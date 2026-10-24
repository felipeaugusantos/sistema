unit untRelCtpLogAcompDuplicNovo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Mask, MaskEditFocus, StdCtrls, EditFocus, AppEvnts, Menus,
  Buttons, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  UniDataSetProvider,   Uni, BitBtnLockedIncrem, cxGrid, UniClientDataSet, StrUtils,
  cxLookAndFeels, cxLookAndFeelPainters,
  cxNavigator, frxClass, frxExportCSVTestabilidade, System.UITypes,
  cxProgressBar, untClassPanelCx, System.ImageList,
  Vcl.ImgList, Datasnap.Provider, DBAccess, Datasnap.DBClient, untTypesSistema, untIFuncoes, untGravando,
  cxContainer, Vcl.ComCtrls, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxImageList;

type
  TfrmRelCtpLogAcompDuplicNovo = class(TfrmPai)
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
    dbgConsultaDBTableView1CTP_CODFOR: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_CODEMP: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_CODVEN: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_CODOPE: TcxGridDBColumn;
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
    dbgConsultaDBTableView1Alteracoes: TcxGridDBColumn;
    GroupBox1: TGroupBox;
    Shape1: TShape;
    Label2: TLabel;
    btnPadrao: TBitBtnLocked;
    btnGeraCSV: TBitBtnLocked;
    cxImageList: TcxImageList;
    btnConsultar: TBitBtnLocked;
    dbgConsultaDBTableView1CTP_RESCAI: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_DTABAI: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_DINHEI: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_CHQAVI: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_CHQPRE: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_CARTAO: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_SEQCON: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_JURSUJ: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_MULSUJ: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_DESSUJ: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_LINDIG: TcxGridDBColumn;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    Shp_inferior: TShape;
    lblCampoAlterados2: TLabel;
    dbgConsultaDBTableView1MotEst: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_OUTENT: TcxGridDBColumn;
    btnAcompLogCtpDet: TBitBtnLocked;
    Label6: TLabel;
    edtSerie: TEditFocus;
    dbgConsultaDBTableView1CTP_NUMAGR: TcxGridDBColumn;
    pnlOperador: TPanel;
    Label7: TLabel;
    edtNomeOpe: TEditFocus;
    edtCodOpe: TEditFocus;
    dbgConsultaDBTableView1CTP_NOMEXE: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_DTAEXE: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_HOREXE: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_VEREXE: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_VEIOBO: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_USACHQ: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_VEIONF: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_PREVIS: TcxGridDBColumn;
    dbgConsultaDBTableView1CTP_DEPOSI: TcxGridDBColumn;
    rdgData: TRadioGroup;
    pnlDatas: TPanel;
    procedure edtCodFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbgConsultaDBTableView1CustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure dbgConsultaDBTableView1CustomDrawGroupCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableCellViewInfo; var ADone: Boolean);
    procedure btnPadraoClick(Sender: TObject);
    procedure btnGeraCSVClick(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure btnAcompLogCtpDetClick(Sender: TObject);
    procedure edtCodOpeKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    intCor     : Integer;

    FDatasetConsulta: TUniClientDataset;

    dtsConsulta: TDataSource;

    procedure pFechaConsulta;
    procedure pSetFilterDefault;
    procedure pMascaraValor;
    function fGetSql: String;
    function fGetSqlAG: String;

    function fAbreConsulta(cxProgress: TcxProgressBar = Nil): Boolean;
    function fSetParametros(var ADataset: TUniQuery): Boolean;
    function fSetParametrosAG(var ADataset: TUniQuery): Boolean;


    Function fAjustaColunas(pgbProgresso: TcxProgressBar): Boolean;
    procedure pAjustaColunas;
    function fGeraCSV(cxProgress : TcxProgressBar): Boolean;
    function MouseShowCursor(const Show: boolean): boolean;
    procedure pDefineAlteracoes;
    function fCarregaCampos(pgbProgresso: TcxProgressBar): Boolean;
    procedure pOcultarColunas;
  public
    { Public declarations }
    blnVeioManutencao: Boolean;
    blnVeioAgrupamento: Boolean;
    blnVeioAtribPortador: Boolean;
    blnVeioCtpReprogVen: Boolean;

    procedure pCarregaCampos;

    property DatasetConsulta: TUniClientDataset read FDatasetConsulta;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;


implementation

uses untConsultas, untFuncoesSimples, untFuncoesRel, untFuncoesRel2;

{$R *.dfm}

procedure TfrmRelCtpLogAcompDuplicNovo.btnAcompLogCtpDetClick(Sender: TObject);
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
                        edtCodEmpresa.Text,
                        FDatasetConsulta.FieldByName('CTP_VALORI').AsString],
                        Sender,
                        nil,
                        True);
  End;

end;

procedure TfrmRelCtpLogAcompDuplicNovo.btnConsultarClick(Sender: TObject);
  Var
    frmAguarde: TfrmGravando;
