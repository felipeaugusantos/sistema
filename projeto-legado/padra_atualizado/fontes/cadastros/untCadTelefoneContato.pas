{******************************}
{* qryTelCon -> TELCON        *}
{* qryCadCid -> CADCID        *}
{***************************RV*}
unit untCadTelefoneContato;

interface

uses
  Windows, Classes, Controls, Forms, untPaiCad, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, DBCtrls, DBEditFocus, EditFocus, Uni, DBMemoFocus, AppEvnts, DB,
  BitBtnLockedIncrem, Mask, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadTelefoneContato = class(TfrmPaiCad)
    pnlFundo: TPanel;
    Label3: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    dbeEndere: TDBEditFocus;
    dbeNomCon: TDBEditFocus;
    dbeCodTel: TDBEditFocus;
    Label4: TLabel;
    dbeBairro: TDBEditFocus;
    Label7: TLabel;
    dbeCodCid: TDBEditFocus;
    edtNomCid: TEditFocus;
    Label8: TLabel;
    edtEstado: TEditFocus;
    Label9: TLabel;
    dbeNumCep: TDBEditFocus;
    Label14: TLabel;
    dbeFone01: TDBEditFocus;
    dbeNumFax: TDBEditFocus;
    Label18: TLabel;
    dbeEmail: TDBEditFocus;
    Label24: TLabel;
    Label5: TLabel;
    dbeObserv: TDBMemoFocus;
    dtsTelCon: TDataSource;
    dbeContat: TDBEditFocus;
    Label6: TLabel;
    procedure dbeCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeObservKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
  private
    { Private declarations }
    qryConCid: TUniQuery;
    qryTelCon: TUniQuery;
    qryCadCid: TUniQuery;

    procedure pCarregaCidade(qryConsulta: TUniQuery; edtCidade, edtEstado: TEdit;
      dbeCidade, dbeCep: TDBEditFocus);
    procedure pQueryTelConAfterOpen(DataSet: TDataSet);
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses SysUtils, untFuncoesSimples, untFuncoesGenerica, untPesqAux, untConsultas,
  untTypesSistema;

{$R *.dfm}

procedure TfrmCadTelefoneContato.dbeCodCidKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCidade: TConsultasArray;
begin
  inherited;
  {****************************}
  {* NOVA CONSULTA DE CIDADES *}
  {*************************RV*}
  If fPesqCidade(Self, dbeCodCid, edtNomCid, edtEstado, Nil, Key, arrCidade) Then
  Begin
    If fValidaCampos(dbeCodCid, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadTelefoneContato.pCarregaCidade(qryConsulta: TUniQuery; edtCidade,
  edtEstado: TEdit; dbeCidade, dbeCep: TDBEditFocus);
begin
  pPesquisaCadCid(qryCadCid, qryConsulta, dbeCidade.Text);
  With qryConsulta Do
  Begin
    edtCidade.Text := FieldByName('CID_NOMCID').AsString;
    edtEstado.Text := FieldByName('CID_ESTADO').AsString;
    If (dbeCep.Field <> Nil) And (dbeCep.Field.IsNull) Then
      dbeCep.Text   := FieldByName('CID_C_E_P_').AsString;
  End;
end;

procedure TfrmCadTelefoneContato.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodTel, dbeNomCon, False)
  Else
    pHabilitaCodigo(dbeCodTel, dbeCodTel, True);

  edtNomCid.Clear;
  edtEstado.Clear;
end;

procedure TfrmCadTelefoneContato.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodTel, dbeNomCon, False)
end;

procedure TfrmCadTelefoneContato.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If (Action <> caNone) Then
  Begin
    FreeAndNil(qryTelCon);
    FreeAndNil(qryCadCid);
  End;
end;

procedure TfrmCadTelefoneContato.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela       := 'TELCON';
  strNomeCampo        := 'TEL_CODTEL';

  qryTelCon           := fCriaQuery(Self);
  qryTabela           := qryTelCon;
  dtsTelCon.DataSet   := qryTabela;
  qryTelCon.AfterOpen := pQueryTelConAfterOpen;

  qryConCid           := fCriaQuery(Self);
  qryCadCid           := fCriaQuery(Self);
  qryConCid           := qryCadCid;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0]   := dbeCodTel;
