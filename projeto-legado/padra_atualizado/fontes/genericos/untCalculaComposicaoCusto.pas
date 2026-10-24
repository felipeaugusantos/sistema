unit untCalculaComposicaoCusto;

interface
uses System.Variants, uni, Math, SysUtils, cxProgressBar, Classes, Data.DB,
     StrUtils, untParCalculaPrecoCusto, Forms, untGravando, untZClient, Dialogs,
     Vcl.StdCtrls, untTypesTabelaPreco, untTypesSistema;
Type

  TPreco = Record
    fltPreven: Double;
    fltMargem: Double;
    blnCalculado: Boolean;
  End;

  TPrecos = array [1..7] of TPreco;

  TCalculaComposicaoCusto = Class
  private
    intDecUni: integer;

  protected
    qryConsulta             : TUniQuery;
    FstrTipFor              : string;
    FEstadoFornecedor       : string;
    FTipoAbfFornecedor      : string;
    FAliBaseRetICMSForne    : Double;
    FCSTFornecedor          : String;
    FBaseIcmFornecedor      : Double;
    FAliquotaBaseFornecedor : Double;
    FBaseRetICMSFornecedor  : Double;
    FAlqFundoCombatePobreza : Double;
    FIVAFornecedor          : Double;
    FintBSTXML              : Integer;
    FAliquotaICMSSai        : Double;
    FBlnSemST               : Boolean;
    FAlqST                  : Double;
    FComLiq                 : Double;
    FCodAbf                 : String;
    FlblContReg             : Tlabel;
    qryItens                : TZClient;
    qryAbf                  : TUniQuery;
    FTipAtu                 : String;
    strFrmCus               : String;
    blnSufram               : Boolean;
    strAgrupadorPreAlt      : String;
    FOrigemCalculo: TOrigemCalculo;
    cpcParams: TParCalculaPrecoCusto;
    intPrimeiraTabPrecoAtiva: Integer;
    FScriptIteger: TStringList;
    FScriptTabDet: TStringList;
    stlListaTabDetProcessada: TStringList;
    FQryCommand: TUnIQuery;
    frmReprocessaItens : TfrmGravando;
    blnInfMat: Boolean;
    cdsEmpresas: TZClient;
    cdsEmpresasBkp: TZClient;
    FPrecosPrincipal: TPrecos;
    blncpcParamsExterno: Boolean;
    FImpFed: Double;
    FImpSub: Double;
    FDesOpe: Double;
    FOutVal: Double;
    FCodEmp: String;
    FStrCodTab : String;
    FblnRecCustos : Boolean;
    FLocal: String;
    procedure pCarregaItens;
    procedure pCarregaItensSemTabelaPrecoAtivo;
    procedure pCarregaAbreviacoesICMS;
    procedure pProcessaItens;
    procedure pProcessaItensSemTabelaPrecoAtivo;
    procedure pCarregaABFEmpresa(strCodTabela : string);

    function fProcessaItem(cxProgresso: TCxProgressBar): Boolean;
    function fProcessaItemSemTabelaPrecoAtivo(cxProgresso: TCxProgressBar): Boolean;
    function fAtualizaBancoDeDados(cxProgresso: TCxProgressBar): Boolean;
    function fAtualizaBancoDeDadosSemAtivo(cxProgresso: TCxProgressBar): Boolean;

    function fGetUltimaLinhaItem(strCodIte: String): Integer;
    function fGetUltimaLinhaItemSemPrecoAtivo(strCodIte: String; strCodtab: String): Integer;


    procedure pExecutaCalculo(strEmpresaPrincipal, strEmpresasProcessando_A_Processar: String; intRecIni, intRecFin: Integer);
    procedure pExecutaCalculoSemItemAtivo(strEmpresaPrincipal, strEmpresasProcessando_A_Processar: String; intRecIni, intRecFin: Integer);

    procedure pExecutaScript;


    function fTrataFloatString(strValor: String): String;

    procedure pGeraScritp(blnSemAtivo: Boolean = False);
    procedure pGeraScriptIteger();
    procedure pGeraScriptTabDet();
    procedure pGeraScriptTabDetSemAtivo();



    procedure pDefineValorImpostos(var fltIcmEnt, fltIcmSai, fltSubsti: Double);
    function fAlteraTabDet(strAutIncTabDet: String): Boolean;


    procedure pCalulaPrecoDeVendaOuMargem(TipoCalculo: TTipoCalculoMargemPreven;DataSet: TDataSet; intTabela: integer; fltPreCus, fltIcmsSai: Double; var fltMargem, fltPreven: Double; blnSemItemAtivo: Boolean = False);
    procedure pProcessaCalculo(blnPrincipal: Boolean;TipoCalculo: TTipoCalculoMargemPreven);
    procedure pProcessaCalculoSemItemAtivo(blnPrincipal: Boolean;TipoCalculo: TTipoCalculoMargemPreven);

    procedure pDefineVariaveisIniciaisPrecoVendaOuMargem(blnSemItemAtivo: Boolean; intTabela: Integer; blnPrincipal: Boolean; var fltMargem, fltPreven: Double);

    procedure pSePrincipalAlimentaArray(intTabela: Integer;blnPrincipal: Boolean; fltPreven, fltMargem: Double);



    function fRetPrecoCusto(intTabela: Integer; dataSet: TDataSet; fltIcmEnt, fltSubst: Double): Double;
    function fRetPrecoCustoSemItemAtivo(intTabela: Integer;dataSet: TDataSet; fltIcmEnt, fltSubst: Double): Double;
    procedure pMontaEstruturaEmpresas;
    procedure pProcessaFiliais(blnSemPrecoAtivo: Boolean; strEmpresasProcessando_A_Processar: String; TipoCalculoMargemPreven : TTipoCalculoMargemPreven; intRecIni, intRecFin: Integer);


    procedure pReiniciaPrecos;
    function fValidaRegrasParaProcessar(intTabela: integer; strCodFor: String; strCodAbf: String; blnValidaCodAbf: Boolean = True): boolean;
    procedure pProcessaPadrao(TipoCalculo: TTipoCalculoMargemPreven; blnPrincipal: boolean; intTabela: integer; strCodFor: String; var fltPreven, fltIPIEntrada, fltIcmEnt, fltIcmSai, fltSubsti, fltMargem, fltPreCus: Double);
    procedure pProcessaCadEmp(strCodAbf: String; TipoCalculo: TTipoCalculoMargemPreven; blnPrincipal: boolean; intTabela: integer; strCodFor: String; var fltPreven, fltIPIEntrada, fltIcmEnt, fltIcmSai, fltSubsti, fltMargem, fltPreCus: Double);
    procedure pProcessaCadEmpSemItemAtivo(strCodAbf: String; TipoCalculo: TTipoCalculoMargemPreven; blnPrincipal: boolean; intTabela: integer; strCodFor: String; var fltPreven, fltIPIEntrada, fltIcmEnt, fltIcmSai, fltSubsti, fltMargem, fltPreCus: Double);
    procedure pMarTabDetParaRecalculo(blnRevertProcessado: Boolean = False);



    procedure pAtualizaBancoDeDados(blnSemAtivo: Boolean);

    procedure pMontaWherepCarregaItens;
    procedure pMontaLinhaFiltroGeral(strTabela: string);
    procedure pConsultaTabDet(strAutoincrem: String; strTabela: String; strCodEmp: String);


   public
    procedure pCarregaInformacoes(strCodFor, strCodAbf: String; strCodTab: string = '');
    function fProcessaVal(ACSTFornecedor: String;
                          AAliquotaBaseRetICMSFornecedor, AAlqFundoCombatePobreza, ABaseIcmFornecedor,
                          AIPIEntrada, AIVAFornecedor, AAliquotaBaseFornecedor,
                          ABaseRetICMSFornecedor: Double): Double; overload;

    function fProcessaVal(strCodFor, strCodAbf: String;
                          AIPIEntrada: Double): Double; overload;

   class function fCalcula(blnIncPis: Boolean; AComLiq: Double; strCodFor, strCodAbf: String; AIPIEntrada: Double; AcpcParams : TParCalculaPrecoCusto = nil; strCodtab: String = ''): TCalculaComposicaoCusto;
   class function fRetCustoTabDet(AIpiEntrada: Double; blnIncPis: Boolean; strCodFor, strCodAbf, strAutoincrem: String; strTabela: String; strCodEmp: String): TCalculaComposicaoCusto;
   class function fCalculaAlteracaoCadEmp(strLocal: string; strCodEmp: String; ModoRecalculo: TOpcRecalculoTabelas) : Boolean;
   class function fCalculaAlteracaoGeral(strLocal: string; strCodAbf, strCodTab: String; ModoRecalculo: TOpcRecalculoTabelas; blnRecCustos: Boolean;  lblContReg: TLabel = nil): Boolean;

   constructor Create(AcpcParams : TParCalculaPrecoCusto = nil; apenasConsulta: Boolean = False);
   destructor Destroy; override;


   property  blnSemST: Boolean read FBlnSemST;
   property  AliquotaICMSSai: Double read FAliquotaICMSSai;
   property  AliquotaICMSEnt: Double read FAliquotaBaseFornecedor;
   property  AliquotaST: Double read FAlqST;
   property  IVAFornecedor: Double read FIVAFornecedor;
   property OrigemCalculo : TOrigemCalculo read FOrigemCalculo write FOrigemCalculo;

   property ImpFed: Double read FImpFed;
   property SubFed: Double read FImpSub;
   property DesOpe: Double read FDesOpe;
   property OutVal: Double read FOutVal;


end;

  var CalculaComposicaoCusto : TCalculaComposicaoCusto;

implementation

uses
  untFuncoesSimples, untConstantes, untPreAlt, untPreAlt_Trigger,
  untTConfiguracao;


{ TCalculaComposicaoCusto }

function TCalculaComposicaoCusto.fProcessaVal(ACSTFornecedor: String;
                                              AAliquotaBaseRetICMSFornecedor, AAlqFundoCombatePobreza, ABaseIcmFornecedor,
                                              AIPIEntrada, AIVAFornecedor, AAliquotaBaseFornecedor,
                                              ABaseRetICMSFornecedor: Double): Double;
var fltBCICMS: Double;
    fltBCST: Double;
    fltValorDebito: Double;
    fltValorCredito: Double;
    fltValorIcmsSubst: Double;
    fltValIpi: Double;
    fltAliquotaBaseRetICMSFornecedorInt: Double;
begin
  FblnSemST := False;
  If Pos(ACSTFornecedor, CST_SUBSTITUICAO) <= 0  Then
  Begin
    FblnSemST := True;
    Exit(0);
  End;
  If FComLiq = 0 then
    FComLiq := 100
  else
    FComLiq := RoundTo(FComLiq,   (intDecUni)* -1);

  fltValIpi := (FComLiq * AIPIEntrada) / 100;

  fltAliquotaBaseRetICMSFornecedorInt := AAliquotaBaseRetICMSFornecedor + AAlqFundoCombatePobreza;

  fltBCICMS := FComLiq -((FComLiq * (100-ABaseIcmFornecedor)) /100);
//   select (210+21) *60/100 *1.35;

//    select ((210 *50/100)+21) *1.35;

//                  210                      10%                  210                       1.35

  If FintBSTXML = 1 Then // IPI Fora
    fltBCST   := (((FComLiq * ABaseRetICMSFornecedor)/100) + fltValIpi) * FIVAFornecedor
  Else
    fltBCST   := (fltValIpi + FComLiq) * ABaseRetICMSFornecedor/100 * FIVAFornecedor;

  fltValorDebito := (fltBCST * fltAliquotaBaseRetICMSFornecedorInt) / 100;
  fltValorCredito := (fltBCICMS * AAliquotaBaseFornecedor) / 100;
  fltValorIcmsSubst := fltValorDebito - fltValorCredito;
  Result := fFormataFloat(((fltValorIcmsSubst/FComLiq )* 100), 2);
  If Result < 0 Then
    Result := 0;
  FAlqST := Result;
end;


constructor TCalculaComposicaoCusto.Create(AcpcParams : TParCalculaPrecoCusto = nil; apenasConsulta: Boolean = False);
begin
  FblnRecCustos := True;
  FStrCodTab := '';
  qryConsulta := fCriaQuery;
  If Not apenasConsulta then
  Begin
    FCodemp := VS_StrCodEmp;
    FQryCommand := fCriaQuery;
    OrigemCalculo := tocPadrao;
    intDecUni := fCfgSis('DECUNI', varInteger);
    FTipAtu := fCfgSis('ATPVMB');
    strFrmCus := fCfgSis('FRMCUS', varString);
    blnSufram := fCfgSis('SUFRAM', varBoolean);
    intPrimeiraTabPrecoAtiva := fRetPrimeiraTabPrecoAtiva;
    FScriptIteger := TStringList.Create;
    FScriptTabDet := TStringList.Create;
    stlListaTabDetProcessada := TStringList.Create;
    stlListaTabDetProcessada.Sorted := True;
    stlListaTabDetProcessada.Duplicates := dupIgnore;
    blnInfMat := fCfgSis('INFMAT', varBoolean);
    cdsEmpresasBkp := TZClient.Create(nil, '');
    blncpcParamsExterno := false;
    If Assigned(AcpcParams) Then
    begin
      cpcParams :=  AcpcParams;
      blncpcParamsExterno := True
    End
    Else
      cpcParams := TParCalculaPrecoCusto.Create(nil, TConfiguracao.fGetConfiguracao, True, True);

  End;

end;

destructor TCalculaComposicaoCusto.Destroy;
begin
  FreeAndNil(qryConsulta);
  FreeAndNil(FQryCommand);
  FreeAndNil(FScriptIteger);
  FreeAndNil(FScriptTabDet);
  FreeAndNil(stlListaTabDetProcessada);
  FreeAndNil(cdsEmpresasBkp);
  If Not blncpcParamsExterno Then
    FreeAndNil(cpcParams);
end;

class function TCalculaComposicaoCusto.fCalcula(blnIncPis: Boolean; AComLiq: Double; strCodFor, strCodAbf: String;
  AIPIEntrada: Double; AcpcParams : TParCalculaPrecoCusto = nil; strCodtab: String = ''): TCalculaComposicaoCusto;
begin
  result := TCalculaComposicaoCusto.Create(AcpcParams);
  result.FLocal := '';
  result.FComLiq := AComLiq;
  result.pCarregaInformacoes(strCodFor, strCodAbf, strCodtab);
  result.fProcessaVal(strCodFor, strCodAbf, AIPIEntrada);
  If Not blnIncPis Then
  begin
    result.fImpFed := 0;
    result.FImpSub := 0;
  End;
end;

class function TCalculaComposicaoCusto.fRetCustoTabDet(AIpiEntrada: Double; blnIncPis: Boolean; strCodFor, strCodAbf, strAutoincrem,
  strTabela: String; strCodEmp: String): TCalculaComposicaoCusto;
begin
  result := TCalculaComposicaoCusto.Create(nil, True);
  result.pCarregaInformacoes(strCodFor, strCodAbf);
  result.pConsultaTabDet(strAutoincrem, strTabela, strCodEmp);

  Result.FImpFed := 0;
  Result.FImpSub := 0;
  If blnIncPis Then
  Begin
    Result.FImpFed := Result.qryConsulta.FieldByName('ITE_IMPFED').AsFloat;
    Result.FImpSub := Result.qryConsulta.FieldByName('ITE_SUBFED').AsFloat;
  End;
  Result.FDesOpe := Result.qryConsulta.FieldByName('DET_DESOPE').AsFloat;
  Result.FOutVal := Result.qryConsulta.FieldByName('DET_OUTVAL').AsFloat;
  Result.FAliquotaICMSSai := Result.qryConsulta.FieldByName('DET_ICMSAI').AsFloat;
  Result.fProcessaVal(strCodFor, strCodAbf, AIPIEntrada);


end;


