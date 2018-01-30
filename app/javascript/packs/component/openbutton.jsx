import React from 'react'
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';
import MaterialFloatingActionButton from './materialfloatingactionbuttonobf';

class OpenButton extends React.Component {
  render() {
    return (
      <MuiThemeProvider>
        <MaterialFloatingActionButton onClick={this.props.onClick}/>
      </MuiThemeProvider>
    );
  }
}

export default OpenButton;
