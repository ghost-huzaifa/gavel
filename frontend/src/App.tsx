import { BrowserRouter, Route, Routes } from "react-router";
import Login from "./pages/login";
import Dashboard from "./pages/dashboard";

export function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/auth" element={<Login />} />
        <Route path="/dashboard" element={<Dashboard />} />
      </Routes>
    </BrowserRouter>
  );
}

export default App;
