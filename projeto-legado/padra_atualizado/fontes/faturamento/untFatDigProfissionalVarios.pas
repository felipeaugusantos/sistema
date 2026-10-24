{***********************}
{* qryConDiv -> CADDIV *}
{********************JB*}

unit untFatDigProfissionalVarios;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, StdCtrls, EditFocus, Menus, ComCtrls, Buttons, untFuncFat,
  ExtCtrls, Grids, DBGridCitel, DBGrids, DB, UniClientDataSet, Uni, AppEvnts, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade, Datasnap.DBClient,
  untFatDigProfissionalVariosFrame, untCadDiversos;

type
  TfrmFatDigProfissionalVarios = class(TfrmPaiSimples)
    pnlConfirma: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    fraDigProfisssionalVarios: TfraFatDigProfissionalVariosFrame;
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure btnCancelaDadosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure fraDigProfisssionalVariosedtCodProExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    function fAlteraCadDiv(const strCodDivLocal: String): String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    objVenda: TFatVenda;
    blnConfirma: Boolean;
  end;

var
  frmFatDigProfissionalVarios: TfrmFatDigProfissionalVarios;

implementation

uses untfuncoesSimples, untPai, untConsultas, untTypesSistema, untFuncFatTypes,
  untLiberacao, untFuncoesGenerica, untFuncIns2, untFuncIns;

{$R *.dfm}

procedure TfrmFatDigProfissionalVarios.fraDigProfisssionalVariosedtCodProExit(
  Sender: TObject);
begin
  inherited;
  fraDigProfisssionalVarios.edtCodProExit(Sender);
  if fEmptyStr(fraDigProfisssionalVarios.edtCodPro.Text) Then
    pSetFocus(btnConfirmaDados);
end;

function TfrmFatDigProfissionalVarios.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := inherited fValidaCampos(Sender, blnBuscaPorChave) And
            fraDigProfisssionalVarios.fValidaCampos(Sender, blnBuscaPorChave);

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmFatDigProfissionalVarios.btnConfirmaDadosClick(
  Sender: TObject);
begin
  inherited;
  If Not fVerificaCampos Then
    Exit;

  If Not fraDigProfisssionalVarios.fConfirmaDados Then
    Exit;

  blnConfirma := True;
  Close;
end;

function TfrmFatDigProfissionalVarios.fAlteraCadDiv(
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

procedure TfrmFatDigProfissionalVarios.btnCancelaDadosClick(
  Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatDigProfissionalVarios.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  fraDigProfisssionalVarios.OnFormClose(Sender, Action);
end;

procedure TfrmFatDigProfissionalVarios.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma  := False;
  fraDigProfisssionalVarios.OnFormCreate;
end;

procedure TfrmFatDigProfissionalVarios.FormDestroy(Sender: TObject);
begin
  inherited;
  fraDigProfisssionalVarios.OnFormDestroy;
end;

procedure TfrmFatDigProfissionalVarios.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  strCodTmp: String;
begin
  inherited;

  if fIsInsert(Key) Then
  Begin
    if fVerificaAcessoSistema('frmCadDiversos') then
    begin
      if fEmptyStr(fraDigProfisssionalVarios.edtCodPro.Text) or
         fEmptyStr(fCampoTabela('DIV_CODDIV', 'CADDIV', ['DIV_CODDIV'], [fStrZero(fraDigProfisssionalVarios.edtCodPro.Text, 8)])) then
        strCodTmp := fChamaCadDiv(Key)
      else
      begin
        objVenda.strCodDiv := '';
        strCodTmp := fAlteraCadDiv(fStrZero(fraDigProfisssionalVarios.edtCodPro.Text, 8));
      end;

      if (not fEmptyStr(strCodTmp)) then
      begin
        fraDigProfisssionalVarios.edtCodPro.Text := strCodTmp;
        fraDigProfisssionalVarios.edtDesPro.Text := fRetNomDiversos(fraDigProfisssionalVarios.edtCodPro.Text);
      end;
    end;
  end;

end;

procedure TfrmFatDigProfissionalVarios.FormShow(Sender: TObject);
begin
  inherited;
  fraDigProfisssionalVarios.objVenda := objVenda;
  fraDigProfisssionalVarios.OnFormShow;
  pSetFocus(fraDigProfisssionalVarios.edtCodPro);
end;

end.

