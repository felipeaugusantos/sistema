{**************************************}
{* CUIDADO AO ADICIONAR MENSAGENS     *}
{* NA ROTINA DE IMPRESSÃO DE BOLETOS. *}
{* PARA NÃO AFETAR O ENVIO AUTOMÁTICO *}
{* E TAMBÉM ROTINAS DE FATURAMENTO    *}
{**************************************}

unit untBoleto;

interface

uses Classes, UniClientDataSet, Uni, untFuncoesSimples, Data.DB, untTypesSistema,
     untDisparaEmailAut, untFuncoesBoleto, untTBoletoCarne, untTDigBoleto,
     untConstantes,untTMultiplosBancos, Vcl.Printers,untTBancoDoBrasilAPI,
     untGravando, untDigBoletoFaturamento, untDisparaSMSAut, untTBancoCredisisAPI,XMLDoc, XMLIntf, 
     untTBancoSicrediAPI, untTBoleto1Via_Comprovante, untTBancoItauAPI, untTBancoSicoobAPI,
     untTBancoSantanderAPI, untTBancoSafraAPI, untTBancoBradescoAPI, untArqNaoGravados;

Type
  TDupCtr = TDuplicataCtr;

  TBoleto = class(TComponent)
  Private
    FCodCar : Integer;
    FBcoIni : String;
    FValExt2: String;
    FCepCli : String;
    FMens02 : String;
    FMens01 : String;
    FValExt : String;
    FNosNum : String;
    FNumDig : String;
    FCgcCli : String;
    FValMor : Double;
    FCodBco : String;
    FCodPor : String;
    FDtaAtu : String;
    FPerMul : String;
    FDesCtr : Double;
    FMulta_ : Double;
    FValDes : Double;
    FBraCrr : String;
    FCodCli : String;
    FNomCli : String;
    FCidCli : String;
    FEstCli : String;
    FEndCli : String;
    FInsEst : String;
    FUltPar : String;
    FBB_Crr : String;
    FConCrr : String;
    FAltImp : Boolean;
    FBlnImp: Boolean;

    FobjStatusEmailAutomatico: TStatusDisparaEmail;

    cpuCampos: TCamposUso;
    qryConCli: TUniQuery;
    qryConRec: TUniQuery;
    qryConTot: TUniQuery;
    qryCfgRel: TUniQuery;

    blnFaturamento: Boolean;
    blnExpedicao  : Boolean;
    strNomFrm     : String;
    strNomImp     : String;
    strNomeTabela : String;

    FBoletoCarneBuilder : TBoletoCarneBuilder;
    FBoleto1ViaBuilder : TBoleto1Via_ComprovanteBuilder;
    FMultiplosBancos : TMultiplosBancos;
    FUtilizaMultiplosBancos : Boolean;
    FImprimiuSemPerguntar : Boolean;
    FReimpressao : Boolean;

    procedure pInicializaCamposUso;
    procedure pAtualizaCamposUso(ctrDup: TDupCtr);
    procedure pAtribuiCamposUso;
    procedure pFinalizaCamposUso;

    procedure pImprimePromissorias(ArrDupCtr: TArrDupCtr; strTipBol, strNomFrm, strNomImp: String);
    procedure pUpdateCadRec(ctrDup: TDupCtr);

    function fSelectNossoNumeroAnterior(ctrDup: TDupCtr): String;
    function fNossoNumeroAnterior(ctrDup: TDupCtr; blnManterPortador: Boolean): String;
    function BoletoJaImpresso(AAutoincrem : String):Boolean;
    function fRetNumCartReimpressao(strCartei: String): Integer;

    function fRetornaEmailCliente(cdsBoleto: TDataset): String;

    function fVerificaEmailAutmatico(objDuplicata: TDuplicataCtr): Boolean;
    function fVerificaWhatsappAutomatico(objDuplicata: TDuplicataCtr): Boolean;

    function fDigBoletoFinanceiro(recDados: TDadosTelaDigBoleto; arrCtrDup: TArrDupCtr): TDadosTelaDigBoleto;
    function fDigBoletoFaturamento(recDados: TDadosTelaDigBoleto; cdsAuxBol : TUniClientDataSet): TDadosTelaDigBoleto;

    function RetornaSelectLinkDoBoleto: String;

    function EnviarSMSBoletos(ADuplicatas: TArrDupCtr; ACorpoMensagemEMASAI: String; blnEnviaWhatsapp: Boolean = False; strArqBoletos: String = ''; AEnviarModal: Boolean = False; ABoletoCarne: Boolean = False; DestinatarioWhatsapp: TDestinatarioWhatsapp = nil): Boolean;
    function EnviarWhatsappBoletos(ADuplicatas: TArrDupCtr; ACorpoMensagemEMASAI, strArqBoletos: String; AEnviarModal: Boolean = False; ABoletoCarne: Boolean = False): Boolean;

    procedure RegistrarBoletoBancoDoBrasilAPI(Var ABancoDoBrasilApi        : TBancoDoBrasilAPI;
                                              Var AGerouBancoDoBrasilApi   : Boolean;
                                                  AarrCtrDup               : TArrDupCtr;
                                              Var ANosNum                  : String;
                                                  ACont                    : Integer);

    procedure RegistrarBoletoBancoCredisisAPI(Var ABancoCredisisApi        : TBancoCredisisAPI;
                                              Var AGerouBancoCredisisApi   : Boolean;
                                                  AarrCtrDup               : TArrDupCtr;
                                              Var ANosNum                  : String;
                                                  ACont                    : Integer);

    procedure RegistrarBoletoBancoSicrediAPI(Var ABancoSicrediApi          : TBancoSicrediAPI;
                                             Var AGerouBancoSicrediApi     : Boolean;
                                                 AarrCtrDup                : TArrDupCtr;
                                             Var ANosNum                   : String;
                                                 ACont                     : Integer);

    procedure ReimpressaoBoletoBancoCredisisAPI( Var LBancoApi : TBancoCredisisAPI; strAutoIncrem : String );


    procedure RegistrarBoletoBancoItauAPI(Var ABancoItauApi        : TBancoItauAPI;
                                          Var AGerouBancoItauApi   : Boolean;
                                              AarrCtrDup           : TArrDupCtr;
                                          Var ANosNum              : String;
                                              ACont                : Integer);

    procedure RegistrarBoletoBancoSicoobAPI(Var ABancoSicoobApi      : TBancoSicoobAPI;
                                            Var AGerouBancoSicoobApi : Boolean;
                                                AarrCtrDup           : TArrDupCtr;
                                            Var ANosNum              : String;
                                                ACont                : Integer);

    procedure RegistrarBoletoBancoSantanderAPI(Var ABancoSantanderApi      : TBancoSantanderAPI;
                                               Var AGerouBancoSantanderApi : Boolean;
                                                   AarrCtrDup              : TArrDupCtr;
                                               Var ANosNum                 : String;
                                                   ACont                   : Integer);

    procedure RegistrarBoletoBancoSafraAPI(Var ABancoSafraApi        : TBancoSafraAPI;
                                           Var AGerouBancoSafraApi   : Boolean;
                                               AarrCtrDup            : TArrDupCtr;
                                           Var ANosNum               : String;
                                               ACont                 : Integer);

    procedure RegistrarBoletoBancoBradescoAPI(Var ABancoBradescoApi      : TBancoBradescoAPI;
                                              Var AGerouBancoBradescoApi : Boolean;
                                                AarrCtrDup               : TArrDupCtr;
                                            Var ANosNum                  : String;
                                                ACont                    : Integer);

    function ValidaImpressaoBoleto: Boolean;
    procedure pTravarImpressaoBoletosBancoDoBrasilAPI;
    function fTravaImpressaoBoletosAtual(out AConIdDono, AChaveCompleta: String): String;
    function fConexaoDaTravaEncerrada(const AConIdDono: String): Boolean;
    function CarteiraValidaParaImpressaoDeBoleto(ACodBco,ACodIde: String):Boolean;

    function fCodPorEstaOuSeraPreenchido(frmDigBoletoFaturamento: TfrmDigBoletoFaturamento): Boolean;
    function fUtilizaBoletoCarne: Boolean;
    function fUtilizaBoleto1Via: Boolean;
    function fBancoUtilizaApenasLayoutPadrao: Boolean;

    function RetornaPastaBoletos(ACodigoEmpresaDuplicata: String;
                                 ABoletoCarne: Boolean; ABoleto1Via: Boolean): String;
    procedure ExibeFormMensagemErro(AMensagem: String);
  public
    blnEditaEmail,
    blnEtiCob: Boolean;
    blnPortadorAlterado: Boolean;
    blnEhBoletoMeiaNota: Boolean;

    FCodCnd : String;
    FCodFpg : String;
    FNotaPromissoria : Boolean;

    Constructor Create(Owner: TComponent; strNomeTabela: String; blnFaturamento: Boolean; blnExpedicao: Boolean=False); reintroduce;
    Destructor Destroy; Override;

    procedure pImprimir(cdsBoletos: TUniClientDataSet;
                            arrCtrDup: TArrDupCtr;
                            strBancoAnterior: String;
                            blnBolPdf,
                            blnEnvEml,
                            blnEmaAut: Boolean;
                            blnReimp: Boolean = False;
                            blnReimpParcial: Boolean = False;
                            strCartei: String = '';
                            strPerMor: String = '';
                            strPerMul: String = '';
                            strNomImpBol: String = '';
                            strOrdCampo: string = '';
                            strOrdTipo : string = '';
                            blnEnvioAutmaticoEmail: Boolean = False;
                            blnImpManual: Boolean = False;
                            blnProrrogado: Boolean = False;
                            blnEmissaoAutomatica: Boolean = False;
                            blnPreview: Boolean = False;
                            blnUsarLayoutEmaSai: Boolean = False;
                            blnExpediMult : Boolean = False;
                            blnFaturadorAutomatico : Boolean = False;
                            blnAbortarEnvioEmaSmsWpp: Boolean = False);

    procedure AcrescentaNossoNumeroCadBco(var ADatasetCadBco: TUniQuery;
                                          ANossoNumeroDuplicado,
                                          ACodigoBanco: String);

    class function fGetProvedorEnvioEmailAutomatico(objDuplicata: TDuplicataCtr): String;

    class function fImprimirBoletos(objArrDupCtr: TArrDupCtr; blnFaturamento: Boolean = False;
      blnPergunta: Boolean = False; strTextoPergunta: String = ''; strNomeForm: String = '';
      strNomImpBol: String = ''; strWhereBol: String = ''; blnTelaDeCadastro: Boolean = False; blnPerguntaDefSim: Boolean = True): Boolean;

    class function fGetSQLBoletos(blnReimpressaoBoleto: Boolean = False): String;

    class function fEnviarEmailBoletoAutomatico(objArrDupCtr: TArrDupCtr;
                                                objStatusBoleto: TStatusDisparaEmail;
                                                out AEnviouEmail: Boolean;
                                                out AEnviouSMS: Boolean;
                                                out AEnviouWPP: Boolean): Boolean;

    class procedure pAtualizaBoleto(objArrDupCtr: TArrDupCtr; blnReimpressao, blnProrrogado, blnPreview: Boolean; blnApenasGerarPDF : Boolean = False);

    class function fChaveLockImpressaoBoletos(): String;
    class function fReimpressaoPDFBoleto(objDuplic: TArrDupCtr): Boolean;

    function fEnviaSmsOuWhatsApp(const blnEnvMaiV, blnEmaAut, blnEnviarSMSBoleto, blnEnviarWPPBoleto: Boolean): Boolean;

  published
    property strCodBco  : String  read FCodBco  write FCodBco;
    property fltValMor  : Double  read FValMor  write FValMor;
    property fltValDes  : Double  read FValDes  write FValDes;
    property strCodPor  : String  read FCodPor  write FCodPor;
    property strNosNum  : String  read FNosNum  write FNosNum;
    property strNumDig  : String  read FNumDig  write FNumDig;
    property strValExt  : String  read FValExt  write FValExt;
    property strValExt2 : String  read FValExt2 write FValExt2;
    property intCodCar  : Integer read FCodCar  write FCodCar;
    property strBcoIni  : String  read FBcoIni  write FBcoIni;
    property strMens01  : String  read FMens01  write FMens01;
    property strMens02  : String  read FMens02  write FMens02;
    property strCliCgc  : String  read FCgcCli  write FCgcCli;
    property strCliCep  : String  read FCepCli  write FCepCli;
    property strDtaAtu  : String  read FDtaAtu  write FDtaAtu;
    property fltDesCtr  : Double  read FDesCtr  write FDesCtr;
    property fltMulta_  : Double  read FMulta_  write FMulta_;
    property strPerMul  : String  read FPerMul  write FPerMul;
    property strBraCrr  : String  read FBraCrr  write FBraCrr;
    property strCodCli  : String  read FCodCli  write FCodCli;
    property strNomCli  : String  read FNomCli  write FNomCli;
    property strCidCli  : String  read FCidCli  write FCidCli;
    property strEstCli  : String  read FEstCli  write FEstCli;
    property strEndCli  : String  read FEndCli  write FEndCli;
    property strInsEst  : String  read FInsEst  write FInsEst;
    property strUltPar  : String  read FUltPar  write FUltPar;
    property strBB_Crr  : String  read FBB_Crr  write FBB_Crr;
    property strConCrr  : String  read FConCrr  write FConCrr;
    property blnAltImp  : Boolean read FAltImp  write FAltImp;
    property blnImprim  : Boolean read FBlnImp  write FBlnImp;

    property objStatusEmailAutomatico: TStatusDisparaEmail read FobjStatusEmailAutomatico write FobjStatusEmailAutomatico;
  Private
    function RetornaLinkPixCitelValido(const ADuplicata: TDataSet): String;
  End;


Const
   BANCO_BOLETO: String = '_001_041_104_237_341_356_399_748_756_33B_021'+
                          '_389_085_090_003_422_070_004_099_089_992_993'+
                          '_994_995_996_997_998_136_707_246_077_988_987'+
                          '_637_033B_033B240p_084_983_990_970_981_906_033API_978_964_';
implementation

uses SysUtils, Forms, StrUtils, untDigBoleto, untCfgRel, untCadRec,
  untFuncoes, untValorPorExtenso, untFuncMacro, untImpNotaPromissoria,
  untTEnvioEmail, untFuncAutban, untDigObsBoleto,
  untAtualizaOcorrenciasCRM, untTypesCRM, untTBancoInter,
  untGravandoObs, untSubjectClass, untSubjectIntf, System.Diagnostics,
  untTEnviaEmailCancelamentoBoleto,untDocumento,untIDocumento;

{ TBoleto }

function TBoleto.CarteiraValidaParaImpressaoDeBoleto(ACodBco,ACodIde: String): Boolean;

begin
  Result := True;

  If Not MatchStr(ACodBco, ['033']) Then
    Exit;

  If Pos(ACodIde, BANCO_BOLETO) = 0 Then
    Result:= False;
end;

constructor TBoleto.Create(Owner: TComponent; strNomeTabela: String; blnFaturamento: Boolean; blnExpedicao: Boolean=False);
begin
  inherited Create(Owner);
  Self.strNomeTabela  := strNomeTabela;
  Self.blnFaturamento := blnFaturamento;
  Self.blnExpedicao   := blnExpedicao;

  qryConCli := fCriaQuery(Self);
  qryConRec := fCriaQuery(Self);
  qryConTot := fCriaQuery(Self);
  qryCfgRel := fCriaQuery(Self);

  pInicializaCamposUso;

  FBoletoCarneBuilder := TBoletoCarneBuilder.Create;
  FBoleto1ViaBuilder  := TBoleto1Via_ComprovanteBuilder.Create;

  FImprimiuSemPerguntar := False;
end;

destructor TBoleto.Destroy;
begin
  pFinalizaCamposUso;
  FreeAndNil(FBoletoCarneBuilder);
  FreeAndNil(FBoleto1ViaBuilder);
  If Assigned(FMultiplosBancos) Then
    FreeAndNil(FMultiplosBancos);
  inherited;
end;

function TBoleto.EnviarWhatsappBoletos(ADuplicatas: TArrDupCtr; ACorpoMensagemEMASAI, strArqBoletos: String; AEnviarModal: Boolean = False; ABoletoCarne: Boolean = False): Boolean;
var
  DestinatarioWhatsapp: TDestinatarioWhatsapp;
begin
  DestinatarioWhatsapp := TDestinatarioWhatsapp.Create;
  try
    Result := EnviarSMSBoletos(ADuplicatas, ACorpoMensagemEMASAI, True, strArqBoletos, True, ABoletoCarne, DestinatarioWhatsapp);
  finally
    FreeAndNil(DestinatarioWhatsapp);
  end;
end;

procedure TBoleto.AcrescentaNossoNumeroCadBco(var ADatasetCadBco: TUniQuery;
  ANossoNumeroDuplicado, ACodigoBanco: String);
  Var
    LProximoNossoNumero: Int64;
begin
  //utilizar isso apenas para nosso numero duplicado em API. Deve implementar com cuidado
  //cada banco tem suas particularidades (observar untCadRec.fGravaNumBco)

  If ANossoNumeroDuplicado.IsEmpty Then
    Exit;

  //Implementar por banco
  If Not MatchStr(ACodigoBanco, ['341']) Then
    Exit;

  LProximoNossoNumero := StrToInt64Def(ANossoNumeroDuplicado, 1);
  Inc(LProximoNossoNumero, 2);

  fStartTransaction;
  ADatasetCadBco.Edit;
  ADatasetCadBco.FieldByName('BCO_PRONUM').AsString := LProximoNossoNumero.ToString;
  ADatasetCadBco.Post;
  fCommit;
end;

function TBoleto.BoletoJaImpresso(AAutoincrem : String): Boolean;
  Var
    LCadRec : TUniQuery;
    LDuplicata: String;
    LDocumento: IDocumento;
begin
  Result := False;

  If FImprimiuSemPerguntar Then
    Exit;

  If FAltImp Then
    Exit;

  If FReimpressao Then
    Exit;


  Try

    Try
      LCadRec := fCriaQuery(Nil);
      LCadRec.Close;
      LCadRec.SQL.Clear;
      LCadRec.SQL.Text := 'SELECT                              '+
                          '  *                                 '+
                          'FROM                                '+
                          '  CADREC                            '+
                          'WHERE AUTOINCREM = :AUTOINC         '+
                          '  AND IFNULL(CTR_NOSNUM,"") <> ""   '+
                          '  AND IFNULL(CTR_BCOBOL,"") <> ""   ';

      LCadRec.ParamByName('AUTOINC').AsString := AAutoincrem;
      LCadRec.Open;

      If Not LCadRec.IsEmpty Then
      Begin
        Result := True;

        If fInTransaction Then
          Exit;

        LDocumento := TDocumento.Create;
        LDuplicata := Concat(LCadRec.FieldByName('CTR_NUMDUP').AsString,
                             LCadRec.FieldByName('CTR_PARCEL').AsString);

        If fMensagem('Atenção', 'A duplicata '+LDuplicata+ ' já teve seu boleto processado! ' + #10#13 +
                                'Deseja realizar a reimpressão?', ['&Sim', '&Não']) = 1 Then
        Begin
          LDocumento.fImprimeBoleto(LCadRec.FieldByName('AUTOINCREM').AsString);
        End;
      End;

    Except
      On E:Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(LCadRec);
  End;
end;

function TBoleto.EnviarSMSBoletos(ADuplicatas: TArrDupCtr; ACorpoMensagemEMASAI: String; blnEnviaWhatsapp: Boolean = False; strArqBoletos: String = '';
  AEnviarModal: Boolean = False; ABoletoCarne: Boolean = False; DestinatarioWhatsapp: TDestinatarioWhatsapp = nil): Boolean;
  Var
    LDadosSMS: TDadosDisparaSMS;

    LNumeroPedido,
    LEmpresaPedido,
    LNumeroDuplicata: String;

    LContadorDuplicatas,
    LInicioContador: Integer;

    LAneBol: Boolean;

    strBoleto: String;
    arrBoletos: TArray<String>;
    recArquivos: TArray<TRecArquivosGatilhos>;
begin
  Result := True;

  LAneBol := fCfgSis('ANEBOL', VarBoolean);

  LInicioContador := 0;
  If ADuplicatas[0].LinkDoBoleto.IsEmpty Then
  Begin
    If ABoletoCarne Then
      LInicioContador := Length(ADuplicatas) - 1;
  End;

  LNumeroDuplicata := '';
  For LContadorDuplicatas := LInicioContador To Length(ADuplicatas) - 1 Do
  Begin
    pAtualizaCamposUso(ADuplicatas[LContadorDuplicatas]);

    If LNumeroDuplicata <> qryConRec.FieldByName('CTR_NUMDUP').AsString Then
      pRetNumeroPedidoVenda(qryConRec.FieldByName('CTR_NUMDUP').AsString,
                            qryConRec.FieldByName('CTR_ESPDOC').AsString,
                            qryConRec.FieldByName('CTR_CODEMP').AsString,
                            qryConRec.FieldByName('CTR_CODCLI').AsString,
                            LNumeroPedido,
                            LEmpresaPedido);

    LNumeroDuplicata := qryConRec.FieldByName('CTR_NUMDUP').AsString;

    LDadosSMS.strNumDoc         := qryConRec.FieldByName('CTR_NUMDUP').AsString;
    LDadosSMS.strCodCli         := qryConRec.FieldByName('CTR_CODCLI').AsString;
    LDadosSMS.strEspDoc         := qryConRec.FieldByName('CTR_ESPDOC').AsString;
    LDadosSMS.strCodEmp         := qryConRec.FieldByName('CTR_CODEMP').AsString;
    LDadosSMS.strNumOrc         := LNumeroPedido;
    LDadosSMS.strEspOrc         := IfThen(fEmptyStr(LNumeroPedido), '', 'PD');
    LDadosSMS.strEmpOri         := LEmpresaPedido;
    LDadosSMS.strCelula         := qryConCli.FieldByName('CLI_CELULA').AsString;
    LDadosSMS.strLinhaDigitavel := IIF(LAneBol, qryConRec.FieldByName('CTR_LINDIG').AsString, ACorpoMensagemEMASAI);
    LDadosSMS.strDtaEmi         := FormatDateTime('dd/mm/yy', qryConRec.FieldByName('CTR_DTACAD').AsDateTime);
    LDadosSMS.strValDup         := FormatFloat( '#,##0.00', qryConRec.FieldByName('CTR_VALDUP').AsFloat);
    LDadosSMS.strParcel         := qryConRec.FieldByName('CTR_PARCEL').AsString;
    LDadosSMS.strDtaVen         := FormatDateTime('dd/mm/yy', qryConRec.FieldByName('CTR_DTAVEN').AsDateTime);
    LDadosSMS.strLinkDoBoleto   := ADuplicatas[LContadorDuplicatas].LinkDoBoleto;

    LDadosSMS.QrCodePix := '';
    If Not ADuplicatas[LContadorDuplicatas].QRCodePix.IsEmpty Then
    Begin
      LDadosSMS.QrCodePix := ADuplicatas[LContadorDuplicatas].LinkPixCitel;
      If ADuplicatas[LContadorDuplicatas].LinkPixCitel.IsEmpty Then
        LDadosSMS.QrCodePix := ADuplicatas[LContadorDuplicatas].QRCodePix;
    End;

    If AEnviarModal Then
      LDadosSms.EnviarModal := 'S';

    if not blnEnviaWhatsapp then
      Result := fDisparaSMSBoletoAutomatico(LDadosSMS,
                                            'BO',
                                            objStatusEmailAutomatico);

    Application.ProcessMessages;
  End;

  if blnEnviaWhatsapp then
  begin
    SetLength(recArquivos, 0);

    arrBoletos := strArqBoletos.Split([',']);
    for strBoleto in arrBoletos do
    begin
      SetLength(recArquivos, Length(recArquivos)+1);
      recArquivos[High(recArquivos)] := TRecArquivosGatilhos.Create('BOLETO_'+ExtractFileName(strBoleto).Replace(ExtractFileExt(ExtractFileName(strBoleto)), EmptyStr)+'-'+LDadosSMS.strEspDoc,
                                                                    strBoleto,
                                                                    EmptyStr);
    end;

    LDadosSms.RecArquivos := recArquivos;

    Result := fDisparaWhatsappBoletoAutomatico(LDadosSMS,
                                               'BO',
                                               objStatusEmailAutomatico,
                                               DestinatarioWhatsapp);
  end;
