{************************************}
{* Importação de arquivos da EQUALS *}
{*********************************AJ*}
unit untEqualsPagto;

interface

uses Classes, StrUtils, SysUtils, Variants, untIIntegracaoCartoes, ComCtrls, Dialogs, Forms;

Type
// +---------------------------------------------------------------------------------+
// |                      CRITÉRIOS DE EDIÇÃO DOS DADOS                              |
// +---------------------------------------------------------------------------------+
// |  Tipo do registro               | “31” = Registro de Transações                 |
// +---------------------------------------------------------------------------------+
// |  Lote Único                     | Número do lote único na adquirinte            |
// +---------------------------------------------------------------------------------+
// |  Cod Estabelecimento            | Código do Estabelecimento junto a EQUALS      |
// +---------------------------------------------------------------------------------+
// |  Data da Venda                  | Data da Venda                                 |
// +---------------------------------------------------------------------------------+
// |  Código da Autorização          | Código da autorização informado pelo emissor  |
// |                                 | para identificar a transação (Ajustes não tem)|
// +---------------------------------------------------------------------------------+
// |  NSU                            | NSU da transação. Para cancelamentos e        |
// |                                 | chargebacks é usada a NSU original            |
// +---------------------------------------------------------------------------------+
// |  Número da TID                  | Número da TID                                 |
// +---------------------------------------------------------------------------------+
// |  Número da Terminal             | Número da Terminal                            |
// +---------------------------------------------------------------------------------+
// |  Tipo do Terminal               | Tipo do terminal usado                        |
// +---------------------------------------------------------------------------------+
// |  Número do Cartão               | Número do Cartão                              |
// +---------------------------------------------------------------------------------+
// |  Valor Bruto                    | Valor Bruto da Parcela                        |
// +---------------------------------------------------------------------------------+
// |  Valor da Taxa                  | Valor da Taxa da Parcela                      |
// +---------------------------------------------------------------------------------+
// |  Valor da Comissão              | Valor da Comissão da parcela                  |
// +---------------------------------------------------------------------------------+
// |  Valor Líquido                  | Valor Líquido da Parcela                      |
// +---------------------------------------------------------------------------------+
// |  Data do Pagamento              | Data do Pagamento                             |
// +---------------------------------------------------------------------------------+
// |  Núm. da Parcela                | Número da parcela a ser paga.                 |
// +---------------------------------------------------------------------------------+

  TRegistroPgto = Record
    strTipReg: String;
    strLotUni: String;
    strCodEst: String;
    strDtaVen: String;
    strCodAut: String;
    strNumNSU: String;
    strNumTid: String;
    strNumTer: String;
    strTipTer: String;
    strNumCar: String;
    fltValBru: Double;
    fltValTax: Double;
    fltValCom: Double;
    fltValLiq: Double;
    strDtaPag: String;
    strCodPar: String;
    strTotPar: String;
    strNomArq: String;
    strMotAju: String;
  End;

  TEstruturaPgto = Record
    strDescri: String;
    strTipCmp: String;
  End;

  TArrRegistroEquPgto  = Array Of TRegistroPgto;

  TArrEstruturaEquPgto  = Array Of TEstruturaPgto;

  TEqualsPagto = Class(TInterfacedObject, ICartoes)
  Private
    procedure AdicionaRegistroDeArquivoCSV(AString: String);

    function CorrigeValoresCSV(AValor: String): Double;
  Public
    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(pgbProg: TProgressBar);

    class function fRetSQLTabelaRegPgto(strTabela: String): String;
    class function fRetEstruturaPgto(strTabela: String): TArrEstruturaEquPgto;
  End;

Var
  strNomArq: String;
  blnPagamentoImportado: Boolean;
  blnArquivoCSV: Boolean;

implementation

uses untFuncoes, untIDataSet, untEquals;

{ TEqualsPgto }

procedure TEqualsPagto.AdicionaRegistroDeArquivoCSV(AString: String);
  Var
    LCampos: TStringList;

    LPosicaoEstabelecimento,
    LPosicaoRegistros      : Integer;
