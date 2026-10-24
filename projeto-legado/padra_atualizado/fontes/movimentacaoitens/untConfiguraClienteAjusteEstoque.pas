unit untConfiguraClienteAjusteEstoque;

interface

Uses
  Classes,
  untZClient,
  CxProgressBar;

Type
  TConfiguraClienteAjusteEstoque = Class(TZClient)
  Private

    FAtivos: Boolean;

    Function fSQLOpcoes: String;

  Public
    blnImpressaoRel: Boolean;
    intIndice: Integer;

    constructor Create(Owner: TComponent; blnAtivos: Boolean = False); Reintroduce; Overload;

    Destructor Destroy; override;

    Function fCarregaOpcoes: Boolean;

  End;

implementation

Uses
  SysUtils,
  untGravando,
  untFuncoesSimples,
  untFuncoesRel;

constructor TConfiguraClienteAjusteEstoque.Create(Owner: TComponent; blnAtivos: Boolean = False);
Begin
  Inherited Create(Owner, '');

  FAtivos :=  blnAtivos;
End;

Destructor TConfiguraClienteAjusteEstoque.Destroy;
Begin

  Inherited;
End;

Function TConfiguraClienteAjusteEstoque.fSQLOpcoes: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT          ';
  strSQL := strSQL + '   C.*,          ';
  strSQL := strSQL + '   CLI_NOMCLI,   ';
  strSQL := strSQL + '   CAST(NULL AS UNSIGNED) AS INDICE  ';
  strSQL := strSQL + ' FROM            ';
  strSQL := strSQL + '   CLIAJU C      ';
  strSQL := strSQL + '   INNER JOIN CADCLI ON CLI_CODCLI = C.CAJ_CODCLI ';
  strSQL := strSQL + ' WHERE           ';
  strSQL := strSQL + '   CAJ_CODEMP =  ' + QuotedStr(VS_strCodEmp);

  Result := strSQL;
End;

Function TConfiguraClienteAjusteEstoque.fCarregaOpcoes: Boolean;
Begin
  qryQuery.SQL.Text := fSQLOpcoes;
  Result := fLeDados('TConfiguraClienteAjusteEstoque.fCarregaOpcoes');
End;


end.
