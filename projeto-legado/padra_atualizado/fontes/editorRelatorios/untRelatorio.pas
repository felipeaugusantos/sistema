unit untRelatorio;

interface

uses
  Controls, Classes, SysUtils, Variants, untTypesSistema, Menus, AdvMenus,
  Uni, DB, untFuncoesSimples, untInterfaceRelatorio, Forms, untModulo,
  untGeraFr3, untGravando, cxProgressBar, untZClient, untFuncEditorRel,
  BitBtnLockedIncrem, untDadosEnviaWhatsapp,
  untRotinasGrid, RegularExpressions, RegularExpressionsCore;

Const
  ITEM_MENU_IGNORAR = 'mnuCtbParametros,' +
                      'mnuCtbCadastrosParametros,' +
                      'mnuCtbMovimentacaoLancamentos,' +
                      'mnuDespesasAcessorias,' +
                      'mnuImportacoesContabeis,' +
                      'mnuCadImobilizadoPatrimonio,' +
                      'mnuLALURLACS,' +
                      'mnuLalurLacsApuracoes,' +
                      'mnuLalurLacsCadastros,' +
                      'mnuImpostoRenda,' +
                      'mnuIRLucroPresumido,' +
                      'mnuIRLucroPresumidoApur,' +
                      'mnuFechamentosContabeis' ;

type
  TarrMenu = Array Of TMenuItem;

  TRelatorio = class(TComponent)
    private
      arrNotOrdInd,
      arrOrdInd,
      arrComEmp,
      arrComGer,
      arrCtaEmp,
      arrCtaGer,
      arrCEvEmp72,
      arrCEvGer72,
      arrCEvEmp74,
      arrCEvGer74,
      arrRefPre,
      arrPecPen,
      arrPecCli,
      arrEncFAn,
      arrEncFSi,
      arrKarTin,
      arrMkpOp1,
      arrMkpOp2,
      arrMkpOp3,
      arrGerPix,
      arrModOp1,
      arrModOp2,
      arrModOp3,
      arrSheWin,
      arrVenCcr,
      arrAnaDes,
      arrLiqVen,
      arrUsaWms,
      arrUsaTmq,
      arrTipEst,
      arrTabPrf,
      arrTabDin,
      arrCadLoc,
      arrEndScc,
      arrRelPar,
      arrConVis,
      arrUraPel,
      arrGirEst,
      arrMetGru,
      arrMetMar,
      arrEveCta74,
      arrGarantia72,
      arrApuICMS,
      arrMODRCM1,
      arrMODRCM2,
      arrRFMOD1,
      arrAJUEST,
      arrTITPAGCHQ,
      arrDEMFLUCAI,
      arrPOSCONPAG,
      arrTITDELPAG,
      arrORDEMSERV,
      arrCOMFAT,
      arrVPREDT,
      arrUSAFLE,
      arrEnvReq,
      arrRelCon,
      arrWhatsapp,
      arrRelEstTer : TarrMenu;

      FExcluirDaTabelaMenu: Boolean;

      FInicia,
      FOrdena: Boolean;
      FCodRel,
      FNovRel: String;

      FTabela: TUniQuery;

      FInterface: TInterfaceRelatorio;
      FGeraFr3: TGeraFR3;

      FRotinasFiltro,
      FRotinasGrid: TRotinasGrid;

      FmnuAutcom: TAdvMainMenu;
      FfrmPrincipal: TForm;
      FmnuRelatorio: TarrMenu;
      FobjMenu : TMenuItem;

      FGravando: TfrmGravando;

      cdsRelatorios: TZClient;

      procedure pOrdenaMenu(const mnuMenu: TMenuItem);
      Function fTemRelatorioMenu(strMenu, strCodRel: String): Boolean;
      Function fInsereOpcoesRelatorio(Progress : TcxProgressBar): Boolean;
      Function fSQLRelatorios: String;

      procedure pInsereListaMenu(Var arrLista: TArrMenu; objNovoItem: TMenuItem);
      procedure pHabilitaListaMenu(arrLista: TArrMenu; blnVisible: Boolean);

      procedure pChamaRelatorio(Sender: TObject);
      procedure pCadastroRelatorio(Sender: TObject);
      procedure pInsereOpcaoRelatorio(Item: TMenuItem);
      procedure pInsereOpcaoRelatorioMenus(Item: TMenuItem);
      Procedure pAdicionaRelatorio(strMenu, strCaption, strCodRel: String);
      Function fFormataVersao(const ATexto: string): string;
      Function fValidaRelatorioMenu(strExpress: String): Boolean;
      procedure pCarregaRelatoriosMenu(frmPrincipal: TForm; sltMnuIncluidos: TStringList);
      Function fInsereRelMenu(mnuRelatorio: TMenuItem; strCodRel, strNomRel: String): TMenuItem;

      Function fExcluiRelatoriosMenuProg(Progress : TcxProgressBar): Boolean;

      Function fGetCodigoRelatorio: String;
      Function fGetAutoincrem(strNomTab: String): String;

      Function fSalvaBackupProg(Progress : TcxProgressBar): Boolean;

    private
      class var FPedeDadosModalResult: TModalResult;
    public
      fecharJanelaDeDadosAoImprimir: Boolean;
      HndSelPedidoCompra: THandle;
      constructor Create(AOwner: TComponent;
                         blnExecutandoPeloMenu,
                         blnConexaoIndependente: Boolean;
                         AConexaoRelatorio: TCriarConexao;
                         blnApenasPrincipal: Boolean = False;
                         ATabelaFiltrosValores: string = 'CADVAL';
                         AArquivoSaidaDiretoPDF: string = '';
                         APathImagemCabecalho: string = '';
                         AExecutaRelatorioValidacao: Boolean = True;
                         AInicializacao: Boolean = False); Reintroduce;

      destructor Destroy; override;

      Class procedure pRefazComplemento(blnExecutandoPeloMenu,
                                        blnConexaoIndependente: Boolean;
                                        qryTabela: TUniQuery;
                                        objInterfaceCorrente: TInterfaceRelatorio;
                                        intRelat: Integer;
                                        Var objRelAntigo: TGeraFR3;
                                        Var blnPrecisaRefazer: Boolean; blnLeuDados: Boolean;
                                        Var objRel: TRelatorio;
                                        blnLiberarRel: Boolean = True;
                                        strNomCam: string = '';
                                        blnApenasPrincipal: Boolean = False;
                                        APathImagemCabecalho: string = '';
                                        AExecutaRelatorioValidacao: Boolean = True);

      class procedure pAtualizarParametrosRelatorio(strCodRel: String;
                                                    strCodOpe: String;
                                                    arrParametros: Array Of String;
                                                    arrValores: Array Of String;
                                                    arrMultiSelecao: array of String;
                                                    ATabelaFiltrosValores: string = 'CADVAL');

      Class function fRetornaCodigoRelatorioAtarel(strAtarel: String): String;

      Class function fEditarFiltrosRelatorio(strCodRel: String;
                                             arrParametrosReadOnly: TArrString;
                                             strDirAce: String;
                                             ATabelaFiltrosValores: string;
                                             blnEditarGatilho: Boolean = False;
                                             blnApenasSalvar: Boolean = False): Boolean;

      Class function fEditarFiltrosRelatorioAtarel(strAtaRel: String;
                                                   arrParametrosReadOnly: TArrString;
                                                   strDirAce: String;
                                                   ATabelaFiltrosValores: string;
                                                   blnEditarGatilho: Boolean = False;
                                                   blnApenasSalvar: Boolean = False): Boolean;

      Class procedure pExecutaRelatorio(strCodRel: String;
                                        arrParametrosReadOnly: TArrString = Nil;
                                        blnExecutarDireto: Boolean = False;
                                        blnExibeMensagem: Boolean =  True;
                                        strDirAce: String = '';
                                        blnApenasEditarFiltros: Boolean = False;
                                        blnUsuarioLogadoDefaultVerdeVermelho: Boolean = False;
                                        ATabelaFiltrosValores: string = 'CADVAL';
                                        AArquivoSaidaDiretoPDF: string = '';
                                        APathImagemCabecalho: string = '';
                                        AExecutaRelatorioValidacao: Boolean = True;
                                        objParametrosRelatorio: TParametrosRelatorio = Nil;
                                        blnEditarGatilho: Boolean = False;
                                        strUsuarioDireito: String = '';
                                        blnApenasSalvar: Boolean = False;
                                        objRel: TRelatorio = nil); Overload;

      Class Procedure pExecutaRelatorio(intCodigoAtalho,
                                        intChaveDefault: integer;
                                        intChavesPossiveis: Array Of Integer;
                                        arrParametros: Array Of String;
                                        arrValores: Array Of String;
                                        SenderChamada: TObject;
                                        arrParametrosReadOnly: TArrString = Nil;
                                        blnExecutarDireto: Boolean = False;
                                        blnExibirMensagem: Boolean = True;
                                        strDirAce: String = '';
                                        blnUsuarioLogadoDefaultVerdeVermelho: Boolean = False;
                                        objParametrosRelatorio: TParametrosRelatorio = Nil); Overload;

      Class procedure pExecutaRelatorio(var AJsonDadosEnviaWhatsapp: String;
                                        strCodRel: String;
                                        arrParametrosReadOnly: TArrString = Nil;
                                        blnExecutarDireto: Boolean = False;
                                        blnExibeMensagem: Boolean =  True;
                                        strDirAce: String = '';
                                        blnApenasEditarFiltros: Boolean = False;
                                        blnUsuarioLogadoDefaultVerdeVermelho: Boolean = False;
                                        ATabelaFiltrosValores: string = 'CADVAL';
                                        AArquivoSaidaDiretoPDF: string = '';
                                        APathImagemCabecalho: string = '';
                                        AExecutaRelatorioValidacao: Boolean = True;
                                        objParametrosRelatorio: TParametrosRelatorio = Nil;
                                        blnEditarGatilho: Boolean = False;
                                        strUsuarioDireito: String = '';
                                        blnApenasSalvar: Boolean = False); Overload;

      Class Procedure pExecutaRelatorioAtarel(strAtarel: String;
                                              arrParametrosReadOnly: TArrString = Nil;
                                              blnExecutarDireto: Boolean = False;
                                              blnExibeMensagem: Boolean =  True;
                                              strDirAce: String = '';
                                              blnApenasEditarFiltros: Boolean = False;
                                              blnUsuarioLogadoDefaultVerdeVermelho: Boolean = False;
                                              ATabelaFiltrosValores: string = 'CADVAL';
                                              AArquivoSaidaDiretoPDF: string = '';
                                              APathImagemCabecalho: string = '';
                                              AExecutaRelatorioValidacao: Boolean = True;
                                              objParametrosRelatorio: TParametrosRelatorio = Nil;
                                              blnEditarGatilho: Boolean = False;
                                              strUsuarioDireito: String = '';
                                              blnApenasSalvar: Boolean = False);

      Class Function fExecutaRelatorioJson(strCodRel: String;
                                           Var strJson: String;
                                           arrParametrosReadOnly: TArrString = Nil;
                                           blnExecutarDireto: Boolean = False;
                                           blnExibeMensagem: Boolean =  True;
                                           strDirAce: String = '';
                                           blnValidacao: Boolean = False;
                                           blnDestinoJson: Boolean = False;
                                           blnMostrarProgresso: Boolean = True): Boolean; Overload;

      Class Function fExecutaRelatorioJson(intCodigoAtalho,
                                           intChaveDefault: integer;
                                           intChavesPossiveis: Array Of Integer;
                                           arrParametros: Array Of String;
                                           arrValores: Array Of String;
                                           SenderChamada: TObject;
                                           Var strJson: String;
                                           arrParametrosReadOnly: TArrString = Nil;
                                           blnExecutarDireto: Boolean = False;
                                           blnExibirMensagem: Boolean = True;
                                           strDirAce: String = '';
                                           blnDestinoJson: Boolean = False;
                                           blnMostrarProgresso: Boolean = True): Boolean; Overload;

      Class Function fExecutaRelatorio(strCodRel: String;
                                       arrParametrosReadOnly: TArrString = Nil;
                                       blnExecutarDireto: Boolean = False;
                                       blnExibeMensagem: Boolean =  True;
                                       strDirAce: String = '';
                                       blnValidacao: Boolean = False;
                                       blnDestinoJson: Boolean = False;
                                       blnMostrarProgresso: Boolean = True): Boolean; Overload;

      Class Function fExecutaRelatorioRetorno(objRel: TRelatorio;
                                              strCodRel: String;
                                              arrParametrosReadOnly: TArrString = Nil;
                                              blnExecutarDireto: Boolean = False;
                                              blnExibeMensagem: Boolean =  True;
                                              strDirAce: String = '';
                                              blnValidacao: Boolean = False;
                                              objRetornoRelatorio: TRetornoRelatorio = Nil): Boolean;

      Class Function fExecutaRelatorio(intCodigoAtalho,
                                       intChaveDefault: integer;
                                       intChavesPossiveis: Array Of Integer;
                                       arrParametros: Array Of String;
                                       arrValores: Array Of String;
                                       SenderChamada: TObject;
                                       arrParametrosReadOnly: TArrString = Nil;
                                       blnExecutarDireto: Boolean = False;
                                       blnExibirMensagem: Boolean = True;
                                       strDirAce: String = '';
                                       blnDestinoJson: Boolean = False;
                                       blnMostrarProgresso: Boolean = True): Boolean; Overload;

      Class Function fRetornaSelectEditorDashBoard(strCodRel: String; Var strTemporarias: String): string; Overload;

      Class Function fRetornaSelectEditorDashBoard(intCodigoAtalho,
                                                   intChaveDefault: integer;
                                                   arrParametros: Array Of String;
                                                   arrValores: Array Of String;
                                                   Var strTemporarias: String): string; Overload;

      Class Function fRetornaJsonEditorDashBoard(intCodigoAtalho,
                                                 intChaveDefault: integer;
                                                 arrParametros: Array Of String;
                                                 arrValores: Array Of String;
                                                 blnMostrarProgresso: Boolean;
                                                 blnExecutarDireto: Boolean = True): string; Overload;

      Class Function fRetornaUrlDashBoardGatilho(strCodRel: String;
                                                 arrParametrosReadOnly: TArrString = Nil;
                                                 blnExecutarDireto: Boolean = False;
                                                 strDirAce: String = '';
                                                 blnApenasEditarFiltros: Boolean = False;
                                                 blnUsuarioLogadoDefaultVerdeVermelho: Boolean = False;
                                                 ATabelaFiltrosValores: string = 'CADVAL';
                                                 AArquivoSaidaDiretoPDF: string = '';
                                                 APathImagemCabecalho: string = '';
                                                 AExecutaRelatorioValidacao: Boolean = True;
                                                 strUsuarioDireito: String = '';
                                                 objRel: TRelatorio = nil): string; Overload;

      class function fRetornaUrlDashBoardGatilho(var AJsonDadosEnviaWhatsapp: String;
                                                 strCodRel: String;
                                                 arrParametrosReadOnly: TArrString = Nil;
                                                 blnExecutarDireto: Boolean = False;
                                                 strDirAce: String = '';
                                                 blnApenasEditarFiltros: Boolean = False;
                                                 blnUsuarioLogadoDefaultVerdeVermelho: Boolean = False;
                                                 ATabelaFiltrosValores: string = 'CADVAL';
                                                 AArquivoSaidaDiretoPDF: string = '';
                                                 APathImagemCabecalho: string = '';
                                                 AExecutaRelatorioValidacao: Boolean = True;
                                                 strUsuarioDireito: String = ''): string; Overload;


      Class Procedure pSalvaParametros(strAutRel: String;
                                       arrParametros: Array Of String;
                                       arrValores: Array Of String);

      Class Function fVerificaSeRelatorioExiste(intCodigoAtalho,
                                                intChaveDefault: integer): Boolean; Overload;

      procedure pHabilitaMenus;

      procedure pInicializaRelatorio(objRel: TRelatorio;
                                     qryTabela: TUniQuery;
                                     objRelatorioRetorno: TRetornoRelatorio;
                                     objInterfaceCorrente: TInterfaceRelatorio = Nil);

      procedure pInsereOpcoesRelatorio(frmPrincipal: TForm; mnuAutcomK: TAdvMainMenu; mnuRelatorio: TarrMenu; blnProgresso: Boolean);

      class function fRelatorioDefinidoDiferenteDoPadrao(intCodigoAtalho: integer; var strChaOri: String): Boolean;

      Class Function fSelecionaRelatorioAtalho(intCodigoAtalho: Integer;
                                               intChavesPossiveis: Array Of Integer;
                                               arrParametros: Array Of String;
                                               intChaveDefault: Integer): Boolean;

      Function fInsereRelatorioMenu(strCodRel, strNomRel: String): Boolean;

      Procedure pMostraRelatoriosMenu(frmPrincipal: TForm);

      Function fExcluiRelatoriosMenu: Boolean;

      Function fSalvaBackup(strCodRel: String): Boolean;

      Function fRealocaMenu(strCodRel: String; frmPrincipal: TForm; mnuAutcomK: TAdvMainMenu): Boolean;
      Function fTemChaveRelatotio(intChave: Integer): Boolean;

      procedure pGravaRelVrs(strCodRel, strVerRel: String);
      procedure pGravaMD5Comp(strAutInc: String);
      Function fLimpaFiltrosNaoUtilizados(strCodRel: String): Boolean;

      Function fPreparaRelatorio(strCodRel: String): Boolean;

      Class Function fExecutaRelatorioCodigo(strCodRel: String;
                                             arrParametros: Array Of String;
                                             arrValores: Array Of String;
                                             arrParametrosReadOnly: TArrString = Nil;
                                             blnExecutarDireto: Boolean = False;
                                             blnExibirMensagem: Boolean = True;
                                             strDirAce: String = '';
                                             blnValidacao: Boolean = False;
                                             objRetornoRelatorio: TRetornoRelatorio = Nil;
                                             fcharJanelaDeDadosAoImprimir: Boolean = False;
                                             HandleSelPedidoCompra: THandle =0): Boolean;

      Class Function fExecutaRelatorioCodigoRetorno(objRelatorio: TRelatorio;
                                                    strCodRel: String;
                                                    arrParametros: Array Of String;
                                                    arrValores: Array Of String;
                                                    arrParametrosReadOnly: TArrString = Nil;
                                                    blnExecutarDireto: Boolean = False;
                                                    blnExibirMensagem: Boolean = True;
                                                    strDirAce: String = '';
                                                    blnValidacao: Boolean = False;
                                                    objRetornoRelatorio: TRetornoRelatorio = Nil): Boolean;

    published

      Property objInterface: TInterfaceRelatorio Read FInterface Write FInterface;
      Property objGeraFr3: TGeraFr3 Read FGeraFr3 Write FGeraFr3;

      Property objRotinasFiltro: TRotinasGrid Read FRotinasFiltro Write FRotinasFiltro;
      Property objRotinasGrid: TRotinasGrid Read FRotinasGrid Write FRotinasGrid;
  end;

