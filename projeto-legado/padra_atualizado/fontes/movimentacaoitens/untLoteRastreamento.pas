unit untLoteRastreamento;

interface

uses
  Classes, SysUtils, Data.Db, untFuncoesSimples,
  System.Variants, uni;


  type
    TLoteRastreamento = class
      FqryLoteRastreamento : TUniQuery;
      FblnRastreamentoIndustrial : boolean;
  private

  public

    constructor Create;
    destructor Destroy; override;

    procedure pAbreQuery(strCodigoItem : String);
    property qryLoteRastreamento : TUniQuery read FqryLoteRastreamento write FqryLoteRastreamento;
    property blnRastreamentoIndustrial : boolean read FblnRastreamentoIndustrial;
  end;


implementation

{ TRastreamentoEnderecamento }

constructor TLoteRastreamento.Create;
begin
  inherited;
  FblnRastreamentoIndustrial := fCfgSis('RASIND', varInteger) = 2;
  FqryLoteRastreamento := fCriaQuery(nil);

  FqryLoteRastreamento.SQL.Add('SELECT                                                                                                                                                                ');
  FqryLoteRastreamento.SQL.Add('  IF(LOTRAS.AUTOINCREM IS NULL, ORD_DTABAI, DET_DTAENT) AS DATA,                                                                                                      ');
  FqryLoteRastreamento.SQL.Add('  IF(LOTRAS.AUTOINCREM IS NULL, CONCAT(ORDDET.ORD_CODITE, DATE_FORMAT(ORD_DTACAD, "%d%m%y"), ORD_CODORD), LOT_NUMLOT) AS NUMERO_LOTE,                                 ');
  FqryLoteRastreamento.SQL.Add('  IF(LOTRAS.AUTOINCREM IS NULL, CONCAT("OP: ",DATE_FORMAT(ORD_DTACAD, "%d/%m/%y"),"-", ORD_CODORD), CONCAT(DET_NUMDOC, "-", DET_ESPDOC,"-",DET_SERIE_)) AS DOCUMENTO, ');
  FqryLoteRastreamento.SQL.Add('  IF(FOR_CODFOR IS NULL, "", CONCAT(FOR_CODFOR, "-", FOR_NOMFOR)) AS FORNECEDOR,                                                                                      ');
  FqryLoteRastreamento.SQL.Add('  IF(FATDOR.AUTOINCREM IS NULL, "", CONCAT(FDO_NUMDOC, "-", FDO_ESPDOC,"-",FDO_SERIE_)) AS PEDIDO_VENDA                                                               ');
  FqryLoteRastreamento.SQL.Add('FROM                                                                                                                                                                  ');
  FqryLoteRastreamento.SQL.Add('  CADITE                                                                                                                                                              ');
  FqryLoteRastreamento.SQL.Add('  LEFT JOIN LOTRAS ON LOT_CODITE = ITE_CODITE                                                                                                                         ');
  FqryLoteRastreamento.SQL.Add('  LEFT JOIN MOVRAS ON MOV_SEQLOT = LOTRAS.AUTOINCREM                                                                                                                  ');
  FqryLoteRastreamento.SQL.Add('  LEFT JOIN CADFOR ON FOR_CODFOR = LOT_CODFOR                                                                                                                         ');
  FqryLoteRastreamento.SQL.Add('  LEFT JOIN MOVDET ON MOVDET.AUTOINCREM = MOV_SEQDET                                                                                                                  ');
  FqryLoteRastreamento.SQL.Add('  LEFT JOIN ORDDET ON ORDDET.ORD_CODITE = ITE_CODITE AND ORD_QTDENV > 0                                                                                               ');
  FqryLoteRastreamento.SQL.Add('  LEFT JOIN ORDGER ON ORDGER.AUTOINCREM = ORD_SEQGER                                                                                                                  ');
  FqryLoteRastreamento.SQL.Add('  LEFT JOIN EXTDOR ON FDO_SEQOPI = ORDGER.AUTOINCREM                                                                                                                  ');
  FqryLoteRastreamento.SQL.Add('  LEFT JOIN FATDOR ON FATDOR.AUTOINCREM = FDO_SEQFDO                                                                                                                  ');
  FqryLoteRastreamento.SQL.Add('WHERE ITE_CODITE = :CODIGO_ITEM                                                                                                                                       ');
  FqryLoteRastreamento.SQL.Add('ORDER BY DATA DESC                                                                                                                                                    ');
end;

destructor TLoteRastreamento.Destroy;
begin
  FreeAndNil(FqryLoteRastreamento);
  inherited;
end;

procedure TLoteRastreamento.pAbreQuery(strCodigoItem : String);
begin
  FqryLoteRastreamento.Close;
  FqryLoteRastreamento.ParamByName('CODIGO_ITEM').AsString := strCodigoItem;
  FqryLoteRastreamento.Open;
end;

end.
