import React from 'react';
import RaisedButton from 'material-ui/RaisedButton';

class MaterialRaisedButton extends React.Component{
  render(){
    return(
      <RaisedButton label="Open" onClick={this.props.onClick} />
    );
  }
}

export default MaterialRaisedButton;
