import type { ImageMetadata } from 'astro';

import photo from '../assets/photo/ahmed-zein.jpg';
import avatar from '../assets/photo/ahmed-zein-square.jpg';
import taggoRider from '../assets/work/customer1.png';
import taggoDriver from '../assets/work/driver1.png';
import theEvents from '../assets/work/theevents_image.png';
import gainz from '../assets/work/gainz_image.jpg';
import amberDrive from '../assets/work/rak_rent.png';
import osta from '../assets/work/osta1.png';
import alTaher from '../assets/work/altaher_home.png';
import spark from '../assets/work/spark1.png';
import ba3ControlPanel from '../assets/work/ba3_control_panel.png';

export const profile = {
  name: 'Ahmed Zein',
  fullName: 'Ahmed Zein Elabedin',
  title: 'Senior Mobile Engineer',
  location: 'Abu Dhabi',
  email: 'ahmed.zein1896@gmail.com',
  photo,
  /** Square head-and-shoulders crop of the photo, for the hero. */
  avatar,
  availability: {
    long: 'Open to full-time roles and freelance work',
    short: 'Open to work',
  },
  headline: 'I build mobile apps that stay live.',
  intro:
    'Real-time tracking, background execution, iOS Live Activities and payments, shipped in Taggo, Taggo Captain and The Events. Author of three Flutter packages.',
  description:
    'Ahmed Zein, Senior Mobile Engineer in Abu Dhabi. Real-time tracking, background execution, iOS Live Activities and payments in Flutter apps live in the UAE stores.',
  now: [
    { label: 'Now', value: 'Senior Mobile Engineer at Kief, Abu Dhabi' },
    { label: 'Shipping', value: 'Taggo, Taggo Captain and The Events' },
    { label: 'Latest release', value: 'draggable_floating_window 0.0.1 · 8 Oct 2026' },
  ],
  links: {
    linkedin: 'https://www.linkedin.com/in/ahmed-zein-294230270',
    github: 'https://github.com/ahmedzein-dev',
    pubdev: 'https://pub.dev/publishers/ahmedzein.dev/packages',
  },
};

export type Proof = { value: string; count?: number; decimals?: number; prefix?: string; suffix?: string; label: string; href: string };

export const proof: Proof[] = [
  { value: '3', count: 3, label: 'apps live in UAE stores', href: '#work' },
  { value: '3.5M', count: 3.5, decimals: 1, suffix: 'M', label: 'AED a month through BA3', href: '/work/ba3/' },
  { value: '~829M', count: 829, prefix: '~', suffix: 'M', label: 'Firestore reads saved a year', href: '/work/ba3/' },
  { value: '12 → 3 s', label: 'app launch, The Events', href: '/work/the-events/' },
  { value: '3', count: 3, label: 'packages on pub.dev', href: '#open-source' },
];

export type Shot = { src: ImageMetadata; alt: string; kind: 'phone' | 'square' | 'window' };
export type StoreLink = { label: string; href: string };

export type Flagship = {
  slug: string;
  name: string;
  eyebrow: string;
  headline: string;
  summary: string;
  role: string;
  period: string;
  platforms: string;
  tags: string[];
  theme: 'taggo' | 'events' | 'ba3' | 'gainz';
  shots: Shot[];
  caption?: string;
  constraint?: string;
  highlights: string[];
  numbers?: { value: string; label: string }[];
  links: StoreLink[];
  film?: Film;
  /** How the project appears in the All projects grid. */
  card: { year: string; platforms: string; summary: string; kinds: Kind[]; image: ImageMetadata; fit: 'cover' | 'contain' };
};

/** Filters in the All projects grid. */
export type Kind = 'mobile' | 'web';

/** A product film: an H.264 MP4 and its poster frame, both under public/films. */
export type Film = { src: string; poster: string; title: string; length: string; caption: string };

