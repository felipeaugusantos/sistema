unit untEntFreConGridIdentificaDocumento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, UniClientDataSet,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, Uni, untFuncoesSimples,
  cxGridBandedTableView, cxGridDBBandedTableView, System.strUtils, untTypesSistema,
  cxDataControllerConditionalFormattingRulesManagerDialog, untLiberacao, untMsgLiberacao,
  cxButtonEdit, System.Actions, Vcl.ActnList, EditFocus, untConsultas,
  cxTextEdit, cxDropDownEdit;

type
  TfrmEntFreConGridIdentificaDocumento = class(TfrmPaiConfirma)
    cxDadosLevel1: TcxGridLevel;
    cxDados: TcxGrid;
    dtsDados: TDataSource;
    cxDadosBandTbl: TcxGridDBBandedTableView;
    cxDadosMov_SeqGer: TcxGridDBBandedColumn;
    cxDadosDuplicado: TcxGridDBBandedColumn;
    cxDadosFIS_CODEMP: TcxGridDBBandedColumn;
    cxDadosFIS_ESPECIE: TcxGridDBBandedColumn;
    cxDadosFIS_NUMDOC: TcxGridDBBandedColumn;
    pnlLegenda: TPanel;
    shpDuplicados: TShape;
    lblDuplicados: TLabel;
    lblLegComVinculo: TLabel;
    Shape2: TShape;
    lblLegSemVinculo: TLabel;
    Shape1: TShape;
    cxDadosDUP_RECTNF: TcxGridDBBandedColumn;
    lblLegJaVincu: TLabel;
    Shape3: TShape;
    pnlDup: TPanel;
    memDup: TMemo;
    cxDadosFIS_TIP_FC: TcxGridDBBandedColumn;
    cxDadosFIS_FORCLI: TcxGridDBBandedColumn;
    cxDadosFIS_SERIE_: TcxGridDBBandedColumn;
    lblDocumentoVendaCancelado: TLabel;
    shpVendaCancelada: TShape;
    cxDadosFIS_HISTOR: TcxGridDBBandedColumn;
    procedure dtsDadosUpdateData(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    { verifica se dentro dos documentos informados existe algum repetido }
    function fValidaDados: boolean;
    procedure cxDadosBandTblCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure btnConfirmaClick(Sender: TObject);
    function  fPedeSenhaNotaCTESemDocumento: Boolean;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxDadosBandTblEditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure cxDadosExit(Sender: TObject);
  private
    qryConsulta: TUniQuery;
    cdsDadosBackup: TUniClientDataSet;
    FtpFrete: TTipoFrete;
    objLiberacao : TLiberacao;
    blnImpCtv: Boolean;
    strFCEVEN: string;
    strFCEDEV: string;
    strFCECOM: string;
//    FblnDocumentoDuplicado : Boolean;
    function fLocalizaDocumento(var strNomeDestinatario: string; var blnNotger: Boolean): String;
    function fRetStrTipoDocumento: String;
    function fRetStrTipoDocumentoUpCase: String;

    procedure ClientDataSet1AfterScroll(DataSet: TDataSet);
    procedure settFtpFrete(const Value: TTipoFrete);
//    procedure setAlteracoesTela(const Value: Boolean);
    { Private declarations }
  public
    FtpDocFrete: TTipoDocFrete;
//    property blnDocumentoDuplicado: Boolean write setAlteracoesTela;
    { Public declarations }
    property tpFrete:  TTipoFrete read FtpFrete write settFtpFrete;

  end;

var
  frmEntFreConGridIdentificaDocumento: TfrmEntFreConGridIdentificaDocumento;

implementation

{$R *.dfm}

uses untFuncFat;


procedure TfrmEntFreConGridIdentificaDocumento.ClientDataSet1AfterScroll(DataSet: TDataSet);
begin
  If (dtsDados.DataSet.FieldByName('DUP_RECTNF').AsString = 'S') And
     (dtsDados.DataSet.FieldByName('ENT_DUPLIC').AsString = 'S' )Then
  Begin
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('SELECT FIS_DTAENT,');
    qryConsulta.SQL.Add('       FIS_NUMDOC,');
    qryConsulta.SQL.Add('       FIS_ESPDOC,');
    qryConsulta.SQL.Add('       FIS_DTADOC,');
    qryConsulta.SQL.Add('       FIS_ACESSO');
    qryConsulta.SQL.Add('  FROM RECTNF');
    qryConsulta.SQL.Add('  LEFT JOIN CADFIS ON CADFIS.AUTOINCREM = REC_CTESEQ');
    qryConsulta.SQL.Add(' WHERE (RECTNF.REC_MOVSEQ = :MOVSEQ OR RECTNF.REC_NOTSEQ = :MOVSEQ)');
    qryConsulta.ParamByName('MOVSEQ').AsString := dtsDados.DataSet.FieldByName('MOV_GERSEQ').AsString;
    qryConsulta.Open;
    memDup.Lines.Clear;
    While Not qryConsulta.Eof Do
    Begin
      memDup.Lines.Add('CHAVE CTE: ' + qryConsulta.FieldByName('FIS_ACESSO').AsString +
             ' DATA CADASTRO: ' + qryConsulta.FieldByName('FIS_DTAENT').AsString);
      memDup.Lines.Add('DATA DOCUMENTO: ' + qryConsulta.FieldByName('FIS_DTADOC').AsString +
             ' NUMERO DOC.: ' + qryConsulta.FieldByName('FIS_NUMDOC').AsString +
             ' ESPECIE: ' + qryConsulta.FieldByName('FIS_ESPDOC').AsString);
      qryConsulta.Next;
    End;
    pnlDup.Visible := memDup.Lines.Count > 0;
  End
  Else
    pnlDup.Visible := False;
end;

procedure TfrmEntFreConGridIdentificaDocumento.cxDadosBandTblCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  var Value: string;
begin
  inherited;
  Value := (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,  cxDadosMov_SeqGer.Index]));
  if  Value <> '' Then
    ACanvas.Brush.Color := clMoneyGreen;
  Value := (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,  cxDadosDuplicado.Index]));
  if  Value = 'S' Then
  Begin
    ACanvas.Brush.Color := clRed;
    ACanvas.Font.Color := clWhite;
  End;
  If (Value = 'S') and (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,  cxDadosDUP_RECTNF.Index]) = 'S') Then
  Begin
    ACanvas.Brush.Color := clAqua;
    ACanvas.Font.Color := clBlack;
  End;
  Value := (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,  cxDadosFIS_HISTOR.Index]));
  if  Value = 'CANCELADO' Then
    ACanvas.Brush.Color := $000080FF;
