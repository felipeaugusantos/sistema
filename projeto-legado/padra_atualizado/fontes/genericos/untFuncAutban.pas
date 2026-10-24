unit untFuncAutban;

interface

uses Windows, Forms, Classes, SysUtils, Uni, StrUtils, UniClientDataSet, Data.DB,
     System.Generics.Collections, Variants,cxProgressBar,Xml.XMLIntf,Xml.XMLDoc,
     untMinioStorageApiCitel, System.DateUtils, Math,JSON;

  {***********************}
  {* FUNCOES PARA AUTBAN *}
  {********************LB*}
  function fCalcDigito(strCodBco, strNosNum, strBcoIni: String; intCodCar: Integer; strCodEmp: String; dtaDtaGen : TDateTime = 0): String;
  function fCalcNossoNumero(strCodBco, strNosNum, strBcoIni: String; intCodCar: Integer; strCodEmp: String): String;
  function fRetLinDig(strCodBco, strNumAge, strCodCar, strNumCon, strCodCed, strNosNum, strVlrTit: String; dtaDtaVen: TDateTime; blnExibMsgErro: Boolean = True):String;
  function fCalcDigCmpLiv(strVlrFix, NosNum, NumAge, CodCed, strVlrFx1: String): String;
  function fValidaTamanhoString(strDigito, strNomPar, strIdeBan: String; intTamanh: Integer; blnExibeMsgErro: Boolean = True): Boolean;
  function fVerificaContido(strOrigem, strContid, strNomStr: String): Boolean;
  function fGePriDig(strBanco1, strMoeda1, strCedent: String): String;
  function fGeSegDig(strCedent, strNumDup:String): String;
  function fGeTerDig(strNumAge, strCodCed:String): String;
  function fGeDigAut(Banco1, Moeda1, FatVen, VlrDup, CodCar, NosNum, NumAge, CodCed: String): String;
  function fTemNaCadCbi(strNumDup, strEspDoc, strParcel, strCodEmp, strCodCli, strCodBco: String): Boolean;
  function fQtdParcelas(strNumDup, strCodEmp, strEspDoc, strCodCli: String): Integer;
  function fRetirarCaracteresEspeciais(strTexto : String): String;
  function fRetStrToSQLIn(strValores: String; strDelimitador: String = '_'): String;
  function RetiraQuebraLinha(AText : String): String;
  procedure Aguarde(msecs: Integer);
  function RetornaValorString(AValor: String; ATamanho: Integer = 0): String;
  function AlteraFormatoData(AData:String) : String;
  function ExtrairJsonObject(AObjeto: TJsonObject;ANomeJson: String): TJsonObject;
  procedure pStep(pgbStatus: TcxProgressBar);

  {**********************************}
  {* PARA SER UTILIZADO EM ARQUIVOS *}
  {* DE RETORNO NO AUTBAN           *}
  {*******************************AJ*}
  procedure pDeletaArqBcoContasPagar(strCodBco: String);
  procedure pGravaArqBcoContasPagar(strParcel, strNumDup, strCodFor, strCodEmp, strSeqBai, strSerie_,
                                    strCodBco, strBcoFav, strNosNum, strCodOco, strMotOco, strValDup,
                                    strDesCon, strJurMor, strValPag, strDtaVen, strDtaPag, strNomArq,
                                    strAutInc: String; dtaDtaArq: TDateTime; var qryRetCtp: TUniQuery;
                                    ATipoLayout: String = '');

  procedure pIncluiOcor(strNosNum, strCodCli, strNumDup, strEspDoc, strCodEmp: String;
                                 dtaDtaVen, dtaDtaPag: TDate; fltValDup, fltValPag: Double; Var cdsNaoGra: TUniClientDataSet; AMotivo:String = '');
  function fRenomeiaArquivo(strNomArq: String): Boolean;
  function RetornaHorarioRegistroBoleto(AAutoIncrem:String):String;
  function RetornaDataVencimentoRegistroBoleto(AAutoIncrem:String; ACodBco:String):TDateTime;
  function RetornaDiasParaRecebimentoAposVencimetoRegistroBoleto(ACodBco:String; ARegBol: TDataSet): String;
  function RetornaEnderecoPagadorRegistroBoleto(AAutoIncrem:String):String;
  function RetornaValorJson(AObjeto: TJsonObject;ANomeCampo: String): String;

  function fRetornoDuplicado(strNomeArquivo, strCarteira: String): Boolean; Overload;
  function fRetornoDuplicado(strNomeArquivo, strCarteira: String; dtaDtaRet :TDateTime): Boolean; Overload;

  function RetornaOcorrencia(ABanco, AOcorrencia, ACnab: String; AMotivo: String = ''; ADescricaoComMotivo: Boolean = True): String;

  procedure pGravaRemGer(strCodEmp, strCodBco, strCartei: String; intNroRem: Integer; Var strAutoIncrem: String);
  procedure pGravaDelRemGer(strSeqGeral, strMotivo: String);

  procedure pGravaDelRemDet(strMotivo,
                            strDuplic: String;
                            Var strSeqGer: String);

  procedure pGravaRemDet(strSeqGer: String;
                         strDuplic: String;
                         strNosNum: String;
                         fltPorcen: Double = 0;
                         fltValDup: Double = 0;
                         dtaDtaRec: TDateTime = 0;
                         dtaDtaVen: TDateTime = 0;
                         dtaDtaEnv: TDateTime = 0;
                         strOpeEnv: String = '';
                         strStsSer: String = '';
                         strProtes: String = '';
                         dtaDtRecL: TDateTime = 0);

  procedure pGravaRetGer(strCodEmp,
                         strCodBco,
                         strCartei,
                         strNomArq: String;
                         intNroRem: Integer;
                         blnUpDate: Boolean;
                         Var strAutoIncrem: String);

  procedure pGravaRetDet(strSeqGer: String;
                         strDuplic: String;
                         strNosNum: String;
                         fltValPag: Double = 0;
                         fltValJur: Double = 0;
                         fltValDes: Double = 0;
                         fltTarifa: Double = 0;
                         dtaDtaPag: TDateTime = 0;
                         strBcoPag: String = '';
                         strAgePag: String = '';
                         dtaDtaRet: TDateTime = 0;
                         strOpeRet: String = '';
                         strStsSer: String = '';
                         strCodOco: String = '';
                         blnUpdate: Boolean = False;
                         dtaDtaVen: TDateTime = 0);

  function fRetornaCarteiraDuplicataRetBco(strCodBco,
                                           strCodEmp,
                                           strCarteiraAtual: String;
                                           arrConfiguracoes,
                                           arrValores: Array of String) : String;

  procedure pDeletaCadCbi(strCodBco: String; strCartei: String = ''; strCodPor: String = '');

  function RetornaEnderecoENumeroCom40Caracteres(AEndereco, ANumero: String): String;
  function RetornaEnderecoENumeroCom35Caracteres(AEndereco, ANumero: String): String;
  function RetornaEnderecoENumeroCom37Caracteres(AEndereco, ANumero: String): String;
  function RetornaEnderecoENumeroCom38Caracteres(AEndereco, ANumero: String): String;
  function RetornaEnderecoENumeroCom30Caracteres(AEndereco, ANumero: String): String;

  function fRetNumParcela(strNumDoc: String): String;
  function RetornaNumeroParcela(AParcela:String):String;

  function fLockBaixaAutomatica(strCodBco : String; blnMsg, blnTrava : Boolean): Boolean;
  function fLiberaLockBaixaAutomatica(strCodBco : String): Boolean;
  function fRetornaEmailCliente(ARemessa: TUniQuery): String;

  function RetornaListaDeCarteirasCFGBAN: TStringList;
  procedure LimpaDadosBoleto(AAutoIncrem:String);
  procedure AtualizaPixBoleto(AAutoincrem,AQrCodeTxId,AQrCodeEmv,
                              AQrCodeUrl,AQrCodeLinkCitel:String);

  function VerificaNossoNumeroDuplicado(ANossoNumero,
                                        ACodigoBanco,
                                        ACodigoEmpresa,
                                        ACarteira: String;
                                        Var AQuantidadeRegistros: Integer;
                                        AAutoIncremCadRec: String): Boolean;

  procedure GravaRegistroRetBco(out AChaveDuplicatas: TStringList;
                                out AListaBaixadas: TStringList;
                                var ARetBco: TUniQuery;
                                ACarteira: Integer;
                                AParcel, ANumDup, ACodCli, ACodEmp, AEspDoc,
                                ADtaOco, ADtaVen, ADtaPag, ANomArq, ADesCon,
                                AValDup, AValPag, AJurMor, AOutVal, ACodBco,
                                ACodOco, ANosNum, ACodRej, AMotOco: String;
                                ADtaArq: TDateTime;
                                ASomaJur: Boolean = False;
                                AConRet: String = '';
                                AOutCob: String = '';
                                ADtaCre: String = '';
                                ATarifa: String = '';
                                AValLan: String = '';
                                ACusCar: String = '';
                                ACarBco: String = '';
                                AIofDes: String = '';
                                ATxaDes: String = '';
                                ADescontada: Boolean = False;
                                AJurOpe: String = '';
                                ACnab: String = '';
                                ARecPix: String = 'N';
                                AEnd_ID: String = '';
                                AEmpresaImportacao: String = '');

  function VerificaDuplicataBaixadaImportacao(out AListaNossoNumero: TStringList;
                                              ANumDup, AParcel, AEspDoc,
                                              ACodEmp, ACodCli: String;
                                              ANosNum: String = ''): Boolean;

  procedure ApagaRegistrosAnterioresRetBco(ACodigoBanco: String;
                                           AApagaRegistros: Boolean;
                                           ATipoCnab: String = '';
                                           AValidaEmpresaImportacao: Boolean = True);

  function RetornaValorImportacaoData(AValor: String;
                                      AOcorrenciaRegistro: String = '';
                                      AOcorrenciasIgnoradas: String = ''): Variant;

  function RetornaValorImportacaoDouble(AValor: String;
                                      AOcorrenciaRegistro: String = '';
                                      AOcorrenciasIgnoradas: String = '';
                                      ACodBco: String = ''): Double;

  function RetornaValorImportacaoString(AValor: String): Variant;

  procedure ApagaRetGerRetDet(ANomeArquivo, ACarteira: String);
  procedure pAtualizaTarifaArqBco(strNumDup, strParcel, strCodCli, strCodEmp, strEspDoc,
                                  strDtaOco, strTarifa: String);
  function fLockedByCurrentConnection(strChaLck: String): Boolean;

  function fBetween(fltValor, fltMinimo, fltMaximo: Double): Boolean;

  function RetornaSeOBancoLancaTarifaNaConfirmacao(AUsaTarifa: Boolean;
                                                   ACodigoBanco,
                                                   AConfiguracaoCarteira: String): Boolean;

  function RetornaDatasetChavesPixPorBanco(ACodigoBanco,
                                           ACodigoEmpresa: String): TUniClientDataset;

  function fTrocaPontoporVirgula(strValor: String): String;

  function RetornaPastaOpenSSL: String;

  function RetornaTimeStampEmMilisegundos: Int64;

  function PegaTimeZone: Integer;

  Function fRetornaTipoRemessa(strAutoInc: String) : Integer;

  function CriaDatasetCnfOco: TUniClientDataset;

Type
  TFuncoesDDA = class
  public
    class var DataInicialDDA: TDateTime;

    class function fAtualizaFornDDA(pgbProgresso: TcxProgressBar = Nil):Boolean;
    class function fUpdAutoIncremCTPDDA(pgbProgresso: TcxProgressBar = Nil): Boolean;

    class procedure AtualizaValorContasPagar(ANumDup: String;
                                             AParcel: String;
                                             ACodEmp: String;
                                             ACodFor: String;
                                             ASerie_: String;
                                             ASeqBai: Integer;
                                             AValor:Double);

    class function ValidaNumeroDuplicataDDA(ADuplicataCTP, ADuplicataDDA: String): Boolean;

    class procedure BaixarMovimentosAnterioresEmAberto(ADatasetRetDDA: TDataset);
  end;

Type
  TBoletoAlpe = class
  private
    MinioConection: TAmazonConnectionInfo;
    StorageMinio: TAmazonStorageService;
    function ImportarArquivo(AName:String):Boolean;
  public
    procedure EnviarArquivoRemessa(AArquivo:String);
    procedure ImportarArquivoRetorno(ACaminho: String);
    constructor Create; overload;
    destructor Destroy; override;

    class function RetornaValorDescontoAlpeDuplicata(ADuplicataCadRec: TDataset): Double;
  end;


implementation

uses untFuncoesSimples, untDesCam, untFuncBancarias, untTIntegracaoPixCitel,
  untIIntegracaoPixCitel, untTypesSistema, untTFuncoesAuxiliaresPix,
  untTBatchSQL.Helper, untTBatchSQL;

{************************************}
{* CARREGA A DLL DINAMICAMENTE E    *}
{* CHAMA A FUNÇÃO PARA CALCULAR O   *}
{* DIGITO.                          *}
{*PS. ESTOU COM FOME                *}
{*********************************AF*}
function fCalcDigito(strCodBco, strNosNum, strBcoIni: String; intCodCar: Integer; strCodEmp: String; dtaDtaGen : TDateTime = 0): String;
Begin

  If (strCodBco = '341') Then
  Begin
    If Length(fStrZero(strNosNum, 8)) <> 8 Then
    Begin
      Result := '';
      Exit;
    End;
  End;

  If strCodBco = '104' Then
  Begin
    If (fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'NUMCART', '', strCodEmp) = '12')   And
       (fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'SISCOB', '', strCodEmp) = 'SIGCB') Then
    Begin
      Result := '';
      Exit;
    end;
  End;

  If dtaDtaGen = 0 Then
    dtaDtaGen := VS_Date;

  Result := fCalcDigitoBco(strCodBco, strNosNum, strBcoIni, intCodCar, strCodEmp, dtaDtaGen);
End;

{************************************}
{* CARREGA A DLL DINAMICAMENTE E    *}
{* CHAMA A FUNÇÃO PARA CALCULAR O   *}
{* NOSSO NUMERO                     *}
{*PS. AINDA ESTOU COM FOME          *}
{*********************************AF*}
function fCalcNossoNumero(strCodBco, strNosNum, strBcoIni: String; intCodCar: Integer; strCodEmp: String): String;
Begin

  If MatchStr(strCodBco, ['341', '995', '964'])Then
  Begin
    If Length(fStrZero(strNosNum, 8)) <> 8 Then
    Begin
      fMensagem('', 'Nosso número deve ter 8 (oito) caracteres, corrija no cadastro de bancos!', ['&Ok']);
      Result := '';
      Exit;
    End;
  End;

  If strCodBco = '104' Then
  Begin
    If (fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'NUMCART', '', strCodEmp) = '12')   And
       (fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'SISCOB', '', strCodEmp) = 'SIGCB') Then
    Begin
      fMensagem('','A Carteira 12 não pode ser utilizada como empresa responsável pela emissão de boletos, corrija nas cofigurações do autban!', ['&OK']);
      Result := '';
      Exit;
    end;
  End;

  Result := fCalcNossoNumeroBco(strCodBco, strNosNum, strBcoIni, intCodCar, strCodEmp, VS_Date);
End;

function fRetLinDig(strCodBco, strNumAge, strCodCar, strNumCon, strCodCed, strNosNum, strVlrTit: String; dtaDtaVen: TDateTime; blnExibMsgErro: Boolean = True):String;
  Var
    strDig001 : String;
    strDig002 : String;
    strDig003 : String;
    strAutCnf : String;
    strDCmpLi : String;
    strCmpLiv : String;
    strFatVen : String;
    strCodBar : String;
    strLinDig : String;

//    fltValTit : Double;

    blnVldDig : Boolean;
Begin

  fVerificaContido(RightStr(Trim(strCodCar), 2), '_11_12_16_17_18_31', 'Carteira');
  if Not fValidaTamanhoString(strNumAge, 'Agência', strCodBco, 04, blnExibMsgErro) Then
  begin
    if Not blnExibMsgErro then
    Begin
      Result := 'Erro/Tamanho do campo Agência inválido/Esperado: 04 Atual: ' + FormatFloat('#00', Length(strNumAge));
      Exit;
    End;
  end;

  //*************************************//
  // COMPOSICAO DO CAMPO LIVRE CART.(12) //
  // (20-30) NOSSO NUMERO,               //
  // (31-34) AGENCIA,                    //
  // (35-42) CEDENTE,                    //
  // (43-44) CARTEIRA                    //
  //**********************************ED*//
  If Pos(RightStr(Trim(strCodCar), 2), '_12') >= 1 Then
  Begin

    strCmpLiv := LeftStr(strNosNum,  11) +
                 LeftStr(strNumAge,  04) +
                 LeftStr(strCodCed,  08) +
                 RightStr(strCodCar, 02);

    strDCmpLi := fCalcDigCmpLiv(strNosNum,
                                strNumAge,
                                strCodCed,
                                strCodCar,
                                '');

    if Not fValidaTamanhoString(strNosNum, 'Nosso Número', strCodBco, 11, blnExibMsgErro) Then
    begin
      if Not blnExibMsgErro then
      Begin
        Result := 'Erro/Tamanho do campo Nosso Número Inválido/Esperado: 11 Atual: ' + FormatFloat('#00', Length(strNosNum));
        Exit;
      End;
    end;

    if Not fValidaTamanhoString(strCodCed, 'Cedente', strCodBco, 08, blnExibMsgErro) Then
    begin
      if Not blnExibMsgErro then
      Begin
        Result := 'Erro/Tamanho do campo Cedente Inválido/Esperado: 08 Atual: ' + FormatFloat('#00', Length(strCodCed));
        Exit;
      End;
    end;

    if Not fValidaTamanhoString(strCodCar, 'Carteira', strCodBco, 02, blnExibMsgErro) Then
    begin
      if Not blnExibMsgErro then
      Begin
        Result := 'Erro/Tamanho do campo Carteira Inválido/Esperado: 02 Atual: ' + FormatFloat('#00', Length(strCodCar));
        Exit;
      End;
    end;

  End


  //*****************************************//
  // COMPOSICAO DO CAMPO LIVRE CART.(16, 18) //
  // VINCULADO A CONVENIOS DE 6 POSICOES     //
  // (20-25) - (06) NUMERO CONVENIO,         //
  // (26-42) - (17) NOSSO NUMERO             //
  // (43-44) - (02) 21 /SERVICO/             //
  //**************************************ED*//
  Else If ( Pos(RightStr(Trim(strCodCar), 2), '_16_18') >= 1 ) And (Length(strNumCon) <= 6) Then
  Begin

    if Not fValidaTamanhoString(strNumCon, 'Número do Convênio', strCodBco, 06, blnExibMsgErro) Then
    begin
      if Not blnExibMsgErro then
      Begin
        Result := 'Erro/Tamanho do campo Número do Convênio Inválido/Esperado: 06 Atual: ' + FormatFloat('#00', Length(strNumCon));
        Exit;
      End;
    end;

    if Not fValidaTamanhoString(strNosNum, 'Nosso Número', strCodBco, 10, blnExibMsgErro) Then
    begin
      if Not blnExibMsgErro then
      Begin
        Result := 'Erro/Tamanho do campo Nosso Número Inválido/Esperado: 10 Atual: ' + FormatFloat('#00', Length(strNosNum));
        Exit;
      End;
    end;

    strCmpLiv := strNumCon + fStrZero(Copy(strNosNum, 1, Length(strNosNum)-1), 17) + '21';

    strDCmpLi := fCalcDigCmpLiv(strCmpLiv, '','', '', '');

  End

  Else If ( Pos(RightStr(Trim(strCodCar), 2), '17') >= 1 ) And (Length(strNumCon) <= 6) Then
  Begin

    if Not fValidaTamanhoString(strNumCon, 'Número do Convênio', strCodBco, 06, blnExibMsgErro) Then
    begin
      if Not blnExibMsgErro then
      Begin
        Result := 'Erro/Tamanho do campo Número do Convênio Inválido/Esperado: 06 Atual: ' + FormatFloat('#00', Length(strNumCon));
        Exit;
      End;
    end;

    if Not fValidaTamanhoString(strNosNum, 'Nosso Número', strCodBco, 12, blnExibMsgErro) Then
    begin
      if Not blnExibMsgErro then
      Begin
        Result := 'Erro/Tamanho do campo Nosso Número Inválido/Esperado: 12 Atual: ' + FormatFloat('#00', Length(strNosNum));
        Exit;
      End;
    end;

    strCmpLiv := LeftStr(strNosNum, 11) + LeftStr(strNumAge, 4) + fStrZero(Copy(strCodCed, 1, Length(strCodCed)-1),8) + fStrZero(StrToInt(strCodCar), 2);

    strDCmpLi := fCalcDigCmpLiv(strCmpLiv, '','', '', '');

  End

  //*************************************************//
  // COMPOSICAO DO CAMPO LIVRE CART.(17)             //
  // VINCULADO A CONVENIOS COM NUMERACAO             //
  // IGUAL OU SUPERIOR A 1.000.000                   //
  // (20-25) ZEROS,                            (06)  //
  // (26-32) NUMERO DO CONVENIO                (07), //
  // (33-42) COMPLEMENTO DO NOSSO NUMERO(S/DV) (10), //
  // (43-44) CARTEIRA/MODALIDADE DE COBRANCA   (02)  //
  //**********************************************ED*//
  Else If ( Pos (RightStr(Trim(strCodCar), 2), '_11_17') >= 1 ) And (Length(strNumCon) >= 7) Then
  Begin

    if Not fValidaTamanhoString(strNosNum, 'Nosso Número', strCodBco, 10, blnExibMsgErro) Then
    begin
      if Not blnExibMsgErro then
      Begin
        Result := 'Erro/Tamanho do campo Nosso Número Inválido/Esperado: 10 Atual: ' + FormatFloat('#00', Length(strNosNum));
        Exit;
      End;
    end;

    if Not fValidaTamanhoString(strNumCon, 'Número do convênio', strCodBco, 07, blnExibMsgErro) Then
    begin
      if Not blnExibMsgErro then
      Begin
        Result := 'Erro/Tamanho do campo Número do Convênio Inválido/Esperado: 07 Atual: ' + FormatFloat('#00', Length(strNumCon));
        Exit;
      End;
    end;

    if Not fValidaTamanhoString(strCodCar, 'Carteira', strCodBco, 02, blnExibMsgErro) Then
    begin
      if Not blnExibMsgErro then
      Begin
        Result := 'Erro/Tamanho do campo Carteira Inválido/Esperado: 02 Atual: ' + FormatFloat('#00', Length(strCodCar));
        Exit;
      End;
    end;

    strCmpLiv := '000000' + strNumCon + LeftStr(Trim(strNosNum), 10) + RightStr(strCodCar, 2);
    strDCmpLi := fCalcDigCmpLiv(strCmpLiv, '', '', '', '');
  End

  //*************************************************//
  // COMPOSICAO DO CAMPO LIVRE CART.(18)             //
  // VINCULADO A CONVENIOS COM NUMERACAO             //
  // IGUAL OU SUPERIOR A 1.000.000                   //
  // (20-25) ZEROS,                            (06)  //
  // (26-32) NUMERO DO CONVENIO                (07), //
  // (33-42) COMPLEMENTO DO NOSSO NUMERO(S/DV) (10), //
  // (43-44) CARTEIRA/MODALIDADE DE COBRANCA   (02)  //
  //**********************************************ED*//
  Else If ( Pos (RightStr(Trim(strCodCar), 2), '18_31_') >= 1 ) And (Length(strNumCon) >= 7) Then
  Begin

    if Not fValidaTamanhoString(strNosNum, 'Nosso Número', strCodBco, 10, blnExibMsgErro) Then
    begin
      if Not blnExibMsgErro then
      Begin
        Result := 'Erro/Tamanho do campo Nosso Número Inválido/Esperado: 10 Atual: ' + FormatFloat('#00', Length(strNosNum));
        Exit;
      End;
    end;

    if Not fValidaTamanhoString(strNumCon, 'Número do convênio', strCodBco, 07, blnExibMsgErro) Then
    begin
      if Not blnExibMsgErro then
      Begin
        Result := 'Erro/Tamanho do campo Número do Convênio Inválido/Esperado: 07 Atual: ' + FormatFloat('#00', Length(strNumCon));
        Exit;
      End;
    end;

    if Not fValidaTamanhoString(strCodCar, 'Carteira', strCodBco, 02, blnExibMsgErro) Then
    begin
      if Not blnExibMsgErro then
      Begin
        Result := 'Erro/Tamanho do campo Carteira Inválido/Esperado: 02 Atual: ' + FormatFloat('#00', Length(strCodCar));
        Exit;
      End;

    end;

    strCmpLiv := '000000' + strNumCon + RightStr(Trim(strNosNum), 10) + RightStr(strCodCar, 2);  
    strDCmpLi := fCalcDigCmpLiv(strCmpLiv, '', '', '', '');
  End;

  //*********************************************************************//
  //                                                                     //
  // FOI ESTIPULADO PELA FEBRABAN UMA DATA BASE PARA CALCULO DO FATOR DE //
  // VENCIMENTO, A DATA BASE É (07/10/1997) CONSTANTE. PARA CALCULO DO   //
  // FATOR DE VENCIMENTO, DEVE SE SUBTRAIR DA DATA DE VENCIMENTO, A DATA //
  // BASE E ENTAO SE OBTEM UM VALOR INTEIRO INDICANDO A QUANTOS DIAS DA  //
  // DATA BASE ESTAMOS  EX.                                              //
  //                                                                     //
  //                    23/12/2006 - 07/10/1997 = 3364                   //
  //                                                                     //
  //******************************************************************ED*//
  strFatVen := CalcularFatorVencimento(dtaDtaVen);

