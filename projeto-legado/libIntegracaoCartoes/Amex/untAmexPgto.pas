{**********************************}
{* Importação de arquivos da AMEX *}
{*******************************AJ*}
unit untAmexPgto;

interface

uses Classes, StrUtils, SysUtils, Variants, untIIntegracaoCartoes, ComCtrls, Dialogs, Forms;

Type
// +---------------------------------------------------------------------------------+
// |                      CRITÉRIOS DE EDIÇÃO DOS DADOS                              |
// +---------------------------------------------------------------------------------+
// |  Tipo do registro               | “1” = Pagamentos                              |
// +---------------------------------------------------------------------------------+
// |  Cod Estabelecimento            | Código do Estabelecimento junto a AMEX        |
// +---------------------------------------------------------------------------------+
// |  Data do Pagamento              | Data do pagamento//previsão da transação      |
// +---------------------------------------------------------------------------------+
// |  Valor Líquido PG               | Valor Líquido da transação                    |
// +---------------------------------------------------------------------------------+
// |  Código do Banco                | Código do Banco onde será realizado o Pgto    |
// +---------------------------------------------------------------------------------+
// |  Código da Agéncia              | Código da Agêcnia onde será realizado o Pgto  |
// +---------------------------------------------------------------------------------+
// |  Número da Conta Corrente       | Número da Conta onde será realizado o Pgto    |
// +---------------------------------------------------------------------------------+
// |  Código da Moeda                | "091"=Real - "001"=Dólar                      |
// +---------------------------------------------------------------------------------+
// |  Valor Bruto PG                 | Valor Bruto do Pgto                           |
// +---------------------------------------------------------------------------------+
// |  Valor de Desconto PG           | Valor de Desconto do Pgto                     |
// +---------------------------------------------------------------------------------+
// |  Encargos da Antecipação PG     | Encargos de Antecipação do Pgto               |
// +---------------------------------------------------------------------------------+
// |  Tipo de Lançamento             | "P" = Pagamento - "F" = Lançamento Futuro     |
// +---------------------------------------------------------------------------------+
// |  Número do RO                   | Número do RO                                  |
// +---------------------------------------------------------------------------------+
// |  Valor Bruto RO                 | Valor Bruto do RO                             |
// +---------------------------------------------------------------------------------+
// |  Valor de Desconto RO           | Valor de Desconto do Ro                       |
// +---------------------------------------------------------------------------------+
// |  Encargos da Antecipação RO     | Encargos de Antecipação do RO                 |
// +---------------------------------------------------------------------------------+
// |  Valor Líquido RO               | Valor Líquido RO (Valor-Valor Des-Valor Ant)  |
// +---------------------------------------------------------------------------------+
// |  Total de Parcelas              | Total de Parcelas da Venda                    |
// +---------------------------------------------------------------------------------+
// |  Número da Antecipação          | Número da Antecipação                         |
// +---------------------------------------------------------------------------------+
// |  Data da Antecipação            | Data do Pagamento da Antecipação              |
// +---------------------------------------------------------------------------------+
// |  Código da Autorização          | Código da Autorização do CV (CCD)             |
// +---------------------------------------------------------------------------------+
// |  Número do Cartão               | Número do Cartão do CV                        |
// +---------------------------------------------------------------------------------+
// |  Valor da Venda                 | Valor Total da Venda                          |
// +---------------------------------------------------------------------------------+
// |  Valor da Primeira Parcela      | Valor da Primeira Parcela da Venda            |
// +---------------------------------------------------------------------------------+
// |  Valor das Demais Parcelas      | Valor das Demais Parcelas da Venda            |
// +---------------------------------------------------------------------------------+
// |  Total de Parcelas              | Total de Parcelas da Venda                    |
// +---------------------------------------------------------------------------------+
// |  Número da Parcela              | Parcela que está sendo paga                   |
// +---------------------------------------------------------------------------------+
// |  Número do NSU                  | Número do NSU com 9 Dígitos                   |
// +---------------------------------------------------------------------------------+
// |  Número do NSU REF              | Número do NSU com 15 Dígitos                  |
// +---------------------------------------------------------------------------------+
// |  Nome do Arquivo                | Nome do Arquivo importado                     |
// +---------------------------------------------------------------------------------+
// |  Data do Arquivo                | Data do Arquivo importado                     |
// +---------------------------------------------------------------------------------+

  TRegistroPgto = Record
    strNumReg: String;
    strCodEst: String;
    strDtaPag: String;
    fltPG_Liq: Double;
    strCodBco: String;
    strCodAge: String;
    strNumCco: String;
    strCodMoe: String;
    fltPG_Bru: Double;
    fltPG_Des: Double;
    fltPG_Ant: Double;
    strTipLan: String;
    strNum_RO: String;
    fltRO_Bru: Double;
    fltRO_Des: Double;
    fltRO_Liq: Double;
    strNumAnt: String;
    strRoDtAn: String;
    fltRO_Ant: Double;
    fltROORLi: Double;
    strDtaCad: String;
    strCodAut: String;
    strNumCar: String;
    fltValVen: Double;
    fltValPri: Double;
    fltValDem: Double;
    strTotPar: String;
    strNumPar: String;
    strNumNSU: String;
    strNSURef: String;
    strNomArq: String;
    strDtaArq: String;
  End;

  TEstruturaPgto = Record
    strDescri: String;
    strTipCmp: String;
  End;

  TArrRegistroAmexPgto  = Array Of TRegistroPgto;

  TArrEstruturaAmexPgto  = Array Of TEstruturaPgto;

  TAmexPgto = Class(TInterfacedObject, ICartoes)
  Private
    dtaArq,
    strRegAnt: String;
  Public
    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(pgbProg: TProgressBar);

    class function fRetSQLTabelaRegPgto(strTabela: String): String;
    class function fRetEstruturaPgto(strTabela: String): TArrEstruturaAmexPgto;
  End;

