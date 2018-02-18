import {applyMiddleware, createStore} from 'redux';
import reducer from '../reducer/formforgroup';
import thunk from 'redux-thunk';

const initialState = {
  isOpen: false,
  isSecondOpen: false,
  starttime: 0,
  endtime: 0,
  timelength: 0
}

const store = createStore(reducer, initialState, applyMiddleware(thunk))

export default store;
