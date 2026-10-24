unit untDisparaSMSAut;

interface

uses Windows, Classes, StrUtils, SysUtils, Controls, Uni, UniClientDataSet, UniDataSetProvider, DB,
     EditFocus, Forms, Variants, StdCtrls, untFuncoesSimples, untTypesSistema, MemData, JPeg,
     DateUtils, System.RegularExpressions;

Type
  TtpGatilho = (gatCfg, gatCtt);

  TSMSAut = Class(TComponent)

    private
      qryGeneric: TUniQuery;
      FCidPed: String;
      FUF_Ped: String;
      FEndPed: String;
      FBaiPed: String;
      FComPed: String;
      FRefEnd: String;
      FCepPed: String;

      procedure pSetaVariaveisDoModeloEmail;
      procedure pCarregaCodigosDoModelo;
      procedure pCarregaModeloSMS;
      procedure pCarregaModeloWPP;
      procedure pSetaDados;
      function  fRetornaStatusParaSMS: TStatusDisparaEmail;
      function  fAcertaVariaveisModelo(strModTmp: String): String;
      function  fRetornaTransportadoraDocumento: String;
      function  fRetPrevisaoDoHorarioDeChegada: String;
      function  fRetMensagemOcorrenciaDeEntrega: String;
      function  fRetDataHoraEntregue: String;
      procedure pRetInformacoesGeraisRomaneio;
      function  fRetLinkPagamento: String;
      function  fEhTransformacaoDe_OR_Em_PD: Boolean;
      function  fEhPedidoSendoGravadoPelaRotinaDeOrcamento: Boolean;
      function fEhPedidoSendoGravadoPelaRotinaDeVendaNormal: Boolean;
      procedure pInformacoesDoServico;
      procedure pInformacoesCashback;
      function fEhPesquisaDeSatisfacao: Boolean;
      procedure pInformacoesIntelipost;

      function fOperadorTemPermissaoDeAcessoParaDispararGatilho: Boolean;

      function fTemAnexoNoModelo: Boolean;
      function fGatilhoComControleDeHorarioDeDisparo: Boolean;

      function fRetVariaveisApiOficial(AStr: String): String;

      procedure pCarregaInformacoesDocumentoFiscal;

      procedure pCarregaInformacoesDoProduto;
      procedure pCarregaEnderecoPedido(ANumDoc, AEspDoc, AEmpDoc, ACodCli: String);
    Public
      FFrom: String;
      FTo: String;
      FSchedule: String;
      FMsg: String;
      FCallbackOption: String;
      FId: String;
      FAggregatedId: String;

      FCodCli: String;
      FNomCli: String;
      FPriCli: String;
      FCidCli: String;
      FOrcVen: String;
      FPedVen: String;
      FDocVen: String;
      FNroVen: String;
      FEmpVen: String;
      FEspVen: String;
      FTransp: String;
      FCodigo: String;
      FCodGru: String;
      FOpcDoc: String;
      FEspOrc: String;
      FEspDoc: String;
      FNumDoc: String;
      FNumOrc: String;
      FEmpDoc: String;
      FEmpOri: String;
      FLinDig: String;
      FEmaCob: String;
      FDtaEmi: String;
      FValDup: String;
      FParcel: String;
      FDtaVen: String;
      FCodRas: String;

      FPedCom: String;
      FEspCom: String;
      FEmpCom: String;
      FEmpDes: String;
      FTotCom: String;
      FDtaEnt: String;
      FCodFor: String;
      FRazFor: String;
      FFanFor: String;
      FCGCFor: String;

      FLinkDoBoleto: String;

      FCupDes: String;
      FTotCup: String;
      FInfCup: String;
      FCodCup: String;

      FQrCodePix: String;
      FLinkPagamento: String;

      FPreChe: String;
      FMsgOco: String;
      FDtaCon: String;
      FLnkPag: String;

      FStatus: TStatusDisparaEmail;
      FAssincrono: Boolean;

      FWhatsApp: Boolean;
      FIDFila: String;
      FApiKey: String;

      FEnvDoc: Boolean;
      FArquiv: TArray<TRecArquivosGatilhos>;

      FAutInc: String;

      FFisAce: String;
      FSerie_: String;

      FAutIncCtt: String;
      FAbreTelaEscolherContato: Boolean;

      FNomGat: String;
      FUntDis: String;

      FCodVen: String;
      FVendedor: String;
      FNomeCompletoVendedor: String;
      FContatoVendedor: String;

      FEnviaModal: Boolean;

      FAutIncNotfic : String;

      FNumeOS: String;

      FValorOrcamento: String;
      FDataDeCadastro: String;
      FTelefoneCliente: String;

      FValorPedido: String;

      FCodSer: String;
      FDesSer: String;
      FPlaVei: String;
      FMsgSta: String;
      FModVei: String;
      FStaSer: String;

      FNumCsh: String;
      FDtaCsh: String;
      FVlrCsh: String;
      FDtaVal: String;
      FTotDsp: String;

      FStaEnt: String;
      FDesEnt: String;
      FLikRas: String;

      FInfAdi: String;

      FDiasVencimento: String;

      FCodOpe: String;

      FNomLoj: String;

      FVarsData: String;
      FTemplateID: Integer;

      FCgcEmp: String;
      FCgcCli: String;
      FHorEmi: String;
      FEndEmp: String;
      FEndCli: String;

      FCodIte: String;
      FNomIte: String;

      FNomMot: String;

      function fTemModeloAtivo(AblnEhApenasVerificacaoSeModeloEstaAtivado: Boolean = False): Boolean;
      function fTemModeloAtivoSms: Boolean;
      function fTemModeloAtivoWpp(tpGatilho: TtpGatilho = gatCfg; AblnEhApenasVerificacaoSeModeloEstaAtivado: Boolean = False): Boolean;
      function fEnviaArquivo: Boolean;
      function fEnviaArquivoXML: Boolean;
      function fEnviaSMSAutomatico(blnEnviar: Boolean = True): Boolean;
      function fGetApiKey: String;

      Constructor Create(Owner: TComponent); override;
      Destructor  Destroy; override;
    published
      property strFrom: String           Read FFrom           Write FFrom;
      property strTo: String             Read FTo             Write FTo;
      property strSchedule: String       Read FSchedule       Write FSchedule;
      property strMsg: String            Read FMsg            Write FMsg;
      property strCallbackOption: String Read FCallbackOption Write FCallbackOption;
      property strId: String             Read FId             Write FId;
      property strAggregatedId: String   Read FAggregatedId   Write FAggregatedId;

      property strCodCli: String  Read FCodCli Write FCodCli;
      property strNomCli: String  Read FNomCli Write FNomCli;
      property strPriCli: String  Read FPriCli Write FPriCli;
      property strCidCli: String  Read FCidCli Write FCidCli;
      property strOrcVen: String  Read FOrcVen Write FOrcVen;
      property strPedVen: String  Read FPedVen Write FPedVen;
      property strDocVen: String  Read FDocVen Write FDocVen;
      property strNroVen: String  Read FNroVen Write FNroVen;
      property strEspVen: String  Read FEspVen Write FEspVen;
      property strEmpVen: String  Read FEmpVen Write FEmpVen;
      property strTransp: String  Read FTransp Write FTransp;
      property strCodigo: String  Read FCodigo Write FCodigo;
      property strCodGru: String  Read FCodGru Write FCodGru;
      property strOpcDoc: String  Read FOpcDoc Write FOpcDoc;
      property strEspOrc: String  Read FEspOrc Write FEspOrc;
      property strEspDoc: String  Read FEspDoc Write FEspDoc;
      property strNumDoc: String  Read FNumDoc Write FNumDoc;
      property strNumOrc: String  Read FNumOrc Write FNumOrc;
      property strEmpDoc: String  Read FEmpDoc Write FEmpDoc;
      property strEmpOri: String  Read FEmpOri Write FEmpOri;
      property strLinDig: String  Read FLinDig Write FLinDig;
      property strEmaCob: String  Read FEmaCob Write FEmaCob;
      property strDtaEmi: String  Read FDtaEmi Write FDtaEmi;
      property strValDup: String  Read FValDup Write FValDup;
      property strParcel: String  Read FParcel Write FParcel;
      property strDtaVen: String  Read FDtaVen Write FDtaVen;
      property strCodCup: String  Read FCodCup Write FCodCup;

      property staStatus: TStatusDisparaEmail Read FStatus Write FStatus;
      property blnAssincrono: Boolean read FAssincrono write FAssincrono default True;
      property strLinkDoBoleto: String  Read FLinkDoBoleto Write FLinkDoBoleto;

      property QrCodePix: String Read FQrCodePix Write FQrCodePix;
      property LinkPgamento: String Read FLinkPagamento write FLinkPagamento;

      property blnWhatsApp: Boolean read FWhatsApp write FWhatsApp;
      property strIDFila: String read FIDFila write FIDFila;
      property strApiKey: String read fGetApiKey write FApiKey;
      property blnEnvDoc: Boolean read FEnvDoc write FEnvDoc;

      property DiasVencimento: String read FDiasVencimento write FDiasVencimento;

      property strPreChe: String read FPreChe write FPreChe;
      property strMsgOco: String read FMsgOco write FMsgOco;
      property strDtaCon: String read FDtaCon write FDtaCon;
      property strLnkPag: String read FLnkPag write FLnkPag;
      property strAutIncCtt: String read FAutIncCtt write FAutIncCtt;
      property blnAbreTelaEscolherContato: Boolean read FAbreTelaEscolherContato write FAbreTelaEscolherContato;
      property strNomGat: String read FNomGat write FNomGat;
      property strFrmDis: String read FUntDis write FUntDis;
      property strNomVen: String  Read FVendedor Write FVendedor;

      property strPedCom: String  Read FPedCom Write FPedCom;
      property strEspCom: String  Read FEspCom Write FEspCom;
      property strEmpCom: String  Read FEmpCom Write FEmpCom;
      property strEmpDes: String  Read FEmpDes Write FEmpDes;
      property strTotCom: String  Read FTotCom Write FTotCom;
      property strDtaEnt: String  Read FDtaEnt Write FDtaEnt;
      property strCodFor: String  Read FCodFor Write FCodFor;
      property strRazFor: String  Read FRazFor Write FRazFor;
      property strFanFor: String  Read FFanFor Write FFanFor;
      property strCGCFor: String  Read FCGCFor Write FCGCFor;

      property EnviaModal: Boolean read FEnviaModal write FEnviaModal;

      property strAutIncNotfic: String Read FAutIncNotfic Write FAutIncNotfic;

      property strNumeOS: String Read FNumeOS Write FNumeOS;

      property strNumCsh: String read FNumCsh write FNumCsh;
      property strDtaCsh: String read FDtaCsh write FDtaCsh;
      property strVlrCsh: String read FVlrCsh write FVlrCsh;
      property strDtaVal: String read FDtaVal write FDtaVal;
      property strTotDsp: String read FTotDsp write FTotDsp;

      property strNomLoj: String read FNomLoj write FNomLoj;

      property strInfAdi: String Read FInfAdi Write FInfAdi;

      property strCodIte: String read FCodIte write FCodIte;
      property strNomIte: String read FNomIte write FNomIte;
  End;

implementation

{ TSMSAut }

uses untConstantes, untTEnvioSMS, untTCuttly, untFuncoesGenerica, untIntelipost.webhook,
  untDadosEnviaGatilhoSms, untDadosEnviaGatilhoWhatsapp, untDllGatIme;

function TSMSAut.fGetApiKey: String;
begin
  if fEmptyStr(FApiKey) then
    FApiKey := fCampoTabela('FIL_KEYAPI', 'CADFIL', ['FIL_IDFILA'], [FIDFila]);

  Result := FApiKey;
