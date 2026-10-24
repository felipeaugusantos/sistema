unit untRelCtrLogAcompDuplicNovo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Mask, MaskEditFocus, StdCtrls, EditFocus, AppEvnts, Menus,
  Buttons, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  UniDataSetProvider,   Uni, BitBtnLockedIncrem, cxGrid, UniClientDataSet, StrUtils,
  cxLookAndFeels, cxLookAndFeelPainters, System.DateUtils,
  cxNavigator, frxClass, frxExportCSVTestabilidade, System.UITypes,
  cxProgressBar, untClassPanelCx, System.ImageList,
  Vcl.ImgList, Datasnap.Provider, DBAccess, Datasnap.DBClient, untTypesSistema, untIFuncoes, untGravando,
  cxContainer, Vcl.ComCtrls, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxImageList;

type
  TfrmRelCtrLogAcompDuplicNovo = class(TfrmPai)
    pnlHeader: TPanel;
    Label12: TLabel;
    Label1: TLabel;
    Label27: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    edtCodCliente: TEditFocus;
    edtNomCliente: TEditFocus;
    edtNumDoc: TEditFocus;
    edtParcel: TEditFocus;
    edtEspecie: TEditFocus;
    dbgConsultaDBTableView1: TcxGridDBTableView;
    dbgConsultaLevel1: TcxGridLevel;
    dbgConsulta: TcxGrid;
    dbgConsultaDBTableView1CTR_NUMDUP: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_PARCEL: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_SEQBAI: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_ESPDOC: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_CODCLI: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_CODEMP: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_CODVEN: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_CODDIG: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_CODPOR: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_DTACAD: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_DTAVEN: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_VALDUP: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_VALORI: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_HIST01: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_HIST02: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_PORBAI: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_HISBAI: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_CTABAI: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_OPEBAI: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_DTAREC: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_VALREC: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_VALJUR: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_VALDES: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_NOSNUM: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_DTABOL: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_BCOBOL: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_BCOENV: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_DTAENV: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_CODEVE: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_DTALOG: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_HORLOG: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_DESCRI: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_NOMFRM: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_CODCTA: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_OPELOG: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_EMPBAI: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_CODREP: TcxGridDBColumn;
    cxsrConsulta: TcxStyleRepository;
    dbgConsultaDBTableView1Duplicata: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_DESCOB: TcxGridDBColumn;
    dbgConsultaDBTableView1Alteracoes: TcxGridDBColumn;
    GroupBox1: TGroupBox;
    Shape1: TShape;
    Label2: TLabel;
    btnGeraCSV: TBitBtnLocked;
    cxImageList: TcxImageList;
    dspConsulta: TUniDataSetProvider;
    btnConsultar: TBitBtnLocked;
    dbgConsultaDBTableView1CTR_RESCAI: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_DTABAI: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_DINHEI: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_CHQAVI: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_CHQPRE: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_CARTAO: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_SEQCON: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_CARTEI: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_PERMOR: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_PERMUL: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_JURSUJ: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_DESSUJ: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_LINDIG: TcxGridDBColumn;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    Shp_inferior: TShape;
    lblCampoAlterados2: TLabel;
    dbgConsultaDBTableView1MotEst: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_DESCON: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_DIFORI: TcxGridDBColumn;
    rdgData: TRadioGroup;
    dbgConsultaDBTableView1CTR_NUMAGR: TcxGridDBColumn;
    Label8: TLabel;
    dbgConsultaDBTableView1CTR_NOMEXE: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_DTAEXE: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_HOREXE: TcxGridDBColumn;
    dbgConsultaDBTableView1CTR_VEREXE: TcxGridDBColumn;
    Label7: TLabel;
    edtCodOpe: TEditFocus;
    edtNomeOpe: TEditFocus;
    dbgConsultaDBTableView1ENV_EMADES: TcxGridDBColumn;
    dbgConsultaDBTableView1ENV_EMAREM: TcxGridDBColumn;
    chkDupExc: TCheckBox;
    gpbRegcomAlteracao: TGroupBox;
    chkRegComAlteracao: TCheckBox;
    cmbInfRegAlterado: TComboBox;
    Label5: TLabel;
    procedure edtCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbgConsultaDBTableView1CustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure dbgConsultaDBTableView1CustomDrawGroupCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableCellViewInfo; var ADone: Boolean);
    procedure btnGeraCSVClick(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure edtCodOpeKeyPress(Sender: TObject; var Key: Char);
    procedure edtNumDocExit(Sender: TObject);
    procedure chkRegComAlteracaoClick(Sender: TObject);
  private
    { Private declarations }
    intCor     : Integer;
    cdsConsulta: TUniClientDataSet;
    dtsConsulta: TDataSource;
    strFiltroCmb : String;

    procedure pFechaConsulta;
    procedure pSetFilterDefault;
    function MascaraValor(cxProgress: TcxProgressBar = Nil): Boolean;
    function fGetSql: String;
    function fGetSqlAG: String;
    function fAbreConsulta(cxProgress: TcxProgressBar = Nil): Boolean;
    function fSetParametros: Boolean;
    function fSetParametrosAG: Boolean;

    function fGeraCSV(cxProgress : TcxProgressBar): Boolean;
    function MouseShowCursor(const Show: boolean): boolean;
    function DefineAlteracoes(cxProgress: TcxProgressBar = Nil): Boolean;
    function fCarregaCampos(pgbProgresso: TcxProgressBar): Boolean;
    procedure pOcultarColunas;
    procedure pStep(pgbStatus: TcxProgressBar);
    function fRetornaListaRegAntesAlteracao(cdsGen: TDataSet): String;
    procedure pVerificaAplicaFiltroRegComAlteracao;
    function fRetornaAdicaoFiltroRegComAlteracao: String;
    procedure VerificaSeTemRegistros;

    function DuplicataDeveValidarAlteracoesAnteriores(var LAlteracaoAnterior: TUniClientDataset): Boolean;
  public
    { Public declarations }
    blnVeioManutencao: Boolean;
    blnVeioDescontada: Boolean;
    blnVeioAgrupamento: Boolean;
    blnVeioCtrReprogVen: Boolean;
    qryConsulta: TUniQuery;

    procedure pCarregaCampos;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;


implementation

uses untConsultas, untFuncoesSimples;

{$R *.dfm}

procedure TfrmRelCtrLogAcompDuplicNovo.btnConsultarClick(Sender: TObject);
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
      VerificaSeTemRegistros();
    Finally
      FreeAndNil(frmAguarde);
    End;
  Except
    On E : Exception Do
      pMensagensErro(E.Message, 'untRelCtrLogAcompDplicNovo.fAbreConsulta');
  End;
end;

procedure TfrmRelCtrLogAcompDuplicNovo.btnGeraCSVClick(Sender: TObject);
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

Procedure TfrmRelCtrLogAcompDuplicNovo.VerificaSeTemRegistros();
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

procedure TfrmRelCtrLogAcompDuplicNovo.chkRegComAlteracaoClick(Sender: TObject);
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

procedure TfrmRelCtrLogAcompDuplicNovo.dbgConsultaDBTableView1CustomDrawCell(
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

procedure TfrmRelCtrLogAcompDuplicNovo.dbgConsultaDBTableView1CustomDrawGroupCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableCellViewInfo; var ADone: Boolean);
begin
  inherited;
  ACanvas.Brush.Color := clSkyBlue;
  ACanvas.Font.Style := ACanvas.Font.Style + [fsBold];
end;

procedure TfrmRelCtrLogAcompDuplicNovo.edtCodClienteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCliente, edtNomCliente, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCliente, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtrLogAcompDuplicNovo.edtCodEmpresaKeyPress(Sender: TObject;
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

procedure TfrmRelCtrLogAcompDuplicNovo.edtCodOpeKeyPress(Sender: TObject;
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

procedure TfrmRelCtrLogAcompDuplicNovo.edtNumDocExit(Sender: TObject);
begin
  inherited;
  If (Not fEmptyStr(edtNumDoc.Text)) And (length(edtNumDoc.Text) < 12) Then
     edtNumDoc.Text := fStrZero(edtNumDoc.Text, 12);
  If Not fEmptyStr(edtNumDoc.Text) Then
  Begin
     mskdtaIni.Clear;
     mskdtaFin.Clear;
  End;
end;

function TfrmRelCtrLogAcompDuplicNovo.fAbreConsulta(cxProgress: TcxProgressBar): Boolean;
  Var
    LSql : String;
    LSetParams : Boolean;
begin

  Result := False;
  cdsConsulta.Close;
  dspConsulta.DataSet := qryConsulta;
  cdsConsulta.SetProvider(dspConsulta);
  LSql := IIF(blnVeioAgrupamento,fGetSqlAG,fGetSql);

  Try
    qryConsulta.Close;
    qryConsulta.Sql.Clear;
    qryConsulta.Sql.Add(LSql);
    LSetParams := IIF(blnVeioAgrupamento,fSetParametrosAG,fSetParametros);
    If Not LSetParams Then Exit(False);
    qryConsulta.Open;

    If Not qryConsulta.IsEmpty Then
    Begin
      pSetaClient(qryConsulta);
      cdsConsulta.DisableControls;
      cdsConsulta.Open;
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

      pSetFocus(dbgConsulta);
      cdsConsulta.EnableControls;
      Result := True;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[TfrmRelCtrLogAcompDuplicNovo.fAbreConsulta]');
      Result := False;
    End;
  End;

  blnMudarFoco := False;
  cdsConsulta.SetProvider(nil);

end;

function TfrmRelCtrLogAcompDuplicNovo.fGetSql: String;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT LOGCTR.*, ';
  strSQL := strSQL + '  REPLACE(IFNULL(CTR_HIST01, ""), "<<csq>>" , " ") AS HIST01, ';
  strSQL := strSQL + '  REPLACE(IFNULL(CTR_HIST02, ""), "<<csq>>" , " ") AS HIST02, ';
  strSQL := strSQL + '  REPLACE(IFNULL(CTR_HISBAI, ""), "<<csq>>" , " ") AS HISBAI, ';
  strSQL := strSQL + '  CONCAT(CTR_NUMDUP, "-", CTR_PARCEL, "-", CTR_ESPDOC, "-", CTR_CODCLI, "-", CTR_CODEMP, "-", CLI_NOMCLI) AS DUPLIC, ';
  strSQL := strSQL + '  CADOCO.OCO_DESOCO AS MOTEST, ';
  strSQL := strSQL + '  CTR_ALTLOG AS ALTERACOES, ';
  strSQL := strSQL + '  ENV_EMADES, ';
  strSQL := strSQL + '  ENV_EMAREM, ';
  strSQL := strSQL + '  "0000" AS CONTADOR, '; //Implementado para sempre gravar o contador, para que possa pegar o anterior qdo usar o filtro do combobox;
  strSQL := strSQL + '  "0000" AS CONT_ANTERIOR '; //Implementado para gravar o nmero referente ao registro anterior;
  strSQL := strSQL + ' FROM LOGCTR    ';
  strSQL := strSQL + ' LEFT JOIN CADOCO ON CTR_MOTEST = OCO_CODOCO ';
  strSQL := strSQL + ' LEFT JOIN CADCLI ON CLI_CODCLI = CTR_CODCLI   ';
  strSQL := strSQL + ' LEFT JOIN DUPEMA ON DUPEMA.DUP_INCDUP = LOGCTR.AUTOINCREM ';
  strSQL := strSQL + ' LEFT JOIN EMAENV ON EMAENV.AUTOINCREM = DUPEMA.DUP_SEQENV ';

  if Not blnVeioManutencao then
  begin
    If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
    Begin
      If rdgData.ItemIndex = 0 Then
      Begin
        strSQL := strSQL + ' WHERE    ';
        strSQL := strSQL + '   CTR_DTACAD BETWEEN :DTAINI AND :DTAFIN ';
      End
      Else
      Begin
        strSQL := strSQL + ' WHERE    ';
        strSQL := strSQL + '   CTR_DTALOG BETWEEN :DTAINI AND :DTAFIN ';
      End;
    End
    Else
      strSQL := strSQL + ' WHERE TRUE ';
  end
  else
    strSQL := strSQL + ' WHERE TRUE ';

  If Not fEmptyStr(edtCodEmpresa.Text) Then
    strSQL := strSQL + '  AND CTR_CODEMP = :CODEMP ';

  If Not fEmptyStr(edtCodCliente.Text) Then
    strSQL := strSQL + '  AND CTR_CODCLI = :CODCLI ';

  If Not fEmptyStr(edtNumDoc.Text) Then
    strSQL := strSQL + '  AND CTR_NUMDUP = :NUMDUP ';

  If Not fEmptyStr(edtParcel.Text) Then
    strSQL := strSQL + '  AND CTR_PARCEL = :PARCEL ';

  If Not fEmptyStr(edtEspecie.Text) Then
    strSQL := strSQL + '  AND CTR_ESPDOC = :ESPDOC ';

  If Not(fEmptyStr(edtCodOpe.Text)) Then
    strSQL := strSQL +'  AND CTR_OPELOG = :OPELOG';

  If chkDupExc.Checked Then
    strSQL := strSQL +'  AND CTR_DESCRI LIKE "%EXCLUSÃO%" ';

  strSQL := strSQL + ' AND CTR_DESCRI NOT IN ("TENTATIVA ENVIO AUTOMÁTICO DE E-MAIL DUP BAIXADA", "TENTATIVA ENVIO AUTOMÁTICO DE E-MAIL DUP BAIXADA LD") ';

  strSQL := strSQL + ' GROUP BY LOGCTR.AUTOINCREM ';

  strSQL := strSQL + ' ORDER BY DUPLIC, CTR_DTALOG, CTR_HORLOG ';

  Result := strSQL;

end;

function TfrmRelCtrLogAcompDuplicNovo.fGetSqlAG: String;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT A.*, ';
  strSQL := strSQL + ' CONCAT (CTR_NUMAGR,"-",C.CTR_CODEMP,"-(",C.CTR_CODVEN,"-",OPE_NOMOPE,")") AS AGRUP , ';
  strSQL := strSQL + '  REPLACE(IFNULL(A.CTR_HIST01, ""), "<<csq>>" , " ") AS HIST01, ';
  strSQL := strSQL + '  REPLACE(IFNULL(A.CTR_HIST02, ""), "<<csq>>" , " ") AS HIST02, ';
  strSQL := strSQL + '  REPLACE(IFNULL(A.CTR_HISBAI, ""), "<<csq>>" , " ") AS HISBAI, ';
  strSQL := strSQL + '  CONCAT(A.CTR_NUMDUP, "-", A.CTR_PARCEL, "-", A.CTR_ESPDOC, "-", A.CTR_CODCLI, "-", A.CTR_CODEMP, "-", CLI_NOMCLI) AS DUPLIC, ';
  strSQL := strSQL + '  CADOCO.OCO_DESOCO AS MOTEST, ';
  strSQL := strSQL + '  CTR_ALTLOG AS  ALTERACOES, ';
  strSQL := strSQL + '  ENV_EMADES, ';
  strSQL := strSQL + '  ENV_EMAREM, ';
  strSQL := strSQL + '  "0000" AS CONTADOR, '; //Implementado para sempre gravar o contador, para que possa pegar o anterior qdo usar o filtro do combobox;
  strSQL := strSQL + '  "0000" AS CONT_ANTERIOR '; //Implementado para gravar o nmero referente ao registro anterior;
  strSQL := strSQL + ' FROM LOGCTR A    ';
  strSQL := strSQL + ' LEFT JOIN CADOCO ON A.CTR_MOTEST = OCO_CODOCO     ';
  strSQL := strSQL + ' LEFT JOIN CADCLI ON CLI_CODCLI = A.CTR_CODCLI   ';
  strSQL := strSQL + ' INNER JOIN DUPAGR B ON A.CTR_NUMDUP = B.CTR_NUMDUP  ' ;
  strSQL := strSQL + '                    AND A.CTR_PARCEL = B.CTR_PARCEL  ' +
                     '                    AND A.CTR_ESPDOC = B.CTR_ESPDOC  ' +
                     '                    AND A.CTR_CODCLI = B.CTR_CODCLI  ' ;
  strSQL := strSQL + ' INNER JOIN CADREC C ON C.CTR_NUMDUP = B.CTR_NUMAGR   ' ;
  strSQL := strSQL + ' AND C.CTR_CODCLI = B.CTR_CODCLI  ' ;
  strSQL := strSQL + ' INNER JOIN CADOPE  ON OPE_CODOPE = C.CTR_CODVEN     ' ;
  strSQL := strSQL + ' LEFT JOIN DUPEMA ON DUPEMA.DUP_INCDUP = A.AUTOINCREM ';
  strSQL := strSQL + ' LEFT JOIN EMAENV ON EMAENV.AUTOINCREM = DUPEMA.DUP_SEQENV ';
  strSQL := strSQL + ' WHERE TRUE ';
  //strSQL := strSQL + ' C.CTR_DTACAD BETWEEN :DTAINI AND :DTAFIN ';

  If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
     strSQL := strSQL + ' AND C.CTR_DTACAD BETWEEN :DTAINI AND :DTAFIN ';

  If Not fEmptyStr(edtCodEmpresa.Text) Then
    strSQL := strSQL + '  AND C.CTR_CODEMP = :CODEMP ';

  If Not fEmptyStr(edtCodCliente.Text) Then
    strSQL := strSQL + '  AND C.CTR_CODCLI = :CODCLI ';

  If Not fEmptyStr(edtNumDoc.Text) Then
    strSQL := strSQL + '  AND B.CTR_NUMAGR = :NUMAGR ';

  If Not(fEmptyStr(edtCodOpe.Text)) Then
    strSQL := strSQL +'  AND C.CTR_CODVEN = :OPELOG';

  If chkDupExc.Checked Then
    strSQL := strSQL +'  AND C.CTR_DESCRI LIKE "EXCLUSÃO" ';

  strSQL := strSQL + ' GROUP BY  A.CTR_DTALOG, A.CTR_HORLOG,B.CTR_NUMDUP,B.CTR_PARCEL,B.CTR_ESPDOC,B.CTR_CODCLI ';
  strSQL := strSQL + ' ORDER BY DUPLIC, A.CTR_DTALOG, A.CTR_HORLOG ';
  Result := strSQL;
end;

procedure TfrmRelCtrLogAcompDuplicNovo.FormCreate(Sender: TObject);
begin
  inherited;
  qryConsulta := fCriaQuery(Nil);
  WindowState:= wsMaximized;

  edtNumDoc.MaxLength := fTamDocCadRec;
  edtNumDoc.TamCampo  := edtNumDoc.MaxLength;

  cdsConsulta := TUniClientDataSet.Create(Self);
  dtsConsulta := fCriaDataSource(cdsConsulta);
  dbgConsultaDBTableView1.DataController.DataSource := dtsConsulta;
end;

procedure TfrmRelCtrLogAcompDuplicNovo.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryConsulta);

  If Assigned(dtsConsulta) Then
    FreeAndNil(dtsConsulta);

  If Assigned(cdsConsulta) Then
    FreeAndNil(cdsConsulta);
end;

procedure TfrmRelCtrLogAcompDuplicNovo.FormKeyDown(Sender: TObject;
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

procedure TfrmRelCtrLogAcompDuplicNovo.FormShow(Sender: TObject);
begin
  inherited;
  intCor    := StrToIntDef(fCfgSis('CORZEB'), clWhite);
  mskDtaIni.Text := DateToStr(VS_Date);
  mskDtaFin.Text := DateToStr(VS_Date);
  fValidaCampos(edtCodOpe,False);
  fValidaCampos(edtCodEmpresa,False);
  fValidaCampos(edtCodCliente,False);
  edtNumDoc.MaxLength := fTamDocCadRec;
  edtNumDoc.TamCampo  := edtNumDoc.MaxLength;
  cmbinfRegAlterado.enabled := False;

  if blnVeioManutencao then
  Begin
    pSetFocus(dbgConsulta);
    pnlHeader.Visible := False;
    GroupBox1.Visible := False;
    lblCampoAlterados2.Visible := True;
    Shp_inferior.Visible := True;
  end;

  If blnVeioDescontada Then
  Begin
    dbgConsultaDBTableView1CTR_OPELOG.GroupIndex := 0;
    dbgConsultaDBTableView1CTR_DTACAD.GroupIndex := 1;
    pOcultarColunas;
    rdgData.Visible := True;
  End;


  If blnVeioAgrupamento Then
  begin
    dbgConsultaDBTableView1CTR_NUMAGR.Visible := True;
    dbgConsultaDBTableView1CTR_NUMAGR.GroupIndex := 0;
    Label6.Visible := False;
    edtEspecie.Visible := False;
    Label3.Visible := False;
    edtParcel.Visible := False;
    pOcultarColunas;
  end;

  If blnVeioCtrReprogVen Then
  Begin
    pOcultarColunas;
    Label3.Visible := False;
    edtParcel.Visible := False;
    dbgConsultaDBTableView1CTR_DTAVEN.Visible := True;
  End;

  rdgData.Visible := True;
  pSetFocus(edtNumDoc);

end;

function TfrmRelCtrLogAcompDuplicNovo.fSetParametros: Boolean;
begin
  Try
    With qryConsulta Do
    Begin
      if Not blnVeioManutencao then
      begin
        If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
        Begin
          ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
          ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
        End;
      end;

      If (Not fEmptyStr(edtCodEmpresa.Text)) Then
        ParamByName('CODEMP').AsString := edtCodEmpresa.Text;

      If Not fEmptyStr(edtCodCliente.Text) Then
        ParamByName('CODCLI').AsString := edtCodCliente.Text;

      If Not fEmptyStr(edtNumDoc.Text) Then
        ParamByName('NUMDUP').AsString := edtNumDoc.Text;

      If Not fEmptyStr(edtParcel.Text) Then
        ParamByName('PARCEL').AsString := edtParcel.Text;

      If Not fEmptyStr(edtEspecie.Text) Then
        ParamByName('ESPDOC').AsString := edtEspecie.Text;

      If Not fEmptyStr(edtCodOpe.Text) Then
        ParamByName('OPELOG').AsString := edtCodOpe.Text;
    End;

    Result := True;
  Except
    Result := False;
  End;
end;

function TfrmRelCtrLogAcompDuplicNovo.fSetParametrosAG: Boolean;
begin
  Try
    With qryConsulta Do
    Begin

      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
      Begin
         ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
         ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
      End;

      If (Not fEmptyStr(edtCodEmpresa.Text)) Then
        ParamByName('CODEMP').AsString := edtCodEmpresa.Text;

      If Not fEmptyStr(edtCodCliente.Text) Then
        ParamByName('CODCLI').AsString := edtCodCliente.Text;

      If Not fEmptyStr(edtNumDoc.Text) Then
        ParamByName('NUMAGR').AsString := edtNumDoc.Text;

      If Not fEmptyStr(edtCodOpe.Text) Then
        ParamByName('OPELOG').AsString := edtCodOpe.Text;
    End;
    Result := True;
  Except
    Result := False;
  End;
end;

function TfrmRelCtrLogAcompDuplicNovo.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) And (fEmptyStr(edtNumDoc.Text)) Then
      Begin
        fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If (Sender = mskDtaFin) Then
        Begin
          If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) And (fEmptyStr(edtNumDoc.Text)) Then
          Begin
            fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
            Result := False;
          End
          Else
          Begin

            If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
            Begin
               If (StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text)) Then
               Begin
                 fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
                 Result := False;
               End;
            End;

          End;
        End
      End;

    End
    Else If (Sender = edtCodCliente) Then
    Begin

      If fEmptyStr(edtCodCliente.Text) Then
      Begin
        edtNomCliente.Text := 'TODOS';
      End Else
      Begin
        edtNomCliente.Text := fRetNomCliente(edtCodCliente.Text);
        If fEmptyStr(edtNomCliente.Text) Then
        Begin
          Result := False;
          pMensagemOk('Cliente não encontrado!');
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

