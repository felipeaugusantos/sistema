unit untCadEstProduto;

interface

uses
  Windows, Classes, Controls, untPaiCad, StdCtrls, Mask, DBCtrls, DBEditFocus,
  AppEvnts, Menus, ComCtrls, Buttons, ExtCtrls, DB, Uni, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade, SysUtils;

type
  TfrmCadEstProduto = class(TfrmPaiCad)
    pnlFundo: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    dbeDescri: TDBEditFocus;
    dbeCodEpr: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    qryCadEpr: TUniQuery;
    dtsDados : TDataSource;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses Forms, untPai, untConsultas, untFuncoesSimples, untTypesSistema;

{$R *.dfm}

procedure TfrmCadEstProduto.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodEpr, dbeDescri, False);
end;

procedure TfrmCadEstProduto.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadEstProduto.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadEstProduto.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[TfrmCadEstProduto.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadEstProduto.btnIncluirClick(Sender: TObject);
begin
  inherited;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodEpr, dbeDescri, False)
  Else
    pHabilitaCodigo(dbeCodEpr, dbeCodEpr, True);
end;

procedure TfrmCadEstProduto.btnPesquisaClick(Sender: TObject);
var
  chrKey: Char;
  arrEstProduto: TConsultasArray;
begin
  {**************************************}
  {* NOVA CONSULTA DE ESTADO DO PRODUTO *}
  {***********************************DH*}
  chrKey := '/';
  If fPesqEstProduto(Self, Nil, Nil, qryTabela, chrKey, arrEstProduto) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadEstProduto.FormCreate(Sender: TObject);
var
  intCont: Integer;
begin
  inherited;

  strNomeTabela := 'CADEPR';
  strNomeCampo  := 'EPR_CODEPR';
  qryCadEpr     := fCriarQuery('SELECT * FROM CADEPR', Self);

  qryCadEpr.FieldByName('EPR_CODEPR').DisplayLabel := 'Código';
  qryCadEpr.FieldbyName('EPR_DESCRI').DisplayLabel := 'Descrição';

  qryCadEpr.FieldByName('AUTOINCREM').Visible := False;

  dtsDados  := fCriaDataSource(qryCadEpr);
  qryTabela := qryCadEpr;

  For intCont := 0 To ComponentCount - 1 Do
  Begin
    If (Components[intCont] is TDBEdit) Then
    Begin
      (Components[intCont] as TDBEdit).DataSource := dtsDados;
    End;
  End;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodEpr;
end;

function TfrmCadEstProduto.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = dbeCodEpr) Then
    Begin
      If (fEmptyStr(dbeCodEpr.Text)) And (dbeCodEpr.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Estado do Produto deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End

    Else If (Sender = dbeDescri) Then
    Begin
      If fEmptyStr(dbeDescri.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A descrição do Estado do Produto deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadEstProduto.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('EPR_CODEPR');
  stlCampos.Add('EPR_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('EPR_DESCRI');
  stlCamInd.Add('EPR_CODEPR');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

end.
