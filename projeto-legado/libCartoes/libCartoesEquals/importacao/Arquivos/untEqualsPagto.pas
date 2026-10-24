{************************************}
{* Importação de arquivos da EQUALS *}
{*********************************AJ*}
unit untEqualsPagto;

interface

uses Classes, StrUtils, SysUtils, Variants, ComCtrls,
     Dialogs, Forms, System.Generics.Collections,

     cxProgressBar, Uni,

     untIEqualsIntegracaoLibCartoes, untTEqualsFuncoes, untEqualsTipos;


Type
  TEqualsPagto = Class(TInterfacedObject, ICartoes)
  Private
    procedure AdicionaRegistroDeArquivoCSV(AString: String);

    function CorrigeValoresCSV(AValor: String): Double;
    function fGetDados(strValor: String; blnFlt: Boolean = False; intCasas: Integer = 0): Variant;
    function fRetiraZerosEsquerda(strDado: String): String;
  Public
    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(pgbProg: TcxProgressBar);

    class function fRetSQLTabelaRegPgto(strTabela: String): String;
    class function fRetEstruturaPgto(strTabela: String): TArrEstruturaEquPgto;
    class function fRetVal(strVal: Variant; blnData: Boolean = False; blnGraNul: Boolean = True): Variant;
  End;

Var
  strNomArq: String;
  blnPagamentoImportado: Boolean;
  blnArquivoCSV: Boolean;

  FRegEquPgto   : TArrRegistroEquPgto;
  FRegEquAjus   : TArrRegistroEquPgto;

implementation

{ TEqualsPgto }

procedure TEqualsPagto.AdicionaRegistroDeArquivoCSV(AString: String);
  Var
    LCampos: TStringList;
    LPosicaoRegistros      : Integer;
begin
  If Pos('NÚMERO SEQUENCIAL;FILIAÇÃO DO ESTABELECIMENTO;NOME ESTABELECIMENTO EQUALS', AString) > 0 Then
    Exit;

  LCampos := Nil;
  Try
    LCampos := TStringList.Create;
    LCampos.StrictDelimiter := True;
    LCampos.Delimiter := ';';
    LCampos.DelimitedText := AString;

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

    If (VS_ListaEstabelecimentos.IndexOf(Trim(LCampos[1])) < 0) Then
      VS_ListaEstabelecimentos.Add(Trim(LCampos[1]));
  Finally
    If Assigned(LCampos) Then
      FreeAndNil(LCampos);
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

class function TEqualsPagto.fRetVal(strVal: Variant; blnData,
  blnGraNul: Boolean): Variant;
begin
 If (TEqualsFuncoes.fEmptyStr(strVal)) And (blnGraNul) Then
      Result := Null
    Else
    Begin
      If blnData Then
        Result := Copy(strVal, 1, 4) + '/' + Copy(strVal, 5, 2) + '/' + Copy(strVal, 7, 2)
      else
        Result := strVal;
    End;
end;

function TEqualsPagto.fGetDados(strValor: String; blnFlt: Boolean;
  intCasas: Integer): Variant;
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

    rst := TEqualsFuncoes.fStrToFloat(rst) / StrtoFloat('1' + strZeros);
  End;

  Result := rst;
end;

function TEqualsPagto.fRetiraZerosEsquerda(strDado: String): String;
begin
 While (Length(strDado) > 0) And (strDado[1] = '0') Do
    Delete(strDado, 1, 1);

  Result := strDado;
end;

procedure TEqualsPagto.pAdicionaLinha(strString: String);
Var
  strValor : String;
  intPos   : Integer;
  blnTemAju: Boolean;
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

    intPos := VS_ListaEstabelecimentos.IndexOf(fRetiraZerosEsquerda(fGetDados(Copy(strString, 69, 20))));
    If (fGetDados(Copy(strString, 69, 20))  <> '') And (intPos < 0) Then
      VS_ListaEstabelecimentos.Add(fRetiraZerosEsquerda(fGetDados(Copy(strString, 69, 20))));
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
      If TEqualsFuncoes.fEmptyStr(FRegEquAjus[Length(FRegEquAjus)-1].strCodAut) Then
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
      FRegEquAjus[Length(FRegEquAjus)-1].strCodPar := Trim(fGetDados(Copy(strString, 228, 2)));
      FRegEquAjus[Length(FRegEquAjus)-1].strTotPar := Trim(fGetDados(Copy(strString, 230, 2)));
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

