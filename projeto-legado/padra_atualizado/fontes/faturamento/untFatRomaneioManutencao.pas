unit untFatRomaneioManutencao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels, cxProgressBar,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, untZClient, Uni, untTypesSistema,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, EditFocus, untConsultas;

type
  TfrmFatRomaneioManutencao = class(TfrmPai)
    pnlFiltro: TPanel;
    pnlObservacao: TPanel;
    cxgDocumentosDBTableView: TcxGridDBTableView;
    cxgDocumentosLevel: TcxGridLevel;
    cxgDocumentos: TcxGrid;
    lblNumLot: TLabel;
    edtNumLot: TEditFocus;
    Label2: TLabel;
    Label5: TLabel;
    edtObs1: TEditFocus;
    edtObs2: TEditFocus;
    cxgDocumentosNUMLOT: TcxGridDBColumn;
    cxgDocumentosDTAENT: TcxGridDBColumn;
    cxgDocumentosHORENT: TcxGridDBColumn;
    cxgDocumentosDTENTR: TcxGridDBColumn;
    cxgDocumentosTURNO: TcxGridDBColumn;
    cxgDocumentosNUMDOC: TcxGridDBColumn;
    cxgDocumentosESPDOC: TcxGridDBColumn;
    cxgDocumentosCODEMP: TcxGridDBColumn;
    cxgDocumentosNOMCLI: TcxGridDBColumn;
    cxgDocumentosNUMFAT: TcxGridDBColumn;
    cxgDocumentosDESREG: TcxGridDBColumn;
    cxgDocumentosNOMCID: TcxGridDBColumn;
    cxgDocumentosCEPENT: TcxGridDBColumn;
    cxgDocumentosBAIENT: TcxGridDBColumn;
    cxgDocumentosENDENT: TcxGridDBColumn;
    cxgDocumentosPESBRU: TcxGridDBColumn;
    cxgDocumentosDESFPG: TcxGridDBColumn;
    cxgDocumentosNOMTRA: TcxGridDBColumn;
    cxgDocumentosVLRCON: TcxGridDBColumn;
    cxgDocumentosCODVEN: TcxGridDBColumn;
    btnTrocar: TBitBtnLocked;
    btnImprimir: TBitBtnLocked;
    btnMarTodos: TBitBtnLocked;
    btnDesmarTodos: TBitBtnLocked;
    btnDefRota: TBitBtnLocked;
    Panel2: TPanel;
    lblMarca: TLabel;
    cxgDocumentosMARDES: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure edtNumLotKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnMarTodosClick(Sender: TObject);
    procedure btnDesmarTodosClick(Sender: TObject);
    procedure cxgDocumentosCEPENTGetDataText(Sender: TcxCustomGridTableItem;
      ARecordIndex: Integer; var AText: string);
    procedure cxgDocumentosDBTableViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgDocumentosDBTableViewKeyPress(Sender: TObject; var Key: Char);
    procedure btnDefRotaClick(Sender: TObject);
    procedure btnTrocarClick(Sender: TObject);
  private
    { Private declarations }
    cdsDoc: TZClient;
    FNumLot: String;
    FblnMarcarTodos: Boolean;
    function fLoteSeparacaoRomaneioExiste(const ANumLot : String):Boolean;
    function fRetEhSQLParcial: String;
    function fRetPesoProporcional: String;
    function fFatGor: String;
    function fGetSQL: String;
    function fAbreDados(cxProgressBar: TcxProgressBar): Boolean;
    function fUltimaSequencia(const AAutInc : String):Integer;
    function fRetornaAutIncLote(const ANumLote: string): string;
    function fTrocaLote(AAutIncOri, AAutIncDes: string; AUltSeqDes: integer): Boolean;
    function fAtualizaLoteDestino(AAutIncDes: string; AUltSeqDes: integer): Boolean;
    function fAtualizaLoteOrigem(AAutIncOri: string): Boolean;
    function fAtualizaSeqOrigem(AAutIncOri: string; AarrDocumento: array of string): Boolean;
    function fExcluiLoteSemDocumento(AAutIncOri: string): Boolean;
    procedure pBuscaDocumentos;
    procedure pAfterScrollDoc(DataSet: TDataSet);
    procedure pImprimir(const ANumLote: String);
    procedure pMarcarDesmarcar(const AMarDes: String = 'M');
    procedure pInverte;
    procedure pAtualizaSequencia;
    function fVerificaOSItemReserv: Boolean;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean; override;
  end;

implementation

uses
  untGravando, untFuncoesSimples, untQckRomLoteSeparacao, untFatRomaneioLoteSeparacaoRota,
  untFatInformaLoteManutencao;

{$R *.dfm}

procedure TfrmFatRomaneioManutencao.btnDefRotaClick(Sender: TObject);
var
  LfrmFatRomaneioLoteSeparacaoRota: TfrmFatRomaneioLoteSeparacaoRota;
  intContadorAtualiza: integer;
