unit untCfgWpp;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels, System.StrUtils,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxClasses,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCustomView,
  cxGridCitel, cxGridLevel, cxGrid, cxCheckBox, cxButtonEdit, cxDropDownEdit,
  Uni, UniClientDataSet, UniDataSetProvider, cxRadioGroup, cxLabel,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxEditRepositoryItems,
  cxExtEditRepositoryItems,untCfgSMSAviCob, cxDBLookupComboBox, cxMaskEdit,
  cxTextEdit, untCfgWppAviDeb;

type
  TfrmCfgWpp = class(TfrmPaiConfirma)
    cxGridCitel1Level1: TcxGridLevel;
    cxGridCitelTableView: TcxGridDBTableViewCitel;
    cxGridCitel1: TcxGridCitel;
    ATIVO: TcxGridDBColumn;
    DESCRIÇÃO: TcxGridDBColumn;
    EDITOR: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    GRUPO: TcxGridDBColumn;
    dtsWPPSAI: TDataSource;
    cxEditRepository1: TcxEditRepository;
    cxEditRepositoryBotaoEditarWPP: TcxEditRepositoryButtonItem;
    cxEditRepositoryBotaoOpcEnvio: TcxEditRepositoryButtonItem;
    cxEditRepository1Label: TcxEditRepositoryLabel;
    cxEditRepositoryBotaoEditarWPPPortador: TcxEditRepositoryButtonItem;
    FILA: TcxGridDBColumn;
    dtsFilas: TDataSource;
    FAIXAIN: TcxGridDBColumn;
    FAIXAFN: TcxGridDBColumn;
    cxEditRepositoryMskHora: TcxEditRepositoryMaskItem;
    cxEditRepositoryTxtHoraDisable: TcxEditRepositoryTextItem;
    cxEditRepositoryBotaoEditarWPPOpcEnvio: TcxEditRepositoryButtonItem;
    CODWPP: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConfirmaClick(Sender: TObject);
    procedure EDITORGetProperties(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
    procedure cxEditRepositoryBotaoEditarWPPPropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
    procedure cxEditRepositoryBotaoEditarWPPPortadorPropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
    procedure FormCreate(Sender: TObject);
    procedure ATIVOPropertiesEditValueChanged(Sender: TObject);
    procedure FAIXAINGetProperties(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
    procedure FAIXAFNGetProperties(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
    procedure cxEditRepositoryBotaoOpcEnvioPropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
    procedure ATIVOGetProperties(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
    procedure cxEditRepositoryBotaoEditarWPPOpcEnvioPropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);

  private
    qryCfgWpp, qryCadFil: TUniQuery;
    cdsCfgWpp, cdsCadFil: TUniClientDataSet;
    dspCfgWpp, dspCadFil: TUniDataSetProvider;
    FstrCodGru: String;
    FstrEntSai: String;

    FMostraAvisoProximoDiaUtil: Boolean;

    procedure pCarregaConfiguracoes;
    procedure pGravar;
    function fRetEspecieDocumento(strCodGru: String; strCodigo: String): String;
    procedure pCriarConfiguracoesPadrao(var AstrGrupos: String);
    procedure pCarregaFilas;
    function fAtivadosNaoTemFilaInformada: Boolean;
    procedure pIncluirRegistroWPPSAI(strCodigo, strCodGru, strDescri: String; intOrdena: Integer; qryTemp: TUniQuery);
    function fExisteWPPSAI(strCodGru, strCodigo: String): Boolean;
    procedure pIncluirRegistroGruWpp(strCodGru, strDesGru: String; qryTemp: TUniQuery);
    function fExisteGruWpp(strCodGru: String): Boolean;
    function fRetFilaPrincipalDaEmpresaLogada: String;
    procedure pBeforePost(DataSet: TDataSet);
    procedure pCriarGrupoAvisosDeDebitos;

    function ValidaSeOsModelosAtivosPossuemConteudo: Boolean;

    function ModelosAvisoDeCobrancaNecessariosConfigurados: Boolean;

    procedure pSetaModeloMensagemPadrao(const strAutInc, strCodGru, strCodigo: String);
    procedure pImportaModeloMensagemDeOutroGatilho(const strAutInc, strCodGru, strCodigo: String);

    function fRetAutIncGatilhosAtivados: String;
    function fRetAutIncGatilhosApiOficialAtivados: String;

    function fTodosModelosDaApiOficialTemTemplateDefinido: Boolean;
  public
    { Public declarations }
    strAutIncContato: String;
    function fCodigoGrupo(strCodGru: String): TfrmCfgWpp;
    property strEntSai: String read FstrEntSai write FstrEntSai;

    property MostraAvisoProximoDiaUtil: Boolean read FMostraAvisoProximoDiaUtil write FMostraAvisoProximoDiaUtil Default False;
  end;

var
  frmCfgWppAviDeb : TfrmCfgWppAviDeb;

implementation

{$R *.dfm}

uses untFuncoesSimples, untCfgPortadoresAutorizadosEmail,
  untCfgModeloWPP, untDigQuantidade;

procedure TfrmCfgWpp.btnConfirmaClick(Sender: TObject);
begin
  inherited;
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

  If Not fTodosModelosDaApiOficialTemTemplateDefinido Then
  Begin
    ModalResult := mrNone;
    Exit;
  End;

  pGravar;
end;

procedure TfrmCfgWpp.cxEditRepositoryBotaoEditarWPPOpcEnvioPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
var
  frmCfgModeloWPP: TfrmCfgModeloWPP;
  intQtdDig: Integer;
begin
  inherited;
  If AButtonIndex = 0 Then //MENSAGEM
  Begin

    Try
      pCriarFormularios(TfrmCfgModeloWPP, frmCfgModeloWPP);
      frmCfgModeloWPP.Caption   := frmCfgModeloWPP.Caption + ' - ' + dtsWPPSAI.DataSet.FieldByName('DESCRI').AsString;
      frmCfgModeloWPP.strSeqGer := dtsWPPSAI.DataSet.FieldByName('AUTOIN').AsString;
      frmCfgModeloWPP.strEspDoc := fRetEspecieDocumento(dtsWPPSAI.DataSet.FieldByName('CODGRU').AsString, dtsWPPSAI.DataSet.FieldByName('CODWPP').AsString);
      frmCfgModeloWPP.strCodGru := dtsWPPSAI.DataSet.FieldByName('CODGRU').AsString;
      frmCfgModeloWPP.strCodGat := dtsWPPSAI.DataSet.FieldByName('CODWPP').AsString;
      frmCfgModeloWPP.blnApiOficial := (fCampoTabela('FIL_APIOFI', 'CADFIL', ['AUTOINCREM'], [dtsWPPSAI.DataSet.FieldByName('FILWPP').AsString]) = 'S');
      If StrToIntDef(dtsWPPSAI.DataSet.FieldByName('CODGRU').AsString,0) In [24] Then
        frmCfgModeloWPP.strEntSai := 'E';
      frmCfgModeloWPP.ShowModal();
    Finally
      pFreeAndNil(frmCfgModeloWPP);
    End;

  End
  Else If AButtonIndex = 1 Then //OPÇÕES DE ENVIO
  Begin
    intQtdDig := dtsWPPSAI.DataSet.FieldByName('INTENV').AsInteger;
    if fDigQuantidade('Digite o intervalo de dias',
                      'Dias',
                      intQtdDig,
                      0,
                      100) then
    begin
      dtsWPPSAI.DataSet.Edit;
      dtsWPPSAI.DataSet.FieldByName('DESCRI').AsString := dtsWPPSAI.DataSet.FieldByName('DESCRI').AsString.Replace(fStrZero(dtsWPPSAI.DataSet.FieldByName('INTENV').AsString, 2), fStrZero(intQtdDig.ToString, 2));
      dtsWPPSAI.DataSet.FieldByName('DESCRI').AsString := dtsWPPSAI.DataSet.FieldByName('DESCRI').AsString.Replace('XX', fStrZero(intQtdDig.ToString, 2));
      dtsWPPSAI.DataSet.FieldByName('INTENV').AsInteger := intQtdDig;
      dtsWPPSAI.DataSet.Post;
    end;
  End;
end;

procedure TfrmCfgWpp.cxEditRepositoryBotaoEditarWPPPortadorPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
var
  frmCfgPortadoresAutorizadosEmail: TfrmCfgPortadoresAutorizadosEmail;
  frmCfgModeloWPP: TfrmCfgModeloWPP;
begin
  inherited;

  If AButtonIndex = 0 Then //MENSAGEM
  Begin

    Try
      pCriarFormularios(TfrmCfgModeloWPP, frmCfgModeloWPP);
      frmCfgModeloWPP.Caption   := frmCfgModeloWPP.Caption + ' - ' + dtsWPPSAI.DataSet.FieldByName('DESCRI').AsString;
      frmCfgModeloWPP.strSeqGer := dtsWPPSAI.DataSet.FieldByName('AUTOIN').AsString;
      frmCfgModeloWPP.strEspDoc := fRetEspecieDocumento(dtsWPPSAI.DataSet.FieldByName('CODGRU').AsString, dtsWPPSAI.DataSet.FieldByName('CODWPP').AsString);
      frmCfgModeloWPP.strCodGru := dtsWPPSAI.DataSet.FieldByName('CODGRU').AsString;
      frmCfgModeloWPP.strCodGat := dtsWPPSAI.DataSet.FieldByName('CODWPP').AsString;
      frmCfgModeloWPP.blnApiOficial := (fCampoTabela('FIL_APIOFI', 'CADFIL', ['AUTOINCREM'], [dtsWPPSAI.DataSet.FieldByName('FILWPP').AsString]) = 'S');
      If StrToIntDef(dtsWPPSAI.DataSet.FieldByName('CODGRU').AsString,0) In [24] Then
        frmCfgModeloWPP.strEntSai := 'E';
      frmCfgModeloWPP.ShowModal();
    Finally
      pFreeAndNil(frmCfgModeloWPP);
    End;

  End
  Else
  If AButtonIndex = 1 Then //PORTADORES
  Begin

    Try
       pCriarFormularios(TfrmCfgPortadoresAutorizadosEmail, frmCfgPortadoresAutorizadosEmail);
       frmCfgPortadoresAutorizadosEmail.Caption   := dtsWPPSAI.DataSet.FieldByName('GRUPOS').AsString + ' - ' + dtsWPPSAI.DataSet.FieldByName('DESCRI').AsString;
       frmCfgPortadoresAutorizadosEmail.strSeqGer := dtsWPPSAI.DataSet.FieldByName('CODWPP').AsString;
       frmCfgPortadoresAutorizadosEmail.strCodGru := dtsWPPSAI.DataSet.FieldByName('CODGRU').AsString;
       frmCfgPortadoresAutorizadosEmail.intCodTip := 2;
       frmCfgPortadoresAutorizadosEmail.ShowModal();
    Finally
       pFreeAndNil(frmCfgPortadoresAutorizadosEmail);
    End;

  End;

end;

procedure TfrmCfgWpp.cxEditRepositoryBotaoEditarWPPPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
var
  frmCfgModeloWPP: TfrmCfgModeloWPP;
begin
  inherited;

  Try
    pCriarFormularios(TfrmCfgModeloWPP, frmCfgModeloWPP);
    frmCfgModeloWPP.Caption   := frmCfgModeloWPP.Caption + ' - ' + dtsWPPSAI.DataSet.FieldByName('DESCRI').AsString;
    frmCfgModeloWPP.strSeqGer := dtsWPPSAI.DataSet.FieldByName('AUTOIN').AsString;
    frmCfgModeloWPP.strEspDoc := fRetEspecieDocumento(dtsWPPSAI.DataSet.FieldByName('CODGRU').AsString, dtsWPPSAI.DataSet.FieldByName('CODWPP').AsString);
    frmCfgModeloWPP.strCodGru := dtsWPPSAI.DataSet.FieldByName('CODGRU').AsString;
    frmCfgModeloWPP.strCodGat := dtsWPPSAI.DataSet.FieldByName('CODWPP').AsString;
    frmCfgModeloWPP.blnApiOficial := (fCampoTabela('FIL_APIOFI', 'CADFIL', ['AUTOINCREM'], [dtsWPPSAI.DataSet.FieldByName('FILWPP').AsString]) = 'S');
    If StrToIntDef(dtsWPPSAI.DataSet.FieldByName('CODGRU').AsString,0) In [24] Then
      frmCfgModeloWPP.strEntSai := 'E';
    frmCfgModeloWPP.ShowModal();
  Finally
    pFreeAndNil(frmCfgModeloWPP);
  End;

end;

procedure TfrmCfgWpp.cxEditRepositoryBotaoOpcEnvioPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;

  Try
    If dtsWPPSAI.DataSet.FieldByName('CODGRU').AsString = '025' Then
    Begin
       pCriarFormularios(TfrmCfgWppAviDeb, frmCfgWppAviDeb);
       frmCfgWppAviDeb.ShowModal();
    End;
  Finally
    pFreeAndNil(frmCfgWppAviDeb);
  End;

end;

procedure TfrmCfgWpp.EDITORGetProperties(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
begin
  inherited;
  If MatchStr(Copy(ARecord.Values[GRUPO.Index],1,3), ['008', '009']) Then
     AProperties := cxEditRepositoryBotaoEditarWPPPortador.Properties
  Else If Copy(ARecord.Values[GRUPO.Index],1,3) = '025' Then
     AProperties := cxEditRepositoryBotaoOpcEnvio.Properties
  Else If (Copy(ARecord.Values[GRUPO.Index],1,3) = '033') and (Copy(ARecord.Values[CODWPP.Index],1,3) = '002') Then
     AProperties := cxEditRepositoryBotaoEditarWPPOpcEnvio.Properties
  Else
     AProperties := cxEditRepositoryBotaoEditarWPP.Properties;
end;

procedure TfrmCfgWpp.FAIXAFNGetProperties(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
begin
  inherited;
  If (Copy(ARecord.Values[GRUPO.Index],1,3) = '009') or
     ((Copy(ARecord.Values[GRUPO.Index],1,3) = '033') and (Copy(ARecord.Values[CODWPP.Index],1,3) = '001')) then
    AProperties := cxEditRepositoryMskHora.Properties
  Else
    AProperties := cxEditRepositoryTxtHoraDisable.Properties;
end;

procedure TfrmCfgWpp.FAIXAINGetProperties(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
begin
  inherited;
  If (Copy(ARecord.Values[GRUPO.Index],1,3) = '009') or
     ((Copy(ARecord.Values[GRUPO.Index],1,3) = '033') and (Copy(ARecord.Values[CODWPP.Index],1,3) = '001')) then
    AProperties := cxEditRepositoryMskHora.Properties
  Else
    AProperties := cxEditRepositoryTxtHoraDisable.Properties;
end;

procedure TfrmCfgWpp.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryCfgWpp);
  FreeAndNil(dspCfgWpp);
  FreeAndNil(cdsCfgWpp);
  FreeAndNil(qryCadFil);
  FreeAndNil(dspCadFil);
  FreeAndNil(cdsCadFil);
end;

procedure TfrmCfgWpp.FormCreate(Sender: TObject);
begin
  inherited;
  strAutIncContato := EmptyStr;
  FstrEntSai := 'S';
end;

procedure TfrmCfgWpp.pBeforePost(DataSet: TDataSet);
begin
  if (MatchStr(cdsCfgWpp.FieldByName('CODGRU').AsString, ['009', '025'])) or
     ((cdsCfgWpp.FieldByName('CODGRU').AsString = '033') and (cdsCfgWpp.FieldByName('CODWPP').AsString = '001')) then
  begin
    if cdsCfgWpp.FieldByName('FXHRIN').AsDateTime > cdsCfgWpp.FieldByName('FXHRFN').AsDateTime then
      cdsCfgWpp.FieldByName('FXHRIN').AsDateTime := StrToTime('00:00:00');
  end;
end;

procedure TfrmCfgWpp.FormShow(Sender: TObject);
begin
  inherited;
  qryCfgWpp := fCriaQuery(Self);
  dspCfgWpp := TUniDataSetProvider.Create(Self);
  cdsCfgWpp := TUniClientDataSet.Create(Self);
  cdsCfgWpp.BeforePost := pBeforePost;

  dspCfgWpp.DataSet := qryCfgWpp;
  cdsCfgWpp.SetProvider(dspCfgWpp);
  dtsWPPSAI.DataSet := cdsCfgWpp;
  pCarregaConfiguracoes;

  qryCadFil := fCriaQuery(Self);
  dspCadFil := TUniDataSetProvider.Create(Self);
  cdsCadFil := TUniClientDataSet.Create(Self);

  dspCadFil.DataSet := qryCadFil;
  cdsCadFil.SetProvider(dspCadFil);
  dtsFilas.DataSet := cdsCadFil;
  pCarregaFilas;

  pCriarGrupoAvisosDeDebitos;

  cxGridCitelTableView.ViewData.Expand(True);
end;

procedure TfrmCfgWpp.pCarregaFilas;
begin
  qryCadFil.SQL.Text :=
  ' SELECT '+
  '   AUTOINCREM, '+
  '   FIL_IDFILA, '+
  '   FIL_DESFIL  '+
  ' FROM '+
  '   CADFIL ';
  qryCadFil.Open;

  pSetaClient(qryCadFil);
  cdsCadFil.Open;
  pSetaClient(cdsCadFil);
end;

function TfrmCfgWpp.fRetEspecieDocumento(strCodGru: String; strCodigo: String): String;
begin
  Result := '';

  case AnsiIndexStr(strCodGru, ['001', '002','003','004','005','006','007','008','009','011','012','013','014',
                                '015', '016', '035', '036', '038', '037', '039', '022', '023', '024', '025',
                                '029', '033', '030', '027', '031', '046']) of
    0 : Result := 'OR';
    1 : Result := 'PD';
    2 : Result := 'E2';
    3 : Result := 'E3';
    4 : Result := 'E4';
    5 : Result := 'RO';
    6 : Result := 'E5';
    7 : Result := 'BO';
    8 : Result := 'AC';
    9 : Result := 'CD';
    10 : Result := 'CE';
    11 :
      Begin
        If (strCodigo = '002') Then
          Result := 'PC'
        Else
          Result := 'CF';
      End;
    12 : Result := 'PX';
    13 : Result := 'EF';
    14 : Result := 'TE';
    15,
    16,
    17 : Result := 'AN';
    18 : Result := 'FF';
    19 : Result := 'CB';
    20 : Result := 'RC';
    21 : Result := 'SE';
    22 : Result := 'PD';
    23 : Result := 'AD';
    24 : Result := 'CH';
    25 : Result := 'CL';
    26 : Result := 'AI';
    27 : Result := 'LP';
    28 : Result := 'PR';
    29 : Result := 'RE';
  end;

end;

procedure TfrmCfgWpp.pCarregaConfiguracoes;
Var
  strSQL: String;
  strGrupos: String;
begin

  //rotina responsável pela criação dos grupos
  //e gatilhos padrão para a empresa logada
  pCriarConfiguracoesPadrao(strGrupos);

  Try

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CONCAT(GRU_CODGRU, "-", GRU_DESGRU) AS GRUPOS, ';
    strSQL := strSQL + '  GRU_CODGRU        AS CODGRU, ';
    strSQL := strSQL + '  WPP_CODIGO        AS CODWPP, ';
    strSQL := strSQL + '  WPP_CODEMP        AS CODEMP, ';
    strSQL := strSQL + '  WPP_STATUS        AS STATUS, ';

    strSQL := strSQL + '  IF((WPP_CODGRU = "033" AND WPP_CODIGO = "002"), '+
                             'REPLACE(WPP_DESCRI, "XX", COALESCE(LPAD(CAST(WPP_INTENV AS CHAR), 2, "0"), "XX")), '+
                             'WPP_DESCRI) AS DESCRI, ';

    strSQL := strSQL + '  WPP_ORDENA        AS ORDENA, ';
    strSQL := strSQL + '  WPP_FXHRIN        AS FXHRIN, ';
    strSQL := strSQL + '  WPP_FXHRFN        AS FXHRFN, ';
    strSQL := strSQL + '  WPP_SEQFIL        AS FILWPP, ';
    strSQL := strSQL + '  WPP_INTENV        AS INTENV, ';
    strSQL := strSQL + '  WPPSAI.AUTOINCREM AS AUTOIN  ';
    strSQL := strSQL + 'FROM      ';
    strSQL := strSQL + '  WPPSAI  ';
    strSQL := strSQL + '  INNER JOIN GRUWPP ON GRU_CODGRU = WPP_CODGRU ';
    strSQL := strSQL + '  LEFT JOIN CADFIL ON CADFIL.AUTOINCREM = WPP_SEQFIL ';
    strSQL := strSQL + 'WHERE     ';
    strSQL := strSQL + '  WPP_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  GRU_CODGRU IN ('+strGrupos+') AND ';
    strSQL := strSQL + '  GRU_CODGRU <> "025" AND ';
    strSQL := strSQL + IIF(not fEmptyStr(strAutIncContato), ' WPP_SEQCTT = :SEQCTT ', ' WPP_SEQCTT IS NULL ');
    strSQL := strSQL + IIF(not fCfgSis('AUTCEN', varBoolean), ' AND GRU_CODGRU <> "023" ', '');
    strSQL := strSQL + IIF(not fEmptyStr(FstrCodGru) , ' AND GRU_CODGRU <> ' + FstrCodGru.QuotedString , '');

    If Not FMostraAvisoProximoDiaUtil Then
      strSQL := strSQL + '  AND (NOT (WPP_CODGRU = "009" AND WPP_CODIGO IN ("023", "024"))) ';

    strSQL := strSQL + 'ORDER BY  ';
    strSQL := strSQL + '  CODGRU, ';
    strSQL := strSQL + '  ORDENA  ';

    qryCfgWpp.Close;
    qryCfgWpp.SQL.Clear;
    qryCfgWpp.SQL.Add(strSQL);

    qryCfgWpp.ParamByName('CODEMP').AsString := VS_strCodEmp;

    if not fEmptyStr(strAutIncContato) then
      qryCfgWpp.ParamByName('SEQCTT').AsString := strAutIncContato;

    qryCfgWpp.Open;

    pSetaClient(qryCfgWpp);
    cdsCfgWpp.Open;
    pSetaClient(cdsCfgWpp);

    cdsCfgWpp.DisableControls;
    If cdsCfgWpp.Locate('CODGRU;CODWPP',
                         VarArrayOf(['002', '009']), []) Then
    Begin
      cdsCfgWpp.Edit;
      cdsCfgWpp.FieldByName('DESCRI').AsString := 'Inclusão/Alteração do Pedido - Pix';
      cdsCfgWpp.Post;
    End;
    cdsCfgWpp.First;
    cdsCfgWpp.EnableControls;

  Except
    On E:Exception Do
      pMensagensErro(e.Message, '[TfrmCfgWpp.pCarregaConfiguracoes]');
  End;

end;

{ ************************************************ }
{ SEMPRE QUE UM NOVO GRUPO OU UM NOVO GATILHO      }
{ FOR CRIADO O INSERT DEVERÁ SER INSERIDO AQUI     }
{ PARA A CRIAÇÃO NA EMPRESA LOGADA CASO NÃO EXISTA }
{ *********************************************DF* }
procedure TfrmCfgWpp.pCriarConfiguracoesPadrao(var AstrGrupos: String);
  Var
    intGruWpp,
    intTamGruWpp,
    intWPPSAI : Integer;
    qryTemp: TUniQuery;
    intOrdena: Integer;

  Const
    arrCodGruWpp: Array [1..30] Of String = ('001', '002', '003', '004', '005', '006', '007', '008', '009', '011', '012', '013', '014',
                                             '015', '016', '022', '023', '024', '025', '029', '035', '036', '037', '038', '039', '033',
                                             '030', '027', '031', '046');

    arrDesGruWpp: Array [1..30] Of String = ('Orçamento de Venda',
                                            'Pedido de Venda',
                                            'Expedição Tipo [2]: Faturamento antes da expedição',
                                            'Expedição Tipo [3]: Faturamento depois da expedição',
                                            'Expedição Tipo [4]: O pedido não será faturado',
                                            'Romaneio com Expedição Tipo [2/3/4]',
                                            'Expedição Tipo [5]: Expedição por romaneio. O pedido não será faturado',
                                            'Envio de Boleto',
                                            'Avisos de Cobrança',
                                            'Cupom de Desconto',
                                            'Conserto de Equipamentos',
                                            'Confirmação de Documentos',
                                            'Pix',
                                            'Entrega Futura',
                                            'App Ta Entregue',
                                            'Informações de Cobrança',
                                            'Autocenter',
                                            'Pedido de Compra',
                                            'Avisos de Débitos',
                                            'Cashback Venda',
                                            'Faturamento NFe',
                                            'Faturamento NFCe',
                                            'Faturamento Futuro',
                                            'Faturamento NFSe',
                                            'Cobrança Eletrônica',
                                            'Cliente',
                                            'Avisos Intelipost',
                                            'Link Pagamento',
                                            'Produtos',
                                            'Rastreamento da Entrega');

    arrTamGruWpp: Array [1..30] Of Integer = (11, 9, 1, 3, 4, 2, 6, 1, 23, 1, 4, 1, 2, 1, 3, 1, 1, 1, 2, 2, 2, 2, 2, 1, 1, 2, 1, 2, 1, 2);
    arrCodWPPSAI: Array [1..95] Of String = ({Grupo: Orçamento de Venda}
                                             '001', '002', '003', '004', '005', '006', '007', '008', '009', '010', '011',
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
                                             '001',
                                             {Grupo: Avisos de Cobrança}
                                             '004', '001', '005', '006', '007', '008', '009', '002', '010', '003', '011','012','013','014','015','016','018','019','020','021','022', '023', '024',
                                             {Grupo: Cupom de Desconto}
                                             '001',
                                             {Grupo: Conserto de Equipamentos}
                                             '001', '002', '003', '004',
                                             {Grupo: Confirmação de Documentos}
                                             '002',
                                             {Grupo: Pix}
                                             '001', '002',
                                             {Grupo: Entrega Futura}
                                             '001',
                                             {Grupo: App Ta Entregue}
                                             '001', '002', '003',
                                             {Grupo: Envio Reimpressão de Cobrança}
                                             '001',
                                             {Grupo: Autocenter}
                                             '001',
                                             {Grupo: Pedido de Compra}
                                             '001',
                                             {Grupo: Avisos de Débitos}
                                             '001', '002',
                                             {Grupo: Cashback Venda}
                                             '001', '002',
                                             {Grupo: Faturamento NFe}
                                             '001', '002',
                                             {Grupo: Faturamento NFCe}
                                             '001', '002',
                                             {Grupo: Faturamento Futuro}
                                             '001', '002',
                                             {Grupo: Faturamento NFSe}
                                             '001',
                                             {Grupo: Cobrança Eletrônica}
                                             '001',
                                             {Grupo: Cliente}
                                             '002', '001',
                                             {Grupo: Avisos Intelipost}
                                             '001',
                                             {Grupo: Link Pagamento}
                                             '001', '002',
                                             {Grupo: Produtos}
                                             '002',
                                             {Grupo: Rastreamento da Entrega}
                                             '001', '002');


    arrDesWPPSAI: Array [1..95] Of String = ({Grupo: Orçamento de Venda}
                                             'Inclusão do Orçamento',
                                             'Alteração do Orçamento',
                                             'Transformação do Orçamento em Pedido de Venda',
                                             'Faturamento do Orçamento em documento de Venda ( F11, Venda Normal )',
                                             '[F10] Baixa de Orçamento que não será entregue',
                                             'Cancelamento do Orçamento',
                                             'Envio manual pela consulta de orçamentos ou reimpressão de documentos',
                                             'Envio de mensagem agendada',
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
                                             'Aviso de cobrança 1 dia ANTES do vencimento',
                                             'Aviso de cobrança 2 dias ANTES do vencimento',
                                             'Aviso de cobrança 3 dias ANTES do vencimento',
                                             'Aviso de cobrança 4 dias ANTES do vencimento',
                                             'Aviso de cobrança 5 dias ANTES do vencimento',
                                             'Aviso de cobrança 1 dia APÓS vencimento',
                                             'Aviso de cobrança 2 dias APÓS vencimento',
                                             'Aviso de cobrança 3 dias APÓS o vencimento',
                                             'Aviso de cobrança 4 dias APÓS vencimento',
                                             'Aviso de cobrança 5 dias APÓS o vencimento',

                                             'Aviso de cobrança 8 dias APÓS vencimento',     //'011'
                                             'Aviso de cobrança 6 dias APÓS vencimento',     //'012'
                                             'Aviso de cobrança 7 dias APÓS vencimento',     //'013'
                                             'Aviso de cobrança 9 dias APÓS vencimento',     //'014'
                                             'Aviso de cobrança 10 dias APÓS vencimento',    //'015'
                                             'Aviso de cobrança 6 dias ANTES do vencimento',  //'016'
                                             'Aviso de cobrança 7 dias ANTES do vencimento',  //'018'
                                             'Aviso de cobrança 8 dias ANTES do vencimento',  //'019'
                                             'Aviso de cobrança 9 dias ANTES do vencimento',  //'020'
                                             'Aviso de cobrança 10 dias ANTES do vencimento', //'021'
                                             'Aviso de cobrança 30 dias APÓS vencimento',    //'022'

                                             'Aviso de cobrança antes do vencimento (Próximo dia útil) ', //'023'
                                             'Aviso de cobrança após vencimento (Próximo dia útil)',      //'024'
                                             {Grupo: Cupom de Descconto}
                                             'Venda gerou cupom de desconto',
                                             {Conserto de Equipamentos}
                                             'F9 Envio de E-mails - Consulta de OS',
                                             'Inclusão de uma nova Ordem de Serviço',
                                             'Baixa/Finalização de uma Ordem de Serviço',
                                             'Imprimir/Enviar Ordem de Serviço para o cliente',
                                             {Grupo: Confirmação de Documentos}
                                             'Envio de Pix para pagamento de duplicatas gerada na confirmação',
                                             {Grupo: Pix}
                                             'Envio de Pix para pagamento de duplicatas - Baixa de Contas a Receber',
                                             'Envio de Pix para geração de crédito ao cliente - Relação de Documentos com Pix Gerados',
                                             {Entrega Futura}
                                             'Aviso de Baixa de Entrega Futura ao Cliente',
                                             {Grupo: App Ta Entregue}
                                             'Rota Iniciada',
                                             'Aviso de Ocorrência na Entrega',
                                             'Entrega Concluída',
                                             {Grupo: Envio Reimpressão de Cobrança}
                                             'Envio de Nota Fiscal',
                                             {Grupo: Autocenter}
                                             'Alteração de Status do Serviço',
                                             {Grupo: Pedido de Compra}
                                             'Inclusão Pedido de Compra',
                                             {Grupo: Avisos de Débitos}
                                             'Aviso de Débito todo dia 01 de cada mês',
                                             'Aviso de Débito todo dia 16 de cada mês',
                                             {Grupo: Cashback}
                                             'Geração de Cashback',
                                             'Cashback - 7 dias antes do vencimento',
                                             {Grupo: Faturamento NFe}
                                             'Pós Autorização de Documento Fiscal',
                                             'Envio pela Reimpressão de Documentos Pós Autorização de Documento Fiscal',
                                             {Grupo: Faturamento NFCe}
                                             'Pós Autorização de Documento Fiscal',
                                             'Envio pela Reimpressão de Documentos Pós Autorização de Documento Fiscal',
                                             {Grupo: Faturamento Futuro}
                                             'Inclusão de Faturamento Futuro',
                                             'Envio pela Reimpressão de Documentos',
                                             {Grupo: Faturamento NFSe}
                                             'Pós Autorização de Documento Fiscal',
                                             {Grupo: Cobrança Eletrônica}
                                             'Mensagem de Link de Pagamento',
                                             {Grupo: Cliente}
                                             'Clientes que compraram nos últimos XX dias',
                                             'Envio de mensagem de aniversário',
                                             {Grupo: Avisos Intelipost}
                                             'Atualização de Status de Entrega',
                                             {Grupo: Link Pagamento}
                                             'Inclusão do Pedido',
                                             'Agrupamento Contas Receber',
                                             {Grupo: Produtos}
                                             'Envio de Foto',
                                             {Grupo: Rastreamento da Entrega}
                                             'Envio do código de rastreamento - Correio',
                                             'Envio do código de rastreamento - Acompanhamento de Entrega');

begin
  AstrGrupos := String.Join(',', arrCodGruWpp);

  intOrdena := 0;

  qryTemp := fCriaQuery(Self);
  Try

    Try
      fStartTransaction();

      intWPPSAI := 1;
      For intGruWpp := 1 To Length(arrCodGruWpp) Do
      Begin

        If (Not fExisteGruWpp(arrCodGruWpp[intGruWpp])) Then
          pIncluirRegistroGruWpp(arrCodGruWpp[intGruWpp], arrDesGruWpp[intGruWpp], qryTemp);

        For intTamGruWpp := 1 To arrTamGruWpp[intGruWpp] Do
        Begin
          If Not fExisteWPPSAI(arrCodGruWpp[intGruWpp], arrCodWPPSAI[intWPPSAI]) Then
          Begin
            If arrCodGruWpp[intGruWpp] = '009' Then
              Inc(intOrdena);

            pIncluirRegistroWPPSAI(arrCodWPPSAI[intWPPSAI], arrCodGruWpp[intGruWpp], arrDesWPPSAI[intWPPSAI], IntOrdena, qryTemp);
          End;

          intWPPSAI := intWPPSAI + 1;
        End;
      End;

	    fCommit();
    Except
      On E: Exception Do
      Begin
        fRollBack();
        pMensagensErro(e.Message, '[TfrmCfgWpp.pCriarConfiguracoesPadrao]')
      End;
    End;
  Finally
    FreeAndNil(qryTemp);
  End;
end;

function TfrmCfgWpp.fExisteGruWpp(strCodGru: String): Boolean;
begin
  Result := ( Not fEmptyStr( fCampoTabela('AUTOINCREM',
                                          'GRUWPP',
                                          ['GRU_CODGRU'],
                                          [strCodGru]) ) );
end;

procedure TfrmCfgWpp.pIncluirRegistroGruWpp(strCodGru, strDesGru: String; qryTemp: TUniQuery);
begin
  qryTemp.Close();
  qryTemp.SQL.Clear();
  qryTemp.SQL.Text := 'INSERT INTO GRUWPP (AUTOINCREM, GRU_CODGRU, GRU_CODEMP, GRU_DESGRU) ' +
    ' VALUES (:AUTINC, :CODGRU, :CODEMP, :DESGRU)';
  qryTemp.ParamByName('AUTINC').AsString := fRetAutoIncrem('GRUWPP', VS_strCodEmp);
  qryTemp.ParamByName('CODGRU').AsString := strCodGru;
  qryTemp.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryTemp.ParamByName('DESGRU').AsString := strDesGru;
  qryTemp.ExecSQL();
end;

function TfrmCfgWpp.fExisteWPPSAI(strCodGru, strCodigo: String): Boolean;
var
  qryWppSai: TUniQuery;
begin
  qryWppSai := fCriaQuery(Self);
  try
    qryWppSai.Close;
    qryWppSai.SQL.Text :=
    ' SELECT '+
    '   AUTOINCREM '+
    ' FROM '+
    '   WPPSAI '+
    ' WHERE '+
    '   WPP_CODIGO = :CODIGO AND '+
    '   WPP_CODGRU = :CODGRU AND '+
    '   WPP_CODEMP = :CODEMP AND '+
    IIF(not fEmptyStr(strAutIncContato), ' WPP_SEQCTT = :SEQCTT ', ' WPP_SEQCTT IS NULL ');

    qryWppSai.ParamByName('CODIGO').AsString := strCodigo;
    qryWppSai.ParamByName('CODGRU').AsString := strCodGru;
    qryWppSai.ParamByName('CODEMP').AsString := VS_strCodEmp;

    if not fEmptyStr(strAutIncContato) then
      qryWppSai.ParamByName('SEQCTT').AsString := strAutIncContato;

    qryWppSai.Open;

    Result := (not qryWppSai.IsEmpty);
  finally
    FreeAndNil(qryWppSai);
  end;
end;

procedure TfrmCfgWpp.pIncluirRegistroWPPSAI(strCodigo, strCodGru, strDescri: String; intOrdena: Integer; qryTemp: TUniQuery);
var
  strAutInc: String;
begin
  qryTemp.Close();
  qryTemp.SQL.Clear();
  qryTemp.SQL.Text :=
  '  INSERT INTO WPPSAI '+
  '   (AUTOINCREM, '+
  '    WPP_CODIGO, '+
  '    WPP_CODGRU, '+
  '    WPP_CODEMP, '+
  '    WPP_DESCRI, '+
  '    WPP_STATUS, '+
  '    WPP_ORDENA  '+
  IIF(not fEmptyStr(strAutIncContato), ', WPP_SEQCTT) ', ') ')+
  ' VALUES '+
  '   (:AUTINC, '+
  '    :CODIGO, '+
  '    :CODGRU, '+
  '    :CODEMP, '+
  '    :DESCRI, '+
  '    :STATUS, '+
  '    :ORDENA  '+
  IIF(not fEmptyStr(strAutIncContato), ', :SEQCTT) ', ') ');

  strAutInc := fRetAutoIncrem('WPPSAI', VS_strCodEmp);
  qryTemp.ParamByName('AUTINC').AsString := strAutInc;
  qryTemp.ParamByName('CODIGO').AsString := strCodigo;
  qryTemp.ParamByName('CODGRU').AsString := strCodGru;
  qryTemp.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryTemp.ParamByName('DESCRI').AsString := strDescri;
  qryTemp.ParamByName('STATUS').AsString := 'I';
  qryTemp.ParamByName('ORDENA').AsString := IIF(strCodGru = '009', intOrdena, strCodigo);

  if not fEmptyStr(strAutIncContato) then
    qryTemp.ParamByName('SEQCTT').AsString := strAutIncContato;

  qryTemp.ExecSQL();

  pSetaModeloMensagemPadrao(strAutInc, strCodGru, strCodigo);
end;

procedure TfrmCfgWpp.pSetaModeloMensagemPadrao(const strAutInc, strCodGru, strCodigo: String);
begin
  if Pos(strCodGru, '035_036_037_038_039_') > 0 then
    pImportaModeloMensagemDeOutroGatilho(strAutInc, strCodGru, strCodigo);
end;

procedure TfrmCfgWpp.pImportaModeloMensagemDeOutroGatilho(const strAutInc, strCodGru, strCodigo: String);
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
    '   WPP_SEQFIL  '+
    ' FROM '+
    '   WPPSAI '+
    ' INNER JOIN MODWPP '+
    '   ON WPPSAI.AUTOINCREM = MODWPP.MOD_SEQGER '+
    ' WHERE '+
    '   WPP_CODGRU = :CODGRU AND '+
    '   WPP_CODEMP = :CODEMP AND '+
    '   WPP_CODIGO = :CODIGO AND '+
    '   WPP_STATUS = :STATUS '+
    IIF(not fEmptyStr(strAutIncContato), ' AND WPP_SEQCTT = :SEQCTT ', ' AND WPP_SEQCTT IS NULL ');

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

    if not fEmptyStr(strAutIncContato) then
      qryModelo.ParamByName('SEQCTT').AsString := strAutIncContato;

    qryModelo.Open;

    if qryModelo.IsEmpty then
      Exit;

    qryAux.Close;
    qryAux.SQL.Text :=
    'INSERT INTO '+
    '  MODWPP(AUTOINCREM,  '+
    '         MOD_SEQGER,  '+
    '         MOD_MODELO,  '+
    '         MOD_ENVDOC)  '+
    '  VALUES(:AUTINC,     '+
    '         :SEQGER,     '+
    '         :MODELO,     '+
    '         :ENVDOC)     ';

    qryAux.ParamByName('AUTINC').AsString := fRetAutoIncrem('MODWPP', VS_strCodEmp);
    qryAux.ParamByName('SEQGER').AsString := strAutInc;
    qryAux.ParamByName('MODELO').AsString := qryModelo.FieldByName('MOD_MODELO').AsString;
    qryAux.ParamByName('ENVDOC').AsString := qryModelo.FieldByName('MOD_ENVDOC').AsString;
    qryAux.ExecSQL;

    qryAux.Close;
    qryAux.SQL.Text :=
    ' UPDATE '+
    '   WPPSAI '+
    ' SET '+
    '   WPP_STATUS = "A", ' +
    '   WPP_SEQFIL = :SEQFIL '+
    IIF(not fEmptyStr(strAutIncContato), ' ,WPP_SEQCTT = :SEQCTT ', '')+
    ' WHERE '+
    '   AUTOINCREM = :AUTINC ';

    qryAux.ParamByName('SEQFIL').AsString := qryModelo.FieldByName('WPP_SEQFIL').AsString;

    if not fEmptyStr(strAutIncContato) then
      qryAux.ParamByName('SEQCTT').AsString := strAutIncContato;

    qryAux.ParamByName('AUTINC').AsString := strAutInc;
    qryAux.ExecSQL;
  finally
    FreeAndNil(qryModelo);
    FreeAndNil(qryAux);
  end;
end;

function TfrmCfgWpp.fAtivadosNaoTemFilaInformada: Boolean;
begin
  Result := False;

  cdsCfgWpp.DisableControls;
  cdsCfgWpp.Filtered := False;
  cdsCfgWpp.Filter := 'STATUS = '+QuotedStr('A')+' AND FILWPP = '+QuotedStr('');
  cdsCfgWpp.Filtered := True;

  if not cdsCfgWpp.IsEmpty then
  begin
    fMensagem('Atenção','Todos os gatilhos ativados devem conter a informação da fila de envio da mensagem!',['&OK']);
    Result:= True;
  end;

  cdsCfgWpp.Filtered := False;
  cdsCfgWpp.EnableControls;
end;

function TfrmCfgWpp.fCodigoGrupo(strCodGru: String): TfrmCfgWpp;
begin
  Result := Self;
  FstrCodGru := strCodGru;
end;

procedure TfrmCfgWpp.pGravar;
Var
  qryGravar: TUniQuery;
  strSQL   : String;
begin
  if fAtivadosNaoTemFilaInformada then
  begin
    ModalResult := mrNone;
    Exit;
  end;

  qryGravar := fCriaQuery(Self);
  Try

    Try
      strSQL := '';
      strSQL := strSQL + 'UPDATE           ';
      strSQL := strSQL + '  WPPSAI         ';
      strSQL := strSQL + 'SET              ';
      strSQL := strSQL + '  WPP_STATUS = :STATUS, ';
      strSQL := strSQL + '  WPP_SEQFIL = :SEQFIL, ';
      strSQL := strSQL + '  WPP_FXHRIN = :FXHRIN, ';
      strSQL := strSQL + '  WPP_FXHRFN = :FXHRFN, ';
      strSQL := strSQL + '  WPP_INTENV = :INTENV  ';
      strSQL := strSQL + 'WHERE            ';
      strSQL := strSQL + '  AUTOINCREM = :AUTOIN AND ';
      strSQL := strSQL + '  WPP_CODEMP = :CODEMP     ';

      cdsCfgWpp.First;
      While Not cdsCfgWpp.Eof Do
      Begin

        If Not cdsCfgWpp.FieldByName('CODGRU').AsString.Equals('025') Then
        Begin
          qryGravar.Close;
          qryGravar.SQL.Clear;
          qryGravar.SQL.Add(strSQL);
          qryGravar.ParamByName('STATUS').AsString := cdsCfgWpp.FieldByName('STATUS').AsString;
          qryGravar.ParamByName('AUTOIN').AsString := cdsCfgWpp.FieldByName('AUTOIN').AsString;
          qryGravar.ParamByName('CODEMP').AsString := cdsCfgWpp.FieldByName('CODEMP').AsString;
          qryGravar.ParamByName('SEQFIL').AsString := cdsCfgWpp.FieldByName('FILWPP').AsString;
          qryGravar.ParamByName('INTENV').AsInteger := cdsCfgWpp.FieldByName('INTENV').AsInteger;

          qryGravar.ParamByName('FXHRIN').Value := Null;
          qryGravar.ParamByName('FXHRFN').Value := Null;
          if (Pos(cdsCfgWpp.FieldByName('CODGRU').AsString, '009_') > 0) or
             ((cdsCfgWpp.FieldByName('CODGRU').AsString = '033') and (cdsCfgWpp.FieldByName('CODWPP').AsString = '001')) then
          begin
            qryGravar.ParamByName('FXHRIN').AsTime := cdsCfgWpp.FieldByName('FXHRIN').AsDateTime;
            qryGravar.ParamByName('FXHRFN').AsTime := cdsCfgWpp.FieldByName('FXHRFN').AsDateTime;
          end;

          qryGravar.ExecSQL;
        End;

        cdsCfgWpp.Next;
      End;
    Except
      On E: Exception Do
        pMensagensErro(e.Message, '[TfrmCfgWpp.pGravar]')
    End;
  Finally
    FreeAndNil(qryGravar);
  End;

end;

function TfrmCfgWpp.ValidaSeOsModelosAtivosPossuemConteudo: Boolean;
  Var
    LConsulta: TUniQuery;
begin

  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT W.WPP_CODGRU, ' +
                          '       W.WPP_DESCRI  ' +
                          'FROM WPPSAI W ' +
                          'LEFT JOIN MODWPP M ON M.MOD_SEQGER=W.AUTOINCREM ' +
                          'WHERE W.AUTOINCREM IN ('+fRetAutIncGatilhosAtivados+') ' +
                          '  AND W.WPP_CODEMP="' + VS_strCodEmp + '" ';

    If Not fCfgSis('USAPIX', varBoolean) Then
      LConsulta.SQL.Add(' AND W.WPP_CODGRU <> "014" ');

    If Not fCfgSis('AUTCEN', varBoolean) Then
       LConsulta.SQL.Add(' AND W.WPP_CODGRU <> "023" ');

    If Not FMostraAvisoProximoDiaUtil Then
      LConsulta.SQL.Add('  AND (NOT (W.WPP_CODGRU = "009" AND W.WPP_CODIGO IN ("023", "024"))) ');

    LConsulta.SQL.Add('  AND (M.MOD_SEQGER IS NULL ' +
                      '    OR TRIM(COALESCE(M.MOD_MODELO, "")) = "") ');

    LConsulta.SQL.Add(IIF(fEmptyStr(strAutIncContato), ' AND WPP_SEQCTT IS NULL ', ' AND WPP_SEQCTT = :SEQCTT ')  );

    if not fEmptyStr(strAutIncContato) then
      LConsulta.ParamByName('SEQCTT').AsString := strAutIncContato;

    LConsulta.Open;

    Result := LConsulta.IsEmpty;

    If Not Result Then
      fMensagem('ATENÇÃO', 'Para confirmar a gravação, todos os modelos ativos devem possuir conteúdo.' + #13 +
                           'Acesse o grupo "' + LConsulta.FieldByName('WPP_CODGRU').AsString + ', ' +
                           'clique em "Editar Mensagem" no modelo "' + LConsulta.FieldByName('WPP_DESCRI').AsString + '" ' +
                           'e adicione o conteúdo para o Whatsapp.', ['&Ok']);
  Finally
    LConsulta.Close;
    FreeAndNil(LConsulta);
  End;
end;

function TfrmCfgWpp.fRetAutIncGatilhosApiOficialAtivados: String;
var
  intRecNo: Integer;
begin
  Result := EmptyStr;

  intRecNo := cdsCfgWpp.RecNo;

  cdsCfgWpp.DisableControls;
  try
    cdsCfgWpp.First;
    while not cdsCfgWpp.Eof do
    begin
      if (cdsCfgWpp.FieldByName('STATUS').AsString = 'A') and (fCampoTabela('FIL_APIOFI', 'CADFIL', ['AUTOINCREM'], [dtsWPPSAI.DataSet.FieldByName('FILWPP').AsString]) = 'S') then
        Result := IIF(not fEmptyStr(Result), Result + ', ', '') + QuotedStr(cdsCfgWpp.FieldByName('AUTOIN').AsString);
      cdsCfgWpp.Next;
    end;
  finally
    cdsCfgWpp.RecNo := intRecNo;
    cdsCfgWpp.EnableControls;
  end;
end;

function TfrmCfgWpp.fRetAutIncGatilhosAtivados: String;
var
  intRecNo: Integer;
begin
  Result := EmptyStr;

  intRecNo := cdsCfgWpp.RecNo;

  cdsCfgWpp.DisableControls;
  try
    cdsCfgWpp.First;
    while not cdsCfgWpp.Eof do
    begin
      if cdsCfgWpp.FieldByName('STATUS').AsString = 'A' then
        Result := IIF(not fEmptyStr(Result), Result + ', ', '') + QuotedStr(cdsCfgWpp.FieldByName('AUTOIN').AsString);
      cdsCfgWpp.Next;
    end;
  finally
    cdsCfgWpp.RecNo := intRecNo;
    cdsCfgWpp.EnableControls;
  end;

  if fEmptyStr(Result) then
    Result := QuotedStr(EmptyStr);
end;

procedure TfrmCfgWpp.ATIVOGetProperties(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
begin
  inherited;
  If Copy(ARecord.Values[GRUPO.Index],1,3) = '025' Then
     AProperties := cxEditRepository1Label.Properties;
end;

procedure TfrmCfgWpp.ATIVOPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;
  cdsCfgWpp.FieldByName('FILWPP').AsString := IIF(cdsCfgWpp.FieldByName('STATUS').AsString = 'A',
                                                  fRetFilaPrincipalDaEmpresaLogada,
                                                  '');
end;

function TfrmCfgWpp.fRetFilaPrincipalDaEmpresaLogada: String;
begin
  Result := fCampoTabela('AUTOINCREM', 'CADFIL', ['FIL_CODEMP', 'FIL_FILPRI'], [VS_strCodEmp, 'S']);
end;

function TfrmCfgWpp.fTodosModelosDaApiOficialTemTemplateDefinido: Boolean;
var
  qryTemplate: TUniQuery;
  strAutInc: String;
begin
  Result := True;

  strAutInc := fRetAutIncGatilhosApiOficialAtivados;
  if fEmptyStr(strAutInc) then
    Exit;

  qryTemplate := fCriaQuery;
  try
    qryTemplate.Close;
    qryTemplate.SQL.Text :=
    ' SELECT '+
    '   MOD_TEMPID '+
    ' FROM '+
    '   MODWPP '+
    ' WHERE '+
    '   MOD_SEQGER IN ( '+strAutInc+')';

    qryTemplate.Open;
    while not qryTemplate.Eof do
    begin
      if (fEmptyStr(qryTemplate.FieldByName('MOD_TEMPID').AsString)) or (qryTemplate.FieldByName('MOD_TEMPID').AsInteger = 0) then
      begin
        Result := False;
        Break;
      end;

      qryTemplate.Next;
    end;

    if not Result then
      fMensagem('ATENÇÃO', 'Os gatilhos configurados para utilizar a fila oficial do WhatsApp devem ter um template definido!'+sLineBreak+
                           'Clique em "Editar Mensagem" e configure o template.', ['&Ok']);
  finally
    FreeAndNil(qryTemplate);
  end;

end;

function TfrmCfgWpp.ModelosAvisoDeCobrancaNecessariosConfigurados: Boolean;
  Var
    LRecNo: Integer;
begin
  Result := Not FMostraAvisoProximoDiaUtil;

  If Result Then
    Exit;

  LRecNo := cdsCfgWpp.RecNo;
  cdsCfgWpp.DisableControls;

  Try
    cdsCfgWpp.Filter := 'CODGRU=''009'' AND (CODWPP <> ''023'' AND CODWPP <> ''024'') ';
    cdsCfgWpp.Filtered := True;

    Result := cdsCfgWpp.IsEmpty;

    If Result Then
      Exit;

    cdsCfgWpp.Filter := 'CODGRU=''009'' AND (CODWPP = ''023'' OR CODWPP = ''024'') ';
    cdsCfgWpp.Filtered := True;

    Result := cdsCfgWpp.RecordCount = 2;

    If Not Result Then
      fMensagem('ATENÇÃO',
                'Com a configuração CFG_AVIFDS igual a "Sim" e com ' +
                   'modelos de avisos de cobrança configurados, é exigido ' +
                   'que os modelos referentes ao próximo dia útil sejam configurados.' + #13 +
                   'Deve ser configurado o modelo nos grupos "Antes do Vencimento" e "Após o Vencimento"',
                ['&Ok']);
  Finally
    cdsCfgWpp.Filtered := False;
    cdsCfgWpp.RecNo := LRecNo;

    cdsCfgWpp.EnableControls;;
  End;
end;

procedure TfrmCfgWpp.pCriarGrupoAvisosDeDebitos;
  Var
    intRecNo : Integer;
begin
  If cdsCfgWpp.IsEmpty Then
    Exit;

  intRecNo := cdsCfgWpp.RecNo;
  Try
    cdsCfgWpp.DisableControls;
    cdsCfgWpp.Insert;
    cdsCfgWpp.FieldByName('GRUPOS').AsString := '025-Avisos De Débito';
    cdsCfgWpp.FieldByName('CODGRU').AsString := '025';
    cdsCfgWpp.FieldByName('ORDENA').AsString := '1';
    cdsCfgWpp.FieldByName('DESCRI').AsString := 'Avisos de Débito';
    cdsCfgWpp.Post;
    cdsCfgWpp.RecNo := intRecNo;
    cdsCfgWpp.EnableControls;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(e.Message, '[TfrmCfgWpp.pCriarGrupoAvisosDeDebito]');
    End;
  End;

end;

end.
