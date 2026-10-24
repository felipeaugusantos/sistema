{******************************************}
{* Importação de arquivos do MERCADOLIVRE *}
{***************************************AJ*}
unit untMercadoLivrePgto;

interface

uses Classes, StrUtils, SysUtils, Variants, untIIntegracaoCartoes, ComCtrls, Dialogs, Forms;

Type
  TRegistroPgto = Record
    strTipReg: String;
    strStatus: String;
    strCodAut: String;
    strDtaTra: String;
    strDtaPag: String;
    fltValPro: Double;
    fltValEnv: Double;
    fltValLiq: Double;
    fltValMPG: Double;
    fltValPla: Double;
    fltValDev: Double;
    strTipPag: String;
    strApelid: String;
    strNumOpe: String;
    strNumVen: String;
    strLinPro: String;
    strNomArq: String;
    strDtaArq: String;
    strCodEst: String;
    strShp_ID: String;
    LCodEmp  : String;

    CupomDesconto: Double;
    CustoDescontoOferecido: Double;
    OrderId,
    ShipmentMode: String;
  End;

  TEstruturaPgto = Record
    strDescri: String;
    strTipCmp: String;
  End;

  TIndicesCampos = Record
    strNomCam: String;
    intIndice: Integer;
  End;

  TArrRegistroMLPgto  = Array Of TRegistroPgto;

  TArrEstruturaMLPgto = Array Of TEstruturaPgto;

  TArrIndicePgto      = Array Of TIndicesCampos;

  TMercadoLivrePgto = Class(TInterfacedObject, ICartoes)
  Private
    function fRetVal(strVal: Variant; blnData: Boolean = False; blnCompleta: Boolean = True): Variant;

    function RetornaPeriodoPagamento : String;
    function RegistroJaImportado(AIndex:Integer): Boolean;
    function RetornaLinhaFormatada(ALinha:String):String;

    function RetornaValorShippingID(ACampos: TStringList): Variant;

    function fGetDados(strValor: String;
                       blnFlt: Boolean = False;
                       intCasas: Integer = 0;
                       AValidaE15: Boolean = False): Variant;

    procedure ValidaSeOsDadosEstaoCorretos(ACampos: TStringList);

    function DeveAjustarOValorLiquidoDePaymentsNegativos(AListaCampos: TStringList;
                                                         var AValorAjustar: Double): Boolean;

    procedure CarregaIndiceChaveDaVenda;

    function RetornaListaDeCampos(AObjetoCampos: TArrEstruturaMLPgto): TStringList;

    function RegistroDeVendaMarcadoComoFretePeloML(ARegistroMLPgto: TRegistroPgto): Boolean;
  Public
    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(pgbProg: TProgressBar);

    class function fRetSQLTabelaRegPgto(strTabela: String): String;
    class function fRetEstruturaPgto(strTabela: String): TArrEstruturaMLPgto;
  End;

Var
  strDtaArq,
  strNomArq,
  strDtaPag,
  strCodEmp: String;
  arrIndCam: TArrIndicePgto;
  lstChave : TStringList;

  Separador: Char;

  dtaMaiorData: TDateTime;

  FIndiceVenda: Integer;
  FTemRegistroParaConciliacao: Boolean;

Const
  NOMTAB = 'MER_MLPGTO';
  INICAM = 'MER_';

implementation

uses untFuncoes, untIDataSet, untMercadoLivre;

{ TMercadoLivrePgto }

