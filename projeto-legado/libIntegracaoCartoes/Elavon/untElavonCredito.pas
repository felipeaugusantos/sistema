{************************************}
{* Importação de arquivos da ELAVON *}
{*********************************AJ*}
unit untElavonCredito;

interface

uses Classes, StrUtils, SysUtils, Variants, untIIntegracaoCartoes, ComCtrls, Forms;

Type
// +---------------------------------------------------------------------------------+
// |                      CRITÉRIOS DE EDIÇÃO DOS DADOS                              |
// +---------------------------------------------------------------------------------+
// |  Tipo do registro               | “11” = Registro de Transações                 |
// +---------------------------------------------------------------------------------+
// |  Cod Estabelecimento            | Código do Estabelecimento junto a ELAVON      |
// +---------------------------------------------------------------------------------+
// |  Número do Terminal             | Número de Indentificação do Terminal          |
// +---------------------------------------------------------------------------------+
// |  Data da Transação              | Data que foi realizada a transação            |
// +---------------------------------------------------------------------------------+
// |  Hora da Transação              | Hora que foi realizada a transação            |
// +---------------------------------------------------------------------------------+
// |  Lote Autorizador               | Será preenchido para: Vendas A Vista e        |
// |                                 | Parceladas; Cancelamentos; Aceleração         |
// |                                 | Não será preenchido: Tarifas; Chargebacks;    |
// |                                 | Ajustes; Antecipações                         |
// +---------------------------------------------------------------------------------+
// |  Número do Cartão               | Núm. do cartão que foi utilizado na transação |
// +---------------------------------------------------------------------------------+
// |  Código da Autorização          | Código da autorização informado pelo emissor  |
// |                                 | para identificar a transação (Ajustes não tem)|
// +---------------------------------------------------------------------------------+
// |  NSU                            | NSU da transação. Para cancelamentos e        |
// |                                 | chargebacks é usada a NSU original            |
// +---------------------------------------------------------------------------------+
// |  Núm. da Parcela                | Número da parcela a ser paga. Será suprimido  |
// |                                 | em transações à vista                         |
// +---------------------------------------------------------------------------------+
// |  Total de Parcelas              | Total de parcelas. Será suprimido em          |
// |                                 | transações a vista                            |
// +---------------------------------------------------------------------------------+
// |  Sinal Valor Transação (Tot)    | Positivo ou Negativo. Cancelamento e Ajustes  |
// |                                 | será suprimido                                |
// +---------------------------------------------------------------------------------+
// |  Valor Total da Transação       | Valor Total de uma compra parcelada. Para     |
// |                                 | compras à vista, será preenchido com 0        |
// |                                 | Cancelamentos e Ajustes não será preenchido.  |
// +---------------------------------------------------------------------------------+
// |  Sinal Valor Transação (Bruto)  | Positivo ou Negativo. Cancelamento e Ajustes  |
// |                                 | será suprimido                                |
// +---------------------------------------------------------------------------------+
// |  Valor da Transação             | Valor Bruto da Transação                      |
// +---------------------------------------------------------------------------------+
// |  Sinal Valor Tx Desconto        | Positivo ou Negativo. Cancelamento e Ajustes  |
// |                                 | será suprimido                                |
// +---------------------------------------------------------------------------------+
// |  Valor Tx de Desconto           | Valor da taxa aplicada pela operação.         |
// |                                 | Não será preenchido para ajustes.             |
// +---------------------------------------------------------------------------------+
// |  Sinal Valor Transação (Liq)    | Positivo ou Negativo. Cancelamento e Ajustes  |
// |                                 | será suprimido                                |
// +---------------------------------------------------------------------------------+
// |  Valor Líquido da Transação     | Valor Bruto - Valor Taxas                     |
// +---------------------------------------------------------------------------------+
// |  Percentual Desconto            | Percentual sobre as vendas. Nos Ajustes       |
// |                                 | será suprimido                                |
// +---------------------------------------------------------------------------------+
// |  Tarifa                         | Valor Unitário taxado sobre as transações     |
// |                                 | quando aplicável                              |
// +---------------------------------------------------------------------------------+
  TRegistroCred = Record
    strNumReg: String;
    strCodEst: String;
    strNumTer: String;
    strDtaTra: String;
    strHorTra: String;
    strLoteAu: String;
    strNumCar: String;
    strCodAut: String;
    strNumNSU: String;
    strNumPar: String;
    strTotPar: String;
    strSinVTT: String;
    fltValVTT: Double;
    strSinVBT: String;
    fltValVBT: Double;
    strSinVTD: String;
    fltValVTD: Double;
    strSinVLT: String;
    fltValVLT: Double;
    fltPorDes: Double;
    fltTarifa: Double;
  End;

  TEstruturaCred = Record
    strDescri: String;
    strTipCmp: String;
  End;

  TArrRegistroElaCred  = Array Of TRegistroCred;

  TArrEstruturaElaCred  = Array Of TEstruturaCred;

  TElavonCredito = Class(TInterfacedObject, ICartoes)
  Private

  Public
    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(pgbProg: TProgressBar);

    class function fRetSQLTabelaRegCred(strTabela: String): String;
    class function fRetEstruturaCred(strTabela: String): TArrEstruturaElaCred;
  End;

