{*************************************}
{* Importação de arquivos do WALMART *}
{**********************************AJ*}
unit untWalmartPgto;

interface

uses Classes, StrUtils, SysUtils, Variants, untIIntegracaoCartoes, ComCtrls, Dialogs, Forms;

Type
  TRegistroPgto = Record
    strTipReg: String;
    strCodEst: String;
    strCodAut: String;
    strDtaTra: String;
    strDtaPag: String;
    fltValBru: Double;
    fltValFre: Double;
    fltValCom: Double;
    fltValLiq: Double;
    strNomArq: String;
    strDtaArq: String;
    strStatus: String;
  End;

  TEstruturaPgto = Record
    strDescri: String;
    strTipCmp: String;
  End;

  TArrRegistroWalmartPgto  = Array Of TRegistroPgto;

  TArrEstruturaWalmartPgto = Array Of TEstruturaPgto;

  TWalmartPgto = Class(TInterfacedObject, ICartoes)
  Private
    strRegAnt: String;
  Public
    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(pgbProg: TProgressBar);

    class function fRetSQLTabelaRegPgto(strTabela: String): String;
    class function fRetEstruturaPgto(strTabela: String): TArrEstruturaWalmartPgto;
  End;

Var
  strDtaArq,
  strNomArq: String;

Const
  NOMTAB = 'WAL_WAPGTO';
  INICAM = 'WAL_';

implementation

uses untFuncoes, untIDataSet, untWalmart;

{ TWalmartPgto }

{**********************************************}
{* RETORNA A ESTRUTURA DA  TABELA  DE CRÉDITO *}
{* WAL_WAPGTO                                 *}
{*******************************************AJ*}
class function TWalmartPgto.fRetEstruturaPgto(strTabela: String): TArrEstruturaWalmartPgto;
Begin
  If strTabela = NOMTAB Then
  Begin
    SetLength(Result, 17);

    Result[0].strDescri  := INICAM + 'TIPREG'; Result[0].strTipCmp  := 'VARCHAR(7)'   ;
    Result[1].strDescri  := INICAM + 'CODEST'; Result[1].strTipCmp  := 'VARCHAR(25)  ';
    Result[2].strDescri  := INICAM + 'DTAPAG'; Result[2].strTipCmp  := 'DATE'         ;
    Result[3].strDescri  := INICAM + 'DTATRA'; Result[3].strTipCmp  := 'DATE'         ;
    Result[4].strDescri  := INICAM + 'CODAUT'; Result[4].strTipCmp  := 'VARCHAR(20)'  ;
    Result[5].strDescri  := INICAM + 'VALBRU'; Result[5].strTipCmp  := 'DECIMAL(15,2)';
    Result[6].strDescri  := INICAM + 'VALFRE'; Result[6].strTipCmp  := 'DECIMAL(15,2)';
    Result[7].strDescri  := INICAM + 'VALCOM'; Result[7].strTipCmp  := 'DECIMAL(15,2)';
    Result[8].strDescri  := INICAM + 'VALLIQ'; Result[8].strTipCmp  := 'DECIMAL(15,2)';
    Result[9].strDescri  := INICAM + 'NOMARQ'; Result[9].strTipCmp  := 'VARCHAR(255)' ;
    Result[10].strDescri := INICAM + 'DTAARQ'; Result[10].strTipCmp := 'DATE'         ;
    Result[11].strDescri := INICAM + 'CONCIL'; Result[11].strTipCmp := 'INT DEFAULT 0';
    Result[12].strDescri := INICAM + 'STATUS'; Result[12].strTipCmp := 'VARCHAR(3)'   ;
    Result[13].strDescri := INICAM + 'NUMPAR'; Result[13].strTipCmp := 'VARCHAR(2) DEFAULT "01"';
    Result[14].strDescri := INICAM + 'TOTPAR'; Result[14].strTipCmp := 'VARCHAR(2) DEFAULT "01"';
    Result[15].strDescri := INICAM + 'NUMCAR'; Result[15].strTipCmp := 'VARCHAR(19)'  ;
    Result[16].strDescri := INICAM + 'PAGDIF'; Result[16].strTipCmp := 'DATE'         ;
  End;