begin
  inherited;
  If (not cdsDoc.Active) Then
    Exit;

  If (cdsDoc.IsEmpty) Then
    Exit;

  pCriarFormularios(TfrmFatRomaneioLoteSeparacaoRota, LfrmFatRomaneioLoteSeparacaoRota);

  Try
    LfrmFatRomaneioLoteSeparacaoRota.cdsRotas.CloneCursor(cdsDoc, False, True);
    TFloatField(LfrmFatRomaneioLoteSeparacaoRota.cdsRotas.FieldByName('PESBRU')).DisplayFormat := '#,##0.00';
    LfrmFatRomaneioLoteSeparacaoRota.cdsRotas.Filter := 'SEQUEN > 0';
    LfrmFatRomaneioLoteSeparacaoRota.cdsRotas.Filtered := True;
    LfrmFatRomaneioLoteSeparacaoRota.cdsRotas.IndexFieldNames := 'SEQUEN';

    LfrmFatRomaneioLoteSeparacaoRota.cdsRotas.First;
    While Not LfrmFatRomaneioLoteSeparacaoRota.cdsRotas.Eof Do
    Begin
      LfrmFatRomaneioLoteSeparacaoRota.cdsRotas.Edit;
      LfrmFatRomaneioLoteSeparacaoRota.cdsRotas.FieldByName('SEQUEN').AsInteger := LfrmFatRomaneioLoteSeparacaoRota.cdsRotas.RecNo;
      LfrmFatRomaneioLoteSeparacaoRota.cdsRotas.FieldByName('SEQORD').AsInteger := LfrmFatRomaneioLoteSeparacaoRota.cdsRotas.RecNo;
      LfrmFatRomaneioLoteSeparacaoRota.cdsRotas.Post;
      LfrmFatRomaneioLoteSeparacaoRota.cdsRotas.Next;
    End;
    LfrmFatRomaneioLoteSeparacaoRota.cdsRotas.First;

    LfrmFatRomaneioLoteSeparacaoRota.cxgDocumentosTableView.ApplyBestFit;


    LfrmFatRomaneioLoteSeparacaoRota.ShowModal;

    LfrmFatRomaneioLoteSeparacaoRota.cdsRotas.First;
    for intContadorAtualiza := 0 to LfrmFatRomaneioLoteSeparacaoRota.cdsRotas.recordcount -1 do
    begin
      if cdsDoc.locate('NOMCLI;NUMDOC;ESPDOC;CODEMP',
         VarArrayOf([LfrmFatRomaneioLoteSeparacaoRota.cdsRotas.FieldByName('NOMCLI').AsString,
                     LfrmFatRomaneioLoteSeparacaoRota.cdsRotas.FieldByName('NUMDOC').AsString,
                     LfrmFatRomaneioLoteSeparacaoRota.cdsRotas.FieldByName('ESPDOC').AsString,
                     LfrmFatRomaneioLoteSeparacaoRota.cdsRotas.FieldByName('CODEMP').AsString]),[]) then
      begin
        cdsDoc.edit;
        cdsDoc.FieldByName('SEQUEN').AsInteger := LfrmFatRomaneioLoteSeparacaoRota.cdsRotas.FieldByName('SEQUEN').AsInteger;
        cdsDoc.post;
      end;
     LfrmFatRomaneioLoteSeparacaoRota.cdsRotas.next;
    end;
     cdsDoc.IndexFieldNames := 'SEQUEN';

    pAtualizaSequencia;
  Finally

    pFreeAndNil(LfrmFatRomaneioLoteSeparacaoRota);
  End;
end;

procedure TfrmFatRomaneioManutencao.btnDesmarTodosClick(Sender: TObject);
var
  LprcScroll: TprcScroll;
begin
  inherited;
  If (not cdsDoc.Active) Then
    Exit;

  If (cdsDoc.IsEmpty) Then
    Exit;

  Try
    pDisableControls(cdsDoc, LprcScroll);
    cdsDoc.First;

    While Not cdsDoc.Eof Do
    Begin
      pMarcarDesmarcar('D');
      cdsDoc.Next;
    End;
  Finally
    cdsDoc.First;
    pEnableControls(cdsDoc, LprcScroll);
    pAfterScrollDoc(cdsDoc);
  End;

end;

procedure TfrmFatRomaneioManutencao.btnImprimirClick(Sender: TObject);
begin
  inherited;
  If (not fEmptyStr(FNumLot)) Then
   pImprimir(FNumLot);
end;

procedure TfrmFatRomaneioManutencao.btnMarTodosClick(Sender: TObject);
var
  LprcScroll: TprcScroll;
begin
  inherited;
  If (not cdsDoc.Active) Then
    Exit;

  If (cdsDoc.IsEmpty) Then
    Exit;

  Try
    FblnMarcarTodos := True;
    pDisableControls(cdsDoc, LprcScroll);
    cdsDoc.First;
    While Not cdsDoc.Eof Do
    Begin
      pMarcarDesmarcar;
      cdsDoc.Next;
    End;
  Finally
    FblnMarcarTodos := False;
    cdsDoc.First;
    pEnableControls(cdsDoc, LprcScroll);
    pAfterScrollDoc(cdsDoc);
  End;
end;

procedure TfrmFatRomaneioManutencao.btnTrocarClick(Sender: TObject);
var
  LfrmFatInformaLoteManutencao: TfrmFatInformaLoteManutencao;
  LLoteDestino: string;
  LAutIncOrigem: string;
  LAutIncDestino: string;
  LUltSeqDestino: integer;
begin
  inherited;
  If (not cdsDoc.Active) Then
    Exit;

  If (cdsDoc.IsEmpty) Then
    Exit;

  pCriarFormularios(TfrmFatInformaLoteManutencao, LfrmFatInformaLoteManutencao);

  try
    if LfrmFatInformaLoteManutencao.ShowModal = mrOk then
    begin
      LLoteDestino := LfrmFatInformaLoteManutencao.edtNumLot.Text;
      LAutIncOrigem := fRetornaAutIncLote(FNumLot);
      LAutIncDestino := fRetornaAutIncLote(LLoteDestino);
      LUltSeqDestino := fUltimaSequencia(LAutIncDestino);

      if fTrocaLote(LAutIncOrigem, LAutIncDestino, LUltSeqDestino) then
      begin
        edtNumLot.Text := LLoteDestino;
        FNumLot := LLoteDestino;
        pBuscaDocumentos;
        if (fMensagem('', 'Atualização de Lote de Separação finalizada com sucesso.'+sLineBreak+'Deseja definir a rota do lote que foi atualizado?', ['&Sim', '&Não'], 2) = 1) then
          btnDefRota.Click;

        pImprimir(FNumLot);
      end
      else
        fMensagem('ATENÇÃO', 'Ocorreu um erro e não foi possível atualizar os lotes!', ['&OK']);

    end;
  finally
    pFreeAndNil(LfrmFatInformaLoteManutencao);
  end;
