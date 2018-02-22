import {applyMiddleware, createStore} from 'redux';
import reducer from '../reducer/formforgroup';
import thunk from 'redux-thunk';

const initialState = {
  isOpen: false,
  isSecondOpen: false,
  title: '',
  startdate: '',
  starttime: 24,
  enddate: '',
  endtime: 24,
  timelength: 0,
  multi: false,
  eventId: '',
  isThirdOpen: false,
  isForthOpen: false
}

const store = createStore(reducer, initialState, applyMiddleware(thunk))

export default store;
