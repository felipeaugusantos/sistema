unit untCadPpgNovasFormulas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, Grids, ValEdit, EditFocus, Mask, DBCtrls, DBEditFocus,
  Uni, DB, BitBtnLockedIncrem, untTypesSistema,
  untFuncoesSimples, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadPpgNovasFormulas = class(TfrmPaiCad)
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
    Label8: TLabel;
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
    Label9: TLabel;
    edtDescMon: TEditFocus;
    btnAtivarNfm: TBitBtnLocked;
    dbchkAtivo: TDBCheckBox;
    Label10: TLabel;
    Label11: TLabel;
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
    Label12: TLabel;
    dbeAcrMob: TDBEditFocus;
    pnlCabecalho: TPanel;
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
    procedure FormShow(Sender: TObject);
    procedure btnAtivarNfmClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
  private
    { Private declarations }
    qryCadNfm: TUniQuery;
    dtsCadNfm: TDataSource;
    arrEscolhas: TStringArray;
    procedure pRetMontadora;
    procedure pCriaDataSets;
    procedure pLigaDataSets;
    procedure pGetEscolhas(var escolhas: TStringArray);
    procedure pAtivarDesativarNfm;
    procedure pAtivaNfm;
    procedure pAtivaCadTinta;
    procedure pBotaoAtivarNfm;
    function VerificarNovaFormulaMovimentada: Boolean;
    function fJaExisteEssaBaseNaFormulacao(strCodBas: String; dbeForm: TObject): Boolean;
  public
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fValidaTipo: Boolean;
    function fValidaBase(strCodBas: String): Boolean;
    { Public declarations }
  end;

var
  frmCadPpgNovasFormulas: TfrmCadPpgNovasFormulas;

implementation

uses untPai, untPpgDinamica,
    untIConfTinta, untFuncTinta, StrUtils, untConsultas;

{$R *.dfm}

{ TfrmCadPpgNovasFormulas }