implementation

Uses
  StrUtils,
  untCadRelatorios,
  untConsultaRelatMenu,
  untSelecionaRelAtalho,
  untFuncoesRel,
  untVersaoProg,
  TConverte;

constructor TRelatorio.Create(AOwner: TComponent;
                              blnExecutandoPeloMenu,
                              blnConexaoIndependente: Boolean;
                              AConexaoRelatorio: TCriarConexao;
                              blnApenasPrincipal: Boolean = False;
                              ATabelaFiltrosValores: string = 'CADVAL';
                              AArquivoSaidaDiretoPDF: string = '';
                              APathImagemCabecalho: string = '';
                              AExecutaRelatorioValidacao: Boolean = True;
                              AInicializacao: Boolean = False);
begin
  inherited Create(AOwner);

  FTabela := Nil;
  FOrdena := True;
  FInicia := AInicializacao;

  SetLength(arrNotOrdInd, 0);
  SetLength(arrOrdInd, 0);
  SetLength(arrComEmp, 0);
  SetLength(arrComGer, 0);
  SetLength(arrCtaEmp, 0);
  SetLength(arrCtaGer, 0);
  SetLength(arrCEvEmp72, 0);
  SetLength(arrCEvGer72, 0);
  SetLength(arrCEvEmp74, 0);
  SetLength(arrCEvGer74, 0);
  SetLength(arrRefPre, 0);
  SetLength(arrPecPen, 0);
  SetLength(arrPecCli, 0);
  SetLength(arrEncFAn, 0);
  SetLength(arrEncFSi, 0);
  SetLength(arrKarTin, 0);
  SetLength(arrMkpOp1, 0);
  SetLength(arrMkpOp2, 0);
  SetLength(arrMkpOp3, 0);
  SetLength(arrGerPix, 0);
  SetLength(arrModOp1, 0);
  SetLength(arrModOp2, 0);
  SetLength(arrModOp3, 0);
  SetLength(arrSheWin, 0);
  SetLength(arrVenCcr, 0);
  SetLength(arrAnaDes, 0);
  SetLength(arrLiqVen, 0);
  SetLength(arrUsaWms, 0);
  SetLength(arrUsaTmq, 0);
  SetLength(arrTipEst, 0);
  SetLength(arrTabPrf, 0);
  SetLength(arrTabDin, 0);
  SetLength(arrGirEst, 0);
  SetLength(arrMetGru, 0);
  SetLength(arrMetMar, 0);
  SetLength(arrEveCta74,0);
  SetLength(arrGarantia72,0);
  SetLength(arrApuICMS,0);
  SetLength(arrMODRCM1,0);
  SetLength(arrMODRCM2,0);
  SetLength(arrRFMOD1,0);
  SetLength(arrAJUEST,0);
  SetLength(arrTITPAGCHQ,0);
  SetLength(arrDEMFLUCAI,0);
  SetLength(arrPOSCONPAG,0);
  SetLength(arrTITDELPAG,0);
  SetLength(arrORDEMSERV,0);
  SetLength(arrCOMFAT,0);
  SetLength(arrVPREDT,0);
  SetLength(arrUSAFLE,0);
  SetLength(arrEnvReq,0);
  SetLength(arrRelCon,0);
  SetLength(arrWhatsapp,0);
  SetLength(arrRelEstTer,0);
  FExcluirDaTabelaMenu := True;

  FInterface := TInterfaceRelatorio.Create(Self, blnExecutandoPeloMenu, AConexaoRelatorio, blnConexaoIndependente,
                                           blnApenasPrincipal, ATabelaFiltrosValores, AArquivoSaidaDiretoPDF,
                                           APathImagemCabecalho, AExecutaRelatorioValidacao);

  FGeraFr3 := TGeraFR3.Create(Self);
  FGeraFr3.strPatImgCab := APathImagemCabecalho;
  FInterface.objGeraFr3 := FGeraFr3;

  FRotinasFiltro := TRotinasGrid.Create(Self, tpcTelaFiltros);
  FRotinasFiltro.objInteface := FInterface;

  FRotinasGrid := TRotinasGrid.Create(Self, tpcGrid);
  FRotinasGrid.objInteface := FInterface;

  FInterface.objRotinasFiltro := FRotinasFiltro;
  FInterface.objRotinasGrid   := FRotinasGrid;
end;

destructor TRelatorio.Destroy;
begin
  inherited;

  SetLength(arrNotOrdInd, 0);
  SetLength(arrOrdInd, 0);
  SetLength(arrComEmp, 0);
  SetLength(arrComGer, 0);
  SetLength(arrCtaEmp, 0);
  SetLength(arrCtaGer, 0);
  SetLength(arrCEvEmp72, 0);
  SetLength(arrCEvGer72, 0);
  SetLength(arrCEvEmp74, 0);
  SetLength(arrCEvGer74, 0);
  SetLength(arrRefPre, 0);
  SetLength(arrPecPen, 0);
  SetLength(arrPecCli, 0);
  SetLength(arrEncFAn, 0);
  SetLength(arrEncFSi, 0);
  SetLength(arrKarTin, 0);
  SetLength(arrMkpOp1, 0);
  SetLength(arrMkpOp2, 0);
  SetLength(arrMkpOp3, 0);
  SetLength(arrGerPix, 0);
  SetLength(arrModOp1, 0);
  SetLength(arrModOp2, 0);
  SetLength(arrModOp3, 0);
  SetLength(arrSheWin, 0);
  SetLength(arrVenCcr, 0);
  SetLength(arrAnaDes, 0);
  SetLength(arrLiqVen, 0);
  SetLength(arrUsaWms, 0);
  SetLength(arrUsaTmq, 0);
  SetLength(arrTipEst, 0);
  SetLength(arrTabPrf, 0);
  SetLength(arrTabDin, 0);
  SetLength(arrCadLoc, 0);
  SetLength(arrEndScc, 0);
  SetLength(arrRelPar, 0);
  SetLength(arrConVis, 0);
  SetLength(arrUraPel, 0);
  SetLength(arrGirEst, 0);
  SetLength(arrMetGru, 0);
  SetLength(arrMetMar, 0);
  SetLength(arrEveCta74,0);
  SetLength(arrGarantia72,0);
  SetLength(arrApuICMS,0);
  SetLength(arrMODRCM1,0);
  SetLength(arrMODRCM2,0);
  SetLength(arrRFMOD1,0);
  SetLength(arrAJUEST,0);
  SetLength(arrTITPAGCHQ,0);
  SetLength(arrDEMFLUCAI,0);
  SetLength(arrPOSCONPAG,0);
  SetLength(arrTITDELPAG,0);
  SetLength(arrORDEMSERV,0);
  SetLength(arrCOMFAT,0);
  SetLength(arrVPREDT,0);
  SetLength(arrUSAFLE,0);
  SetLength(arrEnvReq,0);
  SetLength(arrRelCon,0);
  SetLength(arrWhatsapp,0);
  SetLength(arrRelEstTer,0);
end;

procedure TRelatorio.pInicializaRelatorio(objRel: TRelatorio;
                                          qryTabela: TUniQuery;
                                          objRelatorioRetorno: TRetornoRelatorio;
                                          objInterfaceCorrente: TInterfaceRelatorio = Nil);
