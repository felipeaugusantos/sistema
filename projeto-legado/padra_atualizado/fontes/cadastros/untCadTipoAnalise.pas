unit untCadTipoAnalise;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, Data.DB, untZClient;

type
  TfrmCadTipoAnalise = class(TfrmPaiCad)
    dbeCodigo: TDBEditFocus;
    dbeDescri: TDBEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    dblMetodo: TDBLookupComboBox;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    dtsTabela : TDataSource;
    cdsMetodo : TZClient;
  public
  protected
    Function fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean) : Boolean;Override;
    Procedure pInicializaIndices; override;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untTypesSistema, untConsultas;

{ TfrmCadTipoAnalise }

procedure TfrmCadTipoAnalise.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeDescri, False);
  pSetFocus(dbeDescri);
end;

procedure TfrmCadTipoAnalise.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadTipoAnalise.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

end;

procedure TfrmCadTipoAnalise.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[untCadTipoAnalise.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadTipoAnalise.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeDescri, False);
  pSetFocus(dbeDescri);
end;

procedure TfrmCadTipoAnalise.btnPesquisaClick(Sender: TObject);
  Var
    chrKey : Char;
    arrSel: TConsultasArray;
begin
  inherited;
  chrKey := '/';
  If fPesqTipoAnalise(Self, Nil, Nil, qryTabela, chrKey, arrSel) Then
  Begin
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadTipoAnalise.FormCreate(Sender: TObject);
begin
  inherited;
  cdsMetodo := TZClient.Create(Self, 'SELECT * FROM METODO');
  cdsMetodo.fAbreClient(True, 'TfrmCadTipoAnalise.FormCreate');
  dblMetodo.ListSource := cdsMetodo.dtsSource;

  qryTabela := fCriaQuery(Self);
  dtsTabela := fCriaDataSource(qryTabela);

  strNomeTabela     := 'TIPANA';
  strNomeCampo      := 'TAN_CODIGO';

  dbeCodigo.DataSource := dtsTabela;
  dbeDescri.DataSource := dtsTabela;
  dblMetodo.DataSource := dtsTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

procedure TfrmCadTipoAnalise.FormDestroy(Sender: TObject);
begin
  FreeAndNil(dtsTabela);
  FreeAndNil(qryTabela);

  FreeAndNil(stlCampos);
  FreeAndNil(stlCamInd);
  FreeAndNil(stlDesInd);
  inherited;
end;

function TfrmCadTipoAnalise.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin
    If (Sender = dbeDescri) Then
    Begin
      If fEmptyStr(dbeDescri.Text) Then
      Begin
        fMensagem('', 'Informe o campo Descrição!', ['&Ok']);
        Result := False;
      End;
    End;

  End;

  If not Result Then
    pSetFocus(Sender);

end;

procedure TfrmCadTipoAnalise.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

end;

end.