//  strVlrTit := AnsiReplaceStr(strVlrTit, '.', ',');
//  fltValTit := fStrToFloat(strVlrTit);
  strVlrTit := fPadL(FloatToStr(fFormataFloat(fStrToFloat(strVlrTit), 02) * 100), 14, '0');
  strVlrTit := RightStr(strVlrTit, 10);

  Try
    //*************************************************//
    // CODIGO DO BANCO + MOEDA + 5 PRIMEIROS DO CAMPO  //
    // LIVRE                                           //
    //**********************************************ED*//
    strDig001 := fGePriDig(strCodBco,
                           '9',
                           LeftStr(strCmpLiv, 5));

    //*************************************************//
    // POSICAO DE 6 A 15 DO CAMPO LIVRE                //
    //**********************************************ED*//
    strDig002 := fGeSegDig(Copy(strCmpLiv, 6, 10), '');


    //*************************************************//
    // POSICAO DE 16 A 25 DO CAMPO LIVRE               //
    //**********************************************ED*//
    strDig003 := fGeTerDig( Copy(strCmpLiv, 16, 10), strDCmpLi);


    //*************************************************//
    // CALCULA DIGITO DE AUTO CONFERENCIA              //
    //**********************************************ED*//
    strAutCnf := fGeDigAut(strCodBco,
                           '9',
                           strFatVen,
                           strVlrTit,
                           strCmpLiv,
                           '',
                           '',
                           '');

    blnVldDig := True;

  Except
    blnVldDig := False;
  End;

  If blnVldDig Then
  Begin
    {*********************}
    { CODIGO DE BARRAS   *}
    {******************JB*}
    strCodBar := strCodBco + // IDENTIFICACAO DO BANCO
                 '9'       + // MOEDA
                 strAutCnf + // DIGITO DE AUTO-CONFERENCIA
                 strFatVen + // FATOR DE VENCIMENTO
                 strVlrTit + // VALOR DO TITULO
                 strCmpLiv;  // STRING CONTENDO O CAMPO LIVRE (25C)

    //*************************************************//
    // LINHA DIGITAVEL                                 //
    //**********************************************ED*//
    strLinDig := strCodBco               + // IDENTIFICACAO DO BANCO
                 '9'                     + // MOEDA
                 LeftStr(strCmpLiv ,5)   + // 5 PRIMEIRAS DO CAMPO LIVRE
                 strDig001               + // DIGITO DO PRIMEIRO CAMPO
                 Copy(strCmpLiv, 6, 10)  + // POSICAO 6 C/ (10C) DO CAMPO LIVRE
                 strDig002               + // DIGITO DO SEGUNDO CAMPO
                 Copy(strCmpLiv, 16, 10) + // POSICAO 6 C/ (10C) DO CAMPO LIVRE
                 strDig003               + // DIGITO DO TERCEIRO CAMPO
                 strAutCnf               + // DIGITO DE AUTO-CONFERENCIA
                 strFatVen               + // FATOR DE VENCIMENTO
                 strVlrTit;                // VALOR DO TITULO
    Result := strLinDig;

  End
  Else
    Result := '';

End;

function fCalcDigCmpLiv(strVlrFix, NosNum, NumAge, CodCed, strVlrFx1: String): String;
  Var

    intNumero, intResul1, intI: Integer;
    arrConsta: Array [1..24] Of Integer;
    strOrigin: String;

begin

  arrConsta[1]  := 9;
  arrConsta[2]  := 8;
  arrConsta[3]  := 7;
  arrConsta[4]  := 6;
  arrConsta[5]  := 5;
  arrConsta[6]  := 4;
  arrConsta[7]  := 3;
  arrConsta[8]  := 2;
  arrConsta[9]  := 9;
  arrConsta[10] := 8;
  arrConsta[11] := 7;
  arrConsta[12] := 6;
  arrConsta[13] := 5;
  arrConsta[14] := 4;
  arrConsta[15] := 3;
  arrConsta[16] := 2;
  arrConsta[17] := 9;
  arrConsta[18] := 8;
  arrConsta[19] := 7;
  arrConsta[20] := 6;
  arrConsta[21] := 5;
  arrConsta[22] := 4;
  arrConsta[23] := 3;
  arrConsta[24] := 2;


  strOrigin := strVlrFix + NosNum + NumAge + CodCed + strVlrFx1;
  intResul1 := 0;

  For IntI := 1 To 24 Do
  Begin
    intNumero := StrtoInt(Copy(strOrigin, intI, 1));
    intResul1 := intResul1 + (arrConsta[intI] * IntNumero);
  End;

  intResul1 := intResul1 Mod 11;


  If ((intResul1 <> 0) And (intResul1 <> 1) And (intResul1 <> 10)) Then
    intResul1 := 11 - intResul1
  Else
    intResul1 := 1;

  Result := InttoStr(intResul1);

end;

function fValidaTamanhoString(strDigito, strNomPar, strIdeBan: String; intTamanh: Integer; blnExibeMsgErro: Boolean = True): Boolean;
begin

  Result := True;

  Try

    If Length(strDigito) < intTamanh Then
    Begin
      If blnExibeMsgErro then
      Begin
        pCriarFormularios(tfrmDesCam, frmDesCam);
        Try
          frmDesCam.strNomPar      := strNomPar;
          frmDesCam.strTamCam      := IntToStr(intTamanh);
          frmDesCam.edtVlrInf.Text := strDigito;
          frmDesCam.ShowModal;
        Finally
          FreeAndNil(frmDesCam);
        End;
      End;
      Result := False;

    End;

  Except
    Result := False;
  End;

End;

function fVerificaContido(strOrigem, strContid, strNomStr: String): Boolean;
begin

  Try
    Result := True;

    If Pos(strOrigem, strContid) = 0 Then
    Begin

      fMensagem('',strNomStr + ' ( ' + strOrigem + ' ) deve estar contido na string ( ' +
                 strContid + ' )!', ['&O K']);

      Result := False;
    End;

  Except
    Result := False;
  End;

end;

function fGePriDig(strBanco1, strMoeda1, strCedent: String): String;
  Var
    arrConsta: Array [1..9] Of Integer;
    strOrigin: String;
    intI, intResul1, intNumero: Integer;

begin

  arrConsta[1] := 2;
  arrConsta[2] := 1;
  arrConsta[3] := 2;
  arrConsta[4] := 1;
  arrConsta[5] := 2;
  arrConsta[6] := 1;
  arrConsta[7] := 2;
  arrConsta[8] := 1;
  arrConsta[9] := 2;

  strOrigin := strBanco1 + strMoeda1 + strCedent;
  intResul1 := 0;

  For IntI := 1 To 9 Do
  Begin

    intNumero := StrtoInt(Copy(strOrigin, intI, 1));

    If (arrConsta[intI] * intNumero) > 9 Then
    Begin
      intResul1 := intResul1 + StrToInt(RightStr(IntToStr(arrConsta[intI] * IntNumero), 1));
      intResul1 := intResul1 + StrToInt(LeftStr(IntToStr(arrConsta[intI] * IntNumero), 1));
    End
    Else
      intResul1 := intResul1 + (arrConsta[intI] * IntNumero);

  End;

  intResul1 := intResul1 Mod 10;
  If intResul1 <> 0 Then intResul1 := 10 - intResul1;
  Result := InttoStr(intResul1);

end;

function fGeSegDig(strCedent, strNumDup:String): String;
  Var
    arrConsta: Array [1..10] Of Integer;
    strOrigin: String;
    intI, intResul1, intNumero: Integer;
begin

  arrConsta[1]  := 1;
  arrConsta[2]  := 2;
  arrConsta[3]  := 1;
  arrConsta[4]  := 2;
  arrConsta[5]  := 1;
  arrConsta[6]  := 2;
  arrConsta[7]  := 1;
  arrConsta[8]  := 2;
  arrConsta[9]  := 1;
  arrConsta[10] := 2;

  strOrigin := strCedent + strNumDup;
  intResul1 := 0;

  For IntI := 1 To 10 Do
  Begin
    intNumero := StrtoInt(Copy(strOrigin, intI, 1));

    If (arrConsta[intI] * intNumero) > 9 Then
    Begin
      intResul1 := intResul1 + StrToInt(RightStr(IntToStr(arrConsta[intI] * IntNumero), 1));
      intResul1 := intResul1 + StrToInt(LeftStr(IntToStr(arrConsta[intI] * IntNumero), 1));
    End
    Else
      intResul1 := intResul1 + (arrConsta[intI] * IntNumero);

  End;

  intResul1 := intResul1 Mod 10;
  If intResul1 <> 0 Then intResul1 := 10 - intResul1;
  Result := InttoStr(intResul1);

end;

function fGeTerDig(strNumAge, strCodCed:String): String;
  Var
    arrConsta: Array [1..10] Of Integer;
    strOrigin: String;
    intI, intResul1, intNumero: Integer;
begin

  arrConsta[1]   := 1;
  arrConsta[2]   := 2;
  arrConsta[3]   := 1;
  arrConsta[4]   := 2;
  arrConsta[5]   := 1;
  arrConsta[6]   := 2;
  arrConsta[7]   := 1;
  arrConsta[8]   := 2;
  arrConsta[9]   := 1;
  arrConsta[10]  := 2;

  strOrigin := strNumAge + strCodCed;
  intResul1 := 0;

  For IntI := 1 To 10 Do
  Begin

    intNumero := StrtoInt(Copy(strOrigin, intI, 1));

    If (arrConsta[intI] * intNumero) > 9 Then
    Begin
      intResul1 := intResul1 + StrToInt(RightStr(IntToStr(arrConsta[intI] * IntNumero), 1));
      intResul1 := intResul1 + StrToInt(LeftStr(IntToStr(arrConsta[intI] * IntNumero), 1));
    End
    Else
      intResul1 := intResul1 + (arrConsta[intI] * IntNumero);

  End;

  intResul1 := intResul1 Mod 10;
  If intResul1 <> 0 Then intResul1 := 10 - intResul1;
  Result    := InttoStr(intResul1);

end;

function fTemNaCadCbi(strNumDup, strEspDoc, strParcel, strCodEmp, strCodCli, strCodBco: String): Boolean;
Var
  strSQL: String;
  qryCadCbi: TUniQuery;
begin
  qryCadCbi := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + ' SELECT COUNT(*) AS QTD ';
  strSQL := strSQL + ' FROM CADCBI ';
  strSQL := strSQL + ' WHERE CBI_NUMDUP = :NUMDUP ';
  strSQL := strSQL + '       AND CBI_ESPDOC = :ESPDOC ';
  strSQL := strSQL + '       AND CBI_PARCEL = :PARCEL ';
  strSQL := strSQL + '       AND CBI_CODEMP = :CODEMP ';
  strSQL := strSQL + '       AND CBI_CODCLI = :CODCLI ';

  IF not fEmptyStr(strCodBco) then
    strSQL := strSQL + '       AND CBI_CODBCO = :CODBCO ';

  With qryCadCbi Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMDUP').AsString := strNumDup;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('PARCEL').AsString := strParcel;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('CODCLI').AsString := strCodCli;

    IF not fEmptyStr(strCodBco) then
      ParamByName('CODBCO').AsString := strCodBco;

    Open;

    Result := FieldByName('QTD').AsInteger > 0;
  End;

  FreeAndNil(qryCadCbi);
end;

function fGeDigAut(Banco1, Moeda1, FatVen, VlrDup, CodCar, NosNum, NumAge, CodCed: String): String;
  Var

    intNumero, intResul1, intI: Integer;
    arrConsta: Array [1..43] Of Integer;
    strOrigin: String;

begin

  arrConsta[1]  := 4;
  arrConsta[2]  := 3;
  arrConsta[3]  := 2;
  arrConsta[4]  := 9;
  arrConsta[5]  := 8;
  arrConsta[6]  := 7;
  arrConsta[7]  := 6;
  arrConsta[8]  := 5;
  arrConsta[9]  := 4;
  arrConsta[10] := 3;
  arrConsta[11] := 2;
  arrConsta[12] := 9;
  arrConsta[13] := 8;
  arrConsta[14] := 7;
  arrConsta[15] := 6;
  arrConsta[16] := 5;
  arrConsta[17] := 4;
  arrConsta[18] := 3;
  arrConsta[19] := 2;
  arrConsta[20] := 9;
  arrConsta[21] := 8;
  arrConsta[22] := 7;
  arrConsta[23] := 6;
  arrConsta[24] := 5;
  arrConsta[25] := 4;
  arrConsta[26] := 3;
  arrConsta[27] := 2;
  arrConsta[28] := 9;
  arrConsta[29] := 8;
  arrConsta[30] := 7;
  arrConsta[31] := 6;
  arrConsta[32] := 5;
  arrConsta[33] := 4;
  arrConsta[34] := 3;
  arrConsta[35] := 2;
  arrConsta[36] := 9;
  arrConsta[37] := 8;
  arrConsta[38] := 7;
  arrConsta[39] := 6;
  arrConsta[40] := 5;
  arrConsta[41] := 4;
  arrConsta[42] := 3;
  arrConsta[43] := 2;

  strOrigin := Banco1 + Moeda1 + FatVen + VlrDup + CodCar + NosNum + NumAge + CodCed;
  intResul1 := 0;

  For IntI := 1 To 43 Do
  Begin
    intNumero := StrtoInt(Copy(strOrigin, intI, 1));
    intResul1 := intResul1 + (arrConsta[intI] * IntNumero);
  End;

  intResul1 := intResul1 Mod 11;

  If ((intResul1 <> 0) And (intResul1 <> 1) And (intResul1 <> 10)) Then
    intResul1 := 11 - intResul1
  Else
    intResul1 := 1;

  Result := InttoStr(intResul1);

end;

function fBetween(fltValor, fltMinimo, fltMaximo: Double): Boolean;
Begin
  Result := (fltValor >= fltMinimo) And
            (fltValor <= fltMaximo);
End;

//Atualiza o AutoIncrem da CADPAG na RETDDA AJ
class function TFuncoesDDA.fUpdAutoIncremCTPDDA(pgbProgresso: TcxProgressBar = Nil): Boolean;
  Var
    strSQL: String;
    qryCadPag: TUniQuery;
    qryRetDDa: TUniQuery;

    LFornecedores : String;

    LDataVencimentoInicial,
    LDataVencimentoFinal : TDateTime;


    LDiferenca,
    LTolerancia : Double;
