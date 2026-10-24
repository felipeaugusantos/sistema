unit untGetMetragem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, EditFocus, Vcl.ExtCtrls, untPaiSimples,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.Buttons, BitBtnLockedIncrem;

type
  TfrmGetMetragem = class(TFrmPaiSimples)
    pnlQtdMadeira: TPanel;
    lblComPec: TLabel;
    lblLarPec: TLabel;
    lblEspPec: TLabel;
    lblQtdMadeira: TLabel;
    edtComPec: TEditFocus;
    edtLarPec: TEditFocus;
    edtEspPec: TEditFocus;
    edtQtdPec: TEditFocus;
    Label1: TLabel;
    edtValTot: TEditFocus;
    procedure FormShow(Sender: TObject);
  private
    FValUni : Double;
  public
    class function fGetQuantidadeTotal(fltValUni : Double; Var fltComPec, fltLarPec, fltEspPec, fltQtdPec : Double) : Double;

  protected
    function fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean) : Boolean; Override;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples;

class function TfrmGetMetragem.fGetQuantidadeTotal(fltValUni : Double; Var fltComPec, fltLarPec, fltEspPec, fltQtdPec : Double): Double;
  var
    frmGetMetragem: TfrmGetMetragem;
begin
  pCriarFormularios(TfrmGetMetragem, frmGetMetragem);
  With frmGetMetragem Do
  Begin
    edtQtdPec.EditFormat := fMskDigitos(5);
    edtComPec.EditFormat := fMskDigitos(5);
    edtLarPec.EditFormat := fMskDigitos(5);
    edtEspPec.EditFormat := fMskDigitos(5);
    edtValTot.EditFormat := fMskDigitos( fCfgSis('DECUNI', varInteger) );

    FValUni        := fltValUni;
    edtQtdPec.Text := FormatFloat(edtQtdPec.EditFormat, fltQtdPec);
    edtComPec.Text := FormatFloat(edtComPec.EditFormat, fltComPec);
    edtLarPec.Text := FormatFloat(edtLarPec.EditFormat, fltLarPec);
    edtEspPec.Text := FormatFloat(edtEspPec.EditFormat, fltEspPec);
    edtValTot.Text := FormatFloat(edtValTot.EditFormat, fltValUni);

    ShowModal;

    fltQtdPec := fStrToFloat(edtQtdPec.Text);
    fltComPec := fStrToFloat(edtComPec.Text);
    fltLarPec := fStrToFloat(edtLarPec.Text);
    fltEspPec := fStrToFloat(edtEspPec.Text);

    Result := fStrToFloat(edtQtdPec.Text) *
              fStrToFloat(edtComPec.Text) *
              fStrToFloat(edtLarPec.Text) *
              fStrToFloat(edtEspPec.Text) ;

  End;

end;

procedure TfrmGetMetragem.FormShow(Sender: TObject);
begin
  pSetFocus(edtQtdPec);
end;

function TfrmGetMetragem.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If Inherited fValidaCampos(Sender, blnBuscaPorChave) Then
  Begin
    If (Sender = edtQtdPec) Or
       (Sender = edtComPec) Or
       (Sender = edtLarPec) Or
       (Sender = edtEspPec) Or
       (Sender = edtValTot) Then
    Begin
      Result := fStrToFloat(TEditFocus(Sender).Text) > 0;

      If Not Result Then
        fMensagem('', 'Informe um valor maior que zero!', ['&OK']);

      If Result then
        edtValTot.Text := FormatFloat('#0.00', (fStrToFloat(edtQtdPec.Text) *
                                                fStrToFloat(edtComPec.Text) *
                                                fStrToFloat(edtLarPec.Text) *
                                                fStrToFloat(edtEspPec.Text))* FValUni);

      If (Sender = edtValTot) And Result Then
        ModalResult := mrOK;

    End;
  End;

  If not Result Then
    pSetFocus(Sender);

end;

end.
