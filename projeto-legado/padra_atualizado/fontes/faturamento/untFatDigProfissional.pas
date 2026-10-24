{***************************}
{* qryConDiv -> CADDIV     *}
{************************JB*}
unit untFatDigProfissional;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, Menus, ComCtrls, Buttons, Uni,
  ExtCtrls, EditFocus, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, untFuncFat, untFatDigProfissionalFrame;

type
  TfrmFatDigProfissional = class(TfrmPaiSimples)
    pnlConfirma: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    fraDigProfisssional: TfraFatDigProfissionalFrame;
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCancelaDadosClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure fraDigProfisssionaledtCodProEnter(Sender: TObject);
    procedure fraDigProfisssionaledtCodProExit(Sender: TObject);
  private
    { Private declarations }
    function fAlteraCadDiv(const strCodDivLocal: String): String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnConfirma: Boolean;
    objVenda: TFatVenda;
  end;

var
  frmFatDigProfissional: TfrmFatDigProfissional;

implementation

uses untfuncoesSimples, untConsultas, untTypesSistema, untFuncIns, untFuncIns2,
  untCadDiversos;

{$R *.dfm}

procedure TfrmFatDigProfissional.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  fraDigProfisssional.OnFormClose(Sender, Action);
end;

procedure TfrmFatDigProfissional.FormCreate(Sender: TObject);
var
  intDifTamFormFrame: Integer;
  intDifTamLabel: Integer;
begin
  inherited;
  fraDigProfisssional.OnFormCreate;
  if (fraDigProfisssional.intLblNomProWidth < fraDigProfisssional.lblNomPro.Width) then
  begin
    intDifTamFormFrame := Trunc((fraDigProfisssional.Width - fraDigProfisssional.intFrameWidth) / 2);
    intDifTamLabel := (fraDigProfisssional.lblNomPro.Width - fraDigProfisssional.intLblNomProWidth);
    if (intDifTamFormFrame < intDifTamLabel) then
      Self.Width := Self.Width + (intDifTamLabel - intDifTamFormFrame);
  end;
end;

procedure TfrmFatDigProfissional.FormDestroy(Sender: TObject);
begin
  inherited;
  fraDigProfisssional.OnFormDestroy;
end;

procedure TfrmFatDigProfissional.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  strCodTmp: String;
begin
  inherited;
  if fIsInsert(Key) Then
  Begin
    if fVerificaAcessoSistema('frmCadDiversos') then
    begin
      if fEmptyStr(fraDigProfisssional.edtCodPro.Text) or
         fEmptyStr(fCampoTabela('DIV_CODDIV', 'CADDIV', ['DIV_CODDIV'], [fStrZero(fraDigProfisssional.edtCodPro.Text, 8)])) then
        strCodTmp := fChamaCadDiv(Key)
      else
      begin
        strCodTmp := fAlteraCadDiv(fStrZero(fraDigProfisssional.edtCodPro.Text, 8));
      end;

      if (not fEmptyStr(strCodTmp)) then
      begin
        fraDigProfisssional.edtCodPro.Text := strCodTmp;
        fraDigProfisssional.edtDesPro.Text := fRetNomDiversos(fraDigProfisssional.edtCodPro.Text);
      end;
    end;
  end;
end;

procedure TfrmFatDigProfissional.FormShow(Sender: TObject);
begin
  inherited;
  fraDigProfisssional.objVenda := objVenda;
  fraDigProfisssional.OnFormShow;
end;

procedure TfrmFatDigProfissional.fraDigProfisssionaledtCodProEnter(
  Sender: TObject);
begin
  inherited;
  if fEmptyStr(fraDigProfisssional.edtCodPro.text) then
    pnlInfo.Caption := 'Pressione INSERT para inserir um novo cadastro.';
end;

procedure TfrmFatDigProfissional.fraDigProfisssionaledtCodProExit(
  Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := '';
end;

function TfrmFatDigProfissional.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := fraDigProfisssional.fValidaCampos(Sender, blnBuscaPorChave);
  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmFatDigProfissional.btnCancelaDadosClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatDigProfissional.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If Not fVerificaCampos Then
    Exit();

  If Not fraDigProfisssional.fConfirmaDados Then
    Exit();

  blnConfirma := True;
  Close;
end;

function TfrmFatDigProfissional.fAlteraCadDiv(
  const strCodDivLocal: String): String;
var
  frmCadDiversos: TfrmCadDiversos;
begin
  If Not fVerificaAcessoSistema('frmCadDiversos') Then
    Exit;

  pCriarFormularios(TfrmCadDiversos, frmCadDiversos);
  Try
    Try
      frmCadDiversos.strCodDiversosIniciarCadastro := strCodDivLocal;
      frmCadDiversos.ShowModal;
      Result := frmCadDiversos.strUltimoCodigo;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '');
    End;
  Finally
    pFreeAndNil(frmCadDiversos);
  End;
end;

end.

