unit untCadCentroCustoImobilizado;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, dxScreenTip, cxClasses, untConsultas,
  dxCustomHint, cxHint, Data.DB, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Uni, untFuncoesSimples,
  DBEditFocus, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts,
  untTypesSistema, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons, BitBtnLockedIncrem;

type
  TfrmCadCentroCustoImobilizado = class(TfrmPaiCad)
    pnlFundo: TPanel;
    labelDescricao: TLabel;
    labelCodigo: TLabel;
    labelValidoContribIPI: TLabel;
    dtsCentroCusto: TDataSource;
    HintControler: TcxHintStyleController;
    labelSN: TLabel;
    dbeContribIPI: TDBEditFocus;
    dbeDescricao: TDBEditFocus;
    dbeCodigo: TDBEditFocus;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    qryCtaSpe: TUniQuery;
    function fTeveAlteracao: Boolean;
  public
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;


implementation

{$R *.dfm}

{ TfrmCadCentroCustoImobilizado }

procedure TfrmCadCentroCustoImobilizado.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeDescricao, False);
end;

procedure TfrmCadCentroCustoImobilizado.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadCentroCustoImobilizado.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadCentroCustoImobilizado.btnGravarClick(Sender: TObject);
begin
  blnUsaProCodigo := False;
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  If fTeveAlteracao Then
  Begin
    If fValidacoesBotaoGravarPai Then
    Begin
      Try
        inherited;
      Except
        On E: Exception Do
        Begin
          fRollBack;
          pMensagensErro(E.Message, '[untCadCentroCustoImobilizado.btnGravarClick]');
        End;
      End;
    End;
  End
  Else
  begin
    If Not fValidacoesBotaoGravarPai Then
      Exit;

    inherited;
  end;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadCentroCustoImobilizado.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeCodigo, True);
end;

procedure TfrmCadCentroCustoImobilizado.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrCentroCusto: TConsultasArray;
begin
  chrKey := '/';
  If fPesqCentroDeCustoSped(Self, dbeCodigo, Nil, qryTabela, chrKey, arrCentroCusto) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadCentroCustoImobilizado.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(btnIncluir);
end;

procedure TfrmCadCentroCustoImobilizado.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela := 'CTASPE';
  strNomeCampo  := 'SPE_CODIGO';

  qryCtaSpe              := fCriaQuery(Self);
  qryCtaSpe.Sql.Text     := ' SELECT * FROM CTASPE WHERE CTASPE.SPE_CODIGO = :CHAVE ';
  qryTabela              := qryCtaSpe;
  dtsCentroCusto.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

function TfrmCadCentroCustoImobilizado.fTeveAlteracao: Boolean;
  Var
    strSQL : String;
    qryCta : TUniQuery;
begin
  qryCta := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   SPE_DESCRI, ';
  strSQL := strSQL + '   SPE_CONIPI  ';
  strSQL := strSQL + ' FROM          ';
  strSQL := strSQL + '   CTASPE      ';
  strSQL := strSQL + ' WHERE         ';
  strSQL := strSQL + '   SPE_CODIGO = :CODIGO ';

  qryCta.Close;
  qryCta.SQL.Clear;
  qryCta.SQL.Add(strSQL);
  qryCta.ParamByName('CODIGO').AsString := dbeCodigo.Text;
  qryCta.Open;

  Result := dbeDescricao.Text <> qryCta.FieldByName('SPE_DESCRI').AsString;

  If Not Result Then
    Result := dbeContribIPI.Text <> qryCta.FieldByName('SPE_CONIPI').AsString;

  FreeAndNil(qryCta);

end;

function TfrmCadCentroCustoImobilizado.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*********************}
    {* VALIDA O CÓDIGO   *}
    {*********************}
    If (Sender = dbeCodigo) Then
    Begin
      If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If blnBuscaPorChave Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;

    End

    {****************************}
    {* VALIDA A DESCRIÇÃO       *}
    {****************************}
    Else If (Sender = dbeDescricao) Then
    Begin
      If fEmptyStr(dbeDescricao.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A descrição deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeContribIPI) Then
    Begin
      If fEmptyStr(dbeContribIPI.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo "Válido para Contribuinte IPI" deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (Pos(dbeContribIPI.Text, 'S_N') = 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo "Válido para Contribuinte IPI" deve ser preenchido com "S" ou "N"!', ['&Ok']);
        Result := False;
      End;
    End
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadCentroCustoImobilizado.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('SPE_CODIGO');
  stlCampos.Add('SPE_DESCRI');
  stlCampos.Add('SPE_CONIPI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('SPE_CODIGO');
  stlCamInd.Add('SPE_DESCRI');

  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');
end;

end.