function TfrmRelCtrLogAcompDuplicNovo.DefineAlteracoes(cxProgress: TcxProgressBar = Nil): Boolean;
var
  arrRef: Array of String;
  strDupAtual: String;
  strCamposDif: String;
  intIndex: Integer;
  icont : Integer;

  LValidarAlteracoes: Boolean;

  LDatasetAnterior: TUniClientDataset;

  Const
    CAMPOS_IGNORAR: Array Of String = ['AUTOINCREM', 'CTR_DTALOG', 'CTR_HORLOG', 'CTR_DESCRI',
                                       'CTR_NOMFRM', 'CTR_OPELOG', 'ENV_EMADES', 'ENV_EMAREM'];
begin
  Result := True;
  {**************************************************************************}
  {********** ESSE COMANDO FAZ A MESMA FUNÇÃO DO DISABLECONTROLS, ***********}
  {* SÓ QUE O DISABLECONTROLS NESSE CASO NÃO É VIÁVEL POR CAUSA DOS GRUPOS. *}
  {* PRECISO QUE QUANDO CARREGUE AS INFORMAÇÕES OS GRUPOS FIQUEM ABERTOS E **}
  {************ O USANDO O DISABLECONTROLS ELES FICAM FECHADOS. *************}
  {***********************************************************************MO*}
  If blnVeioDescontada Or blnVeioCtrReprogVen Then
    cdsConsulta.DisableControls
  Else
    dbgConsulta.BeginUpdate;

  SetLength(arrRef, cdsConsulta.Fields.Count);

  cxProgress.Position := 0;
  cxProgress.Properties.Max := cdsConsulta.RecordCount;
  icont := 0;
  strFiltroCmb := '';

  cdsConsulta.First;
  strDupAtual := '';

  While not cdsConsulta.Eof Do
  Begin

    icont := icont + 1;

    cdsConsulta.Edit;
    cdsConsulta.FieldByName('CONTADOR').AsString := inttostr(icont);
    cdsConsulta.Post;

    If (strDupAtual <> cdsConsulta.FieldByName('DUPLIC').AsString) Then
    Begin
      strDupAtual := cdsConsulta.FieldByName('DUPLIC').AsString;

      LValidarAlteracoes := DuplicataDeveValidarAlteracoesAnteriores(LDatasetAnterior);

      strCamposDif := '/';
      for intIndex := 0 to cdsConsulta.Fields.Count - 1 do
      Begin
        arrRef[intIndex] := cdsConsulta.Fields[intIndex].AsString;

        If Not LValidarAlteracoes Then
          Continue;

        If MatchStr(cdsConsulta.Fields[intIndex].FieldName, CAMPOS_IGNORAR) Then
          Continue;

        If Not arrRef[intIndex].Equals(LDatasetAnterior.Fields[intIndex].AsString) Then
          strCamposDif := strCamposDif + cdsConsulta.Fields[intIndex].FieldName + '/';
      End;

      If Not strCamposDif.Equals('/') Then
      Begin
        cdsConsulta.Edit;
        cdsConsulta.FieldByName('ALTERACOES').AsString := strCamposDif;
        cdsConsulta.Post;
      End;

      If Assigned(LDatasetAnterior) Then
        FreeAndNil(LDatasetAnterior);
    End
    Else
    Begin
      strCamposDif := '/';
      for intIndex := 0 to cdsConsulta.Fields.Count - 1 do
      Begin
        If (arrRef[intIndex] <> cdsConsulta.Fields[intIndex].AsString) And
           (Not MatchStr(cdsConsulta.Fields[intIndex].FieldName, CAMPOS_IGNORAR)) Then
          strCamposDif := strCamposDif + cdsConsulta.Fields[intIndex].FieldName + '/';
      End;

      cdsConsulta.Edit;
      cdsConsulta.FieldByName('ALTERACOES').AsString := strCamposDif;
      cdsConsulta.FieldByName('CONT_ANTERIOR').AsString := inttostr(iCont-1);
      cdsConsulta.Post;

      for intIndex := 0 to cdsConsulta.Fields.Count - 1 do
        arrRef[intIndex] := cdsConsulta.Fields[intIndex].AsString;
    End;
    cdsConsulta.Next;
    pStep(cxProgress);
  End;

  pVerificaAplicaFiltroRegComAlteracao();

  If blnVeioDescontada Then
  Begin
    cdsConsulta.Filtered := False;
    cdsConsulta.Filter   := 'CTR_NOMFRM = ' + QuotedStr('frmCtrDescontada');

    cdsConsulta.Filter := cdsConsulta.Filter + fRetornaAdicaoFiltroRegComAlteracao;

    cdsConsulta.Filtered := True;
    If rdgData.ItemIndex = 0 Then
    Begin
      dbgConsultaDBTableView1CTR_OPELOG.GroupIndex := 0;
      dbgConsultaDBTableView1CTR_DTACAD.GroupIndex := 1;
      dbgConsultaDBTableView1CTR_DTALOG.GroupIndex := -1;
    End
    Else
    Begin
      dbgConsultaDBTableView1CTR_OPELOG.GroupIndex := 0;
      dbgConsultaDBTableView1CTR_DTALOG.GroupIndex := 1;
      dbgConsultaDBTableView1CTR_DTACAD.GroupIndex :=-1;
    End;
    cdsConsulta.EnableControls;
    cdsConsulta.First;
  End
  Else If blnVeioCtrReprogVen Then
  Begin
    cdsConsulta.Filtered := False;
    cdsConsulta.Filter   := 'CTR_NOMFRM = ' + QuotedStr('frmCtrReprogVen');

    cdsConsulta.Filter := cdsConsulta.Filter + fRetornaAdicaoFiltroRegComAlteracao;

    cdsConsulta.Filtered := True;

    cdsConsulta.EnableControls;
    cdsConsulta.First;
  End
  Else
  Begin
    dbgConsulta.EndUpdate;
    cdsConsulta.First;
  End;
