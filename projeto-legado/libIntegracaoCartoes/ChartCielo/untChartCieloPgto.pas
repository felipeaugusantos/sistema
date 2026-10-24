{*****************************************}
{* Importação de arquivos da CHART-CIELO *}
{**************************************AJ*}
unit untChartCieloPgto;

interface

uses Classes, StrUtils, SysUtils, Variants, untIIntegracaoCartoes, ComCtrls, Dialogs, Forms;

Type
// +---------------------------------------------------------------------------------+
// |                      CRITÉRIOS DE EDIÇÃO DOS DADOS                              |
// +---------------------------------------------------------------------------------+
// |  Tipo do registro               | “001” = Pagamento - "002" = Aceito CLiente    |
// |                                 | "010" = Valor Divergente - "020" = Ajuste     |
// |                                 | "030" = Não Encontrados - "031" Não Enc. Cli. |
// |                                 | "040" = Rej. pela Oper. - "050" = Antecipados |
// |                                 | "060" = Não Pagos                             |
// +---------------------------------------------------------------------------------+
// |  Cod Estabelecimento            | Código do Estabelecimento junto a CHART-CIELO |
// +---------------------------------------------------------------------------------+
// |  Número NSU                     | Número da NSU                                 |
// +---------------------------------------------------------------------------------+
// |  Número TID                     | Número da TID para vendas online              |
// +---------------------------------------------------------------------------------+
// |  Número do Cartão               | Núm. do cartão que foi utilizado na transação |
// +---------------------------------------------------------------------------------+
// |  Código da Autorização          | Código da autorização informado pelo emissor  |
// |                                 | para identificar a transação                  |
// +---------------------------------------------------------------------------------+
// |  Data da Transação              | Data da transação                             |
// +---------------------------------------------------------------------------------+
// |  Tipo de Cartão                 | Crédito/Débito.                               |
// +---------------------------------------------------------------------------------+
// |  Núm. da Parcela                | Número da parcela a ser paga. Será suprimido  |
// |                                 | em transações à vista                         |
// +---------------------------------------------------------------------------------+
// |  Total de Parcelas              | Total de parcelas. Será suprimido em          |
// |                                 | transações a vista                            |
// +---------------------------------------------------------------------------------+
// |  Valor Bruto                    | Valor Bruto                                   |
// +---------------------------------------------------------------------------------+
// |  Valor Recebido                 | Valor Recebido                                |
// +---------------------------------------------------------------------------------+
// |  Valor Cobrado                  | Valor Cobrado                                 |
// +---------------------------------------------------------------------------------+
// |  Data do Pagamento              | Data Original do pagamento                    |
// +---------------------------------------------------------------------------------+
// |  Código do Banco                | Código do Banco onde será realizado o Pgto    |
// +---------------------------------------------------------------------------------+
// |  Código da Agéncia              | Código da Agêcnia onde será realizado o Pgto  |
// +---------------------------------------------------------------------------------+
// |  Número da Conta Corrente       | Número da Conta onde será realizado o Pgto    |
// +---------------------------------------------------------------------------------+


  TRegistroPgto = Record
    strTipReg: String;
    strCodEst: String;
    strNumNsu: String;
    strNumTID: String;
    strNumCar: String;
    strCodAut: String;
    strTipCar: String;
    strNumPar: String;
    strTotPar: String;
    fltValBru: Double;
    fltValRec: Double;
    fltValCob: Double;
    strDtaPag: String;
    strCodBco: String;
    strCodAge: String;
    strNumCco: String;
    strDtaTra: String;
    strNomArq: String;
  End;

  TEstruturaPgto = Record
    strDescri: String;
    strTipCmp: String;
  End;

  TArrRegistroChaPgto  = Array Of TRegistroPgto;

  TArrEstruturaChaPgto  = Array Of TEstruturaPgto;

  TChartCieloPgto = Class(TInterfacedObject, ICartoes)
  Private
    strCodEst: String;

    intPosicaoAtual: Integer;
  Public

    constructor Create;
    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(pgbProg: TProgressBar);

    class function fRetSQLTabelaRegPgto(strTabela: String): String;
    class function fRetEstruturaPgto(strTabela: String): TArrEstruturaChaPgto;
  End;

