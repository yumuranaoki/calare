import React from 'react';
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';
import ActionSettings from 'material-ui/svg-icons/action/settings';

class SettingButton extends React.Component {
  render(){
    const styles={
      color: 'white',
      margin: '12px'
    }
    return(
      <MuiThemeProvider>
        <ActionSettings style={styles} onClick={this.props.onClick} />
      </MuiThemeProvider>
    );
  }
}

export default SettingButton;
