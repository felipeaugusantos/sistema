unit untDadosFechamentoVendaTipoFaturamentoFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, EditFocus,
  Vcl.ExtCtrls, dxGDIPlusClasses;

type
  TfraDadosFechamentoVendaTipoFaturamentoFrame = class(TFrame)
    pnlDados: TPanel;
    lblTipoFaturamento: TLabel;
    lblDescontoPercentual: TLabel;
    lblDescontoEspecial: TLabel;
    lblTotalGeral: TLabel;
    edtTipFat: TEditFocus;
    edtPorDes: TEditFocus;
    edtDesEsp: TEditFocus;
    edtTotGer: TEditFocus;
    imgAlerta: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