export const flagships: Flagship[] = [
  {
    slug: 'taggo',
    name: 'Taggo',
    eyebrow: 'Taggo · Rider and driver apps · 2025 to now',
    headline: 'Both sides of a ride-hailing platform',
    summary:
      'Ride-hailing and cargo for the UAE, live on the App Store and Google Play. Real-time dispatch and tracking over Socket.IO, background location, Live Activities, Stripe with 3D Secure, and Taggo Buddy, a push-to-talk voice assistant on Gemini Live.',
    role: 'Lead mobile engineer, Kief Consultancy & Technology',
    period: '2025 to now',
    platforms: 'iOS and Android',
    tags: ['Socket.IO', 'Background isolates', 'Live Activities', 'Stripe 3DS', 'Gemini Live'],
    card: { year: '2025 to now', platforms: 'Mobile', summary: 'Ride-hailing and cargo, rider and driver apps.', kinds: ['mobile'], image: taggoRider, fit: 'cover' },
    theme: 'taggo',
    shots: [
      { src: taggoRider, alt: 'Taggo rider app home with ride and cargo services', kind: 'phone' },
      { src: taggoDriver, alt: 'Taggo Captain waiting for the rider, with a countdown and the route on the map', kind: 'phone' },
    ],
    constraint: 'An offer the driver never hears is lost income.',
    highlights: [
      'Live and scheduled rides with per-vehicle-class fares, and cargo shipments through a six-step flow to proof of delivery.',
      'Real-time trip tracking over two Socket.IO channels, with the driver marker smoothed between position updates.',
      'Driver app: several live offers at once, each with its own countdown, and a ride state machine with proximity auto-arrive and a guard against out-of-order server states.',
      'A background isolate keeps the driver’s position live with a heartbeat and a ping buffer for network gaps; on Android a full-screen intent wakes the screen for a new offer.',
      'iOS Live Activities and the Dynamic Island, with state passed through UserDefaults because updates raced in the plugin.',
      'Stripe with 3D Secure, saved cards and split wallet-plus-card charges.',
      'Taggo Buddy: push-to-talk voice booking on the Gemini Live API through a backend relay, confirmed with biometrics.',
      'Hardened clients: freeRASP integrity checks, screenshot blocking on sensitive screens, and release guards on every build path.',
      'Ride and cargo are live; rental and recovery are built behind launch flags.',
    ],
    links: [
      { label: 'Taggo on the App Store', href: 'https://apps.apple.com/ae/app/taggo-ride-cargo/id6756260610' },
      { label: 'Taggo on Google Play', href: 'https://play.google.com/store/apps/details?id=ae.kief.taggo' },
      { label: 'Taggo Captain on the App Store', href: 'https://apps.apple.com/ae/app/taggo-captain/id6784939884' },
      { label: 'Taggo Captain on Google Play', href: 'https://play.google.com/store/apps/details?id=ae.kief.taggodriver.taggo_driver' },
    ],
  },
  {
    slug: 'the-events',
    name: 'The Events',
    eyebrow: 'The Events · Gifting e-commerce · 2025 to now',
    headline: 'A 12-second launch, down to 3',
    summary:
      'Flowers and gifts across nine Gulf countries. App launch went from about 12 s to about 3 s on the same phone, through lazy home sections, de-duplicated requests, a native splash and skeleton loading. Checkout runs on Telr, Apple Pay and Google Pay.',
    role: 'Lead mobile engineer, Kief Consultancy & Technology',
    period: 'April 2025 to now',
    platforms: 'iOS and Android',
    tags: ['Launch performance', 'Telr', 'Apple Pay', 'Google Pay', 'Forced updates'],
    card: { year: '2025 to now', platforms: 'Mobile', summary: 'Flowers and gifts across nine Gulf countries.', kinds: ['mobile'], image: theEvents, fit: 'cover' },
    theme: 'events',
    shots: [{ src: theEvents, alt: 'The Events app promotional screen', kind: 'square' }],
    constraint: 'The app took about 12 seconds to open on the same phone.',
    highlights: [
      'App launch from about 12 s to about 3 s on the same phone: lazy home sections and tabs, de-duplicated provider requests, a native splash, shimmer skeletons and pre-cached SVGs.',
      'Checkout with Telr, Apple Pay and Google Pay.',
      'PDF invoices and printing.',
      'Forced updates, so every user runs a supported version.',
    ],
    numbers: [
      { value: '~12 s → ~3 s', label: 'app launch, same phone' },
      { value: '9', label: 'Gulf countries' },
    ],
    links: [
      { label: 'The Events on the App Store', href: 'https://apps.apple.com/ae/app/theevents-gifts-shopping/id6739205204' },
      { label: 'The Events on Google Play', href: 'https://play.google.com/store/apps/details?id=com.logicalyinfotech.events' },
    ],
  },
  {
    slug: 'ba3',
    name: 'BA3 Business Solutions',
    eyebrow: 'BA3 Business Solutions · Accounting · 2024 to 2025',
    headline: 'Five platforms, one codebase, 3.5M AED a month',
    summary:
      'Accounting and business management on Android, iOS, Windows, macOS and the web. A Firestore re-architecture saved about 829M reads a year and made invoice creation about 99% faster. Desktop users work in floating windows, now open source as draggable_floating_window.',
    role: 'Senior Software Engineer, BA3',
    period: 'May 2024 to April 2025',
    platforms: 'Android, iOS, Windows, macOS and web',
    tags: ['Firestore', 'Desktop windowing', 'Six languages', 'PDF and e-invoices'],
    card: { year: '2024 to 2025', platforms: 'Mobile, desktop and web', summary: 'Accounting on five platforms, with floating windows.', kinds: ['mobile', 'web'], image: ba3ControlPanel, fit: 'cover' },
    theme: 'ba3',
    shots: [
      {
        src: ba3ControlPanel,
        alt: 'The BA3 Control Panel on an iPad, in Arabic: main account balances, invoice and employee counts, and each seller’s share of sales as a donut chart',
        kind: 'window',
      },
    ],
    caption: 'Shown: the BA3 Control Panel on sample data, in Arabic, right to left.',
    highlights: [
      'A Firestore re-architecture that saved about 829M reads a year (about $497) and made invoice creation about 99% faster.',
      'About 3.5M AED a month in transactions through bills, vouchers, cheques and accounts.',
      'Floating, draggable, priority-stacked windows on desktop, so many bills stay open at once.',
      'PDF export for bills, vouchers and cheques, including before-and-after comparisons, with sharing by email and WhatsApp.',
      'E-invoices with a QR code.',
      'Six interface languages: Arabic, English, Urdu, French, German and Chinese, right-to-left included.',
      'XML and JSON import and export, and a year-end migration that rolls balances and stock forward.',
      'Attendance with check-in times, delays and holidays.',
    ],
    numbers: [
      { value: '3.5M AED', label: 'a month' },
      { value: '~829M', label: 'Firestore reads saved a year' },
      { value: '~99%', label: 'faster invoice creation' },
    ],
    links: [{ label: 'draggable_floating_window on pub.dev', href: 'https://pub.dev/packages/draggable_floating_window' }],
    film: {
      src: '/films/ba3-business-solutions.mp4',
      poster: '/films/ba3-business-solutions.jpg',
      title: 'BA3 Business Solutions product film',
      length: '3:28',
      caption:
        'The app on sample data: the control panel, invoices, floating windows, bill search and export, data import, the year-end migration with the cash statement before and after, the activity log and six languages.',
    },
  },
  {
    slug: 'gainz-ai',
    name: 'Gainz AI',
    eyebrow: 'Gainz AI · AI fitness · 2024 · Contract',
    headline: 'Notes you can search, summarise and translate',
    summary:
      'An iOS fitness app with AI athlete avatars and adaptive plans. I built note search with match highlighting, later published as scroll_highlight_text, plus on-device summarisation and translation.',
    role: 'Mobile developer, contract (remote, London)',
    period: 'February to May 2024',
    platforms: 'iOS',
    tags: ['On-device AI', 'Search highlighting', 'Summarisation', 'Translation'],
    card: { year: '2024', platforms: 'Mobile', summary: 'AI fitness coaching with searchable notes.', kinds: ['mobile'], image: gainz, fit: 'cover' },
    theme: 'gainz',
    shots: [{ src: gainz, alt: 'Gainz AI app screens', kind: 'square' }],
    highlights: [
      'Note search with match highlighting and step-through navigation, later published as the scroll_highlight_text package.',
      'On-device summarisation and translation of notes.',
    ],
    links: [{ label: 'Gainz AI on the App Store', href: 'https://apps.apple.com/us/app/gainz-ai-chat-train-track/id6474649083' }],
  },
];

