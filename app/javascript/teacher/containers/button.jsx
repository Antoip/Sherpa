import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import { selectActiveDashboard } from '../actions';

class Button extends Component {
  handleClick = () => {
    this.props.selectActiveDashboard(this.props.btn);
    console.log(this.props)
  }

  render() {
    return(
      <a className={`btn-nav-left ${this.props.activeDashboard == this.props.btn ? 'btn-actif' : ''}`} id={this.props.btn} onClick={this.handleClick}><div className="navbar-icon"><i className={this.props.btn}></i></div></a>
    )
  }
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators(
    { selectActiveDashboard: selectActiveDashboard },
    dispatch
  );
}

function mapStateToProps(state) {
  return {
    activeDashboard: state.activeDashboard
  };
}
export default connect(mapStateToProps, mapDispatchToProps)(Button);
