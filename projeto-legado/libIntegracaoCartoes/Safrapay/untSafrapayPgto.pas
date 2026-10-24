{**************************************}
{* Importação de arquivos da SAFRAPAY *}
{***********************************AJ*}
unit untSafrapayPgto;

interface

uses Classes, StrUtils, SysUtils, Variants, untIIntegracaoCartoes, ComCtrls, Dialogs, Forms;

Type

  TRegistroPgto = Record
    strTipReg: String;
    strCodEst: String;
    strDtaPag: String;
    strDtaTra: String;
    strNumNSU: String;
    strTipLan: String;
    strTipPro: String;
    strTipCap: String;
    fltValBru: Double;
    fltValDes: Double;
    fltValLiq: Double;
    strNumCar: String;
    strNumPar: String;
    strTotPar: String;
    fltBruPar: Double;
    fltDesPar: Double;
    fltLiqPar: Double;
    strCodBco: String;
    strCodAge: String;
    strNumCco: String;
    strCodAut: String;
    strCodBan: String;
    strCodPro: String;
    strNumAnt: String;
    strNSUAju: String;
    strTipAju: String;
    strCodAju: String;
    strDesAju: String;
    strNomArq: String;
    strDtaArq: String;
    strVerArq: String;
    strID_Pix: String;

    TaxaAntecipacao: Double;

    DataPrevisaoPagamento,
    DiasAntecipados,
    NumeroEC,
    NumeroRO: String;
  End;

  TEstruturaPgto = Record
    strDescri: String;
    strTipCmp: String;
  End;

  TArrRegistroSafrapayPgto  = Array Of TRegistroPgto;

  TArrEstruturaSafrapayPgto  = Array Of TEstruturaPgto;

  TSafrapayPgto = Class(TInterfacedObject, ICartoes)
  Private
    dtaArq,
    strVerArq: String;

    intPosicaoAtual: Integer;
  Public
    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(pgbProg: TProgressBar);

    class function fRetSQLTabelaRegPgto(strTabela: String): String;
    class function fRetEstruturaPgto(strTabela: String): TArrEstruturaSafrapayPgto;

    class function RetornaListaDeCampos(AObjetoCampos: TArrEstruturaSafrapayPgto): TStringList;
  End;

Var
  strNomArq: String;
Const
  NOMTAB = 'SAF_SAPGTO';
  INICAM = 'SAF_';

implementation

uses untFuncoes, untIDataSet, untAmex;

{ TSafrapayPgto }