class function TCalculaComposicaoCusto.fCalculaAlteracaoGeral(strLocal: string;
  strCodAbf, strCodTab: String; ModoRecalculo: TOpcRecalculoTabelas; blnRecCustos: Boolean;  lblContReg: TLabel = nil): Boolean;
  var CalculaComposicaoCusto : TCalculaComposicaoCusto;
begin
  CalculaComposicaoCusto := TCalculaComposicaoCusto.Create;
  CalculaComposicaoCusto.FLocal := strLocal;
  If ModoRecalculo.TipoCalculoMargemPreven = tcmVenda Then
    CalculaComposicaoCusto.FTipAtu := 'P'
  Else
    CalculaComposicaoCusto.FTipAtu := 'M';
  CalculaComposicaoCusto.OrigemCalculo := tocCalcGeral;
  CalculaComposicaoCusto.FCodAbf := strCodAbf;
  CalculaComposicaoCusto.FlblContReg := lblContReg;
  CalculaComposicaoCusto.FStrCodTab := strCodTab;
  CalculaComposicaoCusto.FblnRecCustos := blnRecCustos;
  CalculaComposicaoCusto.pMontaEstruturaEmpresas;
  CalculaComposicaoCusto.pMarTabDetParaRecalculo;
  CalculaComposicaoCusto.pCarregaItens;
  CalculaComposicaoCusto.pCarregaAbreviacoesICMS;
  CalculaComposicaoCusto.pProcessaItens;
  CalculaComposicaoCusto.pAtualizaBancoDeDados(False);
  If ModoRecalculo.OpcTabelasReprocessa =  topctrTodas Then
  begin
    CalculaComposicaoCusto.pCarregaItensSemTabelaPrecoAtivo;
    CalculaComposicaoCusto.pProcessaItensSemTabelaPrecoAtivo;
    CalculaComposicaoCusto.pAtualizaBancoDeDados(True);
    CalculaComposicaoCusto.pMarTabDetParaRecalculo(True);
  End;

  pMensagemOk('Concluído!');
  Result := True;
end;



class function TCalculaComposicaoCusto.fCalculaAlteracaoCadEmp(strLocal: string;
  strCodEmp: String; ModoRecalculo: TOpcRecalculoTabelas): Boolean;
begin
  CalculaComposicaoCusto := TCalculaComposicaoCusto.Create;
  CalculaComposicaoCusto.FLocal := strLocal;
  CalculaComposicaoCusto.FCodEmp := strCodEmp;
  CalculaComposicaoCusto.OrigemCalculo := tocCadEmpresa;
  If ModoRecalculo.TipoCalculoMargemPreven = tcmVenda Then
    CalculaComposicaoCusto.FTipAtu := 'P'
  Else
    CalculaComposicaoCusto.FTipAtu := 'M';
  CalculaComposicaoCusto.pMontaEstruturaEmpresas;
  CalculaComposicaoCusto.pMarTabDetParaRecalculo;
  CalculaComposicaoCusto.pCarregaItens;
  CalculaComposicaoCusto.pCarregaAbreviacoesICMS;
  CalculaComposicaoCusto.pProcessaItens;
  CalculaComposicaoCusto.pAtualizaBancoDeDados(False);

  If ModoRecalculo.OpcTabelasReprocessa =  topctrTodas Then
  begin
    CalculaComposicaoCusto.pCarregaItensSemTabelaPrecoAtivo;
    CalculaComposicaoCusto.pProcessaItensSemTabelaPrecoAtivo;
    CalculaComposicaoCusto.pAtualizaBancoDeDados(True);
    CalculaComposicaoCusto.pMarTabDetParaRecalculo(True);
  End;

  pMensagemOk('Concluído!');
  Result := True;
end;




function TCalculaComposicaoCusto.fProcessaItemSemTabelaPrecoAtivo(cxProgresso: TCxProgressBar): Boolean;
var
   intRecIni, intRecFin: integer;
   strEmpresaPrincipal: String;
   strEmpresasProcessando_A_Processar: String;
begin
  Try
    cxProgresso.Properties.Max := qryItens.RecordCount;
    cdsEmpresasBkp.Data := cdsEmpresas.Data;
    While Not qryItens.Eof Do
    Begin
      intRecIni := qryItens.RecNo;
      intRecFin := fGetUltimaLinhaItemSemPrecoAtivo(qryItens.FieldByname('ITE_CODITE').AsString, qryItens.FieldByname('ITE_CODTAB').AsString);
      cdsEmpresas.First;
      qryItens.prior;
      qryItens.RecNo := intRecIni;
      while not cdsEmpresas.Eof Do
      Begin
        strEmpresaPrincipal :=  cdsEmpresas.FieldByname('EMP_CODEMP').ASString;
        strEmpresasProcessando_A_Processar := cdsEmpresas.FieldByname('EMP_UTIPRECO').AsString;
        pExecutaCalculoSemItemAtivo(strEmpresaPrincipal, strEmpresasProcessando_A_Processar, intRecIni, intRecFin);
        cdsEmpresas.Next;
      End;
      qryItens.RecNo := intRecFin;
      cxProgresso.Position := qryItens.RecNo;
      Application.ProcessMessages;
      qryItens.Next;
    End;
    Result := True;
  Except
    on E: Exception do
    begin
      pMensagensErro(e.message, '[TCalculaComposicaoCusto.fProcessaItem]');
      Result := False;
    End;
  End
End;

function TCalculaComposicaoCusto.fProcessaItem(
  cxProgresso: TCxProgressBar): Boolean;
var
   intRecIni, intRecFin: integer;
   strEmpresaPrincipal: String;
   strEmpresasProcessando_A_Processar: String;
begin
  Try
    cxProgresso.Properties.Max := qryItens.RecordCount;
    cdsEmpresasBkp.Data := cdsEmpresas.Data;
    While Not qryItens.Eof Do
    Begin
      intRecIni := qryItens.RecNo;
      intRecFin := fGetUltimaLinhaItem(qryItens.FieldByname('ITE_CODITE').AsString);
      cdsEmpresas.First;
      qryItens.prior;
      qryItens.RecNo := intRecIni;
      while not cdsEmpresas.Eof Do
      Begin
        strEmpresaPrincipal :=  cdsEmpresas.FieldByname('EMP_CODEMP').ASString;
        strEmpresasProcessando_A_Processar := cdsEmpresas.FieldByname('EMP_UTIPRECO').AsString;
        pExecutaCalculo(strEmpresaPrincipal, strEmpresasProcessando_A_Processar, intRecIni, intRecFin);
        cdsEmpresas.Next;
      End;
      cxProgresso.Position := cxProgresso.Position + 1;
      Application.ProcessMessages;
      qryItens.RecNo := intRecFin;
      qryItens.Next;
    End;
    Result := True;
  Except
    on E: Exception do
    begin
      pMensagensErro(e.message, '[TCalculaComposicaoCusto.fProcessaItem]');
      Result := False;
    End;
  End
end;

function TCalculaComposicaoCusto.fAtualizaBancoDeDados(cxProgresso: TCxProgressBar): Boolean;
begin
  try
    cxProgresso.Properties.Max := qryItens.RecordCount;
    pPreAltDefineVariaveisAltPre(fNow, FLocal, strLoginUsuarioLogado, VS_StrCodEmp, strAgrupadorPreAlt);
    cdsEmpresasBkp.Data := cdsEmpresas.Data;
    qryItens.First;
    While Not qryItens.Eof Do
    Begin
      pGeraScritp;
      If Not VS_blnPreAltViaTrigger Then
        fGravaPreAlt(qryItens.FieldByName('ITE_CODITE').AsString,
                     qryItens.FieldByName('ORI_ITE_PRECUS1').AsFloat,
                     qryItens.FieldByName('ITE_PRECUS1').AsFloat/qryItens.FieldByName('ITE_CNVCUS1').AsFloat,
                     qryItens.FieldByName('ORI_ITE_PREVEN1').AsFloat,
                     qryItens.FieldByName('ITE_PREVEN_CNV1').AsFloat,
                     qryItens.FieldByName('ORI_ITE_MARBRU1').AsFloat,
                     qryItens.FieldByName('ITE_MARBRU1').AsFloat,
                     qryItens.FieldByName('ORI_ITE_PREVEN2').AsFloat,
                     qryItens.FieldByName('ITE_PREVEN_CNV2').AsFloat,
                     qryItens.FieldByName('ORI_ITE_MARBRU2').AsFloat,
                     qryItens.FieldByName('ITE_MARBRU2').AsFloat,
                     qryItens.FieldByName('ORI_ITE_PREVEN3').AsFloat,
                     qryItens.FieldByName('ITE_PREVEN_CNV3').AsFloat,
                     qryItens.FieldByName('ORI_ITE_MARBRU3').AsFloat,
                     qryItens.FieldByName('ITE_MARBRU3').AsFloat,
                     qryItens.FieldByName('ORI_ITE_PREVEN4').AsFloat,
                     qryItens.FieldByName('ITE_PREVEN_CNV4').AsFloat,
                     qryItens.FieldByName('ORI_ITE_MARBRU4').AsFloat,
                     qryItens.FieldByName('ITE_MARBRU4').AsFloat,
                     qryItens.FieldByName('ORI_ITE_PREVEN5').AsFloat,
                     qryItens.FieldByName('ITE_PREVEN_CNV5').AsFloat,
                     qryItens.FieldByName('ORI_ITE_MARBRU5').AsFloat,
                     qryItens.FieldByName('ITE_MARBRU5').AsFloat,
                     qryItens.FieldByName('ORI_ITE_PREVEN6').AsFloat,
                     qryItens.FieldByName('ITE_PREVEN_CNV6').AsFloat,
                     qryItens.FieldByName('ORI_ITE_MARBRU6').AsFloat,
                     qryItens.FieldByName('ITE_MARBRU6').AsFloat,
                     qryItens.FieldByName('ORI_ITE_PREVEN7').AsFloat,
                     qryItens.FieldByName('ITE_PREVEN_CNV7').AsFloat,
                     qryItens.FieldByName('ORI_ITE_MARBRU7').AsFloat,
                     qryItens.FieldByName('ITE_MARBRU7').AsFloat,
                     qryItens.FieldByName('ITE_PRECOM').AsFloat,
                     qryItens.FieldByName('ITE_PRECOM').AsFloat,
                     FLocal,
                     nil,
                     qryItens.FieldByName('ITE_CODEMP').AsString,
                     strLoginUsuarioLogado);

      pExecutaScript;
      cxProgresso.Position := cxProgresso.Position + 1;
      Application.ProcessMessages;
      qryItens.Next;
    End;
    result := True;
    strAgrupadorPreAlt := '';
  Except
    on e: Exception do
    Begin
      pMensagensErro(e.message, '[TCalculaComposicaoCusto.fProcessaItem]');
      Result := False;
    End;
  End;
End;

function TCalculaComposicaoCusto.fAtualizaBancoDeDadosSemAtivo(cxProgresso: TCxProgressBar): Boolean;
begin
  try
    cxProgresso.Properties.Max := qryItens.RecordCount;
    cdsEmpresasBkp.Data := cdsEmpresas.Data;
    qryItens.First;
    While Not qryItens.Eof Do
    Begin
      pGeraScritp(True);
      If (qryItens.RecNo mod 10 ) = 0 Then
         pExecutaScript;
      cxProgresso.Position := qryItens.RecNo;
      Application.ProcessMessages;
      qryItens.Next;
    End;
    pExecutaScript;
    result := True;
  Except
    on e: Exception do
    Begin
      pMensagensErro(e.message, '[TCalculaComposicaoCusto.fAtualizaBancoDeDadosSemAtivo]');
      Result := False;
    End;
  End;
End;


function TCalculaComposicaoCusto.fGetUltimaLinhaItem(strCodIte: String): Integer;
var intPosIni: integer;
Begin
  intPosIni := qryItens.recNo;
  while not qryItens.Eof do
  begin
    if strCodIte <> qryItens.FieldByname('ITE_CODITE').AsString then
       Exit(qryItens.recNo -1);
    qryItens.Next;
  end;
  result := qryItens.RecNo;
  qryItens.RecNo := intPosIni;
End;


function TCalculaComposicaoCusto.fGetUltimaLinhaItemSemPrecoAtivo(strCodIte: String; strCodtab: String): Integer;
var intPosIni: integer;
Begin
  intPosIni := qryItens.recNo;
  while not qryItens.Eof do
  begin
    if strCodIte <> qryItens.FieldByname('ITE_CODITE').AsString then
       Exit(qryItens.recNo -1);

    If strCodtab <> qryItens.FieldByname('ITE_CODTAB').AsString Then
       Exit(qryItens.recNo -1);
    qryItens.Next;
  end;
  result := qryItens.RecNo;
  qryItens.RecNo := intPosIni;
End;


procedure TCalculaComposicaoCusto.pMarTabDetParaRecalculo(blnRevertProcessado: Boolean = False);
begin
  FQryCommand.SQl.Clear;
  If blnRevertProcessado Then
  Begin
    FQryCommand.SQl.Add('UPDATE TABDET SET ITE_PROCESSADO = 1;');
    FQryCommand.SQl.Add('UPDATE DETCUS SET DET_PROCESSADO = 0');
    FQryCommand.SQl.Add('    WHERE DET_SEQDET IN (SELECT AUTOINCREM FROM TABDET WHERE ITE_PROCESSADO = 1); ');

  End
  Else
  Begin
    FQryCommand.SQl.Add('UPDATE TABDET SET ITE_PROCESSADO = 0');
    FQryCommand.SQl.Add(' WHERE ITE_CODEMP IN('+fStringSQLLocateToStringSQLIN(cdsEmpresas.FieldByname('EMP_UTIPRECO').AsString) +')');
    If FStrCodTab <> '' then
      FQryCommand.SQl.Add(' AND ITE_CODTAB = "'+FStrCodTab+'"');
    If FCodAbf <> '' then
      FQryCommand.SQl.Add(' AND ITE_CODABF = "'+FCodAbf+'"');
      FQryCommand.SQl.Add(';');


    FQryCommand.SQl.Add('UPDATE DETCUS SET DET_PROCESSADO = 0');
    FQryCommand.SQl.Add('    WHERE DET_SEQDET IN (SELECT AUTOINCREM FROM TABDET WHERE ITE_PROCESSADO = 0); ');


  End;
  FQryCommand.ExecSQL

end;

procedure TCalculaComposicaoCusto.pMontaEstruturaEmpresas;
var strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT EMP_CODEMP, CAST("" AS CHAR(1))AS PREMAT, "" AS EMP_UTIPRECO, IF(EMP_CODEMP = "'+VS_StrCodEmp+ '", -1, 0) AS EMPPRI';
  strSQL := strSQL + '   FROM CADEMP ';
  If OrigemCalculo in [tocCadEmpresa, tocCalcGeral] then
    strSQL := strSQL + ' WHERE CADEMP.EMP_CODEMP = "'+FCodEmp+'"';
  strSQL := strSQL + ' ORDER BY EMPPRI, EMP_CODEMP ';

  cdsEmpresas := TZClient.Create(nil, strSQL);
  cdsEmpresas.fAbreClient(False, '[TCalculaComposicaoCusto.pMontaEstruturaEmpresas]');

  cdsEmpresas.First;
  while not cdsEmpresas.Eof Do
  Begin
    cdsEmpresas.Edit;
    cdsEmpresas.FieldByname('PREMAT').AsString := IIf(fPreMat(cdsEmpresas.FieldByName('EMP_CODEMP').AsString), 'S', 'N');
    cdsEmpresas.FieldByname('EMP_UTIPRECO').AsString := fRetEmpresasUsamPrecoMatriz(nil,
                                                                                    cdsEmpresas.FieldByName('EMP_CODEMP').AsString,
                                                                                    cdsEmpresas.FieldByName('EMP_CODEMP').AsString);
    cdsEmpresas.Post;
    cdsEmpresas.Next

  End;
end;


procedure TCalculaComposicaoCusto.pReiniciaPrecos;
var intTabela: integer;
begin
  for intTabela := 1 To 7 Do
  begin
    FPrecosPrincipal[intTabela].fltPreven := 0;
    FPrecosPrincipal[intTabela].fltMargem := 0;
    FPrecosPrincipal[intTabela].blnCalculado := False;
  End;
