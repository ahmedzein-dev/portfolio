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
const statusRows = statusPanel ? $$('div', statusPanel) : [];
let statusTyping = 0;
// Opening the panel types its rows in, one after another, like a status readout.
function typeStatus() {
  window.cancelAnimationFrame(statusTyping);
  const rows = statusRows.map((row) => ({ row, el: $('.vt', row), text: $('.vg', row)?.textContent ?? '' }));
  if (reduced()) {
    rows.forEach(({ row, el, text }) => {
      row.classList.remove('wait');
      if (el) el.textContent = text;
    });
    return;
  }
  rows.forEach(({ row, el }) => {
    row.classList.add('wait');
    if (el) el.textContent = '';
  });
  const perChar = 22;
  const gap = 180;
  let start = 0;
  const step = (now: number) => {
    start ||= now;
    let t = now - start;
    let running = false;
    for (const { row, el, text } of rows) {
      if (t < 0) break;
      row.classList.remove('wait');
      const n = Math.min(text.length, Math.floor(t / perChar) + 1);
      if (el) el.replaceChildren(text.slice(0, n), ...(n < text.length ? [Object.assign(document.createElement('i'), { className: 'caret' })] : []));
      if (n < text.length) {
        running = true;
        break;
      }
      t -= text.length * perChar + gap;
    }
    if (running || t < 0) statusTyping = requestAnimationFrame(step);
  };
  statusTyping = requestAnimationFrame(step);
}
function setStatus(open: boolean) {
  if (!statusBtn || !statusPanel) return;
  statusBtn.setAttribute('aria-expanded', String(open));
  statusPanel.hidden = !open;
  if (open) typeStatus();
  else window.cancelAnimationFrame(statusTyping);
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
const toTop = $<HTMLButtonElement>('#to-top');
const toTopRing = $<SVGCircleElement>('#to-top-ring');
toTop?.addEventListener('click', () => {
  window.scrollTo({ top: 0, behavior: reduced() ? 'auto' : 'smooth' });
  $('.brand')?.focus({ preventScroll: true });
});

function frame() {
  ticking = false;
  const y = window.scrollY;
  const vh = window.innerHeight;
  toTop?.classList.toggle('show', y > vh * 0.9);
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
  if (toTopRing) toTopRing.style.strokeDashoffset = String(1 - progress);
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

/* ---------- experience: the career builds up from the first job ---------- */
// Once, when the timeline comes into view: the line draws upward and each stop lights up in turn,
// oldest first (CSS, under .play). Left as it is when it is already on screen at load.
const timeline = $('.timeline');
if (timeline && !reduced() && 'IntersectionObserver' in window && timeline.getBoundingClientRect().top > window.innerHeight) {
  timeline.classList.add('tl-anim');
  const tio = new IntersectionObserver(
    (entries) => {
      if (!entries.some((e) => e.isIntersecting)) return;
      tio.disconnect();
      timeline.classList.add('play');
    },
    { threshold: 0.3 },
  );
  tio.observe(timeline);
}

/* ---------- package demos: run only while their card is on screen ---------- */
// The CSS loops run under .live; the highlight demo types its searches here, and the floating windows
// recording plays.
const pkgs = $$('.pkg');
const sht = $('.sht');
const marks = sht ? $$<HTMLElement>('mark', sht) : [];
const shtCount = sht ? $('.cnt', sht) : null;
const shtQuery = sht ? $('.sht-q .q', sht) : null;
let shtRun = 0; // bumped to stop the running loop
const shtWait = (ms: number, run: number) =>
  new Promise<void>((done, stop) => window.setTimeout(() => (run === shtRun ? done() : stop()), ms));
function shtShow(query: string, at: number) {
  const hits = marks.filter((m) => m.dataset.q === query);
  marks.forEach((m) => {
    m.classList.toggle('hit', hits.includes(m));
    m.classList.toggle('cur', hits[at] === m);
  });
  if (shtCount) {
    shtCount.classList.toggle('empty', hits.length === 0);
    if (hits.length) shtCount.textContent = `${at + 1} of ${hits.length}`;
  }
}
// highlight finds the two Latin matches, نتيجة the Arabic one: typed, lit, stepped through, erased.
async function runHighlight(run: number) {
  if (!sht || !shtQuery) return;
  sht.classList.add('demo');
  for (;;) {
    for (const q of ['highlight', 'نتيجة']) {
      shtShow('', 0);
      await shtWait(500, run);
      for (let i = 1; i <= q.length; i++) {
        shtQuery.textContent = q.slice(0, i);
        await shtWait(110, run);
      }
      await shtWait(250, run);
      const n = marks.filter((m) => m.dataset.q === q).length;
      for (let at = 0; at < n; at++) {
        shtShow(q, at);
        await shtWait(1300, run);
      }
      await shtWait(500, run);
      while (shtQuery.textContent) {
        shtQuery.textContent = shtQuery.textContent.slice(0, -1);
        await shtWait(45, run);
      }
    }
  }
}
if (pkgs.length && !reduced() && 'IntersectionObserver' in window) {
  const live = new IntersectionObserver(
    (entries) =>
      entries.forEach((e) => {
        const card = e.target as HTMLElement;
        card.classList.toggle('live', e.isIntersecting);
        const video = $<HTMLVideoElement>('video.dfw-demo', card);
        if (video) {
          if (e.isIntersecting) video.play().catch(() => {});
          else video.pause();
        }
        if (sht && card.contains(sht)) {
          shtRun++;
          if (e.isIntersecting) runHighlight(shtRun).catch(() => {});
        }
      }),
    { threshold: 0.4 },
  );
  pkgs.forEach((p) => live.observe(p));
}

/* ---------- reveal on scroll: once, for what starts below the fold ---------- */
// Whatever is on screen at load stays as it is, so the first view is complete. The rest fades and rises in
// the first time it scrolls into view, a beat apart when several arrive together, then drops the classes
// so its own hover transitions are back.
if (!reduced() && 'IntersectionObserver' in window) {
  const io = new IntersectionObserver(
    (entries) => {
      entries
        .filter((e) => e.isIntersecting)
        .forEach((e, i) => {
          const el = e.target as HTMLElement;
          io.unobserve(el);
          el.style.setProperty('--rd', `${Math.min(i, 4) * 70}ms`);
          el.classList.add('in');
          const done = (ev: TransitionEvent) => {
            if (ev.target !== el) return; // a child's own transition, not the reveal
            el.removeEventListener('transitionend', done);
            el.classList.remove('reveal', 'in');
            el.style.removeProperty('--rd');
          };
          el.addEventListener('transitionend', done);
        });
    },
    { rootMargin: '0px 0px -8% 0px', threshold: 0.08 },
  );
  $$(
    '.section-head, .scard, .pkg, .mw-bar, .mw-grid > li:not([hidden]), .cap-btns, .cap-tiles, .contact, .case-shots figure',
  ).forEach((el) => {
    if (el.getBoundingClientRect().top < window.innerHeight) return;
    // Cards in a row that swipes stay as they are, so a swipe only moves them sideways.
    const row = el.parentElement;
    if (row?.matches('[data-swipe]') && row.scrollWidth > row.clientWidth + 1) return;
    el.classList.add('reveal');
    io.observe(el);
  });
}

/* ---------- count-up, once, when a number first scrolls into view ---------- */
// The inline script after the numbers (Hero.astro) owns the count (window.azCountUp) and has already
// started the ones on screen; the rest count here as they scroll into view.
const countUp = (window as Window & { azCountUp?: (el: HTMLElement) => void }).azCountUp;
if (countUp && !reduced() && 'IntersectionObserver' in window) {
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
  const counters = $$('[data-count]').filter((el) => el.dataset.state === 'start');
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
  // Each card also learns how far it is from settling (--sp, -1 to 1), for the depth while swiping (CSS).
  let queued = false;
  const update = () => {
    queued = false;
    const step = slides.length > 1 ? slides[1].offsetLeft - slides[0].offsetLeft : 0;
    const i = step > 0 ? Math.min(slides.length - 1, Math.round(row.scrollLeft / step)) : 0;
    dots.forEach((d, j) => (j === i ? d.setAttribute('aria-current', 'true') : d.removeAttribute('aria-current')));
    const swiping = step > 0 && row.scrollWidth > row.clientWidth + 1 && !reduced();
    slides.forEach((slide, j) => {
      slide.classList.toggle('cur', j === i);
      if (!swiping) {
        slide.style.removeProperty('--sp');
        slide.style.removeProperty('--spa');
        return;
      }
      const sp = Math.max(-1, Math.min(1, (slide.offsetLeft - slides[0].offsetLeft - row.scrollLeft) / step));
      slide.style.setProperty('--sp', sp.toFixed(3));
      slide.style.setProperty('--spa', Math.abs(sp).toFixed(3));
    });
  };
  const queue = () => {
    if (!queued) {
      queued = true;
      requestAnimationFrame(update);
    }
  };
  row.addEventListener('scroll', queue, { passive: true });
  window.addEventListener('resize', queue);
  update();
});

/* ---------- touch screens: the card and tiles in the middle of the screen act as if hovered ---------- */
// .on, while they cross the middle of the screen; the CSS uses it only where there is no hover.
if (!reduced() && 'IntersectionObserver' in window) {
  const middle = new IntersectionObserver(
    (entries) => entries.forEach((e) => e.target.classList.toggle('on', e.isIntersecting)),
    { rootMargin: '-38% 0px -38% 0px' },
  );
  $$('.scard, .mw-grid > li').forEach((el) => middle.observe(el));
}

/* ---------- more work: filters ---------- */
const chips = $$<HTMLButtonElement>('#mw-filters .chip');
const items = $$('#mw-grid > li');
const showAll = $<HTMLButtonElement>('#mw-all');
const FIRST = 4;
let filter = 'all';
// A filter shows its first four matches; the toggle under the grid shows the rest and hides them again.
// Under All, the first four are the projects that aren't in Selected Work (those carry data-featured).
function showProjects(everything = false) {
  const matches = items.filter((li) => filter === 'all' || (li.dataset.tags ?? '').split(' ').includes(filter));
  const first = filter === 'all' ? matches.filter((li) => li.dataset.featured === undefined).slice(0, FIRST) : matches.slice(0, FIRST);
  let n = 0;
  items.forEach((li) => {
    const show = matches.includes(li) && (everything || first.includes(li));
    const appearing = show && li.hidden;
    li.hidden = !show;
    if (appearing && !reduced()) {
      li.classList.remove('enter');
      li.style.animationDelay = `${Math.min(n++, 5) * 50}ms`;
      void li.offsetWidth;
      li.classList.add('enter');
    }
  });
  if (showAll) {
    showAll.hidden = matches.length <= first.length;
    showAll.setAttribute('aria-expanded', String(everything));
    const label = showAll.querySelector('span');
    if (label) label.textContent = everything ? 'Show less' : `Show all ${matches.length}`;
  }
  measure();
}
chips.forEach((chip) =>
  chip.addEventListener('click', () => {
    chips.forEach((c) => c.setAttribute('aria-pressed', String(c === chip)));
    filter = chip.dataset.f ?? 'all';
    showProjects();
  }),
);
showAll?.addEventListener('click', () => {
  const expand = showAll.getAttribute('aria-expanded') !== 'true';
  showProjects(expand);
  // Hiding them again shortens the page; if that leaves you below the section, bring its top back.
  const section = $('#more-work');
  if (!expand && section && section.getBoundingClientRect().top < 0) section.scrollIntoView({ behavior: reduced() ? 'auto' : 'smooth' });
});

// Every project has a case study now; a link to the old quick view (/#osta-home) opens it.
const deepLink = location.hash.slice(1);
if (deepLink && items.some((li) => li.dataset.id === deepLink)) location.replace(`/work/${deepLink}/`);

/* ---------- capabilities ---------- */
const capButtons = $$<HTMLButtonElement>('.cap-btn');
const capTiles = $$('.cap-tile');
const capOut = $('#cap-out');
const capSr = capOut ? $('.sr-only', capOut) : null;
const capGhost = capOut ? $('.cap-ghost', capOut) : null;
const capTyped = capOut ? $('.cap-typed', capOut) : null;
let capCurrent: HTMLButtonElement | null = null;
let capFrame = 0;
// The proof types out as the answer to a tap, 28 ms a character. The ghost copy keeps its
// full size, and screen readers get the whole sentence from the live region at once. Tapping the same
// capability again, or reduced motion, shows it all.
function writeProof(el: HTMLElement, name: string, proof: string, n: number, caret: boolean) {
  const strong = document.createElement('b');
  strong.textContent = name.slice(0, n);
  const parts: Node[] = [strong, document.createTextNode(proof.slice(0, Math.max(0, n - name.length)))];
  if (caret) parts.push(Object.assign(document.createElement('i'), { className: 'caret' }));
  el.replaceChildren(...parts);
}
function selectCapability(b: HTMLButtonElement, typeIt = true) {
  const again = b === capCurrent;
  capCurrent = b;
  capButtons.forEach((x) => x.setAttribute('aria-pressed', String(x === b)));
  const ids = (b.dataset.ids ?? '').split(' ');
  capTiles.forEach((t) => t.classList.toggle('on', ids.includes(t.dataset.id ?? '')));
  if (!capTyped || !capGhost || !capSr) return;
  const name = `${b.textContent?.trim()}. `;
  const proof = b.dataset.proof ?? '';
  const total = name.length + proof.length;
  window.cancelAnimationFrame(capFrame);
  if (!again) {
    capSr.textContent = name + proof;
    writeProof(capGhost, name, proof, total, false);
  }
  if (again || !typeIt || reduced()) {
    writeProof(capTyped, name, proof, total, false);
    return;
  }
  const perChar = 28;
  let start = 0;
  const step = (now: number) => {
    start ||= now;
    const n = Math.min(total, Math.floor((now - start) / perChar) + 1);
    writeProof(capTyped, name, proof, n, n < total);
    if (n < total) capFrame = requestAnimationFrame(step);
  };
  capFrame = requestAnimationFrame(step);
}
capButtons.forEach((b) => {
  b.addEventListener('click', () => selectCapability(b));
  b.addEventListener('mouseenter', () => selectCapability(b));
  b.addEventListener('focus', () => selectCapability(b));
});
if (capButtons[0]) selectCapability(capButtons[0], false);

document.addEventListener('keydown', (e) => {
  if (e.key === 'Escape') {
    setIsland(false);
    setStatus(false);
  }
});
