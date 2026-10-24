unit untModuloGrid;

interface

uses
  System.SysUtils, System.Classes, cxStyles, cxClasses;

type
  TdtmModuloGrid = class(TDataModule)
    cxStyleRepository: TcxStyleRepository;
    cxsZebra: TcxStyle;
    cxsQuebra1: TcxStyle;
    cxsQuebra2: TcxStyle;
    cxsQuebra3: TcxStyle;
    cxsFooter: TcxStyle;
    cxsHeader: TcxStyle;
    cxsEmpresa: TcxStyle;
    cxsFiltros: TcxStyle;
    cxsTitulo: TcxStyle;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dtmModuloGrid: TdtmModuloGrid;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

Uses
  untFuncoesSimples;

procedure TdtmModuloGrid.DataModuleCreate(Sender: TObject);
begin
  cxsZebra.Color := strToInt(fCfgSis('CORZED'));
end;

end.


