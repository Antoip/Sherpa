const activeDashboardReducer = (state, action) => {
  if (state === undefined) {
  // Reducer initialisation
    return "fas fa-tachometer-alt";
  }
  // TODO: handle some actions
  switch (action.type) {
    case 'SELECT_DASHBOARD':
      return action.payload;
    default:
      return state;
  }
};

export default activeDashboardReducer;
