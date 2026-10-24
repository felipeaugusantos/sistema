unit untFuncBancarias;

interface
  {$WARN NO_RETVAL OFF}

  uses Forms, Classes, IniFiles, SysUtils, Dialogs, StrUtils;

    function fCalcDigitoBco(strCodBco,
                            strNosNum,
                            strBcoIni: String;
                            intCodCar: Integer;
                            strCodEmp: String;
                            dtaDtaAtu: TDateTime): String;

    function fCalcNossoNumeroBco(strCodBco,
                                 strNosNum,
                                 strBcoIni: String;
                                 intCodCar: Integer;
                                 strCodEmp: String;
                                 dtaDtaAtu: TDateTime): String;


    function fCalcDigitoModulo10(strString: String): String;
    function fCalcDigitoModulo11(strString, strDigit1: String; Var strDigitoEncontrado: String): String;
    function fCalcDigitoModulo11Banrisul(strString, strDigit1: String): String;
    function fCalcDigitoModulo11Sicred(strString: String): String;

    function fArqIniAutban(ReadWrite:Integer;NomChave,NomSecao,Conteudo:String; strCodEmp: String):String;

Var // variáveis específicas para o Banrisul
  strDigit1_Banrisul: String;
  strDigit2_Banrisul: String;
  strNosNum_Banrisul: String;

implementation

uses untConstantes, System.UITypes, untFuncoesSimples;

{*****************************************}
{* CALCULA O DIGITO VERIFICADOR          *}
{**************************************MV*}
function fCalcDigitoBco(strCodBco,
                        strNosNum,
                        strBcoIni: String;
                        intCodCar: Integer;
                        strCodEmp: String;
                        dtaDtaAtu: TDateTime): String;
  Var
    strResp      : String;
    strSomAlg    : String;
    strPathAutban: String;
    strModCta    : String;
    strCodAge    : String;
    strCtaCor    : String;
    strCodCar    : String;
    strCartBco   : String;
    strCodCon    : String;
    strCodCed    : String;
    strDigCed    : String;
    strCodCop    : String;
    strBan       : String;
    strEmp       : String;
    strDigCta    : String;
    strDigit1    : String;
    strDigit2    : String;
    strCodPos    : String;
    strModCob    : String;
    strIdentf    : String;
    strSisCob    : String; //Identifica qual sistema de cobrança da CEF (SICOB, SIGCB OU SINCO)
    strTpIdent   : String; //Tipo de Identificador (4/5) HSBC 399 Cobrança Sem Registro *BB*
    strDtaVenc   : String; //Data Vencto, Somente Tp Ident(4) HSBC 399 Cobrança sem Registro *BB*
    intResSoma   : Integer;
    intResDiv    : Integer;
    intContador  : Integer;
    intResultSom : Integer;
    intFat001    : Integer;
    intFat002    : Integer;
    intResMult   : Integer;
    intValMult   : Integer;

begin

  strPathAutban := ExtractFilePath(Application.ExeName) + '\Autban\' + ARQCNFBCO;
  strResp       := fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'RESPONS',strPathAutban, strCodEmp);
  strModCob := '';

  {*******************}
  {* BANCO DO BRASIL *}
  {****************LB*}
  If strCodBco = '001' Then
  Begin
    intResSoma := 0;
    strNosNum  := fPadL(strNosNum, 11, '0');
    strBan     := '678923456789';
    strEmp     := fPadL(strNosNum, Length(strBan),'0');

    strCodCar := fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'NUMCART',strPathAutban, strCodEmp);
    strCodCon := fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'CODCONV',strPathAutban, strCodEmp);

    {*****************************************}
    {* CONVENIO DE 7d NÃO CALCULA DIGITO     *}
    {**************************************AF*}
    If (Length(Trim(strCodCon)) >= 7) Then

      Result := ''

    Else
    Begin

      If Length(Trim(strEmp)) = Length(Trim(strBan)) Then
      Begin

        For intContador := 1 To Length(strBan) Do
        Begin
          intResSoma := intResSoma +  ((StrToInt(strEmp[intContador])) * (StrToInt(strBan[intContador])));
        End;

        intResDiv := intResSoma Mod 11;

        If intResDiv = 10 Then
          Result := 'X'
        Else
          Result :=  LeftStr(IntToStr(intResDiv),1);

      End
      Else
        ShowMessage('Ocorreu algum problema no calculo do dígito verificador do Banco do Brasil (001)');

    End;

  End

  {****************************}
  {* BANCO BANCOOB E CREDISAN *}
  {*************************AF*}
  Else If (strCodBco = '756') Or (strCodBco = '089') Then
  Begin
    intResSoma := 0;
    strNosNum  := fPadL(strNosNum, 7,'0');

    If strCodBco = '756' Then
      strBan := '319731973197319731973'
    Else
      strBan := '654329876543298765432';

    strCodCop  := fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'CODCOPE',strPathAutban, strCodEmp);
    strCodCed  := fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'CODCEDE',strPathAutban, strCodEmp);
    strDigCed  := fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'DIGCEDE',strPathAutban, strCodEmp);

    strEmp     := strCodCop + fStrZero(strCodCed, 9) + strDigCed + fStrZero(strNosNum, 7);

    If Length(Trim(strEmp)) = Length(Trim(strBan)) Then
    Begin

      For intContador := 1 To Length(strBan) Do
        intResSoma := intResSoma +  ((StrToInt(strEmp[intContador])) * (StrToInt(strBan[intContador])));

      intResDiv := intResSoma Mod 11;

      If (intResDiv = 0) Or (intResDiv = 1) Then
        Result := '0'
      Else
        Result :=  LeftStr(IntToStr(11 - intResDiv),1);

    End
    Else
    Begin
      If (strCodBco = '756') Then
        ShowMessage('Ocorreu algum problema no calculo do dígito verificador do Banco BANCOOB (001)')
      Else
        ShowMessage('Ocorreu algum problema no cálculo do dígito verificador do Banco CREDISAN (001)');
    End;

  End

  //*************************************************//
  // BANRISUL                                        //
  //**********************************************ED*//
  Else If strCodBco = '041' Then
  Begin

    strNosNum_Banrisul := fPadL(strNosNum,08,'0');

    strDigit1_Banrisul := fCalcDigitoModulo10(strNosNum_Banrisul);
    strDigit2_Banrisul := fCalcDigitoModulo11Banrisul(strNosNum_Banrisul, strDigit1_Banrisul);

    Result := strDigit1_Banrisul + strDigit2_Banrisul;
  End


  {**************}
  {* BANCO ITAU *}
  {***********LB*}
  Else If MatchStr(strCodBco, ['341', '995', '988', '981', '964']) Then
  Begin

    strCodAge := fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'CODAGEN',strPathAutban, strCodEmp);
    strCtaCor := fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'NUMCTAC',strPathAutban, strCodEmp);
    strCodCar := fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'NUMCART',strPathAutban, strCodEmp);

    strSomAlg  := (strCodAge + strCtaCor + strCodCar + fStrZero(strNosNum,08));
    strBan     := '12121212121212121212';
    intResSoma := 0;

    For intContador := 1 To Length(strBan) Do
    Begin
      intFat001 := StrToInt(strSomAlg[intContador]);
      intFat002 := StrToInt(strBan[intContador]);

      If (intFat001 * intFat002) > 9 Then
        intResSoma := intResSoma + (1 + ((intFat001 * intFat002)-10))
      Else
        intResSoma := intResSoma + (intFat001 * intFat002);
    End;

    intResSoma := 10 - (intResSoma Mod 10);

    If intResSoma > 9 Then
    Begin
      intResSoma := 0;
    End;

    Result := IntToStr(intResSoma);

  End