Var
  strNomArq: String;

implementation

uses untFuncoes, untIDataSet, untChartCielo;

{ TChartCieloPgto }

constructor TChartCieloPgto.Create;
Begin
  intPosicaoAtual := 1;
End;

{************************************************}
{* RETORNA A ESTRUTURA DA  TABELA  DE PAGAMENTO *}
{* CHA_CIPGTO                                   *}
{*********************************************AJ*}
class function TChartCieloPgto.fRetEstruturaPgto(strTabela: String): TArrEstruturaChaPgto;
Begin
  If strTabela = 'CHA_CIPGTO' Then Begin
    SetLength(Result, 20);

    Result[0].strDescri  := 'CHA_TIPREG'; Result[0].strTipCmp  := 'VARCHAR(3)'   ;
    Result[1].strDescri  := 'CHA_CODEST'; Result[1].strTipCmp  := 'VARCHAR(50)'  ;
    Result[2].strDescri  := 'CHA_NUMNSU'; Result[2].strTipCmp  := 'VARCHAR(30)'  ;
    Result[3].strDescri  := 'CHA_NUMTID'; Result[3].strTipCmp  := 'VARCHAR(30)'  ;
    Result[4].strDescri  := 'CHA_NUMCAR'; Result[4].strTipCmp  := 'VARCHAR(19)'  ;
    Result[5].strDescri  := 'CHA_CODAUT'; Result[5].strTipCmp  := 'VARCHAR(30)'  ;
    Result[6].strDescri  := 'CHA_TIPCAR'; Result[6].strTipCmp  := 'VARCHAR(1)'   ;
    Result[7].strDescri  := 'CHA_NUMPAR'; Result[7].strTipCmp  := 'VARCHAR(3)'   ;
    Result[8].strDescri  := 'CHA_TOTPAR'; Result[8].strTipCmp  := 'VARCHAR(3)'   ;
    Result[9].strDescri  := 'CHA_DTATRA'; Result[9].strTipCmp  := 'DATE'         ;
    Result[10].strDescri := 'CHA_VALBRU'; Result[10].strTipCmp := 'DECIMAL(15,2)';
    Result[11].strDescri := 'CHA_VALREC'; Result[11].strTipCmp := 'DECIMAL(15,2)';
    Result[12].strDescri := 'CHA_VALCOB'; Result[12].strTipCmp := 'DECIMAL(15,2)';
    Result[13].strDescri := 'CHA_DTAPAG'; Result[13].strTipCmp := 'DATE'         ;
    Result[14].strDescri := 'CHA_CODBCO'; Result[14].strTipCmp := 'VARCHAR(4)'   ;
    Result[15].strDescri := 'CHA_CODAGE'; Result[15].strTipCmp := 'VARCHAR(5)'   ;
    Result[16].strDescri := 'CHA_NUMCCO'; Result[16].strTipCmp := 'VARCHAR(15)'  ;
    Result[17].strDescri := 'CHA_CREDEB'; Result[17].strTipCmp := 'VARCHAR(1)'   ;
    Result[18].strDescri := 'CHA_NOMARQ'; Result[18].strTipCmp := 'VARCHAR(255)' ;
    Result[19].strDescri := 'CHA_CONCIL'; Result[19].strTipCmp := 'VARCHAR(1) DEFAULT ''0'''   ;
  End;
End;

class function TChartCieloPgto.fRetSQLTabelaRegPgto(strTabela: String): String;
Var arrCampos: TArrEstruturaChaPgto;
    intCont  : Integer;
begin
  Result := 'CREATE TABLE ' + strTabela + '(';
  arrCampos := fRetEstruturaPgto(strTabela);

  For intCont := 0 to Length(arrCampos) - 1 do
    Result := Result + arrCampos[intCont].strDescri + ' ' + arrCampos[intCont].strTipCmp + ', ';

  Result := Result + 'PRIMARY KEY(CHA_TIPREG,CHA_NUMNSU,CHA_DTATRA,CHA_NUMPAR,CHA_CODAUT,CHA_CODEST)) ENGINE INNODB             ' ;
