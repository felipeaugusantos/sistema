unit Contabilidade.Interfaces.TConferenciaNaturezaOperacaoParconService;

interface

uses
  Data.DB;

type
  IConferenciaNaturezaOperacaoParconService = interface
    ['{891012B1-4E81-4F6F-9948-9C0C2960DA06}']
    function fConferir(const AFiltro: string): TDataset;
  end;

implementation

end.
