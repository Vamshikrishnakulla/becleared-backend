import express from "express";
import bodyParser from "body-parser";
import pg from "pg";

//creating express app and assgining the port.
const app = express();
let port = 4000;

//connecting to the database.

const db = new pg.Client({
  user: "postgres",
  host: "localhost",
  database: "beclear",
  password: "Vamshi171", //need to change the password in production.
  port: 5432,
});
db.connect();

//middlewares

app.use(bodyParser.urlencoded({ extended: false }));
//check these for data parsing using above or below.
app.use(bodyParser.json());

//routes

//get categories to react.
app.get("/categories", async (req, res) => {
  let categories;
  let message = "categories retrived successfully.";
  try {
    let result = await db.query("SELECT * FROM category");
    categories = result.rows;
    //console.log(categories);
  } catch (err) {
    message = err.message;
    console.log("category's DB error " + message);
  }
  if (categories) {
    res.send(categories);
  } else {
    res.send(message);
  }
});

app.get("/category", async (req, res) => {
  let fetchId = req.query.id;
  let category;
  let message = "category retrived successfully.";
  try {
    let result = await db.query("SELECT * FROM category WHERE id=($1)", [
      fetchId,
    ]);
    category = result.rows;
    //console.log(category);
  } catch (err) {
    message = err.message;
    console.log("category's DB error " + message);
  }
  if (category) {
    res.send(category);
  } else {
    res.send(message);
  }
});

app.get("/threadLists", async (req, res) => {
  let fetchCatId = req.query.catId;
  let fetchThreadId = req.query.id;
  //console.log("catId " + fetchCatId + "threadId " + fetchThreadId);
  let threadLists;
  let message = "threadLists questions and description retrived successfully.";
  try {
    let sql;
    let fetchId;
    if (fetchThreadId) {
      sql =
        "select id, question, description, category_id, thread_list.date_time, user_id, user_name, email, user_thread_likes, user_thread_dislikes from thread_list left join users on user_id = _id where id = ($1)";
      fetchId = fetchThreadId;
    } else {
      sql =
        "select id, question, description, category_id, thread_list.date_time, user_id, user_name, email, user_thread_likes, user_thread_dislikes from thread_list left join users on user_id = _id where category_id = ($1)";
      fetchId = fetchCatId;
    }
    let result = await db.query(sql, [fetchId]);
    threadLists = result.rows;
    //console.log(threadLists);
  } catch (err) {
    message = err.message;
    console.log("threadList's DB error " + message);
  }
  if (threadLists) {
    res.send(threadLists);
  } else {
    res.send(message);
  }
});

// route to insert data into the thread_list table.
app.post("/threadLists", async (req, res) => {
  const question = req.body.question;
  const description = req.body.description;
  const category_id = req.body["category_id"];
  const userId = req.body["userId"];
  //console.log(req.body);
  let message = "data insertion successful in thread_list table";
  try {
    await db.query(
      "INSERT INTO thread_list (question, description, category_id, user_id) VALUES ($1, $2, $3, $4)",
      [question, description, category_id, userId]
    );
  } catch (err) {
    message = err.message;
    console.log(err.message + " thread_list insertion failed.");
  }
  console.log(message);
  res.send(message);
});

//route to get all the threads
app.get("/threads", async (req, res) => {
  const fetchId = req.query.id;
  //console.log("threadList id on threads " + fetchId);
  let threads;
  let message = "threads questions and description retrived successfully.";
  try {
    let result = await db.query(
      "select id, description, threads.date_time, user_id, user_name, email, user_thread_likes, user_thread_dislikes from threads left join users on user_id = _id where thread_list_id = ($1)",
      [fetchId]
    );
    threads = result.rows;
    //console.log(threads);
  } catch (err) {
    message = err.message;
    console.log("thread's DB error " + message);
  }
  if (threads) {
    res.send(threads);
  } else {
    res.send(message);
  }
});

// route to insert data into the threads table.
app.post("/threads", async (req, res) => {
  const description = req.body.description;
  const thread_list_id = req.body["thread_list_id"];
  const userId = req.body["userId"];
  //console.log(req.body);
  let message = "data insertion successful in threads table";
  try {
    await db.query(
      "INSERT INTO threads (description, thread_list_id, user_id) VALUES ($1, $2, $3)",
      [description, thread_list_id, userId]
    );
  } catch (err) {
    message = err.message;
    console.log(err.message + " thread_list insertion failed.");
  }
  console.log(message);
  res.send(message);
});

//checking the user data in the database.
app.post("/getuserdata", async (req, res) => {
  const userName = req.body.username;
  //const userEmail = req.query.email;
  const password = req.body.password;
  console.log("adding new user to the DB.");
  //console.log(req.body);
  const result = await db.query(
    "SELECT _id, user_name, email, user_thread_likes, user_thread_dislikes FROM users WHERE user_name = $1 AND user_password = $2",
    [userName, password]
  );
  //console.log(result.rows);
  res.send(result.rows);
});

//registering the user into the database.
app.post("/userdata", async (req, res) => {
  const userName = req.body["username"];
  const userEmail = req.body["email"];
  const password = req.body["password"];
  //console.log("adding new user with values " + userName + " " + userEmail + " " + password);
  const result = await db.query(
    "INSERT INTO users (user_name, email, user_password) VALUES ($1, $2, $3) RETURNING *",
    [userName, userEmail, password]
  );
  //console.log(result.rows);
  res.send("user registered succefully, Please continue to login.");
});

//search the queary
app.get("/search", async (req, res) => {
  const query = req.query.query;
  console.log(query);
  //console.log("threadList id on threads " + fetchId);
  let searchThreadLists;
  let message =
    "searching for the questions and description retrived successfully.";
  try {
    let result = await db.query(
      "select * from thread_list where to_tsvector(question || ' ' || coalesce(description, ' ')) @@ websearch_to_tsquery($1)",
      [query]
    );
    searchThreadLists = result.rows;
    //console.log(searchThreadLists);
  } catch (err) {
    message = err.message;
    console.log("threadList's DB error " + message);
  }
  if (searchThreadLists) {
    res.send(searchThreadLists);
  } else {
    res.send(message);
  }
});

//listening to the ports
app.listen(port, (err) => {
  if (!err) {
    console.log(`server started listening on port ${port}`);
  } else {
    console.log(err.message);
  }
});
