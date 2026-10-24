unit untCdsDigMultLoja;

interface

Uses
  Classes, DB, cxGridDBBandedTableView, Windows, SysUtils, Variants,
  DateUtils, untAltEst, EditFocus, Forms, Controls, StdCtrls, ExtCtrls,
  Uni, UniClientDataSet, untFuncoesSimples, untGravando, StrUtils,
  untFuncoesPedidoSimples, Shlobj, Math, IniFiles, untZClient,
  cxGridCustomView, untTypesSistema, CxProgressBar, untRecuperaPedido,
  untEntDigMultiLojasNovo, untPreparaGeracaoTE;

Type
  TRecDadosAnteriores = Record
    fltEstMax,
    fltMaxDig,
    fltEstMin,
    fltMinDig,
    fltQtdIte: Double;
    strEsMilj: String;
    blnCarregou: boolean;
  End;

  TRecDimFrm = Record
    wrdHeight,
    wrdWidth: Word;
    blnMaxim,
    blnCarregar: Boolean;
  End;

  TDefineTransferencia = Procedure Of Object;


  TcxgItensQTDITEPropertiesValidate = procedure (Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean)  of object;

  TProcAtualizaCdsCotacao = procedure (AQtdite: Double; ACodIte: String) of object;

  TCdsDigMultLoja = Class(TComponent)
  Private
    intCalSal,
    intDEQTPC: Integer;

    blnUsaItemExterno,
    blnESMILJ,
    blnUsaPDV,
    blnEntFut,
    blnOrdPro,
    blnLibPcm: Boolean;

    frmGravando: TfrmGravando;

    FProcAtualizaCdsCotacao: TProcAtualizaCdsCotacao;

    FQtSalGeral,
    FMediaGeral: Double;

    FAfterPostPedido: TprcScroll;

    FPcddetAfterPost: TprcScroll;

    recDadosAntetiores: TRecDadosAnteriores;

    strCmpMlt: String;
    blnDiaSai,
    blnMINDIG,
    FSinMul,
    FTelMul,
    FRestaurando: Boolean;

    FSaldos: TZClient;

    FQtdIte: TEditFocus;

    FOrigem,
    FDestino,

    FCodIte,
    FSigUni,
    FEmpMat: String;

    FPanelGiro: TPanel;

    FItens,
    FItensSint: TUniClientDataSet;

    FOpcGir: TRecOpcoesGiro;

    FDiaEst,
    FDiaSug: Integer;

    FComGir: Boolean;

    FcxgGiroQTDITE: TcxGridDBBandedColumn;
    FDataSource: TDataSource;
    FstrCodFor: String;

    blnAtualizaCdsCotacao: Boolean;

    function fRetSQLAtuEstMin: String;
    Function fSQLSaldoReservadoGarantia: String;

    Function fDigQuantidadeMultilojaAux(edtQtdIte: TEditFocus;
                                        strCodIte,
                                        strDesIte,
                                        strSigUni: String;
                                        fltQtdEmbP: Double): Boolean;

    Function fCountEmpresasGiro: Integer;

    Procedure pBeforePost(dataSet: TDataSet);


    Procedure pCarregaDadosItem;
    Procedure pCarregaSQLItem;
    Procedure pCalulaDiasEstoqueSint;
    Procedure pCarregaConfiguracoes(frmEntDigMultiLojas: TForm);
    Procedure pSalvaConfiguracoes(frmEntDigMultiLojas: TForm);
    Procedure pHabilitaEdicao(blnEdita: Boolean; frmEntDigMultiLojas: TForm);
    Procedure pCriaDigMultiLojas;
    Procedure pApagaConfiguracoes;
    Procedure pCriaDigUmaLoja;

    procedure pBeforeEditMultLoja(DataSet: TDataSet);
    procedure pAfterCancelMultiLoja(DataSet: TDataSet);

    Procedure pAjustaConfigs;

    Function fAcumulaEmpresaPrg(cxProgresso: TCxProgressBar): Boolean;

    Function fCriaTotalEmpresas: Boolean;
    Function fSQLTotalEmpresas: String;

  Public
    fltQtdEmb: Double;

    FCotacao: Boolean;

    objPreparaGerMultiLoja: TPreparaGeracaoTE;

    pCalculaTotalItemQtdGrid: TDataSetNotifyEvent;


    OncxgItensQTDITEPropertiesValidate: TcxgItensQTDITEPropertiesValidate;

    blnAlterouEstoqueMinMax,
    blnValidarDados: Boolean;

    cdsRequisicao: TUniClientDataSet;

    cdsTotalEmpresas: TZClient;

    pDefineTransferencia: TDefineTransferencia;

    strEmpresaDestino,
    strCnvEmb,
    FDesIte: String;

    frmPaiGiro: TForm;

    fltLimAma: Double;
    recDimFrm: TRecDimFrm;

    pAtualizaMeses: TPrcAtualizaMeses;
    blnExecutarDigMultLoja: Boolean;

    cdsDadosRodapeUma: TUniClientDataSet;
    objRecuperaPedido: TRecuperaPedido;

    frmEntDigMultiLojasNovo: TfrmEntDigMultiLojasNovo;

    Procedure pAfterPostMultiloja(dataSet: TDataSet);

    property cdsItens    : TUniClientDataSet  Read FItens      Write FItens;
    property cdsItensSint: TUniClientDataSet  Read FItensSint  Write FItensSint;
    property recOpcGir   : TRecOpcoesGiro     Read FOpcGir     Write FOpcGir;

    property strCodFor   : String  Read FstrCodFor write FstrCodFor;
    property intDiaEst   : Integer  Read FDiaEst;
    property intDiaSug   : Integer  Read FDiaSug;

    property strEmpMat    : String  Read FEmpMat;
    property strCodIte    : String  Read FCodIte;
    property strSigUniPed : String  Read FSigUni Write FSigUni;

    property blnComGir   : Boolean  Read FComGir Write FComGir;


    property colQtdIte    : TcxGridDBBandedColumn Read FcxgGiroQTDITE Write FcxgGiroQTDITE;

    constructor Create(Owner: TComponent;
                       cdsItensP,
                       cdsItensSintP: TUniClientDataSet;
                       recOpcGirP: TRecOpcoesGiro;
                       pnlGiro: TPanel;
                       blnComGiroP: Boolean;
                       pAfterPostPedido: TprcScroll;
                       pAtualizaMesesP: TPrcAtualizaMeses = Nil;
                       PcddetAfterPost: TprcScroll = Nil;
                       blnCotacao: Boolean = False;
                       cxgItensQTDITEPropertiesValidate: TcxgItensQTDITEPropertiesValidate = nil;
                       pAtualizaCdsCotacao: TProcAtualizaCdsCotacao = nil); Reintroduce;

    Destructor  Destroy; Override;

    Procedure pVeSeIncluiItem(ACodIte: String = '');

    Class function fCriarArquivoTemporario(strNomArq: String = ''; strPathTmp: String = ''): String;
    Class function fGetPathTempOpcoesLocais: String;
    Class function fArquivoParaString(strNomArq: String): String;
    Class function fEscreverNoArquivo(strNomArq, strTexto: String): Boolean;

    function fGetQtdProSintetica(Field: string): Double;

    Function fRetQtdTotal: Double;
    function fGravaEstoqueMin: Boolean;
    function fGravaEsmIdg: Boolean;
    Function fRetDiaSugSint: Integer;
    Function fRetDiaEstSint: Integer;

    function fRetSQLAtuESMIDG(strInEmpresas: string = ''): String;

    Function fAncorado: Boolean;

    Function fValidaDados(blnForcaValidacao: boolean = False): Boolean;

    Function fRetSalResGarantia(strCodIte, strCodEmp: String): Double;

    Function fDigQuantidadeMultiloja(edtQtdIte: TEditFocus;
                                     strCodIte,
                                     strDesIte,
                                     strSigUni: String;
                                     fltQtdEmbP: Double): Boolean;

    Procedure pAncora(blnParent, blnInicializando: Boolean; pnlPainelGiro: TPanel);

    Procedure pSalvaRecDim(frmEntDigMultiLojas: TForm);
    Procedure pCarregaRecDim(frmEntDigMultiLojas: TForm);
    Procedure pRestauraPadrao;

    Function fAcumulaEmpresa(strOrigem, strDestino: String): Boolean;

    Procedure pVeSeIncluiItemMultiLoja(strCodIte: String);
    procedure GridExpand;
    procedure desvinculaEventos(var EvenBeforePost: TDataSetNotifyEvent;
                                var EvenAfterPost: TDataSetNotifyEvent;
                                var EvenBeforeEdit: TDataSetNotifyEvent);
    procedure VinculaEventos(EvenBeforePost: TDataSetNotifyEvent;
                             EvenAfterPost: TDataSetNotifyEvent;
                             EvenBeforeEdit: TDataSetNotifyEvent);
    procedure desvinculaCDS;
    procedure vinculaCDS;

    Procedure pSetaAgrSim(AAgrSim: Boolean);
  End;

implementation

uses
  cxGridTableView, untfuncoesConsulta, untSaldoPedidoCompra, untTelaGiroUma;

constructor TCdsDigMultLoja.Create(Owner: TComponent;
                                   cdsItensP,
                                   cdsItensSintP: TUniClientDataSet;
                                   recOpcGirP: TRecOpcoesGiro;
                                   pnlGiro: TPanel;
                                   blnComGiroP: Boolean;
                                   pAfterPostPedido: TprcScroll;
                                   pAtualizaMesesP: TPrcAtualizaMeses = Nil;
                                   PcddetAfterPost: TprcScroll = Nil;
                                   blnCotacao: Boolean = False;
                                   cxgItensQTDITEPropertiesValidate: TcxgItensQTDITEPropertiesValidate = nil;
                                   pAtualizaCdsCotacao: TProcAtualizaCdsCotacao = nil);
begin
  Inherited Create(Owner);

  fCriaTotalEmpresas;