end;

procedure TfrmEntFreConGridIdentificaDocumento.cxDadosBandTblEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
  var
    strTipFc: String;
    qryConsulta: TUnIQuery;
    arrSel: TConsultasArray;
begin
  inherited;
  If (Key =  '/') and (AItem = cxDadosFIS_FORCLI) Then
  Begin
    strTipFc := dtsDados.DataSet.FieldByName('FIS_TIP_FC').AsString;
    If strTipFc = '' then
    begin
      pMensagemOk('Para pesquisar é preciso definir o Tipo F/C(Fornecedor ou Cliente)');
      Key := #0;
      Exit;
    End;
    qryConsulta := fCriaQuery;
    Try
      If (AItem = cxDadosFIS_FORCLI) Then
      Begin
        If (strTipFc = 'F') And (fPesqFornecedor(conForSimples, Self, nil, nil, qryConsulta, Key, arrSel)) Then
        Begin
          If cxDadosBandTbl.DataController.DataSource.DataSet.State <> dsEdit Then
            cxDadosBandTbl.DataController.DataSource.DataSet.Edit;

          cxDadosBandTbl.DataController.DataSource.DataSet.FieldByName('FIS_FORCLI').AsString := qryConsulta.FieldByName('FOR_CODFOR').AsString;
          AEdit.EditValue := qryConsulta.FieldByName('FOR_CODFOR').AsString;

        End
        Else If (strTipFc = 'C') And (fPesqCliente(conCliSimples, Self, nil, nil, qryConsulta, Key, arrSel)) Then
        Begin
          If cxDadosBandTbl.DataController.DataSource.DataSet.State <> dsEdit Then
            cxDadosBandTbl.DataController.DataSource.DataSet.Edit;

          cxDadosBandTbl.DataController.DataSource.DataSet.FieldByName('FIS_FORCLI').AsString := qryConsulta.FieldByName('CLI_CODCLI').AsString;
          cxDadosBandTbl.DataController.DataSource.DataSet.Post;
          AEdit.EditValue := qryConsulta.FieldByName('CLI_CODCLI').AsString;

        End;
      End
    Finally
      FreeAndNil(qryConsulta);
    End;
  End;