end;

function TfrmRelCtrLogAcompDuplicNovo.DuplicataDeveValidarAlteracoesAnteriores(
  var LAlteracaoAnterior: TUniClientDataSet): Boolean;
  Var
    LConsulta: TUniQuery;
begin
  Result := False;

  If Not chkRegComAlteracao.Checked Then
    Exit;

  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := IIF(blnVeioAgrupamento,fGetSqlAG,fGetSql);
    LConsulta.SQL.Text := Copy(LConsulta.SQL.Text, 1, Pos(' WHERE ', LConsulta.SQL.Text));
    LConsulta.SQL.Text := LConsulta.SQL.Text +
                          ' WHERE CTR_NUMDUP=:NUMDUP ' +
                          '  AND CTR_PARCEL=:PARCEL ' +
                          '  AND CTR_ESPDOC=:ESPDOC ' +
                          '  AND CTR_CODEMP=:CODEMP ' +
                          '  AND CTR_CODCLI=:CODCLI ' +
                          '  AND CTR_SEQBAI=:SEQBAI ' +
                          '  AND TIMESTAMP(CTR_DTALOG, CTR_HORLOG)<:HRAALT ' +
                          'GROUP BY LOGCTR.AUTOINCREM ' +
                          'ORDER BY CTR_DTALOG DESC, CTR_HORLOG DESC ' +
                          'LIMIT 1';

    LConsulta.ParamByName('NUMDUP').AsString := cdsConsulta.FieldByName('CTR_NUMDUP').AsString;
    LConsulta.ParamByName('PARCEL').AsString := cdsConsulta.FieldByName('CTR_PARCEL').AsString;
    LConsulta.ParamByName('ESPDOC').AsString := cdsConsulta.FieldByName('CTR_ESPDOC').AsString;
    LConsulta.ParamByName('CODEMP').AsString := cdsConsulta.FieldByName('CTR_CODEMP').AsString;
    LConsulta.ParamByName('CODCLI').AsString := cdsConsulta.FieldByName('CTR_CODCLI').AsString;
    LConsulta.ParamByName('SEQBAI').AsInteger := cdsConsulta.FieldByName('CTR_SEQBAI').AsInteger;
    LConsulta.ParamByName('HRAALT').AsString := FormatDateTime('yyyy/mm/dd hh:mm:ss',
                                                               cdsConsulta.FieldByName('CTR_DTALOG').AsDateTime +
                                                               cdsConsulta.FieldByName('CTR_HORLOG').AsDateTime);

    LConsulta.Open;

    LAlteracaoAnterior := fCriaClientDatSet(LConsulta);
    LAlteracaoAnterior.Open;

    Result := Not LAlteracaoAnterior.IsEmpty;
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
end;

