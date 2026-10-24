unit untCadCor;

interface

uses
  Windows, Classes, Controls, Forms, untPaiCad, AppEvnts, Menus, ComCtrls,
  StdCtrls, Buttons, ExtCtrls, DB, Mask, DBCtrls, DBEditFocus, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade, SysUtils;

type
  TfrmCadCor = class(TfrmPaiCad)
    pnlGeral: TPanel;
    Label1: TLabel;
    dbeCodigo: TDBEditFocus;
    Label2: TLabel;
    dbeDesCor: TDBEditFocus;
    dtsCadCor: TDataSource;
    Label3: TLabel;
    dbeDesRes: TDBEditFocus;
    lblDetGru: TLabel;
    dbeDetCor: TDBEditFocus;
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadCor.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeDesCor, False);
end;

procedure TfrmCadCor.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadCor.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadCor.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[untCadCor.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadCor.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeDesCor, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);
end;

procedure TfrmCadCor.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrCor: TConsultasArray;
begin
  {*******************************}
  {* NOVA CONSULTA DE CORES      *}
  {****************************AC*}
  chrKey := '/';
  If fPesqCores(Self, Nil, Nil, qryTabela, chrKey, arrCor) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadCor.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'CADCOR';
  strNomeCampo      := 'COR_CODCOR';
  qryTabela         := fCriarQuery('SELECT * FROM CADCOR', Self);
  dtsCadCor.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

procedure TfrmCadCor.FormShow(Sender: TObject);
begin
  inherited;
  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;
end;

function TfrmCadCor.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
 Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = dbeCodigo) Then
    Begin
      If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da Cor deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End

    Else
    If (Sender = dbeDesCor) Then
    Begin
      If fEmptyStr(dbeDesCor.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição da Cor deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadCor.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('COR_CODCOR');
  stlCampos.Add('COR_DESCOR');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('COR_DESCOR');
  stlCamInd.Add('COR_CODCOR');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código da Cor');
end;

end.

