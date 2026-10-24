unit untCadStandoxNovasFormulas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  EditFocus, Mask, DBCtrls, DBEditFocus, StrUtils, DB, AppEvnts, Uni,
  DBComboBoxFocus, DBMemoFocus, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmCadStandoxNovasFormulas = class(TfrmPaiCad)
    pnlCentral: TPanel;
    pnlCabecalho: TPanel;
    Label1: TLabel;
    Label4: TLabel;
    dbeCodigo: TDBEditFocus;
    dbeDescri: TDBEditFocus;
    gpbColorantes: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    Label17: TLabel;
    Label19: TLabel;
    Label21: TLabel;
    dbeForm01: TDBEditFocus;
    dbeQtdC01: TDBEditFocus;
    dbeForm02: TDBEditFocus;
    dbeQtdC02: TDBEditFocus;
    dbeForm03: TDBEditFocus;
    dbeQtdC03: TDBEditFocus;
    dbeForm04: TDBEditFocus;
    dbeQtdC04: TDBEditFocus;
    dbeForm05: TDBEditFocus;
    dbeQtdC05: TDBEditFocus;
    dbeForm06: TDBEditFocus;
    dbeQtdC06: TDBEditFocus;
    dbeForm07: TDBEditFocus;
    dbeQtdC07: TDBEditFocus;
    dbeForm08: TDBEditFocus;
    dbeQtdC08: TDBEditFocus;
    Label2: TLabel;
    dbeDtaCad: TDBEditFocus;
    Label10: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label16: TLabel;
    Label18: TLabel;
    Label20: TLabel;
    Label22: TLabel;
    Label39: TLabel;
    dbeQualid: TDBEditFocus;
    Label41: TLabel;
    dbeMontad: TDBEditFocus;
    Label42: TLabel;
    dbeForm09: TDBEditFocus;
    Label43: TLabel;
    dbeQtdC09: TDBEditFocus;
    Label45: TLabel;
    dbeForm10: TDBEditFocus;
    Label46: TLabel;
    dbeQtdC10: TDBEditFocus;
    Label48: TLabel;
    dbeForm11: TDBEditFocus;
    Label49: TLabel;
    dbeQtdC11: TDBEditFocus;
    Label51: TLabel;
    dbeForm12: TDBEditFocus;
    Label52: TLabel;
    dbeQtdC12: TDBEditFocus;
    Label54: TLabel;
    dbeForm13: TDBEditFocus;
    Label55: TLabel;
    dbeQtdC13: TDBEditFocus;
    Label57: TLabel;
    dbeForm14: TDBEditFocus;
    Label58: TLabel;
    dbeQtdC14: TDBEditFocus;
    Label60: TLabel;
    dbeForm15: TDBEditFocus;
    Label61: TLabel;
    dbeQtdC15: TDBEditFocus;
    Label24: TLabel;
    Label25: TLabel;
    Label23: TLabel;
    Label26: TLabel;
    Label36: TLabel;
    dbeForm16: TDBEditFocus;
    dbeForm17: TDBEditFocus;
    dbeForm18: TDBEditFocus;
    dbeForm19: TDBEditFocus;
    dbeForm20: TDBEditFocus;
    Label37: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    dbeQtdC16: TDBEditFocus;
    dbeQtdC17: TDBEditFocus;
    dbeQtdC18: TDBEditFocus;
    dbeQtdC19: TDBEditFocus;
    dbeQtdC20: TDBEditFocus;
    btnAtivarNfm: TBitBtnLocked;
    dbchkAtivo: TDBCheckBox;
    dbeAnoFin: TDBEditFocus;
    dbeCatego: TDBEditFocus;
    dbeAnoIni: TDBEditFocus;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label27: TLabel;
    Label38: TLabel;
    Label40: TLabel;
    Label72: TLabel;
    Label74: TLabel;
    dbeVarian: TDBEditFocus;
    dbePais: TDBEditFocus;
    dbeVersao: TDBEditFocus;
    Label28: TLabel;
    dbeAcrMob: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeForm01KeyPress(Sender: TObject; var Key: Char);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnAtivarNfmClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
  private
    { Private declarations }
    qryCadNfm: TUniQuery;
    dtsCadNfm: TDataSource;
    procedure pCriaDataSets;
    procedure pLigaDataSets;
    procedure pBotaoAtivarNfm;
    procedure pAtivarDesativarNfm;
    procedure pAtivaNfm;
    procedure pAtivaCadStandox;
    function fJaExisteEssaBaseNaFormulacao(strCodBas: String; dbeForm: TObject): Boolean;
  protected
    function fValidaColorante(strCodCol: String): Boolean;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
    function VerificarNovaFormulaMovimentada: Boolean;
  public
    { Public declarations }
  end;

