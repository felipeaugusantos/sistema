{***************************************}
{* Importação de arquivos da BANESCARD *}
{************************************MT*}
unit untBanesCardPgto;

interface

uses Classes, StrUtils, SysUtils, Variants, untIIntegracaoCartoes, ComCtrls, Dialogs, Forms;

Type

  TRegistroPgto = Record
    strTipReg: String; // Código do registro
    strCodEst: String; // Identificação da Loja
    strNsuTra: String; // NSU Host da transação
    strDtaTra: String; // Data da transação
    strHorTra: String; // Horário da transação
    strTipLan: String; // Tipo de lançamento
    strDtaLan: String; // Data de lançamento
    strDtaAju: String; // Data da transação AJ
    strTipPro: String; // Tipo do Produto
    strTipAju: String; // Tipo De Ajuste
    strMotAju: String; // Motivo Ajuste
    strCodAju: String; // Codigo do Ajuste
    strMeiCap: String; // Meio de Captura
    fltValBru: Double; // Valor Bruto da Venda
    fltValDes: Double; // Valor do Desconto
    fltValLiq: Double; // Valor Líq da Venda
    strNumCar: String; // Número do Cartão
    strNumPar: String; // Número da Parcela
    strTotPar: String; // Número Total de Parcelas
    strNsuPar: String; // NSU Host da parcela
    strNsuAju: String; // NSU Host NSU Host da transação
    fltBruPar: Double; // Valor Bruto da Parcela
    fltDesPar: Double; // Valor do Desconto da Parcela
    fltLiqPar: Double; // Valor Líq da Venda da Parcela
    strCodBco: String; // Banco
    strNumAge: String; // Agencia
    strCodCta: String; // Conta
    strCodAut: String; // Código de Autorização
    strIdeOco: String; // Identificador de Ocorrência
    strNumSeq: String; // Número seqüencial do registro no arquivo
    strDtaArq: String; // Data do Arquivo
    strNomArq: String; // Nome do Arquivo
  End;

  TEstruturaPgto = Record
    strDescri: String;
    strTipCmp: String;
  End;

  TArrRegistroBanesCardPgto  = Array Of TRegistroPgto;

  TArrEstruturaBanesCardPgto  = Array Of TEstruturaPgto;

  TBanesCardPgto = Class(TInterfacedObject, ICartoes)
  Private
    dtaArq,
    strRegAnt: String;
    LString: String;

    intPosicaoAtual: Integer;
    function fGetDados(intIni, intTam: Integer; blnFlt: Boolean = False): Variant;

    function GetIsNotEmpty(AValue1,AValue2 : Variant): Variant;

    function fRetVal(strVal: Variant): Variant;
    procedure ImportaComprovanteDeVenda;
    procedure ImportaAjustes;
  Public
    constructor Create;

    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(pgbProg: TProgressBar);

    class function fRetSQLTabelaRegPgto(strTabela: String): String;
    class function fRetEstruturaPgto(strTabela: String): TArrEstruturaBanesCardPgto;
  End;

Var
  strNomArq: String;

implementation

uses untFuncoes, untIDataSet, untBanesCard;

{ TBanesCardPgto }

constructor TBanesCardPgto.Create;
Begin
  intPosicaoAtual := 0;
  strRegAnt := '';
End;

function TBanesCardPgto.fGetDados(intIni, intTam: Integer;blnFlt: Boolean): Variant;
Var
    rst: Variant;
Begin
  rst := Trim(Copy(LString, intIni, intTam));
  If blnFlt Then rst := fStrToFloat(rst) / 100;

  Result := rst;
End;