end;

procedure TfrmFatRomaneioManutencao.cxgDocumentosCEPENTGetDataText(
  Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
begin
  inherited;
  If (Not fEmptyStr(AText)) Then
    AText := Copy(AText, 1, 5) + '-' + Copy(AText, 6, 3);
end;

procedure TfrmFatRomaneioManutencao.cxgDocumentosDBTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If VarToStr (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgDocumentosMARDES.Index]) = 'M' Then
  Begin
    ACanvas.Brush.Color := clBlue;
    ACanvas.Font.Color := clWhite;
  End
  Else
  Begin
    ACanvas.Brush.Color := clWhite;
    ACanvas.Font.Color := clBlack;
  End;
end;

procedure TfrmFatRomaneioManutencao.cxgDocumentosDBTableViewKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  Case Key Of
    Chr(VK_SPACE): pInverte;
  End;
end;

procedure TfrmFatRomaneioManutencao.edtNumLotKeyPress(Sender: TObject;
  var Key: Char);
var
  LqryConsulta: TUniQuery;
  LarrSel   : TConsultasArray;
begin
  inherited;

  If Key = #13 Then
  Begin
    edtNumLot.Text := fStrZero(edtNumLot.Text, 8);
    If (fValidaCampos(edtNumLot, True)) Then
    Begin
      SelectNext(ActiveControl, True, True);
      FNumLot := edtNumLot.Text;
      pBuscaDocumentos;
    End;
  End
  Else
  Begin
    LqryConsulta := fCriaQuery(Self);

    try
      If fPesqRomaneioManutencao(Self, edtNumLot, LqryConsulta, Key, LarrSel, True) Then
        If (fValidaCampos(edtNumLot, True)) Then
        Begin
          SelectNext(ActiveControl, True, True);
          FNumLot := edtNumLot.Text;
          pBuscaDocumentos;
        End;
    finally
      FreeAndNil(LqryConsulta);
    end;
  End;
end;

function TfrmFatRomaneioManutencao.fAbreDados(
  cxProgressBar: TcxProgressBar): Boolean;
begin
  pInfoStatusGravacao(cxProgressBar, 'Aguarde, Carregando documentos ...');

  if cdsDoc.Active Then
  Begin
    cdsDoc.AfterScroll := Nil;
    cdsDoc.EmptyDataSet;
  End;

  cdsDoc.qryQuery.Close;
  cdsDoc.qryQuery.SQL.Clear;
  cdsDoc.qryQuery.SQL.Add(fGetSQL);
  cdsDoc.qryQuery.ParamByName('NUMLOT').AsString := FNumLot;
  cdsDoc.qryQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;

  Result := cdsDoc.fAbreClient(True, 'TfrmFatRomaneioManutencao.edtNumLotKeyPress');

  TFloatField(cdsDoc.FieldByName('PESBRU')).DisplayFormat := '#,##0.00';
  TFloatField(cdsDoc.FieldByName('VLRCON')).DisplayFormat := '#,##0.00';

  cxgDocumentosDBTableView.ApplyBestFit();

  cdsDoc.AfterScroll := pAfterScrollDoc;
  pAfterScrollDoc(cdsDoc);

  if cdsDoc.RecordCount > 0 then
    pMarcarDesmarcar('D');

  if cdsDoc.IsEmpty then
    fMensagem('ATENÇÃO', 'Esse lote de separação não possui Pedidos faturados!', ['&OK']);
end;

function TfrmFatRomaneioManutencao.fAtualizaLoteDestino(AAutIncDes: string;
  AUltSeqDes: integer): Boolean;
var
  LprcScroll: TprcScroll;
  LqryLote: TUniQuery;
  LSelecionado: integer;
begin
  pDisableControls(cdsDoc, LprcScroll);
  LSelecionado := 0;
  LqryLote := fCriaQuery;

  try
    try
      LqryLote.Close;
      LqryLote.SQL.Clear;
      LqryLote.SQL.Add('UPDATE ROMLDE');
      LqryLote.SQL.Add('SET RLD_SEQRLG = :INCDES,');
      LqryLote.SQL.Add('RLD_SEQUEN = :SEQDES');
      LqryLote.SQL.Add('WHERE AUTOINCREM = :AUTINC');

      cdsDoc.First;

      while not cdsDoc.Eof do
      begin
        if cdsDoc.FieldByName('MARDES').AsString = 'M' then
        begin
          Inc(AUltSeqDes);
          LqryLote.Close;
          LqryLote.ParamByName('INCDES').AsString := AAutIncDes;
          LqryLote.ParamByName('SEQDES').AsInteger := AUltSeqDes;
          LqryLote.ParamByName('AUTINC').AsString := cdsDoc.FieldByName('INCLOT').AsString;
          LqryLote.ExecSQL;
          Inc(LSelecionado);
        end;
        cdsDoc.Next;
      end;

      if LSelecionado > 0 then
        Result := True
      else
      begin
        fMensagem('', 'Nenhum registro selecionado!', ['&OK']);
        Result := False;
      end;
    except
      Result := False;
    end;
  finally
    FreeAndNil(LqryLote);
    pEnableControls(cdsDoc, LprcScroll);
    pAfterScrollDoc(cdsDoc);
  end;
end;

function TfrmFatRomaneioManutencao.fAtualizaLoteOrigem(
  AAutIncOri: string): Boolean;
var
  LqryLote: TUniQuery;
  LarrDocumento: array of string;
