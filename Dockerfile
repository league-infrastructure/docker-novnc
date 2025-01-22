FROM debian:bullseye

# Make windows open in the upper-left, so if the viewport for the screen 
# is smaller than the window, the window is not offscreen.
ENV SDL_VIDEO_WINDOW_POS=0,0 

# Make SDL not actually use the sound card.
ENV SDL_AUDIODRIVER=dummy

# Install git, supervisor, VNC, & X11 packages
RUN set -ex; \
    apt-get update; \
    apt-get install -y \
      bash \
      fluxbox \
      git \
      net-tools \
      novnc \
      supervisor \
      x11vnc \
      xterm \
      xvfb

# Setup demo environment variables
ENV HOME=/root \
    DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=C.UTF-8 \
    DISPLAY=:0.0 \
    DISPLAY_WIDTH=600 \
    DISPLAY_HEIGHT=600 \
    RUN_XTERM=no \
    RUN_FLUXBOX=yes
COPY . /app

RUN cp /usr/share/novnc/vnc_lite.html  /usr/share/novnc/index.html

CMD ["/app/entrypoint.sh"]
EXPOSE 6080
EXPOSE 5900