end;

procedure TfrmEntFreConGridIdentificaDocumento.cxDadosExit(Sender: TObject);
begin
  inherited;

  If (dtsDados.DataSet.State = dsEdit) Then
    dtsDados.DataSet.Post;
end;

procedure TfrmEntFreConGridIdentificaDocumento.dtsDadosUpdateData(Sender: TObject);
  var
    strDestinatario: String;
    blnNotger: Boolean;
    strForCli: String;
begin
  inherited;
  blnNotger := False;

  dtsDados.OnUpdateData := nil;
  try
     dtsDados.DataSet.Edit;
     strForCli := dtsDados.DataSet.FieldByName('FIS_FORCLI').AsString;
     dtsDados.DataSet.FieldByName('MOV_GERSEQ').AsString := fLocalizaDocumento(strDestinatario, blnNotger);
     if dtsDados.DataSet.FieldByName('MOV_GERSEQ').AsString = '' Then
     Begin
       if fEmptyStr(dtsDados.DataSet.FieldByName('FIS_FORCLI').AsString) Then
         dtsDados.DataSet.FieldByName('FIS_FORCLI').AsString := '';
     End
     Else
     Begin
       dtsDados.DataSet.FieldByName('FIS_NUMDOC').AsString := fStrZero(dtsDados.DataSet.FieldByName('FIS_NUMDOC').AsString, fTamNumDoc);
       dtsDados.DataSet.FieldByName('NFE_DESTINATARIO').AsString := strDestinatario;
       If blnNotger Then
         dtsDados.DataSet.FieldByName('NOTGER').AsString := 'S'
     End;
     dtsDados.DataSet.Post;
     If (not fEmptyStr(dtsDados.DataSet.FieldByName('FIS_NUMDOC').AsString)) And
        (not fEmptyStr(dtsDados.DataSet.FieldByName('FIS_CODEMP').AsString)) And
        (not fEmptyStr(dtsDados.DataSet.FieldByName('FIS_ESPDOC').AsString)) And
        (not fEmptyStr(dtsDados.DataSet.FieldByName('FIS_SERIE_').AsString)) And
        (not fEmptyStr(dtsDados.DataSet.FieldByName('FIS_TIP_FC').AsString)) And
        (not fEmptyStr(strForCli)) Then
       If dtsDados.DataSet.FieldByName('MOV_GERSEQ').AsString = '' Then
         pMensagemOk('Documento não encontrado');
     fValidaDados;
  Finally
    dtsDados.OnUpdateData := dtsDadosUpdateData;
  End;
end;