{************************************************}
{* RETORNA A ESTRUTURA DA  TABELA  DE PAGAMENTO *}
{* BAN_BAPGTO                                   *}
{*********************************************AJ*}
class function TBanesCardPgto.fRetEstruturaPgto(strTabela: String): TArrEstruturaBanesCardPgto;
Begin
  If strTabela = 'BAN_BAPGTO' Then Begin
    SetLength(Result, 33);

    Result[0].strDescri   := 'BAN_TIPREG'; Result[0].strTipCmp   := 'VARCHAR(2)';
    Result[1].strDescri   := 'BAN_CODEST'; Result[1].strTipCmp   := 'VARCHAR(15)';
    Result[2].strDescri   := 'BAN_NSUTRA'; Result[2].strTipCmp   := 'VARCHAR(12)';
    Result[3].strDescri   := 'BAN_DTATRA'; Result[3].strTipCmp   := 'DATE';
    Result[4].strDescri   := 'BAN_HORTRA'; Result[4].strTipCmp   := 'TIME';
    Result[5].strDescri   := 'BAN_TIPLAN'; Result[5].strTipCmp   := 'VARCHAR(1)';
    Result[6].strDescri   := 'BAN_DTALAN'; Result[6].strTipCmp   := 'DATE';
    Result[7].strDescri   := 'BAN_TIPPRO'; Result[7].strTipCmp   := 'VARCHAR(1)';
    Result[8].strDescri   := 'BAN_MEICAP'; Result[8].strTipCmp   := 'VARCHAR(1)';
    Result[9].strDescri   := 'BAN_VALBRU'; Result[9].strTipCmp   := 'DECIMAL(9,2)';
    Result[10].strDescri  := 'BAN_VALDES'; Result[10].strTipCmp   := 'DECIMAL(9,2)';
    Result[11].strDescri  := 'BAN_VALLIQ'; Result[11].strTipCmp  := 'DECIMAL(9,2)';
    Result[12].strDescri  := 'BAN_NUMCAR'; Result[12].strTipCmp  := 'VARCHAR(19)';
    Result[13].strDescri  := 'BAN_NUMPAR'; Result[13].strTipCmp  := 'VARCHAR(2)';
    Result[14].strDescri  := 'BAN_TOTPAR'; Result[14].strTipCmp  := 'VARCHAR(2)';
    Result[15].strDescri  := 'BAN_NSUPAR'; Result[15].strTipCmp  := 'VARCHAR(12)';
    Result[16].strDescri  := 'BAN_BRUPAR'; Result[16].strTipCmp  := 'DECIMAL(9,2)';
    Result[17].strDescri  := 'BAN_DESPAR'; Result[17].strTipCmp  := 'DECIMAL(9,2)';
    Result[18].strDescri  := 'BAN_LIQPAR'; Result[18].strTipCmp  := 'DECIMAL(9,2)';
    Result[19].strDescri  := 'BAN_CODBCO'; Result[19].strTipCmp  := 'VARCHAR(3)';
    Result[20].strDescri  := 'BAN_NUMAGE'; Result[20].strTipCmp  := 'VARCHAR(6)';
    Result[21].strDescri  := 'BAN_CODCTA'; Result[21].strTipCmp  := 'VARCHAR(11)';
    Result[22].strDescri  := 'BAN_CODAUT'; Result[22].strTipCmp  := 'VARCHAR(12)';
    Result[23].strDescri  := 'BAN_IDEOCO'; Result[23].strTipCmp  := 'VARCHAR(2)';
    Result[24].strDescri  := 'BAN_NUMSEQ'; Result[24].strTipCmp  := 'VARCHAR(6)';
    Result[25].strDescri  := 'BAN_DTAAJU'; Result[25].strTipCmp  := 'DATE';
    Result[26].strDescri  := 'BAN_NSUAJU'; Result[26].strTipCmp  := 'VARCHAR(12)';
    Result[27].strDescri  := 'BAN_TIPAJU'; Result[27].strTipCmp  := 'VARCHAR(1)';
    Result[28].strDescri  := 'BAN_CODAJU'; Result[28].strTipCmp  := 'VARCHAR(3)';
    Result[29].strDescri  := 'BAN_MOTAJU'; Result[29].strTipCmp  := 'VARCHAR(30)';
    Result[30].strDescri  := 'BAN_NOMARQ'; Result[30].strTipCmp  := 'VARCHAR(255)';
    Result[31].strDescri  := 'BAN_DTAARQ'; Result[31].strTipCmp  := 'DATE';
    Result[32].strDescri  := 'BAN_CONCIL'; Result[32].strTipCmp  := 'INT DEFAULT 0';
  End;
End;

class function TBanesCardPgto.fRetSQLTabelaRegPgto(strTabela: String): String;
Var arrCampos: TArrEstruturaBanesCardPgto;
    intCont  : Integer;
begin
  Result := 'CREATE TABLE ' + strTabela + '(';
  arrCampos := fRetEstruturaPgto(strTabela);

  For intCont := 0 to Length(arrCampos) - 1 do
    Result := Result + arrCampos[intCont].strDescri + ' ' + arrCampos[intCont].strTipCmp + ', ';

  Result := Result + ' PRIMARY KEY(BAN_TIPREG,BAN_CODEST,BAN_NSUTRA,BAN_DTATRA,BAN_DTALAN,BAN_NUMPAR,BAN_CODAUT)) ENGINE INNODB ' ;