{******************************************}
{*        BANCO DAYCOVAL [400P]           *}
{*            LAYOUT PRÓPRIO              *}
{*REQ:147378****************************MT*}
  Else If (strCodBco = '707') Then
  Begin

    strCodAge := fGetBancoConfig(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'CODAGEN',strPathAutban, strCodEmp);
    strCtaCor := fGetBancoConfig(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'NUMCTAC',strPathAutban, strCodEmp);
    strCodCar := fGetBancoConfig(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'NUMCART',strPathAutban, strCodEmp);
    strCodAge := Copy(strCodAge, 0, Length(strCodAge)-1);

    strSomAlg  := (strCodAge + strCodCar + fStrZero(strNosNum,10));
    strBan     := '21212121212121212';
    intResSoma := 0;

    For intContador := 1 To Length(strBan) Do
    Begin
      intFat001 := StrToInt(strSomAlg[intContador]);
      intFat002 := StrToInt(strBan[intContador]);

      If (intFat001 * intFat002) > 9 Then
        intResSoma := intResSoma + (1 + ((intFat001 * intFat002)-10))
      Else
        intResSoma := intResSoma + (intFat001 * intFat002);
    End;

    intResSoma := 10 - (intResSoma Mod 10);

    If intResSoma > 9 Then
    Begin
      intResSoma := 0;
    End;

    Result := IntToStr(intResSoma);

  End

