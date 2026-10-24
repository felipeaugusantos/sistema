unit untFrameCheckComboBoxEmpresa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxCheckBox, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  Vcl.StdCtrls, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCheckComboBox,Uni,untFuncoesSimples;

type
  TfraCheckComboBoxEmpresa = class(TFrame)
    chkcbEmpresa: TcxCheckComboBox;
    lblEmpresa: TLabel;
    procedure chkcbEmpresaFocusChanged(Sender: TObject);
  private
    { Private declarations }
    procedure pCarregaLstEmpresa;
  public
    procedure SelecionaEmpresaLogada(ASomenteRemessaLocal: Boolean);
    { Public declarations }
  end;

implementation

{$R *.dfm}

{ TfraCheckComboBoxEmpresa }

procedure TfraCheckComboBoxEmpresa.chkcbEmpresaFocusChanged(Sender: TObject);
begin
  If (chkcbEmpresa.Properties.Items.Count = 0) Then
    pCarregaLstEmpresa;
end;


procedure TfraCheckComboBoxEmpresa.pCarregaLstEmpresa;
Var
  qryGen: TUniQuery;
  IntAux: Integer;
Begin
  Try
    qryGen := fCriaQuery;

    chkcbEmpresa.Properties.Items.Clear;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('SELECT EMP_CODEMP, CONCAT(EMP_CODEMP," - ", EMP_NOMEMP) AS EMPNOM FROM CADEMP');
    qryGen.Open;
    qryGen.First;
    IntAux := 0;
    While Not qryGen.Eof Do
    Begin
      chkcbEmpresa.Properties.Items.AddCheckItem(qryGen.FieldByName('EMPNOM').AsString);
      chkcbEmpresa.Properties.Items[intAux].ShortDescription := qryGen.FieldByName('EMP_CODEMP').AsString;
      inc(IntAux);
      qryGen.Next;
    End;
    qryGen.Close;
  Finally
    FreeAndNil(qryGen);
  End;

End;

procedure TfraCheckComboBoxEmpresa.SelecionaEmpresaLogada(ASomenteRemessaLocal: Boolean);
  Var
    LContador: Integer;
begin
  If Not ASomenteRemessaLocal Then
    Exit;

  If chkcbEmpresa.Properties.Items.Count = 0 Then
    Exit;

  For LContador := 0 To chkcbEmpresa.Properties.Items.Count - 1 Do
  Begin
    If VS_strCodEmp.Equals(chkcbEmpresa.Properties.Items[LContador].ShortDescription) Then
    Begin
      chkcbEmpresa.States[LContador] := cbsChecked;
      Break;
    End;
  End;
end;

end.
