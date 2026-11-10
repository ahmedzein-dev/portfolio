// The site in English (/) and Arabic (/ar/): the language of a page, links within a language, and the
// interface text. The content itself (projects, experience) is in src/data/site.ts and src/data/ar.ts.

export type Lang = 'en' | 'ar';

/** The language of the page at this URL: /ar and everything under it is Arabic. */
export const langOf = (url: URL): Lang => (url.pathname === '/ar' || url.pathname.startsWith('/ar/') ? 'ar' : 'en');

/** A site path in a language: /work/taggo/ becomes /ar/work/taggo/. Hashes and full URLs pass through. */
export function localPath(lang: Lang, path: string): string {
  return lang === 'en' || !path.startsWith('/') ? path : `/ar${path}`;
}

/** The same page in the other language. */
export function otherPath(url: URL): { lang: Lang; path: string } {
  const p = url.pathname;
  return langOf(url) === 'ar' ? { lang: 'en', path: p.replace(/^\/ar(?=\/|$)/, '') || '/' } : { lang: 'ar', path: localPath('ar', p) };
}

const en = {
  dir: 'ltr',
  /** Joins a role and its company. */
  comma: ', ',
  skip: 'Skip to content',
  home: (name: string) => `${name}, home`,
  nav: { label: 'Main', work: 'Work', openSource: 'Open source', experience: 'Experience', contact: 'Contact' },
  /** The link to the page in the other language, written in that language. */
  switchTo: { label: 'عربي', short: 'ع', title: 'اقرأ الموقع بالعربية', lang: 'ar' },
  theme: 'Change theme',
  sectionsNav: 'Sections',
  rail: 'Route through the page',
  toTop: 'Back to top',
  hero: { seeWork: 'See the work', cv: 'Download CV', numbers: 'In numbers' },
  sections: {
    work: { label: 'Selected work', title: 'Apps people use every day' },
    openSource: { label: 'Open source', title: 'Three Flutter packages' },
    more: { label: 'More projects', title: 'A selection of apps I’ve shipped' },
    experience: { label: 'Experience', title: 'Five stops so far' },
    capabilities: { label: 'Capabilities', title: 'Skills, with proof attached', lede: 'Pick a capability to see which projects prove it.' },
    contact: { label: 'Contact', title: 'Have a mobile app that needs to stay live?' },
    about: 'Experience and capabilities',
  },
  work: { cta: 'Read the case study', swipe: 'Selected work' },
  more: { filter: 'Filter projects', all: 'All', mobile: 'Mobile', web: 'Web and desktop', open: 'Case study →', showAll: (n: number) => `Show all ${n}` },
  pkg: {
    swipe: 'Packages',
    source: (name: string) => `${name} source on GitHub`,
    sourceTitle: 'Source on GitHub',
    points: 'Points',
    likes: 'Likes',
    downloads: 'Downloads',
    per30: '/ 30 days',
    version: 'Version',
    captured: '✓ Captured',
    dfw: 'The draggable_floating_window example app: notes, tasks and a calculator in windows being dragged, resized, stacked and minimized',
  },
  contact: {
    fastest: 'Email or WhatsApp is the fastest way to reach me.',
    copy: 'Copy email',
    copied: 'Email copied',
    others: 'Other ways to reach me',
    phone: 'Phone',
    whatsapp: 'WhatsApp',
    email: 'Email',
    linkedin: 'LinkedIn',
    github: 'GitHub',
    pubdev: 'pub.dev',
  },
  footer: 'Built with Astro. Fonts: Hubot Sans, Mona Sans and Martian Mono (SIL OFL).',
  case: {
    role: 'Role',
    period: 'Period',
    platforms: 'Platforms',
    constraint: 'The constraint',
    film: 'Product film',
    screens: 'Screens',
    built: 'What I built',
    engineering: 'The engineering',
    results: 'Results',
    next: 'Next case study',
    nextArrow: '→',
    backArrow: '←',
    getApp: 'Get the app',
    back: { work: 'Selected work', more: 'More projects' },
  },
};