Var
  strNomArq: String;

implementation

uses untFuncoes, untIDataSet, untAmex;

{ TAmexPgto }

{**********************************************}
{* RETORNA A ESTRUTURA DA  TABELA  DE CRÉDITO *}
{* AME_AMPGTO                                 *}
{*******************************************AJ*}
class function TAmexPgto.fRetEstruturaPgto(strTabela: String): TArrEstruturaAmexPgto;
Begin
  If strTabela = 'AME_AMPGTO' Then Begin
    SetLength(Result, 33);

    Result[0].strDescri  := 'AME_CODEST'; Result[0].strTipCmp  := 'VARCHAR(10)'  ;
    Result[1].strDescri  := 'AME_TIPREG'; Result[1].strTipCmp  := 'VARCHAR(1)'   ;
    Result[2].strDescri  := 'AME_DTAPAG'; Result[2].strTipCmp  := 'DATE'         ;
    Result[3].strDescri  := 'AME_PG_LIQ'; Result[3].strTipCmp  := 'DECIMAL(15,2)';
    Result[4].strDescri  := 'AME_CODBCO'; Result[4].strTipCmp  := 'VARCHAR(9)'   ;
    Result[5].strDescri  := 'AME_CODAGE'; Result[5].strTipCmp  := 'VARCHAR(6)'   ;
    Result[6].strDescri  := 'AME_NUMCCO'; Result[6].strTipCmp  := 'VARCHAR(20)'  ;
    Result[7].strDescri  := 'AME_CODMOE'; Result[7].strTipCmp  := 'VARCHAR(3)'   ;
    Result[8].strDescri  := 'AME_PG_BRU'; Result[8].strTipCmp  := 'DECIMAL(15,2)';
    Result[9].strDescri  := 'AME_PG_DES'; Result[9].strTipCmp  := 'DECIMAL(15,2)';
    Result[10].strDescri := 'AME_PG_ANT'; Result[10].strTipCmp := 'DECIMAL(15,2)';
    Result[11].strDescri := 'AME_TIPLAN'; Result[11].strTipCmp := 'VARCHAR(1)'   ;
    Result[12].strDescri := 'AME_NUM_RO'; Result[12].strTipCmp := 'VARCHAR(16)'  ;
    Result[13].strDescri := 'AME_RO_BRU'; Result[13].strTipCmp := 'DECIMAL(15,2)';
    Result[14].strDescri := 'AME_RO_DES'; Result[14].strTipCmp := 'DECIMAL(15,2)';
    Result[15].strDescri := 'AME_RO_LIQ'; Result[15].strTipCmp := 'DECIMAL(15,2)';
    Result[16].strDescri := 'AME_NUMANT'; Result[16].strTipCmp := 'VARCHAR(9)'   ;
    Result[17].strDescri := 'AME_RODTAN'; Result[17].strTipCmp := 'DATE'         ;
    Result[18].strDescri := 'AME_RO_ANT'; Result[18].strTipCmp := 'DECIMAL(15,2)';
    Result[19].strDescri := 'AME_ROORLI'; Result[19].strTipCmp := 'DECIMAL(15,2)';
    Result[20].strDescri := 'AME_DTACAD'; Result[20].strTipCmp := 'DATE'         ;
    Result[21].strDescri := 'AME_CODAUT'; Result[21].strTipCmp := 'VARCHAR(6)'   ;
    Result[22].strDescri := 'AME_NUMCAR'; Result[22].strTipCmp := 'VARCHAR(19)'  ;
    Result[23].strDescri := 'AME_VALVEN'; Result[23].strTipCmp := 'DECIMAL(15,2)';
    Result[24].strDescri := 'AME_VALPRI'; Result[24].strTipCmp := 'DECIMAL(15,2)';
    Result[25].strDescri := 'AME_VALDEM'; Result[25].strTipCmp := 'DECIMAL(15,2)';
    Result[26].strDescri := 'AME_QTDPAR'; Result[26].strTipCmp := 'VARCHAR(2)'   ;
    Result[27].strDescri := 'AME_NUMPAR'; Result[27].strTipCmp := 'VARCHAR(2)'   ;
    Result[28].strDescri := 'AME_NUMNSU'; Result[28].strTipCmp := 'VARCHAR(9)'   ;
    Result[29].strDescri := 'AME_NSUREF'; Result[29].strTipCmp := 'VARCHAR(15)'  ;
    Result[30].strDescri := 'AME_NOMARQ'; Result[30].strTipCmp := 'VARCHAR(255)' ;
    Result[31].strDescri := 'AME_DTAARQ'; Result[31].strTipCmp := 'DATE'         ;
    Result[32].strDescri := 'AME_CONCIL'; Result[32].strTipCmp := 'VARCHAR(1) DEFAULT "0"';
  End;
