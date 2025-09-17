# ----------------------------------------------------------------------
# Base image – ShareLaTeX/Overleaf CE
# ----------------------------------------------------------------------
FROM sharelatex/sharelatex:latest

# ----------------------------------------------------------------------
# Become root – tlmgr & apt-get need it
# ----------------------------------------------------------------------
USER root

# ----------------------------------------------------------------------
# Update tlmgr & package database
# ----------------------------------------------------------------------
RUN tlmgr update --self --all

# ----------------------------------------------------------------------
# tlmgr install (1/3): core engines/tools + LaTeX recommended
# ----------------------------------------------------------------------
RUN tlmgr install \
      latexmk ctex fontspec \
      collection-latexrecommended

# ----------------------------------------------------------------------
# tlmgr install (2/3): graphics, tables, fonts
# ----------------------------------------------------------------------
RUN tlmgr install \
      collection-latexextra \
      collection-pictures \
      collection-fontsrecommended

# ----------------------------------------------------------------------
# tlmgr install (3/3): languages + bibliography tooling
# ----------------------------------------------------------------------
RUN tlmgr install \
      collection-langchinese \
      collection-langfrench \
      collection-langitalian \
      collection-bibtexextra \
      biber

# ----------------------------------------------------------------------
# Clean tlmgr caches
# ----------------------------------------------------------------------
RUN tlmgr option -- autobackup 0 && \
    tlmgr backup --clean --all || echo "No tlmgr backups to clean"


# ----------------------------------------------------------------------
# System fonts & tools used by LaTeX runs
# - CJK system fonts for fontspec/xeCJK
# - Inkscape for the 'svg' package (used at build time)
# ----------------------------------------------------------------------
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        fonts-noto-cjk \
        fonts-arphic-uming \
        fonts-arphic-ukai \
        inkscape \
        fontconfig && \
    fc-cache -fv && \
    rm -rf /var/lib/apt/lists/*

# ----------------------------------------------------------------------
# Expose ShareLaTeX web UI
# ----------------------------------------------------------------------
EXPOSE 80
