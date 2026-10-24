unit untRedeDebito;
{********************************************}
{* Versão do arquivo (V1.04 – 07/10 – EEVD) *}
{*                                          *}
{* Obs: Caso modifique a vs, colocar aqui a *}
{* nova versão.                             *}
{*****************************************AF*}

interface

uses Classes, StrUtils, SysUtils, Variants, untIIntegracaoCartoes, ComCtrls, Forms;

Type
  {***************************************}
  {* Se modificar esse record, modificar *}
  {* modificar também fRetSQLTabelaReg5  *}
  {************************************AF*}
  TRegistro5 = Record
    strTipReg: String;  // 1ª 002 Num. Tipo de registro
    strNum_PV: String;  // 2ª 009 Num. N.º de filiação do Ponto de Venda
    strNum_RV: String;  // 3ª 009 Num. N.º do Resumo de Vendas
    strDta_CV: String;  // 4ª 008 Num. Data do CV (DDMMAAAA)
    fltValBru: Double;  // 5ª 015 9(13)V99 Valor bruto (para o Compre e Saque, este campo será
                        //                 composto pelo “Valor da Compra” + “Valor do Saque”)
    fltValDes: Double;  // 6ª 015 9(13)V99 Valor desconto
    fltValLiq: Double;  // 7ª 015 9(13)V99 Valor líquido
    strNumCar: String;  // 8ª 019 Alfa Número do cartão
    strTipTra: String;  // 9ª 001 Alfa Tipo de transação
    strNum_CV: String;  // 10ª 012 Num. Número do CV
    strDtaCre: String;  // 11ª 008 Num. Data do crédito
    strStsTra: String;  // 12ª 002 Num. Status da transação (01 – acatada)
    strHraTra: String;  // 13ª 006 Num. Hora da transação (HHMMSS)
    strNumTer: String;  // 14ª 008 Alfa Número do terminal
    strTipCap: String;  // 15ª 002 Num. Tipo de captura
    strNumRes: String;  // 16ª 005 Num. Reservado
    fltValCom: Double;  // 17ª 015 9(13)V99 Valor da compra (para o Compre e Saque )
    fltValSaq: Double;  // 18ª 015 9(13)V99 Valor do saque (para o Compre e Saque)
    strCodBan: String;  // 19ª 001 Alfa Bandeira
    strCodAut: String;  // 20ª 007 Num. Código da autorização
    strBaixad: String;  // Se o registro já foi baixado no Autcom "S" ou "N"
    strSeqLot: String;  // Sequencial de controle por lote (6 números + CODEMP)
    strNomArq: String;  // Nome do arquivo importado
    strDtaArq: String;  // Data do arquivo importado
    strDtaImp: String;  // Data da Importação
    strMotAju: String;  // Motivo do Ajuste (Registro 11)
  End;

  TEstruturaReg05 = Record
    strDescri: String;
    strTipCmp: String;
  End;

  TArrRegistro5 = Array Of TRegistro5;
  TArrEstruturaReg05 = Array Of TEstruturaReg05;

  TRedeDebito = Class(TInterfacedObject, ICartoes)
  Private
    intPosicaoAtualFReg5: Integer;
  Public
    constructor Create;
    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(pgbProg: TProgressBar);

    class function fRetSQLTabelaReg5: String;
    class function fRetEstruturaReg05: TArrEstruturaReg05;
  End;

Var
  strNomArq: String;
  strDtaArq: String;
  VersaoMenil: Boolean;
  Contador11: Integer;

implementation

uses untFuncoes, untIDataSet;

{ TRedeDebito }

constructor TRedeDebito.Create;
begin
  intPosicaoAtualFReg5 := 0;
  Contador11 := 0;
end;

