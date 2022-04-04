FROM debian:buster-slim

RUN apt-get update
RUN apt-get install -y --no-install-recommends make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm >
ENV HOME="/root"
WORKDIR ${HOME}
RUN apt-get install -y git
RUN git clone --depth=1 https://github.com/pyenv/pyenv.git .pyenv
ENV PYENV_ROOT="${HOME}/.pyenv"
ENV PATH="${PYENV_ROOT}/shims:${PYENV_ROOT}/bin:${PATH}"

ENV PYTHON_VERSION1=3.7.7
ENV PYTHON_VERSION2=2.7.18
RUN pyenv install ${PYTHON_VERSION1}
RUN pyenv global ${PYTHON_VERSION1}
RUN pyenv install ${PYTHON_VERSION2}

RUN git clone https://github.com/yyuu/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
RUN pip install virtualenv
RUN pyenv virtualenv 3.7.7 aws-cli
RUN pyenv virtualenv 2.7.18 dip-cli

RUN eval "$(pyenv init -)"
RUN eval "$(pyenv virtualenv-init -)"