{**********************************************}
{* RETORNA A ESTRUTURA DA  TABELA  DE CRÉDITO *}
{* SAF_SAPGTO                                 *}
{*******************************************AJ*}
class function TSafrapayPgto.fRetEstruturaPgto(strTabela: String): TArrEstruturaSafrapayPgto;
Begin
  If strTabela = NOMTAB Then
  Begin
    SetLength(Result, 38);

    Result[0].strDescri  := INICAM + 'CODEST'; Result[0].strTipCmp  := 'VARCHAR(15)'  ;
    Result[1].strDescri  := INICAM + 'TIPREG'; Result[1].strTipCmp  := 'VARCHAR(2)'   ;
    Result[2].strDescri  := INICAM + 'DTAPAG'; Result[2].strTipCmp  := 'DATE'         ;
    Result[3].strDescri  := INICAM + 'TIPLAN'; Result[3].strTipCmp  := 'VARCHAR(1)'   ;
    Result[4].strDescri  := INICAM + 'DTATRA'; Result[4].strTipCmp  := 'DATE'         ;
    Result[5].strDescri  := INICAM + 'NUMNSU'; Result[5].strTipCmp  := 'VARCHAR(12)'  ;
    Result[6].strDescri  := INICAM + 'TIPPRO'; Result[6].strTipCmp  := 'VARCHAR(1)'   ;
    Result[7].strDescri  := INICAM + 'TIPCAP'; Result[7].strTipCmp  := 'INT'          ;
    Result[8].strDescri  := INICAM + 'VALBRU'; Result[8].strTipCmp  := 'DECIMAL(15,2)';
    Result[9].strDescri  := INICAM + 'VALDES'; Result[9].strTipCmp  := 'DECIMAL(15,2)';
    Result[10].strDescri := INICAM + 'VALLIQ'; Result[10].strTipCmp := 'DECIMAL(15,2)';
    Result[11].strDescri := INICAM + 'NUMCAR'; Result[11].strTipCmp := 'VARCHAR(19)'  ;
    Result[12].strDescri := INICAM + 'TOTPAR'; Result[12].strTipCmp := 'VARCHAR(2)'   ;
    Result[13].strDescri := INICAM + 'NUMPAR'; Result[13].strTipCmp := 'VARCHAR(2)'   ;
    Result[14].strDescri := INICAM + 'BRUPAR'; Result[14].strTipCmp := 'DECIMAL(15,2)';
    Result[15].strDescri := INICAM + 'DESPAR'; Result[15].strTipCmp := 'DECIMAL(15,2)';
    Result[16].strDescri := INICAM + 'LIQPAR'; Result[16].strTipCmp := 'DECIMAL(15,2)';
    Result[17].strDescri := INICAM + 'CODBCO'; Result[17].strTipCmp := 'VARCHAR(3)'   ;
    Result[18].strDescri := INICAM + 'CODAGE'; Result[18].strTipCmp := 'VARCHAR(6)'   ;
    Result[19].strDescri := INICAM + 'NUMCCO'; Result[19].strTipCmp := 'VARCHAR(11)'  ;
    Result[20].strDescri := INICAM + 'CODAUT'; Result[20].strTipCmp := 'VARCHAR(6)'   ;
    Result[21].strDescri := INICAM + 'CODBAN'; Result[21].strTipCmp := 'VARCHAR(4)'   ;
    Result[22].strDescri := INICAM + 'CODPRO'; Result[22].strTipCmp := 'VARCHAR(3)'   ;
    Result[23].strDescri := INICAM + 'NUMANT'; Result[23].strTipCmp := 'VARCHAR(9)'   ;
    Result[24].strDescri := INICAM + 'TIPAJU'; Result[24].strTipCmp := 'VARCHAR(1)'   ;
    Result[25].strDescri := INICAM + 'CODAJU'; Result[25].strTipCmp := 'VARCHAR(4)'   ;
    Result[26].strDescri := INICAM + 'DESAJU'; Result[26].strTipCmp := 'VARCHAR(150)' ;
    Result[27].strDescri := INICAM + 'NSUAJU'; Result[27].strTipCmp := 'VARCHAR(12)'  ;
    Result[28].strDescri := INICAM + 'NOMARQ'; Result[28].strTipCmp := 'VARCHAR(255)' ;
    Result[29].strDescri := INICAM + 'DTAARQ'; Result[29].strTipCmp := 'DATE'         ;
    Result[30].strDescri := INICAM + 'VERARQ'; Result[30].strTipCmp := 'VARCHAR(6)'   ;
    Result[31].strDescri := INICAM + 'CONCIL'; Result[31].strTipCmp := 'INT DEFAULT 0';
    Result[32].strDescri := INICAM + 'ID_PIX'; Result[32].strTipCmp := 'VARCHAR(25)'  ;
    Result[33].strDescri := INICAM + 'TAXANT'; Result[33].strTipCmp := 'DECIMAL(12,2)';
    Result[34].strDescri := INICAM + 'DIAANT'; Result[34].strTipCmp := 'VARCHAR(3)   ';
    Result[35].strDescri := INICAM + 'NUM_EC'; Result[35].strTipCmp := 'VARCHAR(9)   ';
    Result[36].strDescri := INICAM + 'NUM_RO'; Result[36].strTipCmp := 'VARCHAR(50)  ';
    Result[37].strDescri := INICAM + 'DTAPRV'; Result[37].strTipCmp := 'DATE'         ;
  End;
End;

class function TSafrapayPgto.fRetSQLTabelaRegPgto(strTabela: String): String;
Var arrCampos: TArrEstruturaSafrapayPgto;
    intCont  : Integer;
begin
  Result := 'CREATE TABLE ' + strTabela + '(';
  arrCampos := fRetEstruturaPgto(strTabela);

  For intCont := 0 to Length(arrCampos) - 1 do
    Result := Result + arrCampos[intCont].strDescri + ' ' + arrCampos[intCont].strTipCmp + ', ';

  Result := Result + ' PRIMARY KEY(SAF_TIPREG,SAF_CODEST,SAF_NUMNSU,SAF_DTATRA,SAF_TIPLAN,SAF_DTAPAG,SAF_NUMPAR,SAF_CODAUT)) ENGINE INNODB ' ;
end;