{**********************************************}
{* RETORNA A ESTRUTURA DA  TABELA  DE CRÉDITO *}
{* MER_MLPGTO                                 *}
{*******************************************AJ*}
class function TMercadoLivrePgto.fRetEstruturaPgto(strTabela: String): TArrEstruturaMLPgto;
Begin
  If strTabela = NOMTAB Then
  Begin
    SetLength(Result, 28);

    Result[0].strDescri  := INICAM + 'TIPREG'; Result[0].strTipCmp  := 'VARCHAR(40)'  ;
    Result[1].strDescri  := INICAM + 'DTAPAG'; Result[1].strTipCmp  := 'DATETIME'     ;
    Result[2].strDescri  := INICAM + 'STATUS'; Result[2].strTipCmp  := 'VARCHAR(30)'  ;
    Result[3].strDescri  := INICAM + 'DTATRA'; Result[3].strTipCmp  := 'DATETIME'     ;
    Result[4].strDescri  := INICAM + 'CODAUT'; Result[4].strTipCmp  := 'VARCHAR(20)'  ;
    Result[5].strDescri  := INICAM + 'TIPPAG'; Result[5].strTipCmp  := 'VARCHAR(25)'  ;
    Result[6].strDescri  := INICAM + 'VALPRO'; Result[6].strTipCmp  := 'DECIMAL(15,2)';
    Result[7].strDescri  := INICAM + 'VALENV'; Result[7].strTipCmp  := 'DECIMAL(15,2)';
    Result[8].strDescri  := INICAM + 'VALLIQ'; Result[8].strTipCmp  := 'DECIMAL(15,2)';
    Result[9].strDescri  := INICAM + 'VALMPG'; Result[9].strTipCmp  := 'DECIMAL(15,2)';
    Result[10].strDescri := INICAM + 'VALPLA'; Result[10].strTipCmp := 'DECIMAL(15,2)';
    Result[11].strDescri := INICAM + 'VALDEV'; Result[11].strTipCmp := 'DECIMAL(15,2)';
    Result[12].strDescri := INICAM + 'APELID'; Result[12].strTipCmp := 'VARCHAR(25)'  ;
    Result[13].strDescri := INICAM + 'NUMOPE'; Result[13].strTipCmp := 'VARCHAR(20)'  ;
    Result[14].strDescri := INICAM + 'NUMVEN'; Result[14].strTipCmp := 'VARCHAR(20)'  ;
    Result[15].strDescri := INICAM + 'LINPRO'; Result[15].strTipCmp := 'VARCHAR(2000)';
    Result[16].strDescri := INICAM + 'NOMARQ'; Result[16].strTipCmp := 'VARCHAR(255)' ;
    Result[17].strDescri := INICAM + 'DTAARQ'; Result[17].strTipCmp := 'DATE'         ;
    Result[18].strDescri := INICAM + 'CONCIL'; Result[18].strTipCmp := 'INT DEFAULT 0';
    Result[19].strDescri := INICAM + 'CODEST'; Result[19].strTipCmp := 'VARCHAR(30)  ';
    Result[20].strDescri := INICAM + 'NUMPAR'; Result[20].strTipCmp := 'VARCHAR(2) DEFAULT "01"';
    Result[21].strDescri := INICAM + 'TOTPAR'; Result[21].strTipCmp := 'VARCHAR(2) DEFAULT "01"';
    Result[22].strDescri := INICAM + 'NUMCAR'; Result[22].strTipCmp := 'VARCHAR(19)'  ;
    Result[23].strDescri := INICAM + 'SHP_ID'; Result[23].strTipCmp := 'VARCHAR(30)'  ;
    Result[24].strDescri := INICAM + 'VALCUP'; Result[24].strTipCmp := 'DECIMAL(15,2)';
    Result[25].strDescri := INICAM + 'CODEMP'; Result[25].strTipCmp := 'CHAR(3)';
    Result[26].strDescri := INICAM + 'ORD_ID'; Result[26].strTipCmp := 'VARCHAR(30)';
    Result[27].strDescri := INICAM + 'CUPEFE'; Result[27].strTipCmp := 'DECIMAL(15,2)';
  End;
End;

class function TMercadoLivrePgto.fRetSQLTabelaRegPgto(strTabela: String): String;
Var arrCampos: TArrEstruturaMLPgto;
    intCont  : Integer;
begin
  Result := 'CREATE TABLE ' + strTabela + '(';
  arrCampos := fRetEstruturaPgto(strTabela);

  For intCont := 0 to Length(arrCampos) - 1 do
    Result := Result + arrCampos[intCont].strDescri + ' ' + arrCampos[intCont].strTipCmp + ', ';

  Result := Result + ' PRIMARY KEY(MER_CODAUT,MER_CODEST,MER_DTAPAG,MER_NUMPAR,MER_STATUS,MER_TIPPAG,MER_TIPREG)) ENGINE INNODB ' ;
end;

procedure TMercadoLivrePgto.CarregaIndiceChaveDaVenda;
  Var
    LConsulta: IDataSet;
begin
  If FIndiceVenda > 0 Then
    Exit;

  LConsulta := objFunctions.fGetDataSet;
  LConsulta.SQL := 'SELECT * FROM MOVCAR WHERE FALSE';
  LConsulta.Open;

  FIndiceVenda := 14;
  If LConsulta.FindField('MCA_ORDEID') <> Nil Then
    FIndiceVenda := 16;
end;

function TMercadoLivrePgto.DeveAjustarOValorLiquidoDePaymentsNegativos(
  AListaCampos: TStringList; var AValorAjustar: Double): Boolean;
  Var
    LValorLiquidoArquivo,
    LValorLiquidoCalculado,
    LCustoDescontoOferecido: Double;
begin
  Result := False;

  AValorAjustar := 0;

  If Not MatchStr(fGetDados(AListaCampos[arrIndCam[0].intIndice]), ['payment']) Then
    Exit;

  If fGetDados(AListaCampos[arrIndCam[4].intIndice], True, 0) >= 0 Then
    Exit;

  If arrIndCam[9].intIndice = -1 Then
    Exit;

  LValorLiquidoArquivo := fGetDados(AListaCampos[arrIndCam[9].intIndice], True, 0);

  LCustoDescontoOferecido := 0;
  If arrIndCam[22].intIndice > -1 Then
    LCustoDescontoOferecido := fGetDados(AListaCampos[arrIndCam[22].intIndice], True, 0);

  LValorLiquidoCalculado := (fGetDados(AListaCampos[arrIndCam[4].intIndice], True, 0) +
                             fGetDados(AListaCampos[arrIndCam[5].intIndice], True, 0) +
                             fGetDados(AListaCampos[arrIndCam[7].intIndice], True, 0) +
                             fGetDados(AListaCampos[arrIndCam[8].intIndice], True, 0) +
                             LCustoDescontoOferecido);

  If LValorLiquidoCalculado >= 0 Then
    Exit;

  Result := Not FormatFloat(',0.00', Abs(LValorLiquidoCalculado)).Equals(FormatFloat(',0.00', Abs(LValorLiquidoArquivo)));
  If Not Result Then
    Exit;

  AValorAjustar := Abs(LValorLiquidoArquivo) - Abs(LValorLiquidoCalculado);
