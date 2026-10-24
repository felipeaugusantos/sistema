unit untCadEscolaridades;

interface

uses
  Windows, Classes, Controls, Forms, untPaiCad, AppEvnts, Menus, ComCtrls,
  StdCtrls, Buttons, ExtCtrls, DB, DBCtrls, DBEditFocus, BitBtnLockedIncrem,
  Mask, frxClass, frxExportCSVTestabilidade, SysUtils;

type
  TfrmCadEscolaridades = class(TfrmPaiCad)
    pnlDados: TPanel;
    Label2: TLabel;
    dbeDesEsc: TDBEditFocus;
    dbeCodigo: TDBEditFocus;
    Label1: TLabel;
    dtsCadEsc: TDataSource;
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

procedure TfrmCadEscolaridades.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeDesEsc, False);
end;

procedure TfrmCadEscolaridades.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadEscolaridades.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadEscolaridades.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[TfrmCadEscolaridades.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadEscolaridades.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeDesEsc, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);
end;

procedure TfrmCadEscolaridades.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrEscol: TConsultasArray;
begin
  {*******************************}
  {* NOVA CONSULTA DE CARGOS     *}
  {****************************AC*}
  chrKey := '/';
  If fPesqEscolaridadesCliCon(Self, Nil, Nil, qryTabela, chrKey, arrEscol) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadEscolaridades.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'CADESC';
  strNomeCampo      := 'ESC_CODESC';
  qryTabela         := fCriarQuery('SELECT * FROM CADESC', Self);
  dtsCadEsc.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

procedure TfrmCadEscolaridades.FormShow(Sender: TObject);
begin
  inherited;
  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;
end;

procedure TfrmCadEscolaridades.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('ESC_CODESC');
  stlCampos.Add('ESC_DESESC');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('ESC_DESESC');
  stlCamInd.Add('ESC_CODESC');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código Escolaridade');
end;

function TfrmCadEscolaridades.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

 Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = dbeCodigo) Then
    Begin
      If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da Escolaridade deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End

    Else
    If (Sender = dbeDesEsc) Then
    Begin
      If fEmptyStr(dbeDesEsc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição da Escolaridade deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;


end.

