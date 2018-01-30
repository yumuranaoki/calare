import React from 'react';
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';
import MaterialCard from './materialcardobf'

class OpenForm extends React.Component {
  render(){
    return(
      <MuiThemeProvider>
        <MaterialCard IsOpen={this.props.IsOpen}/>
      </MuiThemeProvider>
    );
  }
}

export default OpenForm;
