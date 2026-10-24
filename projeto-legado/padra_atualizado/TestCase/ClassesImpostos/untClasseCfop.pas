unit untClasseCfop;

interface


uses
  Forms,
  untAbstractConsulta, untIConsulta, untAbstractGerarTeste, untIGerarTeste, Uni,
  Faturamento.Impostos.Interfaces.ClassificacaoItem, untFuncoes,
  Faturamento.Impostos.Tipos.ClassificacaoItem,
  Shared.Functions.Funcoes.Faturamento,
  Shared.Functions.Configuracoes,
  Shared.Functions.Constantes,
  Shared.Functions.Types,
  untFatRegrasImpostos,
  untCasosTestesLog,
  untCasosTestesLogImpl,
  System.SysUtils,
  System.StrUtils,
  Vcl.Dialogs,
  Faturamento.Impostos.Interfaces.ClassificacoesTransferencias,
  Faturamento.Impostos.Tipos.ClassificacoesTransferencias,
  Faturamento.Impostos.Tipos.Model,
  untICasosTestesLog,
  Faturamento.Impostos.Calculos.TesteUnitarioLog,
  Faturamento.Impostos.Interfaces.Model,
  UniClientDataSet, untTypes;



Type
  TConsultaCfop = class(TAbstractConsulta)
  private
    function RetornarSQLColuna_ITE_INDREV_PorEmpresa: string;
    function fCampoExiste(const strTabela, strCampo: String): Boolean;
  public
    Class function New : IConsulta;
    function fRetornarSQLCfop : String; override;
  end;

Type
  TGerarTesteCfop = class(TAbstractGerarTeste)
  private
    function ValidarItemBrinde(const AClassificacaoFiscalItem, AConfiguracaoClassificacaoBrinde: string): boolean;
    function ValidarClassificacaoFiscalRemessaGarantiaConserto(
      const AClassificacaoFiscalItem, ACfgClassificacaoRemessaGarantiaConserto: string): boolean;
    function RetornarEntradaOuSaida(const AClassificacaoFiscalItem: string): string;
    function RetornarOrigemPedido(const AOrigemPedido: string): string;
    function RetornarClassificacaoServico(
      const AClassificacaoFiscalItem: string): string;
    function RetornarEmpresaItem(const AEmpresaItemPedido,
      AEmpresaItemDocumento: string): string;
    function RetornarEmpresaClienteFilial(Const ACodigoCliente, AClientesFiliais: string): string;
    function RetornarEmpresaFornecedorFilial(const ACodigoFornecedor,
      AFornecedoresFiliais: string): string;
  public
    Class function New : IGerarTeste;

    Constructor Create;
    Destructor Destroy; override;

    function fGerarTesteCfop(const ADados: OleVariant): Boolean; override;
  end;

  Var QryAux : TUniQuery;

  function fEhSubstituicao(ACodigoSituacao : String) : Boolean;

  procedure pRetornaClassificacaoFiscal(const ADados: TUniClientDataSet; AValorConfiguracao : String;
    var AClassificacaoProduto, AClassificacaoProdutoSt : String);

  procedure pRetornarValoresTransferencias( ACodigoEmpresaTE : String; AEmpresaFilial  : String;
    Var AClaID1, AClaID2, AClaID3, AClaT01, AClaT02, AClaT03, ACSTT01, ACSTT02, ACSTT03 : String;
    const ACfgExibirCstReferenteTeCadastroEmpresas: Boolean);


  Function fRetClassificacaoNFEspSantos(AClassifItem: String) : TOpcItensNFespTinta;




implementation

uses
  untConfiguracoes, untModulo;

{ TConsultaCfop }


function fEhSubstituicao(ACodigoSituacao : String) : Boolean;
begin
  Result := (Pos(ACodigoSituacao, objConstantes.fGetCstSubstituicao) > 0);
end;

Function fRetClassificacaoNFEspSantos(AClassifItem : String) : TOpcItensNFespTinta;
begin

  Result := opcProdutoAcabado;

  If AClassifItem  = '1926' Then
  begin
    Result := opcBasesColorantesSemDestaqueImpostos;
    Exit;
  end;

  If AClassifItem  = '5926' Then
  begin
    Result := opcBasesColorantesComDestaqueImpostos;
    Exit;
  end;

end;

procedure pRetornaClassificacaoFiscal(const ADados : TUniClientDataSet;  AValorConfiguracao : String;
  var AClassificacaoProduto, AClassificacaoProdutoSt : String);
begin
  AClassificacaoProduto   := '';
  AClassificacaoProdutoSt := '';

  If (Pos(ADados.FieldByName('DET_CLAFIS').AsString, AValorConfiguracao) > 0) Then
  begin
    AClassificacaoProduto := ADados.FieldByName('DET_CLAFIS').AsString;

    If fEhSubstituicao(ADados.FieldByName('DET_CODFIS').AsString) Then
    begin
      AClassificacaoProdutoSt := ADados.FieldByName('DET_CLAFIS').AsString;
    end;

  end;
end;


procedure pRetornarValoresTransferencias(ACodigoEmpresaTE : String; AEmpresaFilial  : String;
  Var AClaID1, AClaID2, AClaID3, AClaT01, AClaT02, AClaT03, ACSTT01, ACSTT02, ACSTT03 : String;
  const ACfgExibirCstReferenteTeCadastroEmpresas: Boolean);
Var
  LRegraClassificacoesTransferencias    : IRegraImpostosClassificacoesTransferencias;
  LResultadoClassificacoesTransferencias: IResultadoRegraClassificacoesTransferencias;

  LClassificacoesTransferenciasSQL : String;

