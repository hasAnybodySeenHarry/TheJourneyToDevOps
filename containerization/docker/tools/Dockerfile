# use golang:1.21-alpine as build stage base img
FROM golang:1.21-alpine AS build

# set working directory inside build container
WORKDIR /app

# copy dependency files into build container
COPY go.mod go.sum ./

# download and install dependencies
RUN go mod download

# copy the rest of the application code
COPY . .

# build the app
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

# use alpine:latest as build stage base img
FROM alpine:latest

# set working directory inside final container
WORKDIR /app

# copy the executable and scripts from build stage
COPY --from=build /app/main /app/scripts .

# expose the port
EXPOSE 3000

# command to run the app
CMD ["./main"]
