unit untCadGruposUnidade;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiCad, ComCtrls, Buttons, ExtCtrls, Mask,
  DBCtrls, DBEditFocus, MaskEditFocus, Grids, DBGridCitel, DBGrids, untZClient, DB,
  Menus, StrUtils, Uni, AppEvnts, BitBtnLockedIncrem, EditFocus, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmCadGruposUnidade = class(TfrmPaiCad)
    Label1: TLabel;
    Label2: TLabel;
    dbeCodGun: TDBEditFocus;
    dbeDesGun: TDBEditFocus;
    Label3: TLabel;
    pnlGrid: TPanel;
    dbgIteGun: TDBGridCitel;
    pnlFundo: TPanel;
    Bevel1: TBevel;
    edtCodUni: TEditFocus;
    edtDesUni: TEditFocus;
    btnAdicionarUnidade: TBitBtnLocked;
    btnCancelarUnidade: TBitBtnLocked;
    DataSource1: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbgIteGunKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnPesquisaClick(Sender: TObject);
    procedure edtCodUniKeyPress(Sender: TObject; var Key: Char);
    procedure btnAdicionarUnidadeClick(Sender: TObject);
    procedure btnCancelarUnidadeClick(Sender: TObject);
  private
    { Private declarations }

    cdsIteGun: TZClient;
    dtsTabela: TDataSource;

    procedure pCarregaIteGun;
    procedure pGravaIteGun;
    function fExisteIteGun(strUnidade: String): Boolean;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  public
    { Public declarations }
  end;

implementation

uses untFuncoesSimples, untPai, untConsultas, untTypesSistema, untGravando;

{$R *.dfm}

{ TfrmCadGruposUnidade }

procedure TfrmCadGruposUnidade.FormCreate(Sender: TObject);
  Var
    intCont: Integer;
begin
  inherited;
  strNomeTabela := 'CADGUN';
  strNomeCampo  := 'GUN_CODIGO';
  qryTabela     := fCriarQuery('SELECT * FROM CADGUN WHERE FALSE', Self);

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodGun;

  dtsTabela := fCriaDataSource(qryTabela);

  For intCont := 0 To ComponentCount - 1 Do
    If (Components[intCont] Is TDBEdit) Then
      (Components[intCont] As TDBEdit).DataSource := dtsTabela;

  cdsIteGun := TZClient.Create(Self);
  dbgIteGun.DataSource := cdsIteGun.dtsSource;
end;