End;

class function TWalmartPgto.fRetSQLTabelaRegPgto(strTabela: String): String;
Var arrCampos: TArrEstruturaWalmartPgto;
    intCont  : Integer;
begin
  Result := 'CREATE TABLE ' + strTabela + '(';
  arrCampos := fRetEstruturaPgto(strTabela);

  For intCont := 0 to Length(arrCampos) - 1 do
    Result := Result + arrCampos[intCont].strDescri + ' ' + arrCampos[intCont].strTipCmp + ', ';

  Result := Result + ' PRIMARY KEY(WAL_TIPREG,WAL_CODEST,WAL_DTATRA,WAL_DTAPAG,WAL_CODAUT,WAL_NUMPAR)) ENGINE INNODB ' ;
end;

procedure TWalmartPgto.pAdicionaLinha(strString: String);
Var
  lstCampos: TStringList;

  function fGetDados(strValor: String; blnFlt: Boolean = False; intCasas: Integer = 0): Variant;
    Var
      rst     : Variant;
      i       : Integer;
      strZeros: String;
  Begin
    If strValor <> '' Then
      rst := strValor
    Else
      rst := '';

    If blnFlt Then
    Begin
      strZeros := '';
      For i := 1 to intCasas do
        strZeros := strZeros + '0';

      rst := StringReplace(rst, '.', ',', []);
      rst := fStrToFloat(rst) / StrtoFloat('1' + strZeros);
    End;

    Result := rst;
  End;
begin
  lstCampos := TStringList.Create;
  lstCampos.Delimiter     := ',';
  lstCampos.DelimitedText := StringReplace(strString, ' ', EmptyStr, [rfReplaceAll]);

  If (Pos('Pedido,PedidoEntrega,Movimento,Status', strString) <= 0) Then
  Begin
    If (strRegAnt <> fGetDados(lstCampos[0])) Then
    Begin
      SetLength(FRegWalmartPgto, Length(FRegWalmartPgto) + 1);
      FRegWalmartPgto[Length(FRegWalmartPgto) - 1].strTipReg := fGetDados(lstCampos[2]);
      FRegWalmartPgto[Length(FRegWalmartPgto) - 1].strCodEst := '0';
      FRegWalmartPgto[Length(FRegWalmartPgto) - 1].strCodAut := fGetDados(lstCampos[0]);
      FRegWalmartPgto[Length(FRegWalmartPgto) - 1].strDtaTra := fGetDados(lstCampos[6]);
      FRegWalmartPgto[Length(FRegWalmartPgto) - 1].strDtaPag := fGetDados(lstCampos[4]);

      FRegWalmartPgto[Length(FRegWalmartPgto) - 1].fltValBru := fGetDados(lstCampos[10], True, 0);
      FRegWalmartPgto[Length(FRegWalmartPgto) - 1].fltValFre := fGetDados(lstCampos[9], True, 0);
      FRegWalmartPgto[Length(FRegWalmartPgto) - 1].fltValCom := fGetDados(lstCampos[14], True, 0);
      FRegWalmartPgto[Length(FRegWalmartPgto) - 1].fltValLiq := fGetDados(lstCampos[15], True, 0);
      FRegWalmartPgto[Length(FRegWalmartPgto) - 1].strStatus := fGetDados(lstCampos[3]);
      FRegWalmartPgto[Length(FRegWalmartPgto) - 1].strNomArq := strNomArq;
      FRegWalmartPgto[Length(FRegWalmartPgto) - 1].strDtaArq := Copy(strDtaArq, 7, 4) + '/' + Copy(strDtaArq, 4, 2) + '/' + Copy(strDtaArq, 1, 2);
    End
    Else
    Begin
      FRegWalmartPgto[Length(FRegWalmartPgto) - 1].fltValBru := FRegWalmartPgto[Length(FRegWalmartPgto) - 1].fltValBru + fGetDados(lstCampos[10], True, 0);
      FRegWalmartPgto[Length(FRegWalmartPgto) - 1].fltValFre := FRegWalmartPgto[Length(FRegWalmartPgto) - 1].fltValFre + fGetDados(lstCampos[9], True, 0);
      FRegWalmartPgto[Length(FRegWalmartPgto) - 1].fltValCom := FRegWalmartPgto[Length(FRegWalmartPgto) - 1].fltValCom + fGetDados(lstCampos[14], True, 0);
      FRegWalmartPgto[Length(FRegWalmartPgto) - 1].fltValLiq := FRegWalmartPgto[Length(FRegWalmartPgto) - 1].fltValLiq + fGetDados(lstCampos[15], True, 0);
    End;

    strRegAnt := fGetDados(lstCampos[0]);
  End;
