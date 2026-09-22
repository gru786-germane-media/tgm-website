const puppeteer = require('puppeteer');

async function analyzeLiveSite() {
  const url = 'https://tgm-test-bc447.web.app';
  console.log(`Analyzing live site: ${url}...`);

  const browser = await puppeteer.launch();
  const page = await browser.newPage();
  
  await page.setCacheEnabled(false);

  let totalBytes = 0;
  const largeRequests = [];
  let mainDartJsSize = 0;
  let chunkFilesCount = 0;

  page.on('response', async (response) => {
    try {
      const url = response.url();
      const status = response.status();
      const headers = response.headers();
      const contentLength = headers['content-length'] ? parseInt(headers['content-length'], 10) : 0;
      
      if (contentLength > 0) {
        totalBytes += contentLength;
      }

      const sizeMb = (contentLength / (1024 * 1024)).toFixed(2);
      
      if (contentLength > 1024 * 500) { // Larger than 500KB
        largeRequests.push({ url, sizeMb });
      }

      if (url.includes('main.dart.js')) {
        mainDartJsSize = sizeMb;
      } else if (url.includes('.part.js')) {
        chunkFilesCount++;
      }
    } catch (e) {
      // Ignore
    }
  });

  const startTime = Date.now();
  
  try {
    await page.goto(url, { waitUntil: 'networkidle2', timeout: 60000 });
    // Wait for Flutter Web app to initialize
    await page.waitForSelector('flutter-view', { timeout: 30000 }).catch(() => {});
    
    const loadTime = Date.now() - startTime;
    
    console.log('\n--- Analysis Results ---');
    console.log(`✅ Total Load Time: ${(loadTime / 1000).toFixed(2)} seconds`);
    console.log(`📦 Total Downloaded: ${(totalBytes / (1024 * 1024)).toFixed(2)} MB`);
    console.log(`📄 main.dart.js size: ${mainDartJsSize} MB`);
    console.log(`🧩 Deferred Chunks (.part.js) downloaded: ${chunkFilesCount}`);
    
    console.log('\n⚠️ Large Files (> 500KB):');
    largeRequests.sort((a, b) => b.sizeMb - a.sizeMb).forEach(req => {
      console.log(`- ${req.sizeMb} MB : ${req.url}`);
    });
    
  } catch (e) {
    console.error('❌ Error during analysis:', e.message);
  } finally {
    await browser.close();
  }
}

analyzeLiveSite();
