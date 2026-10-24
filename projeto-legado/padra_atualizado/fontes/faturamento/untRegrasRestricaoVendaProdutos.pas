unit untRegrasRestricaoVendaProdutos;

interface

uses
  System.Classes, System.Generics.Collections, System.SysUtils, Uni,
  UniClientDataSet, UniDataSetProvider, untTypesSistema;

type
  TRegrasRestricaoVendaProdutos = class
  private
    FQryDadosProduto   : TUniQuery;
    FQryDadosCliente   : TUniQuery;
    FLstErros          : TStrings;
    FLstCodigosProduto : TStrings;

    FEspDoc            : String;
    FCodCli            : String;

    procedure pCarregarDadosCliente;
    procedure pCarregarDadosProduto;

    procedure pValidarRegra(const ACampo, ACodigo: String);

    procedure pAcionarProdutoListaErro(const AProduto: String);
    function GetMensagemErros: String;

  public
    constructor Create;
    destructor Destroy; override;

    class function New: TRegrasRestricaoVendaProdutos;

    function EspecieDocumento(const Value: String): TRegrasRestricaoVendaProdutos;
    function CodigoCliente(const Value: String): TRegrasRestricaoVendaProdutos;

    function fAdicionarCodigoProduto(
      const ACodigoProduto: String): TRegrasRestricaoVendaProdutos;
    function fPossuiRestricaoVenda: Boolean;

    function fLimpar: TRegrasRestricaoVendaProdutos;

    property lstListaErros    : TStrings read FLstErros;
    property strMensagemErros : String   read GetMensagemErros;
  end;

implementation

uses
  untFuncoesSimples, untFuncoes, untObservacao;

{ TRegrasRestricaoVendaProdutos }

function TRegrasRestricaoVendaProdutos.CodigoCliente(
  const Value: String): TRegrasRestricaoVendaProdutos;
begin
  Result := Self;

  If Not fCfgSis('UTCRVP', varBoolean) Then
    Exit;

  If Value <> FCodCli Then
  Begin
    FCodCli := Value;
    pCarregarDadosCliente;
  End;
end;

constructor TRegrasRestricaoVendaProdutos.Create;
begin
  FQryDadosProduto   := fCriaQuery(Nil);
  FQryDadosCliente   := fCriaQuery(Nil);

  FLstErros          := TStringList.Create;
  FLstCodigosProduto := TStringList.Create;
end;

destructor TRegrasRestricaoVendaProdutos.Destroy;
begin
  FreeAndNil(FQryDadosProduto);
  FreeAndNil(FQryDadosCliente);
  FreeAndNil(FLstErros);
  FreeAndNil(FLstCodigosProduto);

  inherited;
end;

function TRegrasRestricaoVendaProdutos.EspecieDocumento(
  const Value: String): TRegrasRestricaoVendaProdutos;
begin
  Result := Self;

  If Not fCfgSis('UTCRVP', varBoolean) Then
    Exit;

  FEspDoc := Value;
end;

function TRegrasRestricaoVendaProdutos.fAdicionarCodigoProduto(
  const ACodigoProduto: String): TRegrasRestricaoVendaProdutos;
begin
  Result := Self;

  If Not fCfgSis('UTCRVP', varBoolean) Then
    Exit;

  If FLstCodigosProduto.IndexOf(ACodigoProduto) = -1 Then
    FLstCodigosProduto.Add(ACodigoProduto);
end;

function TRegrasRestricaoVendaProdutos.fPossuiRestricaoVenda: Boolean;
begin
  Result := False;

  FLstErros.Clear;

  If Not fCfgSis('UTCRVP', varBoolean) Then
    Exit;

  If (Pos(FEspDoc,'OR_PD_VN_F3_CP_') <= 0) Or
     (fEmptyStr(FCodCli)) Or
     (FLstCodigosProduto.Count = 0) Then
    Exit;

  pCarregarDadosProduto;

  pValidarRegra('PDT_CODCLI', FQryDadosCliente.FieldByName('CODCLI').AsString);
  pValidarRegra('PDT_CODCID', FQryDadosCliente.FieldByName('CODCID').AsString);
  pValidarRegra('PDT_ESTADO', FQryDadosCliente.FieldByName('ESTADO').AsString);
  pValidarRegra('PDT_CODREG', FQryDadosCliente.FieldByName('CODREG').AsString);

  Result := FLstErros.Count > 0;

  If Result Then
    TfrmObservacao.fObservacao('Restrição de Venda de Produtos', strMensagemErros);
end;

function TRegrasRestricaoVendaProdutos.GetMensagemErros: String;
var
  LIntContador : Integer;
begin
  Result := EmptyStr;

  For LIntContador := 0 To Pred(FLstErros.Count) Do
  Begin
    If Not fEmptyStr(Result) Then
      Result := Result
              + #13#10;

    Result := Result
            + Copy(FLstErros.Strings[LIntContador], 1, 55);
  End;

  If Not fEmptyStr(Result) Then
  Begin
    Result := 'PRODUTOS COM RESTRIÇÃO DE VENDA PARA O CLIENTE:'
            + #13#10
            + '--------------------------------------------------------'
            + #13#10
            + Result
            + #13#10
            + '--------------------------------------------------------';
  End;
