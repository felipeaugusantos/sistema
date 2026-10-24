unit untLibCartoesCfgRepositorio;

interface

Uses System.SysUtils, System.Classes, Vcl.Forms, System.Generics.Collections,

     cxEdit, cxRadioGroup, cxEditRepositoryItems, cxCurrencyEdit, Uni,
     UniCLientDataset,

     untILibCartoesFactory, untILibCartoesWrapper, untLibCartoesInterfacesTipos,
     untLibCartoesTiposCompartilhados, untTLibCartoesFuncoes;

Type
  TLibCartoesCfgRepositorio = class
  private
    class function fInc(Var intValor: Integer) : Integer;

    class function ConfiguracoesForamMapeadas(AOperadora: String): Boolean;

    class procedure CarregaPropriedadesInterna(ACodigoConfiguracao: String;
                                               var AProperties: Pointer;
                                               var AIndiceCfg: Integer;
                                               var ACfgRepositorio: Pointer;
                                               ATipoConfiguracao: TTipoConfiguracao);

    class procedure CarregaPropriedadesConfiguracoesRedeCard(ACodigoConfiguracao: String;
                                                             var AProperty: Pointer;
                                                             var AIndiceCfg: Integer;
                                                             var ACfgRepositorio: Pointer);
    class procedure CarregaPropriedadesConfiguracoesMercadoLivre(ACodigoConfiguracao: String;
                                                                 var AProperty: Pointer;
                                                                 var AIndiceCfg: Integer;
                                                                 var ACfgRepositorio: Pointer);
    class procedure CarregaPropriedadesConfiguracoesSipag(ACodigoConfiguracao: String;
                                                          var AProperty: Pointer;
                                                          var AIndiceCfg: Integer;
                                                          var ACfgRepositorio: Pointer);
    class procedure CarregaPropriedadesConfiguracoesYapay(ACodigoConfiguracao: String;
                                                          var AProperty: Pointer;
                                                          var AIndiceCfg: Integer;
                                                          var ACfgRepositorio: Pointer);
    class procedure CarregaPropriedadesConfiguracoesPagSeguro(ACodigoConfiguracao: String;
                                                              var AProperty: Pointer;
                                                              var AIndiceCfg: Integer;
                                                              var ACfgRepositorio: Pointer);
    class procedure CarregaPropriedadesConfiguracoesShopee(ACodigoConfiguracao: String;
                                                           var AProperty: Pointer;
                                                           var AIndiceCfg: Integer;
                                                           var ACfgRepositorio: Pointer);
    class procedure CarregaPropriedadesConfiguracoesMobbuy(ACodigoConfiguracao: String;
                                                              var AProperty: Pointer;
                                                              var AIndiceCfg: Integer;
                                                              var ACfgRepositorio: Pointer);
    class procedure CarregaPropriedadesConfiguracoesSafrapay(ACodigoConfiguracao: String;
                                                              var AProperty: Pointer;
                                                              var AIndiceCfg: Integer;
                                                              var ACfgRepositorio: Pointer);
    class procedure CarregaPropriedadesConfiguracoesCielo(ACodigoConfiguracao: String;
                                                              var AProperty: Pointer;
                                                              var AIndiceCfg: Integer;
                                                              var ACfgRepositorio: Pointer);
    class procedure CarregaPropriedadesConfiguracoesStone(ACodigoConfiguracao: String;
                                                              var AProperty: Pointer;
                                                              var AIndiceCfg: Integer;
                                                              var ACfgRepositorio: Pointer);
    class procedure CarregaPropriedadesConfiguracoesMagazineLuiza(ACodigoConfiguracao: String;
                                                                  var AProperty: Pointer;
                                                                  var AIndiceCfg: Integer;
                                                                  var ACfgRepositorio: Pointer);
    class procedure CarregaPropriedadesConfiguracoesSicredi(ACodigoConfiguracao: String;
                                                              var AProperty: Pointer;
                                                              var AIndiceCfg: Integer;
                                                              var ACfgRepositorio: Pointer);
    class procedure CarregaPropriedadesConfiguracoesGetNet(ACodigoConfiguracao: String;
                                                          var AProperty: Pointer;
                                                          var AIndiceCfg: Integer;
                                                          var ACfgRepositorio: Pointer);
    class procedure CarregaPropriedadesConfiguracoesEquals(ACodigoConfiguracao: String;
                                                              var AProperty: Pointer;
                                                              var AIndiceCfg: Integer;
                                                              var ACfgRepositorio: Pointer);
    class procedure CarregaPropriedadesConfiguracoesFiservBin(ACodigoConfiguracao: String;
                                                              var AProperty: Pointer;
                                                              var AIndiceCfg: Integer;
                                                              var ACfgRepositorio: Pointer);
    class procedure CarregaPropriedadesConfiguracoesPagarMe(ACodigoConfiguracao: String;
                                                            var AProperty: Pointer;
                                                            var AIndiceCfg: Integer;
                                                            var ACfgRepositorio: Pointer);
   class procedure CarregaPropriedadesConfiguracoesBanrisul(ACodigoConfiguracao: String;
                                                            var AProperty: Pointer;
                                                            var AIndiceCfg: Integer;
                                                            var ACfgRepositorio: Pointer);
    class procedure CarregaPropriedadesConfiguracoesB2W(ACodigoConfiguracao: String;
                                                            var AProperty: Pointer;
                                                            var AIndiceCfg: Integer;
                                                            var ACfgRepositorio: Pointer);
    class procedure CarregaPropriedadesConfiguracoesGranito(ACodigoConfiguracao: String;
                                                              var AProperty: Pointer;
                                                              var AIndiceCfg: Integer;
                                                              var ACfgRepositorio: Pointer);
    class procedure CarregaPropriedadesConfiguracoesAmazon(ACodigoConfiguracao: String;
                                                              var AProperty: Pointer;
                                                              var AIndiceCfg: Integer;
                                                              var ACfgRepositorio: Pointer);

    class procedure AdicionarConfiguracoesRedeCard;
    class procedure AdicionarConfiguracoesMercadoLivre;
    class procedure AdicionarConfiguracoesSipag;
    class procedure AdicionarConfiguracoesYapay;
    class procedure AdicionarConfiguracoesPagSeguro;
    class procedure AdicionarConfiguracoesMobbuy;
    class procedure AdicionarConfiguracoesSafrapay;
    class procedure AdicionarConfiguracoesShopee;
    class procedure AdicionarConfiguracoesCielo;
	  class procedure AdicionarConfiguracoesStone;
    class procedure AdicionarConfiguracoesMagazineLuiza;
    class procedure AdicionarConfiguracoesSicredi;
    class procedure AdicionarConfiguracoesGetNet;
    class procedure AdicionarConfiguracoesFiservBin;
    class procedure AdicionarConfiguracoesEquals;
    class procedure AdicionarConfiguracoesPagarMe;
    class procedure AdicionarConfiguracoesBanrisul;
    class procedure AdicionarConfiguracoesB2W;
    class procedure AdicionarConfiguracoesGranito;
    class procedure AdicionarConfiguracoesAmazon;
  public
    class function RetornaPropertiesLibCartoesCriacaoAutcom: TList<TLibCartoesCfgProperties>;

    class procedure CarregaPropriedadesConfiguracoesCartoes(ACodigoConfiguracao: String;
                                                            var AProperties: Pointer;
                                                            var AIndiceCfg: Integer;
                                                            var ACfgRepositorio: Pointer);

    class procedure CarregaPropriedadesConfiguracoesAntecipacaoRedeCard(ACodigoConfiguracao: String;
                                                                        var AProperties: Pointer;
                                                                        var AIndiceCfg: Integer;
                                                                        var ACfgRepositorio: Pointer);

    class procedure AdicionarConfiguracoesCartoes;
    class procedure AdicionarConfiguracoesAntecipacaoRedeCard;

    class function ValidaConfiguracoesCartoes(var ADatasetCfg: TUniCLientDataSet;
                                              AAdicionarConfigDuranteValidacao: Boolean;
                                              AFiltroEmpresa: Boolean = True): Boolean;
  end;


Const
  GRUPO: String = 'CARTÕES';

implementation

Uses untRepositorioConfiguracoesLibCartoes;

{ TLibCartoesCfgRepositorio }

class procedure TLibCartoesCfgRepositorio.AdicionarConfiguracoesAntecipacaoRedeCard;
  Const
    GRUPO: String = 'ANTECIPAÇÃO DE RECEBÍVEIS - REDECARD';

  Var
    LFuncoesExternas: ILibCartoes;
