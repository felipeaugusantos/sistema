unit untBaixaOrdProdIndCriarLotesAuto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, untOrdProIndustrial, untGravando,
  cxProgressBar, UniClientDataSet, Data.DB, Datasnap.DBClient,
  untFuncoesSimples, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, Uni, System.UITypes, untTSugestaoLocalizacaoFisica,
  untConsultas, untTypesSistema;

type
  TfrmBaixaOrdProdIndCriarLotesAuto = class(TfrmPaiConfirma)
    cxGridLotesDBTableView: TcxGridDBTableView;
    cxGridLotesLevel1: TcxGridLevel;
    cxGridLotes: TcxGrid;
    cxGridLotesTITULO: TcxGridDBColumn;
    dtsLotes: TDataSource;
    cxGridLotesSUBTITULO: TcxGridDBColumn;
    cxGridLotesNUMLOT: TcxGridDBColumn;
    pnlAcao: TPanel;
    pnlLegendaLotePrincipal: TPanel;
    cxGridLotesSTATUS: TcxGridDBColumn;
    cxGridLotesDTAFAB: TcxGridDBColumn;
    cxGridLotesDTAVAL: TcxGridDBColumn;
    cxGridLotesDBLOCFIS: TcxGridDBColumn;
    cxGridLotesDBQTDALO: TcxGridDBColumn;
    cdsLotes: TUniClientDataSet;
    cdsLotesCHAVE: TStringField;
    cdsLotesLOCFIS: TStringField;
    cdsLotesDTAVAL: TDateField;
    cdsLotesQTDITE: TFloatField;
    cdsLotesQTDVEN: TFloatField;
    cdsLotesENDERE: TStringField;
    cdsLotesAUTINC: TStringField;
    cdsLotesBUFVEN: TStringField;
    cdsLotesFISPIC: TStringField;
    cdsLotesEXCESS: TBooleanField;
    cdsLotesSELECE: TBooleanField;
    cdsLotesABPICK: TStringField;
    cdsLotesPICKNG: TStringField;
    cdsLotesCODITE: TStringField;
    cdsLotesAIL_IMPRES: TStringField;
    cdsLotesQTDEMB: TFloatField;
    cdsLotesDESITE: TStringField;
    cdsLotesLOCTIPO: TStringField;
    cdsLotesEMBREC: TFloatField;
    cdsLotesSEQUEN: TIntegerField;
    cdsLotesTITULO: TStringField;
    cdsLotesSUBTITULO: TStringField;
    cdsLotesIDTITULO: TIntegerField;
    cdsLotesNUMLOT: TStringField;
    cdsLotesSTATUS: TStringField;
    cdsLotesDTAFAB: TDateField;
    cdsLotesQTDALO: TFloatField;
    Label1: TLabel;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxGridLotesSTATUSGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridLotesDBTableViewCustomDrawGroupCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableCellViewInfo; var ADone: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cdsLotesBeforePost(DataSet: TDataSet);
    procedure cxGridLotesDBTableViewKeyPress(Sender: TObject; var Key: Char);
  private
    FStrNumOrd: String;
    FstrSubTitulo: String;
    FIntNumLot: Integer;
    FQryIns: TUniQuery;
    FObjSugLocFis: TSugestaoLocalizacaoFisica;
    FblnSugBoi: Boolean;
    FintIncLot: Integer;
    FBlnAlterandoLocFis: Boolean;
    function fCarregarSugestoesLotes: Boolean;
    function fExecutarProcedure(AStrCodite: String; AFltQtd: Double): Boolean;
    function fCarregarSugestoesLotesAux(pgbProgresso: TCxProgressBar): Boolean;
    function fHaItensSemMapeamento: Boolean;
    function fCalcularLocalizacoesFisicas(AStrCodite: String; AFltQtd: Double): Boolean;
    function fValidaLocalSelecionado(strLocFis: String): Boolean;
    function fGetLastIndexNumLot(AStrCodIte: String): Integer;

  public
    FobjOrdProInd: TOrdProIndustrial;
    FBlnConfirma: Boolean;
    FDtaVal: TDateTime;
  end;

