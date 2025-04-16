# simple-time-service

A tiny microservice containing a web server that returns a pure JSON response of current date/time and visitor's IP address when its '/' URL path is accessed.

## How to Run

To run this application, either use `npm` or `docker`.

#### Using `npm`

```bash
npm install --only=production
node index.js
```

#### Using `docker`

```bash
docker build -t justnotmirr/simple-time-service .
docker run -p 3000:3000 justnotmirr/simple-time-service
```

After this, go to 'http://localhost:3000/' to access the application.