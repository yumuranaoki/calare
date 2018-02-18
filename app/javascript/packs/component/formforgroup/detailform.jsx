import React from 'react';
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';
import Dialog from 'material-ui/Dialog';
import FlatButton from 'material-ui/FlatButton';
import SelectTime from './selecttime'

class DetailForm extends React.Component {

  handleSecondSubmit = () => {
    this.props.handleSecondSubmit(this.props.starttime,
                                  this.props.endtime,
                                  this.props.timelength)
  }


  render() {
    const actions = [
      <FlatButton
        label="Cancel"
        onClick={this.props.handleSecondCancel}
      />,
      <FlatButton
        label="Submit"
        onClick={this.handleSecondSubmit}
      />,
    ];
    return(
      <MuiThemeProvider>
        <Dialog
          title="create group by oneclick"
          modal={true}
          open={this.props.isSecondOpen}
          actions={actions}
        >
          <SelectTime
            starttime={this.props.starttime}
            endtime={this.props.endtime}
            timelength={this.props.timelength}
            handleChange={(value, type) => this.props.handleChange(value, type)}
          />
        </Dialog>
      </MuiThemeProvider>
    );
  }
}

export default DetailForm;