function TfrmCadPpgNovasFormulas.fValidaCampos(Sender: TWinControl;
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
      End
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
        fMensagem('ATENÇÃO', Format('%s Não é uma base válida!', [TDBEdit(Sender).Text]), ['OK']);
        Result := False;
      End
      Else If fJaExisteEssaBaseNaFormulacao(TDBEditFocus(Sender).Text, Sender) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa base já está cadastrada para essa fórmula!', ['&Ok']);
        Result := False;
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

procedure TfrmCadPpgNovasFormulas.pCriaDataSets;
  Var
    intCont: Integer;
begin
  {**********************************}
  {* CRIA OS DATASETS DINAMICAMENTE *}
  {*******************************PH*}

  qryCadNfm := fCriarQuery('SELECT * FROM PPG_CADNFM', Self);

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

procedure TfrmCadPpgNovasFormulas.pInicializaIndices;
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

  stlCamInd.Add('NFM_CODNFM');
  stlCamInd.Add('NFM_DESCOR');
  stlCamInd.Add('NFM_VARIAN');
  stlCamInd.Add('NFM_VEICUL');
  stlCamInd.Add('NFM_MONTAD');
  stlCamInd.Add('AUTOINCREM');

  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');
  stlDesInd.Add('Variante');
  stlDesInd.Add('Veículo');
  stlDesInd.Add('Montadora');
end;

procedure TfrmCadPpgNovasFormulas.pLigaDataSets;
  Var
    intCont: Integer;
begin

  For intCont := 0 To ComponentCount - 1 Do
  Begin
    If (Components[intCont] is TDBEdit) Then
    Begin
      (Components[intCont] as TDBEdit).DataSource := dtsCadNfm;
    End;

    If (Components[intCont] is TDBCheckBox) Then
    Begin
      (Components[intCont] as TDBCheckBox).DataSource := dtsCadNfm;
    End;
  End;

  dbeCodigo.DataField := 'NFM_CODNFM';
  dbeDescricao.DataField := 'NFM_DESCOR';
  dbeAnoInicio.DataField := 'NFM_A_N_O_';
  dbeMontadora.DataField := 'NFM_MONTAD';
  dbeTipo.DataField := 'NFM_TIPO__';
  dbeVariante.DataField := 'NFM_VARIAN';
  dbeVeiculo.DataField := 'NFM_VEICUL';
  dbeAcrMob.DataField := 'NFM_ACRMOB';
  dbeDtaCad.DataField := 'NFM_DTACAD';

  For intCont := 1 To 20 Do
  Begin
    TDBEdit(FindComponent('dbeForm' + fStrZero(intCont, 2))).DataField := 'NFM_CODB' + fStrZero(intCont, 2);
    TDBEdit(FindComponent('dbeQtd' + fStrZero(intCont, 2))).DataField := 'NFM_QTDB' + fStrZero(intCont, 2);
  End;
end;

procedure TfrmCadPpgNovasFormulas.FormCreate(Sender: TObject);
begin
  inherited;
  pGetEscolhas(arrEscolhas);    

  pCriaDataSets;
  pLigaDataSets;

  qryTabela := qryCadNfm;
  strNomeTabela := 'PPG_CADNFM';
  strNomeCampo := 'NFM_CODNFM';

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

procedure TfrmCadPpgNovasFormulas.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  qryTabela.FieldByName('NFM_ATIVO_').AsString := 'S';
  qryTabela.FieldByName('NFM_DTACAD').AsDateTime := Date;
  edtDescMon.Clear;
  pSetFocus(dbeDescricao);
end;

procedure TfrmCadPpgNovasFormulas.dbeTipoKeyPress(Sender: TObject;
  var Key: Char);
var
  intEscolha: Integer;
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    Key := #0;
    pGetEscolhas(arrEscolhas);
    intEscolha := fGetMenu('ESCOLHA O TIPO', arrEscolhas, 1, True);
    if intEscolha > 0 then
      dbeTipo.Text := arrEscolhas[intEscolha - 1];
  End;
end;

function TfrmCadPpgNovasFormulas.fJaExisteEssaBaseNaFormulacao(
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

procedure TfrmCadPpgNovasFormulas.dbeMontadoraKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  If fPesqMontadoraTinta(Self, conPPG, dbeMontadora, Nil, Nil, Key, arrSel) Then
    pRetMontadora;
end;

procedure TfrmCadPpgNovasFormulas.pRetMontadora;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery(Self);

  qryGen.SQL.Clear;
  qrygen.SQL.Add('SELECT');
  qrygen.SQL.Add('  MON_DESCRI');
  qrygen.SQL.Add('FROM PPG_CADMON');
  qrygen.SQL.Add('WHERE MON_CODMON = :CODMON');

  qryGen.ParamByName('CODMON').AsString := dbeMontadora.Text;
  qryGen.Open;

  If qryGen.RecordCount > 0 Then
  Begin
    edtDescMon.Text := qryGen.FieldByName('MON_DESCRI').AsString;
  End;

  FreeAndNil(qryGen);
end;

procedure TfrmCadPpgNovasFormulas.btnGravarClick(Sender: TObject);
  Var
    blnInsert: Boolean;
    strNfm: String;
    conf: IConfTinta;
begin
  conf      := fGetConfTinta('PPG');
  qryTabela := qryCadNfm;
  blnInsert := (qryTabela.State = dsInsert);
  If (blnInsert) Then
  Begin
    strNfm := conf.fGet('PROCOD'); //fArqIniTinta(0, 'PPG', 'PROCOD', '0');
    qryTabela.FieldByName('NFM_CODNFM').AsString := 'ESP ' + VS_strCodEmp + fStrZero(strNfm, 5);
  End;

  fStartTransaction;
  inherited;

  Try
    If (blnGravou) Then
    Begin
      Screen.Cursor := crHourGlass;
      If TPpgAutomotivaDinamica.fGravaNovaFormula(qryCadNfm) Then
      Begin
        If (blnInsert) Then
        Begin
          conf.pSet('PROCOD', fStrZero(StrToInt(strNfm) + 1, 5)); //fArqIniTinta(1, 'PPG', 'PROCOD', fStrZero(StrToInt(strNfm) + 1, 5));
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

procedure TfrmCadPpgNovasFormulas.dbeForm01KeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;

begin
  fPesqBaseTinta(Self, conPPG, TDBEdit(Sender), Nil, Nil, Key, arrSel)

end;

function TfrmCadPpgNovasFormulas.fValidaTipo: Boolean;
begin
  Result := MatchText(dbeTipo.Text, arrEscolhas);
end;

function TfrmCadPpgNovasFormulas.fValidaBase(strCodBas: String): Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Clear;
  qryGen.SQL.Add('SELECT');
  qryGen.SQL.Add('  COUNT(*)    QTD');
  qryGen.SQL.Add('FROM PPG_CADBAS');
  qryGen.SQL.Add('WHERE BAS_CODBAS = :CODBAS ');
//  qryGen.SQL.Add('      AND BAS_TIPO__ = :TIPO');
  qryGen.ParamByName('CODBAS').AsString := strCodBas;
//  qryGen.ParamByName('TIPO').AsString := dbeTipo.Text;
  qryGen.Open;
  
  Result := qryGen.FieldbyName('QTD').AsInteger > 0;
  FreeAndNil(qryGen);
end;

procedure TfrmCadPpgNovasFormulas.btnExcluirClick(Sender: TObject);
  Var
    strCodNfm: String;
begin
  if VerificarNovaFormulaMovimentada then
  begin
    fMensagem('ATENÇÃO', 'Já existe movimentação para essa fórmula, por isso não é possivel alterá-la', ['&OK']);
    Exit;
  end;

  strCodNfm := qryTabela.FieldByName('NFM_CODNFM').AsString;

  fStartTransaction;
  inherited;

  Try
    If blnExcluiu Then
    begin
      TPpgAutomotivaDinamica.fDelNovaFormula(strCodNfm);
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

procedure TfrmCadPpgNovasFormulas.dbeQtd10KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
//  If Key = #13 Then
//    SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadPpgNovasFormulas.btnPesquisaClick(Sender: TObject);
  var
    arrSel: TConsultasArray;
    Key: Char;
begin
  key := '/';
  If fPesqFormulaTinta(Self, conPpg, Nil, qryTabela, key, arrSel) Then
  Begin
    pRetMontadora;
    pBotaoAtivarNfm;
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadPpgNovasFormulas.dbeMontadoraExit(Sender: TObject);
begin
  inherited;
  pRetMontadora;
end;

procedure TfrmCadPpgNovasFormulas.btnAlterarClick(Sender: TObject);
begin
  if VerificarNovaFormulaMovimentada then
  begin
    fMensagem('ATENÇÃO', 'Já existe movimentação para essa fórmula, por isso não é possivel alterá-la', ['&OK']);
    Exit;
  end;

  inherited;
  pSetFocus(dbeDescricao);
end;

procedure TfrmCadPpgNovasFormulas.pGetEscolhas(var escolhas: TStringArray);
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT DISTINCT   ' +
        '   BAS_TIPO__      ' +
        ' FROM              ' +
        '   PPG_CADBAS      ';
      qryGen.Open;

      SetLength(escolhas, qryGen.RecordCount);
      while not qryGen.Eof do
      begin
        escolhas[qryGen.RecNo - 1] := qryGen.FieldByName('BAS_TIPO__').AsString;
        qryGen.Next;
      end;

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

procedure TfrmCadPpgNovasFormulas.FormShow(Sender: TObject);
begin
  inherited;
  pBotaoAtivarNfm;
end;

procedure TfrmCadPpgNovasFormulas.btnAtivarNfmClick(Sender: TObject);
begin
  If fMensagem('QUESTÃO', 'Deseja realmente ' + IIF(qryTabela.FieldByName('NFM_ATIVO_').AsString = 'S','Desativar','Ativar') + ' essa nova fórmula ?', ['&Sim','&Não']) = 1 Then
    pAtivarDesativarNfm;

  btnAtivarNfm.Caption := IIF(qryTabela.FieldByName('NFM_ATIVO_').AsString = 'S','Desativar','Ativar');
end;

procedure TfrmCadPpgNovasFormulas.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pBotaoAtivarNfm;
end;

procedure TfrmCadPpgNovasFormulas.pAtivaCadTinta;
var
  qryUpt: TUniQuery;
begin
  Try
    qryUpt := fCriaQuery(Nil);
    With qryUpt Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' UPDATE PPG_CADPPG ');
      SQL.Add('    SET PPG_ATIVO_ = :ATIVO_ ');
      SQL.Add('  WHERE PPG_CODCOR = :CODPRO ');
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

procedure TfrmCadPpgNovasFormulas.pAtivaNfm;
var
  qryUpt: TUniQuery;
begin
  Try
    qryUpt := fCriaQuery(Nil);
    With qryUpt Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' UPDATE PPG_CADNFM ');
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