Begin
  Result    := True;
  qryRetDDa := fCriaQuery(Nil);
  LTolerancia := fFormataFloat(fCfgSis('OSCDDA',varDouble),2);

  Try

    qryRetDDa.Close;
    qryRetDDa.SQL.Clear;
    qryRetDDa.SQL.Add('SELECT RETDDA.*,                    ');
    qryRetDDa.SQL.Add('  CONCAT(IFNULL(DDA_CODFOR,""),"_",IFNULL(DDA_CODFIL,"")) AS FORNECEDORES ');
    qryRetDDa.SQL.Add('FROM RETDDA                         ');
    qryRetDDa.SQL.Add('WHERE DDA_DTABAI IS NULL            ');

    If TFuncoesDDA.DataInicialDDA > 0 Then
    Begin
      qryRetDDa.SQL.Add('  AND DDA_DTAARQ>=:DTAARQ ');
      qryRetDDa.ParamByName('DTAARQ').AsDateTime := TFuncoesDDA.DataInicialDDA;
    End;

    qryRetDDa.SQL.Add('  AND (DDA_AUTCTP IS NULL OR DDA_AUTCTP = "") ');
    qryRetDDa.SQL.Add('  AND DDA_DTAVEN IS NOT NULL ');
    qryRetDDa.SQL.Add('  AND IF(IFNULL(DDA_CODFOR, "") = "",IF(IFNULL(DDA_CODFIL, "") = "",FALSE,TRUE),TRUE) ');
    qryRetDDa.SQL.Add('ORDER BY DDA_DTAVEN, DDA_CODFIL     ');
    qryRetDDa.Open;

    If Not qryRetDDa.IsEmpty Then
    Begin
      Try
        fStartTransaction;
        pgbProgresso.Position := 0;
        pgbProgresso.Properties.Max := qryRetDDa.RecordCount;


        qryRetDDA.First;
        LDataVencimentoInicial := qryRetDDa.FieldByName('DDA_DTAVEN').AsDateTime;

        qryRetDDA.Last;
        LDataVencimentoFinal := qryRetDDa.FieldByName('DDA_DTAVEN').AsDateTime;


        strSQL := '';
        strSQL := strSQL + 'SELECT DISTINCT P.AUTOINCREM, P.CTP_NUMDUP * 1 AS DUP, FOR_C_G_C_,      ';
        strSQL := strSQL + '       P.CTP_CODEMP,                                                    ';
        strSQL := strSQL + '       P.CTP_NUMDUP,                                                    ';
        strSQL := strSQL + '       P.CTP_PARCEL,                                                    ';
        strSQL := strSQL + '       P.CTP_SERIE_,                                                    ';
        strSQL := strSQL + '       "N" AS CTP_MARDES,                                               ';
        strSQL := strSQL + '       P.CTP_DTAVEN,                                                    ';
        strSQL := strSQL + '       P.CTP_SEQBAI,                                                    ';
        strSQL := strSQL + '       P.CTP_CODFOR,                                                    ';
        strSQL := strSQL + '       P.CTP_VALORI                                                     ';
        strSQL := strSQL + 'FROM CADPAG P                                                           ';
        strSQL := strSQL + 'JOIN CADFOR F ON F.FOR_CODFOR=P.CTP_CODFOR                              ';
        strSQL := strSQL + '  LEFT JOIN RETDDA                                                      ';
        strSQL := strSQL + '    ON DDA_AUTCTP = P.AUTOINCREM                                        ';
        strSQL := strSQL + 'WHERE P.CTP_DTAVEN BETWEEN :DTAINI                                      ';
        strSQL := strSQL + '  AND :DTAFIM                                                           ';
        strSQL := strSQL + '  AND P.CTP_DTAPAG IS NULL                                              ';
        strSQL := strSQL + '  AND DDA_AUTCTP IS NULL                                                ';
        strSQL := strSQL + '  AND P.CTP_SEQBAI = 0                                                  ';
        strSQL := strSQL + 'ORDER BY P.CTP_DTAVEN                                                   ';

        qryCadPag := fCriaQuery(Nil);
        qryCadPag.SQL.Text := strSQL;
        qryCadPag.ParamByName('DTAINI').AsDateTime := LDataVencimentoInicial;
        qryCadPag.ParamByName('DTAFIM').AsDateTime := LDataVencimentoFinal;
        qryCadPag.Open;

        If Not qryCadPag.IsEmpty Then
        Begin
          pSetaClient(qryCadPag);
          qryRetDDA.First;

          While not qryRetDDa.Eof Do
          Begin

            LFornecedores := fRetStrToSQLIn(qryRetDDA.FieldByName('FORNECEDORES').AsString);

            qryCadPag.Filtered := False;
            qryCadPag.Filter   := 'CTP_DTAVEN=' + QuotedStr(qryRetDDA.FieldByName('DDA_DTAVEN').AsString) + ' AND ' +
                                  'CTP_CODFOR IN(' + LFornecedores + ')';

            qryCadPag.Filtered := True;

            qryCadPag.First;
            While not qryCadPag.Eof Do
            Begin

              If qryCadPag.FieldByName('CTP_MARDES').AsString.Equals('S') Then
              Begin
                qryCadPag.Next;
                Continue;
              End;

              LDiferenca := fFormataFloat(qryRetDDa.FieldByName('DDA_VALTIT').AsFloat -  qryCadPag.FieldByName('CTP_VALORI').AsFloat,2);

              If fBetween(LDiferenca, -LTolerancia, LTolerancia) Then
              Begin
                Try
                  qryRetDDa.Edit;
                  qryRetDDa.FieldByName('DDA_AUTCTP').AsString := qryCadPag.FieldByName('AUTOINCREM').AsString;
                  qryRetDDa.FieldByName('DDA_CODEMP').AsString := qryCadPag.FieldByName('CTP_CODEMP').AsString;

                  qryRetDDa.FieldByName('DDA_CODFOR').AsString := qryCadPag.FieldByName('CTP_CODFOR').AsString;

                  qryRetDDa.FieldByName('DDA_NUMDUP').AsString := qryCadPag.FieldByName('CTP_NUMDUP').AsString +
                                                                  qryCadPag.FieldByName('CTP_PARCEL').AsString +
                                                                  qryCadPag.FieldByName('CTP_SERIE_').AsString +
                                                                  qryCadPag.FieldByName('CTP_SEQBAI').AsString;

                  qryRetDDa.Post;
                Except
                  On E: Exception Do
                  Begin
                    If E.Message.Contains('Duplicate entry') Then
                    Begin
                      //Para Registros já importados e vinculados
                      qryRetDDa.Cancel;
                      qryRetDDa.Delete;

                      Continue;
                    End
                    Else
                      Raise E;
                  End;
                End;

                TFuncoesDDA.BaixarMovimentosAnterioresEmAberto(qryRetDDa);

                If fFormataFloat(LDiferenca,2) <> 0 Then
                  TFuncoesDDA.AtualizaValorContasPagar(qryCadPag.FieldByName('CTP_NUMDUP').AsString, qryCadPag.FieldByName('CTP_PARCEL').AsString,
                                                qryCadPag.FieldByName('CTP_CODEMP').AsString, qryCadPag.FieldByName('CTP_CODFOR').AsString,
                                                qryCadPag.FieldByName('CTP_SERIE_').AsString, qryCadPag.FieldByName('CTP_SEQBAI').AsInteger,
                                                qryRetDDa.FieldByName('DDA_VALTIT').AsFloat);

                qryCadPag.Edit;
                qryCadPag.FieldByName('CTP_MARDES').AsString := 'S';
                qryCadPag.Post;

              End;
              qryCadPag.Next;
            End;

            qryRetDDa.Next;
            pStep(pgbProgresso);
          End;


        End;

        fCommit;
      Except
        On e: Exception do
        Begin
          fRollBack;
          Result := False;
          pMensagensErro('Ocorreu o seguinte erro ao vincular as duplicatas: '+ E.Message, '[fUpdAutoIncremCTPDDA]');
        End;
      End;
    End;

  Finally
    qryRetDDa.Close;
    FreeAndNil(qryRetDDa);
  End;
End;

class procedure TFuncoesDDA.AtualizaValorContasPagar(ANumDup: String;
                                                     AParcel: String;
                                                     ACodEmp: String;
                                                     ACodFor: String;
                                                     ASerie_: String;
                                                     ASeqBai: Integer;
                                                     AValor:Double);
  Var
    LCadPag : TUniQuery;
    LSql: String;
begin
  Try
    LCadPag := fCriaQuery(Nil);

    LSql := LSql + 'UPDATE                        ';
    LSql := LSql + '  CADPAG                      ';
    LSql := LSql + 'SET                           ';
    LSql := LSql + '  CTP_VALORI = :VALORI,       ';
    LSql := LSql + '  CTP_VALDUP = :VALDUP        ';
    LSql := LSql + 'WHERE CTP_NUMDUP = :NUMDUP    ';
    LSql := LSql + '  AND CTP_PARCEL = :PARCEL    ';
    LSql := LSql + '  AND CTP_SERIE_ = :SERIE_    ';
    LSql := LSql + '  AND CTP_CODEMP = :CODEMP    ';
    LSql := LSql + '  AND CTP_CODFOR = :CODFOR    ';
    LSql := LSql + '  AND CTP_SEQBAI = :SEQBAI    ';

    Try
      LCadPag.Close;
      LCadPag.Sql.Clear;
      LCadPag.Sql.Add(LSql);

      LCadPag.ParamByName('VALORI').AsFloat    :=  AValor;
      LCadPag.ParamByName('VALDUP').AsFloat    :=  AValor;

      LCadPag.ParamByName('NUMDUP').AsString   := ANumDup;
      LCadPag.ParamByName('PARCEL').AsString   := AParcel;
      LCadPag.ParamByName('SERIE_').AsString   := ASerie_;
      LCadPag.ParamByName('CODEMP').AsString   := ACodEmp;
      LCadPag.ParamByName('CODFOR').AsString   := ACodFor;
      LCadPag.ParamByName('SEQBAI').AsInteger  := ASeqBai;

      LCadPag.ExecSQL;
    Except
      On E: Exception Do
      Begin
        Raise  Exception.Create(E.Message);
      End;
    End;

  Finally
    FreeAndNil(LCadPag);
  End;
End;

class function TFuncoesDDA.ValidaNumeroDuplicataDDA(ADuplicataCTP,
  ADuplicataDDA: String): Boolean;
begin
  ADuplicataDDA := fRetSomenteNumeros(ADuplicataDDA);
  ADuplicataCTP := fRetSomenteNumeros(ADuplicataCTP);

  Result := Not ADuplicataCTP.IsEmpty;
  If Result Then
    Result := Not ADuplicataDDA.IsEmpty;

  If Not Result Then
    Exit;

  If RightStr(ADuplicataCTP, Length(ADuplicataDDA)) <> ADuplicataDDA Then
  Begin
    Try
      ADuplicataDDA := StrToInt(ADuplicataDDA).ToString;
      ADuplicataCTP := StrToInt(ADuplicataCTP).ToString;
    Except
      // se der erro na conversão valida do jeito que está
    End;

    Result := Pos(ADuplicataDDA, ADuplicataCTP) > 0;

    If Not Result Then
      Result := Pos(ADuplicataCTP, ADuplicataDDA) > 0;
  End;
end;

class procedure TFuncoesDDA.BaixarMovimentosAnterioresEmAberto(
  ADatasetRetDDA: TDataset);
  Var
    LConsultaRetDDA: TUniQuery;
begin
  LConsultaRetDDA := fCriaQuery;

  Try
    LConsultaRetDDA.SQL.Text := 'SELECT * ' +
                                'FROM RETDDA ' +
                                'WHERE DDA_CNPCPF=:CNPCPF ' +
                                '  AND DDA_CNPJ__=:CNPJ__ ' +
                                '  AND DDA_CODBCO=:CODBCO ' +
                                '  AND DDA_CODEMP=:CODEMP ' +
                                '  AND DDA_DTAVEN=:DTAVEN ' +
                                '  AND DDA_DTAARQ BETWEEN :DTAINI AND :DTAFIN ' +
                                '  AND DDA_NUMDUP LIKE :NUMDUP ' +
                                '  AND DDA_DTABAI IS NULL ';

    LConsultaRetDDA.ParamByName('CNPCPF').AsString := ADatasetRetDDA.FieldByName('DDA_CNPCPF').AsString;
    LConsultaRetDDA.ParamByName('CNPJ__').AsString := ADatasetRetDDA.FieldByName('DDA_CNPJ__').AsString;
    LConsultaRetDDA.ParamByName('CODBCO').AsString := ADatasetRetDDA.FieldByName('DDA_CODBCO').AsString;
    LConsultaRetDDA.ParamByName('CODEMP').AsString := ADatasetRetDDA.FieldByName('DDA_CODEMP').AsString;
    LConsultaRetDDA.ParamByName('DTAVEN').AsDateTime := ADatasetRetDDA.FieldByName('DDA_DTAVEN').AsDateTime;
    LConsultaRetDDA.ParamByName('NUMDUP').AsString := ADatasetRetDDA.FieldByName('DDA_NUMDUP').AsString + '%';

    LConsultaRetDDA.ParamByName('DTAINI').AsDateTime := ADatasetRetDDA.FieldByName('DDA_DTAEMI').AsDateTime;
    LConsultaRetDDA.ParamByName('DTAFIN').AsDateTime := IncDay(ADatasetRetDDA.FieldByName('DDA_DTAARQ').AsDateTime, -1);

    LConsultaRetDDA.Open;

    If LConsultaRetDDA.IsEmpty Then
      Exit;

    While Not LConsultaRetDDA.Eof Do
    Begin
      LConsultaRetDDA.Edit;
      LConsultaRetDDA.FieldByName('DDA_DTABAI').AsDateTime := VS_Date;
      LConsultaRetDDA.FieldByName('DDA_HORBAI').AsDateTime := fRetHoraServidor;
      LConsultaRetDDA.FieldByName('DDA_OPEBAI').AsString := strLoginUsuarioLogado;
      LConsultaRetDDA.FieldByName('DDA_TIPBAI').AsString := 'Baixa Direta';
      LConsultaRetDDA.FieldByName('DDA_HIST01').AsString := 'Reevio Duplicata';

      LConsultaRetDDA.Post;

      LConsultaRetDDA.Next;
    End;
  Finally
    LConsultaRetDDA.Close;

    FreeAndNil(LConsultaRetDDA);
  End;
end;

class function TFuncoesDDA.fAtualizaFornDDA(pgbProgresso: TcxProgressBar = Nil): Boolean;
Var
  LCodigoFornecedor,
  LCodigoFiliais,
  LCNPJAnterior: String;

  LConsultaDDA,
  LConsultaFornecedor: TUniQuery;

  LBatchSQL: TBatchSQL;
  LQueryExec: TUniQuery;

  function RetornaUpdate: String;
  Begin
    Result := 'UPDATE      '+
              '  RETDDA    '+
              'SET         ';

    If Not LCodigoFornecedor.IsEmpty Then
      Result := Result + '  DDA_CODFOR = :CODFOR ';

    If Not LCodigoFiliais.IsEmpty Then
    Begin
      If Not LCodigoFornecedor.IsEmpty Then
        Result := Result  + ',';
      Result := Result + ' DDA_CODFIL = :CODFIL ';
    End;

    Result :=  Result  + ' WHERE DDA_CNPCPF = :CNPCPF     '+
                         '  AND DDA_CNPJ__ = :CNPJ__      '+
                         '  AND DDA_CODBCO = :CODBCO      '+
                         '  AND DDA_CODEMP = :CODEMP      '+
                         '  AND DDA_DTAARQ = :DTAARQ      '+
                         '  AND DDA_DTAVEN = :DTAVEN      '+
                         '  AND DDA_NUMDUP = :NUMDUP      '+
                         '  AND DDA_CODMOV = :CODMOV      ';
  End;


begin
  Result := True;

  LConsultaDDA := fCriaQuery;
  LQueryExec := fCriaQuery;
  LBatchSQL := TBatchHelper.CreateBatchSQL(LQueryExec);

  LConsultaFornecedor := fCriaQuery;
  LConsultaFornecedor.SQL.Text := 'SELECT FOR_CODFOR FROM CADFOR WHERE FOR_CGCCPF="1" AND FOR_C_G_C_ LIKE :INICIO';

  Try
    Try

      // Configura progresso
      LBatchSQL.OnProgress :=
        procedure(Sender: TObject; ACurrent, ATotal: Integer)
        begin
          if Assigned(pgbProgresso) then
          begin
            pgbProgresso.Position := ACurrent;
            pgbProgresso.Properties.Max := ATotal;
            Application.ProcessMessages;
          end;
        end;

      LConsultaDDA.SQL.Text := 'SELECT * FROM RETDDA ' +
                               ' WHERE DDA_AUTCTP IS NULL ' +
                               ' AND (DDA_CODFOR IS NULL ' +
                               '  OR DDA_CODFOR = "" ' +
                               '  OR DDA_CODFIL IS NULL ' +
                               '  OR DDA_CODFIL = "") ' +
                               ' AND DDA_DTABAI IS NULL ' +
                               ' ORDER BY DDA_CNPJ__';
      LConsultaDDA.Open;

      LCNPJAnterior := EmptyStr;

      if Assigned(pgbProgresso) then
      begin
        pgbProgresso.Position := 0;
        pgbProgresso.Properties.Max := LConsultaDDA.RecordCount;
      end;

      While Not LConsultaDDA.Eof Do
      Begin
        If Not LCNPJAnterior.Equals(LConsultaDDA.FieldByName('DDA_CNPJ__').AsString) Then
        Begin
          LCNPJAnterior := LConsultaDDA.FieldByName('DDA_CNPJ__').AsString;

          LCodigoFiliais := EmptyStr;

          LCodigoFornecedor := fCampoTabela('FOR_CODFOR',
                                            'CADFOR',
                                            ['FOR_C_G_C_'],
                                            [LConsultaDDA.FieldByName('DDA_CNPJ__').AsString]);

          LConsultaFornecedor.ParamByName('INICIO').AsString := LeftStr(LCNPJAnterior, 8) + '%';
          LConsultaFornecedor.Open;

          LConsultaFornecedor.First;
          While Not LConsultaFornecedor.Eof Do
          Begin
            LCodigoFiliais := LCodigoFiliais + LConsultaFornecedor.FieldByName('FOR_CODFOR').AsString + '_';

            LConsultaFornecedor.Next;
          End;
          LConsultaFornecedor.Close;
        End;

        If Not LCodigoFornecedor.IsEmpty Or Not LCodigoFiliais.IsEmpty Then
        Begin

          LBatchSQL
           .BeginCommand(RetornaUpdate)
           .AddParam('CODFOR', LCodigoFornecedor, ftString)
           .AddParam('CODFIL', LCodigoFiliais, ftString)
           .AddParam('CNPCPF', LConsultaDDA.FieldByName('DDA_CNPCPF').AsString, ftString)
           .AddParam('CNPJ__', LConsultaDDA.FieldByName('DDA_CNPJ__').AsString, ftString)
           .AddParam('CODBCO', LConsultaDDA.FieldByName('DDA_CODBCO').AsString, ftString)
           .AddParam('CODEMP', LConsultaDDA.FieldByName('DDA_CODEMP').AsString, ftString)
           .AddParam('NUMDUP', LConsultaDDA.FieldByName('DDA_NUMDUP').AsString, ftString)
           .AddParam('CODMOV', LConsultaDDA.FieldByName('DDA_CODMOV').AsString, ftString)
           .AddParam('DTAARQ', LConsultaDDA.FieldByName('DDA_DTAARQ').AsDateTime, ftDateTime)
           .AddParam('DTAVEN', LConsultaDDA.FieldByName('DDA_DTAVEN').AsDateTime, ftDateTime)
           .EndCommand;

        End;

        if Assigned(pgbProgresso) then
          pStep(pgbProgresso);

        LConsultaDDA.Next;
      End;

      fStartTransaction;
      try
        if LBatchSQL.Execute then
          fCommit
        else
        begin
          fRollBack;
          Result := False;
        end;
      except
        on E: Exception do
        begin
          fRollBack;
          Result := False;
          Raise Exception.Create('Ocorreu um erro ao atualizar os fornecedores do DDA. ' + #13 +
                                 'Erro gerado: ' + E.Message);
        end;
      end;

    Except
      On E: Exception Do
      Begin
        fRollBack;
        Result := False;
        Raise Exception.Create('Ocorreu um erro ao atualizar os fornecedores do DDA. ' + #13 +
                               'Erro gerado: ' + E.Message);
      End;
    End;
  Finally
    LConsultaDDA.Close;
    FreeAndNil(LConsultaFornecedor);
    FreeAndNil(LConsultaDDA);
    FreeAndNil(LBatchSQL);
    FreeAndNil(LQueryExec);
  End;
end;

{********************************}
{* APAGA REGISTROS RECEBIDOS EM *}
{* IMPORTAÇÃO ANTERIOR DO ARQUI-*}
{* VO DE RETORNO CONTAS A PAGAR *}
{*****************************AJ*}
procedure pDeletaArqBcoContasPagar(strCodBco: String);
  Var
    strSQL: String;
    qryDelete: TUniQuery;
begin

  Try

    qryDelete := fCriaQuery();

    strSQL := '';
    strSQL := strSQL + 'DELETE FROM ';
    strSQL := strSQL + '  RETCTP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  RET_CODBCO = :CODBCO ';

    With qryDelete Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODBCO').AsString := strCodBco;
      ExecSQL;
      Close;
    End;

  Finally
    FreeAndNil(qryDelete);
  End;

end;

{********************************}
{* GRAVA REGISTROS RECEBIDOS EM *}
{* IMPORTAÇÃO ARQUIVO DE RETORNO*}
{* CONTAS A PAGAR               *}
{*****************************AJ*}
procedure pGravaArqBcoContasPagar(strParcel, strNumDup, strCodFor, strCodEmp, strSeqBai, strSerie_,
                                  strCodBco, strBcoFav, strNosNum, strCodOco, strMotOco, strValDup,
                                  strDesCon, strJurMor, strValPag, strDtaVen, strDtaPag, strNomArq,
                                  strAutInc: String;
                                  dtaDtaArq: TDateTime; var qryRetCtp: TUniQuery;
                                  ATipoLayout: String = '');
  Var
    strDtaOco: String;
Begin

  strDtaOco := strDtaPag;

  Try

    qryRetCtp.Insert;

    If Not fEmptyStr(strDtaOco) And (strDtaOco <> '000000') And (strDtaOco <> '00000000') Then
      qryRetCtp.FieldByName('RET_DTAOCO').AsDateTime := StrToDate(strDtaOco) ;//Data Ocorrencia

    If Not fEmptyStr(strDtaVen) And (strDtaVen <> '000000') And (strDtaVen <> '00000000') Then
      qryRetCtp.FieldByName('RET_DTAVEN').AsDateTime := StrToDate(strDtaVen); //Data Vencimento

    If Not fEmptyStr(strDtaPag) And (strDtaPag <> '000000') And (strDtaPag <> '00000000') Then
      qryRetCtp.FieldByName('RET_DTAPAG').AsDateTime := StrToDate(strDtaPag); //Data Credito/Pgto

    If Not fEmptyStr(strDesCon) Then
      qryRetCtp.FieldByName('RET_VALDES').AsFloat := fStrToFloat(strDesCon)/100; //Valor Desconto

    If Not fEmptyStr(strValDup) Then
      qryRetCtp.FieldByName('RET_VALDUP').AsFloat := fStrToFloat(strValDup)/100; // Valor Duplicata

    If Not fEmptyStr(strValPag) Then
      qryRetCtp.FieldByName('RET_VALPAG').AsFloat := fStrToFloat(strValPag)/100;  //Valor Pago

    If Not fEmptyStr(strJurMor) Then
      qryRetCtp.FieldByName('RET_VALJUR').AsFloat := fStrToFloat(strJurMor)/100; //Juros de Mora

    qryRetCtp.FieldByName('RET_CODBCO').AsString := strCodBco; //Banco Cobrador
    qryRetCtp.FieldByName('RET_BCOFAV').AsString := strBcoFav; //Banco Favorecido
    qryRetCtp.FieldByName('RET_CODOCO').AsString := strCodOco; //Cód. Ocorrencia
    qryRetCtp.FieldByName('RET_NOSNUM').AsString := strNosNum; //Nosso Numero
    qryRetCtp.FieldByName('RET_NUMDUP').AsString := strNumDup; //Nº Duplicata
    qryRetCtp.FieldByName('RET_PARCEL').AsString := strParcel; //Parcela da Duplicata
    qryRetCtp.FieldByName('RET_SEQBAI').AsString := strSeqBai; //Sequência da Baixa
    qryRetCtp.FieldByName('RET_SERIE_').AsString := strSerie_; //Serie
    qryRetCtp.FieldByName('RET_CODEMP').AsString := strCodEmp; //Código Empresa
    qryRetCtp.FieldByName('RET_CODFOR').AsString := strCodFor; //Código Cliente
    qryRetCtp.FieldByName('RET_NOMARQ').AsString := strNomArq; //Nome do Arquivo
    qryRetCtp.FieldByName('RET_AUTOIN').AsString := strAutInc; //Auto-Incremento

    If dtaDtaArq <> 0 Then
      qryRetCtp.FieldByName('RET_DTAARQ').AsDateTime := dtaDtaArq; //Data do Arquivo

    If dtaDtaArq <> 0 Then
      qryRetCtp.FieldByName('RET_HORARQ').AsDateTime := dtaDtaArq; //Hora do Arquivo

    If Not fEmptyStr(strMotOco) Then
      qryRetCtp.FieldByName('RET_MOTOCO').AsString   := strMotOco; //Motivo da Ocorrencia

    If Not ATipoLayout.IsEmpty Then
      qryRetCtp.FieldByName('RET_TIPLAY').AsString   := ATipoLayout; //Tipo layout: API

    qryRetCtp.Post;

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;