procedure TEqualsPagto.pGravarRegistros(pgbProg: TcxProgressBar);
Var
  LRegistros : TUniQuery;
  intCont  : Integer;
begin
  LRegistros := Nil;
  Try
    LRegistros := VS_FuncoesExternas.fICriaQuery;
    LRegistros.SQL.Text := TEqualsFuncoes.RetornaSQLReplace('EQU_EQPGTO',['EQU_CONCIL']);

    pgbProg.Position := 0;

    blnPagamentoImportado := False;
    If (Length(FRegEquPgto) + Length(FRegEquAjus)) > 0 Then
    Begin
      pgbProg.Properties.Max  := Length(FRegEquPgto) + Length(FRegEquAjus);
      For intCont := 0 To Length(FRegEquPgto)-1 Do
      Begin
        If (FRegEquPgto[intCont].strTipReg <> '') Then
        Begin
          LRegistros.Close;

          If fRetVal(FRegEquPgto[intCont].strTipReg) <> '00' Then
            blnPagamentoImportado := True;

          TEqualsFuncoes.CarregaParametroDataset(LRegistros,'EQU_TIPREG', fRetVal(FRegEquPgto[intCont].strTipReg));
          TEqualsFuncoes.CarregaParametroDataset(LRegistros,'EQU_LOTUNI', fRetVal(FRegEquPgto[intCont].strLotUni));
          TEqualsFuncoes.CarregaParametroDataset(LRegistros,'EQU_CODEST', fRetVal(FRegEquPgto[intCont].strCodEst));
          TEqualsFuncoes.CarregaParametroDataset(LRegistros,'EQU_DTAVEN', fRetVal(FRegEquPgto[intCont].strDtaVen, True));
          TEqualsFuncoes.CarregaParametroDataset(LRegistros,'EQU_CODAUT', VarToStrDef(fRetVal(FRegEquPgto[intCont].strCodAut), '0'));
          TEqualsFuncoes.CarregaParametroDataset(LRegistros,'EQU_NUMNSU', VarToStrDef(fRetVal(FRegEquPgto[intCont].strNumNSU), '0'));
          TEqualsFuncoes.CarregaParametroDataset(LRegistros,'EQU_NUMTID', fRetVal(FRegEquPgto[intCont].strNumTid));
          TEqualsFuncoes.CarregaParametroDataset(LRegistros,'EQU_NUMTER', fRetVal(FRegEquPgto[intCont].strNumTer));
          TEqualsFuncoes.CarregaParametroDataset(LRegistros,'EQU_TIPTER', fRetVal(FRegEquPgto[intCont].strTipTer));
          TEqualsFuncoes.CarregaParametroDataset(LRegistros,'EQU_NUMCAR', VarToStrDef(fRetVal(FRegEquPgto[intCont].strNumCar), '0'));
          TEqualsFuncoes.CarregaParametroDataset(LRegistros,'EQU_VALBRU', fRetVal(FRegEquPgto[intCont].fltValBru));
          TEqualsFuncoes.CarregaParametroDataset(LRegistros,'EQU_VALTAX', fRetVal(FRegEquPgto[intCont].fltValTax));
          TEqualsFuncoes.CarregaParametroDataset(LRegistros,'EQU_VALCOM', fRetVal(FRegEquPgto[intCont].fltValCom));
          TEqualsFuncoes.CarregaParametroDataset(LRegistros,'EQU_VALLIQ', fRetVal(FRegEquPgto[intCont].fltValLiq));
          TEqualsFuncoes.CarregaParametroDataset(LRegistros,'EQU_DTAPAG', fRetVal(FRegEquPgto[intCont].strDtaPag));
          TEqualsFuncoes.CarregaParametroDataset(LRegistros,'EQU_CODPAR', fRetVal(FRegEquPgto[intCont].strCodPar));
          TEqualsFuncoes.CarregaParametroDataset(LRegistros,'EQU_TOTPAR', fRetVal(FRegEquPgto[intCont].strTotPar));
          TEqualsFuncoes.CarregaParametroDataset(LRegistros,'EQU_NOMARQ', fRetVal(FRegEquPgto[intCont].strNomArq));
          TEqualsFuncoes.CarregaParametroDataset(LRegistros,'EQU_MOTAJU', fRetVal(FRegEquPgto[intCont].strMotAju));

          LRegistros.ExecSQL;
        End;

        TEqualsFuncoes.pStepStatusGravacao(pgbProg);
      End;

      For intCont := 0 To Length(FRegEquAjus)-1 Do
      Begin
        If (FRegEquPgto[intCont].strTipReg <> '') Then
        Begin
          LRegistros.Close;

          TEqualsFuncoes.CarregaParametroDataset(LRegistros,'EQU_TIPREG', fRetVal(FRegEquAjus[intCont].strTipReg));
          TEqualsFuncoes.CarregaParametroDataset(LRegistros,'EQU_LOTUNI', fRetVal(FRegEquAjus[intCont].strLotUni));
          TEqualsFuncoes.CarregaParametroDataset(LRegistros,'EQU_CODEST', fRetVal(FRegEquAjus[intCont].strCodEst));
          TEqualsFuncoes.CarregaParametroDataset(LRegistros,'EQU_DTAVEN', fRetVal(FRegEquAjus[intCont].strDtaVen, True));
          TEqualsFuncoes.CarregaParametroDataset(LRegistros,'EQU_CODAUT', VarToStrDef(fRetVal(FRegEquAjus[intCont].strCodAut, False, False), '0'));
          TEqualsFuncoes.CarregaParametroDataset(LRegistros,'EQU_NUMNSU', VarToStrDef(fRetVal(FRegEquAjus[intCont].strNumNSU, False, False), '0'));
          TEqualsFuncoes.CarregaParametroDataset(LRegistros,'EQU_NUMTID', fRetVal(FRegEquAjus[intCont].strNumTid, False, False));
          TEqualsFuncoes.CarregaParametroDataset(LRegistros,'EQU_NUMTER', fRetVal(FRegEquAjus[intCont].strNumTer));
          TEqualsFuncoes.CarregaParametroDataset(LRegistros,'EQU_TIPTER', fRetVal(FRegEquAjus[intCont].strTipTer));
          TEqualsFuncoes.CarregaParametroDataset(LRegistros,'EQU_NUMCAR', VarToStrDef(fRetVal(FRegEquAjus[intCont].strNumCar, False, False), '0'));
          TEqualsFuncoes.CarregaParametroDataset(LRegistros,'EQU_VALBRU', fRetVal(FRegEquAjus[intCont].fltValBru));
          TEqualsFuncoes.CarregaParametroDataset(LRegistros,'EQU_VALTAX', fRetVal(FRegEquAjus[intCont].fltValTax));
          TEqualsFuncoes.CarregaParametroDataset(LRegistros,'EQU_VALCOM', fRetVal(FRegEquAjus[intCont].fltValCom));
          TEqualsFuncoes.CarregaParametroDataset(LRegistros,'EQU_VALLIQ', fRetVal(FRegEquAjus[intCont].fltValLiq));
          TEqualsFuncoes.CarregaParametroDataset(LRegistros,'EQU_DTAPAG', fRetVal(FRegEquAjus[intCont].strDtaPag));
          TEqualsFuncoes.CarregaParametroDataset(LRegistros,'EQU_CODPAR', fRetVal(FRegEquAjus[intCont].strCodPar));
          TEqualsFuncoes.CarregaParametroDataset(LRegistros,'EQU_TOTPAR', fRetVal(FRegEquAjus[intCont].strTotPar));
          TEqualsFuncoes.CarregaParametroDataset(LRegistros,'EQU_NOMARQ', fRetVal(FRegEquAjus[intCont].strNomArq));
          TEqualsFuncoes.CarregaParametroDataset(LRegistros,'EQU_MOTAJU', fRetVal(FRegEquAjus[intCont].strMotAju));

          LRegistros.ExecSQL;
        End;

        TEqualsFuncoes.pStepStatusGravacao(pgbProg);
      End;

       TEqualsFuncoes.GravarEstabelecimentos;
    End;
  Finally
    TEqualsFuncoes.FreeAndNilDatasets(LRegistros);
  End;
end;

end.
