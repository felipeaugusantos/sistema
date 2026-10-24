unit untFatDadosFiscaisImpDigIcmDes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, StdCtrls, EditFocus, AppEvnts, Menus, Buttons,
  ExtCtrls, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  ComboBoxFocus, QColorLabel;

type
  TfrmFatDadosFiscaisImpDigIcmDes = class(TfrmPaiConfirma)
    Panel1: TPanel;
    lblBase: TLabel;
    Label15: TLabel;
    Label1: TLabel;
    cmbMtdIcmST: TComboBoxFocus;
    cmbMtdIcmNaoST: TComboBoxFocus;
    edtIcmDes: TEditFocus;
    ColorLabel2: TColorLabel;
    Label2: TLabel;
    cmbMtdIcm020: TComboBoxFocus;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strIcmDes,
    strMtdIcmST,
    strMtdIcm020,
    strMtdIcmNaoST: String;
  end;

  function fPedeDigitacaoDadosICMSDesonerado(Var strIcmDes, strMtdIcmST, strMtdIcmNaoST, strMtdIcm020: String): Boolean;

var
  frmFatDadosFiscaisImpDigIcmDes: TfrmFatDadosFiscaisImpDigIcmDes;


implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmFatDadosFiscaisImpDigIcmDes.btnConfirmaClick(Sender: TObject);
begin
//  inherited;
  If fVerificaCampos Then
  Begin
    strIcmDes      := edtIcmDes.Text;
    strMtdIcmST    := cmbMtdIcmST.Text;
    strMtdIcm020   := cmbMtdIcm020.Text;
    strMtdIcmNaoST := cmbMtdIcmNaoST.Text;
    Close;

    ModalResult := mrOk;
  End;

end;

procedure TfrmFatDadosFiscaisImpDigIcmDes.FormShow(Sender: TObject);
begin
  inherited;
  SelectFirst;
end;

function TfrmFatDadosFiscaisImpDigIcmDes.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin

    If (Sender = edtIcmDes) Then
    Begin
      If fEmptyStr(edtIcmDes.Text) Then
      Begin
        fMensagem('', 'Defina o campo "ICMS Desonerado"!', ['&Ok']);
        Result := False;
      End
      Else If Pos(edtIcmDes.Text, 'SN') <= 0 Then
      Begin
        fMensagem('', 'O campo "ICMS Desonerado" deve ser (S)im ou (N)ão!', ['&Ok']);
        Result := False;
      End;

      cmbMtdIcmST.Enabled    := edtIcmDes.Text = 'S';
      cmbMtdIcm020.Enabled   := edtIcmDes.Text = 'S';
      cmbMtdIcmNaoST.Enabled := edtIcmDes.Text = 'S';
    End
    Else If (Sender = cmbMtdIcmST) And (cmbMtdIcmST.Enabled) Then
    Begin
      If fEmptyStr(cmbMtdIcmST.Text) Then
      Begin
        fMensagem('', 'Defina o campo "Motivo de Desoneração para produtos ST"!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = cmbMtdIcm020) And (cmbMtdIcm020.Enabled) Then
    Begin
      If fEmptyStr(cmbMtdIcm020.Text) Then
      Begin
        fMensagem('', 'Defina o campo "Motivo de Desoneração para produtos CST 020"!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = cmbMtdIcmNaoST) And (cmbMtdIcmNaoST.Enabled) Then
    Begin
      If fEmptyStr(cmbMtdIcmNaoST.Text) Then
      Begin
        fMensagem('', 'Defina o campo "Motivo de Desoneração para produtos não ST"!', ['&Ok']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function fPedeDigitacaoDadosICMSDesonerado(Var strIcmDes, strMtdIcmST, strMtdIcmNaoST, strMtdIcm020: String): Boolean;
begin

  Try
    pCriarFormularios(TfrmFatDadosFiscaisImpDigIcmDes, frmFatDadosFiscaisImpDigIcmDes);
    frmFatDadosFiscaisImpDigIcmDes.ShowModal;

    Result := frmFatDadosFiscaisImpDigIcmDes.ModalResult = mrOk;

    If Result Then
    Begin
      strIcmDes      := frmFatDadosFiscaisImpDigIcmDes.strIcmDes;
      strMtdIcmST    := frmFatDadosFiscaisImpDigIcmDes.strMtdIcmST;
      strMtdIcm020   := frmFatDadosFiscaisImpDigIcmDes.strMtdIcm020;
      strMtdIcmNaoSt := frmFatDadosFiscaisImpDigIcmDes.strMtdIcmNaoST;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;

  pFreeAndNil(frmFatDadosFiscaisImpDigIcmDes);
end;

end.
