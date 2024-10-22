FROM ghcr.io/actions/actions-runner:2.320.0

COPY  scripts/tools.sh ./tools.sh
RUN sudo chmod +x *.sh
RUN ./tools.sh

RUN curl -fsSL https://deb.nodesource.com/setup_22.x
RUN apt-get update && apt-get install -y --no-install-recommends \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*

RUN node -v && npm -v
WORKDIR /app

RUN npx playwright install --with-deps && \
    npm install -D @playwright/test && \
    npm i create-playwright --quiet --with-deps && \
    npm install -g @usebruno/cli && \
    npm install -g dotenv-cli && \
    npm install -D typescript && \
    npm install --save @types/node

CMD ["/bin/bash"]