{******************************************}
{*           BANCO ABC BRASIL             *}
{*            LAYOUT PRÓPRIO              *}
{*REQ:185769****************************TA*}
  Else If (strCodBco = '246') Then
  Begin

    strCodAge := fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'CODAGEN',strPathAutban, strCodEmp);
    strCodCar := fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'CODCART',strPathAutban, strCodEmp);

    strSomAlg  := (strCodAge + strCodCar + fStrZero(strNosNum,10));
    strBan     := '21212121212121212';
    intResSoma := 0;

    For intContador := 1 To Length(strBan) Do
    Begin
      intFat001 := StrToInt(strSomAlg[intContador]);
      intFat002 := StrToInt(strBan[intContador]);

      If (intFat001 * intFat002) > 9 Then
        intResSoma := intResSoma + (1 + ((intFat001 * intFat002)-10))
      Else
        intResSoma := intResSoma + (intFat001 * intFat002);
    End;

    intResSoma := 10 - (intResSoma Mod 10);

    If intResSoma > 9 Then
    Begin
      intResSoma := 0;
    End;

    Result := IntToStr(intResSoma);

  End

  {***************************}
  {* CAIXA ECONOMICA FEDERAL *}
  {************************LB*}
  Else If strCodBco = '104' Then
  Begin
    strCodCar := fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'NUMCART',strPathAutban, strCodEmp);
    strSisCob := fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'SISCOB', strPathAutban, strCodEmp);

    If (strCodCar = '24')      Or
       ((strCodCar = '14')     And
        (strSisCob = 'SIGCB')) Then
    Begin
      strNosNum := strCodCar + fPadL(strNosNum,15,'0');
      strBan    := '29876543298765432';
    End
    Else If strCodCar = '08' Then
    Begin
      strNosNum := '8' + fPadL(strNosNum,14,'0');
      strBan    := '876543298765432';
    End
    Else
    Begin
      strNosNum  := fPadL(strNosNum,10,'0');
      strBan     := '3298765432';
    End;

    intResSoma := 0;

    For intContador := 1 To Length(strBan) Do
    Begin
      intResSoma := intResSoma + ((StrToInt(strBan[intContador])) * (StrToInt(strNosNum[intContador])));
    End;

    intResultSom := intResSoma Mod 11;
    intResDiv := 11 - intResultSom;

    If intResDiv > 9 Then
      Result := '0'
    Else
      Result := LeftStr(IntToStr(intResDiv),1);

  End

  {***********}
  {* BRB     *}
  {********KP*}
  Else If strCodBco = '070' Then
  begin
    {strCodMod  := Copy(fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'CODMOD_',strPathAutban, strCodEmp), 1, 1);
    strCtaCor  := fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'NUMCTAC',strPathAutban, strCodEmp);
    strCtaCor  := fPadL(strCtaCor,10,'0');

    strDigit1  := fCalcDigitoModulo10('000' + strCtaCor + strCodMod + strNosNum + '070');
    strDigit2  := fCalcDigitoModulo11('000' + strCtaCor + strCodMod + strNosNum + '070', strDigit1);

    Result     := strDigit1 +  strDigit2;}
    Result     := '';
  End

  {***********}
  {* BANESPA *}
  {********LB*}
  Else If ((strCodBco = '033') Or (strCodBco = '353')) And (Pos(strBcoIni,'033B_033B240p_033API_') <= 0) Then
  Begin
    strNosNum  := fStrZero(strNosNum,10);
    strBan     := '7319731973';
    intResSoma := 0;

    If Length(Trim(strNosNum)) = Length(Trim(strBan)) Then
    Begin

      For intContador := 1 To Length(strBan) do
      Begin
        intResMult := StrToInt( fStrZero(IntToStr((StrToInt(strNosNum[intContador]) * StrToInt(strBan[intContador])) ),02 ) );
        intValMult := StrToInt(RightStr(IntToStr(intResMult),01));
        intResSoma := intResSoma + intValMult;
      End;

      intResSoma := StrToInt(RightStr(fStrZero(IntToStr(intResSoma),05),1));
      intResDiv  := 10 - intResSoma;

    If intResDiv = 10 Then
      Result := '0'
    Else
      Result := IntToStr(intResDiv);

    End;
  End

  {*****************}
  {* SANTANDER 033 *}
  {**************AF*}
  Else If (MatchStr(strCodBco, ['033', '637'])) And (Pos(strBcoIni,'033B_033B240p_637_444p_033API_') > 0)  Then
  Begin
    strNosNum  := fStrZero(strNosNum,12);

    If strBcoIni.Equals('033API') Then
      Exit(EmptyStr);

    strBan     := '543298765432';
    intResSoma := 0;

    If Length(Trim(strNosNum)) = Length(Trim(strBan)) Then
    Begin

      For intContador := 1 To Length(strBan) do
      Begin
        intResMult := StrToInt(strNosNum[intContador]) * StrToInt(strBan[intContador]);
        intResSoma := intResSoma + intResMult;
      End;

      intResDiv := intResSoma Mod 11;

      If intResDiv = 10 Then
        Result := '1'

      Else If (intResDiv = 0) Or (intResDiv = 1) Then
        Result := '0'

      Else
      Begin
        intResDiv  := 11 - intResDiv;
        Result := IntToStr(intResDiv);
      End;

    End;
  End

  {***************************************}
  {* SOFISA - 637 LP 444- LAYOUT PROPRIO *}
  {***************************************}
  Else If (strCodBco = '637') And (strBcoIni = '637LP444p') Then
  begin
    strCodAge := fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'CODAGEN',strPathAutban, strCodEmp);
    strCodCar := fStrZero(fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'CARTBCO',strPathAutban, strCodEmp), 3);
    strCartBco := fStrZero(fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'CARTBCO',strPathAutban, strCodEmp), 3);

    strSomAlg := (strCodAge + strCartBco + fStrZero(strNosNum,10));
    strBan    := '21212121212121212';
    intResSoma := 0;

    for intContador := Length(strBan) downto 1 do
    begin
      intFat001 := StrToInt(strSomAlg[intContador]);
      intFat002 := StrToInt(strBan[intContador]);

      If (intFat001 * intFat002) > 9 Then
        intResSoma := intResSoma + (((intFat001 * intFat002) div 10) + ((intFat001 * intFat002) mod 10))
      else
        intResSoma := intResSoma + (intFat001 * intFat002);
    end;

    intResDiv := intResSoma mod 10;
    if intResDiv = 0 then
      Result := '0'
    else
      Result := IntToStr(10 - intResDiv);
  end

  {*****************}
  {* BANESTES  021 *}
  {**************AF*}
  Else If (strCodBco = '021') Then
  Begin
    strNosNum  := fStrZero(strNosNum, 08);
    strBan     := '98765432';
    intResSoma := 0;

    If Length(Trim(strNosNum)) = Length(Trim(strBan)) Then
    Begin

      {******************************}
      {* CÁLCULO DO PRIMEIRO DÍGITO *}
      {***************************AF*}
      For intContador := 1 To Length(strBan) Do
      Begin
        intResMult := StrToInt(strNosNum[intContador]) * StrToInt(strBan[intContador]);
        intResSoma := intResSoma + intResMult;
      End;

      intResDiv := intResSoma Mod 11;

      If (intResDiv = 0) Or (intResDiv = 1) Then
        strDigit1 := '0'
      Else
      Begin
        intResDiv  := 11 - intResDiv;
        strDigit1 := IntToStr(intResDiv);
      End;

      {*****************************}
      {* CÁLCULO DO SEGUNDO DÍGITO *}
      {**************************AF*}
      strBan := 'X98765432';
      intResSoma := 0;
      strNosNum := strNosNum + strDigit1;

      For intContador := 1 To Length(strBan) Do
      Begin
        If strBan[intContador] = 'X' Then
          intResMult := StrToInt(strNosNum[intContador]) * 10
        Else
          intResMult := StrToInt(strNosNum[intContador]) * StrToInt(strBan[intContador]);

        intResSoma := intResSoma + intResMult;
      End;

      intResDiv := intResSoma Mod 11;

      If (intResDiv = 0) Or (intResDiv = 1) Then
        strDigit2 := '0'
      Else
      Begin
        intResDiv  := 11 - intResDiv;
        strDigit2 := IntToStr(intResDiv);
      End;

      Result := strDigit1 + strDigit2;
    End
    Else
    Begin
      MessageDlg('Tamanho do Nosso Número incorreto. Deve ser 8 posições.', mtError, [mbOk], 0);
      Result := '';
    End;

  End

  {**********************************************}
  {* BMPMONEYPLUS - 274 LP 400 - LAYOUT PROPRIO *}
  {**********************************************}
  Else If (strCodBco = '274') And (strBcoIni = '274LP400p') Then
  Begin
    strCodCar := fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'CODCART',strPathAutban, strCodEmp);

    strNosNum  := fStrZero(strCodCar,2) + fStrZero(strNosNum,11);
    strBan     := '2765432765432';
    intResSoma := 0;

    If Length(Trim(strNosNum)) = Length(Trim(strBan)) Then
    Begin

      For intContador := 1 To Length(strBan) do
      Begin
        intResMult := StrToInt(strNosNum[intContador]) * StrToInt(strBan[intContador]);
        intResSoma := intResSoma + intResMult;
      End;

      intResDiv := intResSoma Mod 11;

      If intResDiv = 10 Then
        Result := '0'

      Else If (intResDiv = 1) Then
        Result := 'P'

      Else If (intResDiv = 0) Then
        Result := '0'

      Else
      Begin
        intResDiv  := 11 - intResDiv;
        Result := IntToStr(intResDiv);
      End;

    End;

  End

  {************}
  {* BRADESCO *}
  {*********LB*}
  Else If Pos(strCodBco, '237_099_993_994_992_996_997_998_991_989_987_274_982_984_084_983_990_970_979_906_978_977_976_975_974_973_962_') > 0 Then
  Begin
    strCodCar  := fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'CODCART',strPathAutban, strCodEmp);
    strNosNum  := fStrZero(strNosNum,11);
    intResSoma := 0;
    strEmp     := RightStr(strCodCar,02) + strNosNum;
    strBan     := '2765432765432';

    If Length(Trim(strEmp)) = Length(Trim(strBan)) Then
    Begin

      For intContador := 1 To Length(strBan) do
      Begin
        intResSoma := intResSoma +  ((StrToInt(strEmp[intContador])) * (StrToInt(strBan[intContador])));
      End;

      intResDiv := intResSoma Mod 11;

      If intResDiv = 0 Then
        Result := '0'
      Else If intResDiv = 1 Then
        Result := 'P'
      Else
        Result := LeftStr(IntToStr(11 - intResDiv),1);
    End
    Else
    Begin
      If (strCodBco = '274') Then
        ShowMessage('Ocorreu algum problema no cálculo do dígito verificador do BMPMoneyPlus (274)')
      Else If (strCodBco = '982') Then
        ShowMessage('Ocorreu algum problema no cálculo do dígito verificador do Sparti (982)')
      Else
        ShowMessage('Ocorreu algum problema no cálculo do dígito verificador do Banco Bradesco S/A (237)');
    End;

  End

  {************}
  {* CRESOL *}
  {*//MF: 287323 - 17/07/23*}
  Else If strCodBco = '133' Then
  Begin
    strCodCar  := fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'CODCART',strPathAutban, strCodEmp);
    strNosNum  := fStrZero(strNosNum,11);
    intResSoma := 0;
    strEmp     := LeftStr(strCodCar,02) + strNosNum;
    strBan     := '2765432765432';

    If Length(Trim(strEmp)) = Length(Trim(strBan)) Then
    Begin

      For intContador := 1 To Length(strBan) do
      Begin
        intResSoma := intResSoma +  ((StrToInt(strEmp[intContador])) * (StrToInt(strBan[intContador])));
      End;

      intResDiv := intResSoma Mod 11;

      If intResDiv = 0 Then
        Result := '0'
      Else If intResDiv = 1 Then
        Result := 'P'
      Else
        Result := LeftStr(IntToStr(11 - intResDiv),1);
    End
    Else
      ShowMessage('Ocorreu algum problema no c lculo do dígito verificador do Banco Cresol (133)');

  End

  {***************}
  {* GERENCIANET *}
  {*//MF: 284963 - 24/07/23*}
  Else If strCodBco = '364' Then
  Begin
    If (Length(strNosNum) > 20) Then
      strNosNum := LeftStr(strNosNum, 20);

    If (Length(strNosNum) > 11) Then
      strEmp := fStrZero(strNosNum, 20)
    Else
      strEmp  := fStrZero(fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar), 'NUMCTAC', strPathAutban, strCodEmp), 9) +
                   '1' + fStrZero(LeftStr(strNosNum, 10),10);

    intResSoma := 0;
    strBan     := '23456789234567892345';

    Try
      For intContador := 20 DownTo 1 do
      Begin
        intResSoma := intResSoma + ((StrToInt(strEmp[intContador])) * (StrToInt(strBan[21-intContador])));
      End;

      intResDiv := 11 - intResSoma Mod 11;

      If (intResDiv > 9) Or (intResDiv < 2) Then
        Result := '1'
      Else
        Result := IntToStr(intResDiv);
    Except
      ShowMessage('Ocorreu algum problema no cálculo do dígito verificador do Banco Efí Gerencianet (364)');
    End;

  End

  {***************************}
  {* NOSSA CAIXA NOSSO BANCO *}
  {************************AF*}
  Else If strCodBco = '151' Then
  Begin
    strCodAge := fStrZero(fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar), 'CODAGEN', strPathAutban, strCodEmp), 4);
    strModCta := fStrZero(fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar), 'MODALID', strPathAutban, strCodEmp), 2);
    strCtaCor := '0' + fStrZero(fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar), 'NUMCTAC', strPathAutban, strCodEmp), 6);
    strDigCta := fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'DIGCTAC',strPathAutban, strCodEmp);

    strEmp := strCodAge + strModCta + strCtaCor + strDigCta + fStrZero(RightStr(strNosNum,9), 9);
    strBan := '31973197319731319731973';

    If Length(Trim(strEmp)) = Length(Trim(strBan)) Then
    Begin

      intResSoma := 0;

      For intContador := 1 To Length(strBan) Do
        intResSoma := intResSoma + (StrToInt(strEmp[intContador]) * StrToInt(strBan[intContador]));

      intResDiv := intResSoma Mod 10;

      If intResDiv = 0 Then
        Result := '0'
      Else
        Result := IntToStr(10 - intResDiv);

    End
    Else
      ShowMessage('Dados para cálculo de digito incorreto!' + #10#13 + 'Modo Correto(CODAGE: 4/ MODALI: 2/ CTA.COR: 6/ DIG.CTA.COR: 1/ NOSNUM: 9)');

  End

  {**************}
  {* BANCO HSBC *}
  {***********LB*}
  Else If strCodBco = '399' Then
  Begin
    {*******************************************}
    {* S -> COBRANÇA REGISTRADA                *}
    {* N -> QUE QUE VC ACHA???                 *}
    {****************************************AF*}
    strModCob := fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'CBRAREG', strPathAutban, strCodEmp);

    If strModCob = 'S' Then
    Begin
      strIdentf := fStrZero( LeftStr(fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar), 'IDENTBC', strPathAutban, strCodEmp), 5), 5);
      strNosNum := fStrZero( RightStr(strNosNum, 5), 5);

      strEmp     := strIdentf + strNosNum;
      strBan     := '5432765432';
      intResSoma := 0;

      For intContador := 1 To Length(strBan) Do
        intResSoma := intResSoma +  ((StrToInt(strEmp[intContador])) * (StrToInt(strBan[intContador])));

      intResDiv := intResSoma Mod 11;

      If (intResDiv = 0) Or (intResDiv = 1) Then
        Result := '0'
      Else
        Result := LeftStr(IntToStr(11 - intResDiv),1);

    End
    Else
    {****************************************************}
    {* A COBRANCA SEM REGISTRO POSSUI 2 IDENTIFICADORES *}
    {* ESSE É O TIPO IDENTIFICADOR 5 POIS SÃO OPCIONAIS *}
    {*************************************************AF*}
    Begin
      strCodCed := fStrZero( fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar), 'CODCDEN', strPathAutban, strCodEmp), 7);
      strNosNum := fStrZero( RightStr(strNosNum, 9), 9);

      {*****************************************************}
      {* COMO O IDENTIFICADOR UTILIZADO PARA A COBRANÇA DO *}
      {* HSBC SEM REGISTRO É O "5", E CASO A NOVA **********}
      {* CONFIGURAÇÃO, NÃO ESTEJA PREENCHIDA NO CNFBCO.INI *}
      {* POR DEFAULT VAI SER INFORMADO O IDENTIFICADOR "5" *}
      {**RQ 34389_05/05/15*******************************BB*}
      strTpIdent := fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar) , 'TPIDENT', strPathAutban, strCodEmp);

      If (strTpIdent = '') Then
        strTpIdent := '5';
      {*******************************************}
      {* CALCULO DO PRIMEIRO DIGITO              *}
      {****************************************AF*}
      strEmp     := strNosNum;
      strBan     := '923456789';
      intResSoma := 0;

      For intContador := 1 To Length(strBan) Do
        intResSoma := intResSoma +  ((StrToInt(strEmp[intContador])) * (StrToInt(strBan[intContador])));

      intResDiv := intResSoma Mod 11;

      If (intResDiv = 0) Or (intResDiv = 10) Then
        strDigit1 := '0'
      Else
        strDigit1 := LeftStr(IntToStr(intResDiv),1);

      {*******************************************}
      {* CALCULO DO SEGUNDO DIGITO               *}
      {****************************************AF*}
      strEmp     := strNosNum + strDigit1 + strTpIdent;
      strBan     := '78923456789';
      strCodCed  := fStrZero(strCodCed, 11);

      If strTpIdent = '4' Then
        strDtaVenc := fStrZero(FormatDateTime('ddMMYY', dtaDtaAtu), 11)
      else
        strDtaVenc := '0';

      strEmp := fStrZero(IntToStr(StrToInt64(strEmp) + StrToInt64(strCodCed) + StrToInt64(strDtaVenc)), 11);

      intResSoma := 0;
      For intContador := 1 To Length(strEmp) Do
        intResSoma := intResSoma +  ((StrToInt(strEmp[intContador])) * (StrToInt(strBan[intContador])));

      intResDiv := intResSoma Mod 11;

      If (intResDiv = 0) Or (intResDiv = 10) Then
        strDigit2 := '0'
      Else
        strDigit2 := LeftStr(IntToStr(intResDiv),1);

      Result := strDigit1 + strTpIdent + strDigit2;
    End;

  End


  {****************}
  {*  BANCO SAFRA *}
  {*************LB*}
  Else If (strCodBco = '422' )And (strBcoIni <> '422API') Then
  Begin
    strNosNum := fStrZero(strNosNum,08);
    strBan    := '98765432';
    strEmp    := fPadL(strNosNum,Length(strBan),'0');

    If Length(Trim(strEmp)) = Length(Trim(strBan)) Then
    Begin
      intResSoma := 0;

      For intContador := 1 To Length(strBan) Do
        intResSoma := intResSoma +  ((StrToInt(strEmp[intContador])) * (StrToInt(strBan[intContador])));

      intResDiv := intResSoma Mod 11;

      If intResDiv = 0 Then
        Result := '1'

      Else If intResDiv = 1 Then
        Result := '0'

      Else
        Result := LeftStr(IntToStr(11 - intResDiv),1);

    End
    Else
      ShowMessage('Ocorreu algum problema no cálculo, do dígito verificador do Banco Safra (422)');

  End

  Else


  {********************}
  {* BANCO RIB PRETO  *}
  {*****************LB*}
  If strCodBco = '741' Then
  Begin

    strCodCar  := fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'CODCART',strPathAutban, strCodEmp);
    strNosNum  := strCodCar + fStrZero(strNosNum,11);
    strBan     := '2765432765432';
    intResSoma := 0;

    For intContador := 1 To Length(strBan) Do
    Begin
      intResSoma := intResSoma + ((StrToInt(strBan[intContador])) * (StrToInt(strNosNum[intContador])));
    End;

    intResultSom := (intResSoma Mod 11);


    If Not (intResultSom = 1)  Then
    Begin

      If Not (intResultSom = 0) Then
      Begin
        intResDiv := 11 - intResultSom;
        Result := LeftStr(IntToStr(intResDiv),1);
      End
      Else
        Result := '0';

    End
    Else
      Result := 'P';


  End


  //*************************************************//
  // SICREDI                                         //
  //**********************************************ED*//
  Else If strCodBco = '748' Then
  Begin

    strCodAge := fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'CODAGEN',strPathAutban, strCodEmp);
    strCtaCor := fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'IDENTBC',strPathAutban, strCodEmp);
    strCodPos := fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'POSTOCO',strPathAutban, strCodEmp);
    strCodCed := fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'CEDENTE',strPathAutban, strCodEmp);

    // POSTO ALFANUMERICO (EX.: "AJ") ENTRA COMO "00" NO DV DO NOSSO NUMERO - MANUAL CNAB 400 DO SICREDI, ITEM 4.5
    If fRetSomenteNumeros(strCodPos) <> strCodPos Then
      strCodPos := '00';

    strNosNum := fStrZero(strCodAge, 04) +
                 fStrZero(strCodPos, 02) +
                 fStrZero(strCtaCor, 05) +
                 FormatDateTime('yy', dtaDtaAtu) +
                 strCodCed +
                 fStrZero( RightStr(strNosNum,5), 5);

    strDigit1 := fCalcDigitoModulo11Sicred(strNosNum);

    Result    := strDigit1;

  End
  Else

  {***********************}
  {* MERCANTIL DO BRASIL *}
  {********************JU*}
  If strCodBco = '389' Then
  Begin
    intResSoma:= 0;
    strCodAge := fStrZero(fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'CODAGEN',strPathAutban, strCodEmp),4);
    strNosNum := RightStr(fStrZero(strNosNum,10),10);

    strEmp := strCodAge + strNosNum;
    strBan := '76543298765432';

    If Length(Trim(strEmp)) = Length(Trim(strBan)) Then
    Begin

      For intContador := 1 To Length(strBan) Do
      Begin
        intResSoma := intResSoma +  ((StrToInt(strEmp[intContador])) * (StrToInt(strBan[intContador])));
      End;

      intResDiv := intResSoma Mod 11;

      If (intResDiv = 1) Or
         (intResDiv = 0) Then
        Result := '0'
      Else
      Begin
        intResultSom := 11 - intResDiv;

        Result := IntToStr(intResultSom) ;
      End;

    End
    Else
      ShowMessage('Ocorreu algum problema no cálculo do dígito verificador do Banco Mercantil');

  End


  //*************************************************//
  // UNIBANCO                                        //
  //**********************************************ED*//
  Else If strCodBco = '409' Then
  Begin
