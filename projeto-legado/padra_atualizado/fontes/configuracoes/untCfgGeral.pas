{***********************}
{* qryConEmp -> CADEMP *}
{********************JB*}

unit untCfgGeral;

interface

uses
  Windows, Classes, Controls, untPai, Menus, StdCtrls, Buttons, ExtCtrls,
  EditFocus, DBCtrls, AppEvnts, Uni, BitBtnLockedIncrem;

type
  TfrmCfgGeral = class(TfrmPai)
    pnlCentral: TPanel;
    Label1: TLabel;
    edtNomFan: TEditFocus;
    edtCodEmp: TEditFocus;
    btnGravar: TBitBtnLocked;
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    qryConEmp: TUniQuery;

    procedure pCarregaEmpresa(intOpcao: Integer);
    procedure pGravaArqIni;
    procedure pCarregaArqIni;
    procedure pAtualizaVariaveisGlobais;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  public
    { Public declarations }

  end;

var
  frmCfgGeral: TfrmCfgGeral;

implementation

uses SysUtils, Forms, untFuncoes, untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCfgGeral.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel : TConsultasArray;

begin
  inherited;

  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomFan, nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmCfgGeral.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  {*****************************************}
  {* VALIDA O CÓDIGO DA EMPRESA            *}
  {**************************************MV*}
  If (Sender = edtCodEmp) Then
  Begin
    If Not fEmptyStr(edtCodEmp.Text) Then
    Begin
      pCarregaEmpresa(1);
      If qryConEmp.FieldByName('EMP_NOMEMP').IsNull Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
        Result := False;
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCfgGeral.pCarregaEmpresa(intOpcao: Integer);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADEMP ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

  With qryConEmp Do
  Begin
    Close;
    SQl.Clear;
    SQl.Add(strSQL);
    If (intOpcao = 1) Then
      ParamByName('CODEMP').AsString := edtCodEmp.Text;

    Open;
  End;

  If (intOpcao = 1) Then
    edtNomFan.Text := qryConEmp.FieldByName('EMP_NOMEMP').AsString;

end;

procedure TfrmCfgGeral.pGravaArqIni;
begin
  fArqIni(1, 'GERAL', 'CODEMP', edtCodEmp.Text);

  If FileExists(ExtractFilePath(Application.ExeName) + '\auttin\opcoes.ini') Then
  Begin
    fArqIniTinta(1, 'GERAL', 'CODEMP', edtCodEmp.Text);
  End;

  If FileExists(ExtractFilePath(Application.ExeName) + '\autban\opcoes.ini') Then
  Begin
    fArqIniGeral(1, 'GERAL', 'CODEMP', edtCodEmp.Text, ExtractFilePath(Application.ExeName) + '\autban\');
  End;

end;

procedure TfrmCfgGeral.pCarregaArqIni;
begin
  edtCodEmp.Text := fArqIni(0, 'GERAL', 'CODEMP', '');

end;

procedure TfrmCfgGeral.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaArqIni;
  pCarregaEmpresa(1);

end;

procedure TfrmCfgGeral.pAtualizaVariaveisGlobais;
begin
  VS_strCodEmp := edtCodEmp.Text;

end;

procedure TfrmCfgGeral.btnGravarClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) And (fMensagem('', 'Confirma alterações?', ['&Sim', '&Não']) = 1) Then
  Begin
    pGravaArqIni;
    pAtualizaVariaveisGlobais;
    Close;
    ModalResult := mrOk;
  End;

end;
procedure TfrmCfgGeral.FormCreate(Sender: TObject);
begin
  inherited;
  qryConEmp := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE', Self);

end;

initialization
  RegisterClass(TfrmCfgGeral);
finalization
  UnRegisterClass(TfrmCfgGeral);

end.