begin
  LRegraClassificacoesTransferencias := ClassificacoesTransferencias;
  LClassificacoesTransferenciasSQL := LRegraClassificacoesTransferencias.ClassificacoesTransferenciasSQL;

  QryAux.Close;
  QryAux.SQL.Clear;
  QryAux.SQL.Add(LClassificacoesTransferenciasSQL);

  QryAux.ParamByName('CODEMP').AsString := ACodigoEmpresaTE;
  QryAux.ParamByName('EMPDES').AsString := AEmpresaFilial;
  QryAux.Open;

  LResultadoClassificacoesTransferencias :=
    LRegraClassificacoesTransferencias.ClassificacoesTransferenciasRegra(
      TParametrosRegraClassificacoesTransferencias.New()
        .CodigoDaEmpresaTE(AEmpresaFilial)
        .CodigoDaEmpresaOrigemTE(ACodigoEmpresaTE)
        .CstTransfEstoqueEmpresa(ACfgExibirCstReferenteTeCadastroEmpresas)
        .TipoDeOperacao(QryAux.FieldByName('TIPOPE').AsString)
        .TransfDeEstoqueClassifIndustrializacaoTributado(QryAux.FieldByName('EMP_CLATI1').AsString)
        .TransfDeEstoqueClassifIndustrializacaoSubstCombustivelLubrificante(QryAux.FieldByName('EMP_CLATI2').AsString)
        .TransfDeEstoqueClassifIndustrializacaoSubstDemaisProdutos(QryAux.FieldByName('EMP_CLATI3').AsString)
        .TransfDeEstoqueClassifVendaTributado(QryAux.FieldByName('EMP_CLAT01').AsString)
        .TransfDeEstoqueClassifVendaSubstCombustivelLubrificante(QryAux.FieldByName('EMP_CLAT02').AsString)
        .TransfDeEstoqueClassifVendaSubstDemaisProdutos(QryAux.FieldByName('EMP_CLAT03').AsString)
        .TransfDeEstoqueCSTDeVendaTributado(QryAux.FieldByName('EMP_CSTT01').AsString)
        .TransfDeEstoqueCSTDeVendaSubstCombustivelLubrificante(QryAux.FieldByName('EMP_CSTT02').AsString)
        .TransfDeEstoqueCSTDeVendaSubstDemaisProdutos(QryAux.FieldByName('EMP_CSTT03').AsString)
        .TransfDeEstoqueClassifTransferenciaProdutosIndustrializacaoTributado(QryAux.FieldByName('EMP_CLTTI1').AsString)
        .TransfDeEstoqueClassifTransferenciaProdutosIndustrializacaoSubstCombustivelLubrificante(QryAux.FieldByName('EMP_CLTTI2').AsString)
        .TransfDeEstoqueClassifTransferenciaProdutosIndustrializacaoSubstDemaisProdutos(QryAux.FieldByName('EMP_CLTTI3').AsString)
        .TransfDeEstoqueClassifTransferenciaTributado(QryAux.FieldByName('EMP_CLATT1').AsString)
        .TransfDeEstoqueClassifTransferenciaSubstCombustivelLubrificante(QryAux.FieldByName('EMP_CLATT2').AsString)
        .TransfDeEstoqueClassifTransferenciaSubstDemaisProdutos(QryAux.FieldByName('EMP_CLATT3').AsString)
        .TransfDeEstoqueCSTDeTransferenciaTributado(QryAux.FieldByName('EMP_CSTTT1').AsString)
        .TransfDeEstoqueCSTDeTransferenciaSubstCombustivelLubrificante(QryAux.FieldByName('EMP_CSTTT2').AsString)
        .TransfDeEstoqueCSTDeTransferenciaSubstDemaisProdutos(QryAux.FieldByName('EMP_CSTTT3').AsString)
    );

  AClaID1 := LResultadoClassificacoesTransferencias.TransfDeEstoqueClassifIndustrializacaoOuTransferenciaProdutosIndustrializacaoTributado;
  AClaID2 := LResultadoClassificacoesTransferencias.TransfDeEstoqueClassifIndustrializacaoOuTransferenciaProdutosIndustrializacaoSubstCombustivelLubrificante;
  AClaID3 := LResultadoClassificacoesTransferencias.TransfDeEstoqueClassifIndustrializacaoOuTransferenciaProdutosIndustrializacaoSubstDemaisProdutos;

  AClaT01 := LResultadoClassificacoesTransferencias.TransfDeEstoqueClassifVendaOuTransferenciaTributado;
  AClaT02 := LResultadoClassificacoesTransferencias.TransfDeEstoqueClassifVendaOuTransferenciaSubstCombustivelLubrificante;
  AClaT03 := LResultadoClassificacoesTransferencias.TransfDeEstoqueClassifVendaOuTransferenciaSubstDemaisProdutos;

  ACSTT01 := LResultadoClassificacoesTransferencias.TransfDeEstoqueCSTDeVendaOuTransferenciaTributado;
  ACSTT02 := LResultadoClassificacoesTransferencias.TransfDeEstoqueCSTDeVendaOuTransferenciaSubstCombustivelLubrificante;
  ACSTT03 := LResultadoClassificacoesTransferencias.TransfDeEstoqueCSTDeVendaOuTransferenciaSubstDemaisProdutos;
end;

