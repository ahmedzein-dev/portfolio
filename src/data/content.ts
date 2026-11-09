// The site's content in one language: the English data (site.ts) with the Arabic text (ar.ts) laid over
// it for /ar/, and every link inside the site pointed at pages in the same language.
import type { ImageMetadata } from 'astro';
import * as en from './site';
import { ar } from './ar';
import { localPath, ui, type Lang } from '../i18n';

/**
 * Lays `over` onto `base`: objects key by key, lists of objects position by position, and anything else
 * (text, a list of tags) replaced whole. What `over` leaves out keeps the English value, so images,
 * links and numbers to count come through untouched.
 */
function merge<T>(base: T, over: unknown): T {
  if (over === undefined) return base;
  if (Array.isArray(base)) {
    if (!Array.isArray(over)) return base;
    if (base.some((x) => typeof x !== 'object' || x === null)) return over as T;
    return base.map((b, i) => merge(b, over[i])) as T;
  }
  if (base && typeof base === 'object' && over && typeof over === 'object') {
    const out: Record<string, unknown> = { ...(base as Record<string, unknown>) };
    for (const [k, v] of Object.entries(over)) out[k] = merge(out[k], v);
    return out as T;
  }
  return over as T;
}

/** A case study page at /work/<slug>/ (or /ar/work/<slug>/), in the order Next case study walks through them. */
export type CaseStudy = Pick<
  en.Flagship,
  'slug' | 'name' | 'headline' | 'summary' | 'period' | 'platforms' | 'shots' | 'caption' | 'constraint' | 'highlights' | 'numbers' | 'links' | 'film'
> & { role?: string; back: { href: string; label: string } };

/** A tile in More projects. */
export type ProjectCard = { slug: string; name: string; year: string; platforms: string; summary: string; tags: en.Kind[]; thumb: ImageMetadata; featured: boolean };

// Newest first: by the year a project ended ("now" counts as latest), then by the year it began. Read from
// the English years, so both languages list the projects in the same order.
const span = (year: string) => {
  const [from, to = from] = year.split(' to ');
  return { from: Number(from), to: to === 'now' ? Infinity : Number(to) };
};
const newestFirst = (a: string, b: string) => span(b).to - span(a).to || span(b).from - span(a).from;
/**
 * Arabic text runs right to left, but two Latin words with only a full stop between them ("… Socket.IO.
 * Taggo Captain: …") join into one left-to-right run, so the sentence break lands inside it. A right-to-left
 * mark after that full stop keeps the sentences apart.
 */
function rtlBreaks<T>(value: T): T {
  if (typeof value === 'string') return value.replace(/\. (?=[A-Za-z])/g, '.\u200F ') as T;
  if (Array.isArray(value)) return value.map(rtlBreaks) as T;
  if (value && typeof value === 'object') return Object.fromEntries(Object.entries(value).map(([k, v]) => [k, rtlBreaks(v)])) as T;
  return value;
}
const arText = rtlBreaks(ar);

const enYear = new Map<string, string>([...en.flagships.map((p) => [p.slug, p.card.year] as const), ...en.moreWork.map((p) => [p.id, p.year] as const)]);

export function getContent(lang: Lang) {
  const o = lang === 'ar' ? arText : undefined;
  const t = ui[lang];
  const link = (path: string) => localPath(lang, path);

  const profile = merge(en.profile, o?.profile);
  const proof = merge(en.proof, o?.proof).map((p) => ({ ...p, href: link(p.href) }));
  const flagships = en.flagships.map((p) => merge(p, o?.flagships[p.slug as keyof typeof ar.flagships]));
  const moreWork = en.moreWork.map((p) => merge(p, o?.moreWork[p.id as keyof typeof ar.moreWork]));

  const caseStudies: CaseStudy[] = [
    ...flagships.map((p) => ({ ...p, back: { href: link('/#work'), label: t.case.back.work } })),
    ...moreWork.map((p) => ({
      slug: p.id,
      name: p.name,
      headline: p.headline,
      summary: p.description,
      role: p.role,
      period: p.year,
      platforms: p.platforms,
      shots: p.shots,
      highlights: p.highlights,
      links: p.links,
      film: p.film,
      back: { href: link('/#more-work'), label: t.case.back.more },
    })),
  ];

  // Every project, newest first, each tile opening its case study.
  const projectCards: ProjectCard[] = [
    ...flagships.map((p) => ({ slug: p.slug, name: p.name, year: p.card.year, platforms: p.card.platforms, summary: p.card.summary, tags: p.card.kinds, thumb: p.card.image, featured: true })),
    ...moreWork.map((p) => ({ slug: p.id, name: p.name, year: p.year, platforms: p.platforms, summary: p.summary, tags: p.tags, thumb: p.thumb, featured: false })),
  ].sort((a, b) => newestFirst(enYear.get(a.slug) ?? '', enYear.get(b.slug) ?? ''));

  return {
    lang,
    t,
    link,
    profile,
    proof,
    flagships,
    moreWork,
    caseStudies,
    projectCards,
    experience: merge(en.experience, o?.experience),
    education: o?.education ?? en.education,
    capabilities: merge(en.capabilities, o?.capabilities),
    capabilityTiles: merge(en.capabilityTiles, o?.capabilityTiles),
    packages: merge(en.packages, o?.packages),
  };
}

export type Content = ReturnType<typeof getContent>;
