unit untTCompraCat42;

interface

uses System.Generics.Collections, untTItemNotaUtilizadoCat, untTNotaFiscal, untTItemNotaFiscal, untICompraCat, Uni,
     untTDadosAberturaExportacaoCat42;

type
  TCompraCat42 = class(TInterfacedObject, ICompraCat)
  private
    FAbertura: TDadosAberturaExportacaoCat42;
    FQryCompras: TUniQuery;
    FAbfIcm: boolean; // se for true, fazer validação em cima da tabela "ABFICM" se não "CADABF"

    procedure pCarregarListaCreditar(itemVenda: TItemNotafiscal;
                                     listaNotasUtilizadas: TObjectList<TItemNotaUtilizadoCat>; listaComprasCredito: TObjectList<TNotaFiscal>);
    procedure pCalculaQuantidadesUtilizadas(itemVenda: TItemNotafiscal; listaNotasUtilizadas: TObjectList<TItemNotaUtilizadoCat>;
                                            listaComprasCredito: TObjectList<TNotaFiscal>);
    procedure pCarregarCompraCapturada(fltQuantidadeUtilizada: double; listaComprasCredito: TObjectList<TNotaFiscal>);

    procedure pCarregarCompras(dtaDataVenda: TDateTime; itemVenda: TItemNotaFiscal);
    function fRetValorRetido: double;
    function fRetValorIcms: double;
    function fRetSql: string;
  public
    function fRetCompraCat(dtaDataVenda: TDatetime; itemVenda: TItemNotaFiscal; listaNotasUtilizadas: TObjectList<TItemNotaUtilizadoCat>): TObjectList<TNotaFiscal>;

    constructor Create(abertura: TDadosAberturaExportacaoCat42);
    destructor Destroy; override;
  end;

implementation

uses untFuncoes;

{ TCompraCat42 }

constructor TCompraCat42.Create(abertura: TDadosAberturaExportacaoCat42);
begin
  inherited create;

  FAbertura := abertura;

  if fTabelaExiste('ABFICM') then
    FAbfIcm := True
  else
    FAbfIcm := False;

  FQryCompras := fCriaQuery(nil);
  FQryCompras.Close;
  FQryCompras.SQL.Clear;
  FQryCompras.SQL.Text := fRetSql;
end;

destructor TCompraCat42.Destroy;
begin
  FQryCompras.Free;

  inherited;
end;

function TCompraCat42.fRetCompraCat(dtaDataVenda: TDatetime; itemVenda: TItemNotaFiscal; listaNotasUtilizadas:
 TObjectList<TItemNotaUtilizadoCat>): TObjectList<TNotaFiscal>;
begin
  Result := TObjectList<TNotaFiscal>.Create;

  pCarregarCompras(dtaDataVenda, itemVenda);
  pCarregarListaCreditar(itemVenda, listaNotasUtilizadas, Result);
end;

function TCompraCat42.fRetSql: string;
  function fRetCalcIcmsAbreviacao: string;
  begin
    Result := '';
    Result := Result + ' ((DET_TOTITE - DET_DESESP) * IF(IFNULL(FOR_I_E_S_, "") = "" OR FOR_CGCCPF = "2", ABF_ALQICM_ENT_PEF, ';
    Result := Result + '  IF(FOR_MATREV = "I", ABF_ALQICM_ENT_PEJ, ABF_ALQICM_ENT_PER))) / 100 ';
  end;
