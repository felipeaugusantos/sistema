unit untCadFrequenciaCRM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, Data.DB;

type
  TfrmCadFrequenciaCRM = class(TfrmPaiCad)
    dtsSource: TDataSource;
    Label1: TLabel;
    dbeCodigo: TDBEditFocus;
    Label2: TLabel;
    dbeDescri: TDBEditFocus;
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
  Protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untTypesSistema, untConsultas;

{ TfrmCadFrequenciaCRM }

procedure TfrmCadFrequenciaCRM.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadFrequenciaCRM.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadFrequenciaCRM.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[TfrmCadFrequenciaCRM.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadFrequenciaCRM.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pSetFocus(dbeDescri);
end;

procedure TfrmCadFrequenciaCRM.btnPesquisaClick(Sender: TObject);
  Var
    Key: Char;
    arrSel: TConsultasArray;
begin
  inherited;
  Key := '/';
  If fPesqFrequenciaCRM(Self, Nil, Nil, qryTabela, Key, arrSel) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadFrequenciaCRM.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'CRMFRE';
  strNomeCampo      := 'CRF_CODIGO';
  qryTabela         := fCriarQuery('SELECT * FROM CRMFRE', Self);
  dtsSource.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;

end;

procedure TfrmCadFrequenciaCRM.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(btnIncluir);
end;

function TfrmCadFrequenciaCRM.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = dbeDescri) Then
    Begin
      If fEmptyStr(dbeDescri.Text) Then
      Begin
        Result := False;
        fMensagem('', 'Digite uma Descrição!', ['&Ok']);
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCadFrequenciaCRM.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('CRF_CODIGO');
  stlCampos.Add('CRF_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('CRF_DESCRI');
  stlCamInd.Add('CRF_CODIGO');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');

end;

end.
