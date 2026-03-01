# Use a lightweight Node image
FROM node:18-alpine

# Create app directory
WORKDIR /app

# Copy dependency manifests and install dependencies reproducibly
COPY package*.json ./
RUN npm ci --only=production

# Copy app source
COPY . .

# Set production environment and use non-root user
ENV NODE_ENV=production
USER node

# Expose port and start
EXPOSE 3000
CMD ["npm", "start"]