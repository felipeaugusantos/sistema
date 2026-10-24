unit untTControleEstoqueCat42;

interface

uses untTDadosAberturaExportacaoCat42,
     System.Generics.Collections,
     //untTRepositorioNotasFiscais,
     untTItemNotaUtilizadoCat,
     untTEstoqueCat42,
     untTypesSistema,
     SysUtils,
     StrUtils,
     Classes,
     Forms;

type
  TControleEstoqueCat42 = class
  private
    FListaEstoque: TObjectList<TEstoqueCat42>;
    FAbertura: TDadosAberturaExportacaoCat42;
    //FRepositorio: TRepositorioNotasFiscais;
    FProdutosSelecionados: string;
    FLinhaGrupoAExcluir: string;
    FArrProduto: TConsultasArray;
    FArrLinhaGrupo: TConsultasArray;
    FStlEnquadramento: TStringList;

    procedure pCarregaProdutosSelecionados;
  public
    function fCarregaDados: TObjectList<TEstoqueCat42>;

    constructor create(abertura: TDadosAberturaExportacaoCat42; arrProduto: TConsultasArray; stlEnquadramento: TStringList; arrLinhaGrupo: TConsultasArray);
    destructor Destroy; override;
  end;

implementation

uses untTRepositorioCat42,
     untFuncoes,
     untFuncoesSimples,
     untTipo,
     Uni;

{ TControleEstoqueCat42 }

constructor TControleEstoqueCat42.create(abertura: TDadosAberturaExportacaoCat42; arrProduto: TConsultasArray; stlEnquadramento: TStringList; arrLinhaGrupo: TConsultasArray);
begin
  inherited create;

  FListaEstoque := TObjectList<TEstoqueCat42>.Create;
  //FRepositorio := TRepositorioNotasFiscais.Create;
  FStlEnquadramento := stlEnquadramento;
  FArrProduto := arrProduto;
  FArrLinhaGrupo := arrLinhaGrupo;
  FAbertura := abertura;

  pCarregaProdutosSelecionados;
end;

destructor TControleEstoqueCat42.Destroy;
begin
  FListaEstoque.Free;
  //FRepositorio.Free;
  inherited;
end;