Begin
  objInterface.objRelatorioRetorno := objRelatorioRetorno;
  objInterface.arrCadRel[0] := qryTabela;
  objInterface.strTitulo    := qryTabela.FieldByName('REL_DESCRI').AsString;
  objInterface.strSubTitulo := qryTabela.FieldByName('REL_SUBTIT').AsString;

  objInterface.strIdentRel  := 'Relatorio' + qryTabela.FieldByName('REL_CODREL').AsString;

  objInterface.fCarregaParametros(qryTabela.FieldByName('AUTOINCREM').AsString,
                                  qryTabela.FieldByName('REL_COMFIL').AsString);

  objInterface.fCarregaComplementos(qryTabela.FieldByName('AUTOINCREM').AsString);
  objInterface.fCarregaChilds(qryTabela.FieldByName('AUTOINCREM').AsString);

  objInterface.fCarregaCampos(qryTabela.FieldByName('AUTOINCREM').AsString);
  objInterface.fCarregaCamposRodape(qryTabela.FieldByName('AUTOINCREM').AsString);

  objInterface.pSetaEditavel;

  objInterface.strSQL    := qryTabela.FieldByName('REL_SQLDEF').AsString;

  If objInterface.strSQL.IsEmpty Then
    objInterface.strSQL   := AnsiReplaceStr(qryTabela.FieldByName('REL_DEFSQL').AsString, '<<csq>>', #13#10);

  objInterface.strSQLFil := AnsiReplaceStr(qryTabela.FieldByName('REL_SQLFIL').AsString, '<<csq>>', #13#10);

  objGeraFr3.strSQL     := objInterface.strSQL;

  objInterface.pCompCarregaComplementosChilds;

  objInterface.pCarregaParametrosValidacao;

  objGeraFr3.objInterfaceGera := objInterface;

  objGeraFr3.cdsParams  := objInterface.cdsParams;
  objGeraFr3.cdsParamsAut := objInterface.cdsParametrosAutomaticos;
  objGeraFr3.cdsCamposG := objInterface.cdsCampos;
  objGeraFr3.arrCadRel  := objInterface.arrCadRel;
  objGeraFr3.blnTemArquivoSaida := qryTabela.FieldByName('REL_ARQSAI').AsString = 'S';

  objGeraFr3.objInterfaceGeraPrincipal := objInterfaceCorrente;

  objInterface.objRotinasFiltro.fCarregaRotinasRelatorio(qryTabela.FieldByName('AUTOINCREM').AsString);
  objInterface.objRotinasGrid.fCarregaRotinasRelatorio(qryTabela.FieldByName('AUTOINCREM').AsString);
End;

Class procedure TRelatorio.pRefazComplemento(blnExecutandoPeloMenu,
                                             blnConexaoIndependente: Boolean;
                                             qryTabela: TUniQuery;
                                             objInterfaceCorrente: TInterfaceRelatorio;
                                             intRelat: Integer;
                                             Var objRelAntigo: TGeraFR3;
                                             Var blnPrecisaRefazer: Boolean; blnLeuDados: Boolean;
                                             Var objRel: TRelatorio;
                                             blnLiberarRel: Boolean = True;
                                             strNomCam: string = '';
                                             blnApenasPrincipal: Boolean = False;
                                             APathImagemCabecalho: string = '';
                                             AExecutaRelatorioValidacao: Boolean = True);

Begin
  objRel := TRelatorio.Create(Nil, blnExecutandoPeloMenu, blnConexaoIndependente,
                              objInterfaceCorrente.conConexaoRelatorio, blnApenasPrincipal,
                              objInterfaceCorrente.strTabelaFiltrosValores, '',
                              APathImagemCabecalho, AExecutaRelatorioValidacao);

  With objRel Do
  Begin
    pInicializaRelatorio(objRel, qryTabela, Nil, objInterfaceCorrente);

    If SameText(qryTabela.FieldByName('REL_HORIZO').AsString, 'S') And
      (Not objInterface.fAbreConsultaCampos And objInterface.fCriaHorizo(0)) Then
    Begin
      FreeAndNil(objRel);
      Exit;
    End;

    If Assigned(objInterfaceCorrente) Then
      objInterfaceCorrente.strScriptImplementation := '';

    blnPrecisaRefazer := objInterface.fPrecisaRefazerFr3;

    If blnPrecisaRefazer And blnLeuDados Then
    Begin
      objGeraFr3.blnEhComplemento := True;

      objGeraFr3.intRelatPos := intRelat;

      // restaurando valores durante criação de novo objeto GeraFR3

      objGeraFr3.arrControleRel := objRelAntigo.arrControleRel;
      objGeraFr3.arrCadRel      := objRelAntigo.arrCadRel;
      objGeraFr3.pSetaTamanhoDados(Length(objRelAntigo.arrCadRel));
      objGeraFr3.qryDados       := objRelAntigo.qryDados;
      objGeraFr3.qryDadosOrig   := objRelAntigo.qryDadosOrig;
      objGeraFr3.qryFiltros     := objRelAntigo.qryFiltros;

      // fim da restauração de valores

      objGeraFr3.desDestinoFr3 := objInterface.fRetDestino;

      If objGeraFr3.desDestinoFr3 In [desVideo, desDesignReport, desImpressora, desPDF, desEmail] Then
        objGeraFr3.strCodMod := qryTabela.FieldByName('REL_CODMOD').AsString;

      objGeraFr3.cdsComple := objInterface.cdsComplementos;

      If objGeraFr3.fAtualizaPapel(qryTabela) And
         objGeraFr3.fGerarFr3(qryTabela.FieldByName('REL_CODREL').AsString,
                              objInterface.objConsulta, blnLeuDados,
                              objInterfaceCorrente.fRetColunasDados,
                              strNomCam) Then
       { objGeraFr3.fSaveReport(qryTabela)};

      If Assigned(objInterfaceCorrente) Then
        objInterfaceCorrente.strScriptImplementation := objGeraFr3.stlScriptImplementation.Text;
    End;

    If blnLiberarRel Then
      FreeAndNil(objRel);

  End;
End;

Class function TRelatorio.fEditarFiltrosRelatorio(strCodRel: String;
                                                  arrParametrosReadOnly: TArrString;
                                                  strDirAce: String;
                                                  ATabelaFiltrosValores: string;
                                                  blnEditarGatilho: Boolean = False;
                                                  blnApenasSalvar: Boolean = False): Boolean;
begin
  TRelatorio.pExecutaRelatorio(strCodRel,
                               arrParametrosReadOnly,
                               False,
                               True,
                               strDirAce,
                               True,
                               True,
                               ATabelaFiltrosValores,
                               '',
                               '',
                               True,
                               Nil,
                               blnEditarGatilho,
                               '',
                               blnApenasSalvar);


  Result := TRelatorio.FPedeDadosModalResult = mrOk;
end;

Class function TRelatorio.fEditarFiltrosRelatorioAtarel(strAtaRel: String;
                                                        arrParametrosReadOnly: TArrString;
                                                        strDirAce: String;
                                                        ATabelaFiltrosValores: string;
                                                        blnEditarGatilho: Boolean = False;
                                                        blnApenasSalvar: Boolean = False): Boolean;
var
  strCodRel: String;
begin
  strCodRel := fRetornaCodigoRelatorioAtarel(strAtaRel);

  if (fEmptyStr(strCodRel)) Then
    Exit(False);

  TRelatorio.pExecutaRelatorio(strCodRel,
                                 arrParametrosReadOnly,
                                 False,
                                 True,
                                 strDirAce,
                                 True,
                                 True,
                                 ATabelaFiltrosValores,
                                 '',
                                 '',
                                 True,
                                 Nil,
                                 blnEditarGatilho,
                                 '',
                                 blnApenasSalvar);


  Result := TRelatorio.FPedeDadosModalResult = mrOk;

end;

Class procedure TRelatorio.pExecutaRelatorioAtarel(strAtarel: String;
                                             arrParametrosReadOnly: TArrString = Nil;
                                             blnExecutarDireto: Boolean = False;
                                             blnExibeMensagem: Boolean =  True;
                                             strDirAce: String = '';
                                             blnApenasEditarFiltros: Boolean = False;
                                             blnUsuarioLogadoDefaultVerdeVermelho: Boolean = False;
                                             ATabelaFiltrosValores: string = 'CADVAL';
                                             AArquivoSaidaDiretoPDF: string = '';
                                             APathImagemCabecalho: string = '';
                                             AExecutaRelatorioValidacao: Boolean = True;
                                             objParametrosRelatorio: TParametrosRelatorio = Nil;
                                             blnEditarGatilho: Boolean = False;
                                             strUsuarioDireito: String = '';
                                             blnApenasSalvar: Boolean = False);
Var
  strCodRel: String;
begin
  strCodRel := fRetornaCodigoRelatorioAtarel(strAtaRel);

  if (fEmptyStr(strCodRel)) Then
    Exit;

  pExecutaRelatorio(strCodRel,
                    arrParametrosReadOnly,
                    blnExecutarDireto,
                    blnExibeMensagem,
                    strDirAce,
                    blnApenasEditarFiltros,
                    blnUsuarioLogadoDefaultVerdeVermelho,
                    ATabelaFiltrosValores,
                    AArquivoSaidaDiretoPDF,
                    APathImagemCabecalho,
                    AExecutaRelatorioValidacao,
                    objParametrosRelatorio,
                    blnEditarGatilho,
                    strUsuarioDireito,
                    blnApenasSalvar);

end;


Class procedure TRelatorio.pExecutaRelatorio(strCodRel: String;
                                             arrParametrosReadOnly: TArrString = Nil;
                                             blnExecutarDireto: Boolean = False;
                                             blnExibeMensagem: Boolean =  True;
                                             strDirAce: String = '';
                                             blnApenasEditarFiltros: Boolean = False;
                                             blnUsuarioLogadoDefaultVerdeVermelho: Boolean = False;
                                             ATabelaFiltrosValores: string = 'CADVAL';
                                             AArquivoSaidaDiretoPDF: string = '';
                                             APathImagemCabecalho: string = '';
                                             AExecutaRelatorioValidacao: Boolean = True;
                                             objParametrosRelatorio: TParametrosRelatorio = Nil;
                                             blnEditarGatilho: Boolean = False;
                                             strUsuarioDireito: String = '';
                                             blnApenasSalvar: Boolean = False;
                                             objRel: TRelatorio = nil);
  Var
    qryTabela,
    qryConsulta: TUniQuery;
    blnContinua: Boolean;
    blnObjRelExterno: Boolean;
Begin

  // Verificações de direito de acesso
  //   1 tem DIROPE ou DIRGPO, então valida
  //   2 tem DIRACE (antes fixo no Delphi), então valida
  //   3 tem DIRANT (pega do CADREL), então valida
  //   4 não tem nenhum deles, deixa passar

  blnContinua := True;

  blnObjRelExterno := Assigned(objRel);

  if not fVerificaAcessoSistema('frm' + strCodRel + 'Rel', strUsuarioDireito) then
  begin
    if not fEmptyStr(strDirAce) then
    begin
      if not fVerificaAcessoSistema(strDirAce) then
        blnContinua := False;
    end
    else
    begin
      qryConsulta := fCriaQuery;
      try
        qryConsulta.SQL.Text := 'SELECT REL_DIRANT FROM CADREL WHERE REL_CODREL = :CODREL';
        qryConsulta.ParamByName('CODREL').AsString := strCodRel;
        qryConsulta.Open;
        if not fEmptyStr(qryConsulta.FieldByName('REL_DIRANT').AsString) then
          if not fVerificaAcessoSistema(qryConsulta.FieldByName('REL_DIRANT').AsString) then
            blnContinua := False;
      finally
        FreeAndNil(qryConsulta);
      end;
    end;
  end;

  if not blnContinua then
  begin
    pMensagemOk('Operador não tem direito de acesso ao relatório!');
    Exit;
  end;

  Try
    qryTabela := fCriaQuery;
    qryTabela.SQL.Text := 'SELECT * FROM CADREL WHERE REL_CODREL = :CODREL';
    qryTabela.ParamByName('CODREL').AsString := strCodRel;
    qryTabela.Open;

    If qryTabela.IsEmpty Then
    Begin
      pMensagemOk('Código do Relatório ' + strCodRel + ' não encontrado!');
    End Else
    Begin
      if not blnObjRelExterno then
        objRel := TRelatorio.Create(Nil, True, SameText(qryTabela.FieldByName('REL_CONIND').AsString, 'S'), Nil,
                                    False, ATabelaFiltrosValores, AArquivoSaidaDiretoPDF, APathImagemCabecalho,
                                    AExecutaRelatorioValidacao);

      With objRel Do
      Begin
        pInicializaRelatorio(objRel, qryTabela, Nil);

        If SameText(qryTabela.FieldByName('REL_HORIZO').AsString, 'S') And
          (Not objInterface.fAbreConsultaCampos And  objInterface.fCriaHorizo(0)) Then
        Begin
          FreeAndNil(qryTabela);
          if not blnObjRelExterno then
            FreeAndNil(objRel);
          Exit;
        End;

        objInterface.arrParametrosReadOnly := arrParametrosReadOnly;
        objInterface.blnExibirMensagem := blnExibeMensagem;
        objInterface.blnApenasEditarFiltros := blnApenasEditarFiltros;
        objInterface.blnUsuarioLogadoDefaultVerdeVermelho := blnUsuarioLogadoDefaultVerdeVermelho;
        objInterface.blnRetornoDados := False;
        objInterface.objParametrosRelatorio := objParametrosRelatorio;
        objInterface.blnEditarGatilho := blnEditarGatilho;
        objInterface.blnApenasSalvar := blnApenasSalvar;

        If objInterface.fPrecisaRefazerFr3 Then
        Begin
          objGeraFr3.desDestinoFr3 := TInterfaceRelatorio.fDestinoToTipo(qryTabela.FieldByName('REL_DESTIN').AsString);

         If objGeraFr3.desDestinoFr3 In [desVideo, desDesignReport, desImpressora, desPDF, desEmail] Then
           objGeraFr3.strCodMod := qryTabela.FieldByName('REL_CODMOD').AsString;

          objGeraFr3.cdsComple := objInterface.cdsComplementos;

          If (Not (objGeraFr3.desDestinoFr3 In [desVideo, desDesignReport, desImpressora, desPDF, desEmail])) Or
             objGeraFr3.fAtualizaPapel(qryTabela) Then
          Begin
            objInterface.pPedeDados(blnExecutarDireto, False, FPedeDadosModalResult);
          End;

        End Else
        Begin
          If objGeraFr3.fCarregaReport(qryTabela) Then
            objInterface.pPedeDados(blnExecutarDireto, False, FPedeDadosModalResult);
        End;
      End;

      if not blnObjRelExterno then
        FreeAndNil(objRel);
    End;

    FreeAndNil(qryTabela);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TRelatorio.pExecutaRelatorio]');
    End;
  End;
End;

Class procedure TRelatorio.pExecutaRelatorio(var AJsonDadosEnviaWhatsapp: String;
                                             strCodRel: String;
                                             arrParametrosReadOnly: TArrString = Nil;
                                             blnExecutarDireto: Boolean = False;
                                             blnExibeMensagem: Boolean =  True;
                                             strDirAce: String = '';
                                             blnApenasEditarFiltros: Boolean = False;
                                             blnUsuarioLogadoDefaultVerdeVermelho: Boolean = False;
                                             ATabelaFiltrosValores: string = 'CADVAL';
                                             AArquivoSaidaDiretoPDF: string = '';
                                             APathImagemCabecalho: string = '';
                                             AExecutaRelatorioValidacao: Boolean = True;
                                             objParametrosRelatorio: TParametrosRelatorio = Nil;
                                             blnEditarGatilho: Boolean = False;
                                             strUsuarioDireito: String = '';
                                             blnApenasSalvar: Boolean = False);
var
  objRel: TRelatorio;
begin
  objRel := TRelatorio.Create(Nil,
                              True,
                              True,
                              Nil,
                              False,
                              ATabelaFiltrosValores,
                              AArquivoSaidaDiretoPDF,
                              APathImagemCabecalho,
                              AExecutaRelatorioValidacao);
  try
    pExecutaRelatorio(strCodRel,
                      arrParametrosReadOnly,
                      blnExecutarDireto,
                      blnExibeMensagem,
                      strDirAce,
                      blnApenasEditarFiltros,
                      blnUsuarioLogadoDefaultVerdeVermelho,
                      ATabelaFiltrosValores,
                      AArquivoSaidaDiretoPDF,
                      APathImagemCabecalho,
                      AExecutaRelatorioValidacao,
                      objParametrosRelatorio,
                      blnEditarGatilho,
                      strUsuarioDireito,
                      blnApenasSalvar,
                      objRel);

    AJsonDadosEnviaWhatsapp := objRel.objInterface.strDadosJsonEnviaWhatsapp;
  finally
    FreeAndNil(objRel);
  end;
end;

Function TRelatorio.fPreparaRelatorio(strCodRel: String): Boolean;
Begin
  Try
    If Not Assigned(FTabela) Then
      FTabela := fCriaQuery(Self);

    FTabela.Close;
    FTabela.SQL.Text := 'SELECT * FROM CADREL WHERE REL_CODREL = :CODREL';
    FTabela.ParamByName('CODREL').AsString := strCodRel;
    FTabela.Open;

    If FTabela.IsEmpty Then
    Begin
      pMensagemOk('Código do Relatório ' + strCodRel + ' não encontrado!');
      Result := False;
    End Else
    Begin

      pInicializaRelatorio(Self, FTabela, Nil);

      objInterface.blnExecutaPelaInterface := False;

      If SameText(FTabela.FieldByName('REL_HORIZO').AsString, 'S') And
        (Not objInterface.fAbreConsultaCampos And objInterface.fCriaHorizo(0)) Then
      Begin
        Result := False
      End Else
      Begin
        Result := objInterface.fCarregaParametrosExcecucao;
      End;

    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TRelatorio.fPreparaRelatorio]');
    End;
  End;
End;

procedure TRelatorio.pCadastroRelatorio(Sender: TObject);
  Var
    frmCadRelatorios : TfrmCadRelatorios;
Begin
  pCriarFormularios(TfrmCadRelatorios, frmCadRelatorios);

  With frmCadRelatorios Do
  Begin
    frmFormMenu := FfrmPrincipal;
    mnuAutcom   := FmnuAutcom;
    FobjMenu    := TMenuItem((Sender As TComponent).Owner);
    objRelMenu  := Self;
    ShowModal;
  End;

  pFreeAndNil(frmCadRelatorios);
End;

procedure TRelatorio.pInsereOpcaoRelatorio(Item: TMenuItem);
  Var
    mnuInsertRel: TMenuItem;
Begin
  mnuInsertRel := TMenuItem.Create(Item);
  mnuInsertRel.Caption := MOME_MENU_CRIAREL;
  mnuInsertRel.Hint := 'frm' + Item.Name + 'Rel';
  mnuInsertRel.Name := Item.Name + 'Rel';
  mnuInsertRel.OnClick := pCadastroRelatorio;
  Item.Add(mnuInsertRel);
End;

procedure TRelatorio.pInsereOpcaoRelatorioMenus(Item: TMenuItem);
  Var
    intContador: Integer;
Begin
  If (Pos(Item.Name, ITEM_MENU_IGNORAR) <= 0)                And
     ((Item.count > 0)                                  		 Or
     SameText(Item.Hint, 'frmRelEstMovSaldoBal')      			 Or
     SameText(Item.Hint, 'frmLogCpr')                 			 Or
     SameText(Item.Hint, 'frmRelClientes')             			 Or
     SameText(Item.Hint, 'frmRelVendedor')             			 Or
     SameText(Item.Hint, 'frmRelEstCompForn')          			 Or
     SameText(Item.Hint, 'frmRelFornecedores')         			 Or
     SameText(Item.Hint, 'frmRelItensPromocao')        			 Or
     SameText(Item.Hint, 'frmRelEstKardexSint')        			 Or
     SameText(Item.Hint, 'frmRelEstListaPrecosGComp')  			 Or
     SameText(Item.Hint, 'frmGarantia')                			 Or
     SameText(Item.Hint, 'frmRelClientesPromocao')     			 Or
     SameText(Item.Hint, 'frmRelLocacaoEquipamentos')  			 Or
     SameText(Item.Hint, 'frmRelFiscProdutoControlado')      Or
     SameText(Item.Hint, 'frmRelFiscSaiSTDadosEntrada')      Or
     SameText(Item.Hint, 'frmRelCtrAnaCreditos')             Or
     SameText(Item.Hint, 'frmRelCtrComVendedor')             Or
     SameText(Item.Hint, 'frmRelCtrTitReceb')                Or
     SameText(Item.Hint, 'frmRelCtrCartoes')                 Or
     SameText(Item.Hint, 'frmRelCtpTitPortador')             Or
     SameText(Item.Hint, 'frmRelCtpTitContasAno')            Or
     SameText(Item.Hint, 'frmRelCtpAnaDebitos')              Or
     SameText(Item.Hint, 'frmRelCtpTitContas')               Or
     SameText(Item.Hint, 'frmRelBancFluxoCaixa')             Or
     SameText(Item.Hint, 'frmGarantia')                      Or
     SameText(Item.Hint, 'frmRelEstatAbcClientes')           Or
     SameText(Item.Hint, 'frmDASAbcClientes')                Or
     SameText(Item.Hint, 'frmRelEstatPesquisaMercado')       Or
     SameText(Item.Hint, 'frmRelLstPreAlt'           )       Or
     SameText(Item.Hint, 'mnuRELOPI')                        Or
     SameText(Item.Hint, 'frmRelOrdPro')                     Or
     SameText(Item.Hint, 'frmRelEstInvFisico')               Or
     SameText(Item.Hint, 'frmRelFiscDesvaProd')              Or
     SameText(Item.Hint, 'mnuRelCRM')                        Or
     SameText(Item.Hint, 'frmRelEstListaAjuste')             Or
     SameText(Item.Hint, 'frmRelFiscMovEstoqContabil')       Or
     SameText(Item.Hint, 'mnuLogsFaturamento')               Or
     SameText(Item.Hint, 'mnuFatConsertoEquipamentos')       Or
     SameText(Item.Hint, 'frmAuditoriasSistema')             Or
     SameText(Item.Hint, 'mnuSpedContribuicoes')             Or
     SameText(Item.Hint, 'mnuSpedFiscal')                    Or
     SameText(Item.Hint, 'mnuGIA')                           Or
     SameText(Item.Hint, 'mnuAuxiliares1')                   Or
     SameText(Item.Hint, 'mnuAnaVertHor1'))                  Then
  Begin
    pInsereOpcaoRelatorio(Item);

    For intContador := 0 To Item.Count - 1 Do
      pInsereOpcaoRelatorioMenus(Item.Items[intContador]);
  End;
End;

procedure TRelatorio.pInsereOpcoesRelatorio(frmPrincipal: TForm; mnuAutcomK: TAdvMainMenu; mnuRelatorio: TarrMenu; blnProgresso: Boolean);
Begin
  Try
    FmnuAutcom    := mnuAutcomk;
    FfrmPrincipal := frmPrincipal;
    FmnuRelatorio := mnuRelatorio;

    If blnProgresso Then
    Begin
      pCriarFormularios(TfrmGravando, FGravando);

      With FGravando Do
      Begin
        lblGravando.Caption := 'Carregando relatórios customizados...';
        fExecutarAcao := fInsereOpcoesRelatorio;
        ShowModal;
      End;

      pFreeAndNil(FGravando);
    End
    Else
      fInsereOpcoesRelatorio(nil);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TRelatorio.pInsereOpcoesRelatorio]');
    End;
  End;
End;

Function TRelatorio.fInsereOpcoesRelatorio(Progress : TcxProgressBar): Boolean;
  Var
    intContador: Integer;
    mnuItem: TMenuItem;
    sltMnuIncluidos : TStringList;
Begin
  sltMnuIncluidos := TStringList.Create;
  sltMnuIncluidos.Sorted := True;
  sltMnuIncluidos.Duplicates := dupIgnore;
  sltMnuIncluidos.BeginUpdate;

  FmnuAutcom.BeginUpdate;
  FOrdena := False;
  Try
    pCarregaRelatoriosMenu(FfrmPrincipal, sltMnuIncluidos);

    If (Not FInicia) Then
    Begin
      For intContador := 0 To sltMnuIncluidos.Count - 1 Do
      Begin
        mnuItem := TMenuItem(FfrmPrincipal.FindComponent(sltMnuIncluidos[intContador]));
        if Assigned(mnuItem) then
          pOrdenaMenu(mnuItem);
      End;
    End;

    for mnuItem in FmnuRelatorio do
    Begin
      // Insere "Criar novo relatório" dentro dos menus listados abaixo
      if SameText(mnuItem.Hint, 'ControlePagtoFuncionarios') then
        pInsereOpcaoRelatorio(mnuItem);

      // Insere "Criar novo relatório" dentro dos submenus
      For intContador := 0 To mnuItem.Count - 1 Do
        pInsereOpcaoRelatorioMenus(mnuItem.Items[intContador]);
    End;
  Finally
    FOrdena := True;
    FmnuAutcom.EndUpdate;
  End;

  Result := True;
End;

Function TRelatorio.fInsereRelMenu(mnuRelatorio: TMenuItem; strCodRel, strNomRel: String): TMenuItem;
  Var
    intContador: Integer;
    mnuInsertRel: TMenuItem;
Begin
  Try
    mnuInsertRel := TMenuItem.Create(mnuRelatorio);
    mnuInsertRel.Caption := strNomRel;
    mnuInsertRel.Hint := 'frm' + strCodRel + 'Rel';
    mnuInsertRel.Name := 'mnu' + strCodRel + 'Rel';

    mnuInsertRel.OnClick := pChamaRelatorio;

    Result := mnuInsertRel;

    mnuRelatorio.Add(mnuInsertRel);

    If FOrdena Then
    Begin
      mnuInsertRel.MenuIndex := mnuRelatorio.Count - 2;

      For intContador := 0 To mnuRelatorio.Count - 2 Do
      Begin
        If AnsiReplaceStr(mnuRelatorio.Items[intContador].Caption, '&', '') >
           AnsiReplaceStr(mnuInsertRel.Caption, '&', '') Then
        Begin
          mnuInsertRel.MenuIndex := intContador;
          Break;
        End;
      End;
    End;
  Except
    Result := Nil; //sometimes ocurr access violation inside the component
  End;
