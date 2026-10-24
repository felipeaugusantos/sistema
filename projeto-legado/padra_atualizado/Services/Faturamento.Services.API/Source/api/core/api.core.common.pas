unit api.core.common;

interface

uses
  System.SysUtils;

const
  API_SERVER_NAME = 'Autcom.Faturamento.API';

  API_MSG_RESPONSE_SUCCESS_200 = 'Success';
  API_MSG_RESPONSE_SUCCESS_201 = 'Created';
  API_MSG_RESPONSE_SUCCESS_204 = 'No content';
  API_MSG_RESPONSE_ERROR_500 = 'Internal server error';
  API_MSG_RESPONSE_ERROR_401 = 'Invalid authorization type';
  API_MSG_RESPONSE_ERROR_403 = 'Forbidden';
  API_MSG_RESPONSE_ERROR_404 = 'Record not found';

implementation

end.
