import React from 'react';
import { connect } from 'react-redux';
import OpenButtonForm from '../component/openbuttonform';
import { clickOpen } from '../action/openbuttonform';

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


const OpenButtonFormConnected = connect(
  mapStateToProps,
  mapDispatchToProps
)(OpenButtonForm);

export default OpenButtonFormConnected;
