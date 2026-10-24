unit untTEstoqueCat42;

interface

uses untTDadosAberturaExportacaoCat42,
     untTRetRegistroCatTransferencia,
     System.Generics.Collections,
     System.Generics.Defaults,
     untTRegistroCat,
     untTNotaFiscal,
     untTProduto,
     SysUtils;

type
  TEstoqueCat42 = class
  private
    FListaRegistroCat: TObjectList<TRegistroCat>;
    FEnviaMovimentacao: boolean;
    FDescricaoProduto: string;
    FVlrIcmsUnitario: double;
    FVlrIcmsSubst: double;
    FSaldoInicial: double;
    FSaldoFinal: double;
    FQtdInicial: double;
    FQtdFinal: double;
    FUnidade: string;
    FProduto: string;
    FGeraSubstCompra: Boolean;
    FVlrSubstCompra: Double;
    FMovimentacaoSaldoNegativo: Boolean;
    FMovimentacaoSaldoNegativoCompra: Boolean;
    FSubstiCompra: Double;
    FClafisCompra: string;
    FCodSitCompra: string;
    FCodSitPrimDg: string;

  public
    procedure fCarregaIcmsUnitarioCompra(abertura: TDadosAberturaExportacaoCat42; var arrayUntIcmsCompra: Array of Double);
    function fCarregaIcmsUnitarioCompraSaida(abertura: TDadosAberturaExportacaoCat42; srtEmpresaTansf: string): double;

    function fOrdenaListaDataCfop: IComparer<TRegistroCat>;
    function fOrdenaListaData: IComparer<TRegistroCat>;

    destructor Destroy; override;

    property listaRegistroCat: TObjectList<TRegistroCat> read FListaRegistroCat write FListaRegistroCat;
    property blnEnviaMovimentacao: boolean read FEnviaMovimentacao write FEnviaMovimentacao;
    property strDescricaoProduto: string read FDescricaoProduto write FDescricaoProduto;
    property fltVlrIcmsUnitario: double read FVlrIcmsUnitario write FVlrIcmsUnitario;
    property fltVlrIcmsSubst: double read FVlrIcmsSubst write FVlrIcmsSubst;
    property fltSaldoInicial: double read FSaldoInicial write FSaldoInicial;
    property fltSaldoFinal: double read FSaldoFinal write FSaldoFinal;
    property fltQtdInicial: double read FQtdInicial write FQtdInicial;
    property fltQtdFinal: double read FQtdFinal write FQtdFinal;
    property strUnidade: string read FUnidade write FUnidade;
    property strProduto: string read FProduto write FProduto;
    property blnGeraSubstCompra: Boolean read FGeraSubstCompra write FGeraSubstCompra;
    property fltVlrSubstCompra: Double read FVlrSubstCompra write FVlrSubstCompra;
    property blnMovimentacaoSaldoNegativo: boolean read FMovimentacaoSaldoNegativo write FMovimentacaoSaldoNegativo;
    property blnMovimentacaoSaldoNegativoCompra: boolean read FMovimentacaoSaldoNegativoCompra write FMovimentacaoSaldoNegativoCompra;
    property fltSubstiCompra: Double read FSubstiCompra write FSubstiCompra;
    property strClafisCompra: string read FClafisCompra write FClafisCompra;
    property strCodSitCompra: string read FCodSitCompra write FCodSitCompra;
    property strCodSitPrimDg: string read FCodSitPrimDg write FCodSitPrimDg;

  end;

implementation

uses untFuncoes, Uni;

{ TEstoqueCat42 }

destructor TEstoqueCat42.Destroy;
begin
  if Assigned(FListaRegistroCat) then
    FListaRegistroCat.Free;

  inherited;
end;

