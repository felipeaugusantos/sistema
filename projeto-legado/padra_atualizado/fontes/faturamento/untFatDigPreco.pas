unit untFatDigPreco;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem;

type
  TfrmFatDigPreco = class(TfrmPaiConfirma)
    rdgPreco: TRadioGroup;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmFatDigPreco.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  if rdgPreco.ItemIndex = -1 then
  begin
    fMensagem('ATENÇÃO', 'O tipo de preço deve ser informado!', ['&Ok']);
  end
  else
  begin
    ModalResult := mrOk;
  end;
end;

procedure TfrmFatDigPreco.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(TRadioGroup(rdgPreco.Controls[0]));
end;

end.
