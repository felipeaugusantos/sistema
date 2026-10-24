{************************************}
{* Importação de arquivos da GETNET *}
{*********************************AJ*}
unit untGetNetPgto;

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
    strTipReg: String;
    strCodEst: String;
    strNum_RV: String;
    strDta_RV: String;
    strDtaPag: String;
    strCodBco: String;
    strCodAge: String;
    strNumCco: String;
    fltRV_Bru: Double;
    fltRV_Liq: Double;
    fltValTax: Double;
    fltValDes: Double;
    fltValPag: Double;
    fltValEnc: Double;
    strRVNPar: String;
    strRVTPar: String;
    strNumAnt: String;
    strVenOri: String;
    fltLiqAnt: Double;
    strNumNSU: String;
    strDtaTra: String;
    strNumCar: String;
    fltValVen: Double;
    strTotPar: String;
    strNumPar: String;
    fltValPar: Double;
    strCodAut: String;
    strStatus: String;
    strNumTer: String;
    strTipPag: String;
    strNomArq: String;
    strDtaArq: String;
    strMotAju: String;

    Metadado01,
    ContaPagamento,
    IDRecorrencia,
    ConteudoRecorrencia,
    InformacoesAdicionais,

    IdentificadorAjuste,

    VersaoArquivo: String;
  End;

  TEstruturaPgto = Record
    strDescri: String;
    strTipCmp: String;
  End;

  TArrRegistroGetNetPgto  = Array Of TRegistroPgto;

  TArrEstruturaGetNetPgto  = Array Of TEstruturaPgto;

  TGetNetPgto = Class(TInterfacedObject, ICartoes)
  Private
    dtaArq,
    strRegAnt: String;

    FVersaoArquivo: String;

    intPosicaoAtual: Integer;

    FContadorNegociacao: Integer;

    function fRetVal(strVal: Variant; blnData: Boolean = False): Variant;
  Public
    constructor Create;

    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(pgbProg: TProgressBar);

    class function RetornaListaDeCampos(AObjetoCampos: TArrEstruturaGetNetPgto): TStringList;

    class function fRetSQLTabelaRegPgto(strTabela: String): String;
    class function fRetEstruturaPgto(strTabela: String): TArrEstruturaGetNetPgto;
  End;

Var
  strNomArq: String;
  
implementation

uses untFuncoes, untIDataSet, untGetNet;

{ TGetNetPgto }

constructor TGetNetPgto.Create;
Begin
  intPosicaoAtual := 0;
  strRegAnt := '';

  FContadorNegociacao := 0;
End;

