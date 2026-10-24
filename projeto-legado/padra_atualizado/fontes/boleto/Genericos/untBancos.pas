unit untBancos;

interface

uses
  Windows, Classes, Forms, Buttons, Menus, frxClass, frxBarcode, Uni, Data.DB,
  untFuncAutban, untTBoletoCarne, untQckBancos, frxDBSet, untTBoleto1Via_Comprovante;

  var strImpressoraSelecionadaBoleto           : String;
  var blnReutilizarImpressoraSelecionadaBoleto : Boolean;

  procedure pInformarImpressoraSelecionadaBoleto(const strImpressora: String);
  function fRetornarImpressoraSelecionadaBoleto: String;
  procedure pLimparImpressoraSelecionadaBoleto;

  procedure pInformarReutilizarImpressoraSelecionadaBoleto(const blnReutilizar: Boolean);
  function fRetornarReutilizarImpressoraSelecionadaBoleto: Boolean;

  //*************************************************//
  // PROCESSA OS DADOS E CALCULA OS DIGITOS          //
  //**********************************************ED*//
  procedure pProArq033B;
  procedure pProArq021;
  procedure pProArq422; // SAFRA 422
  procedure pProArq748; // SICREDI 748

  //*************************************************//
  // BANCOS QUE FORAM FEITOS PADRONIZADOS            //
  //**********************************************ED*//
  function fGeLiDi001: Boolean;
  function fGeLiDi041: Boolean;
  function fGeLiDi104: Boolean;
  function fGeLiDi104D7: Boolean;
  function fGeLiDi237: Boolean;
  function fGeLiDi341: Boolean;
  function fGeLiDi356: Boolean;
  function fGeLiDi399: Boolean;
  function fGeLiDi409: Boolean;
  function fGeLiDi409SemRegistro: Boolean;
  function fGeLiDi741: Boolean;
  function fGeLiDi756: Boolean;
  function fGeLiDi033: Boolean;
  function fGeLiDi033B: Boolean;
  function RetornaModalidaCarteira(ACodigoCarteira:String): String;
  function fProArq389: Boolean;
  function fGeLiDi085: Boolean;
  function fGeLiDi090: Boolean;
  function fGeLiDi003: Boolean;
  function fGeLiDi070: Boolean;
  function fGeLiDi707: Boolean;
  function fGeLiDi246: Boolean;
  function fGeLiDi208: Boolean;
  //*************************************************//
  // OS PRIMEIROS BANCOS QUE FORAM FEITOS E ESTAO    //
  // FORA DE PADRAO, NECESSARIO REFAZER ALGUMAS      //
  // PARTES                                          //
  //**********************************************ED*//
  function  fGeLiDi353: Boolean;
  function  fGeLiDi021: Boolean;
  function  fGeLiDi422: Boolean;
  procedure pGeLiDi151;
  function  fGeLiDi748: Boolean;
  function fGeLiDi004: Boolean;
  function fGeLiDi089: Boolean;
  function fGeLiDi637LP: Boolean;
  function fGeLiDi133: Boolean;
  function fGeLiDi364: Boolean;
  function fGeLiDi274: Boolean;

  function RetornaLinhaDigitavelBancoInter077: Boolean;
  function RetornaLinhaDigitavelBancoDoBrasilApi: Boolean;
  function AlterouVencimento(ALinDig: String):Boolean;
  function RetornaLinhaDigitavelBancoCredisis097: Boolean;
  function RetornaLinhaDigitavelBancoSicrediApi: Boolean;
  function RetornaLinhaDigitavelBancoItauApi: Boolean;
  function RetornaLinhaDigitavelBancoSicoobApi: Boolean;
  function RetornaLinhaDigitavelBancoSantanderApi: Boolean;
  function RetornaLinhaDigitavelBancoSafraApi: Boolean;
  function RetornaLinhaDigitavelBancoBradescoApi: Boolean;

  function GeraBoletoBancoInter077(Var ARelatorio: TfrxReport; Var AAgrupamento: TfrxDBDataSet): Boolean;
  function GeraBoletoBancoDoBrasilApi(Var ARelatorio: TfrxReport; Var AAgrupamento: TfrxDBDataSet; Var AQRCodePix: TfrxDBDataSet): Boolean;
  function GeraBoletoBancoCredisis097(Var ARelatorio: TfrxReport; Var AAgrupamento: TfrxDBDataSet): Boolean;
  function GeraBoletoBancoSicrediApi(Var ARelatorio: TfrxReport; Var AAgrupamento: TfrxDBDataSet; Var AQRCodePix: TfrxDBDataSet): Boolean;
  function GeraBoletoBancoItauApi(Var ARelatorio: TfrxReport; Var AAgrupamento: TfrxDBDataSet; Var AQRCodePix: TfrxDBDataSet): Boolean;
  function GeraBoletoBancoSicoobApi(Var ARelatorio: TfrxReport; Var AAgrupamento: TfrxDBDataSet; Var AQRCodePix: TfrxDBDataSet): Boolean;
  function GeraBoletoBancoSantanderApi(Var ARelatorio: TfrxReport; Var AAgrupamento: TfrxDBDataSet; Var AQRCodePix: TfrxDBDataSet): Boolean;
  function GeraBoletoBancoSafraApi(Var ARelatorio: TfrxReport; Var AAgrupamento: TfrxDBDataSet; Var AQRCodePix: TfrxDBDataSet): Boolean;
  function GeraBoletoBancoBradescoApi(Var ARelatorio: TfrxReport; Var AAgrupamento: TfrxDBDataSet; Var AQRCodePix: TfrxDBDataSet): Boolean;

  //*************************************************//
  // OUTRAS FUNCOES                                  //
  //**********************************************ED*//
  function fImpCodBar(ClasseForm:TFormClass; frmNomFrm: TForm): Boolean;
  function fProArquivo(strIdeBan: String;
                       strNomeForm: String = '';
                       strNomeFila: String = '';
                       blnForcarImp: Boolean = False;
                       blnEnvioDeEmailAutomatico: Boolean = False;
                       blnBolEnvEmail: Boolean = False;
                       blnEnvioFaturamento: Boolean = False): Boolean;

  function fProcessarArquivo(strLines: String; blnImpPdf: Boolean; var ABoletoCarneBuilder : TBoletoCarneBuilder; var ABoleto1ViaBuilder : TBoleto1Via_ComprovanteBuilder;
                             strNomeForm: String = ''; strNomeFila: String = ''; blnForcarImp: Boolean = False;
                             blnEnvioDeEmailAutomatico: Boolean = False;
                             blnBolEnvEmail: Boolean = False;
                             blnEnvioFaturamento: Boolean = False): Boolean;

  function ImprimirLayoutPadrao: Boolean;

  function fValidaLinhaDigitavel(strLinha : String) : Boolean;
  function fRetornaDataFormatoJuliano(dtaDtaVen: TDateTime): String;
  function fQryAgrupamento(strNumDup, strCodEmp, strCodCli: String): TUniQuery;
  procedure pCarregarLayImp(var frmQckBancos: TfrmQckBancos);
  function DuplicatasAgrupadas(ADataSet: TDataSet): String;
  function RetornaObservacaoBancoob: String;
  function RetornaObservacaoSantander: String;
  function RetornaObservacaoCecred(ADefault: String; Var ADuplicatas: String) : String;
  function RetornaObservacaoItau: String;
  function RetornaObservacaoMultaCredisis(dtaVen : Tdatetime) : String;
  function RetornaObservacaoJurosCredisis(dtaVen : Tdatetime): String;
  function RetornaObservacaoMultaBtgPactual: String;
  function RetornaObservacaoJurosBtgPactual: String;
  function RetornaObservacaoMultaSicrediApi(): String;
  function RetornaObservacaoJurosSicrediApi(): String;

  function PossuiImagemLogoCFG: Boolean;

  function ValidaLogoBoleto(ALogoBoleto: String): Boolean;

implementation

uses SysUtils, Dialogs, StrUtils, untFuncoesBoleto, untFuncoesSimples,
     untCfgRel, System.UITypes, untFuncBancarias,
     untTBoletoLayImp, Vcl.Graphics, DateUtils, frxExportPDF;

//**************************************************//
//       ---  U N I B A N C O  ---                  //
//**************************************************//
// COMPOSICAO DO CAMPO LIVRE                        //
// (20-21) 02 - CODIGO PARA TRANSACAO,              //
// (22-27) 06 - DATA VENCTO (AAMMDD),               //
// (28-32) 05 - AGENCIA + DIGITO,                   //
// (33-44) 12 - NOSSO NUMERO(10) + DIG(1) + SD(1),  //
//***********************************************ED*//
function fGeLiDi409: Boolean;
begin

  SetLength(arrValidar, 3);

  arrValidar[0].strNomCam := 'Nosso Número';
  arrValidar[0].strValCam := strNosNum;
  arrValidar[0].strIdeBan := strIdeBan;
  arrValidar[0].intTamCam := 11;

  arrValidar[1].strNomCam := 'Agência';
  arrValidar[1].strValCam := strNumAge;
  arrValidar[1].strIdeBan := strIdeBan;
  arrValidar[1].intTamCam := 4;

  arrValidar[2].strNomCam := 'Dig. Agência';
  arrValidar[2].strValCam := strDigAge;
  arrValidar[2].strIdeBan := strIdeBan;
  arrValidar[2].intTamCam := 1;

  Result := fValidaStrings;
  If Not( Result ) Then
    Exit;

  strDCmLiv := '0';
  strCmpLiv := '';

  strCmpLiv := strCmpLiv + '04'; //FIXO
  strCmpLiv := strCmpLiv + FormatDateTime('YYMMDD', dtaDtaVen);
  strCmpLiv := strCmpLiv + LeftStr(strNumAge, 4) + strDigAge;

  {************************}
  { CALCULA O SUPER DIGITO }
  {*********************JB*}
  //Insert('1', strNosNum, 0);
  strSupDig := fGetModulo11_409('1' + strNosNum, '');

  strCmpLiv := strCmpLiv + strNosNum + strSupDig;

  strDigit1 := fGePriDig(strIdeBan, strMoeda1, LeftStr(strCmpLiv, 5));
  strDigit2 := fGeSegDig(Copy(strCmpLiv, 6, 10), '');
  strDigit3 := fGeTerDig( Copy(strCmpLiv, 16, 10), strDCmLiv);

  {*******************************}
  {* CALCULO O DIG. DO COD.BARRA *}
  {****************************JB*}
  strDiAuCo := fGetModulo11_409('', strIdeBan + strMoeda1 + strFatVen + strVlrTit + strCmpLiv);

  Result := fMontaCodBarLinDig;

end;

//*************************************************//
// --- U N I B A N C O  S E M  R E G I S T R O --- //
//**********************************************ED*//
function fGeLiDi409SemRegistro: Boolean;
  Var
    strPrimeiroGrupo: String;
    strDigPrimeiroGrupo: String;

    strSegundoGrupo: String;
    strDigSegundoGrupo: String;

    strTerceiroGrupo: String;
    strDigTerceiroGrupo: String;

    strQuartoGrupo: String;

    strQuintoGrupo: String;

    strDigVerifCodBarras: String;
begin
  strCodCed := Trim(strCodCed);
  strNosNum := LeftStr(strNosNum, Length(strNosNum)-1);
  strNosNum := fStrZero(strNosNum, 14);

  strVlrTit := fStrZero(strVlrTit, 10);

  {*****************************************}
  {* INICIA MONTAGEM DO CÓDIGO DE BARRAS   *}
  {**************************************MV*}
  strCodBar := '409' +
               '9' +
               //AQUI ENCAIXARIA O DÍGITO
               strFatVen +
               strVlrTit +
               '5' +
               strCodCed +
               '00' +
               strNosNum +
               fGetModulo11_409(strNosNum, '');
               
  strDigVerifCodBarras := fGetModulo11_409('', strCodBar);
  Insert(strDigVerifCodBarras, strCodBar, 5);

  strCodBar := fGerar_String_Codigo_Barra(strCodBar);

  {*****************************************}
  {* INICIA MONTAGEM  DA LINHA DIGITÁVEL.  *}
  {* PRIMEIRO GRUPO.                       *}
  {**************************************MV*}
  strPrimeiroGrupo := '409' +
                      '9'   +
                      '5'   +
                      LeftStr(strCodCed, 4);
  strDigPrimeiroGrupo := fCalcDigitoModulo10(strPrimeiroGrupo);

  strPrimeiroGrupo := strPrimeiroGrupo + strDigPrimeiroGrupo;

  {*****************************************}
  {* SEGUNDO GRUPO.                        *}
  {**************************************MV*}
  strSegundoGrupo := Copy(strCodCed, 5, 3) +
                     '00' +
                     fStrZero(LeftStr(strNosNum, 5), 5);
  strDigSegundoGrupo := fCalcDigitoModulo10(strSegundoGrupo);

  strSegundoGrupo := strSegundoGrupo + strDigSegundoGrupo;

  {*****************************************}
  {* TERCEIRO GRUPO.                       *}
  {**************************************MV*}
  strTerceiroGrupo := Copy(strNosNum, 6, 9) +
                      fGetModulo11_409(strNosNum, '');
  strDigTerceiroGrupo := fCalcDigitoModulo10(strTerceiroGrupo);

  strTerceiroGrupo := strTerceiroGrupo + strDigTerceiroGrupo;
  {*****************************************}
  {* QUARTO GRUPO.                         *}
  {**************************************MV*}
  strQuartoGrupo := strDigVerifCodBarras;

  strQuintoGrupo := strFatVen + strVlrTit;

  strLinDig := strPrimeiroGrupo + strSegundoGrupo + strTerceiroGrupo + strQuartoGrupo + strQuintoGrupo;
  Insert('.', strLinDig, 6);
  Insert(' ', strLinDig, 12);
  Insert('.', strLinDig, 18);
  Insert(' ', strLinDig, 25);
  Insert('.', strLinDig, 31);
  Insert(' ', strLinDig, 38);
  Insert(' ', strLinDig, 40);

   Result := True;
end;

//******************************************//
//  ---  B A N C O  D O  B R A S I L ---    //
//***************************************ED*//
function fGeLiDi001: Boolean;
begin

  fVerificaContido(RightStr(Trim(strCodCar), 2), '_11_12_16_17_18_31_51', 'Carteira');

  //*************************************//
  // COMPOSICAO DO CAMPO LIVRE CART.(12) //
  // (20-30) NOSSO NUMERO,               //
  // (31-34) AGENCIA,                    //
  // (35-42) CEDENTE,                    //
  // (43-44) CARTEIRA                    //
  //**********************************ED*//
  If Pos(RightStr(Trim(strCodCar), 2), '_12') >= 1 Then
  Begin
    SetLength(arrValidar, 4);

    arrValidar[0].strNomCam := 'Agência';
    arrValidar[0].strValCam := strNumAge;
    arrValidar[0].strIdeBan := strIdeBan;
    arrValidar[0].intTamCam := 04;

    If strBB_Crr <> 'S' Then
    Begin
      strCmpLiv := LeftStr(strNosNum,  11) +
                   LeftStr(strNumAge,  04) +
                   LeftStr(strCodCed,  08) +
                   RightStr(strCodCar, 02);

      arrValidar[1].strNomCam := 'Nosso Número';
      arrValidar[1].strValCam := strNosNum;
      arrValidar[1].strIdeBan := strIdeBan;
      arrValidar[1].intTamCam := 11;
    End
    Else
    Begin
      strCmpLiv := '000000'                +
                   LeftStr(strNosNum,  17) +
                   RightStr(strCodCar, 02);

      arrValidar[1].strNomCam := 'Nosso Número';
      arrValidar[1].strValCam := strNosNum;
      arrValidar[1].strIdeBan := strIdeBan;
      arrValidar[1].intTamCam := 17;
    End;

    strDCmLiv := fGeDigCmL(strNosNum,
                           strNumAge,
                           strCodCed,
                           strCodCar,
                           '');

    arrValidar[2].strNomCam := 'Cedente';
    arrValidar[2].strValCam := strCodCed;
    arrValidar[2].strIdeBan := strIdeBan;
    arrValidar[2].intTamCam := 08;

    arrValidar[3].strNomCam := 'Carteira';
    arrValidar[3].strValCam := strCodCar;
    arrValidar[3].strIdeBan := strIdeBan;
    arrValidar[3].intTamCam := 02;
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
    SetLength(arrValidar, 3);

    arrValidar[0].strNomCam := 'Agência';
    arrValidar[0].strValCam := strNumAge;
    arrValidar[0].strIdeBan := strIdeBan;
    arrValidar[0].intTamCam := 04;

    arrValidar[1].strNomCam := 'Número do Convênio';
    arrValidar[1].strValCam := strNumCon;
    arrValidar[1].strIdeBan := strIdeBan;
    arrValidar[1].intTamCam := 06;

    If strBB_Crr <> 'S' Then
    Begin
      strCmpLiv := strNumCon +
                   fStrZero(Copy(strNosNum, 1, Length(strNosNum)-1), 17) +
                   '21';

      arrValidar[2].strNomCam := 'Nosso Número';
      arrValidar[2].strValCam := strNosNum;
      arrValidar[2].strIdeBan := strIdeBan;
      arrValidar[2].intTamCam := 10;
    End
    Else
    Begin
      strCmpLiv := '000000'          +
             LeftStr(strNosNum,  17) +
             RightStr(strCodCar, 02);

      arrValidar[2].strNomCam := 'Nosso Número';
      arrValidar[2].strValCam := strNosNum;
      arrValidar[2].strIdeBan := strIdeBan;
      arrValidar[2].intTamCam := 17;
    End;

    strDCmLiv := fGeDigCmL(strCmpLiv, '','', '', '');

  End

  Else If ( Pos(RightStr(Trim(strCodCar), 2), '17') >= 1 ) And (Length(strNumCon) <= 6) Then
  Begin
    SetLength(arrValidar, 3);

    arrValidar[0].strNomCam := 'Agência';
    arrValidar[0].strValCam := strNumAge;
    arrValidar[0].strIdeBan := strIdeBan;
    arrValidar[0].intTamCam := 04;

    arrValidar[1].strNomCam := 'Número do Convênio';
    arrValidar[1].strValCam := strNumCon;
    arrValidar[1].strIdeBan := strIdeBan;
    arrValidar[1].intTamCam := 06;

    If strBB_Crr <> 'S' Then
    Begin
      strCmpLiv := strNumCon + RightStr(LeftStr(strNosNum, 11),5) +
                   LeftStr(strNumAge, 4) +
                   fStrZero(Copy(strCodCed, 1, Length(strCodCed)-1),8) +
                   fStrZero(StrToInt(strCodCar), 2);

      arrValidar[2].strNomCam := 'Nosso Número';
      arrValidar[2].strValCam := strNosNum;
      arrValidar[2].strIdeBan := strIdeBan;
      arrValidar[2].intTamCam := 12;
    End
    Else
    Begin
      strCmpLiv := '000000'          +
             LeftStr(strNosNum,  17) +
             RightStr(strCodCar, 02);

      arrValidar[2].strNomCam := 'Nosso Número';
      arrValidar[2].strValCam := strNosNum;
      arrValidar[2].strIdeBan := strIdeBan;
      arrValidar[2].intTamCam := 17;
    End;

    strDCmLiv := fGeDigCmL(strCmpLiv, '','', '', '');

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
    SetLength(arrValidar, 4);

    arrValidar[0].strNomCam := 'Agência';
    arrValidar[0].strValCam := strNumAge;
    arrValidar[0].strIdeBan := strIdeBan;
    arrValidar[0].intTamCam := 04;

    arrValidar[1].strNomCam := 'Nosso Número';
    arrValidar[1].strValCam := strNosNum;
    arrValidar[1].strIdeBan := strIdeBan;
    arrValidar[1].intTamCam := 10;

    If strBB_Crr <> 'S' Then
    Begin
      strCmpLiv := '000000' +
                   strNumCon +
                   LeftStr(Trim(strNosNum), 10) +
                   RightStr(strCodCar, 2);

      arrValidar[2].strNomCam := 'Nosso Número';
      arrValidar[2].strValCam := strNosNum;
      arrValidar[2].strIdeBan := strIdeBan;
      arrValidar[2].intTamCam := 07;
    End
    Else
    Begin
      strCmpLiv := '000000'          +
             LeftStr(strNosNum,  17) +
             RightStr(strCodCar, 02);

      arrValidar[2].strNomCam := 'Nosso Número';
      arrValidar[2].strValCam := strNosNum;
      arrValidar[2].strIdeBan := strIdeBan;
      arrValidar[2].intTamCam := 17;
    End;

    arrValidar[3].strNomCam := 'Carteira';
    arrValidar[3].strValCam := strCodCar;
    arrValidar[3].strIdeBan := strIdeBan;
    arrValidar[3].intTamCam := 02;

    strDCmLiv := fGeDigCmL(strCmpLiv, '', '', '', '');
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
    SetLength(arrValidar, 3);

    arrValidar[0].strNomCam := 'Agência';
    arrValidar[0].strValCam := strNumAge;
    arrValidar[0].strIdeBan := strIdeBan;
    arrValidar[0].intTamCam := 04;

    If strBB_Crr <> 'S' Then
    Begin
      strCmpLiv := '000000' +
                   strNumCon +
                   RightStr(Trim(strNosNum), 10) +
                   RightStr(strCodCar, 2);

      arrValidar[1].strNomCam := 'Nosso Número';
      arrValidar[1].strValCam := strNosNum;
      arrValidar[1].strIdeBan := strIdeBan;
      arrValidar[1].intTamCam := 07;
    End
    Else
    Begin
      strCmpLiv := '000000'          +
             LeftStr(strNosNum,  17) +
             RightStr(strCodCar, 02);

      arrValidar[1].strNomCam := 'Nosso Número';
      arrValidar[1].strValCam := strNosNum;
      arrValidar[1].strIdeBan := strIdeBan;
      arrValidar[1].intTamCam := 17;
    End;

    arrValidar[2].strNomCam := 'Carteira';
    arrValidar[2].strValCam := strCodCar;
    arrValidar[2].strIdeBan := strIdeBan;
    arrValidar[2].intTamCam := 02;

    strDCmLiv := fGeDigCmL(strCmpLiv, '', '', '', '');
  End;

  Result := fValidaStrings;
  If Not( Result ) Then
    Exit;

  fCalculaDigitos;
  Result := fMontaCodBarLinDig;
end;

function fGeLiDi070: Boolean;
begin
   //*****************************************//
  //            ---  B R B ---                //
  //******************************************//

  SetLength(arrValidar, 2);

  arrValidar[0].strNomCam := 'Nosso Número';
  arrValidar[0].strValCam := strNosNum;
  arrValidar[0].strIdeBan := strIdeBan;
  arrValidar[0].intTamCam := 6;

  arrValidar[1].strNomCam := 'Conta Corrente';
  arrValidar[1].strValCam := strCodCed;
  arrValidar[1].strIdeBan := strIdeBan;
  arrValidar[1].intTamCam := 10;

  Result := fValidaStrings;
  If Not( Result ) Then
    Exit;

  strVlrTit  := fStrZero(strVlrTit, 10);

  strCmpLiv := strChaveBRB;

  strNosNum := Copy(strChaveBRB, 14, Length(strChaveBRB));

  strIdeBan := '070';
  strMoeda1 := '9';

  fCalculaDigitos;
  Result := fMontaCodBarLinDig;
end;

{******************************************}
{*        BANCO DAYCOVAL [400P]           *}
{*            LAYOUT PRÓPRIO              *}
{*REQ:147378****************************MT*}
function fGeLiDi707: Boolean;
begin

  SetLength(arrValidar, 4);

  arrValidar[0].strNomCam := 'Nosso Número';
  arrValidar[0].strValCam := strNosNum;
  arrValidar[0].strIdeBan := strIdeBan;
  arrValidar[0].intTamCam := 9;

  arrValidar[1].strNomCam := 'Agência';
  arrValidar[1].strValCam := strNumAge;
  arrValidar[1].strIdeBan := strIdeBan;
  arrValidar[1].intTamCam := 4;

  arrValidar[2].strNomCam := 'Cedente';
  arrValidar[2].strValCam := strCodCed;
  arrValidar[2].strIdeBan := strIdeBan;
  arrValidar[2].intTamCam := 6;

  arrValidar[3].strNomCam := 'Carteira';
  arrValidar[3].strValCam := strCodCar;
  arrValidar[3].strIdeBan := strIdeBan;
  arrValidar[3].intTamCam := 3;

  Result := fValidaStrings;
  If Not( Result ) Then
    Exit;


  strDCmLiv := '0';

  strCmpLiv := '';
  strCmpLiv := strCmpLiv + LeftStr(strNumAge, 4);
  strCmpLiv := strCmpLiv + RightStr(strCodCar, 3);
  strCmpLiv := strCmpLiv + LeftStr(Trim(strInfAdi), 7);
  strCmpLiv := strCmpLiv + LeftStr(fStrZero(Trim(strNosNum), 11),11);
  //strCmpLiv := strCmpLiv + strDCmLiv;

  Result := fCalculaDigitos;
  Result := (Result) And (fMontaCodBarLinDig);
end;

{******************************************}
{*           BANCO ABC BRASIL             *}
{*            LAYOUT PRÓPRIO              *}
{*REQ:185769****************************TA*}
function fGeLiDi246: Boolean;
begin

  SetLength(arrValidar, 4);

  arrValidar[0].strNomCam := 'Cód. Agencia';
  arrValidar[0].strValCam := strNumAge;
  arrValidar[0].strIdeBan := strIdeBan;
  arrValidar[0].intTamCam := 4;

  arrValidar[1].strNomCam := 'Carteira';
  arrValidar[1].strValCam := strCodCar;
  arrValidar[1].strIdeBan := strIdeBan;
  arrValidar[1].intTamCam := 3;

  arrValidar[2].strNomCam := 'Número Operação';
  arrValidar[2].strValCam := strNroOpe;
  arrValidar[2].strIdeBan := strIdeBan;
  arrValidar[2].intTamCam := 7;

  arrValidar[3].strNomCam := 'Nosso Número';
  arrValidar[3].strValCam := strNosNum;
  arrValidar[3].strIdeBan := strIdeBan;
  arrValidar[3].intTamCam := 11;

  Result := fValidaStrings;
  If Not( Result ) Then
    Exit;

  //strDigNossoNum := fCalcDigitoModulo10( strNumAge + strCodCar + strNosNum );

  strDCmLiv := '0';

  strCmpLiv := '';
  strCmpLiv := strCmpLiv + LeftStr(strNumAge, 4);
  strCmpLiv := strCmpLiv + RightStr(strCodCar, 3);
  strCmpLiv := strCmpLiv + LeftStr(Trim(strNroOpe), 7);
  strCmpLiv := strCmpLiv + LeftStr(fStrZero(Trim(strNosNum), 11),11);
  //strCmpLiv := strCmpLiv + strDCmLiv;

  Result := fCalculaDigitos;
  Result := (Result) And (fMontaCodBarLinDig);
end;

{******************************************}
{*        BANCO BTG PACTUAL [240P]        *}
{*            LAYOUT PRÓPRIO              *}
{******************************************}
function fGeLiDi208: Boolean;
begin

  SetLength(arrValidar, 4);

  arrValidar[0].strNomCam := 'Nosso Número';
  arrValidar[0].strValCam := strNosNum;
  arrValidar[0].strIdeBan := strIdeBan;
  arrValidar[0].intTamCam := 11;

  arrValidar[1].strNomCam := 'Agência';
  arrValidar[1].strValCam := strNumAge;
  arrValidar[1].strIdeBan := strIdeBan;
  arrValidar[1].intTamCam := 4;

  arrValidar[2].strNomCam := 'Conta Corrente';
  arrValidar[2].strValCam := strCodCed;
  arrValidar[2].strIdeBan := strIdeBan;
  arrValidar[2].intTamCam := 7;

  arrValidar[3].strNomCam := 'Carteira';
  arrValidar[3].strValCam := strCodCar;
  arrValidar[3].strIdeBan := strIdeBan;
  arrValidar[3].intTamCam := 1;

  Result := fValidaStrings;
  If Not( Result ) Then
    Exit;

  strDCmLiv := '0';

  strCmpLiv := '';
  strCmpLiv := strCmpLiv + LeftStr(strNumAge, 4);
  strCmpLiv := strCmpLiv + RightStr(strCodCar, 2);
  strCmpLiv := strCmpLiv + LeftStr(fStrZero(Trim(strNosNum), 11),11);
  strCmpLiv := strCmpLiv + LeftStr(Trim(strCodCed), 7);
  strCmpLiv := strCmpLiv + strDCmLiv;

  Result := fCalculaDigitos;
  Result := (Result) And (fMontaCodBarLinDig);
end;

function fGeLiDi237: Boolean;
begin

  //******************************************//
  //       ---  B R A D E S C O ---           //
  //******************************************//
  // COMPOSICAO DO CAMPO LIVRE                //
  // (20-23)  4 - AGENCIA DO CEDENTE ,        //
  // (24-25)  2 - CARTEIRA,                   //
  // (26-36) 11 - NUMERO DO NOSSO NUMERO,     //
  // (37-43)  7 - CONTA DO CEDENTE,           //
  // (44-44)  1 - ZERO,                       //
  //***************************************ED*//

  SetLength(arrValidar, 4);

  //*************************************************//
  // ESTOU VALIDANDO COM 12 POIS EU PRESCISO DO DIG. //
  // CONCATENADO COM O NOSSO NUMERO, PARA FAZER A    //
  // IMPRESSAO. POREM NO CALCULO DA LIN. DIGITAVEL   //
  // SAO NECESSARIOS APENAS OS 11 PRIMEIROS CARAC.   //
  //**********************************************ED*//
  arrValidar[0].strNomCam := 'Nosso Número';
  arrValidar[0].strValCam := strNosNum;
  arrValidar[0].strIdeBan := strIdeBan;
  arrValidar[0].intTamCam := 12;

  arrValidar[1].strNomCam := 'Cedente';
  arrValidar[1].strValCam := strCodCed;
  arrValidar[1].strIdeBan := strIdeBan;
  arrValidar[1].intTamCam := 7;

  arrValidar[2].strNomCam := 'Agência';
  arrValidar[2].strValCam := LeftStr(strNumAge, 4);
  arrValidar[2].strIdeBan := strIdeBan;
  arrValidar[2].intTamCam := 4;

  arrValidar[3].strNomCam := 'Carteira';
  arrValidar[3].strValCam := RightStr(strCodCar, 2);
  arrValidar[3].strIdeBan := strIdeBan;
  arrValidar[3].intTamCam := 2;

  Result := fValidaStrings;
  If Not( Result ) Then
    Exit;


  strDCmLiv := '0';

  strCmpLiv := '';
  strCmpLiv := strCmpLiv + LeftStr(strNumAge, 4);
  strCmpLiv := strCmpLiv + RightStr(strCodCar, 2);
  strCmpLiv := strCmpLiv + LeftStr(Trim(strNosNum), 11);
  strCmpLiv := strCmpLiv + LeftStr(Trim(strCodCed), 7);
  strCmpLiv := strCmpLiv + strDCmLiv;

  fCalculaDigitos;
  Result := fMontaCodBarLinDig;

end;







function fGeLiDi741: Boolean;
begin

  //******************************************//
  //      ---  R I B.  P R E T O  ---         //
  //******************************************//
  // COMPOSICAO DO CAMPO LIVRE                //
  // (20-23)  4 - AGENCIA DO CEDENTE ,        //
  // (24-25)  2 - CARTEIRA,                   //
  // (26-36) 11 - NUMERO DO NOSSO NUMERO,     //
  // (37-43)  7 - CONTA DO CEDENTE,           //
  // (44-44)  1 - ZERO,                       //
  //***************************************ED*//


  //*****************************************************//
  // ATRIBUI A VARIAVEL O NUMERO DO BANCO BRADESCO, JA   //
  // QUE A COBRANCA E FEITA REALMENTE PELO BRADESCO      //
  //**************************************************ED*//
  strIdeBan := '237';
  strNomCed := 'BANCO Ribeirão Preto S/A';
  strTipIns := '01';
  strSacAva := strSacAva + ' - ' + fMaskCNPJ(strNumIns);
  strNumIns := '00517645000104';


  SetLength(arrValidar, 4);

  arrValidar[0].strNomCam := 'Nosso Número';
  arrValidar[0].strValCam := strNosNum;
  arrValidar[0].strIdeBan := '741';
  arrValidar[0].intTamCam := 12;

  arrValidar[1].strNomCam := 'Cedente';
  arrValidar[1].strValCam := strCodCed;
  arrValidar[1].strIdeBan := '741';
  arrValidar[1].intTamCam := 8;

  arrValidar[2].strNomCam := 'Agência';
  arrValidar[2].strValCam := LeftStr(strNumAge, 4);
  arrValidar[2].strIdeBan := '741';
  arrValidar[2].intTamCam := 4;

  arrValidar[3].strNomCam := 'Carteira';
  arrValidar[3].strValCam := RightStr(strCodCar, 2);
  arrValidar[3].strIdeBan := '741';
  arrValidar[3].intTamCam := 2;

  Result := fValidaStrings;
  If Not( Result ) Then
    Exit;

  strDCmLiv := '0';
  strCmpLiv := '';
  strCmpLiv := strCmpLiv + LeftStr(strNumAge, 4);
  strCmpLiv := strCmpLiv + RightStr(strCodCar, 2);
  strCmpLiv := strCmpLiv + fStrZero(Copy(Trim(strNosNum), 1, Length(Trim(strNosNum))-1), 11);
  strCmpLiv := strCmpLiv + Copy(Trim(strCodCed), 1, Length(Trim(strCodCed))-1);
  strCmpLiv := strCmpLiv + strDCmLiv;

  fCalculaDigitos;
  Result := fMontaCodBarLinDig;

end;



//******************************************//
// ---  C A I X A  ECON. F E D E R A L  --- //
//******************************************//
function fGeLiDi104: Boolean;
  Const
    strBase = '98765432987654329876543298765432';

  Var
    intDigCed  : Integer;
    intDigCpl  : Integer;
    intContador: Integer;
    intFator1  : Integer;
    intFator2  : Integer;

    LEmpresa: String;
    LCarteira : String;
    LResponsavelEmissaoBoleto: String;
begin
  fVerificaContido(LeftStr(strCodCar, 2), '_01_08_11_12_14_24_41', 'Carteira');

  If (Pos(strCodCar, '_11_12_14_41') >= 1)             And
     ((fEmptyStr(Trim(strSisCob))) Or (strSisCob = 'SICOB')) Then
  Begin
    SetLength(arrValidar, 3);

    //********* SISTEMA DE COBRANÇA SICOB ***************************//
    //                                                               //
    // COBRANCA SEM REGISTRO - COMPOSICAO DO CAMPO LIVRE (CEF)       //
    //     (20-21) 2 - IDENTIFICACAO DE CARTEIRA ( 80, 81 OU 82 )    //
    //     (22-29) 8 - NOSSO NUMERO                                  //
    //     (30-33) 4 - CNPJ DA AGENCIA CEDENTE                       //
    //     (34-36) 3 - OPERACAO CODIGO DO CEDENTE                    //
    //     (37-44) 8 - CODIGO DO CEDENTE FORNECIDO PELA AGENCIA      //
    //                                                               //
    // COBRANCA RAPIDA - COMPOSICAO DO CAMPO LIVRE (CEF)             //
    //     (20-20) 1 - IDENTIFICACAO DE CARTEIRA FIXO ( 9 )          //
    //     (21-29) 9 - NOSSO NUMERO                                  //
    //     (30-33) 4 - CNPJ DA AGENCIA CEDENTE                       //
    //     (34-36) 3 - OPERACAO CODIGO DO CEDENTE                    //
    //     (37-44) 8 - CODIGO DO CEDENTE FORNECIDO PELA AGENCIA      //
    //                                                               //
    //************************************************************ED*//
    If StrToInt(LeftStr(Trim(strNosNum), 1)) = 9 Then
    Begin
      // COBRANÇA RAPIDA

      strCmpLiv := '';
      strCmpLiv := strCmpLiv + LeftStr(Trim(strNosNum), Length(Trim(strNosNum))-1); // 10
      strCmpLiv := strCmpLiv + LeftStr(Trim(strNumAge), 4);                         //  4
      strCmpLiv := strCmpLiv + LeftStr(strCodCed, 11);                              // 11

      arrValidar[0].strNomCam := 'Nosso Número';
      arrValidar[0].strValCam := strNosNum;
      arrValidar[0].strIdeBan := strIdeBan;
      arrValidar[0].intTamCam := 11;

      arrValidar[1].strNomCam := 'Agência';
      arrValidar[1].strValCam := strNumAge;
      arrValidar[1].strIdeBan := strIdeBan;
      arrValidar[1].intTamCam := 04;

      arrValidar[2].strNomCam := 'Cedente';
      arrValidar[2].strValCam := strCodCed;
      arrValidar[2].strIdeBan := strIdeBan;
      arrValidar[2].intTamCam := 12;

      Result := fValidaStrings;
      If Not( Result ) Then
        Exit;
    End
    Else If StrToInt(LeftStr(Trim(strNosNum), 2)) < 90 Then
    Begin
      // COBRANÇA SEM REGISTRO

      strCmpLiv := '';
      strCmpLiv := strCmpLiv + LeftStr(Trim(strNosNum), Length(Trim(strNosNum))-1); // 11
      strCmpLiv := strCmpLiv + LeftStr(Trim(strNumAge), 4);                         //  4
      strCmpLiv := strCmpLiv + LeftStr(strCodCed, 11);                              // 11

      arrValidar[0].strNomCam := 'Nosso Número';
      arrValidar[0].strValCam := strNosNum;
      arrValidar[0].strIdeBan := strIdeBan;
      arrValidar[0].intTamCam := 11;

      arrValidar[1].strNomCam := 'Agência';
      arrValidar[1].strValCam := strNumAge;
      arrValidar[1].strIdeBan := strIdeBan;
      arrValidar[1].intTamCam := 04;

      arrValidar[2].strNomCam := 'Cedente';
      arrValidar[2].strValCam := strCodCed;
      arrValidar[2].strIdeBan := strIdeBan;
      arrValidar[2].intTamCam := 12;

      fVerificaContido(LeftStr(Trim(strNosNum), 02), '_80_81_82', 'Ínicio do Nosso Número');

      Result := fValidaStrings;
      If Not( Result ) Then
        Exit;
    End;

  End
  Else If (Pos(strCodCar, '_01') >= 1)                      And
          ((fEmptyStr(Trim(strSisCob))) Or (strSisCob = 'SINCO')) Then
  Begin
    SetLength(arrValidar, 2);
    //********* SISTEMA DE COBRANÇA SINCO ***************************************************//
    //                                                                                       //
    // COMPOSICAO DO CAMPO LIVRE (CAIXA ECONOMICA FEDERAL) - COBRANCA SEM REGISTRO           //
    // (20-20) 1 - CONSTANTE, FIXO (1)                                                       //
    // (21-26) 6 - CÓDIGO DO CLIENTE/CEDENTE FORNECIDO PELA CAIXA                            //
    // (27-27) 1 - CONSTANTE, FIXO(9)                                                        //
    // (28-32) 6 - CONSTANTE, FIXO(000000) (A T E N Ç Ã O ) - Leia abaixo                    //
    //             Foi atribuido a constante (0) ao nosso número pois no lay-out original    //
    //             o nosso número era exportado para o txt com no máximo 15 posições         //
    //                                                                                       //
    // (33-44) 12 - NOSSO NÚMERO                                                             //
    //                                                                                       //
    //************************************************************************************ED*//

    strCmpLiv := '';
    strCmpLiv := strCmpLiv + '1';                                           //  1
    strCmpLiv := strCmpLiv + LeftStr(Trim(strCodCed), 06);                  //  6
    strCmpLiv := strCmpLiv + '9';                                           //  1
    strCmpLiv := strCmpLiv + '000000';                                      //  6
    strCmpLiv := strCmpLiv + LeftStr(strNosNum, Length(Trim(strNosNum))-1); // 11

    arrValidar[0].strNomCam := 'Nosso Número';
    arrValidar[0].strValCam := strNosNum;
    arrValidar[0].strIdeBan := strIdeBan;
    arrValidar[0].intTamCam := 12;

    arrValidar[1].strNomCam := 'Cedente';
    arrValidar[1].strValCam := strCodCed;
    arrValidar[1].strIdeBan := strIdeBan;
    arrValidar[1].intTamCam := 06;

    Result := fValidaStrings;
    If Not( Result ) Then
      Exit;
  End
  Else If (Pos(strCodCar, '_08') >= 1)                       And
          ((fEmptyStr(Trim(strSisCob))) Or (strSisCob = 'SINCO'))  Then
  Begin
    SetLength(arrValidar, 2);

    {********* SISTEMA DE COBRANÇA SINCO COM NOSSO NUMERO DE 16 POSIÇÕES********************}
    {*                                                                                     *}
    {* COMPOSICAO DO CAMPO LIVRE (CAIXA ECONOMICA FEDERAL) - COBRANCA SEM REGISTRO         *}
    {* (20-24) 5 - CÓDIGO DO CEDENTE FORNECIDO PELA CAIXA                                  *}
    {* (25-28) 4 - CÓDIGO DA AGÊNCIA                                                       *}
    {* (29-29) 1 - CÓDIGO DA CARTEIRA - CONSTANTE, FIXO(8)                                 *}
    {* (30-30) 1 - CONSTANTE, FIXO(7)                                                      *}
    {* (31-44) 14- NOSSO NÚMERO                                                            *}
    {*                                                                                     *}
    {************************************************************************************AF*}

    strCmpLiv := '';
    strCmpLiv := strCmpLiv + LeftStr(RightStr(Trim(strCodCed), 06), 5);                   //  5
    strCmpLiv := strCmpLiv + Trim(strNumAge);                                             //  4
    strCmpLiv := strCmpLiv + '8';                                                         //  1
    strCmpLiv := strCmpLiv + '7';                                                         //  1
    strCmpLiv := strCmpLiv + fStrZero(LeftStr(strNosNum, Length(Trim(strNosNum))-1), 14); // 14

    arrValidar[0].strNomCam := 'Nosso Número';
    arrValidar[0].strValCam := strNosNum;
    arrValidar[0].strIdeBan := strIdeBan;
    arrValidar[0].intTamCam := 11;

    arrValidar[1].strNomCam := 'Agência';
    arrValidar[1].strValCam := strNumAge;
    arrValidar[1].strIdeBan := strIdeBan;
    arrValidar[1].intTamCam := 04;

    Result := fValidaStrings;
    If Not( Result ) Then
      Exit;
  End
  Else If (Pos(strCodCar, '_14_24') >= 1)                         And
          ((fEmptyStr(Trim(strSisCob))) Or (strSisCob = 'SIGCB')) Then
  Begin
    intDigCed := 0;
    intDigCpl := 0;                                                                            
    strNosNum := fStrZero(strNosNum,16);                                                       

    LEmpresa := RightStr(LIdentificacaoBanco, 3);
    LCarteira := AnsiReplaceStr(LIdentificacaoBanco,RightStr(LIdentificacaoBanco, 4),'');
    LResponsavelEmissaoBoleto := fGetBancoConfig(0,LCarteira,'RESPONS', '',LEmpresa);

    {**************************************}
    {* CALCULO DO DIGITO VERIFICADOR DO   *}                                                  
    {* CÓDIGO DO CEDENTE                  *}                                                 
    {***********************************AF*}                                                  
    For intContador := 6 DownTo 1 Do
    Begin                                                                                     
      intFator1 := StrToInt(LeftStr(Trim(strCodCed), 06)[intContador]);
      intFator2 := StrToInt(RightStr(strBase, 06)[intContador]);

      intDigCed := intDigCed + (intFator1 * intFator2);                                       
    End;                                                                                      

    {**************************************}
    {* SE O RESULTADO DA SOMA FOR MENOR   *}                                                   
    {* QUE 11 ENTAO O DIGITO É 11 - SOMA  *}                                                  
    {* OU FAZ UM MONTE DE OUTRAS COISAS   *}                                                   
    {***********************************AF*}                                                   
    If intDigCed < 11 Then                                                                     
    Begin                                                                                      
      intDigCed := 11 - intDigCed;                                                             
    End                                                                                        
    Else                                                                                       
    Begin                                                                                      
      intDigCed := intDigCed Mod 11;                                                           
      intDigCed := 11 - intDigCed;                                                             

      If intDigCed > 9 Then                                                                    
        intDigCed := 0;                                                                        
    End;                                                                                       

    strDigCed := IntToStr(intDigCed);                                                          

    //********* SISTEMA DE COBRANÇA SIGCB ***************************************************//
    //                                                                                       //
    // COMPOSICAO DO CAMPO LIVRE (CAIXA ECONOMICA FEDERAL)                                   //
    // (20-25) 6 - CÓDIGO DO CLIENTE/CEDENTE FORNECIDO PELA CAIXA                            //
    // (26-26) 1 - DIGITO VERIFICADOR DO CODIGO DO CEDENTE                                   //
    // (27-29) 3 - 1ª PARTE DO NOSSO NUMERO DO CLIENTE                                       //
    // (30-30) 1 - CONSTANTE 1 PARA DEFINIÇÃO DA CARTEIRA                                    //
    // (31-33) 3 - 2ª PARTE DO NOSSO NUMERO DO CLIENTE                                       //
    // (34-34) 1 - CONSTANTE 2 PARA IMPRESSÃO DO BLOQUETO                                    //
    // (35-43) 9 - 3ª PARTE DO NOSSO NÚMERO DO CLIENTE                                       //
    // (44-44) 1 - DIGITO VERIFICADOR DO CAMPO LIVRE                                         //
    //                                                                                       //
    //************************************************************************************ED*//

    strCmpLiv := '';
    strCmpLiv := strCmpLiv + LeftStr(Trim(strCodCed),     06);   //  6                         
    strCmpLiv := strCmpLiv + IntToStr(intDigCed);                //  1                         
    strCmpLiv := strCmpLiv + LeftStr(strNosNum,           03);   //  3
    strCmpLiv := strCmpLiv + IIF( strCodCar = '14', '1', '2');   //  1
    strCmpLiv := strCmpLiv + Copy(strNosNum, 4,           03);   //  3
    strCmpLiv := strCmpLiv + IIF( LResponsavelEmissaoBoleto = 'B', '1', '4');    //  1
    strCmpLiv := strCmpLiv + Copy(strNosNum, 7,           09);   //  9

    {**************************************}
    {* CALCULO DO DIGITO VERIFICADOR DO   *}                                                   
    {* CAMPO LIVRE                        *}                                                   
    {***********************************AF*}                                                   
    For intContador := 24 DownTo 1 Do                                                          
    Begin                                                                                      
      intFator1 := StrToInt( strCmpLiv[intContador] );                                         
      intFator2 := StrToInt( RightStr(strBase,24)[intContador] );                              

      intDigCpl := intDigCpl + (intFator1 * intFator2);                                        
    End;                                                                                       

    {**************************************}
    {* SE O RESULTADO DA SOMA FOR MENOR   *}                                                 
    {* QUE 11 ENTAO O DIGITO É 11 - SOMA  *}                                                
    {* OU FAZ UM MONTE DE OUTRAS COISAS   *}                                                 
    {***********************************AF*}                                                 
    If intDigCpl < 11 Then                                                                   
    Begin                                                                                    
      intDigCpl := 11 - intDigCpl;                                                           
    End                                                                                      
    Else                                                                                     
    Begin                                                                                    
      intDigCpl := intDigCpl Mod 11;                                                         
      intDigCpl := 11 - intDigCpl;                                                           

      If intDigCpl > 9 Then                                                                  
        intDigCpl := 0;                                                                      
    End;                                                                                     

    strCmpLiv := strCmpLiv + IntToStr(intDigCpl);

  End;

  fCalculaDigitos;
  Result := fMontaCodBarLinDig;
end;

//****************7 DIGITOS*****************//
// ---  C A I X A  ECON. F E D E R A L  --- //
//******************************************//
function fGeLiDi104D7: Boolean;
  Const
    strBase = '98765432987654329876543298765432';
  Var
    intDigCed  : Integer;
    intDigCpl  : Integer;
    intContador: Integer;
    intFator1  : Integer;
    intFator2  : Integer;
begin

  fVerificaContido(LeftStr(strCodCar, 2), '_01_08_11_12_14_24_41', 'Carteira');

  If (Pos(strCodCar, '_11_12_14_41') >= 1)             And
     ((fEmptyStr(Trim(strSisCob))) Or (strSisCob = 'SICOB')) Then
  Begin
    SetLength(arrValidar, 3);

    //********* SISTEMA DE COBRANÇA SICOB ***************************//
    //                                                               //
    // COBRANCA SEM REGISTRO - COMPOSICAO DO CAMPO LIVRE (CEF)       //
    //     (20-21) 2 - IDENTIFICACAO DE CARTEIRA ( 80, 81 OU 82 )    //
    //     (22-29) 8 - NOSSO NUMERO                                  //
    //     (30-33) 4 - CNPJ DA AGENCIA CEDENTE                       //
    //     (34-36) 3 - OPERACAO CODIGO DO CEDENTE                    //
    //     (37-44) 8 - CODIGO DO CEDENTE FORNECIDO PELA AGENCIA      //
    //                                                               //
    // COBRANCA RAPIDA - COMPOSICAO DO CAMPO LIVRE (CEF)             //
    //     (20-20) 1 - IDENTIFICACAO DE CARTEIRA FIXO ( 9 )          //
    //     (21-29) 9 - NOSSO NUMERO                                  //
    //     (30-33) 4 - CNPJ DA AGENCIA CEDENTE                       //
    //     (34-36) 3 - OPERACAO CODIGO DO CEDENTE                    //
    //     (37-44) 8 - CODIGO DO CEDENTE FORNECIDO PELA AGENCIA      //
    //                                                               //
    //************************************************************ED*//
    If StrToInt(LeftStr(Trim(strNosNum), 1)) = 9 Then
    Begin
      // COBRANÇA RAPIDA

      strCmpLiv := '';
      strCmpLiv := strCmpLiv + LeftStr(Trim(strNosNum), Length(Trim(strNosNum))-1); // 10
      strCmpLiv := strCmpLiv + LeftStr(Trim(strNumAge), 4);                         //  4
      strCmpLiv := strCmpLiv + LeftStr(strCodCed, 11);                              // 11

      arrValidar[0].strNomCam := 'Nosso Número';
      arrValidar[0].strValCam := strNosNum;
      arrValidar[0].strIdeBan := strIdeBan;
      arrValidar[0].intTamCam := 11;

      arrValidar[1].strNomCam := 'Agência';
      arrValidar[1].strValCam := strNumAge;
      arrValidar[1].strIdeBan := strIdeBan;
      arrValidar[1].intTamCam := 04;

      arrValidar[2].strNomCam := 'Cedente';
      arrValidar[2].strValCam := strCodCed;
      arrValidar[2].strIdeBan := strIdeBan;
      arrValidar[2].intTamCam := 12;

      Result := fValidaStrings;
      If Not( Result ) Then
        Exit;
    End
    Else If StrToInt(LeftStr(Trim(strNosNum), 2)) < 90 Then
    Begin
      // COBRANÇA SEM REGISTRO

      strCmpLiv := '';
      strCmpLiv := strCmpLiv + LeftStr(Trim(strNosNum), Length(Trim(strNosNum))-1); // 11
      strCmpLiv := strCmpLiv + LeftStr(Trim(strNumAge), 4);                         //  4
      strCmpLiv := strCmpLiv + LeftStr(strCodCed, 11);                              // 11

      arrValidar[0].strNomCam := 'Nosso Número';
      arrValidar[0].strValCam := strNosNum;
      arrValidar[0].strIdeBan := strIdeBan;
      arrValidar[0].intTamCam := 11;

      arrValidar[1].strNomCam := 'Agência';
      arrValidar[1].strValCam := strNumAge;
      arrValidar[1].strIdeBan := strIdeBan;
      arrValidar[1].intTamCam := 04;

      arrValidar[2].strNomCam := 'Cedente';
      arrValidar[2].strValCam := strCodCed;
      arrValidar[2].strIdeBan := strIdeBan;
      arrValidar[2].intTamCam := 12;

      fVerificaContido(LeftStr(Trim(strNosNum), 02), '_80_81_82', 'Ínicio do Nosso Número');

      Result := fValidaStrings;
      If Not( Result ) Then
        Exit;
    End;

  End
  Else If (Pos(strCodCar, '_01') >= 1)                      And
          ((fEmptyStr(Trim(strSisCob))) Or (strSisCob = 'SINCO')) Then
  Begin
    SetLength(arrValidar, 2);
    //********* SISTEMA DE COBRANÇA SINCO ***************************************************//
    //                                                                                       //
    // COMPOSICAO DO CAMPO LIVRE (CAIXA ECONOMICA FEDERAL) - COBRANCA SEM REGISTRO           //
    // (20-20) 1 - CONSTANTE, FIXO (1)                                                       //
    // (21-26) 6 - CÓDIGO DO CLIENTE/CEDENTE FORNECIDO PELA CAIXA                            //
    // (27-27) 1 - CONSTANTE, FIXO(9)                                                        //
    // (28-32) 6 - CONSTANTE, FIXO(000000) (A T E N Ç Ã O ) - Leia abaixo                    //
    //             Foi atribuido a constante (0) ao nosso número pois no lay-out original    //
    //             o nosso número era exportado para o txt com no máximo 15 posições         //
    //                                                                                       //
    // (33-44) 12 - NOSSO NÚMERO                                                             //
    //                                                                                       //
    //************************************************************************************ED*//

    strCmpLiv := '';
    strCmpLiv := strCmpLiv + '1';                                           //  1
    strCmpLiv := strCmpLiv + LeftStr(Trim(strCodCed), 06);                  //  6
    strCmpLiv := strCmpLiv + '9';                                           //  1
    strCmpLiv := strCmpLiv + '000000';                                      //  6
    strCmpLiv := strCmpLiv + LeftStr(strNosNum, Length(Trim(strNosNum))-1); // 11

    arrValidar[0].strNomCam := 'Nosso Número';
    arrValidar[0].strValCam := strNosNum;
    arrValidar[0].strIdeBan := strIdeBan;
    arrValidar[0].intTamCam := 12;

    arrValidar[1].strNomCam := 'Cedente';
    arrValidar[1].strValCam := strCodCed;
    arrValidar[1].strIdeBan := strIdeBan;
    arrValidar[1].intTamCam := 06;

    Result := fValidaStrings;
    If Not( Result ) Then
      Exit;
  End
  Else If (Pos(strCodCar, '_08') >= 1)                       And
          ((fEmptyStr(Trim(strSisCob))) Or (strSisCob = 'SINCO'))  Then
  Begin
    SetLength(arrValidar, 2);

    {********* SISTEMA DE COBRANÇA SINCO COM NOSSO NUMERO DE 16 POSIÇÕES********************}
    {*                                                                                     *}
    {* COMPOSICAO DO CAMPO LIVRE (CAIXA ECONOMICA FEDERAL) - COBRANCA SEM REGISTRO         *}
    {* (20-24) 5 - CÓDIGO DO CEDENTE FORNECIDO PELA CAIXA                                  *}
    {* (25-28) 4 - CÓDIGO DA AGÊNCIA                                                       *}
    {* (29-29) 1 - CÓDIGO DA CARTEIRA - CONSTANTE, FIXO(8)                                 *}
    {* (30-30) 1 - CONSTANTE, FIXO(7)                                                      *}
    {* (31-44) 14- NOSSO NÚMERO                                                            *}
    {*                                                                                     *}
    {************************************************************************************AF*}

    strCmpLiv := '';
    strCmpLiv := strCmpLiv + LeftStr(RightStr(Trim(strCodCed), 06), 5);                   //  5
    strCmpLiv := strCmpLiv + Trim(strNumAge);                                             //  4
    strCmpLiv := strCmpLiv + '8';                                                         //  1
    strCmpLiv := strCmpLiv + '7';                                                         //  1
    strCmpLiv := strCmpLiv + fStrZero(LeftStr(strNosNum, Length(Trim(strNosNum))-1), 14); // 14

    arrValidar[0].strNomCam := 'Nosso Número';
    arrValidar[0].strValCam := strNosNum;
    arrValidar[0].strIdeBan := strIdeBan;
    arrValidar[0].intTamCam := 11;

    arrValidar[1].strNomCam := 'Agência';
    arrValidar[1].strValCam := strNumAge;
    arrValidar[1].strIdeBan := strIdeBan;
    arrValidar[1].intTamCam := 04;

    Result := fValidaStrings;
    If Not( Result ) Then
      Exit;
  End
  Else If (Pos(strCodCar, '_14_24') >= 1)                         And
          ((fEmptyStr(Trim(strSisCob))) Or (strSisCob = 'SIGCB')) Then
  Begin
    intDigCed := 0;
    intDigCpl := 0;
    strNosNum := fStrZero(strNosNum,16);

    {**************************************}
    {* CALCULO DO DIGITO VERIFICADOR DO   *}
    {* CÓDIGO DO CEDENTE                  *}
    {***********************************AF*}
    For intContador := 7 DownTo 1 Do
    Begin
      intFator1 := StrToInt(LeftStr(Trim(strCodCed), 07)[intContador]);
      intFator2 := StrToInt(RightStr(strBase, 07)[intContador]);

      intDigCed := intDigCed + (intFator1 * intFator2);
    End;

    {**************************************}
    {* SE O RESULTADO DA SOMA FOR MENOR   *}
    {* QUE 11 ENTAO O DIGITO É 11 - SOMA  *}
    {* OU FAZ UM MONTE DE OUTRAS COISAS   *}
    {***********************************AF*}
    If intDigCed < 11 Then
    Begin
      intDigCed := 11 - intDigCed;
    End
    Else
    Begin
      intDigCed := intDigCed Mod 11;
      intDigCed := 11 - intDigCed;

      If intDigCed > 9 Then
        intDigCed := 0;
    End;

    strDigCed := IntToStr(intDigCed);

    //********* SISTEMA DE COBRANÇA SIGCB ***************************************************//
    //                                                                                       //
{     01 – 03 3 9 (3) Identificação do banco (104)
      04 – 04 1 9 Código da moeda (9 - Real)
      05 – 05 1 9 DV Geral do Código de Barras Nota 2 / Anexo I
      06 - 09 4 9 Fator de Vencimento Anexo II
      10 - 19 10 9 (8) V99 Valor do Documento
      20 – 26 7 9 (7) Código do Beneficiário Nota 3 / Anexo VI
      Campo
      Livre
      27 – 29 3 9 (3) Nosso Número - Sequência 1
      Nota 1
      30 – 30 1 9 (1) Constante 1
      31 – 33 3 9 (3) Nosso Número - Sequência 2
      34 – 34 1 9 (1) Constante 2
      35 – 43 9 9 (9) Nosso Número - Sequência 3
      44 – 44 1 9 (1) DV do Campo Livre Nota 4 / Anexo III }
    //********* SISTEMA DE COBRANÇA SIGCB **************************************************MT//

    strCmpLiv := '';
    strCmpLiv := strCmpLiv + LeftStr(Trim(strCodCed),     07);   //  6
    strCmpLiv := strCmpLiv + LeftStr(strNosNum,           03);   //  3
    strCmpLiv := strCmpLiv + IIF( strCodCar = '14', '1', '2');   //  1
    strCmpLiv := strCmpLiv + Copy(strNosNum, 4,           03);   //  3
    strCmpLiv := strCmpLiv + '4';                                //  1
    strCmpLiv := strCmpLiv + Copy(strNosNum, 7,           09);   //  9



    {**************************************}
    {* CALCULO DO DIGITO VERIFICADOR DO   *}
    {* CAMPO LIVRE                        *}
    {***********************************AF*}
    For intContador := 24 DownTo 1 Do
    Begin
      intFator1 := StrToInt( strCmpLiv[intContador] );
      intFator2 := StrToInt( RightStr(strBase,24)[intContador] );

      intDigCpl := intDigCpl + (intFator1 * intFator2);
    End;

    {**************************************}
    {* SE O RESULTADO DA SOMA FOR MENOR   *}
    {* QUE 11 ENTAO O DIGITO É 11 - SOMA  *}
    {* OU FAZ UM MONTE DE OUTRAS COISAS   *}
    {***********************************AF*}
    If intDigCpl < 11 Then
    Begin
      intDigCpl := 11 - intDigCpl;
    End
    Else
    Begin
      intDigCpl := intDigCpl Mod 11;
      intDigCpl := 11 - intDigCpl;

      If intDigCpl > 9 Then
        intDigCpl := 0;
    End;

    strCmpLiv := strCmpLiv + IntToStr(intDigCpl);

  End;

  fCalculaDigitos;
  Result := fMontaCodBarLinDig;
end;

//******************************************//
//        ---  B A N C O O B    ---         //
//******************************************//
// COMPOSICAO DO CAMPO LIVRE (BANCOOB)      //
// (20-20) 1 - CODIGO DA CARTEIRA,          //
// (21-24) 4 - CODIGO DA COOPERATIVA,       //
// (25-26) 2 - MODALIDADE,                  //
// (27-33) 7 - CODIGO DO CLIENTE,           //
// (34-41) 8 - NUMERO DO TITULO,            //
// (42-44) 6 - NUMERO DA PARCELA,           //
//***************************************ED*//
function fGeLiDi756: Boolean;
Var
  LEmpresa : String;
  LCarteira: String;
begin
  Result := False;

  If strBB_Crr = 'S' Then
  Begin
    If Not fGeLiDi001 Then
    begin
      Exit;
    end
  End
  Else
  Begin
    SetLength(arrValidar, 5);
    strDigCed := RightStr(strCodCed,1);

    strCmpLiv := '';

    LEmpresa  := RightStr(LIdentificacaoBanco, 3);
    LCarteira := AnsiReplaceStr(LIdentificacaoBanco, RightStr(LIdentificacaoBanco, 4), '');

    If (Pos('756_240p',LIdentificacaoBanco) > 0) And
       (fGetBancoConfig(0, LCarteira, 'BOLNOVCON', '', LEmpresa) = 'S') Then
    Begin
      strCmpLiv := strCmpLiv + LeftStr(strCodCar, 1);
      strCmpLiv := strCmpLiv + LeftStr(strNumAge, 4);
      strCmpLiv := strCmpLiv + fStrZero(strCodCed, 9);
      strCmpLiv := strCmpLiv + fStrZero(LeftStr(strNosNum, 8), 9);
      strCmpLiv := strCmpLiv + LeftStr(strModCob, 2);
    End
    Else
    Begin
      strCmpLiv := strCmpLiv + LeftStr(strCodCar, 1);
      strCmpLiv := strCmpLiv + LeftStr(strNumAge, 4);
      strCmpLiv := strCmpLiv + LeftStr(strModCob, 2);
      strCmpLiv := strCmpLiv + RightStr(strCodCed, 7);
      strCmpLiv := strCmpLiv + RightStr(strNosNum, 8);
      strCmpLiv := strCmpLiv + fStrZero(RetornaNumeroParcela(strNumDoc), 3);
    End;

    //*****************************************************//
    // VALIDA OS RESPECTIVOS CAMPOS ABAIXO                 //
    //**************************************************ED*//
    arrValidar[0].strNomCam := 'Agência';
    arrValidar[0].strValCam := strNumAge;
    arrValidar[0].strIdeBan := strIdeBan;
    arrValidar[0].intTamCam := 04;

    arrValidar[1].strNomCam := 'Carteira';
    arrValidar[1].strValCam := strCodCar;
    arrValidar[1].strIdeBan := strIdeBan;
    arrValidar[1].intTamCam := 01;

    arrValidar[2].strNomCam := 'Cód. da Mod. de Cobrança';
    arrValidar[2].strValCam := strModCob;
    arrValidar[2].strIdeBan := strIdeBan;
    arrValidar[2].intTamCam := 02;

    arrValidar[3].strNomCam := 'Cedente';
    arrValidar[3].strValCam := strCodCed;
    arrValidar[3].strIdeBan := strIdeBan;
    arrValidar[3].intTamCam := 07;

    arrValidar[4].strNomCam := 'Nosso Número';
    arrValidar[4].strValCam := strNosNum;
    arrValidar[4].strIdeBan := strIdeBan;
    arrValidar[4].intTamCam := 08;

    Result := fValidaStrings;
    If Not( Result ) Then
      Exit;

    fCalculaDigitos;
    Result := fMontaCodBarLinDig;
  End;
end;



//******************************************//
//   ---  B A N C O   R E A L     ---       //
//******************************************//
// COMPOSICAO DO CAMPO LIVRE (BANCOOB)      //
// (20-23)  4 - AGENCIA,                    //
// (24-30)  7 - NUMERO DA CONTA / CEDENTE,  //
// (31-31)  1 - DIGITAO DA COBRANCA,        //
// (32-44) 13 - NOSSO NUMERO                //
//***************************************ED*//
function fGeLiDi356: Boolean;
begin
  SetLength(arrValidar, 4);
  //*****************************************************//
  // VALIDA OS RESPECTIVOS CAMPOS ABAIXO                 //
  //**************************************************ED*//
  //fValidaTamanhoString(LeftStr(strNosNum, 13), 'Nosso Número', strIdeBan, 13);

  arrValidar[0].strNomCam := 'Agência';
  arrValidar[0].strValCam := strNumAge;
  arrValidar[0].strIdeBan := strIdeBan;
  arrValidar[0].intTamCam := 04;

  arrValidar[1].strNomCam := 'Cedente';
  arrValidar[1].strValCam := strCodCed;
  arrValidar[1].strIdeBan := strIdeBan;
  arrValidar[1].intTamCam := 07;

  arrValidar[2].strNomCam := 'Carteira';
  arrValidar[2].strValCam := strCodCar;
  arrValidar[2].strIdeBan := strIdeBan;
  arrValidar[2].intTamCam := 02;

  //*************************************************//
  // CALCULA O DIGITAO DE COBRANCA DO BANCO REAL     //
  //**********************************************ED*//
  If Length(strNosNum) = 7 Then
    strDigita :=  fcDigitaoCobReal(fStrZero(strNosNum, 07), strNumAge, strCodCed)
  Else
    strDigita :=  fcDigitaoCobReal(RightStr(strNosNum, 13), strNumAge, strCodCed);

  arrValidar[3].strNomCam := 'Digitão de cobrança';
  arrValidar[3].strValCam := strDigita;
  arrValidar[3].strIdeBan := strIdeBan;
  arrValidar[3].intTamCam := 01;

  //*************************************************//
  // MONTA A STRING DE CAMPO LIVRE                   //
  //**********************************************ED*//
  strCmpLiv := '';
  strCmpLiv := strCmpLiv + LeftStr(strNumAge, 4);
  strCmpLiv := strCmpLiv + LeftStr(strCodCed, 7);
  strCmpLiv := strCmpLiv + strDigita;              // DIGITAO DA COBRANCA
  {*****************************************}
  {* COBRANÇA REGISTRADA.                  *}
  {**************************************MV*}
  If Length(strNosNum) = 7 Then
    //strCmpLiv := strCmpLiv + fStrZero(strCodCar + RightStr(strNosNum,7), 13)
    strCmpLiv := strCmpLiv + fStrZero(RightStr(strNosNum,7), 13)
  Else
    strCmpLiv := strCmpLiv + fStrZero(strNosNum, 13);

  Result := fValidaStrings;
  If Not( Result ) Then
    Exit;

  fCalculaDigitos;
  Result := fMontaCodBarLinDig;
end;




{******************************************}
{*   ---  B A N C O   H S B C    ---      *}
{***************************************AF*}
function fGeLiDi399: Boolean;
begin
  {*******************************************}
  {* VALIDA CAMPOS                           *}
  {****************************************AF*}
  SetLength(arrValidar, 4);
  arrValidar[0].strNomCam := 'Agência';
  arrValidar[0].strValCam := strNumAge;
  arrValidar[0].strIdeBan := strIdeBan;
  arrValidar[0].intTamCam := 04;

  arrValidar[1].strNomCam := 'Cedente';
  arrValidar[1].strValCam := strCodCed;
  arrValidar[1].strIdeBan := strIdeBan;
  arrValidar[1].intTamCam := 07;

  arrValidar[2].strNomCam := 'Código da Carteira';
  arrValidar[2].strValCam := strCodCar;
  arrValidar[2].strIdeBan := strIdeBan;
  arrValidar[2].intTamCam := 02;

  If strModCob = 'S' Then
  begin
    arrValidar[3].strNomCam := 'Nosso Número';
    arrValidar[3].strValCam := strNosNum;
    arrValidar[3].strIdeBan := strIdeBan;
    arrValidar[3].intTamCam := 11;
  end
  Else
  begin
    arrValidar[3].strNomCam := 'Nosso Número';
    arrValidar[3].strValCam := strNosNum;
    arrValidar[3].strIdeBan := strIdeBan;
    arrValidar[3].intTamCam := 13;
  end;

  {*******************************************}
  {* CAMPO LIVRE                             *}
  {*******************************************}
  {* S -> COBRANÇA REGISTRADA (COB)          *}
  {* N -> COBRANÇA NÃO REGISTRADA (CNR)      *}
  {****************************************AF*}
  If strModCob = 'S' Then
  Begin
    strCmpLiv := '';
    strCmpLiv := strCmpLiv + LeftStr(strNosNum, 11);
    strCmpLiv := strCmpLiv + LeftStr(strNumAge, 4);
    strCmpLiv := strCmpLiv + LeftStr(strCodCed, 7);
    strCmpLiv := strCmpLiv + '00';
    strCmpLiv := strCmpLiv + '1';
  End
  Else
  Begin
    strFatVen := ifThen(strTpIden = '4', strFatVen, '0000');
    strCmpLiv := '';
    strCmpLiv := strCmpLiv + LeftStr(strCodCed, 7);
    strCmpLiv := strCmpLiv + fStrZero(LeftStr(strNosNum, 10),13);
    strCmpLiv := strCmpLiv + ifThen(strTpIden = '4', fRetornaDataFormatoJuliano(dtaDtaVen), '0000');
    strCmpLiv := strCmpLiv + '2';
  End;

  Result := fValidaStrings;
  If Not( Result ) Then
    Exit;

  fCalculaDigitosHSBC;
  Result := fMontaCodBarLinDig;
end;


//*************************************************//
// BANCOS FORA DE PADRAO                           //
//**********************************************ED*//
function fGeLiDi748: Boolean;
var
  LCedenteCodigoBarras: String;
begin

  //*************************************************************************************************//
  // COMPOSICAO DO CAMPO LIVRE                                                                       //
  // (20-20) CORRESPONDE AO TIPO DE COBRANCA: "3" SICREDI                                            //
  // (21-21) CORRESPONDE AO TIPO DE CARTEIRA: "1" CARTEIRA SIMPLES                                   //
  // (22-30) NOSSO NÚMERO                                                                            //
  // (31-34) COOPERATIVA DE CREDITO / AGENCIA CEDENTE                                                //
  // (35-36) UNID. ATENDIMENTO / POSTO DA AGENCIA CEDENTE                                            //
  // (37-41) CÓDIGO DO CEDENTE                                                                       //
  // (42-42) FILER ZEROS: OBS. SERA 1(UM) QUAND. HOUVER VALOR EXPRESSO NO CAMPO "VALOR DO DOCUMENTO" //
  // (43-43) FILER ZEROS                                                                             //
  // (43-44) DV DO CAMPO LIVRE CALCULO POR MÓDULO 11 COM APROVEITAMENTO TOTAL RESTO = (0 OU 1) = 0   //
  //**********************************************************************************************ED*//

  SetLength(arrValidar, 3);

  arrValidar[0].strNomCam := 'Nosso Número';
  arrValidar[0].strValCam := strNosNum;
  arrValidar[0].strIdeBan := strIdeBan;
  arrValidar[0].intTamCam := 9;

  arrValidar[2].strNomCam := 'Agência';
  arrValidar[2].strValCam := LeftStr(strNumAge, 4);
  arrValidar[2].strIdeBan := strIdeBan;
  arrValidar[2].intTamCam := 4;

  arrValidar[1].strNomCam := 'Cedente';
  arrValidar[1].strValCam := strCodCed;
  arrValidar[1].strIdeBan := strIdeBan;
  arrValidar[1].intTamCam := 7;

  Result := fValidaStrings;
  If Not( Result ) Then
    Exit;

  // POSTO ALFANUMERICO (EX.: "AJ") VAI COMO "00" NO CODIGO DE BARRAS, QUE SO ADMITE DIGITO - PLANILHA
  // ANALISABOLETO DO SICREDI. O CAMPO AGENCIA/CODIGO DO BENEFICIARIO DO BOLETO CONTINUA COM AS LETRAS.
  LCedenteCodigoBarras := strCodCed;
  If fRetSomenteNumeros(LeftStr(LCedenteCodigoBarras, 2)) <> LeftStr(LCedenteCodigoBarras, 2) Then
    LCedenteCodigoBarras := '00' + Copy(LCedenteCodigoBarras, 3, Length(LCedenteCodigoBarras));

  strCmpLiv := IIF(strCobReg = 'S', '1', '3') + '1' + strNosNum + strNumAge + LCedenteCodigoBarras + '10';
  strDCmLiv := fGeDigCmLSicred(strCmpLiv, '', '', '', '');

  //********************************************************//
  // CODIGO DO BANCO + MOEDA + 5 PRIMEIROS DO CAMPO LIVRE   //
  //*****************************************************ED*//
  strDigit1 := fGePriDigSic(strIdeBan, strMoeda1, LeftStr(strCmpLiv, 5));

 // Result := Not fEmptyStr(strDigit1);

  //***********************************//
  // POSICAO DE 6 A 15 DO CAMPO LIVRE  //
  //********************************ED*//
  strDigit2 := fGeSegDigSic(Copy(strCmpLiv, 6, 10), '');

  strCmpLiv := strCmpLiv + strDCmLiv;

  //*************************************//
  // POSICAO DE 16 A 25 DO CAMPO LIVRE   //
  //**********************************ED*//
  strDigit3 := fGeTerDigSic( Copy(strCmpLiv, 16, 10), '');
  strDiAuCo := fGeDigAutSicred(strIdeBan, strMoeda1, strFatVen, strVlrTit, strCmpLiv, '', '', '');


  strLinDig := strIdeBan + strMoeda1 + LeftStr(strCmpLiv ,5) + strDigit1 +
               Copy(strCmpLiv, 6, 10) + strDigit2 + Copy(strCmpLiv, 16, 10) +
               strDigit3 + strDiAuCo +  strFatVen + strVlrTit;


{  Insert('.',strLinDig,6);
  Insert(' ',strLinDig,12);
  Insert('.',strLinDig,18);
  Insert(' ',strLinDig,25);
  Insert('.',strLinDig,31);
  Insert(' ',strLinDig,38);
  Insert(' ',strLinDig,40);
}
  Result := fMontaCodBarLinDig;

End;

function fGeLiDi004: Boolean;
var
  strDigito: String;
  strTipoOperacao: String;
begin
  SetLength(arrValidar, 4);

  arrValidar[0].strNomCam := 'Nosso Número';
  arrValidar[0].strValCam := strNosNum;
  arrValidar[0].strIdeBan := strIdeBan;
  arrValidar[0].intTamCam := 7;

  arrValidar[1].strNomCam := 'Conta Corrente';
  arrValidar[1].strValCam := strCodCed;
  arrValidar[1].strIdeBan := strIdeBan;
  arrValidar[1].intTamCam := 6;

  arrValidar[2].strNomCam := 'Dígito Conta Corrente';
  arrValidar[2].strValCam := strDigCed;
  arrValidar[2].strIdeBan := strIdeBan;
  arrValidar[2].intTamCam := 1;

  arrValidar[3].strNomCam := 'Código da Agência';
  arrValidar[3].strValCam := strNumAge;
  arrValidar[3].strIdeBan := strIdeBan;
  arrValidar[3].intTamCam := 4;

  Result := fValidaStrings;
  If Not( Result ) Then
    Exit;

  case AnsiIndexStr(strCodCar, ['1','2','4','5','I']) of
       0: strTipoOperacao := '21';
       1: strTipoOperacao := '41';
       2: strTipoOperacao := '21';
       3: strTipoOperacao := '41';
       4: strTipoOperacao := '51';
  end;

  strNosNum := Copy(strNosNum, 1, 7);
  strCodCed := '0' + strCodCed;

  strDigito := fCalcDigito('004', strNosNum, '004', 0, VS_strCodEmp);

  strDigit1 := fGePriDig004(strIdeBan, strMoeda1, strNumAge, LeftStr(strCodCed, 1));

  strDigit2 := fGeSegDig004(Copy(strCodCed, 2, 6), strDigCed,  Leftstr(strNosNum, 3));

  strDigit3 := fGeTerDig004(Copy(strNosNum, 4, 4),strDigito, strTipoOperacao+'000');

  strDiAuCo := fGeDigAut004(strIdeBan+strMoeda1+strFatVen+strVlrTit+strNumAge+strCodCed+strDigCed+strNosNum+strDigito+strTipoOperacao+'000');

  strLinDig := strIdeBan + strMoeda1 + strNumAge + LeftStr(strCodCed, 1) + strDigit1 +
               Copy(strCodCed, 2, 6) + strDigCed + Leftstr(strNosNum, 3) + strDigit2 +
               Copy(strNosNum, 4, 4) + strDigito + strTipoOperacao+'000' + strDigit3+ strDiAuCo+ strFatVen + strVlrTit;

  strCodBar := strIdeBan + strMoeda1 + strDiAuCo +  strFatVen + strVlrTit +
               strNumAge + strCodCed + strDigCed + strNosNum + strDigito + strTipoOperacao + '000';

  strNosNum := strNosNum + strDigito;

  Insert('.',strLinDig,6);
  Insert(' ',strLinDig,12);
  Insert('.',strLinDig,18);
  Insert(' ',strLinDig,25);
  Insert('.',strLinDig,31);
  Insert(' ',strLinDig,38);
  Insert(' ',strLinDig,40);
end;

function fGeLiDi089: Boolean;
Begin
  SetLength(arrValidar, 5);
  strDigCed := RightStr(strCodCed,1);

  strCmpLiv := '';
  strCmpLiv := strCmpLiv + LeftStr(strCodCar, 1);
  strCmpLiv := strCmpLiv + LeftStr(strNumAge, 4);
  strCmpLiv := strCmpLiv + LeftStr(strModCob, 2);
  strCmpLiv := strCmpLiv + LeftStr(strCodCed, 7);
  strCmpLiv := strCmpLiv + fStrZero(LeftStr(strNosNum,7), 8);
  strCmpLiv := strCmpLiv + '000';

  //**************************************//
  // VALIDA OS RESPECTIVOS CAMPOS ABAIXO  //
  //**************************************//
  arrValidar[0].strNomCam := 'Agência';
  arrValidar[0].strValCam := strNumAge;
  arrValidar[0].strIdeBan := strIdeBan;
  arrValidar[0].intTamCam := 04;

  arrValidar[1].strNomCam := 'Carteira';
  arrValidar[1].strValCam := strCodCar;
  arrValidar[1].strIdeBan := strIdeBan;
  arrValidar[1].intTamCam := 01;

  arrValidar[2].strNomCam := 'Cedente';
  arrValidar[2].strValCam := strCodCed;
  arrValidar[2].strIdeBan := strIdeBan;
  arrValidar[2].intTamCam := 07;

  arrValidar[3].strNomCam := 'Nosso Número';
  arrValidar[3].strValCam := strNosNum;
  arrValidar[3].strIdeBan := strIdeBan;
  arrValidar[3].intTamCam := 08;

  Result := fValidaStrings;

  If Not( Result ) Then
    Exit;

  fCalculaDigitos;
  Result := fMontaCodBarLinDig;
End;

{*****************************************}
{* PROCEDURE QUE GERA A LINHA            *}
{* DIGITAVEL DO BANCO 637 LP 644 - SOFISA*}
{*****************************************}
function fGeLiDi637LP: Boolean;
begin

  strIdeBan := '637';

  SetLength(arrValidar, 3);

  arrValidar[1].strNomCam := 'Numero da Operacao';
  arrValidar[1].strValCam := strNumOperacao;
  arrValidar[1].strIdeBan := strIdeBan;
  arrValidar[1].intTamCam := 7;

  arrValidar[0].strNomCam := 'Nosso Número';
  arrValidar[0].strValCam := strNosNum;
  arrValidar[0].strIdeBan := strIdeBan;
  arrValidar[0].intTamCam := 11;

  arrValidar[1].strNomCam := 'Agencia';
  arrValidar[1].strValCam := strNumAge;
  arrValidar[1].strIdeBan := strIdeBan;
  arrValidar[1].intTamCam := 4;

  arrValidar[1].strNomCam := 'Carteira do Boleto';
  arrValidar[1].strValCam := strCodCar;
  arrValidar[1].strIdeBan := strIdeBan;
  arrValidar[1].intTamCam := 3;

  Result := fValidaStrings;
  If Not( Result ) Then
    Exit;

  strNumOperacao := RightStr(strNumOperacao, 07);

  strNosNum := fStrZero(strNosNum, 11);

  strDigit1 := fGePriDig637(strIdeBan, strMoeda1, LeftStr(strNumAge,4), LeftStr(strCodCar,1));

  strDigit2 := fGeSegDig637(RightStr(strCodCar, 2), strNumOperacao, LeftStr(strNosNum, 1));

  strDigit3 := fGeTerDig637(RightStr(strNosNum, 10));

  strDiAuCo := fGeDigAut637(strIdeBan, strMoeda1, strFatVen, strVlrTit, LeftStr(strNumAge,4), strCodCar, strNumOperacao, strNosNum); //IIF(strCodCar = '4', '102', IIF(strCodCar = '6', '201', '101')));

  strLinDig := strIdeBan + strMoeda1 + LeftStr(strNumAge, 4) + LeftStr(strCodCar,1) + strDigit1 + //1 CAMPO;
               RightStr(strCodCar, 2) + strNumOperacao + LeftStr(strNosNum, 1) + strDigit2 +      //2 CAMPO;
               RightStr(strNosNum, 10) + strDigit3 + //3 CAMPO;
               strDiAuCo +
               strFatVen + strVlrTit;

  strCodBar := strIdeBan + '9' + strDiAuCo + strFatVen + strVlrTit +
               strNumAge + strCodCar + strNumOperacao + strNosNum;

  Insert('.',strLinDig,6);
  Insert(' ',strLinDig,12);
  Insert('.',strLinDig,18);
  Insert(' ',strLinDig,25);
  Insert('.',strLinDig,31);
  Insert(' ',strLinDig,38);
  Insert(' ',strLinDig,40);
end;

{******************************************}
{*          BANCO CRESOL [240P]           *}
{*         MF: 287323 - 14/07/23          *}
{******************************************}
function fGeLiDi133: Boolean;
begin
  strModCob := '09';

  SetLength(arrValidar, 4);

  arrValidar[0].strNomCam := 'Agência';
  arrValidar[0].strValCam := strNumAge;
  arrValidar[0].strIdeBan := strIdeBan;
  arrValidar[0].intTamCam := 4;

  arrValidar[1].strNomCam := 'Cód. da Mod. de Cobrança';
  arrValidar[1].strValCam := strModCob;
  arrValidar[1].strIdeBan := strIdeBan;
  arrValidar[1].intTamCam := 2;

  arrValidar[2].strNomCam := 'Nosso Número';
  arrValidar[2].strValCam := strNosNum;
  arrValidar[2].strIdeBan := strIdeBan;
  arrValidar[2].intTamCam := 11;

  arrValidar[3].strNomCam := 'Conta Corrente';
  arrValidar[3].strValCam := LeftStr(fStrZero(Trim(strCodCed), 7),7);
  arrValidar[3].strIdeBan := strIdeBan;
  arrValidar[3].intTamCam := 7;

  Result := fValidaStrings;
  If Not( Result ) Then
    Exit;

  strDCmLiv := '0';

  strCmpLiv := '';
  strCmpLiv := strCmpLiv + LeftStr(strNumAge, 4);
  strCmpLiv := strCmpLiv + RightStr(strModCob, 2);
  strCmpLiv := strCmpLiv + LeftStr(fStrZero(strNosNum, 11),11);
  strCmpLiv := strCmpLiv + LeftStr(fStrZero(Trim(strCodCed), 7),7);
  strCmpLiv := strCmpLiv + strDCmLiv;

  Result := fCalculaDigitos;
  Result := (Result) And (fMontaCodBarLinDig);
end;

function RetornaLinhaDigitavelBancoInter077: Boolean;
Begin
  Result := Not strLinhaDigitavelAPI.IsEmpty;

  strLinDig := strLinhaDigitavelAPI;

  strCodBar := Copy(strLinDig, 01, 04) + Copy(strLinDig, 33, 15) + Copy(strLinDig, 05, 05) +
               Copy(strLinDig, 11, 08) + Copy(strLinDig, 19, 02) + Copy(strLinDig, 22, 10);

  Insert('.', strLinDig, 6);
  Insert(' ', strLinDig, 12);
  Insert('.', strLinDig, 18);
  Insert(' ', strLinDig, 25);
  Insert('.', strLinDig, 31);
  Insert(' ', strLinDig, 38);
  Insert(' ', strLinDig, 40);
End;


function AlterouVencimento(ALinDig:String): Boolean;
Begin
  Result := False;

  If fEmptyStr(ALinDig) Then
    Exit(True);

  If fEmptyStr(strFatVen) Then
    Exit;

  If Copy(ALinDig, 34, 4) <> strFatVen Then
    Result := True;

End;

function RetornaLinhaDigitavelBancoDoBrasilApi: Boolean;
Begin

  If AlterouVencimento(TRetornoBoletoBancoDoBrasil(LRetornoRegistroBoletoApi).linhaDigitavel) Then
  Begin
    Result := fGeLiDi001;
    If Not Result Then
      Exit(False);

    TRetornoBoletoBancoDoBrasil(LRetornoRegistroBoletoApi).linhaDigitavel := strLinDig;
    TRetornoBoletoBancoDoBrasil(LRetornoRegistroBoletoApi).codigoDeBarras := strCodBar;
    Exit(True);
  End;


  Result := Not TRetornoBoletoBancoDoBrasil(LRetornoRegistroBoletoApi).linhaDigitavel.IsEmpty;
  If Not Result Then Exit;

  Result := Not TRetornoBoletoBancoDoBrasil(LRetornoRegistroBoletoApi).codigoDeBarras.IsEmpty;
  If Not Result Then Exit;

  strLinDig := TRetornoBoletoBancoDoBrasil(LRetornoRegistroBoletoApi).linhaDigitavel;
  strCodBar := TRetornoBoletoBancoDoBrasil(LRetornoRegistroBoletoApi).codigoDeBarras;

  Insert('.', strLinDig, 6);
  Insert(' ', strLinDig, 12);
  Insert('.', strLinDig, 18);
  Insert(' ', strLinDig, 25);
  Insert('.', strLinDig, 31);
  Insert(' ', strLinDig, 38);
  Insert(' ', strLinDig, 40);
End;

function RetornaLinhaDigitavelBancoItauApi: Boolean;
Begin
  Result := Not TRetornoBoletoItau(LRetornoRegistroBoletoApi).linhaDigitavel.IsEmpty;
  If Not Result Then
    Exit;

  Result := Not TRetornoBoletoItau(LRetornoRegistroBoletoApi).codigoDeBarras.IsEmpty;
  If Not Result Then
    Exit;

  strLinDig := TRetornoBoletoItau(LRetornoRegistroBoletoApi).linhaDigitavel;
  strCodBar := TRetornoBoletoItau(LRetornoRegistroBoletoApi).codigoDeBarras;

  Insert('.', strLinDig, 6);
  Insert(' ', strLinDig, 12);
  Insert('.', strLinDig, 18);
  Insert(' ', strLinDig, 25);
  Insert('.', strLinDig, 31);
  Insert(' ', strLinDig, 38);
  Insert(' ', strLinDig, 40);
End;

function RetornaLinhaDigitavelBancoSicoobApi: Boolean;
Begin
  Result := Not TRetornoBoletoSicoob(LRetornoRegistroBoletoApi).linhaDigitavel.IsEmpty;
  If Not Result Then
    Exit;

  Result := Not TRetornoBoletoSicoob(LRetornoRegistroBoletoApi).codigoBarras.IsEmpty;
  If Not Result Then
    Exit;

  strLinDig := TRetornoBoletoSicoob(LRetornoRegistroBoletoApi).linhaDigitavel;
  strCodBar := TRetornoBoletoSicoob(LRetornoRegistroBoletoApi).codigoBarras;

  Insert('.', strLinDig, 6);
  Insert(' ', strLinDig, 12);
  Insert('.', strLinDig, 18);
  Insert(' ', strLinDig, 25);
  Insert('.', strLinDig, 31);
  Insert(' ', strLinDig, 38);
  Insert(' ', strLinDig, 40);
End;

function RetornaLinhaDigitavelBancoSantanderApi: Boolean;
Begin
  Result := Not TRetornoBoletoSantander(LRetornoRegistroBoletoApi).linhaDigitavel.IsEmpty;
  If Not Result Then
    Exit;

  Result := Not TRetornoBoletoSantander(LRetornoRegistroBoletoApi).codigoBarras.IsEmpty;
  If Not Result Then
    Exit;

  strLinDig := TRetornoBoletoSantander(LRetornoRegistroBoletoApi).linhaDigitavel;
  strCodBar := TRetornoBoletoSantander(LRetornoRegistroBoletoApi).codigoBarras;

  Insert('.', strLinDig, 6);
  Insert(' ', strLinDig, 12);
  Insert('.', strLinDig, 18);
  Insert(' ', strLinDig, 25);
  Insert('.', strLinDig, 31);
  Insert(' ', strLinDig, 38);
  Insert(' ', strLinDig, 40);
End;

function RetornaLinhaDigitavelBancoBradescoApi: Boolean;
Begin
  Result := Not TRetornoBoletoBradesco(LRetornoRegistroBoletoApi).linhaDigitavel.IsEmpty;
  If Not Result Then
    Exit;

  Result := Not TRetornoBoletoBradesco(LRetornoRegistroBoletoApi).cdBarras.IsEmpty;
  If Not Result Then
    Exit;

  strLinDig := TRetornoBoletoBradesco(LRetornoRegistroBoletoApi).linhaDigitavel;
  strCodBar := TRetornoBoletoBradesco(LRetornoRegistroBoletoApi).cdBarras;

  Insert('.', strLinDig, 6);
  Insert(' ', strLinDig, 12);
  Insert('.', strLinDig, 18);
  Insert(' ', strLinDig, 25);
  Insert('.', strLinDig, 31);
  Insert(' ', strLinDig, 38);
  Insert(' ', strLinDig, 40);
End;

function RetornaLinhaDigitavelBancoSafraApi: Boolean;
Begin

  Result := Not TRetornoBoletoBancoSafra(LRetornoRegistroBoletoApi).linhaDigitavel.IsEmpty;
  If Not Result Then Exit;

  Result := Not TRetornoBoletoBancoSafra(LRetornoRegistroBoletoApi).codigoDeBarras.IsEmpty;
  If Not Result Then Exit;

  strLinDig := TRetornoBoletoBancoSafra(LRetornoRegistroBoletoApi).linhaDigitavel;
  strCodBar := TRetornoBoletoBancoSafra(LRetornoRegistroBoletoApi).codigoDeBarras;

  Insert('.', strLinDig, 6);
  Insert(' ', strLinDig, 12);
  Insert('.', strLinDig, 18);
  Insert(' ', strLinDig, 25);
  Insert('.', strLinDig, 31);
  Insert(' ', strLinDig, 38);
  Insert(' ', strLinDig, 40);
End;

function RetornaLinhaDigitavelBancoCredisis097: Boolean;
Begin

  Result := Not TRetornoBoletoBancoCredisis(LRetornoRegistroBoletoApi).linhaDigitavel.IsEmpty;
  If Not Result Then Exit;

  Result := Not TRetornoBoletoBancoCredisis(LRetornoRegistroBoletoApi).codigoDeBarras.IsEmpty;
  If Not Result Then Exit;

  strLinDig := TRetornoBoletoBancoCredisis(LRetornoRegistroBoletoApi).linhaDigitavel;
  strCodBar := TRetornoBoletoBancoCredisis(LRetornoRegistroBoletoApi).codigoDeBarras;

  Insert('.', strLinDig, 6);
  Insert(' ', strLinDig, 12);
  Insert('.', strLinDig, 18);
  Insert(' ', strLinDig, 25);
  Insert('.', strLinDig, 31);
  Insert(' ', strLinDig, 38);
  Insert(' ', strLinDig, 40);
End;

function RetornaLinhaDigitavelBancoSicrediApi: Boolean;
Begin

  Result := Not TRetornoBoletoBancoSicredi(LRetornoRegistroBoletoApi).linhaDigitavel.IsEmpty;
  If Not Result Then Exit;

  Result := Not TRetornoBoletoBancoSicredi(LRetornoRegistroBoletoApi).codigoDeBarras.IsEmpty;
  If Not Result Then Exit;

  strLinDig := TRetornoBoletoBancoSicredi(LRetornoRegistroBoletoApi).linhaDigitavel;
  strCodBar := TRetornoBoletoBancoSicredi(LRetornoRegistroBoletoApi).codigoDeBarras;

  Insert('.', strLinDig, 6);
  Insert(' ', strLinDig, 12);
  Insert('.', strLinDig, 18);
  Insert(' ', strLinDig, 25);
  Insert('.', strLinDig, 31);
  Insert(' ', strLinDig, 38);
  Insert(' ', strLinDig, 40);
End;

procedure pGeLiDi151;
begin
  {*****************************************************************************************}
  {* COMPOSICAO DO CAMPO LIVRE (NOSSA CAIXA)                                               *}
  {* (20-20) 1 - IDENTIFICACAO DE SISTEMA ( 8 - COBR. SIMPLES) - (9 - DIRETA IDENTIFICADA) *}
  {* (21-28) 8 - NOSSO NÚMERO (2ª A 9ª POSIÇÕES)                                           *}
  {* (29-32) 4 - AGENCIA DO CEDENTE SEM O DIGITO                                           *}
  {* (33-33) 1 - MODALIDADE DA CONTA CORRENTE                                              *}
  {* (34-39) 6 - CONTA DO CEDENTE SEM O DIGITO                                             *}
  {* (40-42) 3 - BANCO CEDENTE = 151                                                       *}
  {* (43-43) 1 - DIGITO 1 DA ASBACE                                                        *}
  {* (44-44) 1 - DIGITO 2 DA ASBACE                                                        *}
  {**************************************************************************************AF*}

  strDCmLiv := '0';
  strCmpLiv := '';
  strCmpLiv := strCmpLiv + strModCob;
  strCmpLiv := strCmpLiv + Copy(Trim(strNosNum), 2, 8);
  strCmpLiv := strCmpLiv + strNumAge;
  strCmpLiv := strCmpLiv + RightStr(LeftStr(strCodCed, 2), 1);
  strCmpLiv := strCmpLiv + RightStr(strCodCed, 6);
  strCmpLiv := strCmpLiv + '151';

  fValidaTamanhoString(Trim(strNosNum), 'Nosso Número', strIdeBan, 10);
  fValidaTamanhoString(strNumAge, 'Agência', strIdeBan, 4);
  fValidaTamanhoString(strCodCed, 'Modalidade da conta(2) + Cedente(6)', strIdeBan, 8);

  strDiAsb1 := fCalDigAsbace1(strCmpLiv);
  strDiAsb2 := fCalDigAsbace2(strCmpLiv + strDiAsb1);

  strCmpLiv := strCmpLiv + strDiAsb1 + strDiAsb2;

  {********************}
  {* CALCULA DIGITOS  *}
  {*****************AF*}
  strDigit1 := fGePriDig(strIdeBan, strMoeda1, LeftStr(strCmpLiv, 5));
  strDigit2 := fGeSegDig(Copy(strCmpLiv,  6, 10), '');
  strDigit3 := fGeTerDig(Copy(strCmpLiv, 16, 10), '');
  strDiAuCo := fGeDigAut(strIdeBan, strMoeda1, strFatVen, strVlrTit, strCmpLiv, '', '', '');

  strLinDig := strIdeBan +
               strMoeda1 +
               LeftStr(strCmpLiv , 5)  + strDigit1 +
               Copy(strCmpLiv,  6, 10) + strDigit2 +
               Copy(strCmpLiv, 16, 10) + strDigit3 +
               strDiAuCo +  strFatVen + strVlrTit;

  Insert('.',strLinDig,6);
  Insert(' ',strLinDig,12);
  Insert('.',strLinDig,18);
  Insert(' ',strLinDig,25);
  Insert('.',strLinDig,31);
  Insert(' ',strLinDig,38);
  Insert(' ',strLinDig,40);
end;




{*************************************}
{* PROCEDURE QUE GERA A LINHA        *}
{* DIGITAVEL DO BANCO 033 - BANESPA  *}
{**********************************ED*}
function fGeLiDi033: Boolean;
begin

  SetLength(arrValidar, 2);

  arrValidar[0].strNomCam := 'Nosso Número';
  arrValidar[0].strValCam := strNumDup;
  arrValidar[0].strIdeBan := strIdeBan;
  arrValidar[0].intTamCam := 7;

  arrValidar[1].strNomCam := 'Cedente';
  arrValidar[1].strValCam := strCodCed;
  arrValidar[1].strIdeBan := strIdeBan;
  arrValidar[1].intTamCam := 11;

  Result := fValidaStrings;
  If Not( Result ) Then
    Exit;


  strDigiL1 := fGeraPrDiLi(strCodCed, strNumDup);

  strDigiL2 := fGeraSeDiLi(strCodCed, strNumDup, strDigiL1);

  strDigit1 := fGePriDig033(strIdeBan, strMoeda1, LeftStr(strCodCed, 5));

  strDigit2 := fGeSegDig033(Copy(strCodCed, 6, 6), Copy(strNumDup, 1, 4));

  strDigit3 := fGeTerDig033(RightStr(strNumDup, 3), strIdeBan, strDigiL1, strDigiL2);

  strDiAuCo := fGeDigAut033(strIdeBan, strMoeda1, strFatVen, strVlrTit, strCodCed,
                            strNumDup, strIdeBan, strDigiL1, strDigiL2);

  strLinDig := strIdeBan + strMoeda1 + LeftStr(strCodCed, 5) + strDigit1 +
               RightStr(strCodCed, 6) + LeftStr(strNumDup, 4) + strDigit2 +
               RightStr(strNumDup, 3) + '00' + strIdeBan + strDigiL1 + strDigiL2 +
               strDigit3 + strDiAuCo + strFatVen + strVlrTit;

  Insert('.',strLinDig,6);
  Insert(' ',strLinDig,12);
  Insert('.',strLinDig,18);
  Insert(' ',strLinDig,25);
  Insert('.',strLinDig,31);
  Insert(' ',strLinDig,38);
  Insert(' ',strLinDig,40);

end;

{*************************************}
{* PROCEDURE QUE GERA A LINHA        *}
{* DIGITAVEL DO BANCO 353 - SANTANDER*}
{**********************************LU*}
function fGeLiDi353: Boolean;
begin

  SetLength(arrValidar, 2);

  arrValidar[0].strNomCam := 'Nosso Número';
  arrValidar[0].strValCam := strNosNum;
  arrValidar[0].strIdeBan := strIdeBan;
  arrValidar[0].intTamCam := 7;

  arrValidar[1].strNomCam := 'Cedente';
  arrValidar[1].strValCam := strCodCed;
  arrValidar[1].strIdeBan := strIdeBan;
  arrValidar[1].intTamCam := 11;

  Result := fValidaStrings;
  If Not( Result ) Then
    Exit;


  strDigiL1 := fGeraPrDiLi(strCodCed, strNosNum);

  strDigiL2 := fGeraSeDiLi(strCodCed, strNosNum, strDigiL1);

  strDigit1 := fGePriDig033(strIdeBan, strMoeda1, LeftStr(strCodCed, 5));

  strDigit2 := fGeSegDig033(Copy(strCodCed, 6, 6), Copy(strNosNum, 1, 4));

  strDigit3 := fGeTerDig033(RightStr(strNosNum, 3), strIdeBan, strDigiL1, strDigiL2);

  strDiAuCo := fGeDigAut033(strIdeBan, strMoeda1, strFatVen, strVlrTit, strCodCed,
                            strNosNum, strIdeBan, strDigiL1, strDigiL2);

  strLinDig := strIdeBan + strMoeda1 + LeftStr(strCodCed, 5) + strDigit1 +
               RightStr(strCodCed, 6) + LeftStr(strNosNum, 4) + strDigit2 +
               RightStr(strNosNum, 3) + '00' + strIdeBan + strDigiL1 + strDigiL2 +
               strDigit3 + strDiAuCo + strFatVen + strVlrTit;

  Insert('.',strLinDig,6);
  Insert(' ',strLinDig,12);
  Insert('.',strLinDig,18);
  Insert(' ',strLinDig,25);
  Insert('.',strLinDig,31);
  Insert(' ',strLinDig,38);
  Insert(' ',strLinDig,40);

end;

{**************************************}
{* PROCEDURE QUE GERA A LINHA         *}
{* DIGITAVEL DO BANCO 033 - SANTANDER *}
{***********************************AF*}
function fGeLiDi033B: Boolean;
  Var
    LModalidadeCarteira: String;
begin

  SetLength(arrValidar, 2);

  arrValidar[0].strNomCam := 'Nosso Número';
  arrValidar[0].strValCam := strNosNum;
  arrValidar[0].strIdeBan := strIdeBan;
  arrValidar[0].intTamCam := 8;

  arrValidar[1].strNomCam := 'Conta Corrente (Cedente)';
  arrValidar[1].strValCam := strCodCed;
  arrValidar[1].strIdeBan := strIdeBan;
  arrValidar[1].intTamCam := 8;

  Result := fValidaStrings;
  If Not( Result ) Then
    Exit;

  If blnSantan637_444p Then
     strNumAge := strNumAge
  Else
     strNumAge := strNumAge + strDigAge;

  strCodCed := RightStr(strCodCed, 07);
  strNosNum := fStrZero(strNosNum, 13);

  If blnSantan637_444p Then
  Begin
     strDigit1 := fGePriDig033(strIdeBan, strMoeda1, '9' + LeftStr(strCodCed, 4));
     strDigit2 := fGeSegDig033(RightStr(strCodCed, 3), LeftStr(strNosNum, 7));
     strDigit3 := fGeTerDig33B(RightStr(strNosNum, 6), '0', '101');
     strDiAuCo := fGeDigAut33B(strIdeBan, strMoeda1, strFatVen, strVlrTit, '9' + strCodCed, strNosNum, '0', '101');

     strLinDig := strIdeBan + strMoeda1 + '9' + LeftStr(strCodCed, 4) + strDigit1 +
                  RightStr(strCodCed, 3) + LeftStr(strNosNum, 7) + strDigit2 +
                  RightStr(strNosNum, 6) + '0' + '101' + strDigit3 +
                  strDiAuCo + strFatVen + strVlrTit;
  End
  Else
  Begin
    LModalidadeCarteira :=  RetornaModalidaCarteira(strCodCar);

     strDigit1 := fGePriDig033(strIdeBan, strMoeda1, '9' + LeftStr(strCodCed, 4));
     strDigit2 := fGeSegDig033(RightStr(strCodCed, 3), LeftStr(strNosNum, 7));
     strDigit3 := fGeTerDig33B(RightStr(strNosNum, 6), '0', LModalidadeCarteira);
     strDiAuCo := fGeDigAut33B(strIdeBan, strMoeda1, strFatVen, strVlrTit, '9' + strCodCed, strNosNum, '0', LModalidadeCarteira);

     strLinDig := strIdeBan + strMoeda1 + '9' + LeftStr(strCodCed, 4) + strDigit1 +
                  RightStr(strCodCed, 3) + LeftStr(strNosNum, 7) + strDigit2 +
                  RightStr(strNosNum, 6) + '0' + LModalidadeCarteira + strDigit3 +
                  strDiAuCo + strFatVen + strVlrTit;
  End;

  Insert('.',strLinDig,6);
  Insert(' ',strLinDig,12);
  Insert('.',strLinDig,18);
  Insert(' ',strLinDig,25);
  Insert('.',strLinDig,31);
  Insert(' ',strLinDig,38);
  Insert(' ',strLinDig,40);

end;

function RetornaModalidaCarteira(ACodigoCarteira:String): String;
Begin
  Result := '101';

  If ACodigoCarteira.Equals('4') Then
    Result := '102'
  Else If ACodigoCarteira.Equals('6') Then
    Result := '201'
  Else If ACodigoCarteira.Equals('1') Then
    Result := '104';
End;

{**************************************}
{* PROCEDURE QUE GERA A LINHA         *}
{* DIGITAVEL DO BANCO 021 - BANESTES  *}
{***********************************AF*}
function fGeLiDi021: Boolean;
  Var
    strChaAsb: String;
begin

  strNumAge := strNumAge + strDigAge;
  SetLength(arrValidar, 2);

  arrValidar[0].strNomCam := 'Nosso Número';
  arrValidar[0].strValCam := LeftStr(strNosNum, 8);
  arrValidar[0].strIdeBan := strIdeBan;
  arrValidar[0].intTamCam := 8;

  arrValidar[1].strNomCam := 'Conta Corrente (Cedente)';
  arrValidar[1].strValCam := strCodCed;
  arrValidar[1].strIdeBan := strIdeBan;
  arrValidar[1].intTamCam := 11;

  Result := fValidaStrings;
  If Not( Result ) Then
    Exit;

  strCmpLiv := LeftStr(strNosNum, 8) + strCodCed + strCodCar + '021';
  strDiAsb1 := fCalDigAsbace1(LeftStr(strNosNum, 8) + strCodCed + strCodCar + '021');
  strDiAsb2 := fCalDigAsbace2(LeftStr(strNosNum, 8) + strCodCed + strCodCar + '021' + strDiAsb1);

  strChaAsb := LeftStr(strNosNum, 8) + strCodCed + strCodCar + '021' + strDiAsb1 + strDiAsb2;
 
  strDigit1 := fGePriDig033(strIdeBan, strMoeda1, LeftStr(strChaAsb, 5));
  strDigit2 := fGeSegDig033(Copy(strChaAsb,6,10),'');
  strDigit3 := fGeTerDig33B(RightStr(strChaAsb, 10), '', '');

  strCodBar := strIdeBan + strMoeda1 + strFatVen + strVlrTit + strChaAsb;

  strDiAuCo := fGeDigAutCon(strCodBar);

  strCodBar := LeftStr(strCodBar, 4) + strDiAuCo + RightStr(strCodBar, 39);

  strLinDig := strIdeBan + strMoeda1 + LeftStr(strChaAsb, 5) + strDigit1 +
               Copy(strChaAsb,6,10) + strDigit2 +
               RightStr(strChaAsb, 10) + strDigit3 +
               strDiAuCo + strFatVen + strVlrTit;

  Insert('.',strLinDig,6);
  Insert(' ',strLinDig,12);
  Insert('.',strLinDig,18);
  Insert(' ',strLinDig,25);
  Insert('.',strLinDig,31);
  Insert(' ',strLinDig,38);
  Insert(' ',strLinDig,40);

end;

//************************************//
// PROCEDURE QUE GERA OS DIGITOS      //
//*********************************ED*//
function fGeLiDi341: Boolean;
begin

  SetLength(arrValidar, 4);

  arrValidar[0].strNomCam := 'Nosso Número';
  arrValidar[0].strValCam := strNosNum;
  arrValidar[0].strIdeBan := strIdeBan;
  arrValidar[0].intTamCam := 9;

  arrValidar[1].strNomCam := 'Agência';
  arrValidar[1].strValCam := strNumAge;
  arrValidar[1].strIdeBan := strIdeBan;
  arrValidar[1].intTamCam := 4;

  arrValidar[2].strNomCam := 'Cedente';
  arrValidar[2].strValCam := strCodCed;
  arrValidar[2].strIdeBan := strIdeBan;
  arrValidar[2].intTamCam := 6;

  arrValidar[3].strNomCam := 'Carteira';
  arrValidar[3].strValCam := strCodCar;
  arrValidar[3].strIdeBan := strIdeBan;
  arrValidar[3].intTamCam := 3;

  Result := fValidaStrings;
  If Not( Result ) Then
    Exit;


  strDigit1 := fGePriDig(strIdeBan, strMoeda1, strCodCar + LeftStr(strNosNum, 2));

  strDigit2 := fGeSegDig(RightStr( strNosNum, 7), LeftStr(strNumAge, 3));

  strDigit3 := fGeTerDig(RightStr(strNumAge, 1), strCodCed + '000');

  strDiAuCo := fGeDigAut(strIdeBan, strMoeda1, strFatVen, strVlrTit, strCodCar,
                            strNosNum, strNumAge, strCodCed + '000');

  strLinDig := strIdeBan + strMoeda1 + strCodCar + LeftStr(strNosNum, 2) + strDigit1 +
               RightStr( strNosNum, 7) +  LeftStr(strNumAge, 3) + strDigit2 + RightStr(strNumAge, 1) +
               strCodCed + '000' + strDigit3 + strDiAuCo + strFatVen + strVlrTit;

  strCodBar := strIdeBan + strMoeda1 + strDiAuCo + strFatVen + strVlrTit +
               strCodCar + strNosNum + strNumAge + strCodCed + '000';

  Insert('.',strLinDig,6);
  Insert(' ',strLinDig,12);
  Insert('.',strLinDig,18);
  Insert(' ',strLinDig,25);
  Insert('.',strLinDig,31);
  Insert(' ',strLinDig,38);
  Insert(' ',strLinDig,40);
end;

function fGeLiDi422: Boolean;
begin

  strNumAge := strNumAge + strDigAge;

  If SameText(strCodCar,'4') Then
    SetLength(arrValidar, 5)
  Else
    SetLength(arrValidar, 3);

  arrValidar[0].strNomCam := 'Nosso Número';
  arrValidar[0].strValCam := strNosNum;
  arrValidar[0].strIdeBan := strIdeBan;
  arrValidar[0].intTamCam := 9;

  arrValidar[1].strNomCam := 'Cedente';
  arrValidar[1].strValCam := strCodCed;
  arrValidar[1].strIdeBan := strIdeBan;
  arrValidar[1].intTamCam := 9;

  arrValidar[2].strNomCam := 'Agência';
  arrValidar[2].strValCam := strNumAge;
  arrValidar[2].strIdeBan := strIdeBan;
  arrValidar[2].intTamCam := 5;

  If SameText(strCodCar,'4') Then
  Begin
    arrValidar[3].strNomCam := 'Identificação do Cedente';
    arrValidar[3].strValCam := strIdeCed;
    arrValidar[3].strIdeBan := strIdeBan;
    arrValidar[3].intTamCam := 6;

    arrValidar[4].strNomCam := 'Uso do Cliente';
    arrValidar[4].strValCam := strUsoCli;
    arrValidar[4].strIdeBan := strIdeBan;
    arrValidar[4].intTamCam := 17;
  End;

  Result := fValidaStrings;
  If Not( Result ) Then
    Exit;

  If SameText(strCodCar,'4') Then
    strCmpLiv := '7' + strIdeCed + strUsoCli + '4'
  Else
    strCmpLiv := '7' + strNumAge + strCodCed + strNosNum + '2';

  fCalculaDigitos;
  Result := fMontaCodBarLinDig;
end;


//******************************************//
//      ---  B A N R I S U L  ---           //
//******************************************//
// COMPOSICAO DO CAMPO LIVRE (BANRISUL)     //
// (20-20)  1 - CONSTANTE "2",              //
// (21-21)  1 - CONSTANTE "1",              //
// (22-25)  4 - AGENCIA,                    //
// (26-32)  7 - CODIGO DO CEDENTE,          //
// (33-40)  8 - NOSSO NUMERO                //
// (41-42)  2 - CONSTANTE "40",             //
// (43-43)  1 - DIG. CAMPO LIVER MOD(10),   //
// (44-44)  1 - DIG. CAMPO LIVER MOD(11),   //
//***************************************ED*//
function fGeLiDi041: Boolean;
var
  strNovoDigito1: String;
begin

  //*****************************************************//
  // VALIDA OS RESPECTIVOS CAMPOS ABAIXO                 //
  //**************************************************ED*//
  SetLength(arrValidar, 5);

  arrValidar[0].strNomCam := 'Agência';
  arrValidar[0].strValCam := strNumAge;
  arrValidar[0].strIdeBan := strIdeBan;
  arrValidar[0].intTamCam := 04;

  arrValidar[1].strNomCam := 'Cedente';
  arrValidar[1].strValCam := strCodCed;
  arrValidar[1].strIdeBan := strIdeBan;
  arrValidar[1].intTamCam := 07;

  arrValidar[2].strNomCam := 'Nosso Número';
  arrValidar[2].strValCam := strNosNum;
  arrValidar[2].strIdeBan := strIdeBan;
  arrValidar[2].intTamCam := 10;

  //*************************************************//
  // MONTA A STRING DE CAMPO LIVRE                   //
  //**********************************************ED*//
  strCmpLiv := '21';
  strCmpLiv := strCmpLiv + LeftStr(strNumAge, 4);
  strCmpLiv := strCmpLiv + LeftStr(strCodCed, 7);
  strCmpLiv := strCmpLiv + LeftStr(strNosNum, 8);
  strCmpLiv := strCmpLiv + '40';

  {***********************************}
  {* CALCULA O NC DA LINHA DIGITAVEL *}
  {********************************AF*}
  strDigit1_Banrisul := fCalcDigitoModulo10( strCmpLiv );
  strDigit2_Banrisul := fCalcDigitoModulo11( strCmpLiv, strDigit1_Banrisul, strNovoDigito1 );

  if strDigit1_Banrisul <> strNovoDigito1 then
    strCmpLiv := strCmpLiv + strNovoDigito1 + strDigit2_Banrisul
  else
    strCmpLiv := strCmpLiv + strDigit1_Banrisul + strDigit2_Banrisul;

  arrValidar[3].strNomCam := 'Digito 1 do campo livre';
  arrValidar[3].strValCam := strDigit1_Banrisul;
  arrValidar[3].strIdeBan := strIdeBan;
  arrValidar[3].intTamCam := 01;

  arrValidar[4].strNomCam := 'Digito 2 do campo livre';
  arrValidar[4].strValCam := strDigit2_Banrisul;
  arrValidar[4].strIdeBan := strIdeBan;
  arrValidar[4].intTamCam := 01;

  Result := fValidaStrings;
  If Not( Result ) Then
    Exit;

  fCalculaDigitos;
  Result := fMontaCodBarLinDig;
end;

{******************************************}
{*       BANCO MERCANTIL DO BRASIL        *}
{******************************************}
{*       COMPOSICAO DO CAMPO LIVRE        *}
{* (20-20)  1 - CONSTANTE "2",            *}
{* (21-21)  1 - CONSTANTE "1",            *}
{* (22-25)  4 - AGENCIA,                  *}
{* (26-32)  7 - CODIGO DO CEDENTE,        *}
{* (33-40)  8 - NOSSO NUMERO              *}
{* (41-42)  2 - CONSTANTE "40",           *}
{* (43-43)  1 - DIG. CAMPO LIVER MOD(10), *}
{* (44-44)  1 - DIG. CAMPO LIVER MOD(11)  *}
{***************************************JU*}
function fProArq389: Boolean;
Begin

  SetLength(arrValidar, 4);

  arrValidar[0].strNomCam := 'Nosso Número';
  arrValidar[0].strValCam := strNosNum;
  arrValidar[0].strIdeBan := strIdeBan;
  arrValidar[0].intTamCam := 10;

  arrValidar[1].strNomCam := 'Cedente';
  arrValidar[1].strValCam := strCodCed;
  arrValidar[1].strIdeBan := strIdeBan;
  arrValidar[1].intTamCam := 9;

  arrValidar[2].strNomCam := 'Agência';
  arrValidar[2].strValCam := strNumAge;
  arrValidar[2].strIdeBan := strIdeBan;
  arrValidar[2].intTamCam := 4;

  arrValidar[3].strNomCam := 'Carteira';
  arrValidar[3].strValCam := strCodCar;
  arrValidar[3].strIdeBan := strIdeBan;
  arrValidar[3].intTamCam := 2;

  Result := fValidaStrings;
  If Not( Result ) Then
    Exit;

  strDigit1 := fGePriDig(strIdeBan, strMoeda1, strNumAge + LeftStr(strNosNum, 1));

  strDigit2 := fGeSegDig(Copy(strNosNum, 2, 10), '');

  strDigit3 := fGeTerDig(strCodCed, '2');

  strDiAuCo := fGeDigAut(strIdeBan, strMoeda1, strFatVen, strVlrTit, strNumAge,
                            strNosNum, strCodCed, '2');

  strLinDig := strIdeBan + strMoeda1 + strNumAge + LeftStr(strNosNum, 1) + strDigit1 +
               Copy(strNosNum, 2, 10) + strDigit2 + strCodCed + '2' + strDigit3 +
               strDiAuCo + strFatVen + strVlrTit;

  strCodBar := strIdeBan + strMoeda1 + strDiAuCo + strFatVen + strVlrTit +
               strNumAge + strNosNum + strCodCed + '2';

  Insert('.',strLinDig,6);
  Insert(' ',strLinDig,12);
  Insert('.',strLinDig,18);
  Insert(' ',strLinDig,25);
  Insert('.',strLinDig,31);
  Insert(' ',strLinDig,38);
  Insert(' ',strLinDig,40);
End;

{******************************************}
{*             BANCO CECRED               *}
{*REQ-29077*****************************JU*}
function fGeLiDi085: Boolean;
begin

  SetLength(arrValidar, 4);

  arrValidar[0].strNomCam := 'Nosso Número';
  arrValidar[0].strValCam := strNosNum;
  arrValidar[0].strIdeBan := strIdeBan;
  arrValidar[0].intTamCam := 9;

  arrValidar[1].strNomCam := 'Conta Corrente';
  arrValidar[1].strValCam := strCodCed;
  arrValidar[1].strIdeBan := strIdeBan;
  arrValidar[1].intTamCam := 7;

  arrValidar[2].strNomCam := 'Dígito Conta Corrente';
  arrValidar[2].strValCam := strDigCed;
  arrValidar[2].strIdeBan := strIdeBan;
  arrValidar[2].intTamCam := 1;

  arrValidar[3].strNomCam := 'Número do convênio';
  arrValidar[3].strValCam := strNumCon;
  arrValidar[3].strIdeBan := strIdeBan;
  arrValidar[3].intTamCam := 6;

  Result := fValidaStrings;
  If Not( Result ) Then
    Exit;


  strDigit1 := fGePriDig(strIdeBan, strMoeda1, LeftStr(strNumCon, 5));

  strDigit2 := fGeSegDig(RightStr(strNumCon, 1), strCodCed + strDigCed + Leftstr(strNosNum, 1));

  strDigit3 := fGeTerDig(RightStr(strNosNum, 8), strCodCar);

  strDiAuCo := fGeDigAut(strIdeBan, strMoeda1, strFatVen, strVlrTit, strNumCon, strCodCed + strDigCed, strNosNum, strCodCar);

  strLinDig := strIdeBan + strMoeda1 + LeftStr(strNumCon, 5) + strDigit1 +
               RightStr(strNumCon, 1) + strCodCed + strDigCed + Leftstr(strNosNum, 1) + strDigit2 +
               RightStr(strNosNum, 8) + strCodCar + strDigit3 + strDiAuCo + strFatVen + strVlrTit;

  strCodBar := strIdeBan + strMoeda1 + strDiAuCo + strFatVen + strVlrTit +
               strNumCon + strCodCed + strDigCed + strNosNum + strCodCar;

  Insert('.',strLinDig,6);
  Insert(' ',strLinDig,12);
  Insert('.',strLinDig,18);
  Insert(' ',strLinDig,25);
  Insert('.',strLinDig,31);
  Insert(' ',strLinDig,38);
  Insert(' ',strLinDig,40);
end;

{******************************************}
{*             BANCO UNICRED              *}
{*REQ-30140*****************************JU*}
function fGeLiDi090: Boolean;
  Var
    strCed_10: String;
begin

  SetLength(arrValidar, 4);

  arrValidar[0].strNomCam := 'Nosso Número';
  arrValidar[0].strValCam := strNosNum;
  arrValidar[0].strIdeBan := strIdeBan;
  arrValidar[0].intTamCam := 11;

  arrValidar[1].strNomCam := 'Agência';
  arrValidar[1].strValCam := strNumAge;
  arrValidar[1].strIdeBan := strIdeBan;
  arrValidar[1].intTamCam := 4;

  arrValidar[2].strNomCam := 'Conta Corrente';
  arrValidar[2].strValCam := strCodCed;
  arrValidar[2].strIdeBan := strIdeBan;
  arrValidar[2].intTamCam := 7;

  arrValidar[3].strNomCam := 'Dígito Conta Corrente';
  arrValidar[3].strValCam := strDigCed;
  arrValidar[3].strIdeBan := strIdeBan;
  arrValidar[3].intTamCam := 1;

  Result := fValidaStrings;
  If Not( Result ) Then
    Exit;

  strCed_10 := fPadL(strCodCed + strDigCed, 10, '0');

  strDigit1 := fGePriDig(strIdeBan, strMoeda1, strNumAge + LeftStr(strCed_10, 1));

  strDigit2 := fGeSegDig(RightStr(strCed_10, 9), LeftStr(strNosNum, 1));

  strDigit3 := fGeTerDig(RightStr(strNosNum, 10), '');

  strDiAuCo := fGeDigAut(strIdeBan, strMoeda1, strFatVen, strVlrTit, strNumAge, strCed_10, strNosNum, '');

  strLinDig := strIdeBan + strMoeda1 + strNumAge + LeftStr(strCed_10, 1)+ strDigit1 +
               RightStr(strCed_10, 9) + LeftStr(strNosNum, 1) + strDigit2 +
               RightStr(strNosNum, 10) + strDigit3 + strDiAuCo + strFatVen + strVlrTit;

  strCodBar := strIdeBan + strMoeda1 + strDiAuCo + strFatVen + strVlrTit +
               strNumAge + strCed_10 + strNosNum;

  Insert('.',strLinDig,6);
  Insert(' ',strLinDig,12);
  Insert('.',strLinDig,18);
  Insert(' ',strLinDig,25);
  Insert('.',strLinDig,31);
  Insert(' ',strLinDig,38);
  Insert(' ',strLinDig,40);
end;

{*****************************************}
{* BANCO DA AMAZONIA                     *}
{*****************************************}
{*   CAMPO LIVRE                         *}
{* (20-23)  4 - AGÊNCIA COM DÍGITO,      *}
{* (24-27)  4 - CONVÊNIO,                *}
{* (28-43)  16- NOSSO NÚMERO             *}
{* (44-44)  1 - CONSTANTE "8",           *}
{**************************************JU*}
function fGeLiDi003: Boolean;
begin

  {******************}
  {* VALIDA AGÊNCIA *}
  {***************JU*}
  SetLength(arrValidar, 1);

  arrValidar[0].strNomCam := 'Agência';
  arrValidar[0].strValCam := strNumAge;
  arrValidar[0].strIdeBan := strIdeBan;
  arrValidar[0].intTamCam := 03;

  {*********************************}
  {* MONTA A STRING DE CAMPO LIVRE *}
  {******************************JU*}
  strCmpLiv := RightStr(strNumAge,3) + RightStr(strDigAge, 1);
  strCmpLiv := strCmpLiv + RightStr(strNumCon, 4);
  strCmpLiv := strCmpLiv + fPadL(strNosNum, 16, '0');
  strCmpLiv := strCmpLiv + '8';

  Result := fValidaStrings;
  If Not( Result ) Then
    Exit;

  fCalculaDigitos;
  Result := fMontaCodBarLinDig;
end;

{*****************************************}
{* BANCO GERENCIANET                     *}
{* MF: 284963 - 13/07/23                 *}
{*****************************************}
function fGeLiDi364: Boolean;
var
  strDigito: String;
begin
  strDigito := fCalcDigito('364',
                      fStrZero(strCodCed, 9) + '1' + fStrZero(LeftStr(strNosNum, 10), 10),
                      '364', 0, VS_strCodEmp);

  strCmpLiv := '';
  strCmpLiv := strCmpLiv + fStrZero(strDigito,  5);
  strCmpLiv := strCmpLiv + fStrZero(strCodCed, 9);
  strCmpLiv := strCmpLiv + '1';
  strCmpLiv := strCmpLiv + fStrZero(LeftStr(strNosNum, 10), 10);

  Result := fCalculaDigitos;
  Result := (Result) And (fMontaCodBarLinDig);
end;

{*************************************}
{* PROCESSAR ARQUIVO TXT NO FORMATO  *}
{* DO BANCO BANESPA SANTANDER 033    *}
{**********************************AF*}
procedure pProArq033B;
begin

  If Not( fGeLiDi033B ) Then
  Begin
    strCodBar := '';
    Exit;
  End;

  If blnSantan637_444p Then
  Begin
     strCodBar := strIdeBan + strMoeda1 + strDiAuCo + strFatVen + strVlrTit + '9' +
                  strCodCed + strNosNum + '0' + '101';
  End
  Else
  Begin
     strCodBar := strIdeBan + strMoeda1 + strDiAuCo + strFatVen + strVlrTit + '9' +
                  strCodCed + strNosNum + '0' + IIF(strCodCar = '4', '102', IIF(strCodCar = '6', '201', '101'));
  End;

end;

function fGeLiDi274: Boolean;
begin

  //******************************************//
  // ---  BMP MONEYPLUS LAYOUT PROPRIO ---    //
  //******************************************//
  // COMPOSICAO DO CAMPO LIVRE                //
  // (20-23)  4 - AGENCIA DO CEDENTE ,        //
  // (24-25)  2 - CARTEIRA,                   //
  // (26-36) 11 - NUMERO DO NOSSO NUMERO,     //
  // (37-43)  7 - CONTA DO CEDENTE,           //
  // (44-44)  1 - ZERO,                       //
  //***************************************ED*//

  SetLength(arrValidar, 4);

  arrValidar[0].strNomCam := 'Nosso Número';
  arrValidar[0].strValCam := strNosNum;
  arrValidar[0].strIdeBan := strIdeBan;
  arrValidar[0].intTamCam := 12;

  arrValidar[1].strNomCam := 'Cedente';
  arrValidar[1].strValCam := strCodCed;
  arrValidar[1].strIdeBan := strIdeBan;
  arrValidar[1].intTamCam := 7;

  arrValidar[2].strNomCam := 'Agência';
  arrValidar[2].strValCam := LeftStr(strNumAge, 4);
  arrValidar[2].strIdeBan := strIdeBan;
  arrValidar[2].intTamCam := 4;

  arrValidar[3].strNomCam := 'Carteira';
  arrValidar[3].strValCam := RightStr(strCodCar, 2);
  arrValidar[3].strIdeBan := strIdeBan;
  arrValidar[3].intTamCam := 2;

  Result := fValidaStrings;
  If Not( Result ) Then
    Exit;

  strDCmLiv := '0';

  strCmpLiv := '';
  strCmpLiv := strCmpLiv + LeftStr(strNumAge, 4);
  strCmpLiv := strCmpLiv + RightStr(strCodCar, 2);
  strCmpLiv := strCmpLiv + LeftStr(Trim(strNosNum), 11);
  strCmpLiv := strCmpLiv + LeftStr(Trim(strCodCed), 7);
  strCmpLiv := strCmpLiv + strDCmLiv;

  Result := fCalculaDigitos;
  Result := (Result) And (fMontaCodBarLinDig);

end;

{*************************************}
{* PROCESSAR ARQUIVO TXT NO FORMATO  *}
{* DO BANCO BANESTES                 *}
{**********************************AF*}
procedure pProArq021;
begin

  If Not( fGeLiDi021 ) Then
//    Exit;
//
//  strCodBar := strIdeBan + strMoeda1 + strDiAuCo + strFatVen + strVlrTit + LeftStr(strNosNum, 8) + strCodCed +
//               strCodCar + '021' + strDiAsb1 + strDiAsb2;
//
//  strCodBar := fGerar_String_Codigo_Barra(strCodBar);
//  fImpCodBar(TfrmQckBanestes,  frmQckBanestes);
end;

{*****************************************}
{* BANCO SAFRA 422                       *}
{**************************************AF*}
procedure pProArq422;
begin

//  If Not fGeLiDi422 Then
//    Exit;
//
//  fImpCodBar( tfrmQckBoletoSafra,  frmQckBoletoSafra);
end;

{******************************}
{* PROCESSAR ARQUIVO TXT NO   *}
{* FORMATO DO BANCO SICREDI   *}
{***************************ED*}
procedure pProArq748;
begin

  {* FUNCAO QUE GERA A LINHA DIGITAVEL *}
 { pGeLiDi748;


  strCodBar := strIdeBan + strMoeda1 + strDiAuCo + strFatVen + strVlrTit +
               strCmpLiv;

  strCodBar := fGerar_String_Codigo_Barra(strCodBar);

  fImpCodBar(TfrmQckSicredi, frmQckSicredi);
  }
end;

function fImpCodBar(ClasseForm:TFormClass;frmNomFrm: TForm): Boolean;
begin

  Try
    pCriarFormularios(ClasseForm, frmNomFrm);
    Result := True;
  Finally
    FreeAndNil(frmNomFrm);
  End;

end;

function fProArquivo(strIdeBan: String;
                     strNomeForm: String = '';
                     strNomeFila: String = '';
                     blnForcarImp: Boolean = False;
                     blnEnvioDeEmailAutomatico: Boolean = False;
                     blnBolEnvEmail: Boolean = False;
                     blnEnvioFaturamento: Boolean = False): Boolean;
  Var
    frmGeneri  : TForm;
    ClasseForm :TFormClass;
    intCont: Integer;
    strAgeDig: String;
    strCaAgNs: String;
    qryCfgRel: TUniQuery;
    strTipImp: String;
    strTmpNN : String;
    blnImpAgrup: Boolean;
    frmQckBancos: TfrmQckBancos;
    LExecutarImpCodBar: Boolean;
    fltValTit: Double;
    CpfCnpj : String;
    LDuplicatasAgrupadas:String;

begin

  Result      := True;
  qryCfgRel   := fCriaQuery;
  ClasseForm  := nil;
  frmGeneri   := nil;
  blnPegImp   := blnPreview;

  LExecutarImpCodBar := True;

  If (fEmptyStr(strNomeFila)) And
     (fRetornarReutilizarImpressoraSelecionadaBoleto) And
     (Not fEmptyStr(fRetornarImpressoraSelecionadaBoleto)) Then
    strNomeFila := fRetornarImpressoraSelecionadaBoleto;

  //*************************************//
  //* FUNCAO QUE GERA A LINHA DIGITAVEL *//
  //*************************************//
  If (strIdeBan = '001') And Not Assigned(TRetornoBoletoBancoDoBrasil(LRetornoRegistroBoletoApi)) Then
  Begin
    Result     := fGeLiDi001;

    If Result Then
    Begin

      If Not FileExists(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoBrasil.bmp') Then
      Begin
        FreeAndNil(qryCfgRel);
        Result := False;
        pMensagemOk('O logo ' + ExtractFilePath(Application.ExeName) + 'LogoBoletos\LogoBrasil.bmp deve existir na pasta indicada.');
        Exit;
      End;

      Try
        pCriarFormularios(TfrmQckBancos, frmQckBancos);

        pCarregarLayImp(frmQckBancos);

        With frmQckBancos Do
        Begin

          If ( blnBolEnvEmail And (fCampoTabela('CLI_BOLSEN', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False) = 'S') and (blnBolPdf) And (MatchStr(fCfgSis('NOVLAY', varString), ['P','C','U'])) )
             Or
            ( (blnEnvioDeEmailAutomatico) And (fCampoTabela('CLI_BOLSEN', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False) = 'S') and (blnBolPdf) And (fCfgSis('NOVLAY', varString) = 'P') ) then
          begin
            CpfCnpj := fCampoTabela('CLI_C_G_C_', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False);
            CpfCnpj := Copy(CpfCnpj, 1, 5);

            if not fEmptyStr(CpfCnpj) then
            begin
              frmQckBancos.frxPDFExport.PdfA := False;
              frmQckBancos.frxPDFExport.UserPassword := AnsiString(CpfCnpj);
              frmQckBancos.frxPDFExport.OwnerPassword := AnsiString(CpfCnpj);
              frmQckBancos.frxPDFExport.ProtectionFlags := [ePrint];
            end;
          end;

          frxPDFExport.ShowDialog   := Not blnEnvioDeEmailAutomatico;
          frxPDFExport.ShowProgress := Not blnEnvioDeEmailAutomatico;
          frxBanco.ShowProgress     := Not blnEnvioDeEmailAutomatico;
          frxBanco.EngineOptions.SilentMode := blnEnvioDeEmailAutomatico;

          If strEspeci = 'AG' Then
            frxAgrupamento.DataSet := fQryAgrupamento(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, strCodCli)
          Else
            frxAgrupamento.DataSet := fCriaQuery;

          blnImpAgrup := (Not frxAgrupamento.DataSet.IsEmpty) And (fCfgSis('MDBLAG', varInteger) = 2);
          If blnImpAgrup Then
          Begin
            TfrxBand(frxBanco.FindObject('rlbAgrupamento')).Visible   := True;
            TfrxBand(frxBanco.FindObject('rlbFichaCaixa')).Visible    := False;
            TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Visible := False;
            If (Not fEmptyStr(fCfgSis('IMGBOL'))) and FileExists(fCfgSis('IMGBOL')) Then
              TfrxPictureView(frxBanco.FindObject('imgLogo')).Picture.LoadFromFile(fCfgSis('IMGBOL'));

            frxBanco.Script.Variables['NUMPARC'] := fRetNumParcela(RightStr(strNumDoc, 1));
            frxBanco.Script.Variables['TOTPARC'] := fQtdParcelas(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, 'AG', strCodCli);
            frxBanco.Script.Variables['MAILCLI'] := strMailCli;
          End;

          For intCont := 1 To 4 Do
            TfrxPictureView(frxBanco.FindObject('imgLog' + IntToStr(intCont))).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoBrasil.bmp');

          frxBanco.Script.Variables['CODBCO'] := '001-9';

          frxBanco.FindObject('rlbTelSac').Visible := False;
          frxBanco.FindObject('rllTelSac').Visible := False;
          frxBanco.Script.Variables['USOBCO'] := '';

          If strBB_Crr <> 'S' Then
          Begin
            If Trim(strNumIns) <> '' Then
            Begin
              If strTipIns = '01' Then
                frxBanco.Script.Variables['NOMCED'] := strNomCed + '   ' + fMaskCNPJ(strNumIns)
              Else
                frxBanco.Script.Variables['NOMCED'] := strNomCed + '   ' + fMaskCPF(strNumIns);
            End
            Else
              frxBanco.Script.Variables['NOMCED'] := strNomCed;

            frxBanco.Script.Variables['ENDCED'] := strEndere;
            frxBanco.Script.Variables['SACAVA'] := strObsSac; //'';
          End
          Else
          Begin
            frxBanco.Script.Variables['NOMCED'] := 'VIDE CAMPO SACADOR/AVALISTA ABAIXO';
            frxBanco.Script.Variables['ENDCED'] := '';

            If Trim(strNumIns) <> '' Then
            Begin
              If strTipIns = '01' Then
                frxBanco.Script.Variables['SACAVA'] := fMaskCNPJ(strNumIns) + '   ' + strNomCed
              Else
                frxBanco.Script.Variables['SACAVA'] := fMaskCPF(strNumIns) + '   ' + strNomCed;
            End
            Else
              frxBanco.Script.Variables['SACAVA'] := strNomCed;

          End;

          frxBanco.Script.Variables['ENDAVA'] := '';
          frxBanco.Script.Variables['USOBCO'] := '';

          If fEmptyStr(strDigAge) Then
          Begin
            strAgeDig := strNumAge + fStrZero(strCodCed, 7);
            Insert('/', strAgeDig, 5);
          End
          Else
          Begin
            strAgeDig := strNumAge + strDigAge + fStrZero(strCodCed, 7);
            Insert('-', strAgeDig, 5);
            Insert('/', strAgeDig, 7);
            Insert(' ', strAgeDig, 8);
            Insert('-', strAgeDig, 17);

            If Copy(strAgeDig,Length(strAgeDig),1) = '-' then
            Begin
              strAgeDig := strNumAge + strDigAge + fStrZero(strCodCed, 7);
              Insert('-', strAgeDig, 5);
              Insert('/', strAgeDig, 7);
              Insert(' ', strAgeDig, 8);
              Insert('-', strAgeDig, 15);
            End;

          End;

          frxBanco.Script.Variables['BENEFI'] := 'Beneficiário';
          frxBanco.Script.Variables['BENEFI2']:= 'BENEFICIÁRIO';
          frxBanco.Script.Variables['ESPMOE'] := 'Espécie';
          frxBanco.Script.Variables['VALMOE'] := '(x) Valor';
          frxBanco.Script.Variables['PAGADO'] := 'Pagador';
          frxBanco.Script.Variables['AGECED'] := strAgeDig;
          frxBanco.Script.Variables['NOMSAC'] := strNomSac;
          frxBanco.Script.Variables['DTAVEN'] := FormatDateTime('dd/mm/yyyy', dtaDtaVen);

          If blnParNum Then
            frxBanco.Script.Variables['NUMDOC'] := RightStr(IfThen(strImprimirParcela = 'S', LeftStr(strNumDoc, Length(strNumDoc) - 1) +'-'+
                                                                                             fPadL(fRetNumParcela(RightStr(strNumDoc, 1)),003,'0')
                                                                                           , LeftStr(strNumDoc, Length(strNumDoc) - 1)),10)
          Else
            frxBanco.Script.Variables['NUMDOC'] := RightStr(IfThen(strImprimirParcela = 'S', strNumDoc, LeftStr(strNumDoc, Length(strNumDoc) - 1)), 10);

          frxBanco.Script.Variables['VALDOC'] := FormatFloat('R$ #,##0.00',fStrToFloat(strVlrTit)/100);
          frxBanco.Script.Variables['LOCEXT'] := '';
          frxBanco.Script.Variables['LOCPAG'] := 'PAGÁVEL EM QUALQUER BANCO.';
          frxBanco.Script.Variables['DTADOC'] := FormatDateTime('dd/mm/yyyy', dtaDtaEmi);
          frxBanco.Script.Variables['ESPDOC'] := 'DM';
          frxBanco.Script.Variables['DTAPRO'] := FormatDateTime('dd/mm/yyyy', dtaDtaPro);
          frxBanco.Script.Variables['CARTEI'] := strCodCar + IIF(strBB_Crr <> 'S','/' + strVariac, '');
          frxBanco.Script.Variables['CART02'] := '';
          frxBanco.Script.Variables['ACEITE'] := IIF(strIdeAce = 'S', 'Sim', 'Não');
          frxBanco.Script.Variables['CEDENT'] := 'Código do Beneficiário';
          TfrxMemoView(frxBanco.FindObject('Memo15')).Text                  := 'Beneficiário';
          TfrxMemoView(frxBanco.FindObject('lblVencimentoAceite')).Text     := 'Data de Vencimento';
          TfrxMemoView(frxBanco.FindObject('lblVencimentoCX')).Text         := 'Data de Vencimento';
          TfrxMemoView(frxBanco.FindObject('lblVencimentoRecibo')).Text     := 'Data de Vencimento';
          TfrxMemoView(frxBanco.FindObject('lblVencimentoFicha')).Text      := 'Data de Vencimento';
          TfrxMemoView(frxBanco.FindObject('lblNumDocumentoAceite')).Text   := 'Nr. Documento';
          TfrxMemoView(frxBanco.FindObject('lblNumDocumentoCX')).Text       := 'Nr. Documento';
          TfrxMemoView(frxBanco.FindObject('lblNumDocumentoRecibo')).Text   := 'Nr. Documento';
          TfrxMemoView(frxBanco.FindObject('lblNumDocumentoFicha')).Text    := 'Nr. Documento';
          TfrxMemoView(frxBanco.FindObject('lblMoraMultaJurosCX')).Text     := '(+) Juros/Multa';
          TfrxMemoView(frxBanco.FindObject('lblMoraMultaJurosRecibo')).Text := '(+) Juros/Multa';
          TfrxMemoView(frxBanco.FindObject('lblMoraMultaJurosFicha')).Text  := '(+) Juros/Multa';
          TfrxMemoView(frxBanco.FindObject('lblCodBaixaCX')).Visible        := True;
          TfrxMemoView(frxBanco.FindObject('lblCodBaixaFicha')).Visible     := True;
          TfrxMemoView(frxBanco.FindObject('lblCodBaixaRecibo')).Visible    := True;

          strCaAgNs := strCodCar + '/';

          If strBB_Crr <> 'S' Then
          Begin
            If ((RightStr(Trim(strCodCar), 2) = '16') Or (RightStr(Trim(strCodCar), 2) = '18')) And (Length(strNumCon) <= 6) Then
            Begin
              If (RightStr(Trim(strCodCar), 2) = '18') Then
              Begin
                strTmpNN := fStrZero(Copy(strNosNum, 1, Length(strNosNum)-1),17);
              End
              Else
              Begin
                strTmpNN := strNumCon + strNosNum;
              End;
            End
            Else If ((RightStr(Trim(strCodCar), 2) = '18')) And (Length(strNumCon) >= 7) Then
            Begin
              strTmpNN := strNumCon + RightStr(Trim(strNosNum), 10);
            End
            Else If (RightStr(Trim(strCodCar), 2) = '17') And (Length(strNumCon) >= 7) Then
            Begin
              strTmpNN := strNumCon + strNosNum;
            End
            Else If (RightStr(Trim(strCodCar), 2) = '17') And (Length(strNumCon) = 6) Then
            Begin
              strTmpNN := strNumCon + RightStr(strNosNum,6);
              Insert('-', strTmpNN, 12);
            End
            Else If ((RightStr(Trim(strCodCar), 2) = '12')) Then
            Begin
              strTmpNN := strNumCon + strNosNum;
              Insert('.', strTmpNN, 12);
            End
            Else
            Begin
              strTmpNN := strNumCon + strNosNum;
            End;
          End
          Else
            strTmpNN := strNosNum;

          TfrxMemoView(frxBanco.FindObject('rllCarNN1')).Text := 'Carteira/Nosso Número';

          TfrxMemoView(frxBanco.FindObject('rllNN1')).Text := 'Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN2')).Text := 'Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN3')).Text := 'Nosso Número';

          TfrxMemoView(frxBanco.FindObject('rllLinDig')).Visible := False;

          frxBanco.Script.Variables['NOSNUM'] := strTmpNN;
          frxBanco.Script.Variables['CARNOSNUM'] := strCaAgNs + strTmpNN;

          frxBanco.Script.Variables['INST01'] := IIF(fltVlrMor > 0, 'MORA DIARIA DE ' + FormatFloat('R$ #,##0.00', fltVlrMor) + '         ', '') +
                                                 IIF(fltVlrMul > 0, 'APÓS O VENCIMENTO COBRAR MULTA DE ' + FormatFloat('R$ #,##0.00', fltVlrMul), '');

          If StrToIntDef(strPraPro,0) >= 1 Then
            frxBanco.Script.Variables['INST02'] := 'PROTESTAR NO ' + strPraPro + '° DIA ' + IIF(strTipDia = '1', 'ÚTIL', 'CORRIDO') + ' APÓS O VENCIMENTO'
          Else
            frxBanco.Script.Variables['INST02'] := '';

          frxBanco.Script.Variables['INST03'] := strInstr1;
          frxBanco.Script.Variables['INST04'] := strInstr2;
          frxBanco.Script.Variables['INST05'] := strInstr3;
          frxBanco.Script.Variables['INST06'] := strInstr4;
          frxBanco.Script.Variables['INST07'] := strInstr5;
          frxBanco.Script.Variables['INST08'] := '';
          frxBanco.Script.Variables['OUTACR'] := '';

          If Length(Trim(strNuInSa)) > 11 Then
            frxBanco.Script.Variables['INSSAC'] := fMaskCNPJ(strNuInSa)
          Else frxBanco.Script.Variables['INSSAC'] := fMaskCPF(strNuInSa);

          frxBanco.Script.Variables['ENDSAC'] := strEndSac + ' - ' + strBaiSac;
          frxBanco.Script.Variables['CIDSAC'] := fMaskCEP(strCep001) + ' - ' + strCidSac + ' - ' + strEstSac;

          frxBanco.Script.Variables['LINDIG'] := strLinDig;
          TfrxBarCodeView(frxBanco.FindObject('barCodigo')).Text := strCodBar;

          TfrxBand(frxBanco.FindObject('rlbCompEntr')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrCut')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrN1')).Visible := Not (blnProEnt Or blnImpAgrup);
          TfrxBand(frxBanco.FindObject('rlbCompEntrN2')).Visible := Not (blnProEnt Or blnImpAgrup);

          {********************************************************}
          {* LAYOUT DE BOLETO EM DUAS VIAS (FICHA DE COMPENSAÇÃO E*}
          {* RECIBO DO PAGADOR                                    *}
          {*****************************************************GD*}
          if fCfgSis('NOVLAY', varString) = 'D' then
          begin
            TfrxBand(frxBanco.FindObject('rlbFichaCaixa')).Visible    := False;
            TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Visible := False;
            if not blnImpAgrup  then
              TfrxBand(frxBanco.FindObject('rlbCompEntrN1')).Visible := False;

            If (Not fEmptyStr(fCfgSis('IMGBOL'))) and FileExists(fCfgSis('IMGBOL')) Then
            begin
              TfrxBand(frxBanco.FindObject('rlbReciboSac')).Visible              := False;
              TfrxBand(frxBanco.FindObject('rlbReciboPagadorComImagem')).Visible := True;
              TfrxPictureView(frxBanco.FindObject('imgLogo2')).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoBrasil.bmp');
              TfrxPictureView(frxBanco.FindObject('imgLogoEmpresa')).Picture.LoadFromFile(fCfgSis('IMGBOL'));
            end;
          end;

          If blnProEnt Then
            TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Height := TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Height + 18;
        End;

      Except
        On E: Exception Do
        Begin
          MessageDlg(E.Message,mtError,[mbOK],0);
          Result := False;
        End;
      End;

    End;

     LExecutarImpCodBar := False;
  End

  Else If (Pos(strIdeBan, '237_993_994_992_996_997_998_991_989_987_982_984_983_990_970_979_906_978_977_976_975_974_973_962_') > 0) And
          (Not Assigned(TRetornoBoletoBradesco(LRetornoRegistroBoletoApi)))  Then
  Begin
    Result     := fGeLiDi237;

    If Result Then
    Begin

      If Not FileExists(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoBradesco.bmp') Then
      Begin
        FreeAndNil(qryCfgRel);
        Result := False;
        pMensagemOk('O logo ' + ExtractFilePath(Application.ExeName) + 'LogoBoletos\LogoBradesco.bmp deve existir na pasta indicada.');
        Exit;
      End;

      Try
        pCriarFormularios(TfrmQckBancos, frmQckBancos);

        pCarregarLayImp(frmQckBancos);

        With frmQckBancos Do
        Begin

          If ( blnBolEnvEmail And (Pos(strIdeBan, '237_') > 0) And (fCampoTabela('CLI_BOLSEN', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False) = 'S') and (blnBolPdf) And (MatchStr(fCfgSis('NOVLAY', varString), ['P','C','U'])) )
             Or
             ( (blnEnvioDeEmailAutomatico) And (Pos(strIdeBan, '237_') > 0) And ((fCampoTabela('CLI_BOLSEN', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False) = 'S') and (blnBolPdf) And (fCfgSis('NOVLAY', varString) = 'P')) ) then
          begin
            CpfCnpj := fCampoTabela('CLI_C_G_C_', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False);
            CpfCnpj := Copy(CpfCnpj, 1, 5);

            if not fEmptyStr(CpfCnpj) then
            begin
              frmQckBancos.frxPDFExport.PdfA := False;
              frmQckBancos.frxPDFExport.UserPassword := AnsiString(CpfCnpj);
              frmQckBancos.frxPDFExport.OwnerPassword := AnsiString(CpfCnpj);
              frmQckBancos.frxPDFExport.ProtectionFlags := [ePrint];
            end;
          end;

          frxPDFExport.ShowDialog   := Not blnEnvioDeEmailAutomatico;
          frxPDFExport.ShowProgress := Not blnEnvioDeEmailAutomatico;

          If strEspeci = 'AG' Then
            frxAgrupamento.DataSet := fQryAgrupamento(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, strCodCli)
          Else
            frxAgrupamento.DataSet := fCriaQuery;

          blnImpAgrup := (Not frxAgrupamento.DataSet.IsEmpty) And (fCfgSis('MDBLAG', varInteger) = 2);
          If blnImpAgrup Then
          Begin
            TfrxBand(frxBanco.FindObject('rlbAgrupamento')).Visible   := True;
            TfrxBand(frxBanco.FindObject('rlbFichaCaixa')).Visible    := False;
            TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Visible := False;
            If (Not fEmptyStr(fCfgSis('IMGBOL'))) and FileExists(fCfgSis('IMGBOL')) Then
              TfrxPictureView(frxBanco.FindObject('imgLogo')).Picture.LoadFromFile(fCfgSis('IMGBOL'));

            frxBanco.Script.Variables['NUMPARC'] := fRetNumParcela(RightStr(strNumDoc, 1));
            frxBanco.Script.Variables['TOTPARC'] := fQtdParcelas(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, 'AG', strCodCli);
            frxBanco.Script.Variables['MAILCLI'] := strMailCli;
          End;

          For intCont := 1 To 4 Do
            TfrxPictureView(frxBanco.FindObject('imgLog' + IntToStr(intCont))).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoBradesco.bmp');

          frxBanco.Script.Variables['CODBCO'] := '237-2';

          frxBanco.FindObject('rlbTelSac').Visible := False;
          frxBanco.FindObject('rllTelSac').Visible := False;

          If strIdeBan = '993' Then
          Begin
            frxBanco.Script.Variables['NOMCED'] := 'RED S.A – CNPJ 67.915.785/0001-01 ';
            frxBanco.Script.Variables['ENDCED'] := 'AV. CIDADE JARDIM 400 -14º AND. SÃO PAULO/SP';
          End
          Else If strIdeBan = '992' Then
          Begin
            frxBanco.Script.Variables['NOMCED'] := 'CREDIT BRASIL FOMENTO MERCANTIL S.A. – CNPJ 08.839.442/0001-38';
            frxBanco.Script.Variables['ENDCED'] := 'AV. DOUTOR CHUCRI ZAIDAN, 1170–TORRE CRISTAL 9ºANDAR–MORUMBI–SÃO PAULO–SP';
          End
          Else If strIdeBan = '996' Then
          Begin
            frxBanco.Script.Variables['NOMCED'] := 'ATLANTA FIDC FUNDO DE INVESTIMENTO DIREITOS CREDITÓRIOS NP – CNPJ 11.468.186/0001-24';
            frxBanco.Script.Variables['ENDCED'] := '';
          End
          Else
          Begin
            If Trim(strNumIns) <> '' Then
            Begin
              If strTipIns = '01' Then
                frxBanco.Script.Variables['NOMCED'] := IIF(fEmptyStr(strBenefi), strNomCed + '   ' + fMaskCNPJ(strNumIns), strBenefi)
              Else
                frxBanco.Script.Variables['NOMCED'] := IIF(fEmptyStr(strBenefi), strNomCed + '   ' + fMaskCPF(strNumIns), strBenefi);
            End
            Else
              frxBanco.Script.Variables['NOMCED'] := IIF(fEmptyStr(strBenefi), strNomCed, strBenefi);

            frxBanco.Script.Variables['ENDCED'] := IIF(fEmptyStr(strBenefi), strEndere, strEndBen);
          End;


          frxBanco.Script.Variables['SACAVA'] := IIF(fEmptyStr(strBenefi), '', strNomCed + IfThen(Not fEmptyStr(strNumIns),' - ' + IIF(strTipIns = '01', fMaskCNPJ(strNumIns), fMaskCPF(strNumIns)), ''));
          frxBanco.Script.Variables['ENDAVA'] := IIF(fEmptyStr(strBenefi), '', strEndere);

          frxBanco.Script.Variables['USOBCO'] := '';

          If (strIdeBan <> '993') And (strIdeBan <> '992') And (strIdeBan <> '996') And (strIdeBan <> '987') then
          Begin
            If strBraCrr = 'S' Then
            Begin
              IIF(fEmptyStr(strBenefi), '', strNomCed + IfThen(Not fEmptyStr(strNumIns),' - ' + IIF(strTipIns = '01', fMaskCNPJ(strNumIns), fMaskCPF(strNumIns)), ''));

              frxBanco.Script.Variables['SACAVA'] := strNomCed + IfThen(Not fEmptyStr(strNumIns),' - ' + IIF(strTipIns = '01', fMaskCNPJ(strNumIns), fMaskCPF(strNumIns)), '');
              frxBanco.Script.Variables['ENDAVA'] := IIF(fEmptyStr(strBenefi), '', strEndere);

              if fEmptyStr(strBenefi) then
              begin
                frxBanco.Script.Variables['NOMCED'] := strDesCed + IfThen(Not fEmptyStr(strCgcCed),' - ' + fMaskCNPJ(strCgcCed),'');
                frxBanco.Script.Variables['ENDCED'] := IfThen(Not fEmptyStr(strEndCed), strEndCed + ' ' + strCompCed + ' - ' + strBaiCed + ' ' +
                                                       strCidCed + ' - ' + strEstCed + ' - ' + fFormataCEP(strCepCed), '');

                frxBanco.Script.Variables['USOBCO'] := strUsoBco;
              end;
            End;
          End
          Else
          Begin
            If strTipIns = '01' Then
              frxBanco.Script.Variables['SACAVA'] := strNomCed + IfThen(Not fEmptyStr(strNumIns),' - ' + fMaskCNPJ(strNumIns), '')
            Else
              frxBanco.Script.Variables['SACAVA'] := strNomCed + IfThen(Not fEmptyStr(strNumIns),' - ' + fMaskCPF(strNumIns),'');

            frxBanco.Script.Variables['ENDAVA'] := strEndere;
          end;

          If (strIdeBan <> '993') And (strIdeBan <> '992') And (strIdeBan <> '996') And (strIdeBan <> '987') And (strIdeBan <> '982') And (strIdeBan <> '984') Then
            strAgeDig := strNumAge + strDigAge + strCodCed + IIF(strBraCrr = 'S', Trim(strDigCed), '')
          else
            strAgeDig := strNumAge + strDigAge + strCodCed;

          Insert('-', strAgeDig, 5);
          Insert('/', strAgeDig, 7);
          Insert('-', strAgeDig, 15);

          frxBanco.Script.Variables['BENEFI'] := 'Beneficiário';
          frxBanco.Script.Variables['BENEFI2']:= 'BENEFICIÁRIO';
          frxBanco.Script.Variables['ESPMOE'] := 'Esp. Moeda';
          frxBanco.Script.Variables['VALMOE'] := 'Valor da Moeda';
          frxBanco.Script.Variables['PAGADO'] := 'Pagador';
          frxBanco.Script.Variables['AGECED'] := strAgeDig;
          frxBanco.Script.Variables['NOMSAC'] := strNomSac;
          frxBanco.Script.Variables['DTAVEN'] := FormatDateTime('dd/mm/yyyy', dtaDtaVen);

          frxBanco.Script.Variables['NUMDOC'] := RightStr(IfThen(strImprimirParcela = 'S', strNumDoc, LeftStr(strNumDoc, Length(strNumDoc) - 1)), 10);
          If FApresentarEspDocumento = 'S' Then
            frxBanco.Script.Variables['NUMDOC'] := RightStr(frxBanco.Script.Variables['NUMDOC'], Length(frxBanco.Script.Variables['NUMDOC']) - 2) + strEspDoc;

          frxBanco.Script.Variables['VALDOC'] := FormatFloat('R$ #,##0.00',fStrToFloat(strVlrTit)/100);
          frxBanco.Script.Variables['LOCEXT'] := '';

          If strBraCrr = 'S' Then
          begin
            if ((strBcoIni = '090') and (strEstCed = 'SP')) then
              frxBanco.Script.Variables['LOCPAG'] := 'PAGÁVEL EM QUALQUER BANCO.'
            else
              frxBanco.Script.Variables['LOCPAG'] := 'PAGÁVEL EM QUALQUER BANCO.';
          end
          Else
          begin
            If (strIdeBan <> '993') Or (strIdeBan <> '992') And (strIdeBan <> '996') And (strIdeBan <> '987') And (strIdeBan <> '984') then
            Begin
              If (strIdeBan = '237') Then
                frxBanco.Script.Variables['LOCPAG'] := 'PAGÁVEL PREFERENCIALMENTE NA REDE BRADESCO OU BRADESCO EXPRESSO.'
              Else
                frxBanco.Script.Variables['LOCPAG'] := 'PAGÁVEL EM QUALQUER BANCO.'
            End
            Else
              frxBanco.Script.Variables['LOCPAG'] := 'PAGÁVEL EM QUALQUER BANCO.';
          end;

          frxBanco.Script.Variables['DTADOC'] := FormatDateTime('dd/mm/yyyy', dtaDtaEmi);
          frxBanco.Script.Variables['ESPDOC'] := 'DM';
          frxBanco.Script.Variables['DTAPRO'] := FormatDateTime('dd/mm/yyyy', dtaDtaPro);
          frxBanco.Script.Variables['CARTEI'] := strCodCar;
          frxBanco.Script.Variables['CART02'] := '';

          If (strBraCrr = 'S') and (strBcoIni = '090') and (strEstCed = 'SP') Then
            frxBanco.Script.Variables['ACEITE'] := IIF(strIdeAce = 'S', 'S', 'N')
          else
            frxBanco.Script.Variables['ACEITE'] := IIF(strIdeAce = 'S', 'Sim', 'Não');

          frxBanco.Script.Variables['CEDENT'] := 'Cód. Beneficiário';

          //If strBraCrr <> 'S' Then
           // frxBanco.Script.Variables['SACAVA'] := '';

          strCaAgNs := strCodCar + strNosNum;
          If strBraCrr <> 'S' Then
          Begin
            strCaAgNs := RightStr(strCodCar, 2) + strNosNum;

            Insert('/', strCaAgNs, 3);
            Insert('-', strCaAgNs, 15);
          End
          Else
          Begin
            if (strBcoIni = '090') and (strEstCed = 'SP') then
            begin
              Insert('/', strCaAgNs, 3);
            end
            else
            begin
              Insert('/', strCaAgNs, 3);
              Insert(' ', strCaAgNs, 4);
              Insert(' ', strCaAgNs, 7);
              Insert(' ', strCaAgNs, 17);
            end;
          End;

          TfrxMemoView(frxBanco.FindObject('rllCarNN1')).Text := 'Carteira/Nosso Número';

          TfrxMemoView(frxBanco.FindObject('rllNN1')).Text := 'Carteira/Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN2')).Text := 'Carteira/Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN3')).Text := 'Carteira/Nosso Número';

          TfrxMemoView(frxBanco.FindObject('rllLinDig')).Visible := strIdeBan = '994';
          TfrxMemoView(frxBanco.FindObject('rllLinDig2')).Visible := strIdeBan = '994';

          TfrxMemoView(frxBanco.FindObject('Memo71')).Text  := '';
          TfrxMemoView(frxBanco.FindObject('Memo132')).Text := '';
          TfrxMemoView(frxBanco.FindObject('Memo193')).Text := '';

          frxBanco.Script.Variables['NOSNUM'] := strCaAgNs;
          frxBanco.Script.Variables['CARNOSNUM'] := strCaAgNs;

          {**********************************************}
          { CASO FOR BANCO SAFRA TEM INSTRUÇÃO DIFERENTE.}
          {********************************************LE}
          If (strBraCrr = 'S') and (strbcoIni <> '090') Then
          Begin
            frxBanco.Script.Variables['BENEFI2']:= 'SACADOR/AVALISTA';
            TfrxMemoView(frxBanco.FindObject('lblInst1Cx')).WordWrap   := True;
            TfrxMemoView(frxBanco.FindObject('lblInst1Pg')).WordWrap   := True;
            TfrxMemoView(frxBanco.FindObject('lblInst1Cp')).WordWrap   := True;
            TfrxMemoView(frxBanco.FindObject('lblInst1Cx')).StretchMode:= smMaxHeight;
            TfrxMemoView(frxBanco.FindObject('lblInst1Pg')).StretchMode:= smMaxHeight;
            TfrxMemoView(frxBanco.FindObject('lblInst1Cp')).StretchMode:= smMaxHeight;
            TfrxMemoView(frxBanco.FindObject('lblInst1Cx')).Height     := TfrxMemoView(frxBanco.FindObject('lblInst1Cx')).Height + TfrxMemoView(frxBanco.FindObject('lblInst1Cx')).Height;
            TfrxMemoView(frxBanco.FindObject('lblInst1Pg')).Height     := TfrxMemoView(frxBanco.FindObject('lblInst1Pg')).Height + TfrxMemoView(frxBanco.FindObject('lblInst1Pg')).Height;
            TfrxMemoView(frxBanco.FindObject('lblInst1Cp')).Height     := TfrxMemoView(frxBanco.FindObject('lblInst1Cp')).Height + TfrxMemoView(frxBanco.FindObject('lblInst1Cp')).Height;
            TfrxMemoView(frxBanco.FindObject('lblInst2Cx')).Top        := TfrxMemoView(frxBanco.FindObject('lblInst3Cx')).Top;
            TfrxMemoView(frxBanco.FindObject('lblInst2Pg')).Top        := TfrxMemoView(frxBanco.FindObject('lblInst3Pg')).Top;
            TfrxMemoView(frxBanco.FindObject('lblInst2Cp')).Top        := TfrxMemoView(frxBanco.FindObject('lblInst3Cp')).Top;
            TfrxMemoView(frxBanco.FindObject('lblInst3Cx')).Top        := TfrxMemoView(frxBanco.FindObject('lblInst4Cx')).Top;
            TfrxMemoView(frxBanco.FindObject('lblInst3Pg')).Top        := TfrxMemoView(frxBanco.FindObject('lblInst4Pg')).Top;
            TfrxMemoView(frxBanco.FindObject('lblInst3Cp')).Top        := TfrxMemoView(frxBanco.FindObject('lblInst4Cp')).Top;
            TfrxMemoView(frxBanco.FindObject('lblInst4Cx')).Top        := TfrxMemoView(frxBanco.FindObject('lblInst5Cx')).Top;
            TfrxMemoView(frxBanco.FindObject('lblInst4Pg')).Top        := TfrxMemoView(frxBanco.FindObject('lblInst5Pg')).Top;
            TfrxMemoView(frxBanco.FindObject('lblInst4Cp')).Top        := TfrxMemoView(frxBanco.FindObject('lblInst5Cp')).Top;
            TfrxMemoView(frxBanco.FindObject('lblInst5Cx')).Top        := TfrxMemoView(frxBanco.FindObject('lblInst6Cx')).Top;
            TfrxMemoView(frxBanco.FindObject('lblInst5Pg')).Top        := TfrxMemoView(frxBanco.FindObject('lblInst6Pg')).Top;
            TfrxMemoView(frxBanco.FindObject('lblInst5Cp')).Top        := TfrxMemoView(frxBanco.FindObject('lblInst6Cp')).Top;
            TfrxMemoView(frxBanco.FindObject('lblInst6Cx')).Top        := TfrxMemoView(frxBanco.FindObject('lblInst7Cx')).Top;
            TfrxMemoView(frxBanco.FindObject('lblInst6Pg')).Top        := TfrxMemoView(frxBanco.FindObject('lblInst7Pg')).Top;
            TfrxMemoView(frxBanco.FindObject('lblInst6Cp')).Top        := TfrxMemoView(frxBanco.FindObject('lblInst7Cp')).Top;
            TfrxMemoView(frxBanco.FindObject('lblInst7Cx')).Top        := TfrxMemoView(frxBanco.FindObject('lblInst8Cx')).Top;
            TfrxMemoView(frxBanco.FindObject('lblInst7Pg')).Top        := TfrxMemoView(frxBanco.FindObject('lblInst8Pg')).Top;
            TfrxMemoView(frxBanco.FindObject('lblInst7Cp')).Top        := TfrxMemoView(frxBanco.FindObject('lblInst8Cp')).Top;
            TfrxMemoView(frxBanco.FindObject('lblInst8Cx')).Visible    := False;
            TfrxMemoView(frxBanco.FindObject('lblInst8Pg')).Visible    := False;
            TfrxMemoView(frxBanco.FindObject('lblInst8Cp')).Visible    := False;

            TfrxMemoView(frxBanco.FindObject('Memo73')).Text           := 'INSTRUÇÕES (Todas as informações deste bloqueto são de exclusiva responsabilidade do Sacador/Avalista)';
            TfrxMemoView(frxBanco.FindObject('Memo74')).Text           := 'INSTRUÇÕES (Todas as informações deste bloqueto são de exclusiva responsabilidade do Sacador/Avalista)';
            TfrxMemoView(frxBanco.FindObject('Memo75')).Text           := 'INSTRUÇÕES (Todas as informações deste bloqueto são de exclusiva responsabilidade do Sacador/Avalista)';

            frxBanco.Script.Variables['INST01'] := 'ESTE BOLETO REPRESENTA DUPLICATA CEDIDA FIDUCIARIAMENTE AO BANCO SAFRA S/A,'
                                                   +'FICANDO VEDADO O PAGAMENTO DE QUALQUER OUTRA FORMA QUE NÃO ATRAVÉS DO PRESENTE BOLETO.';

            frxBanco.Script.Variables['INST02'] :=  IIF(fltVlrMor > 0,'MORA DIÁRIA DE ' + FormatFloat('R$ #,##0.00', fltVlrMor),'')
                                                   +IIF(fltVlrMul > 0,' APÓS O VENCIMENTO COBRAR MULTA DE ' + FormatFloat('R$ #,##0.00', fltVlrMul),'')
                                                   +IIF(fltVlrMor > 0,', NÃO RECEBER O PRINCIPAL SEM JUROS DE MORA.','');

            If (StrToIntDef(strPraPro,0) >= 1) And (LeftStr(strCdIns1, 2) <> '07') Then
              frxBanco.Script.Variables['INST03'] := 'PROTESTAR APÓS ' + strPraPro + IIF(StrToInt(strPraPro) = 1,' DIA ', ' DIAS ') + 'DO VENCIMENTO'
            Else If (StrToIntDef(strPraPro,0) >= 1) And (LeftStr(strCdIns1, 2) = '07') Then
              frxBanco.Script.Variables['INST03'] := 'SUJEITO A NEGATIVAÇÃO APÓS ' + strPraPro + IIF(StrToInt(strPraPro) = 1,' DIA ', ' DIAS ') + ' DO VENCIMENTO'
            Else
              frxBanco.Script.Variables['INST03'] := '';

            frxBanco.Script.Variables['INST04'] := strInstr1;
            frxBanco.Script.Variables['INST05'] := strInstr2;
            frxBanco.Script.Variables['INST06'] := strInstr3;
            frxBanco.Script.Variables['INST07'] := strInstr4;

          End
          Else
          Begin
            frxBanco.Script.Variables['INST01'] := IIF(fltVlrMor > 0,'MORA DIARIA DE ' + FormatFloat('R$ #,##0.00', fltVlrMor),'') +
                                                 IIF(fltVlrMul > 0,'        APÓS O VENCIMENTO COBRAR MULTA DE ' + FormatFloat('R$ #,##0.00', fltVlrMul),'');
            frxBanco.Script.Variables['INST02'] := IIF(fltVlrMor > 0,'NAO RECEBER O PRINCIPAL SEM JUROS DE MORA','');


            If (StrToIntDef(strPraPro,0) >= 1) And (LeftStr(strCdIns1, 2) <> '07') Then
              frxBanco.Script.Variables['INST03'] := 'PROTESTAR APÓS ' + strPraPro + IIF(StrToInt(strPraPro) = 1,' DIA ', ' DIAS ') + 'DO VENCIMENTO'
            Else If (StrToIntDef(strPraPro,0) >= 1) And (LeftStr(strCdIns1, 2) = '07') Then
              frxBanco.Script.Variables['INST03'] := 'SUJEITO A NEGATIVAÇÃO APÓS ' + strPraPro + IIF(StrToInt(strPraPro) = 1,' DIA ', ' DIAS ') + ' DO VENCIMENTO'
            Else If (StrToIntDef(ADiasCartorio,0) >= 1) And (strIdeBan = '996') then
              frxBanco.Script.Variables['INST03'] := 'PRAZO PARA CARTÓRIO ' + ADiasCartorio + IIF(StrToInt(ADiasCartorio) = 1,' DIA CORRIDO', ' DIAS CORRIDOS') + ' APÓS VENCIMENTO'
            Else
              frxBanco.Script.Variables['INST03'] := '';

            frxBanco.Script.Variables['INST04'] := strInstr1;
            frxBanco.Script.Variables['INST05'] := strInstr2;
            frxBanco.Script.Variables['INST06'] := strInstr3;
            frxBanco.Script.Variables['INST07'] := strInstr4;
            frxBanco.Script.Variables['INST08'] := strInstr5;
          End;

          frxBanco.Script.Variables['OUTACR'] := IIF(fltOutAcr > 0, 'R$ ' + FloatToStrF(fltOutAcr, ffNumber, 12, 2), '');

          If Length(Trim(strNuInSa)) > 11 Then
            frxBanco.Script.Variables['INSSAC'] := fMaskCNPJ(strNuInSa)
          Else frxBanco.Script.Variables['INSSAC'] := fMaskCPF(strNuInSa);

          frxBanco.Script.Variables['ENDSAC'] := strEndSac + ' - ' + strBaiSac;
          frxBanco.Script.Variables['CIDSAC'] := fMaskCEP(strCep001) + ' - ' + strCidSac + ' - ' + strEstSac;
          frxBanco.Script.Variables['LINDIG'] := strLinDig;
          TfrxBarCodeView(frxBanco.FindObject('barCodigo')).Text := strCodBar;

          TfrxBand(frxBanco.FindObject('rlbCompEntr')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrCut')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrN1')).Visible := Not (blnProEnt Or blnImpAgrup);
          TfrxBand(frxBanco.FindObject('rlbCompEntrN2')).Visible := Not (blnProEnt Or blnImpAgrup);

          {********************************************************}
          {* LAYOUT DE BOLETO EM DUAS VIAS (FICHA DE COMPENSAÇÃO E*}
          {* RECIBO DO PAGADOR                                    *}
          {*****************************************************GD*}
          if fCfgSis('NOVLAY', varString) = 'D' then
          begin
            TfrxBand(frxBanco.FindObject('rlbFichaCaixa')).Visible    := False;
            TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Visible := False;
            if not blnImpAgrup  then
              TfrxBand(frxBanco.FindObject('rlbCompEntrN1')).Visible := False;

            If (Not fEmptyStr(fCfgSis('IMGBOL'))) and FileExists(fCfgSis('IMGBOL')) Then
            begin
              TfrxBand(frxBanco.FindObject('rlbReciboSac')).Visible              := False;
              TfrxBand(frxBanco.FindObject('rlbReciboPagadorComImagem')).Visible := True;
              TfrxPictureView(frxBanco.FindObject('imgLogo2')).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoBradesco.bmp');
              TfrxPictureView(frxBanco.FindObject('imgLogoEmpresa')).Picture.LoadFromFile(fCfgSis('IMGBOL'));
            end;
          end;

          If blnProEnt Then
            TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Height := TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Height + 18;
        End;

      Except
        On E: Exception Do
        Begin
          MessageDlg(E.Message,mtError,[mbOK],0);
          Result := False;
        End;
      End;

    End;

    LExecutarImpCodBar := False;
  End

  {*******************************}
  {* BANCO BMP MONEY PLUS LP 440 *}
  {*******************************}
  Else If (strIdeBan = '274') And (strBcoIni = '274LP400p') Then
  Begin
    Result := fGeLiDi274;

    If Result Then
    Begin

      If Not ValidaLogoBoleto('LogoBoletos\BMPMoneyPlus.bmp') Then
      Begin
        FreeAndNil(qryCfgRel);
        Result := False;
        Exit;
      End;

      Try
        pCriarFormularios(TfrmQckBancos, frmQckBancos);

        With frmQckBancos Do
        Begin

          For intCont := 1 To 4 Do
            TfrxPictureView(frxBanco.FindObject('imgLog' + IntToStr(intCont))).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\BMPMoneyPlus.bmp');

          frxBanco.Script.Variables['CODBCO'] := '274-7';

          If strEspeci = 'AG' Then
            frxAgrupamento.DataSet := fQryAgrupamento(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, strCodCli)
          Else
            frxAgrupamento.DataSet := fCriaQuery;

          blnImpAgrup := (Not frxAgrupamento.DataSet.IsEmpty) And (fCfgSis('MDBLAG', varInteger) = 2);
          If blnImpAgrup Then
          Begin
            TfrxBand(frxBanco.FindObject('rlbAgrupamento')).Visible := True;
            TfrxBand(frxBanco.FindObject('rlbReciboSac')).Visible := False;
            TfrxBand(frxBanco.FindObject('rlbReciboSacCut')).Visible := False;
            If (Not fEmptyStr(fCfgSis('IMGBOL'))) and FileExists(fCfgSis('IMGBOL')) Then
              TfrxPictureView(frxBanco.FindObject('imgLogo')).Picture.LoadFromFile(fCfgSis('IMGBOL'));

            frxBanco.Script.Variables['NUMPARC'] := fRetNumParcela(RightStr(strNumDoc, 1));
            frxBanco.Script.Variables['TOTPARC'] := fQtdParcelas(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, 'AG', strCodCli);
            frxBanco.Script.Variables['MAILCLI'] := strMailCli;
          End;


          If Trim(strNumIns) <> '' Then
          Begin
            If strTipIns = '01' Then
              frxBanco.Script.Variables['NOMCED'] := IIF(fEmptyStr(strBenefi), strNomCed + '   ' + fMaskCNPJ(strNumIns), strBenefi)
            Else
              frxBanco.Script.Variables['NOMCED'] := IIF(fEmptyStr(strBenefi), strNomCed + '   ' + fMaskCPF(strNumIns), strBenefi);
          End
          Else
            frxBanco.Script.Variables['NOMCED'] := IIF(fEmptyStr(strBenefi), strNomCed, strBenefi);

          frxBanco.Script.Variables['ENDCED'] := IIF(fEmptyStr(strBenefi), strEndere, strEndBen);

          frxBanco.Script.Variables['SACAVA'] := IIF(fEmptyStr(strBenefi), '', strNomCed + IfThen(Not fEmptyStr(strNumIns),' - ' + IIF(strTipIns = '01', fMaskCNPJ(strNumIns), fMaskCPF(strNumIns)), ''));
          frxBanco.Script.Variables['ENDAVA'] := IIF(fEmptyStr(strBenefi), '', strEndere);

          frxBanco.FindObject('rlbTelSac').Visible := True;
          frxBanco.FindObject('rllTelSac').Visible := False;
          frxBanco.FindObject('rllLinDig').Visible := True;


          //If strTipIns = '01' Then
          //  frxBanco.Script.Variables['SACAVA'] := strNomCed + IfThen(Not fEmptyStr(strNumIns),' - ' + fMaskCNPJ(strNumIns), '')
          //Else
          //  frxBanco.Script.Variables['SACAVA'] := strNomCed + IfThen(Not fEmptyStr(strNumIns),' - ' + fMaskCPF(strNumIns),'');
          //frxBanco.Script.Variables['ENDAVA'] := strEndere;


        strAgeDig := strNumAge + strDigAge + strCodCed;

         Insert('-', strAgeDig, 5);
         Insert('/', strAgeDig, 7);
         if Copy(strAgeDig, 15, 1) <> '' then
           Insert('-', strAgeDig, 15);

          frxBanco.Script.Variables['BENEFI'] := 'Beneficiário';
          frxBanco.Script.Variables['BENEFI2']:= 'BENEFICIÁRIO';
          frxBanco.Script.Variables['ESPMOE'] := 'Esp. Moeda';
          frxBanco.Script.Variables['VALMOE'] := 'Valor da Moeda';
          frxBanco.Script.Variables['PAGADO'] := 'Pagador';
          frxBanco.Script.Variables['AGECED'] := strAgeDig;
          frxBanco.Script.Variables['NOMSAC'] := strNomSac;
          frxBanco.Script.Variables['DTAVEN'] := FormatDateTime('dd/mm/yyyy', dtaDtaVen);
          frxBanco.Script.Variables['NUMDOC'] := RightStr(IfThen(strImprimirParcela = 'S', strNumDoc, LeftStr(strNumDoc, Length(strNumDoc) - 1)), 10);
          frxBanco.Script.Variables['LOCEXT'] := '';
          frxBanco.Script.Variables['LOCPAG'] := 'PAGÁVEL EM QUALQUER BANCO ATÉ O VENCIMENTO.';

          frxBanco.Script.Variables['CART02'] := '';
          frxBanco.Script.Variables['ACEITE'] := IIF(strIdeAce = 'S', 'Sim', 'Não');
          frxBanco.Script.Variables['CEDENT'] := 'Cód. Beneficiário';

          //frxBanco.Script.Variables['NUMDOC'] := strNumDoc;
          frxBanco.Script.Variables['VALDOC'] := FormatFloat('R$ #,##0.00',fStrToFloat(strVlrTit)/100);
          frxBanco.Script.Variables['LOCPAG'] := 'PAGÁVEL EM QUALQUER BANCO';
          frxBanco.Script.Variables['DTADOC'] := FormatDateTime('dd/mm/yyyy', dtaDtaEmi);
          frxBanco.Script.Variables['ESPDOC'] := 'DM';
          frxBanco.Script.Variables['DTAPRO'] := FormatDateTime('dd/mm/yyyy', dtaDtaPro);
          frxBanco.Script.Variables['CARTEI'] := strCodCartBoleto;

          frxBanco.Script.Variables['USOBCO'] := '';
          frxBanco.Script.Variables['SACAVA'] := '';
          frxBanco.Script.Variables['ENDAVA'] := '';

          strCaAgNs := strCodCar + strNosNum;

          If strBraCrr <> 'S' Then
          Begin
            Insert('/', strCaAgNs, 3);
            Insert('-', strCaAgNs, 15);
          End
          Else
          Begin
            Insert('/', strCaAgNs, 3);
            Insert(' ', strCaAgNs, 4);
            Insert(' ', strCaAgNs, 7);
            Insert(' ', strCaAgNs, 17);
          End;


          TfrxMemoView(frxBanco.FindObject('rllCarNN1')).Text := 'Carteira/Nosso Número';

          TfrxMemoView(frxBanco.FindObject('rllNN1')).Text := 'Carteira/Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN2')).Text := 'Carteira/Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN3')).Text := 'Carteira/Nosso Número';

          TfrxMemoView(frxBanco.FindObject('Memo71')).Text  := '';
          TfrxMemoView(frxBanco.FindObject('Memo132')).Text := '';
          TfrxMemoView(frxBanco.FindObject('Memo193')).Text := '';

          frxBanco.Script.Variables['NOSNUM'] := strCaAgNs;
          frxBanco.Script.Variables['CARNOSNUM'] := strCaAgNs;

         fltValTit := fStrToFloat(strVlrTit)/100;
          frxBanco.Script.Variables['INST01'] := IIF(fltVlrMul > 0, 'APÓS O VENCIMENTO, COBRAR MULTA DE ' + FormatFloat('#,##0.00', (fltVlrMul / fltValTit) * 100) + '% DO VALOR DO TÍTULO.          ', '');

          If fltVlrMor > 0 then
          begin
            frxBanco.Script.Variables['INST02'] := 'APÓS O VENCIMENTO, COBRAR ' + FormatFloat('R$ #,##0.00', fltVlrMor) + ' POR DIA DE ATRASO,';

            If StrToIntDef(strPraPro,0) >= 1 Then
              frxBanco.Script.Variables['INST03'] := 'PROTESTAR APÓS ' + strPraPro + IIF(StrToInt(strPraPro) = 1,' DIA ', ' DIAS ') + 'À CONTAR DO VENCIMENTO'
            Else frxBanco.Script.Variables['INST03'] := '';

            frxBanco.Script.Variables['INST04'] := strInstr1;
            frxBanco.Script.Variables['INST05'] := strInstr2;
            frxBanco.Script.Variables['INST06'] := strInstr3;
            frxBanco.Script.Variables['INST07'] := strInstr4;
            frxBanco.Script.Variables['INST08'] := strInstr5;
          end
          else
          begin
            If StrToIntDef(strPraPro,0) >= 1 Then
              frxBanco.Script.Variables['INST02'] := 'PROTESTAR APÓS ' + strPraPro + IIF(StrToInt(strPraPro) = 1,' DIA ', ' DIAS ') + 'À CONTAR DO VENCIMENTO'
            Else frxBanco.Script.Variables['INST02'] := '';

            frxBanco.Script.Variables['INST03'] := strInstr1;
            frxBanco.Script.Variables['INST04'] := strInstr2;
            frxBanco.Script.Variables['INST05'] := strInstr3;
            frxBanco.Script.Variables['INST06'] := strInstr4;
            frxBanco.Script.Variables['INST07'] := strInstr5;
            frxBanco.Script.Variables['INST08'] := '';
          end;

          If Length(Trim(strNuInSa)) > 11 Then
            frxBanco.Script.Variables['INSSAC'] := fMaskCNPJ(strNuInSa)
          Else frxBanco.Script.Variables['INSSAC'] := fMaskCPF(strNuInSa);

          frxBanco.Script.Variables['ENDSAC'] := strEndSac + ' - ' + strBaiSac;
          frxBanco.Script.Variables['CIDSAC'] := fMaskCEP(strCep001) + ' - ' + strCidSac + ' - ' + strEstSac;
          frxBanco.Script.Variables['LINDIG'] := strLinDig;
          TfrxBarCodeView(frxBanco.FindObject('barCodigo')).Text := strCodBar;

          TfrxBand(frxBanco.FindObject('rlbCompEntr')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrCut')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrN1')).Visible := Not blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrN2')).Visible := False;

          frxBanco.Script.Variables['OUTACR'] := '';

          If blnBolPdf Then
          Begin
            frxBanco.PrepareReport;
            frxPDFExport.FileName    := strNumDoc + '.pdf';
            frxPDFExport.DefaultPath := ExtractFilePath(Application.ExeName) + '\Boletos';
            frxPDFExport.ShowDialog := False;
            frxBanco.Export(frxPDFExport);
          End
          Else
          Begin
            pCarregaConfImpr(qryCfgRel, 'frmImpBoletoIndiv');
            fPreImpressao(qryCfgRel, strNomeFila, strTipImp, False);

            frxBanco.PrintOptions.Printer := AnsiReplaceStr(strNomeFila,'\\' + fRetNomeRede + '\','');

            If Not fEmptyStr(strNomeFila) Then
              frxBanco.PrintOptions.ShowDialog := False;

            If Not( blnPegImp ) Then
            Begin
              If frxBanco.PrepareReport Then frxBanco.Print;
            End Else frxBanco.ShowReport;
          End;
        End;

      Except
        On E: Exception Do
        Begin
          MessageDlg(E.Message,mtError,[mbOK],0);

          VS_ErroGeraBoletoLaser := E.Message;

          Result := False;
        End;
      End;

    End;

    FreeAndNil(qryCfgRel);
    Exit;
  End

{**********************}
  {* BANCO BMP MONEY PLUS *}
  {*MF: 300148 - 31/08/23}
  Else If (strIdeBan = '274')Then
  Begin
    Result     := fGeLiDi237;

    If Result Then
    Begin

      If Not FileExists(ExtractFilePath(Application.ExeName) + '\LogoBoletos\BMPMoneyPlus.bmp') Then
      Begin
        FreeAndNil(qryCfgRel);
        Result := False;
        pMensagemOk('O logo ' + ExtractFilePath(Application.ExeName) + 'LogoBoletos\BMPMoneyPlus.bmp deve existir na pasta indicada.');
        Exit;
      End;

      Try
        pCriarFormularios(TfrmQckBancos, frmQckBancos);

        With frmQckBancos Do
        Begin

          For intCont := 1 To 4 Do
            TfrxPictureView(frxBanco.FindObject('imgLog' + IntToStr(intCont))).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\BMPMoneyPlus.bmp');

          frxBanco.Script.Variables['CODBCO'] := '274-7';

          If strEspeci = 'AG' Then
            frxAgrupamento.DataSet := fQryAgrupamento(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, strCodCli)
          Else
            frxAgrupamento.DataSet := fCriaQuery;

          blnImpAgrup := (Not frxAgrupamento.DataSet.IsEmpty) And (fCfgSis('MDBLAG', varInteger) = 2);
          If blnImpAgrup Then
          Begin
            TfrxBand(frxBanco.FindObject('rlbAgrupamento')).Visible := True;
            TfrxBand(frxBanco.FindObject('rlbReciboSac')).Visible := False;
            TfrxBand(frxBanco.FindObject('rlbReciboSacCut')).Visible := False;
            If (Not fEmptyStr(fCfgSis('IMGBOL'))) and FileExists(fCfgSis('IMGBOL')) Then
              TfrxPictureView(frxBanco.FindObject('imgLogo')).Picture.LoadFromFile(fCfgSis('IMGBOL'));

            frxBanco.Script.Variables['NUMPARC'] := fRetNumParcela(RightStr(strNumDoc, 1));
            frxBanco.Script.Variables['TOTPARC'] := fQtdParcelas(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, 'AG', strCodCli);
            frxBanco.Script.Variables['MAILCLI'] := strMailCli;
          End;


          If Trim(strNumIns) <> '' Then
          Begin
            If strTipIns = '01' Then
              frxBanco.Script.Variables['NOMCED'] := IIF(fEmptyStr(strBenefi), strNomCed + '   ' + fMaskCNPJ(strNumIns), strBenefi)
            Else
              frxBanco.Script.Variables['NOMCED'] := IIF(fEmptyStr(strBenefi), strNomCed + '   ' + fMaskCPF(strNumIns), strBenefi);
          End
          Else
            frxBanco.Script.Variables['NOMCED'] := IIF(fEmptyStr(strBenefi), strNomCed, strBenefi);

          frxBanco.Script.Variables['ENDCED'] := IIF(fEmptyStr(strBenefi), strEndere, strEndBen);

          frxBanco.Script.Variables['SACAVA'] := IIF(fEmptyStr(strBenefi), '', strNomCed + IfThen(Not fEmptyStr(strNumIns),' - ' + IIF(strTipIns = '01', fMaskCNPJ(strNumIns), fMaskCPF(strNumIns)), ''));
          frxBanco.Script.Variables['ENDAVA'] := IIF(fEmptyStr(strBenefi), '', strEndere);

          frxBanco.FindObject('rlbTelSac').Visible := True;
          frxBanco.FindObject('rllTelSac').Visible := False;
          frxBanco.FindObject('rllLinDig').Visible := True;


          If strTipIns = '01' Then
            frxBanco.Script.Variables['SACAVA'] := strNomCed + IfThen(Not fEmptyStr(strNumIns),' - ' + fMaskCNPJ(strNumIns), '')
          Else
            frxBanco.Script.Variables['SACAVA'] := strNomCed + IfThen(Not fEmptyStr(strNumIns),' - ' + fMaskCPF(strNumIns),'');
          frxBanco.Script.Variables['ENDAVA'] := strEndere;


        strAgeDig := strNumAge + strDigAge + strCodCed;

         Insert('-', strAgeDig, 5);
         Insert('/', strAgeDig, 7);
         if Copy(strAgeDig, 15, 1) <> '' then
           Insert('-', strAgeDig, 15);

          frxBanco.Script.Variables['BENEFI'] := 'Beneficiário';
          frxBanco.Script.Variables['BENEFI2']:= 'BENEFICIÁRIO';
          frxBanco.Script.Variables['ESPMOE'] := 'Esp. Moeda';
          frxBanco.Script.Variables['VALMOE'] := 'Valor da Moeda';
          frxBanco.Script.Variables['PAGADO'] := 'Pagador';
          frxBanco.Script.Variables['AGECED'] := strAgeDig;
          frxBanco.Script.Variables['NOMSAC'] := strNomSac;
          frxBanco.Script.Variables['DTAVEN'] := FormatDateTime('dd/mm/yyyy', dtaDtaVen);
          frxBanco.Script.Variables['NUMDOC'] := RightStr(IfThen(strImprimirParcela = 'S', strNumDoc, LeftStr(strNumDoc, Length(strNumDoc) - 1)), 10);
          frxBanco.Script.Variables['LOCEXT'] := '';
          frxBanco.Script.Variables['LOCPAG'] := 'PAGÁVEL EM QUALQUER BANCO ATÉ O VENCIMENTO.';

          frxBanco.Script.Variables['CART02'] := '';
          frxBanco.Script.Variables['ACEITE'] := IIF(strIdeAce = 'S', 'Sim', 'Não');
          frxBanco.Script.Variables['CEDENT'] := 'Cód. Beneficiário';

          //frxBanco.Script.Variables['NUMDOC'] := strNumDoc;
          frxBanco.Script.Variables['VALDOC'] := FormatFloat('R$ #,##0.00',fStrToFloat(strVlrTit)/100);
          frxBanco.Script.Variables['LOCPAG'] := 'PAGÁVEL EM QUALQUER BANCO';
          frxBanco.Script.Variables['DTADOC'] := FormatDateTime('dd/mm/yyyy', dtaDtaEmi);
          frxBanco.Script.Variables['ESPDOC'] := 'DM';
          frxBanco.Script.Variables['DTAPRO'] := FormatDateTime('dd/mm/yyyy', dtaDtaPro);
          frxBanco.Script.Variables['CARTEI'] := strCodCar;

          frxBanco.Script.Variables['USOBCO'] := '';
          frxBanco.Script.Variables['SACAVA'] := '';
          frxBanco.Script.Variables['ENDAVA'] := '';

          strCaAgNs := strCodCar + strNosNum;

          If strBraCrr <> 'S' Then
          Begin
            Insert('/', strCaAgNs, 4);
            Insert('-', strCaAgNs, 16);
          End
          Else
          Begin
            Insert('/', strCaAgNs, 3);
            Insert(' ', strCaAgNs, 4);
            Insert(' ', strCaAgNs, 7);
            Insert(' ', strCaAgNs, 17);
          End;


          TfrxMemoView(frxBanco.FindObject('rllCarNN1')).Text := 'Carteira/Nosso Número';

          TfrxMemoView(frxBanco.FindObject('rllNN1')).Text := 'Carteira/Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN2')).Text := 'Carteira/Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN3')).Text := 'Carteira/Nosso Número';

          TfrxMemoView(frxBanco.FindObject('Memo71')).Text  := '';
          TfrxMemoView(frxBanco.FindObject('Memo132')).Text := '';
          TfrxMemoView(frxBanco.FindObject('Memo193')).Text := '';

          frxBanco.Script.Variables['NOSNUM'] := strCaAgNs;
          frxBanco.Script.Variables['CARNOSNUM'] := strCaAgNs;

         fltValTit := fStrToFloat(strVlrTit)/100;
          frxBanco.Script.Variables['INST01'] := IIF(fltVlrMul > 0, 'APÓS O VENCIMENTO, COBRAR MULTA DE ' + FormatFloat('#,##0.00', (fltVlrMul / fltValTit) * 100) + '% DO VALOR DO TÍTULO.          ', '');

          If fltVlrMor > 0 then
          begin
            frxBanco.Script.Variables['INST02'] := 'APÓS O VENCIMENTO, COBRAR ' + FormatFloat('R$ #,##0.00', fltVlrMor) + ' POR DIA DE ATRASO,';

            If StrToIntDef(strPraPro,0) >= 1 Then
              frxBanco.Script.Variables['INST03'] := 'PROTESTAR APÓS ' + strPraPro + IIF(StrToInt(strPraPro) = 1,' DIA ', ' DIAS ') + 'À CONTAR DO VENCIMENTO'
            Else frxBanco.Script.Variables['INST03'] := '';

            frxBanco.Script.Variables['INST04'] := strInstr1;
            frxBanco.Script.Variables['INST05'] := strInstr2;
            frxBanco.Script.Variables['INST06'] := strInstr3;
            frxBanco.Script.Variables['INST07'] := strInstr4;
            frxBanco.Script.Variables['INST08'] := strInstr5;
          end
          else
          begin
            If StrToIntDef(strPraPro,0) >= 1 Then
              frxBanco.Script.Variables['INST02'] := 'PROTESTAR APÓS ' + strPraPro + IIF(StrToInt(strPraPro) = 1,' DIA ', ' DIAS ') + 'À CONTAR DO VENCIMENTO'
            Else frxBanco.Script.Variables['INST02'] := '';

            frxBanco.Script.Variables['INST03'] := strInstr1;
            frxBanco.Script.Variables['INST04'] := strInstr2;
            frxBanco.Script.Variables['INST05'] := strInstr3;
            frxBanco.Script.Variables['INST06'] := strInstr4;
            frxBanco.Script.Variables['INST07'] := strInstr5;
            frxBanco.Script.Variables['INST08'] := '';
          end;

          If Length(Trim(strNuInSa)) > 11 Then
            frxBanco.Script.Variables['INSSAC'] := fMaskCNPJ(strNuInSa)
          Else frxBanco.Script.Variables['INSSAC'] := fMaskCPF(strNuInSa);

          frxBanco.Script.Variables['ENDSAC'] := strEndSac + ' - ' + strBaiSac;
          frxBanco.Script.Variables['CIDSAC'] := fMaskCEP(strCep001) + ' - ' + strCidSac + ' - ' + strEstSac;
          frxBanco.Script.Variables['LINDIG'] := strLinDig;
          TfrxBarCodeView(frxBanco.FindObject('barCodigo')).Text := strCodBar;

          TfrxBand(frxBanco.FindObject('rlbCompEntr')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrCut')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrN1')).Visible := Not blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrN2')).Visible := False;

          frxBanco.Script.Variables['OUTACR'] := '';

          If blnBolPdf Then
          Begin
            frxBanco.PrepareReport;
            frxPDFExport.FileName    := strNumDoc + '.pdf';
            frxPDFExport.DefaultPath := ExtractFilePath(Application.ExeName) + '\Boletos';
            frxPDFExport.ShowDialog := False;
            frxBanco.Export(frxPDFExport);
          End
          Else
          Begin
            pCarregaConfImpr(qryCfgRel, 'frmImpBoletoIndiv');
            fPreImpressao(qryCfgRel, strNomeFila, strTipImp, False);

            frxBanco.PrintOptions.Printer := AnsiReplaceStr(strNomeFila,'\\' + fRetNomeRede + '\','');

            If Not fEmptyStr(strNomeFila) Then
              frxBanco.PrintOptions.ShowDialog := False;

            If Not( blnPegImp ) Then
            Begin
              If frxBanco.PrepareReport Then frxBanco.Print;
            End Else frxBanco.ShowReport;
          End;
        End;

      Except
        On E: Exception Do
        Begin
          MessageDlg(E.Message,mtError,[mbOK],0);
          Result := False;
        End;
      End;

    End;

    FreeAndNil(qryCfgRel);
    Exit;
  End

  Else If Pos(strIdeBan, '099_') > 0 Then
  Begin
    Result     := fGeLiDi237;

    If Result Then
    Begin

      If Not FileExists(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoUniprime.bmp') Then
      Begin
        FreeAndNil(qryCfgRel);
        Result := False;
        pMensagemOk('O logo ' + ExtractFilePath(Application.ExeName) + 'LogoBoletos\LogoUniprime.bmp deve existir na pasta indicada.');
        Exit;
      End;

      Try
        pCriarFormularios(TfrmQckBancos, frmQckBancos);

        With frmQckBancos Do
        Begin

          If ( blnBolEnvEmail And (fCampoTabela('CLI_BOLSEN', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False) = 'S') and (blnBolPdf) And (MatchStr(fCfgSis('NOVLAY', varString), ['P','C','U'])) )
             Or
             ( (blnEnvioDeEmailAutomatico) And (fCampoTabela('CLI_BOLSEN', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False) = 'S') and (blnBolPdf) And (fCfgSis('NOVLAY', varString) = 'P') ) then
          begin
            CpfCnpj := fCampoTabela('CLI_C_G_C_', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False);
            CpfCnpj := Copy(CpfCnpj, 1, 5);

            if not fEmptyStr(CpfCnpj) then
            begin
              frmQckBancos.frxPDFExport.PdfA := False;
              frmQckBancos.frxPDFExport.UserPassword := AnsiString(CpfCnpj);
              frmQckBancos.frxPDFExport.OwnerPassword := AnsiString(CpfCnpj);
              frmQckBancos.frxPDFExport.ProtectionFlags := [ePrint];
            end;
          end;

          frxPDFExport.ShowDialog   := Not blnEnvioDeEmailAutomatico;
          frxPDFExport.ShowProgress := Not blnEnvioDeEmailAutomatico;

          If strEspeci = 'AG' Then
            frxAgrupamento.DataSet := fQryAgrupamento(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, strCodCli)
          Else
            frxAgrupamento.DataSet := fCriaQuery;

          blnImpAgrup := (Not frxAgrupamento.DataSet.IsEmpty) And (fCfgSis('MDBLAG', varInteger) = 2);
          If blnImpAgrup Then
          Begin
            TfrxBand(frxBanco.FindObject('rlbAgrupamento')).Visible := True;
            TfrxBand(frxBanco.FindObject('rlbReciboSac')).Visible := False;
            TfrxBand(frxBanco.FindObject('rlbReciboSacCut')).Visible := False;
            If (Not fEmptyStr(fCfgSis('IMGBOL'))) and FileExists(fCfgSis('IMGBOL')) Then
              TfrxPictureView(frxBanco.FindObject('imgLogo')).Picture.LoadFromFile(fCfgSis('IMGBOL'));

            frxBanco.Script.Variables['NUMPARC'] := fRetNumParcela(RightStr(strNumDoc, 1));
            frxBanco.Script.Variables['TOTPARC'] := fQtdParcelas(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, 'AG', strCodCli);
            frxBanco.Script.Variables['MAILCLI'] := strMailCli;
          End;

          For intCont := 1 To 4 Do
            TfrxPictureView(frxBanco.FindObject('imgLog' + IntToStr(intCont))).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoUniprime.bmp');

          frxBanco.Script.Variables['CODBCO'] := '099-X';

          frxBanco.FindObject('rlbTelSac').Visible := False;
          frxBanco.FindObject('rllTelSac').Visible := False;

          If Trim(strNumIns) <> '' Then
          Begin
            If strTipIns = '01' Then
              frxBanco.Script.Variables['NOMCED'] := IIF(fEmptyStr(strBenefi), strNomCed + '   ' + fMaskCNPJ(strNumIns), strBenefi)
            Else
              frxBanco.Script.Variables['NOMCED'] := IIF(fEmptyStr(strBenefi), strNomCed + '   ' + fMaskCPF(strNumIns), strBenefi);
          End
          Else
            frxBanco.Script.Variables['NOMCED'] := IIF(fEmptyStr(strBenefi), strNomCed, strBenefi);

          frxBanco.Script.Variables['ENDCED'] := IIF(fEmptyStr(strBenefi), strEndere, strEndBen);

          {frxBanco.Script.Variables['SACAVA'] := IIF(fEmptyStr(strBenefi), '', strNomCed + IfThen(Not fEmptyStr(strNumIns),' - ' + IIF(strTipIns = '01', fMaskCNPJ(strNumIns), fMaskCPF(strNumIns)), ''));
          frxBanco.Script.Variables['ENDAVA'] := IIF(fEmptyStr(strBenefi), '', strEndere);}

          frxBanco.Script.Variables['USOBCO'] := '';

{          If strTipIns = '01' Then
            frxBanco.Script.Variables['SACAVA'] := strNomCed + IfThen(Not fEmptyStr(strNumIns),' - ' + fMaskCNPJ(strNumIns), '')
          Else
            frxBanco.Script.Variables['SACAVA'] := strNomCed + IfThen(Not fEmptyStr(strNumIns),' - ' + fMaskCPF(strNumIns),'');}

          frxBanco.Script.Variables['SACAVA'] := '';
          frxBanco.Script.Variables['ENDAVA'] := '';

          strAgeDig := strNumAge + strDigAge + strCodCed;

          Insert('-', strAgeDig, 5);
          Insert('/', strAgeDig, 7);
          Insert('-', strAgeDig, 15);

          frxBanco.Script.Variables['BENEFI'] := 'Beneficiário';
          frxBanco.Script.Variables['BENEFI2']:= 'BENEFICIÁRIO';
          frxBanco.Script.Variables['ESPMOE'] := 'Esp. Moeda';
          frxBanco.Script.Variables['VALMOE'] := 'Valor da Moeda';
          frxBanco.Script.Variables['PAGADO'] := 'Pagador';
          frxBanco.Script.Variables['AGECED'] := strAgeDig;
          frxBanco.Script.Variables['NOMSAC'] := strNomSac;
          frxBanco.Script.Variables['DTAVEN'] := FormatDateTime('dd/mm/yyyy', dtaDtaVen);
          frxBanco.Script.Variables['NUMDOC'] := RightStr(IfThen(strImprimirParcela = 'S', strNumDoc, LeftStr(strNumDoc, Length(strNumDoc) - 1)), 10);
          frxBanco.Script.Variables['VALDOC'] := FormatFloat('R$ #,##0.00',fStrToFloat(strVlrTit)/100);
          frxBanco.Script.Variables['LOCEXT'] := '';
          frxBanco.Script.Variables['LOCPAG'] := 'PAGÁVEL EM QUALQUER BANCO ATÉ O VENCIMENTO.';

          frxBanco.Script.Variables['DTADOC'] := FormatDateTime('dd/mm/yyyy', dtaDtaEmi);
          frxBanco.Script.Variables['ESPDOC'] := 'DM';
          frxBanco.Script.Variables['DTAPRO'] := FormatDateTime('dd/mm/yyyy', dtaDtaPro);
          frxBanco.Script.Variables['CARTEI'] := strCodCar;
          frxBanco.Script.Variables['CART02'] := '';
          frxBanco.Script.Variables['ACEITE'] := IIF(strIdeAce = 'S', 'Sim', 'Não');
          frxBanco.Script.Variables['CEDENT'] := 'Cód. Beneficiário';

          strCaAgNs := strCodCar + strNosNum;
          Insert('/', strCaAgNs, 4);
          Insert('-', strCaAgNs, 16);

          TfrxMemoView(frxBanco.FindObject('rllCarNN1')).Text := 'Carteira/Nosso Número';

          TfrxMemoView(frxBanco.FindObject('rllNN1')).Text := 'Carteira/Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN2')).Text := 'Carteira/Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN3')).Text := 'Carteira/Nosso Número';

          TfrxMemoView(frxBanco.FindObject('rllLinDig')).Visible := strIdeBan = '994';

          TfrxMemoView(frxBanco.FindObject('Memo71')).Text  := '';
          TfrxMemoView(frxBanco.FindObject('Memo132')).Text := '';
          TfrxMemoView(frxBanco.FindObject('Memo193')).Text := '';

          //INSTRUÇÕES
          TfrxMemoView(frxBanco.FindObject('Memo73')).Text := '';
          TfrxMemoView(frxBanco.FindObject('Memo74')).Text := '';
          TfrxMemoView(frxBanco.FindObject('Memo75')).Text := '';

          frxBanco.Script.Variables['NOSNUM'] := strCaAgNs;
          frxBanco.Script.Variables['CARNOSNUM'] := strCaAgNs;

          frxBanco.Script.Variables['INST01'] := IIF(fltVlrMor > 0,'MORA DIARIA DE ' + FormatFloat('R$ #,##0.00', fltVlrMor),'') +
                                                 IIF(fltVlrMul > 0,'        APÓS O VENCIMENTO COBRAR MULTA DE ' + FormatFloat('R$ #,##0.00', fltVlrMul),'');
          frxBanco.Script.Variables['INST02'] := IIF(fltVlrMor > 0,'NAO RECEBER O PRINCIPAL SEM JUROS DE MORA','');

          If (StrToIntDef(strPraPro,0) >= 1) And (LeftStr(strCdIns1, 2) <> '07') Then
            frxBanco.Script.Variables['INST03'] := 'PROTESTAR APÓS ' + strPraPro + IIF(StrToInt(strPraPro) = 1,' DIA ', ' DIAS ') + 'DO VENCIMENTO'
          Else If (StrToIntDef(strPraPro,0) >= 1) And (LeftStr(strCdIns1, 2) = '07') Then
            frxBanco.Script.Variables['INST03'] := 'SUJEITO A NEGATIVAÇÃO APÓS ' + strPraPro + IIF(StrToInt(strPraPro) = 1,' DIA ', ' DIAS ') + ' DO VENCIMENTO'
          Else If (StrToIntDef(ADiasCartorio,0) >= 1) And (strIdeBan = '996') then
            frxBanco.Script.Variables['INST03'] := 'PRAZO PARA CARTÓRIO ' + ADiasCartorio + IIF(StrToInt(ADiasCartorio) = 1,' DIA CORRIDO', ' DIAS CORRIDOS') + ' APÓS VENCIMENTO'
          Else
            frxBanco.Script.Variables['INST03'] := '';

          frxBanco.Script.Variables['INST04'] := strInstr1;
          frxBanco.Script.Variables['INST05'] := strInstr2;
          frxBanco.Script.Variables['INST06'] := strInstr3;
          frxBanco.Script.Variables['INST07'] := strInstr4;
          frxBanco.Script.Variables['INST08'] := strInstr5;

          frxBanco.Script.Variables['OUTACR'] := IIF(fltOutAcr > 0, 'R$ ' + FloatToStrF(fltOutAcr, ffNumber, 12, 2), '');

          If Length(Trim(strNuInSa)) > 11 Then
            frxBanco.Script.Variables['INSSAC'] := fMaskCNPJ(strNuInSa)
          Else frxBanco.Script.Variables['INSSAC'] := fMaskCPF(strNuInSa);

          frxBanco.Script.Variables['ENDSAC'] := strEndSac + ' - ' + strBaiSac;
          frxBanco.Script.Variables['CIDSAC'] := fMaskCEP(strCep001) + ' - ' + strCidSac + ' - ' + strEstSac;
          frxBanco.Script.Variables['LINDIG'] := strLinDig;
          TfrxBarCodeView(frxBanco.FindObject('barCodigo')).Text := strCodBar;

          TfrxBand(frxBanco.FindObject('rlbCompEntr')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrCut')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrN1')).Visible := Not (blnProEnt Or blnImpAgrup);
          TfrxBand(frxBanco.FindObject('rlbCompEntrN2')).Visible := Not (blnProEnt Or blnImpAgrup);

          If blnProEnt Then
            TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Height := TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Height + 18;
        End;

      Except
        On E: Exception Do
        Begin
          MessageDlg(E.Message,mtError,[mbOK],0);
          Result := False;
        End;
      End;

    End;

    LExecutarImpCodBar := False;
  End

  Else If Pos(strIdeBan, '084_') > 0 Then
  Begin
    Result     := fGeLiDi237;

    If Result Then
    Begin

      If Not FileExists(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoSisprime.bmp') Then
      Begin
        FreeAndNil(qryCfgRel);
        Result := False;
        pMensagemOk('O logo ' + ExtractFilePath(Application.ExeName) + 'LogoBoletos\LogoSisprime.bmp deve existir na pasta indicada.');
        Exit;
      End;

      Try
        pCriarFormularios(TfrmQckBancos, frmQckBancos);

        With frmQckBancos Do
        Begin

          If ( blnBolEnvEmail And (fCampoTabela('CLI_BOLSEN', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False) = 'S') and (blnBolPdf) And (MatchStr(fCfgSis('NOVLAY', varString), ['P','C','U'])) )
             Or
             ( (blnEnvioDeEmailAutomatico) And (fCampoTabela('CLI_BOLSEN', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False) = 'S') and (blnBolPdf) And (fCfgSis('NOVLAY', varString) = 'P') ) then
          begin
            CpfCnpj := fCampoTabela('CLI_C_G_C_', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False);
            CpfCnpj := Copy(CpfCnpj, 1, 5);

            if not fEmptyStr(CpfCnpj) then
            begin
              frmQckBancos.frxPDFExport.PdfA := False;
              frmQckBancos.frxPDFExport.UserPassword := AnsiString(CpfCnpj);
              frmQckBancos.frxPDFExport.OwnerPassword := AnsiString(CpfCnpj);
              frmQckBancos.frxPDFExport.ProtectionFlags := [ePrint];
            end;
          end;

          frxPDFExport.ShowDialog   := Not blnEnvioDeEmailAutomatico;
          frxPDFExport.ShowProgress := Not blnEnvioDeEmailAutomatico;

          If strEspeci = 'AG' Then
            frxAgrupamento.DataSet := fQryAgrupamento(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, strCodCli)
          Else
            frxAgrupamento.DataSet := fCriaQuery;

          blnImpAgrup := (Not frxAgrupamento.DataSet.IsEmpty) And (fCfgSis('MDBLAG', varInteger) = 2);
          If blnImpAgrup Then
          Begin
            TfrxBand(frxBanco.FindObject('rlbAgrupamento')).Visible := True;
            TfrxBand(frxBanco.FindObject('rlbReciboSac')).Visible := False;
            TfrxBand(frxBanco.FindObject('rlbReciboSacCut')).Visible := False;
            If (Not fEmptyStr(fCfgSis('IMGBOL'))) and FileExists(fCfgSis('IMGBOL')) Then
              TfrxPictureView(frxBanco.FindObject('imgLogo')).Picture.LoadFromFile(fCfgSis('IMGBOL'));

            frxBanco.Script.Variables['NUMPARC'] := fRetNumParcela(RightStr(strNumDoc, 1));
            frxBanco.Script.Variables['TOTPARC'] := fQtdParcelas(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, 'AG', strCodCli);
            frxBanco.Script.Variables['MAILCLI'] := strMailCli;
          End;

          For intCont := 1 To 4 Do
            TfrxPictureView(frxBanco.FindObject('imgLog' + IntToStr(intCont))).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoSisprime.bmp');

          frxBanco.Script.Variables['CODBCO'] := '084-X';

          frxBanco.FindObject('rlbTelSac').Visible := False;
          frxBanco.FindObject('rllTelSac').Visible := False;

          If Trim(strNumIns) <> '' Then
          Begin
            If strTipIns = '01' Then
              frxBanco.Script.Variables['NOMCED'] := IIF(fEmptyStr(strBenefi), strNomCed + '   ' + fMaskCNPJ(strNumIns), strBenefi)
            Else
              frxBanco.Script.Variables['NOMCED'] := IIF(fEmptyStr(strBenefi), strNomCed + '   ' + fMaskCPF(strNumIns), strBenefi);
          End
          Else
            frxBanco.Script.Variables['NOMCED'] := IIF(fEmptyStr(strBenefi), strNomCed, strBenefi);

          frxBanco.Script.Variables['ENDCED'] := IIF(fEmptyStr(strBenefi), strEndere, strEndBen);

          {frxBanco.Script.Variables['SACAVA'] := IIF(fEmptyStr(strBenefi), '', strNomCed + IfThen(Not fEmptyStr(strNumIns),' - ' + IIF(strTipIns = '01', fMaskCNPJ(strNumIns), fMaskCPF(strNumIns)), ''));
          frxBanco.Script.Variables['ENDAVA'] := IIF(fEmptyStr(strBenefi), '', strEndere);}

          frxBanco.Script.Variables['USOBCO'] := '';

{          If strTipIns = '01' Then
            frxBanco.Script.Variables['SACAVA'] := strNomCed + IfThen(Not fEmptyStr(strNumIns),' - ' + fMaskCNPJ(strNumIns), '')
          Else
            frxBanco.Script.Variables['SACAVA'] := strNomCed + IfThen(Not fEmptyStr(strNumIns),' - ' + fMaskCPF(strNumIns),'');}

          frxBanco.Script.Variables['SACAVA'] := '';
          frxBanco.Script.Variables['ENDAVA'] := '';

          strAgeDig := strNumAge + strDigAge + strCodCed;

          Insert('-', strAgeDig, 5);
          Insert('/', strAgeDig, 7);
          Insert('-', strAgeDig, 15);

          frxBanco.Script.Variables['BENEFI'] := 'Beneficiário';
          frxBanco.Script.Variables['BENEFI2']:= 'BENEFICIÁRIO';
          frxBanco.Script.Variables['ESPMOE'] := 'Esp. Moeda';
          frxBanco.Script.Variables['VALMOE'] := 'Valor da Moeda';
          frxBanco.Script.Variables['PAGADO'] := 'Pagador';
          frxBanco.Script.Variables['AGECED'] := strAgeDig;
          frxBanco.Script.Variables['NOMSAC'] := strNomSac;
          frxBanco.Script.Variables['DTAVEN'] := FormatDateTime('dd/mm/yyyy', dtaDtaVen);
          frxBanco.Script.Variables['NUMDOC'] := RightStr(IfThen(strImprimirParcela = 'S', strNumDoc, LeftStr(strNumDoc, Length(strNumDoc) - 1)), 10);
          frxBanco.Script.Variables['VALDOC'] := FormatFloat('R$ #,##0.00',fStrToFloat(strVlrTit)/100);
          frxBanco.Script.Variables['LOCEXT'] := '';
          frxBanco.Script.Variables['LOCPAG'] := 'PAGÁVEL EM QUALQUER BANCO ATÉ O VENCIMENTO.';

          frxBanco.Script.Variables['DTADOC'] := FormatDateTime('dd/mm/yyyy', dtaDtaEmi);
          frxBanco.Script.Variables['ESPDOC'] := 'DM';
          frxBanco.Script.Variables['DTAPRO'] := FormatDateTime('dd/mm/yyyy', dtaDtaPro);
          frxBanco.Script.Variables['CARTEI'] := strCodCar;
          frxBanco.Script.Variables['CART02'] := '';
          frxBanco.Script.Variables['ACEITE'] := IIF(strIdeAce = 'S', 'Sim', 'Não');
          frxBanco.Script.Variables['CEDENT'] := 'Cód. Beneficiário';

          strCaAgNs := strCodCar + strNosNum;
          Insert('/', strCaAgNs, 4);
          Insert('-', strCaAgNs, 16);

          TfrxMemoView(frxBanco.FindObject('rllCarNN1')).Text := 'Carteira/Nosso Número';

          TfrxMemoView(frxBanco.FindObject('rllNN1')).Text := 'Carteira/Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN2')).Text := 'Carteira/Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN3')).Text := 'Carteira/Nosso Número';

          TfrxMemoView(frxBanco.FindObject('rllLinDig')).Visible := strIdeBan = '994';

          TfrxMemoView(frxBanco.FindObject('Memo71')).Text  := '';
          TfrxMemoView(frxBanco.FindObject('Memo132')).Text := '';
          TfrxMemoView(frxBanco.FindObject('Memo193')).Text := '';

          //INSTRUÇÕES
          TfrxMemoView(frxBanco.FindObject('Memo73')).Text := '';
          TfrxMemoView(frxBanco.FindObject('Memo74')).Text := '';
          TfrxMemoView(frxBanco.FindObject('Memo75')).Text := '';

          frxBanco.Script.Variables['NOSNUM'] := strCaAgNs;
          frxBanco.Script.Variables['CARNOSNUM'] := strCaAgNs;

          frxBanco.Script.Variables['INST01'] := IIF(fltVlrMor > 0,'MORA DIARIA DE ' + FormatFloat('R$ #,##0.00', fltVlrMor),'') +
                                                 IIF(fltVlrMul > 0,'        APÓS O VENCIMENTO COBRAR MULTA DE ' + FormatFloat('R$ #,##0.00', fltVlrMul),'');
          frxBanco.Script.Variables['INST02'] := IIF(fltVlrMor > 0,'NAO RECEBER O PRINCIPAL SEM JUROS DE MORA','');

          If (StrToIntDef(strPraPro,0) >= 1) And (LeftStr(strCdIns1, 2) <> '07') Then
            frxBanco.Script.Variables['INST03'] := 'PROTESTAR APÓS ' + strPraPro + IIF(StrToInt(strPraPro) = 1,' DIA ', ' DIAS ') + 'DO VENCIMENTO'
          Else If (StrToIntDef(strPraPro,0) >= 1) And (LeftStr(strCdIns1, 2) = '07') Then
            frxBanco.Script.Variables['INST03'] := 'SUJEITO A NEGATIVAÇÃO APÓS ' + strPraPro + IIF(StrToInt(strPraPro) = 1,' DIA ', ' DIAS ') + ' DO VENCIMENTO'
          Else If (StrToIntDef(ADiasCartorio,0) >= 1) And (strIdeBan = '996') then
            frxBanco.Script.Variables['INST03'] := 'PRAZO PARA CARTÓRIO ' + ADiasCartorio + IIF(StrToInt(ADiasCartorio) = 1,' DIA CORRIDO', ' DIAS CORRIDOS') + ' APÓS VENCIMENTO'
          Else
            frxBanco.Script.Variables['INST03'] := '';

          frxBanco.Script.Variables['INST04'] := strInstr1;
          frxBanco.Script.Variables['INST05'] := strInstr2;
          frxBanco.Script.Variables['INST06'] := strInstr3;
          frxBanco.Script.Variables['INST07'] := strInstr4;
          frxBanco.Script.Variables['INST08'] := strInstr5;

          frxBanco.Script.Variables['OUTACR'] := IIF(fltOutAcr > 0, 'R$ ' + FloatToStrF(fltOutAcr, ffNumber, 12, 2), '');

          If Length(Trim(strNuInSa)) > 11 Then
            frxBanco.Script.Variables['INSSAC'] := fMaskCNPJ(strNuInSa)
          Else frxBanco.Script.Variables['INSSAC'] := fMaskCPF(strNuInSa);

          frxBanco.Script.Variables['ENDSAC'] := strEndSac + ' - ' + strBaiSac;
          frxBanco.Script.Variables['CIDSAC'] := fMaskCEP(strCep001) + ' - ' + strCidSac + ' - ' + strEstSac;
          frxBanco.Script.Variables['LINDIG'] := strLinDig;
          TfrxBarCodeView(frxBanco.FindObject('barCodigo')).Text := strCodBar;

          TfrxBand(frxBanco.FindObject('rlbCompEntr')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrCut')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrN1')).Visible := Not (blnProEnt Or blnImpAgrup);
          TfrxBand(frxBanco.FindObject('rlbCompEntrN2')).Visible := Not (blnProEnt Or blnImpAgrup);

          If blnProEnt Then
            TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Height := TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Height + 18;
        End;

      Except
        On E: Exception Do
        Begin
          MessageDlg(E.Message,mtError,[mbOK],0);
          Result := False;
        End;
      End;

    End;

    LExecutarImpCodBar := False;
  End

  Else If strIdeBan = '021' Then  // Banestes
  Begin
    Result     := fGeLiDi021;

    If Result Then
    Begin

      If Not FileExists(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoBanestes.bmp') Then
      Begin
        FreeAndNil(qryCfgRel);
        Result := False;
        pMensagemOk('O logo ' + ExtractFilePath(Application.ExeName) + 'LogoBoletos\LogoBanestes.bmp deve existir na pasta indicada.');
        Exit;
      End;

      Try
        pCriarFormularios(TfrmQckBancos, frmQckBancos);

        pCarregarLayImp(frmQckBancos);

        With frmQckBancos Do
        Begin
          frxPDFExport.ShowDialog   := Not blnEnvioDeEmailAutomatico;
          frxPDFExport.ShowProgress := Not blnEnvioDeEmailAutomatico;

          If strEspeci = 'AG' Then
            frxAgrupamento.DataSet := fQryAgrupamento(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, strCodCli)
          Else
            frxAgrupamento.DataSet := fCriaQuery;

          blnImpAgrup := (Not frxAgrupamento.DataSet.IsEmpty) And (fCfgSis('MDBLAG', varInteger) = 2);
          If blnImpAgrup Then
          Begin
            TfrxBand(frxBanco.FindObject('rlbAgrupamento')).Visible := True;
            TfrxBand(frxBanco.FindObject('rlbReciboSac')).Visible := False;
            TfrxBand(frxBanco.FindObject('rlbReciboSacCut')).Visible := False;
            If (Not fEmptyStr(fCfgSis('IMGBOL'))) and FileExists(fCfgSis('IMGBOL')) Then
              TfrxPictureView(frxBanco.FindObject('imgLogo')).Picture.LoadFromFile(fCfgSis('IMGBOL'));

            frxBanco.Script.Variables['NUMPARC'] := fRetNumParcela(RightStr(strNumDoc, 1));
            frxBanco.Script.Variables['TOTPARC'] := fQtdParcelas(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, 'AG', strCodCli);
            frxBanco.Script.Variables['MAILCLI'] := strMailCli;
          End;

          TfrxBand(frxBanco.FindObject('rlbCompEntr')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrCut')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrN1')).Visible := Not (blnProEnt Or blnImpAgrup);
          TfrxBand(frxBanco.FindObject('rlbCompEntrN2')).Visible := Not (blnProEnt Or blnImpAgrup);

          {********************************************************}
          {* LAYOUT DE BOLETO EM DUAS VIAS (FICHA DE COMPENSAÇÃO E*}
          {* RECIBO DO PAGADOR                                    *}
          {*****************************************************GD*}
          If fCfgSis('NOVLAY', varString) = 'D' Then
          Begin
            TfrxBand(frxBanco.FindObject('rlbFichaCaixa')).Visible    := False;
            TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Visible := False;
            if not blnImpAgrup  then
              TfrxBand(frxBanco.FindObject('rlbCompEntrN1')).Visible    := False;

            If (Not fEmptyStr(fCfgSis('IMGBOL'))) Then //And FileExists(fCfgSis('IMGBOL')) Then
            Begin
              TfrxBand(frxBanco.FindObject('rlbReciboPagadorComImagem')).Visible := True;
              TfrxBand(frxBanco.FindObject('rlbReciboSac')).Visible := False;
              TfrxPictureView(frxBanco.FindObject('imgLogo2')).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoBanestes.bmp');
              TfrxPictureView(frxBanco.FindObject('imgLogoEmpresa')).Picture.LoadFromFile(fCfgSis('IMGBOL'));
            End;
          End;

          For intCont := 1 To 4 Do
            TfrxPictureView(frxBanco.FindObject('imgLog' + IntToStr(intCont))).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoBanestes.bmp');

          frxBanco.Script.Variables['CODBCO'] := '021-3';

          frxBanco.FindObject('rlbTelSac').Visible := False;
          frxBanco.FindObject('rllTelSac').Visible := False;

          If Trim(strNumIns) <> '' Then
          Begin
            If strTipIns = '01' Then
              frxBanco.Script.Variables['NOMCED'] := strNomCed + '   ' + fMaskCNPJ(strNumIns)
            Else
              frxBanco.Script.Variables['NOMCED'] := strNomCed + '   ' + fMaskCPF(strNumIns);
          End
          Else
            frxBanco.Script.Variables['NOMCED'] := strNomCed;

          frxBanco.Script.Variables['ENDCED'] := strEndere;
          frxBanco.Script.Variables['ENDAVA'] := '';
          frxBanco.Script.Variables['USOBCO'] := '';

          strAgeDig := strNumAge + '/' + strCodCed;

          frxBanco.Script.Variables['BENEFI'] := 'Beneficiário';
          frxBanco.Script.Variables['BENEFI2']:= 'BENEFICIÁRIO';
          frxBanco.Script.Variables['ESPMOE'] := 'Esp. Moeda';
          frxBanco.Script.Variables['VALMOE'] := 'Valor da Moeda';
          frxBanco.Script.Variables['PAGADO'] := 'Pagador';
          frxBanco.Script.Variables['AGECED'] := strAgeDig;
          frxBanco.Script.Variables['NOMSAC'] := strNomSac;
          frxBanco.Script.Variables['DTAVEN'] := FormatDateTime('dd/mm/yyyy', dtaDtaVen);
          frxBanco.Script.Variables['NUMDOC'] := IfThen(strImprimirParcela = 'S', strNumDoc, LeftStr(strNumDoc, Length(strNumDoc) - 1));
          frxBanco.Script.Variables['VALDOC'] := FormatFloat('R$ #,##0.00',fStrToFloat(strVlrTit)/100);
          frxBanco.Script.Variables['LOCEXT'] := '';
          frxBanco.Script.Variables['LOCPAG'] := 'PAGÁVEL PREFERENCIALMENTE NA REDE BANESTES.';
          frxBanco.Script.Variables['DTADOC'] := FormatDateTime('dd/mm/yyyy', dtaDtaEmi);
          frxBanco.Script.Variables['ESPDOC'] := strEspDoc;
          frxBanco.Script.Variables['DTAPRO'] := FormatDateTime('dd/mm/yyyy', dtaDtaPro);

          if (strCodCar = '1') or (strCodCar = '3') then
            frxBanco.Script.Variables['CARTEI'] := '1' + strCodCar
          else
            frxBanco.Script.Variables['CARTEI'] := strCodCar;

          frxBanco.Script.Variables['CART02'] := '';
          frxBanco.Script.Variables['ACEITE'] := IIF(strIdeAce = 'S', 'Sim', 'Não');
          frxBanco.Script.Variables['CEDENT'] := 'Cód. Beneficiário';
          frxBanco.Script.Variables['SACAVA'] := '';

          strCaAgNs := strNosNum;

          Insert('-', strCaAgNs, 9);

          TfrxMemoView(frxBanco.FindObject('rllCarNN1')).Text := 'Carteira/Nosso Número';

          TfrxMemoView(frxBanco.FindObject('rllNN1')).Text := 'Carteira/Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN2')).Text := 'Carteira/Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN3')).Text := 'Carteira/Nosso Número';

          TfrxMemoView(frxBanco.FindObject('rllLinDig')).Visible := False;

          TfrxMemoView(frxBanco.FindObject('Memo71')).Text  := '';
          TfrxMemoView(frxBanco.FindObject('Memo132')).Text := '';
          TfrxMemoView(frxBanco.FindObject('Memo193')).Text := '';

          frxBanco.Script.Variables['NOSNUM'] := strCaAgNs;
          frxBanco.Script.Variables['CARNOSNUM'] := strCaAgNs;

          frxBanco.Script.Variables['INST01'] := IIF(fltVlrMor > 0,'MORA DIARIA DE ' + FormatFloat('R$ #,##0.00', fltVlrMor),'');
          frxBanco.Script.Variables['INST02'] := IIF(fltVlrMor > 0,'NAO RECEBER O PRINCIPAL SEM JUROS DE MORA','');

          If StrToIntDef(strPraPro,0) >= 1 Then
            frxBanco.Script.Variables['INST03'] := 'PROTESTAR APOS ' + strPraPro + IIF(StrToInt(strPraPro) = 1,' DIA ', ' DIAS ') + 'DO VENCIMENTO'
          Else frxBanco.Script.Variables['INST03'] := '';

          frxBanco.Script.Variables['INST04'] := strInstr1;
          frxBanco.Script.Variables['INST05'] := strInstr2;
          frxBanco.Script.Variables['INST06'] := strInstr3;
          frxBanco.Script.Variables['INST07'] := strInstr4;
          frxBanco.Script.Variables['INST08'] := strInstr5;
          frxBanco.Script.Variables['OUTACR'] := IIF(fltOutAcr > 0, 'R$ ' + FloatToStrF(fltOutAcr, ffNumber, 12, 2), '');

          If Length(Trim(strNuInSa)) > 11 Then
            frxBanco.Script.Variables['INSSAC'] := fMaskCNPJ(strNuInSa)
          Else frxBanco.Script.Variables['INSSAC'] := fMaskCPF(strNuInSa);

          frxBanco.Script.Variables['ENDSAC'] := strEndSac + ' - ' + strBaiSac;
          frxBanco.Script.Variables['CIDSAC'] := fMaskCEP(strCep001) + ' - ' + strCidSac + ' - ' + strEstSac;
          frxBanco.Script.Variables['LINDIG'] := strLinDig;
          TfrxBarCodeView(frxBanco.FindObject('barCodigo')).Text := strCodBar;

          If blnProEnt Then
            TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Height := TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Height + 18;
        End;

      Except
        On E: Exception Do
        Begin
          MessageDlg(E.Message,mtError,[mbOK],0);
          Result := False;
        End;
      End;

    End;

    LExecutarImpCodBar := False;
  End

  Else If (strIdeBan = '104') And (Length(strCodCed) <> 7) Then
  Begin
    Result     := fGeLiDi104;

    If Result Then
    Begin
      If Not FileExists(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoCaixa.bmp') Then
      Begin
        FreeAndNil(qryCfgRel);
        Result := False;
        pMensagemOk('O logo ' + ExtractFilePath(Application.ExeName) + 'LogoBoletos\LogoCaixa.bmp deve existir na pasta indicada.');
        Exit;
      End;

      Try
        pCriarFormularios(TfrmQckBancos, frmQckBancos);

        pCarregarLayImp(frmQckBancos);

        With frmQckBancos Do
        Begin

          If ( blnBolEnvEmail And (fCampoTabela('CLI_BOLSEN', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False) = 'S') and (blnBolPdf) And (MatchStr(fCfgSis('NOVLAY', varString), ['P','C','U'])) )
             Or
             ( (blnEnvioDeEmailAutomatico) And (fCampoTabela('CLI_BOLSEN', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False) = 'S') and (blnBolPdf) And (fCfgSis('NOVLAY', varString) = 'P') ) then
          begin
            CpfCnpj := fCampoTabela('CLI_C_G_C_', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False);
            CpfCnpj := Copy(CpfCnpj, 1, 5);

            if not fEmptyStr(CpfCnpj) then
            begin
              frmQckBancos.frxPDFExport.PdfA := False;
              frmQckBancos.frxPDFExport.UserPassword := AnsiString(CpfCnpj);
              frmQckBancos.frxPDFExport.OwnerPassword := AnsiString(CpfCnpj);
              frmQckBancos.frxPDFExport.ProtectionFlags := [ePrint];
            end;
          end;

          frxPDFExport.ShowDialog   := Not blnEnvioDeEmailAutomatico;
          frxPDFExport.ShowProgress := Not blnEnvioDeEmailAutomatico;

          If strEspeci = 'AG' Then
            frxAgrupamento.DataSet := fQryAgrupamento(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, strCodCli)
          Else
            frxAgrupamento.DataSet := fCriaQuery;

          blnImpAgrup := (Not frxAgrupamento.DataSet.IsEmpty) And (fCfgSis('MDBLAG', varInteger) = 2);
          If blnImpAgrup Then
          Begin
            TfrxBand(frxBanco.FindObject('rlbAgrupamento')).Visible   := True;
            TfrxBand(frxBanco.FindObject('rlbFichaCaixa')).Visible    := False;
            TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Visible := False;
            If (Not fEmptyStr(fCfgSis('IMGBOL'))) and FileExists(fCfgSis('IMGBOL')) Then
              TfrxPictureView(frxBanco.FindObject('imgLogo')).Picture.LoadFromFile(fCfgSis('IMGBOL'));

            frxBanco.Script.Variables['NUMPARC'] := fRetNumParcela(RightStr(strNumDoc, 1));
            frxBanco.Script.Variables['TOTPARC'] := fQtdParcelas(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, 'AG', strCodCli);
            frxBanco.Script.Variables['MAILCLI'] := strMailCli;
          End;

          For intCont := 1 To 4 Do
            TfrxPictureView(frxBanco.FindObject('imgLog' + IntToStr(intCont))).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoCaixa.bmp');

          frxBanco.Script.Variables['CODBCO'] := '104-0';

          frxBanco.FindObject('rlbTelSac').Visible := True;
          frxBanco.FindObject('rllTelSac').Visible := True;
          frxBanco.FindObject('rllLinDig').Visible := True;

          If Trim(strNumIns) <> '' Then
          Begin
            If strTipIns = '01' Then
              frxBanco.Script.Variables['NOMCED'] := strNomCed + '   ' + fMaskCNPJ(strNumIns)
            Else
              frxBanco.Script.Variables['NOMCED'] := strNomCed + '   ' + fMaskCPF(strNumIns);
          End
          Else
            frxBanco.Script.Variables['NOMCED'] := strNomCed;

          frxBanco.Script.Variables['ENDCED'] := strEndere;
          frxBanco.Script.Variables['ENDAVA'] := '';
          frxBanco.Script.Variables['SACAVA'] := '';
          frxBanco.Script.Variables['USOBAN'] := '';
          frxBanco.Script.Variables['ACEITE'] := IIF(strIdeAce = 'S', 'A', 'N');
          frxBanco.Script.Variables['USOBCO'] := '';

          strAgeDig := strNumAge + strDigAge + strCodCed;

          //* SISTEMA DE COBRANÇA SICOB *//
          If (Pos(strCodCar, '_11_12_14_41') >= 1)                 And
             (fEmptyStr(Trim(strSisCob)) Or (strSisCob = 'SICOB')) Then
          Begin
            strAgeDig := strNumAge + LeftStr(strCodCed, 12);
            Insert('.',strAgeDig, 5);
            Insert('.',strAgeDig, 9);
            Insert('-',strAgeDig, 18);
          End

          // SISTEMA DE COBRANÇA SIGCB
          Else If (Pos(strCodCar, '_14_24') > 0)                        And
                  (fEmptyStr(Trim(strSisCob)) Or (strSisCob = 'SIGCB')) Then
          Begin
            strAgeDig := strNumAge + LeftStr(strCodCed, 6);
            Insert('/',strAgeDig, 5);
            strAgeDig := strAgeDig + '-' + strDigCed;
          End

          //* SISTEMA DE COBRANÇA SINCO nn16p *//
          Else If (Pos(strCodCar, '_08') >= 1)                            And
                  ((fEmptyStr(Trim(strSisCob))) Or (strSisCob = 'SINCO')) Then
          Begin

            strAgeDig := strNumAge + LeftStr(strCodCed, 12);
            Insert('.',strAgeDig, 5);
            Insert('.',strAgeDig, 9);
            Insert('-',strAgeDig, 18);

          End

          //* SISTEMA DE COBRANÇA SINCO *//
          Else If (StrToInt(Trim(strCodCar)) = 01)                        And
                  ((fEmptyStr(Trim(strSisCob))) Or (strSisCob = 'SINCO')) Then
          Begin

            strAgeDig := strNumAge + LeftStr(strCodCed, 6);
            Insert('.',strAgeDig, 5);

          End;

          frxBanco.Script.Variables['BENEFI'] := 'Beneficiário';
          frxBanco.Script.Variables['BENEFI2']:= 'BENEFICIÁRIO';
          frxBanco.Script.Variables['ESPMOE'] := 'Esp. Moeda';
          TfrxMemoView(frxBanco.FindObject('MemQtd1')).Text := 'Qtde. Moeda';
          TfrxMemoView(frxBanco.FindObject('MemQtd2')).Text := 'Qtde. Moeda';
          TfrxMemoView(frxBanco.FindObject('MemQtd3')).Text := 'Qtde. Moeda';
          frxBanco.Script.Variables['VALMOE'] := 'Valor';
          frxBanco.Script.Variables['PAGADO'] := 'Pagador';
          frxBanco.Script.Variables['AGECED'] := strAgeDig;
          frxBanco.Script.Variables['NOMSAC'] := strNomSac;
          frxBanco.Script.Variables['DTAVEN'] := FormatDateTime('dd/mm/yyyy', dtaDtaVen);
          frxBanco.Script.Variables['NUMDOC'] := RightStr(IfThen(strImprimirParcela = 'S', strNumDoc, LeftStr(strNumDoc, Length(strNumDoc) - 1)), 11);
          frxBanco.Script.Variables['VALDOC'] := FormatFloat('R$ #,##0.00',fStrToFloat(strVlrTit)/100);
          frxBanco.Script.Variables['LOCEXT'] := '';
          frxBanco.Script.Variables['LOCPAG'] := 'PREFERENCIALMENTE NAS CASAS LOTÉRICAS ATÉ O VALOR LIMITE.';
          frxBanco.Script.Variables['DTADOC'] := FormatDateTime('dd/mm/yyyy', dtaDtaEmi);
          frxBanco.Script.Variables['ESPDOC'] := 'DM';
          frxBanco.Script.Variables['DTAPRO'] := FormatDateTime('dd/mm/yyyy', dtaDtaPro);
          frxBanco.Script.Variables['CEDENT'] := 'Cód. Beneficiário';
          frxBanco.Script.Variables['SACAVA'] := '';

          If (fEmptyStr(Trim(strSisCob))) Or
             (strSisCob = 'SICOB')        Or
             (strSisCob = 'SINCO')        Then
          Begin
            If strCodCar = '11' Then
              frxBanco.Script.Variables['CARTEI'] := 'CS'
            Else If strCodCar = '12' Then
              frxBanco.Script.Variables['CARTEI'] := 'CR'
            Else If (strCodCar = '14') Or (strCodCar = '24') Then
              frxBanco.Script.Variables['CARTEI'] := 'SR'
            Else If strCodCar = '41' Then
              frxBanco.Script.Variables['CARTEI'] := 'DE'
            Else
            If ((strCodCar = '1') Or (strCodCar = '01')) Then
              frxBanco.Script.Variables['CARTEI'] := 'RG'
            Else
              frxBanco.Script.Variables['CARTEI'] := strCodCar;
          End
          Else If strSisCob = 'SIGCB' Then
            frxBanco.Script.Variables['CARTEI'] := IIF(strCodCar = '14', 'RG', 'SR')
          Else
            frxBanco.Script.Variables['CARTEI'] := strCodCar;

          frxBanco.Script.Variables['CART02'] := '';

          strCaAgNs := strNosNum;

          If (fEmptyStr(Trim(strSisCob))) Or
             (strSisCob = 'SICOB')        Or
             (strSisCob = 'SINCO')        Then
          Begin
            If Pos(strCodCar, '_11_12_14_41') > 0 Then
            Begin
              Insert('-',strCaAgNs, 11);
            End

            // SISTEMA DE COBRANÇA SIGCB
            Else If Pos(strCodCar, '_24') > 0 Then
            Begin
              strCaAgNs := '24' + strCaAgNs;
              Insert('-',strCaAgNs, 18);
            End

            //* SISTEMA DE COBRANÇA SINCO nn16p*//
            Else If Pos(strCodCar, '_08') > 0 Then
            Begin
              strCaAgNs := '8' + fStrZero(strCaAgNs,15);
              Insert('-',strCaAgNs, 16);
            End

            //* SISTEMA DE COBRANÇA SINCO *//
            Else If StrToInt(Trim(strCodCar)) = 01 Then
            Begin
              strCaAgNs := '9000000' + strCaAgNs;
              Insert('.',strCaAgNs, 19);
            End;
          End
          Else
          Begin
            // SISTEMA DE COBRANÇA SIGCB COBRANÇA SIMPLES

            // SISTEMA DE COBRANÇA SIGCB
            If Pos(strCodCar, '_24') > 0 Then
            Begin
              strCaAgNs := '24' + strCaAgNs;
              Insert('-',strCaAgNs, 18);
            End
            Else
            Begin
              strCaAgNs := '14/' + strCaAgNs;
              Insert('-',strCaAgNs, 19);
            End;
          End;

          TfrxMemoView(frxBanco.FindObject('rllCarNN1')).Text := 'Nosso Número';

          TfrxMemoView(frxBanco.FindObject('rllNN1')).Text := 'Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN2')).Text := 'Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN3')).Text := 'Nosso Número';

          frxBanco.Script.Variables['NOSNUM'] := strCaAgNs;
          frxBanco.Script.Variables['CARNOSNUM'] := strCaAgNs;

          frxBanco.Script.Variables['INST01'] := IIF(fltVlrMor > 0,'MORA DIARIA DE ' + FormatFloat('R$ #,##0.00', fltVlrMor) + '. ','') +
                                                 IIF(fltVlrMor > 0,' NAO RECEBER O PRINCIPAL SEM JUROS DE MORA. ','') +
                                                 IIF(fltVlrMul > 0,' APÓS O VENCIMENTO COBRAR MULTA DE ' + FormatFloat('R$ #,##0.00', fltVlrMul),'');

          If StrToIntDef(strPraPro,0) >= 1 Then
            frxBanco.Script.Variables['INST02'] := 'PROTESTAR APOS ' + strPraPro + IIF(StrToInt(strPraPro) = 1,' DIA ', ' DIAS ') + 'DO VENCIMENTO'
          Else frxBanco.Script.Variables['INST02'] := '';

          frxBanco.Script.Variables['INST03'] := strInstr1;
          frxBanco.Script.Variables['INST04'] := strInstr2;
          frxBanco.Script.Variables['INST05'] := strInstr3;
          frxBanco.Script.Variables['INST06'] := strInstr4;
          frxBanco.Script.Variables['INST07'] := strInstr5;
          frxBanco.Script.Variables['INST08'] := '';
          frxBanco.Script.Variables['OUTACR'] := IIF(fltOutAcr > 0, 'R$ ' + FloatToStrF(fltOutAcr, ffNumber, 12, 2), '');

          If Length(Trim(strNuInSa)) > 11 Then
            frxBanco.Script.Variables['INSSAC'] := fMaskCNPJ(strNuInSa)
          Else frxBanco.Script.Variables['INSSAC'] := fMaskCPF(strNuInSa);

          frxBanco.Script.Variables['ENDSAC'] := strEndSac + ' - ' + strBaiSac;
          frxBanco.Script.Variables['CIDSAC'] := fMaskCEP(strCep001) + ' - ' + strCidSac + ' - ' + strEstSac;
          frxBanco.Script.Variables['LINDIG'] := strLinDig;
          TfrxBarCodeView(frxBanco.FindObject('barCodigo')).Text := strCodBar;

          TfrxBand(frxBanco.FindObject('rlbCompEntr')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrCut')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrN1')).Visible := Not (blnProEnt Or blnImpAgrup);
          TfrxBand(frxBanco.FindObject('rlbCompEntrN2')).Visible := False;

          {********************************************************}
          {* LAYOUT DE BOLETO EM DUAS VIAS (FICHA DE COMPENSAÇÃO E*}
          {* RECIBO DO PAGADOR                                    *}
          {*****************************************************GD*}
          if fCfgSis('NOVLAY', varString) = 'D' then
          begin
            TfrxBand(frxBanco.FindObject('rlbFichaCaixa')).Visible    := False;
            TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Visible := False;
            if not blnImpAgrup  then
              TfrxBand(frxBanco.FindObject('rlbCompEntrN1')).Visible := False;

            If (Not fEmptyStr(fCfgSis('IMGBOL'))) and FileExists(fCfgSis('IMGBOL')) Then
            begin
              TfrxBand(frxBanco.FindObject('rlbReciboSac')).Visible              := False;
              TfrxBand(frxBanco.FindObject('rlbReciboPagadorComImagem')).Visible := True;
              TfrxPictureView(frxBanco.FindObject('imgLogo2')).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoCaixa.bmp');
              TfrxPictureView(frxBanco.FindObject('imgLogoEmpresa')).Picture.LoadFromFile(fCfgSis('IMGBOL'));
            end;
          end;
        End;

      Except
        On E: Exception Do
        Begin
          MessageDlg(E.Message,mtError,[mbOK],0);
          Result := False;
        End;
      End;

    End;

    LExecutarImpCodBar := False;
  End

  {********************}
  {* BANCO DO NORDESTE*}
  {*REQ-95543*******MO*}
  Else If strIdeBan = '004' Then
  Begin
    Result := fGeLiDi004;

    If Result Then
    Begin
      If Not FileExists(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoNordeste.bmp') Then
      Begin
        FreeAndNil(qryCfgRel);
        pMensagemOk('O logo ' + ExtractFilePath(Application.ExeName) + 'LogoBoletos\LogoNordeste.bmp deve existir na pasta indicada.');
        Exit;
      End;

      Try
        pCriarFormularios(TfrmQckBancos, frmQckBancos);

        With frmQckBancos Do
        Begin
          frxPDFExport.ShowDialog   := Not blnEnvioDeEmailAutomatico;
          frxPDFExport.ShowProgress := Not blnEnvioDeEmailAutomatico;

          frxAgrupamento.DataSet := fQryAgrupamento(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, strCodCli);
          blnImpAgrup := (Not frxAgrupamento.DataSet.IsEmpty) And (fCfgSis('MDBLAG', varInteger) = 2);

          If blnImpAgrup Then
          Begin
            TfrxBand(frxBanco.FindObject('rlbAgrupamento')).Visible := True;
            TfrxBand(frxBanco.FindObject('rlbReciboSac')).Visible := False;
            TfrxBand(frxBanco.FindObject('rlbReciboSacCut')).Visible := False;
            If (Not fEmptyStr(fCfgSis('IMGBOL'))) and FileExists(fCfgSis('IMGBOL')) Then
              TfrxPictureView(frxBanco.FindObject('imgLogo')).Picture.LoadFromFile(fCfgSis('IMGBOL'));

            frxBanco.Script.Variables['NUMPARC'] := fRetNumParcela(RightStr(strNumDoc, 1));
            frxBanco.Script.Variables['TOTPARC'] := fQtdParcelas(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, 'AG', strCodCli);
            frxBanco.Script.Variables['MAILCLI'] := strMailCli;
          End;

          For intCont := 1 To 4 Do
            TfrxPictureView(frxBanco.FindObject('imgLog' + IntToStr(intCont))).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoNordeste.bmp');

          frxBanco.Script.Variables['CODBCO'] := '004-3';

          frxBanco.FindObject('rlbTelSac').Visible := False;
          frxBanco.FindObject('rllTelSac').Visible := False;
          frxBanco.FindObject('rllLinDig').Visible := False;

          If Trim(strNumIns) <> '' Then
          Begin
            If strTipIns = '01' Then
              frxBanco.Script.Variables['NOMCED'] := strNomCed + '   ' + fMaskCNPJ(strNumIns)
            Else
              frxBanco.Script.Variables['NOMCED'] := strNomCed + '   ' + fMaskCPF(strNumIns);
          End
          Else
            frxBanco.Script.Variables['NOMCED'] := strNomCed;

          frxBanco.Script.Variables['ENDCED'] := strEndere;
          frxBanco.Script.Variables['ENDAVA'] := '';
          frxBanco.Script.Variables['USOBCO'] := '';

          strAgeDig := strNumAge + fStrZero(RightStr(strCodCed, 7), 7)+strDigCed;
          Insert('/', strAgeDig, 5);
          Insert('-', strAgeDig, 13);

          case AnsiIndexStr(strCodCar, ['1','2','4','5','I']) of
               0: strCaAgNs := '21';
               1: strCaAgNs := '41';
               2: strCaAgNs := '21';
               3: strCaAgNs := '41';
               4: strCaAgNs := '51';
          end;

          frxBanco.Script.Variables['BENEFI'] := 'Beneficiário';
          frxBanco.Script.Variables['BENEFI2']:= 'CEDENTE';
          frxBanco.Script.Variables['ESPMOE'] := 'Esp. Moeda';
          frxBanco.Script.Variables['VALMOE'] := 'Valor da Moeda';
          frxBanco.Script.Variables['PAGADO'] := 'Pagador';
          frxBanco.Script.Variables['AGECED'] := strAgeDig;
          frxBanco.Script.Variables['NOMSAC'] := strNomSac;
          frxBanco.Script.Variables['DTAVEN'] := FormatDateTime('dd/mm/yyyy', dtaDtaVen);
          frxBanco.Script.Variables['NUMDOC'] := RightStr(strNumDoc, 10 ); //IfThen(strImprimirParcela = 'S', strNumDoc, LeftStr(strNumDoc, Length(strNumDoc) - 1));
          frxBanco.Script.Variables['VALDOC'] := FormatFloat('R$ #,##0.00',fStrToFloat(strVlrTit)/100);
          frxBanco.Script.Variables['LOCEXT'] := '';
          frxBanco.Script.Variables['LOCPAG'] := 'PAGÁVEL EM QUALQUER BANCO.';
          frxBanco.Script.Variables['DTADOC'] := FormatDateTime('dd/mm/yyyy', dtaDtaEmi);
          frxBanco.Script.Variables['ESPDOC'] := 'DM';
          frxBanco.Script.Variables['DTAPRO'] := FormatDateTime('dd/mm/yyyy', dtaDtaPro);

          frxBanco.Script.Variables['CART02'] := '';
          frxBanco.Script.Variables['CARTEI'] := strCaAgNs;
          frxBanco.Script.Variables['ACEITE'] := IIF(strIdeAce = 'S', 'S', 'N');

          frxBanco.Script.Variables['CEDENT'] := 'Cód. Cedente';
          frxBanco.Script.Variables['SACAVA'] := '';

          strTmpNN := strNosNum;
          Insert('-', strTmpNN, 8);

          TfrxMemoView(frxBanco.FindObject('rllCarNN1')).Text := 'Carteira/Nosso Número';

          TfrxMemoView(frxBanco.FindObject('MEMO73')).Text := 'INSTRUÇÕES(Todas as Informações deste bloqueto são de EXCLUSIVA responsabilidade do Beneficiário)';
          TfrxMemoView(frxBanco.FindObject('MEMO74')).Text := 'INSTRUÇÕES(Todas as Informações deste bloqueto são de EXCLUSIVA responsabilidade do Beneficiário)';
          TfrxMemoView(frxBanco.FindObject('MEMO75')).Text := 'INSTRUÇÕES(Todas as Informações deste bloqueto são de EXCLUSIVA responsabilidade do Beneficiário)';

          TfrxMemoView(frxBanco.FindObject('rllNN1')).Text := 'Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN2')).Text := 'Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN3')).Text := 'Nosso Número';
          TfrxMemoView(frxBanco.FindObject('Memo103')).Text := 'Recibo do Sacado';

          frxBanco.Script.Variables['NOSNUM'] := strTmpNN + '         ' + strCaAgNs;
          frxBanco.Script.Variables['CARNOSNUM'] := strCaAgNs + '/' +strTmpNN;

          frxBanco.Script.Variables['INST01'] := IIF(fltVlrMor > 0, 'MORA DIARIA DE ' + FormatFloat('R$ #,##0.00', fltVlrMor) + '         ', '') +
                                                 IIF(fltVlrMul > 0, 'APÓS O VENCIMENTO COBRAR MULTA DE ' + FormatFloat('R$ #,##0.00', fltVlrMul), '');

          frxBanco.Script.Variables['INST02'] := '';

          frxBanco.Script.Variables['INST03'] := strInstr1;
          frxBanco.Script.Variables['INST04'] := strInstr2;
          frxBanco.Script.Variables['INST05'] := strInstr3;
          frxBanco.Script.Variables['INST06'] := strInstr4;
          frxBanco.Script.Variables['INST07'] := strInstr5;
          frxBanco.Script.Variables['INST08'] := '';
          frxBanco.Script.Variables['OUTACR'] := '';

          If Length(Trim(strNuInSa)) > 11 Then
            frxBanco.Script.Variables['INSSAC'] := fMaskCNPJ(strNuInSa)
          Else frxBanco.Script.Variables['INSSAC'] := fMaskCPF(strNuInSa);

          frxBanco.Script.Variables['ENDSAC'] := strEndSac + ' - ' + strBaiSac;
          frxBanco.Script.Variables['CIDSAC'] := fMaskCEP(strCep001) + ' - ' + strCidSac + ' - ' + strEstSac;

          frxBanco.Script.Variables['LINDIG'] := strLinDig;
          TfrxBarCodeView(frxBanco.FindObject('barCodigo')).Text := strCodBar;

          TfrxMemoView(frxBanco.FindObject('memo42')).Font.Size := 5;
          TfrxMemoView(frxBanco.FindObject('memo105')).Font.Size := 5;
          TfrxMemoView(frxBanco.FindObject('memo166')).Font.Size := 5;

          TfrxBand(frxBanco.FindObject('rlbCompEntr')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrCut')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrN1')).Visible := Not (blnProEnt Or blnImpAgrup);
          TfrxBand(frxBanco.FindObject('rlbCompEntrN2')).Visible := Not (blnProEnt Or blnImpAgrup);

          If blnProEnt Then
            TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Height := TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Height + 18;
        End;

      Except
        On E: Exception Do
        Begin
          MessageDlg(E.Message,mtError,[mbOK],0);
          Result := False;
        End;
      End;
    End;

    LExecutarImpCodBar := False;
  End

  {CAIXA FEDERAL 240P 7 DIGITOS}
  Else If (strIdeBan = '104') And (Length(strCodCed) = 7) Then
  Begin
    Result     := fGeLiDi104D7;

    If Result Then
    Begin
      If Not FileExists(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoCaixa.bmp') Then
      Begin
        FreeAndNil(qryCfgRel);
        Result := False;
        pMensagemOk('O logo ' +  ExtractFilePath(Application.ExeName) + 'LogoBoletos\LogoCaixa.bmp deve existir na pasta indicada.');
        Exit;
      End;

      Try
        pCriarFormularios(TfrmQckBancos, frmQckBancos);

        With frmQckBancos Do
        Begin

          If ( blnBolEnvEmail And (fCampoTabela('CLI_BOLSEN', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False) = 'S') and (blnBolPdf) And (MatchStr(fCfgSis('NOVLAY', varString), ['P','C','U'])) )
             Or
             ( (blnEnvioDeEmailAutomatico) And (fCampoTabela('CLI_BOLSEN', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False) = 'S') and (blnBolPdf) And (fCfgSis('NOVLAY', varString) = 'P') ) then
          begin
            CpfCnpj := fCampoTabela('CLI_C_G_C_', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False);
            CpfCnpj := Copy(CpfCnpj, 1, 5);

            if not fEmptyStr(CpfCnpj) then
            begin
              frmQckBancos.frxPDFExport.PdfA := False;
              frmQckBancos.frxPDFExport.UserPassword := AnsiString(CpfCnpj);
              frmQckBancos.frxPDFExport.OwnerPassword := AnsiString(CpfCnpj);
              frmQckBancos.frxPDFExport.ProtectionFlags := [ePrint];
            end;
          end;

          frxPDFExport.ShowDialog   := Not blnEnvioDeEmailAutomatico;
          frxPDFExport.ShowProgress := Not blnEnvioDeEmailAutomatico;

          If strEspeci = 'AG' Then
            frxAgrupamento.DataSet := fQryAgrupamento(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, strCodCli)
          Else
            frxAgrupamento.DataSet := fCriaQuery;

          blnImpAgrup := (Not frxAgrupamento.DataSet.IsEmpty) And (fCfgSis('MDBLAG', varInteger) = 2);
          If blnImpAgrup Then
          Begin
            TfrxBand(frxBanco.FindObject('rlbAgrupamento')).Visible := True;
            TfrxBand(frxBanco.FindObject('rlbReciboSac')).Visible := False;
            TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Visible := False;
            If (Not fEmptyStr(fCfgSis('IMGBOL'))) and FileExists(fCfgSis('IMGBOL')) Then
              TfrxPictureView(frxBanco.FindObject('imgLogo')).Picture.LoadFromFile(fCfgSis('IMGBOL'));

            frxBanco.Script.Variables['NUMPARC'] := fRetNumParcela(RightStr(strNumDoc, 1));
            frxBanco.Script.Variables['TOTPARC'] := fQtdParcelas(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, 'AG', strCodCli);
            frxBanco.Script.Variables['MAILCLI'] := strMailCli;
          End;

          For intCont := 1 To 4 Do
            TfrxPictureView(frxBanco.FindObject('imgLog' + IntToStr(intCont))).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoCaixa.bmp');

          frxBanco.Script.Variables['CODBCO'] := '104-0';

          frxBanco.FindObject('rlbTelSac').Visible := True;
          frxBanco.FindObject('rllTelSac').Visible := True;
          frxBanco.FindObject('rllLinDig').Visible := True;

          If Trim(strNumIns) <> '' Then
          Begin
            If strTipIns = '01' Then
              frxBanco.Script.Variables['NOMCED'] := strNomCed + '   ' + fMaskCNPJ(strNumIns)
            Else
              frxBanco.Script.Variables['NOMCED'] := strNomCed + '   ' + fMaskCPF(strNumIns);
          End
          Else
            frxBanco.Script.Variables['NOMCED'] := strNomCed;

          frxBanco.Script.Variables['ENDCED'] := strEndere;
          frxBanco.Script.Variables['ENDAVA'] := '';
          frxBanco.Script.Variables['SACAVA'] := '';
          frxBanco.Script.Variables['USOBAN'] := '';
          frxBanco.Script.Variables['ACEITE'] := IIF(strIdeAce = 'S', 'A', 'N');
          frxBanco.Script.Variables['USOBCO'] := '';

          strAgeDig := strNumAge + strDigAge + strCodCed;

          //* SISTEMA DE COBRANÇA SICOB *//
          If (Pos(strCodCar, '_11_12_14_41') >= 1)                 And
             (fEmptyStr(Trim(strSisCob)) Or (strSisCob = 'SICOB')) Then
          Begin
            strAgeDig := strNumAge + LeftStr(strCodCed, 12);
            Insert('.',strAgeDig, 5);
            Insert('.',strAgeDig, 9);
            Insert('-',strAgeDig, 18);
          End

          // SISTEMA DE COBRANÇA SIGCB
          Else If (Pos(strCodCar, '_14_24') > 0)                        And
                  (fEmptyStr(Trim(strSisCob)) Or (strSisCob = 'SIGCB')) Then
          Begin
            strAgeDig := strNumAge + LeftStr(strCodCed, Length(strCodCed));
            Insert('/',strAgeDig, 5);
            strAgeDig := strAgeDig + '-' + strDigCed;
          End

          //* SISTEMA DE COBRANÇA SINCO nn16p *//
          Else If (Pos(strCodCar, '_08') >= 1)                            And
                  ((fEmptyStr(Trim(strSisCob))) Or (strSisCob = 'SINCO')) Then
          Begin

            strAgeDig := strNumAge + LeftStr(strCodCed, 12);
            Insert('.',strAgeDig, 5);
            Insert('.',strAgeDig, 9);
            Insert('-',strAgeDig, 18);

          End

          //* SISTEMA DE COBRANÇA SINCO *//
          Else If (StrToInt(Trim(strCodCar)) = 01)                        And
                  ((fEmptyStr(Trim(strSisCob))) Or (strSisCob = 'SINCO')) Then
          Begin

            strAgeDig := strNumAge + LeftStr(strCodCed, 6);
            Insert('.',strAgeDig, 5);

          End;

          frxBanco.Script.Variables['BENEFI'] := 'Beneficiário';
          frxBanco.Script.Variables['BENEFI2']:= 'BENEFICIÁRIO';
          frxBanco.Script.Variables['ESPMOE'] := 'Esp. Moeda';
          TfrxMemoView(frxBanco.FindObject('MemQtd1')).Text := 'Qtde. Moeda';
          TfrxMemoView(frxBanco.FindObject('MemQtd2')).Text := 'Qtde. Moeda';
          TfrxMemoView(frxBanco.FindObject('MemQtd3')).Text := 'Qtde. Moeda';

          TfrxMemoView(frxBanco.FindObject('Memo206')).Text := '(-) Desconto';
          TfrxMemoView(frxBanco.FindObject('Memo145')).Text := '(-) Desconto';
          TfrxMemoView(frxBanco.FindObject('Memo84')).Text  := '(-) Desconto';

          TfrxMemoView(frxBanco.FindObject('Memo207')).Width := 120.944881889763800000;
          TfrxMemoView(frxBanco.FindObject('Memo146')).Width := 120.944881889763800000;
          TfrxMemoView(frxBanco.FindObject('Memo85')).Width  := 120.944881889763800000;

          TfrxMemoView(frxBanco.FindObject('Memo207')).Text := '(-) Outras Deduções/Abatimento';
          TfrxMemoView(frxBanco.FindObject('Memo146')).Text := '(-) Outras Deduções/Abatimento';
          TfrxMemoView(frxBanco.FindObject('Memo85')).Text  := '(-) Outras Deduções/Abatimento';

          frxBanco.Script.Variables['VALMOE'] := 'Valor';
          frxBanco.Script.Variables['PAGADO'] := 'Pagador';
          frxBanco.Script.Variables['AGECED'] := strAgeDig;
          frxBanco.Script.Variables['NOMSAC'] := strNomSac;
          frxBanco.Script.Variables['DTAVEN'] := FormatDateTime('dd/mm/yyyy', dtaDtaVen);
          frxBanco.Script.Variables['NUMDOC'] := RightStr(IfThen(strImprimirParcela = 'S', strNumDoc, LeftStr(strNumDoc, Length(strNumDoc) - 1)), 11);
          frxBanco.Script.Variables['VALDOC'] := FormatFloat('R$ #,##0.00',fStrToFloat(strVlrTit)/100);
          frxBanco.Script.Variables['LOCEXT'] := '';
          frxBanco.Script.Variables['LOCPAG'] := 'EM TODA A REDE BANCÁRIA E SEUS CORRESPONDENTES ATÉ O VALOR LIMITE.';
          frxBanco.Script.Variables['DTADOC'] := FormatDateTime('dd/mm/yyyy', dtaDtaEmi);
          frxBanco.Script.Variables['ESPDOC'] := 'DM';
          frxBanco.Script.Variables['DTAPRO'] := FormatDateTime('dd/mm/yyyy', dtaDtaPro);
          frxBanco.Script.Variables['CEDENT'] := 'Cód. Beneficiário';
          frxBanco.Script.Variables['SACAVA'] := '';

          If (fEmptyStr(Trim(strSisCob))) Or
             (strSisCob = 'SICOB')        Or
             (strSisCob = 'SINCO')        Then
          Begin
            If strCodCar = '11' Then
              frxBanco.Script.Variables['CARTEI'] := 'CS'
            Else If strCodCar = '12' Then
              frxBanco.Script.Variables['CARTEI'] := 'CR'
            Else If (strCodCar = '14') Or (strCodCar = '24') Then
              frxBanco.Script.Variables['CARTEI'] := 'SR'
            Else If strCodCar = '41' Then
              frxBanco.Script.Variables['CARTEI'] := 'DE'
            Else
            If ((strCodCar = '1') Or (strCodCar = '01')) Then
              frxBanco.Script.Variables['CARTEI'] := 'RG'
            Else
              frxBanco.Script.Variables['CARTEI'] := strCodCar;
          End
          Else If strSisCob = 'SIGCB' Then
            frxBanco.Script.Variables['CARTEI'] := IIF(strCodCar = '14', 'RG', 'SR')
          Else
            frxBanco.Script.Variables['CARTEI'] := strCodCar;

          frxBanco.Script.Variables['CART02'] := '';

          strCaAgNs := strNosNum;

          If (fEmptyStr(Trim(strSisCob))) Or
             (strSisCob = 'SICOB')        Or
             (strSisCob = 'SINCO')        Then
          Begin
            If Pos(strCodCar, '_11_12_14_41') > 0 Then
            Begin
              Insert('-',strCaAgNs, 11);
            End

            // SISTEMA DE COBRANÇA SIGCB
            Else If Pos(strCodCar, '_24') > 0 Then
            Begin
              strCaAgNs := '24' + strCaAgNs;
              Insert('-',strCaAgNs, 18);
            End

            //* SISTEMA DE COBRANÇA SINCO nn16p*//
            Else If Pos(strCodCar, '_08') > 0 Then
            Begin
              strCaAgNs := '8' + fStrZero(strCaAgNs,15);
              Insert('-',strCaAgNs, 16);
            End

            //* SISTEMA DE COBRANÇA SINCO *//
            Else If StrToInt(Trim(strCodCar)) = 01 Then
            Begin
              strCaAgNs := '9000000' + strCaAgNs;
              Insert('.',strCaAgNs, 19);
            End;
          End
          Else
          Begin
            // SISTEMA DE COBRANÇA SIGCB COBRANÇA SIMPLES

            // SISTEMA DE COBRANÇA SIGCB
            If Pos(strCodCar, '_24') > 0 Then
            Begin
              strCaAgNs := '24' + strCaAgNs;
              Insert('-',strCaAgNs, 18);
            End
            Else
            Begin
              strCaAgNs := '14/' + strCaAgNs;
              Insert('-',strCaAgNs, 19);
            End;
          End;

          TfrxMemoView(frxBanco.FindObject('rllCarNN1')).Text := 'Nosso Número';

          TfrxMemoView(frxBanco.FindObject('rllNN1')).Text := 'Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN2')).Text := 'Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN3')).Text := 'Nosso Número';

          frxBanco.Script.Variables['NOSNUM'] := strCaAgNs;
          frxBanco.Script.Variables['CARNOSNUM'] := strCaAgNs;

          frxBanco.Script.Variables['INST01'] := IIF(fltVlrMor > 0,'MORA DIARIA DE ' + FormatFloat('R$ #,##0.00', fltVlrMor) + '. ','') +
                                                 IIF(fltVlrMor > 0,' NAO RECEBER O PRINCIPAL SEM JUROS DE MORA. ','') +
                                                 IIF(fltVlrMul > 0,' APÓS O VENCIMENTO COBRAR MULTA DE ' + FormatFloat('R$ #,##0.00', fltVlrMul),'');

          If StrToIntDef(strPraPro,0) >= 1 Then
            frxBanco.Script.Variables['INST02'] := 'PROTESTAR APOS ' + strPraPro + IIF(StrToInt(strPraPro) = 1,' DIA ', ' DIAS ') + 'DO VENCIMENTO'
          Else frxBanco.Script.Variables['INST02'] := '';

          frxBanco.Script.Variables['INST03'] := strInstr1;
          frxBanco.Script.Variables['INST04'] := strInstr2;
          frxBanco.Script.Variables['INST05'] := strInstr3;
          frxBanco.Script.Variables['INST06'] := strInstr4;
          frxBanco.Script.Variables['INST07'] := strInstr5;
          frxBanco.Script.Variables['INST08'] := '';
          frxBanco.Script.Variables['OUTACR'] := IIF(fltOutAcr > 0, 'R$ ' + FloatToStrF(fltOutAcr, ffNumber, 12, 2), '');

          If Length(Trim(strNuInSa)) > 11 Then
            frxBanco.Script.Variables['INSSAC'] := fMaskCNPJ(strNuInSa)
          Else frxBanco.Script.Variables['INSSAC'] := fMaskCPF(strNuInSa);

          frxBanco.Script.Variables['ENDSAC'] := strEndSac + ' - ' + strBaiSac;
          frxBanco.Script.Variables['CIDSAC'] := fMaskCEP(strCep001) + ' - ' + strCidSac + ' - ' + strEstSac;
          frxBanco.Script.Variables['LINDIG'] := strLinDig;
          TfrxBarCodeView(frxBanco.FindObject('barCodigo')).Text := strCodBar;

          TfrxBand(frxBanco.FindObject('rlbCompEntr')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrCut')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrN1')).Visible := Not (blnProEnt Or blnImpAgrup);
          TfrxBand(frxBanco.FindObject('rlbCompEntrN2')).Visible := False;
        End;

      Except
        On E: Exception Do
        Begin
          MessageDlg(E.Message,mtError,[mbOK],0);
          Result := False;
        End;
      End;

    End;

    LExecutarImpCodBar := False;
  End

  Else If strIdeBan.Equals('756') And (Not Assigned(TRetornoBoletoSicoob(LRetornoRegistroBoletoApi))) Then
  Begin
    Result     := fGeLiDi756;

    If Result Then
    Begin

      If Not FileExists(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoBancoob.bmp') Then
      Begin
        FreeAndNil(qryCfgRel);
        Result := False;
        pMensagemOk('O logo ' + ExtractFilePath(Application.ExeName) + 'LogoBoletos\LogoBancoob.bmp deve existir na pasta indicada.');
        Exit;
      End;

      Try
        pCriarFormularios(TfrmQckBancos, frmQckBancos);

        pCarregarLayImp(frmQckBancos);

        With frmQckBancos Do
        Begin

          If ( blnBolEnvEmail And (fCampoTabela('CLI_BOLSEN', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False) = 'S') and (blnBolPdf) And (MatchStr(fCfgSis('NOVLAY', varString), ['P','C','U'])) )
             Or
             ( (blnEnvioDeEmailAutomatico) And (fCampoTabela('CLI_BOLSEN', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False) = 'S') and (blnBolPdf) And (fCfgSis('NOVLAY', varString) = 'P') ) then
          begin
            CpfCnpj := fCampoTabela('CLI_C_G_C_', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False);
            CpfCnpj := Copy(CpfCnpj, 1, 5);

            if not fEmptyStr(CpfCnpj) then
            begin
              frmQckBancos.frxPDFExport.PdfA := False;
              frmQckBancos.frxPDFExport.UserPassword := AnsiString(CpfCnpj);
              frmQckBancos.frxPDFExport.OwnerPassword := AnsiString(CpfCnpj);
              frmQckBancos.frxPDFExport.ProtectionFlags := [ePrint];
            end;
          end;

          frxPDFExport.ShowDialog   := Not blnEnvioDeEmailAutomatico;
          frxPDFExport.ShowProgress := Not blnEnvioDeEmailAutomatico;

          If strEspeci = 'AG' Then
            frxAgrupamento.DataSet := fQryAgrupamento(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, strCodCli)
          Else
            frxAgrupamento.DataSet := fCriaQuery;

          blnImpAgrup := (Not frxAgrupamento.DataSet.IsEmpty) And (fCfgSis('MDBLAG', varInteger) = 2);
          If blnImpAgrup Then
          Begin
            TfrxBand(frxBanco.FindObject('rlbAgrupamento')).Visible   := True;
            TfrxBand(frxBanco.FindObject('rlbFichaCaixa')).Visible    := False;
            TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Visible := False;
            If (Not fEmptyStr(fCfgSis('IMGBOL'))) and FileExists(fCfgSis('IMGBOL')) Then
              TfrxPictureView(frxBanco.FindObject('imgLogo')).Picture.LoadFromFile(fCfgSis('IMGBOL'));

            frxBanco.Script.Variables['NUMPARC'] := fRetNumParcela(RightStr(strNumDoc, 1));
            frxBanco.Script.Variables['TOTPARC'] := fQtdParcelas(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, 'AG', strCodCli);
            frxBanco.Script.Variables['MAILCLI'] := strMailCli;
          End;

          For intCont := 1 To 4 Do
            TfrxPictureView(frxBanco.FindObject('imgLog' + IntToStr(intCont))).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoBancoob.bmp');

          frxBanco.Script.Variables['CODBCO'] := '756-0';

          frxBanco.FindObject('rlbTelSac').Visible := False;
          frxBanco.FindObject('rllTelSac').Visible := False;
          frxBanco.FindObject('rllLinDig').Visible := False;

          If Trim(strNumIns) <> '' Then
          Begin
            If strTipIns = '01' Then
              frxBanco.Script.Variables['NOMCED'] := strNomCed + '   ' + fMaskCNPJ(strNumIns)
            Else
              frxBanco.Script.Variables['NOMCED'] := strNomCed + '   ' + fMaskCPF(strNumIns);
          End
          Else
            frxBanco.Script.Variables['NOMCED'] := strNomCed;

          frxBanco.Script.Variables['ENDCED'] := strEndere;
          frxBanco.Script.Variables['ENDAVA'] := '';
          frxBanco.Script.Variables['USOBCO'] := '';

          strCodCed := fRetiraZerosEsquerda(strCodCed);
          strAgeDig := strNumAge + strCodCed;
          Insert('/', strAgeDig, 5);
          //Insert('-', strAgeDig, 13);

          frxBanco.Script.Variables['BENEFI'] := 'Beneficiário';
          frxBanco.Script.Variables['BENEFI2']:= 'BENEFICIÁRIO';
          frxBanco.Script.Variables['ESPMOE'] := 'Esp. Moeda';
          frxBanco.Script.Variables['VALMOE'] := 'Valor da Moeda';
          frxBanco.Script.Variables['PAGADO'] := 'Pagador';
          frxBanco.Script.Variables['AGECED'] := strAgeDig;
          frxBanco.Script.Variables['NOMSAC'] := strNomSac;
          frxBanco.Script.Variables['DTAVEN'] := FormatDateTime('dd/mm/yyyy', dtaDtaVen);
          frxBanco.Script.Variables['NUMDOC'] := IfThen(strImprimirParcela = 'S', strNumDoc, LeftStr(strNumDoc, Length(strNumDoc) - 1)) +
                                                 IIF((Pos('756_240p',LIdentificacaoBanco) > 0),strEspDocOriginal,'');
          frxBanco.Script.Variables['VALDOC'] := FormatFloat('R$ #,##0.00',fStrToFloat(strVlrTit)/100);
          frxBanco.Script.Variables['LOCEXT'] := '';
          frxBanco.Script.Variables['LOCPAG'] := 'PAGÁVEL PREFERENCIALMENTE NO SICOOB.';
          frxBanco.Script.Variables['DTADOC'] := FormatDateTime('dd/mm/yyyy', dtaDtaEmi);

          if strEspeci <> '' then
          begin
            if ((Copy(strEspDoc, 1, 2) <> '25') and (Copy(strEspDoc, 1, 2) <> '99')) then
              frxBanco.Script.Variables['ESPDOC'] := Trim(Copy(strEspDoc, 6, 3))
            else
              frxBanco.Script.Variables['ESPDOC'] := 'DM';
          end
          else
            frxBanco.Script.Variables['ESPDOC'] := 'DM';

          frxBanco.Script.Variables['DTAPRO'] := FormatDateTime('dd/mm/yyyy', dtaDtaPro);
          frxBanco.Script.Variables['CARTEI'] := strCodCar;
          frxBanco.Script.Variables['CART02'] := '';
          frxBanco.Script.Variables['ACEITE'] := IIF(strIdeAce = 'S', 'Sim', 'Não');
          frxBanco.Script.Variables['CEDENT'] := 'Cód. Beneficiário';
          frxBanco.Script.Variables['SACAVA'] := '';

          strCaAgNs := strNosNum;
          Insert('-', strCaAgNs, 08);

          TfrxMemoView(frxBanco.FindObject('rllCarNN1')).Text := 'Carteira/Nosso Número';

          TfrxMemoView(frxBanco.FindObject('rllNN1')).Text := 'Carteira/Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN2')).Text := 'Carteira/Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN3')).Text := 'Carteira/Nosso Número';

          TfrxMemoView(frxBanco.FindObject('Memo71')).Text  := '';
          TfrxMemoView(frxBanco.FindObject('Memo132')).Text := '';
          TfrxMemoView(frxBanco.FindObject('Memo193')).Text := '';

          frxBanco.Script.Variables['NOSNUM'] := strCaAgNs;
          frxBanco.Script.Variables['CARNOSNUM'] := strCaAgNs;

          frxBanco.Script.Variables['INST01'] := RetornaObservacaoBancoob;

          frxBanco.Script.Variables['INST02'] := IIF(fltVlrMor > 0,'NÃO RECEBER O PRINCIPAL SEM JUROS DE MORA','');

          frxBanco.Script.Variables['INST03'] := '';
          If (Not fEmptyStr(strCodProt)) Then
          Begin
            strPraPro := IIF(strCodProt = '3', '0', strPraPro);
            If (StrToIntDef(strPraPro,0) >= 1) Then
            Begin
              If strCodProt = '1' Then
                frxBanco.Script.Variables['INST03'] := 'PROTESTAR APÓS ' + strPraPro + IIF(StrToInt(strPraPro) = 1,
                                                                                          ' DIA CORRIDO ',
                                                                                          ' DIAS CORRIDOS ') + 'DO VENCIMENTO'
              Else
                frxBanco.Script.Variables['INST03'] := 'PROTESTAR APÓS ' + strPraPro + IIF(StrToInt(strPraPro) = 1,
                                                                                          ' DIA ÚTIL ',
                                                                                          ' DIAS ÚTEIS ') + 'DO VENCIMENTO';
            End;
          End
          Else If (StrToIntDef(strPraPro,0) >= 1) Then
            frxBanco.Script.Variables['INST03'] := 'PROTESTAR APÓS ' + strPraPro + IIF(StrToInt(strPraPro) = 1,
                                                                                        ' DIA ',
                                                                                        ' DIAS ') + 'DO VENCIMENTO';

          frxBanco.Script.Variables['INST04'] := strInstr1;
          frxBanco.Script.Variables['INST05'] := strInstr2;
          frxBanco.Script.Variables['INST06'] := strInstr3;
          frxBanco.Script.Variables['INST07'] := strInstr4;
          frxBanco.Script.Variables['INST08'] := strInstr5;
          frxBanco.Script.Variables['OUTACR'] := IIF(fltOutAcr > 0, 'R$ ' + FloatToStrF(fltOutAcr, ffNumber, 12, 2), '');

          If Length(Trim(strNuInSa)) > 11 Then
            frxBanco.Script.Variables['INSSAC'] := fMaskCNPJ(strNuInSa)
          Else frxBanco.Script.Variables['INSSAC'] := fMaskCPF(strNuInSa);

          frxBanco.Script.Variables['ENDSAC'] := strEndSac + ' - ' + strBaiSac;
          frxBanco.Script.Variables['CIDSAC'] := fMaskCEP(strCep001) + ' - ' + strCidSac + ' - ' + strEstSac;
          frxBanco.Script.Variables['LINDIG'] := strLinDig;
          TfrxBarCodeView(frxBanco.FindObject('barCodigo')).Text := strCodBar;

          TfrxBand(frxBanco.FindObject('rlbCompEntr')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrCut')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrN1')).Visible := Not (blnProEnt Or blnImpAgrup);
          TfrxBand(frxBanco.FindObject('rlbCompEntrN2')).Visible := Not (blnProEnt Or blnImpAgrup);

          {********************************************************}
          {* LAYOUT DE BOLETO EM DUAS VIAS (FICHA DE COMPENSAÇÃO E*}
          {* RECIBO DO PAGADOR                                    *}
          {*****************************************************GD*}
          if fCfgSis('NOVLAY', varString) = 'D' then
          begin
            TfrxBand(frxBanco.FindObject('rlbFichaCaixa')).Visible    := False;
            TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Visible := False;
            if not blnImpAgrup  then
              TfrxBand(frxBanco.FindObject('rlbCompEntrN1')).Visible := False;

            If (Not fEmptyStr(fCfgSis('IMGBOL'))) and FileExists(fCfgSis('IMGBOL')) Then
            begin
              TfrxBand(frxBanco.FindObject('rlbReciboSac')).Visible              := False;
              TfrxBand(frxBanco.FindObject('rlbReciboPagadorComImagem')).Visible := True;
              TfrxPictureView(frxBanco.FindObject('imgLogo2')).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoBancoob.bmp');
              TfrxPictureView(frxBanco.FindObject('imgLogoEmpresa')).Picture.LoadFromFile(fCfgSis('IMGBOL'));
            end;
          end;

          If blnProEnt Then
            TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Height := TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Height + 18;
        End;

      Except
        On E: Exception Do
        Begin
          MessageDlg(E.Message,mtError,[mbOK],0);
          Result := False;
        End;
      End;

    End;

    LExecutarImpCodBar := False;
  End

  //089 - CREDISAN
  Else If strIdeBan = '089' Then
  Begin
    Result     := fGeLiDi089;

    If Result Then
    Begin

      If Not FileExists(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoCredisan.bmp') Then
      Begin
        FreeAndNil(qryCfgRel);
        Result := False;
        pMensagemOk('O logo ' + ExtractFilePath(Application.ExeName) + 'LogoBoletos\LogoCredisan.bmp deve existir na pasta indicada.');
        Exit;
      End;

      Try
        pCriarFormularios(TfrmQckBancos, frmQckBancos);

        With frmQckBancos Do
        Begin
          frxPDFExport.ShowDialog   := Not blnEnvioDeEmailAutomatico;
          frxPDFExport.ShowProgress := Not blnEnvioDeEmailAutomatico;

          If strEspeci = 'AG' Then
            frxAgrupamento.DataSet := fQryAgrupamento(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, strCodCli)
          Else
            frxAgrupamento.DataSet := fCriaQuery;

          blnImpAgrup := (Not frxAgrupamento.DataSet.IsEmpty) And (fCfgSis('MDBLAG', varInteger) = 2);
          If blnImpAgrup Then
          Begin
            TfrxBand(frxBanco.FindObject('rlbAgrupamento')).Visible := True;
            TfrxBand(frxBanco.FindObject('rlbReciboSac')).Visible := False;
            TfrxBand(frxBanco.FindObject('rlbReciboSacCut')).Visible := False;
            If (Not fEmptyStr(fCfgSis('IMGBOL'))) and FileExists(fCfgSis('IMGBOL')) Then
              TfrxPictureView(frxBanco.FindObject('imgLogo')).Picture.LoadFromFile(fCfgSis('IMGBOL'));

            frxBanco.Script.Variables['NUMPARC'] := fRetNumParcela(RightStr(strNumDoc, 1));
            frxBanco.Script.Variables['TOTPARC'] := fQtdParcelas(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, 'AG', strCodCli);
            frxBanco.Script.Variables['MAILCLI'] := strMailCli;
          End;

          For intCont := 1 To 4 Do
            TfrxPictureView(frxBanco.FindObject('imgLog' + IntToStr(intCont))).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoCredisan.bmp');

          frxBanco.Script.Variables['CODBCO'] := '089-2';

          frxBanco.FindObject('rlbTelSac').Visible := False;
          frxBanco.FindObject('rllTelSac').Visible := False;
          frxBanco.FindObject('rllLinDig').Visible := False;

          If Trim(strNumIns) <> '' Then
          Begin
            If strTipIns = '01' Then
              frxBanco.Script.Variables['NOMCED'] := strNomCed + '   ' + fMaskCNPJ(strNumIns)
            Else
              frxBanco.Script.Variables['NOMCED'] := strNomCed + '   ' + fMaskCPF(strNumIns);
          End
          Else
            frxBanco.Script.Variables['NOMCED'] := strNomCed;

          frxBanco.Script.Variables['ENDCED'] := strEndere;
          frxBanco.Script.Variables['ENDAVA'] := '';
          frxBanco.Script.Variables['USOBCO'] := '';

          strAgeDig := strNumAge + strCodCed;
          Insert('/', strAgeDig, 5);
          Insert('-', strAgeDig, 13);

          frxBanco.Script.Variables['BENEFI'] := 'Beneficiário';
          frxBanco.Script.Variables['BENEFI2']:= 'BENEFICIÁRIO';
          frxBanco.Script.Variables['ESPMOE'] := 'Esp. Moeda';
          frxBanco.Script.Variables['VALMOE'] := 'Valor da Moeda';
          frxBanco.Script.Variables['PAGADO'] := 'Pagador';
          frxBanco.Script.Variables['AGECED'] := strAgeDig;
          frxBanco.Script.Variables['NOMSAC'] := strNomSac;
          frxBanco.Script.Variables['DTAVEN'] := FormatDateTime('dd/mm/yyyy', dtaDtaVen);
          frxBanco.Script.Variables['NUMDOC'] := IfThen(strImprimirParcela = 'S', strNumDoc, LeftStr(strNumDoc, Length(strNumDoc) - 1));
          frxBanco.Script.Variables['VALDOC'] := FormatFloat('R$ #,##0.00',fStrToFloat(strVlrTit)/100);
          frxBanco.Script.Variables['LOCEXT'] := '';
          frxBanco.Script.Variables['LOCPAG'] := 'PAGÁVEL EM QUALQUER BANCO.';
          frxBanco.Script.Variables['DTADOC'] := FormatDateTime('dd/mm/yyyy', dtaDtaEmi);

          if strEspeci <> '' then
          begin
            if ((Copy(strEspDoc, 1, 2) <> '25') and (Copy(strEspDoc, 1, 2) <> '99')) then
              frxBanco.Script.Variables['ESPDOC'] := Trim(Copy(strEspDoc, 6, 3))
            else
              frxBanco.Script.Variables['ESPDOC'] := 'DM';
          end
          else
            frxBanco.Script.Variables['ESPDOC'] := 'DM';

          frxBanco.Script.Variables['DTAPRO'] := FormatDateTime('dd/mm/yyyy', dtaDtaPro);
          frxBanco.Script.Variables['CARTEI'] := strCodCar;
          frxBanco.Script.Variables['CART02'] := '';
          frxBanco.Script.Variables['ACEITE'] := IIF(strIdeAce = 'S', 'Sim', 'Não');
          frxBanco.Script.Variables['CEDENT'] := 'Cód. Beneficiário';
          frxBanco.Script.Variables['SACAVA'] := '';

          strCaAgNs := strNosNum;
          Insert('-', strCaAgNs, 08);

          TfrxMemoView(frxBanco.FindObject('rllCarNN1')).Text := 'Carteira/Nosso Número';

          TfrxMemoView(frxBanco.FindObject('rllNN1')).Text := 'Carteira/Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN2')).Text := 'Carteira/Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN3')).Text := 'Carteira/Nosso Número';

          TfrxMemoView(frxBanco.FindObject('Memo71')).Text  := '';
          TfrxMemoView(frxBanco.FindObject('Memo132')).Text := '';
          TfrxMemoView(frxBanco.FindObject('Memo193')).Text := '';

          frxBanco.Script.Variables['NOSNUM'] := strCaAgNs;
          frxBanco.Script.Variables['CARNOSNUM'] := strCaAgNs;

          frxBanco.Script.Variables['INST01'] := IIF(fltVlrMor > 0,'MORA DIARIA DE ' + FormatFloat('R$ #,##0.00', fltVlrMor),'') +
                                                 IIF(fltVlrMul > 0,'        APÓS O VENCIMENTO COBRAR MULTA DE ' + FormatFloat('R$ #,##0.00', fltVlrMul),'');
          frxBanco.Script.Variables['INST02'] := IIF(fltVlrMor > 0,'NAO RECEBER O PRINCIPAL SEM JUROS DE MORA','');

          If StrToIntDef(strPraPro,0) >= 1 Then
            frxBanco.Script.Variables['INST03'] := 'PROTESTAR APOS ' + strPraPro + IIF(StrToInt(strPraPro) = 1,' DIA ', ' DIAS ') + 'DO VENCIMENTO'
          Else frxBanco.Script.Variables['INST03'] := '';

          frxBanco.Script.Variables['INST04'] := strInstr1;
          frxBanco.Script.Variables['INST05'] := strInstr2;
          frxBanco.Script.Variables['INST06'] := strInstr3;
          frxBanco.Script.Variables['INST07'] := strInstr4;
          frxBanco.Script.Variables['INST08'] := strInstr5;
          frxBanco.Script.Variables['OUTACR'] := IIF(fltOutAcr > 0, 'R$ ' + FloatToStrF(fltOutAcr, ffNumber, 12, 2), '');

          If Length(Trim(strNuInSa)) > 11 Then
            frxBanco.Script.Variables['INSSAC'] := fMaskCNPJ(strNuInSa)
          Else frxBanco.Script.Variables['INSSAC'] := fMaskCPF(strNuInSa);

          frxBanco.Script.Variables['ENDSAC'] := strEndSac + ' - ' + strBaiSac;
          frxBanco.Script.Variables['CIDSAC'] := fMaskCEP(strCep001) + ' - ' + strCidSac + ' - ' + strEstSac;
          frxBanco.Script.Variables['LINDIG'] := strLinDig;
          TfrxBarCodeView(frxBanco.FindObject('barCodigo')).Text := strCodBar;

          TfrxBand(frxBanco.FindObject('rlbCompEntr')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrCut')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrN1')).Visible := Not (blnProEnt Or blnImpAgrup);
          TfrxBand(frxBanco.FindObject('rlbCompEntrN2')).Visible := Not (blnProEnt Or blnImpAgrup);

          If blnProEnt Then
            TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Height := TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Height + 18;
        End;

      Except
        On E: Exception Do
        Begin
          MessageDlg(E.Message,mtError,[mbOK],0);
          Result := False;
        End;
      End;

    End;

    LExecutarImpCodBar := False;
  End

  Else If strIdeBan = '070' Then
  Begin
    Result     := fGeLiDi070;

    If Result Then
    Begin

      If Not FileExists(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoBrb.bmp') Then
      Begin
        FreeAndNil(qryCfgRel);
        Result := False;
        pMensagemOk('O logo ' + ExtractFilePath(Application.ExeName) + 'LogoBoletos\LogoBrb.bmp deve existir na pasta indicada.');
        Exit;
      End;

      Try
        pCriarFormularios(TfrmQckBancos, frmQckBancos);

        With frmQckBancos Do
        Begin
          frxPDFExport.ShowDialog   := Not blnEnvioDeEmailAutomatico;
          frxPDFExport.ShowProgress := Not blnEnvioDeEmailAutomatico;

          If strEspeci = 'AG' Then
            frxAgrupamento.DataSet := fQryAgrupamento(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, strCodCli)
          Else
            frxAgrupamento.DataSet := fCriaQuery;

          blnImpAgrup := (Not frxAgrupamento.DataSet.IsEmpty) And (fCfgSis('MDBLAG', varInteger) = 2);
          If blnImpAgrup Then
          Begin
            TfrxBand(frxBanco.FindObject('rlbAgrupamento')).Visible := True;
            TfrxBand(frxBanco.FindObject('rlbReciboSac')).Visible := False;
            TfrxBand(frxBanco.FindObject('rlbReciboSacCut')).Visible := False;
            If (Not fEmptyStr(fCfgSis('IMGBOL'))) and FileExists(fCfgSis('IMGBOL')) Then
              TfrxPictureView(frxBanco.FindObject('imgLogo')).Picture.LoadFromFile(fCfgSis('IMGBOL'));

            frxBanco.Script.Variables['NUMPARC'] := fRetNumParcela(RightStr(strNumDoc, 1));
            frxBanco.Script.Variables['TOTPARC'] := fQtdParcelas(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, 'AG', strCodCli);
            frxBanco.Script.Variables['MAILCLI'] := strMailCli;
          End;

          For intCont := 1 To 4 Do
            TfrxPictureView(frxBanco.FindObject('imgLog' + IntToStr(intCont))).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoBRB.bmp');

          frxBanco.Script.Variables['CODBCO'] := '070-1';

          frxBanco.FindObject('rlbTelSac').Visible := False;
          frxBanco.FindObject('rllTelSac').Visible := False;
          frxBanco.FindObject('rllLinDig').Visible := False;

          If Trim(strNumIns) <> '' Then
          Begin
            If strTipIns = '01' Then
              frxBanco.Script.Variables['NOMCED'] := strNomCed + '   ' + fMaskCNPJ(strNumIns)
            Else
              frxBanco.Script.Variables['NOMCED'] := strNomCed + '   ' + fMaskCPF(strNumIns);
          End
          Else
            frxBanco.Script.Variables['NOMCED'] := strNomCed;

          frxBanco.Script.Variables['ENDCED'] := strEndere;
          frxBanco.Script.Variables['ENDAVA'] := '';
          frxBanco.Script.Variables['USOBCO'] := '';

          frxBanco.Script.Variables['BENEFI'] := 'Beneficiário';
          frxBanco.Script.Variables['BENEFI2']:= 'BENEFICIÁRIO';
          frxBanco.Script.Variables['ESPMOE'] := 'Esp. Moeda';
          frxBanco.Script.Variables['VALMOE'] := 'Valor da Moeda';
          frxBanco.Script.Variables['PAGADO'] := 'Pagador';

          If strImpAgBenef = 'S' Then
          Begin
            //Descrição ficará: Agência/Cód. Beneficiário
            frxBanco.Script.Variables['CEDENT'] := 'Cód. Beneficiário';
            If Copy(strCodCed, 1, 3) = '000' Then
              frxBanco.Script.Variables['AGECED'] := strNumAge + '/' + RightStr(strNumAge, 3) + RightStr(strCodCed, 7)
            Else
              frxBanco.Script.Variables['AGECED'] := strNumAge + '/' + RightStr(strNumAge, 3) + IntToStr(StrToInt64(strCodCed));
          End
          Else
          Begin
            //Descrição ficará: Cód. Beneficiário
            TfrxMemoView(frxBanco.FindObject('Memo19')).Text  := 'Cód. Beneficiário';
            TfrxMemoView(frxBanco.FindObject('Memo48')).Text  := 'Cód. Beneficiário';
            TfrxMemoView(frxBanco.FindObject('Memo110')).Text := 'Cód. Beneficiário';
            TfrxMemoView(frxBanco.FindObject('Memo171')).Text := 'Cód. Beneficiário';

            If Copy(strCodCed, 1, 3) = '000' Then
              frxBanco.Script.Variables['AGECED'] := RightStr(strNumAge, 3) + RightStr(strCodCed, 7)
            Else
              frxBanco.Script.Variables['AGECED'] := RightStr(strNumAge, 3) + IntToStr(StrToInt64(strCodCed));
          End;

          frxBanco.Script.Variables['NOMSAC'] := strNomSac;
          frxBanco.Script.Variables['DTAVEN'] := FormatDateTime('dd/mm/yyyy', dtaDtaVen);
          frxBanco.Script.Variables['NUMDOC'] := strBcoIni+strCodEmp+strConRem;
          frxBanco.Script.Variables['VALDOC'] := FormatFloat('R$ #,##0.00',fStrToFloat(strVlrTit)/100);
          frxBanco.Script.Variables['LOCEXT'] := '';
          frxBanco.Script.Variables['LOCPAG'] := 'PAGÁVEL EM QUALQUER BANCO.';
          frxBanco.Script.Variables['DTADOC'] := FormatDateTime('dd/mm/yyyy', dtaDtaEmi);

          frxBanco.Script.Variables['ESPDOC'] := 'DS';

          frxBanco.Script.Variables['DTAPRO'] := FormatDateTime('dd/mm/yyyy', dtaDtaPro);
          frxBanco.Script.Variables['CARTEI'] := 'COB';
          frxBanco.Script.Variables['CART02'] := '';
          frxBanco.Script.Variables['ACEITE'] := IIF(strIdeAce = 'S', 'Sim', 'Não');
          frxBanco.Script.Variables['SACAVA'] := '';

          strCaAgNs := strNosNum;
          TfrxMemoView(frxBanco.FindObject('rllCarNN1')).Text := 'Carteira/Nosso Número';

          TfrxMemoView(frxBanco.FindObject('rllNN1')).Text := 'Carteira/Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN2')).Text := 'Carteira/Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN3')).Text := 'Carteira/Nosso Número';

          TfrxMemoView(frxBanco.FindObject('Memo71')).Text  := '';
          TfrxMemoView(frxBanco.FindObject('Memo132')).Text := '';
          TfrxMemoView(frxBanco.FindObject('Memo193')).Text := '';

          frxBanco.Script.Variables['NOSNUM'] := strCaAgNs;
          frxBanco.Script.Variables['CARNOSNUM'] := strCaAgNs;

          if ((strCdIns1 = '02') or (strCdIns2 = '02')) then
          begin
            frxBanco.Script.Variables['INST01'] := IIF(fltVlrMor > 0,'MORA DIARIA DE ' + FormatFloat('R$ #,##0.00', fltVlrMor),'') +
                                                   IIF(fltVlrMul > 0,'        APÓS O VENCIMENTO COBRAR MULTA DE ' + FormatFloat('R$ #,##0.00', fltVlrMul),'');
            frxBanco.Script.Variables['INST02'] := IIF(fltVlrMor > 0,'NAO RECEBER O PRINCIPAL SEM JUROS DE MORA','');
          end
          else
          begin
            frxBanco.Script.Variables['INST01'] := IIF(fltPerMul > 0,'APÓS O VENCIMENTO COBRAR MULTA DE ' + FormatFloat(' #,##0.00%', fltPerMul),'') +
                                                   IIF(fltPermor > 0,' E JUROS DE '+ FormatFloat('#,##0.00%', (fltPermor*30)) + ' AO MÊS OU FRAÇÃO','');
            frxBanco.Script.Variables['INST02'] := IIF(fltPermor > 0,'NAO RECEBER O PRINCIPAL SEM JUROS DE MORA','');
          end;

          If StrToIntDef(strPraPro,0) >= 1 Then
            frxBanco.Script.Variables['INST03'] := 'PROTESTAR APÓS ' + strPraPro + IIF(StrToInt(strPraPro) = 1,' DIA ', ' DIAS ') + 'DO VENCIMENTO'
          Else frxBanco.Script.Variables['INST03'] := '';

          frxBanco.Script.Variables['INST04'] := strInstr1;
          frxBanco.Script.Variables['INST05'] := strInstr2;
          frxBanco.Script.Variables['INST06'] := strInstr3;
          frxBanco.Script.Variables['INST07'] := strInstr4;
          frxBanco.Script.Variables['INST08'] := strInstr5;
          frxBanco.Script.Variables['OUTACR'] := IIF(fltOutAcr > 0, 'R$ ' + FloatToStrF(fltOutAcr, ffNumber, 12, 2), '');

          If Length(Trim(strNuInSa)) > 11 Then
            frxBanco.Script.Variables['INSSAC'] := fMaskCNPJ(strNuInSa)
          Else frxBanco.Script.Variables['INSSAC'] := fMaskCPF(strNuInSa);

          frxBanco.Script.Variables['ENDSAC'] := strEndSac + ' - ' + strBaiSac;
          frxBanco.Script.Variables['CIDSAC'] := fMaskCEP(strCep001) + ' - ' + strCidSac + ' - ' + strEstSac;
          frxBanco.Script.Variables['LINDIG'] := strLinDig;
          TfrxBarCodeView(frxBanco.FindObject('barCodigo')).Text := strCodBar;

          TfrxBand(frxBanco.FindObject('rlbCompEntr')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrCut')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrN1')).Visible := Not (blnProEnt Or blnImpAgrup);
          TfrxBand(frxBanco.FindObject('rlbCompEntrN2')).Visible := Not (blnProEnt Or blnImpAgrup);
        End;

      Except
        On E: Exception Do
        Begin
          MessageDlg(E.Message,mtError,[mbOK],0);
          Result := False;
        End;
      End;

    End;

    LExecutarImpCodBar := False;
  End


  {******************}
  {* IMPRESSÃO HSBC *}
  {******************}
  Else If strIdeBan = '399' Then
  Begin
    Result := fGeLiDi399;

    If Result Then
    Begin

      If Not FileExists(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoHsbc.bmp') Then
      Begin
        FreeAndNil(qryCfgRel);
        Result := False;
        pMensagemOk('O logo ' + ExtractFilePath(Application.ExeName) + 'LogoBoletos\LogoHsbc.bmp deve existir na pasta indicada.');
        Exit;
      End;

      Try
        pCriarFormularios(TfrmQckBancos, frmQckBancos);

        With frmQckBancos Do
        Begin
          frxPDFExport.ShowDialog   := Not blnEnvioDeEmailAutomatico;
          frxPDFExport.ShowProgress := Not blnEnvioDeEmailAutomatico;

          If strEspeci = 'AG' Then
            frxAgrupamento.DataSet := fQryAgrupamento(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, strCodCli)
          Else
            frxAgrupamento.DataSet := fCriaQuery;

          blnImpAgrup := (Not frxAgrupamento.DataSet.IsEmpty) And (fCfgSis('MDBLAG', varInteger) = 2);
          If blnImpAgrup Then
          Begin
            TfrxBand(frxBanco.FindObject('rlbAgrupamento')).Visible := True;
            TfrxBand(frxBanco.FindObject('rlbReciboSac')).Visible := False;
            TfrxBand(frxBanco.FindObject('rlbReciboSacCut')).Visible := False;
            If (Not fEmptyStr(fCfgSis('IMGBOL'))) and FileExists(fCfgSis('IMGBOL')) Then
              TfrxPictureView(frxBanco.FindObject('imgLogo')).Picture.LoadFromFile(fCfgSis('IMGBOL'));

            frxBanco.Script.Variables['NUMPARC'] := fRetNumParcela(RightStr(strNumDoc, 1));
            frxBanco.Script.Variables['TOTPARC'] := fQtdParcelas(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, 'AG', strCodCli);
            frxBanco.Script.Variables['MAILCLI'] := strMailCli;
          End;

          For intCont := 1 To 4 Do
            TfrxPictureView(frxBanco.FindObject('imgLog' + IntToStr(intCont))).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoHsbc.bmp');

          frxBanco.Script.Variables['CODBCO'] := '399-9';

          frxBanco.FindObject('rlbTelSac').Visible := False;
          frxBanco.FindObject('rllTelSac').Visible := False;
          frxBanco.FindObject('rllLinDig').Visible := False;

          If Trim(strNumIns) <> '' Then
          Begin
            If strTipIns = '01' Then
              frxBanco.Script.Variables['NOMCED'] := strNomCed + '   ' + fMaskCNPJ(strNumIns)
            Else
              frxBanco.Script.Variables['NOMCED'] := strNomCed + '   ' + fMaskCPF(strNumIns);
          End
          Else
            frxBanco.Script.Variables['NOMCED'] := strNomCed;

          frxBanco.Script.Variables['BENEFI'] := 'Beneficiário';
          frxBanco.Script.Variables['BENEFI2']:= 'BENEFICIÁRIO';
          frxBanco.Script.Variables['ESPMOE'] := 'Esp. Moeda';
          frxBanco.Script.Variables['VALMOE'] := 'Valor da Moeda';
          frxBanco.Script.Variables['PAGADO'] := 'Pagador';
          frxBanco.Script.Variables['ENDCED'] := strEndere;
          frxBanco.Script.Variables['AGECED'] := IIF(strModCob = 'S', strNumAge + ' ', '') + LeftStr(strCodCed, 7);
          frxBanco.Script.Variables['NOMSAC'] := strNomSac;
          frxBanco.Script.Variables['DTAVEN'] := FormatDateTime('dd/mm/yyyy', dtaDtaVen);
          frxBanco.Script.Variables['NUMDOC'] := IfThen(strImprimirParcela = 'S', strNumDoc, LeftStr(strNumDoc, Length(strNumDoc) - 1));
          frxBanco.Script.Variables['VALDOC'] := FormatFloat('R$ #,##0.00',fStrToFloat(strVlrTit)/100);
          {****************************************************}
          {* MENSAGEM ALTERADA POR SOLICITAÇÃO DE HOMOLOGADOR *}
          {* RQ:35192 **************************************BB*}
          frxBanco.Script.Variables['LOCEXT'] := '';
          frxBanco.Script.Variables['LOCPAG'] := 'PAGÁVEL EM QUALQUER BANCO.';
          frxBanco.Script.Variables['DTADOC'] := FormatDateTime('dd/mm/yyyy', dtaDtaEmi);

          If strTpIden = '4' Then
            frxBanco.Script.Variables['ESPDOC'] := ''
          Else
            frxBanco.Script.Variables['ESPDOC'] := strEspDoc;

          frxBanco.Script.Variables['DTAPRO'] := FormatDateTime('dd/mm/yyyy', dtaDtaPro);
          frxBanco.Script.Variables['CARTEI'] := IIF(strModCob = 'S', IIF(strCodCar = '00', 'CSB', 'COB'), 'CNR');
          frxBanco.Script.Variables['CART02'] := '';

          If strTpIden = '4' Then
            frxBanco.Script.Variables['ACEITE'] := ''
          Else
            frxBanco.Script.Variables['ACEITE'] := IIF(strIdeAce = 'S', 'Sim', 'Não');

          frxBanco.Script.Variables['CEDENT'] := 'Cód. Beneficiário';
          frxBanco.Script.Variables['SACAVA'] := '';
          frxBanco.Script.Variables['ENDAVA'] := '';
          frxBanco.Script.Variables['USOBCO'] := '';

          TfrxMemoView(frxBanco.FindObject('rllCarNN1')).Text := 'Carteira/Nosso Número';

          TfrxMemoView(frxBanco.FindObject('rllNN1')).Text := 'Carteira/Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN2')).Text := 'Carteira/Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN3')).Text := 'Carteira/Nosso Número';

          If strModCob = 'S' Then
          Begin
            frxBanco.Script.Variables['NOSNUM'] := LeftStr(strNosNum, 10) + '.' + RightStr(strNosNum, 1);
            frxBanco.Script.Variables['CARNOSNUM'] := LeftStr(strNosNum, 10) + '.' + RightStr(strNosNum, 1);
          End
          Else
          Begin
            frxBanco.Script.Variables['NOSNUM'] := fStrZero(LeftStr(strNosNum, 10),13) + '.' + RightStr(strNosNum, 3);
            frxBanco.Script.Variables['CARNOSNUM'] := fStrZero(LeftStr(strNosNum, 10),13) + '.' + RightStr(strNosNum, 3);
          End;

          If fltVlrMor > 0 Then
          Begin
            frxBanco.Script.Variables['INST01'] := 'MORA DIÁRIA DE ' + FormatFloat('R$ #,##0.00', fltVlrMor);
            frxBanco.Script.Variables['INST02'] := 'NÃO RECEBER O PRINCIPAL SEM JUROS DE MORA';
          End
          Else
          Begin
            frxBanco.Script.Variables['INST01'] := '';
            frxBanco.Script.Variables['INST02'] := '';
          End;

          If StrToIntDef(strPraPro,0) >= 1 Then
            frxBanco.Script.Variables['INST03'] := 'PROTESTAR APÓS ' + strPraPro + IIF(StrToInt(strPraPro) = 1,' DIA ', ' DIAS ') + 'DO VENCIMENTO'
          Else frxBanco.Script.Variables['INST03'] := '';

          frxBanco.Script.Variables['INST04'] := strInstr1;
          frxBanco.Script.Variables['INST05'] := strInstr2;
          frxBanco.Script.Variables['INST06'] := strInstr3;
          frxBanco.Script.Variables['INST07'] := strInstr4;
          frxBanco.Script.Variables['INST08'] := strInstr5;
          frxBanco.Script.Variables['OUTACR'] := '';

          If Length(Trim(strNuInSa)) > 11 Then
            frxBanco.Script.Variables['INSSAC'] := fMaskCNPJ(strNuInSa)
          Else frxBanco.Script.Variables['INSSAC'] := fMaskCPF(strNuInSa);

          frxBanco.Script.Variables['ENDSAC'] := strEndSac;
          frxBanco.Script.Variables['CIDSAC'] := strCep001 + ' - ' + strCidSac + '/' +  strEstSac;
          frxBanco.Script.Variables['LINDIG'] := strLinDig;
          TfrxBarCodeView(frxBanco.FindObject('barCodigo')).Text := strCodBar;

          TfrxBand(frxBanco.FindObject('rlbCompEntr')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrCut')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrN1')).Visible := Not (blnProEnt Or blnImpAgrup);
          TfrxBand(frxBanco.FindObject('rlbCompEntrN2')).Visible := Not (blnProEnt Or blnImpAgrup);

          If blnProEnt Then
            TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Height := TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Height + 18;
        End;

      Except
        On E: Exception Do
        Begin
          MessageDlg(E.Message,mtError,[mbOK],0);
          Result := False;
        End;
      End;

    End;

    LExecutarImpCodBar := False;
  End

  Else If strIdeBan = '041' Then
  Begin
    Result     := fGeLiDi041;

    If Result Then
    Begin

      If Not FileExists(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoBanrisul.bmp') Then
      Begin
        FreeAndNil(qryCfgRel);
        Result := False;
        pMensagemOk('O logo ' + ExtractFilePath(Application.ExeName) + 'LogoBoletos\LogoBanrisul.bmp deve existir na pasta indicada.');
        Exit;
      End;

      Try
        pCriarFormularios(TfrmQckBancos, frmQckBancos);

        pCarregarLayImp(frmQckBancos);

        With frmQckBancos Do
        Begin
          frxPDFExport.ShowDialog   := Not blnEnvioDeEmailAutomatico;
          frxPDFExport.ShowProgress := Not blnEnvioDeEmailAutomatico;

          If strEspeci = 'AG' Then
            frxAgrupamento.DataSet := fQryAgrupamento(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, strCodCli)
          Else
            frxAgrupamento.DataSet := fCriaQuery;

          blnImpAgrup := (Not frxAgrupamento.DataSet.IsEmpty) And (fCfgSis('MDBLAG', varInteger) = 2);
          If blnImpAgrup Then
          Begin
            TfrxBand(frxBanco.FindObject('rlbAgrupamento')).Visible := True;
            TfrxBand(frxBanco.FindObject('rlbReciboSac')).Visible := False;
            TfrxBand(frxBanco.FindObject('rlbReciboSacCut')).Visible := False;
            If (Not fEmptyStr(fCfgSis('IMGBOL'))) and FileExists(fCfgSis('IMGBOL')) Then
              TfrxPictureView(frxBanco.FindObject('imgLogo')).Picture.LoadFromFile(fCfgSis('IMGBOL'));

            frxBanco.Script.Variables['NUMPARC'] := fRetNumParcela(RightStr(strNumDoc, 1));
            frxBanco.Script.Variables['TOTPARC'] := fQtdParcelas(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, 'AG', strCodCli);
            frxBanco.Script.Variables['MAILCLI'] := strMailCli;
          End;

          For intCont := 1 To 4 Do
            TfrxPictureView(frxBanco.FindObject('imgLog' + IntToStr(intCont))).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoBanrisul.bmp');

          frxBanco.Script.Variables['CODBCO'] := '041-8';

          frxBanco.FindObject('rlbTelSac').Visible := False;
          frxBanco.FindObject('rllTelSac').Visible := False;
          frxBanco.FindObject('rllLinDig').Visible := False;

          If Trim(strNumIns) <> '' Then
          Begin
            If strTipIns = '01' Then
              frxBanco.Script.Variables['NOMCED'] := strNomCed + '   ' + fMaskCNPJ(strNumIns)
            Else
              frxBanco.Script.Variables['NOMCED'] := strNomCed + '   ' + fMaskCPF(strNumIns);
          End
          Else
            frxBanco.Script.Variables['NOMCED'] := strNomCed;

          frxBanco.Script.Variables['ENDCED'] := strEndere;
          frxBanco.Script.Variables['ENDAVA'] := '';
          frxBanco.Script.Variables['USOBCO'] := '';

          If (Pos('041_240p',LIdentificacaoBanco) > 0) Then
          Begin
            strAgeDig := strNumAge + strCodCed;
            Insert('/', strAgeDig, 05);
          End
          Else
          Begin
            strAgeDig := strNumAge + strDigAge + strCodCed;
            Insert('.', strAgeDig, 05);
            Insert(' ', strAgeDig, 08);
            Insert('.', strAgeDig, 15);
            Insert('.', strAgeDig, 17);
          End;

          frxBanco.Script.Variables['BENEFI'] := 'Beneficiário';
          frxBanco.Script.Variables['BENEFI2']:= 'BENEFICIÁRIO';
          frxBanco.Script.Variables['ESPMOE'] := 'Esp. Moeda';
          frxBanco.Script.Variables['VALMOE'] := 'Valor da Moeda';
          frxBanco.Script.Variables['PAGADO'] := 'Pagador';
          frxBanco.Script.Variables['AGECED'] := strAgeDig;
          frxBanco.Script.Variables['NOMSAC'] := strNomSac;
          frxBanco.Script.Variables['DTAVEN'] := FormatDateTime('dd/mm/yyyy', dtaDtaVen);
          frxBanco.Script.Variables['NUMDOC'] := IfThen(strImprimirParcela = 'S', strNumDoc, LeftStr(strNumDoc, Length(strNumDoc) - 1));
          frxBanco.Script.Variables['VALDOC'] := FormatFloat('R$ #,##0.00',fStrToFloat(strVlrTit)/100);
          frxBanco.Script.Variables['LOCEXT'] := '';
          frxBanco.Script.Variables['LOCPAG'] := 'PAGÁVEL EM QUALQUER BANCO.';
          frxBanco.Script.Variables['DTADOC'] := FormatDateTime('dd/mm/yyyy', dtaDtaEmi);
          frxBanco.Script.Variables['ESPDOC'] := strEspDoc;
          frxBanco.Script.Variables['DTAPRO'] := FormatDateTime('dd/mm/yyyy', dtaDtaPro);
          frxBanco.Script.Variables['CARTEI'] := strCodCar;
          frxBanco.Script.Variables['CART02'] := '';
          frxBanco.Script.Variables['ACEITE'] := IIF(strIdeAce = 'S', 'A', 'N');
          frxBanco.Script.Variables['CEDENT'] := 'Cód. Beneficiário';
          frxBanco.Script.Variables['SACAVA'] := '';

          strCaAgNs := strNosNum;
          Insert('.', strCaAgNs, 09);

          TfrxMemoView(frxBanco.FindObject('rllCarNN1')).Text := 'Nosso Número';

          TfrxMemoView(frxBanco.FindObject('rllNN1')).Text := 'Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN2')).Text := 'Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN3')).Text := 'Nosso Número';

          TfrxMemoView(frxBanco.FindObject('rllTelSac')).Text := ' SAC BANRISUL – 0800 646 1515 ' + #13 +
                                                                 ' OUVIDORIA BANRISUL – 0800 644 2200';

          frxBanco.FindObject('rlbTelSac').Visible := True;
          frxBanco.FindObject('rllTelSac').Visible := True;
          frxBanco.FindObject('rllLinDig').Visible := True;

          frxBanco.Script.Variables['CARNOSNUM'] := strCaAgNs;
          frxBanco.Script.Variables['NOSNUM'] := strCaAgNs;

          frxBanco.Script.Variables['INST01'] := IIF(fltVlrMor > 0, 'MORA DIARIA DE ' + FormatFloat('R$ #,##0.00', fltVlrMor) + '         ', '') +
                                                 IIF(fltVlrMul > 0, 'APÓS O VENCIMENTO COBRAR MULTA DE ' + FormatFloat('R$ #,##0.00', fltVlrMul), '');

          frxBanco.Script.Variables['INST02'] := IIF(fltVlrMor > 0,'NAO RECEBER O PRINCIPAL SEM JUROS DE MORA','');

          If StrToIntDef(strPraPro,0) >= 1 Then
          Begin
            If StrToIntDef(strPraPro,0) = 1 Then
              frxBanco.Script.Variables['INST03'] := 'PROTESTAR APOS ' + strPraPro + ' DIA DO VENCIMENTO'
            Else
              frxBanco.Script.Variables['INST03'] := 'PROTESTAR APOS ' + strPraPro + ' DIAS DO VENCIMENTO';
          End
          Else frxBanco.Script.Variables['INST03'] := '';

          frxBanco.Script.Variables['INST04'] := strInstr1;
          frxBanco.Script.Variables['INST05'] := strInstr2;
          frxBanco.Script.Variables['INST06'] := strInstr3;
          frxBanco.Script.Variables['INST07'] := strInstr4;
          frxBanco.Script.Variables['INST08'] := strInstr5;
          frxBanco.Script.Variables['OUTACR'] := '';

          If Length(Trim(strNuInSa)) > 11 Then
            frxBanco.Script.Variables['INSSAC'] := fMaskCNPJ(strNuInSa)
          Else frxBanco.Script.Variables['INSSAC'] := fMaskCPF(strNuInSa);

          frxBanco.Script.Variables['ENDSAC'] := strEndSac + ' - ' + strBaiSac;
          frxBanco.Script.Variables['CIDSAC'] := fMaskCEP(strCep001) + ' - ' + strCidSac + ' - ' + strEstSac;

          frxBanco.Script.Variables['LINDIG'] := strLinDig;

          TfrxBarCodeView(frxBanco.FindObject('barCodigo')).Text := strCodBar;

          TfrxBand(frxBanco.FindObject('rlbCompEntr')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrCut')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrN1')).Visible := Not (blnProEnt Or blnImpAgrup);
          TfrxBand(frxBanco.FindObject('rlbCompEntrN2')).Visible := Not (blnProEnt Or blnImpAgrup);

          {********************************************************}
          {* LAYOUT DE BOLETO EM DUAS VIAS (FICHA DE COMPENSAÇÃO E*}
          {* RECIBO DO PAGADOR                                    *}
          {*****************************************************GD*}
          if fCfgSis('NOVLAY', varString) = 'D' then
          begin
            TfrxBand(frxBanco.FindObject('rlbFichaCaixa')).Visible    := False;
            TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Visible := False;
            if not blnImpAgrup  then
              TfrxBand(frxBanco.FindObject('rlbCompEntrN1')).Visible := False;

            If (Not fEmptyStr(fCfgSis('IMGBOL'))) and FileExists(fCfgSis('IMGBOL')) Then
            begin
              TfrxBand(frxBanco.FindObject('rlbReciboSac')).Visible              := False;
              TfrxBand(frxBanco.FindObject('rlbReciboPagadorComImagem')).Visible := True;
              TfrxPictureView(frxBanco.FindObject('imgLogo2')).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoBanrisul.bmp');
              TfrxPictureView(frxBanco.FindObject('imgLogoEmpresa')).Picture.LoadFromFile(fCfgSis('IMGBOL'));
            end;
          end;
        End;

      Except
        On E: Exception Do
        Begin
          MessageDlg(E.Message,mtError,[mbOK],0);
          Result := False;
        End;
      End;

    End;

    LExecutarImpCodBar := False;
  End

{******************************************}
{*        BANCO DAYCOVAL [400P]           *}
{*            LAYOUT PRÓPRIO              *}
{*REQ:147378****************************MT*}
  Else If (strIdeBan = '707') Then
  Begin
    Result     := fGeLiDi707;

    If Result Then
    Begin

      If Not FileExists(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoDaycoval.bmp') Then
      Begin
        FreeAndNil(qryCfgRel);
        Result := False;
        pMensagemOk('O logo ' + ExtractFilePath(Application.ExeName) + 'LogoBoletos\LogoDaycoval.bmp deve existir na pasta indicada.');
        Exit;
      End;

      Try
        pCriarFormularios(TfrmQckBancos, frmQckBancos);

        With frmQckBancos Do
        Begin

          frxPDFExport.ShowDialog   := Not blnEnvioDeEmailAutomatico;
          frxPDFExport.ShowProgress := Not blnEnvioDeEmailAutomatico;

          If strEspeci = 'AG' Then
            frxAgrupamento.DataSet := fQryAgrupamento(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, strCodCli)
          Else
            frxAgrupamento.DataSet := fCriaQuery;

          blnImpAgrup := (Not frxAgrupamento.DataSet.IsEmpty) And (fCfgSis('MDBLAG', varInteger) = 2);
          If blnImpAgrup Then
          Begin
            TfrxBand(frxBanco.FindObject('rlbAgrupamento')).Visible := True;
            TfrxBand(frxBanco.FindObject('rlbReciboSac')).Visible := False;
            TfrxBand(frxBanco.FindObject('rlbReciboSacCut')).Visible := False;
            If (Not fEmptyStr(fCfgSis('IMGBOL'))) and FileExists(fCfgSis('IMGBOL')) Then
              TfrxPictureView(frxBanco.FindObject('imgLogo')).Picture.LoadFromFile(fCfgSis('IMGBOL'));

            frxBanco.Script.Variables['NUMPARC'] := fRetNumParcela(RightStr(strNumDoc, 1));
            frxBanco.Script.Variables['TOTPARC'] := fQtdParcelas(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, 'AG', strCodCli);
            frxBanco.Script.Variables['MAILCLI'] := strMailCli;
          End;


          For intCont := 1 To 4 Do
            TfrxPictureView(frxBanco.FindObject('imgLog' + IntToStr(intCont))).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoDaycoval.bmp');

          frxBanco.Script.Variables['CODBCO'] := '707-2';

          frxBanco.FindObject('rlbTelSac').Visible := False;
          frxBanco.FindObject('rllTelSac').Visible := False;
          frxBanco.FindObject('rllLinDig').Visible := False;

          If Trim(strNumIns) <> '' Then
          Begin
            If strTipIns = '01' Then
              frxBanco.Script.Variables['NOMCED'] := strNomCed + '   ' + fMaskCNPJ(strNumIns)
            Else
              frxBanco.Script.Variables['NOMCED'] := strNomCed + '   ' + fMaskCPF(strNumIns);
          End
          Else
            frxBanco.Script.Variables['NOMCED'] := fRetNomeEmpresa + ' - CNPJ ' + fMaskCNPJ(fRetCGCEmpresa(VS_strCodEmp));

          frxBanco.Script.Variables['ENDCED'] := strEndere;
          frxBanco.Script.Variables['ENDAVA'] := '';
          frxBanco.Script.Variables['USOBCO'] := '';

          strAgeDig := strNumAge + '-' +
                       strDigAge + '/' +
                       Copy(strCodCed, 0, Length(strCodCed)-1) + '-' +
                       Copy(strCodCed, Length(strCodCed),1);

          frxBanco.Script.Variables['BENEFI'] := 'Beneficiário';
          frxBanco.Script.Variables['ESPMOE'] := 'Esp. Moeda';
          frxBanco.Script.Variables['VALMOE'] := 'Valor da Moeda';
          frxBanco.Script.Variables['PAGADO'] := 'Pagador';
          frxBanco.Script.Variables['AGECED'] := strAgeDig;
          frxBanco.Script.Variables['NOMSAC'] := strNomSac;
          frxBanco.Script.Variables['DTAVEN'] := FormatDateTime('dd/mm/yyyy', dtaDtaVen);
          frxBanco.Script.Variables['NUMDOC'] := strNumDoc;
          frxBanco.Script.Variables['VALDOC'] := FormatFloat('R$ #,##0.00',fStrToFloat(strVlrTit)/100);
          frxBanco.Script.Variables['LOCEXT'] := '';
          frxBanco.Script.Variables['LOCPAG'] := 'PAGÁVEL EM QUALQUER AGÊNCIA BANCÁRIA, MESMO APÓS VENCIMENTO';
          frxBanco.Script.Variables['DTADOC'] := FormatDateTime('dd/mm/yyyy', dtaDtaEmi);
          frxBanco.Script.Variables['ESPDOC'] := 'DM';
          frxBanco.Script.Variables['DTAPRO'] := FormatDateTime('dd/mm/yyyy', dtaDtaPro);
          frxBanco.Script.Variables['CARTEI'] := strCodCar;
          frxBanco.Script.Variables['CART02'] := '';
          frxBanco.Script.Variables['ACEITE'] := IIF(strIdeAce = 'S', 'Sim', 'Não');
          frxBanco.Script.Variables['CEDENT'] := 'Conta Corrente';
          frxBanco.Script.Variables['SACAVA'] := '';

          strCaAgNs := strCodCar + strNosNum;
          Insert('/', strCaAgNs, 4);
          Insert('-', strCaAgNs, 13);

          TfrxMemoView(frxBanco.FindObject('rllCarNN1')).Text := 'Carteira/Nosso Número';

          TfrxMemoView(frxBanco.FindObject('rllNN1')).Text := 'Carteira/Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN2')).Text := 'Carteira/Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN3')).Text := 'Carteira/Nosso Número';

          frxBanco.Script.Variables['CARNOSNUM'] := strCaAgNs;
          frxBanco.Script.Variables['NOSNUM'] := strCaAgNs;
          fltValTit := fStrToFloat(strVlrTit)/100;
          frxBanco.Script.Variables['INST01'] := IIF(fltVlrMul > 0, 'APÓS O VENCIMENTO, COBRAR MULTA DE ' + FormatFloat('#,##0.00', (fltVlrMul / fltValTit) * 100) + '% DO VALOR DO TÍTULO.          ', '');

          IF fltVlrMor > 0 THEN
          BEGIN
            frxBanco.Script.Variables['INST02'] := 'APÓS O VENCIMENTO, COBRAR ' + FormatFloat('R$ #,##0.00', fltVlrMor) + ' POR DIA DE ATRASO,';

            If StrToIntDef(strPraPro,0) >= 1 Then
            Begin
              If StrToIntDef(strPraPro,0) = 1 Then
                frxBanco.Script.Variables['INST03'] := 'PROTESTAR APÓS ' + strPraPro + ' DIA ' + IIF(strTipDia = '1', 'ÚTIL', 'CORRIDO') + ' À CONTAR DO VENCIMENTO'
              Else
                frxBanco.Script.Variables['INST03'] := 'PROTESTAR APÓS ' + strPraPro + ' DIAS ' + IIF(strTipDia = '1', 'ÚTEIS', 'CORRIDOS') + ' À CONTAR DO VENCIMENTO';
            End
            Else frxBanco.Script.Variables['INST03'] := '';

            frxBanco.Script.Variables['INST04'] := strInstr1;
            frxBanco.Script.Variables['INST05'] := strInstr2;
            frxBanco.Script.Variables['INST06'] := strInstr3;
            frxBanco.Script.Variables['INST07'] := strInstr4;
            frxBanco.Script.Variables['INST08'] := strInstr5;
            frxBanco.Script.Variables['OUTACR'] := '';
          end
          else
          begin
            If StrToIntDef(strPraPro,0) >= 1 Then
            Begin
              If StrToIntDef(strPraPro,0) = 1 Then
                frxBanco.Script.Variables['INST02'] := 'PROTESTAR APÓS ' + strPraPro + ' DIA ' + IIF(strTipDia = '1', 'ÚTIL', 'CORRIDO') + ' À CONTAR DO VENCIMENTO'
              Else
                frxBanco.Script.Variables['INST02'] := 'PROTESTAR APÓS ' + strPraPro + ' DIAS ' + IIF(strTipDia = '1', 'ÚTEIS', 'CORRIDOS') + ' À CONTAR DO VENCIMENTO';
            End
            Else frxBanco.Script.Variables['INST02'] := '';

            frxBanco.Script.Variables['INST03'] := strInstr1;
            frxBanco.Script.Variables['INST04'] := strInstr2;
            frxBanco.Script.Variables['INST05'] := strInstr3;
            frxBanco.Script.Variables['INST06'] := strInstr4;
            frxBanco.Script.Variables['INST07'] := strInstr5;
            frxBanco.Script.Variables['INST08'] := '';
            frxBanco.Script.Variables['OUTACR'] := '';
          end;

          If Length(Trim(strNuInSa)) > 11 Then
            frxBanco.Script.Variables['INSSAC'] := fMaskCNPJ(strNuInSa)
          Else frxBanco.Script.Variables['INSSAC'] := fMaskCPF(strNuInSa);

          frxBanco.Script.Variables['ENDSAC'] := strEndSac + ' - ' + strBaiSac;
          frxBanco.Script.Variables['CIDSAC'] := fMaskCEP(strCep001) + ' - ' + strCidSac + ' - ' + strEstSac;

          frxBanco.Script.Variables['LINDIG'] := strLinDig;

          TfrxBarCodeView(frxBanco.FindObject('barCodigo')).Text := strCodBar;

          TfrxBand(frxBanco.FindObject('rlbCompEntr')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrCut')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrN1')).Visible := Not blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrN2')).Visible := False;

        End;

      Except
        On E: Exception Do
        Begin
          MessageDlg(E.Message,mtError,[mbOK],0);
          Result := False;
        End;
      End;

    End;

    LExecutarImpCodBar := False;
  End

  {******************************************}
 {*        BANCO BTG PACTUAL [240P]        *}
 {*            LAYOUT PRÓPRIO              *}
 {******************************************}
  Else If (strIdeBan = '208') Then
  Begin
    Result     := fGeLiDi208;

    If Result Then
    Begin

      If Not FileExists(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoBtgPactual.bmp') Then
      Begin
        FreeAndNil(qryCfgRel);
        Result := False;
        pMensagemOk('O logo ' + ExtractFilePath(Application.ExeName) + 'LogoBoletos\LogoBtgPactual.bmp deve existir na pasta indicada.');
        Exit;
      End;

      Try
        pCriarFormularios(TfrmQckBancos, frmQckBancos);

        With frmQckBancos Do
        Begin

          frxPDFExport.ShowDialog   := Not blnEnvioDeEmailAutomatico;
          frxPDFExport.ShowProgress := Not blnEnvioDeEmailAutomatico;

          If strEspeci = 'AG' Then
            frxAgrupamento.DataSet := fQryAgrupamento(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, strCodCli)
          Else
            frxAgrupamento.DataSet := fCriaQuery;

          blnImpAgrup := (Not frxAgrupamento.DataSet.IsEmpty) And (fCfgSis('MDBLAG', varInteger) = 2);
          If blnImpAgrup Then
          Begin
            TfrxBand(frxBanco.FindObject('rlbAgrupamento')).Visible := True;
            TfrxBand(frxBanco.FindObject('rlbReciboSac')).Visible := False;
            TfrxBand(frxBanco.FindObject('rlbReciboSacCut')).Visible := False;
            If (Not fEmptyStr(fCfgSis('IMGBOL'))) and FileExists(fCfgSis('IMGBOL')) Then
              TfrxPictureView(frxBanco.FindObject('imgLogo')).Picture.LoadFromFile(fCfgSis('IMGBOL'));

            frxBanco.Script.Variables['NUMPARC'] := fRetNumParcela(RightStr(strNumDoc, 1));
            frxBanco.Script.Variables['TOTPARC'] := fQtdParcelas(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, 'AG', strCodCli);
            frxBanco.Script.Variables['MAILCLI'] := strMailCli;
          End;


          For intCont := 1 To 4 Do
            TfrxPictureView(frxBanco.FindObject('imgLog' + IntToStr(intCont))).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoBtgPactual.bmp');

          frxBanco.Script.Variables['CODBCO'] := '208-1';

          frxBanco.FindObject('rlbTelSac').Visible := False;
          frxBanco.FindObject('rllTelSac').Visible := False;
          frxBanco.FindObject('rllLinDig').Visible := False;

          // AVALISTA
          If Trim(strNumIns) <> '' Then
          Begin
            If strTipIns = '01' Then
              frxBanco.Script.Variables['NOMCED'] := IIF(fEmptyStr(strBenefi), strNomCed + '   ' + fMaskCNPJ(strNumIns), strBenefi)
            Else
              frxBanco.Script.Variables['NOMCED'] := IIF(fEmptyStr(strBenefi), strNomCed + '   ' + fMaskCPF(strNumIns), strBenefi);
          End
          Else
            frxBanco.Script.Variables['NOMCED'] := IIF(fEmptyStr(strBenefi), strNomCed, strBenefi);

          frxBanco.Script.Variables['ENDCED'] := IIF(fEmptyStr(strBenefi), strEndere, strEndBen);

          frxBanco.Script.Variables['SACAVA'] := IIF(fEmptyStr(strBenefi), '', strNomCed + IfThen(Not fEmptyStr(strNumIns),' - ' + IIF(strTipIns = '01', fMaskCNPJ(strNumIns), fMaskCPF(strNumIns)), ''));
          frxBanco.Script.Variables['ENDAVA'] := IIF(fEmptyStr(strBenefi), '', strEndere);

         {If Trim(strNumIns) <> '' Then
          Begin
            If strTipIns = '01' Then
              frxBanco.Script.Variables['NOMCED'] := strNomCed + '   ' + fMaskCNPJ(strNumIns)
            Else
              frxBanco.Script.Variables['NOMCED'] := strNomCed + '   ' + fMaskCPF(strNumIns);
          End
          Else
            frxBanco.Script.Variables['NOMCED'] := fRetNomeEmpresa + ' - CNPJ ' + fMaskCNPJ(fRetCGCEmpresa(VS_strCodEmp));

          frxBanco.Script.Variables['ENDCED'] := strEndere;
          frxBanco.Script.Variables['ENDAVA'] := '';}

          frxBanco.Script.Variables['USOBCO'] := '';

          {strAgeDig := strNumAge + '-' +
                       strDigAge + '/' +
                       Copy(strCodCed, 0, Length(strCodCed)-1) + '-' +
                       Copy(strCodCed, Length(strCodCed),1);}

          strAgeDig := strNumAge + '/' + strCodCed;

          frxBanco.Script.Variables['BENEFI'] := 'Beneficiário';
          frxBanco.Script.Variables['ESPMOE'] := 'Esp. Moeda';
          frxBanco.Script.Variables['VALMOE'] := 'Valor da Moeda';
          frxBanco.Script.Variables['PAGADO'] := 'Pagador';
          frxBanco.Script.Variables['AGECED'] := strAgeDig;
          frxBanco.Script.Variables['NOMSAC'] := strNomSac;
          frxBanco.Script.Variables['DTAVEN'] := FormatDateTime('dd/mm/yyyy', dtaDtaVen);
          frxBanco.Script.Variables['NUMDOC'] := strNumDoc;
          frxBanco.Script.Variables['VALDOC'] := FormatFloat('R$ #,##0.00',fStrToFloat(strVlrTit)/100);
          frxBanco.Script.Variables['LOCEXT'] := '';
          frxBanco.Script.Variables['LOCPAG'] := 'PAGÁVEL EM QUALQUER AGÊNCIA BANCÁRIA, MESMO APÓS VENCIMENTO';
          frxBanco.Script.Variables['DTADOC'] := FormatDateTime('dd/mm/yyyy', dtaDtaEmi);
          frxBanco.Script.Variables['ESPDOC'] := 'DM';
          frxBanco.Script.Variables['DTAPRO'] := FormatDateTime('dd/mm/yyyy', dtaDtaPro);
          frxBanco.Script.Variables['CARTEI'] := strCodCar;
          frxBanco.Script.Variables['CART02'] := '';
          frxBanco.Script.Variables['ACEITE'] := IIF(strIdeAce = 'S', 'Sim', 'Não');
          frxBanco.Script.Variables['CEDENT'] := 'Código Beneficiário';
          frxBanco.Script.Variables['SACAVA'] := '';

          strCaAgNs := strCodCar + strNosNum;
          Insert('/', strCaAgNs, 4);
          Insert('-', strCaAgNs, 16);

          TfrxMemoView(frxBanco.FindObject('rllCarNN1')).Text := 'Carteira/Nosso Número';

          TfrxMemoView(frxBanco.FindObject('rllNN1')).Text := 'Carteira/Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN2')).Text := 'Carteira/Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN3')).Text := 'Carteira/Nosso Número';

          frxBanco.Script.Variables['CARNOSNUM'] := strCaAgNs;
          frxBanco.Script.Variables['NOSNUM'] := strCaAgNs;

          frxBanco.Script.Variables['INST01'] := RetornaObservacaoMultaBtgPactual;

          frxBanco.Script.Variables['INST02'] := RetornaObservacaoJurosBtgPactual;

          If StrToIntDef(strPraPro,0) >= 1 Then
          Begin
            If StrToIntDef(strPraPro,0) = 1 Then
              frxBanco.Script.Variables['INST03'] := 'PROTESTAR APÓS ' + strPraPro + ' DIA ' + IIF(strTipDia = '1', 'ÚTIL', 'CORRIDO')
            Else
              frxBanco.Script.Variables['INST03'] := 'PROTESTAR APÓS ' + strPraPro + ' DIAS ' + IIF(strTipDia = '1', 'ÚTEIS', 'CORRIDOS') + ' À CONTAR DO VENCIMENTO';
          End
          Else frxBanco.Script.Variables['INST03'] := '';

          frxBanco.Script.Variables['INST04'] := strInstr1;
          frxBanco.Script.Variables['INST05'] := strInstr2;
          frxBanco.Script.Variables['INST06'] := strInstr3;
          frxBanco.Script.Variables['INST07'] := strInstr4;
          frxBanco.Script.Variables['INST08'] := strInstr5;
          frxBanco.Script.Variables['OUTACR'] := '';

          If Length(Trim(strNuInSa)) > 11 Then
            frxBanco.Script.Variables['INSSAC'] := fMaskCNPJ(strNuInSa)
          Else frxBanco.Script.Variables['INSSAC'] := fMaskCPF(strNuInSa);

          frxBanco.Script.Variables['ENDSAC'] := strEndSac + ' - ' + strBaiSac;
          frxBanco.Script.Variables['CIDSAC'] := fMaskCEP(strCep001) + ' - ' + strCidSac + ' - ' + strEstSac;

          frxBanco.Script.Variables['LINDIG'] := strLinDig;

          TfrxBarCodeView(frxBanco.FindObject('barCodigo')).Text := strCodBar;

          TfrxBand(frxBanco.FindObject('rlbCompEntr')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrCut')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrN1')).Visible := Not blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrN2')).Visible := False;

        End;

      Except
        On E: Exception Do
        Begin
          MessageDlg(E.Message,mtError,[mbOK],0);
          Result := False;
        End;
      End;

    End;

    LExecutarImpCodBar := False;
  End

  {******************************************}
  {*           BANCO ABC BRASIL             *}
  {*            LAYOUT PRÓPRIO              *}
  {*REQ:185769****************************TA*}
  Else If (strIdeBan = '246') Then
  Begin
    Result     := fGeLiDi246;

    If Result Then
    Begin

      If Not FileExists(ExtractFilePath(Application.ExeName) + '\LogoBoletos\ABCBrasil.bmp') Then
      Begin
        FreeAndNil(qryCfgRel);
        Result := False;
        pMensagemOk('O logo ' + ExtractFilePath(Application.ExeName) + 'LogoBoletos\ABCBrasil.bmp deve existir na pasta indicada.');
        Exit;
      End;

      Try
        pCriarFormularios(TfrmQckBancos, frmQckBancos);

        With frmQckBancos Do
        Begin

          frxPDFExport.ShowDialog   := Not blnEnvioDeEmailAutomatico;
          frxPDFExport.ShowProgress := Not blnEnvioDeEmailAutomatico;

          If strEspeci = 'AG' Then
            frxAgrupamento.DataSet := fQryAgrupamento(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, strCodCli)
          Else
            frxAgrupamento.DataSet := fCriaQuery;

          blnImpAgrup := (Not frxAgrupamento.DataSet.IsEmpty) And (fCfgSis('MDBLAG', varInteger) = 2);
          If blnImpAgrup Then
          Begin
            TfrxBand(frxBanco.FindObject('rlbAgrupamento')).Visible := True;
            TfrxBand(frxBanco.FindObject('rlbReciboSac')).Visible := False;
            TfrxBand(frxBanco.FindObject('rlbReciboSacCut')).Visible := False;
            If (Not fEmptyStr(fCfgSis('IMGBOL'))) and FileExists(fCfgSis('IMGBOL')) Then
              TfrxPictureView(frxBanco.FindObject('imgLogo')).Picture.LoadFromFile(fCfgSis('IMGBOL'));

            frxBanco.Script.Variables['NUMPARC'] := fRetNumParcela(RightStr(strNumDoc, 1));
            frxBanco.Script.Variables['TOTPARC'] := fQtdParcelas(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, 'AG', strCodCli);
            frxBanco.Script.Variables['MAILCLI'] := strMailCli;
          End;


          For intCont := 1 To 4 Do
            TfrxPictureView(frxBanco.FindObject('imgLog' + IntToStr(intCont))).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\ABCBrasil.bmp');

          frxBanco.Script.Variables['CODBCO'] := '246-1';

          frxBanco.FindObject('rlbTelSac').Visible := False;
          frxBanco.FindObject('rllTelSac').Visible := False;
          frxBanco.FindObject('rllLinDig').Visible := False;

          If Trim(strNumIns) <> '' Then
          Begin
            If strTipIns = '01' Then
              frxBanco.Script.Variables['NOMCED'] := strNomCed + '   ' + fMaskCNPJ(strNumIns)
            Else
              frxBanco.Script.Variables['NOMCED'] := strNomCed + '   ' + fMaskCPF(strNumIns);
          End
          Else
            frxBanco.Script.Variables['NOMCED'] := fRetNomeEmpresa + ' - CNPJ ' + fMaskCNPJ(fRetCGCEmpresa(VS_strCodEmp));

          frxBanco.Script.Variables['ENDCED'] := strEndere;
          frxBanco.Script.Variables['ENDAVA'] := '';
          frxBanco.Script.Variables['USOBCO'] := '';

          strAgeDig := strNumAge + '/' + strCodCed;

          frxBanco.Script.Variables['BENEFI'] := 'Beneficiário';
          frxBanco.Script.Variables['ESPMOE'] := 'Esp. Moeda';
          frxBanco.Script.Variables['VALMOE'] := 'Valor da Moeda';
          frxBanco.Script.Variables['PAGADO'] := 'Pagador';
          frxBanco.Script.Variables['AGECED'] := strAgeDig;
          frxBanco.Script.Variables['NOMSAC'] := strNomSac;
          frxBanco.Script.Variables['DTAVEN'] := FormatDateTime('dd/mm/yyyy', dtaDtaVen);
          frxBanco.Script.Variables['NUMDOC'] := strNumDoc;
          frxBanco.Script.Variables['VALDOC'] := FormatFloat('R$ #,##0.00',fStrToFloat(strVlrTit)/100);
          frxBanco.Script.Variables['LOCEXT'] := '';
          frxBanco.Script.Variables['LOCPAG'] := 'PAGÁVEL EM QUALQUER AGÊNCIA BANCÁRIA ATÉ O VENCIMENTO';
          frxBanco.Script.Variables['DTADOC'] := FormatDateTime('dd/mm/yyyy', dtaDtaEmi);
          frxBanco.Script.Variables['ESPDOC'] := 'DM';
          frxBanco.Script.Variables['DTAPRO'] := FormatDateTime('dd/mm/yyyy', dtaDtaPro);
          frxBanco.Script.Variables['CARTEI'] := strCodCar;
          frxBanco.Script.Variables['CART02'] := '';
          frxBanco.Script.Variables['ACEITE'] := IIF(strIdeAce = 'S', 'Sim', 'Não');
          frxBanco.Script.Variables['CEDENT'] := 'Conta Corrente';
          frxBanco.Script.Variables['SACAVA'] := '';

          strCaAgNs := strNumAge + strCodCar + strNosNum;
          Insert('/', strCaAgNs, 5);
          Insert('/', strCaAgNs, 9);
          Insert('-', strCaAgNs, 20);

          TfrxMemoView(frxBanco.FindObject('memo48') ).Text := 'Agência/Código Beneficiário';
          TfrxMemoView(frxBanco.FindObject('memo110')).Text := 'Agência/Código Beneficiário';
          TfrxMemoView(frxBanco.FindObject('memo171')).Text := 'Agência/Código Beneficiário';

          TfrxMemoView(frxBanco.FindObject('rllCarNN1')).Text := 'Nosso Número';

          TfrxMemoView(frxBanco.FindObject('rllNN1')).Text := 'Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN2')).Text := 'Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN3')).Text := 'Nosso Número';

          TfrxMemoView(frxBanco.FindObject('lblMoraMultaJurosCX')    ).Text := 'Mora/Multa';
          TfrxMemoView(frxBanco.FindObject('lblMoraMultaJurosRecibo')).Text := 'Mora/Multa';
          TfrxMemoView(frxBanco.FindObject('lblMoraMultaJurosFicha') ).Text := 'Mora/Multa';

          frxBanco.Script.Variables['CARNOSNUM'] := strCaAgNs;
          frxBanco.Script.Variables['NOSNUM'] := strCaAgNs;
          frxBanco.Script.Variables['INST01'] := IIF(fltVlrMul > 0, 'APÓS O VENCIMENTO COBRAR MULTA DE ' + FormatFloat('R$ #,##0.00', fltVlrMul), '');

          IF fltVlrMor > 0 THEN
          BEGIN
            frxBanco.Script.Variables['INST02'] := 'APÓS O VENCIMENTO, COBRAR ' + FormatFloat('R$ #,##0.00', fltVlrMor) + ' POR DIA DE ATRASO,';

            If StrToIntDef(strPraPro,0) >= 1 Then
            Begin
              If StrToIntDef(strPraPro,0) = 1 Then
                frxBanco.Script.Variables['INST03'] := 'PROTESTAR APÓS ' + strPraPro + ' DIA ' + IIF(strTipDia = '1', 'ÚTIL', 'CORRIDO') + ' À CONTAR DO VENCIMENTO'
              Else
                frxBanco.Script.Variables['INST03'] := 'PROTESTAR APÓS ' + strPraPro + ' DIAS ' + IIF(strTipDia = '1', 'ÚTEIS', 'CORRIDOS') + ' À CONTAR DO VENCIMENTO';
            End
            Else frxBanco.Script.Variables['INST03'] := '';

            frxBanco.Script.Variables['INST04'] := strInstr1;
            frxBanco.Script.Variables['INST05'] := strInstr2;
            frxBanco.Script.Variables['INST06'] := strInstr3;
            frxBanco.Script.Variables['INST07'] := strInstr4;
            frxBanco.Script.Variables['INST08'] := strInstr5;
            frxBanco.Script.Variables['OUTACR'] := '';
          end
          else
          begin
            If StrToIntDef(strPraPro,0) >= 1 Then
            Begin
              If StrToIntDef(strPraPro,0) = 1 Then
                frxBanco.Script.Variables['INST02'] := 'PROTESTAR APÓS ' + strPraPro + ' DIA ' + IIF(strTipDia = '1', 'ÚTIL', 'CORRIDO') + ' À CONTAR DO VENCIMENTO'
              Else
                frxBanco.Script.Variables['INST02'] := 'PROTESTAR APÓS ' + strPraPro + ' DIAS ' + IIF(strTipDia = '1', 'ÚTEIS', 'CORRIDOS') + ' À CONTAR DO VENCIMENTO';
            End
            Else frxBanco.Script.Variables['INST02'] := '';

            frxBanco.Script.Variables['INST03'] := strInstr1;
            frxBanco.Script.Variables['INST04'] := strInstr2;
            frxBanco.Script.Variables['INST05'] := strInstr3;
            frxBanco.Script.Variables['INST06'] := strInstr4;
            frxBanco.Script.Variables['INST07'] := strInstr5;
            frxBanco.Script.Variables['INST08'] := '';
            frxBanco.Script.Variables['OUTACR'] := '';
          end;

          If Length(Trim(strNuInSa)) > 11 Then
            frxBanco.Script.Variables['INSSAC'] := 'CNPJ: ' + fMaskCNPJ(strNuInSa)
          Else frxBanco.Script.Variables['INSSAC'] := 'CPF: ' + fMaskCPF(strNuInSa);

          frxBanco.Script.Variables['ENDSAC'] := strEndSac + ' - ' + strBaiSac;
          frxBanco.Script.Variables['CIDSAC'] := fMaskCEP(strCep001) + ' - ' + strCidSac + ' - ' + strEstSac;

          frxBanco.Script.Variables['LINDIG'] := strLinDig;

          TfrxBarCodeView(frxBanco.FindObject('barCodigo')).Text := strCodBar;

          TfrxBand(frxBanco.FindObject('rlbCompEntr')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrCut')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrN1')).Visible := Not blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrN2')).Visible := False;


          TfrxBand(frxBanco.FindObject('memo217')).Visible := False;
          TfrxBand(frxBanco.FindObject('memo156')).Visible := False;
          TfrxBand(frxBanco.FindObject('memo95')).Visible  := False;

          TfrxMemoView(frxBanco.FindObject('memo29')).Text  := 'REAL';
          TfrxMemoView(frxBanco.FindObject('memo69')).Text  := 'REAL';
          TfrxMemoView(frxBanco.FindObject('memo130')).Text := 'REAL';
          TfrxMemoView(frxBanco.FindObject('memo191')).Text := 'REAL';

        End;

      Except
        On E: Exception Do
        Begin
          MessageDlg(E.Message,mtError,[mbOK],0);
          Result := False;
        End;
      End;

    End;

    LExecutarImpCodBar := False;
  End

  Else If MatchStr(strIdeBan, ['341', '995', '988', '981', '964']) And (Not Assigned(TRetornoBoletoItau(LRetornoRegistroBoletoApi))) Then
  Begin
    Result     := fGeLiDi341;

    If Result Then
    Begin

      If Not FileExists(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoItau.bmp') Then
      Begin
        FreeAndNil(qryCfgRel);
        Result := False;
        pMensagemOk('O logo ' + ExtractFilePath(Application.ExeName) + 'LogoBoletos\LogoItau.bmp deve existir na pasta indicada.');
        Exit;
      End;

      Try
        pCriarFormularios(TfrmQckBancos, frmQckBancos);

        pCarregarLayImp(frmQckBancos);

        With frmQckBancos Do
        Begin

          If ( blnBolEnvEmail And (strIdeBan = '341') And (fCampoTabela('CLI_BOLSEN', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False) = 'S') and (blnBolPdf) And (MatchStr(fCfgSis('NOVLAY', varString), ['P','C','U'])) )
             Or
             ( (blnEnvioDeEmailAutomatico) And (strIdeBan = '341') And ((fCampoTabela('CLI_BOLSEN', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False) = 'S') and (blnBolPdf) And (fCfgSis('NOVLAY', varString) = 'P')) ) then
          begin
            CpfCnpj := fCampoTabela('CLI_C_G_C_', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False);
            CpfCnpj := Copy(CpfCnpj, 1, 5);

            if not fEmptyStr(CpfCnpj) then
            begin
              frmQckBancos.frxPDFExport.PdfA := False;
              frmQckBancos.frxPDFExport.UserPassword := AnsiString(CpfCnpj);
              frmQckBancos.frxPDFExport.OwnerPassword := AnsiString(CpfCnpj);
              frmQckBancos.frxPDFExport.ProtectionFlags := [ePrint];
            end;
          end;

          frxPDFExport.ShowDialog   := Not blnEnvioDeEmailAutomatico;
          frxPDFExport.ShowProgress := Not blnEnvioDeEmailAutomatico;

          If strEspeci = 'AG' Then
            frxAgrupamento.DataSet := fQryAgrupamento(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, strCodCli)
          Else
            frxAgrupamento.DataSet := fCriaQuery;

          blnImpAgrup := (Not frxAgrupamento.DataSet.IsEmpty) And (fCfgSis('MDBLAG', varInteger) = 2);
          If blnImpAgrup Then
          Begin
            TfrxBand(frxBanco.FindObject('rlbAgrupamento')).Visible   := True;
            TfrxBand(frxBanco.FindObject('rlbFichaCaixa')).Visible    := False;
            TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Visible := False;
            If (Not fEmptyStr(fCfgSis('IMGBOL'))) and FileExists(fCfgSis('IMGBOL')) Then
              TfrxPictureView(frxBanco.FindObject('imgLogo')).Picture.LoadFromFile(fCfgSis('IMGBOL'));

            frxBanco.Script.Variables['NUMPARC'] := fRetNumParcela(RightStr(strNumDoc, 1));
            frxBanco.Script.Variables['TOTPARC'] := fQtdParcelas(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, 'AG', strCodCli);
            frxBanco.Script.Variables['MAILCLI'] := strMailCli;
          End;

          For intCont := 1 To 4 Do
            TfrxPictureView(frxBanco.FindObject('imgLog' + IntToStr(intCont))).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoItau.bmp');

          frxBanco.Script.Variables['CODBCO'] := '341-7';

          frxBanco.FindObject('rlbTelSac').Visible := False;
          frxBanco.FindObject('rllTelSac').Visible := False;
          frxBanco.FindObject('rllLinDig').Visible := False;

          If Trim(strNumIns) <> '' Then
          Begin
            If strTipIns = '01' Then
              frxBanco.Script.Variables['NOMCED'] := IIF(fEmptyStr(strBenefi), strNomCed + '   ' + fMaskCNPJ(strNumIns), strBenefi)
            Else
              frxBanco.Script.Variables['NOMCED'] := IIF(fEmptyStr(strBenefi), strNomCed + '   ' + fMaskCPF(strNumIns), strBenefi);
          End
          Else
            frxBanco.Script.Variables['NOMCED'] := IIF(fEmptyStr(strBenefi), strNomCed, strBenefi);

          frxBanco.Script.Variables['ENDCED'] := IIF(fEmptyStr(strBenefi), strEndere, strEndBen);

          frxBanco.Script.Variables['SACAVA'] := IIF(fEmptyStr(strBenefi), '', strNomCed + IfThen(Not fEmptyStr(strNumIns),' - ' + IIF(strTipIns = '01', fMaskCNPJ(strNumIns), fMaskCPF(strNumIns)), ''));
          frxBanco.Script.Variables['ENDAVA'] := IIF(fEmptyStr(strBenefi), '', strEndere);
          frxBanco.Script.Variables['USOBCO'] := '';

          strAgeDig := strNumAge + strCodCed;
          Insert('/', strAgeDig, 5);
          Insert('-', strAgeDig, 11);

          frxBanco.Script.Variables['BENEFI'] := 'Beneficiário';
          frxBanco.Script.Variables['BENEFI2']:= 'BENEFICIÁRIO';
          frxBanco.Script.Variables['ESPMOE'] := 'Esp. Moeda';
          frxBanco.Script.Variables['VALMOE'] := 'Valor da Moeda';
          frxBanco.Script.Variables['PAGADO'] := 'Pagador';
          frxBanco.Script.Variables['AGECED'] := strAgeDig;
          frxBanco.Script.Variables['NOMSAC'] := strNomSac;
          frxBanco.Script.Variables['DTAVEN'] := FormatDateTime('dd/mm/yyyy', dtaDtaVen);

          If strIdeFac = '981' Then
            frxBanco.Script.Variables['NUMDOC'] := RightStr(IfThen(strImprimirParcela = 'S', strNumDoc, LeftStr(strNumDoc, Length(strNumDoc) - 1)), 10)
          Else
            frxBanco.Script.Variables['NUMDOC'] := IfThen(strImprimirParcela = 'S', strNumDoc, LeftStr(strNumDoc, Length(strNumDoc) - 1));

          frxBanco.Script.Variables['VALDOC'] := FormatFloat('R$ #,##0.00',fStrToFloat(strVlrTit)/100);

          If strIdeBan = '988' Then
          Begin
            frxBanco.Script.Variables['LOCEXT'] := '';
            frxBanco.Script.Variables['LOCPAG'] := 'ATÉ O VENCIMENTO PAGUE PREFERENCIALMENTE NO ITAU. APÓS O VENCIMENTO PAGUE SOMENTE NO ITAU.';
          End
          Else
          Begin
            frxBanco.Script.Variables['LOCEXT'] := 'ATÉ O VENCIMENTO EM QUALQUER BANCO OU CORRESPONDENTE NÃO BANCÁRIO. APÓS O';
            frxBanco.Script.Variables['LOCPAG'] := 'VENCIMENTO, ACESSE ITAU.COM.BR/BOLETOS E PAGUE EM QUALQUER BANCO OU CORRESPONDENTE NÃO BANCÁRIO.';
          End;

          frxBanco.Script.Variables['DTADOC'] := FormatDateTime('dd/mm/yyyy', dtaDtaEmi);
          frxBanco.Script.Variables['ESPDOC'] := 'DM';
          frxBanco.Script.Variables['DTAPRO'] := FormatDateTime('dd/mm/yyyy', dtaDtaPro);
          frxBanco.Script.Variables['CARTEI'] := strCodCar;
          frxBanco.Script.Variables['CART02'] := '';
          frxBanco.Script.Variables['ACEITE'] := IIF(strIdeAce = 'S', 'Sim', 'Não');
          frxBanco.Script.Variables['CEDENT'] := 'Cód. Beneficiário';
          //frxBanco.Script.Variables['SACAVA'] := '';

          strCaAgNs := strCodCar + strNosNum;
          Insert('/', strCaAgNs, 4);
          Insert('-', strCaAgNs, 13);

          TfrxMemoView(frxBanco.FindObject('rllCarNN1')).Text := 'Carteira/Nosso Número';

          TfrxMemoView(frxBanco.FindObject('rllNN1')).Text := 'Carteira/Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN2')).Text := 'Carteira/Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN3')).Text := 'Carteira/Nosso Número';

          frxBanco.Script.Variables['CARNOSNUM'] := strCaAgNs;
          frxBanco.Script.Variables['NOSNUM'] := strCaAgNs;

          If (strIdeBan = '341') Then
             frxBanco.Script.Variables['INST01'] := RetornaObservacaoItau
          Else
             frxBanco.Script.Variables['INST01'] := IIF(fltVlrMor > 0, 'Após o vencimento cobrar ' + FormatFloat('R$ #,##0.00', fltVlrMor) + ' por dia de atraso.','') +
                                                    IIF(fltVlrMul > 0,'        Após o vencimento cobrar multa de ' + FormatFloat('R$ #,##0.00', fltVlrMul),'');

          If strIdeFac = '964' Then
          Begin
             frxBanco.Script.Variables['INST01'] := IIF(fltVlrMor > 0, 'Após o vencimento cobrar ' + FormatFloat('R$ #,##0.00', fltVlrMor) + ' por dia de atraso.','') +
                                                    IIF(fltVlrMul > 0,'        Após o vencimento cobrar multa de ' + FormatFloat('R$ #,##0.00', fltVlrMul),'');
          End;

          If StrToIntDef(strPraPro,0) >= 1 Then
          Begin
            If (strCdIns1 = '66') Or (strCdIns2 = '66') Then
            Begin
              If StrToIntDef(strPraPro,0) = 1 Then
                frxBanco.Script.Variables['INST02'] := 'SUJEITO A NEGATIVAÇÃO APÓS ' + strPraPro + ' DIA DO VENCIMENTO'
              Else
                frxBanco.Script.Variables['INST02'] := 'SUJEITO A NEGATIVAÇÃO APÓS ' + strPraPro + ' DIAS DO VENCIMENTO';
            End
            Else If (strCdIns1 = '9') Or (strCdIns1 = '09') Or (strCdIns1 = '34') Or (strCdIns1 = '35') Or (strCdIns1 = '42') Or (strCdIns1 = '81') Or (strCdIns1 = '82') Or
                    (strCdIns2 = '9') Or (strCdIns2 = '09') Or (strCdIns2 = '34') Or (strCdIns2 = '35') Or (strCdIns2 = '42') Or (strCdIns2 = '81') Or (strCdIns2 = '82') Then
            Begin
              If StrToIntDef(strPraPro,0) = 1 Then
                frxBanco.Script.Variables['INST02'] := 'PROTESTAR APÓS ' + strPraPro + ' DIA ' + IIF(strTipDia = '1', 'ÚTIL', 'CORRIDO') + ' DO VENCIMENTO'
              Else
                frxBanco.Script.Variables['INST02'] := 'PROTESTAR APÓS ' + strPraPro + ' DIAS ' + IIF(strTipDia = '1', 'ÚTEIS', 'CORRIDOS') + ' DO VENCIMENTO';
            End
            Else If (strCdIns1 = '91') Or (strCdIns2 = '91') Then
            Begin
              If StrToIntDef(strPraPro,0) = 1 Then
                frxBanco.Script.Variables['INST02'] := 'NÃO RECEBER APÓS ' + strPraPro + ' DIA DO VENCIMENTO'
              Else
                frxBanco.Script.Variables['INST02'] := 'NÃO RECEBER APÓS ' + strPraPro + ' DIAS DO VENCIMENTO';
            End
            Else
              frxBanco.Script.Variables['INST02'] := '';
          End
          Else
            frxBanco.Script.Variables['INST02'] := '';

          frxBanco.Script.Variables['INST03'] := strInstr1;
          frxBanco.Script.Variables['INST04'] := strInstr2;
          frxBanco.Script.Variables['INST05'] := strInstr3;
          frxBanco.Script.Variables['INST06'] := strInstr4;
          frxBanco.Script.Variables['INST07'] := strInstr5;
          frxBanco.Script.Variables['INST08'] := '';
          frxBanco.Script.Variables['OUTACR'] := '';

          if blnObsDes then // Destaca em negrito a observacao 5 req: 159365
          begin
            TfrxMemoView(frxBanco.FindObject('lblInst7Cx')).Font.Style := [fsBold];
            TfrxMemoView(frxBanco.FindObject('lblInst7Cx')).Font.Size := TfrxMemoView(frxBanco.FindObject('lblInst7Cx')).Font.Size + 1;
            TfrxMemoView(frxBanco.FindObject('lblInst7Cx')).Height := TfrxMemoView(frxBanco.FindObject('lblInst7Cx')).Height + 1;

            TfrxMemoView(frxBanco.FindObject('lblInst7Pg')).Font.Style := [fsBold];
            TfrxMemoView(frxBanco.FindObject('lblInst7Pg')).Font.Size := TfrxMemoView(frxBanco.FindObject('lblInst7Pg')).Font.Size + 1;
            TfrxMemoView(frxBanco.FindObject('lblInst7Pg')).Height := TfrxMemoView(frxBanco.FindObject('lblInst7Pg')).Height + 1;

            TfrxMemoView(frxBanco.FindObject('lblInst7Cp')).Font.Style := [fsBold];
            TfrxMemoView(frxBanco.FindObject('lblInst7Cp')).Font.Size := TfrxMemoView(frxBanco.FindObject('lblInst7Cp')).Font.Size + 1;
            TfrxMemoView(frxBanco.FindObject('lblInst7Cp')).Height := TfrxMemoView(frxBanco.FindObject('lblInst7Cp')).Height + 1;
          end;

          If Length(Trim(strNuInSa)) > 11 Then
            frxBanco.Script.Variables['INSSAC'] := fMaskCNPJ(strNuInSa)
          Else frxBanco.Script.Variables['INSSAC'] := fMaskCPF(strNuInSa);

          frxBanco.Script.Variables['ENDSAC'] := strEndSac + ' - ' + strBaiSac;
          frxBanco.Script.Variables['CIDSAC'] := fMaskCEP(strCep001) + ' - ' + strCidSac + ' - ' + strEstSac;

          frxBanco.Script.Variables['LINDIG'] := strLinDig;

          TfrxBarCodeView(frxBanco.FindObject('barCodigo')).Text := strCodBar;

          TfrxBand(frxBanco.FindObject('rlbCompEntr')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrCut')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrN1')).Visible := Not (blnProEnt Or blnImpAgrup);
          TfrxBand(frxBanco.FindObject('rlbCompEntrN2')).Visible := Not (blnProEnt Or blnImpAgrup);

          {********************************************************}
          {* LAYOUT DE BOLETO EM DUAS VIAS (FICHA DE COMPENSAÇÃO E*}
          {* RECIBO DO PAGADOR                                    *}
          {*****************************************************GD*}
          if fCfgSis('NOVLAY', varString) = 'D' then
          begin
            TfrxBand(frxBanco.FindObject('rlbFichaCaixa')).Visible    := False;
            TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Visible := False;
            if not blnImpAgrup  then
              TfrxBand(frxBanco.FindObject('rlbCompEntrN1')).Visible := False;

            If (Not fEmptyStr(fCfgSis('IMGBOL'))) and FileExists(fCfgSis('IMGBOL')) Then
            begin
              TfrxBand(frxBanco.FindObject('rlbReciboSac')).Visible              := False;
              TfrxBand(frxBanco.FindObject('rlbReciboPagadorComImagem')).Visible := True;
              TfrxPictureView(frxBanco.FindObject('imgLogo2')).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoItau.bmp');
              TfrxPictureView(frxBanco.FindObject('imgLogoEmpresa')).Picture.LoadFromFile(fCfgSis('IMGBOL'));
            end;
          end;

          If blnProEnt Then
            TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Height := TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Height + 18;

          If not fEmptyStr(FQRCode) Then
          Begin
            frmQckBancos.frxQRCodePix.Dataset.Open;
            frmQckBancos.frxQRCodePix.Dataset.Append;
            frmQckBancos.frxQRCodePix.Dataset.FieldByName('QRCODEPIX').AsString := FQRCode;
            frmQckBancos.frxQRCodePix.Dataset.Post;

            TfrxBand(frxBanco.FindObject('rlbFichaComp')).Visible := False;
            TfrxBand(frxBanco.FindObject('rlbFichaCompensacaoPix')).Visible := True;
            TfrxBarCodeView(frxBanco.FindObject('BarCode1')).Text := strCodBar;
          End;
        End;

      Except
        On E: Exception Do
        Begin
          pMensagensErro('Ocorreu um erro ao realizar a impressão do boleto do documento ' + strNumDup + '-' + strEspDoc + '.' + #13 +
                         'Deve ser realizada a reimpressão do boleto desse documento.' + #13 +
                         'Erro gerado: ' + E.Message, '[untBancos.fProArquivo]');
          Result := False;
        End;
      End;
    End;

    LExecutarImpCodBar := False;
  End

  {***************}
  {* BANCO INTER *}
  {************AJ*}
  Else If strIdeBan = '077' Then
  Begin
    pCriarFormularios(TfrmQckBancos, frmQckBancos);

    pCarregarLayImp(frmQckBancos);

    frmQckBancos.frxPDFExport.ShowDialog   := Not blnEnvioDeEmailAutomatico;
    frmQckBancos.frxPDFExport.ShowProgress := Not blnEnvioDeEmailAutomatico;

    Result := GeraBoletoBancoInter077(frmQckBancos.frxBanco, frmQckBancos.frxAgrupamento);

    LExecutarImpCodBar := False;
  End

  {****************************}
  {* BANCO DO BRASIL [Online] *}
  {*************************MT*}
  Else If (strIdeBan = '001') And Assigned(TRetornoBoletoBancoDoBrasil(LRetornoRegistroBoletoApi)) Then
  Begin
    pCriarFormularios(TfrmQckBancos, frmQckBancos);

    pCarregarLayImp(frmQckBancos);

    If ( blnBolEnvEmail And (fCampoTabela('CLI_BOLSEN', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False) = 'S') and (blnBolPdf) And (MatchStr(fCfgSis('NOVLAY', varString), ['P','C','U'])) )
       Or
       ( (blnEnvioDeEmailAutomatico) And (fCampoTabela('CLI_BOLSEN', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False) = 'S') and (blnBolPdf) And (fCfgSis('NOVLAY', varString) = 'P') ) then
    begin
      CpfCnpj := fCampoTabela('CLI_C_G_C_', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False);
      CpfCnpj := Copy(CpfCnpj, 1, 5);

      if not fEmptyStr(CpfCnpj) then
      begin
        frmQckBancos.frxPDFExport.PdfA := False;
        frmQckBancos.frxPDFExport.UserPassword := AnsiString(CpfCnpj);
        frmQckBancos.frxPDFExport.OwnerPassword := AnsiString(CpfCnpj);
        frmQckBancos.frxPDFExport.ProtectionFlags := [ePrint];
      end;
    end;

    frmQckBancos.frxPDFExport.ShowDialog   := Not blnEnvioDeEmailAutomatico;
    frmQckBancos.frxPDFExport.ShowProgress := Not blnEnvioDeEmailAutomatico;
    frmQckBancos.frxBanco.ShowProgress              := Not blnEnvioDeEmailAutomatico;
    frmQckBancos.frxBanco.EngineOptions.SilentMode  := blnEnvioDeEmailAutomatico;


    Result := GeraBoletoBancoDoBrasilApi(frmQckBancos.frxBanco,
                                         frmQckBancos.frxAgrupamento,
                                         frmQckBancos.frxQRCodePix);

    LExecutarImpCodBar := False;
  End

  {*****************}
  {* ITAU [Online] *}
  {**************AJ*}
  Else If (strIdeBan = '341') And Assigned(TRetornoBoletoItau(LRetornoRegistroBoletoApi)) Then
  Begin
    pCriarFormularios(TfrmQckBancos, frmQckBancos);

    pCarregarLayImp(frmQckBancos);

    If ( blnBolEnvEmail And (fCampoTabela('CLI_BOLSEN', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False) = 'S') and (blnBolPdf) And (MatchStr(fCfgSis('NOVLAY', varString), ['P','C','U'])) )
       Or
       ( (blnEnvioDeEmailAutomatico) And (fCampoTabela('CLI_BOLSEN', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False) = 'S') and (blnBolPdf) And (fCfgSis('NOVLAY', varString) = 'P') ) then
    begin
      CpfCnpj := fCampoTabela('CLI_C_G_C_', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False);
      CpfCnpj := Copy(CpfCnpj, 1, 5);

      if not fEmptyStr(CpfCnpj) then
      begin
        frmQckBancos.frxPDFExport.PdfA := False;
        frmQckBancos.frxPDFExport.UserPassword := AnsiString(CpfCnpj);
        frmQckBancos.frxPDFExport.OwnerPassword := AnsiString(CpfCnpj);
        frmQckBancos.frxPDFExport.ProtectionFlags := [ePrint];
      end;
    end;

    frmQckBancos.frxPDFExport.ShowDialog   := Not blnEnvioDeEmailAutomatico;
    frmQckBancos.frxPDFExport.ShowProgress := Not blnEnvioDeEmailAutomatico;
    frmQckBancos.frxBanco.ShowProgress              := Not blnEnvioDeEmailAutomatico;
    frmQckBancos.frxBanco.EngineOptions.SilentMode  := blnEnvioDeEmailAutomatico;


    Result := GeraBoletoBancoItauApi(frmQckBancos.frxBanco,
                                     frmQckBancos.frxAgrupamento,
                                     frmQckBancos.frxQRCodePix);

    LExecutarImpCodBar := False;
  End

  {*******************}
  {* SICOOB [Online] *}
  {****************AJ*}
  Else If (strIdeBan = '756') And Assigned(TRetornoBoletoSicoob(LRetornoRegistroBoletoApi)) Then
  Begin
    pCriarFormularios(TfrmQckBancos, frmQckBancos);

    pCarregarLayImp(frmQckBancos);

    If ( blnBolEnvEmail And (fCampoTabela('CLI_BOLSEN', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False) = 'S') and (blnBolPdf) And (MatchStr(fCfgSis('NOVLAY', varString), ['P','C','U'])) )
       Or
       ( (blnEnvioDeEmailAutomatico) And (fCampoTabela('CLI_BOLSEN', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False) = 'S') and (blnBolPdf) And (fCfgSis('NOVLAY', varString) = 'P') ) then
    begin
      CpfCnpj := fCampoTabela('CLI_C_G_C_', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False);
      CpfCnpj := Copy(CpfCnpj, 1, 5);

      if not fEmptyStr(CpfCnpj) then
      begin
        frmQckBancos.frxPDFExport.PdfA := False;
        frmQckBancos.frxPDFExport.UserPassword := AnsiString(CpfCnpj);
        frmQckBancos.frxPDFExport.OwnerPassword := AnsiString(CpfCnpj);
        frmQckBancos.frxPDFExport.ProtectionFlags := [ePrint];
      end;
    end;

    frmQckBancos.frxPDFExport.ShowDialog   := Not blnEnvioDeEmailAutomatico;
    frmQckBancos.frxPDFExport.ShowProgress := Not blnEnvioDeEmailAutomatico;
    frmQckBancos.frxBanco.ShowProgress              := Not blnEnvioDeEmailAutomatico;
    frmQckBancos.frxBanco.EngineOptions.SilentMode  := blnEnvioDeEmailAutomatico;


    Result := GeraBoletoBancoSicoobApi(frmQckBancos.frxBanco,
                                       frmQckBancos.frxAgrupamento,
                                       frmQckBancos.frxQRCodePix);

    LExecutarImpCodBar := False;
  End

  {******************}
  {* BANCO CREDISIS *}
  {***************TA*}
  Else If strIdeBan = '097' Then
  Begin
    pCriarFormularios(TfrmQckBancos, frmQckBancos);

    pCarregarLayImp(frmQckBancos);

    frmQckBancos.frxPDFExport.ShowDialog   := Not blnEnvioDeEmailAutomatico;
    frmQckBancos.frxPDFExport.ShowProgress := Not blnEnvioDeEmailAutomatico;

    Result := GeraBoletoBancoCredisis097(frmQckBancos.frxBanco, frmQckBancos.frxAgrupamento);

    LExecutarImpCodBar := False;
  End

  {****************************}
  {* BANCO SICREDI [Online] *}
  {*************************TA*}
  Else If (strIdeBan = '748') And Assigned(TRetornoBoletoBancoSicredi(LRetornoRegistroBoletoApi)) Then
  Begin
    pCriarFormularios(TfrmQckBancos, frmQckBancos);

    pCarregarLayImp(frmQckBancos);

    If ( blnBolEnvEmail And (fCampoTabela('CLI_BOLSEN', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False) = 'S') and (blnBolPdf) And (MatchStr(fCfgSis('NOVLAY', varString), ['P','C','U'])) )
       Or
       ( (blnEnvioDeEmailAutomatico) And (fCampoTabela('CLI_BOLSEN', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False) = 'S') and (blnBolPdf) And (fCfgSis('NOVLAY', varString) = 'P') ) then
    begin
      CpfCnpj := fCampoTabela('CLI_C_G_C_', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False);
      CpfCnpj := Copy(CpfCnpj, 1, 5);

      if not fEmptyStr(CpfCnpj) then
      begin
        frmQckBancos.frxPDFExport.PdfA := False;
        frmQckBancos.frxPDFExport.UserPassword := AnsiString(CpfCnpj);
        frmQckBancos.frxPDFExport.OwnerPassword := AnsiString(CpfCnpj);
        frmQckBancos.frxPDFExport.ProtectionFlags := [ePrint];
      end;
    end;

    frmQckBancos.frxPDFExport.ShowDialog   := Not blnEnvioDeEmailAutomatico;
    frmQckBancos.frxPDFExport.ShowProgress := Not blnEnvioDeEmailAutomatico;
    frmQckBancos.frxBanco.ShowProgress              := Not blnEnvioDeEmailAutomatico;
    frmQckBancos.frxBanco.EngineOptions.SilentMode  := blnEnvioDeEmailAutomatico;


    Result := GeraBoletoBancoSicrediApi(frmQckBancos.frxBanco,
                                        frmQckBancos.frxAgrupamento,
                                        frmQckBancos.frxQRCodePix);

    LExecutarImpCodBar := False;
  End

  {**********************}
  {* SANTANDER [Online] *}
  {*******************AJ*}
  Else If (strIdeBan = '033') And Assigned(TRetornoBoletoSantander(LRetornoRegistroBoletoApi)) Then
  Begin
    pCriarFormularios(TfrmQckBancos, frmQckBancos);

    pCarregarLayImp(frmQckBancos);

    If ( blnBolEnvEmail And (fCampoTabela('CLI_BOLSEN', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False) = 'S') and (blnBolPdf) And (MatchStr(fCfgSis('NOVLAY', varString), ['P','C','U'])) )
       Or
       ( (blnEnvioDeEmailAutomatico) And (fCampoTabela('CLI_BOLSEN', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False) = 'S') and (blnBolPdf) And (fCfgSis('NOVLAY', varString) = 'P') ) then
    begin
      CpfCnpj := fCampoTabela('CLI_C_G_C_', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False);
      CpfCnpj := Copy(CpfCnpj, 1, 5);

      if not fEmptyStr(CpfCnpj) then
      begin
        frmQckBancos.frxPDFExport.PdfA := False;
        frmQckBancos.frxPDFExport.UserPassword := AnsiString(CpfCnpj);
        frmQckBancos.frxPDFExport.OwnerPassword := AnsiString(CpfCnpj);
        frmQckBancos.frxPDFExport.ProtectionFlags := [ePrint];
      end;
    end;

    frmQckBancos.frxPDFExport.ShowDialog   := Not blnEnvioDeEmailAutomatico;
    frmQckBancos.frxPDFExport.ShowProgress := Not blnEnvioDeEmailAutomatico;
    frmQckBancos.frxBanco.ShowProgress              := Not blnEnvioDeEmailAutomatico;
    frmQckBancos.frxBanco.EngineOptions.SilentMode  := blnEnvioDeEmailAutomatico;


    Result := GeraBoletoBancoSantanderApi(frmQckBancos.frxBanco,
                                          frmQckBancos.frxAgrupamento,
                                          frmQckBancos.frxQRCodePix);

    LExecutarImpCodBar := False;
  End

  {*********************}
  {* BRADESCO [Online] *}
  {******************AJ*}
  Else If strIdeBan.Equals('237') And Assigned(TRetornoBoletoBradesco(LRetornoRegistroBoletoApi)) Then
  Begin
    pCriarFormularios(TfrmQckBancos, frmQckBancos);

    pCarregarLayImp(frmQckBancos);

    If ( blnBolEnvEmail And blnEnvioFaturamento And (fCampoTabela('CLI_BOLSEN', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False) = 'S') and (blnBolPdf) And (MatchStr(fCfgSis('NOVLAY', varString), ['P','C','U'])) )
       Or
       ( (blnEnvioDeEmailAutomatico) And (fCampoTabela('CLI_BOLSEN', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False) = 'S') and (blnBolPdf) And (fCfgSis('NOVLAY', varString) = 'P') ) then
    begin
      CpfCnpj := fCampoTabela('CLI_C_G_C_', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False);
      CpfCnpj := Copy(CpfCnpj, 1, 5);

      if not fEmptyStr(CpfCnpj) then
      begin
        frmQckBancos.frxPDFExport.PdfA := False;
        frmQckBancos.frxPDFExport.UserPassword := AnsiString(CpfCnpj);
        frmQckBancos.frxPDFExport.OwnerPassword := AnsiString(CpfCnpj);
        frmQckBancos.frxPDFExport.ProtectionFlags := [ePrint];
      end;
    end;

    frmQckBancos.frxPDFExport.ShowDialog   := Not blnEnvioDeEmailAutomatico;
    frmQckBancos.frxPDFExport.ShowProgress := Not blnEnvioDeEmailAutomatico;
    frmQckBancos.frxBanco.ShowProgress              := Not blnEnvioDeEmailAutomatico;
    frmQckBancos.frxBanco.EngineOptions.SilentMode  := blnEnvioDeEmailAutomatico;


    Result := GeraBoletoBancoBradescoApi(frmQckBancos.frxBanco,
                                         frmQckBancos.frxAgrupamento,
                                         frmQckBancos.frxQRCodePix);

    LExecutarImpCodBar := False;
  End

  {************************}
  {* BANCO SAFRA [Online] *}
  {*********************TA*}
  Else If (strIdeBan = '422') And Assigned(TRetornoBoletoBancoSafra(LRetornoRegistroBoletoApi)) Then
  Begin
    pCriarFormularios(TfrmQckBancos, frmQckBancos);

    pCarregarLayImp(frmQckBancos);

    If ( blnBolEnvEmail And blnEnvioFaturamento And (fCampoTabela('CLI_BOLSEN', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False) = 'S') and (blnBolPdf) And (MatchStr(fCfgSis('NOVLAY', varString), ['P','C','U'])) )
       Or
       ( (blnEnvioDeEmailAutomatico) And (fCampoTabela('CLI_BOLSEN', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False) = 'S') and (blnBolPdf) And (fCfgSis('NOVLAY', varString) = 'P') ) then
    begin
      CpfCnpj := fCampoTabela('CLI_C_G_C_', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False);
      CpfCnpj := Copy(CpfCnpj, 1, 5);

      if not fEmptyStr(CpfCnpj) then
      begin
        frmQckBancos.frxPDFExport.PdfA := False;
        frmQckBancos.frxPDFExport.UserPassword := AnsiString(CpfCnpj);
        frmQckBancos.frxPDFExport.OwnerPassword := AnsiString(CpfCnpj);
        frmQckBancos.frxPDFExport.ProtectionFlags := [ePrint];
      end;
    end;

    frmQckBancos.frxPDFExport.ShowDialog   := Not blnEnvioDeEmailAutomatico;
    frmQckBancos.frxPDFExport.ShowProgress := Not blnEnvioDeEmailAutomatico;
    frmQckBancos.frxBanco.ShowProgress              := Not blnEnvioDeEmailAutomatico;
    frmQckBancos.frxBanco.EngineOptions.SilentMode  := blnEnvioDeEmailAutomatico;


    Result := GeraBoletoBancoSafraApi(frmQckBancos.frxBanco,
                                      frmQckBancos.frxAgrupamento,
                                      frmQckBancos.frxQRCodePix);

    LExecutarImpCodBar := False;
  End

  Else If MatchStr(strIdeBan, ['033', '637']) And (Not Assigned(TRetornoBoletoSantander(LRetornoRegistroBoletoApi))) And (strBcoini <> '637LP444p') Then
  Begin
    pProArq033B;
    Result := Not fEmptyStr(strCodBar);

    If Result Then
    Begin
      If Not FileExists(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoSantander.bmp') Then
      Begin
        FreeAndNil(qryCfgRel);
        pMensagemOk('O logo ' + ExtractFilePath(Application.ExeName) + 'LogoBoletos\LogoSantander.bmp deve existir na pasta indicada.');
        Exit;
      End;

      Try
        pCriarFormularios(TfrmQckBancos, frmQckBancos);

        pCarregarLayImp(frmQckBancos);

        With frmQckBancos Do
        Begin

          If ( blnBolEnvEmail And (strIdeBan = '033') And (fCampoTabela('CLI_BOLSEN', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False) = 'S') and (blnBolPdf) And (MatchStr(fCfgSis('NOVLAY', varString), ['P','C','U'])) )
             Or
             ( (blnEnvioDeEmailAutomatico) And (fCampoTabela('CLI_BOLSEN', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False) = 'S') and (blnBolPdf) And (fCfgSis('NOVLAY', varString) = 'P') ) then
          begin
            CpfCnpj := fCampoTabela('CLI_C_G_C_', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False);
            CpfCnpj := Copy(CpfCnpj, 1, 5);

            if not fEmptyStr(CpfCnpj) then
            begin
              frmQckBancos.frxPDFExport.PdfA := False;
              frmQckBancos.frxPDFExport.UserPassword := AnsiString(CpfCnpj);
              frmQckBancos.frxPDFExport.OwnerPassword := AnsiString(CpfCnpj);
              frmQckBancos.frxPDFExport.ProtectionFlags := [ePrint];
            end;
          end;

          frxPDFExport.ShowDialog   := Not blnEnvioDeEmailAutomatico;
          frxPDFExport.ShowProgress := Not blnEnvioDeEmailAutomatico;

          If strEspeci = 'AG' Then
            frxAgrupamento.DataSet := fQryAgrupamento(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, strCodCli)
          Else
            frxAgrupamento.DataSet := fCriaQuery;

          blnImpAgrup := (Not frxAgrupamento.DataSet.IsEmpty) And (fCfgSis('MDBLAG', varInteger) = 2);
          If blnImpAgrup Then
          Begin
            TfrxBand(frxBanco.FindObject('rlbAgrupamento')).Visible   := True;
            TfrxBand(frxBanco.FindObject('rlbFichaCaixa')).Visible    := False;
            TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Visible := False;
            If (Not fEmptyStr(fCfgSis('IMGBOL'))) and FileExists(fCfgSis('IMGBOL')) Then
              TfrxPictureView(frxBanco.FindObject('imgLogo')).Picture.LoadFromFile(fCfgSis('IMGBOL'));

            frxBanco.Script.Variables['NUMPARC'] := fRetNumParcela(RightStr(strNumDoc, 1));
            frxBanco.Script.Variables['TOTPARC'] := fQtdParcelas(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, 'AG', strCodCli);
            frxBanco.Script.Variables['MAILCLI'] := strMailCli;
          End;

          For intCont := 1 To 4 Do
            TfrxPictureView(frxBanco.FindObject('imgLog' + IntToStr(intCont))).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoSantander.bmp');

          frxBanco.Script.Variables['CODBCO'] := '033-7';

          frxBanco.FindObject('rlbTelSac').Visible := False;
          frxBanco.FindObject('rllTelSac').Visible := False;
          frxBanco.FindObject('rllLinDig').Visible := False;

          {If (blnSantan637_444p) Then
          Begin
            If Trim(strNumIns) <> '' Then
            Begin
              If strTipIns = '01' Then
                frxBanco.Script.Variables['NOMCED'] := strNomCed + '   ' + fMaskCNPJ(strNumIns)
              Else
                frxBanco.Script.Variables['NOMCED'] := strNomCed + '   ' + fMaskCPF(strNumIns);
            End
            Else
              frxBanco.Script.Variables['NOMCED'] := strNomCed;

            frxBanco.Script.Variables['ENDCED'] := strEndere;
            frxBanco.Script.Variables['SACAVA'] := IIF(fEmptyStr(fRetirarCaracteresEspeciais(strBenefi)), '', strBenefi);
            frxBanco.Script.Variables['ENDAVA'] := IIF(fEmptyStr(fRetirarCaracteresEspeciais(strBenefi)), '', strEndBen);
          End
          Else
          Begin}
            If Trim(strNumIns) <> '' Then
            Begin
              If strTipIns = '01' Then
                frxBanco.Script.Variables['NOMCED'] := IIF(fEmptyStr(strBenefi), strNomCed + '   ' + fMaskCNPJ(strNumIns), strBenefi)
              Else
                frxBanco.Script.Variables['NOMCED'] := IIF(fEmptyStr(strBenefi), strNomCed + '   ' + fMaskCPF(strNumIns), strBenefi);
            End
            Else
              frxBanco.Script.Variables['NOMCED'] := IIF(fEmptyStr(strBenefi), strNomCed, strBenefi);

            frxBanco.Script.Variables['ENDCED'] := IIF(fEmptyStr(strBenefi), strEndere, strEndBen);
            frxBanco.Script.Variables['SACAVA'] := IIF(fEmptyStr(strBenefi), '', strNomCed + IfThen(Not fEmptyStr(strNumIns),' - ' + IIF(strTipIns = '01', fMaskCNPJ(strNumIns), fMaskCPF(strNumIns)), ''));
            frxBanco.Script.Variables['ENDAVA'] := IIF(fEmptyStr(strBenefi), '', strEndere);
          //End;
          frxBanco.Script.Variables['USOBCO'] := '';

          If fEmptyStr(strDigAge) Then
          Begin
            strAgeDig := strNumAge + fStrZero(strCodCed, 7);
            Insert('/', strAgeDig, 5);
          End
          Else
          Begin
            strAgeDig := strNumAge + strDigAge + fStrZero(strCodCed, 7);
            Insert('-', strAgeDig, 5);
            Insert('/', strAgeDig, 7);
            Insert(' ', strAgeDig, 8);
            Insert('-', strAgeDig, 15);
          End;

          frxBanco.Script.Variables['BENEFI'] := 'Beneficiário';
          frxBanco.Script.Variables['BENEFI2']:= 'BENEFICIÁRIO';
          frxBanco.Script.Variables['ESPMOE'] := 'Esp. Moeda';
          frxBanco.Script.Variables['VALMOE'] := 'Valor da Moeda';
          frxBanco.Script.Variables['PAGADO'] := 'Pagador';
          frxBanco.Script.Variables['AGECED'] := strAgeDig;
          frxBanco.Script.Variables['NOMSAC'] := strNomSac;
          frxBanco.Script.Variables['DTAVEN'] := FormatDateTime('dd/mm/yyyy', dtaDtaVen);

          If blnParNum Then
            frxBanco.Script.Variables['NUMDOC'] := IfThen(strImprimirParcela = 'S', LeftStr(strNumDoc, Length(strNumDoc) - 1) +'-'+
                                                                                    fPadL(fRetNumParcela(RightStr(strNumDoc, 1)),003,'0')
                                                                                  , LeftStr(strNumDoc, Length(strNumDoc) - 1))
          Else
            frxBanco.Script.Variables['NUMDOC'] := IfThen(strImprimirParcela = 'S', strNumDoc, LeftStr(strNumDoc, Length(strNumDoc) - 1));

          frxBanco.Script.Variables['VALDOC'] := FormatFloat('R$ #,##0.00',fStrToFloat(strVlrTit)/100);
          frxBanco.Script.Variables['LOCEXT'] := '';
          frxBanco.Script.Variables['LOCPAG'] := 'PAGÁVEL EM QUALQUER BANCO.';
          frxBanco.Script.Variables['DTADOC'] := FormatDateTime('dd/mm/yyyy', dtaDtaEmi);
          frxBanco.Script.Variables['ESPDOC'] := 'DM';
          frxBanco.Script.Variables['DTAPRO'] := FormatDateTime('dd/mm/yyyy', dtaDtaPro);

          if Not blnSantan240p then
          Begin
            If strCodCar = '4' Then
              strCodCar := 'CSR'
            Else
              strCodCar := 'RCR';
          End;

          if Not blnSantan240p then
            strCodCar := 'COBRANCA SIMPLES - ' + strCodCar;

          If (blnSantan637_444p) Then
             strCodCar := '101';

          frxBanco.Script.Variables['CART02'] := strCodCar;
          frxBanco.Script.Variables['CARTEI'] := '';
          frxBanco.Script.Variables['ACEITE'] := IIF(strIdeAce = 'S', 'Sim', 'Não');
          frxBanco.Script.Variables['CEDENT'] := 'Cód. Beneficiário';

          strCaAgNs := strCodCar + '/';

          If ((RightStr(Trim(strCodCar), 2) = '16') Or (RightStr(Trim(strCodCar), 2) = '18')) And (Length(strNumCon) <= 6) Then
          Begin
            If (RightStr(Trim(strCodCar), 2) = '18') Then
            Begin
              strTmpNN := fStrZero(Copy(strNosNum, 1, Length(strNosNum)-1),17);
            End
            Else
            Begin
              strTmpNN := strNumCon + strNosNum;
              Insert('.', strTmpNN, 04);
              Insert('.', strTmpNN, 08);
              Insert('.', strTmpNN, 12);
              Insert('.', strTmpNN, 16);
              Insert('.', strTmpNN, 20);
            End;
          End
          Else If ((RightStr(Trim(strCodCar), 2) = '18')) And (Length(strNumCon) >= 7) Then
          Begin
            strTmpNN := strNumCon + RightStr(Trim(strNosNum), 10);
            Insert('.', strTmpNN, 3);
            Insert('.', strTmpNN, 7);
            Insert('.', strTmpNN, 11);
            Insert('.', strTmpNN, 15);
            Insert('.', strTmpNN, 19);
          End
          Else If (RightStr(Trim(strCodCar), 2) = '17') And (Length(strNumCon) >= 7) Then
          Begin
            strTmpNN := strNumCon + strNosNum;
            //Insert('.',strNossoNu, 3);
            //Insert('.',strNossoNu, 7);
            //Insert('.',strNossoNu, 11);
            //Insert('.',strNossoNu, 15);
            //Insert('.',strNossoNu, 19);
          End
          Else If (RightStr(Trim(strCodCar), 2) = '17') And (Length(strNumCon) = 6) Then
          Begin
            strTmpNN := strNosNum;
            Insert('-', strTmpNN, 12);
          End
          Else If ((RightStr(Trim(strCodCar), 2) = '12')) Then
          Begin
            strTmpNN := strNumCon + strNosNum;
            Insert('.', strTmpNN, 12);
          End
          Else
          Begin
            strTmpNN := strNumCon + strNosNum;
            Insert(' ', strTmpNN, 13);
          End;

          TfrxMemoView(frxBanco.FindObject('rllCarNN1')).Text := 'Carteira/Nosso Número';

          TfrxMemoView(frxBanco.FindObject('rllNN1')).Text := 'Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN2')).Text := 'Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN3')).Text := 'Nosso Número';

          frxBanco.Script.Variables['NOSNUM'] := strTmpNN;
          frxBanco.Script.Variables['CARNOSNUM'] := strCaAgNs + strTmpNN;

          frxBanco.Script.Variables['INST01'] := IIF(fltVlrMor > 0, 'MORA DIARIA DE ' + FormatFloat('R$ #,##0.00', fltVlrMor) + '         ', '') +
                                                 IIF(fltVlrMul > 0, 'APÓS O VENCIMENTO COBRAR MULTA DE ' + FormatFloat('R$ #,##0.00', fltVlrMul), '');

          If StrToIntDef(strPraPro,0) >= 1 Then
            frxBanco.Script.Variables['INST02'] := 'PROTESTAR NO ' + strPraPro + '° DIA ' + IIF(strTipDia = '1', 'ÚTIL', 'CORRIDO') + ' APÓS O VENCIMENTO'
          Else
            frxBanco.Script.Variables['INST02'] := '';

          frxBanco.Script.Variables['INST03'] := strInstr1;
          frxBanco.Script.Variables['INST04'] := strInstr2;
          frxBanco.Script.Variables['INST05'] := strInstr3;
          frxBanco.Script.Variables['INST06'] := strInstr4;
          frxBanco.Script.Variables['INST07'] := strInstr5;
          frxBanco.Script.Variables['INST08'] := '';
          frxBanco.Script.Variables['OUTACR'] := '';

          If Length(Trim(strNuInSa)) > 11 Then
            frxBanco.Script.Variables['INSSAC'] := fMaskCNPJ(strNuInSa)
          Else frxBanco.Script.Variables['INSSAC'] := fMaskCPF(strNuInSa);

          frxBanco.Script.Variables['ENDSAC'] := strEndSac + ' - ' + strBaiSac;
          frxBanco.Script.Variables['CIDSAC'] := fMaskCEP(strCep001) + ' - ' + strCidSac + ' - ' + strEstSac;

          frxBanco.Script.Variables['LINDIG'] := strLinDig;
          TfrxBarCodeView(frxBanco.FindObject('barCodigo')).Text := strCodBar;

          TfrxMemoView(frxBanco.FindObject('Memo93')).Text  := 'Beneficiário Final';
          TfrxMemoView(frxBanco.FindObject('Memo154')).Text := 'Beneficiário Final';
          TfrxMemoView(frxBanco.FindObject('Memo215')).Text := 'Beneficiário Final';

          TfrxBand(frxBanco.FindObject('rlbCompEntr')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrCut')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrN1')).Visible := Not (blnProEnt Or blnImpAgrup);
          TfrxBand(frxBanco.FindObject('rlbCompEntrN2')).Visible := Not (blnProEnt Or blnImpAgrup);

          {********************************************************}
          {* LAYOUT DE BOLETO EM DUAS VIAS (FICHA DE COMPENSAÇÃO E*}
          {* RECIBO DO PAGADOR                                    *}
          {*****************************************************GD*}
          if fCfgSis('NOVLAY', varString) = 'D' then
          begin
            TfrxBand(frxBanco.FindObject('rlbFichaCaixa')).Visible    := False;
            TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Visible := False;
            if not blnImpAgrup  then
              TfrxBand(frxBanco.FindObject('rlbCompEntrN1')).Visible := False;

            If (Not fEmptyStr(fCfgSis('IMGBOL'))) and FileExists(fCfgSis('IMGBOL')) Then
            begin
              TfrxBand(frxBanco.FindObject('rlbReciboSac')).Visible              := False;
              TfrxBand(frxBanco.FindObject('rlbReciboPagadorComImagem')).Visible := True;
              TfrxPictureView(frxBanco.FindObject('imgLogo2')).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoSantander.bmp');
              TfrxPictureView(frxBanco.FindObject('imgLogoEmpresa')).Picture.LoadFromFile(fCfgSis('IMGBOL'));
            end;
          end;

          If blnProEnt Then
            TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Height := TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Height + 18;
        End;

      Except
        On E: Exception Do
        Begin
          MessageDlg(E.Message,mtError,[mbOK],0);
          Result := False;
        End;
      End;
    End;

    LExecutarImpCodBar := False;
  End

  Else If (strIdeBan = '748') And Not Assigned(TRetornoBoletoBancoSicredi(LRetornoRegistroBoletoApi)) Then
  Begin
    Result := fGeLiDi748;

    If Result Then
    Begin
      If Not FileExists(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoSicredi.bmp') Then
      Begin
        FreeAndNil(qryCfgRel);
        pMensagemOk('O logo ' + ExtractFilePath(Application.ExeName) + 'LogoBoletos\LogoSicredi.bmp deve existir na pasta indicada.');
        Exit;
      End;

      Try
        pCriarFormularios(TfrmQckBancos, frmQckBancos);

        pCarregarLayImp(frmQckBancos);

        With frmQckBancos Do
        Begin

          If ( blnBolEnvEmail And (fCampoTabela('CLI_BOLSEN', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False) = 'S') and (blnBolPdf) And (MatchStr(fCfgSis('NOVLAY', varString), ['P','C','U'])) )
             Or
             ( (blnEnvioDeEmailAutomatico) And (fCampoTabela('CLI_BOLSEN', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False) = 'S') and (blnBolPdf) And (fCfgSis('NOVLAY', varString) = 'P') ) then
          begin
            CpfCnpj := fCampoTabela('CLI_C_G_C_', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False);
            CpfCnpj := Copy(CpfCnpj, 1, 5);

            if not fEmptyStr(CpfCnpj) then
            begin
              frmQckBancos.frxPDFExport.PdfA := False;
              frmQckBancos.frxPDFExport.UserPassword := AnsiString(CpfCnpj);
              frmQckBancos.frxPDFExport.OwnerPassword := AnsiString(CpfCnpj);
              frmQckBancos.frxPDFExport.ProtectionFlags := [ePrint];
            end;
          end;

          frxPDFExport.ShowDialog   := Not blnEnvioDeEmailAutomatico;
          frxPDFExport.ShowProgress := Not blnEnvioDeEmailAutomatico;

          If strEspeci = 'AG' Then
            frxAgrupamento.DataSet := fQryAgrupamento(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, strCodCli)
          Else
            frxAgrupamento.DataSet := fCriaQuery;

          blnImpAgrup := (Not frxAgrupamento.DataSet.IsEmpty) And (fCfgSis('MDBLAG', varInteger) = 2);
          If blnImpAgrup Then
          Begin
            TfrxBand(frxBanco.FindObject('rlbAgrupamento')).Visible := True;
            TfrxBand(frxBanco.FindObject('rlbReciboSac')).Visible := False;
            TfrxBand(frxBanco.FindObject('rlbReciboSacCut')).Visible := False;
            If (Not fEmptyStr(fCfgSis('IMGBOL'))) and FileExists(fCfgSis('IMGBOL')) Then
              TfrxPictureView(frxBanco.FindObject('imgLogo')).Picture.LoadFromFile(fCfgSis('IMGBOL'));

            frxBanco.Script.Variables['NUMPARC'] := fRetNumParcela(RightStr(strNumDoc, 1));
            frxBanco.Script.Variables['TOTPARC'] := fQtdParcelas(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, 'AG', strCodCli);
            frxBanco.Script.Variables['MAILCLI'] := strMailCli;
          End;

          For intCont := 1 To 4 Do
            TfrxPictureView(frxBanco.FindObject('imgLog' + IntToStr(intCont))).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoSicredi.bmp');

          frxBanco.Script.Variables['CODBCO'] := '748-X';

          frxBanco.FindObject('rlbTelSac').Visible := False;
          frxBanco.FindObject('rllTelSac').Visible := False;
          frxBanco.FindObject('rllLinDig').Visible := False;

          If Trim(strNumIns) <> '' Then
          Begin
            If strTipIns = '01' Then
              frxBanco.Script.Variables['NOMCED'] := IIF(fEmptyStr(strBenefi), strNomCed + '   ' + fMaskCNPJ(strNumIns), strBenefi)
            Else
              frxBanco.Script.Variables['NOMCED'] := IIF(fEmptyStr(strBenefi), strNomCed + '   ' + fMaskCPF(strNumIns), strBenefi);
          End
          Else
            frxBanco.Script.Variables['NOMCED'] := IIF(fEmptyStr(strBenefi), strNomCed, strBenefi);

          frxBanco.Script.Variables['ENDCED'] := IIF(fEmptyStr(strBenefi), strEndere, strEndBen);
          frxBanco.Script.Variables['SACAVA'] := IIF(fEmptyStr(strBenefi), '', strNomCed + IfThen(Not fEmptyStr(strNumIns), ' - ' + IIF(strTipIns = '01', fMaskCNPJ(strNumIns), fMaskCPF(strNumIns)), ''));
          frxBanco.Script.Variables['ENDAVA'] := IIF(fEmptyStr(strBenefi), '', strEndere);
          frxBanco.Script.Variables['USOBCO'] := '';

          strAgeDig := strNumAge + fStrZero(strCodCed, 7);
          Insert('.', strAgeDig, 5);
          Insert('.', strAgeDig, 8);

          frxBanco.Script.Variables['BENEFI'] := 'Beneficiário';
          frxBanco.Script.Variables['BENEFI2']:= 'BENEFICIÁRIO';
          frxBanco.Script.Variables['ESPMOE'] := 'Esp. Moeda';
          frxBanco.Script.Variables['VALMOE'] := 'Valor da Moeda';
          frxBanco.Script.Variables['PAGADO'] := 'Pagador';
          frxBanco.Script.Variables['AGECED'] := strAgeDig;
          frxBanco.Script.Variables['NOMSAC'] := strNomSac;
          frxBanco.Script.Variables['DTAVEN'] := FormatDateTime('dd/mm/yyyy', dtaDtaVen);
          frxBanco.Script.Variables['NUMDOC'] := IfThen(strImprimirParcela = 'S', strNumDoc, LeftStr(strNumDoc, Length(strNumDoc) - 1));
          frxBanco.Script.Variables['VALDOC'] := FormatFloat('R$ #,##0.00',fStrToFloat(strVlrTit)/100);
          frxBanco.Script.Variables['LOCEXT'] := '';
          frxBanco.Script.Variables['LOCPAG'] := 'PAGÁVEL EM QUALQUER BANCO.';
          frxBanco.Script.Variables['DTADOC'] := FormatDateTime('dd/mm/yyyy', dtaDtaEmi);
          frxBanco.Script.Variables['ESPDOC'] := 'A';
          frxBanco.Script.Variables['DTAPRO'] := FormatDateTime('dd/mm/yyyy', dtaDtaPro);
          frxBanco.Script.Variables['CARTEI'] := strCodCar;
          frxBanco.Script.Variables['CART02'] := '';
          frxBanco.Script.Variables['ACEITE'] := IIF(strIdeAce = 'S', 'S', 'N');
          frxBanco.Script.Variables['CEDENT'] := 'Cód. Beneficiário';

          strTmpNN := strNosNum;
          Insert('/', strTmpNN, 3);
          Insert('-', strTmpNN, 10);

          TfrxMemoView(frxBanco.FindObject('rllCarNN1')).Text := 'Cart./Nosso Número';

          TfrxMemoView(frxBanco.FindObject('rllNN1')).Text := 'Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN2')).Text := 'Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN3')).Text := 'Nosso Número';

          frxBanco.Script.Variables['NOSNUM'] := strTmpNN;
          frxBanco.Script.Variables['CARNOSNUM'] := strCaAgNs + strTmpNN;

          frxBanco.Script.Variables['INST01'] := IIF(fltVlrMor > 0, 'APÓS O VENCIMENTO COBRAR ' + FormatFloat('R$ #,##0.00', fltVlrMor) + ' POR DIA DE ATRASO ', '') +
                                                 IIF(fltVlrMul > 0, 'APÓS O VENCIMENTO COBRAR MULTA DE ' + FormatFloat('R$ #,##0.00', fltVlrMul), '');

          If StrToIntDef(strPraPro,0) >= 1 Then
            frxBanco.Script.Variables['INST02'] := 'PROTESTAR APÓS ' + strPraPro + ' DIAS ' + IIF(StrToInt(strPraPro) > 4, 'CORRIDOS', 'ÚTEIS') + ' DO VENCIMENTO'
          Else
            frxBanco.Script.Variables['INST02'] := '';

          frxBanco.Script.Variables['INST03'] := strInstr1;
          frxBanco.Script.Variables['INST04'] := strInstr2;
          frxBanco.Script.Variables['INST05'] := strInstr3;
          frxBanco.Script.Variables['INST06'] := strInstr4;
          frxBanco.Script.Variables['INST07'] := strInstr5;
          frxBanco.Script.Variables['INST08'] := '';
          frxBanco.Script.Variables['OUTACR'] := '';

          If Length(Trim(strNuInSa)) > 11 Then
            frxBanco.Script.Variables['INSSAC'] := fMaskCNPJ(strNuInSa)
          Else frxBanco.Script.Variables['INSSAC'] := fMaskCPF(strNuInSa);

          frxBanco.Script.Variables['ENDSAC'] := strEndSac + ' - ' + strBaiSac;
          frxBanco.Script.Variables['CIDSAC'] := fMaskCEP(strCep001) + ' - ' + strCidSac + ' - ' + strEstSac;

          frxBanco.Script.Variables['LINDIG'] := strLinDig;
          TfrxBarCodeView(frxBanco.FindObject('barCodigo')).Text := strCodBar;

          TfrxBand(frxBanco.FindObject('rlbCompEntr')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrCut')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrN1')).Visible := Not (blnProEnt Or blnImpAgrup);
          TfrxBand(frxBanco.FindObject('rlbCompEntrN2')).Visible := Not (blnProEnt Or blnImpAgrup);

          {********************************************************}
          {* LAYOUT DE BOLETO EM DUAS VIAS (FICHA DE COMPENSAÇÃO E*}
          {* RECIBO DO PAGADOR                                    *}
          {*****************************************************GD*}
          if fCfgSis('NOVLAY', varString) = 'D' then
          begin
            TfrxBand(frxBanco.FindObject('rlbFichaCaixa')).Visible    := False;
            TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Visible := False;
            if not blnImpAgrup  then
              TfrxBand(frxBanco.FindObject('rlbCompEntrN1')).Visible := False;

            If (Not fEmptyStr(fCfgSis('IMGBOL'))) and FileExists(fCfgSis('IMGBOL')) Then
            begin
              TfrxBand(frxBanco.FindObject('rlbReciboSac')).Visible              := False;
              TfrxBand(frxBanco.FindObject('rlbReciboPagadorComImagem')).Visible := True;
              TfrxPictureView(frxBanco.FindObject('imgLogo2')).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoSicredi.bmp');
              TfrxPictureView(frxBanco.FindObject('imgLogoEmpresa')).Picture.LoadFromFile(fCfgSis('IMGBOL'));
            end;
          end;

          If blnProEnt Then
            TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Height := TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Height + 18;
        End;

      Except
        On E: Exception Do
        Begin
          MessageDlg(E.Message,mtError,[mbOK],0);
          Result := False;
        End;
      End;
    End;

    LExecutarImpCodBar := False;
  End

  // 637 444p - layout proprio
  Else If (strIdeBan = '637') And (strBcoini = '637LP444p') Then
  Begin
    Result := fGeLiDi637LP;

    If Result Then
    Begin
      If Not ValidaLogoBoleto('LogoBoletos\LogoSofisa.bmp') Then
      Begin
        FreeAndNil(qryCfgRel);
        Result := False;
        Exit;
      End;

      Try
        pCriarFormularios(TfrmQckBancos, frmQckBancos);

        pCarregarLayImp(frmQckBancos);

        With frmQckBancos Do
        Begin

          If ( blnBolEnvEmail And blnEnvioFaturamento And (fCampoTabela('CLI_BOLSEN', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False) = 'S') and (blnBolPdf) And (MatchStr(fCfgSis('NOVLAY', varString), ['P','C','U'])) )
             Or
             ( (blnEnvioDeEmailAutomatico) And (fCampoTabela('CLI_BOLSEN', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False) = 'S') and (blnBolPdf) And (fCfgSis('NOVLAY', varString) = 'P') ) then
          begin
            CpfCnpj := fCampoTabela('CLI_C_G_C_', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False);
            CpfCnpj := Copy(CpfCnpj, 1, 5);

            if not fEmptyStr(CpfCnpj) then
            begin
              frmQckBancos.frxPDFExport.PdfA := False;
              frmQckBancos.frxPDFExport.UserPassword := AnsiString(CpfCnpj);
              frmQckBancos.frxPDFExport.OwnerPassword := AnsiString(CpfCnpj);
              frmQckBancos.frxPDFExport.ProtectionFlags := [ePrint];
            end;
          end;

          frxPDFExport.ShowDialog   := Not blnEnvioDeEmailAutomatico;
          frxPDFExport.ShowProgress := Not blnEnvioDeEmailAutomatico;

          If strEspeci = 'AG' Then
            frxAgrupamento.DataSet := fQryAgrupamento(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, strCodCli)
          Else
            frxAgrupamento.DataSet := fCriaQuery;

          blnImpAgrup := (Not frxAgrupamento.DataSet.IsEmpty) And (fCfgSis('MDBLAG', varInteger) = 2);
          If blnImpAgrup Then
          Begin
            TfrxBand(frxBanco.FindObject('rlbAgrupamento')).Visible := True;
            TfrxBand(frxBanco.FindObject('rlbReciboSac')).Visible := False;
            TfrxBand(frxBanco.FindObject('rlbReciboSacCut')).Visible := False;
            If (Not fEmptyStr(fCfgSis('IMGBOL'))) and FileExists(fCfgSis('IMGBOL')) Then
              TfrxPictureView(frxBanco.FindObject('imgLogo')).Picture.LoadFromFile(fCfgSis('IMGBOL'));

            frxBanco.Script.Variables['NUMPARC'] := fRetNumParcela(RightStr(strNumDoc, 1));
            frxBanco.Script.Variables['TOTPARC'] := fQtdParcelas(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, 'AG', strCodCli);
            frxBanco.Script.Variables['MAILCLI'] := strMailCli;
          End;

          For intCont := 1 To 4 Do
            TfrxPictureView(frxBanco.FindObject('imgLog' + IntToStr(intCont))).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoSofisa.bmp');

          frxBanco.Script.Variables['CODBCO'] := '637-8';

          frxBanco.FindObject('rlbTelSac').Visible := False;
          frxBanco.FindObject('rllTelSac').Visible := False;
          frxBanco.FindObject('rllLinDig').Visible := False;

          If Trim(strNumIns) <> '' Then
          Begin
            If strTipIns = '01' Then
              frxBanco.Script.Variables['NOMCED'] := IIF(fEmptyStr(strBenefi), strNomCed + '   ' + fMaskCNPJ(strNumIns), strBenefi)
            Else
              frxBanco.Script.Variables['NOMCED'] := IIF(fEmptyStr(strBenefi), strNomCed + '   ' + fMaskCPF(strNumIns), strBenefi);
          End
          Else
            frxBanco.Script.Variables['NOMCED'] := IIF(fEmptyStr(strBenefi), strNomCed, strBenefi);

          frxBanco.Script.Variables['ENDCED'] := IIF(fEmptyStr(strBenefi), strEndere, strEndBen);
          frxBanco.Script.Variables['SACAVA'] := IIF(fEmptyStr(strBenefi), '', strNomCed + IfThen(Not fEmptyStr(strNumIns), ' - ' + IIF(strTipIns = '01', fMaskCNPJ(strNumIns), fMaskCPF(strNumIns)), ''));
          frxBanco.Script.Variables['ENDAVA'] := IIF(fEmptyStr(strBenefi), '', strEndere);
          frxBanco.Script.Variables['USOBCO'] := '';

          If fEmptyStr(strAgeDig) Then
          Begin
            strAgeDig := strNumAge + fStrZero(strCodCed, 9);
            Insert('/', strAgeDig, 5);
          End
          Else
          Begin
            strAgeDig := strNumAge + strDigAge + fStrZero(strCodCed, 7);
            Insert('/', strAgeDig, 6);
          End;

          TfrxMemoView(frxBanco.FindObject('memo73')).Text := 'Informações de responsabilidade do beneficiário';
          TfrxMemoView(frxBanco.FindObject('memo74')).Text := 'Informações de responsabilidade do beneficiário';
          TfrxMemoView(frxBanco.FindObject('memo75')).Text := 'Informações de responsabilidade do beneficiário';

          frxBanco.Script.Variables['BENEFI'] := 'Beneficiário';
          frxBanco.Script.Variables['BENEFI2']:= 'BENEFICIÁRIO';
          frxBanco.Script.Variables['ESPMOE'] := 'Esp. Moeda';
          frxBanco.Script.Variables['VALMOE'] := 'Valor da Moeda';
          frxBanco.Script.Variables['PAGADO'] := 'Pagador';
          frxBanco.Script.Variables['AGECED'] := strAgeDig;
          frxBanco.Script.Variables['NOMSAC'] := strNomSac;
          frxBanco.Script.Variables['DTAVEN'] := FormatDateTime('dd/mm/yyyy', dtaDtaVen);
          frxBanco.Script.Variables['NUMDOC'] := IfThen(strImprimirParcela = 'S', strNumDoc, LeftStr(strNumDoc, Length(strNumDoc) - 1));
          frxBanco.Script.Variables['VALDOC'] := FormatFloat('R$ #,##0.00',fStrToFloat(strVlrTit)/100);
          frxBanco.Script.Variables['LOCEXT'] := '';
          frxBanco.Script.Variables['LOCPAG'] := 'PAGÁVEL EM QUALQUER BANCO.';
          frxBanco.Script.Variables['DTADOC'] := FormatDateTime('dd/mm/yyyy', dtaDtaEmi);
          frxBanco.Script.Variables['ESPDOC'] := 'A';
          frxBanco.Script.Variables['DTAPRO'] := FormatDateTime('dd/mm/yyyy', dtaDtaPro);
          frxBanco.Script.Variables['CARTEI'] := strCodCar;
          frxBanco.Script.Variables['CART02'] := '';
          frxBanco.Script.Variables['ACEITE'] := IIF(strIdeAce = 'S', 'Sim', 'Não');
          frxBanco.Script.Variables['CEDENT'] := 'Cód. Beneficiário';

          strCaAgNs := strCodCar + '/';

          strTmpNN := strNosNum;
          strTmpNN := strNumAge + strDigAge + '/' + strCodCar + '/' + strTmpNN;
          Insert('-', strTmpNN, 21);

          TfrxMemoView(frxBanco.FindObject('rllCarNN1')).Text := 'Cart./Nosso Número';

          TfrxMemoView(frxBanco.FindObject('rllNN1')).Text := 'Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN2')).Text := 'Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN3')).Text := 'Nosso Número';

          frxBanco.Script.Variables['NOSNUM'] := strTmpNN;
          frxBanco.Script.Variables['CARNOSNUM'] := strCaAgNs + strTmpNN;

          frxBanco.Script.Variables['INST01'] := IIF(fltVlrMul > 0, 'APÓS O VENCIMENTO, COBRAR MULTA DE ' + FormatFloat('#,##0.00', fltVlrMul) + '% DO VALOR DO TÍTULO.          ', '');

          If fltVlrMor > 0 then
          begin
            frxBanco.Script.Variables['INST02'] := 'MORA DE ' + FormatFloat('R$ #,##0.00', fltVlrMor) + ' AO DIA, A PARTIR DE ' + FormatDateTime('dd/mm/yyyy', dtaDtaVen + IIF(strDiaMora = '0', 1, strToInt(strDiaMora)) );
            If StrToIntDef(strPraPro,0) >= 1 Then
              frxBanco.Script.Variables['INST03'] := 'SE NÃO PAGO, ENVIAR PARA CARTÓRIO ' + strPraPro + IIF(StrToInt(strPraPro) = 1,' DIA CORRIDO ', ' DIAS CORRIDOS ') + 'APÓS O VENCIMENTO'
            Else
              frxBanco.Script.Variables['INST03'] := '';

            frxBanco.Script.Variables['INST04'] := strInstr1;
            frxBanco.Script.Variables['INST05'] := strInstr2;
            frxBanco.Script.Variables['INST06'] := strInstr3;
            frxBanco.Script.Variables['INST07'] := strInstr4;
            frxBanco.Script.Variables['INST08'] := strInstr5;
          end
          else
          begin
            If StrToIntDef(strPraPro,0) >= 1 Then
              frxBanco.Script.Variables['INST02'] := 'SE NÃO PAGO, ENVIAR PARA CARTÓRIO ' + strPraPro + IIF(StrToInt(strPraPro) = 1,' DIA CORRIDO ', ' DIAS CORRIDOS ') + 'APÓS O VENCIMENTO'
            Else
              frxBanco.Script.Variables['INST02'] := '';

            frxBanco.Script.Variables['INST03'] := strInstr1;
            frxBanco.Script.Variables['INST04'] := strInstr2;
            frxBanco.Script.Variables['INST05'] := strInstr3;
            frxBanco.Script.Variables['INST06'] := strInstr4;
            frxBanco.Script.Variables['INST07'] := strInstr5;
            frxBanco.Script.Variables['INST08'] := '';
          end;
          frxBanco.Script.Variables['OUTACR'] := '';

          If Length(Trim(strNuInSa)) > 11 Then
            frxBanco.Script.Variables['INSSAC'] := fMaskCNPJ(strNuInSa)
          Else frxBanco.Script.Variables['INSSAC'] := fMaskCPF(strNuInSa);

          frxBanco.Script.Variables['ENDSAC'] := strEndSac + ' - ' + strBaiSac;
          frxBanco.Script.Variables['CIDSAC'] := fMaskCEP(strCep001) + ' - ' + strCidSac + ' - ' + strEstSac;

          frxBanco.Script.Variables['LINDIG'] := strLinDig;
          TfrxBarCodeView(frxBanco.FindObject('barCodigo')).Text := strCodBar;

          TfrxBand(frxBanco.FindObject('rlbCompEntr')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrCut')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrN1')).Visible := Not blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrN2')).Visible := False;

          {********************************************************}
          {* LAYOUT DE BOLETO EM DUAS VIAS (FICHA DE COMPENSAÇÃO E*}
          {* RECIBO DO PAGADOR                                    *}
          {*****************************************************GD*}
          if fCfgSis('NOVLAY', varString) = 'D' then
          begin
            TfrxBand(frxBanco.FindObject('rlbFichaCaixa')).Visible    := False;
            TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Visible := False;
            if not blnImpAgrup  then
              TfrxBand(frxBanco.FindObject('rlbCompEntrN1')).Visible := False;

            If (Not fEmptyStr(fCfgSis('IMGBOL'))) and FileExists(fCfgSis('IMGBOL')) Then
            begin
              TfrxBand(frxBanco.FindObject('rlbReciboSac')).Visible              := False;
              TfrxBand(frxBanco.FindObject('rlbReciboPagadorComImagem')).Visible := True;
              TfrxPictureView(frxBanco.FindObject('imgLogo2')).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoSofisa.bmp');
              TfrxPictureView(frxBanco.FindObject('imgLogoEmpresa')).Picture.LoadFromFile(fCfgSis('IMGBOL'));
            end;
          end;

          If blnProEnt Then
            TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Height := TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Height + 18;
        End;

      Except
        On E: Exception Do
        Begin
          MessageDlg(E.Message,mtError,[mbOK],0);

          VS_ErroGeraBoletoLaser := E.Message;

          Result := False;
        End;
      End;
    End;

    LExecutarImpCodBar := False;
  End

  {*****************************}
  {* BANCO MERCANTIL DO BRASIL *}
  {**************************JU*}
  Else If strIdeBan = '389' Then
  Begin
    Result := fProArq389;

    If Result Then
    Begin
      If Not FileExists(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoMercantil.bmp') Then
      Begin
        FreeAndNil(qryCfgRel);
        pMensagemOk('O logo ' + ExtractFilePath(Application.ExeName) + 'LogoBoletos\LogoMercantil.bmp deve existir na pasta indicada.');
        Exit;
      End;

      Try
        pCriarFormularios(TfrmQckBancos, frmQckBancos);

        With frmQckBancos Do
        Begin
          frxPDFExport.ShowDialog   := Not blnEnvioDeEmailAutomatico;
          frxPDFExport.ShowProgress := Not blnEnvioDeEmailAutomatico;

          If strEspeci = 'AG' Then
            frxAgrupamento.DataSet := fQryAgrupamento(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, strCodCli)
          Else
            frxAgrupamento.DataSet := fCriaQuery;

          blnImpAgrup := (Not frxAgrupamento.DataSet.IsEmpty) And (fCfgSis('MDBLAG', varInteger) = 2);
          If blnImpAgrup Then
          Begin
            TfrxBand(frxBanco.FindObject('rlbAgrupamento')).Visible := True;
            TfrxBand(frxBanco.FindObject('rlbReciboSac')).Visible := False;
            TfrxBand(frxBanco.FindObject('rlbReciboSacCut')).Visible := False;
            If (Not fEmptyStr(fCfgSis('IMGBOL'))) and FileExists(fCfgSis('IMGBOL')) Then
              TfrxPictureView(frxBanco.FindObject('imgLogo')).Picture.LoadFromFile(fCfgSis('IMGBOL'));

            frxBanco.Script.Variables['NUMPARC'] := fRetNumParcela(RightStr(strNumDoc, 1));
            frxBanco.Script.Variables['TOTPARC'] := fQtdParcelas(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, 'AG', strCodCli);
            frxBanco.Script.Variables['MAILCLI'] := strMailCli;
          End;

          For intCont := 1 To 4 Do
            TfrxPictureView(frxBanco.FindObject('imgLog' + IntToStr(intCont))).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoMercantil.bmp');

          frxBanco.Script.Variables['CODBCO'] := '389-1';

          frxBanco.FindObject('rlbTelSac').Visible := False;
          frxBanco.FindObject('rllTelSac').Visible := False;
          frxBanco.FindObject('rllLinDig').Visible := False;

          If Trim(strNumIns) <> '' Then
          Begin
            If strTipIns = '01' Then
              frxBanco.Script.Variables['NOMCED'] := strNomCed + '   ' + fMaskCNPJ(strNumIns)
            Else
              frxBanco.Script.Variables['NOMCED'] := strNomCed + '   ' + fMaskCPF(strNumIns);
          End
          Else
            frxBanco.Script.Variables['NOMCED'] := strNomCed;

          frxBanco.Script.Variables['ENDCED'] := strEndere;
          frxBanco.Script.Variables['ENDAVA'] := '';
          frxBanco.Script.Variables['USOBCO'] := '';

          If fEmptyStr(strDigAge) Then
          Begin
            strAgeDig := strNumAge + fStrZero(strCodCed, 7);
            Insert('/', strAgeDig, 5);
          End
          Else
          Begin
            strAgeDig := strNumAge + strDigAge + fStrZero(strCodCed, 7);
            Insert('-', strAgeDig, 5);
            Insert('/', strAgeDig, 7);
            Insert(' ', strAgeDig, 8);
            Insert('-', strAgeDig, 15);
          End;

          frxBanco.Script.Variables['BENEFI'] := 'Beneficiário';
          frxBanco.Script.Variables['BENEFI2']:= 'BENEFICIÁRIO';
          frxBanco.Script.Variables['ESPMOE'] := 'Esp. Moeda';
          frxBanco.Script.Variables['VALMOE'] := 'Valor da Moeda';
          frxBanco.Script.Variables['PAGADO'] := 'Pagador';
          frxBanco.Script.Variables['AGECED'] := strAgeDig;
          frxBanco.Script.Variables['NOMSAC'] := strNomSac;
          frxBanco.Script.Variables['DTAVEN'] := FormatDateTime('dd/mm/yyyy', dtaDtaVen);
          frxBanco.Script.Variables['NUMDOC'] := IfThen(strImprimirParcela = 'S', strNumDoc, LeftStr(strNumDoc, Length(strNumDoc) - 1));
          frxBanco.Script.Variables['VALDOC'] := FormatFloat('R$ #,##0.00',fStrToFloat(strVlrTit)/100);
          frxBanco.Script.Variables['LOCEXT'] := '';
          frxBanco.Script.Variables['LOCPAG'] := 'PAGÁVEL EM QUALQUER BANCO.';
          frxBanco.Script.Variables['DTADOC'] := FormatDateTime('dd/mm/yyyy', dtaDtaEmi);
          frxBanco.Script.Variables['ESPDOC'] := 'DM';
          frxBanco.Script.Variables['DTAPRO'] := FormatDateTime('dd/mm/yyyy', dtaDtaPro);

          frxBanco.Script.Variables['CART02'] := '';
          frxBanco.Script.Variables['CARTEI'] := strCodCar;//'01';
          frxBanco.Script.Variables['ACEITE'] := IIF(strIdeAce = 'S', 'Sim', 'Não');
          frxBanco.Script.Variables['CEDENT'] := 'Cód. Beneficiário';
          frxBanco.Script.Variables['SACAVA'] := '';

          strCaAgNs := strCodCar + '/';

          If ((RightStr(Trim(strCodCar), 2) = '16') Or (RightStr(Trim(strCodCar), 2) = '18')) And (Length(strNumCon) <= 6) Then
          Begin
            If (RightStr(Trim(strCodCar), 2) = '18') Then
            Begin
              strTmpNN := fStrZero(Copy(strNosNum, 1, Length(strNosNum)-1),17);
            End
            Else
            Begin
              strTmpNN := strNumCon + strNosNum;
              Insert('.', strTmpNN, 04);
              Insert('.', strTmpNN, 08);
              Insert('.', strTmpNN, 12);
              Insert('.', strTmpNN, 16);
              Insert('.', strTmpNN, 20);
            End;
          End
          Else If ((RightStr(Trim(strCodCar), 2) = '18')) And (Length(strNumCon) >= 7) Then
          Begin
            strTmpNN := strNumCon + RightStr(Trim(strNosNum), 10);
            Insert('.', strTmpNN, 3);
            Insert('.', strTmpNN, 7);
            Insert('.', strTmpNN, 11);
            Insert('.', strTmpNN, 15);
            Insert('.', strTmpNN, 19);
          End
          Else If (RightStr(Trim(strCodCar), 2) = '17') And (Length(strNumCon) >= 7) Then
          Begin
            strTmpNN := strNumCon + strNosNum;
            //Insert('.',strNossoNu, 3);
            //Insert('.',strNossoNu, 7);
            //Insert('.',strNossoNu, 11);
            //Insert('.',strNossoNu, 15);
            //Insert('.',strNossoNu, 19);
          End
          Else If (RightStr(Trim(strCodCar), 2) = '17') And (Length(strNumCon) = 6) Then
          Begin
            strTmpNN := strNosNum;
            Insert('-', strTmpNN, 12);
          End
          Else If ((RightStr(Trim(strCodCar), 2) = '12')) Then
          Begin
            strTmpNN := strNumCon + strNosNum;
            Insert('.', strTmpNN, 12);
          End
          Else
          Begin
            strTmpNN := strNumCon + strNosNum;
            Insert(' ', strTmpNN, 13);
          End;

          TfrxMemoView(frxBanco.FindObject('rllCarNN1')).Text := 'Carteira/Nosso Número';

          TfrxMemoView(frxBanco.FindObject('rllNN1')).Text := 'Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN2')).Text := 'Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN3')).Text := 'Nosso Número';

          frxBanco.Script.Variables['NOSNUM'] := LeftStr(strTmpNN, 11);
          frxBanco.Script.Variables['CARNOSNUM'] := strCaAgNs + strTmpNN;

          frxBanco.Script.Variables['INST01'] := IIF(fltVlrMor > 0, 'MORA DIARIA DE ' + FormatFloat('R$ #,##0.00', fltVlrMor) + '         ', '') +
                                                 IIF(fltVlrMul > 0, 'APÓS O VENCIMENTO COBRAR MULTA DE ' + FormatFloat('R$ #,##0.00', fltVlrMul), '');

//          If StrToIntDef(strPraPro,0) >= 1 Then
//            frxBanco.Script.Variables['INST02'] := 'PROTESTAR NO ' + strPraPro + '° DIA ' + IIF(strTipDia = '1', 'ÚTIL', 'CORRIDO') + ' APÓS O VENCIMENTO'
//          Else
          frxBanco.Script.Variables['INST02'] := '';

          frxBanco.Script.Variables['INST03'] := strInstr1;
          frxBanco.Script.Variables['INST04'] := strInstr2;
          frxBanco.Script.Variables['INST05'] := strInstr3;
          frxBanco.Script.Variables['INST06'] := strInstr4;
          frxBanco.Script.Variables['INST07'] := strInstr5;
          frxBanco.Script.Variables['INST08'] := '';
          frxBanco.Script.Variables['OUTACR'] := '';

          If Length(Trim(strNuInSa)) > 11 Then
            frxBanco.Script.Variables['INSSAC'] := fMaskCNPJ(strNuInSa)
          Else frxBanco.Script.Variables['INSSAC'] := fMaskCPF(strNuInSa);

          frxBanco.Script.Variables['ENDSAC'] := strEndSac + ' - ' + strBaiSac;
          frxBanco.Script.Variables['CIDSAC'] := fMaskCEP(strCep001) + ' - ' + strCidSac + ' - ' + strEstSac;

          frxBanco.Script.Variables['LINDIG'] := strLinDig;
          TfrxBarCodeView(frxBanco.FindObject('barCodigo')).Text := strCodBar;

          TfrxBand(frxBanco.FindObject('rlbCompEntr')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrCut')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrN1')).Visible := Not (blnProEnt Or blnImpAgrup);
          TfrxBand(frxBanco.FindObject('rlbCompEntrN2')).Visible := Not (blnProEnt Or blnImpAgrup);

          If blnProEnt Then
            TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Height := TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Height + 18;
        End;

      Except
        On E: Exception Do
        Begin
          MessageDlg(E.Message,mtError,[mbOK],0);
          Result := False;
        End;
      End;

      LExecutarImpCodBar := False;
    End;

  End

  {****************}
  {* BANCO CECRED *}
  {*REQ-29077***JU*}
  Else If strIdeBan = '085' Then
  Begin
    Result := fGeLiDi085;

    If Result Then
    Begin
      If Not FileExists(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoCecred.bmp') Then
      Begin
        FreeAndNil(qryCfgRel);
        pMensagemOk('O logo ' + ExtractFilePath(Application.ExeName) + 'LogoBoletos\LogoCecred.bmp deve existir na pasta indicada.');
        Exit;
      End;

      Try
        pCriarFormularios(TfrmQckBancos, frmQckBancos);

        With frmQckBancos Do
        Begin
          frxPDFExport.ShowDialog   := Not blnEnvioDeEmailAutomatico;
          frxPDFExport.ShowProgress := Not blnEnvioDeEmailAutomatico;

          If strEspeci = 'AG' Then
          Begin
            frxAgrupamento.DataSet := fQryAgrupamento(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, strCodCli);

            If (fCfgSis('MDBLAG', varInteger) = 1) Then
              LDuplicatasAgrupadas := DuplicatasAgrupadas(frxAgrupamento.DataSet);

          End Else frxAgrupamento.DataSet := fCriaQuery;


          blnImpAgrup := (Not frxAgrupamento.DataSet.IsEmpty) And (fCfgSis('MDBLAG', varInteger) = 2);
          If blnImpAgrup Then
          Begin
            TfrxBand(frxBanco.FindObject('rlbAgrupamento')).Visible := True;
            TfrxBand(frxBanco.FindObject('rlbReciboSac')).Visible := False;
            TfrxBand(frxBanco.FindObject('rlbReciboSacCut')).Visible := False;
            If (Not fEmptyStr(fCfgSis('IMGBOL'))) and FileExists(fCfgSis('IMGBOL')) Then
              TfrxPictureView(frxBanco.FindObject('imgLogo')).Picture.LoadFromFile(fCfgSis('IMGBOL'));

            frxBanco.Script.Variables['NUMPARC'] := fRetNumParcela(RightStr(strNumDoc, 1));
            frxBanco.Script.Variables['TOTPARC'] := fQtdParcelas(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, 'AG', strCodCli);
            frxBanco.Script.Variables['MAILCLI'] := strMailCli;
          End;

          For intCont := 1 To 4 Do
            TfrxPictureView(frxBanco.FindObject('imgLog' + IntToStr(intCont))).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\logoailos.bmp');

          frxBanco.Script.Variables['CODBCO'] := '085-1';

          frxBanco.FindObject('rlbTelSac').Visible := False;
          frxBanco.FindObject('rllTelSac').Visible := False;
          frxBanco.FindObject('rllLinDig').Visible := False;

          If Trim(strNumIns) <> '' Then
          Begin
            If strTipIns = '01' Then
              frxBanco.Script.Variables['NOMCED'] := strNomCed + '   ' + fMaskCNPJ(strNumIns)
            Else
              frxBanco.Script.Variables['NOMCED'] := strNomCed + '   ' + fMaskCPF(strNumIns);
          End
          Else
            frxBanco.Script.Variables['NOMCED'] := strNomCed;

          frxBanco.Script.Variables['ENDCED'] := strEndere;
          frxBanco.Script.Variables['ENDAVA'] := '';
          frxBanco.Script.Variables['USOBCO'] := '';

          If fEmptyStr(strDigAge) Then
          Begin
            strAgeDig := strNumAge + fStrZero(strCodCed, 7) + '-' + fStrZero(strDigCed, 1);
            Insert('/', strAgeDig, 5);
          End
          Else
          Begin
            strAgeDig := strNumAge + strDigAge + fStrZero(strCodCed, 7) + fStrZero(strDigCed, 1);
            Insert('-', strAgeDig, 5);
            Insert('/', strAgeDig, 7);
            Insert(' ', strAgeDig, 8);
            Insert('-', strAgeDig, 16);
          End;

          frxBanco.Script.Variables['BENEFI'] := 'Beneficiário';
          frxBanco.Script.Variables['BENEFI2']:= 'BENEFICIÁRIO';
          frxBanco.Script.Variables['ESPMOE'] := 'Esp. Moeda';
          frxBanco.Script.Variables['VALMOE'] := 'Valor da Moeda';
          frxBanco.Script.Variables['PAGADO'] := 'Pagador';
          frxBanco.Script.Variables['AGECED'] := strAgeDig;
          frxBanco.Script.Variables['NOMSAC'] := strNomSac;
          frxBanco.Script.Variables['DTAVEN'] := FormatDateTime('dd/mm/yyyy', dtaDtaVen);
          frxBanco.Script.Variables['NUMDOC'] := IfThen(strImprimirParcela = 'S', strNumDoc, LeftStr(strNumDoc, Length(strNumDoc) - 1));
          frxBanco.Script.Variables['VALDOC'] := FormatFloat('R$ #,##0.00',fStrToFloat(strVlrTit)/100);
          frxBanco.Script.Variables['LOCEXT'] := '';
          frxBanco.Script.Variables['LOCPAG'] := 'PAGÁVEL PREFERENCIALMENTE NAS COOPERATIVAS DO SISTEMA AILOS.';
          frxBanco.Script.Variables['DTADOC'] := FormatDateTime('dd/mm/yyyy', dtaDtaEmi);
          frxBanco.Script.Variables['ESPDOC'] := 'DM';
          frxBanco.Script.Variables['DTAPRO'] := FormatDateTime('dd/mm/yyyy', dtaDtaPro);

          frxBanco.Script.Variables['CART02'] := '';
          frxBanco.Script.Variables['CARTEI'] := strCodCar;
          frxBanco.Script.Variables['ACEITE'] := IIF(strIdeAce = 'S', 'Sim', 'Não');
          frxBanco.Script.Variables['CEDENT'] := 'Cód. Beneficiário';
          frxBanco.Script.Variables['SACAVA'] := '';

          strCaAgNs := strCodCar + '/';

          strTmpNN := strCodCed + strDigCed + strNosNum;

          TfrxMemoView(frxBanco.FindObject('rllCarNN1')).Text := 'Carteira/Nosso Número';

          TfrxMemoView(frxBanco.FindObject('rllNN1')).Text := 'Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN2')).Text := 'Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN3')).Text := 'Nosso Número';

          frxBanco.Script.Variables['NOSNUM'] := strTmpNN;
          frxBanco.Script.Variables['CARNOSNUM'] := strCaAgNs + strTmpNN;

          frxBanco.Script.Variables['INST01'] := IIF(fltVlrMor > 0, 'MORA DIARIA DE ' + FormatFloat('R$ #,##0.00', fltVlrMor) + '         ', '') +
                                                 IIF(fltVlrMul > 0, 'APÓS O VENCIMENTO COBRAR MULTA DE ' + FormatFloat('R$ #,##0.00', fltVlrMul), '');


          If fEmptyStr(strInstr1) Then frxBanco.Script.Variables['INST02'] := RetornaObservacaoCecred('',LDuplicatasAgrupadas)
          Else  frxBanco.Script.Variables['INST02'] := strInstr1;

          If fEmptyStr(strInstr2) Then frxBanco.Script.Variables['INST03'] := RetornaObservacaoCecred('',LDuplicatasAgrupadas)
          Else  frxBanco.Script.Variables['INST03'] := strInstr2;

          frxBanco.Script.Variables['INST04'] := RetornaObservacaoCecred(strInstr3,LDuplicatasAgrupadas);
          frxBanco.Script.Variables['INST05'] := RetornaObservacaoCecred(strInstr4,LDuplicatasAgrupadas);
          frxBanco.Script.Variables['INST06'] := RetornaObservacaoCecred(strInstr5,LDuplicatasAgrupadas);
          frxBanco.Script.Variables['INST07'] := RetornaObservacaoCecred('',LDuplicatasAgrupadas);
          frxBanco.Script.Variables['INST08'] := RetornaObservacaoCecred('',LDuplicatasAgrupadas);
          frxBanco.Script.Variables['OUTACR'] := '';

          If Length(Trim(strNuInSa)) > 11 Then
            frxBanco.Script.Variables['INSSAC'] := fMaskCNPJ(strNuInSa)
          Else frxBanco.Script.Variables['INSSAC'] := fMaskCPF(strNuInSa);

          frxBanco.Script.Variables['ENDSAC'] := strEndSac + ' - ' + strBaiSac;
          frxBanco.Script.Variables['CIDSAC'] := fMaskCEP(strCep001) + ' - ' + strCidSac + ' - ' + strEstSac;

          frxBanco.Script.Variables['LINDIG'] := strLinDig;
          TfrxBarCodeView(frxBanco.FindObject('barCodigo')).Text := strCodBar;

          TfrxBand(frxBanco.FindObject('rlbCompEntr')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrCut')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrN1')).Visible := Not (blnProEnt Or blnImpAgrup);
          TfrxBand(frxBanco.FindObject('rlbCompEntrN2')).Visible := Not (blnProEnt Or blnImpAgrup);
        End;

      Except
        On E: Exception Do
        Begin
          MessageDlg(E.Message,mtError,[mbOK],0);
          Result := False;
        End;
      End;
    End;

    LExecutarImpCodBar := False;
  End

  {**********************}
  {* BANCO CRESOL       *}
  {*MF: 287323 - 17/07/23}
  Else If strIdeBan = '133' Then
  Begin
    Result := fGeLiDi133;

    If Result Then
    Begin
      If Not FileExists(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoCresol.bmp') Then
      Begin
        FreeAndNil(qryCfgRel);
        pMensagemOk('O logo ' + ExtractFilePath(Application.ExeName) + 'LogoBoletos\LogoCresol.bmp deve existir na pasta indicada.');
        Exit;
      End;

      Try
        pCriarFormularios(TfrmQckBancos, frmQckBancos);

        With frmQckBancos Do
        Begin
          frxPDFExport.ShowDialog   := Not blnEnvioDeEmailAutomatico;
          frxPDFExport.ShowProgress := Not blnEnvioDeEmailAutomatico;

          If strEspeci = 'AG' Then
          Begin
            frxAgrupamento.DataSet := fQryAgrupamento(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, strCodCli);

            If (fCfgSis('MDBLAG', varInteger) = 1) Then
              LDuplicatasAgrupadas := DuplicatasAgrupadas(frxAgrupamento.DataSet);

          End Else frxAgrupamento.DataSet := fCriaQuery;


          blnImpAgrup := (Not frxAgrupamento.DataSet.IsEmpty) And (fCfgSis('MDBLAG', varInteger) = 2);
          If blnImpAgrup Then
          Begin
            TfrxBand(frxBanco.FindObject('rlbAgrupamento')).Visible := True;
            TfrxBand(frxBanco.FindObject('rlbReciboSac')).Visible := False;
            TfrxBand(frxBanco.FindObject('rlbReciboSacCut')).Visible := False;
            If (Not fEmptyStr(fCfgSis('IMGBOL'))) and FileExists(fCfgSis('IMGBOL')) Then
              TfrxPictureView(frxBanco.FindObject('imgLogo')).Picture.LoadFromFile(fCfgSis('IMGBOL'));

            frxBanco.Script.Variables['NUMPARC'] := fRetNumParcela(RightStr(strNumDoc, 1));
            frxBanco.Script.Variables['TOTPARC'] := fQtdParcelas(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, 'AG', strCodCli);
            frxBanco.Script.Variables['MAILCLI'] := strMailCli;
          End;

          For intCont := 1 To 4 Do
            TfrxPictureView(frxBanco.FindObject('imgLog' + IntToStr(intCont))).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoCresol.bmp');

          frxBanco.Script.Variables['CODBCO'] := '133-3';

          frxBanco.FindObject('rlbTelSac').Visible := False;
          frxBanco.FindObject('rllTelSac').Visible := False;
          frxBanco.FindObject('rllLinDig').Visible := False;

          If Trim(strNumIns) <> '' Then
          Begin
            If strTipIns = '01' Then
              frxBanco.Script.Variables['NOMCED'] := strNomCed + '   ' + fMaskCNPJ(strNumIns)
            Else
              frxBanco.Script.Variables['NOMCED'] := strNomCed + '   ' + fMaskCPF(strNumIns);
          End
          Else
            frxBanco.Script.Variables['NOMCED'] := strNomCed;

          frxBanco.Script.Variables['ENDCED'] := strEndere;
          frxBanco.Script.Variables['ENDAVA'] := '';
          frxBanco.Script.Variables['USOBCO'] := '';

          If fEmptyStr(strDigAge) Then
          Begin
            strAgeDig := strNumAge + fStrZero(strCodCed, 7) + '-' + fStrZero(strDigCed, 1);
            Insert('/', strAgeDig, 5);
          End
          Else
          Begin
            strAgeDig := strNumAge + strDigAge + fStrZero(strCodCed, 7) + fStrZero(strDigCed, 1);
            Insert('-', strAgeDig, 5);
            Insert('/', strAgeDig, 7);
            Insert(' ', strAgeDig, 8);
            Insert('-', strAgeDig, 16);
          End;

          frxBanco.Script.Variables['BENEFI'] := 'Beneficiário';
          frxBanco.Script.Variables['BENEFI2']:= 'BENEFICIÁRIO';
          frxBanco.Script.Variables['ESPMOE'] := 'Espécie Moeda';
          frxBanco.Script.Variables['VALMOE'] := 'Valor da Moeda';
          frxBanco.Script.Variables['PAGADO'] := 'Pagador';
          frxBanco.Script.Variables['AGECED'] := strAgeDig;
          frxBanco.Script.Variables['NOMSAC'] := strNomSac;
          frxBanco.Script.Variables['DTAVEN'] := FormatDateTime('dd/mm/yyyy', dtaDtaVen);
          frxBanco.Script.Variables['NUMDOC'] := IfThen(strImprimirParcela = 'S', strNumDoc, LeftStr(strNumDoc, Length(strNumDoc) - 1));
          frxBanco.Script.Variables['VALDOC'] := FormatFloat('R$ #,##0.00',fStrToFloat(strVlrTit)/100);
          frxBanco.Script.Variables['LOCEXT'] := '';
          frxBanco.Script.Variables['LOCPAG'] := 'Pagar preferencialmente na rede Cresol';
          frxBanco.Script.Variables['DTADOC'] := FormatDateTime('dd/mm/yyyy', dtaDtaEmi);
          frxBanco.Script.Variables['ESPDOC'] := 'DM';
          frxBanco.Script.Variables['DTAPRO'] := FormatDateTime('dd/mm/yyyy', dtaDtaPro);

          frxBanco.Script.Variables['CART02'] := '';
          frxBanco.Script.Variables['CARTEI'] := strCodCar;
          frxBanco.Script.Variables['ACEITE'] := IIF(strIdeAce = 'S', 'Sim', 'Não');
          frxBanco.Script.Variables['CEDENT'] := 'Cód. Beneficiário';
          frxBanco.Script.Variables['SACAVA'] := '';

          strCaAgNs := strCodCar + '/';

          iF (Length(strNosNum) = 11) Then
            strTmpNN := strCaAgNs + strNosNum + '-' +  fCalcDigito(strIdeBan, IntToStr(StrToInt64(strNosNum)), strIdeBan, 1, strCodEmp)
          Else
            strTmpNN := strCaAgNs + LeftStr(strNosNum, 11) + '-' + RightStr(strNosNum, 1);

          TfrxMemoView(frxBanco.FindObject('rllCarNN1')).Text := 'Carteira/Nosso Número';

          TfrxMemoView(frxBanco.FindObject('rllNN1')).Text := 'Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN2')).Text := 'Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN3')).Text := 'Nosso Número';

          frxBanco.Script.Variables['NOSNUM'] := strTmpNN;
          frxBanco.Script.Variables['CARNOSNUM'] := strTmpNN;

          frxBanco.Script.Variables['INST01'] := IIF(fltPerMul > 0, 'Após o vencimento cobrar multa de  ' + FormatFloat(' #,##0.00%', fltPerMul),'');
          frxBanco.Script.Variables['INST02'] := IIF(fltVlrMor > 0, 'Após o vencimento cobrar juros de ' + FormatFloat('R$ #,##0.00', fltVlrMor) + ' ao dia.', '') ;

         // frxBanco.Script.Variables['INST01'] := IIF(fltPerMul > 0,'APÓS O VENCIMENTO COBRAR MULTA DE ' + FormatFloat(' #,##0.00%', fltPerMul),'') +
         //                                        IIF(fltPermor > 0,' E JUROS DE '+ FormatFloat('#,##0.00%', (fltPermor*30)) + ' AO MÊS OU FRAÇÃO','');

          If fEmptyStr(strInstr1) Then frxBanco.Script.Variables['INST03'] := RetornaObservacaoCecred('',LDuplicatasAgrupadas)
          Else  frxBanco.Script.Variables['INST03'] := strInstr1;

          If fEmptyStr(strInstr2) Then frxBanco.Script.Variables['INST04'] := RetornaObservacaoCecred('',LDuplicatasAgrupadas)
          Else  frxBanco.Script.Variables['INST04'] := strInstr2;

          frxBanco.Script.Variables['INST05'] := RetornaObservacaoCecred(strInstr3,LDuplicatasAgrupadas);
          frxBanco.Script.Variables['INST06'] := RetornaObservacaoCecred(strInstr4,LDuplicatasAgrupadas);
          frxBanco.Script.Variables['INST07'] := RetornaObservacaoCecred(strInstr5,LDuplicatasAgrupadas);
          frxBanco.Script.Variables['INST08'] := RetornaObservacaoCecred('',LDuplicatasAgrupadas);
          //frxBanco.Script.Variables['INST08'] := RetornaObservacaoCecred('',LDuplicatasAgrupadas);
          frxBanco.Script.Variables['OUTACR'] := '';

          If Length(Trim(strNuInSa)) > 11 Then
            frxBanco.Script.Variables['INSSAC'] := fMaskCNPJ(strNuInSa)
          Else frxBanco.Script.Variables['INSSAC'] := fMaskCPF(strNuInSa);

          frxBanco.Script.Variables['ENDSAC'] := strEndSac + ' - ' + strBaiSac;
          frxBanco.Script.Variables['CIDSAC'] := fMaskCEP(strCep001) + ' - ' + strCidSac + ' - ' + strEstSac;

          frxBanco.Script.Variables['LINDIG'] := strLinDig;
          TfrxBarCodeView(frxBanco.FindObject('barCodigo')).Text := strCodBar;

          TfrxBand(frxBanco.FindObject('rlbCompEntr')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrCut')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrN1')).Visible := Not (blnProEnt Or blnImpAgrup);
          TfrxBand(frxBanco.FindObject('rlbCompEntrN2')).Visible := Not (blnProEnt Or blnImpAgrup);
        End;

      Except
        On E: Exception Do
        Begin
          MessageDlg(E.Message,mtError,[mbOK],0);
          Result := False;
        End;
      End;
    End;

    LExecutarImpCodBar := False;
  End

  {**********************}
  {* BANCO GERENCIANET  *}
  {*MF: 287323 - 24/07/23}
  Else If strIdeBan = '364' Then
  Begin
    Result := fGeLiDi364;

    If Result Then
    Begin
      If Not FileExists(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoGerencianet.bmp') Then
      Begin
        FreeAndNil(qryCfgRel);
        pMensagemOk('O logo ' + ExtractFilePath(Application.ExeName) + 'LogoBoletos\LogoGerencianet.bmp deve existir na pasta indicada.');
        Exit;
      End;

      Try
        pCriarFormularios(TfrmQckBancos, frmQckBancos);

        With frmQckBancos Do
        Begin
          frxPDFExport.ShowDialog   := Not blnEnvioDeEmailAutomatico;
          frxPDFExport.ShowProgress := Not blnEnvioDeEmailAutomatico;

          If strEspeci = 'AG' Then
          Begin
            frxAgrupamento.DataSet := fQryAgrupamento(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, strCodCli);

            If (fCfgSis('MDBLAG', varInteger) = 1) Then
              LDuplicatasAgrupadas := DuplicatasAgrupadas(frxAgrupamento.DataSet);

          End Else frxAgrupamento.DataSet := fCriaQuery;


          blnImpAgrup := (Not frxAgrupamento.DataSet.IsEmpty) And (fCfgSis('MDBLAG', varInteger) = 2);
          If blnImpAgrup Then
          Begin
            TfrxBand(frxBanco.FindObject('rlbAgrupamento')).Visible := True;
            TfrxBand(frxBanco.FindObject('rlbReciboSac')).Visible := False;
            TfrxBand(frxBanco.FindObject('rlbReciboSacCut')).Visible := False;
            If (Not fEmptyStr(fCfgSis('IMGBOL'))) and FileExists(fCfgSis('IMGBOL')) Then
              TfrxPictureView(frxBanco.FindObject('imgLogo')).Picture.LoadFromFile(fCfgSis('IMGBOL'));

            frxBanco.Script.Variables['NUMPARC'] := fRetNumParcela(RightStr(strNumDoc, 1));
            frxBanco.Script.Variables['TOTPARC'] := fQtdParcelas(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, 'AG', strCodCli);
            frxBanco.Script.Variables['MAILCLI'] := strMailCli;
          End;

          For intCont := 1 To 4 Do
            TfrxPictureView(frxBanco.FindObject('imgLog' + IntToStr(intCont))).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoGerencianet.bmp');

          frxBanco.Script.Variables['CODBCO'] := '364-6';

          frxBanco.FindObject('rlbTelSac').Visible := False;
          frxBanco.FindObject('rllTelSac').Visible := False;
          frxBanco.FindObject('rllLinDig').Visible := False;

          If Trim(strNumIns) <> '' Then
          Begin
            If strTipIns = '01' Then
              frxBanco.Script.Variables['NOMCED'] := strNomCed + '   ' + fMaskCNPJ(strNumIns)
            Else
              frxBanco.Script.Variables['NOMCED'] := strNomCed + '   ' + fMaskCPF(strNumIns);
          End
          Else
            frxBanco.Script.Variables['NOMCED'] := strNomCed;

          frxBanco.Script.Variables['ENDCED'] := strEndere;
          frxBanco.Script.Variables['ENDAVA'] := '';
          frxBanco.Script.Variables['USOBCO'] := '';

          strAgeDig := strNumAge +'/'+ fStrZero(strCodCed, 9);

          frxBanco.Script.Variables['BENEFI'] := 'Beneficiário';
          frxBanco.Script.Variables['BENEFI2']:= 'BENEFICIÁRIO';
          frxBanco.Script.Variables['ESPMOE'] := 'Espécie Moeda';
          frxBanco.Script.Variables['VALMOE'] := 'Valor da Moeda';
          frxBanco.Script.Variables['PAGADO'] := 'Pagador';
          frxBanco.Script.Variables['AGECED'] := strAgeDig;
          frxBanco.Script.Variables['NOMSAC'] := strNomSac;
          frxBanco.Script.Variables['DTAVEN'] := FormatDateTime('dd/mm/yyyy', dtaDtaVen);
          frxBanco.Script.Variables['NUMDOC'] := IfThen(strImprimirParcela = 'S', strNumDoc, LeftStr(strNumDoc, Length(strNumDoc) - 1));
          frxBanco.Script.Variables['VALDOC'] := FormatFloat('R$ #,##0.00',fStrToFloat(strVlrTit)/100);
          frxBanco.Script.Variables['LOCEXT'] := '';
          frxBanco.Script.Variables['LOCPAG'] := 'PAGÁVEL EM QUALQUER BANCO OU LOTÉRICA MESMO APÓS O VENCIMENTO';
          frxBanco.Script.Variables['DTADOC'] := FormatDateTime('dd/mm/yyyy', dtaDtaEmi);
          frxBanco.Script.Variables['ESPDOC'] := 'DM';
          frxBanco.Script.Variables['DTAPRO'] := FormatDateTime('dd/mm/yyyy', dtaDtaPro);

          frxBanco.Script.Variables['CART02'] := '';
          frxBanco.Script.Variables['CARTEI'] := strCodCar;
          frxBanco.Script.Variables['ACEITE'] := IIF(strIdeAce = 'S', 'Sim', 'Não');
          frxBanco.Script.Variables['CEDENT'] := 'Código Cedente';
          frxBanco.Script.Variables['SACAVA'] := '';

          strCaAgNs := strCodCar + '/';

           strTmpNN := fStrZero(strCodCed, 9) + '1' + LeftStr(strNosNum, 10);

          TfrxMemoView(frxBanco.FindObject('rllCarNN1')).Text := 'Carteira/Nosso Número';

          TfrxMemoView(frxBanco.FindObject('rllNN1')).Text := 'Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN2')).Text := 'Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN3')).Text := 'Nosso Número';

          frxBanco.Script.Variables['NOSNUM'] := strTmpNN;
          frxBanco.Script.Variables['CARNOSNUM'] := strTmpNN;

          frxBanco.Script.Variables['INST01'] := IIF(fltVlrMor > 0, 'Sr. Caixa, cobrar juros de ' + FormatFloat('R$ #,##0.00', fltVlrMor) + ' ao dia após vencimento. ', '') ;
          frxBanco.Script.Variables['INST02'] := IIF(fltPerMul > 0, 'Sr. Caixa, cobrar multa de  ' + FormatFloat(' #,##0.00%', fltPerMul) + ' após vencimento. ','');

         // frxBanco.Script.Variables['INST01'] := IIF(fltPerMul > 0,'APÓS O VENCIMENTO COBRAR MULTA DE ' + FormatFloat(' #,##0.00%', fltPerMul),'') +
         //                                        IIF(fltPermor > 0,' E JUROS DE '+ FormatFloat('#,##0.00%', (fltPermor*30)) + ' AO MÊS OU FRAÇÃO','');

          If fEmptyStr(strInstr1) Then frxBanco.Script.Variables['INST03'] := RetornaObservacaoCecred('',LDuplicatasAgrupadas)
          Else  frxBanco.Script.Variables['INST03'] := strInstr1;

          If fEmptyStr(strInstr2) Then frxBanco.Script.Variables['INST04'] := RetornaObservacaoCecred('',LDuplicatasAgrupadas)
          Else  frxBanco.Script.Variables['INST04'] := strInstr2;

          frxBanco.Script.Variables['INST05'] := RetornaObservacaoCecred(strInstr3,LDuplicatasAgrupadas);
          frxBanco.Script.Variables['INST06'] := RetornaObservacaoCecred(strInstr4,LDuplicatasAgrupadas);
          frxBanco.Script.Variables['INST07'] := RetornaObservacaoCecred(strInstr5,LDuplicatasAgrupadas);
          frxBanco.Script.Variables['INST08'] := RetornaObservacaoCecred('',LDuplicatasAgrupadas);
          //frxBanco.Script.Variables['INST08'] := RetornaObservacaoCecred('',LDuplicatasAgrupadas);
          frxBanco.Script.Variables['OUTACR'] := '';

          If Length(Trim(strNuInSa)) > 11 Then
            frxBanco.Script.Variables['INSSAC'] := fMaskCNPJ(strNuInSa)
          Else frxBanco.Script.Variables['INSSAC'] := fMaskCPF(strNuInSa);

          frxBanco.Script.Variables['ENDSAC'] := strEndSac + ' - ' + strBaiSac;
          frxBanco.Script.Variables['CIDSAC'] := fMaskCEP(strCep001) + ' - ' + strCidSac + ' - ' + strEstSac;

          frxBanco.Script.Variables['LINDIG'] := strLinDig;
          TfrxBarCodeView(frxBanco.FindObject('barCodigo')).Text := strCodBar;

          TfrxBand(frxBanco.FindObject('rlbCompEntr')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrCut')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrN1')).Visible := Not (blnProEnt Or blnImpAgrup);
          TfrxBand(frxBanco.FindObject('rlbCompEntrN2')).Visible := Not (blnProEnt Or blnImpAgrup);
        End;

      Except
        On E: Exception Do
        Begin
          MessageDlg(E.Message,mtError,[mbOK],0);
          Result := False;
        End;
      End;
    End;

    LExecutarImpCodBar := False;
  End

  {*****************}
  {* BANCO UNICRED *}
  {*REQ-30140****JU*}
  Else If strIdeBan = '090' Then
  Begin
    Result := fGeLiDi090;

    If Result Then
    Begin
      If Not FileExists(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoUnicred.bmp') Then
      Begin
        FreeAndNil(qryCfgRel);
        pMensagemOk('O logo ' + ExtractFilePath(Application.ExeName) + 'LogoBoletos\LogoUnicred.bmp deve existir na pasta indicada.');
        Exit;
      End;

      Try
        pCriarFormularios(TfrmQckBancos, frmQckBancos);

        pCarregarLayImp(frmQckBancos);

        With frmQckBancos Do
        Begin
          frxPDFExport.ShowDialog   := Not blnEnvioDeEmailAutomatico;
          frxPDFExport.ShowProgress := Not blnEnvioDeEmailAutomatico;

          If strEspeci = 'AG' Then
            frxAgrupamento.DataSet := fQryAgrupamento(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, strCodCli)
          Else
            frxAgrupamento.DataSet := fCriaQuery;

          blnImpAgrup := (Not frxAgrupamento.DataSet.IsEmpty) And (fCfgSis('MDBLAG', varInteger) = 2);
          If blnImpAgrup Then
          Begin
            TfrxBand(frxBanco.FindObject('rlbAgrupamento')).Visible := True;
            TfrxBand(frxBanco.FindObject('rlbReciboSac')).Visible := False;
            TfrxBand(frxBanco.FindObject('rlbReciboSacCut')).Visible := False;
            If (Not fEmptyStr(fCfgSis('IMGBOL'))) and FileExists(fCfgSis('IMGBOL')) Then
              TfrxPictureView(frxBanco.FindObject('imgLogo')).Picture.LoadFromFile(fCfgSis('IMGBOL'));

            frxBanco.Script.Variables['NUMPARC'] := fRetNumParcela(RightStr(strNumDoc, 1));
            frxBanco.Script.Variables['TOTPARC'] := fQtdParcelas(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, 'AG', strCodCli);
            frxBanco.Script.Variables['MAILCLI'] := strMailCli;
          End;

          For intCont := 1 To 4 Do
            TfrxPictureView(frxBanco.FindObject('imgLog' + IntToStr(intCont))).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoUnicred.bmp');

          frxBanco.Script.Variables['CODBCO'] := '090-6';

          frxBanco.FindObject('rlbTelSac').Visible := False;
          frxBanco.FindObject('rllTelSac').Visible := False;
          frxBanco.FindObject('rllLinDig').Visible := False;

          If Trim(strNumIns) <> '' Then
          Begin
            If strTipIns = '01' Then
              frxBanco.Script.Variables['NOMCED'] := strNomCed + '   ' + fMaskCNPJ(strNumIns)
            Else
              frxBanco.Script.Variables['NOMCED'] := strNomCed + '   ' + fMaskCPF(strNumIns);
          End
          Else
            frxBanco.Script.Variables['NOMCED'] := strNomCed;

          frxBanco.Script.Variables['ENDCED'] := strEndere;
          frxBanco.Script.Variables['ENDAVA'] := '';
          frxBanco.Script.Variables['USOBCO'] := '';

          If fEmptyStr(strDigAge) Then
          Begin
            strAgeDig := strNumAge + fStrZero(strCodCed, 7);
            Insert('/', strAgeDig, 5);
          End
          Else
          Begin
            strAgeDig := strNumAge + strDigAge + fStrZero(strCodCed, 7);
            Insert('-', strAgeDig, 5);
            Insert('/', strAgeDig, 7);
            Insert(' ', strAgeDig, 8);
            Insert('-', strAgeDig, 15);
          End;

          frxBanco.Script.Variables['BENEFI'] := 'Beneficiário';
          frxBanco.Script.Variables['BENEFI2']:= 'BENEFICIÁRIO';
          frxBanco.Script.Variables['ESPMOE'] := 'Esp. Moeda';
          frxBanco.Script.Variables['VALMOE'] := 'Valor da Moeda';
          frxBanco.Script.Variables['PAGADO'] := 'Pagador';
          frxBanco.Script.Variables['AGECED'] := strAgeDig;
          frxBanco.Script.Variables['NOMSAC'] := strNomSac;
          frxBanco.Script.Variables['DTAVEN'] := FormatDateTime('dd/mm/yyyy', dtaDtaVen);
          frxBanco.Script.Variables['NUMDOC'] := IfThen(strImprimirParcela = 'S', strNumDoc, LeftStr(strNumDoc, Length(strNumDoc) - 1));
          frxBanco.Script.Variables['VALDOC'] := FormatFloat('R$ #,##0.00',fStrToFloat(strVlrTit)/100);
          frxBanco.Script.Variables['LOCEXT'] := '';
          frxBanco.Script.Variables['LOCPAG'] := 'PAGÁVEL EM QUALQUER BANCO.';
          frxBanco.Script.Variables['DTADOC'] := FormatDateTime('dd/mm/yyyy', dtaDtaEmi);
          frxBanco.Script.Variables['ESPDOC'] := 'DM';
          frxBanco.Script.Variables['DTAPRO'] := FormatDateTime('dd/mm/yyyy', dtaDtaPro);

          frxBanco.Script.Variables['CART02'] := '';
          frxBanco.Script.Variables['CARTEI'] := strCodCar;
          frxBanco.Script.Variables['ACEITE'] := IIF(strIdeAce = 'S', 'Sim', 'Não');

          frxBanco.Script.Variables['CEDENT'] := 'Cód. Beneficiário';
          frxBanco.Script.Variables['SACAVA'] := '';

          strCaAgNs := strCodCar + '/';

          strTmpNN := strNosNum;
          Insert('-', strTmpNN, 11);

          TfrxMemoView(frxBanco.FindObject('rllCarNN1')).Text := 'Carteira/Nosso Número';

          TfrxMemoView(frxBanco.FindObject('rllNN1')).Text := 'Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN2')).Text := 'Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN3')).Text := 'Nosso Número';

          frxBanco.Script.Variables['NOSNUM'] := strCaAgNs + strTmpNN;
          frxBanco.Script.Variables['CARNOSNUM'] := strCaAgNs + strTmpNN;

          frxBanco.Script.Variables['INST01'] := IIF(fltVlrMor > 0, 'MORA DIARIA DE ' + FormatFloat('R$ #,##0.00', fltVlrMor) + '         ', '') +
                                                 IIF(fltVlrMul > 0, 'APÓS O VENCIMENTO COBRAR MULTA DE ' + FormatFloat('R$ #,##0.00', fltVlrMul), '');

          frxBanco.Script.Variables['INST02'] := '';

          frxBanco.Script.Variables['INST03'] := strInstr1;
          frxBanco.Script.Variables['INST04'] := strInstr2;
          frxBanco.Script.Variables['INST05'] := strInstr3;
          frxBanco.Script.Variables['INST06'] := strInstr4;
          frxBanco.Script.Variables['INST07'] := strInstr5;
          frxBanco.Script.Variables['INST08'] := '';
          frxBanco.Script.Variables['OUTACR'] := '';

          If Length(Trim(strNuInSa)) > 11 Then
            frxBanco.Script.Variables['INSSAC'] := fMaskCNPJ(strNuInSa)
          Else frxBanco.Script.Variables['INSSAC'] := fMaskCPF(strNuInSa);

          frxBanco.Script.Variables['ENDSAC'] := strEndSac + ' - ' + strBaiSac;
          frxBanco.Script.Variables['CIDSAC'] := fMaskCEP(strCep001) + ' - ' + strCidSac + ' - ' + strEstSac;

          frxBanco.Script.Variables['LINDIG'] := strLinDig;
          TfrxBarCodeView(frxBanco.FindObject('barCodigo')).Text := strCodBar;

          TfrxBand(frxBanco.FindObject('rlbCompEntr')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrCut')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrN1')).Visible := Not (blnProEnt Or blnImpAgrup);
          TfrxBand(frxBanco.FindObject('rlbCompEntrN2')).Visible := Not (blnProEnt Or blnImpAgrup);

          {********************************************************}
          {* LAYOUT DE BOLETO EM DUAS VIAS (FICHA DE COMPENSAÇÃO E*}
          {* RECIBO DO PAGADOR                                    *}
          {*****************************************************GD*}
          if fCfgSis('NOVLAY', varString) = 'D' then
          begin
            TfrxBand(frxBanco.FindObject('rlbFichaCaixa')).Visible    := False;
            TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Visible := False;
            if not blnImpAgrup  then
              TfrxBand(frxBanco.FindObject('rlbCompEntrN1')).Visible := False;

            If (Not fEmptyStr(fCfgSis('IMGBOL'))) and FileExists(fCfgSis('IMGBOL')) Then
            begin
              TfrxBand(frxBanco.FindObject('rlbReciboSac')).Visible              := False;
              TfrxBand(frxBanco.FindObject('rlbReciboPagadorComImagem')).Visible := True;
              TfrxPictureView(frxBanco.FindObject('imgLogo2')).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoUnicred.bmp');
              TfrxPictureView(frxBanco.FindObject('imgLogoEmpresa')).Picture.LoadFromFile(fCfgSis('IMGBOL'));
            end;
          end;

          If blnProEnt Then
            TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Height := TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Height + 18;
        End;

      Except
        On E: Exception Do
        Begin
          MessageDlg(E.Message,mtError,[mbOK],0);
          Result := False;
        End;
      End;
    End;

    LExecutarImpCodBar := False;
  End


  Else If strIdeBan = '136' Then
  Begin
    Result := fGeLiDi090;

    If Result Then
    Begin
      If Not FileExists(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoUnicred.bmp') Then
      Begin
        FreeAndNil(qryCfgRel);
        pMensagemOk('O logo ' + ExtractFilePath(Application.ExeName) + 'LogoBoletos\LogoUnicred.bmp deve existir na pasta indicada.');
        Exit;
      End;

      Try
        pCriarFormularios(TfrmQckBancos, frmQckBancos);

        With frmQckBancos Do
        Begin
          frxPDFExport.ShowDialog   := Not blnEnvioDeEmailAutomatico;
          frxPDFExport.ShowProgress := Not blnEnvioDeEmailAutomatico;

          If strEspeci = 'AG' Then
            frxAgrupamento.DataSet := fQryAgrupamento(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, strCodCli)
          Else
            frxAgrupamento.DataSet := fCriaQuery;

          blnImpAgrup := (Not frxAgrupamento.DataSet.IsEmpty) And (fCfgSis('MDBLAG', varInteger) = 2);
          If blnImpAgrup Then
          Begin
            TfrxBand(frxBanco.FindObject('rlbAgrupamento')).Visible := True;
            TfrxBand(frxBanco.FindObject('rlbReciboSac')).Visible := False;
            TfrxBand(frxBanco.FindObject('rlbReciboSacCut')).Visible := False;
            If (Not fEmptyStr(fCfgSis('IMGBOL'))) and FileExists(fCfgSis('IMGBOL')) Then
              TfrxPictureView(frxBanco.FindObject('imgLogo')).Picture.LoadFromFile(fCfgSis('IMGBOL'));

            frxBanco.Script.Variables['NUMPARC'] := fRetNumParcela(RightStr(strNumDoc, 1));
            frxBanco.Script.Variables['TOTPARC'] := fQtdParcelas(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, 'AG', strCodCli);
            frxBanco.Script.Variables['MAILCLI'] := strMailCli;
          End;

          For intCont := 1 To 4 Do
            TfrxPictureView(frxBanco.FindObject('imgLog' + IntToStr(intCont))).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoUnicred.bmp');

          frxBanco.Script.Variables['CODBCO'] := '136-8';

          frxBanco.FindObject('rlbTelSac').Visible := False;
          frxBanco.FindObject('rllTelSac').Visible := False;
          frxBanco.FindObject('rllLinDig').Visible := False;

          If Trim(strNumIns) <> '' Then
          Begin
            If strTipIns = '01' Then
              frxBanco.Script.Variables['NOMCED'] := strNomCed + '   ' + fMaskCNPJ(strNumIns)
            Else
              frxBanco.Script.Variables['NOMCED'] := strNomCed + '   ' + fMaskCPF(strNumIns);
          End
          Else
            frxBanco.Script.Variables['NOMCED'] := strNomCed;

          frxBanco.Script.Variables['ENDCED'] := strEndere;
          frxBanco.Script.Variables['ENDAVA'] := '';
          frxBanco.Script.Variables['USOBCO'] := '';

          If fEmptyStr(strDigAge) Then
          Begin
            strAgeDig := strNumAge + fStrZero(strCodCed, 7);
            Insert('/', strAgeDig, 5);
          End
          Else
          Begin
            strAgeDig := strNumAge + fStrZero(strCodCed, 9) + strDigCed;
            Insert('/', strAgeDig, 5);
            Insert('-', strAgeDig, 15);
          End;

          frxBanco.Script.Variables['BENEFI'] := 'Beneficiário';
          frxBanco.Script.Variables['BENEFI2']:= 'BENEFICIÁRIO';
          frxBanco.Script.Variables['ESPMOE'] := 'Esp. Moeda';
          frxBanco.Script.Variables['VALMOE'] := 'Valor da Moeda';
          frxBanco.Script.Variables['PAGADO'] := 'Pagador';
          frxBanco.Script.Variables['AGECED'] := strAgeDig;
          frxBanco.Script.Variables['NOMSAC'] := strNomSac;
          frxBanco.Script.Variables['DTAVEN'] := FormatDateTime('dd/mm/yyyy', dtaDtaVen);
          frxBanco.Script.Variables['NUMDOC'] := IfThen(strImprimirParcela = 'S', strNumDoc, LeftStr(strNumDoc, Length(strNumDoc) - 1));
          frxBanco.Script.Variables['VALDOC'] := FormatFloat('R$ #,##0.00',fStrToFloat(strVlrTit)/100);
          frxBanco.Script.Variables['LOCEXT'] := '';
          frxBanco.Script.Variables['LOCPAG'] := 'PAGÁVEL EM QUALQUER BANCO.';
          frxBanco.Script.Variables['DTADOC'] := FormatDateTime('dd/mm/yyyy', dtaDtaEmi);
          frxBanco.Script.Variables['ESPDOC'] := 'DM';
          frxBanco.Script.Variables['DTAPRO'] := FormatDateTime('dd/mm/yyyy', dtaDtaPro);

          frxBanco.Script.Variables['CART02'] := '';
          frxBanco.Script.Variables['CARTEI'] := strCodCar;
          frxBanco.Script.Variables['ACEITE'] := IIF(strIdeAce = 'S', 'Sim', 'Não');

          frxBanco.Script.Variables['CEDENT'] := 'Cód. Beneficiário';
          frxBanco.Script.Variables['SACAVA'] := '';

          strCaAgNs := strCodCar + '/';

          strTmpNN := strNosNum;
          Insert('-', strTmpNN, 11);

          TfrxMemoView(frxBanco.FindObject('rllCarNN1')).Text := 'Carteira/Nosso Número';

          TfrxMemoView(frxBanco.FindObject('rllNN1')).Text := 'Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN2')).Text := 'Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN3')).Text := 'Nosso Número';

          frxBanco.Script.Variables['NOSNUM'] := strCaAgNs + strTmpNN;
          frxBanco.Script.Variables['CARNOSNUM'] := strCaAgNs + strTmpNN;

          If LObsCompletaAG.Equals('S') Then
          Begin
            frxBanco.Script.Variables['INST01'] := IIF(fltVlrMor > 0, 'MORA DIARIA DE ' + FormatFloat('R$ #,##0.00', fltVlrMor) + '         ', '') +
                                                   IIF(fltVlrMul > 0, 'APÓS O VENCIMENTO COBRAR MULTA DE ' + FormatFloat('R$ #,##0.00', fltVlrMul), '');

            frxBanco.Script.Variables['INST02'] := strInstr1;

            frxBanco.Script.Variables['INST03'] := strInstr2;
            frxBanco.Script.Variables['INST04'] := strInstr3;
            frxBanco.Script.Variables['INST05'] := strInstr4;
            frxBanco.Script.Variables['INST06'] := IIF(fEmptyStr(strInstr5),LObservacaoAG1,strInstr5);
            frxBanco.Script.Variables['INST07'] := IIF(fEmptyStr(strInstr5),LObservacaoAG2,LObservacaoAG1);
            frxBanco.Script.Variables['INST08'] := IIF(fEmptyStr(strInstr5),LObservacaoAG3,LObservacaoAG2);
          End
          Else
          Begin
            frxBanco.Script.Variables['INST01'] := IIF(fltVlrMor > 0, 'MORA DIARIA DE ' + FormatFloat('R$ #,##0.00', fltVlrMor) + '         ', '') +
                                                   IIF(fltVlrMul > 0, 'APÓS O VENCIMENTO COBRAR MULTA DE ' + FormatFloat('R$ #,##0.00', fltVlrMul), '');

            frxBanco.Script.Variables['INST02'] := '';

            frxBanco.Script.Variables['INST03'] := strInstr1;
            frxBanco.Script.Variables['INST04'] := strInstr2;
            frxBanco.Script.Variables['INST05'] := strInstr3;
            frxBanco.Script.Variables['INST06'] := strInstr4;
            frxBanco.Script.Variables['INST07'] := strInstr5;
            frxBanco.Script.Variables['INST08'] := '';
          End;

          frxBanco.Script.Variables['OUTACR'] := '';

          If Length(Trim(strNuInSa)) > 11 Then
            frxBanco.Script.Variables['INSSAC'] := fMaskCNPJ(strNuInSa)
          Else frxBanco.Script.Variables['INSSAC'] := fMaskCPF(strNuInSa);

          frxBanco.Script.Variables['ENDSAC'] := strEndSac + ' - ' + strBaiSac;
          frxBanco.Script.Variables['CIDSAC'] := fMaskCEP(strCep001) + ' - ' + strCidSac + ' - ' + strEstSac;

          frxBanco.Script.Variables['LINDIG'] := strLinDig;
          TfrxBarCodeView(frxBanco.FindObject('barCodigo')).Text := strCodBar;

          TfrxBand(frxBanco.FindObject('rlbCompEntr')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrCut')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrN1')).Visible := Not (blnProEnt Or blnImpAgrup);
          TfrxBand(frxBanco.FindObject('rlbCompEntrN2')).Visible := Not (blnProEnt Or blnImpAgrup);

          If blnProEnt Then
            TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Height := TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Height + 18;
        End;

      Except
        On E: Exception Do
        Begin
          MessageDlg(E.Message,mtError,[mbOK],0);
          Result := False;
        End;
      End;
    End;

    LExecutarImpCodBar := False;
  End

  {*********************}
  {* BANCO DA AMAZONIA *}
  {******************JU*}
  Else If strIdeBan = '003' Then
  Begin
    Result := fGeLiDi003;

    If Result Then
    Begin
      If Not FileExists(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoBancoAmazonia.bmp') Then
      Begin
        FreeAndNil(qryCfgRel);
        pMensagemOk('O logo ' + ExtractFilePath(Application.ExeName) + 'LogoBoletos\LogoBancoAmazonia.bmp deve existir na pasta indicada.');
        Exit;
      End;

      Try
        pCriarFormularios(TfrmQckBancos, frmQckBancos);

        With frmQckBancos Do
        Begin
          frxPDFExport.ShowDialog   := Not blnEnvioDeEmailAutomatico;
          frxPDFExport.ShowProgress := Not blnEnvioDeEmailAutomatico;

          If strEspeci = 'AG' Then
            frxAgrupamento.DataSet := fQryAgrupamento(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, strCodCli)
          Else
            frxAgrupamento.DataSet := fCriaQuery;

          blnImpAgrup := (Not frxAgrupamento.DataSet.IsEmpty) And (fCfgSis('MDBLAG', varInteger) = 2);
          If blnImpAgrup Then
          Begin
            TfrxBand(frxBanco.FindObject('rlbAgrupamento')).Visible := True;
            TfrxBand(frxBanco.FindObject('rlbReciboSac')).Visible := False;
            TfrxBand(frxBanco.FindObject('rlbReciboSacCut')).Visible := False;
            If (Not fEmptyStr(fCfgSis('IMGBOL'))) and FileExists(fCfgSis('IMGBOL')) Then
              TfrxPictureView(frxBanco.FindObject('imgLogo')).Picture.LoadFromFile(fCfgSis('IMGBOL'));

            frxBanco.Script.Variables['NUMPARC'] := fRetNumParcela(RightStr(strNumDoc, 1));
            frxBanco.Script.Variables['TOTPARC'] := fQtdParcelas(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, 'AG', strCodCli);
            frxBanco.Script.Variables['MAILCLI'] := strMailCli;
          End;

          For intCont := 1 To 4 Do
            TfrxPictureView(frxBanco.FindObject('imgLog' + IntToStr(intCont))).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoBancoAmazonia.bmp');

          frxBanco.Script.Variables['CODBCO'] := '003-5';

          frxBanco.FindObject('rlbTelSac').Visible := False;
          frxBanco.FindObject('rllTelSac').Visible := False;
          frxBanco.FindObject('rllLinDig').Visible := False;

          If Trim(strNumIns) <> '' Then
          Begin
            If strTipIns = '01' Then
              frxBanco.Script.Variables['NOMCED'] := strNomCed + '   ' + fMaskCNPJ(strNumIns)
            Else
              frxBanco.Script.Variables['NOMCED'] := strNomCed + '   ' + fMaskCPF(strNumIns);
          End
          Else
            frxBanco.Script.Variables['NOMCED'] := strNomCed;

          frxBanco.Script.Variables['ENDCED'] := strEndere;

          frxBanco.Script.Variables['ENDAVA'] := '';
          frxBanco.Script.Variables['USOBCO'] := '';

          strAgeDig := strNumAge + strDigAge + fStrZero(strCodCed, 7);
          Insert('-', strAgeDig, 4);
          Insert('/', strAgeDig, 6);
          Insert('-', strAgeDig, 13);

          frxBanco.Script.Variables['BENEFI'] := 'Beneficiário';
          frxBanco.Script.Variables['BENEFI2']:= 'BENEFICIÁRIO';
          frxBanco.Script.Variables['ESPMOE'] := 'Espécie';
          frxBanco.Script.Variables['VALMOE'] := 'Valor';
          frxBanco.Script.Variables['PAGADO'] := 'Pagador';
          frxBanco.Script.Variables['AGECED'] := strAgeDig;
          frxBanco.Script.Variables['NOMSAC'] := strNomSac;
          frxBanco.Script.Variables['DTAVEN'] := FormatDateTime('dd/mm/yyyy', dtaDtaVen);
          frxBanco.Script.Variables['NUMDOC'] := IfThen(strImprimirParcela = 'S', strNumDoc, LeftStr(strNumDoc, Length(strNumDoc) - 1));
          frxBanco.Script.Variables['VALDOC'] := FormatFloat('R$ #,##0.00',fStrToFloat(strVlrTit)/100);
          frxBanco.Script.Variables['LOCEXT'] := '';
          frxBanco.Script.Variables['LOCPAG'] := 'PAGÁVEL EM QUALQUER BANCO.';
          frxBanco.Script.Variables['DTADOC'] := FormatDateTime('dd/mm/yyyy', dtaDtaEmi);
          frxBanco.Script.Variables['ESPDOC'] := '';
          frxBanco.Script.Variables['DTAPRO'] := FormatDateTime('dd/mm/yyyy', dtaDtaPro);
          frxBanco.Script.Variables['CARTEI'] := 'CNR';
          frxBanco.Script.Variables['CART02'] := '';
          frxBanco.Script.Variables['ACEITE'] := 'N';
          frxBanco.Script.Variables['CEDENT'] := 'Conta';
          frxBanco.Script.Variables['SACAVA'] := '';

          strTmpNN := fPadL(strNosNum, 16, '0');

          TfrxMemoView(frxBanco.FindObject('lblFichaComp')).Visible := True;
          TfrxMemoView(frxBanco.FindObject('lblAutentMec')).Left    := TfrxMemoView(frxBanco.FindObject('lblFichaComp2')).Left;
          TfrxMemoView(frxBanco.FindObject('lblAutentMec')).Text    := 'Autenticação Mecânica';
          TfrxMemoView(frxBanco.FindObject('lblFichaComp2')).Visible:= False;

          TfrxMemoView(frxBanco.FindObject('rllCarNN1')).Text := 'Nosso Número';

          TfrxMemoView(frxBanco.FindObject('rllNN1')).Text := 'Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN2')).Text := 'Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN3')).Text := 'Nosso Número';

          frxBanco.Script.Variables['NOSNUM'] := strTmpNN;
          frxBanco.Script.Variables['CARNOSNUM'] := strCaAgNs + strTmpNN;

         { frxBanco.Script.Variables['INST01'] := IIF(fltVlrMor > 0, 'APÓS O VENCIMENTO COBRAR ' + FormatFloat('R$ #,##0.00', fltVlrMor) + ' POR DIA DE ATRASO ', '');

          If StrToIntDef(strPraPro,0) >= 1 Then
            frxBanco.Script.Variables['INST02'] := 'PROTESTAR APÓS ' + strPraPro + ' DIA(S) ' + IIF(strTipDia = '1', 'ÚTIL(EIS)', 'CORRIDO(S)') + ' DO VENCIMENTO'
          Else
            frxBanco.Script.Variables['INST02'] := '';
          }
          frxBanco.Script.Variables['INST01'] := strInstr1;
          frxBanco.Script.Variables['INST02'] := strInstr2;
          frxBanco.Script.Variables['INST03'] := strInstr3;
          frxBanco.Script.Variables['INST04'] := strInstr4;
          frxBanco.Script.Variables['INST05'] := strInstr5;
          frxBanco.Script.Variables['INST06'] := '';
          frxBanco.Script.Variables['INST07'] := '';
          frxBanco.Script.Variables['INST08'] := 'ARRECADAÇÃO BASA – CONVÊNIO:' + strNumCon + ' AGÊNCIA:' + strNumAge + '-' + strDigAge;
          frxBanco.Script.Variables['OUTACR'] := '';

          If Length(Trim(strNuInSa)) > 11 Then
            frxBanco.Script.Variables['INSSAC'] := fMaskCNPJ(strNuInSa)
          Else frxBanco.Script.Variables['INSSAC'] := fMaskCPF(strNuInSa);

          frxBanco.Script.Variables['ENDSAC'] := strEndSac + ' - ' + strBaiSac;
          frxBanco.Script.Variables['CIDSAC'] := fMaskCEP(strCep001) + ' - ' + strCidSac + ' - ' + strEstSac;

          frxBanco.Script.Variables['LINDIG'] := strLinDig;
          TfrxBarCodeView(frxBanco.FindObject('barCodigo')).Text := strCodBar;

          TfrxBand(frxBanco.FindObject('rlbCompEntr')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrCut')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrN1')).Visible := Not (blnProEnt Or blnImpAgrup);
          TfrxBand(frxBanco.FindObject('rlbCompEntrN2')).Visible := Not (blnProEnt Or blnImpAgrup);

          If blnProEnt Then
            TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Height := TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Height + 18;
        End;

      Except
        On E: Exception Do
        Begin
          MessageDlg(E.Message,mtError,[mbOK],0);
          Result := False;
        End;
      End;
    End;

    LExecutarImpCodBar := False;
  End

  {*********************}
  {* BANCO DA SAFRA    *}
  {******************JU*}
  Else If (strIdeBan = '422') And Not Assigned(TRetornoBoletoBancoSafra(LRetornoRegistroBoletoApi)) Then
  Begin
    Result := fGeLiDi422;

    If Result Then
    Begin
      If Not FileExists(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoSafra.bmp') Then
      Begin
        FreeAndNil(qryCfgRel);
        pMensagemOk('O logo ' + ExtractFilePath(Application.ExeName) + 'LogoBoletos\LogoSafra.bmp deve existir na pasta indicada.');
        Exit;
      End;

      Try
        pCriarFormularios(TfrmQckBancos, frmQckBancos);

        With frmQckBancos Do
        Begin
          frxPDFExport.ShowDialog   := Not blnEnvioDeEmailAutomatico;
          frxPDFExport.ShowProgress := Not blnEnvioDeEmailAutomatico;

          If strEspeci = 'AG' Then
            frxAgrupamento.DataSet := fQryAgrupamento(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, strCodCli)
          Else
            frxAgrupamento.DataSet := fCriaQuery;

          blnImpAgrup := (Not frxAgrupamento.DataSet.IsEmpty) And (fCfgSis('MDBLAG', varInteger) = 2);
          If blnImpAgrup Then
          Begin
            TfrxBand(frxBanco.FindObject('rlbAgrupamento')).Visible := True;
            TfrxBand(frxBanco.FindObject('rlbReciboSac')).Visible := False;
            TfrxBand(frxBanco.FindObject('rlbReciboSacCut')).Visible := False;
            If (Not fEmptyStr(fCfgSis('IMGBOL'))) and FileExists(fCfgSis('IMGBOL')) Then
              TfrxPictureView(frxBanco.FindObject('imgLogo')).Picture.LoadFromFile(fCfgSis('IMGBOL'));

            frxBanco.Script.Variables['NUMPARC'] := fRetNumParcela(RightStr(strNumDoc, 1));
            frxBanco.Script.Variables['TOTPARC'] := fQtdParcelas(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, 'AG', strCodCli);
            frxBanco.Script.Variables['MAILCLI'] := strMailCli;
          End;

          For intCont := 1 To 4 Do
            TfrxPictureView(frxBanco.FindObject('imgLog' + IntToStr(intCont))).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoSafra.bmp');

          frxBanco.Script.Variables['CODBCO'] := '422-7';

          frxBanco.FindObject('rlbTelSac').Visible := False;
          frxBanco.FindObject('rllTelSac').Visible := False;
          frxBanco.FindObject('rllLinDig').Visible := False;

          If Trim(strNumIns) <> '' Then
          Begin
            If strTipIns = '01' Then
              frxBanco.Script.Variables['NOMCED'] := strNomCed + '   ' + fMaskCNPJ(strNumIns)
            Else
              frxBanco.Script.Variables['NOMCED'] := strNomCed + '   ' + fMaskCPF(strNumIns);
          End
          Else
            frxBanco.Script.Variables['NOMCED'] := strNomCed;

          frxBanco.Script.Variables['ENDCED'] := strEndere;

          frxBanco.Script.Variables['ENDAVA'] := '';
          frxBanco.Script.Variables['USOBCO'] := '';

          strAgeDig := strNumAge + fStrZero(strCodCed, 7);
          Insert('/', strAgeDig, 6);
          Insert('-', strAgeDig, 15);

          frxBanco.Script.Variables['BENEFI'] := 'Beneficiário';
          frxBanco.Script.Variables['BENEFI2']:= 'BENEFICIÁRIO';
          frxBanco.Script.Variables['ESPMOE'] := 'Esp. Moeda';
          frxBanco.Script.Variables['VALMOE'] := 'Vr Moeda';
          frxBanco.Script.Variables['PAGADO'] := 'Pagador';
          frxBanco.Script.Variables['AGECED'] := strAgeDig;
          frxBanco.Script.Variables['NOMSAC'] := strNomSac;
          frxBanco.Script.Variables['DTAVEN'] := FormatDateTime('dd/mm/yyyy', dtaDtaVen);
          //frxBanco.Script.Variables['NUMDOC'] := RightStr(IfThen(strImprimirParcela = 'S', strNumDoc, LeftStr(strNumDoc, Length(strNumDoc) - 1)), 10);

          If blnParNum Then
            frxBanco.Script.Variables['NUMDOC'] := IfThen(strImprimirParcela = 'S', LeftStr(strNumDoc, Length(strNumDoc) - 1) +'-'+
                                                                                    fPadL(fRetNumParcela(RightStr(strNumDoc, 1)),003,'0')
                                                                                  , LeftStr(strNumDoc, Length(strNumDoc) - 1))
          Else
            frxBanco.Script.Variables['NUMDOC'] := IfThen(strImprimirParcela = 'S', strNumDoc, LeftStr(strNumDoc, Length(strNumDoc) - 1));

          frxBanco.Script.Variables['VALDOC'] := FormatFloat('R$ #,##0.00',fStrToFloat(strVlrTit)/100);
          frxBanco.Script.Variables['LOCEXT'] := '';
          frxBanco.Script.Variables['LOCPAG'] := 'PAGÁVEL EM QUALQUER BANCO DO SISTEMA DE COMPENSAÇÃO.';
          frxBanco.Script.Variables['DTADOC'] := FormatDateTime('dd/mm/yyyy', dtaDtaEmi);
          frxBanco.Script.Variables['ESPDOC'] := strEspDoc;
          frxBanco.Script.Variables['DTAPRO'] := FormatDateTime('dd/mm/yyyy', dtaDtaPro);
          frxBanco.Script.Variables['CARTEI'] := strCodCar;
          frxBanco.Script.Variables['CART02'] := '';
          frxBanco.Script.Variables['ACEITE'] := 'N';
          frxBanco.Script.Variables['CEDENT'] := 'Cód. Beneficiário';
          frxBanco.Script.Variables['SACAVA'] := '';

          strTmpNN := fPadL(strNosNum, 9, '0');
          Insert('-', strTmpNN, 9);

          TfrxMemoView(frxBanco.FindObject('lblFichaComp')).Visible := True;
          TfrxMemoView(frxBanco.FindObject('lblAutentMec')).Left    := TfrxMemoView(frxBanco.FindObject('lblFichaComp2')).Left;
          TfrxMemoView(frxBanco.FindObject('lblAutentMec')).Text    := 'Autenticação Mecânica';
          TfrxMemoView(frxBanco.FindObject('lblFichaComp2')).Visible:= False;

          TfrxMemoView(frxBanco.FindObject('rllCarNN1')).Text := 'Nosso Número';

          TfrxMemoView(frxBanco.FindObject('rllNN1')).Text := 'Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN2')).Text := 'Nosso Número';
          TfrxMemoView(frxBanco.FindObject('rllNN3')).Text := 'Nosso Número';

          frxBanco.Script.Variables['NOSNUM'] := strTmpNN;
          frxBanco.Script.Variables['CARNOSNUM'] := strCaAgNs + strTmpNN;

          frxBanco.Script.Variables['INST01'] := IIF(fltVlrMor > 0, 'MORA DIÁRIA DE ' + FormatFloat('R$ #,##0.00', fltVlrMor) + '         ', '') +
                                                 IIF(fltVlrMul > 0, 'APÓS O VENCIMENTO COBRAR MULTA DE ' + FormatFloat('R$ #,##0.00', fltVlrMul), '');

          If (StrToIntDef(strPraPro,0) >= 1) And (LeftStr(strCdIns2, 2) = '10') Then
          begin
            frxBanco.Script.Variables['INST02'] := 'PROTESTAR APÓS ' + strPraPro + IIF(StrToInt(strPraPro) = 1,' DIA ', ' DIAS ') + 'DO VENCIMENTO';
            frxBanco.Script.Variables['INST03'] := strInstr1;
            frxBanco.Script.Variables['INST04'] := strInstr2;
            frxBanco.Script.Variables['INST05'] := strInstr3;
            frxBanco.Script.Variables['INST06'] := strInstr4;
            frxBanco.Script.Variables['INST07'] := strInstr5;
          end
          else
          begin
            frxBanco.Script.Variables['INST02'] := strInstr1;
            frxBanco.Script.Variables['INST03'] := strInstr2;
            frxBanco.Script.Variables['INST04'] := strInstr3;
            frxBanco.Script.Variables['INST05'] := strInstr4;
            frxBanco.Script.Variables['INST06'] := strInstr5;
            frxBanco.Script.Variables['INST07'] := '';
          end;

          frxBanco.Script.Variables['INST08'] := '';
          frxBanco.Script.Variables['OUTACR'] := '';

          If Length(Trim(strNuInSa)) > 11 Then
            frxBanco.Script.Variables['INSSAC'] := fMaskCNPJ(strNuInSa)
          Else frxBanco.Script.Variables['INSSAC'] := fMaskCPF(strNuInSa);

          frxBanco.Script.Variables['ENDSAC'] := strEndSac + ' - ' + strBaiSac;
          frxBanco.Script.Variables['CIDSAC'] := fMaskCEP(strCep001) + ' - ' + strCidSac + ' - ' + strEstSac;

          frxBanco.Script.Variables['LINDIG'] := strLinDig;
          TfrxBarCodeView(frxBanco.FindObject('barCodigo')).Text := strCodBar;

          TfrxMemoView(frxBanco.FindObject('Memo93')).Text  := 'Beneficiário Final';
          TfrxMemoView(frxBanco.FindObject('Memo154')).Text := 'Beneficiário Final';
          TfrxMemoView(frxBanco.FindObject('Memo215')).Text := 'Beneficiário Final';

          TfrxBand(frxBanco.FindObject('rlbCompEntr')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrCut')).Visible := blnProEnt;
          TfrxBand(frxBanco.FindObject('rlbCompEntrN1')).Visible := Not (blnProEnt Or blnImpAgrup);
          TfrxBand(frxBanco.FindObject('rlbCompEntrN2')).Visible := Not (blnProEnt Or blnImpAgrup);

          If blnProEnt Then
            TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Height := TfrxBand(frxBanco.FindObject('rlbFichaCaixaCut')).Height + 18;
        End;

      Except
        On E: Exception Do
        Begin
          MessageDlg(E.Message,mtError,[mbOK],0);
          Result := False;
        End;
      End;
    End;

    LExecutarImpCodBar := False;
  End;

  If (Result) Then
  Begin
    If (LExecutarImpCodBar) Then
      fImpCodBar(ClasseForm, frmGeneri)
    Else
    Begin

      frmQckBancos.frxBanco.ShowProgress := blnBolPdf;
      frmQckBancos.frxBanco.PrepareReport;
      frmQckBancos.frxPDFExport.FileName     := strNumDoc + '.pdf';
      frmQckBancos.frxPDFExport.DefaultPath  := ExtractFilePath(Application.ExeName) + '\Boletos';
      frmQckBancos.frxPDFExport.ShowDialog   := False;
      frmQckBancos.frxPDFExport.ShowProgress := False;
      frmQckBancos.frxBanco.Export(frmQckBancos.frxPDFExport);

      If ((Not blnBolPdf) Or blnForcarImp) Then
      Begin
        If fEmptyStr(strNomeFila) And (Not blnPreview) Then
        Begin
           pCarregaConfImpr(qryCfgRel, 'frmImpBoletoIndiv');
           fPreImpressao(qryCfgRel, strNomeFila, strTipImp, False);
           strNomeForm := 'frmImpBoletoIndiv';

          If (Not fEmptyStr(strNomeFila)) And
             (fRetornarReutilizarImpressoraSelecionadaBoleto) And
             (fEmptyStr(fRetornarImpressoraSelecionadaBoleto)) Then
            pInformarImpressoraSelecionadaBoleto(strNomeFila);
        End;

        frmQckBancos.frxBanco.PrintOptions.Printer := AnsiReplaceStr(strNomeFila,'\\' + fRetNomeRede + '\','');

        If Not fEmptyStr(strNomeFila) Then
          frmQckBancos.frxBanco.PrintOptions.ShowDialog := False;

        If (Not blnPegImp) Then
        Begin
          If frmQckBancos.frxBanco.PrepareReport Then
            pPrintReport(strNomeForm, 'Impressão de Boleto(s) - (Banco ' + strIdeBan + ')', strNomeFila, frmQckBancos.frxBanco);
        End
        Else
        Begin
          frmQckBancos.frxPDFExport.DefaultPath  := ExtractFilePath(Application.ExeName) + 'Boletos';
          frmQckBancos.frxPDFExport.FileName  := StringReplace(frmQckBancos.frxPDFExport.FileName ,'\\','\',[rfReplaceAll]);
          frmQckBancos.frxPDFExport.ShowDialog := True;
          pPreviewReport(strNomeForm, 'Impressão de Boleto(s) - (Banco ' + strIdeBan + ')', frmQckBancos.frxBanco);
        End;
      End;
    End;
  End;

  If Assigned(frmQckBancos) Then
    FreeAndNil(frmQckBancos);

  If Assigned(qryCfgRel) Then
    FreeAndNil(qryCfgRel);
end;

function GeraBoletoBancoInter077(Var ARelatorio: TfrxReport; Var AAgrupamento: TfrxDBDataSet): Boolean;
  Var
    LContador: Integer;

    LNossoNumeroImpresso: String;
Begin
  Result := FileExists(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoBancoInter.png');
  If Not Result Then
  Begin
    pMensagemOk('O logo ' + ExtractFilePath(Application.ExeName) + 'LogoBoletos\LogoBancoInter.png deve existir na pasta indicada.');
    Exit;
  End;

  RetornaLinhaDigitavelBancoInter077;

  Try
    AAgrupamento.DataSet := fCriaQuery;

    For LContador := 1 To 4 Do
      TfrxPictureView(ARelatorio.FindObject('imgLog' + IntToStr(LContador))).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoBancoInter.PNG');

    ARelatorio.Script.Variables['CODBCO'] := '077-9';

    ARelatorio.FindObject('rlbTelSac').Visible := False;
    ARelatorio.FindObject('rllTelSac').Visible := False;

    ARelatorio.Script.Variables['NOMCED'] := strNomCed;
    If Trim(strNumIns) <> '' Then
      ARelatorio.Script.Variables['NOMCED'] := strNomCed + '   ' + IIF(strTipIns = '01',
                                                                     fMaskCNPJ(strNumIns),
                                                                     fMaskCPF(strNumIns));

    ARelatorio.Script.Variables['ENDCED'] := strEndere;
    ARelatorio.Script.Variables['ENDAVA'] := '';
    ARelatorio.Script.Variables['USOBCO'] := '';

    ARelatorio.Script.Variables['BENEFI'] := 'Beneficiário';
    ARelatorio.Script.Variables['BENEFI2']:= 'BENEFICIÁRIO';
    ARelatorio.Script.Variables['ESPMOE'] := 'Esp. Moeda';
    ARelatorio.Script.Variables['VALMOE'] := 'Valor da Moeda';
    ARelatorio.Script.Variables['PAGADO'] := 'Pagador';
    ARelatorio.Script.Variables['AGECED'] := strNumAge + strDigAge + '/' + strCodigoCedenteBancoInter;
    ARelatorio.Script.Variables['NOMSAC'] := strNomSac;
    ARelatorio.Script.Variables['DTAVEN'] := FormatDateTime('dd/mm/yyyy', dtaDtaVen);
    ARelatorio.Script.Variables['NUMDOC'] := IfThen(strImprimirParcela = 'S', strNumDoc, LeftStr(strNumDoc, Length(strNumDoc) - 1));
    ARelatorio.Script.Variables['VALDOC'] := FormatFloat('R$ #,##0.00',fStrToFloat(strVlrTit)/100);
    ARelatorio.Script.Variables['LOCEXT'] := '';
    ARelatorio.Script.Variables['LOCPAG'] := 'PAGÁVEL EM QUALQUER BANCO.';
    ARelatorio.Script.Variables['DTADOC'] := FormatDateTime('dd/mm/yyyy', dtaDtaEmi);
    ARelatorio.Script.Variables['ESPDOC'] := strEspDoc;
    ARelatorio.Script.Variables['DTAPRO'] := FormatDateTime('dd/mm/yyyy', dtaDtaPro);
    ARelatorio.Script.Variables['CARTEI'] := strCodCar;
    ARelatorio.Script.Variables['CART02'] := '';
    ARelatorio.Script.Variables['ACEITE'] := IIF(strIdeAce = 'S', 'A', 'N');
    ARelatorio.Script.Variables['CEDENT'] := 'Cód. Beneficiário';
    ARelatorio.Script.Variables['SACAVA'] := strNomCed + '   ' + IIF(strTipIns = '01',
                                                                     'CNPJ: ' + fMaskCNPJ(strNumIns),
                                                                     'CPF: ' + fMaskCPF(strNumIns));

    LNossoNumeroImpresso := strNumAge + strDigAge + '/' + strCodCar + '/' + strNosNum;
    Insert('-', LNossoNumeroImpresso, LNossoNumeroImpresso.Length);

    TfrxMemoView(ARelatorio.FindObject('rllCarNN1')).Text := 'Nosso Número';

    TfrxMemoView(ARelatorio.FindObject('rllNN1')).Text := 'Nosso Número';
    TfrxMemoView(ARelatorio.FindObject('rllNN2')).Text := 'Nosso Número';
    TfrxMemoView(ARelatorio.FindObject('rllNN3')).Text := 'Nosso Número';

    ARelatorio.FindObject('rllLinDig').Visible := True;

    ARelatorio.Script.Variables['CARNOSNUM'] := LNossoNumeroImpresso;
    ARelatorio.Script.Variables['NOSNUM'] := LNossoNumeroImpresso;

    ARelatorio.Script.Variables['INST01'] := strInstr1 + IIF(fltVlrMul > 0, 'MULTA DE ' + FormatFloat('R$ #,##0.00', fltVlrMul) + ' APÓS ' + FormatDateTime('dd/mm/yyyy', dtaDtaVen) + '.', '');

    ARelatorio.Script.Variables['INST02'] := IIF(fltVlrMor > 0,'MORA DE ' + FormatFloat('R$ #,##0.00', fltVlrMor) + ' A PARTIR DE ' + FormatDateTime('dd/mm/yyyy', IncDay(dtaDtaVen, 1)) + '.','');


    ARelatorio.Script.Variables['INST03'] := strInstr5;

    ARelatorio.Script.Variables['INST04'] := strInstrucao1BancoInter;
    ARelatorio.Script.Variables['INST05'] := strInstrucao2BancoInter;
    ARelatorio.Script.Variables['INST06'] := strInstrucao3BancoInter;
    ARelatorio.Script.Variables['INST07'] := strInstrucao4BancoInter;
    ARelatorio.Script.Variables['INST08'] := strInstrucao5BancoInter;
    ARelatorio.Script.Variables['OUTACR'] := '';

    ARelatorio.Script.Variables['INSSAC'] := IIF(strNuInSa.Trim.Length > 11, fMaskCNPJ(strNuInSa), fMaskCPF(strNuInSa));

    ARelatorio.Script.Variables['ENDSAC'] := strEndSac + ' - ' + strBaiSac;
    ARelatorio.Script.Variables['CIDSAC'] := fMaskCEP(strCep001) + ' - ' + strCidSac + ' - ' + strEstSac;

    ARelatorio.Script.Variables['LINDIG'] := strLinDig;

    TfrxBarCodeView(ARelatorio.FindObject('barCodigo')).Text := strCodBar;

    TfrxBand(ARelatorio.FindObject('rlbCompEntr')).Visible := blnProEnt;
    TfrxBand(ARelatorio.FindObject('rlbCompEntrCut')).Visible := blnProEnt;
    TfrxBand(ARelatorio.FindObject('rlbCompEntrN1')).Visible := False;
    TfrxBand(ARelatorio.FindObject('rlbCompEntrN2')).Visible := False;

  Except
    On E: Exception Do
    Begin
      MessageDlg(E.Message,mtError,[mbOK],0);
      Result := False;
    End;
  End;
End;

function GeraBoletoBancoItauApi(Var ARelatorio: TfrxReport; Var AAgrupamento: TfrxDBDataSet; Var AQRCodePix: TfrxDBDataSet): Boolean;
  Var
    LContador:Integer;
    LImpAgrupamento: Boolean;
    LAgencia:String;
    LNossoNumero:String;

    LImagemLogoCfg: Boolean;
Begin
  Result := RetornaLinhaDigitavelBancoItauApi;

  If Not Result Then
    Exit;

  If Not FileExists(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoItau.bmp') Then
  Begin
    Result := False;
    pMensagemOk('O logo ' + ExtractFilePath(Application.ExeName) + 'LogoBoletos\LogoItau.bmp deve existir na pasta indicada.');
    Exit;
  End;

  Try
    AAgrupamento.DataSet := fCriaQuery;
    If strEspeci = 'AG' Then
      AAgrupamento.DataSet := fQryAgrupamento(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, strCodCli);

    LImagemLogoCfg := PossuiImagemLogoCFG;

    LImpAgrupamento := (Not AAgrupamento.DataSet.IsEmpty) And (fCfgSis('MDBLAG', varInteger) = 2);
    If LImpAgrupamento Then
    Begin
      TfrxBand(ARelatorio.FindObject('rlbAgrupamento')).Visible   := True;
      TfrxBand(ARelatorio.FindObject('rlbFichaCaixa')).Visible    := False;
      TfrxBand(ARelatorio.FindObject('rlbFichaCaixaCut')).Visible := False;
      If LImagemLogoCfg Then
        TfrxPictureView(ARelatorio.FindObject('imgLogo')).Picture.LoadFromFile(fCfgSis('IMGBOL'));

      ARelatorio.Script.Variables['NUMPARC'] := fRetNumParcela(RightStr(strNumDoc, 1));
      ARelatorio.Script.Variables['TOTPARC'] := fQtdParcelas(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, 'AG', strCodCli);
      ARelatorio.Script.Variables['MAILCLI'] := strMailCli;
    End;

    For LContador := 1 To 4 Do
      TfrxPictureView(ARelatorio.FindObject('imgLog' + IntToStr(LContador))).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoItau.bmp');

    ARelatorio.Script.Variables['CODBCO'] := '341-7';

    ARelatorio.FindObject('rlbTelSac').Visible := False;
    ARelatorio.FindObject('rllTelSac').Visible := False;
    ARelatorio.FindObject('rllLinDig').Visible := False;

    ARelatorio.Script.Variables['NOMCED'] := IIF(fEmptyStr(strBenefi), strNomCed, strBenefi);
    If Trim(strNumIns) <> '' Then
      ARelatorio.Script.Variables['NOMCED'] := strNomCed + '   ' + IIF(strTipIns = '01', fMaskCNPJ(strNumIns), fMaskCPF(strNumIns));

    ARelatorio.Script.Variables['ENDCED'] := strEndere;

    ARelatorio.Script.Variables['SACAVA'] := IIF(fEmptyStr(strBenefi), '', strBenefi);
    ARelatorio.Script.Variables['ENDAVA'] := IIF(fEmptyStr(strBenefi), '', strEndBen);
    ARelatorio.Script.Variables['USOBCO'] := '';

    LAgencia := strNumAge + strCodCed;
    Insert('/', LAgencia, 5);
    Insert('-', LAgencia, 11);

    ARelatorio.Script.Variables['BENEFI'] := 'Beneficiário';
    ARelatorio.Script.Variables['BENEFI2']:= 'BENEFICIÁRIO';
    ARelatorio.Script.Variables['ESPMOE'] := 'Esp. Moeda';
    ARelatorio.Script.Variables['VALMOE'] := 'Valor da Moeda';
    ARelatorio.Script.Variables['PAGADO'] := 'Pagador';
    ARelatorio.Script.Variables['AGECED'] := LAgencia;
    ARelatorio.Script.Variables['NOMSAC'] := fTiraEnter(strNomSac);
    ARelatorio.Script.Variables['DTAVEN'] := FormatDateTime('dd/mm/yyyy', dtaDtaVen);
    ARelatorio.Script.Variables['NUMDOC'] := IfThen(strImprimirParcela = 'S', strNumDoc, LeftStr(strNumDoc, Length(strNumDoc) - 1));
    ARelatorio.Script.Variables['VALDOC'] := FormatFloat('R$ #,##0.00',fStrToFloat(strVlrTit)/100);
    ARelatorio.Script.Variables['LOCEXT'] := 'ATÉ O VENCIMENTO EM QUALQUER BANCO OU CORRESPONDENTE NÃO BANCÁRIO. APÓS O';
    ARelatorio.Script.Variables['LOCPAG'] := 'VENCIMENTO, ACESSE ITAU.COM.BR/BOLETOS E PAGUE EM QUALQUER BANCO OU CORRESPONDENTE NÃO BANCÁRIO.';
    ARelatorio.Script.Variables['DTADOC'] := FormatDateTime('dd/mm/yyyy', dtaDtaEmi);
    ARelatorio.Script.Variables['ESPDOC'] := 'DM';
    ARelatorio.Script.Variables['DTAPRO'] := FormatDateTime('dd/mm/yyyy', dtaDtaPro);
    ARelatorio.Script.Variables['CARTEI'] := strCodCar;
    ARelatorio.Script.Variables['CART02'] := '';
    ARelatorio.Script.Variables['ACEITE'] := IIF(strIdeAce = 'S', 'Sim', 'Não');
    ARelatorio.Script.Variables['CEDENT'] := 'Cód. Beneficiário';

    LNossoNumero := strCodCar + strNosNum;
    Insert('/', LNossoNumero, 4);
    Insert('-', LNossoNumero, 13);

    TfrxMemoView(ARelatorio.FindObject('rllCarNN1')).Text := 'Carteira/Nosso Número';

    TfrxMemoView(ARelatorio.FindObject('rllNN1')).Text := 'Carteira/Nosso Número';
    TfrxMemoView(ARelatorio.FindObject('rllNN2')).Text := 'Carteira/Nosso Número';
    TfrxMemoView(ARelatorio.FindObject('rllNN3')).Text := 'Carteira/Nosso Número';

    ARelatorio.Script.Variables['CARNOSNUM'] := LNossoNumero;
    ARelatorio.Script.Variables['NOSNUM'] := LNossoNumero;

    ARelatorio.Script.Variables['INST01'] := RetornaObservacaoItau;

    ARelatorio.Script.Variables['INST02'] := IIF(StrToIntDef(strPraPro,0) = 0,
                                                 '',
                                                 'PROTESTAR APÓS ' + strPraPro + ' DIA ' + IIF(strTipDia = '1', 'ÚTIL', 'CORRIDO') + ' DO VENCIMENTO');

    ARelatorio.Script.Variables['INST03'] := strInstr1;
    ARelatorio.Script.Variables['INST04'] := strInstr2;
    ARelatorio.Script.Variables['INST05'] := strInstr3;
    ARelatorio.Script.Variables['INST06'] := strInstr4;
    ARelatorio.Script.Variables['INST07'] := strInstr5;
    ARelatorio.Script.Variables['INST08'] := '';
    ARelatorio.Script.Variables['OUTACR'] := '';

    ARelatorio.Script.Variables['INSSAC'] := IIF(Length(Trim(strNuInSa)) > 11, fMaskCNPJ(strNuInSa), fMaskCPF(strNuInSa));

    ARelatorio.Script.Variables['ENDSAC'] := fTiraEnter(strEndSac + ' - ' + strBaiSac);
    ARelatorio.Script.Variables['CIDSAC'] := fMaskCEP(strCep001) + ' - ' + fTiraEnter(strCidSac) + ' - ' + strEstSac;

    ARelatorio.Script.Variables['LINDIG'] := strLinDig;

    TfrxBarCodeView(ARelatorio.FindObject('barCodigo')).Text := strCodBar;

    TfrxBand(ARelatorio.FindObject('rlbCompEntr')).Visible := blnProEnt;
    TfrxBand(ARelatorio.FindObject('rlbCompEntrCut')).Visible := blnProEnt;
    TfrxBand(ARelatorio.FindObject('rlbCompEntrN1')).Visible := Not (blnProEnt Or LImpAgrupamento);
    TfrxBand(ARelatorio.FindObject('rlbCompEntrN2')).Visible := Not (blnProEnt Or LImpAgrupamento);

    {********************************************************}
    {* LAYOUT DE BOLETO EM DUAS VIAS (FICHA DE COMPENSAÇÃO E*}
    {* RECIBO DO PAGADOR                                    *}
    {*****************************************************GD*}
    if fCfgSis('NOVLAY', varString) = 'D' then
    begin
      TfrxBand(ARelatorio.FindObject('rlbFichaCaixa')).Visible    := False;
      TfrxBand(ARelatorio.FindObject('rlbFichaCaixaCut')).Visible := False;
      if not LImpAgrupamento  then
        TfrxBand(ARelatorio.FindObject('rlbCompEntrN1')).Visible := False;

      If LImagemLogoCfg Then
      begin
        TfrxBand(ARelatorio.FindObject('rlbReciboSac')).Visible              := False;
        TfrxBand(ARelatorio.FindObject('rlbReciboPagadorComImagem')).Visible := True;
        TfrxPictureView(ARelatorio.FindObject('imgLogo2')).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoItau.bmp');
        TfrxPictureView(ARelatorio.FindObject('imgLogoEmpresa')).Picture.LoadFromFile(fCfgSis('IMGBOL'));
      end;
    end;

    If blnProEnt Then
      TfrxBand(ARelatorio.FindObject('rlbFichaCaixaCut')).Height := TfrxBand(ARelatorio.FindObject('rlbFichaCaixaCut')).Height + 18;

    If Not TRetornoBoletoItau(LRetornoRegistroBoletoApi).QrCodeTxId.IsEmpty Then
    Begin
      AQRCodePix.Dataset.Open;
      AQRCodePix.Dataset.Append;
      AQRCodePix.Dataset.FieldByName('QRCODEPIX').AsString := TRetornoBoletoItau(LRetornoRegistroBoletoApi).QrCodeEmv;
      AQRCodePix.Dataset.Post;

      TfrxBand(ARelatorio.FindObject('rlbFichaComp')).Visible := False;
      TfrxBand(ARelatorio.FindObject('rlbFichaCompensacaoPix')).Visible := True;
      TfrxBarCodeView(ARelatorio.FindObject('BarCode1')).Text := strCodBar;
    End;
  Except
    On E: Exception Do
    Begin
      MessageDlg(E.Message,mtError,[mbOK],0);
      Result := False;
    End;
  End;
End;

function GeraBoletoBancoSicoobApi(Var ARelatorio: TfrxReport; Var AAgrupamento: TfrxDBDataSet; Var AQRCodePix: TfrxDBDataSet): Boolean;
  Var
    LContador:Integer;

    LImpAgrupamento: Boolean;

    LAgencia,
    LNossoNumero:String;

    LImagemLogoCfg: Boolean;
Begin
  Result := RetornaLinhaDigitavelBancoSicoobApi;

  If Not Result Then
    Exit;

  If Not FileExists(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoBancoob.bmp') Then
  Begin
    Result := False;
    pMensagemOk('O logo ' + ExtractFilePath(Application.ExeName) + 'LogoBoletos\LogoBancoob.bmp deve existir na pasta indicada.');
    Exit;
  End;

  Try
    AAgrupamento.DataSet := fCriaQuery;
    If strEspeci = 'AG' Then
      AAgrupamento.DataSet := fQryAgrupamento(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, strCodCli);

    LImagemLogoCfg := PossuiImagemLogoCFG;

    LImpAgrupamento := (Not AAgrupamento.DataSet.IsEmpty) And (fCfgSis('MDBLAG', varInteger) = 2);
    If LImpAgrupamento Then
    Begin
      TfrxBand(ARelatorio.FindObject('rlbAgrupamento')).Visible   := True;
      TfrxBand(ARelatorio.FindObject('rlbFichaCaixa')).Visible    := False;
      TfrxBand(ARelatorio.FindObject('rlbFichaCaixaCut')).Visible := False;
      If LImagemLogoCfg Then
        TfrxPictureView(ARelatorio.FindObject('imgLogo')).Picture.LoadFromFile(fCfgSis('IMGBOL'));

      ARelatorio.Script.Variables['NUMPARC'] := fRetNumParcela(RightStr(strNumDoc, 1));
      ARelatorio.Script.Variables['TOTPARC'] := fQtdParcelas(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, 'AG', strCodCli);
      ARelatorio.Script.Variables['MAILCLI'] := strMailCli;
    End;

    For LContador := 1 To 4 Do
      TfrxPictureView(ARelatorio.FindObject('imgLog' + IntToStr(LContador))).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoBancoob.bmp');

    ARelatorio.Script.Variables['CODBCO'] := '756-0';

    ARelatorio.FindObject('rlbTelSac').Visible := False;
    ARelatorio.FindObject('rllTelSac').Visible := False;
    ARelatorio.FindObject('rllLinDig').Visible := False;

    ARelatorio.Script.Variables['NOMCED'] := IIF(fEmptyStr(strBenefi), strNomCed, strBenefi);
    If Trim(strNumIns) <> '' Then
      ARelatorio.Script.Variables['NOMCED'] := strNomCed + '   ' + IIF(strTipIns = '01', fMaskCNPJ(strNumIns), fMaskCPF(strNumIns));

    ARelatorio.Script.Variables['ENDCED'] := strEndere;

    ARelatorio.Script.Variables['SACAVA'] := '';
    ARelatorio.Script.Variables['ENDAVA'] := '';
    ARelatorio.Script.Variables['USOBCO'] := '';

    strCodCed := fRetiraZerosEsquerda(strCodCed);
    LAgencia := strNumAge + strCodCed;
    Insert('/', LAgencia, 5);

    ARelatorio.Script.Variables['BENEFI'] := 'Beneficiário';
    ARelatorio.Script.Variables['BENEFI2']:= 'BENEFICIÁRIO';
    ARelatorio.Script.Variables['ESPMOE'] := 'Esp. Moeda';
    ARelatorio.Script.Variables['VALMOE'] := 'Valor da Moeda';
    ARelatorio.Script.Variables['PAGADO'] := 'Pagador';
    ARelatorio.Script.Variables['AGECED'] := LAgencia;
    ARelatorio.Script.Variables['NOMSAC'] := strNomSac;
    ARelatorio.Script.Variables['DTAVEN'] := FormatDateTime('dd/mm/yyyy', dtaDtaVen);
    ARelatorio.Script.Variables['NUMDOC'] := IfThen(strImprimirParcela = 'S', strNumDoc, LeftStr(strNumDoc, Length(strNumDoc) - 1));
    ARelatorio.Script.Variables['VALDOC'] := FormatFloat('R$ #,##0.00',fStrToFloat(strVlrTit)/100);
    ARelatorio.Script.Variables['LOCEXT'] := '';
    ARelatorio.Script.Variables['LOCPAG'] := 'PAGÁVEL PREFERENCIALMENTE NO SICOOB.';
    ARelatorio.Script.Variables['DTADOC'] := FormatDateTime('dd/mm/yyyy', dtaDtaEmi);
    ARelatorio.Script.Variables['ESPDOC'] := strEspDoc.Substring(4, 3).Trim;
    ARelatorio.Script.Variables['DTAPRO'] := FormatDateTime('dd/mm/yyyy', dtaDtaPro);
    ARelatorio.Script.Variables['CARTEI'] := strCodCar;
    ARelatorio.Script.Variables['CART02'] := '';
    ARelatorio.Script.Variables['ACEITE'] := IIF(strIdeAce = 'S', 'Sim', 'Não');
    ARelatorio.Script.Variables['CEDENT'] := 'Cód. Beneficiário';

    LNossoNumero := strNosNum;
    Insert('-', LNossoNumero, 8);

    TfrxMemoView(ARelatorio.FindObject('rllCarNN1')).Text := 'Carteira/Nosso Número';

    TfrxMemoView(ARelatorio.FindObject('rllNN1')).Text := 'Carteira/Nosso Número';
    TfrxMemoView(ARelatorio.FindObject('rllNN2')).Text := 'Carteira/Nosso Número';
    TfrxMemoView(ARelatorio.FindObject('rllNN3')).Text := 'Carteira/Nosso Número';

    TfrxMemoView(ARelatorio.FindObject('Memo71')).Text  := '';
    TfrxMemoView(ARelatorio.FindObject('Memo132')).Text := '';
    TfrxMemoView(ARelatorio.FindObject('Memo193')).Text := '';

    ARelatorio.Script.Variables['CARNOSNUM'] := LNossoNumero;
    ARelatorio.Script.Variables['NOSNUM'] := LNossoNumero;

    ARelatorio.Script.Variables['INST01'] := RetornaObservacaoBancoob;

    ARelatorio.Script.Variables['INST02'] := IIF(fltVlrMor > 0,'NÃO RECEBER O PRINCIPAL SEM JUROS DE MORA','');

    ARelatorio.Script.Variables['INST03'] := '';
    If (Not fEmptyStr(strCodProt)) Then
    Begin
      strPraPro := IIF(strCodProt = '3', '0', strPraPro);
      If (StrToIntDef(strPraPro,0) >= 1) Then
      Begin
        If strCodProt = '1' Then
          ARelatorio.Script.Variables['INST03'] := 'PROTESTAR APÓS ' + strPraPro + IIF(StrToInt(strPraPro) = 1,
                                                                                    ' DIA CORRIDO ',
                                                                                    ' DIAS CORRIDOS ') + 'DO VENCIMENTO'
        Else
          ARelatorio.Script.Variables['INST03'] := 'PROTESTAR APÓS ' + strPraPro + IIF(StrToInt(strPraPro) = 1,
                                                                                    ' DIA ÚTIL ',
                                                                                    ' DIAS ÚTEIS ') + 'DO VENCIMENTO';
      End;
    End
    Else If (StrToIntDef(strPraPro,0) >= 1) Then
      ARelatorio.Script.Variables['INST03'] := 'PROTESTAR APÓS ' + strPraPro + IIF(StrToInt(strPraPro) = 1,
                                                                                  ' DIA ',
                                                                                  ' DIAS ') + 'DO VENCIMENTO';

    ARelatorio.Script.Variables['INST04'] := strInstr1;
    ARelatorio.Script.Variables['INST05'] := strInstr2;
    ARelatorio.Script.Variables['INST06'] := strInstr3;
    ARelatorio.Script.Variables['INST07'] := strInstr4;
    ARelatorio.Script.Variables['INST08'] := strInstr5;
    ARelatorio.Script.Variables['OUTACR'] := IIF(fltOutAcr > 0, 'R$ ' + FloatToStrF(fltOutAcr, ffNumber, 12, 2), '');

    ARelatorio.Script.Variables['INSSAC'] := IIF(Length(Trim(strNuInSa)) > 11, fMaskCNPJ(strNuInSa), fMaskCPF(strNuInSa));

    ARelatorio.Script.Variables['ENDSAC'] := strEndSac + ' - ' + strBaiSac;
    ARelatorio.Script.Variables['CIDSAC'] := fMaskCEP(strCep001) + ' - ' + strCidSac + ' - ' + strEstSac;

    ARelatorio.Script.Variables['LINDIG'] := strLinDig;

    TfrxBarCodeView(ARelatorio.FindObject('barCodigo')).Text := strCodBar;

    TfrxBand(ARelatorio.FindObject('rlbCompEntr')).Visible := blnProEnt;
    TfrxBand(ARelatorio.FindObject('rlbCompEntrCut')).Visible := blnProEnt;
    TfrxBand(ARelatorio.FindObject('rlbCompEntrN1')).Visible := Not (blnProEnt Or LImpAgrupamento);
    TfrxBand(ARelatorio.FindObject('rlbCompEntrN2')).Visible := Not (blnProEnt Or LImpAgrupamento);

    {********************************************************}
    {* LAYOUT DE BOLETO EM DUAS VIAS (FICHA DE COMPENSAÇÃO E*}
    {* RECIBO DO PAGADOR                                    *}
    {*****************************************************GD*}
    if fCfgSis('NOVLAY', varString) = 'D' then
    begin
      TfrxBand(ARelatorio.FindObject('rlbFichaCaixa')).Visible    := False;
      TfrxBand(ARelatorio.FindObject('rlbFichaCaixaCut')).Visible := False;
      if not LImpAgrupamento  then
        TfrxBand(ARelatorio.FindObject('rlbCompEntrN1')).Visible := False;

      If LImagemLogoCfg Then
      begin
        TfrxBand(ARelatorio.FindObject('rlbReciboSac')).Visible              := False;
        TfrxBand(ARelatorio.FindObject('rlbReciboPagadorComImagem')).Visible := True;
        TfrxPictureView(ARelatorio.FindObject('imgLogo2')).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoBancoob.bmp');
        TfrxPictureView(ARelatorio.FindObject('imgLogoEmpresa')).Picture.LoadFromFile(fCfgSis('IMGBOL'));
      end;
    end;

    If blnProEnt Then
      TfrxBand(ARelatorio.FindObject('rlbFichaCaixaCut')).Height := TfrxBand(ARelatorio.FindObject('rlbFichaCaixaCut')).Height + 18;

    If Not TRetornoBoletoSicoob(LRetornoRegistroBoletoApi).QrCodeEmv.IsEmpty Then
    Begin
      AQRCodePix.Dataset.Open;
      AQRCodePix.Dataset.Append;
      AQRCodePix.Dataset.FieldByName('QRCODEPIX').AsString := TRetornoBoletoSicoob(LRetornoRegistroBoletoApi).QrCodeEmv;
      AQRCodePix.Dataset.Post;

      TfrxBand(ARelatorio.FindObject('rlbFichaComp')).Visible := False;
      TfrxBand(ARelatorio.FindObject('rlbFichaCompensacaoPix')).Visible := True;
      TfrxBarCodeView(ARelatorio.FindObject('BarCode1')).Text := strCodBar;
    End;
  Except
    On E: Exception Do
    Begin
      MessageDlg(E.Message,mtError,[mbOK],0);
      Result := False;
    End;
  End;
End;

function GeraBoletoBancoSantanderApi(Var ARelatorio: TfrxReport; Var AAgrupamento: TfrxDBDataSet; Var AQRCodePix: TfrxDBDataSet): Boolean;
  Var
    LContador:Integer;

    LImpAgrupamento: Boolean;

    LAgencia,
    LNossoNumero:String;

    LImagemLogoCfg: Boolean;
Begin
  Result := RetornaLinhaDigitavelBancoSantanderApi;

  If Not Result Then
    Exit;

  If Not FileExists(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoSantander.bmp') Then
  Begin
    Result := False;
    pMensagemOk('O logo ' + ExtractFilePath(Application.ExeName) + 'LogoBoletos\LogoSantander.bmp deve existir na pasta indicada.');
    Exit;
  End;

  Try
    AAgrupamento.DataSet := fCriaQuery;
    If strEspeci = 'AG' Then
      AAgrupamento.DataSet := fQryAgrupamento(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, strCodCli);

    LImagemLogoCfg := PossuiImagemLogoCFG;

    LImpAgrupamento := (Not AAgrupamento.DataSet.IsEmpty) And (fCfgSis('MDBLAG', varInteger) = 2);
    If LImpAgrupamento Then
    Begin
      TfrxBand(ARelatorio.FindObject('rlbAgrupamento')).Visible   := True;
      TfrxBand(ARelatorio.FindObject('rlbFichaCaixa')).Visible    := False;
      TfrxBand(ARelatorio.FindObject('rlbFichaCaixaCut')).Visible := False;
      If LImagemLogoCfg Then
        TfrxPictureView(ARelatorio.FindObject('imgLogo')).Picture.LoadFromFile(fCfgSis('IMGBOL'));

      ARelatorio.Script.Variables['NUMPARC'] := fRetNumParcela(RightStr(strNumDoc, 1));
      ARelatorio.Script.Variables['TOTPARC'] := fQtdParcelas(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, 'AG', strCodCli);
      ARelatorio.Script.Variables['MAILCLI'] := strMailCli;
    End;

    For LContador := 1 To 4 Do
      TfrxPictureView(ARelatorio.FindObject('imgLog' + IntToStr(LContador))).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoSantander.bmp');

    ARelatorio.Script.Variables['CODBCO'] := '033-7';

    ARelatorio.FindObject('rlbTelSac').Visible := False;
    ARelatorio.FindObject('rllTelSac').Visible := False;
    ARelatorio.FindObject('rllLinDig').Visible := False;

    ARelatorio.Script.Variables['NOMCED'] := IIF(fEmptyStr(strBenefi), strNomCed, strBenefi);
    If Trim(strNumIns) <> '' Then
      ARelatorio.Script.Variables['NOMCED'] := strNomCed + '   ' + IIF(strTipIns = '01', fMaskCNPJ(strNumIns), fMaskCPF(strNumIns));

    ARelatorio.Script.Variables['ENDCED'] := strEndere;

    ARelatorio.Script.Variables['SACAVA'] := IIF(fEmptyStr(strBenefi), '', strNomCed + IfThen(Not fEmptyStr(strNumIns),' - ' + IIF(strTipIns = '01', fMaskCNPJ(strNumIns), fMaskCPF(strNumIns)), ''));
    ARelatorio.Script.Variables['ENDAVA'] := IIF(fEmptyStr(strBenefi), '', strEndere);

    ARelatorio.Script.Variables['USOBCO'] := '';

    If fEmptyStr(strDigAge) Then
    Begin
      LAgencia := strNumAge + fStrZero(strCodCed, 7);
      Insert('/', LAgencia, 5);
    End
    Else
    Begin
      LAgencia := strNumAge + strDigAge + fStrZero(strCodCed, 7);
      Insert('-', LAgencia, 5);
      Insert('/', LAgencia, 7);
      Insert(' ', LAgencia, 8);
      Insert('-', LAgencia, 15);
    End;

    ARelatorio.Script.Variables['BENEFI'] := 'Beneficiário';
    ARelatorio.Script.Variables['BENEFI2']:= 'BENEFICIÁRIO';
    ARelatorio.Script.Variables['ESPMOE'] := 'Esp. Moeda';
    ARelatorio.Script.Variables['VALMOE'] := 'Valor da Moeda';
    ARelatorio.Script.Variables['PAGADO'] := 'Pagador';
    ARelatorio.Script.Variables['AGECED'] := LAgencia;
    ARelatorio.Script.Variables['NOMSAC'] := strNomSac;
    ARelatorio.Script.Variables['DTAVEN'] := FormatDateTime('dd/mm/yyyy', dtaDtaVen);
    ARelatorio.Script.Variables['NUMDOC'] := IfThen(strImprimirParcela = 'S', strNumDoc, LeftStr(strNumDoc, Length(strNumDoc) - 1));
    ARelatorio.Script.Variables['VALDOC'] := FormatFloat('R$ #,##0.00',fStrToFloat(strVlrTit)/100);
    ARelatorio.Script.Variables['LOCEXT'] := '';
    ARelatorio.Script.Variables['LOCPAG'] := 'PAGÁVEL EM QUALQUER BANCO.';
    ARelatorio.Script.Variables['DTADOC'] := FormatDateTime('dd/mm/yyyy', dtaDtaEmi);
    ARelatorio.Script.Variables['ESPDOC'] := 'DM';
    ARelatorio.Script.Variables['DTAPRO'] := FormatDateTime('dd/mm/yyyy', dtaDtaPro);
    ARelatorio.Script.Variables['CARTEI'] := strCodCar;
    ARelatorio.Script.Variables['CART02'] := '';
    ARelatorio.Script.Variables['ACEITE'] := IIF(strIdeAce = 'S', 'Sim', 'Não');
    ARelatorio.Script.Variables['CEDENT'] := 'Cód. Beneficiário';

    LNossoNumero := fStrZero(strNosNum, 12);

    TfrxMemoView(ARelatorio.FindObject('rllCarNN1')).Text := 'Carteira/Nosso Número';

    TfrxMemoView(ARelatorio.FindObject('rllNN1')).Text := 'Carteira/Nosso Número';
    TfrxMemoView(ARelatorio.FindObject('rllNN2')).Text := 'Carteira/Nosso Número';
    TfrxMemoView(ARelatorio.FindObject('rllNN3')).Text := 'Carteira/Nosso Número';

    TfrxMemoView(ARelatorio.FindObject('Memo71')).Text  := '';
    TfrxMemoView(ARelatorio.FindObject('Memo132')).Text := '';
    TfrxMemoView(ARelatorio.FindObject('Memo193')).Text := '';

    ARelatorio.Script.Variables['CARNOSNUM'] := strCodCar + '/' + LNossoNumero;
    ARelatorio.Script.Variables['NOSNUM'] := LNossoNumero;

    ARelatorio.Script.Variables['INST01'] := RetornaObservacaoSantander;

    ARelatorio.Script.Variables['INST02'] := '';
    If StrToIntDef(strPraPro,0) >= 1 Then
      ARelatorio.Script.Variables['INST02'] := 'PROTESTAR NO ' + strPraPro + '° DIA ' + IIF(strTipDia = '1', 'ÚTIL', 'CORRIDO') + ' APÓS O VENCIMENTO';

    ARelatorio.Script.Variables['INST03'] := strInstr1;
    ARelatorio.Script.Variables['INST04'] := strInstr2;
    ARelatorio.Script.Variables['INST05'] := strInstr3;
    ARelatorio.Script.Variables['INST06'] := strInstr4;
    ARelatorio.Script.Variables['INST07'] := strInstr5;
    ARelatorio.Script.Variables['INST08'] := '';
    ARelatorio.Script.Variables['OUTACR'] := '';

    If Length(Trim(strNuInSa)) > 11 Then
      ARelatorio.Script.Variables['INSSAC'] := fMaskCNPJ(strNuInSa)
    Else ARelatorio.Script.Variables['INSSAC'] := fMaskCPF(strNuInSa);

    ARelatorio.Script.Variables['ENDSAC'] := strEndSac + ' - ' + strBaiSac;
    ARelatorio.Script.Variables['CIDSAC'] := fMaskCEP(strCep001) + ' - ' + strCidSac + ' - ' + strEstSac;

    ARelatorio.Script.Variables['LINDIG'] := strLinDig;

    TfrxBarCodeView(ARelatorio.FindObject('barCodigo')).Text := strCodBar;

    TfrxBand(ARelatorio.FindObject('rlbCompEntr')).Visible := blnProEnt;
    TfrxBand(ARelatorio.FindObject('rlbCompEntrCut')).Visible := blnProEnt;
    TfrxBand(ARelatorio.FindObject('rlbCompEntrN1')).Visible := Not (blnProEnt Or LImpAgrupamento);
    TfrxBand(ARelatorio.FindObject('rlbCompEntrN2')).Visible := Not (blnProEnt Or LImpAgrupamento);

    {********************************************************}
    {* LAYOUT DE BOLETO EM DUAS VIAS (FICHA DE COMPENSAÇÃO E*}
    {* RECIBO DO PAGADOR                                    *}
    {*****************************************************GD*}
    if fCfgSis('NOVLAY', varString) = 'D' then
    begin
      TfrxBand(ARelatorio.FindObject('rlbFichaCaixa')).Visible    := False;
      TfrxBand(ARelatorio.FindObject('rlbFichaCaixaCut')).Visible := False;
      if not LImpAgrupamento  then
        TfrxBand(ARelatorio.FindObject('rlbCompEntrN1')).Visible := False;

      If LImagemLogoCfg Then
      begin
        TfrxBand(ARelatorio.FindObject('rlbReciboSac')).Visible              := False;
        TfrxBand(ARelatorio.FindObject('rlbReciboPagadorComImagem')).Visible := True;
        TfrxPictureView(ARelatorio.FindObject('imgLogo2')).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoSantander.bmp');
        TfrxPictureView(ARelatorio.FindObject('imgLogoEmpresa')).Picture.LoadFromFile(fCfgSis('IMGBOL'));
      end;
    end;

    If blnProEnt Then
      TfrxBand(ARelatorio.FindObject('rlbFichaCaixaCut')).Height := TfrxBand(ARelatorio.FindObject('rlbFichaCaixaCut')).Height + 18;

    If Not TRetornoBoletoSantander(LRetornoRegistroBoletoApi).QrCodeTxId.IsEmpty Then
    Begin
      AQRCodePix.Dataset.Open;
      AQRCodePix.Dataset.Append;
      AQRCodePix.Dataset.FieldByName('QRCODEPIX').AsString := TRetornoBoletoSantander(LRetornoRegistroBoletoApi).QrCodeEmv;
      AQRCodePix.Dataset.Post;

      TfrxBand(ARelatorio.FindObject('rlbFichaComp')).Visible := False;
      TfrxBand(ARelatorio.FindObject('rlbFichaCompensacaoPix')).Visible := True;
      TfrxBarCodeView(ARelatorio.FindObject('BarCode1')).Text := strCodBar;
    End;
  Except
    On E: Exception Do
    Begin
      MessageDlg(E.Message,mtError,[mbOK],0);

      Result := False;
    End;
  End;
End;

function GeraBoletoBancoBradescoApi(Var ARelatorio: TfrxReport; Var AAgrupamento: TfrxDBDataSet; Var AQRCodePix: TfrxDBDataSet): Boolean;
  Var
    LContador:Integer;

    LImpAgrupamento: Boolean;

    LAgencia,
    LNossoNumero,
    LCaminhoLogo: String;

    LImagemLogoCfg: Boolean;
Begin
  Result := RetornaLinhaDigitavelBancoBradescoApi;

  If Not Result Then
    Exit;

  If Not ValidaLogoBoleto('LogoBoletos\LogoBradesco.bmp') Then
  Begin
    Result := False;
    Exit;
  End;

  LCaminhoLogo := ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoBradesco.bmp';

  Try
    If strEspeci = 'AG' Then
      AAgrupamento.DataSet := fQryAgrupamento(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, strCodCli)
    Else
      AAgrupamento.DataSet := fCriaQuery;

    LImagemLogoCfg := PossuiImagemLogoCFG;

    LImpAgrupamento := (Not AAgrupamento.DataSet.IsEmpty) And (fCfgSis('MDBLAG', varInteger) = 2);
    If LImpAgrupamento Then
    Begin
      TfrxBand(ARelatorio.FindObject('rlbAgrupamento')).Visible   := True;
      TfrxBand(ARelatorio.FindObject('rlbFichaCaixa')).Visible    := False;
      TfrxBand(ARelatorio.FindObject('rlbFichaCaixaCut')).Visible := False;
      If LImagemLogoCfg Then
        TfrxPictureView(ARelatorio.FindObject('imgLogo')).Picture.LoadFromFile(fCfgSis('IMGBOL'));

      ARelatorio.Script.Variables['NUMPARC'] := fRetNumParcela(RightStr(strNumDoc, 1));
      ARelatorio.Script.Variables['TOTPARC'] := fQtdParcelas(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, 'AG', strCodCli);
      ARelatorio.Script.Variables['MAILCLI'] := strMailCli;
    End;

    For LContador := 1 To 4 Do
      TfrxPictureView(ARelatorio.FindObject('imgLog' + IntToStr(LContador))).Picture.LoadFromFile(LCaminhoLogo);

    ARelatorio.Script.Variables['CODBCO'] := '237-2';

    ARelatorio.FindObject('rlbTelSac').Visible := False;
    ARelatorio.FindObject('rllTelSac').Visible := False;

    ARelatorio.Script.Variables['NOMCED'] := IIF(fEmptyStr(strBenefi), strNomCed, strBenefi);
    If Trim(strNumIns) <> '' Then
      ARelatorio.Script.Variables['NOMCED'] := strNomCed + '   ' + IIF(strTipIns = '01', fMaskCNPJ(strNumIns), fMaskCPF(strNumIns));

    ARelatorio.Script.Variables['ENDCED'] := strEndere;

    ARelatorio.Script.Variables['SACAVA'] := IIF(fEmptyStr(strBenefi), '', strNomCed + IfThen(Not fEmptyStr(strNumIns),' - ' + IIF(strTipIns = '01', fMaskCNPJ(strNumIns), fMaskCPF(strNumIns)), ''));
    ARelatorio.Script.Variables['ENDAVA'] := IIF(fEmptyStr(strBenefi), '', strEndere);

    ARelatorio.Script.Variables['USOBCO'] := '';

    LAgencia := strNumAge + strDigAge + strCodCed;

    Insert('-', LAgencia, 5);
    Insert('/', LAgencia, 7);
    Insert('-', LAgencia, 15);

    ARelatorio.Script.Variables['BENEFI'] := 'Beneficiário';
    ARelatorio.Script.Variables['BENEFI2']:= 'BENEFICIÁRIO';
    ARelatorio.Script.Variables['ESPMOE'] := 'Esp. Moeda';
    ARelatorio.Script.Variables['VALMOE'] := 'Valor da Moeda';
    ARelatorio.Script.Variables['PAGADO'] := 'Pagador';
    ARelatorio.Script.Variables['AGECED'] := LAgencia;
    ARelatorio.Script.Variables['NOMSAC'] := strNomSac;
    ARelatorio.Script.Variables['DTAVEN'] := FormatDateTime('dd/mm/yyyy', dtaDtaVen);

    ARelatorio.Script.Variables['NUMDOC'] := RightStr(IfThen(strImprimirParcela = 'S', strNumDoc, LeftStr(strNumDoc, Length(strNumDoc) - 1)), 10);
    If FApresentarEspDocumento = 'S' Then
      ARelatorio.Script.Variables['NUMDOC'] := RightStr(ARelatorio.Script.Variables['NUMDOC'], Length(ARelatorio.Script.Variables['NUMDOC']) - 2) + strEspDoc;

    ARelatorio.Script.Variables['VALDOC'] := FormatFloat('R$ #,##0.00',fStrToFloat(strVlrTit)/100);
    ARelatorio.Script.Variables['LOCEXT'] := '';

    ARelatorio.Script.Variables['LOCPAG'] := 'PAGÁVEL PREFERENCIALMENTE NA REDE BRADESCO OU BRADESCO EXPRESSO.';

    ARelatorio.Script.Variables['DTADOC'] := FormatDateTime('dd/mm/yyyy', dtaDtaEmi);
    ARelatorio.Script.Variables['ESPDOC'] := 'DM';
    ARelatorio.Script.Variables['DTAPRO'] := FormatDateTime('dd/mm/yyyy', dtaDtaPro);
    ARelatorio.Script.Variables['CARTEI'] := strCodCar;
    ARelatorio.Script.Variables['CART02'] := '';
    ARelatorio.Script.Variables['OUTACR'] := '';

    ARelatorio.Script.Variables['ACEITE'] := IIF(strIdeAce = 'S', 'Sim', 'Não');

    ARelatorio.Script.Variables['CEDENT'] := 'Cód. Beneficiário';

    LNossoNumero := RightStr(strCodCar, 2) + strNosNum;

    Insert('/', LNossoNumero, 3);
    Insert('-', LNossoNumero, 15);

    TfrxMemoView(ARelatorio.FindObject('rllCarNN1')).Text := 'Carteira/Nosso Número';

    TfrxMemoView(ARelatorio.FindObject('rllNN1')).Text := 'Carteira/Nosso Número';
    TfrxMemoView(ARelatorio.FindObject('rllNN2')).Text := 'Carteira/Nosso Número';
    TfrxMemoView(ARelatorio.FindObject('rllNN3')).Text := 'Carteira/Nosso Número';

    TfrxMemoView(ARelatorio.FindObject('rllLinDig')).Visible := strIdeBan = '994';
    TfrxMemoView(ARelatorio.FindObject('rllLinDig2')).Visible := strIdeBan = '994';

    TfrxMemoView(ARelatorio.FindObject('Memo71')).Text  := '';
    TfrxMemoView(ARelatorio.FindObject('Memo132')).Text := '';
    TfrxMemoView(ARelatorio.FindObject('Memo193')).Text := '';

    ARelatorio.Script.Variables['NOSNUM'] := LNossoNumero;
    ARelatorio.Script.Variables['CARNOSNUM'] := LNossoNumero;

    ARelatorio.Script.Variables['INST01'] := IIF(fltVlrMor > 0,'MORA DIARIA DE ' + FormatFloat('R$ #,##0.00', fltVlrMor),'') +
                                         IIF(fltVlrMul > 0,'        APÓS O VENCIMENTO COBRAR MULTA DE ' + FormatFloat('R$ #,##0.00', fltVlrMul),'');
    ARelatorio.Script.Variables['INST02'] := IIF(fltVlrMor > 0,'NAO RECEBER O PRINCIPAL SEM JUROS DE MORA','');

    ARelatorio.Script.Variables['INST03'] := EmptyStr;
    If (StrToIntDef(strPraPro,0) >= 1) And (LeftStr(strCdIns1, 2) <> '07') Then
      ARelatorio.Script.Variables['INST03'] := 'PROTESTAR APÓS ' + strPraPro + IIF(StrToInt(strPraPro) = 1,' DIA ', ' DIAS ') + 'DO VENCIMENTO'
    Else If (StrToIntDef(strPraPro,0) >= 1) And (LeftStr(strCdIns1, 2) = '07') Then
      ARelatorio.Script.Variables['INST03'] := 'SUJEITO A NEGATIVAÇÃO APÓS ' + strPraPro + IIF(StrToInt(strPraPro) = 1,' DIA ', ' DIAS ') + ' DO VENCIMENTO';

    ARelatorio.Script.Variables['INST04'] := strInstr1;
    ARelatorio.Script.Variables['INST05'] := strInstr2;
    ARelatorio.Script.Variables['INST06'] := strInstr3;
    ARelatorio.Script.Variables['INST07'] := strInstr4;
    ARelatorio.Script.Variables['INST08'] := strInstr5;

    If Length(Trim(strNuInSa)) > 11 Then
      ARelatorio.Script.Variables['INSSAC'] := fMaskCNPJ(strNuInSa)
    Else ARelatorio.Script.Variables['INSSAC'] := fMaskCPF(strNuInSa);

    ARelatorio.Script.Variables['ENDSAC'] := strEndSac + ' - ' + strBaiSac;
    ARelatorio.Script.Variables['CIDSAC'] := fMaskCEP(strCep001) + ' - ' + strCidSac + ' - ' + strEstSac;
    ARelatorio.Script.Variables['LINDIG'] := strLinDig;
    TfrxBarCodeView(ARelatorio.FindObject('barCodigo')).Text := strCodBar;

    TfrxBand(ARelatorio.FindObject('rlbCompEntr')).Visible := blnProEnt;
    TfrxBand(ARelatorio.FindObject('rlbCompEntrCut')).Visible := blnProEnt;
    TfrxBand(ARelatorio.FindObject('rlbCompEntrN1')).Visible := Not (blnProEnt Or LImpAgrupamento);
    TfrxBand(ARelatorio.FindObject('rlbCompEntrN2')).Visible := Not (blnProEnt Or LImpAgrupamento);

    if fCfgSis('NOVLAY', varString) = 'D' then
    begin
      TfrxBand(ARelatorio.FindObject('rlbFichaCaixa')).Visible    := False;
      TfrxBand(ARelatorio.FindObject('rlbFichaCaixaCut')).Visible := False;
      if not LImpAgrupamento  then
        TfrxBand(ARelatorio.FindObject('rlbCompEntrN1')).Visible := False;

      If LImagemLogoCfg Then
      begin
        TfrxBand(ARelatorio.FindObject('rlbReciboSac')).Visible              := False;
        TfrxBand(ARelatorio.FindObject('rlbReciboPagadorComImagem')).Visible := True;
        TfrxPictureView(ARelatorio.FindObject('imgLogo2')).Picture.LoadFromFile(LCaminhoLogo);
        TfrxPictureView(ARelatorio.FindObject('imgLogoEmpresa')).Picture.LoadFromFile(fCfgSis('IMGBOL'));
      end;
    end;

    If blnProEnt Then
      TfrxBand(ARelatorio.FindObject('rlbFichaCaixaCut')).Height := TfrxBand(ARelatorio.FindObject('rlbFichaCaixaCut')).Height + 18;

    If Not fEmptyStr(TRetornoBoletoBradesco(LRetornoRegistroBoletoApi).QrCodeEmv) Then //Not .IsEmpty retornando true sempre
    Begin
      AQRCodePix.Dataset.Open;
      AQRCodePix.Dataset.Append;
      AQRCodePix.Dataset.FieldByName('QRCODEPIX').AsString := TRetornoBoletoBradesco(LRetornoRegistroBoletoApi).QrCodeEmv;
      AQRCodePix.Dataset.Post;

      TfrxBand(ARelatorio.FindObject('rlbFichaComp')).Visible := False;
      TfrxBand(ARelatorio.FindObject('rlbFichaCompensacaoPix')).Visible := True;
      TfrxBarCodeView(ARelatorio.FindObject('BarCode1')).Text := strCodBar;
    End;
  Except
    On E: Exception Do
    Begin
      MessageDlg(E.Message,mtError,[mbOK],0);

      VS_ErroGeraBoletoLaser := E.Message;

      Result := False;
    End;
  End;
End;

function GeraBoletoBancoSafraApi(Var ARelatorio: TfrxReport; Var AAgrupamento: TfrxDBDataSet; Var AQRCodePix: TfrxDBDataSet): Boolean;
  Var
    LContador: Integer;
    LImpAgrupamento: Boolean;
    LAgencia: String;
Begin
  Result := RetornaLinhaDigitavelBancoSafraApi;

  If Result Then
  Begin
    If Not ValidaLogoBoleto('LogoBoletos\LogoSafra.bmp') Then
    Begin
      Result := False;
      Exit;
    End;

    Try
        If strEspeci = 'AG' Then
          AAgrupamento.DataSet := fQryAgrupamento(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, strCodCli)
        Else
          AAgrupamento.DataSet := fCriaQuery;

        LImpAgrupamento := (Not AAgrupamento.DataSet.IsEmpty) And (fCfgSis('MDBLAG', varInteger) = 2);
        If LImpAgrupamento Then
        Begin
          TfrxBand(ARelatorio.FindObject('rlbAgrupamento')).Visible := True;
          TfrxBand(ARelatorio.FindObject('rlbReciboSac')).Visible := False;
          TfrxBand(ARelatorio.FindObject('rlbReciboSacCut')).Visible := False;

          If (Not fEmptyStr(fCfgSis('IMGBOL'))) and FileExists(fCfgSis('IMGBOL')) Then
            TfrxPictureView(ARelatorio.FindObject('imgLogo')).Picture.LoadFromFile(fCfgSis('IMGBOL'));

          ARelatorio.Script.Variables['NUMPARC'] := fRetNumParcela(RightStr(strNumDoc, 1));
          ARelatorio.Script.Variables['TOTPARC'] := fQtdParcelas(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, 'AG', strCodCli);
          ARelatorio.Script.Variables['MAILCLI'] := strMailCli;
        End;

        For LContador := 1 To 4 Do
          TfrxPictureView(ARelatorio.FindObject('imgLog' + IntToStr(LContador))).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoSafra.bmp');

        ARelatorio.Script.Variables['CODBCO'] := '422-X';

        ARelatorio.FindObject('rlbTelSac').Visible := False;
        ARelatorio.FindObject('rllTelSac').Visible := False;
        ARelatorio.FindObject('rllLinDig').Visible := False;

        TfrxMemoView(ARelatorio.FindObject('memo29')).Text  := 'REAL';
        TfrxMemoView(ARelatorio.FindObject('memo69')).Text  := 'REAL';
        TfrxMemoView(ARelatorio.FindObject('memo130')).Text := 'REAL';
        TfrxMemoView(ARelatorio.FindObject('memo191')).Text := 'REAL';

        ARelatorio.Script.Variables['NOMCED'] := IIF(fEmptyStr(strBenefi), strNomCed, strBenefi);
        If Trim(strNumIns) <> '' Then
          ARelatorio.Script.Variables['NOMCED'] := strNomCed + '   ' + IIF(strTipIns = '01', fMaskCNPJ(strNumIns), fMaskCPF(strNumIns));

        ARelatorio.Script.Variables['ENDCED'] := strEndere;

        ARelatorio.Script.Variables['SACAVA'] := IIF(fEmptyStr(strBenefi), '', strNomCed + IfThen(Not fEmptyStr(strNumIns),' - ' + IIF(strTipIns = '01', fMaskCNPJ(strNumIns), fMaskCPF(strNumIns)), ''));
        ARelatorio.Script.Variables['ENDAVA'] := IIF(fEmptyStr(strBenefi), '', strEndere);

        ARelatorio.Script.Variables['USOBCO'] := '';

        LAgencia := TRetornoBoletoBancoSafra(LRetornoRegistroBoletoApi).BeneficiarioAgencia;
        LAgencia := LAgencia + fStrZero(TRetornoBoletoBancoSafra(LRetornoRegistroBoletoApi).BeneficiarioContaCorrente, 9);
        Insert('/', LAgencia, 6);

        ARelatorio.Script.Variables['BENEFI'] := 'Beneficiário';
        ARelatorio.Script.Variables['BENEFI2']:= 'BENEFICIÁRIO';
        ARelatorio.Script.Variables['ESPMOE'] := 'Esp. Moeda';
        ARelatorio.Script.Variables['VALMOE'] := 'Valor da Moeda';
        ARelatorio.Script.Variables['PAGADO'] := 'Pagador';
        ARelatorio.Script.Variables['AGECED'] := LAgencia;
        ARelatorio.Script.Variables['NOMSAC'] := strNomSac;
        ARelatorio.Script.Variables['DTAVEN'] := FormatDateTime('dd/mm/yyyy', dtaDtaVen);
        ARelatorio.Script.Variables['NUMDOC'] := IfThen(strImprimirParcela = 'S', strNumDoc, LeftStr(strNumDoc, Length(strNumDoc) - 1));
        ARelatorio.Script.Variables['VALDOC'] := FormatFloat('R$ #,##0.00',fStrToFloat(strVlrTit)/100);
        ARelatorio.Script.Variables['LOCEXT'] := '';
        ARelatorio.Script.Variables['LOCPAG'] := 'PAGÁVEL PREFERENCIALMENTE EM CANAIS ELETRONICOS DA SUA INSTITUICAO FINANCEIRA.';
        ARelatorio.Script.Variables['DTADOC'] := FormatDateTime('dd/mm/yyyy', dtaDtaEmi);
        ARelatorio.Script.Variables['ESPDOC'] := 'DMI';
        ARelatorio.Script.Variables['DTAPRO'] := FormatDateTime('dd/mm/yyyy', dtaDtaPro);
        ARelatorio.Script.Variables['CARTEI'] := TRetornoBoletoBancoSafra(LRetornoRegistroBoletoApi).CodigoCarteira;
        ARelatorio.Script.Variables['CART02'] := '';
        ARelatorio.Script.Variables['ACEITE'] := IIF(strIdeAce = 'S', 'S', 'N');
        ARelatorio.Script.Variables['CEDENT'] := 'Cód. Beneficiário';

        TfrxMemoView(ARelatorio.FindObject('rllCarNN1')).Text := 'Cart./Nosso Número';

        TfrxMemoView(ARelatorio.FindObject('rllNN1')).Text := 'Nosso Número';
        TfrxMemoView(ARelatorio.FindObject('rllNN2')).Text := 'Nosso Número';
        TfrxMemoView(ARelatorio.FindObject('rllNN3')).Text := 'Nosso Número';

        ARelatorio.Script.Variables['NOSNUM'] := TRetornoBoletoBancoSafra(LRetornoRegistroBoletoApi).nossoNumero;
        ARelatorio.Script.Variables['CARNOSNUM'] := TRetornoBoletoBancoSafra(LRetornoRegistroBoletoApi).nossoNumero;

        ARelatorio.Script.Variables['INST01'] := IIF(fltVlrMor > 0, 'MORA DIÁRIA DE ' + FormatFloat('R$ #,##0.00', fltVlrMor) + '         ', '') +
                                                 IIF(fltVlrMul > 0, 'APÓS O VENCIMENTO COBRAR MULTA DE ' + FormatFloat('R$ #,##0.00', fltVlrMul), '');

        If StrToIntDef(strPraPro,0) >= 1 Then
          ARelatorio.Script.Variables['INST02'] := 'PROTESTAR APÓS ' + strPraPro + ' DIAS ' + IIF(StrToInt(strPraPro) > 4, 'CORRIDOS', 'ÚTEIS') + ' DO VENCIMENTO'
        Else
          ARelatorio.Script.Variables['INST02'] := '';

        ARelatorio.Script.Variables['INST03'] := strInstr1;
        ARelatorio.Script.Variables['INST04'] := strInstr2;
        ARelatorio.Script.Variables['INST05'] := strInstr3;
        ARelatorio.Script.Variables['INST06'] := strInstr4;
        ARelatorio.Script.Variables['INST07'] := strInstr5;
        ARelatorio.Script.Variables['INST08'] := '';
        ARelatorio.Script.Variables['OUTACR'] := '';

        If Length(Trim(strNuInSa)) > 11 Then
          ARelatorio.Script.Variables['INSSAC'] := fMaskCNPJ(strNuInSa)
        Else ARelatorio.Script.Variables['INSSAC'] := fMaskCPF(strNuInSa);

        ARelatorio.Script.Variables['ENDSAC'] := strEndSac + ' - ' + strBaiSac;
        ARelatorio.Script.Variables['CIDSAC'] := fMaskCEP(strCep001) + ' - ' + strCidSac + ' - ' + strEstSac;

        ARelatorio.Script.Variables['LINDIG'] := strLinDig;
        TfrxBarCodeView(ARelatorio.FindObject('barCodigo')).Text := strCodBar;

        TfrxBand(ARelatorio.FindObject('rlbCompEntr')).Visible := blnProEnt;
        TfrxBand(ARelatorio.FindObject('rlbCompEntrCut')).Visible := blnProEnt;
        TfrxBand(ARelatorio.FindObject('rlbCompEntrN1')).Visible := Not (blnProEnt Or LImpAgrupamento);
        TfrxBand(ARelatorio.FindObject('rlbCompEntrN2')).Visible := Not (blnProEnt Or LImpAgrupamento);

        {********************************************************}
        {* LAYOUT DE BOLETO EM DUAS VIAS (FICHA DE COMPENSAÇÃO E*}
        {* RECIBO DO PAGADOR                                    *}
        {*****************************************************GD*}
        if fCfgSis('NOVLAY', varString) = 'D' then
        begin
          TfrxBand(ARelatorio.FindObject('rlbFichaCaixa')).Visible    := False;
          TfrxBand(ARelatorio.FindObject('rlbFichaCaixaCut')).Visible := False;
          if not LImpAgrupamento  then
            TfrxBand(ARelatorio.FindObject('rlbCompEntrN1')).Visible := False;

          If (Not fEmptyStr(fCfgSis('IMGBOL'))) and FileExists(fCfgSis('IMGBOL')) Then
          begin
            TfrxBand(ARelatorio.FindObject('rlbReciboSac')).Visible              := False;
            TfrxBand(ARelatorio.FindObject('rlbReciboPagadorComImagem')).Visible := True;
            TfrxPictureView(ARelatorio.FindObject('imgLogo2')).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoSafra.bmp');
            TfrxPictureView(ARelatorio.FindObject('imgLogoEmpresa')).Picture.LoadFromFile(fCfgSis('IMGBOL'));
          end;
        end;

        If blnProEnt Then
          TfrxBand(ARelatorio.FindObject('rlbFichaCaixaCut')).Height := TfrxBand(ARelatorio.FindObject('rlbFichaCaixaCut')).Height + 18;

        If Not TRetornoBoletoBancoSafra(LRetornoRegistroBoletoApi).QrCodeEmv.IsEmpty Then
        Begin
          AQRCodePix.Dataset.Open;
          AQRCodePix.Dataset.Append;
          AQRCodePix.Dataset.FieldByName('QRCODEPIX').AsString := TRetornoBoletoBancoSafra(LRetornoRegistroBoletoApi).QrCodeEmv;
          AQRCodePix.Dataset.Post;

          TfrxBand(ARelatorio.FindObject('rlbFichaComp')).Visible := False;
          TfrxBand(ARelatorio.FindObject('rlbFichaCompensacaoPix')).Visible := True;
          TfrxBarCodeView(ARelatorio.FindObject('BarCode1')).Text := strCodBar;
        End;
    Except
      On E: Exception Do
      Begin
        MessageDlg(E.Message,mtError,[mbOK],0);

        VS_ErroGeraBoletoLaser := E.Message;

        Result := False;
      End;
    End;
  End;

End;

function GeraBoletoBancoDoBrasilApi(Var ARelatorio: TfrxReport; Var AAgrupamento: TfrxDBDataSet;
  Var AQRCodePix: TfrxDBDataSet): Boolean;
  Var
    LContador: Integer;

    LImpAgrupamento: Boolean;
    LAgencia: String;
Begin
  Result := RetornaLinhaDigitavelBancoDoBrasilApi;

  If Result Then
  Begin

    If Not FileExists(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoBrasil.bmp') Then
    Begin
      Result := False;
      pMensagemOk('O logo ' + ExtractFilePath(Application.ExeName) + 'LogoBoletos\LogoBrasil.bmp deve existir na pasta indicada.');
      Exit;
    End;

    Try

      If strEspeci = 'AG' Then
        AAgrupamento.DataSet := fQryAgrupamento(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, strCodCli)
      Else
        AAgrupamento.DataSet := fCriaQuery;

      LImpAgrupamento := (Not AAgrupamento.DataSet.IsEmpty) And (fCfgSis('MDBLAG', varInteger) = 2);
      If LImpAgrupamento Then
      Begin
        TfrxBand(ARelatorio.FindObject('rlbAgrupamento')).Visible   := True;
        TfrxBand(ARelatorio.FindObject('rlbFichaCaixa')).Visible    := False;
        TfrxBand(ARelatorio.FindObject('rlbFichaCaixaCut')).Visible := False;

        If (Not fEmptyStr(fCfgSis('IMGBOL'))) and FileExists(fCfgSis('IMGBOL')) Then
          TfrxPictureView(ARelatorio.FindObject('imgLogo')).Picture.LoadFromFile(fCfgSis('IMGBOL'));

        ARelatorio.Script.Variables['NUMPARC'] := fRetNumParcela(RightStr(strNumDoc, 1));
        ARelatorio.Script.Variables['TOTPARC'] := fQtdParcelas(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, 'AG', strCodCli);
        ARelatorio.Script.Variables['MAILCLI'] := strMailCli;
      End;

      For LContador := 1 To 4 Do
        TfrxPictureView(ARelatorio.FindObject('imgLog' + IntToStr(LContador))).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoBrasil.bmp');

      ARelatorio.Script.Variables['CODBCO'] := '001-9';

      ARelatorio.FindObject('rlbTelSac').Visible := False;
      ARelatorio.FindObject('rllTelSac').Visible := False;
      ARelatorio.Script.Variables['USOBCO'] := '';
      ARelatorio.Script.Variables['NOMCED'] := strNomCed;

      If Trim(strNumIns) <> '' Then
      Begin
        If strTipIns = '01' Then
          ARelatorio.Script.Variables['NOMCED'] := strNomCed + '   ' + fMaskCNPJ(strNumIns)
        Else
          ARelatorio.Script.Variables['NOMCED'] := strNomCed + '   ' + fMaskCPF(strNumIns);
      End;

      ARelatorio.Script.Variables['ENDCED'] := strEndere;
      ARelatorio.Script.Variables['SACAVA'] := strObsSac;
      ARelatorio.Script.Variables['ENDAVA'] := '';
      ARelatorio.Script.Variables['USOBCO'] := '';

      LAgencia :=  TRetornoBoletoBancoDoBrasil(LRetornoRegistroBoletoApi).BeneficiarioAgencia;
      LAgencia := LAgencia + fStrZero(TRetornoBoletoBancoDoBrasil(LRetornoRegistroBoletoApi).BeneficiarioContaCorrente, 7);
      Insert('/', LAgencia, 5);

      ARelatorio.Script.Variables['BENEFI'] := 'Beneficiário';
      ARelatorio.Script.Variables['BENEFI2']:= 'BENEFICIÁRIO';
      ARelatorio.Script.Variables['ESPMOE'] := 'Espécie';
      ARelatorio.Script.Variables['VALMOE'] := '(x) Valor';
      ARelatorio.Script.Variables['PAGADO'] := 'Pagador';
      ARelatorio.Script.Variables['AGECED'] := LAgencia;
      ARelatorio.Script.Variables['NOMSAC'] := strNomSac;
      ARelatorio.Script.Variables['DTAVEN'] := FormatDateTime('dd/mm/yyyy', dtaDtaVen);
      ARelatorio.Script.Variables['NUMDOC'] := RightStr(IfThen(strImprimirParcela = 'S', strNumDoc, LeftStr(strNumDoc, Length(strNumDoc) - 1)), 10);
      ARelatorio.Script.Variables['VALDOC'] := FormatFloat('R$ #,##0.00',fStrToFloat(strVlrTit)/100);
      ARelatorio.Script.Variables['LOCEXT'] := '';
      ARelatorio.Script.Variables['LOCPAG'] := 'PAGÁVEL EM QUALQUER BANCO.';
      ARelatorio.Script.Variables['DTADOC'] := FormatDateTime('dd/mm/yyyy', dtaDtaEmi);
      ARelatorio.Script.Variables['ESPDOC'] := 'DM';
      ARelatorio.Script.Variables['DTAPRO'] := FormatDateTime('dd/mm/yyyy', dtaDtaPro);
      ARelatorio.Script.Variables['CARTEI'] := strCodCar ;
      ARelatorio.Script.Variables['CART02'] := '';
      ARelatorio.Script.Variables['ACEITE'] := IIF(strIdeAce = 'S', 'Sim', 'Não');
      ARelatorio.Script.Variables['CEDENT'] := 'Código do Beneficiário';
      TfrxMemoView(ARelatorio.FindObject('Memo15')).Text                  := 'Beneficiário';
      TfrxMemoView(ARelatorio.FindObject('lblVencimentoAceite')).Text     := 'Data de Vencimento';
      TfrxMemoView(ARelatorio.FindObject('lblVencimentoCX')).Text         := 'Data de Vencimento';
      TfrxMemoView(ARelatorio.FindObject('lblVencimentoRecibo')).Text     := 'Data de Vencimento';
      TfrxMemoView(ARelatorio.FindObject('lblVencimentoFicha')).Text      := 'Data de Vencimento';
      TfrxMemoView(ARelatorio.FindObject('lblNumDocumentoAceite')).Text   := 'Nr. Documento';
      TfrxMemoView(ARelatorio.FindObject('lblNumDocumentoCX')).Text       := 'Nr. Documento';
      TfrxMemoView(ARelatorio.FindObject('lblNumDocumentoRecibo')).Text   := 'Nr. Documento';
      TfrxMemoView(ARelatorio.FindObject('lblNumDocumentoFicha')).Text    := 'Nr. Documento';
      TfrxMemoView(ARelatorio.FindObject('lblMoraMultaJurosCX')).Text     := '(+) Juros/Multa';
      TfrxMemoView(ARelatorio.FindObject('lblMoraMultaJurosRecibo')).Text := '(+) Juros/Multa';
      TfrxMemoView(ARelatorio.FindObject('lblMoraMultaJurosFicha')).Text  := '(+) Juros/Multa';
      TfrxMemoView(ARelatorio.FindObject('lblCodBaixaCX')).Visible        := True;
      TfrxMemoView(ARelatorio.FindObject('lblCodBaixaFicha')).Visible     := True;
      TfrxMemoView(ARelatorio.FindObject('lblCodBaixaRecibo')).Visible    := True;

      TfrxMemoView(ARelatorio.FindObject('rllCarNN1')).Text := 'Nosso Número';
      TfrxMemoView(ARelatorio.FindObject('rllNN1')).Text := 'Nosso Número';
      TfrxMemoView(ARelatorio.FindObject('rllNN2')).Text := 'Nosso Número';
      TfrxMemoView(ARelatorio.FindObject('rllNN3')).Text := 'Nosso Número';

      TfrxMemoView(ARelatorio.FindObject('rllLinDig')).Visible := False;

      ARelatorio.Script.Variables['NOSNUM'] := TRetornoBoletoBancoDoBrasil(LRetornoRegistroBoletoApi).nossoNumero;
      ARelatorio.Script.Variables['CARNOSNUM'] := TRetornoBoletoBancoDoBrasil(LRetornoRegistroBoletoApi).nossoNumero;

      ARelatorio.Script.Variables['INST01'] := IIF(fltVlrMor > 0, 'MORA DIARIA DE ' + FormatFloat('R$ #,##0.00', fltVlrMor) + '         ', '') +
                                               IIF(fltVlrMul > 0, 'APÓS O VENCIMENTO COBRAR MULTA DE ' + FormatFloat('R$ #,##0.00', fltVlrMul), '');

      ARelatorio.Script.Variables['INST02'] := '';
      If StrToIntDef(strPraPro,0) > 0 Then
        ARelatorio.Script.Variables['INST02'] :=  'PROTESTAR NO ' + strPraPro + '° DIA ' + IIF((StrToIntDef(strPraPro,0) <= 5), 'ÚTIL', 'CORRIDO') + ' APÓS O VENCIMENTO';


      ARelatorio.Script.Variables['INST03'] := strInstr1;
      ARelatorio.Script.Variables['INST04'] := strInstr2;
      ARelatorio.Script.Variables['INST05'] := strInstr3;
      ARelatorio.Script.Variables['INST06'] := strInstr4;
      ARelatorio.Script.Variables['INST07'] := strInstr5;
      ARelatorio.Script.Variables['INST08'] := '';
      ARelatorio.Script.Variables['OUTACR'] := '';

      If Length(Trim(strNuInSa)) > 11 Then
        ARelatorio.Script.Variables['INSSAC'] := fMaskCNPJ(strNuInSa)
      Else ARelatorio.Script.Variables['INSSAC'] := fMaskCPF(strNuInSa);

      ARelatorio.Script.Variables['ENDSAC'] := strEndSac + ' - ' + strBaiSac;
      ARelatorio.Script.Variables['CIDSAC'] := fMaskCEP(strCep001) + ' - ' + strCidSac + ' - ' + strEstSac;

      ARelatorio.Script.Variables['LINDIG'] := strLinDig;
      TfrxBarCodeView(ARelatorio.FindObject('barCodigo')).Text := strCodBar;

      TfrxBand(ARelatorio.FindObject('rlbCompEntr')).Visible := blnProEnt;
      TfrxBand(ARelatorio.FindObject('rlbCompEntrCut')).Visible := blnProEnt;
      TfrxBand(ARelatorio.FindObject('rlbCompEntrN1')).Visible := Not (blnProEnt Or LImpAgrupamento);
      TfrxBand(ARelatorio.FindObject('rlbCompEntrN2')).Visible := Not (blnProEnt Or LImpAgrupamento);

      {********************************************************}
      {* LAYOUT DE BOLETO EM DUAS VIAS (FICHA DE COMPENSAÇÃO E*}
      {* RECIBO DO PAGADOR                                    *}
      {*****************************************************GD*}
      if fCfgSis('NOVLAY', varString) = 'D' then
      begin
        TfrxBand(ARelatorio.FindObject('rlbFichaCaixa')).Visible    := False;
        TfrxBand(ARelatorio.FindObject('rlbFichaCaixaCut')).Visible := False;
        if not LImpAgrupamento  then
          TfrxBand(ARelatorio.FindObject('rlbCompEntrN1')).Visible := False;

        If (Not fEmptyStr(fCfgSis('IMGBOL'))) and FileExists(fCfgSis('IMGBOL')) Then
        begin
          TfrxBand(ARelatorio.FindObject('rlbReciboSac')).Visible              := False;
          TfrxBand(ARelatorio.FindObject('rlbReciboPagadorComImagem')).Visible := True;
          TfrxPictureView(ARelatorio.FindObject('imgLogo2')).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoBrasil.bmp');
          TfrxPictureView(ARelatorio.FindObject('imgLogoEmpresa')).Picture.LoadFromFile(fCfgSis('IMGBOL'));
        end;
      end;

      If blnProEnt Then
        TfrxBand(ARelatorio.FindObject('rlbFichaCaixaCut')).Height := TfrxBand(ARelatorio.FindObject('rlbFichaCaixaCut')).Height + 18;

      TfrxBand(ARelatorio.FindObject('rlbFichaCompensacaoPix')).Visible := False;
      TfrxBand(ARelatorio.FindObject('rlbFichaComp')).Visible := True;

      If Not TRetornoBoletoBancoDoBrasil(LRetornoRegistroBoletoApi).QrCodeTxId.IsEmpty Then
      Begin
        AQRCodePix.Dataset.Open;
        AQRCodePix.Dataset.Append;
        AQRCodePix.Dataset.FieldByName('QRCODEPIX').AsString := TRetornoBoletoBancoDoBrasil(LRetornoRegistroBoletoApi).QrCodeEmv;
        AQRCodePix.Dataset.Post;

        TfrxBand(ARelatorio.FindObject('rlbFichaComp')).Visible := False;
        TfrxBand(ARelatorio.FindObject('rlbFichaCompensacaoPix')).Visible := True;
        TfrxBarCodeView(ARelatorio.FindObject('BarCode1')).Text := strCodBar;
      End;
    Except
      On E: Exception Do
      Begin
        MessageDlg(E.Message,mtError,[mbOK],0);
        Result := False;
      End;
    End;

  End;

End;

function GeraBoletoBancoCredisis097(Var ARelatorio: TfrxReport; Var AAgrupamento: TfrxDBDataSet): Boolean;
  Var
    LContador: Integer;

    LogoBancoCredisis : String;
    LCodCed : String;
Begin

  Result := RetornaLinhaDigitavelBancoCredisis097;

  If Result Then
  Begin

    LogoBancoCredisis := 'LogoBancoCredisis' + strNumAge + '.png'; //Para pegar no padrao LogoBancoCredisis0011.png - "0011 - Capital Credi";

    Result := FileExists(ExtractFilePath(Application.ExeName) + '\LogoBoletos\' + LogoBancoCredisis);

    //Se não existe o logo pela agência então pega o logo credisisSistema
    If Not Result Then
    Begin

       LogoBancoCredisis := 'LogoBancoCredisisSistema.png';

       Result := FileExists(ExtractFilePath(Application.ExeName) + '\LogoBoletos\'+LogoBancoCredisis);
       If Not Result Then
       Begin
          pMensagemOk('O logo ' + ExtractFilePath(Application.ExeName) + 'LogoBoletos\'+LogoBancoCredisis+' deve existir na pasta indicada.');
          Exit;
       End;

    End;

    Try
      AAgrupamento.DataSet := fCriaQuery;

      For LContador := 1 To 4 Do
        TfrxPictureView(ARelatorio.FindObject('imgLog' + IntToStr(LContador))).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\'+LogoBancoCredisis);

      ARelatorio.Script.Variables['CODBCO'] := '097-3';

      ARelatorio.FindObject('rlbTelSac').Visible := False;
      ARelatorio.FindObject('rllTelSac').Visible := False;

      ARelatorio.Script.Variables['NOMCED'] := strNomCed;
      If Trim(strNumIns) <> '' Then
        ARelatorio.Script.Variables['NOMCED'] := strNomCed + '   ' + IIF(strTipIns = '01',
                                                                         fMaskCNPJ(strNumIns),
                                                                         fMaskCPF(strNumIns));

      ARelatorio.Script.Variables['ENDCED'] := strEndere;
      ARelatorio.Script.Variables['ENDAVA'] := '';
      ARelatorio.Script.Variables['USOBCO'] := '';

      LCodCed := strCodCed;
      Insert('-', LCodCed, 8);

      ARelatorio.Script.Variables['BENEFI'] := 'Beneficiário';
      ARelatorio.Script.Variables['BENEFI2']:= 'BENEFICIÁRIO';
      ARelatorio.Script.Variables['ESPMOE'] := 'Espécie';
      ARelatorio.Script.Variables['VALMOE'] := 'Valor';
      ARelatorio.Script.Variables['PAGADO'] := 'Pagador';
      ARelatorio.Script.Variables['AGECED'] := strNumAge + '/' + LCodCed;
      ARelatorio.Script.Variables['NOMSAC'] := strNomSac;
      ARelatorio.Script.Variables['DTAVEN'] := FormatDateTime('dd/mm/yyyy', dtaDtaVen);
      ARelatorio.Script.Variables['NUMDOC'] := IfThen(strImprimirParcela = 'S', strNumDoc, LeftStr(strNumDoc, Length(strNumDoc) - 1));
      ARelatorio.Script.Variables['VALDOC'] := FormatFloat('R$ #,##0.00',fStrToFloat(strVlrTit)/100);
      ARelatorio.Script.Variables['LOCEXT'] := '';
      ARelatorio.Script.Variables['LOCPAG'] := 'Preferencialmente nas Agências CrediSIS.';
      ARelatorio.Script.Variables['DTADOC'] := FormatDateTime('dd/mm/yyyy', dtaDtaEmi);
      ARelatorio.Script.Variables['ESPDOC'] := strEspDoc;
      ARelatorio.Script.Variables['DTAPRO'] := FormatDateTime('dd/mm/yyyy', dtaDtaPro);
      ARelatorio.Script.Variables['CARTEI'] := strCodCar;
      ARelatorio.Script.Variables['CART02'] := '';
      ARelatorio.Script.Variables['ACEITE'] := IIF(strIdeAce = 'S', 'A', 'N');
      ARelatorio.Script.Variables['CEDENT'] := 'Código do Beneficiário';

      //***Comentado para seguir o boleto exemplo enviado pelo webservice, mostranso apenas no nome e o cnpj do sacador avalista. ***
     {If Trim(strNumIns) <> '' Then
      Begin
        If strTipIns = '01' Then
          ARelatorio.Script.Variables['NOMCED'] := IIF(fEmptyStr(strBenefi), strNomCed + '   ' + fMaskCNPJ(strNumIns), strBenefi)
        Else
          ARelatorio.Script.Variables['NOMCED'] := IIF(fEmptyStr(strBenefi), strNomCed + '   ' + fMaskCPF(strNumIns), strBenefi);
      End
      Else
        ARelatorio.Script.Variables['NOMCED'] := IIF(fEmptyStr(strBenefi), strNomCed, strBenefi);

      ARelatorio.Script.Variables['ENDCED'] := IIF(fEmptyStr(strBenefi), strEndere, strEndBen); }
      ARelatorio.Script.Variables['SACAVA'] := strBenefi; //IIF(fEmptyStr(strBenefi), '', strNomCed + IfThen(Not fEmptyStr(strNumIns),' - ' + IIF(strTipIns = '01', fMaskCNPJ(strNumIns), fMaskCPF(strNumIns)), ''));
      //ARelatorio.Script.Variables['ENDAVA'] := IIF(fEmptyStr(strBenefi), '', strEndere);

      TfrxMemoView(ARelatorio.FindObject('rllCarNN1')).Text := 'Nosso Número';

      TfrxMemoView(ARelatorio.FindObject('rllNN1')).Text := 'Nosso Número';
      TfrxMemoView(ARelatorio.FindObject('rllNN2')).Text := 'Nosso Número';
      TfrxMemoView(ARelatorio.FindObject('rllNN3')).Text := 'Nosso Número';

      ARelatorio.FindObject('rllLinDig').Visible := True;

      ARelatorio.Script.Variables['NOSNUM'] := TRetornoBoletoBancoCredisis(LRetornoRegistroBoletoApi).nossoNumero;
      ARelatorio.Script.Variables['CARNOSNUM'] := TRetornoBoletoBancoCredisis(LRetornoRegistroBoletoApi).nossoNumero;

      ARelatorio.Script.Variables['INST01'] := RetornaObservacaoMultaCredisis(dtaDtaVen);
      ARelatorio.Script.Variables['INST02'] := RetornaObservacaoJurosCredisis(dtaDtaVen);
      ARelatorio.Script.Variables['INST03'] := strInstr1;
      ARelatorio.Script.Variables['INST04'] := strInstr2;
      ARelatorio.Script.Variables['INST05'] := strInstr3;
      ARelatorio.Script.Variables['INST06'] := strInstr4;
      ARelatorio.Script.Variables['INST07'] := strInstr5;
      ARelatorio.Script.Variables['INST08'] := '';
      ARelatorio.Script.Variables['OUTACR'] := '';

      ARelatorio.Script.Variables['INSSAC'] := IIF(strNuInSa.Trim.Length > 11, fMaskCNPJ(strNuInSa), fMaskCPF(strNuInSa));

      ARelatorio.Script.Variables['ENDSAC'] := strEndSac + ' - ' + strBaiSac;
      ARelatorio.Script.Variables['CIDSAC'] := fMaskCEP(strCep001) + ' - ' + strCidSac + ' - ' + strEstSac;

      ARelatorio.Script.Variables['LINDIG'] := strLinDig;

      TfrxBarCodeView(ARelatorio.FindObject('barCodigo')).Text := strCodBar;

      TfrxBand(ARelatorio.FindObject('rlbCompEntr')).Visible := blnProEnt;
      TfrxBand(ARelatorio.FindObject('rlbCompEntrCut')).Visible := blnProEnt;
      TfrxBand(ARelatorio.FindObject('rlbCompEntrN1')).Visible := False;
      TfrxBand(ARelatorio.FindObject('rlbCompEntrN2')).Visible := False;

      TfrxMemoView(ARelatorio.FindObject('memo29')).Text  := 'REAL';
      TfrxMemoView(ARelatorio.FindObject('memo69')).Text  := 'REAL';
      TfrxMemoView(ARelatorio.FindObject('memo130')).Text := 'REAL';
      TfrxMemoView(ARelatorio.FindObject('memo191')).Text := 'REAL';

    Except
      On E: Exception Do
      Begin
        MessageDlg(E.Message,mtError,[mbOK],0);
        Result := False;
      End;
    End;

  End;

End;

function GeraBoletoBancoSicrediApi(Var ARelatorio: TfrxReport; Var AAgrupamento: TfrxDBDataSet; Var AQRCodePix: TfrxDBDataSet): Boolean;
  Var
    LContador: Integer;

    LImpAgrupamento: Boolean;
    strAgeDig,
    strTmpNN,
    strCaAgNs,
    strPostoAg,
    strCooperativa: String;
Begin
  Result := RetornaLinhaDigitavelBancoSicrediApi;

  If Result Then
  Begin
    If Not FileExists(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoSicredi.bmp') Then
    Begin
      Result := False;
      pMensagemOk('O logo ' + ExtractFilePath(Application.ExeName) + 'LogoBoletos\LogoSicredi.bmp deve existir na pasta indicada.');
      Exit;
    End;

    Try

        If strEspeci = 'AG' Then
          AAgrupamento.DataSet := fQryAgrupamento(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, strCodCli)
        Else
          AAgrupamento.DataSet := fCriaQuery;

        LImpAgrupamento := (Not AAgrupamento.DataSet.IsEmpty) And (fCfgSis('MDBLAG', varInteger) = 2);
        If LImpAgrupamento Then
        Begin
          TfrxBand(ARelatorio.FindObject('rlbAgrupamento')).Visible := True;
          TfrxBand(ARelatorio.FindObject('rlbReciboSac')).Visible := False;
          TfrxBand(ARelatorio.FindObject('rlbReciboSacCut')).Visible := False;

          If (Not fEmptyStr(fCfgSis('IMGBOL'))) and FileExists(fCfgSis('IMGBOL')) Then
            TfrxPictureView(ARelatorio.FindObject('imgLogo')).Picture.LoadFromFile(fCfgSis('IMGBOL'));

          ARelatorio.Script.Variables['NUMPARC'] := fRetNumParcela(RightStr(strNumDoc, 1));
          ARelatorio.Script.Variables['TOTPARC'] := fQtdParcelas(LeftStr(strNumDoc, fTamDocCadRec), strCodEmp, 'AG', strCodCli);
          ARelatorio.Script.Variables['MAILCLI'] := strMailCli;
        End;

        For LContador := 1 To 4 Do
          TfrxPictureView(ARelatorio.FindObject('imgLog' + IntToStr(LContador))).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoSicredi.bmp');

        ARelatorio.Script.Variables['CODBCO'] := '748-X';

        ARelatorio.FindObject('rlbTelSac').Visible := False;
        ARelatorio.FindObject('rllTelSac').Visible := False;
        ARelatorio.FindObject('rllLinDig').Visible := False;

        TfrxMemoView(ARelatorio.FindObject('memo29')).Text  := 'REAL';
        TfrxMemoView(ARelatorio.FindObject('memo69')).Text  := 'REAL';
        TfrxMemoView(ARelatorio.FindObject('memo130')).Text := 'REAL';
        TfrxMemoView(ARelatorio.FindObject('memo191')).Text := 'REAL';

        If Trim(strNumIns) <> '' Then
        Begin
          If strTipIns = '01' Then
            ARelatorio.Script.Variables['NOMCED'] := IIF(fEmptyStr(strBenefi), strNomCed + '   ' + fMaskCNPJ(strNumIns), strBenefi)
          Else
            ARelatorio.Script.Variables['NOMCED'] := IIF(fEmptyStr(strBenefi), strNomCed + '   ' + fMaskCPF(strNumIns), strBenefi);
        End
        Else
          ARelatorio.Script.Variables['NOMCED'] := IIF(fEmptyStr(strBenefi), strNomCed, strBenefi);

        ARelatorio.Script.Variables['ENDCED'] := IIF(fEmptyStr(strBenefi), strEndere, strEndBen);
        ARelatorio.Script.Variables['SACAVA'] := IIF(fEmptyStr(strBenefi), '', strNomCed + IfThen(Not fEmptyStr(strNumIns), ' - ' + IIF(strTipIns = '01', fMaskCNPJ(strNumIns), fMaskCPF(strNumIns)), ''));
        ARelatorio.Script.Variables['ENDAVA'] := IIF(fEmptyStr(strBenefi), '', strEndere);
        ARelatorio.Script.Variables['USOBCO'] := '';

        strPostoAg     := TRetornoBoletoBancoSicredi(LRetornoRegistroBoletoApi).posto;
        strCooperativa := TRetornoBoletoBancoSicredi(LRetornoRegistroBoletoApi).cooperativa;

        strAgedig := strCooperativa +'.'+ strPostoAg +'.'+ strCodCed;

        //strAgeDig := strNumAge + fStrZero(strCodCed, 7);
        //Insert('.', strAgeDig, 5);
        //Insert('.', strAgeDig, 8);

        ARelatorio.Script.Variables['BENEFI'] := 'Beneficiário';
        ARelatorio.Script.Variables['BENEFI2']:= 'BENEFICIÁRIO';
        ARelatorio.Script.Variables['ESPMOE'] := 'Esp. Moeda';
        ARelatorio.Script.Variables['VALMOE'] := 'Valor da Moeda';
        ARelatorio.Script.Variables['PAGADO'] := 'Pagador';
        ARelatorio.Script.Variables['AGECED'] := strAgeDig;
        ARelatorio.Script.Variables['NOMSAC'] := strNomSac;
        ARelatorio.Script.Variables['DTAVEN'] := FormatDateTime('dd/mm/yyyy', dtaDtaVen);
        ARelatorio.Script.Variables['NUMDOC'] := IfThen(strImprimirParcela = 'S', strNumDoc, LeftStr(strNumDoc, Length(strNumDoc) - 1));
        ARelatorio.Script.Variables['VALDOC'] := FormatFloat('R$ #,##0.00',fStrToFloat(strVlrTit)/100);
        ARelatorio.Script.Variables['LOCEXT'] := '';
        ARelatorio.Script.Variables['LOCPAG'] := 'PAGÁVEL PREFERENCIALMENTE EM CANAIS ELETRONICOS DA SUA INSTITUICAO FINANCEIRA.';
        ARelatorio.Script.Variables['DTADOC'] := FormatDateTime('dd/mm/yyyy', dtaDtaEmi);
        ARelatorio.Script.Variables['ESPDOC'] := 'DMI';
        ARelatorio.Script.Variables['DTAPRO'] := FormatDateTime('dd/mm/yyyy', dtaDtaPro);
        ARelatorio.Script.Variables['CARTEI'] := strCodCar;
        ARelatorio.Script.Variables['CART02'] := '';
        ARelatorio.Script.Variables['ACEITE'] := IIF(strIdeAce = 'S', 'S', 'N');
        ARelatorio.Script.Variables['CEDENT'] := 'Cód. Beneficiário';

        strTmpNN := strNosNum;
        Insert('/', strTmpNN, 3);
        Insert('-', strTmpNN, 10);

        TfrxMemoView(ARelatorio.FindObject('rllCarNN1')).Text := 'Cart./Nosso Número';

        TfrxMemoView(ARelatorio.FindObject('rllNN1')).Text := 'Nosso Número';
        TfrxMemoView(ARelatorio.FindObject('rllNN2')).Text := 'Nosso Número';
        TfrxMemoView(ARelatorio.FindObject('rllNN3')).Text := 'Nosso Número';

        ARelatorio.Script.Variables['NOSNUM'] := strTmpNN;
        ARelatorio.Script.Variables['CARNOSNUM'] := strCaAgNs + strTmpNN;

        ARelatorio.Script.Variables['INST01'] := RetornaObservacaoMultaSicrediApi() + RetornaObservacaoJurosSicrediApi();

        If StrToIntDef(strPraPro,0) >= 1 Then
          ARelatorio.Script.Variables['INST02'] := 'PROTESTAR APÓS ' + strPraPro + ' DIAS ' + IIF(StrToInt(strPraPro) > 4, 'CORRIDOS', 'ÚTEIS') + ' DO VENCIMENTO'
        Else
          ARelatorio.Script.Variables['INST02'] := '';

        ARelatorio.Script.Variables['INST03'] := strInstr1;
        ARelatorio.Script.Variables['INST04'] := strInstr2;
        ARelatorio.Script.Variables['INST05'] := strInstr3;
        ARelatorio.Script.Variables['INST06'] := strInstr4;
        ARelatorio.Script.Variables['INST07'] := strInstr5;
        ARelatorio.Script.Variables['INST08'] := '';
        ARelatorio.Script.Variables['OUTACR'] := '';

        If Length(Trim(strNuInSa)) > 11 Then
          ARelatorio.Script.Variables['INSSAC'] := fMaskCNPJ(strNuInSa)
        Else ARelatorio.Script.Variables['INSSAC'] := fMaskCPF(strNuInSa);

        ARelatorio.Script.Variables['ENDSAC'] := strEndSac + ' - ' + strBaiSac;
        ARelatorio.Script.Variables['CIDSAC'] := fMaskCEP(strCep001) + ' - ' + strCidSac + ' - ' + strEstSac;

        ARelatorio.Script.Variables['LINDIG'] := strLinDig;
        TfrxBarCodeView(ARelatorio.FindObject('barCodigo')).Text := strCodBar;

        TfrxBand(ARelatorio.FindObject('rlbCompEntr')).Visible := blnProEnt;
        TfrxBand(ARelatorio.FindObject('rlbCompEntrCut')).Visible := blnProEnt;
        TfrxBand(ARelatorio.FindObject('rlbCompEntrN1')).Visible := Not (blnProEnt Or LImpAgrupamento);
        TfrxBand(ARelatorio.FindObject('rlbCompEntrN2')).Visible := Not (blnProEnt Or LImpAgrupamento);

        {********************************************************}
        {* LAYOUT DE BOLETO EM DUAS VIAS (FICHA DE COMPENSAÇÃO E*}
        {* RECIBO DO PAGADOR                                    *}
        {*****************************************************GD*}
        if fCfgSis('NOVLAY', varString) = 'D' then
        begin
          TfrxBand(ARelatorio.FindObject('rlbFichaCaixa')).Visible    := False;
          TfrxBand(ARelatorio.FindObject('rlbFichaCaixaCut')).Visible := False;
          if not LImpAgrupamento  then
            TfrxBand(ARelatorio.FindObject('rlbCompEntrN1')).Visible := False;

          If (Not fEmptyStr(fCfgSis('IMGBOL'))) and FileExists(fCfgSis('IMGBOL')) Then
          begin
            TfrxBand(ARelatorio.FindObject('rlbReciboSac')).Visible              := False;
            TfrxBand(ARelatorio.FindObject('rlbReciboPagadorComImagem')).Visible := True;
            TfrxPictureView(ARelatorio.FindObject('imgLogo2')).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoSicredi.bmp');
            TfrxPictureView(ARelatorio.FindObject('imgLogoEmpresa')).Picture.LoadFromFile(fCfgSis('IMGBOL'));
          end;
        end;

        If blnProEnt Then
          TfrxBand(ARelatorio.FindObject('rlbFichaCaixaCut')).Height := TfrxBand(ARelatorio.FindObject('rlbFichaCaixaCut')).Height + 18;

        If Not TRetornoBoletoBancoSicredi(LRetornoRegistroBoletoApi).QrCodeTxId.IsEmpty Then
        Begin
          AQRCodePix.Dataset.Open;
          AQRCodePix.Dataset.Append;
          AQRCodePix.Dataset.FieldByName('QRCODEPIX').AsString := TRetornoBoletoBancoSicredi(LRetornoRegistroBoletoApi).QrCodeEmv;
          AQRCodePix.Dataset.Post;

          TfrxBand(ARelatorio.FindObject('rlbFichaComp')).Visible := False;
          TfrxBand(ARelatorio.FindObject('rlbFichaCompensacaoPix')).Visible := True;
          TfrxBarCodeView(ARelatorio.FindObject('BarCode1')).Text := strCodBar;
        End;
    Except
      On E: Exception Do
      Begin
        MessageDlg(E.Message,mtError,[mbOK],0);
        Result := False;
      End;
    End;
  End;

End;

function fProcessarArquivo(strLines: String; blnImpPdf: Boolean; var ABoletoCarneBuilder : TBoletoCarneBuilder; var ABoleto1ViaBuilder : TBoleto1Via_ComprovanteBuilder;
  strNomeForm: String = ''; strNomeFila: String = ''; blnForcarImp: Boolean = False; blnEnvioDeEmailAutomatico: Boolean = False; blnBolEnvEmail: Boolean = False; blnEnvioFaturamento: Boolean = False): Boolean;
Begin
  //Result := True;

  If Not DirectoryExists(ExtractFilePath(Application.ExeName) + 'Boletos') Then
    CreateDir(ExtractFilePath(Application.ExeName) + 'Boletos');

  strIdeBan := Trim(Copy(strLines, 001,03));       // IDENTIFICAÇÃO DO BANCO
  strTipIns := Trim(Copy(strLines, 004,02));       // TIPO DE INSCRIÇÃO 01/02 - CNPJ/CPF
  strNumIns := Trim(Copy(strLines, 006,14));       // NÚMERO DA INSCRIÇÃO DO CEDENTE
  strNomCed := Trim(Copy(strLines, 020,60));       // NOME DO CEDENTE
  strNumAge := Trim(Copy(strLines, 080,04));       // NÚMERO DA AGÊNCIA
  strCodCed := Trim(Copy(strLines, 084,20));       // CÓDIGO DO CEDENTE
  strNosNum := Trim(Copy(strLines, 104,15));       // NOSSO NÚMERO
  strNumDup := Trim(Copy(strLines, 107,07));       // NÚMERO DA DUPLICATA (SEM O DÍGITO)
  strNumDoc := Trim(Copy(strLines, 119,15));       // NÚMERO DO DOCUMENTO
  strEspDoc := Trim(Copy(strLines, 134,07));       // ESPÉCIE DO DOCUMENTO
  strCodCar := Trim(Copy(strLines, 177,03));       // CÓDIGO DA CARTEIRA
  strEspTit := Trim(Copy(strLines, 180,04));       // ESPÉCIE DO TITULO (R$)
  strIdeAce := Trim(Copy(strLines, 184,01));       // IDENTIFICAÇÃO ACEITE
  strTipISa := Trim(Copy(strLines, 215,02));       // TIPO DE INSCR. SACADO
  strNuInSa := Trim(Copy(strLines, 217,14));       // NÚMERO DA INSCR. SACADO
  strNomSac := Trim(Copy(strLines, 231,40));       // NOME DO SACADO
  strEndSac := Trim(Copy(strLines, 271,140));       // ENDEREÇO DO SACADO
  strBaiSac := Trim(Copy(strLines, 411,60));       // BAIRRO DO SACADO
  strCep001 := Trim(Copy(strLines, 471,08));       // CEP DO SACADO
  strCidSac := Trim(Copy(strLines, 479,40));       // CIDADE DO SACADO
  strEstSac := Trim(Copy(strLines, 519,02));       // UF DO SACADO
  strSacAva := Trim(Copy(strLines, 521,40));       // SACADO/AVALISTA
  strPraPro := Trim(Copy(strLines, 561,02));       // PRAZO PARA PROTESTO
  strLocPag := Trim(Copy(strLines, 563,60));       // LOCAL DE PAGAMENTO
  strUsoBan := Trim(Copy(strLines, 623,10));       // USO DO BANCO
  strInstr1 := Trim(Copy(strLines, 633,60));       // INSTRUÇÃO 1
  strInstr2 := Trim(Copy(strLines, 693,60));       // INSTRUÇÃO 2
  strInstr3 := Trim(Copy(strLines, 753,60));       // INSTRUÇÃO 3
  strInstr4 := Trim(Copy(strLines, 813,60));       // INSTRUÇÃO 4
  strInstr5 := Trim(Copy(strLines, 873,60));       // INSTRUÇÃO 5
  strNumCon := Trim(Copy(strLines, 933,07));       // NÚMERO DO CONVÊNIO
  strDigAge := Trim(Copy(strLines, 940,01));       // DÍGITO DA AGÊNCIA
  strCodCli := Trim(Copy(strLines, 941,08));       // CODIGO DO CLIENTE
  strModCob := Trim(Copy(strLines, 949,04));       // MODALIDADE DE COBRANCA
  blnProEnt := Trim(Copy(strLines, 967,01)) = 'S'; // IMPRIME PROTOCOLO DE ENTREGA
  strVariac := Trim(Copy(strLines, 974,03));       // VARIACAO
  strEndere := Trim(Copy(strLines, 991,160));      // ENDEREÇO COMPLETO DO CEDENTE
  strIdeCed := Trim(Copy(strLines,1151,006));      // IDENTIFICAÇÃO DO CEDENTE
  strUsoCli := Trim(Copy(strLines,1157,017));      // USO DO CLIENTE
  strDigCed := Trim(Copy(strLines,1174,002));      // DIGITO DO CEDENTE
  strTipDia := Trim(Copy(strLines,1176,001));      // TIPO DE DIAS PARA PROTESTO
  strObsSac	:= Trim(Copy(strLines,1222,040));			 // SACADOR/AVALISTA NOME + CPF/CNPJ
  strTpIden := Trim(Copy(strLines,1262,001));      // TIPO IDENTIFICADOR, COBRANÇA SEM REGISTRO, 399_HSBC *BB*
  strCdIns1 := Trim(Copy(strLines,1493,002));      // CÓDIGO DA PRIMERIA INSTRUÇÃO
  strCdIns2 := Trim(Copy(strLines,1495,002));      // CÓDIGO DA SEGUNDA INSTRUÇÃO
  strCodEmp := Trim(Copy(strLines,1497,003));      // CÓDIGO DA SEGUNDA INSTRUÇÃO
  strMailCli:= Trim(Copy(strLines,1500,255));      // Email do cliente
  strBcoIni := Trim(Copy(strLines,1755,003));      // Banco Inicial
  strBenefi := Trim(Copy(strLines,1758,080));      // Sacador/Avalista
  strEndBen := Trim(Copy(strLines,1838,180));      // Endereço Sacador/Avalista
  strChaveBRB := Trim(Copy(strLines,2018,040));    // Chave BRB
  strConRem := Trim(Copy(strLines,2058,020));      // Sequencial que substitui a nossa chave para o banco BRB
  blnObsDes := Trim(Copy(strLines, 2708, 001)) = 'S'; // DESTACA OBSERVACAO 5
  {*************************************}
  {* PASSA A SUPORTAR ATÉ 120 POSIÇÕES *}
  {**********************************JS*}
  strInstr3 := Trim(Copy(strLines, 2092,120));
  strInstr4 := Trim(Copy(strLines, 2212,120));
  strInstr5 := Trim(Copy(strLines, 2332,120));
  strImpAgBenef := Trim(Copy(strLines, 2452, 001));

  {*********************************}
  {* DADOS DA COOPERATIVA UNIPRIME *}
  {******************************MO*}
  strRazaoSocialCooperativa := Trim(Copy(strLines, 2453, 060));
  strIncrisaoCooperativa    := Trim(Copy(strLines, 2513, 019));
  strEnderecoCoopetativa    := Trim(Copy(strLines, 2532, 060));
  strBairroCooperativa      := Trim(Copy(strLines, 2592, 040));
  strCidadeCooperativa      := Trim(Copy(strLines, 2632, 040));
  strEstadoCooperativa      := Trim(Copy(strLines, 2672, 002));
  strCEPCooperativa         := Trim(Copy(strLines, 2674, 009));
  strCodProt                := Trim(Copy(strLines, 2683, 001));

  strImprimirParcela        := Trim(Copy(strLines, 2684, 001));

  strEspDocOriginal         := Trim(Copy(strLines, 2685, 005));
  strNumDocumentoSemParcela := Trim(Copy(strLines, 2690, 012));
  strParcelaDoDocumento     := Trim(Copy(strLines, 2702, 003));

  ADiasCartorio             := Trim(Copy(strLines, 2705, 002));
  blnParNum                 := (Trim(Copy(strLines, 2707, 001)) = 'S') And (fCfgSis('PARNUM') = 'S');
  strInfAdi                 := Trim(Copy(strLines, 2709, 007));      // INFORMAÇÃO ADICIONAL (CARTEIRA)

  strCodigoCedenteBancoInter := Trim(Copy(strLines, 2716, 009));
  strInstrucao1BancoInter := Trim(Copy(strLines, 2725, 078));
  strInstrucao2BancoInter := Trim(Copy(strLines, 2803, 078));
  strInstrucao3BancoInter := Trim(Copy(strLines, 2881, 078));
  strInstrucao4BancoInter := Trim(Copy(strLines, 2959, 078));
  strInstrucao5BancoInter := Trim(Copy(strLines, 3037, 078));
  strNroOpe               := Trim(Copy(strLines, 3115, 007));      // NUMERO DA OPERACAO BANCO 246;

  LObservacaoAG1 := Trim(Copy(strLines, 3122, 120));
  LObservacaoAG2 := Trim(Copy(strLines, 3242, 120));
  LObservacaoAG3 := Trim(Copy(strLines, 3362, 120));
  LObsCompletaAG := Trim(Copy(strLines, 3482, 001));
  LIdentificacaoBanco :=  Trim(Copy(strLines, 3483, 020));

  FApresentarEspDocumento := Trim(Copy(strLines, 3503, 001));

  strDiaMora     := Trim(Copy(strLines, 3504, 010));
  strNumOperacao := Trim(Copy(strLines, 3514, 020));
  strBcoInicialCompleto := Trim(Copy(strLines, 3534, 020));

  FQRCode := Trim(Copy(strLines, 3554, 390));
  FExibirParcelasEmNegritoCarne := (Trim(Copy(strLines, 3944, 001)) = 'S') And (fCfgSis('NOVLAY') = 'C');
  strCodCartBoleto := Trim(Copy(strLines, 3945, 003));

  //************************************//
  // VALOR DA MULTA                     //
  //*********************************ED*//
  fltVlrMul := StrToCurr(Trim(Copy(strLines, 1177,12) + ',' +
                              Copy(strLines, 1189,02)));

  fltPerMul := StrToCurr(Trim(Copy(strLines, 2078,12) + ',' +
                              Copy(strLines, 2090,02)));

  fltPerMor := StrToCurr(Trim(Copy(strLines, 953,12) + ',' +
                              Copy(strLines, 965,02)));

  If Not Copy(strLines, 1191,12).Contains(',') Then
    fltOutAcr := StrToCurr(Trim(Copy(strLines, 1191,12) + ',' +
                                Copy(strLines, 1203,02)))
  Else
    fltOutAcr := StrToCurr(Trim(Copy(strLines, 1191,12) +
                                Copy(strLines, 1203,02)));

  If fEmptyStr(Trim(strTipDia)) Then
    strTipDia := '1';

  fltDesBol := StrToCurr(Trim(Copy(strLines, 977,12) + ',' +
                              Copy(strLines, 989,02))); // DESCONTO PARA PAGAMENTO A VISTA

  If strIdeBan = '041' Then
  Begin
    strDigAge := Trim(Copy(strLines, 968,02));       // DÍGITO DA AGÊNCIA
    strCodCar := Trim(Copy(strLines, 970,04));       // CÓDIGO DA CARTEIRA
  End;

  If (strIdeBan = '995') Or (strIdeBan = '988') Or (strIdeBan = '981') Or (strIdeBan = '964') Then
  begin
    strIdeFac := strIdeBan;
    strIdeBan := '341';
  end
  else
  begin
    strIdeFac := '';
  end;

  blnSantan637_444p := False;
  If (strIdeBan = '637') Then
  Begin
      If (strBcoInicialCompleto = '637LP444p') Then
      Begin
         strBcoIni := strBcoInicialCompleto;
      End
      Else
      Begin
        blnSantan637_444p := True;
        strIdeBan := '33B';
      End;
  End;

  If (strIdeBan = '274') Then
  Begin
      If (strBcoInicialCompleto = '274LP400p') Then
          strBcoIni := strBcoInicialCompleto;
  End;

  //*****************************************************//
  // VERIFICA SE A VARIVEL COM O CODIGO DO CLIENTE ESTA  //
  // PREENCHIDA, SE ESTIVER ENTAO CONCATENA COM O NOME   //
  // DO SACADO (CLIENTE)                                 //
  //**************************************************ED*//
  If Trim(strCodCli) <> '' Then
  Begin
    strNomSac := Trim(strCodCli) + ' - ' + Trim(strNomSac);
  End;


  //************************************//
  // VALIDA A DATA DO VENCIMENTO        //
  //*********************************ED*//
  If Not fValidaData('139 á 148 ', Copy(strLines, 141,02) +
                            Copy(strLines, 143,02) +
                            Copy(strLines, 145,04)
                          , 'Data de Vencimento') Then
  Begin
    Result := False;
    Exit;
  End;

  dtaDtaVen := StrToDate(Trim(Copy(strLines, 141,02) + '/' +
                              Copy(strLines, 143,02) + '/' +
                              Copy(strLines, 145,04)));

  //************************************//
  // VALIDA A DATA DA EMISSÃO           //
  //*********************************ED*//
  If Not fValidaData('183 á 190 ', Copy(strLines, 185,02) +
                            Copy(strLines, 187,02) +
                            Copy(strLines, 189,04)
                          , 'Data de Emissão') Then
  Begin
    Result := False;
    Exit;
  End;

  dtaDtaEmi := StrToDate(Trim(Copy(strLines, 185,02) + '/' +
                              Copy(strLines, 187,02) + '/' +
                              Copy(strLines, 189,04)));

  //************************************//
  // VALIDA A DATA DO PROCESSAMENTO     //
  //*********************************ED*//
  If Not fValidaData('181 á 188 ', Copy(strLines, 193,02) +
                            Copy(strLines, 195,02) +
                            Copy(strLines, 197,04)
                          , 'Data de Processamento') Then
  Begin
    Result := False;
    Exit;
  End;

  dtaDtaPro := StrToDate(Trim(Copy(strLines, 193,02) + '/' +
                              Copy(strLines, 195,02) + '/' +
                              Copy(strLines, 197,04)));

  //************************************//
  // VALOR DO TÍTULO                    //
  //*********************************ED*//
  strVlrTit := RightStr(Trim(Copy(strLines, 149,14)), 10);

  //******************************//
  // VALOR DO DESCONTO DO TÍTULO  //
  //***************************ED*//
  fltVlrDes := StrToCurr(Trim(Copy(strLines, 163,12) + ',' +
                              Copy(strLines, 175,02)));

  //************************************//
  // VALOR DA MORA                      //
  //*********************************ED*//
  fltVlrMor := StrToCurr(Trim(Copy(strLines, 201,12) + ',' +
                              Copy(strLines, 213,02)));

  strSisCob := Copy(strLines, 1205, 5);
  strBB_Crr := Copy(strLines, 1210, 1);
  strConCrr := Copy(strLines, 1211,10);

  If (strIdeBan = '756') And
     (strBB_Crr = 'S')   Then
  Begin
    strNosNum := strConCrr + fPadL(strNosNum, 07, '0');
    strIdeBan := '001';
  End;

  strBraCrr := Copy(strLines, 1262, 1);

  If strBraCrr = 'S' Then
  Begin
    strCodCar := fStrZero(RightStr(strCodCar, 2), 2);
    strIdeBan := '237';

    strDesCed := Trim(Copy(strLines, 1263, 40));
    strEndCed := Trim(Copy(strLines, 1303, 40));
    strCompCed:= Trim(Copy(strLines, 1343, 40));
    strBaiCed := Trim(Copy(strLines, 1383, 40));
    strCidCed := Trim(Copy(strLines, 1423, 40));
    strEstCed := Trim(Copy(strLines, 1463, 02));
    strCepCed := Trim(Copy(strLines, 1465, 08));
    strCgcCed := Trim(Copy(strLines, 1473, 14));
    strUsoBco := Trim(Copy(strLines, 1487, 06));
  End;

  If strIdeBan = '748' Then
    strCobReg := Copy(strLines, 1221, 1)
  Else
    strCobReg := ' ';

  //**************************************************//
  // MOEDA = 9 - INDICA QUE A COBRANÇA É EM REAIS R$  //
  //***********************************************ED*//
  strMoeda1 := '9';

  strFatVen := CalcularFatorVencimento(dtaDtaVen);

  //*****************************************************//
  // VALIDA SE A QUANTIDADE DE DIAS DO VENCIMENTO EH     //
  // MENOR QUE 1000, SE SIM ENTAO FINALIZA               //
  //**************************************************ED*//
  If StrToInt(strFatVen) < 1000 Then
  Begin
    MessageDlg('A data de vencimento não deve ser inferior á : 03/07/2000', mtInformation, [mbok], 0);
    Result := False;
    Exit;
  End;

  blnSantan240p := False;
 If strIdeBan = '3B2' Then
  Begin
    blnSantan240p := True;
    strIdeBan := '33B';
  End;

  //SAntander API
  If strIdeBan.Equals('033') Then
    strIdeBan := '33B';

  //******************************************************//
  // VERIFICA SE BANCO INFORMADO E SUPORTADO PELO SISTEMA //
  //                                                      //
  // SEMPRE QUE ACRESCENTAR UM BANCO, FAVOR CRIAR AS CONF.//
  // NO ARQUIVO EXEMPLOS.INI                              //
  //                                                      //
  //***************************************************ED*//
  If Not fVerificaContido(strIdeBan, '_001_041_104_237_341_356_399_748_756_33B_021_389_085_090_003_422_070_004_099_089_992_993_994_995_996_997_998_136_707_077_246_991_989_988_987_637_097_208_133_364_274_982_984_084_983_990_970_981_979_906_978_977_976_975_974_973_964_963_962_', 'O número do banco') Then
  Begin
    Result := False;
    Exit;
  End;

  blnBolPdf := blnImpPdf;
  blnSantan := False;

  If strIdeBan = '33B' Then
  Begin
    {***********************************************}
    {* PROCESSA DADOS PARA O BANCO SANTANDER - 033 *}
    {********************************************AF*}
    blnSantan := True;
    strIdeBan := '033';

    strNumDup := fStrZero(strNumDup, 07);
    strCodCed := fStrZero(strCodCed, 11);
  End;

  {********************************************************}
  {* SE UTILIZAR LAYOUT DE BOLETO PADRÃO OU DUAS VIAS     *}
  {* JÁ DEVE IMPRIMIR NESTE MOMENTO (UM ARQUIVO PARA CADA *}
  {* DUPLICATA\PARCELA). SE FOR LAYOUT CARNE DEVE ACUMULAR*}
  {* NA LISTA PARA SER IMPRESSO POSTERIORMENTE            *}
  {*****************************************************GD*}
  if ImprimirLayoutPadrao   then
    Result := fProArquivo(strIdeBan, strNomeForm, strNomeFila, blnForcarImp, blnEnvioDeEmailAutomatico, blnBolEnvEmail, blnEnvioFaturamento)
  else
  begin
    Result := False;
    If (fCfgSis('NOVLAY') = 'C') Then
       Result := ABoletoCarneBuilder.fAdicionarBoletoCarne(strIdeBan)
    Else
    If (fCfgSis('NOVLAY') = 'U') Then
       Result := ABoleto1ViaBuilder.fAdicionarBoleto1Via(strIdeBan);
  end;

end;

function ImprimirLayoutPadrao: Boolean;
Begin
  Result := MatchStr(fCfgSis('NOVLAY'), ['P','D']);

  If Not Result Then
  Begin

    If MatchStr(strIdeBan, ['077','021']) Then
      Exit(True);

    If ((strIdeBan = '748') And Assigned(TRetornoBoletoBancoSicredi(LRetornoRegistroBoletoApi))) Then
      Exit(True);

    If ((strIdeBan = '341') And Assigned(TRetornoBoletoItau(LRetornoRegistroBoletoApi))) Then
      Exit(True);

    If ((strIdeBan = '756') And Assigned(TRetornoBoletoSicoob(LRetornoRegistroBoletoApi))) Then
      Exit(True);

  End;

End;

function fValidaLinhaDigitavel(strLinha : String) : Boolean;
  Var
    strDiAuCo,
    strIdeBan,
    strMoeda1,
    strFatVen,
    strVlrTit,
    strCamLi1,
    strCamLi2,
    strCamLi3,
    strCamLi4 : String;
Begin
  strLinha := fRetSomenteNumeros(strLinha);

  strIdeBan := Copy(strLinha, 01, 03);
  strMoeda1 := Copy(strLinha, 04, 01);
  strFatVen := Copy(strLinha, 34, 04);
  strVlrTit := Copy(strLinha, 38, 10);
  strCamLi1 := Copy(strLinha, 05, 05);
  strCamLi2 := Copy(strLinha, 11, 10);
  strCamLi3 := Copy(strLinha, 22, 10);
  strCamLi4 := '';


  strDiAuCo := fGeDigAut(strIdeBan,
                         strMoeda1,
                         strFatVen,
                         strVlrTit,
                         strCamLi1,
                         strCamLi2,
                         strCamLi3,
                         strCamLi4);

  Result := strDiAuCo = Copy(strLinha,33,1);


End;

function fRetornaDataFormatoJuliano(dtaDtaVen: TDateTime): String;
  Var
    intContador: Integer;
    strDtaIni  : String;
    dtaDtaIni  : TDateTime;
Begin

  strDtaIni  := '01/01/' + RightStr(DateToStr(dtaDtaVen), 4);
  dtaDtaIni  := StrToDate(strDtaIni);
  intContador:= 1;

  repeat

    Result := fStrZero(intContador, 3);
    dtaDtaIni := dtaDtaIni + 1;
    Inc(intContador);

  until (dtaDtaIni = dtaDtaVen + 1);

  Result := Result + RightStr(FormatDateTime('dd/mm/yyyy', dtaDtaVen), 1);

End;

function fQryAgrupamento(strNumDup, strCodEmp, strCodCli: String): TUniQuery;
var
  strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT                     ';
  strSQL := strSQL + '  CTR_NUMDUP,              ';
  strSQL := strSQL + '  CTR_PARCEL,              ';
  strSQL := strSQL + '  CTR_ESPDOC,              ';
  strSQL := strSQL + '  CTR_CODEMP,              ';
  strSQL := strSQL + '  CTR_DTAVEN,              ';
  strSQL := strSQL + '  CTR_VALORI,              ';
  strSQL := strSQL + '  CTR_VALDUP + CTR_VALJUR AS CTR_VALCOR ';
  strSQL := strSQL + 'FROM                       ';
  strSQL := strSQL + '  DUPAGR                   ';
  strSQL := strSQL + 'WHERE CTR_NUMAGR = :NUMDUP ';
  strSQL := strSQL + '  AND CTR_EMPAGR = :CODEMP ';
  strSQL := strSQL + '  AND CTR_CODCLI = :CODCLI ';

  Result := fCriaQuery();
  With Result Do
  Begin
    SQL.Text := strSQL;
    ParamByName('NUMDUP').AsString := strNumDup;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('CODCLI').AsString := strCodCli;
    Open;
  End;
end;

function DuplicatasAgrupadas(ADataSet: TDataSet): String;
Begin

  Try
    ADataSet.First;
    Result := 'REF. DOC. ';
    While Not ADataSet.Eof Do
    Begin
      Result := Concat(Result,ADataSet.FieldByName('CTR_NUMDUP').AsString,ADataSet.FieldByName('CTR_PARCEL').AsString,'/');
      ADataSet.Next;
    End;
    ADataSet.First;
    Result := Copy(Result,1,Result.Length - 1);
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;

End;

function RetornaObservacaoBancoob: String;
  Var
    LEmpresa: String;
    LCarteira : String;
Begin
  LEmpresa := RightStr(LIdentificacaoBanco, 3);
  LCarteira := AnsiReplaceStr(LIdentificacaoBanco,RightStr(LIdentificacaoBanco, 4),'');


  Result := IIF(fltVlrMor > 0,'MORA DIÁRIA DE ' + FormatFloat('R$ #,##0.00', fltVlrMor),'') +
            IIF(fltVlrMul > 0,'        APÓS O VENCIMENTO COBRAR MULTA DE ' + FormatFloat('R$ #,##0.00', fltVlrMul),'');

  If (Pos('756_240p',LIdentificacaoBanco) > 0) Or (Pos('756API',LIdentificacaoBanco) > 0)  Then
  Begin
    Result := IIF(fltVlrMor > 0,'MORA DE ' + FormatFloat('#,##0.00%', (fltPerMor*30)) + ' AO MÊS','') +
              IIF(fltVlrMul > 0,', APÓS O VENCIMENTO COBRAR MULTA DE ' + FormatFloat('R$ #,##0.00', fltVlrMul),'');

    // Percentual
    If fGetBancoConfig(0,LCarteira,'CODIGOMULTA', LEmpresa) = '2' Then
    Begin
      Result := IIF(fltVlrMor > 0,'MORA DE ' + FormatFloat('#,##0.00%', (fltPerMor*30)) + ' AO MÊS','') +
                                             IIF(fltPerMul > 0,', APÓS O VENCIMENTO COBRAR MULTA DE ' + FormatFloat(' #,##0.00%', fltPerMul),'');
    End Else

    // Valor Fixo
    If  fGetBancoConfig(0,LCarteira,'CODIGOMULTA', LEmpresa) = '1' Then
    Begin
      Result := IIF(fltVlrMor > 0,'MORA DIÁRIA DE ' + FormatFloat('R$ #,##0.00', fltVlrMor),'') +
                IIF(fltVlrMul > 0,', APÓS O VENCIMENTO COBRAR MULTA DE ' + FormatFloat('R$ #,##0.00', fltPerMul),'');
    End;
  End;


End;

function RetornaObservacaoSantander: String;
Begin
  Result := EmptyStr;

  If fltVlrMor > 0 Then
    Result := Result + 'MORA DIARIA DE ' + FormatFloat('R$ #,##0.00', fltVlrMor) + '         ';

  If fltVlrMul > 0 Then
    Result := Result + 'APÓS O VENCIMENTO COBRAR MULTA DE ' + FormatFloat('R$ #,##0.00', fltVlrMul);
End;

function RetornaObservacaoMultaBtgPactual: String;
  Var
    LEmpresa: String;
    LCarteira : String;
Begin
  LEmpresa := RightStr(LIdentificacaoBanco, 3);
  LCarteira := AnsiReplaceStr(LIdentificacaoBanco,RightStr(LIdentificacaoBanco, 4),'');

  // Tipo Multa = 0 - Sem Multa;     1- Valor Fixo;   2 - Percentual(%);
  result := '';

  If Pos('CONFIG208',LIdentificacaoBanco) > 0 Then
  Begin

    If fGetBancoConfig(0,LCarteira,'TPMULTA', LEmpresa) = '0' Then
       result := ''
    Else

    // Percentual
    If fGetBancoConfig(0,LCarteira,'TPMULTA', LEmpresa) = '2' Then
       result := IIF(fltPerMul > 0,'APÓS O VENCIMENTO COBRAR MULTA DE ' + FormatFloat(' #,##0.00%', fltPerMul)+'.','')
    Else

    // Valor Fixo
    If fGetBancoConfig(0,LCarteira,'TPMULTA', LEmpresa) = '1' Then
       result := IIF(fltVlrMul > 0,'APÓS O VENCIMENTO COBRAR MULTA DE ' + FormatFloat('R$ #,##0.00', fltPerMul)+'.','');

  End;

End;

function RetornaObservacaoJurosBtgPactual: String;
  Var
    LEmpresa  : String;
    LCarteira : String;
Begin
  LEmpresa := RightStr(LIdentificacaoBanco, 3);
  LCarteira := AnsiReplaceStr(LIdentificacaoBanco,RightStr(LIdentificacaoBanco, 4),'');

  Result := '';

  If Pos('CONFIG208',LIdentificacaoBanco) > 0 Then
  Begin

    // Tipo Juros = 1 - Valor Por Dia; 2 - Taxa Mensal; 3 - Isento;
    If fGetBancoConfig(0,LCarteira,'TPJUROS', LEmpresa) = '3' Then
       Result := ''
    Else

    // VALOR POR DIA
    If fGetBancoConfig(0,LCarteira,'TPJUROS', LEmpresa) = '1' Then
       Result := IIF(fltVlrMor > 0,'APÓS O VENCIMENTO COBRAR MORA DIÁRIA DE ' + FormatFloat('R$ #,##0.00', fltVlrMor)+'.','')
    Else
    // TAXA MENSAL
    If fGetBancoConfig(0,LCarteira,'TPMULTA', LEmpresa) = '2' Then
       Result := IIF(fltVlrMor > 0,'APÓS O VENCIMENTO COBRAR MORA DE ' + FormatFloat('#,##0.00%', (fltPerMor*30)) + ' AO MÊS.','');

  End;

End;

function RetornaObservacaoCecred(ADefault: String; Var ADuplicatas: String) : String;
Begin
  Result := ADefault;

  If Not fEmptyStr(ADuplicatas) then
  Begin
    Result := LeftStr(ADuplicatas,120);
    ADuplicatas := ADuplicatas.Replace(Result,'');
  End;

  Result := UpperCase(Result);
End;

function RetornaObservacaoItau: String;
  Var
    LEmpresa: String;
    LCarteira : String;
Begin
  LEmpresa := RightStr(LIdentificacaoBanco, 3);
  LCarteira := AnsiReplaceStr(LIdentificacaoBanco,RightStr(LIdentificacaoBanco, 4),'');

  If Pos('341',LIdentificacaoBanco) > 0 Then
  Begin
    Result := IIF(fltVlrMor > 0, 'Após o vencimento cobrar ' + FormatFloat('R$ #,##0.00', fltVlrMor) + ' por dia de atraso.','') +
                  IIF(fltVlrMul > 0,'        Após o vencimento cobrar multa de ' + FormatFloat('R$ #,##0.00', fltVlrMul),'');

    // Percentual
    If fGetBancoConfig(0,LCarteira,'CODIGOMULTA', LEmpresa) = '2' Then
    Begin
       Result := IIF(fltVlrMul > 0,'Após o vencimento cobrar ' + FormatFloat('#,##0.00%', fltPerMul) + ' de multa','') +
                 IIF(fltVlrMor > 0,' e mora diária de ' + FormatFloat('#,##0.00%', fltPerMor) + ' ao dia.','');
    End Else

    // Valor Fixo
    If  fGetBancoConfig(0,LCarteira,'CODIGOMULTA', LEmpresa) = '1' Then
    Begin
       Result := IIF(fltVlrMul > 0,'Após o vencimento cobrar ' + FormatFloat('R$ #,##0.00', fltPerMul) + ' de multa','') +
                 IIF(fltVlrMor > 0,' e mora diária de ' + FormatFloat('R$ #,##0.00', fltVlrMor) + ' ao dia.','');
    End;
  End;

End;

function RetornaObservacaoMultaCredisis(dtaVen : Tdatetime): String;
  Var
    LEmpresa: String;
    LCarteira : String;
Begin
  LEmpresa := RightStr(LIdentificacaoBanco, 3);
  LCarteira := AnsiReplaceStr(LIdentificacaoBanco,RightStr(LIdentificacaoBanco, 4),'');

  If Pos('097',LIdentificacaoBanco) > 0 Then
  Begin

    // Percentual
    If fGetBancoConfig(0,LCarteira,'TPMULTA', LEmpresa) = '2' Then
    Begin
       Result := IIF(fltVlrMul > 0,'Cobrar multa de ' + FormatFloat('#,##0.00%', fltPerMul) + ' após a data de ' + FormatDateTime('dd/mm/yyyy', dtaDtaVen) + '.','');
                 // IIF(fltVlrMor > 0,' e mora diária de ' + FormatFloat('#,##0.00%', fltPerMor) + ' ao dia.','');
    End Else

    // Valor Fixo
    If  fGetBancoConfig(0,LCarteira,'TPMULTA', LEmpresa) = '1' Then
    Begin
       Result := IIF(fltVlrMul > 0,'Cobrar multa de ' + FormatFloat('R$ #,##0.00', fltPerMul) + ' após a data de ' + FormatDateTime('dd/mm/yyyy', dtaDtaVen) + '.','');
                 // IIF(fltVlrMor > 0,' e mora diária de ' + FormatFloat('R$ #,##0.00', fltVlrMor) + ' ao dia.','');
    End;

  End;

End;

function RetornaObservacaoJurosCredisis(dtaVen : Tdatetime): String;
  Var
    LEmpresa: String;
    LCarteira : String;
Begin
  LEmpresa := RightStr(LIdentificacaoBanco, 3);
  LCarteira := AnsiReplaceStr(LIdentificacaoBanco,RightStr(LIdentificacaoBanco, 4),'');

  If Pos('097',LIdentificacaoBanco) > 0 Then
  Begin

    // Percentual
    If fGetBancoConfig(0,LCarteira,'TPJUROS', LEmpresa) = '2' Then
    Begin
       Result := IIF(fltVlrMul > 0,'Cobrar juros de ' + FormatFloat('#,##0.00%', fltPerMor) + ' por dia corridos após a data de ' + FormatDateTime('dd/mm/yyyy', IncDay(dtaDtaVen, 1)) + '.','');
                 // IIF(fltVlrMor > 0,' e mora diária de ' + FormatFloat('#,##0.00%', fltPerMor) + ' ao dia.','');
    End Else

    // Valor Fixo
    If  fGetBancoConfig(0,LCarteira,'TPJUROS', LEmpresa) = '1' Then
    Begin
       Result := IIF(fltVlrMul > 0,'Cobrar juros de ' + FormatFloat('R$ #,##0.00', fltVlrMor) + ' por dia corridos após a data de ' + FormatDateTime('dd/mm/yyyy', IncDay(dtaDtaVen, 1)) + '.','');
                 // IIF(fltVlrMor > 0,' e mora diária de ' + FormatFloat('R$ #,##0.00', fltVlrMor) + ' ao dia.','');
    End;

  End;

End;

function RetornaObservacaoMultaSicrediApi(): String;
  Var
    LEmpresa: String;
    LCarteira : String;
Begin
  LEmpresa := RightStr(LIdentificacaoBanco, 3);
  LCarteira := AnsiReplaceStr(LIdentificacaoBanco,RightStr(LIdentificacaoBanco, 4),'');

  If Pos('748',LIdentificacaoBanco) > 0 Then
  Begin
     Result := IIF(fltVlrMul > 0,'APOS O VENCIMENTO COBRAR MULTA DE ' + FormatFloat('#,##0.00%', fltPerMul) + '.','');
  End;

End;

function RetornaObservacaoJurosSicrediApi(): String;
  Var
    LEmpresa: String;
    LCarteira : String;
Begin
  LEmpresa := RightStr(LIdentificacaoBanco, 3);
  LCarteira := AnsiReplaceStr(LIdentificacaoBanco,RightStr(LIdentificacaoBanco, 4),'');

  If Pos('748',LIdentificacaoBanco) > 0 Then
  Begin

    // Percentual
    If fGetBancoConfig(0,LCarteira,'TIPO_JUROS', LEmpresa) = '1' Then
    Begin
       Result := IIF(fltVlrMul > 0,'APOS O VENCIMENTO COBRAR MORA DIARIA DE ' + FormatFloat('#,##0.00%', fltPerMor) + '.','');
    End Else

    // Valor Fixo
    If  fGetBancoConfig(0,LCarteira,'TIPO_JUROS', LEmpresa) = '0' Then
    Begin
       Result := IIF(fltVlrMul > 0,'APOS O VENCIMENTO COBRAR MORA DIARIA DE ' + FormatFloat('R$ #,##0.00', fltVlrMor) + '.','');
    End;

  End;

End;

procedure pCarregarLayImp(var frmQckBancos: TfrmQckBancos);
var SBoletoLayImp       : TBoletoLayImp;
    SQuantidadeParcelas : Integer;
begin
  if fCfgSis('NOVLAY', varString) = 'D' then
  begin
    SBoletoLayImp := TBoletoLayImp.Create;
    try
      TfrxBand(frmQckBancos.frxBanco.FindObject('rlbLayImp')).Visible := True;

      SBoletoLayImp.pLoadLayoutImpressao(frmQckBancos.frxBanco);

      SQuantidadeParcelas := fQtdParcelas(strNumDocumentoSemParcela, strCodEmp, strEspDocOriginal, strCodCli);

      frmQckBancos.frxBanco.Script.Variables['CODEMP']  := strCodEmp;
      frmQckBancos.frxBanco.Script.Variables['NUMPARC'] := fRetNumParcela(RightStr(strNumDoc, 1));
      frmQckBancos.frxBanco.Script.Variables['TOTPARC'] := IIF(SQuantidadeParcelas = 0, 1, SQuantidadeParcelas);
      frmQckBancos.frxBanco.Script.Variables['MAILCLI'] := strMailCli;
    finally
      FreeAndNil(SBoletoLayImp)
    end;
  end;
end;

procedure pInformarImpressoraSelecionadaBoleto(const strImpressora: String);
begin
  strImpressoraSelecionadaBoleto := strImpressora;
end;

function fRetornarImpressoraSelecionadaBoleto: String;
begin
  Result := strImpressoraSelecionadaBoleto;
end;

procedure pLimparImpressoraSelecionadaBoleto;
begin
  pInformarImpressoraSelecionadaBoleto(EmptyStr);
end;

procedure pInformarReutilizarImpressoraSelecionadaBoleto(const blnReutilizar: Boolean);
begin
  blnReutilizarImpressoraSelecionadaBoleto := blnReutilizar;
end;

function fRetornarReutilizarImpressoraSelecionadaBoleto: Boolean;
begin
  Result := blnReutilizarImpressoraSelecionadaBoleto;
end;

function PossuiImagemLogoCFG: Boolean;
Begin
  Result := (Not fEmptyStr(fCfgSis('IMGBOL')));

  If Result Then
    Result := FileExists(fCfgSis('IMGBOL'));
End;

function ValidaLogoBoleto(ALogoBoleto: String): Boolean;
Begin
  Result := FileExists(ExtractFilePath(Application.ExeName) + ALogoBoleto);

  If Not Result Then
  Begin
    pMensagemOk('O logo ' + ExtractFilePath(Application.ExeName) + ALogoBoleto + ' deve existir na pasta indicada.');

    VS_ErroGeraBoletoLaser := 'O logo ' + ExtractFilePath(Application.ExeName) + ALogoBoleto + ' deve existir na pasta indicada.';
  End;
End;

initialization
  strImpressoraSelecionadaBoleto           := EmptyStr;
  blnReutilizarImpressoraSelecionadaBoleto := False;

end.
