unit untRelChqLogAcomp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Mask, MaskEditFocus, StdCtrls, EditFocus, AppEvnts, Menus,
  Buttons, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  UniDataSetProvider,   Uni, BitBtnLockedIncrem, cxGrid, UniClientDataSet, StrUtils,
  cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, frxClass, frxExportCSVTestabilidade, System.UITypes,
  untMskC_G_C_, cxDataControllerConditionalFormattingRulesManagerDialog,
  cxContainer, Vcl.ComCtrls, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar,cxProgressBar, Datasnap.DBClient, Datasnap.Provider;

type
  TfrmRelChqLogAcomp = class(TfrmPai)
    pnlHeader: TPanel;
    Label12: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    edtCodCliente: TEditFocus;
    edtNomCliente: TEditFocus;
    dbgConsultaDBTableView1: TcxGridDBTableView;
    dbgConsultaLevel1: TcxGridLevel;
    dbgConsulta: TcxGrid;
    cxsrConsulta: TcxStyleRepository;
    Label2: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    edtCodBco: TEditFocus;
    edtNomBco: TEditFocus;
    Label3: TLabel;
    edtAgencia: TEditFocus;
    Label6: TLabel;
    edtConCor: TEditFocus;
    Label10: TLabel;
    edtNumChq: TEditFocus;
    dbgConsultaDBTableView1Column1: TcxGridDBColumn;
    dbgConsultaDBTableView1Column2: TcxGridDBColumn;
    dbgConsultaDBTableView1Column3: TcxGridDBColumn;
    dbgConsultaDBTableView1Column4: TcxGridDBColumn;
    dbgConsultaDBTableView1Column5: TcxGridDBColumn;
    dbgConsultaDBTableView1Column6: TcxGridDBColumn;
    dbgConsultaDBTableView1Column7: TcxGridDBColumn;
    dbgConsultaDBTableView1Column8: TcxGridDBColumn;
    dbgConsultaDBTableView1Column9: TcxGridDBColumn;
    dbgConsultaDBTableView1Column10: TcxGridDBColumn;
    dbgConsultaDBTableView1Column11: TcxGridDBColumn;
    dbgConsultaDBTableView1Column12: TcxGridDBColumn;
    dbgConsultaDBTableView1Column14: TcxGridDBColumn;
    dbgConsultaDBTableView1Column15: TcxGridDBColumn;
    dbgConsultaDBTableView1Column16: TcxGridDBColumn;
    dbgConsultaDBTableView1Column17: TcxGridDBColumn;
    dbgConsultaDBTableView1Column18: TcxGridDBColumn;
    dbgConsultaDBTableView1Column19: TcxGridDBColumn;
    dbgConsultaDBTableView1Column20: TcxGridDBColumn;
    dbgConsultaDBTableView1Column21: TcxGridDBColumn;
    dbgConsultaDBTableView1Column22: TcxGridDBColumn;
    dbgConsultaDBTableView1Column23: TcxGridDBColumn;
    dbgConsultaDBTableView1Column24: TcxGridDBColumn;
    dbgConsultaDBTableView1Column25: TcxGridDBColumn;
    dbgConsultaDBTableView1Column26: TcxGridDBColumn;
    dbgConsultaDBTableView1Column27: TcxGridDBColumn;
    dbgConsultaDBTableView1Column28: TcxGridDBColumn;
    dbgConsultaDBTableView1Column32: TcxGridDBColumn;
    dbgConsultaDBTableView1Column33: TcxGridDBColumn;
    Label13: TLabel;
    edtValidaCnpjCpf: TEditFocus;
    mskCnpjCpf: TMaskEditC_G_C_;
    Label14: TLabel;
    edtNomEmit: TEditFocus;
    mskDtaIniCad: TcxDateEdit;
    mskDtaFinCad: TcxDateEdit;
    mskDtaIniVen: TcxDateEdit;
    mskDtaFinVen: TcxDateEdit;
    btnConsultar: TBitBtnLocked;
    btnGeraCSV: TBitBtnLocked;
    lblCampoAlterados2: TLabel;
    Shp_inferior: TShape;
    dbgConsultaDBTableView1Alteracoes: TcxGridDBColumn;
    GroupBox1: TGroupBox;
    Shape1: TShape;
    Label15: TLabel;
    dspConsulta: TUniDataSetProvider;
    dtsConsulta: TDataSource;
    cdsConsulta: TUniClientDataSet;
    dbgConsultaDBTableView1CHQ_NOMEXE: TcxGridDBColumn;
    dbgConsultaDBTableView1CHQ_DTAEXE: TcxGridDBColumn;
    dbgConsultaDBTableView1CHQ_HOREXE: TcxGridDBColumn;
    dbgConsultaDBTableView1CHQ_VEREXE: TcxGridDBColumn;
    gpbRegcomAlteracao: TGroupBox;
    Label16: TLabel;
    chkRegComAlteracao: TCheckBox;
    cmbInfRegAlterado: TComboBox;
    dbgConsultaDBTableView1CHQ_DTADV2: TcxGridDBColumn;
    dbgConsultaDBTableView1CHQ_MOTDV2: TcxGridDBColumn;
    procedure edtCodClienteKeyPress(Sender: TObject; var Key: Char);
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
    procedure edtCodBcoKeyPress(Sender: TObject; var Key: Char);
    procedure btnConsultarClick(Sender: TObject);
    procedure btnGeraCSVClick(Sender: TObject);
    procedure chkRegComAlteracaoClick(Sender: TObject);
    procedure edtNumChqExit(Sender: TObject);
  private
    { Private declarations }
    intCor     : Integer;

    
    strNomEmi, strEndere, strTele01, strCgc: String;
    function fCarregaCampos(pgbProgresso: TcxProgressBar): Boolean;
    procedure pFechaConsulta;
    procedure pSetFilterDefault;
    function MascaraValor(cxProgress: TcxProgressBar = Nil): Boolean;
    function fGetSql: String;
    function fAbreConsulta(cxProgress: TcxProgressBar = Nil): Boolean;
    function fSetParametros: Boolean;
    function fValidaDatas: Boolean;
    function MouseShowCursor(const Show: boolean): boolean;
    function fGeraCSV(cxProgress : TcxProgressBar): Boolean;
    function DefineAlterações(cxProgress: TcxProgressBar = Nil): Boolean;
    function fRetornaListaRegAntesAlteracao(cdsGen: TDataSet): String;
    procedure pStep(pgbStatus: TcxProgressBar);
    procedure pVerificaAplicaFiltroRegComAlteracao;
    procedure VerificaSeTemRegistros;
  public
    { Public declarations }
    blnVeioManutencao: Boolean;
    qryConsulta: TUniQuery;
    procedure pCarregaCampos;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;