{********************************************}
{* RETORNA A ESTRUTURA DA TABELA RED_EVDR05 *}
{*REQ. 32397 02/04/2015*******************JU*}
class function TRedeDebito.fRetEstruturaReg05: TArrEstruturaReg05;
begin
  SetLength(Result, 27);

  Result[0].strDescri  := 'RED_TIPREG'; Result[0].strTipCmp  := 'CHAR(2)'      ;
  Result[1].strDescri  := 'RED_NUM_PV'; Result[1].strTipCmp  := 'VARCHAR(9)'   ;
  Result[2].strDescri  := 'RED_NUM_RV'; Result[2].strTipCmp  := 'VARCHAR(9)'   ;
  Result[3].strDescri  := 'RED_DTA_CV'; Result[3].strTipCmp  := 'DATE'         ;
  Result[4].strDescri  := 'RED_VALBRU'; Result[4].strTipCmp  := 'DECIMAL(13,2)';
  Result[5].strDescri  := 'RED_VALDES'; Result[5].strTipCmp  := 'DECIMAL(13,2)';
  Result[6].strDescri  := 'RED_VALLIQ'; Result[6].strTipCmp  := 'DECIMAL(13,2)';
  Result[7].strDescri  := 'RED_NUMCAR'; Result[7].strTipCmp  := 'VARCHAR(19)'  ;
  Result[8].strDescri  := 'RED_TIPTRA'; Result[8].strTipCmp  := 'CHAR(1)'      ;
  Result[9].strDescri  := 'RED_NUM_CV'; Result[9].strTipCmp  := 'VARCHAR(12)'  ;
  Result[10].strDescri := 'RED_DTACRE'; Result[10].strTipCmp := 'DATE'         ;
  Result[11].strDescri := 'RED_STSTRA'; Result[11].strTipCmp := 'CHAR(2)'      ;
  Result[12].strDescri := 'RED_HRATRA'; Result[12].strTipCmp := 'TIME'         ;
  Result[13].strDescri := 'RED_NUMTER'; Result[13].strTipCmp := 'VARCHAR(8)'   ;
  Result[14].strDescri := 'RED_TIPCAP'; Result[14].strTipCmp := 'CHAR(2)'      ;
  Result[15].strDescri := 'RED_NUMRES'; Result[15].strTipCmp := 'VARCHAR(5)'   ;
  Result[16].strDescri := 'RED_VALCOM'; Result[16].strTipCmp := 'DECIMAL(13,2)';
  Result[17].strDescri := 'RED_VALSAQ'; Result[17].strTipCmp := 'DECIMAL(13,2)';
  Result[18].strDescri := 'RED_CODBAN'; Result[18].strTipCmp := 'CHAR(1)'      ;
  Result[19].strDescri := 'RED_CODAUT'; Result[19].strTipCmp := 'VARCHAR(7)'   ;
  Result[20].strDescri := 'RED_BAIXAD'; Result[20].strTipCmp := 'CHAR(1)'      ;
  Result[21].strDescri := 'RED_SEQLOT'; Result[21].strTipCmp := 'VARCHAR(9)'   ;
  Result[22].strDescri := 'RED_DTAARQ'; Result[22].strTipCmp := 'DATE'         ;
  Result[23].strDescri := 'RED_NOMARQ'; Result[23].strTipCmp := 'VARCHAR(255)' ;
  Result[24].strDescri := 'RED_CONCIL'; Result[24].strTipCmp := 'INTEGER DEFAULT 0';
  Result[25].strDescri := 'RED_DTAIMP'; Result[25].strTipCmp := 'DATE'         ;
  Result[26].strDescri := 'RED_MOTAJU'; Result[26].strTipCmp := 'VARCHAR(28)'  ;


end;

class function TRedeDebito.fRetSQLTabelaReg5: String;
begin
  Result := 'CREATE TABLE RED_EVDR05(                ' +
            '  RED_TIPREG CHAR(02),                  ' +
            '  RED_NUM_PV VARCHAR(09),               ' +
            '  RED_NUM_RV VARCHAR(09),               ' +
            '  RED_DTA_CV DATE,                      ' +
            '  RED_VALBRU DECIMAL(13,2),             ' +
            '  RED_VALDES DECIMAL(13,2),             ' +
            '  RED_VALLIQ DECIMAL(13,2),             ' +
            '  RED_NUMCAR VARCHAR(19),               ' +
            '  RED_TIPTRA CHAR(01),                  ' +
            '  RED_NUM_CV VARCHAR(12),               ' +
            '  RED_DTACRE DATE,                      ' +
            '  RED_STSTRA CHAR(02),                  ' +
            '  RED_HRATRA TIME,                      ' +
            '  RED_NUMTER VARCHAR(08),               ' +
            '  RED_TIPCAP CHAR(02),                  ' +
            '  RED_NUMRES VARCHAR(05),               ' +
            '  RED_VALCOM DECIMAL(13,2),             ' +
            '  RED_VALSAQ DECIMAL(13,2),             ' +
            '  RED_CODBAN CHAR(01),                  ' +
            '  RED_CODAUT VARCHAR(07),               ' +
            '  RED_BAIXAD CHAR(01),                  ' +
            '  RED_SEQLOT VARCHAR(09),               ' +
            '  RED_DTAARQ DATE,                      ' +
            '  RED_NOMARQ VARCHAR(255),              ' +
            '  RED_CONCIL INTEGER DEFAULT 0,         ' +
            '  RED_DTAIMP DATE,                      ' +
            '  RED_MOTAJU VARCHAR(28),               ' +
            '  PRIMARY KEY(RED_NUM_PV,               ' +
            '              RED_NUM_RV,               ' +
            '              RED_NUM_CV,               ' +
            '              RED_TIPREG,               ' +
            '              RED_DTACRE)) ENGINE INNODB';
