unit untCadGrupoServicos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade,
  Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.Mask,
  Vcl.DBCtrls, DBEditFocus, Data.DB, Uni;

type
  TfrmCadGrupoServicos = class(TfrmPaiCad)
    pnlPrincipal: TPanel;
    Label1: TLabel;
    dbeCodGru: TDBEditFocus;
    Label2: TLabel;
    dbeDesGru: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    qryGrupo: TUniQuery;
    dtsDados: TDataSource;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadGrupoServicos.btnAlterarClick(Sender: TObject);
begin
  inherited;

  pHabilitaCodigo(dbeCodGru, dbeDesGru, False);
end;

procedure TfrmCadGrupoServicos.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadGrupoServicos.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadGrupoServicos.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[TfrmCadGrupoServicos.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadGrupoServicos.btnIncluirClick(Sender: TObject);
begin
  inherited;

  pHabilitaCodigo(dbeCodGru, dbeDesGru, Not blnUsaProCodigo);
end;

procedure TfrmCadGrupoServicos.btnPesquisaClick(Sender: TObject);
  Var
    arrGruSer : TConsultasArray;
    chrKey   : Char;
begin
  chrKey := '/';

  fPesqGrupoServicos(Self, Nil, Nil, qryGrupo, chrKey, arrGruSer);
end;

procedure TfrmCadGrupoServicos.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(btnIncluir);
end;

procedure TfrmCadGrupoServicos.FormCreate(Sender: TObject);
  Var
    intCont: Integer;
begin
  inherited;

  strNomeTabela := 'GRUSER';
  strNomeCampo  := 'GRU_CODGRU';
  qryGrupo      := fCriarQuery('SELECT * FROM GRUSER', Self);

  qryGrupo.FieldByName('GRU_CODGRU').DisplayLabel := 'Código';
  qryGrupo.FieldbyName('GRU_DESGRU').DisplayLabel := 'Descrição';

  qryGrupo.FieldByName('GRU_CODEMP').Visible := False;
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
  arrCamposChave[0] := dbeCodGru;
end;

function TfrmCadGrupoServicos.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = dbeCodGru) Then
    Begin
      If (fEmptyStr(dbeCodGru.Text)) And (dbeCodGru.Enabled) Then
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

procedure TfrmCadGrupoServicos.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('GRU_CODGRU');
  stlCampos.Add('GRU_DESGRU');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('GRU_DESGRU');
  stlCamInd.Add('GRU_CODGRU');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código Grupo');
end;

end.
