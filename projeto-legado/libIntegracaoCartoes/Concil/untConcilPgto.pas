{************************************}
{* Importação de arquivos da CONCIL *}
{*********************************AJ*}
unit untConcilPgto;

interface

uses Classes, StrUtils, SysUtils, Variants, untIIntegracaoCartoes, ComCtrls, Dialogs, Forms;

Type
// +---------------------------------------------------------------------------------+
// |                      CRITÉRIOS DE EDIÇÃO DOS DADOS                              |
// +---------------------------------------------------------------------------------+
// |  Tipo do registro               | Tipo de Lançamento Financeiro                 |
// +---------------------------------------------------------------------------------+
// |  Cod Estabelecimento            | Código do Estabelecimento junto a CONCIL      |
// +---------------------------------------------------------------------------------+
// |  Descrição Lançamento           | Descrição do Lançamento Financeiro            |
// +---------------------------------------------------------------------------------+
// |  Parcela                        | Núm. da Parcela                               |
// +---------------------------------------------------------------------------------+
// |  Código da Adquirinte           | Código do adquirinte                          |
// +---------------------------------------------------------------------------------+
// |  Produto                        | Tipo de transaç~~ao "CRÉDITO/DÉBITO"          |
// +---------------------------------------------------------------------------------+
// |  NSU                            | NSU da transação                              |
// +---------------------------------------------------------------------------------+
// |  Autorização                    | Código da Autorização da operadora            |
// +---------------------------------------------------------------------------------+
// |  Tipo de Cartão                 | Código do tipo de cartão.                     |
// +---------------------------------------------------------------------------------+
// |  Data do pagamento              | Data do pagamento da Transação                |
// +---------------------------------------------------------------------------------+
// |  Valor Pago                     | Valor Líquido                                 |
// +---------------------------------------------------------------------------------+
// |  Taxa                           | Percentual da Taxa                            |
// +---------------------------------------------------------------------------------+
// |  Status                         | 0 = Pendente - 1 = Conciliado                 |
// +---------------------------------------------------------------------------------+
// |  Referencia                     | Referencia 1 da exportação                    |
// +---------------------------------------------------------------------------------+
// |  Número da Antecipação         | Número da Antecipação                          |
// +---------------------------------------------------------------------------------+
// |  Desconto da Antecipação       | Valor do Desconto da Antecipação               |
// +---------------------------------------------------------------------------------+
// |  Código do Banco                | Código do Banco onde será realizado o Pgto    |
// +---------------------------------------------------------------------------------+
// |  Código da Agéncia              | Código da Agêcnia onde será realizado o Pgto  |
// +---------------------------------------------------------------------------------+
// |  Número da Conta Corrente       | Número da Conta onde será realizado o Pgto    |
// +---------------------------------------------------------------------------------+
// |  E-Commerce Transaction ID      | TID do E-Commerce                             |
// +---------------------------------------------------------------------------------+
// |  Terminal                       | Número do Terminal                            |
// +---------------------------------------------------------------------------------+
// | Data da Venda                   | Data da Venda                                 |
// +---------------------------------------------------------------------------------+
// | Número do Cartão                | Número do Cartão                              |
// +---------------------------------------------------------------------------------+
// | Número do RO                    | Número do RO                                  |
// +---------------------------------------------------------------------------------+
  TRegistroPgto = Record
    strNumReg: String;
    strCodEst: String;
    strDesLan: String;
    strNumPar: String;
    strAdquir: String;
    strTipTra: String;
    strNumNSU: String;
    strCodAut: String;
    strDtaPag: String;
    fltValLiq: Double;
    fltPerTax: Double;
    strStatus: String;
    strRefer1: String;
    strNumAnt: String;
    fltValDes: Double;
    strCodBco: String;
    strCodAge: String;
    strNumCCO: String;
    strNumTID: String;
    strNumTer: String;
    strDtaVen: String;
    strNumCar: String;
    strNum_RO: String;
    fltValBru: Double;
    strNomArq: String;
    strConcil: String;
  End;

  TEstruturaPgto = Record
    strDescri: String;
    strTipCmp: String;
  End;

  TArrRegistroConcPgto  = Array Of TRegistroPgto;

  TArrEstruturaConcPgto  = Array Of TEstruturaPgto;

  TConcilPgto = Class(TInterfacedObject, ICartoes)
  Private
    intPosicaoAtual: Integer;

    FGravouRegistros: Boolean;
  Public
    constructor Create;

    property GravouRegistros: Boolean read FGravouRegistros;

    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(pgbProg: TProgressBar);

    class function fRetSQLTabelaRegPgto(strTabela: String): String;
    class function fRetEstruturaPgto(strTabela: String): TArrEstruturaConcPgto;
  End;

