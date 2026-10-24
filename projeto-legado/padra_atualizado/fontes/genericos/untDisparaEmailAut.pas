unit untDisparaEmailAut;

interface

uses Windows, Classes, StrUtils, SysUtils, Controls, Uni, UniClientDataSet, UniDataSetProvider, DB,
     EditFocus, Forms, Variants, StdCtrls, untFuncoesSimples, untTypesSistema, MemData, JPeg,
     DateUtils;

Type
  IInfDocumento = Interface
  ['{15B7A557-E37C-433E-9823-D10F9283CA8B}']
    function fLoadVendedor        (var AVendedor        : String) : IInfDocumento;
    function fLoadValorDocumento  (var AValorDocumento  : String) : IInfDocumento;
    function fLoadDataDeCadastro  (var ADataDeCadastro  : String) : IInfDocumento;
    function fLoadTelefoneCliente (var ATelefoneCliente : String) : IInfDocumento;
  End;

  TInfDocumento = Class(TInterfacedObject, IInfDocumento)
  Private
    FDocumento : TUniQuery;
    function fDocumentoEncontrado : Boolean;
    constructor Create(const ANumeroDocumento, AEspecieDocumento, AEmpresaDocumento : String);
  Public

    function fLoadVendedor        (var AVendedor        : String) : IInfDocumento;
    function fLoadValorDocumento  (var AValorDocumento  : String) : IInfDocumento;
    function fLoadDataDeCadastro  (var ADataDeCadastro  : String) : IInfDocumento;
    function fLoadTelefoneCliente (var ATelefoneCliente : String) : IInfDocumento;

    class function New(const ANumeroDocumento, AEspecieDocumento, AEmpresaDocumento : String) : IInfDocumento;

  End;

  TEmaAut = Class(TComponent)
    private
      qryGeneric: TUniQuery;
      FImgCor: String;
      FLinDig: String;
      FCupDes: String;
      FTotCup: String;
      FInfCup: String;
      FDtaEmi: String;
      FValDup: String;
      FParcel: String;
      FDtaVen: String;
      FCodCup: String;
      FNroCtr: String;

      FCidPed: String;
      FUF_Ped: String;
      FEndPed: String;
      FBaiPed: String;
      FComPed: String;
      FRefEnd: String;
      FCepPed: String;

      FDiasVencimento: String;

      procedure pSetaVariaveisDoModeloEmail;
      procedure pCarregaCodigosDoModelo;
      procedure pCarregaModeloEmail;
      procedure pCarregaDadosConexao;
      procedure pCarregaDadosConexaoFixa;
      procedure pCarregaDadosConexaoOperador;
      procedure pCarregaImagemAssinatura(strBase64: String);
      procedure pSetaDados;
      function  fRetornaStatusParaEmail: TStatusDisparaEmail;
      function  fAcertaVariaveisModelo(strModTmp: String): String;
      function  fRetornaTransportadoraDocumento: String;
      procedure pCriaImagensModeloEmail(strSeqGer: String; Var strPatImg: String);
      procedure pAtualizarModelo(strSeqGer: String);
      function fCarregaTabelaDups: String;
      Function fTabelaAdicionaLinha( ArrIndice : Integer) : String;

      function fRetornaDocumentosConfirmados: String;

      function GeraTabelaDuplicatasPix(ADuplicatas: TArrDupTabelaEmail): String;
      function GeraTabelaDuplicatasAvisoDebito(ADuplicatas: TArrDupTabelaEmail): String;

      function  fRetPrevisaoDoHorarioDeChegada: String;
      function  fRetMensagemOcorrenciaDeEntrega: String;
      function  fRetDataHoraEntregue: String;
      procedure pRetInformacoesGeraisRomaneio;
      function fRetLinkPagamento: String;

      function fEhTransformacaoDe_OR_Em_PD: Boolean;
      function fEhPedidoSendoGravadoPelaRotinaDeOrcamento: Boolean;
      function fEhPedidoSendoGravadoPelaRotinaDeVendaNormal: Boolean;
      function fRetNroContratoPelaFatura(const strEmpDoc, strEspDoc, strNumDoc: String): String;
      function fEhAgendamentoDeEnvioDeOrcamento: Boolean;
      function fRetornaTabelaDuplicataDocsConfirmados: TArrDupTabelaEmail;
      function fCarregaTabelaDupsDocsConfirmados: String;
      procedure pCarregaDadosConexaoEmpresa;
      procedure pInformacoesBoleto;
      function RetornaTabelaDuplicata(ADataSet:TDataSet): TArrDupTabelaEmail;
      procedure pInformacoesCashback;
      procedure pInformacoesIntelipost;

      procedure CarregaDadosDoProvedor(ACodigoProvedor: Integer);
      function fEhPesquisaDeSatisfacao: Boolean;
      procedure pCarregaInformacoesDocumentoFiscal;
      procedure pCarregaEnderecoPedido(ANumDoc, AEspDoc, AEmpDoc, ACodCli: String);
    Public
      FSenha: String;
      FSerSmt: String;
      FAssunt: String;
      FEspDoc: String;
      FCodGru: String;
      FPorIma: Integer;
      FNomCli: String;
      FLimArq: Integer;
      FOpcDoc: String;
      FPedVen: String;
      FNumDoc: String;
      FPriCli: String;
      FEspOrc: String;
      FCodOpe: String;
      FTxtAss: String;
      FCodPrv: Integer;
      FPorSmt: Integer;
      FEmail: String;
      FLogin: String;
      FDocVen: String;
      FNroVen: String;
      FEmpVen: String;
      FEspVen: String;
      FStatus: TStatusDisparaEmail;
      FCidCli: String;
      FEmpDoc: String;
      FProved: String;
      FEmpOri: String;
      FNumOrc: String;
      FCodigo: String;
      FEmaCli: String;
      FCopiaOcultaRemetente:Boolean;
      FModelo: String;
      FCorpo : String;
      FSerIma: String;
      FOrcVen: String;
      FImgAss: Boolean;
      FImaAss: TMemoryStream;
      FTransp: String;
      FArquiv: TArray<TRecArquivosGatilhos>;
      FArqBol: String;
      FRemete: String;
      FSSLSai: Boolean;
      FSSLEnt: Boolean;
      FEnvDoc: Boolean;
      FEnvXML: Boolean;
      FEnvXLS: Boolean;
      FCodCli: String;
      FQrCodePix: String;
      FDocCon: String;
      FEnvAutCob: Boolean;
      FGravaPastaEnviados: String;
      FCorpoAdicional: String;
      FCorpoEmailFixo: String;
      FNumeOS: String;
      FArrDup : TArrDupTabelaEmail;

      FUsaAuthenticacaoOAuth2: Boolean;

      FClientId,
      FClientSecret,
      FTenantId: String;

      FVendedor        : String;
      FValorOrcamento  : String;
      FDataDeCadastro  : String;
      FTelefoneCliente : String;

      FPreChe: String;
      FMsgOco: String;
      FDtaCon: String;
      FLnkPag: String;
      FCodRas: String;

      FAutInc: String;

      FFisAce: String;
      FSerie_: String;

      FAutIncNotfic: String;

      FTotDup: Double;
      FTotRec: Double;
      FTotDeb: Double;

      FGruOco  : String;
      FDtaOco  : String;
      FDtaCoc  : String;
      FTipOco  : String;
      FComOco  : String;
      FOpeori  : String;
      FComDes  : String;
      FLeadDoc : String;
      FHisOco  : String;
      FProOco  : String;
      FUsuDes  : String;

      FAssincrono: Boolean;

      FNumCsh: String;
      FDtaCsh: String;
      FVlrCsh: String;
      FDtaVal: String;
      FTotDsp: String;

      FStaEnt: String;
      FDesEnt: String;
      FLikRas: String;

      FInfAdi: String;

      FNomLoj: String;

      FCgcEmp: String;
      FCgcCli: String;
      FHorEmi: String;
      FEndEmp: String;
      FEndCli: String;

      FNomMot: String;

      function  fTemEmailAtivo(AblnEhApenasVerificacaoSeModeloEstaAtivado: Boolean = False): Boolean;
      function  fEnviaEmailAutomatico(blnEnviar: Boolean = True): Boolean;
      function fEnviaArquivo: Boolean;
      function fEnviaArquivoXML: Boolean;
      function fEnviaArquivoXLS: Boolean;
      function fGetCorpoMensagem : TStringArray;
      function fGetAssuntoMensagem : String;
      procedure CarregaDadosProvedorDoModelo(ACarregaModelo: Boolean = False);
      function fEhEnvioDeXmlDeNfParaFornecedor: Boolean;
      function fRetEmailParaEnvioDoXmlAoFornecedor: String;
      function fEhEnvioDeXmlDeNfParaTransportadora: Boolean;
      function fRetEmailParaEnvioDoXmlATransportadora: String;

      Constructor Create(Owner: TComponent); override;
      Destructor  Destroy; override;

      class function fGetProvedor(AOpcDoc, ACodGru, ACodigo: String): String;

    published

      property strCodigo: String      Read FCodigo Write FCodigo;
      property strCodGru: String      Read FCodGru Write FCodGru;
      property strEspDoc: String      Read FEspDoc Write FEspDoc;
      property strOpcDoc: String      Read FOpcDoc Write FOpcDoc;
      property strNumOrc: String      Read FNumOrc Write FNumOrc;
      property strEspOrc: String      Read FEspOrc Write FEspOrc;
      property strNumDoc: String      Read FNumDoc Write FNumDoc;
      property strEmpDoc: String      Read FEmpDoc Write FEmpDoc;
      property strEmpOri: String      Read FEmpOri Write FEmpOri;
      property strAssunt: String      Read FAssunt Write FAssunt;
      property strModelo: String      Read FModelo Write FModelo;
      property strCorpo : String      Read FCorpo  Write FCorpo;
      property staStatus: TStatusDisparaEmail     Read FStatus Write FStatus;
      property strProved: String      Read FProved Write FProved;

      property strCidCli: String        Read FCidCli Write FCidCli;
      property strOrcVen: String        Read FOrcVen Write FOrcVen;
      property strPedVen: String        Read FPedVen Write FPedVen;
      property strDocVen: String        Read FDocVen Write FDocVen;
      property strNroVen: String        Read FNroVen Write FNroVen;
      property strEspVen: String        Read FEspVen Write FEspVen;
      property strEmpVen: String        Read FEmpVen Write FEmpVen;
      property strTransp: String        Read FTransp Write FTransp;
      property strNomCli: String        Read FNomCli Write FNomCli;
      property strPriCli: String        Read FPriCli Write FPriCli;
      property strEmaCli: String        Read FEmaCli Write FEmaCli;
      property CopiaOcultaRemetente: Boolean     Read FCopiaOcultaRemetente Write FCopiaOcultaRemetente;
      property strCodOpe: String        Read FCodOpe Write FCodOpe;
      property strSenha : String        Read FSenha  Write FSenha;
      property strEmail : String        Read FEmail  Write FEmail;
      property strLogin : String        Read FLogin  Write FLogin;
      property intCodPrv: Integer       Read FCodPrv Write FCodPrv;
      property intPorSmt: Integer       Read FPorSmt Write FPorSmt;
      property intPorIma: Integer       Read FPorIma Write FPorIma;
      property strSerSmt: String        Read FSerSmt Write FSerSmt;
      property strSerIma: String        Read FSerIma Write FSerIma;
      property intLimArq: Integer       Read FLimArq Write FLimArq;
      property blnImgAss: Boolean       Read FImgAss Write FImgAss;
      property strTxtAss: String        Read FTxtAss Write FTxtAss;
      property strImgCor: String        Read FImgCor Write FImgCor;
      property mmsImaAss: TMemoryStream Read FImaAss Write FImaAss;
      property strArqBol: String        Read FArqBol Write FArqBol;
      property strArquiv: TArray<TRecArquivosGatilhos> Read FArquiv Write FArquiv;
      property strRemete: String        Read FRemete Write FRemete;
      property blnSSLSai: Boolean       Read FSSLSai Write FSSLSai;
      property blnSSLEnt: Boolean       Read FSSLEnt Write FSSLEnt;
      property blnEnvDoc: Boolean       Read FEnvDoc Write FEnvDoc;
      property blnEnvXml: Boolean       Read FEnvXML Write FEnvXML;
      property blnEnvXLS: Boolean       Read FEnvXLS Write FEnvXLS;
      property strCodCli: String        Read FCodCli Write FCodCli;
      property strDocCon: String        Read FDocCon Write FDocCon;
      property strLinDig: String        Read FLinDig Write FLinDig;
      property QrCodePix: String        Read FQrCodePix Write FQrCodePix;
      property strDtaEmi: String        Read FDtaEmi Write FDtaEmi;
      property strValDup: String        Read FValDup Write FValDup;
      property strParcel: String        Read FParcel Write FParcel;
      property strDtaVen: String        Read FDtaVen Write FDtaVen;
      property strNumeOs: String      Read FNumeOS Write FNumeOS;
      property strCodCup: String        Read FCOdCup Write FCodCup;
      property strCorpoAdicional: String read FCorpoAdicional write FCorpoAdicional;
      property CorpoEmailFixo: String read FCorpoEmailFixo write FCorpoEmailFixo;
      property ArrDup   : TArrDupTabelaEmail read FArrDup write FArrDup;
      property DiasVencimento: String read FDiasVencimento write FDiasVencimento;

      property strGravaPastaEnviados: String Read FGravaPastaEnviados Write FGravaPastaEnviados;

      property strPreChe: String read FPreChe write FPreChe;
      property strMsgOco: String read FMsgOco write FMsgOco;
      property strDtaCon: String read FDtaCon write FDtaCon;
      property strLnkPag: String read FLnkPag write FLnkPag;

      property strAutIncNotfic: String Read FAutIncNotfic Write FAutIncNotfic;

      property strGruOco: String  read FGruOco   write FGruOco;
      property strDtaOco: String  read FDtaOco   write FDtaOco;
      property strDtaCoc: String  read FDtaCoc   write FDtaCoc;
      property strTipOco: String  read FTipOco   write FTipOco;
      property strComOco: String  read FComOco   write FComOco;
      property strOpeori: String  read FOpeori   write FOpeori;
      property strComDes: String  read FComDes   write FComDes;
      property strLeadDoc:String  read FLeadDoc  write FLeadDoc;
      property strHisOco: String  read FHisOco   write FHisOco;
      property strProOco: String  read FProOco   write FProOco;
      property strUsuDes: String  read FUsuDes   write FUsuDes;
      property blnAssincrono: Boolean read FAssincrono write FAssincrono default True;

      property strNumCsh: String read FNumCsh write FNumCsh;
      property strDtaCsh: String read FDtaCsh write FDtaCsh;
      property strVlrCsh: String read FVlrCsh write FVlrCsh;
      property strDtaVal: String read FDtaVal write FDtaVal;
      property strTotDsp: String read FTotDsp write FTotDsp;

      property strNomLoj: String read FNomLoj write FNomLoj;

      property strInfAdi: String Read FInfAdi Write FInfAdi;
  End;