begin
  inherited;
  Try
    Try
      pCriarFormularios(TfrmGravando, frmAguarde);
      frmAguarde.pgbStatus.Visible   := False;
      frmAguarde.blnDesabilitaMouse  := True;
      frmAguarde.lblGravando.Caption := 'Aguarde Carregando Títulos...';
      frmAguarde.fExecutarAcao := fAbreConsulta;
      frmAguarde.ShowModal;
      btnPadraoClick(Sender);
    Finally
      FreeAndNil(frmAguarde);
    End;
  Except
    On E : Exception Do
      pMensagensErro(E.Message, 'untRelCtrLogAcompDplicNovo.fAbreConsulta');
  End;
end;

procedure TfrmRelCtpLogAcompDuplicNovo.btnGeraCSVClick(Sender: TObject);
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

procedure TfrmRelCtpLogAcompDuplicNovo.btnPadraoClick(Sender: TObject);
begin
  inherited;
  btnPadrao.Enabled := False;

  If ((not Assigned(dtsConsulta.DataSet)) or (dtsConsulta.DataSet.IsEmpty)) Then
  begin
    MouseShowCursor(True);
    fMensagem('ATENÇÃO!', 'Sem dados para exibir!', ['&O k']);
    pSetFocus(edtCodOpe);
    Exit;
  end;

  dbgConsultaDBTableView1.ViewData.Collapse(True);
  pAjustaColunas;
  dbgConsultaDBTableView1.DataController.FocusedRowIndex := 0;
  pSetFocus(dbgConsulta);
  btnPadrao.Enabled := True;
end;

procedure TfrmRelCtpLogAcompDuplicNovo.dbgConsultaDBTableView1CustomDrawCell(
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

procedure TfrmRelCtpLogAcompDuplicNovo.dbgConsultaDBTableView1CustomDrawGroupCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableCellViewInfo; var ADone: Boolean);
begin
  inherited;
  ACanvas.Brush.Color := clSkyBlue;
  ACanvas.Font.Style := ACanvas.Font.Style + [fsBold];
end;