begin
  LFuncoesExternas := TLibCartoesFactory.Get;

  LFuncoesExternas.pIAdicionarConfiguracao('CFG_ATRHOM','Utilizar ambiente de homologação?'                                 ,'N'                                                                      ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_ATRCLI','ClientID'                                                          ,''                                                                       ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_ATRSEC','SecretCode'                                                        ,''                                                                       ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_ATRUSU','Usuário'                                                           ,'tef@citelsoftware.com.br'                                               ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_ATRSEN','Senha'                                                             ,''                                                                       ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_URLTAR','URL para geração do Token'                                         ,'https://api.userede.com.br/redelabs/oauth2/token'                       ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_URLCAR','URL para consentimento'                                            ,'https://auth.useredecloud.com.br/api/oauth2/authorize'                  ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_URLEAR','URL para efetivação da antecipação'                                ,'https://api.userede.com.br/redelabs/anticipation/zenite/hire'           ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_URLSAR','URL para simulação da antecipação'                                 ,'https://api.userede.com.br/redelabs/anticipation/zenite/simulate'       ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_URLCBR','URL de CallBack'                                                   ,'https://antecipacao-redecard.citelsoftware.com.br'                      ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_URLCSR','URL para consultar saldo'                                          ,'https://api.userede.com.br/redelabs/anticipation/zenite/balance/'       ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_CHARED','Chave Secreta Citel'                                               ,'uLtr@-F!n&320147'                                                       ,GRUPO, True);
end;


class procedure TLibCartoesCfgRepositorio.AdicionarConfiguracoesCartoes;
begin
  AdicionarConfiguracoesRedeCard;
  AdicionarConfiguracoesMercadoLivre;
  AdicionarConfiguracoesSipag;
  AdicionarConfiguracoesYapay;
  AdicionarConfiguracoesPagSeguro;
  AdicionarConfiguracoesMobbuy;
  AdicionarConfiguracoesShopee;
  AdicionarConfiguracoesSafrapay;
  AdicionarConfiguracoesCielo;
  AdicionarConfiguracoesStone;
  AdicionarConfiguracoesMagazineLuiza;
  AdicionarConfiguracoesSicredi;
  AdicionarConfiguracoesGetNet;
  AdicionarConfiguracoesEquals;
  AdicionarConfiguracoesFiservBin;
  AdicionarConfiguracoesPagarMe;
  AdicionarConfiguracoesBanrisul;
  AdicionarConfiguracoesB2W;
  AdicionarConfiguracoesGranito;
  AdicionarConfiguracoesAmazon;
end;

class procedure TLibCartoesCfgRepositorio.AdicionarConfiguracoesCielo;
  Var
    LFuncoesExternas: ILibCartoes;
begin
  If Not ConfiguracoesForamMapeadas('CIELO') Then
    Exit;

  LFuncoesExternas := TLibCartoesFactory.Get;

  LFuncoesExternas.pIAdicionarConfiguracao('CFG_CIEEST','CIELO - Código do Estabelecimento'                                                                                 ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_CIEPOR','CIELO - Portador padrão dos lançamentos de Cancelamentos/Ajustes'                                                  ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_CIECTA','CIELO - Plano de Contas padrão dos lançamentos de Cancelamentos/Ajustes'                                           ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_CIEFOR','CIELO - Fornecedor padrão dos lançamentos de Cancelamentos/Ajustes'                                                ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_CIEEVE','CIELO - Centro de Custos padrão dos lançamentos de Cancelamentos/Ajustes'                                          ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_CIETOL','CIELO - Valor de tolerância para conciliação automática de Cartões de Crédito'                                     ,'0,029999'                    ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_CIELNK','CIELO - Código do Estabelecimento para SUPERLINK'                                                                  ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_CIEREG','CIELO - Código do Estabelecimento definido por região'                                                             ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_CIEGRA','CIELO - Considerar registros de gravame/cessão na conciliação?'                                                    ,'N'                           ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_CIEPRN','CIELO - Portador para lançamento de negociação de recebíveis'                                                      ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_CIECTN','CIELO - Plano de Contas para lançamento de negociação de recebíveis'                                               ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_CIEDNE','CIELO - Considerar registros de débitos referente a negociação de recebíveis importados no arquivo 03 (previsão)?' ,'N'                           ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_CIECTT','CIELO - Plano de Contas para lançamento da taxa de ajuste'                                                         ,''                            ,GRUPO, True);
end;

class procedure TLibCartoesCfgRepositorio.AdicionarConfiguracoesEquals;
Var
  LFuncoesExternas: ILibCartoes;
begin
  If Not ConfiguracoesForamMapeadas('EQUALS') Then
    Exit;

  LFuncoesExternas := TLibCartoesFactory.Get;

  LFuncoesExternas.pIAdicionarConfiguracao('CFG_EQUEST','EQUALS - Código do Estabelecimento'                                         ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_EQUSEQ','EQUALS - Sequencial de Arquivo de Exportação'                               ,''                            ,GRUPO, False, 0, 'N', 'N');
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_EQUPAT','EQUALS - Pasta para geração do Arquivo de Exportação'                       ,''                            ,GRUPO, True);
end;

class procedure TLibCartoesCfgRepositorio.AdicionarConfiguracoesMagazineLuiza;
  Var
    LFuncoesExternas: ILibCartoes;
begin
  If Not ConfiguracoesForamMapeadas('MAGAZINE LUIZA') Then
    Exit;

  LFuncoesExternas := TLibCartoesFactory.Get;

  LFuncoesExternas.pIAdicionarConfiguracao('CFG_MLZPOR','MAGAZINE LUIZA - Portador padrão dos lançamentos de Cancelamentos/Ajustes'                                         ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_MLZCTA','MAGAZINE LUIZA - Plano de Contas padrão dos lançamentos de Cancelamentos/Ajustes'                                  ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_MLZFOR','MAGAZINE LUIZA - Fornecedor padrão dos lançamentos de Cancelamentos/Ajustes'                                       ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_MLZEVE','MAGAZINE LUIZA - Centro de Custos padrão dos lançamentos de Cancelamentos/Ajustes'                                 ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_MLZTRF','MAGAZINE LUIZA - Portador para lançamento de transferências'                                                       ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_MLZCTF','MAGAZINE LUIZA - Plano de contas para lançamento de transferências'                                                ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_MLZETF','MAGAZINE LUIZA - Centro de custos para lançamento de transferências'                                               ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_MLZCAR','MAGAZINE LUIZA - Cartão para conciliação de lançamentos'                                                           ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_MLZANA','MAGAZINE LUIZA - Lançar analiticamente os valores de taxas das vendas?'                                           ,'N'                            ,GRUPO, True);
end;

class procedure TLibCartoesCfgRepositorio.AdicionarConfiguracoesSicredi;
  Const
    GRUPO: String = 'CARTÕES';

  Var
    LFuncoesExternas: ILibCartoes;
begin
  If Not ConfiguracoesForamMapeadas('SICREDI') Then
    Exit;

  LFuncoesExternas := TLibCartoesFactory.Get;

  LFuncoesExternas.pIAdicionarConfiguracao('CFG_SICEST','SICREDI - Código do Estabelecimento'                                                                                 ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_SICPOR','SICREDI - Portador padrão dos lançamentos de Cancelamentos/Ajustes'                                                  ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_SICCTA','SICREDI - Plano de Contas padrão dos lançamentos de Cancelamentos/Ajustes'                                           ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_SICFOR','SICREDI - Fornecedor padrão dos lançamentos de Cancelamentos/Ajustes'                                                ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_SICEVE','SICREDI - Centro de Custos padrão dos lançamentos de Cancelamentos/Ajustes'                                          ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_SICTOL','SICREDI - Valor de tolerância para conciliação automática de Cartões de Crédito'                                     ,'0,029999'                    ,GRUPO, True);
end;

class procedure TLibCartoesCfgRepositorio.AdicionarConfiguracoesGetNet;
  Var
    LFuncoesExternas: ILibCartoes;
begin
  If Not ConfiguracoesForamMapeadas('GETNET') Then
    Exit;

  LFuncoesExternas := TLibCartoesFactory.Get;

  LFuncoesExternas.pIAdicionarConfiguracao('CFG_GETTOL','GETNET - Valor de tolerância para conciliação automática de Cartões de Crédito'                                    ,'0,029999'                    ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_GETEST','GETNET - Código do Estabelecimento'                                                                                ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_GETPOR','GETNET - Portador padrão dos lançamentos de Cancelamentos/Ajustes'                                                 ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_GETCTA','GETNET - Plano de Contas padrão dos lançamentos de Cancelamentos/Ajustes'                                          ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_GETFOR','GETNET - Fornecedor padrão dos lançamentos de Cancelamentos/Ajustes'                                               ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_GETEVE','GETNET - Centro de Custos padrão dos lançamentos de Cancelamentos/Ajustes'                                         ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_GETECO','GETNET - Código do Estabelecimento para e-Commerce'                                                                ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_GETCTD','GETNET - Plano de Contas para lançamento dos débitos de ajustes de antecipação (AC)'                               ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_GETCTC','GETNET - Plano de Contas para lançamento dos ajustes de crédito de antecipação (AC)'                               ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_GETPRN','GETNET - Portador para lançamento de negociação de recebíveis'                                                     ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_GETCTN','GETNET - Plano de Contas para lançamento de negociação de recebíveis'                                              ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_GETCTP','GETNET - Plano de Contas para o lançamento de "Aluguel POS"'                                                       ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_GETAGL','GETNET - Considerar movimentos de liquidação (GL) e antecipação (AL) de GRAVAME na conciliação?'                   ,'N'                           ,GRUPO, True);
end;

class procedure TLibCartoesCfgRepositorio.AdicionarConfiguracoesGranito;
Var
    LFuncoesExternas: ILibCartoes;
begin
  If Not ConfiguracoesForamMapeadas('GRANITO') Then
    Exit;

  LFuncoesExternas := TLibCartoesFactory.Get;

  LFuncoesExternas.pIAdicionarConfiguracao('CFG_GRAEST','GRANITO - Código do Estabelecimento'                                                                                 ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_GRAPOR','GRANITO - Portador padrão dos lançamentos de Cancelamentos/Ajustes'                                                  ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_GRACTA','GRANITO - Plano de Contas padrão dos lançamentos de Cancelamentos/Ajustes'                                           ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_GRAFOR','GRANITO - Fornecedor padrão dos lançamentos de Cancelamentos/Ajustes'                                                ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_GRAEVE','GRANITO - Centro de Custos padrão dos lançamentos de Cancelamentos/Ajustes'                                          ,''                            ,GRUPO, True);

end;


class procedure TLibCartoesCfgRepositorio.AdicionarConfiguracoesB2W;
 Var
    LFuncoesExternas: ILibCartoes;
begin
  If Not ConfiguracoesForamMapeadas('B2W') Then
    Exit;

  LFuncoesExternas := TLibCartoesFactory.Get;

  LFuncoesExternas.pIAdicionarConfiguracao('CFG_B2WEST','B2W - Código do Estabelecimento'                                                                                ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_B2WPOR','B2W - Portador padrão dos lançamentos de Cancelamentos/Ajustes'                                                 ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_B2WCTA','B2W - Plano de Contas padrão dos lançamentos de Cancelamentos/Ajustes'                                          ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_B2WFOR','B2W - Fornecedor padrão dos lançamentos de Cancelamentos/Ajustes'                                               ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_B2WEVE','B2W - Centro de Custos padrão dos lançamentos de Cancelamentos/Ajustes'                                         ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_B2WCAR','B2W - Cartões para conciliação de lançamentos'                                                                  ,''                            ,GRUPO, True);
end;

class procedure TLibCartoesCfgRepositorio.AdicionarConfiguracoesMercadoLivre;
  Var
    LFuncoesExternas: ILibCartoes;
begin
  If Not ConfiguracoesForamMapeadas('MERCADO LIVRE') Then
    Exit;

  LFuncoesExternas := TLibCartoesFactory.Get;

  LFuncoesExternas.pIAdicionarConfiguracao('CFG_MEREMP','MERCADO LIVRE - Realizar importação de arquivo por empresa?'                                                      ,'S'                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_MERPOR','MERCADO LIVRE - Portador padrão dos lançamentos de Cancelamentos/Ajustes'                                          ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_MERCTA','MERCADO LIVRE - Plano de Contas padrão dos lançamentos de Cancelamentos/Ajustes'                                   ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_MERFOR','MERCADO LIVRE - Fornecedor padrão dos lançamentos de Cancelamentos/Ajustes'                                        ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_MEREVE','MERCADO LIVRE - Centro de Custos padrão dos lançamentos de Cancelamentos/Ajustes'                                  ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_MERDIA','MERCADO LIVRE - Quantidade de dias para o recebimento após a confirmação de pagamento'                             ,'1'                           ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_MERCAR','MERCADO LIVRE - Cartões para os lançamentos de baixa de recebíveis'                                                ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_MERTRF','MERCADO LIVRE - Portador para o lançamento de registros de transferências/retiradas'                               ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_MERCTF','MERCADO LIVRE - Plano de Contas para o lançamento de registros de transferências/retiradas'                        ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_MERETF','MERCADO LIVRE - Centro de Custos para o lançamento de registros de transferências/retiradas'                       ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_MERANA','MERCADO LIVRE - Lançar analiticamente os valores de taxas das vendas?'                                            ,'N'                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_MERZER','MERCADO LIVRE - Baixar automaticamente valores zerados (Pedidos Cancelados) de cartão ao realizar a baixa de recebíveis?' ,'S'                    ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_MERCTD','MERCADO LIVRE - Plano de Contas para o lançamento de débito de transferências/retiradas.'                         ,''                             ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_MERPAY','MERCADO LIVRE - Plano de Contas para o lançamento de registros "MELIPAYMENTS"'                                    ,''                             ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_MERCRE','MERCADO LIVRE - Na Conciliação de Recebíveis do Mercado Livre, ignorar os lançamentos que vem no arquivo do tipo ' +
                                                        'DESCRIPTION = payment e EXTERNAL_REFERENCE = vazio?'                                                              ,'N'                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_MERFIN','MERCADO LIVRE - Na Conciliação de Recebíveis do Mercado Livre, considerar o valor da coluna FINANCING_FEE_AMOUNT ' +
                                                        'do relatório de liberações no valor da venda?'                                                                    ,'N'                            ,GRUPO, True);

  If TLibCartoesFuncoes.CampoMER_NUMNSUExiste Then
  Begin
    LFuncoesExternas.pIAdicionarConfiguracao('CFG_MERMAQ','MERCADO LIVRE - Cartões para os lançamentos referentes a recebimentos de cartões nas maquininhas do Mercado Pago' ,''                             ,GRUPO, True);
    LFuncoesExternas.pIAdicionarConfiguracao('CFG_MEREST','MERCADO LIVRE - Código do Estabelecimento referentes as maquininhas do Mercado Pago (STORE ID)'                   ,''                             ,GRUPO, True);
  End;
end;

class procedure TLibCartoesCfgRepositorio.AdicionarConfiguracoesMobbuy;
Const
    GRUPO: String = 'CARTÕES';

  Var
    LFuncoesExternas: ILibCartoes;
begin
  If Not ConfiguracoesForamMapeadas('MOBBUY') Then
    Exit;

  LFuncoesExternas := TLibCartoesFactory.Get;

  LFuncoesExternas.pIAdicionarConfiguracao('CFG_MOBEVE','SEMPRE PRONTO - Centro de Custos padrão dos lançamentos de Cancelamentos/Ajustes'                                       ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_MOBTOL','SEMPRE PRONTO - Valor de tolerância para conciliação automática de Cartões de Crédito'                                  ,'0,029999'                    ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_MOBEST','SEMPRE PRONTO - Código do Estabelecimento (CNPJ Lojista)'                                                               ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_MOBPOR','SEMPRE PRONTO - Portador padrão dos lançamentos de Cancelamentos/Ajustes'                                               ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_MOBCTA','SEMPRE PRONTO - Plano de Contas padrão dos lançamentos de Cancelamentos/Ajustes'                                        ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_MOBFOR','SEMPRE PRONTO - Fornecedor padrão dos lançamentos de Cancelamentos/Ajustes'                                             ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_MOBKEY','SEMPRE PRONTO - ApiKey do Estabelecimento (Lojista) para autenticação nas consultas de pagamentos. '                    ,''                            ,GRUPO, True);
end;

class procedure TLibCartoesCfgRepositorio.AdicionarConfiguracoesPagarMe;
  Var
    LFuncoesExternas: ILibCartoes;
begin
  If Not ConfiguracoesForamMapeadas('PAGARME') Then
    Exit;

  LFuncoesExternas := TLibCartoesFactory.Get;

  LFuncoesExternas.pIAdicionarConfiguracao('CFG_PGMKEY','PAGAR.ME - Chave para utilização da API '                                                                          ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_PGMVER','PAGAR.ME - Versão '                                                                                                ,'v5'                          ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_PGMPOR','PAGAR.ME - Portador padrão dos lançamentos de Cancelamentos/Ajustes'                                               ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_PGMCTA','PAGAR.ME - Plano de Contas padrão dos lançamentos de Cancelamentos/Ajustes'                                        ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_PGMFOR','PAGAR.ME - Fornecedor padrão dos lançamentos de Cancelamentos/Ajustes'                                             ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_PGMEVE','PAGAR.ME - Centro de Custos padrão dos lançamentos de Cancelamentos/Ajustes'                                       ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_PGMTOL','PAGAR.ME - Valor de tolerância para conciliação automática de Cartões de Crédito'                                  ,'0,029999'                    ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_PGMTRF','PAGAR.ME - Portador para o lançamento de registros de transferências'                                              ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_PGMCTF','PAGAR.ME - Plano de Contas para o lançamento de registros de transferências'                                       ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_PGMETF','PAGAR.ME - Centro de Custos para o lançamento de registros de transferências'                                      ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_PGMREI','PAGAR.ME - Código de recebedor vinculado à empresa'                                                                ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_PGMCAR','PAGAR.ME - Cartões para conciliação dos lançamentos'                                                               ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_PGMPTT','PAGAR.ME - Plano de Contas para o lançamento de Taxa de Transferência'                                             ,''                            ,GRUPO, True);
end;

class procedure TLibCartoesCfgRepositorio.AdicionarConfiguracoesBanrisul;
Var
    LFuncoesExternas: ILibCartoes;
begin
  If Not ConfiguracoesForamMapeadas('BANRISUL') Then
    Exit;

  LFuncoesExternas := TLibCartoesFactory.Get;

  LFuncoesExternas.pIAdicionarConfiguracao('CFG_BANEST','BANRISUL - Código do Estabelecimento (CNPJ do Estabelecimento)'                                                   ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_BANPOR','BANRISUL - Portador padrão dos lançamentos de Cancelamentos/Ajustes'                                              ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_BANCTA','BANRISUL - Plano de Contas padrão dos lançamentos de Cancelamentos/Ajustes'                                       ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_BANFOR','BANRISUL - Fornecedor padrão dos lançamentos de Cancelamentos/Ajustes'                                            ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_BANEVE','BANRISUL - Centro de Custos padrão dos lançamentos de Cancelamentos/Ajustes'                                      ,''                            ,GRUPO, True);

end;

class procedure TLibCartoesCfgRepositorio.AdicionarConfiguracoesPagSeguro;
  Var
    LFuncoesExternas: ILibCartoes;
begin
  If Not ConfiguracoesForamMapeadas('PAGSEGURO') Then
    Exit;

  LFuncoesExternas := TLibCartoesFactory.Get;

  LFuncoesExternas.pIAdicionarConfiguracao('CFG_PAGTOL','PAGSEGURO - Valor de tolerância para conciliação automática de Cartões de Crédito'                                 ,'0,029999'                    ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_PAGEST','PAGSEGURO - Código do Estabelecimento'                                                                             ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_PAGPOR','PAGSEGURO - Portador padrão dos lançamentos de Cancelamentos/Ajustes'                                              ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_PAGCTA','PAGSEGURO - Plano de Contas padrão dos lançamentos de Cancelamentos/Ajustes'                                       ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_PAGFOR','PAGSEGURO - Fornecedor padrão dos lançamentos de Cancelamentos/Ajustes'                                            ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_PAGEVE','PAGSEGURO - Centro de Custos padrão dos lançamentos de Cancelamentos/Ajustes'                                      ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_PAGTKN','PAGSEGURO API - Token de Acesso: '                                                                                 ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_PAGTRF','PAGSEGURO - Portador para o lançamento de registros de transferências'                                             ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_PAGCTF','PAGSEGURO - Plano de Contas para o lançamento de registros de transferências'                                      ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_PAGETF','PAGSEGURO - Centro de Custos para o lançamento de registros de transferências'                                     ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_PAGLNK','PAGSEGURO - Código do Estabelecimento para LINK'                                                                  ,''                             ,GRUPO, True);
end;

class procedure TLibCartoesCfgRepositorio.AdicionarConfiguracoesRedeCard;
  Var
    LFuncoesExternas: ILibCartoes;
begin
  LFuncoesExternas := TLibCartoesFactory.Get;

  LFuncoesExternas.pIAdicionarConfiguracao('CFG_REDEST','REDECARD - Número do Ponto de Venda (PV)'                                                                          ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_REDPOR','REDECARD - Portador padrão dos lançamentos de Cancelamentos/Ajustes'                                               ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_REDCTA','REDECARD - Plano de Contas padrão dos lançamentos de Cancelamentos/Ajustes'                                        ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_REDFOR','REDECARD - Fornecedor padrão dos lançamentos de Cancelamentos/Ajustes'                                             ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_REDEVE','REDECARD - Centro de Custos padrão dos lançamentos de Cancelamentos/Ajustes'                                       ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_REDTOL','REDECARD - Valor de tolerância para conciliação automática de Cartões de Crédito'                                  ,'0,029999'                    ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_REDECO','REDECARD - Número do Ponto de Venda (PV) para E-COMMERCE'                                                          ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_REDHOM','REDECARD API - Utilizar ambiente de homologação para a conciliação dos registros?'                                 ,'N'                           ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_REDCLI','REDECARD API - Campo ClientID para a utilização da API'                                                            ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_REDSEC','REDECARD API - Campo SecretCode para a utilização da API'                                                          ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_REDEMP','REDECARD API - Considerar empresa fixa para buscar dados da baixa automática'                                      ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_REDUSU','REDECARD API - Campo Usuário para a utilização da API'                                                             ,'tef@citelsoftware.com.br'    ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_REDSEN','REDECARD API - Campo Senha para a utilização da API'                                                               ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_REDPAG','REDECARD API - Número do Ponto de Venda (PV) centralizador dos pagamentos'                                         ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_CONCRV','REDECARD API - Conciliar vendas pelo resumo de venda?'                                                             ,'N'                           ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_REDVCA','REDECARD API - Venda cancelada sem cartão. Lançar como Cancelamentos/Ajustes?'                                     ,'N'                           ,GRUPO, True);
end;

class procedure TLibCartoesCfgRepositorio.AdicionarConfiguracoesSafrapay;
Const
  GRUPO: String = 'CARTÕES';
Var
  LFuncoesExternas: ILibCartoes;
begin
  If Not ConfiguracoesForamMapeadas('SAFRAPAY') Then
    Exit;

  LFuncoesExternas := TLibCartoesFactory.Get;

  LFuncoesExternas.pIAdicionarConfiguracao('CFG_SAFEST','SAFRAPAY - Código do Estabelecimento'                                                                            ,''                        ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_SAFPOR','SAFRAPAY - Portador padrão dos lançamentos de Cancelamentos/Ajustes'                                             ,''                        ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_SAFCTA','SAFRAPAY - Plano de Contas padrão dos lançamentos de Cancelamentos/Ajustes'                                      ,''                        ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_SAFFOR','SAFRAPAY - Fornecedor padrão dos lançamentos de Cancelamentos/Ajustes'                                           ,''                        ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_SAFEVE','SAFRAPAY - Centro de Custos padrão dos lançamentos de Cancelamentos/Ajustes'                                     ,''                        ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_SAFTOL','SAFRAPAY - Valor de tolerância para conciliação automática de Cartões de Crédito'                                ,''                        ,GRUPO, True);
end;

class procedure TLibCartoesCfgRepositorio.AdicionarConfiguracoesShopee;
  Const
    GRUPO: String = 'CARTÕES';

  Var
    LFuncoesExternas: ILibCartoes;
begin
  If Not ConfiguracoesForamMapeadas('SHOPEE') Then
    Exit;

  LFuncoesExternas := TLibCartoesFactory.Get;

  LFuncoesExternas.pIAdicionarConfiguracao('CFG_SHOPOR','SHOPEE - Portador padrão dos lançamentos de Cancelamentos/Ajustes'                                                 ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_SHOCTA','SHOPEE - Plano de Contas padrão dos lançamentos de Cancelamentos/Ajustes'                                          ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_SHOFOR','SHOPEE - Fornecedor padrão dos lançamentos de Cancelamentos/Ajustes'                                               ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_SHOEVE','SHOPEE - Centro de Custos padrão dos lançamentos de Cancelamentos/Ajustes'                                         ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_SHOCAR','SHOPEE - Cartões para conciliação de lançamentos'                                                                  ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_SHOEMP','SHOPEE - Realizar importação de arquivo por empresa?'                                                              ,'S'                           ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_SHOORD','SHOPEE - Conciliar arquivo Order All?'                                                                             ,'N'                           ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_SHOTRF','SHOPEE - Portador para o lançamento de registros de transferências/retiradas'                                      ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_SHOCTF','SHOPEE - Plano de Contas para o lançamento de registros de transferências/retiradas'                               ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_SHOETF','SHOPEE - Centro de Custos para o lançamento de registros de transferências/retiradas'                              ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_SHOHUB','SHOPEE - Rotina de conciliação de recebíveis integrada com o HUB Citel?'                                           ,'S'                           ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_SHOHEM','SHOPEE - Empresas integradas com o HUB Citel para importação das vendas na empresa atual'                          ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_SHOANA','SHOPEE - Lançar analiticamente os valores de taxas das vendas?'                                                    ,'N'                           ,GRUPO, True);
end;

class procedure TLibCartoesCfgRepositorio.AdicionarConfiguracoesSipag;
  Var
    LFuncoesExternas: ILibCartoes;
begin
  If Not ConfiguracoesForamMapeadas('SIPAG') Then
    Exit;

  LFuncoesExternas := TLibCartoesFactory.Get;

  LFuncoesExternas.pIAdicionarConfiguracao('CFG_SIPEST','SIPAG - Código do Estabelecimento'                                                                                 ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_SIPPOR','SIPAG - Portador padrão dos lançamentos de Cancelamentos/Ajustes'                                                  ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_SIPCTA','SIPAG - Plano de Contas padrão dos lançamentos de Cancelamentos/Ajustes'                                           ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_SIPFOR','SIPAG - Fornecedor padrão dos lançamentos de Cancelamentos/Ajustes'                                                ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_SIPEVE','SIPAG - Centro de Custos padrão dos lançamentos de Cancelamentos/Ajustes'                                          ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_SIPFIS','SIPAG - Conciliar arquivo FISERV?'                                                                                ,'N'                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_SIPVER','SIPAG - USAR VERSÃO 2.0?'                                                                                         ,'N'                            ,GRUPO, True);
end;

class procedure TLibCartoesCfgRepositorio.AdicionarConfiguracoesStone;
 Const
    GRUPO: String = 'CARTÕES';

  Var
    LFuncoesExternas: ILibCartoes;
begin
  If Not ConfiguracoesForamMapeadas('STONE') Then
    Exit;

  LFuncoesExternas := TLibCartoesFactory.Get;

  LFuncoesExternas.pIAdicionarConfiguracao('CFG_STOEST','STONE - Código do Estabelecimento'                                                                                 ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_STOAUT','STONE - Chave de Autorização Pública (ClientApplicationKey)'                                                       ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_STOSEC','STONE - Assinatura Cifrada Stone (Client Application SecretKey)'                                                   ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_STOPOR','STONE - Portador padrão dos lançamentos de Cancelamentos/Ajustes'                                                  ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_STOCTA','STONE - Plano de Contas padrão dos lançamentos de Cancelamentos/Ajustes'                                           ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_STOFOR','STONE - Fornecedor padrão dos lançamentos de Cancelamentos/Ajustes'                                                ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_STOEVE','STONE - Centro de Custos padrão dos lançamentos de Cancelamentos/Ajustes'                                          ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_STOLNK','STONE - Código do Estabelecimento para link do e-Commerce'                                                         ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_STOPLK','STONE - Portador dos lançamentos de Cancelamentos/Ajustes para link do e-Commerce'                                 ,''                            ,GRUPO, True);

  LFuncoesExternas.pIAdicionarConfiguracao('CFG_STOCID','STONE - Client ID'                                                                                                 ,'27gjdttlknvlmje2n06ns3n7vi'                           ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_STOCSC','STONE - Client Secret'                                                                                             ,'1tpn1bkqdt6id1qd4bs4cdocht8b9nqirnjphkrf4iugploop61b' ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_STOUSU','STONE - Usuario'                                                                                                   ,''                                                     ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_STOPAS','STONE - Senha'                                                                                                     ,''                                                     ,GRUPO, True);

  LFuncoesExternas.pIAdicionarConfiguracao('CFG_STOTKN','STONE - Url Token'                 ,'https://payments.stone.com.br/auth/realms/payments/oauth/token'                 , GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_STOCOE','STONE - Url Consulta Extrato'      ,'https://conciliation.stone.com.br/v2/merchant/%s/conciliation-file/%s?layout=%s', GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_STOWHO','STONE - Url Consentimento Webhook' ,'https://webhook-stone.citelsoftware.com.br/webhook/stone/consentimento'         , GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_STOMIG','STONE - Url Migração V1 para V2'   ,'https://conciliation.stone.com.br/v1/merchant/migration'                        , GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_STOCOW','STONE - Url Consulta Webhook'      ,'https://webhook-stone.citelsoftware.com.br/api/consentimentos/documento'        , GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_STOCON','STONE - Url Pedido de consentimento'  ,'https://conciliation.stone.com.br/v2/merchant/consents'                      , GRUPO, True);

end;

class procedure TLibCartoesCfgRepositorio.AdicionarConfiguracoesYapay;
  Const
    GRUPO: String = 'CARTÕES';

  Var
    LFuncoesExternas: ILibCartoes;
begin
  If Not ConfiguracoesForamMapeadas('YAPAY') Then
    Exit;

  LFuncoesExternas := TLibCartoesFactory.Get;

  LFuncoesExternas.pIAdicionarConfiguracao('CFG_YAPESTB','YAPAY - Código do Estabelecimento (0)'                                                                            ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_YAPPORB','YAPAY - Portador padrão dos lançamentos de Cancelamentos/Ajustes'                                                 ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_YAPCTAB','YAPAY - Plano de Contas padrão dos lançamentos de Cancelamentos/Ajustes'                                          ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_YAPFORB','YAPAY - Fornecedor padrão dos lançamentos de Cancelamentos/Ajustes'                                               ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_YAPEVEB','YAPAY - Centro de Custos padrão dos lançamentos de Cancelamentos/Ajustes'                                         ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_YAPDIAS','YAPAY - Dias úteis para crédito na movimentação bancária a partir da data do saque'                               ,'0'                           ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_YAPTRF','YAPAY - Portador para o lançamento de registros de saques'                                                        ,''                             ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_YAPCTF','YAPAY - Plano de Contas para o lançamento de registros de saques'                                                 ,''                             ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_YAPETF','YAPAY - Centro de Custos para o lançamento de registros de saques'                                                ,''                             ,GRUPO, True);
end;

class procedure TLibCartoesCfgRepositorio.AdicionarConfiguracoesFiservBin;
Var
    LFuncoesExternas: ILibCartoes;
begin
  If Not ConfiguracoesForamMapeadas('FISERVBIN') Then
    Exit;

  LFuncoesExternas := TLibCartoesFactory.Get;

  LFuncoesExternas.pIAdicionarConfiguracao('CFG_BINEST','FISERV BIN - Código do Estabelecimento'                                                                                 ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_BINPOR','FISERV BIN - Portador padrão dos lançamentos de Cancelamentos/Ajustes'                                                  ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_BINCTA','FISERV BIN - Plano de Contas padrão dos lançamentos de Cancelamentos/Ajustes'                                           ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_BINFOR','FISERV BIN - Fornecedor padrão dos lançamentos de Cancelamentos/Ajustes'                                                ,''                            ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_BINEVE','FISERV BIN - Centro de Custos padrão dos lançamentos de Cancelamentos/Ajustes'                                          ,''                            ,GRUPO, True);
end;

class procedure TLibCartoesCfgRepositorio.AdicionarConfiguracoesAmazon;
Var
  LFuncoesExternas: ILibCartoes;
begin
  If Not ConfiguracoesForamMapeadas('AMAZON') Then
    Exit;

  LFuncoesExternas := TLibCartoesFactory.Get;

  LFuncoesExternas.pIAdicionarConfiguracao('CFG_AMZPOR','AMAZON - Portador padrão dos lançamentos de Cancelamentos/Ajustes'                           ,''  ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_AMZCTA','AMAZON - Plano de Contas padrão dos lançamentos de Cancelamentos/Ajustes'                    ,''  ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_AMZFOR','AMAZON - Fornecedor padrão dos lançamentos de Cancelamentos/Ajustes'                         ,''  ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_AMZEVE','AMAZON - Centro de Custos padrão dos lançamentos de Cancelamentos/Ajustes'                   ,''  ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_AMZCAR','AMAZON - Cartões para conciliação de lançamentos'                                            ,''  ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_AMZTRF','AMAZON - Portador para lançamento de depósitos'                                              ,''  ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_AMZCTF','AMAZON - Plano de Contas para lançamento de depósitos'                                       ,''  ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_AMZETF','AMAZON - Centro de Custos para lançamento de depósitos'                                      ,''  ,GRUPO, True);
  LFuncoesExternas.pIAdicionarConfiguracao('CFG_AMZANA','AMAZON - Lançar analiticamente os valores de taxas das vendas?'                              ,'N' ,GRUPO, True);
end;

class procedure TLibCartoesCfgRepositorio.CarregaPropriedadesConfiguracoesCartoes(
  ACodigoConfiguracao: String; var AProperties: Pointer;
  var AIndiceCfg: Integer; var ACfgRepositorio: Pointer);
  Var
    LProperty: Pointer;
begin
  LProperty := Nil;

  CarregaPropriedadesConfiguracoesRedeCard(ACodigoConfiguracao, LProperty, AIndiceCfg, ACfgRepositorio);
  CarregaPropriedadesConfiguracoesMercadoLivre(ACodigoConfiguracao, LProperty, AIndiceCfg, ACfgRepositorio);
  CarregaPropriedadesConfiguracoesSipag(ACodigoConfiguracao, LProperty, AIndiceCfg, ACfgRepositorio);
  CarregaPropriedadesConfiguracoesYapay(ACodigoConfiguracao, LProperty, AIndiceCfg, ACfgRepositorio);
  CarregaPropriedadesConfiguracoesPagSeguro(ACodigoConfiguracao, LProperty, AIndiceCfg, ACfgRepositorio);
  CarregaPropriedadesConfiguracoesMobbuy(ACodigoConfiguracao, LProperty, AIndiceCfg, ACfgRepositorio);
  CarregaPropriedadesConfiguracoesShopee(ACodigoConfiguracao, LProperty, AIndiceCfg, ACfgRepositorio);
  CarregaPropriedadesConfiguracoesSafrapay(ACodigoConfiguracao, LProperty, AIndiceCfg, ACfgRepositorio);
  CarregaPropriedadesConfiguracoesCielo(ACodigoConfiguracao, LProperty, AIndiceCfg, ACfgRepositorio);
  CarregaPropriedadesConfiguracoesStone(ACodigoConfiguracao, LProperty, AIndiceCfg, ACfgRepositorio);
  CarregaPropriedadesConfiguracoesMagazineLuiza(ACodigoConfiguracao, LProperty, AIndiceCfg, ACfgRepositorio);
  CarregaPropriedadesConfiguracoesSicredi(ACodigoConfiguracao, LProperty, AIndiceCfg, ACfgRepositorio);
  CarregaPropriedadesConfiguracoesGetNet(ACodigoConfiguracao, LProperty, AIndiceCfg, ACfgRepositorio);
  CarregaPropriedadesConfiguracoesEquals(ACodigoConfiguracao, LProperty, AIndiceCfg, ACfgRepositorio);
  CarregaPropriedadesConfiguracoesFiservBin(ACodigoConfiguracao, LProperty, AIndiceCfg, ACfgRepositorio);
  CarregaPropriedadesConfiguracoesPagarMe(ACodigoConfiguracao, LProperty, AIndiceCfg, ACfgRepositorio);
  CarregaPropriedadesConfiguracoesbanrisul(ACodigoConfiguracao, LProperty, AIndiceCfg, ACfgRepositorio);
  CarregaPropriedadesConfiguracoesB2W(ACodigoConfiguracao, LProperty, AIndiceCfg, ACfgRepositorio);
  CarregaPropriedadesConfiguracoesGranito(ACodigoConfiguracao, LProperty, AIndiceCfg, ACfgRepositorio);
  CarregaPropriedadesConfiguracoesAmazon(ACodigoConfiguracao, LProperty, AIndiceCfg, ACfgRepositorio);

  If LProperty <> Nil Then
    AProperties := LProperty;
end;

class procedure TLibCartoesCfgRepositorio.CarregaPropriedadesConfiguracoesCielo(
  ACodigoConfiguracao: String; var AProperty: Pointer; var AIndiceCfg: Integer;
  var ACfgRepositorio: Pointer);
begin
  If Not ConfiguracoesForamMapeadas('CIELO') Then
    Exit;

  {* CIELO *}
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcTexto_Tam20);           //CFG_CIEEST
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPortador);           //CFG_CIEPOR
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPlanoDeContas);      //CFG_CIECTA
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConFornecedor);         //CFG_CIEFOR
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConCentroDeCustos);     //CFG_CIEEVE
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcValorToleranciaCartao); //CFG_CIETOL
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcCadEstabelecimentos);   //CFG_CIELNK
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcCadEstabelecimentos);   //CFG_CIEREG
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcSimNao);                //CFG_CIEGRA
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPortador);           //CFG_CIEPRN
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPlanoDeContas);      //CFG_CIECTN
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcSimNao);                //CFG_CIEDNE
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPlanoDeContas);      //CFG_CIECTT
end;