recDadosAntetiores.blnCarregou := False;
  FProcAtualizaCdsCotacao := pAtualizaCdsCotacao;

  blnAtualizaCdsCotacao := True;

  strEmpresaDestino := '';

  blnExecutarDigMultLoja := True;

  objPreparaGerMultiLoja := TPreparaGeracaoTE.Create;

  objPreparaGerMultiLoja.blnAculumarDigitacao := fCfgSis('LIBETE') <> '2';
  if objPreparaGerMultiLoja.blnAculumarDigitacao Then
    If Assigned(recOpcGirP.objRecupera) Then
     If TRecuperaPedido(recOpcGirP.objRecupera).recPcmger.blnRecuperaPedido Then
       If TRecuperaPedido(recOpcGirP.objRecupera).recPcmger.strPedMlj = 'S' Then
         objPreparaGerMultiLoja.AutincPedidoCompra := TRecuperaPedido(recOpcGirP.objRecupera).recPcmger.strAutInc;

  If objPreparaGerMultiLoja.AutincPedidoCompra <> '' Then
  begin
    objPreparaGerMultiLoja.fSelecionaItensLiberacao;
    objPreparaGerMultiLoja.pRestauraTransferenciasDefinidas;
  End;

  blnUsaItemExterno := fCfgSis('ESTEXT', varBoolean);
  blnESMILJ         := fCfgSis('ESMILJ', varBoolean);

  blnAlterouEstoqueMinMax := False;

  pCalculaTotalItemQtdGrid := Nil;

  fltQtdEmb := 1;

  cdsRequisicao := Nil;
  pDefineTransferencia := Nil;

  frmPaiGiro := Nil;

  frmPaiGiro := Nil;

  FCotacao := blnCotacao;

  If blnCotacao Then
    FSinMul   := False
  Else
    FSinMul   := fCfgSis('TELUMA', varBoolean);

  fltLimAma := fCfgSis('LIMAMA', varDouble);
  FTelMul   := fCfgSis('TELMUL', varBoolean);
  strCmpMlt := fCfgSis('CMPMLT', varString);
  intDEQTPC := fCfgSis('DEQTPC', varInteger);
  intCalSal := fCfgSis('CALSAL', varInteger);
  FEmpMat   := fCfgSis('EMPMAT');
  blnMINDIG := fCfgSis('MINDIG', varBoolean);

  blnDiaSai := fCfgSis('GIRDIA', varInteger) = 2;

  blnLibPcm := fCfgSis('LIBPCM', varBoolean);
  blnOrdPro := fCfgSis('ORDPRO', varBoolean);
  blnUsaPDV := fCfgSis('USAPDV', varBoolean);
  blnEntFut := fCfgSis('ENTFUT', varBoolean);
  strCnvEmb := fCfgSis('CNVEMB');

  FPcddetAfterPost := PcddetAfterPost;

  FQtSalGeral := 0;
  FMediaGeral := 0;

  recDimFrm.wrdHeight   := 800;
  recDimFrm.wrdWidth    := 1280;
  recDimFrm.blnMaxim    := False;
  recDimFrm.blnCarregar := False;

  FRestaurando      := False;
  blnValidarDados   := True;

  FItens            := cdsItensP;
  FItensSint        := cdsItensSintP;
  FOpcGir           := recOpcGirP;
  FComGir           := blnComGiroP;

  If FSinMul And (FOpcGir.strPedMlj = 'S') Then
    cdsDadosRodapeUma := FItensSint
  Else
    cdsDadosRodapeUma := FItens;

  pAtualizaMeses    := pAtualizaMesesP;
  FPanelGiro        := pnlGiro;

  FAfterPostPedido  := pAfterPostPedido;

  FDiaEst           := 0;
  FDiaSug           := 0;
  FSigUni           := '';
  FCodIte           := '';
  FcxgGiroQTDITE    := Nil;

  If Assigned(FItens) Then
  Begin
    FItens.BeforeEdit := pBeforeEditMultLoja;
    FItens.AfterCancel := pAfterCancelMultiLoja;
    FItens.BeforePost := pBeforePost;
    FItens.AfterPost  := pAfterPostMultiloja;
  End;

  FSaldos := TZClient.Create(Self);

  If ((FOpcGir.strPedMlj = 'S') Or FTelMul) And (Not FSinMul) Then
  Begin
    pCriaDigMultiLojas;
    frmEntDigMultiLojasNovo.strEmpCalc := recOpcGirP.strEmpCal;
    pCarregaConfiguracoes(frmEntDigMultiLojasNovo);
    If (Not Assigned(frmEntDigMultiLojasNovo.cxgItensQTDITE.Properties.OnValidate)) And
       (Assigned(cxgItensQTDITEPropertiesValidate)) Then
    Begin
      frmEntDigMultiLojasNovo.cxgItensQTDITE.Properties.OnValidate := cxgItensQTDITEPropertiesValidate;
      OncxgItensQTDITEPropertiesValidate := cxgItensQTDITEPropertiesValidate;
    End;

  End Else
  Begin
    pCriaDigUmaLoja;
  End;

  If Assigned(FItens) And FItens.Active Then
  Begin
    cdsItensP.FieldByName('ITE_NVLGIR').Alignment := taCenter;
    cdsItensP.FieldByName('ITE_NVLCRI').Alignment := taCenter;
    cdsItensP.FieldByName('ITE_DTAULT').Alignment := taCenter;
    cdsItensP.FieldByName('ITE_CODITE').Alignment := taCenter;
    cdsItensP.FieldByName('ITE_CODEMP').Alignment := taCenter;
  End;

  If Assigned(FItensSint) And FItensSint.Active Then
  Begin
    FItensSint.FieldByName('ITE_NVLGIR').Alignment := taCenter;
    FItensSint.FieldByName('ITE_NVLCRI').Alignment := taCenter;
    FItensSint.FieldByName('ITE_DTAULT').Alignment := taCenter;
    FItensSint.FieldByName('ITE_CODITE').Alignment := taCenter;
    FItensSint.FieldByName('ITE_CODEMP').Alignment := taCenter;
  End;

end;

destructor TCdsDigMultLoja.Destroy;
begin
  If Assigned(FItens) Then
    FItens.BeforePost := Nil;

  FreeAndNil(objPreparaGerMultiLoja);

  If Assigned(frmEntDigMultiLojasNovo) Then
  Begin
    pSalvaConfiguracoes(frmEntDigMultiLojasNovo);
    pFreeAndNil(frmEntDigMultiLojasNovo);
  End Else
  Begin
    pFreeAndNil(frmTelaGiroUma);
  End;

  inherited Destroy;
end;

Function TCdsDigMultLoja.fSQLTotalEmpresas: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   CAST(NULL AS CHAR(3)) AS CODEMP, ';
  strSQL := strSQL + '   CAST(0 AS DECIMAL(12,2)) AS TOT_TOTIPI, ';
  strSQL := strSQL + '   CAST(0 AS DECIMAL(12,2)) AS TOT_TOTSUB, ';
  strSQL := strSQL + '   CAST(0 AS DECIMAL(12,2)) AS TOT_TOTITE, ';
  strSQL := strSQL + '   CAST(0 AS DECIMAL(12,2)) AS TOT_TOTGER, ';
  strSQL := strSQL + '   CAST(0 AS DECIMAL(12,2)) AS TOT_TOTDAR, ';
  strSQL := strSQL + '   CAST(0 AS DECIMAL(12,2)) AS TOT_BASCOF, ';
  strSQL := strSQL + '   CAST(0 AS DECIMAL(12,2)) AS TOT_VALCOF, ';
  strSQL := strSQL + '   CAST(0 AS DECIMAL(12,2)) AS TOT_BASPIS, ';
  strSQL := strSQL + '   CAST(0 AS DECIMAL(12,2)) AS TOT_VALPIS, ';
  strSQL := strSQL + '   CAST(0 AS DECIMAL(12,2)) AS TOT_BASICM, ';
  strSQL := strSQL + '   CAST(0 AS DECIMAL(12,2)) AS TOT_VALICM, ';
  strSQL := strSQL + '   CAST(0 AS DECIMAL(12,2)) AS TOT_BASIPI, ';
  strSQL := strSQL + '   CAST(0 AS DECIMAL(12,2)) AS TOT_BASSUB, ';
  strSQL := strSQL + '   CAST(0 AS DECIMAL(12,2)) AS TOT_DESPIS, ';
  strSQL := strSQL + '   CAST(0 AS DECIMAL(12,2)) AS TOT_VALFRE, ';
  strSQL := strSQL + '   CAST(0 AS DECIMAL(12,2)) AS TOT_DESACE, ';

  strSQL := strSQL + '   CAST(0 AS DECIMAL(12,2)) AS TOT_RATFRE, ';
  strSQL := strSQL + '   CAST(0 AS DECIMAL(12,2)) AS TOT_RATACE, ';
  strSQL := strSQL + '   CAST(0 AS DECIMAL(12,2)) AS TOT_SUBFCP, ';
  strSQL := strSQL + '   CAST(0 AS DECIMAL(12,2)) AS TOT_VALCBS, ';
  strSQL := strSQL + '   CAST(0 AS DECIMAL(12,2)) AS TOT_VALIBS, ';
  strSQL := strSQL + '   CAST(0 AS DECIMAL(12,2)) AS TOT_VAL_IS, ';
  strSQL := strSQL + '   CAST(0 AS DECIMAL(12,2)) AS TOT_LITROS, ';
  strSQL := strSQL + '   CAST(0 AS DECIMAL(12,2)) AS TOT_PESLIT  ';

  Result := strSQL;
End;

Function TCdsDigMultLoja.fCriaTotalEmpresas: Boolean;
Begin
  cdsTotalEmpresas := TZClient.Create(Self, fSQLTotalEmpresas);
  Result := cdsTotalEmpresas.fLeDados('TCdsDigMultLoja.fCriaTotalEmpresas');
  cdsTotalEmpresas.IndexFieldNames := 'CODEMP';
End;

procedure TCdsDigMultLoja.desvinculaCDS;
begin
  If Assigned(frmEntDigMultiLojasNovo) Then
  Begin
    If not Assigned(FDataSource) Then
      FDataSource := frmEntDigMultiLojasNovo.cxgItensView.DataController.DataSource;
    frmEntDigMultiLojasNovo.cxgItensView.DataController.DataSource := Nil;
  End;
end;

procedure TCdsDigMultLoja.desvinculaEventos(var EvenBeforePost: TDataSetNotifyEvent;
                                            var EvenAfterPost: TDataSetNotifyEvent;
                                            var EvenBeforeEdit: TDataSetNotifyEvent);
begin
  EvenBeforePost:= FItens.BeforePost;
  EvenAfterPost := FItens.AfterPost;
  EvenBeforeEdit:=  FItens.BeforeEdit;

  FItens.BeforeEdit := nil;
  FItens.BeforePost := nil;
  FItens.AfterPost  := nil;

end;

procedure TCdsDigMultLoja.pBeforeEditMultLoja(DataSet: TDataSet);
Begin
  With recDadosAntetiores, DataSet do
  Begin
    fltEstMax := FieldByName('ITE_ESTMAX').AsFloat;
    fltEstMin := FieldByName('ITE_ESTMIN').AsFloat;

    fltMaxDig := FieldByName('ITE_MAXDIG').AsFloat;
    fltMinDig := FieldByName('ITE_MINDIG').AsFloat;

    fltQtdIte := FieldByName('ITE_QTDITE').AsFloat;

    recDadosAntetiores.strEsMilj := FieldByName('ITE_ESMIDG').AsString;
    recDadosAntetiores.blnCarregou := True;
    RecNo := DataSet.RecNo;

  End;
End;

Procedure TCdsDigMultLoja.pCriaDigMultiLojas;
Begin
  pCriarFormularios(TfrmEntDigMultiLojasNovo, frmEntDigMultiLojasNovo);
  frmEntDigMultiLojasNovo.cdsDigMultLoja := Self;
  frmEntDigMultiLojasNovo.blnCotacao := FCotacao;

  frmEntDigMultiLojasNovo.cxgItensPONPED.Visible := blnMINDIG;
  frmEntDigMultiLojasNovo.cxgItensMINDIG.Visible := blnMINDIG;
  frmEntDigMultiLojasNovo.cxgItensMAXDIG.Visible := blnMINDIG;
  If not blnMINDIG Then
  begin
    frmEntDigMultiLojasNovo.pAddCampoBloqueado(frmEntDigMultiLojasNovo.cxgItensPONPED);
    frmEntDigMultiLojasNovo.pAddCampoBloqueado(frmEntDigMultiLojasNovo.cxgItensMINDIG);
    frmEntDigMultiLojasNovo.pAddCampoBloqueado(frmEntDigMultiLojasNovo.cxgItensMAXDIG);
  end;

  frmEntDigMultiLojasNovo.cxgItensORDPRO.Visible := blnOrdPro;
  If not blnOrdPro Then
    frmEntDigMultiLojasNovo.pAddCampoBloqueado(frmEntDigMultiLojasNovo.cxgItensORDPRO);

  frmEntDigMultiLojasNovo.cxgItensFUTPRE.Visible := blnEntFut;
  frmEntDigMultiLojasNovo.cxgItensFUTFAL.Visible := blnEntFut;
  frmEntDigMultiLojasNovo.cxgItensFUTAGU.Visible := blnEntFut;

  frmEntDigMultiLojasNovo.cxgItensSALEXT.Visible := blnUsaItemExterno;

  If not blnEntFut Then
  Begin
    frmEntDigMultiLojasNovo.pAddCampoBloqueado(frmEntDigMultiLojasNovo.cxgItensFUTPRE);
    frmEntDigMultiLojasNovo.pAddCampoBloqueado(frmEntDigMultiLojasNovo.cxgItensFUTFAL);
    frmEntDigMultiLojasNovo.pAddCampoBloqueado(frmEntDigMultiLojasNovo.cxgItensFUTAGU);
  end;

End;

Procedure TCdsDigMultLoja.pCriaDigUmaLoja;

Begin
  pCriarFormularios(TfrmTelaGiroUma, frmTelaGiroUma);
  frmTelaGiroUma.cdsDigMultLoja := Self;
  frmTelaGiroUma.cxgItensSALEXT.Visible := blnUsaItemExterno;
  frmTelaGiroUma.cxgItensESIMDG.Visible := blnESMILJ;

  With frmTelaGiroUma Do
  Case intCalSal Of
    1: Begin
         cxgItensSALDIS.Index   := IIf(blnUsaItemExterno, 7, 6);
         cxgItensSALEXT.Index   := 6;
       End;
    2: Begin
         cxgItensSALDIS.Index   := IIf(blnUsaItemExterno, 10, 9);
         cxgItensSALEXT.Index   := 9;
       End;
    3: Begin
         cxgItensFUTFAL.Index   := IIf(blnUsaItemExterno, 10,9);
         cxgItensSALDIS.Index   := IIf(blnUsaItemExterno, 9, 8);
         cxgItensSALEXT.Index   := 8;
       End;
    4: Begin
         cxgItensFUTAGU.Index   := IIf(blnUsaItemExterno, 10, 9);
         cxgItensFUTPRE.Index   := IIf(blnUsaItemExterno, 10, 9);
         cxgItensSALDIS.Index   := IIf(blnUsaItemExterno, 8, 7);
         cxgItensSALEXT.Index   := 7;
       End;
    5: Begin
         cxgItensFUTAGU.Index   := IIf(blnUsaItemExterno, 10, 9);
         cxgItensFUTFAL.Index   := IIf(blnUsaItemExterno, 10, 9);
         cxgItensSALDIS.Index   := IIf(blnUsaItemExterno, 8, 7);
         cxgItensSALEXT.Index   := 7;
       End;
  End;