end;

function TMercadoLivrePgto.fGetDados(strValor: String; blnFlt: Boolean = False;
  intCasas: Integer = 0; AValidaE15: Boolean = False): Variant;
  Var
    rst     : Variant;
    i       : Integer;
    strZeros: String;
Begin
  rst := ' ';
  If strValor <> '' Then
    rst := strValor;

  If blnFlt Then
  Begin
    strZeros := '';
    For i := 1 to intCasas do
      strZeros := strZeros + '0';

    rst := StringReplace(rst, '.', ',', []);
    rst := fStrToFloat(rst) / StrtoFloat('1' + strZeros);
  End;

  If Not blnFlt Then
  Begin
    If rst = '2E+15' Then
      Raise Exception.Create('Não é possível importar o arquivo ' + strNomArq + '.' + #13 +
                             'O arquivo foi aberto e salvo em um programa de terceiros, como Excel ou Calc. ' +
                             'A importação deve ser realizada a partir do csv "puro" baixado do portal, sem qualquer alteração.' + #13 +
                             'A operação foi cancelada.');

    If AValidaE15 Then
    Begin
      If Pos('E+15', rst) > 0  Then
        Raise Exception.Create('Não é possível importar o arquivo ' + strNomArq + '.' + #13 +
                               'O arquivo foi aberto e salvo em um programa de terceiros, como Excel ou Calc. ' +
                               'A importação deve ser realizada a partir do csv "puro" baixado do portal, sem qualquer alteração.' + #13 +
                               'A operação foi cancelada.');
    End;
  End;

  Result := rst;
End;

procedure TMercadoLivrePgto.pAdicionaLinha(strString: String);
Var
  lstCampos       : TStringList;
  intRegistro     : Integer;
  blnAchouRegistro: Boolean;

  LDataPagamento,
  LChaveVenda,
  LShippingID,
  LTextoAjusteCredito: String;

  blnTotais: Boolean;

  LCustoDescontoOferecido,
  LValorAjustar: Double;

  procedure pAdicionaIndice(strNomCol, strNomCam: String);
  Begin
    SetLength(arrIndCam, Length(arrIndCam) + 1);
    arrIndCam[Length(arrIndCam) - 1].strNomCam := strNomCam;
    arrIndCam[Length(arrIndCam) - 1].intIndice := lstCampos.IndexOf(strNomCol);
  End;

