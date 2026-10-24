Unit untCadLayoutXMLNFSe;

interface

uses
  Windows, Controls, Forms, untPaiCad, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  DBEditFocus, AppEvnts, DB, BitBtnLockedIncrem, Mask, DBCtrls, Menus, Classes, QColorLabel, frxClass, frxExportCSVTestabilidade,
  DBComboBoxFocus, DBLookupComboBoxFocus,UniClientDataSet;

type
  TfrmCadLayoutXMLNFSe = class(TfrmPaiCad)
    pnlCentral: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    dbeDesCam: TDBEditFocus;
    dbeCodLay: TDBEditFocus;
    dtsLayCfs: TDataSource;
    Label3: TLabel;
    dbeDesCfs: TDBEditFocus;
    Label4: TLabel;
    Label5: TLabel;
    cbxSimNao: TDBLookupComboBoxFocus;
    cbxTipoCampo: TDBLookupComboBoxFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    FcdsSimNao: TUniClientDataSet;
    FdsSimNao: TDataSource;
    FcdsTipoCampo: TUniClientDataSet;
    FdsTipoCampo: TDataSource;
    procedure pPesquisa(strCodAjudante: String = '');
    function fSetaCodInformado(strCodigo: String = ''): Boolean;
    procedure pConfigurarCampos;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strCodLay : String;
  end;


implementation

uses untPai, untFuncoesSimples, untConsultas, untTypesSistema, untPesqAux;

{$R *.dfm}

procedure TfrmCadLayoutXMLNFSe.FormCreate(Sender: TObject);
begin
  inherited;
  strCodLay := '';

  strNomeTabela     := 'LAYCFS';
  strNomeCampo      := 'LAY_CODLAY';
  qryTabela         := fCriarQuery('SELECT * FROM LAYCFS', Self);
  dtsLayCfs.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodLay;
  pConfigurarCampos;
End;

procedure TfrmCadLayoutXMLNFSe.pConfigurarCampos;
Begin
  FcdsSimNao := TUniClientDataSet.Create(Self);
  FcdsSimNao.FieldDefs.Add('CODIGO', TFieldType.ftString, 1);
  FcdsSimNao.FieldDefs.Add('DESCRICAO', TFieldType.ftString, 3);
  FcdsSimNao.CreateDataSet;
  FcdsSimNao.InsertRecord(['S','SIM']);
  FcdsSimNao.InsertRecord(['N','NÃO']);
  FdsSimNao := TDataSource.Create(Self);
  FdsSimNao.DataSet := FcdsSimNao;
  cbxSimNao.ListSource := FdsSimNao;

  FcdsTipoCampo := TUniClientDataSet.Create(Self);
  FcdsTipoCampo.FieldDefs.Add('CODIGO', TFieldType.ftString, 1);
  FcdsTipoCampo.FieldDefs.Add('DESCRICAO', TFieldType.ftString, 10);
  FcdsTipoCampo.CreateDataSet;
  FcdsTipoCampo.InsertRecord(['N','NUMERO']);
  FcdsTipoCampo.InsertRecord(['S','TEXTO']);
  FcdsTipoCampo.InsertRecord(['D','DATA']);
  FcdsTipoCampo.InsertRecord(['B','BOLEANO']);
  FdsTipoCampo := TDataSource.Create(Self);
  FdsTipoCampo.DataSet := FcdsTipoCampo;
  cbxTipoCampo.ListSource := FdsTipoCampo;
End;


procedure TfrmCadLayoutXMLNFSe.FormShow(Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(strCodLay) Then
    Self.pPesquisa(strCodLay);
end;

procedure TfrmCadLayoutXMLNFSe.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    fRollBack;
  End;

end;

procedure TfrmCadLayoutXMLNFSe.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    fRollBack;
  End;

  If blnGravou Then
    fCommit
  Else
  Begin
    fRollBack;
    pnlInfo.Caption := '';
  End;
end;

procedure TfrmCadLayoutXMLNFSe.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodLay, dbeDesCam, False)
  Else
    pHabilitaCodigo(dbeCodLay, dbeCodLay, True);

end;

procedure TfrmCadLayoutXMLNFSe.btnPesquisaClick(Sender: TObject);
begin
  Self.pPesquisa;
end;

procedure TfrmCadLayoutXMLNFSe.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodLay, dbeDesCam, False);
end;

function TfrmCadLayoutXMLNFSe.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = dbeCodLay) Then
  Begin

    If (fEmptyStr(dbeCodLay.Text)) And (dbeCodLay.Enabled) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Código do campo deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (blnBuscaPorChave) Then
    Begin
      If Not fBuscaPorCamposChave Then
        pLimparCampos;
    End;

  End
  Else If (Sender = dbeDesCam) Then
  Begin

    If fEmptyStr(dbeDesCam.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A descrição deve ser preenchido!', ['&Ok']);
      Result := False;
    End;
  End
  Else If (Sender = dbeDesCam) Then
  Begin
    If fEmptyStr(dbeDesCfs.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A descrição do campo Cad. Fis. deve ser preenchido!', ['&Ok']);
      Result := False;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCadLayoutXMLNFSe.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('LAY_DESCFS');
  stlCampos.Add('LAY_DESCAM');
  stlCampos.Add('LAY_CODLAY');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('LAY_DESCAM');
  stlCamInd.Add('LAY_CODLAY');
  stlCamInd.Add('LAY_DESCFS');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
  stlDesInd.Add('Campo Cad. Fis.');
end;

procedure TfrmCadLayoutXMLNFSe.pPesquisa(strCodAjudante: String = '');
Var
  chrKey: Char;
  arrCons: TConsultasArray;
begin
  {*******************************}
  {* NOVA CONSULTA               *}
  {****************************IV*}
  chrKey := '/';
  If fSetaCodInformado(strCodAjudante) or
     fPesqLayoutCadFis(Self, Nil, Nil, qryTabela, chrKey, arrCons) Then
    pSetFocus(btnAlterar);
end;


function TfrmCadLayoutXMLNFSe.fSetaCodInformado(strCodigo: String = ''): Boolean;
begin
  Result := False;
  If Not fEmptyStr(strCodigo) Then
  Begin
    pPesquisaLayCfs(qryTabela, qryTabela, strCodigo);
    Result := True;
  End;
end;

end.


