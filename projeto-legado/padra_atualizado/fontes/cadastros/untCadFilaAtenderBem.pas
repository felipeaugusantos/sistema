unit untCadFilaAtenderBem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, Data.DB, Vcl.Mask,
  Vcl.DBCtrls, DBEditFocus, EditFocus, Uni;

type
  TfrmCadFilaAtenderBem = class(TfrmPaiCad)
    dtsCadFila: TDataSource;
    lblID: TLabel;
    dbeIDFila: TDBEditFocus;
    lblFila: TLabel;
    dbeDesFil: TDBEditFocus;
    lblKey: TLabel;
    dbeKeyApi: TDBEditFocus;
    chkFilPri: TDBCheckBox;
    lblCodEmp: TLabel;
    edtNomEmp: TEditFocus;
    dbeCodEmp: TDBEditFocus;
    chkFilaApiOficial: TDBCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure dbeCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelaClick(Sender: TObject);
  private
    { Private declarations }
    function fIdFilaAtenderBemJaExiste: Boolean;
    function fJaExisteFilaPrincipal: Boolean;
    function fValidarExclusao: Boolean;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples, untTypesSistema, untConsultas;

{$R *.dfm}

procedure TfrmCadFilaAtenderBem.btnAlterarClick(Sender: TObject);
begin
  inherited;
  fValidaCampos(dbeCodEmp, True);
  pSetFocus(dbeIDFila);
end;

procedure TfrmCadFilaAtenderBem.btnCancelaClick(Sender: TObject);
begin
  inherited;
  if fEmptyStr(dbeCodEmp.Text) then
    edtNomEmp.Clear;
end;

function TfrmCadFilaAtenderBem.fValidarExclusao: Boolean;
var
  qryAux: TUniQuery;
begin
  Result := True;

  qryAux := fCriaQuery;
  try
    qryAux.Close;
    qryAux.SQL.Text :=
    ' SELECT '+
    '   GROUP_CONCAT(DISTINCT OPE_CODOPE) AS OPE_CODOPE, '+
    '   GROUP_CONCAT(DISTINCT SIS_CODEMP) AS SIS_CODEMP '+
    ' FROM '+
    '   CADOPE '+
    ' INNER JOIN CFGSIS '+
    '    ON SIS_CODCFG = "CFG_GATOPE" '+
    '   AND SIS_VALCFG = OPE_CODOPE '+
    ' WHERE '+
    '   OPE_SEQFIL = :AUTINC ';
    qryAux.ParamByName('AUTINC').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
    qryAux.Open;

    if (not qryAux.IsEmpty) and (not fEmptyStr(qryAux.FieldByName('OPE_CODOPE').AsString)) then
    begin
      pMensagemOk('Não é possível excluir esta fila, pois ela é utilizada pelo(s) operadore(s) ('+qryAux.FieldByName('OPE_CODOPE').AsString+') para o envio dos '+
                  'Gatilhos de Informação nas empresas ('+qryAux.FieldByName('SIS_CODEMP').AsString+'). Altere primeiro a configuração CFG_GATOPE.');

      Result := False;
    end;
  finally
    FreeAndNil(qryAux);
  end;
end;

procedure TfrmCadFilaAtenderBem.btnExcluirClick(Sender: TObject);
begin
  If not fValidarExclusao Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadFilaAtenderBem.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

end;

procedure TfrmCadFilaAtenderBem.btnGravarClick(Sender: TObject);
begin
  blnGravou := False;

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;

    if blnGravou then
      fCommit;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pnlInfo.Caption := '';
      pMensagensErro(E.Message, '[untCadFilaAtenderBem.btnGravarClick]');
    End;
  End;

end;

procedure TfrmCadFilaAtenderBem.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  pHabilitaCodigo(dbeIDFila, dbeIDFila, True);
  fValidaCampos(dbeCodEmp, True);
end;

procedure TfrmCadFilaAtenderBem.btnPesquisaClick(Sender: TObject);
Var
  chrKey: Char;
  arrFila: TConsultasArray;
begin
  inherited;

  chrKey := '/';
  If fPesqFilaWpp(Self, Nil, Nil, qryTabela, chrKey, arrFila) Then
  Begin
    fValidaCampos(dbeCodEmp, True);
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadFilaAtenderBem.dbeCodEmpKeyPress(Sender: TObject;
  var Key: Char);
var
  arrEmpres: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, dbeCodEmp, edtNomEmp, Nil, Key, arrEmpres, True, True) Then
    fValidaCampos(dbeCodEmp, True);
