import express from "express";
import cors from "cors";
import router from "./routes/index";
import { errorHandler } from "./middlewares/error.middleware";
import { authCheck } from "./middlewares/auth.middleware";

const app = express();
const port = process.env.PORT || 3001;

// Middleware
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Routes
app.use("/api/v1", router);
// app.use(authCheck);

// Error Handling
app.use(errorHandler);

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