begin
  Result := '';

  Result := Result + 'SELECT ';
  Result := Result + '  IFNULL(FIS_ACESSO, "") AS FIS_ACESSO, ';
  Result := Result + '  IFNULL(FIS_SERIE_, "") AS SERIE, ';
  Result := Result + '  FIS_DTAENT, ';
  Result := Result + '  FIS_NUMDOC, ';
  Result := Result + '  FIS_FORCLI, ';

  if FAbertura.blnSomarIcmsRetido then
    Result := Result + '  IFNULL(TRI.DET_VLR158, 0) + IFNULL(TRI.DET_VLGNRE, 0) + IFNULL(TRI.DET_VAERET, 0) + IFNULL(N17_VICMS, 0) AS RETIDO_N_CRED, '
  else
    Result := Result + '  IFNULL(TRI.DET_VLR158, 0) + IFNULL(TRI.DET_VLGNRE, 0) + IFNULL(TRI.DET_VAERET, 0) AS RETIDO_N_CRED, ';

  Result := Result + '  IF(IFNULL(N17_VICMS, IFNULL(D.DET_VALICM, 0)) > 0, IFNULL(N17_VICMS, IFNULL(D.DET_VALICM, 0)), ' + fRetCalcIcmsAbreviacao + ') AS VALOR_ICMS, ';
  Result := Result + '  D.AUTOINCREM AS AUTOINCREM, ';
  Result := Result + '  D.DET_CODEMP AS CODEMP, ';
  Result := Result + '  D.DET_QTDITE AS QTDITE, ';
  Result := Result + '  D.DET_CODITE AS CODITE, ';
  Result := Result + '  D.DET_VALICM AS VALICM, ';
  Result := Result + '  D.DET_CLAFIS AS CFOP, ';
  Result := Result + '  ROUND(D.DET_VALIPI + IFNULL(TRI.DET_VAEIPI, 0), 2) AS IPI_ENTRADA, ';
  Result := Result + '  (D.DET_TOTITE - D.DET_DESESP) AS VALOR_PRODUTO, ';
  Result := Result + '  CADITE.ITE_DESITE, ';
  Result := Result + '  UNI_SIGUNI ';

  Result := Result + 'FROM ';
  Result := Result + '  MOVDET D ';

  Result := Result + '  INNER JOIN CADFIS ';
  Result := Result + '    ON FIS_NUMDOC = D.DET_NUMDOC ';
  Result := Result + '    AND FIS_ESPDOC = D.DET_ESPDOC ';
  Result := Result + '    AND FIS_CODEMP = D.DET_CODEMP ';
  Result := Result + '    AND IFNULL(FIS_SERIE_, "") = IFNULL(D.DET_SERIE_, "") ';
  Result := Result + '    AND FIS_FORCLI = D.DET_CODFOR ';
  Result := Result + '    AND FIS_TIP_FC = D.DET_TIP_FC ';

  Result := Result + '  LEFT JOIN MOVTRI TRI ';
  Result := Result + '   ON TRI.DET_SEQGER = D.AUTOINCREM ';

  Result := Result + '  LEFT JOIN CADITE ';
  Result := Result + '   ON ITE_CODITE = D.DET_CODITE ';

  Result := Result + '  LEFT JOIN CADUNI ';
  Result := Result + '   ON UNI_CODUNI = D.DET_UNIDAD ';

  Result := Result + '  LEFT JOIN CADFOR ';
  Result := Result + '   ON FOR_CODFOR = IFNULL(D.DET_CODFOR, "") ';

  Result := Result + '  LEFT JOIN CADCID ';
  Result := Result + '   ON CID_CODCID = FOR_CODCID ';

  Result := Result + '  LEFT JOIN GERELE GLE ';
  Result := Result + '   ON GLE.B08_NNF = FIS_NUMDOC ';
  Result := Result + '   AND IFNULL(GLE.B07_SERIE, "") = IFNULL(FIS_SERIE_, "") ';
  Result := Result + '   AND GLE.GER_CODFOR = FIS_FORCLI ';

  Result := Result + '  LEFT JOIN DETELE DLE ';
  Result := Result + '   ON DLE.DET_SEQGER = GLE.AUTOINCREM ';
  Result := Result + '   AND DLE.DET_CODITE = D.DET_CODITE ';

  Result := Result + '  LEFT JOIN ITEGER GER ';
  Result := Result + '   ON GER.ITE_CODITE = D.DET_CODITE ';
  Result := Result + '   AND GER.ITE_CODEMP = D.DET_CODEMP ';

  Result := Result + '  LEFT JOIN CADITE ITE ';
  Result := Result + '   ON ITE.ITE_CODITE = D.DET_CODITE ';

  if FAbfIcm then
    Result := Result + '  LEFT JOIN ABFICM '
  else
    Result := Result + '  LEFT JOIN CADABF ';

  if fCfgSis('TIPABF') = '1' then
    Result := Result + '  ON ABF_CODABF = ITE.ITE_CODABF '
  else
    Result := Result + '  ON ABF_CODABF = GER.ITE_CODABF ';

  Result := Result + '  AND ABF_ESTADO = CID_ESTADO ';

  Result := Result + '  LEFT JOIN CAT_42 ';
  Result := Result + '   ON CAT_SEQGER = D.AUTOINCREM ';

  Result := Result + 'WHERE D.DET_TIP_FC = :TIP_FC ';
  Result := Result + '  AND D.DET_CODITE = :CODITE ';
  Result := Result + '  AND D.DET_DTAENT <= :DTAREF ';

  Result := Result + '  AND LOCATE(D.DET_CODEMP, :CODEMP) > 0 ';
  Result := Result + '  AND LOCATE(D.DET_ESPDOC, "NF_NV") > 0 ';
  Result := Result + '  AND IF(D.AUTOINCREM = CAT_SEQGER AND CAT_QTDUTI = CAT_TOTAL_, FALSE, TRUE) ';
  Result := Result + '  AND ((IFNULL(TRI.DET_VAERET, 0) > 0 OR IFNULL(TRI.DET_VLGNRE, 0) > 0 OR IFNULL(TRI.DET_VLR158, 0) > 0) ';
  Result := Result + '  OR (LOCATE(RIGHT(D.DET_CODFIS, 2), "10_60") > 0)) ';

  //  if FAbertura.blnCalculaST then
