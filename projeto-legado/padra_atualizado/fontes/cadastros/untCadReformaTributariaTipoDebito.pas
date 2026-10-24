unit untCadReformaTributariaTipoDebito;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.DBCtrls, DBMemoFocus, Vcl.Mask, DBEditFocus, Data.DB, Uni;

type
  TfrmCadReformaTributariaTipoDebito = class(TfrmPaiCad)
    pnlPrincipal: TPanel;
    lblCodigo: TLabel;
    lblDescr: TLabel;
    dbeCodigo: TDBEditFocus;
    dbeDescr: TDBMemoFocus;
    dtsDados: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  private
    { Private declarations }
    qryDebRef: TUniQuery;
  public
    { Public declarations }
  end;

var
  frmCadReformaTributariaTipoDebito: TfrmCadReformaTributariaTipoDebito;

implementation

uses untFuncoesSimples, untConsultas, untTypesSistema, untFuncIns;

{$R *.dfm}

procedure TfrmCadReformaTributariaTipoDebito.btnAlterarClick(Sender: TObject);
begin
  inherited;
  dbeCodigo.Enabled := False;
  pSetFocus(dbeDescr);
end;

procedure TfrmCadReformaTributariaTipoDebito.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadReformaTributariaTipoDebito.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadReformaTributariaTipoDebito.btnGravarClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
  If fValidacoesBotaoGravarPai Then
  Begin
    Try
      inherited;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[TfrmCadReformaTributariaTipoDebito.btnGravarClick]');
      End;
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadReformaTributariaTipoDebito.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pSetFocus(dbeCodigo);
end;

procedure TfrmCadReformaTributariaTipoDebito.btnPesquisaClick(Sender: TObject);
var
  chrKey: Char;
  arrSel: TConsultasArray;
begin
  chrKey := '/';
  fPesqReformaTributariaTipoDeDebito(Self, nil, nil, qryTabela, chrKey, arrSel);
end;

procedure TfrmCadReformaTributariaTipoDebito.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela       := 'DEBREF';
  strNomeCampo        := 'DEB_CODIGO';
  qryTabela           := fCriaQuery(Self);
  qryDebRef           := fCriaQuery(Self);
  dtsDados.DataSet    := qryTabela;
  dbeCodigo.Enabled   := False;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

procedure TfrmCadReformaTributariaTipoDebito.pInicializaIndices;
begin
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('DEB_CODIGO');
  stlCampos.Add('DEB_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('DEB_CODIGO');
  stlCamInd.Add('DEB_DESCRI');

  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');
end;

function TfrmCadReformaTributariaTipoDebito.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
Var
  qryAux : TUniQuery;

  function fExisteDebRef: Boolean;
  begin
    Result := False;

    If (qryTabela.FieldByName('DEB_CODIGO').OldValue = qryTabela.FieldByName('DEB_CODIGO').NewValue) Then
      Exit;

    qryAux := fCriaQuery(Self);

    Try
      qryAux.SQL.Clear;
      qryAux.SQL.Add('SELECT DEB_CODIGO FROM DEBREF ');
      qryAux.SQL.Add('WHERE DEB_CODIGO = :CODIGO ');
      qryAux.ParamByName('CODIGO').AsString := dbeCodigo.Text;
      qryAux.Open;

      Result := (qryAux.RecordCount > 0);

    Finally
      FreeAndNil(qryAux);
    End;
  end;

begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = dbeCodigo) And (dbeCodigo.Enabled) Then
    Begin
      If fEmptyStr(dbeCodigo.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If fExisteDebRef Then
      Begin
        fMensagem('ATENÇÃO!', 'Já existe um registro com esses código. Verifique !', ['&Ok']);
        Result := False;
      End;
    End
    Else If Sender = dbeDescr Then
    Begin
      If fEmptyStr(dbeDescr.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'A Descrição deve ser preenchida!', ['&Ok']);
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

end.


