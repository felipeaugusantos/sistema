unit untCadPagBosch;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Data.DB, Vcl.DBCtrls,
  DBMemoFocus, Vcl.Mask, DBEditFocus, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDBEdit, MaskEditFocus;

type
  TfrmCadPagBosch = class(TfrmPaiCad)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    dbeCODCND: TDBEditFocus;
    dbeDESCRI: TDBEditFocus;
    dtsDados: TDataSource;
    mskCndPag: TMaskEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  protected
    procedure pInicializaIndices; override;
    function fValidaCondPagamento(blnBuscaPorChave: Boolean): Boolean;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  private
    procedure pAjustatela;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadPagBosch: TfrmCadPagBosch;

implementation

uses untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}
function TfrmCadPagBosch.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin
  Result := True;
  If (Sender = mskCndPag) Then
  Begin
    Result := fValidaCondPagamento(blnBuscaPorChave);
  End;
end;

procedure TfrmCadPagBosch.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pAjustatela;
end;

procedure TfrmCadPagBosch.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pAjustatela;
  if qryTabela.IsEmpty then
    mskCndPag.Clear;
end;

procedure TfrmCadPagBosch.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadPagBosch.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
  begin
    fCommit;
  end
  Else
    fRollBack;

  if qryTabela.IsEmpty then
    mskCndPag.Clear;
end;

procedure TfrmCadPagBosch.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    dtsDados.DataSet.FieldByName('CND_AUTCOM').AsString := (fTiraCaracEspeciais(mskCndPag.Text));
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadPagBosch.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

  pAjustatela;
end;

procedure TfrmCadPagBosch.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pAjustatela;
  blnUsaProCodigo := False;
  mskCndPag.Clear;
end;

procedure TfrmCadPagBosch.btnPesquisaClick(Sender: TObject);
var
  chrKey         : Char;
  arrCest        : TConsultasArray;
begin
  {*************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTOS *}
  {**********************************DP*}
  chrKey := '/';
  fPesqCondPagBosch(Self, Nil, Nil, qryTabela, chrKey, arrCest);

end;

procedure TfrmCadPagBosch.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela        := 'BOSCH_CADCND';
  strNomeCampo         := 'CND_CODCND';
  qryTabela            := fCriaQuery(Self);
  dtsDados.DataSet     := qryTabela;
end;

procedure TfrmCadPagBosch.FormShow(Sender: TObject);
begin
  inherited;
  mskCndPag.Enabled := (dtsDados.State in dsEditModes);
end;

procedure TfrmCadPagBosch.pAjustatela;
begin
  mskCndPag.Enabled := (dtsDados.State in dsEditModes)
end;

procedure TfrmCadPagBosch.pInicializaIndices;
begin
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('CND_CODCND');
  stlCampos.Add('CND_DESCRI');
  stlCampos.Add('CND_AUTCOM');
  stlCampos.Add('AUTOINCREM');

  stlDesInd.Add('Código Bosch');
  stlDesInd.Add('Descrição Bosch');
  stlDesInd.Add('Referência Autcom');
end;

function TfrmCadPagBosch.fValidaCondPagamento(blnBuscaPorChave: Boolean): Boolean;
  Var
   strConPag: String;
begin
  Result := True;
  If fEmptyStr(fTiraCaracEspeciais(mskCndPag.Text)) Then
  Begin
    fMensagem('ATENÇÃO!', 'A condição de pagamento deve ser preenchida!', ['&O k']);
    Result := False;
  End
  Else If fEmptyStr(Copy(mskCndPag.Text, 1, 2)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Condição de pagamento inválida!', ['&O k']);
    Result := False;
  End
  Else If StrToInt(Copy(mskCndPag.Text, 1, 2)) > 24 Then
  Begin
    fMensagem('', 'Não é permitido mais que 24 parcelas!', ['&O k']);
    Result := False;
  End
  Else If Not fValidaCndPag(mskCndPag.Text, strConPag, VS_Date) Then
  Begin
    fMensagem('ATENÇÃO!', 'Essa condição de pagamento não é valida!', ['&O k']);
    Result := False;
  End Else
  Begin
    mskCndPag.Text := strConPag;

    If fEmptyStr(strConPag) Then
      Result := False;

  End;
end;

end.
