#
# Builder
#

FROM ubuntu:19.10 AS builder

LABEL org.opencontainers.image.vendor="NeuraLegion"
LABEL org.opencontainers.image.title="Broken crystals"
LABEL org.opencontainers.image.source="https://github.com/NeuraLegion/repeater"
LABEL org.opencontainers.image.authors="Bar Hofesh <bar.hofesh@neuralegion.com>, \
  Anatol Karalkou <anatol.karalkou@neuralegion.com>, \
  Sijawusz Pur Rahnama <sija@sija.pl>"

ARG DEBIAN_FRONTEND=noninteractive

ARG CRYSTAL_WORKERS=8
ENV CRYSTAL_WORKERS=$CRYSTAL_WORKERS

RUN apt-get update -qq --fix-missing
RUN apt-get install -y --no-install-recommends apt-utils ca-certificates curl gnupg libdbus-1-dev \
  build-essential libevent-dev libssl-dev libyaml-dev libgmp-dev git \
  libxml2 libxml2-dev libxslt1-dev build-essential patch zlib1g-dev liblzma-dev libevent-pthreads-2.1-6
RUN apt-key adv --fetch-keys "https://keybase.io/crystal/pgp_keys.asc"
RUN echo "deb https://dist.crystal-lang.org/apt crystal main" | tee /etc/apt/sources.list.d/crystal.list
RUN apt-get update -qq
RUN apt-get install -y --no-install-recommends crystal


# Create relevant directories
RUN mkdir -p /opt/broken_crystals

WORKDIR /opt/repeater

COPY src ./src
COPY spec ./spec
# COPY spec_integration ./spec_integration
COPY shard.yml ./

# Install dependencies
RUN shards install

# Build broken crystals
RUN shards build -p --error-trace -Dpreview_mt

#
# NexPloit
#

FROM ubuntu:19.10

ARG CRYSTAL_WORKERS=8
ENV CRYSTAL_WORKERS=$CRYSTAL_WORKERS

RUN apt-get update -qq --fix-missing && apt-get install -y --no-install-recommends \
  libevent-2.1 ca-certificates libevent-pthreads-2.1-6 curl

WORKDIR /opt/broken_crystals

COPY --from=builder /opt/broken_crystals/bin/broken_crystals /usr/bin/


ENTRYPOINT ["/usr/bin/broken_crystals"]
