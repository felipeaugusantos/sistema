unit untRelCtpLogAcompDuplic;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Mask, MaskEditFocus, StdCtrls, EditFocus, AppEvnts, Menus,
  Buttons, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  UniDataSetProvider,   Uni, BitBtnLockedIncrem, cxGrid, UniClientDataSet, StrUtils,
  cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, frxClass, frxExportCSVTestabilidade, System.UITypes,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxContainer,
  Vcl.ComCtrls, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, cxCurrencyEdit, cxprogressbar, untGravando;

type
  TfrmRelCtpLogAcompDuplic = class(TfrmPai)
    pnlHeader: TPanel;
    Label12: TLabel;
    Label1: TLabel;
    Label27: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    edtCodFornecedor: TEditFocus;
    edtNomFornecedor: TEditFocus;
    edtNumDoc: TEditFocus;
    edtParcel: TEditFocus;
    dbgConsultaDBTableView1: TcxGridDBTableView;
    dbgConsultaLevel1: TcxGridLevel;
    dbgConsulta: TcxGrid;
    dbgConsultaDBTableView1CTP_NUMDUP: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_PARCEL: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_SEQBAI: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_CODCLI: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_CODEMP: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_CODVEN: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_CODPOR: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_DTACAD: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_DTAVEN: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_VALDUP: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_VALORI: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_HIST01: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_HIST02: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_PORBAI: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_HISBAI: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_CTABAI: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_OPEBAI: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_DTAPAG: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_VALPAG: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_VALJUR: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_VALDES: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_BCOENV: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_DTAENV: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_CODEVE: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_DTALOG: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_HORLOG: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_DESCRI: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_NOMFRM: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_CODCTA: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_OPELOG: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_EMPBAI: TcxGridDBColumn;
    cxsrConsulta: TcxStyleRepository;
    dbgConsultaDBTableView1Duplicata: TcxGridDBColumn;
    Label2: TLabel;
    edtSerie: TEditFocus;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    dbgConsultaDBTableView1Column1: TcxGridDBColumn;
    btnConsultar: TBitBtnLocked;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    mskDtaFinVen: TcxDateEdit;
    mskDtaIniVen: TcxDateEdit;
    dbgConsultaDBTableView1CTP_VEIOBO: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_VEIONF: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_PREVIS: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_USACHQ: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_PAGANT: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_DEPOSI: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_USOCON: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_OUTENT: TcxGridDBColumn;
    btnAcompLogCtpDet: TBitBtnLocked;
    Label10: TLabel;
    edtCodOpe: TEditFocus;
    edtNomeOpe: TEditFocus;
    gpbRegcomAlteracao: TGroupBox;
    Label11: TLabel;
    chkRegComAlteracao: TCheckBox;
    cmbInfRegAlterado: TComboBox;
    btnGeraCSV: TBitBtnLocked;
    lblCampoAlterados2: TLabel;
    Shp_inferior: TShape;
    GroupBox1: TGroupBox;
    Shape1: TShape;
    Label13: TLabel;
    dbgConsultaDBTableView1Alteracoes: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_NOMEXE: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_DTAEXE: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_HOREXE: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_VEREXE: TcxGridDBColumn;
    procedure edtCodFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbgConsultaDBTableView1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure dbgConsultaDBTableView1CustomDrawGroupCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableCellViewInfo; var ADone: Boolean);
    procedure btnConsultarClick(Sender: TObject);
    procedure ApplicationEventsMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure dbgConsultaDBTableView1CTP_VEIOBOGetDataText(
      Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
    procedure dbgConsultaDBTableView1CTP_VEIONFGetDataText(
      Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
    procedure dbgConsultaDBTableView1CTP_PREVISGetDataText(
      Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
    procedure dbgConsultaDBTableView1CTP_USACHQGetDataText(
      Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
    procedure dbgConsultaDBTableView1CTP_PAGANTGetDataText(
      Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
    procedure dbgConsultaDBTableView1CTP_DEPOSIGetDataText(
      Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
    procedure dbgConsultaDBTableView1CTP_USOCONGetDataText(
      Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
    procedure btnAcompLogCtpDetClick(Sender: TObject);
    procedure edtCodOpeKeyPress(Sender: TObject; var Key: Char);
    procedure edtNumDocExit(Sender: TObject);
    procedure chkRegComAlteracaoClick(Sender: TObject);
    procedure btnGeraCSVClick(Sender: TObject);
  private
    { Private declarations }
    intCor     : Integer;

    cdsConsulta: TUniClientDataSet;
    dtsConsulta: TDataSource;

    procedure pFechaConsulta;
    procedure pSetFilterDefault;
    function MascaraValor(cxProgress: TcxProgressBar = Nil): Boolean;
    function fGetSql: String;
    function fAbreConsulta(cxProgress: TcxProgressBar = Nil): Boolean;
    function fSetParametros(var ADataset: TUniQuery): Boolean;
    function DefineAlteracoes(cxProgress: TcxProgressBar = Nil): Boolean;
    function fRetornaListaRegAntesAlteracao(cdsGen: TDataSet): String;
    procedure pStep(pgbStatus: TcxProgressBar);
    function MouseShowCursor(const Show: boolean): boolean;
    function fGeraCSV(cxProgress: TcxProgressBar): Boolean;
    procedure pVerificaAplicaFiltroRegComAlteracao;
    procedure VerificaSeTemRegistros;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;


implementation

uses untTypesSistema, untIFuncoes, untClassPanelCx, untFuncoesSimples, untConsultas,
  untFuncoesRel, untFuncoesRel2;

{$R *.dfm}

procedure TfrmRelCtpLogAcompDuplic.ApplicationEventsMessage(var Msg: tagMSG;
  var Handled: Boolean);
begin
  inherited;

  Case Msg.Message Of
    WM_KEYDOWN:
    Begin
      If (Msg.wParam = VK_TAB) Then
        Msg.wParam :=  VK_RETURN;
    End;
  End;

end;

procedure TfrmRelCtpLogAcompDuplic.btnAcompLogCtpDetClick(Sender: TObject);
begin
  inherited;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(79, 5356, [],
                        ['NUMDUP','PARCEL','SERIE','CODFOR','EMPORI','VALDUP'],
                        [edtNumDoc.Text,
                        edtParcel.Text,
                        edtSerie.Text,
                        edtCodFornecedor.Text,
                        VS_strCodEmp,
                        cdsConsulta.FieldByName('CTP_VALORI').AsString],
                        Sender,
                        nil,
                        True);
  End;

end;

procedure TfrmRelCtpLogAcompDuplic.btnConsultarClick(Sender: TObject);
  Var
    frmAguarde: TfrmGravando;
begin
  If Not fValidaCampos(mskDtaIni, true) then
     exit;

  If Not fValidaCampos(mskDtaFin, true) then
     exit;

  If Not fValidaCampos(mskDtaIniVen, true) then
     exit;

  If Not fValidaCampos(mskDtaFinVen, true) then
     exit;

  Try
    Try
      pCriarFormularios(TfrmGravando, frmAguarde);
      frmAguarde.pgbStatus.Visible   := False;
      frmAguarde.blnDesabilitaMouse  := True;
      frmAguarde.lblGravando.Caption := 'Aguarde Carregando Títulos...';
      frmAguarde.fExecutarAcao := fAbreConsulta;
      frmAguarde.ShowModal;
      VerificaSeTemRegistros();
    Finally
      FreeAndNil(frmAguarde);
    End;
  Except
    On E : Exception Do
      pMensagensErro(E.Message, 'untRelCtrLogAcompDplicNovo.fAbreConsulta');
  End;

end;

procedure TfrmRelCtpLogAcompDuplic.btnGeraCSVClick(Sender: TObject);
  Var
    frmAguarde: TfrmGravando;
begin
  inherited;
  Try
    Try
      pCriarFormularios(TfrmGravando, frmAguarde);
      frmAguarde.lblGravando.Caption := 'Gerando Arquivo...';
      frmAguarde.fExecutarAcao := fGeraCSV;
      frmAguarde.ShowModal;
    Finally
      FreeAndNil(frmAguarde);
    End;
  Except
    On E : Exception Do
      pMensagensErro(E.Message, 'TGeraExcel.fGerarRelatorio');
  End;
end;

Procedure TfrmRelCtpLogAcompDuplic.VerificaSeTemRegistros();
Begin
  If Not dtsConsulta.DataSet.IsEmpty Then
  begin
     dbgConsultaDBTableView1.DataController.FocusedRowIndex := 0;
     pSetFocus(dbgConsulta);
  End
  Else
  Begin
    MouseShowCursor(True);
    fMensagem('ATENÇÃO!', 'Sem dados para exibir!', ['&O k']);
    pSetFocus(edtNumDoc);
  end;
End;

procedure TfrmRelCtpLogAcompDuplic.chkRegComAlteracaoClick(Sender: TObject);
begin
  inherited;
  If chkRegComAlteracao.checked Then
     cmbinfRegAlterado.enabled := True
  Else
  Begin
     cmbinfRegAlterado.enabled := False;
     cmbinfRegAlterado.ItemIndex := -1;
  End;
end;

procedure TfrmRelCtpLogAcompDuplic.dbgConsultaDBTableView1CTP_DEPOSIGetDataText(
  Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
begin
  inherited;
  AText := IIF(AText = 'S', 'Sim', 'Não');
end;

procedure TfrmRelCtpLogAcompDuplic.dbgConsultaDBTableView1CTP_PAGANTGetDataText(
  Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
begin
  inherited;
  AText := IIF(AText = 'S', 'Sim', 'Não');
end;

procedure TfrmRelCtpLogAcompDuplic.dbgConsultaDBTableView1CTP_PREVISGetDataText(
  Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
begin
  inherited;
  AText := IIF(AText = 'S', 'Sim', 'Não');
end;

procedure TfrmRelCtpLogAcompDuplic.dbgConsultaDBTableView1CTP_USACHQGetDataText(
  Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
begin
  inherited;
  AText := IIF(AText = 'S', 'Sim', 'Não');
end;

procedure TfrmRelCtpLogAcompDuplic.dbgConsultaDBTableView1CTP_USOCONGetDataText(
  Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
begin
  inherited;
  AText := IIF(AText = 'S', 'Sim', 'Não');
end;

procedure TfrmRelCtpLogAcompDuplic.dbgConsultaDBTableView1CTP_VEIOBOGetDataText(
  Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
begin
  inherited;
  AText := IIF(AText = 'S', 'Sim', 'Não');
end;

procedure TfrmRelCtpLogAcompDuplic.dbgConsultaDBTableView1CTP_VEIONFGetDataText(
  Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
begin
  inherited;
  AText := IIF(AText = 'S', 'Sim', 'Não');
end;

procedure TfrmRelCtpLogAcompDuplic.dbgConsultaDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If (AViewInfo.GridRecord.Values[dbgConsultaDBTableView1Alteracoes.Index] <> null) And
     (Pos(TcxGridDBColumn(AViewInfo.Item).DataBinding.FieldName,
          AViewInfo.GridRecord.Values[dbgConsultaDBTableView1Alteracoes.Index]) > 0) then
  Begin
    If AViewInfo.Selected Then
      ACanvas.Brush.Color := $4433CC
    Else
      ACanvas.Brush.Color := $8070FF;
  end
  Else
  Begin
    If (not AViewInfo.Selected) Then
    Begin
      If Odd(AViewInfo.GridRecord.Index) Then
        ACanvas.Brush.Color := intCor
      Else
        ACanvas.Brush.Color := clWindow;
    End;
  End;

  ACanvas.Font.Color := clBlack;

end;

procedure TfrmRelCtpLogAcompDuplic.dbgConsultaDBTableView1CustomDrawGroupCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableCellViewInfo; var ADone: Boolean);
begin
  inherited;
  ACanvas.Brush.Color := clSkyBlue;
  ACanvas.Font.Style := ACanvas.Font.Style + [fsBold];

end;

procedure TfrmRelCtpLogAcompDuplic.edtCodFornecedorKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrFornecedor: TConsultasArray;
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtCodFornecedor, edtNomFornecedor, Nil, Key, arrFornecedor) Then
  Begin
    If fValidaCampos(edtCodFornecedor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtpLogAcompDuplic.edtCodOpeKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;
  if fPesqOperador(Self, edtCodOpe, edtNomeOpe, Nil, Key, arrSel) then
  Begin
    If fValidaCampos(edtCodOpe, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtpLogAcompDuplic.edtNumDocExit(Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(edtNumDoc.Text) Then
  Begin
     mskdtaIni.Clear;
     mskdtaFin.Clear;
     mskdtaIniVen.Clear;
     mskdtaFinVen.Clear;
  End;
end;

procedure TfrmRelCtpLogAcompDuplic.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmp, True, True) Then
  Begin
    fValidaCampos(edtCodEmpresa,False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmRelCtpLogAcompDuplic.fAbreConsulta(cxProgress: TcxProgressBar): Boolean;
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := fCriaQuery;

  Try
    cdsConsulta.DisableControls;
    Try
      LConsulta.SQL.Text := fGetSql;

      If Not fSetParametros(LConsulta) Then
      Begin
        Result := False;
        Exit;
      End;

      dbgConsultaDBTableView1.DataController.DataSource := Nil;

      If cdsConsulta.Active Then
        cdsConsulta.EmptyDataSet;

      cdsConsulta.Close;

      fExecutaSQL('SET @CONTADOR := 0');
      LConsulta.Open;
      fExecutaSQL('SET @CONTADOR := 0');

      cdsConsulta := fCriaClientDatSet(LConsulta);

      pSetFilterDefault;

      pCriarFormularios(TfrmGravando,frmGravando);
      frmGravando.fExecutarAcao := MascaraValor;
      frmGravando.lblGravando.Caption := 'Aguarde... Adicionando Formatação aos campos.';
      frmGravando.ShowModal;
      pFreeAndNil(frmGravando);

      pCriarFormularios(TfrmGravando,frmGravando);
      frmGravando.fExecutarAcao := DefineAlteracoes;
      frmGravando.lblGravando.Caption := 'Aguarde... Verificando Alterações.';
      frmGravando.ShowModal;
      pFreeAndNil(frmGravando);

      dtsConsulta.Dataset := cdsConsulta;
      dbgConsultaDBTableView1.DataController.DataSource := dtsConsulta;
      pSetFocus(dbgConsulta);

      Result := LConsulta.RecordCount > 0;

      if (Result) Then
      Begin
        If (LConsulta.Locate('CTP_DESCRI', 'ALTERACAO (TEVE CTPDET)', [])) then
          btnAcompLogCtpDet.Enabled := True;
      End;

      blnMudarFoco := FALSE;
    Except

      On E : Exception Do
      Begin
        pMensagensErro(E.Message,'[TfrmRelCtpLogAcompDuplic.fAbreConsulta]');
        Result := False;
      End;

    End;
  Finally
    cdsConsulta.EnableControls;

    LConsulta.Close;
    FreeAndNil(LConsulta);
  End;
end;

function TfrmRelCtpLogAcompDuplic.fGetSql: String;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + ' SELECT LOGCTP.*, ';
  strSQL := strSQL + ' CADOCO.OCO_DESOCO AS MOTEST, ';
  strSQL := strSQL + ' CONCAT(CTP_NUMDUP, "-", CTP_PARCEL, "-", CTP_CODFOR, "-", CTP_CODEMP, "-", FOR_NOMFOR, "-", CTP_SERIE_) AS DUPLIC, ';
  strSQL := strSQL + '  CAST("" AS CHAR(1000)) AS ALTERACOES, ';
  strSQL := strSQL + '  LPAD(@CONTADOR := @CONTADOR + 1, 10, "0") AS CONTADOR, '; //Implementado para sempre gravar o contador, para que possa pegar o anterior qdo usar o filtro do combobox;
  strSQL := strSQL + '  "0000000000" AS CONT_ANTERIOR '; //Implementado para gravar o nmero referente ao registro anterior;
  strSQL := strSQL + ' FROM LOGCTP   ';
  strSQL := strSQL + ' LEFT JOIN CADFOR ON FOR_CODFOR = CTP_CODFOR  ';
  strSQL := strSQL + ' LEFT JOIN CADOCO ON CTP_MOTEST = OCO_CODOCO ';
  strSQL := strSQL + ' WHERE TRUE  ';

  if not fEmptyDate(fTiraCaracEspeciais(mskDtaIni.Text)) then
    strSQL := strSQL + '  AND CTP_DTACAD BETWEEN :DTAINI AND :DTAFIN ';

  if not fEmptyDate(fTiraCaracEspeciais(mskDtaIniVen.Text)) then
    strSQL := strSQL + '  AND CTP_DTAVEN BETWEEN :DTAINIVEN AND :DTAFINVEN ';

  If Not fEmptyStr(edtCodEmpresa.Text) Then
    strSQL := strSQL + '  AND CTP_CODEMP = :CODEMP ';

  If Not fEmptyStr(edtCodFornecedor.Text) Then
    strSQL := strSQL + '  AND CTP_CODFOR = :CODFOR ';

  If Not fEmptyStr(edtNumDoc.Text) Then
    strSQL := strSQL + '  AND CTP_NUMDUP = :NUMDUP ';

  If Not fEmptyStr(edtParcel.Text) Then
    strSQL := strSQL + '  AND CTP_PARCEL = :PARCEL ';

  If Not fEmptyStr(edtSerie.Text) Then
    strSQL := strSQL + '  AND IFNULL(CTP_SERIE_,"") = :SERIE_ ';

  If Not(fEmptyStr(edtCodOpe.Text)) Then
    strSQL := strSQL + '  AND CTP_OPELOG = :OPELOG ';

  strSQL := strSQL + ' ORDER BY DUPLIC, CTP_DTALOG, CTP_HORLOG ';

  Result := strSQL;

end;

procedure TfrmRelCtpLogAcompDuplic.FormCreate(Sender: TObject);
begin
  inherited;
  dtsConsulta := TDataSource.Create(Nil);
  cdsConsulta := TUniClientDataSet.Create(Nil);

  WindowState:= wsMaximized;
  edtNumDoc.MaxLength := fTamDocCadRec;
  edtNumDoc.TamCampo  := edtNumDoc.MaxLength;
end;

procedure TfrmRelCtpLogAcompDuplic.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(dtsConsulta);
  FreeAndNil(cdsConsulta);
end;

procedure TfrmRelCtpLogAcompDuplic.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  Case Key Of
    VK_ESCAPE:Begin
                If Assigned(cdsConsulta) Then
                Begin
                  If Not cdsConsulta.Active Then
                    Close
                  Else
                   pFechaConsulta;
                End
                Else
                  Close;
              end;
    Else       inherited;
  End;
end;

procedure TfrmRelCtpLogAcompDuplic.FormShow(Sender: TObject);
begin
  inherited;
  intCor    := StrToIntDef(fCfgSis('CORZEB'), clWhite);
  mskDtaIni.Text := DateToStr(VS_Date);
  mskDtaFin.Text := DateToStr(VS_Date);
  cmbinfRegAlterado.enabled := False;
  pSetFocus(edtNumDoc);
end;

function TfrmRelCtpLogAcompDuplic.fSetParametros(var ADataset: TUniQuery): Boolean;
begin
  Try
    if not fEmptyDate(mskDtaIni.Text) and
       not fEmptyDate(mskDtaFin.Text) then
    Begin
       ADataset.ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
       ADataset.ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
    End;

    if not fEmptyDate(mskDtaIniVen.Text) and
       not fEmptyDate(mskDtaFinVen.Text) then
    Begin
      ADataset.ParamByName('DTAINIVEN').AsDate := StrToDate(mskDtaIniVen.Text);
      ADataset.ParamByName('DTAFINVEN').AsDate := StrToDate(mskDtaFinVen.Text);
    End;

    If (Not fEmptyStr(edtCodEmpresa.Text)) Then
      ADataset.ParamByName('CODEMP').AsString := edtCodEmpresa.Text;

    If Not fEmptyStr(edtSerie.Text) Then
      ADataset.ParamByName('SERIE_').AsString := edtSerie.Text;

    If Not fEmptyStr(edtCodFornecedor.Text) Then
      ADataset.ParamByName('CODFOR').AsString := edtCodFornecedor.Text;

    If Not fEmptyStr(edtNumDoc.Text) Then
      ADataset.ParamByName('NUMDUP').AsString := edtNumDoc.Text;

    If Not fEmptyStr(edtParcel.Text) Then
      ADataset.ParamByName('PARCEL').AsString := edtParcel.Text;

    If Not fEmptyStr(edtCodOpe.Text) Then
      ADataset.ParamByName('OPELOG').AsString := edtCodOpe.Text;

    Result := True;
  Except
    Result := False;
  End;
end;

function TfrmRelCtpLogAcompDuplic.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
    Begin
      if StrToDateDef( TcxDateEdit(Sender).Text,0 ) > 0 then
        TcxDateEdit(Sender).Text := DateToStr( StrToDateDef( TcxDateEdit(Sender).Text,0 ) )
      Else If Not fEmptyStr(fTiraCaracEspeciais(TcxDateEdit(Sender).Text)) Then
      Begin
        fMensagem('', 'Data informada inválida, necessário correção!', ['&O k']);
        Result := False;
      End;

      If Result Then
      Begin
        If (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))    And
            fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))    And
            fEmptyStr(fTiraCaracEspeciais(mskDtaIniVen.Text)) And
            fEmptyStr(fTiraCaracEspeciais(mskDtaFinVen.Text))) And (fEmptyStr(edtNumDoc.Text)) Then
        Begin
          fMensagem('', 'É necessário informar um período de "Cadastro" ou "Vencimento"!', ['&O k']);
          Result := False;
        End
        Else
        If   fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))          And
           ((fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) = False) or
           ( fEmptyStr(fTiraCaracEspeciais(mskDtaFinVen.Text))       and
             fEmptyStr(fTiraCaracEspeciais(mskDtaIniVen.Text)))) And (fEmptyStr(edtNumDoc.Text)) Then
        Begin
          fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          If (Sender = mskDtaFin) Then
          Begin
            If   fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))          And
               ((fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) = False) or
               ( fEmptyStr(fTiraCaracEspeciais(mskDtaFinVen.Text))       And
                 fEmptyStr(fTiraCaracEspeciais(mskDtaIniVen.Text)))) And (fEmptyStr(edtNumDoc.Text)) Then
            Begin
              fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
              Result := False;
            End
            Else If not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) And fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
            Begin
              If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
              Begin
                fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
                Result := False;
              End
            End;
          End
        End;
      End;

    End

    Else
    If (Sender = mskDtaIniVen) Or (Sender = mskDtaFinVen) Then
    Begin
      if StrToDateDef( TcxDateEdit(Sender).Text,0 ) > 0 then
        TcxDateEdit(Sender).Text := DateToStr( StrToDateDef( TcxDateEdit(Sender).Text,0 ) )
      Else If Not fEmptyStr(fTiraCaracEspeciais(TcxDateEdit(Sender).Text)) Then
      Begin
        fMensagem('', 'Data informada inválida, necessário correção!', ['&O k']);
        Result := False;
      End;

      If Result Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaIniVen.Text)) And
           (fEmptyStr(fTiraCaracEspeciais(mskDtaFinVen.Text))=false) And (fEmptyStr(edtNumDoc.Text)) Then
        Begin
          fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else
        if (Sender = mskDtaFinVen) then
        Begin
          If fEmptyStr(fTiraCaracEspeciais(mskDtaFinVen.Text)) And
             (fEmptyStr(fTiraCaracEspeciais(mskDtaIniVen.Text))=false) And (fEmptyStr(edtNumDoc.Text)) Then
          Begin
            fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
            Result := False;
          End
          Else if not fEmptyStr(fTiraCaracEspeciais(mskDtaIniVen.Text)) And (fEmptyStr(edtNumDoc.Text)) then
          Begin
            If StrToDate(mskDtaIniVen.Text) > StrToDate(mskDtaFinVen.Text) Then
            Begin
              fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
              Result := False;
            End;
          End;
        End;
      End;

    End

    Else If (Sender = edtCodOpe) Then
    Begin
      If fEmptyStr(edtCodOpe.Text) Then
      Begin
        edtNomeOpe.Text := 'TODOS';
      End Else
      Begin
        edtNomeOpe.Text := fRetNomeOperador(edtCodOpe.Text);
        If fEmptyStr(edtNomeOpe.Text) Then
        Begin
          Result := False;
          pMensagemOk('Operador não encontrado!');
        End;
      End;
    End

    Else If (Sender = edtCodFornecedor) Then
    Begin

      If fEmptyStr(edtCodFornecedor.Text) Then
      Begin
        edtNomFornecedor.Text := 'TODOS';
      End Else
      Begin
        edtNomFornecedor.Text := fRetNomFornecedor(edtCodFornecedor.Text);
        If fEmptyStr(edtNomFornecedor.Text) Then
        Begin
          Result := False;
          pMensagemOk('Fornecedor não encontrado!');
        End;
      End;

    End

    Else If (Sender = edtCodEmpresa) Then
    Begin

      If fEmptyStr(edtCodEmpresa.Text) Then
      Begin
        edtDesEmpresa.Text := 'TODAS';
      End Else
      Begin
        edtDesEmpresa.Text := fRetNomeEmpresa(edtCodEmpresa.Text);

        If fEmptyStr(edtDesEmpresa.Text) Then
        Begin
          Result := False;
          pMensagemOk('Empresa não encontrada!');
        End

        Else If Pos(edtCodEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End;
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmRelCtpLogAcompDuplic.pFechaConsulta;
begin
  cdsConsulta.Close;

  mskDtaIni.Text := DateToStr(VS_Date);
  mskDtaFin.Text := DateToStr(VS_Date);
  mskDtaIniVen.Clear;
  mskDtaFinVen.Clear;
  edtCodFornecedor.Clear;
  edtNomFornecedor.Clear;
  edtCodEmpresa.Clear;
  edtDesEmpresa.Clear;
  edtNumDoc.Clear;
  edtParcel.Clear;
  edtCodOpe.Clear;
  edtNomeOpe.Clear;
  btnAcompLogCtpDet.Enabled := False;

  pSetFocus(edtNumDoc);
end;

function TfrmRelCtpLogAcompDuplic.MascaraValor(cxProgress: TcxProgressBar = Nil): Boolean;
  Var
    intIndex: integer;
begin
  Result := True;

  If cdsConsulta.Active Then
  Begin
    cxProgress.Position := 0;
    cxProgress.Properties.Max := cdsConsulta.Fields.Count;

    For intIndex := 1 To cdsConsulta.Fields.Count - 1 Do
    Begin
      Case cdsConsulta.Fields[intIndex].DataType Of
        ftFloat: TFloatField(cdsConsulta.Fields[intIndex]).DisplayFormat := fMskDigitos(2);
        ftDate : TFloatField(cdsConsulta.Fields[intIndex]).EditMask      := '99/99/9999;1;_';
      End;
      pStep(cxProgress);
    End;
  End;

end;

procedure TfrmRelCtpLogAcompDuplic.pSetFilterDefault;
begin
  cdsConsulta.Filter := '';
  If cdsConsulta.Filtered Then
    cdsConsulta.Filtered := FALSE;
end;

function TfrmRelCtpLogAcompDuplic.DefineAlteracoes(cxProgress: TcxProgressBar = Nil): Boolean;
var
  arrRef: Array of String;
  strDupAtual: String;
  strCamposDif: String;
  intIndex: Integer;
begin

  Result := True;

  SetLength(arrRef, cdsConsulta.Fields.Count);
  cxProgress.Position := 0;
  cxProgress.Properties.Max := cdsConsulta.RecordCount;

  cdsConsulta.First;
  strDupAtual := '';

  While not cdsConsulta.Eof Do
  Begin
    If (strDupAtual <> cdsConsulta.FieldByName('DUPLIC').AsString) Then
    Begin
      strDupAtual := cdsConsulta.FieldByName('DUPLIC').AsString;
      for intIndex := 0 to cdsConsulta.Fields.Count - 1 do
        arrRef[intIndex] := cdsConsulta.Fields[intIndex].AsString;
    End
    Else
    Begin
      strCamposDif := '/';
      for intIndex := 0 to cdsConsulta.Fields.Count - 1 do
        If (arrRef[intIndex] <> cdsConsulta.Fields[intIndex].AsString) And
           (cdsConsulta.Fields[intIndex].FieldName <> 'AUTOINCREM') And
           (cdsConsulta.Fields[intIndex].FieldName <> 'CTP_DTALOG') And
           (cdsConsulta.Fields[intIndex].FieldName <> 'CTP_HORLOG') And
           (cdsConsulta.Fields[intIndex].FieldName <> 'CTP_DESCRI') And
           (cdsConsulta.Fields[intIndex].FieldName <> 'CTP_NOMFRM') And
           (cdsConsulta.Fields[intIndex].FieldName <> 'CTP_OPELOG') Then
          strCamposDif := strCamposDif + cdsConsulta.Fields[intIndex].FieldName + '/';

      cdsConsulta.Edit;
      cdsConsulta.FieldByName('ALTERACOES').AsString := strCamposDif;
      cdsConsulta.FieldByName('CONT_ANTERIOR').AsString := IntToStr(cdsConsulta.FieldByName('CONTADOR').AsInteger -1);
      cdsConsulta.Post;

      for intIndex := 0 to cdsConsulta.Fields.Count - 1 do
        arrRef[intIndex] := cdsConsulta.Fields[intIndex].AsString;
    End;

    cdsConsulta.Next;
    pStep(cxProgress);
  End;

  pVerificaAplicaFiltroRegComAlteracao();

  cdsConsulta.First;
end;

Procedure TfrmRelCtpLogAcompDuplic.pVerificaAplicaFiltroRegComAlteracao();
 Var
     cmpfiltro : String;
     strListAnteriores : String;
Begin

  If (chkRegComAlteracao.Checked) and (cmbInfRegAlterado.ItemIndex <> -1) Then
  Begin

    cmpfiltro := '';

    Case cmbInfRegAlterado.ItemIndex Of
      0: cmpfiltro := 'CTP_DTAVEN';
      1: cmpfiltro := 'CTP_CODPOR';
      2: cmpfiltro := 'CTP_VALDUP';
    End;

    //FILTER PARA PEGAR APENAS AS ALTERACOES CONFORME O COMBO SELECIONADO.
    cdsConsulta.Filtered  := False;
    cdsConsulta.Filter := ' (ALTERACOES LIKE ''%' + cmpfiltro + '%'') ';
    cdsConsulta.Filtered := True;

    strListAnteriores := fRetornaListaRegAntesAlteracao(cdsConsulta);

    If Not FEmptyStr(strListAnteriores) Then
    Begin
      cdsConsulta.Filtered  := False;
      cdsConsulta.First;
      While Not cdsConsulta.Eof Do
      Begin
        If Not cdsConsulta.FieldByName('ALTERACOES').AsString.Contains(cmpfiltro) Then
        Begin
          If Not strListAnteriores.Contains(cdsConsulta.FieldByName('CONTADOR').AsString) Then
          Begin
            cdsConsulta.Delete;
            Continue;
          End;
        End;

        cdsConsulta.Next;
      End;
    End;

  End;
End;

Function TfrmRelCtpLogAcompDuplic.fRetornaListaRegAntesAlteracao(cdsGen:TDataSet): String;
Begin
  Result := EmptyStr;

  cdsGen.First;
  While (Not cdsGen.Eof) Do
  Begin
    Result := Result + cdsGen.FieldByName('CONT_ANTERIOR').AsString.Trim + '_';

    cdsGen.Next;
  End;
End;

procedure TfrmRelCtpLogAcompDuplic.pStep(pgbStatus: TcxProgressBar);
begin
  If Assigned(pgbStatus) Then
  Begin
    pgbStatus.Position := pgbStatus.Position + 1;
    Application.ProcessMessages;
  End;
end;

function TfrmRelCtpLogAcompDuplic.MouseShowCursor(const Show: boolean): boolean;
var
  I: integer;
begin
  I := ShowCursor(LongBool(true));
  if Show then
  begin
    Result := I >= 0;
    while I < 0 do begin
      Result := ShowCursor(LongBool(true)) >= 0;
      Inc(I);
    end;
  end
  else
  begin
    Result := I < 0;
    while I >= 0 do
    begin
      Result := ShowCursor(LongBool(false)) < 0;
      Dec(I);
    end;
  end;
end;

function TfrmRelCtpLogAcompDuplic.fGeraCSV(cxProgress: TcxProgressBar): Boolean;
  Var
    svdCsv: TSaveDialog;
    strLinha,
    strNomArq: String;
    stlCsv: TStringList;

    procedure pStepStatusGravacao;
    Begin
      If Assigned(cxProgress) Then
      Begin
        cxProgress.Position := cxProgress.Position + 1;
        Application.ProcessMessages;
      End;
    End;

    procedure pInfoStatusGravacao(strInformacao: String);
    Begin
      If Assigned(cxProgress) And (GetParentForm(cxProgress).FindComponent('lblGravando') <> Nil) Then
      Begin
        TLabel(GetParentForm(cxProgress).FindComponent('lblGravando')).Caption := strInformacao;
        Application.ProcessMessages;
      End;
    End;

begin
  Result := True;

  pInfoStatusGravacao('Gerando arquivo CSV. Aguarde...');

  cxProgress.Position := 0;
  cxProgress.Properties.Max := cdsConsulta.RecordCount;

  svdCsv := TSaveDialog.Create(Nil);
  svdCsv.Filter := 'Arquivo CSV|*.csv';
  svdCsv.DefaultExt := 'csv';

  If svdCsv.Execute Then
  Begin
    strNomArq := svdCsv.FileName;

    If Not fEmptyStr(strNomArq) Then
    Begin
      stlCsv := TStringList.Create;

      stlCsv.Clear;

      With cdsConsulta Do
      Begin
        DisableControls;

        First;

        strLinha := 'DATA LOG.;HORA LOG.;DESCRIÇÃO;NOME DO FORMULÁRIO;CÓD. OPERADOR LOG;NUM DOC;PARCELA;' +
                    'CÓD. FORNECEDOR;CÓD. EMPRESA;SEQ. BAIXA;CÓD. VENDEDOR;CÓD. PORTADOR;DATA CADASTRO;' +
                    'VENCIMENTO;VALOR;VALOR ORIGINAL;OUTRAS ENTR.;HISTÓRICO 1;HISTÓRICO 2;'+
                    'PORTADOR DA BAIXA;HISTÓRICO DA BAIXA;PL. CONTAS DA BAIXA;OPE. BAIXA;DATA DE PAG.;VALOR PAG.;'+
                    'VALOR JUROS;VALOR DESC.;ENVIO BANCO;DATA ENVIO;CÓD. CENTRO DE CUSTOS;'+
                    'CÓD. PL. CONTAS;CÓD. EMP. BAIXA;MOTIVO ESTORNO;VEIO BOLETO?;VEIO NF?;PREVISÃO?;CHEQUE?;'+
                    'PAGTO. ANTECIPADO?;DEPÓSITO?;USO E CONSUMO?;NOME EXE;DATA DO EXE;HORA EXE;VERSÃO EXE';

        stlCsv.Add(strLinha);

        While Not Eof Do
        Begin
          strLinha := FormatDateTime('dd/mm/yyyy', FieldByName('CTP_DTALOG').AsDateTime) + ';' +
                      FormatDateTime('HH:mm:ss',FieldByName('CTP_HORLOG').AsDateTime) + ';' +
                      FieldByName('CTP_DESCRI').AsString + ';' +
                      FieldByName('CTP_NOMFRM').AsString + ';' +
                      FieldByName('CTP_OPELOG').AsString + ';' +
                      FieldByName('CTP_NUMDUP').AsString + ';' +
                      FieldByName('CTP_PARCEL').AsString + ';' +
                      FieldByName('CTP_CODFOR').AsString + ';' +
                      FieldByName('CTP_CODEMP').AsString + ';' +
                      IntToStr(FieldByName('CTP_SEQBAI').AsInteger) + ';' +
                      FieldByName('CTP_CODVEN').AsString + ';' +
                      FieldByName('CTP_CODPOR').AsString + ';' +
                      IfThen(FieldByName('CTP_DTACAD').Value <= 0, '', FormatDateTime('dd/mm/yyyy', FieldByName('CTP_DTACAD').AsDateTime)) + ';' +
                      IfThen(FieldByName('CTP_DTAVEN').Value <= 0, '', FormatDateTime('dd/mm/yyyy', FieldByName('CTP_DTAVEN').AsDateTime)) + ';' +
                      FormatFloat('#,##0.00',FieldByName('CTP_VALDUP').AsFloat) + ';' +
                      FormatFloat('#,##0.00',FieldByName('CTP_VALORI').AsFloat) + ';' +
                      FormatFloat('#,##0.00',FieldByName('CTP_OUTENT').AsFloat) + ';' +
                      ReplaceStr(ReplaceStr(ReplaceStr((ReplaceStr(FieldByName('CTP_HIST01').AsString, '<<csq>>', ' ')), #13#10, ' '),#10, ' '),#13, ' ') + ';' +
                      ReplaceStr(ReplaceStr(ReplaceStr((ReplaceStr(FieldByName('CTP_HIST02').AsString, '<<csq>>', ' ')), #13#10, ' '),#10, ' '),#13, ' ') + ';' +
                      FieldByName('CTP_PORBAI').AsString + ';' +
                      ReplaceStr(ReplaceStr(ReplaceStr((ReplaceStr(FieldByName('CTP_HISBAI').AsString, '<<csq>>', ' ')), #13#10, ' '),#10, ' '),#13, ' ') + ';' +
                      FieldByName('CTP_CTABAI').AsString + ';' +
                      FieldByName('CTP_OPEBAI').AsString + ';' +
                      IfThen(FieldByName('CTP_DTAPAG').Value <= 0, '', FormatDateTime('dd/mm/yyyy', FieldByName('CTP_DTAPAG').AsDateTime)) + ';' +
                      FormatFloat('#,##0.00',FieldByName('CTP_VALPAG').AsFloat) + ';' +
                      FormatFloat('#,##0.00',FieldByName('CTP_VALJUR').AsFloat) + ';' +
                      FormatFloat('#,##0.00',FieldByName('CTP_VALDES').AsFloat) + ';' +
                      FieldByName('CTP_BCOENV').AsString + ';' +
                      IfThen(FieldByName('CTP_DTAENV').Value <= 0, '', FormatDateTime('dd/mm/yyyy', FieldByName('CTP_DTAENV').AsDateTime)) + ';' +
                      FieldByName('CTP_CODEVE').AsString + ';' +
                      FieldByName('CTP_CODCTA').AsString + ';' +
                      FieldByName('CTP_EMPBAI').AsString + ';' +
                      FieldByName('CTP_MOTEST').AsString + ';' +
                      FieldByName('CTP_VEIOBO').AsString + ';' +
                      FieldByName('CTP_VEIONF').AsString + ';' +
                      FieldByName('CTP_PREVIS').AsString + ';' +
                      FieldByName('CTP_USACHQ').AsString + ';' +
                      FieldByName('CTP_PAGANT').AsString + ';' +
                      FieldByName('CTP_DEPOSI').AsString + ';' +
                      FieldByName('CTP_USOCON').AsString + ';' +
                      FieldByName('CTP_NOMEXE').AsString+';'+
                      IfThen(FieldByName('CTP_DTAEXE').Value <= 0, '', FormatDateTime('dd/mm/yyyy', FieldByName('CTP_DTAEXE').AsDateTime)) + ';' +
                      IfThen(FieldByName('CTP_HOREXE').Value <= 0, '', FormatDateTime('HH:mm:ss', FieldByName('CTP_HOREXE').AsDateTime)) + ';' +
                      FieldByName('CTP_VEREXE').AsString;

          stlCsv.Add(strLinha);
          pStepStatusGravacao;

          Next;
        End;
        EnableControls;
      End;

      stlCsv.SaveToFile(strNomArq);
      FreeAndNil(stlCsv);

      fMensagem('','Arquivo CSV gerado com sucesso!!', ['&O K']);
    End;
  End;

  FreeAndNil(svdCsv);
end;

end.
