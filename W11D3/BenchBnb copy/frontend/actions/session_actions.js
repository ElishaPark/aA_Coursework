import * as SessionApiUtil from '../util/session_api_util'

export const RECEIVE_CURRENT_USER = 'RECEIVE_CURRENT_USER'
export const LOGOUT_CURRENT_USER = 'LOGOUT_CURRENT_USER'
export const RECEIVE_ERRORS = 'RECEIVE_ERRORS'

export const receiveCurrentUser = user => ({
  type: RECEIVE_CURRENT_USER,
  user,
});

export const logoutCurrentUser = () => ({
  type: LOGOUT_CURRENT_USER,
});

export const receiveErrors = errors => ({
  type: RECEIVE_ERRORS,
  errors,
});


export const login = user => dispatch => (
  SessionApiUtil.login(user).then(userResponse => (
    dispatch(receiveCurrentUser(userResponse))
  ), err => (
    dispatch(receiveErrors(err.responseJSON))
  ))
)

// const successCallback = user => (
//   dispatch(receiveCurrentUser(user))
// )

// const errorCallback = err => (
//   dispatch(receiveErrors(err.responseJSON))
// )

export const signup = user => dispatch => (
  SessionApiUtil.signup(user).then(user => (
    dispatch(receiveCurrentUser(user))
  ), err => (
    dispatch(receiveErrors(err.responseJSON))
  ))
);

export const logout = () => dispatch => (
  SessionApiUtil.logout().then(() => (
    dispatch(logoutCurrentUser())
  ))
);
