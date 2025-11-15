# Stage 1: Build
FROM node:18-alpine AS builder

# Set working directory inside the container
WORKDIR /app

# Copy dependency definitions
COPY package*.json ./

# Install dependencies
RUN npm install --force

# Copy the full source code
COPY . .

# Build the NestJS app (compiles TypeScript to JavaScript in dist/)
RUN npm run build

# Stage 2: Production dependencies
FROM node:18-alpine AS prod-deps

WORKDIR /app

COPY package*.json ./

RUN npm install --production --force

# Stage 3: Production container
FROM node:18-alpine

WORKDIR /app

# Copy built output from builder stage
COPY --from=builder /app/dist ./dist

# Copy only production node_modules
COPY --from=prod-deps /app/node_modules ./node_modules

# Expose port (optional, for documentation)
EXPOSE 3000

# Start the app
CMD ["node", "dist/main"]
