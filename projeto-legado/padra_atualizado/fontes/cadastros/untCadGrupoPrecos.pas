unit untCadGrupoPrecos;

interface

uses
  Windows, Classes, Controls, untPaiCad, StdCtrls, Mask, DBCtrls, DBEditFocus,
  AppEvnts, Menus, ComCtrls, Buttons, ExtCtrls, DB, Uni, BitBtnLockedIncrem,
  SysUtils;

type
  TfrmCadGrupoPrecos = class(TfrmPaiCad)
    pnlFundo: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    dbeDesGru: TDBEditFocus;
    dbeCodigo: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    qryGrupo: TUniQuery;
    dtsDados: TDataSource;
    { Private declarations }
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses Forms, untPai, untConsultas, untFuncoesSimples, untTypesSistema;

{$R *.dfm}

procedure TfrmCadGrupoPrecos.FormCreate(Sender: TObject);
  Var
    intCont: Integer;
begin
  inherited;

  strNomeTabela := 'CADGPR';
  strNomeCampo  := 'GPR_CODIGO';
  qryGrupo      := fCriarQuery('SELECT * FROM CADGPR', Self);

  qryGrupo.FieldByName('GPR_CODIGO').DisplayLabel := 'Código';
  qryGrupo.FieldbyName('GPR_DESCRI').DisplayLabel := 'Descrição';

  qryGrupo.FieldByName('GPR_CODEMP').Visible := False;
  qryGrupo.FieldByName('AUTOINCREM').Visible := False;

  dtsDados  := fCriaDataSource(qryGrupo);
  qryTabela := qryGrupo;

  For intCont := 0 To ComponentCount - 1 Do
  Begin
    If (Components[intCont] is TDBEdit) Then
    Begin
      (Components[intCont] as TDBEdit).DataSource := dtsDados;
    End;
  End;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;


function TfrmCadGrupoPrecos.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin

  Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = dbeCodigo) Then
    Begin
      If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Grupo deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End

    Else If (Sender = dbeDesGru) Then
    Begin
      If fEmptyStr(dbeDesGru.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição do Grupo deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadGrupoPrecos.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('GPR_CODIGO');
  stlCampos.Add('GPR_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('GPR_DESCRI');
  stlCamInd.Add('GPR_CODIGO');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código Grupo');
end;

procedure TfrmCadGrupoPrecos.FormShow(Sender: TObject);
begin
  inherited;
  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;

end;


procedure TfrmCadGrupoPrecos.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadGrupoPrecos.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadGrupoPrecos.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadGrupoPrecos.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadGrupoPrecos.btnIncluirClick(Sender: TObject);
begin
  inherited;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeDesGru, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);

end;

procedure TfrmCadGrupoPrecos.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrGrupo: TConsultasArray;
begin
  {************************************}
  {* NOVA CONSULTA DE GRUPO DE PREÇOS *}
  {*********************************RV*}
  chrKey := '/';
  If fPesqGrupoPrecos(Self, Nil, Nil, qryTabela, chrKey, arrGrupo) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadGrupoPrecos.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeDesGru, False);
end;

end.