export type MoreWork = {
  id: string;
  name: string;
  year: string;
  platforms: string;
  tags: Kind[];
  summary: string;
  description: string;
  points: string[];
  image: ImageMetadata;
  fit: 'cover' | 'contain';
  links: StoreLink[];
  film?: Film;
};

export const moreWork: MoreWork[] = [
  {
    id: 'amber-drive',
    name: 'Amber Drive',
    year: '2024 to 2025',
    platforms: 'Mobile and web',
    tags: ['mobile', 'web'],
    summary: 'Car rental with renter and owner flows in one app.',
    description: 'A car rental marketplace for the UAE. One Flutter app serves renters and car owners with separate flows, switched at login.',
    points: [
      'UAE Pass, phone and biometric sign-in',
      'Licence capture with an on-device OCR camera frame, where document_camera_frame started',
      'Cars on a custom-styled map with routes, and slide-to-book',
      'Stripe payments, and Stripe Connect payouts to owners',
      'Owner fleet board, booking approvals and damage reports with photos',
    ],
    image: amberDrive,
    fit: 'contain',
    links: [],
    film: {
      src: '/films/amber-drive.mp4',
      poster: '/films/amber-drive.jpg',
      title: 'Amber Drive product film',
      length: '1:28',
      caption:
        'The app on sample data: search with filters, booking, the owner’s fleet, and an approval reaching the renter’s phone.',
    },
  },
  {
    id: 'osta-home',
    name: 'Osta Home',
    year: '2023',
    platforms: 'Mobile',
    tags: ['mobile'],
    summary: 'Real-estate and construction services marketplace.',
    description: 'A marketplace for real-estate, construction and finishing services, in Arabic.',
    points: ['Direct contact with verified experts', 'Broker IDs and work scheduling', 'Directories of furnishing and supply companies'],
    image: osta,
    fit: 'cover',
    links: [{ label: 'Google Play', href: 'https://play.google.com/store/apps/details?id=com.home_osta.Osta' }],
  },
  {
    id: 'al-taher',
    name: 'Al-Taher Jewelry',
    year: '2021',
    platforms: 'Mobile',
    tags: ['mobile'],
    summary: 'Client and manager apps with live gold prices.',
    description: 'Client and manager apps for a gold jewellery store.',
    points: ['Client app with live gold prices and search', 'Manager app for stock and price updates'],
    image: alTaher,
    fit: 'cover',
    links: [{ label: 'Google Play', href: 'https://play.google.com/store/apps/details?id=ahmedzein.taher.jewellery.altaher_jewellery' }],
  },
  {
    id: 'spark-fitness',
    name: 'Spark Fitness',
    year: '2022',
    platforms: 'Mobile',
    tags: ['mobile'],
    summary: 'Coach-led group training and subscriptions.',
    description: 'Group training in coach-led sessions.',
    points: ['Personalised training activities', 'Monitoring by coaches', 'Subscriptions'],
    image: spark,
    fit: 'cover',
    links: [{ label: 'App Store', href: 'https://apps.apple.com/ae/app/spark-fitness/id6450647441' }],
  },
];