End;

Function TCdsDigMultLoja.fRetQtdTotal: Double;
  Var
    intrecNo: Integer;
Begin
  With FItens Do
  Begin
    DisableControls;
    intRecNo := RecNo;
    Result := 0;

    First;
    While (Not Eof) Do
    Begin
      Result := Result + FieldByName('ITE_QTDITE').AsFloat;
      Next;
    End;
    RecNo := intRecNo;
    EnableControls;
  End;
End;

Procedure TCdsDigMultLoja.pCalulaDiasEstoqueSint;
  Var
    fltSaldos, fltSugest, fltMedia: Double;
    intRecNo: Integer;
Begin
  If Not Assigned(FItens) Then
    Exit;

  With FItens Do
  Begin
    fltSaldos := 0;
    fltSugest := 0;
    fltMedia  := 0;

    DisableControls;
    intRecNo := RecNo;
    First;
    While (Not Eof) Do
    Begin
      fltSaldos := fltSaldos + FieldByName('ITE_SALBAS').AsFloat;
      fltSugest := fltSugest + FieldByName('ITE_SALBAS').AsFloat + FieldByName('ITE_QTDITE').AsFloat + FieldByName('ITE_QTDTRA').AsFloat;

      If recOpcGir.blnMedAju Then
        fltMedia  := fltMedia + FieldByName('ITE_AJUSTA').AsFloat
      Else
        fltMedia  := fltMedia + FieldByName('ITE_MEDIA_').AsFloat;

      Next;
    End;
    RecNo := intRecNo;
    EnableControls;
  End;

  FMediaGeral := fltMedia;
  FQtSalGeral := fltSugest;

  If fltMedia > 0 Then
  Begin
    FDiaEst := Trunc(fltSaldos / (fltMedia / 30));
    FDiaSug := Trunc(fltSugest / (fltMedia / 30));
  End Else
  Begin
    FDiaEst := 0;
    FDiaSug := 0;
  End;
End;

Procedure TCdsDigMultLoja.pBeforePost(dataSet: TDataSet);
  Var
    blnTravar: Boolean;
    fltQtdTra: Double;
    fltMltCom: Currency;
