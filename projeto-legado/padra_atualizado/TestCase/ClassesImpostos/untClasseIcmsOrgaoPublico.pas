unit untClasseIcmsOrgaoPublico;

interface

uses untAbstractConsulta, untIConsulta, untFatCalcularImpostos, untFatRegrasImpostos,
  untAbstractGerarTeste, Uni, untIGerarTeste, untICasosTestesLog, untCasosTestesLog,
  untFuncoes, Shared.Functions.Configuracoes, Shared.Functions.Funcoes.Faturamento, Forms,
  untCasosTestesLogImpl, Faturamento.Impostos.Calculos.TesteUnitarioLog,
  System.SysUtils, Vcl.Dialogs, Shared.Functions.Constantes, Shared.Functions.Types,
  Faturamento.Impostos.Interfaces.Model, Faturamento.Impostos.Tipos.Model,
  System.Math, System.Types, Shared.Functions.FloatUtils, UniClientDataSet,
  UniDataSetProvider, System.Variants, untParametrosResultadoIcmsOrgaoPublico,
  Faturamento.Impostos.Interfaces.IcmsOrgaoPublico, Faturamento.Impostos.Tipos.IcmsOrgaoPublico,
  Data.DB, untTypes;

type
  TConsultaIcmsOrgaoPublico = class(TAbstractConsulta)
  public
    Class function New : IConsulta;
    function fRetornarSQLIcmsOrgaoPublico : String; override;
  end;

type
  TGerarTesteIcmsOrgaoPublico = class(TAbstractGerarTeste)
  private

  public
    Class function New : IGerarTeste;

    Constructor Create;
    Destructor Destroy; override;

    function fGerarTesteIcmsOrgaoPublico(const ADados: OleVariant) : Boolean; override;
  end;

implementation

uses
  untModulo;

{ TConsultaIcmsOrgaoPublico }

function TConsultaIcmsOrgaoPublico.fRetornarSQLIcmsOrgaoPublico: String;
begin
  Result := 'SELECT                                                           ' +
            '  D.DET_NUMDOC,                                                  ' +
            '  D.DET_ESPDOC,                                                  ' +
            '  D.DET_CODEMP,                                                  ' +
            '  D.DET_CODFIS,                                                  ' +
            '  G.GER_CONSUM,                                                  ' +
            '  G.GER_IESCON,                                                  ' +
            '  D.DET_TIP_FC,                                                  ' +
            '  D.DET_CODITE,                                                  ' +
            '  D.DET_CLAFIS,                                                  ' +
            '  D.DET_CODFOR,                                                  ' +
            '  D.DET_CODCLI,                                                  ' +
            '  D.DET_ESTADO,                                                  ' +
            '  AUX_OPCDOC,                                                    ' +
            '  CADCLI.CLI_MICEMP,                                             ' +
            '  CADCLI.CLI_ZONFRA,                                             ' +
            '  CADCLI.CLI_DESPIS,                                             ' +
            '  CADCLI.CLI_ORGPUB,                                             ' +
            '  CADCLI.CLI_CALICM,                                             ' +
            '  AUXMOV.AUX_VENPRE,                                             ' +
            '  CIDEMP.CID_ESTADO AS CID_ESTADO_EMPRESA,                       ' +
            '  DET_ALQICM,                                                    ' +
            '  DET_BASICM,                                                    ' +
            '  DET_VALICM,                                                    ' +
            '  DET_PERBAS,                                                    ' +
            '  DET_TOTITE,                                                    ' +
            '  DET_DESESP,                                                    ' +
            '  DET_TOTFRE,                                                    ' +
            '  DET_DESACE,                                                    ' +
            '  DET_PERRED,                                                    ' +
            '  DET_DTAENT,                                                    ' +
            '  G.GER_ESTADO,                                                  ' +
            '  T.DET_PEBAST,                                                  ' +
            '  D.DET_TOTCUS,                                                  ' +
            '  T.DET_TOTULT,                                                  ' +
            '  T.DET_IMPULT,                                                  ' +
            '  T.DET_PFCPST,                                                  ' +
            '  T.DET_VFCPST,                                                  ' +
            '  D.DET_BASRET,                                                  ' +
            '  D.DET_VALRET,                                                  ' +
            '  D.DET_ALQRET,                                                  ' +
            '  T.DET_ICMORG,                                                  ' +
            '  G.GER_BASORG,                                                  ' +
            '  G.GER_ICMORG,                                                  ' +
            '  T.DET_ALQPIS,                                                  ' +
            '  T.DET_ALQCOF,                                                  ' +
            '  G.GER_ALQICM,                                                  ' +
            '  IF(T.DET_ICMORG > 0, ROUND((D.DET_TOTITE * (IF(((D.DET_PERBAS = 0) AND (T.DET_ICMORG > 0) AND (G.GER_BASORG > 0)), 100, D.DET_PERBAS))) / 100, 2), 0) AS BASORG_ITEM, ' +
            '  "N" AS CONFIRMACAO_DOCUMENTOS                                  ' +
            'FROM                                                             ' +
            '  MOVGER G                                                       ' +
            '  JOIN MOVDET D                                                  ' +
            '    ON D.DET_SEQGER = G.AUTOINCREM                               ' +
            '  INNER JOIN CADITE C                                            ' +
            '    ON C.ITE_CODITE = D.DET_CODITE                               ' +
            '  INNER JOIN ITEGER IG                                           ' +
            '    ON IG.ITE_CODITE = D.DET_CODITE AND                          ' +
            '       IG.ITE_CODEMP = DET_CODEMP                                ' +
            '  INNER JOIN CADCLI                                              ' +
            '    ON CLI_CODCLI = D.DET_CODCLI                                 ' +
            '  INNER JOIN CADEMP EMP                                          ' +
            '    ON EMP.EMP_CODEMP = DET_CODEMP                               ' +
            '  INNER JOIN CADCID CID                                          ' +
            '    ON CID.CID_CODCID = CADCLI.CLI_CODCID                        ' +
            '  INNER JOIN CADCID CIDEMP                                       ' +
            '    ON CIDEMP.CID_CODCID = EMP.EMP_CODCID                        ' +
            '  LEFT JOIN AUXMOV                                               ' +
            '    ON AUXMOV.AUX_SEQGER = D.DET_SEQGER                          ' +
            '  LEFT JOIN MOVTRI T  ON T.DET_SEQGER = D.AUTOINCREM             ' +
            '  WHERE G.GER_CODEMP = :CODEMP                                   ' +
