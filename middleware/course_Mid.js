async function AddCourse(req, res, next) {
  let name = addSlashes(req.body.name); // a' or (drop table courses --
  let Query = `INSERT INTO courses( name) VALUES ('${name}')`;
  const promisePool = db_pool.promise();
  let rows = [];
  try {
    [rows] = await promisePool.query(Query);
  } catch (err) {
    console.log(err);
  }

  next();
}
async function UpdateCourse(req, res, next) {
  let id = parseInt(req.params.id);
  if (id <= 0) {
    req.GoodOne = false;
    return next();
  }
  req.GoodOne = true;
  let name = addSlashes(req.body.name); // a' or (drop table courses --
  let Query = `UPDATE courses SET name='${name}' WHERE id='${id}'`;
  const promisePool = db_pool.promise();
  let rows = [];
  try {
    [rows] = await promisePool.query(Query);
  } catch (err) {
    console.log(err);
  }

  next();
}
async function GetAllCourses(req, res, next) {
  let filter = req.query.filter || "";
  let page = req.query.p ? parseInt(req.query.p) : 0;
  let rowPerPage = 2; // Adjust as needed

  let wh = "";
  if (filter !== "") {
    wh += ` WHERE name LIKE '%${filter}%'`;
  }

  if (req.user_id !== undefined) {
    wh += wh === "" ? " WHERE " : " AND ";
    wh += `id IN (SELECT crs_id FROM crs2user WHERE user_id=${req.user_id})`;
  }

  const promisePool = db_pool.promise();

  // --- count total ---
  let countQuery = `SELECT COUNT(*) as cnt FROM courses ${wh}`;
  let total_rows = 0;
  try {
    const [countRows] = await promisePool.query(countQuery);
    total_rows = countRows[0].cnt;
  } catch (err) {
    console.log(err);
  }

  // --- actual query ---
  let Query = `SELECT * FROM courses ${wh} LIMIT ${
    page * rowPerPage
  }, ${rowPerPage}`;
  req.courses_data = [];
  req.page = page;
  req.total_pages = Math.floor(total_rows / rowPerPage);

  try {
    const [rows] = await promisePool.query(Query);
    req.courses_data = rows;
  } catch (err) {
    console.log(err);
  }

  next();
}

async function GetOneCourse(req, res, next) {
  let id = parseInt(req.params.id);
  console.log(id);
  if (id === NaN || id <= 0) {
    req.GoodOne = false;
    return next();
  }
  req.GoodOne = true;
  let Query = `SELECT * FROM courses  WHERE id='${id}' `;
  const promisePool = db_pool.promise();
  let rows = [];
  req.one_course_data = [];
  try {
    [rows] = await promisePool.query(Query);
    if (rows.length > 0) {
      req.one_course_data = rows[0];
    }
  } catch (err) {
    console.log(err);
  }

  next();
}
async function DeleteCourse(req, res, next) {
  let id = parseInt(req.body.id);
  if (id > 0) {
    let Query = `DELETE FROM courses WHERE id='${id}' `;
    const promisePool = db_pool.promise();
    let rows = [];
    try {
      [rows] = await promisePool.query(Query);
    } catch (err) {
      console.log(err);
    }
  }

  next();
}
module.exports = {
  AddCourse,
  GetAllCourses,
  GetOneCourse,
  DeleteCourse,
  UpdateCourse,
};