function TfrmEntFreConGridIdentificaDocumento.fLocalizaDocumento(var strNomeDestinatario: string; var blnNotger: Boolean):String;
  procedure pCarregar(strTabela: String);
  Begin
    qryConsulta.SQL.Clear;

    qryConsulta.SQL.Add('SELECT '+ strTabela + '.AUTOINCREM, ');
    qryConsulta.SQL.Add('       IF('+ strTabela + '.GER_TIP_FC = "F" ,');
    qryConsulta.SQL.Add('        (SELECT FOR_NOMFOR FROM CADFOR WHERE FOR_CODFOR = '+ strTabela + '.GER_CODFOR),');
    qryConsulta.SQL.Add('        (SELECT CLI_NOMCLI FROM CADCLI WHERE CLI_CODCLI = '+ strTabela + '.GER_CODCLI)) AS NOMDES');

    qryConsulta.SQL.Add('  FROM CADFIS');
    qryConsulta.SQL.Add(' INNER JOIN '+ strTabela + ' ON '+ strTabela + '.GER_NUMDOC = FIS_NUMDOC');
    qryConsulta.SQL.Add('        AND '+ strTabela + '.GER_ESPDOC = FIS_ESPDOC');
    qryConsulta.SQL.Add('        AND '+ strTabela + '.GER_CODEMP = FIS_CODEMP');
    qryConsulta.SQL.Add('        AND IF(FIS_TIP_FC = "C", '+ strTabela + '.GER_CODCLI, '+ strTabela + '.GER_CODFOR) = FIS_FORCLI');
    qryConsulta.SQL.Add('  WHERE TRUE');
    If tpFrete = tpfSaida Then
    Begin
      If strFCEVEN <> '' Then
      Begin
         qryConsulta.SQL.Add('           AND ( '+ strTabela + '.GER_CLAFIS >= 5000');
         qryConsulta.SQL.Add('            OR LOCATE('+ strTabela + '.GER_CLAFIS,'+ QuotedStr(strFCEVEN) +')>=0 )');
      End
      Else
        qryConsulta.SQL.Add('           AND '+ strTabela + '.GER_CLAFIS >= 5000');
    End
    Else
    Begin
      If (strFCEDEV <> '') And (FtpDocFrete in [tpdfDevolucaoCompra, tpdfDevolucaoVenda]) Then
      Begin
        qryConsulta.SQL.Add('           AND ('+ strTabela + '.GER_CLAFIS < 5000');
        qryConsulta.SQL.Add('           OR (LOCATE( '+ strTabela + '.GER_CLAFIS,'+ QuotedStr(strFCEDEV) +')>=0) )');
      End
      Else If (strFCECOM <> '') And (FtpDocFrete = tpdfCompra) Then
      Begin
        qryConsulta.SQL.Add('           AND ('+ strTabela + '.GER_CLAFIS < 5000');
        qryConsulta.SQL.Add('           OR (LOCATE( '+ strTabela + '.GER_CLAFIS,'+ QuotedStr(strFCECOM) +')>=0) )');
      End
      Else
        qryConsulta.SQL.Add('           AND '+ strTabela + '.GER_CLAFIS < 5000');
    End;
    qryConsulta.SQL.Add('   AND '+ strTabela + '.GER_NUMDOC = :NUMDOC');
    qryConsulta.SQL.Add('   AND '+ strTabela + '.GER_CODEMP = :CODEMP');
    qryConsulta.SQL.Add('   AND '+ strTabela + '.GER_ESPDOC = :ESPDOC');
    qryConsulta.SQL.Add('   AND '+ strTabela + '.GER_SERIE_ = :SERIE_');
    qryConsulta.SQL.Add('   AND '+ strTabela + '.GER_TIP_FC = :TIP_FC');
    If (dtsDados.DataSet.FieldByName('FIS_TIP_FC').AsString = 'F') Then
      qryConsulta.SQL.Add('   AND '+ strTabela + '.GER_CODFOR = :FORCLI')
    Else
      qryConsulta.SQL.Add('   AND '+ strTabela + '.GER_CODCLI = :FORCLI');

    Result := '';

    qryConsulta.ParamByName('NUMDOC').Value := fStrZero(dtsDados.DataSet.FieldByName('FIS_NUMDOC').AsString, fTamNumDoc);
    qryConsulta.ParamByName('CODEMP').Value := dtsDados.DataSet.FieldByName('FIS_CODEMP').Value;
    qryConsulta.ParamByName('ESPDOC').Value := dtsDados.DataSet.FieldByName('FIS_ESPDOC').Value;
    qryConsulta.ParamByName('SERIE_').Value := dtsDados.DataSet.FieldByName('FIS_SERIE_').Value;
    qryConsulta.ParamByName('TIP_FC').Value := dtsDados.DataSet.FieldByName('FIS_TIP_FC').Value;
    qryConsulta.ParamByName('FORCLI').Value := fStrZero(dtsDados.DataSet.FieldByName('FIS_FORCLI').AsString, 8);
    strNomeDestinatario := dtsDados.DataSet.FieldByName('FIS_ESPDOC').Value;
    qryConsulta.Open;

  End;