procedure TfrmRelCtpLogAcompDuplicNovo.edtCodFornecedorKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrFornecedors: TConsultasArray;
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtCodFornecedor, edtNomFornecedor, Nil, Key, arrFornecedors) Then
  Begin
    If fValidaCampos(edtCodFornecedor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtpLogAcompDuplicNovo.edtCodOpeKeyPress(Sender: TObject;
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

procedure TfrmRelCtpLogAcompDuplicNovo.edtCodEmpresaKeyPress(Sender: TObject;
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

function TfrmRelCtpLogAcompDuplicNovo.fAbreConsulta(cxProgress: TcxProgressBar): Boolean;
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := fCriaQuery;

  Try
    dbgConsultaDBTableView1.DataController.DataSource := Nil;
    dtsConsulta.Dataset := Nil;

    If Not blnVeioAgrupamento or blnVeioCtpReprogVen Then
    Begin
      LConsulta.SQL.Text := fGetSql;
      If Not fSetParametros(LConsulta) Then
        Exit(False);
    End
    Else If blnVeioAgrupamento Then
    Begin
      LConsulta.SQL.Text := fGetSqlAG;
      If Not fSetParametrosAG(LConsulta) Then
        Exit(False);
    End;

    LConsulta.Open;

    FDatasetConsulta := fCriaClientDatSet(LConsulta);

    pSetFilterDefault;

    pMascaraValor;

    pDefineAlteracoes;

    dtsConsulta.DataSet := FDatasetConsulta;
    dbgConsultaDBTableView1.DataController.DataSource := dtsConsulta;
    pSetFocus(dbgConsulta);

    Result := FDatasetConsulta.RecordCount > 0;

    if (LConsulta.RecordCount > 0) And
       ((LConsulta.Locate('CTP_DESCRI', 'INCLUSAO (TEVE CTPDET)', [])) OR
        (LConsulta.Locate('CTP_DESCRI', 'ALTERACAO (TEVE CTPDET)', []))) then
      btnAcompLogCtpDet.Enabled := True;

    blnMudarFoco := FALSE;
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;

end;

function TfrmRelCtpLogAcompDuplicNovo.fGetSql: String;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT LOGCTP.*, ';
  strSQL := strSQL + '  REPLACE(IFNULL(CTP_HIST01, ""), "<<csq>>" , " ") AS HIST01, ';
  strSQL := strSQL + '  REPLACE(IFNULL(CTP_HIST02, ""), "<<csq>>" , " ") AS HIST02, ';
  strSQL := strSQL + '  REPLACE(IFNULL(CTP_HISBAI, ""), "<<csq>>" , " ") AS HISBAI, ';
  strSQL := strSQL + '  CONCAT(CTP_NUMDUP, "-", CTP_PARCEL, "-", CTP_CODFOR, "-", CTP_CODEMP, "-", FOR_NOMFOR, ';
  strSQL := strSQL + '         IF(IFNULL(CTP_SERIE_, "") = "", "", CONCAT("-", CTP_SERIE_))) AS DUPLIC, ';
  strSQL := strSQL + '  CADOCO.OCO_DESOCO AS MOTEST, ';
  strSQL := strSQL + ' CAST("" AS CHAR(1000)) AS ALTERACOES ';
  strSQL := strSQL + ' FROM LOGCTP    ';
  strSQL := strSQL + ' LEFT JOIN CADOCO ON CTP_MOTEST = OCO_CODOCO ';
  strSQL := strSQL + ' LEFT JOIN CADFOR ON FOR_CODFOR = CTP_CODFOR ';
  
  if blnVeioAtribPortador or blnVeioCtpReprogVen then
  begin
    If rdgData.ItemIndex = 0 Then
    Begin
      strSQL := strSQL + ' WHERE    ';
      if(blnVeioCtpReprogVen) Then
        strSQL := strSQL + '   CTP_DTAVEN BETWEEN :DTAINI AND :DTAFIN ' // vencimento
      Else
        strSQL := strSQL + '   CTP_DTACAD BETWEEN :DTAINI AND :DTAFIN '; // cadastro
    End
    Else
    Begin
      strSQL := strSQL + ' WHERE    ';
      strSQL := strSQL + '   CTP_DTALOG BETWEEN :DTAINI AND :DTAFIN ';   // alterado
    End;
  end
  else
  if Not blnVeioManutencao then
  begin
    strSQL := strSQL + ' WHERE    ';
    strSQL := strSQL + '   CTP_DTACAD BETWEEN :DTAINI AND :DTAFIN ';
  end
  else
    strSQL := strSQL + ' WHERE TRUE ';

  If Not fEmptyStr(edtCodEmpresa.Text) and Not blnVeioCtpReprogVen Then
    strSQL := strSQL + '  AND CTP_CODEMP = :CODEMP ';

  If Not fEmptyStr(edtCodFornecedor.Text) Then
    strSQL := strSQL + '  AND CTP_CODFOR = :CODFOR ';

  If Not fEmptyStr(edtNumDoc.Text) Then
    strSQL := strSQL + '  AND CTP_NUMDUP = :NUMDUP ';

  If Not fEmptyStr(edtSerie.Text) Then
    strSQL := strSQL + '  AND CTP_SERIE_ = :SERIE_ '
  Else If blnVeioManutencao Then
    strSQL := strSQL + '  AND (CTP_SERIE_ IS NULL OR CTP_SERIE_ = "") ';

  If Not fEmptyStr(edtParcel.Text) and Not blnVeioCtpReprogVen Then
    strSQL := strSQL + '  AND CTP_PARCEL = :PARCEL ';

  If Not fEmptyStr(edtCodOpe.Text) and blnVeioCtpReprogVen Then
    strSQL := strSQL +'  AND CTP_CODVEN = :OPELOG';

  strSQL := strSQL + ' ORDER BY DUPLIC, CTP_DTALOG, CTP_HORLOG ';

  Result := strSQL;

end;

function TfrmRelCtpLogAcompDuplicNovo.fGetSqlAG: String;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + '  SELECT A.*, ';
  strSQL := strSQL + '  CONCAT (CTP_NUMAGR,"-",C.CTP_CODFOR,"-",C.CTP_CODEMP,"-(",C.CTP_CODVEN,"-",OPE_NOMOPE,")") AS AGRUP , ';
  strSQL := strSQL + '  REPLACE(IFNULL(A.CTP_HIST01, ""), "<<csq>>" , " ") AS HIST01, ';
  strSQL := strSQL + '  REPLACE(IFNULL(A.CTP_HIST02, ""), "<<csq>>" , " ") AS HIST02, ';
  strSQL := strSQL + '  REPLACE(IFNULL(A.CTP_HISBAI, ""), "<<csq>>" , " ") AS HISBAI, ';
  strSQL := strSQL + '  CONCAT(A.CTP_NUMDUP, "-", A.CTP_PARCEL, "-", A.CTP_CODFOR, "-", A.CTP_CODEMP, "-", FOR_NOMFOR) AS DUPLIC, ';
  strSQL := strSQL + '  CADOCO.OCO_DESOCO AS MOTEST, ';
  strSQL := strSQL + ' CAST("" AS CHAR(1000)) AS ALTERACOES ';
  strSQL := strSQL + ' FROM LOGCTP A  ';
  strSQL := strSQL + ' LEFT JOIN CADOCO ON CTP_MOTEST = OCO_CODOCO ';
  strSQL := strSQL + ' LEFT JOIN CADFOR ON FOR_CODFOR = CTP_CODFOR ';
  strSQL := strSQL + ' INNER JOIN DUPAGP B ON A.CTP_NUMDUP = B.CTP_NUMDUP  ' ;
  strSQL := strSQL + '                    AND A.CTP_PARCEL = B.CTP_PARCEL  ' +
                     '                    AND A.CTP_CODFOR = B.CTP_CODFOR  ' +
                     '                    AND A.CTP_CODEMP = B.CTP_CODEMP  ' ;
  strSQL := strSQL + ' INNER JOIN CADPAG C ON C.CTP_NUMDUP = B.CTP_NUMAGR  ' ;
  strSQL := strSQL + ' AND C.CTP_CODFOR = B.CTP_CODFOR                     ' ;
  strSQL := strSQL + ' INNER JOIN CADOPE  ON OPE_CODOPE = C.CTP_CODVEN     ' ;

  strSQL := strSQL + ' WHERE    ';
  strSQL := strSQL + '   C.CTP_DTACAD BETWEEN :DTAINI AND :DTAFIN ';

  If Not fEmptyStr(edtCodEmpresa.Text) and Not blnVeioCtpReprogVen Then
    strSQL := strSQL + '  AND C.CTP_CODEMP = :CODEMP ';

  If Not fEmptyStr(edtCodFornecedor.Text) Then
    strSQL := strSQL + '  AND C.CTP_CODFOR = :CODFOR ';

  If Not fEmptyStr(edtNumDoc.Text) Then
    strSQL := strSQL + '  AND B.CTP_NUMAGR = :NUMAGR ';

  If Not(fEmptyStr(edtCodOpe.Text)) Then
    strSQL := strSQL +'  AND C.CTP_CODVEN = :OPELOG';

  strSQL := strSQL + ' ORDER BY DUPLIC, A.CTP_DTALOG, A.CTP_HORLOG ';

  Result := strSQL;

end;

procedure TfrmRelCtpLogAcompDuplicNovo.FormCreate(Sender: TObject);
begin
  inherited;
  dtsConsulta := TDataSource.Create(Nil);
  FDatasetConsulta := TUNiClientDataset.Create(Nil);
  WindowState:= wsMaximized;
end;

procedure TfrmRelCtpLogAcompDuplicNovo.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(dtsConsulta);
  FreeAndNil(FDatasetConsulta);
end;

procedure TfrmRelCtpLogAcompDuplicNovo.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  Case Key Of
    VK_ESCAPE:Begin
                If Assigned(FDatasetConsulta) Then
                Begin
                  If Not FDatasetConsulta.Active Then
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

procedure TfrmRelCtpLogAcompDuplicNovo.FormShow(Sender: TObject);
begin
  inherited;
  intCor    := StrToIntDef(fCfgSis('CORZEB'), clWhite);

  If fEmptyStr(mskDtaIni.Text) then
    mskDtaIni.Text := DateToStr(VS_Date);

  If fEmptyStr(mskDtaFin.Text) then
    mskDtaFin.Text := DateToStr(VS_Date);

  fValidaCampos(edtCodOpe,False);
  fValidaCampos(edtCodEmpresa,False);
  fValidaCampos(edtCodFornecedor,False);

  pSetFocus(edtNumDoc);
  edtNumDoc.MaxLength := fTamDocCadPag;
  edtNumDoc.TamCampo  := edtNumDoc.MaxLength;

  if blnVeioManutencao then
  Begin
    pSetFocus(dbgConsulta);
    pnlHeader.Visible := False;
    lblCampoAlterados2.Visible := True;
    Shp_inferior.Visible := True;
    btnPadraoClick(Sender);
  end;

  If blnVeioAgrupamento Then
  begin
    dbgConsultaDBTableView1CTP_NUMAGR.Visible := True;
    dbgConsultaDBTableView1CTP_NUMAGR.GroupIndex := 0;
    Label6.Visible := False;
    edtSerie.Visible := False;
    Label3.Visible := False;
    edtParcel.Visible := False;
    pnlOperador.Visible := True;
    pOcultarColunas;
    btnAcompLogCtpDet.Visible := False;
  end;

  If blnVeioCtpReprogVen Then
  begin
    dbgConsultaDBTableView1CTP_OPELOG.Visible := True;  //CODOPE , OPEBAI , CODVEN , OPELOG
    dbgConsultaDBTableView1CTP_OPELOG.GroupIndex := 0;

    dbgConsultaDBTableView1CTP_DTALOG.Visible := True;
    dbgConsultaDBTableView1CTP_DTALOG.GroupIndex := 1;  // * DTAVEN * ou * DTALOG *
    dbgConsultaDBTableView1Duplicata.GroupIndex := -1;

    Label6.Visible := False;
    edtSerie.Visible := False;
    Label3.Visible := False;
    edtParcel.Visible := False;
    pnlOperador.Visible := True;

    btnAcompLogCtpDet.Visible := False;
    Label1.Visible := False;
    edtCodEmpresa.Visible := False;
    edtDesEmpresa.Visible := False;
    pnlHeader.height:=98;

    rdgData.Visible := True;
    rdgData.items[0]:= 'Vencimento';
    rdgData.items[1]:= 'Alteração';

    pOcultarColunas;
  end;

  If blnVeioAtribPortador Then
  Begin
    Label6.Visible := False;
    edtSerie.Visible := False;
    Label3.Visible := False;
    edtParcel.Visible := False;
    pnlOperador.Visible := True;
    pOcultarColunas;
    btnAcompLogCtpDet.Visible := False;
    rdgData.Visible := True;
  End;


end;

function TfrmRelCtpLogAcompDuplicNovo.fSetParametros(var ADataset: TUniQuery): Boolean;
begin
  Try
    if Not blnVeioManutencao then
    begin
      ADataset.ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
      ADataset.ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);
    end;

    If (Not fEmptyStr(edtCodEmpresa.Text) or Not blnVeioCtpReprogVen) Then
      ADataset.ParamByName('CODEMP').AsString := edtCodEmpresa.Text;

    If Not fEmptyStr(edtCodFornecedor.Text) Then
      ADataset.ParamByName('CODFOR').AsString := edtCodFornecedor.Text;

    If Not fEmptyStr(edtNumDoc.Text) Then
      ADataset.ParamByName('NUMDUP').AsString := edtNumDoc.Text;

    If Not fEmptyStr(edtSerie.Text) Then
      ADataset.ParamByName('SERIE_').AsString := edtSerie.Text;

    If Not fEmptyStr(edtParcel.Text) Then
      ADataset.ParamByName('PARCEL').AsString := edtParcel.Text;

    If Not fEmptyStr(edtCodOpe.Text) and blnVeioCtpReprogVen Then
      ADataset.ParamByName('OPELOG').AsString := edtCodOpe.Text;

    Result := True;
  Except
    Result := False;
  End;
end;

function TfrmRelCtpLogAcompDuplicNovo.fSetParametrosAG(var ADataset: TUniQuery): Boolean;
begin
  Try
    ADataset.ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
    ADataset.ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);

    If (Not fEmptyStr(edtCodFornecedor.Text)) Then
      ADataset.ParamByName('CODFOR').AsString := edtCodFornecedor.Text;

    If Not fEmptyStr(edtCodEmpresa.Text) and Not blnVeioCtpReprogVen Then
      ADataset.ParamByName('CODEMP').AsString := edtCodEmpresa.Text;

    If Not fEmptyStr(edtNumDoc.Text) Then
      ADataset.ParamByName('NUMAGR').AsString := edtNumDoc.Text;

    If Not fEmptyStr(edtCodOpe.Text) Then
      ADataset.ParamByName('OPELOG').AsString := edtCodOpe.Text;

    Result := True;
  Except
    Result := False;
  End;
end;

function TfrmRelCtpLogAcompDuplicNovo.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If (Sender = mskDtaFin) Then
        Begin
          If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
          Begin
            fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
            Result := False;
          End
          Else
          Begin
            If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
            Begin
              fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
              Result := False;
            End;
          End;
        End
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

      If fEmptyStr(edtCodEmpresa.Text) or Not blnVeioCtpReprogVen Then
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


  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmRelCtpLogAcompDuplicNovo.pDefineAlteracoes;
var
  arrRef: Array of String;
  strDupAtual: String;
  strCamposDif: String;
  intIndex: Integer;
begin
  {**************************************************************************}
  {********** ESSE COMANDO FAZ A MESMA FUNÇÃO DO DISABLECONTROLS, ***********}
  {* SÓ QUE O DISABLECONTROLS NESSE CASO NÃO É VIÁVEL POR CAUSA DOS GRUPOS. *}
  {* PRECISO QUE QUANDO CARREGUE AS INFORMAÇÕES OS GRUPOS FIQUEM ABERTOS E **}
  {************ O USANDO O DISABLECONTROLS ELES FICAM FECHADOS. *************}
  {***********************************************************************MO*}
  If blnVeioAtribPortador Then
    FDatasetConsulta.DisableControls
  Else
    dbgConsulta.BeginUpdate;

  SetLength(arrRef, FDatasetConsulta.Fields.Count);

  FDatasetConsulta.First;
  strDupAtual := '';

  While not FDatasetConsulta.Eof Do
  Begin
    If (strDupAtual <> FDatasetConsulta.FieldByName('DUPLIC').AsString) Then
    Begin
      strDupAtual := FDatasetConsulta.FieldByName('DUPLIC').AsString;
      for intIndex := 0 to FDatasetConsulta.Fields.Count - 1 do
        arrRef[intIndex] := FDatasetConsulta.Fields[intIndex].AsString;
    End
    Else
    Begin
      strCamposDif := '/';
      for intIndex := 0 to FDatasetConsulta.Fields.Count - 1 do
      Begin
        If (arrRef[intIndex] <> FDatasetConsulta.Fields[intIndex].AsString) And
           (Not MatchStr(FDatasetConsulta.Fields[intIndex].FieldName, ['AUTOINCREM', 'CTP_DTALOG', 'CTP_HORLOG', 'CTP_DESCRI', 'CTP_NOMFRM', 'CTP_OPELOG'])) Then
          strCamposDif := strCamposDif + FDatasetConsulta.Fields[intIndex].FieldName + '/';
      End;

      FDatasetConsulta.Edit;
      FDatasetConsulta.FieldByName('ALTERACOES').AsString := strCamposDif;
      FDatasetConsulta.Post;

      for intIndex := 0 to FDatasetConsulta.Fields.Count - 1 do
        arrRef[intIndex] := FDatasetConsulta.Fields[intIndex].AsString;
    End;

    FDatasetConsulta.Next;
  End;

  If blnVeioAtribPortador Then
  Begin
    FDatasetConsulta.Filtered := False;
    FDatasetConsulta.Filter   := 'CTP_NOMFRM = ' + QuotedStr('frmCtpAtribPortador');
    FDatasetConsulta.Filtered := True;

    dbgConsultaDBTableView1CTP_DTALOG.GroupIndex := -1;
    dbgConsultaDBTableView1CTP_DTACAD.GroupIndex := -1;

    If rdgData.ItemIndex = 0 Then
    Begin
      dbgConsultaDBTableView1CTP_OPELOG.GroupIndex := 0;
      dbgConsultaDBTableView1CTP_DTACAD.GroupIndex := 1;
      dbgConsultaDBTableView1Duplicata.GroupIndex  := 2;
    End
    Else
    Begin
      dbgConsultaDBTableView1CTP_OPELOG.GroupIndex := 0;
      dbgConsultaDBTableView1CTP_DTALOG.GroupIndex := 1;
      dbgConsultaDBTableView1Duplicata.GroupIndex  := 2;
    End;

    FDatasetConsulta.EnableControls;
    FDatasetConsulta.First;
  End
  Else
  Begin
    dbgConsulta.EndUpdate;
    FDatasetConsulta.First;
  End;
end;

procedure TfrmRelCtpLogAcompDuplicNovo.pFechaConsulta;
begin
  FDatasetConsulta.Close;

  mskDtaIni.Clear;
  mskDtaFin.Clear;
  edtCodFornecedor.Clear;
  edtNomFornecedor.Clear;
  edtCodEmpresa.Clear;
  edtDesEmpresa.Clear;
  edtNumDoc.Clear;
  edtParcel.Clear;
  btnAcompLogCtpDet.Enabled := False;

  pSetFocus(edtNumDoc);
end;

procedure TfrmRelCtpLogAcompDuplicNovo.pMascaraValor;
  Var
    intIndex: integer;
begin
  If FDatasetConsulta.Active Then
  Begin
    For intIndex := 1 To FDatasetConsulta.Fields.Count - 1 Do
    Begin
      Case FDatasetConsulta.Fields[intIndex].DataType Of
        ftFloat: TFloatField(FDatasetConsulta.Fields[intIndex]).DisplayFormat := fMskDigitos(2);
        ftDate : TFloatField(FDatasetConsulta.Fields[intIndex]).EditMask      := '99/99/9999;1;_';
      End;
    End;
  End;
end;

procedure TfrmRelCtpLogAcompDuplicNovo.pOcultarColunas;
begin
  dbgConsultaDBTableView1CTP_NUMAGR.Visible := False;
  dbgConsultaDBTableView1MotEst.Visible := False;
  dbgConsultaDBTableView1CTP_SEQBAI.Visible := False;
  dbgConsultaDBTableView1CTP_CODVEN.Visible := False;
  dbgConsultaDBTableView1CTP_CODFOR.Visible := False;
  dbgConsultaDBTableView1CTP_CARTAO.Visible := False;
  dbgConsultaDBTableView1CTP_CHQPRE.Visible := False;
  dbgConsultaDBTableView1CTP_CHQAVI.Visible := False;
  dbgConsultaDBTableView1CTP_DINHEI.Visible := False;
  dbgConsultaDBTableView1CTP_RESCAI.Visible := False;
  dbgConsultaDBTableView1CTP_EMPBAI.Visible := False;
  dbgConsultaDBTableView1CTP_CODCTA.Visible := False;
  dbgConsultaDBTableView1CTP_HISBAI.Visible := False;
  dbgConsultaDBTableView1CTP_HIST02.Visible := False;
  dbgConsultaDBTableView1CTP_HIST01.Visible := False;
  dbgConsultaDBTableView1CTP_OUTENT.Visible := False;
  dbgConsultaDBTableView1CTP_CODVEN.Visible := False;
  dbgConsultaDBTableView1CTP_CODEMP.Visible := False;
  dbgConsultaDBTableView1CTP_CODOPE.Visible := False;
  dbgConsultaDBTableView1CTP_OUTENT.Visible := False;
  dbgConsultaDBTableView1CTP_PORBAI.Visible := False;
  dbgConsultaDBTableView1CTP_CTABAI.Visible := False;
  dbgConsultaDBTableView1CTP_OPEBAI.Visible := False;
  dbgConsultaDBTableView1CTP_DTAPAG.Visible := False;
  dbgConsultaDBTableView1CTP_VALPAG.Visible := False;
  dbgConsultaDBTableView1CTP_DTAENV.Visible := False;
  dbgConsultaDBTableView1CTP_EMPBAI.Visible := False;
  dbgConsultaDBTableView1CTP_RESCAI.Visible := False;
  dbgConsultaDBTableView1CTP_DTABAI.Visible := False;
  dbgConsultaDBTableView1CTP_LINDIG.Visible := False;
  dbgConsultaDBTableView1CTP_SEQCON.Visible := False;
  dbgConsultaDBTableView1CTP_VEIOBO.Visible := False;
  dbgConsultaDBTableView1CTP_USACHQ.Visible := False;
  dbgConsultaDBTableView1CTP_VEIONF.Visible := False;
  dbgConsultaDBTableView1CTP_PREVIS.Visible := False;
  dbgConsultaDBTableView1CTP_DEPOSI.Visible := False;

  If blnVeioAtribPortador Then
  Begin
    dbgConsultaDBTableView1CTP_CODCTA.Visible := True;
    dbgConsultaDBTableView1CTP_VEIOBO.Visible := True;
    dbgConsultaDBTableView1CTP_USACHQ.Visible := True;
    dbgConsultaDBTableView1CTP_VEIONF.Visible := True;
    dbgConsultaDBTableView1CTP_PREVIS.Visible := True;
    dbgConsultaDBTableView1CTP_DEPOSI.Visible := True;

    dbgConsultaDBTableView1CTP_OPELOG.Visible := False;
    dbgConsultaDBTableView1CTP_NUMDUP.Visible := False;
    dbgConsultaDBTableView1CTP_PARCEL.Visible := False;
    dbgConsultaDBTableView1CTP_DTACAD.Visible := False;
    dbgConsultaDBTableView1CTP_DTAVEN.Visible := False;
    dbgConsultaDBTableView1CTP_VALDUP.Visible := False;
    dbgConsultaDBTableView1CTP_VALORI.Visible := False;
    dbgConsultaDBTableView1CTP_JURSUJ.Visible := False;
    dbgConsultaDBTableView1CTP_MULSUJ.Visible := False;
    dbgConsultaDBTableView1CTP_DESSUJ.Visible := False;
    dbgConsultaDBTableView1CTP_VALJUR.Visible := False;
    dbgConsultaDBTableView1CTP_VALDES.Visible := False;
  End;
end;

procedure TfrmRelCtpLogAcompDuplicNovo.pSetFilterDefault;
begin
  FDatasetConsulta.Filter := '';
  If FDatasetConsulta.Filtered Then
    FDatasetConsulta.Filtered := FALSE;
end;

function TfrmRelCtpLogAcompDuplicNovo.fAjustaColunas(pgbProgresso: TcxProgressBar): Boolean;
begin
  Application.ProcessMessages;
  dbgConsulta.BeginUpdate;
  Try
    If (Assigned(dtsConsulta.DataSet) and (Not dtsConsulta.DataSet.IsEmpty)) Then
      dbgConsultaDBTableView1.ApplyBestFit;
  Finally
    dbgConsulta.EndUpdate;
  End;

  frmGravando.lblGravando.Caption := 'Ajustando pesquisa...';
  Application.ProcessMessages;

  Result := True;
end;

function TfrmRelCtpLogAcompDuplicNovo.fCarregaCampos(
  pgbProgresso: TcxProgressBar): Boolean;
begin
  Application.ProcessMessages;
  dbgConsulta.BeginUpdate;
  Try
    dbgConsultaDBTableView1.ApplyBestFit();
  Finally
    dbgConsulta.EndUpdate;
  End;
  Application.ProcessMessages;
  fAbreConsulta;
  Application.ProcessMessages;
  pSetFocus(dbgConsulta);
  Result := True;
end;

procedure TfrmRelCtpLogAcompDuplicNovo.pAjustaColunas;
begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.pgbStatus.Visible   := False;
    frmGravando.blnDesabilitaMouse  := True;
    frmGravando.lblGravando.Caption := 'Ajustando tamanho das colunas...';
    frmGravando.fExecutarAcao := fAjustaColunas;
    frmGravando.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmConsultaCxGridNova.pAjustaColunas]');
    End;
  End;

  pFreeAndNil(frmGravando);