implementation

uses untFuncoes, untIDataSet, untElavon;

{ TRedeCredito }

{**********************************************}
{* RETORNA A ESTRUTURA DA  TABELA  DE CRÉDITO *}
{* ELA_EVCRED                                 *}
{*******************************************AJ*}
class function TElavonCredito.fRetEstruturaCred(strTabela: String): TArrEstruturaElaCred;
Begin
  If strTabela = 'ELA_EVCRED' Then Begin
    SetLength(Result, 21);

    Result[0].strDescri  := 'ELA_NUMREG'; Result[0].strTipCmp  := 'CHAR(2)'      ;
    Result[1].strDescri  := 'ELA_CODEST'; Result[1].strTipCmp  := 'VARCHAR(16)'  ;
    Result[2].strDescri  := 'ELA_NUMTER'; Result[2].strTipCmp  := 'VARCHAR(22)'  ;
    Result[3].strDescri  := 'ELA_DTATRA'; Result[3].strTipCmp  := 'DATE'         ;
    Result[4].strDescri  := 'ELA_HORTRA'; Result[4].strTipCmp  := 'TIME'         ;
    Result[5].strDescri  := 'ELA_LOTEAU'; Result[5].strTipCmp  := 'VARCHAR(11)'  ;
    Result[6].strDescri  := 'ELA_NUMCAR'; Result[6].strTipCmp  := 'VARCHAR(11)'  ;
    Result[7].strDescri  := 'ELA_CODAUT'; Result[7].strTipCmp  := 'VARCHAR(6)'   ;
    Result[8].strDescri  := 'ELA_NUMNSU'; Result[8].strTipCmp  := 'VARCHAR(11)'  ;
    Result[9].strDescri  := 'ELA_NUMPAR'; Result[9].strTipCmp  := 'VARCHAR(2)'   ;
    Result[10].strDescri := 'ELA_TOTPAR'; Result[10].strTipCmp := 'VARCHAR(2)'   ;
    Result[11].strDescri := 'ELA_SINVTT'; Result[11].strTipCmp := 'VARCHAR(1)'   ;
    Result[12].strDescri := 'ELA_VALVTT'; Result[12].strTipCmp := 'DECIMAL(15,2)';
    Result[13].strDescri := 'ELA_SINVBT'; Result[13].strTipCmp := 'VARCHAR(1)'   ;
    Result[14].strDescri := 'ELA_VALVBT'; Result[14].strTipCmp := 'DECIMAL(15,2)';
    Result[15].strDescri := 'ELA_SINVTD'; Result[15].strTipCmp := 'VARCHAR(1)'   ;
    Result[16].strDescri := 'ELA_VALVTD'; Result[16].strTipCmp := 'DECIMAL(15,6)';
    Result[17].strDescri := 'ELA_SINVLT'; Result[17].strTipCmp := 'VARCHAR(1)'   ;
    Result[18].strDescri := 'ELA_VALVLT'; Result[18].strTipCmp := 'DECIMAL(15,6)';
    Result[19].strDescri := 'ELA_PORDES'; Result[19].strTipCmp := 'DECIMAL(9,6)' ;
    Result[20].strDescri := 'ELA_TARIFA'; Result[20].strTipCmp := 'DECIMAL(9,6)' ;
  End;
End;

