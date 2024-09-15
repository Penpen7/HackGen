FROM ubuntu:22.04

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
WORKDIR /work
ENTRYPOINT ["./make_hackgen.sh"]