Var
  strNomArq: String;

implementation

uses untFuncoes, untIDataSet, untConcil;

{ TConcilPgto }

{************************************************}
{* RETORNA A ESTRUTURA DA  TABELA  DE PAGAMENTO *}
{* CON_COPGTO                                   *}
{*********************************************AJ*}
constructor TConcilPgto.Create;
begin
  intPosicaoAtual := 1;
end;

class function TConcilPgto.fRetEstruturaPgto(strTabela: String): TArrEstruturaConcPgto;
Begin
  If strTabela = 'CON_COPGTO' Then Begin
    SetLength(Result, 26);

    Result[0].strDescri  := 'CON_TIPREG'; Result[0].strTipCmp  := 'VARCHAR(30)'  ;
    Result[1].strDescri  := 'CON_CODEST'; Result[1].strTipCmp  := 'VARCHAR(20)'  ;
    Result[2].strDescri  := 'CON_DESLAN'; Result[2].strTipCmp  := 'VARCHAR(10)'  ;
    Result[3].strDescri  := 'CON_NUMPAR'; Result[3].strTipCmp  := 'VARCHAR(2)'   ;
    Result[4].strDescri  := 'CON_ADQUIR'; Result[4].strTipCmp  := 'VARCHAR(50)'  ;
    Result[5].strDescri  := 'CON_TIPTRA'; Result[5].strTipCmp  := 'VARCHAR(25)'  ;
    Result[6].strDescri  := 'CON_NUMNSU'; Result[6].strTipCmp  := 'VARCHAR(12)'  ;
    Result[7].strDescri  := 'CON_CODAUT'; Result[7].strTipCmp  := 'VARCHAR(12)'  ;
    Result[8].strDescri  := 'CON_DTAPAG'; Result[8].strTipCmp  := 'DATE'         ;
    Result[9].strDescri  := 'CON_VALLIQ'; Result[9].strTipCmp  := 'DECIMAL(15,2)';
    Result[10].strDescri := 'CON_PERTAX'; Result[10].strTipCmp := 'DECIMAL(5,2)' ;
    Result[11].strDescri := 'CON_STATUS'; Result[11].strTipCmp := 'VARCHAR(1)'   ;
    Result[12].strDescri := 'CON_REFER1'; Result[12].strTipCmp := 'VARCHAR(50)'  ;
    Result[13].strDescri := 'CON_NUMANT'; Result[13].strTipCmp := 'VARCHAR(40)'  ;
    Result[14].strDescri := 'CON_VALDES'; Result[14].strTipCmp := 'DECIMAL(15,2)';
    Result[15].strDescri := 'CON_CODBCO'; Result[15].strTipCmp := 'VARCHAR(5)'   ;
    Result[16].strDescri := 'CON_CODAGE'; Result[16].strTipCmp := 'VARCHAR(7)'   ;
    Result[17].strDescri := 'CON_NUMCCO'; Result[17].strTipCmp := 'VARCHAR(15)'  ;
    Result[18].strDescri := 'CON_NUMTID'; Result[18].strTipCmp := 'VARCHAR(50)'  ;
    Result[19].strDescri := 'CON_NUMTER'; Result[19].strTipCmp := 'VARCHAR(30)'  ;
    Result[20].strDescri := 'CON_DTAVEN'; Result[20].strTipCmp := 'DATE'         ;
    Result[21].strDescri := 'CON_NUMCAR'; Result[21].strTipCmp := 'VARCHAR(25)'  ;
    Result[22].strDescri := 'CON_NUM_RO'; Result[22].strTipCmp := 'VARCHAR(45)'  ;
    Result[23].strDescri := 'CON_VALBRU'; Result[23].strTipCmp := 'DECIMAL(15,2)';
    Result[24].strDescri := 'CON_NOMARQ'; Result[24].strTipCmp := 'VARCHAR(255)' ;
    Result[25].strDescri := 'CON_CONCIL'; Result[25].strTipCmp := 'VARCHAR(1) DEFAULT ''0''';
  End;
