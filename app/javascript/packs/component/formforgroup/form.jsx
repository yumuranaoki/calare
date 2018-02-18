import React from 'react';
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';
import Dialog from 'material-ui/Dialog';
import FlatButton from 'material-ui/FlatButton';
import DatePicker from 'material-ui/DatePicker';

class Form extends React.Component {

  handleSubmit = () => {
    let startdateVal = document.getElementById("startdate").value;
    let enddateVal = document.getElementById("enddate").value;
    this.props.handleSubmit(startdateVal, enddateVal)
  }

  render() {

    const todayDate = new Date();
    
    const actions = [
      <FlatButton
        label="Cancel"
        onClick={this.props.handleCancel}
      />,
      <FlatButton
        label="Submit"
        onClick={this.handleSubmit}
      />,
    ];


    return(
      <MuiThemeProvider>
        <Dialog
          title="create group by oneclick"
          modal={true}
          open={this.props.isOpen}
          actions={actions}
        >
        Only actions can close this dialog.
        <DatePicker
          hintText="startdate"
          autoOk={true}
          id="startdate"
          defaultDate={todayDate}
        />
        <DatePicker
          hintText="enddate"
          autoOk={true}
          id="enddate"
          defaultDate={todayDate}
        />
        </Dialog>
      </MuiThemeProvider>
    );
  }
}

export default Form;
