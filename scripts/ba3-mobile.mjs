// The BA3 card's picture on phones and tablets, where it gets a tall narrow column beside the text: two floating
// windows cut from the dashboard, tilted and overlapping like the phones on the other cards. The chart sits
// behind, the BA3 menu in front.
//
//   node scripts/ba3-mobile.mjs
//
// Writes src/assets/work/ba3_mobile.png (transparent, metadata-free).
import sharp from 'sharp';

const SRC = 'src/assets/work/ba3_control_panel.png';
const OUT = 'src/assets/work/ba3_mobile.png';
const W = 640;
const H = 1240;
const BAR = 30;

// A window: title bar with three dots, the crop under it, rounded corners, a hairline edge.
async function win(crop, width) {
  const scale = width / crop.width;
  const h = Math.round(crop.height * scale) + BAR;
  const shot = await sharp(SRC).extract(crop).resize(width, h - BAR, { kernel: 'lanczos3' }).png().toBuffer();
  const chrome = Buffer.from(`<svg xmlns="http://www.w3.org/2000/svg" width="${width}" height="${h}">
    <rect width="${width}" height="${BAR}" fill="#0f1b30"/>
    <circle cx="18" cy="${BAR / 2}" r="5" fill="#3b4a63"/><circle cx="34" cy="${BAR / 2}" r="5" fill="#3b4a63"/><circle cx="50" cy="${BAR / 2}" r="5" fill="#3b4a63"/>
  </svg>`);
  const mask = Buffer.from(`<svg width="${width}" height="${h}"><rect width="${width}" height="${h}" rx="22" fill="#fff"/></svg>`);
  const edge = Buffer.from(`<svg width="${width}" height="${h}"><rect x="1" y="1" width="${width - 2}" height="${h - 2}" rx="21" fill="none" stroke="#fff" stroke-opacity="0.16" stroke-width="2"/></svg>`);
  return sharp(chrome)
    .composite([{ input: shot, top: BAR, left: 0 }, { input: mask, blend: 'dest-in' }, { input: edge }])
    .png()
    .toBuffer();
}

// Tilt a window and give it a soft shadow, on a transparent square big enough for the rotation.
async function tilted(buf, deg) {
  const m = await sharp(buf).metadata();
  const pad = 70;
  const shadow = await sharp(Buffer.from(`<svg width="${m.width + pad * 2}" height="${m.height + pad * 2}"><rect x="${pad}" y="${pad + 26}" width="${m.width}" height="${m.height}" rx="22" fill="#000" fill-opacity="0.55"/></svg>`))
    .blur(26)
    .png()
    .toBuffer();
  const framed = await sharp(shadow).composite([{ input: buf, left: pad, top: pad }]).png().toBuffer();
  return sharp(framed).rotate(deg, { background: { r: 0, g: 0, b: 0, alpha: 0 } }).png().toBuffer();
}

// Crops in the 2752 × 1984 screenshot.
const chart = await win({ left: 540, top: 330, width: 1170, height: 1480 }, 470);
const menu = await win({ left: 2262, top: 0, width: 490, height: 1560 }, 300);

const back = await tilted(chart, -6);
const front = await tilted(menu, 5);
// Lay out on a larger sheet (a tilted window is wider than the picture), then cut the picture from it.
const M = 200;
const sheet = await sharp({ create: { width: W + M * 2, height: H + M * 2, channels: 4, background: { r: 0, g: 0, b: 0, alpha: 0 } } })
  .composite([
    { input: back, left: M - 22, top: M + 10 },
    { input: front, left: M + 262, top: M + 290 },
  ])
  .png()
  .toBuffer();
await sharp(sheet).extract({ left: M, top: M, width: W, height: H }).png({ compressionLevel: 9 }).toFile(OUT);
console.log(OUT);
