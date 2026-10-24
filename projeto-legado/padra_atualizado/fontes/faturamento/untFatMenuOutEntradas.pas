unit untFatMenuOutEntradas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, Menus, StdCtrls, Buttons, ExtCtrls, AppEvnts,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmFatMenuOutEntradas = class(TfrmPaiConfirma)
    rdgOpcao: TRadioGroup;
    procedure rdgOpcaoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    strOpcDoc: String;

  end;

implementation

{$R *.dfm}

Uses
   untFuncoesSimples, untFuncoesDiarias;

procedure TfrmFatMenuOutEntradas.rdgOpcaoClick(Sender: TObject);
begin
  inherited;
  Case rdgOpcao.ItemIndex Of
    0: strOpcDoc := 'OE';
    1: strOpcDoc := 'EF';
  End;
end;

procedure TfrmFatMenuOutEntradas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If ModalResult <> mrok Then
    strOpcDoc := '';
end;

procedure TfrmFatMenuOutEntradas.FormCreate(Sender: TObject);
begin
  inherited;
  strOpcDoc := 'OE';
end;

procedure TfrmFatMenuOutEntradas.FormShow(Sender: TObject);
begin
  inherited;
  pGeraTransferencias;
  pSetFocus(rdgOpcao.Controls[0] As TWinControl);
end;

end.