//            '    AND G.GER_NUMDOC = "000000098447"                            ' +
//            '    AND D.DET_CODITE = "21411"                                   ' +
            '    AND G.GER_DTAENT BETWEEN :DTAINI                             ' +
            '    AND :DTAFIM                                                  ' +

            '  UNION                                                          ' +
            '  ALL                                                            ' +
            '  SELECT                                                         ' +
            '    D.DET_NUMDOC,                                                ' +
            '    D.DET_ESPDOC,                                                ' +
            '    D.DET_CODEMP,                                                ' +
            '    D.DET_CODFIS,                                                ' +
            '    G.GER_CONSUM,                                                ' +
            '    G.GER_IESCON,                                                ' +
            '    D.DET_TIP_FC,                                                ' +
            '    D.DET_CODITE,                                                ' +
            '    D.DET_CLAFIS,                                                ' +
            '    D.DET_CODFOR,                                                ' +
            '    D.DET_CODCLI,                                                ' +
            '    D.DET_ESTADO,                                                ' +
            '    CASE                                                         ' +
            '      WHEN (AUXNOT.AUX_OPCDOC = "11")                            ' +
            '      THEN "VN"                                                  ' +
            '      WHEN (AUXNOT.AUX_OPCDOC = "EX")                            ' +
            '      THEN "CP"                                                  ' +
            '      ELSE AUXNOT.AUX_OPCDOC                                     ' +
            '    END AUX_OPCDOC,                                              ' +
            '    CADCLI.CLI_MICEMP,                                           ' +
            '    CADCLI.CLI_ZONFRA,                                           ' +
            '    CADCLI.CLI_DESPIS,                                           ' +
            '    CADCLI.CLI_ORGPUB,                                           ' +
            '    CADCLI.CLI_CALICM,                                           ' +
            '    AUXNOT.AUX_VENPRE,                                           ' +
            '    CIDEMP.CID_ESTADO AS CID_ESTADO_EMPRESA,                     ' +
            '    DET_ALQICM,                                                  ' +
            '    DET_BASICM,                                                  ' +
            '    DET_VALICM,                                                  ' +
            '    DET_PERBAS,                                                  ' +
            '    DET_TOTITE,                                                  ' +
            '    DET_DESESP,                                                  ' +
            '    DET_TOTFRE,                                                  ' +
            '    DET_DESACE,                                                  ' +
            '    DET_PERRED,                                                  ' +
            '    DET_DTAENT,                                                  ' +
            '    G.GER_ESTADO,                                                ' +
            '    T.DET_PEBAST,                                                ' +
            '    D.DET_TOTCUS,                                                ' +
            '    T.DET_TOTULT,                                                ' +
            '    T.DET_IMPULT,                                                ' +
            '    T.DET_PFCPST,                                                ' +
            '    T.DET_VFCPST,                                                ' +
            '    D.DET_BASRET,                                                ' +
            '    D.DET_VALRET,                                                ' +
            '    D.DET_ALQRET,                                                ' +
            '    T.DET_ICMORG,                                                ' +
            '    G.GER_BASORG,                                                ' +
            '    G.GER_ICMORG,                                                ' +
            '    T.DET_ALQPIS,                                                ' +
            '    T.DET_ALQCOF,                                                ' +
            '    G.GER_ALQICM,                                                ' +
            '    IF(T.DET_ICMORG > 0, ROUND((D.DET_TOTITE * (IF(((D.DET_PERBAS = 0) AND (T.DET_ICMORG > 0) AND (G.GER_BASORG > 0)), 100, D.DET_PERBAS))) / 100, 2), 0) AS BASORG_ITEM, ' +
            '    "S" AS CONFIRMACAO_DOCUMENTOS                                ' +
            '  FROM                                                           ' +
            '    NOTGER G                                                     ' +
            '    JOIN NOTDET D                                                ' +
            '      ON D.DET_SEQGER = G.AUTOINCREM                             ' +
            '    INNER JOIN CADITE C                                          ' +
            '      ON C.ITE_CODITE = D.DET_CODITE                             ' +
            '    INNER JOIN ITEGER IG                                         ' +
            '      ON IG.ITE_CODITE = D.DET_CODITE AND                        ' +
            '         IG.ITE_CODEMP = DET_CODEMP                              ' +
            '    INNER JOIN CADCLI                                            ' +
            '      ON CLI_CODCLI = D.DET_CODCLI                               ' +
            '    INNER JOIN CADEMP EMP                                        ' +
            '      ON EMP.EMP_CODEMP = DET_CODEMP                             ' +
            '    INNER JOIN CADCID CID                                        ' +
            '      ON CID.CID_CODCID = CADCLI.CLI_CODCID                      ' +
            '    INNER JOIN CADCID CIDEMP                                     ' +
            '      ON CIDEMP.CID_CODCID = EMP.EMP_CODCID                      ' +
            '    LEFT JOIN AUXNOT                                             ' +
            '      ON AUXNOT.AUX_SEQGER = D.DET_SEQGER                        ' +
            '    LEFT JOIN NOTTRI T  ON T.DET_SEQGER = D.AUTOINCREM           ' +
            '  WHERE G.GER_CODEMP = :CODEMP                                   ' +
