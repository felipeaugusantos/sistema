unit untCfgEmailAutSaida;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxClasses,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCustomView,
  cxGridCitel, cxGridLevel, cxGrid, cxCheckBox, cxButtonEdit, cxDropDownEdit,
  Uni, UniClientDataSet, UniDataSetProvider, cxRadioGroup, cxLabel,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxEditRepositoryItems, untCfgEmailAviCob,
  cxExtEditRepositoryItems, System.StrUtils, untCfgEmailAviDeb;
type
  TfrmCfgEmailAutSaida = class(TfrmPaiConfirma)
    Panel1: TPanel;
    cxGridCitel1Level1: TcxGridLevel;
    cxGridCitelTableView: TcxGridDBTableViewCitel;
    cxGridCitel1: TcxGridCitel;
    ATIVO: TcxGridDBColumn;
    DESCRIÇÃO: TcxGridDBColumn;
    EDITOR: TcxGridDBColumn;
    ENVIO: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    GRUPO: TcxGridDBColumn;
    dtsEmaSai: TDataSource;
    cxEditRepository1: TcxEditRepository;
    cxEditRepository1Botao: TcxEditRepositoryButtonItem;
    cxEditRepository2Botoes: TcxEditRepositoryButtonItem;
    Panel2: TPanel;
    chkEmaSai: TCheckBox;
    cxEditRepository3Botoes: TcxEditRepositoryButtonItem;
    cxEditRepository1Label1: TcxEditRepositoryLabel;
    cxEditRepository1BtnOpcEnvioEmailCob: TcxEditRepositoryButtonItem;
    cxEditRepository1btnEmailFixo: TcxEditRepositoryButtonItem;
    cxEditRepository1BtnEditarBtnOpcoes: TcxEditRepositoryButtonItem;
    CODEMA: TcxGridDBColumn;
    procedure EDITORPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConfirmaClick(Sender: TObject);
    procedure ENVIOPropertiesChange(Sender: TObject);
    procedure EDITORGetProperties(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
    procedure cxEditRepository1BotaoPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure chkEmaSaiClick(Sender: TObject);
    procedure ATIVOGetProperties(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
    procedure cxEditRepository1BtnOpcEnvioEmailCobPropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
    procedure ENVIOGetProperties(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
    procedure cxEditRepository1btnEmailFixoPropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
    procedure cxEditRepository1BtnEditarBtnOpcoesPropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
  private
    qryCfgEma: TUniQuery;
    cdsCfgEma: TUniClientDataSet;
    dspCfgEma: TUniDataSetProvider;

    FMostraAvisoProximoDiaUtil: Boolean;

    procedure pCarregaConfiguracoes;
    procedure pGravar;
    function fValidouSeEmailFixoTeveModeloCadastrado: Boolean;
    function fRetEspecieDocumento(strCodGru: String; strCodigo: String): String;
    procedure pCriarConfiguracoesPadrao(var AstrGrupos: String);
    procedure pCriarGrupoAvisosDeCobranca;
    function fPodeExibirOpcaoBoletoAposFaturamentoAutorizacaNFe() : Boolean;
    procedure pCriarGrupoAvisosDeDebitos;

    function ValidaSeOsModelosAtivosPossuemConteudo: Boolean;

    function ModelosAvisoDeCobrancaNecessariosConfigurados: Boolean;

    procedure pSetaModeloMensagemPadrao(const strAutInc, strCodGru, strCodigo: String);
    procedure pImportaModeloMensagemDeOutroGatilho(const strAutInc, strCodGru, strCodigo: String);

    function fRetAutIncGatilhosAtivados: String;
  public
    { Public declarations }
    property MostraAvisoProximoDiaUtil: Boolean read FMostraAvisoProximoDiaUtil write FMostraAvisoProximoDiaUtil Default False;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untCfgModeloEmail, untCfgEmailAutenticacao,
  untCfgClientesEmail, untCfgPortadoresAutorizadosEmail,
  untCfgEnvioXmlFornecedor, untDigQuantidade;

procedure TfrmCfgEmailAutSaida.ATIVOGetProperties(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  inherited;
  If Copy(ARecord.Values[GRUPO.Index],1,3) = '009' Then
     AProperties := cxEditRepository1Label1.Properties
  Else
  If Copy(ARecord.Values[GRUPO.Index],1,3) = '025' Then
     AProperties := cxEditRepository1Label1.Properties;
end;

procedure TfrmCfgEmailAutSaida.btnConfirmaClick(Sender: TObject);
begin
  If (Not fValidouSeEmailFixoTeveModeloCadastrado) Then
  Begin
    ModalResult := mrNone;
    Exit;
  End;

  If Not ValidaSeOsModelosAtivosPossuemConteudo Then
  Begin
    ModalResult := mrNone;
    Exit;
  End;

  If Not ModelosAvisoDeCobrancaNecessariosConfigurados Then
  Begin
    ModalResult := mrNone;
    Exit;
  End;

  inherited;

  pGravar;
end;

procedure TfrmCfgEmailAutSaida.EDITORGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
                                               Var AProperties: TcxCustomEditProperties);
begin
  inherited;
  If Copy(ARecord.Values[GRUPO.Index],1,3) = '009' Then
     AProperties := cxEditRepository1BtnOpcEnvioEmailCob.Properties
  Else
  If Copy(ARecord.Values[GRUPO.Index],1,3) = '025' Then
     AProperties := cxEditRepository1BtnOpcEnvioEmailCob.Properties
  Else If (Copy(ARecord.Values[GRUPO.Index],1,3) = '008') And Not Copy(ARecord.Values[DESCRIÇÃO.Index],1,16).Equals('Boleto Cancelado')  Then
    AProperties := cxEditRepository2Botoes.Properties
  Else If (Copy(ARecord.Values[GRUPO.Index],1,3) = '035') And (Copy(ARecord.Values[DESCRIÇÃO.Index],1,26).Equals('Envio de XML ao Fornecedor')) Then
    AProperties := cxEditRepository1BtnEditarBtnOpcoes.Properties
  Else If (Copy(ARecord.Values[GRUPO.Index],1,3) = '040') And (Copy(ARecord.Values[CODEMA.Index],1,3) = '001') Then
    AProperties := cxEditRepository1BtnEditarBtnOpcoes.Properties
  Else
    AProperties := cxEditRepository1Botao.Properties;
end;

procedure TfrmCfgEmailAutSaida.EDITORPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  inherited;
  {*************************************************************}
  {* Como os botões são setados dinamicamente (1 ou 2 botões), *}
  {* a chamada está no componente cxEditRepository.            *}
  {**********************************************************RP*}
end;

procedure TfrmCfgEmailAutSaida.chkEmaSaiClick(Sender: TObject);
begin
  inherited;
  cxGridCitel1.Enabled := chkEmaSai.Checked;
end;

procedure TfrmCfgEmailAutSaida.cxEditRepository1BotaoPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
  Var
    frmCfgClientesEmail: TfrmCfgClientesEmail;
    frmCfgPortadoresAutorizadosEmail: TfrmCfgPortadoresAutorizadosEmail;
begin
  inherited;
  If AButtonIndex = 0 Then //Editar Email
  Begin
    pCriarFormularios(TfrmCfgModeloEmail, frmCfgModeloEmail);
    frmCfgModeloEmail.Caption   := frmCfgModeloEmail.Caption + ' - ' + dtsEmaSai.DataSet.FieldByName('DESCRI').AsString;
    frmCfgModeloEmail.strSeqGer := dtsEmaSai.DataSet.FieldByName('AUTOIN').AsString;
    frmCfgModeloEmail.strEspDoc := fRetEspecieDocumento(dtsEmaSai.DataSet.FieldByName('CODGRU').AsString, dtsEmaSai.DataSet.FieldByName('CODEMA').AsString);
    frmCfgModeloEmail.strCodGru := dtsEmaSai.DataSet.FieldByName('CODGRU').AsString;
    frmCfgModeloEmail.strCodGat := dtsEmaSai.DataSet.FieldByName('CODEMA').AsString;
    frmCfgModeloEmail.blnExibirChkEnvXls := False;
    frmCfgModeloEmail.ShowModal();
    pFreeAndNil(frmCfgModeloEmail);
  End
  Else //Portadores Autorizados
  If AButtonIndex = 1 Then
  Begin
    pCriarFormularios(TfrmCfgPortadoresAutorizadosEmail, frmCfgPortadoresAutorizadosEmail);
    frmCfgPortadoresAutorizadosEmail.Caption   := dtsEmaSai.DataSet.FieldByName('GRUPOS').AsString + ' | ' + dtsEmaSai.DataSet.FieldByName('DESCRI').AsString;
    frmCfgPortadoresAutorizadosEmail.strSeqGer := dtsEmaSai.DataSet.FieldByName('CODEMA').AsString;
    frmCfgPortadoresAutorizadosEmail.strCodGru := dtsEmaSai.DataSet.FieldByName('CODGRU').AsString;
    frmCfgPortadoresAutorizadosEmail.intCodTip := 0;
    frmCfgPortadoresAutorizadosEmail.ShowModal();
    pFreeAndNil(frmCfgPortadoresAutorizadosEmail);
  End
  Else //Editar Clientes
  If AButtonIndex = 2 Then //Editar Email
  Begin
    pCriarFormularios(TfrmCfgClientesEmail, frmCfgClientesEmail);
    frmCfgClientesEmail.Caption := dtsEmaSai.DataSet.FieldByName('GRUPOS').AsString + ' | ' + dtsEmaSai.DataSet.FieldByName('DESCRI').AsString;
    frmCfgClientesEmail.strSeqGer := dtsEmaSai.DataSet.FieldByName('CODEMA').AsString;
    frmCfgClientesEmail.strCodGru := dtsEmaSai.DataSet.FieldByName('CODGRU').AsString;
    frmCfgClientesEmail.ShowModal();
    pFreeAndNil(frmCfgClientesEmail);
  End;
end;

procedure TfrmCfgEmailAutSaida.cxEditRepository1BtnEditarBtnOpcoesPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
var
  frmCfgEnvioXmlFornecedor: TfrmCfgEnvioXmlFornecedor;
  intQtdDig: Integer;
begin
  inherited;
  If AButtonIndex = 0 Then //Editar Email
  Begin
    pCriarFormularios(TfrmCfgModeloEmail, frmCfgModeloEmail);
    frmCfgModeloEmail.Caption   := frmCfgModeloEmail.Caption + ' - ' + dtsEmaSai.DataSet.FieldByName('DESCRI').AsString;
    frmCfgModeloEmail.blnExibirChkEnvDoc := False;
    frmCfgModeloEmail.strSeqGer := dtsEmaSai.DataSet.FieldByName('AUTOIN').AsString;
    frmCfgModeloEmail.strEspDoc := fRetEspecieDocumento(dtsEmaSai.DataSet.FieldByName('CODGRU').AsString, dtsEmaSai.DataSet.FieldByName('CODEMA').AsString);
    frmCfgModeloEmail.strCodGru := dtsEmaSai.DataSet.FieldByName('CODGRU').AsString;
    frmCfgModeloEmail.strCodGat := dtsEmaSai.DataSet.FieldByName('CODEMA').AsString;
    frmCfgModeloEmail.ShowModal();
    pFreeAndNil(frmCfgModeloEmail);
  End
  Else If AButtonIndex = 1 Then //opções envio
  Begin
    If (dtsEmaSai.DataSet.FieldByName('CODGRU').AsString = '035') And (dtsEmaSai.DataSet.FieldByName('DESCRI').AsString = 'Envio de XML ao Fornecedor') Then
    Begin
      pCriarFormularios(TfrmCfgEnvioXmlFornecedor, frmCfgEnvioXmlFornecedor);
      frmCfgEnvioXmlFornecedor.ShowModal();
      pFreeAndNil(frmCfgEnvioXmlFornecedor);
    End
    Else If (dtsEmaSai.DataSet.FieldByName('CODGRU').AsString = '040') And (dtsEmaSai.DataSet.FieldByName('CODEMA').AsString = '001') Then
    Begin
      intQtdDig := dtsEmaSai.DataSet.FieldByName('INTENV').AsInteger;
      if fDigQuantidade('Digite o intervalo de dias',
                        'Dias',
                        intQtdDig,
                        0,
                        100) then
      begin
        dtsEmaSai.DataSet.Edit;
        dtsEmaSai.DataSet.FieldByName('DESCRI').AsString := dtsEmaSai.DataSet.FieldByName('DESCRI').AsString.Replace(fStrZero(dtsEmaSai.DataSet.FieldByName('INTENV').AsString, 2), fStrZero(intQtdDig.ToString, 2));
        dtsEmaSai.DataSet.FieldByName('DESCRI').AsString := dtsEmaSai.DataSet.FieldByName('DESCRI').AsString.Replace('XX', fStrZero(intQtdDig.ToString, 2));
        dtsEmaSai.DataSet.FieldByName('INTENV').AsInteger := intQtdDig;
        dtsEmaSai.DataSet.Post;
      end;
    End;
  End;
end;

procedure TfrmCfgEmailAutSaida.cxEditRepository1btnEmailFixoPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  If AButtonIndex = 0 Then
    ENVIOPropertiesChange(ENVIO);
end;

procedure TfrmCfgEmailAutSaida.cxEditRepository1BtnOpcEnvioEmailCobPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;

  Try
    If dtsEmaSai.DataSet.FieldByName('CODGRU').AsString = '009' Then
    Begin
       pCriarFormularios(TfrmCfgEmailAviCob, frmCfgEmailAviCob);
       frmCfgEmailAviCob.blnAntes := (Pos('Antes',dtsEmaSai.DataSet.FieldByName('DESCRI').AsString) > 0);
       frmCfgEmailAviCob.MostraAvisoProximoDiaUtil := FMostraAvisoProximoDiaUtil;
       frmCfgEmailAviCob.ShowModal();
    End
    Else
    If dtsEmaSai.DataSet.FieldByName('CODGRU').AsString = '025' Then
    Begin
       pCriarFormularios(TfrmCfgEmailAviDeb, frmCfgEmailAviDeb);
       frmCfgEmailAviDeb.ShowModal();
    End;
  Finally
    If dtsEmaSai.DataSet.FieldByName('CODGRU').AsString = '009' Then
       pFreeAndNil(frmCfgEmailAviCob);

    If dtsEmaSai.DataSet.FieldByName('CODGRU').AsString = '025' Then
       pFreeAndNil(frmCfgEmailAviDeb);

  End;

end;

procedure TfrmCfgEmailAutSaida.ENVIOGetProperties(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  inherited;
  If Copy(ARecord.Values[GRUPO.Index],1,3) = '009' Then
    AProperties := cxEditRepository1Label1.Properties
  Else
  If Copy(ARecord.Values[GRUPO.Index],1,3) = '025' Then
    AProperties := cxEditRepository1Label1.Properties
  Else If MatchStr(Copy(ARecord.Values[GRUPO.Index],1,3),['027']) Then
 Begin
   AProperties := cxEditRepository1btnEmailFixo.Properties;
 End ;

  Sender.Options.ShowEditButtons := isebAlways;
end;

procedure TfrmCfgEmailAutSaida.ENVIOPropertiesChange(Sender: TObject);
begin
  inherited;


  If MatchStr(dtsEmaSai.DataSet.Fieldbyname('CODGRU').AsString, ['009','027']) And
     (dtsEmaSai.DataSet.Fieldbyname('PROENV').AsString <> 'F') Then
  Begin
    dtsEmaSai.DataSet.Fieldbyname('PROENV').Clear;
    fMensagem('ATENÇÃO', 'A forma de envio dos itens no grupo '+dtsEmaSai.DataSet.Fieldbyname('CODGRU').AsString
                        +' devem ser apenas por "Email Fixo"', ['&OK'], 0);
    Exit;
  End;

  If (dtsEmaSai.DataSet.State = dsEdit) Then
    dtsEmaSai.DataSet.Post;

  If dtsEmaSai.DataSet.Fieldbyname('PROENV').AsString = 'F' Then
  Begin
    Try
      pCriarFormularios(TfrmCfgEmailAutenticacao, frmCfgEmailAutenticacao);
      frmCfgEmailAutenticacao.strSeqGer := dtsEmaSai.DataSet.FieldByName('AUTOIN').AsString;
      frmCfgEmailAutenticacao.ShowModal();
    Except
      On E: Exception Do
        pMensagensErro(e.Message, '[TfrmCfgEmailAutSaida.ENVIOPropertiesChange]');
    End;

    pFreeAndNil(frmCfgEmailAutenticacao);

  End;
end;

procedure TfrmCfgEmailAutSaida.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryCfgEma);
  FreeAndNil(dspCfgEma);
  FreeAndNil(cdsCfgEma);
end;

procedure TfrmCfgEmailAutSaida.FormShow(Sender: TObject);
begin
  inherited;
  qryCfgEma := fCriaQuery(Self);
  dspCfgEma := TUniDataSetProvider.Create(Self);
  cdsCfgEma := TUniClientDataSet.Create(Self);

  dspCfgEma.DataSet := qryCfgEma;
  cdsCfgEma.SetProvider(dspCfgEma);

  dtsEmaSai.DataSet := cdsCfgEma;
  pCarregaConfiguracoes;
  cxGridCitelTableView.ViewData.Expand(True);
end;

function TfrmCfgEmailAutSaida.fRetEspecieDocumento(strCodGru: String; strCodigo: String): String;
begin
  Result := '';

  If (strCodGru = '001') Then
    Result := 'OR'
  Else If (strCodGru = '002') Then
    Result := 'PD'
  Else If (strCodGru = '003') Then
    Result := 'E2'
  Else If (strCodGru = '004') Then
    Result := 'E3'
  Else If (strCodGru = '005') Then
    Result := 'E4'
  Else If (strCodGru = '006') Then
    Result := 'RO'
  Else If (strCodGru = '007') Then
    Result := 'E5'
  Else If (strCodGru = '008') Then
    Result := 'BO'
  Else If (strCodGru = '009') Then
    Result := 'AC'
  Else If (strCodGru = '010') Then
    Result := 'E6'
  Else If (strCodGru = '011') Then
    Result := 'CD'
  Else If (strCodGru = '012') Then
    Result := 'CE'
  Else If (strCodGru = '013') Then
  Begin
    If (strCodigo = '002') Then
      Result := 'PC'
    Else
      Result := 'CF';
  End
  Else If (strCodGru = '014') Then
    Result := 'PX'
  Else If (strCodGru = '015') Then
    Result := 'EF'
  Else If (strCodGru = '016') Then
    Result := 'TE'
  Else If (strCodGru = '039') Then
    Result := 'CB'
  Else If (Pos(strCodGru, '035_036_038_') > 0) Then
    Result := 'AN'
  Else If (strCodGru = '037') Then
    Result := 'FF'
  Else If (strCodGru = '022') Then
    Result := 'RC'
  Else If (strCodGru = '023') Then
  Begin
    If fCfgSis('LECRSN', varBoolean) Then
      Result := 'RL'
    Else
      Result := 'LE';
  End
  Else If (strCodGru = '025') Then
    Result := 'AD'
  Else If (strCodGru = '027') Then
    Result := 'ET'
  Else If (strCodGru = '028') Then
    Result := 'DC'
  Else If (strCodGru = '029') Then
    Result := 'CH'
  Else If (strCodGru = '040') Then
    Result := 'CL'
  Else If (strCodGru = '030') Then
    Result := 'AI'
  Else If (strCodGru = '046') Then
    Result := 'RE';
end;

procedure TfrmCfgEmailAutSaida.pCarregaConfiguracoes;
Var
  strSQL: String;
  strGrupos: String;
begin
  chkEmaSai.Checked := fCfgSisL('EMASAI', VarString) <> 'Desativado';
  cxGridCitel1.Enabled := chkEmaSai.Checked;

  //rotina responsável pela criação dos grupos
  //e gatilhos padrão para a empresa logada
  pCriarConfiguracoesPadrao(strGrupos);

  Try

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CONCAT(GRU_CODGRU, "-", GRU_DESGRU) AS GRUPOS, ';
    strSQL := strSQL + '  GRU_CODGRU        AS CODGRU, ';
    strSQL := strSQL + '  EMA_CODIGO        AS CODEMA, ';
    strSQL := strSQL + '  EMA_CODEMP        AS CODEMP, ';
    strSQL := strSQL + '  EMA_STATUS        AS STATUS, ';

    strSQL := strSQL + '  IF((EMA_CODGRU = "040" AND EMA_CODIGO = "001"), '+
                             'REPLACE(EMA_DESCRI, "XX", COALESCE(LPAD(CAST(EMA_INTENV AS CHAR), 2, "0"), "XX")), '+
                             'EMA_DESCRI) AS DESCRI, ';

    strSQL := strSQL + '  IF(GRU_CODGRU="009", "F", EMA_PROENV) AS PROENV, ';
    strSQL := strSQL + '  EMA_ORDENA        AS ORDENA, ';
    strSQL := strSQL + '  EMA_INTENV        AS INTENV, ';
    strSQL := strSQL + '  EMASAI.AUTOINCREM AS AUTOIN  ';
    strSQL := strSQL + 'FROM      ';
    strSQL := strSQL + '  EMASAI  ';
    strSQL := strSQL + '  INNER JOIN GRUEMA ON GRU_ENTSAI = EMA_ENTSAI ';
    strSQL := strSQL + '         AND GRU_CODGRU = EMA_CODGRU ';
    strSQL := strSQL + 'WHERE     ';
    strSQL := strSQL + '  EMA_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  EMA_ENTSAI = :ENTSAI AND ';
    strSQL := strSQL + '  GRU_CODGRU IN ('+strGrupos+') ';

    If Not fCfgSis('USAPIX', varBoolean) Then
      strSQL := strSQL + ' AND GRU_CODGRU <> "014" ';

    strSQL := strSQL + ' AND GRU_CODGRU <> "009" ';

    strSQL := strSQL + ' AND GRU_CODGRU <> "025" ';

    If (not fPodeExibirOpcaoBoletoAposFaturamentoAutorizacaNFe) Then
      strSQL := strSQL + ' AND (NOT (EMA_CODGRU = "008" AND EMA_CODIGO = "004")) ';

    strSQL := strSQL + 'ORDER BY  ';
    strSQL := strSQL + '  CODGRU, ';
    strSQL := strSQL + '  ORDENA  ';

    qryCfgEma.Close;
    qryCfgEma.SQL.Clear;
    qryCfgEma.SQL.Add(strSQL);

    qryCfgEma.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryCfgEma.ParamByName('ENTSAI').AsString := 'S';
    qryCfgEma.Open;

    pSetaClient(qryCfgEma);
    cdsCfgEma.Open;
    pSetaClient(cdsCfgEma);

    pCriarGrupoAvisosDeCobranca;
    pCriarGrupoAvisosDeDebitos;

    cdsCfgEma.DisableControls;
    If cdsCfgEma.Locate('CODGRU;CODEMA',
                         VarArrayOf(['002', '009']), []) Then
    Begin
      cdsCfgEma.Edit;
      cdsCfgEma.FieldByName('DESCRI').AsString := 'Inclusão/Alteração do Pedido - Pix';
      cdsCfgEma.Post;
    End;
    cdsCfgEma.First;
    cdsCfgEma.EnableControls;

  Except
    On E:Exception Do
      pMensagensErro(e.Message, '[TfrmCfgEmailAutSaida.pCarregaConfiguracoes]');
  End;

end;

{ ************************************************ }
{ SEMPRE QUE UM NOVO GRUPO OU UM NOVO GATILHO      }
{ FOR CRIADO O INSERT DEVERÁ SER INSERIDO AQUI     }
{ PARA A CRIAÇÃO NA EMPRESA LOGADA CASO NÃO EXISTA }
{ *********************************************DF* }
procedure TfrmCfgEmailAutSaida.pCriarConfiguracoesPadrao(var AstrGrupos: String);
  Var
    i, j, k: Integer;
    qryTemp: TUniQuery;

  Const
    arrCodGruEma: Array [1..30] Of String = ('001', '002', '003', '004', '005', '006', '007', '008', '009', '010', '011', '012', '013',
                                             '014', '015', '016', '022', '023', '025','027', '028','029', '035', '036', '037', '038', '039',
                                             '040', '030', '046');

    arrDesGruEma: Array [1..30] Of String = ('Orçamento de Venda',
                                             'Pedido de Venda',
                                             'Expedição Tipo [2]: Faturamento antes da expedição',
                                             'Expedição Tipo [3]: Faturamento depois da expedição',
                                             'Expedição Tipo [4]: O pedido não será faturado',
                                             'Romaneio com Expedição Tipo [2/3/4]',
                                             'Expedição Tipo [5]: Expedição por romaneio. O pedido não será faturado',
                                             'Envio de Boleto',
                                             'Avisos de Cobrança',
                                             'Expedição de Promoções',
                                             'Cupom de Desconto',
                                             'Conserto de Equipamentos ',
                                             'Confirmação de Documentos',
                                             'Pix',
                                             'Entrega Futura',
                                             'App Ta Entregue',
                                             'Informações de Cobrança',
                                             'Locação de Equipamento',
                                             'Avisos de Débitos',
                                             'Extrato de Cobrança',
                                             'Devolução CRM',
                                             'Cashback Venda',
                                             'Faturamento NFe',
                                             'Faturamento NFCe',
                                             'Faturamento Futuro',
                                             'Faturamento NFSe',
                                             'Cobrança Eletrônica',
                                             'Cliente',
                                             'Avisos Intelipost',
                                             'Rastreamento da Entrega');

    arrTamGruEma: Array [1..30] Of Integer = (10, 9, 1, 3, 4, 2, 6, 4, 17, 1, 1, 1, 2, 2, 1, 3, 1, 1, 2, 1, 1, 2, 3, 1, 1, 1, 1, 1, 1, 2);

    arrCodEmaSai: Array [1..86] Of String = ({Grupo: Orçamento de Venda}
                                             '001', '002', '003', '004', '005', '006', '007', '009', '010', '011',
                                             {Grupo: Pedido de Venda}
                                             '001', '002', '003', '004', '005', '006', '007', '008', '009',
                                             {Grupo: Expedição Tipo [2]: Faturamento antes da expedição}
                                             '001',
                                             {Grupo: Expedição Tipo [3]: Faturamento depois da expedição}
                                             '001', '002', '003',
                                             {Grupo: Expedição Tipo [4]: O pedido não será faturado}
                                             '001', '002', '003', '004',
                                             {Grupo: Romaneio com Expedição Tipo [2/3/4]}
                                             '001', '002',
                                             {Grupo: Expedição Tipo [5]: Expedição por romaneio. O pedido não será faturado}
                                             '001', '002', '003', '004', '005', '006',
                                             {Grupo: Envio de Boleto}
                                             '001', '002','003', '004',
                                             {Grupo: Avisos de Cobrança}
                                             '001', '002', '003','004','011','012','013','014','015','016','018','019','020','021','022','023','024',
                                             {Grupo: Expedição de Promoções}
                                             '001',
                                             {Grupo: Cupom de Desconto}
                                             '001',
                                             {Grupo: Conserto de Equipamentos}
                                             '001',
                                             {Grupo: Confirmação de Documentos}
                                             '001', '002',
                                             {Grupo: Pix}
                                             '001', '002',
                                             {Grupo: Entrega Futura}
                                             '001',
                                             {Grupo: App Ta Entregue}
                                             '001', '002', '003',
                                             {Grupo: Reimpressao de Cobranca}
                                             '001',
                                             {Grupo: Faturamento do Contrato}
                                             '001',
                                             {Grupo: Avisos de Débitos}
                                             '001', '002',
                                             {Grupo: Extrato de cobrança}
                                             '001',
                                             {Grupo:'Devolução CRM'}
                                             '001',
                                             {Grupo: Cashback Venda}
                                             '001', '002',
                                             {Grupo: Faturamento NFe}
                                             '001', '002', '004',
                                             {Grupo: Faturamento NFCe}
                                             '001',
                                             {Grupo: Faturamento Futuro}
                                             '001',
                                             {Grupo: Faturamento NFSe}
                                             '001',
                                             {Grupo: Cobrança Eletrônica}
                                             '001',
                                             {Grupo: Cliente}
                                             '001',
                                             {Grupo: Avisos Intelipost}
                                             '001',
                                             {Grupo: Rastreamento da Entrega}
                                             '001', '002');

    arrDesEmaSai: Array [1..86] Of String = ({Grupo: Orçamento de Venda}
                                             'Inclusão do Orçamento',
                                             'Alteração do Orçamento',
                                             'Transformação do Orçamento em Pedido de Venda',
                                             'Faturamento do Orçamento em documento de Venda ( F11, Venda Normal )',
                                             '[F10] Baixa de Orçamento que não será entregue',
                                             'Cancelamento do Orçamento',
                                             'Envio manual pela consulta de orçamentos ou reimpressão de documentos',
                                             'Aviso de Orçamento em aberto há 1 dia',
                                             'Aviso de Orçamento em aberto há 2 dias',
                                             'Aviso de Orçamento em aberto há 3 dias',
                                             {Grupo: Pedido de Venda}
                                             'Inclusão do Pedido',
                                             'Impressao da Separação',
                                             'Alteração do Pedido',
                                             'Faturamento Parcial do Pedido documento de Venda ( CONF.DE PEDIDOS )',
                                             'Faturamento Total do Pedido documento de Venda ( F11, VENDA NORMAL, CONF.DE PEDIDOS )',
                                             '[F10] Baixa de Pedido que não será entregue',
                                             'Cancelamento do Pedido',
                                             'Envio manual pela consulta de pedidos ou reimpressão de documentos',
                                             'Inclusão do Pedido - Pix',
                                             {Grupo: Expedição Tipo [2]: Faturamento antes da expedição}
                                             'Baixa da Expedição',
                                             {Grupo: Expedição Tipo [3]: Faturamento depois da expedição}
                                             'Impressão da Separação',
                                             'Faturamento Parcial do Pedido documento de Venda ( EXPEDIÇÃO )',
                                             'Faturamento Total do Pedido documento de Venda ( EXPEDIÇÃO )',
                                             {Grupo: Expedição Tipo [4]: O pedido não será faturado}
                                             'Impressão da Separação',
                                             'Conferência da Expedição',
                                             'Faturamento Parcial do Pedido documento de Venda ( EXPEDIÇÃO )',
                                             'Faturamento Total do Pedido documento de Venda ( EXPEDIÇÃO )',
                                             {Grupo: Romaneio com Expedição Tipo [2/3/4]}
                                             'Inclusão do Pedido no Romaneio ou Inclusão do Documento de Venda no Romaneio',
                                             'Baixa do Romaneio',
                                             {Grupo: Expedição Tipo [5]: Expedição por romaneio. O pedido não será faturado}
                                             'Inclusão do Pedido no Pré-Romaneio',
                                             'Impressão da Separação',
                                             'Conferência da Expedição',
                                             'Faturamento Total do Pedido documento de Venda ( EXPEDIÇÃO )',
                                             'Ativação do Pré-Romaneio',
                                             'Baixa do Romaneio',
                                             {Grupo: Envio de Boleto}
                                             'Boleto após faturamento',
                                             'Boleto após Confirmação faturamento',
                                             'Boleto Cancelado',
                                             'Boleto após faturamento e autorização de NFe',
                                             {Grupo: Avisos de Cobrança}
                                             'Aviso de cobrança 2 dias antes do vencimento',
                                             'Aviso de cobrança 3 dias após vencimento',
                                             'Aviso de cobrança 5 dias após vencimento',
                                             'Aviso de cobrança 1 dia antes do vencimento', //teve que ficar nessa posição pra nao dar problema nos clientes que ja usavam outras opções;
                                             'Aviso de cobrança 8 dias após vencimento',
                                             //
                                             'Aviso de cobrança 6 dias após vencimento',  //'012'
                                             'Aviso de cobrança 7 dias após vencimento',  //'013'
                                             'Aviso de cobrança 9 dias após vencimento',  //'014'
                                             'Aviso de cobrança 10 dias após vencimento', //'015'
                                             //
                                             'Aviso de cobrança 6 dias antes do vencimento',  //'016'
                                             'Aviso de cobrança 7 dias antes do vencimento',  //'018'
                                             'Aviso de cobrança 8 dias antes do vencimento',  //'019'
                                             'Aviso de cobrança 9 dias antes do vencimento',  //'020'
                                             'Aviso de cobrança 10 dias antes do vencimento', //'021'
                                             'Aviso de cobrança 30 dias após vencimento',    //'022'
                                             //
                                             'Aviso de cobrança antes do vencimento (Próximo dia útil) ', //'023'
                                             'Aviso de cobrança após vencimento (Próximo dia útil)',      //'024'
                                             {Grupo: Expedição de Promoções}
                                             'Catálogo de Promoções',
                                             {Grupo: Cupom de Descconto}
                                             'Venda gerou cupom de desconto',
                                             {Conserto de Equipamentos}
                                             'F9 Envio de E-mails - Consulta de OS',
                                             {Grupo: Confirmação de Documentos}
                                             'Inclusão de Confirmação',
                                             'Envio de Pix para pagamento de duplicatas gerada na confirmação',
                                             {Grupo: Pix}
                                             'Envio de Pix para pagamento de duplicatas - Baixa de Contas a Receber',
                                             'Envio de Pix para geração de crédito ao cliente - Relação de Documentos com Pix Gerados',
                                             {Grupo: Entrega Futura}
                                             'Aviso de Baixa de Entrega Futura ao Cliente',
                                             {Grupo: App Ta Entregue}
                                             'Rota Iniciada',
                                             'Aviso de Ocorrência na Entrega',
                                             'Entrega Concluída',
                                             {Grupo: Reimpressao de Cobranca}
                                             'Envio de Nota Fiscal',
                                             {Grupo: Locação de Impressão}
                                             'Faturamento do Contrato',
                                             {Grupo: Avisos de Débitos}
                                             'Aviso de Débito todo dia 01 de cada mês',
                                             'Aviso de Débito todo dia 16 de cada mês',
                                             'Envio de extrato para cobrança',
                                             {Grupo: Devolução CRM}
                                             'Inclusão de Devolução CRM',
                                             {Grupo: Cashback}
                                             'Geração de Cashback',
                                             'Cashback - 7 dias antes do vencimento',
                                             {Grupo: Faturamento NFe}
                                             'Pós Autorização de Documento Fiscal',
                                             'Envio de XML ao Fornecedor',
                                             'Envio de Nota Fiscal para Transportadora',
                                             {Grupo: Faturamento NFCe}
                                             'Pós Autorização de Documento Fiscal',
                                             {Grupo: Faturamento Futuro}
                                             'Inclusão de Faturamento Futuro',
                                             {Grupo: Faturamento NFSe}
                                             'Pós Autorização de Documento Fiscal',
                                             {Grupo: Cobrança Eletrônica}
                                             'Mensagem de Link de Pagamento',
                                             {Grupo: Clientes}
                                             'Clientes que compraram nos últimos XX dias',
                                             {Grupo: Avisos Intelipost}
                                             'Atualização de Status de Entrega',
                                             {Grupo: Rastreamento da Entrega}
                                             'Envio do código de rastreamento - Correio',
                                             'Envio do código de rastreamento - Acompanhamento de Entrega');

  procedure pInicializarQuery;
  begin
    qryTemp := fCriaQuery(nil);
    qryTemp.Close();
    qryTemp.SQL.Clear();
  end;

  function fExisteGruEma(strCodGru: String): Boolean;
  begin
    Result := ( Not fEmptyStr( fCampoTabela('AUTOINCREM',
                                            'GRUEMA',
                                            ['GRU_ENTSAI', 'GRU_CODGRU'],
                                            ['S', strCodGru]) ) );
  end;

  procedure pIncluirRegistroGruEma(strCodGru, strDesGru: String);
  begin
    qryTemp.Close();
    qryTemp.SQL.Clear();
    qryTemp.SQL.Text := 'INSERT INTO GRUEMA (AUTOINCREM, GRU_CODGRU, GRU_CODEMP, GRU_DESGRU) ' +
      ' VALUES (:AUTINC, :CODGRU, :CODEMP, :DESGRU)';
    qryTemp.ParamByName('AUTINC').AsString := fRetAutoIncrem('GRUEMA', VS_strCodEmp);
    qryTemp.ParamByName('CODGRU').AsString := strCodGru;
    qryTemp.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryTemp.ParamByName('DESGRU').AsString := strDesGru;
    qryTemp.ExecSQL();
  end;

  function fExisteEmaSai(strCodGru, strCodigo: String): Boolean;
  begin
    Result := ( Not fEmptyStr( fCampoTabela('AUTOINCREM',
                                            'EMASAI',
                                            ['EMA_CODIGO', 'EMA_ENTSAI', 'EMA_CODGRU', 'EMA_CODEMP'],
                                            [strCodigo, 'S', strCodGru, VS_strCodEmp]) ) );
  end;

  procedure pIncluirRegistroEmaSai(strCodigo, strCodGru, strDescri: String);
    var strCodAlt : string;
    strAutInc : String;
  begin

    // Validação feita para jogar o novo registro incluido, para ser o primeiro da lista;
    strCodAlt := strCodigo;
    If (strCodGru = '009') Then
        If (strCodigo = '004') Then
            strCodAlt := '0';

    qryTemp.Close();
    qryTemp.SQL.Clear();
    qryTemp.SQL.Text := 'INSERT INTO EMASAI (AUTOINCREM, EMA_CODIGO, EMA_CODGRU, EMA_CODEMP, EMA_DESCRI, ' +
      'EMA_PROENV, EMA_STATUS, EMA_ORDENA) VALUES (:AUTINC, :CODIGO, :CODGRU, :CODEMP, :DESCRI, ' +
      ':PROENV, :STATUS, :ORDENA)';

    strAutInc := fRetAutoIncrem('EMASAI', VS_strCodEmp);
    qryTemp.ParamByName('AUTINC').AsString := strAutInc;
    qryTemp.ParamByName('CODIGO').AsString := strCodigo;
    qryTemp.ParamByName('CODGRU').AsString := strCodGru;
    qryTemp.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryTemp.ParamByName('DESCRI').AsString := strDescri;
    qryTemp.ParamByName('PROENV').AsString := IIF(MatchStr(strCodGru, ['009', '025','027']), 'F', 'O');
    qryTemp.ParamByName('STATUS').AsString := 'I';
    qryTemp.ParamByName('ORDENA').AsString := strCodAlt;//strCodigo;
    qryTemp.ExecSQL();

    pSetaModeloMensagemPadrao(strAutInc, strCodGru, strCodigo);
  end;

begin
  AstrGrupos := String.Join(',', arrCodGruEma);

  Try
    k := 1;
    pInicializarQuery();

    Try
      fStartTransaction();

      For i := 1 To Length(arrCodGruEma) Do Begin

        If (Not fExisteGruEma(arrCodGruEma[i])) Then
          pIncluirRegistroGruEma(arrCodGruEma[i], arrDesGruEma[i]);

        For j := 1 To arrTamGruEma[i] Do Begin
          If (Not fExisteEmaSai(arrCodGruEma[i], arrCodEmaSai[k])) Then
            pIncluirRegistroEmaSai(arrCodEmaSai[k], arrCodGruEma[i], arrDesEmaSai[k]);

          k := k + 1;
        End;
      End;

	    fCommit();
    Except
      On E: Exception Do Begin
        fRollBack();
        pMensagensErro(e.Message, '[TfrmCfgEmailAutSaida.pCriarConfiguracoesPadrao]')
      End;
    End;
  Finally
    FreeAndNil(qryTemp);
  End;
end;

procedure TfrmCfgEmailAutSaida.pSetaModeloMensagemPadrao(const strAutInc, strCodGru, strCodigo: String);
begin
  if Pos(strCodGru, '035_036_037_038_039_') > 0 then
    pImportaModeloMensagemDeOutroGatilho(strAutInc, strCodGru, strCodigo);
end;

procedure TfrmCfgEmailAutSaida.pImportaModeloMensagemDeOutroGatilho(const strAutInc, strCodGru, strCodigo: String);
var
  qryModelo: TUniQuery;
  qryAux: TUniQuery;
strVersaoAutcom: String;
begin
  strVersaoAutcom := fGetVersaoAutcom;

  qryModelo := fCriaQuery;
  qryAux := fCriaQuery;
  try
    qryModelo.Close;
    qryModelo.SQL.Text :=
    ' SELECT '+
    '   MOD_MODELO, '+
    '   MOD_ENVDOC, '+
    '   MOD_ENVXML, '+
    '   MOD_ASSUNT, '+
    '   EMA_PROENV, '+
    '   CFG_CODPRV, '+
    '   CFG_SENEMA, '+
    '   CFG_EMAIL_, '+
    '   CFG_ASSTXT, '+
    '   CFG_ASSIMG, '+
    '   CFG_EMALOG, '+
    '   CFG_REMETE, '+
    '   CFG_ASSB64, '+
    '   CFG_EMA_ID  '+
    ' FROM '+
    '   EMASAI '+
    ' INNER JOIN MODEMA '+
    '   ON EMASAI.AUTOINCREM = MODEMA.MOD_SEQGER '+
    ' LEFT JOIN CFGEMA '+
    '   ON EMASAI.AUTOINCREM = CFGEMA.CFG_SEQGER '+
    ' WHERE '+
    '   EMA_CODGRU = :CODGRU AND '+
    '   EMA_CODEMP = :CODEMP AND '+
    '   EMA_CODIGO = :CODIGO AND '+
    '   EMA_STATUS = :STATUS ';

    case AnsiIndexStr(strCodGru, ['035', '036', '037', '038', '039']) of
      0: qryModelo.ParamByName('CODGRU').AsString := IIF(Pos('30.72', strVersaoAutcom) > 0, '017', '018');
      1: qryModelo.ParamByName('CODGRU').AsString := IIF(Pos('30.72', strVersaoAutcom) > 0, '018', '019');
      2: qryModelo.ParamByName('CODGRU').AsString := IIF(Pos('30.72', strVersaoAutcom) > 0, '019', '020');
      3: qryModelo.ParamByName('CODGRU').AsString := IIF(Pos('30.72', strVersaoAutcom) > 0, '020', '021');
      4: begin
           if Pos('30.72', strVersaoAutcom) > 0 then
             Exit;

           qryModelo.ParamByName('CODGRU').AsString := '017';
         end;
    end;

    qryModelo.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryModelo.ParamByName('CODIGO').AsString := strCodigo;
    qryModelo.ParamByName('STATUS').AsString := 'A';
    qryModelo.Open;

    if qryModelo.IsEmpty then
      Exit;

    qryAux.Close;
    qryAux.SQL.Text :=
    'INSERT INTO '+
    '  MODEMA(AUTOINCREM,  '+
    '         MOD_SEQGER,  '+
    '         MOD_MODELO,  '+
    '         MOD_ENVDOC,  '+
    '         MOD_ENVXML,  '+
    '         MOD_ASSUNT)  '+
    '  VALUES(:AUTINC,     '+
    '         :SEQGER,     '+
    '         :MODELO,     '+
    '         :ENVDOC,     '+
    '         :ENVXML,     '+
    '         :ASSUNT)     ';

    qryAux.ParamByName('AUTINC').AsString := fRetAutoIncrem('MODEMA', VS_strCodEmp);
    qryAux.ParamByName('SEQGER').AsString := strAutInc;
    qryAux.ParamByName('MODELO').AsString := qryModelo.FieldByName('MOD_MODELO').AsString;
    qryAux.ParamByName('ENVDOC').AsString := qryModelo.FieldByName('MOD_ENVDOC').AsString;
    qryAux.ParamByName('ENVXML').AsString := qryModelo.FieldByName('MOD_ENVXML').AsString;
    qryAux.ParamByName('ASSUNT').AsString := qryModelo.FieldByName('MOD_ASSUNT').AsString;
    qryAux.ExecSQL;

    qryAux.Close;
    qryAux.SQL.Text :=
    ' UPDATE '+
    '   EMASAI '+
    ' SET '+
    '   EMA_STATUS = "A", ' +
    '   EMA_PROENV = :PROENV '+
    ' WHERE '+
    '   AUTOINCREM = :AUTINC ';

    qryAux.ParamByName('AUTINC').AsString := strAutInc;
    qryAux.ParamByName('PROENV').AsString := qryModelo.FieldByName('EMA_PROENV').AsString;
    qryAux.ExecSQL;

    if qryModelo.FieldByName('EMA_PROENV').AsString = 'F' then
    begin
      qryAux.Close;
      qryAux.SQL.Text :=
      'INSERT INTO '+
      '  CFGEMA(AUTOINCREM,  '+
      '         CFG_CODEMP,  '+
      '         CFG_SEQGER,  '+
      '         CFG_CODPRV,  '+
      '         CFG_SENEMA,  '+
      '         CFG_EMAIL_,  '+
      '         CFG_ASSTXT,  '+
      '         CFG_ASSIMG,  '+
      '         CFG_EMALOG,  '+
      '         CFG_REMETE,  '+
      '         CFG_ASSB64,  '+
      '         CFG_EMA_ID)  '+
      '  VALUES(:AUTINC,     '+
      '         :CODEMP,  '+
      '         :SEQGER,  '+
      '         :CODPRV,  '+
      '         :SENEMA,  '+
      '         :EMAIL_,  '+
      '         :ASSTXT,  '+
      '         :ASSIMG,  '+
      '         :EMALOG,  '+
      '         :REMETE,  '+
      '         :ASSB64,  '+
      '         :EMA_ID)  ';

      qryAux.ParamByName('AUTINC').AsString := fRetAutoIncrem('CFGEMA', VS_strCodEmp);
      qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryAux.ParamByName('SEQGER').AsString := strAutInc;
      qryAux.ParamByName('CODPRV').AsString := qryModelo.FieldByName('CFG_CODPRV').AsString;
      qryAux.ParamByName('SENEMA').AsString := qryModelo.FieldByName('CFG_SENEMA').AsString;
      qryAux.ParamByName('EMAIL_').AsString := qryModelo.FieldByName('CFG_EMAIL_').AsString;
      qryAux.ParamByName('ASSTXT').AsString := qryModelo.FieldByName('CFG_ASSTXT').AsString;
      qryAux.ParamByName('ASSIMG').AsString := qryModelo.FieldByName('CFG_ASSIMG').AsString;
      qryAux.ParamByName('EMALOG').AsString := qryModelo.FieldByName('CFG_EMALOG').AsString;
      qryAux.ParamByName('REMETE').AsString := qryModelo.FieldByName('CFG_REMETE').AsString;
      qryAux.ParamByName('ASSB64').AsString := qryModelo.FieldByName('CFG_ASSB64').AsString;
      qryAux.ParamByName('EMA_ID').AsString := qryModelo.FieldByName('CFG_EMA_ID').AsString;
      qryAux.ExecSQL;
    end;
  finally
    FreeAndNil(qryModelo);
    FreeAndNil(qryAux);
  end;
end;

procedure TfrmCfgEmailAutSaida.pGravar;
Var
  qryGravar: TUniQuery;
  strSQL   : String;
begin
  fAtuCfgSis('EMASAI', IIF(chkEmaSai.Checked, 'Ativado', 'Desativado'));

  qryGravar := fCriaQuery(Self);
  Try
    cdsCfgEma.DisableControls;

    Try
      strSQL := '';
      strSQL := strSQL + 'UPDATE           ';
      strSQL := strSQL + '  EMASAI         ';
      strSQL := strSQL + 'SET              ';
      strSQL := strSQL + '  EMA_STATUS = :STATUS,    ';
      strSQL := strSQL + '  EMA_PROENV = :PROENV,    ';
      strSQL := strSQL + '  EMA_INTENV = :INTENV     ';
      strSQL := strSQL + 'WHERE            ';
      strSQL := strSQL + '  AUTOINCREM = :AUTOIN AND ';
      strSQL := strSQL + '  EMA_CODEMP = :CODEMP     ';

      cdsCfgEma.First;

      While Not cdsCfgEma.Eof Do
      Begin
        If (Not cdsCfgEma.FieldByName('CODGRU').AsString.Equals('009')) And (Not cdsCfgEma.FieldByName('CODGRU').AsString.Equals('025')) Then
        Begin
          qryGravar.Close;
          qryGravar.SQL.Clear;
          qryGravar.SQL.Add(strSQL);
          qryGravar.ParamByName('STATUS').AsString := cdsCfgEma.FieldByName('STATUS').AsString;
          qryGravar.ParamByName('PROENV').AsString := IIF(MatchStr(Copy(cdsCfgEma.FieldByName('CODGRU').AsString,1,3),['025','027']),
                                                          'F',
                                                          cdsCfgEma.FieldByName('PROENV').AsString);
          qryGravar.ParamByName('AUTOIN').AsString := cdsCfgEma.FieldByName('AUTOIN').AsString;
          qryGravar.ParamByName('CODEMP').AsString := cdsCfgEma.FieldByName('CODEMP').AsString;
          qryGravar.ParamByName('INTENV').AsInteger := cdsCfgEma.FieldByName('INTENV').AsInteger;
          qryGravar.ExecSQL;
        End;

        cdsCfgEma.Next;
      End;

    Except
      On E: Exception Do
        pMensagensErro(e.Message, '[TfrmCfgEmailAutSaida.pGravar]')
    End;
  Finally
    FreeAndNil(qryGravar);
    cdsCfgEma.EnableControls;
  End;

end;

function TfrmCfgEmailAutSaida.fValidouSeEmailFixoTeveModeloCadastrado: Boolean;
  Var
    strMsg: String;
    strAss: String;
    intQtdLinha: Integer;
    intRecNo: Integer;
begin
  Result := True;

  intRecNo := cdsCfgEma.RecNo;

  cdsCfgEma.DisableControls;
  Try
    cdsCfgEma.First;
    intQtdLinha := 0;
    While Not cdsCfgEma.Eof Do
    Begin
      If (cdsCfgEma.FieldByName('STATUS').AsString = 'A') And
         (cdsCfgEma.FieldByName('PROENV').AsString = 'F') Then
      Begin
        strAss := fCampoTabela('MOD_ASSUNT', 'MODEMA', ['MOD_SEQGER'], [cdsCfgEma.FieldByName('AUTOIN').AsString]);
        If fEmptyStr(strAss) Then
        Begin
          Inc(intQtdLinha);
          strMsg := strMsg + #13#10 +cdsCfgEma.FieldByName('DESCRI').AsString;
        End;
      End;

      cdsCfgEma.Next;
    End;

    If (Not fEmptyStr(strMsg)) Then
    Begin
      Result := False;
      fMensagem('Atenção!', 'Você ativou opções com "Envio = Email Fixo", mas não cadastrou um modelo ou pelo menos o assunto do e-mail. '+
                            'Cadastre pela opção "Editar Email" dos seguintes itens:' + #13#10 + strMsg, ['&Ok'],
                            1, False, 1, 0, False, 0, False, False, False, 0, 0, intQtdLinha);
    End;
  Finally
    cdsCfgEma.RecNo := intRecNo;
    cdsCfgEma.EnableControls;
  End;
end;

function TfrmCfgEmailAutSaida.ModelosAvisoDeCobrancaNecessariosConfigurados: Boolean;
  Var
    LConsulta: TUniQuery;
begin
  Result := Not fCfgSis('AVIFDS', varBoolean);

  If Result Then
    Exit;

  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT EMA_CODGRU, ' +
                          '       EMA_CODIGO  ' +
                          'FROM EMASAI ' +
                          '  INNER JOIN MODEMA ON MOD_SEQGER = EMASAI.AUTOINCREM ' +
                          '  INNER JOIN CFGEMA ON CFG_SEQGER = EMASAI.AUTOINCREM ' +
                          'WHERE EMA_CODGRU="009" ' +
                          '  AND EMA_CODEMP="' + VS_strCodEmp + '" ' +
                          '  AND EMA_STATUS="A" ' +
                          '  AND EMA_ENTSAI="S" ';

    LConsulta.Open;

    LConsulta.Filter := 'EMA_CODIGO <> ''023'' AND EMA_CODIGO <> ''024'' ';
    LConsulta.Filtered := True;

    Result := LConsulta.IsEmpty;

    If Result Then
      Exit;

    LConsulta.Filter := 'EMA_CODIGO = ''023'' OR EMA_CODIGO = ''024'' ';
    LConsulta.Filtered := True;

    Result := LConsulta.RecordCount = 2;

    If Not Result Then
      fMensagem('ATENÇÃO',
                'Com a configuração CFG_AVIFDS igual a "Sim" e com ' +
                   'modelos de avisos de cobrança configurados, é exigido ' +
                   'que os modelos referentes ao próximo dia útil sejam configurados.' + #13 +
                   'Deve ser configurado o modelo nos grupos "Antes do Vencimento" e "Após o Vencimento"',
                ['&Ok']);
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
end;

function TfrmCfgEmailAutSaida.ValidaSeOsModelosAtivosPossuemConteudo: Boolean;
  Var
    LConsulta: TUniQuery;
    LGatilhosAtivos: String;
begin
  LGatilhosAtivos := fRetAutIncGatilhosAtivados;

  If LGatilhosAtivos.IsEmpty Then
    Exit(True);

  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT E.EMA_CODGRU, ' +
                          '       E.EMA_DESCRI  ' +
                          'FROM EMASAI E ' +
                          'LEFT JOIN MODEMA M ON M.MOD_SEQGER=E.AUTOINCREM ' +
                          'WHERE E.AUTOINCREM IN ('+LGatilhosAtivos+') ' +
                          '  AND E.EMA_CODEMP="' + VS_strCodEmp + '" ' +
                          '  AND E.EMA_ENTSAI="S" ';

    If Not fCfgSis('USAPIX', varBoolean) Then
      LConsulta.SQL.Add(' AND E.EMA_CODGRU <> "014" ');

    If (not fPodeExibirOpcaoBoletoAposFaturamentoAutorizacaNFe) Then
      LConsulta.SQL.Add(' AND (NOT (E.EMA_CODGRU = "008" AND E.EMA_CODIGO = "004")) ');

    LConsulta.SQL.Add('  AND (M.MOD_SEQGER IS NULL ' +
                      '    OR TRIM(COALESCE(M.MOD_MODELO, "")) = "") ');

    LConsulta.Open;

    Result := LConsulta.IsEmpty;

    If Not Result Then
      fMensagem('ATENÇÃO', 'Para confirmar a gravação, todos os modelos ativos devem possuir conteúdo.' + #13 +
                           'Acesse o grupo "' + LConsulta.FieldByName('EMA_CODGRU').AsString + ', ' +
                           'clique em "Editar E-mail" no modelo "' + LConsulta.FieldByName('EMA_DESCRI').AsString + '" ' +
                           'e adicione o conteúdo para o e-mail.', ['&Ok']);
  Finally
    LConsulta.Close;
    FreeAndNil(LConsulta);
  End;
end;

function TfrmCfgEmailAutSaida.fRetAutIncGatilhosAtivados: String;
var
  intRecNo: Integer;
begin
  Result := EmptyStr;

  intRecNo := cdsCfgEma.RecNo;

  cdsCfgEma.DisableControls;
  try
    cdsCfgEma.First;
    while not cdsCfgEma.Eof do
    begin
      if cdsCfgEma.FieldByName('STATUS').AsString = 'A' then
        Result := IIF(not fEmptyStr(Result), Result + ', ', '') + QuotedStr(cdsCfgEma.FieldByName('AUTOIN').AsString);
      cdsCfgEma.Next;
    end;
  finally
    cdsCfgEma.RecNo := intRecNo;
    cdsCfgEma.EnableControls;
  end;
end;

procedure TfrmCfgEmailAutSaida.pCriarGrupoAvisosDeCobranca;
  Var
    intRecNo : Integer;
begin
  If cdsCfgEma.IsEmpty Then
    Exit;

  intRecNo := cdsCfgEma.RecNo;
  Try
    // Antes do Vencimento
    cdsCfgEma.DisableControls;
    cdsCfgEma.Insert;
    cdsCfgEma.FieldByName('GRUPOS').AsString := '009-Avisos De Cobrança';
    cdsCfgEma.FieldByName('CODGRU').AsString := '009';
    cdsCfgEma.FieldByName('ORDENA').AsString := '1';
    cdsCfgEma.FieldByName('DESCRI').AsString := 'Aviso de Cobrança Antes do Vencimento';
    cdsCfgEma.Post;

    // Após o Vencimento
    cdsCfgEma.Insert;
    cdsCfgEma.FieldByName('GRUPOS').AsString := '009-Avisos De Cobrança';
    cdsCfgEma.FieldByName('CODGRU').AsString := '009';
    cdsCfgEma.FieldByName('ORDENA').AsString := '2';
    cdsCfgEma.FieldByName('DESCRI').AsString := 'Aviso de Cobrança Após o Vencimento';
    cdsCfgEma.Post;
    cdsCfgEma.RecNo := intRecNo;
    cdsCfgEma.EnableControls;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(e.Message, '[TfrmCfgSMS.pCriarGrupoAvisosDeCobranca]');
    End;
  End;

end;

function TfrmCfgEmailAutSaida.fPodeExibirOpcaoBoletoAposFaturamentoAutorizacaNFe() : Boolean;
begin
  Result := False;

  If (not fCfgSis('CITINF', varBoolean)) Then
    Exit;

  Result := True;
end;

procedure TfrmCfgEmailAutSaida.pCriarGrupoAvisosDeDebitos;
  Var
    intRecNo : Integer;
begin
  If cdsCfgEma.IsEmpty Then
    Exit;

  intRecNo := cdsCfgEma.RecNo;
  Try
    cdsCfgEma.DisableControls;
    cdsCfgEma.Insert;
    cdsCfgEma.FieldByName('GRUPOS').AsString := '025-Avisos De Débito';
    cdsCfgEma.FieldByName('CODGRU').AsString := '025';
    cdsCfgEma.FieldByName('ORDENA').AsString := '1';
    cdsCfgEma.FieldByName('DESCRI').AsString := 'Avisos de Débito';
    cdsCfgEma.Post;
    cdsCfgEma.RecNo := intRecNo;
    cdsCfgEma.EnableControls;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(e.Message, '[TfrmCfgSMS.pCriarGrupoAvisosDeDebito]');
    End;
  End;

end;

end.