class procedure TLibCartoesCfgRepositorio.CarregaPropriedadesConfiguracoesFiservBin(
  ACodigoConfiguracao: String; var AProperty: Pointer; var AIndiceCfg: Integer;
  var ACfgRepositorio: Pointer);
begin
  If Not ConfiguracoesForamMapeadas('FISERVBIN') Then
    Exit;

  {*FISERV BIN*}
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcTexto_Tam20);           //CFG_BINEST
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPortador);           //CFG_BINPOR
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPlanoDeContas);      //CFG_BINCTA
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConFornecedor);         //CFG_BINFOR
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConCentroDeCustos);     //CFG_BINEVE
end;

class procedure TLibCartoesCfgRepositorio.CarregaPropriedadesConfiguracoesEquals(
  ACodigoConfiguracao: String; var AProperty: Pointer; var AIndiceCfg: Integer;
  var ACfgRepositorio: Pointer);
begin
  If Not ConfiguracoesForamMapeadas('EQUALS') Then
    Exit;

  {* EQUALS *}
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcTextoSemCase); // CFG_EQUEST
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcTexto_Tam10);  // CFG_EQUSEQ
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcBuscarDiretorio); // CFG_EQUPAT (campo com botão)

end;

class procedure TLibCartoesCfgRepositorio.CarregaPropriedadesConfiguracoesMagazineLuiza(
  ACodigoConfiguracao: String; var AProperty: Pointer; var AIndiceCfg: Integer;
  var ACfgRepositorio: Pointer);