//    strCodCar := RightStr(fArqIniAutban(0,'CONFIG399-1','CODCART',strPathAutban),5);
    strCodCar  := '';
    strNosNum  := RightStr(strNosNum,10);
    strNosNum  := fStrZero(strNosNum,10);
    strEmp     := strCodCar + strNosNum;
    strBan     := '3298765432';
    intResSoma := 0;

    For intContador := 1 To Length(strBan) Do
    Begin
      intResSoma := intResSoma +  ((StrToInt(strEmp[intContador])) * (StrToInt(strBan[intContador])));
    End;

    intResSoma := intResSoma * 10;

    intResDiv := intResSoma Mod 11;

    If (intResDiv = 0) Or (intResDiv = 10) Then
      Result := '0'
    Else
      Result := LeftStr(IntToStr(intResDiv),1);

  End

  {********************}
  {* BANCO DO NORDESTE*}
  {*****************MO*}
  Else If strCodBco = '004' Then
  Begin
    strNosNum  := fStrZero(strNosNum,7);
    strBan    := '8765432';

    intResSoma := 0;

    For intContador := 1 To Length(strBan) Do
      intResSoma := intResSoma +  ((StrToInt(strNosNum[intContador])) * (StrToInt(strBan[intContador])));

    intResDiv := intResSoma Mod 11;

    If (intResDiv = 0) Or (intResDiv = 1) Then
      Result := '0'
    Else
      Result := LeftStr(IntToStr(11-intResDiv),1);
  End

  {***********************}
  {* BANCO DO NORDESTE   *}
  {********************MO*}
  Else If strCodBco = '004' Then
  Begin
    If strResp = 'E' Then
      Result := fStrZero(strNosNum, 07);
  End

  {**************}
  {* BANCO REAL *}
  {***********ED*}
  Else If strCodBco = '356' Then
  Begin

    {strCodAge := fStrZero(fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'CODAGEN',strPathAutban, strCodEmp),4);
    strCtaCor := fStrZero(fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'NUMCTAC',strPathAutban, strCodEmp),7);

    strEmp := fStrZero(strNosNum,7) + strCodAge + strCtaCor;

    Result := fCalcDigitoModulo10( strEmp );}

    Result := '';

  End
  {****************}
  {* BANCO SOFISA *}
  {*************IV*}
{  Else If strCodBco = '637' Then
  Begin

    strNosNum := fStrZero(strNosNum,08);
    Result    := '';

  End  }

  {****************}
  {* BANCO CECRED *}
  {*************JU*}
  Else If strCodBco = '085' Then
  Begin

    Result    := '';

  End

  {******************************************}
  {*        BANCO BTG PACTUAL [240P]        *}
  {*            LAYOUT PRÓPRIO              *}
  {******************************************}
  Else If (strCodBco = '208') Then
  Begin

    intResSoma := 0;
    strNosNum  := fPadL(strNosNum, 11, '0');
    strBan     := '78923456789';
    strEmp     := fPadL(strNosNum, Length(strBan),'0');

    For intContador := 1 To Length(strBan) Do
    Begin
      intResSoma := intResSoma + ((StrToInt(strEmp[intContador])) * (StrToInt(strBan[intContador])));
    End;

    intResDiv := intResSoma Mod 11;

    If intResDiv = 10 Then
       Result := 'X'
    Else
    If intResDiv < 10 Then
       Result :=  LeftStr(IntToStr(intResDiv),1)
    Else
    If intResDiv = 0 Then
       Result := '0';

  End

  {*****************}
  {* BANCO UNICRED *}
  {**************JU*}
  Else If Pos(strCodBco, '090_136_') > 0  Then
  Begin

    strNosNum := FormatDateTime('yy', dtaDtaAtu) + fStrZero(RightStr(strNosNum, 8), 8);
    strBan    := '3298765432';

    intResSoma := 0;

    For intContador := 1 To Length(strBan) Do
    Begin
      intResSoma := intResSoma +  ((StrToInt(strNosNum[intContador])) * (StrToInt(strBan[intContador])));
    End;

    intResDiv := intResSoma Mod 11;

    If (strCodBco = '136') Then
      intResDiv := (11 - intResDiv) ;

    If (intResDiv = 0) Or (intResDiv = 10) Or
       ((strCodBco = '136') And (intResDiv = 11)) Then
      Result := '0'
    Else
      Result := LeftStr(IntToStr(intResDiv),1);


  End;

