import * as React from "react";
import Box from "@mui/material/Box";
import TextField from "@mui/material/TextField";
import Button from "@mui/material/Button";
// import Paper from "@mui/material/Paper";
import Grid from "@mui/material/Grid";

import Axios from "axios";

import Table from "@mui/material/Table";
import TableBody from "@mui/material/TableBody";
import TableCell from "@mui/material/TableCell";
import TableContainer from "@mui/material/TableContainer";
import TableHead from "@mui/material/TableHead";
import TableRow from "@mui/material/TableRow";
// const { MongoClient } = require("mongodb");
import CircularProgress from "@mui/material/CircularProgress";

// const MONGO_USERNAME = process.env.NEXT_PUBLIC_MONGO_USERNAME;
// const MONGO_PASSWORD = process.env.NEXT_PUBLIC_MONGO_PASSWORD;
// const MONGO_DNS = process.env.NEXT_PUBLIC_MONGO_DNS;
// const MONGO_DATABASE = process.env.NEXT_PUBLIC_MONGO_DATABASE;

// const uri = `mongodb+srv://${MONGO_USERNAME}:${MONGO_PASSWORD}@${MONGO_DNS}/${MONGO_DATABASE}?retryWrites=true&w=majority`;
// const client = new MongoClient(uri, {
//   useNewUrlParser: true,
//   useUnifiedTopology: true
// });

export default function BasicTextFields() {
  const [album, setAlbum] = React.useState([]);
  const [loading, setLoading] = React.useState(false);
  const [uploading, setUploading] = React.useState(false);

  const inputHandler = (code) => {
    console.log(code);
  };

  const getAlbum = async () => {
    setLoading(true);
    Axios.get("http://localhost:3000/api/album")
      .then(function (response) {
        // handle success
        console.log(response.data.data["album"]);
        setAlbum(response.data.data["album"]);
      })
      .catch(function (error) {
        // handle error
        console.log(error);
      })
      .then(function () {
        // always executed
        setLoading(false);
      });
  };

  const uploadAlbum = (e) => {
    console.log("uploadAlbum");
    e.preventDefault();
    const name = e.target.name.value;
    const description = e.target.description.value;
    setUploading(true);

    Axios.post("http://localhost:3000/api/uploadImage", {
      array: [...album, { name: name, amount: 0, description: description }]
    })
      .then(function (response) {
        // handle success
        console.log(response.data);
        // setAlbum(response.data.data["album"]);
      })
      .catch(function (error) {
        // handle error
        console.log(error);
      })
      .then(function () {
        // always executed
        setUploading(false);
      });
  };

  return (
    <div>
      <Grid
        container
        sx={{ width: "100%", margin: "0 auto" }}
        direction="column"
        justifyContent="center"
        alignItems="center"
      >
        <Table sx={{ minWidth: 650 }} aria-label="simple table">
          <TableHead>
            <TableRow>
              <TableCell>Album Name</TableCell>
              <TableCell align="right">Description</TableCell>
            </TableRow>
          </TableHead>
          <TableBody>
            {album.map((row) => (
              <TableRow
                key={row.name}
                sx={{ "&:last-child td, &:last-child th": { border: 0 } }}
              >
                <TableCell component="th" scope="row">
                  {row.name}
                </TableCell>
                <TableCell align="right">{row.description}</TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>

        {loading ? <CircularProgress color="success" /> : null}
        <div style={{ margin: "20px" }}>
          <Button
            variant="contained"
            onClick={(e, name) => {
              e.preventDefault();

              getAlbum();
            }}
            type="submit"
            sx={{ margin: "20px" }}
          >
            Fetch Album
          </Button>
        </div>
        <Grid item xs={12}>
          <form
            onSubmit={async (e) => {
              uploadAlbum(e);
            }}
          >
            <TextField id="name" label="Name" variant="outlined" sx={{}} />
            <TextField
              id="description"
              label="Description"
              variant="outlined"
              sx={{}}
            />
            <Button
              variant="contained"
              // onClick={(e) => {
              //   e.preventDefault();
              //   console.log(e.target);
              //   // addAlbum(name);
              // }}
              type="submit"
              sx={{}}
            >
              addAlbum
            </Button>
          </form>
        </Grid>
        {uploading ? <CircularProgress color="success" /> : null}
      </Grid>
    </div>
  );
}