end;

procedure TChartCieloPgto.pAdicionaLinha(strString: String);
Const
  AUMENTO_CAPACIDADE_FREG  = 2000;

  function fGetDados(intIni, intTam: Integer; blnFlt: Boolean = False): Variant;
    Var
      rst: Variant;
  Begin
    rst := Trim(Copy(strString, intIni, intTam));
    If blnFlt Then rst := fStrToFloat(rst) / 10000;

    Result := rst;
  End;

begin
  If intPosicaoAtual >= Length(FRegChartCieloPgto) - 1 Then
  Begin
    SetLength(FRegChartCieloPgto, Length(FRegChartCieloPgto)+AUMENTO_CAPACIDADE_FREG);
  End;

  If Not Assigned(lstEstabel) Then
    lstEstabel := TStringList.Create;

  If fGetDados(168, 05) = 'CIELO' Then
    strCodEst    := fGetDados(115,50)
  Else If fGetDados(237,01) = '+' Then
  Begin
    FRegChartCieloPgto[intPosicaoAtual-1].strCodEst := strCodEst;
    FRegChartCieloPgto[intPosicaoAtual-1].strNumNSU := fGetDados(091,30);
    FRegChartCieloPgto[intPosicaoAtual-1].strNumTid := fGetDados(121,30);
    FRegChartCieloPgto[intPosicaoAtual-1].strDtaTra := fGetDados(151,08);
    FRegChartCieloPgto[intPosicaoAtual-1].strNumPar := fGetDados(165,03);
    FRegChartCieloPgto[intPosicaoAtual-1].strTotPar := fGetDados(168,03);
    FRegChartCieloPgto[intPosicaoAtual-1].fltValBru := fGetDados(171,13,True);
    FRegChartCieloPgto[intPosicaoAtual-1].fltValRec := fGetDados(184,13,True);
    FRegChartCieloPgto[intPosicaoAtual-1].fltValCob := fGetDados(197,13,True);
    FRegChartCieloPgto[intPosicaoAtual-1].strDtaPag := fGetDados(210,08);
    FRegChartCieloPgto[intPosicaoAtual-1].strNumCar := fGetDados(218,19);
    FRegChartCieloPgto[intPosicaoAtual-1].strCodBco := fGetDados(238,04);
    FRegChartCieloPgto[intPosicaoAtual-1].strCodAge := fGetDados(242,05);
    FRegChartCieloPgto[intPosicaoAtual-1].strNumCco := fGetDados(247,14);
    FRegChartCieloPgto[intPosicaoAtual-1].strTipReg := fGetDados(261,03);

    If (Pos('CREDITO', fGetDados(264,100)) > 0) Or (Pos('PARCELADO', fGetDados(264,100)) > 0) Then
      FRegChartCieloPgto[intPosicaoAtual-1].strTipCar := 'C'
    Else
      FRegChartCieloPgto[intPosicaoAtual-1].strTipCar := 'D';

    FRegChartCieloPgto[intPosicaoAtual-1].strCodAut := fGetDados(364,30);
    FRegChartCieloPgto[intPosicaoAtual-1].strNomArq := strNomArq;

    If (strCodEst <> '') And
       (lstEstabel.IndexOf(strCodEst) < 0) Then
      lstEstabel.Add(strCodEst);

    Inc(intPosicaoAtual);
  End;
end;

