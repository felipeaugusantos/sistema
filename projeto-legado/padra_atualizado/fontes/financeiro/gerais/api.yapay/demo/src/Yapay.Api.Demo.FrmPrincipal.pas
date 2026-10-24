unit Yapay.Api.Demo.FrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.UITypes,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxCheckBox, Vcl.Menus, dxLayoutcxEditAdapters,
  dxLayoutControlAdapters, dxLayoutContainer, cxClasses, cxButtons,
  cxCheckComboBox, cxSpinEdit, cxCurrencyEdit, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, dxLayoutControl, IPPeerClient, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, IniFiles, TypInfo,

  Yapay.Api.Conexao,
  Yapay.Api.Cobranca.Base,
  Yapay.Api.ErrorResponse,
  Yapay.Api.Ambiente,
  Yapay.Api.Envio.Cobranca.V3,
  Yapay.Api.Consulta.Cobranca.V3,
  Yapay.Api.Tabela.Tabela3.FormasDePagamento,
  Yapay.Api.TypeResponse,
  Yapay.Api.Inativar.Cobranca.V3,
  Yapay.Api.Listagem.Transacoes;


type
  TFrmPrincipal = class(TForm)
    BtnEnviarCobranca: TcxButton;
    dxLayoutControl1Group_Root: TdxLayoutGroup;
    dxLayoutControl1: TdxLayoutControl;
    cbAmbiente: TcxComboBox;
    liAmbiente: TdxLayoutItem;
    lgOperacao: TdxLayoutGroup;
    lgEnviarCobranca: TdxLayoutGroup;
    edtEnviarAccess_token: TcxTextEdit;
    liedtAccess_token: TdxLayoutItem;
    edtCustomer_email: TcxTextEdit;
    liedtCustomer_email: TdxLayoutItem;
    edtOrder_number: TcxCurrencyEdit;
    liedtOrder_number: TdxLayoutItem;
    edtCode: TcxCurrencyEdit;
    liedtCode: TdxLayoutItem;
    edtValue: TcxCurrencyEdit;
    liedtValue: TdxLayoutItem;
    edtDescription: TcxTextEdit;
    liedtDescription: TdxLayoutItem;
    edtMax_split_transaction: TcxSpinEdit;
    liedtMax_split_transaction: TdxLayoutItem;
    cbAvailable_payment_methods: TcxCheckComboBox;
    licbAvailable_payment_methods: TdxLayoutItem;
    cbUse_cards: TcxCheckBox;
    licbUse_cards: TdxLayoutItem;
    cbNew_checkout: TcxCheckBox;
    licbNew_checkout: TdxLayoutItem;
    liBtnEnviarCobranca: TdxLayoutItem;
    edtTokenAccount: TcxTextEdit;
    liedtTokenAccount: TdxLayoutItem;
    lgConexao: TdxLayoutGroup;
    edtConsumerKey: TcxTextEdit;
    liedtConsumerKey: TdxLayoutItem;
    edtConsumerSecret: TcxTextEdit;
    liedtConsumerSecret: TdxLayoutItem;
    edtResellerToken: TcxTextEdit;
    liedtResellerToken: TdxLayoutItem;
    cbTypeResponse: TcxComboBox;
    licbTypeResponse: TdxLayoutItem;
    cbDebug: TcxCheckBox;
    licbDebug: TdxLayoutItem;
    cbLog: TcxCheckBox;
    licbLog: TdxLayoutItem;
    lgConsultarCobranca: TdxLayoutGroup;
    lgInativarCobranca: TdxLayoutGroup;
    edtConsultaAccess_token: TcxTextEdit;
    liedtConsultaAccess_token: TdxLayoutItem;
    BtnConsultaCobranca: TcxButton;
    liBtnConsultaCobranca: TdxLayoutItem;
    EdtConsultaIdCobranca: TcxCurrencyEdit;
    liEdtIdCobranca: TdxLayoutItem;
    edtInativarAccess_token: TcxTextEdit;
    EdtInativarIdCobranca: TcxCurrencyEdit;
    BtnInativarCobranca: TcxButton;
    liedtInativaAccess_token: TdxLayoutItem;
    liEdtInativaIdCobranca: TdxLayoutItem;
    liBtnInativaCobranca: TdxLayoutItem;
    lgListagemTransacoes: TdxLayoutGroup;
    liedtConsultaAccess_token2: TdxLayoutItem;
    edtConsultaAccess_token2: TcxTextEdit;
    EdtConsultaIdTransacao: TcxCurrencyEdit;
    dxLayoutItem2: TdxLayoutItem;
    BtnConsultaTransacao: TcxButton;
    dxLayoutItem1: TdxLayoutItem;
    procedure BtnEnviarCobrancaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnConsultaCobrancaClick(Sender: TObject);
    procedure BtnInativarCobrancaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnConsultaTransacaoClick(Sender: TObject);
  private
    ArqIni: TIniFile;

    procedure PopulaformasPagamento;
    procedure CarregaDadosIniciais;
    procedure SalvarDados;
    function getCaminhoArquivoINI: string;

    procedure setAmbiente(const Value: integer);
    function getAmbiente: integer;

    procedure setConsumerKey(const Value: string);
    function getConsumerKey: string;

    procedure setConsumerSecret(const Value: string);
    function getConsumerSecret: string;

    procedure setResellerToken(const Value: string);
    function getResellerToken: string;

    procedure setTokenAccount(const Value: string);
    function getTokenAccount: string;

    procedure setTypeResponse(const Value: integer);
    function getTypeResponse: integer;

    function AtivarConexao(oConexao: TYapayApiConexao): Boolean;
    function ExecuteEnvioCobranca(oEnvioCobranca: TYapayApiEnvioCobrancaV3): boolean;
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

