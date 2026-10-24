{***************************}
{* qryConBco -> CADBCO     *}
{* qryConEmp -> CADEMP     *}
{************************JB*}
{***************************}
{* qryCadBco -> CADBCO     *}
{************************RV*}
unit untCorrigeCheque;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, EditFocus, ComCtrls, Buttons,
  ExtCtrls, Menus, Uni, AppEvnts,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCorrigeCheque = class(TfrmPaiSimples)
    Label1: TLabel;
    edtCodBco: TEditFocus;
    Label2: TLabel;
    edtNumAge: TEditFocus;
    Label3: TLabel;
    edtConCor: TEditFocus;
    Label4: TLabel;
    edtNumChq: TEditFocus;
    pnlConfirma: TPanel;
    edtNomBan: TEditFocus;
    pnlFundo: TPanel;
    Label5: TLabel;
    edtNomEmp: TEditFocus;
    edtCodEmp: TEditFocus;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    procedure edtCodBcoKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    qryConEmp: TUniQuery;
    qryConBco: TUniQuery;
    qryCadBco: TUniQuery;

    procedure pCarregaBanco;
    procedure pCarregaEmpresa;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  public
    { Public declarations }
    strCodBco: String;
    strNumAge: String;
    strConCor: String;
    strNumChq: String;
    strCodEmp: String;

    blnConfirma: Boolean;
  end;


implementation

uses untPesqAux,untFuncoesSimples, untTypesSistema, untConsultas;

{$R *.dfm}

procedure TfrmCorrigeCheque.edtCodBcoKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrBancos: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE BANCOS     *}
  {****************************RV*}
  If fPesqBanco(Self, edtCodBco, edtNomBan, qryTabela, Key, arrBancos) Then
  Begin
    if fValidaCampos(edtCodBco, True) then
      SelectNext(ActiveControl, True, True);
    pCarregaBanco;
  End;
end;

function TfrmCorrigeCheque.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA O CÓDIGO DO BANCO              *}
    {**************************************MV*}
    If (Sender = edtCodBco) Then
    Begin

      If Not fEmptyStr(edtCodBco.Text) Then
      Begin
        pCarregaBanco;
        If qryConBco.FieldByName('BCO_CODBCO').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Banco não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End
      Else
      Begin
        edtNomBan.Clear;
      End;

    End

    Else If (Sender = edtCodEmp) Then
    Begin

      If (Not fEmptyStr(edtCodEmp.Text)) Then
      Begin
        pCarregaEmpresa;
        If qryConEmp.FieldByName('EMP_CODEMP').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&O k']);
          Result := False;
        End
      End;

    End;

    {*****************************************}
    {* VALIDA O NÚMERO DO CHEQUE             *}
    {**************************************MV*}
{    Else If (Sender = edtNumChq) Then
    Begin
      strCodBco := edtCodBco.Text;
      strNumAge := edtNumAge.Text;
      strConCor := edtConCor.Text;
      strNumChq := edtNumChq.Text;
      blnConfirma := True;
      Close;
    End}

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCorrigeCheque.pCarregaBanco;
begin
  pPesquisaCadBco(qryCadBco, qryConBco, edtCodBco.Text);
  edtNomBan.Text := qryConBco.FieldByName('BCO_NOMBCO').AsString;
end;

procedure TfrmCorrigeCheque.pInicializaIndices;
begin
  inherited;
  qryConBco := qryCadBco;
  qryConEmp := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE', Self);;
end;

procedure TfrmCorrigeCheque.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryCadBco);
end;

procedure TfrmCorrigeCheque.FormCreate(Sender: TObject);
begin
  qryCadBco := fCriaQuery(Self);
  inherited;
end;

procedure TfrmCorrigeCheque.FormShow(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
  pInicializaIndices;
end;

procedure TfrmCorrigeCheque.btnCancelaClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCorrigeCheque.btnConfirmaDadosClick(Sender: TObject);
begin
  If fVerificaCampos Then
  Begin
    strCodBco := edtCodBco.Text;
    strNumAge := edtNumAge.Text;
    strConCor := edtConCor.Text;
    strNumChq := edtNumChq.Text;
    strCodEmp := edtCodEmp.Text;
    blnConfirma := True;
    Close;
  End;
end;

procedure TfrmCorrigeCheque.pCarregaEmpresa;
begin
  pPesquisaCadEmp(qryConEmp, qryConEmp, edtCodEmp.Text);
  With qryConEmp Do
  Begin
    edtNomEmp.Text := FieldByName('EMP_NOMEMP').AsString;
  End;
end;

procedure TfrmCorrigeCheque.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

end.

