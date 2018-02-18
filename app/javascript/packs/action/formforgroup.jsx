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


export const afterHandleSubmit = (startdate, enddate) => {
  console.log("afterHandleSubmit")
  return {
    type: "AFTER_HANDLE_SUBMIT"
  }
}

export const handleSubmit =(startdate, enddate) => {
  return dispatch => {
    const csrfToken = document.getElementsByName('csrf-token').item(0).content;
    fetch('http://localhost:3000/date', {
      method: 'POST',
      credentials: 'same-origin',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken
      },
      body: JSON.stringify({startdate: startdate, enddate: enddate}),
    })
    .then(() => dispatch(afterHandleSubmit(startdate, enddate)))
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


export const handleSecondSubmit = (starttime, endtime, timelength) => {
  return dispatch => {
    const csrfToken = document.getElementsByName('csrf-token').item(0).content;
    fetch('http://localhost:3000/time', {
      method: 'POST',
      credentials: 'same-origin',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken
      },
      body: JSON.stringify({starttime: starttime, endtime: endtime, timelength:timelength}),
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
