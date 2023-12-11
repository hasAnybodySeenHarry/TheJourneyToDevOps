# Build stage
FROM golang:1.17-alpine AS build

# Set the working directory inside the build container
WORKDIR /app

# Copy the Go dependency files into the build container
COPY go.mod go.sum ./

# Download and install Go dependencies
RUN go mod download

# Copy the rest of the application code
COPY . .

# Build the Go application
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

# Final stage
FROM alpine:latest

# Set the working directory inside the final container
WORKDIR /app

# Copy only the built executable from the build container
COPY --from=build /app/main /app/template.html .

# Expose the port that the application will run on
EXPOSE 3000

# Command to run the application
CMD ["./main"]

