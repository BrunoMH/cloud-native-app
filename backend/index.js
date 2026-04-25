const express = require("express");
const app = express();

app.get("/hello", (req, res) => {
  res.json({ message: "Hello from backend 🚀" });
});

app.listen(3000, () => console.log("Running on port 3000"));
