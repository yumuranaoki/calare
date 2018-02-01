import React from 'react';
import {StyleSheet, css} from 'aphrodite';
import {List, ListItem} from 'material-ui/List';
import {Card} from 'material-ui/Card';
import Divider from 'material-ui/Divider';
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';

class SettingCard extends React.Component {
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
        <List>
          <ListItem primaryText="Google calendarと連携する" />
          <ListItem primaryText="setting" />
        </List>
        <Divider />
        <List>
          <ListItem primaryText="Log out" />
        </List>
      </Card>
      </MuiThemeProvider>
    );
  }
}

export default SettingCard;