begin
  If Pos('NÚMERO SEQUENCIAL;FILIAÇÃO DO ESTABELECIMENTO;NOME ESTABELECIMENTO EQUALS', AString) > 0 Then
    Exit;

  LCampos := TStringList.Create;
  LCampos.StrictDelimiter := True;
  LCampos.Delimiter := ';';
  LCampos.DelimitedText := AString;

  Try
    SetLength(FRegEquPgto, Length(FRegEquPgto) + 1);

    LPosicaoRegistros := Length(FRegEquPgto)-1;

    FRegEquPgto[LPosicaoRegistros].strTipReg := Trim(LCampos[6]);
    FRegEquPgto[LPosicaoRegistros].strLotUni := Trim(LCampos[10]);
    FRegEquPgto[LPosicaoRegistros].strCodEst := Trim(LCampos[1]);
    FRegEquPgto[LPosicaoRegistros].strDtaVen := Trim(LCampos[23]);
    FRegEquPgto[LPosicaoRegistros].strCodAut := Trim(LCampos[25]);
    FRegEquPgto[LPosicaoRegistros].strNumNSU := Trim(LCampos[26]);
    FRegEquPgto[LPosicaoRegistros].strNumTid := Trim(LCampos[27]);
    FRegEquPgto[LPosicaoRegistros].strNumTer := Trim(LCampos[29]);
    FRegEquPgto[LPosicaoRegistros].strTipTer := '';
    FRegEquPgto[LPosicaoRegistros].strNumCar := Trim(LCampos[28]);

    FRegEquPgto[LPosicaoRegistros].fltValBru := CorrigeValoresCSV(LCampos[16]);
    FRegEquPgto[LPosicaoRegistros].fltValTax := 0.00;
    FRegEquPgto[LPosicaoRegistros].fltValCom := CorrigeValoresCSV(LCampos[17]);
    FRegEquPgto[LPosicaoRegistros].fltValLiq := CorrigeValoresCSV(LCampos[18]);
    If LCampos[15] = 'D' Then
    Begin
      FRegEquPgto[LPosicaoRegistros].fltValBru := FRegEquPgto[LPosicaoRegistros].fltValBru * (-1);
      FRegEquPgto[LPosicaoRegistros].fltValCom := FRegEquPgto[LPosicaoRegistros].fltValCom * (-1);
      FRegEquPgto[LPosicaoRegistros].fltValLiq := FRegEquPgto[LPosicaoRegistros].fltValLiq * (-1);
    End;

    FRegEquPgto[LPosicaoRegistros].strDtaPag := Trim(LCampos[8]);
    FRegEquPgto[LPosicaoRegistros].strCodPar := Trim(LCampos[11]);
    FRegEquPgto[LPosicaoRegistros].strTotPar := Trim(LCampos[30]);
    FRegEquPgto[LPosicaoRegistros].strMotAju := Trim(LCampos[7]);
    FRegEquPgto[LPosicaoRegistros].strNomArq := strNomArq;

    If FRegEquPgto[LPosicaoRegistros].strDtaVen = '' Then
      FRegEquPgto[LPosicaoRegistros].strDtaVen := FRegEquPgto[LPosicaoRegistros].strDtaPag;
    If FRegEquPgto[LPosicaoRegistros].strCodPar = '' Then
      FRegEquPgto[LPosicaoRegistros].strCodPar := '01';
    If FRegEquPgto[LPosicaoRegistros].strTotPar = '' Then
      FRegEquPgto[LPosicaoRegistros].strTotPar := '01';

    LPosicaoEstabelecimento := lstEstabel.IndexOf(Trim(LCampos[1]));
    If (Trim(LCampos[1])  <> '') And (LPosicaoEstabelecimento < 0) Then
      lstEstabel.Add(Trim(LCampos[1]));

    FreeAndNil(LCampos);
  Except
    On E: Exception DO
      Raise Exception.Create(E.Message);
  End;
end;


function TEqualsPagto.CorrigeValoresCSV(AValor: String): Double;
begin
  Result := 0;

  If AValor = '' Then
    Exit;

  Try
    Result := StrToFloat(AValor);
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;