begin

  If (not fEmptyStr(dtsDados.DataSet.FieldByName('FIS_NUMDOC').AsString)) And
     (not fEmptyStr(dtsDados.DataSet.FieldByName('FIS_CODEMP').AsString)) And
     (not fEmptyStr(dtsDados.DataSet.FieldByName('FIS_ESPDOC').AsString)) And
     (not fEmptyStr(dtsDados.DataSet.FieldByName('FIS_SERIE_').AsString)) and
     (not fEmptyStr(dtsDados.DataSet.FieldByName('FIS_TIP_FC').AsString)) And
     (not fEmptyStr(dtsDados.DataSet.FieldByName('FIS_FORCLI').AsString)) Then
  Begin
    blnNotger := False;
    pCarregar('MOVGER');
    If qryConsulta.IsEmpty Then
    Begin
      pCarregar('NOTGER');
      blnNotger := True;
    End;

    If Not qryConsulta.IsEmpty Then
    Begin
      strNomeDestinatario := qryConsulta.FieldByName('NOMDES').AsString;
      Exit(qryConsulta.FieldByName('AUTOINCREM').AsString);
    End;

  End;
end;

procedure TfrmEntFreConGridIdentificaDocumento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ModalResult = mrAbort Then
    Action := caNone;
end;

procedure TfrmEntFreConGridIdentificaDocumento.FormCreate(Sender: TObject);
begin
  inherited;
  qryConsulta:= fCriaQuery();
  objLiberacao := TLiberacao.Create;
end;

procedure TfrmEntFreConGridIdentificaDocumento.FormDestroy(Sender: TObject);
begin
  inherited;
  TUniClientDataSet(dtsDados.Dataset).AfterScroll := Nil;
  FreeAndNil(objLiberacao);
  FreeAndNil(qryConsulta);
end;

procedure TfrmEntFreConGridIdentificaDocumento.FormShow(Sender: TObject);
begin
  inherited;
  TUniClientDataSet(dtsDados.Dataset).AfterScroll := ClientDataSet1AfterScroll;
  blnImpCtv := fCfgSis('IMPCTV', varBoolean);
  strFCEVEN := fTransform(fCfgSis('FCEVEN'), 4);
  strFCEDEV := fTransform(fCfgSis('FCEDEV'), 4);
  strFCECOM := fTransform(fCfgSis('FCECOM'), 4);
end;

function TfrmEntFreConGridIdentificaDocumento.fPedeSenhaNotaCTESemDocumento: Boolean;
 var
  strTitulo   ,
  strTituloDet: String;
Begin
   strTitulo := 'DOCUMENTOS DE FRETE NÃO FORAM VINCULADOS COM AS ' + fRetStrTipoDocumentoUpCase + '.';
   strTituloDet := 'CHAVES DOS FRETES NÃO VINCULADOS COM ' + fRetStrTipoDocumentoUpCase;

  Result := True;

  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddSeparador(70);
  objLiberacao.objMsgLibera.pAddTexto(strTituloDet);
  objLiberacao.objMsgLibera.pAddSeparador(70);

  cdsDadosBackup.First;
  While not cdsDadosBackup.Eof Do
  Begin
    objLiberacao.objMsgLibera.pAddTexto(Copy(cdsDadosBackup.FieldByName('CTE_ACESSO').AsString, 1, 70));
    cdsDadosBackup.Next;
  End;

  objLiberacao.strDirAce := 'IMFRSN';
  objLiberacao.strMsgSen := strTitulo;
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.blnSempreVariavelUsuario := True;


  If Not (objLiberacao.fLibera) Then
    Result := False;
