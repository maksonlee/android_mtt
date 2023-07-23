FROM gcr.io/android-mtt/mtt:prod_1.45.000

COPY download_util.py /tmp/download_util.py

RUN set -x \
    && cd /tmp \
    && python3 -m compileall -bq ./download_util.py \
    && cp ./download_util.pyc /mtt/google3/third_party/py/multitest_transport/test_scheduler/download_util.pyc \
    && apt-get update \
    && apt-get install -y p7zip-full \
    && rm -rf /tmp/*
