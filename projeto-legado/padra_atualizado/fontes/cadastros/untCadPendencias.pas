unit untCadPendencias;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, QColorLabel, Data.DB;

type
  TfrmCadPendencias = class(TfrmPaiCad)
    Panel1: TPanel;
    Label1: TLabel;
    dbeCodigo: TDBEditFocus;
    Label4: TLabel;
    dbeDescri: TDBEditFocus;
    Label67: TLabel;
    dbeAtivo_: TDBEditFocus;
    ColorLabel4: TColorLabel;
    dtsCadPen: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
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
  frmCadPendencias: TfrmCadPendencias;

implementation

{$R *.dfm}

Uses
  untTypesSistema,
  untFuncoesSimples,
  untConsultas;

procedure TfrmCadPendencias.btnAlterarClick(Sender: TObject);
begin
  inherited;

  pHabilitaCodigo(dbeCodigo, dbeDescri, False);
end;

procedure TfrmCadPendencias.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadPendencias.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadPendencias.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[untCadPendencias.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

end;

procedure TfrmCadPendencias.btnIncluirClick(Sender: TObject);
begin
  inherited;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeDescri, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);

  qryTabela.FieldByName('PEN_ATIVO_').AsString := 'S';
end;

procedure TfrmCadPendencias.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrAtiv: TConsultasArray;
begin
  chrKey := '/';
  If fPesqPendenciaFiscal(Self, Nil, Nil, qryTabela, chrKey, arrAtiv) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadPendencias.FormCreate(Sender: TObject);
begin
  inherited;

  strNomeTabela         := 'CADPEN';
  strNomeCampo          := 'PEN_CODPEN';

  qryTabela             := fCriaQuery(Self);
  dtsCadPen.DataSet     := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0]     := dbeCodigo;
end;

procedure TfrmCadPendencias.FormShow(Sender: TObject);
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

function TfrmCadPendencias.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
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

    Else If (Sender = dbeAtivo_) Then
    Begin

      If Pos(dbeAtivo_.Text, 'S-N') = 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O status da Pendência deve ser "S" ou "N"!', ['&Ok']);
        Result := False;
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

procedure TfrmCadPendencias.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;
End;

end.
