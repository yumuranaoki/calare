import React from 'react';
import OpenButton from './openbutton';
import OpenForm from './openform';

class OpenButtonForm extends React.Component {
  render() {
    return (
      <div>
        <OpenButton
          onClick={this.props.handleClick}
          />
        <OpenForm
          IsOpen={this.props.IsOpen}
          />
      </div>
    );
  }
}

export default OpenButtonForm;
