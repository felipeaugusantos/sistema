unit untConfirmaCTP117;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.StdCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, untTypesSistema;

type
  TfmrConfirmaCTP117 = class(TfrmPaiConfirma)
    memPergunta: TMemo;
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    blnConfirmado: boolean;
    class function fPerguntaGravaCadPag(arrDuplicata: TarrDuplicata): Boolean;
  end;

var
  fmrConfirmaCTP117: TfmrConfirmaCTP117;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

{ TTConfirmaCTP117 }

procedure TfmrConfirmaCTP117.btnConfirmaClick(Sender: TObject);
begin
  blnConfirmado := true;
  inherited;
end;

class function TfmrConfirmaCTP117.fPerguntaGravaCadPag(arrDuplicata: TarrDuplicata): Boolean;
var i: integer;
begin
  pCriarFormularios(TfmrConfirmaCTP117, fmrConfirmaCTP117);
  Try
    fmrConfirmaCTP117.blnConfirmado := False;
    for i := 0 to High(arrDuplicata) do
      If arrDuplicata[i].dtaDtaVen <> '' Then
      Begin
        fmrConfirmaCTP117.memPergunta.Lines.Add(arrDuplicata[i].dtaDtaVen +' - ' + FormatFloat('#,##0.00', arrDuplicata[i].curValor));
        fmrConfirmaCTP117.Height := fmrConfirmaCTP117.Height + 15;
      End;
    fmrConfirmaCTP117.ShowModal;
    Result := fmrConfirmaCTP117.blnConfirmado;
  Finally
    FreeAndNil(fmrConfirmaCTP117);
  End;

end;

end.
