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
          title={this.props.title}
          startdate={this.props.startdate}
          starttime={this.props.starttime}
          enddate={this.props.enddate}
          endtime={this.props.endtime}
          timelength={this.props.timelength}
          eventId={this.props.eventId}
          multi={this.props.multi}
          handleSecondCancel={this.props.handleSecondCancel}
          handleSecondSubmit={(data) => this.props.handleSecondSubmit(data)}
          handleChange={(value, type) => this.props.handleChange(value, type)}
        />
      </div>
    );
  }
}

export default FormForGroup;