End;

Function TRelatorio.fInsereRelatorioMenu(strCodRel, strNomRel: String): Boolean;
Var
  qryDirAce: TUniQuery;
  strDirAce: string;
Begin
  Try
    If fTemRelatorioMenu(FobjMenu.Name, strCodRel) Then
    Begin
      pMensagemOk('O Relatório já está incluido no menu ' + FobjMenu.Caption + '!');
      Result := False;
      Exit;
    End;

    FmnuAutcom.BeginUpdate;
    Try
      If fInsereRelMenu(FObjMenu, strCodRel, strNomRel) = Nil Then
        Exit(False);

      //  Aqui tem que dar direito de acesso para o usuário que tem acesso á tela de direitos de acesso,
      //    pois quando o usuário insere no menu pelo editor, ele já insere visível, e estando visível, aparece nos direitos de acesso.
      //  Um tratamento para mostrar os direitos de acesso somente para relatórios visíveis foi feito no req 307958,
      //    pois antes apareciam relatórios que estavam invisíveis ao usuário, só pelo fato do menu ter sido criado, mas estar desabilitado (invisível).
      //      (isso ocorre para aqueles relatórios criados no menu, mas que ficam invisíveis por conta de algums CFG, por exemplo, o Vendas por Mark-Up)
      //  Se não criar um direito de acesso para o usuário inseriu o relatório, o mesmo tendo acesso á tela de direitos de acesso,
      //    assim que ele reabrir o autcom, não vai encontrar o direito de acesso e o relatório vai ficar invisível no menu,
      //    não aparecendo também na tela de direitos de acesso.

      strDirAce := '';
      strDirAce := strDirAce + 'REPLACE INTO DIROPE (DIR_NOMFRM, OPE_CODOPE, DIR_ACAOUS) SELECT CONCAT("frm' + strCodRel + 'Rel"), OPE_CODOPE, DIR_ACAOUS FROM DIROPE WHERE DIR_NOMFRM = "frmDirAcesso";';
      strDirAce := strDirAce + 'REPLACE INTO DIRGPO (DIR_NOMFRM, GPO_CODGPO, DIR_ACAOUS) SELECT CONCAT("frm' + strCodRel + 'Rel"), GPO_CODGPO, DIR_ACAOUS FROM DIRGPO WHERE DIR_NOMFRM = "frmDirAcesso";';

      qryDirAce := fCriaQuery;
      qryDirAce.SQL.Clear;
      qryDirAce.SQL.Add(strDirAce);
      qryDirAce.ExecSQL;

    Finally
      FreeAndNil(qryDirAce);
      FmnuAutcom.EndUpdate;
    End;

    pAdicionaRelatorio(FobjMenu.Name, FobjMenu.Caption, strCodRel);

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TRelatorio.fInsereRelatorioMenu');
    End;
  End;
End;

procedure TRelatorio.pInsereListaMenu(Var arrLista: TArrMenu; objNovoItem: TMenuItem);
Begin
  SetLength(arrLista, Succ(Length(arrLista)));
  arrLista[High(arrLista)] := objNovoItem;
End;

procedure TRelatorio.pHabilitaListaMenu(arrLista: TArrMenu; blnVisible: Boolean);
  Var
    intContador: Integer;
Begin
  For intContador := Low(arrLista) To High(arrLista) Do
    If Assigned(arrLista[intContador]) And arrLista[intContador].Visible Then
      arrLista[intContador].Visible := blnVisible;
End;

procedure TRelatorio.pHabilitaMenus;
Var
  lstVrsArquivo, lstVrsProduto: TStringList;
Begin
  lstVrsArquivo := TStringList.Create;
  ExtractStrings(['.'], [], PChar(Trim(TVersaoExecutavel.GetVersaoArquivo)), lstVrsArquivo);
  lstVrsProduto := TStringList.Create;
  ExtractStrings(['.'], [], PChar(Trim(TVersaoExecutavel.GetVersaoProduto)), lstVrsProduto);

  pHabilitaListaMenu(arrNotOrdInd, Not fCfgSis('UTIIND', varBoolean));
  pHabilitaListaMenu(arrOrdInd, fCfgSis('UTIIND', varBoolean));
  pHabilitaListaMenu(arrComEmp, (fCfgSis('METPED', varString) = '1'));
  pHabilitaListaMenu(arrCtaEmp, (fCfgSis('METPED', varString) = '2'));
  pHabilitaListaMenu(arrComGer, (fCfgSis('METPED', varString) = '3'));
  pHabilitaListaMenu(arrCtaGer, (fCfgSis('METPED', varString) = '4'));
  pHabilitaListaMenu(arrCEvEmp72, ((fCfgSis('METPED', varString) = '5') and (StrToInt(lstVrsArquivo[3]) < 74)));
  pHabilitaListaMenu(arrCEvGer72, ((fCfgSis('METPED', varString) = '6') and (StrToInt(lstVrsArquivo[3]) < 74)));
  pHabilitaListaMenu(arrCEvEmp74, ((fCfgSis('METPED', varString) = '5') and (StrToInt(lstVrsArquivo[3]) > 72)));
  pHabilitaListaMenu(arrCEvGer74, ((fCfgSis('METPED', varString) = '6') and (StrToInt(lstVrsArquivo[3]) > 72)));
  pHabilitaListaMenu(arrRefPre, Not(fUsaRotinaGarantiaPelaMatriz));
  pHabilitaListaMenu(arrPecPen, Not(fUsaRotinaGarantiaPelaMatriz));
  pHabilitaListaMenu(arrEncFAn, Not(fUsaRotinaGarantiaPelaMatriz));
  pHabilitaListaMenu(arrEncFSi, Not(fUsaRotinaGarantiaPelaMatriz));
  pHabilitaListaMenu(arrKarTin, fCfgSis('USATMQ', varBoolean));
  pHabilitaListaMenu(arrMkpOp1, (fCfgSis('MODMKP', varString) = '1'));
  pHabilitaListaMenu(arrMkpOp2, (fCfgSis('MODMKP', varString) = '2'));
  pHabilitaListaMenu(arrMkpOp3, (fCfgSis('MODMKP', varString) = '3'));
  pHabilitaListaMenu(arrGerPix, (fCfgSis('USAPIX', varString) = 'S'));
  pHabilitaListaMenu(arrModOp1, (fCfgSis('MODEMI', varString) = '1'));
  pHabilitaListaMenu(arrModOp2, (fCfgSis('MODEMI', varString) = '2'));
  pHabilitaListaMenu(arrModOp3, (fCfgSis('MODEMI', varString) = '3'));
  pHabilitaListaMenu(arrSheWin, SameText(fArqIniTinta(0, 'SHERWIN WHILLIAMS', 'USATIN', ''), 'S'));
  pHabilitaListaMenu(arrVenCcr, (fCfgSis('USACCR', varString) = 'S'));
  pHabilitaListaMenu(arrAnaDes, (fCfgSis('EVEFAT', varString) = 'S'));
  pHabilitaListaMenu(arrLiqVen, (fCfgSis('AUTCEN', varString) = 'S'));
  pHabilitaListaMenu(arrUsaWms, (fUsaRotinaWMS));
  pHabilitaListaMenu(arrUsaTmq, (VS_strUsaTmq = 'S'));
  pHabilitaListaMenu(arrTipEst, (fCfgSis('CTLEST', varString) = '2'));
  pHabilitaListaMenu(arrTabPrf, (fCfgSis('TABPRF', varString) = 'S'));
  pHabilitaListaMenu(arrTabDin, (fCfgSis('TABDIN', varString) = 'S'));
  pHabilitaListaMenu(arrCadLoc, (fCfgSis('CADLOC', varString) = 'S'));
  pHabilitaListaMenu(arrEndScc, (fCfgSis('ENDSSC', varString) = 'S'));
  pHabilitaListaMenu(arrRelPar, (fCadEmp('ESTADO') = 'PR'));
  pHabilitaListaMenu(arrConVis, (fCfgSis('CONVIS', varString) = 'S'));
  pHabilitaListaMenu(arrUraPel, (fCfgSis('URAPEL', varString) = 'S'));
  pHabilitaListaMenu(arrMetGru, (fCfgSis('MTGRMA', varString) = 'L'));
  pHabilitaListaMenu(arrMetMar, (fCfgSis('MTGRMA', varString) = 'M'));
  pHabilitaListaMenu(arrEveCta74,(StrToInt(lstVrsArquivo[3]) < 74 ) );
  pHabilitaListaMenu(arrRefPre, (Not(fUsaRotinaGarantiaPelaMatriz) And (StrToInt(lstVrsArquivo[3]) < 72 )));
  pHabilitaListaMenu(arrPecPen, (Not(fUsaRotinaGarantiaPelaMatriz) And (StrToInt(lstVrsArquivo[3]) < 72 )));
  pHabilitaListaMenu(arrPecCli, (Not(fUsaRotinaGarantiaPelaMatriz) And (StrToInt(lstVrsArquivo[3]) < 72 )));
  pHabilitaListaMenu(arrEncFAn, (Not(fUsaRotinaGarantiaPelaMatriz) And (StrToInt(lstVrsArquivo[3]) < 72 )));
  pHabilitaListaMenu(arrEncFSi, (Not(fUsaRotinaGarantiaPelaMatriz) And (StrToInt(lstVrsArquivo[3]) < 72 )));
  pHabilitaListaMenu(arrGarantia72, (Not(fUsaRotinaGarantiaPelaMatriz) And (StrToInt(lstVrsArquivo[3]) >= 72 )));
  pHabilitaListaMenu(arrApuICMS, (fCfgSis('APUEDT', varString) = 'S'));
  pHabilitaListaMenu(arrMODRCM1, ((fCfgSis('AUTCEN', varString) = 'S') And (fCfgSis('MODRCM', varString) = '1')));
  pHabilitaListaMenu(arrMODRCM2, ((fCfgSis('AUTCEN', varString) = 'S') And (fCfgSis('MODRCM', varString) = '2')));
  pHabilitaListaMenu(arrRFMOD1, (fCfgSis('RFMOD1', varString) = 'S'));
  pHabilitaListaMenu(arrAJUEST, (StrToInt(lstVrsArquivo[3]) < 74 ));
  pHabilitaListaMenu(arrTITPAGCHQ, (StrToInt(lstVrsArquivo[3]) < 74 ));
  pHabilitaListaMenu(arrDEMFLUCAI, (StrToInt(lstVrsArquivo[3]) < 74 ));
  pHabilitaListaMenu(arrPOSCONPAG, (StrToInt(lstVrsArquivo[3]) < 74 ));
  pHabilitaListaMenu(arrTITDELPAG, (StrToInt(lstVrsArquivo[3]) < 74 ));
  pHabilitaListaMenu(arrORDEMSERV, (StrToInt(lstVrsArquivo[3]) < 74 ));
  pHabilitaListaMenu(arrCOMFAT, (fCfgSis('COMEDT', varString) = 'S'));
  pHabilitaListaMenu(arrVPREDT, (fCfgSis('VPREDT', varString) = 'S'));
  pHabilitaListaMenu(arrUSAFLE, (fCfgSis('USAFLE', varString) = 'S'));
  pHabilitaListaMenu(arrEnvReq, (fUsaRequisicaoEnvioMateriais));
  // OCULTO RELATÓRIOS ANTIGOS DA CONTABILIDADE
  pHabilitaListaMenu(arrRelCon, ((StrToInt(lstVrsArquivo[3]) <= 74) And (StrToInt(lstVrsProduto[3]) < 45)));
  pHabilitaListaMenu(arrWhatsapp, (fCfgSis('UTIWPP', varString) = 'S'));
  pHabilitaListaMenu(arrRelEstTer, False);

  FreeAndNil(lstVrsArquivo);
  FreeAndNil(lstVrsProduto);

  End;

Function TRelatorio.fFormataVersao(const ATexto: string): string;
Var
  Regex: TPerlRegEx;
  Partes: TArray<string>;
  I: Integer;
  VersaoFormatada: string;
Begin
  Regex := TPerlRegEx.Create;
  try
    Regex.Subject := ATexto;
    Regex.RegEx := '\d+(?:\.\d+)+';

    if Regex.Match then
    begin
      repeat
        Partes := Regex.MatchedText.Split(['.']);
        VersaoFormatada := '';
        for I := 0 to High(Partes) do
        begin
          if I > 0 then VersaoFormatada := VersaoFormatada + '.';
          VersaoFormatada := VersaoFormatada + Format('%.3d', [StrToIntDef(Partes[I], 0)]);
        end;

        Regex.Replacement := VersaoFormatada;
        Regex.Replace;
      until not Regex.MatchAgain;
    end;

    Result := Regex.Subject;
  finally
    Regex.Free;
  end;
End;

Function TRelatorio.fValidaRelatorioMenu(strExpress: String): Boolean;
{$IFDEF LINUX}
 {$I '..\..\..\bin\svn_rev.inc'}
{$ELSE}
 {$I rev.inc}
{$ENDIF}
var
  qryRev: TUniQuery;
  LUrlSvn: String;
  LVerSvn: TArray<string>;

Begin
  Result := False;

  try
    try
      qryRev := fCriaQuery;
      qryRev.Close;

      strExpress := fFormataVersao(strExpress);
      strExpress := AnsiReplaceStr(strExpress, 'VS_STRCODEMP', ':VS_STRCODEMP');
      strExpress := AnsiReplaceStr(strExpress, 'VS_VERSAO', ':VS_VERSAO');
      strExpress := AnsiReplaceStr(strExpress, 'VS_RELEASE_COMPLETA', ':VS_RELEASE_COMPLETA');
      strExpress := AnsiReplaceStr(strExpress, 'VS_RELEASE_RESUMIDA', ':VS_RELEASE_RESUMIDA');

      qryRev.SQL.Text := strExpress;

      If Assigned(qryRev.Params.FindParam('VS_STRCODEMP')) Then
        qryRev.ParamByName('VS_STRCODEMP').AsString := VS_strCodEmp;

      If Assigned(qryRev.Params.FindParam('VS_VERSAO')) Then
        qryRev.ParamByName('VS_VERSAO').AsString := fFormataVersao(TVersaoExecutavel.GetVersaoArquivo);

      If Assigned(qryRev.Params.FindParam('VS_RELEASE_RESUMIDA')) Then
        qryRev.ParamByName('VS_RELEASE_RESUMIDA').AsString := fFormataVersao(TVersaoExecutavel.GetVersaoProduto);

      If Assigned(qryRev.Params.FindParam('VS_RELEASE_COMPLETA')) Then
      Begin
        LUrlSvn := SVN_URL;
        LUrlSvn := LUrlSvn.Replace('/padra_atualizado', '');
        LVerSvn := LUrlSvn.Split(['/']);
        qryRev.ParamByName('VS_RELEASE_COMPLETA').AsString := fFormataVersao(LVerSvn[High(LVerSvn)]);
      End;

      qryRev.Open;

      qryRev.First;

      while not qryRev.Eof do
      Begin
        If (qryRev.FieldByName('RESULTADO').AsString = 'S') then
          Result := True;

        qryRev.Next;
      End;

    Except
      On E: Exception Do
        pGravarErro(True, 'ERRO RELATORIO MENU: ' + E.Message, E.StackTrace);
    end;

  finally
    FreeAndNil(qryRev);
  end;

End;

procedure TRelatorio.pCarregaRelatoriosMenu(frmPrincipal: TForm; sltMnuIncluidos: TStringList);
  Var
    qryRelMen: TUniQuery;
    objItem: TComponent;
    objNovoItem: TMenuItem;
    lstVrsArquivo: TStringList;
    lstVrsProduto: TStringList;
