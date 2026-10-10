import type { APIRoute } from 'astro';
import { flagships } from '../data/site';

export const GET: APIRoute = ({ site }) => {
  const base = site ?? new URL('https://ahmedzein.dev');
  const paths = ['/', ...flagships.map((p) => `/work/${p.slug}/`)];
  const urls = paths.map((p) => `  <url><loc>${new URL(p, base).href}</loc></url>`).join('\n');
  const body = `<?xml version="1.0" encoding="UTF-8"?>\n<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">\n${urls}\n</urlset>\n`;
  return new Response(body, { headers: { 'Content-Type': 'application/xml' } });
};
