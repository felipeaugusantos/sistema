unit untCadAcessorios;

interface

uses
  Windows, Classes, Controls, untPaiCad, StdCtrls, Mask, DBCtrls, DBEditFocus,
  AppEvnts, Menus, ComCtrls, Buttons, ExtCtrls, DB, Uni, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade, SysUtils;

type
  TfrmCadAcessorios = class(TfrmPaiCad)
    pnlFundo: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    dbeDescri: TDBEditFocus;
    dbeCodAce: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    qryCadAce: TUniQuery;
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

procedure TfrmCadAcessorios.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodAce, dbeDescri, False);
end;

procedure TfrmCadAcessorios.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadAcessorios.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadAcessorios.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[untCadAcessorios.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadAcessorios.btnIncluirClick(Sender: TObject);
begin
  inherited;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodAce, dbeDescri, False)
  Else
    pHabilitaCodigo(dbeCodAce, dbeCodAce, True);
end;

procedure TfrmCadAcessorios.btnPesquisaClick(Sender: TObject);
var
  chrKey: Char;
  arrAcessorios: TConsultasArray;
begin
  {*******************************}
  {* NOVA CONSULTA DE ACESSÓRIOS *}
  {****************************DH*}
  chrKey := '/';
  If fPesqAcessorios(Self, Nil, Nil, qryTabela, chrKey, arrAcessorios) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadAcessorios.FormCreate(Sender: TObject);
var
  intCont: Integer;
begin
  inherited;

  strNomeTabela := 'CADACE';
  strNomeCampo  := 'ACE_CODACE';
  qryCadAce     := fCriarQuery('SELECT * FROM CADACE', Self);

  qryCadAce.FieldByName('ACE_CODACE').DisplayLabel := 'Código';
  qryCadAce.FieldbyName('ACE_DESCRI').DisplayLabel := 'Descrição';

  qryCadAce.FieldByName('AUTOINCREM').Visible := False;

  dtsDados  := fCriaDataSource(qryCadAce);
  qryTabela := qryCadAce;

  For intCont := 0 To ComponentCount - 1 Do
  Begin
    If (Components[intCont] is TDBEdit) Then
    Begin
      (Components[intCont] as TDBEdit).DataSource := dtsDados;
    End;
  End;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodAce;
end;

function TfrmCadAcessorios.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = dbeCodAce) Then
    Begin
      If (fEmptyStr(dbeCodAce.Text)) And (dbeCodAce.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Acessório deve ser preenchido!', ['&Ok']);
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
        fMensagem('ATENÇÃO!', 'A descrição do Acessório deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadAcessorios.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('ACE_CODACE');
  stlCampos.Add('ACE_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('ACE_DESCRI');
  stlCamInd.Add('ACE_CODACE');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

end.