Begin
  Try

    qryRelMen := fCriaQuery;
    lstVrsArquivo := TStringList.Create;
    lstVrsProduto := TStringList.Create;

    With qryRelMen, SQL Do
    Begin
      Add('SELECT');

      Add('  MEN_NOMME2,');
      Add('  MEN_CODREL,');
      Add('  REL_CHAVE_,');
      Add('  REL_DESCRI,');
      Add('  REV_EXPRES ');
      Add(' FROM RELMEN ');
      Add('   INNER JOIN CADREL ON REL_CODREL = MEN_CODREL ');
      Add('   LEFT JOIN  RELVIS ON REV_CODREL = REL_CODREL ');
      Add(' WHERE TRUE ');
      Add('   AND (IF(IFNULL(CAST(SUBSTRING_INDEX(TRIM(REL_VERREL), ".", - 1) AS SIGNED), 0) < :VERREL, TRUE, FALSE) OR ');
      Add('        IF(IFNULL(CAST(SUBSTRING_INDEX(TRIM(REL_VERREL), ".", - 1) AS SIGNED), 0) = :VERREL ');
      Add('            AND IFNULL(CAST(SUBSTRING_INDEX(TRIM(REL_RELREL), ".", - 1) AS SIGNED), 0) <= :RELREL, TRUE, FALSE)) ');

      Add('ORDER BY MEN_NOMME2, REL_DESCRI');

      ExtractStrings(['.'], [], PChar(Trim(TVersaoExecutavel.GetVersaoArquivo)), lstVrsArquivo);
      ExtractStrings(['.'], [], PChar(Trim(TVersaoExecutavel.GetVersaoProduto)), lstVrsProduto);

      qryRelMen.ParamByName('VERREL').AsInteger := StrToInt(lstVrsArquivo[3]);
      qryRelMen.ParamByName('RELREL').AsInteger := StrToInt(lstVrsProduto[3]);

      FreeAndNil(lstVrsArquivo);
      FreeAndNil(lstVrsProduto);

      Open;

      If Assigned(FGravando) Then
        FGravando.pgbStatus.Properties.Max := RecordCount;

      While Not Eof Do
      Begin
        If FieldByName('REV_EXPRES').AsString <> '' then
        Begin
          If not fValidaRelatorioMenu(FieldByName('REV_EXPRES').AsString) then
          Begin
              Next;
              Continue;
          End;
        End;

        objItem := frmPrincipal.FindComponent(FieldByName('MEN_NOMME2').AsString);

        If Assigned(objItem) And (objItem Is TMenuItem) Then
        Begin
          objNovoItem := fInsereRelMenu((objItem As TMenuItem),
                           FieldByName('MEN_CODREL').AsString,
                           FieldByName('REL_DESCRI').AsString);

          If Not Assigned(objNovoItem) Then
          Begin
            Next;
            Continue;
          End;

          sltMnuIncluidos.Add(objItem.Name);

          Case FieldByName('REL_CHAVE_').AsInteger Of
            {RELATÓRIO DE FORMULAS/ESTRUTURAS}
            022, 023: pInsereListaMenu(arrNotOrdInd, objNovoItem);
            130, 131, 2285, 2287: pInsereListaMenu(arrOrdInd, objNovoItem);
            {RELATÓRIOS DE METAS DE PEDIDO DE COMPRA}
            354, 355: pInsereListaMenu(arrComEmp, objNovoItem);
            350, 351: pInsereListaMenu(arrCtaEmp, objNovoItem);
            356, 357: pInsereListaMenu(arrComGer, objNovoItem);
            352, 353: pInsereListaMenu(arrCtaGer, objNovoItem);
            14135, 14136: pInsereListaMenu(arrCEvEmp72, objNovoItem);
            14137, 14138: pInsereListaMenu(arrCEvGer72, objNovoItem);
            14242, 14243: pInsereListaMenu(arrCEvEmp74, objNovoItem);
            14244, 14245: pInsereListaMenu(arrCEvGer74, objNovoItem);
            {RELATÓRIOS DE GARANTIA}
            695, 696: pInsereListaMenu(arrRefPre, objNovoItem);
            699, 700: pInsereListaMenu(arrPecPen, objNovoItem);
            701, 702: pInsereListaMenu(arrPecCli, objNovoItem);
            703, 704: pInsereListaMenu(arrEncFAn, objNovoItem);
            705, 706: pInsereListaMenu(arrEncFSi, objNovoItem);
            {RELATÓRIO DE FICHA KARDEX SINTÉTICA}
            75,76,77,78: pInsereListaMenu(arrKarTin, objNovoItem);
            {RELATÓRIOS DE MARKUP}
            1079,1085: pInsereListaMenu(arrMkpOp1, objNovoItem);
            1082,1084,1088,1090: pInsereListaMenu(arrMkpOp2, objNovoItem);
            1142,1144,1145,1147: pInsereListaMenu(arrMkpOp3, objNovoItem);
            {RELATÓRIOS DE PIX }
            15380,15381: pInsereListaMenu(arrGerPix, objNovoItem);
            {RELATÓRIOS DE EMISSAO DE CAIXA}
            1846,1865: pInsereListaMenu(arrModOp1, objNovoItem);
            1914,1919: pInsereListaMenu(arrModOp2, objNovoItem);
            1884,1899: pInsereListaMenu(arrModOp3, objNovoItem);
            1319,1321: pInsereListaMenu(arrSheWin,objNovoItem);
            {RELATÓRIO DE CONCRETO}
            1751,1752: pInsereListaMenu(arrVenCcr, objNovoItem);
            {RELATÓRIO DE ANALISE DE DESEMPENHO (EVENTOS)}
            1973,1974: pInsereListaMenu(arrAnaDes, objNovoItem);
            {RELATÓRIO DE LIQUIDEZ DE VENDAS}
            2007,2008,2009,2010: pInsereListaMenu(arrLiqVen, objNovoItem);
            {RELATÓRIOS DE WMS}
            2235,2236: pInsereListaMenu(arrUsaWms, objNovoItem);
            {RELATÓRIOS DE TMQ}
            2249,2250,6374,6375,6376,6377,6378,6379,6380,6381: pInsereListaMenu(arrUsaTmq, objNovoItem);
            {RELATÓRIOS DE ESTOQUE CFG_CTLEST=2}
            2269,2270,2367,2368: pInsereListaMenu(arrTipEst, objNovoItem);
            {RELATÓRIOS DE ESTOQUE CFG_TABPRF=S}
            2273,2274: pInsereListaMenu(arrTabPrf, objNovoItem);
            {RELATRÓRIO DE ESTOQUE CFG_TABDIN=S}
            2278,2279,2280,2281: pInsereListaMenu(arrTabDin, objNovoItem);
            {RELATRÓRIO DE ESTOQUE CFG_CADLOC=S}
            2298,2299: pInsereListaMenu(arrCadLoc, objNovoItem);
            {RELATÓRIO DE ESTOQUE CFG_ENDSSC=S}
            2347,2349: pInsereListaMenu(arrEndScc, objNovoItem);
            {RELATÓRIO EMPRESA DO PARANA }
            2410,2411: pInsereListaMenu(arrRelPar, objNovoItem);
            {RELATÓRIO VISITAS DE CLIENTE TABLET }
            2461,2463: pInsereListaMenu(arrConVis, objNovoItem);
            {RELATÓRIO METAS DE COMPRA PARA RAPEL }
            3581,3582: pInsereListaMenu(arrUraPel, objNovoItem);
            {RELATÓRIO DE GIRO DE ESTOQUE VENDAS}
            3685,3686,3687,3688: pInsereListaMenu(arrGirEst, objNovoItem);
            {RELATÓRIO METAS POR VENDEDOR E GRUPO ou MARCA - FATURAMENTO}
            4349,4355: pInsereListaMenu(arrMetGru, objNovoItem);
            4361,4366: pInsereListaMenu(arrMetMar, objNovoItem);
            {RELATÓRIO COM CENTROS DE CUSTOS NO LUGAR DE EVENTOS-- SOMENTE VERSÃO >= QUE 48.2.30.74}
            79,80,393,395,397,399,401,403,405,407,394,396,398,400,402,404,
            406,408,409,410,417,419,421,418,420,422,460,461,462,463,464,465,
            466,467,468,469,470,471,472,473,474,479,480,483,484,493,494,495,
            497,496,498,499,500,501,502,503,505,507,509,511,504,506,508,510,
            512,513,515,514,516,518,520,519,521,522,524,526,523,525,527,589,
            590,926,928,927,929,572,574,576,573,575,577: pInsereListaMenu(arrEveCta74, objNovoItem);
            {RELATÓRIO DE GARANTIAS -- SOMENTE VERSÃO >= QUE 48.2.30.72}
            5254,5255,5256,5257,5258,5259,5319,5320,5321,5322,5323,5324,5325,5326,5327,5328: pInsereListaMenu(arrGarantia72, objNovoItem);
            {RELATÓRIO DE RESUMO DE APURAÇÃO DE ICMS}
            5560,5561,5562,5563,5564,5565,5566,
            5567,5568,5569,5570,5571,5572,5573: pInsereListaMenu(arrApuICMS, objNovoItem);
            5699,5700,5701,5702,5703,5704: pInsereListaMenu(arrMODRCM1, objNovoItem);
            5705,5706,5707,5708: pInsereListaMenu(arrMODRCM2, objNovoItem);
            6067,6068: pInsereListaMenu(arrRFMOD1, objNovoItem);
            {RELATÓRIO DE AJUSTE DE ESTOQUE}
            2265,2266: pInsereListaMenu(arrAJUEST, objNovoItem);
            {RELATÓRIO DE TÍTULOS PAGOS COM CHEQUE}
            487,488: pInsereListaMenu(arrTITPAGCHQ, objNovoItem);
            {RELATÓRIO DE DEMONSTRATIVO DE FLUXO DE CAIXA REALIZADO}
            31008,31009,31010,31011: pInsereListaMenu(arrDEMFLUCAI, objNovoItem);
            {RELATÓRIO DE POSIÇÃO CONTÁBIL DE CONTAS À PAGAR}
            489,490,491,492: pInsereListaMenu(arrPOSCONPAG, objNovoItem);
            {RELATÓRIO DE TÍTULOS DELETADOS (CONTAS À PAGAR)}
            477,478: pInsereListaMenu(arrTITDELPAG, objNovoItem);
            {RELATÓRIO DE ORDEM DE SERVIÇO}
            962,963: pInsereListaMenu(arrORDEMSERV, objNovoItem);
            {RELATÓRIO DE COMISSAO POR VENDEDOR FATURAMENTO}
            6207,6208,6209,6210,6211,6212: pInsereListaMenu(arrCOMFAT, objNovoItem);
            {RELATÓRIO DE VENDA PARA REPOSIÇÃO}
            6472,6473,6474,6475: pInsereListaMenu(arrVPREDT, objNovoItem);
            6778,6779,7617,7618,7619,7620: pInsereListaMenu(arrUSAFLE, objNovoItem);
            7830,7833: pInsereListaMenu(arrEnvReq, objNovoItem);
            2467,2469,3553: pInsereListaMenu(arrRelCon, objNovoItem);
            17717: pInsereListaMenu(arrWhatsapp, objNovoItem);
            28487,28488,28489,28490,28620,28621,28622,28623: pInsereListaMenu(arrRelEstTer, objNovoItem)

          End;

        End;

        Next;

        If Assigned(FGravando) Then
          FGravando.pgbStatus.Position := FGravando.pgbStatus.Position + 1;

        If Not FOrdena then
         Application.ProcessMessages;
      End;

    End;

    FreeAndNil(qryRelMen);

    TInterfaceRelatorio.pCarregaDireitosMenu(FGravando, FOrdena);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'TRelatorio.pCarregaRelatoriosMenu');
    End;
  End;

End;

procedure TRelatorio.pChamaRelatorio(Sender: TObject);
  Var
    strCodRel: String;
Begin
  strCodRel := Copy((Sender As TComponent).Name, 4, 6);

  pExecutaRelatorio(strCodRel);
End;

Procedure TRelatorio.pAdicionaRelatorio(strMenu, strCaption, strCodRel: String);
  Var
    qryRelMen: TUniQuery;
Begin
  qryRelMen := fCriaQuery;

  With qryRelMen, SQL Do
  Begin
    Add('REPLACE INTO RELMEN');
    Add('(AUTOINCREM, MEN_NOMMEN, MEN_NOMME2, MEN_CODREL, MEN_CAPMEN) VALUES');
    Add('(:AUTINC, :NOMMEN, :NOMME2, :CODREL, :CAPMEN)');

    ParamByName('AUTINC').AsString := fRetAutoIncrem('RELMEN', VS_strCodEmp);
    ParamByName('NOMMEN').AsString := strMenu;
    ParamByName('NOMME2').AsString := strMenu;
    ParamByName('CODREL').AsString := strCodRel;
    ParamByName('CAPMEN').AsString := AnsiReplaceStr(strCaption, '&', '');

    ExecSQL;
  End;

  FreeAndNil(qryRelMen);
End;

Class function TRelatorio.fRetornaCodigoRelatorioAtarel(strAtarel: String): String;
  Var
    qryAtaRel: TUniQuery;
Begin
  Result := '';

  qryAtaRel := fCriaQuery;
  With qryAtaRel, SQL Do
  Begin
    Clear;
    Add('SELECT REL_CODREL AS CODREL, C.AUTOINCREM FROM ATAREL');
    Add('INNER JOIN CADREL C ON REL_CHAVE_ = ATA_CHAVE_');
    Add('WHERE ATA_CODATA = :CODATA');
    ParamByName('CODATA').AsString := strAtarel;
    Open;

    If IsEmpty Then
    Begin
      Close;
      Clear;
      Add('SELECT ATA_CODREL AS CODREL, C.AUTOINCREM FROM ATAREL');
      Add('INNER JOIN CADREL C ON REL_CODREL = ATA_CODREL');
      Add('WHERE ATA_CODATA = :CODATA');
      ParamByName('CODATA').AsString := strAtarel;
      Open;
    End
    Else
      Result := FieldByName('CODREL').AsString;

  end;

end;

class procedure TRelatorio.pAtualizarParametrosRelatorio(strCodRel, strCodOpe: String;
  arrParametros, arrValores, arrMultiSelecao: array of String; ATabelaFiltrosValores: string = 'CADVAL');
Var
  LCadVal: TUniQuery;
  LIncrem: String;
  LIndex: Integer;
begin
  LCadVal := fCriaQuery;
  Try
    LIncrem := fCampoTabela('AUTOINCREM', 'CADREL', ['REL_CODREL'], [strCodRel]);

    If fEmptyStr(LIncrem) Then
      Exit;

    For LIndex := Low(arrParametros) To High(arrParametros) Do
    Begin
      LCadVal.Close;
      LCadVal.SQL.Text := 'SELECT * FROM ' + ATabelaFiltrosValores + ' WHERE VAL_CODOPE = :CODOPE AND VAL_NOMPAR = :NOMPAR AND VAL_SEQGER = :SEQGER';
      LCadVal.ParamByName('CODOPE').AsString := strCodOpe;
      LCadVal.ParamByName('NOMPAR').AsString := arrParametros[LIndex];
      LCadVal.ParamByName('SEQGER').AsString := LIncrem;
      LCadVal.Open;

      If Not LCadVal.IsEmpty Then
      Begin
        LCadVal.Edit;
        LCadVal.FieldByName('VAL_ULTVAL').AsString := arrValores[LIndex];
        LCadVal.FieldByName('VAL_MULSEL').AsString := arrMultiSelecao[LIndex];
        LCadVal.Post;
      End
      Else
      Begin
        LCadVal.Append;
        LCadVal.FieldByName('VAL_CODOPE').AsString := strCodOpe;
        LCadVal.FieldByName('VAL_MULSEL').AsString := arrMultiSelecao[LIndex];
        LCadVal.FieldByName('VAL_NOMPAR').AsString := arrParametros[LIndex];
        LCadVal.FieldByName('VAL_SEQGER').AsString := LIncrem;
        LCadVal.FieldByName('VAL_ULTVAL').AsString := arrValores[LIndex];
        LCadVal.Post;
      End;
    End;
  Finally
    FreeAndNil(LCadVal);
  End;
end;

procedure TRelatorio.pGravaRelVrs(strCodRel, strVerRel: String);
Var
  qryVerRel: TUniQuery;
Begin
  qryVerRel := fCriaQuery;

  With qryVerRel, SQL Do
  Begin
    Add('REPLACE INTO RELVRS');
    Add('(RVS_CODREL, RVS_VERREL) VALUES');
    Add('(:CODREL, :VERREL)');

    ParamByName('CODREL').AsString := IfThen(strCodRel <> '', strCodRel, '48.2.30.00');
    ParamByName('VERREL').AsString := strVerRel;

    ExecSQL;
  End;
End;

procedure TRelatorio.pGravaMD5Comp(strAutInc: String);
Var
  qryUpdRel: TUniQuery;
Begin
  qryUpdRel := fCriaQuery;

  With qryUpdRel, SQL Do
  Begin
    Add('UPDATE CADREL SET                                                              ');
    Add('  REL_MD5NEW = UPPER(MD5(CONCAT(IFNULL(REL_RELFR3, ""),                        ');
    Add('                                IFNULL(REL_ALTTEL, ""),                        ');
    Add('                                IFNULL(REL_CODMOD, ""),                        ');
    Add('                                IFNULL(REL_DEFSQL, ""),                        ');
    Add('                                IFNULL(REL_DESCRI, ""),                        ');
    Add('                                IFNULL(REL_HEAWID, ""),                        ');
    Add('                                IFNULL(REL_LARTEL, ""),                        ');
    Add('                                IFNULL(REL_QTDCOL, ""),                        ');
    Add('                                IFNULL(REL_VALWID, ""),                        ');
    Add('                                IFNULL(REL_DTAALT, ""),                        ');
    Add('                                IFNULL(REL_HORALT, ""))))                      ');
    Add('WHERE AUTOINCREM IN (SELECT REL_COMPLE FROM SUBREL WHERE REL_MASTER = :AUTINC) ');
    ParamByName('AUTINC').AsString := strAutInc;

    ExecSQL;
  End;
End;

Function TRelatorio.fLimpaFiltrosNaoUtilizados(strCodRel: String): Boolean;
var
  qryLimpaFiltros: TUniQuery;
begin

  Result := False;

  qryLimpaFiltros := fCriaQuery;
  try
    with qryLimpaFiltros, qryLimpaFiltros.SQL do
    begin
      Close;
      Clear;
      Append(' SELECT * FROM GRUPAR WHERE GRU_SEQGER = (SELECT AUTOINCREM FROM CADREL WHERE REL_CODREL = :CODREL) AND GRU_TIPGRU = 0 AND GRU_CODGRU NOT IN ');
      Append('   (SELECT DISTINCT IFNULL(PAR_CODGRU, "") FROM CADPRR WHERE PAR_SEQGER = (SELECT AUTOINCREM FROM CADREL WHERE REL_CODREL = :CODREL)) ');
      ParamByName('CODREL').AsString := strCodRel;
      Open;
      if not IsEmpty then
      begin
        Close;
        Clear;
        Append(' DELETE FROM GRUPAR WHERE GRU_SEQGER = (SELECT AUTOINCREM FROM CADREL WHERE REL_CODREL = :CODREL) AND GRU_TIPGRU = 0 AND GRU_CODGRU NOT IN ');
        Append('   (SELECT DISTINCT IFNULL(PAR_CODGRU, "") FROM CADPRR WHERE PAR_SEQGER = (SELECT AUTOINCREM FROM CADREL WHERE REL_CODREL = :CODREL)) ');
        ParamByName('CODREL').AsString := strCodRel;
        ExecSQL;
        Result := True;
      end;
    end;
  finally
    FreeAndNil(qryLimpaFiltros);
  end;