{************************************************}
{* RETORNA A ESTRUTURA DA  TABELA  DE PAGAMENTO *}
{* GET_GEPGTO                                   *}
{*********************************************AJ*}
class function TGetNetPgto.fRetEstruturaPgto(strTabela: String): TArrEstruturaGetNetPgto;
Begin
  If strTabela = 'GET_GEPGTO' Then Begin
    SetLength(Result, 51);

    Result[0].strDescri  := 'GET_TIPREG'; Result[0].strTipCmp  := 'VARCHAR(2)'   ;
    Result[1].strDescri  := 'GET_CODEST'; Result[1].strTipCmp  := 'VARCHAR(15)'  ;
    Result[2].strDescri  := 'GET_NUM_RV'; Result[2].strTipCmp  := 'VARCHAR(9)'   ;
    Result[3].strDescri  := 'GET_DTA_RV'; Result[3].strTipCmp  := 'DATE'         ;
    Result[4].strDescri  := 'GET_DTAPAG'; Result[4].strTipCmp  := 'DATE'         ;
    Result[5].strDescri  := 'GET_CODBCO'; Result[5].strTipCmp  := 'VARCHAR(9)'   ;
    Result[6].strDescri  := 'GET_CODAGE'; Result[6].strTipCmp  := 'VARCHAR(6)'   ;
    Result[7].strDescri  := 'GET_NUMCCO'; Result[7].strTipCmp  := 'VARCHAR(11)'  ;
    Result[8].strDescri  := 'GET_RV_BRU'; Result[8].strTipCmp  := 'DECIMAL(15,2)';
    Result[9].strDescri  := 'GET_RV_LIQ'; Result[9].strTipCmp  := 'DECIMAL(15,2)';
    Result[10].strDescri := 'GET_VALTAX'; Result[10].strTipCmp := 'DECIMAL(15,2)';
    Result[11].strDescri := 'GET_VALDES'; Result[11].strTipCmp := 'DECIMAL(15,2)';
    Result[12].strDescri := 'GET_VALPAG'; Result[12].strTipCmp := 'DECIMAL(15,2)';
    Result[13].strDescri := 'GET_VALENC'; Result[13].strTipCmp := 'DECIMAL(15,2)';
    Result[14].strDescri := 'GET_RVNPAR'; Result[14].strTipCmp := 'VARCHAR(2)'   ;
    Result[15].strDescri := 'GET_RVTPAR'; Result[15].strTipCmp := 'VARCHAR(2)'   ;
    Result[16].strDescri := 'GET_NUMANT'; Result[16].strTipCmp := 'VARCHAR(15)'  ;
    Result[17].strDescri := 'GET_VENORI'; Result[17].strTipCmp := 'DATE'         ;
    Result[18].strDescri := 'GET_LIQANT'; Result[18].strTipCmp := 'DECIMAL(15,2)';
    Result[19].strDescri := 'GET_NUMNSU'; Result[19].strTipCmp := 'VARCHAR(12)'  ;
    Result[20].strDescri := 'GET_DTATRA'; Result[20].strTipCmp := 'DATE'         ;
    Result[21].strDescri := 'GET_NUMCAR'; Result[21].strTipCmp := 'VARCHAR(19)'  ;
    Result[22].strDescri := 'GET_VALVEN'; Result[22].strTipCmp := 'DECIMAL(15,2)';
    Result[23].strDescri := 'GET_TOTPAR'; Result[23].strTipCmp := 'VARCHAR(2)'   ;
    Result[24].strDescri := 'GET_NUMPAR'; Result[24].strTipCmp := 'VARCHAR(2)'   ;
    Result[25].strDescri := 'GET_VALPAR'; Result[25].strTipCmp := 'DECIMAL(15,2)';
    Result[26].strDescri := 'GET_CODAUT'; Result[26].strTipCmp := 'VARCHAR(10)'  ;
    Result[27].strDescri := 'GET_STATUS'; Result[27].strTipCmp := 'VARCHAR(1)'   ;
    Result[28].strDescri := 'GET_NUMTER'; Result[28].strTipCmp := 'VARCHAR(8)'   ;
    Result[29].strDescri := 'GET_MOTAJU'; Result[29].strTipCmp := 'VARCHAR(2)'   ;
    Result[30].strDescri := 'GET_NOMARQ'; Result[30].strTipCmp := 'VARCHAR(255)' ;
    Result[31].strDescri := 'GET_DTAARQ'; Result[31].strTipCmp := 'DATE'         ;
    Result[32].strDescri := 'GET_CONCIL'; Result[32].strTipCmp := 'VARCHAR(1) DEFAULT ''0''';
    Result[33].strDescri := 'GET_TIPPAG'; Result[33].strTipCmp := 'VARCHAR(2)'   ;
    Result[34].strDescri := 'GET_METDAD'; Result[34].strTipCmp := 'VARCHAR(2)'   ;
    Result[35].strDescri := 'GET_CONPAG'; Result[35].strTipCmp := 'VARCHAR(20)'   ;
    Result[36].strDescri := 'GET_ID_REC'; Result[36].strTipCmp := 'VARCHAR(2)';
    Result[37].strDescri := 'GET_CONREC'; Result[37].strTipCmp := 'VARCHAR(118)';
    Result[38].strDescri := 'GET_INFADC'; Result[38].strTipCmp := 'VARCHAR(50)';
    Result[39].strDescri := 'GET_IDEAJU'; Result[39].strTipCmp := 'VARCHAR(20)';

    Result[40].strDescri := 'GET_VERARQ'; Result[40].strTipCmp := 'VARCHAR(10)';
    Result[41].strDescri := 'GET_CHA_UR'; Result[41].strTipCmp := 'VARCHAR(25)';
    Result[42].strDescri := 'GET_CODPRO'; Result[42].strTipCmp := 'VARCHAR(2)' ;
    Result[43].strDescri := 'GET_TIPCAP'; Result[43].strTipCmp := 'VARCHAR(3)' ;
    Result[44].strDescri := 'GET_NUMCON'; Result[44].strTipCmp := 'VARCHAR(18)';
    Result[45].strDescri := 'GET_DTACAN'; Result[45].strTipCmp := 'DATE'       ;
    Result[46].strDescri := 'GET_RV_ORI'; Result[46].strTipCmp := 'VARCHAR(9)' ;
    Result[47].strDescri := 'GET_PAGORI'; Result[47].strTipCmp := 'DATE'       ;
    Result[48].strDescri := 'GET_NUMOPE'; Result[48].strTipCmp := 'VARCHAR(20)';
    Result[49].strDescri := 'GET_CANOPE'; Result[49].strTipCmp := 'VARCHAR(3)' ;
    Result[50].strDescri := 'GET_VALMDR'; Result[50].strTipCmp := 'DECIMAL(15,2)' ;
  End;