end;

function TfrmEntFreConGridIdentificaDocumento.fRetStrTipoDocumento: String;
begin
  case FtpFrete of
    tpfSaida  : exit('venda');
    tpfEntrada: exit('entrada');
  end;
end;

function TfrmEntFreConGridIdentificaDocumento.fRetStrTipoDocumentoUpCase: String;
begin
  Exit(upperCase(fRetStrTipoDocumento));
end;

function TfrmEntFreConGridIdentificaDocumento.fValidaDados: boolean;
var
  strBookMark: TBookmark;
begin
  Result := True;
  cdsDadosBackup := TUniClientDataSet.Create(nil);
  dtsDados.DataSet.DisableControls;
  Try
     TUniClientDataSet(dtsDados.Dataset).AfterScroll := nil;
     strBookMark := dtsDados.DataSet.Bookmark;
     dtsDados.DataSet.First;
     cdsDadosBackup.Data := TUniClientDataSet(dtsDados.DataSet).Data;
     while not dtsDados.DataSet.EoF do
     Begin
       If dtsDados.DataSet.FieldByName('MOV_GERSEQ').AsString <> '' Then
       Begin
         cdsDadosBackup.Filtered := False;
         cdsDadosBackup.Filter :=  'CTE_MARCAD = ' + QuotedStr('S') + ' AND MOV_GERSEQ = '+ QuotedStr(dtsDados.DataSet.FieldByName('MOV_GERSEQ').AsString);
         cdsDadosBackup.Filtered := True;
         dtsDados.DataSet.Edit;
         If cdsDadosBackup.RecordCount > 1 Then
         Begin
           Result := False;
           dtsDados.DataSet.FieldByName('ENT_DUPLIC').AsString := 'S';
         End
         Else
           dtsDados.DataSet.FieldByName('ENT_DUPLIC').AsString := 'N';

         //Verifica se o esse documento ja esta referenciado em outra nota fiscal
         qryConsulta.Sql.Clear;
         qryConsulta.SQL.Add('SELECT *');
         qryConsulta.SQL.Add('  FROM RECTNF');
         qryConsulta.SQL.Add(' WHERE (RECTNF.REC_MOVSEQ = :MOVSEQ OR RECTNF.REC_NOTSEQ = :MOVSEQ)');
         qryConsulta.ParamByName('MOVSEQ').AsString := dtsDados.DataSet.FieldByName('MOV_GERSEQ').AsString;
         qryConsulta.Open;
         If qryConsulta.RecordCount > 0 Then
         Begin
           dtsDados.DataSet.FieldByName('DUP_RECTNF').AsString := 'S';
           dtsDados.DataSet.FieldByName('ENT_DUPLIC').AsString := 'S';
         End
         Else
           dtsDados.DataSet.FieldByName('DUP_RECTNF').AsString := 'N';

         dtsDados.DataSet.Post;
       End;
       dtsDados.DataSet.Next;
     End;
  Finally
    dtsDados.DataSet.Bookmark := strBookMark;
    dtsDados.DataSet.EnableControls;
    FreeAndNil(cdsDadosBackup);
    TUniClientDataSet(dtsDados.Dataset).AfterScroll := ClientDataSet1AfterScroll;
    ClientDataSet1AfterScroll(dtsDados.DataSet);
  End
end;

procedure TfrmEntFreConGridIdentificaDocumento.settFtpFrete(
  const Value: TTipoFrete);
