// Small progressive enhancements. Every section is readable without this script.

const $ = <T extends Element = HTMLElement>(s: string, r: ParentNode = document) => r.querySelector<T>(s);
const $$ = <T extends Element = HTMLElement>(s: string, r: ParentNode = document) => Array.from(r.querySelectorAll<T>(s));
const reduceMotion = window.matchMedia('(prefers-reduced-motion: reduce)');
const reduced = () => reduceMotion.matches;

/* ---------- island: where you are, contents, confirmations ---------- */
const island = $('#island');
const islandBtn = $<HTMLButtonElement>('#island-btn');
const islandPanel = $('#island-panel');
const islandNow = $('#island-now');
const islandRing = $<SVGCircleElement>('#island-ring');
const islandToast = $('#island-toast');
const liveRegion = $('#live-region');
const defaultIslandText = islandNow?.textContent ?? '';

function setIsland(open: boolean) {
  if (!island || !islandBtn || !islandPanel) return;
  island.dataset.open = String(open);
  islandBtn.setAttribute('aria-expanded', String(open));
  islandPanel.hidden = !open;
}
islandBtn?.addEventListener('click', (e) => {
  e.stopPropagation();
  island?.classList.remove('toasting');
  if (!islandPanel || islandPanel.querySelectorAll('a').length === 0) return;
  setIsland(island?.dataset.open !== 'true');
});
islandPanel?.addEventListener('click', (e) => {
  if ((e.target as Element).closest('a')) setIsland(false);
});
document.addEventListener('click', (e) => {
  if (island?.dataset.open === 'true' && !island.contains(e.target as Node)) setIsland(false);
});

let toastTimer = 0;
export function toast(message: string, kind: 'ok' | 'info' = 'ok') {
  if (!island || !islandToast) return;
  setIsland(false);
  islandToast.textContent = message;
  if (liveRegion) liveRegion.textContent = message;
  island.classList.remove('toasting');
  island.classList.toggle('info', kind === 'info');
  void island.offsetWidth;
  island.classList.add('toasting');
  window.clearTimeout(toastTimer);
  toastTimer = window.setTimeout(() => island.classList.remove('toasting'), 2300);
}

/* ---------- copy buttons ---------- */
function selectText(el: Element) {
  const range = document.createRange();
  range.selectNodeContents(el);
  const sel = window.getSelection();
  sel?.removeAllRanges();
  sel?.addRange(range);
}
document.addEventListener('click', (e) => {
  const btn = (e.target as Element).closest<HTMLElement>('[data-copy]');
  if (!btn) return;
  const text = btn.dataset.copy ?? '';
  const message = btn.dataset.copyMsg ?? 'Copied';
  const target = btn.dataset.copyTarget ? $(btn.dataset.copyTarget) : null;
  const fail = () => {
    if (target) {
      selectText(target);
      toast('Selected. Press Ctrl+C or ⌘C to copy', 'info');
    } else toast(text, 'info');
  };
  try {
    if (navigator.clipboard?.writeText) navigator.clipboard.writeText(text).then(() => toast(message), fail);
    else fail();
  } catch {
    fail();
  }
});

/* ---------- theme toggle: system → light → dark ---------- */
const themeBtn = $<HTMLButtonElement>('#theme-btn');
function applyThemeLabel() {
  if (!themeBtn) return;
  const t = document.documentElement.dataset.theme ?? 'system';
  themeBtn.dataset.mode = t;
  themeBtn.setAttribute('aria-label', `Theme: ${t}. Change theme`);
  themeBtn.title = `Theme: ${t}`;
}
themeBtn?.addEventListener('click', () => {
  const order = ['system', 'light', 'dark'];
  const current = document.documentElement.dataset.theme ?? 'system';
  const next = order[(order.indexOf(current) + 1) % order.length];
  if (next === 'system') delete document.documentElement.dataset.theme;
  else document.documentElement.dataset.theme = next;
  try {
    if (next === 'system') localStorage.removeItem('theme');
    else localStorage.setItem('theme', next);
  } catch {}
  applyThemeLabel();
  toast(next === 'system' ? 'Theme follows your system' : `${next[0].toUpperCase()}${next.slice(1)} theme`);
});
applyThemeLabel();