End;

class function TConcilPgto.fRetSQLTabelaRegPgto(strTabela: String): String;
Var arrCampos: TArrEstruturaConcPgto;
    intCont  : Integer;
begin
  Result := 'CREATE TABLE ' + strTabela + '(';
  arrCampos := fRetEstruturaPgto(strTabela);

  For intCont := 0 to Length(arrCampos) - 1 do
    Result := Result + arrCampos[intCont].strDescri + ' ' + arrCampos[intCont].strTipCmp + ', ';

  Result := Result + 'PRIMARY KEY(CON_TIPREG,CON_CODEST,CON_NUMPAR,CON_ADQUIR,CON_NUMNSU,CON_CODAUT,CON_DTAVEN)) ENGINE INNODB ' ;
end;

procedure TConcilPgto.pAdicionaLinha(strString: String);
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
  If intPosicaoAtual >= Length(FRegConcPgto) - 1 Then
  Begin
    SetLength(FRegConcPgto, Length(FRegConcPgto)+AUMENTO_CAPACIDADE_FREG);
  End;

  lstCampos := TStringList.Create;
  lstCampos.Delimiter     := ';';
  lstCampos.DelimitedText := StringReplace(strString, ' ', '_', [rfReplaceAll]);
  If lstCampos[0] = 'C02' Then
  Begin
    FRegConcPgto[intPosicaoAtual-1].strNumReg := IIF(fEmptyStr(fGetDados(lstCampos[4])),'PCV',fGetDados(lstCampos[4]));
    FRegConcPgto[intPosicaoAtual-1].strCodEst := fGetDados(lstCampos[3]) ;
    FRegConcPgto[intPosicaoAtual-1].strDesLan := fGetDados(lstCampos[5]) ;
    FRegConcPgto[intPosicaoAtual-1].strNumPar := fGetDados(lstCampos[6]) ;
    FRegConcPgto[intPosicaoAtual-1].strNumPar := Copy(FRegConcPgto[intPosicaoAtual-1].strNumPar, 1,
                                                 Length(FRegConcPgto[intPosicaoAtual-1].strNumPar) - 2);
    FRegConcPgto[intPosicaoAtual-1].strAdquir := fGetDados(lstCampos[7]) ;
    FRegConcPgto[intPosicaoAtual-1].strTipTra := fGetDados(lstCampos[9]) ;
    FRegConcPgto[intPosicaoAtual-1].strNumNsu := fGetDados(lstCampos[11]);
    FRegConcPgto[intPosicaoAtual-1].strCodAut := fGetDados(lstCampos[12]);
    FRegConcPgto[intPosicaoAtual-1].strDtaPag := fGetDados(lstCampos[13]);
    FRegConcPgto[intPosicaoAtual-1].fltValLiq := fGetDados(lstCampos[14], True, 2);
    FRegConcPgto[intPosicaoAtual-1].fltPerTax := fGetDados(lstCampos[15], True, 2);
    FRegConcPgto[intPosicaoAtual-1].strStatus := fGetDados(lstCampos[16]);
    FRegConcPgto[intPosicaoAtual-1].strRefer1 := fGetDados(lstCampos[17]);
    FRegConcPgto[intPosicaoAtual-1].strNumAnt := fGetDados(lstCampos[19]);
    FRegConcPgto[intPosicaoAtual-1].fltValDes := fGetDados(lstCampos[20], True, 2);
    FRegConcPgto[intPosicaoAtual-1].strCodBco := fGetDados(lstCampos[21]);
    FRegConcPgto[intPosicaoAtual-1].strCodAge := fGetDados(lstCampos[22]);
    FRegConcPgto[intPosicaoAtual-1].strNumCCO := fGetDados(lstCampos[23]);
    FRegConcPgto[intPosicaoAtual-1].strNumTid := fGetDados(lstCampos[24]);
    FRegConcPgto[intPosicaoAtual-1].strNumTer := fGetDados(lstCampos[25]);
    FRegConcPgto[intPosicaoAtual-1].strDtaVen := fGetDados(lstCampos[26]);
    FRegConcPgto[intPosicaoAtual-1].strNumCar := fGetDados(lstCampos[27]);
    FRegConcPgto[intPosicaoAtual-1].strNum_RO := fGetDados(lstCampos[28]);
    FRegConcPgto[intPosicaoAtual-1].fltValBru := FRegConcPgto[intPosicaoAtual-1].fltValLiq +
                                                 ((FRegConcPgto[intPosicaoAtual-1].fltValLiq * FRegConcPgto[intPosicaoAtual-1].fltPerTax) /
                                                 (100 - FRegConcPgto[intPosicaoAtual-1].fltPerTax));
    FRegConcPgto[intPosicaoAtual-1].strNomArq := strNomArq;
    FRegConcPgto[intPosicaoAtual-1].strConcil := '0';


    Inc(intPosicaoAtual);
    intPos := lstEstabel.IndexOf(fGetDados(lstCampos[3]));
    If intPos < 0 Then
      lstEstabel.Add(fGetDados(lstCampos[3]));

  End;
