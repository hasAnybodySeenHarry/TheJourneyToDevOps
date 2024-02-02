# build stage base image
FROM golang:1.17-alpine AS build

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

# final stage base image
FROM alpine:latest

# set working directory inside final container
WORKDIR /app

# copy only the executable and template from build stage
COPY --from=build /app/main /app/template.html .

# expose the port
EXPOSE 3000

# command to run the app
CMD ["./main"]
