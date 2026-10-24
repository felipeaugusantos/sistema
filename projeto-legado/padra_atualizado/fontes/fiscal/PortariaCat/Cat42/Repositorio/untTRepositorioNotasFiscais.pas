unit untTRepositorioNotasFiscais;

interface

uses Uni, DB,
     untTipo,
     Contnrs,
     untFuncoesSimples,
     untFuncoesConsulta,
     {untTConfiguracoes,
     untTLocalArquivo,}
     untTNotaFiscal,
     {$IFDEF MSWINDOWS}
     untFuncoes,
     {$ENDIF}
     untTDadosAbertura,
     untTItemNotaFiscal,
     {untTDadosAberturaSped,}
     untTRepositorioBasico,
     untTypesSistema,
     System.StrUtils,
     System.SysUtils,
     System.Generics.Defaults,
     System.Generics.Collections,
     System.Classes;

Type
  TEcfLoja = class(TObject)
    public
      strNumSer: String;
      strCodEmp: String;
      strCodEcf: String;
  End;

Type
  TInformacoesECF = class(TObject)
    private
      stlEcfs: TObjectList;
      dtaDtaIni: TDateTime;
      dtaDtaFin: TDateTime;

      procedure pCarregaEcfsPorLoja;
      procedure pDefineDatasEcf;
    public
      constructor Create(dtaDtaIni, dtaDtaFin: TDateTime);
      destructor Destroy; override;
      procedure pProcessarInformacoes;

      function fEcfsPorLoja(const strCodEmp: String): TObjectList;
      procedure pTotaisPorLoja(const strCodEmp: String;
        Var fltVlrCon, fltBasIcm, fltValIcm: Double);
      //procedure pVerificaReducoesPendentes(strEmpresa: String; stlResult: TStrings);
      //function fReducoesOk(strEmpresa: String): Boolean;
  End;

type
  TRepositorioNotasFiscais = class(TRepositorioBasico)
    private
      FNotasSintetizadasCFOP: TObjectList<TNotaFiscalSintetizada>;
      FNotasSintetizadasCNPJ: TObjectList<TNotaFiscalSintetizada>;
      FNotasSintetizadasIBGE: TObjectList<TNotaFiscalSintetizada>;
      FNotasTransporte: TObjectList<TNotaFiscal>;
      FNotasServico: TObjectList<TNotaFiscal>;
      FTipoExportacao: TTipoExportacaoFiscal;
      FNotas: TObjectList<TNotaFiscal>;
      FExcluirCFOPUsoConsumo: boolean; //variavel manipulada para enviar não enviar notas com CFOP 1556 e 1407 (alteração feita para exportação de LFe)
      FExcluirCFOPServico: boolean; //variavel manipulada para enviar não enviar notas com CFOP 1933 e 2933
      FExcluirNotasFiscaisConsumidor: boolean; //variavel manipulada para enviar ou não enviar notas fiscais de consumidor
      FIncluirCFOPSaida: boolean; //variavel manipulada para enviar notas com CFOP 5933 e 6933
      FNotaFiscalConjugada: Boolean; //variavel manipulada para determinar se envia notas fiscais com CFOP conjugados ex: 1556 e 1933
      FNaoEnviarCte: boolean; //variavel manipulada para enviar CTE ou não pela função "fRetNotasPorPeriodo" (ps: default true)
      FClaDevCompra: String;
      FClaDevVenda: String;
      FExisteMovAux: boolean; //variavel que manipula se a MovAux existe
      arrEmp: TConsultasArray;
      FQryAuxDel: TUniQuery;

      FCALCULAR_ST_ADJUDICACAO: String;
      FENVIAR_TODAS_COMPRAS_SUBAPURACAO: String;
      FCFOP_COMPRA_REG1923: String;
      FCFOP_VENDA_REG1923: String;
      VS_strFiltroNumDoc: string;     // FILTRO PARA TESTES INTERNOS

      function fRetSqlTodasNotasServicoSintetizadas(strTipoSintetizacao: string): string;
      function fRetSqlTodasNotasFiscaisVendasAtivoImobilizadoPorPeriodo: string;
      function fRetIndicadorEmitente(strCFOP, strCNPJ: string): string;
      function fRetSqlTodasNotasFiscaisCompraPeriodoPorProduto: string;
      function fRetSqlTodasNotasServicoTomadosPorPeriodo: string;
      function fRetIndicadorOperacao(strCFOP: string): string;
      //function fRetSqlTodasNotasFiscaisSpedPorPeriodo: string;
      function fRetSqlTodasNotasTransportePorPeriodo: string;
      function fRetSqlTodasNotasFiscaisPorPeriodo: string;
      function fStrLocateEmpresa(objCodigo: TObject; arrLinha: TConsultasArray; strNomCampo,
                  strNomPar: String; blnSemAND: Boolean = False; strCodigo: String = ''): String;
      function fGetSqlConverteFiscDeCincoPraUm(strCodEmp, intClaFis: string): string;
      function fGetSqlUnionConverteFiscDeCincoPraUm(strCodEmp: String): string;
      function fSQLValorIcms(const strCampo: String): String;
      function fGetSqlFisc(strCodEmp: String; intClaFis: Integer): String;
      function fGetSqlUnion(strCodEmp: String): String;
      function fRetSqlTodasNotasFiscaisPorPeriodoDapi(strDtaIni, strDtaFin, strEmpresa: String): string;
      function fRetSqlTodasNotasCompraSubApuracaoIcms(abertura: TDadosAbertura): string;
      function fRetSqlTodasNotasSubApuracaoIcms(abertura: TDadosAbertura): string;
      function fRetSqlNotaCompraSubApuracaoIcms(abertura: TDadosAbertura): string;

      function fRetSqlNotaCompraSubApuracaoIcmsDevDocumento(abertura: TDadosAbertura; strCampoBusca: string): string;
      function fRetSqlNotaCompraSubApuracaoIcmsDocDevolucao(abertura: TDadosAbertura): string;

      function fRetSqlTodosCuponsSatPorPeriodo: string;
      function fRetSqlTodosCuponsPorPeriodo: string;

      function fRetTabelaInventario(abertura: TDadosAbertura): string;

      function fRetValorRetidoUnitarioTransferencia(strNotUlt, strCodIte: string): double;
      procedure pCarregaVariaveisConfiguracoes;

      function fGetSqlConverteFiscDeCincoPraUmDief(strCodEmp, intClaFis: string): string;
      function fGetSqlUnionConverteFiscDeCincoPraUmDief(strCodEmp: String): string;
      function fGetSqlFiscDief(strCodEmp: String; intClaFis: Integer): String;
      function fGetSqlUnionDief(strCodEmp: String): String;
      function fRetSqlTodasNotasFiscaisPorPeriodoDief(strDtaIni, strDtaFin, strEmpresa: String): string;

    public
      function fRetNotasPorPeriodo(dtaIni, dtaFin: TDateTime; strCodEmp: String; blnExcluiCFOPUsoConsumo: Boolean = False; blnExcluiCFOPServico: Boolean = False): TObjectList<TNotaFiscal>;
      function fRetNotasPorPeriodoDapi(dtaIni, dtaFin: TDateTime; strCodEmp: String; blnExcluiCFOPUsoConsumo: Boolean = False; blnExcluiCFOPServico: Boolean = False): TObjectList<TNotaFiscal>;
      function fRetNotasServicoTomadoPorPeriodo(dtaIni, dtaFin: TDateTime; strCodEmp: String; blnIncluiCFOPSaida: Boolean = False; blnNotaFiscalConjugada: Boolean = False): TObjectList<TNotaFiscal>;
      function fRetNotasServicoSintetizadas(dtaIni, dtaFin: TDateTime; strCodEmp, strTipoSintetizacao: String): TObjectList<TNotaFiscalSintetizada>;
      function fRetNotasVendasAtivoImobilizadoPorPeriodo(dtaIni, dtaFin: TDateTime; strCodEmp: string): TObjectList<TNotaFiscal>;
      function fRetNotasTransportePorPeriodo(dtaIni, dtaFin: TDateTime; strCodEmp: String): TObjectList<TNotaFiscal>;
      function fRetNotasCompraPeriodoPorProduto(abertura: TDadosAbertura; strCodIte: string): TObjectList<TNotaFiscal>;
      function fRetNotaFiscalCompraSubApuracaoIcms(abertura: TDadosAbertura; strNumDoc, strEspDoc, strCodEmp, strSerie, strCodFor, strCodIte: String): TItemNotaFiscal;

      function fRetNotaFiscalCompraSubApuracaoIcmsDevDocumento(abertura: TDadosAbertura; strDocDevolucao, strCodEmp, strCodIte, strCampoBusca: string): TItemNotaFiscal;
      function fRetNotaFiscalCompraSubApuracaoIcmsDocDevolucao(abertura: TDadosAbertura; strNumDoc, strCodEmp, strCodIte, strCampoBusca: string): TItemNotaFiscal;

      function fRetCuponsSatPorPeriodo(dtaIni, dtaFin: TDateTime; strCodEmp: string): TObjectList<TNotaFiscal>;
      function fRetCuponsPorPeriodo(dtaIni, dtaFin: TDateTime; strCodEmp: String): TObjectList<TNotaFiscal>;
      {function fRetNotasFiscaisSpedPorPeriodo(abertura: TDadosAberturaSped): TObjectList<TNotaFiscal>;}
      function fOrdenaListaData: IComparer<TNotaFiscal>;

      function fRetValorRetidoUnitario(strCfop, strNotUlt, strCodIte: string): double;

      procedure pRetNotaFiscalCompraSubApuracaoIcmsDocDevolucao(abertura: TDadosAbertura);
      procedure pCarregaNotasFiscaisCompraSubApuracaoIcmsSpedFiscal(abertura: TDadosAbertura; qryAux: TUniQuery);
      procedure pCarregaNotasFiscaisSubApuracaoIcmsSpedFiscal(abertura: TDadosAbertura; qryAux: TUniQuery);

      function fRetNotasPorPeriodoDief(dtaIni, dtaFin: TDateTime; strCodEmp: String;
        blnExcluiCFOPUsoConsumo: Boolean = False; blnExcluiCFOPServico: Boolean = False; blnExcluirNotasFiscaisConsumidor: Boolean = False): TObjectList<TNotaFiscal>;

      constructor create;
      destructor Destroy; override;

      property blnExcluirCFOPUsoConsumo: boolean read FExcluirCFOPUsoConsumo write FExcluirCFOPUsoConsumo;
      property blnExcluirCFOPServico: boolean read FExcluirCFOPServico write FExcluirCFOPServico;
      property blnExcluirNotasFiscaisConsumidor: boolean read FExcluirNotasFiscaisConsumidor write FExcluirNotasFiscaisConsumidor;
      property TipoExportacao: TTipoExportacaoFiscal read FTipoExportacao write FTipoExportacao;
      property blnIncluirCFOPSaida: boolean read FIncluirCFOPSaida write FIncluirCFOPSaida;
      property blnNotaFiscalConjugada: Boolean read FNotaFiscalConjugada write FNotaFiscalConjugada;
      property blnNaoEnviarCte: boolean read FNaoEnviarCte write FNaoEnviarCte;
  end;

implementation

const CFOP_TRANSPORTE = '1351, 1352, 1353, 1354, 1355, 1356, 1360, 1932, 2351, 2352, 2353, 2354, 2355, 2356, 2932, ' +
                  						'5351, 5352, 5353, 5354, 5355, 5356, 5357, 5359, 5360, 5932, ' +
						                  '6351, 6352, 6353, 6354, 6355, 6356, 6357, 6359, 6360, 6932';
      CFOP_USOCONSUMO = '1556, 1407';
      CFOP_SERVICO    = '1933, 2933';
      CFOP_DEVOLUCAOES = '1411';
      CFOP_VENDAS = 5000;
      CFOP_COMPRAS = 5000;

{ TRepositorioNotasFiscais }

constructor TRepositorioNotasFiscais.create;
begin
  inherited;
  pCarregaStringDevolucoes(VS_strClaDev, FClaDevVenda, FClaDevCompra);
  FNotasTransporte := TObjectList<TNotaFiscal>.Create;
  FNotasServico := TObjectList<TNotaFiscal>.Create;
  FNotasSintetizadasCFOP := TObjectList<TNotaFiscalSintetizada>.Create;
  FNotasSintetizadasCNPJ := TObjectList<TNotaFiscalSintetizada>.Create;
  FNotasSintetizadasIBGE := TObjectList<TNotaFiscalSintetizada>.Create;
  FNotas := TObjectList<TNotaFiscal>.Create;
  FNaoEnviarCte := True;
  FExcluirCFOPUsoConsumo := False;
  FExcluirCFOPServico := False;
  FExcluirNotasFiscaisConsumidor := False;
  FExisteMovAux := fTabelaExiste('MOVAUX');
  FQryAuxDel := fCriaQuery(Nil);
  pCarregaVariaveisConfiguracoes;
end;

destructor TRepositorioNotasFiscais.Destroy;
begin
  if Assigned(FNotasTransporte) then
    FNotasTransporte.Free;

  if Assigned(FNotasServico) then
    FNotasServico.Free;

  if Assigned(FNotasSintetizadasCFOP) then
    FNotasSintetizadasCFOP.Free;

  if Assigned(FNotasSintetizadasCNPJ) then
    FNotasSintetizadasCNPJ.Free;

  if Assigned(FNotasSintetizadasIBGE) then
    FNotasSintetizadasIBGE.Free;

  if Assigned(FNotas) then
    FNotas.Free;

  if Assigned(FQryAuxDel) then
    FQryAuxDel.Free;

  inherited;
end;

function TRepositorioNotasFiscais.fRetCuponsPorPeriodo(dtaIni, dtaFin: TDateTime; strCodEmp: String): TObjectList<TNotaFiscal>;
  Var
    NotaNormal: TNotaFiscal;
    NotaFiscalDetalhada: TNotaFiscalDetalhada;
    ItemNota: TItemNotaFiscal;
    intContador: Integer;
    qryAux: TUniQuery;
    strChaveAtual, strChaveNotaNormal: String;
begin
  Result := TobjectList<TNotaFiscal>.Create;

  NotaNormal := Nil;
  strChaveAtual := '';
  strChaveNotaNormal := '';

  qryAux := fCriaQuery(Nil);
  Try
    Try
      With qryAux Do
      Begin
        Close;
        SQL.Clear;

        SQL.Add(fRetSqlTodosCuponsPorPeriodo);
        ParamByName('DTAINI').AsDateTime := dtaIni;
        ParamByName('DTAFIN').AsDateTime := dtaFin;
        ParamByName('CODEMP').AsString := strCodEmp;

        Open;

        First;
        While Not Eof Do
        Begin
          strChaveAtual := fRetChaveAtual(FieldByName('FIS_SERIE_').AsString,
                                          FieldByName('FIS_TIP_FC').AsString,
                                          FieldByName('FIS_ESPDOC').AsString,
                                          FieldByName('FIS_NUMDOC').AsString,
                                          FieldByName('FIS_CODEMP').AsString,
                                          FieldByName('FIS_FORCLI').AsString);

          If strChaveAtual <> strChaveNotaNormal Then
          Begin
            strChaveNotaNormal := strChaveAtual;

            NotaNormal := TNotaFiscal.Create;

            NotaNormal.strSerie := FieldByName('FIS_SERIE_').AsString;
            NotaNormal.strTipFc := FieldByName('FIS_TIP_FC').AsString;
            NotaNormal.strNumero := FieldByName('FIS_NUMDOC').AsString;
            NotaNormal.strEspecie := FieldByName('FIS_ESPDOC').AsString;
            NotaNormal.strEmpresa := FieldByName('FIS_CODEMP').AsString;
            NotaNormal.participante.strCodigo := FieldByName('FIS_FORCLI').AsString;
            NotaNormal.participante.strNome := FieldByName('NOME').AsString;
            NotaNormal.participante.strCgcCpf := FieldByName('CNPJ').AsString;
            NotaNormal.participante.intCgcCpfInt := StrToInt64Def(FieldByName('CNPJ').AsString, 0);
            NotaNormal.strChaveAcesso := FieldByName('FIS_ACESSO').AsString;
            NotaNormal.strCodEcf := FieldByName('ECF_CODECF').AsString;
            NotaNormal.strNumUsu := FieldByName('ECF_NUMUSU').AsString;
            NotaNormal.strNumeroSerie := FieldByName('FIS_NUMSER').AsString;
            NotaNormal.strNumCoo := FieldByName('FIS_NUMCOO').AsString;
            NotaNormal.strNumCooRdz := FieldByName('RDZ_NROCOO').AsString;
            NotaNormal.strEstado := FieldByName('FIS_ESTADO').AsString;
            NotaNormal.strHistorico := FieldByName('FIS_HISTOR').AsString;
            NotaNormal.strSituacaoDocumento := FieldByName('FIS_SITDOC').AsString;
            NotaNormal.strCfop1 := FieldByName('FIS_CLFSC1').AsString;
            NotaNormal.strCfop2 := FieldByName('FIS_CLFSC2').AsString;
            NotaNormal.strCfop3 := FieldByName('FIS_CLFSC3').AsString;
            NotaNormal.strCfop4 := FieldByName('FIS_CLFSC4').AsString;
            NotaNormal.strCfop5 := FieldByName('FIS_CLFSC5').AsString;
            NotaNormal.fltVlrIcm1 := FieldByName('FIS_VLRIC1').AsFloat;
            NotaNormal.fltVlrIcm2 := FieldByName('FIS_VLRIC2').AsFloat;
            NotaNormal.fltVlrIcm3 := FieldByName('FIS_VLRIC3').AsFloat;
            NotaNormal.fltVlrIcm4 := FieldByName('FIS_VLRIC4').AsFloat;
            NotaNormal.fltVlrIcm5 := FieldByName('FIS_VLRIC5').AsFloat;
            NotaNormal.fltBasIss := 0.00;
            NotaNormal.fltAlqIss := 0.00;
            NotaNormal.fltValIss := 0.00;
            NotaNormal.fltBasPis := 0.00;
            NotaNormal.fltAlqPis := 0.00;
            NotaNormal.fltValPis := 0.00;
            NotaNormal.fltBasCof := 0.00;
            NotaNormal.fltAlqCof := 0.00;
            NotaNormal.fltValCof := 0.00;
            NotaNormal.fltFrete := FieldByName('GER_TOTFRE').AsFloat;
            NotaNormal.fltOutras := FieldByName('FIS_OUTRAS').AsFloat;
            NotaNormal.fltDesconto := FieldByName('GER_DESESP').AsFloat;
            NotaNormal.fltValorContabil := FieldByName('FIS_VLRCON').AsFloat;
            NotaNormal.dtaDtaDoc := FieldByName('FIS_DTADOC').AsDateTime;
            NotaNormal.dtaDtaEnt := FieldByName('FIS_DTAENT').AsDateTime;

            Result.Add(NotaNormal);

            For intContador := 1 to 5 Do
            Begin
              If Not fEmptyStr(FieldByName('FIS_CLFSC' + IntToStr(intContador)).AsString) Then
              Begin
                NotaFiscalDetalhada := TNotaFiscalDetalhada.Create;
                NotaFiscalDetalhada.strCfop := FieldByName('FIS_CLFSC' + IntToStr(intContador)).AsString;
                NotaFiscalDetalhada.fltValorContabil := FieldByName('FIS_VLCON' + IntToStr(intContador)).AsFloat;
                NotaFiscalDetalhada.fltBaseIcms := FieldByName('FIS_BASIC' + IntToStr(intContador)).AsFloat;
                NotaFiscalDetalhada.fltAliquotaIcms := FieldByName('FIS_ALQIC' + IntToStr(intContador)).AsFloat;
                NotaFiscalDetalhada.fltValorIcms := FieldByName('FIS_VLRIC' + IntToStr(intContador)).AsFloat;
                NotaFiscalDetalhada.fltValorOutras := FieldByName('FIS_OUTRA' + IntToStr(intContador)).AsFloat;
                NotaFiscalDetalhada.fltValorIsentas := FieldByName('FIS_ISENT' + IntToStr(intContador)).AsFloat;

                NotaNormal.notaFiscalDetalhada.Add(NotaFiscalDetalhada);
              End;
            End;
          End;

          ItemNota := TItemNotaFiscal.Create;

          ItemNota.strCodIte := FieldByName('DET_CODITE').AsString;
          ItemNota.strDesIte := FieldByName('DET_DESCRI').AsString;
          ItemNota.strUnidade := FieldByName('DET_UNIDAD').AsString;
          ItemNota.fltValorContabil := FieldByName('DET_VLRCON').AsFloat;
          ItemNota.fltValBru := FieldByName('DET_TOTITE').AsFloat;
          ItemNota.fltValFre := FieldByName('DET_TOTFRE').AsFloat;
          ItemNota.fltQuantidade := FieldByName('DET_QTDITE').AsFloat;
          ItemNota.fltValorUnitario := FieldByName('DET_UNITAR').AsFloat;
          ItemNota.strCFOP := FieldByName('DET_CLAFIS').AsString;
          ItemNota.fltValorIpi := FieldByName('DET_VALIPI').AsFloat;
          ItemNota.fltDesconto := FieldByName('DET_DESESP').AsFloat;
          ItemNota.fltDesAce := FieldByName('DET_DESACE').AsFloat;
          ItemNota.strCstIcm := FieldByName('DET_CODFIS').AsString;
          ItemNota.fltBasIcm := FieldByName('DET_BASICM').AsFloat;
          ItemNota.fltAlqIcm := FieldByName('DET_ALQICM').AsFloat;
          ItemNota.fltValIcm := FieldByName('DET_VALICM').AsFloat;
          ItemNota.fltBasRet := FieldByName('DET_BASRET').AsFloat;
          ItemNota.strCstPis := FieldByName('DET_CSTPIS').AsString;
          ItemNota.fltBasPis := FieldByName('DET_BASPIS').AsFloat;
          ItemNota.fltAlqPis := FieldByName('DET_ALQPIS').AsFloat;
          ItemNota.fltValPis := FieldByName('DET_VALPIS').AsFloat;
          ItemNota.strCstCof := FieldByName('DET_CSTCOF').AsString;
          ItemNota.fltBasCof := FieldByName('DET_BASCOF').AsFloat;
          ItemNota.fltAlqCof := FieldByName('DET_ALQCOF').AsFloat;
          ItemNota.fltValCof := FieldByName('DET_VALCOF').AsFloat;

          NotaNormal.pAdicionarItem(ItemNota);

          Next;
        End;
      End;
    Except
      On E: Exception Do
      Begin
        {$IFDEF MSWINDOWS}
        fMensagem('Atenção', E.Message, ['OK']);
        {$ENDIF}
      End;
    End;
  Finally
    qryAux.Free;
  End;
end;

function TRepositorioNotasFiscais.fRetCuponsSatPorPeriodo(dtaIni, dtaFin: TDateTime; strCodEmp: string): TObjectList<TNotaFiscal>;
  Var
    NotaNormal: TNotaFiscal;
    NotaFiscalDetalhada: TNotaFiscalDetalhada;
    ItemNota: TItemNotaFiscal;
    intContador: Integer;
    qryAux: TUniQuery;
    strChaveAtual, strChaveNotaNormal: String;
begin
  Result := TobjectList<TNotaFiscal>.Create;

  NotaNormal := Nil;
  strChaveAtual := '';
  strChaveNotaNormal := '';

  qryAux := fCriaQuery(Nil);
  Try
    Try
      With qryAux Do
      Begin
        Close;
        SQL.Clear;

        SQL.Add(fRetSqlTodosCuponsSatPorPeriodo);
        ParamByName('DTAINI').AsDateTime := dtaIni;
        ParamByName('DTAFIN').AsDateTime := dtaFin;
        ParamByName('CODEMP').AsString := strCodEmp;

        Open;

        First;
        While Not Eof Do
        Begin
          strChaveAtual := fRetChaveAtual(FieldByName('FIS_SERIE_').AsString,
                                          FieldByName('FIS_TIP_FC').AsString,
                                          FieldByName('FIS_ESPDOC').AsString,
                                          FieldByName('FIS_NUMDOC').AsString,
                                          FieldByName('FIS_CODEMP').AsString,
                                          FieldByName('FIS_FORCLI').AsString);

          If strChaveAtual <> strChaveNotaNormal Then
          Begin
            strChaveNotaNormal := strChaveAtual;

            NotaNormal := TNotaFiscal.Create;

            NotaNormal.strSerie := FieldByName('FIS_SERIE_').AsString;
            NotaNormal.strTipFc := FieldByName('FIS_TIP_FC').AsString;
            NotaNormal.strNumero := FieldByName('FIS_NUMDOC').AsString;
            NotaNormal.strEspecie := FieldByName('FIS_ESPDOC').AsString;
            NotaNormal.strEmpresa := FieldByName('FIS_CODEMP').AsString;
            NotaNormal.participante.strCodigo := FieldByName('FIS_FORCLI').AsString;
            NotaNormal.participante.strNome := FieldByName('NOME').AsString;
            NotaNormal.participante.strCgcCpf := FieldByName('CNPJ').AsString;
            NotaNormal.participante.intCgcCpfInt := StrToInt64Def(FieldByName('CNPJ').AsString, 0);
            NotaNormal.strChaveAcesso := FieldByName('FIS_ACESSO').AsString;
            NotaNormal.strNumeroSerie := FieldByName('FIS_NUMSER').AsString;
            NotaNormal.strNumCoo := FieldByName('FIS_NUMCOO').AsString;
            NotaNormal.strEstado := FieldByName('FIS_ESTADO').AsString;
            NotaNormal.strHistorico := FieldByName('FIS_HISTOR').AsString;
            NotaNormal.strSituacaoDocumento := FieldByName('FIS_SITDOC').AsString;
            NotaNormal.strCfop1 := FieldByName('FIS_CLFSC1').AsString;
            NotaNormal.strCfop2 := FieldByName('FIS_CLFSC2').AsString;
            NotaNormal.strCfop3 := FieldByName('FIS_CLFSC3').AsString;
            NotaNormal.strCfop4 := FieldByName('FIS_CLFSC4').AsString;
            NotaNormal.strCfop5 := FieldByName('FIS_CLFSC5').AsString;
            NotaNormal.fltVlrIcm1 := FieldByName('FIS_VLRIC1').AsFloat;
            NotaNormal.fltVlrIcm2 := FieldByName('FIS_VLRIC2').AsFloat;
            NotaNormal.fltVlrIcm3 := FieldByName('FIS_VLRIC3').AsFloat;
            NotaNormal.fltVlrIcm4 := FieldByName('FIS_VLRIC4').AsFloat;
            NotaNormal.fltVlrIcm5 := FieldByName('FIS_VLRIC5').AsFloat;
            NotaNormal.fltBasIss := 0.00;
            NotaNormal.fltAlqIss := 0.00;
            NotaNormal.fltValIss := 0.00;
            NotaNormal.fltBasPis := 0.00;
            NotaNormal.fltAlqPis := 0.00;
            NotaNormal.fltValPis := 0.00;
            NotaNormal.fltBasCof := 0.00;
            NotaNormal.fltAlqCof := 0.00;
            NotaNormal.fltValCof := 0.00;
            NotaNormal.fltFrete := FieldByName('GER_TOTFRE').AsFloat;
            NotaNormal.fltOutras := FieldByName('FIS_OUTRAS').AsFloat;
            NotaNormal.fltDesconto := FieldByName('GER_DESESP').AsFloat;
            NotaNormal.fltValorContabil := FieldByName('FIS_VLRCON').AsFloat;
            NotaNormal.dtaDtaDoc := FieldByName('FIS_DTADOC').AsDateTime;
            NotaNormal.dtaDtaEnt := FieldByName('FIS_DTAENT').AsDateTime;

            Result.Add(NotaNormal);

            For intContador := 1 to 5 Do
            Begin
              If Not fEmptyStr(FieldByName('FIS_CLFSC' + IntToStr(intContador)).AsString) Then
              Begin
                NotaFiscalDetalhada := TNotaFiscalDetalhada.Create;
                NotaFiscalDetalhada.strCfop := FieldByName('FIS_CLFSC' + IntToStr(intContador)).AsString;
                NotaFiscalDetalhada.fltValorContabil := FieldByName('FIS_VLCON' + IntToStr(intContador)).AsFloat;
                NotaFiscalDetalhada.fltBaseIcms := FieldByName('FIS_BASIC' + IntToStr(intContador)).AsFloat;
                NotaFiscalDetalhada.fltAliquotaIcms := FieldByName('FIS_ALQIC' + IntToStr(intContador)).AsFloat;
                NotaFiscalDetalhada.fltValorIcms := FieldByName('FIS_VLRIC' + IntToStr(intContador)).AsFloat;
                NotaFiscalDetalhada.fltValorOutras := FieldByName('FIS_OUTRA' + IntToStr(intContador)).AsFloat;
                NotaFiscalDetalhada.fltValorIsentas := FieldByName('FIS_ISENT' + IntToStr(intContador)).AsFloat;

                NotaNormal.notaFiscalDetalhada.Add(NotaFiscalDetalhada);
              End;
            End;
          End;

          ItemNota := TItemNotaFiscal.Create;

          ItemNota.strCodIte := FieldByName('DET_CODITE').AsString;
          ItemNota.strDesIte := FieldByName('DET_DESCRI').AsString;
          ItemNota.strUnidade := FieldByName('DET_UNIDAD').AsString;
          ItemNota.fltValorContabil := FieldByName('DET_VLRCON').AsFloat;
          ItemNota.fltValBru := FieldByName('DET_TOTITE').AsFloat;
          ItemNota.fltValFre := FieldByName('DET_TOTFRE').AsFloat;
          ItemNota.fltQuantidade := FieldByName('DET_QTDITE').AsFloat;
          ItemNota.fltValorUnitario := FieldByName('DET_UNITAR').AsFloat;
          ItemNota.strCFOP := FieldByName('DET_CLAFIS').AsString;
          ItemNota.fltValorIpi := FieldByName('DET_VALIPI').AsFloat;
          ItemNota.fltDesconto := FieldByName('DET_DESESP').AsFloat;
          ItemNota.fltDesAce := FieldByName('DET_DESACE').AsFloat;
          ItemNota.strCstIcm := FieldByName('DET_CODFIS').AsString;
          ItemNota.fltBasIcm := FieldByName('DET_BASICM').AsFloat;
          ItemNota.fltAlqIcm := FieldByName('DET_ALQICM').AsFloat;
          ItemNota.fltValIcm := FieldByName('DET_VALICM').AsFloat;
          ItemNota.fltBasRet := FieldByName('DET_BASRET').AsFloat;
          ItemNota.strCstPis := FieldByName('DET_CSTPIS').AsString;
          ItemNota.fltBasPis := FieldByName('DET_BASPIS').AsFloat;
          ItemNota.fltAlqPis := FieldByName('DET_ALQPIS').AsFloat;
          ItemNota.fltValPis := FieldByName('DET_VALPIS').AsFloat;
          ItemNota.strCstCof := FieldByName('DET_CSTCOF').AsString;
          ItemNota.fltBasCof := FieldByName('DET_BASCOF').AsFloat;
          ItemNota.fltAlqCof := FieldByName('DET_ALQCOF').AsFloat;
          ItemNota.fltValCof := FieldByName('DET_VALCOF').AsFloat;

          NotaNormal.pAdicionarItem(ItemNota);

          Next;
        End;
      End;
    Except
      On E: Exception Do
      Begin
        {$IFDEF MSWINDOWS}
        fMensagem('Atenção', E.Message, ['OK']);
        {$ENDIF}
      End;
    End;
  Finally
    qryAux.Free;
  End;
end;

function TRepositorioNotasFiscais.fRetIndicadorEmitente(strCFOP, strCNPJ: String): string;
var
  strCPNJEmpresa: String;
begin
  Result := '0';

  if fEmptyStr(strCfop) then
    Exit;

  {**************************************************************}
  {* Para CFOP's que começam com 5 ou mais -> Emissão própria   *}
  {* Para CFOP's que começam com menos de 5:                    *}
  {* - Se CNPJ do Cliente  = CNPJ da Empresa -> Emissão Própria *}
  {* - Se CNPJ do Cliente <> CNPJ da Empresa -> Terceiros       *}
  {**********************************************************MM**}
  if (StrToInt(LeftStr(strCFOP, 1)) >= 5) Then
  begin
    Result := '0';
  end
  else
  begin
    strCPNJEmpresa := fCadEmp('C_G_C_');

    if (strCNPJ = strCPNJEmpresa) Then
      Result := '0'
    else
      Result := '1';
  end;
end;

function TRepositorioNotasFiscais.fRetIndicadorOperacao(strCFOP: string): string;
begin

  Result := '0';

  if fEmptyStr(strCFOP) then
    Exit;

  if (IndexStr(LeftStr(strCFOP, 1), ['1','2','3']) > -1) Then
    Result := '0'
  else
    Result := '1';

end;

{function TRepositorioNotasFiscais.fRetNotasFiscaisSpedPorPeriodo(abertura: TDadosAberturaSped): TObjectList<TNotaFiscal>;
begin
  Result := TObjectList<TNotaFiscal>.Create;

  fRetSqlTodasNotasFiscaisSpedPorPeriodo;
end;}

function TRepositorioNotasFiscais.fRetNotaFiscalCompraSubApuracaoIcms(abertura: TDadosAbertura; strNumDoc, strEspDoc, strCodEmp,
  strSerie, strCodFor, strCodIte: String): TItemNotaFiscal;
  function fRetValorStCalculadoInventario(strTabelaInventario: string): double;
    var
      qryCalcSt: TUniQuery;
  begin
    qryCalcSt := fCriaQuery(nil);
    try
      with qryCalcSt do
      begin
        Close;
        SQL.Clear;
        SQL.Text := 'SELECT  ' +
                    '  ABF_IVA_ST_ENT_PEJ AS IVA_ST, ' +
                    '  @RESULT := INV.ITE_PRECOM, ' +
                    '  @RESULT := ( ' +
                    '  @RESULT * IFNULL((1 - (INV.ITE_DESF01) / 100), 0) ' +
                    '  ), ' +
                    '  @RESULT := ( ' +
                    '  @RESULT * IFNULL((1 - (INV.ITE_DESF02) / 100), 0) ' +
                    '   ), ' +
                    '  @RESULT := ( ' +
                    '  @RESULT * IFNULL((1 - (INV.ITE_DESF03) / 100), 0) ' +
                    '    ), ' +
                    '    @RESULT := ( ' +
                    '      @RESULT * IFNULL((1 - (INV.ITE_DESF04) / 100), 0) ' +
                    '    ), ' +
                    '    @RESULT := ( ' +
                    '      @RESULT * IFNULL((1 - (INV.ITE_DESF05) / 100), 0) ' +
                    '    ), ' +
                    '    @RESULT := ( ' +
                    '      @RESULT * IFNULL((1 - (INV.ITE_DESF06) / 100), 0) ' +
                    '    ), ' +
                    '    @PRECOM_LIQ_IPI := @RESULT + (@RESULT * IFNULL((INV.ITE_IPIENT / 100), 0)), ' +
                    '    @PRECO_COMPRA_LIQ_IPI_FRE := ROUND( ' +
                    '      @PRECOM_LIQ_IPI + (@RESULT * IFNULL((INV.ITE_FREENT / 100), 0)), ' +
                    '      2 ' +
                    '    ) AS PRECOM ' +
                    'FROM ' +
                       strTabelaInventario + ' AS INV ' +

                    '  LEFT JOIN ABFICM ' +
                    '    ON ABF_CODABF = INV.ITE_CODABF ' +
                    '    AND ABF_ESTADO = "RS" ' +

                    ' WHERE LOCATE(RIGHT(INV.ITE_CODSIT, 2), "10_60_70") > 0 ' +
                    '   AND INV.ITE_CODEMP = :CODEMP ' +
                    '   AND INV.ITE_CODITE = :CODITE ' +
                    '   AND INV.ITE_SALDOS > 0 ';

        ParamByName('CODEMP').AsString := VS_strCodEmp;
        ParamByName('CODITE').AsString := strCodIte;
        Open;

        Result := ((FieldByName('IVA_ST').AsFloat * FieldByName('PRECOM').AsFloat) * 18) / 100;
      end;
    finally
      qryCalcSt.Free;
    end;
  end;

  var
    qryAux: TUniQuery;
begin
  Result := nil;

  if not fEmptyStr(Trim(strNumDoc)) then
  begin

    qryAux := fCriaQuery(nil);
    try
      with qryAux do
      begin
        Close;
        SQL.Clear;
        SQL.Text := fRetSqlNotaCompraSubApuracaoIcms(abertura);
        ParamByName('NUMDOC').AsString := strNumDoc;
        ParamByName('CODEMP').AsString := strCodEmp;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ParamByName('CODFOR').AsString := strCodFor;
        ParamByName('SERIE').AsString := strSerie;
        ParamByName('CODITE').AsString := strCodIte;
        Open;

        First;
        while not Eof do
        begin
          Result := TItemNotaFiscal.Create;

          if (FCALCULAR_ST_ADJUDICACAO = '1') and
             (not fEmptyStr(FieldByName('DOCUMENTO').AsString)) and
             (FieldByName('ST_UNITARIA').AsFloat <= 0) then
            Result.fltValorRetidoNaoCreditadoUnitario := (FieldByName('COMLIQ_IPI_FRETE_IVA').AsFloat * 18) / 100
          else
            Result.fltValorRetidoNaoCreditadoUnitario := FieldByName('ST_UNITARIA').AsFloat;

          if ((FieldByName('BAERET').AsFloat + FieldByName('BASRET').AsFloat) > 0) then
            Result.fltCpValorEfetivo := FieldByName('BAERET').AsFloat + FieldByName('BASRET').AsFloat
          else
            Result.fltCpValorEfetivo := IIF(FieldByName('ST_UNITARIA').AsFloat <= 0, FieldByName('COMLIQ_IPI_FRETE_IVA').AsFloat,
                                                                                     Result.fltValorRetidoNaoCreditadoUnitario);

          Result.strChaveAcesso := FieldByName('ACESSO').AsString;
          Result.strNumDoc := FieldByName('DOCUMENTO').AsString;
          Result.dtaDtaEnt := FieldByName('DTAENT').AsDateTime;
          Result.strModelo := FieldByName('MODELO').AsString;
          Result.strCodIte := FieldByName('CODITE').AsString;
          Result.strSerie := FieldByName('SERIE').AsString;
          Result.strTipFc := FieldByName('TIP_FC').AsString;
          Result.strCfop := FieldByName('CLAFIS').AsString;
          Result.fltQuantidade := FieldByName('QTDITE').AsFloat;

          Result.participante.strCodigo := FieldByName('FORCLI').AsString;
          Result.participante.strNome := FieldByName('NOME').AsString;
          Result.participante.strCgcCpf := FieldByName('C_G_C_').AsString;
          Result.participante.strCodCid := FieldByName('CODCID').AsString;

          Next;
        end;
      end;
    except
      on e:exception Do
      begin
        qryAux.Free;
      end;
    end;
  end;
end;

function TRepositorioNotasFiscais.fRetNotaFiscalCompraSubApuracaoIcmsDocDevolucao(
  abertura: TDadosAbertura; strNumDoc, strCodEmp, strCodIte, strCampoBusca: string): TItemNotaFiscal;
  function fRetValorStCalculadoInventario(strTabelaInventario: string): double;
    var
      qryCalcSt: TUniQuery;
  begin
    qryCalcSt := fCriaQuery(nil);
    try
      with qryCalcSt do
      begin
        Close;
        SQL.Clear;
        SQL.Text := 'SELECT  ' +
                    '  ABF_IVA_ST_ENT_PEJ AS IVA_ST, ' +
                    '  @RESULT := INV.ITE_PRECOM, ' +
                    '  @RESULT := ( ' +
                    '  @RESULT * IFNULL((1 - (INV.ITE_DESF01) / 100), 0) ' +
                    '  ), ' +
                    '  @RESULT := ( ' +
                    '  @RESULT * IFNULL((1 - (INV.ITE_DESF02) / 100), 0) ' +
                    '   ), ' +
                    '  @RESULT := ( ' +
                    '  @RESULT * IFNULL((1 - (INV.ITE_DESF03) / 100), 0) ' +
                    '    ), ' +
                    '    @RESULT := ( ' +
                    '      @RESULT * IFNULL((1 - (INV.ITE_DESF04) / 100), 0) ' +
                    '    ), ' +
                    '    @RESULT := ( ' +
                    '      @RESULT * IFNULL((1 - (INV.ITE_DESF05) / 100), 0) ' +
                    '    ), ' +
                    '    @RESULT := ( ' +
                    '      @RESULT * IFNULL((1 - (INV.ITE_DESF06) / 100), 0) ' +
                    '    ), ' +
                    '    @PRECOM_LIQ_IPI := @RESULT + (@RESULT * IFNULL((INV.ITE_IPIENT / 100), 0)), ' +
                    '    @PRECO_COMPRA_LIQ_IPI_FRE := ROUND( ' +
                    '      @PRECOM_LIQ_IPI + (@RESULT * IFNULL((INV.ITE_FREENT / 100), 0)), ' +
                    '      2 ' +
                    '    ) AS PRECOM ' +
                    'FROM ' +
                       strTabelaInventario + ' AS INV ' +

                    '  LEFT JOIN ABFICM ' +
                    '    ON ABF_CODABF = INV.ITE_CODABF ' +
                    '    AND ABF_ESTADO = "RS" ' +

                    ' WHERE LOCATE(RIGHT(INV.ITE_CODSIT, 2), "10_60_70") > 0 ' +
                    '   AND INV.ITE_CODEMP = :CODEMP ' +
                    '   AND INV.ITE_CODITE = :CODITE ' +
                    '   AND INV.ITE_SALDOS > 0 ';

        ParamByName('CODEMP').AsString := VS_strCodEmp;
        ParamByName('CODITE').AsString := strCodIte;
        Open;

        Result := ((FieldByName('IVA_ST').AsFloat * FieldByName('PRECOM').AsFloat) * 18) / 100;
      end;
    finally
      qryCalcSt.Free;
    end;
  end;

  var
    strFilter: string;
begin
  //#5

  Result := nil;

  try
    with FQryAuxDel do
    begin
      strFilter := strCampoBusca + ' = ' + QuotedStr(strNumDoc) +
                   ' AND CODITE = ' + QuotedStr(strCodIte);
      Filter := strFilter;
      Filtered := True;

      First;
      while not Eof do
      begin
        Result := TItemNotaFiscal.Create;

        if (FCALCULAR_ST_ADJUDICACAO = '1') and
           (not fEmptyStr(FieldByName('DOCUMENTO').AsString)) and
           (FieldByName('ST_UNITARIA').AsFloat <= 0) then
          Result.fltValorRetidoNaoCreditadoUnitario := (FieldByName('COMLIQ_IPI_FRETE_IVA').AsFloat * 18) / 100
        else
          Result.fltValorRetidoNaoCreditadoUnitario := FieldByName('ST_UNITARIA').AsFloat;

        Result.strChaveAcesso := FieldByName('ACESSO').AsString;
        Result.strNumDoc := FieldByName('DOCUMENTO').AsString;
        Result.dtaDtaEnt := FieldByName('DTAENT').AsDateTime;
        Result.strModelo := FieldByName('MODELO').AsString;
        Result.strCodIte := FieldByName('CODITE').AsString;
        Result.strSerie := FieldByName('SERIE').AsString;
        Result.strTipFc := FieldByName('TIP_FC').AsString;
        Result.strCfop := FieldByName('CLAFIS').AsString;
        Result.fltQuantidade := FieldByName('QTDITE').AsFloat;
        Result.fltValorEfetivo := FieldByName('VICMEF').AsFloat;
        Result.fltBaseEfetivo := FieldByName('BICMEF').AsFloat;
        Result.fltAliqEfetivo :=  FieldByName('AICMEF').AsFloat;

        Result.participante.strCodigo := FieldByName('FORCLI').AsString;
        Result.participante.strNome := FieldByName('NOME').AsString;
        Result.participante.strCgcCpf := FieldByName('C_G_C_').AsString;

        Next;
      end;
    end;
  except
    on e:exception Do
    begin

    end;
  end;
end;

function TRepositorioNotasFiscais.fRetNotaFiscalCompraSubApuracaoIcmsDevDocumento(abertura: TDadosAbertura; strDocDevolucao,
  strCodEmp, strCodIte, strCampoBusca: string): TItemNotaFiscal;
  function fRetValorStCalculadoInventario(strTabelaInventario: string): double;
    var
      qryCalcSt: TUniQuery;
  begin
    qryCalcSt := fCriaQuery(nil);
    try
      with qryCalcSt do
      begin
        Close;
        SQL.Clear;
        SQL.Text := 'SELECT  ' +
                    '  ABF_IVA_ST_ENT_PEJ AS IVA_ST, ' +
                    '  @RESULT := INV.ITE_PRECOM, ' +
                    '  @RESULT := ( ' +
                    '  @RESULT * IFNULL((1 - (INV.ITE_DESF01) / 100), 0) ' +
                    '  ), ' +
                    '  @RESULT := ( ' +
                    '  @RESULT * IFNULL((1 - (INV.ITE_DESF02) / 100), 0) ' +
                    '   ), ' +
                    '  @RESULT := ( ' +
                    '  @RESULT * IFNULL((1 - (INV.ITE_DESF03) / 100), 0) ' +
                    '    ), ' +
                    '    @RESULT := ( ' +
                    '      @RESULT * IFNULL((1 - (INV.ITE_DESF04) / 100), 0) ' +
                    '    ), ' +
                    '    @RESULT := ( ' +
                    '      @RESULT * IFNULL((1 - (INV.ITE_DESF05) / 100), 0) ' +
                    '    ), ' +
                    '    @RESULT := ( ' +
                    '      @RESULT * IFNULL((1 - (INV.ITE_DESF06) / 100), 0) ' +
                    '    ), ' +
                    '    @PRECOM_LIQ_IPI := @RESULT + (@RESULT * IFNULL((INV.ITE_IPIENT / 100), 0)), ' +
                    '    @PRECO_COMPRA_LIQ_IPI_FRE := ROUND( ' +
                    '      @PRECOM_LIQ_IPI + (@RESULT * IFNULL((INV.ITE_FREENT / 100), 0)), ' +
                    '      2 ' +
                    '    ) AS PRECOM ' +
                    'FROM ' +
                       strTabelaInventario + ' AS INV ' +

                    '  LEFT JOIN ABFICM ' +
                    '    ON ABF_CODABF = INV.ITE_CODABF ' +
                    '    AND ABF_ESTADO = "RS" ' +

                    ' WHERE LOCATE(RIGHT(INV.ITE_CODSIT, 2), "10_60_70") > 0 ' +
                    '   AND INV.ITE_CODEMP = :CODEMP ' +
                    '   AND INV.ITE_CODITE = :CODITE ' +
                    '   AND INV.ITE_SALDOS > 0 ';

        ParamByName('CODEMP').AsString := VS_strCodEmp;
        ParamByName('CODITE').AsString := strCodIte;
        Open;

        Result := ((FieldByName('IVA_ST').AsFloat * FieldByName('PRECOM').AsFloat) * 18) / 100;
      end;
    finally
      qryCalcSt.Free;
    end;
  end;

  var
    qryAux: TUniQuery;
begin
  Result := nil;

  if not fEmptyStr(Trim(strDocDevolucao)) then
  begin

    qryAux := fCriaQuery(nil);
    try
      with qryAux do
      begin
        Close;
        SQL.Clear;
        SQL.Text := fRetSqlNotaCompraSubApuracaoIcmsDevDocumento(abertura, strcampoBusca);
        ParamByName('DTAINI').AsDateTime := abertura.dtaDataInicial;
        ParamByName('DTAFIN').AsDateTime := abertura.dtaDataFinal;
        ParamByName('NUMDOC').AsString := strDocDevolucao;
        ParamByName('CODEMP').AsString := strCodEmp;
        ParamByName('CODITE').AsString := strCodIte;
        Open;

        First;
        while not Eof do
        begin
          Result := TItemNotaFiscal.Create;

          if (FCALCULAR_ST_ADJUDICACAO = '1') and
             (not fEmptyStr(FieldByName('DOCUMENTO').AsString)) and
             (FieldByName('ST_UNITARIA').AsFloat <= 0) then
            Result.fltValorRetidoNaoCreditadoUnitario := (FieldByName('COMLIQ_IPI_FRETE_IVA').AsFloat * 18) / 100
          else
            Result.fltValorRetidoNaoCreditadoUnitario := FieldByName('ST_UNITARIA').AsFloat;

          Result.strChaveAcesso := FieldByName('ACESSO').AsString;
          Result.strNumDoc := FieldByName('DOCUMENTO').AsString;
          Result.dtaDtaEnt := FieldByName('DTAENT').AsDateTime;
          Result.strModelo := FieldByName('MODELO').AsString;
          Result.strCodIte := FieldByName('CODITE').AsString;
          Result.strSerie := FieldByName('SERIE').AsString;
          Result.strTipFc := FieldByName('TIP_FC').AsString;
          Result.strCfop := FieldByName('CLAFIS').AsString;
          Result.fltQuantidade := FieldByName('QTDITE').AsFloat;
          Result.fltValorEfetivo := FieldByName('VICMEF').AsFloat;
          Result.fltBaseEfetivo := FieldByName('BICMEF').AsFloat;
          Result.fltAliqEfetivo :=  FieldByName('AICMEF').AsFloat;

          Result.participante.strCodigo := FieldByName('FORCLI').AsString;
          Result.participante.strNome := FieldByName('NOME').AsString;
          Result.participante.strCgcCpf := FieldByName('C_G_C_').AsString;
          Result.participante.strCodCid := FieldByName('CODCID').AsString;

          Next;
        end;
      end;
    except
      on e:exception Do
      begin
        qryAux.Free;
      end;
    end;
  end;
end;

function TRepositorioNotasFiscais.fRetNotasCompraPeriodoPorProduto(abertura: TDadosAbertura; strCodIte: string): TObjectList<TNotaFiscal>;
  var
    NotaFiscalDetalhada: TNotaFiscalDetalhada;
    strChaveAtual, strChaveNotaNormal: String;
    ItemNota: TItemNotaFiscal;
    NotaNormal: TNotaFiscal;
    intContador: Integer;
    qryAux: TUniQuery;
begin
  FNotas.Clear;
  Result := FNotas;

  strChaveNotaNormal := '';
  strChaveAtual := '';
  NotaNormal := Nil;

  qryAux := fCriaQuery(Nil);
  Try
    Try
      With qryAux Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(fRetSqlTodasNotasFiscaisCompraPeriodoPorProduto);
        ParamByName('CODEMP').AsString := abertura.empresa.strCodigo;
        ParamByName('DTAINI').AsDateTime := abertura.dtaDataInicial;
        ParamByName('DTAFIN').AsDateTime := abertura.dtaDataFinal;
        ParamByName('CFOP').AsString := VS_strClaCom;
        ParamByName('CODITE').AsString := strCodIte;
        Open;

        First;
        While Not Eof Do
        Begin
          strChaveAtual := fRetChaveAtual(FieldByName('FIS_SERIE_').AsString,
                                          FieldByName('FIS_TIP_FC').AsString,
                                          FieldByName('FIS_ESPDOC').AsString,
                                          FieldByName('FIS_NUMDOC').AsString,
                                          FieldByName('FIS_CODEMP').AsString,
                                          FieldByName('FIS_FORCLI').AsString);

          If strChaveAtual <> strChaveNotaNormal Then
          Begin
            strChaveNotaNormal := strChaveAtual;

            NotaNormal := TNotaFiscal.Create;

            NotaNormal.strSerie := FieldByName('FIS_SERIE_').AsString;
            NotaNormal.strTipFc := FieldByName('FIS_TIP_FC').AsString;
            NotaNormal.strNumero := FieldByName('FIS_NUMDOC').AsString;
            NotaNormal.strEspecie := FieldByName('FIS_ESPDOC').AsString;
            NotaNormal.strEmpresa := FieldByName('FIS_CODEMP').AsString;
            NotaNormal.participante.strCodigo := FieldByName('FIS_FORCLI').AsString;
            NotaNormal.participante.strNome := FieldByName('NOME').AsString;
            NotaNormal.participante.strCgcCpf := FieldByName('CNPJ').AsString;
            NotaNormal.participante.intCgcCpfInt := StrToInt64Def(FieldByName('CNPJ').AsString, 0);
            NotaNormal.participante.cidade.strCodigoIbge := FieldByName('CODIGO_IBGE').AsString;
            NotaNormal.participante.cidade.strEstado := FieldByName('UF').AsString;
            NotaNormal.strChaveAcesso := FieldByName('FIS_ACESSO').AsString;
            NotaNormal.strEstado := FieldByName('FIS_ESTADO').AsString;
            NotaNormal.strHistorico := FieldByName('FIS_HISTOR').AsString;
            NotaNormal.strModelo := FieldByName('FIS_DOCMOD').AsString;
            NotaNormal.strSituacaoDocumento := FieldByName('FIS_SITDOC').AsString;
            NotaNormal.strCfop1 := FieldByName('FIS_CLFSC1').AsString;
            NotaNormal.strCfop2 := FieldByName('FIS_CLFSC2').AsString;
            NotaNormal.strCfop3 := FieldByName('FIS_CLFSC3').AsString;
            NotaNormal.strCfop4 := FieldByName('FIS_CLFSC4').AsString;
            NotaNormal.strCfop5 := FieldByName('FIS_CLFSC5').AsString;
            NotaNormal.strCondicaoPagamento := FieldByName('FIS_COND_PG').AsString;
            NotaNormal.strTipoFrete := FieldByName('GER_TIPO_FRETE').AsString;
            NotaNormal.fltVlrIcm1 := FieldByName('FIS_VLRIC1').AsFloat;
            NotaNormal.fltVlrIcm2 := FieldByName('FIS_VLRIC2').AsFloat;
            NotaNormal.fltVlrIcm3 := FieldByName('FIS_VLRIC3').AsFloat;
            NotaNormal.fltVlrIcm4 := FieldByName('FIS_VLRIC4').AsFloat;
            NotaNormal.fltVlrIcm5 := FieldByName('FIS_VLRIC5').AsFloat;
            NotaNormal.fltBasIss := 0.00;
            NotaNormal.fltAlqIss := 0.00;
            NotaNormal.fltValIss := 0.00;
            NotaNormal.fltBasPis := 0.00;
            NotaNormal.fltAlqPis := 0.00;
            NotaNormal.fltValPis := 0.00;
            NotaNormal.fltBasCof := 0.00;
            NotaNormal.fltAlqCof := 0.00;
            NotaNormal.fltValCof := 0.00;
            NotaNormal.fltFrete := FieldByName('GER_TOTFRE').AsFloat;
            NotaNormal.fltOutras := FieldByName('FIS_OUTRAS').AsFloat;
            NotaNormal.fltDesconto := FieldByName('GER_DESESP').AsFloat;
            NotaNormal.fltValorContabil := FieldByName('FIS_VLRCON').AsFloat;
            NotaNormal.dtaDtaDoc := FieldByName('FIS_DTADOC').AsDateTime;
            NotaNormal.dtaDtaEnt := FieldByName('FIS_DTAENT').AsDateTime;
            NotaNormal.transportadora.strInscricaoEstadual := FieldByName('TRA_I_E_S_').AsString;
            NotaNormal.transportadora.strUFPlaca := FieldByName('GER_TOTFRE').AsString;
            NotaNormal.transportadora.strPlaca := FieldByName('TRA_NUMPLA').AsString;
            NotaNormal.transportadora.strCnpj := FieldByName('TRA_C_G_C_').AsString;
            NotaNormal.transportadora.cidade.strEstado := FieldByName('TRA_UF').AsString;
            NotaNormal.strIndicadorEmitente := fRetIndicadorEmitente(FieldByName('FIS_CLFSC1').AsString,
                                                                     FieldByName('CNPJ').AsString);

            Result.Add(NotaNormal);

            For intContador := 1 to 5 Do
            Begin
              If Not fEmptyStr(FieldByName('FIS_CLFSC' + IntToStr(intContador)).AsString) Then
              Begin
                NotaFiscalDetalhada := TNotaFiscalDetalhada.Create;
                NotaFiscalDetalhada.strCfop := FieldByName('FIS_CLFSC' + IntToStr(intContador)).AsString;
                NotaFiscalDetalhada.fltValorContabil := FieldByName('FIS_VLCON' + IntToStr(intContador)).AsFloat;
                NotaFiscalDetalhada.fltBaseIcms := FieldByName('FIS_BASIC' + IntToStr(intContador)).AsFloat;
                NotaFiscalDetalhada.fltAliquotaIcms := FieldByName('FIS_ALQIC' + IntToStr(intContador)).AsFloat;
                NotaFiscalDetalhada.fltValorIcms := FieldByName('FIS_VLRIC' + IntToStr(intContador)).AsFloat;
                NotaFiscalDetalhada.fltValorOutras := FieldByName('FIS_OUTRA' + IntToStr(intContador)).AsFloat;
                NotaFiscalDetalhada.fltValorIsentas := FieldByName('FIS_ISENT' + IntToStr(intContador)).AsFloat;
                NotaFiscalDetalhada.fltBaseIcmsST := FieldByName('FIS_BCRET' + IntToStr(intContador)).AsFloat;
                NotaFiscalDetalhada.fltValorIcmsST := FieldByName('FIS_RETID' + IntToStr(intContador)).AsFloat;
                NotaFiscalDetalhada.fltBaseIpi := FieldByName('FIS_BASIP' + IntToStr(intContador)).AsFloat;
                NotaFiscalDetalhada.fltValorIpi := FieldByName('FIS_VLRIP' + IntToStr(intContador)).AsFloat;

                NotaNormal.notaFiscalDetalhada.Add(NotaFiscalDetalhada);
              End;
            End;
          End;

          if not fEmptyStr(FieldByName('DET_CODITE').AsString) then
          begin
            ItemNota := TItemNotaFiscal.Create;

            ItemNota.strCodIte := FieldByName('DET_CODITE').AsString;
            ItemNota.strDesIte := FieldByName('DET_DESCRI').AsString;
            ItemNota.strUnidade := FieldByName('DET_UNIDAD').AsString;
            ItemNota.fltValorContabil := FieldByName('DET_VLRCON').AsFloat;
            ItemNota.fltValBru := FieldByName('DET_TOTITE').AsFloat;
            ItemNota.fltValFre := FieldByName('DET_TOTFRE').AsFloat;
            ItemNota.fltQuantidade := FieldByName('DET_QTDITE').AsFloat;
            ItemNota.fltValorUnitario := FieldByName('DET_UNITAR').AsFloat;
            ItemNota.strCFOP := FieldByName('DET_CLAFIS').AsString;
            ItemNota.fltValorIpi := FieldByName('DET_VALIPI').AsFloat;
            ItemNota.fltDesconto := FieldByName('DET_DESESP').AsFloat;
            ItemNota.fltDesAce := FieldByName('DET_DESACE').AsFloat;
            ItemNota.strCstIcm := FieldByName('DET_CODFIS').AsString;
            ItemNota.fltBasIcm := FieldByName('DET_BASICM').AsFloat;
            ItemNota.fltAlqIcm := FieldByName('DET_ALQICM').AsFloat;
            ItemNota.fltValIcm := FieldByName('DET_VALICM').AsFloat;
            ItemNota.strCstIpi := FieldByName('DET_CSTIPI').AsString;
            ItemNota.fltBasIpi := FieldByName('DET_BASIPI').AsFloat;
            ItemNota.fltAlqIpi := FieldByName('DET_ALQIPI').AsFloat;
            ItemNota.fltValIpi := FieldByName('DET_VALIPI').AsFloat;
            ItemNota.fltValorIpiNaoCreditado := FieldByName('DET_VAEIPI').AsFloat;
            ItemNota.fltBasRet := FieldByName('DET_BASRET').AsFloat;
            ItemNota.fltValRet := FieldByName('DET_VALRET').AsFloat;
            ItemNota.fltValorRetidoNaoCreditado := FieldByName('DET_VAERET').AsFloat;
            ItemNota.fltOutIcm := FieldByName('DET_OUTICM').AsFloat;
            ItemNota.strCstPis := FieldByName('DET_CSTPIS').AsString;
            ItemNota.fltBasPis := FieldByName('DET_BASPIS').AsFloat;
            ItemNota.fltAlqPis := FieldByName('DET_ALQPIS').AsFloat;
            ItemNota.fltValPis := FieldByName('DET_VALPIS').AsFloat;
            ItemNota.strCstCof := FieldByName('DET_CSTCOF').AsString;
            ItemNota.fltBasCof := FieldByName('DET_BASCOF').AsFloat;
            ItemNota.fltAlqCof := FieldByName('DET_ALQCOF').AsFloat;
            ItemNota.fltValCof := FieldByName('DET_VALCOF').AsFloat;
            ItemNota.fltIsentas := FieldByName('DET_ISEICM').AsFloat;
            ItemNota.strNaturezaReceitaPis := FieldByName('DET_NR_PIS').AsString;
            ItemNota.strNaturezaReceitaCof := FieldByName('DET_NR_COF').AsString;
            ItemNota.strReducaoBaseIcms := FieldByName('DET_PERRED').AsString;
            ItemNota.fltBaseCalculoDestino := FieldByName('ICD_BCUFDE').AsFloat;
            ItemNota.fltAlqFcpDestino := FieldByName('ICD_PERFCP').AsFloat;
            ItemNota.fltAlqIcmsDestino := FieldByName('ICD_ALQUFD').AsFloat;
            ItemNota.fltAqlIcmsInterEstadual := FieldByName('ICD_ALQINE').AsFloat;
            ItemNota.fltPercentualPartilhaIcms := FieldByName('ICD_PERPAR').AsFloat;
            ItemNota.fltValorFcpDestino := FieldByName('ICD_VALFCP').AsFloat;
            ItemNota.fltValorIcmsDestino := FieldByName('ICD_VALDES').AsFloat;
            ItemNota.fltValorIcmsOrigem := FieldByName('ICD_VALORI').AsFloat;

            ItemNota.item.strCodigo := FieldByName('DET_CODITE').AsString;
            ItemNota.item.strNcm := FieldByName('ITE_CLAIPI').AsString;
            ItemNota.item.strCodigoCest := FieldByName('ITE_CDCEST').AsString;
            ItemNota.item.unidade.strSigla := FieldByName('UNI_SIGUNI').AsString;

            NotaNormal.pAdicionarItem(ItemNota);
          end;

          Next;
        End;
      End;
    Except
      On E: Exception Do
      Begin
        {$IFDEF MSWINDOWS}
        fMensagem('Atenção', E.Message, ['OK']);
        {$ENDIF}
      End;
    End;
  Finally
    qryAux.Free;
  End;
end;

function TRepositorioNotasFiscais.fRetNotasPorPeriodo(dtaIni, dtaFin: TDateTime; strCodemp: String;
                                                      blnExcluiCFOPUsoConsumo: Boolean;
                                                      blnExcluiCFOPServico: Boolean): TObjectList<TNotaFiscal>;
  var
    NotaFiscalDetalhada: TNotaFiscalDetalhada;
    strChaveAtual, strChaveNotaNormal: String;
    ItemNota: TItemNotaFiscal;
    NotaNormal: TNotaFiscal;
    intContador: Integer;
    qryAux: TUniQuery;
begin
  FNotas.Clear;
  Result := FNotas;

  FExcluirCFOPUsoConsumo := blnExcluiCFOPUsoConsumo;
  FExcluirCFOPServico := blnExcluiCFOPServico;

  NotaNormal := Nil;
  strChaveAtual := '';
  strChaveNotaNormal := '';

  qryAux := fCriaQuery(Nil);
  Try
    Try
      With qryAux Do
      Begin
        Close;
        SQL.Clear;

        SQL.Add(fRetSqlTodasNotasFiscaisPorPeriodo);
        ParamByName('DTAINI').AsDateTime := dtaIni;
        ParamByName('DTAFIN').AsDateTime := dtaFin;
        ParamByName('CODEMP').AsString := strCodEmp;
        Open;

        First;
        While Not Eof Do
        Begin
          strChaveAtual := fRetChaveAtual(FieldByName('FIS_SERIE_').AsString,
                                          FieldByName('FIS_TIP_FC').AsString,
                                          FieldByName('FIS_ESPDOC').AsString,
                                          FieldByName('FIS_NUMDOC').AsString,
                                          FieldByName('FIS_CODEMP').AsString,
                                          FieldByName('FIS_FORCLI').AsString);

          If strChaveAtual <> strChaveNotaNormal Then
          Begin
            strChaveNotaNormal := strChaveAtual;

            NotaNormal := TNotaFiscal.Create;

            NotaNormal.strSerie := FieldByName('FIS_SERIE_').AsString;
            NotaNormal.strTipFc := FieldByName('FIS_TIP_FC').AsString;
            NotaNormal.strNumero := FieldByName('FIS_NUMDOC').AsString;
            NotaNormal.strEspecie := FieldByName('FIS_ESPDOC').AsString;
            NotaNormal.strEmpresa := FieldByName('FIS_CODEMP').AsString;
            NotaNormal.participante.strCodigo := FieldByName('FIS_FORCLI').AsString;
            NotaNormal.participante.strNome := FieldByName('NOME').AsString;
            NotaNormal.participante.strCgcCpf := FieldByName('CNPJ').AsString;
            NotaNormal.participante.intCgcCpfInt := StrToInt64Def(FieldByName('CNPJ').AsString, 0);
            NotaNormal.participante.cidade.strCodigoIbge := FieldByName('CODIGO_IBGE').AsString;
            NotaNormal.participante.cidade.strEstado := FieldByName('UF').AsString;
            NotaNormal.blnNotaComplementar := FieldByName('FIS_NFCOMP').AsString = 'S';
            NotaNormal.strChaveAcesso := FieldByName('FIS_ACESSO').AsString;
            NotaNormal.strEstado := FieldByName('FIS_ESTADO').AsString;
            NotaNormal.strHistorico := FieldByName('FIS_HISTOR').AsString;
            NotaNormal.strModelo := FieldByName('FIS_DOCMOD').AsString;
            NotaNormal.strSituacaoDocumento := FieldByName('FIS_SITDOC').AsString;
            NotaNormal.strCfop1 := FieldByName('FIS_CLFSC1').AsString;
            NotaNormal.strCfop2 := FieldByName('FIS_CLFSC2').AsString;
            NotaNormal.strCfop3 := FieldByName('FIS_CLFSC3').AsString;
            NotaNormal.strCfop4 := FieldByName('FIS_CLFSC4').AsString;
            NotaNormal.strCfop5 := FieldByName('FIS_CLFSC5').AsString;
            NotaNormal.strCondicaoPagamento := FieldByName('FIS_COND_PG').AsString;
            NotaNormal.strTipoFrete := FieldByName('GER_TIPO_FRETE').AsString;
            NotaNormal.fltVlrIcm1 := FieldByName('FIS_VLRIC1').AsFloat;
            NotaNormal.fltVlrIcm2 := FieldByName('FIS_VLRIC2').AsFloat;
            NotaNormal.fltVlrIcm3 := FieldByName('FIS_VLRIC3').AsFloat;
            NotaNormal.fltVlrIcm4 := FieldByName('FIS_VLRIC4').AsFloat;
            NotaNormal.fltVlrIcm5 := FieldByName('FIS_VLRIC5').AsFloat;
            NotaNormal.fltBasIss := 0.00;
            NotaNormal.fltAlqIss := 0.00;
            NotaNormal.fltValIss := 0.00;
            NotaNormal.fltBasPis := 0.00;
            NotaNormal.fltAlqPis := 0.00;
            NotaNormal.fltValPis := 0.00;
            NotaNormal.fltBasCof := 0.00;
            NotaNormal.fltAlqCof := 0.00;
            NotaNormal.fltValCof := 0.00;
            NotaNormal.fltFrete := FieldByName('GER_TOTFRE').AsFloat;
            NotaNormal.fltOutras := FieldByName('FIS_OUTRAS').AsFloat;
            NotaNormal.fltDesconto := FieldByName('GER_DESESP').AsFloat;
            NotaNormal.fltValorContabil := FieldByName('FIS_VLRCON').AsFloat;
            NotaNormal.dtaDtaDoc := FieldByName('FIS_DTADOC').AsDateTime;
            NotaNormal.dtaDtaEnt := FieldByName('FIS_DTAENT').AsDateTime;
            NotaNormal.transportadora.strInscricaoEstadual := FieldByName('TRA_I_E_S_').AsString;
            NotaNormal.transportadora.strUFPlaca := FieldByName('GER_TOTFRE').AsString;
            NotaNormal.transportadora.strPlaca := FieldByName('TRA_NUMPLA').AsString;
            NotaNormal.transportadora.strCnpj := FieldByName('TRA_C_G_C_').AsString;
            NotaNormal.transportadora.cidade.strEstado := FieldByName('TRA_UF').AsString;
            NotaNormal.strIndicadorEmitente := fRetIndicadorEmitente(FieldByName('FIS_CLFSC1').AsString,
                                                                     FieldByName('CNPJ').AsString);

            Result.Add(NotaNormal);

            For intContador := 1 to 5 Do
            Begin
              If Not fEmptyStr(FieldByName('FIS_CLFSC' + IntToStr(intContador)).AsString) Then
              Begin
                NotaFiscalDetalhada := TNotaFiscalDetalhada.Create;
                NotaFiscalDetalhada.strCfop := FieldByName('FIS_CLFSC' + IntToStr(intContador)).AsString;
                NotaFiscalDetalhada.fltValorContabil := FieldByName('FIS_VLCON' + IntToStr(intContador)).AsFloat;
                NotaFiscalDetalhada.fltBaseIcms := FieldByName('FIS_BASIC' + IntToStr(intContador)).AsFloat;
                NotaFiscalDetalhada.fltAliquotaIcms := FieldByName('FIS_ALQIC' + IntToStr(intContador)).AsFloat;
                NotaFiscalDetalhada.fltValorIcms := FieldByName('FIS_VLRIC' + IntToStr(intContador)).AsFloat;
                NotaFiscalDetalhada.fltValorOutras := FieldByName('FIS_OUTRA' + IntToStr(intContador)).AsFloat;
                NotaFiscalDetalhada.fltValorIsentas := FieldByName('FIS_ISENT' + IntToStr(intContador)).AsFloat;
                NotaFiscalDetalhada.fltBaseIcmsST := FieldByName('FIS_BCRET' + IntToStr(intContador)).AsFloat;
                NotaFiscalDetalhada.fltValorIcmsST := FieldByName('FIS_RETID' + IntToStr(intContador)).AsFloat;
                NotaFiscalDetalhada.fltBaseIpi := FieldByName('FIS_BASIP' + IntToStr(intContador)).AsFloat;
                NotaFiscalDetalhada.fltValorIpi := FieldByName('FIS_VLRIP' + IntToStr(intContador)).AsFloat;

                //# VER COM O JULIO
                NotaFiscalDetalhada.strNumDoc := FieldByName('FIS_NUMDOC').AsString;

                NotaNormal.notaFiscalDetalhada.Add(NotaFiscalDetalhada);
              End;
            End;
          End;

          if not fEmptyStr(FieldByName('DET_CODITE').AsString) then
          begin
            ItemNota := TItemNotaFiscal.Create;

            ItemNota.strCodIte := FieldByName('DET_CODITE').AsString;
            ItemNota.strDesIte := FieldByName('DET_DESCRI').AsString;
            ItemNota.strUnidade := FieldByName('DET_UNIDAD').AsString;
            ItemNota.fltValorContabil := FieldByName('DET_VLRCON').AsFloat;
            ItemNota.fltValBru := FieldByName('DET_TOTITE').AsFloat;
            ItemNota.fltValFre := FieldByName('DET_TOTFRE').AsFloat;
            ItemNota.fltQuantidade := FieldByName('DET_QTDITE').AsFloat;
            ItemNota.fltValorUnitario := FieldByName('DET_UNITAR').AsFloat;
            ItemNota.strCFOP := FieldByName('DET_CLAFIS').AsString;
            ItemNota.fltValorIpi := FieldByName('DET_VALIPI').AsFloat;
            ItemNota.fltDesconto := FieldByName('DET_DESESP').AsFloat;
            ItemNota.fltDesAce := FieldByName('DET_DESACE').AsFloat;
            ItemNota.strCstIcm := FieldByName('DET_CODFIS').AsString;
            ItemNota.fltBasIcm := FieldByName('DET_BASICM').AsFloat;
            ItemNota.fltAlqIcm := FieldByName('DET_ALQICM').AsFloat;
            ItemNota.fltValIcm := FieldByName('DET_VALICM').AsFloat;
            ItemNota.strCstIpi := FieldByName('DET_CSTIPI').AsString;
            ItemNota.fltBasIpi := FieldByName('DET_BASIPI').AsFloat;
            ItemNota.fltAlqIpi := FieldByName('DET_ALQIPI').AsFloat;
            ItemNota.fltValIpi := FieldByName('DET_VALIPI').AsFloat;
            ItemNota.fltValorIpiNaoCreditado := FieldByName('DET_VAEIPI').AsFloat;
            ItemNota.fltBasRet := FieldByName('DET_BASRET').AsFloat;
            ItemNota.fltValRet := FieldByName('DET_VALRET').AsFloat;
            ItemNota.fltValorRetidoNaoCreditado := FieldByName('DET_VAERET').AsFloat;
            ItemNota.fltValorFcpSt := FieldByName('DET_VFCPST').AsFloat;
            ItemNota.fltOutIcm := FieldByName('DET_OUTICM').AsFloat;
            ItemNota.strCstPis := FieldByName('DET_CSTPIS').AsString;
            ItemNota.fltBasPis := FieldByName('DET_BASPIS').AsFloat;
            ItemNota.fltAlqPis := FieldByName('DET_ALQPIS').AsFloat;
            ItemNota.fltValPis := FieldByName('DET_VALPIS').AsFloat;
            ItemNota.strCstCof := FieldByName('DET_CSTCOF').AsString;
            ItemNota.fltBasCof := FieldByName('DET_BASCOF').AsFloat;
            ItemNota.fltAlqCof := FieldByName('DET_ALQCOF').AsFloat;
            ItemNota.fltValCof := FieldByName('DET_VALCOF').AsFloat;
            ItemNota.fltIsentas := FieldByName('DET_ISEICM').AsFloat;
            ItemNota.strNaturezaReceitaPis := FieldByName('DET_NR_PIS').AsString;
            ItemNota.strNaturezaReceitaCof := FieldByName('DET_NR_COF').AsString;
            ItemNota.strReducaoBaseIcms := FieldByName('DET_PERRED').AsString;

            ItemNota.fltBaseCalculoDestino := FieldByName('ICD_BCUFDE').AsFloat;
            ItemNota.fltAlqFcpDestino := FieldByName('ICD_PERFCP').AsFloat;
            ItemNota.fltAlqIcmsDestino := FieldByName('ICD_ALQUFD').AsFloat;
            ItemNota.fltAqlIcmsInterEstadual := FieldByName('ICD_ALQINE').AsFloat;
            ItemNota.fltPercentualPartilhaIcms := FieldByName('ICD_PERPAR').AsFloat;
            ItemNota.fltValorFcpDestino := FieldByName('ICD_VALFCP').AsFloat;
            ItemNota.fltValorIcmsDestino := FieldByName('ICD_VALDES').AsFloat;
            ItemNota.fltValorIcmsOrigem := FieldByName('ICD_VALORI').AsFloat;

            ItemNota.item.strCodigo := FieldByName('DET_CODITE').AsString;
            ItemNota.item.strNcm := FieldByName('ITE_CLAIPI').AsString;
            ItemNota.item.strCodigoCest := FieldByName('ITE_CDCEST').AsString;
            ItemNota.item.unidade.strSigla := FieldByName('UNI_SIGUNI').AsString;

            NotaNormal.pAdicionarItem(ItemNota);
          end;

          Next;
        End;
      End;
    Except
      On E: Exception Do
      Begin
        {$IFDEF MSWINDOWS}
        fMensagem('Atenção', E.Message, ['OK']);
        {$ENDIF}
      End;
    End;
  Finally
    qryAux.Free;
  End;
end;

function TRepositorioNotasFiscais.fRetNotasPorPeriodoDapi(dtaIni,
  dtaFin: TDateTime; strCodEmp: String; blnExcluiCFOPUsoConsumo,
  blnExcluiCFOPServico: Boolean): TObjectList<TNotaFiscal>;
  var
    NotaFiscalDetalhada: TNotaFiscalDetalhada;
    strChaveAtual, strChaveNotaNormal: String;
    ItemNota: TItemNotaFiscal;
    NotaNormal: TNotaFiscal;
    intContador: Integer;
    qryAux: TUniQuery;
begin
  FNotas.Clear;
  Result := FNotas;

  FExcluirCFOPUsoConsumo := blnExcluiCFOPUsoConsumo;
  FExcluirCFOPServico := blnExcluiCFOPServico;

  NotaNormal := Nil;
  strChaveAtual := '';
  strChaveNotaNormal := '';

  qryAux := fCriaQuery(Nil);
  Try
    Try
      With qryAux Do
      Begin
        Close;
        SQL.Clear;

        SQL.Add(fRetSqlTodasNotasFiscaisPorPeriodoDapi(dateToStr(dtaIni), dateToStr(dtaFin), strCodEmp));
        ParamByName('DTAINI').AsDateTime := dtaIni;
        ParamByName('DTAFIN').AsDateTime := dtaFin;
        ParamByName('CODEMP').AsString := strCodEmp;

        //# SAVE DO SQL PARA ANALISE 19122019 1135
        //# qryAux.SQL.SaveToFile('C:\Users\fabio.silva\Documents\REQUISITOS\SQLDelphi\fRetSqlTodasNotasFiscaisPorPeriodoDapi.txt');

        Open;

        First;
        While Not Eof Do
        Begin
          strChaveAtual := fRetChaveAtualR(FieldByName('FIS_SERIE_').AsString,
                                           FieldByName('FIS_TIP_FC').AsString,
                                           FieldByName('FIS_ESPDOC').AsString,
                                           FieldByName('FIS_NUMDOC').AsString,
                                           FieldByName('FIS_CODEMP').AsString,
                                           FieldByName('FIS_FORCLI').AsString,
                                           FieldByName('FIS_CLFSC1').AsString);

          If strChaveAtual <> strChaveNotaNormal Then
          Begin
            strChaveNotaNormal := strChaveAtual;

            NotaNormal := TNotaFiscal.Create;

            NotaNormal.strSerie := FieldByName('FIS_SERIE_').AsString;
            NotaNormal.strTipFc := FieldByName('FIS_TIP_FC').AsString;
            NotaNormal.strNumero := FieldByName('FIS_NUMDOC').AsString;
            NotaNormal.strEspecie := FieldByName('FIS_ESPDOC').AsString;
            NotaNormal.strEmpresa := FieldByName('FIS_CODEMP').AsString;
            NotaNormal.participante.strCodigo := FieldByName('FIS_FORCLI').AsString;
            NotaNormal.participante.strNome := FieldByName('NOME').AsString;
            NotaNormal.participante.strCgcCpf := FieldByName('CNPJ').AsString;
            NotaNormal.participante.intCgcCpfInt := StrToInt64Def(FieldByName('CNPJ').AsString, 0);
            NotaNormal.participante.cidade.strCodigoIbge := FieldByName('CODIGO_IBGE').AsString;
            NotaNormal.participante.cidade.strEstado := FieldByName('UF').AsString;
            NotaNormal.blnNotaComplementar := FieldByName('FIS_NFCOMP').AsString = 'S';
            NotaNormal.strChaveAcesso := FieldByName('FIS_ACESSO').AsString;
            NotaNormal.strEstado := FieldByName('FIS_ESTADO').AsString;
            NotaNormal.strHistorico := FieldByName('FIS_HISTOR').AsString;
            NotaNormal.strModelo := FieldByName('FIS_DOCMOD').AsString;
            NotaNormal.strSituacaoDocumento := FieldByName('FIS_SITDOC').AsString;
            NotaNormal.strCfop1 := FieldByName('FIS_CLFSC1').AsString;
            NotaNormal.strCfop2 := FieldByName('FIS_CLFSC2').AsString;
            NotaNormal.strCfop3 := FieldByName('FIS_CLFSC3').AsString;
            NotaNormal.strCfop4 := FieldByName('FIS_CLFSC4').AsString;
            NotaNormal.strCfop5 := FieldByName('FIS_CLFSC5').AsString;
            NotaNormal.strCondicaoPagamento := FieldByName('FIS_COND_PG').AsString;
            NotaNormal.strTipoFrete := FieldByName('GER_TIPO_FRETE').AsString;
            NotaNormal.fltVlrIcm1 := FieldByName('FIS_VLRIC1').AsFloat;
            NotaNormal.fltVlrIcm2 := FieldByName('FIS_VLRIC2').AsFloat;
            NotaNormal.fltVlrIcm3 := FieldByName('FIS_VLRIC3').AsFloat;
            NotaNormal.fltVlrIcm4 := FieldByName('FIS_VLRIC4').AsFloat;
            NotaNormal.fltVlrIcm5 := FieldByName('FIS_VLRIC5').AsFloat;
            NotaNormal.fltBasIss := 0.00;
            NotaNormal.fltAlqIss := 0.00;
            NotaNormal.fltValIss := 0.00;
            NotaNormal.fltBasPis := 0.00;
            NotaNormal.fltAlqPis := 0.00;
            NotaNormal.fltValPis := 0.00;
            NotaNormal.fltBasCof := 0.00;
            NotaNormal.fltAlqCof := 0.00;
            NotaNormal.fltValCof := 0.00;
            NotaNormal.fltFrete := FieldByName('GER_TOTFRE').AsFloat;
            NotaNormal.fltOutras := FieldByName('FIS_OUTRAS').AsFloat;
            NotaNormal.fltDesconto := FieldByName('GER_DESESP').AsFloat;
            NotaNormal.fltValorContabil := FieldByName('FIS_VLRCON').AsFloat;
            NotaNormal.dtaDtaDoc := FieldByName('FIS_DTADOC').AsDateTime;
            NotaNormal.dtaDtaEnt := FieldByName('FIS_DTAENT').AsDateTime;
            NotaNormal.transportadora.strInscricaoEstadual := FieldByName('TRA_I_E_S_').AsString;
            NotaNormal.transportadora.strUFPlaca := FieldByName('GER_TOTFRE').AsString;
            NotaNormal.transportadora.strPlaca := FieldByName('TRA_NUMPLA').AsString;
            NotaNormal.transportadora.strCnpj := FieldByName('TRA_C_G_C_').AsString;
            NotaNormal.transportadora.cidade.strEstado := FieldByName('TRA_UF').AsString;
            NotaNormal.strIndicadorEmitente := fRetIndicadorEmitente(FieldByName('FIS_CLFSC1').AsString, FieldByName('CNPJ').AsString);

            NotaNormal.strNumDocDapi := FieldByName('FIS_NUMDOC').AsString;
            NotaNormal.strCfopDapi := FieldByName('FIS_CLFSC1').AsString;
            NotaNormal.fltValorContabilDapi := FieldByName('FIS_VLCON1').AsFloat;
            NotaNormal.fltBaseIcmsDapi := FieldByName('FIS_BASIC1').AsFloat;
            NotaNormal.fltAliquotaIcmsDapi := FieldByName('FIS_ALQIC1').AsFloat;
            NotaNormal.fltValorIcmsDapi := FieldByName('FIS_VLRIC1').AsFloat;
            NotaNormal.fltValorOutrasDapi := FieldByName('FIS_OUTRA1').AsFloat;
            NotaNormal.fltValorIsentasDapi := FieldByName('FIS_ISENT1').AsFloat;
            NotaNormal.fltBaseIcmsSTDapi := FieldByName('FIS_BCRET1').AsFloat;
            NotaNormal.fltValorIcmsSTDapi := FieldByName('FIS_RETID1').AsFloat;
            NotaNormal.fltBaseIpiDapi := FieldByName('FIS_BASIP1').AsFloat;
            NotaNormal.fltValorIpiDapi := FieldByName('FIS_VLRIP1').AsFloat;

            Result.Add(NotaNormal);

            For intContador := 1 to 1 Do
            Begin
              If Not fEmptyStr(FieldByName('FIS_CLFSC' + IntToStr(intContador)).AsString) Then
              Begin
                NotaFiscalDetalhada := TNotaFiscalDetalhada.Create;

                NotaFiscalDetalhada.strNumDoc := FieldByName('FIS_NUMDOC').AsString;
                NotaFiscalDetalhada.strCfop := FieldByName('FIS_CLFSC' + IntToStr(intContador)).AsString;
                NotaFiscalDetalhada.fltValorContabil := FieldByName('FIS_VLCON' + IntToStr(intContador)).AsFloat;
                NotaFiscalDetalhada.fltBaseIcms := FieldByName('FIS_BASIC' + IntToStr(intContador)).AsFloat;
                NotaFiscalDetalhada.fltAliquotaIcms := FieldByName('FIS_ALQIC' + IntToStr(intContador)).AsFloat;
                NotaFiscalDetalhada.fltValorIcms := FieldByName('FIS_VLRIC' + IntToStr(intContador)).AsFloat;
                NotaFiscalDetalhada.fltValorOutras := FieldByName('FIS_OUTRA' + IntToStr(intContador)).AsFloat;
                NotaFiscalDetalhada.fltValorIsentas := FieldByName('FIS_ISENT' + IntToStr(intContador)).AsFloat;
                NotaFiscalDetalhada.fltBaseIcmsST := FieldByName('FIS_BCRET' + IntToStr(intContador)).AsFloat;
                NotaFiscalDetalhada.fltValorIcmsST := FieldByName('FIS_RETID' + IntToStr(intContador)).AsFloat;
                NotaFiscalDetalhada.fltBaseIpi := FieldByName('FIS_BASIP' + IntToStr(intContador)).AsFloat;
                NotaFiscalDetalhada.fltValorIpi := FieldByName('FIS_VLRIP' + IntToStr(intContador)).AsFloat;

                NotaNormal.notaFiscalDetalhada.Add(NotaFiscalDetalhada);
              End;
            End;
          End;

          if not fEmptyStr(FieldByName('DET_CODITE').AsString) then
          begin
            ItemNota := TItemNotaFiscal.Create;

            ItemNota.strCodIte := FieldByName('DET_CODITE').AsString;
            ItemNota.strDesIte := FieldByName('DET_DESCRI').AsString;
            ItemNota.strUnidade := FieldByName('DET_UNIDAD').AsString;
            ItemNota.fltValorContabil := FieldByName('DET_VLRCON').AsFloat;
            ItemNota.fltValBru := FieldByName('DET_TOTITE').AsFloat;
            ItemNota.fltValFre := FieldByName('DET_TOTFRE').AsFloat;
            ItemNota.fltQuantidade := FieldByName('DET_QTDITE').AsFloat;
            ItemNota.fltValorUnitario := FieldByName('DET_UNITAR').AsFloat;
            ItemNota.strCFOP := FieldByName('DET_CLAFIS').AsString;
            ItemNota.fltValorIpi := FieldByName('DET_VALIPI').AsFloat;
            ItemNota.fltDesconto := FieldByName('DET_DESESP').AsFloat;
            ItemNota.fltDesAce := FieldByName('DET_DESACE').AsFloat;
            ItemNota.strCstIcm := FieldByName('DET_CODFIS').AsString;
            ItemNota.fltBasIcm := FieldByName('DET_BASICM').AsFloat;
            ItemNota.fltAlqIcm := FieldByName('DET_ALQICM').AsFloat;
            ItemNota.fltValIcm := FieldByName('DET_VALICM').AsFloat;
            ItemNota.strCstIpi := FieldByName('DET_CSTIPI').AsString;
            ItemNota.fltBasIpi := FieldByName('DET_BASIPI').AsFloat;
            ItemNota.fltAlqIpi := FieldByName('DET_ALQIPI').AsFloat;
            ItemNota.fltValIpi := FieldByName('DET_VALIPI').AsFloat;
            ItemNota.fltValorIpiNaoCreditado := FieldByName('DET_VAEIPI').AsFloat;
            ItemNota.fltBasRet := FieldByName('DET_BASRET').AsFloat;
            ItemNota.fltValRet := FieldByName('DET_VALRET').AsFloat;
            ItemNota.fltValorRetidoNaoCreditado := FieldByName('DET_VAERET').AsFloat;
            ItemNota.fltValorFcpSt := FieldByName('DET_VFCPST').AsFloat;
            ItemNota.fltOutIcm := FieldByName('DET_OUTICM').AsFloat;
            ItemNota.strCstPis := FieldByName('DET_CSTPIS').AsString;
            ItemNota.fltBasPis := FieldByName('DET_BASPIS').AsFloat;
            ItemNota.fltAlqPis := FieldByName('DET_ALQPIS').AsFloat;
            ItemNota.fltValPis := FieldByName('DET_VALPIS').AsFloat;
            ItemNota.strCstCof := FieldByName('DET_CSTCOF').AsString;
            ItemNota.fltBasCof := FieldByName('DET_BASCOF').AsFloat;
            ItemNota.fltAlqCof := FieldByName('DET_ALQCOF').AsFloat;
            ItemNota.fltValCof := FieldByName('DET_VALCOF').AsFloat;
            ItemNota.fltIsentas := FieldByName('DET_ISEICM').AsFloat;
            ItemNota.strNaturezaReceitaPis := FieldByName('DET_NR_PIS').AsString;
            ItemNota.strNaturezaReceitaCof := FieldByName('DET_NR_COF').AsString;
            ItemNota.strReducaoBaseIcms := FieldByName('DET_PERRED').AsString;
            ItemNota.fltBaseCalculoDestino := FieldByName('ICD_BCUFDE').AsFloat;
            ItemNota.fltAlqFcpDestino := FieldByName('ICD_PERFCP').AsFloat;
            ItemNota.fltAlqIcmsDestino := FieldByName('ICD_ALQUFD').AsFloat;
            ItemNota.fltAqlIcmsInterEstadual := FieldByName('ICD_ALQINE').AsFloat;
            ItemNota.fltPercentualPartilhaIcms := FieldByName('ICD_PERPAR').AsFloat;
            ItemNota.fltValorFcpDestino := FieldByName('ICD_VALFCP').AsFloat;
            ItemNota.fltValorIcmsDestino := FieldByName('ICD_VALDES').AsFloat;
            ItemNota.fltValorIcmsOrigem := FieldByName('ICD_VALORI').AsFloat;

            ItemNota.item.strCodigo := FieldByName('DET_CODITE').AsString;
            ItemNota.item.strNcm := FieldByName('ITE_CLAIPI').AsString;
            ItemNota.item.strCodigoCest := FieldByName('ITE_CDCEST').AsString;
            ItemNota.item.unidade.strSigla := FieldByName('UNI_SIGUNI').AsString;

            NotaNormal.pAdicionarItem(ItemNota);
          end;

          Next;
        End;
      End;
    Except
      On E: Exception Do
      Begin
        {$IFDEF MSWINDOWS}
        fMensagem('Atenção', E.Message, ['OK']);
        {$ENDIF}
      End;
    End;
  Finally
    qryAux.Free;
  End;
end;

function TRepositorioNotasFiscais.fRetNotasPorPeriodoDief(dtaIni, dtaFin: TDateTime; strCodEmp: String;
  blnExcluiCFOPUsoConsumo: Boolean = False; blnExcluiCFOPServico: Boolean = False; blnExcluirNotasFiscaisConsumidor: Boolean = False): TObjectList<TNotaFiscal>;
  var
    NotaFiscalDetalhada: TNotaFiscalDetalhada;
    strChaveAtual, strChaveNotaNormal: String;
    ItemNota: TItemNotaFiscal;
    NotaNormal: TNotaFiscal;
    intContador: Integer;
    qryAux: TUniQuery;
begin
  FNotas.Clear;
  Result := FNotas;

  FExcluirCFOPUsoConsumo := blnExcluiCFOPUsoConsumo;
  FExcluirCFOPServico := blnExcluiCFOPServico;
  FExcluirNotasFiscaisConsumidor := blnExcluirNotasFiscaisConsumidor;

  NotaNormal := Nil;
  strChaveAtual := '';
  strChaveNotaNormal := '';

  qryAux := fCriaQuery(Nil);
  Try
    Try
      With qryAux Do
      Begin
        Close;
        SQL.Clear;

        SQL.Add(fRetSqlTodasNotasFiscaisPorPeriodoDief(dateToStr(dtaIni), dateToStr(dtaFin), strCodEmp));
        ParamByName('DTAINI').AsDateTime := dtaIni;
        ParamByName('DTAFIN').AsDateTime := dtaFin;
        ParamByName('CODEMP').AsString := strCodEmp;

        //# SAVE DO SQL PARA ANALISE 19122019 1135
        //# qryAux.SQL.SaveToFile('C:\Users\fabio.silvaprg\Documents\REQUISITOS\SQLDelphi\fRetSqlTodasNotasFiscaisPorPeriodoDief.txt');

        Open;

        First;
        While Not Eof Do
        Begin
          strChaveAtual := fRetChaveAtualR(FieldByName('FIS_SERIE_').AsString,
                                           FieldByName('FIS_TIP_FC').AsString,
                                           FieldByName('FIS_ESPDOC').AsString,
                                           FieldByName('FIS_NUMDOC').AsString,
                                           FieldByName('FIS_CODEMP').AsString,
                                           FieldByName('FIS_FORCLI').AsString,
                                           FieldByName('FIS_CLFSC1').AsString);

          If strChaveAtual <> strChaveNotaNormal Then
          Begin
            strChaveNotaNormal := strChaveAtual;

            NotaNormal := TNotaFiscal.Create;

            NotaNormal.strSerie := FieldByName('FIS_SERIE_').AsString;
            NotaNormal.strTipFc := FieldByName('FIS_TIP_FC').AsString;
            NotaNormal.strNumero := FieldByName('FIS_NUMDOC').AsString;
            NotaNormal.strEspecie := FieldByName('FIS_ESPDOC').AsString;
            NotaNormal.strEmpresa := FieldByName('FIS_CODEMP').AsString;
            NotaNormal.participante.strCodigo := FieldByName('FIS_FORCLI').AsString;
            NotaNormal.participante.strNome := FieldByName('NOME').AsString;
            NotaNormal.participante.strCgcCpf := FieldByName('CNPJ').AsString;
            NotaNormal.participante.intCgcCpfInt := StrToInt64Def(FieldByName('CNPJ').AsString, 0);
            NotaNormal.participante.cidade.strCodigoIbge := FieldByName('CODIGO_IBGE').AsString;
            NotaNormal.participante.cidade.strEstado := FieldByName('UF').AsString;
            NotaNormal.blnNotaComplementar := FieldByName('FIS_NFCOMP').AsString = 'S';
            NotaNormal.strChaveAcesso := FieldByName('FIS_ACESSO').AsString;
            NotaNormal.strEstado := FieldByName('FIS_ESTADO').AsString;
            NotaNormal.strHistorico := FieldByName('FIS_HISTOR').AsString;
            NotaNormal.strModelo := FieldByName('FIS_DOCMOD').AsString;
            NotaNormal.strSituacaoDocumento := FieldByName('FIS_SITDOC').AsString;
            NotaNormal.strCfop1 := FieldByName('FIS_CLFSC1').AsString;
            NotaNormal.strCfop2 := FieldByName('FIS_CLFSC2').AsString;
            NotaNormal.strCfop3 := FieldByName('FIS_CLFSC3').AsString;
            NotaNormal.strCfop4 := FieldByName('FIS_CLFSC4').AsString;
            NotaNormal.strCfop5 := FieldByName('FIS_CLFSC5').AsString;
            NotaNormal.strCondicaoPagamento := FieldByName('FIS_COND_PG').AsString;
            NotaNormal.strTipoFrete := FieldByName('GER_TIPO_FRETE').AsString;
            NotaNormal.fltVlrIcm1 := FieldByName('FIS_VLRIC1').AsFloat;
            NotaNormal.fltVlrIcm2 := FieldByName('FIS_VLRIC2').AsFloat;
            NotaNormal.fltVlrIcm3 := FieldByName('FIS_VLRIC3').AsFloat;
            NotaNormal.fltVlrIcm4 := FieldByName('FIS_VLRIC4').AsFloat;
            NotaNormal.fltVlrIcm5 := FieldByName('FIS_VLRIC5').AsFloat;
            NotaNormal.fltBasIss := 0.00;
            NotaNormal.fltAlqIss := 0.00;
            NotaNormal.fltValIss := 0.00;
            NotaNormal.fltBasPis := 0.00;
            NotaNormal.fltAlqPis := 0.00;
            NotaNormal.fltValPis := 0.00;
            NotaNormal.fltBasCof := 0.00;
            NotaNormal.fltAlqCof := 0.00;
            NotaNormal.fltValCof := 0.00;
            NotaNormal.fltFrete := FieldByName('GER_TOTFRE').AsFloat;
            NotaNormal.fltOutras := FieldByName('FIS_OUTRAS').AsFloat;
            NotaNormal.fltDesconto := FieldByName('GER_DESESP').AsFloat;
            NotaNormal.fltValorContabil := FieldByName('FIS_VLRCON').AsFloat;
            NotaNormal.dtaDtaDoc := FieldByName('FIS_DTADOC').AsDateTime;
            NotaNormal.dtaDtaEnt := FieldByName('FIS_DTAENT').AsDateTime;
            NotaNormal.transportadora.strInscricaoEstadual := FieldByName('TRA_I_E_S_').AsString;
            NotaNormal.transportadora.strUFPlaca := FieldByName('GER_TOTFRE').AsString;
            NotaNormal.transportadora.strPlaca := FieldByName('TRA_NUMPLA').AsString;
            NotaNormal.transportadora.strCnpj := FieldByName('TRA_C_G_C_').AsString;
            NotaNormal.transportadora.cidade.strEstado := FieldByName('TRA_UF').AsString;
            NotaNormal.strIndicadorEmitente := fRetIndicadorEmitente(FieldByName('FIS_CLFSC1').AsString, FieldByName('CNPJ').AsString);

            NotaNormal.strNumDocDapi := FieldByName('FIS_NUMDOC').AsString;
            NotaNormal.strCfopDapi := FieldByName('FIS_CLFSC1').AsString;
            NotaNormal.fltValorContabilDapi := FieldByName('FIS_VLCON1').AsFloat;
            NotaNormal.fltBaseIcmsDapi := FieldByName('FIS_BASIC1').AsFloat;
            NotaNormal.fltAliquotaIcmsDapi := FieldByName('FIS_ALQIC1').AsFloat;
            NotaNormal.fltValorIcmsDapi := FieldByName('FIS_VLRIC1').AsFloat;
            NotaNormal.fltValorOutrasDapi := FieldByName('FIS_OUTRA1').AsFloat;
            NotaNormal.fltValorIsentasDapi := FieldByName('FIS_ISENT1').AsFloat;
            NotaNormal.fltBaseIcmsSTDapi := FieldByName('FIS_BCRET1').AsFloat;
            NotaNormal.fltValorIcmsSTDapi := FieldByName('FIS_RETID1').AsFloat;
            NotaNormal.fltBaseIpiDapi := FieldByName('FIS_BASIP1').AsFloat;
            NotaNormal.fltValorIpiDapi := FieldByName('FIS_VLRIP1').AsFloat;

            Result.Add(NotaNormal);

            For intContador := 1 to 1 Do
            Begin
              If Not fEmptyStr(FieldByName('FIS_CLFSC' + IntToStr(intContador)).AsString) Then
              Begin
                NotaFiscalDetalhada := TNotaFiscalDetalhada.Create;

                NotaFiscalDetalhada.strNumDoc := FieldByName('FIS_NUMDOC').AsString;
                NotaFiscalDetalhada.strCfop := FieldByName('FIS_CLFSC' + IntToStr(intContador)).AsString;
                NotaFiscalDetalhada.fltValorContabil := FieldByName('FIS_VLCON' + IntToStr(intContador)).AsFloat;
                NotaFiscalDetalhada.fltBaseIcms := FieldByName('FIS_BASIC' + IntToStr(intContador)).AsFloat;
                NotaFiscalDetalhada.fltAliquotaIcms := FieldByName('FIS_ALQIC' + IntToStr(intContador)).AsFloat;
                NotaFiscalDetalhada.fltValorIcms := FieldByName('FIS_VLRIC' + IntToStr(intContador)).AsFloat;
                NotaFiscalDetalhada.fltValorOutras := FieldByName('FIS_OUTRA' + IntToStr(intContador)).AsFloat;
                NotaFiscalDetalhada.fltValorIsentas := FieldByName('FIS_ISENT' + IntToStr(intContador)).AsFloat;
                NotaFiscalDetalhada.fltBaseIcmsST := FieldByName('FIS_BCRET' + IntToStr(intContador)).AsFloat;
                NotaFiscalDetalhada.fltValorIcmsST := FieldByName('FIS_RETID' + IntToStr(intContador)).AsFloat;
                NotaFiscalDetalhada.fltBaseIpi := FieldByName('FIS_BASIP' + IntToStr(intContador)).AsFloat;
                NotaFiscalDetalhada.fltValorIpi := FieldByName('FIS_VLRIP' + IntToStr(intContador)).AsFloat;

                NotaNormal.notaFiscalDetalhada.Add(NotaFiscalDetalhada);
              End;
            End;
          End;

          if not fEmptyStr(FieldByName('DET_CODITE').AsString) then
          begin
            ItemNota := TItemNotaFiscal.Create;

            ItemNota.strCodIte := FieldByName('DET_CODITE').AsString;
            ItemNota.strDesIte := FieldByName('DET_DESCRI').AsString;
            ItemNota.strUnidade := FieldByName('DET_UNIDAD').AsString;
            //ItemNota.fltValorContabil := FieldByName('DET_VLRCON').AsFloat;
            ItemNota.fltValorContabil := IIF(FieldByName('DET_VLRCON').AsFloat > 0, FieldByName('DET_VLRCON').AsFloat, FieldByName('FIS_VLCON1').AsFloat);
            ItemNota.fltValBru := FieldByName('DET_TOTITE').AsFloat;
            ItemNota.fltValFre := FieldByName('DET_TOTFRE').AsFloat;
            ItemNota.fltQuantidade := FieldByName('DET_QTDITE').AsFloat;
            ItemNota.fltValorUnitario := FieldByName('DET_UNITAR').AsFloat;
            ItemNota.strCFOP := FieldByName('DET_CLAFIS').AsString;
            //ItemNota.fltValorIpi := FieldByName('DET_VALIPI').AsFloat;
            ItemNota.fltValorIpi := IIF(FieldByName('DET_VALIPI').AsFloat > 0, FieldByName('DET_VALIPI').AsFloat, FieldByName('FIS_VLRIP1').AsFloat);
            ItemNota.fltDesconto := FieldByName('DET_DESESP').AsFloat;
            ItemNota.fltDesAce := FieldByName('DET_DESACE').AsFloat;
            ItemNota.strCstIcm := FieldByName('DET_CODFIS').AsString;
            //ItemNota.fltBasIcm := FieldByName('DET_BASICM').AsFloat;
            ItemNota.fltBasIcm := IIF(FieldByName('DET_BASICM').AsFloat > 0, FieldByName('DET_BASICM').AsFloat, FieldByName('FIS_BASIC1').AsFloat);
            ItemNota.fltAlqIcm := FieldByName('DET_ALQICM').AsFloat;
            //ItemNota.fltValIcm := FieldByName('DET_VALICM').AsFloat;
            ItemNota.fltValIcm := IIF(FieldByName('DET_VALICM').AsFloat > 0, FieldByName('DET_VALICM').AsFloat, FieldByName('FIS_VLRIC1').AsFloat);
            ItemNota.strCstIpi := FieldByName('DET_CSTIPI').AsString;
            ItemNota.fltBasIpi := FieldByName('DET_BASIPI').AsFloat;
            ItemNota.fltAlqIpi := FieldByName('DET_ALQIPI').AsFloat;
            //ItemNota.fltValIpi := FieldByName('DET_VALIPI').AsFloat;
            ItemNota.fltValIpi := IIF(FieldByName('DET_VALIPI').AsFloat > 0, FieldByName('DET_VALIPI').AsFloat, FieldByName('FIS_VLRIP1').AsFloat);
            ItemNota.fltValorIpiNaoCreditado := FieldByName('DET_VAEIPI').AsFloat;
            ItemNota.fltBasRet := FieldByName('DET_BASRET').AsFloat;
            ItemNota.fltValRet := FieldByName('DET_VALRET').AsFloat;
            ItemNota.fltValorRetidoNaoCreditado := FieldByName('DET_VAERET').AsFloat;
            ItemNota.fltValorFcpSt := FieldByName('DET_VFCPST').AsFloat;
            //ItemNota.fltOutIcm := FieldByName('DET_OUTICM').AsFloat;
            ItemNota.fltOutIcm := IIF(FieldByName('DET_OUTICM').AsFloat > 0, FieldByName('DET_OUTICM').AsFloat, FieldByName('FIS_OUTRA1').AsFloat);
            ItemNota.strCstPis := FieldByName('DET_CSTPIS').AsString;
            ItemNota.fltBasPis := FieldByName('DET_BASPIS').AsFloat;
            ItemNota.fltAlqPis := FieldByName('DET_ALQPIS').AsFloat;
            ItemNota.fltValPis := FieldByName('DET_VALPIS').AsFloat;
            ItemNota.strCstCof := FieldByName('DET_CSTCOF').AsString;
            ItemNota.fltBasCof := FieldByName('DET_BASCOF').AsFloat;
            ItemNota.fltAlqCof := FieldByName('DET_ALQCOF').AsFloat;
            ItemNota.fltValCof := FieldByName('DET_VALCOF').AsFloat;
            //ItemNota.fltIsentas := FieldByName('DET_ISEICM').AsFloat;
            ItemNota.fltIsentas := IIF(FieldByName('DET_ISEICM').AsFloat > 0, FieldByName('DET_ISEICM').AsFloat, FieldByName('FIS_ISENT1').AsFloat);
            ItemNota.strNaturezaReceitaPis := FieldByName('DET_NR_PIS').AsString;
            ItemNota.strNaturezaReceitaCof := FieldByName('DET_NR_COF').AsString;
            ItemNota.strReducaoBaseIcms := FieldByName('DET_PERRED').AsString;
            ItemNota.fltBaseCalculoDestino := FieldByName('ICD_BCUFDE').AsFloat;
            ItemNota.fltAlqFcpDestino := FieldByName('ICD_PERFCP').AsFloat;
            ItemNota.fltAlqIcmsDestino := FieldByName('ICD_ALQUFD').AsFloat;
            ItemNota.fltAqlIcmsInterEstadual := FieldByName('ICD_ALQINE').AsFloat;
            ItemNota.fltPercentualPartilhaIcms := FieldByName('ICD_PERPAR').AsFloat;
            ItemNota.fltValorFcpDestino := FieldByName('ICD_VALFCP').AsFloat;
            ItemNota.fltValorIcmsDestino := FieldByName('ICD_VALDES').AsFloat;
            ItemNota.fltValorIcmsOrigem := FieldByName('ICD_VALORI').AsFloat;
            ItemNota.item.strCodigo := FieldByName('DET_CODITE').AsString;
            ItemNota.item.strNcm := FieldByName('ITE_CLAIPI').AsString;
            ItemNota.item.strCodigoCest := FieldByName('ITE_CDCEST').AsString;
            ItemNota.item.unidade.strSigla := FieldByName('UNI_SIGUNI').AsString;

            NotaNormal.pAdicionarItem(ItemNota);
          end;

          Next;
        End;
      End;
    Except
      On E: Exception Do
      Begin
        {$IFDEF MSWINDOWS}
        fMensagem('Atenção', E.Message, ['OK']);
        {$ENDIF}
      End;
    End;
  Finally
    qryAux.Free;
  End;
end;

function TRepositorioNotasFiscais.fRetNotasServicoSintetizadas(dtaIni, dtaFin: TDateTime; strCodEmp, strTipoSintetizacao: String): TObjectList<TNotaFiscalSintetizada>;
  Var
    qryAux: TUniQuery;
    NotaTotal: TNotaFiscalSintetizada;
begin
  If (strTipoSintetizacao = 'CFOP') Then
  Begin
    FNotasSintetizadasCFOP.Clear;
    Result := FNotasSintetizadasCFOP;
  End
  Else If (strTipoSintetizacao = 'CNPJ') Then
  Begin
    FNotasSintetizadasCNPJ.Clear;
    Result := FNotasSintetizadasCNPJ;
  End
  Else
  Begin
    FNotasSintetizadasIBGE.Clear;
    Result := FNotasSintetizadasIBGE;
  End;

  qryAux := fCriaQuery(Nil);
  Try
    With qryAux Do
    Begin
      SQL.Add(fRetSqlTodasNotasServicoSintetizadas(strTipoSintetizacao));

      ParamByName('DTAINI').AsDateTime := dtaIni;
      ParamByName('DTAFIN').AsDateTime := dtaFin;
      ParamByName('CODEMP').AsString := strCodEmp;

      Open;

      First;
      While Not Eof Do
      Begin
        NotaTotal := TNotaFiscalSintetizada.Create;

        NotaTotal.strCfop           := FieldByName('FIS_CLFSC1').AsString;
        NotaTotal.strCfps           := FieldByName('FIS_CFPS__').AsString;
        NotaTotal.strCPNJ           := FieldByName('FIS_CNPJ__').AsString;
        NotaTotal.strIbge           := FieldByName('FIS_IBGE__').AsString;
        NotaTotal.fltTotalContabil  := FieldByName('FIS_VLRCON').AsFloat;
        NotaTotal.fltTotalRetidoISS := FieldByName('FIS_RETISS').AsFloat;

        Result.Add(NotaTotal);

        Next;
      End;
    End;
  Finally
    qryAux.Free;
  End;

end;

function TRepositorioNotasFiscais.fRetNotasServicoTomadoPorPeriodo(dtaIni, dtaFin: TDateTime; strCodEmp: String; blnIncluiCFOPSaida: Boolean; blnNotaFiscalConjugada: Boolean): TObjectList<TNotaFiscal>;
  Var
    qryAux: TUniQuery;
    NotaNormal: TNotaFiscal;
begin
  FNotasServico.Clear;
  Result := FNotasServico;

  FIncluirCFOPSaida := blnIncluiCFOPSaida;
  FNotaFiscalConjugada := blnNotaFiscalConjugada;

  qryAux := fCriaQuery(Nil);
  Try
    With qryAux Do
    Begin
      SQL.Add(fRetSqlTodasNotasServicoTomadosPorPeriodo);
      //qryAux.SQL.SaveToFile('untTRepositorioNotasFiscais_RetSqlTodasNotasServicoTomadosPorPeriodo.txt');

      ParamByName('DTAINI').AsDateTime := dtaIni;
      ParamByName('DTAFIN').AsDateTime := dtaFin;
      ParamByName('CODEMP').AsString := strCodEmp;

      Open;

      First;
      While Not Eof Do
      Begin
        NotaNormal := TNotaFiscal.Create;

        NotaNormal.strSerie := FieldByName('FIS_SERIE_').AsString;
        NotaNormal.strTipFc := FieldByName('FIS_TIP_FC').AsString;
        NotaNormal.strNumero := FieldByName('FIS_NUMDOC').AsString;
        NotaNormal.strEspecie := FieldByName('FIS_ESPDOC').AsString;
        NotaNormal.strEmpresa := FieldByName('FIS_CODEMP').AsString;
        NotaNormal.strCfop1 := FieldByName('FIS_CLFSC1').AsString;
        NotaNormal.strModelo := FieldByName('FIS_DOCMOD').AsString;
        NotaNormal.strSituacaoDocumento := FieldByName('FIS_SITDOC').AsString;
        NotaNormal.strChaveAcesso := FieldByName('ACESSO').AsString;

        NotaNormal.participante.strCodigo := FieldByName('FIS_FORCLI').AsString;
        NotaNormal.participante.strCgcCpf := FieldByName('CNPJ').AsString;
        NotaNormal.participante.intCgcCpfInt := StrToInt64Def(FieldByName('CNPJ').AsString, 0);
        NotaNormal.participante.strNome := FieldByName('NOME').AsString;
        NotaNormal.participante.cidade.strCodigoIbge := FieldByName('CODIGO_IBGE').AsString;
        NotaNormal.participante.cidade.strCodCid := FieldByName('CID_CODCID').AsString;

        NotaNormal.fltBasIss := FieldByName('FIS_BASISS').AsFloat;
        NotaNormal.fltAlqIss := FieldByName('FIS_ALQISS').AsFloat;
        NotaNormal.fltValIss := FieldByName('FIS_VALISS').AsFloat;
        NotaNormal.fltRetIss := FieldByName('FIS_RETISS').AsFloat;

        NotaNormal.fltBasPis := FieldByName('FIS_BASPIS').AsFloat;
        NotaNormal.fltAlqPis := FieldByName('FIS_ALQPIS').AsFloat;
        NotaNormal.fltValPis := FieldByName('FIS_TOTPIS').AsFloat;

        NotaNormal.fltBasCof := FieldByName('FIS_BASCOF').AsFloat;
        NotaNormal.fltAlqCof := FieldByName('FIS_ALQCOF').AsFloat;
        NotaNormal.fltValCof := FieldByName('FIS_TOTCOF').AsFloat;

        NotaNormal.fltFrete := FieldByName('GER_TOTFRE').AsFloat;
        NotaNormal.fltOutras := FieldByName('FIS_OUTRAS').AsFloat;
        NotaNormal.fltDesconto := FieldByName('GER_DESESP').AsFloat;
        NotaNormal.fltValorContabil := FieldByName('FIS_VLRCON').AsFloat;
        NotaNormal.dtaDtaDoc := FieldByName('FIS_DTADOC').AsDateTime;
        NotaNormal.dtaDtaEnt := FieldByName('FIS_DTAENT').AsDateTime;
        NotaNormal.strIndicadorEmitente := fRetIndicadorEmitente(FieldByName('FIS_CLFSC1').AsString, FieldByName('CNPJ').AsString);

        If FindField('CID_ESTADO') <> Nil Then
          NotaNormal.strUFEmpresaEmitente := FieldByName('CID_ESTADO').AsString;

        if FNotaFiscalConjugada then
        begin
          NotaNormal.fltValorContabil := FieldByName('FIS_VLRCON_CONJ').AsFloat;
          NotaNormal.fltOutras := FieldByName('FIS_OUTRAS_CONJ').AsFloat;
          NotaNormal.fltValIss := FieldByName('FIS_VALISS_CONJ').AsFloat;
          NotaNormal.strIndicadorOperacao := fRetIndicadorOperacao(FieldByName('FIS_ICLFSC_CONJ').AsString);
          NotaNormal.strCodigoServico := FieldByName('FIS_CDSERV').AsString;
        end;

        Result.Add(NotaNormal);

        Next;
      End;
    End;
  Finally
    qryAux.Free;
  End;
end;

function TRepositorioNotasFiscais.fRetNotasTransportePorPeriodo(dtaIni, dtaFin: TDateTime; strCodEmp: String): TObjectList<TNotaFiscal>;
  var
    NotaFiscalDetalhada: TNotaFiscalDetalhada;
    NotaNormal: TNotaFiscal;
    intContador: integer;
    qryAux: TUniQuery;
begin
  FNotasTransporte.Clear;
  Result := FNotasTransporte;

  qryAux := fCriaQuery(Nil);
  try
    with qryAux do
    begin
      SQL.Add(fRetSqlTodasNotasTransportePorPeriodo);

      ParamByName('DTAINI').AsDateTime := dtaIni;
      ParamByName('DTAFIN').AsDateTime := dtaFin;
      ParamByName('CODEMP').AsString := strCodEmp;

      Open;

      First;
      while not Eof do
      begin
        NotaNormal := TNotaFiscal.Create;

        NotaNormal.strSerie := FieldByName('FIS_SERIE_').AsString;
        NotaNormal.strTipFc := FieldByName('FIS_TIP_FC').AsString;
        NotaNormal.strNumero := FieldByName('FIS_NUMDOC').AsString;
        NotaNormal.strEspecie := FieldByName('FIS_ESPDOC').AsString;
        NotaNormal.strEmpresa := FieldByName('FIS_CODEMP').AsString;
        NotaNormal.strCfop1 := FieldByName('FIS_CLFSC1').AsString;
        NotaNormal.participante.strCodigo := FieldByName('FIS_FORCLI').AsString;
        NotaNormal.participante.strCgcCpf := FieldByName('CNPJ').AsString;
        NotaNormal.participante.intCgcCpfInt := StrToInt64Def(FieldByName('CNPJ').AsString, 0);
        NotaNormal.participante.strNome := FieldByName('NOME').AsString;
        NotaNormal.strModelo := FieldByName('FIS_DOCMOD').AsString;
        NotaNormal.strTipoFrete := FieldByName('GER_TIPO_FRETE').AsString;
        NotaNormal.strSituacaoDocumento := FieldByName('FIS_SITDOC').AsString;
        NotaNormal.fltBasIss := FieldByName('FIS_BASISS').AsFloat;
        NotaNormal.fltAlqIss := FieldByName('FIS_ALQISS').AsFloat;
        NotaNormal.fltValIss := FieldByName('FIS_VALISS').AsFloat;
        NotaNormal.fltBasPis := FieldByName('FIS_BASPIS').AsFloat;
        NotaNormal.fltAlqPis := FieldByName('FIS_ALQPIS').AsFloat;
        NotaNormal.fltValPis := FieldByName('FIS_TOTPIS').AsFloat;
        NotaNormal.fltBasCof := FieldByName('FIS_BASCOF').AsFloat;
        NotaNormal.fltAlqCof := FieldByName('FIS_ALQCOF').AsFloat;
        NotaNormal.fltValCof := FieldByName('FIS_TOTCOF').AsFloat;
        NotaNormal.fltFrete := FieldByName('GER_TOTFRE').AsFloat;
        NotaNormal.fltOutras := FieldByName('FIS_OUTRAS').AsFloat;
        NotaNormal.fltDesconto := FieldByName('GER_DESESP').AsFloat;
        NotaNormal.fltValorContabil := FieldByName('FIS_VLRCON').AsFloat;
        NotaNormal.dtaDtaDoc := FieldByName('FIS_DTADOC').AsDateTime;
        NotaNormal.dtaDtaEnt := FieldByName('FIS_DTAENT').AsDateTime;
        NotaNormal.fltVlrIcm1 := FieldByName('FIS_VLRIC1').AsFloat;
        NotaNormal.fltVlrIcm2 := FieldByName('FIS_VLRIC2').AsFloat;
        NotaNormal.fltVlrIcm3 := FieldByName('FIS_VLRIC3').AsFloat;
        NotaNormal.fltVlrIcm4 := FieldByName('FIS_VLRIC4').AsFloat;
        NotaNormal.fltVlrIcm5 := FieldByName('FIS_VLRIC5').AsFloat;
        NotaNormal.strIndicadorEmitente := fRetIndicadorEmitente(FieldByName('FIS_CLFSC1').AsString,
                                                                 FieldByName('CNPJ').AsString);

        if FindField('CID_ESTADO') <> nil then
          NotaNormal.strUFEmpresaEmitente := FieldByName('CID_ESTADO').AsString;

        Result.Add(NotaNormal);

        For intContador := 1 to 5 Do
        Begin
          If Not fEmptyStr(FieldByName('FIS_CLFSC' + IntToStr(intContador)).AsString) Then
          Begin
            NotaFiscalDetalhada := TNotaFiscalDetalhada.Create;
            NotaFiscalDetalhada.strCfop := FieldByName('FIS_CLFSC' + IntToStr(intContador)).AsString;
            NotaFiscalDetalhada.fltBaseIcms := FieldByName('FIS_BASIC' + IntToStr(intContador)).AsFloat;
            NotaFiscalDetalhada.fltAliquotaIcms := FieldByName('FIS_ALQIC' + IntToStr(intContador)).AsFloat;
            NotaFiscalDetalhada.fltValorIcms := FieldByName('FIS_VLRIC' + IntToStr(intContador)).AsFloat;

            NotaNormal.notaFiscalDetalhada.Add(NotaFiscalDetalhada);
          End;
        End;

        Next;
      end;
    end;
  finally
    qryAux.Free;
  end;
end;

function TRepositorioNotasFiscais.fRetNotasVendasAtivoImobilizadoPorPeriodo(dtaIni, dtaFin: TDateTime; strCodEmp: string): TObjectList<TNotaFiscal>;
  var
    NotaNormal: TNotaFiscal;
    NotaFiscalDetalhada: TNotaFiscalDetalhada;
    ItemNota: TItemNotaFiscal;
    intContador: Integer;
    qryAux: TUniQuery;
    strChaveAtual, strChaveNotaNormal: string;
begin
  Result := TobjectList<TNotaFiscal>.Create;

  NotaNormal := nil;
  strChaveAtual := '';
  strChaveNotaNormal := '';

  qryAux := fCriaQuery(nil);
  try
    try
      with qryAux do
      begin
        Close;
        SQL.Clear;

        SQL.Add(fRetSqlTodasNotasFiscaisVendasAtivoImobilizadoPorPeriodo);
        ParamByName('DTAINI').AsDateTime := dtaIni;
        ParamByName('DTAFIN').AsDateTime := dtaFin;
        ParamByName('CODEMP').AsString := strCodEmp;

        Open;

        First;
        while not Eof do
        begin
          strChaveAtual := fRetChaveAtual(FieldByName('FIS_SERIE_').AsString,
                                          FieldByName('FIS_TIP_FC').AsString,
                                          FieldByName('FIS_ESPDOC').AsString,
                                          FieldByName('FIS_NUMDOC').AsString,
                                          FieldByName('FIS_CODEMP').AsString,
                                          FieldByName('FIS_FORCLI').AsString);

          if strChaveAtual <> strChaveNotaNormal then
          begin
            strChaveNotaNormal := strChaveAtual;

            NotaNormal := TNotaFiscal.Create;

            NotaNormal.strSerie := FieldByName('FIS_SERIE_').AsString;
            NotaNormal.strTipFc := FieldByName('FIS_TIP_FC').AsString;
            NotaNormal.strNumero := FieldByName('FIS_NUMDOC').AsString;
            NotaNormal.strEspecie := FieldByName('FIS_ESPDOC').AsString;
            NotaNormal.strEmpresa := FieldByName('FIS_CODEMP').AsString;
            NotaNormal.participante.strCodigo := FieldByName('FIS_FORCLI').AsString;
            NotaNormal.participante.strNome := FieldByName('NOME').AsString;
            NotaNormal.participante.strCgcCpf := FieldByName('CNPJ').AsString;
            NotaNormal.participante.intCgcCpfInt := StrToInt64Def(FieldByName('CNPJ').AsString, 0);
            NotaNormal.participante.cidade.strCodigoIbge := FieldByName('CODIGO_IBGE').AsString;
            NotaNormal.strChaveAcesso := FieldByName('FIS_ACESSO').AsString;
            NotaNormal.strEstado := FieldByName('FIS_ESTADO').AsString;
            NotaNormal.strHistorico := FieldByName('FIS_HISTOR').AsString;
            NotaNormal.strCfop1 := FieldByName('FIS_CLFSC1').AsString;
            NotaNormal.strCfop2 := FieldByName('FIS_CLFSC2').AsString;
            NotaNormal.strCfop3 := FieldByName('FIS_CLFSC3').AsString;
            NotaNormal.strCfop4 := FieldByName('FIS_CLFSC4').AsString;
            NotaNormal.strCfop5 := FieldByName('FIS_CLFSC5').AsString;
            NotaNormal.fltVlrIcm1 := FieldByName('FIS_VLRIC1').AsFloat;
            NotaNormal.fltVlrIcm2 := FieldByName('FIS_VLRIC2').AsFloat;
            NotaNormal.fltVlrIcm3 := FieldByName('FIS_VLRIC3').AsFloat;
            NotaNormal.fltVlrIcm4 := FieldByName('FIS_VLRIC4').AsFloat;
            NotaNormal.fltVlrIcm5 := FieldByName('FIS_VLRIC5').AsFloat;
            NotaNormal.fltBasIss := 0.00;
            NotaNormal.fltAlqIss := 0.00;
            NotaNormal.fltValIss := 0.00;
            NotaNormal.fltBasPis := 0.00;
            NotaNormal.fltAlqPis := 0.00;
            NotaNormal.fltValPis := 0.00;
            NotaNormal.fltBasCof := 0.00;
            NotaNormal.fltAlqCof := 0.00;
            NotaNormal.fltValCof := 0.00;
            NotaNormal.fltFrete := FieldByName('GER_TOTFRE').AsFloat;
            NotaNormal.fltOutras := FieldByName('FIS_OUTRAS').AsFloat;
            NotaNormal.fltDesconto := FieldByName('GER_DESESP').AsFloat;
            NotaNormal.fltValorContabil := FieldByName('FIS_VLRCON').AsFloat;
            NotaNormal.dtaDtaDoc := FieldByName('FIS_DTADOC').AsDateTime;
            NotaNormal.dtaDtaEnt := FieldByName('FIS_DTAENT').AsDateTime;

            Result.Add(NotaNormal);

            for intContador := 1 to 5 do
            begin
              if not fEmptyStr(FieldByName('FIS_CLFSC' + IntToStr(intContador)).AsString) then
              begin
                NotaFiscalDetalhada := TNotaFiscalDetalhada.Create;
                NotaFiscalDetalhada.strCfop := FieldByName('FIS_CLFSC' + IntToStr(intContador)).AsString;
                NotaFiscalDetalhada.fltValorContabil := FieldByName('FIS_VLCON' + IntToStr(intContador)).AsFloat;
                NotaFiscalDetalhada.fltBaseIcms := FieldByName('FIS_BASIC' + IntToStr(intContador)).AsFloat;
                NotaFiscalDetalhada.fltAliquotaIcms := FieldByName('FIS_ALQIC' + IntToStr(intContador)).AsFloat;
                NotaFiscalDetalhada.fltValorIcms := FieldByName('FIS_VLRIC' + IntToStr(intContador)).AsFloat;
                NotaFiscalDetalhada.fltValorOutras := FieldByName('FIS_OUTRA' + IntToStr(intContador)).AsFloat;
                NotaFiscalDetalhada.fltValorIsentas := FieldByName('FIS_ISENT' + IntToStr(intContador)).AsFloat;

                NotaNormal.notaFiscalDetalhada.Add(NotaFiscalDetalhada);
              end;
            end;
          end;

          ItemNota := TItemNotaFiscal.Create;

          ItemNota.strCodIte := FieldByName('DET_CODITE').AsString;
          ItemNota.strDesIte := FieldByName('DET_DESCRI').AsString;
          ItemNota.strUnidade := FieldByName('DET_UNIDAD').AsString;
          ItemNota.fltValorContabil := FieldByName('DET_VLRCON').AsFloat;
          ItemNota.fltValBru := FieldByName('DET_TOTITE').AsFloat;
          ItemNota.fltValFre := FieldByName('DET_TOTFRE').AsFloat;
          ItemNota.fltQuantidade := FieldByName('DET_QTDITE').AsFloat;
          ItemNota.fltValorUnitario := FieldByName('DET_UNITAR').AsFloat;
          ItemNota.strCFOP := FieldByName('DET_CLAFIS').AsString;
          ItemNota.fltValorIpi := FieldByName('DET_VALIPI').AsFloat;
          ItemNota.fltDesconto := FieldByName('DET_DESESP').AsFloat;
          ItemNota.fltDesAce := FieldByName('DET_DESACE').AsFloat;
          ItemNota.strCstIcm := FieldByName('DET_CODFIS').AsString;
          ItemNota.fltBasIcm := FieldByName('DET_BASICM').AsFloat;
          ItemNota.fltAlqIcm := FieldByName('DET_ALQICM').AsFloat;
          ItemNota.fltValIcm := FieldByName('DET_VALICM').AsFloat;
          ItemNota.strCstIpi := FieldByName('DET_CSTIPI').AsString;
          ItemNota.fltBasIpi := FieldByName('DET_BASIPI').AsFloat;
          ItemNota.fltAlqIpi := FieldByName('DET_ALQIPI').AsFloat;
          ItemNota.fltValIpi := FieldByName('DET_VALIPI').AsFloat;
          ItemNota.fltBasRet := FieldByName('DET_BASRET').AsFloat;
          ItemNota.fltValRet := FieldByName('DET_VALRET').AsFloat;
          ItemNota.fltOutIcm := FieldByName('DET_OUTICM').AsFloat;
          ItemNota.strCstPis := FieldByName('DET_CSTPIS').AsString;
          ItemNota.fltBasPis := FieldByName('DET_BASPIS').AsFloat;
          ItemNota.fltAlqPis := FieldByName('DET_ALQPIS').AsFloat;
          ItemNota.fltValPis := FieldByName('DET_VALPIS').AsFloat;
          ItemNota.strCstCof := FieldByName('DET_CSTCOF').AsString;
          ItemNota.fltBasCof := FieldByName('DET_BASCOF').AsFloat;
          ItemNota.fltAlqCof := FieldByName('DET_ALQCOF').AsFloat;
          ItemNota.fltValCof := FieldByName('DET_VALCOF').AsFloat;

          NotaNormal.pAdicionarItem(ItemNota);

          Next;
        end;
      end;
    except
      on E: Exception do
      begin
        {$IFDEF MSWINDOWS}
        fMensagem('Atenção', E.Message, ['OK']);
        {$ENDIF}
      end;
    end;
  finally
    qryAux.Free;
  end;
end;

function TRepositorioNotasFiscais.fRetSqlNotaCompraSubApuracaoIcms(abertura: TDadosAbertura): string;
begin
  Result := '';

  Result := Result + 'SELECT ';
  Result := Result + '   IF(((IFNULL(FIS_HISTOR, "") LIKE "%INUTILI%") AND (FIS_ESPDOC IN ("IF", "IV"))), "65",';
  Result := Result + '     IF(IFNULL(FIS_HISTOR, "") LIKE "%INUTILI%", "55", IF(FIS_SERIE_ BETWEEN 890 AND 899, "55", IF( (FIS_ESPDOC = "NF") AND (IFNULL(FIS_ACESSO,"") = "") , "01", ';
  Result := Result + '     IF( ( (FIS_ESPDOC IN ("NF", "NV")) AND (IFNULL(FIS_ACESSO,"") <> "") ) OR ';
  Result := Result + '           (FIS_ESPDOC = "EL"), "55", ';
  Result := Result + '       IF( FIS_ESPDOC IN ("IF", "IV"), IF(IFNULL(FIS_ACESSO,"")="", "2D", "65"), "01" ) ) ) ) ) ) AS MODELO, ';
  Result := Result + '  ROUND((((IFNULL(D.DET_BASRET, 0) + IFNULL(T.DET_BAERET, 0)) * 18) / 100) / D.DET_QTDITE, 2) AS ST_UNITARIA, '; //faz o calculo pela base fixando 18% e não o retido da nota
  Result := Result + '  IF( D.DET_IDEPRO = "NOR", I.ITE_PRECOM * ((100-I.ITE_DESF01)/100) * ((100-I.ITE_DESF02)/100) * ((100-I.ITE_DESF03)/100) * ';
  Result := Result + '  ((100-I.ITE_DESF04)/100) * ((100-I.ITE_DESF05)/100) * ((100-I.ITE_DESF06)/100), ';
  Result := Result + '  T.DET_COMLIQ ) ';
  Result := Result + '  * ((100+I.ITE_IPIENT)/100) * ((100+I.ITE_FREENT)/100) * ABF_IVA_ST_ENT_PEJ   AS COMLIQ_IPI_FRETE_IVA, ';
  Result := Result + '  IFNULL(D.DET_SERIE_, "") AS SERIE, ';
  Result := Result + '  IFNULL(FIS_FORCLI, "") AS FORCLI, ';
  Result := Result + '  IFNULL(FIS_ACESSO, "") AS ACESSO, ';

  Result := Result + '  FOR_C_G_C_ AS C_G_C_, ';
  Result := Result + '  FOR_NOMFOR AS NOME, ';
  Result := Result + '  IFNULL(CF.CID_CODCID, "00000") AS CODCID, ';

  Result := Result + '  D.DET_NUMDOC AS DOCUMENTO, ';
  Result := Result + '  D.DET_TIP_FC AS TIP_FC, ';
  Result := Result + '  D.DET_DTAENT AS DTAENT, ';
  Result := Result + '  D.DET_CODITE AS CODITE, ';
  Result := Result + '  D.DET_CLAFIS AS CLAFIS, ';
  Result := Result + '  D.DET_QTDITE AS QTDITE, ';
  Result := Result + '  D.DET_BASRET AS BASRET, ';
  Result := Result + '  T.DET_BAERET AS BAERET ';
  Result := Result + 'FROM ';
  Result := Result + '  CADFIS ';

  Result := Result + '  INNER JOIN MOVDET D ';
  Result := Result + '    ON D.DET_NUMDOC = FIS_NUMDOC ';
  Result := Result + '    AND D.DET_CODEMP = FIS_CODEMP  ';
  Result := Result + '    AND D.DET_ESPDOC = FIS_ESPDOC ';
  Result := Result + '    AND IFNULL(D.DET_SERIE_, "") = IFNULL(FIS_SERIE_, "") ';
  Result := Result + '    AND IF(FIS_TIP_FC = "C", D.DET_CODCLI, D.DET_CODFOR) = FIS_FORCLI ';

  Result := Result + '  LEFT JOIN MOVTRI T ';
  Result := Result + '    ON T.DET_SEQGER = D.AUTOINCREM ';

  Result := Result + '  LEFT JOIN CADFOR ';
  Result := Result + '    ON FOR_CODFOR = D.DET_CODFOR ';
  Result := Result + '  LEFT JOIN CADCID CF ON CF.CID_CODCID = FOR_CODCID ';

  Result := Result + '  LEFT  JOIN ITEGER G  ';
  Result := Result + '    ON D.DET_CODITE = G.ITE_CODITE ';
  Result := Result + '    AND D.DET_CODEMP = G.ITE_CODEMP ';

  Result := Result + '  LEFT JOIN ' + fRetTabelaInventario(abertura) + ' I ';
  Result := Result + '    ON I.ITE_CODITE = D.DET_CODITE ';
  Result := Result + '    AND I.ITE_CODEMP = D.DET_CODEMP ';

  Result := Result + '  LEFT JOIN ABFICM E ';
  Result := Result + '    ON E.ABF_CODABF = I.ITE_CODABF ';
  Result := Result + '    AND E.ABF_ESTADO = "RS" ';

  Result := Result + 'WHERE LOCATE(RIGHT(D.DET_CODFIS, 2), "10_60_70") > 0 ';
  //#Ver com a Cristiane 26062020
  Result := Result + '  AND (IFNULL(D.DET_PROEMB, "") IN ("", "N")) ';
  Result := Result + '  AND D.DET_NUMDOC = :NUMDOC ';
  Result := Result + '  AND D.DET_CODEMP = :CODEMP ';
  Result := Result + '  AND D.DET_ESPDOC = :ESPDOC ';
  Result := Result + '  AND D.DET_CODFOR = :CODFOR ';
  Result := Result + '  AND D.DET_CODITE = :CODITE ';
  Result := Result + '  AND D.DET_SERIE_ = :SERIE ';
end;

function TRepositorioNotasFiscais.fRetSqlNotaCompraSubApuracaoIcmsDocDevolucao(abertura: TDadosAbertura): string;
begin
  //#3

  Result := '';

  Result := Result + 'SELECT ';
  Result := Result + '   IF(((IFNULL(FIS_HISTOR, "") LIKE "%INUTILI%") AND (FIS_ESPDOC IN ("IF", "IV"))), "65",';
  Result := Result + '     IF(IFNULL(FIS_HISTOR, "") LIKE "%INUTILI%", "55", IF(FIS_SERIE_ BETWEEN 890 AND 899, "55", IF( (FIS_ESPDOC = "NF") AND (IFNULL(FIS_ACESSO,"") = "") , "01", ';
  Result := Result + '     IF( ( (FIS_ESPDOC IN ("NF", "NV")) AND (IFNULL(FIS_ACESSO,"") <> "") ) OR ';
  Result := Result + '           (FIS_ESPDOC = "EL"), "55", ';
  Result := Result + '       IF( FIS_ESPDOC IN ("IF", "IV"), IF(IFNULL(FIS_ACESSO,"")="", "2D", "65"), "01" ) ) ) ) ) ) AS MODELO, ';
  Result := Result + '  ROUND((((IFNULL(D.DET_BASRET, 0) + IFNULL(T.DET_BAERET, 0)) * 18) / 100) / D.DET_QTDITE, 2) AS ST_UNITARIA, '; //faz o calculo pela base fixando 18% e não o retido da nota
  Result := Result + '  IF( D.DET_IDEPRO = "NOR", I.ITE_PRECOM * ((100-I.ITE_DESF01)/100) * ((100-I.ITE_DESF02)/100) * ((100-I.ITE_DESF03)/100) * ';
  Result := Result + '  ((100-I.ITE_DESF04)/100) * ((100-I.ITE_DESF05)/100) * ((100-I.ITE_DESF06)/100), ';
  Result := Result + '  T.DET_COMLIQ ) ';
  Result := Result + '  * ((100+I.ITE_IPIENT)/100) * ((100+I.ITE_FREENT)/100) * ABF_IVA_ST_ENT_PEJ   AS COMLIQ_IPI_FRETE_IVA, ';
  Result := Result + '  IFNULL(D.DET_SERIE_, "") AS SERIE, ';
  Result := Result + '  IFNULL(FIS_FORCLI, "") AS FORCLI, ';
  Result := Result + '  IFNULL(FIS_ACESSO, "") AS ACESSO, ';

  Result := Result + '  IF(FIS_TIP_FC = "C", CLI_C_G_C_, FOR_C_G_C_) AS C_G_C_, ';
  Result := Result + '  IF(FIS_TIP_FC = "C", CLI_NOMCLI, FOR_NOMFOR) AS NOME, ';

  Result := Result + '  IF(FIS_TIP_FC = "C", CLI_C_E_P_, FOR_C_E_P_) AS CEP, ';
  Result := Result + '  IF(FIS_TIP_FC = "C", CLI_BAIRRO, FOR_BAIRRO) AS BAIRRO, ';
  Result := Result + '  IF(FIS_TIP_FC = "C", CLI_ENDERE, FOR_ENDERE) AS ENDERECO, ';
  Result := Result + '  IF(FIS_TIP_FC = "C", CLI_FONE01, FOR_FONE01) AS TELEFONE, ';
  Result := Result + '  IF(FIS_TIP_FC = "C", IFNULL(CC.CID_CODCID, "00000"), IFNULL(CF.CID_CODCID, "00000")) AS CODCID, ';

  Result := Result + '  D.DET_NUMDOC AS DOCUMENTO, ';
  Result := Result + '  D.DET_TIP_FC AS TIP_FC, ';
  Result := Result + '  D.DET_DTAENT AS DTAENT, ';
  Result := Result + '  D.DET_CODITE AS CODITE, ';
  Result := Result + '  D.DET_CLAFIS AS CLAFIS, ';
  Result := Result + '  D.DET_QTDITE AS QTDITE, ';
  Result := Result + '  D.DET_BASRET AS BASRET, ';
  Result := Result + '  D.DET_DOCDEV AS DOCDEV, ';
  Result := Result + '  T.DET_BAERET AS BAERET, ';

  Result := Result + '  MOVAUX.DET_VICMEF AS VICMEF, ';
  Result := Result + '  MOVAUX.DET_BICMEF AS BICMEF, ';
  Result := Result + '  MOVAUX.DET_AICMEF AS AICMEF ';

  Result := Result + 'FROM ';
  Result := Result + '  CADFIS ';

  Result := Result + '  INNER JOIN MOVDET D ';
  Result := Result + '    ON D.DET_NUMDOC = FIS_NUMDOC ';
  Result := Result + '    AND D.DET_CODEMP = FIS_CODEMP  ';
  Result := Result + '    AND D.DET_ESPDOC = FIS_ESPDOC ';
  Result := Result + '    AND IFNULL(D.DET_SERIE_, "") = IFNULL(FIS_SERIE_, "") ';
  Result := Result + '    AND IF(FIS_TIP_FC = "C", D.DET_CODCLI, D.DET_CODFOR) = FIS_FORCLI ';

  Result := Result + '  LEFT JOIN MOVAUX ';
  Result := Result + '    ON MOVAUX.DET_SEQGER = D.AUTOINCREM ';

  Result := Result + '  LEFT JOIN MOVTRI T ';
  Result := Result + '    ON T.DET_SEQGER = D.AUTOINCREM ';

  Result := Result + '  LEFT JOIN CADFOR ';
  Result := Result + '    ON FOR_CODFOR = FIS_FORCLI ';
  Result := Result + '  LEFT JOIN CADCID CF ON CF.CID_CODCID = FOR_CODCID ';

  Result := Result + '  LEFT JOIN CADCLI ';
  Result := Result + '    ON CLI_CODCLI = FIS_FORCLI ';
  Result := Result + '  LEFT JOIN CADCID CC ON CC.CID_CODCID = CLI_CODCID ';

  Result := Result + '  LEFT  JOIN ITEGER G  ';
  Result := Result + '    ON D.DET_CODITE = G.ITE_CODITE ';
  Result := Result + '    AND D.DET_CODEMP = G.ITE_CODEMP ';

  Result := Result + '  LEFT JOIN ' + fRetTabelaInventario(abertura) + ' I ';
  Result := Result + '    ON I.ITE_CODITE = D.DET_CODITE ';
  Result := Result + '    AND I.ITE_CODEMP = D.DET_CODEMP ';

  Result := Result + '  LEFT JOIN ABFICM E ';
  Result := Result + '    ON E.ABF_CODABF = I.ITE_CODABF ';
  Result := Result + '    AND E.ABF_ESTADO = "RS" ';

  Result := Result + 'WHERE FIS_DTAENT BETWEEN :DTAINI ';
  Result := Result + '  AND :DTAFIN ';

  Result := Result + '  AND LOCATE(RIGHT(D.DET_CODFIS, 2), "10_60_70") > 0 ';
  Result := Result + '  AND D.DET_CODEMP = :CODEMP ';
  Result := Result + '  AND (D.DET_DOCDEV IS NOT NULL OR D.DET_DOCDEV <> "")';

  If Not fEmptyStr(VS_strFiltroNumDoc) Then
    Result := Result + '  AND FIS_NUMDOC = "'+VS_strFiltroNumDoc+'" ';
end;

function TRepositorioNotasFiscais.fRetSqlNotaCompraSubApuracaoIcmsDevDocumento(
  abertura: TDadosAbertura; strCampoBusca: string): string;
begin
  Result := '';

  Result := Result + 'SELECT ';
  Result := Result + '   IF(((IFNULL(FIS_HISTOR, "") LIKE "%INUTILI%") AND (FIS_ESPDOC IN ("IF", "IV"))), "65",';
  Result := Result + '     IF(IFNULL(FIS_HISTOR, "") LIKE "%INUTILI%", "55", IF(FIS_SERIE_ BETWEEN 890 AND 899, "55", IF( (FIS_ESPDOC = "NF") AND (IFNULL(FIS_ACESSO,"") = "") , "01", ';
  Result := Result + '     IF( ( (FIS_ESPDOC IN ("NF", "NV")) AND (IFNULL(FIS_ACESSO,"") <> "") ) OR ';
  Result := Result + '           (FIS_ESPDOC = "EL"), "55", ';
  Result := Result + '       IF( FIS_ESPDOC IN ("IF", "IV"), IF(IFNULL(FIS_ACESSO,"")="", "2D", "65"), "01" ) ) ) ) ) ) AS MODELO, ';
  Result := Result + '  ROUND((((IFNULL(D.DET_BASRET, 0) + IFNULL(T.DET_BAERET, 0)) * 18) / 100) / D.DET_QTDITE, 2) AS ST_UNITARIA, '; //faz o calculo pela base fixando 18% e não o retido da nota
  Result := Result + '  IF( D.DET_IDEPRO = "NOR", I.ITE_PRECOM * ((100-I.ITE_DESF01)/100) * ((100-I.ITE_DESF02)/100) * ((100-I.ITE_DESF03)/100) * ';
  Result := Result + '  ((100-I.ITE_DESF04)/100) * ((100-I.ITE_DESF05)/100) * ((100-I.ITE_DESF06)/100), ';
  Result := Result + '  T.DET_COMLIQ ) ';
  Result := Result + '  * ((100+I.ITE_IPIENT)/100) * ((100+I.ITE_FREENT)/100) * ABF_IVA_ST_ENT_PEJ   AS COMLIQ_IPI_FRETE_IVA, ';
  Result := Result + '  IFNULL(D.DET_SERIE_, "") AS SERIE, ';
  Result := Result + '  IFNULL(FIS_FORCLI, "") AS FORCLI, ';
  Result := Result + '  IFNULL(FIS_ACESSO, "") AS ACESSO, ';

  Result := Result + '  IF(FIS_TIP_FC = "C", CLI_C_G_C_, FOR_C_G_C_) AS C_G_C_, ';
  Result := Result + '  IF(FIS_TIP_FC = "C", CLI_NOMCLI, FOR_NOMFOR) AS NOME, ';

  Result := Result + '  IF(FIS_TIP_FC = "C", CLI_C_E_P_, FOR_C_E_P_) AS CEP, ';
  Result := Result + '  IF(FIS_TIP_FC = "C", CLI_BAIRRO, FOR_BAIRRO) AS BAIRRO, ';
  Result := Result + '  IF(FIS_TIP_FC = "C", CLI_ENDERE, FOR_ENDERE) AS ENDERECO, ';
  Result := Result + '  IF(FIS_TIP_FC = "C", CLI_FONE01, FOR_FONE01) AS TELEFONE, ';
  Result := Result + '  IF(FIS_TIP_FC = "C", IFNULL(CC.CID_CODCID, "00000"), IFNULL(CF.CID_CODCID, "00000")) AS CODCID, ';

  Result := Result + '  D.DET_NUMDOC AS DOCUMENTO, ';
  Result := Result + '  D.DET_TIP_FC AS TIP_FC, ';
  Result := Result + '  D.DET_DTAENT AS DTAENT, ';
  Result := Result + '  D.DET_CODITE AS CODITE, ';
  Result := Result + '  D.DET_CLAFIS AS CLAFIS, ';
  Result := Result + '  D.DET_QTDITE AS QTDITE, ';
  Result := Result + '  D.DET_BASRET AS BASRET, ';
  Result := Result + '  D.DET_DOCDEV AS DOCDEV, ';
  Result := Result + '  T.DET_BAERET AS BAERET, ';

  Result := Result + '  MOVAUX.DET_VICMEF AS VICMEF, ';
  Result := Result + '  MOVAUX.DET_BICMEF AS BICMEF, ';
  Result := Result + '  MOVAUX.DET_AICMEF AS AICMEF ';

  Result := Result + 'FROM ';
  Result := Result + '  CADFIS ';

  Result := Result + '  INNER JOIN MOVDET D ';
  Result := Result + '    ON D.DET_NUMDOC = FIS_NUMDOC ';
  Result := Result + '    AND D.DET_CODEMP = FIS_CODEMP  ';
  Result := Result + '    AND D.DET_ESPDOC = FIS_ESPDOC ';
  Result := Result + '    AND IFNULL(D.DET_SERIE_, "") = IFNULL(FIS_SERIE_, "") ';
  Result := Result + '    AND IF(FIS_TIP_FC = "C", D.DET_CODCLI, D.DET_CODFOR) = FIS_FORCLI ';

  Result := Result + '  LEFT JOIN MOVAUX ';
  Result := Result + '    ON MOVAUX.DET_SEQGER = D.AUTOINCREM ';

  Result := Result + '  LEFT JOIN MOVTRI T ';
  Result := Result + '    ON T.DET_SEQGER = D.AUTOINCREM ';

  Result := Result + '  LEFT JOIN CADFOR ';
  Result := Result + '    ON FOR_CODFOR = FIS_FORCLI ';
  Result := Result + '  LEFT JOIN CADCID CF ON CF.CID_CODCID = FOR_CODCID ';

  Result := Result + '  LEFT JOIN CADCLI ';
  Result := Result + '    ON CLI_CODCLI = FIS_FORCLI ';
  Result := Result + '  LEFT JOIN CADCID CC ON CC.CID_CODCID = CLI_CODCID ';

  Result := Result + '  LEFT  JOIN ITEGER G  ';
  Result := Result + '    ON D.DET_CODITE = G.ITE_CODITE ';
  Result := Result + '    AND D.DET_CODEMP = G.ITE_CODEMP ';

  Result := Result + '  LEFT JOIN ' + fRetTabelaInventario(abertura) + ' I ';
  Result := Result + '    ON I.ITE_CODITE = D.DET_CODITE ';
  Result := Result + '    AND I.ITE_CODEMP = D.DET_CODEMP ';

  Result := Result + '  LEFT JOIN ABFICM E ';
  Result := Result + '    ON E.ABF_CODABF = I.ITE_CODABF ';
  Result := Result + '    AND E.ABF_ESTADO = "RS" ';

  Result := Result + 'WHERE FIS_DTAENT BETWEEN :DTAINI ';
  Result := Result + '  AND :DTAFIN ';

  Result := Result + '  AND LOCATE(RIGHT(D.DET_CODFIS, 2), "10_60_70") > 0 ';
  Result := Result + '  AND D.DET_CODEMP = :CODEMP ';
  Result := Result + '  AND D.DET_' + strCampoBusca + ' = :NUMDOC';
  Result := Result + '  AND D.DET_CODITE = :CODITE ';

end;

function TRepositorioNotasFiscais.fRetSqlTodasNotasCompraSubApuracaoIcms(abertura: TDadosAbertura): string;
  function fRetTabelaInventario(abertura: TDadosAbertura): string;
    var
      intDia, intMes, intAno: word;
      dataMesAnterior: TDateTime;
  begin
    dataMesAnterior := abertura.dtaDataInicial;
    DecodeDate(dataMesAnterior, intAno, intMes, intDia);

    Result := 'I_' + FormatDateTime('YYYYMM', dataMesAnterior);
  end;

  var
    blnExisteTabelaInventario: boolean;
    strTabelaInventarioLocal: string;
begin
  strTabelaInventarioLocal := fRetTabelaInventario(abertura);
  blnExisteTabelaInventario := fTabelaExiste(strTabelaInventarioLocal);

  Result := Result + 'SELECT ';

  if FExisteMovAux then
  begin
    Result := Result + '  MA.DET_VSTANT AS VALOR_ST_COMPRA_PROPORCIONAL, ' ;
    Result := Result + '  MA.DET_VICMEF AS VLR_EFETIVO, ';
  end
  else
  begin
    Result := Result + '  0 AS VALOR_ST_COMPRA_PROPORCIONAL, ' ;
    Result := Result + '  0 AS VLR_EFETIVO, ';
  end;

  Result := Result + '  ABF_IVA_ST_ENT_PEJ AS IVA_ST, ' ;

  if blnExisteTabelaInventario then
  begin
    Result := Result + '  IF(IFNULL(D.DET_IDEPRO, "NOR") = "NOR", I.ITE_PRECOM * ((100-I.ITE_DESF01)/100) * ((100-I.ITE_DESF02)/100) * ((100-I.ITE_DESF03)/100) * ';
    Result := Result + ' ((100-I.ITE_DESF04)/100) * ((100-I.ITE_DESF05)/100) * ((100-I.ITE_DESF06)/100), ';
    Result := Result + '  T.DET_COMLIQ ) ';
    Result := Result + ' * ((100+I.ITE_IPIENT)/100) * ((100+I.ITE_FREENT)/100) * ABF_IVA_ST_ENT_PEJ AS COMLIQ_IPI_FRETE_IVA, ';
  end
  else
  begin
    Result := Result + '  @RESULT := GER.ITE_PRECOM, ';
    Result := Result + '  @RESULT := ( ';
    Result := Result + '    @RESULT * IFNULL((1 - (GER.ITE_DESF01) / 100), 0) ';
    Result := Result + '  ), ';
    Result := Result + '  @RESULT := ( ';
    Result := Result + '    @RESULT * IFNULL((1 - (GER.ITE_DESF02) / 100), 0) ';
    Result := Result + '  ), ';
    Result := Result + '  @RESULT := ( ';
    Result := Result + '    @RESULT * IFNULL((1 - (GER.ITE_DESF03) / 100), 0) ';
    Result := Result + '  ), ';
    Result := Result + '  @RESULT := ( ';
    Result := Result + '    @RESULT * IFNULL((1 - (GER.ITE_DESF04) / 100), 0) ';
    Result := Result + '  ), ';
    Result := Result + '  @RESULT := ( ';
    Result := Result + '    @RESULT * IFNULL((1 - (GER.ITE_DESF05) / 100), 0) ';
    Result := Result + '  ), ';
    Result := Result + '  @RESULT := ( ';
    Result := Result + '    @RESULT * IFNULL((1 - (GER.ITE_DESF06) / 100), 0) ';
    Result := Result + '  ), ';
    Result := Result + '  @PRECOM_LIQ_IPI := @RESULT + (@RESULT * IFNULL((GER.ITE_IPIENT / 100), 0)), ';
    Result := Result + '  @PRECO_COMPRA_LIQ_IPI_FRE := ROUND( ';
    Result := Result + '    @PRECOM_LIQ_IPI + (@RESULT * IFNULL((GER.ITE_FREENT / 100), 0)), ';
    Result := Result + '    2 ';
    Result := Result + '  ) * ABF_IVA_ST_ENT_PEJ AS COMLIQ_IPI_FRETE_IVA, ';
  end;

  Result := Result + '  IFNULL(D.DET_BASRET, 0) + IFNULL(T.DET_BAERET, 0) '+IIF(FExisteMovAux,'+ IFNULL(MA.DET_BSTANT, 0)','')+' AS BASE_RETIDO, ';
  Result := Result + '  IFNULL(D.DET_VALRET, 0) + IFNULL(T.DET_VAERET, 0) '+IIF(FExisteMovAux,'+ IFNULL(MA.DET_VSTANT, 0)','')+' AS RETIDO, ';

  Result := Result + '  IF(FIS_TIP_FC = "C", CLI_CODCLI, FOR_CODFOR) AS CODPAR, ';
  Result := Result + '  IF(FIS_TIP_FC = "C", CLI_NOMCLI, FOR_NOMFOR) AS NOMPAR, ';
  Result := Result + '  IF(FIS_TIP_FC = "C", CLI_C_G_C_, FOR_C_G_C_) AS CGCPAR, ';
  Result := Result + '  IF(FIS_TIP_FC = "C", IFNULL(CC.CID_CODCID, "00000"), IFNULL(CF.CID_CODCID, "00000")) AS CODCID, ';

  Result := Result + '  D.DET_CLAFIS AS CFOP, ';
  Result := Result + '  D.DET_QTDITE AS QTDITE, ';
  Result := Result + '  IFNULL(FIS_ACESSO, "") AS ACESSO, ';
  Result := Result + '  D.DET_CODITE AS CODITE, ';
  Result := Result + '  D.DET_CLAFIS AS CLAFIS, ';
  Result := Result + '   IF(((IFNULL(FIS_HISTOR, "") LIKE "%INUTILI%") AND (FIS_ESPDOC IN ("IF", "IV"))), "65",';
  Result := Result + '     IF(IFNULL(FIS_HISTOR, "") LIKE "%INUTILI%", "55", IF(FIS_SERIE_ BETWEEN 890 AND 899, "55", IF( (FIS_ESPDOC = "NF") AND (IFNULL(FIS_ACESSO,"") = "") , "01", ';
  Result := Result + '     IF( ( (FIS_ESPDOC IN ("NF", "NV")) AND (IFNULL(FIS_ACESSO,"") <> "") ) OR ';
  Result := Result + '           (FIS_ESPDOC = "EL"), "55", ';
  Result := Result + '       IF( FIS_ESPDOC IN ("IF", "IV"), IF(IFNULL(FIS_ACESSO,"")="", "2D", "65"), "01" ) ) ) ) ) ) AS MODELO, ';
  Result := Result + '  FIS_NUMDOC AS NUMDOC, ';
  Result := Result + '  FIS_SERIE_ AS SERIE, ';
  Result := Result + '  FIS_DTAENT AS DTAENT, ';
  Result := Result + '  FIS_TIP_FC AS TIP_FC ';

  Result := Result + 'FROM ';
  Result := Result + '  CADFIS ';

  Result := Result + '  INNER JOIN MOVDET D ';
  Result := Result + '    ON D.DET_NUMDOC = FIS_NUMDOC ';
  Result := Result + '    AND D.DET_CODEMP = FIS_CODEMP ';
  Result := Result + '    AND D.DET_ESPDOC = FIS_ESPDOC ';
  Result := Result + '    AND IFNULL(D.DET_SERIE_, "") = IFNULL(FIS_SERIE_, "")';
  Result := Result + '    AND IF(FIS_TIP_FC = "C", D.DET_CODCLI, D.DET_CODFOR) = FIS_FORCLI ';

  Result := Result + '  LEFT JOIN MOVTRI T ';
  Result := Result + '    ON T.DET_SEQGER = D.AUTOINCREM ';

  if FExisteMovAux then
  begin
    Result := Result + '  LEFT JOIN MOVAUX MA ';
    Result := Result + '    ON MA.DET_SEQGER = D.AUTOINCREM ';
  end;

  Result := Result + '  LEFT JOIN CADCLI ';
  Result := Result + '    ON CLI_CODCLI = FIS_FORCLI ';
  Result := Result + '  LEFT JOIN CADCID CC ON CC.CID_CODCID = CLI_CODCID ';

  Result := Result + '  LEFT JOIN CADFOR ';
  Result := Result + '    ON FOR_CODFOR = FIS_FORCLI ';
  Result := Result + '  LEFT JOIN CADCID CF ON CF.CID_CODCID = FOR_CODCID ';

  Result := Result + '  LEFT JOIN CADITE ITE ';
  Result := Result + '    ON ITE.ITE_CODITE = D.DET_CODITE ';

  Result := Result + '  LEFT JOIN ITEGER GER ';
  Result := Result + '    ON GER.ITE_CODITE = D.DET_CODITE ';
  Result := Result + '    AND GER.ITE_CODEMP = D.DET_CODEMP ';

  if blnExisteTabelaInventario then
  begin
    Result := Result + '  LEFT JOIN ' + strTabelaInventarioLocal + ' I ';
    Result := Result + '    ON I.ITE_CODITE = D.DET_CODITE ';
    Result := Result + '    AND I.ITE_CODEMP = D.DET_CODEMP ';
  end;

  Result := Result + '  LEFT JOIN ABFICM ';

  if blnExisteTabelaInventario then
    Result := Result + '    ON ABF_CODABF = I.ITE_CODABF '
  else
    Result := Result + '    ON ABF_CODABF = ITE.ITE_CODABF ';

  Result := Result + '    AND ABF_ESTADO = "RS" ';

  Result := Result + 'WHERE FIS_DTAENT BETWEEN :DTAINI ';
  Result := Result + '  AND :DTAFIN ';
  Result := Result + '  AND FIS_CODEMP = :CODEMP ';
  Result := Result + '  AND LOCATE(FIS_ESPDOC, "NF_IF_IV_NV") > 0 ';
  Result := Result + '  AND LOCATE(D.DET_CLAFIS, :CLACOM) > 0 ';
  Result := Result + '  AND IFNULL(D.DET_PROEMB,"") <> "S" ';
  Result := Result + '  AND LOCATE(RIGHT(D.DET_CODFIS, 2), "10_60_70") > 0 ';

  Result := 'SELECT * FROM (' + Result + ') AS TAB ORDER BY CODITE ';
end;

function TRepositorioNotasFiscais.fRetSqlTodasNotasFiscaisCompraPeriodoPorProduto: string;
  var
    strSQL: string;
begin
  strSQL := '';

  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  IFNULL(FIS_ACESSO, "") AS FIS_ACESSO, ';
  strSQL := strSQL + '  IFNULL(FIS_HISTOR, "") AS FIS_HISTOR, ';
  strSQL := strSQL + '  FIS_ESTADO, ';
  strSQL := strSQL + '  FIS_NUMDOC, ';
  strSQL := strSQL + '  FIS_CODEMP, ';
  strSQL := strSQL + '  FIS_SERIE_, ';
  strSQL := strSQL + '  FIS_ESPDOC, ';
  strSQL := strSQL + '  FIS_FORCLI, ';
  strSQL := strSQL + '  FIS_TIP_FC, ';
  strSQL := strSQL + '  FIS_DTAENT, ';
  strSQL := strSQL + '  FIS_DTADOC, ';

  strSql := strSql + '   IF( (FIS_ESPDOC = "NF") AND (IFNULL(FIS_ACESSO,"") = "") , "01",     ';
  strSql := strSql + '     IF( ( (FIS_ESPDOC IN ("NF", "NV")) AND (IFNULL(FIS_ACESSO,"") <> "") ) OR   ';
  strSql := strSql + '           (FIS_ESPDOC = "EL"),  "55",                                  ';
  strSql := strSql + '       IF( FIS_ESPDOC IN ("IF", "IV"), IF(((IFNULL(FIS_ACESSO,"")="") AND (IFNULL(FIS_HISTOR, "") NOT LIKE "%INUTILI%")), "2D", "65"), "01" ) ) ) AS FIS_DOCMOD, ';
  strSQL := strSQL + '  IF(IFNULL(FIS_HISTOR, "") = "CANCELADO", "02", "00") AS FIS_SITDOC, ';

  strSQL := strSQL + '  IFNULL(FIS_CLFSC1, "") AS FIS_CLFSC1, ';
  strSQL := strSQL + '  IFNULL(FIS_CLFSC2, "") AS FIS_CLFSC2, ';
  strSQL := strSQL + '  IFNULL(FIS_CLFSC3, "") AS FIS_CLFSC3, ';
  strSQL := strSQL + '  IFNULL(FIS_CLFSC4, "") AS FIS_CLFSC4, ';
  strSQL := strSQL + '  IFNULL(FIS_CLFSC5, "") AS FIS_CLFSC5, ';

  strSQL := strSQL + '  IFNULL(FIS_VLCON1, 0) AS FIS_VLCON1, ';
  strSQL := strSQL + '  IFNULL(FIS_VLCON2, 0) AS FIS_VLCON2, ';
  strSQL := strSQL + '  IFNULL(FIS_VLCON3, 0) AS FIS_VLCON3, ';
  strSQL := strSQL + '  IFNULL(FIS_VLCON4, 0) AS FIS_VLCON4, ';
  strSQL := strSQL + '  IFNULL(FIS_VLCON5, 0) AS FIS_VLCON5, ';

  strSQL := strSQL + '  IFNULL(FIS_OUTRA1, 0) AS FIS_OUTRA1, ';
  strSQL := strSQL + '  IFNULL(FIS_OUTRA2, 0) AS FIS_OUTRA2, ';
  strSQL := strSQL + '  IFNULL(FIS_OUTRA3, 0) AS FIS_OUTRA3, ';
  strSQL := strSQL + '  IFNULL(FIS_OUTRA4, 0) AS FIS_OUTRA4, ';
  strSQL := strSQL + '  IFNULL(FIS_OUTRA5, 0) AS FIS_OUTRA5, ';

  strSQL := strSQL + '  IFNULL(FIS_BCRET1, 0) AS FIS_BCRET1, ';
  strSQL := strSQL + '  IFNULL(FIS_BCRET2, 0) AS FIS_BCRET2, ';
  strSQL := strSQL + '  IFNULL(FIS_BCRET3, 0) AS FIS_BCRET3, ';
  strSQL := strSQL + '  IFNULL(FIS_BCRET4, 0) AS FIS_BCRET4, ';
  strSQL := strSQL + '  IFNULL(FIS_BCRET5, 0) AS FIS_BCRET5, ';

  strSQL := strSQL + '  IFNULL(FIS_RETID1, 0) AS FIS_RETID1, ';
  strSQL := strSQL + '  IFNULL(FIS_RETID2, 0) AS FIS_RETID2, ';
  strSQL := strSQL + '  IFNULL(FIS_RETID3, 0) AS FIS_RETID3, ';
  strSQL := strSQL + '  IFNULL(FIS_RETID4, 0) AS FIS_RETID4, ';
  strSQL := strSQL + '  IFNULL(FIS_RETID5, 0) AS FIS_RETID5, ';

  strSQL := strSQL + '  IFNULL(FIS_ISENT1, 0) AS FIS_ISENT1, ';
  strSQL := strSQL + '  IFNULL(FIS_ISENT2, 0) AS FIS_ISENT2, ';
  strSQL := strSQL + '  IFNULL(FIS_ISENT3, 0) AS FIS_ISENT3, ';
  strSQL := strSQL + '  IFNULL(FIS_ISENT4, 0) AS FIS_ISENT4, ';
  strSQL := strSQL + '  IFNULL(FIS_ISENT5, 0) AS FIS_ISENT5, ';

  strSQL := strSQL + '  IFNULL(FIS_BASIC1, 0) AS FIS_BASIC1, ';
  strSQL := strSQL + '  IFNULL(FIS_BASIC2, 0) AS FIS_BASIC2, ';
  strSQL := strSQL + '  IFNULL(FIS_BASIC3, 0) AS FIS_BASIC3, ';
  strSQL := strSQL + '  IFNULL(FIS_BASIC4, 0) AS FIS_BASIC4, ';
  strSQL := strSQL + '  IFNULL(FIS_BASIC5, 0) AS FIS_BASIC5, ';

  strSQL := strSQL + '  IFNULL(FIS_ALQIC1, 0) AS FIS_ALQIC1, ';
  strSQL := strSQL + '  IFNULL(FIS_ALQIC2, 0) AS FIS_ALQIC2, ';
  strSQL := strSQL + '  IFNULL(FIS_ALQIC3, 0) AS FIS_ALQIC3, ';
  strSQL := strSQL + '  IFNULL(FIS_ALQIC4, 0) AS FIS_ALQIC4, ';
  strSQL := strSQL + '  IFNULL(FIS_ALQIC5, 0) AS FIS_ALQIC5, ';

  strSQL := strSQL + '  IFNULL(FIS_VLRIC1, 0) AS FIS_VLRIC1, ';
  strSQL := strSQL + '  IFNULL(FIS_VLRIC2, 0) AS FIS_VLRIC2, ';
  strSQL := strSQL + '  IFNULL(FIS_VLRIC3, 0) AS FIS_VLRIC3, ';
  strSQL := strSQL + '  IFNULL(FIS_VLRIC4, 0) AS FIS_VLRIC4, ';
  strSQL := strSQL + '  IFNULL(FIS_VLRIC5, 0) AS FIS_VLRIC5, ';

  strSQL := strSQL + '  IFNULL(FIS_BASIP1, 0) AS FIS_BASIP1, ';
  strSQL := strSQL + '  IFNULL(FIS_BASIP2, 0) AS FIS_BASIP2, ';
  strSQL := strSQL + '  IFNULL(FIS_BASIP3, 0) AS FIS_BASIP3, ';
  strSQL := strSQL + '  IFNULL(FIS_BASIP4, 0) AS FIS_BASIP4, ';
  strSQL := strSQL + '  IFNULL(FIS_BASIP5, 0) AS FIS_BASIP5, ';

  strSQL := strSQL + '  IFNULL(FIS_VLRIP1, 0) AS FIS_VLRIP1, ';
  strSQL := strSQL + '  IFNULL(FIS_VLRIP2, 0) AS FIS_VLRIP2, ';
  strSQL := strSQL + '  IFNULL(FIS_VLRIP3, 0) AS FIS_VLRIP3, ';
  strSQL := strSQL + '  IFNULL(FIS_VLRIP4, 0) AS FIS_VLRIP4, ';
  strSQL := strSQL + '  IFNULL(FIS_VLRIP5, 0) AS FIS_VLRIP5, ';

  strSql := strSql + '  IF(GER_CONPAG = "01000", "0", "1") AS FIS_COND_PG, ';
  strSql := strSql + '  GER_TIPFRE AS GER_TIPO_FRETE, ';
  strSQL := strSQL + '  GER_TOTFRE, ';
  strSQL := strSQL + '  GER_DESESP, ';
  strSQL := strSQL + '  DET_CODITE, ';
  strSQL := strSQL + '  DET_DESCRI, ';
  strSQL := strSQL + '  DET_UNIDAD, ';
  strSQL := strSQL + '  DET_QTDITE, ';
  strSQL := strSQL + '  DET_VLRCON, ';
  strSQL := strSQL + '  DET_TOTITE, ';
  strSQL := strSQL + '  DET_TOTFRE, ';
  strSQL := strSQL + '  DET_UNITAR, ';
  strSQL := strSQL + '  DET_CLAFIS, ';
  strSQL := strSQL + '  DET_DESESP, ';
  strSQL := strSQL + '  DET_PERRED, ';
  strSQL := strSQL + '  DET_CODFIS, ';
  strSQL := strSQL + '  DET_BASICM, ';
  strSQL := strSQL + '  DET_ALQICM, ';
  strSQL := strSQL + '  DET_VALICM, ';
  strSQL := strSQL + '  DET_BASIPI, ';
  strSQL := strSQL + '  DET_ALQIPI, ';
  strSQL := strSQL + '  DET_VALIPI, ';
  strSQL := strSQL + '  DET_BASRET, ';
  strSQL := strSQL + '  DET_VALRET, ';
  strSQL := strSQL + '  DET_DESACE, ';
  strSQL := strSQL + '  T.DET_OUTICM, ';
  strSQL := strSQL + '  T.DET_ISEICM, ';
  strSQL := strSQL + '  T.DET_NR_PIS, ';
  strSQL := strSQL + '  T.DET_NR_COF, ';

  if fCampoExiste('MOVTRI', 'DET_VAERET') then
    strSQL := strSQL + '  T.DET_VAERET, '
  else
    strSQL := strSQL + '  0 AS DET_VAERET, ';

  strSQL := strSQL + '  T.DET_VAEIPI, ';
  strSQL := strSQL + '  T.DET_CSTIPI, ';
  strSQL := strSQL + '  T.DET_CSTPIS, ';
  strSQL := strSQL + '  T.DET_BASPIS, ';
  strSQL := strSQL + '  T.DET_ALQPIS, ';
  strSQL := strSQL + '  T.DET_VALPIS, ';
  strSQL := strSQL + '  T.DET_CSTCOF, ';
  strSQL := strSQL + '  T.DET_BASCOF, ';
  strSQL := strSQL + '  T.DET_ALQCOF, ';
  strSQL := strSQL + '  T.DET_VALCOF, ';
  strSQL := strSQL + '  IFNULL(ICD_BCUFDE, 0) AS ICD_BCUFDE, ';
  strSQL := strSQL + '  IFNULL(ICD_PERFCP, 0) AS ICD_PERFCP, ';
  strSQL := strSQL + '  IFNULL(ICD_ALQUFD, 0) AS ICD_ALQUFD, ';
  strSQL := strSQL + '  IFNULL(ICD_ALQINE, 0) AS ICD_ALQINE, ';
  strSQL := strSQL + '  IFNULL(ICD_PERPAR, 0) AS ICD_PERPAR, ';
  strSQL := strSQL + '  IFNULL(ICD_VALFCP, 0) AS ICD_VALFCP, ';
  strSQL := strSQL + '  IFNULL(ICD_VALDES, 0) AS ICD_VALDES, ';
  strSQL := strSQL + '  IFNULL(ICD_VALORI, 0) AS ICD_VALORI, ';
  strSQL := strSQL + '  UNI_SIGUNI, ';
  strSQL := strSQL + '  ITE.ITE_CLAIPI, ';
  strSQL := strSQL + '  ITE.ITE_CDCEST, ';
  strSQL := strSQL + '  TRA_C_G_C_, ';
  strSQL := strSQL + '  TRA_I_E_S_, ';
  strSQL := strSQL + '  TRA_NUMPLA, ';
  strSql := strSql + '  CIDTRA.CID_ESTADO AS TRA_UF, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CLI_C_E_P_, FOR_C_E_P_) AS CEP, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CLI_C_G_C_, FOR_C_G_C_) AS CNPJ, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CLI_NOMCLI, FOR_NOMFOR) AS NOME, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CLI_BAIRRO, FOR_BAIRRO) AS BAIRRO, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CLI_ENDERE, FOR_ENDERE) AS ENDERECO, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CLI_FONE01, FOR_FONE01) AS TELEFONE, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CC.CID_ESTADO, CF.CID_ESTADO) AS UF, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CC.CID_NOMCID, CF.CID_NOMCID) AS MUNICIPIO, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CC.CID_COIBGE, CF.CID_COIBGE) AS CODIGO_IBGE, ';
  strSQL := strSQL + '  IFNULL(FIS_OUTRA1, 0) + IFNULL(FIS_OUTRA2, 0) + IFNULL(FIS_OUTRA3, 0) + IFNULL(FIS_OUTRA4, 0) + IFNULL(FIS_OUTRA5, 0) AS FIS_OUTRAS, ';
  strSQL := strSQL + '  IFNULL(FIS_VLCON1, 0) + IFNULL(FIS_VLCON2, 0) + IFNULL(FIS_VLCON3, 0) + IFNULL(FIS_VLCON4, 0) + IFNULL(FIS_VLCON5, 0) AS FIS_VLRCON ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADFIS ';

  strSQL := strSQL + '  LEFT JOIN MOVGER G ';
  strSQL := strSQL + '   ON G.GER_NUMDOC = FIS_NUMDOC ';
  strSQL := strSQL + '   AND G.GER_ESPDOC = FIS_ESPDOC ';
  strSQL := strSQL + '   AND G.GER_CODEMP = FIS_CODEMP ';
  strSQL := strSQL + '   AND IFNULL(G.GER_SERIE_, "") = IFNULL(FIS_SERIE_, "") ';
  strSQL := strSQL + '   AND G.GER_TIP_FC = FIS_TIP_FC ';
  strSQL := strSQL + '   AND IF(G.GER_TIP_FC = "C", G.GER_CODCLI, G.GER_CODFOR) = FIS_FORCLI ';

  strSQL := strSQL + '  LEFT JOIN MOVDET D ';
  strSQL := strSQL + '   ON D.DET_NUMDOC = G.GER_NUMDOC ';
  strSQL := strSQL + '   AND D.DET_ESPDOC = G.GER_ESPDOC ';
  strSQL := strSQL + '   AND D.DET_CODEMP = G.GER_CODEMP ';
  strSQL := strSQL + '   AND IFNULL(D.DET_SERIE_, "") = IFNULL(G.GER_SERIE_, "") ';
  strSQL := strSQL + '   AND D.DET_TIP_FC = G.GER_TIP_FC ';
  strSQL := strSQL + '   AND IF(FIS_TIP_FC = "C", D.DET_CODCLI, D.DET_CODFOR) = IF(G.GER_TIP_FC = "C", G.GER_CODCLI, G.GER_CODFOR) ';

  strSQL := strSQL + '  LEFT JOIN MOVTRI T ';
  strSQL := strSQL + '   ON T.DET_SEQGER = D.AUTOINCREM ';

  if fTabelaExiste('MOVICD') then
  begin
    strSQL := strSQL + '  LEFT JOIN MOVICD ';
    strSQL := strSQL + '   ON ICD_SEQGER = D.AUTOINCREM ';
  end;

  strSQL := strSQL + '  LEFT JOIN CADITE ITE ';
  strSQL := strSQL + '    ON ITE.ITE_CODITE = D.DET_CODITE ';

  strSQL := strSQL + '  LEFT JOIN CADUNI ';
  strSQL := strSQL + '    ON UNI_CODUNI = D.DET_UNIDAD ';

  strSQL := strSQL + '  LEFT JOIN CADTRA TRA ';
  strSQL := strSQL + '    ON TRA.TRA_CODTRA = G.GER_CODTRA ';

  strSQL := strSQL + '  LEFT JOIN CADCLI ';
  strSQL := strSQL + '   ON CLI_CODCLI = IF(FIS_TIP_FC = "C", FIS_FORCLI, NULL) ';

  strSQL := strSQL + '  LEFT JOIN CADFOR ';
  strSQL := strSQL + '   ON FOR_CODFOR = IF(FIS_TIP_FC = "F", FIS_FORCLI, NULL) ';

  strSQL := strSQL + '  LEFT JOIN CADCID CC ';
  strSQL := strSQL + '   ON CC.CID_CODCID = CLI_CODCID ';

  strSQL := strSQL + '  LEFT JOIN CADCID CF ';
  strSQL := strSQL + '   ON CF.CID_CODCID = FOR_CODCID ';

  strSQL := strSQL + '  LEFT JOIN CADCID CIDTRA ';
  strSQL := strSQL + '    ON CIDTRA.CID_CODCID = TRA_CODCID ';

  strSQL := strSQL + 'WHERE FIS_DTAENT BETWEEN :DTAINI ';
  strSQL := strSQL + '  AND :DTAFIN ';
  strSQL := strSQL + '  AND IFNULL(FIS_HISTOR,"") NOT LIKE "%DENEGAD%" ';
  strSQL := strSQL + '  AND LOCATE(D.DET_CLAFIS, :CFOP) > 0 ';
  strSQL := strSQL + '  AND IFNULL(DET_PROEMB, "") <> "S" ';
  strSQL := strSQL + '  AND D.DET_CODITE = :CODITE ';
  strSQL := strSQL + '  AND FIS_CODEMP = :CODEMP ';

  Result := strSQL;
end;

function TRepositorioNotasFiscais.fRetSqlTodasNotasFiscaisPorPeriodo: String;
  var
    strSQL: string;
    blnTabelaExisteMOVICD: Boolean;
begin
  blnTabelaExisteMOVICD := fTabelaExiste('MOVICD');

  strSQL := '';

  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  IFNULL(FIS_ACESSO, "") AS FIS_ACESSO, ';
  strSQL := strSQL + '  IFNULL(FIS_HISTOR, "") AS FIS_HISTOR, ';
  strSQL := strSQL + '  FIS_ESTADO, ';
  strSQL := strSQL + '  FIS_NUMDOC, ';
  strSQL := strSQL + '  FIS_CODEMP, ';
  strSQL := strSQL + '  FIS_SERIE_, ';
  strSQL := strSQL + '  FIS_ESPDOC, ';
  strSQL := strSQL + '  FIS_FORCLI, ';
  strSQL := strSQL + '  FIS_TIP_FC, ';
  strSQL := strSQL + '  FIS_DTAENT, ';
  strSQL := strSQL + '  FIS_DTADOC, ';
  strSQL := strSQL + '  FIS_NFCOMP, ';

  strSql := strSql + '   IF( (FIS_ESPDOC = "NF") AND (IFNULL(FIS_ACESSO,"") = "") , "01",     ';
  strSql := strSql + '     IF( ( (FIS_ESPDOC IN ("NF", "NV")) AND (IFNULL(FIS_ACESSO,"") <> "") ) OR   ';
  strSql := strSql + '           (FIS_ESPDOC = "EL"),  "55",                                  ';
  strSql := strSql + '       IF( FIS_ESPDOC IN ("IF", "IV"), IF(((IFNULL(FIS_ACESSO,"")="") AND (IFNULL(FIS_HISTOR, "") NOT LIKE "%INUTILI%")), "2D", "65"), "01" ) ) ) AS FIS_DOCMOD, ';
  strSQL := strSQL + '  IF(IFNULL(FIS_HISTOR, "") = "CANCELADO", "02", "00") AS FIS_SITDOC, ';

  strSQL := strSQL + '  IFNULL(FIS_CLFSC1, "") AS FIS_CLFSC1, ';
  strSQL := strSQL + '  IFNULL(FIS_CLFSC2, "") AS FIS_CLFSC2, ';
  strSQL := strSQL + '  IFNULL(FIS_CLFSC3, "") AS FIS_CLFSC3, ';
  strSQL := strSQL + '  IFNULL(FIS_CLFSC4, "") AS FIS_CLFSC4, ';
  strSQL := strSQL + '  IFNULL(FIS_CLFSC5, "") AS FIS_CLFSC5, ';

  strSQL := strSQL + '  IFNULL(FIS_VLCON1, 0) AS FIS_VLCON1, ';
  strSQL := strSQL + '  IFNULL(FIS_VLCON2, 0) AS FIS_VLCON2, ';
  strSQL := strSQL + '  IFNULL(FIS_VLCON3, 0) AS FIS_VLCON3, ';
  strSQL := strSQL + '  IFNULL(FIS_VLCON4, 0) AS FIS_VLCON4, ';
  strSQL := strSQL + '  IFNULL(FIS_VLCON5, 0) AS FIS_VLCON5, ';

  strSQL := strSQL + '  IFNULL(FIS_OUTRA1, 0) AS FIS_OUTRA1, ';
  strSQL := strSQL + '  IFNULL(FIS_OUTRA2, 0) AS FIS_OUTRA2, ';
  strSQL := strSQL + '  IFNULL(FIS_OUTRA3, 0) AS FIS_OUTRA3, ';
  strSQL := strSQL + '  IFNULL(FIS_OUTRA4, 0) AS FIS_OUTRA4, ';
  strSQL := strSQL + '  IFNULL(FIS_OUTRA5, 0) AS FIS_OUTRA5, ';

  strSQL := strSQL + '  IFNULL(FIS_BCRET1, 0) AS FIS_BCRET1, ';
  strSQL := strSQL + '  IFNULL(FIS_BCRET2, 0) AS FIS_BCRET2, ';
  strSQL := strSQL + '  IFNULL(FIS_BCRET3, 0) AS FIS_BCRET3, ';
  strSQL := strSQL + '  IFNULL(FIS_BCRET4, 0) AS FIS_BCRET4, ';
  strSQL := strSQL + '  IFNULL(FIS_BCRET5, 0) AS FIS_BCRET5, ';

  strSQL := strSQL + '  IFNULL(FIS_RETID1, 0) AS FIS_RETID1, ';
  strSQL := strSQL + '  IFNULL(FIS_RETID2, 0) AS FIS_RETID2, ';
  strSQL := strSQL + '  IFNULL(FIS_RETID3, 0) AS FIS_RETID3, ';
  strSQL := strSQL + '  IFNULL(FIS_RETID4, 0) AS FIS_RETID4, ';
  strSQL := strSQL + '  IFNULL(FIS_RETID5, 0) AS FIS_RETID5, ';

  strSQL := strSQL + '  IFNULL(FIS_ISENT1, 0) AS FIS_ISENT1, ';
  strSQL := strSQL + '  IFNULL(FIS_ISENT2, 0) AS FIS_ISENT2, ';
  strSQL := strSQL + '  IFNULL(FIS_ISENT3, 0) AS FIS_ISENT3, ';
  strSQL := strSQL + '  IFNULL(FIS_ISENT4, 0) AS FIS_ISENT4, ';
  strSQL := strSQL + '  IFNULL(FIS_ISENT5, 0) AS FIS_ISENT5, ';

  strSQL := strSQL + '  IFNULL(FIS_BASIC1, 0) AS FIS_BASIC1, ';
  strSQL := strSQL + '  IFNULL(FIS_BASIC2, 0) AS FIS_BASIC2, ';
  strSQL := strSQL + '  IFNULL(FIS_BASIC3, 0) AS FIS_BASIC3, ';
  strSQL := strSQL + '  IFNULL(FIS_BASIC4, 0) AS FIS_BASIC4, ';
  strSQL := strSQL + '  IFNULL(FIS_BASIC5, 0) AS FIS_BASIC5, ';

  strSQL := strSQL + '  IFNULL(FIS_ALQIC1, 0) AS FIS_ALQIC1, ';
  strSQL := strSQL + '  IFNULL(FIS_ALQIC2, 0) AS FIS_ALQIC2, ';
  strSQL := strSQL + '  IFNULL(FIS_ALQIC3, 0) AS FIS_ALQIC3, ';
  strSQL := strSQL + '  IFNULL(FIS_ALQIC4, 0) AS FIS_ALQIC4, ';
  strSQL := strSQL + '  IFNULL(FIS_ALQIC5, 0) AS FIS_ALQIC5, ';

  strSQL := strSQL + '  IFNULL(FIS_VLRIC1, 0) AS FIS_VLRIC1, ';
  strSQL := strSQL + '  IFNULL(FIS_VLRIC2, 0) AS FIS_VLRIC2, ';
  strSQL := strSQL + '  IFNULL(FIS_VLRIC3, 0) AS FIS_VLRIC3, ';
  strSQL := strSQL + '  IFNULL(FIS_VLRIC4, 0) AS FIS_VLRIC4, ';
  strSQL := strSQL + '  IFNULL(FIS_VLRIC5, 0) AS FIS_VLRIC5, ';

  strSQL := strSQL + '  IFNULL(FIS_BASIP1, 0) AS FIS_BASIP1, ';
  strSQL := strSQL + '  IFNULL(FIS_BASIP2, 0) AS FIS_BASIP2, ';
  strSQL := strSQL + '  IFNULL(FIS_BASIP3, 0) AS FIS_BASIP3, ';
  strSQL := strSQL + '  IFNULL(FIS_BASIP4, 0) AS FIS_BASIP4, ';
  strSQL := strSQL + '  IFNULL(FIS_BASIP5, 0) AS FIS_BASIP5, ';

  strSQL := strSQL + '  IFNULL(FIS_VLRIP1, 0) AS FIS_VLRIP1, ';
  strSQL := strSQL + '  IFNULL(FIS_VLRIP2, 0) AS FIS_VLRIP2, ';
  strSQL := strSQL + '  IFNULL(FIS_VLRIP3, 0) AS FIS_VLRIP3, ';
  strSQL := strSQL + '  IFNULL(FIS_VLRIP4, 0) AS FIS_VLRIP4, ';
  strSQL := strSQL + '  IFNULL(FIS_VLRIP5, 0) AS FIS_VLRIP5, ';

  strSql := strSql + '  IF(GER_CONPAG = "01000", "0", "1") AS FIS_COND_PG, ';
  strSql := strSql + '  GER_TIPFRE AS GER_TIPO_FRETE, ';
  strSQL := strSQL + '  GER_TOTFRE, ';
  strSQL := strSQL + '  GER_DESESP, ';
  strSQL := strSQL + '  DET_CODITE, ';
  strSQL := strSQL + '  DET_DESCRI, ';
  strSQL := strSQL + '  DET_UNIDAD, ';
  strSQL := strSQL + '  DET_QTDITE, ';
  strSQL := strSQL + '  DET_VLRCON, ';
  strSQL := strSQL + '  DET_TOTITE, ';
  strSQL := strSQL + '  DET_TOTFRE, ';
  strSQL := strSQL + '  DET_UNITAR, ';
  strSQL := strSQL + '  DET_CLAFIS, ';
  strSQL := strSQL + '  DET_DESESP, ';
  strSQL := strSQL + '  DET_PERRED, ';
  strSQL := strSQL + '  DET_CODFIS, ';
  strSQL := strSQL + '  DET_BASICM, ';
  strSQL := strSQL + '  DET_ALQICM, ';
  strSQL := strSQL + '  DET_VALICM, ';
  strSQL := strSQL + '  DET_BASIPI, ';
  strSQL := strSQL + '  DET_ALQIPI, ';
  strSQL := strSQL + '  DET_VALIPI, ';
  strSQL := strSQL + '  DET_BASRET, ';
  strSQL := strSQL + '  DET_VALRET, ';
  strSQL := strSQL + '  DET_DESACE, ';
  strSQL := strSQL + '  T.DET_VFCPST, ';
  strSQL := strSQL + '  T.DET_OUTICM, ';
  strSQL := strSQL + '  T.DET_ISEICM, ';
  strSQL := strSQL + '  T.DET_NR_PIS, ';
  strSQL := strSQL + '  T.DET_NR_COF, ';

  if fCampoExiste('MOVTRI', 'DET_VAERET') then
    strSQL := strSQL + '  T.DET_VAERET, '
  else
    strSQL := strSQL + '  0 AS DET_VAERET, ';

  strSQL := strSQL + '  T.DET_VAEIPI, ';
  strSQL := strSQL + '  T.DET_CSTIPI, ';
  strSQL := strSQL + '  T.DET_CSTPIS, ';
  strSQL := strSQL + '  T.DET_BASPIS, ';
  strSQL := strSQL + '  T.DET_ALQPIS, ';
  strSQL := strSQL + '  T.DET_VALPIS, ';
  strSQL := strSQL + '  T.DET_CSTCOF, ';
  strSQL := strSQL + '  T.DET_BASCOF, ';
  strSQL := strSQL + '  T.DET_ALQCOF, ';
  strSQL := strSQL + '  T.DET_VALCOF, ';

  if blnTabelaExisteMOVICD then
  begin
    strSQL := strSQL + '  IFNULL(ICD_BCUFDE, 0) AS ICD_BCUFDE, ';
    strSQL := strSQL + '  IFNULL(ICD_PERFCP, 0) AS ICD_PERFCP, ';
    strSQL := strSQL + '  IFNULL(ICD_ALQUFD, 0) AS ICD_ALQUFD, ';
    strSQL := strSQL + '  IFNULL(ICD_ALQINE, 0) AS ICD_ALQINE, ';
    strSQL := strSQL + '  IFNULL(ICD_PERPAR, 0) AS ICD_PERPAR, ';
    strSQL := strSQL + '  IFNULL(ICD_VALFCP, 0) AS ICD_VALFCP, ';
    strSQL := strSQL + '  IFNULL(ICD_VALDES, 0) AS ICD_VALDES, ';
    strSQL := strSQL + '  IFNULL(ICD_VALORI, 0) AS ICD_VALORI, ';
  end
  else
  begin
    strSQL := strSQL + '  0 AS ICD_BCUFDE, ';
    strSQL := strSQL + '  0 AS ICD_PERFCP, ';
    strSQL := strSQL + '  0 AS ICD_ALQUFD, ';
    strSQL := strSQL + '  0 AS ICD_ALQINE, ';
    strSQL := strSQL + '  0 AS ICD_PERPAR, ';
    strSQL := strSQL + '  0 AS ICD_VALFCP, ';
    strSQL := strSQL + '  0 AS ICD_VALDES, ';
    strSQL := strSQL + '  0 AS ICD_VALORI, ';
  end;

  strSQL := strSQL + '  UNI_SIGUNI, ';
  strSQL := strSQL + '  ITE.ITE_CLAIPI, ';
  strSQL := strSQL + '  ITE.ITE_CDCEST, ';
  strSQL := strSQL + '  TRA_C_G_C_, ';
  strSQL := strSQL + '  TRA_I_E_S_, ';
  strSQL := strSQL + '  TRA_NUMPLA, ';
  strSql := strSql + '  CIDTRA.CID_ESTADO AS TRA_UF, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CLI_C_E_P_, FOR_C_E_P_) AS CEP, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CLI_C_G_C_, FOR_C_G_C_) AS CNPJ, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CLI_NOMCLI, FOR_NOMFOR) AS NOME, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CLI_BAIRRO, FOR_BAIRRO) AS BAIRRO, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CLI_ENDERE, FOR_ENDERE) AS ENDERECO, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CLI_FONE01, FOR_FONE01) AS TELEFONE, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CC.CID_ESTADO, CF.CID_ESTADO) AS UF, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CC.CID_NOMCID, CF.CID_NOMCID) AS MUNICIPIO, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CC.CID_COIBGE, CF.CID_COIBGE) AS CODIGO_IBGE, ';
  strSQL := strSQL + '  IFNULL(FIS_OUTRA1, 0) + IFNULL(FIS_OUTRA2, 0) + IFNULL(FIS_OUTRA3, 0) + IFNULL(FIS_OUTRA4, 0) + IFNULL(FIS_OUTRA5, 0) AS FIS_OUTRAS, ';
  strSQL := strSQL + '  IFNULL(FIS_VLCON1, 0) + IFNULL(FIS_VLCON2, 0) + IFNULL(FIS_VLCON3, 0) + IFNULL(FIS_VLCON4, 0) + IFNULL(FIS_VLCON5, 0) AS FIS_VLRCON ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADFIS ';

  strSQL := strSQL + '  LEFT JOIN MOVGER G ';
  strSQL := strSQL + '   ON G.GER_NUMDOC = FIS_NUMDOC ';
  strSQL := strSQL + '   AND G.GER_ESPDOC = FIS_ESPDOC ';
  strSQL := strSQL + '   AND G.GER_CODEMP = FIS_CODEMP ';
  strSQL := strSQL + '   AND IFNULL(G.GER_SERIE_, "") = IFNULL(FIS_SERIE_, "") ';
  strSQL := strSQL + '   AND G.GER_TIP_FC = FIS_TIP_FC ';
  strSQL := strSQL + '   AND IF(G.GER_TIP_FC = "C", G.GER_CODCLI, G.GER_CODFOR) = FIS_FORCLI ';

  strSQL := strSQL + '  LEFT JOIN MOVDET D ';
  strSQL := strSQL + '   ON D.DET_NUMDOC = G.GER_NUMDOC ';
  strSQL := strSQL + '   AND D.DET_ESPDOC = G.GER_ESPDOC ';
  strSQL := strSQL + '   AND D.DET_CODEMP = G.GER_CODEMP ';
  strSQL := strSQL + '   AND IFNULL(D.DET_SERIE_, "") = IFNULL(G.GER_SERIE_, "") ';
  strSQL := strSQL + '   AND D.DET_TIP_FC = G.GER_TIP_FC ';
  strSQL := strSQL + '   AND IF(FIS_TIP_FC = "C", D.DET_CODCLI, D.DET_CODFOR) = IF(G.GER_TIP_FC = "C", G.GER_CODCLI, G.GER_CODFOR) ';

  strSQL := strSQL + '  LEFT JOIN MOVTRI T ';
  strSQL := strSQL + '   ON T.DET_SEQGER = D.AUTOINCREM ';

  if blnTabelaExisteMOVICD then
  begin
    strSQL := strSQL + '  LEFT JOIN MOVICD ';
    strSQL := strSQL + '   ON ICD_SEQGER = D.AUTOINCREM ';
  end;

  strSQL := strSQL + '  LEFT JOIN CADITE ITE ';
  strSQL := strSQL + '    ON ITE.ITE_CODITE = D.DET_CODITE ';

  strSQL := strSQL + '  LEFT JOIN CADUNI ';
  strSQL := strSQL + '    ON UNI_CODUNI = D.DET_UNIDAD ';

  strSQL := strSQL + '  LEFT JOIN CADTRA TRA ';
  strSQL := strSQL + '    ON TRA.TRA_CODTRA = G.GER_CODTRA ';

  strSQL := strSQL + '  LEFT JOIN CADCLI ';
  strSQL := strSQL + '   ON CLI_CODCLI = IF(FIS_TIP_FC = "C", FIS_FORCLI, NULL) ';

  strSQL := strSQL + '  LEFT JOIN CADFOR ';
  strSQL := strSQL + '   ON FOR_CODFOR = IF(FIS_TIP_FC = "F", FIS_FORCLI, NULL) ';

  strSQL := strSQL + '  LEFT JOIN CADCID CC ';
  strSQL := strSQL + '   ON CC.CID_CODCID = CLI_CODCID ';

  strSQL := strSQL + '  LEFT JOIN CADCID CF ';
  strSQL := strSQL + '   ON CF.CID_CODCID = FOR_CODCID ';

  strSQL := strSQL + '  LEFT JOIN CADCID CIDTRA ';
  strSQL := strSQL + '    ON CIDTRA.CID_CODCID = TRA_CODCID ';

  strSQL := strSQL + 'WHERE FIS_DTAENT BETWEEN :DTAINI ';
  strSQL := strSQL + '  AND :DTAFIN ';
  strSQL := strSQL + '  AND FIS_CODEMP = :CODEMP ';
  strSQL := strSQL + '  AND IFNULL(DET_PROEMB, "") <> "S" ';
  strSQL := strSQL + '  AND IFNULL(FIS_HISTOR,"") NOT LIKE "%DENEGAD%" ';

  if FNaoEnviarCte then
    strSQL := strSQL + '  AND LOCATE(FIS_CLFSC1, ' + QuotedStr(CFOP_TRANSPORTE) + ') <= 0 ';

  if FExcluirCFOPUsoConsumo then
    strSQL := strSQL + '  AND LOCATE(FIS_CLFSC1, ' + QuotedStr(CFOP_USOCONSUMO) + ') <= 0 ';

  if FExcluirCFOPServico then
    strSQL := strSQL + '  AND LOCATE(FIS_CLFSC1, ' + QuotedStr(CFOP_SERVICO) + ') <= 0 ';

  strSQL := strSQL + ' UNION ALL ' + AnsiReplaceText(AnsiReplaceText(AnsiReplaceText(AnsiReplaceText(strSQL, 'LEFT JOIN MOVDET', 'INNER JOIN NOTDET'),
                                                                                                             'LEFT JOIN MOVTRI', 'INNER JOIN NOTTRI'),
                                                                                                             'LEFT JOIN MOVGER', 'INNER JOIN NOTGER'),
                                                                                                             'LEFT JOIN MOVICD', 'INNER JOIN NOTICD');

  Result := strSQL;
end;

constructor TInformacoesECF.Create(dtaDtaIni, dtaDtaFin: TDateTime);
begin
  stlEcfs := TObjectList.Create;

  Self.dtaDtaIni := dtaDtaIni;
  Self.dtaDtaFin := dtaDtaFin;

  pDefineDatasEcf;
end;

destructor TInformacoesECF.Destroy;
begin
  FreeAndNil(stlEcfs);
  inherited;
end;

function TInformacoesECF.fEcfsPorLoja(const strCodEmp: String): TObjectList;

  Var
    intContador: Integer;
begin
  Result := TObjectList.Create;
  Result.OwnsObjects := False;

  For intContador := 0 To stlEcfs.Count-1 Do
  Begin
    If (fEmptyStr(strCodEmp)) Or (TEcfLoja(stlEcfs[intContador]).strCodEmp = strCodEmp) Then
      Result.Add(stlEcfs[intContador]);
  End;

end;

procedure TInformacoesECF.pTotaisPorLoja(const strCodEmp: String; var fltVlrCon, fltBasIcm,
  fltValIcm: Double);
  Var
    qryTotais: TUniQuery;
    stlEcfsTmp: TObjectList;
    strNumSerEmp: String;
    intContador: Integer;
begin
  strNumSerEmp := '';
  stlEcfsTmp := fEcfsPorLoja(strCodEmp);
  For intContador := 0 To stlEcfsTmp.Count-1 Do
  Begin
    strNumSerEmp := strNumSerEmp + TEcfLoja(stlEcfsTmp[intContador]).strNumSer + ',';
  End;

  fltBasIcm := 0;
  fltValIcm := 0;

  If Not fEmptyStr(strNumSerEmp) Then
  Begin
    qryTotais := fCriaQuery(Nil);

    qryTotais.SQL.Add('SELECT ');
    qryTotais.SQL.Add('  SUM(IFNULL(TOT_BASIMP, 0)) AS VLRCON, ');
    qryTotais.SQL.Add('  SUM(IF(TOT_ALQIMP > 0, IFNULL(TOT_BASIMP, 0), 0)) AS BASIMP, ');
    qryTotais.SQL.Add('  SUM(IFNULL(TOT_VALIMP, 0)) AS VALIMP ');
    qryTotais.SQL.Add('FROM ');
    qryTotais.SQL.Add('  RDZTOT ');
    qryTotais.SQL.Add('JOIN CADRDZ ON RDZ_QTDRDZ = TOT_NUMCRZ AND ');
    qryTotais.SQL.Add('               RDZ_CODECF = TOT_CODECF ');
    qryTotais.SQL.Add('JOIN CADECF ON ECF_CODECF = RDZ_CODECF ');
    qryTotais.SQL.Add('WHERE ');
    qryTotais.SQL.Add('  LOCATE(ECF_NUMSER, :NUMSER) > 0 AND ');
    qryTotais.SQL.Add('  RDZ_DTAMOV BETWEEN :DTAINI AND :DTAFIN ');

    qryTotais.ParamByName('NUMSER').AsString := strNumSerEmp;
    qryTotais.ParamByName('DTAINI').AsDateTime := dtaDtaIni;
    qryTotais.ParamByName('DTAFIN').AsDateTime := dtaDtaFin;
    qryTotais.Open;

    fltVlrCon := qryTotais.FieldByName('VLRCON').AsFloat;
    fltBasIcm := qryTotais.FieldByName('BASIMP').AsFloat;
    fltValIcm := qryTotais.FieldByName('VALIMP').AsFloat;

    FreeAndNil(qryTotais);
  End;

  FreeAndNil(stlEcfs);
end;

procedure TInformacoesECF.pCarregaEcfsPorLoja;
  Var
    qryEcfs: TUniQuery;
    ecf: TEcfLoja;
begin
  qryEcfs := fCriaQuery(Nil);
  qryEcfs.SQL.Add('SELECT ');
  qryEcfs.SQL.Add('  FIS_CODEMP, ECF_CODECF, REPLACE(FIS_NUMSER, "\0", "") AS FIS_NUMSER ');
  qryEcfs.SQL.Add('FROM ');
  qryEcfs.SQL.Add('  CADFIS ');
  qryEcfs.SQL.Add('JOIN CADECF ON ECF_NUMSER = REPLACE(FIS_NUMSER, "\0", "") ');
  qryEcfs.SQL.Add('WHERE ');
  qryEcfs.SQL.Add('  FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN AND ');
  qryEcfs.SQL.Add('  FIS_ESPDOC IN ("IF", "IV") AND ');
  qryEcfs.SQL.Add('  IFNULL(FIS_HISTOR, "") NOT LIKE "%CANCELADO%" ');
  qryEcfs.SQL.Add('GROUP BY ');
  qryEcfs.SQL.Add('  FIS_CODEMP, FIS_NUMSER ');

  qryEcfs.ParamByName('DTAINI').AsDateTime := dtaDtaIni;
  qryEcfs.ParamByName('DTAFIN').AsDateTime := dtaDtaFin;
  qryEcfs.Open;

  While (Not qryEcfs.Eof) Do
  Begin
    ecf := TEcfLoja.Create;
    ecf.strNumSer := qryEcfs.FieldByName('FIS_NUMSER').AsString;
    ecf.strCodEmp := qryEcfs.FieldByName('FIS_CODEMP').AsString;
    ecf.strCodEcf := qryEcfs.FieldByName('ECF_CODECF').AsString;

    stlEcfs.Add(ecf);

    qryEcfs.Next;
  End;

  FreeAndNil(qryEcfs);
end;

procedure TRepositorioNotasFiscais.pCarregaVariaveisConfiguracoes;
begin
  FCALCULAR_ST_ADJUDICACAO := fCfgSpd('CALCULAR_ST_ADJUDICACAO');
  FENVIAR_TODAS_COMPRAS_SUBAPURACAO := fCfgSpd('ENVIAR_TODAS_COMPRAS_SUBAPURACAO');
  FCFOP_COMPRA_REG1923 := fCfgSpd('CFOP_COMPRA_REG1923');
  FCFOP_VENDA_REG1923 := fCfgSpd('CFOP_VENDA_REG1923');
end;

procedure TRepositorioNotasFiscais.pRetNotaFiscalCompraSubApuracaoIcmsDocDevolucao(abertura: TDadosAbertura);
begin
  //#2

  try
    with FQryAuxDel do
    begin
       Close;
       SQL.Clear;
       SQL.Text := fRetSqlNotaCompraSubApuracaoIcmsDocDevolucao(abertura);
       ParamByName('DTAINI').AsDateTime := abertura.dtaDataInicial;
       ParamByName('DTAFIN').AsDateTime := abertura.dtaDataFinal;
       ParamByName('CODEMP').AsString := abertura.empresa.strCodigo;
       Open;
    end
  except
  on e:exception Do
    begin

    end;
  end;
end;


function TRepositorioNotasFiscais.fStrLocateEmpresa(objCodigo: TObject; arrLinha: TConsultasArray; strNomCampo,
  strNomPar: String; blnSemAND: Boolean = False; strCodigo: String = ''): String;
Begin

  Result := fStrLocate(nil, arrLinha, strNomCampo, strNomPar, blnSemAND, False, strCodigo);

  If (Not fEmptyStr(Result)) Then
    Result := Result + ' AND '

  Else If Not blnSemAND Then
    Result := Result + ' AND ';

  Result := Result + ' ' + strNomCampo +' IN (' + fStringSQLLocateToStringSQLIN(strEmpAcessoUsuarioLogado) + ') ';

End;

function TRepositorioNotasFiscais.fGetSqlConverteFiscDeCincoPraUm(strCodEmp, intClaFis: string): string;
  var
    strSQL: string;
begin
  strSQL := '            SELECT ';
  strSQL := strSQL + '     CLFSC' + intClaFis + '.FIS_NFCOMP AS FIS_NFCOMP, ';
  strSQL := strSQL + '     CLFSC' + intClaFis + '.FIS_ENTSAI AS FIS_ENTSAI, ';
  strSQL := strSQL + '     CLFSC' + intClaFis + '.FIS_CODEMP AS FIS_CODEMP, ';
  strSQL := strSQL + '     CLFSC' + intClaFis + '.FIS_ACESSO AS FIS_ACESSO, ';
  strSQL := strSQL + '     CLFSC' + intClaFis + '.FIS_HISTOR AS FIS_HISTOR, ';
  strSQL := strSQL + '     CLFSC' + intClaFis + '.FIS_DTAENT AS FIS_DTAENT, ';
  strSQL := strSQL + '     CLFSC' + intClaFis + '.FIS_DTADOC AS FIS_DTADOC, ';
  strSQL := strSQL + '     CLFSC' + intClaFis + '.FIS_NUMDOC AS FIS_NUMDOC, ';
  strSQL := strSQL + '     CLFSC' + intClaFis + '.FIS_SERIE_ AS FIS_SERIE_, ';
  strSQL := strSQL + '     CLFSC' + intClaFis + '.FIS_FORCLI AS FIS_FORCLI, ';
  strSQL := strSQL + '     CLFSC' + intClaFis + '.FIS_ESPDOC AS FIS_ESPDOC, ';
  strSQL := strSQL + '     CLFSC' + intClaFis + '.FIS_TIP_FC AS FIS_TIP_FC, ';
  strSQL := strSQL + '     IFNULL(CLFSC' + intClaFis + '.FIS_CLFSC' + intClaFis + ', "") AS FIS_CLFSC1, ';
  strSQL := strSQL + '     IFNULL(CLFSC' + intClaFis + '.FIS_VLCON' + intClaFis + ', 0) AS FIS_VLCON1, ';
  strSQL := strSQL + '     IFNULL(CLFSC' + intClaFis + '.FIS_OUTRA' + intClaFis + ', 0) AS FIS_OUTRA1, ';
  strSQL := strSQL + '     IFNULL(CLFSC' + intClaFis + '.FIS_BCRET' + intClaFis + ', 0) AS FIS_BCRET1, ';
  strSQL := strSQL + '     IFNULL(CLFSC' + intClaFis + '.FIS_RETID' + intClaFis + ', 0) AS FIS_RETID1, ';
  strSQL := strSQL + '     IFNULL(CLFSC' + intClaFis + '.FIS_ISENT' + intClaFis + ', 0) AS FIS_ISENT1, ';
  strSQL := strSQL + '     IFNULL(CLFSC' + intClaFis + '.FIS_BASIC' + intClaFis + ', 0) AS FIS_BASIC1, ';
  strSQL := strSQL + '     IFNULL(CLFSC' + intClaFis + '.FIS_ALQIC' + intClaFis + ', 0) AS FIS_ALQIC1, ';
  strSQL := strSQL + '     IFNULL(CLFSC' + intClaFis + '.FIS_VLRIC' + intClaFis + ', 0) AS FIS_VLRIC1, ';
  strSQL := strSQL + '     IFNULL(CLFSC' + intClaFis + '.FIS_BASIP' + intClaFis + ', 0) AS FIS_BASIP1, ';
  strSQL := strSQL + '     IFNULL(CLFSC' + intClaFis + '.FIS_VLRIP' + intClaFis + ', 0) AS FIS_VLRIP1, ';
  strSQL := strSQL + '     IFNULL(CLFSC' + intClaFis + '.FIS_ANTIC' + intClaFis + ', 0) AS FIS_ANTIC1 ';
  strSQL := strSQL + '   FROM ';
  strSQL := strSQL + '     CADFIS CLFSC' + intClaFis;
  strSQL := strSQL + '   WHERE (IFNULL(CLFSC' + intClaFis + '.FIS_HISTOR, "") <> "CANCELADO") ';


  strSQL := strSQL + 'AND CLFSC' + intClaFis + '.FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN ';


  strSQL := strSQL + fStrLocateEmpresa(nil, arrEmp, 'CLFSC' + intClaFis + '.FIS_CODEMP', 'CODEMP', false, strCodEmp);

//  if not chkInc933.Checked then
//    strSQL := strSQL + '   AND LOCATE(RIGHT(CLFSC' + intClaFis + '.FIS_CLFSC' + intClaFis + ', 3), "933") <= 0 ';

  strSQL := strSQL + '     AND LENGTH(CLFSC' + intClaFis + '.FIS_CLFSC' + intClaFis + ') > 0 ';

  result := strSQL;
end;

function TRepositorioNotasFiscais.fGetSqlConverteFiscDeCincoPraUmDief(strCodEmp,
  intClaFis: string): string;
  var
    strSQL: string;
begin
  strSQL := '            SELECT ';
  strSQL := strSQL + '     CLFSC' + intClaFis + '.FIS_NFCOMP AS FIS_NFCOMP, ';
  strSQL := strSQL + '     CLFSC' + intClaFis + '.FIS_ENTSAI AS FIS_ENTSAI, ';
  strSQL := strSQL + '     CLFSC' + intClaFis + '.FIS_CODEMP AS FIS_CODEMP, ';
  strSQL := strSQL + '     CLFSC' + intClaFis + '.FIS_ACESSO AS FIS_ACESSO, ';
  strSQL := strSQL + '     CLFSC' + intClaFis + '.FIS_HISTOR AS FIS_HISTOR, ';
  strSQL := strSQL + '     CLFSC' + intClaFis + '.FIS_DTAENT AS FIS_DTAENT, ';
  strSQL := strSQL + '     CLFSC' + intClaFis + '.FIS_DTADOC AS FIS_DTADOC, ';
  strSQL := strSQL + '     CLFSC' + intClaFis + '.FIS_NUMDOC AS FIS_NUMDOC, ';
  strSQL := strSQL + '     CLFSC' + intClaFis + '.FIS_SERIE_ AS FIS_SERIE_, ';
  strSQL := strSQL + '     CLFSC' + intClaFis + '.FIS_FORCLI AS FIS_FORCLI, ';
  strSQL := strSQL + '     CLFSC' + intClaFis + '.FIS_ESPDOC AS FIS_ESPDOC, ';
  strSQL := strSQL + '     CLFSC' + intClaFis + '.FIS_TIP_FC AS FIS_TIP_FC, ';
  strSQL := strSQL + '     IFNULL(CLFSC' + intClaFis + '.FIS_CLFSC' + intClaFis + ', "") AS FIS_CLFSC1, ';
  strSQL := strSQL + '     IFNULL(CLFSC' + intClaFis + '.FIS_VLCON' + intClaFis + ', 0) AS FIS_VLCON1, ';
  strSQL := strSQL + '     IFNULL(CLFSC' + intClaFis + '.FIS_OUTRA' + intClaFis + ', 0) AS FIS_OUTRA1, ';
  strSQL := strSQL + '     IFNULL(CLFSC' + intClaFis + '.FIS_BCRET' + intClaFis + ', 0) AS FIS_BCRET1, ';
  strSQL := strSQL + '     IFNULL(CLFSC' + intClaFis + '.FIS_RETID' + intClaFis + ', 0) AS FIS_RETID1, ';
  strSQL := strSQL + '     IFNULL(CLFSC' + intClaFis + '.FIS_ISENT' + intClaFis + ', 0) AS FIS_ISENT1, ';
  strSQL := strSQL + '     IFNULL(CLFSC' + intClaFis + '.FIS_BASIC' + intClaFis + ', 0) AS FIS_BASIC1, ';
  strSQL := strSQL + '     IFNULL(CLFSC' + intClaFis + '.FIS_ALQIC' + intClaFis + ', 0) AS FIS_ALQIC1, ';
  strSQL := strSQL + '     IFNULL(CLFSC' + intClaFis + '.FIS_VLRIC' + intClaFis + ', 0) AS FIS_VLRIC1, ';
  strSQL := strSQL + '     IFNULL(CLFSC' + intClaFis + '.FIS_BASIP' + intClaFis + ', 0) AS FIS_BASIP1, ';
  strSQL := strSQL + '     IFNULL(CLFSC' + intClaFis + '.FIS_VLRIP' + intClaFis + ', 0) AS FIS_VLRIP1, ';
  strSQL := strSQL + '     IFNULL(CLFSC' + intClaFis + '.FIS_ANTIC' + intClaFis + ', 0) AS FIS_ANTIC1 ';
  strSQL := strSQL + '   FROM ';
  strSQL := strSQL + '     CADFIS CLFSC' + intClaFis;
  strSQL := strSQL + '   WHERE (IFNULL(CLFSC' + intClaFis + '.FIS_HISTOR, "") <> "CANCELADO") ';
  strSQL := strSQL + '     AND CLFSC' + intClaFis + '.FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN ';
  strSQL := strSQL + fStrLocateEmpresa(nil, arrEmp, 'CLFSC' + intClaFis + '.FIS_CODEMP', 'CODEMP', false, strCodEmp);
  strSQL := strSQL + '     AND LENGTH(CLFSC' + intClaFis + '.FIS_CLFSC' + intClaFis + ') > 0 ';

  result := strSQL;
end;

function TRepositorioNotasFiscais.fGetSqlUnionConverteFiscDeCincoPraUm(strCodEmp: String): string;
  Var
    strSQL: String;
    intClaFis: Integer;
Begin
  strSQL := '';
  strSQL := '( SELECT ';
  strSQL := strSQL + '   FIS_NFCOMP, ';
  strSQL := strSQL + '   FIS_ENTSAI, ';
  strSQL := strSQL + '   FIS_ESPDOC, ';
  strSQL := strSQL + '   FIS_ACESSO, ';
  strSQL := strSQL + '   FIS_HISTOR, ';
  strSQL := strSQL + '   FIS_DTAENT, ';
  strSQL := strSQL + '   FIS_DTADOC, ';
  strSQL := strSQL + '   FIS_CODEMP, ';
  strSQL := strSQL + '   FIS_NUMDOC, ';
  strSQL := strSQL + '   FIS_SERIE_, ';
  strSQL := strSQL + '   FIS_TIP_FC, ';
  strSQL := strSQL + '   FIS_FORCLI, ';
  strSQL := strSQL + '   FIS_CLFSC1, ';
  strSQL := strSQL + '   FIS_ALQIC1, ';
  strSQL := strSQL + '   SUM(FIS_VLCON1) AS FIS_VLCON1, ';
  strSQL := strSQL + '   SUM(FIS_OUTRA1) AS FIS_OUTRA1, ';
  strSQL := strSQL + '   SUM(FIS_BCRET1) AS FIS_BCRET1, ';
  strSQL := strSQL + '   SUM(FIS_RETID1) AS FIS_RETID1, ';
  strSQL := strSQL + '   SUM(FIS_ISENT1) AS FIS_ISENT1, ';
  strSQL := strSQL + '   SUM(FIS_BASIC1) AS FIS_BASIC1, ';
  strSQL := strSQL + '   SUM(FIS_VLRIC1) AS FIS_VLRIC1, ';
  strSQL := strSQL + '   SUM(FIS_BASIP1) AS FIS_BASIP1, ';
  strSQL := strSQL + '   SUM(FIS_VLRIP1) AS FIS_VLRIP1, ';
  strSQL := strSQL + '   SUM(FIS_ANTIC1) AS FIS_ANTIC1 ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   ( ';

  for intClaFis := 1 to 5 do
  begin
    strSQL := strSQL + fGetSqlConverteFiscDeCincoPraUm(strCodEmp, IntToStr(intClaFis));
    if intClaFis <> 5 then
      strSQL := strSQL + ' UNION ALL ';
  end;

  strSQL := strSQL + ' ) AS TCADFIS ';
  strSQL := strSQL + ' GROUP BY FIS_CODEMP, ';
  strSQL := strSQL + '   FIS_NUMDOC, ';
  strSQL := strSQL + '   FIS_SERIE_, ';
  strSQL := strSQL + '   FIS_TIP_FC, ';
  strSQL := strSQL + '   FIS_FORCLI, ';
  strSQL := strSQL + '   FIS_DTAENT, ';
  strSQL := strSQL + '   FIS_DTADOC, ';
  strSQL := strSQL + '   FIS_HISTOR, ';
  strSQL := strSQL + '   FIS_ACESSO, ';
  strSQL := strSQL + '   FIS_ESPDOC, ';
  strSQL := strSQL + '   FIS_ENTSAI, ';
  strSQL := strSQL + '   FIS_CLFSC1, ';
  strSQL := strSQL + '   FIS_ALQIC1 ) AS TB_CADFIS ';

  Result := strSQL;
end;

function TRepositorioNotasFiscais.fGetSqlUnionConverteFiscDeCincoPraUmDief(
  strCodEmp: String): string;
  Var
    strSQL: String;
    intClaFis: Integer;
Begin
  strSQL := '';
  strSQL := '( SELECT ';
  strSQL := strSQL + '   FIS_NFCOMP, ';
  strSQL := strSQL + '   FIS_ENTSAI, ';
  strSQL := strSQL + '   FIS_ESPDOC, ';
  strSQL := strSQL + '   FIS_ACESSO, ';
  strSQL := strSQL + '   FIS_HISTOR, ';
  strSQL := strSQL + '   FIS_DTAENT, ';
  strSQL := strSQL + '   FIS_DTADOC, ';
  strSQL := strSQL + '   FIS_CODEMP, ';
  strSQL := strSQL + '   FIS_NUMDOC, ';
  strSQL := strSQL + '   FIS_SERIE_, ';
  strSQL := strSQL + '   FIS_TIP_FC, ';
  strSQL := strSQL + '   FIS_FORCLI, ';
  strSQL := strSQL + '   FIS_CLFSC1, ';
  strSQL := strSQL + '   FIS_ALQIC1, ';
  strSQL := strSQL + '   FIS_VLCON1 AS FIS_VLCON1, ';
  strSQL := strSQL + '   FIS_OUTRA1 AS FIS_OUTRA1, ';
  strSQL := strSQL + '   FIS_BCRET1 AS FIS_BCRET1, ';
  strSQL := strSQL + '   FIS_RETID1 AS FIS_RETID1, ';
  strSQL := strSQL + '   FIS_ISENT1 AS FIS_ISENT1, ';
  strSQL := strSQL + '   FIS_BASIC1 AS FIS_BASIC1, ';
  strSQL := strSQL + '   FIS_VLRIC1 AS FIS_VLRIC1, ';
  strSQL := strSQL + '   FIS_BASIP1 AS FIS_BASIP1, ';
  strSQL := strSQL + '   FIS_VLRIP1 AS FIS_VLRIP1, ';
  strSQL := strSQL + '   FIS_ANTIC1 AS FIS_ANTIC1 ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   ( ';

  for intClaFis := 1 to 5 do
  begin
    strSQL := strSQL + fGetSqlConverteFiscDeCincoPraUmDief(strCodEmp, IntToStr(intClaFis));
    if intClaFis <> 5 then
      strSQL := strSQL + ' UNION ALL ';
  end;

  strSQL := strSQL + ' ) AS TCADFIS ';
  strSQL := strSQL + ' GROUP BY FIS_CODEMP, ';
  strSQL := strSQL + '   FIS_NUMDOC, ';
  strSQL := strSQL + '   FIS_SERIE_, ';
  strSQL := strSQL + '   FIS_TIP_FC, ';
  strSQL := strSQL + '   FIS_FORCLI, ';
  strSQL := strSQL + '   FIS_DTAENT, ';
  strSQL := strSQL + '   FIS_DTADOC, ';
  strSQL := strSQL + '   FIS_HISTOR, ';
  strSQL := strSQL + '   FIS_ACESSO, ';
  strSQL := strSQL + '   FIS_ESPDOC, ';
  strSQL := strSQL + '   FIS_ENTSAI, ';
  strSQL := strSQL + '   FIS_CLFSC1, ';
  strSQL := strSQL + '   FIS_ALQIC1 ) AS TB_CADFIS ';

  Result := strSQL;
end;

function TRepositorioNotasFiscais.fGetSqlUnionDief(strCodEmp: String): String;
  Var
    strSQL: String;
    intClaFis: Integer;
Begin
  strSQL := '';
  For intClaFis := 1 To 1 Do
  Begin
    strSQL := strSQL + fGetSqlFiscDief(strCodEmp, intClaFis);
    If intClaFis <> 1 Then
      strSQL := strSQL + ' UNION ALL ';
  End;

  Result := strSQL;
end;

function TRepositorioNotasFiscais.fSQLValorIcms(const strCampo: String): String;
begin
  Result := ' IF(((FIS_ESPDOC IN ("IF","IV")) AND (IFNULL(FIS_ACESSO, "") = "")), 0, ' + strCampo + ')';
end;

Function TRepositorioNotasFiscais.fGetSqlFisc(strCodEmp: String; intClaFis: Integer): String;
  Var
    FStrSqlValFcp,
    FStrSqlValFcpSt,
    strSQL   : String;
Begin
  FStrSqlValFcpSt := ' 0 ';//'IFNULL(MT.DET_VFCPST, IFNULL(NT.DET_VFCPST, 0)) ';
  FStrSqlValFcp := ' 0 ';//'IFNULL(MI.ICD_VALFCP, IFNULL(NI.ICD_VALFCP, 0)) ';

  strSQL := '';
  strSQL := strSQL + 'SELECT           ';

  strSQL := strSQL + 'CLI_C_E_P_, ';
  strSQL := strSQL + 'FOR_C_E_P_, ';
  strSQL := strSQL + 'CLI_C_G_C_, ';
  strSQL := strSQL + 'FOR_C_G_C_, ';
  strSQL := strSQL + 'CLI_NOMCLI, ';
  strSQL := strSQL + 'FOR_NOMFOR, ';
  strSQL := strSQL + 'CLI_BAIRRO, ';
  strSQL := strSQL + 'FOR_BAIRRO, ';
  strSQL := strSQL + 'CLI_ENDERE, ';
  strSQL := strSQL + 'FOR_ENDERE, ';
  strSQL := strSQL + 'CLI_FONE01, ';
  strSQL := strSQL + 'FOR_FONE01, ';
  strSQL := strSQL + 'FIS_ALQIC1, ';
  strSQL := strSQL + 'IF( ';
  strSQL := strSQL + '  FIS_TIP_FC = "C", ';
  strSQL := strSQL + '  CC.CID_ESTADO, ';
  strSQL := strSQL + '  CF.CID_ESTADO ';
  strSQL := strSQL + ') AS UF, ';
  strSQL := strSQL + 'IF( ';
  strSQL := strSQL + '  FIS_TIP_FC = "C", ';
  strSQL := strSQL + '  CC.CID_NOMCID, ';
  strSQL := strSQL + '  CF.CID_NOMCID ';
  strSQL := strSQL + ') AS MUNICIPIO, ';
  strSQL := strSQL + 'IF( ';
  strSQL := strSQL + '  FIS_TIP_FC = "C", ';
  strSQL := strSQL + '  CC.CID_COIBGE, ';
  strSQL := strSQL + '  CF.CID_COIBGE ';
  strSQL := strSQL + ') AS CODIGO_IBGE, ';
  strSQL := strSQL + 'MG.GER_CONPAG, ';
  strSQL := strSQL + 'MG.GER_TIPFRE, ';
  strSQL := strSQL + 'MG.GER_TOTFRE, ';
  strSQL := strSQL + 'MG.GER_DESESP, ';
  strSQL := strSQL + 'MD.DET_CODITE, ';
  strSQL := strSQL + 'MD.DET_DESCRI, ';
  strSQL := strSQL + 'MD.DET_UNIDAD, ';
  strSQL := strSQL + 'MD.DET_QTDITE, ';
  strSQL := strSQL + 'MD.DET_VLRCON, ';
  strSQL := strSQL + 'MD.DET_TOTITE, ';
  strSQL := strSQL + 'MD.DET_TOTFRE, ';
  strSQL := strSQL + 'MD.DET_UNITAR, ';
  strSQL := strSQL + 'MD.DET_DESESP, ';
  strSQL := strSQL + 'MD.DET_PERRED, ';
  strSQL := strSQL + 'MD.DET_CODFIS, ';
  strSQL := strSQL + 'MD.DET_ALQICM, ';
  strSQL := strSQL + 'MD.DET_BASIPI, ';
  strSQL := strSQL + 'MD.DET_ALQIPI, ';
  strSQL := strSQL + 'MD.DET_DESACE, ';
  strSQL := strSQL + 'FIS_ACESSO, ';
  strSQL := strSQL + 'FIS_HISTOR, ';
  strSQL := strSQL + 'FIS_NUMDOC, ';
  strSQL := strSQL + 'FIS_CODEMP, ';
  strSQL := strSQL + 'FIS_SERIE_, ';
  strSQL := strSQL + 'FIS_ESPDOC, ';
  strSQL := strSQL + 'FIS_FORCLI, ';
  strSQL := strSQL + 'FIS_TIP_FC, ';
  strSQL := strSQL + 'FIS_DTAENT, ';
  strSQL := strSQL + 'FIS_DTADOC, ';
  strSQL := strSQL + 'FIS_NFCOMP, ';


  strSQL := strSQL + '  CRE_ICMANT      AS ICMANT, ';
  strSQL := strSQL + '  EMP_I_E_S_      AS I_E_S_, ';
  strSQL := strSQL + '  EMP_C_G_C_      AS C_G_C_, ';
  strSQL := strSQL + '  CIDEMP.CID_ESTADO      AS ESTADO, ';
  strSQL := strSQL + '  FIS_CLFSC'     + IntToStr(intClaFis) + '  AS CLAFSC, ';

//  If (ckbRegistrado_Ecf.Checked) And
//     (ckbEnviaValores1603_2603.Checked) Then
  Begin
    strSQL := strSQL + '  SUM(IFNULL(MD.DET_VLRCON, IFNULL(ND.DET_VLRCON, IFNULL(FIS_VLCON' + IntToStr(intClaFis) + ',0)))) AS VLRCON, ';
    strSQL := strSQL + '  SUM(IFNULL(MD.DET_BASICM, IFNULL(ND.DET_BASICM, IFNULL(FIS_BASIC' + IntToStr(intClaFis) + ',0)))) AS BASICM, ';
    strSQL := strSQL + '  SUM(' + FStrSqlValFcp + ' + ' + fSQLValorIcms('IFNULL(MD.DET_VALICM, IFNULL(ND.DET_VALICM, IFNULL(FIS_VLRIC' + IntToStr(intClaFis) + ', 0)))')+') AS VLRICM, ';
    strSQL := strSQL + '  SUM(' + FstrSqlValFcpSt + ' + IFNULL(MD.DET_VALRET, IFNULL(ND.DET_VALRET, IFNULL(FIS_RETID' + IntToStr(intClaFis) + ',0)))) AS RETIDO, ';
    strSQL := strSQL + '  SUM(' + FstrSqlValFcpSt + ' + IFNULL(MD.DET_BASRET, IFNULL(ND.DET_BASRET, IFNULL(FIS_RETID' + IntToStr(intClaFis) + ',0)))) AS BASRET, ';
    strSQL := strSQL + '  SUM(IFNULL(MT.DET_OUTICM, IFNULL(NT.DET_OUTICM, IFNULL(FIS_OUTRA' + IntToStr(intClaFis) + ',0)))) AS OUTRAS, ';
    strSQL := strSQL + '  SUM(IFNULL(MT.DET_ISEICM, IFNULL(NT.DET_ISEICM, IFNULL(FIS_ISENT' + IntToStr(intClaFis) + ',0)))) AS ISENTA, ';
    strSQL := strSQL + '  SUM(IFNULL(MD.DET_VALIPI, IFNULL(ND.DET_VALIPI, IFNULL(FIS_VLRIP' + IntToStr(intClaFis) + ',0)))) AS VLRIPI  ';

//    blnClaEcf := False;
  End;
  //Else
//  Begin
//    strSQL := strSQL + '  SUM(IF(LOCATE(FIS_CLFSC' + IntToStr(intClaFis) + ', :CLAECF) > 0, "0.0", IFNULL(MD.DET_VLRCON, IFNULL(ND.DET_VLRCON, IFNULL(FIS_VLCON' + IntToStr(intClaFis) + ',0))))) AS VLRCON, ';
//    strSQL := strSQL + '  SUM(IF(LOCATE(FIS_CLFSC' + IntToStr(intClaFis) + ', :CLAECF) > 0, "0.0", IFNULL(MD.DET_BASICM, IFNULL(ND.DET_BASICM, IFNULL(FIS_BASIC' + IntToStr(intClaFis) + ',0))))) AS BASICM, ';
//    strSQL := strSQL + '  SUM(IF(LOCATE(FIS_CLFSC' + IntToStr(intClaFis) + ', :CLAECF) > 0, "0.0", ' + FStrSqlValFcp + ' + ' + fSQLValorIcms('IFNULL(MD.DET_VALICM, IFNULL(ND.DET_VALICM, IFNULL(FIS_VLRIC' + IntToStr(intClaFis) + ',0)))') + ')) AS VLRICM, ';
//    strSQL := strSQL + '  SUM(IF(LOCATE(FIS_CLFSC' + IntToStr(intClaFis) + ', :CLAECF) > 0, "0.0", ' + FStrSqlValFcpSt + ' + IFNULL(MD.DET_VALRET, IFNULL(ND.DET_VALRET, IFNULL(FIS_RETID' + IntToStr(intClaFis) + ',0))))) AS RETIDO, ';
//    strSQL := strSQL + '  SUM(IF(LOCATE(FIS_CLFSC' + IntToStr(intClaFis) + ', :CLAECF) > 0, "0.0", IFNULL(MT.DET_OUTICM, IFNULL(NT.DET_OUTICM, IFNULL(FIS_OUTRA' + IntToStr(intClaFis) + ',0))))) AS OUTRAS, ';
//    strSQL := strSQL + '  SUM(IF(LOCATE(FIS_CLFSC' + IntToStr(intClaFis) + ', :CLAECF) > 0, "0.0", IFNULL(MT.DET_ISEICM, IFNULL(NT.DET_ISEICM, IFNULL(FIS_ISENT' + IntToStr(intClaFis) + ',0))))) AS ISENTA, ';
//    strSQL := strSQL + '  SUM(IF(LOCATE(FIS_CLFSC' + IntToStr(intClaFis) + ', :CLAECF) > 0, "0.0", IFNULL(MD.DET_VALIPI, IFNULL(ND.DET_VALIPI, IFNULL(FIS_VLRIP' + IntToStr(intClaFis) + ',0))))) AS VLRIPI  ';
//
//    blnClaEcf := True;
//  End;

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + fGetSqlUnionConverteFiscDeCincoPraUm(strCodEmp);

  strSQL := strSQL + '  LEFT JOIN MOVGER MG ';
  strSQL := strSQL + '    ON MG.GER_NUMDOC = FIS_NUMDOC ';
  strSQL := strSQL + '    AND MG.GER_ESPDOC = FIS_ESPDOC ';
  strSQL := strSQL + '    AND MG.GER_CODEMP = FIS_CODEMP ';
  strSQL := strSQL + '    AND IFNULL(MG.GER_SERIE_, "") = IFNULL(FIS_SERIE_, "") ';
  strSQL := strSQL + '    AND IF(FIS_TIP_FC = "C", MG.GER_CODCLI, MG.GER_CODFOR) = FIS_FORCLI ';

  strSQL := strSQL + '  LEFT JOIN NOTGER ';
  strSQL := strSQL + '    ON NOTGER.GER_NUMDOC = FIS_NUMDOC ';
  strSQL := strSQL + '    AND NOTGER.GER_ESPDOC = FIS_ESPDOC ';
  strSQL := strSQL + '    AND NOTGER.GER_CODEMP = FIS_CODEMP ';
  strSQL := strSQL + '    AND IFNULL(NOTGER.GER_SERIE_, "") = IFNULL(FIS_SERIE_, "") ';
  strSQL := strSQL + '    AND IF(FIS_TIP_FC = "C", NOTGER.GER_CODCLI, NOTGER.GER_CODFOR) = FIS_FORCLI ';

  strSQL := strSQL + '  LEFT JOIN MOVDET MD ';
  strSQL := strSQL + '    ON MD.DET_NUMDOC = FIS_NUMDOC ';
  strSQL := strSQL + '    AND MD.DET_CODEMP = FIS_CODEMP ';
  strSQL := strSQL + '    AND MD.DET_ESPDOC = FIS_ESPDOC ';
  strSQL := strSQL + '    AND IFNULL(MD.DET_SERIE_, "") = IFNULL(FIS_SERIE_, "") ';
  strSQL := strSQL + '    AND IF(FIS_TIP_FC = "C", MD.DET_CODCLI, MD.DET_CODFOR) = FIS_FORCLI ';
  strSQL := strSQL + '    AND MD.DET_CLAFIS = FIS_CLFSC' + IntToStr(intClaFis);
  strSQL := strSQL + '    AND MD.DET_ALQICM = FIS_ALQIC' + IntToStr(intClaFis);

  strSQL := strSQL + '  LEFT JOIN MOVTRI MT ON MT.DET_SEQGER = MD.AUTOINCREM ';

  strSql := strSql + '  LEFT JOIN MOVICD MI ON MI.ICD_SEQGER = MD.AUTOINCREM ';

  strSQL := strSQL + '  LEFT JOIN NOTDET ND ';
  strSQL := strSQL + '    ON ND.DET_NUMDOC = FIS_NUMDOC ';
  strSQL := strSQL + '    AND ND.DET_CODEMP = FIS_CODEMP ';
  strSQL := strSQL + '    AND ND.DET_ESPDOC = FIS_ESPDOC ';
  strSQL := strSQL + '    AND IFNULL(ND.DET_SERIE_, "") = IFNULL(FIS_SERIE_, "") ';
  strSQL := strSQL + '    AND IF(FIS_TIP_FC = "C", ND.DET_CODCLI, ND.DET_CODFOR) = FIS_FORCLI ';
  strSQL := strSQL + '    AND ND.DET_CLAFIS = FIS_CLFSC' + IntToStr(intClaFis);
  strSQL := strSQL + '    AND ND.DET_ALQICM = FIS_ALQIC' + IntToStr(intClaFis);

  strSQL := strSQL + '  LEFT JOIN NOTTRI NT ON NT.DET_SEQGER = ND.AUTOINCREM ';

  strSql := strSql + '  LEFT JOIN NOTICD NI ON NI.ICD_SEQGER = ND.AUTOINCREM ';

  strSQL := strSQL + '  INNER JOIN CADEMP ON EMP_CODEMP = FIS_CODEMP ';

  strSQL := strSQL + '  INNER JOIN CADCID CIDEMP ON CIDEMP.CID_CODCID = EMP_CODCID ';

  strSQL := strSQL + '  LEFT JOIN CREFIS ON CRE_CODEMP = EMP_CODEMP AND ';
  strSQL := strSQL + '                      CRE_MESREF = :MESREF ';

  strSQL := strSQL + '  LEFT JOIN CADTRA TRA ON TRA.TRA_CODTRA = MG.GER_CODTRA ';
  strSQL := strSQL + '  LEFT JOIN CADCLI ON CLI_CODCLI = IF(  ';
  strSQL := strSQL + '                      FIS_TIP_FC = "C", ';
  strSQL := strSQL + '                      FIS_FORCLI, NULL) ';

  strSQL := strSQL + '  LEFT JOIN CADFOR ON FOR_CODFOR = IF(  ';
  strSQL := strSQL + '                      FIS_TIP_FC = "F", ';
  strSQL := strSQL + '                      FIS_FORCLI, NULL) ';

  strSQL := strSQL + '  LEFT JOIN CADCID CC ON CC.CID_CODCID = CLI_CODCID ';
  strSQL := strSQL + '  LEFT JOIN CADCID CF ON CF.CID_CODCID = FOR_CODCID ';
  strSQL := strSQL + '  LEFT JOIN CADCID CIDTRA ON CIDTRA.CID_CODCID = TRA_CODCID ';

  strSQL := strSQL + 'WHERE ';

  strSQL := strSQL + '  (IFNULL(FIS_HISTOR, "") <> "CANCELADO") AND ';

  strSQL := strSQL + '  FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

  strSQL := strSQL + fStrLocateEmpresa(nil, arrEmp, 'FIS_CODEMP', 'CODEMP', false, strCodEmp);

  strSQL := strSQL + 'GROUP BY ';
  strSQL := strSQL + '  FIS_CLFSC' + IntToStr(intClaFis) + ' ';

  Result := strSQL;
End;

function TRepositorioNotasFiscais.fGetSqlFiscDief(strCodEmp: String;
  intClaFis: Integer): String;
  Var
    FStrSqlValFcp,
    FStrSqlValFcpSt,
    strSQL   : String;
Begin
  FStrSqlValFcpSt := ' 0 ';
  FStrSqlValFcp := ' 0 ';

  strSQL := '';
  strSQL := strSQL + 'SELECT      ';
  strSQL := strSQL + 'CLI_C_E_P_, ';
  strSQL := strSQL + 'FOR_C_E_P_, ';
  strSQL := strSQL + 'CLI_C_G_C_, ';
  strSQL := strSQL + 'FOR_C_G_C_, ';
  strSQL := strSQL + 'CLI_NOMCLI, ';
  strSQL := strSQL + 'FOR_NOMFOR, ';
  strSQL := strSQL + 'CLI_BAIRRO, ';
  strSQL := strSQL + 'FOR_BAIRRO, ';
  strSQL := strSQL + 'CLI_ENDERE, ';
  strSQL := strSQL + 'FOR_ENDERE, ';
  strSQL := strSQL + 'CLI_FONE01, ';
  strSQL := strSQL + 'FOR_FONE01, ';
  strSQL := strSQL + 'FIS_ALQIC1, ';
  (*strSQL := strSQL + 'IF( ';
  strSQL := strSQL + '  FIS_TIP_FC = "C", ';
  strSQL := strSQL + '  CC.CID_ESTADO, ';
  strSQL := strSQL + '  CF.CID_ESTADO ';
  strSQL := strSQL + ') AS UF, ';*)
  strSQL := strSQL + 'IFNULL( ';
  strSQL := strSQL + '  IFNULL(MG.GER_ESTADO, NOTGER.GER_ESTADO), ';
  strSQL := strSQL + '    IF(FIS_TIP_FC = "C", ';
  strSQL := strSQL + '      CC.CID_ESTADO, ';
  strSQL := strSQL + '      CF.CID_ESTADO ';
  strSQL := strSQL + ')) AS UF, ';
  strSQL := strSQL + 'IF( ';
  strSQL := strSQL + '  FIS_TIP_FC = "C", ';
  strSQL := strSQL + '  CC.CID_NOMCID, ';
  strSQL := strSQL + '  CF.CID_NOMCID ';
  strSQL := strSQL + ') AS MUNICIPIO, ';
  strSQL := strSQL + 'IF( ';
  strSQL := strSQL + '  FIS_TIP_FC = "C", ';
  strSQL := strSQL + '  CC.CID_COIBGE, ';
  strSQL := strSQL + '  CF.CID_COIBGE ';
  strSQL := strSQL + ') AS CODIGO_IBGE, ';
  strSQL := strSQL + 'MG.GER_CONPAG, ';
  strSQL := strSQL + 'MG.GER_TIPFRE, ';
  strSQL := strSQL + 'MG.GER_TOTFRE, ';
  strSQL := strSQL + 'MG.GER_DESESP, ';
  strSQL := strSQL + 'IFNULL(MG.GER_CGCCON, NOTGER.GER_CGCCON) AS CGCCON, ';
  strSQL := strSQL + 'MD.DET_CODITE, ';
  strSQL := strSQL + 'MD.DET_DESCRI, ';
  strSQL := strSQL + 'MD.DET_UNIDAD, ';
  strSQL := strSQL + 'MD.DET_QTDITE, ';
  strSQL := strSQL + 'MD.DET_VLRCON, ';
  strSQL := strSQL + 'MD.DET_TOTITE, ';
  strSQL := strSQL + 'MD.DET_TOTFRE, ';
  strSQL := strSQL + 'MD.DET_UNITAR, ';
  strSQL := strSQL + 'MD.DET_DESESP, ';
  strSQL := strSQL + 'MD.DET_PERRED, ';
  strSQL := strSQL + 'IFNULL(MD.DET_CODFIS, IFNULL(ND.DET_CODFIS, ND.DET_CODFIS)) AS CODFIS, ';
  strSQL := strSQL + 'MD.DET_ALQICM, ';
  strSQL := strSQL + 'MD.DET_BASIPI, ';
  strSQL := strSQL + 'MD.DET_ALQIPI, ';
  strSQL := strSQL + 'MD.DET_DESACE, ';
  strSQL := strSQL + 'FIS_ACESSO, ';
  strSQL := strSQL + 'FIS_HISTOR, ';
  strSQL := strSQL + 'FIS_NUMDOC, ';
  strSQL := strSQL + 'FIS_CODEMP, ';
  strSQL := strSQL + 'FIS_SERIE_, ';
  strSQL := strSQL + 'FIS_ESPDOC, ';
  strSQL := strSQL + 'FIS_FORCLI, ';
  strSQL := strSQL + 'FIS_TIP_FC, ';
  strSQL := strSQL + 'FIS_DTAENT, ';
  strSQL := strSQL + 'FIS_DTADOC, ';
  strSQL := strSQL + 'FIS_NFCOMP, ';

  strSQL := strSQL + 'EMP_I_E_S_ AS I_E_S_, ';
  strSQL := strSQL + 'EMP_C_G_C_ AS C_G_C_, ';
  strSQL := strSQL + 'CIDEMP.CID_ESTADO AS ESTADO, ';
  strSQL := strSQL + 'FIS_CLFSC' + IntToStr(intClaFis) + ' AS CLAFSC, ';

  strSQL := strSQL + 'IFNULL(MD.DET_VLRCON, IFNULL(ND.DET_VLRCON, IFNULL(FIS_VLCON' + IntToStr(intClaFis) + ',0))) AS VLRCON, ';
  strSQL := strSQL + 'IFNULL(MD.DET_BASICM, IFNULL(ND.DET_BASICM, IFNULL(FIS_BASIC' + IntToStr(intClaFis) + ',0))) AS BASICM, ';
  strSQL := strSQL +  FStrSqlValFcp + ' + ' + fSQLValorIcms('IFNULL(MD.DET_VALICM, IFNULL(ND.DET_VALICM, IFNULL(FIS_VLRIC' + IntToStr(intClaFis) + ', 0)))')+' AS VLRICM, ';
  strSQL := strSQL +  FstrSqlValFcpSt + ' + IFNULL(MD.DET_VALRET, IFNULL(ND.DET_VALRET, IFNULL(FIS_RETID' + IntToStr(intClaFis) + ',0))) AS RETIDO, ';
  strSQL := strSQL +  FstrSqlValFcpSt + ' + IFNULL(MD.DET_BASRET, IFNULL(ND.DET_BASRET, IFNULL(FIS_RETID' + IntToStr(intClaFis) + ',0))) AS BASRET, ';
  strSQL := strSQL + 'IFNULL(MT.DET_OUTICM, IFNULL(NT.DET_OUTICM, IFNULL(FIS_OUTRA' + IntToStr(intClaFis) + ',0))) AS OUTRAS, ';
  strSQL := strSQL + 'IFNULL(MT.DET_ISEICM, IFNULL(NT.DET_ISEICM, IFNULL(FIS_ISENT' + IntToStr(intClaFis) + ',0))) AS ISENTA, ';
  strSQL := strSQL + 'IFNULL(MD.DET_VALIPI, IFNULL(ND.DET_VALIPI, IFNULL(FIS_VLRIP' + IntToStr(intClaFis) + ',0))) AS VLRIPI, ';

  if fCampoExiste('MOVTRI', 'DET_VAERET') then
    strSQL := strSQL + ' IFNULL(MT.DET_VAERET, 0) AS VAERET, '
  else strSQL := strSQL + '  0 AS VAERET, ';

  if fCampoExiste('MOVTRI', 'DET_VAERET') then
    strSQL := strSQL + ' IFNULL(MT.DET_VAEIPI, 0) AS VAEIPI  '
  else strSQL := strSQL + '  0 AS VAEIPI  ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + fGetSqlUnionConverteFiscDeCincoPraUmDief(strCodEmp);

  strSQL := strSQL + '  LEFT JOIN MOVGER MG ';
  strSQL := strSQL + '    ON MG.GER_NUMDOC = FIS_NUMDOC ';
  strSQL := strSQL + '   AND MG.GER_ESPDOC = FIS_ESPDOC ';
  strSQL := strSQL + '   AND MG.GER_CODEMP = FIS_CODEMP ';
  strSQL := strSQL + '   AND IFNULL(MG.GER_SERIE_, "") = IFNULL(FIS_SERIE_, "") ';
  strSQL := strSQL + '   AND IF(FIS_TIP_FC = "C", MG.GER_CODCLI, MG.GER_CODFOR) = FIS_FORCLI ';

  strSQL := strSQL + '  LEFT JOIN NOTGER ';
  strSQL := strSQL + '    ON NOTGER.GER_NUMDOC = FIS_NUMDOC ';
  strSQL := strSQL + '   AND NOTGER.GER_ESPDOC = FIS_ESPDOC ';
  strSQL := strSQL + '   AND NOTGER.GER_CODEMP = FIS_CODEMP ';
  strSQL := strSQL + '   AND IFNULL(NOTGER.GER_SERIE_, "") = IFNULL(FIS_SERIE_, "") ';
  strSQL := strSQL + '   AND IF(FIS_TIP_FC = "C", NOTGER.GER_CODCLI, NOTGER.GER_CODFOR) = FIS_FORCLI ';

  strSQL := strSQL + '  LEFT JOIN MOVDET MD ';
  strSQL := strSQL + '    ON MD.DET_NUMDOC = FIS_NUMDOC ';
  strSQL := strSQL + '   AND MD.DET_CODEMP = FIS_CODEMP ';
  strSQL := strSQL + '   AND MD.DET_ESPDOC = FIS_ESPDOC ';
  strSQL := strSQL + '   AND IFNULL(MD.DET_SERIE_, "") = IFNULL(FIS_SERIE_, "") ';
  strSQL := strSQL + '   AND IF(FIS_TIP_FC = "C", MD.DET_CODCLI, MD.DET_CODFOR) = FIS_FORCLI ';
  strSQL := strSQL + '   AND MD.DET_CLAFIS = FIS_CLFSC' + IntToStr(intClaFis);
  strSQL := strSQL + '   AND MD.DET_ALQICM = FIS_ALQIC' + IntToStr(intClaFis);

  strSQL := strSQL + '  LEFT JOIN MOVTRI MT ON MT.DET_SEQGER = MD.AUTOINCREM ';

  if fTabelaExiste('MOVICD') then
    strSql := strSql + '  LEFT JOIN MOVICD MI ON MI.ICD_SEQGER = MD.AUTOINCREM ';

  strSQL := strSQL + '  LEFT JOIN NOTDET ND ';
  strSQL := strSQL + '    ON ND.DET_NUMDOC = FIS_NUMDOC ';
  strSQL := strSQL + '   AND ND.DET_CODEMP = FIS_CODEMP ';
  strSQL := strSQL + '   AND ND.DET_ESPDOC = FIS_ESPDOC ';
  strSQL := strSQL + '   AND IFNULL(ND.DET_SERIE_, "") = IFNULL(FIS_SERIE_, "") ';
  strSQL := strSQL + '   AND IF(FIS_TIP_FC = "C", ND.DET_CODCLI, ND.DET_CODFOR) = FIS_FORCLI ';
  strSQL := strSQL + '   AND ND.DET_CLAFIS = FIS_CLFSC' + IntToStr(intClaFis);
  strSQL := strSQL + '   AND ND.DET_ALQICM = FIS_ALQIC' + IntToStr(intClaFis);

  strSQL := strSQL + '  LEFT JOIN NOTTRI NT ON NT.DET_SEQGER = ND.AUTOINCREM ';

  strSql := strSql + '  LEFT JOIN NOTICD NI ON NI.ICD_SEQGER = ND.AUTOINCREM ';

  strSQL := strSQL + '  INNER JOIN CADEMP ON EMP_CODEMP = FIS_CODEMP ';

  strSQL := strSQL + '  INNER JOIN CADCID CIDEMP ON CIDEMP.CID_CODCID = EMP_CODCID ';

  strSQL := strSQL + '  LEFT JOIN CADTRA TRA ON TRA.TRA_CODTRA = MG.GER_CODTRA ';
  strSQL := strSQL + '  LEFT JOIN CADCLI ON CLI_CODCLI = IF(  ';
  strSQL := strSQL + '                      FIS_TIP_FC = "C", ';
  strSQL := strSQL + '                      FIS_FORCLI, NULL) ';

  strSQL := strSQL + '  LEFT JOIN CADFOR ON FOR_CODFOR = IF(  ';
  strSQL := strSQL + '                      FIS_TIP_FC = "F", ';
  strSQL := strSQL + '                      FIS_FORCLI, NULL) ';

  strSQL := strSQL + '  LEFT JOIN CADCID CC ON CC.CID_CODCID = CLI_CODCID ';
  strSQL := strSQL + '  LEFT JOIN CADCID CF ON CF.CID_CODCID = FOR_CODCID ';
  strSQL := strSQL + '  LEFT JOIN CADCID CIDTRA ON CIDTRA.CID_CODCID = TRA_CODCID ';

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  ((IFNULL(FIS_HISTOR, "") NOT LIKE "%CANCELAD%") AND ';
  strSQL := strSQL + '   (IFNULL(FIS_HISTOR, "") NOT LIKE "%DENEGAD%") AND ';
  strSQL := strSQL + '   (IFNULL(FIS_HISTOR, "") NOT LIKE "%INUTILIZAD%")) AND ';
  strSQL := strSQL + '  FIS_ESPDOC IN ("NF", "IF", "CT") AND ';

  strSQL := strSQL + '  FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN ';
  strSQL := strSQL + fStrLocateEmpresa(nil, arrEmp, 'FIS_CODEMP', 'CODEMP', false, strCodEmp);

  Result := strSQL;
end;

Function TRepositorioNotasFiscais.fGetSqlUnion(strCodEmp: String): String;
  Var
    strSQL: String;
    intClaFis: Integer;
Begin
  strSQL := '';
  For intClaFis := 1 To 1 Do
  Begin
    strSQL := strSQL + fGetSqlFisc(strCodEmp, intClaFis);
    If intClaFis <> 1 Then
      strSQL := strSQL + ' UNION ALL ';
  End;

  Result := strSQL;
End;


function TRepositorioNotasFiscais.fRetSqlTodasNotasFiscaisPorPeriodoDapi(strDtaIni, strDtaFin, strEmpresa: String): string;
  var
    strSQL: string;
Begin

(*
  strSQL := '';
  strSQL := strSQL + ' SELECT       ';
  strSQL := strSQL + '   ICMANT, ';
  strSQL := strSQL + '   I_E_S_, ';
  strSQL := strSQL + '   C_G_C_, ';
  strSQL := strSQL + '   ESTADO, ';
  strSQL := strSQL + '   CLAFSC, ';
  strSQL := strSQL + '   SUM(VLRCON) AS VLRCON, ';
  strSQL := strSQL + '   SUM(BASICM) AS BASICM, ';

  strSQL := strSQL + '  IFNULL(SUM(VLRICM),0) + IF(CLAFSC="5102", ' + fValorIcmsCupons(strDtaIni, strDtaFin, strEmpresa) + ',0) AS VLRICM, ';

  strSQL := strSQL + '   SUM(RETIDO) AS RETIDO, ';
  strSQL := strSQL + '   SUM(OUTRAS) AS OUTRAS, ';
  strSQL := strSQL + '   SUM(ISENTA) AS ISENTA, ';
  strSQL := strSQL + '   SUM(VLRIPI) AS VLRIPI  ';

  *)

  strSQL := '';
  strSQL := strSQL + ' SELECT       ';

  strSQL := strSQL + ' IFNULL(FIS_ACESSO, "") AS FIS_ACESSO, ';
  strSQL := strSQL + ' IFNULL(FIS_HISTOR, "") AS FIS_HISTOR, ';
  strSQL := strSQL + ' ESTADO AS FIS_ESTADO, ';
  strSQL := strSQL + ' FIS_NUMDOC, ';
  strSQL := strSQL + ' FIS_CODEMP, ';
  strSQL := strSQL + ' FIS_SERIE_, ';
  strSQL := strSQL + ' FIS_ESPDOC, ';
  strSQL := strSQL + ' FIS_FORCLI, ';
  strSQL := strSQL + ' FIS_TIP_FC, ';
  strSQL := strSQL + ' FIS_DTAENT, ';
  strSQL := strSQL + ' FIS_DTADOC, ';
  strSQL := strSQL + ' FIS_NFCOMP, ';
  strSQL := strSQL + ' IF( ';
  strSQL := strSQL + '   (FIS_ESPDOC = "NF") ';
  strSQL := strSQL + '   AND (IFNULL(FIS_ACESSO, "") = ""), ';
  strSQL := strSQL + '   "01", ';
  strSQL := strSQL + '   IF( ';
  strSQL := strSQL + '     ( ';
  strSQL := strSQL + '       (FIS_ESPDOC IN ("NF", "NV")) ';
  strSQL := strSQL + '       AND (IFNULL(FIS_ACESSO, "") <> "") ';
  strSQL := strSQL + '     ) ';
  strSQL := strSQL + '     OR (FIS_ESPDOC = "EL"), ';
  strSQL := strSQL + '     "55", ';
  strSQL := strSQL + '     IF( ';
  strSQL := strSQL + '       FIS_ESPDOC IN ("IF", "IV"), ';
  strSQL := strSQL + '       IF( ';
  strSQL := strSQL + '         ( ';
  strSQL := strSQL + '           (IFNULL(FIS_ACESSO, "") = "") ';
  strSQL := strSQL + '           AND ( ';
  strSQL := strSQL + '             IFNULL(FIS_HISTOR, "") NOT LIKE "%INUTILI%" ';
  strSQL := strSQL + '           ) ';
  strSQL := strSQL + '         ), ';
  strSQL := strSQL + '         "2D", ';
  strSQL := strSQL + '         "65" ';
  strSQL := strSQL + '       ), ';
  strSQL := strSQL + '       "01" ';
  strSQL := strSQL + '     ) ';
  strSQL := strSQL + '   ) ';
  strSQL := strSQL + ' ) AS FIS_DOCMOD, ';
  strSQL := strSQL + ' IF( ';
  strSQL := strSQL + '   IFNULL(FIS_HISTOR, "") = "CANCELADO", ';
  strSQL := strSQL + '   "02", ';
  strSQL := strSQL + '   "00" ';
  strSQL := strSQL + ' ) AS FIS_SITDOC, ';
  strSQL := strSQL + ' IFNULL(CLAFSC, "") AS FIS_CLFSC1, ';
  strSQL := strSQL + ' IFNULL(CLAFSC, "") AS FIS_CLFSC2, ';
  strSQL := strSQL + ' IFNULL(CLAFSC, "") AS FIS_CLFSC3, ';
  strSQL := strSQL + ' IFNULL(CLAFSC, "") AS FIS_CLFSC4, ';
  strSQL := strSQL + ' IFNULL(CLAFSC, "") AS FIS_CLFSC5, ';
  strSQL := strSQL + ' IFNULL(VLRCON, 0) AS FIS_VLCON1, ';
  strSQL := strSQL + ' 0 AS FIS_VLCON2, ';
  strSQL := strSQL + ' 0 AS FIS_VLCON3, ';
  strSQL := strSQL + ' 0 AS FIS_VLCON4, ';
  strSQL := strSQL + ' 0 AS FIS_VLCON5, ';
  strSQL := strSQL + ' IFNULL(OUTRAS, 0) AS FIS_OUTRA1, ';
  strSQL := strSQL + ' 0 AS FIS_OUTRA2, ';
  strSQL := strSQL + ' 0 AS FIS_OUTRA3, ';
  strSQL := strSQL + ' 0 AS FIS_OUTRA4, ';
  strSQL := strSQL + ' 0 AS FIS_OUTRA5, ';
  strSQL := strSQL + ' IFNULL(BASRET, 0) AS FIS_BCRET1, ';
  strSQL := strSQL + ' 0 AS FIS_BCRET2, ';
  strSQL := strSQL + ' 0 AS FIS_BCRET3, ';
  strSQL := strSQL + ' 0 AS FIS_BCRET4, ';
  strSQL := strSQL + ' 0 AS FIS_BCRET5, ';
  strSQL := strSQL + ' IFNULL(RETIDO, 0) AS FIS_RETID1, ';
  strSQL := strSQL + ' 0 AS FIS_RETID2, ';
  strSQL := strSQL + ' 0 AS FIS_RETID3, ';
  strSQL := strSQL + ' 0 AS FIS_RETID4, ';
  strSQL := strSQL + ' 0 AS FIS_RETID5, ';
  strSQL := strSQL + ' IFNULL(ISENTA, 0) AS FIS_ISENT1, ';
  strSQL := strSQL + ' 0 AS FIS_ISENT2, ';
  strSQL := strSQL + ' 0 AS FIS_ISENT3, ';
  strSQL := strSQL + ' 0 AS FIS_ISENT4, ';
  strSQL := strSQL + ' 0 AS FIS_ISENT5, ';
  strSQL := strSQL + ' IFNULL(BASICM, 0) AS FIS_BASIC1, ';
  strSQL := strSQL + ' 0 AS FIS_BASIC2, ';
  strSQL := strSQL + ' 0 AS FIS_BASIC3, ';
  strSQL := strSQL + ' 0 AS FIS_BASIC4, ';
  strSQL := strSQL + ' 0 AS FIS_BASIC5, ';
  strSQL := strSQL + ' IFNULL(FIS_ALQIC1, 0) AS FIS_ALQIC1, ';
  strSQL := strSQL + ' 0 AS FIS_ALQIC2, ';
  strSQL := strSQL + ' 0 AS FIS_ALQIC3, ';
  strSQL := strSQL + ' 0 AS FIS_ALQIC4, ';
  strSQL := strSQL + ' 0 AS FIS_ALQIC5, ';
  strSQL := strSQL + ' IFNULL(VLRICM, 0) AS FIS_VLRIC1, ';
  strSQL := strSQL + ' 0 AS FIS_VLRIC2, ';
  strSQL := strSQL + ' 0 AS FIS_VLRIC3, ';
  strSQL := strSQL + ' 0 AS FIS_VLRIC4, ';
  strSQL := strSQL + ' 0 AS FIS_VLRIC5, ';
  strSQL := strSQL + ' IFNULL(BASICM, 0) AS FIS_BASIP1, ';
  strSQL := strSQL + ' 0 AS FIS_BASIP2, ';
  strSQL := strSQL + ' 0 AS FIS_BASIP3, ';
  strSQL := strSQL + ' 0 AS FIS_BASIP4, ';
  strSQL := strSQL + ' 0 AS FIS_BASIP5, ';
  strSQL := strSQL + ' IFNULL(VLRIPI, 0) AS FIS_VLRIP1, ';
  strSQL := strSQL + ' 0 AS FIS_VLRIP2, ';
  strSQL := strSQL + ' 0 AS FIS_VLRIP3, ';
  strSQL := strSQL + ' 0 AS FIS_VLRIP4, ';
  strSQL := strSQL + ' 0 AS FIS_VLRIP5, ';
  strSQL := strSQL + ' IF(GER_CONPAG = "01000", "0", "1") AS FIS_COND_PG, ';
  strSQL := strSQL + ' GER_TIPFRE AS GER_TIPO_FRETE, ';
  strSQL := strSQL + ' GER_TOTFRE, ';
  strSQL := strSQL + ' GER_DESESP, ';
  strSQL := strSQL + ' DET_CODITE, ';
  strSQL := strSQL + ' DET_DESCRI, ';
  strSQL := strSQL + ' DET_UNIDAD, ';
  strSQL := strSQL + ' DET_QTDITE, ';
  strSQL := strSQL + ' VLRCON AS DET_VLRCON, ';
  strSQL := strSQL + ' DET_TOTITE, ';
  strSQL := strSQL + ' DET_TOTFRE, ';
  strSQL := strSQL + ' DET_UNITAR, ';
  strSQL := strSQL + ' CLAFSC AS DET_CLAFIS, ';
  strSQL := strSQL + ' DET_DESESP, ';
  strSQL := strSQL + ' DET_PERRED, ';
  strSQL := strSQL + ' DET_CODFIS, ';
  strSQL := strSQL + ' BASICM AS DET_BASICM, ';
  strSQL := strSQL + ' DET_ALQICM, ';
  strSQL := strSQL + ' VLRICM AS DET_VALICM, ';
  strSQL := strSQL + ' DET_BASIPI, ';
  strSQL := strSQL + ' DET_ALQIPI, ';
  strSQL := strSQL + ' VLRIPI AS DET_VALIPI, ';
  strSQL := strSQL + ' BASRET AS DET_BASRET, ';
  strSQL := strSQL + ' RETIDO AS DET_VALRET, ';
  strSQL := strSQL + ' DET_DESACE, ';
  strSQL := strSQL + ' 0  AS DET_VFCPST, ';
  strSQL := strSQL + ' 0  AS DET_OUTICM, ';
  strSQL := strSQL + ' 0  AS DET_ISEICM, ';
  strSQL := strSQL + ' "" AS DET_NR_PIS, ';
  strSQL := strSQL + ' "" AS DET_NR_COF, ';
  strSQL := strSQL + ' 0  AS DET_VAERET, ';
  strSQL := strSQL + ' 0  AS DET_VAEIPI, ';
  strSQL := strSQL + ' "" AS DET_CSTIPI, ';
  strSQL := strSQL + ' "" AS DET_CSTPIS, ';
  strSQL := strSQL + ' 0  AS DET_BASPIS, ';
  strSQL := strSQL + ' 0  AS DET_ALQPIS, ';
  strSQL := strSQL + ' 0  AS DET_VALPIS, ';
  strSQL := strSQL + ' "" AS DET_CSTCOF, ';
  strSQL := strSQL + ' 0  AS DET_BASCOF, ';
  strSQL := strSQL + ' 0  AS DET_ALQCOF, ';
  strSQL := strSQL + ' 0  AS DET_VALCOF, ';
  strSQL := strSQL + ' 0  AS ICD_BCUFDE, ';
  strSQL := strSQL + ' 0  AS ICD_PERFCP, ';
  strSQL := strSQL + ' 0  AS ICD_ALQUFD, ';
  strSQL := strSQL + ' 0  AS ICD_ALQINE, ';
  strSQL := strSQL + ' 0  AS ICD_PERPAR, ';
  strSQL := strSQL + ' 0  AS ICD_VALFCP, ';
  strSQL := strSQL + ' 0  AS ICD_VALDES, ';
  strSQL := strSQL + ' 0  AS ICD_VALORI, ';
  strSQL := strSQL + ' "" AS UNI_SIGUNI, ';
  strSQL := strSQL + ' "" AS ITE_CLAIPI, ';
  strSQL := strSQL + ' "" AS ITE_CDCEST, ';
  strSQL := strSQL + ' "" AS TRA_C_G_C_, ';
  strSQL := strSQL + ' "" AS TRA_I_E_S_, ';
  strSQL := strSQL + ' "" AS TRA_NUMPLA, ';
  strSQL := strSQL + ' "" AS TRA_UF, ';
  strSQL := strSQL + ' IF( ';
  strSQL := strSQL + '   FIS_TIP_FC = "C", ';
  strSQL := strSQL + '   CLI_C_E_P_, ';
  strSQL := strSQL + '   FOR_C_E_P_ ';
  strSQL := strSQL + ' ) AS CEP, ';
  strSQL := strSQL + ' IF( ';
  strSQL := strSQL + '   FIS_TIP_FC = "C", ';
  strSQL := strSQL + '   CLI_C_G_C_, ';
  strSQL := strSQL + '   FOR_C_G_C_ ';
  strSQL := strSQL + ' ) AS CNPJ, ';
  strSQL := strSQL + ' IF( ';
  strSQL := strSQL + '   FIS_TIP_FC = "C", ';
  strSQL := strSQL + '   CLI_NOMCLI, ';
  strSQL := strSQL + '   FOR_NOMFOR ';
  strSQL := strSQL + ' ) AS NOME, ';
  strSQL := strSQL + ' IF( ';
  strSQL := strSQL + '   FIS_TIP_FC = "C", ';
  strSQL := strSQL + '   CLI_BAIRRO, ';
  strSQL := strSQL + '   FOR_BAIRRO ';
  strSQL := strSQL + ' ) AS BAIRRO, ';
  strSQL := strSQL + ' IF( ';
  strSQL := strSQL + '   FIS_TIP_FC = "C", ';
  strSQL := strSQL + '   CLI_ENDERE, ';
  strSQL := strSQL + '   FOR_ENDERE ';
  strSQL := strSQL + ' ) AS ENDERECO, ';
  strSQL := strSQL + ' IF( ';
  strSQL := strSQL + '   FIS_TIP_FC = "C", ';
  strSQL := strSQL + '   CLI_FONE01, ';
  strSQL := strSQL + '   FOR_FONE01 ';
  strSQL := strSQL + ' ) AS TELEFONE, ';

  strSQL := strSQL + ' UF, ';
  strSQL := strSQL + ' MUNICIPIO, ';
  strSQL := strSQL + ' CODIGO_IBGE, ';
  strSQL := strSQL + ' OUTRAS AS FIS_OUTRAS, ';
  strSQL := strSQL + ' VLRCON AS FIS_VLRCON ';


  strSQL := strSQL + '  FROM (';

  strSQL := strSQL + fGetSqlUnion(strEmpresa);

  strSQL := strSQL + ' ) AS TAB ';

//  If Not chkInc933.Checked Then
    strSQL := strSQL + ' WHERE LOCATE(RIGHT(CLAFSC, 3), "933") <= 0 ';

  strSQL := strSQL + '  GROUP BY ';

  strSQL := strSQL + '    CLAFSC ';

  strSQL := strSQL + '  ORDER BY ';

  strSQL := strSQL + '    CLAFSC ';

  Result := strSQL;
end;

function TRepositorioNotasFiscais.fRetSqlTodasNotasFiscaisPorPeriodoDief(
  strDtaIni, strDtaFin, strEmpresa: String): string;
  var
    strSQL: string;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT       ';
  strSQL := strSQL + ' IFNULL(FIS_ACESSO, "") AS FIS_ACESSO, ';
  strSQL := strSQL + ' IFNULL(FIS_HISTOR, "") AS FIS_HISTOR, ';
  strSQL := strSQL + ' ESTADO AS FIS_ESTADO, ';
  strSQL := strSQL + ' FIS_NUMDOC, ';
  strSQL := strSQL + ' FIS_CODEMP, ';
  strSQL := strSQL + ' FIS_SERIE_, ';
  strSQL := strSQL + ' FIS_ESPDOC, ';
  strSQL := strSQL + ' FIS_FORCLI, ';
  strSQL := strSQL + ' FIS_TIP_FC, ';
  strSQL := strSQL + ' FIS_DTAENT, ';
  strSQL := strSQL + ' FIS_DTADOC, ';
  strSQL := strSQL + ' FIS_NFCOMP, ';
  strSQL := strSQL + ' IF( ';
  strSQL := strSQL + '   (FIS_ESPDOC = "NF") ';
  strSQL := strSQL + '   AND (IFNULL(FIS_ACESSO, "") = ""), ';
  strSQL := strSQL + '   "01", ';
  strSQL := strSQL + '   IF( ';
  strSQL := strSQL + '     ( ';
  strSQL := strSQL + '       (FIS_ESPDOC IN ("NF", "NV")) ';
  strSQL := strSQL + '       AND (IFNULL(FIS_ACESSO, "") <> "") ';
  strSQL := strSQL + '     ) ';
  strSQL := strSQL + '     OR (FIS_ESPDOC = "EL"), ';
  strSQL := strSQL + '     "55", ';
  strSQL := strSQL + '     IF( ';
  strSQL := strSQL + '       FIS_ESPDOC IN ("IF", "IV"), ';
  strSQL := strSQL + '       IF( ';
  strSQL := strSQL + '         ( ';
  strSQL := strSQL + '           (IFNULL(FIS_ACESSO, "") = "") ';
  strSQL := strSQL + '           AND ( ';
  strSQL := strSQL + '             IFNULL(FIS_HISTOR, "") NOT LIKE "%INUTILI%" ';
  strSQL := strSQL + '           ) ';
  strSQL := strSQL + '         ), ';
  strSQL := strSQL + '         "2D", ';
  strSQL := strSQL + '         "65" ';
  strSQL := strSQL + '       ), ';
  strSQL := strSQL + '       "01" ';
  strSQL := strSQL + '     ) ';
  strSQL := strSQL + '   ) ';
  strSQL := strSQL + ' ) AS FIS_DOCMOD, ';
  strSQL := strSQL + ' IF( ';
  strSQL := strSQL + '   IFNULL(FIS_HISTOR, "") = "CANCELADO", ';
  strSQL := strSQL + '   "02", ';
  strSQL := strSQL + '   "00" ';
  strSQL := strSQL + ' ) AS FIS_SITDOC, ';
  strSQL := strSQL + ' IFNULL(CLAFSC, "") AS FIS_CLFSC1, ';
  strSQL := strSQL + ' IFNULL(CLAFSC, "") AS FIS_CLFSC2, ';
  strSQL := strSQL + ' IFNULL(CLAFSC, "") AS FIS_CLFSC3, ';
  strSQL := strSQL + ' IFNULL(CLAFSC, "") AS FIS_CLFSC4, ';
  strSQL := strSQL + ' IFNULL(CLAFSC, "") AS FIS_CLFSC5, ';
  strSQL := strSQL + ' IFNULL(VLRCON, 0) AS FIS_VLCON1, ';
  strSQL := strSQL + ' 0 AS FIS_VLCON2, ';
  strSQL := strSQL + ' 0 AS FIS_VLCON3, ';
  strSQL := strSQL + ' 0 AS FIS_VLCON4, ';
  strSQL := strSQL + ' 0 AS FIS_VLCON5, ';
  strSQL := strSQL + ' IFNULL(OUTRAS, 0) AS FIS_OUTRA1, ';
  strSQL := strSQL + ' 0 AS FIS_OUTRA2, ';
  strSQL := strSQL + ' 0 AS FIS_OUTRA3, ';
  strSQL := strSQL + ' 0 AS FIS_OUTRA4, ';
  strSQL := strSQL + ' 0 AS FIS_OUTRA5, ';
  strSQL := strSQL + ' IFNULL(BASRET, 0) AS FIS_BCRET1, ';
  strSQL := strSQL + ' 0 AS FIS_BCRET2, ';
  strSQL := strSQL + ' 0 AS FIS_BCRET3, ';
  strSQL := strSQL + ' 0 AS FIS_BCRET4, ';
  strSQL := strSQL + ' 0 AS FIS_BCRET5, ';
  strSQL := strSQL + ' IFNULL(RETIDO, 0) AS FIS_RETID1, ';
  strSQL := strSQL + ' 0 AS FIS_RETID2, ';
  strSQL := strSQL + ' 0 AS FIS_RETID3, ';
  strSQL := strSQL + ' 0 AS FIS_RETID4, ';
  strSQL := strSQL + ' 0 AS FIS_RETID5, ';
  strSQL := strSQL + ' IFNULL(ISENTA, 0) AS FIS_ISENT1, ';
  strSQL := strSQL + ' 0 AS FIS_ISENT2, ';
  strSQL := strSQL + ' 0 AS FIS_ISENT3, ';
  strSQL := strSQL + ' 0 AS FIS_ISENT4, ';
  strSQL := strSQL + ' 0 AS FIS_ISENT5, ';
  strSQL := strSQL + ' IFNULL(BASICM, 0) AS FIS_BASIC1, ';
  strSQL := strSQL + ' 0 AS FIS_BASIC2, ';
  strSQL := strSQL + ' 0 AS FIS_BASIC3, ';
  strSQL := strSQL + ' 0 AS FIS_BASIC4, ';
  strSQL := strSQL + ' 0 AS FIS_BASIC5, ';
  strSQL := strSQL + ' IFNULL(FIS_ALQIC1, 0) AS FIS_ALQIC1, ';
  strSQL := strSQL + ' 0 AS FIS_ALQIC2, ';
  strSQL := strSQL + ' 0 AS FIS_ALQIC3, ';
  strSQL := strSQL + ' 0 AS FIS_ALQIC4, ';
  strSQL := strSQL + ' 0 AS FIS_ALQIC5, ';
  strSQL := strSQL + ' IFNULL(VLRICM, 0) AS FIS_VLRIC1, ';
  strSQL := strSQL + ' 0 AS FIS_VLRIC2, ';
  strSQL := strSQL + ' 0 AS FIS_VLRIC3, ';
  strSQL := strSQL + ' 0 AS FIS_VLRIC4, ';
  strSQL := strSQL + ' 0 AS FIS_VLRIC5, ';
  strSQL := strSQL + ' IFNULL(BASICM, 0) AS FIS_BASIP1, ';
  strSQL := strSQL + ' 0 AS FIS_BASIP2, ';
  strSQL := strSQL + ' 0 AS FIS_BASIP3, ';
  strSQL := strSQL + ' 0 AS FIS_BASIP4, ';
  strSQL := strSQL + ' 0 AS FIS_BASIP5, ';
  strSQL := strSQL + ' IFNULL(VLRIPI, 0) AS FIS_VLRIP1, ';
  strSQL := strSQL + ' 0 AS FIS_VLRIP2, ';
  strSQL := strSQL + ' 0 AS FIS_VLRIP3, ';
  strSQL := strSQL + ' 0 AS FIS_VLRIP4, ';
  strSQL := strSQL + ' 0 AS FIS_VLRIP5, ';
  strSQL := strSQL + ' IF(GER_CONPAG = "01000", "0", "1") AS FIS_COND_PG, ';
  strSQL := strSQL + ' GER_TIPFRE AS GER_TIPO_FRETE, ';
  strSQL := strSQL + ' GER_TOTFRE, ';
  strSQL := strSQL + ' GER_DESESP, ';
  strSQL := strSQL + ' DET_CODITE, ';
  strSQL := strSQL + ' DET_DESCRI, ';
  strSQL := strSQL + ' DET_UNIDAD, ';
  strSQL := strSQL + ' DET_QTDITE, ';
  strSQL := strSQL + ' VLRCON AS DET_VLRCON, ';
  strSQL := strSQL + ' DET_TOTITE, ';
  strSQL := strSQL + ' DET_TOTFRE, ';
  strSQL := strSQL + ' DET_UNITAR, ';
  strSQL := strSQL + ' CLAFSC AS DET_CLAFIS, ';
  strSQL := strSQL + ' DET_DESESP, ';
  strSQL := strSQL + ' DET_PERRED, ';
  strSQL := strSQL + ' CODFIS AS DET_CODFIS, ';
  strSQL := strSQL + ' BASICM AS DET_BASICM, ';
  strSQL := strSQL + ' DET_ALQICM, ';
  strSQL := strSQL + ' VLRICM AS DET_VALICM, ';
  strSQL := strSQL + ' DET_BASIPI, ';
  strSQL := strSQL + ' DET_ALQIPI, ';
  strSQL := strSQL + ' VLRIPI AS DET_VALIPI, ';
  strSQL := strSQL + ' BASRET AS DET_BASRET, ';
  strSQL := strSQL + ' RETIDO AS DET_VALRET, ';
  strSQL := strSQL + ' VAERET AS DET_VAERET, ';
  strSQL := strSQL + ' VAEIPI AS DET_VAEIPI, ';
  strSQL := strSQL + ' DET_DESACE, ';
  strSQL := strSQL + ' 0  AS DET_VFCPST, ';
  strSQL := strSQL + ' 0  AS DET_OUTICM, ';
  strSQL := strSQL + ' 0  AS DET_ISEICM, ';
  strSQL := strSQL + ' "" AS DET_NR_PIS, ';
  strSQL := strSQL + ' "" AS DET_NR_COF, ';
  strSQL := strSQL + ' "" AS DET_CSTIPI, ';
  strSQL := strSQL + ' "" AS DET_CSTPIS, ';
  strSQL := strSQL + ' 0  AS DET_BASPIS, ';
  strSQL := strSQL + ' 0  AS DET_ALQPIS, ';
  strSQL := strSQL + ' 0  AS DET_VALPIS, ';
  strSQL := strSQL + ' "" AS DET_CSTCOF, ';
  strSQL := strSQL + ' 0  AS DET_BASCOF, ';
  strSQL := strSQL + ' 0  AS DET_ALQCOF, ';
  strSQL := strSQL + ' 0  AS DET_VALCOF, ';
  strSQL := strSQL + ' 0  AS ICD_BCUFDE, ';
  strSQL := strSQL + ' 0  AS ICD_PERFCP, ';
  strSQL := strSQL + ' 0  AS ICD_ALQUFD, ';
  strSQL := strSQL + ' 0  AS ICD_ALQINE, ';
  strSQL := strSQL + ' 0  AS ICD_PERPAR, ';
  strSQL := strSQL + ' 0  AS ICD_VALFCP, ';
  strSQL := strSQL + ' 0  AS ICD_VALDES, ';
  strSQL := strSQL + ' 0  AS ICD_VALORI, ';
  strSQL := strSQL + ' "" AS UNI_SIGUNI, ';
  strSQL := strSQL + ' "" AS ITE_CLAIPI, ';
  strSQL := strSQL + ' "" AS ITE_CDCEST, ';
  strSQL := strSQL + ' "" AS TRA_C_G_C_, ';
  strSQL := strSQL + ' "" AS TRA_I_E_S_, ';
  strSQL := strSQL + ' "" AS TRA_NUMPLA, ';
  strSQL := strSQL + ' "" AS TRA_UF, ';
  strSQL := strSQL + ' IF( ';
  strSQL := strSQL + '   FIS_TIP_FC = "C", ';
  strSQL := strSQL + '   CLI_C_E_P_, ';
  strSQL := strSQL + '   FOR_C_E_P_ ';
  strSQL := strSQL + ' ) AS CEP, ';
  (*strSQL := strSQL + ' IF( ';
  strSQL := strSQL + '   FIS_TIP_FC = "C", ';
  strSQL := strSQL + '   CLI_C_G_C_, ';
  strSQL := strSQL + '   FOR_C_G_C_ ';
  strSQL := strSQL + ' ) AS CNPJ, ';*)
  strSQL := strSQL + ' IFNULL(CGCCON, IF( ';
  strSQL := strSQL + '   FIS_TIP_FC = "C", ';
  strSQL := strSQL + '   CLI_C_G_C_, ';
  strSQL := strSQL + '   FOR_C_G_C_ ';
  strSQL := strSQL + ' )) AS CNPJ, ';
  strSQL := strSQL + ' IF( ';
  strSQL := strSQL + '   FIS_TIP_FC = "C", ';
  strSQL := strSQL + '   CLI_NOMCLI, ';
  strSQL := strSQL + '   FOR_NOMFOR ';
  strSQL := strSQL + ' ) AS NOME, ';
  strSQL := strSQL + ' IF( ';
  strSQL := strSQL + '   FIS_TIP_FC = "C", ';
  strSQL := strSQL + '   CLI_BAIRRO, ';
  strSQL := strSQL + '   FOR_BAIRRO ';
  strSQL := strSQL + ' ) AS BAIRRO, ';
  strSQL := strSQL + ' IF( ';
  strSQL := strSQL + '   FIS_TIP_FC = "C", ';
  strSQL := strSQL + '   CLI_ENDERE, ';
  strSQL := strSQL + '   FOR_ENDERE ';
  strSQL := strSQL + ' ) AS ENDERECO, ';
  strSQL := strSQL + ' IF( ';
  strSQL := strSQL + '   FIS_TIP_FC = "C", ';
  strSQL := strSQL + '   CLI_FONE01, ';
  strSQL := strSQL + '   FOR_FONE01 ';
  strSQL := strSQL + ' ) AS TELEFONE, ';

  strSQL := strSQL + ' UF, ';
  strSQL := strSQL + ' MUNICIPIO, ';
  strSQL := strSQL + ' CODIGO_IBGE, ';
  strSQL := strSQL + ' OUTRAS AS FIS_OUTRAS, ';
  strSQL := strSQL + ' VLRCON AS FIS_VLRCON ';

  strSQL := strSQL + '  FROM (';

  strSQL := strSQL + fGetSqlUnionDief(strEmpresa);

  strSQL := strSQL + ' ) AS TAB ';

  strSQL := strSQL + ' WHERE ((IFNULL(FIS_HISTOR, "") NOT LIKE "%CANCELAD%") ';
  strSQL := strSQL + '   AND  (IFNULL(FIS_HISTOR, "") NOT LIKE "%DENEGAD%") ';
  strSQL := strSQL + '   AND  (IFNULL(FIS_HISTOR, "") NOT LIKE "%INUTILIZAD%")) ';
  strSQL := strSQL + '   AND FIS_ESPDOC IN ("NF", "IF", "CT") ';

  if FExcluirCFOPServico then
    strSQL := strSQL + ' AND LOCATE(RIGHT(CLAFSC, 3), "933") <= 0 ';

  strSQL := strSQL + '   AND LOCATE(RIGHT(CLAFSC, 3), "929") <= 0 ';
  strSQL := strSQL + '  ORDER BY CLAFSC ';

  Result := strSQL;
end;
{
function TRepositorioNotasFiscais.fRetSqlTodasNotasFiscaisSpedPorPeriodo: string;
begin
  Result := '';

  Result := Result + 'FROM ';
  Result := Result + '  CADFIS FIS ';

  Result := Result + '  LEFT JOIN EXTFIS ';
  Result := Result + '   ON FIS_SEQGER = FIS.AUTOINCREM ';

  Result := Result + '  LEFT JOIN MOVGER GER ';
  Result := Result + '   ON GER.GER_CODEMP = FIS.FIS_CODEMP ';
  Result := Result + '   AND GER.GER_ESPDOC = FIS.FIS_ESPDOC ';
  Result := Result + '   AND GER.GER_TIP_FC = FIS.FIS_TIP_FC ';
  Result := Result + '   AND GER.GER_NUMDOC = FIS.FIS_NUMDOC ';
  Result := Result + '   AND IFNULL(GER.GER_SERIE_,"") = IFNULL(FIS.FIS_SERIE_,"") ';
  Result := Result + '   AND IF(GER.GER_TIP_FC = "C", GER.GER_CODCLI = FIS.FIS_FORCLI, ';
  Result := Result + '                                GER.GER_CODFOR = FIS.FIS_FORCLI) ';

  Result := Result + '  LEFT JOIN MOVDET DET ';
  Result := Result + '   ON DET.DET_CODEMP = FIS.FIS_CODEMP ';
  Result := Result + '   AND DET.DET_ESPDOC = FIS.FIS_ESPDOC ';
  Result := Result + '   AND DET.DET_TIP_FC = FIS.FIS_TIP_FC ';
  Result := Result + '   AND DET.DET_NUMDOC = FIS.FIS_NUMDOC ';
  Result := Result + '   AND IFNULL(DET.DET_SERIE_,"") = IFNULL(FIS.FIS_SERIE_,"") ';
  Result := Result + '   AND IF(DET.DET_TIP_FC = "C", DET.DET_CODCLI = FIS.FIS_FORCLI, ';
  Result := Result + '                                DET.DET_CODFOR = FIS.FIS_FORCLI) ';

  Result := Result + '  LEFT JOIN MOVTRI TRI ';
  Result := Result + '   ON TRI.DET_SEQGER = DET.AUTOINCREM ';

  Result := Result + '  LEFT JOIN CADCLI CLI ';
  Result := Result + '   ON FIS.FIS_TIP_FC = "C" ';
  Result := Result + '   AND CLI.CLI_CODCLI = FIS.FIS_FORCLI ';

  Result := Result + '  LEFT JOIN CADFOR FORN ';
  Result := Result + '   ON FIS.FIS_TIP_FC = "F" ';
  Result := Result + '   AND FORN.FOR_CODFOR = FIS.FIS_FORCLI ';

  Result := Result + '  LEFT JOIN CADITE ';
  Result := Result + '   ON ITE_CODITE = DET.DET_CODITE ';

  Result := Result + '  LEFT JOIN NOTCOM NOC ';
  Result := Result + '   ON NOC.GER_SEQGER = FIS.AUTOINCREM ';

  Result := Result + '  INNER JOIN CADEMP EMP';
  Result := Result + '   ON EMP.EMP_CODEMP = FIS.FIS_CODEMP ';

  Result := Result + '  LEFT JOIN CADCID CID';
  Result := Result + '   ON CID.CID_CODCID = EMP_CODCID ';

  Result := Result + '  LEFT JOIN CADCID CIDPAR ';
  Result := Result + '   ON CIDPAR.CID_CODCID = IFNULL(CLI_CODCID, FOR_CODCID) ';

//  if fTabelaExiste('MOVICD' + FSufixoTabelaMovIcd) and
 //    fTabelaExiste('NOTICD' + FSufixoTabelaMovIcd) then
//    Result := Result +  '  LEFT JOIN MOVICD' + FSufixoTabelaMovIcd + ' ON ICD_SEQGER = DET.AUTOINCREM ';

  Result := Result + 'WHERE FIS.FIS_DTAENT BETWEEN :DTAINI AND :DTAFIM ) ';
  Result := Result + '  AND (NOT (IFNULL(FIS_HISTOR, "") LIKE "%AGUA%" OR IFNULL(FIS_HISTOR, "") LIKE "ESGOTO")) ';
  Result := Result + '  AND (NOT (IFNULL(FIS_HISTOR, "") LIKE "%CANCEL%" AND FIS_ORIDOC <> "V")) ';
  Result := Result + '  AND (LOCATE(FIS_ESPDOC, :ESPDOC) > 0  OR (FIS_ESPDOC IN ("IF", "IV") AND IFNULL(FIS_ACESSO,"") <> "" AND IFNULL(FIS_NUMSER,"") = "")) ';
  Result := Result + '  AND (FIS_CODEMP = :CODEMP ) ';
  Result := Result + '  AND ((IFNULL(FIS_NFCOMP, "") <> "S")) ';
  Result := Result + '  AND (IFNULL(GER_NUMDOC,"") <> "") ';

//  if rbEntradas.Checked then
    Result := Result + '  AND FIS_ENTSAI = "E" ';

//  if rbEntradasCupons.Checked then
    Result := Result + ' AND ( (FIS_ENTSAI = "E") OR (FIS_ESPDOC IN ("IF", "IV")) ) ';

//   if not chkEntrarNotasMunicipaisServico.Checked then
//     Result := Result + ' AND ( LOCATE(FIS_CLFSC1, "' + strCfopServico + '") = 0 ) ';

//  Result := Result + ' AND (LOCATE(FIS_CLFSC1, "' + strCfopsCompraEnergia + '") = 0 ) ';

//  Result := Result + ' AND (LOCATE(FIS_CLFSC1, "' + strCfopsCompraComunica + '") = 0 ) ';

//  Result := Result + ' AND (LOCATE(RIGHT(FIS_CLFSC1, 3), ' + strCfopsNotasTransporte + ') = 0) ';
end;
 }
function TRepositorioNotasFiscais.fRetSqlTodasNotasFiscaisVendasAtivoImobilizadoPorPeriodo: String;
  Var
    strSQL: string;
begin
  strSQL := '';

  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  IFNULL(FIS_ACESSO, "") AS FIS_ACESSO, ';
  strSQL := strSQL + '  IFNULL(FIS_HISTOR, "") AS FIS_HISTOR, ';
  strSQL := strSQL + '  FIS_ESTADO, ';
  strSQL := strSQL + '  FIS_NUMDOC, ';
  strSQL := strSQL + '  FIS_CODEMP, ';
  strSQL := strSQL + '  FIS_SERIE_, ';
  strSQL := strSQL + '  FIS_ESPDOC, ';
  strSQL := strSQL + '  FIS_FORCLI, ';
  strSQL := strSQL + '  FIS_TIP_FC, ';
  strSQL := strSQL + '  FIS_DTAENT, ';
  strSQL := strSQL + '  FIS_DTADOC, ';

  strSQL := strSQL + '  IFNULL(FIS_CLFSC1, "") AS FIS_CLFSC1, ';
  strSQL := strSQL + '  IFNULL(FIS_CLFSC2, "") AS FIS_CLFSC2, ';
  strSQL := strSQL + '  IFNULL(FIS_CLFSC3, "") AS FIS_CLFSC3, ';
  strSQL := strSQL + '  IFNULL(FIS_CLFSC4, "") AS FIS_CLFSC4, ';
  strSQL := strSQL + '  IFNULL(FIS_CLFSC5, "") AS FIS_CLFSC5, ';

  strSQL := strSQL + '  IFNULL(FIS_VLCON1, 0) AS FIS_VLCON1, ';
  strSQL := strSQL + '  IFNULL(FIS_VLCON2, 0) AS FIS_VLCON2, ';
  strSQL := strSQL + '  IFNULL(FIS_VLCON3, 0) AS FIS_VLCON3, ';
  strSQL := strSQL + '  IFNULL(FIS_VLCON4, 0) AS FIS_VLCON4, ';
  strSQL := strSQL + '  IFNULL(FIS_VLCON5, 0) AS FIS_VLCON5, ';

  strSQL := strSQL + '  IFNULL(FIS_OUTRA1, 0) AS FIS_OUTRA1, ';
  strSQL := strSQL + '  IFNULL(FIS_OUTRA2, 0) AS FIS_OUTRA2, ';
  strSQL := strSQL + '  IFNULL(FIS_OUTRA3, 0) AS FIS_OUTRA3, ';
  strSQL := strSQL + '  IFNULL(FIS_OUTRA4, 0) AS FIS_OUTRA4, ';
  strSQL := strSQL + '  IFNULL(FIS_OUTRA5, 0) AS FIS_OUTRA5, ';

  strSQL := strSQL + '  IFNULL(FIS_ISENT1, 0) AS FIS_ISENT1, ';
  strSQL := strSQL + '  IFNULL(FIS_ISENT2, 0) AS FIS_ISENT2, ';
  strSQL := strSQL + '  IFNULL(FIS_ISENT3, 0) AS FIS_ISENT3, ';
  strSQL := strSQL + '  IFNULL(FIS_ISENT4, 0) AS FIS_ISENT4, ';
  strSQL := strSQL + '  IFNULL(FIS_ISENT5, 0) AS FIS_ISENT5, ';

  strSQL := strSQL + '  IFNULL(FIS_BASIC1, 0) AS FIS_BASIC1, ';
  strSQL := strSQL + '  IFNULL(FIS_BASIC2, 0) AS FIS_BASIC2, ';
  strSQL := strSQL + '  IFNULL(FIS_BASIC3, 0) AS FIS_BASIC3, ';
  strSQL := strSQL + '  IFNULL(FIS_BASIC4, 0) AS FIS_BASIC4, ';
  strSQL := strSQL + '  IFNULL(FIS_BASIC5, 0) AS FIS_BASIC5, ';

  strSQL := strSQL + '  IFNULL(FIS_ALQIC1, 0) AS FIS_ALQIC1, ';
  strSQL := strSQL + '  IFNULL(FIS_ALQIC2, 0) AS FIS_ALQIC2, ';
  strSQL := strSQL + '  IFNULL(FIS_ALQIC3, 0) AS FIS_ALQIC3, ';
  strSQL := strSQL + '  IFNULL(FIS_ALQIC4, 0) AS FIS_ALQIC4, ';
  strSQL := strSQL + '  IFNULL(FIS_ALQIC5, 0) AS FIS_ALQIC5, ';

  strSQL := strSQL + '  IFNULL(FIS_VLRIC1, 0) AS FIS_VLRIC1, ';
  strSQL := strSQL + '  IFNULL(FIS_VLRIC2, 0) AS FIS_VLRIC2, ';
  strSQL := strSQL + '  IFNULL(FIS_VLRIC3, 0) AS FIS_VLRIC3, ';
  strSQL := strSQL + '  IFNULL(FIS_VLRIC4, 0) AS FIS_VLRIC4, ';
  strSQL := strSQL + '  IFNULL(FIS_VLRIC5, 0) AS FIS_VLRIC5, ';

  strSQL := strSQL + '  GER_TOTFRE, ';
  strSQL := strSQL + '  GER_DESESP, ';
  strSQL := strSQL + '  DET_CODITE, ';
  strSQL := strSQL + '  DET_DESCRI, ';
  strSQL := strSQL + '  DET_UNIDAD, ';
  strSQL := strSQL + '  DET_QTDITE, ';
  strSQL := strSQL + '  DET_VLRCON, ';
  strSQL := strSQL + '  DET_TOTITE, ';
  strSQL := strSQL + '  DET_TOTFRE, ';
  strSQL := strSQL + '  DET_UNITAR, ';
  strSQL := strSQL + '  DET_CLAFIS, ';
  strSQL := strSQL + '  DET_VALIPI, ';
  strSQL := strSQL + '  DET_DESESP, ';
  strSQL := strSQL + '  DET_CODFIS, ';
  strSQL := strSQL + '  DET_BASICM, ';
  strSQL := strSQL + '  DET_ALQICM, ';
  strSQL := strSQL + '  DET_VALICM, ';
  strSQL := strSQL + '  T.DET_CSTIPI, ';
  strSQL := strSQL + '  DET_BASIPI, ';
  strSQL := strSQL + '  DET_ALQIPI, ';
  strSQL := strSQL + '  DET_VALIPI, ';
  strSQL := strSQL + '  DET_BASRET, ';
  strSQL := strSQL + '  DET_VALRET, ';
  strSQL := strSQL + '  DET_DESACE, ';
  strSQL := strSQL + '  T.DET_OUTICM, ';
  strSQL := strSQL + '  T.DET_CSTPIS, ';
  strSQL := strSQL + '  T.DET_BASPIS, ';
  strSQL := strSQL + '  T.DET_ALQPIS, ';
  strSQL := strSQL + '  T.DET_VALPIS, ';
  strSQL := strSQL + '  T.DET_CSTCOF, ';
  strSQL := strSQL + '  T.DET_BASCOF, ';
  strSQL := strSQL + '  T.DET_ALQCOF, ';
  strSQL := strSQL + '  T.DET_VALCOF, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CLI_C_E_P_, FOR_C_E_P_) AS CEP, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CLI_C_G_C_, FOR_C_G_C_) AS CNPJ, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CLI_NOMCLI, FOR_NOMFOR) AS NOME, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CLI_BAIRRO, FOR_BAIRRO) AS BAIRRO, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CLI_ENDERE, FOR_ENDERE) AS ENDERECO, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CLI_FONE01, FOR_FONE01) AS TELEFONE, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CC.CID_ESTADO, CF.CID_ESTADO) AS UF, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CC.CID_NOMCID, CF.CID_NOMCID) AS MUNICIPIO, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CC.CID_COIBGE, CF.CID_COIBGE) AS CODIGO_IBGE, ';
  strSQL := strSQL + '  IFNULL(FIS_OUTRA1, 0) + IFNULL(FIS_OUTRA2, 0) + IFNULL(FIS_OUTRA3, 0) + IFNULL(FIS_OUTRA4, 0) + IFNULL(FIS_OUTRA5, 0) AS FIS_OUTRAS, ';
  strSQL := strSQL + '  IFNULL(FIS_VLCON1, 0) + IFNULL(FIS_VLCON2, 0) + IFNULL(FIS_VLCON3, 0) + IFNULL(FIS_VLCON4, 0) + IFNULL(FIS_VLCON5, 0) AS FIS_VLRCON ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADFIS ';

  strSQL := strSQL + '	LEFT JOIN MOVGER G ';
  strSQL := strSQL + '   ON G.GER_NUMDOC = FIS_NUMDOC ';
  strSQL := strSQL + '   AND G.GER_ESPDOC = FIS_ESPDOC ';
  strSQL := strSQL + '   AND G.GER_CODEMP = FIS_CODEMP ';
  strSQL := strSQL + '   AND IFNULL(G.GER_SERIE_, "") = IFNULL(FIS_SERIE_, "") ';
  strSQL := strSQL + '   AND G.GER_TIP_FC = FIS_TIP_FC ';
  strSQL := strSQL + '   AND IF(G.GER_TIP_FC = "C", G.GER_CODCLI, G.GER_CODFOR) = FIS_FORCLI ';

  strSQL := strSQL + '  LEFT JOIN MOVDET D ';
  strSQL := strSQL + '   ON D.DET_NUMDOC = G.GER_NUMDOC ';
  strSQL := strSQL + '   AND D.DET_ESPDOC = G.GER_ESPDOC ';
  strSQL := strSQL + '   AND D.DET_CODEMP = G.GER_CODEMP ';
  strSQL := strSQL + '   AND IFNULL(D.DET_SERIE_, "") = IFNULL(G.GER_SERIE_, "") ';
  strSQL := strSQL + '   AND D.DET_TIP_FC = G.GER_TIP_FC ';
  strSQL := strSQL + '   AND IF(FIS_TIP_FC = "C", D.DET_CODCLI, D.DET_CODFOR) = IF(G.GER_TIP_FC = "C", G.GER_CODCLI, G.GER_CODFOR) ';

  strSQL := strSQL + '  LEFT JOIN MOVTRI T ';
  strSQL := strSQL + '   ON T.DET_SEQGER = D.AUTOINCREM ';

  strSQL := strSQL + '  LEFT JOIN CADCLI ';
  strSQL := strSQL + '   ON CLI_CODCLI = IF(FIS_TIP_FC = "C", FIS_FORCLI, NULL) ';

  strSQL := strSQL + '  LEFT JOIN CADFOR ';
  strSQL := strSQL + '   ON FOR_CODFOR = IF(FIS_TIP_FC = "F", FIS_FORCLI, NULL) ';

  strSQL := strSQL + '  LEFT JOIN CADCID CC ';
  strSQL := strSQL + '   ON CC.CID_CODCID = CLI_CODCID ';

  strSQL := strSQL + '  LEFT JOIN CADCID CF ';
  strSQL := strSQL + '   ON CF.CID_CODCID = FOR_CODCID ';

  strSQL := strSQL + 'WHERE FIS_DTAENT BETWEEN :DTAINI ';
  strSQL := strSQL + '  AND :DTAFIN ';
  strSQL := strSQL + '  AND FIS_CODEMP = :CODEMP ';
  strSQL := strSQL + '  AND IFNULL(DET_PROEMB, "") <> "S" ';
  strSQL := strSQL + '  AND LOCATE(IFNULL(FIS_CLFSC1, ""), "5551_6551") > 0 ';

  Result := strSQL;
end;

function TRepositorioNotasFiscais.fRetSqlTodasNotasServicoSintetizadas(strTipoSintetizacao: String): String;
  Var
    strSQL: String;
begin
  strSQL := '';

  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '    IFNULL(FIS_CLFSC1, "") AS FIS_CLFSC1, ';
  strSQL := strSQL + '    CASE ';
  strSQL := strSQL + '      WHEN IFNULL(FIS_CLFSC1, "") = "1933" THEN "9201" ';
  strSQL := strSQL + '      WHEN IFNULL(FIS_CLFSC1, "") = "2933" THEN "9203" ELSE "" END FIS_CFPS__, ';
  strSQL := strSQL + '    IF(FIS_TIP_FC = "C",CLI_C_G_C_,FOR_C_G_C_) AS FIS_CNPJ__, ';
  strSQL := strSQL + '    IF(FIS_TIP_FC = "C",CC.CID_COIBGE,CF.CID_COIBGE) AS FIS_IBGE__, ';
  strSQL := strSQL + '    SUM(IFNULL(FIS_VLCON1, 0) + IFNULL(FIS_VLCON2, 0) + IFNULL(FIS_VLCON3, 0) + IFNULL(FIS_VLCON4, 0) + IFNULL(FIS_VLCON5, 0)) AS FIS_VLRCON, ';
  strSQL := strSQL + '    SUM(IFNULL(FIS_RETISS, 0)) AS FIS_RETISS ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADFIS ';

  strSQL := strSQL + '  LEFT JOIN MOVGER ';
  strSQL := strSQL + '   ON GER_NUMDOC = FIS_NUMDOC ';
  strSQL := strSQL + '   AND GER_ESPDOC = FIS_ESPDOC ';
  strSQL := strSQL + '   AND GER_CODEMP = FIS_CODEMP ';
  strSQL := strSQL + '   AND IFNULL(GER_SERIE_, "") = IFNULL(FIS_SERIE_, "") ';
  strSQL := strSQL + '   AND IF(FIS_TIP_FC = "C", GER_CODCLI, GER_CODFOR) = FIS_FORCLI ';

  strSQL := strSQL + '  LEFT JOIN CADCLI ';
  strSQL := strSQL + '   ON CLI_CODCLI = FIS_FORCLI ';

  strSQL := strSQL + '  LEFT JOIN CADFOR ';
  strSQL := strSQL + '   ON FOR_CODFOR = FIS_FORCLI ';

  strSQL := strSQL + '  LEFT JOIN CADEMP ';
  strSQL := strSQL + '   ON EMP_CODEMP = FIS_CODEMP ';

  strSQL := strSQL + '  LEFT JOIN CADCID CE ';
  strSQL := strSQL + '   ON CE.CID_CODCID = EMP_CODCID ';

  strSQL := strSQL + '  LEFT JOIN CADCID CC ';
  strSQL := strSQL + '   ON CC.CID_CODCID = CLI_CODCID ';

  strSQL := strSQL + '  LEFT JOIN CADCID CF ';
  strSQL := strSQL + '   ON CF.CID_CODCID = FOR_CODCID ';

  strSQL := strSQL + 'WHERE FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN ';
  strSQL := strSQL + '  AND FIS_CODEMP = :CODEMP ';
  strSQL := strSQL + '  AND ((FIS_CLFSC1 = "1933") OR (FIS_CLFSC1 = "2933")) ';
  strSQL := strSQL + '  AND (IFNULL(FIS_CLFSC2, "") = "")';

  If (strTipoSintetizacao = 'CFOP') Then
  begin
    strSQL := strSQL + 'GROUP BY FIS_CLFSC1 ';
    strSQL := strSQL + 'ORDER BY FIS_CLFSC1 ';
  end
  else If (strTipoSintetizacao = 'CNPJ') Then
  begin
    strSQL := strSQL + 'GROUP BY FIS_CNPJ__ ';
    strSQL := strSQL + 'ORDER BY FIS_CNPJ__ ';
  end
  else
  Begin
    strSQL := strSQL + 'GROUP BY FIS_IBGE__ ';
    strSQL := strSQL + 'ORDER BY FIS_IBGE__ ';
  end;

  Result := strSQL;
end;

function TRepositorioNotasFiscais.fRetSqlTodasNotasServicoTomadosPorPeriodo: String;
  Var
    strSQL: String;
begin
  strSQL := '';

  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  IFNULL(FIS_CLFSC1, "") AS FIS_CLFSC1, ';
  strSQL := strSQL + '  IFNULL(FIS_ACESSO, "") AS ACESSO, ';
  strSQL := strSQL + '  RIGHT(FIS_NUMDOC, 9) AS FIS_NUMDOC, ';
  strSQL := strSQL + '  FIS_CODEMP, ';
  strSQL := strSQL + '  FIS_SERIE_, ';
  strSQL := strSQL + '  FIS_ESPDOC, ';
  strSQL := strSQL + '  FIS_FORCLI, ';
  strSQL := strSQL + '  FIS_TIP_FC, ';
  strSQL := strSQL + '  FIS_DTAENT, ';
  strSQL := strSQL + '  FIS_DTADOC, ';
  strSQL := strSQL + '  GER_TOTFRE, ';
  strSQL := strSQL + '  GER_DESESP, ';
  strSQL := strSQL + '  CE.CID_ESTADO, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CLI_C_E_P_, FOR_C_E_P_) AS CEP, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CLI_C_G_C_, FOR_C_G_C_) AS CNPJ, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CLI_NOMCLI, FOR_NOMFOR) AS NOME, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CLI_BAIRRO, FOR_BAIRRO) AS BAIRRO, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CLI_ENDERE, FOR_ENDERE) AS ENDERECO, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CLI_FONE01, FOR_FONE01) AS TELEFONE, ';

  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CC.CID_ESTADO, CF.CID_ESTADO) AS UF, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CC.CID_NOMCID, CF.CID_NOMCID) AS MUNICIPIO, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CC.CID_COIBGE, CF.CID_COIBGE) AS CODIGO_IBGE, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", IFNULL(CC.CID_CODCID, "00000"), IFNULL(CF.CID_CODCID, "00000")) AS CID_CODCID, ';

  strSQL := strSQL + '  IFNULL(FIS_VLCON1, 0) + IFNULL(FIS_VLCON2, 0) + IFNULL(FIS_VLCON3, 0) + IFNULL(FIS_VLCON4, 0) + IFNULL(FIS_VLCON5, 0) AS FIS_VLRCON, ';
  strSQL := strSQL + '  IFNULL(FIS_OUTRA1, 0) + IFNULL(FIS_OUTRA2, 0) + IFNULL(FIS_OUTRA3, 0) + IFNULL(FIS_OUTRA4, 0) + IFNULL(FIS_OUTRA5, 0) AS FIS_OUTRAS, ';
  strSQL := strSQL + '  IFNULL(FIS_BASISS, 0) AS FIS_BASISS, ';
  strSQL := strSQL + '  IFNULL(FIS_ALQISS, 0) AS FIS_ALQISS, ';
  strSQL := strSQL + '  IFNULL(FIS_VALIS1, 0) + IFNULL(FIS_VALIS2, 0) + IFNULL(FIS_VALIS3, 0) + IFNULL(FIS_VALIS4, 0) + IFNULL(FIS_VALIS5, 0) AS FIS_VALISS, ';
  strSQL := strSQL + '  IFNULL(FIS_RETISS, 0) AS FIS_RETISS, ';
  strSQL := strSQL + '  IFNULL(FIS_BASPIS, 0) AS FIS_BASPIS, ';
  strSQL := strSQL + '  IFNULL(FIS_ALQPIS, 0) AS FIS_ALQPIS, ';
  strSQL := strSQL + '  IFNULL(FIS_TOTPIS, 0) AS FIS_TOTPIS, ';
  strSQL := strSQL + '  IFNULL(FIS_BASCOF, 0) AS FIS_BASCOF, ';
  strSQL := strSQL + '  IFNULL(FIS_ALQCOF, 0) AS FIS_ALQCOF, ';
  strSQL := strSQL + '  IFNULL(FIS_TOTCOF, 0) AS FIS_TOTCOF, ';
  strSql := strSql + '  IF( (FIS_ESPDOC = "NF") AND (IFNULL(FIS_ACESSO,"") = "") , "01",     ';
  strSql := strSql + '     IF( ( (FIS_ESPDOC IN ("NF", "NV")) AND (IFNULL(FIS_ACESSO,"") <> "") ) OR   ';
  strSql := strSql + '           (FIS_ESPDOC = "EL"),  "55",                                  ';
  strSql := strSql + '       IF( FIS_ESPDOC IN ("IF", "IV"), IF(((IFNULL(FIS_ACESSO,"")="") AND (IFNULL(FIS_HISTOR, "") NOT LIKE "%INUTILI%")), "2D", "65"), "01" ) ) ) AS FIS_DOCMOD, ';

  if (FNotaFiscalConjugada) then
  begin
    strSQL := strSQL + '  IFNULL(FIS_VALISS, 0) AS FIS_VALISS_CONJ, ';
    strSQL := strSQL + '  FIS_CDSERV, ';

    strSQL := strSQL + '  IF(IFNULL(FIS_CLFSC1,0) LIKE "%933%", FIS_VLCON1, 0) + ';
    strSQL := strSQL + '  IF(IFNULL(FIS_CLFSC2,0) LIKE "%933%", FIS_VLCON2, 0) + ';
    strSQL := strSQL + '  IF(IFNULL(FIS_CLFSC3,0) LIKE "%933%", FIS_VLCON3, 0) + ';
    strSQL := strSQL + '  IF(IFNULL(FIS_CLFSC4,0) LIKE "%933%", FIS_VLCON4, 0) + ';
    strSQL := strSQL + '  IF(IFNULL(FIS_CLFSC5,0) LIKE "%933%", FIS_VLCON5, 0) AS FIS_VLRCON_CONJ, ';

    strSQL := strSQL + '  IF(IFNULL(FIS_CLFSC1,0) LIKE "%933%", FIS_OUTRA1, 0) + ';
    strSQL := strSQL + '  IF(IFNULL(FIS_CLFSC2,0) LIKE "%933%", FIS_OUTRA2, 0) + ';
    strSQL := strSQL + '  IF(IFNULL(FIS_CLFSC3,0) LIKE "%933%", FIS_OUTRA3, 0) + ';
    strSQL := strSQL + '  IF(IFNULL(FIS_CLFSC4,0) LIKE "%933%", FIS_OUTRA4, 0) + ';
    strSQL := strSQL + '  IF(IFNULL(FIS_CLFSC5,0) LIKE "%933%", FIS_OUTRA5, 0) AS FIS_OUTRAS_CONJ, ';

    strSQL := strSQL + '  IF(IFNULL(FIS_CLFSC1,0) LIKE "%933%", FIS_VALIS1, 0) + ';
    strSQL := strSQL + '  IF(IFNULL(FIS_CLFSC2,0) LIKE "%933%", FIS_VALIS2, 0) + ';
    strSQL := strSQL + '  IF(IFNULL(FIS_CLFSC3,0) LIKE "%933%", FIS_VALIS3, 0) + ';
    strSQL := strSQL + '  IF(IFNULL(FIS_CLFSC4,0) LIKE "%933%", FIS_VALIS4, 0) + ';
    strSQL := strSQL + '  IF(IFNULL(FIS_CLFSC5,0) LIKE "%933%", FIS_VALIS5, 0) AS FIS_VALISS_CONJ, ';

    strSQL := strSQL + '  SUBSTRING( ';
    strSQL := strSQL + '    CASE WHEN IFNULL(FIS_CLFSC1,"") LIKE "%933%" THEN FIS_CLFSC1 ';
    strSQL := strSQL + '         WHEN IFNULL(FIS_CLFSC2,"") LIKE "%933%" THEN FIS_CLFSC2 ';
    strSQL := strSQL + '         WHEN IFNULL(FIS_CLFSC3,"") LIKE "%933%" THEN FIS_CLFSC3 ';
    strSQL := strSQL + '         WHEN IFNULL(FIS_CLFSC4,"") LIKE "%933%" THEN FIS_CLFSC4 ';
    strSQL := strSQL + '         WHEN IFNULL(FIS_CLFSC5,"") LIKE "%933%" THEN FIS_CLFSC5 ';
    strSQL := strSQL + '  END,1,1) AS FIS_ICLFSC_CONJ, ';
  end;

  strSQL := strSQL + '  IF(IFNULL(FIS_HISTOR, "") = "CANCELADO", "02", "00") AS FIS_SITDOC ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADFIS ';

  strSQL := strSQL + '  LEFT JOIN MOVGER ';
  strSQL := strSQL + '   ON GER_NUMDOC = FIS_NUMDOC ';
  strSQL := strSQL + '   AND GER_ESPDOC = FIS_ESPDOC ';
  strSQL := strSQL + '   AND GER_CODEMP = FIS_CODEMP ';
  strSQL := strSQL + '   AND IFNULL(GER_SERIE_, "") = IFNULL(FIS_SERIE_, "") ';
  strSQL := strSQL + '   AND IF(FIS_TIP_FC = "C", GER_CODCLI, GER_CODFOR) = FIS_FORCLI ';

  strSQL := strSQL + '  LEFT JOIN CADCLI ';
  strSQL := strSQL + '   ON CLI_CODCLI = FIS_FORCLI ';

  strSQL := strSQL + '  LEFT JOIN CADFOR ';
  strSQL := strSQL + '   ON FOR_CODFOR = FIS_FORCLI ';

  strSQL := strSQL + '  LEFT JOIN CADEMP ';
  strSQL := strSQL + '   ON EMP_CODEMP = FIS_CODEMP ';

  strSQL := strSQL + '  LEFT JOIN CADCID CE ';
  strSQL := strSQL + '   ON CE.CID_CODCID = EMP_CODCID ';

  strSQL := strSQL + '  LEFT JOIN CADCID CC ';
  strSQL := strSQL + '   ON CC.CID_CODCID = CLI_CODCID ';

  strSQL := strSQL + '  LEFT JOIN CADCID CF ';
  strSQL := strSQL + '   ON CF.CID_CODCID = FOR_CODCID ';

  strSQL := strSQL + 'WHERE FIS_DTAENT BETWEEN :DTAINI ';
  strSQL := strSQL + '  AND :DTAFIN ';
  strSQL := strSQL + '  AND FIS_CODEMP = :CODEMP ';
  strSql := strSql + '  AND IF(:DTAINI >= ''2023-01-01'',IFNULL(FIS_HISTOR,"") NOT LIKE "%DENEGAD%" AND IFNULL(FIS_HISTOR,"") NOT LIKE "%INUTILI%",TRUE) ';

  if (not(FNotaFiscalConjugada)) then
  begin

    if FIncluirCFOPSaida Then
      strSQL := strSQL + '  AND (FIS_CLFSC1 IN ("1933", "2933", "5933", "6933")) '
    else
      strSQL := strSQL + '  AND ((FIS_CLFSC1 = "1933") OR (FIS_CLFSC1 = "2933")) ';

    strSQL := strSQL + '  AND (IFNULL(FIS_CLFSC2, "") = "")';

  end
  else
  begin
    strSQL := strSQL + '  AND SUBSTRING( ';
    strSQL := strSQL + '     CASE WHEN IFNULL(FIS_CLFSC1,"") LIKE "%933%" THEN FIS_CLFSC1 ';
    strSQL := strSQL + '          WHEN IFNULL(FIS_CLFSC2,"") LIKE "%933%" THEN FIS_CLFSC2 ';
    strSQL := strSQL + '          WHEN IFNULL(FIS_CLFSC3,"") LIKE "%933%" THEN FIS_CLFSC3 ';
    strSQL := strSQL + '          WHEN IFNULL(FIS_CLFSC4,"") LIKE "%933%" THEN FIS_CLFSC4 ';
    strSQL := strSQL + '          WHEN IFNULL(FIS_CLFSC5,"") LIKE "%933%" THEN FIS_CLFSC5 ';

    if FIncluirCFOPSaida Then
      { notas fiscais de entrada e saida }
      strSQL := strSQL + '  END,1,1) IN ("1","2","5","6") '
    else
      { notas fiscais somente de entrada }
      strSQL := strSQL + '  END,1,1) IN ("1","2") ';

    { notas fiscais de prestação de serviços }
    strSQL := strSQL + '  AND SUBSTRING( ';
    strSQL := strSQL + '     CASE WHEN IFNULL(FIS_CLFSC1,"") LIKE "%933%" THEN FIS_CLFSC1 ';
    strSQL := strSQL + '          WHEN IFNULL(FIS_CLFSC2,"") LIKE "%933%" THEN FIS_CLFSC2 ';
    strSQL := strSQL + '          WHEN IFNULL(FIS_CLFSC3,"") LIKE "%933%" THEN FIS_CLFSC3 ';
    strSQL := strSQL + '          WHEN IFNULL(FIS_CLFSC4,"") LIKE "%933%" THEN FIS_CLFSC4 ';
    strSQL := strSQL + '          WHEN IFNULL(FIS_CLFSC5,"") LIKE "%933%" THEN FIS_CLFSC5 ';
    strSQL := strSQL + '  END,2,3) = "933" ';
  end;

  Result := strSQL;
end;

function TRepositorioNotasFiscais.fRetSqlTodasNotasSubApuracaoIcms(abertura: TDadosAbertura): string;
begin
  Result := '';

  Result := Result + 'SELECT ';

  if FExisteMovAux then
  begin
    Result := Result + '  MA.DET_NOTULT AS NOTULT, ';
    Result := Result + '  MA.DET_BICMEF AS BASE_EFETIVA, ';
    Result := Result + '  MA.DET_AICMEF AS ALQ_EFETIVA,';
    Result := Result + '  MA.DET_VICMEF AS VLR_EFETIVO, ';
    Result := Result + '  MA.DET_BSTANT AS BASE_ST_COMPRA_PROPORCIONAL, ';
    Result := Result + '  MA.DET_VSTANT AS VALOR_ST_COMPRA_PROPORCIONAL, ' ;
  end
  else
  begin
    Result := Result + '  "" AS NOTULT, ';
    Result := Result + '  0 AS BASE_EFETIVA, ';
    Result := Result + '  0 AS ALQ_EFETIVA,';
    Result := Result + '  0 AS VLR_EFETIVO, ';
    Result := Result + '  0 AS BASE_ST_COMPRA_PROPORCIONAL, ';
    Result := Result + '  0 AS VALOR_ST_COMPRA_PROPORCIONAL, ' ;
  end;

  Result := Result + '  D.DET_CODITE AS CODITE, ';
  Result := Result + '  D.DET_VLRCON AS VLRCON, ';
  Result := Result + '  D.DET_QTDITE AS QTDITE, ';
  Result := Result + '  D.DET_CODFIS AS CODFIS, ';
  Result := Result + '  D.DET_ESTADO AS ESTADO, ';
  Result := Result + '  D.DET_CLAFIS AS CLAFIS, ';
  Result := Result + '  D.DET_DOCDEV AS DOCDEV, ';

  Result := Result + '  IF(LOCATE(FIS_ESPDOC, "IF_IV") > 0 AND IFNULL(FIS_ACESSO, "") = "", FIS_NUMCOO, FIS_NUMDOC) AS DOCUMENTO, ';
  Result := Result + '   IF(((IFNULL(FIS_HISTOR, "") LIKE "%INUTILI%") AND (FIS_ESPDOC IN ("IF", "IV"))), "65",';
  Result := Result + '     IF(IFNULL(FIS_HISTOR, "") LIKE "%INUTILI%", "55", IF(FIS_SERIE_ BETWEEN 890 AND 899, "55", IF( (FIS_ESPDOC = "NF") AND (IFNULL(FIS_ACESSO,"") = "") , "01", ';
  Result := Result + '     IF( ( (FIS_ESPDOC IN ("NF", "NV")) AND (IFNULL(FIS_ACESSO,"") <> "") ) OR ';
  Result := Result + '           (FIS_ESPDOC = "EL"), "55", ';
  Result := Result + '       IF( FIS_ESPDOC IN ("IF", "IV"), IF(IFNULL(FIS_ACESSO,"")="", "2D", "65"), "01" ) ) ) ) ) ) AS MODELO, ';
  Result := Result + '  FIS_DTAENT AS DTAENT, ';
  Result := Result + '  FIS_CODEMP AS CODEMP, ';
  Result := Result + '  FIS_ACESSO AS ACESSO, ';

  Result := Result + '  FIS_FORCLI AS FORCLI, ';
  Result := Result + '  FIS_TIP_FC AS TIP_FC, ';
  Result := Result + '  CLI_NOMCLI AS NOME, ';
  Result := Result + '  IFNULL(CC.CID_CODCID, "00000") AS CODCID, ';

  Result := Result + '  IF(IFNULL(GER_CGCCON, "") <> "", GER_CGCCON, CLI_C_G_C_) AS C_G_C_, ';
  Result := Result + '  FIS_SERIE_ AS SERIE ';

  Result := Result + 'FROM ';
  Result := Result + '  CADFIS ';

  Result := Result + '  INNER JOIN MOVGER ';
  Result := Result + '    ON GER_NUMDOC = FIS_NUMDOC ';
  Result := Result + '    AND GER_CODEMP = FIS_CODEMP ';
  Result := Result + '    AND GER_ESPDOC = FIS_ESPDOC ';
  Result := Result + '    AND IFNULL(GER_SERIE_, "") = IFNULL(FIS_SERIE_, "")';
  Result := Result + '    AND IF(FIS_TIP_FC = "C", GER_CODCLI, GER_CODFOR) = FIS_FORCLI ';

  Result := Result + '  INNER JOIN MOVDET D ';
  Result := Result + '    ON D.DET_NUMDOC = FIS_NUMDOC ';
  Result := Result + '    AND D.DET_CODEMP = FIS_CODEMP ';
  Result := Result + '    AND D.DET_ESPDOC = FIS_ESPDOC ';
  Result := Result + '    AND IFNULL(D.DET_SERIE_, "") = IFNULL(FIS_SERIE_, "")';
  Result := Result + '    AND IF(FIS_TIP_FC = "C", D.DET_CODCLI, D.DET_CODFOR) = FIS_FORCLI ';

  if FExisteMovAux then
  begin
    Result := Result + '  INNER JOIN MOVAUX MA ';
    Result := Result + '    ON MA.DET_SEQGER = D.AUTOINCREM ';
  end;

  Result := Result + '  LEFT JOIN AUXMOV ';
  Result := Result + '    ON AUX_SEQGER = MOVGER.AUTOINCREM ';

  Result := Result + '  LEFT JOIN CADCLI ';
  Result := Result + '    ON CLI_CODCLI = FIS_FORCLI ';
  Result := Result + '  LEFT JOIN CADCID CC ON CC.CID_CODCID = CLI_CODCID ';

  Result := Result + 'WHERE FIS_DTAENT BETWEEN :DTAINI ';
  Result := Result + '  AND :DTAFIN ';
  Result := Result + '  AND FIS_CODEMP = :CODEMP ';
  Result := Result + '  AND LOCATE(FIS_ESPDOC, "NF_IF_IV_NV") > 0 ';
  Result := Result + '  AND LOCATE(D.DET_CLAFIS, :CLAVEN) > 0 ';
  Result := Result + '  AND (IFNULL(D.DET_PROEMB,"") <> "S") ';
  //# Result := Result + '  AND D.DET_CLAFIS > 5000 ';
  Result := Result + '  AND ((DET_ESTADO = "RS") OR (AUX_VENPRE = "S")) ';

  If Not fEmptyStr(VS_strFiltroNumDoc) Then
    Result := Result + '  AND FIS_NUMDOC = "'+VS_strFiltroNumDoc+'" ';

  Result := Result + ' UNION ALL ' + AnsiReplaceText(AnsiReplaceText(AnsiReplaceText(Result, 'MOVDET', 'NOTDET'), 'MOVAUX', 'NOTAUX'), 'MOVGER', 'NOTGER');

  Result := 'SELECT * FROM (' + Result + ') AS TAB ';

  //# abertura.notaFiscal.strNumero := '000000289795_';
  if (not(fEmptyStr(abertura.notaFiscal.strNumero))) and (abertura.blnInconsistencia) then
  begin
    Result := Result + ' WHERE LOCATE(DOCUMENTO, :DOCUMENTO) > 0 ';
    Result := Result + '   AND (NOTULT IS NULL OR NOTULT = "") ';
  end;

  if ((not(fEmptyStr(abertura.notaFiscal.strNumero))) and (not(abertura.blnInconsistencia))) then
    Result := Result + ' WHERE LOCATE(DOCUMENTO, :DOCUMENTO) > 0 ';

  if (fEmptyStr(abertura.notaFiscal.strNumero)) and (abertura.blnInconsistencia)  then
    Result := Result + ' WHERE (NOTULT IS NULL OR NOTULT = "") ';

  Result := Result + ' ORDER BY CODITE ';
end;

function TRepositorioNotasFiscais.fRetSqlTodasNotasTransportePorPeriodo: String;
  var
    strSQL: string;
begin
  strSQL := '';

  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  FIS_NUMDOC, ';
  strSQL := strSQL + '  FIS_CODEMP, ';
  strSQL := strSQL + '  FIS_SERIE_, ';
  strSQL := strSQL + '  FIS_ESPDOC, ';
  strSQL := strSQL + '  FIS_FORCLI, ';
  strSQL := strSQL + '  FIS_TIP_FC, ';
  strSQL := strSQL + '  FIS_DTAENT, ';
  strSQL := strSQL + '  FIS_DTADOC, ';
  strSQL := strSQL + '  GER_TOTFRE, ';
  strSQL := strSQL + '  GER_DESESP, ';
  strSql := strSql + '  GER_TIPFRE AS GER_TIPO_FRETE, ';
  strSql := strSql + '   IF( (FIS_ESPDOC = "NF") AND (IFNULL(FIS_ACESSO,"") = "") , "01",     ';
  strSql := strSql + '     IF( ( (FIS_ESPDOC IN ("NF", "NV")) AND (IFNULL(FIS_ACESSO,"") <> "") ) OR   ';
  strSql := strSql + '           (FIS_ESPDOC = "EL"),  "55",                                  ';
  strSql := strSql + '       IF( FIS_ESPDOC IN ("IF", "IV"), IF(((IFNULL(FIS_ACESSO,"")="") AND (IFNULL(FIS_HISTOR, "") NOT LIKE "%INUTILI%")), "2D", "65"), "01" ) ) ) AS FIS_DOCMOD, ';
  strSQL := strSQL + '  IF(IFNULL(FIS_HISTOR, "") = "CANCELADO", "02", "00") AS FIS_SITDOC, ';
  strSQL := strSQL + '  CE.CID_ESTADO, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CLI_C_E_P_, FOR_C_E_P_) AS CEP, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CLI_C_G_C_, FOR_C_G_C_) AS CNPJ, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CLI_NOMCLI, FOR_NOMFOR) AS NOME, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CLI_BAIRRO, FOR_BAIRRO) AS BAIRRO, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CLI_ENDERE, FOR_ENDERE) AS ENDERECO, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CLI_FONE01, FOR_FONE01) AS TELEFONE, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CC.CID_ESTADO, CF.CID_ESTADO) AS UF, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CC.CID_NOMCID, CF.CID_NOMCID) AS MUNICIPIO, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CC.CID_COIBGE, CF.CID_COIBGE) AS CODIGO_IBGE, ';
  strSQL := strSQL + '  IFNULL(FIS_VLCON1, 0) + IFNULL(FIS_VLCON2, 0) + IFNULL(FIS_VLCON3, 0) + IFNULL(FIS_VLCON4, 0) + IFNULL(FIS_VLCON5, 0) AS FIS_VLRCON, ';
  strSQL := strSQL + '  IFNULL(FIS_OUTRA1, 0) + IFNULL(FIS_OUTRA2, 0) + IFNULL(FIS_OUTRA3, 0) + IFNULL(FIS_OUTRA4, 0) + IFNULL(FIS_OUTRA5, 0) AS FIS_OUTRAS, ';
  strSQL := strSQL + '  IFNULL(FIS_BASISS, 0) AS FIS_BASISS, ';
  strSQL := strSQL + '  IFNULL(FIS_ALQISS, 0) AS FIS_ALQISS, ';
  strSQL := strSQL + '  IFNULL(FIS_VALIS1, 0) + IFNULL(FIS_VALIS2, 0) + IFNULL(FIS_VALIS3, 0) + IFNULL(FIS_VALIS4, 0) + IFNULL(FIS_VALIS5, 0) AS FIS_VALISS, ';
  strSQL := strSQL + '  IFNULL(FIS_BASPIS, 0) AS FIS_BASPIS, ';
  strSQL := strSQL + '  IFNULL(FIS_ALQPIS, 0) AS FIS_ALQPIS, ';
  strSQL := strSQL + '  IFNULL(FIS_TOTPIS, 0) AS FIS_TOTPIS, ';
  strSQL := strSQL + '  IFNULL(FIS_BASCOF, 0) AS FIS_BASCOF, ';
  strSQL := strSQL + '  IFNULL(FIS_ALQCOF, 0) AS FIS_ALQCOF, ';
  strSQL := strSQL + '  IFNULL(FIS_TOTCOF, 0) AS FIS_TOTCOF, ';

  strSQL := strSQL + '  IFNULL(FIS_CLFSC1, "") AS FIS_CLFSC1, ';
  strSQL := strSQL + '  IFNULL(FIS_CLFSC2, "") AS FIS_CLFSC2, ';
  strSQL := strSQL + '  IFNULL(FIS_CLFSC3, "") AS FIS_CLFSC3, ';
  strSQL := strSQL + '  IFNULL(FIS_CLFSC4, "") AS FIS_CLFSC4, ';
  strSQL := strSQL + '  IFNULL(FIS_CLFSC5, "") AS FIS_CLFSC5, ';

  strSQL := strSQL + '  IFNULL(FIS_BASIC1, 0) AS FIS_BASIC1, ';
  strSQL := strSQL + '  IFNULL(FIS_BASIC2, 0) AS FIS_BASIC2, ';
  strSQL := strSQL + '  IFNULL(FIS_BASIC3, 0) AS FIS_BASIC3, ';
  strSQL := strSQL + '  IFNULL(FIS_BASIC4, 0) AS FIS_BASIC4, ';
  strSQL := strSQL + '  IFNULL(FIS_BASIC5, 0) AS FIS_BASIC5, ';

  strSQL := strSQL + '  IFNULL(FIS_ALQIC1, 0) AS FIS_ALQIC1, ';
  strSQL := strSQL + '  IFNULL(FIS_ALQIC2, 0) AS FIS_ALQIC2, ';
  strSQL := strSQL + '  IFNULL(FIS_ALQIC3, 0) AS FIS_ALQIC3, ';
  strSQL := strSQL + '  IFNULL(FIS_ALQIC4, 0) AS FIS_ALQIC4, ';
  strSQL := strSQL + '  IFNULL(FIS_ALQIC5, 0) AS FIS_ALQIC5, ';

  strSQL := strSQL + '  IFNULL(FIS_VLRIC1, 0) AS FIS_VLRIC1, ';
  strSQL := strSQL + '  IFNULL(FIS_VLRIC2, 0) AS FIS_VLRIC2, ';
  strSQL := strSQL + '  IFNULL(FIS_VLRIC3, 0) AS FIS_VLRIC3, ';
  strSQL := strSQL + '  IFNULL(FIS_VLRIC4, 0) AS FIS_VLRIC4, ';
  strSQL := strSQL + '  IFNULL(FIS_VLRIC5, 0) AS FIS_VLRIC5 ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADFIS ';

  strSQL := strSQL + '  LEFT JOIN MOVGER ';
  strSQL := strSQL + '   ON GER_NUMDOC = FIS_NUMDOC ';
  strSQL := strSQL + '   AND GER_ESPDOC = FIS_ESPDOC ';
  strSQL := strSQL + '   AND GER_CODEMP = FIS_CODEMP ';
  strSQL := strSQL + '   AND IFNULL(GER_SERIE_, "") = IFNULL(FIS_SERIE_, "") ';
  strSQL := strSQL + '   AND IF(FIS_TIP_FC = "C", GER_CODCLI, GER_CODFOR) = FIS_FORCLI ';

  strSQL := strSQL + '  LEFT JOIN CADCLI ';
  strSQL := strSQL + '   ON CLI_CODCLI = FIS_FORCLI ';

  strSQL := strSQL + '  LEFT JOIN CADFOR ';
  strSQL := strSQL + '   ON FOR_CODFOR = FIS_FORCLI ';

  strSQL := strSQL + '  LEFT JOIN CADEMP ';
  strSQL := strSQL + '   ON EMP_CODEMP = FIS_CODEMP ';

  strSQL := strSQL + '  LEFT JOIN CADCID CE ';
  strSQL := strSQL + '   ON CE.CID_CODCID = EMP_CODCID ';

  strSQL := strSQL + '  LEFT JOIN CADCID CC ';
  strSQL := strSQL + '   ON CC.CID_CODCID = CLI_CODCID ';

  strSQL := strSQL + '  LEFT JOIN CADCID CF ';
  strSQL := strSQL + '   ON CF.CID_CODCID = FOR_CODCID ';

  strSQL := strSQL + 'WHERE FIS_DTAENT BETWEEN :DTAINI ';
  strSQL := strSQL + '  AND :DTAFIN ';
  strSQL := strSQL + '  AND FIS_CODEMP = :CODEMP ';
  strSQL := strSQL + '  AND LOCATE(FIS_CLFSC1, ' + QuotedStr(CFOP_TRANSPORTE) + ') > 0 ';

  Result := strSQL;
end;

function TRepositorioNotasFiscais.fRetSqlTodosCuponsPorPeriodo: String;
  Var
    strSQL: String;
begin
  strSQL := '';

  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  IFNULL(FIS_ACESSO, "") AS FIS_ACESSO, ';
  strSQL := strSQL + '  IFNULL(FIS_HISTOR, "") AS FIS_HISTOR, ';
  strSQL := strSQL + '  IF(IFNULL(FIS_HISTOR, "") = "CANCELADO", "02", "00") AS FIS_SITDOC, ';
  strSQL := strSQL + '  REPLACE(IFNULL(FIS_NUMSER,""), "\0","") AS FIS_NUMSER, ';
  strSQL := strSQL + '  ECF_CODECF, ';
  strSQL := strSQL + '  ECF_NUMUSU, ';
  strSQL := strSQL + '  FIS_NUMCOO, ';
  strSQL := strSQL + '  RDZ_NROCOO, ';
  strSQL := strSQL + '  FIS_ESTADO, ';
  strSQL := strSQL + '  FIS_NUMDOC, ';
  strSQL := strSQL + '  FIS_CODEMP, ';
  strSQL := strSQL + '  FIS_SERIE_, ';
  strSQL := strSQL + '  FIS_ESPDOC, ';
  strSQL := strSQL + '  FIS_FORCLI, ';
  strSQL := strSQL + '  FIS_TIP_FC, ';
  strSQL := strSQL + '  FIS_DTAENT, ';
  strSQL := strSQL + '  FIS_DTADOC, ';

  strSQL := strSQL + '  IFNULL(FIS_CLFSC1, "") AS FIS_CLFSC1, ';
  strSQL := strSQL + '  IFNULL(FIS_CLFSC2, "") AS FIS_CLFSC2, ';
  strSQL := strSQL + '  IFNULL(FIS_CLFSC3, "") AS FIS_CLFSC3, ';
  strSQL := strSQL + '  IFNULL(FIS_CLFSC4, "") AS FIS_CLFSC4, ';
  strSQL := strSQL + '  IFNULL(FIS_CLFSC5, "") AS FIS_CLFSC5, ';

  strSQL := strSQL + '  IFNULL(FIS_VLCON1, 0) AS FIS_VLCON1, ';
  strSQL := strSQL + '  IFNULL(FIS_VLCON2, 0) AS FIS_VLCON2, ';
  strSQL := strSQL + '  IFNULL(FIS_VLCON3, 0) AS FIS_VLCON3, ';
  strSQL := strSQL + '  IFNULL(FIS_VLCON4, 0) AS FIS_VLCON4, ';
  strSQL := strSQL + '  IFNULL(FIS_VLCON5, 0) AS FIS_VLCON5, ';

  strSQL := strSQL + '  IFNULL(FIS_OUTRA1, 0) AS FIS_OUTRA1, ';
  strSQL := strSQL + '  IFNULL(FIS_OUTRA2, 0) AS FIS_OUTRA2, ';
  strSQL := strSQL + '  IFNULL(FIS_OUTRA3, 0) AS FIS_OUTRA3, ';
  strSQL := strSQL + '  IFNULL(FIS_OUTRA4, 0) AS FIS_OUTRA4, ';
  strSQL := strSQL + '  IFNULL(FIS_OUTRA5, 0) AS FIS_OUTRA5, ';

  strSQL := strSQL + '  IFNULL(FIS_ISENT1, 0) AS FIS_ISENT1, ';
  strSQL := strSQL + '  IFNULL(FIS_ISENT2, 0) AS FIS_ISENT2, ';
  strSQL := strSQL + '  IFNULL(FIS_ISENT3, 0) AS FIS_ISENT3, ';
  strSQL := strSQL + '  IFNULL(FIS_ISENT4, 0) AS FIS_ISENT4, ';
  strSQL := strSQL + '  IFNULL(FIS_ISENT5, 0) AS FIS_ISENT5, ';

  strSQL := strSQL + '  IFNULL(FIS_BASIC1, 0) AS FIS_BASIC1, ';
  strSQL := strSQL + '  IFNULL(FIS_BASIC2, 0) AS FIS_BASIC2, ';
  strSQL := strSQL + '  IFNULL(FIS_BASIC3, 0) AS FIS_BASIC3, ';
  strSQL := strSQL + '  IFNULL(FIS_BASIC4, 0) AS FIS_BASIC4, ';
  strSQL := strSQL + '  IFNULL(FIS_BASIC5, 0) AS FIS_BASIC5, ';

  strSQL := strSQL + '  IFNULL(FIS_ALQIC1, 0) AS FIS_ALQIC1, ';
  strSQL := strSQL + '  IFNULL(FIS_ALQIC2, 0) AS FIS_ALQIC2, ';
  strSQL := strSQL + '  IFNULL(FIS_ALQIC3, 0) AS FIS_ALQIC3, ';
  strSQL := strSQL + '  IFNULL(FIS_ALQIC4, 0) AS FIS_ALQIC4, ';
  strSQL := strSQL + '  IFNULL(FIS_ALQIC5, 0) AS FIS_ALQIC5, ';

  strSQL := strSQL + '  IFNULL(FIS_VLRIC1, 0) AS FIS_VLRIC1, ';
  strSQL := strSQL + '  IFNULL(FIS_VLRIC2, 0) AS FIS_VLRIC2, ';
  strSQL := strSQL + '  IFNULL(FIS_VLRIC3, 0) AS FIS_VLRIC3, ';
  strSQL := strSQL + '  IFNULL(FIS_VLRIC4, 0) AS FIS_VLRIC4, ';
  strSQL := strSQL + '  IFNULL(FIS_VLRIC5, 0) AS FIS_VLRIC5, ';

  strSQL := strSQL + '  GER_TOTFRE, ';
  strSQL := strSQL + '  GER_DESESP, ';
  strSQL := strSQL + '  DET_CODITE, ';
  strSQL := strSQL + '  DET_DESCRI, ';
  strSQL := strSQL + '  DET_UNIDAD, ';
  strSQL := strSQL + '  DET_QTDITE, ';
  strSQL := strSQL + '  DET_VLRCON, ';
  strSQL := strSQL + '  DET_TOTITE, ';
  strSQL := strSQL + '  DET_TOTFRE, ';
  strSQL := strSQL + '  DET_UNITAR, ';
  strSQL := strSQL + '  DET_CLAFIS, ';
  strSQL := strSQL + '  DET_VALIPI, ';
  strSQL := strSQL + '  DET_DESESP, ';
  strSQL := strSQL + '  DET_CODFIS, ';
  strSQL := strSQL + '  DET_BASICM, ';
  strSQL := strSQL + '  DET_ALQICM, ';
  strSQL := strSQL + '  DET_VALICM, ';
  strSQL := strSQL + '  DET_BASRET, ';
  strSQL := strSQL + '  DET_DESACE, ';
  strSQL := strSQL + '  T.DET_OUTICM, ';
  strSQL := strSQL + '  T.DET_CSTPIS, ';
  strSQL := strSQL + '  T.DET_BASPIS, ';
  strSQL := strSQL + '  T.DET_ALQPIS, ';
  strSQL := strSQL + '  T.DET_VALPIS, ';
  strSQL := strSQL + '  T.DET_CSTCOF, ';
  strSQL := strSQL + '  T.DET_BASCOF, ';
  strSQL := strSQL + '  T.DET_ALQCOF, ';
  strSQL := strSQL + '  T.DET_VALCOF, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CLI_C_E_P_, FOR_C_E_P_) AS CEP, ';
  strSQL := strSQL + '  IF(IFNULL(G.GER_NOMCON, "") = "", IF(FIS_TIP_FC = "C", CLI_C_G_C_, FOR_C_G_C_), G.GER_CGCCON) AS CNPJ, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CLI_NOMCLI, FOR_NOMFOR) AS NOME, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CLI_BAIRRO, FOR_BAIRRO) AS BAIRRO, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CLI_ENDERE, FOR_ENDERE) AS ENDERECO, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CLI_FONE01, FOR_FONE01) AS TELEFONE, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CC.CID_ESTADO, CF.CID_ESTADO) AS UF, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CC.CID_NOMCID, CF.CID_NOMCID) AS MUNICIPIO, ';
  strSQL := strSQL + '  IFNULL(FIS_OUTRA1, 0) + IFNULL(FIS_OUTRA2, 0) + IFNULL(FIS_OUTRA3, 0) + IFNULL(FIS_OUTRA4, 0) + IFNULL(FIS_OUTRA5, 0) AS FIS_OUTRAS, ';
  strSQL := strSQL + '  IFNULL(FIS_VLCON1, 0) + IFNULL(FIS_VLCON2, 0) + IFNULL(FIS_VLCON3, 0) + IFNULL(FIS_VLCON4, 0) + IFNULL(FIS_VLCON5, 0) AS FIS_VLRCON ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADFIS ';

  strSQL := strSQL + '	LEFT JOIN MOVGER G ';
  strSQL := strSQL + '   ON G.GER_NUMDOC = FIS_NUMDOC ';
  strSQL := strSQL + '   AND G.GER_ESPDOC = FIS_ESPDOC ';
  strSQL := strSQL + '   AND G.GER_CODEMP = FIS_CODEMP ';
  strSQL := strSQL + '   AND IFNULL(G.GER_SERIE_, "") = IFNULL(FIS_SERIE_, "") ';
  strSQL := strSQL + '   AND G.GER_TIP_FC = FIS_TIP_FC ';
  strSQL := strSQL + '   AND IF(G.GER_TIP_FC = "C", G.GER_CODCLI, G.GER_CODFOR) = FIS_FORCLI ';

  strSQL := strSQL + '  LEFT JOIN MOVDET D ';
  strSQL := strSQL + '   ON D.DET_NUMDOC = G.GER_NUMDOC';
  strSQL := strSQL + '   AND D.DET_ESPDOC = G.GER_ESPDOC ';
  strSQL := strSQL + '   AND D.DET_CODEMP = G.GER_CODEMP ';
  strSQL := strSQL + '   AND IFNULL(D.DET_SERIE_, "") = IFNULL(G.GER_SERIE_, "") ';
  strSQL := strSQL + '   AND D.DET_TIP_FC = G.GER_TIP_FC ';
  strSQL := strSQL + '   AND IF(FIS_TIP_FC = "C", D.DET_CODCLI, D.DET_CODFOR) = IF(G.GER_TIP_FC = "C", G.GER_CODCLI, G.GER_CODFOR)';

  strSQL := strSQL + '  LEFT JOIN MOVTRI T ';
  strSQL := strSQL + '   ON T.DET_SEQGER = D.AUTOINCREM';

  strSQL := strSQL + '  LEFT JOIN CADECF ';
  strSQL := strSQL + '   ON ECF_NUMSER = REPLACE(IFNULL(FIS_NUMSER, ""), "\0", "") ';

  strSQL := strSQL + '  LEFT JOIN CADRDZ ';
  strSQL := strSQL + '   ON RDZ_CODECF = ECF_CODECF ';
  strSQL := strSQL + '   AND RDZ_DTAMOV = FIS_DTAENT ';
  strSQL := strSQL + '   AND RDZ_CODEMP = FIS_CODEMP ';

  strSQL := strSQL + '  LEFT JOIN CADCLI ';
  strSQL := strSQL + '   ON CLI_CODCLI = IF(FIS_TIP_FC = "C", FIS_FORCLI, NULL)';

  strSQL := strSQL + '  LEFT JOIN CADFOR ';
  strSQL := strSQL + '   ON FOR_CODFOR = IF(FIS_TIP_FC = "F", FIS_FORCLI, NULL)';

  strSQL := strSQL + '  LEFT JOIN CADCID CC';
  strSQL := strSQL + '   ON CC.CID_CODCID = CLI_CODCID ';

  strSQL := strSQL + '  LEFT JOIN CADCID CF';
  strSQL := strSQL + '   ON CF.CID_CODCID = FOR_CODCID ';

  strSQL := strSQL + 'WHERE FIS_DTAENT BETWEEN :DTAINI ';
  strSQL := strSQL + '  AND :DTAFIN ';
  strSQL := strSQL + '  AND FIS_CODEMP = :CODEMP ';
  strSQL := strSQL + '  AND LOCATE(FIS_ESPDOC, "IF") > 0 ';
  strSQL := strSQL + '  AND REPLACE(IFNULL(FIS_NUMSER,""), "\0", "") <> "" ';
  strSQL := strSQL + '  AND IFNULL(FIS_ACESSO, "") = "" ';
  strSQL := strSQL + '  AND IFNULL(DET_PROEMB, "") <> "S" ';

  Result := strSQL;
end;

function TRepositorioNotasFiscais.fRetSqlTodosCuponsSatPorPeriodo: String;
  Var
    strSQL: String;
begin
  strSQL := '';

  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  IFNULL(FIS_ACESSO, "") AS FIS_ACESSO, ';
  strSQL := strSQL + '  IFNULL(FIS_HISTOR, "") AS FIS_HISTOR, ';
  strSQL := strSQL + '  IF(IFNULL(FIS_HISTOR, "") = "CANCELADO", "02", "00") AS FIS_SITDOC, ';
  strSQL := strSQL + '  REPLACE(IFNULL(FIS_NUMSER,""), "\0","") AS FIS_NUMSER, ';
  strSQL := strSQL + '  FIS_NUMCOO, ';
  strSQL := strSQL + '  FIS_ESTADO, ';
  strSQL := strSQL + '  FIS_NUMDOC, ';
  strSQL := strSQL + '  FIS_CODEMP, ';
  strSQL := strSQL + '  FIS_SERIE_, ';
  strSQL := strSQL + '  FIS_ESPDOC, ';
  strSQL := strSQL + '  FIS_FORCLI, ';
  strSQL := strSQL + '  FIS_TIP_FC, ';
  strSQL := strSQL + '  FIS_DTAENT, ';
  strSQL := strSQL + '  FIS_DTADOC, ';

  strSQL := strSQL + '  IFNULL(FIS_CLFSC1, "") AS FIS_CLFSC1, ';
  strSQL := strSQL + '  IFNULL(FIS_CLFSC2, "") AS FIS_CLFSC2, ';
  strSQL := strSQL + '  IFNULL(FIS_CLFSC3, "") AS FIS_CLFSC3, ';
  strSQL := strSQL + '  IFNULL(FIS_CLFSC4, "") AS FIS_CLFSC4, ';
  strSQL := strSQL + '  IFNULL(FIS_CLFSC5, "") AS FIS_CLFSC5, ';

  strSQL := strSQL + '  IFNULL(FIS_VLCON1, 0) AS FIS_VLCON1, ';
  strSQL := strSQL + '  IFNULL(FIS_VLCON2, 0) AS FIS_VLCON2, ';
  strSQL := strSQL + '  IFNULL(FIS_VLCON3, 0) AS FIS_VLCON3, ';
  strSQL := strSQL + '  IFNULL(FIS_VLCON4, 0) AS FIS_VLCON4, ';
  strSQL := strSQL + '  IFNULL(FIS_VLCON5, 0) AS FIS_VLCON5, ';

  strSQL := strSQL + '  IFNULL(FIS_OUTRA1, 0) AS FIS_OUTRA1, ';
  strSQL := strSQL + '  IFNULL(FIS_OUTRA2, 0) AS FIS_OUTRA2, ';
  strSQL := strSQL + '  IFNULL(FIS_OUTRA3, 0) AS FIS_OUTRA3, ';
  strSQL := strSQL + '  IFNULL(FIS_OUTRA4, 0) AS FIS_OUTRA4, ';
  strSQL := strSQL + '  IFNULL(FIS_OUTRA5, 0) AS FIS_OUTRA5, ';

  strSQL := strSQL + '  IFNULL(FIS_ISENT1, 0) AS FIS_ISENT1, ';
  strSQL := strSQL + '  IFNULL(FIS_ISENT2, 0) AS FIS_ISENT2, ';
  strSQL := strSQL + '  IFNULL(FIS_ISENT3, 0) AS FIS_ISENT3, ';
  strSQL := strSQL + '  IFNULL(FIS_ISENT4, 0) AS FIS_ISENT4, ';
  strSQL := strSQL + '  IFNULL(FIS_ISENT5, 0) AS FIS_ISENT5, ';

  strSQL := strSQL + '  IFNULL(FIS_BASIC1, 0) AS FIS_BASIC1, ';
  strSQL := strSQL + '  IFNULL(FIS_BASIC2, 0) AS FIS_BASIC2, ';
  strSQL := strSQL + '  IFNULL(FIS_BASIC3, 0) AS FIS_BASIC3, ';
  strSQL := strSQL + '  IFNULL(FIS_BASIC4, 0) AS FIS_BASIC4, ';
  strSQL := strSQL + '  IFNULL(FIS_BASIC5, 0) AS FIS_BASIC5, ';

  strSQL := strSQL + '  IFNULL(FIS_ALQIC1, 0) AS FIS_ALQIC1, ';
  strSQL := strSQL + '  IFNULL(FIS_ALQIC2, 0) AS FIS_ALQIC2, ';
  strSQL := strSQL + '  IFNULL(FIS_ALQIC3, 0) AS FIS_ALQIC3, ';
  strSQL := strSQL + '  IFNULL(FIS_ALQIC4, 0) AS FIS_ALQIC4, ';
  strSQL := strSQL + '  IFNULL(FIS_ALQIC5, 0) AS FIS_ALQIC5, ';

  strSQL := strSQL + '  IFNULL(FIS_VLRIC1, 0) AS FIS_VLRIC1, ';
  strSQL := strSQL + '  IFNULL(FIS_VLRIC2, 0) AS FIS_VLRIC2, ';
  strSQL := strSQL + '  IFNULL(FIS_VLRIC3, 0) AS FIS_VLRIC3, ';
  strSQL := strSQL + '  IFNULL(FIS_VLRIC4, 0) AS FIS_VLRIC4, ';
  strSQL := strSQL + '  IFNULL(FIS_VLRIC5, 0) AS FIS_VLRIC5, ';

  strSQL := strSQL + '  GER_TOTFRE, ';
  strSQL := strSQL + '  GER_DESESP, ';
  strSQL := strSQL + '  DET_CODITE, ';
  strSQL := strSQL + '  DET_DESCRI, ';
  strSQL := strSQL + '  DET_UNIDAD, ';
  strSQL := strSQL + '  DET_QTDITE, ';
  strSQL := strSQL + '  DET_VLRCON, ';
  strSQL := strSQL + '  DET_TOTITE, ';
  strSQL := strSQL + '  DET_TOTFRE, ';
  strSQL := strSQL + '  DET_UNITAR, ';
  strSQL := strSQL + '  DET_CLAFIS, ';
  strSQL := strSQL + '  DET_VALIPI, ';
  strSQL := strSQL + '  DET_DESESP, ';
  strSQL := strSQL + '  DET_CODFIS, ';
  strSQL := strSQL + '  DET_BASICM, ';
  strSQL := strSQL + '  DET_ALQICM, ';
  strSQL := strSQL + '  DET_VALICM, ';
  strSQL := strSQL + '  DET_BASRET, ';
  strSQL := strSQL + '  DET_DESACE, ';
  strSQL := strSQL + '  T.DET_OUTICM, ';
  strSQL := strSQL + '  T.DET_CSTPIS, ';
  strSQL := strSQL + '  T.DET_BASPIS, ';
  strSQL := strSQL + '  T.DET_ALQPIS, ';
  strSQL := strSQL + '  T.DET_VALPIS, ';
  strSQL := strSQL + '  T.DET_CSTCOF, ';
  strSQL := strSQL + '  T.DET_BASCOF, ';
  strSQL := strSQL + '  T.DET_ALQCOF, ';
  strSQL := strSQL + '  T.DET_VALCOF, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CLI_C_E_P_, FOR_C_E_P_) AS CEP, ';
  strSQL := strSQL + '  IF(IFNULL(G.GER_NOMCON, "") = "", IF(FIS_TIP_FC = "C", CLI_C_G_C_, FOR_C_G_C_), G.GER_CGCCON) AS CNPJ, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CLI_NOMCLI, FOR_NOMFOR) AS NOME, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CLI_BAIRRO, FOR_BAIRRO) AS BAIRRO, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CLI_ENDERE, FOR_ENDERE) AS ENDERECO, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CLI_FONE01, FOR_FONE01) AS TELEFONE, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CC.CID_ESTADO, CF.CID_ESTADO) AS UF, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CC.CID_NOMCID, CF.CID_NOMCID) AS MUNICIPIO, ';
  strSQL := strSQL + '  IFNULL(FIS_OUTRA1, 0) + IFNULL(FIS_OUTRA2, 0) + IFNULL(FIS_OUTRA3, 0) + IFNULL(FIS_OUTRA4, 0) + IFNULL(FIS_OUTRA5, 0) AS FIS_OUTRAS, ';
  strSQL := strSQL + '  IFNULL(FIS_VLCON1, 0) + IFNULL(FIS_VLCON2, 0) + IFNULL(FIS_VLCON3, 0) + IFNULL(FIS_VLCON4, 0) + IFNULL(FIS_VLCON5, 0) AS FIS_VLRCON ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADFIS ';

  strSQL := strSQL + '	INNER JOIN MOVGER G ';
  strSQL := strSQL + '   ON G.GER_NUMDOC = FIS_NUMDOC ';
  strSQL := strSQL + '   AND G.GER_ESPDOC = FIS_ESPDOC ';
  strSQL := strSQL + '   AND G.GER_CODEMP = FIS_CODEMP ';
  strSQL := strSQL + '   AND IFNULL(G.GER_SERIE_, "") = IFNULL(FIS_SERIE_, "") ';
  strSQL := strSQL + '   AND G.GER_TIP_FC = FIS_TIP_FC ';
  strSQL := strSQL + '   AND IF(G.GER_TIP_FC = "C", G.GER_CODCLI, G.GER_CODFOR) = FIS_FORCLI ';

  strSQL := strSQL + '  INNER JOIN MOVDET D ';
  strSQL := strSQL + '   ON D.DET_NUMDOC = G.GER_NUMDOC';
  strSQL := strSQL + '   AND D.DET_ESPDOC = G.GER_ESPDOC ';
  strSQL := strSQL + '   AND D.DET_CODEMP = G.GER_CODEMP ';
  strSQL := strSQL + '   AND IFNULL(D.DET_SERIE_, "") = IFNULL(G.GER_SERIE_, "") ';
  strSQL := strSQL + '   AND D.DET_TIP_FC = G.GER_TIP_FC ';
  strSQL := strSQL + '   AND IF(FIS_TIP_FC = "C", D.DET_CODCLI, D.DET_CODFOR) = IF(G.GER_TIP_FC = "C", G.GER_CODCLI, G.GER_CODFOR)';

  strSQL := strSQL + '  INNER JOIN MOVTRI T ';
  strSQL := strSQL + '   ON T.DET_SEQGER = D.AUTOINCREM';

  strSQL := strSQL + '  LEFT JOIN CADCLI ';
  strSQL := strSQL + '   ON CLI_CODCLI = IF(FIS_TIP_FC = "C", FIS_FORCLI, NULL)';

  strSQL := strSQL + '  LEFT JOIN CADFOR ';
  strSQL := strSQL + '   ON FOR_CODFOR = IF(FIS_TIP_FC = "F", FIS_FORCLI, NULL)';

  strSQL := strSQL + '  LEFT JOIN CADCID CC';
  strSQL := strSQL + '   ON CC.CID_CODCID = CLI_CODCID ';

  strSQL := strSQL + '  LEFT JOIN CADCID CF';
  strSQL := strSQL + '   ON CF.CID_CODCID = FOR_CODCID ';

  strSQL := strSQL + 'WHERE FIS_DTAENT BETWEEN :DTAINI ';
  strSQL := strSQL + '  AND :DTAFIN ';
  strSQL := strSQL + '  AND FIS_CODEMP = :CODEMP ';
  strSQL := strSQL + '  AND LOCATE(FIS_ESPDOC, "IF_IV") > 0 ';
  strSQL := strSQL + '  AND REPLACE(IFNULL(FIS_NUMSER,""), "\0", "") <> "" ';
  strSQL := strSQL + '  AND IFNULL(FIS_ACESSO, "") <> "" ';
  strSQL := strSQL + '  AND IFNULL(DET_PROEMB, "") <> "S" ';

  strSQL := strSQL + ' UNION ALL ' + AnsiReplaceText(AnsiReplaceText(AnsiReplaceText(strSql, 'MOVDET', 'NOTDET'),
                                                                                             'MOVGER', 'NOTGER'),
                                                                                             'MOVTRI', 'NOTTRI');

  strSQL := strSQL + ' UNION ALL ' + AnsiReplaceText(AnsiReplaceText(AnsiReplaceText(AnsiReplaceText(AnsiReplaceText(AnsiReplaceText(strSql,
                                                                                              'MOVGER', 'DEL_MOVGER'),
                                                                                              'MOVDET', 'DEL_MOVDET'),
                                                                                              'MOVTRI', 'DEL_MOVTRI'),
                                                                                              'NOTGER', 'DEL_NOTGER'),
                                                                                              'NOTDET', 'DEL_NOTDET'),
                                                                                              'NOTTRI', 'DEL_NOTTRI');

  strSQL := strSQL + ' ORDER BY FIS_SERIE_, FIS_TIP_FC, FIS_ESPDOC, FIS_NUMDOC, FIS_CODEMP, FIS_FORCLI ';

  Result := strSQL;
end;

function TRepositorioNotasFiscais.fRetTabelaInventario(abertura: TDadosAbertura): string;
  var
    intDia, intMes, intAno: word;
    dataMesAnterior: TDateTime;
begin
  dataMesAnterior := IncMonth(abertura.dtaDataInicial,-1);
  DecodeDate(dataMesAnterior, intAno, intMes, intDia);

  Result := 'I_' + FormatDateTime('YYYYMM', dataMesAnterior);
end;

function TRepositorioNotasFiscais.fRetValorRetidoUnitario(strCfop, strNotUlt, strCodIte: string): double;
  var
    fltValorNfTransferencia: double;
begin
  fltValorNfTransferencia := 0;
  if Pos(strCfop, '1409') > 0 then
    fltValorNfTransferencia := fRetValorRetidoUnitarioTransferencia(strNotUlt, strCodIte);

  Result := fltValorNfTransferencia;
end;

function TRepositorioNotasFiscais.fRetValorRetidoUnitarioTransferencia(strNotUlt, strCodIte: string): double;
  function fRetSQLLocal: string;
  begin
    Result := '';
    Result := Result + 'SELECT ';
    Result := Result + 'D.DET_QTDITE AS QTDITE, ';

    if FExisteMovAux then
    begin
      Result := Result + '  MA.DET_BSTANT AS BASE_ST_COMPRA_PROPORCIONAL, ';
      Result := Result + '  MA.DET_VSTANT AS VALOR_ST_COMPRA_PROPORCIONAL, ' ;
      Result := Result + '  MA.DET_VICMEF AS VLR_EFETIVO ';
    end
    else
    begin
      Result := Result + '  0 AS BASE_ST_COMPRA_PROPORCIONAL, ';
      Result := Result + '  0 AS VALOR_ST_COMPRA_PROPORCIONAL, ' ;
      Result := Result + '  0 AS VLR_EFETIVO ';
    end;

    Result := Result + 'FROM ';
    Result := Result + '  CADFIS F ';

    Result := Result + '  LEFT JOIN MOVDET D ';
    Result := Result + '    ON IF(F.FIS_TIP_FC = "C", D.DET_CODCLI, D.DET_CODFOR) = F.FIS_FORCLI ';
    Result := Result + '    AND IFNULL(D.DET_SERIE_, "") = IFNULL(F.FIS_SERIE_, "") ';
    Result := Result + '    AND D.DET_ESPDOC = F.FIS_ESPDOC ';
    Result := Result + '    AND D.DET_CODEMP = F.FIS_CODEMP ';
    Result := Result + '    AND D.DET_NUMDOC = F.FIS_NUMDOC ';

    if FExisteMovAux then
    begin
      Result := Result + ' LEFT JOIN MOVAUX MA ';
      Result := Result + '   ON MA.DET_SEQGER = D.AUTOINCREM ';
    end;

    Result := Result + 'WHERE F.FIS_CODEMP <> :CODEMP ';
    Result := Result + '  AND F.FIS_NUMDOC  = :NUMDOC ';
    Result := Result + '  AND F.FIS_SERIE_  = :SERIE_ ';
    Result := Result + '  AND F.FIS_ESPDOC  = :ESPDOC ';
    Result := Result + '  AND F.FIS_ENTSAI  = :ENTSAI ';

    Result := Result + '  AND D.DET_CODITE  = :CODITE ';
    Result := Result + '  AND D.DET_CLAFIS  = :CLAFIS ';

    Result := Result + ' UNION ALL ' + AnsiReplaceText(AnsiReplaceText(Result, 'MOVDET', 'NOTDET'), 'MOVAUX', 'NOTAUX');
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
      SQL.Text := fRetSQLLocal;
      ParamByName('CODEMP').AsString := Copy(strNotUlt, 15, 3);
      ParamByName('NUMDOC').AsString := Copy(strNotUlt, 0, 12);
      ParamByName('SERIE_').AsString := Copy(strNotUlt, 18, 3);
      ParamByName('ESPDOC').AsString := Copy(strNotUlt, 13, 2);
      ParamByName('ENTSAI').AsString := 'S';
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CLAFIS').AsString := '5409';
      Open;

      //DET_BSTANT * 0.18 / DET_QTDITE = 5,76
      if not IsEmpty then
      begin
        Result :=
          fRound(
            (fTrunca((
              ((qryAux.FieldByName('BASE_ST_COMPRA_PROPORCIONAL').AsFloat
                + qryAux.FieldByName('VLR_EFETIVO').AsFloat)
                * 18)/100)
            , 2) / qryAux.FieldByName('QTDITE').AsFloat)
          , 2)
      end
      else
        Result := 0;
    end;
  finally
    qryAux.Free;
  end;
end;

procedure TRepositorioNotasFiscais.pCarregaNotasFiscaisCompraSubApuracaoIcmsSpedFiscal(abertura: TDadosAbertura; qryAux: TUniQuery);
  function fRetFiltroCfop: string;
  begin
    if (IIF(FENVIAR_TODAS_COMPRAS_SUBAPURACAO = '1', True, False)) and
       (not fEmptyStr(FCFOP_COMPRA_REG1923)) then
      Result := fTransform(FCFOP_COMPRA_REG1923, 4)
    else
      Result := AnsiReplaceText(AnsiReplaceText(VS_strClaCom + '1409_2409', '1407', ''), '2407', '');
  end;
begin
  with qryAux do
  begin
    Close;
    SQL.Clear;
    SQL.Text := fRetSqlTodasNotasCompraSubApuracaoIcms(abertura);
    ParamByName('DTAINI').AsDateTime := abertura.dtaDataInicial;
    ParamByName('DTAFIN').AsDateTime := abertura.dtaDataFinal;
    ParamByName('CODEMP').AsString := abertura.empresa.strCodigo;
    ParamByName('CLACOM').AsString := fRetFiltroCfop;
    Open;
  end;
end;

procedure TRepositorioNotasFiscais.pCarregaNotasFiscaisSubApuracaoIcmsSpedFiscal(abertura: TDadosAbertura; qryAux: TUniQuery);
  function fRetFiltroCfop: string;
  begin
    if (IIF(FENVIAR_TODAS_COMPRAS_SUBAPURACAO = '1', True, False)) and
       (not fEmptyStr(FCFOP_VENDA_REG1923)) then
      Result := fTransform(FCFOP_VENDA_REG1923, 4)
    else
      Result := VS_strClaVen + '5409_5949_5910_5911';
  end;
begin
  with qryAux do
  begin
    Close;
    SQL.Clear;
    SQL.Text := fRetSqlTodasNotasSubApuracaoIcms(abertura);
    ParamByName('DTAINI').AsDateTime := abertura.dtaDataInicial;
    ParamByName('DTAFIN').AsDateTime := abertura.dtaDataFinal;
    ParamByName('CODEMP').AsString := abertura.empresa.strCodigo;
    ParamByName('CLAVEN').AsString := fRetFiltroCfop;

    if (not(fEmptyStr(abertura.notaFiscal.strNumero))) then
      ParamByName('DOCUMENTO').AsString := abertura.notaFiscal.strNumero;

    Open;
  end;
end;

function TRepositorioNotasFiscais.fOrdenaListaData: IComparer<TNotaFiscal>;
  Var
    criterioComparacao: TComparison<TNotaFiscal>;
begin
  criterioComparacao := function(const L: TNotaFiscal; const R: TNotaFiscal): Integer
                        Begin
                          Result := Trunc(Int(L.dtaDtaEnt) - Int(R.dtaDtaEnt));

                          If Result = 0 Then
                            Result := CompareText(L.strNumero, R.strNumero);
                        End;

  Result := TComparer<TNotaFiscal>.Construct(criterioComparacao);
end;

procedure TInformacoesECF.pDefineDatasEcf;
begin

end;

procedure TInformacoesECF.pProcessarInformacoes;
begin
  stlEcfs.Clear;
  pCarregaEcfsPorLoja;
end;

end.