end;

procedure TRedeDebito.pAdicionaLinha(strString: String);
  Const
    AUMENTO_CAPACIDADE_FREG5 = 2000;
  Var
    intPosVir: Integer;

    LValores : TStringList;

    function fGetDados: String;
    Begin
      intPosVir := Pos(',', strString);
      Result := Copy(strString, 1, intPosVir-1);
    End;

    procedure pProxRegistro;
    Begin
      Delete(strString, 1, intPosVir);
    End;

begin

  If intPosicaoAtualFReg5 = Length(FReg5) Then
  Begin
    SetLength(FReg5, Length(FReg5)+AUMENTO_CAPACIDADE_FREG5);
  End;

  If Not Assigned(lstEstabel) Then
    lstEstabel := TStringList.Create;

  If LeftStr(strString, 2) = '05' Then
  Begin

    FReg5[intPosicaoAtualFReg5].strTipReg := fGetDados; pProxRegistro;
    FReg5[intPosicaoAtualFReg5].strNum_PV := fGetDados; pProxRegistro;
    FReg5[intPosicaoAtualFReg5].strNum_RV := fGetDados; pProxRegistro;
    FReg5[intPosicaoAtualFReg5].strDta_CV := fGetDados; pProxRegistro;
    FReg5[intPosicaoAtualFReg5].fltValBru := fStrToFloat(fGetDados)/100; pProxRegistro;
    FReg5[intPosicaoAtualFReg5].fltValDes := fStrToFloat(fGetDados)/100; pProxRegistro;
    FReg5[intPosicaoAtualFReg5].fltValLiq := fStrToFloat(fGetDados)/100; pProxRegistro;
    FReg5[intPosicaoAtualFReg5].strNumCar := fGetDados; pProxRegistro;
    FReg5[intPosicaoAtualFReg5].strTipTra := fGetDados; pProxRegistro;
    FReg5[intPosicaoAtualFReg5].strNum_CV := fGetDados; pProxRegistro;
    FReg5[intPosicaoAtualFReg5].strDtaCre := fGetDados; pProxRegistro;
    FReg5[intPosicaoAtualFReg5].strStsTra := fGetDados; pProxRegistro;
    FReg5[intPosicaoAtualFReg5].strHraTra := fGetDados; pProxRegistro;
    FReg5[intPosicaoAtualFReg5].strNumTer := fGetDados; pProxRegistro;
    FReg5[intPosicaoAtualFReg5].strTipCap := fGetDados; pProxRegistro;
    FReg5[intPosicaoAtualFReg5].strNumRes := fGetDados; pProxRegistro;
    FReg5[intPosicaoAtualFReg5].fltValCom := fStrToFloat(fGetDados)/100; pProxRegistro;
    FReg5[intPosicaoAtualFReg5].fltValSaq := fStrToFloat(fGetDados)/100; pProxRegistro;
    FReg5[intPosicaoAtualFReg5].strCodBan := fGetDados; pProxRegistro;
    FReg5[intPosicaoAtualFReg5].strCodAut := fGetDados; pProxRegistro;
    FReg5[intPosicaoAtualFReg5].strBaixad := 'N';
    FReg5[intPosicaoAtualFReg5].strSeqLot := '';
    FReg5[intPosicaoAtualFReg5].strNomArq := strNomArq;
    FReg5[intPosicaoAtualFReg5].strDtaArq := strDtaArq;
    FReg5[intPosicaoAtualFReg5].strDtaImp := FormatDateTime('yyyy-mm-dd', nOw);

    If (FReg5[intPosicaoAtualFReg5].strNum_PV <> '') And
       (lstEstabel.IndexOf(FReg5[intPosicaoAtualFReg5].strNum_PV) < 0) Then
      lstEstabel.Add(FReg5[intPosicaoAtualFReg5].strNum_PV);

    Inc(intPosicaoAtualFReg5);
  End;

  If Not VersaoMenil Then
    Exit;

  If LeftStr(strString, 3) = '011' Then
  Begin
    Inc(Contador11);

    LValores := TStringList.Create;
    LValores.StrictDelimiter := True;
    LValores.Delimiter := ',';
    LValores.DelimitedText := strString;

    FReg5[intPosicaoAtualFReg5].strTipReg := RightStr(LValores[0], 2);
    FReg5[intPosicaoAtualFReg5].strNum_PV := LValores[1];
    FReg5[intPosicaoAtualFReg5].strNum_RV := LValores[2];
    FReg5[intPosicaoAtualFReg5].strDtaCre := LValores[3];
    FReg5[intPosicaoAtualFReg5].fltValBru := fStrToFloat(LValores[4])/100;
    FReg5[intPosicaoAtualFReg5].strTipTra := LValores[5];
    FReg5[intPosicaoAtualFReg5].strMotAju := LValores[7];
    FReg5[intPosicaoAtualFReg5].strNumCar := LValores[8];
    FReg5[intPosicaoAtualFReg5].strDta_CV := LValores[9];
    FReg5[intPosicaoAtualFReg5].fltValLiq := fStrToFloat(LValores[4])/100;
    FReg5[intPosicaoAtualFReg5].strNum_CV := LeftStr('000000000000', 12 - Length(IntToStr(Contador11))) + IntToStr(Contador11);

    If Not MatchStr(LValores[18], ['', '00000000']) Then
      FReg5[intPosicaoAtualFReg5].strDtaCre := LValores[18];

    FReg5[intPosicaoAtualFReg5].strStsTra := LValores[17];
    FReg5[intPosicaoAtualFReg5].strHraTra := '00:00:00';
    FReg5[intPosicaoAtualFReg5].strNumTer := '';
    FReg5[intPosicaoAtualFReg5].strTipCap := '';
    FReg5[intPosicaoAtualFReg5].strNumRes := LValores[10];
    FReg5[intPosicaoAtualFReg5].fltValCom := 0.00;
    FReg5[intPosicaoAtualFReg5].fltValSaq := 0.00;
    FReg5[intPosicaoAtualFReg5].strCodBan := LValores[28];
    FReg5[intPosicaoAtualFReg5].strCodAut := LValores[22];
    FReg5[intPosicaoAtualFReg5].strBaixad := 'N';
    FReg5[intPosicaoAtualFReg5].strSeqLot := '';
    FReg5[intPosicaoAtualFReg5].fltValDes := 0.00;
    FReg5[intPosicaoAtualFReg5].strNomArq := strNomArq;
    FReg5[intPosicaoAtualFReg5].strDtaArq := strDtaArq;
    FReg5[intPosicaoAtualFReg5].strDtaImp := FormatDateTime('yyyy-mm-dd', nOw);

    If (FReg5[intPosicaoAtualFReg5].strNum_PV <> '') And
       (lstEstabel.IndexOf(FReg5[intPosicaoAtualFReg5].strNum_PV) < 0) Then
      lstEstabel.Add(FReg5[intPosicaoAtualFReg5].strNum_PV);

    Inc(intPosicaoAtualFReg5);

    FreeAndNil(LValores);
  End;

