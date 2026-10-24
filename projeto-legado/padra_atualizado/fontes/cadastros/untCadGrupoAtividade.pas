unit untCadGrupoAtividade;

interface

uses
  Windows, Classes, Controls, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls,
  Buttons, BitBtnLockedIncrem, ExtCtrls, Mask, DBCtrls, DBEditFocus, DB,
  frxClass, frxExportCSVTestabilidade;

type
  TfrmCadGrupoAtividade = class(TfrmPaiCad)
    pnlFundo: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    dbeDescri: TDBEditFocus;
    dbeCodGat: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    dtsDados: TDataSource;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;


implementation

uses  Forms, untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadGrupoAtividade.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodGat, dbeDescri, False);
end;

procedure TfrmCadGrupoAtividade.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    fRollBack;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadGrupoAtividade.btnGravarClick(Sender: TObject);
begin
  qryTabela.FieldByName('GAT_CODEMP').AsString := VS_strCodEmp;

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    fRollBack;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadGrupoAtividade.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodGat, dbeDescri, False);

end;

procedure TfrmCadGrupoAtividade.btnPesquisaClick(Sender: TObject);
  Var
    c: Char;
    arrSel: TConsultasArray;
begin
  c := '/';

  fPesqGrupoAtividade(Self, Nil, Nil, qryTabela, c, arrSel);
end;

procedure TfrmCadGrupoAtividade.FormCreate(Sender: TObject);
begin
  inherited;

  strNomeTabela := 'CADGAT';
  strNomeCampo  := 'GAT_CODGAT';

  qryTabela := fCriarQuery('SELECT * FROM CADGAT');
  dtsDados  := fCriaDataSource(qryTabela);

  qryTabela.FieldByName('GAT_CODGAT').DisplayLabel := 'Código';
  qryTabela.FieldByName('GAT_DESCRI').DisplayLabel := 'Descrição';

  qryTabela.FieldByName('GAT_CODEMP').Visible := False;
  qryTabela.FieldByName('AUTOINCREM').Visible := False;

  dbeCodGat.DataSource := dtsDados;
  dbeDescri.DataSource := dtsDados;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodGat;
  pHabilitaCodigo(dbeCodGat, dbeDescri, False);
end;

procedure TfrmCadGrupoAtividade.FormDestroy(Sender: TObject);
begin
  dtsDados.Free;
  qryTabela.Free;
  inherited;
end;

procedure TfrmCadGrupoAtividade.FormShow(Sender: TObject);
begin
  inherited;
  If btnIncluir.Enabled Then
    pSetFocus(btnIncluir);
end;

function TfrmCadGrupoAtividade.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  
  If Sender = dbeDescri Then
  Begin
    If fEmptyStr(dbeDescri.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Descrição do Grupo de Atividade deve ser preenchida!', ['&Ok']);
      Result := False;
    End;
  End;

  If Not Result Then
    pSetFocus(dbeDescri);
end;

procedure TfrmCadGrupoAtividade.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('GAT_CODGAT');
  stlCampos.Add('GAT_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('GAT_DESCRI');
  stlCamInd.Add('GAT_CODIGO');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código Grupo');
end;

end.
