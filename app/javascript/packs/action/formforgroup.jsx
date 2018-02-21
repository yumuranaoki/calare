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
  return {
    type: "AFTER_HANDLE_SUBMIT",
    data: data
  }
}

export const handleSubmit =(data) => {
  return {
    type: "HANDLE_SUBMIT",
    data: data
  }
}



export const handleSecondCancel = () => {
  return {
    type: "HANDLE_SECOND_CANCEL"
  }
}

export const afterHandleSecondSubmit = () => {
  return {
    type: "AFTER_HANDLE_SECOND_SUBMIT"
  }
}


export const handleSecondSubmit = (data) => {
  return dispatch => {
    const csrfToken = document.getElementsByName('csrf-token').item(0).content;
    fetch('http://localhost:3000/time', {
      method: 'POST',
      credentials: 'same-origin',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken
      },
      body: JSON.stringify(data),
    })
    .then(() => dispatch(afterHandleSecondSubmit()))
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