end;

function TBanesCardPgto.fRetVal(strVal: Variant): Variant;
Begin
  If fEmptyStr(strVal) Then Result := Null
  Else
  Begin
    Result := strVal;
  End;
End;


function TBanesCardPgto.GetIsNotEmpty(AValue1, AValue2: Variant): Variant;
begin
  Try
    Result := AValue1;

   If fEmptyStr(AValue1) Then
     Result := AValue2
   Else If AValue1 <= 0 Then
     Result := AValue2;
  Except
    Begin
      Result := AValue1;
    End;
  End;
end;

procedure TBanesCardPgto.ImportaAjustes;
begin
  Exit;

  Inc(intPosicaoAtual);
  FRegBanesCardPgto[intPosicaoAtual-1].strTipReg := fGetDados(001,02); // Código do registro
  FRegBanesCardPgto[intPosicaoAtual-1].strCodEst := fGetDados(003,15); // Identificação da Loja
  FRegBanesCardPgto[intPosicaoAtual-1].strNsuTra := fGetDados(018,12); // NSU Host da transação original
  FRegBanesCardPgto[intPosicaoAtual-1].strDtaTra := fGetDados(030,08); // Data da transação original
  FRegBanesCardPgto[intPosicaoAtual-1].strNumPar := fGetDados(038,02); // Número da Parcela
  FRegBanesCardPgto[intPosicaoAtual-1].strNsuAju := fGetDados(040,12); // NSU Host da transação  AJ
  FRegBanesCardPgto[intPosicaoAtual-1].strDtaAju := fGetDados(052,08); // Data da transação AJ
  FRegBanesCardPgto[intPosicaoAtual-1].strHorTra := fGetDados(060,06); // Horário da transação
  FRegBanesCardPgto[intPosicaoAtual-1].strTipLan := fGetDados(066,01); // Tipo de lançamento
  FRegBanesCardPgto[intPosicaoAtual-1].strDtaLan := fGetDados(067,08); // Data de lançamento
  FRegBanesCardPgto[intPosicaoAtual-1].strMeiCap := fGetDados(075,01); // Meio de Captura
  FRegBanesCardPgto[intPosicaoAtual-1].strTipAju := fGetDados(076,01); // Tipo de Ajuste
  FRegBanesCardPgto[intPosicaoAtual-1].strCodAju := fGetDados(077,03); // Codigo do Ajuste
  FRegBanesCardPgto[intPosicaoAtual-1].strMotAju := fGetDados(080,30); // Motivo do Ajuste
  FRegBanesCardPgto[intPosicaoAtual-1].fltValBru := fGetDados(110,11,True); // Valor Bruto do ajuste
  FRegBanesCardPgto[intPosicaoAtual-1].fltValDes := fGetDados(121,11,True); // Valor do Desconto
  FRegBanesCardPgto[intPosicaoAtual-1].fltValLiq := fGetDados(132,11,True); // Valor Líq do ajuste
  FRegBanesCardPgto[intPosicaoAtual-1].strCodBco := fGetDados(143,03); // Banco
  FRegBanesCardPgto[intPosicaoAtual-1].strNumAge := fGetDados(146,06); // Agencia
  FRegBanesCardPgto[intPosicaoAtual-1].strCodCta := fGetDados(152,11); // Conta
  FRegBanesCardPgto[intPosicaoAtual-1].strNumCar := fGetDados(163,19); // Número do Cartão
  FRegBanesCardPgto[intPosicaoAtual-1].strNumSeq := fGetDados(182,06); // Número seqüencial do registro no arquivo.
  FRegBanesCardPgto[intPosicaoAtual-1].strDtaArq := dtaArq;
  FRegBanesCardPgto[intPosicaoAtual-1].strNomArq := strNomArq;
end;