End;

function TCalculaComposicaoCusto.fValidaRegrasParaProcessar(intTabela: integer; strCodFor: String; strCodAbf: String; blnValidaCodAbf: Boolean = True): Boolean;
begin
 Result := true;
 If blnValidaCodAbf then
   If strCodAbf <> FCodAbf Then
     Exit(False);
 If VS_strTabPrc[intTabela] <> 'S' Then
   Exit(False);
 If strCodFor = '' then
   Exit(False);
End;


procedure TCalculaComposicaoCusto.pProcessaPadrao(TipoCalculo: TTipoCalculoMargemPreven; blnPrincipal: boolean; intTabela: integer; strCodFor: String; var fltPreven, fltIPIEntrada, fltIcmEnt, fltIcmSai, fltSubsti, fltMargem, fltPreCus: Double);
var strTabela: String;
    fltPreCusCNV: Double;
begin
  strTabela := IntToStr(intTabela);
  qryAbf.First;
  FEstadoFornecedor := qryItens.FieldByName('CID_ESTADO' + strTabela).AsString;
  qryAbf.First;
  If qryAbf.Locate('ABF_CODABF;ABF_ESTADO', VarArrayOf([qryItens.FieldByName('ITE_CODABF' + strTabela).AsString, FEstadoFornecedor]), []) Then
  Begin
    cdsEmpresasBkp.First;
    cdsEmpresasBkp.Locate('EMP_CODEMP', qryItens.FieldByName('ITE_CODITE').AsString, []);
    FAliquotaICMSSai        := qryItens.FieldByName('ITE_ICMSAI' + strTabela).AsFloat;
    fltIcmSai := FAliquotaICMSSai;
    FTipoAbfFornecedor      := qryItens.FieldByName('TIPABF' + strTabela).AsString;
    FAliBaseRetICMSForne    := qryAbf.FieldByName('ABF_ALQRET' + FTipoAbfFornecedor).AsFloat;
    FCSTFornecedor          := qryAbf.FieldByName('ABF_CODSIT' + FTipoAbfFornecedor).AsString;
    FBaseIcmFornecedor      := qryAbf.FieldByName('ABF_BASICM' + FTipoAbfFornecedor).AsFloat;
    FAliquotaBaseFornecedor := qryAbf.FieldByName('ABF_ALQICM' + FTipoAbfFornecedor).AsFloat;
    FBaseRetICMSFornecedor  := qryAbf.FieldByName('ABF_BASRET' + FTipoAbfFornecedor).AsFloat;
    FAlqFundoCombatePobreza := qryAbf.FieldByName('ABF_ALQFCP' + FTipoAbfFornecedor).AsFloat;
    FIVAFornecedor          := qryAbf.FieldByName('ABF_IVA_ST' + FTipoAbfFornecedor).AsFloat;
    FintBSTXML              := qryItens.FieldByName('FOR_BSTXML' + strTabela).AsInteger;
    FComLiq                 := qryItens.FieldByName('ITE_COMLIQ').AsFloat;
    strCodFor               := qryItens.FieldByName('ITE_CODFOR' + strTabela).AsString;
    fltIPIEntrada           := qryItens.FieldByName('ITE_IPIENT' + strTabela).AsFloat;
    fProcessaVal(strCodFor, FCodAbf, fltIPIEntrada);

    pDefineValorImpostos(fltIcmEnt, fltIcmSai, fltSubsti);
    fltPreCus := fRetPrecoCusto(intTabela , qryItens, fltIcmEnt, fltSubsti);

    fltPreCusCNV := fltPreCus / qryItens.FieldByName('ITE_CNVCUS' + strTabela).AsFloat;

    pDefineVariaveisIniciaisPrecoVendaOuMargem(False, intTabela, blnPrincipal, fltMargem, fltPreven);

    If TipoCalculo = tcmMargem then
      fltPreven := fltPreven * qryItens.FieldByName('ITE_CNVCUS' + strTabela).AsFloat;

    pCalulaPrecoDeVendaOuMargem(TipoCalculo, qryItens, intTabela, fltPreCus, fltIcmSai, fltMargem, fltPreven);
    qryItens.FieldByName('ITE_PRECUS' + strTabela).AsFloat := fltPreCus;
    If Not FblnRecCustos Then
      qryItens.FieldByName('ITE_SUBFED' + strTabela).AsFloat := qryItens.FieldByName('TAB_ITE_SUBFED' + strTabela).AsFloat;



    qryItens.FieldByName('ITE_ICMSAI' + strTabela).AsFloat := fltIcmSai;
    qryItens.FieldByName('ITE_ICMENT' + strTabela).AsFloat := fltIcmEnt;
    qryItens.FieldByName('ITE_SUBSTI' + strTabela).AsFloat := fltSubsti;
    qryItens.FieldByName('ITE_PREVEN' + strTabela).AsFloat := fltPreven;
    qryItens.FieldByName('ITE_MARBRU' + strTabela).AsFloat := fltMargem;

    qryItens.FieldByName('ITE_PRECUS_CNV' + strTabela).AsFloat := fltPreCusCNV;
    qryItens.FieldByName('ITE_PREVEN_CNV' + strTabela).AsFloat := fltPreven/qryItens.FieldByName('ITE_CNVCUS' + strTabela).AsFloat;;
    qryItens.FieldByName('ITE_OUTVAL_CNV' + strTabela).AsFloat := qryItens.FieldByName('ITE_OUTVAL' + strTabela).AsFloat/qryItens.FieldByName('ITE_CNVCUS' + strTabela).AsFloat;

    qryItens.FieldByName('PROCESSADO').AsInteger := 1;
    pSePrincipalAlimentaArray(intTabela, blnPrincipal, fltPreven, fltMargem);

  End;
End;

procedure TCalculaComposicaoCusto.pProcessaCadEmp(strCodAbf: String; TipoCalculo: TTipoCalculoMargemPreven; blnPrincipal: boolean; intTabela: integer; strCodFor: String; var fltPreven, fltIPIEntrada, fltIcmEnt, fltIcmSai, fltSubsti, fltMargem, fltPreCus: Double);
var strTabela: String;
    fltPreCusCNV: Double;
begin
  strTabela := IntToStr(intTabela);
  qryAbf.First;
  FEstadoFornecedor := qryItens.FieldByName('CID_ESTADO'+strTabela).AsString;

  If qryAbf.Locate('ABF_CODABF;ABF_ESTADO', VarArrayOf([qryItens.FieldByName('ITE_CODABF' + strTabela).AsString, FEstadoFornecedor]), []) Then
  Begin
    cdsEmpresasBkp.First;
    cdsEmpresasBkp.Locate('EMP_CODEMP', qryItens.FieldByName('ITE_CODITE').AsString, []);
    FAliquotaICMSSai        := qryItens.FieldByName('ITE_ICMSAI' + strTabela).AsFloat;
    fltIcmSai := FAliquotaICMSSai;
    FTipoAbfFornecedor      := qryItens.FieldByName('TIPABF' + strTabela).AsString;
    FAliBaseRetICMSForne    := qryAbf.FieldByName('ABF_ALQRET' + FTipoAbfFornecedor).AsFloat;
    FCSTFornecedor          := qryAbf.FieldByName('ABF_CODSIT' + FTipoAbfFornecedor).AsString;
    FBaseIcmFornecedor      := qryAbf.FieldByName('ABF_BASICM' + FTipoAbfFornecedor).AsFloat;
    FAliquotaBaseFornecedor := qryAbf.FieldByName('ABF_ALQICM' + FTipoAbfFornecedor).AsFloat;
    FBaseRetICMSFornecedor  := qryAbf.FieldByName('ABF_BASRET' + FTipoAbfFornecedor).AsFloat;
    FAlqFundoCombatePobreza := qryAbf.FieldByName('ABF_ALQFCP' + FTipoAbfFornecedor).AsFloat;
    FIVAFornecedor          := qryAbf.FieldByName('ABF_IVA_ST' + FTipoAbfFornecedor).AsFloat;
    FintBSTXML              := qryItens.FieldByName('FOR_BSTXML' + strTabela).AsInteger;
    FComLiq                 := qryItens.FieldByName('ITE_COMLIQ').AsFloat;
    strCodFor               := qryItens.FieldByName('ITE_CODFOR' + strTabela).AsString;
    fltIPIEntrada           := qryItens.FieldByName('ITE_IPIENT' + strTabela).AsFloat;
    fProcessaVal(strCodFor, FCodAbf, fltIPIEntrada);


    pDefineValorImpostos(fltIcmEnt, fltIcmSai, fltSubsti);

    fltPreCus := fRetPrecoCusto(intTabela , qryItens, fltIcmEnt, fltSubsti);
    fltPreCusCNV := fltPreCus / qryItens.FieldByName('ITE_CNVCUS' + strTabela).AsFloat;

    pDefineVariaveisIniciaisPrecoVendaOuMargem(False, intTabela, blnPrincipal, fltMargem, fltPreven);
    If TipoCalculo = tcmMargem then
      fltPreven := fltPreven * qryItens.FieldByName('ITE_CNVCUS' + strTabela).AsFloat;

    pCalulaPrecoDeVendaOuMargem(TipoCalculo, qryItens, intTabela, fltPreCus, fltIcmSai, fltMargem, fltPreven);

    If Not FblnRecCustos Then
      qryItens.FieldByName('ITE_SUBFED' + strTabela).AsFloat := qryItens.FieldByName('TAB_ITE_SUBFED' + strTabela).AsFloat;

    qryItens.FieldByName('ITE_PRECUS' + strTabela).AsFloat := fltPreCus;
    qryItens.FieldByName('ITE_ICMSAI' + strTabela).AsFloat := fltIcmSai;
    qryItens.FieldByName('ITE_ICMENT' + strTabela).AsFloat := fltIcmEnt;
    qryItens.FieldByName('ITE_SUBSTI' + strTabela).AsFloat := fltSubsti;
    qryItens.FieldByName('ITE_PREVEN' + strTabela).AsFloat := fltPreven;
    qryItens.FieldByName('ITE_MARBRU' + strTabela).AsFloat := fltMargem;

    qryItens.FieldByName('ITE_PRECUS_CNV' + strTabela).AsFloat := fltPreCusCNV;
    qryItens.FieldByName('ITE_PREVEN_CNV' + strTabela).AsFloat := fltPreven/qryItens.FieldByName('ITE_CNVCUS' + strTabela).AsFloat;
    qryItens.FieldByName('ITE_OUTVAL_CNV' + strTabela).AsFloat := qryItens.FieldByName('ITE_OUTVAL' + strTabela).AsFloat/qryItens.FieldByName('ITE_CNVCUS' + strTabela).AsFloat;

    qryItens.FieldByName('PROCESSADO').AsInteger := 1;
    pSePrincipalAlimentaArray(intTabela, blnPrincipal, fltPreven, fltMargem);
  End;
End;


procedure TCalculaComposicaoCusto.pProcessaCadEmpSemItemAtivo(strCodAbf: String; TipoCalculo: TTipoCalculoMargemPreven; blnPrincipal: boolean; intTabela: integer; strCodFor: String; var fltPreven, fltIPIEntrada, fltIcmEnt, fltIcmSai, fltSubsti, fltMargem, fltPreCus: Double);
var strTabela: String;
begin
  strTabela := IntToStr(intTabela);
  FEstadoFornecedor := qryItens.FieldByName('CID_ESTADO').AsString;
  qryAbf.First;
  If qryAbf.Locate('ABF_CODABF;ABF_ESTADO', VarArrayOf([qryItens.FieldByName('ITE_CODABF').AsString, FEstadoFornecedor]), []) Then
  Begin
    cdsEmpresasBkp.First;
    cdsEmpresasBkp.Locate('EMP_CODEMP', qryItens.FieldByName('ITE_CODITE').AsString, []);
//    FAliquotaICMSSai        := qryItens.FieldByName('ITE_ICMSAI').AsFloat;
    FImpFed := qryItens.FieldByName('ITE_IMPFED').AsFloat;
    FImpSub := qryItens.FieldByName('ITE_SUBFED').AsFloat;
    FDesOpe := qryItens.FieldByName('ITE_DESOPE').AsFloat;
    FOutVal := qryItens.FieldByName('ITE_OUTVAL').AsFloat;
    FAliquotaICMSSai := qryItens.FieldByName('ITE_ICMSAI').AsFloat;
    fltIcmSai :=  FAliquotaICMSSai;

    FTipoAbfFornecedor      := qryItens.FieldByName('TIPABF').AsString;
    FAliBaseRetICMSForne    := qryAbf.FieldByName('ABF_ALQRET' + FTipoAbfFornecedor).AsFloat;
    FCSTFornecedor          := qryAbf.FieldByName('ABF_CODSIT' + FTipoAbfFornecedor).AsString;
    FBaseIcmFornecedor      := qryAbf.FieldByName('ABF_BASICM' + FTipoAbfFornecedor).AsFloat;
    FAliquotaBaseFornecedor := qryAbf.FieldByName('ABF_ALQICM' + FTipoAbfFornecedor).AsFloat;
    FBaseRetICMSFornecedor  := qryAbf.FieldByName('ABF_BASRET' + FTipoAbfFornecedor).AsFloat;
    FAlqFundoCombatePobreza := qryAbf.FieldByName('ABF_ALQFCP' + FTipoAbfFornecedor).AsFloat;
    FIVAFornecedor          := qryAbf.FieldByName('ABF_IVA_ST' + FTipoAbfFornecedor).AsFloat;
    FintBSTXML              := qryItens.FieldByName('FOR_BSTXML').AsInteger;
    FComLiq                 := qryItens.FieldByName('ITE_COMLIQ').AsFloat;
    strCodFor               := qryItens.FieldByName('ITE_CODFOR').AsString;
    fltIPIEntrada           := qryItens.FieldByName('ITE_IPIENT').AsFloat;
    fProcessaVal(strCodFor, FCodAbf, fltIPIEntrada);

    pDefineValorImpostos(fltIcmEnt, fltIcmSai, fltSubsti);

    fltPreCus := fRetPrecoCustoSemItemAtivo(intTabela , qryItens, fltIcmEnt, fltSubsti);

    pDefineVariaveisIniciaisPrecoVendaOuMargem(True, intTabela, blnPrincipal, fltMargem, fltPreven);

    pCalulaPrecoDeVendaOuMargem(TipoCalculo, qryItens, intTabela, fltPreCus, fltIcmSai, fltMargem, fltPreven, True);
    If Not FblnRecCustos Then
      qryItens.FieldByName('ITE_SUBFED').AsFloat := qryItens.FieldByName('TAB_ITE_SUBFED').AsFloat;

    qryItens.FieldByName('ITE_PRECUS').AsFloat := fltPreCus;
    qryItens.FieldByName('ITE_ICMSAI').AsFloat := fltIcmSai;
    qryItens.FieldByName('ITE_ICMENT').AsFloat := fltIcmEnt;
    qryItens.FieldByName('ITE_SUBSTI').AsFloat := fltSubsti;

    qryItens.FieldByName('ITE_PREVEN').AsFloat := fltPreven;
    qryItens.FieldByName('ITE_MARBRU').AsFloat := fltMargem;

    qryItens.FieldByName('ITE_PRECUS_CNV').AsFloat := fltPreCus/qryItens.FieldByName('ITE_CNVCUS').AsFloat;
    qryItens.FieldByName('ITE_PREVEN_CNV').AsFloat := fltPreven/qryItens.FieldByName('ITE_CNVCUS').AsFloat;;
    qryItens.FieldByName('ITE_OUTVAL_CNV').AsFloat := qryItens.FieldByName('ITE_OUTVAL').AsFloat/qryItens.FieldByName('ITE_CNVCUS').AsFloat;


    qryItens.FieldByName('PROCESSADO').AsInteger := 1;
    pSePrincipalAlimentaArray(intTabela, blnPrincipal, fltPreven, fltMargem);

  End;
End;



