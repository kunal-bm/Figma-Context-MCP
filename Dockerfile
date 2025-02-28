FROM node:20.17.0-alpine

# Create app directory
WORKDIR /app

# Install pnpm
RUN npm install -g pnpm

# Copy package files for better layer caching
COPY package.json pnpm-lock.yaml ./

COPY . .


# Install all dependencies
RUN pnpm install --no-frozen-lockfile

RUN pnpm prepare


# Expose the port specified in the environment variable (default: 3333)
EXPOSE ${PORT:-3333}

# Set environment variables
ENV NODE_ENV=production
ENV PORT=${PORT:-3333}
ENV FIGMA_API_KEY=${FIGMA_API_KEY}

# Start the server with proper error handling
CMD ["sh", "-c", "node dist/index.js || echo 'Server failed to start, check your environment variables and configuration'"] 