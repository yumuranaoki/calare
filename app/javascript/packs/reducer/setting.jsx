const reducer = (state, action) => {
  switch (action.type) {
    case 'CLICK':
      return {
        IsOpen: !state.IsOpen
      };
    default:
      return state;
  }
}

export default reducer;
