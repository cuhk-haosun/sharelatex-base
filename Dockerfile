# Use the official ShareLaTeX image as base
FROM sharelatex/sharelatex:latest

# Switch to root to install packages
USER root

# Update tlmgr and install required TeX Live packages
RUN tlmgr update --self --all && \
    tlmgr install \
      ctex \
      collection-langchinese \
      collection-latexrecommended \
      collection-latexextra \
      collection-fontsrecommended \
      collection-fontsextra \
      latexmk

# (Optional) Clean up tlmgr caches to reduce image size
RUN tlmgr clean --all

# Switch back to the sharelatex user
USER sharelatex

# Expose default ShareLaTeX port (optional, inherited from base image)
EXPOSE 80

# (Optional) set entrypoint/cmd if you need to override base behavior
# CMD ["run"]

