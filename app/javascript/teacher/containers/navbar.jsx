import React, { Component } from 'react';
import Button from "./button";

class Navbar extends Component {
  render() {
    return(
      <div className="navbar-left">

          {this.props.btns.map((btn) => {
            return (
              <Button btn={btn}/>
          );
        })}

      </div>
    );
  }
}

export default Navbar;
