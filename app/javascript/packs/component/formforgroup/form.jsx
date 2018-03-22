import React from 'react';
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';
import Dialog from 'material-ui/Dialog';
import FlatButton from 'material-ui/FlatButton';
import DatePicker from 'material-ui/DatePicker';
import TextField from 'material-ui/TextField';
import Toggle from 'material-ui/Toggle';

class Form extends React.Component {

  handleSubmit = () => {
      let startdateVal = document.getElementById("startdate").value;
      let enddateVal = document.getElementById("enddate").value;
      let title = document.getElementById("textfield-for-title").value;
      let multi = this.props.multi;
      let l = 25;
      let c = "abcdefghijklmnopqrstuvwxyz0123456789";
      let cl = c.length;
      let eventId = "";
      for(let i=0; i<l; i++){
        eventId += c[Math.floor(Math.random()*cl)];
      }
    let data = {startdate: startdateVal, enddate: enddateVal, title: title, multi: multi, eventId: eventId}
    console.log(data["eventId"])
    this.props.handleSubmit(data)
  }

  render() {

    const todayDate = new Date();

    const styles = {
      toggle: {
        width: "200px",
        marginTop: "30px",
        marginButton: "30px"
      },
      inline: {
        display: "inline"
      }
    }

    const actions = [
      <FlatButton
        label="Cancel"
        onClick={this.props.handleCancel}
      />,
      <FlatButton
        label="次へ"
        onClick={this.handleSubmit}
      />,
    ];


    return(
      <MuiThemeProvider>
        <Dialog
          title="範囲を選択して日程調整"
          modal={true}
          open={this.props.isOpen}
          actions={actions}
        >
        <TextField
          id="textfield-for-title"
          floatingLabelText="タイトルを入力してください"
        />
        <Toggle
          id="bool-toggle"
          label="複数人で日程調整"
          onToggle={this.props.onToggle}
          style={styles.toggle}
        />
        <DatePicker
          floatingLabelText="いつから"
          autoOk={true}
          id="startdate"
          mode="landscape"
          defaultDate={todayDate}
        />
        <DatePicker
          floatingLabelText="いつまで"
          autoOk={true}
          id="enddate"
          mode="landscape"
          defaultDate={todayDate}
        />
        </Dialog>
      </MuiThemeProvider>
    );
  }
}

export default Form;