begin
  If fEmptyStr(strString) Then
    Exit;

  lstCampos := TStringList.Create;
  lstCampos.Delimiter     := Separador;
  lstCampos.DelimitedText := RetornaLinhaFormatada(strString);

  If Not Assigned(lstEstabel) Then
    lstEstabel := TStringList.Create;

  If Not Assigned(lstChave) Then
    lstChave := TStringList.Create;

  If Not Assigned(FDatasPagamento) Then
    FDatasPagamento := TStringList.Create;

  Try
    If (Pos('NET_CREDIT_AMOUNT', strString) > 0) Then
    Begin
      strString := fConverteParaAcento(strString);
      lstCampos.DelimitedText := StringReplace(strString, ' ', EmptyStr, [rfReplaceAll]);
      SetLength(arrIndCam, 0);
      pAdicionaIndice('DESCRIPTION', INICAM + 'TIPREG');  //0
      pAdicionaIndice('EXTERNAL_REFERENCE', INICAM + 'CODAUT'); //1
      pAdicionaIndice('DATE', INICAM + 'DTATRA'); //2
      If arrIndCam[2].intIndice = -1 Then
      Begin
        SetLength(arrIndCam, Length(arrIndCam) - 1);
        pAdicionaIndice('RELEASE_DATE', INICAM + 'DTATRA'); //2
      End;
      pAdicionaIndice('DATE', INICAM + 'DTAPAG'); //3
      If arrIndCam[3].intIndice = -1 Then
      Begin
        SetLength(arrIndCam, Length(arrIndCam) - 1);
        pAdicionaIndice('RELEASE_DATE', INICAM + 'DTAPAG'); //3
      End;
      pAdicionaIndice('GROSS_AMOUNT', INICAM + 'VALPRO'); //4
      pAdicionaIndice('SHIPPING_FEE_AMOUNT', INICAM + 'VALENV'); //5
      pAdicionaIndice('NET_CREDIT_AMOUNT', INICAM + 'VALLIQ'); //6
      pAdicionaIndice('FINANCING_FEE_AMOUNT', INICAM + 'VALMPG'); //7
      pAdicionaIndice('MP_FEE_AMOUNT', INICAM + 'VALPLA'); //8
      pAdicionaIndice('NET_DEBIT_AMOUNT', INICAM + 'VALDEV'); //9
      pAdicionaIndice('PAYMENT_METHOD', INICAM + 'TIPPAG'); //10
      pAdicionaIndice('SOURCE_ID', INICAM + 'NUMOPE'); //11
      pAdicionaIndice('SOURCE_ID', INICAM + 'NUMVEN'); //12
      pAdicionaIndice('RECORD_TYPE', INICAM + 'STATUS'); //13
      pAdicionaIndice('SHIPPING_ID', INICAM + 'SHP_ID'); //14
      pAdicionaIndice('COUPON_AMOUNT', INICAM + 'VALCUP'); //15
      pAdicionaIndice('ORDER_ID', INICAM + 'ORD_ID'); //16
      pAdicionaIndice('SHIPMENT_MODE', EmptyStr); //17
      pAdicionaIndice('TRANSACTION_APPROVAL_DATE', EmptyStr); //18
      pAdicionaIndice('BUSINESS_UNIT', EmptyStr); //19
      pAdicionaIndice('SUB_UNIT', EmptyStr); //20
      pAdicionaIndice('SALE_DETAIL', EmptyStr); //21
      pAdicionaIndice('EFFECTIVE_COUPON_AMOUNT', 'MER_CUPEFE'); //22

      CarregaIndiceChaveDaVenda;
    End
    Else
    Begin
      blnTotais := ((fGetDados(lstCampos[arrIndCam[13].intIndice]) = 'subtotal') Or
                    (Trim(fGetDados(lstCampos[arrIndCam[0].intIndice])) = '')) And
                    (fGetDados(lstCampos[arrIndCam[0].intIndice]) <> 'withdrawal') And
                    (fGetDados(lstCampos[arrIndCam[13].intIndice]) <> 'total');


      If (lstCampos.Count = 0) Or
         (blnTotais) Then
        Exit;

      ValidaSeOsDadosEstaoCorretos(lstCampos);

      LShippingID := RetornaValorShippingID(lstCampos);

      LChaveVenda := fGetDados(lstCampos[arrIndCam[0].intIndice]) + '_' +
                               IIF(Trim(fGetDados(lstCampos[arrIndCam[FIndiceVenda].intIndice])) <> '',
                                   fGetDados(lstCampos[arrIndCam[FIndiceVenda].intIndice]),
                                   fGetDados(lstCampos[arrIndCam[1].intIndice])) + '_' +
                               Copy(fGetDados(lstCampos[arrIndCam[3].intIndice]),1,10) + '_' +
                               strNomArq;

      intRegistro := lstChave.IndexOf(LChaveVenda);

      blnAchouRegistro := intRegistro > -1;
      If Not blnAchouRegistro Then
      Begin
        SetLength(FRegMLPgto, Length(FRegMLPgto) + 1);
        intRegistro := Length(FRegMLPgto) - 1;
        lstChave.Add(LChaveVenda);
      End;

      FRegMLPgto[intRegistro].strTipReg := fGetDados(lstCampos[arrIndCam[0].intIndice]);
      If (Trim(fGetDados(lstCampos[arrIndCam[0].intIndice])) = '') Then
       FRegMLPgto[intRegistro].strTipReg := fGetDados(lstCampos[arrIndCam[13].intIndice]);
      FRegMLPgto[intRegistro].strStatus := fGetDados(lstCampos[arrIndCam[13].intIndice]);
      FRegMLPgto[intRegistro].strCodAut := IIF(Trim(fGetDados(lstCampos[arrIndCam[1].intIndice])) <> '',
                                               fGetDados(lstCampos[arrIndCam[1].intIndice]),
                                               '0000000000');

      FRegMLPgto[intRegistro].strDtaTra := fGetDados(lstCampos[arrIndCam[2].intIndice]);
      If arrIndCam[18].intIndice > -1 Then
      Begin
        If Trim(fGetDados(lstCampos[arrIndCam[18].intIndice])) <> '' Then
          FRegMLPgto[intRegistro].strDtaTra := fGetDados(lstCampos[arrIndCam[18].intIndice]);
      End;

      FRegMLPgto[intRegistro].strDtaPag := fGetDados(lstCampos[arrIndCam[3].intIndice]);
      FRegMLPgto[intRegistro].fltValPro := (fGetDados(lstCampos[arrIndCam[4].intIndice], True, 0)) +
                                           IIF(blnAchouRegistro, FRegMLPgto[intRegistro].fltValPro, 0);
      FRegMLPgto[intRegistro].fltValEnv := (fGetDados(lstCampos[arrIndCam[5].intIndice], True, 0)) +
                                           IIF(blnAchouRegistro, FRegMLPgto[intRegistro].fltValEnv, 0);

      If arrIndCam[8].intIndice > -1 Then
        FRegMLPgto[intRegistro].fltValMPG := (fGetDados(lstCampos[arrIndCam[7].intIndice], True, 0)) +
                                             IIF(blnAchouRegistro, FRegMLPgto[intRegistro].fltValMPG, 0)
      Else
        FRegMLPgto[intRegistro].fltValMPG := 0;

      If arrIndCam[9].intIndice > -1 Then
        FRegMLPgto[intRegistro].fltValPla := (fGetDados(lstCampos[arrIndCam[8].intIndice], True, 0)) +
                                             IIF(blnAchouRegistro, FRegMLPgto[intRegistro].fltValPla, 0)
      Else
        FRegMLPgto[intRegistro].fltValPla := 0;

      FRegMLPgto[intRegistro].CupomDesconto := (fGetDados(lstCampos[arrIndCam[15].intIndice], True, 0)) +
                                               IIF(blnAchouRegistro, FRegMLPgto[intRegistro].CupomDesconto, 0);

      LCustoDescontoOferecido := 0;
      If Not blnAchouRegistro Then
        FRegMLPgto[intRegistro].CustoDescontoOferecido := 0;
      If arrIndCam[22].intIndice > -1 Then
        LCustoDescontoOferecido := fGetDados(lstCampos[arrIndCam[22].intIndice], True, 0);

      FRegMLPgto[intRegistro].CustoDescontoOferecido := LCustoDescontoOferecido +
                                                        FRegMLPgto[intRegistro].CustoDescontoOferecido;

      If Pos(FRegMLPgto[intRegistro].strStatus, 'release_') > 0 Then
      Begin
        FRegMLPgto[intRegistro].fltValLiq := IIF(blnAchouRegistro, FRegMLPgto[intRegistro].fltValLiq, 0) +
                                             ((fGetDados(lstCampos[arrIndCam[4].intIndice], True, 0) +
                                              fGetDados(lstCampos[arrIndCam[5].intIndice], True, 0) +
                                              fGetDados(lstCampos[arrIndCam[7].intIndice], True, 0) +
                                              fGetDados(lstCampos[arrIndCam[8].intIndice], True, 0) +
                                              LCustoDescontoOferecido));
      End
      Else
      Begin
        FRegMLPgto[intRegistro].fltValLiq := IIF(blnAchouRegistro, FRegMLPgto[intRegistro].fltValLiq, 0) +
                                             ((fGetDados(lstCampos[arrIndCam[4].intIndice], True, 0) +
                                              fGetDados(lstCampos[arrIndCam[5].intIndice], True, 0) +
                                              fGetDados(lstCampos[arrIndCam[7].intIndice], True, 0) +
                                              fGetDados(lstCampos[arrIndCam[8].intIndice], True, 0) +
                                              LCustoDescontoOferecido));
      End;

      FRegMLPgto[intRegistro].strTipPag := fGetDados(lstCampos[arrIndCam[10].intIndice]);
      If FRegMLPgto[intRegistro].strTipPag.Trim = '' Then
        FRegMLPgto[intRegistro].strTipPag := FRegMLPgto[intRegistro].strCodAut;

       If arrIndCam[13].intIndice > -1 Then
        FRegMLPgto[intRegistro].strNumOpe := fGetDados(lstCampos[arrIndCam[11].intIndice])
      Else
        FRegMLPgto[intRegistro].strNumOpe := '';
      If arrIndCam[14].intIndice > -1 Then
        FRegMLPgto[intRegistro].strNumVen := fGetDados(lstCampos[arrIndCam[12].intIndice])
      Else
        FRegMLPgto[intRegistro].strNumVen := '';

      FRegMLPgto[intRegistro].strCodEst := '0';
      FRegMLPgto[intRegistro].LCodEmp   := strCodEmp;

      FRegMLPgto[intRegistro].strShp_ID := LShippingID;

      FRegMLPgto[intRegistro].OrderId := fGetDados(lstCampos[arrIndCam[16].intIndice]);

      FRegMLPgto[intRegistro].strNomArq := strNomArq;
      FRegMLPgto[intRegistro].strDtaArq := strDtaArq;

      //Registros de Total não possuem data de transação. Descobrindo a qual data esse total pertence
      If FRegMLPgto[intRegistro].strTipReg = 'total' Then
      Begin
        FRegMLPgto[intRegistro].strDtaTra := FormatDateTime('yyyy-mm-dd HH:MM:SS', dtaMaiorData);
        FRegMLPgto[intRegistro].strDtaPag := FormatDateTime('yyyy-mm-dd HH:MM:SS', dtaMaiorData);
      End
      Else If (FRegMLPgto[intRegistro].strDtaTra.Trim <> '') And
              (VarToDateTime(fRetVal(FRegMLPgto[intRegistro].strDtaTra, True, True)) > dtaMaiorData) Then
        dtaMaiorData := VarToDateTime(fRetVal(FRegMLPgto[intRegistro].strDtaTra, True, True));

      If (FRegMLPgto[intRegistro].LCodEmp <> '') And
         (lstEstabel.IndexOf(FRegMLPgto[intRegistro].LCodEmp) < 0) Then
        lstEstabel.Add(FRegMLPgto[intRegistro].LCodEmp);

      If Not fEmptyStr(FRegMLPgto[intRegistro].strDtaPag) Then
      Begin
        LDataPagamento := LeftStr(FRegMLPgto[intRegistro].strDtaPag,10);
        LDataPagamento := Copy(LDataPagamento, 9, 2) +'/'+ Copy(LDataPagamento, 6, 2) + '/' + Copy(LDataPagamento, 1, 4) ;

        If (FDatasPagamento.IndexOf(LDataPagamento) < 0) Then
          FDatasPagamento.Add(LDataPagamento);
      End;

      FRegMLPgto[intRegistro].ShipmentMode := fGetDados(lstCampos[arrIndCam[17].intIndice]);

      If DeveAjustarOValorLiquidoDePaymentsNegativos(lstCampos, LValorAjustar) Then
        FRegMLPgto[intRegistro].fltValLiq := FRegMLPgto[intRegistro].fltValLiq -
                                             LValorAjustar;

      If Trim(FRegMLPgto[intRegistro].strTipReg + fGetDados(lstCampos[arrIndCam[14].intIndice]) +
              FRegMLPgto[intRegistro].ShipmentMode + FRegMLPgto[intRegistro].OrderId) = 'payment' Then
      Begin
        If fRetVal(FRegMLPgto[intRegistro].fltValLiq) > 0 Then
        Begin
          Try
            LTextoAjusteCredito := VarToStr(fGetDados(lstCampos[arrIndCam[19].intIndice])) + VarToStr(fGetDados(lstCampos[arrIndCam[20].intIndice]));

            If Not LTextoAjusteCredito.Equals('MercadoPagoCheckouts') Then
            Begin
              If FormatFloat('0.00', FRegMLPgto[intRegistro].fltValPro) = FormatFloat('0.00', FRegMLPgto[intRegistro].fltValLiq) Then
                FRegMLPgto[intRegistro].strTipReg := 'ajuste_credito';
            End;
          Except
            FRegMLPgto[intRegistro].strTipReg := 'ajuste_credito';
          End;
        End;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      If Pos('Não é possível importar o arquivo', E.Message) <= 0 Then
        Raise Exception.Create('Ocorreu um erro ao importar o arquivo.' + #13 +
                               'Erro gerado: ' + E.Message)
      Else
        Raise Exception.Create(E.Message);
    End;
  End;

  If Assigned(lstCampos) Then
    FreeAndNil(lstCampos);
