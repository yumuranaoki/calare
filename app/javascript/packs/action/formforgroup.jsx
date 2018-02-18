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

export const handleSubmit = (startdate, enddate) => {
  console.log(startdate)
  console.log(enddate)
  return {
    type: "HANDLE_SUBMIT"
  }
}

export const handleSecondCancel = () => {
  return {
    type: "HANDLE_SECOND_CANCEL"
  }
}

export const handleSecondSubmit = (starttime, endtime, timelength) => {
  return {
    type: "HANDLE_SECOND_SUBMIT",
    starttime: starttime,
    endtime: endtime,
    timelength: timelength
  }
}

export const handleChange = (value, type) => {
  console.log(value);
  console.log(type);
  return {
    type: "HANDLE_CHANGE",
    value: value,
    formType: type
  }
}