End;

class function TGetNetPgto.fRetSQLTabelaRegPgto(strTabela: String): String;
Var arrCampos: TArrEstruturaGetNetPgto;
    intCont  : Integer;
begin
  Result := 'CREATE TABLE ' + strTabela + '(';
  arrCampos := fRetEstruturaPgto(strTabela);

  For intCont := 0 to Length(arrCampos) - 1 do
    Result := Result + arrCampos[intCont].strDescri + ' ' + arrCampos[intCont].strTipCmp + ', ';

  Result := Result + ' PRIMARY KEY(GET_TIPREG,GET_CODEST,GET_NUM_RV,GET_DTA_RV,GET_DTAPAG,GET_NUMPAR,GET_CODAUT,GET_NUMNSU,GET_IDEAJU,GET_TIPPAG)) ENGINE INNODB ' ;
end;

procedure TGetNetPgto.pAdicionaLinha(strString: String);
Var
  strOperad: String;
Const
  AUMENTO_CAPACIDADE_FREG  = 2000;

  function fGetDados(intIni, intTam: Integer; blnFlt: Boolean = False): Variant;
    Var
      rst: Variant;
  Begin
    rst := Trim(Copy(strString, intIni, intTam));
    If blnFlt Then rst := fStrToFloat(rst) / 100;

    Result := rst;
  End;

