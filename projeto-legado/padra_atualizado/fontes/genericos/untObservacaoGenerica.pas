unit untObservacaoGenerica;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.StdCtrls,
  Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus,
  Vcl.Buttons, BitBtnLockedIncrem;

type
  TfrmObservacaoGenerica = class(TfrmPaiConfirma)
    mmoObservacao: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function fstrInputObservacao(strCaption: string; strValorDefault: string = ''): string;

implementation

{$R *.dfm}

uses untFuncoesSimples;

function fstrInputObservacao(strCaption: string; strValorDefault: string = ''): string;
  var
    frmObservacao: TfrmObservacaoGenerica;
begin
  frmObservacao := TfrmObservacaoGenerica.Create(nil);
  Try
    frmObservacao.Caption := strCaption;
    frmObservacao.mmoObservacao.Text := strValorDefault;
    frmObservacao.Showmodal;
    If frmObservacao.ModalResult = mrOk Then
      Result := frmObservacao.mmoObservacao.Text;
  Finally
    FreeAndNil(frmObservacao);
  End;
end;

end.