End;

{********************************}
{* GRAVA AS OCORRÊNCIAS NÃO GRA-*}
{* VADAS NA IMPORTAÇÃO DO ARQUI-*}
{* VO DE RETORNO                *}
{*****************************AJ*}
procedure pIncluiOcor(strNosNum, strCodCli, strNumDup, strEspDoc, strCodEmp: String;
                                 dtaDtaVen, dtaDtaPag: TDate; fltValDup, fltValPag: Double; Var cdsNaoGra: TUniClientDataSet;AMotivo:String = '');
Begin

  if not cdsNaoGra.Active Then
  begin
    cdsNaoGra.CreateDataSet;
    cdsNaoGra.Open;
    cdsNaoGra.EmptyDataSet;
  end;

  cdsNaoGra.Insert;
  cdsNaoGra.FieldByName('NOSNUM').AsString   := strNosNum;
  cdsNaoGra.FieldByName('CODCLI').AsString   := strCodCli;
  cdsNaoGra.FieldByName('NUMDUP').AsString   := strNumDup;
  cdsNaoGra.FieldByName('ESPDOC').AsString   := strEspDoc;
  cdsNaoGra.FieldByName('CODEMP').AsString   := strCodEmp;

  If dtaDtaVen <> 0 Then
    cdsNaoGra.FieldByName('DTAVEN').AsDateTime := dtaDtaVen;

  If dtaDtaPag <> 0 Then
    cdsNaoGra.FieldByName('DTAPAG').AsDateTime := dtaDtaPag;

  cdsNaoGra.FieldByName('VALDUP').AsFloat    := fltValDup;
  cdsNaoGra.FieldByName('VALPAG').AsFloat    := fltValPag;

  If Assigned(cdsNaoGra.FindField('MOTIVO')) Then
    cdsNaoGra.FieldByName('MOTIVO').AsString    := AMotivo;

  cdsNaoGra.Post;
End;

function fRenomeiaArquivo(strNomArq: String): Boolean;
  Var
    strNomArqNovo: String;
    intNumOld    : Integer;

Begin
  intNumOld := 1;

  Repeat

    Result := True;

    If intNumOld = 1 Then
      strNomArqNovo := ChangeFileExt(strNomArq,'.old')
    Else
      strNomArqNovo := ChangeFileExt(strNomArq,'.old' + IntToStr(intNumOld));

    Inc(intNumOld);
  Until Not FileExists(strNomArqNovo);

  If Not RenameFile(strNomArq,strNomArqNovo) Then
  Begin
    fMensagem('','Não foi possível Renomear do arquivo!',['&Ok']);
    Result := False;
  End;

End;

function RetornaOcorrencia(ABanco, AOcorrencia, ACnab: String; AMotivo: String = ''; ADescricaoComMotivo: Boolean = True): String;
var
  AQryOcorrencia: TUniQuery;
Begin
  AQryOcorrencia := fCriaQuery();

  Try
    AQryOcorrencia.Close;
    AQryOcorrencia.SQL.Clear;
    AQryOcorrencia.SQL.Add(' SELECT OCO_CODOCO, OCO_MOTIVO, OCO_DESCRI, OCO_CODBCO, OCO_OPCNAB ');
    AQryOcorrencia.SQL.Add(' FROM OCOBAN ');
    AQryOcorrencia.SQL.Add(' WHERE OCO_CODOCO = :CODOCO AND ');
    AQryOcorrencia.SQL.Add('       OCO_CODBCO = :CODBCO AND ');
    AQryOcorrencia.SQL.Add('       OCO_OPCNAB = :OPCNAB ');

    If Not fEmptyStr(AMotivo) Then
    begin
      AQryOcorrencia.SQL.Add('     AND OCO_MOTIVO = :MOTIVO ');
      AQryOcorrencia.ParamByName('MOTIVO').AsString := AMotivo;
    end;

    AQryOcorrencia.ParamByName('CODOCO').AsString := AOcorrencia;
    AQryOcorrencia.ParamByName('CODBCO').AsString := ABanco;
    AQryOcorrencia.ParamByName('OPCNAB').AsString := ACnab;
    AQryOcorrencia.Open;

    If Not AQryOcorrencia.IsEmpty Then
    Begin
      if ADescricaoComMotivo then
      begin
         if AQryOcorrencia.FieldByName('OCO_MOTIVO').AsString <> '00' then
         Begin
            If (AQryOcorrencia.FieldByName('OCO_CODBCO').AsString = '237') then
               result := AQryOcorrencia.FieldByName('OCO_MOTIVO').AsString + ' - ' + AQryOcorrencia.FieldByName('OCO_DESCRI').AsString
            Else
               Result := AQryOcorrencia.FieldByName('OCO_MOTIVO').AsString + ' - ' + AQryOcorrencia.FieldByName('OCO_DESCRI').AsString
         End
         Else
            Result := AQryOcorrencia.FieldByName('OCO_DESCRI').AsString;
      end
      else
      begin

        if (AQryOcorrencia.FieldByName('OCO_MOTIVO').AsString <>  '00') and
           (AQryOcorrencia.FieldByName('OCO_CODOCO').AsString  =  '10') and
           (AQryOcorrencia.FieldByName('OCO_CODBCO').AsString  = '237') then
        Begin
           Result := AQryOcorrencia.FieldByName('OCO_DESCRI').AsString;
        End
        Else
           Result := AQryOcorrencia.FieldByName('OCO_DESCRI').AsString;

      end;

    end
    Else
    Begin

      If ADescricaoComMotivo Then
      Begin

        If Not fEmptyStr(AMotivo) Then
          Result := AMotivo +' - OUTRAS'
        Else
          Result := 'OUTRAS';

      End
      Else
        Result := 'OUTRAS'
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'Erro na busca da Ocorrência RetornaOcorrencia.');
    End;
  End;

  FreeAndNil(AQryOcorrencia);
End;

procedure pGravaRemGer(strCodEmp, strCodBco, strCartei: String; intNroRem: Integer; Var strAutoIncrem: String);
Var
  strSQL: String;
  qryRemGer : TUniQuery;
begin
  qryRemGer := fCriaQuery();

  strSQL := '';
  strSQL := strSQL + 'INSERT INTO REMGER ';
  strSQL := strSQL + '       (           ';
  strSQL := strSQL + '       AUTOINCREM, ';
  strSQL := strSQL + '       GER_CODEMP, ';
  strSQL := strSQL + '       GER_CODBCO, ';
  strSQL := strSQL + '       GER_CARTEI, ';
  strSQL := strSQL + '       GER_NROREM, ';
  strSQL := strSQL + '       GER_DTACAD, ';
  strSQL := strSQL + '       GER_HORCAD) ';
  strSQL := strSQL + '       VALUES (    ';
  strSQL := strSQL + '       :AUTOIN,    ';
  strSQL := strSQL + '       :CODEMP,    ';
  strSQL := strSQL + '       :CODBCO,    ';
  strSQL := strSQL + '       :CARTEI,    ';
  strSQL := strSQL + '       :NROREM,    ';
  strSQL := strSQL + '       :DTACAD,    ';
  strSQL := strSQL + '       :HORCAD)    ';

  strAutoIncrem := fRetAutoIncrem('REMGER', strCodEmp);

  try
    With qryRemGer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('AUTOIN').AsString  := strAutoIncrem;
	    ParamByName('CODEMP').AsString  := strCodEmp;
	    ParamByName('CODBCO').AsString  := strCodBco;
	    ParamByName('CARTEI').AsString  := strCartei;
      ParamByName('DTACAD').AsDate    := VS_Date;
      ParamByName('HORCAD').AsTime    := fTime();
	    ParamByName('NROREM').AsInteger := intNroRem;
	    ExecSQL;
      Close;
    end;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pGravaRemGer]');
    End;
  End;
  FreeAndNil(qryRemGer);
end;

procedure pGravaDelRemGer(strSeqGeral, strMotivo: String);
Var
  strSQL: String;
  qryRemGer : TUniQuery;
  qryRemDet : TUniQuery;
  qrySelect : TUniQuery;
  qryDelete : TUniQuery;
begin
  qryRemGer := fCriaQuery();
  qryRemDet := fCriaQuery();
  qrySelect := fCriaQuery();
  qryDelete := fCriaQuery();

  If not fEmptyStr(strseqGeral) then
  begin
    {***************************************************************}
    {* VERIFICA SE AINDA TEM REGISTRO DA REMESSA NA TABELA DETALHE *}
    {*** PARA DETERMINAR SE EXCLUI OU NÃO A TABELA GERAL (REMGER) **}
    {***************************************************************}
    strSQL := '';
    strSQL := strSQL + 'SELECT DET_SEQGER FROM REMDET ';
    strSQL := strSQL + 'WHERE DET_SEQGER = :SEQGER ';

    With qryRemDet Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('SEQGER').AsString := strSeqGeral;
      Open;
    end;

    if qryRemDet.RecordCount = 0 then
    begin
      strSQL := '';
      strSQL := strSQL + 'SELECT * FROM REMGER ';
      strSQL := strSQL + 'WHERE AUTOINCREM = :SEQGER ';

      With qrySelect Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('SEQGER').AsString := strSeqGeral;
        Open;
      end;

      If qrySelect.RecordCount > 0 then
      begin
        strSQL := '';
        strSQL := strSQL + 'INSERT INTO DEL_REMGER ';
        strSQL := strSQL + '       (           ';
        strSQL := strSQL + '       AUTOINCREM, ';
        strSQL := strSQL + '       GER_CODEMP, ';
        strSQL := strSQL + '       GER_CODBCO, ';
        strSQL := strSQL + '       GER_CARTEI, ';
        strSQL := strSQL + '       GER_NROREM, ';
        strSQL := strSQL + '       GER_DTACAD, ';
        strSQL := strSQL + '       GER_HORCAD, ';
        strSQL := strSQL + '       OPEDEL,     ';
        strSQL := strSQL + '       DTADEL,     ';
        strSQL := strSQL + '       HORDEL,     ';
        strSQL := strSQL + '       MOTDEL)     ';
        strSQL := strSQL + '       VALUES (    ';
        strSQL := strSQL + '       :AUTOIN,    ';
        strSQL := strSQL + '       :CODEMP,    ';
        strSQL := strSQL + '       :CODBCO,    ';
        strSQL := strSQL + '       :CARTEI,    ';
        strSQL := strSQL + '       :NROREM,    ';
        strSQL := strSQL + '       :DTACAD,    ';
        strSQL := strSQL + '       :HORCAD,    ';
        strSQL := strSQL + '       :OPEDEL,    ';
        strSQL := strSQL + '       :DTADEL,    ';
        strSQL := strSQL + '       :HORDEL,    ';
        strSQL := strSQL + '       :MOTDEL)    ';

        try
          With qryRemGer Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add(strSQL);
            ParamByName('AUTOIN').AsString   := strSeqGeral;
            ParamByName('CODEMP').AsString   := qrySelect.FieldByName('GER_CODEMP').AsString;
            ParamByName('CODBCO').AsString   := qrySelect.FieldByName('GER_CODBCO').AsString;
            ParamByName('CARTEI').AsString   := qrySelect.FieldByName('GER_CARTEI').AsString;
            ParamByName('NROREM').AsInteger  := qrySelect.FieldByName('GER_NROREM').AsInteger;
            ParamByName('DTACAD').AsDateTime := qrySelect.FieldByName('GER_DTACAD').AsDateTime;
            ParamByName('HORCAD').AsTime     := qrySelect.FieldByName('GER_HORCAD').AsDateTime;
            ParamByName('OPEDEL').AsString   := strLoginUsuarioLogado;
            ParamByName('DTADEL').AsDateTime := VS_Date;
            ParamByName('HORDEL').AsString   := FormatDateTime('hh:mm:ss', fTime());
            ParamByName('MOTDEL').AsString   := strMotivo;
            ExecSQL;
            Close;
          end;

          strSQL := '';
          strSQL := strSQL + 'DELETE FROM REMGER ';
          strSQL := strSQL + 'WHERE AUTOINCREM = :SEQGER ';

          With qryRemDet Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add(strSQL);
            ParamByName('SEQGER').AsString := strSeqGeral;
            ExecSQL;
            Close;
          end;
        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '[pGravaDelRemGer]');
          End;
        End;
      end;
    end;
  end;

  FreeAndNil(qryRemDet);
  FreeAndNil(qrySelect);
  FreeAndNil(qryDelete);
  FreeAndNil(qryRemGer);
end;


procedure pGravaRemDet(strSeqGer: String;
                       strDuplic: String;
                       strNosNum: String;
                       fltPorcen: Double = 0;
                       fltValDup: Double = 0;
                       dtaDtaRec: TDateTime = 0;
                       dtaDtaVen: TDateTime = 0;
                       dtaDtaEnv: TDateTime = 0;
                       strOpeEnv: String = '';
                       strStsSer: String = '';
                       strProtes: String = '';
                       dtaDtRecL: TDateTime = 0);
Var
  strSQL: String;
  qryRemDet : TUniQuery;
begin
  qryRemDet := fCriaQuery();
  strSQL := '';
  strSQL := strSQL + 'INSERT INTO REMDET ';
  strSQL := strSQL + '       (           ';
  strSQL := strSQL + '       DET_SEQGER, ';
  strSQL := strSQL + '       DET_DUPLIC, ';
  strSQL := strSQL + '       DET_NOSNUM, ';
  strSQL := strSQL + '       DET_DTACAD, ';
  strSQL := strSQL + '       DET_HORCAD, ';

  If dtaDtaRec <> 0 Then
    strSQL := strSQL + '       DET_DTAREC, ';

  If dtaDtaVen <> 0 Then
    strSQL := strSQL + '       DET_DTAVEN, ';

  If dtaDtaEnv <> 0 Then
    strSQL := strSQL + '       DET_DTAENV, ';

  if fltPorcen > 0 Then
    strSQL := strSQL + '       DET_PORCEN, ';

  if fltValDup > 0 Then
    strSQL := strSQL + '       DET_VALDUP, ';

  if Not fEmptyStr(strOpeEnv) then
    strSQL := strSQL + '       DET_OPEENV, ';

  if Not fEmptyStr(strStsSer) Then
    strSQL := strSQL + '       DET_STSSER, ';

  if Not fEmptyStr(strProtes) Then
    strSQL := strSQL + '       DET_PROTES, ';

  If dtaDtRecL <> 0 Then
    strSQL := strSQL + '       DET_DTRECL, ';

  strSQL := strSQL + '       DET_TIPREM, ';

  strSQL := strSQL + '       AUTOINCREM) ';

  strSQL := strSQL + '       VALUES (    ';
  strSQL := strSQL + '       :SEQGER,    ';
  strSQL := strSQL + '       :DUPLIC,    ';
  strSQL := strSQL + '       :NOSNUM,    ';
  strSQL := strSQL + '       :DTACAD,    ';
  strSQL := strSQL + '       :HORCAD,    ';

  If dtaDtaRec <> 0 then
    strSQL := strSQL + '       :DTAREC,    ';

  If dtaDtaVen <> 0 then
    strSQL := strSQL + '       :DTAVEN,    ';

  If dtaDtaEnv <> 0 Then
    strSQL := strSQL + '       :DTAENV,    ';

  if fltPorcen > 0 Then
    strSQL := strSQL + '       :PORCEN,    ';

  if fltValDup > 0 Then
    strSQL := strSQL + '       :VALDUP,    ';

  if Not fEmptyStr(strOpeEnv) then
    strSQL := strSQL + '       :OPEENV,    ';

  if Not fEmptyStr(strStsSer) Then
    strSQL := strSQL + '       :STSSER,    ';

  if Not fEmptyStr(strProtes) Then
    strSQL := strSQL + '       :PROTES,    ';

  If dtaDtRecL <> 0 Then
    strSQL := strSQL + '       :DTRECL,    ';

  strSQL := strSQL + '       :TIPREM,    ';

  strSQL := strSQL + '       :AUTOIN)    ';

  try
    With qryRemDet Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('AUTOIN').AsString   := fRetAutoIncrem('REMDET', VS_strCodEmp);
      ParamByName('SEQGER').AsString   := strSeqGer;
      ParamByName('DUPLIC').AsString   := strDuplic;
      ParamByName('NOSNUM').AsString   := strNosNum;
      ParamByName('DTACAD').AsDateTime := VS_Date;
      ParamByName('HORCAD').AsTime     := fTime();

      IF dtaDtaRec <> 0 THEN
        ParamByName('DTAREC').AsDateTime := dtaDtaRec;

      If dtaDtaVen <> 0 then
        ParamByName('DTAVEN').AsDateTime := dtaDtaVen;

      If dtaDtaEnv <> 0 Then
        ParamByName('DTAENV').AsDateTime := dtaDtaEnv;

      if fltPorcen > 0 Then
        ParamByName('PORCEN').AsFloat    := fltPorcen;

      if fltValDup > 0 Then
        ParamByName('VALDUP').AsFloat    := fltValDup;

      if Not fEmptyStr(strOpeEnv) then
        ParamByName('OPEENV').AsString   := strOpeEnv;

      if Not fEmptyStr(strStsSer) Then
        ParamByName('STSSER').AsString   := strStsSer;

      if Not fEmptyStr(strProtes) Then
        ParamByName('PROTES').AsString   := strProtes;

      If dtaDtRecL <> 0 Then
        ParamByName('DTRECL').AsDateTime := dtaDtRecL;

      ParamByName('TIPREM').AsInteger := fRetornaTipoRemessa(strDuplic);

      ExecSQL;
      Close;
    end;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pGravaRemDet]');
    End;
  End;
  FreeAndNil(qryRemDet);
end;

procedure pGravaDelRemDet(strMotivo,
                          strDuplic: String;
                          Var strSeqGer: String);
Var
  strSQL: String;
  blnInseriu: Boolean;
  qryRemDet : TUniQuery;
  qrySelect : TUniQuery;
  qryUpdate : TUniQuery;