end;

procedure TConcilPgto.pGravarRegistros(pgbProg: TProgressBar);
  Var
    qryDados : IDataSet;
    intCont  : Integer;
    strSQL   : String;
    arrCampos: TArrEstruturaConcPgto;

  function fRetVal(strVal: Variant; blnData: Boolean = False): Variant;
  Begin
    If fEmptyStr(strVal) Then Result := Null
    Else
    Begin
      If blnData Then
        Result := Copy(strVal, 7, 4) + '/' + Copy(strVal, 4, 2) + '/' + Copy(strVal, 1, 2)
      else
        Result := strVal;
    End;
  End;

begin
  strSQL :=          'REPLACE INTO CON_COPGTO (';
  arrCampos := fRetEstruturaPgto('CON_COPGTO');
  For intCont := 0 to Length(arrCampos) - 1 do
    If (arrCampos[intCont].strDescri <> 'CON_CONCIL') Then
      strSQL := strSQL + arrCampos[intCont].strDescri + ',';
  strSQL := Copy(strSQL, 1, Length(strSQL) - 1) + ') VALUES (';
  For intCont := 0 to Length(arrCampos) - 1 do
    If (arrCampos[intCont].strDescri <> 'CON_CONCIL') Then
      strSQL := strSQL + ':' + arrCampos[intCont].strDescri + ',';
  strSQL := Copy(strSQL, 1, Length(strSQL) - 1) + ')';

  qryDados := objFunctions.fGetDataSet;
  qryDados.Close;
  qryDados.SQL := strSQL;

  pgbProg.Position := 0;

  FGravouRegistros := False;

  If Length(FRegConcPgto) > 0 Then
  Begin
    pgbProg.Max      := Length(FRegConcPgto)-1;
    For intCont := 0 To Length(FRegConcPgto)-1 Do
    Begin
      If (FRegConcPgto[intCont].strDtaPag <> '') And (FRegConcPgto[intCont].strStatus <> '0') Then
      Begin
        Application.ProcessMessages;
        qryDados.Close;

        qryDados.ParamByName('CON_TIPREG').Value   := fRetVal(FRegConcPgto[intCont].strNumReg);
        qryDados.ParamByName('CON_CODEST').Value   := fRetVal(FRegConcPgto[intCont].strCodEst);
        qryDados.ParamByName('CON_DESLAN').Value   := fRetVal(FRegConcPgto[intCont].strDesLan);
        qryDados.ParamByName('CON_NUMPAR').Value   := fRetVal(FRegConcPgto[intCont].strNumPar);
        qryDados.ParamByName('CON_ADQUIR').Value   := fRetVal(FRegConcPgto[intCont].strAdquir);
        qryDados.ParamByName('CON_TIPTRA').Value   := fRetVal(FRegConcPgto[intCont].strTipTra);

        If fEmptyStr(FRegConcPgto[intCont].strNumNsu) Then
          qryDados.ParamByName('CON_NUMNSU').Value   := '  '
        Else
          qryDados.ParamByName('CON_NUMNSU').Value   := fRetVal(FRegConcPgto[intCont].strNumNsu);
        If fEmptyStr(FRegConcPgto[intCont].strCodAut) Then
          qryDados.ParamByName('CON_CODAUT').Value   := '  '
        Else
          qryDados.ParamByName('CON_CODAUT').Value   := fRetVal(FRegConcPgto[intCont].strCodAut);

        qryDados.ParamByName('CON_DTAPAG').Value   := fRetVal(FRegConcPgto[intCont].strDtaPag, True);
        qryDados.ParamByName('CON_VALLIQ').Value   := fRetVal(FRegConcPgto[intCont].fltValLiq);
        qryDados.ParamByName('CON_PERTAX').Value   := fRetVal(FRegConcPgto[intCont].fltPerTax);
        qryDados.ParamByName('CON_STATUS').Value   := fRetVal(FRegConcPgto[intCont].strStatus);
        qryDados.ParamByName('CON_REFER1').Value   := fRetVal(FRegConcPgto[intCont].strRefer1);
        qryDados.ParamByName('CON_NUMANT').Value   := fRetVal(FRegConcPgto[intCont].strNumAnt);
        qryDados.ParamByName('CON_VALDES').Value   := fRetVal(FRegConcPgto[intCont].fltValDes);
        qryDados.ParamByName('CON_CODBCO').Value   := fRetVal(FRegConcPgto[intCont].strCodBco);
        qryDados.ParamByName('CON_CODAGE').Value   := fRetVal(FRegConcPgto[intCont].strCodAge);
        qryDados.ParamByName('CON_NUMCCO').Value   := fRetVal(FRegConcPgto[intCont].strNumCCO);
        qryDados.ParamByName('CON_NUMTID').Value   := fRetVal(FRegConcPgto[intCont].strNumTid);
        qryDados.ParamByName('CON_NUMTER').Value   := fRetVal(FRegConcPgto[intCont].strNumTer);
        qryDados.ParamByName('CON_DTAVEN').Value   := fRetVal(FRegConcPgto[intCont].strDtaVen, True);
        qryDados.ParamByName('CON_NUMCAR').Value   := fRetVal(FRegConcPgto[intCont].strNumCar);
        qryDados.ParamByName('CON_NUM_RO').Value   := fRetVal(FRegConcPgto[intCont].strNum_RO);
        qryDados.ParamByName('CON_VALBRU').Value   := fRetVal(FRegConcPgto[intCont].fltValBru);
        qryDados.ParamByName('CON_NOMARQ').Value   := fRetVal(FRegConcPgto[intCont].strNomArq);

        qryDados.ExecSQL;

        FGravouRegistros := True;
      End;

      pgbProg.Position := pgbProg.Position + 1;
    End;

    Try
      qryDados.Close;
      qryDados.SQL := 'REPLACE INTO ESTCAR (CAR_CODEST, CAR_NOMOPE) VALUES (:ESTAB, "CONCIL")';
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
