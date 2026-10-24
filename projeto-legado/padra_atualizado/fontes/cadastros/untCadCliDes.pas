unit untCadCliDes;

interface

uses Classes, SysUtils, Uni, DB, StdCtrls, Controls, untFuncoesSimples,
     untTypesSistema, Forms;

type
  TCadCliDes = class(TComponent)
    private
      FCodCli: string;
      FCodFor: string;
      FCodEmp: string;
      FAutInc: string;
      FPerDes: Double;
      FPerCom: Double;
      FQryCad: TUniQuery;
      FormSelf: TForm;
      function fGetPerCom: String;
      function fGetPerDes: String;
      procedure pGeraErro(Value: String);
      procedure pSetCodCli(Value: String);
      procedure pSetCodFor(Value: String);
      procedure pSetPerDes(Value: String);
      procedure pSetPerCom(Value: String);
    protected
      procedure pAfterOpenCadastro(DataSet: TDataSet);
    public
      constructor Create(AOwner: TComponent; FormSelf: TForm);reintroduce;

      function fPesquisarCadastro: Boolean;

      procedure pKeyPressCodigoCliente(Sender: TCustomEdit;
                                       var Key: Char;
                                       fValidacao: TFuncValidaCampos;
                                       pSelectNext: TProcSelectNext);

      procedure pKeyPressCodigoFornecedor(Sender: TCustomEdit;
                                          var Key: Char;
                                          fValidacao: TFuncValidaCampos;
                                          pSelectNext: TProcSelectNext);

      procedure pKeyDownCodigoCliente(Sender: TCustomEdit;
                                      var Key: Word;
                                      Shift: TShiftState;
                                      fValidacao: TFuncValidaCampos;
                                      pSelectNext: TProcSelectNext);

      procedure pKeyDownCodigoFornecedor(Sender: TCustomEdit;
                                         var Key: Word;
                                         Shift: TShiftState;
                                         fValidacao: TFuncValidaCampos;
                                         pSelectNext: TProcSelectNext);

    published
      property strCodCli: String read FCodCli write pSetCodCli;
      property strCodFor: String read FCodFor write pSetCodFor;
      property strCodEmp: String read FCodEmp write FCodEmp;
      property strAutInc: String read FAutInc write FAutInc;
      property strPerDes: String read fGetPerDes write pSetPerDes;
      property strPerCom: String read fGetPerCom write pSetPerCom;      
      property qryCliDes: TUniQuery read FQryCad write FQryCad;
  end;

  ExceptionCliDes = class(Exception);

implementation

uses untFuncoesConsulta, untFuncIns, untConsultas, untFuncIns2;

constructor TCadCliDes.Create(AOwner: TComponent; FormSelf: TForm);
begin
  inherited Create(AOwner);
  FQryCad := fCriarQuery('SELECT * FROM CLIDES WHERE FALSE', Self);
  FQryCad.AfterOpen := pAfterOpenCadastro;
  FQryCad.Open;
  Self.FormSelf := FormSelf;
end;

procedure TCadCliDes.pGeraErro(Value: String);
begin
  Raise ExceptionCliDes.Create(Value);
end;

procedure TCadCliDes.pSetCodCli(Value: String);
begin
  If fEmptyStr(Value) Then
    pGeraErro('Informe o código do cliente!')

  Else If fEmptyStr(fRetNomCliente(Value)) Then
    pGeraErro('Cliente não cadastrado!')

  Else
    FCodCli := Value;
end;

procedure TCadCliDes.pSetCodFor(Value: String);
begin
  If fEmptyStr(Value) Then
    pGeraErro('Informe o código do fornecedor!')

  Else If fEmptyStr(fRetNomFornecedor(Value)) Then
    pGeraErro('Fornecedor não cadastrado!')

  Else
    FCodFor := Value;
end;

procedure TCadCliDes.pSetPerCom(Value: String);
begin
  If Not fValidaEscala(Value, 0, 100) Then
    pGeraErro('Informe um valor entre 0 e 100!')
  Else
    FPerCom := fStrToFloat(Value);
end;

procedure TCadCliDes.pSetPerDes(Value: String);
begin
  If Not fValidaEscala(Value, 0, 100) Then
    pGeraErro('Informe um valor entre 0 e 100!')
  Else
    FPerDes := fStrToFloat(Value);
end;