function TControleEstoqueCat42.fCarregaDados: TObjectList<TEstoqueCat42>;
  function fRetPrecoConfigurado: string;
  var
    strPreInvCat : String;
  begin
    Result := 'G.ITE_IMPULT';

    strPreInvCat := fCfgSpd('PRECO_INV_CAT42');

    if Pos(strPreInvCat, '0_2') > 0 then
      Result := 'G.ITE_PRECOM'
    else if Pos(strPreInvCat, '_3') > 0 then
    begin
      if FAbertura.blnUtilizarPrecoCompraCalcICMSSuportado then
      begin
        Result := 'IF(IFNULL(G.ITE_IMPULT, 0) > 0, G.ITE_IMPULT, ';
        Result := Result + 'IF(IFNULL(G.ITE_SALDOS, 0) > 0 AND IFNULL( ';
        Result := Result + 'G.ITE_SUBSTI, 0 ) >= 0, ';
        Result := Result + 'G.ITE_PRECOM, ';
        Result := Result + 'G.ITE_IMPULT ))';
      end else
        Result := 'G.ITE_IMPULT';
    end
    else if Pos(strPreInvCat, '_4') > 0 then
      Result := 'G.ITE_PREULT';
  end;

  function fRetPrecoConfigurado_ComST(strAlias: string = ''): string;
  var
    strPreInvCatST : String;
  begin
    Result := strAlias + 'ITE_IMPULT';

    strPreInvCatST := fCfgSpd('PRECO_INV_CAT42_COM_ST');

    if Pos(strPreInvCatST, '0_2') > 0 then
      Result := strAlias +'ITE_PRECOM'
    else if Pos(strPreInvCatST, '_3') > 0 then
    begin
      if FAbertura.blnUtilizarPrecoCompraCalcICMSSuportado then
      begin
        Result :=  IIF(fEmptyStr(strAlias), '', strAlias +'ITE_PRECOM, ');

        Result := Result + 'IF(IFNULL('+ strAlias +'ITE_IMPULT, 0) > 0, '+ strAlias +'ITE_IMPULT, ';
        Result := Result + 'IF(IFNULL('+
          strAlias +'ITE_SALDOS, 0) > 0 AND IFNULL('+
          strAlias +'ITE_SUBSTI, 0) >= 0, '+
          strAlias +'ITE_PRECOM, '+
          strAlias +'ITE_IMPULT))' +
          IIF(fEmptyStr(strAlias), '', ' AS ITE_IMPULT');
      end else
        Result := strAlias +'ITE_IMPULT';
    end
    else if Pos(strPreInvCatST, '_4') > 0 then
      Result := strAlias +'ITE_PREULT';
  end;

  function fRetStringPreco: string;
  begin
    if Pos(fCfgSpd('PRECO_INV_CAT42'), '0_1') > 0 then
    begin
      Result := Result + '    @RESULT := ' + fRetPrecoConfigurado + ', ';
      Result := Result + '    @RESULT := ( ';
      Result := Result + '      @RESULT * IFNULL((1 - (G.ITE_DESF01) / 100), 0) ';
      Result := Result + '    ), ';
      Result := Result + '    @RESULT := ( ';
      Result := Result + '      @RESULT * IFNULL((1 - (G.ITE_DESF02) / 100), 0) ';
      Result := Result + '    ), ';
      Result := Result + '    @RESULT := ( ';
      Result := Result + '      @RESULT * IFNULL((1 - (G.ITE_DESF03) / 100), 0) ';
      Result := Result + '    ), ';
      Result := Result + '    @RESULT := ( ';
      Result := Result + '      @RESULT * IFNULL((1 - (G.ITE_DESF04) / 100), 0) ';
      Result := Result + '    ), ';
      Result := Result + '    @RESULT := ( ';
      Result := Result + '      @RESULT * IFNULL((1 - (G.ITE_DESF05) / 100), 0) ';
      Result := Result + '    ), ';
      Result := Result + '    @RESULT := ( ';
      Result := Result + '      @RESULT * IFNULL((1 - (G.ITE_DESF06) / 100), 0) ';
      Result := Result + '    ), ';
      Result := Result + '    @PRECOM_LIQ_IPI := @RESULT + (@RESULT * IFNULL((G.ITE_IPIENT / 100), 0)), ';
      Result := Result + '    @PRECO_COMPRA_LIQ_IPI_FRE := ROUND( ';
      Result := Result + '      @PRECOM_LIQ_IPI + (@RESULT * IFNULL((G.ITE_FREENT / 100), 0)), ';
      Result := Result + '      2 ';
      Result := Result + '    ) AS PRECOM_CALCULADO, ';
    end
    else
      Result := Result + fRetPrecoConfigurado + ' AS PRECOM_CALCULADO, ';
  end;

  function fTrechoSQLV1: string;
  begin
    Result := '  ((G.ITE_SALDOS > 0) OR (IFNULL(M.DET_QTDITE, IFNULL(N.DET_QTDITE, "")) > 0)) ';
    if not FAbertura.blnCalculaST then
    begin
      if FAbertura.tipoConferencia = tccsim then
        Result := Result + '    AND G.ITE_SUBSTI > 0 '
      else if FAbertura.tipoConferencia = tccNao then
        Result := Result + '    AND (G.ITE_SUBSTI >= 0 OR G.ITE_SUBSTI < 0) '
      else if FAbertura.tipoConferencia = tccConf then
        Result := Result + '    AND (G.ITE_SUBSTI >= 0 OR G.ITE_SUBSTI < 0) ';
    end;
  end;

  function fTrechoSQLV2: string;
  begin

    if not FAbertura.blnCalculaST then
    begin
      if FAbertura.tipoConferencia = tccsim then
      begin

        IF FAbertura.blnGerarComSaldoZero then
          Result := '  TRUE '
        else
          Result := '  ((G.ITE_SALDOS > 0) OR (IFNULL(M.DET_QTDITE, IFNULL(N.DET_QTDITE, "")) > 0)) ';

        if (FAbertura.blnConsiderarInconsistenciaQuatro) then
          Result := Result + '    AND G.ITE_SUBSTI >= 0 '
        else
          if (FAbertura.blnConsiderarInconsistenciaCincoTransfSemSt) then
            Result := Result + '    AND G.ITE_SUBSTI >= 0 '
          else
            if (FAbertura.blnConsiderarInconsistenciaCincoEntradaSemSt) then
              Result := Result + '    AND G.ITE_SUBSTI >= 0 '
            else
              Result := Result + '    AND G.ITE_SUBSTI > 0 ';

      end
      else
      begin

        if FAbertura.tipoConferencia = tccConf then
        begin

          IF FAbertura.blnGerarComSaldoZero then
            Result := ' TRUE '
          Else
            Result := ' (((G.ITE_SALDOS > 0) OR (IFNULL(M.DET_QTDITE, IFNULL(N.DET_QTDITE, "")) > 0)) ';

          Result := Result + '     OR (G.ITE_SUBSTI >= 0 OR G.ITE_SUBSTI < 0)) ';

        end;

      end;

    end
    else
    begin

      IF FAbertura.blnGerarComSaldoZero then
        Result := '  True '
      else
        Result := '  ((G.ITE_SALDOS > 0) OR (IFNULL(M.DET_QTDITE, IFNULL(N.DET_QTDITE, "")) > 0)) ';

    end;

  end;

  function fRetAliquotasReferenteCompras(strCst, strCfop: string): Integer;
    var
      cst, cfop: string;
  begin
    cst := Copy(strCst, 1, 1);
    cfop := Copy(strCfop, 1, 1);

    if (Pos(cfop, '2_') > 0) then
    begin
      if cst = '0' then Result := 12
      else if cst = '1' then Result :=  4
      else if cst = '2' then Result :=  4
      else if cst = '3' then Result := 12
      else if cst = '4' then Result := 12
      else if cst = '5' then Result := 12
      else if cst = '6' then Result :=  4
      else if cst = '7' then Result :=  4
      else if cst = '8' then Result := 12
      else Result := 0;
    end
    else if (Pos(cfop, '1_') > 0) then
      Result := 18
    else Result := 0;
  end;

  var
    repositorioVendas: TRepositorioCat42;
    estoque: TEstoqueCat42;
    qryAux: TUniQuery;
    fltDET_VAERET: Double;
    fltITE_SUBSTI: Double;
    fltVALOR_ST_IMPULT: Double;
    fltVALOR_ST_ITE_PRECOM: Double;
    fltVALOR_CALC_IVA: Double;
    fltVALOR_ICMS_CALCULADO: Double;
    fltVALOR_ICMS_CALCULADO_UNIT: Double;
    fltABF_ALQICM_ENT_PEJ_FOR: Double;
    strDET_CLAFIS, strDET_CODFIS: string;