var
  frmCadStandoxNovasFormulas: TfrmCadStandoxNovasFormulas;

implementation

uses
      untModuloTinta, untPai, untStandox, untFuncoesSimples,
      untIConfTinta,untFuncTinta, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmCadStandoxNovasForumulas }

function TfrmCadStandoxNovasFormulas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    dbeForm: TDBEdit;
    dbeQtdC: TDBEdit;
begin

  Result := True;

  If (Sender = dbeCodigo) Then
  Begin
  End

  Else If (Sender = dbeDescri) Then
  Begin
    If (fEmptyStr(dbeDescri.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A descrição deve ser preenchida!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = dbeForm01) Then
  Begin
    If (fEmptyStr(dbeForm01.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'É necessário digitar pelo menos 1 colorante!', ['&Ok']);
      Result := False;
    End
    Else If (Not fValidaColorante(dbeForm01.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa base não está cadastrada!', ['&Ok']);
      Result := False;
    End;
  End

  Else If LeftStr(Sender.Name, 7) = 'dbeForm' Then
  Begin
    If (fStrToFloat(TDBEdit(FindComponent('dbeQtdC' + RightStr(Sender.Name, 2))).Text) > 0) And
       (fEmptyStr((TEdit(Sender).Text))) Then
    Begin
      fMensagem('ATENÇÃO!', 'É preciso preencher a base!', ['&Ok']);
      Result := False;
    End
    Else If (fEmptyStr((TEdit(Sender).Text))) Then
    Begin
      pSetFocus(dbeQtdC20);
    End
    Else If (Not fValidaColorante(TEdit(Sender).Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa base não está cadastrada!', ['&Ok']);
      Result := False;
    End
    Else If fJaExisteEssaBaseNaFormulacao(TDBEditFocus(Sender).Text, Sender) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa base já está cadastrada para essa fórmula!', ['&Ok']);
      Result := False;
    End;
  End

  Else If LeftStr(Sender.Name, 6) = 'dbeQtd' Then
  Begin
    dbeForm := TDBEdit(FindComponent('dbeForm' + RightStr(Sender.Name, 2)));
    dbeQtdC := TDBEdit(FindComponent('dbeQtdC' + RightStr(Sender.Name, 2)));

    If (dbeForm <> nil) And (LeftStr(Sender.Name, 7) = 'dbeQtdC') And (Not fEmptyStr(dbeForm.Text)) Then
    Begin
      If (fEmptyStr(dbeQtdC.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'É necessário digitar a quantidade da base!', ['&Ok']);
        Result := False;
      End
      Else If (fStrToFloat(dbeQtdC.Text) <= 0)Then
      Begin
        fMensagem('ATENÇÃO!', 'É necessário digitar a quantidade da base!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (dbeForm <> nil) And (LeftStr(Sender.Name, 7) = 'dbeQtdC') And (fEmptyStr(dbeForm.Text)) Then
    Begin
      If (fStrToFloat(dbeQtdC.Text) > 0)Then
      Begin
        fMensagem('ATENÇÃO!', 'É necessário digitar a base!', ['&Ok']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = dbeAcrMob) Then
  Begin
    If fEmptyStr(dbeAcrMob.Text) Then
    Begin
      dbeAcrMob.Field.AsFloat := 0.00;
    End
    Else If Not fEmptyStr(dbeAcrMob.Text) Then
    Begin
      If (fStrToFloat(dbeAcrMob.Text) < 0) Then
      Begin
        Result := fMensagem('ATENÇÃO', 'O Acréscimo de Mão de Obra deve ser maior ou igual a zero', ['OK']) = -1;
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

function TfrmCadStandoxNovasFormulas.fValidaColorante(
  strCodCol: String): Boolean;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  COUNT(*) AS QTD ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  DOX_CADBAS ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  BAS_CODBAS = :CODBAS ';

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODBAS').AsString := strCodCol;
    Open;
    Result := (FieldByName('QTD').AsInteger > 0);
    Close;
  End;
end;

procedure TfrmCadStandoxNovasFormulas.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('NFM_CODNFM');
  stlCampos.Add('NFM_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('NFM_CODNFM');
  stlCamInd.Add('NFM_DESCRI');
  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');
end;

procedure TfrmCadStandoxNovasFormulas.pLigaDataSets;
var
  intCont: Integer;
begin

  For intCont := 0 To ComponentCount - 1 Do
  Begin
    If (Components[intCont] is TDBEdit) Then
    Begin
      (Components[intCont] as TDBEdit).DataSource := dtsCadNfm;
    End;

    If (Components[intCont] is TDBMemoFocus) Then
    Begin
      (Components[intCont] as TDBMemoFocus).DataSource := dtsCadNfm;
    End;

    If (Components[intCont] is TDBCheckBox) Then
    Begin
      (Components[intCont] as TDBCheckBox).DataSource := dtsCadNfm;
    End;

    If (Components[intCont] is TDBComboBoxFocus) Then
    Begin
      (Components[intCont] as TDBComboBoxFocus).DataSource := dtsCadNfm;
    End;
  End;
end;

function TfrmCadStandoxNovasFormulas.VerificarNovaFormulaMovimentada: Boolean;
begin
  Try
    Result := fVerificarNovaFormulaMovimentada('SELECT COUNT(0) AS QTD FROM %0:s INNER JOIN DOX_CADDOX ON %1:s_ITETIN = DOX_MD5KEY WHERE DOX_CODNFM = :CODNFM',
      [qryTabela.FieldByName('NFM_CODNFM').AsString]);
  Except
    on E: Exception do
    begin
      raise;
    end;
  End;
end;

procedure TfrmCadStandoxNovasFormulas.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaDataSets;
  pLigaDataSets;

  strNomeTabela := 'DOX_CADNFM';
  strNomeCampo  := 'NFM_CODNFM';
  qryTabela := qryCadNfm;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;

  dtsCadNfm.DataSet := qryTabela;

  btnAtivarNfm.Enabled := False;
end;

procedure TfrmCadStandoxNovasFormulas.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;

  dbeCodigo.Enabled := False;
  pSetFocus(dbeDescri);
  dbeDtaCad.Field.AsDateTime := Date;

  dbeQtdC01.Field.AsFloat := 0.0;
  dbeQtdC02.Field.AsFloat := 0.0;
  dbeQtdC02.Field.AsFloat := 0.0;
  dbeQtdC03.Field.AsFloat := 0.0;
  dbeQtdC04.Field.AsFloat := 0.0;
  dbeQtdC05.Field.AsFloat := 0.0;
  dbeQtdC06.Field.AsFloat := 0.0;
  dbeQtdC07.Field.AsFloat := 0.0;
  dbeQtdC08.Field.AsFloat := 0.0;
  dbeQtdC09.Field.AsFloat := 0.0;
  dbeQtdC10.Field.AsFloat := 0.0;
  dbeQtdC11.Field.AsFloat := 0.0;
  dbeQtdC12.Field.AsFloat := 0.0;
  dbeQtdC13.Field.AsFloat := 0.0;
  dbeQtdC14.Field.AsFloat := 0.0;
  dbeQtdC15.Field.AsFloat := 0.0;
  dbeQtdC16.Field.AsFloat := 0.0;
  dbeQtdC17.Field.AsFloat := 0.0;
  dbeQtdC18.Field.AsFloat := 0.0;
  dbeQtdC19.Field.AsFloat := 0.0;
  dbeQtdC20.Field.AsFloat := 0.0;
  dbchkAtivo.Field.AsString := 'S';

  If btnAtivarNfm.Enabled Then
    btnAtivarNfm.Enabled := False;
end;

procedure TfrmCadStandoxNovasFormulas.btnPesquisaClick(Sender: TObject);
  var
    arrSel: TConsultasArray;
    Key: Char;
begin
  key := '/';
  If fPesqFormulaTinta(Self, conDox, Nil, qryTabela, key, arrSel) Then
  Begin
    pBotaoAtivarNfm;
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadStandoxNovasFormulas.btnAlterarClick(Sender: TObject);
begin
  if VerificarNovaFormulaMovimentada then
  begin
    fMensagem('ATENÇÃO', 'Já existe movimentação para essa fórmula, por isso não é possivel alterá-la', ['&OK']);
    Exit;
  end;  
  
  inherited;
  dbeCodigo.Enabled := False;
  If (dbeDescri.Enabled) Then
    pSetFocus(dbeDescri);
end;

procedure TfrmCadStandoxNovasFormulas.btnGravarClick(Sender: TObject);
  Var
    blnInsert: Boolean;
    strNfmBri: String;
    conf: IConfTinta;
begin
  blnInsert := (qryTabela.State = dsInsert);
  conf := fGetConfTinta('DOX');
  
  If (blnInsert) Then
  Begin
    strNfmBri := conf.fGet('NFMDOX');
    qryTabela.FieldByName('NFM_CODNFM').AsString := 'ESP ' + VS_strCodEmp + fStrZero(strNfmBri, 5);
  End;

  fStartTransaction;
  inherited;

  Try
    If (blnGravou) Then
    Begin

      Screen.Cursor := crHourGlass;

      If (fGeraNovasFormulas(qryTabela)) Then
      Begin
        If (blnInsert) Then
        Begin
          conf.pSet('NFMDOX', fStrZero(StrToInt(strNfmBri) + 1, 5));
        End;

        fCommit;
      End
      Else
        fRollBack;

      Screen.Cursor := crDefault;
      blnGravou := False;
    End
    Else
      fRollBack;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[btnGravarClick]');
    End;
  End;
end;

procedure TfrmCadStandoxNovasFormulas.btnAtivarNfmClick(Sender: TObject);
begin
  inherited;
  If fMensagem('QUESTÃO', 'Deseja realmente ' + IIF(qryTabela.FieldByName('NFM_ATIVO_').AsString = 'S','Desativar','Ativar') + ' essa nova fórmula ?', ['&Sim','&Não']) = 1 Then
    pAtivarDesativarNfm;

  btnAtivarNfm.Caption := IIF(qryTabela.FieldByName('NFM_ATIVO_').AsString = 'S','Desativar','Ativar');
end;

procedure TfrmCadStandoxNovasFormulas.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pBotaoAtivarNfm;
end;

procedure TfrmCadStandoxNovasFormulas.btnExcluirClick(Sender: TObject);
  Var
    strCodigo: String;
begin
  if VerificarNovaFormulaMovimentada then
  begin
    fMensagem('ATENÇÃO', 'Já existe movimentação para essa fórmula, por isso não é possivel excluí-la', ['&OK']);
    Exit;
  end;

  strCodigo := qryTabela.FieldByName('NFM_CODNFM').AsString;
  fStartTransaction;
  inherited;

  Try
    If (blnExcluiu) Then
    Begin
      pDeletaNovaFormula(strCodigo);
      fCommit;
      blnExcluiu := False;
      If btnAtivarNfm.Enabled Then
        btnAtivarNfm.Enabled := False;
    End
    Else
      fRollBack;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[btnExcluirClick]');
    End;
  End;
end;

procedure TfrmCadStandoxNovasFormulas.dbeForm01KeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If fPesqBaseTinta(Self, conDox, TDBEditFocus(Sender), Nil, Nil, Key, arrSel) Then
    If (fValidaCampos(TDBEditFocus(Sender))) Then
      Self.SelectNext(ActiveControl, True, True);
end;

function TfrmCadStandoxNovasFormulas.fJaExisteEssaBaseNaFormulacao(
  strCodBas: String; dbeForm: TObject): Boolean;
var
  intCont: Integer;
begin
  Result := False;

  For intCont := 1 To 20 Do
  Begin
    If (RightStr(TDBEditFocus(dbeForm).Name, 2) <> fStrZero(intCont,2)) And
       (Not fEmptyStr(TDBEditFocus(FindComponent('dbeForm' + fStrZero(intCont,2))).Text)) Then
    Begin
      If TDBEditFocus(FindComponent('dbeForm' + fStrZero(intCont,2))).Text = strCodBas Then
        Result := True;
    End;    
  End;
end;

procedure TfrmCadStandoxNovasFormulas.pAtivaCadStandox;
var
  qryUpt: TUniQuery;
begin
  Try
    qryUpt := fCriaQuery(Nil);
    With qryUpt Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' UPDATE DOX_CADDOX ');
      SQL.Add('    SET DOX_ATIVO_ = :ATIVO_ ');
      SQL.Add('  WHERE DOX_CODNFM = :CODPRO ');
      ParamByName('ATIVO_').AsString := IIF(qryTabela.FieldByName('NFM_ATIVO_').AsString = 'S','N','S');
      ParamByName('CODPRO').AsString := qryTabela.FieldByName('NFM_CODNFM').AsString;
      ExecSQL;
    End;
  Finally
    FreeAndNil(qryUpt);
  End;
end;

procedure TfrmCadStandoxNovasFormulas.pAtivaNfm;
var
  qryUpt: TUniQuery;
begin
  Try
    qryUpt := fCriaQuery(Nil);
    With qryUpt Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' UPDATE DOX_CADNFM ');
      SQL.Add('    SET NFM_ATIVO_ = :ATIVO_ ');
      SQL.Add('  WHERE NFM_CODNFM = :CODPRO ');
      ParamByName('ATIVO_').AsString := IIF(qryTabela.FieldByName('NFM_ATIVO_').AsString = 'S','N','S');
      ParamByName('CODPRO').AsString := qryTabela.FieldByName('NFM_CODNFM').AsString;
      ExecSQL;

      qryTabela.Edit;
      qryTabela.FieldByName('NFM_ATIVO_').AsString := IIF(qryTabela.FieldByName('NFM_ATIVO_').AsString = 'S','N','S');
      qryTabela.Post;
    End;
  Finally
    FreeAndNil(qryUpt);
  End;
end;

procedure TfrmCadStandoxNovasFormulas.pAtivarDesativarNfm;
begin
  Try
    fStartTransaction;

    pAtivaNfm;
    pAtivaCadStandox;

    fCommit;

    fMensagem('ATENÇÃO!', 'Nova Fórmula ' + IIF(qryTabela.FieldByName('NFM_ATIVO_').AsString = 'S','Ativada','Desativada') + ' com sucesso !' , ['&Ok']);
  Except
    On E: Exception Do
    Begin
      fRollBack;
      fMensagem('ATENÇÃO!', 'Erro na hora de ' + IIF(qryTabela.FieldByName('NFM_ATIVO_').AsString = 'S','Ativar','Desativar') + ' a nova fórmula !', ['&Ok']);
    End;
  End;
end;

procedure TfrmCadStandoxNovasFormulas.pBotaoAtivarNfm;
begin
  btnAtivarNfm.Enabled   := False;
  If Not qryTabela.IsEmpty Then
  Begin
    btnAtivarNfm.Enabled := VerificarNovaFormulaMovimentada;
    btnAtivarNfm.Caption := IIF(btnAtivarNfm.Enabled,
                            IIF(qryTabela.FieldByName('NFM_ATIVO_').AsString = 'S','Desativar','Ativar'),'Ativar');
  End;
end;


procedure TfrmCadStandoxNovasFormulas.pCriaDataSets;
Var
  intCont: Integer;
begin
  {**********************************}
  {* CRIA OS DATASETS DINAMICAMENTE *}
  {*******************************PH*}

  qryCadNfm := fCriarQuery('SELECT * FROM DOX_CADNFM', Self);

  qryCadNfm.FieldByName('NFM_CODNFM').DisplayLabel := 'Código';
  qryCadNfm.FieldbyName('NFM_DESCRI').DisplayLabel := 'Descrição';
  qryCadNfm.FieldbyName('NFM_DTACAD').DisplayLabel := 'Data de Cadastro';
  qryCadNfm.FieldbyName('NFM_MONTAD').DisplayLabel := 'Montadora';
  qryCadNfm.FieldbyName('NFM_ATIVO_').DisplayLabel := 'Ativo';

  qryCadNfm.FieldbyName('NFM_ACRMOB').DisplayLabel := 'Acréscimo mão de obra';

  qryCadNfm.FieldByName('AUTOINCREM').Visible := False;

  For intCont := 1 To 20 Do
  Begin
    TFloatField(qryCadNfm.FieldByName('NFM_QTDC' + fStrZero(intCont, 2))).DisplayFormat := '0.000';
  End;

  TFloatField(qryCadNfm.FieldByName('NFM_ACRMOB')).DisplayFormat := '0.00';

  dtsCadNfm := fCriaDataSource(qryCadNfm);
end;

initialization
  RegisterClass(TfrmCadStandoxNovasFormulas);
finalization
  UnRegisterClass(TfrmCadStandoxNovasFormulas);
end.

