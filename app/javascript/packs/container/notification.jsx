import React from 'react';
import {connect} from 'react-redux';
import Notification from '../component/notification/notification';
import {clickOpen} from '../action/notification';


function mapStateToProps(state) {
  return {
    IsOpen: state.IsOpen
  };
}


function mapDispatchToProps(dispatch) {
  return {
    handleClick() {
      dispatch(clickOpen());
    }
  }
}


const NotificationConnected = connect(
  mapStateToProps,
  mapDispatchToProps
)(Notification);

export default NotificationConnected;
