unit untMensagemNegociacaoOS;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Data.DB, Vcl.Grids, Vcl.DBGrids, DBGridCitel;

type
  TfrmMensagemNegociacaoOS = class(TfrmPai)
    pnlMsg: TPanel;
    memMsg: TMemo;
    dbgGridDfe: TDBGridCitel;
    dtsNegociacoes: TDataSource;
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

procedure TfrmMensagemNegociacaoOS.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(btnSair);
end;

end.