var
  frmBaixaOrdProdIndCriarLotesAuto: TfrmBaixaOrdProdIndCriarLotesAuto;

implementation

{$R *.dfm}

procedure TfrmBaixaOrdProdIndCriarLotesAuto.btnConfirmaClick(Sender: TObject);
begin
  FblnConfirma := fMensagem('', 'Confirma a criação dos lotes informados?', ['&Sim', '&Não']) = 1;
  If fBlnConfirma Then
    ModalResult := mrOk;
end;

procedure TfrmBaixaOrdProdIndCriarLotesAuto.FormCreate(Sender: TObject);
begin
  inherited;
  FObjSugLocFis := TSugestaoLocalizacaoFisica.Create(opccOPI);
  FblnSugBoi := fCfgSis('SUGBOI', varBoolean);
end;

procedure TfrmBaixaOrdProdIndCriarLotesAuto.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FQryIns);
  FreeAndNil(FObjSugLocFis);
end;

function TfrmBaixaOrdprodIndCriarLotesAuto.fGetLastIndexNumLot(AStrCodIte: String): Integer;
var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  Try
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT                                        ');
    qryAux.SQL.Add('  IFNULL(MAX(                                 ');
    qryAux.SQL.Add('    SUBSTRING(                                ');
    qryAux.SQL.Add('      LOT_NUMLOT,                             ');
    qryAux.SQL.Add('      POSITION("/" IN LOT_NUMLOT) + 1,        ');
    qryAux.SQL.Add('      LENGTH(LOT_NUMLOT)                      ');
    qryAux.SQL.Add('    )                                         ');
    qryAux.SQL.Add('  ),0) + 1 AS INC_LOT                         ');
    qryAux.SQL.Add('FROM                                          ');
    qryAux.SQL.Add('  CADLOT                                      ');
    qryAux.SQL.Add('WHERE LOT_NUMLOT LIKE "' + FStrNumOrd + '/%"  ');
    qryAux.SQL.Add('  AND LOT_CODITE = "'+ AStrCodIte + '"        ');
    qryAux.SQL.Add('  AND LOT_CODEMP = "'+ VS_StrCodEmp + '"      ');

    qryAux.Open;
    Result := qryAux.FieldByName('INC_LOT').AsInteger;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TfrmBaixaOrdProdIndCriarLotesAuto.FormShow(Sender: TObject);
var
  blnCarregouSugestoes: Boolean;
begin
  inherited;
  FStrNumOrd := FormatDateTime('ddmmyy', FobjOrdProInd.objOrdemProducao.dtaDataCadastro) + '-' + FobjOrdProInd.objOrdemProducao.strCodigo;
  blnCarregouSugestoes := fCarregarSugestoesLotes;

  If Not blnCarregouSugestoes Then
  Begin
    blnFecharFormPai := True;
    FblnConfirma := False;
    Exit;
  End;

  If cdsLotes.isEmpty Then
  Begin
    blnFecharFormPai := True;
    FblnConfirma := True;
  End;

  btnConfirma.Enabled := Not (fHaItensSemMapeamento And fCfgSis('SUGBOI', varBoolean));
  pnlAcao.Visible := Not btnConfirma.Enabled;

  TFloatField(cdsLotes.FieldByName('QTDALO')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));

  cxGridLotesDBTableView.ViewData.Expand(True);
end;

function TfrmBaixaOrdProdIndCriarLotesAuto.fCarregarSugestoesLotes: Boolean;
begin
  Result := TfrmGravando.fExecutarModalA(fCarregarSugestoesLotesAux, 'Carregando sugestões de lotes...', '');
end;

procedure TfrmBaixaOrdProdIndCriarLotesAuto.cdsLotesBeforePost(
  DataSet: TDataSet);