function TfrmCadGruposUnidade.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = dbeCodGun) Then
    Begin
      If (fEmptyStr(dbeCodGun.Text)) And (dbeCodGun.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If blnBuscaPorChave Then
      Begin
        If Not fBuscaPorCamposChave Then
        Begin
          pLimparCampos;
          cdsIteGun.EmptyDataSet;
        End
        Else
        Begin
          pCarregaIteGun;
        End;
      End
    End

    Else If (Sender = dbeDesGun) Then
    Begin
      If fEmptyStr(dbeDesGun.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição deve ser preenchida!', ['&Ok']);
        Result := False;
      End
    End

    Else If (Sender = edtCodUni) Then
    Begin

      If Not fEmptyStr(edtCodUni.Text) Then
      Begin
        edtDesUni.Text := fRetNomUnidade(edtCodUni.Text);
        If fEmptyStr(edtDesUni.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa Unidade não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else If fExisteIteGun(edtCodUni.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Unidade (' + edtCodUni.Text + ') já foi cadastrada em outro Grupo!', ['&Ok']);
          btnCancelarUnidade.Click;
          Result := False;
        End
        Else If cdsIteGun.Locate('GUN_CODUNI', edtCodUni.Text, []) Then
        Begin
          fMensagem('ATENÇÃO!', 'Unidade (' + edtCodUni.Text + ') já foi cadastrada!', ['&Ok']);
          btnCancelarUnidade.Click;
          Result := False;
        End;
      End
      Else
      Begin
        If cdsIteGun.IsEmpty Then
        Begin
          fMensagem('', 'É necessário escolher pelo menos uma unidade!', ['&Ok']);
          Result := False
        End
        Else
        Begin
          blnMudarFoco := False;
          pSetFocus(dbgIteGun);
        End;
      End;
    End;
  End;
end;

procedure TfrmCadGruposUnidade.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('GUN_CODIGO');
  stlCampos.Add('GUN_DESCRI');
  stlCampos.Add('AUTOINCREM');  

  stlCamInd.Add('GUN_CODIGO');
  stlCamInd.Add('GUN_DESCRI');

  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');
end;

procedure TfrmCadGruposUnidade.btnIncluirClick(Sender: TObject);
begin
  inherited;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodGun, dbeDesGun, False)
  Else
    pHabilitaCodigo(dbeCodGun, dbeCodGun, True);

  pCarregaIteGun;
end;

procedure TfrmCadGruposUnidade.btnAdicionarUnidadeClick(Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(edtCodUni.Text) And fValidaCampos(edtCodUni, True) Then
  Begin
    cdsIteGun.AppendRecord([edtCodUni.Text, edtDesUni.Text]);
  End;
  btnCancelarUnidade.Click;
end;

procedure TfrmCadGruposUnidade.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodGun, dbeDesGun, False);
  pCarregaIteGun;
end;

procedure TfrmCadGruposUnidade.pCarregaIteGun;
begin

  With cdsIteGun.qryQuery, SQL Do
  Begin
    cdsIteGun.Close;
    Close;
    Clear;

    Add('SELECT ');
    Add('  GUN_CODUNI, ');
    Add('  UNI_DESUNI  ');
    Add('FROM ');
    Add('  CADUNI U, ');
    Add('  ITEGUN I  ');
    Add('WHERE ');
    Add('  U.UNI_CODUNI = I.GUN_CODUNI AND ');
    Add('  I.GUN_CODIGO = :CODGUN ');

    If qryTabela.Active Then
      ParamByName('CODGUN').AsString :=
        qryTabela.FieldByName('GUN_CODIGO').AsString;

    cdsIteGun.pSetProvider;

    Open;

    pSetaClient(cdsIteGun.qryQuery);

    cdsIteGun.Open;

    cdsIteGun.First;

    cdsIteGun.IndexFieldNames   := 'GUN_CODUNI';

    dbgIteGun.Enabled           := (qryTabela.State In [dsEdit, dsInsert]);
    edtCodUni.Enabled           := (qryTabela.State In [dsEdit, dsInsert]);
    btnAdicionarUnidade.Enabled := (qryTabela.State In [dsEdit, dsInsert]);
    btnCancelarUnidade.Enabled  := (qryTabela.State In [dsEdit, dsInsert]);
  End;

end;

procedure TfrmCadGruposUnidade.pGravaIteGun;
begin
  fExecutaSQL(' DELETE FROM ITEGUN ' +
              ' WHERE GUN_CODIGO = ' + QuotedStr(dbeCodGun.Field.AsString));

  cdsIteGun.First;
  While Not cdsIteGun.Eof Do
  Begin
    fExecutaSQL(' INSERT INTO ITEGUN (' +
                '   GUN_CODIGO,       ' +
                '   GUN_CODUNI,       ' +
                '   AUTOINCREM )      ' +
                ' VALUES (            ' +
                '   ' + QuotedStr(dbeCodGun.Field.AsString) + ', ' +
                '   ' + QuotedStr(cdsIteGun.FieldByName('GUN_CODUNI').AsString) + ', ' +
                '   ' + fRetAutoIncrem('ITEGUN', VS_strCodEmp) + ' ) ');
    cdsIteGun.Next;
  End;
  cdsIteGun.First;
end;

procedure TfrmCadGruposUnidade.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
  If (cdsIteGun.IsEmpty) Then
  Begin
    fMensagem('', 'É necessário escolher pelo menos uma unidade!', ['&Ok']);
    pSetFocus(edtCodUni);
  End
  Else
  Begin
    Try
      inherited;
      If (blnGravou) Then
      Begin
        TfrmGravando.fExecutarModal(pGravaIteGun, 'Aguarde, Gravando unidade(s)...', '');
        fCommit;
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
  End;
end;

procedure TfrmCadGruposUnidade.FormShow(Sender: TObject);
begin
  inherited;
  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;
  pCarregaIteGun;
  pSetFocus(btnIncluir);
end;

procedure TfrmCadGruposUnidade.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregaIteGun;
end;

procedure TfrmCadGruposUnidade.btnCancelarUnidadeClick(Sender: TObject);
begin
  inherited;
  edtCodUni.Clear;
  edtDesUni.Clear;
  pSetFocus(edtCodUni);
end;

procedure TfrmCadGruposUnidade.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadGruposUnidade.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  pCarregaIteGun;
end;

procedure TfrmCadGruposUnidade.dbgIteGunKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Not (qryTabela.State = dsBrowse) Then
  Begin
    If Key = VK_Escape Then
      btnCancelarUnidade.Click

    Else If Key = VK_Delete Then
      cdsIteGun.Delete

    Else If Key = VK_Return Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadGruposUnidade.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrGrupo: TConsultasArray;
begin
  chrKey := '/';
  If fPesqGrupoUnidade(Self, Nil, Nil, qryTabela, chrKey, arrGrupo) Then
  Begin
    pCarregaIteGun;
    pSetFocus(btnAlterar);
  End;
end;

function TfrmCadGruposUnidade.fExisteIteGun(strUnidade: String): Boolean;
  Var
    strCodGun: String;
begin
  strCodGun := fCampoTabela('GUN_CODIGO', 'ITEGUN', ['GUN_CODUNI'], [strUnidade]);

  If fEmptyStr(strCodGun) Then
    Result := False
  Else
    Result := strCodGun <> dbeCodGun.Field.AsString;
end;

procedure TfrmCadGruposUnidade.edtCodUniKeyPress(Sender: TObject; var Key: Char);
  Var
    arrUnidades: TConsultasArray;
begin
  If fPesqUnidade(Self, edtCodUni, edtDesUni, Nil, nil, Key, arrUnidades) Then
  Begin
    If fValidaCampos(edtCodUni, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

end.