function TConsultaCfop.fRetornarSQLCfop: String;
begin
  Result := 'SELECT                                                           ' +
            '  D.DET_NUMDOC,                                                  ' +
            '  D.DET_ESPDOC,                                                  ' +
            '  D.DET_CODEMP,                                                  ' +
            '  D.DET_CODFIS,                                                  ' +
            '  G.GER_CONSUM,                                                  ' +
            '  G.GER_IESCON,                                                  ' +
            '  G.GER_CGCCPF,                                                  ' +
            '  D.DET_TIP_FC,                                                  ' +
            '  D.DET_CODITE,                                                  ' +
            '  D.DET_CLAFIS,                                                  ' +
            '  D.DET_CODFOR,                                                  ' +
            '  D.DET_CODCLI,                                                  ' +
            '  D.DET_ENTFUT,                                                  ' +
            '  D.DET_ESTADO,                                                  ' +
            '  D.DET_DTAENT,                                                  ' +
            '  "N" AS AUX_COMVAL,                                             ' +
            '  AUX_OPCDOC,                                                    ' +
            '  CADCLI.CLI_REGFIS,                                             ' +
            '  C.ITE_COMLUB,                                                  ' +
            '  C.ITE_IMPDIR,                                                  ' +
            '  CADCLI.CLI_CODATI,                                             ' +
            '  CADCLI.CLI_MICEMP,                                             ' +
            '  CADCLI.CLI_CODCID,                                             ' +
            '  CADCLI.CLI_ZONFRA,                                             ' +
            '  CADCLI.CLI_I_E_S_,                                             ' +
            '  CADCLI.CLI_PRORUR,                                             ' +
            '  CADCLI.CLI_IESUNI,                                             ' +
            '  CADCLI.CLI_DESPIS,                                             ' +
            '  CADCLI.CLI_ORGPUB,                                             ' +
            '  CADCLI.CLI_CALICM,                                             ' +
            '  ENTCLI.ETC_CIDENT,                                             ' +
            '  ENTCLI.AUTOINCREM AS SEQUENCIAL_ENDERECO,                      ' +
            '  AUXMOV.AUX_VENPRE,                                             ' +
            '  AUXMOV.AUX_CONEQU,                                             ' +
            '  D.DET_CODEMP AS FDO_EMPITE,                                    ' +
            '  IFNULL(FATGOR.FGO_ORIGEM, "AUTCOM") AS FGO_ORIGEM,             ' +
            '  FATGOR.FGO_TIPOPE,                                             ' +
            '  EXTGOR.FGO_EMP_TE,                                             ' +
            '  C.ITE_INDREV  AS ITE_INDREV_CADITE,                            ' +
               RetornarSQLColuna_ITE_INDREV_PorEmpresa                          +
            '  C.ITE_ITECCR,                                                  ' +
            '  CID.CID_ESTADO AS CID_ESTADO_CLIENTE,                          ' +
            '  CIDEMP.CID_ESTADO AS CID_ESTADO_EMPRESA                        ' +
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
            '  LEFT JOIN FATDOR                                               ' +
            '     ON FATDOR.FDO_NUMDOC = D.DET_NUM_PD                         ' +
            '    AND FATDOR.FDO_ESPDOC = D.DET_ESP_PD                         ' +
            '    AND FATDOR.FDO_CODEMP = D.DET_EMP_PD                         ' +
            '    AND FATDOR.FDO_CODITE = D.DET_CODITE                         ' +
            '  LEFT JOIN FATGOR                                               ' +
            '    ON FATGOR.AUTOINCREM = FATDOR.FDO_SEQGER                     ' +
            '  LEFT JOIN EXTGOR                                               ' +
            '    ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM                     ' +
            '  LEFT JOIN ENTCLI                                               ' +
            '    ON ETC_CODCLI = D.DET_CODCLI                                 ' +
            '    AND IF(                                                      ' +
            '      AUXMOV.AUX_ENTGER IS NOT NULL,                             ' +
            '      ENTCLI.AUTOINCREM = AUXMOV.AUX_ENTGER,                     ' +
            '      ETC_SEQIND =                                               ' +
            '      (SELECT                                                    ' +
            '        MIN(ETC_SEQIND)                                          ' +
            '      FROM                                                       ' +
            '        ENTCLI                                                   ' +
            '      WHERE ETC_CODCLI = CLI_CODCLI)                             ' +
            '    )                                                            ' +
            '  WHERE G.GER_CODEMP = :CODEMP                                   ' +
            '    AND G.GER_DTAENT BETWEEN :DTAINI                             ' +
            '    AND :DTAFIM                                                  ' +
            '    AND IFNULL(D.DET_CODFIS, "") <> ""                           ' +
            '    AND IFNULL(AUX_OPCDOC, "") <> ""                             ' +
            '    AND G.GER_ESPDOC IN ("NF", "EL", "IF", "DV", "FF", "TE","TR")' +
            '    AND D.DET_ORIDOC <> "D"                                      ' +
            '  UNION                                                          ' +
            '  ALL                                                            ' +
            '  SELECT                                                         ' +
            '    D.DET_NUMDOC,                                                ' +
            '    D.DET_ESPDOC,                                                ' +
            '    D.DET_CODEMP,                                                ' +
            '    D.DET_CODFIS,                                                ' +
            '    G.GER_CONSUM,                                                ' +
            '    G.GER_IESCON,                                                ' +
            '    G.GER_CGCCPF,                                                ' +
            '    D.DET_TIP_FC,                                                ' +
            '    D.DET_CODITE,                                                ' +
            '    D.DET_CLAFIS,                                                ' +
            '    D.DET_CODFOR,                                                ' +
            '    D.DET_CODCLI,                                                ' +
            '    D.DET_ENTFUT,                                                ' +
            '    D.DET_ESTADO,                                                ' +
            '    D.DET_DTAENT,                                                ' +
            '    AUXNOT.AUX_COMVAL,                                           ' +
            '    CASE                                                         ' +
            '      WHEN (AUXNOT.AUX_OPCDOC = "11")                            ' +
            '      THEN "VN"                                                  ' +
            '      WHEN (AUXNOT.AUX_OPCDOC = "EX")                            ' +
            '      THEN "CP"                                                  ' +
            '      ELSE AUXNOT.AUX_OPCDOC                                     ' +
            '    END AUX_OPCDOC,                                              ' +
            '    CADCLI.CLI_REGFIS,                                           ' +
            '    C.ITE_COMLUB,                                                ' +
            '    C.ITE_IMPDIR,                                                ' +
            '    CADCLI.CLI_CODATI,                                           ' +
            '    CADCLI.CLI_MICEMP,                                           ' +
            '    CADCLI.CLI_CODCID,                                           ' +
            '    CADCLI.CLI_ZONFRA,                                           ' +
            '    CADCLI.CLI_I_E_S_,                                           ' +
            '    CADCLI.CLI_PRORUR,                                           ' +
            '    CADCLI.CLI_IESUNI,                                           ' +
            '    CADCLI.CLI_DESPIS,                                           ' +
            '    CADCLI.CLI_ORGPUB,                                           ' +
            '    CADCLI.CLI_CALICM,                                           ' +
            '    ENTCLI.ETC_CIDENT,                                           ' +
            '    ENTCLI.AUTOINCREM AS SEQUENCIAL_ENDERECO,                    ' +
            '    AUXNOT.AUX_VENPRE,                                           ' +
            '    "N" AS AUX_CONEQU,                                           ' +
            '    DET_CODEMP AS FDO_EMPITE,                                    ' +
            '    "AUTCOM" AS FGO_ORIGEM,                                      ' +
            '    "V" AS FGO_TIPOPE,                                           ' +
            '    "" AS FGO_EMP_TE,                                            ' +
            '    C.ITE_INDREV  AS ITE_INDREV_CADITE,                          ' +
                 RetornarSQLColuna_ITE_INDREV_PorEmpresa                        +
            '    C.ITE_ITECCR,                                                ' +
            '    CID.CID_ESTADO AS CID_ESTADO_CLIENTE,                        ' +
            '    CIDEMP.CID_ESTADO AS CID_ESTADO_EMPRESA                      ' +
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
            '    LEFT JOIN ENTCLI                                             ' +
            '      ON ETC_CODCLI = D.DET_CODCLI                               ' +
            '      AND IF(                                                    ' +
            '        AUXNOT.AUX_ENTGER IS NOT NULL,                           ' +
            '        ENTCLI.AUTOINCREM = AUXNOT.AUX_ENTGER,                   ' +
            '        ETC_SEQIND =                                             ' +
            '        (SELECT                                                  ' +
            '          MIN(ETC_SEQIND)                                        ' +
            '        FROM                                                     ' +
            '          ENTCLI                                                 ' +
            '        WHERE ETC_CODCLI = CLI_CODCLI)                           ' +
            '      )                                                          ' +
            '  WHERE G.GER_CODEMP = :CODEMP                                   ' +
            '    AND G.GER_DTAENT BETWEEN :DTAINI                             ' +
            '    AND :DTAFIM                                                  ' +
            '    AND IFNULL(D.DET_CODFIS, "") <> ""                           ' +
            '    AND IFNULL(AUX_OPCDOC, "") <> ""                             ' +
            '    AND G.GER_ESPDOC IN ("NF", "EL", "IF", "DV", "FF", "TE","TR")' +
            '    AND D.DET_ORIDOC <> "D"                                      ' +
            '    AND AUXNOT.AUX_OPCDOC <> "NE"                                ' ;
