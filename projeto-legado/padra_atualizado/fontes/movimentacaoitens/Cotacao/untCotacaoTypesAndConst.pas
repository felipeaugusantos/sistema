unit untCotacaoTypesAndConst;

interface

uses
  untImpostosReformaCompra;

Const
  INT_MAX_FORNECEDOR = 50;
  STR_TIPALT_MARGEM  = 'Margem';
  STR_TIPALT_PRECO   = 'Preço';
  STR_EXCLUIDO       = 'EXCLUIDO';
  STR_NAO_UTILIZADO  = 'NAO UTILIZADO';

  STR_CUSREA = ' IF((1 - (IFNULL(G.ITE_ICMSAI, 0) + IFNULL(G.ITE_IMPFED, 0) + IFNULL(G.ITE_DESOPE, 0))/100) <> 0, ' +
               '     ((IFNULL(G.ITE_PRECUS, 0) + IFNULL(G.ITE_OUTVAL, 0)) / (1 - (IFNULL(G.ITE_ICMSAI, 0) + IFNULL(G.ITE_IMPFED, 0) + IFNULL(G.ITE_DESOPE, 0))/100)), 0) ';

  STR_CUSREA_NOV = ' IF((1 - (IFNULL(G.ITE_ICMSAI, 0) + IFNULL(G.ITE_IMPFED, 0) + IFNULL(G.ITE_DESOPE, 0))/100) <> 0, ' +
                   '     ((IFNULL(@VALUNI, 0) + IFNULL(G.ITE_OUTVAL, 0)) / (1 - (IFNULL(G.ITE_ICMSAI, 0) + IFNULL(G.ITE_IMPFED, 0) + IFNULL(G.ITE_DESOPE, 0))/100)), 0) ';


  STR_COMLIQ = ' (G.ITE_PRECOM * (1 -  G.ITE_DESF01 / 100) * '  +
               '                 (1 -  G.ITE_DESF02 / 100) * '  +
               '                 (1 -  G.ITE_DESF03 / 100) * '  +
               '                 (1 -  G.ITE_DESF04 / 100) * '  +
               '                 (1 -  G.ITE_DESF05 / 100) * '  +
               '                 (1 -  G.ITE_DESF06 / 100))  ';


  STR_PREIMP_FRMCUS_1 = '(@COMLIQ + ((@COMLIQ * @IPIENT) /100) + (((@COMLIQ + ((@COMLIQ * @IPIENT) /100))  * @SUBSTI) /100) + (((@COMLIQ + ((@COMLIQ * @IPIENT) /100) + (((@COMLIQ + ((@COMLIQ * @IPIENT) /100))  * @SUBSTI) /100)) * @FREENT) / 100))';
  STR_PREIMP_FRMCUS_2 = '(@COMLIQ + ((@COMLIQ * @IPIENT) /100) + ((@COMLIQ * @SUBSTI) /100) + (((@COMLIQ  + ((@COMLIQ * @SUBSTI) /100) +  ((@COMLIQ * @IPIENT) /100)) * @FREENT) / 100))';
  STR_PREIMP_FRMCUS_3 = '(@COMLIQ + ((@COMLIQ * @IPIENT) /100) + ((@COMLIQ * @FREENT) /100) + (((@COMLIQ  + ((@COMLIQ * @FREENT) /100) +  ((@COMLIQ * @IPIENT) /100)) * @SUBSTI) / 100))';

  STR_FRETE_FRMCUS_1 = '(((@COMLIQ + ((@COMLIQ * @IPIENT) /100) + (((@COMLIQ + ((@COMLIQ * @IPIENT) /100))  * @SUBSTI) /100)) * @FREENT) / 100)';
  STR_FRETE_FRMCUS_2 = '(((@COMLIQ  + ((@COMLIQ * @SUBSTI) /100) +  ((@COMLIQ * @IPIENT) /100)) * @FREENT) / 100)';
  STR_FRETE_FRMCUS_3 = '((@COMLIQ * @FREENT) /100) ';

  Type
  TStatusCotacao = (stcAbertas, stcBaixadas, stcTodas);
  TTipoGeracao = (tpgNaoGera, tpgTodos, tpgGeraF2);
  TTipoUnidade = (tuUnCompra, tuUnVenda);
  TAcaoParaItensSemCotacao = (taIgnorar, taGerarNovaCotacao, taAbortado);

  TStatusBid = (stbNaoLiberado, stbLiberado, stbIntegrado, stbInativa, stbInativaIntegrado, stbEncerrada);

  TFonecCotacao = record
    strCodFor: String;
    strNomFor: String;
  End;

  TArrFonecCotacao = Array of TFonecCotacao;


  TDadosSubGrid = Record
    CodForFocused: String;
    CodIteFocused: String;
    IndexFocused: Integer;
    RecodIndexMasterFocused: Integer;
    RecodIndexDetailFocused: Integer;
  End;

  TRecDimFrm = Record
    wrdHeight,
    wrdWidth: Word;
    blnMaxim,
    blnCarregar: Boolean;
  End;

  TTipoCalculoExterno = (tpcNenhum, tpcPrecoVenda, tpcMargem);

  TCalculaPrecoImp = function (APrecoLiquido, AAliquotaIpi, AAliquotaST, AAliquotaFrete: Double): Double of object;
  TCalculaReformaImp = function (APrecoLiquido, AAliquotaIpi, AAliquotaST, AAliquotaFrete: Double;
                                 const AAliquotasReforma: TAliquotasReforma): TValoresReforma of object;

  TAtualizaUnitarioItemfornecedorEscolhido = procedure (ACodIte, ACodFor, AObsForIte: String;
                                                            APreCom: Double;
                                                            AVAlIpi: Double;
                                                            AVal_ST: Double;
                                                            AFreEnt: Double;
                                                            AValUni: Double) of object;

  TIncluiItensFornec_CopiaSeguranca = function (blnIncluido: Boolean = false; AcodFor: String = ''): Boolean of object;

implementation

end.