function TFrmPrincipal.AtivarConexao(oConexao: TYapayApiConexao): Boolean;
var
  sRetorno: string;
  oErro: TGeneralError;
begin
  oConexao.Ambiente := TYapayApiAmbiente(cbAmbiente.ItemIndex);
  oConexao.Debug := cbDebug.Checked;
  oConexao.Log := cbLog.Checked;
  oConexao.Consumer_key := edtConsumerKey.text;
  oConexao.Consumer_secret := edtConsumerSecret.text;
  oConexao.Reseller_token := edtResellerToken.text;
  oConexao.Token_account := edtTokenAccount.text;
  oConexao.Type_response := TTypeResponse.JSON;
  oConexao.Active := True;
  result := oConexao.Active;

  sRetorno := NullAsStringValue;
  for oErro in oConexao.Authorization.Error_Response.General_errors do
  begin
    sRetorno := sRetorno +
      'Code: ' + oErro.Code + sLineBreak +
      'Messagem: ' + oErro.Message + sLineBreak;
  end;
  for oErro in oConexao.Token.Error_Response.General_errors do
  begin
    sRetorno := sRetorno +
      'Code: ' + oErro.Code + sLineBreak +
      'Messagem: ' + oErro.Message + sLineBreak;
  end;
  MessageDlg('Erro de conexão!' + sLineBreak + sLineBreak + sRetorno,mtError,[mbOk],0);
end;

function TFrmPrincipal.ExecuteEnvioCobranca(oEnvioCobranca: TYapayApiEnvioCobrancaV3): boolean;
var
  i: integer;
begin
  oEnvioCobranca.TabelaParametros.Customer_email := edtCustomer_email.Text;
  oEnvioCobranca.TabelaParametros.Order_number := edtOrder_number.text;
  oEnvioCobranca.TabelaParametros.Code := edtCode.text;
  oEnvioCobranca.TabelaParametros.Value := edtValue.Value;
  oEnvioCobranca.TabelaParametros.Description := edtDescription.Text;
  oEnvioCobranca.TabelaParametros.Max_split_transaction := StrToInt64Def(edtMax_split_transaction.Text,1);
  for I := 0 to cbAvailable_payment_methods.Properties.Items.Count - 1 do
  begin
    if cbAvailable_payment_methods.States[i] = cbsChecked then
    begin
      oEnvioCobranca.TabelaParametros.Available_payment_methods :=
        oEnvioCobranca.TabelaParametros.Available_payment_methods +
        [TFormasPagamento.FindById(cbAvailable_payment_methods.Properties.Items[i].Tag)];
    end;
  end;
  oEnvioCobranca.TabelaParametros.New_checkout := cbNew_checkout.Checked;
  oEnvioCobranca.TabelaParametros.Use_cards := cbUse_cards.Checked;
  Result := oEnvioCobranca.Enviar;