class function TElavonCredito.fRetSQLTabelaRegCred(strTabela: String): String;
Var arrCampos: TArrEstruturaElaCred;
    intCont  : Integer;
begin
  Result := 'CREATE TABLE ' + strTabela + '(';
  arrCampos := fRetEstruturaCred(strTabela);

  For intCont := 0 to Length(arrCampos) - 1 do
    Result := Result + arrCampos[intCont].strDescri + ' ' + arrCampos[intCont].strTipCmp + ', ';

  Result := Result + 'PRIMARY KEY(ELA_CODEST,    ' +
                     'ELA_CODAUT,                ' +
                     'ELA_NUMNSU,                ' +
                     'ELA_NUMPAR,                ' +
                     'ELA_DTATRA)) ENGINE INNODB ';
end;

procedure TElavonCredito.pAdicionaLinha(strString: String);
Var
  lstCampos: TStringList;
  intPos   : Integer;

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

begin
  lstCampos := TStringList.Create;
  lstCampos.Delimiter     := '|';
  lstCampos.DelimitedText := strString;
  If lstCampos[0] = '11' Then
  Begin
    SetLength(FRegElaCred, Length(FRegElaCred) + 1);

    FRegElaCred[Length(FRegElaCred)-1].strNumReg := fGetDados(lstCampos[0]) ;
    FRegElaCred[Length(FRegElaCred)-1].strCodEst := fGetDados(lstCampos[1]) ;
    FRegElaCred[Length(FRegElaCred)-1].strNumTer := fGetDados(lstCampos[2]) ;
    FRegElaCred[Length(FRegElaCred)-1].strDtaTra := fGetDados(lstCampos[3]) ;
    FRegElaCred[Length(FRegElaCred)-1].strHorTra := fGetDados(lstCampos[4]) ;
    FRegElaCred[Length(FRegElaCred)-1].strLoteAu := fGetDados(lstCampos[5]) ;
    FRegElaCred[Length(FRegElaCred)-1].strNumCar := fGetDados(lstCampos[7]) ;
    FRegElaCred[Length(FRegElaCred)-1].strCodAut := fGetDados(lstCampos[8]) ;
    FRegElaCred[Length(FRegElaCred)-1].strNumNSU := fGetDados(lstCampos[9]) ;
    FRegElaCred[Length(FRegElaCred)-1].strNumPar := fGetDados(lstCampos[13]);
    FRegElaCred[Length(FRegElaCred)-1].strTotPar := fGetDados(lstCampos[14]);
    FRegElaCred[Length(FRegElaCred)-1].strSinVTT := fGetDados(lstCampos[15]);
    FRegElaCred[Length(FRegElaCred)-1].fltValVTT := fGetDados(lstCampos[16], True, 2);
    FRegElaCred[Length(FRegElaCred)-1].strSinVBT := fGetDados(lstCampos[17]);
    FRegElaCred[Length(FRegElaCred)-1].fltValVBT := fGetDados(lstCampos[18], True, 2);
    FRegElaCred[Length(FRegElaCred)-1].strSinVTD := fGetDados(lstCampos[19]);
    FRegElaCred[Length(FRegElaCred)-1].fltValVTD := fGetDados(lstCampos[20], True, 6);
    FRegElaCred[Length(FRegElaCred)-1].strSinVLT := fGetDados(lstCampos[21]);
    FRegElaCred[Length(FRegElaCred)-1].fltValVLT := fGetDados(lstCampos[22], True, 6);
    FRegElaCred[Length(FRegElaCred)-1].fltPorDes := fGetDados(lstCampos[22], True, 6);
    FRegElaCred[Length(FRegElaCred)-1].fltTarifa := fGetDados(lstCampos[22], True, 6);

    intPos := lstEstabel.IndexOf(fGetDados(lstCampos[1]));
    If (fGetDados(lstCampos[1]) <> '') And (intPos < 0) Then
      lstEstabel.Add(fGetDados(lstCampos[1]));
  End;
end;

procedure TElavonCredito.pGravarRegistros(pgbProg: TProgressBar);
  Var
    qryDados : IDataSet;
    intCont  : Integer;
    strSQL   : String;
    arrCampos: TArrEstruturaElaCred;

  function fRetVal(strVal: Variant; blnData: Boolean = False): Variant;
  Begin
    If fEmptyStr(strVal) Then Result := Null
    Else
    Begin
      If blnData Then
        Result := Copy(strVal, 5, 4) + '/' + Copy(strVal, 3, 2) + '/' + Copy(strVal, 1, 2)
      else
        Result := strVal;
    End;
  End;

