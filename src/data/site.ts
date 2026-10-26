import type { ImageMetadata } from 'astro';

import taggoRider from '../assets/work/taggo_rider_home.png';
import taggoDriver from '../assets/work/taggo_captain_pickup.png';
import theEvents from '../assets/work/theevents_home.png';
import theEventsSearch from '../assets/work/theevents_visual_search.png';
import gainz from '../assets/work/gainz_image.jpg';
import amberDrive from '../assets/work/amber_drive.jpg';
import ostaWallet from '../assets/work/osta1.png';
import ostaChat from '../assets/work/osta2.png';
import alTaherHome from '../assets/work/altaher_home.png';
import alTaherWelcome from '../assets/work/altaher_welcome.png';
import sparkHome from '../assets/work/spark1.png';
import sparkGallery from '../assets/work/spark2.png';
import ba3IpadDashboard from '../assets/work/ba3_ipad_dashboard.png';
import ba3IpadInvoice from '../assets/work/ba3_ipad_invoice.png';
// The More projects grid: 4:3 thumbnails made by scripts/card-images.mjs.
import taggoCard from '../assets/cards/taggo.jpg';
import theEventsCard from '../assets/cards/the-events.jpg';
import ba3Card from '../assets/cards/ba3.jpg';
import gainzCard from '../assets/cards/gainz.jpg';
import amberDriveCard from '../assets/cards/amber-drive.jpg';
import ostaCard from '../assets/cards/osta-home.jpg';
import alTaherCard from '../assets/cards/al-taher.jpg';
import sparkCard from '../assets/cards/spark-fitness.jpg';

export const profile = {
  name: 'Ahmed Zein',
  fullName: 'Ahmed Zein Elabedin',
  title: 'Senior Mobile Engineer',
  location: 'Abu Dhabi',
  email: 'ahmed.zein1896@gmail.com',
  phone: '+971544626234',
  phoneLabel: '+971 54 462 6234',
  /** The CV from FlowCV (public/cv); replace the file to update it. */
  cv: '/cv/Ahmed-Zein-CV.pdf',
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
    whatsapp: 'https://wa.me/971544626234',
    github: 'https://github.com/ahmedzein-dev',
    pubdev: 'https://pub.dev/publishers/ahmedzein.dev/packages',
  },
};

export type Proof = { value: string; count?: number; from?: number; decimals?: number; prefix?: string; suffix?: string; label: string; href: string };

export const proof: Proof[] = [
  { value: '3', count: 3, label: 'apps live in UAE stores', href: '#work' },
  { value: '3.5M', count: 3.5, decimals: 1, suffix: 'M', label: 'AED a month through BA3', href: '/work/ba3/' },
  { value: '~829M', count: 829, prefix: '~', suffix: 'M', label: 'Firestore reads saved a year', href: '/work/ba3/' },
  { value: '12 → 3 s', count: 3, from: 12, prefix: '12 → ', suffix: ' s', label: 'app launch, The Events', href: '/work/the-events/' },
  { value: '3', count: 3, label: 'packages on pub.dev', href: '#open-source' },
];

export type Shot = { src: ImageMetadata; alt: string; kind: 'phone' | 'tablet' | 'square' | 'window' };
export type StoreLink = { label: string; href: string };

export type Flagship = {
  slug: string;
  name: string;
  eyebrow: string;
  headline: string;
  summary: string;
  /** One line under the headline in Selected work; the full summary opens the case study. */
  pitch: string;
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
  /** How the project appears in the More projects grid. */
  card: { year: string; platforms: string; summary: string; kinds: Kind[]; image: ImageMetadata };
};

/** Filters in the More projects grid. */
export type Kind = 'mobile' | 'web';

/** A product film: an H.264 MP4 and its poster frame, both under public/films. */
export type Film = { src: string; poster: string; title: string; length: string; caption: string };

