FROM node:18-slim

# add curl for healthcheck
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    curl \
    tini \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# have nodemon available for local dev use (file watching)
RUN npm install -g nodemon

COPY package*.json ./

RUN npm ci \
 && npm cache clean --force \
 && mv /app/node_modules /node_modules

COPY . .

ENV PORT 80
EXPOSE 80

ENTRYPOINT ["/usr/bin/tini", "--"]      # 引入tini, 使用tini来启动node，防止产生僵尸进程
CMD ["node", "server.js"]               # node进程不会响应SIGTERM/SIGINIT


# 1. 容器启动时候，带了init进程，作为systemd
# docker run -it --init node

# # Add Tini
# ENV TINI_VERSION v0.19.0
# ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
# RUN chmod +x /tini
# ENTRYPOINT ["/tini", "--"]

# # Run your program under Tini
# CMD ["/your/program", "-and", "-its", "arguments"]
# # or docker run your-image /your/program ...