//            '    AND G.GER_NUMDOC = "000000098287"                            ' +
//            '    AND D.DET_CODITE = "21411"                                   ' +
            '    AND G.GER_DTAENT BETWEEN :DTAINI                             ' +
            '    AND :DTAFIM                                                  ';
end;

class function TConsultaIcmsOrgaoPublico.New: IConsulta;
begin
  Result := Self.Create;
end;

{ TGerarTesteIcmsOrgaoPublico }

constructor TGerarTesteIcmsOrgaoPublico.Create;
begin

end;

destructor TGerarTesteIcmsOrgaoPublico.Destroy;
begin

  inherited;
end;

function TGerarTesteIcmsOrgaoPublico.fGerarTesteIcmsOrgaoPublico(const ADados: OleVariant): Boolean;

  Const EspecieConfirmacao = 'CF_CI_CP_';

var
  LCasosTestesLog: ICasosTestesLog;
  LParametrosResultadoIcmsOrgaoPublico: IParametrosResultadoIcmsOrgaoPublico;
  LResultadoComparacao: TResultadoComparacao;
  LDados: TUniClientDataSet;
  LTrocaUFEndEntrega: String;
  LVendaPresencial: Boolean;
  LClienteEstadoBD: String;
  LDentroDoEstado: Boolean;
  LDentroDoEstadoFaturamento: Boolean;
  LSimplesNacional: Boolean;
