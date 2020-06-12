// TODO: add and export your own actions

export function selectActiveDashboard(btn) {
  // TODO: Api call! For now, simulate a DB
  return {
    type: 'SELECT_DASHBOARD',
    payload: btn
  };
}
