import {createStore} from 'redux';
import reducer from '../reducer/formforgroup'

const initialState = {
  isOpen: false,
  isSecondOpen: false,
  starttime: 0,
  endtime: 0,
  timelength: 0
}

const store = createStore(reducer, initialState)

export default store;
