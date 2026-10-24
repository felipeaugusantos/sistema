unit untCadLeadVincularOrcamentos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, untZClient,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, cxCheckBox, Vcl.Mask,
  MaskEditFocus, EditFocus, untTypesSistema, Uni, untILeads, untLeads;

type

  TfrmCadLeadVincularOrcamentos = class(TfrmPai)
    cxgOrcamentosDBTableViewCitel1: TcxGridDBTableViewCitel;
    cxgOrcamentosLevel1: TcxGridLevel;
    cxgOrcamentos: TcxGridCitel;
    cxgOrcamentosDBTableViewCitel1Column1: TcxGridDBColumn;
    cxgOrcamentosDBTableViewCitel1Column2: TcxGridDBColumn;
    cxgOrcamentosDBTableViewCitel1Column3: TcxGridDBColumn;
    cxgOrcamentosDBTableViewCitel1Column4: TcxGridDBColumn;
    cxgOrcamentosDBTableViewCitel1Column5: TcxGridDBColumn;
    cxgOrcamentosDBTableViewCitel1Column6: TcxGridDBColumn;
    cxgOrcamentosDBTableViewCitel1Column7: TcxGridDBColumn;
    btnConfirmar: TBitBtnLocked;
    pnlFiltros: TPanel;
    lblCodCli: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    lblDtaIni: TLabel;
    mskDtaOrcIni: TMaskEditFocus;
    lblAteDtaIniObr: TLabel;
    mskDtaOrcFim: TMaskEditFocus;
    btnCarrega: TBitBtnLocked;
    Label1: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    lblNumDoc: TLabel;
    edtNumDoc: TEditFocus;
    edtDesNumDoc: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cxgOrcamentosDBTableViewCitel1Column7PropertiesChange(
      Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliExit(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
    procedure btnCarregaClick(Sender: TObject);
    procedure edtNumDocExit(Sender: TObject);
    procedure edtNumDocKeyPress(Sender: TObject; var Key: Char);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  private
    cdsFatGor : TZClient;
    arrCliente,
    arrEmpresa,
    arrDocumento: TConsultasArray;
    strEmpresas,
    strClientes,
    strDocumento,
    strCodEmpDocumento: String;
    qryFatGor: TUniQuery;
    objLeads : ILeads;

    procedure pMostrarOrcamentos;
    procedure SetObjLead(const AValue: ILeads);
    function fExisteRegistroSelecionado: Boolean;
    procedure pVincularOrcamentoAoLead(const strOrcamento: string);
    procedure pCarregaEmpresa;
    procedure pCarregaCliente;
    procedure pCarregaDocumento;
    function fValidaAcessoEmpresa(const strEmpresa: string): Boolean;
  public
    class procedure pAbrirTelaVincularOrcamentos(const aObjLead: ILeads);
  end;

implementation

uses
  untFuncoesSimples, untFuncoesConsulta, untConsultas, DateUtils;

{$R *.dfm}

{ TfrmCadLeadVincularOrcamentos }

procedure TfrmCadLeadVincularOrcamentos.btnCarregaClick(Sender: TObject);
begin
  inherited;

  pMostrarOrcamentos;
end;

procedure TfrmCadLeadVincularOrcamentos.btnConfirmarClick(Sender: TObject);
begin
  inherited;

  Try
    cdsFatGor.DisableControls;

    cdsFatGor.First;
    While Not cdsFatGor.Eof Do
    Begin
      If (cxgOrcamentosDBTableViewCitel1.DataController.Values[cdsFatGor.RecNo - 1, 0] = 'S') Then
      Begin
        pVincularOrcamentoAoLead(cdsFatGor.FieldByName('FGO_SEQFGO').AsString);
      End;
      cdsFatGor.Next;
    End;

    fMensagem('Atenção', 'Orçamento(s) vinculado ao Lead: ' + objLeads.strNumLead , ['&OK']);
  Finally
    cdsFatGor.EnableControls;
    Self.Close;
  End;
end;

procedure TfrmCadLeadVincularOrcamentos.cxgOrcamentosDBTableViewCitel1Column7PropertiesChange(
  Sender: TObject);
begin
  inherited;

  btnConfirmar.Enabled := fExisteRegistroSelecionado;
end;

procedure TfrmCadLeadVincularOrcamentos.edtCodCliExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodCli, edtNomCli, arrCliente, Nil, fRetNomCliente, 'do Cliente');

end;

procedure TfrmCadLeadVincularOrcamentos.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrCliente, False) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadLeadVincularOrcamentos.edtCodEmpExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodEmp, edtNomEmp, arrEmpresa, Nil, fRetNomeEmpresaSelec, 'da Empresa');

