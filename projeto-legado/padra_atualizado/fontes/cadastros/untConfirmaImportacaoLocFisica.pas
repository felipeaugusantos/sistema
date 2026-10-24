unit untConfirmaImportacaoLocFisica;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.StdCtrls,
  Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus,
  Vcl.Buttons, BitBtnLockedIncrem, Data.DB, Uni, UniClientDataSet, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, Vcl.DBCtrls,
  cxProgressBar, System.UiTypes;

type
  TfrmConfirmaImportacaoLocFisica = class(TfrmPaiConfirma)
    pnlTopo: TPanel;
    rdgOpcoesPesquisa: TRadioGroup;
    dtsLocais: TDataSource;
    pnlBottom: TPanel;
    grpLegenda: TGroupBox;
    shpLocalComInconsistencia: TShape;
    lblProdutoComInconsistencia: TLabel;
    shpLocalOK: TShape;
    lblProdutoOk: TLabel;
    cxGLocFisicaDBTableView: TcxGridDBTableViewCitel;
    cxGLocFisicaLevel1: TcxGridLevel;
    cxGLocFisica: TcxGridCitel;
    cxGLocFisicaCODFIM: TcxGridDBColumn;
    cxGLocFisicaDESCRI: TcxGridDBColumn;
    cxGLocFisicaCRITIC: TcxGridDBColumn;
    cxGLocFisicaTRANSI: TcxGridDBColumn;
    cxGLocFisicaBALCAO: TcxGridDBColumn;
    cxGLocFisicaCAPACI: TcxGridDBColumn;
    cxGLocFisicaPONREP: TcxGridDBColumn;
    cxGLocFisicaCODLSE: TcxGridDBColumn;
    cxGLocFisicaTIPLOC: TcxGridDBColumn;
    cxGLocFisicaENDER_: TcxGridDBColumn;
    cxGLocFisicaITEPIC: TcxGridDBColumn;
    cxGLocFisicaIMPORT: TcxGridDBColumn;
    cxGLocFisicaMOTIVO: TcxGridDBColumn;
    lblTipInc: TLabel;
    mmoMotivo: TDBMemo;
    cxGLocFisicaCODAMZ: TcxGridDBColumn;
    cxGLocFisicaATIVO_: TcxGridDBColumn;
    cxGLocFisicaPDERPD: TcxGridDBColumn;
    cxGLocFisicaTXOMAX: TcxGridDBColumn;
    cxGLocFisicaPESMAX: TcxGridDBColumn;
    cxGLocFisicaLARGUR: TcxGridDBColumn;
    cxGLocFisicaALTURA: TcxGridDBColumn;
    cxGLocFisicaPROFUN: TcxGridDBColumn;
    cxGLocFisicaOBSERV: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure rdgOpcoesPesquisaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGLocFisicaDBTableViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
    procedure pFiltrarLocais(blnApenasInconsistentes: Boolean);
    function fConfirma(pgbStatus: TcxProgressBar): Boolean;
    procedure pConfiguraGrid;
  public
    { Public declarations }
    blnUsaWms,
    blnTemInconsist : Boolean;
    cdsLocFis : TUniClientDataSet;
  end;

var
  frmConfirmaImportacaoLocFisica: TfrmConfirmaImportacaoLocFisica;

implementation

uses
  untFuncoesSimples, untGravando;

{$R *.dfm}

function TfrmConfirmaImportacaoLocFisica.fConfirma(pgbStatus: TcxProgressBar): Boolean;
var
  qryAux: TUniQuery;
