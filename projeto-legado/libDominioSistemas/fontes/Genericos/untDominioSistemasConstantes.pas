unit untDominioSistemasConstantes;

interface

Uses Winapi.Messages;

Const
  ERR_UNKNOW_ERROR    = 0000000;
  ERR_UNKNOW_DATABASE = 0000001;
  ERR_ACCESS_DENIED   = 0000002;
  ERR_TABLE_NOT_EXIST = 0000003;
  ERR_FIELD_NOT_FOUND = 0000004;
  ERR_TABLE_READONLY  = 0000005;
  ERR_NOT_VALID_INT   = 0000006;
  ERR_NOT_VALID_DATE  = 0000007;
  ERR_NOT_VALID_FLOAT = 0000008;
  ERR_NOT_IN_EDIT     = 0000009; //Not in EDIT or INSERT mode
  ERR_SQL_SYNTAX      = 0000010;
  ERR_BD_NOT_ACTIVE   = 0000011;
  ERR_FIELD_NOT_NULL  = 0000012;
  ERR_PRIMARY_KEY     = 0000013;
  ERR_ORDER_BY        = 0000014;
  ERR_DEFAULT_PRINTER = 0000015;

  {*****************************************}
  {* CODIGOS DE ERRO ESPECIFICOS DO MYSQL  *}
  {**************************************MV*}
  ERROR_FOREIGN_KEY_DELETE = 1217;
  ERROR_FOREIGN_KEY_INSERT = 1216;
  ERROR_PRIMARY_KEY_INSERT = 1062;
  ERROR_USUARIO_SENHA_INV =  1045;
  ERRO_NAO_CONECTOU = 2003;
  CM_AVISOS = WM_USER + 1;


Var
  VS_strCodEmp: String;
  strLoginUsuarioLogado: String;
  VS_TimeZone: Integer;
  NewGravando: Boolean;
  COR_ZEBRA: Integer;
  VS_Date: TDateTime;

Const
  AUTCOM_STYLE_NAME: String = 'Sapphire Kamri';

implementation

end.
