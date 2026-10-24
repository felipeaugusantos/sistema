unit untCadRegDes;

interface

uses Classes, SysUtils, Uni, DB, StdCtrls, Controls, untTypesSistema, Forms;

type
  TCadRegDes = class(TComponent)
    private
      FCodReg: string;
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
      procedure pSetCodReg(Value: String);
      procedure pSetCodFor(Value: String);
      procedure pSetPerDes(Value: String);
      procedure pSetPerCom(Value: String);
    protected
      procedure pAfterOpenCadastro(DataSet: TDataSet);
    public
      constructor Create(AOwner: TComponent; FormSelf: TForm); reintroduce;

      function fPesquisarCadastro: Boolean;

      procedure pKeyPressCodigoRegiao(Sender: TCustomEdit;
                                      var Key: Char;
                                      fValidacao: TFuncValidaCampos;
                                      pSelectNext: TProcSelectNext);

      procedure pKeyPressCodigoFornecedor(Sender: TCustomEdit;
                                          var Key: Char;
                                          fValidacao: TFuncValidaCampos;
                                          pSelectNext: TProcSelectNext);

      procedure pKeyDownCodigoRegiao(Sender: TCustomEdit;
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
      property strCodReg: String read FCodReg write pSetCodReg;
      property strCodFor: String read FCodFor write pSetCodFor;
      property strCodEmp: String read FCodEmp write FCodEmp;
      property strAutInc: String read FAutInc write FAutInc;
      property strPerDes: String read fGetPerDes write pSetPerDes;
      property strPerCom: String read fGetPerCom write pSetPerCom;      
      property qryRegDes: TUniQuery read FQryCad write FQryCad;
  end;

  ExceptionRegDes = class(Exception);

implementation

uses untFuncoesConsulta, untFuncoesSimples, untFuncIns, untConsultas, untFuncIns2;

constructor TCadRegDes.Create(AOwner: TComponent; FormSelf: TForm);
begin
  inherited Create(AOwner);
  FQryCad := fCriarQuery('SELECT * FROM REGDES WHERE FALSE', Self);
  FQryCad.AfterOpen := pAfterOpenCadastro;
  FQryCad.Open;

  Self.FormSelf := FormSelf;
end;

procedure TCadRegDes.pGeraErro(Value: String);
begin
  Raise ExceptionRegDes.Create(Value);
end;

procedure TCadRegDes.pSetCodReg(Value: String);
begin
  If fEmptyStr(Value) Then
    pGeraErro('Informe o código da Região!')

  Else If fEmptyStr(fRetNomRegiao(Value)) Then
    pGeraErro('Região não cadastrada!')

  Else
    FCodReg := Value;
end;

procedure TCadRegDes.pSetCodFor(Value: String);
begin
  If fEmptyStr(Value) Then
    pGeraErro('Informe o código do fornecedor!')

  Else If fEmptyStr(fRetNomFornecedor(Value)) Then
    pGeraErro('Fornecedor não cadastrado!')

  Else
    FCodFor := Value;
end;

procedure TCadRegDes.pSetPerCom(Value: String);
begin
  If Not fValidaEscala(Value, 0, 100) Then
    pGeraErro('Informe um valor entre 0 e 100!')
  Else
    FPerCom := fStrToFloat(Value);
end;

procedure TCadRegDes.pSetPerDes(Value: String);
begin
  If Not fValidaEscala(Value, 0, 100) Then
    pGeraErro('Informe um valor entre 0 e 100!')
  Else
    FPerDes := fStrToFloat(Value);
end;

function TCadRegDes.fGetPerCom: String;
begin
  Result := FormatFloat('##,#0.00', FPerCom);
end;

function TCadRegDes.fGetPerDes: String;
begin
  Result := FormatFloat('##,#0.00', FPerDes);
end;

function TCadRegDes.fPesquisarCadastro: Boolean;
  Var
    Key: Char;
    arrSel : TConsultasArray;
begin
  key := '?';
  Result := fPesqRegDes('TCadRegDes.fPesquisarCadastro',
                        Nil,
                        FQryCad,
                        Key,
                        arrSel);
end;

procedure TCadRegDes.pAfterOpenCadastro(DataSet: TDataSet);
begin
  With DataSet Do
  Begin
    If FindField('RDS_CODREG') <> Nil Then
      FieldByName('RDS_CODREG').DisplayLabel := 'Região';

    If FindField('RDS_CODFOR') <> Nil Then
      FieldByName('RDS_CODFOR').DisplayLabel := 'Fornecedor';

    If FindField('RDS_CODEMP') <> Nil Then
      FieldByName('RDS_CODEMP').DisplayLabel := 'Empresa';

    If FindField('AUTOINCREM') <> Nil Then
    Begin
      FieldByName('AUTOINCREM').DisplayLabel := 'Autoincremento';
      FieldByName('AUTOINCREM').Visible      := False;
    End;

    If FindField('RDS_PERDES') <> Nil Then
    Begin
      FieldByName('RDS_PERDES').DisplayLabel := '% Desconto';
      TFloatField(FieldByName('RDS_PERDES')).EditFormat := '##,#0.00';
      TFloatField(FieldByName('RDS_PERDES')).DisplayFormat := '##,#0.00';
    End;

    If FindField('RDS_PERCOM') <> Nil Then
    Begin
      FieldByName('RDS_PERCOM').DisplayLabel := '% Comissão';
      TFloatField(FieldByName('RDS_PERCOM')).EditFormat := '##,#0.00';
      TFloatField(FieldByName('RDS_PERCOM')).DisplayFormat := '##,#0.00';
    End;
  End;
end;

procedure TCadRegDes.pKeyPressCodigoRegiao(Sender: TCustomEdit; var Key: Char;
  fValidacao: TFuncValidaCampos; pSelectNext: TProcSelectNext);
  Var
    arrSel : TConsultasArray;
begin
  If fPesqRegiao(FormSelf, Sender, Nil, Nil, Key, arrSel) Then
  Begin
    If fValidacao(Sender, True) Then
      pSelectNext(Sender, True, True);
  End;
end;

procedure TCadRegDes.pKeyPressCodigoFornecedor(Sender: TCustomEdit; var Key: Char;
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

procedure TCadRegDes.pKeyDownCodigoRegiao(Sender: TCustomEdit; var Key: Word; Shift: TShiftState;
  fValidacao: TFuncValidaCampos; pSelectNext: TProcSelectNext);
  var
    strCodigo: String;
begin
  If fIsInsert(Key) And fVerificaAcessoSistema('frmCadRegioes') Then
  Begin
    strCodigo := fChamaCadReg(Key);
    If (Not fEmptyStr(strCodigo)) Then
    Begin
      Sender.Text := strCodigo;
      If fValidacao(Sender, True) Then
        pSelectNext(Sender, True, True);
    End;
  End;
end;

procedure TCadRegDes.pKeyDownCodigoFornecedor(Sender: TCustomEdit; var Key: Word; Shift: TShiftState;
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