Begin
  Result := True;
  qryAux := fCriaQuery;

  Try
    pgbStatus.Properties.Max := cdsLocFis.RecordCount;

    cdsLocFis.DisableControls;
    cdsLocFis.First;
    While Not cdsLocFis.Eof Do
    Begin
      If cdsLocFis.FieldByName('IMPORT').AsString = 'S' Then
      Begin
        qryAux.Close;
        qryAux.SQL.Clear;
        qryAux.SQL.Add(' INSERT INTO CADLOC ( ');
        qryAux.SQL.Add('    AUTOINCREM, ');
        qryAux.SQL.Add('    LOC_CODEMP, ');
        qryAux.SQL.Add('    LOC_CODLOC, ');
        qryAux.SQL.Add('    LOC_DESCRI, ');
        qryAux.SQL.Add('    LOC_CRITIC, ');
        qryAux.SQL.Add('    LOC_TRANSI, ');
        qryAux.SQL.Add('    LOC_BALCAO, ');
        If Not fEmptyStr(cdsLocFis.FieldByName('CODLSE').AsString) Then
          qryAux.SQL.Add('    LOC_CODLSE, ');

        If blnUsaWms Then
        begin
          qryAux.SQL.Add('  LOC_ATIVO_, ');
          qryAux.SQL.Add('  LOC_R_U_A_, ');
          qryAux.SQL.Add('  LOC_PREDIO, ');
          qryAux.SQL.Add('  LOC_ANDAR_, ');
          qryAux.SQL.Add('  LOC_APARTA, ');
          qryAux.SQL.Add('  LOC_PICKIN, ');
          qryAux.SQL.Add('  LOC_PRILAB, ');
          qryAux.SQL.Add('  LOC_PDERPD, ');
          qryAux.SQL.Add('  LOC_TXOMAX, ');
          qryAux.SQL.Add('  LOC_PESMAX, ');
          qryAux.SQL.Add('  LOC_LARGUR, ');
          qryAux.SQL.Add('  LOC_ALTURA, ');
          qryAux.SQL.Add('  LOC_PROFUN, ');
          If Not fEmptyStr(cdsLocFis.FieldByName('ITEPIC').AsString) Then
            qryAux.SQL.Add('  LOC_ITEPIC, ');
          qryAux.SQL.Add('  LOC_OBSERV ');
        end
        else
        begin
          If Not fEmptyStr(cdsLocFis.FieldByName('CODAMZ').AsString) Then
            qryAux.SQL.Add('  LOC_CODAMZ, ');
          qryAux.SQL.Add('  LOC_CAPACI, ');
          qryAux.SQL.Add('  LOC_PONREP ');
        end;

        qryAux.SQL.Add(' ) VALUES ( ');
        qryAux.SQL.Add('    :AUTOIN, ');
        qryAux.SQL.Add('    :CODEMP, ');
        qryAux.SQL.Add('    :CODLOC, ');
        qryAux.SQL.Add('    :DESCRI, ');
        qryAux.SQL.Add('    :CRITIC, ');
        qryAux.SQL.Add('    :TRANSI, ');
        qryAux.SQL.Add('    :BALCAO, ');
        If Not fEmptyStr(cdsLocFis.FieldByName('CODLSE').AsString) Then
          qryAux.SQL.Add('    :CODLSE, ');

        If blnUsaWms Then
        begin
          qryAux.SQL.Add('  :ATIVO_, ');
          qryAux.SQL.Add('  :R_U_A_, ');
          qryAux.SQL.Add('  :PREDIO, ');
          qryAux.SQL.Add('  :ANDAR_, ');
          qryAux.SQL.Add('  :APARTA, ');
          qryAux.SQL.Add('  :PICKIN, ');
          qryAux.SQL.Add('  :PRILAB, ');
          qryAux.SQL.Add('  :PDERPD, ');
          qryAux.SQL.Add('  :TXOMAX, ');
          qryAux.SQL.Add('  :PESMAX, ');
          qryAux.SQL.Add('  :LARGUR, ');
          qryAux.SQL.Add('  :ALTURA, ');
          qryAux.SQL.Add('  :PROFUN, ');
          If Not fEmptyStr(cdsLocFis.FieldByName('ITEPIC').AsString) Then
            qryAux.SQL.Add('  :ITEPIC, ');
          qryAux.SQL.Add('  :OBSERV ');
        end
        else
        begin
          If Not fEmptyStr(cdsLocFis.FieldByName('CODAMZ').AsString) Then
            qryAux.SQL.Add('  :CODAMZ, ');
          qryAux.SQL.Add('  :CAPACI, ');
          qryAux.SQL.Add('  :PONREP ');
        end;
        qryAux.SQL.Add(' ) ');

        qryAux.ParamByName('AUTOIN').AsString := fRetAutoIncrem('CADLOC', VS_strCodEmp);
        qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
        qryAux.ParamByName('CODLOC').AsString := cdsLocFis.FieldByName('CODFIM').AsString;
        qryAux.ParamByName('DESCRI').AsString := cdsLocFis.FieldByName('DESCRI').AsString;
        qryAux.ParamByName('CRITIC').AsString := cdsLocFis.FieldByName('CRITIC').AsString;
        qryAux.ParamByName('TRANSI').AsString := cdsLocFis.FieldByName('TRANSI').AsString;
        qryAux.ParamByName('BALCAO').AsString := cdsLocFis.FieldByName('BALCAO').AsString;
        If Not fEmptyStr(cdsLocFis.FieldByName('CODLSE').AsString) Then
          qryAux.ParamByName('CODLSE').AsString := cdsLocFis.FieldByName('CODLSE').AsString;

        If blnUsaWms Then
        begin
          qryAux.ParamByName('ATIVO_').AsString   := cdsLocFis.FieldByName('ATIVO_').AsString;
          qryAux.ParamByName('R_U_A_').AsString   := cdsLocFis.FieldByName('R_U_A_').AsString;
          qryAux.ParamByName('PREDIO').AsString   := cdsLocFis.FieldByName('PREDIO').AsString;
          qryAux.ParamByName('ANDAR_').AsString   := cdsLocFis.FieldByName('ANDAR_').AsString;
          qryAux.ParamByName('APARTA').AsString   := cdsLocFis.FieldByName('APARTA').AsString;
          qryAux.ParamByName('PICKIN').AsString   := cdsLocFis.FieldByName('PICKIN').AsString;
          qryAux.ParamByName('PRILAB').AsString   := cdsLocFis.FieldByName('PRILAB').AsString;
          qryAux.ParamByName('PDERPD').AsString   := cdsLocFis.FieldByName('PDERPD').AsString;
          qryAux.ParamByName('TXOMAX').AsInteger  := cdsLocFis.FieldByName('TXOMAX').AsInteger;
          qryAux.ParamByName('PESMAX').AsFloat    := cdsLocFis.FieldByName('PESMAX').AsFloat;
          qryAux.ParamByName('LARGUR').AsFloat    := cdsLocFis.FieldByName('LARGUR').AsFloat;
          qryAux.ParamByName('ALTURA').AsFloat    := cdsLocFis.FieldByName('ALTURA').AsFloat;
          qryAux.ParamByName('PROFUN').AsFloat    := cdsLocFis.FieldByName('PROFUN').AsFloat;
          If Not fEmptyStr(cdsLocFis.FieldByName('ITEPIC').AsString) Then
            qryAux.ParamByName('ITEPIC').AsString   := cdsLocFis.FieldByName('ITEPIC').AsString;
          qryAux.ParamByName('OBSERV').AsString   := cdsLocFis.FieldByName('OBSERV').AsString;
        end
        else
        begin
          If Not fEmptyStr(cdsLocFis.FieldByName('CODAMZ').AsString) Then
            qryAux.ParamByName('CODAMZ').AsString   := cdsLocFis.FieldByName('CODAMZ').AsString;
          qryAux.ParamByName('CAPACI').AsFloat    := cdsLocFis.FieldByName('CAPACI').AsFloat;
          qryAux.ParamByName('PONREP').AsFloat    := cdsLocFis.FieldByName('PONREP').AsFloat;
        end;

        qryAux.ExecSql;
      End;

      cdsLocFis.Next;

      pgbStatus.Position := pgbStatus.Position + 1;

      Application.ProcessMessages;
    End;

  Finally
    cdsLocFis.First;
    cdsLocFis.EnableControls;
    FreeAndNil(qryAux);
  End;