end;

class function TRegrasRestricaoVendaProdutos.New: TRegrasRestricaoVendaProdutos;
begin
  Result := Self.Create;
end;

procedure TRegrasRestricaoVendaProdutos.pAcionarProdutoListaErro(
  const AProduto: String);
begin
  If FLstErros.IndexOf(AProduto) = -1 Then
    FLstErros.Add(AProduto);
end;

procedure TRegrasRestricaoVendaProdutos.pCarregarDadosCliente;
begin
  FQryDadosCliente.Close;
  FQryDadosCliente.SQL.Text := 'SELECT '
                             + '       CLI_CODCLI AS CODCLI '
                             + '     , CLI_CODCID AS CODCID '
                             + '     , CID_ESTADO AS ESTADO '
                             + '     , CLI_CODREG AS CODREG '
                             + '     , CLI_NOMCLI AS NOMCLI '
                             + '  FROM CADCLI '
                             + ' INNER JOIN CADCID ON CID_CODCID = CLI_CODCID '
                             + ' WHERE CLI_CODCLI = :CODCLI ';
  FQryDadosCliente.ParamByName('CODCLI').AsString := FCodCli;
  FQryDadosCliente.Open;
end;

procedure TRegrasRestricaoVendaProdutos.pCarregarDadosProduto;
var
  LstrCodigos  : String;
  LintContador : Integer;
begin
  LstrCodigos := EmptyStr;
  For LintContador := 0 To Pred(FLstCodigosProduto.Count) Do
  Begin
    If Not fEmptyStr(LstrCodigos) Then
      LstrCodigos := LstrCodigos
                   + ',';

    LstrCodigos := LstrCodigos
                 + fColocaAspas(FLstCodigosProduto.Strings[LintContador]);
  End;

  FQryDadosProduto.Close;
  FQryDadosProduto.SQL.Text := 'SELECT '
                             + '       ITE_CODITE AS CODITE '
                             + '     , ITE_CODMAR AS CODMAR '
                             + '     , ITE_CODDEP AS CODDEP '
                             + '     , ITE_CODFOR AS CODFOR '
                             + '     , ITE_DESITE AS DESITE '
                             + '  FROM CADITE '
                             + ' WHERE ITE_CODITE IN ('+LstrCodigos+') ';
  FQryDadosProduto.Open;
end;

function TRegrasRestricaoVendaProdutos.fLimpar: TRegrasRestricaoVendaProdutos;
begin
  Result := Self;

  FLstErros.Clear;
  FLstCodigosProduto.Clear;
end;

procedure TRegrasRestricaoVendaProdutos.pValidarRegra(const ACampo,
  ACodigo: String);
var
  LExisteRestricao : Boolean;
  LQryDadosRestricao : TUniQuery;
begin
  LQryDadosRestricao := fCriaQuery(nil);
  Try
    LQryDadosRestricao.SQL.Text := 'SELECT '
                                 + '       NPV_CODFOR '
                                 + '     , NPV_CODDEP '
                                 + '     , NPV_CODMAR '
                                 + '     , NPV_CODITE '
                                 + '  FROM RTVVND '
                                 + ' INNER JOIN RTVPDT ON PDT_CODRTV = RTV_CODIGO '
                                 + ' INNER JOIN RTVNPV ON NPV_CODRTV = RTV_CODIGO '
                                 + ' WHERE '+ACampo+' = :CODIGO ';
    LQryDadosRestricao.ParamByName('CODIGO').AsString := ACodigo;
    LQryDadosRestricao.Open;

    If LQryDadosRestricao.IsEmpty Then
      Exit;

    FQryDadosProduto.First;
    While Not FQryDadosProduto.Eof Do
    Begin
      LExisteRestricao := False;

      If LQryDadosRestricao.Locate('NPV_CODITE', FQryDadosProduto.FieldByName('CODITE').AsString, []) Then
        LExisteRestricao := True
      Else If LQryDadosRestricao.Locate('NPV_CODDEP', FQryDadosProduto.FieldByName('CODDEP').AsString, []) Then
        LExisteRestricao := True
      Else If LQryDadosRestricao.Locate('NPV_CODMAR', FQryDadosProduto.FieldByName('CODMAR').AsString, []) Then
        LExisteRestricao := True
      Else If LQryDadosRestricao.Locate('NPV_CODFOR', FQryDadosProduto.FieldByName('CODFOR').AsString, []) Then
        LExisteRestricao := True;

      If LExisteRestricao Then
      Begin
        pAcionarProdutoListaErro(FQryDadosProduto.FieldByName('CODITE').AsString
                               + ' - '
                               + FQryDadosProduto.FieldByName('DESITE').AsString);
      End;

      FQryDadosProduto.Next;
    End;
  Finally
    FreeAndNil(LQryDadosRestricao);
  End;
end;

end.