begin
  FtpFrete := Value;
  If FtpFrete = tpfSaida Then
    Exit;
  cxDadosBandTbl.Bands[2].Caption := 'Documento de ' + fRetStrTipoDocumento;
  Self.Caption := 'Situação dos documentos que serão importados. Digite o documento de ' + fRetStrTipoDocumento  + ' relacionado.';
  lblLegSemVinculo.Caption := 'NF-e sem vinculo com documento de ' + fRetStrTipoDocumento  + '.';
  lblLegComVinculo.Caption := 'NF-e vinculado com um documento de ' + fRetStrTipoDocumento  + '.';
  lblLegJaVincu.caption    := 'Documento de ' + fRetStrTipoDocumento  + ' vinculado em mais de um NF-e. Pórem realizada em outra importação.';
  lblDuplicados.Caption    := 'Documento de ' + fRetStrTipoDocumento  + ' vinculado em mais de um NF-e.';
  lblDocumentoVendaCancelado.Caption    := 'NF-e vinculada com documento de '+ fRetStrTipoDocumento  +' cancelado';
end;

{procedure TfrmEntFreConGridIdentificaDocumento.setAlteracoesTela(const Value: Boolean);
begin
  If Value Then
  Begin
    FblnDocumentoDuplicado := Value;
    Self.Caption  := 'Notas Fiscais já importadas ou documentos vinculados em mais de uma Nota.';
    cxDadosFIS_CODEMP.Options.Editing := False;
    cxDadosFIS_ESPECIE.Options.Editing := False;
    cxDadosFIS_NUMDOC.Options.Editing := False;
    chkMostrarTodos.Visible := False;
    pnlLegenda.Height := pnlLegenda.Height - pnlVinculoDoc.Height;
    pnlVinculoDoc.Visible := False;
    shpDuplicados.Top := 3;
    lblDuplicados.Top := 3;
  End
end;                          }

procedure TfrmEntFreConGridIdentificaDocumento.btnConfirmaClick(Sender: TObject);
 var
   arrMensag: TStringArray;
   strTitulo, strTituloDet, strLinha: String;
  procedure pImprimeDetalhe(BuscarGravado: boolean= False);
  Begin
    strLinha := stringOfChar('-', 120);
    pAddDados(arrMensag, Copy(strLinha, 1, 120));
    strLinha := strTituloDet;
    pAddDados(arrMensag, Copy(strLinha, 1, 120));
    strLinha := stringOfChar('-', 120);
    pAddDados(arrMensag, Copy(strLinha, 1, 120));
    cdsDadosBackup.First;
    While not cdsDadosBackup.Eof Do
    Begin
      strLinha := stringOfChar(' ', 120);
      Insert(cdsDadosBackup.FieldByName('CTE_ACESSO').AsString, strLinha, 0);
      Insert(cdsDadosBackup.FieldByName('NFE_ACESSO').AsString, strLinha, 46);
      Insert(cdsDadosBackup.FieldByName('FIS_CODEMP').AsString, strLinha, 91);
      Insert(cdsDadosBackup.FieldByName('FIS_ESPDOC').AsString, strLinha, 99);
      Insert(cdsDadosBackup.FieldByName('FIS_NUMDOC').AsString, strLinha, 107);
      pAddDados(arrMensag, Copy(strLinha, 1, 120));

      strLinha := stringOfChar(' ', 120);
      Insert('NUM. DOC.: ' + cdsDadosBackup.FieldByName('NFE_NUMDOC').AsString +
             ' SERIE: ' + cdsDadosBackup.FieldByName('NFE_SERIE_').AsString, strLinha, 46);
      pAddDados(arrMensag, Copy(strLinha, 1, 120));


      qryConsulta.SQL.Clear;
      qryConsulta.SQL.Add('SELECT FIS_DTAENT,');
      qryConsulta.SQL.Add('       FIS_NUMDOC,');
      qryConsulta.SQL.Add('       FIS_ESPDOC,');
      qryConsulta.SQL.Add('       FIS_DTADOC,');
      qryConsulta.SQL.Add('       FIS_ACESSO');
      qryConsulta.SQL.Add('  FROM RECTNF');
      qryConsulta.SQL.Add('  LEFT JOIN CADFIS ON CADFIS.AUTOINCREM = REC_CTESEQ');
      qryConsulta.SQL.Add(' WHERE (RECTNF.REC_MOVSEQ = :MOVSEQ OR RECTNF.REC_NOTSEQ = :MOVSEQ)');
      qryConsulta.ParamByName('MOVSEQ').AsString := cdsDadosBackup.FieldByName('MOV_GERSEQ').AsString;
      qryConsulta.Open;
      If Not QryConsulta.IsEmpty Then
      Begin
        strLinha := stringOfChar(' ', 120);
        Insert('DOCUMENTO RELACIONADO ANTERIORMENTE', strLinha, 0);
        pAddDados(arrMensag, Copy(strLinha, 1, 120));
      End;

      While Not qryConsulta.Eof Do
      Begin
        strLinha := stringOfChar(' ', 120);
        Insert('CHAVE CTE: ' + qryConsulta.FieldByName('FIS_ACESSO').AsString +
               ' DATA CADASTRO: ' + qryConsulta.FieldByName('FIS_DTAENT').AsString, strLinha, 0);
        pAddDados(arrMensag, Copy(strLinha, 1, 120));
        strLinha := stringOfChar(' ', 120);
        Insert('DATA DOCUMENTO: ' + qryConsulta.FieldByName('FIS_DTADOC').AsString +
               ' NUMERO DOC.: ' + qryConsulta.FieldByName('FIS_NUMDOC').AsString +
               ' ESPECIE: ' + qryConsulta.FieldByName('FIS_ESPDOC').AsString, strLinha, 0);
        pAddDados(arrMensag, Copy(strLinha, 1, 120));
        qryConsulta.Next;
      End;
      cdsDadosBackup.Next;
      strLinha := stringOfChar('-', 120);
      pAddDados(arrMensag, Copy(strLinha, 1, 120));
    End;
  End;
