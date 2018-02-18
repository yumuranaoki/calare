import React from 'react';
import SelectField from 'material-ui/SelectField';
import MenuItem from 'material-ui/MenuItem';
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';

class SelectTime extends React.Component {

  handleChangeStart = (event, index, value) => {
    this.props.handleChange(value, "start")
  }

  handleChangeEnd = (event, index, value) => {
    this.props.handleChange(value, "end")
  }

  handleChangeLength = (event, index, value) => {
    this.props.handleChange(value, "length")
  }

  render() {
    const styles = {
      form: {
        width: 200
      },
      timelength: {
        width: 100
      }
    };


    const items = []
    for (let i=0; i < 100; i++){
      items.push(
        <MenuItem value={i} key={i} primaryText={`Item ${i}`} />
      )
    }

    const timeItems = []
    for (let i=0; i < 12; i++){
      timeItems.push(
        <MenuItem value={i} key={i} primaryText={i} />
      );
    }

    return(
      <div>
        <MuiThemeProvider>
          <SelectField
            id="starttime"
            style={styles.form}
            floatingLabelText="starttime"
            maxHeight={100}
            value={this.props.starttime}
            onChange={this.handleChangeStart}
          >
            {items}
          </SelectField>
        </MuiThemeProvider>
        <MuiThemeProvider>
          <SelectField
            id="endtime"
            style={styles.form}
            floatingLabelText="endtime"
            maxHeight={100}
            value={this.props.endtime}
            onChange={this.handleChangeEnd}
          >
            {items}
          </SelectField>
        </MuiThemeProvider>
        <MuiThemeProvider>
          <SelectField
            id="timelength"
            style={styles.timelength}
            floatingLabelText="timelength"
            maxHeight={100}
            value={this.props.timelength}
            onChange={this.handleChangeLength}
          >
            {timeItems}
          </SelectField>
        </MuiThemeProvider>
      </div>
    );
  }
}

export default SelectTime;
