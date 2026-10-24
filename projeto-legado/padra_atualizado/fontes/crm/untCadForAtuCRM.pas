unit untCadForAtuCRM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, Data.DB;

type
  TfrmCadForAtuCRM = class(TfrmPaiCad)
    Label1: TLabel;
    Label2: TLabel;
    dbeDescri: TDBEditFocus;
    dbeCodigo: TDBEditFocus;
    dtsSource: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
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

implementation

{$R *.dfm}

uses untFuncoesSimples, untTypesSistema, untConsultas;

{ TfrmCadForAtuCRM }

procedure TfrmCadForAtuCRM.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadForAtuCRM.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadForAtuCRM.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[TfrmCadForAtuCRM.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadForAtuCRM.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pSetFocus(dbeDescri);
end;

procedure TfrmCadForAtuCRM.btnPesquisaClick(Sender: TObject);
  Var
    Key: Char;
    arrSel: TConsultasArray;
begin
  inherited;
  Key := '/';
  If fPesqFornecedorAtualCRM(Self, Nil, Nil, qryTabela, Key, arrSel) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadForAtuCRM.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'CRMFOR';
  strNomeCampo      := 'CRF_CODIGO';
  qryTabela         := fCriarQuery('SELECT * FROM CRMFOR', Self);
  dtsSource.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;

end;

procedure TfrmCadForAtuCRM.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(btnIncluir);
end;

function TfrmCadForAtuCRM.fValidaCampos(Sender: TWinControl;  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = dbeDescri) Then
    Begin
      If fEmptyStr(dbeDescri.Text) Then
      Begin
        Result := False;
        fMensagem('', 'Digite o Nome do Fornecedor!', ['&Ok']);
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadForAtuCRM.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('CRF_CODIGO');
  stlCampos.Add('CRF_NOMFOR');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('CRF_NOMFOR');
  stlCamInd.Add('CRF_CODIGO');

  stlDesInd.Add('Nome');
  stlDesInd.Add('Código');

end;

end.
