unit OrdemProducaoIndustrial.TAgrupamentoPedidoEstoque;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
     Forms, Dialogs;

Type
  TAgrupamentoPedidoEstoque = class
    private

      FCodigoEmpresa : String;

    public
      property strCodigoEmpresa     : String  read FCodigoEmpresa     write FCodigoEmpresa;

      constructor Create;

      function  fGetSQLFatDor: String;

  End;

implementation

{ TAgrupamentoPedidoOrdProdIndustrialEstoque }

constructor TAgrupamentoPedidoEstoque.Create;
begin
  FCodigoEmpresa:= '';
end;

function TAgrupamentoPedidoEstoque.fGetSQLFatDor: String;
begin
  Result := '';
  Result := Result + ' SELECT FDO_CODITE,                                 ';
  Result := Result + '        FDO_DESCRI,                                 ';
  Result := Result + '        FDO_UNIDAD,                                 ';
  Result := Result + '        FDO_QTDITE,                                 ';
  Result := Result + '        FDO_UNITAR,                                 ';
  Result := Result + '        FDO_TOTITE,                                 ';
  Result := Result + '        FDO_COMPLE,                                 ';
  Result := Result + ' IF( IFNULL(FDO_ENTRET, "") =  "E" AND IFNULL(FDO_ENTFUT, "") <> "S", "Entrega Imediata",   ';
  Result := Result + ' IF( IFNULL(FDO_ENTRET, "") =  "E" AND IFNULL(FDO_ENTFUT, "") =  "S", "Entrega Futura",     ';
  Result := Result + ' IF( IFNULL(FDO_ENTRET, "") <> "E", "Retira", ""))) AS ENTRET,                              ';
  Result := Result + '        ITE_CODPAG,                                 ';
  Result := Result + '        ITE_CODCOR,                                 ';
  Result := Result + '        ITE_SALDOS,                                 ';
  Result := Result + ' (0.00) ITE_SALRES,                                 ';
  Result := Result + ' (0.00) ITE_SALDIS,                                 ';
  Result := Result + ' (0.00) ITE_SALFIS,                                 ';
  Result := Result + '        FDO_NUMLOT,                                 ';
  Result := Result + '        D.AUTOINCREM AS FDO_SEQFDO                  ';
  Result := Result + ' FROM FATDOR D                                      ';
  Result := Result + ' INNER JOIN EXTDOR   ON FDO_SEQFDO = D.AUTOINCREM   ';
  Result := Result + ' INNER JOIN CADITE I ON I.ITE_CODITE = D.FDO_CODITE ';
  Result := Result + ' INNER JOIN ITEGER G ON G.ITE_CODITE = D.FDO_CODITE ';
  Result := Result + '                    AND G.ITE_CODEMP = ' + QuotedStr(FCodigoEmpresa);
  Result := Result + ' WHERE D.FDO_SEQGER = :AUTINC                       ';
  Result := Result + '   AND FDO_QTDITE > 0                               ';
  Result := Result + '   AND ITE_CODPAG IS NOT NULL                       ';
  Result := Result + '   AND FDO_BAIOPI = "N"                             ';
  Result := Result + '   AND FDO_SEQOPI IS NULL                           ';
  Result := Result + ' ORDER BY FDO_DESCRI                                ';
end;

end.
