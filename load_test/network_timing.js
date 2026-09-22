const puppeteer = require('puppeteer');
async function run() {
  const browser = await puppeteer.launch();
  const page = await browser.newPage();
  await page.setCacheEnabled(false);
  const start = Date.now();
  
  page.on('request', req => console.log(`[+${Date.now() - start}ms] REQ: ${req.url()}`));
  page.on('response', res => {
      const len = res.headers()['content-length'];
      console.log(`[+${Date.now() - start}ms] RES: ${res.url()} ${res.status()} ${len ? (len/1024).toFixed(1)+'KB' : ''}`);
  });

  await page.goto('https://tgm-test-bc447.web.app', { waitUntil: 'networkidle2', timeout: 60000 });
  await page.waitForSelector('flutter-view', { timeout: 30000 }).catch(() => {});
  console.log(`[+${Date.now() - start}ms] Load complete.`);
  await browser.close();
}
run();