end;

function TMercadoLivrePgto.fRetVal(strVal: Variant; blnData: Boolean = False; blnCompleta: Boolean = True): Variant;
Begin
  Result := Null;

  If Not fEmptyStr(strVal) Then
  Begin
    Result := strVal;
    If (blnData) Then
    Begin
      Result := Copy(strVal, 1, 4) + '/' + Copy(strVal, 6, 2) + '/' + Copy(strVal, 9, 2);
      If blnCompleta Then
        Result := Result + ' ' + Copy(strVal, 12, 8);
    End;
  End;
End;

function TMercadoLivrePgto.RetornaListaDeCampos(
  AObjetoCampos: TArrEstruturaMLPgto): TStringList;
  Var
    LContador: Integer;
begin
  Result := TStringList.Create;

  For LContador := 0 To Length(AObjetoCampos) - 1 Do
    Result.Add(AObjetoCampos[LContador].strDescri);
end;

procedure TMercadoLivrePgto.pGravarRegistros(pgbProg: TProgressBar);
  Var
    qryDados : IDataSet;
    intCont  : Integer;
begin
  qryDados := objFunctions.fGetDataSet;
  qryDados.Close;
  qryDados.SQL := RetornaSQLReplace('MER_MLPGTO',
                                    RetornaListaDeCampos(fRetEstruturaPgto('MER_MLPGTO')),
                                    ['MER_CONCIL']);

  CarregaRegistrosJaImportados('MER_MLPGTO',
                              ['MER_CONCIL', 'MER_DTAPAG'],
                              ['= 1',RetornaPeriodoPagamento]);



  pgbProg.Position := 0;

  If Length(FRegMLPgto) = 0 Then
    Exit;

  Try
    pgbProg.Max      := Length(FRegMLPgto)-1;
    For intCont := 0 To Length(FRegMLPgto)-1 Do
    Begin
      If (FRegMLPgto[intCont].strTipReg <> '') Then
      Begin
        Application.ProcessMessages;
        qryDados.Close;

        If RegistroJaImportado(intCont) Then
        Begin
          pgbProg.Position := pgbProg.Position + 1;

          Continue;
        End;


        qryDados.ParamByName(arrIndCam[0].strNomCam).Value  := fRetVal(FRegMLPgto[intCont].strTipReg);
        qryDados.ParamByName(INICAM + 'STATUS').Value       := fRetVal(FRegMLPgto[intCont].strStatus);
        qryDados.ParamByName(arrIndCam[1].strNomCam).Value  := fRetVal(FRegMLPgto[intCont].strCodAut);
        qryDados.ParamByName(arrIndCam[2].strNomCam).Value  := fRetVal(FRegMLPgto[intCont].strDtaTra, True);
        qryDados.ParamByName(arrIndCam[3].strNomCam).Value  := fRetVal(FRegMLPgto[intCont].strDtaPag, True, True);
        qryDados.ParamByName(arrIndCam[4].strNomCam).Value  := IIF(fRetVal(FRegMLPgto[intCont].fltValPro) = 0,
                                                                   fRetVal(FRegMLPgto[intCont].fltValLiq),
                                                                   fRetVal(FRegMLPgto[intCont].fltValPro));
        qryDados.ParamByName(arrIndCam[5].strNomCam).Value  := fRetVal(FRegMLPgto[intCont].fltValEnv);
        qryDados.ParamByName(arrIndCam[6].strNomCam).Value  := fRetVal(FRegMLPgto[intCont].fltValLiq);
        qryDados.ParamByName(arrIndCam[7].strNomCam).Value  := fRetVal(FRegMLPgto[intCont].fltValMPG);
        qryDados.ParamByName(arrIndCam[8].strNomCam).Value  := fRetVal(FRegMLPgto[intCont].fltValPla);
        qryDados.ParamByName(arrIndCam[9].strNomCam).Value  := fRetVal(FRegMLPgto[intCont].fltValDev);
        qryDados.ParamByName(arrIndCam[10].strNomCam).Value := fRetVal(FRegMLPgto[intCont].strTipPag);
        qryDados.ParamByName(arrIndCam[11].strNomCam).Value := fRetVal(FRegMLPgto[intCont].strNumOpe);
        qryDados.ParamByName(arrIndCam[12].strNomCam).Value := fRetVal(FRegMLPgto[intCont].strNumVen);
        qryDados.ParamByName(INICAM + 'NOMARQ').AsString    := fRetVal(FRegMLPgto[intCont].strNomArq);
        qryDados.ParamByName(INICAM + 'DTAARQ').Value       := fRetVal(FRegMLPgto[intCont].strDtaArq, True, False);
        qryDados.ParamByName(INICAM + 'CODEST').Value       := fRetVal(FRegMLPgto[intCont].strCodEst);
        qryDados.ParamByName(INICAM + 'NUMPAR').Value       := '01';
        qryDados.ParamByName(INICAM + 'TOTPAR').Value       := '01';
        qryDados.ParamByName(INICAM + 'NUMCAR').Value       := '00000000000000';
        qryDados.ParamByName(arrIndCam[14].strNomCam).Value := fRetVal(FRegMLPgto[intCont].strShp_ID);
        qryDados.ParamByName(arrIndCam[15].strNomCam).Value := fRetVal(FRegMLPgto[intCont].CupomDesconto);
        qryDados.ParamByName(arrIndCam[16].strNomCam).Value := fRetVal(FRegMLPgto[intCont].OrderId);

        If qryDados.SQL.Contains('MER_CODEMP') Then
          qryDados.ParamByName('MER_CODEMP').Value := fRetVal(FRegMLPgto[intCont].LCodEmp);

         qryDados.ParamByName(INICAM + 'CUPEFE').Value := fRetVal(FRegMLPgto[intCont].CustoDescontoOferecido);

        If RegistroDeVendaMarcadoComoFretePeloML(FRegMLPgto[intCont]) Then
          qryDados.ParamByName(arrIndCam[0].strNomCam).AsString := 'payment';

        qryDados.ExecSQL;

       If Not AnsiUpperCase(FRegMLPgto[intCont].strTipReg).Contains('TOTAL') Then
         untMercadoLivrePgto.FTemRegistroParaConciliacao := True;
      End;

      pgbProg.Position := pgbProg.Position + 1;
    End;
  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao gravar a importação do arquivo.' + #13 +
                             'Erro gerado: ' + E.Message);
  End;


  Try
    qryDados.Close;
    qryDados.SQL := 'REPLACE INTO ESTCAR (CAR_CODEST, CAR_NOMOPE) VALUES (:ESTAB, "MERCADO LIVRE")';
    For intCont := 0 To lstEstabel.Count - 1 Do
    Begin
      qryDados.ParamByName('ESTAB').AsString := lstEstabel[intCont];
      qryDados.ExecSQL;
    End;
  Except
    Raise Exception.Create('A tabela ESTCAR não foi criada. Entre em contato com a Citel!');
  End;

  If Assigned(FRegistrosJaImportados) Then
    FRegistrosJaImportados := Nil;

  If Assigned(FDatasPagamento) Then
    FreeAndNil(FDatasPagamento);
