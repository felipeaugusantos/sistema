unit untCadClassificacaoOnu;

interface

uses
  Windows, Classes, Controls, Forms, untPaiCad, AppEvnts, Menus, ComCtrls,
  StdCtrls, Buttons, BitBtnLockedIncrem, ExtCtrls, DBEditFocus, DB, Mask,
  DBCtrls, frxClass, frxExportCSVTestabilidade,SysUtils;

type
  TfrmCadClassificacaoOnu = class(TfrmPaiCad)
    pnlCadastro: TPanel;
    dbeCodigo: TDBEditFocus;
    Label1: TLabel;
    lblDesOnu: TLabel;
    dbeDesOnu: TDBEditFocus;
    dtsTabela: TDataSource;
    Label2: TLabel;
    dbeCodOnu: TDBEditFocus;
    Label3: TLabel;
    dbeClaRis: TDBEditFocus;
    dbeGruEmb: TDBEditFocus;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  Protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;


implementation

uses untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadClassificacaoOnu.btnAlterarClick(Sender: TObject);
begin
  inherited;

  If (dbeCodigo.Enabled) Then
    pSetFocus(dbeCodigo)
  Else pSetFocus(dbeDesOnu);
end;

procedure TfrmCadClassificacaoOnu.btnExcluirClick(Sender: TObject);
begin
  Try
    blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadClassificacaoOnu.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadClassificacaoOnu.btnGravarClick(Sender: TObject);
begin

  If Not fValidacoesBotaoGravarPai Then
    Exit;

  Try
    blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadClassificacaoOnu.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
   fRollBack;

end;

procedure TfrmCadClassificacaoOnu.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeDesOnu, False);
end;

procedure TfrmCadClassificacaoOnu.btnPesquisaClick(Sender: TObject);
  Var
    chrKey : Char;
    arrClaOnu : TConsultasArray;
begin
  chrKey := '/';
  If fPesqClassificacaoOnu(Self, nil, nil, qryTabela, chrKey, arrClaOnu) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadClassificacaoOnu.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(btnIncluir);
end;

procedure TfrmCadClassificacaoOnu.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela := 'CADONU';
  strNomeCampo      := 'ONU_CODONU';
  qryTabela := fCriarQuery('SELECT * FROM CADONU', Self);
  dtsTabela.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

procedure TfrmCadClassificacaoOnu.FormShow(Sender: TObject);
begin
  inherited;
  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;
end;

function TfrmCadClassificacaoOnu.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then Begin
    If (Sender = dbeCodigo) Then Begin
      If (dbeCodigo.Enabled) And (fEmptyStr(dbeCodigo.Text)) Then Begin
        fMensagem('ATENÇÃO!', 'Campo Código deve ser informado!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeDesOnu) Then Begin
      If (fEmptyStr(dbeDesOnu.Text)) Then Begin
        fMensagem('ATENÇÃO!', 'Campo Descrição ONU deve ser informado!', ['&Ok']);
        Result := False;
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadClassificacaoOnu.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;
end;

end.