End;

procedure TfrmConfirmaImportacaoLocFisica.btnConfirmaClick(Sender: TObject);
Var
  frmGravando : TfrmGravando;
begin
  If (blnTemInconsist) And
    (fMensagem('ATENÇÃO!', 'Ainda há inconsistências na grade. Ao confirmar, apenas os Locais sem inconsistências serão importados.' + #13#10 +
               'Deseja realmente continuar?', ['&Sim', '&Não'], 2) = 2) Then
    Exit;

  pCriarFormularios(TfrmGravando, frmGravando);
  Try
    frmGravando.fExecutarAcao := fConfirma;
    frmGravando.lblGravando.Caption := 'Aguarde... Gravando Locais...';
    frmGravando.Showmodal;

    pMensagemOk('Importação concluída com sucesso!');

    inherited;
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

procedure TfrmConfirmaImportacaoLocFisica.cxGLocFisicaDBTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  ACanvas.Font.Color := clBlack;
  If (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxGLocFisicaIMPORT.Index]) = 'C') Then
    ACanvas.Brush.Color := shpLocalComInconsistencia.Brush.Color
  Else
    ACanvas.Brush.Color := shpLocalOk.Brush.Color;

  If AViewInfo.Item.Index = cxGLocFisicaDBTableView.GetColumnByFieldName('ATIVO_').Index Then
  Begin
    ACanvas.FillRect(AViewInfo.Bounds);
    If (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxGLocFisicaATIVO_.Index]) = 'S') Then
      ACanvas.TextOut(AViewInfo.Bounds.Left + 2, AViewInfo.Bounds.Top + 2, 'Sim')
    Else If (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxGLocFisicaATIVO_.Index]) = 'N') Then
      ACanvas.TextOut(AViewInfo.Bounds.Left + 2, AViewInfo.Bounds.Top + 2, 'Não');
    ADone := True;
  End;

  If AViewInfo.Item.Index = cxGLocFisicaDBTableView.GetColumnByFieldName('CRITIC').Index Then
  Begin
    ACanvas.FillRect(AViewInfo.Bounds);
    If (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxGLocFisicaCRITIC.Index]) = 'S') Then
      ACanvas.TextOut(AViewInfo.Bounds.Left + 2, AViewInfo.Bounds.Top + 2, 'Sim')
    Else If (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxGLocFisicaCRITIC.Index]) = 'N') Then
      ACanvas.TextOut(AViewInfo.Bounds.Left + 2, AViewInfo.Bounds.Top + 2, 'Não');
    ADone := True;
  End;

  If AViewInfo.Item.Index = cxGLocFisicaDBTableView.GetColumnByFieldName('TRANSI').Index Then
  Begin
    ACanvas.FillRect(AViewInfo.Bounds);
    If (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxGLocFisicaTRANSI.Index]) = 'S') Then
      ACanvas.TextOut(AViewInfo.Bounds.Left + 2, AViewInfo.Bounds.Top + 2, 'Sim')
    Else If (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxGLocFisicaTRANSI.Index]) = 'N') Then
      ACanvas.TextOut(AViewInfo.Bounds.Left + 2, AViewInfo.Bounds.Top + 2, 'Não');
    ADone := True;
  End;

  If AViewInfo.Item.Index = cxGLocFisicaDBTableView.GetColumnByFieldName('BALCAO').Index Then
  Begin
    ACanvas.FillRect(AViewInfo.Bounds);
    If (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxGLocFisicaBALCAO.Index]) = 'S') Then
      ACanvas.TextOut(AViewInfo.Bounds.Left + 2, AViewInfo.Bounds.Top + 2, 'Sim')
    Else If (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxGLocFisicaBALCAO.Index]) = 'N') Then
      ACanvas.TextOut(AViewInfo.Bounds.Left + 2, AViewInfo.Bounds.Top + 2, 'Não');
    ADone := True;
  End;

  If AViewInfo.Item.Index = cxGLocFisicaDBTableView.GetColumnByFieldName('PDERPD').Index Then
  Begin
    ACanvas.FillRect(AViewInfo.Bounds);
    If (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxGLocFisicaPDERPD.Index]) = 'S') Then
      ACanvas.TextOut(AViewInfo.Bounds.Left + 2, AViewInfo.Bounds.Top + 2, 'Sim')
    Else If (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxGLocFisicaPDERPD.Index]) = 'N') Then
      ACanvas.TextOut(AViewInfo.Bounds.Left + 2, AViewInfo.Bounds.Top + 2, 'Não');
    ADone := True;
  End;