procedure TCalculaComposicaoCusto.pProcessaCalculo(blnPrincipal: Boolean; TipoCalculo: TTipoCalculoMargemPreven);
var intTabela: integer;
    fltIcmEnt, fltIcmSai, fltSubsti, fltMargem, fltPreven: Double;
    strTabela: String;
    strCodFor: String;
    fltIPIEntrada: Double;
    fltPreCus: Double;
begin
  If blnPrincipal Then
    pReiniciaPrecos;
  qryItens.Edit;
  for intTabela := 1 To 7 Do
  begin
    strTabela := INtToStr(intTabela);
    If fValidaRegrasParaProcessar(intTabela, qryItens.FieldByName('ITE_CODFOR' + strTabela).AsString, qryItens.FieldByName('ITE_CODABF' + strTabela).AsString, FCodAbf <> '')  then
    begin
      FImpFed := qryItens.FieldByName('ITE_IMPFED' + strTabela).AsFloat;
      FImpSub := qryItens.FieldByName('ITE_SUBFED' + strTabela).AsFloat;
      FDesOpe := qryItens.FieldByName('ITE_DESOPE' + strTabela).AsFloat;
      FOutVal := qryItens.FieldByName('ITE_OUTVAL' + strTabela).AsFloat;
      FAliquotaICMSSai := qryItens.FieldByName('ITE_ICMSAI' + strTabela).AsFloat;
      fltIcmSai := FAliquotaICMSSai;
      case OrigemCalculo of
        tocPadrao,
        tocCalcGeral: pProcessaPadrao(TipoCalculo, blnPrincipal, intTabela, strCodFor, fltPreven, fltIPIEntrada, fltIcmEnt, fltIcmSai, fltSubsti, fltMargem, fltPreCus);
        tocCadEmpresa: pProcessaCadEmp(qryItens.FieldByName('ITE_CODABF' + strTabela).AsString, TipoCalculo, blnPrincipal, intTabela, strCodFor, fltPreven, fltIPIEntrada, fltIcmEnt, fltIcmSai, fltSubsti, fltMargem, fltPreCus);
      End;
    End;
  End;
  qryItens.Post;
End;

procedure TCalculaComposicaoCusto.pProcessaCalculoSemItemAtivo(blnPrincipal: Boolean; TipoCalculo: TTipoCalculoMargemPreven);
var intTabela: integer;
    fltIcmEnt, fltIcmSai, fltSubsti, fltMargem, fltPreven: Double;
    strTabela: String;
    strCodFor: String;
    fltIPIEntrada: Double;
    fltPreCus: Double;
begin
  If blnPrincipal Then
    pReiniciaPrecos;
  qryItens.Edit;
  intTabela := fRetPrimeiraTabPrecoAtiva;
  If fValidaRegrasParaProcessar(intTabela, qryItens.FieldByName('ITE_CODFOR' + strTabela).AsString,
                                qryItens.FieldByName('ITE_CODABF' + strTabela).AsString,
                                FCodAbf <> '')  then
    pProcessaCadEmpSemItemAtivo(qryItens.FieldByName('ITE_CODABF' + strTabela).AsString, TipoCalculo, blnPrincipal, intTabela, strCodFor, fltPreven, fltIPIEntrada, fltIcmEnt, fltIcmSai, fltSubsti, fltMargem, fltPreCus);
  qryItens.Post;
End;

procedure TCalculaComposicaoCusto.pDefineVariaveisIniciaisPrecoVendaOuMargem(blnSemItemAtivo: Boolean; intTabela: Integer; blnPrincipal: Boolean; var fltMargem, fltPreven: Double);
begin
  If blnPrincipal Then
  Begin
    If blnSemItemAtivo then
    Begin
      fltPreven := qryItens.FieldByName('ITE_PREVEN').AsFloat;
      fltMargem := qryItens.FieldByName('ITE_MARBRU').AsFloat;
    End
    Else
    Begin
      fltPreven := qryItens.FieldByName('ITE_PREVE' + IntToStr(intTabela)).AsFloat;
      fltMargem := qryItens.FieldByName('ITE_MARBR' + IntToStr(intTabela)).AsFloat;
    End;
  End
  Else
  Begin
    fltPreven := FPrecosPrincipal[intTabela].fltPreven;
    fltMargem := FPrecosPrincipal[intTabela].fltMargem;
  End
End;

procedure TCalculaComposicaoCusto.pSePrincipalAlimentaArray(intTabela: Integer; blnPrincipal: Boolean; fltPreven, fltMargem: Double);
begin
  If blnPrincipal Then
  begin
    FPrecosPrincipal[intTabela].fltPreven := fltPreven;
    FPrecosPrincipal[intTabela].fltMargem := fltMargem;
    FPrecosPrincipal[intTabela].blnCalculado := true;
  End;
End;


procedure TCalculaComposicaoCusto.pExecutaCalculo(strEmpresaPrincipal, strEmpresasProcessando_A_Processar: String; intRecIni, intRecFin: Integer);
  var blnPrincipalProcessado: Boolean;
      TipoCalculoMargemPreven : TTipoCalculoMargemPreven;
begin
  qryItens.RecNo := intRecIni;
  TipoCalculoMargemPreven := IIf(FTipAtu = 'P', tcmVenda, tcmMargem);
  blnPrincipalProcessado := False;
  While (not (qryItens.RecNo > intRecFin)) And (Not qryItens.Eof)  do
  begin
    If qryItens.FieldByName('ITE_CODEMP').AsString = strEmpresaPrincipal then
    begin
      If qryItens.FieldByName('PROCESSADO').AsInteger = 1 Then
        break;
      TipoCalculoMargemPreven := IIf(FTipAtu = 'P', tcmVenda, tcmMargem);
      pProcessaCalculo(True, TipoCalculoMargemPreven);
      qryItens.RecNo := intRecIni;
      blnPrincipalProcessado := True;
      break;
    End;
    qryItens.Next;
  End;


  If blnPrincipalProcessado Then
    pProcessaFiliais(False, strEmpresasProcessando_A_Processar,
                     IIf(TipoCalculoMargemPreven = tcmMargem, tcmMargem, IIf(TipoCalculoMargemPreven = tcmMargem, tcmVenda, tcmMargem)),
                     intRecIni, intRecFin);
End;

procedure TCalculaComposicaoCusto.pExecutaCalculoSemItemAtivo(strEmpresaPrincipal, strEmpresasProcessando_A_Processar: String; intRecIni, intRecFin: Integer);
  var blnPrincipalProcessado: Boolean;
      TipoCalculoMargemPreven : TTipoCalculoMargemPreven;
begin
  qryItens.RecNo := intRecIni;
  TipoCalculoMargemPreven := IIf(FTipAtu = 'P', tcmVenda, tcmMargem);
  blnPrincipalProcessado := False;
  While (not (qryItens.RecNo > intRecFin)) And (Not qryItens.Eof)  do
  begin
    If qryItens.FieldByName('ITE_CODEMP').AsString = strEmpresaPrincipal then
    begin
      If qryItens.FieldByName('PROCESSADO').AsInteger = 1 Then
        break;
      TipoCalculoMargemPreven := IIf(FTipAtu = 'P', tcmVenda, tcmMargem);
      pProcessaCalculoSemItemAtivo(True, TipoCalculoMargemPreven);
      qryItens.RecNo := intRecIni;
      blnPrincipalProcessado := True;
      break;
    End;
    qryItens.Next;
  End;


  If blnPrincipalProcessado Then
    pProcessaFiliais(True, strEmpresasProcessando_A_Processar,
                     IIf(TipoCalculoMargemPreven = tcmMargem, tcmMargem, IIf(TipoCalculoMargemPreven = tcmMargem, tcmVenda, tcmMargem)),
                     intRecIni, intRecFin);
end;

procedure TCalculaComposicaoCusto.pProcessaFiliais(blnSemPrecoAtivo: Boolean; strEmpresasProcessando_A_Processar: String; TipoCalculoMargemPreven : TTipoCalculoMargemPreven; intRecIni, intRecFin: Integer);
begin
  qryItens.RecNo := intRecIni;
  While  (not (qryItens.RecNo > intRecFin)) And (Not qryItens.Eof) do
  Begin
    If qryItens.FieldByName('PROCESSADO').AsInteger = 1 Then
    begin
      qryItens.Next;
      continue;
    End;

    If Pos(qryItens.FieldByName('ITE_CODEMP').AsString, strEmpresasProcessando_A_Processar) = 0 Then
    begin
      qryItens.Next;
      continue;
    End;
    IF blnSemPrecoAtivo Then
      pProcessaCalculoSemItemAtivo(False, TipoCalculoMargemPreven)
    Else
      pProcessaCalculo(False, TipoCalculoMargemPreven);
    qryItens.Next;
  End;
end;

procedure TCalculaComposicaoCusto.pExecutaScript;
begin
    FQryCommand.SQL.Text := FScriptIteger.Text;
    If FQryCommand.SQL.Text <> '' Then
      FQryCommand.ExecSQL;

    FQryCommand.SQL.Text := FScriptTabDet.Text;
    If FQryCommand.SQL.Text <> '' Then
      FQryCommand.ExecSQL;

    FScriptIteger.Text := '';
    FScriptTabDet.Text := '';
End;

function TCalculaComposicaoCusto.fTrataFloatString(strValor: String): String;
begin
  result := AnsiReplaceStr(AnsiReplaceStr(strValor, '.', ''), ',', '.');
  If fEmptyStr(result) Then
    Result := '0';
end;


procedure TCalculaComposicaoCusto.pGeraScriptIteger;
var strConteudo: String;
    intTabela: integer;
    strTabela: String;
Begin
  strConteudo := '';
  for intTabela := 1 To 7 do
  begin
    strTabela := intToStr(intTabela);
    If fValidaRegrasParaProcessar(intTabela, qryItens.FieldByName('ITE_CODFOR' + strTabela).AsString, qryItens.FieldByName('ITE_CODABF' + strTabela).AsString, FCodAbf <> '') then
    begin
      If intPrimeiraTabPrecoAtiva =  intTabela Then
      begin
        strConteudo := strConteudo + ' ITE_ICMENT = ' + fTrataFloatString(qryItens.FieldByName('ITE_ICMENT' + strTabela).AsString) + ', ';
        strConteudo := strConteudo + ' ITE_SUBSTI = ' + fTrataFloatString(qryItens.FieldByName('ITE_SUBSTI' + strTabela).AsString) + ',';
        strConteudo := strConteudo + ' ITE_PRECUS = ' + fTrataFloatString(qryItens.FieldByName('ITE_PRECUS_CNV' + strTabela).AsString) + ',';
        strConteudo := strConteudo + ' ITE_PRECOM = ' + fTrataFloatString(qryItens.FieldByName('ITE_PRECOM' + strTabela).AsString) + ',';

        strConteudo := strConteudo + ' ITE_DESF01 = ' + fTrataFloatString(qryItens.FieldByName('ITE_DESF01' + strTabela).AsString) + ',';
        strConteudo := strConteudo + ' ITE_DESF02 = ' + fTrataFloatString(qryItens.FieldByName('ITE_DESF02' + strTabela).AsString) + ',';
        strConteudo := strConteudo + ' ITE_DESF03 = ' + fTrataFloatString(qryItens.FieldByName('ITE_DESF03' + strTabela).AsString) + ',';
        strConteudo := strConteudo + ' ITE_DESF04 = ' + fTrataFloatString(qryItens.FieldByName('ITE_DESF04' + strTabela).AsString) + ',';
        strConteudo := strConteudo + ' ITE_DESF05 = ' + fTrataFloatString(qryItens.FieldByName('ITE_DESF05' + strTabela).AsString) + ',';
        strConteudo := strConteudo + ' ITE_DESF06 = ' + fTrataFloatString(qryItens.FieldByName('ITE_DESF06' + strTabela).AsString) + ',';
        strConteudo := strConteudo + ' ITE_ACRFIN = ' + fTrataFloatString(qryItens.FieldByName('ITE_ACRFIN' + strTabela).AsString) + ',';
        strConteudo := strConteudo + ' ITE_IPIENT = ' + fTrataFloatString(qryItens.FieldByName('ITE_IPIENT' + strTabela).AsString) + ',';
        strConteudo := strConteudo + ' ITE_PRECOM = ' + fTrataFloatString(qryItens.FieldByName('ITE_PRECOM' + strTabela).AsString) + ',';

        strConteudo := strConteudo + ' ITE_SUBFED = ' + fTrataFloatString(qryItens.FieldByName('ITE_SUBFED' + strTabela).AsString) + ', ';
        strConteudo := strConteudo + ' ITE_IMPFED = ' + fTrataFloatString(qryItens.FieldByName('ITE_IMPFED' + strTabela).AsString) + ', ';
        strConteudo := strConteudo + ' ITE_ICMSAI = ' + fTrataFloatString(qryItens.FieldByName('ITE_ICMSAI' + strTabela).AsString) + ', ';
        strConteudo := strConteudo + ' ITE_DESOPE = ' + fTrataFloatString(qryItens.FieldByName('ITE_DESOPE' + strTabela).AsString) + ', ';
        strConteudo := strConteudo + ' ITE_OUTVAL = ' + fTrataFloatString(qryItens.FieldByName('ITE_OUTVAL_CNV' + strTabela).AsString);

      End;
      strConteudo := strConteudo + IIf(strConteudo = '', '', ',') + ' ITE_PREVE' + IntToStr(intTabela) + ' = ' + fTrataFloatString(qryItens.FieldByName('ITE_PREVEN_CNV' + strTabela).AsString);
      strConteudo := strConteudo + ' ,ITE_MARBR' + IntToStr(intTabela) + ' = ' +  fTrataFloatString(qryItens.FieldByName('ITE_MARBRU' + strTabela).AsString);
    End;
  end;
  If strConteudo <> '' Then
  begin
    strConteudo := strConteudo + ' WHERE ITE_CODITE = "' +qryItens.FieldByName('ITE_CODITE').AsString+ '"';
    strConteudo := strConteudo + '   AND ITE_CODEMP = "' +qryItens.FieldByName('ITE_CODEMP').AsString+ '";';
    FScriptIteger.Add('UPDATE ITEGER SET ' +  strConteudo);
  End;
End;

procedure TCalculaComposicaoCusto.pGeraScriptTabDet();
var strConteudo: String;
    intTabela: integer;
    strTabela: String;