end;

Function TRelatorio.fTemRelatorioMenu(strMenu, strCodRel: String): Boolean;
  Var
    qryRelMen: TUniQuery;
Begin
  qryRelMen := fCriaQuery;

  With qryRelMen, SQL Do
  Begin
    Add('SELECT * FROM RELMEN WHERE ');
    Add('(MEN_NOMME2 = :NOMME2 OR MEN_NOMMEN = :NOMMEN) AND MEN_CODREL = :CODREL');

    ParamByName('NOMME2').AsString := strMenu;
    ParamByName('NOMMEN').AsString := strMenu;
    ParamByName('CODREL').AsString := strCodRel;

    Open;

    Result := Not IsEmpty;
  End;

  FreeAndNil(qryRelMen);
End;

Function TRelatorio.fSQLRelatorios: String;
  Var
    strSQL: String;
Begin
  strSQL := '';

  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   R.AUTOINCREM AS AUTINC,  ';

  strSQL := strSQL + '   MEN_NOMME2 AS NOMME2,  ';
  strSQL := strSQL + '   MEN_CAPMEN AS CAPMEN,  ';
  strSQL := strSQL + '   MEN_CODREL AS CODREL,  ';
  strSQL := strSQL + '   REL_DESCRI AS NOMREL,  ';
  strSQL := strSQL + '   "N"        AS RETIRA   ';

  strSQL := strSQL + ' FROM RELMEN R  ';
  strSQL := strSQL + ' INNER JOIN CADREL ON REL_CODREL = MEN_CODREL  ';

  strSQL := strSQL + ' WHERE TRUE ';

  If Not fEmptyStr(FCodRel) Then
    strSQL := strSQL + ' AND MEN_CODREL = :CODREL ';

  If fCfgSis('UTIIND', varBoolean) Then
    strSQL := strSQL + ' AND IFNULL(REL_CHAVE_, 0) NOT IN (22, 23) '
  Else
    strSQL := strSQL + ' AND IFNULL(REL_CHAVE_, 0) NOT IN (130, 131) ';

  If (fCfgSis('METPED', varString) = '1') Then
    strSQL := strSQL + ' AND IFNULL(REL_CHAVE_, 0) NOT IN (350,351,352,353,356,357,14135,14136,14137,14138,14242,14243,14244,14245)';

  If (fCfgSis('METPED', varString) = '2') Then
    strSQL := strSQL + ' AND IFNULL(REL_CHAVE_, 0) NOT IN (352,353,354,355,356,357,14135,14136,14137,14138,14242,14243,14244,14245)';

  If (fCfgSis('METPED', varString) = '3') Then
    strSQL := strSQL + ' AND IFNULL(REL_CHAVE_, 0) NOT IN (350,351,352,353,354,355,14135,14136,14137,14138,14242,14243,14244,14245)';

  If (fCfgSis('METPED', varString) = '4') Then
    strSQL := strSQL + ' AND IFNULL(REL_CHAVE_, 0) NOT IN (350,351,354,355,356,357,14135,14136,14137,14138,14242,14243,14244,14245)';

  If (fCfgSis('METPED', varString) = '5') Then
    strSQL := strSQL + ' AND IFNULL(REL_CHAVE_, 0) NOT IN (350,351,352,353,354,355,356,357,14135,14136,14137,14138,14244,14245)';

  If (fCfgSis('METPED', varString) = '6') Then
    strSQL := strSQL + ' AND IFNULL(REL_CHAVE_, 0) NOT IN (350,351,352,353,354,355,356,357,14135,14136,14137,14138,14242,14243)';

  If (fUsaRotinaGarantiaPelaMatriz) Then
    strSQL := strSQL + ' AND IFNULL(REL_CHAVE_, 0) NOT IN (695,696,699,700,703,704,705,706)';

  If fCfgSis('USATMQ', varBoolean) Then
    strSQL := strSQL + ' AND IFNULL(REL_CHAVE_, 0) NOT IN (71,72,73,74)'
  Else
    strSQL := strSQL + ' AND IFNULL(REL_CHAVE_, 0) NOT IN (75,76,77,78)';

  If (fCfgSis('MODMKP', varString) = '1') Then
    strSQL := strSQL + 'AND IFNULL(REL_CHAVE_, 0) NOT IN(1082,1084,1088,1090,1142,1144,1145,1147)';

  If (fCfgSis('MODMKP', varString) = '2') Then
    strSQL := strSQL + 'AND IFNULL(REL_CHAVE_, 0) NOT IN(1079,1085,1142,1144,1145,1147)';

  If (fCfgSis('MODMKP', varString) = '3') Then
    strSQL := strSQL + 'AND IFNULL(REL_CHAVE_, 0) NOT IN(1079,1085,1082,1084,1088,1090)';

  If fCfgSis('APUEDT') = 'N' Then
    strSQL := strSQL + 'AND IFNULL(REL_CHAVE_, 0) NOT IN(5560,5561,5562,5563,5564,5565,5566,5567,5568,5569,5570,5571,5572,5573)';

  strSQL := strSQL + ' ORDER BY NOMME2, NOMREL  ';

  Result := strSQL;
End;

Procedure TRelatorio.pMostraRelatoriosMenu(frmPrincipal: TForm);
  Var
    frmConsultaRelatMenu : TfrmConsultaRelatMenu;
Begin
  FfrmPrincipal := frmPrincipal;

  cdsRelatorios := TZClient.Create(Self, fSQLRelatorios);

  If cdsRelatorios.fAbreClient(True) Then
  Begin
    cdsRelatorios.pAlinhaCampoCentro('CODREL');

    pCriarFormularios(TfrmConsultaRelatMenu, frmConsultaRelatMenu);

    frmConsultaRelatMenu.cxvItens.DataController.DataSource := cdsRelatorios.dtsSource;
    frmConsultaRelatMenu.objRelatorio := Self;

    frmConsultaRelatMenu.ShowModal;

    pFreeAndNil(frmConsultaRelatMenu);
  End;
End;

procedure TRelatorio.pOrdenaMenu(const mnuMenu: TMenuItem);

  procedure pOrdenarItens;
    var
      index: Integer;
      item: TMenuItem;
      stlOrdem: TStringList;
  begin
    stlOrdem := TStringList.Create;
    stlOrdem.BeginUpdate;
    try
      for item in mnuMenu do
      begin
        stlOrdem.AddObject(AnsiReplaceStr(item.Caption, '&', ''), item);
        if item.Count > 0 then
          pOrdenaMenu(item);
      end;

      stlOrdem.CaseSensitive := True;
      stlOrdem.Sort;

      for index := stlOrdem.Count -1 Downto 0 do
      begin
        item := TMenuItem(stlOrdem.Objects[index]);
        if (item.MenuIndex <> index) then
          item.MenuIndex := index;
      end;
    finally
      stlOrdem.EndUpdate;
      stlOrdem.Free;
    end;
  end;

begin
  pOrdenarItens;
end;

Function TRelatorio.fExcluiRelatoriosMenuProg(Progress : TcxProgressBar): Boolean;
  Var
    qryRelMen: TUniQuery;
    objItem: TComponent;
    mnuItem,
    mnuPai: TMenuItem;
    intContador: Integer;
Begin
  If Not Assigned(FfrmPrincipal) Then
  Begin
    Result := True;
    Exit;
  End;

  With cdsRelatorios Do
  Begin
    DisableControls;
    qryRelMen := Nil;

    If FExcluirDaTabelaMenu Then
    Begin
      qryRelMen := fCriaQuery;
      qryRelMen.SQL.Text := 'DELETE FROM RELMEN WHERE AUTOINCREM = :AUTINC';

      Filter   := 'RETIRA =  ' + QuotedStr('S');
      Filtered := True;
    End;

    First;

    If Assigned(Progress) Then
    Begin
      Progress.Properties.Max := RecordCount;
      Application.ProcessMessages;
    End;

    While Not Eof Do
    Begin
      objItem := FfrmPrincipal.FindComponent(FieldByName('NOMME2').AsString);

      If Assigned(objItem) And (objItem Is TMenuItem) Then
      Begin
        mnuPai := (objItem As TMenuItem);

        For intContador := 0 To mnuPai.Count - 1 Do
          If SameText(mnuPai.Items[intContador].Name, 'mnu' + FieldByName('CODREL').AsString + 'Rel') Then
          Begin

            If FExcluirDaTabelaMenu Then
            Begin
              qryRelMen.Close;
              qryRelMen.ParamByName('AUTINC').AsString := FieldByName('AUTINC').AsString;
              qryRelMen.ExecSQL;
            End;

            mnuItem := mnuPai.Items[intContador];
            mnuPai.Delete(intContador);

            FreeAndNil(mnuItem);

            Break;
          End;
      End;

      Next;

      If Assigned(Progress) Then
      Begin
        Progress.Position := Progress.Position + 1;
        Application.ProcessMessages;
      End;
    End;

    Filtered := False;

    EnableControls;

    If Assigned(qryRelMen) Then
      FreeAndNil(qryRelMen);

    Result := True;
  End;
End;

Function TRelatorio.fRealocaMenu(strCodRel: String; frmPrincipal: TForm; mnuAutcomK: TAdvMainMenu): Boolean;
  Var
    objItem: TComponent;
Begin
  Try
    Result := True;

    If Not Assigned(mnuAutcomK) Then
      Exit;

    FExcluirDaTabelaMenu := False;
    FCodRel := strCodRel;
    FfrmPrincipal := frmPrincipal;
    FmnuAutcom    := mnuAutcomk;

    cdsRelatorios := TZClient.Create(Self, fSQLRelatorios);
    cdsRelatorios.qryQuery.ParamByName('CODREL').AsString := strCodRel;

    With cdsRelatorios Do
    If fAbreClient(True) And (Not IsEmpty) Then
    Begin
      FmnuAutcom.BeginUpdate;

      If fExcluiRelatoriosMenuProg(Nil) Then
      Begin
        First;

        While Not Eof Do
        Begin
          objItem := frmPrincipal.FindComponent(FieldByName('NOMME2').AsString);

          If Assigned(objItem) And (objItem Is TMenuItem) Then
          Begin
            fInsereRelMenu((objItem As TMenuItem),
                           FieldByName('CODREL').AsString,
                           FieldByName('NOMREL').AsString);
          End;

          Next;
        End;
      End;

      FmnuAutcom.EndUpdate;

    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TRelatorio.fRealocaMenu');
    End;
  End;
End;

Function TRelatorio.fExcluiRelatoriosMenu: Boolean;
Begin
  Try
    FExcluirDaTabelaMenu := True;

    pCriarFormularios(TfrmGravando, frmGravando);

    frmGravando.lblGravando.Caption := 'Removendo relatórios...';
    frmGravando.fExecutarAcao := fExcluiRelatoriosMenuProg;
    frmGravando.ShowModal;

    Result := frmGravando.blnConfirma;

    If Result Then
    Begin
      cdsRelatorios.fAbreClient(True);
      cdsRelatorios.pAlinhaCampoCentro('CODREL');
    End;

    pFreeAndNil(frmGravando);
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TRelatorio.pExcluiRelatoriosMenu');
    End;
  End;

End;

Function TRelatorio.fSalvaBackup(strCodRel: String): Boolean;
  Var
    frmGravando: TfrmGravando;
Begin
  Try
    FCodRel := strCodRel;

    Result := TfrmGravando.fExecuta(fSalvaBackupProg, frmGravando, 'Duplicando relatório, aguarde...', False);

    If Result Then
      pMensagemOk('Código do novo relatório criado: ' + FNovRel);

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TRelatorio.fSalvaBackup]');
    End;
  End;

End;

Function TRelatorio.fGetCodigoRelatorio: String;
Begin
  Result := fProximoCodigo('CADREL', 'REL_CODREL');
End;

Function TRelatorio.fGetAutoincrem(strNomTab: String): String;
Begin
  Result := fRetAutoIncrem(strNomTab, VS_strCodEmp);
End;

Function TRelatorio.fSalvaBackupProg(Progress: TcxProgressBar): Boolean;
  Var
    strScript: String;
    qryExcecuta: TUniQuery;
    objConverte: TConvert;
Begin
  Try
    Result := False;

    objConverte := TConvert.Create(Nil, frmModulo.GetCurrentConnection);
    objConverte.strCodRelExterno    := objConverte.fGetCodChilds(objConverte.fGetListaRelatorio(FCodRel));
    objConverte.fGetCodigoRelatorio := fGetCodigoRelatorio;
    objConverte.fGetAutoIncrem      := fGetAutoIncrem;

    strScript := objConverte.fGeraScriptCopiaRelatorio(FCodRel, FNovRel);

    If strScript.IsEmpty Then
      Exit;

    fStartTransaction;
    qryExcecuta := objConverte.fCriaQuery;
    qryExcecuta.SQL.Text := strScript;
    qryExcecuta.Execute;
    fCommit;

    FreeAndNil(qryExcecuta);
    FreeAndNil(objConverte);

    Result := True;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      Result := False;
      pMensagensErro(E.Message, '[TRelatorio.fSalvaBackup]');
    End;
  End;
End;

Function TRelatorio.fTemChaveRelatotio(intChave: Integer): Boolean;
Begin
  Result := fCampoTabela('REL_CHAVE_', 'CADREL', ['REL_CHAVE_'], [intChave]) = intChave;
End;

Class Procedure TRelatorio.pSalvaParametros(strAutRel: String;
                                            arrParametros: Array Of String;
                                            arrValores: Array Of String);
  Var
    qryCadVal: TUniQuery;
    intContador: Integer;
Begin
  qryCadVal := fCriaQuery;

  For intContador := Low(arrParametros) To High(arrParametros) Do
  Begin
    If TInterfaceRelatorio.fExisteCadVal(strAutRel,
                                         arrParametros[intContador],
                                         strLoginUsuarioLogado,
                                         'CADVAL') Then
      qryCadVal.SQL.Text := TInterfaceRelatorio.fSQLUpdateCadVal(1, 'CADVAL')
    Else
      qryCadVal.SQL.Text := TInterfaceRelatorio.fSQLInsertCadVal(1, 'CADVAL');

    qryCadVal.Close;
    qryCadVal.ParamByName('MULSEL1').AsString := 'N';
    qryCadVal.ParamByName('SEQGER1').AsString := strAutRel;
    qryCadVal.ParamByName('CODOPE1').AsString := strLoginUsuarioLogado;
    qryCadVal.ParamByName('NOMPAR1').AsString := arrParametros[intContador];

    If POS('(IN)', arrValores[intContador]) > 0 Then
    Begin
      qryCadVal.ParamByName('ULTVAL1').AsString := AnsiReplaceStr(arrValores[intContador], '(IN)', '');
      qryCadVal.ParamByName('MULSEL1').AsString := 'S';
    End

    Else
      qryCadVal.ParamByName('ULTVAL1').AsString := arrValores[intContador];

    qryCadVal.ExEcSQL;
  End;

  FreeAndNil(qryCadVal);
End;

Class Function TRelatorio.fVerificaSeRelatorioExiste(intCodigoAtalho,
                                                     intChaveDefault: integer): Boolean;
Var
  qryRelatorio: TUniQuery;
begin
  Result := False;

  qryRelatorio := fCriaQuery(nil);

  Try
    qryRelatorio.Close;
    qryRelatorio.SQL.Clear;

    qryRelatorio.SQL.Add('SELECT REL_CODREL FROM CADREL ');
    qryRelatorio.SQL.Add('LEFT JOIN ATAREL ON ATAREL.ATA_CHAVE_ = CADREL.REL_CHAVE_ ');
    qryRelatorio.SQL.Add('WHERE CADREL.REL_CHAVE_ = :CHAVE_ ');
    qryRelatorio.SQL.Add('   OR ATA_CODATA = :ATAREL ');

    qryRelatorio.ParamByName('CHAVE_').AsInteger := intChaveDefault;
    qryRelatorio.ParamByName('ATAREL').AsInteger := intCodigoAtalho;

    qryRelatorio.Open;

    Result := Not qryRelatorio.IsEmpty;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TRelatorio.fVerificaSeRelatorioExiste]');
  End;

  FreeAndNil(qryRelatorio);
end;

Class Function TRelatorio.fSelecionaRelatorioAtalho(intCodigoAtalho: Integer;
                                                    intChavesPossiveis: Array Of Integer;
                                                    arrParametros: Array Of String;
                                                    intChaveDefault: Integer): Boolean;
  Var
    frmSelecionaRelAtalho: TfrmSelecionaRelAtalho;
    qryAtaRel: TUniQuery;
    sltLista,
    sltChaves: TStringList;
    intContador: Integer;
    strCodRel,
    strChaOri,
    strFiltros: String;
