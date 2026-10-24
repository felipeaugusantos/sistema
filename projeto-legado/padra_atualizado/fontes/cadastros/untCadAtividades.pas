{***********************}
{* qryCadAti -> CADATI *}
{********************RV*}
unit untCadAtividades;

interface

uses
  Classes, Controls, Forms, StdCtrls, untPaiCad, ComCtrls, ExtCtrls, DBCtrls,
  DBEditFocus, Menus, AppEvnts, cxHint, DB, Uni, Buttons, BitBtnLockedIncrem, EditFocus,
  dxScreenTip, cxClasses, dxCustomHint, Mask, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmCadAtividades = class(TfrmPaiCad)
    Label1: TLabel;
    dbeCodigo: TDBEditFocus;
    dbeDesAti: TDBEditFocus;
    Label2: TLabel;
    pnlFundo: TPanel;
    Label3: TLabel;
    dbeTabPre: TDBEditFocus;
    HintControler: TcxHintStyleController;
    dtsCadAti: TDataSource;
    Label5: TLabel;
    dbeCodGat: TDBEditFocus;
    edtDesGat: TEditFocus;
    pnlRenPre: TPanel;
    Label4: TLabel;
    dbeRenPre: TDBEditFocus;
    pnlPerCom: TPanel;
    Label18: TLabel;
    Label6: TLabel;
    dbePerCom: TDBEditFocus;
    dbePercentualComissaoEmPromocao: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbeTabPreEnter(Sender: TObject);
    procedure dbeTabPreExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnGravarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure dbeCodGatKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    qryCadAti: TUniQuery;

    procedure pAlteraDiversos(strCodAti: String; fltPerCom, AfltPercentualComissaoEmPromocao: Double);
    procedure pAfterScroll(Dataset: TDataset);
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;


implementation

uses SysUtils, StrUtils, untFuncoesSimples, untPai, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadAtividades.FormCreate(Sender: TObject);
  Var
    intIndice: Integer;
begin
  inherited;
  strNomeTabela         := 'CADATI';
  strNomeCampo          := 'ATI_CODATI';

  qryCadAti             := fCriaQuery(Self);
  qryTabela             := qryCadAti;
  dtsCadAti.DataSet     := qryTabela;

  qryTabela.AfterScroll := pAfterScroll;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0]     := dbeCodigo;

  For intIndice := 1 To Length(Trim(VS_strTabVen)) Do
  Begin

    If VS_strTabVen[intIndice] = 'S' Then
    Begin

      If (intIndice > 1) And (Not fEmptyStr(dbeTabPre.Hint)) Then
        dbeTabPre.Hint := dbeTabPre.Hint + ' - ';

      dbeTabPre.Hint := dbeTabPre.Hint + IntToStr(intIndice);

    End;

  End;

  pnlRenPre.Visible := fCfgSis('SISCRE', varBoolean);
  
end;

function TfrmCadAtividades.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin

  Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = dbeCodigo) Then
    Begin
      If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da Atividade deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End

    Else If (Sender = dbeTabPre) Then
    Begin

      If Not fEmptyStr(dbeTabPre.Text) Then
      Begin
        If Pos(dbeTabPre.Text,AnsiReplaceStr(dbeTabPre.Hint,' - ','')) <= 0 Then
        Begin
          fMensagem('','A Tabela de preço não é permitida!', ['&Ok']);
          Result := False;
        End;
      End;

    End

    Else If (Sender = dbeDesAti) Then
    Begin
      If fEmptyStr(dbeDesAti.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição da Atividade deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbePerCom) And pnlPerCom.Visible Then
    Begin
      If fStrToFloat(dbePerCom.Text) < 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O percentual de comissão deve ser maior ou igual a zero!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeRenPre) And pnlRenPre.Visible Then
    Begin
      If fStrToFloat(dbeRenPre.Text) < 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'A renda presumida não deve ser um valor negativo!', ['&Ok']);
        Result := False;
      End;
    End

    Else If Sender = dbeCodGat Then
    Begin
      If Not fEmptyStr(dbeCodGat.Text) Then
      Begin
        edtDesGat.Text := fRetDescGrupoAtividade(dbeCodGat.Text);

        If fEmptyStr(edtDesGat.Text) Then
        Begin
          pMensagemOk('Grupo de Atividade não encontrado!');
          Result := False;
        End;
      End;
    End

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadAtividades.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('ATI_CODATI');
  stlCampos.Add('ATI_DESATI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('ATI_DESATI');
  stlCamInd.Add('ATI_CODATI');
  
  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

procedure TfrmCadAtividades.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeTabPre, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);
end;

