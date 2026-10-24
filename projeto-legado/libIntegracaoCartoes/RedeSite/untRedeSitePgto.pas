{*******************************************}
{* Importação de arquivos da REDECARD SITE *}
{****************************************AJ*}
unit untRedeSitePgto;

interface

uses Classes, StrUtils, SysUtils, Variants, untIIntegracaoCartoes, ComCtrls, Dialogs, Forms,
     Math;

Type

  TRegistroPgto = Record
    strTipReg: String;
    strCodEst: String;
    strNumLot: String;
    strDtaPag: String;
    strCodBco: String;
    strCodAge: String;
    strNumCco: String;
    strTipCar: String;
    strNomBan: String;
    strNumCar: String;
    strDtaTra: String;
    strNumPar: String;
    strTotPar: String;
    strCodAut: String;
    strNumNSU: String;
    fltValBru: Double;
    fltValLiq: Double;
    strNumTer: String;
    strCodAju: String;
    strNumTid: String;
    strDesAju: String;
    strTipAju: String;
    strDtaArq: String;
    strNomArq: String;
  End;

  TEstruturaPgto = Record
    strDescri: String;
    strTipCmp: String;
  End;

  TArrRegistroRedeSitePgto  = Array Of TRegistroPgto;

  TArrEstruturaRedeSitePgto  = Array Of TEstruturaPgto;

  TRedeSitePgto = Class(TInterfacedObject, ICartoes)
  Private
    dtaArq: String;

    intPosicaoAtual: Integer;
  Public
    constructor Create;

    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(pgbProg: TProgressBar);

    class function fRetSQLTabelaRegPgto(strTabela: String): String;
    class function fRetEstruturaPgto(strTabela: String): TArrEstruturaRedeSitePgto;
  End;

Var
  strNomArq,
  strCodBco,
  strCodAge,
  strNumCco,
  strTipReg: String;
Const
  NOMTAB = 'RED_SITPGTO';
  INICAM = 'RED_';

implementation

uses untFuncoes, untIDataSet, untRedeSite;

{ TRedeSitePgto }

constructor TRedeSitePgto.Create;
Begin
  intPosicaoAtual := 0;
End;

{************************************************}
{* RETORNA A ESTRUTURA DA  TABELA  DE PAGAMENTO *}
{* RED_SITPGTO                                  *}
{*********************************************AJ*}
class function TRedeSitePgto.fRetEstruturaPgto(strTabela: String): TArrEstruturaRedeSitePgto;
Begin
  If strTabela = NOMTAB Then Begin
    SetLength(Result, 25);

    Result[0].strDescri  := INICAM + 'CODEST'; Result[0].strTipCmp  := 'VARCHAR(20)'  ;
    Result[1].strDescri  := INICAM + 'TIPREG'; Result[1].strTipCmp  := 'VARCHAR(2)'   ;
    Result[2].strDescri  := INICAM + 'NUMLOT'; Result[2].strTipCmp  := 'VARCHAR(20)'  ;
    Result[3].strDescri  := INICAM + 'TIPCAR'; Result[3].strTipCmp  := 'VARCHAR(1)'   ;
    Result[4].strDescri  := INICAM + 'DTATRA'; Result[4].strTipCmp  := 'DATE'         ;
    Result[5].strDescri  := INICAM + 'CODBCO'; Result[5].strTipCmp  := 'VARCHAR(3)'   ;
    Result[6].strDescri  := INICAM + 'CODAGE'; Result[6].strTipCmp  := 'VARCHAR(6)'   ;
    Result[7].strDescri  := INICAM + 'NUMCCO'; Result[7].strTipCmp  := 'VARCHAR(15)'  ;
    Result[8].strDescri  := INICAM + 'DTAPAG'; Result[8].strTipCmp  := 'DATE'         ;
    Result[9].strDescri  := INICAM + 'NOMBAN'; Result[9].strTipCmp  := 'VARCHAR(30)'  ;
    Result[10].strDescri := INICAM + 'NUMNSU'; Result[10].strTipCmp := 'VARCHAR(12)'  ;
    Result[11].strDescri := INICAM + 'VALLIQ'; Result[11].strTipCmp := 'DECIMAL(15,2)';
    Result[12].strDescri := INICAM + 'VALBRU'; Result[12].strTipCmp := 'DECIMAL(15,2)';
    Result[13].strDescri := INICAM + 'NUMCAR'; Result[13].strTipCmp := 'VARCHAR(20)'  ;
    Result[14].strDescri := INICAM + 'NUMTER'; Result[14].strTipCmp := 'VARCHAR(10)'  ;
    Result[15].strDescri := INICAM + 'CODAUT'; Result[15].strTipCmp := 'VARCHAR(10)'  ;
    Result[16].strDescri := INICAM + 'NUMPAR'; Result[16].strTipCmp := 'VARCHAR(2)'   ;
    Result[17].strDescri := INICAM + 'CODTID'; Result[17].strTipCmp := 'VARCHAR(40)'  ;
    Result[18].strDescri := INICAM + 'TOTPAR'; Result[18].strTipCmp := 'VARCHAR(2)'   ;
    Result[19].strDescri := INICAM + 'CODAJU'; Result[19].strTipCmp := 'VARCHAR(3)'   ;
    Result[20].strDescri := INICAM + 'DESAJU'; Result[20].strTipCmp := 'VARCHAR(30)'  ;
    Result[21].strDescri := INICAM + 'TIPAJU'; Result[21].strTipCmp := 'VARCHAR(3)'   ;
    Result[22].strDescri := INICAM + 'DTAARQ'; Result[22].strTipCmp := 'DATE'         ;
    Result[23].strDescri := INICAM + 'NOMARQ'; Result[23].strTipCmp := 'VARCHAR(255)' ;
    Result[24].strDescri := INICAM + 'CONCIL'; Result[24].strTipCmp := 'INT DEFAULT 0';
  End;
