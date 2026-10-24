{***************************************}
{* Importação de arquivos da BOA VISTA *}
{************************************AZ*}
unit untBoaVistaPgto;

interface

uses Classes, StrUtils, SysUtils, Variants, untIIntegracaoCartoes, ComCtrls, Dialogs, Forms, untIDataSet;

Type
// +---------------------------------------------------------------------------------+
// |                      CRITÉRIOS DE EDIÇÃO DOS DADOS                              |
// +---------------------------------------------------------------------------------+
// |  Data da Venda                  | Data da Venda                                 |
// +---------------------------------------------------------------------------------+
// |  Data de Crédito                | Data de Crédito                               |
// +---------------------------------------------------------------------------------+
// |  NSU                            | DOC/CV                                        |
// +---------------------------------------------------------------------------------+
// |  Autorização                    | Núm. da Autorização da venda                  |
// +---------------------------------------------------------------------------------+
// |  Total de Parcelas              | Qauntidade de Parcelas                        |
// +---------------------------------------------------------------------------------+
// |  Parcela                        | Núm. da Parcela                               |
// +---------------------------------------------------------------------------------+
// |  Operadora                      | Nome da Operadora do cartão                   |
// +---------------------------------------------------------------------------------+
// |  Bandeira                       | Bandeira do cartão                            |
// +---------------------------------------------------------------------------------+
// |  Produto                        | Tipo de transaç~~ao "CRÉDITO/DÉBITO"          |
// +---------------------------------------------------------------------------------+
// |  Valor Bruto                    | Valor Bruto da Parcela                        |
// +---------------------------------------------------------------------------------+
// |  Valor Taxa                     | Valor da Administração                        |
// +---------------------------------------------------------------------------------+
// |  Valor Antecipação              | Valor de Antecipação                          |
// +---------------------------------------------------------------------------------+
// |  Número do Lote                 | Identificador do Lote                         |
// +---------------------------------------------------------------------------------+
// |  Banco                          | Banco                                         |
// +---------------------------------------------------------------------------------+
// |  Agência                        | Agência                                       |
// +---------------------------------------------------------------------------------+
// |  Conta                          | Conta                                         |
// +---------------------------------------------------------------------------------+
// |  Código da Loja                 | Código da loja onde a venda foi capturada     |
// +---------------------------------------------------------------------------------+
// |  Código do Estabelecimento      | Código do Estabelecimento junto a Boa Vista   |
// +---------------------------------------------------------------------------------+
// |  Status                         | Status (Pagamento, Antecipação,  Previsto     |
// +---------------------------------------------------------------------------------+
// |  Valor Liquido                  | Valor Liquido da Parcela                      |
// +---------------------------------------------------------------------------------+
// |  Numero do Cartão               | Número do Cartão                              |
// +---------------------------------------------------------------------------------+

  TRegistroPgto = Record
    strTipReg: String;
    strDtaVen: String;
    strDtaCre: String;
    strNumNSU: String;
    strCodAut: String;
    strTotPar: String;
    strNumPar: String;
    strNomRed: String;
    strNomBan: String;
    strTipTra: String;
    fltValBru: Double;
    fltValTax: Double;
    fltValAnt: Double;
    strNumLot: String;
    strCodBco: String;
    strCodAge: String;
    strNumCco: String;
    strNomLoj: String;
    strCodEst: String;
    strStatus: String;
    fltValLiq: Double;
    strNumCar: String;
    strConcil: String;
    strNomArq: String;
  End;

  TEstruturaPgto = Record
    strDescri: String;
    strTipCmp: String;
  End;

  TArrRegistroBovPgto  = Array Of TRegistroPgto;

  TArrEstruturaBovPgto  = Array Of TEstruturaPgto;

  TBoaVistaPgto = Class(TInterfacedObject, ICartoes)
  Private
    intPosicaoAtual: Integer;
  Public
    constructor Create;

    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(pgbProg: TProgressBar);

    function fRetVal(strVal: Variant; blnData: Boolean = False): Variant;
    function fValidaBaixa(strValor1, strValor2 : String) : Boolean;
    function fGetDados(strValor: String; blnFlt: Boolean = False; intCasas: Integer = 0): Variant;

    function fStrDesc(arrDescri : TArrEstruturaBovPgto; strTipo : String) : String;
    function fCriaEstCar(qryDados : IDataSet) : Variant;

    class function fRetSQLTabelaRegPgto(strTabela: String): String;
    class function fRetEstruturaPgto(strTabela: String): TArrEstruturaBovPgto;
  End;