export const experience = [
  {
    when: 'April 2025 to now',
    place: 'Abu Dhabi',
    role: 'Senior Mobile Engineer',
    org: 'Kief Consultancy & Technology',
    note: 'Lead mobile engineer on Taggo, Taggo Captain and The Events.',
    current: true,
  },
  {
    when: 'May 2024 to April 2025',
    place: 'Ras Al Khaimah',
    role: 'Senior Software Engineer',
    org: 'BA3',
    note: 'BA3 Business Solutions and Amber Drive. document_camera_frame started here.',
  },
  {
    when: 'February to May 2024',
    place: 'Remote, London',
    role: 'Mid-Senior Mobile App Developer',
    org: 'Gainz.ai',
    note: 'Note search with highlighting, on-device summarisation and translation.',
  },
  {
    when: 'January 2022 to January 2024',
    place: 'Cairo',
    role: 'Junior Mobile App Developer',
    org: 'Xtreme Digital',
    note: 'Mobile apps from concept to release.',
  },
  {
    when: 'July to December 2021',
    place: 'Remote, Stockholm',
    role: 'Junior Mobile App Developer',
    org: 'LinnStäd',
    note: 'Remote contract.',
  },
];

export const education = 'BSc, Telecommunications and Computer Engineering, Delta University for Science and Technology, 2017 to 2021';

