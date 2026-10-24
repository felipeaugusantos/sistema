unit Contabilidade.View.ImportacaoDadosContabeisMensagem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Contabilidade.View.TfrmPaiContabilidade, Vcl.StdCtrls, Vcl.ExtCtrls,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  BitBtnLockedIncrem;

type
  TfrmImportacoesContabeisMensagem = class(TfrmPaiContabilidade)
    mmMensagens: TMemo;
    procedure FormShow(Sender: TObject);
  private
    FstrMensagem: string;
    { Private declarations }
  public
    { Public declarations }
    property strMensagem : string  read FstrMensagem write FstrMensagem;
  end;

implementation

{$R *.dfm}

procedure TfrmImportacoesContabeisMensagem.FormShow(Sender: TObject);
begin
  inherited;
  mmMensagens.Text := strMensagem ;
end;

end.