begin
  SetLength(LarrDocumento, 0);
  LqryLote := fCriaQuery;

  try
    try
      LqryLote.Close;
      LqryLote.SQL.Clear;
      LqryLote.SQL.Add('SELECT AUTOINCREM');
      LqryLote.SQL.Add('FROM ROMLDE');
      LqryLote.SQL.Add('WHERE RLD_SEQRLG = :INCLOT');
      LqryLote.SQL.Add('ORDER BY RLD_SEQUEN');
      LqryLote.ParamByName('INCLOT').AsString := AAutIncOri;
      LqryLote.Open;

      if LqryLote.IsEmpty then
        Result := fExcluiLoteSemDocumento(AAutIncOri)
      else
      begin
        while not LqryLote.Eof do
        begin
          SetLength(LarrDocumento, Length(LarrDocumento) + 1);
          LarrDocumento[Length(LarrDocumento) - 1] := LqryLote.FieldByName('AUTOINCREM').AsString;
          LqryLote.Next;
        end;

        Result := fAtualizaSeqOrigem(AAutIncOri, LarrDocumento);
      end;
    except
      Result := False;
    end;
  finally
    FreeAndNil(LqryLote);
  end;
end;

function TfrmFatRomaneioManutencao.fAtualizaSeqOrigem(
  AAutIncOri: string; AarrDocumento: array of string): Boolean;
var
  LqryLote: TUniQuery;
  LIndice: integer;
  LSequen: integer;
begin
  LSequen := 0;
  LqryLote := fCriaQuery;

  try
    try
      LqryLote.Close;
      LqryLote.SQL.Clear;
      LqryLote.SQL.Add('UPDATE ROMLDE');
      LqryLote.SQL.Add('SET RLD_SEQUEN = :SEQUEN');
      LqryLote.SQL.Add('WHERE AUTOINCREM = :AUTINC');

      for LIndice := Low(AarrDocumento) to High(AarrDocumento) do
      begin
        Inc(LSequen);
        LqryLote.Close;
        LqryLote.ParamByName('SEQUEN').AsInteger := LSequen;
        LqryLote.ParamByName('AUTINC').AsString := AarrDocumento[LIndice];
        LqryLote.ExecSQL;
      end;

      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(LqryLote);
  end;
end;

function TfrmFatRomaneioManutencao.fExcluiLoteSemDocumento(
  AAutIncOri: string): Boolean;
var
  LqryLote: TUniQuery;
begin
  LqryLote := fCriaQuery;

  try
    try
      LqryLote.Close;
      LqryLote.SQL.Clear;
      LqryLote.SQL.Add('DELETE FROM ROMLGE');
      LqryLote.SQL.Add('WHERE AUTOINCREM = :AUTINC');
      LqryLote.ParamByName('AUTINC').AsString := AAutIncOri;
      LqryLote.ExecSQL;

      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(LqryLote);
  end;
end;