begin
  inherited;
  If FBlnAlterandoLocFis Then
    Exit;

  DataSet.FieldByName('SUBTITULO').AsString := FstrSubTitulo;
  If DataSet.FieldByName('IDTITULO').AsInteger = 3 Then
  Begin
    Inc(FintIncLot);
    DataSet.FieldByName('NUMLOT').AsString := FStrNumOrd + '/' + IntToStr(FintIncLot);
  End;
end;

procedure TfrmBaixaOrdProdIndCriarLotesAuto.cxGridLotesDBTableViewCustomDrawGroupCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableCellViewInfo; var ADone: Boolean);
begin
  inherited;
  ACanvas.Font.Style := ACanvas.Font.Style + [fsBold];
  ACanvas.Font.Color := clBlack;

  If Pos('mapeamento', VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxGridLotesTITULO.Index])) > 0 Then
    ACanvas.Font.Color := clRed;
  If Pos('endereçamento', VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxGridLotesTITULO.Index])) > 0 Then
    ACanvas.Font.Color := clBlue
end;

function TfrmBaixaOrdProdIndCriarLotesAuto.fValidaLocalSelecionado(strLocFis : String) : Boolean;
  Var
    qryCadLoc : TUniQuery;
Begin
  Try
    qryCadLoc := fCriaQuery;
    With qryCadLoc, SQL Do
    Begin
      Close;
      Clear;

      Add(' SELECT ITE_DESITE ');
      Add(' FROM CADLOT       ');
      Add(' INNER JOIN CADITE ON ITE_CODITE = LOT_CODITE ');
      Add(' WHERE LOT_CODEMP = :CODEMP ');
      Add('   AND LOT_LOCFIS = :CODLOC ');
      Add('   AND LOT_SALDOS > 0       ');

      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('CODLOC').AsString := strLocFis;

      Open;

      Result := IsEmpty;

      if not Result Then
      Begin
        fMensagem('', 'Localização Física não permitida pois o produto ' + FieldByName('ITE_DESITE').AsString + ' esta alocado nessa localização!', ['&OK']);
      End
      Else
      Begin
        Close;
        Clear;
        Add(' SELECT *                                           ');
        Add(' FROM AGEITE I                                      ');
        Add('   INNER JOIN AGEILO L ON AIL_SEQITE = I.AUTOINCREM ');
        Add('   INNER JOIN AGEREC R ON R.AUTOINCREM = AIT_SEQGER ');
        Add(' WHERE AIL_ENDERE = "N"                             ');
        Add('   AND AIL_LOCFIS = :CODLOC                         ');
        Add('   AND ARC_CODEMP = :CODEMP                         ');

        Open;

        Result := IsEmpty;

        if not Result Then
        Begin
          fMensagem('', 'Localização Física não permitida pois já existe um produto destinado a esta localização!', ['&OK']);
        End;

      End;

      Close;
    End;
  Finally
    FreeAndNil(qryCadLoc);
  End;

End;

procedure TfrmBaixaOrdProdIndCriarLotesAuto.cxGridLotesDBTableViewKeyPress(
  Sender: TObject; var Key: Char);
Var
  qryTabela : TUniQuery;
  chrKey : Char;
  arrSel : TConsultasArray;
begin
  inherited;

  If (cxGridLotesDBLOCFIS.Focused) And fEntraCons(Key) Then
  Begin
    qryTabela := fCriaQuery;
    chrKey := '/';
    If fPesqLocFisica(Self, nil, nil, qryTabela, chrKey, arrSel, True, False, True) Then
    Begin
      FBlnAlterandoLocFis := True;
      If fValidaLocalSelecionado(qryTabela.FieldByName('LOC_CODLOC').AsString) Then
      Begin
        cdsLotes.Edit;
        cdsLotes.FieldByName('LOCFIS').AsString := qryTabela.FieldByName('LOC_CODLOC').AsString;
        cdsLotes.Post;
      End;
    End;
    FreeAndNil(qryTabela);
    FBlnAlterandoLocFis := False;
  End;
