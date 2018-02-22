import React from 'react';
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';
import Dialog from 'material-ui/Dialog';
import FlatButton from 'material-ui/FlatButton';

class ResultModal extends React.Component {
  render() {

    const actions = [
      <FlatButton
        label="閉じる"
        onClick={this.props.handleClose}
      />
    ];

    return (
      <MuiThemeProvider>
        <Dialog
          modal={true}
          open={this.props.isThirdOpen}
          actions={actions}
        >
        </Dialog>
      </MuiThemeProvider>
    );
  }
}

export default ResultModal;
