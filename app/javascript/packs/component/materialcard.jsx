import React from 'react';
import {Card, CardHeader, CardText} from 'material-ui/Card';
import {StyleSheet, css} from 'aphrodite';

class MaterialCard extends React.Component {
  render(){
    const style = StyleSheet.create({
      switchdisplay: {
        display: (this.props.IsOpen ? '' : 'none')
      }
    })

    return(
      <Card className={css(style.switchdisplay)}>
        <CardHeader title="without avatar" />
        <CardText>
          Lorem ipsum dolor sit amet, consectetur adipiscing elit.
          Donec mattis pretium massa. Aliquam erat volutpat. Nulla facilisi.
          Donec vulputate interdum sollicitudin. Nunc lacinia auctor quam sed pellentesque.
          Aliquam dui mauris, mattis quis lacus id, pellentesque lobortis odio.
        </CardText>
      </Card>
    );
  }
}

export default MaterialCard;