export const flagships: Flagship[] = [
  {
    slug: 'taggo',
    name: 'Taggo',
    eyebrow: 'Taggo · Rider and driver apps · 2025 to now',
    headline: 'Both sides of a ride-hailing platform',
    pitch: 'Ride-hailing and cargo for the UAE, with live tracking and Live Activities.',
    summary:
      'Ride-hailing and cargo for the UAE, live on the App Store and Google Play. Real-time dispatch and tracking over Socket.IO, background location, Live Activities, Stripe with 3D Secure, and Taggo Buddy, a push-to-talk voice assistant on Gemini Live.',
    role: 'Lead mobile engineer, Kief Consultancy & Technology',
    period: '2025 to now',
    platforms: 'iOS and Android',
    tags: ['Socket.IO', 'Background isolates', 'Live Activities', 'Stripe 3DS', 'Gemini Live'],
    card: { year: '2025 to now', platforms: 'Mobile', summary: 'Ride-hailing and cargo, rider and driver apps.', kinds: ['mobile'], image: taggoCard },
    theme: 'taggo',
    shots: [
      { src: taggoRider, alt: 'Taggo rider app home: live ride, cargo delivery, VIP service and airport travel', kind: 'phone' },
      { src: taggoDriver, alt: 'Taggo Captain at the pickup: you have arrived, the free-wait countdown, the rider and Start ride', kind: 'phone' },
    ],
    constraint: 'An offer the driver never hears is lost income.',
    highlights: [
      'Live and scheduled rides with per-vehicle-class fares, and cargo shipments through a six-step flow to proof of delivery.',
      'Real-time trip tracking over two Socket.IO channels, with the driver marker smoothed between position updates.',
      'Driver app: several live offers at once, each with its own countdown, and a ride state machine with proximity auto-arrive and a guard against out-of-order server states.',
      'A background isolate keeps the driver’s position live with a heartbeat and a ping buffer for network gaps; on Android a full-screen intent wakes the screen for a new offer.',
      'iOS Live Activities and the Dynamic Island, with state passed through UserDefaults because updates raced in the plugin.',
      'Taggo Captain’s navigation map: a heading-up driving camera that zooms with speed, with smooth car movement that holds its heading when the car stops.',
      'Driver onboarding that scans licences, passports and residency cards on the device, with document_camera_frame, my open-source package.',
      'Stripe with 3D Secure, saved cards, Apple Pay and Google Pay, and split wallet-plus-card charges.',
      'Payment reliability across the wallet, driver cash-out and cash deposits: idempotency keys, settlement reconciliation and recovery from ambiguous failures.',
      'Taggo Buddy: push-to-talk voice booking on the Gemini Live API through a backend relay, confirmed with biometrics.',
      'Hardened clients: freeRASP integrity checks, screenshot blocking on sensitive screens, and release guards on every build path.',
      'Dev and prod flavors in both apps, installable side by side, each with its own backend, app ID and Firebase app.',
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
    pitch: 'Flowers and gifts across nine Gulf countries, on Telr, Apple Pay and Google Pay.',
    summary:
      'Flowers and gifts across nine Gulf countries. App launch went from about 12 s to about 3 s on the same phone, through lazy home sections, de-duplicated requests, a native splash and skeleton loading. Checkout runs on Telr, Apple Pay and Google Pay.',
    role: 'Lead mobile engineer, Kief Consultancy & Technology',
    period: 'April 2025 to now',
    platforms: 'iOS and Android',
    tags: ['Launch performance', 'Telr', 'Apple Pay', 'Google Pay', 'Forced updates'],
    card: { year: '2025 to now', platforms: 'Mobile', summary: 'Flowers and gifts across nine Gulf countries.', kinds: ['mobile'], image: theEventsCard },
    theme: 'events',
    shots: [
      { src: theEvents, alt: 'The Events app home: occasion picks, Celebrate Occasions and Curated For You', kind: 'phone' },
      { src: theEventsSearch, alt: 'The Events visual search: point the camera at a gift to find it in the store', kind: 'phone' },
    ],
    constraint: 'The app took about 12 seconds to open on the same phone.',
    highlights: [
      'Modernised a legacy Flutter codebase: refactored for maintainability, one consistent approach to state management, and a unified UI across the app.',
      'App launch from about 12 s to about 3 s on the same phone: lazy home sections and tabs, de-duplicated provider requests, a native splash, shimmer skeletons and pre-cached SVGs.',
      'Checkout on Telr, with Apple Pay and Google Pay.',
      'PDF generation for order documents, with printing straight from the app.',
      'Forced updates, so every user runs a supported version.',
      'Secure on-device storage, and dependency injection across the app’s services.',
      'Paginated product lists that load more as you scroll.',
      'HTML content rendered inside the app’s screens.',
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
    pitch: 'Accounting on Android, iOS, Windows, macOS and the web, in floating windows.',
    summary:
      'Accounting and business management on Android, iOS, Windows, macOS and the web. A Firestore re-architecture saved about 829M reads a year and made invoice creation about 99% faster. Desktop users work in floating windows, now open source as draggable_floating_window.',
    role: 'Senior Software Engineer, BA3',
    period: 'May 2024 to April 2025',
    platforms: 'Android, iOS, Windows, macOS and web',
    tags: ['Firestore', 'Desktop windowing', 'Six languages', 'PDF and e-invoices'],
    card: { year: '2024 to 2025', platforms: 'Mobile, desktop and web', summary: 'Accounting on five platforms, with floating windows.', kinds: ['mobile', 'web'], image: ba3Card },
    theme: 'ba3',
    shots: [
      { src: ba3IpadDashboard, alt: 'BA3 on an iPad, in Arabic: the Control Panel with sales per seller', kind: 'tablet' },
      { src: ba3IpadInvoice, alt: 'BA3 on an iPad: a sales invoice open in a floating window, with its items, VAT and totals', kind: 'tablet' },
    ],
    highlights: [
      'Invoice fetching rebuilt on a linked-list structure, so creating an invoice no longer reads the whole collection, plus a hybrid materials cache: about 829M Firestore reads saved a year (about $497) and invoices about 99% faster.',
      'About 3.5M AED a month in transactions across 26 modules: bills, vouchers, cheques, accounts and inventory.',
      'Floating, draggable, priority-stacked windows and dialog stacks on desktop, with focus management, so operators keep several bills open at once.',
      'Role-based access with separate seller and admin permissions, synced in real time on every platform through Firestore listeners.',
      'PDF export for bills, vouchers and cheques, including before-and-after comparisons, with sharing by email and through the WhatsApp API.',
      'E-invoices with a QR code, and direct printing.',
      'Six interface languages: Arabic, English, Urdu, French, German and Chinese, right-to-left included, with culture-aware formatting.',
      'XML and JSON import and export, and a year-end migration that rolls balances forward, carries closing stock into opening stock, handles unpaid cheques and closes accounts securely.',
      'Attendance with NFC check-in and check-out, delays and holidays.',
      'Receipts on Bluetooth thermal printers at the point of sale.',
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
      length: '2:54',
      caption:
        'The app on sample data: the control panel, invoices, floating windows, bill search and export, data import, the year-end migration with the cash statement before and after, the activity log and six languages.',
    },
  },
  {
    slug: 'gainz-ai',
    name: 'Gainz AI',
    eyebrow: 'Gainz AI · AI fitness · 2024 · Contract',
    headline: 'Notes you can search, summarise and translate',
    pitch: 'AI fitness coaching, with note search published as scroll_highlight_text.',
    summary:
      'A fitness app with AI athlete avatars and adaptive plans. I built note search with match highlighting, later published as scroll_highlight_text, plus on-device summarisation and translation.',
    role: 'Mobile developer, contract (remote, London)',
    period: 'February to May 2024',
    platforms: 'iOS and Android',
    tags: ['On-device AI', 'Search highlighting', 'Summarisation', 'Translation'],
    card: { year: '2024', platforms: 'Mobile', summary: 'AI fitness coaching with searchable notes.', kinds: ['mobile'], image: gainzCard },
    theme: 'gainz',
    shots: [{ src: gainz, alt: 'Gainz AI app screens', kind: 'square' }],
    highlights: [
      'The Notepad feature set, where members keep their training notes, organised by category and by coach.',
      'Search across note content, categories and coaches at once, with every match highlighted in the text.',
      'Scroll-to-match navigation: step to the next or previous match and the note scrolls it into view.',
      'On-device AI summarisation of notes.',
      'On-device translation of notes.',
      'Search and data retrieval optimised so results stay responsive.',
      'The Note Categories and Note Details screens, designed for smooth transitions and quick responses.',
      'The search and highlighting, extracted and published on pub.dev as scroll_highlight_text, for Latin and Arabic text.',
    ],
    links: [
      { label: 'Gainz AI on the App Store', href: 'https://apps.apple.com/us/app/gainz-ai-chat-train-track/id6474649083' },
      { label: 'Gainz AI on Google Play', href: 'https://play.google.com/store/apps/details?id=ai.gainz.app' },
    ],
  },
];

/** A smaller project: a tile in More projects, and a case study of its own at /work/<id>/. */
export type MoreWork = {
  id: string;
  name: string;
  year: string;
  platforms: string;
  tags: Kind[];
  /** One line on the tile. */
  summary: string;
  headline: string;
  /** The case study's opening paragraph. */
  description: string;
  role?: string;
  shots: Shot[];
  highlights: string[];
  /** The 4:3 grid thumbnail. */
  thumb: ImageMetadata;
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
    headline: 'Car rental for renters and owners, in one app',
    description:
      'A car rental marketplace for the UAE. One Flutter app serves renters and car owners with separate flows, switched at login: renters find a car on a map and book it, owners approve the booking and it updates on the renter’s phone at once. Payments run on Stripe, with Stripe Connect payouts to owners.',
    role: 'Senior Software Engineer, BA3',
    shots: [
      {
        src: amberDrive,
        alt: 'Amber Drive, renter and owner side by side: the owner approves a booking and the renter sees it under Approved at once',
        kind: 'window',
      },
    ],
    highlights: [
      'UAE Pass, phone and biometric sign-in.',
      'Licence capture with an on-device OCR camera frame, built to drop a paid third-party SDK; it became the open-source document_camera_frame.',
      'Cars on a custom-styled Google Map with routes and live availability, and a slide-to-book gesture.',
      'Reservations through pending, approved, current, finished and cancelled, synced in real time over Firebase, with push notifications.',
      'Stripe payments and Stripe Connect payouts to owners, with webhooks that keep a payment right when the app is interrupted mid-transaction.',
      'An owner fleet board, booking approvals and damage reports with photos.',
    ],
    thumb: amberDriveCard,
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
    headline: 'Builders, brokers and finishers, in one marketplace',
    description:
      'A marketplace for residential, commercial and construction services, in Arabic. Customers talk directly to verified experts, compare their ratings and prices, negotiate and schedule the work; registered brokers get official IDs.',
    role: 'Freelance Flutter Developer',
    shots: [
      { src: ostaChat, alt: 'Osta Home chat, in Arabic: a customer asks if the expert is free, the expert asks when to visit, and they talk price', kind: 'phone' },
      { src: ostaWallet, alt: 'Osta Home wallet, in Arabic: the balance, a coupon field and top-up details', kind: 'phone' },
    ],
    highlights: [
      'Residential, commercial and construction services in one app, in Arabic, right to left.',
      'Experts are tested before they can register, and customers see their record, ratings and prices.',
      'Direct chat with an expert, to agree the price, the working time and how long the job takes.',
      'Work scheduling once a job is agreed.',
      'Official ID cards for registered brokers, renewed periodically.',
      'A wallet with coupons and top-ups.',
      'Directories of building-supply, finishing and furnishing companies, showrooms and stores.',
    ],
    thumb: ostaCard,
    links: [{ label: 'Google Play', href: 'https://play.google.com/store/apps/details?id=com.home_osta.Osta' }],
  },
  {
    id: 'spark-fitness',
    name: 'Spark Fitness',
    year: '2022',
    platforms: 'Mobile',
    tags: ['mobile'],
    summary: 'Coach-led group training and subscriptions.',
    headline: 'Group training, followed by coaches',
    description:
      'The app of Spark Fitness & Healthcare Center: personalised group training in supportive sessions, with activities tailored to each member and closely followed by coaches.',
    role: 'Freelance Flutter Developer',
    shots: [
      { src: sparkHome, alt: 'Spark Fitness home: a welcome banner, contact, training activities with their prices, and subscriptions', kind: 'phone' },
      { src: sparkGallery, alt: 'Spark Fitness gallery: photos of members training at the center', kind: 'phone' },
    ],
    highlights: [
      'The member app for Spark Fitness & Healthcare Center, built in Flutter and published on the App Store.',
      'A home screen with the center’s banners, a one-tap contact card, then activities and subscription plans.',
      'Training activities as cards with a photo and a price each: personal and group training, injury rehabilitation, and self-defence courses such as karate, taekwondo and boxing.',
      'Subscription plans by length, from 30 to 90 days, showing what the longer plans save.',
      'Coaches follow every member’s activities.',
      'A gallery of photos from the center.',
      'Notifications for the center’s news.',
    ],
    thumb: sparkCard,
    links: [{ label: 'App Store', href: 'https://apps.apple.com/ae/app/spark-fitness/id6450647441' }],
  },
  {
    id: 'al-taher',
    name: 'Al-Taher Jewelry',
    year: '2021',
    platforms: 'Mobile',
    tags: ['mobile'],
    summary: 'Client and manager apps with live gold prices.',
    headline: 'Two apps for a jewellery store, priced with the day’s gold',
    description:
      'Two apps for a gold jewellery store: a client app for discovering jewellery with real-time prices and search, and a manager app for running the store, from jewellers and products to the daily gold price.',
    role: 'Freelance Flutter Developer',
    shots: [
      { src: alTaherWelcome, alt: 'Al-Taher Jewelry welcome screen, in Arabic, with a gold necklace', kind: 'phone' },
      { src: alTaherHome, alt: 'Al-Taher Jewelry home, in Arabic: featured pieces, then rings and bangles with their prices', kind: 'phone' },
    ],
    highlights: [
      'Two Flutter apps for one jewellery store: a client app for shoppers and a manager app for the staff, published on Google Play.',
      'Client app: a welcome screen, then featured pieces in a carousel and jewellery by category, such as rings and bangles.',
      'Prices that follow the day’s gold rate in real time, from the price the staff set in the manager app.',
      'Search and filters across the jewellery.',
      'Manager app: the store’s jewellers, its products and the daily gold price.',
      'Arabic, right to left.',
    ],
    thumb: alTaherCard,
    links: [{ label: 'Google Play', href: 'https://play.google.com/store/apps/details?id=ahmedzein.taher.jewellery.altaher_jewellery' }],
  },
];

/** Every case study page at /work/<slug>/, in the order Next case study walks through them. */
export type CaseStudy = Pick<
  Flagship,
  'slug' | 'name' | 'headline' | 'summary' | 'period' | 'platforms' | 'shots' | 'caption' | 'constraint' | 'highlights' | 'numbers' | 'links' | 'film'
> & { role?: string; back: { href: string; label: string } };

export const caseStudies: CaseStudy[] = [
  ...flagships.map((p) => ({ ...p, back: { href: '/#work', label: 'Selected work' } })),
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
    back: { href: '/#more-work', label: 'More projects' },
  })),
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
  github: string;
  fallback: { points: string; likes?: number; downloads30?: number; version: string };
};

export const packages: Package[] = [
  {
    name: 'draggable_floating_window',
    description: 'Draggable, resizable windows inside a Flutter app.',
    github: 'https://github.com/ahmedzein-dev/draggable_floating_window',
    fallback: { points: '160/160', version: '0.0.1' },
  },
  {
    name: 'document_camera_frame',
    description: 'Document capture with a camera frame, in Taggo Captain’s onboarding.',
    github: 'https://github.com/ahmedzein-dev/document_camera_frame',
    fallback: { points: '150/160', likes: 55, downloads30: 735, version: '2.6.11' },
  },
  {
    name: 'scroll_highlight_text',
    description: 'Search and highlight text matches, in Latin and Arabic.',
    github: 'https://github.com/ahmedzein-dev/scroll_highlight_text',
    fallback: { points: '160/160', likes: 43, downloads30: 88, version: '1.0.10' },
  },
];