end;

class function TConsultaCfop.New: IConsulta;
begin
  Result := Self.Create;

end;

{ TGerarTesteCfop }

constructor TGerarTesteCfop.Create;
begin
  QryAux := fCriaQuery;
end;

destructor TGerarTesteCfop.Destroy;
begin
  If Assigned(QryAux) Then
    FreeAndNil(QryAux);

  inherited;
end;

function TGerarTesteCfop.fGerarTesteCfop(const ADados: OleVariant): Boolean;
Var
  LCodEmpresa            : String;
  LCodigoAtividadeBD     : String;
  LCodigoAtividade       : String;

  LEmpresaTE             : String;

  LCodigoClienteFilial   : String;
  LRetornaClienteFilial  : String;
  LEhClienteFilial       : Boolean;

  LCodigoFornecedorFilial: String;
  LIndustrializacaoRevendaGeral: String;

  LIndustrializacaoRevendaDaEmpresa: String;
  LCodigoDoItem          : String;
  LProdutoConcreto       : String;
  LEhItemEstrutura       : Boolean;

  LCount                 : Integer;
  LItemConcreto          : Boolean;

  LEmpresaItem           : String;
  LOrigem                : String;
  LPedidoRemessaGarantia : Boolean;
  LEntradaOuSaida        : String;

  LSimplesRemessaConcretoDadosCliente: Boolean;
  LDesmembrarNotaProdutosServicos    : Boolean;

  LClassificacaoServico : String;
  LTipoDeEmprestimo     : String;

  LClassifFiscalRecebimentoGarantia   : String;
  LClassifFiscalRecebimentoGarantiaST : String;

  LClassiFiscalEnvioGarantia : String;
  LClassiFiscalEnvioGarantiaST : String;

  // Variáveis DentroDoEstado
  LDocumentoParaFornecedor    : Boolean;
  //LAtendeRegraFiscalEndEntrega: Boolean;
  LAtividadeConstrutora       : Boolean;
  LTrocaUFEndEntrega          : String;
  //LEstadoEntrega              : String;
  LDentroDoEstado             : Boolean;
  LVendaPresencial            : Boolean;
  LDentroDoEstadoFaturamento  : Boolean;

  LAtendeRegraDifal               : Boolean;

  // Proprietário Rural
  LProdutorRuralBD : String;
  LEhProdutorRural : Boolean;

  // IESUNI
  LInscricaoEstadual : String;
  LRetornaIesUni     : String;

  // Classificação de transferencias
  LClaID1 : String;
  LClaID2 : String;
  LClaID3 : String;

  LClaT01 : String;
  LClaT02 : String;
  LClaT03 : String;

  LCSTT01 : String;
  LCSTT02 : String;
  LCSTT03 : String;

  LNotaEEspecialFornecedor : Boolean;

  LClienteEstadoBD : String;
  LNomeEstado : String;

  LResultadoComparacao : TResultadoComparacao;

  LResultadoRegraClassificacaoItem: IResultadoRegraClassificacaoItem;
  LCasosTestesLog: ICasosTestesLog;
  LTipoAbfCliente : String;
  LBrindeDoItem: boolean;
  LCfgBrinde: string;
  LCfgProcedimentoImpressaoNF: string;
  LCfgClafissicacaoRemessaGarantiaConserto: string;
  LCfgDefinirConsumoOuRevendaVendas: boolean;
  LCfgClassificacaoReposicaoGarantiaCliente: string;
  LCfgClassificacaoEnvioMercadoriaConsertoGarantia: string;
  LCfgExibirCstReferenteTeCadastroEmpresas: boolean;
  LClientesFiliais: string;
  LFornecedoresFiliais: string;
  
  LClientesFilialDaEmpresaDoDocumento: string;
  LFornecedoresFilialDaEmpresaDoDocumento: string;

  LDados: TUniClientDataSet;

  LParametrosClienteConsumidor: IParametrosFaturamentoImpostosClienteConsumidor;

  function fGetTipoAbfCliente(const strCodCli: String; strConsum: String =''): String;
    Var
      qryCliente: TUniQuery;
  begin
    qryCliente := fCriaQuery;

    qryCliente.SQL.Text := TFunctionFuncoesFaturamento.fGetSelectTipoAbfCliente;
    qryCliente.ParamByName('CODCLI').AsString := strCodCli;
    qryCliente.Open;


    Result :=
      TFunctionFuncoesFaturamento.
        fGetTipoAbfCliente(strCodCli, qryCliente.FieldByName('FISJUR').AsString,
          qryCliente.FieldByName('I_E_S_').AsString, IIF(fEmptyStr(strConsum),
          qryCliente.FieldByName('CONSUM').AsString, strConsum), qryCliente.FieldByName('CODATI').AsString,
          qryCliente.FieldByName('PRORUR').AsString, qryCliente.FieldByName('MICEMP').AsString,
          qryCliente.FieldByName('REGTRI').AsString, '', qryCliente.FieldByName('INDUST').AsString,
          LCodigoClienteFilial, LAtividadeConstrutora);

    FreeAndNil(qryCliente);
  end;

  procedure pInicializarObjetoCliente(const ADados: TUniClientDataSet);
  begin
    LParametrosClienteConsumidor :=
      TParametrosFaturamentoImpostosClienteConsumidor.New
        .ClienteEstado(ADados.FieldByName('DET_ESTADO').AsString)
        .ClienteInscricaoEstadual(ADados.FieldByName('GER_IESCON').AsString)
        .ClienteAtividade(LDados.FieldByName('CLI_CODATI').AsString)
        .CalcularDescontoIcmsOrgaoPublico(ADados.FieldByName('CLI_CALICM').AsString = 'S')
        .ClienteFisicoOuJuridico(TFunctionFuncoesFaturamento.RetornarClienteFisicoOuJuridico(ADados.FieldByName('GER_CGCCPF').AsInteger));
  end;