implementation

{ TEmaAut }

uses untConstantes, untTEnvioEmail, untImagemBase64,
     untFuncoesGenerica, untTCadastroProvedores, untIntelipost.webhook,
     untDadosEnviaGatilhoEmail,
     untDllGatIme;

procedure TEmaAut.CarregaDadosDoProvedor(ACodigoProvedor: Integer);
  Var
    LDatasetProvedor: TUniClientDataset;
begin
   If ACodigoProvedor <= 0 Then
     Exit;

  LDatasetProvedor := TCadastroProvedores.RetornaProvedorPorID(ACodigoProvedor);

  Try
    FCodPrv := LDatasetProvedor.FieldByName('PRV_CODPRV').AsInteger;
    FPorSmt := LDatasetProvedor.FieldByName('PRV_PORPRV').AsInteger;
    FSerSmt := LDatasetProvedor.FieldByName('PRV_URSMTP').AsString;
    FPorIma := LDatasetProvedor.FieldByName('PRV_PTIMAP').AsInteger;
    FSerIma := LDatasetProvedor.FieldByName('PRV_URIMAP').AsString;
    FLimArq := LDatasetProvedor.FieldByName('PRV_LIMARQ').AsInteger;

    FGravaPastaEnviados := LDatasetProvedor.FieldByName('PRV_GRVENV').AsString;
    FSSLSai := LDatasetProvedor.FieldByName('PRV_SSLSAI').AsString.Equals('S');
    FSSLEnt := LDatasetProvedor.FieldByName('PRV_SSLENT').AsString.Equals('S');

    FUsaAuthenticacaoOAuth2 := LDatasetProvedor.FieldByName('PRV_USAOA2').AsString.Equals('S');
    FClientId := LDatasetProvedor.FieldByName('PRV_CLI_ID').AsString;
    FClientSecret := LDatasetProvedor.FieldByName('PRV_CLISEC').AsString;
    FTenantId := LDatasetProvedor.FieldByName('PRV_TENAID').AsString;
  Finally
    LDatasetProvedor.Close;

    FreeAndNil(LDatasetProvedor);
  End;
end;

procedure TEmaAut.CarregaDadosProvedorDoModelo(ACarregaModelo: Boolean = False);
begin
  If fTemEmailAtivo Then
  Begin
    If ACarregaModelo Then
      PCarregaModeloEmail;

    pCarregaDadosConexao;
  End;
end;

constructor TEmaAut.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  qryGeneric := fCriaQuery(Self);

  FSenha  := '';
  FEmail  := '';
  FLogin  := '';
  FCodPrv := 0;
  FPorSmt := 0;
  FSerSmt := '';
  FPorIma := 0;
  FSerIma := '';
  FLimArq := 0;
  FImgAss := False;
  FTxtAss := '';
  FRemete := '';
  FSSLSai := False;
  FSSLEnt := False;
  FLinDig := '';
  FCupDes := '';
  FTotCup := '';
  FInfCup := '';
  FDtaEmi := '';
  FValDup := '';
  FParcel := '';
  FDtaVen := '';
  FLnkPag := '';
  FNumeOS := '';
  FGravaPastaEnviados := 'S';
  FNroCtr := '';
  FTotDup := 0;
  FTotRec := 0;
  FTotDeb := 0;
  FNumCsh := EmptyStr;
  FDtaCsh := EmptyStr;
  FVlrCsh := EmptyStr;
  FDtaVal := EmptyStr;
  FTotDsp := EmptyStr;

  FCidPed := EmptyStr;
  FUF_Ped := EmptyStr;
  FEndPed := EmptyStr;
  FBaiPed := EmptyStr;
  FComPed := EmptyStr;
  FRefEnd := EmptyStr;
  FCepPed := EmptyStr;

  mmsImaAss := TMemoryStream.Create;

  FUsaAuthenticacaoOAuth2 := False;
end;

destructor TEmaAut.Destroy;
begin

  FreeAndNil(qryGeneric);
  mmsImaAss.Free;

  inherited destroy;
end;

