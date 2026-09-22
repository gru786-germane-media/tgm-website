const puppeteer = require('puppeteer');

async function measureNavigationLatency(url) {
  const browser = await puppeteer.launch();
  const page = await browser.newPage();
  
  await page.setCacheEnabled(false);

  console.log(`Connecting to ${url}...`);
  await page.goto(url, { waitUntil: 'networkidle2', timeout: 60000 });
  await page.waitForSelector('flutter-view', { timeout: 30000 }).catch(() => {});
  
  console.log('--- Navigating to /monetization ---');
  let startTime = Date.now();
  
  // Click on monetization link (assuming header or navigation exists)
  // Let's directly navigate to trigger deferred loading network fetch as a test
  await page.goto(`${url}monetization`, { waitUntil: 'networkidle2', timeout: 60000 });
  
  let loadTime = Date.now() - startTime;
  console.log(`Navigation to /monetization took ${(loadTime / 1000).toFixed(2)} seconds`);
  
  console.log('--- Navigating to /solutions ---');
  startTime = Date.now();
  await page.goto(`${url}solutions`, { waitUntil: 'networkidle2', timeout: 60000 });
  loadTime = Date.now() - startTime;
  console.log(`Navigation to /solutions took ${(loadTime / 1000).toFixed(2)} seconds`);

  await browser.close();
}

measureNavigationLatency('http://localhost:8081/');
