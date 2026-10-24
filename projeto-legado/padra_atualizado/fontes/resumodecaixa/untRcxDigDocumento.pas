unit untRcxDigDocumento;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls,
  EditFocus, Menus, Uni, AppEvnts, cxHint, Windows, BitBtnLockedIncrem,
  dxScreenTip, cxClasses, dxCustomHint, frxClass, frxExportCSVTestabilidade;

type
  TfrmRcxDigDocumento = class(TfrmPaiSimples)
    pnlConfirma: TPanel;
    pnlDados: TPanel;
    Label1: TLabel;
    edtNumDoc: TEditFocus;
    edtEspDoc: TEditFocus;
    edtCodEmp: TEditFocus;
    lblEmpresa: TLabel;
    edtDesEmp: TEditFocus;
    Label2: TLabel;
    btnDocsAviOriLoj: TSpeedButton;
    HintControler: TcxHintStyleController;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    lblNumCoo: TLabel;
    edtNumCoo: TEditFocus;
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure btnDocsAviOriLojClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
  private
    { Private declarations }
    function fConsultaCoo(Var strNumIf: String): Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strOpcDoc: String;
    strAutInc: String;
    blnDocsAVistaOrigLoja: Boolean;
  end;

var
  frmRcxDigDocumento: TfrmRcxDigDocumento;

implementation

uses untFuncoesSimples, untConsultas, untTypesSistema, untRcxCuponsConfirmacao;

{$R *.dfm}

function TfrmRcxDigDocumento.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strNumDocIf: String;
begin

  Result    := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodEmp) Then
    Begin

      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        fMensagem('AVISO','Informe  o código da empresa.', ['&O K']);
        Result := FALSE;
      End Else
      Begin
        edtDesEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);

        If fEmptyStr(edtDesEmp.Text) Then
        Begin
          fMensagem('AVISO','Código da empresa não encontrado.', ['&O K']);
          Result := FALSE;
        End

        Else If (fCfgSis('CFFMAT', varBoolean)) And (edtCodEmp.Text <> VS_strCodEmp) Then
        Begin
          If (Not fEmptyStr(fCfgSis('EMPCNF'))) And (Pos(edtCodEmp.Text, fCfgSis('EMPCNF')) <= 0) Then
          Begin
            fMensagem('','Empresa não possui permissão para confirmar documentos da Empresa '+ edtCodEmp.Text +'!'+ sLineBreak +
                         'Verifique a configuração [CFG_EMPCNF].', ['&Ok']);
            Result := FALSE;
          End;
        End;
      End;
      
    End

    Else If (Sender = edtNumDoc) Then
    Begin
      if (fEmptyStr(edtNumDoc.Text)) And (Not edtNumCoo.Visible) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe o Número do Documento!', ['&Ok']);
        Result := FALSE;
      End;

      If (edtNumCoo.Visible) Then
      Begin
        edtNumCoo.Enabled := fEmptyStr(edtNumDoc.Text);
        If Not edtNumCoo.Enabled Then
          edtNumCoo.Clear;
      End;
    End

    Else If (Sender = edtEspDoc) Then
    Begin

      if fEmptyStr(edtEspDoc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe a Espécie do Documento!', ['&Ok']);
        Result := FALSE;
      End;

    End

    Else If (Sender = edtNumCoo) Then
    Begin
      If Not fEmptyStr(edtNumCoo.Text) Then
      Begin
        Result := fConsultaCoo(strNumDocIf);
        If Result Then
        Begin
          edtNumDoc.Text := strNumDocIf;
          btnConfirmaDados.Click;
        End;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmRcxDigDocumento.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If Not fVerificaCampos Then
    Exit;
  ModalResult := mrOk;
end;

procedure TfrmRcxDigDocumento.btnDocsAviOriLojClick(Sender: TObject);
begin
  inherited;
  blnDocsAVistaOrigLoja := True;
  Close;
  ModalResult := mrOk;
end;

procedure TfrmRcxDigDocumento.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmRcxDigDocumento.fConsultaCoo(var strNumIf: String): Boolean;
begin
  strNumIf := '';
  pCriarFormularios(TfrmRcxCuponsConfirmacao, frmRcxCuponsConfirmacao);
  Try
    frmRcxCuponsConfirmacao.strNumCoo := edtNumCoo.Text;
    Result := (frmRcxCuponsConfirmacao.ShowModal = mrOk);
    If Result Then
    Begin
      strNumIf := frmRcxCuponsConfirmacao.strNumDoc;
    End;
  Finally
    pFreeAndNil(frmRcxCuponsConfirmacao);
  End;
end;

procedure TfrmRcxDigDocumento.FormActivate(Sender: TObject);
begin
  inherited;

  If (edtCodEmp.Enabled) Then
    pSetFocus(edtCodEmp)
  Else
    pSetFocus(edtNumDoc);
end;

procedure TfrmRcxDigDocumento.FormCreate(Sender: TObject);
begin
  inherited;
  edtNumDoc.TamCampo  := fTamDocCadRec;
  edtNumDoc.MaxLength := fTamDocCadRec;
end;

procedure TfrmRcxDigDocumento.FormDblClick(Sender: TObject);
begin
  inherited;
  blnDocsAVistaOrigLoja := False;
end;

procedure TfrmRcxDigDocumento.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case Key Of
    VK_F1: btnDocsAviOriLoj.Click;
    Else inherited;
  end;  
end;

procedure TfrmRcxDigDocumento.FormShow(Sender: TObject);
begin
  inherited;
  If edtEspDoc.Text <> 'IF' Then
  Begin
    edtNumCoo.Visible := False;
    edtNumCoo.Enabled := False;
    lblNumCoo.Visible := False;

    Self.Height := Self.Height - edtNumCoo.Height - lblNumCoo.Height;
  End;

  If Not btnDocsAviOriLoj.Visible Then
    Exit;

  edtCodEmp.Text := VS_strCodEmp;
  edtDesEmp.Text := fRetNomeEmpresa(edtCodEmp.Text);
end;

end.

