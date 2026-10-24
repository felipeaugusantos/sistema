{************************************}
{* Importação de arquivos da ELAVON *}
{*********************************AJ*}
unit untElavonPagto;

interface

uses Classes, StrUtils, SysUtils, Variants, untIIntegracaoCartoes, ComCtrls, Dialogs, Forms;

Type
// +---------------------------------------------------------------------------------+
// |                      CRITÉRIOS DE EDIÇÃO DOS DADOS                              |
// +---------------------------------------------------------------------------------+
// |  Tipo do registro               | “10” = Registro de Transações                 |
// +---------------------------------------------------------------------------------+
// |  Cod Estabelecimento            | Código do Estabelecimento junto a ELAVON      |
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
// |  Tipo de Cartão                 | Código do tipo de cartão.                     |
// +---------------------------------------------------------------------------------+
// |  Código da Descrição            | Código da descrição de carnê, tarifa, ajustes |
// +---------------------------------------------------------------------------------+
// |  Núm. da Parcela                | Número da parcela a ser paga. Será suprimido  |
// |                                 | em transações à vista                         |
// +---------------------------------------------------------------------------------+
// |  Total de Parcelas              | Total de parcelas. Será suprimido em          |
// |                                 | transações a vista                            |
// +---------------------------------------------------------------------------------+
// |  Sinal Valor Transação (Bruto)  | Positivo ou Negativo. Cancelamento e Ajustes  |
// |                                 | será suprimido                                |
// +---------------------------------------------------------------------------------+
// |  Valor da Transação             | Valor Bruto da Transação                      |
// +---------------------------------------------------------------------------------+
// |  Data Original do Pagamento     | Data Original do pagamento                    |
// +---------------------------------------------------------------------------------+
// |  E-Commerce Transaction ID      | TID do E-Commerce                             |
// +---------------------------------------------------------------------------------+
// | Data da transação               | Data em que foi realizada a transação         |
// +---------------------------------------------------------------------------------+
  TRegistroPgto = Record
    strNumReg: String;
    strCodEst: String;
    strLoteAu: String;
    strNumCar: String;
    strCodAut: String;
    strNumNSU: String;
    strTipCar: String;
    strCodDes: String;
    strNumPar: String;
    strTotPar: String;
    strSinVBT: String;
    fltValVBT: Double;
    strDtaPag: String;
    strIDECom: String;
    strDtaTra: String;
    fltValBLT: Double;
    fltValLLT: Double;
    strNomArq: String;
    strConcil: String;
  End;

  TEstruturaPgto = Record
    strDescri: String;
    strTipCmp: String;
  End;

  TArrRegistroElaPgto  = Array Of TRegistroPgto;

  TArrEstruturaElaPgto  = Array Of TEstruturaPgto;

  TElavonPagto = Class(TInterfacedObject, ICartoes)
  Private
    dtaArq   : String;
    fltValBLT,
    fltValLLT: Double;

    intPosicaoAtual: Integer;
  Public
    constructor Create;

    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(pgbProg: TProgressBar);

    class function fRetSQLTabelaRegPgto(strTabela: String): String;
    class function fRetEstruturaPgto(strTabela: String): TArrEstruturaElaPgto;
  End;

Var
  strNomArq: String;

implementation

uses untFuncoes, untIDataSet, untElavon;

{ TRedeCredito }

{************************************************}
{* RETORNA A ESTRUTURA DA  TABELA  DE PAGAMENTO *}
{* ELA_EVPGTO                                   *}
{*********************************************AJ*}
constructor TElavonPagto.Create;
begin
  intPosicaoAtual := 1;
end;

class function TElavonPagto.fRetEstruturaPgto(strTabela: String): TArrEstruturaElaPgto;
Begin
  If strTabela = 'ELA_EVPGTO' Then Begin
    SetLength(Result, 19);

    Result[0].strDescri  := 'ELA_NUMREG'; Result[0].strTipCmp  := 'CHAR(2)'      ;
    Result[1].strDescri  := 'ELA_CODEST'; Result[1].strTipCmp  := 'VARCHAR(16)'  ;
    Result[2].strDescri  := 'ELA_LOTEAU'; Result[2].strTipCmp  := 'VARCHAR(11)'  ;
    Result[3].strDescri  := 'ELA_NUMCAR'; Result[3].strTipCmp  := 'VARCHAR(11)'  ;
    Result[4].strDescri  := 'ELA_CODAUT'; Result[4].strTipCmp  := 'VARCHAR(6)'   ;
    Result[5].strDescri  := 'ELA_NUMNSU'; Result[5].strTipCmp  := 'VARCHAR(11)'  ;
    Result[6].strDescri  := 'ELA_TIPCAR'; Result[6].strTipCmp  := 'VARCHAR(3)'   ;
    Result[7].strDescri  := 'ELA_CODDES'; Result[7].strTipCmp  := 'VARCHAR(5)'   ;
    Result[8].strDescri  := 'ELA_NUMPAR'; Result[8].strTipCmp  := 'VARCHAR(2)'   ;
    Result[9].strDescri  := 'ELA_TOTPAR'; Result[9].strTipCmp  := 'VARCHAR(2)'   ;
    Result[10].strDescri := 'ELA_SINVBT'; Result[10].strTipCmp := 'VARCHAR(1)'   ;
    Result[11].strDescri := 'ELA_VALVBT'; Result[11].strTipCmp := 'DECIMAL(15,2)';
    Result[12].strDescri := 'ELA_DTAPAG'; Result[12].strTipCmp := 'DATE'         ;
    Result[13].strDescri := 'ELA_IDECOM'; Result[13].strTipCmp := 'VARCHAR(20)'  ;
    Result[14].strDescri := 'ELA_DTATRA'; Result[14].strTipCmp := 'DATE'         ;
    Result[15].strDescri := 'ELA_VALBLT'; Result[15].strTipCmp := 'DECIMAL(15,2)';
    Result[16].strDescri := 'ELA_VALLLT'; Result[16].strTipCmp := 'DECIMAL(15,2)';
    Result[17].strDescri := 'ELA_NOMARQ'; Result[17].strTipCmp := 'VARCHAR(255)' ;
    Result[18].strDescri := 'ELA_CONCIL'; Result[18].strTipCmp := 'VARCHAR(1) DEFAULT ''0''';
  End;