procedure TEstoqueCat42.fCarregaIcmsUnitarioCompra(abertura: TDadosAberturaExportacaoCat42;
  var arrayUntIcmsCompra: Array of Double);

  function fRetCalcIcmsAbreviacao: string;
  begin
    Result := '';
    Result := Result + ' ((D.DET_TOTITE - D.DET_DESESP) * IF(IFNULL(FOR_I_E_S_, "") = "" OR FOR_CGCCPF = "2", ABF_ALQICM_ENT_PEF, ';
    Result := Result + '  IF(FOR_MATREV = "I", ABF_ALQICM_ENT_PEJ, ABF_ALQICM_ENT_PER))) / 100 ';
  end;

  var
    objTransferencia: TRetRegistroCatTransferencia;
    strEmpresaTransf: string;
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(nil);
  try
    with qryAux do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT ');

      SQL.Add('  RIGHT(D.DET_CODFIS, 2) AS DET_CODFIS, ');

      if (fCampoExiste('DETELE', 'N27_VICMSSUBSTITUTO')) then
        SQL.Add(' ROUND(IF(DET_QTDITE > 0, (IFNULL(N27_VICMSSUBSTITUTO, 0) / DET_QTDITE), 0), 2) AS N27_VICMSSUBSTITUTO, ')
      else SQL.Add(' ROUND(0, 2) AS N27_VICMSSUBSTITUTO, ');

      SQL.Add('  IF(IFNULL(N17_VICMS, IFNULL(D.DET_VALICM, 0)) > 0, ');
      SQL.Add('        IFNULL(N17_VICMS, IFNULL(D.DET_VALICM, 0)), IF(RIGHT(D.DET_CODFIS, 2) = "30", ');
      SQL.Add('        0, ' + fRetCalcIcmsAbreviacao + ')) / DET_QTDITE AS VALOR_ICMS_UNIT ');

      SQL.Add('FROM ');
      SQL.Add('  MOVDET D ');

      SQL.Add('  LEFT JOIN GERELE GLE ');
      SQL.Add('    ON GLE.B08_NNF = D.DET_NUMDOC ');
      SQL.Add('    AND IFNULL(GLE.B07_SERIE, "") = IFNULL(D.DET_SERIE_, "") ');
      SQL.Add('    AND GLE.GER_CODFOR = D.DET_CODFOR ');

      SQL.Add('  LEFT JOIN DETELE DLE ');
      SQL.Add('    ON DLE.DET_SEQGER = GLE.AUTOINCREM ');
      SQL.Add('    AND DLE.DET_CODITE = D.DET_CODITE ');

      SQL.Add('  LEFT JOIN CADFOR ');
      SQL.Add('   ON FOR_CODFOR = IFNULL(DET_CODFOR, "") ');

      SQL.Add( '  LEFT JOIN CADCID ');
      SQL.Add('   ON CID_CODCID = FOR_CODCID ');

      SQL.Add('  LEFT JOIN CADITE ITE ');
      SQL.Add('   ON ITE.ITE_CODITE = D.DET_CODITE ');

      SQL.Add('  LEFT JOIN ITEGER GER ');
      SQL.Add('   ON GER.ITE_CODITE = D.DET_CODITE ');
      SQL.Add('   AND GER.ITE_CODEMP = D.DET_CODEMP ');

      if fTabelaExiste('ABFICM') then
        SQL.Add('  LEFT JOIN ABFICM ')
      else
        SQL.Add('  LEFT JOIN CADABF ');

      if fCfgSis('TIPABF') = '1' then
        SQL.Add('  ON ABF_CODABF = ITE.ITE_CODABF ')
      else
        SQL.Add('  ON ABF_CODABF = GER.ITE_CODABF ');

      SQL.Add('  AND ABF_ESTADO = CID_ESTADO ');

      SQL.Add('WHERE D.DET_DTAENT <= :DTAFIN ');
      SQL.Add('  AND LOCATE(RIGHT(D.DET_CODFIS, 2), "10_30_60_70") > 0 ');
      SQL.Add('  AND LOCATE(DET_ESPDOC, "NF_NV_IF_IV_EL") > 0 ');
      SQL.Add('  AND TRIM(D.DET_CODFIS) <> "" ');
      SQL.Add('  AND LOCATE(D.DET_CODEMP, :CODEMP) > 0 ');
      SQL.Add('  AND LOCATE(D.DET_CLAFIS, :CLACOM) > 0 ');
      SQL.Add('  AND D.DET_CODITE = :CODITE ');
      SQL.Add('ORDER BY D.DET_DTAENT DESC ');
      SQL.Add('LIMIT 1');

      ParamByName('DTAFIN').AsDateTime := abertura.dtaDataFinal;
      ParamByName('CLACOM').AsString := VS_strClaCom;
      ParamByName('CODITE').AsString := FProduto;
      ParamByName('CODEMP').AsString := abertura.empresa.strCodigo;

      Open;

      //Result[0] := 0; //# VALOR_ICMS_UNIT
      //Result[1] := 0; //# DET_CODFIS
      //Result[2] := 0; //# CASO NÃO ENCONTRE NOTA FISCAL

      if RecordCount > 0 then
      begin
        arrayUntIcmsCompra[0] := 0;

        if FieldByName('VALOR_ICMS_UNIT').AsFloat > 0 then
          arrayUntIcmsCompra[0] := FieldByName('VALOR_ICMS_UNIT').AsFloat
        else
        begin
          objTransferencia := TRetRegistroCatTransferencia.Create;
          try
            objTransferencia.abertura := abertura;
            strEmpresaTransf:= objTransferencia.fRetRegistroSaida(FProduto);

            if not fEmptyStr(strEmpresaTransf) then
              arrayUntIcmsCompra[0] := fCarregaIcmsUnitarioCompraSaida(abertura, strEmpresaTransf);

          finally
            objTransferencia.Free;
          end;
        end;

        arrayUntIcmsCompra[1] := FieldByName('DET_CODFIS').AsFloat;
        arrayUntIcmsCompra[2] := qryAux.RecordCount;
        arrayUntIcmsCompra[3] := FieldByName('N27_VICMSSUBSTITUTO').AsFloat;
      end
      else
      begin
        arrayUntIcmsCompra[0] := 0;

        objTransferencia := TRetRegistroCatTransferencia.Create;
        try
          objTransferencia.abertura := abertura;
          strEmpresaTransf:= objTransferencia.fRetRegistroSaida(FProduto);

          if not fEmptyStr(strEmpresaTransf) then
            arrayUntIcmsCompra[0] := fCarregaIcmsUnitarioCompraSaida(abertura, strEmpresaTransf);

        finally
          objTransferencia.Free;
        end;

        arrayUntIcmsCompra[1] := 0;

        //# INICIO - AJUSTE
        //# CASO NÃO ENCONTRE NOTA DE ENTRADA NA BUSCA DO ICMS UNITÁRIO,
        //# CONTROLAR APENAS O ESTOQUE --> ZERAR O VALOR NAS COLUNAS 14, 18 E 21,
        //# OU SEJA, TER O MESMO COMPORTAMENTO  SE NÃO TIVESSE HABILITADO O ENQUADRAMENTO
        //# 4 NO QUAL CONTROLA SÓ O ESTOQUE) COMPORTAMENTO DO REQUISITO 164201.
        arrayUntIcmsCompra[2] := 0;
        arrayUntIcmsCompra[3] := 0;
        //# FIM AJUSTE
      end;

    end;
  finally
    qryAux.Free;
  end;