end;

procedure TfrmRelCtpLogAcompDuplicNovo.pCarregaCampos;
begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.pgbStatus.Visible   := False;
    frmGravando.blnDesabilitaMouse  := True;
    frmGravando.lblGravando.Caption := 'Carregando Campos...';
    frmGravando.fExecutarAcao := fCarregaCampos;
    frmGravando.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmRelCtrLogAcompDuplicNovo.pCarregaCampos]');
  End;
  pFreeAndNil(frmGravando);
end;

function TfrmRelCtpLogAcompDuplicNovo.fGeraCSV(cxProgress: TcxProgressBar): Boolean;
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
  cxProgress.Properties.Max := FDatasetConsulta.RecordCount;

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

      With FDatasetConsulta Do
      Begin
        First;

        strLinha := 'DATA LOG.;HORA LOG.;DESCRIÇÃO;NOME DO FORMULÁRIO;CÓD. OPERADOR LOG;NUM DOC;PARCELA;' +
                    'CÓD. FORNECEDOR;CÓD. EMPRESA;SEQ. BAIXA;CÓD. VENDEDOR;CÓD. DIGITADOR;CÓD. PORTADOR;DATA CADASTRO;' +
                    'VENCIMENTO;VALOR;VALOR ORIGINAL;JUROS SUGERIDOS;MULTA SUGERIDA;DESCONTO SUGERIDOS;HISTÓRICO 1;HISTÓRICO 2;'+
                    'PORTADOR DA BAIXA;HISTÓRICO DA BAIXA;PL. CONTAS DA BAIXA;OPE. BAIXA;DATA DE PAG.;VALOR PAG.;'+
                    'VALOR JUROS;VALOR DESC.;ENVIO BANCO;DATA ENVIO;CÓD. CENTRO DE CUSTOS;'+
                    'CÓD. PL. CONTAS;CÓD. EMP. BAIXA;CÓD. REP.;ORIGEM BAIXA DOC;DATA DA BAIXA;REC. DINHEIRO;'+
                    'REC. CHEQUE AVI.;REC. CHEQUE PRÉ;REC. CARTÃO;SEQUENCIAL DA BAIXA;'+
                    'LINHA DIGITÁVEL;MOTIVO ESTORNO;NOME EXE;DATA DO EXE;HORA EXE;VERSÃO EXE';

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
                      FieldByName('CTP_CODOPE').AsString + ';' +
                      FieldByName('CTP_CODPOR').AsString + ';' +
                      IfThen(FieldByName('CTP_DTACAD').Value <= 0, '', FormatDateTime('dd/mm/yyyy', FieldByName('CTP_DTACAD').AsDateTime)) + ';' +
                      IfThen(FieldByName('CTP_DTAVEN').Value <= 0, '', FormatDateTime('dd/mm/yyyy', FieldByName('CTP_DTAVEN').AsDateTime)) + ';' +
                      FormatFloat('#,##0.00',FieldByName('CTP_VALDUP').AsFloat) + ';' +
                      FormatFloat('#,##0.00',FieldByName('CTP_VALORI').AsFloat) + ';' +
                      FormatFloat('#,##0.00',FieldByName('CTP_JURSUJ').AsFloat) + ';' +
                      FormatFloat('#,##0.00',FieldByName('CTP_MULSUJ').AsFloat) + ';' +
                      FormatFloat('#,##0.00',FieldByName('CTP_DESSUJ').AsFloat) + ';' +
                      ReplaceStr((ReplaceStr(FieldByName('CTP_HIST01').AsString, '<<csq>>', ' ')), #13#10, ' ') + ';' +
                      ReplaceStr((ReplaceStr(FieldByName('CTP_HIST02').AsString, '<<csq>>', ' ')), #13#10, ' ') + ';' +
                      FieldByName('CTP_PORBAI').AsString + ';' +
                      ReplaceStr((ReplaceStr(FieldByName('CTP_HISBAI').AsString, '<<csq>>', ' ')), #13#10, ' ') + ';' +
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
                      FieldByName('CTP_OPEBAI').AsString + ';' +
                      IntToStr(FieldByName('CTP_RESCAI').AsInteger) + ';' +
                      IfThen(FieldByName('CTP_DTABAI').Value <= 0, '', FormatDateTime('dd/mm/yyyy', FieldByName('CTP_DTABAI').AsDateTime)) + ';' +
                      FormatFloat('#,##0.00', FieldByName('CTP_DINHEI').AsFloat) + ';' +
                      FormatFloat('#,##0.00', FieldByName('CTP_CHQAVI').AsFloat) + ';' +
                      FormatFloat('#,##0.00', FieldByName('CTP_CHQPRE').AsFloat) + ';' +
                      FormatFloat('#,##0.00', FieldByName('CTP_CARTAO').AsFloat) + ';' +
                      IntToStr(FieldByName('CTP_SEQCON').AsInteger) + ';' +
                      FieldByName('CTP_LINDIG').AsString+ ';' +
                      FieldByName('MOTEST').AsString+';'+
                      FieldByName('CTP_NOMEXE').AsString+';'+
                      IfThen(FieldByName('CTP_DTAEXE').Value <= 0, '', FormatDateTime('dd/mm/yyyy', FieldByName('CTP_DTAEXE').AsDateTime)) + ';' +
                      IfThen(FieldByName('CTP_HOREXE').Value <= 0, '', FormatDateTime('HH:mm:ss', FieldByName('CTP_HOREXE').AsDateTime)) + ';' +
                      FieldByName('CTP_VEREXE').AsString;

          stlCsv.Add(strLinha);
          pStepStatusGravacao;

          Next;
        End;
      End;

      stlCsv.SaveToFile(strNomArq);
      FreeAndNil(stlCsv);

      fMensagem('','Arquivo CSV gerado com sucesso!!', ['&O K']);
    End;
  End;

  FreeAndNil(svdCsv);
end;

function TfrmRelCtpLogAcompDuplicNovo.MouseShowCursor(const Show: boolean): boolean;
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


end.
