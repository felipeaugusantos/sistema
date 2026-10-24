unit untTItemNotaUtilizadoCat;

interface

type
  TItemNotaUtilizadoCat = class
  private
    FAutoIncrem: string;
    FSeqGer: string;
    FQuantidadeUtilizada: Double;
    FQuantidadeTotal: Double;
  public
    property strAutoIncrem: string read FAutoIncrem write FAutoIncrem;
    property strSeqGer: string read FSeqGer write FSeqGer;
    property fltQuantidadeUtilizada: Double read FQuantidadeUtilizada write FQuantidadeUtilizada;
    property fltQuantidadeTotal: Double read FQuantidadeTotal write FQuantidadeTotal;
  end;

implementation

end.