export const capabilities = [
  {
    name: 'Real-time',
    ids: ['taggo', 'captain'],
    proof: 'Taggo: dispatch and live tracking over two Socket.IO channels. Taggo Captain: live offers with per-offer countdowns.',
  },
  {
    name: 'Background execution',
    ids: ['captain', 'taggo'],
    proof: 'Taggo Captain: a background isolate with a heartbeat, a ping buffer and recovery. Taggo: a background isolate that receives the driver’s position.',
  },
  {
    name: 'Payments',
    ids: ['taggo', 'events', 'rak'],
    proof: 'Taggo: Stripe with 3D Secure and saved cards. The Events: Telr, Apple Pay and Google Pay. Amber Drive: Stripe Connect payouts.',
  },
  {
    name: 'Performance',
    ids: ['events', 'ba3'],
    proof: 'The Events: app launch from about 12 s to about 3 s. BA3: about 829M Firestore reads a year saved, invoices about 99% faster.',
  },
  {
    name: 'Security and release',
    ids: ['taggo', 'captain'],
    proof: 'Taggo and Taggo Captain: freeRASP integrity checks, release guards on every build path, dev and prod flavors side by side.',
  },
  {
    name: 'Desktop and web',
    ids: ['ba3', 'dfw'],
    proof: 'BA3: five platforms from one codebase, with floating windows. draggable_floating_window: that windowing layer as a package.',
  },
  {
    name: 'AI and voice',
    ids: ['taggo', 'gainz'],
    proof: 'Taggo: Taggo Buddy, push-to-talk voice booking on Gemini Live. Gainz AI: on-device summarisation and translation.',
  },
];

export const capabilityTiles = [
  { id: 'taggo', name: 'Taggo', note: 'Rider app' },
  { id: 'captain', name: 'Taggo Captain', note: 'Driver app' },
  { id: 'events', name: 'The Events', note: 'E-commerce' },
  { id: 'ba3', name: 'BA3', note: 'Accounting' },
  { id: 'gainz', name: 'Gainz AI', note: 'Fitness' },
  { id: 'rak', name: 'Amber Drive', note: 'Rental' },
  { id: 'dfw', name: 'Floating windows', note: 'Open-source package' },
];

export type Package = {
  name: string;
  description: string;
  note?: string;
  github?: string;
  fallback: { points: string; likes?: number; downloads30?: number; version: string; published?: string };
};

export const packages: Package[] = [
  {
    name: 'draggable_floating_window',
    description:
      'Draggable, resizable windows inside a Flutter app, with priority stacking, dialogs that block only their own window, and keyboard focus that comes back.',
    github: 'https://github.com/ahmedzein-dev/draggable_floating_window',
    fallback: { points: '160/160', version: '0.0.1', published: '2026-10-08' },
  },
  {
    name: 'document_camera_frame',
    description: 'Document capture with a camera frame, cropping and export.',
    note: 'Runs in production in Taggo Captain’s driver onboarding.',
    fallback: { points: '150/160', likes: 55, downloads30: 735, version: '2.6.11' },
  },
  {
    name: 'scroll_highlight_text',
    description: 'Search, highlight and step through text matches in Latin and Arabic, with match counts and previous and next controls.',
    fallback: { points: '160/160', likes: 43, downloads30: 88, version: '1.0.10' },
  },
];