Var
  strNomArq: String;

implementation

uses untFuncoes, untBoaVista;

{ TBoaVistaPgto }

{************************************************}
{* RETORNA A ESTRUTURA DA  TABELA  DE PAGAMENTO *}
{* CON_COPGTO                                   *}
{*********************************************AJ*}
constructor TBoaVistaPgto.Create;
begin
  intPosicaoAtual := 1;
end;

class function TBoaVistaPgto.fRetEstruturaPgto(strTabela: String): TArrEstruturaBovPgto;
Begin
  If strTabela <> 'BOV_BOPGTO' Then
    Exit;

  SetLength(Result, 23);

  Result[0].strDescri  := 'BOV_DTAVEN'; Result[0].strTipCmp  := 'DATE'  ;
  Result[1].strDescri  := 'BOV_DTACRE'; Result[1].strTipCmp  := 'DATE'  ;
  Result[2].strDescri  := 'BOV_NUMNSU'; Result[2].strTipCmp  := 'VARCHAR(12)' ;
  Result[3].strDescri  := 'BOV_CODAUT'; Result[3].strTipCmp  := 'VARCHAR(12)'  ;
  Result[4].strDescri  := 'BOV_TOTPAR'; Result[4].strTipCmp  := 'VARCHAR(2)'  ;
  Result[5].strDescri  := 'BOV_NUMPAR'; Result[5].strTipCmp  := 'VARCHAR(2)'  ;
  Result[6].strDescri  := 'BOV_NOMRED'; Result[6].strTipCmp  := 'VARCHAR(50)'  ;
  Result[7].strDescri  := 'BOV_NOMBAN'; Result[7].strTipCmp  := 'VARCHAR(50)' ;
  Result[8].strDescri  := 'BOV_TIPTRA'; Result[8].strTipCmp  := 'VARCHAR(25)';
  Result[9].strDescri  := 'BOV_VALBRU'; Result[9].strTipCmp  := 'DECIMAL(15,2)' ;
  Result[10].strDescri := 'BOV_VALTAX'; Result[10].strTipCmp := 'DECIMAL(15,2)' ;
  Result[11].strDescri := 'BOV_VALANT'; Result[11].strTipCmp := 'DECIMAL(15,2)' ;
  Result[12].strDescri := 'BOV_NUMLOT'; Result[12].strTipCmp := 'VARCHAR(30)'  ;
  Result[13].strDescri := 'BOV_CODBCO'; Result[13].strTipCmp := 'VARCHAR(5)';
  Result[14].strDescri := 'BOV_CODAGE'; Result[14].strTipCmp := 'VARCHAR(7)' ;
  Result[15].strDescri := 'BOV_NUMCCO'; Result[15].strTipCmp := 'VARCHAR(15)' ;
  Result[16].strDescri := 'BOV_NOMLOJ'; Result[16].strTipCmp := 'VARCHAR(50)' ;
  Result[17].strDescri := 'BOV_CODEST'; Result[17].strTipCmp := 'VARCHAR(20)' ;
  Result[18].strDescri := 'BOV_STATUS'; Result[18].strTipCmp := 'VARCHAR(3)'  ;
  Result[19].strDescri := 'BOV_VALLIQ'; Result[19].strTipCmp := 'DECIMAL(15,2)' ;
  Result[20].strDescri := 'BOV_NUMCAR'; Result[20].strTipCmp := 'VARCHAR(25)' ;
  Result[21].strDescri := 'BOV_CONCIL'; Result[21].strTipCmp := 'VARCHAR(1)';
  Result[22].strDescri := 'BOV_NOMARQ'; Result[22].strTipCmp := 'VARCHAR(255)';