begin
  ModalResult := mrOk;
  strTitulo    := 'DOCUMENTOS(S) DE ' + fRetStrTipoDocumentoUpCase + '(S) VINCULADO COM MAIS DE UMA NOTA.';
  strTituloDet := 'CTE                                          NFE                                          EMPRESA ESPECIE DOC ' + fRetStrTipoDocumentoUpCase;
  cdsDadosBackup := TUniClientDataSet.Create(Nil);
  Try
    cdsDadosBackup.IndexFieldNames := 'NFE_ACESSO';

    cdsDadosBackup.Data := TUniClientDataSet(dtsDados.DataSet).Data;
    cdsDadosBackup.Filtered := False;
    cdsDadosBackup.Filter := 'CTE_MARCAD = ' + QuotedStr('S') + ' AND MOV_GERSEQ = ''''';
    cdsDadosBackup.Filtered := True;
    If (cdsDadosBackup.RecordCount > 0) Then
    begin
      If (fCfgsis('UTICON', varBoolean)) Then
      Begin
         pMensagemOk('Existem notas que não foram relacionadas com o documento de ' + fRetStrTipoDocumento + ', fretes não serão importados');
         Exit;
      End;
      If (Not fPedeSenhaNotaCTESemDocumento) Then
      Begin
        pMensagemOk('Existem notas que não foram relacionadas com o documento de ' + fRetStrTipoDocumento + ', fretes não serão importados');
        ModalResult := mrAbort;
        Exit;
      End;
    End;

    cdsDadosBackup.Filtered := False;
    cdsDadosBackup.Filter := 'CTE_MARCAD = ' + QuotedStr('S') + ' AND ENT_DUPLIC = ' + QuotedStr('S') + ' OR DUP_RECTNF = ' +  QuotedStr('S');
    cdsDadosBackup.Filtered := True;
    If cdsDadosBackup.RecordCount > 0 Then
    Begin

      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto(strTitulo);

      pImprimeDetalhe;

      objLiberacao.strDirAce := 'IMFRDD';
      objLiberacao.strMsgSen := strTitulo;
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      objLiberacao.blnSempreVariavelUsuario := True;


      If Not objLiberacao.fLibera Then
        ModalResult := mrAbort;

    End;
  Finally
    FreeAndNil(cdsDadosBackup)
  End
End;

end.
