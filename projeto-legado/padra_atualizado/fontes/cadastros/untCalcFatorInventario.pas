unit untCalcFatorInventario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.StdCtrls, EditFocus, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus,
  Vcl.Buttons, BitBtnLockedIncrem, strUtils;

type
  TfrmCalcFatorInventario = class(TfrmPaiConfirma)
    edtValAtu: TEditFocus;
    Label1: TLabel;
    edtValFut: TEditFocus;
    Label2: TLabel;
    Label3: TLabel;
    edtFatorCalc: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
  protected
    blnConfirma: Boolean;

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fGetValueFloat(strValue: String): Double;

  public
    class function fGetFator(strValorInventarioAtual: String): Double;

    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmCalcFatorInventario.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  blnConfirma:= True;
end;

class function TfrmCalcFatorInventario.fGetFator(strValorInventarioAtual: String): Double;
var frmCalcFatorInventario: TfrmCalcFatorInventario;
begin
  Result := 1;
  pCriarFormularios(TfrmCalcFatorInventario, frmCalcFatorInventario);
  Try
    frmCalcFatorInventario.edtValAtu.Text := strValorInventarioAtual;
    frmCalcFatorInventario.Showmodal;
    If frmCalcFatorInventario.blnConfirma Then
      Result := frmCalcFatorInventario.fGetValueFloat(frmCalcFatorInventario.edtFatorCalc.Text)
  Finally
    FreeAndNil(frmCalcFatorInventario);
  End;
end;

function TfrmCalcFatorInventario.fGetValueFloat(strValue: String): Double;
begin
  strValue := AnsiReplaceStr(strValue, '.', '');
  If strValue = '' Then
    strValue := '0';
  Result := strToFloat(strValue);
end;

procedure TfrmCalcFatorInventario.FormCreate(Sender: TObject);
begin
  inherited;
  edtValAtu.EditFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  edtValFut.EditFormat := edtValAtu.EditFormat;
  blnConfirma := False;
end;

function TfrmCalcFatorInventario.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If Sender = edtValFut Then
  Begin
    If fEmptyStr(edtValFut.Text) Then
      edtValFut.Text := '0'
    Else
    Begin
      If Not (fGetValueFloat(edtValFut.Text) > 0) Then
      Begin
        pMensagemOk('O valor desejado deve ser maior que 0!');
        Result := False;
      End
      Else
        edtFatorCalc.Text :=  FormatFloat('#0.000000', fGetValueFloat(edtValFut.Text)/fGetValueFloat(edtValAtu.Text));
    End;
  End;
end;

end.