function TfrmFatRomaneioManutencao.fFatGor: String;
begin
  Result := '';

  Result := Result + ' SELECT "FATGOR" AS TABELA,     ';
  Result := Result + '        G.AUTOINCREM AS AUTINC, ';
  Result := Result + '        ROMLDE.AUTOINCREM AS INCLOT, ';
  Result := Result + '        RLG_NUMLOT AS NUMLOT,   ';
  Result := Result + '        FGO_DTAENT AS DTAENT,   ';
  Result := Result + '        FGO_HORENT AS HORENT,   ';
  Result := Result + '        FGO_DTENTR AS DTENTR,   ';
  Result := Result + '        FGO_NUMDOC AS NUMDOC,   ';
  Result := Result + '        FGO_ESPDOC AS ESPDOC,   ';
  Result := Result + '        FGO_SERIE_ AS SERIE_,   ';
  Result := Result + '        FGO_CODEMP AS CODEMP,   ';
  Result := Result + '        FGO_CODCLI AS CODCLI,   ';
  Result := Result + '        IF('+fRetEhSQLParcial+' = "*" ,'+fRetPesoProporcional+',FGO_PESBRU) AS PESBRU,   ';
  Result := Result + '        FGO_CODFPG AS CODFPG,   ';
  Result := Result + '        FGO_CODTRA AS CODTRA,   ';
  Result := Result + '        FGO_VLRCON AS VLRCON,   ';
  Result := Result + '        FGO_CODVEN AS CODVEN,   ';
  Result := Result + '        ETC_CIDENT AS CIDENT,   ';
  Result := Result + '        ETC_ENDENT AS ENDENT,   ';
  Result := Result + '        ETC_BAIENT AS BAIENT,   ';
  Result := Result + '        ETC_CODREG AS CODREG,   ';
  Result := Result + '        STA_DESCRI AS STATUS,   ';
  Result := Result + '        CAST((SELECT GROUP_CONCAT(DISTINCT CONCAT(X.DET_NUMDOC,"-",X.DET_ESPDOC)) FROM MOVDET X WHERE X.DET_NUM_PD = FGO_NUMDOC AND X.DET_ESP_PD = FGO_ESPDOC AND X.DET_EMP_PD = FGO_CODEMP) AS CHAR(255)) AS NUMFAT, ';
  Result := Result + '   (SELECT ';
  Result := Result + '      SUM(CTR_VALREC - IFNULL(CTR_VALJUR, 0) - IFNULL(CTR_VALCOB, 0) + IFNULL(CTR_VALDES, 0)) ';
  Result := Result + '    FROM ';
  Result := Result + '      CADREC ';
  Result := Result + '    WHERE ';
  Result := Result + '      CTR_NUMDUP = FGO_NUMDOC AND ';
  Result := Result + '      CTR_ESPDOC = FGO_ESPDOC AND ';
  Result := Result + '      CTR_CODEMP = FGO_CODEMP AND ';
  Result := Result + '      CTR_CODCLI = FGO_CODCLI AND ';
  Result := Result + '      CTR_DTAREC IS NOT NULL) AS VALREC, ';

  Result := Result + '   (SELECT ';
  Result := Result + '      SUM(IF(ADT_TIPLAN = "C", ADT_VALLAN, -ADT_VALLAN)) ';
  Result := Result + '    FROM ';
  Result := Result + '      ADTCLI ';
  Result := Result + '    WHERE ';
  Result := Result + '      ADT_NUMDOC = FGO_NUMDOC AND ';
  Result := Result + '      ADT_ESPDOC = FGO_ESPDOC AND ';
  Result := Result + '      ADT_CODEMP = FGO_CODEMP AND ';
  Result := Result + '      ADT_CODCLI = FGO_CODCLI) AS VALADT, ';

  Result := Result + '   (SELECT ';
  Result := Result + '     SUM( IF( COALESCE(FDO_QTDBAI, 0) = 0, FDO_TOTITE - FDO_DESESP + FDO_VALIPI + FDO_TOTFRE + FDO_VALRET + EXTDOR.FDO_VALFCP' + fSqlValorReformaFdoRef('FATDOR.AUTOINCREM') + ', ';
  Result := Result + '              ROUND( (FDO_TOTITE - FDO_DESESP + FDO_VALIPI + FDO_TOTFRE + FDO_VALRET + EXTDOR.FDO_VALFCP' + fSqlValorReformaFdoRef('FATDOR.AUTOINCREM') + ') - ';
  Result := Result + '              IFNULL( ( SELECT SUM(DET_VLRCON) ';
  Result := Result + '                        FROM   MOVDET ';
  Result := Result + '                        WHERE  DET_NUM_PD = FDO_NUMDOC ';
  Result := Result + '                        AND    DET_ESP_PD = FDO_ESPDOC ';
  Result := Result + '                        AND    DET_EMP_PD = FDO_CODEMP ';
  Result := Result + '                        AND    DET_CODITE = FDO_CODITE ';
  Result := Result + '                        AND    DET_IND_PD = FDO_SEQIND ';
  Result := Result + '                        AND    (SELECT COUNT(BRI_SEQDET) FROM BRIDET WHERE BRI_SEQDET = MOVDET.AUTOINCREM) = 0), 0), 2 ) ) ) ';
  Result := Result + '    FROM FATDOR ';
  Result := Result + '    LEFT JOIN EXTDOR ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO ';
  Result := Result + '    WHERE FDO_NUMDOC = FGO_NUMDOC ';
  Result := Result + '      AND FDO_ESPDOC = FGO_ESPDOC ';
  Result := Result + '      AND FDO_CODEMP = FGO_CODEMP ';
  Result := Result + '      AND FDO_CODCLI = FGO_CODCLI) AS CONORI, ';

  Result := Result + '      FGO_TIPOPE AS TIPOPE, ';

  If (Not fCfgSis('NPDF11', VarBoolean)) and (Not fCfgSis('NPRF11', VarBoolean)) and (Not fCfgSis('LOCRET', VarBoolean)) Then
    Result := Result + '  "N" AS ORIF11,'
  Else
  Begin
    Result := Result + ' (SELECT ';
    Result := Result + '    IF(COUNT(*) > 0, "S", "N") ';
    Result := Result + '  FROM ';
    Result := Result + '    FATDOR AS PEDORI ';
    Result := Result + '  WHERE ';
    Result := Result + '    PEDORI.FDO_NUMFAT = G.FGO_NUMDOC AND ';
    Result := Result + '    PEDORI.FDO_TIPFAT = G.FGO_ESPDOC AND ';
    Result := Result + '    PEDORI.FDO_EMPFAT = G.FGO_CODEMP) AS ORIF11, ';
  End;

  Result := Result + '  (SELECT ';
  Result := Result + '     GROUP_CONCAT(FPN_CODFPG) ';
  Result := Result + '   FROM ';
  Result := Result + '     FPGNEG ';
  Result := Result + '   WHERE ';
  Result := Result + '     FPGNEG.FPN_SEQFGO = G.AUTOINCREM) AS FPGNEG, ';
  Result := Result + '  FGO_CONPAG AS CONPAG, ';

  Result := Result + '  EXTGOR.FGO_BOLADT AS BOLADT, ';
  Result := Result + '  EXTGOR.FGO_BOLVEN AS BOLVEN, ';

  Result := Result + ' (SELECT DISTINCT IF(IFNULL(FDO_INCFUT,"N") = "N", "N", "S") ';
  Result := Result + '    FROM FATDOR FD ';
  Result := Result + '    LEFT JOIN EXTDOR ED ON FD.AUTOINCREM = ED.FDO_SEQFDO ';
  Result := Result + '   WHERE FD.FDO_SEQGER = G.AUTOINCREM) AS BENFUT, ';

  Result := Result + ' RLD_SEQUEN AS SEQUEN, ';
  Result := Result + ' "D" AS MARDES, ';
  Result := Result + ' RLD_SEPIMP AS SEPIMP, ';

  Result := Result + ' EXTDOR.FDO_TURENT AS TURNO, ';
  Result := Result + ' ETC_CEPENT AS CEPENT ';

  Result := Result + ' FROM FATGOR G              ';
  Result := Result + '   LEFT JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = G.AUTOINCREM ';
  Result := Result + '   LEFT JOIN FATDOR ON FATDOR.FDO_SEQGER = G.AUTOINCREM AND FATDOR.FDO_ORDPRO IS NULL ';
  Result := Result + '   LEFT JOIN EXTDOR ON EXTDOR.FDO_SEQFDO = FATDOR.AUTOINCREM ';
  Result := Result + '   LEFT JOIN AUXGOR ON AUX_SEQGER = G.AUTOINCREM ';
  Result := Result + '   LEFT JOIN ENTCLI ON ETC_CODCLI = FGO_CODCLI AND      ';
  Result := Result + '         IF(IFNULL(AUX_ENTGER,"") <> "", ENTCLI.AUTOINCREM = AUX_ENTGER, ';
  Result := Result + '         ETC_SEQIND = (SELECT MIN(ETC_SEQIND) FROM ENTCLI WHERE ETC_CODCLI = FGO_CODCLI)) ';
  Result := Result + '   LEFT JOIN FGOSTA S ON FGO_STATUS = S.STA_CODIGO  ';