begin
  If Not ConfiguracoesForamMapeadas('MAGAZINE LUIZA') Then
    Exit;

  {*MAGAZINE LUIZA*}
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPortador);           //CFG_MLZPOR
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPlanoDeContas);      //CFG_MLZCTA
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConFornecedor);         //CFG_MLZFOR
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConCentroDeCustos);     //CFG_MLZEVE
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPortador);           //CFG_MLZTRF
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPlanoDeContas);      //CFG_MLZCTF
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConCentroDeCustos);     //CFG_MLZETF
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConCartoesMultiSelecao);//CFG_MLZCAR
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcSimNao);                //CFG_MLZANA
end;

class procedure TLibCartoesCfgRepositorio.CarregaPropriedadesConfiguracoesSicredi(
  ACodigoConfiguracao: String; var AProperty: Pointer; var AIndiceCfg: Integer;
  var ACfgRepositorio: Pointer);
begin
 If Not ConfiguracoesForamMapeadas('SICREDI') Then
    Exit;

  {*SICREDI*}
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcCadEstabelecimentos); //CFG_SICEST
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPortador);         //CFG_SICPOR
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPlanoDeContas);    //CFG_SICCTA
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConFornecedor);       //CFG_SICFOR
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConCentroDeCustos);   //CFG_SICEVE
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcValorToleranciaCartao);//CFG_SICTOL