procedure TSafrapayPgto.pAdicionaLinha(strString: String);
  Const
    AUMENTO_CAPACIDADE_FREG  = 2000;

  function fGetDados(intIni, intTam: Integer; blnFlt: Boolean = False): Variant;
    Var
      rst: Variant;
  Begin
    rst := Trim(Copy(strString, intIni, intTam));
    If blnFlt Then rst := fStrToFloat(rst) / 100;

    Result := rst;
  End;

begin
  If intPosicaoAtual >= Length(FRegSafrapayPgto) - 1 Then
    SetLength(FRegSafrapayPgto, Length(FRegSafrapayPgto)+AUMENTO_CAPACIDADE_FREG);

  If Not Assigned(lstEstabel) Then
    lstEstabel := TStringList.Create;

  If fGetDados(001,02) = 'A0' Then
  Begin
    dtaArq    := fGetDados(009,08);
    strVerArq := fGetDados(003,06);
  End
  Else If MatchStr(fGetDados(001,02), ['CV', 'AJ']) Then
  Begin
    Inc(intPosicaoAtual);

    FRegSafrapayPgto[intPosicaoAtual-1].strTipReg := fGetDados(001,02);
    FRegSafrapayPgto[intPosicaoAtual-1].strCodEst := fGetDados(003,15);
    FRegSafrapayPgto[intPosicaoAtual-1].strNumNSU := fGetDados(018,12);
    FRegSafrapayPgto[intPosicaoAtual-1].strDtaTra := fGetDados(030,08);
    FRegSafrapayPgto[intPosicaoAtual-1].strVerArq := strVerArq;
    FRegSafrapayPgto[intPosicaoAtual-1].strDtaArq := dtaArq;
    FRegSafrapayPgto[intPosicaoAtual-1].strNomArq := strNomArq;

    If (fGetDados(001,02) = 'CV')  Then
    Begin
      FRegSafrapayPgto[intPosicaoAtual-1].strTipLan := fGetDados(044,01);
      FRegSafrapayPgto[intPosicaoAtual-1].strDtaPag := fGetDados(045,08);
      FRegSafrapayPgto[intPosicaoAtual-1].strTipPro := fGetDados(053,01);
      FRegSafrapayPgto[intPosicaoAtual-1].strTipCap := fGetDados(054,01);
      FRegSafrapayPgto[intPosicaoAtual-1].fltValBru := fGetDados(055,11,True);
      FRegSafrapayPgto[intPosicaoAtual-1].fltValDes := fGetDados(066,11,True);
      FRegSafrapayPgto[intPosicaoAtual-1].fltValLiq := fGetDados(077,11,True);
      FRegSafrapayPgto[intPosicaoAtual-1].strNumCar := fGetDados(088,19);
      FRegSafrapayPgto[intPosicaoAtual-1].strNumPar := fGetDados(107,02);
      FRegSafrapayPgto[intPosicaoAtual-1].strTotPar := fGetDados(109,02);
      If FRegSafrapayPgto[intPosicaoAtual-1].strTotPar <> '00' Then
      Begin
        FRegSafrapayPgto[intPosicaoAtual-1].fltBruPar := fGetDados(123,11,True);
        FRegSafrapayPgto[intPosicaoAtual-1].fltDesPar := fGetDados(134,11,True);
        FRegSafrapayPgto[intPosicaoAtual-1].fltLiqPar := fGetDados(145,11,True);
      End
      Else
      begin
        FRegSafrapayPgto[intPosicaoAtual-1].fltBruPar := FRegSafrapayPgto[intPosicaoAtual-1].fltValBru;
        FRegSafrapayPgto[intPosicaoAtual-1].fltDesPar := FRegSafrapayPgto[intPosicaoAtual-1].fltValDes;
        FRegSafrapayPgto[intPosicaoAtual-1].fltLiqPar := FRegSafrapayPgto[intPosicaoAtual-1].fltValLiq;
      End;
      FRegSafrapayPgto[intPosicaoAtual-1].strCodBco := fGetDados(156,03);
      FRegSafrapayPgto[intPosicaoAtual-1].strCodAge := fGetDados(159,06);
      FRegSafrapayPgto[intPosicaoAtual-1].strNumCco := fGetDados(165,11);
      FRegSafrapayPgto[intPosicaoAtual-1].strCodAut := fGetDados(182,06);
      FRegSafrapayPgto[intPosicaoAtual-1].strCodBan := fGetDados(188,04);
      FRegSafrapayPgto[intPosicaoAtual-1].strCodPro := fGetDados(192,03);
      FRegSafrapayPgto[intPosicaoAtual-1].strNumAnt := fGetDados(199,09);

      FRegSafrapayPgto[intPosicaoAtual-1].DataPrevisaoPagamento := fGetDados(315,08);

      If FRegSafrapayPgto[intPosicaoAtual-1].strCodBan = 'PIX' Then
      Begin
        FRegSafrapayPgto[intPosicaoAtual-1].strNumCar := 'PIX';
        FRegSafrapayPgto[intPosicaoAtual-1].strID_Pix := fGetDados(469, 25);
      End;
    End
    Else If (fGetDados(001,02) = 'AJ')  Then
    Begin
      FRegSafrapayPgto[intPosicaoAtual-1].strNumPar := fGetDados(038,02);

      FRegSafrapayPgto[intPosicaoAtual-1].strTotPar := fGetDados(375,02);
      If FRegSafrapayPgto[intPosicaoAtual-1].strTotPar = '' Then
        FRegSafrapayPgto[intPosicaoAtual-1].strTotPar := FRegSafrapayPgto[intPosicaoAtual-1].strNumPar;

      FRegSafrapayPgto[intPosicaoAtual-1].strNSUAju := fGetDados(040,12);
      FRegSafrapayPgto[intPosicaoAtual-1].strDtaPag := fGetDados(067,08);
      FRegSafrapayPgto[intPosicaoAtual-1].strTipLan := fGetDados(066,01);
      FRegSafrapayPgto[intPosicaoAtual-1].strTipCap := fGetDados(075,01);
      FRegSafrapayPgto[intPosicaoAtual-1].strTipAju := fGetDados(076,01);
      FRegSafrapayPgto[intPosicaoAtual-1].strCodAju := fGetDados(077,04);
      FRegSafrapayPgto[intPosicaoAtual-1].strDesAju := fGetDados(081,150);
      FRegSafrapayPgto[intPosicaoAtual-1].fltValBru := fGetDados(231,11,True);
      FRegSafrapayPgto[intPosicaoAtual-1].fltValDes := fGetDados(242,11,True);
      FRegSafrapayPgto[intPosicaoAtual-1].fltValLiq := fGetDados(253,11,True);
      FRegSafrapayPgto[intPosicaoAtual-1].fltBruPar := fGetDados(231,11,True);
      FRegSafrapayPgto[intPosicaoAtual-1].fltDesPar := fGetDados(242,11,True);
      FRegSafrapayPgto[intPosicaoAtual-1].fltLiqPar := fGetDados(253,11,True);
      FRegSafrapayPgto[intPosicaoAtual-1].strCodBco := fGetDados(264,03);
      FRegSafrapayPgto[intPosicaoAtual-1].strCodAge := fGetDados(267,06);
      FRegSafrapayPgto[intPosicaoAtual-1].strNumCco := fGetDados(273,11);
      FRegSafrapayPgto[intPosicaoAtual-1].strNumCar := fGetDados(284,19);
      FRegSafrapayPgto[intPosicaoAtual-1].strCodBan := fGetDados(303,04);
      FRegSafrapayPgto[intPosicaoAtual-1].strCodAut := fGetDados(339,06);
      FRegSafrapayPgto[intPosicaoAtual-1].strCodPro := fGetDados(307,03);
      FRegSafrapayPgto[intPosicaoAtual-1].strNumAnt := fGetDados(310,09);

      FRegSafrapayPgto[intPosicaoAtual-1].TaxaAntecipacao := fGetDados(414,5,True);

      FRegSafrapayPgto[intPosicaoAtual-1].DiasAntecipados := fGetDados(419,03);
      FRegSafrapayPgto[intPosicaoAtual-1].NumeroEC := fGetDados(422,09);
      FRegSafrapayPgto[intPosicaoAtual-1].NumeroRO := fGetDados(431,50);
    End;
  End;

  If (intPosicaoAtual > 0) And (FRegSafrapayPgto[intPosicaoAtual-1].strCodEst <> '') And
     (lstEstabel.IndexOf(FRegSafrapayPgto[intPosicaoAtual-1].strCodEst) < 0) Then
    lstEstabel.Add(FRegSafrapayPgto[intPosicaoAtual-1].strCodEst);
