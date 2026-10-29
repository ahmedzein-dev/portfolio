// The LinkedIn profile cover (1584 × 396), in the portfolio's style: dark, the accent, the headline and
// the proof numbers, with two Taggo screens on the right. The bottom-left stays clear for the profile
// photo, which LinkedIn lays over it. System fonts stand in for the site's web fonts.
//
//   node scripts/linkedin-cover.mjs [out]
//
// Writes ~/LinkedIn/cover/linkedin-cover.png by default.
import sharp from 'sharp';
import { mkdir } from 'node:fs/promises';
import { homedir } from 'node:os';
import { dirname } from 'node:path';

const out = process.argv[2] ?? `${homedir()}/LinkedIn/cover/linkedin-cover.png`;
const [W, H] = [1584, 396];
const SRC = 'src/assets/work/';

// A phone: the screen in a dark bezel with rounded corners, tilted, with a soft shadow.
async function phone(file, w, deg) {
  const h = Math.round(w * 2.165);
  const pad = 7;
  const screen = await sharp(SRC + file)
    .resize(w - pad * 2, h - pad * 2, { fit: 'cover', position: 'top' })
    .composite([{ input: Buffer.from(`<svg width="${w - pad * 2}" height="${h - pad * 2}"><rect width="100%" height="100%" rx="${Math.round(w * 0.11)}" fill="#fff"/></svg>`), blend: 'dest-in' }])
    .png()
    .toBuffer();
  const body = await sharp(Buffer.from(`<svg width="${w}" height="${h}"><rect width="${w}" height="${h}" rx="${Math.round(w * 0.14)}" fill="#0b0d10"/><rect x="1" y="1" width="${w - 2}" height="${h - 2}" rx="${Math.round(w * 0.14) - 1}" fill="none" stroke="#fff" stroke-opacity="0.14" stroke-width="2"/></svg>`))
    .composite([{ input: screen, left: pad, top: pad }])
    .png()
    .toBuffer();
  const m = 60;
  const shadow = Buffer.from(`<svg width="${w + m * 2}" height="${h + m * 2}"><rect x="${m}" y="${m + 22}" width="${w}" height="${h}" rx="${Math.round(w * 0.14)}" fill="#000" fill-opacity="0.6"/></svg>`);
  const framed = await sharp(await sharp(shadow).blur(22).png().toBuffer()).composite([{ input: body, left: m, top: m }]).png().toBuffer();
  return sharp(framed).rotate(deg, { background: { r: 0, g: 0, b: 0, alpha: 0 } }).png().toBuffer();
}

const tx = 470;
const page = Buffer.from(`<svg xmlns="http://www.w3.org/2000/svg" width="${W}" height="${H}">
  <defs>
    <radialGradient id="glow" cx="0.82" cy="0.55" r="0.45"><stop offset="0" stop-color="#d4aa7d" stop-opacity="0.2"/><stop offset="1" stop-color="#d4aa7d" stop-opacity="0"/></radialGradient>
    <linearGradient id="fade" x1="0" y1="0" x2="1" y2="0"><stop offset="0" stop-color="#0b0f15"/><stop offset="1" stop-color="#121925"/></linearGradient>
  </defs>
  <rect width="${W}" height="${H}" fill="url(#fade)"/><rect width="${W}" height="${H}" fill="url(#glow)"/>
  <text x="${tx}" y="104" font-family="Menlo" font-size="19" letter-spacing="3" fill="#d4aa7d">SENIOR MOBILE ENGINEER · FLUTTER · ABU DHABI</text>
  <text x="${tx}" y="178" font-family="Helvetica Neue" font-weight="700" font-size="60" fill="#f2ede5">I build mobile apps</text>
  <text x="${tx}" y="244" font-family="Helvetica Neue" font-weight="700" font-size="60" fill="#f2ede5">that stay live.</text>
  <text x="${tx}" y="300" font-family="Helvetica Neue" font-size="21" fill="#a3a9b5">Real-time tracking · Background execution · iOS Live Activities · Payments</text>
  <text x="${tx}" y="346" font-family="Menlo" font-size="18" fill="#a3a9b5"><tspan fill="#f2ede5">3</tspan> apps live in UAE stores <tspan fill="#d4aa7d">·</tspan> <tspan fill="#f2ede5">3.5M</tspan> AED a month <tspan fill="#d4aa7d">·</tspan> <tspan fill="#f2ede5">3</tspan> packages on pub.dev</text>
  <text x="${W - 40}" y="56" text-anchor="end" font-family="Menlo" font-size="20" fill="#d4aa7d">ahmedzein.dev</text>
</svg>`);

const rider = await phone('taggo_rider_home.png', 158, -7);
const captain = await phone('taggo_captain_pickup.png', 158, 6);
// Laid out on a taller sheet so the phones can run off the bottom edge, then cut to the cover.
const sheet = await sharp({ create: { width: W, height: H + 300, channels: 4, background: { r: 0, g: 0, b: 0, alpha: 0 } } })
  .composite([
    { input: page, left: 0, top: 0 },
    { input: rider, left: 1180, top: 38 },
    { input: captain, left: 1318, top: 78 },
  ])
  .png()
  .toBuffer();
await mkdir(dirname(out), { recursive: true });
await sharp(sheet).extract({ left: 0, top: 0, width: W, height: H }).png({ compressionLevel: 9 }).toFile(out);
console.log(out);