End;

class function TBoaVistaPgto.fRetSQLTabelaRegPgto(strTabela: String): String;
Var arrCampos: TArrEstruturaBovPgto;
    intCont  : Integer;
begin
  Result := 'CREATE TABLE ' + strTabela + '(';
  arrCampos := fRetEstruturaPgto(strTabela);

  For intCont := 0 to Length(arrCampos) - 1 do
    Result := Result + arrCampos[intCont].strDescri + ' ' + arrCampos[intCont].strTipCmp + ', ';

  Result := Result + 'PRIMARY KEY(BOV_DTAVEN, BOV_NUMNSU, BOV_CODAUT, BOV_NUMPAR, BOV_CODEST)) ENGINE INNODB ' ;
end;

procedure TBoaVistaPgto.pAdicionaLinha(strString: String);
Const
  AUMENTO_CAPACIDADE_FREG  = 2000;

Var
  lstCampos: TStringList;
  intPos   : Integer;
begin
  If intPosicaoAtual >= Length(FRegBovPgto) - 1 Then
    SetLength(FRegBovPgto, Length(FRegBovPgto)+AUMENTO_CAPACIDADE_FREG);

  lstCampos := TStringList.Create;
  lstCampos.Delimiter     := ';';
  lstCampos.DelimitedText := StringReplace(strString, ' ', '_', [rfReplaceAll]);

  FRegBovPgto[intPosicaoAtual-1].strDtaVen := fGetDados(lstCampos[0]);
  FRegBovPgto[intPosicaoAtual-1].strDtaCre := fGetDados(lstCampos[1]);
  FRegBovPgto[intPosicaoAtual-1].strNumNsu := fGetDados(lstCampos[2]);
  FRegBovPgto[intPosicaoAtual-1].strCodAut := fGetDados(lstCampos[3]);
  FRegBovPgto[intPosicaoAtual-1].strTotPar := fGetDados(lstCampos[4]);
  FRegBovPgto[intPosicaoAtual-1].strNumPar := fGetDados(lstCampos[5]);
  FRegBovPgto[intPosicaoAtual-1].strNomRed := fGetDados(lstCampos[6]);
  FRegBovPgto[intPosicaoAtual-1].strNomBan := fGetDados(lstCampos[7]);
  FRegBovPgto[intPosicaoAtual-1].strTipTra := fGetDados(lstCampos[8]);
  FRegBovPgto[intPosicaoAtual-1].fltValBru := fGetDados(lstCampos[9], True, 2);
  FRegBovPgto[intPosicaoAtual-1].fltValTax := fGetDados(lstCampos[10], True, 2);
  FRegBovPgto[intPosicaoAtual-1].fltValAnt := fGetDados(lstCampos[11], True, 2);
  FRegBovPgto[intPosicaoAtual-1].strNumLot := fGetDados(lstCampos[12]);
  FRegBovPgto[intPosicaoAtual-1].strCodBco := fGetDados(lstCampos[14]);
  FRegBovPgto[intPosicaoAtual-1].strCodAge := fGetDados(lstCampos[15]);
  FRegBovPgto[intPosicaoAtual-1].strNumCco := fGetDados(lstCampos[16]);
  FRegBovPgto[intPosicaoAtual-1].strNomLoj := fGetDados(lstCampos[18]);
  FRegBovPgto[intPosicaoAtual-1].strCodEst := fGetDados(lstCampos[19]);
  FRegBovPgto[intPosicaoAtual-1].strStatus := fGetDados(lstCampos[20]);
  FRegBovPgto[intPosicaoAtual-1].strCodEst := fGetDados(lstCampos[19]);
  FRegBovPgto[intPosicaoAtual-1].fltValLiq := fGetDados(lstCampos[21], True, 2);
  FRegBovPgto[intPosicaoAtual-1].strNumCar := fGetDados(lstCampos[23]);
  FRegBovPgto[intPosicaoAtual-1].strConcil := '0';
  FRegBovPgto[intPosicaoAtual-1].strNomArq := strNomArq;

  Inc(intPosicaoAtual);
  intPos := lstEstabel.IndexOf(fGetDados(lstCampos[19]));
  If intPos < 0 Then
    lstEstabel.Add(fGetDados(lstCampos[19]));