End;

class function TRedeSitePgto.fRetSQLTabelaRegPgto(strTabela: String): String;
Var arrCampos: TArrEstruturaRedeSitePgto;
    intCont  : Integer;
begin
  Result := 'CREATE TABLE ' + strTabela + '(';
  arrCampos := fRetEstruturaPgto(strTabela);

  For intCont := 0 to Length(arrCampos) - 1 do
    Result := Result + arrCampos[intCont].strDescri + ' ' + arrCampos[intCont].strTipCmp + ', ';

  Result := Result + ' PRIMARY KEY(RED_TIPREG,RED_CODAUT,RED_NUMNSU,RED_DTATRA,RED_NUMPAR,RED_CODEST,RED_DTAPAG)) ENGINE INNODB ' ;
end;

procedure TRedeSitePgto.pAdicionaLinha(strString: String);
Var
  lstCampos: TStringList;

  function fGetDados(strValor: String; blnFlt: Boolean = False; intCasas: Integer = 0): Variant;
    Var
      rst     : Variant;
  Begin
    Try
      rst := Trim(strValor);
      If blnFlt Then
      Begin
        If rst = '' Then
          rst := 0;
        rst := fStrToFloat(StringReplace(rst, '.', ',', []));
      End;
      Result := rst;
    Except
      On E: Exception Do
        Raise Exception.Create('Ocorreu um erro ao converter os dados importados. Erro gerado: ' + E.Message);
    End;
  End;