//  LResultadoCalculoIcmsOrgaoPublico: IResultadoCalculoIcmsOrgaoPublico;
  LBaseDeIcmsDeOrgaoPublicoDoItem: Double;
//  LIsencaoDeIcmsVendasZonaFrancaProdutosNacionais: Boolean;
//  LAliquotaDeIcmsDoItem: Double;
  LPercentualDaBaseDeCalculoDoItem: Double;
//  LTotalDoItemReduzido: Double;
//  LBaseDeIcmsDeOrgaoPublicoConfirmacao: Double;
  //LValorDeIcmsDeOrgaoPublicoConfirmacao: Double;

  function fValorFreteDespAcessItem: Double; //Vamos ter que isolar ?
    var
      fltFreTmp: Double;
      fltDesTmp: Double;
  begin
    fltFreTmp := LDados.FieldByName('DET_TOTFRE').AsFloat; //arrMatItens[intIndice].fltValFre;
    fltDesTmp := LDados.FieldByName('DET_DESACE').AsFloat; //arrMatItens[intIndice].fltDesAce;

    If ((LDados.FieldByName('CLI_ORGPUB').AsString = 'S') Or (LDados.FieldByName('CLI_ZONFRA').AsString = 'S'))  And
       (Not LSimplesNacional) And
       (LDentroDoEstadoFaturamento)     Then
    Begin
      fltFreTmp := 0;
    End;

    If (LDados.FieldByName('AUX_OPCDOC').AsString = 'CO') Then
    Begin
      fltFreTmp := 0;
    End;

    Result := fltFreTmp + fltDesTmp;
  end;

  // Regra necessaria por conta
  function AtendeRegraConfirmacao: Boolean;
  begin
    Result := False; //((Pos(LDados.FieldByName('AUX_OPCDOC').AsString, EspecieConfirmacao) > 0) And (objCliente.ClienteOrgaoPublico) And (Not objCliente.CalcularDescontoIcmsOrgaoPublico));
  end;
begin
  Result := True;
  LParametrosResultadoIcmsOrgaoPublico := Nil;

  LSimplesNacional := fGetValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, varBoolean);
  //LIsencaoDeIcmsVendasZonaFrancaProdutosNacionais := fGetValorConfiguracao(CFG_ISENCAO_ICMS_VENDAS_ZONA_FRANCA_SOMENTE_PARA_PRODUTOS_NACIONAIS, varBoolean);

  LCasosTestesLog := TCasosTestesLog.New();
  LDados := TUniClientDataSet.Create(Nil);

  Try
    LDados.Data := ADados;
    LDados.Open;
    LDados.First;

    Try

      While Not LDados.Eof Do
      Begin
        if (ValidarPararProcessamento) then
          Break;

        frmModulo.IncrementarRegistrosProcessados;

        pExecutarProgresso(LDados.RecordCount, LDados.RecNo);

        LVendaPresencial := LDados.FieldByName('AUX_VENPRE').AsString = 'S';

        LClienteEstadoBD := LDados.FieldByName('CID_ESTADO_EMPRESA').AsString;

        LTrocaUFEndEntrega := LDados.FieldByName('DET_ESTADO').AsString;

        LDentroDoEstado :=
          TFunctionFuncoesFaturamento.fDentroDoEstado(LTrocaUFEndEntrega, LClienteEstadoBD);

        LDentroDoEstadoFaturamento :=
          TFunctionFuncoesFaturamento.
            fDentroDoEstadoFaturamento(LDentroDoEstado, LVendaPresencial);

        LPercentualDaBaseDeCalculoDoItem := LDados.FieldByName('DET_PERBAS').AsFloat;
        If (LDados.FieldByName('GER_BASORG').AsFloat > 0) And (LDados.FieldByName('DET_ICMORG').AsFloat > 0) And (LPercentualDaBaseDeCalculoDoItem = 0) Then
          LPercentualDaBaseDeCalculoDoItem := 100;

        LBaseDeIcmsDeOrgaoPublicoDoItem := 0;
        If (LPercentualDaBaseDeCalculoDoItem > 0) And (LDados.FieldByName('DET_ICMORG').AsFloat > 0) Then
          LBaseDeIcmsDeOrgaoPublicoDoItem := objFloatUtils.fFormataFloat((((LDados.FieldByName('DET_TOTITE').AsFloat + fValorFreteDespAcessItem) * LPercentualDaBaseDeCalculoDoItem) / 100), 2);