function TEmaAut.fAcertaVariaveisModelo(strModTmp: String): String;
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
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FEmaCli)
      Else If (arrVarEma[intContador][0] = '<<DTAEMI>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FDtaEmi)
      Else If (arrVarEma[intContador][0] = '<<VALDUP>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FValDup)
      Else If (arrVarEma[intContador][0] = '<<PARCEL>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FParcel)
      Else If (arrVarEma[intContador][0] = '<<DTAVEN>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FDtaVen)
      Else If (arrVarEma[intContador][0] = '<<CUPDES>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FCupDes)
      Else If (arrVarEma[intContador][0] = '<<TOTCUP>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FTotCup)
      Else If (arrVarEma[intContador][0] = '<<INFCUP>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FInfCup)
      Else If (arrVarEma[intContador][0] = '<<NUMEOS>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FNumeOS)
      Else If (arrVarEma[intContador][0] = '<<TABDUP>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], IIF(FCodGru <> '025',
                                                                        fCarregaTabelaDups(),
                                                                        GeraTabelaDuplicatasAvisoDebito(FArrDup)))
      Else If (arrVarEma[intContador][0] = '<<NROCON>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FNumDoc)
      Else If (arrVarEma[intContador][0] = '<<ESPCON>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FEspDoc)
      Else If (arrVarEma[intContador][0] = '<<EMPCON>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], IfThen(fEmptyStr(FEmpDoc), VS_strCodEmp, FEmpDoc))
      Else If (arrVarEma[intContador][0] = '<<DOCCON>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FDocCon)
      Else If (arrVarEma[intContador][0] = '<<QRCODE>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FQrCodePix)
      Else If (arrVarEma[intContador][0] = '<<TABDUPPX>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], GeraTabelaDuplicatasPix(FArrDup))
      Else If (arrVarEma[intContador][0] = '<<NOMVEN>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FVendedor)
      Else If (arrVarEma[intContador][0] = '<<VALORC>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FValorOrcamento)
      Else If (arrVarEma[intContador][0] = '<<DTACAD>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FDataDeCadastro)
      Else If (arrVarEma[intContador][0] = '<<TELCLI>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FTelefoneCliente)
      Else If (arrVarEma[intContador][0] = '<<PRECHE>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FPreChe)
      Else If (arrVarEma[intContador][0] = '<<MSGOCO>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FMsgOco)
      Else If (arrVarEma[intContador][0] = '<<DTACON>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FDtaCon)
      Else If (arrVarEma[intContador][0] = '<<LNKPAG>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FLnkPag)
      Else If (arrVarEma[intContador][0] = '<<NROCTR>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FNroCtr)
      Else If (arrVarEma[intContador][0] = '<<TOTDUP>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], Format('%m', [FTotDup]))
      Else If (arrVarEma[intContador][0] = '<<TOTREC>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], Format('%m', [FTotRec]))
      Else If (arrVarEma[intContador][0] = '<<TOTDEB>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], Format('%m', [FTotDeb]))
      Else If (arrVarEma[intContador][0] = '<<TBDCNF>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], fCarregaTabelaDupsDocsConfirmados)
        Else If (arrVarEma[intContador][0] = '<<GRUOCO>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FGruOco)
      Else If (arrVarEma[intContador][0] = '<<DTAOCO>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FDtaOco)
      Else If (arrVarEma[intContador][0] = '<<DTACOC>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FDtaCoc)
      Else If (arrVarEma[intContador][0] = '<<TIPOCO>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FTipOco)
      Else If (arrVarEma[intContador][0] = '<<COMOCO>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FComOco)
      Else If (arrVarEma[intContador][0] = '<<OPEORI>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FOpeori)
      Else If (arrVarEma[intContador][0] = '<<COMDES>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FComDes)
      Else If (arrVarEma[intContador][0] = '<<LEADOC>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FLeadDoc)
      Else If (arrVarEma[intContador][0] = '<<HISOCO>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FHisOco)
      Else If (arrVarEma[intContador][0] = '<<PROOCO>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FProOco)
      Else If (arrVarEma[intContador][0] = '<<USUDES>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FUsuDes)
      Else If (arrVarEma[intContador][0] = '<<CODCLI>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FCodCli)
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
      Else If (arrVarEma[intContador][0] = '<<VALPED>>') Then
        Result := AnsiReplaceStr(Result, arrVarEma[intContador][0], FValorOrcamento)
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
    .Replace('<<NOMMOT>>', FNomMot);

end;

Function TEmaAut.fTabelaAdicionaLinha( ArrIndice : Integer) : String;
 Var strLnh : String;
Begin

     strLnh := '<TR>'+
                       '<TD>' + ArrDup[ArrIndice].strNumDoc + '-' + ArrDup[ArrIndice].strEspDoc + '-' + ArrDup[ArrIndice].strCodEmp + '</TD>'+
                       '<TD>' + ArrDup[ArrIndice].strParcel + '</TD>'+
                       '<TD>' + FormatFloat('R$ ###,###,##0.00',ArrDup[ArrIndice].fltVlrDup)  + '</TD>'+
                       '<TD>' + DateToStr(ArrDup[ArrIndice].dtaDtaVen) + '</TD>'+
                       '<TD>' + ArrDup[ArrIndice].strLinDig + '</TD>'+
               '</TR>';

     result := strLnh;
End;

Function TEmaAut.fCarregaTabelaDups : String;
 Var
     intContador : Integer;
     strTabela, strLinhasTabela : String;
Begin
  strTabela   := '';

  If Length(ArrDup) > 0 Then
  Begin

    // TITULO ->  *(NRO DOCTO-ESP-EMP)| *PARCELA | *VALOR | *VENCIMENTO | *LINHA DIGITAVEL
    strTabela := '<TABLE borderColor=black cellSpacing=0 cellPadding=3 width="75%" align=center border=1>'+
                 '<TBODY>'+
                 '<TR bgColor=#b8b8b8>'+
                   '<TD>DOCUMENTO</TD>'+
                   '<TD>PARCELA</TD>'+
                   '<TD>VALOR</TD>'+
                   '<TD>VENCIMENTO</TD>'+
                   '<TD>LINHA DIGITAVEL</TD>'+
                 '</TR>';

    strLinhasTabela := '';

    For intContador := 0 To Length(ArrDup) -1 Do
        strLinhasTabela := strLinhasTabela + fTabelaAdicionaLinha( intContador );

    strTabela := strTabela + strLinhasTabela;

    strTabela := strTabela + '</TBODY>';
    strTabela := strTabela + '</TABLE>';

  End;

  result := strTabela;
End;

function TEmaAut.fCarregaTabelaDupsDocsConfirmados: String;
Var
  intContador : Integer;
begin
  Result := EmptyStr;

  if Length(ArrDup) > 0 then
  begin

    Result := '<TABLE borderColor=black cellSpacing=0 cellPadding=3 border=1>'+
                '<TBODY>'+
                  '<TR bgColor=#b8b8b8>'+
                  '<TD width="160px" align=center>DOCUMENTO</TD>'+
                  '<TD width="80px" align=center>EMISSÃO</TD>'+
                  '<TD align=center>VENCIMENTO</TD>'+
                  '<TD width="120px" align=right>VALOR</TD>'+
             '</TR>';

    For intContador := 0 To Length(ArrDup) -1 Do
        Result := Result + '<TR>'+
                             '<TD align=center>' + ArrDup[intContador].strNumDoc + ArrDup[intContador].strParcel + '-' + ArrDup[intContador].strEspDoc + '-' + ArrDup[intContador].strCodEmp + '</TD>'+
                             '<TD align=center>' + DateToStr(ArrDup[intContador].dtaDtaCad) + '</TD>'+
                             '<TD align=center>' + DateToStr(ArrDup[intContador].dtaDtaVen) + '</TD>'+
                             '<TD align=right>' + FormatFloat('R$ ###,###,##0.00',ArrDup[intContador].fltVlrDup) + '</TD>'+
                            '</TR>';
  end;
end;

function TEmaAut.fEhEnvioDeXmlDeNfParaFornecedor: Boolean;
begin
  Result := ((FOpcDoc = 'AN') and (FEspOrc = 'EF'));
end;

function TEmaAut.fEhEnvioDeXmlDeNfParaTransportadora: Boolean;
begin
  Result := ((FOpcDoc = 'AN') and (FEspOrc = 'ET'));
end;

function TEmaAut.fEhPedidoSendoGravadoPelaRotinaDeOrcamento: Boolean;
begin
  Result := ((FEspDoc = 'PD') and (FOpcDoc = 'OR'));
end;

function TEmaAut.fEhPedidoSendoGravadoPelaRotinaDeVendaNormal: Boolean;
begin
  Result := ((FEspDoc = 'PD') and (FOpcDoc = 'VN'));
end;

function TEmaAut.fEhTransformacaoDe_OR_Em_PD: Boolean;
begin
  Result := ((FEspDoc = 'PD') and (FEspOrc = 'OR') and (not fEmptyStr(FNumOrc)));
end;

function TEmaAut.fEnviaArquivo: Boolean;
begin
  Result := FEnvDoc;
end;

function TEmaAut.fEnviaArquivoXML: Boolean;
begin
  Result := FEnvXML;
end;

function TEmaAut.fEnviaEmailAutomatico(blnEnviar: Boolean): Boolean;
Var
  DadosEnviaGatilhoEmail: TDadosEnviaGatilhoEmail;
  LArquivo: TRecArquivosGatilhos;
  arrImgCorpo: TArray<String>;
  strImgCorpo: String;
begin
  Result := False;

  If (fEmptyStr(FEmaCli)) Or
     (Not fValidarEmail(FEmaCli, False)) Then
    Exit;

  Try
    pSetaDados;

    pCarregaModeloEmail;

    pCarregaDadosConexao;

    If (Not blnEnviar) Then
      Exit(True);

    for LArquivo in FArquiv do
    begin
      if (not fEhArquivoBase64(LArquivo.Arquivo)) and (not fArquivoExisteNoDiretorio(LArquivo.Arquivo, 40, 2000)) then
        Exit;
    end;

    DadosEnviaGatilhoEmail := TDadosEnviaGatilhoEmail.Create;
    try
      DadosEnviaGatilhoEmail.provedor.tipoProvedorEnvio := FProved;

      DadosEnviaGatilhoEmail.chavesPrimarias.autIncNotfic := FAutIncNotfic;

      DadosEnviaGatilhoEmail.operador.codigoOperador := FCodOpe;
      DadosEnviaGatilhoEmail.operador.nomeOperador := fRetNomeOperador(FCodOpe);

      DadosEnviaGatilhoEmail.cliente.codigoCliente := FCodCli;

       If FCopiaOcultaRemetente Then
        DadosEnviaGatilhoEmail.email.copiaOculta := [FEmail];

      arrImgCorpo := FImgCor.Split([';']);
      for strImgCorpo in arrImgCorpo do
        DadosEnviaGatilhoEmail.email.pAddImagemCorpo(TDadosImagemCorpo
                                                       .fNew
                                                       .fPath(strImgCorpo)
                                                       .fBase64(fRetornarArquivoBase64(strImgCorpo))
                                                     );

      DadosEnviaGatilhoEmail.email.envioAutomaticoCobranca := FEnvAutCob;
      DadosEnviaGatilhoEmail.email.duplicatas := FArrDup;
      DadosEnviaGatilhoEmail.email.gravarAnexos := ((FOpcDoc = 'CF') and (fCfgSis('MOVDIG', varBoolean)));

      DadosEnviaGatilhoEmail.gatilho.codigoGrupo := FCodGru;
      DadosEnviaGatilhoEmail.gatilho.codigoGatilho := FCodigo;
      DadosEnviaGatilhoEmail.gatilho.numeroDocumento := FNumDoc;
      DadosEnviaGatilhoEmail.gatilho.especieDocumento := FEspDoc;
      DadosEnviaGatilhoEmail.gatilho.OpcDocumento := FOpcDoc;
      DadosEnviaGatilhoEmail.gatilho.empresaDocumento := FEmpDoc;

      Result := TDllGatime
                  .fNew
                  .fGravarGatilhoImediato(TRecGatilhoImediato
                                            .Create(FAssunt,
                                                    FCorpo,
                                                    FArquiv,
                                                    DadosEnviaGatilhoEmail.ToJsonString,
                                                    FCodOpe,
                                                    EmptyStr,
                                                    FEmaCli)
                                          );

    finally
      FreeAndNil(DadosEnviaGatilhoEmail);
    end;
  Except
    On E: Exception Do
      If FEnvAutCob Then
        pGravarErro(True, E.Message + ' [TEmaAut.fEnviaEmailAutomatico]'{$IFNDEF LINUX}, fRetornaStack{$ENDIF})
      Else
        pMensagensErro(E.Message, '[TEmaAut.fEnviaEmailAutomatico]');
  End;
end;

function TEmaAut.fGetCorpoMensagem: TStringArray;
begin
  If fEmptyStr(FCorpo) Then
  Begin
    pCarregaCodigosDoModelo;
    pSetaDados;
    pCarregaModeloEmail;
  End;
  Result := [FCorpo];
end;

function TEmaAut.fGetAssuntoMensagem: String;
begin
  If fEmptyStr(FAssunt) Then
  Begin
    pCarregaCodigosDoModelo;
    pSetaDados;
    pCarregaModeloEmail;
  End;
  Result := FAssunt;
end;

class function TEmaAut.fGetProvedor(AOpcDoc, ACodGru, ACodigo: String): String;
  Var
    objEmaAut: TEmaAut;
begin
  Result := '';
  Try
    objEmaAut := TEmaAut.Create(Nil);

    objEmaAut.FOpcDoc := AOpcDoc;
    objEmaAut.FCodGru := ACodGru;
    objEmaAut.FCodigo := ACodigo;
    objEmaAut.FCodOpe := strLoginUsuarioLogado;

    If objEmaAut.fTemEmailAtivo Then
    Begin
      objEmaAut.pCarregaModeloEmail;
      objEmaAut.pCarregaDadosConexao;
      Result := objEmaAut.intCodPrv.ToString;
    End;

  Finally
    FreeAndNil(objEmaAut);
  End;
end;

procedure TEmaAut.pCarregaModeloEmail;
Var
  strSQL   : String;
begin

  Try

    strSQL := '';
    strSQL := strSQL + 'SELECT        ';
    strSQL := strSQL + '  EMA_PROENV, ';
    strSQL := strSQL + '  MOD_ASSUNT, ';
    strSQL := strSQL + '  MOD_MODELO, ';
    strSQL := strSQL + '  MODEMA.AUTOINCREM  ';
    strSQL := strSQL + 'FROM          ';
    strSQL := strSQL + '  EMASAI      ';
    strSQL := strSQL + '  INNER JOIN MODEMA ON MOD_SEQGER = EMASAI.AUTOINCREM ';
    strSQL := strSQL + 'WHERE        ';
    strSQL := strSQL + '  EMA_CODIGO = :CODIGO AND ';
    strSQL := strSQL + '  EMA_CODGRU = :CODGRU AND ';
    strSQL := strSQL + '  EMA_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  EMA_ENTSAI = "S"         ';

    With qryGeneric Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODIGO').AsString := FCodigo;
      ParamByName('CODGRU').AsString := FCodGru;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      FProved := FieldByName('EMA_PROENV').AsString;
      FAssunt := fAcertaVariaveisModelo(FieldByName('MOD_ASSUNT').AsString);
      FAssunt := IfEmptyStr(FAssunt, '(Sem Assunto)');
      FModelo := FieldByName('MOD_MODELO').AsString;
      FCorpo  := fAcertaVariaveisModelo(FieldByName('MOD_MODELO').AsString);
    End;

    pCriaImagensModeloEmail(qryGeneric.FieldByName('AUTOINCREM').AsString, FImgCor);

    if not fEmptyStr(strCorpoAdicional) then
      FCorpo := FCorpo + strCorpoAdicional;

    If Not fEmptyStr(FCorpoEmailFixo) Then
     FCorpo := FCorpoEmailFixo;
  Except
    On E: Exception Do
      If FEnvAutCob Then
        pGravarErro(True, E.Message + ' [TEmaAut.pCarregaModeloEmail]', fRetornaStack)
      Else
        pMensagensErro(e.Message, '[TEmaAut.pCarregaModeloEmail]');
  End;

end;

procedure TEmaAut.pCriaImagensModeloEmail(strSeqGer: String; Var strPatImg: String);
Var
  strSQL   : String;
  qryImg   : TUniQuery;
  strPasImg, strModelo, strOldPath, strNewPath: String;
  blnAtualizarModelo: Boolean;
  i, intPosIni, intPosFim: Integer;
  tmpImg: TBytesStream;
begin

  Try

    tmpImg := TBytesStream.Create(nil);

    strPatImg := '';
    strPasImg := ExtractFilePath(Application.ExeName) + PASTA_IMAGEM_EMAIL_AUT + '\';
    strModelo := FModelo;
    blnAtualizarModelo := False;

    If (Not DirectoryExists(strPasImg)) Then
      MkDir(strPasImg);

    qryImg := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'SELECT   ';
    strSQL := strSQL + '  IMG_NOMIMG AS NOMIMG, ';
    strSQL := strSQL + '  IMG_IMAGEM AS IMAGEM, ';
    strSQL := strSQL + '  IMG_IMGB64 AS IMGB64  ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  IMGMOD ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  IMG_SEQGER = :SEQGER ';

    With qryImg Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('SEQGER').AsString := strSeqGer;
      Open;

      While Not Eof Do
      Begin
        If (Not FileExists(strPasImg + FieldByName('NOMIMG').AsString)) Then
        Begin
          If FieldByName('IMAGEM').isNull Then
          Begin
            fStreamFromBase64(FieldByName('IMGB64').AsString, tmpImg);
            If (tmpImg.Size > 0) Then
              tmpImg.SaveToFile(strPasImg + FieldByName('NOMIMG').AsString);
          End
          Else
            TBlobField(FieldByName('IMAGEM')).SaveToFile(strPasImg + FieldByName('NOMIMG').AsString);
        End;

        If (fEmptyStr(strPatImg)) Then
          strPatImg := strPasImg + FieldByName('NOMIMG').AsString
        Else
          strPatImg := strPatImg + ';' + strPasImg + FieldByName('NOMIMG').AsString;

        If (Pos(strPasImg + FieldByName('NOMIMG').AsString, FModelo) <= 0) Then Begin
          intPosIni := 0;
          intPosFim := Pos(FieldByName('NOMIMG').AsString, strModelo) +
                           Length(FieldByName('NOMIMG').AsString);

          For i := intPosFim DownTo 0 Do Begin
            If (strModelo[i] = '<') Then Begin
              intPosIni := i;
              Break;
            End;
          End;

          For i := intPosFim To Length(strModelo) - 1 Do Begin
            If (strModelo[i] = '>') Then Begin
              intPosFim := i;
              Break;
            End;
          End;

          If (intPosIni > 0) And (intPosFim > 0) Then Begin
            strOldPath := Copy(strModelo, intPosIni, intPosFim - intPosIni + 1);
            strNewPath := strOldPath;

            intPosIni := Pos('src="', strNewPath) + 5;
            intPosFim := Pos(FieldByName('NOMIMG').AsString, strNewPath) +
                           Length(FieldByName('NOMIMG').AsString);

            strNewPath := AnsiReplaceStr(strNewPath,
                                         Copy(strNewPath, intPosIni, intPosFim - intPosIni),
                                         strPasImg + FieldByName('NOMIMG').AsString);

            FModelo := AnsiReplaceStr(FModelo,
                                      strOldPath,
                                      strNewPath);

            FCorpo  := AnsiReplaceStr(FCorpo,
                                      strOldPath,
                                      strNewPath);

            If (Not blnAtualizarModelo) Then blnAtualizarModelo := True;
          End;
        End;

        Next;
      End;

      If (blnAtualizarModelo) Then pAtualizarModelo(strSeqGer);
    End;

  Finally
    FreeAndNil(qryImg);
    FreeAndNil(tmpImg);
  End;
end;

procedure TEmaAut.pInformacoesBoleto;
var
  qryCadRec: TUniQuery;
begin
  qryCadRec := fCriaQuery;
  try
    qryCadRec.Close;
    qryCadRec.SQL.Text :=
    ' SELECT '+
    '   * ' +
    ' FROM '+
    '   CADREC'+
    ' WHERE '+
    '   CTR_DTAREC IS NULL   AND '+
    '   CTR_VALDUP > 0       AND '+
    '   CTR_NUMDUP = :NUMDOC AND '+
    '   CTR_CODCLI = :CODCLI AND '+
    '   CTR_CODEMP = :CODEMP AND '+
    '   CTR_ESPDOC = :ESPDOC ';

    qryCadRec.ParamByName('NUMDOC').AsString := FNumDoc;
    qryCadRec.ParamByName('CODCLI').AsString := FCodCli;
    qryCadRec.ParamByName('CODEMP').AsString := FEmpDoc;
    qryCadRec.ParamByName('ESPDOC').AsString := FEspDoc;
    qryCadRec.Open;

    if qryCadRec.IsEmpty then
      Exit;

    FLinDig := qryCadRec.FieldByName('CTR_LINDIG').AsString;
    FDtaEmi := FormatDateTime('dd/mm/yy', qryCadRec.FieldByName('CTR_DTACAD').AsDateTime);
    FValDup :=  FormatFloat( '#,##0.00', qryCadRec.FieldByName('CTR_VALDUP').AsFloat);
    FParcel := qryCadRec.FieldByName('CTR_PARCEL').AsString;
    FDtaVen := FormatDateTime('dd/mm/yy', qryCadRec.FieldByName('CTR_DTAVEN').AsDateTime);
    FArrDup   := RetornaTabelaDuplicata(qryCadRec);
  finally
    FreeAndNil(qryCadRec);
  end;
end;

procedure TEmaAut.pInformacoesCashback;
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

function TEmaAut.fRetornaStatusParaEmail: TStatusDisparaEmail;
begin
  Result := staNenhumaAcao;

  If ((FOpcDoc = 'OR') Or
      (FEspOrc = 'OR') Or
      (FEspDoc = 'OR')) And
      (not fEhAgendamentoDeEnvioDeOrcamento) And
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

  Else If (SameText(FOpcDoc, 'CD')) Then
    Result := FStatus

  Else If (SameText(FOpcDoc, 'BO')) Then
    Result := FStatus

  Else If (SameText(FOpcDoc, 'BN')) Then
  Begin
    if (FEspDoc = 'NF') then
      Result := staNFeAutComBoleto;
  End

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

  Else If (SameText(FOpcDoc, 'CB')) Then
    Result := staCobrancaEletronica

  Else If (FOpcDoc = 'AN') Then
  Begin
    If (FEspDoc = 'NF') Then
    Begin
      if (FEspOrc = 'AT') Or (fEmptyStr(FEspOrc)) then
        Result := staAutorizadaNFe
      else if FEspOrc = 'EF' then
        Result := staAutorizadaNFeEnvioFornecedor
      else if (FEspOrc = 'ET') then
        Result := staAutorizadaNFeEnvioTransportadora;
    End
    Else If (FEspDoc = 'IF') Then
    Begin
      if (FEspOrc = 'AT') Or (fEmptyStr(FEspOrc))then
        Result := staAutorizadaNFCe;
    End
    Else If (FEspDoc = 'NS') Then
    Begin
      if (FEspOrc = 'AT') Or (fEmptyStr(FEspOrc)) then
        Result := staAutorizadaNFSe;
    End;
  End

  Else If FOpcDoc = 'FF' Then
    Result := staIncluindo

  Else If FOpcDoc = 'RC' Then
    Result := staReimpressaoCobranca

  Else If (SameText(FOpcDoc, 'AD')) Then
    Result := FStatus

  Else If FOpcDoc = 'CH' Then
  Begin
    If FEspOrc = '7A' Then
      Result := staCashback7DiasAVencer
    Else
      Result := staCashbackVenda
  End

  Else If FOpcDoc = 'CL' Then
  Begin
    If FEspOrc = 'PS' then
      Result := staPesquisaSatisfacao;
  End

  Else If (FOpcDoc = 'AI') Then
  Begin
    If (FEspOrc = 'AS') Then
      Result := staAlteracaoStatusEntrega;
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

function TEmaAut.fRetornaTransportadoraDocumento: String;
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

function TEmaAut.fTemEmailAtivo(AblnEhApenasVerificacaoSeModeloEstaAtivado: Boolean = False): Boolean;
Var
  strSQL : String;
begin

  Result := False;

  pSetaDados;
  pCarregaCodigosDoModelo;

  Try

    strSQL := '';
    strSQL := strSQL + 'SELECT       ';
    strSQL := strSQL + '  EMA_CODIGO,';
    strSQL := strSQL + '  MOD_ENVDOC,';
    strSQL := strSQL + '  MOD_ENVXML,';
    strSQL := strSQL + '  MOD_ENVXLS ';
    strSQL := strSQL + 'FROM         ';
    strSQL := strSQL + '  EMASAI     ';
    strSQL := strSQL + '  INNER JOIN MODEMA ON MOD_SEQGER = EMASAI.AUTOINCREM ';

    If FCodGru = '009' Then
      strSQL := strSQL + '  INNER JOIN CFGEMA ON CFG_SEQGER = EMASAI.AUTOINCREM ';

    strSQL := strSQL + 'WHERE        ';
    strSQL := strSQL + '  EMA_CODIGO = :CODIGO AND ';
    strSQL := strSQL + '  EMA_CODGRU = :CODGRU AND ';
    strSQL := strSQL + '  EMA_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  EMA_STATUS = "A"     AND ';
    strSQL := strSQL + '  EMA_ENTSAI = "S"         ';

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
                           '     INTERVAL EMA_INTENV DAY '+
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
                           '     INTERVAL EMA_INTENV DAY '+
                           '   ) '+
                           '   AND NOT_GATILH = "CL" '+
                           '   AND NOT_NOTFIC = "PS" )',
                           '');

    If fCfgSis('EMASAI', VarString) = 'Desativado' Then
    Begin
      strSQL := strSQL + ' AND FALSE ';
    End;

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

      if ((fEhPesquisaDeSatisfacao) and (AblnEhApenasVerificacaoSeModeloEstaAtivado)) then
        qryGeneric.ParamByName('CODCLI').AsString := FCodCli;

      qryGeneric.Open;
    End;

    Result := (Not qryGeneric.IsEmpty);
    If Result Then
    Begin
      if FOpcDoc = 'CF' then
        FEnvDoc := fCfgSis('MOVDIG', varBoolean)
      else
        FEnvDoc := (qryGeneric.FieldByName('MOD_ENVDOC').AsString = 'S');
    End;

    FEnvXML := (qryGeneric.FieldByName('MOD_ENVXML').AsString = 'S');
    FEnvXLS := (qryGeneric.FieldByName('MOD_ENVXLS').AsString = 'S');
  Except
    On E: Exception Do
      If FEnvAutCob Then
        pGravarErro(True, E.Message + ' [TEmaAut.fTemEmailAtivo]', fRetornaStack)
      Else
        pMensagensErro(e.Message, '[TEmaAut.fTemEmailAtivo]');
  End;

end;

function TEmaAut.fEhPesquisaDeSatisfacao: Boolean;
begin
  Result := ((FOpcDoc = 'CL') and (FEspOrc = 'PS'));
end;

function TEmaAut.GeraTabelaDuplicatasAvisoDebito(
  ADuplicatas: TArrDupTabelaEmail): String;
  Var
    LTotalCorrigido: Double;

    LDuplicata: TDupTabelaEmail;
begin
  Result := '';

  If Length(ADuplicatas) = 0 Then
    Exit;

  LTotalCorrigido := 0;

  Result := Result +
            '<table borderColor=black cellSpacing=0 cellPadding=3 width="70%" align=center border=1>' + #13 +
            '  <tbody>' + #13 +
            '    <tr bgColor=#b8b8b8>' + #13 +
            '      <td width="20%">DUPLICATA</td>' + #13 +
            '      <td width="15%" align=center>EMISSÃO</td>' + #13 +
            '      <td width="15%" align=center>VENCIMENTO</td>' + #13 +
            '      <td width="20%" align=right>VALOR DUPLICATA</td>' + #13 +
            '      <td width="10%" align=right>VALOR JUROS</td>' + #13 +
            '      <td width="20%" align=right>VALOR CORRIGIDO</td>' + #13 +
            '    </tr>' + #13;

  For LDuplicata In FArrDup Do
  Begin
    Result := Result +
              '    <tr>' + #13 +
              '      <td>' + LDuplicata.strNumDoc +
                             LDuplicata.strParcel + '-' +
                             LDuplicata.strEspDoc + '-' +
                             LDuplicata.strCodEmp + '</td>' + #13 +
              '      <td align=center>' + FormatDateTime('dd/mm/yyyy', LDuplicata.dtaDtaCad) + '</td>' + #13 +
              '      <td align=center>' + FormatDateTime('dd/mm/yyyy', LDuplicata.dtaDtaVen) + '</td>' + #13 +
              '      <td align=right>' + FormatFloat(',0.00', LDuplicata.fltVlrDup) + '</td>' + #13 +
               '      <td align=right>' + FormatFloat(',0.00', LDuplicata.ValorJuros) + '</td>' + #13 +
              '      <td align=right>' + FormatFloat(',0.00', LDuplicata.ValorCorrigido) + '</td>' + #13 +
              '    </tr>' + #13;

    LTotalCorrigido := LTotalCorrigido + LDuplicata.ValorCorrigido;
  End;

  Result := Result +
            '    <tr>' + #13 +
            '      <td colspan=6 align=right>TOTAL CORRIGIDO: ' + FormatFloat(',0.00', LTotalCorrigido) + '</td>' + #13 +
            '    </tr>' + #13 +
            '  </tbody>' + #13 +
            '</table>';
end;

function TEmaAut.GeraTabelaDuplicatasPix(ADuplicatas: TArrDupTabelaEmail): String;
  Var
    LTotalRecebido: Double;

    LDuplicata: TDupTabelaEmail;
begin
  Result := '';

  If Length(ADuplicatas) = 0 Then
    Exit;

  LTotalRecebido := 0;

  Result := Result +
            '<table borderColor=black cellSpacing=0 cellPadding=3 width="70%" align=center border=1>' + #13 +
            '  <tbody>' + #13 +
            '    <tr bgColor=#b8b8b8>' + #13 +
            '      <td width="20%">DUPLICATA</td>' + #13 +
            '      <td width="15%" align=center>EMISSÃO</td>' + #13 +
            '      <td width="15%" align=center>VENCIMENTO</td>' + #13 +
            '      <td width="16%" align=right>VALOR DUPLICATA</td>' + #13 +
            '      <td width="16%" align=right>VALOR CORRIGIDO</td>' + #13 +
            '      <td width="18%" align=right>VALOR A PAGAR</td>' + #13 +
            '    </tr>' + #13;

  For LDuplicata In FArrDup Do
  Begin
    Result := Result +
              '    <tr>' + #13 +
              '      <td>' + LDuplicata.strNumDoc +
                             LDuplicata.strParcel + '-' +
                             LDuplicata.strEspDoc + '-' +
                             LDuplicata.strCodEmp + '</td>' + #13 +
              '      <td align=center>' + FormatDateTime('dd/mm/yyyy', LDuplicata.dtaDtaCad) + '</td>' + #13 +
              '      <td align=center>' + FormatDateTime('dd/mm/yyyy', LDuplicata.dtaDtaVen) + '</td>' + #13 +
              '      <td align=right>' + FormatFloat(',0.00', LDuplicata.fltVlrDup) + '</td>' + #13 +
              '      <td align=right>' + FormatFloat(',0.00', LDuplicata.ValorCorrigido) + '</td>' + #13 +
              '      <td align=right>' + FormatFloat(',0.00', LDuplicata.ValorRecebido) + '</td>' + #13 +
              '    </tr>' + #13;

    LTotalRecebido := LTotalRecebido + LDuplicata.ValorRecebido;
  End;

  Result := Result +
            '    <tr>' + #13 +
            '      <td colspan=6 align=right>TOTAL A PAGAR: ' + FormatFloat(',0.00', LTotalRecebido) + '</td>' + #13 +
            '    </tr>' + #13 +
            '  </tbody>' + #13 +
            '</table>';
end;

procedure TEmaAut.pAtualizarModelo(strSeqGer: String);
  Var
    strSQL: String;
    qryTemp: TUniQuery;
begin
  Try
    qryTemp := fCriaQuery(Nil);

    strSQL := 'UPDATE MODEMA SET MOD_MODELO = :MODELO WHERE AUTOINCREM = :AUTINC';

    With qryTemp Do Begin
      Close();
      SQL.Clear();
      SQL.Add(strSQL);
      ParamByName('AUTINC').AsString := strSeqGer;
      ParamByName('MODELO').AsString := FModelo;
      ExecSQL();
    End;
  Finally
    FreeAndNil(qryTemp);
  End;
end;

function TEmaAut.fEhAgendamentoDeEnvioDeOrcamento: Boolean;
begin
  Result := (FEspOrc = 'EA');
end;

procedure TEmaAut.pCarregaCodigosDoModelo;
begin
  If ((SameText(FOpcDoc, 'OR')) Or
      (SameText(FEspOrc, 'OR')) Or
      (SameText(FEspDoc, 'OR')) Or
      (FStatus = staTransformando)) And
      (not fEhAgendamentoDeEnvioDeOrcamento) And
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

  Else If (SameText(FOpcDoc, 'PD')) Or (fEhPedidoSendoGravadoPelaRotinaDeVendaNormal) Or (fEhPedidoSendoGravadoPelaRotinaDeOrcamento) Or (SameText(FEspOrc, 'FT') And (Pos(FOpcDoc, 'E2_E3_E4_E5_') <= 0)) Then
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
    FCodGru := '006';

    If (FStatus = staIncluindo) Then
      FCodigo := '001'
    Else If (FStatus = staBaixando) Then
      FCodigo := '002';
  End

  Else If (SameText(FOpcDoc, 'E5')) Then
  Begin
    FCodGru := '007';

    If (FStatus = staIncluindo) Then
      FCodigo := '001'
    Else If (FStatus = staImprimindoSeparacao) Then
      FCodigo := '002'
    Else If (FStatus = staConferindo) Then
      FCodigo := '003'
    Else If (FStatus = staFaturandoParcial) Then
      FCodigo := '004'
    Else If (FStatus = staFaturandoTotal) Then
      FCodigo := '005'
    Else If (FStatus = staAtivando) Then
      FCodigo := '006'
    Else If (FStatus = staBaixando) Then
      FCodigo := '007';
  End

  Else If (SameText(FOpcDoc, 'BO')) Then
  Begin
    FCodGru := '008';
    if FStatus = staConfirmandoDocumento then
      FCodigo := '002'
    Else If FStatus = staCancelandoBoleto Then
      FCodigo := '003'
    Else
      FCodigo := '001'
  End

  Else If (SameText(FOpcDoc, 'BN')) Then
  Begin
    FCodGru := '008';
    If FStatus = staNFeAutComBoleto Then
      FCodigo := '004'
  End

  Else If (SameText(FOpcDoc, 'AC')) Then
  Begin
    FCodGru := '009';
    If (FStatus = sta1DiaVencer) Then
      FCodigo := '004'
    Else If (FStatus = sta2DiasVencer) Then
      FCodigo := '001'
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
    Else If (FStatus = sta3DiasVencido) Then
      FCodigo := '002'
    Else If (FStatus = sta4DiasVencido) Then
      FCodigo := '010'
    Else If (FStatus = sta5DiasVencido) Then
      FCodigo := '003'
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
    FCodGru := '014';
    FCodigo := '001';

    If FStatus = staPixParaCreditoCliente Then
      FCodigo := '002';
  End

  Else If (SameText(FOpcDoc, 'EF')) Then
  begin
    FCodGru := '015';
    FCodigo := '001';
  End

  Else If (SameText(FOpcDoc, 'TE')) Then
  Begin
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
    FCodGru := '039';
    If (FStatus = staCobrancaEletronica) Then
      FCodigo := '001';
  End

  Else If (SameText(FOpcDoc, 'AN')) Then
  Begin
    If (FStatus = staAutorizadaNFe) Then
    Begin
      FCodGru := '035';
      FCodigo := '001';
    End
    Else If (FStatus = staAutorizadaNFeEnvioFornecedor) Then
    Begin
      FCodGru := '035';
      FCodigo := '002';
    End
    Else If (FStatus = staAutorizadaNFeEnvioTransportadora) Then
    Begin
      FCodGru := '035';
      FCodigo := '004';
    End
    Else If (FStatus = staAutorizadaNFCe) Then
    Begin
      FCodGru := '036';
      FCodigo := '001';
    End
    Else If (FStatus = staAutorizadaNFSe) Then
    Begin
      FCodGru := '038';
      FCodigo := '001';
    End;
  End

  Else If FOpcDoc = 'FF' Then
  Begin
    FCodGru := '037';
    If (FStatus = staIncluindo) Then
      FCodigo := '001';
  End

  Else If FOpcDoc = 'RC' Then
  Begin
    FCodGru := '022';
    If (FStatus = staReimpressaoCobranca) Then
       FCodigo := '001';
  End

  Else If FOpcDoc = 'RL' Then
  Begin
    FCodGru := '023';
    FCodigo := '001';
  End

  Else If FOpcDoc = 'AD' Then
  Begin
    FCodGru := '025';
    FCodigo := '001';

    If FStatus = staAvisoDebitoDia16 Then
     FCodigo := '002';
  End

  Else If FOpcDoc = 'ET' Then
  Begin
    FCodGru := '027';
    FCodigo := '001';
  End

  Else If (SameText(FOpcDoc, 'CH')) Then
  Begin
    FCodGru := '029';
    If (FStatus = staCashbackVenda) Then
      FCodigo := '001'
    Else If (FStatus = staCashback7DiasAVencer) Then
      FCodigo := '002';
  End

  Else If (SameText(FOpcDoc, 'CL')) Then
  Begin
    FCodGru := '040';
    If FStatus = staPesquisaSatisfacao then
      FCodigo := '001';
  End

  Else If (SameText(FOpcDoc, 'AI')) Then
  Begin
    FCodGru := '030';
    If FStatus = staAlteracaoStatusEntrega Then
      FCodigo := '001';
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

procedure TEmaAut.pCarregaDadosConexao;
begin
  If (FProved = 'F') Then
    pCarregaDadosConexaoFixa
  Else
  Begin
    If (fCfgSis('EMLEMP', varBoolean)) Then
      pCarregaDadosConexaoEmpresa
    Else
      pCarregaDadosConexaoOperador;
  End;
end;

procedure TEmaAut.pCarregaDadosConexaoFixa;
Var
  strSQL   : String;
  qryEmaSai: TUniQuery;
begin
  qryEmaSai := fCriaQuery(Nil);

  Try
    Try
      strSQL := '';
      strSQL := strSQL + 'SELECT   ';
      strSQL := strSQL + '  CFG_SENEMA,  ';
      strSQL := strSQL + '  CFG_EMAIL_,  ';
      strSQL := strSQL + '  CFG_EMALOG,  ';
      strSQL := strSQL + '  CFG_REMETE,  ';
      strSQL := strSQL + '  CFG_ASSB64,  ';
      strSQL := strSQL + '  CFG_ASSTXT,  ';
      strSQL := strSQL + '  PRV_CODPRV,  ';
      strSQL := strSQL + '  PRV_PORPRV,  ';
      strSQL := strSQL + '  PRV_URSMTP,  ';
      strSQL := strSQL + '  PRV_PTIMAP,  ';
      strSQL := strSQL + '  PRV_URIMAP,  ';
      strSQL := strSQL + '  PRV_LIMARQ,  ';
      strSQL := strSQL + '  PRV_SSLSAI,  ';
      strSQL := strSQL + '  PRV_SSLENT,  ';
      strSQL := strSQL + '  PRV_GRVENV   ';
      strSQL := strSQL + 'FROM     ';
      strSQL := strSQL + '  EMASAI ';
      strSQL := strSQL + '  INNER JOIN CFGEMA ON CFG_SEQGER = EMASAI.AUTOINCREM ';
      strSQL := strSQL + '  INNER JOIN CADPRV ON PRV_CODPRV = CFG_CODPRV        ';
      strSQL := strSQL + 'WHERE    ';
      strSQL := strSQL + '  EMA_CODIGO = :CODIGO AND ';
      strSQL := strSQL + '  EMA_CODGRU = :CODGRU AND ';
      strSQL := strSQL + '  EMA_CODEMP = :CODEMP AND ';
      strSQL := strSQL + '  EMA_ENTSAI = "S"         ';

      qryEmaSai.SQL.Text := strSQL;
      qryEmaSai.ParamByName('CODIGO').AsString := FCodigo;
      qryEmaSai.ParamByName('CODGRU').AsString := FCodGru;
      qryEmaSai.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryEmaSai.Open;

      If (Not qryEmaSai.IsEmpty) Then
      Begin
        FSenha  := CriptografarSenhaEmail(qryEmaSai.FieldByName('CFG_SENEMA').AsString);
        FEmail  := qryEmaSai.FieldByName('CFG_EMAIL_').AsString;
        FLogin  := qryEmaSai.FieldByName('CFG_EMALOG').AsString;
        FRemete := qryEmaSai.FieldByName('CFG_REMETE').AsString;

        CarregaDadosDoProvedor(qryEmaSai.FieldByName('PRV_CODPRV').AsInteger);

        FImgAss := (Not fEmptyStr(qryEmaSai.FieldByName('CFG_ASSB64').AsString));
        FTxtAss := AnsiReplaceStr(qryEmaSai.FieldByName('CFG_ASSTXT').AsString, STRING_QUEBRA, STRING_ENTER);

        If (FImgAss) Then
          pCarregaImagemAssinatura(qryEmaSai.FieldByName('CFG_ASSB64').AsString);
      End;
    Except
      On E: Exception Do
      Begin
        If FEnvAutCob Then
          pGravarErro(True, E.Message + ' [TEmaAut.pCarregaDadosConexaoFixa]', fRetornaStack)
        Else
          pMensagensErro(e.message, '[TEmaAut.pCarregaDadosConexaoFixa]');
      End;
    End;
  Finally
    qryEmaSai.Close;

    FreeAndNil(qryEmaSai);
  End;
end;

procedure TEmaAut.pCarregaDadosConexaoOperador;
Var
  strSQL   : String;
  qryCadOpe: TUniQuery;
begin
  qryCadOpe := fCriaQuery(Nil);

  Try
    Try
      strSQL := '';
      strSQL := strSQL + 'SELECT   ';
      strSQL := strSQL + '  *      ';
      strSQL := strSQL + 'FROM     ';
      strSQL := strSQL + '  CADOPE ';
      strSQL := strSQL + '  INNER JOIN CADPRV ON PRV_CODPRV = OPE_CODPRV ';
      strSQL := strSQL + '  LEFT  JOIN OPEASS ON ASS_CODOPE = OPE_CODOPE ';
      strSQL := strSQL + 'WHERE    ';
      strSQL := strSQL + '  OPE_CODOPE = :CODOPE ';

      qryCadOpe.SQL.Text := strSQL;
      qryCadOpe.ParamByName('CODOPE').AsString := FCodOpe;
      qryCadOpe.Open;

      If (Not qryCadOpe.IsEmpty) Then
      Begin
        FSenha := CriptografarSenhaEmail(qryCadOpe.FieldByName('OPE_PRVSEN').AsString);
        FEmail := qryCadOpe.FieldByName('OPE_E_MAIL').AsString;
        FLogin := qryCadOpe.FieldByName('OPE_EMALOG').AsString;
        FRemete := qryCadOpe.FieldByName('OPE_E_NOME').AsString;

        CarregaDadosDoProvedor(qryCadOpe.FieldByName('PRV_CODPRV').AsInteger);

        If (Not fEmptyStr(qryCadOpe.FieldByName('ASS_CODOPE').AsString)) Then
        Begin
          FImgAss := (Not fEmptyStr(qryCadOpe.FieldByName('ASS_IMGB64').AsString));
          FTxtAss := (AnsiReplaceStr(qryCadOpe.FieldByName('ASS_TEXTO_').AsString, STRING_QUEBRA, STRING_ENTER));

          If (FImgAss) Then
            pCarregaImagemAssinatura(qryCadOpe.FieldByName('ASS_IMGB64').AsString);
        End;
      End;

    Except
      On E: Exception Do
      Begin
        If FEnvAutCob Then
          pGravarErro(True, E.Message + ' [TEmaAut.fEnviaEmailAutomatico]', fRetornaStack)
        Else
          pMensagensErro(e.message, '[TEmaAut.pCarregaDadosConexaoOperador]');
      End;
    End;
  Finally
    qryCadOpe.Close;

    FreeAndNil(qryCadOpe);
  End;
end;

procedure TEmaAut.pCarregaDadosConexaoEmpresa;
  Var
    qryDados: TUniQuery;
begin
  qryDados := fCriaQuery(Nil);

  Try
    Try
      qryDados.Close;
      qryDados.SQL.Clear;
      qryDados.SQL.Text := ' SELECT * FROM                        '+
                           '   OPEEML                             '+
                           ' INNER JOIN                           '+
                           '   CADPRV ON PRV_CODPRV = EML_CODPRV  '+
                           ' WHERE EML_CODOPE = :CODOPE           '+
                           '   AND EML_CODEMP = :CODEMP           ';

      qryDados.ParamByName('CODOPE').AsString := FCodOpe;
      qryDados.ParamByName('CODEMP').AsString := Vs_strCodEmp;
      qryDados.Open;

      If (qryDados.IsEmpty) Then
        Exit;

      FSenha := CriptografarSenhaEmail(qryDados.FieldByName('EML_PRVSEN').AsString);
      FEmail := qryDados.FieldByName('EML_E_MAIL').AsString;
      FLogin := qryDados.FieldByName('EML_EMALOG').AsString;

      FCodPrv := qryDados.FieldByName('PRV_CODPRV').AsInteger;
      FPorSmt := qryDados.FieldByName('PRV_PORPRV').AsInteger;
      FSerSmt := qryDados.FieldByName('PRV_URSMTP').AsString;
      FPorIma := qryDados.FieldByName('PRV_PTIMAP').AsInteger;
      FSerIma := qryDados.FieldByName('PRV_URIMAP').AsString;
      FLimArq := qryDados.FieldByName('PRV_LIMARQ').AsInteger;

      FGravaPastaEnviados := (qryDados.FieldByName('PRV_GRVENV').AsString);
      FSSLSai := (qryDados.FieldByName('PRV_SSLSAI').AsString = 'S');
      FSSLEnt := (qryDados.FieldByName('PRV_SSLENT').AsString = 'S');

      If (Not fEmptyStr(qryDados.FieldByName('EML_IMGB64').AsString)) Then
      Begin
        FImgAss := (Not fEmptyStr(qryDados.FieldByName('EML_IMGB64').AsString));
        FTxtAss := (AnsiReplaceStr(qryDados.FieldByName('EML_TEXTO_').AsString, STRING_QUEBRA, STRING_ENTER));

        If (FImgAss) Then
          pCarregaImagemAssinatura(qryDados.FieldByName('EML_IMGB64').AsString);
      End;
    Except
      On E: Exception Do
      Begin
        If FEnvAutCob Then
          pGravarErro(True, E.Message + ' [TEmaAut.fEnviaEmailAutomatico]', fRetornaStack)
        Else
          pMensagensErro(e.message, '[TEmaAut.pCarregaDadosConexaoEmpresa]');
      End;
    End;
  Finally
    FreeAndNil(qryDados);
  End;
end;

procedure TEmaAut.pCarregaImagemAssinatura(strBase64: String);
var
  tmpImg: TBytesStream;
begin
  FImaAss.Clear();
  tmpImg := TBytesStream.Create(nil);
  fStreamFromBase64(strBase64, tmpImg);

  Try
    If (tmpImg.Size > 0) Then
    Begin
      tmpImg.SaveToStream(mmsImaAss);
      mmsImaAss.Seek(0, soFromBeginning);
    End;
  Finally
    tmpImg.Free;
  End;
end;

procedure TEmaAut.pSetaDados;
begin
  FStatus := fRetornaStatusParaEmail;
  pSetaVariaveisDoModeloEmail;
end;

{procedure TEmaAut.pSetAssunto(Value: String);
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

function TEmaAut.fRetLinkPagamento: String;
Var
  qryConsulta: TUniQuery;
  strSQL   : String;
begin
  Result := '';

  qryConsulta := fCriaQuery;
  Try
    strSQL := '';
    if fUsaLinkPagamentoSitefCielo then
    begin
      strSQL := strSQL + ' SELECT S.SIT_URLPGT AS CBE_LNKPAG ';
      strSQL := strSQL + '       FROM SITCOB S ';
      strSQL := strSQL + '            INNER JOIN EXTGOR EG ON S.SIT_NUMNIT = EG.FGO_SITNIT AND S.SIT_MERCID = EG.FGO_SITMID ';
      strSQL := strSQL + '            INNER JOIN FATGOR F  ON F.AUTOINCREM = EG.FGO_SEQFGO ';
      strSQL := strSQL + '       WHERE F.FGO_NUMDOC = :NUMDOC ';
      strSQL := strSQL + '             AND F.FGO_ESPDOC = :ESPDOC ';
      strSQL := strSQL + '             AND F.FGO_CODEMP = :CODEMP ';
    end
    else
    begin
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '       CBE_LNKPAG ';
      strSQL := strSQL + '  FROM COBELT ';
      strSQL := strSQL + ' WHERE CBE_NUMDOC = :NUMDOC ';
      strSQL := strSQL + '   AND CBE_ESPDOC = :ESPDOC ';
      strSQL := strSQL + '   AND CBE_CODEMP = :CODEMP ';
      strSQL := strSQL + '   AND CBE_APICOB NOT IN ("PMEC") ';
    end ;

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

function TEmaAut.fRetDataHoraEntregue: String;
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

procedure TEmaAut.pRetInformacoesGeraisRomaneio;
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

function TEmaAut.fRetEmailParaEnvioDoXmlAoFornecedor: String;
var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);
  try
    qryAux.Close;
    qryAux.SQL.Text :=
    ' SELECT '+
    '   GROUP_CONCAT(DISTINCT FOR_EMAIL_ SEPARATOR ";") AS FOR_EMAIL_ '+
    ' FROM '+

    '   (SELECT '+
    '     DET_CODITE, '+
    '     DET_CODEMP, '+
    '     DET_CODMAR '+
    '   FROM '+
    '     MOVDET '+
    '   WHERE DET_NUMDOC = :NUMDOC '+
    '     AND DET_ESPDOC = :ESPDOC '+
    '     AND DET_CODEMP = :EMPORI '+
    '     AND DET_CODCLI = :CODCLI '+
    '     AND DET_SERIE_ = :SERIE_ '+

    '   UNION '+

    '   SELECT '+
    '     DET_CODITE, '+
    '     DET_CODEMP, '+
    '     DET_CODMAR '+
    '   FROM '+
    '     NOTDET '+
    '   WHERE DET_NUMDOC = :NUMDOC '+
    '     AND DET_ESPDOC = :ESPDOC '+
    '     AND DET_CODEMP = :EMPORI '+
    '     AND DET_CODCLI = :CODCLI '+
    '     AND DET_SERIE_ = :SERIE_) NF '+

    '   INNER JOIN CADITE '+
    '     ON DET_CODITE = ITE_CODITE '+
    '   INNER JOIN XMLFOR '+
    '     ON FOR_CODEMP = DET_CODEMP '+
    '     AND FOR_CODDEP = ITE_CODDEP '+
    '     AND FOR_CODMAR = DET_CODMAR ';

    qryAux.ParamByName('NUMDOC').AsString := FNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := FEspDoc;
    qryAux.ParamByName('EMPORI').AsString := FEmpOri;
    qryAux.ParamByName('CODCLI').AsString := FCodCli;
    qryAux.ParamByName('SERIE_').AsString := FSerie_;
    qryAux.Open;

    Result := qryAux.FieldByName('FOR_EMAIL_').AsString;
  finally
    FreeAndNil(qryAux);
  end;
end;

function TEmaAut.fRetEmailParaEnvioDoXmlATransportadora: String;
var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);
  try
    qryAux.Close;
    qryAux.SQL.Clear;
	qryAux.SQL.Add(' SELECT TRA_EMAIL_ ');
	qryAux.SQL.Add(' FROM MOVGER ');
	qryAux.SQL.Add(' INNER JOIN CADTRA ON TRA_CODTRA = GER_CODTRA ');
	qryAux.SQL.Add(' WHERE ');
	qryAux.SQL.Add('   GER_NUMDOC = :NUMDOC AND ');
	qryAux.SQL.Add('   GER_ESPDOC = :ESPDOC AND ');
	qryAux.SQL.Add('   GER_CODEMP = :CODEMP AND ');
	qryAux.SQL.Add('   GER_CODCLI = :CODCLI AND ');
	qryAux.SQL.Add('   GER_SERIE_ = :SERIE_; ');
    qryAux.ParamByName('NUMDOC').AsString := FNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := FEspDoc;
    qryAux.ParamByName('CODEMP').AsString := FEmpOri;
    qryAux.ParamByName('CODCLI').AsString := FCodCli;
    qryAux.ParamByName('SERIE_').AsString := FSerie_;
    qryAux.Open;

    Result := qryAux.FieldByName('TRA_EMAIL_').AsString;
  finally
    FreeAndNil(qryAux);
  end;
end;

function TEmaAut.fRetMensagemOcorrenciaDeEntrega: String;
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

function TEmaAut.fRetNroContratoPelaFatura(const strEmpDoc, strEspDoc,
  strNumDoc: String): String;
var
  qryLocEqu: TUniQuery;
begin
  Result := '';

  qryLocEqu := fCriaQuery;
  try
    qryLocEqu.Close;
    qryLocEqu.SQL.Text :=
      'SELECT MAX(EQL_NROCON) AS EQL_NROCON ' +
      'FROM CONEQL ' +
      'INNER JOIN EQLFAT ON (CONEQL.AUTOINCREM = EQF_SEQCON) '+
      'WHERE EQF_EMPDOC = :EMPDOC ' +
      '  AND EQF_ESPDOC = :ESPDOC ' +
      '  AND EQF_NUMDOC = :NUMDOC ' ;

    qryLocEqu.ParamByName('EMPDOC').AsString := strEmpDoc;
    qryLocEqu.ParamByName('ESPDOC').AsString := strEspDoc;
    qryLocEqu.ParamByName('NUMDOC').AsString := strNumDoc;
    qryLocEqu.Open;

    If Not qryLocEqu.IsEmpty Then
      Result := qryLocEqu.FieldByName('EQL_NROCON').AsString;

  finally
    FreeAndNil(qryLocEqu);
  end;
end;

function TEmaAut.fRetPrevisaoDoHorarioDeChegada: String;
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

procedure TEmaAut.pSetaVariaveisDoModeloEmail;
var
  LCodigoEmpresa : String;
begin
  FOrcVen := '';
  FPedVen := '';
  FDocVen := '';
  FNroVen := '';
  FEmpVen := '';
  FEspVen := '';

  FVendedor        := '';
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

  LCodigoEmpresa := IfThen(fEmptyStr(FEmpDoc), VS_strCodEmp, FEmpDoc);

  FNomLoj := fRetFantasiaEmpresa(LCodigoEmpresa);

  If (FEspDoc = 'OR') Then
  Begin
    FOrcVen := (FNumDoc + '-' + FEspDoc + '-' + LCodigoEmpresa);
  End

  Else If (FEspDoc = 'PD') Then
  Begin
    If (FEspOrc = 'OR') Then
      FOrcVen := (FNumOrc + '-' + FEspOrc + '-' + FEmpOri);

    FPedVen := (FNumDoc + '-' + FEspDoc + '-' + LCodigoEmpresa);
    pCarregaEnderecoPedido(FNumDoc, FEspDoc, IfThen(fEmptyStr(FEmpDoc), VS_strCodEmp, FEmpDoc), FCodCli);
  End

  Else If (FEspDoc <> 'OR') And (FEspDoc <> 'PD') Then
  Begin
    If (FEspOrc = 'OR') Then
      FOrcVen := (FNumOrc + '-' + FEspOrc + '-' + FEmpOri)
    Else If (Pos(FEspOrc, 'PD_FT_') > 0) Or (Pos(FOpcDoc, 'E3_E4_') > 0) Then
      FPedVen := (FNumOrc + '-' + 'PD' + '-' + FEmpOri);
  End;

  FDocVen := (FNumDoc + '-' + FEspDoc + '-' + LCodigoEmpresa);

  FNroVen := FNumDoc;
  FEmpVen := LCodigoEmpresa;
  FEspVen := FEspDoc;

  FTransp := fRetornaTransportadoraDocumento;

  FCupDes := GetNumeroCupom(FNumDoc, FEspDoc, LCodigoEmpresa, FCodCup);
  FTotCup := FormatFloat(fMskDigitos(2), GetDescontoCupom(FCupDes));
  FInfCup := GetInformacoesCupom(FCupDes);

  FDocCon := fRetornaDocumentosConfirmados;

  TInfDocumento.New(FNumDoc, FEspDoc, LCodigoEmpresa).fLoadVendedor        (FVendedor)
                                                     .fLoadValorDocumento  (FValorOrcamento)
                                                     .fLoadDataDeCadastro  (FDataDeCadastro)
                                                     .fLoadTelefoneCliente (FTelefoneCliente);

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
    if FEspDoc = 'PD' then
      FLnkPag := fRetLinkPagamento;
  end;

  If FOpcDoc = 'RL' Then
    FNroCtr := fRetNroContratoPelaFatura(FEmpDoc, FEspDoc, FNumDoc);

  If FOpcDoc = 'CF' Then
    FarrDup := fRetornaTabelaDuplicataDocsConfirmados;

  if FOpcDoc = 'BN' then
    pInformacoesBoleto;

  If FOpcDoc = 'CH' Then
    pInformacoesCashback;

  if FOpcDoc = 'AI' then
    pInformacoesIntelipost;

  if ((FOpcDoc = 'AN') OR (FOpcDoc = 'BN')) and ((FEspdoc = 'NF') or (FEspdoc = 'IF') or (FEspdoc = 'NS')) then
    pCarregaInformacoesDocumentoFiscal;
end;

procedure TEmaAut.pCarregaEnderecoPedido(ANumDoc, AEspDoc, AEmpDoc, ACodCli: String);
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

procedure TEmaAut.pInformacoesIntelipost;
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

function TEmaAut.RetornaTabelaDuplicata(ADataSet:TDataSet): TArrDupTabelaEmail;
begin
  Try
    SetLength(Result,0);

    ADataset.First;

    While Not ADataset.Eof Do
    Begin
      SetLength(Result,Length(Result) + 1);
      Result[Length(Result)-1].strNumDoc := ADataSet.FieldByName('CTR_NUMDUP').AsString;
      Result[Length(Result)-1].strParcel := ADataSet.FieldByName('CTR_PARCEL').AsString;
      Result[Length(Result)-1].strEspDoc := ADataSet.FieldByName('CTR_ESPDOC').AsString;
      Result[Length(Result)-1].strCodEmp := ADataSet.FieldByName('CTR_CODEMP').AsString;
      Result[Length(Result)-1].strCodCli := ADataSet.FieldByName('CTR_CODCLI').AsString;
      Result[Length(Result)-1].dtaDtaCad := ADataSet.FieldByName('CTR_DTACAD').AsDatetime;
      Result[Length(Result)-1].dtaDtaVen := ADataSet.FieldByName('CTR_DTAVEN').AsDatetime;
      Result[Length(Result)-1].fltVlrDup := ADataSet.FieldByName('CTR_VALDUP').AsFloat;
      Result[Length(Result)-1].strAutoIn := ADataSet.FieldByName('AUTOINCREM').AsString;
      Result[Length(Result)-1].intSeqBai := ADataSet.FieldByName('CTR_SEQBAI').AsInteger;
      Result[Length(Result)-1].strLinDig := ADataSet.FieldByName('CTR_LINDIG').AsString;

      ADataset.Next;
    End;
  Except
    On E:Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;

function TEmaAut.fRetornaTabelaDuplicataDocsConfirmados: TArrDupTabelaEmail;
var
  qryCadRec: TUniQuery;
begin
  qryCadRec := fCriaQuery;
  try
    Try
      qryCadRec.Close;
      qryCadRec.SQL.Text :=
      ' SELECT '+
      '    CTR_NUMDUP, '+
      '    CTR_PARCEL, '+
      '    CTR_ESPDOC, '+
      '    CTR_CODEMP, '+
      '    CTR_CODCLI, '+
      '    CTR_DTACAD, '+
      '    CTR_DTAVEN, '+
      '    CTR_VALDUP, '+
      '    AUTOINCREM, '+
      '    CTR_SEQBAI, '+
      '    CTR_LINDIG  '+
      ' FROM '+
      '   CTRCNF'+
      ' WHERE '+
      '   CTR_DOCCNF = :NUMDOC AND '+
      '   CTR_CLICNF = :CODCLI AND '+
      '   CTR_EMPCNF = :CODEMP AND '+
      '   CTR_ESPCNF = :ESPDOC '+
      ' ORDER BY '+
      '   CTR_DTACAD ';

      qryCadRec.ParamByName('NUMDOC').AsString := FNumDoc;
      qryCadRec.ParamByName('CODCLI').AsString := FCodCli;
      qryCadRec.ParamByName('CODEMP').AsString := IfThen(fEmptyStr(FEmpDoc), VS_strCodEmp, FEmpDoc);
      qryCadRec.ParamByName('ESPDOC').AsString := FEspDoc;
      qryCadRec.Open;

      SetLength(Result,0);
      FTotDup := 0;
      FTotRec := 0;
      FTotDeb := 0;

      qryCadRec.First;
      While Not qryCadRec.Eof Do
      Begin
        SetLength(Result,Length(Result) + 1);
        Result[Length(Result)-1].strNumDoc := qryCadRec.FieldByName('CTR_NUMDUP').AsString;
        Result[Length(Result)-1].strParcel := qryCadRec.FieldByName('CTR_PARCEL').AsString;
        Result[Length(Result)-1].strEspDoc := qryCadRec.FieldByName('CTR_ESPDOC').AsString;
        Result[Length(Result)-1].strCodEmp := qryCadRec.FieldByName('CTR_CODEMP').AsString;
        Result[Length(Result)-1].strCodCli := qryCadRec.FieldByName('CTR_CODCLI').AsString;
        Result[Length(Result)-1].dtaDtaCad := qryCadRec.FieldByName('CTR_DTACAD').AsDatetime;
        Result[Length(Result)-1].dtaDtaVen := qryCadRec.FieldByName('CTR_DTAVEN').AsDatetime;
        Result[Length(Result)-1].fltVlrDup := qryCadRec.FieldByName('CTR_VALDUP').AsFloat;
        Result[Length(Result)-1].strAutoIn := qryCadRec.FieldByName('AUTOINCREM').AsString;
        Result[Length(Result)-1].intSeqBai := qryCadRec.FieldByName('CTR_SEQBAI').AsInteger;
        Result[Length(Result)-1].strLinDig := qryCadRec.FieldByName('CTR_LINDIG').AsString;

        FTotRec := FTotRec + IIF(qryCadRec.FieldByName('CTR_VALDUP').AsFloat > 0, qryCadRec.FieldByName('CTR_VALDUP').AsFloat, 0);
        FTotDeb := FTotDeb + IIF(qryCadRec.FieldByName('CTR_VALDUP').AsFloat < 0, qryCadRec.FieldByName('CTR_VALDUP').AsFloat, 0);
        FTotDup := FTotDup + qryCadRec.FieldByName('CTR_VALDUP').AsFloat;

        qryCadRec.Next;
      End;
    Except
      On E:Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(qryCadRec);
  End;
end;

function TEmaAut.fRetornaDocumentosConfirmados: String;
Var
  qryConsulta: TUniQuery;
  strSQL   : String;
begin
  Result := '';

  qryConsulta := fCriaQuery;
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  GROUP_CONCAT(CONCAT(GER_NUMDOC, "-", GER_ESPDOC, "-", GER_CODEMP) ORDER BY GER_DTAENT, GER_HORENT SEPARATOR ", ") AS TEMP ';
    strSQL := strSQL + 'FROM MOVGER ';
    strSQL := strSQL + 'WHERE GER_NUMFAT = :NUMDOC ';
    strSQL := strSQL + '  AND GER_TIPFAT = :ESPDOC ';
    strSQL := strSQL + '  AND GER_EMPFAT = :CODEMP ';

    qryConsulta.Close;
    qryConsulta.SQL.Text := strSQL;
    qryConsulta.ParamByName('NUMDOC').AsString := FNumDoc;
    qryConsulta.ParamByName('ESPDOC').AsString := FEspDoc;
    qryConsulta.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryConsulta.Open;

    Result := qryConsulta.FieldByName('TEMP').AsString;

  Finally
    FreeAndNil(qryConsulta);
  End;

end;

{ TDocumento }

constructor TInfDocumento.Create(const ANumeroDocumento, AEspecieDocumento, AEmpresaDocumento: String);
const
  SQL = 'SELECT        ' +
        '  FGO_CODVEN, ' +
        '  OPE_NOMOPE, ' +
        '  FGO_VLRCON, ' +
        '  FGO_DTAENT, ' +
        '  FGO_CODCLI, ' +
        '  CLI_FONE01  ' +
        'FROM          ' +
        '  FATGOR      ' +
        '  INNER JOIN CADCLI ON (CLI_CODCLI = FGO_CODCLI) ' +
        '  INNER JOIN CADOPE ON (OPE_CODOPE = FGO_CODVEN) ' +
        'WHERE FGO_NUMDOC = :NUMDOC ' +
        '  AND FGO_ESPDOC = :ESPDOC ' +
        '  AND FGO_CODEMP = :CODEMP ';

begin

  If ANumeroDocumento.IsEmpty Then
    Exit;

  If AEspecieDocumento.IsEmpty Then
    Exit;

  If AEmpresaDocumento.IsEmpty Then
    Exit;

  FDocumento := fCriaQuery;

  FDocumento.Close;
  FDocumento.SQL.Clear;
  FDocumento.SQL.Add(SQL);

  FDocumento.ParamByName('NUMDOC').AsString := ANumeroDocumento;
  FDocumento.ParamByName('ESPDOC').AsString := AEspecieDocumento;
  FDocumento.ParamByName('CODEMP').AsString := AEmpresaDocumento;
  FDocumento.Open;

end;

function TInfDocumento.fDocumentoEncontrado: Boolean;
begin

  Result := False;

  If Not Assigned(FDocumento) Then
    Exit;

  If FDocumento.IsEmpty Then
    Exit;

  Result := True;

end;

function TInfDocumento.fLoadDataDeCadastro(var ADataDeCadastro: String): IInfDocumento;
begin

  Result := Self;

  If Not fDocumentoEncontrado Then
    Exit;

  If FDocumento.FieldByName('FGO_DTAENT').IsNull Then
    Exit;

  ADataDeCadastro := FormatDateTime('dd/mm/yyyy', FDocumento.FieldByName('FGO_DTAENT').AsDateTime);

end;

function TInfDocumento.fLoadTelefoneCliente(var ATelefoneCliente: String): IInfDocumento;
begin

  Result := Self;

  If Not fDocumentoEncontrado Then
    Exit;

  If FDocumento.FieldByName('CLI_FONE01').IsNull Then
    Exit;

  ATelefoneCliente := fFormataFone(FDocumento.FieldByName('CLI_FONE01').AsString);

end;

function TInfDocumento.fLoadValorDocumento(var AValorDocumento: String): IInfDocumento;
begin

  Result := Self;

  If Not fDocumentoEncontrado Then
    Exit;

  If FDocumento.FieldByName('FGO_VLRCON').IsNull Then
    Exit;

  AValorDocumento := FormatFloat('#,##0.00', FDocumento.FieldByName('FGO_VLRCON').AsFloat);

end;

function TInfDocumento.fLoadVendedor(var AVendedor: String): IInfDocumento;
begin

  Result := Self;

  If Not fDocumentoEncontrado Then
    Exit;

  If FDocumento.FieldByName('FGO_CODVEN').IsNull Then
    Exit;

  AVendedor := FDocumento.FieldByName('FGO_CODVEN').AsString + '-' +
               FDocumento.FieldByName('OPE_NOMOPE').AsString;
end;

class function TInfDocumento.New(const ANumeroDocumento, AEspecieDocumento, AEmpresaDocumento: String): IInfDocumento;
begin
  Result := TInfDocumento.Create(ANumeroDocumento, AEspecieDocumento, AEmpresaDocumento);
end;

function TEmaAut.fEnviaArquivoXLS: Boolean;
begin
  Result := FEnvXLS;
end;

procedure TEmaAut.pCarregaInformacoesDocumentoFiscal;
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

end.
