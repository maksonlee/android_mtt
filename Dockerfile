FROM gcr.io/android-mtt/mtt:latest_20220608.000

RUN apt-get update \
    && apt-get install -y --allow-unauthenticated -q p7zip-full libssl-dev libffi-dev \
    && apt-get clean \
    && apt-get purge

ENV PYENV_ROOT="/root/.pyenv"
ENV PATH="/root/.pyenv/shims:/root/.pyenv/bin:$PATH"
RUN git clone https://github.com/pyenv/pyenv.git ~/.pyenv \
    && pyenv install 3.7.8

COPY ssh /root/.ssh
RUN chmod -R 600 /root/.ssh

COPY download_util.pyc /mtt/google3/third_party/py/multitest_transport/test_scheduler/download_util.pyc

RUN sed -i '/^gunicorn \"file_server.file_server/a \ \ \ \ --timeout 120 \\' /mtt/serve.sh