end;

procedure TFrmPrincipal.BtnEnviarCobrancaClick(Sender: TObject);
var
  oConexao: TYapayApiConexao;
  oEnvioCobranca: TYapayApiEnvioCobrancaV3;
  sRetorno: string;
  oErro: TGeneralError;
begin
  edtEnviarAccess_token.Clear;
  oConexao := TYapayApiConexao.Create;
  oEnvioCobranca := TYapayApiEnvioCobrancaV3.Create;
  try
    if not AtivarConexao(oConexao) then
      Exit;

    edtEnviarAccess_token.Text := oConexao.Token.Data_Response.Authorization.Access_Token;
    oEnvioCobranca.Conexao := oConexao;

    if ExecuteEnvioCobranca(oEnvioCobranca) then
    begin
      ShowMessage('Cobrança enviada com Sucesso!');
      Exit;
    end;

    if oEnvioCobranca.Resposta.TipoResposta = TYapayApiTipoRespostaCobranca.Erro then
    begin
      sRetorno := NullAsStringValue;
      for oErro in TYapayApiRespostaBaseComErro(oEnvioCobranca.Resposta).Errors do
      begin
        sRetorno := sRetorno +
          'Code: ' + oErro.Code + sLineBreak +
          'Messagem: ' + oErro.Message + sLineBreak;
      end;
    end;
    MessageDlg('Erro no Envio de Cobrança!' + sLineBreak + sLineBreak + sRetorno,mtError,[mbOk],0);

  finally
    if Assigned(oConexao) then
      FreeAndNil(oConexao);
    if Assigned(oEnvioCobranca) then
      FreeAndNil(oEnvioCobranca);
  end;
end;

procedure TFrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SalvarDados;
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
  lgOperacao.ItemIndex := 0;
  PopulaformasPagamento;
  CarregaDadosIniciais;
end;

function TFrmPrincipal.getCaminhoArquivoINI: string;
begin
  result := ChangeFileExt(Application.ExeName, '.ini');
end;

procedure TFrmPrincipal.setAmbiente(const Value: integer);
begin
  ArqIni.WriteString('Dados', 'Ambiente', GetEnumName(TypeInfo(TYapayApiAmbiente), Value));
end;

procedure TFrmPrincipal.setConsumerKey(const Value: string);
begin
  ArqIni.WriteString('Dados', 'ConsumerKey', Value);
end;

procedure TFrmPrincipal.setConsumerSecret(const Value: string);
begin
  ArqIni.WriteString('Dados', 'ConsumerSecret', Value);
end;

procedure TFrmPrincipal.setResellerToken(const Value: string);
begin
  ArqIni.WriteString('Dados', 'ResellerToken', Value);
end;

procedure TFrmPrincipal.setTokenAccount(const Value: string);
begin
  ArqIni.WriteString('Dados', 'TokenAccount', Value);
end;

procedure TFrmPrincipal.setTypeResponse(const Value: integer);
begin
  ArqIni.WriteString('Dados', 'TypeResponse', GetEnumName(TypeInfo(TTypeResponse), Value));
end;

procedure TFrmPrincipal.SalvarDados;
var
  CaminhoArquivoIni: string;
begin
  CaminhoArquivoIni := getCaminhoArquivoINI;
  ArqIni := TIniFile.Create(CaminhoArquivoIni);
  try
    setAmbiente(cbAmbiente.ItemIndex);
    setConsumerKey(edtConsumerKey.Text);
    setConsumerSecret(edtConsumerSecret.Text);
    setResellerToken(edtResellerToken.Text);
    setTokenAccount(edtTokenAccount.Text);
    setTypeResponse(cbTypeResponse.ItemIndex);
  finally
    ArqIni.Free;
  end;
end;

function TFrmPrincipal.getAmbiente: integer;
var ValorLidoIni: string;
begin
  ValorLidoIni := ArqIni.ReadString('Dados', 'Ambiente', GetEnumName(TypeInfo(TYapayApiAmbiente), Ord(TYapayApiAmbiente.Sandbox)));
  result := GetEnumValue(TypeInfo(TYapayApiAmbiente), ValorLidoIni);
end;

function TFrmPrincipal.getConsumerKey: string;
begin
  result := ArqIni.ReadString('Dados', 'ConsumerKey', '54f032ce1ac15421133e8d79c4d67252');
