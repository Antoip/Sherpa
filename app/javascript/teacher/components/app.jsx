import React from 'react';
import Navbar from "../containers/navbar";
import ActiveDashboard from "../containers/active-dashboard";

const btns = ["fas fa-tachometer-alt", "fas fa-graduation-cap", "fas fa-star", "fas fa-comments"];

const App = () => {
  return (
    <div className="app">
      <Navbar btns={btns} />
      <div className="content">
        <ActiveDashboard />
      </div>
    </div>
  );
};

export default App;
