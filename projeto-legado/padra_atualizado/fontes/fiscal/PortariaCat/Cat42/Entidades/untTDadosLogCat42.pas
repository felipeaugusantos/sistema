unit untTDadosLogCat42;

interface

type
  TDadosLogCat42 = class
  private

    FEmpresaProcessamento: string;
    FUsuarioProcessamento: string;
    FDataProcessamento: TDate;
    FDataInicial: TDate;
    FDataFinal: TDate;
    FHoraInicial: TTime;
    FHoraFinal: TTime;
    FOrder: Integer;
    FDescr: string;
    FValor: string;
    FOrigem: string;
    FPrecoInventario: string;

  public

    property strEmpresaProcessamento: string read FEmpresaProcessamento write FEmpresaProcessamento;
    property strUsuarioProcessamento: string read FUsuarioProcessamento write FUsuarioProcessamento;
    property dteDataProcessamento: TDate read FDataProcessamento write FDataProcessamento;
    property dteDataInicial: TDate read FDataInicial write FDataInicial;
    property dteDataFinal: TDate read FDataFinal write FDataFinal;
    property tmeHoraInicial: TTime read FHoraInicial write FHoraInicial;
    property tmeHoraFinal: TTime read FHoraFinal write FHoraFinal;
    property intOrder: Integer read FOrder write FOrder;
    property strDescr: string read FDescr write FDescr;
    property strValor: string read FValor write FValor;
    property strOrigem: string read FOrigem write FOrigem;
    property strPrecoInventario: string read FPrecoInventario write FPrecoInventario;

  end;

implementation

end.