end;

function TSMSAut.fOperadorTemPermissaoDeAcessoParaDispararGatilho: Boolean;
begin
  Result := True;

  if VS_AutcomIniciadoModoRobo then
    Exit;

  if MatchStr(Concat(FCodGru, FCodigo),
                     ['001001', '001002', '001003', '001004', '001005', '001006', '001007', '001008', //Orçamentos
                     '002001', '002002', '002003', '002004', '002005', '002006', '002007', '002008', '002009'] // Pedidos
             ) then
    Result := fVerificaAcessoSistema('PERWPP', strLoginUsuarioLogado);
end;

constructor TSMSAut.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  qryGeneric := fCriaQuery(Self);

  FFrom := fCfgSis('REMSMS', varString);
  FTo := '';
  FSchedule := '';
  FMsg := '';
  FCallbackOption := 'NONE';
  FId := '';
  FAggregatedId := '';
  FAssincrono := True;
  FAutIncCtt := EmptyStr;
  FIDFila := EmptyStr;
  FUntDis := EmptyStr;
  FNomGat := EmptyStr;
  FAbreTelaEscolherContato := (fCfgSis('EXITWP') = 'S') And (Not VS_AutcomIniciadoModoRobo);
  FNumeOS := EmptyStr;
  FLnkPag := EmptyStr;
  FNumCsh := EmptyStr;
  FDtaCsh := EmptyStr;
  FVlrCsh := EmptyStr;
  FDtaVal := EmptyStr;
  FTotDsp := EmptyStr;
  FEnviaModal := False;
  FVarsData := EmptyStr;
  FTemplateID := 0;

  FCidPed := EmptyStr;
  FUF_Ped := EmptyStr;
  FEndPed := EmptyStr;
  FBaiPed := EmptyStr;
  FComPed := EmptyStr;
  FRefEnd := EmptyStr;
  FCepPed := EmptyStr;
end;

destructor TSMSAut.Destroy;
begin
  FreeAndNil(qryGeneric);

  inherited destroy;
end;

function TSMSAut.fRetVariaveisApiOficial(AStr: String): String;
var
  Match: TMatch;
begin
  Result := EmptyStr;

  AStr := AnsiReplaceStr(AStr, '&lt;&lt;', '<<');
  AStr := AnsiReplaceStr(AStr, '&gt;&gt;', '>>');
  AStr := AnsiReplaceStr(AStr, STRING_QUEBRA, STRING_ENTER);

  Match := TRegEx.Match(AStr, '<<.*?>>');
  while Match.Success do
  begin
    Result := Result + fAcertaVariaveisModelo(Match.Value) + '_';
    Match := Match.NextMatch;
  end;
end;

function TSMSAut.fAcertaVariaveisModelo(strModTmp: String): String;
Var
  intContador: Integer;
  strNomTag: String;
