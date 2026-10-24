unit untMetaCompDepVendConsultaDocsDevolucao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Mask, MaskEditFocus, EditFocus,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxCheckBox, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGridCitel, cxGrid,
  Datasnap.DBClient, UniClientDataSet, untTypesSistema;

type
  TfrmMetaCompDepVendConsultaDocsDevolucao = class(TfrmPaiConfirma)
    Panel1: TPanel;
    Label19: TLabel;
    edtCodCliente: TEditFocus;
    edtDesCliente: TEditFocus;
    lblCodEmp: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    Label4: TLabel;
    Label6: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    edtNumDoc: TEditFocus;
    Label1: TLabel;
    btnFiltrar: TBitBtnLocked;
    grdDocsDev: TcxGridCitel;
    grdDocsDevTv: TcxGridDBTableViewCitel;
    grdDocsDevTvSELECIONADO: TcxGridDBColumn;
    grdDocsDevTvDOCUME: TcxGridDBColumn;
    grdDocsDevTvCODEMP: TcxGridDBColumn;
    grdDocsDevTvCLIENTE: TcxGridDBColumn;
    grdDocsDevTvDTAEMI: TcxGridDBColumn;
    grdDocsDevTvVALDOC: TcxGridDBColumn;
    grdDocsDevLvl: TcxGridLevel;
    cdsDocsDev: TUniClientDataSet;
    cdsDocsDevSELECIONADO: TBooleanField;
    cdsDocsDevDEV_NUMDOC: TStringField;
    cdsDocsDevDEV_ESPDOC: TStringField;
    cdsDocsDevDEV_CODEMP: TStringField;
    cdsDocsDevDEV_DOCUME: TStringField;
    cdsDocsDevDEV_CLIENTE: TStringField;
    cdsDocsDevDEV_DTAEMI: TDateField;
    cdsDocsDevDEV_VALDOC: TFloatField;
    dtsMT2DocsDev: TDataSource;
    procedure edtCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodClienteExit(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
    arrClientes,
    arrEmpres: TConsultasArray;
    strAceRom: String;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses
  Uni, untFuncoesSimples, untFuncoesConsulta, untConsultas;

{$R *.dfm}

procedure TfrmMetaCompDepVendConsultaDocsDevolucao.btnConfirmaClick(
  Sender: TObject);
begin
  inherited;
  cdsDocsDev.DisableControls;
  try

    cdsDocsDev.Filtered := False;
    cdsDocsDev.Filter := 'SELECIONADO = TRUE';
    cdsDocsDev.Filtered := True;

    if cdsDocsDev.IsEmpty then
      fMensagem('ATENÇÃO!', 'Necessário selecionar pelo menos um Documento!', ['&Ok'])
    else
    begin
      ModalResult := MrOk;
    end;
  finally
    cdsDocsDev.First;
    cdsDocsDev.EnableControls;
  end;
end;

procedure TfrmMetaCompDepVendConsultaDocsDevolucao.btnFiltrarClick(
  Sender: TObject);
var
  qrySelect: TUniQuery;
  strSQL: String;
  strLinCli: String;
  I: Integer;
begin
  inherited;

  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   MOVGER.AUTOINCREM, ';
  strSQL := strSQL + '   GER_NUMDOC AS DEV_NUMDOC, ';
  strSQL := strSQL + '   GER_ESPDOC AS DEV_ESPDOC, ';
  strSQL := strSQL + '   GER_CODEMP AS DEV_CODEMP, ';
  strSQL := strSQL + '   CONCAT(GER_NUMDOC, "-", GER_ESPDOC) AS DEV_DOCUME, ';
  strSQL := strSQL + '   CONCAT(GER_CODCLI, "-", CLI_NOMCLI) AS DEV_CLIENTE, ';
  strSQL := strSQL + '   GER_DTAENT AS DEV_DTAEMI, ';
  strSQL := strSQL + '   GER_VLRCON AS DEV_VALDOC ';
  strSQL := strSQL + ' FROM  MOVDET ';
  strSQL := strSQL + ' INNER JOIN MOVGER ON MOVGER.AUTOINCREM = DET_SEQGER ';
  strSQL := strSQL + ' LEFT  JOIN CADCLI ON CLI_CODCLI = GER_CODCLI ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '    (LOCATE(DET_CLAFIS, ' + QuotedStr(VS_strClaDev) + ') > 0) ';

  if not fEmptyStr(edtNumDoc.Text) then
    strSQL := strSQL + '  AND GER_NUMDOC = :NUMDOC';

  If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
    strSQL := strSQL + ' AND DET_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

  strSQL := strSQL + fStrLocate(edtCodCliente, arrClientes, 'GER_CODCLI', 'CODCLI');
  strSQL := strSQL + fStrLocate(edtCodEmp    , arrEmpres  , 'GER_CODEMP', 'CODEMP');

  strSQL := strSQL + ' GROUP BY MOVGER.AUTOINCREM ';

  qrySelect := fCriaQuery;
  try
    qrySelect.SQL.Text := strSQL;
    if not fEmptyStr(edtNumDoc.Text) then
      qrySelect.ParamByName('NUMDOC').AsString := edtNumDoc.Text;

    If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
    Begin
      qrySelect.ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
      qrySelect.ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
    End;

    pSetaParam(edtCodCliente.Text, arrClientes, strLinCli, 'CODCLI', qrySelect);
    pSetaParam(edtCodEmp.Text    , arrEmpres  , strLinCli, 'CODEMP', qrySelect);

    qrySelect.Open;

    cdsDocsDev.DisableControls;
    try
      cdsDocsDev.EmptyDataSet;
      while not qrySelect.Eof do
      begin
        cdsDocsDev.Append;
        for I := 0 to Pred(cdsDocsDev.Fields.Count) do
          if Assigned(qrySelect.FindField(cdsDocsDev.Fields[I].FieldName)) then
            cdsDocsDev.Fields[I].Value := qrySelect.FieldByName(cdsDocsDev.Fields[I].FieldName).Value;

        cdsDocsDevSELECIONADO.AsBoolean := False;
        cdsDocsDev.Post;

        qrySelect.Next;
      end;
    finally
      cdsDocsDev.First;
      cdsDocsDev.EnableControls;
    end;

  finally
    FreeAndNil(qrySelect);
  end;
end;

procedure TfrmMetaCompDepVendConsultaDocsDevolucao.edtCodClienteExit(
  Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCliente, edtDesCliente, arrClientes, Nil, fRetNomCliente, 'do Cliente');
end;

procedure TfrmMetaCompDepVendConsultaDocsDevolucao.edtCodClienteKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCliente, edtDesCliente, Nil, Key, arrClientes, False) Then
    If fValidaCampos(edtCodCliente, True) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmMetaCompDepVendConsultaDocsDevolucao.edtCodEmpExit(
  Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmp, edtNomEmp, arrEmpres, fRetNomeEmpresa, nil, 'da Empresa');
