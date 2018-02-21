import {applyMiddleware, createStore} from 'redux';
import reducer from '../reducer/formforgroup';
import thunk from 'redux-thunk';

const initialState = {
  isOpen: false,
  isSecondOpen: false,
  starttime: 24,
  endtime: 24,
  timelength: 0,
  multi: false,
  eventId: ''
}

const store = createStore(reducer, initialState, applyMiddleware(thunk))

export default store;