procedure TBanesCardPgto.ImportaComprovanteDeVenda;
begin
  Inc(intPosicaoAtual);
  FRegBanesCardPgto[intPosicaoAtual-1].strTipReg := fGetDados(001,02); // Código do registro
  FRegBanesCardPgto[intPosicaoAtual-1].strCodEst := fGetDados(003,15); // Identificação da Loja
  FRegBanesCardPgto[intPosicaoAtual-1].strNsuTra := fGetDados(018,12); // NSU Host da transação
  FRegBanesCardPgto[intPosicaoAtual-1].strDtaTra := fGetDados(030,08); // Data da transação
  FRegBanesCardPgto[intPosicaoAtual-1].strHorTra := fGetDados(038,06); // Horário da transação
  FRegBanesCardPgto[intPosicaoAtual-1].strTipLan := fGetDados(044,01); // Tipo de lançamento
  FRegBanesCardPgto[intPosicaoAtual-1].strDtaLan := fGetDados(045,08); // Data de lançamento
  FRegBanesCardPgto[intPosicaoAtual-1].strTipPro := fGetDados(053,01); // Tipo do Produto
  FRegBanesCardPgto[intPosicaoAtual-1].strMeiCap := fGetDados(054,01); // Meio de Captura
  FRegBanesCardPgto[intPosicaoAtual-1].fltValBru := fGetDados(055,11,True); // Valor Bruto da Venda
  FRegBanesCardPgto[intPosicaoAtual-1].fltValDes := fGetDados(066,11,True); // Valor do Desconto
  FRegBanesCardPgto[intPosicaoAtual-1].fltValLiq := fGetDados(077,11,True); // Valor Líq da Venda
  FRegBanesCardPgto[intPosicaoAtual-1].strNumCar := fGetDados(088,19); // Número do Cartão
  FRegBanesCardPgto[intPosicaoAtual-1].strNumPar := fGetDados(107,02); // Número da Parcela
  FRegBanesCardPgto[intPosicaoAtual-1].strTotPar := fGetDados(109,02); // Número Total de Parcelas
  FRegBanesCardPgto[intPosicaoAtual-1].strNsuPar := GetIsNotEmpty(fGetDados(111,12),fGetDados(018,12)); // NSU Host da parcela
  FRegBanesCardPgto[intPosicaoAtual-1].fltBruPar := GetIsNotEmpty(fGetDados(123,11,True),fGetDados(055,11,True)); // Valor Bruto da Parcela
  FRegBanesCardPgto[intPosicaoAtual-1].fltDesPar := GetIsNotEmpty(fGetDados(134,11,True),fGetDados(066,11,True)); // Valor do Desconto da Parcela
  FRegBanesCardPgto[intPosicaoAtual-1].fltLiqPar := GetIsNotEmpty(fGetDados(145,11,True),fGetDados(077,11,True)); // Valor Líq da Venda da Parcela
  FRegBanesCardPgto[intPosicaoAtual-1].strCodBco := fGetDados(156,03); // Banco
  FRegBanesCardPgto[intPosicaoAtual-1].strNumAge := fGetDados(159,06); // Agencia
  FRegBanesCardPgto[intPosicaoAtual-1].strCodCta := fGetDados(165,11); // Conta
  FRegBanesCardPgto[intPosicaoAtual-1].strCodAut := fGetDados(176,12); // Código de Autorização
  FRegBanesCardPgto[intPosicaoAtual-1].strIdeOco := fGetDados(188,02); // Identificador de Ocorrência
  FRegBanesCardPgto[intPosicaoAtual-1].strNumSeq := fGetDados(190,06); // Número seqüencial do registro no arquivo.
  FRegBanesCardPgto[intPosicaoAtual-1].strDtaArq := dtaArq;
  FRegBanesCardPgto[intPosicaoAtual-1].strNomArq := strNomArq;
end;

procedure TBanesCardPgto.pAdicionaLinha(strString: String);
Const
  AUMENTO_CAPACIDADE_FREG  = 2000;
begin
  LString := strString;

  If intPosicaoAtual >= Length(FRegBanesCardPgto) - 1 Then
  Begin
    SetLength(FRegBanesCardPgto, Length(FRegBanesCardPgto)+AUMENTO_CAPACIDADE_FREG);
  End;

  If Not Assigned(lstEstabel) Then
    lstEstabel := TStringList.Create;

  If fGetDados(001,02) = 'A0' Then // Header do Arquivo
  Begin
    dtaArq    := fGetDados(009,08);
  End
  Else If (fGetDados(001,02) = 'CV') Then // Comprovante de Venda
  Begin
    ImportaComprovanteDeVenda;
  End
  Else If (fGetDados(001,02) = 'AJ') Then // Ajustes
  Begin
    ImportaAjustes;
  End;

  If (intPosicaoAtual > 0)And
     (FRegBanesCardPgto[intPosicaoAtual-1].strCodEst <> '') And
     (lstEstabel.IndexOf(FRegBanesCardPgto[intPosicaoAtual-1].strCodEst) < 0) Then
  Begin
    lstEstabel.Add(FRegBanesCardPgto[intPosicaoAtual-1].strCodEst);
  End;

