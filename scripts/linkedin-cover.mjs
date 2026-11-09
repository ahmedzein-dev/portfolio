// The LinkedIn profile cover (1584 × 396), in the portfolio's style: dark, the accent, the headline and
// the proof numbers, with two Taggo screens on the right. The bottom-left stays clear for the profile
// photo, which LinkedIn lays over it. System fonts stand in for the site's web fonts.
//
//   node scripts/linkedin-cover.mjs [out]
//
// Writes ~/LinkedIn/cover/linkedin-cover.png (3168 × 792) by default.
import sharp from 'sharp';
import { mkdir } from 'node:fs/promises';
import { homedir } from 'node:os';
import { dirname } from 'node:path';

const out = process.argv[2] ?? `${homedir()}/LinkedIn/cover/linkedin-cover.png`;
// Laid out in LinkedIn's 1584 × 396 and rendered at twice that (3168 × 792): LinkedIn shows the cover at about
// half size and recompresses it, so a 1x image comes out soft; from 2x the type stays sharp.
const K = 2;
const [W, H] = [1584, 396];
const SRC = 'src/assets/work/';

// A phone: the screen in a dark bezel with rounded corners, tilted, with a soft shadow. In output pixels.
async function phone(file, w, deg) {
  const h = Math.round(w * 2.165);
  const pad = 7 * K;
  const screen = await sharp(SRC + file)
    .resize(w - pad * 2, h - pad * 2, { fit: 'cover', position: 'top', kernel: 'lanczos3' })
    .composite([{ input: Buffer.from(`<svg width="${w - pad * 2}" height="${h - pad * 2}"><rect width="100%" height="100%" rx="${Math.round(w * 0.11)}" fill="#fff"/></svg>`), blend: 'dest-in' }])
    .png()
    .toBuffer();
  const body = await sharp(Buffer.from(`<svg width="${w}" height="${h}"><rect width="${w}" height="${h}" rx="${Math.round(w * 0.14)}" fill="#0b0d10"/><rect x="${K}" y="${K}" width="${w - 2 * K}" height="${h - 2 * K}" rx="${Math.round(w * 0.14) - K}" fill="none" stroke="#fff" stroke-opacity="0.14" stroke-width="${2 * K}"/></svg>`))
    .composite([{ input: screen, left: pad, top: pad }])
    .png()
    .toBuffer();
  const m = 60 * K;
  const shadow = Buffer.from(`<svg width="${w + m * 2}" height="${h + m * 2}"><rect x="${m}" y="${m + 22 * K}" width="${w}" height="${h}" rx="${Math.round(w * 0.14)}" fill="#000" fill-opacity="0.6"/></svg>`);
  const framed = await sharp(await sharp(shadow).blur(22 * K).png().toBuffer()).composite([{ input: body, left: m, top: m }]).png().toBuffer();
  return sharp(framed).rotate(deg, { background: { r: 0, g: 0, b: 0, alpha: 0 } }).png().toBuffer();
}

// The site's address sits above the title: top right, LinkedIn puts its edit button over it.
const tx = 470;
const page = Buffer.from(`<svg xmlns="http://www.w3.org/2000/svg" width="${W * K}" height="${H * K}" viewBox="0 0 ${W} ${H}">
  <defs>
    <radialGradient id="glow" cx="0.82" cy="0.55" r="0.45"><stop offset="0" stop-color="#d4aa7d" stop-opacity="0.2"/><stop offset="1" stop-color="#d4aa7d" stop-opacity="0"/></radialGradient>
    <linearGradient id="fade" x1="0" y1="0" x2="1" y2="0"><stop offset="0" stop-color="#0b0f15"/><stop offset="1" stop-color="#121925"/></linearGradient>
  </defs>
  <rect width="${W}" height="${H}" fill="url(#fade)"/><rect width="${W}" height="${H}" fill="url(#glow)"/>
  <text x="${tx}" y="62" font-family="Menlo" font-size="19" fill="#d4aa7d">ahmedzein.dev</text>
  <text x="${tx}" y="106" font-family="Menlo" font-weight="700" font-size="18" letter-spacing="1.5" fill="#d4aa7d">SENIOR SOFTWARE ENGINEER · FLUTTER (iOS, ANDROID &amp; DESKTOP)</text>
  <text x="${tx}" y="180" font-family="Helvetica Neue" font-weight="700" font-size="60" fill="#f2ede5">I build mobile apps</text>
  <text x="${tx}" y="246" font-family="Helvetica Neue" font-weight="700" font-size="60" fill="#f2ede5">that stay live.</text>
  <text x="${tx}" y="302" font-family="Helvetica Neue" font-weight="500" font-size="21" fill="#b8bdc8">Real-time tracking · Background execution · iOS Live Activities · Payments</text>
  <text x="${tx}" y="348" font-family="Menlo" font-size="20" fill="#b8bdc8"><tspan fill="#f2ede5" font-weight="700">3</tspan> apps live in UAE stores <tspan fill="#d4aa7d">·</tspan> <tspan fill="#f2ede5" font-weight="700">3</tspan> open-source packages on pub.dev</text>
</svg>`);

const rider = await phone('taggo_rider_home.png', 158 * K, -7);
const captain = await phone('taggo_captain_pickup.png', 158 * K, 6);
// Laid out on a taller sheet so the phones can run off the bottom edge, then cut to the cover.
const sheet = await sharp({ create: { width: W * K, height: (H + 300) * K, channels: 4, background: { r: 0, g: 0, b: 0, alpha: 0 } } })
  .composite([
    { input: await sharp(page).png().toBuffer(), left: 0, top: 0 },
    { input: rider, left: 1180 * K, top: 38 * K },
    { input: captain, left: 1318 * K, top: 78 * K },
  ])
  .png()
  .toBuffer();
await mkdir(dirname(out), { recursive: true });
await sharp(sheet).extract({ left: 0, top: 0, width: W * K, height: H * K }).png({ compressionLevel: 9 }).toFile(out);
console.log(out);