Begin
  Result := False;

  qryAtaRel := fCriaQuery;
  sltLista  := TStringList.Create;
  sltChaves := TStringList.Create;

  For intContador := Low(arrParametros) To High(arrParametros) Do
    sltLista.Add(arrParametros[intContador]);

  For intContador := Low(intChavesPossiveis) To High(intChavesPossiveis) Do
    sltChaves.Add(IntToStr(intChavesPossiveis[intContador]));

  strFiltros := ' FALSE ';
  For intContador := Low(intChavesPossiveis) To High(intChavesPossiveis) Do
    strFiltros := strFiltros + ' OR REL_CHAVE_ = ' +   IntToStr(intChavesPossiveis[intContador]) + ' ';

  With qryAtaRel, SQL Do
  Begin
    Clear;
    Add('SELECT REL_CODREL, REL_DESCRI, IF(REL_TIPIMP = "J", "Jato", "Matricial") AS REL_TIPIMP, REL_CHAVE_ FROM CADREL R');
    Add('WHERE TRUE ');

    If sltLista.Count > 0 Then
    Begin
      Add(' AND (SELECT COUNT(*) FROM CADPRR WHERE PAR_SEQGER = R.AUTOINCREM AND ');
      Add('   PAR_NOMPAR IN (' + fCommaText(sltLista, True) + ')');
      Add('  ) = :QTDPAR ');

      ParamByName('QTDPAR').AsInteger := Length(arrParametros);
    End Else
    Begin
      If sltChaves.Count > 0 Then
        Add(' AND REL_CHAVE_ IN (' + sltChaves.CommaText + ')');
    End;

    Add(' AND R.REL_CODBKP IS NULL ');

    Open;

    If IsEmpty Then
    Begin
      pMensagemOk('O relatório de chave ' + IntToStr(intChaveDefault) + ' não foi encontrado na base do cliente. Favor inseri-lo ou entrar em contato com a Citel.');
    End Else
    Begin
      FieldByName('REL_CODREL').Alignment := taCenter;
      FieldByName('REL_TIPIMP').Alignment := taCenter;

      Filter   := strFiltros;
      Filtered := True;

      pCriarFormularios(TfrmSelecionaRelAtalho, frmSelecionaRelAtalho);

      frmSelecionaRelAtalho.btnRestaurar.Visible := fRelatorioDefinidoDiferenteDoPadrao(intCodigoAtalho, strChaOri);

      frmSelecionaRelAtalho.dtsCadRel.DataSet := qryAtaRel;

      If frmSelecionaRelAtalho.ShowModal = mrOk Then
      Begin
        If frmSelecionaRelAtalho.blnRestaurarRelatorioPadrao Then
        Begin
          Close;
          Clear;
          Add('UPDATE ATAREL');
          Add('  SET ATA_CHAVE_ = ATA_CHAORI,');
          Add('      ATA_CODREL = NULL');
          Add('WHERE ATA_CHAORI IS NOT NULL');
          Add('AND ATA_CODATA = :CODATA');
        End
        Else
        Begin
          strCodRel := FieldByName('REL_CODREL').AsString;

          Close;
          Clear;
          Add('REPLACE INTO ATAREL');
          Add('(ATA_CODATA, ATA_CODREL, ATA_CHAORI) VALUES');
          Add('(:CODATA, :CODREL, :CHAORI)');

          ParamByName('CODREL').AsString  := strCodRel;
          ParamByName('CHAORI').Clear;
          If strChaOri <> '' Then
            ParamByName('CHAORI').AsString  := strChaOri;

        End;

        ParamByName('CODATA').AsInteger := intCodigoAtalho;
        ExecSQL;

        Result := True;
      End;

      pFreeAndNil(frmSelecionaRelAtalho);
    End;

    Close;
  End;

  sltLista.Clear;
  FreeAndNil(sltLista);
  FreeAndNil(qryAtaRel);
  FreeAndNil(sltChaves);
End;

Class function TRelatorio.fRelatorioDefinidoDiferenteDoPadrao(intCodigoAtalho: integer; var strChaOri: String): Boolean;
  var
    qryAtaRel: TUniQuery;
begin
  qryAtaRel := fCriaQuery;
  strChaOri := '';
  Try
    qryAtaRel.SQL.Add('SELECT * FROM ATAREL');
    qryAtaRel.SQL.Add('WHERE ATA_CODATA = :CODATA');
    qryAtaRel.ParamByName('CODATA').AsInteger := intCodigoAtalho;
    qryAtaRel.Open;

    If qryAtaRel.IsEmpty Then
      Exit(False);

    If qryAtaRel.FieldByName('ATA_CHAORI').AsString = '' Then
      Exit(False)
    Else
    Begin
      Result := qryAtaRel.FieldByName('ATA_CODREL').AsString <> '';

      strChaOri := qryAtaRel.FieldByName('ATA_CHAORI').AsString;
    End;

  Finally
    FreeAndNil(qryAtaRel);
  End;



end;


Class Procedure TRelatorio.pExecutaRelatorio(intCodigoAtalho,
                                             intChaveDefault: integer;
                                             intChavesPossiveis: Array Of Integer;
                                             arrParametros: Array Of String;
                                             arrValores: Array Of String;
                                             SenderChamada: TObject;
                                             arrParametrosReadOnly: TArrString = Nil;
                                             blnExecutarDireto: Boolean = False;
                                             blnExibirMensagem: Boolean = True;
                                             strDirAce: String = '';
                                             blnUsuarioLogadoDefaultVerdeVermelho: Boolean = False;
                                             objParametrosRelatorio: TParametrosRelatorio = Nil);
  Var
    qryAtaRel: TUniQuery;
Begin
  If (SenderChamada Is TMenuItem) And ((SenderChamada As TMenuItem).Tag = 199) Then
  Begin
    if fVerificaAcessoSistema('PCRCPB') then
      fSelecionaRelatorioAtalho(intCodigoAtalho, intChavesPossiveis, arrParametros, intChaveDefault)
    else
      pMensagemOk('Você não possui Permissão para alterar a Chamada de Relatório!');
    Exit;
  End;

  qryAtaRel := fCriaQuery;
  With qryAtaRel, SQL Do
  Begin
    Clear;
    Add('SELECT REL_CODREL AS CODREL, C.AUTOINCREM FROM ATAREL');
    Add('INNER JOIN CADREL C ON REL_CHAVE_ = ATA_CHAVE_');
    Add('WHERE ATA_CODATA = :CODATA');
    ParamByName('CODATA').AsInteger := intCodigoAtalho;
    Open;

    If IsEmpty Then
    Begin
      Close;
      Clear;
      Add('SELECT ATA_CODREL AS CODREL, C.AUTOINCREM FROM ATAREL');
      Add('INNER JOIN CADREL C ON REL_CODREL = ATA_CODREL');
      Add('WHERE ATA_CODATA = :CODATA');
      ParamByName('CODATA').AsInteger := intCodigoAtalho;
      Open;
    End;

    If IsEmpty Then
    Begin
      Close;
      Clear;
      Add('SELECT REL_CODREL AS CODREL, C.AUTOINCREM FROM CADREL C');
      Add('WHERE REL_CHAVE_ = :CHAVE_');
      ParamByName('CHAVE_').AsInteger := intChaveDefault;
      Open;
    End;

    If IsEmpty Then
    Begin
      if fVerificaAcessoSistema('PCRCPB') then
      begin
        // CHAMAR A TELA DE CONFIGURAÇÃO
        If fSelecionaRelatorioAtalho(intCodigoAtalho, intChavesPossiveis, arrParametros, intChaveDefault) Then
          pExecutaRelatorio(intCodigoAtalho,
                            intChaveDefault,
                            intChavesPossiveis,
                            arrParametros,
                            arrValores,
                            SenderChamada,
                            arrParametrosReadOnly,
                            blnExecutarDireto,
                            blnExibirMensagem,
                            strDirAce,
                            blnUsuarioLogadoDefaultVerdeVermelho,
                            objParametrosRelatorio);

      end
      else
        pMensagemOk('Relatório de chave ' + IntToStr(intChaveDefault) + ' não encontrado na base do cliente. Favor entrar em contato com a Citel.');
    End Else
    Begin
      // EXECUTAR O RELATÓRIO PASSANDO OS PARÂMETROS
      pSalvaParametros(FieldByName('AUTOINCREM').AsString, arrParametros, arrValores);

      pExecutaRelatorio(FieldByName('CODREL').AsString,
                        arrParametrosReadOnly,
                        blnExecutarDireto,
                        blnExibirMensagem,
                        strDirAce,
                        False,
                        blnUsuarioLogadoDefaultVerdeVermelho,
                        'CADVAL'{ATabelaFiltrosValores: string = 'CADVAL'},
                        ''{AArquivoSaidaDiretoPDF: string = ''},
                        ''{APathImagemCabecalho: string = ''},
                        True{AExecutaRelatorioValidacao: Boolean = True},
                        objParametrosRelatorio);
    End;

  End;
  FreeAndNil(qryAtaRel);
End;

Class Function TRelatorio.fExecutaRelatorio(strCodRel: String;
                                            arrParametrosReadOnly: TArrString = Nil;
                                            blnExecutarDireto: Boolean = False;
                                            blnExibeMensagem: Boolean =  True;
                                            strDirAce: String = '';
                                            blnValidacao: Boolean = False;
                                            blnDestinoJson: Boolean = False;
                                            blnMostrarProgresso: Boolean = True): Boolean;
  Var strJson: String;
Begin
  strJson := '';

  Result := TRelatorio.fExecutaRelatorioJson(strCodRel,
                                             strJson,
                                             arrParametrosReadOnly,
                                             blnExecutarDireto,
                                             blnExibeMensagem,
                                             strDirAce,
                                             blnValidacao,
                                             blnDestinoJson,
                                             blnMostrarProgresso);
End;

Class Function TRelatorio.fExecutaRelatorioJson(strCodRel: String;
                                                Var strJson: String;
                                                arrParametrosReadOnly: TArrString = Nil;
                                                blnExecutarDireto: Boolean = False;
                                                blnExibeMensagem: Boolean =  True;
                                                strDirAce: String = '';
                                                blnValidacao: Boolean = False;
                                                blnDestinoJson: Boolean = False;
                                                blnMostrarProgresso: Boolean = True): Boolean;
  Var
    objRel: TRelatorio;
Begin
  objRel := TRelatorio.Create(Nil, True, SameText(fCampoTabela('REL_CONIND', 'CADREL', ['REL_CODREL'], [strCodRel]), 'S'),  Nil);

  objRel.objInterface.blnDestinoJson := blnDestinoJson;
  objRel.objInterface.blnMostrarProgresso := blnMostrarProgresso;

  Result :=  TRelatorio.fExecutaRelatorioRetorno(objRel,
                                                 strCodRel,
                                                 arrParametrosReadOnly,
                                                 blnExecutarDireto,
                                                 blnExibeMensagem,
                                                 strDirAce,
                                                 blnValidacao);

  strJson := objRel.objInterface.strJson;

  FreeAndNil(objRel);
End;

Class Function TRelatorio.fExecutaRelatorioRetorno(objRel: TRelatorio;
                                                   strCodRel: String;
                                                   arrParametrosReadOnly: TArrString = Nil;
                                                   blnExecutarDireto: Boolean = False;
                                                   blnExibeMensagem: Boolean =  True;
                                                   strDirAce: String = '';
                                                   blnValidacao: Boolean = False;
                                                   objRetornoRelatorio: TRetornoRelatorio = Nil): Boolean;
  Var
    qryTabela,
    qryConsulta: TUniQuery;
    blnContinua: Boolean;
Begin

  // Verificações de direito de acesso
  //   1 tem DIROPE ou DIRGPO, então valida
  //   2 tem DIRACE (antes fixo no Delphi), então valida
  //   3 tem DIRANT (pega do CADREL), então valida
  //   4 não tem nenhum deles, deixa passar

  Result := False;
  blnContinua := True;

  If Not blnValidacao Then
  Begin
    if not fVerificaAcessoSistema('frm' + strCodRel + 'Rel') then
    begin
      if not fEmptyStr(strDirAce) then
      begin
        if not fVerificaAcessoSistema(strDirAce) then
          blnContinua := False;
      end
      else
      begin
        qryConsulta := fCriaQuery;
        try
          qryConsulta.SQL.Text := 'SELECT REL_DIRANT FROM CADREL WHERE REL_CODREL = :CODREL';
          qryConsulta.ParamByName('CODREL').AsString := strCodRel;
          qryConsulta.Open;
          if not fEmptyStr(qryConsulta.FieldByName('REL_DIRANT').AsString) then
            if not fVerificaAcessoSistema(qryConsulta.FieldByName('REL_DIRANT').AsString) then
              blnContinua := False;
        finally
          FreeAndNil(qryConsulta);
        end;
      end;
    end;

    if not blnContinua then
    begin
      pMensagemOk('Operador não tem direito de acesso ao relatório!');
      Exit;
    end;
  End;

  Try
    qryTabela := fCriaQuery;
    qryTabela.SQL.Text := 'SELECT * FROM CADREL WHERE REL_CODREL = :CODREL';
    qryTabela.ParamByName('CODREL').AsString := strCodRel;
    qryTabela.Open;

    If qryTabela.IsEmpty Then
    Begin
      pMensagemOk('Código do Relatório ' + strCodRel + ' não encontrado!');
    End Else
    Begin

      With objRel Do
      Begin
        pInicializaRelatorio(objRel, qryTabela, objRetornoRelatorio);

        If SameText(qryTabela.FieldByName('REL_HORIZO').AsString, 'S') And
          (Not objInterface.fAbreConsultaCampos And  objInterface.fCriaHorizo(0)) Then
        Begin
          FreeAndNil(qryTabela);
          Exit;
        End;

        objInterface.blnValidacao := blnValidacao;
        objInterface.arrParametrosReadOnly := arrParametrosReadOnly;
        objInterface.blnExibirMensagem := blnExibeMensagem;
        objInterface.blnRetornoDados := False;
        objInterface.fecharJanelaDeDadosAoImprimir := objRel.fecharJanelaDeDadosAoImprimir;
        objInterface.HndSelPedidoCompra := objRel.HndSelPedidoCompra;

        If objInterface.fPrecisaRefazerFr3 Then
        Begin
          objGeraFr3.strCodMod := qryTabela.FieldByName('REL_CODMOD').AsString;
          objGeraFr3.cdsComple := objInterface.cdsComplementos;

          If objGeraFr3.fAtualizaPapel(qryTabela) Then
          Begin
            objInterface.pPedeDados(blnExecutarDireto);
          End;

        End Else
        Begin
          If objGeraFr3.fCarregaReport(qryTabela) Then
            objInterface.pPedeDados(blnExecutarDireto);
        End;

        Result := objInterface.blnRetornoDados;

      End;

    End;

    FreeAndNil(qryTabela);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TRelatorio.fExecutaRelatorio]');
    End;
  End;
End;

Class Function TRelatorio.fRetornaJsonEditorDashBoard(intCodigoAtalho,
                                                      intChaveDefault: integer;
                                                      arrParametros: Array Of String;
                                                      arrValores: Array Of String;
                                                      blnMostrarProgresso: Boolean;
                                                      blnExecutarDireto: Boolean = true): string;
Begin
  TRelatorio.fExecutaRelatorioJson(intCodigoAtalho,
                                   intChaveDefault,
                                   [],                 // intChavesPossiveis: Array Of Integer;
                                   arrParametros,
                                   arrValores,
                                   Nil,                // SenderChamada: TObject;
                                   Result,
                                   Nil,                // arrParametrosReadOnly: TArrString = Nil;
                                   blnExecutarDireto,  // blnExecutarDireto: Boolean = False;
                                   True,               // blnExibirMensagem: Boolean = True;
                                   '',                 // strDirAce: String = '')
                                   True,               // blnDestinoJson: Boolean = False
                                   blnMostrarProgresso);
End;

class function TRelatorio.fRetornaUrlDashBoardGatilho(strCodRel: String;
                                                      arrParametrosReadOnly: TArrString = Nil;
                                                      blnExecutarDireto: Boolean = False;
                                                      strDirAce: String = '';
                                                      blnApenasEditarFiltros: Boolean = False;
                                                      blnUsuarioLogadoDefaultVerdeVermelho: Boolean = False;
                                                      ATabelaFiltrosValores: string = 'CADVAL';
                                                      AArquivoSaidaDiretoPDF: string = '';
                                                      APathImagemCabecalho: string = '';
                                                      AExecutaRelatorioValidacao: Boolean = True;
                                                      strUsuarioDireito: String = '';
                                                      objRel: TRelatorio = nil): string;
  Var
    qryTabela,
    qryConsulta: TUniQuery;
    blnContinua: Boolean;
    blnObjRelExterno: Boolean;