End;

class function TElavonPagto.fRetSQLTabelaRegPgto(strTabela: String): String;
Var arrCampos: TArrEstruturaElaPgto;
    intCont  : Integer;
begin
  Result := 'CREATE TABLE ' + strTabela + '(';
  arrCampos := fRetEstruturaPgto(strTabela);

  For intCont := 0 to Length(arrCampos) - 1 do
    Result := Result + arrCampos[intCont].strDescri + ' ' + arrCampos[intCont].strTipCmp + ', ';

  Result := Result + 'PRIMARY KEY(ELA_CODEST,                ' +
                     'ELA_CODAUT,                            ' +
                     'ELA_NUMNSU,                            ' +
                     'ELA_NUMPAR,                            ' +
                     'ELA_DTAPAG,                            ' +
                     'ELA_DTATRA)) ENGINE INNODB             ' ;
end;

procedure TElavonPagto.pAdicionaLinha(strString: String);
Const
  AUMENTO_CAPACIDADE_FREG  = 2000;

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
  If intPosicaoAtual >= Length(FRegElaPgto) - 1 Then
  Begin
    SetLength(FRegElaPgto, Length(FRegElaPgto)+AUMENTO_CAPACIDADE_FREG);
  End;

  lstCampos := TStringList.Create;
  lstCampos.Delimiter     := '|';
  lstCampos.DelimitedText := strString;
  If lstCampos[0] = '02' Then
    dtaArq := lstCampos[6]
  Else If lstCampos[0] = '05' Then
  Begin
    fltValBLT := fGetDados(lstCampos[13], True, 2);
    fltValLLT := fGetDados(lstCampos[19], True, 2);
  End
  Else If lstCampos[0] = '10' Then
  Begin
    FRegElaPgto[intPosicaoAtual-1].strNumReg := fGetDados(lstCampos[0]) ;
    FRegElaPgto[intPosicaoAtual-1].strCodEst := fGetDados(lstCampos[1]) ;
    FRegElaPgto[intPosicaoAtual-1].strLoteAu := fGetDados(lstCampos[2]) ;
    FRegElaPgto[intPosicaoAtual-1].strNumCar := fGetDados(lstCampos[4]) ;
    FRegElaPgto[intPosicaoAtual-1].strCodAut := fGetDados(lstCampos[17]);
    FRegElaPgto[intPosicaoAtual-1].strNumNSU := fGetDados(lstCampos[5]) ;
    FRegElaPgto[intPosicaoAtual-1].strTipCar := fGetDados(lstCampos[7]) ;
    FRegElaPgto[intPosicaoAtual-1].strCodDes := fGetDados(lstCampos[8]) ;
    FRegElaPgto[intPosicaoAtual-1].strNumPar := fGetDados(lstCampos[10]);
    FRegElaPgto[intPosicaoAtual-1].strTotPar := fGetDados(lstCampos[11]);
    FRegElaPgto[intPosicaoAtual-1].strSinVBT := fGetDados(lstCampos[12]);
    FRegElaPgto[intPosicaoAtual-1].fltValVBT := fGetDados(lstCampos[13], True, 2);
    FRegElaPgto[intPosicaoAtual-1].strDtaPag := VarToStrDef(fGetDados(lstCampos[14]), dtaArq);
    FRegElaPgto[intPosicaoAtual-1].strIDECom := fGetDados(lstCampos[16]);
    FRegElaPgto[intPosicaoAtual-1].strDtaTra := fGetDados(lstCampos[18]);
    FRegElaPgto[intPosicaoAtual-1].fltValBLT := fltValBLT;
    FRegElaPgto[intPosicaoAtual-1].fltValLLT := fltValLLT;
    FRegElaPgto[intPosicaoAtual-1].strNomArq := strNomArq;
    FRegElaPgto[intPosicaoAtual-1].strConcil := '0';

    Inc(intPosicaoAtual);
    intPos := lstEstabel.IndexOf(fGetDados(lstCampos[1]));
    If (fGetDados(lstCampos[1]) <> '') And (intPos < 0) Then
      lstEstabel.Add(fGetDados(lstCampos[1]));
  End;