end;

function TfrmFatRomaneioManutencao.fGetSQL: String;
begin
  Result := '';
  Result := Result + ' SELECT DISTINCT  ';
  Result := Result + '        TABELA,   ';
  Result := Result + '        AUTINC,   ';
  Result := Result + '        INCLOT,   ';
  Result := Result + '        NUMLOT,   ';
  Result := Result + '        DTAENT,   ';
  Result := Result + '        HORENT,   ';
  Result := Result + '        DTENTR,   ';
  Result := Result + '        NUMDOC,   ';
  Result := Result + '        ESPDOC,   ';
  Result := Result + '        SERIE_,   ';
  Result := Result + '        CODEMP,   ';
  Result := Result + '        CODCLI,   ';
  Result := Result + '        PESBRU,   ';
  Result := Result + '        CODFPG,   ';
  Result := Result + '        CODTRA,   ';
  Result := Result + '        VLRCON,   ';
  Result := Result + '        CODVEN,   ';
  Result := Result + '        CIDENT,   ';
  Result := Result + '        ENDENT,   ';
  Result := Result + '        BAIENT,   ';
  Result := Result + '        CODREG,   ';
  Result := Result + '        STATUS,   ';
  Result := Result + '        SEQUEN,   ';
  Result := Result + '        MARDES,   ';
  Result := Result + '        SEPIMP,   ';
  Result := Result + '        SEQUEN AS SEQORD,   ';
  Result := Result + '        IF(SEQUEN > 0, 0, 1) AS SEQINI, ';
  Result := Result + '        CLI_NOMCLI AS NOMCLI, ';
  Result := Result + '        CID_NOMCID AS NOMCID, ';
  Result := Result + '        FPG_DESCRI AS DESFPG, ';
  Result := Result + '        REG_DESREG AS DESREG, ';
  Result := Result + '        TRA_NOMTRA AS NOMTRA, ';
  Result := Result + '        VLRCON,               ';
  Result := Result + '        VALREC,               ';
  Result := Result + '        VALADT,               ';
  Result := Result + '        CONORI,               ';
  Result := Result + '        TIPOPE,               ';
  Result := Result + '        ORIF11,               ';
  Result := Result + '        FPGNEG,               ';
  Result := Result + '        CONPAG,               ';
  Result := Result + '        BOLADT,               ';
  Result := Result + '        BOLVEN,               ';
  Result := Result + '        BENFUT,               ';
  Result := Result + '        TURNO,                ';
  Result := Result + '        CEPENT,               ';
  Result := Result + '        NUMFAT                ';

  Result := Result + ' FROM ( ';

  Result := Result + fFatGor;
  Result := Result + ' INNER JOIN ROMLDE ON RLD_NUMDOC = FGO_NUMDOC        ';
  Result := Result + '                  AND RLD_ESPDOC = FGO_ESPDOC        ';
  Result := Result + '                  AND RLD_SERIE_ = FGO_SERIE_        ';
  Result := Result + '                  AND RLD_CODEMP = FGO_CODEMP        ';
  Result := Result + ' INNER JOIN ROMLGE ON ROMLGE.AUTOINCREM = RLD_SEQRLG ';
  Result := Result + ' WHERE RLG_NUMLOT = :NUMLOT                          ';
  Result := Result + '   AND RLG_CODEMP = :CODEMP                          ';
  Result := Result + '   AND FDO_JAFATU = 1                                ';

  Result := Result + ' ) AS DOCUMENTOS ';
  Result := Result + ' LEFT JOIN CADCID ON CID_CODCID = CIDENT ';
  Result := Result + ' LEFT JOIN CADREG ON REG_CODREG = CODREG ';
  Result := Result + ' LEFT JOIN CADCLI ON CLI_CODCLI = CODCLI ';
  Result := Result + ' LEFT JOIN CADFPG ON FPG_CODIGO = CODFPG ';
  Result := Result + ' LEFT JOIN CADTRA ON TRA_CODTRA = CODTRA ';
  Result := Result + ' GROUP BY CONCAT(TABELA, AUTINC)         ';
  Result := Result + ' ORDER BY SEQINI, SEQORD, NUMDOC         ';

end;

function TfrmFatRomaneioManutencao.fLoteSeparacaoRomaneioExiste(
  const ANumLot : String): Boolean;
var
  LqryLote: TUniQuery;
begin
  LqryLote := fCriaQuery;

  try
    try
      LqryLote.Close;
      LqryLote.SQL.Clear;
      LqryLote.SQL.Add('SELECT *');
      LqryLote.SQL.Add('FROM ROMLGE');
      LqryLote.SQL.Add('WHERE RLG_NUMLOT = :NUMLOT');
      LqryLote.SQL.Add('AND RLG_CODEMP = :CODEMP');

      LqryLote.ParamByName('NUMLOT').AsString := ANumLot;
      LqryLote.ParamByName('CODEMP').AsString := VS_strCodEmp;

      LqryLote.Open;

      Result := not LqryLote.IsEmpty;
    except
      Result := False;
    end;
  finally
    FreeAndNil(LqryLote);
  end;
end;

