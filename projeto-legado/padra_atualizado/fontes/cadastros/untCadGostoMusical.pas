unit untCadGostoMusical;

interface

uses
  Windows, Classes, Controls, Forms, untPaiCad, AppEvnts, Menus, ComCtrls,
  StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls, DBEditFocus, DB, BitBtnLockedIncrem,
  SysUtils;

type
  TfrmCadGostoMusical = class(TfrmPaiCad)
    pnlDados: TPanel;
    dbeDesGmu: TDBEditFocus;
    dbeCodigo: TDBEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    dtsCadGmu: TDataSource;
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

procedure TfrmCadGostoMusical.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeDesGmu, False);
end;

procedure TfrmCadGostoMusical.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadGostoMusical.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadGostoMusical.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[TfrmCadGostoMusical.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadGostoMusical.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeDesGmu, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);
end;

procedure TfrmCadGostoMusical.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrGostoMusical: TConsultasArray;
begin
  {*******************************}
  {* NOVA CONSULTA DE CARGOS     *}
  {****************************AC*}
  chrKey := '/';
  If fPesqGostosMusicaisCliCon(Self, Nil, Nil, qryTabela, chrKey, arrGostoMusical) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadGostoMusical.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'CADGMU';
  strNomeCampo      := 'GMU_CODGMU';
  qryTabela         := fCriarQuery('SELECT * FROM CADGMU', Self);
  dtsCadGmu.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

procedure TfrmCadGostoMusical.FormShow(Sender: TObject);
begin
  inherited;
  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;
end;

procedure TfrmCadGostoMusical.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('GMU_CODGMU');
  stlCampos.Add('GMU_DESGMU');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('GMU_DESGMU');
  stlCamInd.Add('GMU_CODGMU');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código Gosto Musical');
end;

function TfrmCadGostoMusical.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

 Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = dbeCodigo) Then
    Begin
      If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Gosto Musical deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End

    Else
    If (Sender = dbeDesGmu) Then
    Begin
      If fEmptyStr(dbeDesGmu.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição do Gosto Musical deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

end.