End;

class function TAmexPgto.fRetSQLTabelaRegPgto(strTabela: String): String;
Var arrCampos: TArrEstruturaAmexPgto;
    intCont  : Integer;
begin
  Result := 'CREATE TABLE ' + strTabela + '(';
  arrCampos := fRetEstruturaPgto(strTabela);

  For intCont := 0 to Length(arrCampos) - 1 do
    Result := Result + arrCampos[intCont].strDescri + ' ' + arrCampos[intCont].strTipCmp + ', ';

  Result := Result + ' PRIMARY KEY(AME_CODEST,AME_DTAPAG,AME_TIPLAN,AME_NUM_RO,AME_CODAUT,AME_NUMPAR)) ENGINE INNODB ' ;
end;

procedure TAmexPgto.pAdicionaLinha(strString: String);
Var
  lstCampos: TStringList;

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
  lstCampos.Delimiter     := ',';
  lstCampos.DelimitedText := StringReplace(strString, ' ', EmptyStr, [rfReplaceAll]);

  If Not Assigned(lstEstabel) Then
    lstEstabel := TStringList.Create;

  If lstCampos[5] = '0' Then
    dtaArq    := lstCampos[7]
  Else If (lstCampos[5] = '1') Or (lstCampos[5] = '3') Or (lstCampos[5] = '4') Or (lstCampos[5] = '5') Then
  Begin
    If ((lstCampos[5] = '1') Or (lstCampos[5] = '5') Or
       ((strRegAnt = '4') And ((lstCampos[5] = '1') Or (lstCampos[5] = '3') Or (lstCampos[5] = '4')))) Then
      SetLength(FRegAmexPgto, Length(FRegAmexPgto) + 1);

    If (lstCampos[5] = '1') Then
    Begin
      FRegAmexPgto[Length(FRegAmexPgto)-1].strNumReg := '1';
      FRegAmexPgto[Length(FRegAmexPgto)-1].strDtaPag := fGetDados(lstCampos[1]);
      FRegAmexPgto[Length(FRegAmexPgto)-1].fltPG_Liq := fGetDados(lstCampos[7], True, 2);
      FRegAmexPgto[Length(FRegAmexPgto)-1].strCodBco := fGetDados(lstCampos[8]);
      FRegAmexPgto[Length(FRegAmexPgto)-1].strCodAge := fGetDados(lstCampos[9]);
      FRegAmexPgto[Length(FRegAmexPgto)-1].strNumCco := fGetDados(lstCampos[10]);
      FRegAmexPgto[Length(FRegAmexPgto)-1].strCodMoe := fGetDados(lstCampos[12]);
      FRegAmexPgto[Length(FRegAmexPgto)-1].fltPG_Bru := fGetDados(lstCampos[14], True, 2);
      FRegAmexPgto[Length(FRegAmexPgto)-1].fltPG_Des := fGetDados(lstCampos[15], True, 2);
      FRegAmexPgto[Length(FRegAmexPgto)-1].fltPG_Ant := fGetDados(lstCampos[17], True, 2);
      FRegAmexPgto[Length(FRegAmexPgto)-1].strTipLan := fGetDados(lstCampos[19]);
      FRegAmexPgto[Length(FRegAmexPgto)-1].strDtaArq := dtaArq;
      FRegAmexPgto[Length(FRegAmexPgto)-1].strNomArq := strNomArq;
    End
    Else If (lstCampos[5] = '3') Then
    Begin
      If (strRegAnt = '4') Then
      Begin
        FRegAmexPgto[Length(FRegAmexPgto)-1].strNumReg := FRegAmexPgto[Length(FRegAmexPgto)-2].strNumReg;
        FRegAmexPgto[Length(FRegAmexPgto)-1].strDtaPag := FRegAmexPgto[Length(FRegAmexPgto)-2].strDtaPag;
        FRegAmexPgto[Length(FRegAmexPgto)-1].fltPG_Liq := FRegAmexPgto[Length(FRegAmexPgto)-2].fltPG_Liq;
        FRegAmexPgto[Length(FRegAmexPgto)-1].strCodBco := FRegAmexPgto[Length(FRegAmexPgto)-2].strCodBco;
        FRegAmexPgto[Length(FRegAmexPgto)-1].strCodAge := FRegAmexPgto[Length(FRegAmexPgto)-2].strCodAge;
        FRegAmexPgto[Length(FRegAmexPgto)-1].strNumCco := FRegAmexPgto[Length(FRegAmexPgto)-2].strNumCco;
        FRegAmexPgto[Length(FRegAmexPgto)-1].strCodMoe := FRegAmexPgto[Length(FRegAmexPgto)-2].strCodMoe;
        FRegAmexPgto[Length(FRegAmexPgto)-1].fltPG_Bru := FRegAmexPgto[Length(FRegAmexPgto)-2].fltPG_Bru;
        FRegAmexPgto[Length(FRegAmexPgto)-1].fltPG_Des := FRegAmexPgto[Length(FRegAmexPgto)-2].fltPG_Des;
        FRegAmexPgto[Length(FRegAmexPgto)-1].fltPG_Ant := FRegAmexPgto[Length(FRegAmexPgto)-2].fltPG_Ant;
        FRegAmexPgto[Length(FRegAmexPgto)-1].strTipLan := FRegAmexPgto[Length(FRegAmexPgto)-2].strTipLan;
        FRegAmexPgto[Length(FRegAmexPgto)-1].strDtaArq := FRegAmexPgto[Length(FRegAmexPgto)-2].strDtaArq;
        FRegAmexPgto[Length(FRegAmexPgto)-1].strNomArq := FRegAmexPgto[Length(FRegAmexPgto)-2].strNomArq;
      End;

      FRegAmexPgto[Length(FRegAmexPgto)-1].strCodEst := fGetDados(lstCampos[3]);
      FRegAmexPgto[Length(FRegAmexPgto)-1].strNum_RO := fGetDados(lstCampos[8]);
      FRegAmexPgto[Length(FRegAmexPgto)-1].fltRO_Bru := fGetDados(lstCampos[10], True, 2);
      FRegAmexPgto[Length(FRegAmexPgto)-1].fltRO_Des := fGetDados(lstCampos[11], True, 2);
      FRegAmexPgto[Length(FRegAmexPgto)-1].fltRO_Liq := fGetDados(lstCampos[14], True, 2);
      FRegAmexPgto[Length(FRegAmexPgto)-1].strNumAnt := fGetDados(lstCampos[19]);
      FRegAmexPgto[Length(FRegAmexPgto)-1].strRoDtAn := fGetDados(lstCampos[21]);
      FRegAmexPgto[Length(FRegAmexPgto)-1].fltRO_Ant := fGetDados(lstCampos[23], True, 2);
      FRegAmexPgto[Length(FRegAmexPgto)-1].fltROORLi := fGetDados(lstCampos[24], True, 2);
    End
    Else If (lstCampos[5] = '4') Then
    Begin
      If (strRegAnt = '4') Then
      Begin
        FRegAmexPgto[Length(FRegAmexPgto)-1].strNumReg := FRegAmexPgto[Length(FRegAmexPgto)-2].strNumReg;
        FRegAmexPgto[Length(FRegAmexPgto)-1].strDtaPag := FRegAmexPgto[Length(FRegAmexPgto)-2].strDtaPag;
        FRegAmexPgto[Length(FRegAmexPgto)-1].fltPG_Liq := FRegAmexPgto[Length(FRegAmexPgto)-2].fltPG_Liq;
        FRegAmexPgto[Length(FRegAmexPgto)-1].strCodBco := FRegAmexPgto[Length(FRegAmexPgto)-2].strCodBco;
        FRegAmexPgto[Length(FRegAmexPgto)-1].strCodAge := FRegAmexPgto[Length(FRegAmexPgto)-2].strCodAge;
        FRegAmexPgto[Length(FRegAmexPgto)-1].strNumCco := FRegAmexPgto[Length(FRegAmexPgto)-2].strNumCco;
        FRegAmexPgto[Length(FRegAmexPgto)-1].strCodMoe := FRegAmexPgto[Length(FRegAmexPgto)-2].strCodMoe;
        FRegAmexPgto[Length(FRegAmexPgto)-1].fltPG_Bru := FRegAmexPgto[Length(FRegAmexPgto)-2].fltPG_Bru;
        FRegAmexPgto[Length(FRegAmexPgto)-1].fltPG_Des := FRegAmexPgto[Length(FRegAmexPgto)-2].fltPG_Des;
        FRegAmexPgto[Length(FRegAmexPgto)-1].fltPG_Ant := FRegAmexPgto[Length(FRegAmexPgto)-2].fltPG_Ant;
        FRegAmexPgto[Length(FRegAmexPgto)-1].strTipLan := FRegAmexPgto[Length(FRegAmexPgto)-2].strTipLan;
        FRegAmexPgto[Length(FRegAmexPgto)-1].strDtaArq := FRegAmexPgto[Length(FRegAmexPgto)-2].strDtaArq;
        FRegAmexPgto[Length(FRegAmexPgto)-1].strNomArq := FRegAmexPgto[Length(FRegAmexPgto)-2].strNomArq;
        FRegAmexPgto[Length(FRegAmexPgto)-1].strCodEst := FRegAmexPgto[Length(FRegAmexPgto)-2].strCodEst;
        FRegAmexPgto[Length(FRegAmexPgto)-1].strNum_RO := FRegAmexPgto[Length(FRegAmexPgto)-2].strNum_RO;
        FRegAmexPgto[Length(FRegAmexPgto)-1].fltRO_Bru := FRegAmexPgto[Length(FRegAmexPgto)-2].fltRO_Bru;
        FRegAmexPgto[Length(FRegAmexPgto)-1].fltRO_Des := FRegAmexPgto[Length(FRegAmexPgto)-2].fltRO_Des;
        FRegAmexPgto[Length(FRegAmexPgto)-1].fltRO_Liq := FRegAmexPgto[Length(FRegAmexPgto)-2].fltRO_Liq;
        FRegAmexPgto[Length(FRegAmexPgto)-1].strNumAnt := FRegAmexPgto[Length(FRegAmexPgto)-2].strNumAnt;
        FRegAmexPgto[Length(FRegAmexPgto)-1].strRoDtAn := FRegAmexPgto[Length(FRegAmexPgto)-2].strRoDtAn;
        FRegAmexPgto[Length(FRegAmexPgto)-1].fltRO_Ant := FRegAmexPgto[Length(FRegAmexPgto)-2].fltRO_Ant;
        FRegAmexPgto[Length(FRegAmexPgto)-1].fltROORLi := FRegAmexPgto[Length(FRegAmexPgto)-2].fltROORLi;
      End;

      FRegAmexPgto[Length(FRegAmexPgto)-1].strDtaCad := fGetDados(lstCampos[7]);
      FRegAmexPgto[Length(FRegAmexPgto)-1].strNumNSU := fGetDados(lstCampos[8]);
      FRegAmexPgto[Length(FRegAmexPgto)-1].strCodAut := fGetDados(lstCampos[9]);
      FRegAmexPgto[Length(FRegAmexPgto)-1].strNumCar := fGetDados(lstCampos[10]);
      FRegAmexPgto[Length(FRegAmexPgto)-1].fltValVen := fGetDados(lstCampos[11], True, 2);
      FRegAmexPgto[Length(FRegAmexPgto)-1].fltValPri := fGetDados(lstCampos[12], True, 2);
      FRegAmexPgto[Length(FRegAmexPgto)-1].fltValDem := fGetDados(lstCampos[13], True, 2);
      FRegAmexPgto[Length(FRegAmexPgto)-1].strTotPar := fGetDados(lstCampos[14]);
      FRegAmexPgto[Length(FRegAmexPgto)-1].strNumPar := fGetDados(lstCampos[15]);
      FRegAmexPgto[Length(FRegAmexPgto)-1].strNSURef := fGetDados(lstCampos[18]);
    End
    Else If lstCampos[5] = '5' Then
    Begin
      FRegAmexPgto[Length(FRegAmexPgto)-1].strNumReg := fGetDados(lstCampos[5]);
      FRegAmexPgto[Length(FRegAmexPgto)-1].strDtaPag := fGetDados(lstCampos[1]);
      FRegAmexPgto[Length(FRegAmexPgto)-1].fltPG_Liq := fGetDados(lstCampos[12], True, 2);
      FRegAmexPgto[Length(FRegAmexPgto)-1].strCodBco := '';
      FRegAmexPgto[Length(FRegAmexPgto)-1].strCodAge := '';
      FRegAmexPgto[Length(FRegAmexPgto)-1].strNumCco := '';
      FRegAmexPgto[Length(FRegAmexPgto)-1].strCodMoe := fGetDados(lstCampos[16]);
      FRegAmexPgto[Length(FRegAmexPgto)-1].fltPG_Bru := fGetDados(lstCampos[8], True, 2);
      FRegAmexPgto[Length(FRegAmexPgto)-1].fltPG_Des := fGetDados(lstCampos[9], True, 2);
      FRegAmexPgto[Length(FRegAmexPgto)-1].fltPG_Ant := fGetDados(lstCampos[31], True, 2);
      FRegAmexPgto[Length(FRegAmexPgto)-1].strTipLan := 'A';
      FRegAmexPgto[Length(FRegAmexPgto)-1].strDtaArq := dtaArq;
      FRegAmexPgto[Length(FRegAmexPgto)-1].strNomArq := strNomArq;
      FRegAmexPgto[Length(FRegAmexPgto)-1].strCodEst := fGetDados(lstCampos[0]);
      FRegAmexPgto[Length(FRegAmexPgto)-1].strNum_RO := fGetDados(lstCampos[7]);
      FRegAmexPgto[Length(FRegAmexPgto)-1].fltRO_Bru := fGetDados(lstCampos[21], True, 2);
      FRegAmexPgto[Length(FRegAmexPgto)-1].fltRO_Des := 0;
      FRegAmexPgto[Length(FRegAmexPgto)-1].fltRO_Liq := 0;
      FRegAmexPgto[Length(FRegAmexPgto)-1].strNumAnt := fGetDados(lstCampos[17]);
      FRegAmexPgto[Length(FRegAmexPgto)-1].strRoDtAn := fGetDados(lstCampos[1]);
      FRegAmexPgto[Length(FRegAmexPgto)-1].fltRO_Ant := fGetDados(lstCampos[21], True, 2);
      FRegAmexPgto[Length(FRegAmexPgto)-1].fltROORLi := fGetDados(lstCampos[21], True, 2);

      FRegAmexPgto[Length(FRegAmexPgto)-1].strDtaCad := fGetDados(lstCampos[1]);
      If (fGetDados(lstCampos[23]) <> '') And (StrtoInt(fGetDados(lstCampos[23])) <> 0) Then
        FRegAmexPgto[Length(FRegAmexPgto)-1].strNumNSU := fGetDados(lstCampos[23])
      Else
        FRegAmexPgto[Length(FRegAmexPgto)-1].strNumNSU := RightStr(FRegAmexPgto[Length(FRegAmexPgto)-1].strNum_RO, 10);

      FRegAmexPgto[Length(FRegAmexPgto)-1].strCodAut := fGetDados(lstCampos[9]);
      FRegAmexPgto[Length(FRegAmexPgto)-1].strNumCar := fGetDados(lstCampos[13]);
      FRegAmexPgto[Length(FRegAmexPgto)-1].fltValVen := fGetDados(lstCampos[21], True, 2);
      FRegAmexPgto[Length(FRegAmexPgto)-1].fltValPri := fGetDados(lstCampos[12], True, 2);
      FRegAmexPgto[Length(FRegAmexPgto)-1].fltValDem := fGetDados(lstCampos[12], True, 2);
      FRegAmexPgto[Length(FRegAmexPgto)-1].strTotPar := '01';
      FRegAmexPgto[Length(FRegAmexPgto)-1].strNumPar := '01';
      If (fGetDados(lstCampos[25]) <> '') And (StrtoInt(fGetDados(lstCampos[25])) <> 0) Then
        FRegAmexPgto[Length(FRegAmexPgto)-1].strNSURef := fGetDados(lstCampos[25])
      Else
        FRegAmexPgto[Length(FRegAmexPgto)-1].strNSURef := FRegAmexPgto[Length(FRegAmexPgto)-1].strNum_RO;
    End;

    If (FRegAmexPgto[Length(FRegAmexPgto)-1].strCodEst <> '') And
       (lstEstabel.IndexOf(FRegAmexPgto[Length(FRegAmexPgto)-1].strCodEst) < 0) Then
      lstEstabel.Add(FRegAmexPgto[Length(FRegAmexPgto)-1].strCodEst);

    strRegAnt := lstCampos[5];
  End;
