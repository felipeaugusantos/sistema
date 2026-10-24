unit untRelCartoesLogAcomp;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid, Vcl.Mask, MaskEditFocus, Vcl.StdCtrls, EditFocus,
  Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus,
  Vcl.Buttons, BitBtnLockedIncrem, UniDataSetProvider, Uni, UniClientDataSet,
  untTypesSistema, untFuncoesSimples, untFuncoesConsulta, untFuncoes, untConsultas,
  System.StrUtils, System.UITypes, cxContainer, Vcl.ComCtrls, dxCore,
  cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  cxDataControllerConditionalFormattingRulesManagerDialog,cxProgressBar;

type
  TfrmRelCartoesLogAcomp = class(TfrmPai)
    pnlHeader: TPanel;
    Label11: TLabel;
    Label12: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label2: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    Label10: TLabel;
    Label13: TLabel;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    edtNumCCD: TEditFocus;
    edtNumNSU: TEditFocus;
    edtCodCar: TEditFocus;
    edtDesCar: TEditFocus;
    edtParcel: TEditFocus;
    edtNumDup: TEditFocus;
    btnConfirmar: TBitBtnLocked;
    dbgConsulta: TcxGrid;
    dbgConsultaDBTableView1: TcxGridDBTableView;
    dbgConsultaDBTableView1MCA_DTALOG: TcxGridDBColumn;
    dbgConsultaDBTableView1MCA_HORLOG: TcxGridDBColumn;
    dbgConsultaDBTableView1MCA_OPELOG: TcxGridDBColumn;
    dbgConsultaDBTableView1MCA_DESCRI: TcxGridDBColumn;
    dbgConsultaDBTableView1MCA_DTACAD: TcxGridDBColumn;
    dbgConsultaDBTableView1MCA_DTAVEN: TcxGridDBColumn;
    dbgConsultaDBTableView1MCA_DTACUP: TcxGridDBColumn;
    dbgConsultaDBTableView1MCA_CODEMP: TcxGridDBColumn;
    dbgConsultaDBTableView1MCA_CODOPE: TcxGridDBColumn;
    dbgConsultaDBTableView1Alteracoes: TcxGridDBColumn;
    dbgConsultaDBTableView1MCA_NUMDUP: TcxGridDBColumn;
    dbgConsultaDBTableView1MCA_PARCEL: TcxGridDBColumn;
    dbgConsultaDBTableView1MCA_NUMCCD: TcxGridDBColumn;
    dbgConsultaDBTableView1MCA_NUMNSU: TcxGridDBColumn;
    dbgConsultaDBTableView1MCA_NOMFRM: TcxGridDBColumn;
    dbgConsultaDBTableView1MCA_VALORI: TcxGridDBColumn;
    dbgConsultaDBTableView1MCA_VALDUP: TcxGridDBColumn;
    dbgConsultaDBTableView1MCA_HIST01: TcxGridDBColumn;
    dbgConsultaDBTableView1MCA_HIST02: TcxGridDBColumn;
    dbgConsultaDBTableView1MCA_CONPAG: TcxGridDBColumn;
    dbgConsultaDBTableView1MCA_DTAREC: TcxGridDBColumn;
    dbgConsultaDBTableView1MCA_VALREC: TcxGridDBColumn;
    dbgConsultaDBTableView1MCA_DTABAI: TcxGridDBColumn;
    dbgConsultaDBTableView1MCA_OPEBAI: TcxGridDBColumn;
    dbgConsultaDBTableView1MCA_HISBAI: TcxGridDBColumn;
    dbgConsultaDBTableView1MCA_PORBAI: TcxGridDBColumn;
    dbgConsultaDBTableView1MCA_CTABAI: TcxGridDBColumn;
    dbgConsultaDBTableView1MCA_DOCBAN: TcxGridDBColumn;
    dbgConsultaDBTableView1MCA_PERCAR: TcxGridDBColumn;
    dbgConsultaDBTableView1MCA_VALSTA: TcxGridDBColumn;
    dbgConsultaDBTableView1MCA_VALTAX: TcxGridDBColumn;
    dbgConsultaDBTableView1MCA_DOCUME: TcxGridDBColumn;
    dbgConsultaDBTableView1MCA_TIPCAR: TcxGridDBColumn;
    dbgConsultaLevel1: TcxGridLevel;
    edtValSta: TEditFocus;
    Label14: TLabel;
    GroupBox1: TGroupBox;
    Shape1: TShape;
    Label15: TLabel;
    mskDtaIniCad: TcxDateEdit;
    mskDtaIniVen: TcxDateEdit;
    mskDtaFinVen: TcxDateEdit;
    mskDtaFinCad: TcxDateEdit;
    btnGeraCSV: TBitBtnLocked;
    lblCampoAlterados2: TLabel;
    Shp_inferior: TShape;
    dbgConsultaDBTableView1MCA_NOMEXE: TcxGridDBColumn;
    dbgConsultaDBTableView1MCA_DTAEXE: TcxGridDBColumn;
    dbgConsultaDBTableView1MCA_HOREXE: TcxGridDBColumn;
    dbgConsultaDBTableView1MCA_VEREXE: TcxGridDBColumn;
    gpbRegcomAlteracao: TGroupBox;
    Label16: TLabel;
    chkRegComAlteracao: TCheckBox;
    cmbInfRegAlterado: TComboBox;
    procedure btnConfirmarClick(Sender: TObject);
    procedure dbgConsultaDBTableView1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure dbgConsultaDBTableView1CustomDrawGroupCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableCellViewInfo; var ADone: Boolean);
    procedure edtCodCarExit(Sender: TObject);
    procedure edtCodCarKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliExit(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnGeraCSVClick(Sender: TObject);
    procedure edtNumDupExit(Sender: TObject);
    procedure chkRegComAlteracaoClick(Sender: TObject);
  private
    { Private declarations }
    intCor     : Integer;

    dspConsulta: TUniDataSetProvider;
    cdsConsulta: TUniClientDataSet;
    dtsConsulta: TDataSource;

    arrCartao: TConsultasArray;
    arrEmpresa: TConsultasArray;
    arrCliente: TConsultasArray;
    blnAcesso : Boolean;
    function fCarregaCampos (pgbProgresso: TcxProgressBar): Boolean;
    function fGeraCSV(cxProgress : TcxProgressBar): Boolean;
    function MouseShowCursor(const Show: boolean): boolean;

    procedure pFechaConsulta;
    procedure pSetFilterDefault;
    procedure pMascaraValor;
    function fGetSql: String;
    function fAbreConsulta(cxProgress: TcxProgressBar = Nil): Boolean;
    function fSetParametros: Boolean;
    procedure pDefineAlteracoes;
    function fRetornaListaRegAntesAlteracao(cdsGen: TDataSet): String;
    procedure pVerificaAplicaFiltroRegComAlteracao;

  public
    { Public declarations }
    blnVeioManutencao: Boolean;
    qryConsulta: TUniQuery;
    procedure pCarregaCampos;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

var
  frmRelCartoesLogAcomp: TfrmRelCartoesLogAcomp;

implementation

{$R *.dfm}

uses untGravando;

procedure TfrmRelCartoesLogAcomp.pFechaConsulta;
begin
  cdsConsulta.Close;

  mskDtaIniCad.Clear;
  mskDtaFinCad.Clear;
  mskDtaIniVen.Clear;
  mskDtaFinVen.Clear;

  edtCodCli.Clear;
  edtNomCli.Clear;
  edtCodEmp.Clear;
  edtDesEmp.Clear;

  edtNumDup.Clear;
  edtParcel.Clear;
  edtNumCCD.Clear;
  edtNumNSU.Clear;
  edtCodCar.Clear;
  edtDesCar.Clear;
  edtValSta.Clear;

  pSetFocus(edtNumDup);
end;

procedure TfrmRelCartoesLogAcomp.pSetFilterDefault;
begin
  cdsConsulta.Filter := '';
  If cdsConsulta.Filtered Then
    cdsConsulta.Filtered := FALSE;
end;

procedure TfrmRelCartoesLogAcomp.pMascaraValor;
  Var
    intIndex: integer;
begin
  If cdsConsulta.Active Then
    With cdsConsulta Do
    For intIndex := 1 To Fields.Count - 1 Do
      Case Fields[intIndex].DataType Of
        ftFloat: TFloatField(Fields[intIndex]).DisplayFormat := fMskDigitos(2); //'#0.00';
        ftDate : TFloatField(Fields[intIndex]).EditMask      := '99/99/9999;1;_';
      End;
end;

function TfrmRelCartoesLogAcomp.fGeraCSV(cxProgress: TcxProgressBar): Boolean;
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

        strLinha := 'DATA LOG.; HORA LOG.; OPER. LOG; DESCRIÇÃO LOG; DATA CADASTRO; DATA VENCIMENTO; DATA TRANSAÇÃO;EMPRESA;' +
                    'OPER.DOC.; CARTÃO; DUPLICATA; PARCELA; LIBERAÇÃO; NUM.NSU; FORMULÁRIO;' +
                    'VR.ORIGINAL; VR.DUP.; HISTÓRICO 1; HISTÓRICO 2; COND. PAG.; DATA RECEB.; VAL. RECEB.;'+
                    'DATA BAIXA; OPER. BAI.; HIST. BAI.; PORT. BAI.; CTA. BAI.; DOC. BAN.;'+
                    'TX. ADM.; VL.S/ TAXA; VAL.TAX.; DOCUMENTO; TIP. CAR.; DATA TRANSF.; SEQ. TRF.;' +
                    'NOME EXE;DATA EXE;HORA EXE;VERSÃO EXE';

        stlCsv.Add(strLinha);

        While Not Eof Do
        Begin
          strLinha := FormatDateTime('dd/mm/yyyy', FieldByName('MCA_DTALOG').AsDateTime) + ';' +
                      FormatDateTime('HH:mm:ss',FieldByName('MCA_HORLOG').AsDateTime) + ';' +
                      FieldByName('MCA_OPELOG').AsString + ';' +
                      FieldByName('MCA_DESCRI').AsString + ';' +
                      IfThen(FieldByName('MCA_DTACAD').Value <= 0, '', FormatDateTime('dd/mm/yyyy', FieldByName('MCA_DTACAD').AsDateTime)) + ';' +
                      IfThen(FieldByName('MCA_DTAVEN').Value <= 0, '', FormatDateTime('dd/mm/yyyy', FieldByName('MCA_DTAVEN').AsDateTime)) + ';' +
                      IfThen(FieldByName('MCA_DTACUP').Value <= 0, '', FormatDateTime('dd/mm/yyyy', FieldByName('MCA_DTACUP').AsDateTime)) + ';' +
                      FieldByName('MCA_CODEMP').AsString + ';' +
                      FieldByName('MCA_CODOPE').AsString + ';' +
                      FieldByName('CAR_DESCAR').AsString + ';' +
                      FieldByName('MCA_NUMDUP').AsString + ';' +
                      FieldByName('MCA_PARCEL').AsString + ';' +
                      FieldByName('MCA_NUMCCD').AsString + ';' +
                      FieldByName('MCA_NUMNSU').AsString + ';' +
                      FieldByName('MCA_NOMFRM').AsString + ';' +
                      FormatFloat('#,##0.00',FieldByName('MCA_VALORI').AsFloat) + ';' +
                      FormatFloat('#,##0.00',FieldByName('MCA_VALDUP').AsFloat) + ';' +
                      FieldByName('MCA_HIST01').AsString + ';' +
                      FieldByName('MCA_HIST02').AsString + ';' +
                      FieldByName('MCA_CONPAG').AsString + ';' +
                      IfThen(FieldByName('MCA_DTAREC').Value <= 0, '', FormatDateTime('dd/mm/yyyy', FieldByName('MCA_DTAREC').AsDateTime)) + ';' +
                      FormatFloat('#,##0.00',FieldByName('MCA_VALREC').AsFloat) + ';' +
                      IfThen(FieldByName('MCA_DTABAI').Value <= 0, '', FormatDateTime('dd/mm/yyyy', FieldByName('MCA_DTABAI').AsDateTime)) + ';' +
                      FieldByName('MCA_OPEBAI').AsString + ';' +
                      FieldByName('MCA_HISBAI').AsString + ';' +
                      FieldByName('MCA_PORBAI').AsString + ';' +
                      FieldByName('MCA_CTABAI').AsString + ';' +
                      FieldByName('MCA_DOCBAN').AsString + ';' +
                      FormatFloat(',0.000000',FieldByName('MCA_PERCAR').AsFloat) + ';' +
                      FormatFloat('#,##0.00',FieldByName('MCA_VALSTA').AsFloat) + ';' +
                      FormatFloat('#,##0.00',FieldByName('MCA_VALTAX').AsFloat) + ';' +
                      FieldByName('MCA_DOCUME').AsString + ';' +
                      FieldByName('MCA_TIPCAR').AsString + ';' +
                      IfThen(FieldByName('MCA_DTATRA').Value <= 0, '', FormatDateTime('dd/mm/yyyy', FieldByName('MCA_DTATRA').AsDateTime)) + ';' +
                      IntToStr(FieldByName('MCA_SEQTRF').AsInteger) + ';' +
                      FieldByName('MCA_NOMEXE').AsString + ';' +
                      IfThen(FieldByName('MCA_DTAEXE').Value <= 0, '', FormatDateTime('dd/mm/yyyy', FieldByName('MCA_DTAEXE').AsDateTime)) + ';' +
                      IfThen(FieldByName('MCA_HOREXE').Value <= 0, '', FormatDateTime('HH:mm:ss', FieldByName('MCA_HOREXE').AsDateTime)) + ';' +
                      FieldByName('MCA_VEREXE').AsString;


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

function TfrmRelCartoesLogAcomp.fGetSql: String;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT        CONCAT(MCA_NUMDUP, " - ",';
  strSQL := strSQL + '               MCA_PARCEL, "-",         ';
  strSQL := strSQL + '               MCA_CODEMP, "-",         ';
  strSQL := strSQL + '               MCA_CODCLI, "-",         ';
  strSQL := strSQL + '               CLI_NOMCLI) AS DUPLICATA,';
  strSQL := strSQL + '               '''' AS ALTERACOES,      ';
  strSQL := strSQL + '               CAR_DESCAR, CLI_NOMCLI,  ';
  strSQL := strSQL + '               LOGMCA.*,                ';
  strSQL := strSQL + '               "0000" AS CONTADOR,         '; //Implementado para sempre gravar o contador, para que possa pegar o anterior qdo usar o filtro do combobox;
  strSQL := strSQL + '               "0000" AS CONT_ANTERIOR     '; //Implementado para gravar o nmero referente ao registro anterior;
  strSQL := strSQL + ' FROM LOGMCA                               ';
  strSQL := strSQL + ' LEFT JOIN CADCLI ON CLI_CODCLI = MCA_CODCLI ';
  strSQL := strSQL + ' LEFT JOIN CADCAR ON CAR_CODCAR = MCA_CODCAR ';

  if Not blnVeioManutencao then
  begin
    strSQL := strSQL + ' WHERE TRUE   ';
    if (Not fEmptyDate(mskDtaIniCad.text)) And (Not fEmptyDate(mskDtaFinCad.Text)) then
    strSQL := strSQL + ' AND MCA_DTACAD BETWEEN :DTAINICAD AND :DTAFINCAD ';

    if (Not fEmptyDate(mskDtaIniVen.text)) And (Not fEmptyDate(mskDtaFinVen.Text)) then
    strSQL := strSQL + ' AND MCA_DTAVEN BETWEEN :DTAINIVEN AND :DTAFINVEN ';

  end
  else
   strSQL := strSQL + ' WHERE TRUE ';

  if Not fEmptyStr(edtNumDup.Text) then
    strSQL := strSQL + ' AND MCA_NUMDUP = :NUMDUP ';

  if Not fEmptyStr(edtParcel.Text) then
    strSQL := strSQL + ' AND MCA_PARCEL = :PARCEL ';

  if Not fEmptyStr(edtNumCCD.Text) then
    strSQL := strSQL + ' AND MCA_NUMCCD = :NUMCCD ';

  if Not fEmptyStr(edtNumNSU.Text) then
    strSQL := strSQL + ' AND MCA_NUMNSU = :NUMNSU ';

  if Not fEmptyStr(edtValSta.Text) then
    strSQL := strSQL + ' AND MCA_VALSTA = :VALSTA ';


  If Not fEmptyStr(edtCodCli.Text) Then
    strSQL := strSQL + fStrLocate(edtCodCli,  arrCliente,  'CLI_CODCLI', 'CODCLI');

  If Not fEmptyStr(edtDesCar.Text) Then
    strSQL := strSQL + fStrLocate(edtCodCar,  arrCartao,  'MCA_CODCAR', 'CODCAR');

  If Not fEmptyStr(edtCodEmp.Text) Then
    strSQL := strSQL + fStrLocate(edtCodEmp,  arrEmpresa,  'MCA_CODEMP', 'CODEMP');

  strSQL := strSQL + ' ORDER BY DUPLICATA, MCA_DTALOG, MCA_HORLOG   ';

  Result := strSQL;

end;

procedure TfrmRelCartoesLogAcomp.FormCreate(Sender: TObject);
begin
  inherited;
  WindowState := wsMaximized;

  qryConsulta := fCriaQuery(Nil);
end;

procedure TfrmRelCartoesLogAcomp.FormDestroy(Sender: TObject);
begin
  inherited;

  FreeAndNil(qryConsulta);
end;

procedure TfrmRelCartoesLogAcomp.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

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

procedure TfrmRelCartoesLogAcomp.FormShow(Sender: TObject);
begin
  inherited;

  intCor    := StrToIntDef(fCfgSis('CORZEB'), clWhite);
  mskDtaIniCad.Text := DateToStr(VS_Date);
  mskDtaFinCad.Text := DateToStr(VS_Date);
  pSetFocus(edtNumDup);
  cmbinfRegAlterado.enabled := False;

  blnAcesso := fVerificaAcessoSistema('CARBAITODOS');

  if blnVeioManutencao then
  Begin
    pSetFocus(dbgConsulta);
    pnlHeader.Visible := False;
    lblCampoAlterados2.Visible := True;
    Shp_inferior.Visible := True;
  end;
end;

procedure TfrmRelCartoesLogAcomp.btnConfirmarClick(Sender: TObject);
begin
  inherited;

  If fValidaCampos(Self, True) Then
    If not fAbreConsulta then
    Begin
      fMensagem('', 'Não há dados para Exibir!', ['&Ok']);
      pSetFocus(edtNumDup);
    End;
end;

procedure TfrmRelCartoesLogAcomp.btnGeraCSVClick(Sender: TObject);
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

procedure TfrmRelCartoesLogAcomp.chkRegComAlteracaoClick(Sender: TObject);
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

procedure TfrmRelCartoesLogAcomp.dbgConsultaDBTableView1CustomDrawCell(
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

procedure TfrmRelCartoesLogAcomp.dbgConsultaDBTableView1CustomDrawGroupCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableCellViewInfo; var ADone: Boolean);
begin
  inherited;

  ACanvas.Brush.Color := clSkyBlue;
  ACanvas.Font.Style := ACanvas.Font.Style + [fsBold];
end;

procedure TfrmRelCartoesLogAcomp.edtCodCarExit(Sender: TObject);
begin
  inherited;

  If Not edtCodCar.ReadOnly Then
    pEdtCodSelectExit(edtCodCar, edtDesCar, arrCartao, fRetNomeCartao, Nil, 'do cartão');
end;

procedure TfrmRelCartoesLogAcomp.edtCodCarKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqCartao(Self, edtCodCar, edtDesCar, Nil, Key, arrCartao, False, False, False, True, True, Not blnAcesso) Then
  Begin
    fValidaCampos(edtCodCar,False);
    self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCartoesLogAcomp.edtCodCliExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCli, edtNomCli, arrCliente, Nil, fRetNomCliente, 'do cliente', 8);
end;

procedure TfrmRelCartoesLogAcomp.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrCliente, False) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCartoesLogAcomp.edtCodEmpExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodEmp, edtDesEmp, arrEmpresa, Nil, fRetNomeEmpresaSelec, 'da empresa', 3);
end;

procedure TfrmRelCartoesLogAcomp.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, arrEmpresa, False, True) Then
  Begin
    fValidaCampos(edtCodEmp,False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCartoesLogAcomp.edtNumDupExit(Sender: TObject);
begin
  inherited;
  If (Not fEmptyStr(edtNumDup.Text)) And (length(edtNumDup.Text) < 12) Then
     edtNumDup.Text := fStrZero(edtNumDup.Text, 12);
  If Not fEmptyStr(edtNumDup.Text) Then
  Begin
     mskdtaIniCad.Clear;
     mskdtaFinCad.Clear;
     mskdtaIniVen.Clear;
     mskdtaFinVen.Clear;
  End;
end;

function TfrmRelCartoesLogAcomp.fAbreConsulta(cxProgress: TcxProgressBar = Nil): Boolean;
begin
  Try
    cdsConsulta := TUniClientDataSet.Create(Self);
    dtsConsulta := TDataSource.Create(Self);
    dspConsulta := TUniDataSetProvider.Create(Self);
    dspConsulta.DataSet := qryConsulta;
    cdsConsulta.SetProvider(dspConsulta);
    dtsConsulta.DataSet := cdsConsulta;

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

      pMascaraValor;

      pDefineAlteracoes;

      dbgConsultaDBTableView1.DataController.DataSource := dtsConsulta;
      pSetFocus(dbgConsulta);

      Result := cdsConsulta.RecordCount > 0;
    End;

  Except

    On E : Exception Do
    Begin
			pMensagensErro(E.Message,'[TfrmRelCtrLogAcompDuplicNovo.fAbreConsulta]');
      Result := False;
    End;

  End;
end;

function TfrmRelCartoesLogAcomp.fCarregaCampos(
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

function TfrmRelCartoesLogAcomp.fSetParametros: Boolean;
Var
  strClientes, strCartoes, strEmpresas : string;
begin
  Try
    With qryConsulta Do
    Begin
      if Not fEmptyStr(edtNumDup.Text) then
        ParamByName('NUMDUP').AsString := edtNumDup.Text;

      if Not fEmptyStr(edtParcel.Text) then
        ParamByName('PARCEL').AsString := edtParcel.Text;

      if Not fEmptyStr(edtNumCCD.Text) then
        ParamByName('NUMCCD').AsString := edtNumCCD.Text;

      if Not fEmptyStr(edtNumNSU.Text) then
        ParamByName('NUMNSU').AsString := edtNumNSU.Text;

      If Not fEmptyStr(edtCodCli.Text) Then
        pSetaParam(edtCodCli.Text, arrCliente, strClientes, 'CODCLI', qryConsulta);

      If Not fEmptyStr(edtDesCar.Text) Then
        pSetaParam(edtCodCar.Text, arrCartao, strCartoes, 'CODCAR', qryConsulta);

      If Not fEmptyStr(edtCodEmp.Text) Then
        pSetaParam(edtCodEmp.Text, arrEmpresa, strEmpresas, 'CODEMP', qryConsulta);

      If (Not fEmptyStr(edtValSta.Text)) Then
        ParamByName('VALSTA').AsString := AnsiReplaceStr(FloatToStr(fStrToFloat(edtValSta.Text)), FormatSettings.DecimalSeparator, '.');

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

    End;

    Result := True;
  Except
    Result := False;
  End;
end;

function TfrmRelCartoesLogAcomp.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
Var
    intIndex: Integer;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If (Sender = edtCodCar) Then
    Begin

      pDesmarcaLista(edtCodCar, arrCartao);

      If (Not fEmptyStr(edtCodCar.Text)) And (High(arrCartao) <= 0) And Not blnAcesso Then
      Begin
        If (Not fVerificaAcessoCartao(edtCodCar.Text)) Then
        Begin
          fMensagem('', 'Usuário sem permissão de acesso a esse Cartão!', ['&Ok']);
          Result := False;
        End;
      End;

    End

    Else If (Sender = edtCodCli) Then

      pDesmarcaLista(edtCodCli, arrCliente)

    Else If (Sender = edtCodEmp) Then
    Begin

      pDesmarcaLista(edtCodEmp, arrEmpresa);

      If ((Not fEmptyStr(edtCodEmp.Text)) Or (High(arrEmpresa) >= 0)) And Not blnAcesso Then
      Begin
        If (High(arrEmpresa) >= 0 ) Then
        Begin
          For intIndex := 0 To High(arrEmpresa) Do
          Begin
            If Pos(arrEmpresa[intIndex].strCodigo, strEmpAcessoUsuarioLogado) <= 0 Then
            Begin
              fMensagem('', 'Usuário sem permissão de acesso a empresa + ' + arrEmpresa[intIndex].strCodigo + '!', ['&Ok']);
              Result := False;
              Break;
            End;
          End;
        End
        Else If Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('', 'Usuário sem permissão de acesso a essa Empresa!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtValSta) Then
    Begin

      If not fEmptyStr(edtValSta.Text) Then
        If (fStrToFloat(edtValSta.Text) <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Valor sem taxa deve ser maior que Zero!', ['&O k']);
          Result := False;
        End
        Else
          edtValSta.Text := FloatToStrF(fStrToFloat(edtValSta.Text), ffFixed, 12, 2);

    End
    Else If (Sender <> mskDtaIniCad) and (Sender <> mskDtaFinCad) and
            (Sender <> mskDtaIniVen) Then
    Begin
      If (fEmptyStr(fTiraCaracEspeciais(mskDtaIniCad.Text)) and
          fEmptyStr(fTiraCaracEspeciais(mskDtaFinCad.Text)) and
          fEmptyStr(fTiraCaracEspeciais(mskDtaIniVen.Text)) and
          fEmptyStr(fTiraCaracEspeciais(mskDtaFinVen.Text))) And
          (fEmptyStr(edtNumDup.Text)) Then
      Begin
        fMensagem('', 'Favor informar período por cadastro ou vencimento!', ['&Ok']);
        pSetFocus(mskDtaIniCad);
        Result := False;
      End
      Else
      If (fEmptyStr(fTiraCaracEspeciais(mskDtaIniCad.Text)) and
          not fEmptyStr(fTiraCaracEspeciais(mskDtaFinCad.Text))) And (fEmptyStr(edtNumDup.Text)) Then
      Begin
        fMensagem('', 'Favor informar a data inicial (Cadastro)!', ['&Ok']);
        pSetFocus(mskDtaIniCad);
        Result := False;
      End
      Else
      If (not fEmptyStr(fTiraCaracEspeciais(mskDtaIniCad.Text)) and
          fEmptyStr(fTiraCaracEspeciais(mskDtaFinCad.Text))) And (fEmptyStr(edtNumDup.Text)) Then
      Begin
        fMensagem('', 'Favor informar a data final (Cadastro)!', ['&Ok']);
        pSetFocus(mskDtaFinCad);
        Result := False;
      End
      Else
      If (fEmptyStr(fTiraCaracEspeciais(mskDtaIniVen.Text)) and
          not fEmptyStr(fTiraCaracEspeciais(mskDtaFinVen.Text))) And (fEmptyStr(edtNumDup.Text)) Then
      Begin
        fMensagem('', 'Favor informar a data inicial (Vencimento)!', ['&Ok']);
        pSetFocus(mskDtaIniVen);
        Result := False;
      End
      Else
      If (not fEmptyStr(fTiraCaracEspeciais(mskDtaIniVen.Text)) and
          fEmptyStr(fTiraCaracEspeciais(mskDtaFinVen.Text))) And (fEmptyStr(edtNumDup.Text)) Then
      Begin
        fMensagem('', 'Favor informar a data final (Vencimento)!', ['&Ok']);
        pSetFocus(mskDtaFinVen);
        Result := False;
      End
    End
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

function TfrmRelCartoesLogAcomp.MouseShowCursor(const Show: boolean): boolean;
Var
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

procedure TfrmRelCartoesLogAcomp.pCarregaCampos;
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
      pMensagensErro(E.Message, '[frmRelCartoesLogAcomp.pCarregaCampos]');
  End;
  pFreeAndNil(frmGravando);
end;

procedure TfrmRelCartoesLogAcomp.pDefineAlteracoes;
var
  arrRef: Array of String;
  strCartAtual: String;
  strCamposDif: String;
  intIndex: Integer;
  icont : Integer;
begin
  {**************************************************************************}
  {********** ESSE COMANDO FAZ A MESMA FUNÇÃO DO DISABLECONTROLS, ***********}
  {* SÓ QUE O DISABLECONTROLS NESSE CASO NÃO É VIÁVEL POR CAUSA DOS GRUPOS. *}
  {* PRECISO QUE QUANDO CARREGUE AS INFORMAÇÕES OS GRUPOS FIQUEM ABERTOS E **}
  {************ O USANDO O DISABLECONTROLS ELES FICAM FECHADOS. *************}
  {***********************************************************************MO*}
  dbgConsulta.BeginUpdate;

  SetLength(arrRef, cdsConsulta.Fields.Count);
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

      If (strCartAtual <> FieldByName('DUPLICATA').AsString) Then
      Begin
        strCartAtual := FieldByName('DUPLICATA').AsString;
        for intIndex := 0 to Fields.Count - 1 do
          arrRef[intIndex] := Fields[intIndex].AsString;
      End
      Else
      Begin
        strCamposDif := '/';
        for intIndex := 0 to Fields.Count - 1 do
          If (arrRef[intIndex] <> Fields[intIndex].AsString) And
             (Fields[intIndex].FieldName <> 'AUTOINCREM') And
             (Fields[intIndex].FieldName <> 'MCA_DTALOG') And
             (Fields[intIndex].FieldName <> 'MCA_HORLOG') And
             (Fields[intIndex].FieldName <> 'MCA_DESCRI') And
             (Fields[intIndex].FieldName <> 'MCA_NOMFRM') And
             (Fields[intIndex].FieldName <> 'MCA_OPELOG') Then
            strCamposDif := strCamposDif + Fields[intIndex].FieldName + '/';

        Edit;
        FieldByName('ALTERACOES').AsString := strCamposDif;
        FieldByName('CONT_ANTERIOR').AsString := inttostr(iCont-1);
        Post;

        for intIndex := 0 to Fields.Count - 1 do
          arrRef[intIndex] := Fields[intIndex].AsString;
      End;
      Next;
    End;
  End;

  pVerificaAplicaFiltroRegComAlteracao();

  dbgConsulta.EndUpdate;
  cdsConsulta.First;
end;

Procedure TfrmRelCartoesLogAcomp.pVerificaAplicaFiltroRegComAlteracao();
 Var
     cmpfiltro : String;
     strListAnteriores : String;
Begin

  If (chkRegComAlteracao.Checked) and (cmbInfRegAlterado.ItemIndex <> -1) Then
  Begin

    cmpfiltro := '';

    Case cmbInfRegAlterado.ItemIndex Of
      0: cmpfiltro := 'MCA_DTAVEN';
      1: cmpfiltro := 'MCA_PORCAR';
      2: cmpfiltro := 'MCA_VALDUP';
      3: cmpfiltro := 'MCA_NUMNSU';
      4: cmpfiltro := 'MCA_CODCAR';
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

Function TfrmRelCartoesLogAcomp.fRetornaListaRegAntesAlteracao(cdsGen:TDataSet): String;
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

end.