Begin
  strConteudo := '';
  for intTabela := 1 To 7 do
  begin
    strTabela := intToStr(intTabela);
    If fValidaRegrasParaProcessar(intTabela, qryItens.FieldByName('ITE_CODFOR' + strTabela).AsString, qryItens.FieldByName('ITE_CODABF' + strTabela).AsString, FCodAbf <> '')  then
    Begin

      If fAlteraTabDet(qryItens.FieldByName('INCDET' + IntToStr(intTabela)).AsString) Then
      Begin
        strConteudo := '';

        strConteudo := strConteudo + 'REPLACE INTO DETCUS (DET_SEQDET, DET_TABELA,  DET_ICMSAI, DET_DESOPE, DET_OUTVAL, DET_MARBRU, DET_PREVEN, DET_PROCESSADO) VALUES (';
        strConteudo := strConteudo +  '"' + (qryItens.FieldByName('INCDET' + IntToStr(intTabela)).AsString) + '",';
        strConteudo := strConteudo +  strTabela + ',';
        strConteudo := strConteudo +  fTrataFloatString(qryItens.FieldByName('ITE_ICMSAI' + strTabela).AsString) + ', ';
        strConteudo := strConteudo +  fTrataFloatString(qryItens.FieldByName('ITE_DESOPE' + strTabela).AsString) + ', ';
        strConteudo := strConteudo +  fTrataFloatString(qryItens.FieldByName('ITE_OUTVAL' + strTabela).AsString) + ', ';
        strConteudo := strConteudo +  fTrataFloatString(qryItens.FieldByName('ITE_MARBRU' + strTabela).AsString) + ', ';
        strConteudo := strConteudo +  fTrataFloatString(qryItens.FieldByName('ITE_PREVEN' + strTabela).AsString) + ', ';
        strConteudo := strConteudo +  '1);';
        FScriptTabDet.Add(strConteudo);


        strConteudo   := '';
        strTabela := intToStr(intTabela);
        strConteudo := 'UPDATE TABDET SET ';
        strConteudo := strConteudo + ' ITE_PROCESSADO = IF((SELECT COUNT(1) FROM DETCUS WHERE DETCUS.DET_SEQDET = "'+qryItens.FieldByName('INCDET' + IntToStr(intTabela)).AsString+'" AND DET_PROCESSADO  = 0) = 0, 1, 0),';
        If intPrimeiraTabPrecoAtiva =  intTabela Then
        begin
          strConteudo := strConteudo + ' ITE_PREVEN = ' + fTrataFloatString(qryItens.FieldByName('ITE_PREVEN' + strTabela).AsString) + ', ';
          strConteudo := strConteudo + ' ITE_MARBRU = ' + fTrataFloatString(qryItens.FieldByName('ITE_MARBRU' + strTabela).AsString) + ', ';
        End;
        strConteudo := strConteudo + ' ITE_ICMENT = ' + fTrataFloatString(qryItens.FieldByName('ITE_ICMENT' + strTabela).AsString) + ', ';
        strConteudo := strConteudo + ' ITE_SUBSTI = ' + fTrataFloatString(qryItens.FieldByName('ITE_SUBSTI' + strTabela).AsString) + ', ';
        strConteudo := strConteudo + ' ITE_PRECOM = ' + fTrataFloatString(qryItens.FieldByName('ITE_PRECOM' + strTabela).AsString) + ', ';
        strConteudo := strConteudo + ' ITE_PRECUS = ' + fTrataFloatString(qryItens.FieldByName('ITE_PRECUS' + strTabela).AsString) + ', ';
        strConteudo := strConteudo + ' ITE_SUBFED = ' + fTrataFloatString(qryItens.FieldByName('ITE_SUBFED' + strTabela).AsString) + ', ';
        strConteudo := strConteudo + ' ITE_IMPFED = ' + fTrataFloatString(qryItens.FieldByName('ITE_IMPFED' + strTabela).AsString) + ', ';
        strConteudo := strConteudo + ' ITE_ICMSAI = ' + fTrataFloatString(qryItens.FieldByName('ITE_ICMSAI' + strTabela).AsString) + ', ';
        strConteudo := strConteudo + ' ITE_DESOPE = ' + fTrataFloatString(qryItens.FieldByName('ITE_DESOPE' + strTabela).AsString) + ', ';
        strConteudo := strConteudo + ' ITE_OUTVAL = ' + fTrataFloatString(qryItens.FieldByName('ITE_OUTVAL' + strTabela).AsString) + ' ';
        strConteudo := strConteudo + ' WHERE AUTOINCREM = "' +qryItens.FieldByName('INCDET' + IntToStr(intTabela)).AsString+ '";';
        stlListaTabDetProcessada.Add(qryItens.FieldByName('INCDET' + IntToStr(intTabela)).AsString + strTabela);
        FScriptTabDet.Add(strConteudo);

      End;
    End;
  End;
End;

procedure TCalculaComposicaoCusto.pGeraScriptTabDetSemAtivo();
var strConteudo: String;

Begin
    strConteudo := '';


    strConteudo := '';

    strConteudo := strConteudo + 'REPLACE INTO DETCUS (DET_SEQDET, DET_TABELA,  DET_ICMSAI, DET_DESOPE, DET_OUTVAL, DET_MARBRU, DET_PREVEN, DET_PROCESSADO) VALUES (';
    strConteudo := strConteudo +  QuotedStr(qryItens.FieldByName('INCDET').AsString) + ',';
    strConteudo := strConteudo +  qryItens.FieldByName('TABELA').AsString + ',';
    strConteudo := strConteudo +  fTrataFloatString(qryItens.FieldByName('ITE_ICMSAI').AsString) + ',';
    strConteudo := strConteudo +  fTrataFloatString(qryItens.FieldByName('ITE_DESOPE').AsString) + ',';
    strConteudo := strConteudo +  fTrataFloatString(qryItens.FieldByName('ITE_OUTVAL').AsString) + ',';
    strConteudo := strConteudo +  fTrataFloatString(qryItens.FieldByName('ITE_MARBRU').AsString) + ',';
    strConteudo := strConteudo +  fTrataFloatString(qryItens.FieldByName('ITE_PREVEN').AsString) + ',';
    strConteudo := strConteudo +  '1);';
    FScriptTabDet.Add(strConteudo);


    strConteudo := 'UPDATE TABDET SET ';
    strConteudo := strConteudo + ' ITE_PROCESSADO = IF((SELECT COUNT(1) FROM DETCUS WHERE DETCUS.DET_SEQDET = "'+qryItens.FieldByName('INCDET').AsString+'" AND DET_PROCESSADO  = 0) = 0, 1, 0),';

    If qryItens.FieldByName('TABELA').AsInteger = intPrimeiraTabPrecoAtiva Then
    Begin
      strConteudo := strConteudo + ' ITE_PREVEN = ' + fTrataFloatString(qryItens.FieldByName('ITE_PREVEN').AsString) + ', ';
      strConteudo := strConteudo + ' ITE_MARBRU = ' + fTrataFloatString(qryItens.FieldByName('ITE_MARBRU').AsString) + ', ';
    End;

    strConteudo := strConteudo + ' ITE_ICMENT = ' + fTrataFloatString(qryItens.FieldByName('ITE_ICMENT').AsString) + ', ';
    strConteudo := strConteudo + ' ITE_SUBSTI = ' + fTrataFloatString(qryItens.FieldByName('ITE_SUBSTI').AsString) + ', ';
    strConteudo := strConteudo + ' ITE_PRECUS = ' + fTrataFloatString(qryItens.FieldByName('ITE_PRECUS').AsString) + ', ';
    strConteudo := strConteudo + ' ITE_SUBFED = ' + fTrataFloatString(qryItens.FieldByName('ITE_SUBFED').AsString) + ', ';
    strConteudo := strConteudo + ' ITE_IMPFED = ' + fTrataFloatString(qryItens.FieldByName('ITE_IMPFED').AsString) + ', ';
    strConteudo := strConteudo + ' ITE_ICMSAI = ' + fTrataFloatString(qryItens.FieldByName('ITE_ICMSAI').AsString) + ', ';
    strConteudo := strConteudo + ' ITE_DESOPE = ' + fTrataFloatString(qryItens.FieldByName('ITE_DESOPE').AsString) + ', ';
    strConteudo := strConteudo + ' ITE_OUTVAL = ' + fTrataFloatString(qryItens.FieldByName('ITE_OUTVAL').AsString) ;
    strConteudo := strConteudo + ' WHERE AUTOINCREM = "' +qryItens.FieldByName('INCDET').AsString+ '";';
    stlListaTabDetProcessada.Add(qryItens.FieldByName('INCDET').AsString);
    FScriptTabDet.Add(strConteudo);



End;


procedure TCalculaComposicaoCusto.pGeraScritp(blnSemAtivo: Boolean = False);
begin
  If blnSemAtivo then
    pGeraScriptTabDetSemAtivo
  Else
  Begin
    pGeraScriptIteger;
    pGeraScriptTabDet;
  End;
End;


function TCalculaComposicaoCusto.fAlteraTabDet(strAutIncTabDet: String): Boolean;
Begin
  Result := True;
  If strAutIncTabDet = '' Then
    Exit(False);
  If stlListaTabDetProcessada.IndexOf(strAutIncTabDet) > -1 Then
    Exit(False);
End;


procedure TCalculaComposicaoCusto.pDefineValorImpostos(var fltIcmEnt, fltIcmSai, fltSubsti: Double);
begin
  If blnSemST then
  Begin
    fltIcmEnt := FAliquotaBaseFornecedor;
    fltIcmSai := FAliquotaICMSSai;
    fltSubsti := 0;
  End
  Else
  Begin
    fltIcmEnt := 0;
    fltIcmSai := 0;
    fltSubsti := FAlqST;
  End;
End;


procedure TCalculaComposicaoCusto.pCalulaPrecoDeVendaOuMargem(TipoCalculo: TTipoCalculoMargemPreven; DataSet: TDataSet;
  intTabela: integer; fltPreCus, fltIcmsSai: Double; var fltMargem, fltPreven: Double; blnSemItemAtivo: Boolean = False);
  var strTabela: String;
begin
  If blnSemItemAtivo Then
    strTabela := ''
  Else
   strTabela := IntToStr(intTabela);
  If TipoCalculo = tcmVenda Then
    fltPreven := fCalculaPrecoVenda(1,
                                    fltPreCus + dataSet.FieldByName('ITE_OUTVAL' + strTabela).AsFloat,
                                    0,
                                    fltMargem,
                                    fltIcmssai,
                                    dataSet.FieldByName('ITE_IMPFED' + strTabela).AsFloat,
                                    dataSet.FieldByName('ITE_DESOPE' + strTabela).AsFloat,
                                    dataSet.FieldByName('ITE_COMTBL' + strTabela).AsFloat)

  Else
    fltMargem := fCalculaPrecoVenda(2,
                                    fltPreCus + dataSet.FieldByName('ITE_OUTVAL' + strTabela).AsFloat,
                                    fltPreven,
                                    0,
                                    fltIcmssai,
                                    dataSet.FieldByName('ITE_IMPFED' + strTabela).AsFloat,
                                    dataSet.FieldByName('ITE_DESOPE' + strTabela).AsFloat,
                                    dataSet.FieldByName('ITE_COMTBL' + strTabela).AsFloat);
end;


function TCalculaComposicaoCusto.fRetPrecoCustoSemItemAtivo(intTabela: Integer;dataSet: TDataSet; fltIcmEnt, fltSubst: Double): Double;
  Var
    blnUtilizarConversorDeMoeda: Boolean;
    strTabela: string;
begin

  strTabela := IntToStr(intTabela);

  cpcParams.curPreCom := dataSet.FieldByName('ITE_PRECOM').AsFloat;
  cpcParams.curDesF01 := dataSet.FieldByName('ITE_DESF01').AsFloat;
  cpcParams.curDesF02 := dataSet.FieldByName('ITE_DESF02').AsFloat;
  cpcParams.curDesF03 := dataSet.FieldByName('ITE_DESF03').AsFloat;
  cpcParams.curDesF04 := dataSet.FieldByName('ITE_DESF04').AsFloat;
  cpcParams.curDesF05 := dataSet.FieldByName('ITE_DESF05').AsFloat;
  cpcParams.curDesF06 := dataSet.FieldByName('ITE_DESF06').AsFloat;
  cpcParams.curICMSEnt:= fltIcmEnt;
  cpcParams.curIPIEnt := dataSet.FieldByName('ITE_IPIENT').AsFloat;
  cpcParams.curFrete  := dataSet.FieldByName('ITE_FREENT').AsFloat;
  cpcParams.curAcrFin := dataSet.FieldByName('ITE_ACRFIN').AsFloat;
  cpcParams.curSubsti := fltSubst;
  cpcParams.curValFre := dataSet.FieldByName('ITE_VALFRE').AsFloat;
  cpcParams.curDesAdb := dataSet.FieldByName('ITE_DESADB').AsFloat;
  cpcParams.curSubFed := dataSet.FieldByName('ITE_SUBFED').AsFloat;

  if blnSufram and (strFrmCus = '4') then
  begin
    cpcParams.curTCIFCu := dataSet.FieldByName('ITE_TCIFCU').AsFloat;
    cpcParams.curTSCust := dataSet.FieldByName('ITE_TSCUST').AsFloat;
    cpcParams.curDePiCo := dataSet.FieldByName('ITE_DEPICO').AsFloat;
    cpcParams.curDeICMS := dataSet.FieldByName('ITE_DEICMS').AsFloat;
    cpcParams.curFatReg := dataSet.FieldByName('ITE_FATREG').AsFloat;
  end
  else
  begin
    cpcParams.curTCIFCu := 0;
    cpcParams.curTSCust := 0;
    cpcParams.curDePiCo := 0;
    cpcParams.curDeICMS := 0;
    cpcParams.curFatReg := 0;
  end;

  blnUtilizarConversorDeMoeda := dataSet.FieldByName('ITE_PREDOL').AsString = 'S';

  Result := cpcParams.fCalculaPrecoCusto(blnUtilizarConversorDeMoeda);
  Result := Result;
end;


function TCalculaComposicaoCusto.fRetPrecoCusto(intTabela: Integer;dataSet: TDataSet; fltIcmEnt, fltSubst: Double): Double;
  Var
    blnUtilizarConversorDeMoeda: Boolean;
    strTabela: string;
begin

  strTabela := IntToStr(intTabela);

  cpcParams.curPreCom := dataSet.FieldByName('ITE_PRECOM' + strTabela).AsFloat;
  cpcParams.curDesF01 := dataSet.FieldByName('ITE_DESF01' + strTabela).AsFloat;
  cpcParams.curDesF02 := dataSet.FieldByName('ITE_DESF02' + strTabela).AsFloat;
  cpcParams.curDesF03 := dataSet.FieldByName('ITE_DESF03' + strTabela).AsFloat;
  cpcParams.curDesF04 := dataSet.FieldByName('ITE_DESF04' + strTabela).AsFloat;
  cpcParams.curDesF05 := dataSet.FieldByName('ITE_DESF05' + strTabela).AsFloat;
  cpcParams.curDesF06 := dataSet.FieldByName('ITE_DESF06' + strTabela).AsFloat;
  cpcParams.curICMSEnt:= fltIcmEnt;
  cpcParams.curIPIEnt := dataSet.FieldByName('ITE_IPIENT' + IntToStr(intTabela)).AsFloat;
  cpcParams.curFrete  := dataSet.FieldByName('ITE_FREENT' + IntToStr(intTabela)).AsFloat;
  cpcParams.curAcrFin := dataSet.FieldByName('ITE_ACRFIN' + IntToStr(intTabela)).AsFloat;
  cpcParams.curSubsti := fltSubst;
  cpcParams.curValFre := dataSet.FieldByName('ITE_VALFRE' + IntToStr(intTabela)).AsFloat;
  cpcParams.curDesAdb := dataSet.FieldByName('ITE_DESADB' + IntToStr(intTabela)).AsFloat;
  cpcParams.curSubFed := dataSet.FieldByName('ITE_SUBFED' + IntToStr(intTabela)).AsFloat;

  if blnSufram and (strFrmCus = '4') then
  begin
    cpcParams.curTCIFCu := dataSet.FieldByName('ITE_TCIFCU' + IntToStr(intTabela)).AsFloat;
    cpcParams.curTSCust := dataSet.FieldByName('ITE_TSCUST' + IntToStr(intTabela)).AsFloat;
    cpcParams.curDePiCo := dataSet.FieldByName('ITE_DEPICO' + IntToStr(intTabela)).AsFloat;
    cpcParams.curDeICMS := dataSet.FieldByName('ITE_DEICMS' + IntToStr(intTabela)).AsFloat;
    cpcParams.curFatReg := dataSet.FieldByName('ITE_FATREG' + IntToStr(intTabela)).AsFloat;
  end
  else
  begin
    cpcParams.curTCIFCu := 0;
    cpcParams.curTSCust := 0;
    cpcParams.curDePiCo := 0;
    cpcParams.curDeICMS := 0;
    cpcParams.curFatReg := 0;
  end;

  blnUtilizarConversorDeMoeda := dataSet.FieldByName('ITE_PREDOL' + IntToStr(intTabela)).AsString = 'S';

  Result := cpcParams.fCalculaPrecoCusto(blnUtilizarConversorDeMoeda);


end;

function TCalculaComposicaoCusto.fProcessaVal(strCodFor, strCodAbf: String;
                                              AIPIEntrada: Double): Double;
begin
  Result := fProcessaVal(FCSTFornecedor,
                         FAliBaseRetICMSForne,
                         FAlqFundoCombatePobreza,
                         FBaseIcmFornecedor,
                         AIPIEntrada,
                         FIVAFornecedor,
                         FAliquotaBaseFornecedor,
                         FBaseRetICMSFornecedor);