procedure TfrmFatRomaneioManutencao.FormCreate(Sender: TObject);
begin
  inherited;
  FNumLot := EmptyStr;
  FblnMarcarTodos := False;
  cdsDoc := TZClient.Create(Self);
  cxgDocumentosDBTableView.DataController.DataSource := cdsDoc.dtsSource;
end;

procedure TfrmFatRomaneioManutencao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case key of
    VK_F5: btnTrocar.Click;
    VK_F6: btnImprimir.Click;
    VK_F7: btnMarTodos.Click;
    VK_F8: btnDesmarTodos.Click;
    VK_F9: btnDefRota.Click;
  end;
end;

procedure TfrmFatRomaneioManutencao.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtNumLot);
end;

function TfrmFatRomaneioManutencao.fRetEhSQLParcial: String;
begin
  Result := ' (SELECT IF((SUM(Y.FDO_QTDBAI)>0) AND (SUM(Y.FDO_QTDBAI)<SUM(Y.FDO_QTDITE)),"*","") FROM FATDOR Y WHERE Y.FDO_SEQGER = G.AUTOINCREM) ';
end;

function TfrmFatRomaneioManutencao.fRetornaAutIncLote(
  const ANumLote: string): string;
var
  LqryLote: TUniQuery;
begin
  Result := EmptyStr;
  LqryLote := fCriaQuery;

  try
    LqryLote.Close;
    LqryLote.SQL.Clear;
    LqryLote.SQL.Add('SELECT AUTOINCREM');
    LqryLote.SQL.Add('FROM ROMLGE');
    LqryLote.SQL.Add('WHERE RLG_NUMLOT = :NUMLOT');
    LqryLote.SQL.Add('AND RLG_CODEMP = :CODEMP');
    LqryLote.ParamByName('NUMLOT').AsString := ANumLote;
    LqryLote.ParamByName('CODEMP').AsString := VS_strCodEmp;
    LqryLote.Open;

    if not LqryLote.IsEmpty then
      Result := LqryLote.FieldByName('AUTOINCREM').AsString;
  finally
    FreeAndNil(LqryLote);
  end;
end;

function TfrmFatRomaneioManutencao.fRetPesoProporcional: String;
begin
  Result := ' (SELECT SUM( ROUND( (Y.FDO_TOTPES / Y.FDO_QTDITE) * IF( (Y.FDO_QTDBAI > 0) AND (Y.FDO_QTDBAI < Y.FDO_QTDITE), (Y.FDO_QTDITE - Y.FDO_QTDBAI), Y.FDO_QTDITE), 2 )) '+
            '    FROM FATDOR Y WHERE Y.FDO_SEQGER = G.AUTOINCREM AND Y.FDO_JAFATU = 0) ';
end;

function TfrmFatRomaneioManutencao.fTrocaLote(AAutIncOri, AAutIncDes: string;
  AUltSeqDes: integer): Boolean;
begin
  fStartTransaction;

  try
    Result := fAtualizaLoteDestino(AAutIncDes, AUltSeqDes);

    if Result then
      Result := fAtualizaLoteOrigem(AAutIncOri);

    if Result then
      Result := fCommit
    else
      fRollBack;
  except
    begin
      fRollBack;
      Result := False;
    end;
  end;
end;

function TfrmFatRomaneioManutencao.fUltimaSequencia(
  const AAutInc: String): Integer;
var
  LqryDados : TUniQuery;
begin
  Result := -1;
  LqryDados := fCriaQuery(Self);
  Try
    LqryDados.Close;
    LqryDados.SQL.Clear;
    LqryDados.SQL.Add(' SELECT MAX(RLD_SEQUEN) AS SEQUEN');
    LqryDados.SQL.Add(' FROM ROMLDE');
    LqryDados.SQL.Add(' WHERE RLD_SEQRLG = :AUTINC');

    LqryDados.ParamByName('AUTINC').AsString := AAutInc;

    LqryDados.Open;

    if not LqryDados.IsEmpty then
      Result := LqryDados.FieldByName('SEQUEN').AsInteger;
  Finally
    FreeAndNil(LqryDados);
  End;

end;

