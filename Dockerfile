FROM zenika/alpine-chrome

LABEL maintainer="Gitai <i@gitai.me>"

ARG TZ="Asia/Shanghai"

RUN mkdir -p /data && adduser -D chrome \
    && chown -R chrome:chrome /data
    
USER chrome

EXPOSE 9222

# chrome launch flag https://peter.sh/experiments/chromium-command-line-switches/
ENTRYPOINT [ "chromium-browser", \
  "--headless", "--no-sandbox", "--disable-gpu", \
  "--remote-debugging-address=0.0.0.0", \
  "--remote-debugging-port=9222", \
  "--disable-dev-shm-usage", \
  "--window-size=1920,1080", \
  # Disable various background network services, including extension updating,
  #   safe browsing service, upgrade detector, translate, UMA
  "--disable-background-networking", \
  # Disable installation of default apps on first run
  "--disable-default-apps", \
  # Disable all chrome extensions entirely
  "--disable-extensions", \
  # Disable syncing to a Google account
  "--disable-sync", \
  # Disable chrome pop-up notifications which cover the page
  "--disable-notifications", \
  # Disable built-in Google Translate service
  "--disable-translate", \
  # Hide scrollbars on generated images/PDFs
  "--hide-scrollbars", \
  # Disable reporting to UMA, but allows for collection
  "--metrics-recording-only", \
  # Mute audio
  "--mute-audio", \
  # Skip first run wizards
  "--no-first-run", \
  # Disable fetching safebrowsing lists, likely redundant due to disable-background-networking
  "--safebrowsing-disable-auto-update", \
  # set user data path
  "--user-data-dir=/data" \
]