{************************************************}
{* RETORNA A ESTRUTURA DA  TABELA  DE PAGAMENTO *}
{* EQU_EQPGTO                                   *}
{*********************************************AJ*}
class function TEqualsPagto.fRetEstruturaPgto(strTabela: String): TArrEstruturaEquPgto;
Begin
  If strTabela = 'EQU_EQPGTO' Then Begin
    SetLength(Result, 20);
    Result[0].strDescri  := 'EQU_TIPREG'; Result[0].strTipCmp  := 'CHAR(2)'      ;
    Result[1].strDescri  := 'EQU_LOTUNI'; Result[1].strTipCmp  := 'VARCHAR(30)'  ;
    Result[2].strDescri  := 'EQU_CODEST'; Result[2].strTipCmp  := 'VARCHAR(20)'  ;
    Result[3].strDescri  := 'EQU_DTAVEN'; Result[3].strTipCmp  := 'DATE'         ;
    Result[4].strDescri  := 'EQU_CODAUT'; Result[4].strTipCmp  := 'VARCHAR(20)'  ;
    Result[5].strDescri  := 'EQU_NUMNSU'; Result[5].strTipCmp  := 'VARCHAR(20)'  ;
    Result[6].strDescri  := 'EQU_NUMTID'; Result[6].strTipCmp  := 'VARCHAR(50)'  ;
    Result[7].strDescri  := 'EQU_NUMTER'; Result[7].strTipCmp  := 'VARCHAR(20)'  ;
    Result[8].strDescri  := 'EQU_TIPTER'; Result[8].strTipCmp  := 'VARCHAR(4)'   ;
    Result[9].strDescri  := 'EQU_VALBRU'; Result[9].strTipCmp  := 'DECIMAL(15,2)';
    Result[10].strDescri := 'EQU_VALTAX'; Result[10].strTipCmp := 'DECIMAL(15,2)';
    Result[11].strDescri := 'EQU_VALCOM'; Result[11].strTipCmp := 'DECIMAL(15,2)';
    Result[12].strDescri := 'EQU_VALLIQ'; Result[12].strTipCmp := 'DECIMAL(15,2)';
    Result[13].strDescri := 'EQU_NUMCAR'; Result[13].strTipCmp := 'VARCHAR(25)'  ;
    Result[14].strDescri := 'EQU_DTAPAG'; Result[14].strTipCmp := 'DATE'         ;
    Result[15].strDescri := 'EQU_CODPAR'; Result[15].strTipCmp := 'VARCHAR(2)'   ;
    Result[16].strDescri := 'EQU_TOTPAR'; Result[16].strTipCmp := 'VARCHAR(2)'   ;
    Result[17].strDescri := 'EQU_NOMARQ'; Result[17].strTipCmp := 'VARCHAR(255)' ;
    Result[18].strDescri := 'EQU_CONCIL'; Result[18].strTipCmp := 'VARCHAR(1) DEFAULT ''0''';
    Result[19].strDescri := 'EQU_MOTAJU'; Result[19].strTipCmp := 'VARCHAR(50)'  ;
  End;
End;

class function TEqualsPagto.fRetSQLTabelaRegPgto(strTabela: String): String;
Var arrCampos: TArrEstruturaEquPgto;
    intCont  : Integer;
begin
  Result := 'CREATE TABLE ' + strTabela + '(';
  arrCampos := fRetEstruturaPgto(strTabela);

  For intCont := 0 to Length(arrCampos) - 1 do
    Result := Result + arrCampos[intCont].strDescri + ' ' + arrCampos[intCont].strTipCmp + ', ';

  Result := Result + 'CONSTRAINT PK_EQU_EQPGTO PRIMARY KEY(EQU_CODEST,    ' +
                     'EQU_CODAUT, EQU_NUMNSU, EQU_CODPAR,   ' +
                     'EQU_DTAPAG, EQU_DTAVEN)) ENGINE INNODB' ;
end;

procedure TEqualsPagto.pAdicionaLinha(strString: String);
Var
  strValor : String;
  intPos   : Integer;
  blnTemAju: Boolean;

  function fGetDados(strValor: String; blnFlt: Boolean = False; intCasas: Integer = 0): Variant;
    Var
      rst     : Variant;
      i       : Integer;
      strZeros: String;
  Begin
    rst := strValor;
    If blnFlt Then
    Begin
      strZeros := '';
      For i := 1 to intCasas do
        strZeros := strZeros + '0';

      rst := fStrToFloat(rst) / StrtoFloat('1' + strZeros);
    End;

    Result := rst;
  End;

  function fRetiraZerosEsquerda(strDado: String): String;
  Begin
    While (Length(strDado) > 0) And (strDado[1] = '0') Do
      Delete(strDado, 1, 1);

    Result := strDado;
  End;

