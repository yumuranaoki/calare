import React from 'react';
import ReactDOM from 'react-dom';
import NotificationConnected from './container/notification';
import {Provider} from 'react-redux';
import {createStore} from 'redux';
import reducer from './reducer/notification';

const initialState = {
  IsOpen: false
}
const store = createStore(reducer, initialState)


document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <Provider store={store}>
      <NotificationConnected />
    </Provider>,
    document.getElementById('react-notification')
  )
})