function TfrmFatRomaneioManutencao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtNumLot) Then
  Begin
    If (Not fEmptyStr(edtNumLot.Text)) Then
    Begin
      If (Not fLoteSeparacaoRomaneioExiste(edtNumLot.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse lote de separação para romaneio não está cadastrado!', ['&Ok']);
        Result := False;
        edtNumLot.Clear;
        FNumLot := EmptyStr;
      End;
    End
    Else
    Begin
      fMensagem('ATENÇÃO!', 'Informe o número do lote!', ['&Ok']);
      Result := False;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmFatRomaneioManutencao.fVerificaOSItemReserv: Boolean;
var
  strNumOse  : String;
  intCont    : Integer;
  stlItensOS : TStringList;
  arrMensagem: TStringArray;
begin
  Result := False;

  if fCfgSis('OPCROM') <> '1' then
    Exit;

  stlItensOS := TStringList.Create;

  try
    if (fOSItensNaoReservados(cdsDoc.FieldByName('NUMDOC').AsString,
                              cdsDoc.FieldByName('ESPDOC').AsString,
                              cdsDoc.FieldByName('CODEMP').AsString,
                              '',
                              strNumOse,
                              stlItensOS)) then
    begin
      Result := True;

      if FblnMarcarTodos then
        Exit;

      SetLength(arrMensagem, 0);

      pAddDados(arrMensagem, fPadR('|Cód.Item|Descrição', 57) + '|');
      pAddDados(arrMensagem, fPadR('-', 58, '-'));

      for intCont := 0 to Pred(stlItensOS.Count) do
      begin
        pAddDados(arrMensagem, '|' + fPadR(Copy(stlItensOS[intCont], 1, 56), 56) + '|');
      end;

      fMensagemTabela('ATENÇÃO!',
                      'Produtos',
                      arrMensagem,
                      'Não é permitido entregar o pedido ' + cdsDoc.FieldByName('NUMDOC').AsString + '-' + cdsDoc.FieldByName('ESPDOC').AsString + '-' +
                        cdsDoc.FieldByName('CODEMP').AsString + ' pois ele possui produtos que não estão reservando estoque (OS).' + #13 +
                        'OS: ' + strNumOse + #13 +
                        'Acesse a rotina "Liberação de Reserva de Estoque Itens de Pedido de Venda - OS", ' +
                        'realize a liberação da reserva do estoque e depois, tente novamente.',
                      ['&Ok'],
                      1,
                      False,
                      1,
                      0,
                      False,
                      0,
                      False,
                      False,
                      False,
                      400,
                      100);
    end;
  finally
    FreeAndNil(stlItensOS);
  end;
end;

procedure TfrmFatRomaneioManutencao.pAfterScrollDoc(DataSet: TDataSet);
var
  LqryObs: TUniQuery;
begin
  LqryObs := fCriaQuery;

  try
    LqryObs.Close;
    LqryObs.SQL.Clear;
    LqryObs.SQL.Add('SELECT OBS_OBSER1, OBS_OBSER2');
    LqryObs.SQL.Add('FROM LROOBS');
    LqryObs.SQL.Add('WHERE OBS_NUMDOC = :NUMDOC');
    LqryObs.SQL.Add('AND OBS_ESPDOC = :ESPDOC');
    LqryObs.SQL.Add('AND OBS_CODEMP = :CODEMP');
    LqryObs.SQL.Add('AND OBS_SERIE_ = :SERIE_');
    LqryObs.SQL.Add('AND OBS_CODCLI = :CODCLI');

    LqryObs.ParamByName('NUMDOC').AsString := DataSet.FieldByName('NUMDOC').AsString;
    LqryObs.ParamByName('ESPDOC').AsString := DataSet.FieldByName('ESPDOC').AsString;
    LqryObs.ParamByName('CODEMP').AsString := DataSet.FieldByName('CODEMP').AsString;
    LqryObs.ParamByName('CODCLI').AsString := DataSet.FieldByName('CODCLI').AsString;

    If DataSet.FieldByName('SERIE_').isNull Then
      LqryObs.ParamByName('SERIE_').Value := Null
    Else
      LqryObs.ParamByName('SERIE_').AsString := DataSet.FieldByName('SERIE_').AsString;

    LqryObs.Open;

    edtObs1.Text := EmptyStr;
    edtObs2.Text := EmptyStr;

    If (Not LqryObs.IsEmpty) Then
    Begin
      edtObs1.Text := LqryObs.FieldbyName('OBS_OBSER1').AsString;
      edtObs2.Text := LqryObs.FieldbyName('OBS_OBSER2').AsString;
    End;
  finally
    FreeAndNil(LqryObs);
  end;
end;

procedure TfrmFatRomaneioManutencao.pAtualizaSequencia;
var
  LprcScroll: TprcScroll;
  LqrySeq: TUniQuery;
begin
  pDisableControls(cdsDoc, LprcScroll);
  LqrySeq := fCriaQuery;
  fStartTransaction;

  try
    try
      LqrySeq.Close;
      LqrySeq.SQL.Clear;
      LqrySeq.SQL.Add('UPDATE ROMLDE');
      LqrySeq.SQL.Add('SET RLD_SEQUEN = :SEQUEN');
      LqrySeq.SQL.Add('WHERE AUTOINCREM = :AUTINC');

      cdsDoc.First;
      while not cdsDoc.Eof do
      begin
        LqrySeq.Close;
        LqrySeq.ParamByName('SEQUEN').AsInteger := cdsDoc.FieldByName('SEQUEN').AsInteger;
        LqrySeq.ParamByName('AUTINC').AsString := cdsDoc.FieldByName('INCLOT').AsString;
        LqrySeq.ExecSQL;
        cdsDoc.Next;
      end;

      fCommit;
    except
      fRollBack;
    end;
  finally
    FreeAndNil(LqrySeq);
    pEnableControls(cdsDoc, LprcScroll);
    pAfterScrollDoc(cdsDoc);
  end;
end;

procedure TfrmFatRomaneioManutencao.pBuscaDocumentos;
begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fAbreDados;
    frmGravando.ShowModal;
    if frmGravando.blnConfirma Then
      pSetFocus(cxgDocumentos)
    Else
      SelectFirst;
  Finally
    FreeAndNil(frmGravando);
  End;
end;

procedure TfrmFatRomaneioManutencao.pImprimir(const ANumLote: String);
begin
  If fMensagem('', 'Selecione o modelo desejado', ['&Separação', '&Conferência'], 1) = 1 Then
    pImprimeRomaneioLoteSeparacao(modSeparacao,   ANumLote, VS_strCodEmp, True)
  Else
    pImprimeRomaneioLoteSeparacao(modConferencia, ANumLote, VS_strCodEmp, True);
end;


procedure TfrmFatRomaneioManutencao.pInverte;
begin
  If (not cdsDoc.Active) Then
    Exit;

  If (cdsDoc.IsEmpty) Then
    Exit;

  If cdsDoc.FieldByName('MARDES').AsString = 'D' Then
  Begin
    pMarcarDesmarcar;
  End
  Else
  Begin
    pMarcarDesmarcar('D');
  End;
end;

procedure TfrmFatRomaneioManutencao.pMarcarDesmarcar(const AMarDes: String);
begin
  If (not cdsDoc.Active) Then
    Exit;

  If (cdsDoc.IsEmpty) Then
    Exit;

  if (AMarDes = 'M') and fVerificaOSItemReserv then
    Exit;

  cdsDoc.Edit;
  cdsDoc.FieldByName('MARDES').AsString  := AMarDes;
  cdsDoc.Post;
end;

end.