begin
  If blnArquivoCSV then
  Begin
    AdicionaRegistroDeArquivoCSV(strString);
    Exit;
  End;

  strValor := Copy(strString, 1, 2);
  If (strValor = '31') Or (strValor = '42') Then
  Begin
    SetLength(FRegEquPgto, Length(FRegEquPgto) + 1);

    FRegEquPgto[Length(FRegEquPgto)-1].strTipReg := Trim(fGetDados(strValor));
    FRegEquPgto[Length(FRegEquPgto)-1].strLotUni := Trim(fGetDados(Copy(strString, 28, 30)));
    FRegEquPgto[Length(FRegEquPgto)-1].strCodEst := Trim(fRetiraZerosEsquerda(fGetDados(Copy(strString, 69, 20))));
    FRegEquPgto[Length(FRegEquPgto)-1].strDtaVen := Trim(fGetDados(Copy(strString, 96, 8)));
    FRegEquPgto[Length(FRegEquPgto)-1].strCodAut := Trim(fGetDados(Copy(strString, 110, 20)));
    FRegEquPgto[Length(FRegEquPgto)-1].strNumNSU := Trim(fGetDados(Copy(strString, 130, 20)));
    FRegEquPgto[Length(FRegEquPgto)-1].strNumTid := Trim(fGetDados(Copy(strString, 150, 50)));
    FRegEquPgto[Length(FRegEquPgto)-1].strNumTer := Trim(fGetDados(Copy(strString, 200, 20)));
    FRegEquPgto[Length(FRegEquPgto)-1].strTipTer := Trim(fGetDados(Copy(strString, 220, 4)));
    FRegEquPgto[Length(FRegEquPgto)-1].strNumCar := Trim(fGetDados(Copy(strString, 224, 25)));

    FRegEquPgto[Length(FRegEquPgto)-1].fltValBru := fGetDados(Copy(strString, 343, 15), True, 2);
    FRegEquPgto[Length(FRegEquPgto)-1].fltValTax := fGetDados(Copy(strString, 266, 15), True, 2);
    FRegEquPgto[Length(FRegEquPgto)-1].fltValCom := fGetDados(Copy(strString, 358, 15), True, 2);
    FRegEquPgto[Length(FRegEquPgto)-1].fltValLiq := fGetDados(Copy(strString, 373, 15), True, 2);
    If fGetDados(Copy(strString, 251, 15), True, 2) <> 0 Then
      FRegEquPgto[Length(FRegEquPgto)-1].fltValBru := fGetDados(Copy(strString, 251, 15), True, 2);

    FRegEquPgto[Length(FRegEquPgto)-1].strDtaPag := Trim(fGetDados(Copy(strString, 311, 8)));
    FRegEquPgto[Length(FRegEquPgto)-1].strCodPar := Trim(fGetDados(Copy(strString, 319, 2)));
    FRegEquPgto[Length(FRegEquPgto)-1].strTotPar := Trim(fGetDados(Copy(strString, 249, 2)));
    FRegEquPgto[Length(FRegEquPgto)-1].strNomArq := strNomArq;

    intPos := lstEstabel.IndexOf(fRetiraZerosEsquerda(fGetDados(Copy(strString, 69, 20))));
    If (fGetDados(Copy(strString, 69, 20))  <> '') And (intPos < 0) Then
      lstEstabel.Add(fRetiraZerosEsquerda(fGetDados(Copy(strString, 69, 20))));
  End
  Else If (strValor = '50') Then
  Begin
    blnTemAju := False;
    For intPos := 0 To Length(FRegEquAjus) - 1 Do
    Begin
      blnTemAju := (FRegEquAjus[intPos].strTipReg = Trim(fGetDados(strValor))) And
                   (FRegEquAjus[intPos].strCodEst = Trim(fRetiraZerosEsquerda(fGetDados(Copy(strString, 69, 20))))) And
                   (FRegEquAjus[intPos].strDtaPag = Trim(fGetDados(Copy(strString, 58, 8)))) And
                   (FRegEquAjus[intPos].strMotAju = Trim(fGetDados(Copy(strString, 158, 50)))) And
                   (Trim(fGetDados(Copy(strString, 158, 50))) <> ' Cancelamento');
      If blnTemAju Then Break;
    End;

    If not blnTemAju Then
    Begin
      SetLength(FRegEquAjus, Length(FRegEquAjus) + 1);
      FRegEquAjus[Length(FRegEquAjus)-1].strTipReg := Trim(fGetDados(strValor));
      FRegEquAjus[Length(FRegEquAjus)-1].strCodEst := Trim(fRetiraZerosEsquerda(fGetDados(Copy(strString, 69, 20))));
      FRegEquAjus[Length(FRegEquAjus)-1].strDtaPag := Trim(fGetDados(Copy(strString, 58, 8)));
      FRegEquAjus[Length(FRegEquAjus)-1].strLotUni := Trim(fGetDados(Copy(strString, 28, 30)));
      FRegEquAjus[Length(FRegEquAjus)-1].strDtaVen := Trim(fGetDados(Copy(strString, 58, 8)));
      FRegEquAjus[Length(FRegEquAjus)-1].strCodAut := Trim(fGetDados(Copy(strString, 459, 20)));
      If fEmptyStr(FRegEquAjus[Length(FRegEquAjus)-1].strCodAut) Then
        FRegEquAjus[Length(FRegEquAjus)-1].strCodAut := InttoStr(Length(Trim(fGetDados(Copy(strString, 158, 50)))));
      FRegEquAjus[Length(FRegEquAjus)-1].strNumNSU := Trim(fGetDados(Copy(strString, 479, 20)));
      FRegEquAjus[Length(FRegEquAjus)-1].strNumTid := Trim(fGetDados(Copy(strString, 499, 50)));
      FRegEquAjus[Length(FRegEquAjus)-1].strNumTer := '';
      FRegEquAjus[Length(FRegEquAjus)-1].strTipTer := '';
      FRegEquAjus[Length(FRegEquAjus)-1].strNumCar := Trim(fGetDados(Copy(strString, 553, 25)));
      If Trim(fGetDados(Copy(strString, 232, 01))) = 'C' Then
      Begin
        FRegEquAjus[Length(FRegEquAjus)-1].fltValBru := fGetDados(Copy(strString, 233, 15), True, 2);
        FRegEquAjus[Length(FRegEquAjus)-1].fltValTax := fGetDados(Copy(strString, 248, 15), True, 2);
        FRegEquAjus[Length(FRegEquAjus)-1].fltValCom := 0.00;
        FRegEquAjus[Length(FRegEquAjus)-1].fltValLiq := fGetDados(Copy(strString, 263, 15), True, 2);
      End
      Else
      Begin
        FRegEquAjus[Length(FRegEquAjus)-1].fltValBru := fGetDados(Copy(strString, 233, 15), True, 2) * (-1);
        FRegEquAjus[Length(FRegEquAjus)-1].fltValTax := fGetDados(Copy(strString, 248, 15), True, 2) * (-1);
        FRegEquAjus[Length(FRegEquAjus)-1].fltValCom := 0.00;
        FRegEquAjus[Length(FRegEquAjus)-1].fltValLiq := fGetDados(Copy(strString, 263, 15), True, 2) * (-1);
      End;
      FRegEquAjus[Length(FRegEquAjus)-1].strCodPar := Trim(fGetDados(Copy(strString, 228, 2)));;
      FRegEquAjus[Length(FRegEquAjus)-1].strTotPar := Trim(fGetDados(Copy(strString, 230, 2)));;
      FRegEquAjus[Length(FRegEquAjus)-1].strNomArq := strNomArq;
      FRegEquAjus[Length(FRegEquAjus)-1].strMotAju := Trim(fGetDados(Copy(strString, 158, 50)));
    End
    Else
    Begin
      If Trim(fGetDados(Copy(strString, 232, 01))) = 'C' Then
      Begin
        FRegEquAjus[intPos].fltValBru := FRegEquAjus[intPos].fltValBru + fGetDados(Copy(strString, 233, 15), True, 2);
        FRegEquAjus[intPos].fltValTax := FRegEquAjus[intPos].fltValTax + fGetDados(Copy(strString, 248, 15), True, 2);
        FRegEquAjus[intPos].fltValLiq := FRegEquAjus[intPos].fltValLiq + fGetDados(Copy(strString, 263, 15), True, 2);
      End
      Else
      Begin
        FRegEquAjus[intPos].fltValBru := FRegEquAjus[intPos].fltValBru + fGetDados(Copy(strString, 233, 15), True, 2) * (-1);
        FRegEquAjus[intPos].fltValTax := FRegEquAjus[intPos].fltValTax + fGetDados(Copy(strString, 248, 15), True, 2) * (-1);
        FRegEquAjus[intPos].fltValLiq := FRegEquAjus[intPos].fltValLiq + fGetDados(Copy(strString, 263, 15), True, 2) * (-1);
      End;
    End;
  End;