//    Result := Result + '  OR (LOCATE(RIGHT(D.DET_CODFIS, 2), "10_60") > 0)) '
//  else
//    Result := Result + '  AND (LOCATE(RIGHT(D.DET_CODFIS, 2), "10_60") > 0)) ';

  Result := Result + ' ORDER BY DET_DTAENT DESC, DET_HORENT DESC ';
end;

function TCompraCat42.fRetValorIcms: double;
begin
  with FQryCompras do
  begin
    Result := FieldByName('VALOR_ICMS').AsFloat;

    //se a nota não tiver Icms e estiver parametrizado para calcular
    if (Result <= 0) and (FAbertura.blnCalculaST) then
    begin
      Result := (FieldByName('VALOR_PRODUTO').AsFloat * 18) / 100;
    end;
  end;
end;

function TCompraCat42.fRetValorRetido: double;
  var
    fltValorST: double;
begin
  with FQryCompras do
  begin
    Result := FieldByName('RETIDO_N_CRED').AsFloat;

    //se a nota não tiver ST e estiver parametrizado para calcular
    if (Result <= 0) and (FAbertura.blnCalculaST) then
    begin
      //TOTAL DO PRODUTO (TOTITE - DESESP) + IPI * FATOR DE IVA INFORMADO NA TELA * ALIQUOTA INTERNA DO ESTADO
      fltValorST := (((FieldByName('VALOR_PRODUTO').AsFloat + FieldByName('IPI_ENTRADA').AsFloat) * FAbertura.fltValorIVA) * 18) / 100;

      Result := fltValorSt - fRetValorIcms;
    end;
  end;
end;

procedure TCompraCat42.pCalculaQuantidadesUtilizadas(itemVenda: TItemNotafiscal; listaNotasUtilizadas: TObjectList<TItemNotaUtilizadoCat>;
  listaComprasCredito: TObjectList<TNotaFiscal>);
  var
    fltSaldoVendido, fltSaldoComprado, fltQuantidadeUtilizada: double;
    itemNotaUtilizada: TItemNotaUtilizadoCat;
    blnAdicionar: boolean;