end;

procedure TfrmCadTelefoneContato.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('TEL_NOMCON');
  stlCampos.Add('TEL_FONE01');
  stlCampos.Add('TEL_F_A_X_');
  stlCampos.Add('TEL_E_MAIL');
  stlCampos.Add('TEL_CONTAT');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('TEL_NOMCON');
  stlCamInd.Add('TEL_FONE01');
  stlCamInd.Add('TEL_F_A_X_');
  stlCamInd.Add('TEL_E_MAIL');
  stlCamInd.Add('TEL_CONTAT');

  stlDesInd.Add('Nome');
  stlDesInd.Add('Telefone');
  stlDesInd.Add('Fax');
  stlDesInd.Add('E-mail');
  stlDesInd.Add('Contato');
end;

procedure TfrmCadTelefoneContato.pQueryTelConAfterOpen(DataSet: TDataSet);
begin
  With DataSet Do
  Begin
    TStringField(FieldByName('TEL_C_E_P_')).EditMask := '99999-999;0;_';
    TStringField(FieldByName('TEL_FONE01')).EditMask := fRetMascaraFonePais;
    TStringField(FieldByName('TEL_F_A_X_')).EditMask := fRetMascaraFonePais;
  End;
end;

function TfrmCadTelefoneContato.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA O NOME DO CONTATO              *}
    {**************************************LU*}
    If (Sender = dbeNomCon) Then
    Begin
      If fEmptyStr(dbeNomCon.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Nome do Contato deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End

    {*********************}
    {* VALIDA TELEFONES  *}
    {******************MM*}
    Else If (Sender = dbeFone01) Or (Sender = dbeNumFax) Then
    Begin
      If (Not fEmptyStr(TDBEditFocus(Sender).Text)) And
         (Not fValidaTelefone(TDBEditFocus(Sender).Text)) Then
      Begin
        fMensagem('','Informe o telefone corretamente!', ['&Ok']);
        Result := False;
      End
      Else
        TDBEditFocus(Sender).Text := fAcertaMaskTel(TDBEditFocus(Sender).Text);
    End

    Else If (Sender = dbeCodCid) Then
    Begin
      If fEmptyStr(dbeCodCid.Text) Then
      Begin
        qryTabela.FieldByName('TEL_CODCID').Clear;
        edtNomCid.Clear;
        edtEstado.Clear;
      End
      Else
      Begin
        pCarregaCidade(qryConCid, edtNomCid, edtEstado, dbeCodCid, dbeNumCep);
        If fEmptyStr(edtNomCid.Text) Then
        Begin
          Result := False;
          fMensagem('ATENÇÃO!', 'Cidade não econtrada!', ['&Ok']);
        End;

      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;


procedure TfrmCadTelefoneContato.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrFone: TConsultasArray;
begin
  {*******************************}
  {* NOVA CONSULTA DE ATIVIDADES *}
  {****************************RV*}
  chrKey := '/';
  If fPesqAgendaTelef(Self, Nil, Nil, qryTabela, chrKey, arrFone) Then
  Begin
    pCarregaCidade(qryConCid, edtNomCid, edtEstado, dbeCodCid, dbeNumCep);
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadTelefoneContato.btnCancelaClick(Sender: TObject);
begin
  inherited;
  If qryTabela.IsEmpty then
  Begin
    edtNomCid.Clear;
    edtEstado.Clear;
  End
  Else
    pCarregaCidade(qryConCid, edtNomCid, edtEstado, dbeCodCid, dbeNumCep);
end;

procedure TfrmCadTelefoneContato.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadTelefoneContato.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  If qryTabela.IsEmpty then
  Begin
    edtNomCid.Clear;
    edtEstado.Clear;
  End
  Else
    pCarregaCidade(qryConCid, edtNomCid, edtEstado, dbeCodCid, dbeNumCep);
end;

procedure TfrmCadTelefoneContato.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[untCadTelefoneContato.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

end;

procedure TfrmCadTelefoneContato.dbeObservKeyPress(Sender: TObject;
  var Key: Char);
  Var
    strKey : String;
begin
  inherited;
  strKey := Key;
  strKey := AnsiUpperCase(strKey);
  Key    := strKey[1];
end;

end.