end;

function TFrmPrincipal.getConsumerSecret: string;
begin
  result := ArqIni.ReadString('Dados', 'ConsumerSecret', '2375aeeff6cc9e58cbaf43e6b1d44efa');
end;

function TFrmPrincipal.getResellerToken: string;
begin
  result := ArqIni.ReadString('Dados', 'ResellerToken', '3504525c88e74f7');
end;

function TFrmPrincipal.getTokenAccount: string;
begin
  result := ArqIni.ReadString('Dados', 'TokenAccount', '3504525c88e74f7');
end;

function TFrmPrincipal.getTypeResponse: integer;
var ValorLidoIni: string;
begin
  ValorLidoIni := ArqIni.ReadString('Dados', 'TypeResponse', GetEnumName(TypeInfo(TTypeResponse), Ord(TTypeResponse.JSON)));
  result := GetEnumValue(TypeInfo(TTypeResponse), ValorLidoIni);
end;

procedure TFrmPrincipal.CarregaDadosIniciais;
var
  CaminhoArquivoIni: string;
begin
  CaminhoArquivoIni := getCaminhoArquivoINI;
  ArqIni := TIniFile.Create(CaminhoArquivoIni);
  try
    cbAmbiente.ItemIndex := getAmbiente;
    edtConsumerKey.Text := getConsumerKey;
    edtConsumerSecret.Text := getConsumerSecret;
    edtResellerToken.Text := getResellerToken;
    edtTokenAccount.Text := getTokenAccount;
    cbTypeResponse.ItemIndex := getTypeResponse;
  finally
    ArqIni.Free;
  end;

  edtEnviarAccess_token.Clear;
  edtCustomer_email.Text := 'davidroliveira@gmail.com';
  edtOrder_number.Text := FormatDateTime('yyyymmddhhnnsszzz', Date + Time);
  edtCode.Text := NullAsStringValue;
  edtValue.Value := Random(1000000) / 100;
  edtDescription.Text := 'Descrição do Produto' ;
  edtMax_split_transaction.Value := 1;
  cbAvailable_payment_methods.States[ord(TFormasPagamento.BoletoBancario)] := cbsChecked;

  edtConsultaAccess_token2.Clear;
  EdtConsultaIdTransacao.Clear;

  edtConsultaAccess_token.Clear;
  EdtConsultaIdCobranca.Clear;

  edtInativarAccess_token.Clear;
  EdtInativarIdCobranca.Clear;
end;

procedure TFrmPrincipal.PopulaformasPagamento;
var
  i: integer;
  objCheckComboBoxItem: TcxCheckComboBoxItem;
begin
  cbAvailable_payment_methods.Properties.Items.Clear;
  for I := ord(TFormasPagamento(low(TFormasPagamento))) to ord(TFormasPagamento(high(TFormasPagamento))) do
  begin
    objCheckComboBoxItem := cbAvailable_payment_methods.Properties.Items.Add;
    objCheckComboBoxItem.Description := TFormasPagamento(i).Dados.Descricao;
    objCheckComboBoxItem.Enabled := True;
    objCheckComboBoxItem.ShortDescription := TFormasPagamento(i).Dados.Descricao;
    objCheckComboBoxItem.Tag := TFormasPagamento(i).Dados.Id;
  end;
end;

//procedure SetResourceString(xOldResourceString: PResStringRec; xValueChanged: PChar);
//var
//  POldProtect: DWORD;
//begin
//  VirtualProtect(xOldResourceString, SizeOf(xOldResourceString^), PAGE_EXECUTE_READWRITE, @POldProtect);
//  xOldResourceString^.Identifier := Integer(xValueChanged);
//  VirtualProtect(xOldResourceString,SizeOf(xOldResourceString^),POldProtect, @POldProtect);
//end;

procedure TFrmPrincipal.BtnConsultaCobrancaClick(Sender: TObject);
var
  oConexao: TYapayApiConexao;
  oConsultaCobranca: TYapayApiConsultaCobrancaV3;
  sRetorno: string;
  oErro: TGeneralError;