begin
  fltSaldoVendido := itemVenda.fltQuantidade;

  with FQryCompras do
  begin
    First;
    while (fltSaldoVendido <> 0) and (not Eof) do
    begin
      if fRetValorRetido > 0 then
      begin
        fltSaldoComprado := FieldByName('QTDITE').AsFloat;
        itemNotaUtilizada := nil;
        blnAdicionar := True;

        for itemNotaUtilizada in listaNotasUtilizadas do
        begin
          // Se existir dentro da lista a nota que será processada, verificar se a mesma já foi utilizada totalmente
          if (itemNotaUtilizada.strSeqGer = FieldByName('AUTOINCREM').AsString) then
          begin
            if itemNotaUtilizada.fltQuantidadeUtilizada = itemNotaUtilizada.fltQuantidadeTotal then
              Next
            else
            begin
              fltSaldoComprado := itemNotaUtilizada.fltQuantidadeTotal - itemNotaUtilizada.fltQuantidadeUtilizada;
              blnAdicionar := False;
              Break;
            end;
          end;
        end;

        if fltSaldoVendido < fltSaldoComprado then
        begin
          fltQuantidadeUtilizada := fltSaldoVendido;
          fltSaldoVendido := 0;
        end
        else
        begin
          fltSaldoVendido := fltSaldoVendido - fltSaldoComprado;
          fltQuantidadeUtilizada := fltSaldoComprado;
        end;

        pCarregarCompraCapturada(fltQuantidadeUtilizada, listaComprasCredito);

        //ALIMENTANDO A LISTA DE NOTAS DE ENTRADA UTILIZADAS
        if blnAdicionar then
        begin
          itemNotaUtilizada := TItemNotaUtilizadoCat.Create;
          itemNotaUtilizada.strAutoIncrem := fRetAutoIncrem('CAT_42', FieldByName('CODEMP').AsString);
          itemNotaUtilizada.strSeqGer := FieldByName('AUTOINCREM').AsString;
          itemNotaUtilizada.fltQuantidadeUtilizada := fltQuantidadeUtilizada;
          itemNotaUtilizada.fltQuantidadeTotal := FieldByName('QTDITE').AsFloat;
          listaNotasUtilizadas.Add(itemNotaUtilizada);
        end
        else
          itemNotaUtilizada.fltQuantidadeUtilizada := itemNotaUtilizada.fltQuantidadeUtilizada + fltQuantidadeUtilizada;
      end;

      Next;
    end;
  end;
end;

procedure TCompraCat42.pCarregarCompraCapturada(fltQuantidadeUtilizada: double; listaComprasCredito: TObjectList<TNotaFiscal>);
  var
    itemNota: TItemNotaFiscal;
    nota: TNotaFiscal;
begin
  with FQryCompras do
  begin
    nota := TNotaFiscal.Create;
    nota.participante.strCodigo := FieldByName('FIS_FORCLI').AsString;
    nota.strChaveAcesso := FieldByName('FIS_ACESSO').AsString;
    nota.dtaDtaEnt := FieldByName('FIS_DTAENT').AsDateTime;
    nota.strNumero := FieldByName('FIS_NUMDOC').AsString;
    nota.strSerie := FieldByName('SERIE').AsString;

    itemNota := TItemNotaFiscal.Create;
    itemNota.fltValorRetidoNaoCreditado := fRetValorRetido;
    itemNota.strAutoIncrem := FieldByName('AUTOINCREM').AsString;
    itemNota.fltQuantidadeUtilizada := fltQuantidadeUtilizada;
    itemNota.fltQuantidade := FieldByName('QTDITE').AsFloat;
    itemNota.item.strCodigo := FieldByName('CODITE').AsString;
    itemNota.item.strDescricao := FieldByName('ITE_DESITE').AsString;
    itemNota.item.unidade.strSigla := FieldByName('UNI_SIGUNI').AsString;
    itemNota.strCodIte := FieldByName('CODITE').AsString;
    itemNota.fltValIcm := fRetValorIcms;
    itemNota.strCfop := FieldByName('CFOP').AsString;

    nota.pAdicionarItem(itemNota);

    listaComprasCredito.Add(nota);
  end;
end;

procedure TCompraCat42.pCarregarCompras(dtaDataVenda: TDateTime; itemVenda: TItemNotaFiscal);
begin
  with FQryCompras do
  begin
    Close;
    ParamByName('CODITE').AsString := itemVenda.strCodIte;
    ParamByName('DTAREF').AsDateTime := dtaDataVenda;
    ParamByName('TIP_FC').AsString := 'F';
    Open;
  end;
end;

procedure TCompraCat42.pCarregarListaCreditar(itemVenda: TItemNotafiscal; listaNotasUtilizadas: TObjectList<TItemNotaUtilizadoCat>;
  listaComprasCredito: TObjectList<TNotaFiscal>);
begin
  pCalculaQuantidadesUtilizadas(itemVenda, listaNotasUtilizadas, listaComprasCredito);
end;

end.
