import React from 'react';
import {StyleSheet, css} from 'aphrodite';
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';
import {Card, CardText, CardTitle} from 'material-ui/Card';

class NotoficationCard extends React.Component {
  render(){
    const style = StyleSheet.create({
      switchedisplay: {
        display: (this.props.IsOpen ? '' : 'none'),
        position: 'fixed',
        top: '45px',
        right: '20px',
        width: '300px',
        zIndex: '100'
      }
    })
    return(
      <MuiThemeProvider>
        <Card className={css(style.switchedisplay)}>
          <CardTitle title="Notification" />
          <CardText>

          </CardText>
        </Card>
      </MuiThemeProvider>
    );
  }
}

export default NotoficationCard;