end;

procedure TfrmCadFilaAtenderBem.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(btnIncluir);
end;

procedure TfrmCadFilaAtenderBem.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela         := 'CADFIL';
  strNomeCampo          := 'FIL_IDFILA';

  qryTabela             := fCriaQuery(Self);
  dtsCadFila.DataSet    := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0]     := dbeIDFila;
end;

function TfrmCadFilaAtenderBem.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
   Result := True;

  If (inherited fValidaCampos(Sender,blnBuscaPorChave)) Then
  Begin

    If (Sender = dbeIDFila) Then
    Begin
      If fEmptyStr(dbeIDFila.Text) or (Trim(dbeIDFila.Text) = '0') Then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo ID deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      If (qryTabela.State = dsEdit) and
         (fIdFilaAtenderBemJaExiste) Then
      begin
        fMensagem('ATENÇÃO!', 'Já existe um cadastro de fila com o ID informado!', ['&Ok']);
        Result := False;
      End;
    End
    Else
    If (Sender = dbeDesFil) Then
    Begin
      If fEmptyStr(dbeDesFil.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo Fila deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End
    Else
    If (Sender = dbeKeyApi) Then
    Begin
      If fEmptyStr(dbeKeyApi.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo apiKey deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = dbeCodEmp) Then
    Begin
      edtNomEmp.Clear;

      if (fEmptyStr(dbeCodEmp.Text)) and ((qryTabela.State = dsEdit) Or (qryTabela.State = dsInsert))  then
        dbeCodEmp.Field.Value := VS_strCodEmp;

      edtNomEmp.Text := fRetNomeEmpresa(dbeCodEmp.Text);
      if fEmptyStr(dbeCodEmp.Text) then
      begin
        dbeCodEmp.Clear;
        fMensagem('ATENÇÃO!', 'Empresa não cadastrada!', ['&Ok']);
        Result := False;
      end;
    End
    Else If (Sender = chkFilPri) Then
    Begin
      if (chkFilPri.Checked) and (fJaExisteFilaPrincipal) then
      begin
        fMensagem('ATENÇÃO!', 'A empresa '+dbeCodEmp.Text+' já possui uma fila principal para envio de mensagens!', ['&Ok']);
        Result := False;
      end;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCadFilaAtenderBem.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('FIL_IDFILA');
  stlCampos.Add('FIL_DESFIL');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('FIL_DESFIL');
  stlCamInd.Add('FIL_IDFILA');

  stlDesInd.Add('Fila');
  stlDesInd.Add('ID');
end;

function TfrmCadFilaAtenderBem.fIdFilaAtenderBemJaExiste: Boolean;
var
  qryCadFil: TUniQuery;
begin
  qryCadFil := fCriaQuery(Self);
  try
    qryCadFil.Close;
    qryCadFil.SQL.Text :=
    ' SELECT '+
    '   AUTOINCREM '+
    ' FROM '+
    '   CADFIL '+
    ' WHERE '+
    '   AUTOINCREM <> :AUTINC AND '+
    '   FIL_IDFILA = :IDFIL ';

    qryCadFil.ParamByName('AUTINC').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
    qryCadFil.ParamByName('IDFIL').AsString := dbeIDFila.Text;
    qryCadFil.Open;

    Result := (not qryCadFil.IsEmpty);
  finally
    FreeAndNil(qryCadFil);
  end;
end;

function TfrmCadFilaAtenderBem.fJaExisteFilaPrincipal: Boolean;
var
  qryCadFil: TUniQuery;
begin
  qryCadFil := fCriaQuery(Self);
  try
    qryCadFil.Close;
    qryCadFil.SQL.Text :=
    ' SELECT '+
    '   AUTOINCREM '+
    ' FROM '+
    '   CADFIL '+
    ' WHERE '+
    IIF(not fEmptyStr(qryTabela.FieldByName('AUTOINCREM').AsString), '   AUTOINCREM <> :AUTINC AND ', '')+
    '   FIL_CODEMP = :CODEMP AND '+
    '   FIL_FILPRI = "S" ';

    if not fEmptyStr(qryTabela.FieldByName('AUTOINCREM').AsString) then
      qryCadFil.ParamByName('AUTINC').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
    qryCadFil.ParamByName('CODEMP').AsString := dbeCodEmp.Text;
    qryCadFil.Open;

    Result := (not qryCadFil.IsEmpty);
  finally
    FreeAndNil(qryCadFil);
  end;
end;

end.
