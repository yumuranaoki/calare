import React from 'react';
import ReactDOM from 'react-dom';
import FormForGroupConnected from './container/formforgroup';
import store from './store/formforgroup';
import {Provider} from 'react-redux';


document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <Provider store={store}>
      <FormForGroupConnected />
    </Provider>,
    document.getElementById('floating-actionbutton'),
  )
})
