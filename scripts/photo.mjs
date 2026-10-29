// Builds every picture made from the profile photo: the hero circle, the link preview and the app icons.
//
//   node scripts/photo.mjs <photo> [top]
//
// The photo is cut to a square the full width of the photo, starting `top` px from its top (default 40,
// just above the hair), so the face sits in the middle of the circle. Writes, metadata-free and sRGB:
//   public/photo/ahmed-zein-{120,240,360,480}.jpg   the hero circle at 1x to 4x, lightly sharpened
//   public/photo/ahmed-zein-share.jpg               the 1200 px link preview of the home page
//   public/icon-{192,512}.png, apple-touch-icon.png  the home-screen and shortcut icons
//   public/favicon.ico                               32 px, a PNG inside an ICO
import sharp from 'sharp';
import { writeFile } from 'node:fs/promises';

const [src, topArg] = process.argv.slice(2);
if (!src) throw new Error('usage: node scripts/photo.mjs <photo> [top]');
const meta = await sharp(src).metadata();
const side = Math.min(meta.width, meta.height);
const top = Math.min(Number(topArg ?? 40), meta.height - side);
const square = await sharp(src)
  .rotate()
  .extract({ left: Math.round((meta.width - side) / 2), top, width: side, height: side })
  .toColourspace('srgb')
  .png()
  .toBuffer();

const sized = (px) => sharp(square).resize(px, px, { kernel: 'lanczos3' });
const jpg = (px, file, sharpen) =>
  (sharpen ? sized(px).sharpen({ sigma: 0.6 }) : sized(px)).jpeg({ quality: 88, mozjpeg: true, chromaSubsampling: '4:4:4' }).toFile(file);
const png = (px, file) => sized(px).png({ compressionLevel: 9, palette: true, quality: 92, effort: 10 }).toFile(file);

for (const px of [120, 240, 360, 480]) await jpg(px, `public/photo/ahmed-zein-${px}.jpg`, true);
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
console.log(`cut ${side} × ${side} from ${meta.width} × ${meta.height} at top ${top}`);
