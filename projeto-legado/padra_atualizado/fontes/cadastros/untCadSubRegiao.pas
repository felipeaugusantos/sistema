unit untCadSubRegiao;

interface

uses
  Windows, Classes, Controls, Forms, untPaiCad, StdCtrls, DBCtrls, DBEditFocus,
  AppEvnts, Menus, ComCtrls, Buttons, ExtCtrls, Uni, DB, BitBtnLockedIncrem,
  Mask, frxClass, frxExportCSVTestabilidade, SysUtils;

type
  TfrmCadSubRegiao = class(TfrmPaiCad)
    pnlCentral: TPanel;
    lbl2: TLabel;
    lbl3: TLabel;
    dbeDesSub: TDBEditFocus;
    dbeCodSub: TDBEditFocus;
    dtsCadSub: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    qryCadSub: TUniQuery;
  public
    { Public declarations }
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmCadSubRegiao }

procedure TfrmCadSubRegiao.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodSub, dbeDesSub, False);
end;

procedure TfrmCadSubRegiao.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadSubRegiao.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadSubRegiao.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[untCadSubRegiao.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadSubRegiao.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodSub, dbeDesSub, False)
  Else
    pHabilitaCodigo(dbeCodSub, dbeDesSub, True);
end;

procedure TfrmCadSubRegiao.btnPesquisaClick(Sender: TObject);
  var
    chrKey   : Char;
    arrSubReg: TConsultasArray;
begin
  chrKey := '/';
  If fPesqSubRegiao(Self, Nil, Nil, qryTabela, chrKey, arrSubReg) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadSubRegiao.FormCreate(Sender: TObject);
var
  strSQL: String;
begin
  inherited;
  strNomeTabela     := 'CADSUB';
  strNomeCampo      := 'SUB_CODSUB';

  strSQL            := 'SELECT * FROM CADSUB';
  qryCadSub         := fCriarQuery(strSQL, Self);
  qryTabela         := qryCadSub;
  dtsCadSub.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodSub;
end;

function TfrmCadSubRegiao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = dbeCodSub) Then
  Begin
    If (fEmptyStr(dbeCodSub.Text)) And (dbeCodSub.Enabled) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Código da Sub-Região deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (blnBuscaPorChave) Then
    Begin
      If Not fBuscaPorCamposChave Then
        pLimparCampos;
    End;
  End

  Else If (Sender = dbeDesSub) Then
  Begin
    If fEmptyStr(dbeDesSub.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Descrição da Sub-Região deve ser preenchida!', ['&Ok']);
      Result := False;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadSubRegiao.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('SUB_CODSUB');
  stlCampos.Add('SUB_DESSUB');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('SUB_DESSUB');
  stlCamInd.Add('SUB_CODSUB');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

end.