begin
  qryRemDet := fCriaQuery();
  qrySelect := fCriaQuery();
  qryUpdate := fCriaQuery();

  strSQL := '';
  strSQL := strSQL + 'SELECT * FROM REMDET ';
  strSQL := strSQL + 'WHERE DET_DUPLIC = :DUPLIC ';

  With qrySelect Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('DUPLIC').AsString   := strDuplic;
    Open;
  end;

  if qrySelect.RecordCount > 0 then
  begin
    strSeqGer := qrySelect.FieldByName('DET_SEQGER').AsString;

    strSQL := '';
    strSQL := strSQL + 'INSERT INTO DEL_REMDET ';
    strSQL := strSQL + '       (           ';
    strSQL := strSQL + '       DET_SEQGER, ';
    strSQL := strSQL + '       DET_DUPLIC, ';
    strSQL := strSQL + '       DET_NOSNUM, ';
    strSQL := strSQL + '       DET_DTACAD, ';
    strSQL := strSQL + '       DET_HORCAD, ';

    If qrySelect.FieldByName('DET_DTAREC').AsDateTime <> 0 Then
      strSQL := strSQL + '       DET_DTAREC, ';

    If qrySelect.FieldByName('DET_DTAVEN').AsDateTime <> 0 Then
      strSQL := strSQL + '       DET_DTAVEN, ';

    If qrySelect.FieldByName('DET_DTAENV').AsDateTime <> 0 Then
      strSQL := strSQL + '       DET_DTAENV, ';

    if qrySelect.FieldByName('DET_PORCEN').AsFloat > 0 Then
      strSQL := strSQL + '       DET_PORCEN, ';

    if qrySelect.FieldByName('DET_VALDUP').AsFloat > 0 Then
      strSQL := strSQL + '       DET_VALDUP, ';

    if Not fEmptyStr(qrySelect.FieldByName('DET_OPEENV').AsString) then
      strSQL := strSQL + '       DET_OPEENV, ';

    if Not fEmptyStr(qrySelect.FieldByName('DET_STSSER').AsString) Then
      strSQL := strSQL + '       DET_STSSER, ';

    if Not fEmptyStr(qrySelect.FieldByName('DET_PROTES').AsString) Then
      strSQL := strSQL + '       DET_PROTES, ';

    if Not fEmptyStr(qrySelect.FieldByName('DET_DTRECL').AsString) Then
      strSQL := strSQL + '       DET_DTRECL, ';

    strSQL := strSQL + '       AUTOINCREM, ';
    strSQL := strSQL + '       OPEDEL,     ';
    strSQL := strSQL + '       DTADEL,     ';
    strSQL := strSQL + '       HORDEL,     ';
    strSQL := strSQL + '       MOTDEL)     ';
    strSQL := strSQL + '       VALUES (    ';
    strSQL := strSQL + '       :SEQGER,    ';
    strSQL := strSQL + '       :DUPLIC,    ';
    strSQL := strSQL + '       :NOSNUM,    ';
    strSQL := strSQL + '       :DTACAD,    ';
    strSQL := strSQL + '       :HORCAD,    ';

    If qrySelect.FieldByName('DET_DTAREC').AsDateTime <> 0 then
      strSQL := strSQL + '       :DTAREC,    ';

    If qrySelect.FieldByName('DET_DTAVEN').AsDateTime <> 0 then
      strSQL := strSQL + '       :DTAVEN,    ';

    If qrySelect.FieldByName('DET_DTAENV').AsDateTime <> 0 Then
      strSQL := strSQL + '       :DTAENV,    ';

    if qrySelect.FieldByName('DET_PORCEN').AsFloat > 0 Then
      strSQL := strSQL + '       :PORCEN,    ';

    if qrySelect.FieldByName('DET_VALDUP').AsFloat > 0 Then
      strSQL := strSQL + '       :VALDUP,    ';

    if Not fEmptyStr(qrySelect.FieldByName('DET_OPEENV').AsString) then
      strSQL := strSQL + '       :OPEENV,    ';

    if Not fEmptyStr(qrySelect.FieldByName('DET_STSSER').AsString) Then
      strSQL := strSQL + '       :STSSER,    ';

    if Not fEmptyStr(qrySelect.FieldByName('DET_PROTES').AsString) Then
      strSQL := strSQL + '       :PROTES,    ';

    if Not fEmptyStr(qrySelect.FieldByName('DET_DTRECL').AsString) Then
      strSQL := strSQL + '       :DTRECL,    ';

    strSQL := strSQL + '       :AUTOIN,    ';
    strSQL := strSQL + '       :OPEDEL,    ';
    strSQL := strSQL + '       :DATADEL,    ';
    strSQL := strSQL + '       :HORDEL,    ';
    strSQL := strSQL + '       :MOTDEL)    ';

    try
      With qryRemDet Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('AUTOIN').AsString   := qrySelect.FieldByName('AUTOINCREM').AsString;
        ParamByName('SEQGER').AsString   := qrySelect.FieldByName('DET_SEQGER').AsString;
        ParamByName('DUPLIC').AsString   := qrySelect.FieldByName('DET_DUPLIC').AsString;
        ParamByName('NOSNUM').AsString   := qrySelect.FieldByName('DET_NOSNUM').AsString;
        ParamByName('DTACAD').AsDateTime := qrySelect.FieldByName('DET_DTACAD').AsDateTime;
        ParamByName('HORCAD').AsTime     := qrySelect.FieldByName('DET_HORCAD').AsDateTime;

        IF qrySelect.FieldByName('DET_DTAREC').AsDateTime <> 0 THEN
          ParamByName('DTAREC').AsDateTime := qrySelect.FieldByName('DET_DTAREC').AsDateTime;

        If qrySelect.FieldByName('DET_DTAVEN').AsDateTime <> 0 then
          ParamByName('DTAVEN').AsDateTime := qrySelect.FieldByName('DET_DTAVEN').AsDateTime;

        If qrySelect.FieldByName('DET_DTAENV').AsDateTime <> 0 Then
          ParamByName('DTAENV').AsDateTime := qrySelect.FieldByName('DET_DTAENV').AsDateTime;

        if qrySelect.FieldByName('DET_PORCEN').AsFloat > 0 Then
          ParamByName('PORCEN').AsFloat    := qrySelect.FieldByName('DET_PORCEN').AsFloat;

        if qrySelect.FieldByName('DET_VALDUP').AsFloat > 0 Then
          ParamByName('VALDUP').AsFloat    := qrySelect.FieldByName('DET_VALDUP').AsFloat;

        if Not fEmptyStr(qrySelect.FieldByName('DET_OPEENV').AsString) then
          ParamByName('OPEENV').AsString   := qrySelect.FieldByName('DET_OPEENV').AsString;

        if Not fEmptyStr(qrySelect.FieldByName('DET_STSSER').AsString) Then
          ParamByName('STSSER').AsString   := qrySelect.FieldByName('DET_STSSER').AsString;

        if Not fEmptyStr(qrySelect.FieldByName('DET_PROTES').AsString) Then
          ParamByName('PROTES').AsString   := qrySelect.FieldByName('DET_PROTES').AsString;

        If qrySelect.FieldByName('DET_DTRECL').AsDateTime <> 0 then
          ParamByName('DTRECL').AsDateTime := qrySelect.FieldByName('DET_DTRECL').AsDateTime;

        ParamByName('OPEDEL').AsString     := strLoginUsuarioLogado;
        ParamByName('DATADEL').AsDateTime  := VS_Date;
        ParamByName('HORDEL').AsString     := FormatDateTime('hh:mm:ss', fTime());
        ParamByName('MOTDEL').AsString     := strMotivo;
        ExecSQL;
        Close;
        blnInseriu := True;
      end;

      //SE GRAVOU A DEL_REMDET ATUALIZA OS DADOS DE DEL DA REMDET
      if blnInseriu then
      begin
        strSQL := '';
        strSQL := strSQL + 'DELETE FROM REMDET ';
        strSQL := strSQL + 'WHERE DET_DUPLIC = :DUPLIC ';

        With qryRemDet Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('DUPLIC').AsString := strDuplic;
          ExecSQL;
          Close;
        end;
      end;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[pGravaDelRemDet]');
      End;
    End;
  end;

  FreeAndNil(qryUpdate);
  FreeAndNil(qrySelect);
  FreeAndNil(qryRemDet);
end;

procedure pGravaRetGer(strCodEmp,
                       strCodBco,
                       strCartei,
                       strNomArq: String;
                       intNroRem: Integer;
                       blnUpdate: Boolean;
                       Var strAutoIncrem: String);
Var
  strSQL: String;
  qryRetGer : TUniQuery;
  qryRetornoGer: TUniQuery;
begin
  qryRetGer     := fCriaQuery();
  qryRetornoGer := fCriaQuery();

  If blnUpdate Then
    If fEmptyStr(VarToStrDef(fCampoTabela('AUTOINCREM', 'RETGER',['GER_CARTEI', 'GER_NOMARQ'],[strCartei, strNomArq]), '')) Then
      blnUpdate := False;

  if blnUpdate then
  begin
    strSQL := '';
    strSQL := strSQL + 'UPDATE RETGER SET ';
    strSQL := strSQL + '       GER_CODEMP = :CODEMP, ';

    IF intNroRem > 0 Then
      strSQL := strSQL + '     GER_NROREM = :NROREM, ';

    strSQL := strSQL + '       GER_CODBCO = :CODBCO, ';
    strSQL := strSQL + '       GER_DTACAD = :DTACAD, ';
    strSQL := strSQL + '       GER_HORCAD = :HORCAD ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '       GER_CARTEI = :CARTEI AND ';
    strSQL := strSQL + '       GER_NOMARQ = :NOMARQ ';

    with qryRetornoGer Do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT AUTOINCREM ');
      SQL.Add('FROM RETGER ');
      SQL.Add('WHERE GER_CARTEI = :CARTEI AND ');
      SQL.Add('      GER_NOMARQ = :NOMARQ ');
      ParamByName('CARTEI').AsString := strCartei;
      ParamByName('NOMARQ').AsString := strNomArq;
      Open;
    end;

    strAutoIncrem := qryRetornoGer.FieldByName('AUTOINCREM').AsString;
  end
  else
  begin
    strSQL := '';
    strSQL := strSQL + 'INSERT INTO RETGER ';
    strSQL := strSQL + '       (           ';
    strSQL := strSQL + '       AUTOINCREM, ';
    strSQL := strSQL + '       GER_CODEMP, ';
    strSQL := strSQL + '       GER_CODBCO, ';
    strSQL := strSQL + '       GER_NOMARQ, ';
    strSQL := strSQL + '       GER_DTACAD, ';
    strSQL := strSQL + '       GER_HORCAD, ';

    IF intNroRem > 0 Then
      strSQL := strSQL + '       GER_NROREM, ';

    strSQL := strSQL + '       GER_CARTEI) ';
    strSQL := strSQL + '       VALUES (    ';
    strSQL := strSQL + '       :AUTOIN,    ';
    strSQL := strSQL + '       :CODEMP,    ';
    strSQL := strSQL + '       :CODBCO,    ';
    strSQL := strSQL + '       :NOMARQ,    ';
    strSQL := strSQL + '       :DTACAD,    ';
    strSQL := strSQL + '       :HORCAD,    ';

    IF intNroRem > 0 Then
      strSQL := strSQL + '       :NROREM,    ';

    strSQL := strSQL + '       :CARTEI)    ';

    strAutoIncrem := fRetAutoIncrem('REMGER', strCodEmp);
  end;

  try
    With qryRetGer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If Not blnUpdate then
        ParamByName('AUTOIN').AsString  := strAutoIncrem;

	    ParamByName('CODEMP').AsString   := strCodEmp;
	    ParamByName('CODBCO').AsString   := strCodBco;
	    ParamByName('CARTEI').AsString   := strCartei;
 	    ParamByName('NOMARQ').AsString   := strNomArq;
      ParamByName('DTACAD').AsDateTime := VS_Date;
      ParamByName('HORCAD').AsTime     := fTime();

      IF intNroRem > 0 Then
	      ParamByName('NROREM').AsInteger := intNroRem;

	    ExecSQL;
      Close;
    end;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pGravaRetGer]');
    End;
  End;

  FreeAndNil(qryRetornoGer);
  FreeAndNil(qryRetGer);
end;

procedure pGravaRetDet(strSeqGer: String;
                       strDuplic: String;
                       strNosNum: String;
                       fltValPag: Double = 0;
                       fltValJur: Double = 0;
                       fltValDes: Double = 0;
                       fltTarifa: Double = 0;
                       dtaDtaPag: TDateTime = 0;
                       strBcoPag: String = '';
                       strAgePag: String = '';
                       dtaDtaRet: TDateTime = 0;
                       strOpeRet: String = '';
                       strStsSer: String = '';
                       strCodOco: String = '';
                       blnUpdate: Boolean = False;
                       dtaDtaVen: TDateTime = 0);
Var
  strSQL   : String;
  qryRetDet: TUniQuery;
  qryDelete: TUniQuery;
begin
  qryRetDet := fCriaQuery();
  qryDelete := fCriaQuery();

  try
    {************************************************************************}
    {*** SE FOR PARA SOBREPOR O ARQUIVO JÁ EXISTENETE SERÁ DELETADO TODOS ***}
    {* OS REGISTROS QUE COMPÕE O ARQUIVO QUE ESTÃO NA TABELA E NA SEQUÊNCIA *}
    {**************** FAZ A INSERÇÃO DOS REGISTROS NOVAMENTE ****************}
    {*********************************************************************MO*}
    IF blnUpdate then
    begin
      strSQL := '';
      strSQL := strSQL + 'DELETE FROM RETDET ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '   DET_SEQGER = :SEQGER ';

      with qryDelete Do
      begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('SEQGER').AsString := strSeqGer;
        ExecSQL;
        Close;
      end;
    end;

    strSQL := '';
    strSQL := strSQL + 'INSERT INTO RETDET ';
    strSQL := strSQL + '       (           ';
    strSQL := strSQL + '       DET_SEQGER, ';
    strSQL := strSQL + '       DET_NOSNUM, ';
    strSQL := strSQL + '       DET_DTACAD, ';
    strSQL := strSQL + '       DET_HORCAD, ';

    if Not fEmptyStr(strDuplic) then
      strSQL := strSQL + '       DET_DUPLIC, ';

    if fltValPag > 0 Then
      strSQL := strSQL + '       DET_VALPAG, ';

    if fltValJur > 0 Then
      strSQL := strSQL + '       DET_VALJUR, ';

    if fltValDes > 0 Then
      strSQL := strSQL + '       DET_VALDES, ';

    if fltTarifa > 0 Then
      strSQL := strSQL + '       DET_TARIFA, ';

    if Not fEmptyStr(strBcoPag) then
      strSQL := strSQL + '       DET_BCOPAG, ';

    if Not fEmptyStr(strAgePag) Then
      strSQL := strSQL + '       DET_AGEPAG, ';

    if Not fEmptyStr(strOpeRet) Then
      strSQL := strSQL + '       DET_OPERET, ';

    if Not fEmptyStr(strStsSer) Then
      strSQL := strSQL + '       DET_STSSER, ';

    if Not fEmptyStr(strCodOco) then
      strSQL := strSQL + '       DET_CODOCO, ';

    if dtaDtaRet <> 0 then
      strSQL := strSQL + '       DET_DTARET, ';

    if dtaDtaPag <> 0 then
      strSQL := strSQL + '       DET_DTAPAG, ';

    if dtaDtaVen <> 0 then
      strSQL := strSQL + '       DET_DTAVEN, ';

    strSQL := strSQL + '       AUTOINCREM) ';
    strSQL := strSQL + '       VALUES (    ';
    strSQL := strSQL + '       :SEQGER,    ';
    strSQL := strSQL + '       :NOSNUM,    ';
    strSQL := strSQL + '       :DTACAD,    ';
    strSQL := strSQL + '       :HORCAD,    ';

    if Not fEmptyStr(strDuplic) then
      strSQL := strSQL + '       :DUPLIC,    ';

    if fltValPag > 0 Then
      strSQL := strSQL + '       :VALPAG,    ';

    if fltValJur > 0 Then
      strSQL := strSQL + '       :VALJUR,    ';

    if fltValDes > 0 Then
      strSQL := strSQL + '       :VALDES,    ';

    if fltTarifa > 0 Then
      strSQL := strSQL + '       :TARIFA,    ';

    if Not fEmptyStr(strBcoPag) then
      strSQL := strSQL + '       :BCOPAG,    ';

    if Not fEmptyStr(strAgePag) Then
      strSQL := strSQL + '       :AGEPAG,    ';

    if Not fEmptyStr(strOpeRet) Then
      strSQL := strSQL + '       :OPERET,    ';

    if Not fEmptyStr(strStsSer) Then
      strSQL := strSQL + '       :STSSER,    ';

    if Not fEmptyStr(strCodOco) then
      strSQL := strSQL + '       :CODOCO,    ';

    if dtaDtaRet <> 0 then
      strSQL := strSQL + '       :DTARET,    ';

    if dtaDtaPag <> 0 then
      strSQL := strSQL + '       :DTAPAG,    ';

    if dtaDtaVen <> 0 then
      strSQL := strSQL + '       :DTAVEN,    ';

    strSQL := strSQL + '       :AUTOIN)    ';

    With qryRetDet Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('AUTOIN').AsString   := fRetAutoIncrem('REMDET', VS_strCodEmp);
      ParamByName('SEQGER').AsString   := strSeqGer;
      ParamByName('NOSNUM').AsString   := strNosNum;
      ParamByName('DTACAD').AsDateTime := VS_Date;
      ParamByName('HORCAD').AsTime     := fTime();

      if dtaDtaPag <> 0 then
        ParamByName('DTAPAG').AsDateTime := dtaDtaPag;

      if dtaDtaVen <> 0 then
        ParamByName('DTAVEN').AsDateTime := dtaDtaVen;

      if Not fEmptyStr(strDuplic) then
        ParamByName('DUPLIC').AsString := strDuplic;

      if fltValPag > 0 Then
        ParamByName('VALPAG').AsFloat  := fltValPag;

      if fltValJur > 0 Then
        ParamByName('VALJUR').AsFloat  := fltValJur;

      if fltValDes > 0 Then
        ParamByName('VALDES').AsFloat  := fltValDes;

      if fltTarifa > 0 Then
        ParamByName('TARIFA').AsFloat  := fltTarifa;

      if Not fEmptyStr(strBcoPag) then
        ParamByName('BCOPAG').AsString := strBcoPag;

      if Not fEmptyStr(strAgePag) Then
        ParamByName('AGEPAG').AsString := strAgePag;

      if dtaDtaRet <> 0 then
        ParamByName('DTARET').AsDateTime := dtaDtaRet;

      if Not fEmptyStr(strOpeRet) Then
        ParamByName('OPERET').AsString := strOpeRet;

      if Not fEmptyStr(strStsSer) Then
        ParamByName('STSSER').AsString := strStsSer;

      if Not fEmptyStr(strCodOco) then
        ParamByName('CODOCO').AsString := strCodOco;

      ExecSQL;
      Close;
    end;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pGravaRetDet]');
    End;
  End;

  FreeAndNil(qryDelete);
  FreeAndNil(qryRetDet);
end;

function fRetornoDuplicado(strNomeArquivo, strCarteira: String): Boolean;
var
  qryRetornoGer: TUniQuery;
begin
  qryRetornoGer := fCriaQuery();

  with qryRetornoGer Do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT AUTOINCREM, GER_CARTEI, GER_NOMARQ ');
    SQL.Add('FROM RETGER ');
    SQL.Add('WHERE GER_CARTEI = :CARTEI AND ');
    SQL.Add('      GER_NOMARQ = :NOMARQ ');
    ParamByName('CARTEI').AsString := strCarteira;
    ParamByName('NOMARQ').AsString := strNomeArquivo;
    Open;
  end;

  if qryRetornoGer.RecordCount <= 0 then
    Result := False
  else
    Result := True;

  FreeAndNil(qryRetornoGer);
end;

function fRetornoDuplicado(strNomeArquivo, strCarteira: String; dtaDtaRet: TDateTime): Boolean;
var
  qryRetornoGer: TUniQuery;
  strSql : String;
begin
  qryRetornoGer := fCriaQuery();

  strSql := '';
  strSql := strSql + 'SELECT                                                         ';
  strSql := strSql + '  DET_DTARET,                                                  ';
  strSql := strSql + '  G.AUTOINCREM,                                                ';
  strSql := strSql + '  GER_CARTEI,                                                  ';
  strSql := strSql + '  GER_NOMARQ,                                                  ';
  strSql := strSql + '  G.*                                                          ';
  strSql := strSql + 'FROM                                                           ';
  strSql := strSql + '  RETGER G                                                     ';
  strSql := strSql + '  INNER JOIN RETDET D ON DET_SEQGER = G.AUTOINCREM             ';
  strSql := strSql + 'WHERE GER_CARTEI =  :CARTEI                                    ';
  strSql := strSql + '  AND GER_NOMARQ =  :NOMARQ                                    ';
  strSql := strSql + '  AND DET_DTARET =  :DTARET                                    ';
  strSql := strSql + '  LIMIT 1                                                      ';


  with qryRetornoGer Do
  begin
    Close;
    SQL.Clear;
    SQL.Add(strSql);
    ParamByName('CARTEI').AsString := strCarteira;
    ParamByName('NOMARQ').AsString := strNomeArquivo;
    ParamByName('DTARET').AsDateTime := dtaDtaRet;
    Open;
  end;

  if qryRetornoGer.RecordCount <= 0 then
    Result := False
  else
    Result := True;

  FreeAndNil(qryRetornoGer);
end;


function fRetornaCarteiraDuplicataRetBco(strCodBco,
                                         strCodEmp,
                                         strCarteiraAtual: String;
                                         arrConfiguracoes,
                                         arrValores: Array of String) : String;
  Var
    intContadorCarteira,
    intContadorConfig  : Integer;
    arrValoresCarteira : Array Of String;
    blnValorDiferente  : Boolean;
Begin
  Result := strCarteiraAtual;
  SetLength(arrValoresCarteira, Length(arrConfiguracoes));

  For intContadorCarteira := 1 To 5 Do
  Begin
    blnValorDiferente := False;
    For intContadorConfig := 0 To Length(arrConfiguracoes) - 1 Do
    Begin
      arrValoresCarteira[intContadorConfig] := untFuncoesSimples.fGetBancoConfig(0,
                                                             'CONFIG' + strCodBco + '-' + intContadorCarteira.ToString,
                                                             arrConfiguracoes[intContadorConfig],
                                                             '');

      blnValorDiferente := fStrZero(RightStr(arrValoresCarteira[intContadorConfig], Length(arrValores[intContadorConfig])),
                                    Length(arrValores[intContadorConfig])) <>
                           arrValores[intContadorConfig];

      If blnValorDiferente THen
        Break;
    End;

    If Not blnValorDiferente Then
    Begin
      Result := intContadorCarteira.ToString;
      Exit;
    End;
  End;
End;

procedure pDeletaCadCbi(strCodBco, strCartei, strCodPor: String);
  Var
    strSQL: String;
    qryDelCbi: TUniQuery;
begin
  qryDelCbi := fCriaQuery();

  Try
    strSQL := '';
    strSQL := strSQL + 'DELETE FROM ';
    strSQL := strSQL + '  CADCBI ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + 'CBI_CODBCO = :CODBCO ';

    If (fCfgSis('CONREM', varString) = 'C') Then
      If (Not fEmptyStr(strCartei)) Then
        strSQL := strSQL + ' AND CBI_CARTEI = :CARTEI ';

    If (Not fEmptyStr(strCodPor)) Then
      strSQL := strSQL + ' AND CBI_CODPOR = :CODPOR ';

    With qryDelCbi Do
    Begin
      SQL.Add(strSQL);
      ParamByName('CODBCO').AsString := strCodBco;

      If (fCfgSis('CONREM', varString) = 'C') Then
        If (Not fEmptyStr(strCartei)) Then
          ParamByName('CARTEI').AsString := strCartei;

      If (Not fEmptyStr(strCodPor)) Then
        ParamByName('CODPOR').AsString := strCodPor;

      ExecSQL;
      Close;
    End;
  Finally
    FreeAndNil(qryDelCbi);
  End;
