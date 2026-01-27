# Traccar-Timeline
Simple html single page web app for viewing Traccar API GPS data. Uses timeline-based interface for device movements including real-time and historical data.

[![Built with Claude](https://img.shields.io/badge/Built%20with-Claude%20AI-5A67D8)](https://claude.ai)

Just want to see it in action: **[Traccar-Timeline](https://iamdabe.github.io/Traccar-Timeline/src/traccar.html)** on github pages.

## Contents
- `src/traccar.html` - single page HTML/JS Traccar API timeline app.

## Features
* Real-time GPS tracking using Traccar API with live map updates
* Interactive timeline, click or drag to explore any historical time period
* Runs entirely in browser, no installation needed
* Customizable themes, device colors and Dark mode support
* Toggle device visibility or isolate individual devices
* Settings persistence (import/export as JSON)
* Movement-only tracks (configurable threshold)

## Preview
Screenshots from both mobile and desktop experierences.

#### Desktop

<div style="display:flex; flex-wrap:wrap; gap:15px;">

<a href="https://raw.githubusercontent.com/iamdabe/Traccar-Timeline/main/screenshots/desktop-dark-monthview.png">
  <img src="https://raw.githubusercontent.com/iamdabe/Traccar-Timeline/main/screenshots/desktop-dark-monthview.png" alt="Desktop Dark Month View" width="300">
</a>

<a href="https://raw.githubusercontent.com/iamdabe/Traccar-Timeline/main/screenshots/desktop-dark-settings.png">
  <img src="https://raw.githubusercontent.com/iamdabe/Traccar-Timeline/main/screenshots/desktop-dark-settings.png" alt="Desktop Dark Settings" width="300">
</a>

<a href="https://raw.githubusercontent.com/iamdabe/Traccar-Timeline/main/screenshots/desktop-dark.png">
  <img src="https://raw.githubusercontent.com/iamdabe/Traccar-Timeline/main/screenshots/desktop-dark.png" alt="Desktop Dark" width="300">
</a>

<a href="https://raw.githubusercontent.com/iamdabe/Traccar-Timeline/main/screenshots/desktop-light.png">
  <img src="https://raw.githubusercontent.com/iamdabe/Traccar-Timeline/main/screenshots/desktop-light.png" alt="Desktop Light" width="300">
</a>

</div>


#### Mobile

<div style="display:flex; flex-wrap:wrap; gap:15px;">

<a href="https://raw.githubusercontent.com/iamdabe/Traccar-Timeline/main/screenshots/mobile-dark-minimal.png">
  <img src="https://raw.githubusercontent.com/iamdabe/Traccar-Timeline/main/screenshots/mobile-dark-minimal.png" alt="Mobile Dark Minimal" width="200">
</a>

<a href="https://raw.githubusercontent.com/iamdabe/Traccar-Timeline/main/screenshots/mobile-dark-popup.png">
  <img src="https://raw.githubusercontent.com/iamdabe/Traccar-Timeline/main/screenshots/mobile-dark-popup.png" alt="Mobile Dark Popup" width="200">
</a>

<a href="https://raw.githubusercontent.com/iamdabe/Traccar-Timeline/main/screenshots/mobile-light-collapsed.png">
  <img src="https://raw.githubusercontent.com/iamdabe/Traccar-Timeline/main/screenshots/mobile-light-collapsed.png" alt="Mobile Light Collapsed" width="200">
</a>

<a href="https://raw.githubusercontent.com/iamdabe/Traccar-Timeline/main/screenshots/mobile-light-popup-geocode.png">
  <img src="https://raw.githubusercontent.com/iamdabe/Traccar-Timeline/main/screenshots/mobile-light-popup-geocode.png" alt="Mobile Light Popup Geocode" width="200">
</a>

<a href="https://raw.githubusercontent.com/iamdabe/Traccar-Timeline/main/screenshots/mobile-light.png">
  <img src="https://raw.githubusercontent.com/iamdabe/Traccar-Timeline/main/screenshots/mobile-light.png" alt="Mobile Light" width="200">
</a>

</div>



## Install
### Installation via Docker Compose


1. **Create project directory:**
```bash
   mkdir traccar-timeline && cd traccar-timeline
```

2. **Create `compose.yaml`:**
```yaml

  services:
    traccar-timeline:
      container_name: traccar-timeline
      image: ghcr.io/iamdabe/traccar-timeline:latest
      ports:
        - "80:80"
      restart: unless-stopped
      environment:
        # Nginx configuration
        - NGINX_HOST=localhost
        - NGINX_PORT=80
```

3. **Deploy:**
```bash
   docker-compose up -d
```

### No Install method
Download the `src/traccar.html` to your pc and load it your web browser - That's it! or visit https://iamdabe.github.io/Traccar-Timeline/src/traccar.html. No database, no config no extra fat needed! All settings saved to the browser.


**Note:** On first run a popup will show complaining about the Traccar API url. Head into settings and enter the URL to your traccar API. Ensure you complete with the trailing slash.


### CORS and traccar.xml
If you don't proxy your Traccar API (see Nginx proxy.conf below) you'll need to ensure your server CORS is configued correctly by editing your traccar.xml, example below: 
```
<properties>
    ~~~ other config vars ~~~
    <entry key='web.cors'>*</entry>
    <entry key='web.cors.credentials'>true</entry>
    <entry key='web.origin'>*</entry>
</properties>
```

### Nginx proxy
If you don't wish to expose your user/pass for your traccar server you can also use a nginx proxy by using a location conf. See example below. 
```
server {
    listen 80;
    server_name localhost;

    location / {
        root /usr/share/nginx/html;   
    }

    # Proxy requests to your Traccar API
    location /traccar/api/ {
        proxy_pass https://YOUR_TRACCAR_SERVER_ADDR/api/;
        proxy_http_version 1.1;

        # Standard headers
        proxy_set_header Host YOUR_TRACCAR_SERVER_ADDR;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;

        # Basic Auth
        proxy_set_header Authorization "Basic YOUR_TRACCAR_USER/PASS_BASE64_ENC";

        # SSL fix
        proxy_ssl_server_name on;
        proxy_ssl_verify off;
    }
}

```
 
## Third-Party
- Leaflet.js - BSD-2-Clause License
- OpenStreetMap - ODbL
- Traccar - Apache 2.0
- Font Awesome 6 Free - CC BY 4.0
