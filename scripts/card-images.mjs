// Builds the 4:3 thumbnails of the More projects grid and the link previews (og:image) of the case studies,
// on a dark stage tinted with the app's colour. The thumbnails show the screens as Selected Work does: in
// dark device bodies, two of them tilted and overlapping, running off the bottom edge. The link previews
// keep whole, flat screens side by side, which read better at 1200×630.
//
//   node scripts/card-images.mjs [id ...]
//
// With ids (taggo, the-events, ...), only those cards are built, so the others keep their bytes and URLs.
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
const PAGES = {
  taggo: 'taggo',
  'the-events': 'the-events',
  ba3: 'ba3',
  gainz: 'gainz-ai',
  'amber-drive': 'amber-drive',
  'osta-home': 'osta-home',
  'al-taher': 'al-taher',
  'spark-fitness': 'spark-fitness',
};

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

// Selected Work's devices (global.css: .phone, .tablet, .v-two): a dark body with rounded corners around
// the screen, filled from the top, and a soft shadow below.
async function device(file, w, h, kind) {
  const pad = Math.round(w * (kind === 'tablet' ? 0.016 : 0.022));
  const outer = Math.round(w * (kind === 'tablet' ? 0.05 : 0.1));
  const inner = Math.round(outer * 0.8);
  const [sw, sh] = [w - pad * 2, h - pad * 2];
  const screen = await sharp(SRC + file)
    .resize(sw, sh, { fit: 'cover', position: 'top', kernel: 'lanczos3' })
    .composite([{ input: Buffer.from(`<svg width="${sw}" height="${sh}"><rect width="${sw}" height="${sh}" rx="${inner}" fill="#fff"/></svg>`), blend: 'dest-in' }])
    .png()
    .toBuffer();
  const body = await sharp(Buffer.from(`<svg width="${w}" height="${h}"><rect width="${w}" height="${h}" rx="${outer}" fill="#0b0d10"/><rect x="1.5" y="1.5" width="${w - 3}" height="${h - 3}" rx="${outer - 1.5}" fill="none" stroke="#fff" stroke-opacity="0.22" stroke-width="3"/></svg>`))
    .composite([{ input: screen, left: pad, top: pad }])
    .png()
    .toBuffer();
  const m = Math.round(w * 0.16);
  const shadow = await sharp(Buffer.from(`<svg width="${w + m * 2}" height="${h + m * 2}"><rect x="${m}" y="${m + Math.round(w * 0.07)}" width="${w}" height="${h}" rx="${outer}" fill="#000" fill-opacity="0.55"/></svg>`))
    .blur(Math.round(w * 0.06))
    .png()
    .toBuffer();
  return { input: await sharp(shadow).composite([{ input: body, left: m, top: m }]).png().toBuffer(), margin: m };
}

// Two devices as on a Selected Work card: phones 9:19.5 tilted apart (-6° and 5°), tablets 3:4 straight and
// stepped. Laid out on a taller sheet so they can run off the bottom, then cut to the thumbnail.
async function mockupCard(c) {
  const tablet = c.radius !== undefined;
  const place = tablet
    ? [{ x: 0.06, y: 0.1, w: 0.5, deg: 0 }, { x: 0.44, y: 0.2, w: 0.5, deg: 0 }]
    : [{ x: 0.16, y: 0.09, w: 0.33, deg: -6 }, { x: 0.51, y: 0.16, w: 0.33, deg: 5 }];
  const layers = [];
  for (const [i, file] of c.phones.entries()) {
    const p = place[i];
    const w = Math.round(W * p.w);
    const h = Math.round(tablet ? (w * 4) / 3 : (w * 19.5) / 9);
    const { input, margin } = await device(file, w, h, tablet ? 'tablet' : 'phone');
    const turned = p.deg ? await sharp(input).rotate(p.deg, { background: { r: 0, g: 0, b: 0, alpha: 0 } }).png().toBuffer() : input;
    const t = await sharp(turned).metadata();
    // Keep the device's centre where an untilted one would have it.
    const cx = W * p.x + w / 2;
    const cy = H * p.y + h / 2;
    layers.push({ input: turned, left: Math.round(cx - t.width / 2), top: Math.round(cy - t.height / 2), _m: margin });
  }
  const pad = Math.round(W * 0.3);
  const sheet = await sharp({ create: { width: W + pad * 2, height: H * 2 + pad * 2, channels: 4, background: { r: 0, g: 0, b: 0, alpha: 0 } } })
    .composite([
      { input: await sharp(stage(c.tint, c.glow)).png().toBuffer(), left: pad, top: pad },
      ...layers.map((l) => ({ input: l.input, left: l.left + pad, top: l.top + pad })),
    ])
    .png()
    .toBuffer();
  return sharp(await sharp(sheet).extract({ left: pad, top: pad, width: W, height: H }).png().toBuffer());
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

async function write(c, file, mockup = false) {
  const img = c.phones ? await (mockup ? mockupCard(c) : phonesCard(c)) : await stillCard(c);
  // Flatten in a second pass: composite layers resolve before resize/format options apply.
  const flat = await img.png().toBuffer();
  await sharp(flat).sharpen({ sigma: 0.5 }).jpeg({ quality: 88, mozjpeg: true, chromaSubsampling: '4:4:4' }).toFile(file);
  console.log(file);
}

const only = process.argv.slice(2);
const chosen = only.length ? cards.filter((c) => only.includes(c.id)) : cards;
if (only.length && chosen.length !== only.length) throw new Error(`unknown card id in: ${only.join(', ')}`);

await mkdir(OUT, { recursive: true });
for (const c of chosen) await write(c, `${OUT}${c.id}.jpg`, true);

[W, H] = [1200, 630];
await mkdir(SHARE, { recursive: true });
for (const c of chosen.filter((c) => c.id in PAGES)) await write(c, `${SHARE}${PAGES[c.id]}.jpg`);
