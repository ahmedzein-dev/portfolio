// Builds every picture made from the profile photo: the hero circle, the link preview and the app icons.
//
//   node scripts/photo.mjs <photo> [top]
//
// The hero shows a 4:5 portrait cut from the photo: its full width (or as wide as 4:5 allows), from
// `top` px down (default 0): space above the head, the suit showing. The link preview and the icons
// use a square, the photo's full width from 40 px down. Writes, metadata-free and sRGB:
//   public/photo/ahmed-zein-{120,240,360,480}.jpg   the hero portrait, that many px wide (1x to 4x), lightly sharpened
//   public/photo/ahmed-zein-share.jpg               the 1200 px link preview of the home page
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
    .extract({ left: Math.round((meta.width - width) / 2), top: Math.min(top, meta.height - height), width, height })
    .toColourspace('srgb')
    .png()
    .toBuffer();
const heroW = Math.min(meta.width, Math.floor((meta.height * 4) / 5));
const hero = await cut(heroW, Math.round((heroW * 5) / 4), Number(topArg ?? 0));
const inner = Math.min(meta.width, meta.height);
const square = await cut(inner, inner, 40);

const sized = (px, from = square, h = px) => sharp(from).resize(px, h, { kernel: 'lanczos3' });
const jpg = (px, file, sharpen, from, h) =>
  (sharpen ? sized(px, from, h).sharpen({ sigma: 0.6 }) : sized(px, from, h)).jpeg({ quality: 88, mozjpeg: true, chromaSubsampling: '4:4:4' }).toFile(file);
const png = (px, file) => sized(px).png({ compressionLevel: 9, palette: true, quality: 92, effort: 10 }).toFile(file);

for (const px of [120, 240, 360, 480]) await jpg(px, `public/photo/ahmed-zein-${px}.jpg`, true, hero, Math.round((px * 5) / 4));
await jpg(1200, 'public/photo/ahmed-zein-share.jpg', false);
await png(512, 'public/icon-512.png');
await png(192, 'public/icon-192.png');
await png(180, 'public/apple-touch-icon.png');

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