end;

procedure TfrmBaixaOrdProdIndCriarLotesAuto.cxGridLotesSTATUSGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  If SameText(AText, 'A') Then
    AText := 'Ativo';
end;

function TfrmBaixaOrdProdIndCriarLotesAuto.fCarregarSugestoesLotesAux(pgbProgresso: TCxProgressBar): Boolean;
var strFilterBackup: String;
    blnFilteredBackup: Boolean;
    fltQtd: Double;
begin
  blnFilteredBackup := False;
  Result := False;
  Try
    strFilterBackup := FobjOrdProInd.Filter;
    blnFilteredBackup := FobjOrdProInd.Filtered;

    FobjOrdProInd.Filter := 'ORD_QTDENV > 0 AND ORD_RESIDU = ''N''';
    FobjOrdProInd.Filtered := True;

    If Assigned(pgbProgresso) Then
    Begin
      pgbProgresso.Properties.Max := FobjOrdProInd.RecordCount;
      pgbProgresso.Position := 0;
    End;

    FobjOrdProInd.First;
    While Not FobjOrdProInd.Eof Do
    Begin
      If FobjOrdProInd.FieldByName('ORD_QTDENV').AsFloat <= 0 Then
      Begin
        FobjOrdProInd.Next;
        Continue;
      End;

      fltQtd := FobjOrdProInd.FieldByName('ORD_QTDENV').AsFloat;

      If FblnSugBoi Then
        Result := fExecutarProcedure(FobjOrdProInd.FieldByName('ORD_CODITE').AsString, fltQtd)
      Else
        Result := fCalcularLocalizacoesFisicas(FobjOrdProInd.FieldByName('ORD_CODITE').AsString, fltQtd);

      If Not Result Then
        Break;

      FobjOrdProInd.Next;

      If Assigned(pgbProgresso) Then
        pgbProgresso.Position := FobjOrdProInd.RecNo;
    End;

  Finally
    FobjOrdProInd.Filtered := False;
    FobjOrdProInd.Filter := strFilterBackup;
    FobjOrdProInd.Filtered := blnFilteredBackup;
  End;
end;

function TfrmBaixaOrdProdIndCriarLotesAuto.fHaItensSemMapeamento: Boolean;
begin
  Result := False;
  Try
    FobjOrdProInd.DisableControls;
    FobjOrdProInd.Filter := 'ORD_QTDENV > 0';
    FobjOrdProInd.Filtered := True;
    FobjOrdProInd.First;

    While Not FobjOrdProInd.Eof Do
    Begin
      If SameText(FobjOrdProInd.FieldByName('MAPEAD').AsString, 'N') Then
        Exit(True);

      FobjOrdProInd.Next;
    End;
  Finally
    FobjOrdProInd.Filtered := False;
    FobjOrdProInd.EnableControls;
  End;
end;

function TfrmBaixaOrdProdIndCriarLotesAuto.fExecutarProcedure(AStrCodIte: String; AFltQtd: Double): Boolean;
var
  qryProc: TUniQuery;
  fltSomaQtdAlocada: Double;