procedure TChartCieloPgto.pGravarRegistros(pgbProg: TProgressBar);
  Var
    qryDados : IDataSet;
    intCont  : Integer;
    strSQL   : String;
    arrCampos: TArrEstruturaChaPgto;

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
  strSQL :=    'REPLACE INTO CHA_CIPGTO (';
  arrCampos := fRetEstruturaPgto('CHA_CIPGTO');
  For intCont := 0 to Length(arrCampos) - 1 do
    If (arrCampos[intCont].strDescri <> 'CHA_CONCIL') Then
      strSQL := strSQL + arrCampos[intCont].strDescri + ',';
  strSQL := Copy(strSQL, 1, Length(strSQL) - 1) + ') VALUES (';
  For intCont := 0 to Length(arrCampos) - 1 do
    If (arrCampos[intCont].strDescri <> 'CHA_CONCIL') Then
      strSQL := strSQL + ':' + arrCampos[intCont].strDescri + ',';
  strSQL := Copy(strSQL, 1, Length(strSQL) - 1) + ')';

  qryDados := objFunctions.fGetDataSet;
  qryDados.Close;
  qryDados.SQL := strSQL;

  pgbProg.Position := 0;

  If Length(FRegChartCieloPgto) > 0 Then
  Begin
    pgbProg.Max      := Length(FRegChartCieloPgto);
    For intCont := 0 To Length(FRegChartCieloPgto) - 1 Do
    Begin
      If ((FRegChartCieloPgto[intCont].strTipReg <> '') And
         (FRegChartCieloPgto[intCont].strCodEst <> ''))  Then
      Begin
        Application.ProcessMessages;
        With qryDados Do
        Begin
          Close;

          ParamByName('CHA_TIPREG').Value   := fRetVal(FRegChartCieloPgto[intCont].strTipReg);
          ParamByName('CHA_CODEST').Value   := fRetVal(FRegChartCieloPgto[intCont].strCodEst);
          ParamByName('CHA_DTATRA').Value   := fRetVal(FRegChartCieloPgto[intCont].strDtaTra, True);
          ParamByName('CHA_DTAPAG').Value   := fRetVal(FRegChartCieloPgto[intCont].strDtaPag, True);
          ParamByName('CHA_CODBCO').Value   := fRetVal(FRegChartCieloPgto[intCont].strCodBco);
          ParamByName('CHA_CODAGE').Value   := fRetVal(FRegChartCieloPgto[intCont].strCodAge);
          ParamByName('CHA_NUMCCO').Value   := fRetVal(FRegChartCieloPgto[intCont].strNumCco);
          ParamByName('CHA_VALBRU').Value   := fRetVal(FRegChartCieloPgto[intCont].fltValBru);
          ParamByName('CHA_VALREC').Value   := fRetVal(FRegChartCieloPgto[intCont].fltValRec);
          ParamByName('CHA_VALCOB').Value   := fRetVal(FRegChartCieloPgto[intCont].fltValCob);
          ParamByName('CHA_NUMNSU').Value   := fRetVal(FRegChartCieloPgto[intCont].strNumNSU);
          ParamByName('CHA_NUMCAR').Value   := fRetVal(FRegChartCieloPgto[intCont].strNumCar);
          ParamByName('CHA_TOTPAR').Value   := fRetVal(FRegChartCieloPgto[intCont].strTotPar);
          ParamByName('CHA_NUMPAR').Value   := fRetVal(FRegChartCieloPgto[intCont].strNumPar);
          ParamByName('CHA_CODAUT').Value   := fRetVal(FRegChartCieloPgto[intCont].strCodAut);
          ParamByName('CHA_NUMTID').Value   := fRetVal(FRegChartCieloPgto[intCont].strNumTid);
          ParamByName('CHA_TIPCAR').Value   := fRetVal(FRegChartCieloPgto[intCont].strTipCar);
          ParamByName('CHA_NOMARQ').Value   := fRetVal(FRegChartCieloPgto[intCont].strNomArq);
          
          ExecSQL;
        End;
      End;

      pgbProg.Position := pgbProg.Position + 1;
    End;

    Try
      qryDados.Close;
      qryDados.SQL := 'REPLACE INTO ESTCAR (CAR_CODEST, CAR_NOMOPE) VALUES (:ESTAB, "CHART-CIELO")';
      For intCont := 0 To lstEstabel.Count - 1 Do
      Begin
        qryDados.ParamByName('ESTAB').AsString := lstEstabel[intCont];
        qryDados.ExecSQL;
      End;

      FreeAndNil(lstEstabel);
    Except
      Raise Exception.Create('A tabela ESTCAR não foi criada. Entre em contato com a Citel!');
    End;

    pgbProg.Position := pgbProg.Max;
  End;
end;

end.