end;

procedure TEqualsPagto.pGravarRegistros(pgbProg: TProgressBar);
  Var
    qryDados : IDataSet;
    intCont  : Integer;
    strSQL   : String;
    arrCampos: TArrEstruturaEquPgto;

  function fRetVal(strVal: Variant; blnData: Boolean = False; blnGraNul: Boolean = True): Variant;
  Begin
    If (fEmptyStr(strVal)) And (blnGraNul) Then
      Result := Null
    Else
    Begin
      If blnData Then
        Result := Copy(strVal, 1, 4) + '/' + Copy(strVal, 5, 2) + '/' + Copy(strVal, 7, 2)
      else
        Result := strVal;
    End;
  End;

begin
  strSQL :=          'REPLACE INTO EQU_EQPGTO (';
  arrCampos := fRetEstruturaPgto('EQU_EQPGTO');
  For intCont := 0 to Length(arrCampos) - 1 do
    If (arrCampos[intCont].strDescri <> 'EQU_CONCIL') Then
      strSQL := strSQL + arrCampos[intCont].strDescri + ',';
  strSQL := Copy(strSQL, 1, Length(strSQL) - 1) + ') VALUES (';
  For intCont := 0 to Length(arrCampos) - 1 do
    If (arrCampos[intCont].strDescri <> 'EQU_CONCIL') Then
      strSQL := strSQL + ':' + arrCampos[intCont].strDescri + ',';
  strSQL := Copy(strSQL, 1, Length(strSQL) - 1) + ')';

  qryDados := objFunctions.fGetDataSet;
  qryDados.Close;
  qryDados.SQL := strSQL;

  pgbProg.Position := 0;

  blnPagamentoImportado := False;
  If (Length(FRegEquPgto) > 0) Or (Length(FRegEquAjus) > 0) Then
  Begin
    pgbProg.Max      := (Length(FRegEquPgto)-1) + (Length(FRegEquAjus)-1);
    For intCont := 0 To Length(FRegEquPgto)-1 Do
    Begin
      If (FRegEquPgto[intCont].strTipReg <> '') Then
      Begin
        Application.ProcessMessages;
        qryDados.Close;

        If fRetVal(FRegEquPgto[intCont].strTipReg) <> '00' Then
          blnPagamentoImportado := True;

        qryDados.ParamByName('EQU_TIPREG').Value   := fRetVal(FRegEquPgto[intCont].strTipReg);
        qryDados.ParamByName('EQU_LOTUNI').Value   := fRetVal(FRegEquPgto[intCont].strLotUni);
        qryDados.ParamByName('EQU_CODEST').Value   := fRetVal(FRegEquPgto[intCont].strCodEst);
        qryDados.ParamByName('EQU_DTAVEN').Value   := fRetVal(FRegEquPgto[intCont].strDtaVen, True);
        qryDados.ParamByName('EQU_CODAUT').Value   := VarToStrDef(fRetVal(FRegEquPgto[intCont].strCodAut), '0');
        qryDados.ParamByName('EQU_NUMNSU').Value   := VarToStrDef(fRetVal(FRegEquPgto[intCont].strNumNSU), '0');
        qryDados.ParamByName('EQU_NUMTID').Value   := fRetVal(FRegEquPgto[intCont].strNumTid);
        qryDados.ParamByName('EQU_NUMTER').Value   := fRetVal(FRegEquPgto[intCont].strNumTer);
        qryDados.ParamByName('EQU_TIPTER').Value   := fRetVal(FRegEquPgto[intCont].strTipTer);
        qryDados.ParamByName('EQU_NUMCAR').Value   := VarToStrDef(fRetVal(FRegEquPgto[intCont].strNumCar), '0');
        qryDados.ParamByName('EQU_VALBRU').Value   := fRetVal(FRegEquPgto[intCont].fltValBru);
        qryDados.ParamByName('EQU_VALTAX').Value   := fRetVal(FRegEquPgto[intCont].fltValTax);
        qryDados.ParamByName('EQU_VALCOM').Value   := fRetVal(FRegEquPgto[intCont].fltValCom);
        qryDados.ParamByName('EQU_VALLIQ').Value   := fRetVal(FRegEquPgto[intCont].fltValLiq);
        qryDados.ParamByName('EQU_DTAPAG').Value   := fRetVal(FRegEquPgto[intCont].strDtaPag);
        qryDados.ParamByName('EQU_CODPAR').Value   := fRetVal(FRegEquPgto[intCont].strCodPar);
        qryDados.ParamByName('EQU_TOTPAR').Value   := fRetVal(FRegEquPgto[intCont].strTotPar);
        qryDados.ParamByName('EQU_NOMARQ').Value   := fRetVal(FRegEquPgto[intCont].strNomArq);
        qryDados.ParamByName('EQU_MOTAJU').Value   := fRetVal(FRegEquPgto[intCont].strMotAju);

        qryDados.ExecSQL;
      End;

      pgbProg.Position := pgbProg.Position + 1;
    End;

    For intCont := 0 To Length(FRegEquAjus)-1 Do
    Begin
      If (FRegEquPgto[intCont].strTipReg <> '') Then
      Begin
        Application.ProcessMessages;
        qryDados.Close;

        qryDados.ParamByName('EQU_TIPREG').Value   := fRetVal(FRegEquAjus[intCont].strTipReg);
        qryDados.ParamByName('EQU_LOTUNI').Value   := fRetVal(FRegEquAjus[intCont].strLotUni);
        qryDados.ParamByName('EQU_CODEST').Value   := fRetVal(FRegEquAjus[intCont].strCodEst);
        qryDados.ParamByName('EQU_DTAVEN').Value   := fRetVal(FRegEquAjus[intCont].strDtaVen, True);
        qryDados.ParamByName('EQU_CODAUT').Value   := VarToStrDef(fRetVal(FRegEquAjus[intCont].strCodAut, False, False), '0');
        qryDados.ParamByName('EQU_NUMNSU').Value   := VarToStrDef(fRetVal(FRegEquAjus[intCont].strNumNSU, False, False), '0');
        qryDados.ParamByName('EQU_NUMTID').Value   := fRetVal(FRegEquAjus[intCont].strNumTid, False, False);
        qryDados.ParamByName('EQU_NUMTER').Value   := fRetVal(FRegEquAjus[intCont].strNumTer);
        qryDados.ParamByName('EQU_TIPTER').Value   := fRetVal(FRegEquAjus[intCont].strTipTer);
        qryDados.ParamByName('EQU_NUMCAR').Value   := VarToStrDef(fRetVal(FRegEquAjus[intCont].strNumCar, False, False), '0');
        qryDados.ParamByName('EQU_VALBRU').Value   := fRetVal(FRegEquAjus[intCont].fltValBru);
        qryDados.ParamByName('EQU_VALTAX').Value   := fRetVal(FRegEquAjus[intCont].fltValTax);
        qryDados.ParamByName('EQU_VALCOM').Value   := fRetVal(FRegEquAjus[intCont].fltValCom);
        qryDados.ParamByName('EQU_VALLIQ').Value   := fRetVal(FRegEquAjus[intCont].fltValLiq);
        qryDados.ParamByName('EQU_DTAPAG').Value   := fRetVal(FRegEquAjus[intCont].strDtaPag);
        qryDados.ParamByName('EQU_CODPAR').Value   := fRetVal(FRegEquAjus[intCont].strCodPar);
        qryDados.ParamByName('EQU_TOTPAR').Value   := fRetVal(FRegEquAjus[intCont].strTotPar);
        qryDados.ParamByName('EQU_NOMARQ').Value   := fRetVal(FRegEquAjus[intCont].strNomArq);
        qryDados.ParamByName('EQU_MOTAJU').Value   := fRetVal(FRegEquAjus[intCont].strMotAju);

        qryDados.ExecSQL;
      End;

      pgbProg.Position := pgbProg.Position + 1;
    End;

    Try
      qryDados.Close;
      qryDados.SQL := 'REPLACE INTO ESTCAR (CAR_CODEST, CAR_NOMOPE) VALUES (:ESTAB, "EQUALS")';
      For intCont := 0 To lstEstabel.Count - 1 Do
      Begin
        qryDados.ParamByName('ESTAB').AsString := lstEstabel[intCont];
        qryDados.ExecSQL;
      End;
    Except
      Raise Exception.Create('A tabela ESTCAR não foi criada. Entre em contato com a Citel!');
    End;
  End;
end;

end.