end;

{********************************************************************}
{* FUNÇÃO QUE FORMATA O ENDEREÇO + NUMERO TOTALIZANDO 40 CARACTERES *}
{*REQ*154107******************************************************MO*}
function RetornaEnderecoENumeroCom40Caracteres(AEndereco, ANumero: String): String;
begin
  if Not fEmptyStr(ANumero) Then
    ANumero := ', ' + ANumero;

  if Length(AEndereco) > 40 then
    AEndereco := Copy(AEndereco, 1, 40);

  if (Length(AEndereco) + Length(ANumero)) > 40 Then
    AEndereco := Copy(AEndereco, 1, Length(AEndereco) - Length(ANumero));

  Result := AEndereco + '' + ANumero;
end;

function RetornaEnderecoENumeroCom35Caracteres(AEndereco, ANumero: String): String;
begin
  if Not fEmptyStr(ANumero) Then
    ANumero := ', ' + ANumero;

  if Length(AEndereco) > 35 then
    AEndereco := Copy(AEndereco, 1, 35);

  if (Length(AEndereco) + Length(ANumero)) > 35 Then
    AEndereco := Copy(AEndereco, 1, Length(AEndereco) - Length(ANumero));

  Result := AEndereco + '' + ANumero;
end;

function RetornaEnderecoENumeroCom37Caracteres(AEndereco, ANumero: String): String;
begin
  if Not fEmptyStr(ANumero) Then
    ANumero := ', ' + ANumero;

  if Length(AEndereco) > 37 then
    AEndereco := Copy(AEndereco, 1, 37);

  if (Length(AEndereco) + Length(ANumero)) > 37 Then
    AEndereco := Copy(AEndereco, 1, Length(AEndereco) - Length(ANumero));

  Result := AEndereco + '' + ANumero;
end;

function RetornaEnderecoENumeroCom30Caracteres(AEndereco, ANumero: String): String;
begin
  if Not fEmptyStr(ANumero) Then
    ANumero := ', ' + ANumero;

  if Length(AEndereco) > 30 then
    AEndereco := Copy(AEndereco, 1, 30);

  if (Length(AEndereco) + Length(ANumero)) > 30 Then
    AEndereco := Copy(AEndereco, 1, Length(AEndereco) - Length(ANumero));

  Result := AEndereco + '' + ANumero;
end;


function RetornaEnderecoENumeroCom38Caracteres(AEndereco, ANumero: String): String;
begin
  if Not fEmptyStr(ANumero) Then
    ANumero := ', ' + ANumero;

  if Length(AEndereco) > 38 then
    AEndereco := Copy(AEndereco, 1, 38);

  if (Length(AEndereco) + Length(ANumero)) > 38 Then
    AEndereco := Copy(AEndereco, 1, Length(AEndereco) - Length(ANumero));

  Result := AEndereco + '' + ANumero;
end;

function fRetNumParcela(strNumDoc: String): String;
  Var
    arrParcel   : Array Of String;
    intContador : Integer;

Begin

  SetLength(arrParcel, 27);

  arrParcel[01] := 'A';
  arrParcel[02] := 'B';
  arrParcel[03] := 'C';
  arrParcel[04] := 'D';
  arrParcel[05] := 'E';
  arrParcel[06] := 'F';
  arrParcel[07] := 'G';
  arrParcel[08] := 'H';
  arrParcel[09] := 'I';
  arrParcel[10] := 'J';
  arrParcel[11] := 'K';
  arrParcel[12] := 'L';
  arrParcel[13] := 'M';
  arrParcel[14] := 'N';
  arrParcel[15] := 'O';
  arrParcel[16] := 'P';
  arrParcel[17] := 'Q';
  arrParcel[18] := 'R';
  arrParcel[19] := 'S';
  arrParcel[20] := 'T';
  arrParcel[21] := 'U';
  arrParcel[22] := 'V';
  arrParcel[23] := 'X';
  arrParcel[24] := 'Y';
  arrParcel[25] := 'W';
  arrParcel[26] := 'Z';

  For intContador := 1 To Length(arrParcel) - 1 Do
    If RightStr(strNumDoc, 1) = arrParcel[intContador] Then
      Break;

  Result := IntToStr(intContador);

End;

function RetornaNumeroParcela(AParcela:String):String;
  Var
    LParcela: String;
Begin
  LParcela := RightStr(AParcela, 1);

  Result := LParcela;
  If Not CharInSet(LParcela [1], ['0'..'9']) Then
    Result := fRetNumParcela(AParcela);
End;

{*****************************************}
{* RETIRA CARACTERES ESPECIAIS DE UMA    *}
{* STRING SUBSTITUINDO POR VAZIO         *}
{**************************************MT*}
function fRetirarCaracteresEspeciais(strTexto : String): String;
  Var
    strLista: String;
    intContador: Integer;
    intPosicao: Integer;
    strCaracNorm: String;
    strCaracEsp: String;
begin

  strLista := '/\-_+#;<>|*ªº°&"''()%$¨@!?§={}[]´`^~¹²³£¢Ø., ';

  strCaracNorm := 'aeiouaeiouaeiouaoaeioucAEIOUAEIOUAEIOUAOAEIOUC';
  strCaracEsp  := 'àèìòùáéíóúâêîôûãõäëïöüçÀÈÌÒÙÁÉÍÓÚÂÊÎÔÛÃÕÄËÏÖÜÇ';

  Result := '';
  For intContador := 1 To Length(strTexto) Do
  Begin
    intPosicao := Pos(strTexto[intContador], strCaracEsp);
    If intPosicao > 0 Then
      Result := Result + strCaracNorm[intPosicao]

    Else
      If Pos(strTexto[intContador], strLista) <= 0 Then
        Result := Result + strTexto[intContador]
      Else
        Result := Result + ' ';
  End;

end;

{******************************************************************
* DEPOIS QUE O OPERADOR TERMINAR DE REALIZAR A ATUALIZAÇÃO/ BAIXA *
* DAS DUPLICATAS DA RETBCO RETIRA A ROTINA DE LCKATC*             *
************************************************RQ:183634******MT**}
function fLiberaLockBaixaAutomatica(strCodBco: String): Boolean;
begin
  Result := True;
  If Not (strCodBco = '237') Then // apenas bradesco por enquanto
    Exit;

  Result :=  fLock_Unlock('ATUALIZACAO/BAIXA_AUTOMATICA_AUTBAN_' + strCodBco.Trim, False);
end;

{*****************************************************************
* QUANDO O OPERADOR INCIAR A ATUALIZAÇÃO/BAIXA DAS DUPLICATAS    *
* DA RETBCO, TRAVAR A ROTINA NA LCKATC PARA QUE NÃO DEIXE NENHUM *
* OUTRO OPERADOR REALIZAR A IMPORTAÇÃO DE UM NOVO ARQUIVO RETORNO*
* JÁ QUE IRA APAGAR A RETBCO QUE ESTA EM BAIXA NO MOMENTO        *
*********************************************RQ:183634******MT** *}
function fLockBaixaAutomatica(strCodBco: String; blnMsg, blnTrava : Boolean): Boolean;
  Var
   strNomBco : String;
begin
  Result := False;

  If Not (strCodBco = '237') Then // apenas bradesco por enquanto
    Exit;

  strNomBco := fCampoTabela('BCO_NOMBCO', 'CADBCO',
                            ['BCO_CODBCO'],
                            [strCodBco]);

  If Not fLock_Unlock('ATUALIZACAO/BAIXA_AUTOMATICA_AUTBAN_' + strCodBco.Trim, True, False) Then
  Begin
    If blnMsg Then
      fMensagem('ATENÇÃO', 'A rotina de Atualização/Baixa Automática do banco ' + strNomBco + ' está sendo utilizada por outra estação: ' + #13+#10 +
                            fGetHostLock('ATUALIZACAO/BAIXA_AUTOMATICA_AUTBAN_' + strCodBco.Trim) + #13+#10 +
                            'Aguarde o término da Atualização/Baixa das duplicatas importadas anteriormente!', ['&OK'], 1);
    Result := True;
  End;

  If Not blnTrava And Not Result Then
  Begin
    fLiberaLockBaixaAutomatica(strCodBco);
  End;

end;



function fQtdParcelas(strNumDup, strCodEmp, strEspDoc, strCodCli: String): Integer;
var
  strSQL: String;
  qryPes: TUniQuery;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT                    ';
  strSQL := strSQL + '  COUNT(*) AS QTDPARC     ';
  strSQL := strSQL + 'FROM                      ';
  strSQL := strSQL + '  CADREC                  ';
  strSQL := strSQL + 'WHERE CTR_NUMDUP = :NUMDUP';
  strSQL := strSQL + '  AND CTR_CODEMP = :CODEMP';
  strSQL := strSQL + '  AND CTR_ESPDOC = :ESPDOC';
  strSQL := strSQL + '  AND CTR_CODCLI = :CODCLI';

  qryPes := fCriaQuery();
  try
    qryPes.SQL.Text := strSQL;
    qryPes.ParamByName('NUMDUP').AsString := strNumDup;
    qryPes.ParamByName('CODEMP').AsString := strCodEmp;
    qryPes.ParamByName('ESPDOC').AsString := strEspDoc;
    qryPes.ParamByName('CODCLI').AsString := strCodCli;
    qryPes.Open;

    Result := qryPes.FieldByName('QTDPARC').AsInteger;
  finally
    FreeAndNil(qryPes);
  end;
End;

function RetornaListaDeCarteirasCFGBAN: TStringList;
  Var
    LConsulta: TUniQuery;
Begin
  LConsulta := Nil;
  Try

    LConsulta := fCriaQuery;
    LConsulta.SQL.Text := 'SELECT CONCAT("BCO", SIS_CODBAN, "_EMP", SIS_CODEMP) AS CHAVE ' +
                          'FROM CFGBAN                                                   ' +
                          'GROUP BY SIS_CODBAN, SIS_CODEMP                               ' +
                          'ORDER BY SIS_CODBAN, SIS_CODEMP                               ';
    LConsulta.Open;

    Result := TStringList.Create;

    While Not LConsulta.Eof Do
    Begin
      Result.Add(LConsulta.FieldByName('CHAVE').AsString);

      LConsulta.Next;
    End;
  Finally
    FreeAndNilDatasets(LConsulta);
  End;
End;

function VerificaNossoNumeroDuplicado(ANossoNumero,
                                      ACodigoBanco,
                                      ACodigoEmpresa,
                                      ACarteira: String;
                                      Var AQuantidadeRegistros: Integer;
                                      AAutoIncremCadRec: String): Boolean;
  Var
    LSQL : String;
    LConsulta : TUniQuery;
begin
  Try
    LConsulta := fCriaQuery(Nil);

    LSQL := '';
    LSQL := LSQL + ' SELECT ';
    LSQL := LSQL + '   CTR_CARTEI, COUNT(CTR_NOSNUM) REGDUP ';
    LSQL := LSQL + ' FROM ';
    LSQL := LSQL + '   CADREC ';
    LSQL := LSQL + ' WHERE ';
    LSQL := LSQL + '   CTR_NOSNUM = :NOSNUM AND  ';
    LSQL := LSQL + '  (CTR_BCOBOL = :CODBCO OR   ';
    LSQL := LSQL + '   CTR_BCOENV = :CODBCO) AND ';
    LSQL := LSQL + ' ((CTR_CARTEI IS NOT NULL AND CTR_CARTEI <> "") OR ';
    LSQL := LSQL + '  (CTR_CODEMP = :CODEMP))    ';
    LSQL := LSQL + ' GROUP BY ';
    LSQL := LSQL + '   CTR_CARTEI ';
    LSQL := LSQL + ' HAVING ';
    LSQL := LSQL + '   COUNT(CTR_NOSNUM) > 1 ';

    LConsulta.Close;
    LConsulta.SQL.Text := LSQL;
    LConsulta.ParamByName('NOSNUM').AsString := ANossoNumero;
    LConsulta.ParamByName('CODBCO').AsString := ACodigoBanco;
    LConsulta.ParamByName('CODEMP').AsString := ACodigoEmpresa;
    LConsulta.Open;

    AQuantidadeRegistros := LConsulta.RecordCount;
    Result := LConsulta.FieldByName('REGDUP').AsInteger > 1;

    If Result Then
    Begin
      If ACarteira.IsEmpty Then
        Exit;
    End;

    //Se possuir o nosso número na cadrec, verifica se é da duplicata selecionada
    LSQL := '';
    LSQL := LSQL + ' SELECT ';
    LSQL := LSQL + '   CTR_NOSNUM, ';
    LSQL := LSQL + '   IF(IFNULL(CTR_CARTEI, "") <> "", RIGHT(CTR_CARTEI, 3), CTR_CODEMP) AS EMPCAR ';
    LSQL := LSQL + ' FROM ';
    LSQL := LSQL + '   CADREC ';
    LSQL := LSQL + ' WHERE ';
    LSQL := LSQL + '   AUTOINCREM <> :AUTINC AND ';
    LSQL := LSQL + '   CTR_NOSNUM = :NOSNUM AND  ';
    LSQL := LSQL + '  (CTR_BCOBOL = :CODBCO OR   ';
    LSQL := LSQL + '   CTR_BCOENV = :CODBCO)     ';

    LConsulta.Close;
    LConsulta.SQL.Text := LSQL;
    LConsulta.ParamByName('NOSNUM').AsString := ANossoNumero;
    LConsulta.ParamByName('CODBCO').AsString := ACodigoBanco;
    LConsulta.ParamByName('AUTINC').AsString := AAutoIncremCadRec;
    LConsulta.Open;

    LConsulta.Filter   := 'EMPCAR=' + RightStr(ACarteira, 3).QuotedString;
    LConsulta.Filtered := True;

    Result := (Not LConsulta.IsEmpty);
  Finally
    FreeAndNil(LConsulta);
  End;
end;

function RetornaValorImportacaoData(AValor: String;
                                    AOcorrenciaRegistro: String = '';
                                    AOcorrenciasIgnoradas: String = ''): Variant;
Begin
  Result := Null;

  If AValor.IsEmpty Then
    Exit;

  If MatchStr(AValor, ['000000', '00000000']) Then
    Exit;

  If Not AOcorrenciaRegistro.IsEmpty Then
  Begin
    If Pos(AOcorrenciaRegistro, AOcorrenciasIgnoradas) > 0 Then
      Exit;
  End;

  Result := StrToDate(AValor);
End;

function RetornaValorImportacaoDouble(AValor: String;
                                      AOcorrenciaRegistro: String = '';
                                      AOcorrenciasIgnoradas: String = '';
                                      ACodBco: String = ''): Double;
Begin
  Result := 0.00;

  If AValor.IsEmpty Then
    Exit;

  If Not AOcorrenciaRegistro.IsEmpty Then
  Begin
    If Pos(AOcorrenciaRegistro, AOcorrenciasIgnoradas) > 0 Then
      Exit;
  End;

  If MatchStr(ACodBco, ['097', '237']) Then
    Exit(fStrToFloat(AValor));

  If MatchStr(ACodBco, ['748', '756']) Then
    Exit(fStrToFloat(fTrocaPontoporVirgula(AValor)));

  If ACodBco.Equals('033') Then
    Exit(fStrToFloat(fTrocaPontoporVirgula(AValor.Replace(',', EmptyStr))));

  Result := fStrToFloat(AValor) / 100;
End;

function RetornaValorImportacaoString(AValor: String): Variant;
Begin
  Result := Null;

  If Not AValor.IsEmpty Then
    Result := AValor;
End;

procedure GravaRegistroRetBco(out AChaveDuplicatas: TStringList;
                              out AListaBaixadas: TStringList;
                              var ARetBco: TUniQuery;
                              ACarteira: Integer;
                              AParcel, ANumDup, ACodCli, ACodEmp, AEspDoc,
                              ADtaOco, ADtaVen, ADtaPag, ANomArq, ADesCon,
                              AValDup, AValPag, AJurMor, AOutVal, ACodBco,
                              ACodOco, ANosNum, ACodRej, AMotOco: String;
                              ADtaArq: TDateTime;
                              ASomaJur: Boolean = False;
                              AConRet: String = '';
                              AOutCob: String = '';
                              ADtaCre: String = '';
                              ATarifa: String = '';
                              AValLan: String = '';
                              ACusCar: String = '';
                              ACarBco: String = '';
                              AIofDes: String = '';
                              ATxaDes: String = '';
                              ADescontada: Boolean = False;
                              AJurOpe: String = '';
                              ACnab: String = '';
                              ARecPix: String = 'N';
                              AEnd_ID: String = '';
                              AEmpresaImportacao: String = '');
  Var
    LDuplicataBaixada: String;
Begin

  If AChaveDuplicatas.IndexOf(ACodBco + ACodEmp + ACodCli + ACodOco + ANumDup + AParcel + AEspDoc) >= 0 Then
    Exit;

  Try

    LDuplicataBaixada := 'N';
    If VerificaDuplicataBaixadaImportacao(AListaBaixadas, ANumDup, AParcel, AEspDoc, ACodEmp, ACodCli, ANosNum) Then
      LDuplicataBaixada := 'S';

    If Not ARetBco.Active Then
      ARetBco.Open;

    AChaveDuplicatas.Add(ACodBco + ACodEmp + ACodCli + ACodOco + ANumDup + AParcel + AEspDoc);

    ARetBco.Insert;

    ARetBco.FieldByName('RET_DTAOCO').Value := RetornaValorImportacaoData(ADtaOco); //Data Ocorrencia
    ARetBco.FieldByName('RET_DTAVEN').Value := RetornaValorImportacaoData(ADtaVen); //Data Vencimento
    ARetBco.FieldByName('RET_DTACRE').Value := RetornaValorImportacaoData(ADtaCre); //Data Crédito

    ARetBco.FieldByName('RET_DTAPAG').Value := RetornaValorImportacaoData(ADtaPag,
                                                                          ACodOco,
                                                                          '02_32_09_'); //Data Crédito/Pgto

    ARetBco.FieldByName('RET_DESCON').AsFloat := RetornaValorImportacaoDouble(ADesCon,'','',ACodBco); //Valor Desconto
    ARetBco.FieldByName('RET_VALDUP').AsFloat := RetornaValorImportacaoDouble(AValDup,'','',ACodBco); //Valor Duplicata
    ARetBco.FieldByName('RET_VALPAG').AsFloat := RetornaValorImportacaoDouble(AValPag,'','',ACodBco); //Valor Pago
    ARetBco.FieldByName('RET_OUTCOB').AsFloat := RetornaValorImportacaoDouble(AOutCob,'','',ACodBco); //Outros valores (somado no valrec apenas. no movban não)
    ARetBco.FieldByName('RET_TARIFA').AsFloat := RetornaValorImportacaoDouble(ATarifa,'','',ACodBco); //Valor da Tarifa Bancária
    ARetBco.FieldByName('RET_VALLAN').AsFloat := RetornaValorImportacaoDouble(AValLan,'','',ACodBco); //Valor Recebido - Deduções + Acréscimos

    If ASomaJur Then
    Begin
      ARetBco.FieldByName('RET_VALPAG').AsFloat := ARetBco.FieldByName('RET_VALPAG').AsFloat +
                                                   RetornaValorImportacaoDouble(AJurMor,
                                                                                ACodOco,
                                                                                '02_32_09_',
                                                                                ACodBco);

      If (Not fEmptyStr(AJurMor)) Then
      Begin
        If MatchStr(ACodOco, ['02', '32', '09']) Then
          ARetBco.FieldByName('RET_VALPAG').AsFloat := 0;
      End;
    End;

    ARetBco.FieldByName('RET_JURMOR').AsFloat := RetornaValorImportacaoDouble(AJurMor,
                                                                              ACodOco,
                                                                              '02_32_09_',
                                                                              ACodBco);

    ARetBco.FieldByName('RET_OUTVAL').AsFloat := RetornaValorImportacaoDouble(AOutVal,
                                                                              ACodOco,
                                                                              '02_32_09_',
                                                                              ACodBco); //Outros Valores (Despesas de Cobrança)

    if ACodBco = '041' Then
    Begin
      ARetBco.FieldByName('RET_DTAPAG').Value := RetornaValorImportacaoData(ADtaPag,
                                                                            ACodOco,
                                                                            '30_');

      If ACodOco = '09' Then
      Begin
        If ACnab = '240' Then
          ARetBco.FieldByName('RET_DTAPAG').Value := RetornaValorImportacaoData(ADtaPag); //Data Credito/Pgto
      End;
    End;

    ARetBco.FieldByName('RET_CODBCO').AsString := ACodBco; //Banco Cobrador
    ARetBco.FieldByName('RET_CODOCO').AsString := ACodOco; //Cód. Ocorrencia
    ARetBco.FieldByName('RET_NOSNUM').AsString := ANosNum; //Nosso Numero
    ARetBco.FieldByName('RET_NUMDUP').AsString := ANumDup; //Nº Duplicata
    ARetBco.FieldByName('RET_PARCEL').AsString := AParcel; //Parcela da Duplicata
    ARetBco.FieldByName('RET_ESPDOC').AsString := AEspDoc; //Especie do Documento
    ARetBco.FieldByName('RET_CODEMP').AsString := ACodEmp; //Código Empresa
    ARetBco.FieldByName('RET_CODCLI').AsString := ACodCli; //Código Cliente
    ARetBco.FieldByName('RET_NOMARQ').AsString := ANomArq; //Nome do Arquivo
    ARetBco.FieldByName('RET_DUPDES').AsString := IIF(ADescontada, 'S', 'N');

    ARetBco.FieldByName('RET_DTAARQ').AsDateTime := RetornaValorImportacaoData(DateTimeToStr(ADtaArq)); //Data Arquivo
    ARetBco.FieldByName('RET_HORARQ').AsDateTime := RetornaValorImportacaoData(DateTimeToStr(ADtaArq)); //Hora Arquivo

    ARetBco.FieldByName('RET_CODREJ').Value := RetornaValorImportacaoString(ACodRej); //Código de Rejeição
    ARetBco.FieldByName('RET_MOTOCO').Value := RetornaValorImportacaoString(AMotOco); //Motivo da Ocorrencia
    ARetBco.FieldByName('RET_CONRET').Value := RetornaValorImportacaoString(AConRet); //Conta de Retorno para Baixa
    ARetBco.FieldByName('RET_CARBCO').Value := RetornaValorImportacaoString(ACarBco); //Código da Carteira do banco

    ARetBco.FieldByName('RET_CARTEI').AsInteger  := ACarteira; // Código da Carteira


    ARetBco.FieldByName('RET_CUSCAR').AsFloat := RetornaValorImportacaoDouble(ACusCar,'','',ACodBco); //Valor de Custas de cartório
    ARetBco.FieldByName('RET_IOFDES').AsFloat := RetornaValorImportacaoDouble(AIofDes,'','',ACodBco); //Valor Iof duplicata descontada
    ARetBco.FieldByName('RET_TXADES').AsFloat := RetornaValorImportacaoDouble(ATxaDes,'','',ACodBco); //Taxa de desconto duplicata descontada
    ARetBco.FieldByName('RET_JUROPE').AsFloat := RetornaValorImportacaoDouble(AJurOpe,'','',ACodBco); //Juros da operação sobre desconto de duplicatas

    ARetBco.FieldByName('RET_DUPBAI').AsString := LDuplicataBaixada;

    ARetBco.FieldByName('RET_CNAB__').AsString := ACnab;

    ARetBco.FieldByName('RET_RECPIX').AsString := ARecPix;
    ARetBco.FieldByName('RET_END_ID').AsString := AEnd_ID;

    ARetBco.FieldByName('RET_EMPIMP').AsString := VS_strCodEmp;
    If Not AEmpresaImportacao.IsEmpty Then
      ARetBco.FieldByName('RET_EMPIMP').AsString := AEmpresaImportacao;

    ARetBco.Post;

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;

