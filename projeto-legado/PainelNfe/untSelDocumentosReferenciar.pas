unit untSelDocumentosReferenciar;

interface

uses
  {$IF Defined(UNIDAC)}
    Uni, UniSQLMonitor, MemDS, DBAccess,
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
    Vcl.ExtCtrls, Vcl.Grids, DBGridCitel, DBGrids, Vcl.Mask, Data.DB,
  {$ELSE}
    SysUtils, Windows, ZDataset, DB, Grids, DBGridCitel, DBGrids, StdCtrls, Mask,
    Controls, Buttons, Classes, ExtCtrls, Forms,
  {$IFEND}
  BitBtnLockedIncrem, MaskEditFocus, StrUtils, EditFocus, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxDBData, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView,
  {$IFDEF VER300}
  cxDataControllerConditionalFormattingRulesManagerDialog, cxImageList,
  {$ENDIF}
  cxGrid;

type
  TfrmSelDocumentosReferenciar = class(TForm)
    pnlBotoes: TPanel;
    btnSair: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    pnlCabecalho: TPanel;
    lblCliFor: TLabel;
    Label1: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    Label2: TLabel;
    btnFiltrar: TBitBtnLocked;
    dtsDocumentos: TDataSource;
    edtNumDoc: TEditFocus;
    edtEspDoc: TEditFocus;
    lblNumDoc: TLabel;
    lblEspDoc: TLabel;
    dbgDocumentos: TcxGrid;
    dbgDocumentosDBTableView: TcxGridDBTableView;
    FIS_NUMDOC: TcxGridDBColumn;
    FIS_ESPDOC: TcxGridDBColumn;
    FIS_CODEMP: TcxGridDBColumn;
    FIS_DTAENT: TcxGridDBColumn;
    FIS_ACESSO: TcxGridDBColumn;
    FIS_NUMSER: TcxGridDBColumn;
    FIS_NUMCOO: TcxGridDBColumn;
    dbgDocumentosLevel: TcxGridLevel;
    procedure FormActivate(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtEspDocChange(Sender: TObject);
  private
    { Private declarations }
    qryDocumentos: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    function fFiltroPorDoc:Boolean;
  public
    { Public declarations }
    strCliFor: String;
    strNomCliFor: String;
    strTipFc: String;

    strNumDoc: String;
    strEspDoc: String;
    strCodEmp: String;
    strChaAce: String;
    strNumSer: String;
    strNumCoo: String;
    strNumUsu: String;

    strAutIncMovGer: String;
    strAutIncNotGer: String;
  end;

var
  frmSelDocumentosReferenciar: TfrmSelDocumentosReferenciar;

implementation

{$R *.dfm}

uses untUtil;

procedure TfrmSelDocumentosReferenciar.btnConfirmaClick(Sender: TObject);
begin
  If qryDocumentos.IsEmpty Then
  Begin
    Exit;
  End;

  strNumDoc := qryDocumentos.FieldByName('FIS_NUMDOC').AsString;
  strEspDoc := qryDocumentos.FieldByName('FIS_ESPDOC').AsString;
  strCodEmp := qryDocumentos.FieldByName('FIS_CODEMP').AsString;
  ModalResult := mrOk;
end;

procedure TfrmSelDocumentosReferenciar.btnFiltrarClick(Sender: TObject);
begin
  If (Not fFiltroPorDoc) And
     ((fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Or
      (fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)))) Then
  Begin
    pMensagemOk('É necessário informar a data inicial e final.');
    Exit;
  End;

  qryDocumentos.Close;
  qryDocumentos.SQL.Clear;
  qryDocumentos.SQL.Add('SELECT ');
  qryDocumentos.SQL.Add('  FIS_NUMDOC, ');
  qryDocumentos.SQL.Add('  FIS_ESPDOC, ');
  qryDocumentos.SQL.Add('  FIS_CODEMP, ');
  qryDocumentos.SQL.Add('  FIS_ACESSO, ');
  qryDocumentos.SQL.Add('  FIS_NUMSER, ');
  qryDocumentos.SQL.Add('  FIS_NUMCOO, ');
  qryDocumentos.SQL.Add('  FIS_DTAENT, ');
  qryDocumentos.SQL.Add('  ECF_NUMUSU ');
  qryDocumentos.SQL.Add('FROM ');
  qryDocumentos.SQL.Add('  CADFIS ');
  qryDocumentos.SQL.Add('  JOIN MOVGER ON MOVGER.GER_NUMDOC = FIS_NUMDOC AND ');
  qryDocumentos.SQL.Add('                 MOVGER.GER_ESPDOC = FIS_ESPDOC AND ');
  qryDocumentos.SQL.Add('                 MOVGER.GER_CODEMP = FIS_CODEMP AND ');
  qryDocumentos.SQL.Add('                 IF(FIS_TIP_FC="C", MOVGER.GER_CODCLI, MOVGER.GER_CODFOR) = FIS_FORCLI AND ');
  qryDocumentos.SQL.Add('                 MOVGER.GER_TIP_FC = FIS_TIP_FC AND ');
  qryDocumentos.SQL.Add('                 IFNULL(MOVGER.GER_SERIE_, "") = IFNULL(FIS_SERIE_, "") ');
  qryDocumentos.SQL.Add('  JOIN MOVDET ON DET_NUMDOC = MOVGER.GER_NUMDOC AND ');
  qryDocumentos.SQL.Add('                 DET_ESPDOC = MOVGER.GER_ESPDOC AND ');
  qryDocumentos.SQL.Add('                 DET_CODEMP = MOVGER.GER_CODEMP AND ');
  qryDocumentos.SQL.Add('                 IFNULL(DET_CODCLI,DET_CODFOR) = IFNULL(MOVGER.GER_CODCLI,MOVGER.GER_CODFOR) AND ');
  qryDocumentos.SQL.Add('                 IFNULL(DET_SERIE_,"") = IFNULL(MOVGER.GER_SERIE_,"") ');
  qryDocumentos.SQL.Add('  LEFT JOIN CADECF ON REPLACE(FIS_NUMSER, "\0", "") = ECF_NUMSER ');
  qryDocumentos.SQL.Add('WHERE ');
  qryDocumentos.SQL.Add('  MOVGER.AUTOINCREM <> :MOVGER_DOC_ATUAL AND ');

  If Not fEmptyStr(edtNumDoc.Text) Then
    qryDocumentos.SQL.Add('  FIS_NUMDOC = :NUMDOC AND ');
  If Not fEmptyStr(edtEspDoc.Text) Then
    qryDocumentos.SQL.Add('  FIS_ESPDOC = :ESPDOC AND ');
  If Not fFiltroPorDoc Then
    qryDocumentos.SQL.Add('  FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN AND ');

  qryDocumentos.SQL.Add('  FIS_FORCLI = :FORCLI AND ');
  qryDocumentos.SQL.Add('  FIS_TIP_FC = :TIP_FC AND ');
  qryDocumentos.SQL.Add('  DET_DOCDEV IS NULL AND ');
  qryDocumentos.SQL.Add('  FIS_ESPDOC IN ("NF", "EL", "IF", "NV", "IV") ');
  qryDocumentos.SQL.Add('GROUP BY ');
  qryDocumentos.SQL.Add('  FIS_NUMDOC, FIS_ESPDOC, FIS_CODEMP, FIS_FORCLI, FIS_TIP_FC, FIS_SERIE_ ');

  qryDocumentos.SQL.Add('UNION ALL ' +
    AnsiReplaceStr(
      AnsiReplaceStr(qryDocumentos.SQL.Text, 'MOVGER', 'NOTGER'), 'MOVDET', 'NOTDET'));

  qryDocumentos.ParamByName('MOVGER_DOC_ATUAL').AsString := strAutIncMovGer;
  qryDocumentos.ParamByName('NOTGER_DOC_ATUAL').AsString := strAutIncNotGer;
  qryDocumentos.ParamByName('FORCLI').AsString := strCliFor;
  qryDocumentos.ParamByName('TIP_FC').AsString := strTipFc;

  If Not fFiltroPorDoc Then
  Begin
    qryDocumentos.ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
    qryDocumentos.ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);
    If Not fEmptyStr(edtNumDoc.Text) Then
      qryDocumentos.ParamByName('NUMDOC').Value := edtNumDoc.Text;
    If Not fEmptyStr(edtEspDoc.Text) Then
      qryDocumentos.ParamByName('ESPDOC').Value := edtEspDoc.Text;
  End
  Else
  Begin
    qryDocumentos.ParamByName('NUMDOC').Value := edtNumDoc.Text;
    qryDocumentos.ParamByName('ESPDOC').Value := edtEspDoc.Text;
  End;

  qryDocumentos.Open;
  dbgDocumentosDBTableView.ApplyBestFit;
  pSetFocus(dbgDocumentos);
