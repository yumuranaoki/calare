export const handlePlus = () => {
  return {
    type: 'HANDLE_PLUS'
  };
}

export const handleCancel = () => {
  return {
    type: "HANDLE_CANCEL"
  };
}


export const afterHandleSubmit = (data) => {
  console.log("afterHandleSubmit")
  return {
    type: "AFTER_HANDLE_SUBMIT",
    data: data
  }
}

export const handleSubmit =(data) => {
  console.log(data)
  return dispatch => {
    const csrfToken = document.getElementsByName('csrf-token').item(0).content;
    fetch('http://localhost:3000/date', {
      method: 'POST',
      credentials: 'same-origin',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken
      },
      body: JSON.stringify(data),
    })
    .then(() => dispatch(afterHandleSubmit(data)))
  }
}



export const handleSecondCancel = () => {
  return {
    type: "HANDLE_SECOND_CANCEL"
  }
}

export const afterHandleSecondSubmit = (starttime, endtime, timelength) => {
  console.log("afterHandleSecondSubmit")
  return {
    type: "AFTER_HANDLE_SECOND_SUBMIT"
  }
}


export const handleSecondSubmit = (starttime, endtime, timelength, accessId) => {
  console.log(accessId)
  console.log(starttime)
  return dispatch => {
    const csrfToken = document.getElementsByName('csrf-token').item(0).content;
    fetch('http://localhost:3000/time', {
      method: 'POST',
      credentials: 'same-origin',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken
      },
      body: JSON.stringify({starttime: starttime, endtime: endtime, timelength: timelength, accessId: accessId}),
    })
    .then(() => dispatch(afterHandleSecondSubmit(starttime, endtime, timelength)))
  }
}


export const handleChange = (value, type) => {
  return {
    type: "HANDLE_CHANGE",
    value: value,
    formType: type
  }
}

export const onToggle = () => {
  return {
    type: "ON_TOGGLE"
  }
}