Begin

  // Verificações de direito de acesso
  //   1 tem DIROPE ou DIRGPO, então valida
  //   2 tem DIRACE (antes fixo no Delphi), então valida
  //   3 tem DIRANT (pega do CADREL), então valida
  //   4 não tem nenhum deles, deixa passar

  blnContinua := True;
  Result := '';

  blnObjRelExterno := Assigned(objRel);

  if not fVerificaAcessoSistema('frm' + strCodRel + 'Rel', strUsuarioDireito) then
  begin
    if not fEmptyStr(strDirAce) then
    begin
      if not fVerificaAcessoSistema(strDirAce) then
        blnContinua := False;
    end
    else
    begin
      qryConsulta := fCriaQuery;
      try
        qryConsulta.SQL.Text := 'SELECT REL_DIRANT FROM CADREL WHERE REL_CODREL = :CODREL';
        qryConsulta.ParamByName('CODREL').AsString := strCodRel;
        qryConsulta.Open;
        if not fEmptyStr(qryConsulta.FieldByName('REL_DIRANT').AsString) then
          if not fVerificaAcessoSistema(qryConsulta.FieldByName('REL_DIRANT').AsString) then
            blnContinua := False;
      finally
        FreeAndNil(qryConsulta);
      end;
    end;
  end;

  if not blnContinua then
  begin
    pMensagemOk('Operador não tem direito de acesso ao relatório!');
    Exit;
  end;

  Try
    qryTabela := fCriaQuery;
    qryTabela.SQL.Text := 'SELECT * FROM CADREL WHERE REL_CODREL = :CODREL';
    qryTabela.ParamByName('CODREL').AsString := strCodRel;
    qryTabela.Open;

    If qryTabela.IsEmpty Then
    Begin
      pMensagemOk('Código do Relatório ' + strCodRel + ' não encontrado!');
    End Else
    Begin
      if not blnObjRelExterno then
        objRel := TRelatorio.Create(Nil, True, SameText(qryTabela.FieldByName('REL_CONIND').AsString, 'S'), Nil,
                                    False, ATabelaFiltrosValores, AArquivoSaidaDiretoPDF, APathImagemCabecalho,
                                    AExecutaRelatorioValidacao);
      With objRel Do
      Begin
        pInicializaRelatorio(objRel, qryTabela, Nil, Nil);

        If SameText(qryTabela.FieldByName('REL_HORIZO').AsString, 'S') And
          (Not objInterface.fAbreConsultaCampos And  objInterface.fCriaHorizo(0)) Then
        Begin
          FreeAndNil(qryTabela);
          FreeAndNil(objRel);
          Exit;
        End;

        objInterface.arrParametrosReadOnly := arrParametrosReadOnly;
        objInterface.blnApenasEditarFiltros := blnApenasEditarFiltros;
        objInterface.blnUsuarioLogadoDefaultVerdeVermelho := blnUsuarioLogadoDefaultVerdeVermelho;
        objInterface.blnDestinoJson := True;

        If objInterface.fPrecisaRefazerFr3 Then
        Begin
          objGeraFr3.desDestinoFr3 := TInterfaceRelatorio.fDestinoToTipo(qryTabela.FieldByName('REL_DESTIN').AsString);

         If objGeraFr3.desDestinoFr3 In [desVideo, desDesignReport, desImpressora, desPDF, desEmail] Then
           objGeraFr3.strCodMod := qryTabela.FieldByName('REL_CODMOD').AsString;

          objGeraFr3.cdsComple := objInterface.cdsComplementos;

          If (Not (objGeraFr3.desDestinoFr3 In [desVideo, desDesignReport, desImpressora, desPDF, desEmail])) Or
             objGeraFr3.fAtualizaPapel(qryTabela) Then
          Begin
            objInterface.pPedeDados(blnExecutarDireto, False, FPedeDadosModalResult);
          End;

        End Else
        Begin
          If objGeraFr3.fCarregaReport(qryTabela) Then
            objInterface.pPedeDados(blnExecutarDireto, False, FPedeDadosModalResult);
        End;

        Result := objRel.objInterface.fRetornaUrlGrafico;
      End;

      if not blnObjRelExterno then
        FreeAndNil(objRel);
    End;

    FreeAndNil(qryTabela);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TRelatorio.pExecutaRelatorio]');
    End;
  End;
End;

class function TRelatorio.fRetornaUrlDashBoardGatilho(var AJsonDadosEnviaWhatsapp: String;
                                                      strCodRel: String;
                                                      arrParametrosReadOnly: TArrString = Nil;
                                                      blnExecutarDireto: Boolean = False;
                                                      strDirAce: String = '';
                                                      blnApenasEditarFiltros: Boolean = False;
                                                      blnUsuarioLogadoDefaultVerdeVermelho: Boolean = False;
                                                      ATabelaFiltrosValores: string = 'CADVAL';
                                                      AArquivoSaidaDiretoPDF: string = '';
                                                      APathImagemCabecalho: string = '';
                                                      AExecutaRelatorioValidacao: Boolean = True;
                                                      strUsuarioDireito: String = ''): string;
var
  objRel: TRelatorio;
begin
  objRel := TRelatorio.Create(Nil,
                              True,
                              True,
                              Nil,
                              False,
                              ATabelaFiltrosValores,
                              AArquivoSaidaDiretoPDF,
                              APathImagemCabecalho,
                              AExecutaRelatorioValidacao);
  try
    Result := fRetornaUrlDashBoardGatilho(strCodRel,
                                          arrParametrosReadOnly,
                                          blnExecutarDireto,
                                          strDirAce,
                                          blnApenasEditarFiltros,
                                          blnUsuarioLogadoDefaultVerdeVermelho,
                                          ATabelaFiltrosValores,
                                          AArquivoSaidaDiretoPDF,
                                          APathImagemCabecalho,
                                          AExecutaRelatorioValidacao,
                                          strUsuarioDireito,
                                          objRel);

    AJsonDadosEnviaWhatsapp := objRel.objInterface.strDadosJsonEnviaWhatsapp;
    AJsonDadosEnviaWhatsapp := AJsonDadosEnviaWhatsapp.Replace('URL_DASHBOARD', Result);
  finally
    FreeAndNil(objRel);
  end;
end;

Class Function TRelatorio.fExecutaRelatorio(intCodigoAtalho,
                                            intChaveDefault: integer;
                                            intChavesPossiveis: Array Of Integer;
                                            arrParametros: Array Of String;
                                            arrValores: Array Of String;
                                            SenderChamada: TObject;
                                            arrParametrosReadOnly: TArrString = Nil;
                                            blnExecutarDireto: Boolean = False;
                                            blnExibirMensagem: Boolean = True;
                                            strDirAce: String = '';
                                            blnDestinoJson: Boolean = False;
                                            blnMostrarProgresso: Boolean = True): Boolean;
  Var strJson: String;
Begin
  strJson := '';

  Result := TRelatorio.fExecutaRelatorioJson(intCodigoAtalho,
                                             intChaveDefault,
                                             intChavesPossiveis,
                                             arrParametros,
                                             arrValores,
                                             SenderChamada,
                                             strJson,
                                             arrParametrosReadOnly,
                                             blnExecutarDireto,
                                             blnExibirMensagem,
                                             strDirAce,
                                             blnDestinoJson,
                                             blnMostrarProgresso);
End;


Class Function TRelatorio.fExecutaRelatorioJson(intCodigoAtalho,
                                                intChaveDefault: integer;
                                                intChavesPossiveis: Array Of Integer;
                                                arrParametros: Array Of String;
                                                arrValores: Array Of String;
                                                SenderChamada: TObject;
                                                Var strJson: String;
                                                arrParametrosReadOnly: TArrString = Nil;
                                                blnExecutarDireto: Boolean = False;
                                                blnExibirMensagem: Boolean = True;
                                                strDirAce: String = '';
                                                blnDestinoJson: Boolean = False;
                                                blnMostrarProgresso: Boolean = True): Boolean;
  Var
    qryAtaRel: TUniQuery;
Begin

  Result := False;

  If (SenderChamada Is TMenuItem) And ((SenderChamada As TMenuItem).Tag = 199) Then
  Begin
    if fVerificaAcessoSistema('PCRCPB') then
      fSelecionaRelatorioAtalho(intCodigoAtalho, intChavesPossiveis, arrParametros, intChaveDefault)
    else
      pMensagemOk('Você não possui Permissão para alterar a Chamada de Relatório!');
    Exit;
  End;

  qryAtaRel := fCriaQuery;
  With qryAtaRel, SQL Do
  Begin
    Clear;
    Add('SELECT REL_CODREL AS CODREL, C.AUTOINCREM FROM ATAREL');
    Add('INNER JOIN CADREL C ON REL_CHAVE_ = ATA_CHAVE_');
    Add('WHERE ATA_CODATA = :CODATA');
    ParamByName('CODATA').AsInteger := intCodigoAtalho;
    Open;

    If IsEmpty Then
    Begin
      Close;
      Clear;
      Add('SELECT ATA_CODREL AS CODREL, C.AUTOINCREM FROM ATAREL');
      Add('INNER JOIN CADREL C ON REL_CODREL = ATA_CODREL');
      Add('WHERE ATA_CODATA = :CODATA');
      ParamByName('CODATA').AsInteger := intCodigoAtalho;
      Open;
    End;

    If IsEmpty Then
    Begin
      Close;
      Clear;
      Add('SELECT REL_CODREL AS CODREL, C.AUTOINCREM FROM CADREL C');
      Add('WHERE REL_CHAVE_ = :CHAVE_');
      ParamByName('CHAVE_').AsInteger := intChaveDefault;
      Open;
    End;

    If IsEmpty Then
    Begin
      // CHAMAR A TELA DE CONFIGURAÇÃO
      If fSelecionaRelatorioAtalho(intCodigoAtalho, intChavesPossiveis, arrParametros, intChaveDefault) Then
        Result := fExecutaRelatorio(intCodigoAtalho,
                          intChaveDefault,
                          intChavesPossiveis,
                          arrParametros,
                          arrValores,
                          SenderChamada,
                          arrParametrosReadOnly,
                          blnExecutarDireto,
                          blnExibirMensagem,
                          strDirAce);

    End Else
    Begin
      // EXECUTAR O RELATÓRIO PASSANDO OS PARÂMETROS
      pSalvaParametros(FieldByName('AUTOINCREM').AsString, arrParametros, arrValores);

      Result := fExecutaRelatorioJson(FieldByName('CODREL').AsString,
                                      strJson,
                                      arrParametrosReadOnly,
                                      blnExecutarDireto,
                                      blnExibirMensagem,
                                      strDirAce,
                                      False, // blnValidacao: Boolean = False;
                                      blnDestinoJson,
                                      blnMostrarProgresso);
    End;

  End;
  FreeAndNil(qryAtaRel);
End;

Class Function TRelatorio.fExecutaRelatorioCodigo(strCodRel: String;
                                                  arrParametros: Array Of String;
                                                  arrValores: Array Of String;
                                                  arrParametrosReadOnly: TArrString = Nil;
                                                  blnExecutarDireto: Boolean = False;
                                                  blnExibirMensagem: Boolean = True;
                                                  strDirAce: String = '';
                                                  blnValidacao: Boolean = False;
                                                  objRetornoRelatorio: TRetornoRelatorio = Nil;
                                                  fcharJanelaDeDadosAoImprimir: Boolean = False;
                                                  HandleSelPedidoCompra: THandle = 0): Boolean;
  Var
    objRelatorio: TRelatorio;
Begin
  objRelatorio := TRelatorio.Create(Nil, True, SameText(fCampoTabela('REL_CONIND', 'CADREL', ['REL_CODREL'], [strCodRel]), 'S'), Nil);
  objRelatorio.fecharJanelaDeDadosAoImprimir := fcharJanelaDeDadosAoImprimir;
  objRelatorio.HndSelPedidoCompra := HandleSelPedidoCompra;
  Result := TRelatorio.fExecutaRelatorioCodigoRetorno(objRelatorio,
                                                      strCodRel,
                                                      arrParametros,
                                                      arrValores,
                                                      arrParametrosReadOnly,
                                                      blnExecutarDireto,
                                                      blnExibirMensagem,
                                                      strDirAce,
                                                      blnValidacao,
                                                      objRetornoRelatorio);

  FreeAndNil(objRelatorio);
End;

Class Function TRelatorio.fExecutaRelatorioCodigoRetorno(objRelatorio: TRelatorio;
                                                         strCodRel: String;
                                                         arrParametros: Array Of String;
                                                         arrValores: Array Of String;
                                                         arrParametrosReadOnly: TArrString = Nil;
                                                         blnExecutarDireto: Boolean = False;
                                                         blnExibirMensagem: Boolean = True;
                                                         strDirAce: String = '';
                                                         blnValidacao: Boolean = False;
                                                         objRetornoRelatorio: TRetornoRelatorio = Nil): Boolean;
  Var
    qryCadRel: TUniQuery;
Begin
  qryCadRel := fCriaQuery;

  qryCadRel.SQL.Add('SELECT REL_CODREL AS CODREL, C.AUTOINCREM FROM CADREL C');
  qryCadRel.SQL.Add('WHERE REL_CODREL = ' + QuotedStr(strCodRel));
  qryCadRel.Open;

  If qryCadRel.IsEmpty Then
  Begin
    pMensagemOk('Relatório ' + strCodRel + ' não encontrado!');
    Result := False;
  End Else
  Begin
    // EXECUTAR O RELATÓRIO PASSANDO OS PARÂMETROS
    pSalvaParametros(qryCadRel.FieldByName('AUTOINCREM').AsString, arrParametros, arrValores);

    Result := fExecutaRelatorioRetorno(objRelatorio,
                                       qryCadRel.FieldByName('CODREL').AsString,
                                       arrParametrosReadOnly,
                                       blnExecutarDireto,
                                       blnExibirMensagem,
                                       strDirAce,
                                       blnValidacao,
                                       objRetornoRelatorio);
  End;

  FreeAndNil(qryCadRel);
End;

Class Function TRelatorio.fRetornaSelectEditorDashBoard(intCodigoAtalho,
                                                        intChaveDefault: integer;
                                                        arrParametros: Array Of String;
                                                        arrValores: Array Of String;
                                                        Var strTemporarias: String): string;
  Var
    qryAtaRel: TUniQuery;
Begin
  qryAtaRel := fCriaQuery;
  Try
    With qryAtaRel, SQL Do
    Begin
      Clear;
      Add('SELECT REL_CODREL AS CODREL, C.AUTOINCREM FROM ATAREL');
      Add('INNER JOIN CADREL C ON REL_CHAVE_ = ATA_CHAVE_');
      Add('WHERE ATA_CODATA = :CODATA');
      ParamByName('CODATA').AsInteger := intCodigoAtalho;
      Open;

      If IsEmpty Then
      Begin
        Close;
        Clear;
        Add('SELECT ATA_CODREL AS CODREL, C.AUTOINCREM FROM ATAREL');
        Add('INNER JOIN CADREL C ON REL_CODREL = ATA_CODREL');
        Add('WHERE ATA_CODATA = :CODATA');
        ParamByName('CODATA').AsInteger := intCodigoAtalho;
        Open;
      End;

      If IsEmpty Then
      Begin
        Close;
        Clear;
        Add('SELECT REL_CODREL AS CODREL, C.AUTOINCREM FROM CADREL C');
        Add('WHERE REL_CHAVE_ = :CHAVE_');
        ParamByName('CHAVE_').AsInteger := intChaveDefault;
        Open;
      End;

      If not IsEmpty Then
      Begin
        // EXECUTAR O RELATÓRIO PASSANDO OS PARÂMETROS
        pSalvaParametros(FieldByName('AUTOINCREM').AsString, arrParametros, arrValores);

        Result := fRetornaSelectEditorDashBoard(FieldByName('CODREL').AsString, strTemporarias);
      End;

    End;
  Finally
    FreeAndNil(qryAtaRel);
  End;
End;

Class Function TRelatorio.fRetornaSelectEditorDashBoard(strCodRel: String; Var strTemporarias: String): string;
  Var
    qryTabela: TUniQuery;
    objRel: TRelatorio;
Begin
  qryTabela := fCriaQuery;
  Try
    Result := '';
    qryTabela.SQL.Text := 'SELECT * FROM CADREL WHERE REL_CODREL = :CODREL';
    qryTabela.ParamByName('CODREL').AsString := strCodRel;
    qryTabela.Open;
    If qryTabela.IsEmpty Then
      pMensagemOk('Código do Relatório ' + strCodRel + ' não encontrado!')
    Else
    Begin
      objRel := TRelatorio.Create(Nil, True, SameText(qryTabela.FieldByName('REL_CONIND').AsString, 'S'), Nil);
      Try
        objRel.objInterface.blnApagaTemporarias := False;

        objRel.objInterface.pCarregaTemporarias(strTemporarias);

        With objRel Do
        Begin
          pInicializaRelatorio(objRel, qryTabela, Nil);

          If SameText(qryTabela.FieldByName('REL_HORIZO').AsString, 'S') And
            (Not objInterface.fAbreConsultaCampos And  objInterface.fCriaHorizo(0)) Then
          Begin
            Exit;
          End;

          objInterface.arrParametrosReadOnly := nil;
          objInterface.blnExibirMensagem := False;
          objInterface.blnRetornoDados := False;

          If objInterface.fPrecisaRefazerFr3 Then
          Begin
            objGeraFr3.strCodMod := qryTabela.FieldByName('REL_CODMOD').AsString;
            objGeraFr3.cdsComple := objInterface.cdsComplementos;
            If objGeraFr3.fAtualizaPapel(qryTabela) Then
            Begin
              Result := objInterface.fPedeDados(True, False, False);
              strTemporarias := objInterface.fGetListaTemporarias;
            End;
          End
          Else
          Begin
            If objGeraFr3.fCarregaReport(qryTabela) Then
              Result := objInterface.fPedeDados(True, False, False);
          End;
        End;
      Finally
        FreeAndNil(objRel);
      End;
    End;
  Finally
    FreeAndNil(qryTabela);
  End;
End;

initialization

  prcExecutaRelatorio := TRelatorio.pExecutaRelatorio;
  fncExecutaRelatorio := TRelatorio.fExecutaRelatorio;
  fncExecutaRelatorioCodigo := TRelatorio.fExecutaRelatorioCodigo;
  fncRetornaSelectEditorDashBoard := TRelatorio.fRetornaSelectEditorDashBoard;

  fncRetornaJsonEditorDashBoard := TRelatorio.fRetornaJsonEditorDashBoard;

  fncVerificaSeRelatorioExiste := TRelatorio.fVerificaSeRelatorioExiste;

end.


