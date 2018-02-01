import React from 'react';
import SettingButton from './setting-button';
import SettingCard from './setting-card';

class Setting extends React.Component {
  render(){
    return(
      <div>
        <SettingButton onClick={this.props.handleClick} />
        <SettingCard IsOpen={this.props.IsOpen} />
      </div>
    );
  }
}

export default Setting;