function TCadCliDes.fGetPerCom: String;
begin
  Result := FormatFloat('##,#0.00', FPerCom);
end;

function TCadCliDes.fGetPerDes: String;
begin
  Result := FormatFloat('##,#0.00', FPerDes);
end;

function TCadCliDes.fPesquisarCadastro: Boolean;
  Var
    Key : Char;
    arrSel : TConsultasArray;
begin
  Key := '?';
  Result := fPesqCliDes('TCadCliDes.fPesquisarCadastro',
                        Nil,
                        FQryCad,
                        key,
                        arrSel,
                        True);
end;

procedure TCadCliDes.pAfterOpenCadastro(DataSet: TDataSet);
begin
  With DataSet Do
  Begin
    If FindField('CDS_CODCLI') <> Nil Then
      FieldByName('CDS_CODCLI').DisplayLabel := 'Cliente';

    If FindField('CDS_CODFOR') <> Nil Then
      FieldByName('CDS_CODFOR').DisplayLabel := 'Fornecedor';

    If FindField('CDS_CODEMP') <> Nil Then
      FieldByName('CDS_CODEMP').DisplayLabel := 'Empresa';

    If FindField('AUTOINCREM') <> Nil Then
    Begin
      FieldByName('AUTOINCREM').DisplayLabel := 'Autoincremento';
      FieldByName('AUTOINCREM').Visible      := False;
    End;

    If FindField('CDS_PERDES') <> Nil Then
    Begin
      FieldByName('CDS_PERDES').DisplayLabel := '% Desconto';
      TFloatField(FieldByName('CDS_PERDES')).EditFormat := '##,#0.00';
      TFloatField(FieldByName('CDS_PERDES')).DisplayFormat := '##,#0.00';
    End;

    If FindField('CDS_PERCOM') <> Nil Then
    Begin
      FieldByName('CDS_PERCOM').DisplayLabel := '% Comissão';
      TFloatField(FieldByName('CDS_PERCOM')).EditFormat := '##,#0.00';
      TFloatField(FieldByName('CDS_PERCOM')).DisplayFormat := '##,#0.00';
    End;
  End;
end;

procedure TCadCliDes.pKeyPressCodigoCliente(Sender: TCustomEdit; var Key: Char;
  fValidacao: TFuncValidaCampos; pSelectNext: TProcSelectNext);
  Var
    arrSel : TConsultasArray;
begin
  If fPesqCliente(conCliSimples, FormSelf, Sender, Nil, nil, Key, arrSel) Then
  Begin
    If fValidacao(Sender, True) Then
      pSelectNext(Sender, True, True);
  End;
end;

procedure TCadCliDes.pKeyPressCodigoFornecedor(Sender: TCustomEdit; var Key: Char;
  fValidacao: TFuncValidaCampos; pSelectNext: TProcSelectNext);
  Var
    arrSel : TConsultasArray;
begin
  If fPesqFornecedor(conForCompleta, FormSelf, Sender, Nil, Nil, Key, arrSel) Then
  Begin
    If fValidacao(Sender, True) Then
      pSelectNext(Sender, True, True);
  End;
end;

procedure TCadCliDes.pKeyDownCodigoCliente(Sender: TCustomEdit; var Key: Word; Shift: TShiftState;
  fValidacao: TFuncValidaCampos; pSelectNext: TProcSelectNext);
  var
    strCodigo: String;
begin
  If fIsInsert(Key) And fVerificaAcessoSistema('frmCadClientes') Then
  Begin
    strCodigo := fChamaCadCli(Key);
    If (Not fEmptyStr(strCodigo)) Then
    Begin
      Sender.Text := strCodigo;
      If fValidacao(Sender, True) Then
        pSelectNext(Sender, True, True);
    End;
  End;
end;

procedure TCadCliDes.pKeyDownCodigoFornecedor(Sender: TCustomEdit; var Key: Word; Shift: TShiftState;
  fValidacao: TFuncValidaCampos; pSelectNext: TProcSelectNext);
  var
    strCodigo: String;
begin
  If fIsInsert(Key) And fVerificaAcessoSistema('frmCadFornecedores') Then
  Begin
    strCodigo := untFuncIns.fChamaCadFor(Key);
    If (Not fEmptyStr(strCodigo)) Then
    Begin
      Sender.Text := strCodigo;
      If fValidacao(Sender, True) Then
        pSelectNext(Sender, True, True);
    End;
  End;
end;

end.