begin

  blnTravar := False;
  fltQtdTra := 0.0;

  With DataSet Do
  Begin

    If blnValidarDados Then
    Begin

      If FieldByName('ITE_CPRCEN').AsString = 'S' Then
      Begin

        If (FieldByName('ITE_CODEMP').AsString <> FieldByName('ITE_EMPCEN').AsString) And
           (FieldByName('ITE_QTDITE').AsFloat > 0)         And
           (Not fLiberaCompraCentralizada(FieldByName('ITE_CODITE').AsString, FieldByName('ITE_EMPCEN').AsString)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Produto com compra centralizada na loja ' + FieldByName('ITE_EMPCEN').AsString + '.', ['&Ok']);
          FieldByName('ITE_QTDITE').Value := 0;
          Exit;
        End;

      End;

      If (FieldByName('ITE_QTDITE').AsFloat < 0.0) Then
      Begin
        blnTravar := True;
        fltQtdTra := 0.0;
      End;

      If FOpcGir.strPedMlj = 'S' Then
      Begin

        If (FieldByName('ITE_ESTMIN').AsFloat < 0.0) Then
        Begin
          pMensagemOk('O Estoque mínimo deve ser maior ou igual a zero!');
          Abort;
          Exit;
        End;

        If (FieldByName('ITE_ESTMAX').AsFloat < 0.0) Then
        Begin
          pMensagemOk('O Estoque máximo deve ser maior ou igual a zero!');
          Abort;
          Exit;
        End;

        If fAncorado And (FieldByName('ITE_ESTMIN').AsFloat > DataSet.FieldByName('ITE_ESTMAX').AsFloat) Then
        Begin
          pMensagemOk('O Estoque máximo deve ser maior ou igual ao estoque mínimo!');
          Abort;
          Exit;
        End;

        If blnMINDIG Then
        Begin
          If (FieldByName('ITE_MINDIG').AsFloat < 0.0) Then
          Begin
            pMensagemOk('O Estoque mínimo digitado deve ser maior ou igual a zero!');
            Abort;
            Exit;
          End;

          If (FieldByName('ITE_ESTMAX').AsFloat < 0.0) Then
          Begin
            pMensagemOk('O Estoque máximo digitado deve ser maior ou igual a zero!');
            Abort;
            Exit;
          End;

          If fAncorado And (FieldByName('ITE_MINDIG').AsFloat > DataSet.FieldByName('ITE_MAXDIG').AsFloat) Then
          Begin
            pMensagemOk('O Estoque máximo digitado deve ser maior ou igual ao estoque mínimo digitado!');
            Abort;
            Exit;
          End;
        End;

        fltMltCom := Frac(RoundTo(FieldByName('ITE_QTDITE').AsFloat / FieldByName('ITE_MLTCOM').AsFloat, -4));
        If (strCmpMlt <> 'N') And
           (FieldByName('ITE_MLTCOM').AsFloat <> 0) And
           (fltMltCom  <> 0) Then
        Begin
          If AnsiIndexText(strCmpMlt,['S','T']) >= 0 Then
            pMensagemOk('Quantidade permitida somente em múltiplos de compra (' + FormatFloat('#0.00', FieldByName('ITE_MLTCOM').AsFloat)  + ')!');

          If (strCmpMlt = 'T') Then
          Begin
            If Not fLiberaQuantidadeMultiplos(FieldByName('ITE_CODITE').AsString) Then
              Abort;
          End
          Else
          If strCmpMlt = 'A' Then
            pMensagemOk('Quantidade está fora do do múltiplos de compra (' + FormatFloat('#0.00', FieldByName('ITE_MLTCOM').AsFloat)  + ')!');
        End;

        If (Not fEmptyStr(FieldByName('ITE_INCIRQ').AsString)) And
           (FieldByName('ITE_ATEREQ').AsString <> 'T') And
           (FieldByName('ITE_QTDREQ').AsFloat > 0) And
           ( RoundTo(FieldByName('ITE_QTDREQ').AsFloat, -4) >
             RoundTo(FieldByName('ITE_QTDITE').AsFloat * IIf(FieldByName('ITE_EMBALA').AsFloat = 0, 1, FieldByName('ITE_EMBALA').AsFloat), -4)) Then
        Begin
          pMensagemOk('A quantidade do item ' + FieldByName('ITE_CODITE').AsString + ' para a empresa ' +
                      FieldByName('ITE_CODEMP').AsString + ' não pode ser menor que ' +
                      'a quantidade pendende de requisição (' + FormatFloat('#,##0.00', FieldByName('ITE_QTDREQ').AsFloat) +
                      ') a qual ela está vinculada!');
          Abort;
          Exit;
        End;

      End;

      If (blnTravar) Then
      Begin
        fMensagem('ATENÇÃO!', 'A quantidade não pode ser menor que ' + FloatToStrF(fltQtdTra, ffNumber, 12, 2), ['&Ok']);
        FieldByName('ITE_QTDITE').AsFloat := DataSet.FieldByName('ITE_QTDITE').OldValue;
        Abort;
      End;
    End;

    FieldByName('ITE_PESOIT').AsFloat := FieldByName('ITE_PESORI').AsFloat * FieldByName('ITE_QTDITE').AsFloat * FieldByName('ITE_QTDEMB').AsFloat;

    If IIF(recOpcGir.blnMedAju, FieldByName('ITE_AJUSTA').AsFloat, FieldByName('ITE_MEDIA_').AsFloat) > 0 Then
    Begin

      FieldByName('ITE_DIASUG').AsInteger := Trunc(RoundTo((FieldByName('ITE_SALBAS').AsFloat +
                                                           (FieldByName('ITE_QTDITE').AsFloat * FieldByName('ITE_QTDEMB').AsFloat) + FieldByName('ITE_QTDTRA').AsFloat) /
                                             (IIF(recOpcGir.blnMedAju, FieldByName('ITE_AJUSTA').AsFloat,
                                                                       FieldByName('ITE_MEDIA_').AsFloat) / 30), -4))
    End Else
    Begin
      FieldByName('ITE_DIASUG').Clear;
    End;

    FQtSalGeral := FQtSalGeral - FieldByName('ITE_QTDANT').AsFloat + FieldByName('ITE_QTDITE').AsFloat + FieldByName('ITE_QTDTRA').AsFloat;

    If FMediaGeral > 0 Then
      FDiaSug := Trunc(FQtSalGeral / (FMediaGeral / 30))
    Else
      FDiaSug := 0;

    FieldByName('ITE_QTDANT').AsFloat := FieldByName('ITE_QTDITE').AsFloat;

    FieldByName('ITE_ALTERA').AsString := 'S';

    pCalculaVariacaoCompra(dataSet);
  End; {With DataSet Do}

  TCalculaCamposPedido.pCalcFields(dataSet);
End;

Function TCdsDigMultLoja.fValidaDados(blnForcaValidacao: boolean = False): Boolean;
Begin
  Result := True;

  If (blnAlterouEstoqueMinMax or blnForcaValidacao) And Assigned(FItens) And FItens.Active And FItens.Filtered Then
  Begin

    FItens.DisableControls;

    Try

      FItens.First;

      While Not FItens.Eof Do
      Begin

        If FItens.FieldByName('ITE_ESTMIN').AsFloat > FItens.FieldByName('ITE_ESTMAX').AsFloat Then
        Begin
          pMensagemOk('O estoque máximo deve ser maior ou igual ao estoque mínimo!');
          Result := False;
          Exit;
        End;

        FItens.Next;
      End;

    Finally

      FItens.EnableControls;

    End;

  End;

End;

procedure TCdsDigMultLoja.GridExpand;
begin
  Try
    If Assigned(frmEntDigMultiLojasNovo) Then
      frmEntDigMultiLojasNovo.cxgItensView.ViewData.Expand(True);

  Except
    //Se der algume erro não atrapalhar o processo
  End;
end;

Function TCdsDigMultLoja.fAncorado: Boolean;
Begin
  Result := Assigned(frmEntDigMultiLojasNovo) And Assigned(frmEntDigMultiLojasNovo.Parent);
End;

procedure TCdsDigMultLoja.pAfterCancelMultiLoja(DataSet: TDataSet);
begin
  recDadosAntetiores.blnCarregou := False;
end;

Procedure TCdsDigMultLoja.pAfterPostMultiLoja(dataSet: TDataSet);
  var RecNo: integer;
      bkpAfterPosLoc: TprcScroll;
      blnEdicao: Boolean;
begin
  RecNo := DataSet.RecNo;

   bkpAfterPosLoc := nil;
  If FOpcGir.strPedMlj = 'S' Then
  With recDadosAntetiores, DataSet Do
  Begin
    If (FieldByName('ITE_ESTMIN').AsFloat <> fltEstMin) Or
       (FieldByName('ITE_ESTMAX').AsFloat <> fltEstMax) Or
       (FieldByName('ITE_MAXDIG').AsFloat <> fltMaxDig) Or
       (FieldByName('ITE_MINDIG').AsFloat <> fltMinDig) Then
    Begin
      blnAlterouEstoqueMinMax := True;

      If (((FieldByName('ITE_ESTMIN').AsFloat <> fltEstMin) Or (FieldByName('ITE_ESTMAX').AsFloat <> fltEstMax)) And
           (FieldByName('ITE_ESTMIN').AsFloat <= FieldByName('ITE_ESTMAX').AsFloat)) Or

         (((FieldByName('ITE_MAXDIG').AsFloat <> fltMaxDig) Or (FieldByName('ITE_MINDIG').AsFloat <> fltMinDig)) And
           (FieldByName('ITE_MINDIG').AsFloat <= FieldByName('ITE_MAXDIG').AsFloat)) Then
        fGravaEstoqueMin;
    End;

    If (recDadosAntetiores.blnCarregou) and (Assigned(FItens.BeforeEdit)) and (Not fEmptyStr(strEsMilj)) And (FieldByName('ITE_ESMIDG').AsString <> strEsMilj) Then
    begin
      fGravaEsmIdg;
      recDadosAntetiores.blnCarregou := False;
    end;

    // VERIFICAR SE ESTÁ ANCORADO
    If (Not FCotacao) And
       (FieldByName('ITE_QTDITE').AsFloat <> fltQtdIte) And
       Assigned(frmEntDigMultiLojasNovo) And Assigned(frmEntDigMultiLojasNovo.Parent) And
       (cdsItensSint.FieldByName('ITE_CODITE').AsString = FieldByName('ITE_CODITE').AsString) Then
    Begin
      cdsItensSint.Edit;
      cdsItensSint.FieldByName('ITE_QTDITE').AsFloat :=
        cdsItensSint.FieldByName('ITE_QTDITE').AsFloat - fltQtdIte + FieldByName('ITE_QTDITE').AsFloat;

      If cdsItensSint.FieldByName('ITE_QTDITE').AsFloat < 0 Then
        cdsItensSint.FieldByName('ITE_QTDITE').AsFloat := 0;

      If Assigned(pCalculaTotalItemQtdGrid) Then
      Begin
        pCalculaTotalItemQtdGrid(cdsItensSint);
        If FItens = Dataset Then
        Begin
          blnEdicao := False;
          If Not (dataSet.State = dsEdit) Then
          Begin
            blnEdicao := true;
            bkpAfterPosLoc := dataSet.AfterPost;
            dataSet.Edit;
          End;

          pCalculaTotalItemQtdGrid(dataSet);
          If blnEdicao Then
          Begin
            dataSet.Post;
            dataSet.AfterPost := bkpAfterPosLoc;
          End;
        End;
      End;

      cdsItensSint.Post;
    End;

  End;

  If (Not FCotacao) And (FOpcGir.strPedMlj <> 'S') And Assigned(FAfterPostPedido) Then
    FAfterPostPedido(DataSet);

  If blnAtualizaCdsCotacao And FCotacao And (FOpcGir.strPedMlj =  'S') And fAncorado And Assigned(FProcAtualizaCdsCotacao)Then
  Begin
    If Pos('ITE_CODITE =', DataSet.Filter) > 0 Then
      FProcAtualizaCdsCotacao(fRetQtdTotal, dataSet.FieldByName('ITE_CODITE').Value);
  End;

  If (Assigned(objRecuperaPedido)) And
     (DataSet.FieldByName('ITE_QTDANT').AsFloat <> DataSet.FieldByName('ITE_QTDTMP').AsFloat) Then
   Begin
     objRecuperaPedido.pAtualizaItem;
   End;

   DataSet.RecNo := RecNo;

End;

Procedure TCdsDigMultLoja.pCarregaSQLItem;
Var
  strSQL: String;
  blnTabPrf: Boolean;
Begin
  blnTabPrf :=  fCfgSis('TABPRF', VarBoolean);

  FSaldos.qryQuery.SQL.Clear;

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '  I.ITE_CODITE, ';
  strSQL := strSQL + '  C.ITE_CODSIM, ';
  strSQL := strSQL + '  I.ITE_LOCFIS, ';
  strSQL := strSQL + '  I.ITE_ESMIDG, ';
  strSQL := strSQL + '  I.ITE_CODEMP, ';
  strSQL := strSQL + '  I.ITE_CPRCEN, ';
  strSQL := strSQL + '  IFNULL(I.ITE_EMPCEN, "' + FEmpMat + '") AS ITE_EMPCEN, ';
  If blnTabPrf Then
    strSQL := strSQL + '  F.ITE_MLTCOM, '
  Else
    strSQL := strSQL + '  C.ITE_MLTCOM, ';

  strSQL := strSQL + '  C.ITE_EMBALA, ';

  strSQL := strSQL + '  U.UNI_ITEFRA, ';
  strSQL := strSQL + '  I.ITE_ESTMIN, ';
  strSQL := strSQL + '  I.ITE_ESTMAX, ';

  strSQL := strSQL + '  I.ITE_PMED_V, ';
  strSQL := strSQL + '  I.ITE_MINDIG, ';
  strSQL := strSQL + '  I.ITE_MAXDIG, ';

  If recOpcGir.blnAgrSim And (fCfgSis('REMSIM', varBoolean) Or fSimilarPrincipal(FCodIte)) Then
  Begin
    strSQL := strSQL + fSQLSaldoItem('I', True, 'C') + ' AS ITE_SALDOS, ';

    strSQL := strSQL +  fSQLSaldosReservadosAgrSim(False, 'I', 'C', 'SP');

    strSQL := strSQL + '  IF(IFNULL(C.ITE_CODSIM, "") = "", (' + fSQLSaldoCotacao(FCodIte, 'I.ITE_CODEMP') + ') , ';
    strSQL := strSQL + '    (' + fSQLSaldoCotacao(FCodIte, 'I.ITE_CODEMP', 'C.ITE_CODSIM') + ')) AS ITE_SALCOT, ';

    strSQL := strSQL + '  IF(IFNULL(C.ITE_CODSIM, "") = "", (' + fSQLVendasPerdidas(FCodIte, 'I.ITE_CODEMP', recOpcGir, FComGir) + ') , ';
    strSQL := strSQL + '    (' + fSQLVendasPerdidas(FCodIte, 'I.ITE_CODEMP', recOpcGir, FComGir, 'C.ITE_CODSIM') + ')) AS ITE_VENPER, ';
  End Else
  Begin
    strSQL := strSQL + '  I.ITE_SALDOS + IF(IFNULL(ITE_CNV_ML, 0) > 0, IFNULL(ITE_SAL_ML, 0) / ITE_CNV_ML, 0) AS ITE_SALDOS, ';

    strSQL := strSQL + fSQLSaldosReservados(False, FComGir, recOpcGir, 'I', 'C', 'SP');

    strSQL := strSQL + '(' + fSQLSaldoCotacao(FCodIte, 'I.ITE_CODEMP') + ') AS ITE_SALCOT, ';
    strSQL := strSQL + '(' + fSQLVendasPerdidas(FCodIte, 'I.ITE_CODEMP', recOpcGir, FComGir) + ') AS ITE_VENPER, ';
  End;

  strSQL := strSQL + '  I.ITE_PONPED, ';
  strSQL := strSQL + '  I.ITE_NIVCRI AS ITE_NVLCRI, ';

  If recOpcGir.recNivEst.nivEstoque = nivGiroFornecedor then
    strSQL := strSQL + '  C.ITE_NVLFOR AS ITE_NVLGIR, '
  Else
  Begin
    If fCfgSis('TIPGIR') = 'S' Then
      strSQL := strSQL + '  I.ITE_NIVGIR AS ITE_NVLGIR, '
    Else
      strSQL := strSQL + '  C.ITE_NVLGIR, ';
  End;

  strSQL := strSQL + '  I.ITE_ESMIDG, ';

  strSQL := strSQL + '  I.ITE_DTAUVE, ';
  strSQL := strSQL + '  I.ITE_PREUVE, ';
  strSQL := strSQL + '  I.ITE_QTDUVE, ';

  strSQL := strSQL + '  I.ITE_PREULT, ';
  strSQL := strSQL + '  I.ITE_IMPULT, ';
  strSQL := strSQL + '  I.ITE_QTDUCO, ';
  strSQL := strSQL + '  I.ITE_FORULT, ';
  strSQL := strSQL + '  UF.FOR_NOMFOR AS ITE_NOMFOR, ';
  strSQL := strSQL + '  I.ITE_DTAULT, ';
  strSQL := strSQL + '  I.ITE_IMPULT, ';
  strSQL := strSQL + '  C.ITE_REFERE,  ';
  strSQL := strSQL + '  I.ITE_PONEXP,  ';
  strSQL := strSQL + '  I.ITE_QTEP_S,  ';
  strSQL := strSQL + '  I.ITE_TIPABS, ';
  strSQL := strSQL + '  I.ITE_VNOLCD ';

  strSQL := strSQL + 'FROM  ';
  strSQL := strSQL + '  ITEGER I ';

  strSQL := strSQL + 'INNER JOIN CADITE C ON C.ITE_CODITE = I.ITE_CODITE ';

  strSQL := strSQL + 'LEFT JOIN SALPDC SP ON SP.SAL_CODITE = I.ITE_CODITE ';
  strSQL := strSQL + '                   AND SP.SAL_CODEMP = I.ITE_CODEMP ';

  strSQL := strSQL + 'LEFT JOIN CADUNI U ON C.ITE_CODUNI = U.UNI_CODUNI ';

  strSQL := strSQL + 'LEFT JOIN CADFOR UF ON UF.FOR_CODFOR = I.ITE_FORULT ';

  strSQL := strSQL + '  LEFT JOIN ITEFOR F ON F.ITE_CODITE = I.ITE_CODITE AND ';
  strSQL := strSQL + '                        F.ITE_CODFOR = ' + FstrCodFor.QuotedString;

  If blnTabPrf Then
  Begin
    strSQL := strSQL + '  AND (SELECT COUNT(*) FROM TABPRE      ';
    strSQL := strSQL + '       WHERE F.ITE_CODTAB = TAB_CODTAB AND TAB_ATICMP = "S" ) > 0 ';
  End Else
  Begin
    strSQL := strSQL + '  AND F.AUTOINCREM = (SELECT MAX(FF.AUTOINCREM) FROM ITEFOR FF  ';
    strSQL := strSQL + '                       WHERE FF.ITE_CODITE = C.ITE_CODITE AND    ';
    strSQL := strSQL + '                             FF.ITE_CODFOR = ' + FstrCodFor.QuotedString + ')         ';
  End;

  strSQL := strSQL + ' INNER JOIN CADEMP E ON E.EMP_CODEMP = I.ITE_CODEMP ';

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  I.ITE_CODITE = :CODITE ';

  strSQL := strSQL + '  AND E.EMP_EMPATI = "S" ';

  If Not fEmptyStr(FOpcGir.strEmpGir) Then
    strSQL := strSQL + ' AND I.ITE_CODEMP IN (' +  FOpcGir.strEmpGir + ') ';

  FSaldos.qryQuery.SQL.Text := strSQL;
End;

Procedure TCdsDigMultLoja.pCarregaDadosItem;
Begin
  With FSaldos Do
  Begin
    pCarregaSQLItem;

    qryQuery.ParamByName('CODITE').AsString := FCodIte;

    fLeDados('TCdsDigMultLoja.pCarregaDadosItem');
  End;
End;

Function TCdsDigMultLoja.fSQLSaldoReservadoGarantia: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + '  SELECT SQL_NO_CACHE  ';
  strSQL := strSQL + '    SUM(COALESCE(GAD_QTDREQ,0) - IFNULL((SELECT SUM(GAE_QTDENV) FROM MOVGAE WHERE GAE_SEQGAD = D.AUTOINCREM ),0) ) QTDRES ';

  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   MOVGAG G ';
  strSQL := strSQL + '    INNER JOIN MOVGAD D ON G.AUTOINCREM = D.GAD_SEQGAG ';

  strSQL := strSQL + ' WHERE  ';

  strSQL := strSQL + '    GAD_CODITE = :CODITE  AND ';
  strSQL := strSQL + '    GAG_CODEMP = :CODEMP  ';

  Result := strSQL;
End;

Function TCdsDigMultLoja.fRetSalResGarantia(strCodIte, strCodEmp: String): Double;
  Var
    qryReservado: TUniQuery;
Begin
  qryReservado := fCriaQuery;
  With qryReservado Do
  Begin
    SQL.Text := fSQLSaldoReservadoGarantia;
    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := strCodEmp;
    Open;

    Result := FieldByName('QTDRES').AsFloat;
  End;
  FreeAndNil(qryReservado);
End;

Function TCdsDigMultLoja.fCountEmpresasGiro: Integer;
  Var
    stlLista: TStringList;
Begin
  stlLista := TStringList.Create;
  stlLista.CommaText := FOpcGir.strEmpGir;
  Result := stlLista.Count;
  FreeAndNil(stlLista);
End;

Procedure TCdsDigMultLoja.pVeSeIncluiItemMultiLoja(strCodIte: String);
  Var
    qryCadEmp: TUniQuery;
    arrCamposFloat: array of integer;
    procedure pMontaArrayCamposFloat;
      var Field: TField;
    begin
      SetLength(arrCamposFloat, 0);
      For Field in FItens.Fields do
      Begin
        If Field.DataType = ftFloat Then
        begin
          SetLength(arrCamposFloat, succ(Length(arrCamposFloat)));
          arrCamposFloat[High(arrCamposFloat)] := Field.Index;
        End;
      end;
    End;
    procedure pZeraTypeFloat;
     var i: integer;
    begin
      For i := 0 to High(arrCamposFloat) do
        FItens.Fields[arrCamposFloat[i]].AsFloat := 0;
    End;
Begin
  With FItens, FOpcGir Do
  Begin
    FCodIte := strCodIte;
    pMontaArrayCamposFloat;
    {*****************************************}
    {* CASO NÃO TENHA MOVIMENTO DE MULTI-LO- *}
    {* JAS, CRIA O MESMO.                    *}
    {**************************************MV*}
    If (RecordCount < fCountEmpresasGiro) Or (RecordCount = 0) Then
    Begin
      pCarregaDadosItem;

      qryCadEmp := fCriaQuery(Self);
      qryCadEmp.SQL.Add('SELECT ');
      qryCadEmp.SQL.Add('  EMP_CODEMP, ');
      qryCadEmp.SQL.Add('  EMP_NOMEMP, ');
      qryCadEmp.SQL.Add('  EMP_NOMFAN  ');
      qryCadEmp.SQL.Add('FROM ');
      qryCadEmp.SQL.Add('  CADEMP ');

      qryCadEmp.SQL.Add(' WHERE ');
      qryCadEmp.SQL.Add('   EMP_EMPATI = "S" ');

      If Not fEmptyStr(strEmpGir) Then
        qryCadEmp.SQL.Add(' AND LOCATE(EMP_CODEMP, ' +  QuotedStr(strEmpGir) + ' ) ');

      qryCadEmp.Open;

      While (Not qryCadEmp.Eof) Do
      Begin

        If Not Locate('ITE_CODEMP', qryCadEmp.FieldByName('EMP_CODEMP').AsString, []) Then
        Begin
          Append;
          FieldByName('ITE_CODITE').AsString := FCodIte;
          FieldByName('ITE_CODEMP').AsString := qryCadEmp.FieldByName('EMP_CODEMP').AsString;
          FieldByName('ITE_DESEMP').AsString := qryCadEmp.FieldByName('EMP_NOMEMP').AsString;
          FieldByName('ITE_FANEMP').AsString := qryCadEmp.FieldByName('EMP_NOMFAN').AsString;

          pZeraTypeFloat;

          If (FSaldos.Locate('ITE_CODITE;ITE_CODEMP',
              VarArrayOf([FCodIte, qryCadEmp.FieldByName('EMP_CODEMP').AsString]), [])) Then
          Begin
            FieldByName('ITE_QTEF_F').AsFloat  := FSaldos.FieldByName('ITE_QTEF_F').AsFloat;
            FieldByName('ITE_QTEF_A').AsFloat  := FSaldos.FieldByName('ITE_QTEF_A').AsFloat;
            FieldByName('ITE_QTEF_P').AsFloat  := FSaldos.FieldByName('ITE_QTEF_P').AsFloat;
            FieldByName('ITE_QTPD_P').AsFloat  := FSaldos.FieldByName('ITE_QTPD_P').AsFloat;
            FieldByName('ITE_SALDOS').AsFloat  := FSaldos.FieldByName('ITE_SALDOS').AsFloat;
            FieldByName('ITE_SALFIS').AsFloat  := FSaldos.FieldByName('ITE_SALFIS').AsFloat;
            FieldByName('ITE_SALDIS').AsFloat  := FSaldos.FieldByName('ITE_SALDIS').AsFloat;
            FieldByName('ITE_SALEXT').AsFloat  := FSaldos.FieldByName('ITE_SALEXT').AsFloat;
            FieldByName('ITE_SALBAS').AsFloat  := FSaldos.FieldByName('ITE_SALBAS').AsFloat;
            FieldByName('ITE_SALRES').AsFloat  := FSaldos.FieldByName('ITE_SALRES').AsFloat;
            FieldByName('ITE_SALEND').AsFloat  := FSaldos.FieldByName('ITE_SALEND').AsFloat;
            FieldByName('ITE_SALTRA').AsFloat  := FSaldos.FieldByName('ITE_SALTRA').AsFloat;
            FieldByName('ITE_SALGAR').AsFloat  := FSaldos.FieldByName('ITE_SALGAR').AsFloat;
            FieldByName('ITE_SALCOT').AsFloat  := FSaldos.FieldByName('ITE_SALCOT').AsFloat;
            FieldByName('ITE_VENPER').AsFloat  := FSaldos.FieldByName('ITE_VENPER').AsFloat;
            FieldByName('ITE_PONEXP').Value    := FSaldos.FieldByName('ITE_PONEXP').Value;
            If opcChamada <> chaSpoolTransferencia Then
              FieldByName('ITE_QTEP_S').Value    := FSaldos.FieldByName('ITE_QTEP_S').Value;
            If FComGir Then
            Begin
              If recOpcGir.blnVenPer Then
                FieldByName('ITE_SALBAS').AsFloat := FieldByName('ITE_SALBAS').AsFloat - FSaldos.FieldByName('ITE_VENPER').AsFloat;

              If recOpcGir.blnConsCot Then
                FieldByName('ITE_SALBAS').AsFloat := FieldByName('ITE_SALBAS').AsFloat + FSaldos.FieldByName('ITE_SALCOT').AsFloat;
            End;

            FieldByName('ITE_ESTMIN').AsFloat  := FSaldos.FieldByName('ITE_ESTMIN').AsFloat;
            FieldByName('ITE_ESTMAX').AsFloat  := FSaldos.FieldByName('ITE_ESTMAX').AsFloat;
            FieldByName('ITE_PMED_V').AsFloat  := FSaldos.FieldByName('ITE_PMED_V').AsFloat;
            FieldByName('ITE_MINDIG').Value    := FSaldos.FieldByName('ITE_MINDIG').Value;
            FieldByName('ITE_MAXDIG').Value    := FSaldos.FieldByName('ITE_MAXDIG').Value;
            FieldByName('ITE_PONPED').AsFloat  := FSaldos.FieldByName('ITE_PONPED').AsFloat;
            FieldByName('ITE_MLTCOM').AsFloat  := FSaldos.FieldByName('ITE_MLTCOM').AsFloat;
            FieldByName('ITE_EMBALA').AsFloat  := FSaldos.FieldByName('ITE_EMBALA').AsFloat;
            FieldByName('ITE_SALREQ').AsFloat  := FSaldos.FieldByName('ITE_SALREQ').AsFloat;
            FieldByName('ITE_QTDPEN').AsFloat  := FSaldos.FieldByName('ITE_QTDPEN').AsFloat;
            FieldByName('ITE_CPRCEN').AsString := FSaldos.FieldByName('ITE_CPRCEN').AsString;
            FieldByName('ITE_EMPCEN').AsString := FSaldos.FieldByName('ITE_EMPCEN').AsString;
            FieldByName('ITE_CPCEMO').AsString := IIF(FSaldos.FieldByName('ITE_CPRCEN').AsString='S', 'C', 'I');
            FieldByName('ITE_LOCFIS').AsString := FSaldos.FieldByName('ITE_LOCFIS').AsString;
            FieldByName('ITE_ESMIDG').AsString := FSaldos.FieldByName('ITE_ESMIDG').AsString;
            FieldByName('ITE_ITEFRA').AsString := FSaldos.FieldByName('UNI_ITEFRA').AsString;
            FieldByName('ITE_NVLGIR').AsString := FSaldos.FieldByName('ITE_NVLGIR').AsString;
            FieldByName('ITE_NVLCRI').AsString := FSaldos.FieldByName('ITE_NVLCRI').AsString;
            FieldByName('ITE_ESMIDG').AsString := FSaldos.FieldByName('ITE_ESMIDG').AsString;
          End;

          pRetCamposGiro(FItens,
                         FCodIte,
                         QuotedStr(qryCadEmp.FieldByName('EMP_CODEMP').AsString),
                         strMeses,
                         blnConsMesAtu,
                         intMesGir,
                         intMesMos,
                         recNivEst,
                         IIF(recOpcGir.blnAgrSim, FSaldos.FieldByName('ITE_CODSIM').AsString, ''));

          FieldByName('ITE_VENMES').AsFloat  := fRetVendasMesItem(FCodIte,
                                                                  IIF(recOpcGir.blnAgrSim, FSaldos.FieldByName('ITE_CODSIM').AsString, ''),
                                                                  qryCadEmp.FieldByName('EMP_CODEMP').AsString,
                                                                  MOnthOf(VS_Date),
                                                                  YearOf(VS_Date),
                                                                  False);

          FieldByName('ITE_Q_VPME').AsFloat  := fRetVendasMesItem(FCodIte,
                                                                  IIF(recOpcGir.blnAgrSim, FSaldos.FieldByName('ITE_CODSIM').AsString, ''),
                                                                  qryCadEmp.FieldByName('EMP_CODEMP').AsString,
                                                                  MOnthOf(VS_Date),
                                                                  YearOf(VS_Date),
                                                                  True);

          FieldByName('ITE_PREULT').Value := FSaldos.FieldByName('ITE_PREULT').Value;
          FieldByName('ITE_IMPULT').Value := FSaldos.FieldByName('ITE_IMPULT').Value;
          FieldByName('ITE_QTDUCO').Value := FSaldos.FieldByName('ITE_QTDUCO').Value;
          FieldByName('ITE_FORULT').Value := FSaldos.FieldByName('ITE_FORULT').Value;
          FieldByName('ITE_NOMFOR').Value := FSaldos.FieldByName('ITE_NOMFOR').Value;
          FieldByName('ITE_DTAULT').Value := FSaldos.FieldByName('ITE_DTAULT').Value;
          FieldByName('ITE_IMPULT').Value := FSaldos.FieldByName('ITE_IMPULT').Value;
          FieldByName('ITE_REFERE').Value := FSaldos.FieldByName('ITE_REFERE').Value;
          FieldByName('ITE_TIPABS').Value := FSaldos.FieldByName('ITE_TIPABS').Value;
          FieldByName('ITE_VNOLCD').Value := FSaldos.FieldByName('ITE_VNOLCD').Value;


          If (Not FieldByName('ITE_DTAULT').IsNull) And (FieldByName('ITE_DTAULT').AsDateTime > 0) Then
            FieldByName('ITE_DIAUCO').AsInteger  := Trunc(VS_Date - FieldByName('ITE_DTAULT').AsDateTime);

          FieldByName('ITE_PREUVE').Value := FSaldos.FieldByName('ITE_PREUVE').Value;
          FieldByName('ITE_QTDUVE').Value := FSaldos.FieldByName('ITE_QTDUVE').Value;
          FieldByName('ITE_DTAUVE').Value := FSaldos.FieldByName('ITE_DTAUVE').Value;

          If (Not FieldByName('ITE_DTAUVE').IsNull) And (FieldByName('ITE_DTAUVE').AsDateTime > 0) Then
            FieldByName('ITE_DIAUVE').AsInteger  := Trunc(VS_Date - FieldByName('ITE_DTAUVE').AsDateTime);

          FieldByName('ITE_QTDEMB').AsFloat  := fltQtdEmb;
          FieldByName('ITE_SIGUNI').AsString := FSigUni;;

          Post;

        End;

        qryCadEmp.Next;
      End;

      qryCadEmp.Close;
      FreeAndNil(qryCadEmp);
    End;
  End;
End;

procedure TCdsDigMultLoja.vinculaCDS;
begin
  If Assigned(FDataSource) Then
    frmEntDigMultiLojasNovo.cxgItensView.DataController.DataSource := FDataSource;
end;

procedure TCdsDigMultLoja.VinculaEventos(EvenBeforePost: TDataSetNotifyEvent;
                                         EvenAfterPost: TDataSetNotifyEvent;
                                         EvenBeforeEdit: TDataSetNotifyEvent);
begin
  FItens.BeforeEdit := EvenBeforeEdit;
  FItens.BeforePost := EvenBeforePost;
  FItens.AfterPost  := EvenAfterPost;
end;


Procedure TCdsDigMultLoja.pVeSeIncluiItem(ACodIte: String = '');
  Var
    blnHabilitar: Boolean;
Begin
  If Not ACodIte.IsEmpty Then
    FCodIte := ACodIte;

  If FCodIte = '' Then
    Exit;

  If Not Assigned(FItens) Then
    Exit;

  If Not FItens.Active Then
    Exit;

  blnValidarDados := False;

  With FItens, FOpcGir Do
  Begin
    blnHabilitar := Not FItens.ControlsDisabled;

    If Not FItens.ControlsDisabled Then
      DisableControls;

    Filtered := False;
    Filter   := 'ITE_CODITE = ' + QuotedStr(FCodIte);
    Filtered := True;

    pVeSeIncluiItemMultiLoja(FCodIte);

    blnAtualizaCdsCotacao := False;

    First;
    While (Not Eof) Do
    Begin
      Edit;
      FieldByName('ITE_QTDTMP').AsFloat := FieldByName('ITE_QTDITE').AsFloat;
      FieldByName('ITE_QTDANT').AsFloat := FieldByName('ITE_QTDITE').AsFloat;
      Post;
      Next;
    End;

    blnAtualizaCdsCotacao := True;

    If blnHabilitar Then
      EnableControls;
  End;

  If ACodIte.IsEmpty Then
    pCalulaDiasEstoqueSint;

  blnValidarDados := True;
End;

function TCdsDigMultLoja.fRetSQLAtuEstMin: String;
Var
  strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'UPDATE   ';
  strSQL := strSQL + '  ITEGER ';
  strSQL := strSQL + 'SET      ';
  strSQL := strSQL + '  ITE_ESTMIN = :ESTMIN, ';
  strSQL := strSQL + '  ITE_ESTMAX = :ESTMAX, ';
  strSQL := strSQL + '  ITE_MINDIG = :MINDIG, ';
  strSQL := strSQL + '  ITE_MAXDIG = :MAXDIG  ';

  strSQL := strSQL + 'WHERE    ';
  strSQL := strSQL + '  ITE_CODITE = :CODITE AND ';
  strSQL := strSQL + '  ITE_CODEMP = :CODEMP     ';

  Result := strSQL;

end;

function TCdsDigMultLoja.fGravaEsmIdg: Boolean;
var
  qryUpd: TUniQuery;
begin
  qryUpd := fCriaQuery;
  Try
    qryUpd.SQL.Clear;
    qryUpd.SQL.Add( fRetSQLAtuESMIDG );
    qryUpd.ParamByName('ESMIDG').AsString := FItens.FieldByName('ITE_ESMIDG').AsString;
    qryUpd.ParamByName('CODITE').AsString := FItens.FieldByName('ITE_CODITE').AsString;
    qryUpd.ParamByName('CODEMP').AsString := FItens.FieldByName('ITE_CODEMP').AsString;

    Try
      fStartTransaction;
      qryUpd.ExecSQL;
      fCommit;
      Result := True;
    Except On
      E:Exception Do
      Begin
        fRollBack;
        Result := False;
        pMensagensErro(E.Message, 'TCdsDigMultLoja.fGravaEsmIdg');
      End;
    End;
  Finally
    FreeAndNil(qryUpd);
  End;
end;

function TCdsDigMultLoja.fGravaEstoqueMin: Boolean;
 Var
   strSQL   : String;
   qryEst   : TUniQuery;
begin
  Result := True;

  With FItens Do
  Try

    If (FieldByName('ITE_ESTMIN').Value <> FieldByName('ITE_ESTMIN').OldValue) Or
       (FieldByName('ITE_ESTMAX').Value <> FieldByName('ITE_ESTMAX').OldValue) Then
    Begin
      qryEst    := fCriaQuery(Self);
      strSQL    := fRetSQLAtuEstMin;

      fStartTransaction;

      TAltEst.fGravaLog(Self,
                        FieldByName('ITE_CODITE').AsString,
                        FieldByName('ITE_CODEMP').AsString,
                        FieldByName('ITE_ESTMIN').AsFloat,
                        FieldByName('ITE_ESTMAX').AsFloat,
                        True,
                        False);


      qryEst.Close;
      qryEst.SQL.Clear;
      qryEst.SQL.Add(strSQL);

      qryEst.ParamByName('ESTMIN').Value := FieldByName('ITE_ESTMIN').Value;
      qryEst.ParamByName('ESTMAX').Value := FieldByName('ITE_ESTMAX').Value;

      qryEst.ParamByName('MINDIG').Value := FieldByName('ITE_MINDIG').Value;
      qryEst.ParamByName('MAXDIG').Value := FieldByName('ITE_MAXDIG').Value;

      qryEst.ParamByName('CODITE').AsString := FieldByName('ITE_CODITE').AsString;
      qryEst.ParamByName('CODEMP').AsString := FieldByName('ITE_CODEMP').AsString;
      qryEst.ExecSQL;

      fCommit;

      FreeAndNil(qryEst);
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      fRollBack;
      pMensagensErro(e.Message, '[TfrmEntDigMultiLojas.fGravaEstoqueMin]');
    End;
  End;

end;

Function TCdsDigMultLoja.fRetDiaSugSint: Integer;
Begin
  If (FOpcGir.strPedMlj = 'S') And Assigned(frmEntDigMultiLojasNovo) And Assigned(frmEntDigMultiLojasNovo.Parent) And
     Assigned(FItensSint) And (Not FItensSint.IsEmpty) {And  (FItensSint.FieldByName('ITE_CODITE').AsString = FCodite)} Then
    Result := FItensSint.FieldByName('ITE_DIASUG').AsInteger
  Else
    Result := FDiaSug;
End;

Function TCdsDigMultLoja.fRetDiaEstSint: Integer;
Begin
  If Assigned(FItensSint) And (Not FItensSint.IsEmpty) {And (FItensSint.FieldByName('ITE_CODITE').AsString = FCodite)} Then
    Result := FItensSint.FieldByName('ITE_DIAEST').AsInteger
  Else
    Result := FDiaEst;
End;

Function TCdsDigMultLoja.fDigQuantidadeMultiloja(edtQtdIte: TEditFocus;
                                                 strCodIte,
                                                 strDesIte,
                                                 strSigUni: String;
                                                 fltQtdEmbP: Double): Boolean;
Begin
  If Assigned(frmEntDigMultiLojasNovo) Then
    frmEntDigMultiLojasNovo.cxgItensQTDITE.Properties.OnValidate := nil;

  Repeat

    FRestaurando := False;

    Result := fDigQuantidadeMultilojaAux(edtQtdIte,
                                         strCodIte,
                                         strDesIte,
                                         strSigUni,
                                         fltQtdEmbP);
   Until Not FRestaurando;

   If Assigned(OncxgItensQTDITEPropertiesValidate) Then
     frmEntDigMultiLojasNovo.cxgItensQTDITE.Properties.OnValidate := OncxgItensQTDITEPropertiesValidate
End;

Function TCdsDigMultLoja.fDigQuantidadeMultilojaAux(edtQtdIte: TEditFocus;
                                                    strCodIte,
                                                    strDesIte,
                                                    strSigUni: String;
                                                    fltQtdEmbP: Double): Boolean;
Begin
  Try
    FQtdIte := edtQtdIte;
    FSigUni := strSigUni;
    FCodIte := strCodIte;
    FDesIte := strDesIte;

    fltQtdEmb := fltQtdEmbP;

    If fltQtdEmb = 0 Then
      fltQtdEmb := 1;

    pVeSeIncluiItem;

    If Not Assigned(frmEntDigMultiLojasNovo) Then
    Begin
      pCriaDigMultiLojas;
      pCarregaConfiguracoes(frmEntDigMultiLojasNovo);
    End;

    frmEntDigMultiLojasNovo.Close;
    frmEntDigMultiLojasNovo.Parent := Nil;

    pHabilitaEdicao(True, frmEntDigMultiLojasNovo);

    recDimFrm.blnCarregar := True;

    frmEntDigMultiLojasNovo.Caption := 'Digitação de Quantidades: ' + strCodIte + ' - ' + strDesIte + ' - ' + strSigUni;

    pCalulaDiasEstoqueSint;

    If Not blnExecutarDigMultLoja Then
      Result := True
    Else If (frmEntDigMultiLojasNovo.ShowModal = mrOk) Then
    Begin
      Result := True;
      edtQtdIte.Text := FloatToStrF(fRetQtdTotal, ffFixed, 12, intDEQTPC);
    End
    Else
    Begin
      Result := False;

      If Not FRestaurando Then
        pVoltaQtdTmpMultiLojas(strCodIte, FItens);
    End;

    If FRestaurando Then
    Begin
      pFreeAndNil(frmEntDigMultiLojasNovo);
      pCriaDigMultiLojas;
      pCarregaConfiguracoes(frmEntDigMultiLojasNovo);
    End Else
    Begin
      pAncora(True, False, Nil);
    End;

    pCalulaDiasEstoqueSint;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[pDigQuantidadeMultiloja]');
    End;
  End;

End;

Procedure TCdsDigMultLoja.pHabilitaEdicao(blnEdita: Boolean; frmEntDigMultiLojas: TForm);
Begin
  With TfrmEntDigMultiLojasNovo(frmEntDigMultiLojas) Do
  Begin
    pnlAltera.Visible  := blnEdita;
    lblAltera.Visible  := blnEdita;
    shpAltera.Visible  := blnEdita;
    pnlBotoes.Visible  := blnEdita;
    pnlStatus.Visible  := blnEdita;
    blnFecharComEscape := blnEdita;
    cxgItensView.OptionsData.Editing := blnEdita Or (Not recOpcGir.blnCotacao);

    If pnlBotoes.Visible Then
     pnlLegendas.Top := pnlBotoes.Top - pnlLegendas.Height;

    If blnEdita Then
    Begin
      BorderStyle := bsSizeable;
      align       := alNone;
      Position    := poScreenCenter;
    End Else
    Begin
      align       := alClient;
      BorderStyle := bsNone;
    End;
  End;
End;

Procedure TCdsDigMultLoja.pAncora(blnParent, blnInicializando: Boolean; pnlPainelGiro: TPanel);
  Var
    intRows,
    intRows2,
    intRows3,
    intContador: Integer;
Begin
  If (FOpcGir.strPedMlj = 'S') And (FSinMul) And (Not blnInicializando) Then
    Exit;

  If Assigned(pnlPainelGiro) Then
  Begin
    If FPanelGiro = pnlPainelGiro Then
      Exit;

    If (FOpcGir.strPedMlj <> 'S') And Assigned(frmTelaGiroUma) Then
    Begin
      FreeAndNil(frmTelaGiroUma);
      pCriaDigUmaLoja;
    End;

    FPanelGiro := pnlPainelGiro;
  End;

  If ((FOpcGir.strPedMlj = 'S') Or FTelMul) And (Not FSinMul) Then
  Begin

    If Assigned(frmEntDigMultiLojasNovo) Then
    With frmEntDigMultiLojasNovo Do
    Begin
      If FOpcGir.strPedMlj <> 'S' Then
      Begin
        FPanelGiro.Height             := 130;
      End Else
      Begin

      End;

      recDimFrm.blnCarregar := False;
      FPanelGiro.Visible := True;
      pHabilitaEdicao(False, frmEntDigMultiLojasNovo);

      If blnParent Then
        parent := FPanelGiro;

      Dock(FPanelGiro, FPanelGiro.BoundsRect);
      Show;

      cxgItensVENMES.Focused := True;
    End;

  End Else If Assigned(frmTelaGiroUma) Then
  Begin
    With frmTelaGiroUma Do
    Begin
      parent := FPanelGiro;

      If Not FComGir Then
        pnlLegenda.Visible:= False;

      cxgItensPONPED.Visible := blnMINDIG;
      cxgItensORDPRO.Visible := blnOrdPro;
      cxgItensFUTPRE.Visible := blnEntFut;
      cxgItensFUTFAL.Visible := blnEntFut;
      cxgItensFUTAGU.Visible := blnEntFut;

      cxgItensMEDIA_.Visible := FComGir;
      cxgItensMEDAJU.Visible := FComGir And (FOpcGir.intMesGir > 3) And (fltLimAma > 0);
      cxgItensMEDIXX.Visible := FComGir;
      cxgItensSUGEST.Visible := FComGir;

      cxgItensDIAEST.Visible := FComGir;
      cxgItensDIASUG.Visible := FComGir;
      cxgItensMAQTSA.Visible := FComGir;
      cxgItensMADTSA.Visible := FComGir;

   //   cxgItensSALBAS.Visible := FComGir;

      If Not FComGir Then
        cxcSugest.Properties.Caption := 'Estoque Máximo/Mínimo';

      intRows := 0;
      For intContador := 0 To cxvSugest.Rows.Count - 1 Do
        If cxvSugest.Rows[intContador].Visible Then
          intRows := intRows + 1;

      intRows2 := 0;
      For intContador := 0 To cxvSaldos.Rows.Count - 1 Do
        If cxvSaldos.Rows[intContador].Visible Then
          intRows2 := intRows2 + 1;

      intRows3 := 0;
      For intContador := 0 To cxVerticalGrid4.Rows.Count - 1 Do
        If cxVerticalGrid4.Rows[intContador].Visible Then
          intRows3 := intRows3 + 1;

      For intContador := 0 To cxVerticalGrid5.Rows.Count - 1 Do
        If cxVerticalGrid5.Rows[intContador].Visible Then
          intRows3 := intRows3 + 1;
      For intContador := 0 To cxVerticalGrid8.Rows.Count - 1 Do
        If cxVerticalGrid8.Rows[intContador].Visible Then
          intRows3 := intRows3 + 1;


      If intRows2 > intRows Then
        intRows := intRows2;

      If intRows3 > intRows Then
        intRows := intRows3;

      If intRows < 8 Then
        intRows := 8;

      ClientHeight := IIF(pnlLegenda.Visible, pnlLegenda.Height, 0) + 17 * intRows + 1 * intRows + 2;

      FPanelGiro.ClientHeight := ClientHeight;
      FPanelGiro.Visible := True;
      Dock(FPanelGiro, FPanelGiro.BoundsRect);

      Show;
    End;
  End;
End;

Class function TCdsDigMultLoja.fCriarArquivoTemporario(strNomArq: String = ''; strPathTmp: String = ''): String;
  Var
    Caminho  : PChar;
    Arquivo  : file;
    strDirVal: String;

  function GetSpecialFolderPath(Folder: Integer; CanCreate: Boolean): String;
    Var
      FilePath: array [0..255] of Char;
  Begin
    SHGetSpecialFolderPath(0, @FilePath[0], FOLDER, CanCreate);
    Result := FilePath;
  End;

begin
  Result := '';

  Try
    If fEmptyStr(strPathTmp) Then
    Begin
      strDirVal := GetSpecialFolderPath(CSIDL_APPDATA, False) + '\Autcom\';

      If Not DirectoryExists(strDirVal) Then
        CreateDir(strDirVal);

      Caminho := PChar(strDirVal);
    End
    Else
      Caminho := PChar(strPathTmp);

    If fEmptyStr(strNomArq) Then
    Begin
      Result := Caminho + IntToStr(RandomRange(0, 99999));

      While FileExists(Result) Do
      Begin
        Result := Caminho + IntToStr(RandomRange(0, 99999));
      End;
    End
    Else
    Begin
      Result := Caminho + strNomArq;
    End;

    AssignFile(Arquivo, Result);
    Rewrite(Arquivo);

  Finally
    CloseFile(Arquivo);
  End;
end;

Class function TCdsDigMultLoja.fArquivoParaString(strNomArq: String): String;
  Var
    stlArq: TStringList;
begin
  Try
    stlArq := TStringList.Create;
    stlArq.LoadFromFile(strNomArq);
    Result := stlArq.Text;
  Except
    Result := '';
  End;

  FreeAndNil(stlArq);
end;

Class function TCdsDigMultLoja.fGetPathTempOpcoesLocais: String;
  Var
    Buffer: Array[0..254] Of Char;
    strPatIni: String;
    iniArqIni : TIniFile;
begin
  Result := '';
  GetWindowsDirectory(Buffer, 255);
  strPatIni := StrPas(Buffer) + '\OPCOES_LOCAIS.INI';

  If FileExists(strPatIni) Then
  Begin
    iniArqIni := TIniFile.Create(strPatIni);
    Try
      Result := iniArqIni.ReadString('ARQUIVOS_TEMPORARIOS', 'PATH' , Result)
    Finally
      iniArqIni.Free;
    End;
  End;
end;

function TCdsDigMultLoja.fGetQtdProSintetica(Field: string): Double;
begin
  Result := 0;
  if Assigned(FItensSint) then
    If Assigned(FItensSint.FindField(Field)) Then
      Result :=  FItensSint.FieldByName(Field).AsFloat;

end;

Procedure TCdsDigMultLoja.pSalvaConfiguracoes(frmEntDigMultiLojas: TForm);
  Var
    qryCfgPdc: TUniQuery;
    strArqTemp: String;
    stlCfgFrm: TStringList;
Begin
  If Not Assigned(frmEntDigMultiLojas) Then
    Exit;

  With TfrmEntDigMultiLojasNovo(frmEntDigMultiLojas) Do
  Begin

    stlCfgFrm := TStringList.Create;
    stlCfgFrm.Add(IntToStr(recDimFrm.wrdHeight));
    stlCfgFrm.Add(IntToStr(recDimFrm.wrdWidth));

    If recDimFrm.blnMaxim Then
      stlCfgFrm.Add('1')
    Else
      stlCfgFrm.Add('0');

    strArqTemp := fCriarArquivoTemporario('',fGetPathTempOpcoesLocais);
    cxgItensView.StoreToIniFile(strArqTemp, True, [gsoUseFilter, gsoUseSummary]);

    qryCfgPdc := fCriaQuery;

    With qryCfgPdc, SQL Do
    Begin
      Clear;
      Add('SELECT * FROM CFGPDC');
      Add('WHERE CFG_CODOPE = :CODOPE');
      Add('  AND IFNULL(CFG_NOMGRI, "") =  "" ');

      ParamByName('CODOPE').AsString := strLoginUsuarioLogado;

      Open;

      If IsEmpty Then
      Begin
        qryCfgPdc.Insert;
        FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CFGPDC', VS_strCodEmp);
      End Else
      Begin
        Edit;
      End;

      FieldByName('CFG_CFGGRI').AsString := fArquivoParaString(strArqTemp);
      FieldByName('CFG_CFGFRM').AsString := stlCfgFrm.Text;
      FieldByName('CFG_CODOPE').AsString := strLoginUsuarioLogado;

      Post;

      DeleteFile(PChar(strArqTemp));

    End;

    FreeAndNil(qryCfgPdc);
    FreeAndNil(stlCfgFrm);
  End;

End;

Class function TCdsDigMultLoja.fEscreverNoArquivo(strNomArq, strTexto: String): Boolean;
  Var
    Arquivo: TextFile;
begin
  Result := True;

  Try

    If Not FileExists(strNomArq) Then
    Begin
      Result := False;
    End
    Else
    Begin
      AssignFile(Arquivo, strNomArq);
      Rewrite(Arquivo);
      Write(Arquivo, strTexto);
    End;

  Finally
    CloseFile(Arquivo);
  End;
end;

Procedure TCdsDigMultLoja.pCarregaConfiguracoes(frmEntDigMultiLojas: TForm);
  Var
    qryCfgPdc: TUniQuery;
    strArqTemp: String;
    stlCfgFrm: TStringList;
Begin
  With TfrmEntDigMultiLojasNovo(frmEntDigMultiLojas) Do
  Begin
    qryCfgPdc := fCriaQuery;

    With qryCfgPdc, SQL Do
    Begin
      Clear;
      Add('SELECT * FROM CFGPDC');
      Add('WHERE CFG_CODOPE = :CODOPE');
      Add('  AND IFNULL(CFG_NOMGRI, "") =  "" ');

      ParamByName('CODOPE').AsString := strLoginUsuarioLogado;

      Open;

      If Not IsEmpty Then
      Begin
        stlCfgFrm := TStringList.Create;

        strArqTemp := fCriarArquivoTemporario('',fGetPathTempOpcoesLocais);

        If fEscreverNoArquivo(strArqTemp, FieldByName('CFG_CFGGRI').AsString) Then
        Begin
          cxgItensView.RestoreFromIniFile(strArqTemp);

          frmEntDigMultiLojasNovo.cxgItensPONPED.Visible := blnMINDIG and frmEntDigMultiLojasNovo.fGetVisibleArrCamposCfg(cxgItensPONPED);

          TfrmEntDigMultiLojasNovo(frmEntDigMultiLojas).pCarregaArrCampos;

          frmEntDigMultiLojasNovo.cxgItensMINDIG.Visible := blnMINDIG And frmEntDigMultiLojasNovo.fGetVisibleArrCamposCfg(cxgItensMINDIG);
          If Not blnMINDIG Then
            frmEntDigMultiLojasNovo.pAddCampoBloqueado(frmEntDigMultiLojasNovo.cxgItensMINDIG);

          frmEntDigMultiLojasNovo.cxgItensMAXDIG.Visible := blnMINDIG And frmEntDigMultiLojasNovo.fGetVisibleArrCamposCfg(cxgItensMAXDIG);
          If Not blnMINDIG Then
            frmEntDigMultiLojasNovo.pAddCampoBloqueado(frmEntDigMultiLojasNovo.cxgItensMAXDIG);

          frmEntDigMultiLojasNovo.cxgItensORDPRO.Visible := blnOrdPro And frmEntDigMultiLojasNovo.fGetVisibleArrCamposCfg(cxgItensORDPRO);
          If not blnOrdPro Then
             frmEntDigMultiLojasNovo.pAddCampoBloqueado(frmEntDigMultiLojasNovo.cxgItensORDPRO);



          frmEntDigMultiLojasNovo.cxgItensFUTPRE.Visible := blnEntFut And frmEntDigMultiLojasNovo.fGetVisibleArrCamposCfg(cxgItensFUTPRE);
          frmEntDigMultiLojasNovo.cxgItensFUTFAL.Visible := blnEntFut And frmEntDigMultiLojasNovo.fGetVisibleArrCamposCfg(cxgItensFUTFAL);
          frmEntDigMultiLojasNovo.cxgItensFUTAGU.Visible := blnEntFut And frmEntDigMultiLojasNovo.fGetVisibleArrCamposCfg(cxgItensFUTAGU);
          If not blnEntFut then
          Begin
            frmEntDigMultiLojasNovo.pAddCampoBloqueado(frmEntDigMultiLojasNovo.cxgItensFUTPRE);
            frmEntDigMultiLojasNovo.pAddCampoBloqueado(frmEntDigMultiLojasNovo.cxgItensFUTFAL);
            frmEntDigMultiLojasNovo.pAddCampoBloqueado(frmEntDigMultiLojasNovo.cxgItensFUTAGU);
          End;

          DeleteFile(PChar(strArqTemp));
        End;

        stlCfgFrm.Text := FieldByName('CFG_CFGFRM').AsString;

        If stlCfgFrm.Count > 0 Then
          recDimFrm.wrdHeight := StrToIntDef(stlCfgFrm[0], 800);

        If stlCfgFrm.Count > 1 Then
          recDimFrm.wrdWidth := StrToIntDef(stlCfgFrm[1], 1280);

        If stlCfgFrm.Count > 2 Then
          recDimFrm.blnMaxim := StrToIntDef(stlCfgFrm[2], 0) = 1;

        FreeAndNil(stlCfgFrm);
      End;

    End;

    FreeAndNil(qryCfgPdc);
  End;

  pAjustaConfigs;
End;

Procedure TCdsDigMultLoja.pAjustaConfigs;
Begin
  If (FOpcGir.strPedMlj = 'S') Then
  Begin
    frmEntDigMultiLojasNovo.cxgItensView.Bands[0].Visible := True;
    frmEntDigMultiLojasNovo.cxgItensView.OptionsView.GroupFooters := gfAlwaysVisible;
    frmEntDigMultiLojasNovo.cxgItensView.OptionsView.Footer       := True;
    frmEntDigMultiLojasNovo.cxgItensCODITE.GroupIndex             := 0;

    frmEntDigMultiLojasNovo.cxgItensView.DataController.Filter.Root.Clear;
  End Else
  Begin
    frmEntDigMultiLojasNovo.cxgItensView.Bands[0].Visible := False;
    frmEntDigMultiLojasNovo.cxgItensView.OptionsView.GroupFooters := gfInvisible;
    frmEntDigMultiLojasNovo.cxgItensView.OptionsView.Footer       := False;
    frmEntDigMultiLojasNovo.cxgItensView.Controller.LeftPos := 0;
    frmEntDigMultiLojasNovo.cxgItensCODITE.GroupIndex             := -1;
  End;

  With frmEntDigMultiLojasNovo Do
  Begin
    cxgItensMEDIA_.Visible := (FOpcGir.strPedMlj = 'S') and frmEntDigMultiLojasNovo.fGetVisibleArrCamposCfg(cxgItensMEDIA_);
    cxgItensSUGEST.Visible := (FOpcGir.strPedMlj = 'S') and frmEntDigMultiLojasNovo.fGetVisibleArrCamposCfg(cxgItensSUGEST);
    cxgItensMEDIXX.Visible := (FOpcGir.strPedMlj = 'S') and frmEntDigMultiLojasNovo.fGetVisibleArrCamposCfg(cxgItensMEDIXX);
    cxgItensMEDAJU.Visible := (FOpcGir.strPedMlj = 'S') and frmEntDigMultiLojasNovo.fGetVisibleArrCamposCfg(cxgItensMEDAJU);
    cxgItensDIAEST.Visible := (FOpcGir.strPedMlj = 'S') and frmEntDigMultiLojasNovo.fGetVisibleArrCamposCfg(cxgItensDIAEST);
    cxgItensDIASUG.Visible := (FOpcGir.strPedMlj = 'S') and frmEntDigMultiLojasNovo.fGetVisibleArrCamposCfg(cxgItensDIASUG);
    cxgItensMAQTSA.Visible := (FOpcGir.strPedMlj = 'S') and frmEntDigMultiLojasNovo.fGetVisibleArrCamposCfg(cxgItensMAQTSA);
    cxgItensMADTSA.Visible := (FOpcGir.strPedMlj = 'S') and frmEntDigMultiLojasNovo.fGetVisibleArrCamposCfg(cxgItensMADTSA);
    cxgItensDIASAI.Visible := (FOpcGir.strPedMlj = 'S') and frmEntDigMultiLojasNovo.fGetVisibleArrCamposCfg(cxgItensDIASAI) And blnDiaSai;

    cxgItensQTDEMB.Visible := (TCdsDigMultLoja(cdsDigMultLoja).strCnvEmb <> 'N') and (Not TCdsDigMultLoja(CdsDigMultLoja).FCotacao) And frmEntDigMultiLojasNovo.fGetVisibleArrCamposCfg(cxgItensQTDEMB);
    cxgItensQTDVEN.Visible := (TCdsDigMultLoja(cdsDigMultLoja).strCnvEmb <> 'N') and (Not TCdsDigMultLoja(CdsDigMultLoja).FCotacao) And frmEntDigMultiLojasNovo.fGetVisibleArrCamposCfg(cxgItensQTDVEN);

    If (TCdsDigMultLoja(CdsDigMultLoja).strCnvEmb = 'N') Or (TCdsDigMultLoja(CdsDigMultLoja).FCotacao) Then
    Begin
      pAddCampoBloqueado(cxgItensQTDEMB);
      pAddCampoBloqueado(cxgItensQTDVEN);
    End;

    If Not blnDiaSai Then
      pAddCampoBloqueado(cxgItensDIASAI);

    If Not (FOpcGir.strPedMlj = 'S') Then
    Begin
      pAddCampoBloqueado(cxgItensDIASAI);
      pAddCampoBloqueado(cxgItensMEDIA_);
      pAddCampoBloqueado(cxgItensSUGEST);
      pAddCampoBloqueado(cxgItensMEDIXX);
      pAddCampoBloqueado(cxgItensMEDAJU);
      pAddCampoBloqueado(cxgItensDIAEST);
      pAddCampoBloqueado(cxgItensDIASUG);
      pAddCampoBloqueado(cxgItensMAQTSA);
      pAddCampoBloqueado(cxgItensMADTSA);
    end;

    cxgItensPONPED.Visible := blnMINDIG and frmEntDigMultiLojasNovo.fGetVisibleArrCamposCfg(cxgItensPONPED);

    cxgItensORDPRO.Visible := blnOrdPro and frmEntDigMultiLojasNovo.fGetVisibleArrCamposCfg(cxgItensORDPRO);
    If not blnOrdPro Then
      pAddCampoBloqueado(cxgItensORDPRO);

    cxgItensFUTPRE.Visible := blnEntFut and frmEntDigMultiLojasNovo.fGetVisibleArrCamposCfg(cxgItensFUTPRE);
    cxgItensFUTFAL.Visible := blnEntFut and frmEntDigMultiLojasNovo.fGetVisibleArrCamposCfg(cxgItensFUTFAL);
    cxgItensFUTAGU.Visible := blnEntFut and frmEntDigMultiLojasNovo.fGetVisibleArrCamposCfg(cxgItensFUTAGU);
    If not blnEntFut Then
    Begin
      pAddCampoBloqueado(cxgItensFUTPRE);
      pAddCampoBloqueado(cxgItensFUTFAL);
      pAddCampoBloqueado(cxgItensFUTAGU);
    End;
  End;
End;

Procedure TCdsDigMultLoja.pSalvaRecDim(frmEntDigMultiLojas: TForm);
Begin
  With TfrmEntDigMultiLojasNovo(frmEntDigMultiLojas) Do
  If recDimFrm.blnCarregar Then
  Begin
    recDimFrm.blnMaxim := (WindowState = wsMaximized);

    If Not recDimFrm.blnMaxim Then
    Begin
      recDimFrm.wrdHeight := Height;
      recDimFrm.wrdWidth  := Width;
    End;
  End;
End;

Procedure TCdsDigMultLoja.pCarregaRecDim(frmEntDigMultiLojas: TForm);
Begin
  With TfrmEntDigMultiLojasNovo(frmEntDigMultiLojas) Do
  Begin
    If recDimFrm.blnCarregar Then
    Begin
      Height := recDimFrm.wrdHeight;
      Width  := recDimFrm.wrdWidth;
      If recDimFrm.blnMaxim Then
        WindowState := wsMaximized;
    End;
  End;
End;

Procedure TCdsDigMultLoja.pApagaConfiguracoes;
  Var
    qryCfgPdc: TUniQuery;
Begin
  qryCfgPdc := fCriaQuery;

  With qryCfgPdc, SQL Do
  Begin
    Clear;
    Add('DELETE FROM CFGPDC');
    Add('WHERE CFG_CODOPE = :CODOPE');

    ParamByName('CODOPE').AsString := strLoginUsuarioLogado;

    ExecSQL
  End;

  FreeAndNil(qryCfgPdc);
End;

Procedure TCdsDigMultLoja.pRestauraPadrao;
  Var
    blnAncorado: Boolean;
Begin
  blnAncorado := Assigned(frmEntDigMultiLojasNovo.Parent);

  frmEntDigMultiLojasNovo.Close;

  pApagaConfiguracoes;

  If blnAncorado Then
  Begin
    pCriaDigMultiLojas;
    pAncora(False, False, Nil);
  End Else
  Begin
    FRestaurando := True;
  End;

  pAjustaConfigs;
End;

Function TCdsDigMultLoja.fAcumulaEmpresaPrg(cxProgresso: TCxProgressBar): Boolean;
  Var
    cdsOrigem: TUniClientDataSet;
    stlLisReq: TStringList;
    intDecUni,
    intContador: Integer;
Begin
  frmGravando.lblGravando.Caption := 'Transferindo ' + FOrigem + ' para ' + FDestino;
  Application.ProcessMessages;

  stlLisReq := TStringList.Create;

  cdsItens.Filter   := 'ITE_CODEMP = ' + QuotedStr(FDestino);
  cdsItens.Filtered := True;
  cdsItens.IndexFieldNames := 'ITE_CODITE';

  cdsOrigem := TUniClientDataSet.Create(Nil);
  cdsOrigem.Data := cdsItens.Data;
  cdsOrigem.IndexFieldNames := 'ITE_CODEMP;ITE_CODITE';

  cdsOrigem.Filter   := 'ITE_QTDITE > 0 AND ITE_CODEMP = ' + QuotedStr(FOrigem);
//  cdsOrigem.Filter   := 'ITE_CODEMP = ' + QuotedStr(FOrigem);
  cdsOrigem.Filtered := True;
  cdsOrigem.First;

  cxProgresso.Properties.Max := 2 * cdsOrigem.RecordCount;

  intDecUni := fCfgSis('DECUNI');

  While Not cdsOrigem.Eof Do
  Begin

    If cdsItens.FindKey([cdsOrigem.FieldByName('ITE_CODITE').AsString]) Then
    Begin
      cdsItens.Edit;
      cdsItens.FieldByName('ITE_QTDITE').AsFloat := cdsItens.FieldByName('ITE_QTDITE').AsFloat + cdsOrigem.FieldByName('ITE_QTDITE').AsFloat;


      cdsItens.FieldByName('ITE_TOTITE').AsFloat := RoundTo(cdsItens.FieldByName('ITE_QTDITE').AsFloat *
                                  RoundTo(cdsItens.FieldByName('ITE_UNITAR').AsFloat *
                                    (   (1 - cdsItens.FieldByName('ITE_DESUNI').AsFloat / 100)
                                      * (1 - cdsItens.FieldByName('ITE_DESUN2').AsFloat / 100)
                                      * (1 - cdsItens.FieldByName('ITE_DESUN3').AsFloat / 100)
                                      * (1 - cdsItens.FieldByName('ITE_DESUN4').AsFloat / 100)
                                      * (1 - cdsItens.FieldByName('ITE_DESUN5').AsFloat / 100)
                                      * (1 - cdsItens.FieldByName('ITE_DESUN6').AsFloat / 100) ), - intDecUni), -2);

         cdsItens.FieldByName('ITE_BASIPI').AsFloat  := cdsItens.FieldByName('ITE_TOTITE').AsFloat;
         cdsItens.FieldByName('ITE_TOTIPI').AsFloat  := cdsItens.FieldByName('ITE_BASIPI').AsFloat * cdsItens.FieldByName('ITE_PERIPI').AsFloat / 100;

         If cdsItens.FieldByName('ITE_QTDITE').AsFloat > 0 Then
           cdsItens.FieldByName('ITE_TOTSUB').AsFloat := (cdsItens.FieldByName('ITE_TOTSUB').AsFloat * cdsItens.FieldByName('ITE_QTDITE').AsFloat) /
                                                   cdsItens.FieldByName('ITE_QTDITE').AsFloat
         Else
           cdsItens.FieldByName('ITE_TOTSUB').AsFloat := 0;

         If cdsItens.FieldByName('ITE_QTDITE').AsFloat > 0 Then
           cdsItens.FieldByName('ITE_VALFRE').AsFloat := (cdsItens.FieldByName('ITE_VALFRE').AsFloat * cdsItens.FieldByName('ITE_QTDITE').AsFloat) /
                                                   cdsItens.FieldByName('ITE_QTDITE').AsFloat
         Else
           cdsItens.FieldByName('ITE_VALFRE').AsFloat := 0;

         If cdsItens.FieldByName('ITE_QTDITE').AsFloat > 0 Then
           cdsItens.FieldByName('ITE_DESACE').AsFloat := (cdsItens.FieldByName('ITE_DESACE').AsFloat * cdsItens.FieldByName('ITE_QTDITE').AsFloat) /
                                                   cdsItens.FieldByName('ITE_QTDITE').AsFloat
         Else
           cdsItens.FieldByName('ITE_DESACE').AsFloat := 0;

         pCalculaImpostosReformaItem(cdsItens, False);




      If Not fEmptyStr(cdsOrigem.FieldByName('ITE_INCIRQ').AsString) Then
      Begin

        If fEmptyStr(cdsItens.FieldByName('ITE_INCIRQ').AsString) Then
          cdsItens.FieldByName('ITE_INCIRQ').AsString := cdsOrigem.FieldByName('ITE_INCIRQ').AsString
        Else
          cdsItens.FieldByName('ITE_INCIRQ').AsString := cdsItens.FieldByName('ITE_INCIRQ').AsString + ',' + cdsOrigem.FieldByName('ITE_INCIRQ').AsString;

        cdsItens.FieldByName('ITE_QTDREQ').AsFloat := cdsItens.FieldByName('ITE_QTDREQ').AsFloat + cdsOrigem.FieldByName('ITE_QTDREQ').AsFloat;

        stlLisReq.CommaText := cdsOrigem.FieldByName('ITE_INCIRQ').AsString;

        If Assigned(cdsRequisicao) And cdsRequisicao.Active Then
        For intContador := 0 To stlLisReq.Count - 1 do
          If cdsRequisicao.Locate('AUTOINCREM', stlLisReq[intContador], []) Then
          Begin
            cdsRequisicao.Edit;
            cdsRequisicao.FieldByName('EMPDES').AsString := FDestino;
            cdsRequisicao.Post;
          End;

      End;

      cdsItens.Post;
    End;

    cdsOrigem.Next;

    cxProgresso.Position := cxProgresso.Position + 1;
    Application.ProcessMessages;
  End;


  cdsItens.Filter   := 'ITE_QTDITE > 0 AND ITE_CODEMP = ' + QuotedStr(FOrigem);
  cdsItens.Filtered := True;
  cdsItens.First;

  While Not cdsItens.Eof Do
  Begin
    cdsItens.Edit;
    cdsItens.FieldByName('ITE_QTDITE').AsFloat  := 0;
    cdsItens.FieldByName('ITE_QTDREQ').AsFloat  := 0;
    cdsItens.FieldByName('ITE_INCIRQ').AsString := '';
    cdsItens.Post;

   // cdsItens.Next;

    cxProgresso.Position := cxProgresso.Position + 1;
    Application.ProcessMessages;
  End;

  cdsItens.Filter   := '';
  cdsItens.Filtered := False;

  FreeAndNil(cdsOrigem);

  FreeAndNil(stlLisReq);

  Result := True;
End;

Function TCdsDigMultLoja.fAcumulaEmpresa(strOrigem, strDestino: String): Boolean;
  Var
    blnFiltered: Boolean;

    strFilter,
    strIndexFieldNames: String;
Begin
  FOrigem  := strOrigem;
  FDestino := strDestino;

  strFilter          := cdsItens.Filter;
  blnFiltered        := cdsItens.Filtered;
  strIndexFieldNames := cdsItens.IndexFieldNames;

  Try

    Result   := TfrmGravando.fExecuta(fAcumulaEmpresaPrg, frmGravando);

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TCdsDigMultLoja.fAcumulaEmpresa');
    End;
  End;

  cdsItens.Filter          := strFilter;
  cdsItens.Filtered        := blnFiltered;
  cdsItens.IndexFieldNames := strIndexFieldNames;
End;

function TCdsDigMultLoja.fRetSQLAtuESMIDG(strInEmpresas: string = ''): String;
begin
  Result := '';
  Result := Result + 'UPDATE   ';
  Result := Result + '  ITEGER ';
  Result := Result + 'SET      ';
  Result := Result + '  ITE_ESMIDG = :ESMIDG ';
  Result := Result + 'WHERE    ';
  Result := Result + '  ITE_CODITE = :CODITE AND ';
  If strInEmpresas <> '' Then
    Result := Result + '  ITE_CODEMP IN('+strInEmpresas+')'
  Else
    Result := Result + '  ITE_CODEMP = :CODEMP     ';
end;

Procedure TCdsDigMultLoja.pSetaAgrSim(AAgrSim: Boolean);
Begin
  FOpcGir.blnAgrSim := AAgrSim;
End;

end.
