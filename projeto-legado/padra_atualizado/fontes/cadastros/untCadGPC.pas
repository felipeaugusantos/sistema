unit untCadGPC;

interface

uses
  Classes, Controls, Forms, StdCtrls, untPaiCad, ComCtrls, Buttons, ExtCtrls,
  Mask, DBCtrls, DBEditFocus, Menus, AppEvnts, Uni, DB, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade, SysUtils;

type
  TfrmCadGPC = class(TfrmPaiCad)
    Label1: TLabel;
    dbeCodGpc: TDBEditFocus;
    Label2: TLabel;
    dbeDesGpc: TDBEditFocus;
    pnlFundo: TPanel;
    dtsTabela: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  public
    { Public declarations }
  end;

var
  frmCadGPC: TfrmCadGPC;

implementation

uses untFuncoesSimples, untPai, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmCadGPC }

function TfrmCadGPC.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender,blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA CODIGO DA GPC                  *}
    {**************************************AC*}
    If (Sender = dbeCodGpc) Then
    Begin
      If (fEmptyStr(dbeCodGpc.Text)) And (dbeCodGpc.Enabled) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'O Código da Classificação Global Do Produto deve ser preenchido!', ['&Ok']);
      End
      {*****************************************}
      {* VERIFICA SE EXISTE O CODIGO INFORMADO *}
      {* CASO EXISTA TRAZ PARA EDICAO          *}
      {**************************************WI*}
      Else If blnBuscaPorChave Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End
    {*****************************************}
    {* VALIDA DESCRICAO DA GPC               *}
    {**************************************AC*}
    Else If (Sender = dbeDesGpc) Then
    Begin
      If fEmptyStr(dbeDesGpc.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'A Descrição da Classificação Global Do Produto deve ser preenchida!', ['&Ok']);
      End;
    End

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCadGPC.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('GPC_CODGPC');
  stlCampos.Add('GPC_DESGPC');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('GPC_DESGPC');
  stlCamInd.Add('GPC_CODGPC');

  stlDesInd.Add('Descrição');
//  stlDesInd.Add('Grupo');
  stlDesInd.Add('Código');

end;

procedure TfrmCadGPC.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(btnIncluir);
end;

procedure TfrmCadGPC.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'CADGPC';
  strNomeCampo      := 'GPC_CODGPC';
  qryTabela         := fCriaQuery(Self);
  dtsTabela.DataSet := qryTabela;

  SetLength(arrCamposChave, 1 );
  arrCamposChave[0] := dbeCodGpc;
end;

procedure TfrmCadGPC.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadGPC.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadGPC.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[TfrmCadGPC.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadGPC.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodGpc, dbeDesGpc, False)
  Else
    pHabilitaCodigo(dbeCodGpc, dbeCodGpc, True);
end;

procedure TfrmCadGPC.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodGpc, dbeDesGpc, False);
end;

procedure TfrmCadGPC.FormShow(Sender: TObject);
begin
  inherited;
  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;
end;

procedure TfrmCadGPC.btnPesquisaClick(Sender: TObject);
  Var
    arrGPC: TConsultasArray;
    chrKey: Char;
begin
  {***************************}
  {* NOVA CONSULTA DE GPC    *}
  {************************AC*}
  chrKey := '/';
  If fPesqGPC(Self, Nil, Nil, qryTabela, chrKey, arrGPC) Then
  Begin
  
  End;
end;

end.

