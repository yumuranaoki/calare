import React from 'react';
import {connect} from 'react-redux';
import FormForGroup from '../component/formforgroup/formforgroup';
import {handlePlus, handleCancel, handleSubmit, handleSecondCancel, handleSecondSubmit, handleChange} from '../action/formforgroup';

function mapStateToProps(state){
  return{
    isOpen: state.isOpen,
    isSecondOpen: state.isSecondOpen,
    starttime: state.starttime,
    endtime: state.endtime,
    timelength: state.timelength
  };
}

function mapDispatchToProps(dispatch){
  return{
    handlePlus() {
      dispatch(handlePlus());
    },
    handleCancel() {
      dispatch(handleCancel());
    },
    handleSubmit(startdate, enddate) {
      dispatch(handleSubmit(startdate, enddate));
    },
    handleSecondCancel() {
      dispatch(handleSecondCancel());
    },
    handleSecondSubmit(starttime, endtime, timelength) {
      dispatch(handleSecondSubmit(starttime, endtime, timelength));
    },
    handleChange(value, type){
      dispatch(handleChange(value, type))
    }
  }
}

const FormForGroupConnected = connect(
  mapStateToProps,
  mapDispatchToProps
)(FormForGroup);

export default FormForGroupConnected;
