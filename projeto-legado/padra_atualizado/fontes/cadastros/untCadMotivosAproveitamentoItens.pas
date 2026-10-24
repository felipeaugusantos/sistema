unit untCadMotivosAproveitamentoItens;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, Uni, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, DBComboBoxFocus, Data.DB;

type
  TfrmCadMotivosAproveitamentoItens = class(TfrmPaiCad)
    dbeDescri: TDBEditFocus;
    dbeCodigo: TDBEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    dbcbTIPMOT: TDBComboBoxFocus;
    Label3: TLabel;
    pnlDados: TPanel;
    procedure FormShow(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure pqryCadMaiAfterOpen(Sender: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    qryCadMai: TUniQuery;
    dtsDados: TDataSource;
    procedure pqryCadMaiTIPMOTOnGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure pQryCadMAITIPMOTSetText(Sender: TField;  const Text: string);
    function fDescricaoCadastrada(const strDescri, strCodEmp, strTipMot: String): Boolean;
    function fValidarDescricao(const strDescri: String): Boolean;
    { Private declarations }
  protected
    procedure pInicializaIndices; override;
  public
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    { Public declarations }
  end;

var
  frmCadMotivosAproveitamentoItens: TfrmCadMotivosAproveitamentoItens;

implementation
 uses
  untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmCadMotivosAproveitamentoItens }

procedure TfrmCadMotivosAproveitamentoItens.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeDescri, False);
end;

procedure TfrmCadMotivosAproveitamentoItens.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadMotivosAproveitamentoItens.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadMotivosAproveitamentoItens.btnGravarClick(Sender: TObject);
begin
  if Not fValidaPanel(pnlDados) Then
    Exit;

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadMotivosAproveitamentoItens.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadMotivosAproveitamentoItens.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeDescri, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);

end;

procedure TfrmCadMotivosAproveitamentoItens.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrMotivo: TConsultasArray;
    strCodigo, strDescri, strTipMot: String;
begin
  {************************************}
  {* NOVA CONSULTA DE GRUPO DE PREÇOS *}
  {*********************************RV*}
  chrKey := '/';
  fPesqMotAproveitamentoItem(Self, strCodigo, strDescri, strTipMot, qryTabela, chrKey, arrMotivo);
    pSetFocus(btnAlterar);
end;

function TfrmCadMotivosAproveitamentoItens.fDescricaoCadastrada(const strDescri,
  strCodEmp, strTipMot: String): Boolean;
  Var
    qry: TUniquery;
begin
  Result := False;
  Qry := Nil;
  Try
    Qry := fCriaQuery;
    Qry.Close;
    Qry.Sql.Add('SELECT COUNT(1) CONTAGEM FROM CADMAI WHERE MAI_CODEMP = :CODEMP AND MAI_TIPMOT = :TIPMOT AND MAI_DESCRI = :DESCRI');
    Qry.ParamByName('CODEMP').AsString := strCodEmp;
    Qry.ParamByName('TIPMOT').AsString := strTipMot;
    Qry.ParamByName('DESCRI').AsString := strDescri;
    Qry.Open;
    if Qry.IsEmpty then
      Exit;
    Result := Qry.FieldByName('CONTAGEM').AsInteger > 0;
  Finally
    if Assigned(Qry) Then
      FreeAndNil(Qry);
  End
end;

procedure TfrmCadMotivosAproveitamentoItens.FormCreate(Sender: TObject);
var
  intCont: Integer;
begin
  inherited;
  strNomeTabela := 'CADMAI';
  strNomeCampo  := 'MAI_CODIGO';
  qryCadMai     := fCriarQuery('SELECT * FROM CADMAI', Self);

  qryCadMai.FieldByName('MAI_CODIGO').DisplayLabel := 'Código';
  qryCadMai.FieldbyName('MAI_DESCRI').DisplayLabel := 'Descrição';
  qryCadMai.FieldbyName('MAI_TIPMOT').DisplayLabel := 'Tipo';

  qryCadMai.FieldByName('MAI_CODEMP').Visible := False;
  qryCadMai.FieldByName('AUTOINCREM').Visible := False;
  qryCadMai.AfterOpen := pqryCadMaiAfterOpen;
  dtsDados  := fCriaDataSource(qryCadMai);
  qryTabela := qryCadMai;

  For intCont := 0 To ComponentCount - 1 Do
  Begin
    If (Components[intCont] is TDBEdit) Then
    Begin
      (Components[intCont] as TDBEdit).DataSource := dtsDados;
    End;
  End;
  dbcbTIPMOT.DataSource := dtsDados;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