end;

procedure TSafrapayPgto.pGravarRegistros(pgbProg: TProgressBar);
  Var
    qryDados : IDataSet;
    intCont  : Integer;
    strSQL   : String;

    LValidaNovosCampos: IDataSet;

  function fRetVal(strVal: Variant; blnData: Boolean = False): Variant;
  Begin
    If fEmptyStr(strVal) Then Result := Null
    Else
    Begin
      If blnData Then
        Result := Copy(strVal, 1, 4) + '/' + Copy(strVal, 5, 2) + '/' + Copy(strVal, 7, 2)
      else
        Result := strVal;
    End;
  End;

begin
  strSQL := RetornaSQLReplace(NOMTAB,
                              RetornaListaDeCampos(fRetEstruturaPgto(NOMTAB)),
                              [INICAM + 'CONCIL']);

  qryDados := objFunctions.fGetDataSet;
  qryDados.Close;
  qryDados.SQL := strSQL;

  pgbProg.Position := 0;

  If Length(FRegSAfrapayPgto) > 0 Then
  Begin
    LValidaNovosCampos := objFunctions.fGetDataSet;
    LValidaNovosCampos.SQL := 'SELECT * FROM ' + NOMTAB + ' WHERE FALSE';
    LValidaNovosCampos.Open;

    pgbProg.Max      := Length(FRegSAfrapayPgto)-1;
    For intCont := 0 To Length(FRegSAfrapayPgto)-1 Do
    Begin
      If (FRegSAfrapayPgto[intCont].strTipReg <> '') Then
      Begin
        Application.ProcessMessages;

        qryDados.Close;

        qryDados.ParamByName(INICAM + 'TIPREG').AsString:= fRetVal(FRegSAfrapayPgto[intCont].strTipReg);
        qryDados.ParamByName(INICAM + 'CODEST').AsString:= fRetVal(FRegSAfrapayPgto[intCont].strCodEst);
        qryDados.ParamByName(INICAM + 'DTAPAG').AsString:= fRetVal(FRegSAfrapayPgto[intCont].strDtaPag, True);
        qryDados.ParamByName(INICAM + 'CODBCO').AsString:= fRetVal(FRegSAfrapayPgto[intCont].strCodBco);
        qryDados.ParamByName(INICAM + 'CODAGE').AsString:= fRetVal(FRegSAfrapayPgto[intCont].strCodAge);
        qryDados.ParamByName(INICAM + 'NUMCCO').AsString:= fRetVal(FRegSAfrapayPgto[intCont].strNumCco);
        qryDados.ParamByName(INICAM + 'VALBRU').Value   := fRetVal(FRegSAfrapayPgto[intCont].fltValBru);
        qryDados.ParamByName(INICAM + 'VALDES').Value   := fRetVal(FRegSAfrapayPgto[intCont].fltValDes);
        qryDados.ParamByName(INICAM + 'VALLIQ').Value   := fRetVal(FRegSAfrapayPgto[intCont].fltValLiq);
        qryDados.ParamByName(INICAM + 'BRUPAR').Value   := fRetVal(FRegSAfrapayPgto[intCont].fltBruPar);
        qryDados.ParamByName(INICAM + 'DESPAR').Value   := fRetVal(FRegSAfrapayPgto[intCont].fltDesPar);
        qryDados.ParamByName(INICAM + 'LIQPAR').Value   := fRetVal(FRegSAfrapayPgto[intCont].fltLiqPar);
        qryDados.ParamByName(INICAM + 'DTATRA').AsString:= fRetVal(FRegSAfrapayPgto[intCont].strDtaTra, True);
        qryDados.ParamByName(INICAM + 'CODAUT').AsString:= fRetVal(FRegSAfrapayPgto[intCont].strCodAut);
        qryDados.ParamByName(INICAM + 'NUMCAR').AsString:= fRetVal(FRegSAfrapayPgto[intCont].strNumCar);
        qryDados.ParamByName(INICAM + 'ID_PIX').Value   := fRetVal(FRegSAfrapayPgto[intCont].strID_Pix);

        If FRegSAfrapayPgto[intCont].strNumNSU <> '000000000000' Then
          qryDados.ParamByName(INICAM + 'NUMNSU').AsString:= fRetVal(FRegSAfrapayPgto[intCont].strNumNSU)
        Else
          qryDados.ParamByName(INICAM + 'NUMNSU').AsString:= fRetVal(FRegSAfrapayPgto[intCont].strNSUAju);

        qryDados.ParamByName(INICAM + 'TIPLAN').AsString:= fRetVal(FRegSAfrapayPgto[intCont].strTipLan);

        qryDados.ParamByName(INICAM + 'TIPPRO').Value := Null;
        If FRegSAfrapayPgto[intCont].strTipPro <> '' Then
          qryDados.ParamByName(INICAM + 'TIPPRO').AsString:= fRetVal(FRegSAfrapayPgto[intCont].strTipPro);

        qryDados.ParamByName(INICAM + 'TIPCAP').AsString:= fRetVal(FRegSAfrapayPgto[intCont].strTipCap);
        qryDados.ParamByName(INICAM + 'TOTPAR').AsString:= RightStr(fRetVal(FRegSAfrapayPgto[intCont].strTotPar), 2);
        qryDados.ParamByName(INICAM + 'NUMPAR').AsString:= RightStr(fRetVal(FRegSAfrapayPgto[intCont].strNumPar), 2);
        qryDados.ParamByName(INICAM + 'CODBAN').AsString:= fRetVal(FRegSAfrapayPgto[intCont].strCodBan);
        qryDados.ParamByName(INICAM + 'CODPRO').AsString:= fRetVal(FRegSAfrapayPgto[intCont].strCodPro);
        qryDados.ParamByName(INICAM + 'NUMANT').AsString:= fRetVal(FRegSAfrapayPgto[intCont].strNumAnt);

        qryDados.ParamByName(INICAM + 'NSUAJU').Value := Null;
        qryDados.ParamByName(INICAM + 'TIPAJU').Value := Null;
        qryDados.ParamByName(INICAM + 'CODAJU').Value := Null;
        qryDados.ParamByName(INICAM + 'DESAJU').Value := Null;
        If FRegSAfrapayPgto[intCont].strTipReg = 'AJ' Then
        Begin
          qryDados.ParamByName(INICAM + 'NSUAJU').AsString:= fRetVal(FRegSAfrapayPgto[intCont].strNSUAju);
          qryDados.ParamByName(INICAM + 'TIPAJU').AsString:= fRetVal(FRegSAfrapayPgto[intCont].strTipAju);
          qryDados.ParamByName(INICAM + 'CODAJU').AsString:= fRetVal(FRegSAfrapayPgto[intCont].strCodAju);
          qryDados.ParamByName(INICAM + 'DESAJU').AsString:= fRetVal(FRegSAfrapayPgto[intCont].strDesAju);
        End;

        If LValidaNovosCampos.FindField(INICAM + 'TAXANT') <> Nil Then
        Begin
          qryDados.ParamByName(INICAM + 'TAXANT').Value := fRetVal(FRegSAfrapayPgto[intCont].TaxaAntecipacao);
          qryDados.ParamByName(INICAM + 'DIAANT').Value:= fRetVal(FRegSAfrapayPgto[intCont].DiasAntecipados);
          qryDados.ParamByName(INICAM + 'NUM_EC').Value:= fRetVal(FRegSAfrapayPgto[intCont].NumeroEC);
          qryDados.ParamByName(INICAM + 'NUM_RO').Value:= fRetVal(FRegSAfrapayPgto[intCont].NumeroRO);

          qryDados.ParamByName(INICAM + 'DTAPRV').Value:= fRetVal(FRegSAfrapayPgto[intCont].DataPrevisaoPagamento, True);
        End;

        qryDados.ParamByName(INICAM + 'DTAARQ').AsString:= fRetVal(FRegSAfrapayPgto[intCont].strDtaArq, True);
        qryDados.ParamByName(INICAM + 'NOMARQ').AsString:= fRetVal(FRegSAfrapayPgto[intCont].strNomArq);
        qryDados.ParamByName(INICAM + 'VERARQ').AsString:= fRetVal(FRegSAfrapayPgto[intCont].strVerArq);

        qryDados.ExecSQL;
      End;

      pgbProg.Position := pgbProg.Position + 1;
    End;

    Try
      qryDados.Close;
      qryDados.SQL := 'REPLACE INTO ESTCAR (CAR_CODEST, CAR_NOMOPE) VALUES (:ESTAB, "SAFRAPAY")';
      For intCont := 0 To lstEstabel.Count - 1 Do
      Begin
        qryDados.ParamByName('ESTAB').AsString := lstEstabel[intCont];
        qryDados.ExecSQL;
      End;

      FreeAndNil(lstEstabel);
    Except
      Raise Exception.Create('A tabela ESTCAR não foi criada. Entre em contato com a Citel!');
    End;
  End;
end;

class function TSafrapayPgto.RetornaListaDeCampos(
  AObjetoCampos: TArrEstruturaSafrapayPgto): TStringList;
  Var
    LContador: Integer;
begin
  Result := TStringList.Create;

  For LContador := 0 To Length(AObjetoCampos) - 1 Do
    Result.Add(AObjetoCampos[LContador].strDescri);
end;

end.