end;

procedure TRedeDebito.pGravarRegistros(pgbProg: TProgressBar);
  Var
    qryDados: IDataSet;
    intCont : Integer;

  function fRetVal(strVal: String): Variant;
  Begin
    If fEmptyStr(strVal) Then Result := Null
    Else Result := strVal;
  End;

begin
  qryDados := objFunctions.fGetDataSet;
  qryDados.Close;
  qryDados.SQL := 'REPLACE INTO RED_EVDR05 (                                      ' +
                  '  RED_TIPREG, RED_NUM_PV, RED_NUM_RV, RED_DTA_CV, RED_VALBRU, ' +
                  '  RED_VALDES, RED_VALLIQ, RED_NUMCAR, RED_TIPTRA, RED_NUM_CV, ' +
                  '  RED_DTACRE, RED_STSTRA, RED_HRATRA, RED_NUMTER, RED_TIPCAP, ' +
                  '  RED_NUMRES, RED_VALCOM, RED_VALSAQ, RED_CODBAN, RED_CODAUT, ' +
                  '  RED_BAIXAD, RED_SEQLOT, RED_NOMARQ, RED_DTAARQ, RED_DTAIMP, ' +
                  '  RED_MOTAJU) VALUES (                                        ' +
                  '  :TIPREG, :NUM_PV, :NUM_RV, :DTA_CV, :VALBRU,                ' +
                  '  :VALDES, :VALLIQ, :NUMCAR, :TIPTRA, :NUM_CV,                ' +
                  '  :DTACRE, :STSTRA, :HRATRA, :NUMTER, :TIPCAP,                ' +
                  '  :NUMRES, :VALCOM, :VALSAQ, :CODBAN, :CODAUT,                ' +
                  '  :BAIXAD, :SEQLOT, :NOMARQ, :DTAARQ, :DTAIMP,                ' +
                  '  :MOTAJU)                                                    ';

  If Length(FReg5) <= 0 Then
    Exit;

  pgbProg.Position := 0;
  pgbProg.Max      := Length(FReg5)-1;
  For intCont := 0 To Length(FReg5)-1 Do
  Begin
    Application.ProcessMessages;
    If FReg5[intCont].strTipReg <> '' Then
    Begin
      Application.ProcessMessages;
      qryDados.Close;

      Try
        qryDados.ParamByName('TIPREG').Value   := fRetVal(FReg5[intCont].strTipReg);
        qryDados.ParamByName('NUM_PV').Value   := fRetVal(FReg5[intCont].strNum_PV);
        qryDados.ParamByName('NUM_RV').Value   := fRetVal(FReg5[intCont].strNum_RV);
        qryDados.ParamByName('DTA_CV').Value   := fRetData(FReg5[intCont].strDta_CV);
        qryDados.ParamByName('VALBRU').AsFloat := FReg5[intCont].fltValBru;
        qryDados.ParamByName('VALDES').AsFloat := FReg5[intCont].fltValDes;
        qryDados.ParamByName('VALLIQ').AsFloat := FReg5[intCont].fltValLiq;
        qryDados.ParamByName('NUMCAR').Value   := fRetVal(FReg5[intCont].strNumCar);
        qryDados.ParamByName('TIPTRA').Value   := fRetVal(FReg5[intCont].strTipTra);
        qryDados.ParamByName('NUM_CV').Value   := fRetVal(FReg5[intCont].strNum_CV);
        qryDados.ParamByName('DTACRE').Value   := fRetData(FReg5[intCont].strDtaCre);
        qryDados.ParamByName('STSTRA').Value   := fRetVal(FReg5[intCont].strStsTra);
        qryDados.ParamByName('HRATRA').Value   := fRetHora(FReg5[intCont].strHraTra);
        qryDados.ParamByName('NUMTER').Value   := fRetVal(FReg5[intCont].strNumTer);
        qryDados.ParamByName('TIPCAP').Value   := fRetVal(FReg5[intCont].strTipCap);
        qryDados.ParamByName('NUMRES').Value   := fRetVal(FReg5[intCont].strNumRes);
        qryDados.ParamByName('VALCOM').AsFloat := FReg5[intCont].fltValCom;
        qryDados.ParamByName('VALSAQ').AsFloat := FReg5[intCont].fltValSaq;
        qryDados.ParamByName('CODBAN').Value   := fRetVal(FReg5[intCont].strCodBan);
        qryDados.ParamByName('CODAUT').Value   := fRetVal(FReg5[intCont].strCodAut);
        qryDados.ParamByName('BAIXAD').Value   := fRetVal(FReg5[intCont].strBaixad);
        qryDados.ParamByName('SEQLOT').Value   := fRetVal(FReg5[intCont].strSeqLot);
        qryDados.ParamByName('MOTAJU').Value   := fRetVal(FReg5[intCont].strMotAju);
        qryDados.ParamByName('DTAARQ').Value   := fRetData(FReg5[intCont].strDtaArq);
        qryDados.ParamByName('NOMARQ').Value   := FReg5[intCont].strNomArq;
        qryDados.ParamByName('DTAIMP').Value   := fRetData(FReg5[intCont].strDtaImp);

        qryDados.ExecSQL;
      Except

      End;
    End;

    pgbProg.Position := pgbProg.Position + 1;
  End;

  Try
    qryDados.Close;
    qryDados.SQL := 'REPLACE INTO ESTCAR (CAR_CODEST, CAR_NOMOPE) VALUES (:ESTAB, "REDECARD")';
    For intCont := 0 To lstEstabel.Count - 1 Do
    Begin
      qryDados.ParamByName('ESTAB').AsString := lstEstabel[intCont];
      qryDados.ExecSQL;
    End;
  Except
    Raise Exception.Create('A tabela ESTCAR não foi criada. Entre em contato com a Citel!');
  End;

end;

end.
