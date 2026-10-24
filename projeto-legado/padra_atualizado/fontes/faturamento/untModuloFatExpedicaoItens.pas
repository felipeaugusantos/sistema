unit untModuloFatExpedicaoItens;

interface

uses
  System.SysUtils, System.Classes, frxClass, frxExportCSVTestabilidade, Forms,
  frxDBSet;

type
  TfrmModuloFatExpedicaoItens = class(TForm)
    frxEtiqItens: TfrxReport;
    frxEtiqCaixa: TfrxReport;
    frxListCaixa: TfrxReport;
    frxCSVExportTestabilidade: TfrxCSVExportTestabilidade;
    frxDBImpEti: TfrxDBDataset;
    frxDBEtiqCaixa: TfrxDBDataset;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