end;

procedure TfrmCadLeadVincularOrcamentos.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmpresa, False, True) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadLeadVincularOrcamentos.edtNumDocExit(Sender: TObject);
begin
  inherited;

   fValidaCampos(edtNumDoc, True);

end;

procedure TfrmCadLeadVincularOrcamentos.edtNumDocKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqPedOrc(conPedCompleta, Self, 'OR', 'OR', '', edtNumDoc,  nil,
    edtCodEmp, qryFatGor, Key, arrDocumento, True, Nil, '', 'N', '', True) Then
  Begin
    edtNumDoc.Text := qryFatGor.FieldByName('FGO_NUMDOC').AsString;
    strCodEmpDocumento := qryFatGor.FieldByName('FGO_CODEMP').AsString;

    If fValidaCampos(edtNumDoc, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmCadLeadVincularOrcamentos.fExisteRegistroSelecionado: Boolean;
var
  LRecNo: Integer;
begin
  Result := False;
  LRecNo := cdsFatGor.RecNo;
  cdsFatGor.DisableControls;
  Try
    cdsFatGor.First;
    While Not cdsFatGor.Eof Do
    Begin
      If cdsFatGor.FieldByName('MARCADO').AsString = 'S' Then
      Begin
        Result := True;
        Exit;
      End;

      cdsFatGor.Next;
    End;
  Finally
    cdsFatGor.RecNo := LRecNo;
    cdsFatGor.EnableControls;
  End;
end;

procedure TfrmCadLeadVincularOrcamentos.pMostrarOrcamentos;
const
  SQLSelect = ' SELECT "N" AS MARCADO,                           ' +
              '        FGO_NUMDOC,                               ' +
              '        FGO_ESPDOC,                               ' +
              '        FGO_CODCLI,                               ' +
              '        CLI_NOMCLI,                               ' +
              '        FGO_CODEMP,                               ' +
              '        FGO_TOTPRO,                               ' +
              '        FGO_NLEADS,                               ' +
              '        FGO_SEQFGO,                               ' +
              '        FGO_DTAENT,                               ' +
              '        G.AUTOINCREM                              ' +
              ' FROM FATGOR G                                    ' +
              '   INNER JOIN EXTGOR ON FGO_SEQFGO = G.AUTOINCREM ' +
              '   INNER JOIN CADCLI ON CLI_CODCLI = FGO_CODCLI   ' +
              ' WHERE                                            ' +
              '   FGO_ESPDOC = "OR"                              ' +
              '   AND FGO_JAFATU = 0                             ' +
              '   AND (IFNULL(FGO_NLEADS, "")  = "")             ' ;
begin

  If Not fVerificaCampos Then
    Exit;

  cdsFatGor.Close;
  cdsFatGor.qryQuery.Close;
  cdsFatGor.qryQuery.SQL.Clear;
  cdsFatGor.qryQuery.SQL.Add(SQLSelect);

  If Not fEmptyStr(edtCodEmp.Text) Then
  Begin
    cdsFatGor.qryQuery.SQL.Add(fStrLocate(edtCodEmp, arrEmpresa, 'FGO_CODEMP', 'FGO_CODEMP'));
    pSetaParam(edtCodEmp.Text, arrEmpresa, strEmpresas, 'FGO_CODEMP', cdsFatGor.qryQuery);
  End;

  If Not fEmptyStr(edtCodCli.Text) Then
  Begin
    cdsFatGor.qryQuery.SQL.Add(fStrLocate(edtCodCli, arrCliente, 'FGO_CODCLI', 'CODCLI'));
    pSetaParam(edtCodCli.Text, arrCliente, strClientes, 'CODCLI', cdsFatGor.qryQuery);
  End;

  If (Not fEmptyDate(mskDtaOrcIni.Text)) Then
  Begin
    cdsFatGor.qryQuery.SQL.Add('AND FGO_DTAENT >= :FGO_DTAENT_INI');
    cdsFatGor.qryQuery.ParamByName('FGO_DTAENT_INI').AsDateTime := StrToDate(mskDtaOrcIni.Text);
  End;

  If (Not fEmptyDate(mskDtaOrcFim.Text)) Then
  Begin
    cdsFatGor.qryQuery.SQL.Add('AND FGO_DTAENT <= :FGO_DTAENT_FIM');
    cdsFatGor.qryQuery.ParamByName('FGO_DTAENT_FIM').AsDateTime := StrToDate(mskDtaOrcFim.Text);
  End;

  If Not fEmptyStr(edtNumDoc.Text) Then
  Begin
    cdsFatGor.qryQuery.SQL.Add(fStrLocate(edtNumDoc, arrDocumento, 'FGO_NUMDOC', 'FGO_NUMDOC'));
    pSetaParam(edtNumDoc.Text, arrDocumento, strDocumento, 'FGO_NUMDOC', cdsFatGor.qryQuery);

    If Not(fEmptyStr(strCodEmpDocumento)) then
    Begin
      cdsFatGor.qryQuery.SQL.Add(' AND FGO_CODEMP = :FGO_CODEMP_DOC');
      cdsFatGor.qryQuery.ParamByName('FGO_CODEMP_DOC').AsString := strCodEmpDocumento;
    End;

  End;

  cdsFatGor.fAbreClient(True, 'TfrmCadLeadVincularOrcamentos.pMostrarOrcamentos', False);
  TFloatField(cdsFatGor.FieldByName('FGO_TOTPRO')).DisplayFormat := fMskDigitos(2);

end;

procedure TfrmCadLeadVincularOrcamentos.FormCreate(Sender: TObject);
begin
  inherited;

  cdsFatGor := TZClient.Create(Self);
  cxgOrcamentosDBTableViewCitel1.DataController.DataSource := cdsFatGor.dtsSource;
  qryFatGor := fCriaQuery;
  qryFatGor.SQL.Add('SELECT * FROM FATGOR WHERE FALSE');
  qryFatGor.Open;
  objLeads := TLeads.New();
end;

procedure TfrmCadLeadVincularOrcamentos.FormDestroy(Sender: TObject);
begin
  FreeAndNil(objLeads);
  FreeAndNil(cdsFatGor);
  FreeAndNil(qryFatGor);
  inherited;
end;

procedure TfrmCadLeadVincularOrcamentos.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
       VK_F10: Begin
                 If btnConfirmar.Enabled Then
                   btnConfirmar.Click;
               End;
    VK_ESCAPE: Begin
                 btnSair.Click;
               End;
  End;
end;

procedure TfrmCadLeadVincularOrcamentos.FormShow(Sender: TObject);
begin
  inherited;

  edtCodEmp.Clear;
  edtCodCli.Text := objLeads.strCodCli;
  mskDtaOrcIni.Text := FormatDateTime('dd/mm/yyyy', Today - 60);
  mskDtaOrcFim.Text := FormatDateTime('dd/mm/yyyy', Today);

  pMostrarOrcamentos;

  pSetFocus(edtCodEmp);

end;

function TfrmCadLeadVincularOrcamentos.fValidaAcessoEmpresa(const strEmpresa: string): Boolean;
Begin
  If Pos(strEmpresa, strEmpAcessoUsuarioLogado) <= 0 Then
  Begin
    fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso à Empresa ' + strEmpresa + '!', ['&O k']);
    Result := False;
  End
  Else
    Result := True;
End;

function TfrmCadLeadVincularOrcamentos.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
var
  intContador: Integer;
begin
  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = edtCodEmp)Then
    Begin
      If Not fEmptyStr(edtCodEmp.Text) Then
      Begin

        pCarregaEmpresa;
        If fEmptyStr(edtNomEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa não encontrada!', ['&Ok']);
          Result := False;
        End

        Else Begin

          If (Length(arrEmpresa) > 1) Then
          Begin

           For intContador := 0 To Length(arrEmpresa) -1 Do
            Begin
              Result := fValidaAcessoEmpresa(arrEmpresa[intContador].strCodigo);
              If Not Result then
                Break;
            End;

          End

          Else
            Result := fValidaAcessoEmpresa(edtCodEmp.Text);
        End;

      End
      Else
        edtNomEmp.Text := 'TODOS';
    End

    Else If (Sender = edtCodCli) Then
    Begin
      If Not fEmptyStr(edtCodCli.Text) Then
      Begin
        pCarregaCliente;
        If fEmptyStr(edtNomCli.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Este Código de CLIENTE não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End
      Else
        edtNomCli.Text := 'TODOS';
    End

    Else If (Sender = mskDtaOrcIni) Then
    Begin
      If ((Not fEmptyStr(mskDtaOrcIni.Text)) And (mskDtaOrcIni.Text <> '  /  /    ')) And
         ((Not fEmptyStr(mskDtaOrcFim.Text)) And (mskDtaOrcFim.Text <> '  /  /    ')) And
         (StrToDate(mskDtaOrcIni.Text) > StrToDate(mskDtaOrcFim.Text))  Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Inicial não pode ser maior que a data final!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = mskDtaOrcFim) Then
    Begin
      If ((Not fEmptyStr(mskDtaOrcIni.Text)) And (mskDtaOrcIni.Text <> '  /  /    ')) And
         ((Not fEmptyStr(mskDtaOrcFim.Text)) And (mskDtaOrcFim.Text <> '  /  /    ')) And
         (StrToDate(mskDtaOrcIni.Text) > StrToDate(mskDtaOrcFim.Text))  Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Inicial não pode ser maior que a data final!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtNumDoc) Then
    Begin
      If Not fEmptyStr(edtNumDoc.Text) Then
      Begin

        If Not fEmptyStr(edtCodEmp.Text) Then
        Begin
          If strCodEmpDocumento <> edtCodEmp.Text Then
          Begin
            fMensagem('ATENÇÃO!', 'Este DOCUMENTO não pertence à empresa informada!', ['&Ok']);
            Result := False;
          End;
        End;

        pCarregaDocumento;

        If fEmptyStr(edtDesNumDoc.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Este DOCUMENTO não está lançado!', ['&Ok']);
          Result := False;
        End;
      End
      Else
        edtDesNumDoc.Text := 'TODOS';

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

End;


procedure TfrmCadLeadVincularOrcamentos.SetObjLead(const AValue: ILeads);
begin
  objLeads := AValue;
end;

procedure TfrmCadLeadVincularOrcamentos.pCarregaCliente;
begin
  If (Length(arrCliente) > 1) Then
  Begin
    edtCodCli.Text := StringOfChar('0', edtCodCli.TamCampo);
    edtNomCli.Text := '+1';
  End
  else
    edtNomCli.Text := fRetNomCliente(edtCodCli.Text);
end;

procedure TfrmCadLeadVincularOrcamentos.pCarregaEmpresa;
begin
  If (Length(arrEmpresa) > 1) Then
  Begin
    edtCodEmp.Text := StringOfChar('0', edtCodEmp.TamCampo);
    edtNomEmp.Text := '+1';
  End
  else
    edtNomEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);
end;

class procedure TfrmCadLeadVincularOrcamentos.pAbrirTelaVincularOrcamentos(const aObjLead: ILeads);
  var
    frmCadLeadVincularOrcamentos: TfrmCadLeadVincularOrcamentos;
begin
  pCriarFormularios(TfrmCadLeadVincularOrcamentos, frmCadLeadVincularOrcamentos);
  try
    frmCadLeadVincularOrcamentos.SetObjLead(aObjLead);
    frmCadLeadVincularOrcamentos.ShowModal;
  Finally
    pFreeAndNil(frmCadLeadVincularOrcamentos);
  End;
end;

procedure TfrmCadLeadVincularOrcamentos.pVincularOrcamentoAoLead(const strOrcamento: string);
begin
  objLeads.pVincularOrcamentoAoLead(strOrcamento);
end;

procedure TfrmCadLeadVincularOrcamentos.pCarregaDocumento;
begin
  If (Length(arrDocumento) > 1) Then
    edtDesNumDoc.Text := '+1'
  Else
  Begin
    If fEmptyStr(edtNumDoc.Text) Then
      edtDesNumDoc.Text := 'TODOS'
    Else
      edtDesNumDoc.Text := edtNumDoc.Text;
  End;

end;

end.
