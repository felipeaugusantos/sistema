unit untRcxDigMoedas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiEdit, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  EditFocus, BitBtnLockedIncrem;

type
  TfrmRcxDigMoedas = class(TfrmPaiEdit)
    Label9: TLabel;
    edtDinheiro: TEditFocus;
    edtGuarani: TEditFocus;
    edtDolar: TEditFocus;
    edtEuro: TEditFocus;
    edtPeso: TEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtReal: TEditFocus;
    Label6: TLabel;
    edtTotDig: TEditFocus;
    btnConfirma: TBitBtnLocked;
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtGuaraniExit(Sender: TObject);
    procedure edtDolarExit(Sender: TObject);
    procedure edtEuroExit(Sender: TObject);
    procedure edtPesoExit(Sender: TObject);
    procedure edtRealExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure pCalculaTotalDig;
    function fValidaValores: Boolean;
    function fTotalDigitadoConfere: Boolean;
  public
    blnConfirma: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmRcxDigMoedas: TfrmRcxDigMoedas;

implementation

uses untFuncoesSimples,untPai;

{$R *.dfm}


procedure TfrmRcxDigMoedas.edtDolarExit(Sender: TObject);
begin
  inherited;
  pCalculaTotalDig;
end;

procedure TfrmRcxDigMoedas.edtEuroExit(Sender: TObject);
begin
  inherited;
  pCalculaTotalDig;
end;

procedure TfrmRcxDigMoedas.edtGuaraniExit(Sender: TObject);
begin
  inherited;
  pCalculaTotalDig;
end;

procedure TfrmRcxDigMoedas.edtPesoExit(Sender: TObject);
begin
  inherited;
  pCalculaTotalDig;
end;

procedure TfrmRcxDigMoedas.edtRealExit(Sender: TObject);
begin
  inherited;
  pCalculaTotalDig;
end;

procedure TfrmRcxDigMoedas.FormShow(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
  pCalculaTotalDig;;
end;

function TfrmRcxDigMoedas.fTotalDigitadoConfere: Boolean;
begin

  Result := fStrToFloat(edtDinheiro.Text) = fStrToFloat(edtTotDig.Text);

end;

function TfrmRcxDigMoedas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {If (Sender = edtGuarani) Then //PEDIDO PARA PERMITIR RECEBER SÓ CREDITO
    Begin
      If fStrToFloat(edtGuarani.Text) < 0 Then
      Begin
        fMensagem('', 'O Valor em Guarani dever ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End
    End

    Else If (Sender = edtDolar) Then
    Begin
      If fStrToFloat(edtDolar.Text) < 0 Then
      Begin
        fMensagem('', 'O Valor em Dolar dever ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End
    End

    Else If (Sender = edtEuro) Then
    Begin
      If fStrToFloat(edtEuro.Text) < 0 Then
      Begin
        fMensagem('', 'O Valor em Euro dever ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End
    End

    Else If (Sender = edtPeso) Then
    Begin
      If fStrToFloat(edtPeso.Text) < 0 Then
      Begin
        fMensagem('', 'O Valor em Peso dever ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End
    End

    Else If (Sender = edtReal) Then
    Begin
      If fStrToFloat(edtReal.Text) < 0 Then
      Begin
        fMensagem('', 'O Valor em Real dever ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End
    End}

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmRcxDigMoedas.fValidaValores: Boolean;
begin

  Result := False;

  Try

    {If fStrToFloat(edtGuarani.Text) + //PEDIDO PARA PERMITIR RECEBER SÓ CREDITO
       fStrToFloat(edtEuro.Text)    +
       fStrToFloat(edtDolar.Text)   +
       fStrToFloat(edtPeso.Text)    +
       fStrToFloat(edtReal.Text) <= 0 Then
    Begin
      fMensagem('', 'Informe o valor recebido!', ['&O k']);
      pSetFocus(edtGuarani);
    End
    Else} If (Not fTotalDigitadoConfere) Then
    Begin
      fMensagem('', 'O total dos valores digitados não confere com o total em dinheiro!', ['&O k']);
      pSetFocus(edtGuarani);
    End
    Else
      Result := True;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TfrmRcxDigMoedas.fValidaValores]');
  End;

end;

procedure TfrmRcxDigMoedas.pCalculaTotalDig;
Var
  fltVlrGua: Double;
  fltVlrDol: Double;
  fltVlrEur: Double;
  fltVlrPes: Double;
  fltVlrRea: Double;
begin

  fltVlrGua := fFormataFloat(fStrToFloat(edtGuarani.Text), 2);
  fltVlrDol := fFormataFloat(fCon_Precos(fStrToFloat(edtDolar.Text), 2, False, VS_Date, True), 2);
  fltVlrEur := fFormataFloat(fCon_Precos(fStrToFloat(edtEuro.Text), 5, False, VS_Date, True), 2);
  fltVlrPes := fFormataFloat(fCon_Precos(fStrToFloat(edtPeso.Text), 4, False, VS_Date, True), 2);
  fltVlrRea := fFormataFloat(fCon_Precos(fStrToFloat(edtReal.Text), 3, False, VS_Date, True), 2);

  edtTotDig.Text := FormatFloat('#,##0.00', fltVlrGua + fltVlrDol + fltVlrEur + fltVlrPes + fltVlrRea);
end;

procedure TfrmRcxDigMoedas.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If Not fVerificaCampos Then
    Exit;

  If Not fValidaValores Then
    Exit;

  blnConfirma := True;
  Close;
end;

end.