begin

  Result := strModTmp;
  Result := AnsiReplaceStr(Result, '&lt;&lt;', '<<');
  Result := AnsiReplaceStr(Result, '&gt;&gt;', '>>');

  For IntContador := 0 To Length(arrVarEma) - 1 Do
  Begin
    strNomTag := arrVarEma[intContador][0];

    If (Pos(strNomTag, Result) > 0) Then
    Begin
      If (arrVarEma[intContador][0] =  '<<NOMCLI>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FNomCli)
      Else If (arrVarEma[intContador][0] = '<<PRICLI>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FPriCli)
      Else If (arrVarEma[intContador][0] = '<<CIDCLI>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FCidCli)
      Else If (arrVarEma[intContador][0] = '<<ORCVEN>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FOrcVen)
      Else If (arrVarEma[intContador][0] = '<<PEDVEN>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FPedVen)
      Else If (arrVarEma[intContador][0] = '<<DOCVEN>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FDocVen)
      Else If (arrVarEma[intContador][0] = '<<TRANSP>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FTransp)
      Else If (arrVarEma[intContador][0] = '<<NROVEN>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FNroVen)
      Else If (arrVarEma[intContador][0] = '<<EMPVEN>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FEmpVen)
      Else If (arrVarEma[intContador][0] = '<<ESPVEN>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FEspVen)
      Else If (arrVarEma[intContador][0] = '<<LINDIG>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FLinDig)
      Else If (arrVarEma[intContador][0] = '<<EMACOB>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FEmaCob)
      Else If (arrVarEma[intContador][0] = '<<DTAEMI>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FDtaEmi)
      Else If (arrVarEma[intContador][0] = '<<VALDUP>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FValDup)
      Else If (arrVarEma[intContador][0] = '<<PARCEL>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FParcel)
      Else If (arrVarEma[intContador][0] = '<<VALPED>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FValorPedido)
      Else If (arrVarEma[intContador][0] = '<<DTAVEN>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FDtaVen)
      Else If (arrVarEma[intContador][0] = '<<LNKBOL>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], TCuttly.EncurtarLinkDoBoleto(FLinkDoBoleto))
      Else If (arrVarEma[intContador][0] = '<<CUPDES>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FCupDes)
      Else If (arrVarEma[intContador][0] = '<<TOTCUP>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FTotCup)
      Else If (arrVarEma[intContador][0] = '<<INFCUP>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FInfCup)
      Else If (arrVarEma[intContador][0] = '<<QRCODE>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FQrCodePix)
      Else If (arrVarEma[intContador][0] = '<<LNKPGT>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FLinkPagamento)
      Else If (arrVarEma[intContador][0] = '<<PRECHE>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FPreChe)
      Else If (arrVarEma[intContador][0] = '<<MSGOCO>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FMsgOco)
      Else If (arrVarEma[intContador][0] = '<<DTACON>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FDtaCon)
      Else If (arrVarEma[intContador][0] = '<<LNKPAG>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FLnkPag)
      Else If (arrVarEma[intContador][0] = '<<NOMVEN>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FVendedor)
      Else If (arrVarEma[intContador][0] = '<<NUMEOS>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FNumeOS)
      Else If (arrVarEma[intContador][0] = '<<VALORC>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FValorOrcamento)
      Else If (arrVarEma[intContador][0] = '<<DTACAD>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FDataDeCadastro)
      Else If (arrVarEma[intContador][0] = '<<TELCLI>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FTelefoneCliente)
      Else If (arrVarEma[intContador][0] = '<<CODSER>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FCodSer)
      Else If (arrVarEma[intContador][0] = '<<DESSER>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FDesSer)
      Else If (arrVarEma[intContador][0] = '<<PLAVEI>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FPlaVei)
      Else If (arrVarEma[intContador][0] = '<<MSGSTA>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FMsgSta)
      Else If (arrVarEma[intContador][0] = '<<MODVEI>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FModVei)
      Else If (arrVarEma[intContador][0] = '<<NOMCVE>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FNomeCompletoVendedor)
      Else If (arrVarEma[intContador][0] = '<<CONVEN>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FContatoVendedor)
      Else If (arrVarEma[intContador][0] = '<<NUMCSH>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FNumCsh)
      Else If (arrVarEma[intContador][0] = '<<DTACSH>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FDtaCsh)
      Else If (arrVarEma[intContador][0] = '<<VLRCSH>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FVlrCsh)
      Else If (arrVarEma[intContador][0] = '<<TOTDSP>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FTotDsp)
      Else If (arrVarEma[intContador][0] = '<<DTAVAL>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FDtaVal)
      Else If (arrVarEma[intContador][0] = '<<DIASVEN>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FDiasVencimento)
      Else If (arrVarEma[intContador][0] = '<<NOMLOJ>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FNomLoj)
      Else If (arrVarEma[intContador][0] = '<<STAENT>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FStaEnt)
      Else If (arrVarEma[intContador][0] = '<<DESENT>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FDesEnt)
      Else If (arrVarEma[intContador][0] = '<<LIKRAS>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FLikRas)
      Else If (arrVarEma[intContador][0] = '<<CGCEMP>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FCgcEmp)
      Else If (arrVarEma[intContador][0] = '<<CGCCLI>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FCgcCli)
      Else If (arrVarEma[intContador][0] = '<<SERIE_>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FSerie_)
      Else If (arrVarEma[intContador][0] = '<<ACESSO>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FFisAce)
      Else If (arrVarEma[intContador][0] = '<<HOREMI>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FHorEmi)
      Else If (arrVarEma[intContador][0] = '<<ENDEMP>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FEndEmp)
      Else If (arrVarEma[intContador][0] = '<<ENDCLI>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FEndCli)
      Else If (arrVarEma[intContador][0] = '<<CIDPED>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FCidPed)
      Else If (arrVarEma[intContador][0] = '<<UF_PED>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FUF_Ped)
      Else If (arrVarEma[intContador][0] = '<<COMPED>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FComPed)
      Else If (arrVarEma[intContador][0] = '<<ENDPED>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FEndPed)
      Else If (arrVarEma[intContador][0] = '<<REFEND>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FRefEnd)
      Else If (arrVarEma[intContador][0] = '<<CEPPED>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FCepPed)
      Else If (arrVarEma[intContador][0] = '<<BAIPED>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FBaiPed)
      Else If (arrVarEma[intContador][0] = '<<CODRAS>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FCodRas);
    End;
  End;

  Result := Result
    .Replace('<<PEDCOM>>', FPedCom)
    .Replace('<<ESPCOM>>', FEspCom)
    .Replace('<<EMPCOM>>', FEmpCom)
    .Replace('<<EMPDES>>', FEmpDes)
    .Replace('<<TOTCOM>>', FTotCom)
    .Replace('<<DTAENT>>', FDtaEnt)
    .Replace('<<CODFOR>>', FCodFor)
    .Replace('<<RAZFOR>>', FRazFor)
    .Replace('<<FANFOR>>', FFanFor)
    .Replace('<<CGCFOR>>', FCGCFor)
    .Replace('<<NOMITE>>', FNomIte)
    .Replace('<<CODITE>>', FCodIte)
    .Replace('<<NOMMOT>>', FNomMot);
end;

procedure TSMSAut.pCarregaEnderecoPedido(ANumDoc, AEspDoc, AEmpDoc, ACodCli: String);
var
  qryPedido : TUniQuery;
begin
  qryPedido := fCriaQuery(Self);
  try
    qryPedido.Close;
    qryPedido.SQL.Clear();
    qryPedido.SQL.Add(' SELECT ');
    qryPedido.SQL.Add('   COALESCE(EC.ETC_ENDENT, CA.CLI_ENDERE) AS ENDERECO, ');
    qryPedido.SQL.Add('   COALESCE(EC.ETC_BAIENT, CA.CLI_BAIRRO) AS BAIRRO, ');
    qryPedido.SQL.Add('   COALESCE(EC.ETC_CEPENT, CA.CLI_C_E_P_) AS CEP, ');
    qryPedido.SQL.Add('   COALESCE(EC.ETC_REFENT, "") AS REFERENCIA, ');
    qryPedido.SQL.Add('   COALESCE(EC.ETC_ENDCOM, CA.CLI_ENDCOM) AS COMPLEMENTO, ');
    qryPedido.SQL.Add('   COALESCE(EC.ETC_CIDENT, CA.CLI_CODCID) AS CODCID, ');
    qryPedido.SQL.Add('   COALESCE(CC.CID_NOMCID, CM.CID_NOMCID) AS CIDADE, ');
    qryPedido.SQL.Add('   COALESCE(CC.CID_ESTADO, CM.CID_ESTADO) AS ESTADO ');
    qryPedido.SQL.Add(' FROM ');
    qryPedido.SQL.Add('   FATGOR FG ');
    qryPedido.SQL.Add('   INNER JOIN CADCLI CA ');
    qryPedido.SQL.Add('     ON (FG.FGO_CODCLI = CA.CLI_CODCLI) ');
    qryPedido.SQL.Add('   INNER JOIN AUXGOR AG ');
    qryPedido.SQL.Add('     ON (FG.AUTOINCREM = AG.AUX_SEQGER) ');
    qryPedido.SQL.Add('   LEFT JOIN ENTCLI EC ');
    qryPedido.SQL.Add('     ON (AG.AUX_ENTGER = EC.AUTOINCREM) ');
    qryPedido.SQL.Add('   LEFT JOIN CADCID CC ');
    qryPedido.SQL.Add('     ON (EC.ETC_CIDENT = CC.CID_CODCID) ');
    qryPedido.SQL.Add('   LEFT JOIN CADCID CM ');
    qryPedido.SQL.Add('     ON (CA.CLI_CODCID = CM.CID_CODCID) ');
    qryPedido.SQL.Add(' WHERE FG.FGO_NUMDOC = :NUMDOC ');
    qryPedido.SQL.Add('   AND FG.FGO_ESPDOC = :ESPDOC ');
    qryPedido.SQL.Add('   AND FG.FGO_CODEMP = :CODEMP ');
    qryPedido.SQL.Add('   AND FG.FGO_CODCLI = :CODCLI ');
    qryPedido.ParamByName('NUMDOC').AsString := ANumDoc;
    qryPedido.ParamByName('ESPDOC').AsString := AEspDoc;
    qryPedido.ParamByName('CODEMP').AsString := AEmpDoc;
    qryPedido.ParamByName('CODCLI').AsString := ACodCli;
    qryPedido.Open();

    if (not qryPedido.IsEmpty) then
    begin
      FCidPed := qryPedido.FieldByName('CIDADE').AsString;
      FUF_Ped := qryPedido.FieldByName('ESTADO').AsString;
      FEndPed := qryPedido.FieldByName('ENDERECO').AsString;
      FBaiPed := qryPedido.FieldByName('BAIRRO').AsString;
      FComPed := qryPedido.FieldByName('COMPLEMENTO').AsString;
      FRefEnd := qryPedido.FieldByName('REFERENCIA').AsString;
      FCepPed := qryPedido.FieldByName('CEP').AsString;
    end;
  finally
    FreeAndNil(qryPedido);
  end;
end;

function TSMSAut.fEnviaArquivo: Boolean;
begin
  Result := FEnvDoc;
end;

function TSMSAut.fEnviaArquivoXML: Boolean;
begin
  Result := False;
end;

function TSMSAut.fEnviaSMSAutomatico(blnEnviar: Boolean): Boolean;
  Var
    DadosEnviaGatilhoWhatsapp: TDadosEnviaGatilhoWhatsapp;
    DadosEnviaGatilhoSms: TDadosEnviaGatilhoSms;

    intCount: Integer;
    arrCelular: TArray<String>;
    arrAutIncCtt: TArray<String>;
    arrFila: TArray<String>;

    LArquivo: TRecArquivosGatilhos;
begin

  Result := False;

  Try
    If fEmptyStr(FTo) Then
      Exit;

    arrCelular := FTo.Split(['_']);
    arrAutIncCtt := FAutIncCtt.Split(['_']);
    arrFila := FIDFila.Split(['_']);
    for intCount := 0 to High(arrCelular) do
    begin
      FTo := arrCelular[intCount];

      FAutIncCtt := EmptyStr;
      if Length(arrAutIncCtt) >= (intCount+1) then
        FAutIncCtt := IIF(arrAutIncCtt[intCount] = 'CLIENTE', EmptyStr, arrAutIncCtt[intCount]);

      FIDFila := EmptyStr;
      if Length(arrFila) >= (intCount+1) then
        FIDFila := arrFila[intCount];

      pSetaDados;
      if blnWhatsApp then
      begin
        pValidaProCod('WPPENV');
        pCarregaModeloWPP;
      end
      else
        pCarregaModeloSMS;

      If not blnEnviar Then
        Exit(True);

      for LArquivo in FArquiv do
      begin
        if (not fEhArquivoBase64(LArquivo.Arquivo)) and (not fArquivoExisteNoDiretorio(LArquivo.Arquivo, 40, 2000)) then
          Exit;
      end;

      if not blnWhatsApp then
      begin
        DadosEnviaGatilhoSms := TDadosEnviaGatilhoSms.Create;
        try
          DadosEnviaGatilhoSms.gatilho.schedule := Self.FSchedule;
          DadosEnviaGatilhoSms.gatilho.cgcEmp := fRetCGCEmpresa(VS_strCodEmp);
          DadosEnviaGatilhoSms.gatilho.utilizaIntegracaoMKON := fCfgSis('SMSMKM', varBoolean);
          DadosEnviaGatilhoSms.gatilho.nomeGatilho := FNomGat;
          DadosEnviaGatilhoSms.gatilho.codigoGrupo := FCodGru;
          DadosEnviaGatilhoSms.gatilho.codigoGatilho := FCodigo;
          DadosEnviaGatilhoSms.gatilho.numeroDocumento := FNumDoc;
          DadosEnviaGatilhoSms.gatilho.especieDocumento := FEspDoc;
          DadosEnviaGatilhoSms.gatilho.OpcDocumento := FOpcDoc;
          DadosEnviaGatilhoSms.gatilho.empresaDocumento := FEmpDoc;

          Result := TDllGatime
                      .fNew
                      .fGravarGatilhoImediato(TRecGatilhoImediato
                                                .Create(FNomGat,
                                                        FMsg,
                                                        nil,
                                                        DadosEnviaGatilhoSms.ToJsonString,
                                                        FCodOpe,
                                                        FTo,
                                                        EmptyStr)
                                              );


        finally
          FreeAndNil(DadosEnviaGatilhoSms);
        end;
      end
      else
      begin
        DadosEnviaGatilhoWhatsapp := TDadosEnviaGatilhoWhatsapp.Create;
        try
          DadosEnviaGatilhoWhatsapp.fila.id := FIDFila;
          DadosEnviaGatilhoWhatsapp.template.id := IntToStr(FTemplateID);
          DadosEnviaGatilhoWhatsapp.template.varsdata := FVarsData.Split(['_']);

          DadosEnviaGatilhoWhatsapp.outrasInformacoes.qrCodePix := FQrCodePix;

          DadosEnviaGatilhoWhatsapp.gatilho.nomeGatilho := FNomGat;
          DadosEnviaGatilhoWhatsapp.gatilho.unitDisparo := FUntDis;
          DadosEnviaGatilhoWhatsapp.gatilho.codigoGrupo := FCodGru;
          DadosEnviaGatilhoWhatsapp.gatilho.codigoGatilho := FCodigo;
          DadosEnviaGatilhoWhatsapp.gatilho.numeroDocumento := FNumDoc;
          DadosEnviaGatilhoWhatsapp.gatilho.especieDocumento := FEspDoc;
          DadosEnviaGatilhoWhatsapp.gatilho.OpcDocumento := FOpcDoc;
          DadosEnviaGatilhoWhatsapp.gatilho.empresaDocumento := FEmpDoc;

          DadosEnviaGatilhoWhatsapp.chavesPrimarias.autIncNotfic := FAutIncNotfic;

          Result := TDllGatime
                      .fNew
                      .fGravarGatilhoImediato(TRecGatilhoImediato
                                                .Create(FNomGat,
                                                        FMsg,
                                                        FArquiv,
                                                        DadosEnviaGatilhoWhatsapp.ToJsonString,
                                                        FCodOpe,
                                                        FTo,
                                                        EmptyStr)
                                              );
        finally
          FreeAndNil(DadosEnviaGatilhoWhatsapp);
        end;
      end;
    end;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TSMSAut.fEnviaSMSAutomatico]');
  End;

end;

procedure TSMSAut.pCarregaModeloSMS;
Var
  strSQL   : String;
begin

  Try

    strSQL := '';
    strSQL := strSQL + 'SELECT        ';
    strSQL := strSQL + '  MOD_MODELO, ';
    strSQL := strSQL + '  MODSMS.AUTOINCREM, ';
    strSQL := strSQL + '  SMS_DESCRI  ';
    strSQL := strSQL + 'FROM          ';
    strSQL := strSQL + '  SMSSAI      ';
    strSQL := strSQL + '  INNER JOIN MODSMS ON MOD_SEQGER = SMSSAI.AUTOINCREM ';
    strSQL := strSQL + 'WHERE        ';
    strSQL := strSQL + '  SMS_CODIGO = :CODIGO AND ';
    strSQL := strSQL + '  SMS_CODGRU = :CODGRU AND ';
    strSQL := strSQL + '  SMS_CODEMP = :CODEMP     ';

    With qryGeneric Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODIGO').AsString := FCodigo;
      ParamByName('CODGRU').AsString := FCodGru;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      FMsg := AnsiReplaceStr(fAcertaVariaveisModelo(FieldByName('MOD_MODELO').AsString), STRING_QUEBRA, STRING_ENTER);
      FNomGat := FieldByName('SMS_DESCRI').AsString;
    End;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TSMSAut.pCarregaModeloEmail]');
  End;

end;

procedure TSMSAut.pCarregaModeloWPP;
Var
  strSQL: String;
begin

  Try

    strSQL := '';
    strSQL := strSQL + 'SELECT        ';
    strSQL := strSQL + '  MOD_MODELO, ';
    strSQL := strSQL + '  MODWPP.AUTOINCREM, ';
    strSQL := strSQL + '  FIL_IDFILA, ';
    strSQL := strSQL + '  FIL_KEYAPI, ';
    strSQL := strSQL + '  WPP_DESCRI, ';
    strSQL := strSQL + '  MOD_TEMPID ';
    strSQL := strSQL + 'FROM          ';
    strSQL := strSQL + '  WPPSAI      ';
    strSQL := strSQL + '  INNER JOIN MODWPP ON WPPSAI.AUTOINCREM = MODWPP.MOD_SEQGER ';
    strSQL := strSQL + '  INNER JOIN CADFIL ON WPPSAI.WPP_SEQFIL = CADFIL.AUTOINCREM ';
    strSQL := strSQL + 'WHERE        ';
    strSQL := strSQL + '  WPP_CODIGO = :CODIGO AND ';
    strSQL := strSQL + '  WPP_CODGRU = :CODGRU AND ';
    strSQL := strSQL + '  WPP_CODEMP = :CODEMP     ';

    With qryGeneric Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL + IIF(not fEmptyStr(FAutIncCtt), ' AND WPP_SEQCTT = :SEQCTT ', ' AND WPP_SEQCTT IS NULL '));
      ParamByName('CODIGO').AsString := FCodigo;
      ParamByName('CODGRU').AsString := FCodGru;
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      if not fEmptyStr(FAutIncCtt) then
        ParamByName('SEQCTT').AsString := FAutIncCtt;

      Open;

      if (qryGeneric.IsEmpty) and (not fEmptyStr(FAutIncCtt)) then
      begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL + ' AND WPP_SEQCTT IS NULL ');
        ParamByName('CODIGO').AsString := FCodigo;
        ParamByName('CODGRU').AsString := FCodGru;
        ParamByName('CODEMP').AsString := VS_strCodEmp;

        Open;
      end;

      FMsg := AnsiReplaceStr(fAcertaVariaveisModelo(FieldByName('MOD_MODELO').AsString), STRING_QUEBRA, STRING_ENTER);
      FTemplateID := StrToIntDef(FieldByName('MOD_TEMPID').AsString, 0);
      FVarsData := fRetVariaveisApiOficial(FieldByName('MOD_MODELO').AsString);
      FNomGat := FieldByName('WPP_DESCRI').AsString;
      if (fEmptyStr(FIDFila)) or (FIDFila = '0') then
        FIDFila := FieldByName('FIL_IDFILA').AsString;
    End;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TSMSAut.pCarregaModeloWPP]');
  End;

end;

function TSMSAut.fEhPedidoSendoGravadoPelaRotinaDeOrcamento: Boolean;
begin
  Result := ((FEspDoc = 'PD') and (FOpcDoc = 'OR'));
end;

function TSMSAut.fEhPedidoSendoGravadoPelaRotinaDeVendaNormal: Boolean;
begin
  Result := ((FEspDoc = 'PD') and (FOpcDoc = 'VN'));
end;

function TSMSAut.fEhTransformacaoDe_OR_Em_PD: Boolean;
begin
  Result := ((FEspDoc = 'PD') and (FEspOrc = 'OR') and (not fEmptyStr(FNumOrc)));
end;

function TSMSAut.fRetornaStatusParaSMS: TStatusDisparaEmail;
begin
  Result := staNenhumaAcao;

  If ((FOpcDoc = 'OR') Or
      (FEspOrc = 'OR') Or
      (FEspDoc = 'OR')) And
     ((not fEhPedidoSendoGravadoPelaRotinaDeOrcamento) Or (fEhTransformacaoDe_OR_Em_PD)) Then
  Begin
    Result := staIncluindo;

    If (FEspDoc = 'OR') And (Not fEmptyStr(FNumOrc)) Then
      Result := staAlterando
    Else If (Pos(FEspDoc, 'OR_PD_') <= 0) And (Not fEmptyStr(FNumOrc)) Then
      Result := staFaturandoTotal
    Else If (FEspDoc = 'PD') Then
      Result := staTransformando
    Else If (FEspOrc = 'BX') Then
      Result := staBaixando
    Else If (FEspOrc = 'CN') Then
      Result := staCancelando
    Else If (FEspOrc = 'CR') Then
      Result := staConsultandoReimprimindo
    Else If (FEspOrc = 'EA') Then
      Result := staEnvioAgendado
    Else If (FEspOrc = 'A1') Then
      Result := staAberto1Dia
    Else If (FEspOrc = 'A2') Then
      Result := staAberto2Dias
    Else If (FEspOrc = 'A3') Then
      Result := staAberto3Dias;
  End

  Else If (FOpcDoc = 'CP') And (FEspOrc = 'FP') And (FEspDoc = 'PD') Then
  Begin
    Result := staFaturandoParcial;
  End

  Else If (FOpcDoc = 'PD') Or (fEhPedidoSendoGravadoPelaRotinaDeVendaNormal) Or (fEhPedidoSendoGravadoPelaRotinaDeOrcamento) Or ((FEspOrc = 'FT') And (Pos(FOpcDoc, 'E2_E3_E4_E5_') <= 0)) Then
  Begin
    Result := staIncluindo;

    If (FEspDoc = 'PD') And (Not fEmptyStr(FNumOrc)) Then
      Result := staAlterando
    Else If (FEspOrc = 'FT') Then
      Result := staFaturandoTotal
    Else If (FEspOrc = 'FP') Then
      Result := staFaturandoParcial
    Else If (FEspOrc = 'BX') Then
      Result := staBaixando
    Else If (FEspOrc = 'CN') Then
      Result := staCancelando
    Else If (FEspOrc = 'SE') Then
      Result := staImprimindoSeparacao
    Else If (FEspOrc = 'CR') Then
      Result := staConsultandoReimprimindo;
  End
  Else If (Pos(FOpcDoc, 'E2_E3_E4_') > 0) Then
  Begin
    Result := staNenhumaAcao;

    If (FOpcDoc = 'E2') Then
      Result := staIncluindo
    Else If (FOpcDoc = 'E3') Then
    Begin
      If (FEspOrc = 'SE') Then
        Result := staImprimindoSeparacao
      Else If (FEspOrc = 'FT') Then
        Result := staFaturandoTotal
      Else If (FEspOrc = 'FP') Then
        Result := staFaturandoParcial;
    End
    Else If (FOpcDoc = 'E4') Then
    Begin
      If (FEspOrc = 'SE') Then
        Result := staImprimindoSeparacao
      Else If (FEspOrc = 'CF') Then
        Result := staConferindo
      Else If (FEspOrc = 'FP') Then
        Result := staFaturandoParcial
      Else If (FEspOrc = 'FT') Then
        Result := staFaturandoTotal;
    End;
  End
  Else If (Pos(FOpcDoc, 'RI_RB_') > 0) Then
  Begin
    If (FOpcDoc = 'RI') Then
      Result := staIncluindo
    Else If (FOpcDoc = 'RB') Then
      Result := staBaixando;
  End
  Else If (FOpcDoc = 'E5') Then
  Begin
    If (FEspOrc = 'IN') Then
      Result := staIncluindo
    Else If (FEspOrc = 'SE') Then
      Result := staImprimindoSeparacao
    Else If (FEspOrc = 'CF') Then
      Result := staConferindo
    Else If (FEspOrc = 'FP') Then
      Result := staFaturandoParcial
    Else If (FEspOrc = 'FT') Then
      Result := staFaturandoTotal
    Else If (FEspOrc = 'AT') Then
      Result := staAtivando
    Else If (FEspOrc = 'BX') Then
      Result := staBaixando;
  End
  Else If (SameText(FOpcDoc, 'AC')) Then
    Result := FStatus
  Else If (SameText(FOpcDoc, 'PX')) Then
    Result := FStatus
  Else If (FOpcDoc = 'TE') Then
  Begin
    If (FEspOrc = 'RI') Then
      Result := staRotaIniciada
    Else
    If (FEspOrc = 'OE') Then
      Result := staOcorrenciaEntrega
    Else
    If (FEspOrc = 'EC') Then
      Result := staEntregaConcluida;
  End

  Else If (FOpcDoc = 'CB') Then
    Result := staCobrancaEletronica

  Else If (FOpcDoc = 'AN') Then
  Begin
    If (FEspDoc = 'NF') Then
    Begin
      If (FEspOrc = 'AT') Or (fEmptyStr(FEspOrc)) Then
        Result := staAutorizadaNFe
      Else If (FEspOrc = 'RI') Then
        Result := staReenvioNfeReimpressaoDocs
    End
    Else If (FEspDoc = 'IF') Then
    Begin
      If (FEspOrc = 'AT') Or (fEmptyStr(FEspOrc)) Then
        Result := staAutorizadaNFCe
      Else If (FEspOrc = 'RI') Then
        Result := staReenvioNfceReimpressaoDocs
    End
    Else If (FEspDoc = 'NS') Then
    Begin
      If (FEspOrc = 'AT') Or (fEmptyStr(FEspOrc)) Then
        Result := staAutorizadaNFSe;
    End;
  End

  Else If FOpcDoc = 'FF' Then
  Begin
    If (FEspOrc = 'IN') Or (fEmptyStr(FEspOrc)) Then
      Result := staIncluindo
    Else If (FEspOrc = 'RI') Then
      Result := staReenvioFFReimpressaoDocs;
  End

  Else If FOpcDoc = 'RC' Then
  Begin
    If blnWhatsApp Then
       Result := staReimpressaoCobranca;
  End

  Else If FOpcDoc = 'CE' Then
    Result := FStatus

  Else If (FOpcDoc = 'SE') Then
    Result := staAlterouStatusDoServico

  Else If FOpcDoc = 'AD' Then
  Begin
    Result := staNenhumaAcao;
    If StrToInt(FormatDateTime('dd', VS_Date)) > 15 Then
      Result := staAvisoDebitoDia16;
  End

  Else If FOpcDoc = 'CH' Then
  Begin
    If FEspOrc = '7A' Then
      Result := staCashback7DiasAVencer
    Else
      Result := staCashbackVenda;
  End

  Else If FOpcDoc = 'CL' Then
  Begin
    If FEspOrc = 'PS' then
      Result := staPesquisaSatisfacao
    Else If FEspOrc = 'CA' then
      Result := staClienteAniversariante;
  End

  Else If (FOpcDoc = 'AI') Then
  Begin
    If (FEspOrc = 'AS') Then
      Result := staAlteracaoStatusEntrega;
  End

  Else If (FOpcDoc = 'PR') Then
  Begin
    if FEspOrc = 'FP' then
      Result := staFotoProduto;
  End

  Else If (FOpcDoc = 'CF') Then
  Begin
    If (FEspOrc = 'PC') Then
      Result := staEnvioPixDupGeradaConfirmacao;
  End

  Else If (FOpcDoc = 'RE') Then
  Begin
    If (FEspOrc = 'ERC') Then
      Result := staEnvCodRastreioCorreio
    Else If (FEspOrc = 'ERA') Then
      Result := staEnvCodRastreioAcompanhamento;
  End;

end;

function TSMSAut.fRetornaTransportadoraDocumento: String;
Var
  qryTransp: TUniQuery;
  strSQL   : String;
  strTabela: String;
  strSigTab: String;

  procedure pDefineDadosTabela;
  Begin

    If (Pos(FEspDoc, 'PD_OR_') > 0) Then
    Begin
      strTabela := 'FATGOR';
      strSigTab := 'FGO_';
    End
    Else
    Begin
      strTabela := 'MOVGER';
      strSigTab := 'GER_';
    End;
  End;

  function fRetSQL: String;
  Var
    strSQL: String;
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CONCAT(TRA_CODTRA, "-", TRA_NOMTRA) AS TRANSP ';
    strSQL := strSQL + 'FROM                                            ';
    strSQL := strSQL +    strTabela;
    strSQL := strSQL + '  INNER JOIN CADTRA ON TRA_CODTRA = ' + strSigTab + 'CODTRA  ';
    strSQL := strSQL + 'WHERE                      ';
    strSQL := strSQL +    strSigTab + 'NUMDOC = :NUMDOC AND ';
    strSQL := strSQL +    strSigTab + 'ESPDOC = :ESPDOC AND ';
    strSQL := strSQL +    strSigTab + 'CODEMP = :CODEMP     ';
    Result := strSQL;
  End;
begin

  Result := '';
  pDefineDadosTabela;

  Try

    qryTransp := fCriaQuery(Self);
    strSQL := fRetSQL;

    If (Pos(FEspDoc, 'PD_OR_') <= 0) Then
      strSQL := strSQL + ' UNION ALL ' + AnsiReplaceStr(fRetSQL, 'MOVGER', 'NOTGER');

    With qryTransp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDOC').AsString := FNumDoc;
      ParamByName('ESPDOC').AsString := FEspDoc;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      Result := FieldByName('TRANSP').AsString;
    End;

  Finally
    FreeAndNil(qryTransp);
  End;

end;

function TSMSAut.fTemModeloAtivoSms: Boolean;
Var
  strSQL: String;
begin

  Result := False;
  pSetaDados;
  pCarregaCodigosDoModelo;

  Try

    strSQL := '';
    strSQL := strSQL + 'SELECT       ';
    strSQL := strSQL + '  SMS_CODIGO ';
    strSQL := strSQL + 'FROM         ';
    strSQL := strSQL + '  SMSSAI     ';
    strSQL := strSQL + 'WHERE        ';
    strSQL := strSQL + '  SMS_CODIGO = :CODIGO AND ';
    strSQL := strSQL + '  SMS_CODGRU = :CODGRU AND ';
    strSQL := strSQL + '  SMS_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  SMS_STATUS = "A"         ';

    qryGeneric.Close;
    qryGeneric.SQL.Clear;
    qryGeneric.SQL.Add(strSQL);

    If (MatchStr(Concat(FCodigo, FCodGru), ['001002', '003002'])) And
       (Not FQrCodePix.IsEmpty) Then
    Begin
      qryGeneric.ParamByName('CODIGO').AsString := '009';
      qryGeneric.ParamByName('CODGRU').AsString := FCodGru;
      qryGeneric.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryGeneric.Open;

      If Not qryGeneric.IsEmpty Then
        FCodigo := '009';
    End;

    If qryGeneric.IsEmpty Then
    Begin
      qryGeneric.Close;
      qryGeneric.ParamByName('CODIGO').AsString := FCodigo;
      qryGeneric.ParamByName('CODGRU').AsString := FCodGru;
      qryGeneric.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryGeneric.Open;
    End;

    Result := (Not qryGeneric.IsEmpty);

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TSMSAut.fTemModeloAtivoSms]');
  End;
end;

function TSMSAut.fGatilhoComControleDeHorarioDeDisparo: Boolean;
begin
  Result := False;

  if Pos(FCodGru, '009_') > 0 then
    Exit(True);

  if Concat(FCodGru, FCodigo) = '033001' then
    Exit(True);
end;

function TSMSAut.fTemModeloAtivoWpp(tpGatilho: TtpGatilho = gatCfg; AblnEhApenasVerificacaoSeModeloEstaAtivado: Boolean = False): Boolean;
Var
  strSQL: String;
begin

  Result := False;
  pSetaDados;
  pCarregaCodigosDoModelo;

  if not fOperadorTemPermissaoDeAcessoParaDispararGatilho then
    Exit;

  Try

    strSQL := '';
    strSQL := strSQL + 'SELECT       ';
    strSQL := strSQL + '  WPP_CODIGO,';
    strSQL := strSQL + '  MOD_ENVDOC,';
    strSQL := strSQL + '  MOD_MODELO,';
    strSQL := strSQL + '  MOD_IMAB64 ';
    strSQL := strSQL + 'FROM         ';
    strSQL := strSQL + '  WPPSAI     ';
    strSQL := strSQL + '  INNER JOIN MODWPP ON WPPSAI.AUTOINCREM = MODWPP.MOD_SEQGER ';
    strSQL := strSQL + 'WHERE        ';
    strSQL := strSQL + '  WPP_CODIGO = :CODIGO AND ';
    strSQL := strSQL + '  WPP_CODGRU = :CODGRU AND ';
    strSQL := strSQL + '  WPP_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  WPP_STATUS = "A"         ';

    strSQL := strSQL + IIF(tpGatilho = gatCtt,
                           ' AND WPP_SEQCTT IN ( SELECT '+
                           '                       AUTOINCREM '+
                           '                     FROM '+
                           '                       CLICTT '+
                           '                     WHERE '+
                           '                       CLI_CODCLI = :CODCLI )',
                           ' AND WPP_SEQCTT IS NULL ');

    strSQL := strSQL + IIF(fGatilhoComControleDeHorarioDeDisparo, ' AND CAST(:HORENV AS TIME) BETWEEN WPP_FXHRIN AND WPP_FXHRFN ', '');

    strSQL := strSQL + IIF(((fEhPesquisaDeSatisfacao) and (AblnEhApenasVerificacaoSeModeloEstaAtivado)),
                           ' AND NOT EXISTS '+
                           ' (SELECT '+
                           '   MOVGER.AUTOINCREM '+
                           ' FROM '+
                           '   MOVGER '+
                           '   INNER JOIN NOTFIC '+
                           '     ON MOVGER.AUTOINCREM = NOTFIC.NOT_SEQGER '+
                           ' WHERE GER_CODCLI = :CODCLI '+
                           '   AND GER_ESPDOC IN ("NF", "IF", "FF") '+
                           '   AND CURRENT_DATE < DATE_ADD( '+
                           '     NOT_DTAHOR, '+
                           '     INTERVAL WPP_INTENV DAY '+
                           '   ) '+
                           '   AND NOT_GATILH = "CL" '+
                           '   AND NOT_NOTFIC = "PS" '+
                           ' UNION '+
                           ' SELECT '+
                           '   NOTGER.AUTOINCREM '+
                           ' FROM '+
                           '   NOTGER '+
                           '   INNER JOIN NOTFIC '+
                           '     ON NOTGER.AUTOINCREM = NOTFIC.NOT_SEQGER '+
                           ' WHERE GER_CODCLI = :CODCLI '+
                           '   AND GER_ESPDOC IN ("NF", "IF", "FF") '+
                           '   AND CURRENT_DATE < DATE_ADD( '+
                           '     NOT_DTAHOR, '+
                           '     INTERVAL WPP_INTENV DAY '+
                           '   ) '+
                           '   AND NOT_GATILH = "CL" '+
                           '   AND NOT_NOTFIC = "PS" )',
                           '');

    qryGeneric.Close;
    qryGeneric.SQL.Clear;
    qryGeneric.SQL.Add(strSQL);

    If (MatchStr(Concat(FCodigo, FCodGru), ['001002', '003002'])) And
       (Not FQrCodePix.IsEmpty) Then
    Begin
      if tpGatilho = gatCtt then
        qryGeneric.ParamByName('CODCLI').AsString := FCodCli;

      qryGeneric.ParamByName('CODIGO').AsString := '009';
      qryGeneric.ParamByName('CODGRU').AsString := FCodGru;
      qryGeneric.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryGeneric.Open;

      If Not qryGeneric.IsEmpty Then
        FCodigo := '009';
    End;

    If qryGeneric.IsEmpty Then
    Begin
      qryGeneric.Close;

      if (tpGatilho = gatCtt) or
         ((fEhPesquisaDeSatisfacao) and (AblnEhApenasVerificacaoSeModeloEstaAtivado)) then
        qryGeneric.ParamByName('CODCLI').AsString := FCodCli;

      if fGatilhoComControleDeHorarioDeDisparo then
        qryGeneric.ParamByName('HORENV').AsTime := fRetHoraServidor;

      qryGeneric.ParamByName('CODIGO').AsString := FCodigo;
      qryGeneric.ParamByName('CODGRU').AsString := FCodGru;
      qryGeneric.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryGeneric.Open;
    End;

    Result := (Not qryGeneric.IsEmpty);
    Result := (Result) and ((qryGeneric.FieldByName('MOD_ENVDOC').AsString = 'S') or
                            (not fEmptyStr(qryGeneric.FieldByName('MOD_MODELO').AsString)));

    If Result Then
    Begin
      FEnvDoc := (qryGeneric.FieldByName('MOD_ENVDOC').AsString = 'S');

      if (fTemAnexoNoModelo) and (not AblnEhApenasVerificacaoSeModeloEstaAtivado) then
      begin
        SetLength(FArquiv, Length(FArquiv)+1);
        FArquiv[High(FArquiv)] := TRecArquivosGatilhos.Create('DIVERSOS', qryGeneric.FieldByName('MOD_IMAB64').AsString, EmptyStr, tpaImagem);
      end;
    End;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TSMSAut.fTemModeloAtivoWpp]');
  End;
end;

function TSMSAut.fEhPesquisaDeSatisfacao: Boolean;
begin
  Result := ((FOpcDoc = 'CL') and (FEspOrc = 'PS'));
end;

function TSMSAut.fTemAnexoNoModelo: Boolean;
begin
  Result := False;

  if (FOpcDoc = 'CL') and (FEspOrc = 'PS') then
    Exit(True);

  if (FOpcDoc = 'CL') and (FEspOrc = 'CA') then
    Exit(True);
end;

function TSMSAut.fTemModeloAtivo(AblnEhApenasVerificacaoSeModeloEstaAtivado: Boolean = False): Boolean;
begin
  if blnWhatsapp then
  begin
    Result := fTemModeloAtivoWpp(gatCtt, AblnEhApenasVerificacaoSeModeloEstaAtivado);
    if not Result then
      Result := fTemModeloAtivoWpp(gatCfg, AblnEhApenasVerificacaoSeModeloEstaAtivado);
  end
  else
    Result := fTemModeloAtivoSms;
end;

procedure TSMSAut.pCarregaCodigosDoModelo;
begin
  If ((SameText(FOpcDoc, 'OR')) Or
      (SameText(FEspOrc, 'OR')) Or
      (SameText(FEspDoc, 'OR')) Or
      (FStatus = staTransformando)) And
     ((not fEhPedidoSendoGravadoPelaRotinaDeOrcamento) Or (fEhTransformacaoDe_OR_Em_PD)) Then
  Begin
    FCodGru := '001';

    If (FStatus = staIncluindo) Then
      FCodigo := '001'
    Else If (FStatus = staAlterando) Then
      FCodigo := '002'
    Else If (FStatus = staTransformando) Then
      FCodigo := '003'
    Else If (FStatus = staFaturandoTotal) Then
      FCodigo := '004'
    Else If (FStatus = staBaixando) Then
      FCodigo := '005'
    Else If (FStatus = staCancelando) Then
      FCodigo := '006'
    Else If (FStatus = staConsultandoReimprimindo) Then
      FCodigo := '007'
    Else If (FStatus = staEnvioAgendado) Then
    Begin
      FAbreTelaEscolherContato := False;

      FCodigo := '008';
    end
    Else If (FStatus = staAberto1Dia) Then
      FCodigo := '009'
    Else If (FStatus = staAberto2Dias) Then
      FCodigo := '010'
    Else If (FStatus = staAberto3Dias) Then
      FCodigo := '011';
  End

  Else If (FOpcDoc = 'CP') And (FEspOrc = 'FP') And (FEspDoc = 'PD') Then
  Begin
    FCodGru := '002';
    FCodigo := '004'
  End

  Else If (SameText(FOpcDoc, 'PD')) Or (fEhPedidoSendoGravadoPelaRotinaDeVendaNormal) Or (fEhPedidoSendoGravadoPelaRotinaDeOrcamento) Or ((Pos(FEspOrc, 'FT_FP_') > 0) And (Pos(FOpcDoc, 'E2_E3_E4_E5_PR_') <= 0)) Then
  Begin
    FCodGru := '002';

    If (FStatus = staIncluindo) Then
      FCodigo := '001'
    Else If (FStatus = staImprimindoSeparacao) Then
      FCodigo := '002'
    Else If (FStatus = staAlterando) Then
      FCodigo := '003'
    Else If (FStatus = staFaturandoParcial) Then
      FCodigo := '004'
    Else If (FStatus = staFaturandoTotal) Then
      FCodigo := '005'
    Else If (FStatus = staBaixando) Then
      FCodigo := '006'
    Else If (FStatus = staCancelando) Then
      FCodigo := '007'
    Else If (FStatus = staConsultandoReimprimindo) Then
      FCodigo := '008'
  End
  Else If (Pos(FOpcDoc, 'E2_E3_E4_') > 0) Then
  Begin
    FAbreTelaEscolherContato := False;

    If (SameText(FOpcDoc , 'E2')) Then
    Begin
      FCodGru := '003';
      FCodigo := '001';
    End
    Else If (SameText(FOpcDoc, 'E3')) Then
    Begin
      FCodGru := '004';

      If (FStatus = staImprimindoSeparacao) Then
        FCodigo := '001'
      Else If (FStatus = staFaturandoParcial) Then
        FCodigo := '002'
      Else If (FStatus = staFaturandoTotal) Then
        FCodigo := '003';
    End
    Else If (SameText(FOpcDoc, 'E4')) Then
    Begin
      FCodGru := '005';

      If (FStatus = staImprimindoSeparacao) Then
        FCodigo := '001'
      Else If (FStatus = staConferindo) Then
        FCodigo := '002'
      Else If (FStatus = staFaturandoParcial) Then
        FCodigo := '003'
      Else If (FStatus = staFaturandoTotal) Then
        FCodigo := '004';
    End;
  End
  Else If (Pos(FOpcDoc, 'RI_RB_') > 0) Then
  Begin
    FAbreTelaEscolherContato := False;

    FCodGru := '006';

    If (FStatus = staIncluindo) Then
      FCodigo := '001'
    Else If (FStatus = staBaixando) Then
      FCodigo := '002';
  End

  Else If (SameText(FOpcDoc, 'E5')) Then
  Begin
    FAbreTelaEscolherContato := False;

    FCodGru := '007';

    If (FStatus = staIncluindo) Then
      FCodigo := '001'
    Else If (FStatus = staImprimindoSeparacao) Then
      FCodigo := '002'
    Else If (FStatus = staConferindo) Then
      FCodigo := '003'
    Else If (FStatus = staFaturandoTotal) Then
      FCodigo := '004'
    Else If (FStatus = staAtivando) Then
      FCodigo := '005'
    Else If (FStatus = staBaixando) Then
      FCodigo := '006';
  End

  Else If (SameText(FOpcDoc, 'BO')) Then
  Begin
    FCodGru := '008';
    FCodigo := '001'
  End

  Else If (SameText(FOpcDoc, 'AC')) Then
  Begin
    FAbreTelaEscolherContato := False;

    FCodGru := '009';
    If (FStatus = sta2DiasVencer) Then
      FCodigo := '001'
    Else If (FStatus = sta3DiasVencido) Then
      FCodigo := '002'
    Else If (FStatus = sta5DiasVencido) Then
      FCodigo := '003'
    Else If (FStatus = sta1DiaVencer) Then
      FCodigo := '004'
    Else If (FStatus = sta3DiasVencer) Then
      FCodigo := '005'
    Else If (FStatus = sta4DiasVencer) Then
      FCodigo := '006'
    Else If (FStatus = sta5DiasVencer) Then
      FCodigo := '007'
    Else If (FStatus = sta1DiaVencido) Then
      FCodigo := '008'
    Else If (FStatus = sta2DiasVencido) Then
      FCodigo := '009'
    Else If (FStatus = sta4DiasVencido) Then
      FCodigo := '010'
    Else If (FStatus = sta8DiasVencido) Then
      FCodigo := '011'
    Else If (FStatus = sta6DiasVencido) Then
      FCodigo := '012'
    Else If (FStatus = sta7DiasVencido) Then
      FCodigo := '013'
    Else If (FStatus = sta9DiasVencido) Then
      FCodigo := '014'
    Else If (FStatus = sta10DiasVencido) Then
      FCodigo := '015'

    Else If (FStatus = sta6DiasVencer) Then
      FCodigo := '016'
    Else If (FStatus = sta7DiasVencer) Then
      FCodigo := '018'
    Else If (FStatus = sta8DiasVencer) Then
      FCodigo := '019'
    Else If (FStatus = sta9DiasVencer) Then
      FCodigo := '020'
    Else If (FStatus = sta10DiasVencer) Then
      FCodigo := '021'

    Else If (FStatus = sta30DiasVencido) Then
      FCodigo := '022'

    Else If (FStatus = staAVencerProximoDiaUtil) Then
      FCodigo := '023'
    Else If (FStatus = staVencidoProximoDiaUtil) Then
      FCodigo := '024';

  End

  Else If (SameText(FOpcDoc, 'CD')) Then
  Begin
    FAbreTelaEscolherContato := False;

    FCodGru := '011';
    FCodigo := '001'
  End

  Else If (SameText(FOpcDoc, 'CF')) Then
  Begin
    FCodGru := '013';
    FCodigo := '001';

    If FStatus = staEnvioPixDupGeradaConfirmacao Then
      FCodigo := '002';
  End

  Else If (SameText(FOpcDoc, 'PX')) Then
  Begin
    FAbreTelaEscolherContato := False;

    FCodGru := '014';
    FCodigo := '001';

    If FStatus = staPixParaCreditoCliente Then
      FCodigo := '002';
  End

  Else If (SameText(FOpcDoc, 'EF')) Then
  Begin
    FAbreTelaEscolherContato := False;

    FCodGru := '015';
    FCodigo := '001';
  End

  Else If (SameText(FOpcDoc, 'TE')) Then
  Begin
    FAbreTelaEscolherContato := False;

    FCodGru := '016';
    If (FStatus = staRotaIniciada) Then
      FCodigo := '001'
    Else
    If (FStatus = staOcorrenciaEntrega) Then
      FCodigo := '002'
    Else
    If (FStatus = staEntregaConcluida) Then
      FCodigo := '003';
  End

  Else If (SameText(FOpcDoc, 'CB')) Then
  Begin
    FAbreTelaEscolherContato := False;

    FCodGru := '039';
    If (FStatus = staCobrancaEletronica) Then
      FCodigo := '001'
  End

  Else If (SameText(FOpcDoc, 'AN')) Then
  Begin
    If (FStatus = staAutorizadaNFe) Then
    Begin
    FAbreTelaEscolherContato := False;

      FCodGru := '035';
      FCodigo := '001';
    End
    Else If (FStatus = staAutorizadaNFCe) Then
    Begin
      FAbreTelaEscolherContato := False;

      FCodGru := '036';
      FCodigo := '001';
    End
    Else If (FStatus = staAutorizadaNFSe) Then
    Begin
      FAbreTelaEscolherContato := False;

      FCodGru := '038';
      FCodigo := '001';
    End
    Else If (FStatus = staReenvioNfeReimpressaoDocs) Then
    Begin
      FCodGru := '035';
      FCodigo := '002';
    End
    Else If (FStatus = staReenvioNfceReimpressaoDocs) Then
    Begin
      FCodGru := '036';
      FCodigo := '002';
    End;

  End

  Else If FOpcDoc = 'FF' Then
  Begin
    FCodGru := '037';
    If (FStatus = staIncluindo) Then
    Begin
      FAbreTelaEscolherContato := False;
      FCodigo := '001';
  End
    Else If (FStatus = staReenvioFFReimpressaoDocs) Then
      FCodigo := '002';
  End

  Else If FOpcDoc = 'RC' Then
  Begin
    FAbreTelaEscolherContato := False;

    If blnWhatsApp Then
    Begin
      FCodGru := '022';
      If (FStatus = staReimpressaoCobranca) Then
     FCodigo := '001';
    end;

  end
  Else If (SameText(FOpcDoc, 'LP')) Then
  Begin
    FAbreTelaEscolherContato := True;

    FCodGru := '027';
    if SameText(FEspDoc, 'PD') then
      FCodigo := '001'
    else if SameText(FEspDoc, 'AGR') then
      FCodigo := '002' ;
  End

  Else If FOpcDoc = 'CE' Then
  Begin
    FCodGru := '012';
    FCodigo := '001';

    If FStatus = staIncluindo Then
      FCodigo := '002'
    Else If FStatus = staBaixando Then
      FCodigo := '003'
    Else If FStatus = staImprimindoOS Then
      FCodigo := '004';
  End

  Else If FOpcDoc = 'SE' Then
  Begin
    FAbreTelaEscolherContato := False;

    FCodGru := '023';
    If FStatus = staAlterouStatusDoServico Then
      FCodigo := '001';
  End

  Else If FOpcDoc = 'PC' Then
  Begin
    FAbreTelaEscolherContato := False;
    FCodigo := '001';
    FCodGru := '024';
  End

  Else If FOpcDoc = 'AD' Then
  Begin
    FCodGru := '025';
    FCodigo := '001';

    If FStatus = staAvisoDebitoDia16 Then
     FCodigo := '002';
  End
  Else If (SameText(FOpcDoc, 'CH')) Then
  Begin
    FAbreTelaEscolherContato := False;

    FCodGru := '029';
    If (FStatus = staCashbackVenda) Then
      FCodigo := '001'
    Else If (FStatus = staCashback7DiasAVencer) Then
      FCodigo := '002';
  End
  Else If (SameText(FOpcDoc, 'CL')) Then
  Begin
    FCodGru := '033';
    If FStatus = staPesquisaSatisfacao then
      FCodigo := '002'
    Else If FStatus = staClienteAniversariante then
      FCodigo := '001';
  End
  Else If (SameText(FOpcDoc, 'AI')) Then
  Begin
    FAbreTelaEscolherContato := False;

    FCodGru := '030';
    If FStatus = staAlteracaoStatusEntrega Then
      FCodigo := '001';
  End
  Else If (SameText(FOpcDoc, 'PR')) Then
  Begin
    FAbreTelaEscolherContato := True;

    FCodGru := '031';
    If FStatus = staFotoProduto Then
      FCodigo := '002';
  End

  Else If (SameText(FOpcDoc, 'RE')) Then
  Begin
    FCodGru := '046';
    If FStatus = staEnvCodRastreioCorreio Then
      FCodigo := '001';

    If FStatus = staEnvCodRastreioAcompanhamento Then
      FCodigo := '002';
  End;
end;

procedure TSMSAut.pCarregaInformacoesDocumentoFiscal;
var
  qryCadFis: TUniQuery;
begin
  qryCadFis := fCriaQuery;
  try
    qryCadFis.Close;
    qryCadFis.SQL.Text :=
    ' SELECT '+
    '   FIS_SERIE_, '+
    '   FIS_ACESSO, '+

    '   GER_DTAENT, '+
    '   GER_HORENT, '+

    '   CONCAT(COALESCE(CONCAT(EMP_ENDERE, ", "), ""), COALESCE(CONCAT(EMP_ENDNUM, " "), ""), COALESCE(CONCAT(EMP_ENDCMP, " "), ""), COALESCE(CONCAT(EMP_BAIRRO, " - "), ""), COALESCE(CONCAT(E.CID_NOMCID, " - "), ""), COALESCE(E.CID_ESTADO, "")) AS ENDEMP, '+
    '   CONCAT( '+
    '       SUBSTRING(EMP_C_G_C_,1,2), ".", '+
    '       SUBSTRING(EMP_C_G_C_,3,3), ".", '+
    '       SUBSTRING(EMP_C_G_C_,6,3), "/", '+
    '       SUBSTRING(EMP_C_G_C_,9,4), "-", '+
    '       SUBSTRING(EMP_C_G_C_,13,2) '+
    '   ) AS EMP_C_G_C_, '+

    '   CONCAT(COALESCE(CONCAT(CLI_ENDERE, ", "), ""), COALESCE(CONCAT(CLI_ENDNUM, " "), ""), COALESCE(CONCAT(CLI_ENDCOM, " "), ""), COALESCE(CONCAT(CLI_BAIRRO, " - "), ""), COALESCE(CONCAT(C.CID_NOMCID, " "), ""), COALESCE(C.CID_ESTADO, "")) AS ENDCLI, '+
    '   CASE '+
    '     WHEN LENGTH(TRIM(CLI_C_G_C_)) = 11 THEN '+
    '         CONCAT( '+
    '             SUBSTRING(CLI_C_G_C_,1,3), ".", '+
    '             SUBSTRING(CLI_C_G_C_,4,3), ".", '+
    '             SUBSTRING(CLI_C_G_C_,7,3), "-", '+
    '             SUBSTRING(CLI_C_G_C_,10,2) '+
    '         ) '+

    '     WHEN LENGTH(TRIM(CLI_C_G_C_)) = 14 THEN '+
    '         CONCAT( '+
    '             SUBSTRING(CLI_C_G_C_,1,2), ".", '+
    '             SUBSTRING(CLI_C_G_C_,3,3), ".", '+
    '             SUBSTRING(CLI_C_G_C_,6,3), "/", '+
    '             SUBSTRING(CLI_C_G_C_,9,4), "-", '+
    '             SUBSTRING(CLI_C_G_C_,13,2) '+
    '         ) '+
    '     ELSE CLI_C_G_C_ '+
    '   END AS CLI_C_G_C_  '+

    ' FROM '+
    '   CADFIS '+

    ' INNER JOIN MOVGER '+
    '    ON FIS_NUMDOC = GER_NUMDOC '+
    '   AND FIS_ESPDOC = GER_ESPDOC '+
    '   AND FIS_CODEMP = GER_CODEMP '+
    '   AND FIS_FORCLI = GER_CODCLI '+
    '   AND FIS_SERIE_ = GER_SERIE_ '+

    ' INNER JOIN CADEMP '+
    '   ON FIS_CODEMP = EMP_CODEMP '+

    ' INNER JOIN CADCLI '+
    '   ON FIS_FORCLI = CLI_CODCLI '+

    ' LEFT JOIN CADCID E '+
    '   ON EMP_CODCID = E.CID_CODCID '+

    ' LEFT JOIN CADCID C '+
    '   ON CLI_CODCID = C.CID_CODCID '+

    ' WHERE '+

    '   FIS_NUMDOC = :NUMDOC AND '+
    '   FIS_ESPDOC = :ESPDOC AND '+
    '   FIS_CODEMP = :CODEMP AND '+
    '   FIS_FORCLI = :FORCLI AND '+
    '   FIS_SERIE_ = :SERIE_ ';

    qryCadFis.ParamByName('NUMDOC').AsString := FNumDoc;
    qryCadFis.ParamByName('ESPDOC').AsString := FEspDoc;
    qryCadFis.ParamByName('CODEMP').AsString := FEmpDoc;
    qryCadFis.ParamByName('FORCLI').AsString := FCodCli;
    qryCadFis.ParamByName('SERIE_').AsString := FSerie_;
    qryCadFis.Open;

    if not qryCadFis.IsEmpty then
    begin
      FSerie_ := IIF(fEmptyStr(FSerie_), qryCadFis.FieldByName('FIS_SERIE_').AsString, FSerie_);
      FFisAce := IIF(fEmptyStr(FFisAce), qryCadFis.FieldByName('FIS_ACESSO').AsString, FFisAce);

      FDtaEmi := qryCadFis.FieldByName('GER_DTAENT').AsString;
      FHorEmi := qryCadFis.FieldByName('GER_HORENT').AsString;

      FEndEmp := qryCadFis.FieldByName('ENDEMP').AsString;
      FCgcEmp := qryCadFis.FieldByName('EMP_C_G_C_').AsString;

      FEndCli := qryCadFis.FieldByName('ENDCLI').AsString;
      FCgcCli := qryCadFis.FieldByName('CLI_C_G_C_').AsString;
    end;
  finally
    FreeAndNil(qryCadFis);
  end;
end;

procedure TSMSAut.pSetaDados;
begin
  FStatus := fRetornaStatusParaSMS;
  pSetaVariaveisDoModeloEmail;
end;

{procedure TSMSAut.pSetAssunto(Value: String);
begin
  strAssunt := Value;
end;}

function GetInformacoesCupom(ACupom: String): String;
begin
  if (fEmptyStr(ACupom)) then
    Exit('');

  Result := fCampoTabela('MCU_RESCAL', 'MOVCUP', ['MCU_NUMCUP'], [ACupom]);
end;

function GetNumeroCupom(ADoc, AEsp, AEmp, ACup: String): String;
begin
  Result := fCampoTabela('MCU_NUMCUP', 'MOVCUP', ['MCU_NUMDOC', 'MCU_ESPDOC',
    'MCU_CODEMP', 'MCU_CODCUP'], [ADoc, AEsp, AEmp, ACup]);
end;

function GetDescontoCupom(ACupom: String): Double;
begin
  if (fEmptyStr(ACupom)) then
    Exit(0);

  Result := fCampoTabela('MCU_TOTCUP', 'MOVCUP', ['MCU_NUMCUP'], [ACupom]);
end;

function TSMSAut.fRetDataHoraEntregue: String;
var
  qryDtaEnt: TUniQuery;
begin
  Result := '';

  qryDtaEnt := fCriaQuery;
  try
    qryDtaEnt.Close;
    qryDtaEnt.SQL.Text :=
    ' SELECT '+
    '   GER_DTABAI, '+
    '   GER_HORBAI '+
    ' FROM '+
    '   ROMGERX '+
    ' WHERE '+
    '   AUTOINCREM = :AUTINC ';

    qryDtaEnt.ParamByName('AUTINC').AsString := FAutInc;
    qryDtaEnt.Open;

    if not qryDtaEnt.IsEmpty then
      Result := qryDtaEnt.FieldByName('GER_DTABAI').AsString + ' ' +
                qryDtaEnt.FieldByName('GER_HORBAI').AsString;

  finally
    FreeAndNil(qryDtaEnt);
  end;

end;

procedure TSMSAut.pRetInformacoesGeraisRomaneio;
var
  qryRomGer: TUniQuery;
begin
  qryRomGer := fCriaQuery;
  try
    qryRomGer.Close;
    qryRomGer.SQL.Text :=
    ' SELECT '+
    '   MOT_NOMMOT '+
    ' FROM '+
    '   ROMGERX '+
    ' INNER JOIN CADMOT '+
    '   ON GER_CODMOT = MOT_CODMOT '+
    ' WHERE '+
    '   ROMGERX.AUTOINCREM = :AUTINC ';

    qryRomGer.ParamByName('AUTINC').AsString := FAutInc;
    qryRomGer.Open;

    if qryRomGer.IsEmpty then
      Exit;

    FNomMot := qryRomGer.FieldByName('MOT_NOMMOT').AsString;
  finally
    FreeAndNil(qryRomGer);
  end;
end;

function TSMSAut.fRetLinkPagamento: String;
Var
  qryConsulta: TUniQuery;
  strSQL   : String;
begin
  Result := '';

  qryConsulta := fCriaQuery;
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '       CBE_LNKPAG ';
    strSQL := strSQL + '  FROM COBELT ';
    strSQL := strSQL + ' WHERE CBE_NUMDOC = :NUMDOC ';
    strSQL := strSQL + '   AND CBE_ESPDOC = :ESPDOC ';
    strSQL := strSQL + '   AND CBE_CODEMP = :CODEMP ';
    strSQL := strSQL + '   AND CBE_APICOB NOT IN ("PMEC") ';

    qryConsulta.Close;
    qryConsulta.SQL.Text := strSQL;
    qryConsulta.ParamByName('NUMDOC').AsString := FNumDoc;
    qryConsulta.ParamByName('ESPDOC').AsString := FEspDoc;
    qryConsulta.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryConsulta.Open;

    Result := qryConsulta.FieldByName('CBE_LNKPAG').AsString;

  Finally
    FreeAndNil(qryConsulta);
  End;

end;

function TSMSAut.fRetMensagemOcorrenciaDeEntrega: String;
var
  qryMsgOco: TUniQuery;
begin
  Result := '';

  qryMsgOco := fCriaQuery;
  try
    qryMsgOco.Close;
    qryMsgOco.SQL.Text :=
    ' SELECT '+
    '   O.OCR_MSGCLI '+
    ' FROM '+
    '   NOTFIC N '+
    ' INNER JOIN OCOROM O ON '+
    '   N.NOT_NOTFIC = O.AUTOINCREM '+
    ' WHERE '+
    '   N.NOT_SEQGER = ( SELECT '+
                       '   AUTOINCREM '+
                       ' FROM '+
                       '   ROMGERX '+
                       ' WHERE '+
                       '   AUTOINCREM = :AUTINC) AND '+
    '   N.NOT_NOTENV = "N" '+
    ' ORDER BY '+
    '   N.NOT_DTAHOR ';

    qryMsgOco.ParamByName('AUTINC').AsString := FAutInc;
    qryMsgOco.Open;

    if not qryMsgOco.IsEmpty then
      Result := qryMsgOco.FieldByName('OCR_MSGCLI').AsString;

  finally
    FreeAndNil(qryMsgOco);
  end;
end;

function TSMSAut.fRetPrevisaoDoHorarioDeChegada: String;
var
  qryTmpEnt: TUniQuery;
  strNumRom,
  strEmpRom,
  strOrdImp: String;
  intTmpEnt: LargeInt;
begin
  Result := '';

  qryTmpEnt := fCriaQuery;
  try
    qryTmpEnt.Close;
    qryTmpEnt.SQL.Text :=
    ' SELECT '+
    '   GER_NUMROM, '+
    '   GER_EMPROM, '+
    '   GER_ORDIMP, '+
    '   IFNULL(GER_TMPENT,0) AS GER_TMPENT '+
    ' FROM '+
    '   ROMGERX '+
    ' WHERE '+
    '   AUTOINCREM = :AUTINC ';

    qryTmpEnt.ParamByName('AUTINC').AsString := FAutInc;
    qryTmpEnt.Open;

    if not qryTmpEnt.IsEmpty then
    begin
      Result := DateTimeToStr( IncSecond(fNow, qryTmpEnt.FieldByName('GER_TMPENT').AsLargeInt) );

      strNumRom := qryTmpEnt.FieldByName('GER_NUMROM').AsString;
      strEmpRom := qryTmpEnt.FieldByName('GER_EMPROM').AsString;
      strOrdImp := qryTmpEnt.FieldByName('GER_ORDIMP').AsString;
      intTmpEnt := qryTmpEnt.FieldByName('GER_TMPENT').AsLargeInt;

      qryTmpEnt.Close;
      qryTmpEnt.SQL.Text :=
      ' SELECT '+
      '   IFNULL(GER_TMPENT,0) AS GER_TMPENT '+
      ' FROM '+
      '   ROMGERX '+
      ' WHERE '+
      '   AUTOINCREM = :AUTINC AND '+
      '   GER_ORDIMP = :ORDIMP ';

      qryTmpEnt.ParamByName('AUTINC').AsString := FAutInc;
      qryTmpEnt.ParamByName('ORDIMP').AsString := IntToStr(StrToInt(strOrdImp)-1);
      qryTmpEnt.Open;

      if not qryTmpEnt.IsEmpty then
      begin
        intTmpEnt := intTmpEnt - qryTmpEnt.FieldByName('GER_TMPENT').AsLargeInt;
        Result := DateTimeToStr( IncSecond(fNow, intTmpEnt) );
      end;

    end;

  finally
    FreeAndNil(qryTmpEnt);
  end;
end;

procedure TSMSAut.pInformacoesDoServico;
var
  qryServico : TUniQuery;
begin
  qryServico := fCriaQuery;
  try
    qryServico.Close;
    qryServico.SQL.Text :=
    IIF(FEspDoc = 'PD',
        ' SELECT '+
        '   FGO_PLAVEI AS PLAVEI, '+
        '   MAR_DESMAR AS DESMAR, '+
        '   MOD_DESMOD AS DESMOD '+
        ' FROM '+
        '   FATGOR '+
        '   INNER JOIN EXTGOR ON '+
        '     FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO '+
        '   LEFT JOIN CADVEI ON '+
        '     FGO_PLAVEI = VEI_PLAVEI '+
        '   LEFT JOIN MARVEI ON '+
        '     VEI_CODMAR = MAR_CODMAR '+
        '   LEFT JOIN MODVEI ON '+
        '     VEI_CODMOD = MOD_CODMOD '+
        ' WHERE '+
        '   FGO_NUMDOC = :NUMDOC AND '+
        '   FGO_ESPDOC = :ESPDOC AND '+
        '   FGO_CODEMP = :CODEMP AND '+
        '   FGO_CODCLI = :CODCLI '
        ,
        ' SELECT '+
        '   AUX_PLAVEI AS PLAVEI, '+
        '   MAR_DESMAR AS DESMAR, '+
        '   MOD_DESMOD AS DESMOD '+
        ' FROM '+
        '   MOVGER '+
        '   INNER JOIN AUXMOV ON '+
        '     MOVGER.AUTOINCREM = AUXMOV.AUX_SEQGER '+
        '   LEFT JOIN CADVEI ON '+
        '     AUX_PLAVEI = VEI_PLAVEI '+
        '   LEFT JOIN MARVEI ON '+
        '     VEI_CODMAR = MAR_CODMAR '+
        '   LEFT JOIN MODVEI ON '+
        '     VEI_CODMOD = MOD_CODMOD '+
        ' WHERE '+
        '   GER_NUMDOC = :NUMDOC AND '+
        '   GER_ESPDOC = :ESPDOC AND '+
        '   GER_CODEMP = :CODEMP AND '+
        '   GER_CODCLI = :CODCLI '+

        ' UNION '+

        ' SELECT '+
        '   AUX_PLAVEI AS PLAVEI, '+
        '   MAR_DESMAR AS DESMAR, '+
        '   MOD_DESMOD AS DESMOD '+
        ' FROM '+
        '   NOTGER '+
        ' INNER JOIN AUXMOV ON '+
        '   NOTGER.AUTOINCREM = AUXMOV.AUX_SEQGER '+
        ' LEFT JOIN CADVEI ON '+
        '   AUX_PLAVEI = VEI_PLAVEI '+
        ' LEFT JOIN MARVEI ON '+
        '   VEI_CODMAR = MAR_CODMAR '+
        ' LEFT JOIN MODVEI ON '+
        '   VEI_CODMOD = MOD_CODMOD '+
        ' WHERE '+
        '   GER_NUMDOC = :NUMDOC AND '+
        '   GER_ESPDOC = :ESPDOC AND '+
        '   GER_CODEMP = :CODEMP AND '+
        '   GER_CODCLI = :CODCLI ');

    qryServico.ParamByName('NUMDOC').AsString := FNumDoc;
    qryServico.ParamByName('ESPDOC').AsString := FEspDoc;
    qryServico.ParamByName('CODEMP').AsString := FEmpOri;
    qryServico.ParamByName('CODCLI').AsString := FCodCli;
    qryServico.Open;

    FPlaVei := qryServico.FieldByName('PLAVEI').AsString;
    FModVei := qryServico.FieldByName('DESMAR').AsString + ' ' + qryServico.FieldByName('DESMOD').AsString;

    FMsgSta := fCampoTabela('STS_MSGCLI', 'STASER', ['STS_CODIGO'], [FStaSer]);
    FDesSer := fRetDesServico(FCodSer);
  finally
    FreeAndNil(qryServico);
  end;
end;

procedure TSMSAut.pSetaVariaveisDoModeloEmail;
var
  LValorDocumento: Double;
begin
  FOrcVen := '';
  FPedVen := '';
  FDocVen := '';
  FNroVen := '';
  FEmpVen := '';
  FEspVen := '';

  FValorOrcamento  := '';
  FDataDeCadastro  := '';
  FTelefoneCliente := '';

  FCidPed := EmptyStr;
  FUF_Ped := EmptyStr;
  FEndPed := EmptyStr;
  FBaiPed := EmptyStr;
  FComPed := EmptyStr;
  FRefEnd := EmptyStr;
  FCepPed := EmptyStr;

  FValorPedido     := EmptyStr;

  FCodOpe := strLoginUsuarioLogado;

  FNomLoj := fRetFantasiaEmpresa(IfThen(fEmptyStr(FEmpDoc), VS_strCodEmp, FEmpDoc));

  If Pos(FEspDoc, 'OR_PD_') > 0 Then
  Begin
    FVendedor := fCampoTabela('OPE_NOMOPE', 'CADOPE', ['OPE_CODOPE'], [FCodVen]);
    FVendedor := IIF(Pos(' ', FVendedor) > 0, Trim(Copy(FVendedor, 0, Pos(' ', FVendedor))), FVendedor);

    FNomeCompletoVendedor := fCampoTabela('OPE_NOMOPE', 'CADOPE', ['OPE_CODOPE'], [FCodVen]);
    FContatoVendedor := fFormataFone(fCampoTabela('OPE_NUMWPP', 'CADOPE', ['OPE_CODOPE'], [FCodVen]));

    If (FEspDoc = 'OR') Then
    Begin
      FOrcVen := (FNumDoc + '-' + FEspDoc + '-' + IfThen(fEmptyStr(FEmpDoc), VS_strCodEmp, FEmpDoc));

      LValorDocumento := fCampoTabela('FGO_VLRCON', 'FATGOR',
                                     ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'],
                                     [FNumDoc, FEspDoc, IIF(fEmptyStr(FEmpDoc), VS_strCodEmp, FEmpDoc)]);

      FValorOrcamento  := Format('%m', [LValorDocumento]);

      FDataDeCadastro  := fCampoTabela('FGO_DTAENT', 'FATGOR',
                                       ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'],
                                       [FNumDoc, FEspDoc, IIF(fEmptyStr(FEmpDoc), VS_strCodEmp, FEmpDoc)]);

      FTelefoneCliente := fCampoTabela('CLI_FONE01', 'CADCLI', ['CLI_CODCLI'], [FCodCli]);
    End
    Else If (FEspDoc = 'PD') Then
    Begin
      If (FEspOrc = 'OR') Then
        FOrcVen := (FNumOrc + '-' + FEspOrc + '-' + FEmpOri);

      FPedVen := (FNumDoc + '-' + FEspDoc + '-' + IfThen(fEmptyStr(FEmpDoc), VS_strCodEmp, FEmpDoc));
      pCarregaEnderecoPedido(FNumDoc, FEspDoc, IfThen(fEmptyStr(FEmpDoc), VS_strCodEmp, FEmpDoc), FCodCli);
    End;
  End
  Else If (FEspDoc <> 'OR') And (FEspDoc <> 'PD') Then
  Begin
    If (FEspOrc = 'OR') Then
      FOrcVen := (FNumOrc + '-' + FEspOrc + '-' + FEmpOri)
    Else If (Pos(FEspOrc, 'PD_FT_FP_') > 0) Or (Pos(FOpcDoc, 'E3_E4_') > 0) Then
      FPedVen := (FNumOrc + '-' + 'PD' + '-' + FEmpOri);
  End;

  FDocVen := (FNumDoc + '-' + FEspDoc + '-' + IfThen(fEmptyStr(FEmpDoc), VS_strCodEmp, FEmpDoc));

  FNroVen := FNumDoc;
  FEmpVen := IfThen(fEmptyStr(FEmpDoc), VS_strCodEmp, FEmpDoc);
  FEspVen := FEspDoc;

  FTransp := fRetornaTransportadoraDocumento;

  FCupDes := GetNumeroCupom(FNumDoc, FEspDoc, IfThen(fEmptyStr(FEmpDoc), VS_strCodEmp, FEmpDoc), FCodCup);
  FTotCup := FormatFloat(fMskDigitos(2), GetDescontoCupom(FCupDes));
  FInfCup := GetInformacoesCupom(FCupDes);

  if FOpcDoc = 'TE' then
  begin
    if FEspOrc = 'RI' then
      FPreChe := fRetPrevisaoDoHorarioDeChegada
    else
    if FEspOrc = 'OE' then
      FMsgOco := fRetMensagemOcorrenciaDeEntrega
    else
    if FEspOrc = 'EC' then
      FDtaCon := fRetDataHoraEntregue;

    pRetInformacoesGeraisRomaneio;
  end;

  if FOpcDoc = 'CB' then
  begin
    if FEspOrc = 'PD' then
      FLnkPag := fRetLinkPagamento;
  end;

  if FOpcDoc = 'SE' then
    pInformacoesDoServico;

  if FOpcDoc = 'LP' then
  begin
    FVendedor := fCampoTabela('CONCAT("'+strLoginUsuarioLogado+'", "-", OPE_NOMOPE)', 'CADOPE', ['OPE_CODOPE'], [strLoginUsuarioLogado]);

    FDataDeCadastro  := fCampoTabela('FGO_DTAENT', 'FATGOR',
                                     ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'],
                                     [FNumDoc, FEspDoc, IIF(fEmptyStr(FEmpDoc), VS_strCodEmp, FEmpDoc)]);

    LValorDocumento := fCampoTabela('FGO_VLRCON', 'FATGOR',
                                     ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'],
                                     [FNumDoc, FEspDoc, IIF(fEmptyStr(FEmpDoc), VS_strCodEmp, FEmpDoc)]);

    FValorPedido := Format('%m', [LValorDocumento]);

  end ;

  if FOpcDoc = 'CH' then
    pInformacoesCashback;

  if FOpcDoc = 'AI' then
    pInformacoesIntelipost;

  if (FOpcDoc = 'AN') and ((FEspdoc = 'NF') or (FEspdoc = 'IF') or (FEspdoc = 'NS')) then
    pCarregaInformacoesDocumentoFiscal;

  if FOpcDoc = 'PR' then
  begin
    if FEspOrc = 'FP' then
      pCarregaInformacoesDoProduto;
  end;
end;

procedure TSMSAut.pCarregaInformacoesDoProduto;
begin
  FNomIte := fCampoTabela('ITE_DESITE', 'CADITE', ['ITE_CODITE'], [FCodIte]);
end;

procedure TSMSAut.pInformacoesIntelipost;
var
  IntelipostWebhook: TIntelipostWebhook;
begin
  IntelipostWebhook := TIntelipostWebhook.FromJsonString(strInfAdi);
  try
    if Assigned(IntelipostWebhook) then
    begin
      FStaEnt := IntelipostWebhook.history.shipment_volume_micro_state.default_name;
      FDesEnt := IntelipostWebhook.history.shipment_volume_micro_state.description;
      FLikRas := IntelipostWebhook.tracking_url;
    end;
  finally
    if Assigned(IntelipostWebhook) then
      FreeAndNil(IntelipostWebhook);
  end;
end;

procedure TSMSAut.pInformacoesCashback;
var
  qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.Close;
    qryConsulta.SQL.Text := 'SELECT '
                          + '       G.GER_DTAENT '
                          + '     , V.VCB_NUMCSH '
                          + '     , V.VCB_DTAENT '
                          + '     , V.VCB_VLRCSH '
                          + '     , V.VCB_DTAVAL '
                          + '     , (SELECT SUM(E.VCB_VLRDSP) FROM VENCSH E '
                          + '         WHERE E.VCB_DTAVAL >= CURRENT_DATE '
                          + '           AND E.VCB_CODCLI = G.GER_CODCLI) AS TOTAL_DISPONIVEL '
                          + '  FROM VENCSH V '
                          + ' INNER JOIN MOVGER G ON G.AUTOINCREM = V.VCB_SEQGER '
                          + ' WHERE G.GER_NUMDOC = :NUMDOC '
                          + '   AND G.GER_ESPDOC = :ESPDOC '
                          + '   AND G.GER_CODEMP = :CODEMP ';

    qryConsulta.ParamByName('NUMDOC').AsString := FNumDoc;
    qryConsulta.ParamByName('ESPDOC').AsString := FEspDoc;
    qryConsulta.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryConsulta.Open;

    FNumCsh := qryConsulta.FieldByName('VCB_NUMCSH').AsString;
    FDtaCsh := FormatDateTime('dd/mm/yyyy', qryConsulta.FieldByName('VCB_DTAENT').AsDateTime);
    FVlrCsh := FormatFloat(',0.00', qryConsulta.FieldByName('VCB_VLRCSH').AsFloat);
    FDtaVal := FormatDateTime('dd/mm/yyyy', qryConsulta.FieldByName('VCB_DTAVAL').AsDateTime);
    FTotDsp := FormatFloat(',0.00', qryConsulta.FieldByName('TOTAL_DISPONIVEL').AsFloat);
    FDtaVen := qryConsulta.FieldByName('GER_DTAENT').AsString;
    FDtaEmi := FormatDateTime('dd/mm/yyyy', qryConsulta.FieldByName('GER_DTAENT').AsDateTime);
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

end.
