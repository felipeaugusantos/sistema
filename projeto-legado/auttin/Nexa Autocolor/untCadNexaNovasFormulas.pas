unit untCadNexaNovasFormulas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, Grids, ValEdit, EditFocus, Mask, DBCtrls, DBEditFocus,
  Uni, DB, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadNexaNovasFormulas = class(TfrmPaiCad)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    dbeCodigo: TDBEditFocus;
    dbeDescricao: TDBEditFocus;
    dbeMontadora: TDBEditFocus;
    dbeVariante: TDBEditFocus;
    dbeAnoInicio: TDBEditFocus;
    dbeTipo: TDBEditFocus;
    dbeVeiculo: TDBEditFocus;
    GroupBox1: TGroupBox;
    edtDescMon: TEditFocus;
    pnlCabecalho: TPanel;
    Label10: TLabel;
    dbeAcrMob: TDBEditFocus;
    pnl1: TPanel;
    Label9: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    lbl11: TLabel;
    lbl12: TLabel;
    lbl13: TLabel;
    lbl14: TLabel;
    lbl15: TLabel;
    lbl16: TLabel;
    lbl17: TLabel;
    lbl18: TLabel;
    lbl19: TLabel;
    lbl20: TLabel;
    lbl21: TLabel;
    lbl22: TLabel;
    lbl23: TLabel;
    lbl24: TLabel;
    lbl25: TLabel;
    lbl26: TLabel;
    lbl27: TLabel;
    lbl28: TLabel;
    lbl29: TLabel;
    lbl30: TLabel;
    lbl31: TLabel;
    lbl32: TLabel;
    lbl33: TLabel;
    lbl34: TLabel;
    lbl35: TLabel;
    lbl36: TLabel;
    lbl37: TLabel;
    lbl38: TLabel;
    lbl39: TLabel;
    dbeForm01: TDBEditFocus;
    dbeForm02: TDBEditFocus;
    dbeForm03: TDBEditFocus;
    dbeForm04: TDBEditFocus;
    dbeForm05: TDBEditFocus;
    dbeForm06: TDBEditFocus;
    dbeForm07: TDBEditFocus;
    dbeForm08: TDBEditFocus;
    dbeForm09: TDBEditFocus;
    dbeForm10: TDBEditFocus;
    dbeQtd10: TDBEditFocus;
    dbeQtd09: TDBEditFocus;
    dbeQtd08: TDBEditFocus;
    dbeQtd07: TDBEditFocus;
    dbeQtd06: TDBEditFocus;
    dbeQtd05: TDBEditFocus;
    dbeQtd04: TDBEditFocus;
    dbeQtd03: TDBEditFocus;
    dbeQtd02: TDBEditFocus;
    dbeQtd01: TDBEditFocus;
    dbeForm11: TDBEditFocus;
    dbeForm12: TDBEditFocus;
    dbeForm13: TDBEditFocus;
    dbeForm14: TDBEditFocus;
    dbeForm15: TDBEditFocus;
    dbeForm16: TDBEditFocus;
    dbeForm17: TDBEditFocus;
    dbeForm18: TDBEditFocus;
    dbeForm19: TDBEditFocus;
    dbeForm20: TDBEditFocus;
    dbeQtd20: TDBEditFocus;
    dbeQtd19: TDBEditFocus;
    dbeQtd18: TDBEditFocus;
    dbeQtd17: TDBEditFocus;
    dbeQtd16: TDBEditFocus;
    dbeQtd15: TDBEditFocus;
    dbeQtd14: TDBEditFocus;
    dbeQtd13: TDBEditFocus;
    dbeQtd12: TDBEditFocus;
    dbeQtd11: TDBEditFocus;
    btnAtivarNfm: TBitBtnLocked;
    dbchkAtivo: TDBCheckBox;
    Label28: TLabel;
    dbeDtaCad: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure dbeTipoKeyPress(Sender: TObject; var Key: Char);
    procedure dbeMontadoraKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure dbeForm01KeyPress(Sender: TObject; var Key: Char);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeQtd10KeyPress(Sender: TObject; var Key: Char);
    procedure btnPesquisaClick(Sender: TObject);
    procedure dbeMontadoraExit(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnAtivarNfmClick(Sender: TObject);
  private
    { Private declarations }
    qryCadNfm: TUniQuery;
    dtsCadNfm: TDataSource;
    arrOpcoesTipo: Array[1..7] of String;
    procedure pRetMontadora;
    procedure pCriaDataSets;
    procedure pLigaDataSets;
    function fJaExisteEssaBaseNaFormulacao(strCodBas: String; dbeForm: TObject): Boolean;
    procedure pAtivaNfm;
    procedure pAtivaCadTinta;

    procedure pAtivarDesativarNfm;
  public
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fValidaTipo: Boolean;
    function fValidaBase(strCodBas: String): Boolean;
    { Public declarations }
  end;

var
  frmCadNexaNovasFormulas: TfrmCadNexaNovasFormulas;

implementation

uses untFuncoesSimples,  untPai,
      untIConfTinta, untFuncTinta, untNexaDinamica, StrUtils, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmCadNexaNovasFormulas }

