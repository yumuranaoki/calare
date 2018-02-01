import React from 'react';
import NotificationButton from './notification-button';
import NotificationCard from './notification-card';

class Notification extends React.Component {
  render(){
    return(
      <div>
        <NotificationButton onClick={this.props.handleClick} />
        <NotificationCard IsOpen={this.props.IsOpen} />
      </div>
    );
  }
}

export default Notification;
