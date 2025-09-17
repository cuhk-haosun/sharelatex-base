# Use the official ShareLaTeX image as base
FROM sharelatex/sharelatex:latest

# Switch to root to install packages
USER root

# Update tlmgr and install required TeX Live packages
RUN tlmgr update --self --all && \
    tlmgr install \
      ctex latexmk \
      collection-langchinese \
      collection-latexrecommended \
      collection-fontsrecommended 

      
RUN tlmgr install \
      siunitx caption subcaption float booktabs \
      tikz hyperref fancyhdr
      

# (Optional) Clean up tlmgr caches to reduce image size
##  # disables future backups, removes all existing backups
RUN tlmgr option -- autobackup 0 && tlmgr backup --clean --all


# Install system CJK font packages
RUN apt-get update && apt-get install -y --no-install-recommends \
      fonts-noto-cjk fonts-arphic-uming fonts-arphic-ukai \
      texlive-xetex texlive-luatex \
      fontconfig \
    && fc-cache -fv \
    && rm -rf /var/lib/apt/lists/*

# Expose default ShareLaTeX port (optional, inherited from base image)
EXPOSE 80

# (Optional) set entrypoint/cmd if you need to override base behavior
# CMD ["run"]