function TfrmCadNexaNovasFormulas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If Sender = dbeDescricao Then
    Begin
      If fEmptyStr(dbeDescricao.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'A descrição deve ser preenchida!', ['OK']);
        Result := False;
      End;
    End

    Else If Sender = dbeTipo Then
    Begin
      If fEmptyStr(dbeTipo.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O tipo deve ser preenchido!', ['OK']);
        Result := False;
      End
      Else If Not fValidaTipo Then
      Begin
        fMensagem('ATENÇÃO', 'O tipo selecionado não é válido!', ['OK']);
        Result := False;
      End;
    End

    Else If LeftStr(Sender.Name, 6) = 'dbeQtd' Then
    Begin
      If (Not fEmptyStr(TDBEdit(FindComponent('dbeForm' + RightStr(Sender.Name, 2))).Text))
        And (fStrToFloat(TDBEdit(Sender).Text) <= 0) Then
      Begin
        fMensagem('ATENÇÃO', 'A quantidade deve ser maior que zero!!', ['OK']);
        Result := False;
      End;
    End

    Else If LeftStr(Sender.Name, 7) = 'dbeForm' Then
    Begin
      If fEmptyStr(dbeForm01.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'Entre com pelo menos uma base!', ['OK']);
        Result := False;
      End
      Else If (Not fEmptyStr(TDBEdit(Sender).Text)) And (Not fValidaBase(TDBEdit(Sender).Text)) Then
      Begin
        fMensagem('ATENÇÃO', Format('%s Não é uma base válida, verifique o tipo!', [TDBEdit(Sender).Text]), ['OK']);
        Result := False;
      End

      Else If fJaExisteEssaBaseNaFormulacao(TDBEditFocus(Sender).Text, Sender) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa base já está cadastrada para essa fórmula!', ['&Ok']);
        Result := False;
      End

      Else If fEmptyStr(TDBEdit(Sender).Text) Then
      Begin
        pSetFocus(dbeQtd20);
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

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadNexaNovasFormulas.pAtivaCadTinta;
Var
  qryUpt: TUniQuery;
begin
  Try
    qryUpt := fCriaQuery(Nil);
    With qryUpt Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' UPDATE NEX_CADNEX ');
      SQL.Add('    SET NEX_ATIVO_ = :ATIVO_ ');
      SQL.Add('  WHERE NEX_CODCOR = :CODPRO ');
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

procedure TfrmCadNexaNovasFormulas.pAtivaNfm;
var
  qryUpt: TUniQuery;
