import type { APIRoute } from 'astro';
import { getContent } from '../data/content';
import { localPath } from '../i18n';

// Every page in English and Arabic, each listing its other-language version (hreflang), as Google asks.
export const GET: APIRoute = ({ site }) => {
  const base = site ?? new URL('https://ahmedzein.dev');
  const paths = ['/', ...getContent('en').caseStudies.map((p) => `/work/${p.slug}/`)];
  const abs = (p: string) => new URL(p, base).href;
  const urls = paths
    .flatMap((p) => [p, localPath('ar', p)])
    .map((loc) => {
      const en = loc.replace(/^\/ar(?=\/)/, '');
      const alts = [
        `<xhtml:link rel="alternate" hreflang="en" href="${abs(en)}"/>`,
        `<xhtml:link rel="alternate" hreflang="ar" href="${abs(localPath('ar', en))}"/>`,
        `<xhtml:link rel="alternate" hreflang="x-default" href="${abs(en)}"/>`,
      ].join('');
      return `  <url><loc>${abs(loc)}</loc>${alts}</url>`;
    })
    .join('\n');
  const body = `<?xml version="1.0" encoding="UTF-8"?>\n<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xmlns:xhtml="http://www.w3.org/1999/xhtml">\n${urls}\n</urlset>\n`;
  return new Response(body, { headers: { 'Content-Type': 'application/xml' } });
};
