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
            (data) => this.props.handleSubmit(data)
          }
          onToggle={this.props.onToggle}
          multi={this.props.multi}
        />
        <DetailForm
          isSecondOpen={this.props.isSecondOpen}
          starttime={this.props.starttime}
          endtime={this.props.endtime}
          timelength={this.props.timelength}
          handleSecondCancel={this.props.handleSecondCancel}
          handleSecondSubmit={
            (starttime, endtime, timelength, accessId) => this.props.handleSecondSubmit(starttime, endtime, timelength, accessId)
          }
          handleChange={(value, type) => this.props.handleChange(value, type)}
          eventId={this.props.eventId}
        />
      </div>
    );
  }
}

export default FormForGroup;