begin
  Result := FListaEstoque;

  FListaEstoque.Clear;

  repositorioVendas := TRepositorioCat42.Create(FAbertura, FStlEnquadramento);

  qryAux := fCriaQuery(nil);
  try
    with qryAux do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT ');
      SQL.Add('  DET_CODITE, ');
      SQL.Add('  ITE_CODUNI, ');
      SQL.Add('  ITE_DESITE, ');
      SQL.Add('  ITE_CODITE, ');
      SQL.Add('  ITE_SALDOS, ');
      SQL.Add('  ITE_CODSIT, ');

      SQL.Add('  ITE_SUBSTI, ');
      SQL.Add('  IFNULL( ' + fRetPrecoConfigurado_ComST + ', 0) AS PRECO_CONFIGURADO, ');
      SQL.Add('  PRECOM_CALCULADO, ');
      SQL.Add('  ABF_ALQICM_ENT_PEJ_EMP, ');

      SQL.Add('  ABF_ALQICM_ENT_PEJ_FOR, ');

      //## inicio ******************************************************************************** CAT42
      SQL.Add('  ABF_CODABF_FOR, ');
      SQL.Add('  ABF_CODSIT_ENT_PEJ_FOR, ');
      SQL.Add('  ABF_BASICM_ENT_PEJ_FOR, ');
      SQL.Add('  ABF_BASRET_ENT_PEJ_FOR, ');
      SQL.Add('  ABF_ALQRET_ENT_PEJ_FOR, ');
      SQL.Add('  ABF_IVA_ST_ENT_PEJ_FOR, ');
      //## fim *****************************************************************************************

      SQL.Add('  IFNULL(ROUND((((PRECOM_CALCULADO * ' + fFloatToStrPonto(FAbertura.fltValorIVA, 12, 2) + ') * ABF_ALQICM_ENT_PEJ_EMP) / 100) *  ITE_SALDOS, 2) - ROUND(((PRECOM_CALCULADO * ABF_ALQICM_ENT_PEJ_FOR) / 100) * ITE_SALDOS, 2), 0) AS VALOR_CALC_IVA, ');

      SQL.Add('  IFNULL(ROUND(((PRECOM_CALCULADO * ABF_ALQICM_ENT_PEJ_FOR) / 100) * ROUND(ITE_SALDOS, 2), 2), 0) AS VALOR_ICMS_CALCULADO, ');

      SQL.Add('  IFNULL(ROUND(((PRECOM_CALCULADO * ABF_ALQICM_ENT_PEJ_FOR) / 100), 2), 0) AS VALOR_ICMS_CALCULADO_UNIT, ');

      SQL.Add('  IFNULL(ROUND('+fRetPrecoConfigurado_ComST+' + (('+fRetPrecoConfigurado_ComST+' * ITE_SUBSTI) / 100), 2), 0) AS BASE_ST_IMPULT, ');

      SQL.Add('  IFNULL(ROUND(PRECOM_CALCULADO + ((PRECOM_CALCULADO * ITE_SUBSTI) / 100), 2), 0) AS BASE_ST_PRECOM, ');

      SQL.Add('  IFNULL(ROUND((('+fRetPrecoConfigurado_ComST+' * ITE_SUBSTI) / 100) * ITE_SALDOS, 2), 0) AS VALOR_ST_IMPULT, ');

      SQL.Add('  IFNULL(ROUND(((PRECOM_CALCULADO * ITE_SUBSTI) / 100) * ITE_SALDOS, 2), 0) AS VALOR_ST_ITE_PRECOM ');

      SQL.Add('FROM ');
      SQL.Add('  (SELECT ');
      SQL.Add('    IFNULL(M.DET_CODITE, IFNULL(N.DET_CODITE, "")) AS DET_CODITE, ');
      SQL.Add('    IFNULL(M.DET_QTDITE, IFNULL(N.DET_QTDITE, "")) AS DET_QTDITE, ');

      SQL.Add('    CASE WHEN A.ABF_ALQICM_ENT_PEJ > 0 THEN A.ABF_ALQICM_ENT_PEJ ELSE A1.ABF_ALQICM_ENT_PEJ END AS ABF_ALQICM_ENT_PEJ_EMP, ');

      SQL.Add('    G.ITE_CODUNI, ');
      SQL.Add('    G.ITE_DESITE, ');
      SQL.Add('    G.ITE_CODITE, ');
      SQL.Add('    G.ITE_CODEMP, ');

      SQL.Add(fRetPrecoConfigurado_ComST('G.')+', ');

      SQL.Add('    G.ITE_CODSIT, ');
      SQL.Add('    CASE WHEN B.ABF_ALQICM_ENT_PEJ > 0 THEN B.ABF_ALQICM_ENT_PEJ ELSE B1.ABF_ALQICM_ENT_PEJ END AS ABF_ALQICM_ENT_PEJ_FOR, ');

      //## inicio ******************************************************************************** CAT42
      SQL.Add('    CASE WHEN B.ABF_CODABF > 0 THEN B.ABF_CODABF ELSE B1.ABF_CODABF END AS ABF_CODABF_FOR, ');
      SQL.Add('    CASE WHEN B.ABF_CODSIT_ENT_PEJ > 0 THEN B.ABF_CODSIT_ENT_PEJ ELSE B1.ABF_CODSIT_ENT_PEJ END AS ABF_CODSIT_ENT_PEJ_FOR, ');
      SQL.Add('    CASE WHEN B.ABF_BASICM_ENT_PEJ > 0 THEN B.ABF_BASICM_ENT_PEJ ELSE B1.ABF_BASICM_ENT_PEJ END AS ABF_BASICM_ENT_PEJ_FOR, ');
      SQL.Add('    CASE WHEN B.ABF_BASRET_ENT_PEJ > 0 THEN B.ABF_BASRET_ENT_PEJ ELSE B1.ABF_BASRET_ENT_PEJ END AS ABF_BASRET_ENT_PEJ_FOR, ');
      SQL.Add('    CASE WHEN B.ABF_ALQRET_ENT_PEJ > 0 THEN B.ABF_ALQRET_ENT_PEJ ELSE B1.ABF_ALQRET_ENT_PEJ END AS ABF_ALQRET_ENT_PEJ_FOR, ');
      SQL.Add('    CASE WHEN B.ABF_IVA_ST_ENT_PEJ > 0 THEN B.ABF_IVA_ST_ENT_PEJ ELSE B1.ABF_IVA_ST_ENT_PEJ END AS ABF_IVA_ST_ENT_PEJ_FOR, ');
      //## fim *****************************************************************************************

      SQL.Add(fRetStringPreco);
      SQL.Add('    G.ITE_IPIENT, ');
      SQL.Add('    G.ITE_FREENT, ');
      SQL.Add('    G.ITE_SUBSTI, ');
      SQL.Add('    G.ITE_SALDOS ');
      SQL.Add('  FROM ');
      SQL.Add(FAbertura.strTabelaInventario + ' G ');

      SQL.Add('    LEFT JOIN MOVDET M ');
      SQL.Add('      ON M.DET_CODITE = G.ITE_CODITE ');
      SQL.Add('      AND M.DET_CODEMP = G.ITE_CODEMP ');
      SQL.Add('      AND M.DET_DTAENT BETWEEN :DTAINI ');
      SQL.Add('      AND :DTAFIN ');

      SQL.Add('    LEFT JOIN NOTDET N ');
      SQL.Add('      ON N.DET_CODITE = G.ITE_CODITE ');
      SQL.Add('      AND N.DET_CODEMP = G.ITE_CODEMP ');
      SQL.Add('      AND N.DET_DTAENT BETWEEN :DTAINI ');
      SQL.Add('      AND :DTAFIN ');

      SQL.Add('    LEFT JOIN CADITE ITE ');
      SQL.Add('      ON ITE.ITE_CODITE = G.ITE_CODITE ');

      SQL.Add('    LEFT JOIN ITEGER GER ');
      SQL.Add('      ON GER.ITE_CODITE = G.ITE_CODITE ');
      SQL.Add('     AND GER.ITE_CODEMP = G.ITE_CODEMP ');

      SQL.Add('  LEFT JOIN ABFICM A ');
      SQL.Add('    ON A.ABF_CODABF = G.ITE_CODABF ');
      SQL.Add('   AND A.ABF_ESTADO = "SP" ');

      SQL.Add('  LEFT JOIN ABFICM A1 ');
      if fCfgSis('TIPABF') = '1' then
        SQL.Add('    ON A1.ABF_CODABF = ITE.ITE_CODABF ')
      else
        SQL.Add('    ON A1.ABF_CODABF = GER.ITE_CODABF ');
      SQL.Add('   AND A1.ABF_ESTADO = "SP" ');

      SQL.Add('  LEFT JOIN CADFOR ');
      SQL.Add('    ON FOR_CODFOR = ITE_CODFOR ');
      SQL.Add('  LEFT JOIN CADCID ');
      SQL.Add('    ON CID_CODCID = FOR_CODCID ');

      SQL.Add('  LEFT JOIN ABFICM B ');
      SQL.Add('    ON B.ABF_CODABF = G.ITE_CODABF ');
      SQL.Add('   AND B.ABF_ESTADO = CID_ESTADO ');

      SQL.Add('  LEFT JOIN ABFICM B1 ');
      if fCfgSis('TIPABF') = '1' then
        SQL.Add('    ON B1.ABF_CODABF = ITE.ITE_CODABF ')
      else
        SQL.Add('    ON B1.ABF_CODABF = GER.ITE_CODABF ');
      SQL.Add('   AND B1.ABF_ESTADO = CID_ESTADO ');

      if FAbertura.strVersaoExecutada = 'v1' then
        SQL.Add(' WHERE ' + fTrechoSQLV1)
      else
        SQL.Add(' WHERE ' + fTrechoSQLV2);

      if not fEmptyStr(FProdutosSelecionados) then
        SQL.Add('  AND LOCATE(G.ITE_CODITE, "' + FProdutosSelecionados + '") > 0 ');

      if not fEmptyStr(FLinhaGrupoAExcluir) then
        SQL.Add('  AND LOCATE(G.ITE_CODGRU, "' + FLinhaGrupoAExcluir + '") <= 0 ');

      //# PARAMETROS PARA DEBUGAR
      //# SQL.Add('  AND G.ITE_CODITE BETWEEN 19000 AND 30000');
      //# SQL.Add('  AND LOCATE(G.ITE_CODITE, "' + '20107_' + '") > 0 ');

      SQL.Add('    AND LOCATE(RIGHT(G.ITE_CODSIT, 2), "10_60_70") > 0 ');
      SQL.Add('    AND G.ITE_CODEMP = :CODEMP ');
      SQL.Add('  GROUP BY G.ITE_CODITE, ');
      SQL.Add('           G.ITE_CODEMP) AS TAB ');

      ParamByName('CODEMP').AsString := FAbertura.empresa.strCodigo;
      ParamByName('DTAINI').AsDateTime := FAbertura.dtaDataInicial;
      ParamByName('DTAFIN').AsDateTime := FAbertura.dtaDataFinal;
      Open;

      FAbertura.lblOperacao.Caption := 'Carregando estoque...';
      FAbertura.lblOperacao.Visible := True;

      FAbertura.progressoTela.Max := RecordCount;
      FAbertura.progressoTela.Position := 0;
      Application.ProcessMessages;

      //para cada produto do inventário, será capturado todas as suas vendas e compras no mês para ressarcimento
      First;
      while not Eof do
      begin
        estoque := TEstoqueCat42.Create;

        //default true, caso configurado, ir para validação para não enviar itens com saldo total negativo. ex: compra/venda sem nota
        //estoque.blnEnviaMovimentacao := True;
        estoque.blnEnviaMovimentacao := IIF(FAbertura.tipoConferencia = tccSim, True, False);

        {$Region 'Movimentação Estoque com ITE_CODSIT igual a CST 60'}
        if ((not fEmptyStr(FieldByName('DET_CODITE').AsString)) and
          (Pos(RightStr(FieldByName('ITE_CODSIT').AsString, 2), '60_') > 0) and
          (FieldByName('ITE_SUBSTI').AsFloat = 0) and (FieldByName('PRECO_CONFIGURADO').AsFloat > 0) and
          (FAbertura.blnSaidaOutroEstado Or FAbertura.blnSaidaConsumidor) and
          (FAbertura.blnConsiderarInconsistenciaQuatro)) then
        begin
          repositorioVendas.pCarregaNotaProdutoCompra(FieldByName('DET_CODITE').AsString, estoque);

          fltDET_VAERET := fTrunca(estoque.fltSubstiCompra, 2);
          strDET_CLAFIS := estoque.strClafisCompra;
          strDET_CLAFIS := LeftStr(strDET_CLAFIS, 1);
          strDET_CODFIS := estoque.strCodSitCompra;

          if (fltDET_VAERET >= 0) then
          begin
            fltABF_ALQICM_ENT_PEJ_FOR := IIF(FieldByName('ABF_ALQICM_ENT_PEJ_FOR').AsFloat > 0,
              FieldByName('ABF_ALQICM_ENT_PEJ_FOR').AsFloat, IIF(strDET_CLAFIS = '1',
                18, 0));

            fltITE_SUBSTI := fTrunca(((fltDET_VAERET/IIF(FieldByName('PRECO_CONFIGURADO').AsFloat = 0, 1, FieldByName('PRECO_CONFIGURADO').AsFloat))*100),2);

            fltVALOR_ST_IMPULT := fTrunca(((FieldByName('PRECO_CONFIGURADO').AsFloat*fltITE_SUBSTI)/100)*FieldByName('ITE_SALDOS').AsFloat,2);
            fltVALOR_ST_ITE_PRECOM := fTrunca(((FieldByName('PRECOM_CALCULADO').AsFloat*fltITE_SUBSTI)/100)*FieldByName('ITE_SALDOS').AsFloat, 2);
            fltVALOR_CALC_IVA := fTrunca((((FieldByName('PRECOM_CALCULADO').AsFloat*FAbertura.fltValorIVA)*FieldByName('ABF_ALQICM_ENT_PEJ_EMP').AsFloat)/100)*FieldByName('ITE_SALDOS').AsFloat,2)
              -fTrunca(((FieldByName('PRECOM_CALCULADO').AsFloat*fltABF_ALQICM_ENT_PEJ_FOR)/100)*FieldByName('ITE_SALDOS').AsFloat,2) ;
            fltVALOR_ICMS_CALCULADO := fTrunca(((FieldByName('PRECOM_CALCULADO').AsFloat*fltABF_ALQICM_ENT_PEJ_FOR)/100)*FieldByName('ITE_SALDOS').AsFloat,2);
            fltVALOR_ICMS_CALCULADO_UNIT := fTrunca(((FieldByName('PRECOM_CALCULADO').AsFloat*fltABF_ALQICM_ENT_PEJ_FOR)/100),2) ;

            estoque.fltSaldoInicial := IIF(fltVALOR_ST_IMPULT > 0,
              fltVALOR_ST_IMPULT, fltVALOR_ST_ITE_PRECOM);

            estoque.fltSaldoFinal := IIF(fltVALOR_ST_IMPULT > 0,
              fltVALOR_ST_IMPULT, fltVALOR_ST_ITE_PRECOM);

            if (estoque.fltSaldoInicial <= 0) and (FAbertura.blnCalculaST) then
            begin
              estoque.fltSaldoInicial := fltVALOR_CALC_IVA;
              estoque.fltSaldoFinal := fltVALOR_CALC_IVA;
            end;

            if FAbertura.blnSomarIcmsRetido then
            begin
              estoque.fltSaldoInicial := estoque.fltSaldoInicial + fltVALOR_ICMS_CALCULADO;
              estoque.fltSaldoFinal := estoque.fltSaldoFinal + fltVALOR_ICMS_CALCULADO;
            end;

            estoque.fltVlrIcmsUnitario :=  fltVALOR_ICMS_CALCULADO_UNIT;

            estoque.fltVlrIcmsSubst := fltITE_SUBSTI;

            estoque.blnGeraSubstCompra := False;
            estoque.blnMovimentacaoSaldoNegativoCompra := IIF(fltITE_SUBSTI = 0, True, False);
          end
          else
          begin
            estoque.fltSaldoInicial := IIF(FieldByName('VALOR_ST_IMPULT').AsFloat > 0,
              FieldByName('VALOR_ST_IMPULT').AsFloat, FieldByName('VALOR_ST_ITE_PRECOM').AsFloat);

            estoque.fltSaldoFinal := IIF(FieldByName('VALOR_ST_IMPULT').AsFloat > 0,
              FieldByName('VALOR_ST_IMPULT').AsFloat, FieldByName('VALOR_ST_ITE_PRECOM').AsFloat);

            if (estoque.fltSaldoInicial <= 0) and (FAbertura.blnCalculaST) then
            begin
              estoque.fltSaldoInicial := FieldByName('VALOR_CALC_IVA').AsFloat;
              estoque.fltSaldoFinal := FieldByName('VALOR_CALC_IVA').AsFloat;
            end;

            if FAbertura.blnSomarIcmsRetido then
            begin
              estoque.fltSaldoInicial := estoque.fltSaldoInicial + FieldByName('VALOR_ICMS_CALCULADO').AsFloat;
              estoque.fltSaldoFinal := estoque.fltSaldoFinal + FieldByName('VALOR_ICMS_CALCULADO').AsFloat;
            end;

            estoque.fltVlrIcmsUnitario :=  FieldByName('VALOR_ICMS_CALCULADO_UNIT').AsFloat;
            estoque.fltVlrIcmsSubst := FieldByName('ITE_SUBSTI').AsFloat;
            estoque.blnGeraSubstCompra := False;
            estoque.blnMovimentacaoSaldoNegativoCompra := False;
            estoque.strCodSitPrimDg := LeftStr(FieldByName('ITE_CODSIT').AsString, 1);
          end;
        end
        {$EndRegion}

        else
        begin
          {$Region 'Movimentação Estoque com ABF_CODSIT_ENT_PEJ_FOR igual a CST 30'}
          if (Pos(RightStr(FieldByName('ABF_CODSIT_ENT_PEJ_FOR').AsString, 2), '30_') > 0) and
             (FAbertura.blnSaidaOutroEstado Or FAbertura.blnSaidaConsumidor) then
          begin
            repositorioVendas.pCarregaNotaProdutoCompra(FieldByName('DET_CODITE').AsString, estoque);

            fltDET_VAERET := fTrunca(estoque.fltSubstiCompra, 2);
            strDET_CLAFIS := estoque.strClafisCompra;
            strDET_CLAFIS := LeftStr(strDET_CLAFIS, 1);
            strDET_CODFIS := estoque.strCodSitCompra;

            if (fltDET_VAERET >= 0) then
            begin
              fltABF_ALQICM_ENT_PEJ_FOR := fRetAliquotasReferenteCompras(strDET_CODFIS, strDET_CLAFIS);

              fltITE_SUBSTI := fTrunca(((fltDET_VAERET/IIF(FieldByName('PRECO_CONFIGURADO').AsFloat = 0, 1, FieldByName('PRECO_CONFIGURADO').AsFloat))*100),2);

              fltVALOR_ST_IMPULT := fTrunca(((FieldByName('PRECO_CONFIGURADO').AsFloat*fltITE_SUBSTI)/100)*FieldByName('ITE_SALDOS').AsFloat,2);
              fltVALOR_ST_ITE_PRECOM := fTrunca(((FieldByName('PRECOM_CALCULADO').AsFloat*fltITE_SUBSTI)/100)*FieldByName('ITE_SALDOS').AsFloat, 2);
              fltVALOR_CALC_IVA := fTrunca((((FieldByName('PRECOM_CALCULADO').AsFloat*FAbertura.fltValorIVA)*FieldByName('ABF_ALQICM_ENT_PEJ_EMP').AsFloat)/100)*FieldByName('ITE_SALDOS').AsFloat,2)
                -fTrunca(((FieldByName('PRECOM_CALCULADO').AsFloat*fltABF_ALQICM_ENT_PEJ_FOR)/100)*FieldByName('ITE_SALDOS').AsFloat,2) ;
              fltVALOR_ICMS_CALCULADO := fTrunca(((FieldByName('PRECOM_CALCULADO').AsFloat*fltABF_ALQICM_ENT_PEJ_FOR)/100)*FieldByName('ITE_SALDOS').AsFloat,2);
              fltVALOR_ICMS_CALCULADO_UNIT := fTrunca(((FieldByName('PRECOM_CALCULADO').AsFloat*fltABF_ALQICM_ENT_PEJ_FOR)/100),2) ;

              estoque.fltSaldoInicial := IIF(fltVALOR_ST_IMPULT > 0,
                fltVALOR_ST_IMPULT, fltVALOR_ST_ITE_PRECOM);

              estoque.fltSaldoFinal := IIF(fltVALOR_ST_IMPULT > 0,
                fltVALOR_ST_IMPULT, fltVALOR_ST_ITE_PRECOM);

              if (estoque.fltSaldoInicial <= 0) and (FAbertura.blnCalculaST) then
              begin
                estoque.fltSaldoInicial := fltVALOR_CALC_IVA;
                estoque.fltSaldoFinal := fltVALOR_CALC_IVA;
              end;

              if FAbertura.blnSomarIcmsRetido then
              begin
                estoque.fltSaldoInicial := estoque.fltSaldoInicial + fltVALOR_ICMS_CALCULADO;
                estoque.fltSaldoFinal := estoque.fltSaldoFinal + fltVALOR_ICMS_CALCULADO;
              end;

              estoque.fltVlrIcmsUnitario :=  fltVALOR_ICMS_CALCULADO_UNIT;

              estoque.fltVlrIcmsSubst := fltITE_SUBSTI;

              estoque.blnGeraSubstCompra := False;
              estoque.blnMovimentacaoSaldoNegativoCompra := IIF(fltITE_SUBSTI = 0, True, False);
              estoque.strCodSitPrimDg := LeftStr(FieldByName('ITE_CODSIT').AsString, 1);
            end;

          end
          {$EndRegion}
          else
          begin
            estoque.fltSaldoInicial := IIF(FieldByName('VALOR_ST_IMPULT').AsFloat > 0,
              FieldByName('VALOR_ST_IMPULT').AsFloat, FieldByName('VALOR_ST_ITE_PRECOM').AsFloat);

            estoque.fltSaldoFinal := IIF(FieldByName('VALOR_ST_IMPULT').AsFloat > 0,
              FieldByName('VALOR_ST_IMPULT').AsFloat, FieldByName('VALOR_ST_ITE_PRECOM').AsFloat);

            if (estoque.fltSaldoInicial <= 0) and (FAbertura.blnCalculaST) then
            begin
              estoque.fltSaldoInicial := FieldByName('VALOR_CALC_IVA').AsFloat;
              estoque.fltSaldoFinal := FieldByName('VALOR_CALC_IVA').AsFloat;
            end;

            if FAbertura.blnSomarIcmsRetido then
            begin
              estoque.fltSaldoInicial := estoque.fltSaldoInicial + FieldByName('VALOR_ICMS_CALCULADO').AsFloat;
              estoque.fltSaldoFinal := estoque.fltSaldoFinal + FieldByName('VALOR_ICMS_CALCULADO').AsFloat;
            end;

            estoque.fltVlrIcmsUnitario :=  FieldByName('VALOR_ICMS_CALCULADO_UNIT').AsFloat;
            estoque.fltVlrIcmsSubst := FieldByName('ITE_SUBSTI').AsFloat;
            estoque.blnGeraSubstCompra := False;
            estoque.blnMovimentacaoSaldoNegativoCompra := False;
            estoque.strCodSitPrimDg := LeftStr(FieldByName('ITE_CODSIT').AsString, 1);
          end
        end;

        estoque.fltQtdInicial := FieldByName('ITE_SALDOS').AsFloat;
        estoque.fltQtdFinal := FieldByName('ITE_SALDOS').AsFloat;
        estoque.strUnidade := FieldByName('ITE_CODUNI').AsString;
        estoque.strProduto := FieldByName('ITE_CODITE').AsString;
        estoque.strDescricaoProduto := FieldByName('ITE_DESITE').AsString;
        estoque.blnMovimentacaoSaldoNegativo := True;

        if not fEmptyStr(FieldByName('DET_CODITE').AsString) then
        begin
          //carrega as notas de vendas por produto estocado
          repositorioVendas.pCarregaNotasPeriodoProduto(FieldByName('ITE_CODITE').AsString);

          estoque.listaRegistroCat := repositorioVendas.fRetListaNotasCat42;

          If (FAbertura.tipoConferencia = tccConf) And (FAbertura.blnSaldoMovimentacao) Then
          Begin
            If (estoque.fltQtdInicial > 0) and (estoque.fltQtdFinal >= 0) Then
            begin
              estoque.blnEnviaMovimentacao := Not repositorioVendas
                .fSaldoNegativo(FieldByName('ITE_CODITE').AsString, estoque.fltQtdInicial);

              estoque.blnMovimentacaoSaldoNegativo := estoque.blnEnviaMovimentacao;
            end;
          End
          Else If Not (FAbertura.tipoConferencia = tccConf) Then
          begin
            estoque.blnEnviaMovimentacao := repositorioVendas
              .fSaldoNegativo(FieldByName('ITE_CODITE').AsString, estoque.fltQtdInicial);

            estoque.blnMovimentacaoSaldoNegativo := estoque.blnEnviaMovimentacao;
          end;
        end;

        FAbertura.progressoTela.StepBy(1);
        Application.ProcessMessages;

        FListaEstoque.Add(estoque);

        Next;
      end;
    end;
  finally
    repositorioVendas.Free;
    qryAux.Free;
  end;
end;

procedure TControleEstoqueCat42.pCarregaProdutosSelecionados;
  var
    intContador: integer;
begin
  FProdutosSelecionados := '';

  if Assigned(FArrProduto) then
  begin
    for intContador := Low(FArrProduto) to High(FArrProduto) do
    begin
      FProdutosSelecionados := FProdutosSelecionados +  FArrProduto[intContador].strCodigo + '_';
    end;
  end;

  FLinhaGrupoAExcluir := '';

  if Assigned(FArrLinhaGrupo) then
  begin
    for intContador := Low(FArrLinhaGrupo) to High(FArrLinhaGrupo) do
    begin
      FLinhaGrupoAExcluir := FLinhaGrupoAExcluir +  FArrLinhaGrupo[intContador].strCodigo + '_';
    end;
  end;

end;

end.
