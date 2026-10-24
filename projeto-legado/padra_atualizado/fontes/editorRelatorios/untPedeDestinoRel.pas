unit untPedeDestinoRel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, ComboBoxFocus, untFuncEditorRel;

type
  TfrmPedeDestinoRel = class(TfrmPaiConfirma)
    cmbDestino: TComboBoxFocus;
    Label1: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
    Procedure pMontaDestinos(strDestinos: String);
    Function fGetDestinoRel: TDestinoRel;
  end;

var
  frmPedeDestinoRel: TfrmPedeDestinoRel;

implementation

{$R *.dfm}

Procedure TfrmPedeDestinoRel.pMontaDestinos(strDestinos: String);
  Var
    stlLista: TStringList;
    desIndice: TDestinoRel;
    intContador: Integer;
Begin
  stlLista      := TStringList.Create;
  stlLista.Text := Trim(strDestinos);

  For desIndice := Low(ArrDestino) To High(ArrDestino) Do
  If desIndice <> desGrid Then
    For intContador := 0 To stlLista.Count - 1 Do
      If SameText(String(ArrDestino[desIndice]), stlLista[intContador]) Then
        cmbDestino.Items.Add(String(ArrDestino[desIndice]));

  FreeAndNil(stlLista);

  If cmbDestino.Items.Count > 0 Then
    cmbDestino.ItemIndex := 0;
End;

Function TfrmPedeDestinoRel.fGetDestinoRel: TDestinoRel;
  Var
    desIndice: TDestinoRel;
Begin
  Result := desVideo;

  For desIndice := Low(ArrDestino) To High(ArrDestino) Do
    If SameText(cmbDestino.Text, String(ArrDestino[desIndice])) Then
    Begin
      Result := desIndice;
      Exit;
    End;
End;

end.