begin
  Try
    qryUpt := fCriaQuery(Nil);
    With qryUpt Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' UPDATE NEX_CADNFM ');
      SQL.Add('    SET NFM_ATIVO_ = :ATIVO_ ');
      SQL.Add('  WHERE NFM_CODNFM = :CODPRO ');
      ParamByName('ATIVO_').AsString := IIF(qryTabela.FieldByName('NFM_ATIVO_').AsString = 'S','N','S');
      ParamByName('CODPRO').AsString := qryTabela.FieldByName('NFM_CODNFM').AsString;
      ExecSQL;
    End;
  Finally
    FreeAndNil(qryUpt);
  End;
end;

procedure TfrmCadNexaNovasFormulas.pAtivarDesativarNfm;
begin
  Try
    fStartTransaction;

    pAtivaNfm;
    pAtivaCadTinta;

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

procedure TfrmCadNexaNovasFormulas.pCriaDataSets;
  Var
    intCont: Integer;
begin
  {**********************************}
  {* CRIA OS DATASETS DINAMICAMENTE *}
  {*******************************PH*}

  qryCadNfm := fCriarQuery('SELECT * FROM NEX_CADNFM', Self);

  qryCadNfm.FieldByName('NFM_CODNFM').DisplayLabel := 'Código';
  qryCadNfm.FieldByName('NFM_DESCOR').DisplayLabel := 'Descrição';
  qryCadNfm.FieldByName('NFM_VARIAN').DisplayLabel := 'Variação';
  qryCadNfm.FieldByName('NFM_VEICUL').DisplayLabel := 'Veículo';
  qryCadNfm.FieldByName('NFM_MONTAD').DisplayLabel := 'Montadora';
  qryCadNfm.FieldByName('NFM_TIPO__').DisplayLabel := 'Tipo';
  qryCadNfm.FieldByName('NFM_A_N_O_').DisplayLabel := 'Ano';
  qryCadNfm.FieldByName('NFM_ACRMOB').DisplayLabel := 'Acréscimo mão de obra';
  qryCadNfm.FieldByName('NFM_DTACAD').DisplayLabel := 'Data Cadastro';

  qryCadNfm.FieldByName('AUTOINCREM').Visible := False;

  For intCont := 1 To 20 Do
  Begin
    TFloatField(qryCadNfm.FieldByName('NFM_QTDB' + fStrZero(intCont, 2))).DisplayFormat := '0.000';
  End;

  TFloatField(qryCadNfm.FieldByName('NFM_ACRMOB')).DisplayFormat := '0.00';

  dtsCadNfm := fCriaDataSource(qryCadNfm);
end;

procedure TfrmCadNexaNovasFormulas.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('NFM_CODNFM');
  stlCampos.Add('NFM_DESCOR');
  stlCampos.Add('NFM_VARIAN');
  stlCampos.Add('NFM_VEICUL');
  stlCampos.Add('NFM_MONTAD');
  stlCampos.Add('AUTOINCREM');
  stlCampos.Add('NFM_A_N_O_');

  stlCamInd.Add('NFM_CODNFM');
  stlCamInd.Add('NFM_DESCOR');
  stlCamInd.Add('NFM_VARIAN');
  stlCamInd.Add('NFM_VEICUL');
  stlCamInd.Add('NFM_MONTAD');
  stlCamInd.Add('AUTOINCREM');
  stlCamInd.Add('NFM_A_N_O_');

  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');
  stlDesInd.Add('Variante');
  stlDesInd.Add('Veículo');
  stlDesInd.Add('Montadora');
  stlDesInd.Add('Ano Início');
end;

procedure TfrmCadNexaNovasFormulas.pLigaDataSets;
  Var
    intCont: Integer;