begin
  If intPosicaoAtual >= Length(FRegGetNetPgto) - 1 Then
  Begin
    SetLength(FRegGetNetPgto, Length(FRegGetNetPgto)+AUMENTO_CAPACIDADE_FREG);
  End;

  If Not Assigned(lstEstabel) Then
    lstEstabel := TStringList.Create;

  If fGetDados(001,01) = '0' Then
  Begin
    dtaArq    := fGetDados(002,08);
    strRegAnt := fGetDados(001,01);

    FVersaoArquivo := Trim(fGetDados(100,03));

    FContadorNegociacao := 0;
  End
  Else If (Pos(fGetDados(001,01), '1_2_3_5_') > 0) Then
  Begin
    If (fGetDados(001,01) = '1') Or (fGetDados(001,01) = '5') Or
       (((fGetDados(001,01) = '2') Or (fGetDados(001,01) = '3')) And (strRegAnt <> '1')) Then
      Inc(intPosicaoAtual);

    If (fGetDados(001,01) = '1') Then
    Begin
      FRegGetNetPgto[intPosicaoAtual-1].strTipReg := fGetDados(169,02);
      FRegGetNetPgto[intPosicaoAtual-1].strNum_RV := fGetDados(022,09);
      FRegGetNetPgto[intPosicaoAtual-1].strDta_RV := fGetDados(031,08);
      FRegGetNetPgto[intPosicaoAtual-1].strCodBco := fGetDados(047,03);
      FRegGetNetPgto[intPosicaoAtual-1].strCodAge := fGetDados(050,06);
      FRegGetNetPgto[intPosicaoAtual-1].strNumCco := fGetDados(056,11);
      FRegGetNetPgto[intPosicaoAtual-1].fltRV_Bru := fGetDados(085,12,True);
      FRegGetNetPgto[intPosicaoAtual-1].fltRV_Liq := fGetDados(097,12,True);
      FRegGetNetPgto[intPosicaoAtual-1].fltValTax := fGetDados(109,12,True);
      FRegGetNetPgto[intPosicaoAtual-1].fltValDes := fGetDados(121,12,True);
      FRegGetNetPgto[intPosicaoAtual-1].fltValPag := fGetDados(145,12,True);
      FRegGetNetPgto[intPosicaoAtual-1].fltValEnc := fGetDados(157,12,True);
      FRegGetNetPgto[intPosicaoAtual-1].strRVNPar := fGetDados(171,02);
      FRegGetNetPgto[intPosicaoAtual-1].strRVTPar := fGetDados(173,02);
      FRegGetNetPgto[intPosicaoAtual-1].strNumAnt := fGetDados(190,15);
      FRegGetNetPgto[intPosicaoAtual-1].strVenOri := fGetDados(205,08);
      FRegGetNetPgto[intPosicaoAtual-1].fltLiqAnt := fGetDados(225,12,True);
      FRegGetNetPgto[intPosicaoAtual-1].strTipPag := fGetDados(017,02);
      FRegGetNetPgto[intPosicaoAtual-1].VersaoArquivo := FVersaoArquivo;

      If FVersaoArquivo = '10' Then
      Begin
        FRegGetNetPgto[intPosicaoAtual-1].Metadado01 := fGetDados(287,02);
        FRegGetNetPgto[intPosicaoAtual-1].ContaPagamento := fGetDados(289,20);
      End;

      If (fGetDados(169,02) = 'AC') OR (fGetDados(169,02) = 'CS')Then
      Begin
        FRegGetNetPgto[intPosicaoAtual-1].strDtaPag := fGetDados(039,08);
        FRegGetNetPgto[intPosicaoAtual-1].strCodEst := fGetDados(175,15);
        FRegGetNetPgto[intPosicaoAtual-1].strNumNSU := fGetDados(022,09);
        FRegGetNetPgto[intPosicaoAtual-1].strNumAnt := fGetDados(190,15);
        FRegGetNetPgto[intPosicaoAtual-1].strDtaTra := fGetDados(031,08);
        FRegGetNetPgto[intPosicaoAtual-1].strNumCar := '00000000000000';
        FRegGetNetPgto[intPosicaoAtual-1].fltValVen := fGetDados(085,12,True);
        FRegGetNetPgto[intPosicaoAtual-1].strTotPar := fGetDados(173,02);
        FRegGetNetPgto[intPosicaoAtual-1].strNumPar := fGetDados(171,02);
        FRegGetNetPgto[intPosicaoAtual-1].fltValPar := fGetDados(085,12,True);
        fRegGetNetPgto[intPosicaoAtual-1].fltValPag := fGetDados(225,12,True);
        FRegGetNetPgto[intPosicaoAtual-1].fltValDes := fGetDados(213,12,True);
        FRegGetNetPgto[intPosicaoAtual-1].strCodAut := '00000';
        FRegGetNetPgto[intPosicaoAtual-1].strStatus := 'C';
        FRegGetNetPgto[intPosicaoAtual-1].strNumTer := '00000000';
       // FRegGetNetPgto[intPosicaoAtual-1].strDtaPag := fGetDados(205,08);
      End;

      FRegGetNetPgto[intPosicaoAtual-1].strDtaArq := dtaArq;
      FRegGetNetPgto[intPosicaoAtual-1].strNomArq := strNomArq;
    End
    Else If (fGetDados(001,01) = '2') Or (fGetDados(001,01) = '3') Then
    Begin
      If (strRegAnt = '2') Or (strRegAnt = '3') Then
      Begin
        FRegGetNetPgto[intPosicaoAtual-1].strTipReg := FRegGetNetPgto[intPosicaoAtual-2].strTipReg;
        FRegGetNetPgto[intPosicaoAtual-1].strNum_RV := FRegGetNetPgto[intPosicaoAtual-2].strNum_RV;
        FRegGetNetPgto[intPosicaoAtual-1].strDta_RV := FRegGetNetPgto[intPosicaoAtual-2].strDta_RV;
        FRegGetNetPgto[intPosicaoAtual-1].strCodBco := FRegGetNetPgto[intPosicaoAtual-2].strCodBco;
        FRegGetNetPgto[intPosicaoAtual-1].strCodAge := FRegGetNetPgto[intPosicaoAtual-2].strCodAge;
        FRegGetNetPgto[intPosicaoAtual-1].strNumCco := FRegGetNetPgto[intPosicaoAtual-2].strNumCco;
        FRegGetNetPgto[intPosicaoAtual-1].fltRV_Bru := FRegGetNetPgto[intPosicaoAtual-2].fltRV_Bru;
        FRegGetNetPgto[intPosicaoAtual-1].fltRV_Liq := FRegGetNetPgto[intPosicaoAtual-2].fltRV_Liq;
        FRegGetNetPgto[intPosicaoAtual-1].fltValTax := FRegGetNetPgto[intPosicaoAtual-2].fltValTax;
        FRegGetNetPgto[intPosicaoAtual-1].fltValDes := FRegGetNetPgto[intPosicaoAtual-2].fltValDes;
        FRegGetNetPgto[intPosicaoAtual-1].fltValPag := FRegGetNetPgto[intPosicaoAtual-2].fltValPag;
        FRegGetNetPgto[intPosicaoAtual-1].fltValEnc := FRegGetNetPgto[intPosicaoAtual-2].fltValEnc;
        FRegGetNetPgto[intPosicaoAtual-1].strRVNPar := FRegGetNetPgto[intPosicaoAtual-2].strRVNPar;
        FRegGetNetPgto[intPosicaoAtual-1].strRVTPar := FRegGetNetPgto[intPosicaoAtual-2].strRVTPar;
        FRegGetNetPgto[intPosicaoAtual-1].strNumAnt := FRegGetNetPgto[intPosicaoAtual-2].strNumAnt;
        FRegGetNetPgto[intPosicaoAtual-1].strVenOri := FRegGetNetPgto[intPosicaoAtual-2].strVenOri;
        FRegGetNetPgto[intPosicaoAtual-1].fltLiqAnt := FRegGetNetPgto[intPosicaoAtual-2].fltLiqAnt;
        FRegGetNetPgto[intPosicaoAtual-1].strTipPag := FRegGetNetPgto[intPosicaoAtual-2].strTipPag;
        FRegGetNetPgto[intPosicaoAtual-1].strDtaArq := dtaArq;
        FRegGetNetPgto[intPosicaoAtual-1].strNomArq := strNomArq;

        FRegGetNetPgto[intPosicaoAtual-1].Metadado01 := FRegGetNetPgto[intPosicaoAtual-2].Metadado01;
        FRegGetNetPgto[intPosicaoAtual-1].ContaPagamento := FRegGetNetPgto[intPosicaoAtual-2].ContaPagamento;
      End;

      If (fGetDados(001,01) = '2') Then
      Begin
        FRegGetNetPgto[intPosicaoAtual-1].strDtaPag := fGetDados(123,08);
        FRegGetNetPgto[intPosicaoAtual-1].strCodEst := fGetDados(002,15);
        FRegGetNetPgto[intPosicaoAtual-1].strNumNSU := fGetDados(026,12);
        FRegGetNetPgto[intPosicaoAtual-1].strDtaTra := fGetDados(038,08);
        FRegGetNetPgto[intPosicaoAtual-1].strNumCar := fGetDados(052,19);
        FRegGetNetPgto[intPosicaoAtual-1].fltValVen := fGetDados(071,12,True);
        FRegGetNetPgto[intPosicaoAtual-1].strTotPar := fGetDados(107,02);
        FRegGetNetPgto[intPosicaoAtual-1].strNumPar := fGetDados(109,02);
        FRegGetNetPgto[intPosicaoAtual-1].fltValPar := fGetDados(111,12,True);
        FRegGetNetPgto[intPosicaoAtual-1].strCodAut := fGetDados(131,10);
        FRegGetNetPgto[intPosicaoAtual-1].strStatus := fGetDados(144,01);
        FRegGetNetPgto[intPosicaoAtual-1].strNumTer := fGetDados(160,08);

        If FVersaoArquivo = '10' Then
        Begin
          FRegGetNetPgto[intPosicaoAtual-1].IDRecorrencia := fGetDados(188,02);
          FRegGetNetPgto[intPosicaoAtual-1].ConteudoRecorrencia := fGetDados(190,118);
          FRegGetNetPgto[intPosicaoAtual-1].InformacoesAdicionais := fGetDados(310,50);
        End;
      End
      Else If (fGetDados(001,01) = '3') Then
      Begin
        If fGetDados(134,02) <> 'PF' Then
          FRegGetNetPgto[intPosicaoAtual-1].strTipReg := 'AJ'
        Else
          FRegGetNetPgto[intPosicaoAtual-1].strTipReg := 'AF'; //Ajuste futuro

        FRegGetNetPgto[intPosicaoAtual-1].strDtaPag := fGetDados(034,08);

        FRegGetNetPgto[intPosicaoAtual-1].strCodEst := fGetDados(002,15);
        FRegGetNetPgto[intPosicaoAtual-1].strNum_RV := fGetDados(017,09);
        FRegGetNetPgto[intPosicaoAtual-1].strNumNSU := fGetDados(042,20);
        FRegGetNetPgto[intPosicaoAtual-1].strDtaTra := fGetDados(126,08);
        FRegGetNetPgto[intPosicaoAtual-1].strNumCar := fGetDados(086,19);
        strOperad := fGetDados(063,01);
        FRegGetNetPgto[intPosicaoAtual-1].fltValVen := fGetDados(063,13,True);
        FRegGetNetPgto[intPosicaoAtual-1].strTotPar := FRegGetNetPgto[intPosicaoAtual-1].strRVTPar;
        FRegGetNetPgto[intPosicaoAtual-1].strNumPar := FRegGetNetPgto[intPosicaoAtual-1].strRVNPar;
        FRegGetNetPgto[intPosicaoAtual-1].fltValPar := fGetDados(063,13,True);
        FRegGetNetPgto[intPosicaoAtual-1].strCodAut := '0';
        FRegGetNetPgto[intPosicaoAtual-1].strStatus := fGetDados(144,01);
        FRegGetNetPgto[intPosicaoAtual-1].strNumTer := fGetDados(136,08);
        FRegGetNetPgto[intPosicaoAtual-1].strMotAju := fGetDados(076,02);
        FRegGetNetPgto[intPosicaoAtual-1].strTipPag := fGetDados(134,02);
        FRegGetNetPgto[intPosicaoAtual-1].IdentificadorAjuste := Trim(fGetDados(042,20));

        If strOperad = '-' Then
        Begin
          FRegGetNetPgto[intPosicaoAtual-1].fltRV_Bru := FRegGetNetPgto[intPosicaoAtual-1].fltRV_Bru * (-1);
          FRegGetNetPgto[intPosicaoAtual-1].fltRV_Liq := FRegGetNetPgto[intPosicaoAtual-1].fltRV_Liq * (-1);
          FRegGetNetPgto[intPosicaoAtual-1].fltValPag := FRegGetNetPgto[intPosicaoAtual-1].fltValPag * (-1);
        End;

        If FRegGetNetPgto[intPosicaoAtual-1].strDtaTra = '00000000' Then
           FRegGetNetPgto[intPosicaoAtual-1].strDtaTra := FRegGetNetPgto[intPosicaoAtual-1].strDtaPag;

      End;
    End
    Else If fGetDados(001,01) = '5' Then
    Begin
      Inc(FContadorNegociacao);

      FRegGetNetPgto[intPosicaoAtual-1].strTipReg := 'NR';

      FRegGetNetPgto[intPosicaoAtual-1].strDtaPag := fGetDados(025,08);

      FRegGetNetPgto[intPosicaoAtual-1].strCodEst := fGetDados(002,15);
      FRegGetNetPgto[intPosicaoAtual-1].strNum_RV := RightStr(fGetDados(033,20), 09);
      FRegGetNetPgto[intPosicaoAtual-1].strNumNSU := fGetDados(033,20);
      FRegGetNetPgto[intPosicaoAtual-1].strDtaTra := fGetDados(017,08);
      FRegGetNetPgto[intPosicaoAtual-1].strDta_RV := fGetDados(017,08);
      FRegGetNetPgto[intPosicaoAtual-1].strNumCar := '***';
      FRegGetNetPgto[intPosicaoAtual-1].fltValVen := fGetDados(055,12,True);
      FRegGetNetPgto[intPosicaoAtual-1].strTotPar := '01';
      FRegGetNetPgto[intPosicaoAtual-1].strNumPar := '01';
      FRegGetNetPgto[intPosicaoAtual-1].fltValPar := fGetDados(091,12,True);
      FRegGetNetPgto[intPosicaoAtual-1].strCodAut := IntToStr(FContadorNegociacao);
      FRegGetNetPgto[intPosicaoAtual-1].strStatus := fGetDados(148,01);
      FRegGetNetPgto[intPosicaoAtual-1].strMotAju := Trim(fGetDados(053,02));

      FRegGetNetPgto[intPosicaoAtual-1].fltRV_Bru := fGetDados(055,12,True);
      FRegGetNetPgto[intPosicaoAtual-1].fltRV_Liq := fGetDados(091,12,True);
      FRegGetNetPgto[intPosicaoAtual-1].fltValPag := fGetDados(091,12,True);

      FRegGetNetPgto[intPosicaoAtual-1].strCodBco := fGetDados(116,03);
      FRegGetNetPgto[intPosicaoAtual-1].strCodAge := fGetDados(119,06);
      FRegGetNetPgto[intPosicaoAtual-1].strNumCco := fGetDados(125,20);
      FRegGetNetPgto[intPosicaoAtual-1].fltValTax := fGetDados(079,12,True);
      FRegGetNetPgto[intPosicaoAtual-1].strTipPag := fGetDados(053,02);

      FRegGetNetPgto[intPosicaoAtual-1].strDtaArq := dtaArq;
      FRegGetNetPgto[intPosicaoAtual-1].strNomArq := strNomArq;
      FRegGetNetPgto[intPosicaoAtual-1].VersaoArquivo := FVersaoArquivo;
    End;

    If (FRegGetNetPgto[intPosicaoAtual-1].strCodEst <> '') And
       (lstEstabel.IndexOf(FRegGetNetPgto[intPosicaoAtual-1].strCodEst) < 0) Then
      lstEstabel.Add(FRegGetNetPgto[intPosicaoAtual-1].strCodEst);

    strRegAnt := fGetDados(001,01);
  End;
