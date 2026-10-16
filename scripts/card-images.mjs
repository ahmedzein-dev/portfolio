// Builds the 4:3 thumbnails of the More projects grid, so every card frames its screens the same way:
// whole screens, never cropped, centred on a dark stage tinted with the app's colour. The same stages,
// at 1200×630, are the link previews (og:image) of the case studies.
//
//   node scripts/card-images.mjs
//
// Writes src/assets/cards/<id>.jpg (1600×1200) and public/share/<slug>.jpg (1200×630), metadata-free.
import sharp from 'sharp';
import { mkdir } from 'node:fs/promises';

let W = 1600;
let H = 1200;
const SRC = 'src/assets/work/';
const OUT = 'src/assets/cards/';
const SHARE = 'public/share/';
/** Project pages, which get a link preview each: card id -> page slug. */
const FLAGSHIPS = { taggo: 'taggo', 'the-events': 'the-events', ba3: 'ba3', gainz: 'gainz-ai', 'amber-drive': 'amber-drive' };

const cards = [
  { id: 'taggo', tint: ['#2e2810', '#100e07'], glow: '#f2d23c', phones: ['taggo_rider_home.png', 'taggo_captain_pickup.png'] },
  { id: 'the-events', tint: ['#33191d', '#12090b'], glow: '#e8837a', phones: ['theevents_home.png', 'theevents_visual_search.png'] },
  { id: 'ba3', tint: ['#13233f', '#080e1a'], glow: '#4a8fe7', phones: ['ba3_ipad_dashboard.png', 'ba3_ipad_invoice.png'], radius: 0.05 },
  { id: 'gainz', still: 'gainz_image.jpg', trim: 40 },
  { id: 'amber-drive', still: 'amber_drive.jpg', trim: 0 },
  { id: 'osta-home', tint: ['#30230c', '#120d05'], glow: '#f2a516', phones: ['osta1.png', 'osta2.png'] },
  { id: 'al-taher', tint: ['#2c2a12', '#100f07'], glow: '#f5c518', phones: ['altaher_home.png', 'altaher_welcome.png'] },
  { id: 'spark-fitness', tint: ['#0d2d2b', '#061312'], glow: '#1fb5aa', phones: ['spark1.png', 'spark2.png'] },
];

const stage = ([top, bottom], glow) =>
  Buffer.from(`<svg xmlns="http://www.w3.org/2000/svg" width="${W}" height="${H}">
    <defs>
      <linearGradient id="g" x1="0" y1="0" x2="0" y2="1"><stop offset="0" stop-color="${top}"/><stop offset="1" stop-color="${bottom}"/></linearGradient>
      <radialGradient id="r" cx="0.5" cy="0.55" r="0.5"><stop offset="0" stop-color="${glow}" stop-opacity="0.28"/><stop offset="1" stop-color="${glow}" stop-opacity="0"/></radialGradient>
    </defs>
    <rect width="100%" height="100%" fill="url(#g)"/><rect width="100%" height="100%" fill="url(#r)"/>
  </svg>`);

// A screen with rounded corners, a hairline edge and a soft shadow, as layers for composite().
async function framed(file, w, h, radius, left, top) {
  const mask = Buffer.from(`<svg width="${w}" height="${h}"><rect width="${w}" height="${h}" rx="${radius}" fill="#fff"/></svg>`);
  const screen = await sharp(SRC + file)
    .resize(w, h, { kernel: 'lanczos3' })
    .composite([{ input: mask, blend: 'dest-in' }])
    .png()
    .toBuffer();
  const edge = Buffer.from(`<svg width="${w}" height="${h}"><rect x="1" y="1" width="${w - 2}" height="${h - 2}" rx="${radius - 1}" fill="none" stroke="#fff" stroke-opacity="0.18" stroke-width="2"/></svg>`);
  const shadow = await sharp(
    Buffer.from(`<svg width="${W}" height="${H}"><rect x="${left}" y="${top + 24}" width="${w}" height="${h}" rx="${radius}" fill="#000" fill-opacity="0.55"/></svg>`),
  )
    .blur(28)
    .png()
    .toBuffer();
  return [
    { input: shadow, left: 0, top: 0 },
    { input: screen, left, top },
    { input: edge, left, top },
  ];
}

// Phones, or tablets (radius: their smaller corner), side by side; wide screens shrink to fit the width.
async function phonesCard(c) {
  const gap = 56;
  const metas = await Promise.all(c.phones.map((f) => sharp(SRC + f).metadata()));
  const aspect = metas.reduce((sum, m) => sum + m.width / m.height, 0);
  const h = Math.round(Math.min(H * 0.9, (W * 0.92 - gap * (metas.length - 1)) / aspect));
  const widths = metas.map((m) => Math.round((h * m.width) / m.height));
  let left = Math.round((W - widths.reduce((a, b) => a + b, 0) - gap * (widths.length - 1)) / 2);
  const top = Math.round((H - h) / 2);
  const layers = [];
  for (const [i, f] of c.phones.entries()) {
    layers.push(...(await framed(f, widths[i], h, Math.round(widths[i] * (c.radius ?? 0.13)), left, top)));
    left += widths[i] + gap;
  }
  return sharp(stage(c.tint, c.glow)).composite(layers);
}

// A ready-made still (a mockup or a film frame): shown whole, its own background carried out to 4:3.
async function stillCard(c) {
  const m = await sharp(SRC + c.still).metadata();
  const t = c.trim;
  const cw = m.width - t * 2;
  const ch = m.height - t * 2;
  const scale = Math.min(W / cw, H / ch);
  const w = Math.round(cw * scale);
  const h = Math.round(ch * scale);
  const img = await sharp(SRC + c.still)
    .extract({ left: t, top: t, width: cw, height: ch })
    .resize(w, h, { kernel: 'lanczos3' })
    .toBuffer();
  const x = Math.floor((W - w) / 2);
  const y = Math.floor((H - h) / 2);
  return sharp(img).extend({ left: x, right: W - w - x, top: y, bottom: H - h - y, extendWith: 'copy' });
}

async function write(c, file) {
  const img = c.phones ? await phonesCard(c) : await stillCard(c);
  // Flatten in a second pass: composite layers resolve before resize/format options apply.
  const flat = await img.png().toBuffer();
  await sharp(flat).sharpen({ sigma: 0.5 }).jpeg({ quality: 88, mozjpeg: true, chromaSubsampling: '4:4:4' }).toFile(file);
  console.log(file);
}

await mkdir(OUT, { recursive: true });
for (const c of cards) await write(c, `${OUT}${c.id}.jpg`);

[W, H] = [1200, 630];
await mkdir(SHARE, { recursive: true });
for (const c of cards.filter((c) => c.id in FLAGSHIPS)) await write(c, `${SHARE}${FLAGSHIPS[c.id]}.jpg`);
