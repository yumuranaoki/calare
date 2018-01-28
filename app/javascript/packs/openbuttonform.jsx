import React from 'react'
import ReactDOM from 'react-dom'
import { createStore } from 'redux'
import { Provider } from 'react-redux'
import OpenButtonFormConnected from './container/openbuttonform'
import reducer from './reducer/openbuttonform'

const initialState = {
  IsOpen: false
}
const store = createStore(reducer, initialState)

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <Provider store={store}>
      <OpenButtonFormConnected />
    </Provider>,
    document.getElementById('react'),
  )
})
