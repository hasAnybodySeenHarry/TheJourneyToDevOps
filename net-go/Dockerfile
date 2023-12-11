# Use the official Golang image
FROM golang:1.17-alpine

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the Go application files to the working directory
COPY go.mod .
COPY go.sum .

# Download and install dependencies
RUN go mod download

# Copy the rest of the application files
COPY . .

# Build the Go application
RUN go build -o main .

# Expose the application port
EXPOSE 3000

# Command to run the application
CMD ["./main"]