end;

class procedure TLibCartoesCfgRepositorio.CarregaPropriedadesConfiguracoesGetNet(
  ACodigoConfiguracao: String; var AProperty: Pointer; var AIndiceCfg: Integer;
  var ACfgRepositorio: Pointer);
begin
  If Not ConfiguracoesForamMapeadas('GETNET') Then
    Exit;

  {* GETNET *}
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcValorToleranciaCartao); //CFG_GETTOL
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcTexto_Tam20);           //CFG_GETEST
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPortador);           //CFG_GETPOR
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPlanoDeContas);      //CFG_GETCTA
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConFornecedor);         //CFG_GETFOR
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConCentroDeCustos);     //CFG_GETEVE
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcTexto_Tam20);           //CFG_GETECO
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPlanoDeContas);      //CFG_GETCTD
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPlanoDeContas);      //CFG_GETCTC
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPortador);           //CFG_GETPRN
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPlanoDeContas);      //CFG_GETCTN
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPlanoDeContas);      //CFG_GETCTP
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcSimNao);                //CFG_GETAGL

end;

class procedure TLibCartoesCfgRepositorio.CarregaPropriedadesConfiguracoesGranito(
  ACodigoConfiguracao: String; var AProperty: Pointer; var AIndiceCfg: Integer;
  var ACfgRepositorio: Pointer);
begin
  If Not ConfiguracoesForamMapeadas('GRANITO') Then
    Exit;

  {*GRANITO*}
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcTexto_Tam20);           //CFG_GRAEST
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPortador);           //CFG_GRAPOR
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPlanoDeContas);      //CFG_GRACTA
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConFornecedor);         //CFG_GRAFOR
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConCentroDeCustos);     //CFG_GRAEVE
end;


class procedure TLibCartoesCfgRepositorio.CarregaPropriedadesConfiguracoesMercadoLivre(
  ACodigoConfiguracao: String; var AProperty: Pointer; var AIndiceCfg: Integer;
  var ACfgRepositorio: Pointer);
begin
  If Not ConfiguracoesForamMapeadas('MERCADO LIVRE') Then
    Exit;

  {*MERCADO LIVRE*}
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcSimNao);                //CFG_MEREMP
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPortador);           //CFG_MERPOR
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPlanoDeContas);      //CFG_MERCTA
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConFornecedor);         //CFG_MERFOR
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConCentroDeCustos);     //CFG_MEREVE
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcValorInteiro);          //CFG_MERDIA
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConCartoesMultiSelecao);//CFG_MERCAR
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPortador);           //CFG_MERTRF
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPlanoDeContas);      //CFG_MERCTF
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConCentroDeCustos);     //CFG_MERETF
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcSimNao);                //CFG_MERANA
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcSimNao);                //CFG_MERZER
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPlanoDeContas);      //CFG_MERCTD
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPlanoDeContas);      //CFG_MERPAY
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcSimNao);                //CFG_MERCRE
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcSimNao);                //CFG_MERFIN

  If TLibCartoesFuncoes.CampoMER_NUMNSUExiste Then
  Begin
    CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConCartoesMultiSelecao);//CFG_MERMAQ
    CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcCadEstabelecimentos);   //CFG_MEREST
  End;
end;

class procedure TLibCartoesCfgRepositorio.CarregaPropriedadesConfiguracoesMobbuy(
  ACodigoConfiguracao: String; var AProperty: Pointer; var AIndiceCfg: Integer;
  var ACfgRepositorio: Pointer);
begin
  If Not ConfiguracoesForamMapeadas('MOBBUY') Then
    Exit;

  {*MOBBUY*}

  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConCentroDeCustos);     //CFG_MOBEVE
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcValorToleranciaCartao); //CFG_MOBTOL
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcCadEstabelecimentos);   //CFG_MOBEST
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPortador);           //CFG_MOBPOR
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPlanoDeContas);      //CFG_MOBCTA
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConFornecedor);         //CFG_MOBFOR
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcTextoSemCase);          //CFG_MOBKEY
end;

class procedure TLibCartoesCfgRepositorio.CarregaPropriedadesConfiguracoesPagarMe(
  ACodigoConfiguracao: String; var AProperty: Pointer; var AIndiceCfg: Integer;
  var ACfgRepositorio: Pointer);
begin
  If Not ConfiguracoesForamMapeadas('PAGARME') Then
    Exit;

  {*PAGAR.ME*}
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcCadChavesAutorizacaoPagarMe);//CFG_PGMKEY
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcVersaoPagarMe);         //CFG_PGMVER
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPortador);           //CFG_PGMPOR
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPlanoDeContas);      //CFG_PGMCTA
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConFornecedor);         //CFG_PGMFOR
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConCentroDeCustos);     //CFG_PGMEVE
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcValorToleranciaCartao); //CFG_PGMTOL
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPortador);           //CFG_PGMTRF
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPlanoDeContas);      //CFG_PGMCTF
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConCentroDeCustos);     //CFG_PGMETF
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcCadIDRecebedoresPagarMe);//CFG_PGMREI
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConCartoesMultiSelecao);//CFG_PGMCAR
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPlanoDeContas);      //CFG_PGMPTT
end;

class procedure TLibCartoesCfgRepositorio.CarregaPropriedadesConfiguracoesBanrisul(
  ACodigoConfiguracao: String; var AProperty: Pointer; var AIndiceCfg: Integer;
  var ACfgRepositorio: Pointer);
begin
   If Not ConfiguracoesForamMapeadas('BANRISUL') Then
    Exit;

  {*BANRISUL*}

  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcTexto_Tam20);           //CFG_BANEST
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPortador);           //CFG_BANPOR
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPlanoDeContas);      //CFG_BANCTA
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConFornecedor);         //CFG_BANFOR
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConCentroDeCustos);     //CFG_BANEVE
end;

class procedure TLibCartoesCfgRepositorio.CarregaPropriedadesConfiguracoesPagSeguro(
  ACodigoConfiguracao: String; var AProperty: Pointer; var AIndiceCfg: Integer;
  var ACfgRepositorio: Pointer);
begin
  If Not ConfiguracoesForamMapeadas('PAGSEGURO') Then
    Exit;

  {*PAGSEGURO*}
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcValorToleranciaCartao); //CFG_PAGTOL
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcTexto_Tam20);           //CFG_PAGEST
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPortador);           //CFG_PAGPOR
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPlanoDeContas);      //CFG_PAGCTA
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConFornecedor);         //CFG_PAGFOR
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConCentroDeCustos);     //CFG_PAGEVE
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcTextoSemCase);          //CFG_PAGTKN
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPortador);           //CFG_PAGTRF
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPlanoDeContas);      //CFG_PAGCTF
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConCentroDeCustos);     //CFG_PAGETF
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcCadEstabelecimentos);   //CFG_PAGLNK
end;

class procedure TLibCartoesCfgRepositorio.CarregaPropriedadesConfiguracoesRedeCard(
  ACodigoConfiguracao: String; var AProperty: Pointer;
  var AIndiceCfg: Integer; var ACfgRepositorio: Pointer);
begin
  {*REDECARD*}
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcCadEstabelecimentos);   //CFG_REDEST
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPortador);           //CFG_REDPOR
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPlanoDeContas);      //CFG_REDCTA
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConFornecedor);         //CFG_REDFOR
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConCentroDeCustos);     //CFG_REDEVE
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcValorToleranciaCartao); //CFG_REDTOL
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcTexto_Tam20);           //CFG_REDECO
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcSimNao);                //CFG_REDHOM
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcTextoSemCase);          //CFG_REDCLI
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcSenha);                 //CFG_REDSEC
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConEmpresa);            //CFG_REDEMP
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcTextoSemCase);          //CFG_REDUSU
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcSenha);                 //CFG_REDSEN
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcTexto_Tam10);           //CFG_REDPAG
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcSimNao);                //CFG_CONCRV
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcSimNao);                //CFG_REDVCA
end;

