FROM ubuntu:22.04 AS build

RUN apt-get update && apt-get -y --no-install-recommends install \
    ca-certificates \
    curl \
    fontforge \
    python2 \
    ttfautohint \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /pip2
RUN curl https://bootstrap.pypa.io/pip/2.7/get-pip.py -o get-pip.py \
    && python2 get-pip.py \
    && pip2 install --no-cache-dir fonttools==3.44.0 \
    && rm -rf /pip2

WORKDIR /work/bak
WORKDIR /work
COPY *.sh /work
COPY little_scripts /work/little_scripts
COPY hinting_post_processing /work/hinting_post_processing
# COPY source /work/source
RUN --mount=type=bind,source=./source,target=/work/source \
    /work/make_hackgen.sh

FROM scratch AS output
COPY --from=build /work/build /