begin
  strSQL :=          'REPLACE INTO ELA_EVCRED (';
  arrCampos := fRetEstruturaCred('ELA_EVCRED');
  For intCont := 0 to Length(arrCampos) - 1 do
    strSQL := strSQL + arrCampos[intCont].strDescri + ',';
  strSQL := Copy(strSQL, 1, Length(strSQL) - 1) + ') VALUES (';
  For intCont := 0 to Length(arrCampos) - 1 do
    strSQL := strSQL + ':' + arrCampos[intCont].strDescri + ',';
  strSQL := Copy(strSQL, 1, Length(strSQL) - 1) + ')';

  qryDados := objFunctions.fGetDataSet;
  qryDados.Close;
  qryDados.SQL := strSQL;

  pgbProg.Position := 0;

  If Length(FRegElaCred) > 0 Then
  Begin
    pgbProg.Max      := Length(FRegElaCred)-1;
    For intCont := 0 To Length(FRegElaCred)-1 Do
    Begin
      Application.ProcessMessages;
      qryDados.Close;

      qryDados.ParamByName('ELA_NUMREG').Value   := fRetVal(FRegElaCred[intCont].strNumReg);
      qryDados.ParamByName('ELA_CODEST').Value   := fRetVal(FRegElaCred[intCont].strCodEst);
      qryDados.ParamByName('ELA_NUMTER').Value   := fRetVal(FRegElaCred[intCont].strNumTer);
      qryDados.ParamByName('ELA_DTATRA').Value   := fRetVal(FRegElaCred[intCont].strDtaTra, True);
      qryDados.ParamByName('ELA_HORTRA').Value   := fRetVal(FRegElaCred[intCont].strHorTra);
      qryDados.ParamByName('ELA_LOTEAU').Value   := fRetVal(FRegElaCred[intCont].strLoteAu);
      qryDados.ParamByName('ELA_NUMCAR').Value   := fRetVal(FRegElaCred[intCont].strNumCar);
      qryDados.ParamByName('ELA_CODAUT').Value   := VarToStrDef(fRetVal(FRegElaCred[intCont].strCodAut), '0');
      qryDados.ParamByName('ELA_NUMNSU').Value   := VarToStrDef(fRetVal(FRegElaCred[intCont].strNumNSU), '0');
      qryDados.ParamByName('ELA_NUMPAR').Value   := VarToStrDef(fRetVal(FRegElaCred[intCont].strNumPar), '0');
      qryDados.ParamByName('ELA_TOTPAR').Value   := fRetVal(FRegElaCred[intCont].strTotPar);
      qryDados.ParamByName('ELA_SINVTT').Value   := fRetVal(FRegElaCred[intCont].strSinVTT);
      qryDados.ParamByName('ELA_VALVTT').Value   := fRetVal(FRegElaCred[intCont].fltValVTT);
      qryDados.ParamByName('ELA_SINVBT').Value   := fRetVal(FRegElaCred[intCont].strSinVBT);
      qryDados.ParamByName('ELA_VALVBT').Value   := fRetVal(FRegElaCred[intCont].fltValVBT);
      qryDados.ParamByName('ELA_SINVTD').Value   := fRetVal(FRegElaCred[intCont].strSinVTD);
      qryDados.ParamByName('ELA_VALVTD').Value   := fRetVal(FRegElaCred[intCont].fltValVTD);
      qryDados.ParamByName('ELA_SINVLT').Value   := fRetVal(FRegElaCred[intCont].strSinVLT);
      qryDados.ParamByName('ELA_VALVLT').Value   := fRetVal(FRegElaCred[intCont].fltValVLT);
      qryDados.ParamByName('ELA_PORDES').Value   := fRetVal(FRegElaCred[intCont].fltPorDes);
      qryDados.ParamByName('ELA_TARIFA').Value   := fRetVal(FRegElaCred[intCont].fltTarifa);

      qryDados.ExecSQL;


      pgbProg.Position := pgbProg.Position + 1;
    End;

  End;
end;

end.
