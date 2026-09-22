const puppeteer = require('puppeteer');

const pagesToTest = [
  '/',
  '/monetization',
  '/solutions',
  '/media-hub',
  '/gallery'
];

async function measureLoadTiming(url) {
  const browser = await puppeteer.launch();
  const page = await browser.newPage();
  
  await page.setCacheEnabled(false);

  const startTime = Date.now();
  await page.goto(url, { waitUntil: 'networkidle2', timeout: 60000 });
  
  // Wait for Flutter's main view container to be added to DOM
  await page.waitForSelector('flutter-view', { timeout: 30000 }).catch(() => {});
  
  const loadTime = Date.now() - startTime;
  
  await browser.close();
  return loadTime;
}

async function main() {
  console.log('Starting page load measurements...');
  for (const path of pagesToTest) {
    const url = `http://localhost:8081${path}`;
    try {
      console.log(`Testing ${url}...`);
      const timeMs = await measureLoadTiming(url);
      console.log(`✅ ${path} loaded in ${(timeMs / 1000).toFixed(2)} seconds`);
    } catch (e) {
      console.log(`❌ ${path} failed to load: ${e.message}`);
    }
  }
}

main();