export type Ui = typeof en;

const ar: Ui = {
  dir: 'rtl',
  comma: '، ',
  skip: 'انتقل إلى المحتوى',
  home: (name) => `${name}، الصفحة الرئيسية`,
  nav: { label: 'القائمة الرئيسية', work: 'الأعمال', openSource: 'مفتوح المصدر', experience: 'الخبرة', contact: 'تواصل' },
  switchTo: { label: 'English', short: 'EN', title: 'Read the site in English', lang: 'en' },
  theme: 'تغيير المظهر',
  sectionsNav: 'الأقسام',
  rail: 'مسار الصفحة',
  toTop: 'العودة إلى الأعلى',
  hero: { seeWork: 'شاهد الأعمال', cv: 'تحميل السيرة الذاتية', numbers: 'بالأرقام' },
  sections: {
    work: { label: 'أعمال مختارة', title: 'تطبيقات يستخدمها الناس كل يوم' },
    openSource: { label: 'مفتوح المصدر', title: 'ثلاث حزم Flutter' },
    more: { label: 'مشاريع أخرى', title: 'مختارات من تطبيقات أطلقتُها' },
    experience: { label: 'الخبرة', title: 'خمس محطات حتى الآن' },
    capabilities: { label: 'المهارات', title: 'مهارات، ومعها الدليل', lede: 'اختر مهارة لترى المشاريع التي تثبتها.' },
    contact: { label: 'تواصل', title: 'تحتاج تطبيق جوّال يعمل بلا توقف؟' },
    about: 'الخبرة والمهارات',
  },
  work: { cta: 'اقرأ دراسة الحالة', swipe: 'أعمال مختارة' },
  more: { filter: 'تصفية المشاريع', all: 'الكل', mobile: 'جوّال', web: 'ويب وسطح المكتب', open: 'دراسة الحالة ←', showAll: (n) => `عرض الكل (${n})` },
  pkg: {
    swipe: 'الحزم',
    source: (name) => `الكود المصدري لـ ${name} على GitHub`,
    sourceTitle: 'الكود المصدري على GitHub',
    points: 'النقاط',
    likes: 'الإعجابات',
    downloads: 'التنزيلات',
    per30: 'خلال 30 يوماً',
    version: 'الإصدار',
    captured: '✓ تم الالتقاط',
    dfw: 'تطبيق المثال لحزمة draggable_floating_window: ملاحظات ومهام وآلة حاسبة في نوافذ تُسحب ويتغير حجمها وتُرتَّب وتُصغَّر',
  },
  contact: {
    fastest: 'البريد الإلكتروني أو واتساب أسرع طريقة للتواصل معي.',
    copy: 'نسخ البريد',
    copied: 'تم نسخ البريد',
    others: 'طرق أخرى للتواصل',
    phone: 'الهاتف',
    whatsapp: 'واتساب',
    email: 'البريد',
    linkedin: 'لينكدإن',
    github: 'GitHub',
    pubdev: 'pub.dev',
  },
  footer: 'صُمّم بـ Astro. الخطوط: Hubot Sans وMona Sans وMartian Mono وNoto Kufi Arabic وIBM Plex Sans Arabic (SIL OFL).',
  case: {
    role: 'الدور',
    period: 'الفترة',
    platforms: 'المنصات',
    constraint: 'التحدي',
    film: 'فيلم تعريفي',
    screens: 'الشاشات',
    built: 'ما بنيته',
    engineering: 'الجانب الهندسي',
    results: 'النتائج',
    next: 'دراسة الحالة التالية',
    nextArrow: '←',
    backArrow: '→',
    getApp: 'حمّل التطبيق',
    back: { work: 'أعمال مختارة', more: 'مشاريع أخرى' },
  },
};

export const ui: Record<Lang, Ui> = { en, ar };
