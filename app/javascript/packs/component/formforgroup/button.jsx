import React from 'react';
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';
import FloatingActionButton from 'material-ui/FloatingActionButton';
import ContentAdd from 'material-ui/svg-icons/content/add';

class ButtonForForm extends React.Component {
  render() {
    return(
      <MuiThemeProvider>
        <FloatingActionButton onClick={this.props.handlePlus}>
          <ContentAdd />
        </FloatingActionButton>
      </MuiThemeProvider>
    );
  }
}

export default ButtonForForm;