begin
  Try
    lstCampos := TStringList.Create;
    lstCampos.Delimiter     := ';';
    lstCampos.DelimitedText := StringReplace(strString, ' ', '_', [rfReplaceAll]);

    If Not Assigned(lstEstabel) Then
      lstEstabel := TStringList.Create;

    If (StrtoInt(lstCampos[0]) In [4, 5]) Then
      SetLength(FRegRedeSitePgto, Length(FRegRedeSitePgto) + 1);

    If lstCampos[0] = '01' Then
      dtaArq    := lstCampos[1]
    Else If (StrtoInt(lstCampos[0]) In [3, 4, 5]) Then
    Begin
      If (StrtoInt(lstCampos[0]) In [3]) Then
      Begin
        strCodBco := fGetDados(lstCampos[6]);
        strCodAge := fGetDados(lstCampos[7]);
        strNumCco := fGetDados(lstCampos[8]);
        strTipReg := fGetDados(lstCampos[10]);
      End
      Else If (StrtoInt(lstCampos[0]) In [4]) Then
      Begin
        FRegRedeSitePgto[Length(FRegRedeSitePgto)-1].strTipReg := strTipReg; //01 - Pagamento futuro 02 - pago 03 - Antecipação
        FRegRedeSitePgto[Length(FRegRedeSitePgto)-1].strCodEst := fGetDados(lstCampos[2]);
        FRegRedeSitePgto[Length(FRegRedeSitePgto)-1].strNumLot := fGetDados(lstCampos[3]);
        FRegRedeSitePgto[Length(FRegRedeSitePgto)-1].strDtaPag := fGetDados(lstCampos[4]);
        FRegRedeSitePgto[Length(FRegRedeSitePgto)-1].strDtaTra := fGetDados(lstCampos[5]);
        If LeftStr(fGetDados(lstCampos[6]), 1) = 'D' Then
          FRegRedeSitePgto[Length(FRegRedeSitePgto)-1].strTipCar := 'D'
        Else
          FRegRedeSitePgto[Length(FRegRedeSitePgto)-1].strTipCar := 'C';
        FRegRedeSitePgto[Length(FRegRedeSitePgto)-1].fltValBru := fGetDados(lstCampos[7] + lstCampos[8], True);
        FRegRedeSitePgto[Length(FRegRedeSitePgto)-1].strNumPar := fGetDados(lstCampos[9]);
        FRegRedeSitePgto[Length(FRegRedeSitePgto)-1].strTotPar := fGetDados(lstCampos[10]);
        FRegRedeSitePgto[Length(FRegRedeSitePgto)-1].strNumCar := fGetDados(lstCampos[11]);
        FRegRedeSitePgto[Length(FRegRedeSitePgto)-1].strNumNSU := fGetDados(lstCampos[12]);
        FRegRedeSitePgto[Length(FRegRedeSitePgto)-1].strCodAut := fGetDados(lstCampos[13]);
        FRegRedeSitePgto[Length(FRegRedeSitePgto)-1].strNumTid := fGetDados(lstCampos[14]);
        FRegRedeSitePgto[Length(FRegRedeSitePgto)-1].fltValLiq := fGetDados(lstCampos[16] + lstCampos[17], True);
        FRegRedeSitePgto[Length(FRegRedeSitePgto)-1].strCodBco := strCodBco;
        FRegRedeSitePgto[Length(FRegRedeSitePgto)-1].strCodAge := strCodAge;
        FRegRedeSitePgto[Length(FRegRedeSitePgto)-1].strNumCco := strNumCco;
        FRegRedeSitePgto[Length(FRegRedeSitePgto)-1].strDtaArq := dtaArq;
        FRegRedeSitePgto[Length(FRegRedeSitePgto)-1].strNomArq := strNomArq;
      End
      Else If (StrtoInt(lstCampos[0]) In [5]) Then
      Begin
        FRegRedeSitePgto[Length(FRegRedeSitePgto)-1].strTipReg := '05'; //Ajustes
        FRegRedeSitePgto[Length(FRegRedeSitePgto)-1].strCodEst := fGetDados(lstCampos[2]);
        FRegRedeSitePgto[Length(FRegRedeSitePgto)-1].strCodBco := fGetDados(lstCampos[3]);
        FRegRedeSitePgto[Length(FRegRedeSitePgto)-1].strCodAge := fGetDados(lstCampos[4]);
        FRegRedeSitePgto[Length(FRegRedeSitePgto)-1].strNumCco := fGetDados(lstCampos[5]);
        FRegRedeSitePgto[Length(FRegRedeSitePgto)-1].strDtaPag := fGetDados(lstCampos[6]);
        FRegRedeSitePgto[Length(FRegRedeSitePgto)-1].strCodAju := fGetDados(lstCampos[7]);
        FRegRedeSitePgto[Length(FRegRedeSitePgto)-1].strDesAju := fGetDados(lstCampos[8]);
        FRegRedeSitePgto[Length(FRegRedeSitePgto)-1].strTipAju := fGetDados(lstCampos[9]);
        FRegRedeSitePgto[Length(FRegRedeSitePgto)-1].fltValLiq := fGetDados(lstCampos[10] + lstCampos[11], True);
        FRegRedeSitePgto[Length(FRegRedeSitePgto)-1].strNumLot := fGetDados(lstCampos[12]);
        FRegRedeSitePgto[Length(FRegRedeSitePgto)-1].strDtaTra := fGetDados(lstCampos[13]);
        If FRegRedeSitePgto[Length(FRegRedeSitePgto)-1].strDtaTra = '' Then
          FRegRedeSitePgto[Length(FRegRedeSitePgto)-1].strDtaTra := FRegRedeSitePgto[Length(FRegRedeSitePgto)-1].strDtaPag;
        FRegRedeSitePgto[Length(FRegRedeSitePgto)-1].fltValBru := fGetDados(lstCampos[15] + lstCampos[16], True);
        If fGetDados(lstCampos[15] + lstCampos[16], True) = 0 Then
          FRegRedeSitePgto[Length(FRegRedeSitePgto)-1].fltValBru := FRegRedeSitePgto[Length(FRegRedeSitePgto)-1].fltValLiq;
        FRegRedeSitePgto[Length(FRegRedeSitePgto)-1].strNumPar := fGetDados(lstCampos[17]);
        If fGetDados(lstCampos[17]) = '' Then
          FRegRedeSitePgto[Length(FRegRedeSitePgto)-1].strNumPar := '01';
        FRegRedeSitePgto[Length(FRegRedeSitePgto)-1].strTotPar := fGetDados(lstCampos[18]);
        If fGetDados(lstCampos[18]) = '' Then
          FRegRedeSitePgto[Length(FRegRedeSitePgto)-1].strTotPar := '01';
        FRegRedeSitePgto[Length(FRegRedeSitePgto)-1].strNumCar := fGetDados(lstCampos[19]);
        FRegRedeSitePgto[Length(FRegRedeSitePgto)-1].strNumNSU := fGetDados(lstCampos[20]);
        If fGetDados(lstCampos[20]) = '' Then
          FRegRedeSitePgto[Length(FRegRedeSitePgto)-1].strNumNSU := '-';
        FRegRedeSitePgto[Length(FRegRedeSitePgto)-1].strCodAut := fGetDados(lstCampos[21]);
        If fGetDados(lstCampos[21]) = '' Then
          FRegRedeSitePgto[Length(FRegRedeSitePgto)-1].strCodAut := '-';
        FRegRedeSitePgto[Length(FRegRedeSitePgto)-1].strDtaArq := dtaArq;
        FRegRedeSitePgto[Length(FRegRedeSitePgto)-1].strNomArq := strNomArq;
      End;

      If (lstCampos[0] <> '03') And (FRegRedeSitePgto[Length(FRegRedeSitePgto)-1].strCodEst <> '') And
         (lstEstabel.IndexOf(FRegRedeSitePgto[Length(FRegRedeSitePgto)-1].strCodEst) < 0) Then
        lstEstabel.Add(FRegRedeSitePgto[Length(FRegRedeSitePgto)-1].strCodEst);
    End;
  Except
    On E: Exception Do
        Raise Exception.Create('Ocorreu um erro ao importar os dados. Verifique o arquivo. Erro gerado: ' + E.Message);
  End;
