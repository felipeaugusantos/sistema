unit untDigTintaAutomotivaMazaAutomotiva;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untDigTintaAutomotiva, AppEvnts, Menus, StdCtrls, ComboBoxFocus,
  EditFocus, ExtCtrls, Buttons, BitBtnLockedIncrem;

type
  TfrmDigTintaAutomotivaMazaAutomotiva = class(TfrmDigTintaAutomotiva)
    procedure edtVolumeExit(Sender: TObject);
    procedure rdbLitroClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDigTintaAutomotivaMazaAutomotiva: TfrmDigTintaAutomotivaMazaAutomotiva;

implementation

uses untFuncEspecificas, untFuncoesSimples;

{$R *.dfm}

procedure TfrmDigTintaAutomotivaMazaAutomotiva.edtVolumeExit(Sender: TObject);
begin
//  inherited;
  If (fEmptyStr(edtVolume.Text)) Then
  Begin
    fMensagem('', 'O volume deve ser preenchido!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End
  Else If (fStrToFloat(edtVolume.Text) <= 0) Then
  Begin
    fMensagem('', 'O volume deve ser maior que Zero!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End
  Else If (rdbLitro.Checked) And (fStrToFloat(edtVolume.Text) > 1) Then
  Begin
    fMensagem('', 'O volume máximo para Litro é 1,000!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End
  Else If (rdbGalao.Checked) And (fStrToFloat(edtVolume.Text) > 4) Then
  Begin
    fMensagem('', 'O volume máximo para Galão é 4,000!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End
  Else If (rdbCopo.Checked) And (fFormataFloat(fStrToFloat(edtVolume.Text), 3) > fFormataFloat(0.450, 3)) Then
  Begin
    fMensagem('', 'O volume máximo para Copo é 0,450!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End
  Else If (rdbSpray.Checked) And (fFormataFloat(fStrToFloat(edtVolume.Text), 3) > fFormataFloat(0.190, 3)) Then
  Begin
    fMensagem('', 'O volume máximo para Lata é 0,190!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End;

  objFormula.fltVolumePro := fStrToFloat(edtVolume.Text);
  pAtualizaPrecos;
end;

procedure TfrmDigTintaAutomotivaMazaAutomotiva.rdbLitroClick(Sender: TObject);
begin
  inherited;
  If (rdbCopo.Checked) Then
  Begin
    objFormula.tpeTipEmb := teCopo;
    edtVolume.Text := '0,450';
  End
  Else If (rdbSpray.Checked) Then
  Begin
    objFormula.tpeTipEmb := teSpray;
    edtVolume.Text := '0,190';
  End;
  objFormula.fltVolumePro := fStrToFloat(edtVolume.Text);
  pAtualizaPrecos;
end;

end.
