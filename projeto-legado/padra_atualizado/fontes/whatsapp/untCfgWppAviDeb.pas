unit untCfgWppAviDeb;

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
  cxTextEdit;

type
  TfrmCfgWppAviDeb = class(TfrmPaiConfirma)
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
    ROBO: TcxGridDBColumn;
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
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConfirmaClick(Sender: TObject);
    procedure ROBOPropertiesEditValueChanged(Sender: TObject);
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

  private
    arrCodGruWpp: Array Of String;
    arrDesGruWpp: Array Of String;
    arrTamGruWpp: Array Of Integer;
    arrCodWPPSAI: Array Of String;
    arrDesWPPSAI: Array Of String;

    qryCfgWpp, qryCadFil: TUniQuery;
    cdsCfgWpp, cdsCadFil: TUniClientDataSet;
    dspCfgWpp, dspCadFil: TUniDataSetProvider;
    FstrCodGru: String;
    FstrEntSai: String;
    procedure pCarregaConfiguracoes;
    procedure pGravar;
    function fRetEspecieDocumento(strCodGru: String): String;
    procedure pCriarConfiguracoesPadrao;
    procedure pCarregaFilas;
    function fAtivadosNaoTemFilaInformada: Boolean;
    procedure pIncluirRegistroWPPSAI(strCodigo, strCodGru, strDescri: String; intOrdena: Integer; qryTemp: TUniQuery);
    function fExisteWPPSAI(strCodGru, strCodigo: String): Boolean;
    procedure pIncluirRegistroGruWpp(strCodGru, strDesGru: String; qryTemp: TUniQuery);
    function fExisteGruWpp(strCodGru: String): Boolean;
    function fRetFilaPrincipalDaEmpresaLogada: String;
    function fPodeCriarGatilho(strCodGru: String): Boolean;
    procedure pBeforePost(DataSet: TDataSet);
    procedure pAdicionarOpcao(FCodGruWpp, FDesGruWpp: String);
    procedure ValidaSeTodosAtivosPossuemAsRegrasConfiguradas;
  public
    { Public declarations }
    strAutIncContato: String;
    //function fCodigoGrupo(strCodGru: String): TfrmCfgSMSAviDeb;
    property strEntSai: String read FstrEntSai write FstrEntSai;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untCfgPortadoresAutorizadosEmail,
  untCfgModeloWPP;

procedure TfrmCfgWppAviDeb.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  pGravar;
end;