end;



procedure TCalculaComposicaoCusto.pCarregaAbreviacoesICMS;
begin
  qryAbf := fCriaQuery;
  qryAbf.SQL.Add('SELECT ABF_ALQRET_ENT_PEF,');
  qryAbf.SQL.Add('       ABF_ALQRET_ENT_PEJ,');
  qryAbf.SQL.Add('       ABF_ALQRET_ENT_PER,');
  qryAbf.SQL.Add('       ABF_ALQRET_ENT_PES,');
  qryAbf.SQL.Add('       ABF_ALQRET_ENT_PSI,');
  qryAbf.SQL.Add('       ABF_ALQRET_ENT_PII,');
  qryAbf.SQL.Add('       ABF_CODSIT_ENT_PEF,');
  qryAbf.SQL.Add('       ABF_CODSIT_ENT_PEJ,');
  qryAbf.SQL.Add('       ABF_CODSIT_ENT_PER,');
  qryAbf.SQL.Add('       ABF_CODSIT_ENT_PES,');
  qryAbf.SQL.Add('       ABF_CODSIT_ENT_PSI,');
  qryAbf.SQL.Add('       ABF_CODSIT_ENT_PII,');
  qryAbf.SQL.Add('       ABF_BASICM_ENT_PEF,');
  qryAbf.SQL.Add('       ABF_BASICM_ENT_PEJ,');
  qryAbf.SQL.Add('       ABF_BASICM_ENT_PER,');
  qryAbf.SQL.Add('       ABF_BASICM_ENT_PES,');
  qryAbf.SQL.Add('       ABF_BASICM_ENT_PSI,');
  qryAbf.SQL.Add('       ABF_BASICM_ENT_PII,');
  qryAbf.SQL.Add('       ABF_ALQICM_ENT_PEF,');
  qryAbf.SQL.Add('       ABF_ALQICM_ENT_PEJ,');
  qryAbf.SQL.Add('       ABF_ALQICM_ENT_PER,');
  qryAbf.SQL.Add('       ABF_ALQICM_ENT_PES,');
  qryAbf.SQL.Add('       ABF_ALQICM_ENT_PSI,');
  qryAbf.SQL.Add('       ABF_ALQICM_ENT_PII,');
  qryAbf.SQL.Add('       ABF_BASRET_ENT_PEF,');
  qryAbf.SQL.Add('       ABF_BASRET_ENT_PEJ,');
  qryAbf.SQL.Add('       ABF_BASRET_ENT_PER,');
  qryAbf.SQL.Add('       ABF_BASRET_ENT_PES,');
  qryAbf.SQL.Add('       ABF_BASRET_ENT_PSI,');
  qryAbf.SQL.Add('       ABF_BASRET_ENT_PII,');
  qryAbf.SQL.Add('       ABF_ALQFCP_ENT_PEF,');
  qryAbf.SQL.Add('       ABF_ALQFCP_ENT_PEJ,');
  qryAbf.SQL.Add('       ABF_ALQFCP_ENT_PER,');
  qryAbf.SQL.Add('       ABF_ALQFCP_ENT_PES,');
  qryAbf.SQL.Add('       ABF_ALQFCP_ENT_PSI,');
  qryAbf.SQL.Add('       ABF_ALQFCP_ENT_PII,');
  qryAbf.SQL.Add('       ABF_IVA_ST_ENT_PEF,');
  qryAbf.SQL.Add('       ABF_IVA_ST_ENT_PEJ,');
  qryAbf.SQL.Add('       ABF_IVA_ST_ENT_PER,');
  qryAbf.SQL.Add('       ABF_IVA_ST_ENT_PES,');
  qryAbf.SQL.Add('       ABF_IVA_ST_ENT_PSI,');
  qryAbf.SQL.Add('       ABF_IVA_ST_ENT_PII,');
  qryAbf.SQL.Add('       ABF_ESTADO, ');
  qryAbf.SQL.Add('       ABF_CODABF ');
  qryAbf.SQL.Add('  FROM ABFICM ');
  If OrigemCalculo = tocPadrao then
   If FCodAbf <> '' Then
    qryAbf.SQL.Add('   WHERE ABF_CODABF = "' + FCodAbf + '"');
  qryAbf.Open;
end;

procedure TCalculaComposicaoCusto.pCarregaInformacoes(strCodFor, strCodAbf: String; strCodTab: string = '');
begin
  FAliquotaICMSSai  := 0;

  FCodAbf := strCodAbf;
  FBlnSemST         := False;
  FBaseIcmFornecedor:= 0;

  qryConsulta.SQL.Add('SELECT ABF_ALQRET_ENT_PEF,');
  qryConsulta.SQL.Add('       ABF_ALQRET_ENT_PEJ,');
  qryConsulta.SQL.Add('       ABF_ALQRET_ENT_PER,');
  qryConsulta.SQL.Add('       ABF_ALQRET_ENT_PES,');
  qryConsulta.SQL.Add('       ABF_ALQRET_ENT_PSI,');
  qryConsulta.SQL.Add('       ABF_ALQRET_ENT_PII,');
  qryConsulta.SQL.Add('       ABF_CODSIT_ENT_PEF,');
  qryConsulta.SQL.Add('       ABF_CODSIT_ENT_PEJ,');
  qryConsulta.SQL.Add('       ABF_CODSIT_ENT_PER,');
  qryConsulta.SQL.Add('       ABF_CODSIT_ENT_PES,');
  qryConsulta.SQL.Add('       ABF_CODSIT_ENT_PSI,');
  qryConsulta.SQL.Add('       ABF_CODSIT_ENT_PII,');
  qryConsulta.SQL.Add('       ABF_BASICM_ENT_PEF,');
  qryConsulta.SQL.Add('       ABF_BASICM_ENT_PEJ,');
  qryConsulta.SQL.Add('       ABF_BASICM_ENT_PER,');
  qryConsulta.SQL.Add('       ABF_BASICM_ENT_PES,');
  qryConsulta.SQL.Add('       ABF_BASICM_ENT_PSI,');
  qryConsulta.SQL.Add('       ABF_BASICM_ENT_PII,');
  qryConsulta.SQL.Add('       ABF_ALQICM_ENT_PEF,');
  qryConsulta.SQL.Add('       ABF_ALQICM_ENT_PEJ,');
  qryConsulta.SQL.Add('       ABF_ALQICM_ENT_PER,');
  qryConsulta.SQL.Add('       ABF_ALQICM_ENT_PES,');
  qryConsulta.SQL.Add('       ABF_ALQICM_ENT_PSI,');
  qryConsulta.SQL.Add('       ABF_ALQICM_ENT_PII,');
  qryConsulta.SQL.Add('       ABF_BASRET_ENT_PEF,');
  qryConsulta.SQL.Add('       ABF_BASRET_ENT_PEJ,');
  qryConsulta.SQL.Add('       ABF_BASRET_ENT_PER,');
  qryConsulta.SQL.Add('       ABF_BASRET_ENT_PES,');
  qryConsulta.SQL.Add('       ABF_BASRET_ENT_PSI,');
  qryConsulta.SQL.Add('       ABF_BASRET_ENT_PII,');
  qryConsulta.SQL.Add('       ABF_ALQFCP_ENT_PEF,');
  qryConsulta.SQL.Add('       ABF_ALQFCP_ENT_PEJ,');
  qryConsulta.SQL.Add('       ABF_ALQFCP_ENT_PER,');
  qryConsulta.SQL.Add('       ABF_ALQFCP_ENT_PES,');
  qryConsulta.SQL.Add('       ABF_ALQFCP_ENT_PSI,');
  qryConsulta.SQL.Add('       ABF_ALQFCP_ENT_PII,');
  qryConsulta.SQL.Add('       ABF_IVA_ST_ENT_PEF,');
  qryConsulta.SQL.Add('       ABF_IVA_ST_ENT_PEJ,');
  qryConsulta.SQL.Add('       ABF_IVA_ST_ENT_PER,');
  qryConsulta.SQL.Add('       ABF_IVA_ST_ENT_PES,');
  qryConsulta.SQL.Add('       ABF_IVA_ST_ENT_PSI,');
  qryConsulta.SQL.Add('       ABF_IVA_ST_ENT_PII,');
  qryConsulta.SQL.Add('       FOR_BSTXML,');
  qryConsulta.SQL.Add('       CID_ESTADO');
  qryConsulta.SQL.Add('  FROM CADFOR');
  qryConsulta.SQL.Add(' INNER JOIN CADCID ON CID_CODCID = FOR_CODCID');
  qryConsulta.SQL.Add(' INNER JOIN ABFICM ON ABF_CODABF = "' + strCodAbf + '" AND ABF_ESTADO = CID_ESTADO');
  qryConsulta.SQL.Add(' WHERE FOR_CODFOR = "'+strCodFor+'"');
  qryConsulta.Open;

  FEstadoFornecedor       := qryConsulta.FieldByName('CID_ESTADO').AsString;
  FTipoAbfFornecedor      := fGetTipoAbfFornecedor(strCodFor, FstrTipFor);
  FAliBaseRetICMSForne    := qryConsulta.FieldByName('ABF_ALQRET' + FTipoAbfFornecedor).AsFloat;
  FCSTFornecedor          := qryConsulta.FieldByName('ABF_CODSIT' + FTipoAbfFornecedor).AsString;
  FBaseIcmFornecedor      := qryConsulta.FieldByName('ABF_BASICM' + FTipoAbfFornecedor).AsFloat;
  FAliquotaBaseFornecedor := qryConsulta.FieldByName('ABF_ALQICM' + FTipoAbfFornecedor).AsFloat;
  FBaseRetICMSFornecedor  := qryConsulta.FieldByName('ABF_BASRET' + FTipoAbfFornecedor).AsFloat;
  FAlqFundoCombatePobreza := qryConsulta.FieldByName('ABF_ALQFCP' + FTipoAbfFornecedor).AsFloat;
  FIVAFornecedor          := qryConsulta.FieldByName('ABF_IVA_ST' + FTipoAbfFornecedor).AsFloat;
  FintBSTXML              := qryConsulta.FieldByName('FOR_BSTXML').AsInteger;


  If strCodTab = '' Then
    strCodTab :=  IntToStr(fRetPrimeiraTabPrecoAtiva);

  pCarregaABFEmpresa(strCodTab);

  qryConsulta.Close;

end;

procedure TCalculaComposicaoCusto.pCarregaABFEmpresa(strCodTabela : string);
begin

  qryConsulta.Close;
  qryConsulta.SQL.Clear;

  qryConsulta.SQL.Add('SELECT C1.CUS_ICMSAI CUS_ICMSAI1, ');
  qryConsulta.SQL.Add('       C1.CUS_IMPFED CUS_IMPFED1, ');
  qryConsulta.SQL.Add('       C1.CUS_SUBFED CUS_SUBFED1, ');
  qryConsulta.SQL.Add('       C1.CUS_DESOPE CUS_DESOPE1, ');
  qryConsulta.SQL.Add('       C1.CUS_OUTVAL CUS_OUTVAL1, ');

  qryConsulta.SQL.Add('       C2.CUS_ICMSAI CUS_ICMSAI2, ');
  qryConsulta.SQL.Add('       C2.CUS_IMPFED CUS_IMPFED2, ');
  qryConsulta.SQL.Add('       C2.CUS_SUBFED CUS_SUBFED2, ');
  qryConsulta.SQL.Add('       C2.CUS_DESOPE CUS_DESOPE2, ');
  qryConsulta.SQL.Add('       C2.CUS_OUTVAL CUS_OUTVAL2, ');

  qryConsulta.SQL.Add('       C3.CUS_ICMSAI CUS_ICMSAI3, ');
  qryConsulta.SQL.Add('       C3.CUS_IMPFED CUS_IMPFED3, ');
  qryConsulta.SQL.Add('       C3.CUS_SUBFED CUS_SUBFED3, ');
  qryConsulta.SQL.Add('       C3.CUS_DESOPE CUS_DESOPE3, ');
  qryConsulta.SQL.Add('       C3.CUS_OUTVAL CUS_OUTVAL3, ');

  qryConsulta.SQL.Add('       C4.CUS_ICMSAI CUS_ICMSAI4, ');
  qryConsulta.SQL.Add('       C4.CUS_IMPFED CUS_IMPFED4, ');
  qryConsulta.SQL.Add('       C4.CUS_SUBFED CUS_SUBFED4, ');
  qryConsulta.SQL.Add('       C4.CUS_DESOPE CUS_DESOPE4, ');
  qryConsulta.SQL.Add('       C4.CUS_OUTVAL CUS_OUTVAL4, ');

  qryConsulta.SQL.Add('       C5.CUS_ICMSAI CUS_ICMSAI5, ');
  qryConsulta.SQL.Add('       C5.CUS_IMPFED CUS_IMPFED5, ');
  qryConsulta.SQL.Add('       C5.CUS_SUBFED CUS_SUBFED5, ');
  qryConsulta.SQL.Add('       C5.CUS_DESOPE CUS_DESOPE5, ');
  qryConsulta.SQL.Add('       C5.CUS_OUTVAL CUS_OUTVAL5, ');

  qryConsulta.SQL.Add('       C6.CUS_ICMSAI CUS_ICMSAI6, ');
  qryConsulta.SQL.Add('       C6.CUS_IMPFED CUS_IMPFED6, ');
  qryConsulta.SQL.Add('       C6.CUS_SUBFED CUS_SUBFED6, ');
  qryConsulta.SQL.Add('       C6.CUS_DESOPE CUS_DESOPE6, ');
  qryConsulta.SQL.Add('       C6.CUS_OUTVAL CUS_OUTVAL6, ');

  qryConsulta.SQL.Add('       C7.CUS_ICMSAI CUS_ICMSAI7, ');
  qryConsulta.SQL.Add('       C7.CUS_IMPFED CUS_IMPFED7, ');
  qryConsulta.SQL.Add('       C7.CUS_SUBFED CUS_SUBFED7, ');
  qryConsulta.SQL.Add('       C7.CUS_DESOPE CUS_DESOPE7, ');
  qryConsulta.SQL.Add('       C7.CUS_OUTVAL CUS_OUTVAL7 ');


  qryConsulta.SQL.Add('  FROM CADEMP');
  qryConsulta.SQL.Add('  LEFT JOIN CUSEMP C1 ON C1.CUS_CODEMP = EMP_CODEMP AND C1.CUS_TABELA = 1');
  qryConsulta.SQL.Add('  LEFT JOIN CUSEMP C2 ON C2.CUS_CODEMP = EMP_CODEMP AND C2.CUS_TABELA = 2');
  qryConsulta.SQL.Add('  LEFT JOIN CUSEMP C3 ON C3.CUS_CODEMP = EMP_CODEMP AND C3.CUS_TABELA = 3');
  qryConsulta.SQL.Add('  LEFT JOIN CUSEMP C4 ON C4.CUS_CODEMP = EMP_CODEMP AND C4.CUS_TABELA = 4');
  qryConsulta.SQL.Add('  LEFT JOIN CUSEMP C5 ON C5.CUS_CODEMP = EMP_CODEMP AND C5.CUS_TABELA = 5');
  qryConsulta.SQL.Add('  LEFT JOIN CUSEMP C6 ON C6.CUS_CODEMP = EMP_CODEMP AND C6.CUS_TABELA = 6');
  qryConsulta.SQL.Add('  LEFT JOIN CUSEMP C7 ON C7.CUS_CODEMP = EMP_CODEMP AND C7.CUS_TABELA = 7');
  qryConsulta.SQL.Add(' WHERE EMP_CODEMP = "'+FCodEmp+'"');


  qryConsulta.Open;
  FAliquotaICMSSai := qryConsulta.FieldByName('CUS_ICMSAI' + strCodTabela).AsFloat;
  FImpFed  := qryConsulta.FieldByName('CUS_IMPFED' + strCodTabela).AsFloat;
  FImpSub  := qryConsulta.FieldByName('CUS_SUBFED' + strCodTabela).AsFloat;
  FDesOpe  := qryConsulta.FieldByName('CUS_DESOPE' + strCodTabela).AsFloat;
  FOutVal  := qryConsulta.FieldByName('CUS_OUTVAL' + strCodTabela).AsFloat;



