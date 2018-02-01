import React from 'react';
import ReactDOM from 'react-dom';
import SettingConnected from './container/setting';
import {createStore} from 'redux';
import {Provider} from 'react-redux';
import reducer from './reducer/setting';

const initialState = {
  IsOpen: false
};
const store = createStore(reducer, initialState);

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <Provider store={store}>
      <SettingConnected />
    </Provider>,
    document.getElementById('react-setting')
  )
})
