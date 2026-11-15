const path = require('path');
const fs = require('fs');
const { chromium } = require(path.join(__dirname, '..', '.agents', 'skills', 'playwright-skill', 'node_modules', 'playwright'));

const BASE_URL = 'http://gemilang2.local';
const SCREENSHOT_DIR = path.join(__dirname, '..', 'docs', 'audit', 'screenshots');

if (!fs.existsSync(SCREENSHOT_DIR)) {
  fs.mkdirSync(SCREENSHOT_DIR, { recursive: true });
}

const PAGES = [
  { slug: 'home', path: '/' },
  { slug: 'program', path: '/program/' },
  { slug: 'ptn-tka', path: '/ptn-tka/' },
  { slug: 'bimbel-sd-smp-sma', path: '/bimbel-sd-smp-sma/' },
  { slug: 'english-for-kids', path: '/english-for-kids/' },
  { slug: 'program-khusus', path: '/program-khusus/' },
  { slug: 'siapa-kami', path: '/siapa-kami/' },
  { slug: 'alamat-kontak-kami', path: '/alamat-kontak-kami/' },
  { slug: 'contact', path: '/contact/' },
];

async function capture() {
  console.log('🚀 Launching Chromium for baseline screenshots...');
  const browser = await chromium.launch();

  // Desktop (1440x900)
  const desktopContext = await browser.newContext({
    viewport: { width: 1440, height: 900 },
    deviceScaleFactor: 1,
  });
  const desktopPage = await desktopContext.newPage();

  // Mobile (390x844 - iPhone 14 standard)
  const mobileContext = await browser.newContext({
    viewport: { width: 390, height: 844 },
    deviceScaleFactor: 2,
    isMobile: true,
  });
  const mobilePage = await mobileContext.newPage();

  for (const p of PAGES) {
    const url = `${BASE_URL}${p.path}`;
    console.log(`📸 Capturing ${p.slug} (${url})...`);

    try {
      // Desktop full page
      await desktopPage.goto(url, { waitUntil: 'networkidle', timeout: 30000 });
      const desktopPath = path.join(SCREENSHOT_DIR, `${p.slug}-desktop-1440.png`);
      await desktopPage.screenshot({ path: desktopPath, fullPage: true });

      // Mobile full page
      await mobilePage.goto(url, { waitUntil: 'networkidle', timeout: 30000 });
      const mobilePath = path.join(SCREENSHOT_DIR, `${p.slug}-mobile-390.png`);
      await mobilePage.screenshot({ path: mobilePath, fullPage: true });

      console.log(`  ✓ ${p.slug} captured (Desktop & Mobile)`);
    } catch (e) {
      console.error(`  ✗ Error capturing ${p.slug}:`, e.message);
    }
  }

  await browser.close();
  console.log('✨ All baseline screenshots saved to docs/audit/screenshots/');
}

capture().catch(err => {
  console.error('Capture failed:', err);
  process.exit(1);
});
