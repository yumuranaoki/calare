const reducer = (state, action) => {
  switch (action.type) {
    case "HANDLE_PLUS":
      return Object.assign({}, state, {isOpen: true})
    case "HANDLE_CANCEL":
      return Object.assign({}, state, {isOpen: false})
    case "HANDLE_SUBMIT":
      return Object.assign({}, state, {isOpen: false,
                                      isSecondOpen: true,
                                      eventId: action.data["eventId"],
                                      title: action.data["title"],
                                      multi: action.data["multi"],
                                      startdate: action.data["startdate"],
                                      enddate: action.data["enddate"]})
    case "HANDLE_SECOND_CANCEL":
      return Object.assign({}, state, {isSecondOpen: false})
    case "AFTER_HANDLE_SECOND_SUBMIT":
      return Object.assign({}, state, {isSecondOpen: false})
    case "HANDLE_CHANGE":
      //type(start, end, length)によって場合分け
      switch (action.formType) {
        case "start":
          return Object.assign({}, state, {starttime: action.value})
        case "end":
          return Object.assign({}, state, {endtime: action.value})
        case "length":
          return Object.assign({}, state, {timelength: action.value})
        default:
          return state;
      }
    case "ON_TOGGLE":
      return Object.assign({}, state, {multi: !state.multi})
    default:
      return state;
  }
}

export default reducer;