procedure TfrmCfgWppAviDeb.cxEditRepositoryBotaoEditarWPPPortadorPropertiesButtonClick(
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
      frmCfgModeloWPP.strEspDoc := fRetEspecieDocumento (dtsWPPSAI.DataSet.FieldByName('CODGRU').AsString);
      frmCfgModeloWPP.strCodGru := dtsWPPSAI.DataSet.FieldByName('CODGRU').AsString;
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

procedure TfrmCfgWppAviDeb.cxEditRepositoryBotaoEditarWPPPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
var
  frmCfgModeloWPP: TfrmCfgModeloWPP;
begin
  inherited;

  Try
    pCriarFormularios(TfrmCfgModeloWPP, frmCfgModeloWPP);
    frmCfgModeloWPP.Caption   := frmCfgModeloWPP.Caption + ' - ' + dtsWPPSAI.DataSet.FieldByName('DESCRI').AsString;
    frmCfgModeloWPP.strSeqGer := dtsWPPSAI.DataSet.FieldByName('AUTOIN').AsString;
    frmCfgModeloWPP.strEspDoc := fRetEspecieDocumento(dtsWPPSAI.DataSet.FieldByName('CODGRU').AsString);
    frmCfgModeloWPP.strCodGru := dtsWPPSAI.DataSet.FieldByName('CODGRU').AsString;
    If StrToIntDef(dtsWPPSAI.DataSet.FieldByName('CODGRU').AsString,0) In [24] Then
      frmCfgModeloWPP.strEntSai := 'E';
    frmCfgModeloWPP.ShowModal();
  Finally
    pFreeAndNil(frmCfgModeloWPP);
  End;

end;

procedure TfrmCfgWppAviDeb.EDITORGetProperties(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
begin
  inherited;
  If MatchStr(Copy(ARecord.Values[GRUPO.Index],1,3), ['025']) Then
     AProperties := cxEditRepositoryBotaoEditarWPPPortador.Properties
  Else
     AProperties := cxEditRepositoryBotaoEditarWPP.Properties;
end;

procedure TfrmCfgWppAviDeb.FAIXAFNGetProperties(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
begin
  inherited;
  AProperties := cxEditRepositoryTxtHoraDisable.Properties;
end;

procedure TfrmCfgWppAviDeb.FAIXAINGetProperties(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
begin
  inherited;
  AProperties := cxEditRepositoryTxtHoraDisable.Properties;
end;

procedure TfrmCfgWppAviDeb.FormClose(Sender: TObject;
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

procedure TfrmCfgWppAviDeb.FormCreate(Sender: TObject);
begin
  inherited;
  strAutIncContato := EmptyStr;
  FstrEntSai := 'S';
end;

procedure TfrmCfgWppAviDeb.pBeforePost(DataSet: TDataSet);
begin
  if MatchStr(cdsCfgWpp.FieldByName('CODGRU').AsString, ['025']) then
  begin
    if cdsCfgWpp.FieldByName('FXHRIN').AsDateTime > cdsCfgWpp.FieldByName('FXHRFN').AsDateTime then
       cdsCfgWpp.FieldByName('FXHRIN').AsDateTime := StrToTime('00:00:00');
  end;
end;

procedure TfrmCfgWppAviDeb.FormShow(Sender: TObject);
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
  cxGridCitelTableView.ViewData.Expand(True);


  qryCadFil := fCriaQuery(Self);
  dspCadFil := TUniDataSetProvider.Create(Self);
  cdsCadFil := TUniClientDataSet.Create(Self);

  dspCadFil.DataSet := qryCadFil;
  cdsCadFil.SetProvider(dspCadFil);
  dtsFilas.DataSet := cdsCadFil;
  pCarregaFilas;
end;

procedure TfrmCfgWppAviDeb.pCarregaFilas;
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

function TfrmCfgWppAviDeb.fRetEspecieDocumento(strCodGru: String): String;
begin
  Result := '';

  If strCodGru = '025' Then
     Result := 'AD';

end;

procedure TfrmCfgWppAviDeb.pCarregaConfiguracoes;
Var
  strSQL: String;
begin
  pCriarConfiguracoesPadrao();

  Try

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CONCAT(GRU_CODGRU, "-", GRU_DESGRU) AS GRUPOS, ';
    strSQL := strSQL + '  GRU_CODGRU        AS CODGRU, ';
    strSQL := strSQL + '  WPP_CODIGO        AS CODWPP, ';
    strSQL := strSQL + '  WPP_CODEMP        AS CODEMP, ';
    strSQL := strSQL + '  WPP_STATUS        AS STATUS, ';
    strSQL := strSQL + '  WPP_DESCRI        AS DESCRI, ';
    strSQL := strSQL + '  WPP_ORDENA        AS ORDENA, ';
    strSQL := strSQL + '  WPP_FXHRIN        AS FXHRIN, ';
    strSQL := strSQL + '  WPP_FXHRFN        AS FXHRFN, ';
    strSQL := strSQL + '  WPP_MDROBO        AS MDROBO, ';
    strSQL := strSQL + '  WPP_SEQFIL        AS FILWPP, ';
    strSQL := strSQL + '  WPPSAI.AUTOINCREM AS AUTOIN  ';
    strSQL := strSQL + 'FROM      ';
    strSQL := strSQL + '  WPPSAI  ';
    strSQL := strSQL + '  INNER JOIN GRUWPP ON GRU_CODGRU = WPP_CODGRU ';
    strSQL := strSQL + '  LEFT JOIN CADFIL ON CADFIL.AUTOINCREM = WPP_SEQFIL ';
    strSQL := strSQL + 'WHERE     ';
    strSQL := strSQL + '  WPP_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  GRU_CODGRU = "025" AND   ';
    strSQL := strSQL + IIF(not fEmptyStr(strAutIncContato), ' WPP_SEQCTT = :SEQCTT ', ' WPP_SEQCTT IS NULL ');
    strSQL := strSQL + IIF(not fCfgSis('AUTCEN', varBoolean), ' AND GRU_CODGRU <> "023" ', '');
    strSQL := strSQL + IIF(not fEmptyStr(FstrCodGru) , ' AND GRU_CODGRU <> ' + FstrCodGru.QuotedString , '');
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

   {cdsCfgWpp.DisableControls;
    If cdsCfgWpp.Locate('CODGRU;CODWPP',
                         VarArrayOf(['002', '009']), []) Then
    Begin
      cdsCfgWpp.Edit;
      cdsCfgWpp.FieldByName('DESCRI').AsString := 'Inclusão/Alteração do Pedido - Pix';
      cdsCfgWpp.Post;
    End;}
    cdsCfgWpp.First;
//    cdsCfgWpp.EnableControls;

  Except
    On E:Exception Do
      pMensagensErro(e.Message, '[TfrmCfgWppAviDeb.pCarregaConfiguracoes]');
  End;

end;

procedure TfrmCfgWppAviDeb.pAdicionarOpcao(FCodGruWpp,FDesGruWpp: String);//(FCodEmaSAI,FDesEmaSAI: String);
begin
  // Codigo do Grupo
  SetLength(arrCodGruWpp, 1);
  arrCodGruWpp[0] := '025';

  // Descrição do Grupo
  SetLength(arrDesGruWpp,1);
  arrDesGruWpp[0] := 'Avisos de Débito';

  // Código das opção por grupo
  SetLength(arrCodWPPSAI, Length(arrCodWPPSAI) + 1);
  arrCodWPPSAI[Length(arrCodWPPSAI)-1] := FCodGruWpp;

  // Descrição das opção
  SetLength(arrDesWPPSAI, Length(arrDesWPPSAI) + 1);
  arrDesWPPSAI[Length(arrDesWPPSAI)-1] := FDesGruWpp;

  // Quantidade de opção
  SetLength(arrTamGruWpp, 1);
  arrTamGruWpp[0] := Length(arrCodGruWpp);
end;

{ ************************************************ }
{ SEMPRE QUE UM NOVO GRUPO OU UM NOVO GATILHO      }
{ FOR CRIADO O INSERT DEVERÁ SER INSERIDO AQUI     }
{ PARA A CRIAÇÃO NA EMPRESA LOGADA CASO NÃO EXISTA }
{ *********************************************DF* }
procedure TfrmCfgWppAviDeb.pCriarConfiguracoesPadrao;
  Var
    intGruWpp,
    intTamGruWpp,
    intWPPSAI : Integer;
    qryTemp: TUniQuery;
    intOrdena: Integer;
begin
  intOrdena := 0;

  Try
    qryTemp := fCriaQuery(Self);

    // OPÇÕES ANTES DO VENCIMENTO
    pAdicionarOpcao('001','Aviso de Débito todo dia 01 de cada mês');
    pAdicionarOpcao('002','Aviso de Débito todo dia 16 de cada mês');

    Try
      fStartTransaction();

      intWPPSAI := 0;
      For intGruWpp := 0 To (Length(arrCodGruWpp) -1) Do
      Begin

        If (Not fExisteGruWpp(arrCodGruWpp[intGruWpp])) Then
          pIncluirRegistroGruWpp(arrCodGruWpp[intGruWpp], arrDesGruWpp[intGruWpp], qryTemp);

        For intTamGruWpp := 1 To arrTamGruWpp[intGruWpp] Do
        Begin
          If (fPodeCriarGatilho(arrCodGruWpp[intGruWpp])) And
             (Not fExisteWPPSAI(arrCodGruWpp[intGruWpp], arrCodWPPSAI[intWPPSAI])) Then
          Begin
             pIncluirRegistroWPPSAI(arrCodWPPSAI[intWPPSAI], arrCodGruWpp[intGruWpp], arrDesGruWpp[intWPPSAI], IntOrdena, qryTemp);
          End;

          intWPPSAI := intWPPSAI + 1;
        End;

      End;

	    fCommit();
    Except
      On E: Exception Do
      Begin
        fRollBack();
        pMensagensErro(e.Message, '[TfrmCfgWppAviDeb.pCriarConfiguracoesPadrao]')
      End;
    End;
  Finally
    FreeAndNil(qryTemp);
  End;
end;

function TfrmCfgWppAviDeb.fPodeCriarGatilho(strCodGru: String): Boolean;
begin
  Result := True;

  if (not fEmptyStr(strAutIncContato)) and (strCodGru = '009') then
    Result := False;
end;

function TfrmCfgWppAviDeb.fExisteGruWpp(strCodGru: String): Boolean;
begin
  Result := ( Not fEmptyStr( fCampoTabela('AUTOINCREM',
                                          'GRUWPP',
                                          ['GRU_CODGRU'],
                                          [strCodGru]) ) );
end;

procedure TfrmCfgWppAviDeb.pIncluirRegistroGruWpp(strCodGru, strDesGru: String; qryTemp: TUniQuery);
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

function TfrmCfgWppAviDeb.fExisteWPPSAI(strCodGru, strCodigo: String): Boolean;
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

procedure TfrmCfgWppAviDeb.pIncluirRegistroWPPSAI(strCodigo, strCodGru, strDescri: String; intOrdena: Integer; qryTemp: TUniQuery);
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
  '    WPP_ORDENA, '+
  '    WPP_MDROBO  '+
  IIF(not fEmptyStr(strAutIncContato), ', WPP_SEQCTT) ', ') ')+
  ' VALUES '+
  '   (:AUTINC, '+
  '    :CODIGO, '+
  '    :CODGRU, '+
  '    :CODEMP, '+
  '    :DESCRI, '+
  '    :STATUS, '+
  '    :ORDENA, '+
  '    :MDROBO  '+
  IIF(not fEmptyStr(strAutIncContato), ', :SEQCTT) ', ') ');

  qryTemp.ParamByName('AUTINC').AsString := fRetAutoIncrem('WPPSAI', VS_strCodEmp);
  qryTemp.ParamByName('CODIGO').AsString := strCodigo;
  qryTemp.ParamByName('CODGRU').AsString := strCodGru;
  qryTemp.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryTemp.ParamByName('DESCRI').AsString := strDescri;
  qryTemp.ParamByName('STATUS').AsString := 'I';
  qryTemp.ParamByName('ORDENA').AsString := IIF(strCodGru = '009', intOrdena, strCodigo);
  qryTemp.ParamByName('MDROBO').AsString := 'N';

  if not fEmptyStr(strAutIncContato) then
    qryTemp.ParamByName('SEQCTT').AsString := strAutIncContato;

  qryTemp.ExecSQL();
end;

function TfrmCfgWppAviDeb.fAtivadosNaoTemFilaInformada: Boolean;
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

{function TfrmCfgWppAviDeb.fCodigoGrupo(strCodGru: String): TfrmCfgWppAviDeb;
begin
  Result := Self;
  FstrCodGru := strCodGru;
end;}

procedure TfrmCfgWppAviDeb.pGravar;
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
      strSQL := strSQL + '  WPP_MDROBO = :MDROBO, ';
      strSQL := strSQL + '  WPP_STATUS = :STATUS, ';
      strSQL := strSQL + '  WPP_SEQFIL = :SEQFIL, ';
      strSQL := strSQL + '  WPP_FXHRIN = :FXHRIN, ';
      strSQL := strSQL + '  WPP_FXHRFN = :FXHRFN  ';
      strSQL := strSQL + 'WHERE            ';
      strSQL := strSQL + '  AUTOINCREM = :AUTOIN AND ';
      strSQL := strSQL + '  WPP_CODEMP = :CODEMP     ';

      cdsCfgWpp.First;
      While Not cdsCfgWpp.Eof Do
      Begin
        qryGravar.Close;
        qryGravar.SQL.Clear;
        qryGravar.SQL.Add(strSQL);
        qryGravar.ParamByName('STATUS').AsString := cdsCfgWpp.FieldByName('STATUS').AsString;
        qryGravar.ParamByName('AUTOIN').AsString := cdsCfgWpp.FieldByName('AUTOIN').AsString;
        qryGravar.ParamByName('CODEMP').AsString := cdsCfgWpp.FieldByName('CODEMP').AsString;
        qryGravar.ParamByName('MDROBO').AsString := cdsCfgWpp.FieldByName('MDROBO').AsString;
        qryGravar.ParamByName('SEQFIL').AsString := cdsCfgWpp.FieldByName('FILWPP').AsString;

        qryGravar.ParamByName('FXHRIN').Value := Null;
        qryGravar.ParamByName('FXHRFN').Value := Null;
       // if cdsCfgWpp.FieldByName('CODGRU').AsString = '009' then
       // begin
       //  qryGravar.ParamByName('FXHRIN').AsTime := cdsCfgWpp.FieldByName('FXHRIN').AsDateTime;
       //   qryGravar.ParamByName('FXHRFN').AsTime := cdsCfgWpp.FieldByName('FXHRFN').AsDateTime;
       // end;

        qryGravar.ExecSQL;

        cdsCfgWpp.Next;
      End;

      ValidaSeTodosAtivosPossuemAsRegrasConfiguradas;
    Except
      On E: Exception Do
        pMensagensErro(e.Message, '[TfrmCfgWppAviDeb.pGravar]')
    End;
  Finally
    FreeAndNil(qryGravar);
  End;

end;

procedure TfrmCfgWppAviDeb.ROBOPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;
  If cdsCfgWpp.Active Then
  Begin
    If (cdsCfgWpp.FieldByName('CODGRU').AsString + '-' + cdsCfgWpp.FieldByName('CODWPP').AsString <> '008-001') Then
    Begin
      fMensagem('Atenção','Opção não disponível para modo robo, SMS será enviado via processamento paralelo!',['&OK']);
      cdsCfgWpp.FieldByName('MDROBO').AsString := 'N';
    End;
  End;
end;

procedure TfrmCfgWppAviDeb.ValidaSeTodosAtivosPossuemAsRegrasConfiguradas;
  Var
    LConsulta: TUniQuery;

    LExisteRegistroSemRegras: Boolean;
begin
  LExisteRegistroSemRegras := False;

  Try
    LConsulta := fCriaQuery;
    LConsulta.SQL.Text := 'SELECT MOD_REGREL FROM MODWPP WHERE MOD_SEQGER=:SEQGER';

    cdsCfgWpp.DisableControls;

    cdsCfgWpp.Filter := 'STATUS=''A'' ';
    cdsCfgWpp.Filtered := True;

    cdsCfgWpp.First;

    While Not cdsCfgWpp.Eof Do
    Begin
      LConsulta.Close;
      LConsulta.ParamByName('SEQGER').AsString := cdsCfgWpp.FieldByName('AUTOIN').AsString;
      LConsulta.Open;

      LExisteRegistroSemRegras := LConsulta.FieldByName('MOD_REGREL').AsString.IsEmpty;
      If LExisteRegistroSemRegras Then
        Break;

      cdsCfgWpp.Next;
    End;
  Finally
    FreeAndNil(LConsulta);

    cdsCfgWpp.Filter := '';
    cdsCfgWpp.Filtered := False;

    cdsCfgWpp.EnableControls;

    If LExisteRegistroSemRegras Then
      fMensagem('ATENÇÃO', 'Existe(m) modelo(s) ativo(s) sem as Regras do Relatório configurada(s).' + #13 +
                           'Esse(s) modelo(s) não funcionará(ão) até que as regras seja(m) configurada(s).', ['&Ok']);
  End;
end;

procedure TfrmCfgWppAviDeb.ATIVOPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;
  cdsCfgWpp.FieldByName('FILWPP').AsString := IIF(cdsCfgWpp.FieldByName('STATUS').AsString = 'A',
                                                  fRetFilaPrincipalDaEmpresaLogada,
                                                  '');
end;

function TfrmCfgWppAviDeb.fRetFilaPrincipalDaEmpresaLogada: String;
begin
  Result := fCampoTabela('AUTOINCREM', 'CADFIL', ['FIL_CODEMP', 'FIL_FILPRI'], [VS_strCodEmp, 'S']);
end;

end.