class procedure TLibCartoesCfgRepositorio.CarregaPropriedadesConfiguracoesSafrapay(
  ACodigoConfiguracao: String; var AProperty: Pointer; var AIndiceCfg: Integer;
  var ACfgRepositorio: Pointer);
begin
  If Not ConfiguracoesForamMapeadas('SAFRAPAY') Then
    Exit;

     {*SAFRAPAY}
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcCadEstabelecimentos);   //CFG_SAFEST
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPortador);           //CFG_SAFPOR
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPlanoDeContas);      //CFG_SAFCTA
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConFornecedor);         //CFG_SAFFOR
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConCentroDeCustos);     //CFG_SAFEVE
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcValorToleranciaCartao); //CFG_SAFTOL
end;

class procedure TLibCartoesCfgRepositorio.CarregaPropriedadesConfiguracoesShopee(
  ACodigoConfiguracao: String; var AProperty: Pointer; var AIndiceCfg: Integer;
  var ACfgRepositorio: Pointer);
begin
  If Not ConfiguracoesForamMapeadas('SHOPEE') Then
    Exit;

  {*SHOPEE*}
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPortador);           //CFG_SHOPOR
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPlanoDeContas);      //CFG_SHOCTA
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConFornecedor);         //CFG_SHOFOR
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConCentroDeCustos);     //CFG_SHOEVE
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConCartoesMultiSelecao);//CFG_SHOCAR
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcSimNao);                //CFG_SHOEMP
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcSimNao);                //CFG_SHOORD
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPortador);           //CFG_SHOTRF
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPlanoDeContas);      //CFG_SHOCTF
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConCentroDeCustos);     //CFG_SHOETF
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcSimNao);                //CFG_SHOHUB
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConEmpresasMultiSelecao);//CFG_SHOHEM
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcSimNao);                //CFG_SHOANA
end;

class procedure TLibCartoesCfgRepositorio.CarregaPropriedadesConfiguracoesSipag(
  ACodigoConfiguracao: String; var AProperty: Pointer; var AIndiceCfg: Integer;
  var ACfgRepositorio: Pointer);
begin
  If Not ConfiguracoesForamMapeadas('SIPAG') Then
    Exit;

  {*SIPAG*}
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcCadEstabelecimentos); //CFG_SIPEST
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPortador);         //CFG_SIPPOR
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPlanoDeContas);    //CFG_SIPCTA
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConFornecedor);       //CFG_SIPFOR
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConCentroDeCustos);   //CFG_SIPEVE
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcSimNao);              //CFG_SIPFIS
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcSimNao);              //CFG_SIPVER
end;

class procedure TLibCartoesCfgRepositorio.CarregaPropriedadesConfiguracoesStone(
  ACodigoConfiguracao: String; var AProperty: Pointer; var AIndiceCfg: Integer;
  var ACfgRepositorio: Pointer);
begin
  If Not ConfiguracoesForamMapeadas('STONE') Then
    Exit;

  {*STONE*}
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcTexto_Tam10); //CFG_STOEST
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcTextoSemCase);        //CFG_STOAUT
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcTextoSemCase);        //CFG_STOSEC
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPortador);         //CFG_STOPOR
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPlanoDeContas);    //CFG_STOCTA
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConFornecedor);       //CFG_STOFOR
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConCentroDeCustos);   //CFG_STOEVE
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcTexto_Tam10);         //CFG_STOLNK
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPortador);         //CFG_STOPLK

  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcTextoSemCase);        //CFG_STOCID
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcTextoSemCase);        //CFG_STOCSC
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcTextoSemCase);        //CFG_STOUSU
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcTextoSemCase);        //CFG_STOPAS
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcTextoSemCase);        //CFG_STOTKN
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcTextoSemCase);        //CFG_STOCOE
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcTextoSemCase);        //CFG_STOWHO
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcTextoSemCase);        //CFG_STOMIG
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcTextoSemCase);        //CFG_STOCOW
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcTextoSemCase);        //CFG_STOCON
end;

class procedure TLibCartoesCfgRepositorio.CarregaPropriedadesConfiguracoesYapay(
  ACodigoConfiguracao: String; var AProperty: Pointer; var AIndiceCfg: Integer;
  var ACfgRepositorio: Pointer);
begin
  If Not ConfiguracoesForamMapeadas('YAPAY') Then
    Exit;

  {*YAPAY*}
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcTexto_Tam20);        //CFG_YAPESTB
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPortador);        //CFG_YAPPORB
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPlanoDeContas);   //CFG_YAPCTAB
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConFornecedor);      //CFG_YAPFORB
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConCentroDeCustos);  //CFG_YAPEVEB
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcValorInteiro);       //CFG_YAPDIAS
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPortador);        //CFG_YAPTRF
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPlanoDeContas);   //CFG_YAPCTF
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConCentroDeCustos);  //CFG_YAPETF
end;

class procedure TLibCartoesCfgRepositorio.CarregaPropriedadesConfiguracoesB2W(
  ACodigoConfiguracao: String; var AProperty: Pointer; var AIndiceCfg: Integer;
  var ACfgRepositorio: Pointer);
begin
  If Not ConfiguracoesForamMapeadas('B2W') Then
    Exit;

  {*B2W*}
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcTexto_Tam20);            //CFG_B2WEST
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPortador);            //CFG_B2WPOR
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPlanoDeContas);       //CFG_B2WCTA
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConFornecedor);          //CFG_B2WFOR
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConCentroDeCustos);      //CFG_B2WEVE
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConCartoesMultiSelecao); //CFG_B2WCAR
end;

class procedure TLibCartoesCfgRepositorio.CarregaPropriedadesConfiguracoesAmazon(
  ACodigoConfiguracao: String; var AProperty: Pointer; var AIndiceCfg: Integer;
  var ACfgRepositorio: Pointer);
begin
  If Not ConfiguracoesForamMapeadas('AMAZON') Then
    Exit;

  {*AMAZON*}
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPortador);           //CFG_AMZPOR
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPlanoDeContas);      //CFG_AMZCTA
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConFornecedor);         //CFG_AMZFOR
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConCentroDeCustos);     //CFG_AMZEVE
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConCartoesMultiSelecao);//CFG_AMZCAR
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPortador);           //CFG_AMZTRF
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConPlanoDeContas);      //CFG_AMZCTF
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcConCentroDeCustos);     //CFG_AMZETF
  CarregaPropriedadesInterna(ACodigoConfiguracao, AProperty, AIndiceCfg, ACfgRepositorio, tpcSimNao);                //CFG_AMZANA
end;

class procedure TLibCartoesCfgRepositorio.CarregaPropriedadesConfiguracoesAntecipacaoRedeCard(
  ACodigoConfiguracao: String; var AProperties: Pointer;
  var AIndiceCfg: Integer; var ACfgRepositorio: Pointer);
Var
  LProperty: Pointer;
begin
  LProperty := Nil;

  CarregaPropriedadesInterna(ACodigoConfiguracao, LProperty, AIndiceCfg, ACfgRepositorio, tpcSimNao);       //CFG_ATRHOM
  CarregaPropriedadesInterna(ACodigoConfiguracao, LProperty, AIndiceCfg, ACfgRepositorio, tpcTextoSemCase); //CFG_ATRCLI
  CarregaPropriedadesInterna(ACodigoConfiguracao, LProperty, AIndiceCfg, ACfgRepositorio, tpcSenha);        //CFG_ATRSEC
  CarregaPropriedadesInterna(ACodigoConfiguracao, LProperty, AIndiceCfg, ACfgRepositorio, tpcTextoSemCase); //CFG_ATRUSU
  CarregaPropriedadesInterna(ACodigoConfiguracao, LProperty, AIndiceCfg, ACfgRepositorio, tpcSenha);        //CFG_ATRSEN
  CarregaPropriedadesInterna(ACodigoConfiguracao, LProperty, AIndiceCfg, ACfgRepositorio, tpcTextoSemCase); //CFG_URLTAR
  CarregaPropriedadesInterna(ACodigoConfiguracao, LProperty, AIndiceCfg, ACfgRepositorio, tpcTextoSemCase); //CFG_URLCAR
  CarregaPropriedadesInterna(ACodigoConfiguracao, LProperty, AIndiceCfg, ACfgRepositorio, tpcTextoSemCase); //CFG_URLEAR
  CarregaPropriedadesInterna(ACodigoConfiguracao, LProperty, AIndiceCfg, ACfgRepositorio, tpcTextoSemCase); //CFG_URLSAR
  CarregaPropriedadesInterna(ACodigoConfiguracao, LProperty, AIndiceCfg, ACfgRepositorio, tpcTextoSemCase); //CFG_URLCBR
  CarregaPropriedadesInterna(ACodigoConfiguracao, LProperty, AIndiceCfg, ACfgRepositorio, tpcTextoSemCase); //CFG_URLCSR
  CarregaPropriedadesInterna(ACodigoConfiguracao, LProperty, AIndiceCfg, ACfgRepositorio, tpcSenha);        //CFG_CHARED

  If LProperty <> Nil Then
    AProperties := LProperty;
end;



class function TLibCartoesCfgRepositorio.RetornaPropertiesLibCartoesCriacaoAutcom: TList<TLibCartoesCfgProperties>;
  Var
    LRepositorio: TdtmRepositorioConfiguracoesLibCartoes;

    LContador: Integer;

    LItemCfg: TLibCartoesCfgProperties;
begin
  Result := TList<TLibCartoesCfgProperties>.Create;

  LRepositorio := TdtmRepositorioConfiguracoesLibCartoes.Create(Nil);
  For LContador := 0 To LRepositorio.cxRepositorioCartoes.Count - 1 Do
  Begin
    LItemCfg := TLibCartoesCfgProperties.Create;
    LItemCfg.Nome := LRepositorio.cxRepositorioCartoes.Items[LContador].Name;
    LItemCfg.TipoClasse := LRepositorio.cxRepositorioCartoes.Items[LContador].ClassName;
    LItemCfg.TipoClasseProperties := LRepositorio.cxRepositorioCartoes.Items[LContador].Properties.ClassName;

    LRepositorio.CarregaTipoConfiguracao(LItemCfg);
    LRepositorio.CarregaPropertiesPeloTipoConfiguracao(LItemCfg);

    Result.Add(LItemCfg);
  End;
end;

class function TLibCartoesCfgRepositorio.ValidaConfiguracoesCartoes(
  var ADatasetCfg: TUniCLientDataSet; AAdicionarConfigDuranteValidacao: Boolean;
  AFiltroEmpresa: Boolean = True): Boolean;
  Var
    LValorConfiguracao: String;