end;

procedure TBanesCardPgto.pGravarRegistros(pgbProg: TProgressBar);
  Var
    qryDados : IDataSet;
    intCont  : Integer;
    strSQL   : String;
    arrCampos: TArrEstruturaBanesCardPgto;
begin
  arrCampos := fRetEstruturaPgto('BAN_BAPGTO');

  strSQL :=          'REPLACE INTO BAN_BAPGTO (';

  For intCont := 0 to Length(arrCampos) - 1 do
  Begin
    If (arrCampos[intCont].strDescri <> 'BAN_CONCIL') Then
      strSQL := strSQL + arrCampos[intCont].strDescri + ',';
  End;

  strSQL := Copy(strSQL, 1, Length(strSQL) - 1) + ') VALUES (';

  For intCont := 0 to Length(arrCampos) - 1 do
  Begin
    If (arrCampos[intCont].strDescri <> 'BAN_CONCIL') Then
      strSQL := strSQL + ':' + arrCampos[intCont].strDescri + ',';
  End;

  strSQL := Copy(strSQL, 1, Length(strSQL) - 1) + ')';

  qryDados := objFunctions.fGetDataSet;
  qryDados.Close;
  qryDados.SQL := strSQL;

  pgbProg.Position := 0;

  If Length(FRegBanesCardPgto) > 0 Then
  Begin
    pgbProg.Max      := Length(FRegBanesCardPgto) - 1;

    For intCont := 0 To Length(FRegBanesCardPgto) - 1 Do
    Begin
      If (FRegBanesCardPgto[intCont].strTipReg <> '') And (FRegBanesCardPgto[intCont].strCodEst <> '') And
         (FRegBanesCardPgto[intCont].strDtaTra <> '') Then
      Begin
        Application.ProcessMessages;

        qryDados.Close;
        qryDados.ParamByName('BAN_TIPREG').Value   := fRetVal(FRegBanesCardPgto[intCont].strTipReg); // CÓDIGO DO REGISTRO
        qryDados.ParamByName('BAN_CODEST').Value   := fRetVal(FRegBanesCardPgto[intCont].strCodEst); // IDENTIFICAÇÃO DA LOJA
        qryDados.ParamByName('BAN_NSUTRA').Value   := fRetVal(FRegBanesCardPgto[intCont].strNsuTra); // NSU HOST DA TRANSAÇÃO
        qryDados.ParamByName('BAN_DTATRA').Value   := fRetVal(FRegBanesCardPgto[intCont].strDtaTra); // DATA DA TRANSAÇÃO
        qryDados.ParamByName('BAN_HORTRA').Value   := fRetVal(FRegBanesCardPgto[intCont].strHorTra); // HORÁRIO DA TRANSAÇÃO
        qryDados.ParamByName('BAN_TIPLAN').Value   := fRetVal(FRegBanesCardPgto[intCont].strTipLan); // TIPO DE LANÇAMENTO
        qryDados.ParamByName('BAN_DTALAN').Value   := fRetVal(FRegBanesCardPgto[intCont].strDtaLan); // DATA DE LANÇAMENTO
        qryDados.ParamByName('BAN_DTAAJU').Value   := fRetVal(FRegBanesCardPgto[intCont].strDtaAju); // DATA DA TRANSAÇÃO AJ
        qryDados.ParamByName('BAN_TIPPRO').Value   := fRetVal(FRegBanesCardPgto[intCont].strTipPro); // TIPO DO PRODUTO
        qryDados.ParamByName('BAN_TIPAJU').Value   := fRetVal(FRegBanesCardPgto[intCont].strTipAju); // TIPO DE AJUSTE
        qryDados.ParamByName('BAN_MOTAJU').Value   := fRetVal(FRegBanesCardPgto[intCont].strMotAju); // MOTIVO DO AJUSTE
        qryDados.ParamByName('BAN_CODAJU').Value   := fRetVal(FRegBanesCardPgto[intCont].strCodAju); // CODIGO DO AJUSTE
        qryDados.ParamByName('BAN_MEICAP').Value   := fRetVal(FRegBanesCardPgto[intCont].strMeiCap); // MEIO DE CAPTURA
        qryDados.ParamByName('BAN_VALBRU').Value   := fRetVal(FRegBanesCardPgto[intCont].fltValBru); // VALOR BRUTO DA VENDA
        qryDados.ParamByName('BAN_VALDES').Value   := fRetVal(FRegBanesCardPgto[intCont].fltValDes); // VALOR DO DESCONTO
        qryDados.ParamByName('BAN_VALLIQ').Value   := fRetVal(FRegBanesCardPgto[intCont].fltValLiq); // VALOR LÍQ DA VENDA
        qryDados.ParamByName('BAN_NUMCAR').Value   := fRetVal(FRegBanesCardPgto[intCont].strNumCar); // NÚMERO DO CARTÃO
        qryDados.ParamByName('BAN_NUMPAR').Value   := fRetVal(FRegBanesCardPgto[intCont].strNumPar); // NÚMERO DA PARCELA
        qryDados.ParamByName('BAN_TOTPAR').Value   := fRetVal(FRegBanesCardPgto[intCont].strTotPar); // NÚMERO TOTAL DE PARCELAS
        qryDados.ParamByName('BAN_NSUPAR').Value   := fRetVal(FRegBanesCardPgto[intCont].strNsuPar); // NSU HOST DA PARCELA
        qryDados.ParamByName('BAN_NSUAJU').Value   := fRetVal(FRegBanesCardPgto[intCont].strNsuAju); // NSU HOST NSU HOST DA TRANSAÇÃO
        qryDados.ParamByName('BAN_BRUPAR').Value   := fRetVal(FRegBanesCardPgto[intCont].fltBruPar); // VALOR BRUTO DA PARCELA
        qryDados.ParamByName('BAN_DESPAR').Value   := fRetVal(FRegBanesCardPgto[intCont].fltDesPar); // VALOR DO DESCONTO DA PARCELA
        qryDados.ParamByName('BAN_LIQPAR').Value   := fRetVal(FRegBanesCardPgto[intCont].fltLiqPar); // VALOR LÍQ DA VENDA DA PARCELA
        qryDados.ParamByName('BAN_CODBCO').Value   := fRetVal(FRegBanesCardPgto[intCont].strCodBco); // BANCO
        qryDados.ParamByName('BAN_NUMAGE').Value   := fRetVal(FRegBanesCardPgto[intCont].strNumAge); // AGENCIA
        qryDados.ParamByName('BAN_CODCTA').Value   := fRetVal(FRegBanesCardPgto[intCont].strCodCta); // CONTA
        qryDados.ParamByName('BAN_CODAUT').Value   := fRetVal(FRegBanesCardPgto[intCont].strCodAut); // CÓDIGO DE AUTORIZAÇÃO
        qryDados.ParamByName('BAN_IDEOCO').Value   := fRetVal(FRegBanesCardPgto[intCont].strIdeOco); // IDENTIFICADOR DE OCORRÊNCIA
        qryDados.ParamByName('BAN_NUMSEQ').Value   := fRetVal(FRegBanesCardPgto[intCont].strNumSeq); // NÚMERO SEQÜENCIAL DO REGISTRO NO ARQUIVO
        qryDados.ParamByName('BAN_DTAARQ').Value   := fRetVal(FRegBanesCardPgto[intCont].strDtaArq); // DATA DO ARQUIVO
        qryDados.ParamByName('BAN_NOMARQ').Value   := fRetVal(FRegBanesCardPgto[intCont].strNomArq); // NOME DO ARQUIVO
        qryDados.ExecSQL;
      End;
      pgbProg.Position := pgbProg.Position + 1;
    End;

    Try
      qryDados.Close;
      qryDados.SQL := 'REPLACE INTO ESTCAR (CAR_CODEST, CAR_NOMOPE) VALUES (:ESTAB, "BANESCARD")';
      For intCont := 0 To lstEstabel.Count - 1 Do
      Begin
        qryDados.ParamByName('ESTAB').AsString := lstEstabel[intCont];
        qryDados.ExecSQL;
      End;

      FreeAndNil(lstEstabel);
    Except
      Raise Exception.Create('A tabela ESTCAR não foi criada. Entre em contato com a Citel!');
    End;

    pgbProg.Position := Length(FRegBanesCardPgto) - 1;
  End;
end;

end.