End;


procedure TCalculaComposicaoCusto.pCarregaItensSemTabelaPrecoAtivo;
begin
  If Assigned(qryItens) Then
    FreeAndNil(qryItens);
  qryItens := TZClient.Create(nil, '');
  qryItens.qryQuery.SQL.Add('SELECT 0 AS PROCESSADO, ');
  qryItens.qryQuery.SQL.Add('       CAST(CONCAT("_ENT_", IF(FO.FOR_SIMPAU = "S", IF(FO.FOR_MATREV = "I" OR FO.FOR_MATREV = "Y", "PSI", "PES"),');
  qryItens.qryQuery.SQL.Add('                       IF(IFNULL(FO.FOR_I_E_S_, "") = "" OR FO.FOR_CGCCPF <> 1, "PEF",');
  qryItens.qryQuery.SQL.Add('                       IF(FO.FOR_MATREV = "I", "PEJ",');
  qryItens.qryQuery.SQL.Add('                       IF(FO.FOR_MATREV = "Y", "PII", "PER"))))) AS CHAR(10)) AS TIPABF,');
  qryItens.qryQuery.SQL.Add('       CADITE.ITE_INCPIS, ');
  qryItens.qryQuery.SQL.Add('       D.ITE_CODITE, ');
  qryItens.qryQuery.SQL.Add('       D.ITE_CODEMP, ');
  qryItens.qryQuery.SQL.Add('       D.ITE_CODABF,');
  qryItens.qryQuery.SQL.Add('       D.ITE_PRECUS,');
  qryItens.qryQuery.SQL.Add('       DC.DET_TABELA AS TABELA,');
  qryItens.qryQuery.SQL.Add('       D.ITE_PRECUS AS ITE_PRECUS_CNV,');
  qryItens.qryQuery.SQL.Add('       D.ITE_PRECUS AS ORI_ITE_PRECUS,');
  qryItens.qryQuery.SQL.Add('       FO.FOR_CODFOR AS  ITE_CODFOR,');
  qryItens.qryQuery.SQL.Add('       CI.CID_ESTADO AS CID_ESTADO,');
  qryItens.qryQuery.SQL.Add('       FOR_BSTXML,');
  qryItens.qryQuery.SQL.Add('        D.ITE_IPIENT AS ITE_IPIENT,');
  qryItens.qryQuery.SQL.Add('        D.ITE_FREENT AS ITE_FREENT,');
  qryItens.qryQuery.SQL.Add('        D.ITE_ACRFIN AS ITE_ACRFIN,');
  qryItens.qryQuery.SQL.Add('        D.ITE_VALFRE AS ITE_VALFRE,');
  qryItens.qryQuery.SQL.Add('        D.ITE_DESADB AS ITE_DESADB,');
  qryItens.qryQuery.SQL.Add('        IF(IFNULL(CADITE.ITE_INCPIS, "N") = "S", D.ITE_SUBFED, 0)  AS TAB_ITE_SUBFED,');
  qryItens.qryQuery.SQL.Add('        IF(IFNULL(CADITE.ITE_INCPIS, "N") = "S", D.ITE_SUBFED, 0) AS ITE_SUBFED,');
  qryItens.qryQuery.SQL.Add('        IF(IFNULL(CADITE.ITE_INCPIS, "N") = "S", D.ITE_IMPFED, 0) AS ITE_IMPFED,');
  qryItens.qryQuery.SQL.Add('        DC.DET_ICMSAI AS ITE_ICMSAI,');
  qryItens.qryQuery.SQL.Add('        DC.DET_DESOPE AS ITE_DESOPE,');
  qryItens.qryQuery.SQL.Add('        DC.DET_OUTVAL AS ITE_OUTVAL,');
  qryItens.qryQuery.SQL.Add('        DC.DET_OUTVAL AS ITE_OUTVAL_CNV,');
  qryItens.qryQuery.SQL.Add('        D.ITE_ICMENT AS ITE_ICMENT,');
  qryItens.qryQuery.SQL.Add('        D.ITE_SUBSTI AS ITE_SUBSTI,');
  qryItens.qryQuery.SQL.Add('        DC.DET_PREVEN AS ITE_PREVEN,');
  qryItens.qryQuery.SQL.Add('        DC.DET_PREVEN AS ITE_PREVEN_CNV,');
  qryItens.qryQuery.SQL.Add('        DC.DET_MARBRU AS ITE_MARBRU,');
  qryItens.qryQuery.SQL.Add('        D.ITE_PRECOM AS ORI_ITE_PRECOM,');
  qryItens.qryQuery.SQL.Add('        D.ITE_PRECOM AS ITE_PRECOM,');
  qryItens.qryQuery.SQL.Add('        D.ITE_DESF01 AS ITE_DESF01,');
  qryItens.qryQuery.SQL.Add('        D.ITE_DESF02 AS ITE_DESF02,');
  qryItens.qryQuery.SQL.Add('        D.ITE_DESF03 AS ITE_DESF03,');
  qryItens.qryQuery.SQL.Add('        D.ITE_DESF04 AS ITE_DESF04,');
  qryItens.qryQuery.SQL.Add('        D.ITE_DESF05 AS ITE_DESF05,');
  qryItens.qryQuery.SQL.Add('        D.ITE_DESF06 AS ITE_DESF06,');
  qryItens.qryQuery.SQL.Add('         D.ITE_PRECOM *');
  qryItens.qryQuery.SQL.Add('          ( 1 - (D.ITE_DESF01 / 100) ) * ');
  qryItens.qryQuery.SQL.Add('          ( 1 - (D.ITE_DESF02 / 100) ) * ');
  qryItens.qryQuery.SQL.Add('          ( 1 - (D.ITE_DESF03 / 100) ) * ');
  qryItens.qryQuery.SQL.Add('          ( 1 - (D.ITE_DESF04 / 100) ) * ');
  qryItens.qryQuery.SQL.Add('          ( 1 - (D.ITE_DESF05 / 100) ) *');
  qryItens.qryQuery.SQL.Add('          ( 1 - (D.ITE_DESF06 / 100) ) AS ITE_COMLIQ,');
  qryItens.qryQuery.SQL.Add('        D.ITE_PREDOL AS ITE_PREDOL,');
  qryItens.qryQuery.SQL.Add('        D.AUTOINCREM AS INCDET,');
  qryItens.qryQuery.SQL.Add('        D.ITE_CODTAB,');
  qryItens.qryQuery.SQL.Add('        IF(IFNULL(F.ITE_CNVCUS, 1) <=0 , 1, IFNULL(F.ITE_CNVCUS, 1)) ITE_CNVCUS, ');
  qryItens.qryQuery.SQL.Add('        D.ITE_PREREV AS ITE_PREREV,');
  qryItens.qryQuery.SQL.Add('        D.ITE_COMTBL AS ITE_COMTBL');
  qryItens.qryQuery.SQL.Add('   FROM TABPRE');
  qryItens.qryQuery.SQL.Add('  INNER JOIN ITEFOR F ON F.ITE_CODTAB = TABPRE.TAB_CODTAB ');
  qryItens.qryQuery.SQL.Add('  INNER JOIN TABDET D ON D.ITE_CODTAB = TABPRE.TAB_CODTAB');
  qryItens.qryQuery.SQL.Add('                     AND D.ITE_CODITE = F.ITE_CODITE ');
  qryItens.qryQuery.SQL.Add('  INNER JOIN CADFOR FO ON FO.FOR_CODFOR = TAB_CODFOR');
  qryItens.qryQuery.SQL.Add('  INNER JOIN CADITE ON CADITE.ITE_CODITE = D.ITE_CODITE');
  qryItens.qryQuery.SQL.Add('   LEFT JOIN CADCID CI ON CI.CID_CODCID = FO.FOR_CODCID  ');
  qryItens.qryQuery.SQL.Add('   LEFT JOIN DETCUS DC ON DC.DET_SEQDET = D.AUTOINCREM ');
  qryItens.qryQuery.SQL.Add('   WHERE DC.DET_PROCESSADO = 0');
  If OrigemCalculo in [tocCadEmpresa, tocCalcGeral] then
    qryItens.qryQuery.SQL.Add(' AND D.ITE_CODEMP  IN('+fStringSQLLocateToStringSQLIN(cdsEmpresas.FieldByname('EMP_UTIPRECO').AsString)+')');

  If FStrCodTab <> '' Then
    qryItens.qryQuery.SQL.Add(' AND D.ITE_CODTAB = "'+FStrCodTab+'"');

  If FCodAbf <> '' Then
    qryItens.qryQuery.SQL.Add(' AND D.ITE_CODABF = "'+FCodAbf+'"');



  qryItens.qryQuery.SQL.Add('   ORDER BY ITE_CODTAB, D.ITE_CODITE, D.ITE_CODEMP ');
  qryItens.fAbreClient(False, '[TCalculaComposicaoCusto.pCarregaItensSemTabelaPrecoAtivo]');
End;

procedure TCalculaComposicaoCusto.pConsultaTabDet(strAutoincrem,
  strTabela: String; strCodEmp: String);
begin
  qryConsulta.SQL.Clear;
  if strAutoincrem = '' Then
  Begin
    qryConsulta.SQL.Add('SELECT CUS_ICMSAI AS DET_ICMSAI,');
    qryConsulta.SQL.Add('       CUS_DESOPE AS DET_DESOPE,');
    qryConsulta.SQL.Add('       CUS_OUTVAL AS DET_OUTVAL,');
    qryConsulta.SQL.Add('       CUS_IMPFED AS ITE_IMPFED,');
    qryConsulta.SQL.Add('       CUS_SUBFED AS ITE_SUBFED');
    qryConsulta.SQL.Add('  FROM CUSEMP');
    qryConsulta.SQL.Add(' WHERE CUS_CODEMP = ' + QuotedStr(strCodEmp));
    qryConsulta.SQL.Add('   AND CUS_TABELA = ' + QuotedStr(strTabela));
  End
  Else
  Begin
    qryConsulta.SQL.Add('SELECT IFNULL(DET_ICMSAI, CUS_ICMSAI) AS DET_ICMSAI,');
    qryConsulta.SQL.Add('       IFNULL(DET_DESOPE, CUS_DESOPE) AS DET_DESOPE,');
    qryConsulta.SQL.Add('       IFNULL(DET_OUTVAL, CUS_OUTVAL) AS DET_OUTVAL,');
    qryConsulta.SQL.Add('       IFNULL(ITE_IMPFED, CUS_IMPFED) AS ITE_IMPFED,');
    qryConsulta.SQL.Add('       IFNULL(ITE_SUBFED, CUS_SUBFED) AS ITE_SUBFED');
    qryConsulta.SQL.Add('  FROM TABDET');
    qryConsulta.SQL.Add(' INNER JOIN DETCUS ON DET_SEQDET = TABDET.AUTOINCREM');
    qryConsulta.SQL.Add('  LEFT JOIN CUSEMP ON CUS_CODEMP = TABDET.ITE_CODEMP AND CUS_TABELA = DET_TABELA ');
    qryConsulta.SQL.Add(' WHERE TABDET.AUTOINCREM = ' + QuotedStr(strAutoincrem));
    qryConsulta.SQL.Add('   AND DET_TABELA = ' + QuotedStr(strTabela));
  End;


  qryConsulta.Open;
end;

