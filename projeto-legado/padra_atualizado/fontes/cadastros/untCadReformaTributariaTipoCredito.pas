unit untCadReformaTributariaTipoCredito;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.DBCtrls, DBMemoFocus, Vcl.Mask, DBEditFocus, Data.DB, Uni;

type
  TfrmCadReformaTributariaTipoCredito = class(TfrmPaiCad)
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
    qryCreRef: TUniQuery;
  public
    { Public declarations }
  end;

var
  frmCadReformaTributariaTipoCredito: TfrmCadReformaTributariaTipoCredito;

implementation

uses untFuncoesSimples, untConsultas, untTypesSistema, untFuncIns;

{$R *.dfm}

procedure TfrmCadReformaTributariaTipoCredito.btnAlterarClick(Sender: TObject);
begin
  inherited;
  dbeCodigo.Enabled := False;
  pSetFocus(dbeDescr);
end;

procedure TfrmCadReformaTributariaTipoCredito.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadReformaTributariaTipoCredito.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadReformaTributariaTipoCredito.btnGravarClick(Sender: TObject);
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
        pMensagensErro(E.Message, '[TfrmCadReformaTributariaTipoCredito.btnGravarClick]');
      End;
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadReformaTributariaTipoCredito.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pSetFocus(dbeCodigo);
end;

procedure TfrmCadReformaTributariaTipoCredito.btnPesquisaClick(Sender: TObject);
var
  chrKey: Char;
  arrSel: TConsultasArray;
begin
  chrKey := '/';
  fPesqReformaTributariaTipoDeCredito(Self, nil, nil, qryTabela, chrKey, arrSel);
end;

procedure TfrmCadReformaTributariaTipoCredito.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela       := 'CREREF';
  strNomeCampo        := 'CRE_CODIGO';
  qryTabela           := fCriaQuery(Self);
  qryCreRef           := fCriaQuery(Self);
  dtsDados.DataSet    := qryTabela;
  dbeCodigo.Enabled   := False;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

procedure TfrmCadReformaTributariaTipoCredito.pInicializaIndices;
begin
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('CRE_CODIGO');
  stlCampos.Add('CRE_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('CRE_CODIGO');
  stlCamInd.Add('CRE_DESCRI');

  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');
end;

function TfrmCadReformaTributariaTipoCredito.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
Var
  qryAux : TUniQuery;

  function fExisteCreRef: Boolean;
  begin
    Result := False;

    If (qryTabela.FieldByName('CRE_CODIGO').OldValue = qryTabela.FieldByName('CRE_CODIGO').NewValue) Then
      Exit;

    qryAux := fCriaQuery(Self);

    Try
      qryAux.SQL.Clear;
      qryAux.SQL.Add('SELECT CRE_CODIGO FROM CREREF ');
      qryAux.SQL.Add('WHERE CRE_CODIGO = :CODIGO ');
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
      Else If fExisteCreRef Then
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