end;

procedure TElavonPagto.pGravarRegistros(pgbProg: TProgressBar);
  Var
    qryDados : IDataSet;
    intCont  : Integer;
    strSQL   : String;
    arrCampos: TArrEstruturaElaPgto;

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
  strSQL :=          'REPLACE INTO ELA_EVPGTO (';
  arrCampos := fRetEstruturaPgto('ELA_EVPGTO');
  For intCont := 0 to Length(arrCampos) - 1 do
    If (arrCampos[intCont].strDescri <> 'ELA_CONCIL') Then
      strSQL := strSQL + arrCampos[intCont].strDescri + ',';
  strSQL := Copy(strSQL, 1, Length(strSQL) - 1) + ') VALUES (';
  For intCont := 0 to Length(arrCampos) - 1 do
    If (arrCampos[intCont].strDescri <> 'ELA_CONCIL') Then
      strSQL := strSQL + ':' + arrCampos[intCont].strDescri + ',';
  strSQL := Copy(strSQL, 1, Length(strSQL) - 1) + ')';

  qryDados := objFunctions.fGetDataSet;
  qryDados.Close;
  qryDados.SQL := strSQL;

  pgbProg.Position := 0;

  If Length(FRegElaPgto) > 0 Then
  Begin
    pgbProg.Max      := Length(FRegElaPgto)-1;
    For intCont := 0 To Length(FRegElaPgto)-1 Do
    Begin
      If (FRegElaPgto[intCont].strDtaPag <> '') And (FRegElaPgto[intCont].strCodAut <> '') And
         (FRegElaPgto[intCont].strNumNSU <> '') Then
      Begin
        Application.ProcessMessages;
        qryDados.Close;

        qryDados.ParamByName('ELA_NUMREG').Value   := fRetVal(FRegElaPgto[intCont].strNumReg);
        qryDados.ParamByName('ELA_CODEST').Value   := fRetVal(FRegElaPgto[intCont].strCodEst);
        qryDados.ParamByName('ELA_LOTEAU').Value   := fRetVal(FRegElaPgto[intCont].strLoteAu);
        qryDados.ParamByName('ELA_NUMCAR').Value   := fRetVal(FRegElaPgto[intCont].strNumCar);
        qryDados.ParamByName('ELA_CODAUT').Value   := VarToStrDef(fRetVal(FRegElaPgto[intCont].strCodAut), '0');
        qryDados.ParamByName('ELA_NUMNSU').Value   := VarToStrDef(fRetVal(FRegElaPgto[intCont].strNumNSU), '0');
        qryDados.ParamByName('ELA_TIPCAR').Value   := fRetVal(FRegElaPgto[intCont].strTipCar);
        qryDados.ParamByName('ELA_CODDES').Value   := fRetVal(FRegElaPgto[intCont].strCodDes);
        qryDados.ParamByName('ELA_NUMPAR').Value   := VarToStrDef(fRetVal(FRegElaPgto[intCont].strNumPar), '0');
        qryDados.ParamByName('ELA_TOTPAR').Value   := fRetVal(FRegElaPgto[intCont].strTotPar);
        qryDados.ParamByName('ELA_SINVBT').Value   := fRetVal(FRegElaPgto[intCont].strSinVBT);
        qryDados.ParamByName('ELA_VALVBT').Value   := fRetVal(FRegElaPgto[intCont].fltValVBT);
        qryDados.ParamByName('ELA_DTAPAG').Value   := fRetVal(FRegElaPgto[intCont].strDtaPag, True);
        qryDados.ParamByName('ELA_IDECOM').Value   := fRetVal(FRegElaPgto[intCont].strIDECom);
        qryDados.ParamByName('ELA_DTATRA').Value   := fRetVal(FRegElaPgto[intCont].strDtaTra, True);
        qryDados.ParamByName('ELA_VALBLT').Value   := fRetVal(FRegElaPgto[intCont].fltValBLT);
        qryDados.ParamByName('ELA_VALLLT').Value   := fRetVal(FRegElaPgto[intCont].fltValLLT);
        qryDados.ParamByName('ELA_NOMARQ').Value   := fRetVal(FRegElaPgto[intCont].strNomArq);
        
        qryDados.ExecSQL;
      End;

      pgbProg.Position := pgbProg.Position + 1;
    End;

    Try
      qryDados.Close;
      qryDados.SQL := 'REPLACE INTO ESTCAR (CAR_CODEST, CAR_NOMOPE) VALUES (:ESTAB, "ELAVON")';
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
