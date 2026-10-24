unit untReferenciarDocumentosExterior;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, untFuncFat, untReferenciarDocumentos, Uni;

type
  TfraReferenciarDocumentosExterior = class(TFrame)
    pnlRefDoc: TPanel;
    btnRefeDoc: TBitBtnLocked;
    procedure btnRefeDocClick(Sender: TObject);
  private
    { Private declarations }
    procedure pCarregaChavesDataSet(
      const frmRefenciarDocumentos: TfrmReferenciarDocumentos);
  public
    { Public declarations }
    objVenda: TFatVenda;

    procedure pCarregaCaptionbtnRefeDoc;
  end;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

procedure TfraReferenciarDocumentosExterior.btnRefeDocClick(Sender: TObject);
var
  frmRefenciarDocumentos: TfrmReferenciarDocumentos;
begin
  pCriarFormularios(TfrmReferenciarDocumentos, frmRefenciarDocumentos);

  try
    pCarregaChavesDataSet(frmRefenciarDocumentos);

    frmRefenciarDocumentos.ShowModal;

    if frmRefenciarDocumentos.ModalResult = mrOk then
    begin
      SetLength(objVenda.arrChaveNFReferenciaDocumentos, 0);

      frmRefenciarDocumentos.cdsChave.First;

      while not frmRefenciarDocumentos.cdsChave.Eof do
      begin
        SetLength(objVenda.arrChaveNFReferenciaDocumentos, Length(objVenda.arrChaveNFReferenciaDocumentos) + 1);
        objVenda.arrChaveNFReferenciaDocumentos[Length(objVenda.arrChaveNFReferenciaDocumentos) - 1] := frmRefenciarDocumentos.cdsChaveCHAVE.AsString;
        frmRefenciarDocumentos.cdsChave.Next;
      end;
    end;
  finally
    pFreeAndNil(frmRefenciarDocumentos);
    pCarregaCaptionbtnRefeDoc;
  end;
end;

procedure TfraReferenciarDocumentosExterior.pCarregaCaptionbtnRefeDoc;
begin
  btnRefeDoc.Caption := 'Referenciar Docs.';

  If (Not Assigned(objVenda)) Or
     (Length(objVenda.arrChaveNFReferenciaDocumentos) = 0) Then
    Exit;

  btnRefeDoc.Caption := btnRefeDoc.Caption
                      + ' ('
                      + IntToStr(Length(objVenda.arrChaveNFReferenciaDocumentos))
                      + ')';
end;

procedure TfraReferenciarDocumentosExterior.pCarregaChavesDataSet(
  const frmRefenciarDocumentos: TfrmReferenciarDocumentos);
var
  intContador : Integer;
begin
  If Length(objVenda.arrChaveNFReferenciaDocumentos) > 0 Then
  Begin
    If frmRefenciarDocumentos.cdsChave.Active Then
      frmRefenciarDocumentos.cdsChave.EmptyDataSet;

    For intContador := 0 To Pred(Length(objVenda.arrChaveNFReferenciaDocumentos)) Do
    Begin
      frmRefenciarDocumentos.cdsChave.Append;
      frmRefenciarDocumentos.cdsChaveCHAVE.AsString := objVenda.arrChaveNFReferenciaDocumentos[intContador];
      frmRefenciarDocumentos.cdsChave.Post;
    End;
  End;
end;

end.