begin

  For intCont := 0 To ComponentCount - 1 Do
  Begin
    If (Components[intCont] is TDBEdit) Then
    Begin
      (Components[intCont] as TDBEdit).DataSource := dtsCadNfm;
    End
    Else
    If (Components[intCont] is TDBCheckBox) Then
    Begin
      (Components[intCont] as TDBCheckBox).DataSource := dtsCadNfm;
    End;

  End;

  dbeCodigo.DataField    := 'NFM_CODNFM';
  dbeDescricao.DataField := 'NFM_DESCOR';
  dbeAnoInicio.DataField := 'NFM_A_N_O_';
  dbeMontadora.DataField := 'NFM_MONTAD';
  dbeTipo.DataField      := 'NFM_TIPO__';
  dbeVariante.DataField  := 'NFM_VARIAN';
  dbeVeiculo.DataField   := 'NFM_VEICUL';
  dbeAcrMob.DataField    := 'NFM_ACRMOB';
  dbchkAtivo.DataField   := 'NFM_ATIVO_';
  dbeDtaCad.DataField    := 'NFM_DTACAD';

  For intCont := 1 To 20 Do
  Begin
    TDBEdit(FindComponent('dbeForm' + fStrZero(intCont, 2))).DataField := 'NFM_CODB' + fStrZero(intCont, 2);
    TDBEdit(FindComponent('dbeQtd' + fStrZero(intCont, 2))).DataField := 'NFM_QTDB' + fStrZero(intCont, 2);
  End;
end;

procedure TfrmCadNexaNovasFormulas.FormCreate(Sender: TObject);
begin
  inherited;

  arrOpcoesTipo[1] := '2K';
  arrOpcoesTipo[2] := 'ACS (LA)';
  arrOpcoesTipo[3] := 'INDUSTRAN';
  arrOpcoesTipo[4] := 'SPECTRAL GREY';
  arrOpcoesTipo[5] := 'ZYNAMIX';
  arrOpcoesTipo[6] := 'ACS EVOLUTION (LA)';
  arrOpcoesTipo[7] := 'TURBO PLUS';

  pCriaDataSets;
  pLigaDataSets;

  qryTabela := qryCadNfm;
  strNomeTabela := 'NEX_CADNFM';
  strNomeCampo := 'NFM_CODNFM';

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

procedure TfrmCadNexaNovasFormulas.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  edtDescMon.Clear;

  dbchkAtivo.Checked := true;

  qryTabela.FieldByName('NFM_ATIVO_').AsString := 'S';
  qryTabela.FieldByName('NFM_DTACAD').AsDateTime := Date;

  pSetFocus(dbeDescricao);
end;

procedure TfrmCadNexaNovasFormulas.dbeTipoKeyPress(Sender: TObject;
  var Key: Char);
  Var
    intOpcao: Integer;
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    Key := #0;
    intOpcao := fGetMenu('Tipo de Bases', arrOpcoesTipo, 1, True);
    If intOpcao > 0 Then
      dbeTipo.Text := arrOpcoesTipo[intOpcao];
  End;
end;