Function TfrmRelCtrLogAcompDuplicNovo.fRetornaAdicaoFiltroRegComAlteracao : String;
Begin

   Result := '';

   If Not fEmptyStr(strFiltroCmb) Then
      Result := ' AND (' + strFiltroCmb + ')';

End;

Procedure TfrmRelCtrLogAcompDuplicNovo.pVerificaAplicaFiltroRegComAlteracao();
 Var
     cmpfiltro : String;
     strListAnteriores : String;
Begin

  If (chkRegComAlteracao.Checked) and (cmbInfRegAlterado.ItemIndex <> -1) Then
  Begin

    cmpfiltro := '';

    Case cmbInfRegAlterado.ItemIndex Of
      0: cmpfiltro := 'CTR_DTAVEN';
      1: cmpfiltro := 'CTR_CODPOR';
      2: cmpfiltro := 'CTR_VALDUP';
    End;

    //FILTER PARA PEGAR APENAS AS ALTERACOES CONFORME O COMBO SELECIONADO.
    cdsConsulta.Filtered  := False;
    cdsConsulta.Filter := ' (ALTERACOES LIKE ''%' + cmpfiltro + '%'') ';
    cdsConsulta.Filtered := True;

    strListAnteriores := fRetornaListaRegAntesAlteracao(cdsConsulta);

    If Not FEmptyStr(strListAnteriores) Then
    Begin

       // FILTER PARA TRAZER OS ALTERADOS E O REGISTRO ANTERIOR;
       cdsConsulta.Filtered  := False;
       cdsConsulta.Filter := ' (ALTERACOES LIKE ''%' + cmpfiltro + '%'') '+
                             ' OR (CONTADOR IN (' + strListAnteriores + ') ) ';

       strFiltroCmb := cdsConsulta.Filter;
       cdsConsulta.Filtered := True;

    End;

  End;

