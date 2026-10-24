unit Estoque.Lote.TSQLSaldoLote;

interface

uses
  classes;

  Type
    TSQLSaldoLote = Class

    private

      FCodigoItem    : String;
      FCodigoEmpresa : String;

    public

      property strCodigoItem    : String read FCodigoItem     write FCodigoItem;
      property strCodigoEmpresa : String read FCodigoEmpresa  write FCodigoEmpresa;

      function fRetornaLoteComSaldo: String;

    constructor create;

  End;

implementation

{ TSQLCadLote }

constructor TSQLSaldoLote.create;
begin
  FCodigoItem    := '';
  FCodigoEmpresa := '';
end;

function TSQLSaldoLote.fRetornaLoteComSaldo: String;
begin
  Result:= 'SELECT * FROM CADLOT                         '+
           '  WHERE LOT_CODITE = "'+FCodigoItem+'"       '+
           '    AND LOT_CODEMP = "'+FCodigoEmpresa+'"    '+
           '    AND LOCATE(LOT_NUMLOT, "A DEFINIR") <= 0 '+
           '    AND LOT_STATUS = "S"                     '+
           '    AND LOT_SALDOS > 0                       '+
           '  ORDER BY LOT_SALDOS DESC, LOT_ARMPRI DESC  '+
           '  LIMIT 1                                    ';
end;

end.