end;

function TMercadoLivrePgto.RegistroDeVendaMarcadoComoFretePeloML(ARegistroMLPgto: TRegistroPgto): Boolean;
begin
  If fRetVal(ARegistroMLPgto.strTipReg) <> 'shipping' Then
    Exit(False);

  If fRetVal(ARegistroMLPgto.fltValLiq) <= 0 Then
    Exit(False);

  If fRetVal(ARegistroMLPgto.strCodAut) = fRetVal(ARegistroMLPgto.strShp_ID) Then
    Exit(False);

  Result := Not LowerCase(fRetVal(ARegistroMLPgto.strCodAut)).Contains('cashback_');
end;

function TMercadoLivrePgto.RegistroJaImportado(AIndex: Integer): Boolean;
  Var
    LTipReg,
    LStatus,
    LCodAut: String;

    LDtaTra,
    LDtaPag : TDateTime;
    LDtaAux: String;
begin
  LTipReg := fRetVal(FRegMLPgto[AIndex].strTipReg);
  LStatus := fRetVal(FRegMLPgto[AIndex].strStatus);
  LCodAut := fRetVal(FRegMLPgto[AIndex].strCodAut);

  LDtaAux := fRetVal(FRegMLPgto[AIndex].strDtaTra, True);
  LDtaAux := Copy(LeftStr(LDtaAux,10), 9, 2) + '/'+
             Copy(LeftStr(LDtaAux,10), 6, 2) + '/' +
             Copy(LeftStr(LDtaAux,10), 1, 4) + RightStr(LDtaAux,9);
  LDtaTra := StrToDateTime(LDtaAux);


  LDtaAux := fRetVal(FRegMLPgto[AIndex].strDtaPag, True);
  LDtaAux := Copy(LeftStr(LDtaAux,10), 9, 2) + '/'+
             Copy(LeftStr(LDtaAux,10), 6, 2) + '/' +
             Copy(LeftStr(LDtaAux,10), 1, 4) + RightStr(LDtaAux,9);
  LDtaPag := StrToDateTime(LDtaAux);


  Result := FRegistrosJaImportados.Locate('MER_TIPREG;MER_STATUS;MER_CODAUT;MER_DTATRA;MER_DTAPAG',
                                      VarArrayOf([LTipReg,
                                                  LStatus,
                                                  LCodAut,
                                                  LDtaTra,
                                                  LDtaPag]),[]);