end;

procedure TBoleto.pImprimir(cdsBoletos: TUniClientDataSet;
                            arrCtrDup: TArrDupCtr;
                            strBancoAnterior: String;
                            blnBolPdf,
                            blnEnvEml,
                            blnEmaAut: Boolean;
                            blnReimp: Boolean = False;
                            blnReimpParcial: Boolean = False;
                            strCartei: String = '';
                            strPerMor: String = '';
                            strPerMul: String = '';
                            strNomImpBol: String = '';
                            strOrdCampo: string = '';
                            strOrdTipo : string = '';
                            blnEnvioAutmaticoEmail: Boolean = False;
                            blnImpManual: Boolean = False;
                            blnProrrogado: Boolean = False;
                            blnEmissaoAutomatica: Boolean = False;
                            blnPreview: Boolean = False;
                            blnUsarLayoutEmaSai: Boolean = False;
                            blnExpediMult : Boolean = False;
                            blnFaturadorAutomatico : Boolean = False;
                            blnAbortarEnvioEmaSmsWpp: Boolean = False);
  Var
    blnConfirma    : Boolean;
    blnBolPdfV : Boolean;
    blnEnvMaiV : Boolean;
    blnDupMercantil: Boolean;
    strTipBol      : String;
    strReimpr      : String;
    strPathBol     : String;
    strNosNumNovo  : String;
    strNosNumReimpr: String;
    strPortadorAnt : String;
    strEmailCli    : String;
    strNum_PD      : String;
    strEmp_PD      : String;
    strSelObs      : String;
    qryGen         : TUniQuery;
    intCont        : Integer;
    intContCli     : Integer;
    stlClientes    : TStringList;
    arrArquivos, arrDestinatarios: TStringArray;
    strTpIden   : String;
    blnEmailEnviado,
    blnForcarImp   : Boolean;
    thrSincEmail   : TThreadSincronizaEmails;
    objDadosEmail  : TDadosDisparaEmail;
    objDadosSMS    : TDadosDisparaSMS;
    strArqBoletos  : String;
    strMSBOEM : String;
    ACorpoMensagem : TStringArray;
    ACorpoMensagemEMASAI: String;
    FAssunto : String;

    strEmpresaImpressao: String;
    recDadosDigBoleto: TDadosTelaDigBoleto;

    ABoletoCarne: Boolean;
    ABoleto1Via: Boolean;

    stlBoletosRealocados : TStringList;

    LErroAPI,
    LGerouBancoInter: Boolean;

    LBancoInter: TBancoInter;

    LRetornoAPI: TRetornoBoletoBancoInter;

    {API COBRANÇA BANCO DO BRASIL REQ: 191511 MT}
    LBancoDoBrasilApi: TBancoDoBrasilAPI;
    LBancoItauApi: TBancoItauAPI;
    LGerouBoletoApi: Boolean;
    LNomBcoApi: String;

    {API COBRANÇA BANCO CREDISIS REQ: 275584 TA}
    LBancoCredisisAPI: TBancoCredisisAPI;
    LGerouBancoCredisisApi: Boolean;

    {API COBRANÇA BANCO SICREDI REQ: 287741 TA}
    LBancoSicrediAPI: TBancoSicrediAPI;
    LGerouBancoSicrediApi: Boolean;

    LBancoSicoobApi: TBancoSicoobAPI;

    LBancoBradescoApi: TBancoBradescoAPI;

    LBancoSantanderApi: TBancoSantanderAPI;

    {API COBRANÇA BANCO SAFRA REQ: 354392 TA}
    LBancoSafraAPI: TBancoSafraAPI;
    LGerouBancoSafraApi: Boolean;
    LLinhaDigitavel,
    LCodigoDeBarras,
    LDocumentosRestantes,
    LAutoIncremInter: String;

    LContadorTentativas,
    LContadorRestantes: Integer;

    LDadosLoginEmail: TDadosLoginEmail;

    cdsPortAutEmail,
    cdsPortAutSms : TUniClientDataSet;

    blnEnviaEmailPortAut : Boolean;
    blnEnviaSmsPortAut   : Boolean;
    blnEnviaWppPortAut   : Boolean;

    blnJaGerouNP : Boolean;
    LCarteiraBanco : String;
    LDuplicataBoleto: TDuplicataCtr;

    blnEnvSMS,
    blnEnvWPP: Boolean;

    strArqBoletosWppEma: String;
    strCorpo : String;
    LReimprimirBoletoOriginal : Boolean;

    iArr : Integer;

    blnMsg : Boolean;
    LEnviaEmailCancelamentoBoleto: TEnviaEmailCancelamentoBoleto;

    LDuplicatasSMSWppArray: TarrDupCtr;
    LImprimiuBoleto:Boolean;

     LCodigoGrupoModelo,
     LCodigoModelo: String;

     blnMsgBolSen : Boolean;
     AMensagemBolSen : TStringArray;

     LNossoNumeroDisponivel: String;

     strBoleto: String;
     arrBoletos: TArray<String>;
     recArquivos: TArray<TRecArquivosGatilhos>;

  procedure pProcessarClientesCtrDup;
    Var i: Integer;
  begin
    If (Length(arrCtrDup) = 0) Then
      Exit;

    stlClientes.Clear();
    stlClientes.Add(arrCtrDup[0].strCodCli);

    For i := 1 To Length(arrCtrDup) - 1 Do
      If (stlClientes.IndexOf(arrCtrDup[i].strCodCli) = -1) Then
        stlClientes.Add(arrCtrDup[i].strCodCli);
  end;

  function fInformaObsBoleto(strChave: String): Boolean;
    Var frmDigObsBoleto: TfrmDigObsBoleto;
  Begin
    pCriarFormularios(TfrmDigObsBoleto, frmDigObsBoleto);
    frmDigObsBoleto.edtObservacao1.Text := fGetBancoConfig(0, strChave, 'OBSERV1', '');
    frmDigObsBoleto.edtObservacao2.Text := fGetBancoConfig(0, strChave, 'OBSERV2', '');
    frmDigObsBoleto.edtObservacao3.Text := fGetBancoConfig(0, strChave, 'OBSERV3', '');
    frmDigObsBoleto.edtObservacao4.Text := fGetBancoConfig(0, strChave, 'OBSERV4', '');
    frmDigObsBoleto.edtObservacao5.Text := fGetBancoConfig(0, strChave, 'OBSERV5', '');
    frmDigObsBoleto.ShowModal;

    strSelObs := frmDigObsBoleto.strSelObs;
    Result := frmDigObsBoleto.blnConfirma;

    FreeAndNil(frmDigObsBoleto);
  End;

  Function fCarteiraPossuiObservacoes(strChave: String): Boolean;
  Begin
    Result := False;
    If Not fEmptyStr(fGetBancoConfig(0, strChave, 'OBSERV1', '')) Then
      Result := True
    Else If Not fEmptyStr(fGetBancoConfig(0, strChave, 'OBSERV2', '')) Then
      Result := True
    Else If Not fEmptyStr(fGetBancoConfig(0, strChave, 'OBSERV3', '')) Then
      Result := True
    Else If Not fEmptyStr(fGetBancoConfig(0, strChave, 'OBSERV4', '')) Then
      Result := True
    Else If Not fEmptyStr(fGetBancoConfig(0, strChave, 'OBSERV5', '')) Then
      Result := True;
  End;

  function fRetornaAutoIncremDups() : String;
  Var Str : String;
      intContador : Integer;
  Begin

    Str := '';
    For intContador := 0 To Length(arrCtrDup) -1 Do
      Str := Str + '"' + arrCtrDup[intContador].strAutoIn + '"' +
                         IIF(intContador < Length(arrCtrDup) - 1, ',', ' ');

    Result := Str;

  End;


  function pCarregaTabelaDupEmail( strCodCli : string) : TArrDupTabelaEmail;
   Var qryDadosDups : TUniQuery;
       StrSQL : String;
       arrDupT: TArrDupTabelaEmail;
  Begin

      qryDadosDups := fCriaQuery(Self);

      strSQL := '';
      strSQL := strSQL + 'SELECT                                              ';
      strSQL := strSQL + '  R.*                                               ';
      strSQL := strSQL + 'FROM                                                ';
      strSQL := strSQL + '  CADREC R                                          ';
      strSQL := strSQL + 'WHERE R.CTR_CODCLI = :CODCLI                        ';
      strSQL := strSQL + '  AND                                               ';
      strSQL := strSQL + '     R.AUTOINCREM IN (' + fRetornaAutoIncremDups +  ') ';

      qryDadosDups.SQL.Clear;
      qryDadosDups.SQL.Add(strSQL);
      qryDadosDups.ParamByName('CODCLI').AsString := strCodCli;
      qryDadosDups.Open;

      SetLength(arrDupT,0);

      qryDadosDups.First;
      While Not qryDadosDups.Eof Do
      Begin
          SetLength(arrDupT,Length(arrDupT)+1);
          arrDupT[Length(arrDupT)-1].strNumDoc := qryDadosDups.FieldByName('CTR_NUMDUP').AsString;//NRODUP
          arrDupT[Length(arrDupT)-1].strParcel := qryDadosDups.FieldByName('CTR_PARCEL').AsString;//PARDUP
          arrDupT[Length(arrDupT)-1].strEspDoc := qryDadosDups.FieldByName('CTR_ESPDOC').AsString;
          arrDupT[Length(arrDupT)-1].strCodEmp := qryDadosDups.FieldByName('CTR_CODEMP').AsString;
          arrDupT[Length(arrDupT)-1].strCodCli := qryDadosDups.FieldByName('CTR_CODCLI').AsString;
          arrDupT[Length(arrDupT)-1].dtaDtaCad := qryDadosDups.FieldByName('CTR_DTACAD').AsDatetime;
          arrDupT[Length(arrDupT)-1].dtaDtaVen := qryDadosDups.FieldByName('CTR_DTAVEN').AsDatetime;
          arrDupT[Length(arrDupT)-1].fltVlrDup := qryDadosDups.FieldByName('CTR_VALDUP').AsFloat;
          arrDupT[Length(arrDupT)-1].strAutoIn := qryDadosDups.FieldByName('AUTOINCREM').AsString;
          arrDupT[Length(arrDupT)-1].intSeqBai := qryDadosDups.FieldByName('CTR_SEQBAI').AsInteger;
          arrDupT[Length(arrDupT)-1].strLinDig := qryDadosDups.FieldByName('CTR_LINDIG').AsString;

        Application.ProcessMessages;

        qryDadosDups.Next;
      End;

      Result := arrDupT;

      FreeAndNil(qryDadosDups);

  End;

  procedure pCarregaDadosEmail;
  var
    strArquivos: String;
    strBoleto: String;
    arrBoletos: TArray<String>;
    recArquivos: TArray<TRecArquivosGatilhos>;
  Begin
    pRetNumeroPedidoVenda(qryConRec.FieldByName('CTR_NUMDUP').AsString,
                          qryConRec.FieldByName('CTR_ESPDOC').AsString,
                          qryConRec.FieldByName('CTR_CODEMP').AsString,
                          qryConRec.FieldByName('CTR_CODCLI').AsString,
                          strNum_PD,
                          strEmp_PD);

    objDadosEmail.strNumDoc         := qryConRec.FieldByName('CTR_NUMDUP').AsString;
    objDadosEmail.strCodCli         := qryConRec.FieldByName('CTR_CODCLI').AsString;
    objDadosEmail.strEspDoc         := qryConRec.FieldByName('CTR_ESPDOC').AsString;
    objDadosEmail.strCodEmp         := qryConRec.FieldByName('CTR_CODEMP').AsString;
    objDadosEmail.strNumOrc         := strNum_PD;
    objDadosEmail.strEspOrc         := IfThen(fEmptyStr(strNum_PD), '', 'PD');
    objDadosEmail.strEmpOri         := strEmp_PD;

    IF (Not fUtilizaBoletoCarne) And (Not fUtilizaBoleto1Via) then
      strArquivos := IfThen(blnEnvioAutmaticoEmail,
                            RetornaPastaBoletos(qryConRec.FieldByName('CTR_CODEMP').AsString,
                                                ABoletoCarne,ABoleto1Via) + qryConRec.FieldByName('CTR_NUMDUP').AsString +
                                                                qryConRec.FieldByName('CTR_PARCEL').AsString + '.pdf',
                            strArqBoletos)
    else
      strArquivos := strArqBoletos;

    arrBoletos := strArquivos.Split([',']);
    for strBoleto in arrBoletos do
    begin
      SetLength(recArquivos, Length(recArquivos)+1);
      recArquivos[High(recArquivos)] := TRecArquivosGatilhos.Create('BOLETO_'+ExtractFileName(strBoleto).Replace(ExtractFileExt(ExtractFileName(strBoleto)), EmptyStr)+'-'+objDadosEmail.strEspDoc,
                                                                    strBoleto,
                                                                    EmptyStr);
    end;

    objDadosEmail.RecArquivos       := recArquivos;
    objDadosEmail.strEmailCli       := strEmailCli;
    objDadosEmail.strLinhaDigitavel := IIF(fCfgSis('ANEBOL', VarBoolean), strLinDig, ACorpoMensagemEMASAI);
    objDadosEmail.strDtaEmi         := DateToStr(qryConRec.FieldByName('CTR_DTACAD').AsDateTime);
    objDadosEmail.strValDup         := FormatFloat( 'R$ #,##0.00', qryConRec.FieldByName('CTR_VALDUP').AsFloat);
    objDadosEmail.strParcel         := qryConRec.FieldByName('CTR_PARCEL').AsString;
    objDadosEmail.strDtaVen         := DateToStr(qryConRec.FieldByName('CTR_DTAVEN').AsDateTime);
    objDadosEmail.arrDupTabela      := pCarregaTabelaDupEmail( qryConRec.FieldByName('CTR_CODCLI').AsString );

    If Length(LDuplicatasSMSWppArray) = 1 Then
    Begin
      objDadosEmail.QRCodePix         := LDuplicatasSMSWppArray[0].QrCodePix;
      If Not LDuplicatasSMSWppArray[0].LinkPixCitel.IsEmpty Then
        objDadosEmail.LinkCitelPix    := LDuplicatasSMSWppArray[0].LinkPixCitel;
    End;
  End;

  function fChamaSelecaoFilaImpressao: Boolean;
  begin
    Result := True;

    If blnFaturamento Then
    Begin
      Result := ((not blnBolPdfV) Or blnForcarImp) And (not blnEnvMaiV) And (Not blnFaturadorAutomatico);
    End;
  end;

