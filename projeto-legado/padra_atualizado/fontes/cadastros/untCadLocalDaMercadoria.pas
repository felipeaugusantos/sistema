unit untCadLocalDaMercadoria;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, Data.DB;

type
  TfrmCadLocalDaMercadoria = class(TfrmPaiCad)
    Panel1: TPanel;
    Label1: TLabel;
    Label4: TLabel;
    dbeCodigo: TDBEditFocus;
    dbeDescri: TDBEditFocus;
    dtsTabela: TDataSource;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmCadLocalDaMercadoria: TfrmCadLocalDaMercadoria;

implementation

{$R *.dfm}

Uses
  untTypesSistema,
  untFuncoesSimples,
  untConsultas;

procedure TfrmCadLocalDaMercadoria.btnAlterarClick(Sender: TObject);
begin
  inherited;

  pHabilitaCodigo(dbeCodigo, dbeDescri, False);
end;

procedure TfrmCadLocalDaMercadoria.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadLocalDaMercadoria.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadLocalDaMercadoria.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[untCadLocalDaMercadoria.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

end;

procedure TfrmCadLocalDaMercadoria.btnIncluirClick(Sender: TObject);
begin
  inherited;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeDescri, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);

end;

procedure TfrmCadLocalDaMercadoria.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrAtiv: TConsultasArray;
begin
  chrKey := '/';
  If fPesqLocalMercadoria(Self, Nil, Nil, qryTabela, chrKey, arrAtiv) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadLocalDaMercadoria.FormCreate(Sender: TObject);
begin
  inherited;

  strNomeTabela         := 'LOCMER';
  strNomeCampo          := 'LOC_CODLOC';

  qryTabela             := fCriaQuery(Self);
  dtsTabela.DataSet     := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0]     := dbeCodigo;

end;

procedure TfrmCadLocalDaMercadoria.FormShow(Sender: TObject);
begin
  inherited;

  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;

  pSetFocus(btnIncluir);
end;

function TfrmCadLocalDaMercadoria.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin

  Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = dbeCodigo) Then
    Begin
      If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da Pendência deve ser preenchido!', ['&Ok']);
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
        fMensagem('ATENÇÃO!', 'A Descrição da Pendência deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadLocalDaMercadoria.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;
End;

end.
