const express = require("express");
const request = require("request");

const app = express();

function delayTimer(time) {
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve();
    }, time);
  });
}

/** 新闻列表 */
function getNewsLHandle(last_oid) {
  return new Promise((resolve) => {
    request(
      {
        method: "get",
        url: `https://opser.api.dgtle.com/v2/news/index?last_oid=${last_oid}`,
      },
      (err, response) => {
        if (err) {
          resolve([]);
        }
        resolve(response.body);
      }
    );
  });
}
app.get("/news", async (req, res) => {
  // const { last_oid = "" } = req.query;
  // console.log('target', last_oid)
  // await delayTimer(5000)
  // const resolve = await getNewsLHandle(last_oid)
  // res.send(resolve)
  res.send(require("./news.json"));
});

app.get("/live", (req, res) => {
  res.send(require("./live.json"));
});

app.get("/oneDayTalk", (req, res) => {
  res.send(require("./oneDayTalk.json"));
});

app.listen(3000, () => {
  console.log("service live in host 3000");
});