procedure TfrmCadPpgNovasFormulas.pAtivarDesativarNfm;
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

procedure TfrmCadPpgNovasFormulas.pBotaoAtivarNfm;
begin
  btnAtivarNfm.Enabled   := False;
  If Not qryTabela.IsEmpty Then
  Begin
    btnAtivarNfm.Enabled := VerificarNovaFormulaMovimentada;
    btnAtivarNfm.Caption := IIF(btnAtivarNfm.Enabled,
                            IIF(qryTabela.FieldByName('NFM_ATIVO_').AsString = 'S','Desativar','Ativar'),'Ativar');
  End;
end;

function TfrmCadPpgNovasFormulas.VerificarNovaFormulaMovimentada: Boolean;
var
  strChave: string;
begin
  Result := True;
  Try
    Try
      strChave := ' CAST(MD5(CONCAT(IFNULL(PPG_DESCOR, "") ' +
        '  , IFNULL(PPG_VEICUL, "") ' +
        '  , IFNULL(PPG_MONTAD, "") ' +
        '  , IFNULL(PPG_TIPO__, "") ' +
        '  , IFNULL(PPG_A_N_O_, "") ' +
        '  , IFNULL(PPG_CODCOR, "") ' +
        '  , IFNULL(PPG_CODATC, "") ' +
        '  , IFNULL(PPG_CODB01, "") ' +
        '  , IFNULL(PPG_QTDB01, "") ' +
        '  , IFNULL(PPG_CODB02, "") ' +
        '  , IFNULL(PPG_QTDB02, "") ' +
        '  , IFNULL(PPG_CODB03, "") ' +
        '  , IFNULL(PPG_QTDB03, "") ' +
        '  , IFNULL(PPG_CODB04, "") ' +
        '  , IFNULL(PPG_QTDB04, "") ' +
        '  , IFNULL(PPG_CODB05, "") ' +
        '  , IFNULL(PPG_QTDB05, "") ' +
        '  , IFNULL(PPG_CODB06, "") ' +
        '  , IFNULL(PPG_QTDB06, "") ' +
        '  , IFNULL(PPG_CODB07, "") ' +
        '  , IFNULL(PPG_QTDB07, "") ' +
        '  , IFNULL(PPG_CODB08, "") ' +
        '  , IFNULL(PPG_QTDB08, "") ' +
        '  , IFNULL(PPG_CODB09, "") ' +
        '  , IFNULL(PPG_QTDB09, "") ' +
        '  , IFNULL(PPG_CODB10, "") ' +
        '  , IFNULL(PPG_QTDB10, "") ' +
        '  , IFNULL(PPG_CODB11, "") ' +
        '  , IFNULL(PPG_QTDB11, "") ' +
        '  , IFNULL(PPG_CODB12, "") ' +
        '  , IFNULL(PPG_QTDB12, "") ' +
        '  , IFNULL(PPG_CODB13, "") ' +
        '  , IFNULL(PPG_QTDB13, "") ' +
        '  , IFNULL(PPG_CODB14, "") ' +
        '  , IFNULL(PPG_QTDB14, "") ' +
        '  , IFNULL(PPG_CODB15, "") ' +
        '  , IFNULL(PPG_QTDB15, "") ' +
        '  , IFNULL(PPG_CODB16, "") ' +
        '  , IFNULL(PPG_QTDB16, "") ' +
        '  , IFNULL(PPG_CODB17, "") ' +
        '  , IFNULL(PPG_QTDB17, "") ' +
        '  , IFNULL(PPG_CODB18, "") ' +
        '  , IFNULL(PPG_QTDB18, "") ' +
        '  , IFNULL(PPG_CODB19, "") ' +
        '  , IFNULL(PPG_QTDB19, "") ' +
        '  , IFNULL(PPG_CODB20, "") ' +
        '  , IFNULL(PPG_QTDB20, "") ' +
        '  )) AS CHAR)';

      Result := fVerificarNovaFormulaMovimentada('SELECT COUNT(0) AS QTD FROM %0:s INNER JOIN PPG_CADPPG ON %1:s_ITETIN = ' + strChave + ' WHERE PPG_CODCOR = :CODNFM AND %1:s_IDEPRO = "PPG"',
        [qryTabela.FieldByName('NFM_CODNFM').AsString]);

      If Not Result Then
      Begin
        strChave := ' PPG_MD5KEY';

        Result := fVerificarNovaFormulaMovimentada('SELECT COUNT(0) AS QTD FROM %0:s INNER JOIN PPG_CADPPG ON %1:s_ITETIN = ' + strChave + ' WHERE PPG_CODCOR = :CODNFM AND %1:s_IDEPRO = "PPG"',
          [qryTabela.FieldByName('NFM_CODNFM').AsString]);
      End;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
  End;
end;


initialization
  RegisterClass(TfrmCadPpgNovasFormulas);
finalization
  UnRegisterClass(TfrmCadPpgNovasFormulas);

end.