end;

function TMercadoLivrePgto.RetornaLinhaFormatada(ALinha: String): String;
begin
  Result :=  StringReplace(ALinha, ' ', EmptyStr, [rfReplaceAll]);     // remove espaços
  Result :=  StringReplace(Result, '"', EmptyStr, [rfReplaceAll]);     // remove aspas duplas
  Result :=  StringReplace(Result, Chr(39), EmptyStr, [rfReplaceAll]); // remove aspas simples
end;

function TMercadoLivrePgto.RetornaPeriodoPagamento: String;
  Var
    LDataInicial: String;
    LDataFinal: String;
begin
  FDatasPagamento.Sort;
  LDataInicial := FDatasPagamento[0];
  LDataFinal := FDatasPagamento[FDatasPagamento.Count - 1];

  Result := 'BETWEEN ' +
             FormatDateTime('yyyy-mm-dd hh:mm:ss', StrToDateTime(LDataInicial + ' 00:00:00')).QuotedString + ' AND '+
             FormatDateTime('yyyy-mm-dd hh:mm:ss', StrToDateTime(LDataFinal + ' 23:59:59')).QuotedString;

end;

function TMercadoLivrePgto.RetornaValorShippingID(ACampos: TStringList): Variant;
begin
  Try
    If VarToStr(fGetDados(ACampos[arrIndCam[14].intIndice])).Trim.IsEmpty Then
    Begin
      If VarToStr(fGetDados(ACampos[arrIndCam[16].intIndice])).Trim.IsEmpty Then
      Begin
        If fGetDados(ACampos[arrIndCam[19].intIndice]) = 'MercadoPago' Then
        Begin
          If fGetDados(ACampos[arrIndCam[20].intIndice]) = 'Checkouts' Then
            Exit(fGetDados(ACampos[arrIndCam[11].intIndice]));
        End;
      End;
    End;
  Except

  End;

  Result := VarToStr(fGetDados(ACampos[arrIndCam[14].intIndice])).Trim;
  If VarToStr(Result).IsEmpty Then
    Result := VarToStr(fGetDados(ACampos[arrIndCam[1].intIndice])).Trim;
end;

procedure TMercadoLivrePgto.ValidaSeOsDadosEstaoCorretos(ACampos: TStringList);
begin
  fGetDados(ACampos[arrIndCam[1].intIndice],
                    False,
                    0,
                    True);

  fGetDados(ACampos[arrIndCam[11].intIndice],
                    False,
                    0,
                    True);

  fGetDados(ACampos[arrIndCam[12].intIndice],
                    False,
                    0,
                    True);

  fGetDados(ACampos[arrIndCam[13].intIndice],
                    False,
                    0,
                    True);

  fGetDados(ACampos[arrIndCam[14].intIndice],
                    False,
                    0,
                    True);
end;

end.
