import React from 'react';
import Form from './form';
import ButtonForForm from './button';
import DetailForm from './detailform';

class FormForGroup extends React.Component {
  render() {
    return(
      <div>
        <ButtonForForm
          handlePlus={this.props.handlePlus}
        />
        <Form
          isOpen={this.props.isOpen}
          handleCancel={this.props.handleCancel}
          handleSubmit={
            (enddate, startdate) => this.props.handleSubmit(startdate, enddate)
          }
        />
        <DetailForm
          isSecondOpen={this.props.isSecondOpen}
          starttime={this.props.starttime}
          endtime={this.props.endtime}
          timelength={this.props.timelength}
          handleSecondCancel={this.props.handleSecondCancel}
          handleSecondSubmit={
            (starttime, endtime, timelength) => this.props.handleSecondSubmit(starttime, endtime, timelength)
          }
          handleChange={(value, type) => this.props.handleChange(value, type)}
        />
      </div>
    );
  }
}

export default FormForGroup;
