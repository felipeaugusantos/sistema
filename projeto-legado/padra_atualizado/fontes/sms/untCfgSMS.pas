unit untCfgSMS;

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
  cxDataControllerConditionalFormattingRulesManagerDialog, cxEditRepositoryItems,
  cxExtEditRepositoryItems,untCfgSMSAviCob;

type
  TfrmCfgSMS = class(TfrmPaiConfirma)
    Panel1: TPanel;
    cxGridCitel1Level1: TcxGridLevel;
    cxGridCitelTableView: TcxGridDBTableViewCitel;
    cxGridCitel1: TcxGridCitel;
    ATIVO: TcxGridDBColumn;
    DESCRIÇÃO: TcxGridDBColumn;
    EDITOR: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    GRUPO: TcxGridDBColumn;
    dtsSMSSAI: TDataSource;
    ROBO: TcxGridDBColumn;
    cxEditRepository1: TcxEditRepository;
    cxEditRepositoryBotaoEditarSMS: TcxEditRepositoryButtonItem;
    cxEditRepositoryBotaoOpcEnvio: TcxEditRepositoryButtonItem;
    cxEditRepository1Label: TcxEditRepositoryLabel;
    cxEditRepositoryBotaoEditarSMSPortador: TcxEditRepositoryButtonItem;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConfirmaClick(Sender: TObject);
    procedure ENVIOPropertiesChange(Sender: TObject);
    procedure ROBOPropertiesEditValueChanged(Sender: TObject);
    procedure ATIVOGetProperties(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
    procedure EDITORGetProperties(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
    procedure ROBOGetProperties(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
    procedure cxEditRepositoryBotaoEditarSMSPropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
    procedure cxEditRepositoryBotaoOpcEnvioPropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
    procedure cxEditRepositoryBotaoEditarSMSPortadorPropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
  private
    qryCfgEma: TUniQuery;
    cdsCfgEma: TUniClientDataSet;
    dspCfgEma: TUniDataSetProvider;

    FMostraAvisoProximoDiaUtil: Boolean;

    procedure pCarregaConfiguracoes;
    procedure pGravar;
    function fRetEspecieDocumento(strCodGru: String): String;
    procedure pCriarConfiguracoesPadrao;
    procedure pCriarGrupoAvisosDeCobranca;

    function ValidaSeOsModelosAtivosPossuemConteudo: Boolean;

    function ModelosAvisoDeCobrancaNecessariosConfigurados: Boolean;

    function fRetAutIncGatilhosAtivados: String;
  public
    { Public declarations }
    property MostraAvisoProximoDiaUtil: Boolean read FMostraAvisoProximoDiaUtil write FMostraAvisoProximoDiaUtil Default False;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untCfgModeloSMS, untCfgPortadoresAutorizadosEmail;

procedure TfrmCfgSMS.ATIVOGetProperties(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
begin
  inherited;
  If Copy(ARecord.Values[GRUPO.Index],1,3) = '009' Then
    AProperties := cxEditRepository1Label.Properties;
end;

procedure TfrmCfgSMS.btnConfirmaClick(Sender: TObject);
begin
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

procedure TfrmCfgSMS.cxEditRepositoryBotaoEditarSMSPortadorPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
var
  frmCfgPortadoresAutorizadosEmail: TfrmCfgPortadoresAutorizadosEmail;
begin
  inherited;

  If AButtonIndex = 0 Then //SMS
  Begin

    Try
      pCriarFormularios(TfrmCfgModeloSMS, frmCfgModeloSMS);
      frmCfgModeloSMS.Caption   := frmCfgModeloSMS.Caption + ' - ' + dtsSMSSAI.DataSet.FieldByName('DESCRI').AsString;
      frmCfgModeloSMS.strSeqGer := dtsSMSSAI.DataSet.FieldByName('AUTOIN').AsString;
      frmCfgModeloSMS.strEspDoc := fRetEspecieDocumento(dtsSMSSAI.DataSet.FieldByName('CODGRU').AsString);
      frmCfgModeloSMS.strCodGru := dtsSMSSAI.DataSet.FieldByName('CODGRU').AsString;
      frmCfgModeloSMS.ShowModal();
    Finally
      pFreeAndNil(frmCfgModeloSMS);
    End;

  End
  Else
  If AButtonIndex = 1 Then //Portadores
  Begin

    Try
       pCriarFormularios(TfrmCfgPortadoresAutorizadosEmail, frmCfgPortadoresAutorizadosEmail);
       frmCfgPortadoresAutorizadosEmail.Caption   := dtsSMSSAI.DataSet.FieldByName('GRUPOS').AsString + ' - ' + dtsSMSSAI.DataSet.FieldByName('DESCRI').AsString;
       frmCfgPortadoresAutorizadosEmail.strSeqGer := dtsSMSSAI.DataSet.FieldByName('CODSMS').AsString;
       frmCfgPortadoresAutorizadosEmail.strCodGru := dtsSMSSAI.DataSet.FieldByName('CODGRU').AsString;
       frmCfgPortadoresAutorizadosEmail.intCodTip := 1;
       frmCfgPortadoresAutorizadosEmail.ShowModal();
    Finally
       pFreeAndNil(frmCfgPortadoresAutorizadosEmail);
    End;

  End;

end;

procedure TfrmCfgSMS.cxEditRepositoryBotaoEditarSMSPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;

  Try
    pCriarFormularios(TfrmCfgModeloSMS, frmCfgModeloSMS);
    frmCfgModeloSMS.Caption   := frmCfgModeloSMS.Caption + ' - ' + dtsSMSSAI.DataSet.FieldByName('DESCRI').AsString;
    frmCfgModeloSMS.strSeqGer := dtsSMSSAI.DataSet.FieldByName('AUTOIN').AsString;
    frmCfgModeloSMS.strEspDoc := fRetEspecieDocumento(dtsSMSSAI.DataSet.FieldByName('CODGRU').AsString);
    frmCfgModeloSMS.strCodGru := dtsSMSSAI.DataSet.FieldByName('CODGRU').AsString;
    frmCfgModeloSMS.ShowModal();
  Finally
    pFreeAndNil(frmCfgModeloSMS);
  End;

end;

procedure TfrmCfgSMS.cxEditRepositoryBotaoOpcEnvioPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;

  Try
    pCriarFormularios(TfrmCfgSMSAviCob, frmCfgSMSAviCob);
    frmCfgSMSAviCob.blnAntes := (Pos('Antes',dtsSMSSAI.DataSet.FieldByName('DESCRI').AsString) > 0);
    frmCfgSMSAviCob.MostraAvisoProximoDiaUtil := FMostraAvisoProximoDiaUtil;
    frmCfgSMSAviCob.ShowModal();
  Finally
    pFreeAndNil(frmCfgSMSAviCob);
  End;

end;

procedure TfrmCfgSMS.EDITORGetProperties(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
begin
  inherited;
  If Copy(ARecord.Values[GRUPO.Index],1,3) = '008' Then
     AProperties := cxEditRepositoryBotaoEditarSMSPortador.Properties
  Else
  If Copy(ARecord.Values[GRUPO.Index],1,3) = '009' Then
     AProperties := cxEditRepositoryBotaoOpcEnvio.Properties
  Else
     AProperties := cxEditRepositoryBotaoEditarSMS.Properties;
end;

procedure TfrmCfgSMS.ENVIOPropertiesChange(Sender: TObject);
begin
  inherited;

  If (dtsSMSSAI.DataSet.State = dsEdit) Then
    dtsSMSSAI.DataSet.Post;
end;

procedure TfrmCfgSMS.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryCfgEma);
  FreeAndNil(dspCfgEma);
  FreeAndNil(cdsCfgEma);
end;

procedure TfrmCfgSMS.FormShow(Sender: TObject);
begin
  inherited;
  qryCfgEma := fCriaQuery(Self);
  dspCfgEma := TUniDataSetProvider.Create(Self);
  cdsCfgEma := TUniClientDataSet.Create(Self);

  dspCfgEma.DataSet := qryCfgEma;
  cdsCfgEma.SetProvider(dspCfgEma);

  dtsSMSSAI.DataSet := cdsCfgEma;
  pCarregaConfiguracoes;
  cxGridCitelTableView.ViewData.Expand(True);
end;

function TfrmCfgSMS.fRetEspecieDocumento(strCodGru: String): String;
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
  Else If (strCodGru = '011') Then
    Result := 'CD'
  Else If (strCodGru = '014') Then
    Result := 'PX'
  Else If (strCodGru = '015') Then
    Result := 'EF'
  Else If (strCodGru = '016') Then
    Result := 'TE'
  Else If (strCodGru = '017') Then
    Result := 'CB';
end;

function TfrmCfgSMS.ModelosAvisoDeCobrancaNecessariosConfigurados: Boolean;
  Var
    LConsulta: TUniQuery;
begin
  Result := Not fCfgSis('AVIFDS', varBoolean);

  If Result Then
    Exit;

  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT SMS_CODGRU, ' +
                          '       SMS_CODIGO  ' +
                          'FROM SMSSAI ' +
                          '  INNER JOIN MODSMS ON MOD_SEQGER = SMSSAI.AUTOINCREM ' +
                          'WHERE SMS_CODGRU="009" ' +
                          '  AND SMS_CODEMP="' + VS_strCodEmp + '" ' +
                          '  AND SMS_STATUS="A" ';

    LConsulta.Open;

    LConsulta.Filter := 'SMS_CODIGO <> ''023'' AND SMS_CODIGO <> ''024'' ';
    LConsulta.Filtered := True;

    Result := LConsulta.IsEmpty;

    If Result Then
      Exit;

    LConsulta.Filter := 'SMS_CODIGO = ''023'' OR SMS_CODIGO = ''024'' ';
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

procedure TfrmCfgSMS.pCarregaConfiguracoes;
Var
  strSQL: String;
begin

  //rotina responsável pela criação dos grupos
  //e gatilhos padrão para a empresa logada
  pCriarConfiguracoesPadrao();

  Try

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CONCAT(GRU_CODGRU, "-", GRU_DESGRU) AS GRUPOS, ';
    strSQL := strSQL + '  GRU_CODGRU        AS CODGRU, ';
    strSQL := strSQL + '  SMS_CODIGO        AS CODSMS, ';
    strSQL := strSQL + '  SMS_CODEMP        AS CODEMP, ';
    strSQL := strSQL + '  SMS_STATUS        AS STATUS, ';
    strSQL := strSQL + '  SMS_DESCRI        AS DESCRI, ';
    strSQL := strSQL + '  SMS_ORDENA        AS ORDENA, ';
    strSQL := strSQL + '  SMS_MDROBO        AS MDROBO, ';
    strSQL := strSQL + '  SMSSAI.AUTOINCREM AS AUTOIN  ';
    strSQL := strSQL + 'FROM      ';
    strSQL := strSQL + '  SMSSAI  ';
    strSQL := strSQL + '  INNER JOIN GRUSMS ON GRU_CODGRU = SMS_CODGRU ';
    strSQL := strSQL + 'WHERE     ';
    strSQL := strSQL + '  SMS_CODEMP = :CODEMP AND GRU_CODGRU <> "009" ';
    strSQL := strSQL + 'ORDER BY  ';
    strSQL := strSQL + '  CODGRU, ';
    strSQL := strSQL + '  ORDENA  ';

    With qryCfgEma Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
      pSetaClient(qryCfgEma);
      cdsCfgEma.Open;
      pSetaClient(cdsCfgEma);
      pCriarGrupoAvisosDeCobranca;
    End;

    cdsCfgEma.DisableControls;
    If cdsCfgEma.Locate('CODGRU;CODSMS',
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
      pMensagensErro(e.Message, '[TfrmCfgSMS.pCarregaConfiguracoes]');
  End;

end;

{ ************************************************ }
{ SEMPRE QUE UM NOVO GRUPO OU UM NOVO GATILHO      }
{ FOR CRIADO O INSERT DEVERÁ SER INSERIDO AQUI     }
{ PARA A CRIAÇÃO NA EMPRESA LOGADA CASO NÃO EXISTA }
{ *********************************************DF* }
procedure TfrmCfgSMS.pCriarConfiguracoesPadrao;
  Var
    i, j, k: Integer;
    qryTemp: TUniQuery;

  Const
    arrCodSmsEma: Array [1..14] Of String = ('001', '002', '003', '004', '005', '006', '007', '008', '009', '011','014','015', '016', '017');

    arrDesSmsEma: Array [1..14] Of String = ('Orçamento de Venda',
                                            'Pedido de Venda',
                                            'Expedição Tipo [2]: Faturamento antes da expedição',
                                            'Expedição Tipo [3]: Faturamento depois da expedição',
                                            'Expedição Tipo [4]: O pedido não será faturado',
                                            'Romaneio com Expedição Tipo [2/3/4]',
                                            'Expedição Tipo [5]: Expedição por romaneio. O pedido não será faturado',
                                            'Envio de Boleto',
                                            'Avisos de Cobrança',
                                            'Cupom de Desconto',
                                            'Pix',
                                            'Entrega Futura',
                                            'App Ta Entregue',
                                            'Cobranca Eletrônica');

    arrTamSmsEma: Array [1..14] Of Integer = (6, 8, 1, 3, 4, 2, 6, 1, 16, 1, 2, 1, 3, 1);

    arrCodSMSSAI: Array [1..55] Of String = ({Grupo: Orçamento de Venda}
                                             '001', '002', '003', '004', '005', '006',
                                             {Grupo: Pedido de Venda}
                                             '001', '002', '003', '004', '005', '006', '007', '009',
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
                                             '001',
                                             {Grupo: Avisos de Cobrança}
                                             '001', '002', '003', '011','012','013','014','015','016','018','019','020','021','022', '023', '024',
                                             {Grupo: Cupom de Desconto}
                                             '001',
                                             {Grupo: Pix}
                                             '001', '002',
                                             {Grupo: Entrega Futura}
                                             '001',
                                             {Grupo: App Ta Entregue}
                                             '001', '002', '003',
                                             {Grupo: Cobranca Eletrônica}
                                             '001');

    arrDesSMSSAI: Array [1..55] Of String = ({Grupo: Orçamento de Venda}
                                             'Inclusão do Orçamento',
                                             'Alteração do Orçamento',
                                             'Transformação do Orçamento em Pedido de Venda',
                                             'Faturamento do Orçamento em documento de Venda ( F11, Venda Normal )',
                                             '[F10] Baixa de Orçamento que não será entregue',
                                             'Cancelamento do Orçamento',
                                             {Grupo: Pedido de Venda}
                                             'Inclusão do Pedido',
                                             'Impressao da Separação',
                                             'Alteração do Pedido',
                                             'Faturamento Parcial do Pedido documento de Venda ( CONF.DE PEDIDOS )',
                                             'Faturamento Total do Pedido documento de Venda ( F11, VENDA NORMAL, CONF.DE PEDIDOS )',
                                             '[F10] Baixa de Pedido que não será entregue',
                                             'Cancelamento do Pedido',
                                             'Inclusão/Alteração do Pedido - Pix',
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
                                             {Grupo: Avisos de Cobrança}
                                             'Aviso de cobrança 2 dias antes do vencimento',
                                             'Aviso de cobrança 3 dias após vencimento',
                                             'Aviso de cobrança 5 dias após vencimento',

                                             'Aviso de cobrança 8 dias após vencimento',     //'011'
                                             'Aviso de cobrança 6 dias após vencimento',     //'012'
                                             'Aviso de cobrança 7 dias após vencimento',     //'013'
                                             'Aviso de cobrança 9 dias após vencimento',     //'014'
                                             'Aviso de cobrança 10 dias após vencimento',    //'015'
                                             'Aviso de cobrança 6 dias antes do vencimento',  //'016'
                                             'Aviso de cobrança 7 dias antes do vencimento',  //'018'
                                             'Aviso de cobrança 8 dias antes do vencimento',  //'019'
                                             'Aviso de cobrança 9 dias antes do vencimento',  //'020'
                                             'Aviso de cobrança 10 dias antes do vencimento', //'021'
                                             'Aviso de cobrança 30 dias após vencimento',    //'022'

                                             'Aviso de cobrança antes do vencimento (Próximo dia útil) ', //'023'
                                             'Aviso de cobrança após vencimento (Próximo dia útil)',      //'024'
                                             {Grupo: Cupom de Descconto}
                                             'Venda gerou cupom de desconto',
                                             {Grupo: Pix}
                                             'Envio de Pix para pagamento de duplicatas - Baixa de Contas a Receber',
                                             'Envio de Pix para geração de crédito ao cliente - Relação de Documentos com Pix Gerados',
                                             {Entrega Futura}
                                             'Aviso de Baixa de Entrega Futura ao Cliente',
                                             {Grupo: App Ta Entregue}
                                             'Rota Iniciada',
                                             'Aviso de Ocorrência na Entrega',
                                             'Entrega Concluída',
                                             {Grupo: Cobrança Eletrônica}
                                             'Mensagem de Link de Pagamento');

  procedure pInicializarQuery; begin
    qryTemp := fCriaQuery(nil);
    qryTemp.Close();
    qryTemp.SQL.Clear();
  end;

  function fExisteSmsEma(strCodGru: String): Boolean; begin
    Result := ( Not fEmptyStr( fCampoTabela('AUTOINCREM',
                                            'GRUSMS',
                                            ['GRU_CODGRU'],
                                            [strCodGru]) ) );
  end;

  procedure pIncluirRegistroSmsEma(strCodGru, strDesGru: String); begin
    qryTemp.Close();
    qryTemp.SQL.Clear();
    qryTemp.SQL.Text := 'INSERT INTO GRUSMS (AUTOINCREM, GRU_CODGRU, GRU_CODEMP, GRU_DESGRU) ' +
      ' VALUES (:AUTINC, :CODGRU, :CODEMP, :DESGRU)';
    qryTemp.ParamByName('AUTINC').AsString := fRetAutoIncrem('GRUSMS', VS_strCodEmp);
    qryTemp.ParamByName('CODGRU').AsString := strCodGru;
    qryTemp.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryTemp.ParamByName('DESGRU').AsString := strDesGru;
    qryTemp.ExecSQL();
  end;

  function fExisteSMSSAI(strCodGru, strCodigo: String): Boolean; begin
    Result := ( Not fEmptyStr( fCampoTabela('AUTOINCREM',
                                            'SMSSAI',
                                            ['SMS_CODIGO', 'SMS_CODGRU', 'SMS_CODEMP'],
                                            [strCodigo, strCodGru, VS_strCodEmp]) ) );
  end;

  procedure pIncluirRegistroSMSSAI(strCodigo, strCodGru, strDescri: String);
  begin
    qryTemp.Close();
    qryTemp.SQL.Clear();
    qryTemp.SQL.Text := 'INSERT INTO SMSSAI (AUTOINCREM, SMS_CODIGO, SMS_CODGRU, SMS_CODEMP, SMS_DESCRI, ' +
      'SMS_STATUS, SMS_ORDENA, SMS_MDROBO) VALUES (:AUTINC, :CODIGO, :CODGRU, :CODEMP, :DESCRI, ' +
      ':STATUS, :ORDENA, :MDROBO)';
    qryTemp.ParamByName('AUTINC').AsString := fRetAutoIncrem('SMSSAI', VS_strCodEmp);
    qryTemp.ParamByName('CODIGO').AsString := strCodigo;
    qryTemp.ParamByName('CODGRU').AsString := strCodGru;
    qryTemp.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryTemp.ParamByName('DESCRI').AsString := strDescri;
    qryTemp.ParamByName('STATUS').AsString := 'I';
    qryTemp.ParamByName('ORDENA').AsString := strCodigo;
    qryTemp.ParamByName('MDROBO').AsString := 'N';
    qryTemp.ExecSQL();
  end;

begin
  Try
    k := 1;
    pInicializarQuery();

    Try
      fStartTransaction();

      For i := 1 To Length(arrCodSmsEma) Do Begin

        If (Not fExisteSmsEma(arrCodSmsEma[i])) Then
          pIncluirRegistroSmsEma(arrCodSmsEma[i], arrDesSmsEma[i]);

        For j := 1 To arrTamSmsEma[i] Do Begin
          If (Not fExisteSMSSAI(arrCodSmsEma[i], arrCodSMSSAI[k])) Then
            pIncluirRegistroSMSSAI(arrCodSMSSAI[k], arrCodSmsEma[i], arrDesSMSSAI[k]);

          k := k + 1;
        End;
      End;

	    fCommit();
    Except
      On E: Exception Do Begin
        fRollBack();
        pMensagensErro(e.Message, '[TfrmCfgSMS.pCriarConfiguracoesPadrao]')
      End;
    End;
  Finally
    FreeAndNil(qryTemp);
  End;
end;

procedure TfrmCfgSMS.pCriarGrupoAvisosDeCobranca;
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

procedure TfrmCfgSMS.pGravar;
Var
  qryGravar: TUniQuery;
  strSQL   : String;
begin

  Try

    qryGravar := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'UPDATE           ';
    strSQL := strSQL + '  SMSSAI         ';
    strSQL := strSQL + 'SET              ';
    strSQL := strSQL + '  SMS_MDROBO = :MDROBO, ';
    strSQL := strSQL + '  SMS_STATUS = :STATUS  ';
    strSQL := strSQL + 'WHERE            ';
    strSQL := strSQL + '  AUTOINCREM = :AUTOIN AND ';
    strSQL := strSQL + '  SMS_CODEMP = :CODEMP     ';

    With qryGravar Do
    Begin
      cdsCfgEma.First;

      While Not cdsCfgEma.Eof Do
      Begin
        If Not cdsCfgEma.FieldByName('CODGRU').AsString.Equals('009') Then
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('STATUS').AsString := cdsCfgEma.FieldByName('STATUS').AsString;
          ParamByName('AUTOIN').AsString := cdsCfgEma.FieldByName('AUTOIN').AsString;
          ParamByName('CODEMP').AsString := cdsCfgEma.FieldByName('CODEMP').AsString;
          ParamByName('MDROBO').AsString := cdsCfgEma.FieldByName('MDROBO').AsString;
          ExecSQL;
        End;
        cdsCfgEma.Next;
      End;
    End;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TfrmCfgSMS.pGravar]')
  End;

  FreeAndNil(qryGravar);

end;

procedure TfrmCfgSMS.ROBOGetProperties(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
begin
  inherited;
  If Copy(ARecord.Values[GRUPO.Index],1,3) = '009' Then
    AProperties := cxEditRepository1Label.Properties;
end;

procedure TfrmCfgSMS.ROBOPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;
  If cdsCfgEma.Active Then
  Begin
    If (cdsCfgEma.FieldByName('CODGRU').AsString + '-' + cdsCfgEma.FieldByName('CODSMS').AsString <> '008-001') Then
    Begin
      fMensagem('Atenção','Opção não disponível para modo robo, SMS será enviado via processamento paralelo!',['&OK']);
      cdsCfgEma.FieldByName('MDROBO').AsString := 'N';
    End;
  End;
end;

function TfrmCfgSMS.ValidaSeOsModelosAtivosPossuemConteudo: Boolean;
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT S.SMS_CODGRU, ' +
                          '       S.SMS_DESCRI  ' +
                          'FROM SMSSAI S ' +
                          'LEFT JOIN MODSMS M ON M.MOD_SEQGER=S.AUTOINCREM ' +
                          'WHERE S.AUTOINCREM IN ('+fRetAutIncGatilhosAtivados+') ' +
                          '  AND S.SMS_CODEMP="' + VS_strCodEmp + '" ';

    If Not fCfgSis('USAPIX', varBoolean) Then
      LConsulta.SQL.Add(' AND S.SMS_CODGRU <> "014" ');

    LConsulta.SQL.Add('  AND (M.MOD_SEQGER IS NULL ' +
                      '    OR TRIM(COALESCE(M.MOD_MODELO, "")) = "") ');

    LConsulta.Open;

    Result := LConsulta.IsEmpty;

    If Not Result Then
      fMensagem('ATENÇÃO', 'Para confirmar a gravação, todos os modelos ativos devem possuir conteúdo.' + #13 +
                           'Acesse o grupo "' + LConsulta.FieldByName('SMS_CODGRU').AsString + ', ' +
                           'clique em "Editar SMS" no modelo "' + LConsulta.FieldByName('SMS_DESCRI').AsString + '" ' +
                           'e adicione o conteúdo para o SMS.', ['&Ok']);
  Finally
    LConsulta.Close;
    FreeAndNil(LConsulta);
  End;
end;

function TfrmCfgSMS.fRetAutIncGatilhosAtivados: String;
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

  if fEmptyStr(Result) then
    Result := QuotedStr(EmptyStr);
end;

end.