end;

procedure TWalmartPgto.pGravarRegistros(pgbProg: TProgressBar);
  Var
    qryDados : IDataSet;
    intCont  : Integer;
    strSQL   : String;
    arrCampos: TArrEstruturaWalmartPgto;

  function fRetVal(strVal: Variant; blnData: Boolean = False): Variant;
  Begin
    If fEmptyStr(strVal) Then Result := Null
    Else
    Begin
      If blnData Then
        Result := Copy(strVal, 1, 4) + '/' + Copy(strVal, 6, 2) + '/' + Copy(strVal, 9, 2)
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

  If Length(FRegWalmartPgto) > 0 Then
  Begin
    pgbProg.Max      := Length(FRegWalmartPgto)-1;
    For intCont := 0 To Length(FRegWalmartPgto)-1 Do
    Begin
      If (FRegWalmartPgto[intCont].fltValLiq <> 0) Then
      Begin
        Application.ProcessMessages;
        With qryDados Do
        Begin
          Close;

          ParamByName(INICAM + 'TIPREG').Value     := fRetVal(FRegWalmartPgto[intCont].strTipReg);
          ParamByName(INICAM + 'CODAUT').Value     := fRetVal(FRegWalmartPgto[intCont].strCodAut);
          ParamByName(INICAM + 'DTATRA').Value     := fRetVal(FRegWalmartPgto[intCont].strDtaTra, True);
          ParamByName(INICAM + 'DTAPAG').Value     := fRetVal(FRegWalmartPgto[intCont].strDtaPag, True);
          ParamByName(INICAM + 'VALBRU').Value     := fRetVal(FRegWalmartPgto[intCont].fltValBru);
          ParamByName(INICAM + 'VALFRE').Value     := fRetVal(FRegWalmartPgto[intCont].fltValFre);
          ParamByName(INICAM + 'VALCOM').Value     := fRetVal(FRegWalmartPgto[intCont].fltValCom);
          ParamByName(INICAM + 'VALLIQ').Value     := fRetVal(FRegWalmartPgto[intCont].fltValLiq);
          ParamByName(INICAM + 'STATUS').Value     := fRetVal(FRegWalmartPgto[intCont].strStatus);
          ParamByName(INICAM + 'NOMARQ').AsString  := fRetVal(FRegWalmartPgto[intCont].strNomArq);
          ParamByName(INICAM + 'DTAARQ').Value     := fRetVal(FRegWalmartPgto[intCont].strDtaArq);
          ParamByName(INICAM + 'CODEST').Value     := '0';
          ParamByName(INICAM + 'NUMPAR').Value     := '01';
          ParamByName(INICAM + 'TOTPAR').Value     := '01';
          ParamByName(INICAM + 'NUMCAR').Value     := '00000000000000';

          ExecSQL;
        End;
      End;

      pgbProg.Position := pgbProg.Position + 1;
    End;

    Try
      qryDados.Close;
      qryDados.SQL := 'REPLACE INTO ESTCAR (CAR_CODEST, CAR_NOMOPE) VALUES (:ESTAB, "WALMART")';
      qryDados.ParamByName('ESTAB').AsString := '0';
      qryDados.ExecSQL;
    Except
      Raise Exception.Create('A tabela ESTCAR não foi criada. Entre em contato com a Citel!');
    End;
  End;
end;

end.