procedure TCalculaComposicaoCusto.pCarregaItens;
var i: Integer;
begin
  qryItens := TZClient.Create(nil, '');
  qryItens.qryQuery.SQL.Add('SELECT ITEGER.*, ');
  qryItens.qryQuery.SQL.Add('       0 AS PROCESSADO, ');
  qryItens.qryQuery.SQL.Add('       CADITE.ITE_INCPIS, ');
  For i := 1 To 7 Do
  begin
    qryItens.qryQuery.SQL.Add('     IF(F'+ IntToStr(i) + '.FOR_CODFOR IS NULL,');
    qryItens.qryQuery.SQL.Add('     CAST(CONCAT("_ENT_", IF(F.FOR_SIMPAU = "S", IF(F.FOR_MATREV = "I" OR F.FOR_MATREV = "Y", "PSI", "PES"),');
    qryItens.qryQuery.SQL.Add('                   IF(IFNULL(F.FOR_I_E_S_, "") = "" OR F.FOR_CGCCPF <> 1, "PEF",');
    qryItens.qryQuery.SQL.Add('                   IF(F.FOR_MATREV = "I", "PEJ",');
    qryItens.qryQuery.SQL.Add('                   IF(F.FOR_MATREV = "Y", "PII", "PER"))))) AS CHAR(10)),');
    qryItens.qryQuery.SQL.Add('     CAST(CONCAT("_ENT_", IF(F'+ IntToStr(i) + '.FOR_SIMPAU = "S", IF(F'+ IntToStr(i) + '.FOR_MATREV = "I" OR F'+ IntToStr(i) + '.FOR_MATREV = "Y", "PSI", "PES"),');
    qryItens.qryQuery.SQL.Add('                   IF(IFNULL(F'+ IntToStr(i) + '.FOR_I_E_S_, "") = "" OR F'+ IntToStr(i) + '.FOR_CGCCPF <> 1, "PEF",');
    qryItens.qryQuery.SQL.Add('                   IF(F'+ IntToStr(i) + '.FOR_MATREV = "I", "PEJ",');
    qryItens.qryQuery.SQL.Add('                   IF(F'+ IntToStr(i) + '.FOR_MATREV = "Y", "PII", "PER"))))) AS CHAR(10))) AS TIPABF'+ IntToStr(i) + ',');
    If fCfgSis('TIPABF') = '2' Then
      qryItens.qryQuery.SQL.Add('IFNULL(TB'+ IntToStr(i) + '.ITE_CODABF, ITEGER.ITE_CODABF) AS ITE_CODABF' + IntToStr(i) + ',')
    Else
      qryItens.qryQuery.SQL.Add('IFNULL(TB'+ IntToStr(i) + '.ITE_CODABF, CADITE.ITE_CODABF) AS ITE_CODABF' + IntToStr(i) + ',');
    qryItens.qryQuery.SQL.Add('IF(IFNULL(FO'+ IntToStr(i) + '.ITE_CNVCUS, 0) <=0, 1, FO'+ IntToStr(i) + '.ITE_CNVCUS) AS ITE_CNVCUS' + IntToStr(i) + ',');
    qryItens.qryQuery.SQL.Add('TB'+ IntToStr(i) + '.ITE_PRECUS  ORI_ITE_PRECUS' + IntToStr(i) + ',');
    qryItens.qryQuery.SQL.Add('TB'+ IntToStr(i) + '.ITE_PRECUS  AS ITE_PRECUS' + IntToStr(i) + ',');
    qryItens.qryQuery.SQL.Add('TB'+ IntToStr(i) + '.ITE_PRECUS/IF(IFNULL(FO' + IntToStr(i) + '.ITE_CNVCUS, 1) <=0 , 1, IFNULL(FO' + IntToStr(i) + '.ITE_CNVCUS, 1)) AS ITE_PRECUS_CNV' + IntToStr(i) + ',');
    qryItens.qryQuery.SQL.Add('IFNULL(TB'+ IntToStr(i) + '.ITE_CODFOR, CADITE.ITE_CODFOR) AS ITE_CODFOR' + IntToStr(i) + ',');
    qryItens.qryQuery.SQL.Add('IFNULL(C'+ IntToStr(i) + '.CID_ESTADO, C.CID_ESTADO) AS CID_ESTADO' + IntToStr(i) + ',');
    qryItens.qryQuery.SQL.Add('IFNULL(F'+ IntToStr(i) + '.FOR_BSTXML, F.FOR_BSTXML) AS FOR_BSTXML' + IntToStr(i) + ',');
    qryItens.qryQuery.SQL.Add('TB'+ IntToStr(i) + '.ITE_IPIENT AS ITE_IPIENT' + IntToStr(i) + ',');
    qryItens.qryQuery.SQL.Add('TB'+ IntToStr(i) + '.ITE_FREENT AS ITE_FREENT' + IntToStr(i) + ',');
    qryItens.qryQuery.SQL.Add('TB'+ IntToStr(i) + '.ITE_ACRFIN AS ITE_ACRFIN' + IntToStr(i) + ',');
    qryItens.qryQuery.SQL.Add('TB'+ IntToStr(i) + '.ITE_VALFRE AS ITE_VALFRE' + IntToStr(i) + ',');
    qryItens.qryQuery.SQL.Add('TB'+ IntToStr(i) + '.ITE_DESADB AS ITE_DESADB' + IntToStr(i) + ',');

    qryItens.qryQuery.SQL.Add('IFNULL(TB'+ IntToStr(i) + '.ITE_SUBFED, ITEGER.ITE_SUBFED) AS TAB_ITE_SUBFED' + IntToStr(i) + ',');

    qryItens.qryQuery.SQL.Add('IF(IFNULL(CADITE.ITE_INCPIS, "N") = "S", TB'+ IntToStr(i) + '.ITE_SUBFED, 0) AS ITE_SUBFED' + IntToStr(i) + ',');
    qryItens.qryQuery.SQL.Add('IF(IFNULL(CADITE.ITE_INCPIS, "N") = "S", TB'+ IntToStr(i) + '.ITE_IMPFED, 0) AS ITE_IMPFED' + IntToStr(i) + ',');
    qryItens.qryQuery.SQL.Add('DC'+ IntToStr(i) + '.DET_ICMSAI AS ITE_ICMSAI' + IntToStr(i) + ',');
    qryItens.qryQuery.SQL.Add('DC'+ IntToStr(i) + '.DET_DESOPE AS ITE_DESOPE' + IntToStr(i) + ',');
    qryItens.qryQuery.SQL.Add('DC'+ IntToStr(i) + '.DET_OUTVAL AS ITE_OUTVAL' + IntToStr(i) + ',');
    qryItens.qryQuery.SQL.Add('DC'+ IntToStr(i) + '.DET_OUTVAL/IF(IFNULL(FO' + IntToStr(i) + '.ITE_CNVCUS, 1) <=0 , 1, IFNULL(FO' + IntToStr(i) + '.ITE_CNVCUS, 1)) AS ITE_OUTVAL_CNV' + IntToStr(i) + ',');

    qryItens.qryQuery.SQL.Add('TB'+ IntToStr(i) + '.ITE_ICMENT AS ITE_ICMENT' + IntToStr(i) + ',');
    qryItens.qryQuery.SQL.Add('TB'+ IntToStr(i) + '.ITE_SUBSTI AS ITE_SUBSTI' + IntToStr(i) + ',');

    qryItens.qryQuery.SQL.Add('ITEGER.ITE_PREVE' + IntToStr(i) + ' AS ITE_PREVEN' + IntToStr(i) + ',');
    qryItens.qryQuery.SQL.Add('ITEGER.ITE_PREVE' + IntToStr(i) + '/IF(IFNULL(FO' + IntToStr(i) + '.ITE_CNVCUS, 1) <=0 , 1, IFNULL(FO' + IntToStr(i) + '.ITE_CNVCUS, 1)) AS ITE_PREVEN_CNV' + IntToStr(i) + ',');
    qryItens.qryQuery.SQL.Add('ITEGER.ITE_MARBR' + IntToStr(i) + ' AS ITE_MARBRU' + IntToStr(i) + ',');

    qryItens.qryQuery.SQL.Add('TB'+ IntToStr(i) + '.ITE_PRECOM AS ORI_ITE_PRECOM' + IntToStr(i) + ',');
    qryItens.qryQuery.SQL.Add('TB'+ IntToStr(i) + '.ITE_PRECOM as ITE_PRECOM' + IntToStr(i) + ',');


    qryItens.qryQuery.SQL.Add('TB'+ IntToStr(i) + '.ITE_DESF01 AS ITE_DESF01' + IntToStr(i) + ',');
    qryItens.qryQuery.SQL.Add('TB'+ IntToStr(i) + '.ITE_DESF02 AS ITE_DESF02' + IntToStr(i) + ',');
    qryItens.qryQuery.SQL.Add('TB'+ IntToStr(i) + '.ITE_DESF03 AS ITE_DESF03' + IntToStr(i) + ',');
    qryItens.qryQuery.SQL.Add('TB'+ IntToStr(i) + '.ITE_DESF04 AS ITE_DESF04' + IntToStr(i) + ',');
    qryItens.qryQuery.SQL.Add('TB'+ IntToStr(i) + '.ITE_DESF05 AS ITE_DESF05' + IntToStr(i) + ',');
    qryItens.qryQuery.SQL.Add('TB'+ IntToStr(i) + '.ITE_DESF06 AS ITE_DESF06' + IntToStr(i) + ',');


    qryItens.qryQuery.SQL.Add(' TB'+ IntToStr(i) + '.ITE_PRECOM * ');
    qryItens.qryQuery.SQL.Add('  ( 1 - (TB'+ IntToStr(i) + '.ITE_DESF01 / 100) ) * ');
    qryItens.qryQuery.SQL.Add('  ( 1 - (TB'+ IntToStr(i) + '.ITE_DESF02 / 100) ) * ');
    qryItens.qryQuery.SQL.Add('  ( 1 - (TB'+ IntToStr(i) + '.ITE_DESF03 / 100) ) * ');
    qryItens.qryQuery.SQL.Add('  ( 1 - (TB'+ IntToStr(i) + '.ITE_DESF04 / 100) ) * ');
    qryItens.qryQuery.SQL.Add('  ( 1 - (TB'+ IntToStr(i) + '.ITE_DESF05 / 100) ) * ');
    qryItens.qryQuery.SQL.Add('  ( 1 - (TB'+ IntToStr(i) + '.ITE_DESF06 / 100) ) AS ITE_COMLIQ'+ IntToStr(i) + ',');


    qryItens.qryQuery.SQL.Add('ITEGER.ITE_PREVE' + IntToStr(i) + ' AS ORI_ITE_PREVEN' + IntToStr(i) + ',');
    qryItens.qryQuery.SQL.Add('ITEGER.ITE_MARBR' + IntToStr(i) + ' AS ORI_ITE_MARBRU' + IntToStr(i) + ',');

    qryItens.qryQuery.SQL.Add('TB'+ IntToStr(i) + '.ITE_PREDOL AS ITE_PREDOL' + IntToStr(i) + ',');
    qryItens.qryQuery.SQL.Add('TB'+ IntToStr(i) + '.ITE_CODTAB AS CODTAB' + IntToStr(i) + ',');
    qryItens.qryQuery.SQL.Add('TB'+ IntToStr(i) + '.AUTOINCREM AS INCDET' + IntToStr(i) + ',');
    qryItens.qryQuery.SQL.Add('TB'+ IntToStr(i) + '.ITE_PREREV AS ITE_PREREV' + IntToStr(i) + ',');

    if blnSufram and (strFrmCus = '4') then
    begin
      qryItens.qryQuery.SQL.Add('TB'+ IntToStr(i) + '.ITE_TCIFCU AS ITE_TCIFCU' + IntToStr(i) + ',');
      qryItens.qryQuery.SQL.Add('TB'+ IntToStr(i) + '.ITE_TSCUST AS ITE_TSCUST' + IntToStr(i) + ',');
      qryItens.qryQuery.SQL.Add('TB'+ IntToStr(i) + '.ITE_DEPICO AS ITE_DEPICO' + IntToStr(i) + ',');
      qryItens.qryQuery.SQL.Add('TB'+ IntToStr(i) + '.ITE_DEICMS AS ITE_DEICMS' + IntToStr(i) + ',');
      qryItens.qryQuery.SQL.Add('TB'+ IntToStr(i) + '.ITE_FATREG AS ITE_FATREG' + IntToStr(i) + ',');
    End;
    qryItens.qryQuery.SQL.Add('TB'+ IntToStr(i) + '.ITE_COMTBL AS ITE_COMTBL' + IntToStr(i) + ',');

  End;


  qryItens.qryQuery.SQL.Add(' ITEGER.ITE_PRECOM * ');
  qryItens.qryQuery.SQL.Add('  ( 1 - (ITEGER.ITE_DESF01 / 100) ) * ');
  qryItens.qryQuery.SQL.Add('  ( 1 - (ITEGER.ITE_DESF02 / 100) ) * ');
  qryItens.qryQuery.SQL.Add('  ( 1 - (ITEGER.ITE_DESF03 / 100) ) * ');
  qryItens.qryQuery.SQL.Add('  ( 1 - (ITEGER.ITE_DESF04 / 100) ) * ');
  qryItens.qryQuery.SQL.Add('  ( 1 - (ITEGER.ITE_DESF05 / 100) ) * ');
  qryItens.qryQuery.SQL.Add('  ( 1 - (ITEGER.ITE_DESF06 / 100) ) AS ITE_COMLIQ ');


  qryItens.qryQuery.SQL.Add('  FROM CADITE');
  qryItens.qryQuery.SQL.Add('       INNER JOIN CADFOR F ON F.FOR_CODFOR = CADITE.ITE_CODFOR ');
    qryItens.qryQuery.SQL.Add('  LEFT JOIN CADCID C ON C.CID_CODCID = F.FOR_CODCID');
  qryItens.qryQuery.SQL.Add(' INNER JOIN ITEGER ON ITEGER.ITE_CODITE = CADITE.ITE_CODITE');

  For i := 1 To 7 Do
  begin
    qryItens.qryQuery.SQL.Add('  LEFT JOIN TABDET TB' + IntToStr(i) + ' ON TB' + IntToStr(i) + '.ITE_CODTAB = ITE_TABPR' + IntToStr(i) +
                                                            ' AND TB' + IntToStr(i) + '.ITE_CODEMP = ITEGER.ITE_CODEMP ' +
                                                            ' AND TB' + IntToStr(i) + '.ITE_CODITE = ITEGER.ITE_CODITE ');
    qryItens.qryQuery.SQL.Add('  LEFT JOIN DETCUS DC'+IntToStr(i)+' ON DC'+IntToStr(i)+'.DET_SEQDET = TB' + IntToStr(i) + '.AUTOINCREM AND DC'+IntToStr(i)+'.DET_TABELA = ' + IntToStr(i));

    qryItens.qryQuery.SQL.Add('  LEFT JOIN CADFOR F' + IntToStr(i) + ' ON F' + IntToStr(i) + '.FOR_CODFOR = TB' + IntToStr(i) + '.ITE_CODFOR');
    qryItens.qryQuery.SQL.Add('  LEFT JOIN ITEFOR FO' + IntToStr(i) + ' ON FO' + IntToStr(i) + '.ITE_CODITE = TB' + IntToStr(i) + '.ITE_CODITE AND FO' + IntToStr(i) + '.ITE_CODTAB = TB' + IntToStr(i) + '.ITE_CODTAB');
    qryItens.qryQuery.SQL.Add('  LEFT JOIN CADCID C' + IntToStr(i) + ' ON C' + IntToStr(i) + '.CID_CODCID = F' + IntToStr(i) + '.FOR_CODCID');

  End;
    qryItens.qryQuery.SQL.Add('WHERE TRUE ');


  pMontaWherepCarregaItens;

  qryItens.qryQuery.SQL.Add('   ORDER BY ITEGER.ITE_CODITE, ITEGER.ITE_CODEMP');
  qryItens.fAbreClient(False, '[TCalculaComposicaoCusto.pCarregaItens]');
end;

procedure TCalculaComposicaoCusto.pMontaLinhaFiltroGeral(strTabela: string);
begin
  If strTabela = '1' then
    qryItens.qryQuery.SQL.Add('(');

  If Not fEmptyStr(FCodAbf) Then
    qryItens.qryQuery.SQL.Add(' (TB'+strTabela+'.ITE_CODABF = "'+FCodAbf+'"' + IIf(fEmptyStr(FstrCodTab), ')', ' AND '));
  If Not fEmptyStr(FstrCodTab) Then
    qryItens.qryQuery.SQL.Add(IIf(fEmptyStr(FCodAbf), '(', '') + ' TB'+strTabela+'.ITE_CODTAB = "'+FStrCodTab+'")');
  If strTabela = '7' then
    qryItens.qryQuery.SQL.Add(')')
  Else
    qryItens.qryQuery.SQL.Add(' OR ');
End;

procedure TCalculaComposicaoCusto.pMontaWherepCarregaItens;
begin
  If OrigemCalculo = tocPadrao then
  begin
    qryItens.qryQuery.SQL.Add('AND (TB1.ITE_CODABF = "'+FCodAbf+'"');
    qryItens.qryQuery.SQL.Add('   OR TB2.ITE_CODABF = "'+FCodAbf+'"');
    qryItens.qryQuery.SQL.Add('   OR TB3.ITE_CODABF = "'+FCodAbf+'"');
    qryItens.qryQuery.SQL.Add('   OR TB4.ITE_CODABF = "'+FCodAbf+'"');
    qryItens.qryQuery.SQL.Add('   OR TB5.ITE_CODABF = "'+FCodAbf+'"');
    qryItens.qryQuery.SQL.Add('   OR TB6.ITE_CODABF = "'+FCodAbf+'"');
    qryItens.qryQuery.SQL.Add('   OR TB7.ITE_CODABF = "'+FCodAbf+'")');
  End
  Else If OrigemCalculo = tocCalcGeral Then
  begin
    if not (fEmptyStr(FCodAbf) and  fEmptyStr(FstrCodTab)) Then
    Begin
      qryItens.qryQuery.SQL.Add('AND ');
      pMontaLinhaFiltroGeral('1');
      pMontaLinhaFiltroGeral('2');
      pMontaLinhaFiltroGeral('3');
      pMontaLinhaFiltroGeral('4');
      pMontaLinhaFiltroGeral('5');
      pMontaLinhaFiltroGeral('6');
      pMontaLinhaFiltroGeral('7');
    End;
  End;
  If OrigemCalculo in [tocCadEmpresa, tocCalcGeral] then
    qryItens.qryQuery.SQL.Add(' AND ITEGER.ITE_CODEMP  IN('+fStringSQLLocateToStringSQLIN(cdsEmpresas.FieldByname('EMP_UTIPRECO').AsString)+')');

End;



procedure TCalculaComposicaoCusto.pAtualizaBancoDeDados(blnSemAtivo: Boolean);
begin
  pCriarFormularios(TfrmGravando, frmReprocessaItens);
  Try
    frmReprocessaItens.lblGravando.Caption := 'Atualizando banco de dados, aguarde...';
    If blnSemAtivo Then
      frmReprocessaItens.fExecutarAcao := fAtualizaBancoDeDadosSemAtivo
    Else
      frmReprocessaItens.fExecutarAcao := fAtualizaBancoDeDados;

    frmReprocessaItens.ShowModal;
  Finally
    FreeAndNil(frmReprocessaItens);
  End;
end;

procedure TCalculaComposicaoCusto.pProcessaItensSemTabelaPrecoAtivo;
begin
  pCriarFormularios(TfrmGravando, frmReprocessaItens);
  Try
    frmReprocessaItens.lblGravando.Caption := 'Calculando itens sem Preço Ativo, aguarde...';
    frmReprocessaItens.fExecutarAcao := fProcessaItemSemTabelaPrecoAtivo;
    frmReprocessaItens.ShowModal;
  Finally
    FreeAndNil(frmReprocessaItens);
  End;
end;


procedure TCalculaComposicaoCusto.pProcessaItens;
begin
  pCriarFormularios(TfrmGravando, frmReprocessaItens);
  Try
    frmReprocessaItens.lblGravando.Caption := 'Calculando itens com Preço Ativo, aguarde...';
    frmReprocessaItens.fExecutarAcao := fProcessaItem;
    frmReprocessaItens.ShowModal;
  Finally
    FreeAndNil(frmReprocessaItens);
  End;
end;

end.
