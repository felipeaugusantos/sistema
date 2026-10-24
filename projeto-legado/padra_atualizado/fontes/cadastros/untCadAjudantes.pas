unit untCadAjudantes;

interface

uses
  Windows, Controls, Forms, untPaiCad, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  DBEditFocus, AppEvnts, DB, BitBtnLockedIncrem, Mask, DBCtrls, Menus, Classes, QColorLabel, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadAjudantes = class(TfrmPaiCad)
    pnlCentral: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    dbeNomAju: TDBEditFocus;
    dbeCodAju: TDBEditFocus;
    dtsCadAju: TDataSource;
    lbl1: TLabel;
    lbl2: TColorLabel;
    dbeStatus: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    procedure pPesquisa(strCodAjudante: String = '');
    function fSetaCodAjudanteInformado(strCodAjudante: String = ''): Boolean;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strCodAjudanteIniciarCadastro : String;
  end;


implementation

uses untPai, untFuncoesSimples, untConsultas, untTypesSistema, untPesqAux;

{$R *.dfm}

procedure TfrmCadAjudantes.FormCreate(Sender: TObject);
begin
  inherited;
  strCodAjudanteIniciarCadastro := '';

  strNomeTabela     := 'CADAJU';
  strNomeCampo      := 'AJU_CODAJU';
  qryTabela         := fCriarQuery('SELECT * FROM CADAJU', Self);
  dtsCadAju.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodAju;
end;

procedure TfrmCadAjudantes.FormShow(Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(strCodAjudanteIniciarCadastro) Then
    Self.pPesquisa(strCodAjudanteIniciarCadastro);
end;

procedure TfrmCadAjudantes.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    fRollBack;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadAjudantes.btnGravarClick(Sender: TObject);
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

procedure TfrmCadAjudantes.btnIncluirClick(Sender: TObject);
begin
  inherited;

  dbeStatus.Field.AsString := 'A';

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodAju, dbeNomAju, False)
  Else
    pHabilitaCodigo(dbeCodAju, dbeCodAju, True);

end;

procedure TfrmCadAjudantes.btnPesquisaClick(Sender: TObject);
begin
  Self.pPesquisa;
end;

procedure TfrmCadAjudantes.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodAju, dbeNomAju, False);
end;

function TfrmCadAjudantes.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = dbeCodAju) Then
  Begin

    If (fEmptyStr(dbeCodAju.Text)) And (dbeCodAju.Enabled) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Código do Ajudante deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (blnBuscaPorChave) Then
    Begin
      If Not fBuscaPorCamposChave Then
        pLimparCampos;
    End;

  End
  Else If (Sender = dbeNomAju) Then
  Begin

    If fEmptyStr(dbeNomAju.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Nome do Ajudante deve ser preenchido!', ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = dbeStatus) Then
  Begin

    If fEmptyStr(dbeStatus.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O campo Situação deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If ((dbeStatus.Text <> 'A') and (dbeStatus.Text <> 'I')) Then
    Begin
      fMensagem('ATENÇÃO!', 'O campo Situação deve ser preenchido com ''A'' ou ''I''!', ['&Ok']);
      Result := False;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCadAjudantes.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('AJU_CODAJU');
  stlCampos.Add('AJU_NOMAJU');
  stlCampos.Add('AJU_STATUS');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('AJU_NOMAJU');
  stlCamInd.Add('AJU_CODAJU');
  stlCamInd.Add('AJU_STATUS');

  stlDesInd.Add('Nome');
  stlDesInd.Add('Código');
  stlDesInd.Add('Situação');

end;

procedure TfrmCadAjudantes.pPesquisa(strCodAjudante: String = '');
Var
  chrKey: Char;
  arrAjud: TConsultasArray;
begin
  {*******************************}
  {* NOVA CONSULTA DE AJUDANTES  *}
  {****************************IV*}
  chrKey := '/';
  If fSetaCodAjudanteInformado(strCodAjudante) or
     fPesqAjudantes(Self, Nil, Nil, Nil, qryTabela, chrKey, arrAjud) Then
    pSetFocus(btnAlterar);
end;


function TfrmCadAjudantes.fSetaCodAjudanteInformado(strCodAjudante: String = ''): Boolean;
begin
  Result := False;
  If Not fEmptyStr(strCodAjudante) Then
  Begin
    pPesquisaCadAju(qryTabela, qryTabela, strCodAjudante);
    Result := True;
  End;
end;

end.