end;

procedure TfrmSelDocumentosReferenciar.edtEspDocChange(Sender: TObject);
begin
  If (Not fEmptyStr(edtNumDoc.Text)) And (Not fEmptyStr(edtEspDoc.Text)) Then
  Begin
    mskDtaIni.Enabled := False;
    mskDtaFin.Enabled := False;
  End
  Else
  Begin
    mskDtaIni.Enabled := True;
    mskDtaFin.Enabled := True;
  End;
end;

function TfrmSelDocumentosReferenciar.fFiltroPorDoc: Boolean;
begin
  Result := (Not fEmptyStr(edtNumDoc.Text)) And (Not fEmptyStr(edtEspDoc.Text));
end;

procedure TfrmSelDocumentosReferenciar.FormActivate(Sender: TObject);
begin
  pSetFocus(edtNumDoc);
  mskDtaIni.Text := DateToStr(Date);
  mskDtaFin.Text := DateToStr(Date);
end;

procedure TfrmSelDocumentosReferenciar.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(qryDocumentos);
end;

procedure TfrmSelDocumentosReferenciar.FormCreate(Sender: TObject);
begin
  {$IFDEF VER300}
  dbgDocumentos.LookAndFeel.ScrollbarMode := sbmClassic;
  {$ENDIF};
  qryDocumentos := fCriaQuery(Self);
  dtsDocumentos.DataSet := qryDocumentos;
  edtNumDoc.MaxLength := fRetornaTamanhoCampo('CADFIS', 'FIS_NUMDOC');
  edtNumDoc.TamCampo  := edtNumDoc.MaxLength;
end;

procedure TfrmSelDocumentosReferenciar.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  If Key = VK_RETURN Then
  Begin
    SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmSelDocumentosReferenciar.FormShow(Sender: TObject);
begin
  lblCliFor.Caption := IIF(strTipFc='C', 'Cliente', 'Fornecedor') + ': ' + strNomCliFor;
end;

end.
