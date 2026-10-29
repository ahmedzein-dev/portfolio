// Builds every picture made from the profile photo: the hero circle, the link preview and the app icons.
//
//   node scripts/photo.mjs <photo> [top]
//
// The hero shows a 4:5 portrait cut from the photo: its full width (or as wide as 4:5 allows), from
// `top` px down (default 0): space above the head, the suit showing. The link preview and the icons
// use a tighter square around the head (see `square` below). Writes, metadata-free and sRGB:
//   public/photo/ahmed-zein-{120,240,360,480}.jpg   the hero portrait, that many px wide (1x to 4x), lightly sharpened
//   public/photo/ahmed-zein-share.jpg               a 1200 px square (the person in the page's structured data)
//   public/share/home.jpg                           the home page's 1200 × 630 link preview: photo, name, title
//   public/icon-{192,512}.png, apple-touch-icon.png  the home-screen and shortcut icons
//   public/favicon.ico                               32 px, a PNG inside an ICO
import sharp from 'sharp';
import { writeFile } from 'node:fs/promises';

const [src, topArg] = process.argv.slice(2);
if (!src) throw new Error('usage: node scripts/photo.mjs <photo> [top]');
const meta = await sharp(src).rotate().metadata();
const cut = (width, height, top) =>
  sharp(src)
    .rotate()
    .flatten({ background: '#ffffff' })
    // Lifts the near-white background (253-254) to pure white, hiding a faint seam an edit left in it;
    // about 1% brighter overall, which faces and fabric do not show.
    .linear(1.012, 0)
    .extract({ left: Math.round((meta.width - width) / 2), top: Math.min(top, meta.height - height), width, height })
    .toColourspace('srgb')
    .png()
    .toBuffer();
const heroW = Math.min(meta.width, Math.floor((meta.height * 4) / 5));
const hero = await cut(heroW, Math.round((heroW * 5) / 4), Number(topArg ?? 0));
// Icons are tiny, so their square is tighter: 81% of the width, from 9.5% of the height (head and collar
// in this photo's framing; adjust if a new photo is framed differently).
const inner = Math.round(Math.min(meta.width, meta.height) * 0.81);
const square = await cut(inner, inner, Math.round(meta.height * 0.095));

const sized = (px, from = square, h = px) => sharp(from).resize(px, h, { kernel: 'lanczos3' });
// The hero is small, so it gets a firmer unsharp mask and a higher quality, which keep hair, brows
// and eyes crisp without halos.
const jpg = (px, file, sharpen, from, h) =>
  (sharpen ? sized(px, from, h).sharpen({ sigma: 0.7, m1: 1.4, m2: 2.4, x1: 2 }) : sized(px, from, h))
    .jpeg({ quality: sharpen ? 94 : 88, mozjpeg: true, chromaSubsampling: '4:4:4' })
    .toFile(file);
const png = (px, file) => sized(px).png({ compressionLevel: 9, palette: true, quality: 92, effort: 10 }).toFile(file);

for (const px of [120, 240, 360, 480]) await jpg(px, `public/photo/ahmed-zein-${px}.jpg`, true, hero, Math.round((px * 5) / 4));
await jpg(1200, 'public/photo/ahmed-zein-share.jpg', false);
await png(512, 'public/icon-512.png');
await png(192, 'public/icon-192.png');
await png(180, 'public/apple-touch-icon.png');

// The home page's link preview, in the site's dark style: the portrait in its accent ring on the left,
// name, title and headline on the right. Link cards (LinkedIn's among them) are wide, so a square would
// be cropped to a strip through the face. System fonts stand in for the site's web fonts.
{
  const [W, H, pw, ph, px, py] = [1200, 630, 360, 450, 96, 90];
  const portrait = await sharp(hero)
    .resize(pw, ph, { kernel: 'lanczos3' })
    .sharpen({ sigma: 0.7, m1: 1.4, m2: 2.4, x1: 2 })
    .composite([{ input: Buffer.from(`<svg width="${pw}" height="${ph}"><rect width="${pw}" height="${ph}" rx="30" fill="#fff"/></svg>`), blend: 'dest-in' }])
    .png()
    .toBuffer();
  const tx = px + pw + 70;
  const page = Buffer.from(`<svg xmlns="http://www.w3.org/2000/svg" width="${W}" height="${H}">
    <defs>
      <radialGradient id="glow" cx="0.22" cy="0.5" r="0.6"><stop offset="0" stop-color="#d4aa7d" stop-opacity="0.16"/><stop offset="1" stop-color="#d4aa7d" stop-opacity="0"/></radialGradient>
      <linearGradient id="ring" x1="0" y1="0" x2="1" y2="1"><stop offset="0" stop-color="#d4aa7d"/><stop offset="0.55" stop-color="#d4aa7d" stop-opacity="0.15"/><stop offset="1" stop-color="#d4aa7d"/></linearGradient>
    </defs>
    <rect width="${W}" height="${H}" fill="#0e1219"/><rect width="${W}" height="${H}" fill="url(#glow)"/>
    <rect x="${px - 7}" y="${py - 7}" width="${pw + 14}" height="${ph + 14}" rx="36" fill="url(#ring)"/>
    <rect x="${px - 3}" y="${py - 3}" width="${pw + 6}" height="${ph + 6}" rx="32" fill="#0e1219"/>
    <text x="${tx}" y="236" font-family="Helvetica Neue" font-weight="700" font-size="66" fill="#f2ede5">Ahmed Zein</text>
    <text x="${tx}" y="286" font-family="Menlo" font-size="20" letter-spacing="2" fill="#a3a9b5">SENIOR MOBILE ENGINEER · ABU DHABI</text>
    <text x="${tx}" y="372" font-family="Helvetica Neue" font-weight="700" font-size="38" fill="#f2ede5">I build mobile apps</text>
    <text x="${tx}" y="420" font-family="Helvetica Neue" font-weight="700" font-size="38" fill="#f2ede5">that stay live.</text>
    <text x="${tx}" y="500" font-family="Menlo" font-size="22" fill="#d4aa7d">ahmedzein.dev</text>
  </svg>`);
  const card = await sharp(page).composite([{ input: portrait, left: px, top: py }]).png().toBuffer();
  await sharp(card).jpeg({ quality: 90, mozjpeg: true, chromaSubsampling: '4:4:4' }).toFile('public/share/home.jpg');
}

// An ICO holding one 32 × 32 PNG: a 6-byte header, one 16-byte entry, then the PNG.
const ico32 = await sized(32).png().toBuffer();
const head = Buffer.alloc(22);
head.writeUInt16LE(0, 0);
head.writeUInt16LE(1, 2);
head.writeUInt16LE(1, 4);
head.writeUInt8(32, 6);
head.writeUInt8(32, 7);
head.writeUInt16LE(1, 10);
head.writeUInt16LE(32, 12);
head.writeUInt32LE(ico32.length, 14);
head.writeUInt32LE(22, 18);
await writeFile('public/favicon.ico', Buffer.concat([head, ico32]));
console.log(`hero ${heroW} × ${Math.round((heroW * 5) / 4)} and square ${inner} from ${meta.width} × ${meta.height}`);
