import React from 'react';
import {connect} from 'react-redux';
import FormForGroup from '../component/formforgroup/formforgroup';
import {handlePlus, handleCancel, handleSubmit, handleSecondCancel,
        handleSecondSubmit, handleChange, onToggle, handleClose} from '../action/formforgroup';


const mapStateToProps = state => ({
  isOpen: state.isOpen,
  isSecondOpen: state.isSecondOpen,
  starttime: state.starttime,
  endtime: state.endtime,
  timelength: state.timelength,
  multi: state.multi,
  eventId: state.eventId,
  title:  state.title,
  startdate: state.startdate,
  enddate: state.enddate,
  isThirdOpen: state.isThirdOpen
})


const mapDispatchToProps = dispatch => ({
  handlePlus: () => dispatch(handlePlus()),
  handleCancel: () => dispatch(handleCancel()),
  handleSubmit: (startdate, enddate) => dispatch(handleSubmit(startdate, enddate)),
  handleSecondCancel: () => dispatch(handleSecondCancel()),
  handleSecondSubmit: (starttime, endtime, timelength, accessId) => dispatch(handleSecondSubmit(starttime, endtime, timelength, accessId)),
  handleChange: (value, type) => dispatch(handleChange(value, type)),
  onToggle: () => dispatch(onToggle()),
  handleClose: () => dispatch(handleClose())
})


const FormForGroupConnected = connect(
  mapStateToProps,
  mapDispatchToProps
)(FormForGroup);

export default FormForGroupConnected;