begin
  qryProc := fCriaQuery;
  FstrSubTitulo := 'Item: ' + AStrCodIte + '-' + FobjOrdProInd.FieldByName('DESITE').AsString + ' | Qtd Envasada: ' + FloatToStrF(AFltQtd, ffFixed, 12, fCfgSis('DECUNI', varInteger));
  FIntNumLot := fGetLastIndexNumLot(AStrCodIte);
  Try
    Try
      If SameText(FobjOrdProInd.FieldByName('MAPEAD').AsString, 'N') Then
      Begin
        cdsLotes.Insert;
        cdsLotesIDTITULO.AsInteger := 1;
        cdsLotesNUMLOT.AsString := '';
        cdsLotesSTATUS.AsString := '';
        cdsLotesDTAFAB.AsDateTime := fNow;
        cdsLotesDTAVAL.AsDateTime := FDtaVal;
        cdsLotesLOCFIS.AsString := '';
        cdsLotesCODITE.AsString := AStrCodIte;
        cdsLotesTITULO.AsString := 'Lotes não gerados: itens sem mapeamento de localização física:';
        cdsLotes.Post;
        Exit(True);
      End;

      {If fCfgSis('ENDBAI', varBoolean) And SameText(FobjOrdProInd.FieldByName('ITE_REAEND').AsString, 'S') Then
      Begin
        FstrSubTitulo := FstrSubTitulo + ' | Lote: A definir';

        cdsLotes.Insert;
        cdsLotesIDTITULO.AsInteger := 2;
        cdsLotesNUMLOT.AsString := '';
        cdsLotesSTATUS.AsString := '';
        cdsLotesDTAFAB.AsDateTime := fNow;
        cdsLotesDTAVAL.AsDateTime := FDtaVal;
        cdsLotesLOCFIS.AsString := '';
        cdsLotesCODITE.AsString := AStrCodIte;
        cdsLotesTITULO.AsString := 'Lotes dos itens abaixo devem ser gerados na rotina de endereçamento:';
        cdsLotes.Post;
        Exit(True);
      End;}

      fExecutaSQL('DELETE FROM PRE_RESSUPRIMENTO WHERE IDSESSAO = (SELECT CONNECTION_ID())');

      qryProc.SQL.Clear;
      qryProc.SQL.Add('CALL PGERAMAPADISTANCIALOCALIZACAOFISICA_OPI(:CODITE, :CODEMP,:QTDITE, "","", "3")');
      qryProc.ParamByName('CODITE').AsString := AStrCodIte;
      qryProc.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryProc.ParamByName('QTDITE').AsFloat := Trunc(AFltQtd);

      qryProc.ExecSQL;

      qryProc.SQL.Clear;
      qryProc.SQL.Add('SELECT                                                                                   ');
      qryProc.SQL.Add(' QUANTIDADE_MOVIMENTA/fRetM3ProdutoSaldoEmbalagemFechadaCompra(:CODITE, :CODEMP, -999) * ');
      qryProc.SQL.Add('(SELECT BAR_EMBALA FROM ITEBAR WHERE BAR_COMPRA = 1 AND BAR_CODITE = :CODITE) AS QTDMOV, ');
      qryProc.SQL.Add(' LOC_LOCDES                                                                              ');
      qryProc.SQL.Add('FROM                                                                                     ');
      qryProc.SQL.Add(' PRE_RESSUPRIMENTO                                                                       ');
      qryProc.SQL.Add('WHERE LOC_CODITE = :CODITE                                                               ');
      qryProc.SQL.Add(' AND IDSESSAO = CONNECTION_ID()                                                          ');
      qryProc.ParamByName('CODITE').AsString := AStrCodIte;
      qryProc.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryProc.Open;

      fltSomaQtdAlocada := 0;

      qryProc.Filter := 'QTDMOV > 0';
      qryProc.Filtered := True;

      qryProc.First;
      If Not qryProc.isEmpty Then
      Begin
        While fltSomaQtdAlocada < Trunc(AFltQtd) Do
        Begin
          cdsLotes.Insert;
          cdsLotesIDTITULO.AsInteger := 3;
          cdsLotesNUMLOT.AsString := FStrNumOrd + '/' + IntToStr(FintNumLot);
          cdsLotesSTATUS.AsString := 'A';
          cdsLotesDTAFAB.AsDateTime := fNow;
          cdsLotesDTAVAL.AsDateTime := FDtaVal;
          cdsLotesLOCFIS.AsString := qryProc.FieldByName('LOC_LOCDES').AsString;
          cdsLotesQTDALO.AsFloat := qryProc.FieldByName('QTDMOV').AsFloat;
          cdsLotesTITULO.AsString := 'Lotes x Localizações x Quantidade a serem criados:';
          cdsLotesCODITE.AsString := AStrCodIte;

          fltSomaQtdAlocada := fltSomaQtdAlocada + qryProc.FieldByName('QTDMOV').AsFloat;
          //Se teve resto ao final soma no ultimo lote
          If not (fltSomaQtdAlocada < Trunc(AFltQtd)) Then
            if (AFltQtd- fltSomaQtdAlocada) > 0 Then
              cdsLotesQTDALO.AsFloat := cdsLotesQTDALO.AsFloat + (AFltQtd- fltSomaQtdAlocada);
          Inc(FintNumLot);
          cdsLotes.Post;
          qryProc.Next;
        End;

      End;
      Result := True;
    Except On
      E:Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TfrmBaixaOrdProdIndCriarLotesAuto.fExecutarProcedure]');
      End;
    End;
  Finally
    FreeAndNil(qryProc);
  End;