end;

procedure TBoaVistaPgto.pGravarRegistros(pgbProg: TProgressBar);
  Var
    qryDados : IDataSet;
    intCont  : Integer;
    strSQL   : String;
    arrCampos: TArrEstruturaBovPgto;
begin
  strSQL    := 'REPLACE INTO BOV_BOPGTO (';
  arrCampos := fRetEstruturaPgto('BOV_BOPGTO');

  strSQL := strSQL + fStrDesc(arrCampos, 'P');

  strSQL := Copy(strSQL, 1, Length(strSQL) - 1) + ') VALUES (';

  strSQL := strSQL + fStrDesc(arrCampos, 'V');

  strSQL := Copy(strSQL, 1, Length(strSQL) - 1) + ')';

  qryDados := objFunctions.fGetDataSet;
  qryDados.Close;
  qryDados.SQL := strSQL;

  pgbProg.Position := 0;

  If Length(FRegBovPgto) > 0 Then
  Begin
    pgbProg.Max      := Length(FRegBovPgto)-1;
    For intCont := 0 To Length(FRegBovPgto)-1 Do
    Begin
      if fValidaBaixa(FRegBovPgto[intCont].strDtaCre, FRegBovPgto[intCont].strStatus) then //*
      Begin
        Application.ProcessMessages;
        qryDados.Close;

        qryDados.ParamByName('BOV_DTAVEN').Value   := fRetVal(FRegBovPgto[intCont].strDtaVen, True);
        qryDados.ParamByName('BOV_DTACRE').Value   := fRetVal(FRegBovPgto[intCont].strDtaCre, True);

        qryDados.ParamByName('BOV_NUMNSU').Value   := fRetVal(FRegBovPgto[intCont].strNumNsu);
        If fEmptyStr(FRegBovPgto[intCont].strNumNsu) Then
          qryDados.ParamByName('BOV_NUMNSU').Value := '  ';

        qryDados.ParamByName('BOV_CODAUT').Value := fRetVal(FRegBovPgto[intCont].strCodAut);
        If fEmptyStr(FRegBovPgto[intCont].strCodAut) Then
          qryDados.ParamByName('BOV_CODAUT').Value := '  ';

        qryDados.ParamByName('BOV_TOTPAR').Value   := fRetVal(FRegBovPgto[intCont].strTotPar);

        qryDados.ParamByName('BOV_NUMPAR').Value := fRetVal(FRegBovPgto[intCont].strNumPar);
        If fEmptyStr(FRegBovPgto[intCont].strNumPar) Then
          qryDados.ParamByName('BOV_NUMPAR').Value := '  ';

        qryDados.ParamByName('BOV_NOMRED').Value   := fRetVal(FRegBovPgto[intCont].strNomRed);
        qryDados.ParamByName('BOV_NOMBAN').Value   := fRetVal(FRegBovPgto[intCont].strNomBan);
        qryDados.ParamByName('BOV_TIPTRA').Value   := fRetVal(FRegBovPgto[intCont].strTipTra);
        qryDados.ParamByName('BOV_VALBRU').Value   := fRetVal(FRegBovPgto[intCont].fltValBru);
        qryDados.ParamByName('BOV_VALTAX').Value   := fRetVal(FRegBovPgto[intCont].fltValTax);
        qryDados.ParamByName('BOV_VALANT').Value   := fRetVal(FRegBovPgto[intCont].fltValAnt);
        qryDados.ParamByName('BOV_NUMLOT').Value   := fRetVal(FRegBovPgto[intCont].strNumLot);
        qryDados.ParamByName('BOV_CODBCO').Value   := fRetVal(FRegBovPgto[intCont].strCodBco);
        qryDados.ParamByName('BOV_CODAGE').Value   := fRetVal(FRegBovPgto[intCont].strCodAge);
        qryDados.ParamByName('BOV_NUMCCO').Value   := fRetVal(FRegBovPgto[intCont].strNumCCO);
        qryDados.ParamByName('BOV_NOMLOJ').Value   := fRetVal(FRegBovPgto[intCont].strNomLoj);
        qryDados.ParamByName('BOV_CODEST').Value   := fRetVal(FRegBovPgto[intCont].strCodEst);
        qryDados.ParamByName('BOV_STATUS').Value   := fRetVal(FRegBovPgto[intCont].strStatus);
        qryDados.ParamByName('BOV_VALLIQ').Value   := fRetVal(FRegBovPgto[intCont].fltValLiq);
        qryDados.ParamByName('BOV_NUMCAR').Value   := fRetVal(FRegBovPgto[intCont].strNumCar);
        qryDados.ParamByName('BOV_NOMARQ').Value   := fRetVal(FRegBovPgto[intCont].strNomArq);

        qryDados.ExecSQL;
      End;

      pgbProg.Position := pgbProg.Position + 1;
    End;

    fCriaEstCar(qryDados);
  End;
