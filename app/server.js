const http = require("http");

const port = 3000;

const server = http.createServer((req, res) => {

  res.writeHead(200, {
    "Content-Type": "application/json"
  });

  res.end(JSON.stringify({
    message: "Hello from EKS!",
    hostname: require("os").hostname()
  }));

});


server.listen(port, () => {

  console.log(`Server running on port ${port}`);

});
