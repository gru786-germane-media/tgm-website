import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: HtmlWidget('''<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-widtha, initial-scale=1.0">
<title>Dark Theme Sidebar</title>
<style>
  body {
    margin: 0;
    font-family: "Inter", sans-serif;
    background-color: #121212;
    color: #e0e0e0;
  }

  .sidebar {
    width: 310px;
    flex-shrink: 0px;
    background-color: #1e1e1e;
    height: 100vh;
    padding: 20px;
    box-sizing: border-box;
    border-right: 1px solid #333;
    overflow-y: auto;
  }

  .menu-item {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 8px 0;
    user-select: none;
    transition: color 0.2s ease;
  }

  .menu-item a {
    text-decoration: none;
    color: inherit;
  }

  .menu-item:hover {
    color: #4fc3f7;
  }

  .submenu {
    margin-left: 20px;
    display: none;
    border-left: 1px solid #333;
    padding-left: 10px;
  }

  .submenu.open {
    display: block;
  }

  .arrow {
    cursor: pointer;
    transition: transform 0.3s ease;
  }

  .arrow.open {
    transform: rotate(90deg);
  }

  .powered {
    margin-top: 20px;
    font-size: 12px;
    text-align: center;
    color: #999;
    border-top: 1px solid #333;
    padding-top: 10px;
  }

  /* ACTIVE HIGHLIGHT STYLES */
  .active-link {
    color: #4fc3f7 !important;
    font-weight: 600;
  }
  .active-item {
    background: #2a2a2a;
    padding: 6px 8px;
    border-radius: 6px;
  }
</style>
</head>

<body>

  <div class="sidebar">

    <div class="menu-item">
      <span><a href="https://thegermanemedia.com/custom-adapter-sdk/">📘 Custom Adapter Integration</a></span>
    </div>

    <!-- Mediation Partners -->
    <div class="menu-item">
      <span><a href="https://thegermanemedia.com/mediation-partners/">📡 Mediation Partners</a></span>
      <span class="arrow" onclick="toggleMenu('partners', this)">▶</span>
    </div>

    <div id="partners" class="submenu">
      
      <!-- Google Ad Manager -->
      <div class="menu-item">
        <span><a href="https://thegermanemedia.com/google-ad-manager/">🖥️ Google Ad Manager</a></span>
        <span class="arrow" onclick="toggleMenu('google', this)">▶</span>
      </div>

      <div id="google" class="submenu">
        <div class="menu-item"><span><a href="https://thegermanemedia.com/google-ad-manager-banner/">• Banner</a></span></div>

        <div class="menu-item"><span><a href="https://thegermanemedia.com/google-ad-manager-interstitial/">• Interstitial</a></span></div>

        <div class="menu-item"><span><a href="https://thegermanemedia.com/google-ad-manager-rewarded/">• Rewarded</a></span></div>
        <div class="menu-item"><span><a href="https://thegermanemedia.com/google-ad-manager-native/">• Native</a></span></div>
      </div>

      <!-- AdMob -->
      <div class="menu-item">
        <span><a href="https://thegermanemedia.com/admob/">🖥️ AdMob</a></span>
        <span class="arrow" onclick="toggleMenu('admob', this)">▶</span>
      </div>

      <div id="admob" class="submenu">
        <div class="menu-item"><span><a href="https://thegermanemedia.com/admob-banner/">• Banner</a></span></div>
        <div class="menu-item"><span><a href="https://thegermanemedia.com/admob-interstitial/">• Interstitial</a></span></div>
        <div class="menu-item"><span><a href="https://thegermanemedia.com/admob-rewarded/">• Rewarded</a></span></div>
        <div class="menu-item"><span><a href="https://thegermanemedia.com/admob-native/">• Native</a></span></div>
      </div>

      <!-- Applovin -->
      <div class="menu-item">
        <span><a href="https://thegermanemedia.com/applovin/">🖥️ Applovin</a></span>
        <span class="arrow" onclick="toggleMenu('applovin', this)">▶</span>
      </div>

      <div id="applovin" class="submenu">
        <div class="menu-item"><span><a href="https://thegermanemedia.com/applovin-banner/">• Banner</a></span></div>
        <div class="menu-item"><span><a href="https://thegermanemedia.com/applovin-mrec/">• MREC</a></span></div>
        <div class="menu-item"><span><a href="https://thegermanemedia.com/applovin-interstitial/">• Interstitial</a></span></div>
        <div class="menu-item"><span><a href="https://thegermanemedia.com/applovin-rewarded/">• Rewarded</a></span></div>
      </div>

      <!-- Ironsource -->
      <div class="menu-item">
        <span><a href="https://thegermanemedia.com/ironsource-levelplay/">🖥️ Ironsource - LevelPlay</a></span>
      </div>

    </div>

    <div class="powered">⚡ Powered by GitBook</div>
  </div>

<script>
  function toggleMenu(id, arrow) {
    const menu = document.getElementById(id);
    menu.classList.toggle("open");
    arrow.classList.toggle("open");
  }

  /* AUTO-HIGHLIGHT ACTIVE PAGE */
  document.addEventListener("DOMContentLoaded", () => {
    const current = window.location.href;

    document.querySelectorAll(".menu-item a").forEach(link => {
      if (link.href === current) {

        // highlight text
        link.classList.add("active-link");

        // highlight menu box
        const item = link.closest(".menu-item");
        if (item) item.classList.add("active-item");

        // open parent submenu
        const submenu = link.closest(".submenu");
        if (submenu) submenu.classList.add("open");

        // rotate its arrow
        const arrow = submenu?.previousElementSibling?.querySelector(".arrow");
        if (arrow) arrow.classList.add("open");

        // always open main menu
        const partnersMenu = document.getElementById("partners");
        partnersMenu.classList.add("open");

        const partnersArrow = document.querySelector("[onclick=\"toggleMenu('partners', this)\"]");
        if (partnersArrow) partnersArrow.classList.add("open");
      }
    });
  });
</script>

</body>
</html>''', renderMode: RenderMode.column),
          ),

          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              child: HtmlWidget('''<!DOCTYPE html>
            <html lang="en">
            <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Custom Adapter Integration</title> 
            <style>
              body {
                font-family: "Inter", sans-serif;
                background-color: #121212;
                color: #e0e0e0;
                margin: 0;
                /padding: 40px;/
                line-height: 1.6;
              }
            
              h1 {
                display: flex;
                align-items: center;
                font-size: 1.8rem;
                color: #fff;
              }
            
              h1 img {
                width: 28px;
                height: 28px;
                margin-right: 10px;
              }
            
              p {
                color: #cfcfcf;
                margin-bottom: 24px;
              }
            
              .box {
                background-color: #1e1e1e;
                border: 1px solid #333;
                border-radius: 6px;
                padding: 16px 20px;
                margin-bottom: 30px;
              }
            
              .box-title {
                font-weight: 600;
                margin-bottom: 10px;
                color: #4fc3f7;
              }
            
              ul {
                margin: 0;
                padding-left: 20px;
              }
            
              li {
                margin-bottom: 6px;
              }
            
              h2 {
                font-size: 1.4rem;
                color: #fff;
                margin-top: 40px;
              }
            
              /h3 {/
              /*  font-size: 1rem;*/
              /*  color: #fff;*/
              /*  margin-top: 20px;*/
              /}/
            
              code {
                background-color: #2a2a2a;
                color: #ffcc80;
                padding: 2px 6px;
                border-radius: 4px;
                font-size: 0.95rem;
                font-family: "Consolas", monospace;
              }
            
              pre {
                background-color: #1e1e1e;
                color: #cfcfcf;
                padding: 14px;
                border-radius: 6px;
                border: 1px solid #333;
                overflow-x: auto;
                font-family: "Consolas", monospace;
                font-size: 0.95rem;
              }
            
              .copy-btn {
                background-color: #333;
                color: #bbb;
                border: 1px solid #444;
                border-radius: 4px;
                padding: 4px 10px;
                font-size: 0.8rem;
                cursor: pointer;
                float: right;
                transition: all 0.2s ease;
              }
            
              .copy-btn:hover {
                background-color: #4fc3f7;
                color: #000;
              }
            
              .header-row {
                display: flex;
                align-items: center;
                justify-content: space-between;
              }
            
              details {
                background-color: #1e1e1e;
                border: 1px solid #333;
                border-radius: 6px;
                margin-top: 15px;
                padding: 10px 14px;
              }
            
              summary {
                cursor: pointer;
                list-style: none;
                font-weight: 600;
                color: #fff;
              }
            
              summary::marker {
                display: none;
              }
            
              summary::-webkit-details-marker {
                display: none;
              }
            
              summary:before {
                content: '▶';
                display: inline-block;
                margin-right: 8px;
                transition: transform 0.2s ease;
              }
            
              details[open] summary:before {
                transform: rotate(90deg);
              }
            
              hr {
                border: 0;
                border-top: 1px solid #333;
                margin: 30px 0;
              }
              .container {
                max-width: 800px;
                /margin: 40px auto;/
                padding: 20px 30px;
                background-color: #1e1e1e;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0,0,0,0.4);
              }
              .box {
                background-color: #2c2c2c;
                border-left: 4px solid #4fc3f7;
                padding: 10px 15px;
                margin: 15px 0;
                border-radius: 4px;
                color: #ccc;
              }
               /* Card */
                .nav-card {
                    flex: 1;
                    min-width: 240px;
                    background: #1e1e1e;
                    border: 1px solid #333;
                    border-radius: 10px;
                    padding: 18px 22px;
                    text-decoration: none;
                    color: #e0e0e0;
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    transition: background 0.2s ease, border-color 0.2s ease;
                }
            
                .nav-card:hover {
                    background: #252525;
                    border-color: #60a5fa;
                }
            
                .nav-label {
                    font-size: 12px;
                    color: #9ca3af;
                    margin-bottom: 4px;
                    display: block;
                }
            
                .nav-title {
                    font-size: 18px;
                    font-weight: 600;
                    color: #fff;}
                    
                .arrow {
                    font-size: 20px;
                    color: #60a5fa;}
                    
                .code-box pre {
                margin: 0;
                padding: 16px;
                overflow-x: auto;
                color: #f7d774;
                background: #181818;
                border-radius: 8px;
                }
                .copy-btn {
                position: absolute;
                top: 8px;
                right: 10px;
                background: #2a2a2a;
                border: 1px solid #444;
                color: #ccc;
                padding: 5px 10px;
                font-size: 12px;
                border-radius: 6px;
                cursor: pointer;
                transition: 0.2s;
            }
            
            .copy-btn:hover {
                background: #333;
                color: #4fc3f7;
            }
            .code-box {
                position: relative;
                background: #1e1e1e;
                border: 1px solid #333;
                border-radius: 8px;
                margin: 20px 0;
            }
            </style>
            </head>
            <body>
            <div class="container">
              <div class="header-row">
                <h2>📱 Custom Adapter Integration</h2>
                <!--<button class="copy-btn">Copy</button>-->
              </div><br>
            
              <p>
                This document will guide you through an easy-to-follow process of adding 
                <strong>TGM</strong> as your third-party ad network mediation partner 
                for your mobile banner, interstitial, and rewarded ads.
              </p>
            
              <div class="box">
                <div class="box-title">📋 App Prerequisite</div>
                <ul>
                  <li>minSdkVersion of 21 or higher</li>
                  <li>compileSdkVersion of 33 or higher</li>
                </ul>
              </div>
            
              <h2>Configuration Steps</h2><br>
              <h5>Setting Up Repository in Project (Android Non-Unity)</h5><br>
              <ul>
                <li>Open your Android Studio project and navigate to 
            <code>settings.gradle</code> file.</li>
            
                <li>Add the following Maven repository configuration inside the dependencyResolutionManagement block.</li>
              </ul>
              <div class="code-box">
                <button class="copy-btn">Copy</button>
                <pre><code>gradle
            repositories {
              ...
              maven {
                url = uri("https://maven.pkg.github.com/germane-ca/orchestration-sdk")
                credentials {
                  username = GITHUB_USERNAME
                  password = GITHUB_TOKEN
                }
              }
            }</code></pre>
            </div><br>
            <h5>Setting Up Repository in Project (Android Unity)</h5><br>
              <ol>
                  <li>Go to Project Settings > Player > Android > Publishing Settings > Build and select :<br>
            Custom Main Gradle Template<br>
            Custom 
            Main Settings Template
            </li>
            <li>Open the<code>mainTemplate.gradle</code> file.</li>
                <li>Find the dependencies block from below and add the SDK dependency.
            <code>implementation 'com.tgm:customadapter:2.2.1'</code></li>
            <li>Open the <code>settingsTemplate.gradle</code> file.</li>
            
                <li>Add the following Maven repository configuration inside the dependencyResolutionManagement block :
            </li>
              </ol>
              <div class="code-box">
                <button class="copy-btn">Copy</button>
                <pre><code>repositories {
              maven {
                url = uri("https://maven.pkg.github.com/germane-ca/orchestration-sdk")
                credentials {
                  username = "username"
                  password = "password"
                }
              }
            }
            </code></pre>
            </div><br>
            <div class="box">
                <p>📋 Replace GITHUB\_USERNAME and GITHUB\_TOKEN with your GitHub username and personal access token (create a classic token with read only access from your personal GitHub profile OR reach out to us to get an TGM token)</p></div>
            
              <h5>Adding Dependency</h5><br>
              <ul>
                <li>Open the <code>build.gradle</code> (Module: app) file.</li>
                <li>Find the dependencies block and add the following SDK dependency.</li>
              </ul>
            
              <!-- Collapsible Dependency Sections -->
              <details>
                <summary>Google Ad Manager</summary>
                <pre><code>dependencies {
                implementation 'com.tgm:customadapter:2.2.1'}
            }
            </code></pre>
              </details>
            
              <details>
                <summary>ADMob</summary>
                <pre><code>dependencies {
                implementation 'com.tgm:customadapter:2.2.1'}
            }
            </code></pre>
              </details>
            
              <details>
                <summary>AppLovin</summary>
                <pre><code>dependencies {
                implementation "com.tgm:customadapter-applovin:2.2.1"
            }
            </code></pre>
              </details>
            
              <details>
                <summary>IronSource</summary>
                <pre><code>dependencies {
                implementation 'com.tgm:customadapter-ironsource:2.0.0.1'
            }</code></pre>
              </details>
            <br>
            <h5>Authentication</h5><br>
            <ul>
                <li>It's crucial not to hardcode GitHub credentials. Store credentials in
            <code>gradle.properties</code>  or use environment variables.</li>
            
                <li>In
            <code>gradle.properties,</code> add</li>
              </ul>
              <div class="code-box">
                <button class="copy-btn">Copy</button>
                <pre><code>properties:
            GITHUB_USERNAME=username
            GITHUB_TOKEN=token
            </code></pre>
            </div>
            <ul>
                <li>In
            <code>settings.gradle</code>  reference these properties:</li>
            </ul>
            <div class="code-box">
                <button class="copy-btn">Copy</button>
                <pre><code>gradle:<br>
            username = findProperty("GITHUB_USERNAME") ?: System.getenv("GITHUB_USERNAME")
            password = findProperty("GITHUB_TOKEN") ?: System.getenv("GITHUB_TOKEN")
            
            </code></pre>
            </div>
            <div class="box">
                <p>📋 Note: This approach enhances security by keeping credentials out of source control.</p></div>
            </div>
            <br>
            <div class="nav-container">
            
                <!-- Next Card -->
                <a href="https://thegermanemedia.com/mediation-partners/" class="nav-card">
                    <span>
            <span class="nav-label">Next</span>
            <span class="nav-title">Mediation Partners</span>
                    </span>
                    <span class="arrow">→</span>
                </a>
            
            </div>
            <script>
            document.querySelectorAll(".copy-btn").forEach(button => {
                button.addEventListener("click", () => {
            
                    // Find <code> inside the same container
                    const codeBox = button.closest(".code-box");
                    const codeElement = codeBox.querySelector("code");
            
                    // Copy the text
                    navigator.clipboard.writeText(codeElement.innerText.trim());
            
                    // Change button text
                    button.innerText = "Copied!";
                    button.style.color = "#4fc3f7";
            
                    // Revert back after delay
                    setTimeout(() => {
            button.innerText = "Copy";
            button.style.color = "#ccc";
                    }, 1200);
                });
            });
            </script>
            
            <br>
            </body>
            </html>''', renderMode: RenderMode.column),
            ),
          ),
        ],
      ),
    );
  }
}