function TfrmCadNexaNovasFormulas.fJaExisteEssaBaseNaFormulacao(
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

procedure TfrmCadNexaNovasFormulas.dbeMontadoraKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  If fPesqMontadoraTinta(Self, conNex, dbeMontadora, Nil, Nil, Key, arrSel) Then
  Begin
    pRetMontadora;
    SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadNexaNovasFormulas.pRetMontadora;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery(Self);

  qryGen.SQL.Clear;
  qrygen.SQL.Add('SELECT');
  qrygen.SQL.Add('  MON_DESCRI');
  qrygen.SQL.Add('FROM NEX_CADMON');
  qrygen.SQL.Add('WHERE MON_CODMON = :CODMON');

  qryGen.ParamByName('CODMON').AsString := dbeMontadora.Text;
  qryGen.Open;

  If qryGen.RecordCount > 0 Then
  Begin
    edtDescMon.Text := qryGen.FieldByName('MON_DESCRI').AsString;
  End;

  FreeAndNil(qryGen);
end;

procedure TfrmCadNexaNovasFormulas.btnGravarClick(Sender: TObject);
  Var
    blnInsert: Boolean;
    strNfm: String;
    conf: IConfTinta;
begin
  conf      := fGetConfTinta('NEX');
  qryTabela := qryCadNfm;
  blnInsert := (qryTabela.State = dsInsert);

  If (blnInsert) Then
  Begin
    strNfm := conf.fGet('PROCOD');
    qryTabela.FieldByName('NFM_CODNFM').AsString := 'ESP ' + VS_strCodEmp + fStrZero(strNfm, 5);
  End;
  fStartTransaction;
  inherited;

  Try
    If (blnGravou) Then
    Begin
      Screen.Cursor := crHourGlass;
      If TNexaAutomotivaDinamica.fGravaNovaFormula(qryCadNfm) Then
      Begin
        If (blnInsert) Then
        Begin
          conf.pSet('PROCOD', fStrZero(StrToInt(strNfm) + 1, 5));
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

procedure TfrmCadNexaNovasFormulas.dbeForm01KeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  fPesqBaseTinta(Self, conNex, TDBEdit(Sender), Nil, Nil, Key, arrSel);
  //  SelectNext(ActiveControl, True, True);
end;

function TfrmCadNexaNovasFormulas.fValidaTipo: Boolean;
begin
  Result := Pos(dbeTipo.Text, '2K ACS (LA) INDUSTRAN SPECTRAL GREY ZYNAMIX ACS EVOLUTION (LA) TURBO PLUS') > 0;
end;

function TfrmCadNexaNovasFormulas.fValidaBase(strCodBas: String): Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := nil;
  Result := False;
  Try
    Try
      qryGen := fCriaQuery(Self);
      qryGen.SQL.Clear;
      qryGen.SQL.Add('SELECT');
      qryGen.SQL.Add('  COUNT(*)    QTD');
      qryGen.SQL.Add('FROM NEX_CADBAS');
   //   qryGen.SQL.Add('WHERE BAS_CODBAS = :CODBAS AND BAS_TIPO__ = :TIPO');
      qryGen.SQL.Add('WHERE BAS_CODBAS = :CODBAS ');
      qryGen.ParamByName('CODBAS').AsString := strCodBas;
   //  qryGen.ParamByName('TIPO').AsString := dbeTipo.Text;
      qryGen.Open;

      Result := qryGen.FieldbyName('QTD').AsInteger > 0;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;
end;

procedure TfrmCadNexaNovasFormulas.btnAtivarNfmClick(Sender: TObject);
begin
  inherited;
  If fMensagem('QUESTÃO', 'Deseja realmente ' + IIF(qryTabela.FieldByName('NFM_ATIVO_').AsString = 'S','Desativar','Ativar') + ' essa nova fórmula ?', ['&Sim','&Não']) = 1 Then
    pAtivarDesativarNfm;

  btnAtivarNfm.Caption := IIF(qryTabela.FieldByName('NFM_ATIVO_').AsString = 'S','Desativar','Ativar');

end;

procedure TfrmCadNexaNovasFormulas.btnExcluirClick(Sender: TObject);
  Var
    strCodNfm: String;
begin
  strCodNfm := qryTabela.FieldByName('NFM_CODNFM').AsString;
  fStartTransaction;
  inherited;

  Try
    If blnExcluiu Then
    begin
      TNexaAutomotivaDinamica.fDelNovaFormula(strCodNfm);
      edtDescMon.Clear;
      fCommit;
    end
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

procedure TfrmCadNexaNovasFormulas.dbeQtd10KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If Key = #13 Then
    pSetFocus(dbeForm11);
end;

procedure TfrmCadNexaNovasFormulas.btnPesquisaClick(Sender: TObject);
  var
    arrSel: TConsultasArray;
    Key: Char;
begin
  key := '/';
  If fPesqFormulaTinta(Self, conNex, Nil, qryTabela, key, arrSel) Then
  Begin
    pRetMontadora;
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadNexaNovasFormulas.dbeMontadoraExit(Sender: TObject);
begin
  inherited;
  pRetMontadora;
end;

procedure TfrmCadNexaNovasFormulas.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pSetFocus(dbeDescricao);
end;

initialization
  RegisterClass(TfrmCadNexaNovasFormulas);
finalization
  UnRegisterClass(TfrmCadNexaNovasFormulas);

end.

