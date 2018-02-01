import React from 'react';
import {connect} from 'react-redux';
import Setting from '../component/setting/setting';
import {clickOpen} from '../action/setting';

function mapStateToProps(state){
  return{
    IsOpen: state.IsOpen
  };
}

function mapDispatchToProps(dispatch){
  return{
    handleClick(){
      dispatch(clickOpen());
    }
  }
}

const SettingConnected = connect(
  mapStateToProps,
  mapDispatchToProps
)(Setting);

export default SettingConnected;