//        LAliquotaDeIcmsDoItem := LDados.FieldByName('DET_ALQICM').AsFloat;
        If (LDados.FieldByName('DET_ALQICM').AsFloat = 0) And (LDados.FieldByName('DET_ICMORG').AsFloat > 0) Then
        Begin
//          LTotalDoItemReduzido := objFloatUtils.fFormataFloat((LDados.FieldByName('DET_TOTITE').AsFloat * LPercentualDaBaseDeCalculoDoItem) / 100, 2);

//          If (LPercentualDaBaseDeCalculoDoItem > 0) And (LPercentualDaBaseDeCalculoDoItem < 100) Then
//            LAliquotaDeIcmsDoItem := (objFloatUtils.fFormataFloat(LDados.FieldByName('DET_ICMORG').AsFloat / LTotalDoItemReduzido, 2) * 100)
//          Else
//            LAliquotaDeIcmsDoItem := (objFloatUtils.fFormataFloat(LDados.FieldByName('DET_ICMORG').AsFloat / LDados.FieldByName('DET_TOTITE').AsFloat, 2) * 100);
        End;

        If (LDados.FieldByName('GER_BASORG').AsFloat <= 0) Then
          //LPercentualDaBaseDeCalculoDoItem := 0;

        If (LDados.FieldByName('DET_ICMORG').AsFloat <= 0) And (LDados.FieldByName('GER_BASORG').AsFloat > 0) Then
          //LPercentualDaBaseDeCalculoDoItem := 0;

        //LBaseDeIcmsDeOrgaoPublicoConfirmacao := 0;
        //LValorDeIcmsDeOrgaoPublicoConfirmacao := 0;
        If (LDados.FieldByName('CONFIRMACAO_DOCUMENTOS').AsString = 'S') And (LDados.FieldByName('GER_BASORG').AsFloat > 0) And (AtendeRegraConfirmacao) Then
        Begin
          //LBaseDeIcmsDeOrgaoPublicoConfirmacao := LDados.FieldByName('BASORG_ITEM').AsFloat;
          //LValorDeIcmsDeOrgaoPublicoConfirmacao := LDados.FieldByName('DET_DESESP').AsFloat;
        End;

        LParametrosResultadoIcmsOrgaoPublico :=
          TParametrosResultadoIcmsOrgaoPublico.New()
            .BaseDeIcmsDeOrgaoPublicoDoItem(LBaseDeIcmsDeOrgaoPublicoDoItem)
            .ValorDoIcmsDeOrgaoPublicoDoItem(LDados.FieldByName('DET_ICMORG').AsFloat);