implementation

uses untTypesSistema, untIFuncoes, untClassPanelCx,untFuncoesGenerica, untFuncoesSimples,
     untConsultas, untFuncoes, untCfgRel, untGravando;


{$R *.dfm}

procedure TfrmRelChqLogAcomp.btnConsultarClick(Sender: TObject);
  Var
    frmAguarde: TfrmGravando;
begin
  inherited;
  if fVerificaCampos then
  begin
    if fValidaDatas then
    begin

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
          pMensagensErro(E.Message, 'frmRelCbaLogAcompMovBanNovo.fAbreConsulta');
      End;

    end;
  end;

end;

procedure TfrmRelChqLogAcomp.btnGeraCSVClick(Sender: TObject);
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

Procedure TfrmRelChqLogAcomp.VerificaSeTemRegistros();
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
    pSetFocus(edtCodBco);
  end;
End;

procedure TfrmRelChqLogAcomp.chkRegComAlteracaoClick(Sender: TObject);
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

procedure TfrmRelChqLogAcomp.dbgConsultaDBTableView1CustomDrawCell(
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

procedure TfrmRelChqLogAcomp.dbgConsultaDBTableView1CustomDrawGroupCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableCellViewInfo; var ADone: Boolean);
begin
  inherited;
  ACanvas.Brush.Color := clSkyBlue;
  ACanvas.Font.Style := ACanvas.Font.Style + [fsBold];