begin
  edtEnviarAccess_token.Clear;
  oConexao := TYapayApiConexao.Create;
  oConsultaCobranca := TYapayApiConsultaCobrancaV3.Create;
  try
    if not AtivarConexao(oConexao) then
      Exit;

    edtConsultaAccess_token.Text := oConexao.Token.Data_Response.Authorization.Access_Token;
    oConsultaCobranca.TabelaParametros.Id := Trunc(EdtConsultaIdCobranca.Value);
    oConsultaCobranca.Conexao := oConexao;
    if oConsultaCobranca.Enviar then
    begin
      ShowMessage('Consulta de Cobrança realizada com Sucesso!');
      Exit;
    end;

    if oConsultaCobranca.Resposta.TipoResposta = TYapayApiTipoRespostaCobranca.Erro then
    begin
      sRetorno := NullAsStringValue;
      for oErro in TYapayApiRespostaBaseComErro(oConsultaCobranca.Resposta).Errors do
      begin
        sRetorno := sRetorno +
          'Code: ' + oErro.Code + sLineBreak +
          'Messagem: ' + oErro.Message + sLineBreak;
      end;
    end;
    MessageDlg('Erro Consulta de Cobrança!' + sLineBreak + sLineBreak + sRetorno,mtError,[mbOk],0);
  finally
    if Assigned(oConexao) then
      FreeAndNil(oConexao);
    if Assigned(oConsultaCobranca) then
      FreeAndNil(oConsultaCobranca);
  end;
end;

procedure TFrmPrincipal.BtnInativarCobrancaClick(Sender: TObject);
var
  oConexao: TYapayApiConexao;
  oInativarCobranca: TYapayApiInativarCobrancaV3;
  sRetorno: string;
  oErro: TGeneralError;
begin
  edtEnviarAccess_token.Clear;
  oConexao := TYapayApiConexao.Create;
  oInativarCobranca := TYapayApiInativarCobrancaV3.Create;
  try
    if not AtivarConexao(oConexao) then
      Exit;

    edtInativarAccess_token.Text := oConexao.Token.Data_Response.Authorization.Access_Token;
    oInativarCobranca.TabelaParametros.Id := Trunc(EdtInativarIdCobranca.Value);
    oInativarCobranca.Conexao := oConexao;
    if oInativarCobranca.Enviar then
    begin
      ShowMessage('Consulta de Cobrança realizada com Sucesso!');
      Exit;
    end;

    if oInativarCobranca.Resposta.TipoResposta = TYapayApiTipoRespostaCobranca.Erro then
    begin
      sRetorno := NullAsStringValue;
      for oErro in TYapayApiRespostaBaseComErro(oInativarCobranca.Resposta).Errors do
      begin
        sRetorno := sRetorno +
          'Code: ' + oErro.Code + sLineBreak +
          'Messagem: ' + oErro.Message + sLineBreak;
      end;
    end;
    MessageDlg('Erro ao Inativar de Cobrança!' + sLineBreak + sLineBreak + sRetorno,mtError,[mbOk],0);
  finally
    if Assigned(oConexao) then
      FreeAndNil(oConexao);
    if Assigned(oInativarCobranca) then
      FreeAndNil(oInativarCobranca);
  end;
end;

procedure TFrmPrincipal.BtnConsultaTransacaoClick(Sender: TObject);
var
  oConexao: TYapayApiConexao;
  oListagemTransacoes: TYapayApiListagemTransacoes;
begin
  edtEnviarAccess_token.Clear;
  oConexao := TYapayApiConexao.Create;
  oListagemTransacoes := TYapayApiListagemTransacoes.Create;
  try
    if not AtivarConexao(oConexao) then
      Exit;

    edtConsultaAccess_token2.Text := oConexao.Token.Data_Response.Authorization.Access_Token;
    oListagemTransacoes.TabelaParametros.Id := Trunc(EdtConsultaIdTransacao.Value);
    oListagemTransacoes.Conexao := oConexao;
    if oListagemTransacoes.Enviar then
    begin
      ShowMessage('Consulta de Cobrança realizada com Sucesso!');
      Exit;
    end;

    if oListagemTransacoes.Resposta.Pagination.Count = 0 then
      MessageDlg('Nenhuma transação encontrada!',mtError,[mbOk],0);

  finally
    if Assigned(oConexao) then
      FreeAndNil(oConexao);
    if Assigned(oListagemTransacoes) then
      FreeAndNil(oListagemTransacoes);
  end;
end;

end.