end;

function TEstoqueCat42.fCarregaIcmsUnitarioCompraSaida(abertura: TDadosAberturaExportacaoCat42; srtEmpresaTansf: string): double;
  function fRetCalcIcmsAbreviacao: string;
  begin
    Result := '';
    Result := Result + ' ((D.DET_TOTITE - D.DET_DESESP) * IF(IFNULL(FOR_I_E_S_, "") = "" OR FOR_CGCCPF = "2", ABF_ALQICM_ENT_PEF, ';
    Result := Result + '  IF(FOR_MATREV = "I", ABF_ALQICM_ENT_PEJ, ABF_ALQICM_ENT_PER))) / 100 ';
  end;

  var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(nil);
  try
    with qryAux do
    begin
      Close;
      SQL.Clear;

      SQL.Add('SELECT ');
      SQL.Add('  IF(IFNULL(N17_VICMS, IFNULL(D.DET_VALICM, 0)) > 0, ');
      SQL.Add('        IFNULL(N17_VICMS, IFNULL(D.DET_VALICM, 0)), IF(RIGHT(D.DET_CODFIS, 2) = "30", ');
      SQL.Add('        0, ' + fRetCalcIcmsAbreviacao + ')) / DET_QTDITE AS VALOR_ICMS_UNIT ');
      SQL.Add('FROM ');
      SQL.Add('  MOVDET D ');

      SQL.Add('  LEFT JOIN GERELE GLE ');
      SQL.Add('    ON GLE.B08_NNF = D.DET_NUMDOC ');
      SQL.Add('    AND IFNULL(GLE.B07_SERIE, "") = IFNULL(D.DET_SERIE_, "") ');
      SQL.Add('    AND GLE.GER_CODFOR = D.DET_CODFOR ');

      SQL.Add('  LEFT JOIN DETELE DLE ');
      SQL.Add('    ON DLE.DET_SEQGER = GLE.AUTOINCREM ');
      SQL.Add('    AND DLE.DET_CODITE = D.DET_CODITE ');

      SQL.Add('  LEFT JOIN CADFOR ');
      SQL.Add('   ON FOR_CODFOR = IFNULL(DET_CODFOR, "") ');

      SQL.Add( '  LEFT JOIN CADCID ');
      SQL.Add('   ON CID_CODCID = FOR_CODCID ');

      SQL.Add('  LEFT JOIN CADITE ITE ');
      SQL.Add('   ON ITE.ITE_CODITE = D.DET_CODITE ');

      SQL.Add('  LEFT JOIN ITEGER GER ');
      SQL.Add('   ON GER.ITE_CODITE = D.DET_CODITE ');
      SQL.Add('   AND GER.ITE_CODEMP = D.DET_CODEMP ');

      if fTabelaExiste('ABFICM') then
        SQL.Add('  LEFT JOIN ABFICM ')
      else
        SQL.Add('  LEFT JOIN CADABF ');

      if fCfgSis('TIPABF') = '1' then
        SQL.Add('  ON ABF_CODABF = ITE.ITE_CODABF ')
      else
        SQL.Add('  ON ABF_CODABF = GER.ITE_CODABF ');

      SQL.Add('  AND ABF_ESTADO = CID_ESTADO ');

      SQL.Add('WHERE D.DET_DTAENT <= :DTAFIN ');
      SQL.Add('  AND LOCATE(RIGHT(D.DET_CODFIS, 2), "10_30_60_70") > 0 ');
      SQL.Add('  AND LOCATE(D.DET_CODEMP, :CODEMP) > 0 ');
      SQL.Add('  AND LOCATE(D.DET_CLAFIS, :CLACOM) > 0 ');
      SQL.Add('  AND D.DET_CODITE = :CODITE ');
      SQL.Add('ORDER BY D.DET_DTAENT DESC ');
      SQL.Add('LIMIT 1');

      ParamByName('DTAFIN').AsDateTime := abertura.dtaDataFinal;
      ParamByName('CLACOM').AsString := VS_strClaCom;
      ParamByName('CODITE').AsString := FProduto;
      ParamByName('CODEMP').AsString := srtEmpresaTansf;

      Open;
      Result := FieldByName('VALOR_ICMS_UNIT').AsFloat

    end;
  finally
    qryAux.Free;
  end;
end;

function TEstoqueCat42.fOrdenaListaData: IComparer<TRegistroCat>;
  var
    criterioComparacao: TComparison<TRegistroCat>;
begin
  criterioComparacao := function(const L: TRegistroCat; const R: TRegistroCat): Integer
                        begin
                          Result := Trunc(Int(L.dtaDataNotaDadosGerais) - Int(R.dtaDataNotaDadosGerais));
                        end;

  Result := TComparer<TRegistroCat>.Construct(criterioComparacao);
end;

function TEstoqueCat42.fOrdenaListaDataCfop: IComparer<TRegistroCat>;
  var
    criterioComparacao: TComparison<TRegistroCat>;
begin
  criterioComparacao := function(const L: TRegistroCat; const R: TRegistroCat): Integer
                        begin
                          Result := L.intOrdemGeracao - R.intOrdemGeracao;

                          If Result = 0 Then
                            Result := CompareText(L.itemNota.strCfop, R.itemNota.strCfop);

                          if Result = 0 then
                            Result := Trunc(Int(L.dtaDataNotaDadosGerais) - Int(R.dtaDataNotaDadosGerais));
                        end;

  Result := TComparer<TRegistroCat>.Construct(criterioComparacao);
end;

end.