End;

procedure ApagaRegistrosAnterioresRetBco(ACodigoBanco: String; AApagaRegistros: Boolean; ATipoCnab: String = '';
  AValidaEmpresaImportacao: Boolean = True);
  Var
    LSQL: String;

    LDelete: TUniQuery;
begin
  If Not AApagaRegistros Then
    Exit;

  Try
    LDelete := fCriaQuery(Nil);

    LSQL := '';
    LSQL := LSQL + 'DELETE FROM ';
    LSQL := LSQL + '  RETBCO ';
    LSQL := LSQL + 'WHERE ';
    LSQL := LSQL + '  RET_CODBCO = :CODBCO ';

    If fCfgSis('EMPIMP', varBoolean) Then
    Begin
      If AValidaEmpresaImportacao Then
        LSQL := LSQL + ' AND RET_EMPIMP = ' + VS_strCodEmp.QuotedString
      Else
        LSQL := LSQL + ' AND RET_EMPIMP IN (' + fRetStrToSqlIn(strEmpAcessoUsuarioLogado) + ') ';
    End;

    LDelete.Close;
    LDelete.SQL.Text := LSQL;

    LDelete.ParamByName('CODBCO').AsString := ACodigoBanco;

    LDelete.ExecSQL;

    LSQL := LSQL.Replace(' AND RET_EMPIMP = ' + VS_strCodEmp.QuotedString,'');
    LSQL := LSQL.Replace(' AND RET_EMPIMP IN (' + fRetStrToSqlIn(strEmpAcessoUsuarioLogado) + ')','');
    LDelete.SQL.Text := AnsiReplaceStr(AnsiReplaceStr(LSQL, 'RETBCO', 'RETMOT'),'RET_','MOT_');
    LDelete.ExecSQL;

    LDelete.Close;
  Finally
    FreeAndNil(LDelete);
  End;
End;

procedure AtualizaPixBoleto(AAutoincrem,AQrCodeTxId,AQrCodeEmv,
                            AQrCodeUrl,AQrCodeLinkCitel:String);
  Var
    LCadRec : TUniQuery;
    LSql: String;
begin
  Try
    LCadRec := fCriaQuery(Nil);

    LSql := LSql + 'UPDATE                  ';
    LSql := LSql + '  CADREC                ';
    LSql := LSql + 'SET                     ';
    LSql := LSql + '  CTR_TX_BOL = :TX_BOL, ';
    LSql := LSql + '  CTR_QRCODE = :QRCODE, ';
    LSql := LSql + '  CTR_PIXLOC = :PIXLOC, ';
    LSql := LSql + '  CTR_LNKCIT = :LNKCIT  ';
    LSql := LSql + 'WHERE AUTOINCREM = :AUTINC   ';

    Try
      LCadRec.Close;
      LCadRec.Sql.Clear;
      LCadRec.Sql.Add(LSql);

      LCadRec.ParamByName('AUTINC').AsString := AAutoIncrem;
      LCadRec.ParamByName('TX_BOL').AsString := AQrCodeTxId;
      LCadRec.ParamByName('QRCODE').AsString := AQrCodeEmv;
      LCadRec.ParamByName('PIXLOC').AsString := AQrCodeUrl;
      LCadRec.ParamByName('LNKCIT').AsString := AQrCodeLinkCitel;

      LCadRec.ExecSQL;
    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;

  Finally
    FreeAndNil(LCadRec);
  End;
End;

procedure LimpaDadosBoleto(AAutoIncrem:String);
  Var
    LCadRec : TUniQuery;
    LSql: String;

    LCommitar: Boolean;
begin
  Try
    LCommitar := Not fInTransaction;
    If LCommitar Then
      fStartTransaction;

    LCadRec := fCriaQuery(Nil);

    LSql := LSql + 'UPDATE                       ';
    LSql := LSql + '  CADREC                     ';
    LSql := LSql + 'SET                          ';
    LSql := LSql + '  CTR_LINDIG = NULL,         ';
    LSql := LSql + '  CTR_NOSNUM = NULL,         ';
    LSql := LSql + '  CTR_DTABOL = NULL,         ';
    LSql := LSql + '  CTR_BCOBOL = NULL,         ';
    LSql := LSql + '  CTR_CARTEI = NULL,         ';
    LSql := LSql + '  CTR_CODCED = NULL,         ';
    LSql := LSql + '  CTR_BCOENV = NULL,         ';
    LSql := LSql + '  CTR_DTAENV = NULL,         ';
    LSql := LSql + '  CTR_CTREME = NULL,         ';
    LSql := LSql + '  CTR_END_ID = NULL,         ';
    LSql := LSql + '  CTR_TX_BOL = NULL,         ';
    LSql := LSql + '  CTR_QRCODE = NULL,         ';
    LSql := LSql + '  CTR_LNKCIT = NULL,         ';
    LSql := LSql + '  CTR_PIXLOC = NULL,         ';
    LSql := LSql + '  CTR_ID_BOL = NULL          ';
    LSql := LSql + 'WHERE AUTOINCREM = :AUTINC   ';

    Try
      LCadRec.Close;
      LCadRec.Sql.Clear;
      LCadRec.Sql.Add(LSql);

      LCadRec.ParamByName('AUTINC').AsString :=  AAutoIncrem;

      LCadRec.ExecSQL;

      If LCommitar Then
        fCommit;
    Except
      On E: Exception Do
      Begin
        If LCommitar Then
          fRollback;

        Raise Exception.Create(E.Message);
      End;
    End;

  Finally
    FreeAndNil(LCadRec);
  End;
End;


function VerificaDuplicataBaixadaImportacao(out AListaNossoNumero: TStringList;
                                            ANumDup, AParcel, AEspDoc,
                                            ACodEmp, ACodCli: String;
                                            ANosNum: String = ''): Boolean;
  Var
    LSQL: String;

    LDuplicataBaixada: TUniQuery;
begin

  If Not Assigned(AListaNossoNumero) Then
    AListaNossoNumero := TStringList.Create;

  Try
    LDuplicataBaixada := fCriaQuery(Nil);

    LSQL := '';
    LSQL := LSQL + ' SELECT                     ';
    LSQL := LSQL + '   CTR_NOSNUM               ';
    LSQL := LSQL + ' FROM                       ';
    LSQL := LSQL + '   CADREC                   ';
    LSQL := LSQL + ' WHERE                      ';
    LSQL := LSQL + '   CTR_NUMDUP = :NUMDUP AND ';
    LSQL := LSQL + '   CTR_PARCEL = :PARCEL AND ';
    LSQL := LSQL + '   CTR_ESPDOC = :ESPDOC AND ';
    LSQL := LSQL + '   CTR_CODEMP = :CODEMP AND ';
    LSQL := LSQL + '   CTR_CODCLI = :CODCLI AND ';
    LSQL := LSQL + '   CTR_SEQBAI = 0 AND       ';
    LSQL := LSQL + '   CTR_DTAREC IS NOT NULL   ';

    LDuplicataBaixada.SQL.Text := LSQL;

    LDuplicataBaixada.ParamByName('NUMDUP').AsString := ANumDup;
    LDuplicataBaixada.ParamByName('PARCEL').AsString := AParcel;
    LDuplicataBaixada.ParamByName('ESPDOC').AsString := AEspDoc;
    LDuplicataBaixada.ParamByName('CODEMP').AsString := ACodEmp;
    LDuplicataBaixada.ParamByName('CODCLI').AsString := ACodCli;
    LDuplicataBaixada.Open;

    Result := Not LDuplicataBaixada.IsEmpty;
    If Result Then
      AListaNossoNumero.Add(IIF(LDuplicataBaixada.FieldByName('CTR_NOSNUM').AsString  = '',
                                ANosNum,
                                LDuplicataBaixada.FieldByName('CTR_NOSNUM').AsString));

  Finally
    FreeAndNil(LDuplicataBaixada);
  End;

end;

procedure ApagaRetGerRetDet(ANomeArquivo, ACarteira: String);
  Var
    LAutoIncremRetGer: String;
Begin
  LAutoIncremRetGer := fCampoTabela('AUTOINCREM',
                                    'RETGER',
                                    ['GER_CARTEI', 'GER_NOMARQ'],
                                    [ACarteira, ANomeArquivo]);

  If Not LAutoIncremRetGer.IsEmpty Then
  Begin
    fExecutaSQL('DELETE FROM RETDET WHERE DET_SEQGER="' + LAutoIncremRetGer + '"');

    fExecutaSQL('DELETE FROM RETGER WHERE AUTOINCREM="' + LAutoIncremRetGer + '"');
  End;

End;


function fRetStrToSQLIn(strValores: String; strDelimitador: String): String;
var
  arrValores : TArray<String>;
  intContador: Integer;
  strResultado: String;
Begin
  arrValores := strValores.Split(strDelimitador);

  For intContador := 0 To Length(arrValores)-1 Do
  Begin
    if strResultado = '""' then
      strResultado := '';

    if not fEmptyStr(strResultado) then
      strResultado := strResultado + ', "' + arrValores[intContador] + '"'
    else
      strResultado := '"' + arrValores[intContador] + '"';
  end;

  If fEmptyStr(strResultado) Then
    strResultado :=  '""';

  Result := strResultado;
End;

function fRetornaEmailCliente(ARemessa: TUniQuery): String;
begin
  If (fCfgSis('GPEMCB', VarBoolean)) Then
  Begin
    Result := '';

    If Not fEmptyStr(ARemessa.FieldByName('CLI_EMCOB1').AsString) Then
      Result := ARemessa.FieldByName('CLI_EMCOB1').AsString;

    If Not fEmptyStr(ARemessa.FieldByName('CLI_EMCOB2').AsString) Then
    Begin
      If fEmptyStr(Result) Then
        Result := ARemessa.FieldByName('CLI_EMCOB2').AsString
      Else
        Result := Result + '; ' + ARemessa.FieldByName('CLI_EMCOB2').AsString;
    End;

    If fEmptyStr(Result) Then
    Begin
      If Not fEmptyStr(ARemessa.FieldByName('CLI_EMAIL_').AsString) Then
        Result := ARemessa.FieldByName('CLI_EMAIL_').AsString
      Else If Not fEmptyStr(ARemessa.FieldByName('CLI_EMAIL2').AsString) Then
        Result := ARemessa.FieldByName('CLI_EMAIL2').AsString
      Else If Not fEmptyStr(ARemessa.FieldByName('CLI_EMAIL3').AsString) Then
        Result := ARemessa.FieldByName('CLI_EMAIL3').AsString;
    End;
  End
  Else
  Begin
    Result := '';
    If Not fEmptyStr(ARemessa.FieldByName('CLI_EMCOB1').AsString) Then
      Result := ARemessa.FieldByName('CLI_EMCOB1').AsString
    Else If Not fEmptyStr(ARemessa.FieldByName('CLI_EMCOB2').AsString) Then
      Result := ARemessa.FieldByName('CLI_EMCOB2').AsString
    Else If Not fEmptyStr(ARemessa.FieldByName('CLI_EMAIL_').AsString) Then
      Result := ARemessa.FieldByName('CLI_EMAIL_').AsString
    Else If Not fEmptyStr(ARemessa.FieldByName('CLI_EMAIL2').AsString) Then
      Result := ARemessa.FieldByName('CLI_EMAIL2').AsString
    Else If Not fEmptyStr(ARemessa.FieldByName('CLI_EMAIL3').AsString) Then
      Result := ARemessa.FieldByName('CLI_EMAIL3').AsString;
  End;

  Result := UpperCase(Result);
  Result := AnsiReplaceStr(Result, ';;', ';');
end;

procedure pAtualizaTarifaArqBco(strNumDup, strParcel, strCodCli, strCodEmp, strEspDoc,
                                strDtaOco, strTarifa: String);
  Var
    qryTabela: TUniQuery;
    strSQL : String;
Begin

  Try
    qryTabela := fCriaQuery(Nil);
    strSQL := '';
    strSQL := strSQL + ' UPDATE                     ';
    strSQL := strSQL + '   RETBCO                   ';
    strSQL := strSQL + ' SET                        ';
    strSQL := strSQL + '   RET_DTAOCO = IFNULL(:DTAOCO,RET_DTAOCO),   ';
    strSQL := strSQL + '   RET_TARIFA = IFNULL(:TARIFA,RET_TARIFA)    ';
    strSQL := strSQL + ' WHERE                      ';
    strSQL := strSQL + '   RET_NUMDUP = :NUMDUP     ';
    strSQL := strSQL + '   AND RET_PARCEL = :PARCEL ';
    strSQL := strSQL + '   AND RET_ESPDOC = :ESPDOC ';
    strSQL := strSQL + '   AND RET_CODEMP = :CODEMP ';
    strSQL := strSQL + '   AND RET_CODCLI = :CODCLI ';
    strSQL := strSQL + '   AND RET_CODOCO = "02" ';

    Try
      qryTabela.Close;
      qryTabela.SQL.Clear;
      qryTabela.SQL.Add(strSQL);

      If Not fEmptyStr(strDtaOco) And (strDtaOco <> '000000') And (strDtaOco <> '00000000') Then
        qryTabela.ParamByName('DTAOCO').AsDateTime := StrToDate(strDtaOco)
      else
        qryTabela.ParamByName('DTAOCO').Value := Null;

      If Not fEmptyStr(strTarifa) Then
        qryTabela.ParamByName('TARIFA').AsFloat := fStrToFloat(strTarifa)
      Else
        qryTabela.ParamByName('TARIFA').Value := Null;


      qryTabela.ParamByName('NUMDUP').AsString := strNumDup;
      qryTabela.ParamByName('PARCEL').AsString := strParcel;
      qryTabela.ParamByName('ESPDOC').AsString := strEspDoc;
      qryTabela.ParamByName('CODEMP').AsString := strCodEmp;
      qryTabela.ParamByName('CODCLI').AsString := strCodCli;
      qryTabela.ExecSQL;
    Except
      On E : Exception Do
      Begin
        pMensagensErro(E.Message, '[pAtualizaTarifaArqBco]');
      End;
    End;

  Finally
    FreeAndNil(qryTabela);
  End;

End;

function fLockedByCurrentConnection(strChaLck: String): Boolean;
begin
  Result := (fGetIdConnectionLock(strChaLck) = fGetConnectionID) And
            (fGetIPConnectionLock(strChaLck) = VS_IPAddressAsString);
end;

