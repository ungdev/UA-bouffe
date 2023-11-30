FROM node:20

ENV NODE_ENV=production
WORKDIR /srv/app
COPY ./ ./

# Generate /srv/app/db/seed.sql
CMD node seed/collector.mjs && cp seed.sql db/seed.sql
