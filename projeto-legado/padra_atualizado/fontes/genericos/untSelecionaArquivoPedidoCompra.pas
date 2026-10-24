unit untSelecionaArquivoPedidoCompra;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxButtonEdit, DirectoryEditFocus, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, untLayoutImportacaoPedidoCompra, FilenameEditFocus;

type
  TfrmSelecionaArquivoPedidoCompra = class(TfrmPaiConfirma)
    Label1: TLabel;
    Label2: TLabel;
    lblModelo: TLabel;
    Label4: TLabel;
    edtArquivo: TFilenameEditFocus;
    rgpQuantidade: TRadioGroup;
    procedure lblModeloClick(Sender: TObject);
  private
    { Private declarations }
  public
     ObjImportaPlanilhaPedidoCompra: TImportaPlanilhaPedidoCompra;
    { Public declarations }
  end;

var
  frmSelecionaArquivoPedidoCompra: TfrmSelecionaArquivoPedidoCompra;

implementation

{$R *.dfm}

procedure TfrmSelecionaArquivoPedidoCompra.lblModeloClick(Sender: TObject);
begin
  inherited;
  If ObjImportaPlanilhaPedidoCompra.fSelecionaModelo Then
     lblModelo.Caption := ObjImportaPlanilhaPedidoCompra.fGetNomeModeloSelecionado;
end;

end.