begin
  Result := true;

  LCasosTestesLog := TCasosTestesLog.New();
  LCfgBrinde := fGetValorConfiguracao(CFG_CLAFIS_BRINDE);
  LCfgProcedimentoImpressaoNF := fGetValorConfiguracao(CFG_PROCEDIMENTO_IMPRESSAO_NOTA_FISCAL);
  LCfgClafissicacaoRemessaGarantiaConserto := fGetValorConfiguracao(CFG_CLAFIS_REMESSA_GARANTIA_CONSERTO);
  LCfgDefinirConsumoOuRevendaVendas := fGetValorConfiguracao(CFG_DEFINIR_CONSUMO_OU_REVENDA_VENDAS,VarBoolean);
  LCfgClassificacaoReposicaoGarantiaCliente := fGetValorConfiguracao(CFG_CLASSIF_REPOSICAO_GARANTIA_CLIENTE);
  LCfgClassificacaoEnvioMercadoriaConsertoGarantia := fGetValorConfiguracao(CFG_CLASSIF_ENVIO_MERCADORIA_CONSERTO_GARANTIA);
  LCfgExibirCstReferenteTeCadastroEmpresas := fGetValorConfiguracao(CFG_EXIBIR_CST_REFERENTE_TE_CADASTRO_EMPRESAS, varBoolean);
  LClientesFiliais := fCampoTabela('GROUP_CONCAT(EMP_CLIFIL)', 'CADEMP', [], [], False, '', Nil);
  LFornecedoresFiliais := fCampoTabela('GROUP_CONCAT(EMP_FORFIL)', 'CADEMP', [], [], False, '', Nil);

  LDados := TUniClientDataSet.Create(Nil);

  try
    LDados.Data := ADados;
    LDados.Open;
    LDados.First;

    LClientesFilialDaEmpresaDoDocumento := fCampoTabela('EMP_CLIFIL', 'CADEMP', ['EMP_CODEMP'], [LDados.FieldByName('DET_CODEMP').AsString], False, '', Nil);
    LFornecedoresFilialDaEmpresaDoDocumento := fCampoTabela('EMP_FORFIL', 'CADEMP', ['EMP_CODEMP'], [LDados.FieldByName('DET_CODEMP').AsString], False, '', Nil);

    Try
      While not LDados.Eof Do
      Begin
        if (ValidarPararProcessamento) then
          Break;

        frmModulo.IncrementarRegistrosProcessados;

        pExecutarProgresso(LDados.RecordCount, LDados.RecNo);

        LCodEmpresa := LDados.FieldByName('DET_CODEMP').AsString;

        // Classificação Fiscal de Garantia
        pRetornaClassificacaoFiscal(LDados, LCfgClassificacaoReposicaoGarantiaCliente,
          LClassifFiscalRecebimentoGarantia, LClassifFiscalRecebimentoGarantiaST);

        pRetornaClassificacaoFiscal( LDados, LCfgClassificacaoEnvioMercadoriaConsertoGarantia,
          LClassiFiscalEnvioGarantia, LClassiFiscalEnvioGarantiaST);


        // fAtividadeConstrutora
        LCodigoAtividade := LDados.FieldByName('CLI_CODATI').AsString;

        LCodigoAtividadeBD :=
            fCampoTabela('ATI_CODATI', 'CLIATI', ['ATI_CODATI', 'ATI_CODEMP'], [LCodigoAtividade, LCodEmpresa], False);

        LAtividadeConstrutora :=
          TFunctionFuncoesFaturamento.
            fAtividadeConstrutora(LCodigoAtividade,
                                  LCodigoAtividadeBD);

        LCodigoClienteFilial    := RetornarEmpresaClienteFilial(LDados.FieldByName('DET_CODCLI').AsString, LClientesFiliais);
        LCodigoFornecedorFilial := RetornarEmpresaFornecedorFilial(LDados.FieldByName('DET_CODFOR').AsString, LFornecedoresFiliais);;

        LRetornaClienteFilial :=
          TFunctionFuncoesFaturamento.
            fRetornaClienteFilial(LCodEmpresa,
                                  LClientesFilialDaEmpresaDoDocumento,
                                  LFornecedoresFilialDaEmpresaDoDocumento,
                                  LDados.FieldByName('DET_TIP_FC').AsString);

        // fItemRevInd
        LCodigoDoItem := LDados.FieldByName('DET_CODITE').AsString;

        LIndustrializacaoRevendaGeral     := LDados.FieldByName('ITE_INDREV_CADITE').AsString;
        LIndustrializacaoRevendaDaEmpresa := LDados.FieldByName('ITE_INDREV_ITEGER').AsString;

        LCount := fCampoTabela('COUNT(*)', 'GERMAT', ['GMT_CODITE'], [LCodigoDoItem], False);

        LEhItemEstrutura := TFunctionFuncoesFaturamento.fItemEstrutura(LCount);

        LProdutoConcreto := LDados.FieldByName('ITE_ITECCR').AsString;

        LEmpresaItem := RetornarEmpresaItem(LDados.FieldByName('FDO_EMPITE').AsString, LDados.FieldByName('DET_CODEMP').AsString);

        LItemConcreto :=
          TFunctionFuncoesFaturamento.
            fItemConcreto(LEhItemEstrutura,
                          LEmpresaItem,
                          LProdutoConcreto);

        LSimplesRemessaConcretoDadosCliente :=
          (LCfgProcedimentoImpressaoNF = CONCREMASSA);

        // Origem
        LOrigem := RetornarOrigemPedido(LDados.FieldByName('FGO_ORIGEM').AsString);

        // PedidoDeRemessaParaGarantia(blnPedRemGar)
        LPedidoRemessaGarantia := ValidarClassificacaoFiscalRemessaGarantiaConserto(LDados.FieldByName('DET_CLAFIS').AsString, LCfgClafissicacaoRemessaGarantiaConserto);

        // Entrada Ou Saida
        LEntradaOuSaida := RetornarEntradaOuSaida(LDados.FieldByName('DET_CLAFIS').AsString);

        // blnDesmembrarNotaProdutosServicos
        LDesmembrarNotaProdutosServicos := Not ((Pos(LDados.FieldByName('AUX_OPCDOC').AsString, ENTRADA_FORNECEDOR) > 0) Or
                                                (Pos(LDados.FieldByName('AUX_OPCDOC').AsString, OUTRAS_SAIDAS_FORNECEDOR) > 0));


        LTipoDeEmprestimo := RetornarEntradaOuSaida(LDados.FieldByName('DET_CLAFIS').AsString);
        LClassificacaoServico := RetornarClassificacaoServico(LDados.FieldByName('DET_CLAFIS').AsString);

        LNotaEEspecialFornecedor :=
          ((LDados.FieldByName('AUX_OPCDOC').AsString = 'NE') And
            (LDados.FieldByName('DET_TIP_FC').AsString = 'F'));

        // DentroDoEstadoCfop
        LDocumentoParaFornecedor :=
          TFunctionFuncoesFaturamento.
            fDocumentoParaFornecedor(LDados.FieldByName('AUX_OPCDOC').AsString,
                                     LDados.FieldByName('AUX_OPCDOC').AsString = 'OF', // blnNCFornecedor
                                     LNotaEEspecialFornecedor,
                                     LDados.FieldByName('AUX_OPCDOC').AsString = 'IN',
                                     LDados.FieldByName('DET_CODCLI').AsString,
                                     LDados.FieldByName('DET_CODFOR').AsString);


        LNomeEstado := LDados.FieldByName('CID_ESTADO_CLIENTE').AsString;
        LTrocaUFEndEntrega := LDados.FieldByName('DET_ESTADO').AsString;

        LVendaPresencial := (LDados.FieldByName('AUX_VENPRE').AsString =  'S');


        LClienteEstadoBD := LDados.FieldByName('CID_ESTADO_EMPRESA').AsString;

        LDentroDoEstado :=
          TFunctionFuncoesFaturamento.fDentroDoEstado(LTrocaUFEndEntrega, LClienteEstadoBD);

        LDentroDoEstadoFaturamento :=
          TFunctionFuncoesFaturamento.
            fDentroDoEstadoFaturamento(LDentroDoEstado, LVendaPresencial);

        // Produtor Rural
        LProdutorRuralBD := LDados.FieldByName('CLI_PRORUR').AsString;
        LEhProdutorRural := TFunctionFuncoesFaturamento.fEhProdutorRural(LProdutorRuralBD);

        //Inscrição Estadual
        LInscricaoEstadual := LDados.FieldByName('CLI_IESUNI').AsString;

        LRetornaIesUni := TFunctionFuncoesFaturamento.fRetornaIesUni(LInscricaoEstadual);

        LTipoAbfCliente := fGetTipoAbfCliente(LDados.FieldByName('DET_CODCLI').AsString);

        LEhClienteFilial := ValidarClienteFilial(LDados.FieldByName('DET_CODCLI').AsString, LClientesFiliais);

        LAtendeRegraDifal :=
          TFunctionFuncoesFaturamento.
            fAtendeRegrasDifal(LDados.FieldByName('GER_IESCON').AsString,
                               false,
                               LDados.FieldByName('GER_CONSUM').AsString = 'S',
                               LDocumentoParaFornecedor,
                               LDentroDoEstadoFaturamento,
                               LEhClienteFilial,
                               LDados.FieldByName('AUX_OPCDOC').AsString,
                               LEhProdutorRural,
                               LRetornaIesUni,
                               LAtividadeConstrutora,
                               fGetTipoAbfCliente(
                                 LDados.FieldByName('DET_CODCLI').AsString,
                                   IIF(LCfgDefinirConsumoOuRevendaVendas,
                                     LDados.FieldByName('GER_CONSUM').AsString, ''))); //fGetTipoAbfCliente

        LEmpresaTE :=
          IIF(fEmptyStr(LDados.FieldByName('FGO_EMP_TE').AsString),
            LDados.FieldByName('DET_CODEMP').AsString,
              LDados.FieldByName('FGO_EMP_TE').AsString);

        pRetornarValoresTransferencias(LEmpresaTE, LCodigoClienteFilial , LClaID1, LClaID2, LClaID3, LClaT01, LClaT02, LClaT03, LCSTT01, LCSTT02, LCSTT03,
          LCfgExibirCstReferenteTeCadastroEmpresas);

        LBrindeDoItem := ValidarItemBrinde(LDados.FieldByName('DET_CLAFIS').AsString, LCfgBrinde);

        pInicializarObjetoCliente(LDados);

        LResultadoRegraClassificacaoItem :=
          ClassificacaoDoItem(
            TParametrosRegraClassificacaoItem.New
              .ClassificacaoDoItem(LDados.FieldByName('DET_CLAFIS').AsString)
              .ClassificacaoDeServico(LClassificacaoServico)
              .CodigoDaSubstituicaoTributariaDoItem(LDados.FieldByName('DET_CODFIS').AsString)
              .FatGorOrigem(LOrigem)
              .OpcaoDeDocumento(LDados.FieldByName('AUX_OPCDOC').AsString)
              .EspecieDoDocumento(LDados.FieldByName('DET_ESPDOC').AsString)
              .TipoDeEmprestimo(LTipoDeEmprestimo)
              .ClassificacaoFiscalDoItem(LDados.FieldByName('DET_CLAFIS').AsString)
              .IndustrializacaoOuRevenda(TFunctionFuncoesFaturamento.fItemRevInd(LIndustrializacaoRevendaGeral, LIndustrializacaoRevendaDaEmpresa))
              .ClassificacaoDeVendaTributadoTransferencia(LClaT01)
              .ClassificacaoDeIndustrializacaoTributadotransferencia(LClaID1)
              .CSTDeVendaTributadoTransferencia(LCSTT01)
              .ClassificacaoDeVendaSubstCombustivelELubrificanteTransferencia(LClaT02)
              .ClassificacaoDeIndustrializacaoSubstCombustivelELubrificanteTransferencia(LClaID2)
              .CSTDeVendaSubstCombustivelELubrificanteTransferencia(LCSTT02)
              .ClassificacaoDeVendaSubstDemaisProdutosTransferencia(LClaT03)
              .ClassificacaoDeIndustrializacaoSubstDemaisProdutosTransferencia(LClaID3)
              .CSTDeVendaSubstDemaisTransferencia(LCSTT03)
              .EntregaFuturaDoItem(LDados.FieldByName('DET_ENTFUT').AsString = 'S')
              .BaixaDeEntregaFutura(LDados.FieldByName('AUX_OPCDOC').AsString = 'BF')
              .CombustivelLubrificanteDoItem(LDados.FieldByName('ITE_COMLUB').AsString = 'S')
              .ImportacaoDiretaDoItem(LDados.FieldByName('ITE_IMPDIR').AsString = 'S')
              .AtividadeConstrutora(LAtividadeConstrutora)
              .AtendeRegrasDifal(LAtendeRegraDifal)
              .VendaPresencial(LVendaPresencial)
              .PedidoDeRemessaParaGarantia(LPedidoRemessaGarantia)
              .BrindeDoItem(LBrindeDoItem)
              .TipoDeOperacaoDoPedidoDeVenda(LDados.FieldByName('FGO_TIPOPE').AsString)
              .CodigoDoItem(LDados.FieldByName('DET_CODITE').AsString)
              .DesmembrarNotaProdutosServicos(LDesmembrarNotaProdutosServicos)
              .ClassificacaoFiscalEnvioGarantia(LClassiFiscalEnvioGarantia)
              .ClassificacaoFiscalEnvioGarantiaST(LClassiFiscalEnvioGarantiaST)
              .DocumentoDeComplementoDeValores(LDados.FieldByName('AUX_COMVAL').AsString = 'S')
              .OpcaoItensNFespTinta(fRetClassificacaoNFEspSantos(LDados.FieldByName('DET_CLAFIS').AsString))
              .RetornaClienteFilial(LRetornaClienteFilial)
              .EntradaOuSaidaDoItem(LEntradaOuSaida)
              .NotaDeImportacao(LDados.FieldByName('AUX_OPCDOC').AsString = 'IN' )
              .ConsertoDeEquipamento(LDados.FieldByName('AUX_CONEQU').AsString = 'S' )
              .ClassificacaoFiscalRecebimentoGarantia(LClassifFiscalRecebimentoGarantia)
              .ClassificacaoFiscalRecebimentoGarantiaST(LClassifFiscalRecebimentoGarantiaSt)
              .CodigoDaEmpresa(LCodEmpresa)
              .DentroDoEstado(LDentroDoEstadoFaturamento)
              .TipoDaAbreviacaoFiscal(LTipoAbfCliente)
              .ItemConcreto(LItemConcreto)
              .SimplesRemessaConcretoDadosCliente(LSimplesRemessaConcretoDadosCliente)
              .TaxaBombeamentoPedidoOrcamento(false)

              .ClienteCodigo(LDados.FieldByName('DET_CODCLI').AsString)
              .SequencialEnderecoEntrega(LDados.FieldByName('SEQUENCIAL_ENDERECO').AsString)
              .ClienteConsumidorFinal(LDados.FieldByName('GER_CONSUM').AsString = 'S')
              .ParametrosClienteConsumidor(LParametrosClienteConsumidor)
              .ClienteFilial(LEhClienteFilial)
              .GerandoCasosTestes(True)

              );

        LResultadoComparacao := rcoFalse;

        if (LResultadoRegraClassificacaoItem.ClassificacaoDoItem = LDados.FieldByName('DET_CLAFIS').AsString) then
        begin
          LResultadoComparacao := rcoTrue;
        end;

        LCasosTestesLog.Add(
          TParametrosCasosTestesLog.New()
            .ResultadoComparacao(LResultadoComparacao)
            .RetornarNomeOperacao('REGRA_CFOP_')
            .NumeroDoDocumento(LDados.FieldByName('DET_NUMDOC').AsString)
            .EspecieDoDocumento(LDados.FieldByName('DET_ESPDOC').AsString)
            .CodigoDaEmpresa(LDados.FieldByName('DET_CODEMP').AsString)
            .CodigoDoItem(LDados.FieldByName('DET_CODITE').AsString)
            .CodigoDoCliente(LDados.FieldByName('DET_CODCLI').AsString)
            .OpcaoDocumento(LDados.FieldByName('AUX_OPCDOC').AsString)
            .DataEntrada(LDados.FieldByName('DET_DTAENT').AsDateTime)
            .CodigoFiscal(LDados.FieldByName('DET_CODFIS').AsString)
            .EstadoDoDocumento(LDados.FieldByName('DET_ESTADO').AsString)
            .Log(fGetVariavelLogCfop));

        pLimparVariaveisTesteUnitario;


        LDados.Next;
      End;

      LCasosTestesLog.GerarLog('Cfop');

    Except
        On E : Exception do
         ShowMessage('Documento:'+ LDados.FieldByName('DET_NUMDOC').AsString +
                    '| Especie:'+ LDados.FieldByName('DET_ESPDOC').AsString +
                    '| Item:'+ LDados.FieldByName('DET_CODITE').AsString +
                    '| Empresa:'+ LDados.FieldByName('DET_CODEMP').AsString + #13#10 + E.Message);

    End;
  Finally
    FreeAndNil(LDados);
  end;
end;

function TGerarTesteCfop.ValidarItemBrinde(const AClassificacaoFiscalItem, AConfiguracaoClassificacaoBrinde: string): boolean;
var
  LClassificacaoFiscalItem: string;
begin
  LClassificacaoFiscalItem := RightStr(AClassificacaoFiscalItem, 3);
  result := Pos(LClassificacaoFiscalItem, AConfiguracaoClassificacaoBrinde) > 0;
end;

function TGerarTesteCfop.ValidarClassificacaoFiscalRemessaGarantiaConserto(const AClassificacaoFiscalItem,
  ACfgClassificacaoRemessaGarantiaConserto: string): boolean;
var
  LClassificacaoFiscalItem: string;
begin
  LClassificacaoFiscalItem := RightStr(AClassificacaoFiscalItem, 3);
  result := Pos(LClassificacaoFiscalItem, ACfgClassificacaoRemessaGarantiaConserto) > 0;
end;

function TGerarTesteCfop.RetornarEntradaOuSaida(const AClassificacaoFiscalItem: string): string;
begin
  result := 'E';

  If LeftStr(AClassificacaoFiscalItem, 1) >= '5' Then
    result := 'S';
end;

function TGerarTesteCfop.RetornarOrigemPedido(const AOrigemPedido: string): string;
begin
  result := 'AUTCOM';

  If Not fEmptyStr(AOrigemPedido) Then
    result := AOrigemPedido;
end;

function TGerarTesteCfop.RetornarClassificacaoServico(const AClassificacaoFiscalItem: string): string;
begin
  result := EmptyStr;

  If RightStr(AClassificacaoFiscalItem, 3) = '933' Then
    result := AClassificacaoFiscalItem;
end;

function TGerarTesteCfop.RetornarEmpresaItem(const AEmpresaItemPedido, AEmpresaItemDocumento: string): string;
begin
  result := AEmpresaItemPedido;

  If fEmptyStr(AEmpresaItemPedido) Then
    result := AEmpresaItemDocumento;
end;

function TGerarTesteCfop.RetornarEmpresaClienteFilial(Const ACodigoCliente, AClientesFiliais: string): string;
begin
  result := EmptyStr;

  if (fEmptyStr(ACodigoCliente)) then
    Exit;

  if (Pos(ACodigoCliente, AClientesFiliais)) <= 0 Then
    Exit;

  result := fCampoTabela('EMP_CODEMP', 'CADEMP', ['EMP_CLIFIL'], [ACodigoCliente], False);
end;

function TGerarTesteCfop.RetornarEmpresaFornecedorFilial(Const ACodigoFornecedor, AFornecedoresFiliais: string): string;
begin
  result := EmptyStr;

  if (fEmptyStr(ACodigoFornecedor)) then
    Exit;

  if (Pos(ACodigoFornecedor, AFornecedoresFiliais)) <= 0 Then
    Exit;

  result := fCampoTabela('EMP_CODEMP', 'CADEMP', ['EMP_FORFIL'], [ACodigoFornecedor], False);
end;


function TConsultaCfop.fCampoExiste(const strTabela, strCampo: String): Boolean;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  qryAux.SQL.Add('DESC ' + strTabela);
  qryAux.Open;

  Result := False;
  While (Not qryAux.Eof) Do
  Begin
    If qryAux.FieldByName('Field').AsString = strCampo Then
    Begin
      Result := True;
      Break;
    End;

    qryAux.Next;
  End;

  FreeAndNil(qryAux);
end;

function TConsultaCfop.RetornarSQLColuna_ITE_INDREV_PorEmpresa: string;
begin
  result := '  C.ITE_INDREV AS ITE_INDREV_ITEGER, ';

  if (fCampoExiste('ITEGER', 'ITE_INDREV')) then
    result := '  IG.ITE_INDREV AS ITE_INDREV_ITEGER, ';
end;

class function TGerarTesteCfop.New: IGerarTeste;
begin
  Result := Self.Create;
end;

end.

