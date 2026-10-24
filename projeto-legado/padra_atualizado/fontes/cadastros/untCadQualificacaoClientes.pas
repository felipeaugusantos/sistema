unit untCadQualificacaoClientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Data.DB, Vcl.StdCtrls, Uni,
  Vcl.DBCtrls, Vcl.Mask, DBEditFocus, QColorLabel, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, DBMemoFocus, untFuncoesSimples;

type
  TfrmCadQualificacaoClientes = class(TfrmPaiCad)
    pnlFundo: TPanel;
    Label1: TLabel;
    lblDesEti: TLabel;
    dbeCodigo: TDBEditFocus;
    dtsCadQua: TDataSource;
    dbeQualificacao: TDBMemoFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);

    protected
    qryCadQua: TUniQuery;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;

  end;

implementation

uses untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadQualificacaoClientes.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeQualificacao, False)
end;

procedure TfrmCadQualificacaoClientes.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadQualificacaoClientes.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadQualificacaoClientes.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[untCadQualificacaoClientes.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

end;

procedure TfrmCadQualificacaoClientes.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeQualificacao, False)
end;

procedure TfrmCadQualificacaoClientes.btnPesquisaClick(Sender: TObject);
var
  chrKey: Char;
  arrQualificacao: TConsultasArray;
begin
  inherited;
  chrKey := '/';
  if fPesqQualificacao(Self, Nil, Nil, qryTabela, chrKey, arrQualificacao) then
  begin
    pSetFocus(btnAlterar);
  end;
end;

procedure TfrmCadQualificacaoClientes.FormCreate(Sender: TObject);
  var
    strSQL: String;
begin
  inherited;
  strNomeTabela     := 'CADQUA';
  strNomeCampo      := 'QUA_CODQUA';

  strSQL            := 'SELECT * FROM CADQUA';
  qryCadQua         := fCriarQuery(strSQL, Self);
  qryTabela         := qryCadQua;
  dtsCadQua.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;

end;

function TfrmCadQualificacaoClientes.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = dbeCodigo) Then
    Begin
      If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da Qualificação deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End

    Else If (Sender = dbeQualificacao) Then
    Begin
      If fEmptyStr(dbeQualificacao.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição da Atividade deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadQualificacaoClientes.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('QUA_CODQUA');
  stlCampos.Add('QUA_DESQUA');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('QUA_DESQUA');
  stlCamInd.Add('QUA_CODQUA');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

end.