end;

{*****************************************}
{* CALCULA O NOSSO NUMERO                *}
{**************************************LB*}
function fCalcNossoNumeroBco(strCodBco, strNosNum, strBcoIni: String; intCodCar: Integer; strCodEmp: String; dtaDtaAtu: TDateTime): String;
  Var
    strPathAutban: String;
    strResp      : String;
    strTipCob    : String;
    strCodAgen   : String;
    strModCob    : String;
    strCodCon    : String;
    strCarCfg    : String;
begin

  strPathAutban := ExtractFilePath(Application.ExeName) + 'Autban\' + ARQCNFBCO;
  strResp       := fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'RESPONS',strPathAutban, strCodEmp);
  strTipCob     := fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'TIPCOBR',strPathAutban, strCodEmp);
  strCodAgen    := fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'CODAGEN',strPathAutban, strCodEmp);
  strCodCon     := fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'CODCONV',strPathAutban, strCodEmp);
  strModCob     := '';
  Result        := '';

  {*****************************************}
  {* BANCO BANCOOB                         *}
  {**************************************AF*}
  If (strCodBco = '756') Or (strCodBco = '089') Then
  Begin

    If strResp = 'E' Then
    Begin
      Result := fStrZero(strNosNum, 07);
    End;

  End

  {*****************************************}
  {* BANCO GERENCIANET                     *}
  {* MF: 284963 - 13/07/23                 *}
  {*****************************************}
  Else If strCodBco = '364' Then
  Begin
    //Result  := fPadL(fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'NUMCTAC',strPathAutban, strCodEmp), 9, '0') +
    //           '1' +
    //           fPadL(RightStr(strNosNum, 10), 10, '0');

    Result  := fPadL(RightStr(strNosNum, 10), 10, '0');
  End


  {*****************************************}
  {* CRESOL                                *}
  {* MF: 287323 - 14/07/23                 *}
  {*****************************************}
  Else If strCodBco = '133' Then
  Begin
    Result  := fPadL(RightStr(strNosNum, 11), 11, '0');
  End

  {*****************************************}
  {* BANCO DO BRASIL                       *}
  {**************************************LB*}
  Else If strCodBco = '001' Then
  Begin

    If (strResp = 'E') Or (strBcoIni = '001API') Then
    Begin

      If (Length(Trim(strCodCon)) >= 7) Then
        Result := fPadL(RightStr(strNosNum, 10), 10, '0')
      Else
        Result := strCodCon +fStrZero(RightStr(strNosNum,5), 5);

    End;

  End

  {*****************************************}
  {* BRB                                   *}
  {**************************************KP*}

  Else If strCodBco = '070' Then
  Begin
    Result     := fPadL(RightStr(strNosNum, 06), 06, '0');
  End

  {*****************************************}
  {* BANESPA                               *}
  {**************************************LB*}
  Else  If (strCodBco = '033') And (Pos(strBcoIni,'033B_033B240p_033API_') <= 0) Then
  Begin

    If strResp = 'E' Then
      Result := ( strCodAgen + RightStr(fStrZero(strNosNum, 07), 07) );

  End

  {*****************************************}
  {* SANTANDER                             *}
  {**************************************LU*}
  Else If strCodBco = '353' Then
  Begin
    Result := fStrZero(strNosNum, 07);
  End

  {*****************************************}
  {* SANTANDER 033                         *}
  {**************************************AF*}
  Else If (strCodBco = '033') And (Pos(strBcoIni,'033B_033B240p_') > 0) Then
  Begin
    Result := fStrZero(Copy(strNosNum,1,7), 07);
  End

  {*****************************************}
  {* SANTANDER 033 API                     *}
  {**************************************AJ*}
  Else If (strCodBco = '033') And (strBcoIni.Equals('033API')) Then
  Begin
    Result := fStrZero(strNosNum, 12);
  End

  {*****************************************}
  {* SOFISA LAYOUT PROPRIO                 *}
  {**************************************LB*}
  Else If (Pos(strCodBco, '637') > 0) And (Pos(strBcoIni,'637LP444p') > 0) Then
  Begin

    Result := fStrZero(strNosNum, 10);

  End

  {*****************************************}
  {* SOFISA                                *}
  {**************************************LB*}
  Else If Pos(strCodBco, '637_') > 0 Then
  Begin

    Result := fStrZero(strNosNum, 12);

  End

  {*****************************************}
  {* BANESTES 021                          *}
  {**************************************AF*}
  Else If (strCodBco = '021') Then
  Begin
    Result := fStrZero(Copy(strNosNum,1,8), 08);
  End

  //*************************************************//
  // BANRISUL                                        //
  //**********************************************ED*//
  Else If strCodBco = '041' Then
  Begin

    If strResp = 'E' Then
      Result := fStrZero(strNosNum, 08);

  End

  {**********************************************}
  {* BMPMONEYPLUS - 274 LP 400 - LAYOUT PROPRIO *}
  {*******************************************LB*}
  Else If (strCodBco = '274') And (strBcoIni = '274LP400p') Then
  Begin
    If strResp = 'E' Then
       Result := fStrZero(strNosNum, 11);
  End

  {*****************************************}
  {* BRADESCO                              *}
  {**************************************LB*}
  Else If Pos(strCodBco, '237_099_993_994_992_996_997_998_991_989_987_274_982_984_084_983_990_970_979_906_978_977_976_975_974_973_962_') > 0 Then
  Begin

    Result := fStrZero(strNosNum, 11);

  End


  {*****************************************}
  {* BANCO ITAU                            *}
  {**************************************LB*}
  Else If MatchStr(strCodBco, ['341', '995', '988', '981', '964']) Then
  Begin

    If strResp = 'E' Then
      Result := fStrZero(strNosNum, 08);

  End

