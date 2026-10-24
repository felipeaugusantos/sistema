unit untImportaPAFECFCheques;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, frxClass, frxExportCSVTestabilidade, AppEvnts, Menus,
  StdCtrls, Buttons, BitBtnLockedIncrem, ExtCtrls, EditFocus, Mask, DBCtrls,
  DBEditFocus, Uni, DB, untTypesSistema;

type
  TfrmImportaPAFECFCheques = class(TfrmPai)
    pnlCentral: TPanel;
    Label1: TLabel;
    dbeCodBco: TDBEditFocus;
    edtNomBan: TEditFocus;
    Label2: TLabel;
    dbeNumAge: TDBEditFocus;
    Label3: TLabel;
    dbeConCor: TDBEditFocus;
    Label4: TLabel;
    dbeNumChq: TDBEditFocus;
    btnGravar: TBitBtnLocked;
    dtsCheques: TDataSource;
    Label5: TLabel;
    dbeValor: TDBEditFocus;
    Label6: TLabel;
    dbeDtaVen: TDBEditFocus;
    procedure dbeCodBcoKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
    qryCheque: TUniQuery;
    procedure pCarregaBanco;
    function fExisteCheque(strCodBco, strNumAge, strConCor,
      strNumChq: String): Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strIdLoc: String;
    strIdDoc: String;
    strCodBco: String;
    strNumAge: String;
    strConCor: String;
    strNumChq: String;
  end;

var
  frmImportaPAFECFCheques: TfrmImportaPAFECFCheques;

implementation

uses untConsultas, untFuncoesSimples;

{$R *.dfm}

procedure TfrmImportaPAFECFCheques.btnGravarClick(Sender: TObject);
begin
  inherited;
  If fVerificaCampos Then
  Begin
    qryCheque.FieldByName('CHQ_DUPLIC').AsInteger := 0;
    qryCheque.Post;
    ModalResult := mrOk;
  End;
end;

procedure TfrmImportaPAFECFCheques.dbeCodBcoKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrBancos: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE BANCOS     *}
  {****************************RV*}
  If fPesqBanco(Self, dbeCodBco, edtNomBan, Nil, Key, arrBancos) Then
  Begin
    if fValidaCampos(dbeCodBco, True) then
      SelectNext(ActiveControl, True, True);
    pCarregaBanco;
  End;
end;

function TfrmImportaPAFECFCheques.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  {*****************************************}
  {* VALIDA O CÓIDIGO DO BANCO             *}
  {**************************************MV*}
  If (Sender = dbeCodBco) Then
  Begin

    If fEmptyStr(dbeCodBco.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Código do Banco deve ser preenchido!', ['&O k']);
      Result := False;
    End
    Else
    Begin
      pCarregaBanco;
      If fEmptyStr(edtNomBan.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse Banco não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;

  End

  {*****************************************}
  {* VALIDA A AGENCIA                      *}
  {**************************************MV*}
  Else If (Sender = dbeNumAge) Then
  Begin
    If fEmptyStr(dbeNumAge.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Agencia deve ser preenchida!', ['&O k']);
      Result := False;
    End
  End

  {*****************************************}
  {* VALIDA  A CONTA CORRENTE              *}
  {**************************************MV*}
  Else If (Sender = dbeConCor) Then
  Begin

    If fEmptyStr(dbeConCor.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Conta Corrente deve ser preenchida!', ['&O k']);
      Result := False;
    End;

  End

  {*****************************************}
  {* VALIDA O NÚMERO DO CHEQUE             *}
  {**************************************MV*}
  Else If (Sender = dbeNumChq) Then
  Begin
    If fEmptyStr(dbeNumChq.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Número do Cheque deve ser preenchido!', ['&O k']);
      Result := False;
    End
    Else If (fExisteCheque(dbeCodBco.Text,dbeNumAge.Text,dbeConCor.Text,dbeNumChq.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Cheque digitado já existe no cadastro!', ['&O k']);
      Result := False;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmImportaPAFECFCheques.pCarregaBanco;
begin
  edtNomBan.Text := fRetNomeBancoSelec(dbeCodBco.Text);
end;

function TfrmImportaPAFECFCheques.fExisteCheque(strCodBco, strNumAge, strConCor, strNumChq: String): Boolean;
  Var
    strSQL   : String;
    qryGenChq: TUniQuery;
begin
  Try

    Result := False;

    qryGenChq := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COUNT(*) AS QTD ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + ' CADCHQ ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CHQ_CODBCO = :CODBCO AND ';
    strSQL := strSQL + '  CHQ_NUMAGE = :NUMAGE AND ';
    strSQL := strSQL + '  CHQ_CONCOR = :CONCOR AND ';
    strSQL := strSQL + '  CHQ_NUMCHQ = :NUMCHQ     ';

    With qryGenChq Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODBCO').AsString := strCodBco;
      ParamByName('NUMAGE').AsString := strNumAge;
      ParamByName('CONCOR').AsString := strConCor;
      ParamByName('NUMCHQ').AsString := strNumChq;
      Open;
      If FieldByName('QTD').AsInteger > 0 Then
        Result := True;
      Close;
    End;

  Finally
    FreeAndNil(qryGenChq);
  End;
end;

procedure TfrmImportaPAFECFCheques.FormCreate(Sender: TObject);
begin
  inherited;
  qryCheque := fCriaQuery(Nil);
  dtsCheques.DataSet := qryCheque;
end;

procedure TfrmImportaPAFECFCheques.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryCheque);
  inherited;
end;

procedure TfrmImportaPAFECFCheques.FormShow(Sender: TObject);
begin
  inherited;
  qryCheque.SQL.Add('SELECT * FROM PAF_CHEQUES WHERE ');
  qryCheque.SQL.Add('  CHQ_ID_LOC = :ID_LOC AND ');
  qryCheque.SQL.Add('  CHQ_ID_DOC = :ID_DOC AND ');
  qryCheque.SQL.Add('  CHQ_CODBCO = :CODBCO AND ');
  qryCheque.SQL.Add('  CHQ_NUMAGE = :NUMAGE AND ');
  qryCheque.SQL.Add('  CHQ_CONCOR = :CONCOR AND ');
  qryCheque.SQL.Add('  CHQ_NUMCHQ = :NUMCHQ ');

  qryCheque.ParamByName('ID_LOC').AsString := strIdLoc;
  qryCheque.ParamByName('ID_DOC').AsString := strIdDoc;
  qryCheque.ParamByName('CODBCO').AsString := strCodBco;
  qryCheque.ParamByName('NUMAGE').AsString := strNumAge;
  qryCheque.ParamByName('CONCOR').AsString := strConCor;
  qryCheque.ParamByName('NUMCHQ').AsString := strNumChq;
  qryCheque.Open;

  TDateTimeField(qryCheque.FieldByName('CHQ_DTAVEN')).DisplayFormat := 'dd/mm/yyyy';
  TFloatField(qryCheque.FieldByName('CHQ_VALCHQ')).DisplayFormat := '#,##0.00';

  qryCheque.Edit;

  pSetFocus(dbeCodBco);
end;

end.
