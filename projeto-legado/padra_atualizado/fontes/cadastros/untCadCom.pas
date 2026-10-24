{******************************}
{* qryCadCom -> CADCOM        *}
{***************************RV*}
unit untCadCom;

interface

uses
  Windows, Classes, Controls, Forms, untPaiCad, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, DBCtrls, DBEditFocus, DB, Uni, AppEvnts, BitBtnLockedIncrem,
  DBLookupComboBoxFocus, UniClientDataSet, Mask, Datasnap.DBClient, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmCadCom = class(TfrmPaiCad)
    pnlFundo: TPanel;
    pnlTopo: TPanel;
    dbeCodigo: TDBEditFocus;
    dbeDescri: TDBEditFocus;
    lblCodigo: TLabel;
    lblDescricao: TLabel;
    pnlComissoes: TPanel;
    dbePerIni: TDBEditFocus;
    Label1: TLabel;
    dbePerFin: TDBEditFocus;
    Label2: TLabel;
    dbeComPra: TDBEditFocus;
    Label3: TLabel;
    dtsCadCom: TDataSource;
    dtsListTipVen: TDataSource;
    cdsListTipVen: TUniClientDataSet;
    cdsListTipVenTipVen: TStringField;
    cdsListTipVenDesTip: TStringField;
    pnlTipVen: TPanel;
    dbeTipVen: TDBLookupComboBoxFocus;
    lbl1: TLabel;
    lbl2: TLabel;
    dbeComVis: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    strMsgVen: String;
    qryCadCom: TUniQuery;

    function fExisteMargem(fltValor: Double): Boolean;
    procedure pCriaCDSListaVendedor;
  public
    { Public declarations }
  protected
    procedure pInicializaIndices; Override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

implementation

uses SysUtils, untPai, untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadCom.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryCadCom);
end;

procedure TfrmCadCom.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'CADCOM';
  strNomeCampo      := 'COM_CODCOM';

  qryCadCom         := fCriaQuery(Self);
  qryTabela         := qryCadCom;
  dtsCadCom.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

procedure TfrmCadCom.FormShow(Sender: TObject);
begin
  inherited;
  pnlTipVen.Visible := fCfgSis('OPCCOM') = 'PD';

  If Not pnlTipVen.Visible Then
    Self.Height := Self.Height - pnlTipVen.Height
  Else
  Begin
    strMsgVen := ' para esse tipo de vendedor';
    pCriaCDSListaVendedor;
  End;

  pSetFocus(btnIncluir);
end;

procedure TfrmCadCom.pCriaCDSListaVendedor;
begin
  With cdsListTipVen Do
  Begin
    CreateDataSet;
    Open;

    Insert;
    FieldByName('CODTIP').AsString := 'I';
    FieldByName('DESTIP').AsString := 'VENDEDOR INTERNO';
    Post;

    Insert;
    FieldByName('CODTIP').AsString := 'E';
    FieldByName('DESTIP').AsString := 'REPRES. EXTERNO LOJA';
    Post;

    Insert;
    FieldByName('CODTIP').AsString := 'D';
    FieldByName('DESTIP').AsString := 'REPRES. EXTERNO DISTRIBUIDOR';
    Post;
  End;
end;

procedure TfrmCadCom.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('COM_CODCOM');
  stlCampos.Add('COM_DESCOM');
  stlCampos.Add('COM_PERINI');
  stlCampos.Add('COM_PERFIN');
  stlCampos.Add('COM_PERCOM');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('COM_DESCOM');
  stlCamInd.Add('COM_CODCOM');
  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

procedure TfrmCadCom.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadCom.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

end;

procedure TfrmCadCom.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[untCadCom.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

end;

procedure TfrmCadCom.btnIncluirClick(Sender: TObject);
begin
  inherited;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeDescri, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);

  If pnlTipVen.Visible Then
    dbeTipVen.Field.AsString := 'I';

end;

procedure TfrmCadCom.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrComissao: TConsultasArray;
begin
  {*******************************}
  {* NOVA CONSULTA DE COMISSÕES  *}
  {****************************RV*}
  chrKey := '/';
  If fPesqFaixaComissao(Self, Nil, Nil, qryTabela, chrKey, arrComissao) Then
   pSetFocus(btnAlterar);
