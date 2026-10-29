// Builds every picture made from the profile photo: the hero circle, the link preview and the app icons.
//
//   node scripts/photo.mjs <photo> [side] [top]
//
// The hero circle frames the photo in a square `side` px wide (default 2100), its top `top` px from the
// photo's top (default -120, so space above the hair), centred across: head and shoulders with the suit
// showing. Where that square is wider or taller than the photo, the photo's edge pixels are carried out
// (the plain background, the jacket at the bottom corners); the circle hides the corners. The link
// preview and the icons show the whole square, so they use a square cut from inside the photo instead
// (its full width, from 40 px down). Writes, metadata-free and sRGB:
//   public/photo/ahmed-zein-{120,240,360,480}.jpg   the hero circle at 1x to 4x, lightly sharpened
//   public/photo/ahmed-zein-share.jpg               the 1200 px link preview of the home page
//   public/icon-{192,512}.png, apple-touch-icon.png  the home-screen and shortcut icons
//   public/favicon.ico                               32 px, a PNG inside an ICO
import sharp from 'sharp';
import { writeFile } from 'node:fs/promises';

const [src, sideArg, topArg] = process.argv.slice(2);
if (!src) throw new Error('usage: node scripts/photo.mjs <photo> [side] [top]');
const meta = await sharp(src).rotate().metadata();

async function frame(side, top) {
  const left = Math.round((meta.width - side) / 2);
  const pad = { left: Math.max(0, -left), right: Math.max(0, left + side - meta.width), top: Math.max(0, -top), bottom: Math.max(0, top + side - meta.height) };
  const extended = await sharp(src).rotate().extend({ ...pad, extendWith: 'copy' }).png().toBuffer();
  return sharp(extended).extract({ left: Math.max(0, left), top: Math.max(0, top), width: side, height: side }).toColourspace('srgb').png().toBuffer();
}
const hero = await frame(Number(sideArg ?? 2100), Number(topArg ?? -120));
const inner = Math.min(meta.width, meta.height);
const square = await frame(inner, Math.min(40, meta.height - inner));

const sized = (px, from = square) => sharp(from).resize(px, px, { kernel: 'lanczos3' });
const jpg = (px, file, sharpen, from) =>
  (sharpen ? sized(px, from).sharpen({ sigma: 0.6 }) : sized(px, from)).jpeg({ quality: 88, mozjpeg: true, chromaSubsampling: '4:4:4' }).toFile(file);
const png = (px, file) => sized(px).png({ compressionLevel: 9, palette: true, quality: 92, effort: 10 }).toFile(file);

for (const px of [120, 240, 360, 480]) await jpg(px, `public/photo/ahmed-zein-${px}.jpg`, true, hero);
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
console.log(`hero and ${inner} px square from ${meta.width} × ${meta.height}`);