end;

procedure TRedeSitePgto.pGravarRegistros(pgbProg: TProgressBar);
  Var
    qryDados : IDataSet;
    intCont  : Integer;
    strSQL   : String;
    arrCampos: TArrEstruturaRedeSitePgto;

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
  strSQL    := 'REPLACE INTO ' + NOMTAB + ' (';
  arrCampos := fRetEstruturaPgto(NOMTAB);
  For intCont := 0 to Length(arrCampos) - 1 do
    If (arrCampos[intCont].strDescri <> INICAM + 'CONCIL') Then
      strSQL := strSQL + arrCampos[intCont].strDescri + ',';
  strSQL := Copy(strSQL, 1, Length(strSQL) - 1) + ') VALUES (';
  For intCont := 0 to Length(arrCampos) - 1 do
    If (arrCampos[intCont].strDescri <> INICAM + 'CONCIL') Then
      strSQL := strSQL + ':' + arrCampos[intCont].strDescri + ',';
  strSQL := Copy(strSQL, 1, Length(strSQL) - 1) + ')';

  qryDados := objFunctions.fGetDataSet;
  qryDados.Close;
  qryDados.SQL := strSQL;

  pgbProg.Position := 0;

  Try
    If Length(FRegRedeSitePgto) > 0 Then
    Begin
      pgbProg.Max      := Length(FRegRedeSitePgto)-1;
      For intCont := 0 To Length(FRegRedeSitePgto)-1 Do
      Begin
        Application.ProcessMessages;
        If FRegRedeSitePgto[intCont].strTipReg <> '' Then
        Begin
          With qryDados Do
          Begin
            Close;
            ParamByName(INICAM + 'TIPREG').Value   := fRetVal(FRegRedeSitePgto[intCont].strTipReg);
            ParamByName(INICAM + 'CODEST').Value   := fRetVal(FRegRedeSitePgto[intCont].strCodEst);
            ParamByName(INICAM + 'DTAPAG').Value   := fRetVal(FRegRedeSitePgto[intCont].strDtaPag, True);
            ParamByName(INICAM + 'CODBCO').Value   := fRetVal(FRegRedeSitePgto[intCont].strCodBco);
            ParamByName(INICAM + 'CODAGE').Value   := fRetVal(FRegRedeSitePgto[intCont].strCodAge);
            ParamByName(INICAM + 'NUMCCO').Value   := fRetVal(FRegRedeSitePgto[intCont].strNumCco);
            ParamByName(INICAM + 'VALBRU').Value   := fRetVal(FRegRedeSitePgto[intCont].fltValBru);
            ParamByName(INICAM + 'VALLIQ').Value   := fRetVal(FRegRedeSitePgto[intCont].fltValLIQ);
            ParamByName(INICAM + 'CODTID').Value   := fRetVal(FRegRedeSitePgto[intCont].strNumTid);
            ParamByName(INICAM + 'NUMLOT').Value   := fRetVal(FRegRedeSitePgto[intCont].strNumLot);
            ParamByName(INICAM + 'TIPCAR').Value   := fRetVal(FRegRedeSitePgto[intCont].strTipCar);
            ParamByName(INICAM + 'TOTPAR').Value   := RightStr(fRetVal(FRegRedeSitePgto[intCont].strTotPar), 2);
            ParamByName(INICAM + 'NUMPAR').Value   := RightStr(fRetVal(FRegRedeSitePgto[intCont].strNumPar), 2);
            ParamByName(INICAM + 'DTATRA').Value   := fRetVal(FRegRedeSitePgto[intCont].strDtaTra, True);
            ParamByName(INICAM + 'CODAUT').Value   := fRetVal(FRegRedeSitePgto[intCont].strCodAut);
            ParamByName(INICAM + 'NUMCAR').Value   := fRetVal(FRegRedeSitePgto[intCont].strNumCar);
            ParamByName(INICAM + 'NUMNSU').Value   := fRetVal(FRegRedeSitePgto[intCont].strNumNSU);
            ParamByName(INICAM + 'CODAJU').Value   := fRetVal(FRegRedeSitePgto[intCont].strCodAju);
            ParamByName(INICAM + 'DESAJU').Value   := fRetVal(FRegRedeSitePgto[intCont].strDesAju);
            ParamByName(INICAM + 'TIPAJU').Value   := fRetVal(FRegRedeSitePgto[intCont].strTipAju);

            ParamByName(INICAM + 'NOMARQ').Value   := fRetVal(FRegRedeSitePgto[intCont].strNomArq);
            ParamByName(INICAM + 'DTAARQ').Value   := fRetVal(FRegRedeSitePgto[intCont].strDtaArq, True);
            ExecSQL;
          End;
        End;

        pgbProg.Position := pgbProg.Position + 1;
      End;

      Try
        qryDados.Close;
        qryDados.SQL := 'REPLACE INTO ESTCAR (CAR_CODEST, CAR_NOMOPE) VALUES (:ESTAB, "REDECARD (SITE)")';
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
  Except
    On E: Exception Do
        Raise Exception.Create('Ocorreu um erro ao gravar os dados importados. Erro gerado: ' + E.Message);
  End;
end;

end.