end;

function TBoaVistaPgto.fRetVal(strVal: Variant; blnData: Boolean = False): Variant;
Begin
  If fEmptyStr(strVal) Then Result := Null
  Else
  Begin
    If blnData Then
    Begin
      If Length(strVal) = 8 Then
        Result := Copy(strVal, 1, 4) + '/' + Copy(strVal, 5, 2) + '/' + Copy(strVal, 7, 2)
      Else
        Result := Copy(strVal, 1, 2) + '/' + Copy(strVal, 3, 2) + '/' + Copy(strVal, 5, 2);
    End
    else
      Result := strVal;
  End;
End;

function TBoaVistaPgto.fStrDesc(arrDescri: TArrEstruturaBovPgto; strTipo : String): String;
var
  intCont: Integer;
  strSQL, strCaract: String;
begin
  strCaract := '';
  if strTipo = 'V' then
    strCaract := ':';

  For intCont := 0 to Length(arrDescri) - 1 do
    If (arrDescri[intCont].strDescri <> 'BOV_CONCIL') Then
      strSQL := strSQL + strCaract + arrDescri[intCont].strDescri + ',';

  Result := strSQL;
end;

function TBoaVistaPgto.fValidaBaixa(strValor1, strValor2: String): Boolean;
begin
  Result := False;

  if strValor1 = '' then
    Exit;

  if strValor2 = '0' then
    Exit;

  Result := True;
end;

function TBoaVistaPgto.fCriaEstCar(qryDados: IDataSet): Variant;
var
  intCont : Integer;
begin
  Try
    qryDados.Close;
    qryDados.SQL := 'REPLACE INTO ESTCAR (CAR_CODEST, CAR_NOMOPE) VALUES (:ESTAB, "BOA VISTA")';
    For intCont := 0 To lstEstabel.Count - 1 Do
    Begin
      qryDados.ParamByName('ESTAB').AsString := lstEstabel[intCont];
      qryDados.ExecSQL;
    End;
  Except
    Raise Exception.Create('A tabela ESTCAR não foi criada. Entre em contato com a Citel!');
  End;
end;

function TBoaVistaPgto.fGetDados(strValor: String; blnFlt: Boolean = False; intCasas: Integer = 0): Variant;
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

end.