//            .TotalDaBaseDeIcmsDeOrgaoPublico(LDados.FieldByName('BASORG_ITEM').AsFloat)
//            .AliquotaDeIcmsDoItem(LAliquotaDeIcmsDoItem)
//            .BaseDeCalculoDoIcmsDoItem(LDados.FieldByName('DET_BASICM').AsFloat)
//            .ValorDoIcmsDoItem(LDados.FieldByName('DET_VALICM').AsFloat);
            //.TotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao(LBaseDeIcmsDeOrgaoPublicoConfirmacao)
            //.TotalDoValorDeIcmsDeOrgaoPublicoConfirmacao(LValorDeIcmsDeOrgaoPublicoConfirmacao);


        {LResultadoCalculoIcmsOrgaoPublico :=
          CalcularValorIcmsOrgaoPublico(
            TParametrosCalculoIcmsOrgaoPublico.New
              .DentroDoEstado(LDentroDoEstadoFaturamento)
              .SubstituicaoTributariaDoItem(Pos(LDados.FieldByName('DET_CODFIS').AsString, objConstantes.fGetCstSubstituicao) > 0)
              .OpcaoDeDocumento(LDados.FieldByName('AUX_OPCDOC').AsString)
              .ValorTotalDoItem(LDados.FieldByName('DET_TOTITE').AsFloat)
              .AliquotaDoPis(0)
              .AliquotaDoCofins(0)
              .CodigoDaSituacaoTributaria(LDados.FieldByName('DET_CODFIS').AsString)
              .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(LIsencaoDeIcmsVendasZonaFrancaProdutosNacionais)
              .PercentualDaBaseDeCalculoDoItem(LPercentualDaBaseDeCalculoDoItem)
              .ValorFreteDespesasAcessoriasItem(fValorFreteDespAcessItem)
              .DescontoEspecialDoItem(LDados.FieldByName('DET_DESESP').AsFloat)
              .ValorDoIcmsDeOrgaoPublicoDoItem(0)
              .BaseDeIcmsDeOrgaoPublicoDoItem(0)
              .TotalDaBaseDeIcmsDeOrgaoPublico(0)
              .TotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao(0)
              .TotalDoValorDeIcmsDeOrgaoPublicoConfirmacao(0)
              .AliquotaDeIcmsDoItem(LAliquotaDeIcmsDoItem)
              .BaseDeCalculoDoIcmsDoItem(LDados.FieldByName('DET_BASICM').AsFloat)
              .ValorDoIcmsDoItem(LDados.FieldByName('DET_VALICM').AsFloat),
              LParametrosResultadoIcmsOrgaoPublico
            );}

        LResultadoComparacao := rcoFalse;

       { if ((LResultadoCalculoIcmsOrgaoPublico.BaseDeIcmsDeOrgaoPublicoDoItem = LBaseDeIcmsDeOrgaoPublicoDoItem) And
            (LResultadoCalculoIcmsOrgaoPublico.ValorDoIcmsDeOrgaoPublicoDoItem = LDados.FieldByName('DET_ICMORG').AsFloat) And
            (LResultadoCalculoIcmsOrgaoPublico.TotalDaBaseDeIcmsDeOrgaoPublico = LDados.FieldByName('BASORG_ITEM').AsFloat) And
            (LResultadoCalculoIcmsOrgaoPublico.AliquotaDeIcmsDoItem = LAliquotaDeIcmsDoItem) And
            (LResultadoCalculoIcmsOrgaoPublico.BaseDeCalculoDoIcmsDoItem = LDados.FieldByName('DET_BASICM').AsFloat) And
            (LResultadoCalculoIcmsOrgaoPublico.ValorDoIcmsDoItem = LDados.FieldByName('DET_VALICM').AsFloat) And
            (LResultadoCalculoIcmsOrgaoPublico.TotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao = LBaseDeIcmsDeOrgaoPublicoConfirmacao) And
            (LResultadoCalculoIcmsOrgaoPublico.TotalDoValorDeIcmsDeOrgaoPublicoConfirmacao = LValorDeIcmsDeOrgaoPublicoConfirmacao)) then
        begin
          LResultadoComparacao := rcoTrue;
        end;  }

        LCasosTestesLog.Add(
          TParametrosCasosTestesLog.New()
            .ResultadoComparacao(LResultadoComparacao)
            .RetornarNomeOperacao('CALCULO_ICMSORGAOPUBLICO')
            .NumeroDoDocumento(LDados.FieldByName('DET_NUMDOC').AsString)
            .EspecieDoDocumento(LDados.FieldByName('DET_ESPDOC').AsString)
            .CodigoDaEmpresa(LDados.FieldByName('DET_CODEMP').AsString)
            .CodigoDoItem(LDados.FieldByName('DET_CODITE').AsString)
            .CodigoDoCliente(LDados.FieldByName('DET_CODCLI').AsString)
            .OpcaoDocumento(LDados.FieldByName('AUX_OPCDOC').AsString)
            .DataEntrada(LDados.FieldByName('DET_DTAENT').AsDateTime)
            .CodigoFiscal(LDados.FieldByName('DET_CODFIS').AsString)
            .EstadoDoDocumento(LDados.FieldByName('DET_ESTADO').AsString)
            .Log(fGetVariavelLogIcmsOrgaoPublico));

        pLimparVariaveisTesteUnitario;

        LDados.Next;
      End;

      LCasosTestesLog.GerarLog('IcmsOrgaoPublico');

    Except
      On E : Exception do
        ShowMessage('Documento:'+ LDados.FieldByName('DET_NUMDOC').AsString +
                    '| Especie:'+ LDados.FieldByName('DET_ESPDOC').AsString +
                    '| Item:'+ LDados.FieldByName('DET_CODITE').AsString +
                    '| Empresa:'+ LDados.FieldByName('DET_CODEMP').AsString + #13#10 + E.Message);
    End;
  Finally
    FreeAndNil(LDados);
  End;
end;

class function TGerarTesteIcmsOrgaoPublico.New: IGerarTeste;
begin
  Result := Self.Create;
end;

end.