End;

Function TfrmRelCtrLogAcompDuplicNovo.fRetornaListaRegAntesAlteracao(cdsGen:TDataSet): String;
Var
    res : String;
Begin

  res := '';

  cdsGen.First;
  While (Not cdsGen.Eof) Do
  Begin
    res := res + IIf( fEmptyStr(res), Quotedstr(trim(cdsGen.FieldByName('CONT_ANTERIOR').AsString)),
                                      ',' + QuotedStr(trim(cdsGen.FieldByName('CONT_ANTERIOR').AsString)) );

    cdsGen.Next;
  End;

  Result := Res;

End;

procedure TfrmRelCtrLogAcompDuplicNovo.pFechaConsulta;
begin
  cdsConsulta.Close;

  mskDtaIni.Clear;
  mskDtaFin.Clear;
  edtCodCliente.Clear;
  edtNomCliente.Clear;
  edtCodEmpresa.Clear;
  edtDesEmpresa.Clear;
  edtNumDoc.Clear;
  edtParcel.Clear;
  edtEspecie.Clear;

  pSetFocus(edtNumDoc);
end;

function TfrmRelCtrLogAcompDuplicNovo.MascaraValor(cxProgress: TcxProgressBar = Nil): Boolean;
  Var
    intIndex: integer;