end;

procedure TAmexPgto.pGravarRegistros(pgbProg: TProgressBar);
  Var
    qryDados : IDataSet;
    intCont  : Integer;
    strSQL   : String;
    arrCampos: TArrEstruturaAmexPgto;

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
  strSQL :=          'REPLACE INTO AME_AMPGTO (';
  arrCampos := fRetEstruturaPgto('AME_AMPGTO');
  For intCont := 0 to Length(arrCampos) - 1 do
    If (arrCampos[intCont].strDescri <> 'AME_CONCIL') Then
      strSQL := strSQL + arrCampos[intCont].strDescri + ',';
  strSQL := Copy(strSQL, 1, Length(strSQL) - 1) + ') VALUES (';
  For intCont := 0 to Length(arrCampos) - 1 do
    If (arrCampos[intCont].strDescri <> 'AME_CONCIL') Then
      strSQL := strSQL + ':' + arrCampos[intCont].strDescri + ',';
  strSQL := Copy(strSQL, 1, Length(strSQL) - 1) + ')';

  qryDados := objFunctions.fGetDataSet;
  qryDados.Close;
  qryDados.SQL := strSQL;

  pgbProg.Position := 0;

  If Length(FRegAmexPgto) > 0 Then
  Begin
    pgbProg.Max      := Length(FRegAmexPgto)-1;
    For intCont := 0 To Length(FRegAmexPgto)-1 Do
    Begin
      If (FRegAmexPgto[intCont].fltRO_Bru > 0) Or (FRegAmexPgto[intCont].strNumReg = '5') Then
      Begin
        Application.ProcessMessages;
        With qryDados Do
        Begin
          Close;

          ParamByName('AME_TIPREG').Value   := fRetVal(FRegAmexPgto[intCont].strNumReg);
          ParamByName('AME_CODEST').Value   := fRetVal(FRegAmexPgto[intCont].strCodEst);
          ParamByName('AME_DTAPAG').Value   := fRetVal(FRegAmexPgto[intCont].strDtaPag, True);
          ParamByName('AME_PG_LIQ').Value   := fRetVal(FRegAmexPgto[intCont].fltPG_Liq);
          ParamByName('AME_CODBCO').Value   := fRetVal(FRegAmexPgto[intCont].strCodBco);
          ParamByName('AME_CODAGE').Value   := fRetVal(FRegAmexPgto[intCont].strCodAge);
          ParamByName('AME_NUMCCO').Value   := fRetVal(FRegAmexPgto[intCont].strNumCco);
          ParamByName('AME_CODMOE').Value   := fRetVal(FRegAmexPgto[intCont].strCodMoe);
          ParamByName('AME_PG_BRU').Value   := fRetVal(FRegAmexPgto[intCont].fltPG_Bru);
          ParamByName('AME_PG_DES').Value   := fRetVal(FRegAmexPgto[intCont].fltPG_Des);
          If (FRegAmexPgto[intCont].fltPG_Ant > 0) Then
            ParamByName('AME_PG_ANT').Value   := fRetVal(FRegAmexPgto[intCont].fltPG_Ant);
          ParamByName('AME_TIPLAN').Value   := fRetVal(FRegAmexPgto[intCont].strTipLan);
          ParamByName('AME_NUM_RO').Value   := fRetVal(FRegAmexPgto[intCont].strNum_RO);
          ParamByName('AME_RO_BRU').Value   := fRetVal(FRegAmexPgto[intCont].fltRO_Bru);
          ParamByName('AME_RO_DES').Value   := fRetVal(FRegAmexPgto[intCont].fltRO_Des);
          ParamByName('AME_RO_LIQ').Value   := fRetVal(FRegAmexPgto[intCont].fltRO_Liq);
          If (StrtoInt(FRegAmexPgto[intCont].strNumAnt) <> 0) Then
            ParamByName('AME_NUMANT').Value   := fRetVal(FRegAmexPgto[intCont].strNumAnt);
          If (StrtoInt(FRegAmexPgto[intCont].strRoDtAn) <> 0) Then
            ParamByName('AME_RODTAN').Value   := fRetVal(FRegAmexPgto[intCont].strRoDtAn, True);
          If (FRegAmexPgto[intCont].fltRO_Ant > 0) Then
            ParamByName('AME_RO_ANT').Value   := fRetVal(FRegAmexPgto[intCont].fltRO_Ant);
          If (FRegAmexPgto[intCont].fltRoOrLi > 0) Then
            ParamByName('AME_ROORLI').Value   := fRetVal(FRegAmexPgto[intCont].fltRoOrLi);
          ParamByName('AME_DTACAD').Value   := fRetVal(FRegAmexPgto[intCont].strDtaCad, True);
          ParamByName('AME_CODAUT').Value   := fRetVal(FRegAmexPgto[intCont].strCodAut);
          ParamByName('AME_NUMCAR').Value   := fRetVal(FRegAmexPgto[intCont].strNumCar);
          ParamByName('AME_VALVEN').Value   := fRetVal(FRegAmexPgto[intCont].fltValVen);
          ParamByName('AME_VALPRI').Value   := fRetVal(FRegAmexPgto[intCont].fltValPri);
          ParamByName('AME_VALDEM').Value   := fRetVal(FRegAmexPgto[intCont].fltValDem);
          ParamByName('AME_QTDPAR').Value   := RightStr(fRetVal(FRegAmexPgto[intCont].strTotPar), 2);
          ParamByName('AME_NUMPAR').Value   := RightStr(fRetVal(FRegAmexPgto[intCont].strNumPar), 2);
          ParamByName('AME_NUMNSU').Value   := RightStr(fRetVal(FRegAmexPgto[intCont].strNumNSU), 10);
          ParamByName('AME_NSUREF').Value   := RightStr(fRetVal(FRegAmexPgto[intCont].strNSURef), 11);
          ParamByName('AME_NOMARQ').Value   := fRetVal(FRegAmexPgto[intCont].strNomArq);
          ParamByName('AME_DTAARQ').Value   := fRetVal(FRegAmexPgto[intCont].strDtaArq, True);

          ExecSQL;
        End;
      End;

      pgbProg.Position := pgbProg.Position + 1;
    End;

    Try
      qryDados.Close;
      qryDados.SQL := 'REPLACE INTO ESTCAR (CAR_CODEST, CAR_NOMOPE) VALUES (:ESTAB, "AMEX")';
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

end.