begin
  blnEnvMaiV := False;
  blnBolPdfV := False;
  blnPortadorAlterado := False;
  blnDupMercantil     := False;
  blnEditaEmail       := False;
  LReimprimirBoletoOriginal := False;
  LImprimiuBoleto     := False;
  strSelObs           := '';
  ACorpoMensagemEMASAI := '';
  FAssunto :=  'Boleto(s)';
  FBlnImp := False;
  blnJaGerouNP := false;

  LBancoInter        := Nil;
  LBancoDoBrasilApi  := Nil;
  LBancoCredisisAPI  := Nil;
  LBancoSicrediAPI   := Nil;
  LBancoItauApi      := Nil;
  LBancoSicoobApi    := Nil;
  LBancoSantanderApi := Nil;
  LBancoSafraAPI     := Nil;
  LBancoBradescoApi  := Nil;

  If OperadorCitelLogado Then
    Exit;

  blnMsg := False;

  blnMsgBolSen := False;

  if (Not blnFaturamento) And (Not blnEnvioAutmaticoEmail) And Not (fCfgSis('GRVBOL') = '2') then
    thrSincEmail    := TThreadSincronizaEmails.Create
  Else
    thrSincEmail    := nil;

  stlClientes := TStringList.Create();

  stlBoletosRealocados := TStringList.Create();

  {* Imprimir e enviar e-mail *}
  blnForcarImp    := False;
  blnEmailEnviado := False;

  LGerouBancoInter := False;
  LGerouBoletoApi := False;
  LGerouBancoCredisisApi := False;

  strEmpresaImpressao := VS_strCodEmp;
  recDadosDigBoleto.strEmpresaImpressao := strEmpresaImpressao;

  ABoletoCarne := fUtilizaBoletoCarne;
  ABOleto1Via  := fUtilizaBoleto1via;

  VS_ErroGeraBoletoLaser := EmptyStr;

  Try
    recDadosDigBoleto.blnPortadorAlterado := blnPortadorAlterado;
    recDadosDigBoleto.cdsBoletos          := cdsBoletos;
    recDadosDigBoleto.strBancoAnterior    := strBancoAnterior;
    recDadosDigBoleto.strCodBco           := cdsBoletos.FieldByName('CTR_BCOBOL').AsString;
    recDadosDigBoleto.strOrdCampo         := strOrdCampo;
    recDadosDigBoleto.strOrdTipo          := strOrdTipo;

    recDadosDigBoleto.blnReimp        := blnReimp;
    FReimpressao                      := blnReimp;
    recDadosDigBoleto.blnReimpParcial := blnReimpParcial;
    recDadosDigBoleto.blnFaturamento  := blnFaturamento;
    recDadosDigBoleto.blnFaturadorAutomatico := blnFaturadorAutomatico;

    If (cdsBoletos.FindField('CTR_CARTEI') <> Nil) Then
    Begin
      If blnReimp Then
      begin
        recDadosDigBoleto.intRetCar    := fRetNumCartReimpressao(cdsBoletos.FieldByName('CTR_CARTEI').AsString);
        recDadosDigBoleto.intRetCarAnt := fRetNumCartReimpressao(cdsBoletos.FieldByName('CTR_CARTEI').AsString);
        recDadosDigBoleto.strRetBco    := Copy(cdsBoletos.FieldByName('CTR_CARTEI').AsString, 7, Length(cdsBoletos.FieldByName('CTR_CARTEI').AsString));
        recDadosDigBoleto.strRetBco    := Copy(recDadosDigBoleto.strRetBco, 1, Pos('-', recDadosDigBoleto.strRetBco)-1);
        recDadosDigBoleto.strChave     := cdsBoletos.FieldByName('CTR_CARTEI').AsString;
      end;
    End;

    {*****************************************************************}
    {* TRATAMENTOS DIFERENTES PARA BOLETOS IMPRESSOS E NÃO IMPRESSOS *}
    {*REQ-25848-22/01/2015*****************************************JU*}
    If blnReimp Then
    Begin
      recDadosDigBoleto.strMorDia            := IfThen(fEmptyStr(strPerMor), FloatToStrF(fCfgSis('TAXDIA', varDouble),ffFixed,12,fCfgSis('CSDMOR', VarInteger)), strPerMor);
      recDadosDigBoleto.strCartei            := strCartei;
      recDadosDigBoleto.strCodPor            := cdsBoletos.FieldByName('CTR_CODPOR').AsString;
      If ((recDadosDigBoleto.strCodBco ='637') And (Pos('CONFIG637_444p', strCartei) > 0)) Then
         recDadosDigBoleto.strNosNum            := fPadL(Copy(cdsBoletos.FieldByName('CTR_NOSNUM').AsString, 1, Length(cdsBoletos.FieldByName('CTR_NOSNUM').AsString) - 1), 12, '0')
      Else
         recDadosDigBoleto.strNosNum            := IIF(Pos('CONFIG001D7', strCartei) = 0, fPadL(Copy(cdsBoletos.FieldByName('CTR_NOSNUM').AsString, 1, Length(cdsBoletos.FieldByName('CTR_NOSNUM').AsString) - 1), 11, '0'), fPADL(cdsBoletos.FieldByName('CTR_NOSNUM').AsString, 11, '0'));
      recDadosDigBoleto.strPerMul            := IfThen(fEmptyStr(strPerMul), '0,00', strPerMul);

      If (Not cdsBoletos.FieldByName('CTR_CARTEI').AsString.IsEmpty) Then
        recDadosDigBoleto.strEmpresaImpressao := RightStr(cdsBoletos.FieldByName('CTR_CARTEI').AsString, 3);

      recDadosDigBoleto.strMens01 := cdsBoletos.FieldByName('CTR_OBSV01').AsString;
      recDadosDigBoleto.strMens02 := cdsBoletos.FieldByName('CTR_OBSV02').AsString;
    End;

    If blnEhBoletoMeiaNota Then
    Begin
      recDadosDigBoleto.strCodPor := cdsBoletos.FieldByName('CTR_CODPOR').AsString;
      blnEmaAut := blnUsarLayoutEmaSai;
    End;

    If blnFaturamento Then
    Begin

      If ((fCfgSis('EMPFAT', VarBoolean)) Or (fCfgSis('EMPFVN', VarBoolean))) Then
      Begin
        strEmpresaImpressao := cdsBoletos.FieldByName('CTR_CODEMP').AsString;

        recDadosDigBoleto.strMorDia := FloatToStrF(fCfgSis('TAXDIA', varDouble, strEmpresaImpressao),ffFixed,12,2);

        If fCfgSis('BANBOL', varString, strEmpresaImpressao) <> '' Then
          recDadosDigBoleto.strCodBco := fCfgSis('BANBOL', varString, strEmpresaImpressao);
      End;

      If fPermiteCarregarPortadorDoDocumento(strEmpresaImpressao) Then
        recDadosDigBoleto.strCodPor := strCodPor;

      recDadosDigBoleto.strEspDoc := arrCtrDup[0].strEspDoc;
      recDadosDigBoleto.strCodCli := arrCtrDup[0].strCodCli;
      If (arrCtrDup[0].strEspDoc = 'FF') Then
        recDadosDigBoleto.strCodBco     := '778';

      recDadosDigBoleto.strEmpresaImpressao := strEmpresaImpressao;

      recDadosDigBoleto.blnFaturamento := blnFaturamento;

      recDadosDigBoleto.blnEnvEml := blnEnvEml;
      recDadosDigBoleto.blnBolPdf := blnBolPdf;
    End;

    recDadosDigBoleto.blnEnvioAutmaticoEmail := blnEnvioAutmaticoEmail;
    recDadosDigBoleto.blnEmissaoAutomatica   := blnEmissaoAutomatica;
    recDadosDigBoleto.blnPreview             := blnPreview;
    recDadosDigBoleto.blnEmaAut              := blnEmaAut;
    recDadosDigBoleto.blnExpediMult          := blnExpediMult;

    recDadosDigBoleto.blnEnviarWPPBoleto := True;
    recDadosDigBoleto.blnEnviarSMSBoleto := True;

    If blnFaturamento Then
      recDadosDigBoleto := fDigBoletoFaturamento(recDadosDigBoleto,cdsBoletos)
    Else
      recDadosDigBoleto := fDigBoletoFinanceiro(recDadosDigBoleto, arrCtrDup);

    If (blnReimp) And (Not recDadosDigBoleto.blnAltImp) And
       (Not cdsBoletos.FieldByName('CTR_CARTEI').AsString.IsEmpty) Then
      strEmpresaImpressao := RightStr(cdsBoletos.FieldByName('CTR_CARTEI').AsString, 3);

    blnConfirma         := recDadosDigBoleto.blnConfirma;
    blnBolPdfV          := (recDadosDigBoleto.blnBolPdf Or blnEmaAut);
    blnEnvMaiV          := recDadosDigBoleto.blnEnvMai;
    blnEtiCob           := recDadosDigBoleto.blnEtiCob;
    strTipBol           := recDadosDigBoleto.strTipBol;
    blnDupMercantil     := recDadosDigBoleto.blnDupMercantil;
    blnEditaEmail       := recDadosDigBoleto.blnEditaEmail;
    LReimprimirBoletoOriginal := recDadosDigBoleto.blnBoletoOriginal;
    blnPortadorAlterado := recDadosDigBoleto.blnPortadorAlterado;

    blnForcarImp := (Not blnFaturadorAutomatico) And
                    (Not blnEnvioAutmaticoEmail) And
                    ((recDadosDigBoleto.blnDeveImprimir) Or
                     ((fCfgSis('TIPEXP') = '5') And (Self.blnFaturamento And Self.blnExpedicao)));

    FCodBco := recDadosDigBoleto.strCodBco;
    FCodPor := recDadosDigBoleto.strCodPor;
    FValMor := recDadosDigBoleto.fltValMor;
    FNosNum := recDadosDigBoleto.strNosNum;
    FMens01 := recDadosDigBoleto.strMens01;
    FMens02 := recDadosDigBoleto.strMens02;
    FBcoIni := recDadosDigBoleto.strRetBco;
    FCodCar := recDadosDigBoleto.intRetCar;
    FDtaAtu := FormatDateTime('DD/MM/YYYY', VS_Date);
    If (blnReimp) And (strCodBco = '033')  And (FBcoIni <> '033B240p')  And (FBcoIni <> '033API') Then // REIMPRESSÃO BANCO SANTANDER - 033
        FBcoIni := '033B';

    if strCodBco = '041' then
    begin
      if ((fGetBancoConfig(0,'CONFIG041-' + IntToStr(intCodCar), 'MULATR_', '', strEmpresaImpressao) <> '') and
          (fGetBancoConfig(0,'CONFIG041-' + IntToStr(intCodCar), 'PERMULT', '', strEmpresaImpressao) = ''))   then
      Begin
        fGetBancoConfig(1, 'CONFIG041-' + IntToStr(intCodCar), 'PERMULT', fGetBancoConfig(0,'CONFIG041-' + IntToStr(intCodCar), 'MULATR_', '', strEmpresaImpressao), strEmpresaImpressao);
      end;
    end;

    if Not fEmptyStr(strBcoIni) Then
      fGetBancoConfig(1, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CFG_TAXDIA', FloatToStrF(fCfgSis('TAXDIA', varDouble), ffFixed, 12, 2));

    FPerMul   := IfThen(recDadosDigBoleto.fltPerMul = 0, fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'PERMULT', '', strEmpresaImpressao), fFloatToStrVirgula(recDadosDigBoleto.fltPerMul, 12, 2));
    If Not fEmptyStr(FPerMul) Then
      FMulta_ := fStrToFloat(FPerMul);

    FBraCrr     := recDadosDigBoleto.strBraCrr;
    FBB_Crr     := recDadosDigBoleto.strBB_Crr;
    FConCrr     := recDadosDigBoleto.strConCrr;

    FAltImp   := recDadosDigBoleto.blnAltImp;

    {****************************************}
    {* RESERVA 01 LINHA DE INSTRUÇÃO PARA   *}
    {* A IMPRESSÃO DA MSG DE PONTUALIDADE   *}
    {*************************************IV*}
    If (fCfgSis('DESPON', varBoolean, strEmpresaImpressao)) And
       ( Not fEmptyStr(strMens01)    ) Then
    Begin
      strMens02 := strMens01;
      strMens01 := '';
    End;
  Except
    On E: Exception Do
    Begin
      fMensagem('Atençao!', E.Message, ['&Ok']);
      blnConfirma := False;
    End;
  End;

  If (blnDupMercantil) or (Pos(FCodBco, '999_888_') > 0) Then
    Exit;

  If (Not blnEnvioAutmaticoEmail) And (blnProrrogado) And (fCfgSis('SELOBS', varBoolean, strEmpresaImpressao)) And
      fCarteiraPossuiObservacoes('CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar)) Then
    blnConfirma := fInformaObsBoleto('CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar))
  Else If (fCfgSis('SELOBS', varBoolean, strEmpresaImpressao)) Then
    strSelObs := '1_2_3_4_5_';

  If blnConfirma Then
  Begin
    blnConfirma := False;
    strNomImp   := strNomImpBol;
    strNomFrm   := IIF(blnFaturamento, 'frmFatVendas_BOLETO', 'frmImpBoletoIndiv');

    {****************************}
    {* QUESTIONA SE O USUÁRIO   *}
    {* DESEJA IMPRIMIR O BOLETO *}
    {*************************FS*}
    //blnEnvioAutmaticoEmail = CFG_EMASAI = e-mail de aviso de combrança;
    //blnEmaAut              = CFG_EMASAI = demais opções;
    If blnFaturamento And Not blnFaturadorAutomatico Then
    Begin
      If ((Not blnEnvioAutmaticoEmail) And (blnEmaAut)) or
         (((blnBolPdfV or blnEnvMaiV)) And (Not blnForcarImp) and (fCfgSis('FOIMBO', VarBoolean, strEmpresaImpressao))) Then
      Begin
        If (Pos(fCfgSis('IMPBOL'), 'A_S_') > 0) Then
        Begin
          If (fCfgSis('IMPBOL') = 'A') Or ((fCfgSis('TIPEXP') = '5') And (Self.blnFaturamento And Self.blnExpedicao)) Or
             (Self.blnFaturamento And Self.blnExpedicao And blnExpediMult) Then
            blnForcarImp := True
          Else
            blnForcarImp := (fMensagem('', 'Deseja imprimir o boleto?', ['&Sim', '&Não']) = 1);
        End;
      End;
    End;

    if FCodBco <> '778' then
      strTipBol := 'J';

    If fEmptyStr(strNomImp) And (Not blnPreview) And (IIF(blnFaturamento, ((Not blnEmaAut) Or blnForcarImp), blnForcarImp)) Then
    Begin
      pCarregaConfImpr(qryCfgRel, strNomFrm);
      strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

      strNomImp := fIdentificarNomeDaImpressora(strNomImp);

      If (qryCfgRel.RecordCount > 1) And fCfgSis('BOLMPI', varBoolean, strEmpresaImpressao) Then
        strNomImp := ''; // Chama tela para selecao da impressora

      If fEmptyStr(strNomImp) And fChamaSelecaoFilaImpressao Then
      Begin
        if not fPreImpressao(qryCfgRel, strNomImp, strTipBol, False, '', False) then
          Exit;
      End;
    End;

    If ((Not blnEmaAut) Or blnForcarImp) Then
    Begin

      If (strTipBol <> 'M') And (Not fCfgSis('IMPBOD', varBoolean, strEmpresaImpressao)) And (FCodBco <> '778') Then
      Begin

        If (Not fEmptyStr(fCfgSis('PATLA2', varString, strEmpresaImpressao))) Or
           (Not fEmptyStr(fCfgSis('PATLA3', varString, strEmpresaImpressao))) Then
        Begin
          Case fGetMenu('Selecione o destino.',['Impressora 1','Impressora 2','Impressora 3'],1) Of
            1: strPathBol := fCfgSis('PATLAS', varString, strEmpresaImpressao);
            2: strPathBol := fCfgSis('PATLA2', varString, strEmpresaImpressao);
            3: strPathBol := fCfgSis('PATLA3', varString, strEmpresaImpressao);
          End;
        End

        Else strPathBol := fCfgSis('PATLAS', varString, strEmpresaImpressao);

      End;

      If (strTipBol <> 'M') And (Not fCfgSis('IMPBOD', varBoolean, strEmpresaImpressao)) And (FCodBco <> '778') And (Not DirectoryExists(strPathBol)) Then
      Begin
        fMensagem('','Path para geração de boleto incorreto, favor alterar nas configurações do sistema no grupo boleto!',['&OK']);
        Exit;
      End;
    End;

    pProcessarClientesCtrDup();

    If FCodBco = '778' Then
    begin
      blnJaGerouNP := true;
      pImprimePromissorias(arrCtrDup, strTipBol, strNomFrm, strNomImp);
    end;

    LCarteiraBanco := 'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar)  + '-' + strEmpresaImpressao;

    If FCodBco = '077' Then
      LBancoInter := TBancoInter.Create('CONFIG' + strBcoIni + '-' + IntToStr(intCodCar) + strEmpresaImpressao)
    Else If (FBcoIni = '001API') Then LBancoDoBrasilApi := TBancoDoBrasilAPI.Create(LCarteiraBanco)
    Else If (FBcoIni = '097API') Then LBancoCredisisApi := TBancoCredisisAPI.Create(LCarteiraBanco)
    Else If (FBcoIni = '748API') Then LBancoSicrediApi  := TBancoSicrediAPI.Create(LCarteiraBanco)
    Else If (FBcoIni = '341API') Then LBancoItauApi := TBancoItauAPI.Create(LCarteiraBanco)
    Else If (FBcoIni = '756API') Then LBancoSicoobApi := TBancoSicoobAPI.Create(LCarteiraBanco)
    Else If (FBcoIni = '033API') Then LBancoSantanderApi := TBancoSantanderAPI.Create(LCarteiraBanco)
    Else If (FBcoIni = '422API') Then LBancoSafraApi  := TBancoSafraAPI.Create(LCarteiraBanco)
    Else If (FBcoIni = '237API') Then LBancoBradescoApi := TBancoBradescoAPI.Create(LCarteiraBanco);
    Try
      For intContCli := 0 To stlClientes.Count - 1 Do
      Begin
        If fRetCgcCpf(stlClientes[intContCli]).Trim.IsEmpty Then
          Raise ExceptionAutCom.Create('Para a emissão de Boletos, é necessário cadastrar o CPF/CNPJ do cliente ' +
                                       stlClientes[intContCli] + '-' + fRetNomCliente(stlClientes[intContCli]) + '!');

        strEmailCli   := '';
        strArqBoletos := '';

        SetLength(ACorpoMensagem, 1);

        if fCfgSis('ANEBOL', VarBoolean, strEmpresaImpressao) then
          ACorpoMensagem[0] := 'Segue(m) relação do(s) boleto(s) em anexo: '
        Else
          ACorpoMensagem[0] := 'Segue(m) relação do(s) boleto(s) ';

        blnEnviaEmailPortAut := True;
        blnEnviaSmsPortAut   := True;
        blnEnviaWppPortAut   := True;

        SetLength(LDuplicatasSMSWppArray, 0);

        pLimparImpressoraSelecionaBoleto;
        For intCont := 0 To Length(arrCtrDup)-1 Do
        Begin
          If (stlClientes[intContCli] <> arrCtrDup[intCont].strCodCli) Then
            Continue;

          untFuncoesBoleto.strLinDig := '';
          pAtualizaCamposUso(arrCtrDup[intCont]);

          If FCodBco <> '778' Then
          Begin

            Try

              {******************}
              {* TRAVA O LCKATC *}
              {***************AF*}
              If (Not blnEnvioAutmaticoEmail) And MatchStr(FBcoIni, ['001API']) Then
                pTravarImpressaoBoletosBancoDoBrasilAPI
              Else
                While (Not blnEnvioAutmaticoEmail) And
                      (Not fLock_Unlock(fChaveLockImpressaoBoletos, True, True, Not blnEnvioAutmaticoEmail, '', Not blnEnvioAutmaticoEmail)) Do
                  Application.ProcessMessages;


              If BoletoJaImpresso(qryConRec.FieldByName('AUTOINCREM').AsString) Then
              begin
                If (Not blnEnvioAutmaticoEmail) Then
                  fLock_Unlock(fChaveLockImpressaoBoletos, False);

                Continue;
              end;

              If FAltImp Then
              Begin
                LEnviaEmailCancelamentoBoleto := TEnviaEmailCancelamentoBoleto.Create(qryConRec.FieldByName('AUTOINCREM').AsString);
              End;

              If FUtilizaMultiplosBancos And FImprimiuSemPerguntar Then
              Begin
                FMultiplosBancos.strEspDoc := qryConRec.FieldByName('CTR_ESPDOC').AsString;

                FMultiplosBancos.pCarregaDadosMultiplosBancos(FCodBco,
                                                              FCodPor,
                                                              FBcoIni,
                                                              FCodCar,
                                                              qryConRec.FieldByName('CTR_DTACAD').AsDateTime,
                                                              qryConRec.FieldByName('CTR_DTAVEN').AsDateTime);

                If (Not FMultiplosBancos.fValidaPortadorMultiplosBancos(FCodPor) Or
                    Not FMultiplosBancos.fValidaBancoMultiplosBancos (FCodBco)) Then
                Begin
                  If (Not blnEnvioAutmaticoEmail) Then
                    fLock_Unlock(fChaveLockImpressaoBoletos, False);

                  Continue;
                End;


                FNosNum := FMultiplosBancos.RetornaNossoNumero(FCodBco,FBcoIni,strEmpresaImpressao,FCodCar);
              End;

              LImprimiuBoleto := True;

              // Valida Portadores E-Mail - SMS
              If Not fVerificaTemPortadorAut(0, blnFaturamento, FCodPor, strEmpresaImpressao) Then // E-MAIL;
                 blnEnviaEmailPortAut := False;

              If Not fVerificaTemPortadorAut(1, blnFaturamento, FCodPor, strEmpresaImpressao) Then // SMS;
                 blnEnviaSmsPortAut := False;

              If Not fVerificaTemPortadorAut(2, blnFaturamento, FCodPor, strEmpresaImpressao) Then // WHATSAPP;
                 blnEnviaWppPortAut := False;

              fStartTransaction;

              strReimpr := 'N';

              If (Not fEmptyStr(qryConRec.FieldByName('CTR_NOSNUM').AsString)) Then
                strPortadorAnt := qryConRec.FieldByName('CTR_CODPOR').AsString;

              If ( fCfgSis('DESPON', varBoolean, strEmpresaImpressao)       ) And
                 (qryConRec.FieldByName('CTR_PERDPO').AsFloat > 0) Then
              Begin
                If qryConRec.FieldByName('CTR_QTDDAV').AsInteger > 0 Then
                  FMens01 := 'CONCEDER DESCONTO DE ' + FormatFloat('#,##0.00', qryConRec.FieldByName('CTR_PERDPO').AsFloat) + '% SE PAGO ATE ' +
                             DateToStr(qryConRec.FieldByName('CTR_DTAVEN').AsDateTime - qryConRec.FieldByName('CTR_QTDDAV').AsInteger) + '.'
                Else
                  FMens01 := 'CONCEDER DESCONTO DE ' + FormatFloat('#,##0.00', qryConRec.FieldByName('CTR_PERDPO').AsFloat) +
                             '% SE PAGO ATE O VENCIMENTO.';
              End
              Else If fCfgSis('DESPON', varBoolean, strEmpresaImpressao) Then
                FMens01 := '';

              FDesCtr := qryConRec.FieldByName('CTR_DESSUJ').AsFloat;

              If (Not fEmptyStr(qryConRec.FieldByName('CTR_NOSNUM').AsString)) And (qryConRec.FieldByName('CTR_BCOBOL').AsString = FCodBco) And Not (FAltImp) Then
              Begin
                if not (fRetNumCartReimpressao(qryConRec.FieldByName('CTR_CARTEI').AsString) = FCodCar) then
                begin
                  fGravaNumCart(FCodBco,
                                IIF(fEmptyStr(strPortadorAnt), FCodPor, strPortadorAnt),
                                FNosNum,
                                FNumDig,
                                Nil,
                                @arrCtrDup[intCont],
                                FBcoIni,
                                FCodCar,
                                FBB_Crr,
                                FValMor,
                                fStrToFloat(FPerMul),
                                strEmpresaImpressao);
                end;

                strNosNumReimpr := fNossoNumeroAnterior(arrCtrDup[intCont], FCodPor = qryConRec.FieldByName('CTR_CODPOR').AsString);
                strReimpr := 'S';

                If FCodBco = '077' Then
                  strLinhaDigitavelAPI := qryConRec.FieldByName('CTR_LINDIG').AsString;

                If MatchStr(FBcoIni, ['001API']) Then
                Begin
                  LBancoDoBrasilApi.ReimpressaoDeBoleto(qryConRec.FieldByName('AUTOINCREM').AsString);
                  TRetornoBoletoBancoDoBrasil(LRetornoRegistroBoletoApi) := LBancoDoBrasilApi.RetornoBandoDoBrasilAPI;
                End;

                If MatchStr(FBcoIni, ['097API']) Then
                Begin
                  ReimpressaoBoletoBancoCredisisAPI( LBancoCredisisApi, qryConRec.FieldByName('AUTOINCREM').AsString );
                  TRetornoBoletoBancoCredisis(LRetornoRegistroBoletoApi) := LBancoCredisisApi.RetornoBancoCredisisAPI;
                End;

                If MatchStr(FBcoIni, ['748API']) Then
                Begin
                  LBancoSicrediApi.ReimpressaoDeBoleto(qryConRec.FieldByName('AUTOINCREM').AsString);
                  TRetornoBoletoBancoSicredi(LRetornoRegistroBoletoApi) := LBancoSicrediApi.RetornoBancoSicrediAPI;
                End;

                If MatchStr(FBcoIni, ['341API']) Then
                Begin
                  LBancoItauApi.ReimpressaoDeBoleto(qryConRec.FieldByName('AUTOINCREM').AsString);
                  TRetornoBoletoItau(LRetornoRegistroBoletoApi) := LBancoItauApi.RetornoBancoItauAPI;
                End;

                If MatchStr(FBcoIni, ['756API']) Then
                Begin
                  LBancoSicoobApi.ReimpressaoDeBoleto(qryConRec.FieldByName('AUTOINCREM').AsString);
                  TRetornoBoletoSicoob(LRetornoRegistroBoletoApi) := LBancoSicoobApi.RetornoBancoSicoobAPI;
                End;

                If MatchStr(FBcoIni, ['033API']) Then
                Begin
                  LBancoSantanderApi.ReimpressaoDeBoleto(qryConRec.FieldByName('AUTOINCREM').AsString);
                  TRetornoBoletoSantander(LRetornoRegistroBoletoApi) := LBancoSantanderApi.RetornoBancoSantanderAPI;
                End;

                If MatchStr(FBcoIni, ['422API']) Then
                Begin
                  LBancoSafraApi.ReimpressaoDeBoleto(qryConRec.FieldByName('AUTOINCREM').AsString);
                  TRetornoBoletoBancoSafra(LRetornoRegistroBoletoApi) := LBancoSafraApi.RetornoBancoSafraAPI;
                End;

                If MatchStr(FBcoIni, ['237API']) Then
                Begin
                  LBancoBradescoApi.ReimpressaoDeBoleto(qryConRec.FieldByName('AUTOINCREM').AsString);
                  TRetornoBoletoBradesco(LRetornoRegistroBoletoApi) := LBancoBradescoApi.RetornoBancoBradescoAPI;
                End;

                arrCtrDup[intCont].QRCodePix := qryConRec.FieldByName('CTR_QRCODE').AsString;
                arrCtrDup[intCont].LinkPixCitel := RetornaLinkPixCitelValido(qryConRec);
              End
              Else
              Begin
                qryGen := fCriaQuery(Self);

                {************************************************}
                {* TRAVA A TABELA CADBCO PARA PEGAR NOSSONUMERO *}
                {*********************************************AF*}
                //If FCodBco <> '077' Then
                If (Not MatchStr(FCodBco, ['077','097'])) And (Not MatchStr(FBcoIni, ['748API','756API'])) Then
                Begin
                  If qryConRec.FieldByName('CTR_BOLINT').AsString = 'S' Then
                    Raise Exception.Create('INTER-O boleto dessa duplicata poderá ser gerado apenas no banco Inter.' + #13 +
                                           'Operação cancelada.');

                  If DuplicataCorrespondenteAOutroBanco(FBcoIni,arrCtrDup[intCont].strAutoIn,LNomBcoApi) and
                    (not BoletoApiCancelado(arrCtrDup[intCont].strAutoIn)) Then
                    Raise Exception.Create(
                      'BCOAPI-A parcela "A" da duplicata ' + arrCtrDup[intCont].strNumDup + arrCtrDup[intCont].strParcel +
                      ' teve o boleto gerado através do faturamento ' +
                      'utilizando o banco "' + LNomBcoApi +'". Entretanto, esta parcela não possui um boleto registrado, ' +
                      'indicando que houve alguma instabilidade na API que impediu sua geração. ' +
                      'Portanto, não será possível gerar este boleto utilizando outro banco, apenas o "' + LNomBcoApi + '".'
                    );


                  If Not CarteiraValidaParaImpressaoDeBoleto(FCodBco,FBcoIni)Then
                      Raise Exception.Create('A carteira '+LCarteiraBanco+' não é valida para impressão de boleto! ');

                  qryGen.SQL.Add('SELECT * FROM CADBCO WHERE BCO_CODBCO = :CODBCO FOR UPDATE');
                  qryGen.ParamByName('CODBCO').AsString := FCodBco;
                  qryGen.Open;

                  LNossoNumeroDisponivel := fRetNossoNumeroDisponivel(FCodBco, FNosNum, FBcoIni, FCodCar, strEmpresaImpressao);
                  strNosNumNovo := fCalcNossoNumero(FCodBco, LNossoNumeroDisponivel, FBcoIni, FCodCar, strEmpresaImpressao);

                  If fEmptyStr(strNosNumNovo) Then
                  Begin
                    If FCodBco = '104' Then
                    Begin
                      If (fGetBancoConfig(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'NUMCART', '', strEmpresaImpressao) = '12')   And
                         (fGetBancoConfig(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'SISCOB', '', strEmpresaImpressao) = 'SIGCB') Then
                      Begin
                        fRollBack;
                        fLock_Unlock(fChaveLockImpressaoBoletos, False);
                        Exit;
                      End;
                    End;

                    Raise Exception.CreateFmt(
                      'Não foi possível determinar o nosso número com as informações abaixo: '+#13+
                      'Banco: %s'+#13+
                      'Nosso número duplicata: %s'+#13+
                      'Nosso número disponível: %s'+#13+
                      'Código banco: %s'+#13+
                      'Carteira: %d'+#13+
                      'Empresa: %s',
                      [FCodBco,
                       FNosNum,
                       LNossoNumeroDisponivel,
                       FBcoIni,
                       FCodCar,
                       strEmpresaImpressao]);
                  End
                  Else
                    FNosNum := strNosNumNovo;

                  strTpIden := fGetBancoConfig(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'TPIDENT', '5', strEmpresaImpressao);
                  If (strTpIden = '4') Then
                    FNumDig := fCalcDigito(FCodBco, IntToStr(StrToInt64(strNosNumNovo)), FBcoIni, FCodCar, qryConRec.FieldByName('CTR_DTAVEN').AsString)
                  Else
                    FNumDig := fCalcDigito(FCodBco, IntToStr(StrToInt64(strNosNumNovo)), FBcoIni, FCodCar, strEmpresaImpressao);


                  If (FBcoIni = '001API') Then
                  Begin
                    If ValidaImpressaoBoleto Then
                    Begin
                      FNosNum := RightStr((FNosNum + FNumDig), 12);
                      RegistrarBoletoBancoDoBrasilAPI(LBancoDoBrasilApi,
                                                      LGerouBoletoApi,
                                                      arrCtrDup,
                                                      FNosNum,
                                                      intCont);

                      If LGerouBoletoApi Then
                      Begin
                        strNosNumNovo        := RightStr((FNosNum + FNumDig), 12);
                        LLinhaDigitavel      := LBancoDoBrasilApi.RetornoBandoDoBrasilAPI.linhaDigitavel;
                        FNosNum              := strNosNumNovo;
                        TRetornoBoletoBancoDoBrasil(LRetornoRegistroBoletoApi) := LBancoDoBrasilApi.RetornoBandoDoBrasilAPI;

                        arrCtrDup[intCont].QRCodePix := TRetornoBoletoBancoDoBrasil(LRetornoRegistroBoletoApi).QrCodeEmv;
                        arrCtrDup[intCont].LinkPixCitel := TRetornoBoletoBancoDoBrasil(LRetornoRegistroBoletoApi).QrCodeLinkCitel;
                      End;
                    End;
                  End;

                  If (FBcoIni = '341API') Then
                  Begin

                    FNosNum := RightStr(FNosNum, 8);
                    RegistrarBoletoBancoItauAPI(LBancoItauApi,
                                                LGerouBoletoApi,
                                                arrCtrDup,
                                                FNosNum,
                                                intCont);

                    If LGerouBoletoApi Then
                    Begin
                      strNosNumNovo        := LBancoItauApi.RetornoBancoItauAPI.nossoNumero;
                      LLinhaDigitavel      := LBancoItauApi.RetornoBancoItauAPI.linhaDigitavel;
                      TRetornoBoletoItau(LRetornoRegistroBoletoApi) := LBancoItauApi.RetornoBancoItauAPI;

                      arrCtrDup[intCont].QRCodePix := TRetornoBoletoItau(LRetornoRegistroBoletoApi).QrCodeEmv;
                      arrCtrDup[intCont].LinkPixCitel := TRetornoBoletoItau(LRetornoRegistroBoletoApi).QrCodeLinkCitel;
                    End
                    Else If LBancoItauApi.ErroNossoNumeroDuplicado Then
                      Raise Exception.Create(LBancoItauApi.TextoErroNossoNumeroDuplicado);
                  End;

                  If (FBcoIni = '422API') Then
                  Begin

                    FNosNum := RightStr(FNosNum, 9);
                    RegistrarBoletoBancoSafraAPI(LBancoSafraApi,
                                                 LGerouBoletoApi,
                                                 arrCtrDup,
                                                 FNosNum,
                                                 intCont);

                    If LGerouBoletoApi Then
                    Begin
                      strNosNumNovo        := LBancoSafraApi.RetornoBancoSafraAPI.nossoNumero;
                      LLinhaDigitavel      := LBancoSafraApi.RetornoBancoSafraAPI.linhaDigitavel;
                      TRetornoBoletoBancoSafra(LRetornoRegistroBoletoApi) := LBancoSafraApi.RetornoBancoSafraAPI;

                      arrCtrDup[intCont].QRCodePix := TRetornoBoletoBancoSafra(LRetornoRegistroBoletoApi).QrCodeEmv;
                      arrCtrDup[intCont].LinkPixCitel := TRetornoBoletoBancoSafra(LRetornoRegistroBoletoApi).QrCodeLinkCitel;
                    End
                    Else
                      Raise Exception.Create('Erros encontrados ao gerar o arquivo de requisição da API.')

                  End
                  Else If (FBcoIni = '033API') Then
                  Begin
                    FNosNum := RightStr(FNosNum, 13);
                    RegistrarBoletoBancoSantanderAPI(LBancoSantanderApi,
                                                     LGerouBoletoApi,
                                                     arrCtrDup,
                                                     FNosNum,
                                                     intCont);

                    If LGerouBoletoApi Then
                    Begin
                      strNosNumNovo        := LBancoSantanderApi.RetornoBancoSantanderAPI.nossoNumero;
                      LLinhaDigitavel      := LBancoSantanderApi.RetornoBancoSantanderAPI.linhaDigitavel;
                      TRetornoBoletoSantander(LRetornoRegistroBoletoApi) := LBancoSantanderApi.RetornoBancoSantanderAPI;
                      FNosNum := strNosNumNovo;

                      arrCtrDup[intCont].QRCodePix := TRetornoBoletoSantander(LRetornoRegistroBoletoApi).QrCodeEmv;
                      arrCtrDup[intCont].LinkPixCitel := TRetornoBoletoSantander(LRetornoRegistroBoletoApi).QrCodeLinkCitel;
                    End;

                  End
                  Else If (FBcoIni = '237API') Then
                  Begin
                    FNosNum := RightStr(FNosNum, 11);

                    RegistrarBoletoBancoBradescoAPI(LBancoBradescoApi,
                                                    LGerouBoletoApi,
                                                    arrCtrDup,
                                                    FNosNum,
                                                    intCont);

                    If LGerouBoletoApi Then
                    Begin
                      strNosNumNovo        := LBancoBradescoApi.RetornoBancoBradescoAPI.NuTituloGerado.ToString;
                      LLinhaDigitavel      := LBancoBradescoApi.RetornoBancoBradescoAPI.linhaDigitavel;
                      TRetornoBoletoBradesco(LRetornoRegistroBoletoApi) := LBancoBradescoApi.RetornoBancoBradescoAPI;
                      FNosNum := strNosNumNovo;

                      arrCtrDup[intCont].QRCodePix := TRetornoBoletoBradesco(LRetornoRegistroBoletoApi).QrCodeEmv;
                      arrCtrDup[intCont].LinkPixCitel := TRetornoBoletoBradesco(LRetornoRegistroBoletoApi).QrCodeLinkCitel;
                    End;
                  End;


                End
                Else
                Begin
                  //APIs que retornam o Nosso Número

                  If MatchStr(FCodBco, ['077']) Then
                  Begin
                    LContadorTentativas := 1;
                    LErroAPI := False;
                    LRetornoAPI := TRetornoBoletoBancoInter.Create;

                    While (LContadorTentativas <= 3) Do
                    Begin
                      Try
                        LBancoInter.PercentualMulta := FMulta_;
                        LBancoInter.PercentualMora := FValMor;
                        LRetornoAPI := LBancoInter.CadastrarNovoBoleto(qryConRec, qryConCli);

                        LGerouBancoInter := True;

                        LErroAPI := False;
                      Except
                        On E: Exception Do
                        Begin
                          LErroAPI := True;

                          If (LContadorTentativas >= 3) Or Not LBancoInter.TentarNovamente Then
                          Begin
                            LDocumentosRestantes := '';
                            LAutoIncremInter := '';

                            For LContadorRestantes := intCont To Length(arrCtrDup)-1 Do
                            Begin
                              LDocumentosRestantes := LDocumentosRestantes + arrCtrDup[LContadorRestantes].strNumDup +
                                                                             arrCtrDup[LContadorRestantes].strParcel + '-' +
                                                                             arrCtrDup[LContadorRestantes].strEspdoc + '-' +
                                                                             arrCtrDup[LContadorRestantes].strCodEmp + ', ';

                              If blnFaturamento Then
                                LAutoIncremInter := LAutoIncremInter + '"' + arrCtrDup[LContadorRestantes].strAutoIn + '",';
                            End;

                            LDocumentosRestantes := LeftStr(LDocumentosRestantes, LDocumentosRestantes.Length - 2);

                            If Not LAutoIncremInter.IsEmpty Then
                              LAutoIncremInter := LeftStr(LAutoIncremInter, LAutoIncremInter.Length - 1);

                            If Copy(E.Message, 1, 6) = 'INTER-' Then
                            Begin
                              Raise Exception.Create(E.Message  + #13 +
                                                    'Documentos que ficaram sem gerar boleto: ' + LDocumentosRestantes);
                            End;

                            Raise Exception.Create('BCOAPI-Ocorreram erros ao registrar o boleto no Banco Inter.' + #13#10 +
                                                   'Erro gerado: ' + E.Message + #13#10 +
                                                   'Solução: ' + LBancoInter.RetornaSolucaoErro(E.Message) + #13#10 +
                                                   'Documentos ficaram sem gerar boleto: ' + LDocumentosRestantes);
                          End;
                        End;
                      End;

                      Inc(LContadorTentativas);

                      If Not LErroAPI Then
                        Break;
                    End;

                    strNosNumNovo := LRetornoAPI.nossoNumero;
                    LLinhaDigitavel := LRetornoAPI.linhaDigitavel;

                    FNosNum := strNosNumNovo;

                    strLinhaDigitavelAPI := LLinhaDigitavel;
                  End
                  Else If MatchStr(FCodBco, ['097']) Then
                  Begin

                    If (FBcoIni = '097API') Then
                    Begin
                      If ValidaImpressaoBoleto Then
                      Begin
                        FNosNum := '0';
                        RegistrarBoletoBancoCredisisAPI(LBancoCredisisApi,
                                                        LGerouBancoCredisisApi,
                                                        arrCtrDup,
                                                        FNosNum,
                                                        intCont);

                        If LGerouBancoCredisisApi Then
                        Begin
                          LLinhaDigitavel      := LBancoCredisisApi.RetornoBancoCredisisAPI.linhaDigitavel;
                          FNosNum              := LBancoCredisisApi.RetornoBancoCredisisAPI.nossoNumero;
                          TRetornoBoletoBancoCredisis(LRetornoRegistroBoletoApi) := LBancoCredisisApi.RetornoBancoCredisisAPI;
                        End
                        Else
                           Raise Exception.Create('Erros encontrados ao gerar o arquivo de requisição da API.')

                      End;
                    End;

                  End
                  Else If MatchStr(FCodBco, ['748']) Then
                  Begin

                  If (FBcoIni = '748API') Then
                  Begin
                    If LBancoSicrediApi.fDiasNegativacaoParaMatoGrossoDoSulEhInvalido(
                         qryConCli.FieldByName('CID_ESTADO').AsString) Then
                      raise EExceptionBancoSicrediAPI.Create(
                        'Para clientes do estado do Mato Grosso do Sul(MS) será necessário '+
                        'preencher o campo "Dias para Negativação(UF: Mato Grosso do Sul)" '+
                        'na carteira do banco.');

                    If ValidaImpressaoBoleto Then
                    Begin
                      FNosNum := '0';
                        RegistrarBoletoBancoSicrediAPI(LBancoSicrediApi,
                                                       LGerouBancoSicrediApi,
                                                       arrCtrDup,
                                                       FNosNum,
                                                       intCont);

                        If LGerouBancoSicrediApi Then
                        Begin
                          LLinhaDigitavel      := LBancoSicrediApi.RetornoBancoSicrediAPI.linhaDigitavel;
                          FNosNum              := LBancoSicrediApi.RetornoBancoSicrediAPI.nossoNumero;
                          TRetornoBoletoBancoSicredi(LRetornoRegistroBoletoApi) := LBancoSicrediApi.RetornoBancoSicrediAPI;

                          arrCtrDup[intCont].QRCodePix := TRetornoBoletoBancoSicredi(LRetornoRegistroBoletoApi).QrCodeEmv;
                          arrCtrDup[intCont].LinkPixCitel := TRetornoBoletoBancoSicredi(LRetornoRegistroBoletoApi).QrCodeLinkCitel;
                        End
                        Else
                           Raise Exception.Create('Erros encontrados ao gerar o arquivo de requisição da API.')

                      End;
                    End;

                  End
                  Else If (FBcoIni = '756API') Then
                  Begin
                    FNosNum := '0';

                    RegistrarBoletoBancoSicoobAPI(LBancoSicoobApi,
                                                  LGerouBoletoApi,
                                                  arrCtrDup,
                                                  FNosNum,
                                                  intCont);

                    If LGerouBoletoApi Then
                    Begin
                      strNosNumNovo        := LBancoSicoobApi.RetornoBancoSicoobAPI.nossoNumero;
                      LLinhaDigitavel      := LBancoSicoobApi.RetornoBancoSicoobAPI.linhaDigitavel;
                      TRetornoBoletoSicoob(LRetornoRegistroBoletoApi) := LBancoSicoobApi.RetornoBancoSicoobAPI;
                      FNosNum := strNosNumNovo;

                      arrCtrDup[intCont].QRCodePix := TRetornoBoletoSicoob(LRetornoRegistroBoletoApi).QrCodeEmv;
                      arrCtrDup[intCont].LinkPixCitel := TRetornoBoletoSicoob(LRetornoRegistroBoletoApi).QrCodeLinkCitel;
                    End;

                  End;

                End;

                qryGen.Close;
                FreeAndNil(qryGen);
              End;

              if strReimpr <> 'S' then
              begin
                If Not fGravaNumBco(FCodBco,
                                   {************************************************}
                                   {* VERIFICAÇÃO DE PORTADOR COMENTADA POR NÃO    *}
                                   {* ESTAR GRAVANDO O ULTIMO PORTADOR DO BOLETO.  *}
                                   {* AO ALTERAR O PORTADOR E O BANCO DO BOLETO NA *}
                                   {* REIMPRESSÃO, ATUALIZAR BANCO E PORTADOR.     *}
                                   {*RQ: 31709 **********************************BB*}
                                   //IIF(fEmptyStr(strPortadorAnt), FCodPor, strPortadorAnt),
                                    FCodPor,
                                    FNosNum,
                                    FNumDig,
                                    qryConRec,
                                    @arrCtrDup[intCont],
                                    FBcoIni,
                                    FCodCar,
                                    FBB_Crr,
                                    FValMor,
                                    fStrToFloat(FPerMul),
                                    '',
                                    strEmpresaImpressao,
                                    LLinhaDigitavel,
                                    FMens01,
                                    FMens02) Then
                begin
                  fRollBack;
                  Raise Exception.Create('Não foi possível fazer a gravação do Nosso Número no Contas a receber! Tente Novamente!');
                end;
              end;

              fCommit;

              If Assigned(LBancoDoBrasilApi) Then
                LBancoDoBrasilApi.GravarDadosRequisicaoRegistroBoleto;

              If Assigned(LBancoCredisisAPI) Then
                LBancoCredisisAPI.GravarDadosRequisicaoRegistroBoleto;

              If Assigned(LBancoItauApi) Then
                LBancoItauApi.GravarDadosRequisicaoRegistroBoleto;

              If Assigned(LBancoSicoobApi) Then
                LBancoSicoobApi.GravarDadosRequisicaoRegistroBoleto;

              If Assigned(LBancoSantanderApi) Then
                LBancoSantanderApi.GravarDadosRequisicaoRegistroBoleto;

              If Assigned(LBancoSafraApi) Then
                LBancoSafraApi.GravarDadosRequisicaoRegistroBoleto;

              If Assigned(LBancoBradescoApi) Then
                LBancoBradescoApi.GravarDadosRequisicaoRegistroBoleto;

              If (Not blnEnvioAutmaticoEmail) Then
                fLock_Unlock(fChaveLockImpressaoBoletos, False);

              blnConfirma := fGeraBoletoLaser(FCodBco,
                                              cpuCampos,
                                              FValMor,
                                              IIF(fEmptyStr(strNosNumReimpr), FNosNum, strNosNumReimpr),
                                              FNumDig,
                                              fCadEmpDes('NOMEMP', strEmpresaImpressao),
                                              fCadEmpDes('C_G_C_', strEmpresaImpressao),
                                              FBcoIni,
                                              FCodCar,
                                              strArqBoletos,
                                              FBoletoCarneBuilder,
                                              FBoleto1ViaBuilder,
                                              FMens01,
                                              FMens02,
                                              strReimpr,
                                              strPathBol,
                                              blnBolPdfV,
                                              FBraCrr,
                                              FBB_Crr,
                                              FConCrr,
                                              strNomFrm,
                                              strNomImp,
                                              FMulta_,
                                              blnForcarImp,
                                              arrCtrDup[intCont].blnAvisoAutomaticoEmail,
                                              IIF((blnReimp) And (Not blnAltImp) And (Not qryConRec.FieldByName('CTR_CARTEI').AsString.IsEmpty),
                                                   qryConRec.FieldByName('CTR_CARTEI').AsString,
                                                   strEmpresaImpressao),
                                              strSelObs,
                                              blnPreview,
                                              arrCtrDup[intCont].strMsgProrrogacao,
                                              (blnEnvMaiV or blnEmaAut),
                                              blnFaturamento,
                                              LReimprimirBoletoOriginal);

              If blnConfirma Then
              Begin
                // grava se não for reimpressão ou se for alteração de boleto
                If Not blnReimp Or FAltImp Then
                Begin
                  LDuplicataBoleto.strNumDup := AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'], #39, '');
                  LDuplicataBoleto.strParcel := AnsiReplaceStr(cpuCampos['CADREC->CTR_PARCEL'], #39, '');
                  LDuplicataBoleto.strEspDoc := AnsiReplaceStr(cpuCampos['CADREC->CTR_ESPDOC'], #39, '');
                  LDuplicataBoleto.strCodEmp := AnsiReplaceStr(cpuCampos['CADREC->CTR_CODEMP'], #39, '');
                  LDuplicataBoleto.strCodCli := AnsiReplaceStr(cpuCampos['CADREC->CTR_CODCLI'], #39, '');

                  GravarCarteiraBoleto(LDuplicataBoleto,LCarteiraBanco);
                End;
              End;

              If blnConfirma Then
              begin
                If ((Not fUtilizaBoletoCarne) And (Not fUtilizaBoleto1Via)) Or (fBancoUtilizaApenasLayoutPadrao) Then
                  arrCtrDup[intCont].ArquivoBoleto := ExtractFilePath(Application.ExeName) + 'Boletos\' + qryConRec.FieldByName('CTR_NUMDUP').AsString +
                                                                                                          qryConRec.FieldByName('CTR_PARCEL').AsString + '.pdf';

                fGravaDtaBoletoImpresso(qryConRec,strCodBco);

                SetLength(ACorpoMensagem, Length(ACorpoMensagem)+1);

                if fCfgSis('ANEBOL', VarBoolean, strEmpresaImpressao) then
                begin
                  ACorpoMensagem[Length(ACorpoMensagem)-1] := AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'] + cpuCampos['CADREC->CTR_PARCEL'], #39, '');
                end
                Else
                begin
                  ACorpoMensagem[Length(ACorpoMensagem)-1] := AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'] + cpuCampos['CADREC->CTR_PARCEL'], #39, '');
                  SetLength(ACorpoMensagem, Length(ACorpoMensagem)+1);
                  ACorpoMensagem[Length(ACorpoMensagem)-1] := 'Linha Digitável: ' + strLinDig;
                  ACorpoMensagemEMASAI := ACorpoMensagemEMASAI + ' Linha Digitável: ' + strLinDig + #13#10;
                end;

                //Se der erro nas intruções, o sistema estava gravando na LOGREP, pois estava
                //fora de uma transação
                fStartTransaction;

                If (Not ABoletoCarne) And (Not ABoleto1Via) Then
                  GravarPDFBoleto(AnsiReplaceStr(cpuCampos['CADREC->AUTOINCREM'], #39, ''),
                                  ExtractFilePath(Application.ExeName) + 'Boletos\' + AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'] + cpuCampos['CADREC->CTR_PARCEL'], #39, '') + '.pdf');

                arrCtrDup[intcont].LinkDoBoleto := qryConRec.FieldByName('LINK_DO_BOLETO').AsString;

                If VS_strHabilitarCRM And (Not fEmptyStr(fCfgSis('OCOFIN', varString)))  Then
                Begin
                  TAtuOcoCrm.pAtualizaOcorrenciaFinanceiro(AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'], #39, ''),
                                                           AnsiReplaceStr(cpuCampos['CADREC->CTR_ESPDOC'], #39, ''),
                                                           AnsiReplaceStr(cpuCampos['CADREC->CTR_CODEMP'], #39, ''),
                                                           AnsiReplaceStr(cpuCampos['CADREC->CTR_CODCLI'], #39, ''),
                                                           AnsiReplaceStr(cpuCampos['CADREC->CTR_PARCEL'], #39, ''),
                                                           strLoginUsuarioLogado,
                                                           fRetCgcCpf(AnsiReplaceStr(cpuCampos['CADREC->CTR_CODCLI'], #39, '')),
                                                           afcImpressaoBoleto);
                End;

                {****************}
                {* GRAVA LOGCTR *}
                {*************JS*}
                untCadRec.pGravaLogCtr(qryConRec.FieldByName('AUTOINCREM').AsString,
                                       IIF(strReimpr = 'N', 'IMPRESSÃO DE BOLETO', 'REIMPRESSÃO DE BOLETO')+IIF(blnImpManual,' - MANUAL - ',' - ') + IIF(blnFaturamento,'FATURAMENTO','FINANCEIRO'),
                                       'untBoletos');

                fCommit;
              end
              ELSE
              BEGIN
                fMensagem('','Não foi possível imprimir o boleto selecionado.',['&OK']);

                Exit;
              END;

              If strReimpr = 'N' Then
                If (Not fEmptyStr(FNosNum)) And (FCodBco <> '097') Then
                  FNosNum := IntToStr(StrToInt64(FNosNum)+1);

              strReimpr := 'N';
              strNosNumReimpr := '';

            Except
              On E: Exception Do
              Begin
                fRollBack;

                Try
                  fStartTransaction;
                  If Assigned(LBancoDoBrasilApi) Then
                    LBancoDoBrasilApi.GravarDadosRequisicaoRegistroBoleto;

                  If Assigned(LBancoCredisisAPI) Then
                    LBancoCredisisAPI.GravarDadosRequisicaoRegistroBoleto;

                  If Assigned(LBancoItauApi) Then
                    LBancoItauApi.GravarDadosRequisicaoRegistroBoleto;

                  If Assigned(LBancoSicrediAPI) Then
                    LBancoSicrediAPI.GravarDadosRequisicaoRegistroBoleto;

                  If Assigned(LBancoSicoobApi) Then
                    LBancoSicoobApi.GravarDadosRequisicaoRegistroBoleto;

                  If Assigned(LBancoBradescoApi) Then
                    LBancoBradescoApi.GravarDadosRequisicaoRegistroBoleto;

                  If Assigned(LBancoSantanderApi) Then
                    LBancoSantanderApi.GravarDadosRequisicaoRegistroBoleto;

                  If Assigned(LBancoSafraApi) Then
                    LBancoSafraApi.GravarDadosRequisicaoRegistroBoleto;

                  If Assigned(LBancoInter) Then
                    LBancoInter.GravarDadosRequisicaoRegistroBoleto;

                  fCommit;
                Except
                  On EBol: Exception Do
                  Begin
                    fRollBack;
                    pGravarErro(True,
                                'Falha ao gravar REGBOL no caminho de exceção: ' + EBol.Message
                                {$IFNDEF LINUX}, GetComputerNetName + #13#10 + fRetornaStack{$ENDIF});
                  End;
                End;

                If Assigned(LBancoItauAPI) Then
                Begin
                  If LBancoItauAPI.ErroNossoNumeroDuplicado Then
                    AcrescentaNossoNumeroCadBco(qryGen, strNosNumNovo, LeftStr(strCodBco, 3));
                 End;

                If (Not blnEnvioAutmaticoEmail) Then
                  fLock_Unlock(fChaveLockImpressaoBoletos, False);

                If Assigned(qryGen) Then
                Begin
                  qryGen.Close;
                  FreeAndNil(qryGen);
                End;

                If Not LAutoIncremInter.IsEmpty Then
                Begin
                  If LGerouBancoInter Then
                    untCadRec.MarcarComoBoletoBancoInter(LAutoIncremInter);
                End;

                If Copy(E.Message, 1, 6) = 'INTER-' Then
                Begin
                  fMensagem('ATENÇÃO', RightStr(E.Message, E.Message.Length - 6), ['&OK']);
                  Exit;
                End;

                If Copy(E.Message, 1, 7) = 'BCOAPI-' Then
                Begin
                  ExibeFormMensagemErro(RightStr(E.Message, E.Message.Length - 7));
                  Exit;
                End;


              If (E Is EExceptionBancoSicrediAPI) Then
              Begin
                fMensagem('ATENÇÃO', E.Message, ['&OK']);
                Exit;
              End;

              pMensagensErro(E.Message,'[TBoleto.pImprimir]');

              Exit;
              End;
            End;

            If Not arrCtrDup[intCont].LinkPixCitel.IsEmpty Then
              arrCtrDup[intCont].LinkPixCitel := 'https://pix.citelsoftware.com.br/' + arrCtrDup[intCont].LinkPixCitel;

            SetLength(LDuplicatasSMSWppArray, Length(LDuplicatasSMSWppArray) + 1);
            LDuplicatasSMSWppArray[Length(LDuplicatasSMSWppArray) - 1] := arrCtrDup[intCont];
          End;

          //Grava boletos por empresa
          If (fCfgSis('GRVBOL') = '2') And ((Not ABoletoCarne) And (Not ABoleto1Via)) Then
          Begin
             GravaPDFPorEmpresa( AnsiReplaceStr(cpuCampos['CADREC->AUTOINCREM'], #39, ''),
                                 ExtractFilePath(Application.ExeName) + 'Boletos\' + AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'] + cpuCampos['CADREC->CTR_PARCEL'], #39, '') + '.pdf');

             stlBoletosRealocados.Add( AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'] + cpuCampos['CADREC->CTR_PARCEL'], #39, '') + '.pdf' );

          End;
        End; //For Duplicatas

        If Not LImprimiuBoleto Then
          Exit;

        if ABoletoCarne And Not MatchStr(strBcoIni, ['077','341API','748API','021','756API','033API']) then
        begin
          try
            if FBoletoCarneBuilder.fImprimiBoletoCarne(blnForcarImp, strNomFrm, strNomImp, blnPreview, blnEnvioAutmaticoEmail, false, blnEnvMaiV, blnFaturamento) then
            begin
              strArqBoletos := FBoletoCarneBuilder.fGetListaArquivosGerados;

              GravarPDFBoletosCarne(arrCtrDup,
                                    ExtractFilePath(Application.ExeName) + 'Boletos\');

              fCommit;

              LDuplicatasSMSWppArray[Length(LDuplicatasSMSWppArray) - 1].ArquivoBoleto := strArqBoletos;
            end
            else
            begin
              fRollBack;

              If (Not blnEnvioAutmaticoEmail) Then
                fLock_Unlock(fChaveLockImpressaoBoletos, False);

              fMensagem('','Não foi possível imprimir o(s) boleto(s) selecionado(s).',['&OK']);
              Exit;
            end;

          Except
            On E: Exception Do
            Begin
              fRollBack;

              If (Not blnEnvioAutmaticoEmail) Then
                fLock_Unlock(fChaveLockImpressaoBoletos, False);

              pMensagensErro(E.Message,'[TBoleto.pImprimir]');
              Exit;
            End;
          End;
        end
        else
        if ABoleto1Via And Not MatchStr(strBcoIni, ['077']) then
        begin
          try
            if FBoleto1ViaBuilder.fImprimiBoleto1Via(blnForcarImp, strNomFrm, strNomImp, blnPreview, blnEnvioAutmaticoEmail, blnEnvMaiV, blnFaturamento) then
            begin
              strArqBoletos := FBoleto1ViaBuilder.fGetListaArquivosGerados;

              GravarPDFBoletosCarne(arrCtrDup,
                                    ExtractFilePath(Application.ExeName) + 'Boletos\');

              fCommit;

              LDuplicatasSMSWppArray[Length(LDuplicatasSMSWppArray) - 1].ArquivoBoleto := strArqBoletos;
            end
            else
            begin
              fRollBack;

              If (Not blnEnvioAutmaticoEmail) Then
                fLock_Unlock(fChaveLockImpressaoBoletos, False);

              fMensagem('','Não foi possível imprimir o(s) boleto(s) selecionado(s).',['&OK']);
              Exit;
            end;

          Except
            On E: Exception Do
            Begin
              fRollBack;

              If (Not blnEnvioAutmaticoEmail) Then
                fLock_Unlock(fChaveLockImpressaoBoletos, False);

              pMensagensErro(E.Message,'[TBoleto.pImprimir]');
              Exit;
            End;
          End;
        end
        else
          strArqBoletos := LeftStr(strArqBoletos, Length(strArqBoletos)-1);

        strArqBoletos := strArqBoletos.Replace(ExtractFilePath(Application.ExeName) + 'Boletos\',
                                               RetornaPastaBoletos(qryConRec.FieldByName('CTR_CODEMP').AsString,
                                                                   ABoletoCarne,ABoleto1Via));

        If (not blnAbortarEnvioEmaSmsWpp) and
           (Length(LDuplicatasSMSWppArray) > 0) and
           (qryConCli.FieldByName('CLI_CELULA').AsString <> '') and
           (fEnviaSmsOuWhatsApp(blnEnvMaiV, blnEmaAut, recDadosDigBoleto.blnEnviarSMSBoleto, recDadosDigBoleto.blnEnviarWPPBoleto)) Then
        Begin
          If (recDadosDigBoleto.blnEnviarSMSBoleto) And (blnEnviaSmsPortAut) Then
            EnviarSMSBoletos(LDuplicatasSMSWppArray, ACorpoMensagemEMASAI, False, '', True, IIF( (ABoletoCarne or ABoleto1Via), true, false));//ABoletoCarne);

          If (recDadosDigBoleto.blnEnviarWPPBoleto) And (blnEnviaWppPortAut) Then
          Begin
            IF ((Not fUtilizaBoletoCarne) And (Not fUtilizaBoleto1Via)) Or (fBancoUtilizaApenasLayoutPadrao) then
              strArqBoletosWppEma := IfThen(blnEnvioAutmaticoEmail,
                                            RetornaPastaBoletos(qryConRec.FieldByName('CTR_CODEMP').AsString,
                                                                ABoletoCarne,ABoleto1Via) + qryConRec.FieldByName('CTR_NUMDUP').AsString +
                                                                                qryConRec.FieldByName('CTR_PARCEL').AsString + '.pdf',
                                            strArqBoletos)
            else
              strArqBoletosWppEma := strArqBoletos;

            EnviarWhatsappBoletos(LDuplicatasSMSWppArray,
                                  ACorpoMensagemEMASAI,
                                  strArqBoletosWppEma,
                                  True,
                                  IIF( (ABoletoCarne or ABoleto1Via), True, False ) ); //ABoletoCarne);

          End;
        End;

        strEmailCli := '';
        If (blnEnvMaiV) Or (blnEmaAut) Then
          strEmailCli := fRetornaEmailCliente(qryConCli);

        If Assigned(LEnviaEmailCancelamentoBoleto) Then
        Begin
          If Not LEnviaEmailCancelamentoBoleto.EnviaEmailCancelamentoBoleto Then
          Begin
            fMensagem('Aviso!','Houve um problema no envio do e-mail referente ao cancelamento do boleto!',['&O k']);
          End;
          FreeAndNil(LEnviaEmailCancelamentoBoleto);
        End;

        If (not blnAbortarEnvioEmaSmsWpp) and (Not fEmptyStr(strArqBoletos)) And (blnEnvMaiV Or blnEmaAut) and (blnEnviaEmailPortAut) Then
        Begin
          If (blnEmaAut) And (Not blnEditaEmail) Then
          Begin
            pRetNumeroPedidoVenda(qryConRec.FieldByName('CTR_NUMDUP').AsString,
                                  qryConRec.FieldByName('CTR_ESPDOC').AsString,
                                  qryConRec.FieldByName('CTR_CODEMP').AsString,
                                  qryConRec.FieldByName('CTR_CODCLI').AsString,
                                  strNum_PD,
                                  strEmp_PD);

            objDadosEmail.strNumDoc         := qryConRec.FieldByName('CTR_NUMDUP').AsString;
            objDadosEmail.strCodCli         := qryConRec.FieldByName('CTR_CODCLI').AsString;
            objDadosEmail.strEspDoc         := qryConRec.FieldByName('CTR_ESPDOC').AsString;
            objDadosEmail.strCodEmp         := qryConRec.FieldByName('CTR_CODEMP').AsString;
            objDadosEmail.strNumOrc         := strNum_PD;
            objDadosEmail.strEspOrc         := IfThen(fEmptyStr(strNum_PD), '', 'PD');
            objDadosEmail.strEmpOri         := strEmp_PD;

            IF ((Not fUtilizaBoletoCarne) And (Not fUtilizaBoleto1Via)) Or (fBancoUtilizaApenasLayoutPadrao) then
              strArqBoletosWppEma := IfThen(blnEnvioAutmaticoEmail,
                                            RetornaPastaBoletos(qryConRec.FieldByName('CTR_CODEMP').AsString,
                                                                ABoletoCarne,ABoleto1Via) + qryConRec.FieldByName('CTR_NUMDUP').AsString +
                                                                                qryConRec.FieldByName('CTR_PARCEL').AsString + '.pdf',
                                            strArqBoletos)
            else
              strArqBoletosWppEma := strArqBoletos;

            SetLength(recArquivos, 0);
            arrBoletos := strArqBoletosWppEma.Split([',']);
            for strBoleto in arrBoletos do
            begin
              SetLength(recArquivos, Length(recArquivos)+1);
              recArquivos[High(recArquivos)] := TRecArquivosGatilhos.Create('BOLETO_'+ExtractFileName(strBoleto).Replace(ExtractFileExt(ExtractFileName(strBoleto)), EmptyStr)+'-'+objDadosEmail.strEspDoc,
                                                                            strBoleto,
                                                                            EmptyStr);
            end;

            objDadosEmail.RecArquivos       := recArquivos;
            objDadosEmail.strEmailCli       := strEmailCli;
            objDadosEmail.strLinhaDigitavel := IIF(fCfgSis('ANEBOL', VarBoolean), strLinDig, ACorpoMensagemEMASAI);
            objDadosEmail.strDtaEmi         := DateToStr(qryConRec.FieldByName('CTR_DTACAD').AsDateTime);
            objDadosEmail.strValDup         := FormatFloat( 'R$ #,##0.00', qryConRec.FieldByName('CTR_VALDUP').AsFloat);
            objDadosEmail.strParcel         := qryConRec.FieldByName('CTR_PARCEL').AsString;
            objDadosEmail.strDtaVen         := DateToStr(qryConRec.FieldByName('CTR_DTAVEN').AsDateTime);
            objDadosEmail.arrDupTabela      := pCarregaTabelaDupEmail( qryConRec.FieldByName('CTR_CODCLI').AsString );

            If Length(LDuplicatasSMSWppArray) = 1 Then
            Begin
              objDadosEmail.QRCodePix         := LDuplicatasSMSWppArray[0].QrCodePix;
              If Not LDuplicatasSMSWppArray[0].LinkPixCitel.IsEmpty Then
                objDadosEmail.LinkCitelPix      := LDuplicatasSMSWppArray[0].LinkPixCitel;
            End;

            if ( (blnFaturamento) And (fCampoTabela('CLI_BOLSEN', 'CADCLI', ['CLI_CODCLI'], [qryConRec.FieldByName('CTR_CODCLI').AsString], False) = 'S') And
                 (MatchStr(fCfgSis('NOVLAY', varString), ['P','C','U'])) And (MatchStr(FBcoIni, ['001','001D7','001API','756','756_240p','099','341','341API','748','748API','033','033B','237','104','104D7', '084','756API','033API'])) )
            Or
               ( (blnEnvioAutmaticoEmail) And (fCampoTabela('CLI_BOLSEN', 'CADCLI', ['CLI_CODCLI'], [qryConRec.FieldByName('CTR_CODCLI').AsString], False) = 'S')
            And (fCfgSis('NOVLAY', varString) = 'P') And (MatchStr(FBcoIni, ['001','001D7','756','099','341','748','033','033B','237','104','104D7', '084'])) )
            Or
               ( (blnEnvMaiV) And (fCampoTabela('CLI_BOLSEN', 'CADCLI', ['CLI_CODCLI'], [qryConRec.FieldByName('CTR_CODCLI').AsString], False) = 'S')
            And (MatchStr(fCfgSis('NOVLAY', varString), ['P','C','U'])) And (MatchStr(FBcoIni, ['001','001D7','001API','756','756_240p','099','341','341API','756API','748','748API','033','033B','237','104','104D7', '084','033API']))) then
            begin

               strCorpo := strCorpo + '<p>Para abrir a sua fatura é necessário digitar os 5 primeiros números do CPF ou CNPJ do titular da assinatura.</p>';
               strCorpo := strCorpo + '<p>Exemplo: CPF: 123.45.789-00 ==> digitar: 12345</p>';
               strCorpo := strCorpo + '<p>* os números do exemplo acima são fictícios.</p>';
               objDadosEmail.strCorpoAdicional := strCorpo;

            end;

            if not fDisparaEmailBoletoAutomatico(objDadosEmail,
                                                 IIF(blnEnvioAutmaticoEmail, 'AC', 'BO'),
                                                 objStatusEmailAutomatico,
                                                 blnEmaAut) then
            Begin
              fMensagem('AVISO', 'Problema ao enviar o E-mail(s) automático com o boleto. Favor tentar o reenvio via reimpressão manual de boletos.', ['&OK']);
            End;


            If blnFaturamento Then
              recDadosDigBoleto.blnEnviarSMSBoleto := blnFaturamento;
          End
          Else
          Begin
            //ENVIAR ANEXO DO BOLETO
            if not fCfgSis('ANEBOL', VarBoolean, strEmpresaImpressao) then
            Begin
              strArqBoletos := '';
            End
            Else
            Begin
              strMSBOEM := fCfgSis('MSBOEM', varString, strEmpresaImpressao);
              SetLength(ACorpoMensagem, Length(ACorpoMensagem)+1);
              ACorpoMensagem[Length(ACorpoMensagem)-1] := strMSBOEM;

              If Length(LDuplicatasSMSWppArray) = 1 Then
              Begin
                If Not LDuplicatasSMSWppArray[0].QRCodePix.IsEmpty Then
                Begin
                  SetLength(ACorpoMensagem, Length(ACorpoMensagem)+1);
                  ACorpoMensagem[Length(ACorpoMensagem)-1] := 'Pagamento por Pix:<br>' +
                                                              '<p><img src="' + RetornaLinkImagemPixCitel(LDuplicatasSMSWppArray[0].QRCodePix) + '"></p>' +
                                                              '<p>Valor: ' + FormatFloat(',0.00', qryConRec.FieldByName('CTR_VALDUP').AsFloat) + '</p>';

                  If Not LDuplicatasSMSWppArray[0].LinkPixCitel.IsEmpty Then
                    ACorpoMensagem[Length(ACorpoMensagem)-1] := ACorpoMensagem[Length(ACorpoMensagem)-1] + '<p>Link para Pix Copia e Cola: <a href="' + LDuplicatasSMSWppArray[0].LinkPixCitel + '">' + LDuplicatasSMSWppArray[0].LinkPixCitel + '</a></p>';

                  ACorpoMensagem[Length(ACorpoMensagem)-1] := ACorpoMensagem[Length(ACorpoMensagem)-1] +  '<p>Para pagamento através do código (Pix Copia e Cola):<br>' +
                                                                                                          '<textarea readonly style="text-decoration: underline; resize: none;" rows="4" cols="' + Trunc((LDuplicatasSMSWppArray[0].QRCodePix.Length + 3) / 3).ToString + '">' + LDuplicatasSMSWppArray[0].QRCodePix + '</textarea></p>';
                End;
              End;

              if (blnEnvMaiV) And (fCampoTabela('CLI_BOLSEN', 'CADCLI', ['CLI_CODCLI'], [qryConRec.FieldByName('CTR_CODCLI').AsString], False) = 'S')
              And (MatchStr(fCfgSis('NOVLAY', varString), ['P','C','U'])) And (MatchStr(FBcoIni, ['001','001D7','001API','756','756_240p','099','341','341API','748','748API','033','033B','237','104','104D7', '084','756API','033API'])) then
              begin

                 SetLength(AMensagemBolSen, Length(AMensagemBolSen)+1);

                 AMensagemBolSen[Length(AMensagemBolSen)-1] := '<p>Para abrir a sua fatura é necessário digitar os 5 primeiros números do CPF ou CNPJ do titular da assinatura.</p>'+
                                                               '<p>Exemplo: CPF: 123.45.789-00 ==> digitar: 12345</p>'+
                                                               '<p>* os números do exemplo acima são fictícios.</p>';

                 blnMsgBolSen := True;
              end;

            End;

            pCriarArrayAnexosEDestinatarios(strArqBoletos, strEmailCli, arrDestinatarios, arrArquivos);

            LCodigoGrupoModelo := EmptyStr;
            LCodigoModelo := EmptyStr;

            If blnMsgBolSen Then
               ACorpoMensagem := ACorpoMensagem + AMensagemBolSen;

            If (blnUsarLayoutEmaSai Or blnEmaAut) Then
            Begin
              pCarregaDadosEmail;
              pGetMensagemEMASAI(ACorpoMensagem,
                                 FAssunto,
                                 objDadosEmail,
                                 IIF(blnEnvioAutmaticoEmail, 'AC', 'BO'),
                                 objStatusEmailAutomatico,
                                 LDadosLoginEmail,
                                 LCodigoGrupoModelo,
                                 LCodigoModelo);
            End;

            Try

              blnEmailEnviado := TEnvioEmail.EnviarEmailSemMensagemConfirmacao(Self,
                                                                               strLoginUsuarioLogado,
                                                                               FAssunto,
                                                                               arrDestinatarios,
                                                                               [],
                                                                               [],
                                                                               ACorpoMensagem,
                                                                               arrArquivos,
                                                                               blnEditaEmail,
                                                                               thrSincEmail,
                                                                               True,
                                                                               False,
                                                                               '',
                                                                               '',
                                                                               0,
                                                                               False,
                                                                               LDadosLoginEmail.Senha,
                                                                               LDadosLoginEmail.Email,
                                                                               LDadosLoginEmail.Login,
                                                                               LDadosLoginEmail.Remetente,
                                                                               LDadosLoginEmail.Provedor,
                                                                               LDadosLoginEmail.PortaSMTP,
                                                                               LDadosLoginEmail.PortaImap,
                                                                               LDadosLoginEmail.ServidorSMTP,
                                                                               LDadosLoginEmail.ServidorImap,
                                                                               LDadosLoginEmail.LimiteArquivos,
                                                                               LDadosLoginEmail.ImagemAssinatura,
                                                                               LDadosLoginEmail.TextoAssinatura,
                                                                               LDadosLoginEmail.ImagemAssinaturaStream,
                                                                               '',
                                                                               '',
                                                                               LDadosLoginEmail.AutenticacaoSSL,
                                                                               LDadosLoginEmail.AutenticacaoSSLImap,
                                                                               LDadosLoginEmail.GravaPastaEnviados,
                                                                               pCarregaTabelaDupEmail(qryConRec.FieldByName('CTR_CODCLI').AsString ),
                                                                               LCodigoGrupoModelo,
                                                                               LCodigoModelo,
                                                                               qryConRec.FieldByName('CTR_CODCLI').AsString,
                                                                               LDadosLoginEmail.TipoProvedor);


              If Assigned(LDadosLoginEmail.ImagemAssinaturaStream) Then
                FreeAndNil(LDadosLoginEmail.ImagemAssinaturaStream);

            Except
              On E:Exception Do
                fMensagem('AVISO', 'Erro no envio de e-mail: ' + E.Message, ['&OK'], 0);
            End;

            If blnEmailEnviado And (intContCli = stlClientes.Count - 1) Then
              fMensagem('AVISO', 'E-mail(s) enviado(s) com sucesso.', ['&OK'], 0);
          End;
        End;

        //Grava boletos por empresa
        If (fCfgSis('GRVBOL') = '2') And ((ABoletoCarne) or (ABoleto1Via)) Then
        Begin

           GravarPDFPorEmpresaBoletosCarne(arrCtrDup,
                                           ExtractFilePath(Application.ExeName) + 'Boletos\');

           For iArr := 0 To Length(arrCtrDup) - 1 Do
               stlBoletosRealocados.Add( arrCtrDup[iArr].strNumDup + '.pdf' );

        End;

      End;

    Finally
      If Assigned(LBancoInter) Then
        FreeAndNil(LBancoInter);

      If Assigned(LBancoDoBrasilApi) Then
        FreeAndNil(LBancoDoBrasilApi);

      If Assigned(LBancoCredisisAPI) Then
        FreeAndNil(LBancoCredisisAPI);

      If Assigned(LBancoSicrediAPI) Then
        FreeAndNil(LBancoSicrediAPI);

      If Assigned(LEnviaEmailCancelamentoBoleto) Then
        FreeAndNil(LEnviaEmailCancelamentoBoleto);

      If Assigned(LBancoItauAPI) Then
        FreeAndNil(LBancoItauAPI);

      If Assigned(LBancoSicoobAPI) Then
        FreeAndNil(LBancoSicoobAPI);

      If Assigned(LBancoSantanderAPI) Then
        FreeAndNil(LBancoSantanderAPI);

      If Assigned(LBancoBradescoAPI) Then
        FreeAndNil(LBancoBradescoAPI);

      If Assigned(LRetornoRegistroBoletoApi) Then
        LRetornoRegistroBoletoApi := Nil;
    End;

    pBackupCnfBco;

    If blnConfirma Then
    Begin
       //Grava boletos por empresa
       If (fCfgSis('GRVBOL') = '2') And (stlBoletosRealocados <> Nil) Then
          RemovePDFRealocadosPorEmpresa(stlBoletosRealocados);
    End;

    If blnConfirma And blnBolPdfV And (Not blnEmaAut) Then
    Begin

      If fCfgSis('GRVBOL') = '2' Then
         pMensagemOk('Boleto(s) gerado(s) na(s) pasta(s) referentes a empresa do boleto.')
      Else
         pMensagemOk('Boleto(s) gerado(s) na pasta: ' + ExtractFilePath(Application.ExeName) + 'Boletos');

    End;

    If (Assigned(stlBoletosRealocados)) Then
        FreeAndNil(stlBoletosRealocados);

  End;

  FBlnImp := blnConfirma;

  if not blnConfirma then
  begin
    If ((fCfgSis('NOTPFF', varBoolean) And fCfgSis('NPFFAU', varBoolean)) And
        (Not blnJaGerouNP)) And (Not blnPreview) And (arrCtrDup[0].strEspDoc = 'FF') Then
    begin
      strTipBol := 'J';
      if fEmptyStr(strNomImp) then
      begin
        TCfgRel.fExecutePrintDialog(strNomImp);
        if fEmptyStr(strNomImp) then
            strNomImp := TCfgRel.fGetImpressoraSelecionada;
      end;
      if not fEmptyStr(strNomImp) then
        pImprimePromissorias(arrCtrDup, strTipBol, strNomFrm, strNomImp);
    end;
  end;

  //Inicia thread que vai salvar os arquivos dos email's enviados na pasta
  //EmailTemp, e vai sincronizar a pasta enviados no servidor caso use IMAP
  //Essa rotina foi isolada para melhorar o desempenho da mesma
  //que estava muito lenta - KP.110123
  if (blnEmailEnviado) and (Assigned(thrSincEmail)) then
  Begin
    if thrSincEmail.QuantidadeEmails > 0 then
    begin
      thrSincEmail.Start;

      TListaThreadsSincronizaEmails.GetInstance.pAdicionar(thrSincEmail);
    end;
  End;

  If (Assigned(stlClientes)) Then
    FreeAndNil(stlClientes);

end;

function TBoleto.fEnviaSmsOuWhatsApp(const blnEnvMaiV, blnEmaAut, blnEnviarSMSBoleto, blnEnviarWPPBoleto: Boolean): Boolean;
begin
  Result := False;

  if blnEmaAut then
    Exit(True);

  if (blnFaturamento) and (blnEnvMaiV) then
    Exit(True);

  if (not blnFaturamento) and ((blnEnviarSMSBoleto) or (blnEnviarWPPBoleto)) then
    Exit(True);
end;

function TBoleto.fUtilizaBoletoCarne: Boolean;
begin
  Result := (fCfgSis('NOVLAY') = 'C');
end;

function TBoleto.fUtilizaBoleto1Via: Boolean;
begin
  Result := (fCfgSis('NOVLAY') = 'U');
end;

function TBoleto.fBancoUtilizaApenasLayoutPadrao: Boolean;
begin
  Result := MatchStr(FBcoIni, ['077','748API','341API','756API','021','033API']);
end;

procedure TBoleto.pImprimePromissorias(ArrDupCtr: TArrDupCtr; strTipBol, strNomFrm, strNomImp: String);
  Var
    qryCadRec: TUniQuery;
begin

  Try
    qryCadRec := fCriaQuery(Self);
    Try
      TImpNotaPromissoria.pImprimeNotaPromissoria(ArrDupCtr, strNomFrm, strNomImp, qryCadRec, FValMor, strTipBol);
    Finally
      FreeAndNil(qryCadRec);
    End;
  Except
    On E: Exception Do
    Begin
      FreeAndNil(qryCadRec);
      Raise Exception.Create(E.Message);
    End;
  End;

End;

procedure TBoleto.pUpdateCadRec(ctrDup: TDupCtr);
  Var
    qryUpdateCtr: TUniQuery;
begin

  Try
    qryUpdateCtr := fCriaQuery(Self);

    With qryUpdateCtr Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' UPDATE ' + strNomeTabela);
      SQL.Add('    SET CTR_CODPOR = ' + QuotedStr(FCodPor));
      SQL.Add('  WHERE CTR_NUMDUP = ' + QuotedStr(ctrDup.strNumDup));
      SQL.Add('    AND CTR_PARCEL = ' + QuotedStr(ctrDup.strParcel));
      SQL.Add('    AND CTR_CODCLI = ' + QuotedStr(ctrDup.strCodCli));
      SQL.Add('    AND CTR_CODEMP = ' + QuotedStr(ctrDup.strCodEmp));
      SQL.Add('    AND CTR_ESPDOC = ' + QuotedStr(ctrDup.strEspDoc));
      ExecSQL;
    End;

    FreeAndNil(qryUpdateCtr);
  Except
    On E: Exception Do
    Begin
      FreeAndNil(qryUpdateCtr);
      Raise Exception.Create('Erro ao Atualizar Portador e Banco do Boleto da Duplicata a ser Reimpressa - [pUpdateCadRec] !' + #13#10 + E.Message);
    End;
  End;

end;

function TBoleto.RetornaPastaBoletos(ACodigoEmpresaDuplicata: String;
  ABoletoCarne: Boolean; ABoleto1Via: Boolean): String;
begin
  Result := ExtractFilePath(Application.ExeName) + 'Boletos\';

  If (ABoletoCarne or ABoleto1Via) THen
    Exit;

  If fCfgSis('GRVBOL', varString) = '2' Then
    Result := ExtractFilePath(Application.ExeName) + 'Boletos_' + ACodigoEmpresaDuplicata + '\';
end;

function TBoleto.RetornaSelectLinkDoBoleto: String;
  Var
    LConfBoleto: String;
begin
  LConfBoleto := fCfgSis('LNKBOL');

  If LConfBoleto.IsEmpty Then
    Exit('"" AS LINK_DO_BOLETO');

  Result := 'CONCAT("' + LConfBoleto + '", ' +
            'TO_BASE64(              ' +
            'CONCAT(                 ' +
            '       CTR_NUMDUP, "|", ' +
            '       CTR_ESPDOC, "|", ' +
            '       CTR_PARCEL, "|", ' +
            '       CTR_CODEMP, "|", ' +
            '       CTR_CODCLI, "|", ' +
            'UPPER(                  ' +
            '      MD5(              ' +
            '          CONCAT(       ' +
            '       CTR_NUMDUP, "|", ' +
            '       CTR_ESPDOC, "|", ' +
            '       CTR_PARCEL, "|", ' +
            '       CTR_CODEMP, "|", ' +
            '       CTR_CODCLI, "|", ' +
            ' "CITEL_BOLETO_@_13347" ' +
            ' ) ) ) )  ) )           ' +
            ' AS LINK_DO_BOLETO      ';
end;

function TBoleto.ValidaImpressaoBoleto: Boolean;
  Var
    LValorMora : Double;
begin
  Result := True;
  If (FValMor > 0) Then
  Begin
    LValorMora := fFormataFloat(qryConRec.FieldByName('CTR_VALDUP').AsFloat * (FValMor/100), 2);
    If (LValorMora <= 0) Then
    Begin
      Raise Exception.Create('BCOAPI-Não será possível registrar o boleto pois o valor de mora está abaixo do permitido!');
    End;
  End;
end;

function TBoleto.fSelectNossoNumeroAnterior(ctrDup: TDupCtr): String;
  Var
    qrySelectCtr: TUniQuery;
begin

  Result := '';

  Try
    qrySelectCtr := fCriaQuery(Self);

    With qrySelectCtr Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT CTR_NOSNUM ');
      SQL.Add('   FROM '+ strNomeTabela);
      SQL.Add('  WHERE CTR_NUMDUP = ' + QuotedStr(ctrDup.strNumDup));
      SQL.Add('    AND CTR_PARCEL = ' + QuotedStr(ctrDup.strParcel));
      SQL.Add('    AND CTR_ESPDOC = ' + QuotedStr(ctrDup.strEspDoc));
      SQL.Add('    AND CTR_CODEMP = ' + QuotedStr(ctrDup.strCodEmp));
      SQL.Add('    AND CTR_CODCLI = ' + QuotedStr(ctrDup.strCodCli));
      SQL.Add('    AND CTR_SEQBAI = 0 ');
      Open;

      Result := FieldByName('CTR_NOSNUM').AsString;
    End;

  Finally
    FreeAndNil(qrySelectCtr);
  End;

end;

function TBoleto.fVerificaWhatsappAutomatico(objDuplicata: TDuplicataCtr): Boolean;
  Var
    objWhatsappAut: TSMSAut;
begin
  Try
    objWhatsappAut := TSMSAut.Create(Nil);
    objWhatsappAut.FWhatsapp := True;

    If objDuplicata.blnAvisoAutomaticoEmail Then
    Begin
      objWhatsappAut.FOpcDoc := 'AC';
      objWhatsappAut.FCodGru := objDuplicata.strCodigoGrupo;
      objWhatsappAut.FCodigo := objDuplicata.strCodigoEmail;
    End
    Else
      objWhatsappAut.FOpcDoc := 'BO';

    Result := objWhatsappAut.fTemModeloAtivo;
  Finally
    FreeAndNil(objWhatsappAut);
  End;

end;

function TBoleto.fVerificaEmailAutmatico(objDuplicata: TDuplicataCtr): Boolean;
  Var
    objEmaAut: TEmaAut;
begin
  Try
    objEmaAut := TEmaAut.Create(Nil);
    If objDuplicata.blnAvisoAutomaticoEmail Then
    Begin
      objEmaAut.FOpcDoc := 'AC';
      objEmaAut.FCodGru := objDuplicata.strCodigoGrupo;
      objEmaAut.FCodigo := objDuplicata.strCodigoEmail;
    End
    Else
      objEmaAut.FOpcDoc := 'BO';

    Result := objEmaAut.fTemEmailAtivo;
  Finally
    FreeAndNil(objEmaAut);
  End;
end;

class function TBoleto.fChaveLockImpressaoBoletos: String;
begin
  Result := 'BOLETO_IMPRESSAO_' + fRetEmpresaFisica;
end;

procedure TBoleto.pTravarImpressaoBoletosBancoDoBrasilAPI;
  Const
    MILISSEGUNDOS_MAXIMO_TRAVA = 120000;
  Var
    LTrava,
    LTravaObservada,
    LConIdDono,
    LChaveCompleta: String;
    LTempoObservado: TStopwatch;
   {$IFNDEF LINUX}
    LParametros: array of String;
    LGravando  : IObserver_;
    LSubject   : ISubject_;
   {$ENDIF}
begin
  // Mesma espera do Lock_Unlock (nova tentativa a cada 3 segundos). Autcom encerrado ou com a conexao
  // caida no meio do registro no BB deixava a trava sem dono, e todas as estacoes ficavam paradas ate a
  // liberacao manual no Relatorio de Travas (Req. 466847). A trava so e liberada aqui quando as duas
  // condicoes valem:
  // - a mesma trava ha mais de 2 minutos, pelo cronometro desta estacao. Nao pela hora gravada nela:
  //   LCK_HRALCK vem do relogio de quem travou (fTime) e LCK_DTALCK e a data do login (VS_Date);
  // - a conexao dona nao existe mais no servidor. Sessao viva esperando o BB, mesmo passando de
  //   2 minutos, segura a trava: liberar deixaria outra estacao passar pelo BoletoJaImpresso antes do
  //   commit dela e registrar a mesma duplicata de novo no BB.
  LTravaObservada := '';
  While Not fLock_Unlock(fChaveLockImpressaoBoletos, True, False, True) Do
  Begin
    LTrava := fTravaImpressaoBoletosAtual(LConIdDono, LChaveCompleta);

    If LTrava <> LTravaObservada Then
    Begin
      LTravaObservada := LTrava;
      LTempoObservado := TStopwatch.StartNew;
    End
    Else If (Not LTrava.IsEmpty) And
            (LTempoObservado.ElapsedMilliseconds > MILISSEGUNDOS_MAXIMO_TRAVA) And
            fConexaoDaTravaEncerrada(LConIdDono) Then
    Begin
      fLock_Unlock(fChaveLockImpressaoBoletos, False, False, False, LConIdDono);
      Continue;
    End;

   {$IFNDEF LINUX}
    If (Not Assigned(LSubject)) And (Not LChaveCompleta.IsEmpty) Then
    Begin
      LGravando := TGravandoObs.Create;
      LSubject  := TSubject.Create;
      LSubject.pAddObserver(LGravando);

      SetLength(LParametros, 4);
      LParametros[2] := 'O arquivo ' + LChaveCompleta + ' está sendo utilizado no momento.' + #13#10 + 'Aguarde Liberação!';
      LSubject.pNotify(LParametros, False);
    End;
   {$ENDIF}

    Sleep(3000);
    Application.ProcessMessages;
  End;
end;

function TBoleto.fTravaImpressaoBoletosAtual(out AConIdDono, AChaveCompleta: String): String;
  Var
    LLckatc: TUniQuery;
begin
  // Identifica a linha da trava: dono e data/hora gravados. A proxima duplicata da mesma estacao,
  // ou outra estacao, grava outra linha e recomeca a contagem dos 2 minutos.
  Result         := '';
  AConIdDono     := '';
  AChaveCompleta := '';

  LLckatc := fCriaQuery(Nil);
  Try
    LLckatc.SQL.Text := 'SELECT LCK_CHAACE, LCK_CON_ID, LCK_DTALCK, LCK_HRALCK ' +
                        '  FROM LCKATC ' +
                        ' WHERE LCK_CHAACE = CONCAT(DATABASE(), ".", :CHAVE)';
    LLckatc.ParamByName('CHAVE').AsString := fChaveLockImpressaoBoletos;
    LLckatc.Open;

    If LLckatc.IsEmpty Then
      Exit;

    AChaveCompleta := LLckatc.FieldByName('LCK_CHAACE').AsString;
    AConIdDono     := LLckatc.FieldByName('LCK_CON_ID').AsString;
    Result         := AConIdDono + '|' +
                      LLckatc.FieldByName('LCK_DTALCK').AsString + '|' +
                      LLckatc.FieldByName('LCK_HRALCK').AsString;
  Finally
    FreeAndNil(LLckatc);
  End;
end;

function TBoleto.fConexaoDaTravaEncerrada(const AConIdDono: String): Boolean;
  Var
    LQuery: TUniQuery;
begin
  // Sem o privilegio PROCESS o PROCESSLIST so mostra as conexoes do proprio usuario do banco, e a
  // conexao viva de outro usuario pareceria encerrada: sem ele, nunca considera encerrada.
  Result := False;

  If AConIdDono.IsEmpty Then
    Exit;

  LQuery := fCriaQuery(Nil);
  Try
    LQuery.SQL.Text := 'SELECT ' +
                       '  (SELECT COUNT(0) FROM INFORMATION_SCHEMA.PROCESSLIST P ' +
                       '    WHERE P.ID = :CON_ID) AS CONEXAO_ATIVA, ' +
                       '  (SELECT COUNT(0) FROM INFORMATION_SCHEMA.USER_PRIVILEGES U ' +
                       '    WHERE U.PRIVILEGE_TYPE = "PROCESS" ' +
                       '      AND U.GRANTEE = CONCAT("''", REPLACE(CURRENT_USER(), "@", "''@''"), "''")) AS VE_TODAS_CONEXOES';
    LQuery.ParamByName('CON_ID').AsString := AConIdDono;
    LQuery.Open;

    Result := (LQuery.FieldByName('CONEXAO_ATIVA').AsInteger = 0) And
              (LQuery.FieldByName('VE_TODAS_CONEXOES').AsInteger > 0);
  Finally
    FreeAndNil(LQuery);
  End;
end;

function TBoleto.fCodPorEstaOuSeraPreenchido(frmDigBoletoFaturamento: TfrmDigBoletoFaturamento): Boolean;
begin
  Result := False;

  if not fEmptyStr(frmDigBoletoFaturamento.edtCodPor.Text) then
    Exit(True);

  if (fEmptyStr(frmDigBoletoFaturamento.strBancoAnterior)) and
     (not fEmptyStr(fCfgSis('PORBOL', varString, frmDigBoletoFaturamento.strEmpresaImpressao))) and
     (fCfgSis('IMPBOL') = 'A') then
    Exit(True);
end;

function TBoleto.fDigBoletoFaturamento(recDados: TDadosTelaDigBoleto; cdsAuxBol : TUniClientDataSet): TDadosTelaDigBoleto;
  Var
    frmDigBoletoFaturamento: TfrmDigBoletoFaturamento;
    intCodCarMlt : Integer;
begin
  {********************************************************
  * PARA EXECUTAR O PROCESSO DA frmDigBoletoFaturamento   *
  * VAMOS UTILIZAR O BANCO DO PRIMEIRO PERIODO ENCONTRADO *
  * POSTERIOMENTE ANALISAMOS DUPLICATA POR DUPLICATA      *
  *************************************MT*****REQ:183368***}

  If Not Assigned(FMultiplosBancos) Then
  Begin
    FMultiplosBancos := TMultiplosBancos.Create(FCodCnd,
                                                FCodFpg,
                                                recDados.strCodCli,
                                                recDados.strEspDoc);

    FUtilizaMultiplosBancos := Not FNotaPromissoria And // Não pode ser impressão de nota promissoria
                              (Assigned(FMultiplosBancos) And // tem que ter construido o objeto
                               FMultiplosBancos.FCarregarDadosMultiplosBancos)And // tem que estar configurado para imprimir multiplos bancos
                              (((fCfgSis('IMPBOL') = 'A') Or (recDados.blnEmaAut)) And recDados.blnFaturamento);// Tem que ser uma impressão automatica (sem perguntar)

    If FUtilizaMultiplosBancos  Then
    Begin
      cdsAuxBol.First;
      While Not cdsAuxBol.Eof  Do
      Begin
        FMultiplosBancos.pCarregaDadosMultiplosBancos(recDados.strCodbco,
                                                      recDados.strCodPor,
                                                      recDados.strRetBco,
                                                      intCodCarMlt,
                                                      cdsAuxBol.FieldByName('CTR_DTACAD').AsDateTime,
                                                      cdsAuxBol.FieldByName('CTR_DTAVEN').AsDateTime);

        If FMultiplosBancos.fValidaPortadorMultiplosBancos(recDados.strCodPor) And
           FMultiplosBancos.fValidaBancoMultiplosBancos(recDados.strCodbco) Then
        Begin
          Break;
        End;

        cdsAuxBol.Next;
      End;
    End;
  End;

  pCriarFormularios(TfrmDigBoletoFaturamento, frmDigBoletoFaturamento);
  frmDigBoletoFaturamento.recDados := recDados;
  frmDigBoletoFaturamento.FUtilizaMultiplosBancos := FUtilizaMultiplosBancos;
  frmDigBoletoFaturamento.pCarregaDadosTela;

  If (((fCfgSis('IMPBOL') = 'A') Or (recDados.blnEmaAut)) And recDados.blnFaturamento And
     (fCodPorEstaOuSeraPreenchido(frmDigBoletoFaturamento))) Or
     ((recDados.blnExpediMult) And (recDados.blnFaturamento)) Or
     ((recDados.blnFaturadorAutomatico) And (recDados.blnFaturamento)) Then
  Begin
    frmDigBoletoFaturamento.pOnShow;//Carregar o portador e o banco
    frmDigBoletoFaturamento.edtCodBcoExit(frmDigBoletoFaturamento.edtCodBco);//Carrega o nosso numero

    frmDigBoletoFaturamento.btnConfirmaDados.Click;//valida todos os campos

    If Not frmDigBoletoFaturamento.blnConfirma Then
    Begin
      If Not recDados.blnFaturadorAutomatico Then
        frmDigBoletoFaturamento.showModal;
    End
    Else
      FImprimiuSemPerguntar := True;
  End
  Else If recDados.blnEnvioAutmaticoEmail Or (recDados.blnEmissaoAutomatica And recDados.blnReimp And recDados.blnPreview) Then
  Begin
    frmDigBoletoFaturamento.edtCodBco.Text := recDados.strBancoAnterior; //É necessário, para atualizar o código do banco sem portador vinculado

    frmDigBoletoFaturamento.pOnShow;
    frmDigBoletoFaturamento.edtCodBcoExit(frmDigBoletoFaturamento.edtCodBco);

    frmDigBoletoFaturamento.btnConfirmaDados.Click;
    FImprimiuSemPerguntar := True;
  End
  Else
    frmDigBoletoFaturamento.showModal;

  Result := frmDigBoletoFaturamento.recDados;

  FreeAndNil(frmDigBoletoFaturamento);
end;

function TBoleto.fDigBoletoFinanceiro(recDados: TDadosTelaDigBoleto; arrCtrDup: TArrDupCtr): TDadosTelaDigBoleto;
  Var
    frmDigBoleto: TfrmDigBoleto;
begin
  pCriarFormularios(TfrmDigBoleto, frmDigBoleto);
  frmDigBoleto.recDados := recDados;
  frmDigBoleto.arrDupCtr := arrCtrDup;
  frmDigBoleto.blnEhBoletoMeiaNota := blnEhBoletoMeiaNota;
  frmDigBoleto.pCarregaDadosTela;

  If recDados.blnEnvioAutmaticoEmail Or (recDados.blnEmissaoAutomatica And recDados.blnReimp And recDados.blnPreview) Or (blnEhBoletoMeiaNota) Then
  Begin
    frmDigBoleto.edtCodBco.Text := recDados.strBancoAnterior; //É necessário, para atualizar o código do banco sem portador vinculado

    frmDigBoleto.pOnShow;
    frmDigBoleto.edtCodBcoExit(frmDigBoleto.edtCodBco);

    frmDigBoleto.btnConfirmaDados.Click;
    FImprimiuSemPerguntar := True;
  End
  Else
  begin
    frmDigBoleto.blnMostrarCreditosDoCliente := True;
    frmDigBoleto.showModal;
  end;

  Result := frmDigBoleto.recDados;

  FreeAndNil(frmDigBoleto);
end;

function TBoleto.RetornaLinkPixCitelValido(const ADuplicata: TDataSet): String;
  Var
    LCarteira: String;

    LDiasValidade: Integer;
begin
  Result := ADuplicata.FieldByName('CTR_LNKCIT').AsString;

  LCarteira := ADuplicata.FieldByName('CTR_CARTEI').AsString;

  If Result.IsEmpty Or (Copy(LCarteira, 1, 13) <> 'CONFIG756API-') Then
    Exit;

  LDiasValidade := StrToIntDef(fGetBancoConfig(0,
                                               Copy(LCarteira, 1, 14),
                                               'DIALIMR',
                                               '0',
                                               Copy(LCarteira, Length(LCarteira) - 2, 3)), 0);

  If Trunc(fRetDtaHraServidor) > Trunc(ADuplicata.FieldByName('CTR_DTAVEN').AsDateTime) + LDiasValidade Then
    Result := EmptyStr;
end;

class function TBoleto.fEnviarEmailBoletoAutomatico(
  objArrDupCtr: TArrDupCtr; objStatusBoleto: TStatusDisparaEmail;
  out AEnviouEmail: Boolean; out AEnviouSMS: Boolean; out AEnviouWPP: Boolean): Boolean;
  Var
    objBoleto   : TBoleto;
    blnEmaAut   : Boolean;
    qryGenCtr   : TUniQuery;
    cdsBoleto   : TUniClientDataSet;
    intConta_   : Integer;
    strAutInc   : String;
Begin
  Result := False;

  If Length(objArrDupCtr) <= 0 Then
    Exit;

  qryGenCtr := fCriaQuery;

  Try
    strAutInc := '';

    For intConta_ := 0 To Length(objArrDupCtr)-1 Do
      strAutInc := strAutInc + objArrDupCtr[intConta_].strAutoIn + '", "';

    strAutInc := '"'+ strAutInc;
    strAutInc := Copy(strAutInc, 1, Length(strAutInc)-3);

    qryGenCtr.Close;
    qryGenCtr.SQL.Clear;
    qryGenCtr.SQL.Text := fGetSQLBoletos(objArrDupCtr[0].blnAvisoAutomaticoEmail);
    qryGenCtr.SQL.Text := StringReplace(qryGenCtr.SQL.Text, 'AUTINC', strAutInc, []);
    qryGenCtr.Open;

    objBoleto := TBoleto.Create(Nil, 'CADREC', False);
    cdsBoleto := fCriaClientDatset(qryGenCtr);

    blnEmaAut := objBoleto.fVerificaEmailAutmatico(objArrDupCtr[0]);
    if not blnEmaAut then
      blnEmaAut := objBoleto.fVerificaWhatsappAutomatico(objArrDupCtr[0]);

    objBoleto.objStatusEmailAutomatico := objStatusBoleto;

    If blnEmaAut Then
    Begin
      Application.ProcessMessages;
      objBoleto.pImprimir(cdsBoleto,
                          objArrDupCtr,
                          cdsBoleto.FieldByName('CTR_BCOBOL').AsString,
                          True,
                          True,
                          blnEmaAut,
                          objArrDupCtr[0].blnAvisoAutomaticoEmail,
                          False,
                          cdsBoleto.FieldByName('CTR_CARTEI').AsString,
                          '',
                          '',
                          '',
                          '',
                          '',
                          True);
    End;

    Result := blnEmaAut;
  Except
    On e: Exception Do
      pMensagensErro(E.Message, '[untFuncoes.fImprimirBoletos]');
  End;

  If Assigned(cdsBoleto) Then
    FreeAndNil(cdsBoleto);

  If Assigned(objBoleto) Then
    FreeAndNil(objBoleto);

  FreeAndNil(qryGenCtr);
end;

class function TBoleto.fGetProvedorEnvioEmailAutomatico(objDuplicata: TDuplicataCtr): String;
begin
  If objDuplicata.blnAvisoAutomaticoEmail Then
    Result := TEmaAut.fGetProvedor('AC', objDuplicata.strCodigoGrupo, objDuplicata.strCodigoEmail)
  Else
    Result := TEmaAut.fGetProvedor('BO', '', '');
end;

class function TBoleto.fGetSQLBoletos(blnReimpressaoBoleto: Boolean = False): String;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  R.AUTOINCREM, ';
  strSQL := strSQL + '  R.CTR_NUMDUP AS NRODUP, ';
  strSQL := strSQL + '  R.CTR_PARCEL AS PARDUP, ';
  strSQL := strSQL + '  CONCAT(R.CTR_NUMDUP, R.CTR_PARCEL) AS CTR_NUMDUP, ';
  strSQL := strSQL + '  R.CTR_CODEMP, ';
  strSQL := strSQL + '  R.CTR_ESPDOC, ';
  strSQL := strSQL + '  R.CTR_DTAVEN, ';
  strSQL := strSQL + '  R.CTR_DTACAD, ';
  strSQL := strSQL + '  IF((R.CTR_NOSNUM IS NOT NULL) OR ' +
                     '     (R.CTR_DTAENV IS NOT NULL) OR ' +
                     '     (R.CTR_BCOBOL = "999" AND R.CTR_DTABOL IS NOT NULL), "Sim", "Não") ' +
                     '  AS CTR_BOLETO, ';
  strSQL := strSQL + '  R.CTR_VALDUP, ';
  strSQL := strSQL + '  R.CTR_DESSUJ, ';
  strSQL := strSQL + '  R.CTR_JURSUJ, ';
  strSQL := strSQL + '  R.CTR_DESCOB, ';
  strSQL := strSQL + '  0.0000 AS CTR_VALCOR, ';
  strSQL := strSQL + '  R.CTR_CODCLI, ';
  strSQL := strSQL + '  CLI_NOMCLI, ';
  strSQL := strSQL + '  CLI_EMAIL_, ';
  strSQL := strSQL + '  R.CTR_CODPOR, ';
  strSQL := strSQL + '  POR_NOMPOR, ';
  strSQL := strSQL + '  R.CTR_NOSNUM, ';
  strSQL := strSQL + '  R.CTR_HIST01, ';
  strSQL := strSQL + '  R.CTR_HIST02, ';
  strSQL := strSQL + '  R.CTR_OBSAG1, ';
  strSQL := strSQL + '  R.CTR_OBSAG2, ';
  strSQL := strSQL + '  R.CTR_OBSAG3, ';
  strSQL := strSQL + '  R.CTR_PERDPO, ';
  strSQL := strSQL + '  R.CTR_QTDDAV, ';
  strSQL := strSQL + '  R.CTR_CARTEI, ';
  strSQL := strSQL + '  R.CTR_PERMOR, ';
  strSQL := strSQL + '  R.CTR_PERMUL, ';
  strSQL := strSQL + '  R.CTR_DTAENV, ';
  strSQL := strSQL + '  R.CTR_DTABOL, ';
  strSQL := strSQL + '  R.CTR_SEQBAI, ';
  strSQL := strSQL + '  R.CTR_PARCEL, ';
  strSQL := strSQL + '  R.CTR_LINDIG, ';
  strSQL := strSQL + '  R.CTR_VALORI, ';
  strSQL := strSQL + '  IFNULL(R.CTR_BCOBOL, "") AS CTR_BCOBOL, ';
  strSQL := strSQL + '  IF(R.CTR_NOSNUM IS NOT NULL OR R.CTR_DTAENV IS NOT NULL, CONCAT(R.CTR_BCOBOL, "-", R.CTR_CARTEI), R.CTR_BCOBOL) AS CTR_CHAVE, ';
  strSQL := strSQL + '  CLI_C_G_C_, ';
  strSQL := strSQL + '  "M" AS CTR_MARDES, ';
  strSQL := strSQL + '  "N" AS CTR_VNCALT, ';
  strSQL := strSQL + '  R.CTR_JURSUJ AS CTR_JSJBKP, ';
  strSQL := strSQL + '  R.CTR_DTAVEN AS CTR_DTVBKP, ';
  strSQL := strSQL + '  "" AS NUMPED, ';
  strSQL := strSQL + '  R.CTR_OBSV01 AS CTR_OBSV01, ';
  strSQL := strSQL + '  R.CTR_OBSV02 AS CTR_OBSV02  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADREC R ';
  strSQL := strSQL + '  JOIN CADCLI      ON R.CTR_CODCLI = CLI_CODCLI ';
  strSQL := strSQL + '  LEFT JOIN CADPOR ON R.CTR_CODPOR = POR_CODPOR ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  R.CTR_DTAREC IS NULL   AND ';
  strSQL := strSQL + '  R.CTR_VALDUP > 0       AND ';
  strSQL := strSQL + '  R.AUTOINCREM IN (AUTINC) AND ';

  If blnReimpressaoBoleto Then
    strSQL := strSQL + '  (R.CTR_NOSNUM IS NOT NULL AND (R.CTR_BCOBOL IS NOT NULL AND R.CTR_BCOBOL NOT IN ("", "999"))) '
  Else
    strSQL := strSQL + '  (R.CTR_NOSNUM IS NULL  AND R.CTR_DTAENV IS NULL AND COALESCE(R.CTR_BCOBOL, "") <> "999") ';

  Result := strSQL;
end;

class function TBoleto.fImprimirBoletos(objArrDupCtr: TArrDupCtr;
  blnFaturamento, blnPergunta: Boolean; strTextoPergunta, strNomeForm,
  strNomImpBol, strWhereBol: String; blnTelaDeCadastro: Boolean; blnPerguntaDefSim: Boolean ): Boolean;
Var
  objBoleto: TBoleto;
  blnEmaAut,
  blnImpBoleto: Boolean;
  qryGenCtr: TUniQuery;
  cdsBoleto: TUniClientDataSet;
  intConta_: Integer;
  strAutInc: String;
Begin
  Result       := False;
  blnImpBoleto := False;

  If Length(objArrDupCtr) > 0 Then
  Begin
    If Not blnImpBoleto Then
      blnImpBoleto := fPergunta(IIF(fEmptyStr(strTextoPergunta), 'Deseja gerar boletos?', strTextoPergunta), blnPerguntaDefSim);

    If blnImpBoleto Then
    Begin
      qryGenCtr := fCriaQuery;

      Try
        strAutInc := '';

        For intConta_ := 0 To Length(objArrDupCtr)-1 Do
          strAutInc := strAutInc + objArrDupCtr[intConta_].strAutoIn + '", "';

        strAutInc := '"'+ strAutInc;
        strAutInc := Copy(strAutInc, 1, Length(strAutInc)-3);

        With qryGenCtr Do
        Begin
          Close;
          SQL.Clear;
          SQL.Text := fGetSQLBoletos(objArrDupCtr[0].blnAvisoAutomaticoEmail);
          SQL.Text := StringReplace(SQL.Text, 'AUTINC', strAutInc, []);
          Open;
        End;

        objBoleto := TBoleto.Create(Nil, 'CADREC', blnFaturamento);
        cdsBoleto := fCriaClientDatset(qryGenCtr);

        blnEmaAut := (Not blnTelaDeCadastro) And
                     (objBoleto.fVerificaEmailAutmatico(objArrDupCtr[0]));

        objBoleto.pImprimir(cdsBoleto, objArrDupCtr, '', True, True, blnEmaAut, objArrDupCtr[0].blnAvisoAutomaticoEmail, False, '', '', '');

        Result := True;
      Except
        On E: ExceptionAutcom Do
          fMensagem('ATENÇÃO', E.Message, ['&Ok']);

        On e: Exception Do
          pMensagensErro(E.Message, '[untFuncoes.fImprimirBoletos]');
      End;

      If Assigned(cdsBoleto) Then
        FreeAndNil(cdsBoleto);

      If Assigned(objBoleto) Then
        FreeAndNil(objBoleto);

      FreeAndNil(qryGenCtr);
    End;
  End;
End;

function TBoleto.fNossoNumeroAnterior(ctrDup: TDupCtr; blnManterPortador: Boolean): String;
begin
  If Not blnManterPortador and blnPortadorAlterado Then
    pUpdateCadRec(ctrDup);
  Result := fSelectNossoNumeroAnterior(ctrDup);
end;

{*************************************************************}
{* RETORNA O NÚMERO DA CARTEIRA EM QUE O BOLETO FOI IMPRESSO *}
{*REQ-25848-23/01/2015*************************************JU*}
class function TBoleto.fReimpressaoPDFBoleto(objDuplic: TArrDupCtr): Boolean;
begin
  // Função implementada no Monitor
  Result := True;
end;

function TBoleto.fRetNumCartReimpressao(strCartei: String): Integer;
  Var
    intCont: Integer;
begin

  Result := 0;

  For intCont := 1 To Length(strCartei) Do
  Begin
    If Copy(strCartei, intCont, 1) = '-' Then
    Begin
      Result := StrToInt(Copy(strCartei, intCont + 1, 1));
      Break;
    End;
  End;

end;

function TBoleto.fRetornaEmailCliente(cdsBoleto: TDataset): String;
begin
  If (fCfgSis('GPEMCB', VarBoolean)) Then
  Begin
    Result := '';

    If Not fEmptyStr(cdsBoleto.FieldByName('CLI_EMCOB1').AsString) Then
      Result := cdsBoleto.FieldByName('CLI_EMCOB1').AsString;

    If Not fEmptyStr(cdsBoleto.FieldByName('CLI_EMCOB2').AsString) Then
    Begin
      If fEmptyStr(Result) Then
        Result := cdsBoleto.FieldByName('CLI_EMCOB2').AsString
      Else
        Result := Result + '; ' + cdsBoleto.FieldByName('CLI_EMCOB2').AsString;
    End;

    If fEmptyStr(Result) Then
    Begin
      If Not fEmptyStr(cdsBoleto.FieldByName('CLI_EMAIL_').AsString) Then
        Result := cdsBoleto.FieldByName('CLI_EMAIL_').AsString
      Else If Not fEmptyStr(cdsBoleto.FieldByName('CLI_EMAIL2').AsString) Then
        Result := cdsBoleto.FieldByName('CLI_EMAIL2').AsString;
    End;
  End
  Else
  Begin
    If Not fEmptyStr(cdsBoleto.FieldByName('CLI_EMCOB1').AsString) Then
      Result := cdsBoleto.FieldByName('CLI_EMCOB1').AsString
    Else If Not fEmptyStr(cdsBoleto.FieldByName('CLI_EMCOB2').AsString) Then
      Result := cdsBoleto.FieldByName('CLI_EMCOB2').AsString
    Else If Not fEmptyStr(cdsBoleto.FieldByName('CLI_EMAIL_').AsString) Then
      Result := cdsBoleto.FieldByName('CLI_EMAIL_').AsString
    Else If Not fEmptyStr(cdsBoleto.FieldByName('CLI_EMAIL2').AsString) Then
      Result := cdsBoleto.FieldByName('CLI_EMAIL2').AsString
    Else
      Result := '';
  End;

  If (Not fEmptyStr(cdsBoleto.FieldByName('CLI_EMAIL3').AsString)) Then
  Begin
    If (Not fEmptyStr(Result)) Then
      Result := Result + '; ' + cdsBoleto.FieldByName('CLI_EMAIL3').AsString
    Else
      Result := cdsBoleto.FieldByName('CLI_EMAIL3').AsString;
  End;

  Result := AnsiReplaceStr(Result, ';;', ';');

end;

{*****************************************}
{* INICIALIZA QUERIES COMS SEUS SELECTS  *}
{**************************************AF*}
procedure TBoleto.pInicializaCamposUso;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT                                                ';
  strSQL := strSQL + '  C.*,                                                ';
  strSQL := strSQL + '  D1.CID_NOMCID AS CID_NOMCID,                        ';
  strSQL := strSQL + '  D1.CID_ESTADO AS CID_ESTADO,                        ';
  strSQL := strSQL + '  D2.CID_NOMCID AS CID_CIDCOB,                        ';
  strSQL := strSQL + '  D2.CID_ESTADO AS CID_ESTCOB,                        ';
  strSQL := strSQL + '  D3.CID_NOMCID AS CID_CIDENT,                        ';
  strSQL := strSQL + '  D3.CID_ESTADO AS CID_ESTENT                         ';
  strSQL := strSQL + 'FROM                                                  ';
  strSQL := strSQL + '  CADCLI AS C                                         ';
  strSQL := strSQL + '  JOIN CADCID     D1  ON C.CLI_CODCID = D1.CID_CODCID ';
  strSQL := strSQL + '  LEFT JOIN CADCID D2 ON C.CLI_CIDCOB = D2.CID_CODCID ';
  strSQL := strSQL + '  LEFT JOIN CADCID D3 ON C.CLI_CIDENT = D3.CID_CODCID ';
  strSQL := strSQL + 'WHERE                                                 ';
  strSQL := strSQL + '  C.CLI_CODCLI = :CODCLI                              ';

  qryConCli.SQL.Clear;
  qryConCli.SQL.Add(strSQL);
  qryConCli.Open;

  strSQL := '';
  strSQL := strSQL + 'SELECT                                              ';
  strSQL := strSQL + '  R.*,                                              ';
  strSQL := strSQL + RetornaSelectLinkDoBoleto + ',                       ';
  strSQL := strSQL + '  O.OPE_NOMOPE AS OPE_NOMOPE,                       ';
  strSQL := strSQL + '  P.POR_NOMPOR AS POR_NOMPOR                        ';
  strSQL := strSQL + 'FROM                                                ';
  strSQL := strSQL + strNomeTabela + ' R                                  ';
  strSQL := strSQL + '  JOIN CADOPE O ON R.CTR_CODVEN = O.OPE_CODOPE      ';
  strSQL := strSQL + '  LEFT JOIN CADPOR P ON R.CTR_CODPOR = P.POR_CODPOR ';
  strSQL := strSQL + 'WHERE                                               ';
  strSQL := strSQL + '  R.CTR_NUMDUP = :NUMDUP AND                        ';
  strSQL := strSQL + '  R.CTR_PARCEL = :PARCEL AND                        ';
  strSQL := strSQL + '  R.CTR_ESPDOC = :ESPDOC AND                        ';
  strSQL := strSQL + '  R.CTR_CODEMP = :CODEMP AND                        ';
  strSQL := strSQL + '  R.CTR_CODCLI = :CODCLI AND                        ';
  strSQL := strSQL + '  R.CTR_SEQBAI = 0                                  ';

  qryConRec.SQL.Clear;
  qryConRec.SQL.Add(strSQL);
  qryConRec.Open;

  strSQL := '';
  strSQL := strSQL + 'SELECT                          ';
  strSQL := strSQL + '  SUM(CTR_VALDUP) AS CTR_TOTDUP ';
  strSQL := strSQL + 'FROM                            ';
  strSQL := strSQL + '  CADREC                        ';
  strSQL := strSQL + 'WHERE                           ';
  strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP AND      ';
  strSQL := strSQL + '  CTR_PARCEL = :PARCEL AND      ';
  strSQL := strSQL + '  CTR_ESPDOC = :ESPDOC AND      ';
  strSQL := strSQL + '  CTR_CODEMP = :CODEMP AND      ';
  strSQL := strSQL + '  CTR_CODCLI = :CODCLI          ';

  qryConTot.SQL.Clear;
  qryConTot.SQL.Add(strSQL);
  qryConTot.Open;

  pAtribuiCamposUso;
end;


class procedure TBoleto.pAtualizaBoleto(objArrDupCtr: TArrDupCtr; blnReimpressao, blnProrrogado, blnPreview: Boolean; blnApenasGerarPDF : Boolean = False);
  Var
    objBoleto   : TBoleto;
    blnEmaAut   : Boolean;
    qryGenCtr   : TUniQuery;
    cdsBoleto   : TUniClientDataSet;
    intConta_   : Integer;
    strAutInc   : String;
Begin
  If Length(objArrDupCtr) <= 0 Then
    Exit;

  qryGenCtr := fCriaQuery;

  Try
    strAutInc := '';

    For intConta_ := 0 To Length(objArrDupCtr)-1 Do
      strAutInc := strAutInc + objArrDupCtr[intConta_].strAutoIn + '", "';

    strAutInc := '"'+ strAutInc;
    strAutInc := Copy(strAutInc, 1, Length(strAutInc)-3);

    qryGenCtr.Close;
    qryGenCtr.SQL.Clear;
    qryGenCtr.SQL.Text := fGetSQLBoletos(blnReimpressao);
    qryGenCtr.SQL.Text := StringReplace(qryGenCtr.SQL.Text, 'AUTINC', strAutInc, []);
    qryGenCtr.Open;

    objBoleto := TBoleto.Create(Nil, 'CADREC', False);
    cdsBoleto := fCriaClientDatset(qryGenCtr);

    blnEmaAut := False;

    Application.ProcessMessages;
    objBoleto.pImprimir(cdsBoleto,
                        objArrDupCtr,
                        cdsBoleto.FieldByName('CTR_BCOBOL').AsString,
                        True,
                        True,
                        blnEmaAut,
                        blnReimpressao,
                        False,
                        cdsBoleto.FieldByName('CTR_CARTEI').AsString,
                        '',
                        '',
                        '',
                        '',
                        '',
                        False,
                        False,
                        blnProrrogado,
                        True,
                        blnPreview,
                        False,
                        False,
                        blnApenasGerarPDF);
  Except
    Raise;
  End;

  If Assigned(cdsBoleto) Then
    FreeAndNil(cdsBoleto);

  If Assigned(objBoleto) Then
    FreeAndNil(objBoleto);

  FreeAndNil(qryGenCtr);
end;

{*****************************************}
{* ATUALIZA AS TABELAS ENVOLVIDAS NO PRO-*}
{* CESSO DE IMPRESSÃO DOS BOLETOS        *}
{**************************************AF*}
procedure TBoleto.pAtualizaCamposUso(ctrDup: TDupCtr);
begin

  With qryConCli Do
  Begin
    Close;
    ParamByName('CODCLI').AsString := ctrDup.strCodCli;
    Open;
  End;

  With qryConRec Do
  Begin
    Close;
    ParamByName('NUMDUP').AsString := ctrDup.strNumDup;
    ParamByName('PARCEL').AsString := ctrDup.strParcel;
    ParamByName('ESPDOC').AsString := ctrDup.strEspDoc;
    ParamByName('CODEMP').AsString := ctrDup.strCodEmp;
    ParamByName('CODCLI').AsString := ctrDup.strCodCli;
    Open;
  End;

  With qryConTot Do
  Begin
    Close;
    ParamByName('NUMDUP').AsString := ctrDup.strNumDup;
    ParamByName('PARCEL').AsString := ctrDup.strParcel;
    ParamByName('ESPDOC').AsString := ctrDup.strEspDoc;
    ParamByName('CODEMP').AsString := ctrDup.strCodEmp;
    ParamByName('CODCLI').AsString := ctrDup.strCodCli;
    Open;
  End;

  pFinalizaCamposUso;
  pAtribuiCamposUso;
end;

procedure TBoleto.pAtribuiCamposUso;
  Var
    strExtenso: String;
begin
  If Assigned(cpuCampos) Then
    FreeAndNil(cpuCampos);

  cpuCampos := TCamposUso.Create;
  cpuCampos.AdicionaCampos(qryConCli, 'CADCLI');
  cpuCampos.AdicionaCampos(qryConRec, 'CADREC');
  cpuCampos.AdicionaCampos(qryConTot, 'CADREC');


  FCodCli := qryConCli.FieldByName('CLI_CODCLI').AsString;
  FNomCli := qryConCli.FieldByName('CLI_NOMCLI').AsString;
  FInsEst := qryConCli.FieldByName('CLI_I_E_S_').AsString;

  If (Length(AnsiReplaceStr(qryConCli.FieldByName('CLI_C_G_C_').AsString, '.', '')) = 11) Then
    FCgcCli := Copy(qryConCli.FieldByName('CLI_C_G_C_').AsString,1,3) + '.' +
               Copy(qryConCli.FieldByName('CLI_C_G_C_').AsString,4,3) + '.' +
               Copy(qryConCli.FieldByName('CLI_C_G_C_').AsString,7,3) + '-' +
               Copy(qryConCli.FieldByName('CLI_C_G_C_').AsString,10,2)
  Else
    FCgcCli := Copy(qryConCli.FieldByName('CLI_C_G_C_').AsString,1,2) + '.' +
               Copy(qryConCli.FieldByName('CLI_C_G_C_').AsString,3,3) + '.' +
               Copy(qryConCli.FieldByName('CLI_C_G_C_').AsString,6,3) + '/' +
               Copy(qryConCli.FieldByName('CLI_C_G_C_').AsString,9,4) + '-' +
               Copy(qryConCli.FieldByName('CLI_C_G_C_').AsString,13,2);

  If (qryConCli.FieldByName('CLI_ENDCOB').IsNull) Or (qryConCli.FieldByName('CLI_ENDCOB').AsString = '') Then
    FEndCli := qryConCli.FieldByName('CLI_ENDERE').AsString + ', ' + qryConCli.FieldByName('CLI_ENDNUM').AsString
  Else
    FEndCli := qryConCli.FieldByName('CLI_ENDCOB').AsString;

  If (qryConCli.FieldByName('CLI_ENDCOB').IsNull) Or (qryConCli.FieldByName('CLI_ENDCOB').AsString = '') Then
    FCidCli := qryConCli.FieldByName('CID_NOMCID').AsString
  Else
    FCidCli := qryConCli.FieldByName('CID_CIDCOB').AsString;

  If (qryConCli.FieldByName('CLI_ENDCOB').IsNull) Or (qryConCli.FieldByName('CLI_ENDCOB').AsString = '') Then
    FEstCli := qryConCli.FieldByName('CID_ESTADO').AsString
  Else
    FEstCli := qryConCli.FieldByName('CID_ESTCOB').AsString;

  {***********************************************************}
  {* GUARDO O CEP DO CLIENTE PARA PODER FORMATA-LO NO CNFBOL *}
  {********************************************************AC*}

  If qryConCli.FieldByName('CLI_ENDCOB').AsString = '' Then
    FCepCli := Copy(qryConCli.FieldByName('CLI_C_E_P_').AsString,1,5) + '-' + Copy(qryConCli.FieldByName('CLI_C_E_P_').AsString,6,3)
  Else FCepCli := Copy(qryConCli.FieldByName('CLI_CEPCOB').AsString,1,5) + '-' + Copy(qryConCli.FieldByName('CLI_CEPCOB').AsString,6,3);

  If qryConRec.FieldByName('CTR_VALDUP').AsString <> '' Then
  Begin
    strExtenso := fRetExtensoNumero(AnsiReplaceStr(qryConRec.FieldByName('CTR_VALDUP').AsString,'-',''));
    FValExt  := AnsiUpperCase(Copy(strExtenso,1,50));
    FValExt2 := AnsiUpperCase(Copy(strExtenso,50,100));
  End;

  FValDes := qryConRec.FieldByName('CTR_VALDES').AsFloat;
//  FUltPar := fRetUltimaParcela(qryConRec.FieldByName('CTR_CODCLI').AsString, qryConRec.FieldByName('CTR_CODEMP').AsString,
//                                 qryConRec.FieldByName('CTR_NUMDUP').AsString, qryConRec.FieldByName('CTR_ESPDOC').AsString);


end;

procedure TBoleto.pFinalizaCamposUso;
begin
  If cpuCampos <> Nil Then
    FreeAndNil(cpuCampos);
end;

procedure TBoleto.RegistrarBoletoBancoDoBrasilAPI(Var ABancoDoBrasilApi        : TBancoDoBrasilAPI;
                                                  Var AGerouBancoDoBrasilApi   : Boolean;
                                                      AarrCtrDup               : TArrDupCtr;
                                                  Var ANosNum                  : String;
                                                      ACont                    : Integer);
  Var
    LDocumentosRestantes : String;
    LErroAPI : Boolean;
    LContadorTentativas : Integer;
    LContadorRestantes: Integer;
begin
  LContadorTentativas := 1;
  LErroAPI := False;

  While (LContadorTentativas <= 4) Do
  Begin
    Try
      ABancoDoBrasilApi.PercentualMulta := FMulta_;
      ABancoDoBrasilApi.PercentualMora  := FValMor;
      ABancoDoBrasilApi.Faturamento     := blnFaturamento;
      ABancoDoBrasilApi.RetornoBandoDoBrasilAPI := ABancoDoBrasilApi.CadastrarNovoBoleto(qryConRec, qryConCli, ANosNum);

      AGerouBancoDoBrasilApi := True;

      LErroAPI := False;
    Except
      On E: Exception Do
      Begin
        LErroAPI := True;


        If (LContadorTentativas >= 4) Or Not ABancoDoBrasilApi.TentarNovamente Then
        Begin
          LDocumentosRestantes := '';

          For LContadorRestantes := ACont To Length(AarrCtrDup)-1 Do
          Begin
            LDocumentosRestantes := LDocumentosRestantes + AarrCtrDup[LContadorRestantes].strNumDup +
                                                           AarrCtrDup[LContadorRestantes].strParcel + '-' +
                                                           AarrCtrDup[LContadorRestantes].strEspdoc + '-' +
                                                           AarrCtrDup[LContadorRestantes].strCodEmp + ', ';
          End;

          LDocumentosRestantes := LeftStr(LDocumentosRestantes, LDocumentosRestantes.Length - 2);

          Raise Exception.Create('BCOAPI-Ocorreram erros ao registrar o boleto no Banco do Brasil [Online].' + #13#10 +
                                 'Erro gerado: ' + E.Message + #13#10 +
                                 'Documentos ficaram sem gerar boleto: ' + LDocumentosRestantes);
        End;
      End;
    End;

    Inc(LContadorTentativas);

    If Not LErroAPI Then
      Break;
  End;

end;

procedure TBoleto.ReimpressaoBoletoBancoCredisisAPI( Var LBancoApi : TBancoCredisisAPI; strAutoIncrem : String );
  Var
    FXmlRet : TXMLDocument;
begin

   FXmlRet := TXMLDocument.Create(Self);

   LBancoApi.ReimpressaoDeBoleto(strAutoIncrem, FXmlRet);

End;

procedure TBoleto.RegistrarBoletoBancoBradescoAPI(
  var ABancoBradescoApi: TBancoBradescoAPI; var AGerouBancoBradescoApi: Boolean;
  AarrCtrDup: TArrDupCtr; var ANosNum: String; ACont: Integer);
  Var
    LDocumentosRestantes: String;

    LErroAPI: Boolean;

    LContadorTentativas,
    LContadorRestantes,
    LTotalTentativas: Integer;

    LNovoNossoNumero: Int64;
begin
  LContadorTentativas := 1;
  LTotalTentativas := 2;

  LErroAPI := False;

  While (LContadorTentativas <= LTotalTentativas) Do
  Begin
    Try
      ABancoBradescoApi.PercentualMulta := FMulta_;
      ABancoBradescoApi.PercentualMora  := FValMor;
      ABancoBradescoApi.Faturamento     := blnFaturamento;
      ABancoBradescoApi.RetornoBancoBradescoAPI := ABancoBradescoApi.CadastrarNovoBoleto(qryConRec, qryConCli, ANosNum);

      AGerouBancoBradescoApi := ABancoBradescoApi.RetornoBancoBradescoAPI.NuTituloGerado > 0;

      LErroAPI := ABancoBradescoApi.RetornoBancoBradescoAPI.NuTituloGerado = 0;
    Except
      On E: Exception Do
      Begin
        LErroAPI := True;

        If Pos('Status: 400', E.Message) > 0 Then
          ABancoBradescoApi.TentarNovamente := False;
        If Pos('Status: 422', E.Message) > 0 Then
          ABancoBradescoApi.TentarNovamente := False;

        If Pos('Status: 403', E.Message) > 0 Then
          ABancoBradescoApi.RemoverTokenGravado;

        If ABancoBradescoApi.NossoNumeroDuplicado Then
        Begin
          LTotalTentativas := 5;
          ABancoBradescoApi.TentarNovamente := True;

          If TryStrToInt64(ANosNum, LNovoNossoNumero) Then
            ANosNum := (LNovoNossoNumero + 1).ToString
          Else
            ABancoBradescoApi.TentarNovamente := False;
        End;

        If (LContadorTentativas >= LTotalTentativas) Or Not ABancoBradescoApi.TentarNovamente Then
        Begin
          LDocumentosRestantes := '';

          For LContadorRestantes := ACont To Length(AarrCtrDup)-1 Do
          Begin
            LDocumentosRestantes := LDocumentosRestantes + AarrCtrDup[LContadorRestantes].strNumDup +
                                                           AarrCtrDup[LContadorRestantes].strParcel + '-' +
                                                           AarrCtrDup[LContadorRestantes].strEspdoc + '-' +
                                                           AarrCtrDup[LContadorRestantes].strCodEmp + ', ';
          End;

          LDocumentosRestantes := LeftStr(LDocumentosRestantes, LDocumentosRestantes.Length - 2);

          Raise Exception.Create('BCOAPI-Ocorreram erros ao registrar o boleto no Banco Bradesco [Online].' + #13 +
                                 'Erro gerado: ' + E.Message + #13 +
                                 'Documentos ficaram sem gerar boleto: ' + LDocumentosRestantes);
        End;
      End;
    End;

    Inc(LContadorTentativas);

    If Not LErroAPI Then
      Break;
  End;
end;

procedure TBoleto.RegistrarBoletoBancoCredisisAPI(Var ABancoCredisisApi        : TBancoCredisisAPI;
                                                  Var AGerouBancoCredisisApi   : Boolean;
                                                      AarrCtrDup               : TArrDupCtr;
                                                  Var ANosNum                  : String;
                                                      ACont                    : Integer);
  Var
    LDocumentosRestantes : String;
    LErroAPI : Boolean;
    LContadorTentativas : Integer;
    LContadorRestantes: Integer;
    FXmlRetorno : TXMLDocument;
begin
  LContadorTentativas := 1;
  LErroAPI := False;
  FXmlRetorno := TXMLDocument.Create(Self);

  While (LContadorTentativas <= 4) Do
  Begin
    Try
      ABancoCredisisApi.PercentualMulta := FMulta_;
      ABancoCredisisApi.PercentualMora  := FValMor;
      ABancoCredisisApi.Faturamento     := blnFaturamento;
      ABancoCredisisApi.RetornoBancoCredisisAPI := ABancoCredisisApi.CadastrarNovoBoleto(qryConRec, qryConCli, ANosNum, FXmlRetorno);

      If Not ABancoCredisisApi.ErroNoXml Then
         AGerouBancoCredisisApi := True
      Else
         AGerouBancoCredisisApi := False;

      LErroAPI := False;
    Except
      On E: Exception Do
      Begin
        LErroAPI := True;


        If (LContadorTentativas >= 4) Or Not ABancoCredisisApi.TentarNovamente Then
        Begin
          LDocumentosRestantes := '';

          For LContadorRestantes := ACont To Length(AarrCtrDup)-1 Do
          Begin
            LDocumentosRestantes := LDocumentosRestantes + AarrCtrDup[LContadorRestantes].strNumDup +
                                                           AarrCtrDup[LContadorRestantes].strParcel + '-' +
                                                           AarrCtrDup[LContadorRestantes].strEspdoc + '-' +
                                                           AarrCtrDup[LContadorRestantes].strCodEmp + ', ';
          End;

          LDocumentosRestantes := LeftStr(LDocumentosRestantes, LDocumentosRestantes.Length - 2);

          Raise Exception.Create('BCOAPI-Ocorreram erros ao registrar o boleto no Banco Credisis [Online].' + #13#10 +
                                 'Erro gerado: ' + E.Message + #13#10 +
                                 'Documentos ficaram sem gerar boleto: ' + LDocumentosRestantes);
        End;
      End;
    End;

    Inc(LContadorTentativas);

    If Not LErroAPI Then
      Break;
  End;

end;

procedure TBoleto.RegistrarBoletoBancoSantanderAPI(  var ABancoSantanderApi: TBancoSantanderAPI; var AGerouBancoSantanderApi: Boolean;
  AarrCtrDup: TArrDupCtr; var ANosNum: String; ACont: Integer);
  Var
    LDocumentosRestantes : String;

    LErroAPI : Boolean;

    LContadorTentativas,
    LTotalTentativas,
    LContadorRestantes: Integer;

    LTesteNossoNumero: Int64;
begin
  LContadorTentativas := 1;
  LTotalTentativas := 2;

  LErroAPI := False;

  While (LContadorTentativas <= LTotalTentativas) Do
  Begin
    Try
      ABancoSantanderApi.PercentualMulta := FMulta_;
      ABancoSantanderApi.PercentualMora  := FValMor * 30;
      ABancoSantanderApi.Faturamento     := blnFaturamento;
      ABancoSantanderApi.NossoNumeroDuplicado := False;
      ABancoSantanderApi.RetornoBancoSantanderAPI := ABancoSantanderApi.CadastrarNovoBoleto(qryConRec, qryConCli, ANosNum);

      AGerouBancoSantanderApi := Not ABancoSantanderApi.RetornoBancoSantanderAPI.LinhaDigitavel.IsEmpty;

      LErroAPI := ABancoSantanderApi.RetornoBancoSantanderAPI.LinhaDigitavel.IsEmpty;
    Except
      On E: Exception Do
      Begin
        LErroAPI := True;

        If Pos('Status: 400', E.Message) > 0 Then
          ABancoSantanderApi.TentarNovamente := False;
        If Pos('Status: 422', E.Message) > 0 Then
          ABancoSantanderApi.TentarNovamente := False;

        If ABancoSantanderApi.NossoNumeroDuplicado Then
        Begin
          LTotalTentativas := 5;
          ABancoSantanderApi.TentarNovamente := TryStrToInt64(ANosNum, LTesteNossoNumero);

          If ABancoSantanderApi.TentarNovamente Then
            ANosNum := (StrToInt64(ANosNum) + 1).ToString;
        End;

        If (LContadorTentativas >= LTotalTentativas) Or Not ABancoSantanderApi.TentarNovamente Then
        Begin
          LDocumentosRestantes := '';

          For LContadorRestantes := ACont To Length(AarrCtrDup)-1 Do
          Begin
            LDocumentosRestantes := LDocumentosRestantes + AarrCtrDup[LContadorRestantes].strNumDup +
                                                           AarrCtrDup[LContadorRestantes].strParcel + '-' +
                                                           AarrCtrDup[LContadorRestantes].strEspdoc + '-' +
                                                           AarrCtrDup[LContadorRestantes].strCodEmp + ', ';
          End;

          LDocumentosRestantes := LeftStr(LDocumentosRestantes, LDocumentosRestantes.Length - 2);

          Raise Exception.Create('BCOAPI-Ocorreram erros ao registrar o boleto no Banco Santander [Online].' + #13#10 +
                                 'Erro gerado: ' + E.Message + #13#10 +
                                 'Documentos ficaram sem gerar boleto: ' + LDocumentosRestantes);
        End;
      End;
    End;

    Inc(LContadorTentativas);

    If Not LErroAPI Then
      Break;
  End;
end;

procedure TBoleto.RegistrarBoletoBancoSicoobAPI(
  var ABancoSicoobApi: TBancoSicoobAPI; var AGerouBancoSicoobApi: Boolean;
  AarrCtrDup: TArrDupCtr; var ANosNum: String; ACont: Integer);
  Var
    LDocumentosRestantes : String;

    LErroAPI : Boolean;

    LContadorTentativas,
    LContadorRestantes: Integer;
begin
  LContadorTentativas := 1;

  LErroAPI := False;

  While (LContadorTentativas <= 2) Do
  Begin
    Try
      ABancoSicoobApi.PercentualMulta := FMulta_;
      ABancoSicoobApi.PercentualMora  := FValMor;
      ABancoSicoobApi.Faturamento     := blnFaturamento;
      ABancoSicoobApi.RetornoBancoSicoobAPI := ABancoSicoobApi.CadastrarNovoBoleto(qryConRec, qryConCli, ANosNum);

      AGerouBancoSicoobApi := Not ABancoSicoobApi.RetornoBancoSicoobAPI.nossoNumero.IsEmpty;

      LErroAPI := ABancoSicoobApi.RetornoBancoSicoobAPI.nossoNumero.IsEmpty;
    Except
      On E: Exception Do
      Begin
        LErroAPI := True;

        If Pos('Status: 400', E.Message) > 0 Then
          ABancoSicoobApi.TentarNovamente := False;
        If Pos('Status: 422', E.Message) > 0 Then
          ABancoSicoobApi.TentarNovamente := False;

        If (LContadorTentativas >= 2) Or Not ABancoSicoobApi.TentarNovamente Then
        Begin
          LDocumentosRestantes := '';

          For LContadorRestantes := ACont To Length(AarrCtrDup)-1 Do
          Begin
            LDocumentosRestantes := LDocumentosRestantes + AarrCtrDup[LContadorRestantes].strNumDup +
                                                           AarrCtrDup[LContadorRestantes].strParcel + '-' +
                                                           AarrCtrDup[LContadorRestantes].strEspdoc + '-' +
                                                           AarrCtrDup[LContadorRestantes].strCodEmp + ', ';
          End;

          LDocumentosRestantes := LeftStr(LDocumentosRestantes, LDocumentosRestantes.Length - 2);

          Raise Exception.Create('BCOAPI-Ocorreram erros ao registrar o boleto no Banco Sicoob [Online].' + #13#10 +
                                 'Erro gerado: ' + E.Message + #13#10 +
                                 'Documentos ficaram sem gerar boleto: ' + LDocumentosRestantes);
        End;
      End;
    End;

    Inc(LContadorTentativas);

    If Not LErroAPI Then
      Break;
  End;
end;

procedure TBoleto.RegistrarBoletoBancoSafraAPI(Var ABancoSafraApi       : TBancoSafraAPI;
                                               Var AGerouBancoSafraApi  : Boolean;
                                                   AarrCtrDup           : TArrDupCtr;
                                               Var ANosNum               : String;
                                                   ACont                : Integer);
  Var
    LDocumentosRestantes : String;
    LErroAPI : Boolean;
    LContadorTentativas : Integer;
    LContadorRestantes: Integer;
begin
  LContadorTentativas := 1;
  LErroAPI := False;

  While (LContadorTentativas <= 4) Do
  Begin
    Try
      ABancoSafraApi.PercentualMulta := FMulta_;
      ABancoSafraApi.PercentualMora  := FValMor;
      ABancoSafraApi.Faturamento     := blnFaturamento;
      ABancoSafraApi.RetornoBancoSafraAPI := ABancoSafraApi.CadastrarNovoBoleto(qryConRec, qryConCli, ANosNum);

      AGerouBancoSafraApi := True;

      LErroAPI := False;
    Except
      On E: Exception Do
      Begin
        LErroAPI := True;


        If (LContadorTentativas >= 4) Or Not ABancoSafraApi.TentarNovamente Then
        Begin
          LDocumentosRestantes := '';

          For LContadorRestantes := ACont To Length(AarrCtrDup)-1 Do
          Begin
            LDocumentosRestantes := LDocumentosRestantes + AarrCtrDup[LContadorRestantes].strNumDup +
                                                           AarrCtrDup[LContadorRestantes].strParcel + '-' +
                                                           AarrCtrDup[LContadorRestantes].strEspdoc + '-' +
                                                           AarrCtrDup[LContadorRestantes].strCodEmp + ', ';
          End;

          LDocumentosRestantes := LeftStr(LDocumentosRestantes, LDocumentosRestantes.Length - 2);

          Raise Exception.Create('BCOAPI-Ocorreram erros ao registrar o boleto no Banco Safra [Online].' + #13#10 +
                                 'Erro gerado: ' + E.Message + #13#10 +
                                 'Documentos ficaram sem gerar boleto: ' + LDocumentosRestantes);
        End;
      End;
    End;

    Inc(LContadorTentativas);

    If Not LErroAPI Then
      Break;
  End;

end;

procedure TBoleto.RegistrarBoletoBancoSicrediAPI(Var ABancoSicrediApi         : TBancoSicrediAPI;
                                                 Var AGerouBancoSicrediApi    : Boolean;
                                                     AarrCtrDup               : TArrDupCtr;
                                                 Var ANosNum                  : String;
                                                     ACont                    : Integer);
  Var
    LDocumentosRestantes : String;
    LErroAPI : Boolean;
    LContadorTentativas : Integer;
    LContadorRestantes: Integer;
begin
  LContadorTentativas := 1;
  LErroAPI := False;

  While (LContadorTentativas <= 4) Do
  Begin
    Try
      ABancoSicrediApi.PercentualMulta := FMulta_;
      ABancoSicrediApi.PercentualMora  := FValMor;
      ABancoSicrediApi.Faturamento     := blnFaturamento;
      ABancoSicrediApi.RetornoBancoSicrediAPI := ABancoSicrediApi.CadastrarNovoBoleto(qryConRec, qryConCli, ANosNum);

      AGerouBancoSicrediApi := True;

      LErroAPI := False;
    Except
      On E: Exception Do
      Begin
        LErroAPI := True;


        If (LContadorTentativas >= 4) Or Not ABancoSicrediApi.TentarNovamente Then
        Begin
          LDocumentosRestantes := '';

          For LContadorRestantes := ACont To Length(AarrCtrDup)-1 Do
          Begin
            LDocumentosRestantes := LDocumentosRestantes + AarrCtrDup[LContadorRestantes].strNumDup +
                                                           AarrCtrDup[LContadorRestantes].strParcel + '-' +
                                                           AarrCtrDup[LContadorRestantes].strEspdoc + '-' +
                                                           AarrCtrDup[LContadorRestantes].strCodEmp + ', ';
          End;

          LDocumentosRestantes := LeftStr(LDocumentosRestantes, LDocumentosRestantes.Length - 2);

          Raise Exception.Create('BCOAPI-Ocorreram erros ao registrar o boleto no Banco Sicredi [Online].' + #13#10 +
                                 'Erro gerado: ' + E.Message + #13#10 +
                                 'Documentos ficaram sem gerar boleto: ' + LDocumentosRestantes);
        End;
      End;
    End;

    Inc(LContadorTentativas);

    If Not LErroAPI Then
      Break;
  End;

end;

procedure TBoleto.RegistrarBoletoBancoItauAPI(Var ABancoItauApi        : TBancoItauAPI;
                                              Var AGerouBancoItauApi   : Boolean;
                                                  AarrCtrDup           : TArrDupCtr;
                                              Var ANosNum              : String;
                                                  ACont                : Integer);
  Var
    LDocumentosRestantes : String;
    LErroAPI : Boolean;

    LMaximoTentativas,
    LContadorTentativas,
    LContadorRestantes: Integer;
begin
  LContadorTentativas := 1;
  LErroAPI := False;

  LMaximoTentativas := 2;

  While (LContadorTentativas <= LMaximoTentativas) Do
  Begin
    Try
      ABancoItauApi.PercentualMulta := FMulta_;
      ABancoItauApi.PercentualMora  := FValMor;
      ABancoItauApi.Faturamento     := blnFaturamento;
      ABancoItauApi.RetornoBancoItauAPI := ABancoItauApi.CadastrarNovoBoleto(qryConRec, qryConCli, ANosNum);

      AGerouBancoItauApi := Not ABancoItauApi.ErroNossoNumeroDuplicado;

      LErroAPI := ABancoItauApi.ErroNossoNumeroDuplicado;
    Except
      On E: Exception Do
      Begin
        LErroAPI := True;

        If Pos('Status: 400', E.Message) > 0 Then
          ABancoItauApi.TentarNovamente := False;
        If Pos('Status: 422', E.Message) > 0 Then
          ABancoItauApi.TentarNovamente := False;

        If E.Message.Contains('Status: 202') Then
          LMaximoTentativas := 5;

        If (LContadorTentativas >= LMaximoTentativas) Or Not ABancoItauApi.TentarNovamente Then
        Begin
          LDocumentosRestantes := '';

          For LContadorRestantes := ACont To Length(AarrCtrDup)-1 Do
          Begin
            LDocumentosRestantes := LDocumentosRestantes + AarrCtrDup[LContadorRestantes].strNumDup +
                                                           AarrCtrDup[LContadorRestantes].strParcel + '-' +
                                                           AarrCtrDup[LContadorRestantes].strEspdoc + '-' +
                                                           AarrCtrDup[LContadorRestantes].strCodEmp + ', ';
          End;

          LDocumentosRestantes := LeftStr(LDocumentosRestantes, LDocumentosRestantes.Length - 2);

          Raise Exception.Create('BCOAPI-Ocorreram erros ao registrar o boleto no Banco Itaú [Online].' + #13#10 +
                                 'Erro gerado: ' + E.Message + #13#10 +
                                 'Documentos ficaram sem gerar boleto: ' + LDocumentosRestantes);
        End;
      End;
    End;

    Inc(LContadorTentativas);

    If Not LErroAPI Then
      Break;
  End;

end;

procedure TBoleto.ExibeFormMensagemErro(AMensagem: String);
  Var
    LArqNaoGravados: TfrmArqNaoGravados;
begin
  Try
    pCriarFormularios(TfrmArqNaoGravados,LArqNaoGravados);
    LArqNaoGravados.Caption := 'AVISO';
    LArqNaoGravados.memResumo.WantReturns := True;
    LArqNaoGravados.memResumo.Lines.Add(AMensagem);
    LArqNaoGravados.ShowModal;
  Finally
    FreeAndNil(LArqNaoGravados);
  End;
end;

end.