end;

procedure TfrmRelChqLogAcomp.edtCodBcoKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;

begin
  inherited;

  If fPesqBanco(Self, edtCodBco, edtNomBco, Nil, Key, arrSel) Then
    Self.SelectNext(ActiveControl, True, True);
end;

procedure TfrmRelChqLogAcomp.edtCodClienteKeyPress(Sender: TObject;
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

procedure TfrmRelChqLogAcomp.edtCodEmpresaKeyPress(Sender: TObject;
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

procedure TfrmRelChqLogAcomp.edtNumChqExit(Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(edtNumChq.Text) Then
  Begin
     mskdtaIniCad.Clear;
     mskdtaFinCad.Clear;
     mskdtaIniVen.Clear;
     mskdtaFinVen.Clear;
  End;
end;

function TfrmRelChqLogAcomp.fAbreConsulta(cxProgress: TcxProgressBar): Boolean;
begin

  Try
    dspConsulta.DataSet := qryConsulta;


    With qryConsulta, Sql Do
    Begin
      Close;
      cdsConsulta.Close;
      Clear;

      Add(fGetSql);


      If Not fSetParametros Then
      Begin
        Result := False;
        Exit;
      End;

      Open;

      If Assigned(dspConsulta.DataSet) Then
        pSetaClient(dspConsulta.DataSet);

      cdsConsulta.Open;

      pSetFilterDefault;

      pCriarFormularios(TfrmGravando,frmGravando);
      frmGravando.fExecutarAcao := MascaraValor;
      frmGravando.lblGravando.Caption := 'Aguarde... Adicionando Formatação aos campos.';
      frmGravando.ShowModal;
      pFreeAndNil(frmGravando);

      pCriarFormularios(TfrmGravando,frmGravando);
      frmGravando.fExecutarAcao := DefineAlterações;
      frmGravando.lblGravando.Caption := 'Aguarde... Verificando Alterações.';
      frmGravando.ShowModal;
      pFreeAndNil(frmGravando);

      dbgConsultaDBTableView1.DataController.DataSource := dtsConsulta;
      pSetFocus(dbgConsulta);

      Result := RecordCount > 0;
    End;

    blnMudarFoco := FALSE;
  Except

    On E : Exception Do
    Begin
			pMensagensErro(E.Message,'[frmRelChqLogAcomp.fAbreConsulta]');
      Result := False;
    End;

  End;
end;

function TfrmRelChqLogAcomp.fCarregaCampos(
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

function TfrmRelChqLogAcomp.fGeraCSV(cxProgress: TcxProgressBar): Boolean;
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

        strLinha := 'DATA LOG.;HORA LOG.;OPE LOG.;HISTÓRICO LOG.;CÓD.BANCO;NÚM. AGENCIA;CONTA CORRENTE;NÚM CHEQUE;CÓD CLIENTE;' +
                    'NOME;ENDEREÇO;TELEFONE;CNPF/CPF;DATA CADASTRO;DATA VENCIMENTO;VALOR;' +
                    'HISTÓRICO 1;HISTÓRICO 2;PL. CONTAS DEPÓSITO; DATA DEPÓSITO; DOC. DEPÓSITO;PORTADOR;PL. CONTAS;'+
                    'DATA DEVOLUÇÃO;MOTIVO DEVOLUÇÃO;DATA REDEPÓSITO; EMPRESA;OPERADOR;'+
                    'NOME EXE;DATA EXE;HORA EXE;VERSÃO EXE';

        stlCsv.Add(strLinha);

        While Not Eof Do
        Begin
          strLinha := FormatDateTime('dd/mm/yyyy', FieldByName('CHQ_DTALOG').AsDateTime) + ';' +
                      FormatDateTime('HH:mm:ss',FieldByName('CHQ_HORLOG').AsDateTime) + ';' +
                      FieldByName('CHQ_OPELOG').AsString + ';' +
                      FieldByName('CHQ_HISLOG').AsString + ';' +
                      FieldByName('CHQ_CODBCO').AsString + ';' +
                      FieldByName('CHQ_NUMAGE').AsString + ';' +
                      FieldByName('CHQ_CONCOR').AsString + ';' +
                      FieldByName('CHQ_NUMCHQ').AsString + ';' +
                      FieldByName('CHQ_CODCLI').AsString + ';' +
                      FieldByName('CHQ_NOMEMI').AsString + ';' +
                      FieldByName('CHQ_ENDERE').AsString + ';' +
                      FieldByName('CHQ_TELEMI').AsString + ';' +
                      FieldByName('CHQ_C_G_C_').AsString + ';' +
                      IfThen(FieldByName('CHQ_DTACAD').Value <= 0, '', FormatDateTime('dd/mm/yyyy', FieldByName('CHQ_DTACAD').AsDateTime)) + ';' +
                      IfThen(FieldByName('CHQ_DTAVEN').Value <= 0, '', FormatDateTime('dd/mm/yyyy', FieldByName('CHQ_DTAVEN').AsDateTime)) + ';' +
                      FormatFloat('#,##0.00',FieldByName('CHQ_VALCHQ').AsFloat) + ';' +
                      FieldByName('CHQ_HIST01').AsString + ';' +
                      FieldByName('CHQ_HIST02').AsString + ';' +
                      FieldByName('CHQ_CTADEP').AsString + ';' +
                      IfThen(FieldByName('CHQ_DTADEP').Value <= 0, '', FormatDateTime('dd/mm/yyyy', FieldByName('CHQ_DTADEP').AsDateTime)) + ';' +
                      FieldByName('CHQ_DOCDEP').AsString + ';' +
                      FieldByName('CHQ_CODPOR').AsString + ';' +
                      FieldByName('CHQ_CODCTA').AsString + ';' +
                      IfThen(FieldByName('CHQ_DTADEV').Value <= 0, '', FormatDateTime('dd/mm/yyyy', FieldByName('CHQ_DTADEV').AsDateTime)) + ';' +
                      FieldByName('CHQ_MOTDEV').AsString + ';' +
                      IfThen(FieldByName('CHQ_DTARDP').Value <= 0, '', FormatDateTime('dd/mm/yyyy', FieldByName('CHQ_DTARDP').AsDateTime)) + ';' +
                      FieldByName('CHQ_CODEMP').AsString + ';' +
                      FieldByName('CHQ_CODOPE').AsString + ';' +
                      FieldByName('CHQ_NOMEXE').AsString + ';' +
                      IfThen(FieldByName('CHQ_DTAEXE').Value <= 0, '', FormatDateTime('dd/mm/yyyy', FieldByName('CHQ_DTAEXE').AsDateTime)) + ';' +
                      IfThen(FieldByName('CHQ_HOREXE').Value <= 0, '', FormatDateTime('HH:mm:ss', FieldByName('CHQ_HOREXE').AsDateTime)) + ';' +
                      FieldByName('CHQ_VEREXE').AsString;

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

function TfrmRelChqLogAcomp.fGetSql: String;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT CONCAT(CHQ_CODBCO, "-",            ';
  strSQL := strSQL + '               CHQ_NUMAGE, "-",            ';
  strSQL := strSQL + '               CHQ_CONCOR, "-",            ';
  strSQL := strSQL + '               CHQ_NUMCHQ, "-",            ';
  strSQL := strSQL + '               CHQ_CODCLI, "-",            ';
  strSQL := strSQL + '               CHQ_C_G_C_, "-",            ';
  strSQL := strSQL + '               CLI_NOMCLI) AS CHEQUE,      ';
  strSQL := strSQL + '               '''' AS ALTERACOES,         ';
  strSQL := strSQL + '               "0000" AS CONTADOR,         '; //Implementado para sempre gravar o contador, para que possa pegar o anterior qdo usar o filtro do combobox;
  strSQL := strSQL + '               "0000" AS CONT_ANTERIOR,    '; //Implementado para gravar o nmero referente ao registro anterior;
  strSQL := strSQL + '               LOGCHQ.*                    ';
  strSQL := strSQL + ' FROM LOGCHQ                               ';
  strSQL := strSQL + ' LEFT JOIN CADCLI ON CLI_CODCLI = CHQ_CODCLI ';

  if Not blnVeioManutencao then
  begin
    strSQL := strSQL + ' WHERE TRUE                                ';
    if (Not fEmptyDate(mskDtaIniCad.text)) And (Not fEmptyDate(mskDtaFinCad.Text)) then
      strSQL := strSQL + ' AND CHQ_DTACAD BETWEEN :DTAINICAD AND :DTAFINCAD ';

    if (Not fEmptyDate(mskDtaIniVen.text)) And (Not fEmptyDate(mskDtaFinVen.Text)) then
      strSQL := strSQL + ' AND CHQ_DTAVEN BETWEEN :DTAINIVEN AND :DTAFINVEN ';
   end
   else
      strSQL := strSQL + ' WHERE TRUE  ';
  if Not fEmptyStr(edtCodBco.Text) then
    strSQL := strSQL + ' AND CHQ_CODBCO = :CODBCO ';

  if Not fEmptyStr(edtAgencia.Text) then
    strSQL := strSQL + ' AND CHQ_NUMAGE = :NUMAGE ';

  if Not fEmptyStr(edtConCor.Text) then
    strSQL := strSQL + ' AND CHQ_CONCOR = :CONCOR ';

  if Not fEmptyStr(edtNumChq.Text) then
    strSQL := strSQL + ' AND CHQ_NUMCHQ = :NUMCHQ ';

  if Not fEmptyStr(edtCodCliente.Text) then
    strSQL := strSQL + ' AND CHQ_CODCLI = :CODCLI ';

  if Not fEmptyStr(edtCodEmpresa.Text) then
    strSQL := strSQL + ' AND CHQ_CODEMP = :CODEMP ';

  If Not fEmptyStr(fTiraCaracEspeciais(mskCnpjCpf.Text)) Then
    strSQL := strSQL + ' AND CHQ_C_G_C_ = :CADEMI_C_G_C_';

  strSQL := strSQL + ' ORDER BY CHEQUE, CHQ_DTALOG, CHQ_HORLOG   ';

  Result := strSQL;

end;

procedure TfrmRelChqLogAcomp.FormCreate(Sender: TObject);
begin
  inherited;
  qryConsulta := fCriaQuery(Nil);
  WindowState := wsMaximized;
end;

procedure TfrmRelChqLogAcomp.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryConsulta);
end;

procedure TfrmRelChqLogAcomp.FormKeyDown(Sender: TObject;
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

procedure TfrmRelChqLogAcomp.FormShow(Sender: TObject);
begin
  inherited;
  intCor    := StrToIntDef(fCfgSis('CORZEB'), clWhite);
  mskDtaIniCad.Text := DateToStr(VS_Date);
  mskDtaFinCad.Text := DateToStr(VS_Date);
  mskDtaIniVen.Clear;
  mskDtaFinVen.Clear;
  pSetFocus(edtCodBco);
  cmbinfRegAlterado.enabled := False;

  if blnVeioManutencao then
  Begin
    pSetFocus(dbgConsulta);
    pnlHeader.Visible := False;
    lblCampoAlterados2.Visible := True;
    Shp_inferior.Visible := True;
  end;
end;

function TfrmRelChqLogAcomp.fSetParametros: Boolean;
begin
  Try
    With qryConsulta Do
    Begin
      if Not fEmptyStr(edtCodBco.Text) then
        ParamByName('CODBCO').AsString := edtCodBco.Text;

      if Not fEmptyStr(edtAgencia.Text) then
        ParamByName('NUMAGE').AsString := edtAgencia.Text;

      if Not fEmptyStr(edtConCor.Text) then
        ParamByName('CONCOR').AsString := edtConCor.Text;

      if Not fEmptyStr(edtNumChq.Text) then
        ParamByName('NUMCHQ').AsString := edtNumChq.Text;

      If Not fEmptyStr(edtCodCliente.Text) Then
        ParamByName('CODCLI').AsString := edtCodCliente.Text;

      If (Not fEmptyStr(edtCodEmpresa.Text)) Then
        ParamByName('CODEMP').AsString := edtCodEmpresa.Text;

      If Not blnVeioManutencao then
      begin
        if (Not fEmptyDate(mskDtaIniCad.text)) And (Not fEmptyDate(mskDtaFinCad.Text)) then
        Begin
        ParamByName('DTAINICAD').AsDate := StrToDate(mskDtaIniCad.Text);
        ParamByName('DTAFINCAD').AsDate := StrToDate(mskDtaFinCad.Text);
        End;

        if (Not fEmptyDate(mskDtaIniVen.text)) And (Not fEmptyDate(mskDtaFinVen.Text)) then
        Begin
        ParamByName('DTAINIVEN').AsDate := StrToDate(mskDtaIniVen.Text);
        ParamByName('DTAFINVEN').AsDate := StrToDate(mskDtaFinVen.Text);
        End;
      end;

      If Not fEmptyStr(fTiraCaracEspeciais(mskCnpjCpf.Text)) Then
        ParamByName('CADEMI_C_G_C_').AsString := fTiraCaracEspeciais(mskCnpjCpf.Text);

    End;

    Result := True;
  Except
    Result := False;
  End;
end;

function TfrmRelChqLogAcomp.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    If (Sender = edtCodBco) Then
    Begin
      If Not fEmptyStr(edtCodBco.Text) Then
      Begin
        edtNomBco.Text := fRetNomeBancoSelec(edtCodBco.Text);
        If fEmptyStr(edtNomBco.Text) Then
        Begin
          fMensagem('ATENÇÃO!','Nenhum Banco encontrado com este código !',['&O K']);
          Result := False;
        End;
      End
      Else
        edtNomBco.Text := 'TODOS';
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
    Else If (Sender = edtCodEmpresa) Then
    Begin

      If fEmptyStr(edtCodEmpresa.Text) Then
      Begin
        edtDesEmpresa.Text := 'TODOS';
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

    {***********************************}
    {*  RETORNA NOME POR  CPF OU CNPJ  *}
    {********************************LE*}
    Else if (Sender = edtValidaCnpjCpf) Then
    Begin
      If edtValidaCnpjCpf.Text = '' Then
      Begin
        mskCnpjCpf.EditMask := '';
        mskCnpjCPf.Text := '';
        edtNomEmit.Text := 'TODOS';
        mskCnpjCpf.Enabled := False;
      End
      Else Begin
        If Pos(edtValidaCnpjCPf.Text,'1_2') <= 0  Then
        Begin
          fMensagem('ATENÇÃO!', 'O campo CNPJ/CPF deve ser 1 ou 2!', ['&OK']);
          Result := False;
        End
        Else Begin
          mskCnpjCpf.Enabled := True;
          If edtValidaCnpjCPf.Text = '1'  Then
            mskCnpjCpf.EditMask := fRetMascaraC_G_C_(fSetaPais, C_G_C_)
          Else
            mskCnpjCPf.EditMask := fRetMascaraC_G_C_(fSetaPais,C_P_F_);
        End;
      End;
    End

    Else if (Sender = mskCnpjCpf) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(mskCnpjCpf.Text)) Then
      Begin
        strCgc := fTiraCaracEspeciais(mskCnpjCpf.Text);
        If (Length(strCgc) < 14) AND (edtValidaCnpjCpf.Text = '1') OR   (Length(strCgc) < 11) OR
         (Length(strCgc) > 11) AND (edtValidaCnpjCpf.Text = '2') Then
        Begin
          fMensagem('ATENÇÃO', mskCnpjCpf.Text + ' não é um número de '+IfThen(edtValidaCnpjCpf.Text ='1','CNPJ','CPF')+' válido!', ['&Ok']);
          edtNomEmit.Text := 'TODOS';
          Result := False;
        End
        Else  Begin
        fRetDadosEmitente(mskCnpjCPf.Text, strNomEmi, strEndere, strTele01);
        If strNomEmi = '' Then
          edtNomEmit.Text := 'NÃO CADASTRADO'
        Else
         edtNomEmit.Text := strNomEmi;
        End;
      End
      Else Begin
        edtNomEmit.Text := 'TODOS';
        mskCnpjCpf.Enabled := False;
        mskCnpjCpf.EditMask := '';
        mskCnpjCPf.Text := '';
        edtValidaCnpjCpf.Text := '';
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

function TfrmRelChqLogAcomp.fValidaDatas: Boolean;
begin
  Result := True;
  if (((not fEmptyStr(mskDtaIniCad.Text)) and (not fEmptyStr(mskDtaFinCad.Text))) or ((not fEmptyStr(mskDtaIniVen.Text)) and (not fEmptyStr(mskDtaFinVen.Text))))
     And (fEmptyStr(edtNumChq.Text)) then
  begin
    if (((not fEmptyStr(mskDtaIniCad.Text)) and (not fEmptyStr(mskDtaFinCad.Text)))
        and((mskDtaIniCad.Date) > (mskDtaFinCad.Date))) And (fEmptyStr(edtNumChq.Text)) then
    begin
      fMensagem('','A data Inicial de cadastro deve ser menor que a data final!',['&O K']);
      pSetFocus(mskDtaIniCad);
      Result := False;
    end
    else
    if (((not fEmptyStr(mskDtaIniVen.Text)) and (not fEmptyStr(mskDtaFinVen.Text)))
        and ((mskDtaIniVen.Date) > (mskDtaFinVen.Date))) And (fEmptyStr(edtNumChq.Text)) then
    begin
      fMensagem('','A data Inicial de vencimento deve ser menor que a data final!',['&O K']);
      pSetFocus(mskDtaIniVen);
      Result := False;
    end;
  end
  else
  begin
    If (fEmptyStr(edtNumChq.Text)) then
    Begin
      fMensagem('', 'Um dos dois períodos devem estar preenchidos', ['&O k']);
      pSetFocus(mskDtaIniCad);
      Result := False;
    End;
  end;
end;

function TfrmRelChqLogAcomp.MouseShowCursor(const Show: boolean): boolean;
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

procedure TfrmRelChqLogAcomp.pCarregaCampos;
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
      pMensagensErro(E.Message, '[TfrmRelChqLogAcomp.pCarregaCampos]');
  End;
  pFreeAndNil(frmGravando);
end;

function TfrmRelChqLogAcomp.DefineAlterações(cxProgress: TcxProgressBar = Nil): Boolean;
var
  arrRef: Array of String;
  strCartAtual: String;
  strCamposDif: String;
  intIndex: Integer;
  icont : Integer;
begin
   Result := True;

  {**************************************************************************}
  {********** ESSE COMANDO FAZ A MESMA FUNÇÃO DO DISABLECONTROLS, ***********}
  {* SÓ QUE O DISABLECONTROLS NESSE CASO NÃO É VIÁVEL POR CAUSA DOS GRUPOS. *}
  {* PRECISO QUE QUANDO CARREGUE AS INFORMAÇÕES OS GRUPOS FIQUEM ABERTOS E **}
  {************ O USANDO O DISABLECONTROLS ELES FICAM FECHADOS. *************}
  {***********************************************************************MO*}
  dbgConsulta.BeginUpdate;

  SetLength(arrRef, cdsConsulta.Fields.Count);

  cxProgress.Position := 0;
  cxProgress.Properties.Max := cdsConsulta.RecordCount;
  icont := 0;

  With cdsConsulta Do
  Begin
    First;
    strCartAtual := '';
    While not Eof Do
    Begin

      icont := icont + 1;

      Edit;
      FieldByName('CONTADOR').AsString := inttostr(icont);
      Post;

      If (strCartAtual <> FieldByName('CHEQUE').AsString) Then
      Begin
        strCartAtual := FieldByName('CHEQUE').AsString;
        for intIndex := 0 to Fields.Count - 1 do
          arrRef[intIndex] := Fields[intIndex].AsString;
      End
      Else
      Begin
        strCamposDif := '/';
        for intIndex := 0 to Fields.Count - 1 do
          If (arrRef[intIndex] <> Fields[intIndex].AsString) And
             (Fields[intIndex].FieldName <> 'AUTOINCREM') And
             (Fields[intIndex].FieldName <> 'CHQ_DTALOG') And
             (Fields[intIndex].FieldName <> 'CHQ_HORLOG') And
             (Fields[intIndex].FieldName <> 'CHQ_HISLOG') And
             (Fields[intIndex].FieldName <> 'CHQ_OPELOG') Then
            strCamposDif := strCamposDif + Fields[intIndex].FieldName + '/';

        Edit;
        FieldByName('ALTERACOES').AsString := strCamposDif;
        FieldByName('CONT_ANTERIOR').AsString := inttostr(iCont-1);
        Post;

        for intIndex := 0 to Fields.Count - 1 do
          arrRef[intIndex] := Fields[intIndex].AsString;
      End;
      Next;
      pStep(cxProgress);
    End;
  End;

  pVerificaAplicaFiltroRegComAlteracao();

  dbgConsulta.EndUpdate;
  cdsConsulta.First;
end;

Procedure TfrmRelChqLogAcomp.pVerificaAplicaFiltroRegComAlteracao();
 Var
     cmpfiltro : String;
     strListAnteriores : String;
Begin
  If (chkRegComAlteracao.Checked) and (cmbInfRegAlterado.ItemIndex <> -1) Then
  Begin

    cmpfiltro := '';

    Case cmbInfRegAlterado.ItemIndex Of
      0: cmpfiltro := 'CHQ_DTAVEN';
      1: cmpfiltro := 'CHQ_CODPOR';
      2: cmpfiltro := 'CHQ_VALCHQ';
      3: cmpfiltro := 'CHQ_DTADEP';
      4: cmpfiltro := 'CHQ_DTADEV';
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
       cdsConsulta.Filtered := True;

    End;

  End;
End;

Function TfrmRelChqLogAcomp.fRetornaListaRegAntesAlteracao(cdsGen:TDataSet): String;
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

procedure TfrmRelChqLogAcomp.pFechaConsulta;
begin
  cdsConsulta.Close;

  mskDtaIniCad.Clear;
  mskDtaFinCad.Clear;
  mskDtaIniVen.Clear;
  mskDtaFinVen.Clear;

  edtCodCliente.Clear;
  edtNomCliente.Clear;
  edtCodEmpresa.Clear;
  edtDesEmpresa.Clear;

  edtCodBco.Clear;
  edtAgencia.Clear;
  edtConCor.Clear;
  edtNumChq.Clear;

  pSetFocus(edtCodBco);
end;

function TfrmRelChqLogAcomp.MascaraValor(cxProgress: TcxProgressBar = Nil): Boolean;
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

procedure TfrmRelChqLogAcomp.pSetFilterDefault;
begin
  cdsConsulta.Filter := '';
  If cdsConsulta.Filtered Then
    cdsConsulta.Filtered := FALSE;
end;

procedure TfrmRelChqLogAcomp.pStep(pgbStatus: TcxProgressBar);
begin
  If Assigned(pgbStatus) Then
  Begin
    pgbStatus.Position := pgbStatus.Position + 1;
    Application.ProcessMessages;
  End;
end;

end.