/* ---------- status pill in the hero ---------- */
const statusBtn = $<HTMLButtonElement>('#status-btn');
const statusPanel = $('#status-panel');
function setStatus(open: boolean) {
  if (!statusBtn || !statusPanel) return;
  statusBtn.setAttribute('aria-expanded', String(open));
  statusPanel.hidden = !open;
}
statusBtn?.addEventListener('click', (e) => {
  e.stopPropagation();
  setStatus(statusBtn.getAttribute('aria-expanded') !== 'true');
});
document.addEventListener('click', (e) => {
  if (statusPanel && !statusPanel.hidden && !statusPanel.contains(e.target as Node)) setStatus(false);
});

/* ---------- section tracking, route rail and stacking cards ---------- */
const sections = $$('[data-section]');
const tocLinks = $$<HTMLAnchorElement>('#island-panel a');
const rail = $('#rail');
const railFill = $('#rail-fill');
const railPuck = $('#rail-puck');
const railQuery = window.matchMedia('(min-width: 1320px)');
const stops = rail
  ? sections.map((s) => {
      const b = document.createElement('button');
      b.type = 'button';
      b.className = 'rail-stop';
      const name = `${s.dataset.num ? `${s.dataset.num} · ` : ''}${s.dataset.section}`;
      b.setAttribute('aria-label', name);
      const tip = document.createElement('span');
      tip.className = 'rail-tip';
      tip.textContent = name;
      b.appendChild(tip);
      b.addEventListener('click', () => s.scrollIntoView({ behavior: reduced() ? 'auto' : 'smooth' }));
      rail.appendChild(b);
      return b;
    })
  : [];
let tops: number[] = [];
let stopY: number[] = [];
let current = -1;

const cards = $$('.scard');
const stackQuery = window.matchMedia('(min-width: 900px) and (min-height: 680px)');
let stackOn = false;
let cardTop: number[] = [];
let cardHeight: number[] = [];

function measure() {
  const y = window.scrollY;
  tops = sections.map((s) => s.getBoundingClientRect().top + y);
  const h = rail?.clientHeight ?? 1;
  stopY = sections.map((_, i) => (sections.length > 1 ? (i * h) / (sections.length - 1) : 0));
  stops.forEach((b, i) => (b.style.top = `${stopY[i]}px`));
  stackOn = stackQuery.matches && !reduced();
  cards.forEach((c, i) => {
    cardTop[i] = 84 + i * 18;
    cardHeight[i] = c.offsetHeight;
    if (!stackOn) {
      c.style.removeProperty('--s');
      c.style.removeProperty('--dim');
    }
  });
}

function updateStack() {
  if (!stackOn) return;
  for (let i = 0; i < cards.length - 1; i++) {
    const nextTop = cards[i + 1].getBoundingClientRect().top;
    const p = Math.min(1, Math.max(0, (cardTop[i] + cardHeight[i] - nextTop) / Math.max(1, cardHeight[i] - 18)));
    cards[i].style.setProperty('--s', (1 - 0.05 * p).toFixed(4));
    cards[i].style.setProperty('--dim', (0.3 * p).toFixed(3));
  }
}