procedure TfrmCadMotivosAproveitamentoItens.FormDestroy(Sender: TObject);
begin

  if Assigned(stlCampos) then
    FreeAndNil(stlCampos);

  if Assigned(stlCamInd) then
    FreeAndNil(stlCamInd);

  if Assigned(stlDesInd) then
    FreeAndNil(stlDesInd);

  if Assigned(stlDesInd) then
    FreeAndNil(stlDesInd);


  if Assigned(dtsDados) then
    FreeAndNil(dtsDados);

  if Assigned(qryCadMai) then
    FreeAndNil(qryCadMai);

  inherited;

end;

procedure TfrmCadMotivosAproveitamentoItens.FormShow(Sender: TObject);
begin
  inherited;
  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;
end;

function TfrmCadMotivosAproveitamentoItens.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = dbeCodigo) Then
    Begin
      If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Motivo deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End

    Else If (Sender = dbeDescri) Then
    Begin
      if (dbcbTIPMOT.ItemIndex <> -1) then
      begin
        Result := fValidarDescricao(dbeDescri.Text);
      end;
    End

    Else If (Sender = dbcbTIPMOT) Then
    Begin
      if (dbcbTIPMOT.ItemIndex = -1) then
      begin
        fMensagem('ATENÇÃO!', 'O tipo deve ser preenchido!', ['&Ok']);
        Result := False;
      end;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmCadMotivosAproveitamentoItens.fValidarDescricao(
  const strDescri: String): Boolean;
begin
  Result := True;
  if fEmptyStr(strDescri) then
  begin
    fMensagem('ATENÇÃO!', 'A descrição deve ser preenchida!', ['&Ok']);
    Exit(False);
  end;

  if fDescricaoCadastrada(strDescri,
                          VS_strCodEmp,
                          qryCadMai.FieldByName('MAI_TIPMOT').AsString) Then
  begin
    fMensagem('ATENÇÃO!', 'A descrição e tipo já cadastrados!', ['&Ok']);
    Exit(False);
  end;

end;

procedure TfrmCadMotivosAproveitamentoItens.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('MAI_CODIGO');
  stlCampos.Add('MAI_DESCRI');
  stlCampos.Add('MAI_TIPMOT');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('MAI_DESCRI');
  stlCamInd.Add('MAI_CODIGO');
  stlCamInd.Add('MAI_TIPMOT');
  stlCamInd.Add('AUTOINCREM');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
  stlDesInd.Add('Tipo');
  stlDesInd.Add('AUTOINCREM');
end;

procedure TfrmCadMotivosAproveitamentoItens.pqryCadMaiTIPMOTOnGetText(
  Sender: TField; var Text: string; DisplayText: Boolean);
  Var
    intIdx: Integer;
begin
  if TryStrToInt(Sender.AsString,intIdx) then
    Text :=   dbcbTIPMOT.Items[intIdx];
end;

procedure TfrmCadMotivosAproveitamentoItens.pQryCadMAITIPMOTSetText(
  Sender: TField; const Text: string);
begin
  Sender.AsString := IntToStr(DBCBTIPMOT.ItemIndex);
end;

procedure TfrmCadMotivosAproveitamentoItens.pqryCadMaiAfterOpen(
  Sender: TDataSet);
  Var
    objqryTabelaMai_TipMot: TField;
begin
  objqryTabelaMai_TipMot := qryTabela.FindField('MAI_TIPMOT');
  if Assigned(objqryTabelaMai_TipMot) Then
  begin
    objqryTabelaMai_TipMot.OnGetText := pqryCadMaiTIPMOTOnGetText;
    objqryTabelaMai_TipMot.OnSetText := pQryCadMAITIPMOTSetText;
  end;
end;

end.
