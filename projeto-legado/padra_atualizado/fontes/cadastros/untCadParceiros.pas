unit untCadParceiros;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, DB, Mask, DBCtrls, DBEditFocus, DBMemoFocus,
  EditFocus, untFuncIns, untConstantes, frxClass, frxExportCSVTestabilidade,
  BitBtnLockedIncrem;

type
  TfrmCadParceiros = class(TfrmPaiCad)
    pnlFundo: TPanel;
    dbeCodPar: TDBEditFocus;
    dbeNomPar: TDBEditFocus;
    lbl1: TLabel;
    lbl4: TLabel;
    dtsCadPar: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  public
    { Public declarations }
  end;


implementation

uses untFuncoes, untfuncoesSimples, untModulo, untPai, untConsultas,
  untTypesSistema;

{$R *.dfm}

procedure TfrmCadParceiros.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'CADPAR';
  strNomeCampo      := 'PAR_CODPAR';
  qryTabela         := fCriarQuery('SELECT * FROM CADPAR WHERE FALSE', Self);
  dtsCadPar.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodPar;
end;

function TfrmCadParceiros.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
Begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = dbeCodPar) And dbeCodPar.Enabled Then
    Begin
      If fEmptyStr(dbeCodPar.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO', 'O código do parceiro deve ser preenchido!', ['OK']);
      End;
    End

    Else If Sender = dbeNomPar Then
    Begin
      If fEmptyStr(dbeNomPar.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO', 'O nome do parceiro deve ser preenchido!', ['OK']);
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
End;

procedure TfrmCadParceiros.pInicializaIndices;
Begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;
End;

procedure TfrmCadParceiros.FormShow(Sender: TObject);
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

procedure TfrmCadParceiros.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadMovFlex.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadParceiros.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[untCadParceiros.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadParceiros.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodPar, dbeNomPar, Not blnUsaProCodigo);
end;

procedure TfrmCadParceiros.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrParceiros: TConsultasArray;
begin
  chrKey := '/';
  If fPesqParceiro(Self, Nil, Nil, qryTabela, chrKey, arrParceiros) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadParceiros.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodPar, dbeNomPar, False);
end;

end.