end;

procedure TfrmConfirmaImportacaoLocFisica.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = VK_F10) Then
    btnConfirma.Click;
end;

procedure TfrmConfirmaImportacaoLocFisica.pConfiguraGrid;
Begin
  cxGLocFisicaCODFIM.Width    := 115;
  cxGLocFisicaDESCRI.Width    := 265;
  cxGLocFisicaCRITIC.Width    := 79;
  cxGLocFisicaTRANSI.Width    := 65;
  cxGLocFisicaBALCAO.Width    := 42;
  cxGLocFisicaCAPACI.Width    := 65;
  cxGLocFisicaPONREP.Width    := 105;
  cxGLocFisicaCODLSE.Width    := 110;
  cxGLocFisicaTIPLOC.Width    := 121;
  cxGLocFisicaENDER_.Width    := 140;
  cxGLocFisicaITEPIC.Width    := 65;
  cxGLocFisicaCODAMZ.Width    := 65;
  cxGLocFisicaATIVO_.Width    := 65;
  cxGLocFisicaPDERPD.Width    := 120;
  cxGLocFisicaTXOMAX.Width    := 105;
  cxGLocFisicaPESMAX.Width    := 70;
  cxGLocFisicaLARGUR.Width    := 70;
  cxGLocFisicaALTURA.Width    := 70;
  cxGLocFisicaPROFUN.Width    := 70;
  cxGLocFisicaOBSERV.Width    := 200;

  cxGLocFisicaTRANSI.Visible  := fCfgSis('ESTTRA') = 'S';
  cxGLocFisicaBALCAO.Visible  := fCfgSis('UTCSEA') = 'C';
  cxGLocFisicaITEPIC.Visible  := fCfgSis('UTIWMS') = 'S';
  cxGLocFisicaPROFUN.Visible  := fCfgSis('UTIWMS') = 'S';
  cxGLocFisicaCODAMZ.Visible  := Not blnUsaWms;
  cxGLocFisicaCODLSE.Visible  := IIF(blnUsaWms, fCfgSis('LSEWMS') = 'S', fCfgSis('UTLSLF') = 'S');
  cxGLocFisicaATIVO_.Visible  := blnUsaWms;
  cxGLocFisicaENDER_.Visible  := blnUsaWms;
  cxGLocFisicaTIPLOC.Visible  := blnUsaWms;
  cxGLocFisicaPDERPD.Visible  := blnUsaWms;
  cxGLocFisicaTXOMAX.Visible  := blnUsaWms;
  cxGLocFisicaPESMAX.Visible  := blnUsaWms;
  cxGLocFisicaLARGUR.Visible  := blnUsaWms;
  cxGLocFisicaALTURA.Visible  := blnUsaWms;
  cxGLocFisicaOBSERV.Visible  := blnUsaWms;
End;

procedure TfrmConfirmaImportacaoLocFisica.FormShow(Sender: TObject);
begin
  inherited;

  dtsLocais.DataSet           := cdsLocFis;
  pConfiguraGrid;
end;

procedure TfrmConfirmaImportacaoLocFisica.rdgOpcoesPesquisaClick(
  Sender: TObject);
begin
  inherited;

  Case rdgOpcoesPesquisa.ItemIndex Of
    0: pFiltrarLocais(False);
    1: pFiltrarLocais(True);
  End;
end;

procedure TfrmConfirmaImportacaoLocFisica.pFiltrarLocais(blnApenasInconsistentes: Boolean);
begin
  cdsLocFis.Filter := 'IMPORT = '+QuotedStr('C');
  cdsLocFis.Filtered := blnApenasInconsistentes;
end;

end.