begin

  Result := True;

  If cdsConsulta.Active Then
  Begin
    cxProgress.Position := 0;
    cxProgress.Properties.Max := cdsConsulta.Fields.Count;

    With cdsConsulta Do
    For intIndex := 1 To Fields.Count - 1 Do
    Begin
      Case Fields[intIndex].DataType Of
        ftFloat: TFloatField(Fields[intIndex]).DisplayFormat := fMskDigitos(2); //'#0.00';
        ftDate : TFloatField(Fields[intIndex]).EditMask      := '99/99/9999;1;_';
      End;
      pStep(cxProgress);
    End;
  End;

end;

procedure TfrmRelCtrLogAcompDuplicNovo.pOcultarColunas;
begin
  dbgConsultaDBTableView1CTR_CODEMP.Visible := False;
  dbgConsultaDBTableView1CTR_SEQBAI.Visible := False;
  dbgConsultaDBTableView1CTR_CODVEN.Visible := False;
  dbgConsultaDBTableView1CTR_CODDIG.Visible := False;
  dbgConsultaDBTableView1CTR_HIST01.Visible := False;
  dbgConsultaDBTableView1CTR_HIST02.Visible := False;
  dbgConsultaDBTableView1CTR_PORBAI.Visible := False;
  dbgConsultaDBTableView1CTR_HISBAI.Visible := False;
  dbgConsultaDBTableView1CTR_CTABAI.Visible := False;
  dbgConsultaDBTableView1CTR_OPEBAI.Visible := False;
  dbgConsultaDBTableView1CTR_DTAREC.Visible := False;
  dbgConsultaDBTableView1CTR_VALREC.Visible := False;
  dbgConsultaDBTableView1CTR_VALJUR.Visible := False;
  dbgConsultaDBTableView1CTR_DESCOB.Visible := False;
  dbgConsultaDBTableView1CTR_VALDES.Visible := False;
  dbgConsultaDBTableView1CTR_NOSNUM.Visible := False;
  dbgConsultaDBTableView1CTR_DTABOL.Visible := False;
  dbgConsultaDBTableView1CTR_BCOBOL.Visible := False;
  dbgConsultaDBTableView1CTR_BCOENV.Visible := False;
  dbgConsultaDBTableView1CTR_DTAENV.Visible := False;
  dbgConsultaDBTableView1CTR_EMPBAI.Visible := False;
  dbgConsultaDBTableView1CTR_CODREP.Visible := False;
  dbgConsultaDBTableView1CTR_RESCAI.Visible := False;
  dbgConsultaDBTableView1CTR_DTABAI.Visible := False;
  dbgConsultaDBTableView1CTR_DINHEI.Visible := False;
  dbgConsultaDBTableView1CTR_CHQAVI.Visible := False;
  dbgConsultaDBTableView1CTR_CHQPRE.Visible := False;
  dbgConsultaDBTableView1CTR_CARTAO.Visible := False;
  dbgConsultaDBTableView1CTR_SEQCON.Visible := False;
  dbgConsultaDBTableView1CTR_CARTEI.Visible := False;
  dbgConsultaDBTableView1CTR_PERMOR.Visible := False;
  dbgConsultaDBTableView1CTR_PERMUL.Visible := False;
  dbgConsultaDBTableView1CTR_LINDIG.Visible := False;
  dbgConsultaDBTableView1CTR_DIFORI.Visible := False;
  dbgConsultaDBTableView1CTR_OPELOG.Visible := False;
  dbgConsultaDBTableView1MotEst.Visible := False;

  If Not blnVeioAgrupamento Then
  Begin
    dbgConsultaDBTableView1CTR_NUMDUP.Visible := False;
    dbgConsultaDBTableView1CTR_DTACAD.Visible := False;
    dbgConsultaDBTableView1CTR_DTAVEN.Visible := False;
    dbgConsultaDBTableView1CTR_VALDUP.Visible := False;
    dbgConsultaDBTableView1CTR_VALORI.Visible := False;
    dbgConsultaDBTableView1CTR_JURSUJ.Visible := False;
    dbgConsultaDBTableView1CTR_DESSUJ.Visible := False;
    dbgConsultaDBTableView1CTR_PARCEL.Visible := False;
    dbgConsultaDBTableView1CTR_ESPDOC.Visible := False;
    dbgConsultaDBTableView1CTR_CODCLI.Visible := False;
  End;
