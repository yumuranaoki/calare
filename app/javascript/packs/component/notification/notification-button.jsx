import React from 'react';
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';
import SocialNotifications from 'material-ui/svg-icons/social/notifications';

class NotificationButton extends React.Component {
  render(){
    const styles = {
      color: 'white',
      margin: '12px'
    }
    return(
      <MuiThemeProvider>
        <SocialNotifications style={styles} onClick={this.props.onClick} />
      </MuiThemeProvider>
    );
  }
}

export default NotificationButton;
