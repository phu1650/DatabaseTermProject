// Next.js API route support: https://nextjs.org/docs/api-routes/introduction
const { MongoClient, ObjectID } = require("mongodb");

const MONGO_USERNAME = process.env.NEXT_PUBLIC_MONGO_USERNAME;
const MONGO_PASSWORD = process.env.NEXT_PUBLIC_MONGO_PASSWORD;
const MONGO_DNS = process.env.NEXT_PUBLIC_MONGO_DNS;
const MONGO_DATABASE = process.env.NEXT_PUBLIC_MONGO_DATABASE;

const uri = `mongodb+srv://${MONGO_USERNAME}:${MONGO_PASSWORD}@${MONGO_DNS}/${MONGO_DATABASE}?retryWrites=true&w=majority`;

export default async function handler(req, res) {
  const client = new MongoClient(uri, {
    useNewUrlParser: true,
    useUnifiedTopology: true
  });

  const data = await new Promise((resolve) => {
    client.connect(async () => {
      const collection = client.db("outstagram").collection("user");
      const result = await collection.findOneAndUpdate(
        {
          _id: ObjectID("6194b6dc5aabbf1ef4b3673d")
        },
        { $set: { album: req.body.array } }
      );

      resolve(result);
      client.close();
    });
  });

  if (data) {
    res.status(200).json({ message: "fetch data successfully", data: data });
  } else {
    res.status(200).json({ message: "fetch data error" });
  }
}
