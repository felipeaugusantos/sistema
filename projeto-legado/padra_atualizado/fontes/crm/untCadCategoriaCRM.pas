unit untCadCategoriaCRM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, Data.DB;

type
  TfrmCadCategoriaCRM = class(TfrmPaiCad)
    dtsSource: TDataSource;
    dbeDescri: TDBEditFocus;
    Label2: TLabel;
    Label1: TLabel;
    dbeCodigo: TDBEditFocus;
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

{ TfrmCadCategoriaCRM }

procedure TfrmCadCategoriaCRM.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadCategoriaCRM.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadCategoriaCRM.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[TfrmCadCategoriaCRM.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadCategoriaCRM.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pSetFocus(dbeDescri);
end;

procedure TfrmCadCategoriaCRM.btnPesquisaClick(Sender: TObject);
  Var
    Key: Char;
    arrSel: TConsultasArray;
begin
  inherited;
  Key := '/';
  If fPesqCategoriaCRM(Self, Nil, Nil, qryTabela, Key, arrSel) Then
    pSetFocus(btnAlterar);

end;

procedure TfrmCadCategoriaCRM.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'CRMCAT';
  strNomeCampo      := 'CAT_CODIGO';
  qryTabela         := fCriarQuery('SELECT * FROM CRMCAT', Self);
  dtsSource.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;

end;

procedure TfrmCadCategoriaCRM.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(btnIncluir);
end;

function TfrmCadCategoriaCRM.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
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

procedure TfrmCadCategoriaCRM.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('CAT_CODIGO');
  stlCampos.Add('CAT_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('CAT_DESCRI');
  stlCamInd.Add('CAT_CODIGO');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

end.