end;

Function TFrmBaixaordProdIndCriarLotesAuto.fCalcularLocalizacoesFisicas(AStrCodIte: String; AFltQtd: Double): Boolean;
begin
  FstrSubTitulo := 'Item: ' + AStrCodIte + '-' + FobjOrdProInd.FieldByName('DESITE').AsString + ' | Qtd Envasada: ' + FloatToStrF(AFltQtd, ffFixed, 12, fCfgSis('DECUNI', varInteger));
  FintIncLot := fGetLastIndexNumLot(AStrCodIte) - 1;
  Try
    {If SameText(FobjOrdProInd.FieldByName('MAPEAD').AsString, 'N') Then
    Begin
      cdsLotes.Insert;
      cdsLotesIDTITULO.AsInteger := 1;
      cdsLotesNUMLOT.AsString := '';
      cdsLotesSTATUS.AsString := '';
      cdsLotesDTAFAB.AsDateTime := fNow;
      cdsLotesDTAVAL.AsDateTime := FDtaVal;
      cdsLotesLOCFIS.AsString := '';
      cdsLotesCODITE.AsString := AStrCodIte;
      cdsLotesTITULO.AsString := 'Lotes não gerados: itens sem mapeamento de localização física:';
      cdsLotes.Post;
      Exit(True);
    End;

    If fCfgSis('ENDBAI', varBoolean) And SameText(FobjOrdProInd.FieldByName('ITE_REAEND').AsString, 'S') Then
    Begin
      FstrSubTitulo := FstrSubTitulo + ' | Lote: A definir';
      cdsLotes.Insert;
      cdsLotesIDTITULO.AsInteger := 2;
      cdsLotesNUMLOT.AsString := '';
      cdsLotesSTATUS.AsString := '';
      cdsLotesDTAFAB.AsDateTime := fNow;
      cdsLotesDTAVAL.AsDateTime := FDtaVal;
      cdsLotesLOCFIS.AsString := '';
      cdsLotesCODITE.AsString := AStrCodIte;
      cdsLotesTITULO.AsString := 'Lotes dos itens abaixo devem ser gerados na rotina de endereçamento:';
      cdsLotes.Post;
      Exit(True);
    End;}

    FObjSugLocFis.pMontaSugestao(cdsLotes,

                                 '',
                                 AStrCodIte,
                                 FobjOrdProInd.FieldByName('DESITE').AsString,
                                 '',
                                 fCampoTabela('BAR_EMBALA', 'ITEBAR', ['BAR_CODITE', 'BAR_COMPRA'], [AStrCodIte, '1']),
                                 AFltQtd,
                                 FDtaVal);
    Result := True;
  Except On
    E:Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmBaixaOrdProdIndCriarLotesAuto.pCalcularLocalizacoesFisicas]');
    End;
  End;
End;

end.