function RetiraQuebraLinha(AText : String): String;
begin
  AText := StringReplace(AText, #$D, '', [rfReplaceAll]);
  AText := StringReplace(AText, #$A, '', [rfReplaceAll]);
  AText := StringReplace(AText, #13, '', [rfReplaceAll]);
  AText := StringReplace(AText, #10, '', [rfReplaceAll]);
  Result := AText;
end;

procedure Aguarde(msecs: Integer);
  var
    FirstTickCount: LongInt;
begin
  FirstTickCount := GetTickCount;
  repeat
    Application.ProcessMessages;
  until ((LongInt(GetTickCount) - LongInt(FirstTickCount)) >= LongInt(msecs));
end;

procedure pStep(pgbStatus: TcxProgressBar);
begin
  If Assigned(pgbStatus) Then
  Begin
    pgbStatus.Position := pgbStatus.Position + 1;
    Application.ProcessMessages;
  End;
end;

function RetornaHorarioRegistroBoleto(AAutoIncrem:String):String;
  Var
    LRegBol : TUniQuery;
    LSql: String;
begin
  LRegBol := fCriaQuery(Nil);

  Try
    LSql := 'SELECT                        '+
            '  REG_HRAREG                  '+
            'FROM                          '+
            '  REGBOL                      '+
            'WHERE REG_DUPLIC = :DUPLIC    '+
            '  AND REG_EXCEPT IS NULL      '+
            '  AND REG_JSOREC IS NOT NULL  '+
            '  AND IFNULL(REG_DESCRI,"REGISTRO") = "REGISTRO" '+
            'ORDER BY REG_DTAREG DESC,     '+
            '  REG_HRAREG DESC             ';
    Try
      LRegBol.Close;
      LRegBol.SQL.Clear;
      LRegBol.SQL.Add(LSql);
      LRegBol.ParamByName('DUPLIC').AsString := AAutoIncrem;
      LRegBol.Open;
      Result := LRegBol.FieldByName('REG_HRAREG').AsString;
    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;

  Finally
    FreeAndNil(LRegBol);
  End;
end;

function RetornaValorJson(AObjeto: TJsonObject; ANomeCampo: String): String;
begin
  Result := '';
  If AObjeto.GetValue(ANomeCampo) <> Nil Then
    Result := AObjeto.GetValue<string>(ANomeCampo);
end;



function RetornaEnderecoPagadorRegistroBoleto(AAutoIncrem:String):String;
  Var
    LRegBol : TUniQuery;
    LSql: String;
    LJsonRetorno: TJSONObject;
    LUltimoEnderecoPagador : String;
begin
  LRegBol := fCriaQuery(Nil);
  Result := '';

  Try
    LSql := 'SELECT                        '+
            '  REG_JSOENV,IFNULL(REG_DESCRI,"REGISTRO") AS DESCRICAO '+
            'FROM                          '+
            '  REGBOL                      '+
            'WHERE REG_DUPLIC = :DUPLIC    '+
            '  AND REG_EXCEPT IS NULL      '+
            '  AND REG_JSOREC IS NOT NULL  '+
            '  AND IFNULL(REG_DESCRI,"REGISTRO") IN ("REGISTRO","ALTERAÇÃO") '+
            'ORDER BY REG_DTAREG,     '+
            '  REG_HRAREG             ';
    Try
      LRegBol.Close;
      LRegBol.SQL.Clear;
      LRegBol.SQL.Add(LSql);
      LRegBol.ParamByName('DUPLIC').AsString := AAutoIncrem;
      LRegBol.Open;

      LRegBol.First;
      While Not LRegBol.Eof Do
      Begin
        If fEmptyStr(LRegBol.FieldByName('REG_JSOENV').AsString) Then
          Exit;

        LJsonRetorno := TJSONObject.ParseJSONValue(LRegBol.FieldByName('REG_JSOENV').AsString) as TJSONObject;

        If LRegBol.FieldByName('DESCRICAO').AsString.Equals('REGISTRO') Then
        Begin
          LJsonRetorno :=  ExtrairJsonObject(LJsonRetorno,'pagador');

          LUltimoEnderecoPagador := Concat(RetornaValorJson(LJsonRetorno,'endereco') ,' - ',
                                           RetornaValorJson(LJsonRetorno,'bairro')   ,' - ',
                                           RetornaValorJson(LJsonRetorno,'cidade')   ,'/',
                                           RetornaValorJson(LJsonRetorno,'uf')       ,' - ',
                                           RetornaValorJson(LJsonRetorno,'cep'));

          If Not fEmptyStr(fRetirarCaracteresEspeciais(LUltimoEnderecoPagador)) Then
            Result := LUltimoEnderecoPagador;

        End
        Else
        Begin
          LJsonRetorno :=  ExtrairJsonObject(LJsonRetorno,'alteracaoEndereco');
          If Assigned(LJsonRetorno) Then
          Begin
            LUltimoEnderecoPagador := Concat(RetornaValorJson(LJsonRetorno,'enderecoPagador') ,' - ',
                                             RetornaValorJson(LJsonRetorno,'bairroPagador')   ,' - ',
                                             RetornaValorJson(LJsonRetorno,'cidadePagador')   ,'/',
                                             RetornaValorJson(LJsonRetorno,'UFPagador')       ,' - ',
                                             RetornaValorJson(LJsonRetorno,'CEPPagador'));

            If Not fEmptyStr(fRetirarCaracteresEspeciais(LUltimoEnderecoPagador)) Then
              Result := LUltimoEnderecoPagador;
          End;
        End;

        Application.ProcessMessages;
        FreeAndNil(LJsonRetorno);
        LRegBol.Next;
      End;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;

  Finally
    FreeAndNil(LRegBol);
  End;
end;

function RetornaValorString(AValor: String;
  ATamanho: Integer): String;
begin
  Result := AValor;

  If Result.IsEmpty Then
    Exit;

  If ATamanho > 0 Then
    Result := LeftStr(Result, ATamanho);

  Result := fRemoveAcento(Result);
  Result := fTiraCaracEspeciais(Result);
end;

function RetornaDataVencimentoRegistroBoleto(AAutoIncrem:String; ACodBco : String):TDateTime;
  Var
    LRegBol : TUniQuery;
    LSql: String;
    LJsonRetorno: TJSONObject;
    LUltimaDataVencimento : String;
begin
  LRegBol := fCriaQuery(Nil);
  Result := 0;

  Try
    LSql := 'SELECT                        '+
            '  REG_JSOENV,IFNULL(REG_DESCRI,"REGISTRO") AS DESCRICAO '+
            'FROM                          '+
            '  REGBOL                      '+
            'WHERE REG_DUPLIC = :DUPLIC    '+
            '  AND REG_EXCEPT IS NULL      '+
            '  AND REG_JSOREC IS NOT NULL  '+
            '  AND IFNULL(REG_DESCRI,"REGISTRO") IN ("REGISTRO","ALTERAÇÃO") '+
            'ORDER BY REG_DTAREG,     '+
            '  REG_HRAREG             ';
    Try
      LRegBol.Close;
      LRegBol.SQL.Clear;
      LRegBol.SQL.Add(LSql);
      LRegBol.ParamByName('DUPLIC').AsString := AAutoIncrem;
      LRegBol.Open;

      LRegBol.First;
      While Not LRegBol.Eof Do
      Begin

        If fEmptyStr(LRegBol.FieldByName('REG_JSOENV').AsString) Then
          Exit;

        LJsonRetorno := TJSONObject.ParseJSONValue(LRegBol.FieldByName('REG_JSOENV').AsString) as TJSONObject;

        If LRegBol.FieldByName('DESCRICAO').AsString.Equals('REGISTRO') Then
        Begin

          If ACodBco = '001' Then
             LUltimaDataVencimento := RetornaValorJson(LJsonRetorno,'dataVencimento').Replace('.','/')
          Else
          Begin
             LUltimaDataVencimento := RetornaValorJson(LJsonRetorno,'dataVencimento').Replace('.','/');
             LUltimaDataVencimento := AlteraFormatoData(LUltimaDataVencimento);
          End;

          If Not fEmptyStr(LUltimaDataVencimento) Then
            Result := StrToDate(LUltimaDataVencimento);

        End
        Else
        Begin
          LJsonRetorno := ExtrairJsonObject(LJsonRetorno,'alteracaoData');
          If Assigned(LJsonRetorno) Then
          Begin
            LUltimaDataVencimento := RetornaValorJson(LJsonRetorno,'novaDataVencimento').Replace('.','/');
            If Not fEmptyStr(LUltimaDataVencimento) Then
              Result := StrToDate(LUltimaDataVencimento);
          End;
        End;

        Application.ProcessMessages;
        FreeAndNil(LJsonRetorno);
        LRegBol.Next;
      End;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;

  Finally
    FreeAndNil(LRegBol);
  End;
end;

function AlteraFormatoData(AData:String) : String;
 Var
     dtRet : String;
Begin
  dtRet := Copy(AData,9,2) + '/' + Copy(AData,6,2) + '/' + Copy(AData,1,4);
  result := dtRet;
End;

function ExtrairJsonObject(AObjeto: TJsonObject;
  ANomeJson: String): TJsonObject;
begin
  Result := Nil;
  Try
    Result := AObjeto.GetValue<TJSONObject>(ANomeJson) as TJSONObject;
  Except
    //
  End;
end;

{ TBoletoAlpe }

constructor TBoletoAlpe.Create;
begin
  MinioConection := TAmazonConnectionInfo.Create(nil);
  MinioConection.UseDefaultEndpoints := False;
  MinioConection.AccountKey := fCfgSis('MINACK');
  MinioConection.AccountName := fCfgSis('MINACN');
  MinioConection.StorageEndpoint := fCfgSis('MINENP');
  MinioConection.Protocol := 'https';

  StorageMinio := TAmazonStorageService.Create(MinioConection);
end;

destructor TBoletoAlpe.Destroy;
begin
  FreeAndNil(MinioConection);
  FreeAndNil(StorageMinio);
  inherited;
end;

procedure TBoletoAlpe.EnviarArquivoRemessa(AArquivo: String);
var
  Reader: TBinaryReader;
  FileContent: TBytes;
  LNameFile : String;
  BucketName : String;
begin
  Try

    Try
      Reader := TBinaryReader.Create(AArquivo);
      FileContent := Reader.ReadBytes(Reader.BaseStream.Size);
    Finally
      FreeAndNil(Reader);
    End;

    LNameFile := ExtractFileName(AArquivo);
    BucketName := fCfgSis('MINBKT');
    BucketName := BucketName + '/documentos-bancarios/in';

    If StorageMinio.UploadObject(BucketName, LNameFile, FileContent, False, nil) Then
    Begin
      fMensagem('AVISO!','Arquivo remessa enviado com sucesso!',['&O K']);
      fRenomeiaArquivo(AArquivo);
    End Else fMensagem('AVISO!','Falha no envio do arquivo remessa!',['&O K']);

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
End;

function TBoletoAlpe.ImportarArquivo(AName: String): Boolean;
begin
  Result := False;

  If (Pos('documentos-bancarios/out/',AName) > 0) Then
    Result := True;

  If (Pos('conciliacao/out/',AName) > 0) Then
    Result := True;
end;

procedure TBoletoAlpe.ImportarArquivoRetorno(ACaminho: String);
  Var
    LBucketName  : String;
    LBucketInfo  : TAmazonBucketResult;
    LObjectInfo  : TAmazonObjectResult;
    LDelimiter   : TStringList;
    LStream      : TMemoryStream;
    LNomeArquivo : String;
    LImportou : Boolean;
begin

  Try
    LImportou := False;
    LDelimiter := TStringList.Create;
    LDelimiter.Delimiter := '/';
    LDelimiter.StrictDelimiter := True;

    LBucketName := fCfgSis('MINBKT');
    LBucketInfo := StorageMinio.GetBucket(LBucketName, nil);
    LStream := TMemoryStream.Create;

    For LObjectInfo in LBucketInfo.Objects do
    Begin

      If Not ImportarArquivo(LObjectInfo.Name) Then
        Continue;

      LDelimiter.DelimitedText := LObjectInfo.Name;

      LNomeArquivo := LDelimiter[(LDelimiter.Count - 1)];
      LBucketName  := fCfgSis('MINBKT');
      LBucketName  := LBucketName +'/'+ LObjectInfo.Name.Replace('/' + LNomeArquivo,'');

      If StorageMinio.GetObject(LBucketName, LNomeArquivo, LStream) Then
      Begin
        TMemoryStream(LStream).SaveToFile(ACaminho + '/' + LNomeArquivo);
        StorageMinio.DeleteObject(LBucketName, LNomeArquivo);
        LImportou := True;
      End;

    End;

    If LImportou Then fMensagem('AVISO!','Download do(s) arquivo(s) efetuado com sucesso!',['&O K'])
    Else fMensagem('AVISO!','Não há arquivo(s) para download.',['&O K']);

  Finally
    If Assigned(LDelimiter) Then
      FreeAndNil(LDelimiter);

    If Assigned(LStream) Then
      FreeAndNil(LStream);

    If Assigned(LBucketInfo) Then
      FreeAndNil(LBucketInfo);
  End;

end;

class function TBoletoAlpe.RetornaValorDescontoAlpeDuplicata(ADuplicataCadRec: TDataset): Double;
  Var
    LDiasPeriodo: Integer;

    LPercentualPeriodo: Double;
Begin
  Result := 0.00;

  If ADuplicataCadRec.FieldByName('CTR_PERALP').IsNull Then
    Exit;

  If ADuplicataCadRec.FieldByName('CTR_PERALP').AsFloat <= 0 Then
    Exit;

  LDiasPeriodo := DaysBetween(fAcertaDataParaDiaUtil(ADuplicataCadRec.FieldByName('CTR_DTAVEN').AsDateTime),
                                                     ADuplicataCadRec.FieldByName('CTR_DTAALP').AsDateTime);

  LPercentualPeriodo := 1 + (1 * (ADuplicataCadRec.FieldByName('CTR_PERALP').AsFloat / 100));
  LPercentualPeriodo := Power(LPercentualPeriodo, (LDiasPeriodo / 30)) - 1;
  LPercentualPeriodo := fFormataFloat(LPercentualPeriodo * 100, 3);

  Result := ADuplicataCadRec.FieldByName('CTR_VALDUP').AsFloat *
            (LPercentualPeriodo / 100);
End;

function RetornaSeOBancoLancaTarifaNaConfirmacao(AUsaTarifa: Boolean;
                                                 ACodigoBanco,
                                                 AConfiguracaoCarteira: String): Boolean;
Begin
  Result := False;

  If Not AUsaTarifa Then
    Exit;

  If AConfiguracaoCarteira.Contains('CONFIG341API') Then
    Exit;

  If MatchStr(ACodigoBanco, ['001', '041']) Then
    Exit(fArqIniAutban(0, AConfiguracaoCarteira, 'LANTX02', '06', VS_strCodEmp) = '02');

  Result := MatchStr(ACodigoBanco, ['748', '756', '341', '033', '237']);
End;

function RetornaDatasetChavesPixPorBanco(ACodigoBanco,
                                         ACodigoEmpresa: String): TUniClientDataset;
  Var
    LConsulta: TUniQuery;
Begin
  Try
    LConsulta := fCriaQuery;
    LConsulta.SQL.Text := 'SELECT P.AUTOINCREM, ' +
                          '       P.PIX_TIPCHV, ' +
                          '       P.PIX_CHAVE_, ' +
                          '       C.CCA_CODBCO, ' +
                          '       C.CCA_AGENCI, ' +
                          '       C.CCA_CODCTA, ' +
                          '       C.CCA_DIGAGE, ' +
                          '       C.CCA_DIGCTA, ' +
                          '       C.CCA_CODEMP, ' +
                          '       POR.POR_CODPOR, ' +
                          '       POR.POR_NOMPOR, ' +
                          '       CONCAT("Emp: ", C.CCA_CODEMP, " - ", P.PIX_TIPCHV, "-", P.PIX_CHAVE_) AS CHAVE ' +
                          'FROM CADCCA C ' +
                          'JOIN CCAPIX P ON P.PIX_SEQCCA=C.AUTOINCREM ' +
                          'JOIN CADPOR POR ON POR.POR_CCAAUT=C.AUTOINCREM ' +
                          'WHERE C.CCA_CODBCO="' + ACodigoBanco + '" ' +
                          '  AND (POR.POR_EMPACE IS NULL OR POR.POR_EMPACE="" OR ' +
                          '       LOCATE("' + ACodigoEmpresa + '", POR.POR_EMPACE) > 0) ';

    LConsulta.Open;

    Result := fCriaClientDatSet(LConsulta);
    Result.Open;
  Finally
    FreeAndNil(LConsulta);
  End;
End;

function fTrocaPontoporVirgula(strValor: String): String;
Begin
  Result := AnsiReplaceStr(strValor, '.', ',');
End;

function RetornaDiasParaRecebimentoAposVencimetoRegistroBoleto(ACodBco:String; ARegBol: TDataSet): String;
  Var
    LJsonRetorno: TJSONObject;
    LDiasParaRecebimentoAposVencimetoRegistrado : String;
begin
  Result := '';

  If Not MatchStr(ACodBco,['001']) Then
    Exit;

  Try

    ARegBol.First;
    While Not ARegBol.Eof Do
    Begin

      If fEmptyStr(ARegBol.FieldByName('REG_JSOENV').AsString) Then
        Exit;

      LJsonRetorno := TJSONObject.ParseJSONValue(ARegBol.FieldByName('REG_JSOENV').AsString) as TJSONObject;

      If ARegBol.FieldByName('DESCRICAO').AsString.Equals('REGISTRO') Then
      Begin
        LDiasParaRecebimentoAposVencimetoRegistrado := RetornaValorJson(LJsonRetorno,'numeroDiasLimiteRecebimento');
      End
      Else
      Begin
        LJsonRetorno := ExtrairJsonObject(LJsonRetorno,'alteracaoPrazo');
        If Assigned(LJsonRetorno) Then
        Begin
          LDiasParaRecebimentoAposVencimetoRegistrado := RetornaValorJson(LJsonRetorno,'quantidadeDiasAceite');
        End;
      End;

      Application.ProcessMessages;
      FreeAndNil(LJsonRetorno);
      ARegBol.Next;
    End;

    Result := LDiasParaRecebimentoAposVencimetoRegistrado;

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;

end;

function RetornaPastaOpenSSL: String;
  Var
    LOpenSSL: String;
begin
  Result := ExtractFilePath(Application.ExeName).Replace('\autban', EmptyStr)
                                                .Replace('\Autban', EmptyStr)
                                                .Replace('\AUTBAN', EmptyStr) + 'openssl32\';

  LOpenSSL := Result + 'openssl.exe';

  If FileExists(LOpenSSL) Then
    Exit;

  Result := ExtractFilePath(Application.ExeName).Replace('\autban', EmptyStr)
                                                .Replace('\Autban', EmptyStr)
                                                .Replace('\AUTBAN', EmptyStr) + 'openssl\';
  LOpenSSL := Result + 'openssl.exe';

  If (Not FileExists(LOpenSSL)) Then
  Begin
    fMensagem('ATENÇÃO', 'Não foi possível obter a validade do certificado selecionado, pois o aplicativo openssl não está na pasta do Autcom.' + #13 +
                         'Entre em contato com a Citel!', ['&Ok'], 0);
    Exit('');
  End;
End;

function PegaTimeZone: Integer;
  Var
    TimeZone: TTimeZoneInformation;

    LTimeZoneServer: TUniQuery;

    LValorMaquinaLocal: Integer;

    LPossuiTimeZoneAlterado: Boolean;
begin
  Result := 3;

  Try
    GetTimeZoneInformation(TimeZone);

    LValorMaquinaLocal := TimeZone.Bias div 60;
  Except
    LValorMaquinaLocal := 3;
  End;

  LTimeZoneServer := fCriaQuery;

  Try
    LTimeZoneServer.SQL.Text := 'SHOW VARIABLES LIKE "%time_zone%"';
    LTimeZoneServer.Open;

    If Not LTimeZoneServer.IsEmpty Then
    Begin
      LPossuiTimeZoneAlterado := LTimeZoneServer.Locate('Variable_name', 'time_zone', []);
      If LPossuiTimeZoneAlterado Then
      Begin
        LPossuiTimeZoneAlterado := Not LTimeZoneServer.FieldByName('Value').AsString.ToUpperInvariant.Equals('SYSTEM');

        If LPossuiTimeZoneAlterado Then
        Begin
          If TryStrToInt(LeftStr(LTimeZoneServer.FieldByName('Value').AsString, 3).Replace(':', EmptyStr), Result) Then
          Begin
            Result := Result * -1;
            Exit;
          End;
        End;
      End;

      If LTimeZoneServer.Locate('Variable_name', 'system_time_zone', []) Then
      Begin
        Result := LTimeZoneServer.FieldByName('value').AsInteger * -1;
        Exit;
      End;
    End;

    Result := LValorMaquinaLocal;
  Except
    Result := LValorMaquinaLocal;
  End;

  LTimeZoneServer.Close;
  FreeAndNil(LTimeZoneServer);
End;

function RetornaTimeStampEmMilisegundos: Int64;
  var
    LDateTime: TDateTime;

    LDataServidor,
    LHoraServidor: TDateTime;

    LConsulta: TUniQuery;

    SystemTime: TSystemTime;
begin
  LConsulta := fCriaQuery;

  Try
    Try
      LConsulta.SQL.Text := 'SELECT CURRENT_DATE AS DATA, ' +
                            '       CURTIME(3) AS HORA ' +
                            'FROM DUAL';
      LConsulta.Open;

      LDataServidor := FloatToDateTime(LConsulta.FieldByName('DATA').AsFloat);
      LHoraServidor := IncHour(FloatToDateTime(LConsulta.FieldByName('HORA').AsFloat), PegaTimeZone);

      LDateTime := EncodeDate(YearOf(LDataServidor), MonthOf(LDataServidor), DayOf(LDataServidor)) +
                   EncodeTime(HourOf(LHoraServidor), MinuteOf(LHoraServidor), SecondOf(LHoraServidor), MilliSecondOf(LHoraServidor));

      Result := MilliSecondsBetween(LDateTime, UnixDateDelta);
    Except
      GetSystemTime(SystemTime);
      LDateTime := EncodeDate(SystemTime.wYear, SystemTime.wMonth, SystemTime.wDay) +
                   EncodeTime(SystemTime.wHour, SystemTime.wMinute, SystemTime.wSecond, SystemTime.wMilliseconds);
      Result := MilliSecondsBetween(LDateTime, UnixDateDelta);
    End;
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
End;

Function fRetornaTipoRemessa(strAutoInc: String) : Integer;
Var
  strSQL,
  strSQLRec: String;

  qrySelectRec,
  qrySelectCBI : TUniQuery;
begin
  strSQLRec := '';
  strSQLRec := strSQLRec + 'SELECT CTR_CODCLI, CTR_CODEMP, CTR_ESPDOC, CTR_PARCEL, CTR_NUMDUP, CTR_NOSNUM'
                         + ' FROM CADREC WHERE AUTOINCREM = :AUTOIN ';

  strSQL := '';
  strSQL := strSQL + 'SELECT CBI_TIPREM FROM CADCBI '
                   + ' WHERE CBI_NUMDUP = :NUMDUP   '
                   + '   AND CBI_PARCEL = :PARCEL   '
                   + '   AND CBI_CODCLI = :CODCLI   '
                   + '   AND CBI_ESPDOC = :ESPDOC   '
                   + '   AND CBI_CODEMP = :CODEMP   ';

  Try

    qrySelectRec := fCriaQuery();
    qrySelectCBI := fCriaQuery();

    result := 0;

    With qrySelectRec Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQLRec);
      ParamByName('AUTOIN').AsString := strAutoInc;
      Open;
    end;

    If Not qrySelectRec.IsEmpty Then
    Begin

      With qrySelectCBI Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMDUP').AsString := qrySelectRec.FieldByName('CTR_NUMDUP').AsString;
        ParamByName('PARCEL').AsString := qrySelectRec.FieldByName('CTR_PARCEL').AsString;
        ParamByName('CODCLI').AsString := qrySelectRec.FieldByName('CTR_CODCLI').AsString;
        ParamByName('ESPDOC').AsString := qrySelectRec.FieldByName('CTR_ESPDOC').AsString;
        ParamByName('CODEMP').AsString := qrySelectRec.FieldByName('CTR_CODEMP').AsString;
        Open;

        If Not qrySelectCBI.IsEmpty Then
           result := qrySelectCBI.FieldByName('CBI_TIPREM').AsInteger;

      End;

    End;

  Finally
    FreeAndNil(qrySelectRec);
    FreeAndNil(qrySelectCBI);
  End;

end;


function CriaDatasetCnfOco: TUniClientDataset;
  Var
    LConsulta: TUniQuery;
Begin
  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT CAST("" AS CHAR(02)) AS  CNF_CODOCO, ' +
                          '       CAST("" AS CHAR(120)) AS CNF_DESOCO, ' +
                          '       CAST("" AS CHAR(02)) AS  CNF_MOTOCO, ' +
                          '       0 AS CNF_GERPAG, ' +
                          '       0 AS CNF_GERREC, ' +
                          '       0 AS CNF_CUSCAR, ' +
                          '       0 AS CNF_USADIA, ' +
                          '       CAST("" AS CHAR(255)) AS CNF_FORNEC, ' +
                          '       CAST("" AS CHAR(255)) AS CNF_PORTAD, ' +
                          '       CAST("" AS CHAR(255)) AS CNF_PLNCON, ' +
                          '       0 AS CNF_TIPDES, ' +
                          '       CAST("" AS CHAR(30)) AS  CNF_DSTPDS  ' +
                          'FROM CNFOCO ' +
                          'WHERE FALSE';
    LConsulta.Open;

    Result := fCriaClientDatSet(LConsulta);
    Result.Open;
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
End;

end.

