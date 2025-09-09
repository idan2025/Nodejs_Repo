FROM node:20-alpine

WORKDIR /app

# Install deps (none here, but keeps caching pattern standard)
COPY package*.json ./
RUN npm install --omit=dev

# Copy app
COPY . .

EXPOSE 5000
CMD ["npm", "start"]