procedure TfrmCadAtividades.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrAtiv: TConsultasArray;
begin
  {*******************************}
  {* NOVA CONSULTA DE ATIVIDADES *}
  {****************************RV*}
  chrKey := '/';
  If fPesqAtividade(Self, Nil, Nil, qryTabela, chrKey, arrAtiv) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadAtividades.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeTabPre, False);
end;

procedure TfrmCadAtividades.FormShow(Sender: TObject);
begin
  inherited;
  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;

  pnlPerCom.Visible := fCfgSis('DIVCOM') = '2';

  If Not pnlPerCom.Visible Then
    Self.Height := Self.Height - pnlPerCom.Height;

  If Not pnlRenPre.Visible Then
    Self.Height := Self.Height - pnlRenPre.Height;

  If btnIncluir.Enabled Then
    pSetFocus(btnIncluir);
end;

procedure TfrmCadAtividades.dbeCodGatKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  If fPesqGrupoAtividade(Self, dbeCodGat, edtDesGat, Nil, Key, arrSel) Then
  Begin
    If fValidaCampos(dbeCodGat) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadAtividades.dbeTabPreEnter(Sender: TObject);
begin
  inherited;
  HintControler.ShowHint(Self.Left + dbeTabPre.Left + dbeTabPre.Width,
                         15 + Self.Top + dbeTabPre.Top + dbeTabPre.Height, 'CAMPO INFORMATIVO, Não utilizado no faturamento.' + #13#10 + 'Tabelas permitidas:', dbeTabPre.Hint);
end;

procedure TfrmCadAtividades.dbeTabPreExit(Sender: TObject);
begin
  inherited;
  HintControler.HideHint;
end;

procedure TfrmCadAtividades.pAfterScroll(Dataset: TDataset);
begin
  TFloatField(Dataset.FieldByName('ATI_RENPRE')).DisplayFormat := '#,##0.00';
  TFloatField(Dataset.FieldByName('ATI_RENPRE')).EditFormat    := '#,##0.00';
  edtDesGat.Text := fRetDescGrupoAtividade(Dataset.FieldByName('ATI_CODGAT').AsString);

  If Dataset.State = dsBrowse Then
    HintControler.HideHint;
end;

procedure TfrmCadAtividades.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(btnIncluir);
end;

procedure TfrmCadAtividades.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  HintControler.HideHint;

  inherited;

  If (Action <> CaNone) Then
    qryTabela.AfterScroll := Nil;

end;

procedure TfrmCadAtividades.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadAtividades.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadAtividades.btnGravarClick(Sender: TObject);
begin
  blnGravou := False;

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pnlInfo.Caption := '';
      pMensagensErro(E.Message, '[untCadAtividades.btnGravarClick]');
    End;
  End;

  Try
    If blnGravou And pnlPerCom.Visible Then
    Begin
      With qryTabela Do
        pAlteraDiversos(FieldByName('ATI_CODATI').AsString,
                        FieldByName('ATI_PERCOM').AsFloat,
                        FieldByName('ATI_PERCOP').AsFloat);

      fCommit;
    End
    Else If blnGravou Then
      fCommit
    Else If Not blnGravou Then
    Begin
      fRollBack;
      pnlInfo.Caption := '';
    End;
  Except
    fRollBack;
    pnlInfo.Caption := '';
  End;
end;

procedure TfrmCadAtividades.pAlteraDiversos(strCodAti: String; fltPerCom, AfltPercentualComissaoEmPromocao: Double);
  Var
    qryCadDiv: TUniQuery;
Begin
  Try
    qryCadDiv := fCriaQuery(Self);
    With qryCadDiv, SQl Do
    Begin
      Clear;
      Add('UPDATE CADDIV');
      Add('SET DIV_PERCOM = :PERCOM, ');
      Add('    DIV_PERCOP = :PERCOP  ');
      Add('WHERE ');
      Add('DIV_CODATI = :CODATI');

      ParamByName('CODATI').AsString := strCodAti;
      ParamByName('PERCOM').AsFloat  := fltPerCom;
      ParamByName('PERCOP').AsFloat  := AfltPercentualComissaoEmPromocao;

      ExecSQL;
    End;
    FreeAndNil(qryCadDiv);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pAlteraDiversos]');
    End;
  End;
End;

end.

