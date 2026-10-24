unit untFatDadosFiscaisImpDigValores;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, StdCtrls, EditFocus, AppEvnts, Menus, Buttons,
  ExtCtrls, BitBtnLockedIncrem;

type
  TfrmFatDadosFiscaisImpDigValores = class(TfrmPaiConfirma)
    Panel1: TPanel;
    lblBase: TLabel;
    Label15: TLabel;
    edtBase: TEditFocus;
    edtAlq: TEditFocus;
    Label1: TLabel;
    edtValor: TEditFocus;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    fltBase, fltAlq, fltValor: Double;
    strImposto: String;
    blnInfAlq: Boolean;
  end;

  function fPedeDigitacaoValoresImpost(Var fltbase, fltAlq, fltValor: Double;
    strImposto: String; blnInfAlq: Boolean): Boolean;

var
  frmFatDadosFiscaisImpDigValores: TfrmFatDadosFiscaisImpDigValores;


implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmFatDadosFiscaisImpDigValores.btnConfirmaClick(Sender: TObject);
begin
//  inherited;
  If fVerificaCampos Then
  Begin
    fltBase  := fStrToFloat(edtBase.Text);
    fltAlq   := fStrToFloat(edtAlq.Text);
    fltValor := fStrToFloat(edtValor.Text);
    Close;
    ModalResult := mrOk;    
  End;  

end;

procedure TfrmFatDadosFiscaisImpDigValores.FormCreate(Sender: TObject);
begin
  inherited;
  blnInfAlq := True;
end;

procedure TfrmFatDadosFiscaisImpDigValores.FormShow(Sender: TObject);
begin
  inherited;
  edtAlq.Enabled := blnInfAlq;
  self.Caption   := strImposto;
  SelectFirst;
end;

function TfrmFatDadosFiscaisImpDigValores.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin

    If (Sender = edtBase) Then
    Begin
      edtValor.Enabled := True;

      If fStrToFloat(edtBase.Text) < 0 Then
      Begin
        fMensagem('', 'Informe um valor maior ou igual à zero!', ['&Ok']);
        Result := False;
      End
      Else If fStrToFloat(edtBase.Text) = 0 Then
      Begin
        edtValor.Enabled := False;
        edtValor.Text    := '0,00';
      End
      Else If blnBuscaPorChave Then
        edtValor.Text := FormatFloat('#,##0.00', fStrToFloat(edtBase.Text) * fStrToFloat(edtAlq.Text) / 100);
    End

    Else If (Sender = edtAlq) And (edtAlq.Enabled) Then
    Begin
      edtValor.Enabled := True;

      If fStrToFloat(edtAlq.Text) < 0 Then
      Begin
        fMensagem('', 'Informe um valor maior ou igual à zero!', ['&Ok']);
        Result := False;
      End
      Else If fStrToFloat(edtAlq.Text) = 0 Then
      Begin
        edtValor.Enabled := False;
        edtValor.Text    := '0,00';
      End
      Else If blnBuscaPorChave Then
        edtValor.Text := FormatFloat('#,##0.00', fStrToFloat(edtBase.Text) * fStrToFloat(edtAlq.Text) / 100);
    End

    Else If (Sender = edtValor) And (edtValor.Enabled) Then
    Begin

      If fStrToFloat(edtValor.Text) < 0 Then
      Begin
        fMensagem('', 'Informe um valor maior ou igual à zero!', ['&Ok']);
        Result := False;
      End
      Else If edtAlq.Enabled And (Abs(fStrToFloat(edtValor.Text) - (fStrToFloat(edtBase.Text) * fStrToFloat(edtAlq.Text) / 100)) > 0.10) Then
      Begin
        fMensagem('', 'Valor digitado excede a variação máxima permitida entre calculado e digitado que é de (0.10)!', ['&Ok']);
        Result := False;
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
    
end;

function fPedeDigitacaoValoresImpost(Var fltbase, fltAlq, fltValor: Double;
  strImposto: String; blnInfAlq: Boolean): Boolean;
begin

  Try
    pCriarFormularios(TfrmFatDadosFiscaisImpDigValores, frmFatDadosFiscaisImpDigValores);
    frmFatDadosFiscaisImpDigValores.strImposto := strImposto;
    frmFatDadosFiscaisImpDigValores.blnInfAlq  := blnInfAlq;

    frmFatDadosFiscaisImpDigValores.ShowModal;

    Result := frmFatDadosFiscaisImpDigValores.ModalResult = mrOk;

    If Result Then
    Begin
      fltbase  := frmFatDadosFiscaisImpDigValores.fltBase;
      fltAlq   := frmFatDadosFiscaisImpDigValores.fltAlq;
      fltValor := frmFatDadosFiscaisImpDigValores.fltValor;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;

  pFreeAndNil(frmFatDadosFiscaisImpDigValores);

end;

end.