let ticking = false;
function frame() {
  ticking = false;
  const y = window.scrollY;
  const vh = window.innerHeight;
  const line = y + vh * 0.35;
  let idx = -1;
  for (let i = 0; i < tops.length; i++) if (tops[i] <= line) idx = i;
  const max = document.documentElement.scrollHeight - vh;
  const progress = max > 0 ? Math.min(1, Math.max(0, y / max)) : 0;
  if (progress > 0.995 && tops.length) idx = tops.length - 1;
  if (idx !== current) {
    current = idx;
    const s = idx >= 0 ? sections[idx] : null;
    if (islandNow) islandNow.textContent = s?.dataset.section ?? defaultIslandText;
    tocLinks.forEach((a, j) => a.setAttribute('aria-current', String(j === idx)));
    stops.forEach((b, j) => {
      b.classList.toggle('passed', j < idx);
      b.classList.toggle('current', j === idx);
    });
  }
  if (islandRing) islandRing.style.strokeDashoffset = String(50.27 * (1 - progress));
  if (rail && railQuery.matches && tops.length) {
    const i = Math.max(0, idx);
    const n = Math.min(i + 1, tops.length - 1);
    const span = tops[n] - tops[i];
    const p = n === i || span <= 0 || idx < 0 ? 0 : Math.min(1, Math.max(0, (line - tops[i]) / span));
    const py = stopY[i] + (stopY[n] - stopY[i]) * p;
    if (railPuck) railPuck.style.transform = `translate(-50%, ${py - 7}px)`;
    if (railFill) railFill.style.height = `${py}px`;
  }
  updateStack();
}
function onScroll() {
  if (!ticking) {
    ticking = true;
    requestAnimationFrame(frame);
  }
}
measure();
frame();
window.addEventListener('scroll', onScroll, { passive: true });
window.addEventListener('resize', () => {
  measure();
  frame();
});
window.addEventListener('load', () => {
  measure();
  frame();
});
if ('ResizeObserver' in window) {
  new ResizeObserver(() => {
    measure();
    frame();
  }).observe(document.body);
}

/* ---------- count-up, once, when a number first scrolls into view ---------- */
// Numbers on screen at load count up too. The inline script after them (Hero.astro) has already set
// them to their starting value, so the first paint never shows the final one.
function countUp(el: HTMLElement) {
  const from = parseFloat(el.dataset.from ?? '0');
  const to = parseFloat(el.dataset.count ?? '0');
  const decimals = Number(el.dataset.decimals ?? 0);
  const prefix = el.dataset.prefix ?? '';
  const suffix = el.dataset.suffix ?? '';
  const duration = 1200;
  let start = 0;
  const step = (now: number) => {
    start ||= now;
    const k = Math.min(1, (now - start) / duration);
    const eased = 1 - Math.pow(1 - k, 3);
    el.textContent = `${prefix}${(from + (to - from) * eased).toFixed(decimals)}${suffix}`;
    if (k < 1) requestAnimationFrame(step);
    else el.dataset.state = 'done';
  };
  requestAnimationFrame(step);
}
if (!reduced() && 'IntersectionObserver' in window) {
  const io = new IntersectionObserver(
    (entries) => {
      entries.forEach((entry) => {
        if (!entry.isIntersecting) return;
        io.unobserve(entry.target);
        countUp(entry.target as HTMLElement);
      });
    },
    { threshold: 0.6 },
  );
  const counters = $$('[data-count]');
  counters.forEach((el) => (el.dataset.state = 'waiting'));
  let watching = false;
  const watch = () => {
    if (!watching) counters.forEach((el) => io.observe(el));
    watching = true;
  };
  // Opened at a #section, the page scrolls down past the numbers first: start watching once it settles.
  if (location.hash.length > 1 && document.getElementById(location.hash.slice(1))) {
    window.setTimeout(watch, 1200);
    window.addEventListener('scrollend', watch, { once: true });
  } else watch();
}

/* ---------- swiped rows on phones: dots for where you are ---------- */
$$('[data-swipe]').forEach((row) => {
  const slides = Array.from(row.children) as HTMLElement[];
  const nav = document.createElement('div');
  nav.className = 'swipe-dots';
  nav.setAttribute('role', 'group');
  nav.setAttribute('aria-label', row.dataset.swipe ?? '');
  const dots = slides.map((slide) => {
    const b = document.createElement('button');
    b.type = 'button';
    b.setAttribute('aria-label', `Show ${slide.dataset.name ?? ''}`);
    b.addEventListener('click', () => row.scrollTo({ left: slide.offsetLeft - slides[0].offsetLeft, behavior: reduced() ? 'auto' : 'smooth' }));
    nav.append(b);
    return b;
  });
  row.after(nav);
  const update = () => {
    const step = slides.length > 1 ? slides[1].offsetLeft - slides[0].offsetLeft : 0;
    const i = step > 0 ? Math.min(slides.length - 1, Math.round(row.scrollLeft / step)) : 0;
    dots.forEach((d, j) => (j === i ? d.setAttribute('aria-current', 'true') : d.removeAttribute('aria-current')));
  };
  row.addEventListener('scroll', update, { passive: true });
  window.addEventListener('resize', update);
  update();
});

