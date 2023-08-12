# FROM node:alpine

# # RUN npm install -g yarn

# WORKDIR /usr/src/app

# # COPY package*.json ./
# COPY . .
# RUN yarn && yarn build

# EXPOSE 3000

# CMD ["yarn", "start"]


FROM node:alpine AS builder

USER node

RUN mkdir -p /home/node/app

WORKDIR /home/node/app

COPY --chown=node . .
# Building the production-ready application code - alias to 'nest build'
RUN yarn install --production && yarn build

FROM node:alpine

USER node

WORKDIR /home/node/app

COPY --from=builder --chown=node /home/node/app .

CMD [ "yarn", "start" ]