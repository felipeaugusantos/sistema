unit untCadCargos;

interface

uses
  Windows, Classes, Controls, Forms, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls,
  Buttons, ExtCtrls, DBCtrls, DBEditFocus, DB, BitBtnLockedIncrem, Mask;

type
  TfrmCadCargos = class(TfrmPaiCad)
    pnlDados: TPanel;
    dbeCodigo: TDBEditFocus;
    dbeDesCgo: TDBEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    dtsCadCgo: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
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

procedure TfrmCadCargos.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeDesCgo, False);
end;

procedure TfrmCadCargos.btnExcluirClick(Sender: TObject);
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

procedure TfrmCadCargos.btnGravarClick(Sender: TObject);
begin
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

procedure TfrmCadCargos.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeDesCgo, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);
end;

procedure TfrmCadCargos.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrCargo: TConsultasArray;
begin
  {*******************************}
  {* NOVA CONSULTA DE CARGOS     *}
  {****************************AC*}
  chrKey := '/';
  If fPesqCargosCliCon(Self, Nil, Nil, qryTabela, chrKey, arrCargo) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadCargos.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'CADCGO';
  strNomeCampo      := 'CGO_CODCGO';
  qryTabela         := fCriarQuery('SELECT * FROM CADCGO', Self);
  dtsCadCgo.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

procedure TfrmCadCargos.FormShow(Sender: TObject);
begin
  inherited;
  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;
end;

procedure TfrmCadCargos.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('CGO_CODCGO');
  stlCampos.Add('CGO_DESCGO');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('CGO_DESCGO');
  stlCamInd.Add('CGO_CODCGO');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código Cargo');
end;

function TfrmCadCargos.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

 Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = dbeCodigo) Then
    Begin
      If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Cargo deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End

    Else
    If (Sender = dbeDesCgo) Then
    Begin
      If fEmptyStr(dbeDesCgo.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição do Cargo deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

end.