end;

procedure TfrmMetaCompDepVendConsultaDocsDevolucao.edtCodEmpKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmpres, False, False, strAceRom) Then
    If fValidaCampos(edtCodEmp, True) Then
      Self.SelectNext(ActiveControl, True, True);
end;

procedure TfrmMetaCompDepVendConsultaDocsDevolucao.FormCreate(Sender: TObject);
begin
  inherited;
  strAceRom := fCampoTabela('OPE_EMPROM', 'CADOPE', ['OPE_CODOPE'], [strLoginUsuarioLogado]);
  cdsDocsDev.CreateDataSet;
end;

function TfrmMetaCompDepVendConsultaDocsDevolucao.fValidaCampos(
  Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender,blnBuscaPorChave)) Then
  Begin

    If (Sender = mskDtaIni) Then
    Begin

      If (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
        mskDtaFin.Enabled := False
      Else
        mskDtaFin.Enabled := True;

    End

    Else If (Sender = mskDtaFin) Then
    Begin

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        If (fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
        Begin
          fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
          Begin
            fMensagem('','A Data Inicial deve ser menor que a Data Final!',['&O K']);
            Result := False;
          End;
        End;
      End;

    End

    Else If Sender = edtCodEmp Then
    Begin
      If Not fEmptyStr(edtCodEmp.Text) And (Length(arrEmpres) <= 1) Then
      Begin
        If Pos(edtCodEmp.Text, strAceRom) <= 0 Then
        Begin
          fMensagem('','Usuário sem permissão de acesso à empresa!',['&O K']);
          Result := False;
        End;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

end.
