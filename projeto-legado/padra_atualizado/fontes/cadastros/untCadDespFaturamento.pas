unit untCadDespFaturamento;

interface

uses
  Windows, Classes, Controls, Forms, untPaiCad, AppEvnts, Menus, ComCtrls,
  StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls, DBEditFocus, DB, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade, SysUtils;

type
  TfrmCadDespFaturamento = class(TfrmPaiCad)
    pnlDados: TPanel;
    dbeDescri: TDBEditFocus;
    dbeCodigo: TDBEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    dtsCadDes: TDataSource;
    Label3: TLabel;
    dbeValDes: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    procedure pAfterOpen(Dataset: TDataset);
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadDespFaturamento.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeDescri, False);
end;

procedure TfrmCadDespFaturamento.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadDespFaturamento.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadDespFaturamento.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[untCadDespFaturamento.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadDespFaturamento.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeDescri, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);
end;

procedure TfrmCadDespFaturamento.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrDespesas: TConsultasArray;
begin
  chrKey := '/';
  If fPesqDespesasFaturamento(Self, Nil, Nil, qryTabela, chrKey, arrDespesas) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadDespFaturamento.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'CADDES';
  strNomeCampo      := 'DES_CODIGO';
  qryTabela         := fCriarQuery('SELECT * FROM CADDES WHERE FALSE', Self);
  dtsCadDes.DataSet := qryTabela;
  qryTabela.AfterOpen := pAfterOpen;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

procedure TfrmCadDespFaturamento.FormShow(Sender: TObject);
begin
  inherited;
  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;
end;

function TfrmCadDespFaturamento.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

 Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = dbeCodigo) Then
    Begin
      If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End

    Else
    If (Sender = dbeDescri) Then
    Begin
      If fEmptyStr(dbeDescri.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End

    Else
    If (Sender = dbeValDes) Then
    Begin
      If fStrToFloat(dbeValDes.Text) < 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O valor da despesa não pode ser menor negativo!', ['&Ok']);
        Result := False;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadDespFaturamento.pAfterOpen(Dataset: TDataset);
begin
  TFloatField(Dataset.FieldByName('DES_VALDES')).DisplayFormat := fMskDigitos(2);
end;

procedure TfrmCadDespFaturamento.pInicializaIndices;
begin
  inherited;
end;

end.

