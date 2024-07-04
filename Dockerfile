# Use recomended for MegaMek Java 11 distribution offcial image.
FROM eclipse-temurin:17.0.11_9-jre-jammy

# Set MegaMek version
ARG VERSION=0.49.19.1

RUN cd /srv && \
# Download desired MegaMek release
wget https://github.com/MegaMek/mekhq/releases/download/v${VERSION}/mekhq-${VERSION}.tar.gz && \
tar -zxvf mekhq-${VERSION}.tar.gz && \
rm mekhq-${VERSION}.tar.gz && \
mv mekhq-${VERSION} mekhq && \
# Make shared folder for custom assets to use it as Volume
mkdir -p /srv/shared/boards /srv/shared/images /srv/shared/mechfiles /srv/shared/scenarios /srv/shared/forcegenerator /srv/shared/mapgen /srv/shared/names /srv/shared/rat /srv/shared/sounds && \
ln -s /srv/shared/boards /srv/mekhq/data/boards/custom && \
ln -s /srv/shared/images /srv/mekhq/data/images/custom  && \
ln -s /srv/shared/mechfiles /srv/mekhq/data/mechfiles/custom && \
ln -s /srv/shared/scenarios /srv/mekhq/data/scenarios/custom && \
ln -s /srv/shared/forcegenerator /srv/mekhq/data/forcegenerator/custom && \
ln -s /srv/shared/mapgen /srv/mekhq/data/mapgen/custom && \
ln -s /srv/shared/names /srv/mekhq/data/names/custom && \
ln -s /srv/shared/rat /srv/mekhq/data/rat/custom && \
ln -s /srv/shared/sounds /srv/mekhq/data/sounds/custom

# Define Volume with shared custom assets
VOLUME ["/srv/shared"]
# Set server port. I suggest leaving it here, and changing diferent in docker port binding if desired.
EXPOSE 2346
# Set desired memory limit in megabytes and password
ENV MEMORY=768
ENV PASSWORD=megamek

WORKDIR srv/mekhq
CMD ["sh", "-c", "java -Xms${MEMORY}m -Xmx${MEMORY}m -jar MegaMek.jar -dedicated -port 2346 -password ${PASSWORD}"]