end;

procedure TfrmRelCtrLogAcompDuplicNovo.pSetFilterDefault;
begin
  cdsConsulta.Filter := '';
  If cdsConsulta.Filtered Then
    cdsConsulta.Filtered := FALSE;
end;

procedure TfrmRelCtrLogAcompDuplicNovo.pStep(pgbStatus: TcxProgressBar);
begin
  If Assigned(pgbStatus) Then
  Begin
    pgbStatus.Position := pgbStatus.Position + 1;
    Application.ProcessMessages;
  End;
end;

function TfrmRelCtrLogAcompDuplicNovo.fCarregaCampos(
  pgbProgresso: TcxProgressBar): Boolean;
begin
  Application.ProcessMessages;
  //dbgConsultaDBTableView1.ApplyBestFit();
  //Application.ProcessMessages;
  fAbreConsulta;
  MouseShowCursor(True);
  Application.ProcessMessages;
  pSetFocus(dbgConsulta);
  Result := True;
end;

procedure TfrmRelCtrLogAcompDuplicNovo.pCarregaCampos;
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

function TfrmRelCtrLogAcompDuplicNovo.fGeraCSV(cxProgress: TcxProgressBar): Boolean;
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

        strLinha := 'DATA LOG.;HORA LOG.;DESCRIÇÃO;NOME DO FORMULÁRIO;CÓD. OPERADOR LOG;NUM DOC;PARCELA;ESPÉCIE;' +
                    'CÓD. CLIENTE;CÓD. EMPRESA;SEQ. BAIXA;CÓD. VENDEDOR;CÓD. DIGITADOR;CÓD. PORTADOR;DATA CADASTRO;' +
                    'VENCIMENTO;VALOR;VALOR ORIGINAL;JUROS SUGERIDOS;DESCONTO SUGERIDOS;HISTÓRICO 1;HISTÓRICO 2;'+
                    'PORTADOR DA BAIXA;HISTÓRICO DA BAIXA;PL. CONTAS DA BAIXA;OPE. BAIXA;DATA DE REC.;VALOR REC.;'+
                    'VALOR JUROS;VALOR DESC.;NOSSO NUMERO;DATA BOLETO;BANCO BOLETO;ENVIO BANCO;DATA ENVIO;CÓD. CENTRO CUSTOS;'+
                    'CÓD. PL. CONTAS;CÓD. EMP. BAIXA;CÓD. REP.;ORIGEM BAIXA DOC;DATA DA BAIXA;REC. DINHEIRO;'+
                    'REC. CHEQUE AVI.;REC. CHEQUE PRÉ;REC. CARTÃO;SEQUENCIAL DA BAIXA;CARTEIRA BANCO;PERCENTUAL MORA;'+
                    'PERCENTUAL MULTA;LINHA DIGITÁVEL;MOTIVO ESTORNO;DP. DESCONTADA;' +
                    'NOME EXE;DATA EXE;HORA EXE;VERSÃO EXE';

        stlCsv.Add(strLinha);

        While Not Eof Do
        Begin
          strLinha := FormatDateTime('dd/mm/yyyy', FieldByName('CTR_DTALOG').AsDateTime) + ';' +
                      FormatDateTime('HH:mm:ss',FieldByName('CTR_HORLOG').AsDateTime) + ';' +
                      FieldByName('CTR_DESCRI').AsString + ';' +
                      FieldByName('CTR_NOMFRM').AsString + ';' +
                      FieldByName('CTR_OPELOG').AsString + ';' +
                      FieldByName('CTR_NUMDUP').AsString + ';' +
                      FieldByName('CTR_PARCEL').AsString + ';' +
                      FieldByName('CTR_ESPDOC').AsString + ';' +
                      FieldByName('CTR_CODCLI').AsString + ';' +
                      FieldByName('CTR_CODEMP').AsString + ';' +
                      IntToStr(FieldByName('CTR_SEQBAI').AsInteger) + ';' +
                      FieldByName('CTR_CODVEN').AsString + ';' +
                      FieldByName('CTR_CODDIG').AsString + ';' +
                      FieldByName('CTR_CODPOR').AsString + ';' +
                      IfThen(FieldByName('CTR_DTACAD').Value <= 0, '', FormatDateTime('dd/mm/yyyy', FieldByName('CTR_DTACAD').AsDateTime)) + ';' +
                      IfThen(FieldByName('CTR_DTAVEN').Value <= 0, '', FormatDateTime('dd/mm/yyyy', FieldByName('CTR_DTAVEN').AsDateTime)) + ';' +
                      FormatFloat('#,##0.00',FieldByName('CTR_VALDUP').AsFloat) + ';' +
                      FormatFloat('#,##0.00',FieldByName('CTR_VALORI').AsFloat) + ';' +
                      FormatFloat('#,##0.00',FieldByName('CTR_JURSUJ').AsFloat) + ';' +
                      FormatFloat('#,##0.00',FieldByName('CTR_DESSUJ').AsFloat) + ';' +
                      ReplaceStr(ReplaceStr(ReplaceStr((ReplaceStr(FieldByName('CTR_HIST01').AsString, '<<csq>>', ' ')), #13#10, ' '),#10,' '),#13,' ') + ';' +
                      ReplaceStr(ReplaceStr(ReplaceStr((ReplaceStr(FieldByName('CTR_HIST02').AsString, '<<csq>>', ' ')), #13#10, ' '),#10,' '),#13,' ') + ';' +
                      FieldByName('CTR_PORBAI').AsString + ';' +
                      ReplaceStr(ReplaceStr(ReplaceStr((ReplaceStr(FieldByName('CTR_HISBAI').AsString, '<<csq>>', ' ')), #13#10, ' '),#10,' '),#13,' ') + ';' +
                      FieldByName('CTR_CTABAI').AsString + ';' +
                      FieldByName('CTR_OPEBAI').AsString + ';' +
                      IfThen(FieldByName('CTR_DTAREC').Value <= 0, '', FormatDateTime('dd/mm/yyyy', FieldByName('CTR_DTAREC').AsDateTime)) + ';' +
                      FormatFloat('#,##0.00',FieldByName('CTR_VALREC').AsFloat) + ';' +
                      FormatFloat('#,##0.00',FieldByName('CTR_VALJUR').AsFloat) + ';' +
                      FormatFloat('#,##0.00',FieldByName('CTR_VALDES').AsFloat) + ';' +
                      FieldByName('CTR_NOSNUM').AsString + ';' +
                      IfThen(FieldByName('CTR_DTABOL').Value <= 0, '', FormatDateTime('dd/mm/yyyy', FieldByName('CTR_DTABOL').AsDateTime)) + ';' +
                      FieldByName('CTR_BCOBOL').AsString + ';' +
                      FieldByName('CTR_BCOENV').AsString + ';' +
                      IfThen(FieldByName('CTR_DTAENV').Value <= 0, '', FormatDateTime('dd/mm/yyyy', FieldByName('CTR_DTAENV').AsDateTime)) + ';' +
                      FieldByName('CTR_CODEVE').AsString + ';' +
                      FieldByName('CTR_CODCTA').AsString + ';' +
                      FieldByName('CTR_EMPBAI').AsString + ';' +
                      FieldByName('CTR_CODREP').AsString + ';' +
                      IntToStr(FieldByName('CTR_RESCAI').AsInteger) + ';' +
                      IfThen(FieldByName('CTR_DTABAI').Value <= 0, '', FormatDateTime('dd/mm/yyyy', FieldByName('CTR_DTABAI').AsDateTime)) + ';' +
                      FormatFloat('#,##0.00', FieldByName('CTR_DINHEI').AsFloat) + ';' +
                      FormatFloat('#,##0.00', FieldByName('CTR_CHQAVI').AsFloat) + ';' +
                      FormatFloat('#,##0.00', FieldByName('CTR_CHQPRE').AsFloat) + ';' +
                      FormatFloat('#,##0.00', FieldByName('CTR_CARTAO').AsFloat) + ';' +
                      IntToStr(FieldByName('CTR_SEQCON').AsInteger) + ';' +
                      FieldByName('CTR_CARTEI').AsString + ';' +
                      FormatFloat('#,##0.00', FieldByName('CTR_PERMOR').AsFloat) + ';' +
                      FormatFloat('#,##0.00', FieldByName('CTR_PERMUL').AsFloat) + ';' +
                      FieldByName('CTR_LINDIG').AsString+ ';' +
                      FieldByName('MOTEST').AsString+';'+
                      FieldbyName('CTR_DESCON').AsString+';'+
                      FieldByName('CTR_NOMEXE').AsString+';'+
                      IfThen(FieldByName('CTR_DTAEXE').Value <= 0, '', FormatDateTime('dd/mm/yyyy', FieldByName('CTR_DTAEXE').AsDateTime)) + ';' +
                      IfThen(FieldByName('CTR_HOREXE').Value <= 0, '', FormatDateTime('HH:mm:ss', FieldByName('CTR_HOREXE').AsDateTime)) + ';' +
                      FieldByName('CTR_VEREXE').AsString;

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

function TfrmRelCtrLogAcompDuplicNovo.MouseShowCursor(const Show: boolean): boolean;
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