{******************************************}
{*        BANCO DAYCOVAL [400P]           *}
{*            LAYOUT PRÓPRIO              *}
{*REQ:147378****************************MT*}
  Else If (strCodBco = '707') Then
  Begin

    If strResp = 'E' Then
      Result := fStrZero(strNosNum, 08);

  End

 {******************************************}
 {*          BANCO ABC BRASIL              *}
 {*            LAYOUT PRÓPRIO              *}
 {*REQ:185769****************************TA*}
  Else If (strCodBco = '246') Then
  Begin

    If strResp = 'E' Then
      Result := fStrZero(strNosNum, 10);

  End

  {*********************}
  {* BANCO DO NORDESTE *}
  {******************MO*}
  Else If strCodBco = '004' Then
  Begin

    If strResp = 'E' Then
      Result := fStrZero(strNosNum, 07);

  End

  {*****************************************}
  {* BANCO REAL                            *}
  {**************************************ED*}
  Else If strCodBco = '356' Then
  Begin

    If strResp = 'E' Then
    Begin

      If strTipCob = 'S' Then
        Result := fStrZero(strNosNum, 07)
      Else
        Result := fStrZero(strNosNum, 13);

    End;

  End


  {*****************************************}
  {* CAIXA ECONÔMICA FEDERAL               *}
  {**************************************LB*}
  Else If strCodBco = '104' Then
  Begin

    If strResp = 'E' Then
      Result := fStrZero(strNosNum, 10);

  End


  {*****************************************}
  {* MERCANTIL DO BRASIL                   *}
  {**************************************JU*}
  Else If strCodBco = '389' Then
  Begin

    If strResp = 'E' Then
      Result := fStrZero(strNosNum,10);

  End


  {*****************************************}
  {* BANCO DO HSBC                         *}
  {**************************************AF*}
  Else If strCodBco = '399' Then
  Begin

    If strResp = 'E' Then
    Begin
      {*******************************************}
      {* S -> COBRANÇA REGISTRADA                *}
      {* N -> QUE QUE VC ACHA???                 *}
      {****************************************AF*}
      strModCob := fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'CBRAREG',strPathAutban, strCodEmp);

      If strModCob = 'S' Then
        Result := fStrZero(fStrZero( LeftStr(fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'IDENTBC', strPathAutban, strCodEmp),5), 5) + fStrZero( RightStr(strNosNum, 5), 5), 10)
      Else
        Result := fStrZero(strNosNum, 9);

    End;

  End


  //*************************************************//
  // UNIBANCO                                        //
  //**********************************************ED*//
  Else If strCodBco = '409' Then
  Begin

    If strResp = 'E' Then
      Result := fStrZero(strNosNum, 10);

  End


  {*****************************************}
  {* BANCO SAFRA                           *}
  {**************************************LB*}
  Else If strCodBco = '422' Then
  Begin

    If strResp = 'E' Then
    Begin
       If (strBcoIni = '422API') Then
           Result := fStrZero(strNosNum,09)
       Else
           Result := fStrZero(strNosNum,08);
    End;

  End

  {*****************************************}
  {* BANCO RIB PRETO                       *}
  {**************************************LB*}
  Else If strCodBco = '741' Then
  Begin

    If strResp = 'E' Then
      Result := fStrZero(strNosNum,11);

  End

  //*************************************************//
  // SICREDI                                         //
  //**********************************************ED*//
  Else If strCodBco = '748' Then
  Begin

    If (strResp = 'E') And (fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'GERTITU',strPathAutban,strCodEmp) <> '') Then
    Begin

      If fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'GERTITU',strPathAutban,strCodEmp) = FormatDateTime('yyyy',dtaDtaAtu) Then
      Begin
        Result := FormatDateTime('yy',dtaDtaAtu) +
                  fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'CEDENTE',strPathAutban, strCodEmp) +
                  fStrZero( RightStr(strNosNum,5), 5);
      End
      Else
      Begin
        Result := FormatDateTime('yy',dtaDtaAtu) +
                  fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'CEDENTE',strPathAutban, strCodEmp) +
                  fStrZero('1', 5);
        fArqIniAutban(1, 'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar), 'GERTITU', FormatDateTime('yyyy',dtaDtaAtu),strCodEmp);
      End;

    End;

  End

  {*************************************************}
  {* SANTANDER                                     *}
  {**********************************************ED*}
  Else If strCodBco = '353' Then
  Begin

    If strResp = 'E' Then
      Result := fStrZero(strNosNum, 10);

  End

  {*************************************************}
  {* SANTANDER  - SOFISA - LAYOUT PROPRIO          *}
  {**********************************************ED*}
  Else If (strCodBco = '637') And (strBcoIni = '637LP444p') Then
  Begin

    If strResp = 'E' Then
      Result := fStrZero(strNosNum, 10);

  End

  {*************************************************}
  {* SANTANDER  - SOFISA                           *}
  {**********************************************ED*}
  Else If strCodBco = '637' Then
  Begin

    If strResp = 'E' Then
      Result := fStrZero(strNosNum, 12);

  End

  {*************************************************}
  {* NOSSA CAIXA NOSSO BANCO                       *}
  {* NOSSO NUMERO COMPOSTO POR 10 DIGITOS SENDO    *}
  {* SEMPRE INICIADO COM 99 E O ULTIMO SENDO O DIG *}
  {**********************************************AF*}
  Else If strCodBco = '151' Then
  Begin

    strCarCfg := fArqIniAutban(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'CODCART',strPathAutban, strCodEmp);

    If strCarCfg = '6' Then
      Result := '99' + fStrZero(RightStr(strNosNum,7), 7)
    Else If strCarCfg = '5' Then
      Result := '9' + fStrZero(RightStr(strNosNum,8), 8)
    Else
      Result := fStrZero(RightStr(strNosNum,9), 9);

  End
  {*************************************************}
  {* BANCO SOFISA                                  *}
  {**********************************************IV*}
  Else If strCodBco = '637' Then
  Begin

    If strResp = 'E' Then
      Result := fStrZero(strNosNum, 08);

  End

  Else If strCodBco = '633' Then
  Begin
    Result := fStrZero(strNosNum, 08);
  End

  {*************************************************}
  {* BANCO CECRED                                  *}
  {**********************************************JU*}
  Else If strCodBco = '085' Then
  Begin

    If strResp = 'E' Then
      Result := fStrZero(strNosNum, 09);

  End

 {******************************************}
 {*        BANCO BTG PACTUAL [240P]        *}
 {*            LAYOUT PRÓPRIO              *}
 {******************************************}
  Else If (strCodBco = '208') Then
  Begin

    If strResp = 'E' Then
      Result := fStrZero(strNosNum, 11);

  End

  {*************************************************}
  {* BANCO UNICRED                                 *}
  {**********************************************JU*}
  Else If Pos(strCodBco, '090_136_') > 0  Then
  Begin
    If (strCodBco = '136') And (Length(strNosNum) <= 10)  Then
      strNosNum := fStrZero(strNosNum, 10)
    Else If (strCodBco = '136') Then
      strNosNum :=  FormatDateTime('yy', dtaDtaAtu) + fStrZero(RightStr(strNosNum, 8), 8);

    If LeftStr(strNosNum, 02) = FormatDateTime('yy', dtaDtaAtu) Then
      Result := fStrZero(strNosNum, 10)
    Else If (strCodBco <> '136') Then
      Result := FormatDateTime('yy', dtaDtaAtu) +  fStrZero(strNosNum, 08)
    Else
      Result := FormatDateTime('yy', dtaDtaAtu) + fStrZero(RightStr(strNosNum, 8), 8);
  End
  {********************************}
  {* BANCO DA AMAZONIA            *}
  {*****************************JU*}
  Else If strCodBco = '003' Then
  Begin
    Result := fPadL(strNosNum, 16, '0');
  End
  {*****************************************}
  {* DEMAIS BANCOS                         *}
  {**************************************LB*}
  Else
    Result := fStrZero(strNosNum, 10);

end;






//*************************************************//
// CALCULA O DIGITO NO MODULO 10                   //
//**********************************************ED*//
function fCalcDigitoModulo10(strString: String): String;
  Const
    strBase = '121212121212121212121212121212';

  Var
    intContador : Integer;
    intFator1   : Integer;
    intFator2   : Integer;
    intResult   : Integer;

Begin

  intResult := 0;

  For intContador := 0 To Length(strString)-1 Do
  Begin

    intFator1 := StrToInt( Copy(strString, Length(strString)-intContador, 1 ) );
    intFator2 := StrToInt( Copy(strBase,   Length(strBase)-intContador,   1 ) );

    If (intFator1 * intFator2) > 9 Then
      intResult := intResult + ( (intFator1 * intFator2) - 9 )
    Else
      intResult := intResult + (intFator1 * intFator2);

  End;

  If intResult >= 10 Then
    intResult := intResult Mod 10;


  If intResult = 0 Then
    Result := '0'
  Else
    Result := IntToStr( 10 - intResult );


End;



//*************************************************//
// CALCULA O DIGITO NO MODULO 11                   //
//**********************************************ED*//
function fCalcDigitoModulo11(strString, strDigit1: String; Var strDigitoEncontrado: String): String;
  Const
    strBase = '765432765432765432765432765432765432765432';
    //strBase =   '329876543298765432987654329876543298765432';

  Var
    intContador : Integer;
    intFator1   : Integer;
    intFator2   : Integer;
    intResult   : Integer;
    blnVerifi   : Boolean;
    strDigitoNovo: String;
    strConcatena: String;
    strDigit2   : String;

Begin

  blnVerifi := False;
  strConcatena := strString + strDigit1;
  intResult := 0;

  For intContador := 0 To Length(strConcatena)-1 Do
  Begin

    intFator1 := StrToInt( Copy(strConcatena, Length(strConcatena)-intContador, 1 ) );
    intFator2 := StrToInt( Copy(strBase,   Length(strBase)-intContador,   1 ) );

    intResult := intResult + (intFator1 * intFator2);

  End;


  intResult := intResult Mod 11;

  If intResult = 1 Then
  Begin

    If StrToInt( strDigit1 ) = 9 Then
      strDigit1 := '0'
    Else
      strDigit1 := IntToStr( StrToInt( strDigit1 ) + 1 );


    strDigit2 := IntToStr( intResult );


    While strDigit2 = '1' Do
    Begin

      blnVerifi := True;

      strDigit2 := fCalcDigitoModulo11( strString, strDigit1, strDigitoNovo);

      If strDigit2 = '1' Then
        strDigit1 := IntToStr( StrToInt( strDigit1 ) + 1 );

      intResult := StrtoInt( strDigit2 );

    End;

  End
  Else If intResult = 10 Then
  Begin
    intResult := 1;
  End;


  If Not blnVerifi Then
    If intResult > 1  Then
      intResult := 11 - intResult;

  strDigitoEncontrado := strDigit1;
  Result := IntToStr( intResult );
End;

function fArqIniAutban(ReadWrite:Integer;NomChave,NomSecao,Conteudo:String; strCodEmp: String):String;
begin
  Result := untFuncoesSimples.fGetBancoConfig(REadWrite, NomChave, NomSecao, Conteudo, strCodEmp);
end;

{**************************************************}
{* CALCULA O DIGITO NO MODULO 11 SICRED           *}
{***********************************************AF*}
function fCalcDigitoModulo11Sicred(strString: String): String;
  Const
    strBase = '4329876543298765432';

  Var
    intContador : Integer;
    intFator1   : Integer;
    intFator2   : Integer;
    intResult   : Integer;
Begin
  intResult := 0;

  For intContador := 0 To Length(strString)-1 Do
  Begin

    intFator1 := StrToInt( Copy(strString, Length(strString)-intContador, 1 ) );
    intFator2 := StrToInt( Copy(strBase,   Length(strBase)-intContador,   1 ) );

    intResult := intResult + (intFator1 * intFator2);

  End;

  intResult := intResult Mod 11;

  intResult := 11 - intResult;

  If intResult >= 10 Then
    intResult := 0;

  Result := IntToStr( intResult );


End;

//************************************************************//
// CALCULA O DIGITO NO MODULO 11  - ESPECIFICO PARA BANRISUL  //
//*********************************************************LU*//
function fCalcDigitoModulo11Banrisul(strString, strDigit1: String): String;
  Const
    strBase = '765432765432765432765432765432765432765432';
  Var
    intContador : Integer;
    intFator1   : Integer;
    intFator2   : Integer;
    intResult   : Integer;
    blnVerifi   : Boolean;
    strDigit2   : String;
Begin

  blnVerifi := False;
  strString := strString + strDigit1;
  intResult := 0;

  For intContador := 0 To Length(strString)-1 Do
  Begin

    intFator1 := StrToInt( Copy(strString, Length(strString)-intContador, 1 ) );
    intFator2 := StrToInt( Copy(strBase,   Length(strBase)-intContador,   1 ) );

    intResult := intResult + (intFator1 * intFator2);

  End;


  If intResult >= 11 Then
    intResult := intResult Mod 11;

  If intResult = 1 Then
  Begin

    If StrToInt( strDigit1 ) = 9 Then
    Begin
      strDigit1_Banrisul := '0';
      strDigit1 := '0';
    End
    Else
    Begin
      strDigit1_Banrisul := IntToStr( StrToInt( strDigit1 ) + 1 );
      strDigit1 := IntToStr( StrToInt( strDigit1 ) + 1 );
    End;


    strDigit2 := IntToStr( intResult );


    While strDigit2 = '1' Do
    Begin

      blnVerifi := True;

      strString := copy(strString,1,length(strString)-1);

      strDigit2 := fCalcDigitoModulo11Banrisul(strString, strDigit1);

      If strDigit2 = '1' Then
        strDigit1 := IntToStr( StrToInt( strDigit1 ) + 1 );

      intResult := StrtoInt( strDigit2 );

    End;

  End
  Else If intResult = 10 Then
  Begin
    intResult := 1;
  End;

  If Not blnVerifi Then
    If intResult > 1  Then
      intResult := 11 - intResult;

  Result := IntToStr( intResult );

End;


end.