end;

procedure TfrmCadCom.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeDescri, False);
end;

function TfrmCadCom.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {************************************}
    {* VALIDA CODIGO                    *}
    {*********************************AF*}
    If (Sender = dbeCodigo) Then
    Begin

      If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código deve ser preenchido!', ['&O k']);
        Result := False;
      End;

    End

    {************************************}
    {* VALIDA DESCRIÇÃO                 *}
    {*********************************AF*}
    Else If (Sender = dbeDescri) Then
    Begin

      If fEmptyStr(dbeDescri.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição deve ser preenchido!', ['&O k']);
        Result := False;
      End;

    End

    {************************************}
    {* VALIDA A % INICIAL               *}
    {*********************************AF*}
    Else If (Sender = dbePerIni) Then
    Begin

      If fEmptyStr(dbePerIni.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo % Inicial deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin

        If fExisteMargem(fStrToFloat(dbePerIni.Text)) Then
        Begin
          fMensagem('','Já existe um período com esta margem '+ strMsgVen +'!',['&OK']);
          Result := False;
        End;

      End;

    End

    {************************************}
    {* VALIDA A % FINAL                 *}
    {*********************************AF*}
    Else If (Sender = dbePerFin) Then
    Begin

      If fEmptyStr(dbePerFin.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo % Final deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin

        If fExisteMargem(fStrToFloat(dbePerFin.Text)) Then
        Begin
          fMensagem('','Já existe um período com esta margem '+ strMsgVen +'!',['&OK']);
          Result := False;
          pSetFocus(Sender);
          Exit;
        End;

        If Not fEmptyStr(dbePerIni.Text) Then
        Begin

          If fStrToFloat(dbePerIni.Text) > fStrToFloat(dbePerFin.Text) Then
          Begin
            fMensagem('ATENÇÃO!','A %Inicial não pode ser maior que %Final!',['&OK']);
            Result := False;
          End;

        End;

      End;

    End

    {************************************}
    {* VALIDA % COMISSÃO A VISTA        *}
    {*********************************MM*}
    Else If (Sender = dbeComVis) Then
    Begin

      If fEmptyStr(dbeComVis.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O Campo % Comissão a Vista deve ser preenchido!', ['&O k']);
        Result := False;
      End;

    End

    {************************************}
    {* VALIDA % COMISSÃO A PRAZO        *}
    {*********************************MM*}
    Else If (Sender = dbeComPra) Then
    Begin

      If fEmptyStr(dbeComPra.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O Campo % Comissão a Prazo deve ser preenchido!', ['&O k']);
        Result := False;
      End;

    End

    Else If (Sender = dbeTipVen) Then
    Begin

      If (pnlTipVen.Visible) And (fEmptyStr(dbeTipVen.Text)) Then
      Begin
        fMensagem('ATENÇÃO', 'O Campo Tipo Vendedor deve ser preenchido!', ['&O k']);
        Result := False;
      End;
      
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

function TfrmCadCom.fExisteMargem(fltValor: Double): Boolean;
  Var
    strSQL   : String;
    qryGenCom: TUniQuery;

Begin
  Try

    Result := False;

    qryGenCom := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCOM ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  :VALOR >= COM_PERINI AND ';
    strSQL := strSQL + '  :VALOR <= COM_PERFIN ';

    If pnlTipVen.Visible Then
      strSQL := strSQL + '  AND IFNULL(COM_TIPVEN, "") = :TIPVEN ';

    If (qryTabela.State = dsEdit) Then
    Begin
      strSQL := strSQL + '  AND COM_CODCOM <> :CODCOM ';
    End;

    With qryGenCom Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('VALOR').AsFloat := fltValor;

      If pnlTipVen.Visible Then
        ParamByName('TIPVEN').AsString := dtsCadCom.DataSet.FieldByName('COM_TIPVEN').AsString;

      If (qryTabela.State = dsEdit) Then
      Begin
        ParamByName('CODCOM').AsString := qryTabela.FieldByName('COM_CODCOM').AsString;
      End;

      Open;

      If Not IsEmpty Then
        Result := True;

      Close;
    End;

  Finally
    FreeAndNil(qryGenCom);
  End;

End;

end.