/* ---------- more work: filters, show all and quick view ---------- */
const grid = $('#mw-grid');
const showAll = $<HTMLButtonElement>('#mw-all');
// On phones the list starts at its newest four; a filter or the button shows the rest.
const expand = () => {
  grid?.removeAttribute('data-collapsed');
  measure();
};
showAll?.addEventListener('click', () => {
  expand();
  $<HTMLButtonElement>('#mw-grid > li:nth-child(5) .mw-card')?.focus();
});
const chips = $$<HTMLButtonElement>('#mw-filters .chip');
const items = $$('#mw-grid > li');
chips.forEach((chip) =>
  chip.addEventListener('click', () => {
    const f = chip.dataset.f;
    expand();
    chips.forEach((c) => c.setAttribute('aria-pressed', String(c === chip)));
    items.forEach((li) => {
      const show = f === 'all' || (li.dataset.tags ?? '').split(' ').includes(f ?? '');
      li.hidden = !show;
      if (show && !reduced()) {
        li.classList.remove('enter');
        void li.offsetWidth;
        li.classList.add('enter');
      }
    });
    measure();
  }),
);

const drawer = $<HTMLDialogElement>('#drawer');
function openDrawer(id: string) {
  const tpl = $<HTMLTemplateElement>(`#mw-${id}`);
  const body = $('#drawer-body');
  if (!drawer || !tpl || !body) return;
  body.replaceChildren(tpl.content.cloneNode(true));
  drawer.showModal();
  if (location.hash !== `#${id}`) history.replaceState(null, '', `#${id}`);
}
$$<HTMLButtonElement>('button.mw-card').forEach((b) => b.addEventListener('click', () => openDrawer(b.dataset.id ?? '')));
drawer?.addEventListener('click', (e) => {
  if (e.target === drawer) drawer.close();
});
drawer?.addEventListener('close', () => {
  // A film playing in the drawer stops with it.
  drawer.querySelectorAll('video').forEach((v) => v.pause());
  if (location.hash && items.some((li) => `#${li.dataset.id}` === location.hash)) history.replaceState(null, '', location.pathname);
});
$('#drawer-close')?.addEventListener('click', () => drawer?.close());
const deepLink = location.hash.slice(1);
if (deepLink && items.some((li) => li.dataset.id === deepLink)) {
  expand();
  openDrawer(deepLink);
}

/* ---------- capabilities ---------- */
const capButtons = $$<HTMLButtonElement>('.cap-btn');
const capTiles = $$('.cap-tile');
const capOut = $('#cap-out');
function selectCapability(b: HTMLButtonElement) {
  capButtons.forEach((x) => x.setAttribute('aria-pressed', String(x === b)));
  const ids = (b.dataset.ids ?? '').split(' ');
  capTiles.forEach((t) => t.classList.toggle('on', ids.includes(t.dataset.id ?? '')));
  if (capOut) {
    const strong = document.createElement('b');
    strong.textContent = `${b.textContent?.trim()}. `;
    capOut.replaceChildren(strong, document.createTextNode(b.dataset.proof ?? ''));
  }
}
capButtons.forEach((b) => {
  b.addEventListener('click', () => selectCapability(b));
  b.addEventListener('mouseenter', () => selectCapability(b));
  b.addEventListener('focus', () => selectCapability(b));
});
if (capButtons[0]) selectCapability(capButtons[0]);

document.addEventListener('keydown', (e) => {
  if (e.key === 'Escape') {
    setIsland(false);
    setStatus(false);
  }
});