begin
  //Valida a quantidade de carcelas dos cartões
  Result := TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_PARCAR', AAdicionarConfigDuranteValidacao, AFiltroEmpresa);
  If Result Then
  Begin
    If (Not TLibCartoesFuncoes.fEmptyStr(ADatasetCfg.FieldByName('SIS_VALCFG').AsString)) Then
    Begin
      Result := (ADatasetCfg.FieldByName('SIS_VALCFG').AsInteger >= 1) And (ADatasetCfg.FieldByName('SIS_VALCFG').AsInteger <= 26);
      If Not Result Then
      Begin
        TLibCartoesFuncoes.fMensagem('ATENÇÃO', 'A configuração CFG_PARCAR deve estar entre 1 e 26.' , ['&Ok']);
        Exit;
      End;
    End
    Else
    Begin
      TLibCartoesFuncoes.fMensagem('ATENÇÃO', 'A configuração CFG_PARCAR deve estar entre 1 e 26.' , ['&Ok']);
      Exit;
    End;
  End;

  Result := TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_SHOHEM', AAdicionarConfigDuranteValidacao, AFiltroEmpresa);
  If Result Then
  Begin
    If Not TLibCartoesFuncoes.fEmptyStr(ADatasetCfg.FieldByName('SIS_VALCFG').AsString) Then
    Begin
       If TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_SHOEMP', AAdicionarConfigDuranteValidacao, AFiltroEmpresa) Then
       Begin
         If ADatasetCfg.FieldByName('SIS_VALCFG').AsString.Equals('N') Then
         Begin
           TLibCartoesFuncoes.fMensagem('ATENÇÃO', 'Para utilizar a CFG_SHOHEM preenchida, a configuração CFG_SHOEMP deve estar marcada como "Sim".' , ['&Ok']);
           Exit(False);
         End;
       End;
    End;
  End;

  Result := TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_REDECO', AAdicionarConfigDuranteValidacao, AFiltroEmpresa);
  If Result Then
  Begin
    LValorConfiguracao := ADatasetCfg.FieldByName('SIS_VALCFG').AsString;

    If Not TLibCartoesFuncoes.fEmptyStr(LValorConfiguracao) Then
    Begin

      While LValorConfiguracao[1] = '0' do
        Delete(LValorConfiguracao,1,1);

      If TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_REDEST', AAdicionarConfigDuranteValidacao, AFiltroEmpresa) Then
      Begin
        If (Pos(LValorConfiguracao, ADatasetCfg.FieldByName('SIS_VALCFG').AsString) > 0) Then
        Begin
          TLibCartoesFuncoes.fMensagem('ATENÇÃO', 'Foram identificados códigos de estabelecimento duplicados entre as configurações CFG_REDECO e CFG_REDEST.'+ #13 +
                                                  'Ajuste as configurações para prosseguir.' , ['&Ok']);
          Exit(False);
        End;
      End;
    End;

  End;

  Result := TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_STOLNK', AAdicionarConfigDuranteValidacao, AFiltroEmpresa);
  If Result Then
  Begin
    LValorConfiguracao := ADatasetCfg.FieldByName('SIS_VALCFG').AsString;

    If Not TLibCartoesFuncoes.fEmptyStr(LValorConfiguracao) Then
    Begin

      While LValorConfiguracao[1] = '0' do
        Delete(LValorConfiguracao,1,1);

      If TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_STOEST', AAdicionarConfigDuranteValidacao, AFiltroEmpresa) Then
      Begin
        If (Pos(LValorConfiguracao, ADatasetCfg.FieldByName('SIS_VALCFG').AsString) > 0) Then
        Begin
          TLibCartoesFuncoes.fMensagem('ATENÇÃO', 'Foram identificados códigos de estabelecimento duplicados entre as configurações CFG_STOLNK e CFG_STOEST.'+ #13 +
                                                  'Ajuste as configurações para prosseguir.' , ['&Ok']);
          Exit(False);
        End;
      End;
    End;

  End;

  Result := TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_CIEEST', AAdicionarConfigDuranteValidacao, AFiltroEmpresa);
  If Result Then
  Begin
    LValorConfiguracao := ADatasetCfg.FieldByName('SIS_VALCFG').AsString;

    If Not TLibCartoesFuncoes.fEmptyStr(LValorConfiguracao) Then
    Begin

      While LValorConfiguracao[1] = '0' do
        Delete(LValorConfiguracao,1,1);

      If TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_CIELNK', AAdicionarConfigDuranteValidacao, AFiltroEmpresa) Then
      Begin
        If (Pos(LValorConfiguracao, ADatasetCfg.FieldByName('SIS_VALCFG').AsString) > 0) Then
        Begin
          TLibCartoesFuncoes.fMensagem('ATENÇÃO', 'Foram identificados códigos de estabelecimento duplicados entre as configurações CFG_CIELNK e CFG_CIEEST.'+ #13 +
                                                  'Ajuste as configurações para prosseguir.' , ['&Ok']);
          Exit(False);
        End;
      End;
    End;

  End;

  Result := TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_PAGEST', AAdicionarConfigDuranteValidacao, AFiltroEmpresa);
  If Result Then
  Begin
    LValorConfiguracao := ADatasetCfg.FieldByName('SIS_VALCFG').AsString;

    If Not TLibCartoesFuncoes.fEmptyStr(TLibCartoesFuncoes.RetiraZerosEsquerda(LValorConfiguracao)) Then
    Begin

      LValorConfiguracao := TLibCartoesFuncoes.RetiraZerosEsquerda(LValorConfiguracao);

      If TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_PAGLNK', AAdicionarConfigDuranteValidacao, AFiltroEmpresa) Then
      Begin
        If TLibCartoesFuncoes.ExisteValorMultiplosEstabelecimentos(LValorConfiguracao, ADatasetCfg.FieldByName('SIS_VALCFG').AsString, ',') Then
        Begin
          TLibCartoesFuncoes.fMensagem('ATENÇÃO', 'Foram identificados códigos de estabelecimento duplicados entre as configurações CFG_PAGLNK e CFG_PAGEST.'+ #13 +
                                                  'Ajuste as configurações para prosseguir.' , ['&Ok']);
          Exit(False);
        End;
      End;
    End;

  End;

  Result := (TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_BAIDEB', AAdicionarConfigDuranteValidacao, AFiltroEmpresa)) And
            (ADatasetCfg.FieldByName('SIS_VALCFG').AsString = 'N');
  If Result Then
    Exit;

  Result := ((TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_CIEEST', AAdicionarConfigDuranteValidacao, AFiltroEmpresa)) And
            (Not TLibCartoesFuncoes.fEmptyStr(ADatasetCfg.FieldByName('SIS_VALCFG').AsString))) And
            ((TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_CIEPOR', AAdicionarConfigDuranteValidacao, AFiltroEmpresa)) And
            (Not TLibCartoesFuncoes.fEmptyStr(ADatasetCfg.FieldByName('SIS_VALCFG').AsString))) And
            ((TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_CIECTA', AAdicionarConfigDuranteValidacao, AFiltroEmpresa)) And
            (Not TLibCartoesFuncoes.fEmptyStr(ADatasetCfg.FieldByName('SIS_VALCFG').AsString))) And
            ((TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_CIEFOR', AAdicionarConfigDuranteValidacao, AFiltroEmpresa)) And
            (Not TLibCartoesFuncoes.fEmptyStr(ADatasetCfg.FieldByName('SIS_VALCFG').AsString)));

  Result := (Result) Or (((TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_GETEST', AAdicionarConfigDuranteValidacao, AFiltroEmpresa)) And
            (Not TLibCartoesFuncoes.fEmptyStr(ADatasetCfg.FieldByName('SIS_VALCFG').AsString))) And
            ((TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_GETPOR', AAdicionarConfigDuranteValidacao, AFiltroEmpresa)) And
            (Not TLibCartoesFuncoes.fEmptyStr(ADatasetCfg.FieldByName('SIS_VALCFG').AsString))) And
            ((TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_GETCTA', AAdicionarConfigDuranteValidacao, AFiltroEmpresa)) And
            (Not TLibCartoesFuncoes.fEmptyStr(ADatasetCfg.FieldByName('SIS_VALCFG').AsString))) And
            ((TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_GETFOR', AAdicionarConfigDuranteValidacao, AFiltroEmpresa)) And
            (Not TLibCartoesFuncoes.fEmptyStr(ADatasetCfg.FieldByName('SIS_VALCFG').AsString))));

  Result := (Result) Or (((ADatasetCfg.FindKey(['CFG_STOEST'])) And
            (Not TLibCartoesFuncoes.fEmptyStr(ADatasetCfg.FieldByName('SIS_VALCFG').AsString))) And
            ((ADatasetCfg.FindKey(['CFG_STOPOR'])) And
            (Not TLibCartoesFuncoes.fEmptyStr(ADatasetCfg.FieldByName('SIS_VALCFG').AsString))) And
            ((ADatasetCfg.FindKey(['CFG_STOCTA'])) And
            (Not TLibCartoesFuncoes.fEmptyStr(ADatasetCfg.FieldByName('SIS_VALCFG').AsString))) And
            ((ADatasetCfg.FindKey(['CFG_STOFOR'])) And
            (Not TLibCartoesFuncoes.fEmptyStr(ADatasetCfg.FieldByName('SIS_VALCFG').AsString))));

  Result := (Result) Or (((TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_AMEEST', AAdicionarConfigDuranteValidacao, AFiltroEmpresa)) And
            (Not TLibCartoesFuncoes.fEmptyStr(ADatasetCfg.FieldByName('SIS_VALCFG').AsString))) And
            ((TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_AMEPOR', AAdicionarConfigDuranteValidacao, AFiltroEmpresa)) And
            (Not TLibCartoesFuncoes.fEmptyStr(ADatasetCfg.FieldByName('SIS_VALCFG').AsString))) And
            ((TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_AMECTA', AAdicionarConfigDuranteValidacao, AFiltroEmpresa)) And
            (Not TLibCartoesFuncoes.fEmptyStr(ADatasetCfg.FieldByName('SIS_VALCFG').AsString))) And
            ((TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_AMEFOR', AAdicionarConfigDuranteValidacao, AFiltroEmpresa)) And
            (Not TLibCartoesFuncoes.fEmptyStr(ADatasetCfg.FieldByName('SIS_VALCFG').AsString))));

  Result := (Result) Or (((TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_SIPEST', AAdicionarConfigDuranteValidacao, AFiltroEmpresa)) And
            (Not TLibCartoesFuncoes.fEmptyStr(ADatasetCfg.FieldByName('SIS_VALCFG').AsString))) And
            ((TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_SIPPOR', AAdicionarConfigDuranteValidacao, AFiltroEmpresa)) And
            (Not TLibCartoesFuncoes.fEmptyStr(ADatasetCfg.FieldByName('SIS_VALCFG').AsString))) And
            ((TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_SIPCTA', AAdicionarConfigDuranteValidacao, AFiltroEmpresa)) And
            (Not TLibCartoesFuncoes.fEmptyStr(ADatasetCfg.FieldByName('SIS_VALCFG').AsString))) And
            ((TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_SIPFOR', AAdicionarConfigDuranteValidacao, AFiltroEmpresa)) And
            (Not TLibCartoesFuncoes.fEmptyStr(ADatasetCfg.FieldByName('SIS_VALCFG').AsString))));

  Result := (Result) Or (((TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_SAFEST', AAdicionarConfigDuranteValidacao, AFiltroEmpresa)) And
            (Not TLibCartoesFuncoes.fEmptyStr(ADatasetCfg.FieldByName('SIS_VALCFG').AsString))) And
            ((TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_SAFPOR', AAdicionarConfigDuranteValidacao, AFiltroEmpresa)) And
            (Not TLibCartoesFuncoes.fEmptyStr(ADatasetCfg.FieldByName('SIS_VALCFG').AsString))) And
            ((TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_SAFCTA', AAdicionarConfigDuranteValidacao, AFiltroEmpresa)) And
            (Not TLibCartoesFuncoes.fEmptyStr(ADatasetCfg.FieldByName('SIS_VALCFG').AsString))) And
            ((TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_SAFFOR', AAdicionarConfigDuranteValidacao, AFiltroEmpresa)) And
            (Not TLibCartoesFuncoes.fEmptyStr(ADatasetCfg.FieldByName('SIS_VALCFG').AsString))));

  Result := (Result) Or (((TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_B2WEST', AAdicionarConfigDuranteValidacao, AFiltroEmpresa)) And
            (Not TLibCartoesFuncoes.fEmptyStr(ADatasetCfg.FieldByName('SIS_VALCFG').AsString))) And
            ((TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_B2WPOR', AAdicionarConfigDuranteValidacao, AFiltroEmpresa)) And
            (Not TLibCartoesFuncoes.fEmptyStr(ADatasetCfg.FieldByName('SIS_VALCFG').AsString))) And
            ((TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_B2WCTA', AAdicionarConfigDuranteValidacao, AFiltroEmpresa)) And
            (Not TLibCartoesFuncoes.fEmptyStr(ADatasetCfg.FieldByName('SIS_VALCFG').AsString))) And
            ((TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_B2WFOR', AAdicionarConfigDuranteValidacao, AFiltroEmpresa)) And
            (Not TLibCartoesFuncoes.fEmptyStr(ADatasetCfg.FieldByName('SIS_VALCFG').AsString))));

  Result := (Result) Or (((TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_PAGEST', AAdicionarConfigDuranteValidacao, AFiltroEmpresa)) And
            (Not TLibCartoesFuncoes.fEmptyStr(ADatasetCfg.FieldByName('SIS_VALCFG').AsString))) And
            ((TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_PAGPOR', AAdicionarConfigDuranteValidacao, AFiltroEmpresa)) And
            (Not TLibCartoesFuncoes.fEmptyStr(ADatasetCfg.FieldByName('SIS_VALCFG').AsString))) And
            ((TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_PAGCTA', AAdicionarConfigDuranteValidacao, AFiltroEmpresa)) And
            (Not TLibCartoesFuncoes.fEmptyStr(ADatasetCfg.FieldByName('SIS_VALCFG').AsString))) And
            ((TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_PAGFOR', AAdicionarConfigDuranteValidacao, AFiltroEmpresa)) And
            (Not TLibCartoesFuncoes.fEmptyStr(ADatasetCfg.FieldByName('SIS_VALCFG').AsString))));

  Result := (Result) Or (((TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_BANEST', AAdicionarConfigDuranteValidacao, AFiltroEmpresa)) And
            (Not TLibCartoesFuncoes.fEmptyStr(ADatasetCfg.FieldByName('SIS_VALCFG').AsString))) And
            ((TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_BANPOR', AAdicionarConfigDuranteValidacao, AFiltroEmpresa)) And
            (Not TLibCartoesFuncoes.fEmptyStr(ADatasetCfg.FieldByName('SIS_VALCFG').AsString))) And
            ((TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_BANCTA', AAdicionarConfigDuranteValidacao, AFiltroEmpresa)) And
            (Not TLibCartoesFuncoes.fEmptyStr(ADatasetCfg.FieldByName('SIS_VALCFG').AsString))) And
            ((TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_BANFOR', AAdicionarConfigDuranteValidacao, AFiltroEmpresa)) And
            (Not TLibCartoesFuncoes.fEmptyStr(ADatasetCfg.FieldByName('SIS_VALCFG').AsString))));

  Result := (Result) Or (((TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_REDEST', AAdicionarConfigDuranteValidacao, AFiltroEmpresa)) And
            (Not TLibCartoesFuncoes.fEmptyStr(ADatasetCfg.FieldByName('SIS_VALCFG').AsString))) And
            ((TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_REDPOR', AAdicionarConfigDuranteValidacao, AFiltroEmpresa)) And
            (Not TLibCartoesFuncoes.fEmptyStr(ADatasetCfg.FieldByName('SIS_VALCFG').AsString))) And
            ((TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_REDCTA', AAdicionarConfigDuranteValidacao, AFiltroEmpresa)) And
            (Not TLibCartoesFuncoes.fEmptyStr(ADatasetCfg.FieldByName('SIS_VALCFG').AsString))) And
            ((TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_REDFOR', AAdicionarConfigDuranteValidacao, AFiltroEmpresa)) And
            (Not TLibCartoesFuncoes.fEmptyStr(ADatasetCfg.FieldByName('SIS_VALCFG').AsString))));

  Result := (Result) Or (((TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_KONKEY', AAdicionarConfigDuranteValidacao, AFiltroEmpresa)) And
            (Not TLibCartoesFuncoes.fEmptyStr(ADatasetCfg.FieldByName('SIS_VALCFG').AsString))) And
            ((TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_KONPOR', AAdicionarConfigDuranteValidacao, AFiltroEmpresa)) And
            (Not TLibCartoesFuncoes.fEmptyStr(ADatasetCfg.FieldByName('SIS_VALCFG').AsString))) And
            ((TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_KONCTA', AAdicionarConfigDuranteValidacao, AFiltroEmpresa)) And
            (Not TLibCartoesFuncoes.fEmptyStr(ADatasetCfg.FieldByName('SIS_VALCFG').AsString))) And
            ((TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_KONFOR', AAdicionarConfigDuranteValidacao, AFiltroEmpresa)) And
            (Not TLibCartoesFuncoes.fEmptyStr(ADatasetCfg.FieldByName('SIS_VALCFG').AsString))));

  Result := (Result) Or (((TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_PGMKEY', AAdicionarConfigDuranteValidacao, AFiltroEmpresa)) And
            (Not TLibCartoesFuncoes.fEmptyStr(ADatasetCfg.FieldByName('SIS_VALCFG').AsString))) And
            ((TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_PGMPOR', AAdicionarConfigDuranteValidacao, AFiltroEmpresa)) And
            (Not TLibCartoesFuncoes.fEmptyStr(ADatasetCfg.FieldByName('SIS_VALCFG').AsString))) And
            ((TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_PGMCTA', AAdicionarConfigDuranteValidacao, AFiltroEmpresa)) And
            (Not TLibCartoesFuncoes.fEmptyStr(ADatasetCfg.FieldByName('SIS_VALCFG').AsString))) And
            ((TLibCartoesFuncoes.fFindCfg(ADatasetCfg, 'CFG_PGMFOR', AAdicionarConfigDuranteValidacao, AFiltroEmpresa)) And
            (Not TLibCartoesFuncoes.fEmptyStr(ADatasetCfg.FieldByName('SIS_VALCFG').AsString))));

  If Not Result Then
    TLibCartoesFuncoes.fMensagem('ATENÇÃO',
                                 'Para utilizar a configuração CFG_BAIDEB = Sim, é necessário configurar Código do Estabelecimento, ' +
                                          'Portador, Plano de Contas e Fornecedor de alguma das operadoras de cartão.',
                                 ['&Ok']);
end;

class procedure TLibCartoesCfgRepositorio.CarregaPropriedadesInterna(
  ACodigoConfiguracao: String; var AProperties: Pointer;
  var AIndiceCfg: Integer; var ACfgRepositorio: Pointer;
   ATipoConfiguracao: TTipoConfiguracao);
Var
  LItem: TcxEditRepositoryItem;
  LArrayConfiguracao: TArrConfiguracoes;
begin
  LArrayConfiguracao := TLibCartoesFactory.Get.fIGetArrayConfiguracoes;

  If Not ACodigoConfiguracao.Equals(LArrayConfiguracao[fInc(AIndiceCfg)].strCodCfg) Then
    Exit;

  Case ATipoConfiguracao Of
    tpcSimNao: LItem := TcxEditRepository(TForm(ACfgRepositorio).FindComponent('cxRepositorio')).ItemByName('libCartoesrdgSimNao');
    tpcSenha: LItem := TcxEditRepository(TForm(ACfgRepositorio).FindComponent('cxRepositorio')).ItemByName('libCartoesedtSenha');
    tpcCadEstabelecimentos: LItem := TcxEditRepository(TForm(ACfgRepositorio).FindComponent('cxRepositorio')).ItemByName('libCartoesbtnCadEstabelecimentosCartoes');
    tpcConPortador: LItem := TcxEditRepository(TForm(ACfgRepositorio).FindComponent('cxRepositorio')).ItemByName('btnConPortador');
    tpcConPlanoDeContas: LItem := TcxEditRepository(TForm(ACfgRepositorio).FindComponent('cxRepositorio')).ItemByName('btnConCta');
    tpcConFornecedor: LItem := TcxEditRepository(TForm(ACfgRepositorio).FindComponent('cxRepositorio')).ItemByName('btnConFornecedor');
    tpcConCentroDeCustos: LItem := TcxEditRepository(TForm(ACfgRepositorio).FindComponent('cxRepositorio')).ItemByName('btnConEvento');
    tpcTexto_Tam20: LItem := TcxEditRepository(TForm(ACfgRepositorio).FindComponent('cxRepositorio')).ItemByName('libCartoesedtTexto_Tam20');
    tpcTexto_Tam10: LItem := TcxEditRepository(TForm(ACfgRepositorio).FindComponent('cxRepositorio')).ItemByName('libCartoesedtTexto_Tam10');
    tpcTextoSemCase: LItem := TcxEditRepository(TForm(ACfgRepositorio).FindComponent('cxRepositorio')).ItemByName('libCartoesedtTextoSemCase');
    tpcConEmpresa: LItem := TcxEditRepository(TForm(ACfgRepositorio).FindComponent('cxRepositorio')).ItemByName('btnConEmpresa');
    tpcValorToleranciaCartao: LItem := TcxEditRepository(TForm(ACfgRepositorio).FindComponent('cxRepositorio')).ItemByName('libCartoesedtToleranciaConciliacao');
    tpcValorInteiro: LItem := TcxEditRepository(TForm(ACfgRepositorio).FindComponent('cxRepositorio')).ItemByName('libCartoesedtValorInteiro');
    tpcConCartoesMultiSelecao: LItem := TcxEditRepository(TForm(ACfgRepositorio).FindComponent('cxRepositorio')).ItemByName('btnConCartaoMultiselecao');
    tpcBuscarDiretorio:  LItem := TcxEditRepository(TForm(ACfgRepositorio).FindComponent('cxRepositorio')).ItemByName('btnPatEnd');
    tpcVersaoPagarMe: LItem := TcxEditRepository(TForm(ACfgRepositorio).FindComponent('cxRepositorio')).ItemByName('libCartoesrdgVersaoImpPagarMe');
    tpcCadIDRecebedoresPagarMe: LItem := TcxEditRepository(TForm(ACfgRepositorio).FindComponent('cxRepositorio')).ItemByName('libCartoesbtnCadIDRecebedorPagarMe');
    tpcCadChavesAutorizacaoPagarMe: LItem := TcxEditRepository(TForm(ACfgRepositorio).FindComponent('cxRepositorio')).ItemByName('libCartoesbtnCadChavesAutorizacaoPagarMe');

    tpcConEmpresasMultiSelecao:
    Begin
      LItem := TcxEditRepository(TForm(ACfgRepositorio).FindComponent('cxRepositorio')).ItemByName('btnConEmpresasMultiselecao');
      If LItem = Nil THen
        LItem := TcxEditRepository(TForm(ACfgRepositorio).FindComponent('cxRepositorio')).ItemByName('libCartoesedtTexto_Tam20');
    End
    Else LItem := TcxEditRepository(TForm(ACfgRepositorio).FindComponent('cxRepositorio')).ItemByName('libCartoesedtTextoSemCase');
  End;

  If Assigned(LItem) Then
    AProperties := (LItem.Properties As LITem.GetEditPropertiesClass);
end;

class function TLibCartoesCfgRepositorio.ConfiguracoesForamMapeadas(
  AOperadora: String): Boolean;
begin
  Try
    Result := VS_FuncoesExternas.fIRetornaOperadorasMapeadasLibCartoes.Contains(AOperadora + '_');
  Except
    Result := False;
  End;
end;

class function TLibCartoesCfgRepositorio.fInc(var intValor: Integer): Integer;
begin
  Inc(intValor);
  Result := intValor;
end;

end.