end;

function TGetNetPgto.fRetVal(strVal: Variant; blnData: Boolean = False): Variant;
Begin
  If fEmptyStr(strVal) Then
    Result := Null
  Else
  Begin
    Result := strVal;
    If blnData Then
      Result := Copy(strVal, 5, 4) + '/' + Copy(strVal, 3, 2) + '/' + Copy(strVal, 1, 2);
  End;
End;

procedure TGetNetPgto.pGravarRegistros(pgbProg: TProgressBar);
  Var
    qryDados : IDataSet;
    intCont  : Integer;
    strSQL   : String;
begin
  strSQL := RetornaSQLReplace('GET_GEPGTO',
                              RetornaListaDeCampos(fRetEstruturaPgto('GET_GEPGTO')),
                              ['GET_CONCIL']);

  qryDados := objFunctions.fGetDataSet;
  qryDados.Close;
  qryDados.SQL := strSQL;

  pgbProg.Position := 0;

  If Length(FRegGetNetPgto) > 0 Then
  Begin
    pgbProg.Max      := Length(FRegGetNetPgto) - 1;
    For intCont := 0 To Length(FRegGetNetPgto) - 1 Do
    Begin
      If (FRegGetNetPgto[intCont].strTipReg <> '') And (FRegGetNetPgto[intCont].strCodEst <> '') And
         (FRegGetNetPgto[intCont].strDtaPag <> '') Then
      Begin
        Application.ProcessMessages;

        qryDados.Close;
        qryDados.ParamByName('GET_TIPREG').Value   := fRetVal(FRegGetNetPgto[intCont].strTipReg);
        qryDados.ParamByName('GET_CODEST').Value   := fRetVal(FRegGetNetPgto[intCont].strCodEst);
        qryDados.ParamByName('GET_NUM_RV').Value   := fRetVal(FRegGetNetPgto[intCont].strNum_RV);
        qryDados.ParamByName('GET_DTA_RV').Value   := fRetVal(FRegGetNetPgto[intCont].strDta_RV, True);
        qryDados.ParamByName('GET_DTAPAG').Value   := fRetVal(FRegGetNetPgto[intCont].strDtaPag, True);
        qryDados.ParamByName('GET_CODBCO').Value   := fRetVal(FRegGetNetPgto[intCont].strCodBco);
        qryDados.ParamByName('GET_CODAGE').Value   := fRetVal(FRegGetNetPgto[intCont].strCodAge);
        qryDados.ParamByName('GET_NUMCCO').Value   := fRetVal(FRegGetNetPgto[intCont].strNumCco);
        qryDados.ParamByName('GET_RV_BRU').Value   := fRetVal(FRegGetNetPgto[intCont].fltRV_Bru);
        qryDados.ParamByName('GET_RV_LIQ').Value   := fRetVal(FRegGetNetPgto[intCont].fltRV_Liq);
        qryDados.ParamByName('GET_VALDES').Value   := fRetVal(FRegGetNetPgto[intCont].fltValDes);
        qryDados.ParamByName('GET_VALTAX').Value   := fRetVal(FRegGetNetPgto[intCont].fltValTax);
        qryDados.ParamByName('GET_VALPAG').Value   := fRetVal(FRegGetNetPgto[intCont].fltValPag);
        qryDados.ParamByName('GET_VALENC').Value   := fRetVal(FRegGetNetPgto[intCont].fltValEnc);
        qryDados.ParamByName('GET_RVNPAR').Value   := fRetVal(FRegGetNetPgto[intCont].strRVNPar);
        qryDados.ParamByName('GET_RVTPAR').Value   := fRetVal(FRegGetNetPgto[intCont].strRVTPar);
        If (FRegGetNetPgto[intCont].strNumAnt <> '') And (StrToInt64(FRegGetNetPgto[intCont].strNumAnt) <> 0) Then
          qryDados.ParamByName('GET_NUMANT').Value   := fRetVal(FRegGetNetPgto[intCont].strNumAnt);
        If (FRegGetNetPgto[intCont].strNumAnt <> '') And (StrToInt64(FRegGetNetPgto[intCont].strNumAnt) <> 0) Then
          qryDados.ParamByName('GET_VENORI').Value   := fRetVal(FRegGetNetPgto[intCont].strVenOri, True);
        If (FRegGetNetPgto[intCont].fltLiqAnt > 0) Then
          qryDados.ParamByName('GET_LIQANT').Value   := fRetVal(FRegGetNetPgto[intCont].fltLiqAnt);
        qryDados.ParamByName('GET_NUMNSU').Value   := fRetVal(FRegGetNetPgto[intCont].strNumNSU);
        qryDados.ParamByName('GET_DTATRA').Value   := fRetVal(FRegGetNetPgto[intCont].strDtaTra, True);
        qryDados.ParamByName('GET_NUMCAR').Value   := fRetVal(FRegGetNetPgto[intCont].strNumCar);
        qryDados.ParamByName('GET_VALVEN').Value   := fRetVal(FRegGetNetPgto[intCont].fltValVen);
        qryDados.ParamByName('GET_TOTPAR').Value   := fRetVal(FRegGetNetPgto[intCont].strTotPar);
        qryDados.ParamByName('GET_NUMPAR').Value   := fRetVal(FRegGetNetPgto[intCont].strNumPar);
        qryDados.ParamByName('GET_VALPAR').Value   := fRetVal(FRegGetNetPgto[intCont].fltValPar);
        qryDados.ParamByName('GET_CODAUT').Value   := fRetVal(FRegGetNetPgto[intCont].strCodAut);
        qryDados.ParamByName('GET_STATUS').Value   := fRetVal(FRegGetNetPgto[intCont].strStatus);
        qryDados.ParamByName('GET_NUMTER').Value   := fRetVal(FRegGetNetPgto[intCont].strNumTer);
        qryDados.ParamByName('GET_TIPPAG').Value   := fRetVal(FRegGetNetPgto[intCont].strTipPag);
        qryDados.ParamByName('GET_MOTAJU').Value   := fRetVal(FRegGetNetPgto[intCont].strMotAju);
        qryDados.ParamByName('GET_NOMARQ').Value   := fRetVal(FRegGetNetPgto[intCont].strNomArq);
        qryDados.ParamByName('GET_DTAARQ').Value   := fRetVal(FRegGetNetPgto[intCont].strDtaArq, True);

        qryDados.ParamByName('GET_METDAD').Value   := fRetVal(FRegGetNetPgto[intCont].Metadado01);
        qryDados.ParamByName('GET_CONPAG').Value   := fRetVal(FRegGetNetPgto[intCont].ContaPagamento);
        qryDados.ParamByName('GET_ID_REC').Value   := fRetVal(FRegGetNetPgto[intCont].IDRecorrencia);
        qryDados.ParamByName('GET_CONREC').Value   := fRetVal(FRegGetNetPgto[intCont].ConteudoRecorrencia);
        qryDados.ParamByName('GET_INFADC').Value   := fRetVal(FRegGetNetPgto[intCont].InformacoesAdicionais);

        Try
          qryDados.ParamByName('GET_IDEAJU').AsString := '';
          If FRegGetNetPgto[intCont].IdentificadorAjuste <> '' Then
            qryDados.ParamByName('GET_IDEAJU').AsString := FRegGetNetPgto[intCont].IdentificadorAjuste;
        Except
          //para que versões mais antigas, sem rodar o script funcionem
        end;

        If qryDados.SQL.Contains('GER_VERARQ') Then
          qryDados.ParamByName('GET_VERARQ').AsString := FRegGetNetPgto[intCont].VersaoArquivo;

        qryDados.ExecSQL;
      End;
      pgbProg.Position := pgbProg.Position + 1;
    End;

    Try
      qryDados.Close;
      qryDados.SQL := 'REPLACE INTO ESTCAR (CAR_CODEST, CAR_NOMOPE) VALUES (:ESTAB, "GETNET")';
      For intCont := 0 To lstEstabel.Count - 1 Do
      Begin
        qryDados.ParamByName('ESTAB').AsString := lstEstabel[intCont];
        qryDados.ExecSQL;
      End;

      FreeAndNil(lstEstabel);
    Except
      Raise Exception.Create('A tabela ESTCAR não foi criada. Entre em contato com a Citel!');
    End;

    pgbProg.Position := Length(FRegGetNetPgto) - 1;
  End;
end;

class function TGetNetPgto.RetornaListaDeCampos(
  AObjetoCampos: TArrEstruturaGetNetPgto): TStringList;
  Var
    LContador: Integer;
begin
  Result := TStringList.Create;

  For LContador := 0 To Length(AObjetoCampos) - 1 Do
    Result.Add(AObjetoCampos[LContador].strDescri);
end;

end.
