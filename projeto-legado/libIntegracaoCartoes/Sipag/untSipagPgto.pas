{***********************************}
{* Importação de arquivos da SIPAG *}
{********************************AJ*}
unit untSipagPgto;

interface

uses Classes, StrUtils, SysUtils, Variants, untIIntegracaoCartoes, ComCtrls, Dialogs, Forms,
     Math, Uni,untFuncoesSimples;

Type

  TRegistroPgto = Record
    strTipReg: String;
    strCodEst: String;
    strNum_RV: String;
    strDtaPag: String;
    strOC_Doc: String;
    fltRV_Bru: Double;
    fltRV_Liq: Double;
    strCodBco: String;
    strCodAge: String;
    strNumCco: String;
    strStatus: String;
    strTipCre: String;
    strTipOpe: String;
    strNumCar: String;
    strDtaTra: String;
    strNumPar: String;
    strTotPar: String;
    strCodAut: String;
    strNumNSU: String;
    fltValBru: Double;
    fltValDes: Double;
    fltValLiq: Double;
    strBandei: String;
    strNumCli: String;
    strCodAju: String;
    strDesAju: String;
    strTipAju: String;
    strDtaArq: String;
    strNomArq: String;
  End;

  TRegistroMovimentoFinanceiro = Record
    TipoRegistro,
    BandeiraCartao,
    DataPagamento,
    Estabelecimento,
    EstabelecimentoCentralizador,
    InstrucaoPagamento,
    NumeroResumoVenda,
    QuantidadeROC,
    TipoPagamento,
    TipoTransacao,
    CodigoDescricaoTransacao,
    Descricaotransacao,
    ResumoPagamento,
    CNPJBeneficiarioLockin,
    TipoLockin,
    TipoContaPagamento,
    StatusPagamento,
    DescricaoTransacaoPagamento,
    ChargebackComprovanteReferencia,
    NumeroComprovanteVenda,
    TipoTransacaoVenda,
    DataTransacao,
    HorarioCriacao,
    NumeroParcela,
    TotalParcelas,
    NumeroContaEC,
    DataGeracaoSOC,
    DataPagamentoSOC,
    NumeroControleCliente,
    NumeroCartao,
    CodigoAutorizacao,
    NumeroComprovanteNSU,
    TipoComprovante,
    ValorBrutoROC,
    ValorTaxaImpostosROC,
    ValorLiquidoROC,
    ValorTaxaAntecipacaoROC,
    ValorLiquidoAntecipacaoROC,
    ValorCompraComSaque,
    ReversaoIntercambio,
    ValorBrutoVenda,
    NumeroRegistroArquivo,
    NomeArquivo: String;
  End;

  TEstruturaPgto = Record
    strDescri: String;
    strTipCmp: String;
  End;

  TArrRegistroSipagPgto  = Array Of TRegistroPgto;

  TArrEstruturaSipagPgto  = Array Of TEstruturaPgto;

  TArrRegistroSipagMovimentoFinanceiro = Array Of TRegistroMovimentoFinanceiro;
  TSipagPgto = Class(TInterfacedObject, ICartoes)
  Private
    dtaArq,
    strRegAnt: String;
    intPosicaoAtual: Integer;
    FIncAddMovimentoFinanceiro:Integer;
    Colunas:TStringList;
    procedure ImportaCreditoParcelado;
    procedure ImportaAjustesProgramados;
    procedure ImportaCredito;
    procedure ImportaDebitos;
    function CorrigeCampoData(ADate: String): String;
    function CorrigeNumeroParcela(AParcela:String): String;
    function CorrigeCampoNumerico(AValor: String): String;
    function RetornaDelimitador(AText: String): Char;
    function CorrigeDadosBanco(AValor: Variant): Variant;
    function ConverterParaNegativo(AValor:String): String;
  Public
    constructor Create;
    Destructor Destroy; Override;
    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(pgbProg: TProgressBar);

    class function fRetSQLTabelaRegPgto(strTabela: String): String;
    class function fRetEstruturaPgto(strTabela: String): TArrEstruturaSipagPgto;
  End;

Var
  strNomArq,
  strArqAnt: String;
  intParAju: Integer;
  FArquivoFiserv: Boolean;
  FImportouPagamentos: Boolean;

implementation

uses untFuncoes, untIDataSet, untSipag;

{ TSipagPgto }

function TSipagPgto.ConverterParaNegativo(AValor: String): String;
var
  ValorNumerico: Double;
begin

  if TryStrToFloat(AValor.Replace('.',','), ValorNumerico) then
  begin
    if ValorNumerico > 0 then
      Result := FloatToStr(-ValorNumerico).Replace(',','.')
    else
      Result := FloatToStr(ValorNumerico).Replace(',','.');
  end
  else
    Result := AValor;
end;

function TSipagPgto.CorrigeCampoData(ADate: String): String;
begin
  Result := '';

  If fEmptyStr(ADate) Then
    Exit;

  Try
    ADate  := StringReplace(ADate,'-','',[rfReplaceAll]);
    ADate  := StringReplace(ADate,'/','',[rfReplaceAll]);
    Result := Concat(Copy(ADate,5,4),'-',Copy(ADate,3,2),'-',Copy(ADate,1,2));
  Except
    Result := '';
  End;
end;

function TSipagPgto.CorrigeCampoNumerico(AValor: String): String;
begin
  Result := '';

  Try
    AValor := StringReplace(AValor,',','',[rfReplaceAll]);
    AValor := StringReplace(AValor,'.','',[rfReplaceAll]);
    AValor := StringReplace(AValor,'R$','',[rfReplaceAll]);

    If Not fEmptyStr(AValor) Then
      Result := (StrToFloat(AValor)/100).ToString;

    Result  := StringReplace(Result,',','.',[rfReplaceAll]);
  Except
    Result := '';
  End;
end;

function TSipagPgto.CorrigeDadosBanco(AValor: Variant): Variant;
begin
  Result := Null;
  If Not fEmptyStr(AValor) Then
  Begin
    Result := AValor;
  End;
end;

function TSipagPgto.CorrigeNumeroParcela(AParcela: String): String;
begin
  If fEmptyStr(AParcela) Then
    AParcela := '1'
  Else If AParcela.Equals(fStrZero('0',AParcela.Length)) Then
    AParcela := '1'
  Else If Trim(AParcela).Equals('-') Then
    AParcela := '1';

  Result := LeftStr(AParcela,2);
  Result := fStrZero(Result.Replace('/',''),2);
end;

constructor TSipagPgto.Create;
Begin
  intPosicaoAtual := 0;
  FIncAddMovimentoFinanceiro := 0;
  strRegAnt := '';
  FIncAddMovimentoFinanceiro := 0;
  Colunas := TStringList.Create;
  FImportouPagamentos := False;
End;

{************************************************}
{* RETORNA A ESTRUTURA DA  TABELA  DE PAGAMENTO *}
{* SIP_SIPGTO                                   *}
{*********************************************AJ*}
destructor TSipagPgto.Destroy;
begin
  FreeAndNil(Colunas);
  inherited;
end;

class function TSipagPgto.fRetEstruturaPgto(strTabela: String): TArrEstruturaSipagPgto;
Begin
  If strTabela = 'SIP_SIPGTO' Then Begin
    SetLength(Result, 30);

    Result[0].strDescri  := 'SIP_CODEST'; Result[0].strTipCmp  := 'VARCHAR(8)'   ;
    Result[1].strDescri  := 'SIP_TIPREG'; Result[1].strTipCmp  := 'VARCHAR(3)'   ;
    Result[2].strDescri  := 'SIP_NUM_RV'; Result[2].strTipCmp  := 'VARCHAR(15)'  ;
    Result[3].strDescri  := 'SIP_TIPOPE'; Result[3].strTipCmp  := 'VARCHAR(1) DEFAULT ''C'' ';
    Result[4].strDescri  := 'SIP_DTATRA'; Result[4].strTipCmp  := 'DATE'         ;
    Result[5].strDescri  := 'SIP_CODBCO'; Result[5].strTipCmp  := 'VARCHAR(3)'   ;
    Result[6].strDescri  := 'SIP_CODAGE'; Result[6].strTipCmp  := 'VARCHAR(6)'   ;
    Result[7].strDescri  := 'SIP_NUMCCO'; Result[7].strTipCmp  := 'VARCHAR(15)'  ;
    Result[8].strDescri  := 'SIP_RV_BRU'; Result[8].strTipCmp  := 'DECIMAL(15,2)';
    Result[9].strDescri  := 'SIP_RV_LIQ'; Result[9].strTipCmp  := 'DECIMAL(15,2)';
    Result[10].strDescri := 'SIP_TIPCRE'; Result[10].strTipCmp := 'INT'          ;
    Result[11].strDescri := 'SIP_STATUS'; Result[11].strTipCmp := 'INT'          ;
    Result[12].strDescri := 'SIP_OC_DOC'; Result[12].strTipCmp := 'VARCHAR(20)'  ;
    Result[13].strDescri := 'SIP_DTAPAG'; Result[13].strTipCmp := 'DATE'         ;
    Result[14].strDescri := 'SIP_BANDEI'; Result[14].strTipCmp := 'VARCHAR(3)'   ;
    Result[15].strDescri := 'SIP_NUMNSU'; Result[15].strTipCmp := 'VARCHAR(12)'  ;
    Result[16].strDescri := 'SIP_VALLIQ'; Result[16].strTipCmp := 'DECIMAL(15,2)';
    Result[17].strDescri := 'SIP_VALDES'; Result[17].strTipCmp := 'DECIMAL(15,2)';
    Result[18].strDescri := 'SIP_VALBRU'; Result[18].strTipCmp := 'DECIMAL(15,2)';
    Result[19].strDescri := 'SIP_NUMCAR'; Result[19].strTipCmp := 'VARCHAR(19)'  ;
    Result[20].strDescri := 'SIP_NUMCLI'; Result[20].strTipCmp := 'VARCHAR(20)'  ;
    Result[21].strDescri := 'SIP_CODAUT'; Result[21].strTipCmp := 'VARCHAR(6)'   ;
    Result[22].strDescri := 'SIP_NUMPAR'; Result[22].strTipCmp := 'VARCHAR(2)'   ;
    Result[23].strDescri := 'SIP_TOTPAR'; Result[23].strTipCmp := 'VARCHAR(2)'   ;
    Result[24].strDescri := 'SIP_CODAJU'; Result[24].strTipCmp := 'VARCHAR(3)'   ;
    Result[25].strDescri := 'SIP_DESAJU'; Result[25].strTipCmp := 'VARCHAR(40)'  ;
    Result[26].strDescri := 'SIP_TIPAJU'; Result[26].strTipCmp := 'VARCHAR(1)'   ;
    Result[27].strDescri := 'SIP_DTAARQ'; Result[27].strTipCmp  := 'DATE'        ;
    Result[28].strDescri := 'SIP_NOMARQ'; Result[28].strTipCmp := 'VARCHAR(255)' ;
    Result[29].strDescri := 'SIP_CONCIL'; Result[29].strTipCmp := 'INT DEFAULT 0';
  End;
End;

class function TSipagPgto.fRetSQLTabelaRegPgto(strTabela: String): String;
Var arrCampos: TArrEstruturaSipagPgto;
    intCont  : Integer;
begin
  Result := 'CREATE TABLE ' + strTabela + '(';
  arrCampos := fRetEstruturaPgto(strTabela);

  For intCont := 0 to Length(arrCampos) - 1 do
    Result := Result + arrCampos[intCont].strDescri + ' ' + arrCampos[intCont].strTipCmp + ', ';

  Result := Result + ' PRIMARY KEY(SIP_CODEST,SIP_DTAPAG,SIP_TIPREG,SIP_DTATRA,SIP_NUMNSU,SIP_CODAUT,SIP_NUMPAR)) ENGINE INNODB ' ;
end;

procedure TSipagPgto.ImportaAjustesProgramados;
begin
  SetLength(FRegistroSipagMovimentoFinanceiro, Length(FRegistroSipagMovimentoFinanceiro) + 1);
  Inc(FIncAddMovimentoFinanceiro);

  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoRegistro := Colunas.Strings[0];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].BandeiraCartao := Colunas.Strings[1];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].DataPagamento := CorrigeCampoData(Colunas.Strings[2]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento := Colunas.Strings[3];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroResumoVenda := Colunas.Strings[4];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoTransacao := Colunas.Strings[5];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoTransacaoVenda := Colunas.Strings [6];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroComprovanteVenda := Colunas.Strings [7];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].DataTransacao := CorrigeCampoData(Colunas.Strings[8]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroParcela := Colunas.Strings[9];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TotalParcelas := Colunas.Strings[10];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].DataGeracaoSoc := CorrigeCampoData(Colunas.Strings[11]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroControleCliente := Colunas.Strings[12];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroCartao := Colunas.Strings[13];
  // Colunas.Strings[14] Número referência da conta de pagamento
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].CodigoAutorizacao := Colunas.Strings[15];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroComprovanteVenda := Colunas.Strings[16];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoComprovante := CorrigirTexto(Colunas.Strings[17]);

  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorBrutoVenda := CorrigeCampoNumerico(Colunas.Strings[18]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorLiquidoROC := CorrigeCampoNumerico(Colunas.Strings[19]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorBrutoROC := CorrigeCampoNumerico(Colunas.Strings[20]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Descricaotransacao := CorrigirTexto(Colunas.Strings[21]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoPagamento := Colunas.Strings[22];
  // Colunas.Strings[23] Número do Terminal
  // Colunas.Strings[24] Acquirer Reference Number
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroRegistroArquivo := Colunas.Strings[25];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NomeArquivo := strNomArq;


  If FEmptyStr(FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU) Then
    FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU := '0';

  If FEmptyStr(FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao) Then
    FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao := '0';

  If FEmptyStr(FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroParcela) Then
    FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroParcela := '01';

  If FEmptyStr(FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TotalParcelas) Then
    FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TotalParcelas := '01';


 If LeftStr(FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro -1].TipoComprovante, 1).Equals('D') Then
 Begin
   FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorBrutoVenda := ConverterParaNegativo(FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorBrutoVenda);
   FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorLiquidoROC := ConverterParaNegativo(FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorLiquidoROC);
   FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorBrutoROC := ConverterParaNegativo(FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorBrutoROC);
 End;

  If Not Assigned(lstEstabel) Then
    lstEstabel := TStringList.Create;

  If (FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento <> '') And
     (lstEstabel.IndexOf(FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento) < 0) Then
    lstEstabel.Add(FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento);
end;

procedure TSipagPgto.ImportaCredito;
begin
  SetLength(FRegistroSipagMovimentoFinanceiro, Length(FRegistroSipagMovimentoFinanceiro)+1);
  Inc(FIncAddMovimentoFinanceiro);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoRegistro  := Colunas.Strings[0];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].BandeiraCartao := Colunas.Strings[1];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DataPagamento := CorrigeCampoData(Colunas.Strings[2]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].Estabelecimento := Colunas.Strings[3];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].EstabelecimentoCentralizador := Colunas.Strings[4];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].InstrucaoPagamento := Colunas.Strings[5];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroResumoVenda := Colunas.Strings[6];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].QuantidadeROC := Colunas.Strings[7];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoPagamento := Colunas.Strings[8];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoTransacao := Colunas.Strings[09];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoDescricaoTransacao := Colunas.Strings[10];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].Descricaotransacao := Colunas.Strings[11];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ResumoPagamento := Colunas.Strings[12];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CNPJBeneficiarioLockin := Colunas.Strings[13];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoLockin := Colunas.Strings[14];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoContaPagamento := Colunas.Strings[15];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].StatusPagamento := Colunas.Strings[16];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DescricaoTransacaoPagamento := Colunas.Strings[17];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ChargebackComprovanteReferencia := Colunas.Strings[18];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteVenda := Colunas.Strings[19];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoTransacaoVenda := Colunas.Strings[20];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DataTransacao := CorrigeCampoData(Colunas.Strings[21]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].HorarioCriacao := Colunas.Strings[22];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroParcela := '01';
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TotalParcelas := '01';
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroContaEC := Colunas.Strings[23];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DataGeracaoSOC := CorrigeCampoData(Colunas.Strings[24]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DataPagamentoSOC := CorrigeCampoData(Colunas.Strings[25]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroControleCliente := Colunas.Strings[26];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroCartao := Colunas.Strings[27];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao := Colunas.Strings[29];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU := Colunas.Strings[30];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoComprovante := CorrigirTexto(Colunas.Strings[31]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorBrutoROC := CorrigeCampoNumerico(Colunas.Strings[32]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorTaxaImpostosROC := CorrigeCampoNumerico(Colunas.Strings[33]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorLiquidoROC := CorrigeCampoNumerico(Colunas.Strings[34]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorTaxaAntecipacaoROC := CorrigeCampoNumerico(Colunas.Strings[35]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorLiquidoAntecipacaoROC := CorrigeCampoNumerico(Colunas.Strings[36]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorCompraComSaque  := '';
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ReversaoIntercambio  := '';
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroRegistroArquivo := Colunas.Strings[37];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NomeArquivo := strNomArq;

  If FEmptyStr(FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU) Then
    FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU := '0';

  If FEmptyStr(FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao) Then
    FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao := '0';

  If Not Assigned(lstEstabel) Then
    lstEstabel := TStringList.Create;

  If (FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento <> '') And
     (lstEstabel.IndexOf(FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro -1 ].Estabelecimento) < 0) Then
    lstEstabel.Add(FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro -1].Estabelecimento);
end;

procedure TSipagPgto.ImportaCreditoParcelado;
begin
  SetLength(FRegistroSipagMovimentoFinanceiro, Length(FRegistroSipagMovimentoFinanceiro)+1);
  Inc(FIncAddMovimentoFinanceiro);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoRegistro  := Colunas.Strings[0];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].BandeiraCartao := Colunas.Strings[1];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DataPagamento := CorrigeCampoData(Colunas.Strings[2]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].Estabelecimento := Colunas.Strings[3];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].EstabelecimentoCentralizador := Colunas.Strings[4];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].InstrucaoPagamento := Colunas.Strings[5];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroResumoVenda := Colunas.Strings[6];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].QuantidadeROC := Colunas.Strings[7];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoPagamento := Colunas.Strings[8];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoTransacao := Colunas.Strings[9];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoDescricaoTransacao := Colunas.Strings[10];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].Descricaotransacao := Colunas.Strings[11];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ResumoPagamento := Colunas.Strings[12];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CNPJBeneficiarioLockin := Colunas.Strings[13];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoLockin := Colunas.Strings[14];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoContaPagamento := Colunas.Strings[15];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].StatusPagamento := Colunas.Strings[16];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DescricaoTransacaoPagamento := Colunas.Strings[17];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ChargebackComprovanteReferencia := Colunas.Strings[18];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteVenda := Colunas.Strings[19];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoTransacaoVenda := Colunas.Strings[20];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DataTransacao := CorrigeCampoData(Colunas.Strings[21]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].HorarioCriacao := Colunas.Strings[22];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroParcela := CorrigeNumeroParcela(Colunas.Strings[23]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TotalParcelas := Colunas.Strings[24];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroContaEC := Colunas.Strings[25];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DataGeracaoSOC := CorrigeCampoData(Colunas.Strings[26]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DataPagamentoSOC := CorrigeCampoData(Colunas.Strings[27]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroControleCliente := Colunas.Strings[28];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroCartao := Colunas.Strings[29];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao := Colunas.Strings[31];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU := Colunas.Strings[32];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoComprovante := CorrigirTexto(Colunas.Strings[33]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorBrutoROC := CorrigeCampoNumerico(Colunas.Strings[34]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorTaxaImpostosROC := CorrigeCampoNumerico(Colunas.Strings[35]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorLiquidoROC := CorrigeCampoNumerico(Colunas.Strings[36]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorTaxaAntecipacaoROC := CorrigeCampoNumerico(Colunas.Strings[37]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorLiquidoAntecipacaoROC := CorrigeCampoNumerico(Colunas.Strings[38]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorCompraComSaque  := '';
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ReversaoIntercambio  := '';
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroRegistroArquivo := Colunas.Strings[39];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NomeArquivo := strNomArq;

  If FEmptyStr(FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU) Then
    FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU := '0';

  If FEmptyStr(FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao) Then
    FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao := '0';

  If Not Assigned(lstEstabel) Then
    lstEstabel := TStringList.Create;

  If (FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento <> '') And
     (lstEstabel.IndexOf(FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro -1 ].Estabelecimento) < 0) Then
    lstEstabel.Add(FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro -1].Estabelecimento);
end;

procedure TSipagPgto.ImportaDebitos;
begin
  SetLength(FRegistroSipagMovimentoFinanceiro, Length(FRegistroSipagMovimentoFinanceiro)+1);
  Inc(FIncAddMovimentoFinanceiro);

  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoRegistro  := Colunas.Strings[0];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].BandeiraCartao := Colunas.Strings[1];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DataPagamento := CorrigeCampoData(Colunas.Strings[2]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].Estabelecimento := Colunas.Strings[3];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].EstabelecimentoCentralizador := Colunas.Strings[4];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].InstrucaoPagamento := Colunas.Strings[5];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroResumoVenda := Colunas.Strings[6];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].QuantidadeROC := Colunas.Strings[7];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoPagamento := Colunas.Strings[8];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoTransacao := Colunas.Strings[9];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoDescricaoTransacao := Colunas.Strings[10];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].Descricaotransacao := Colunas.Strings[11];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ResumoPagamento := Colunas.Strings[12];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CNPJBeneficiarioLockin := Colunas.Strings[13];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoLockin := Colunas.Strings[14];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoContaPagamento := Colunas.Strings[15];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].StatusPagamento := Colunas.Strings[16];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DescricaoTransacaoPagamento := Colunas.Strings[17];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ChargebackComprovanteReferencia := Colunas.Strings[18];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteVenda := Colunas.Strings[19];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoTransacaoVenda := '';
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DataTransacao := CorrigeCampoData(Colunas.Strings[20]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].HorarioCriacao := Colunas.Strings[21];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroParcela := '01';
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TotalParcelas := '01';
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroContaEC := Colunas.Strings[22];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DataGeracaoSOC := CorrigeCampoData(Colunas.Strings[23]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DataPagamentoSOC := CorrigeCampoData(Colunas.Strings[24]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroControleCliente := Colunas.Strings[25];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroCartao := Colunas.Strings[26];

  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao := Colunas.Strings[28];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU := Colunas.Strings[29];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoComprovante := CorrigirTexto(Colunas.Strings[30]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorBrutoROC := CorrigeCampoNumerico(Colunas.Strings[31]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorTaxaImpostosROC := CorrigeCampoNumerico(Colunas.Strings[32]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorLiquidoROC := CorrigeCampoNumerico(Colunas.Strings[33]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorTaxaAntecipacaoROC := CorrigeCampoNumerico(Colunas.Strings[34]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorLiquidoAntecipacaoROC := CorrigeCampoNumerico(Colunas.Strings[35]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorCompraComSaque  := CorrigeCampoNumerico(Colunas.Strings[36]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ReversaoIntercambio  := CorrigeCampoNumerico(Colunas.Strings[37]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroRegistroArquivo := Colunas.Strings[37];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NomeArquivo := strNomArq;

  If FEmptyStr(FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU) Then
    FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU := '0';

  If FEmptyStr(FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao) Then
    FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao := '0';

  If Not Assigned(lstEstabel) Then
    lstEstabel := TStringList.Create;

  If (FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento <> '') And
     (lstEstabel.IndexOf(FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro -1 ].Estabelecimento) < 0) Then
    lstEstabel.Add(FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro -1].Estabelecimento);
end;

procedure TSipagPgto.pAdicionaLinha(strString: String);
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

  If FArquivoFiserv Then
  begin
    Colunas.Delimiter := RetornaDelimitador(strString);
    Colunas.StrictDelimiter := True;
    Colunas.DelimitedText := fConverteParaAcento(strString);
    If fEmptyStr(Colunas.Text) Then
      Exit;

    // Registro 025 – Detalhamento Ordem de Pagamento de Crédito Parcelado
    If Colunas.Strings[0].Equals('025') Then
    begin
      ImportaCreditoParcelado;
    end

    // Detalhamento (Pagamento) – Registro 021 – Detalhamento Ordem de Pagamento de Débito
    Else If Colunas.Strings[0].Equals('021') Then
    begin
      ImportaDebitos;
    end

    // Detalhamento (Pagamento) – Registro 023 – Detalhamento Ordem de Pagamento de Crédito
    Else IF Colunas.Strings[0].Equals('023') Then
    begin
      ImportaCredito;
    end
    // Registro 031 – Ajustes Programados (Próximos 30 Dias)
    Else IF Colunas.Strings[0].Equals('031') Then
    begin
      ImportaAjustesProgramados;
    end;


    exit;
  end;

  If lstCampos[0] = '000' Then
    dtaArq    := lstCampos[1]
  Else If (StrtoInt(lstCampos[0]) In [20, 21, 22, 23, 24, 26, 30]) Then
  Begin
    If ((StrToInt(lstCampos[0]) In [20, 22, 24, 30]) Or
       ((StrToInt(strRegAnt) In [21, 23, 26]) And (StrToInt(lstCampos[0]) In [21, 23, 26]))) Then
      SetLength(FRegSipagPgto, Length(FRegSipagPgto) + 1);

    If (StrtoInt(lstCampos[0]) In [20, 22, 24]) Then
    Begin
      FRegSipagPgto[Length(FRegSipagPgto)-1].strDtaPag := fGetDados(lstCampos[2]);
      FRegSipagPgto[Length(FRegSipagPgto)-1].strDtaArq := dtaArq;
      FRegSipagPgto[Length(FRegSipagPgto)-1].strNomArq := strNomArq;
      FRegSipagPgto[Length(FRegSipagPgto)-1].fltRV_Liq := fGetDados(lstCampos[4], True, 2);
      If StrtoInt(lstCampos[0]) In [20, 22] Then
      Begin
        FRegSipagPgto[Length(FRegSipagPgto)-1].strCodBco := fGetDados(lstCampos[8]);
        FRegSipagPgto[Length(FRegSipagPgto)-1].strCodAge := fGetDados(lstCampos[9]);
        FRegSipagPgto[Length(FRegSipagPgto)-1].strNumCco := fGetDados(lstCampos[10]);
        FRegSipagPgto[Length(FRegSipagPgto)-1].strNum_RV := fGetDados(lstCampos[11]);
        FRegSipagPgto[Length(FRegSipagPgto)-1].fltRV_Bru := fGetDados(lstCampos[15], True, 2);
        FRegSipagPgto[Length(FRegSipagPgto)-1].strBandei := fGetDados(lstCampos[14]);
      End
      Else If StrtoInt(lstCampos[0]) In [24] Then
      Begin
        FRegSipagPgto[Length(FRegSipagPgto)-1].strCodBco := fGetDados(lstCampos[10]);
        FRegSipagPgto[Length(FRegSipagPgto)-1].strCodAge := fGetDados(lstCampos[11]);
        FRegSipagPgto[Length(FRegSipagPgto)-1].strNumCco := fGetDados(lstCampos[12]);
        FRegSipagPgto[Length(FRegSipagPgto)-1].strNum_RV := fGetDados(lstCampos[13]);
        FRegSipagPgto[Length(FRegSipagPgto)-1].strBandei := fGetDados(lstCampos[16]);
        FRegSipagPgto[Length(FRegSipagPgto)-1].fltRV_Bru := fGetDados(lstCampos[17], True, 2);
      End;
    End
    Else If (StrtoInt(lstCampos[0]) In [21, 23, 26]) Then
    Begin
      If (StrToInt(strRegAnt) In [21, 23, 26]) Then
      Begin
        FRegSipagPgto[Length(FRegSipagPgto)-1].strDtaPag := FRegSipagPgto[Length(FRegSipagPgto)-2].strDtaPag;
        FRegSipagPgto[Length(FRegSipagPgto)-1].strCodBco := FRegSipagPgto[Length(FRegSipagPgto)-2].strCodBco;
        FRegSipagPgto[Length(FRegSipagPgto)-1].strCodAge := FRegSipagPgto[Length(FRegSipagPgto)-2].strCodAge;
        FRegSipagPgto[Length(FRegSipagPgto)-1].strNumCco := FRegSipagPgto[Length(FRegSipagPgto)-2].strNumCco;
        FRegSipagPgto[Length(FRegSipagPgto)-1].fltRV_Liq := FRegSipagPgto[Length(FRegSipagPgto)-2].fltRV_Liq;
        FRegSipagPgto[Length(FRegSipagPgto)-1].fltRV_Bru := FRegSipagPgto[Length(FRegSipagPgto)-2].fltRV_Bru;
        FRegSipagPgto[Length(FRegSipagPgto)-1].strNum_RV := FRegSipagPgto[Length(FRegSipagPgto)-2].strNum_RV;
        FRegSipagPgto[Length(FRegSipagPgto)-1].strBandei := FRegSipagPgto[Length(FRegSipagPgto)-2].strBandei;
        FRegSipagPgto[Length(FRegSipagPgto)-1].strDtaArq := dtaArq;
        FRegSipagPgto[Length(FRegSipagPgto)-1].strNomArq := strNomArq;
      End;

      FRegSipagPgto[Length(FRegSipagPgto)-1].strTipReg := fGetDados(lstCampos[0]);
      FRegSipagPgto[Length(FRegSipagPgto)-1].strCodEst := fGetDados(lstCampos[1]);
      FRegSipagPgto[Length(FRegSipagPgto)-1].strNumNSU := fGetDados(lstCampos[3]);
      FRegSipagPgto[Length(FRegSipagPgto)-1].fltValLiq := fGetDados(lstCampos[4], True, 2);
      FRegSipagPgto[Length(FRegSipagPgto)-1].strTipOpe := 'C';

      If (lstCampos[0] <> '026') Then
      Begin
        FRegSipagPgto[Length(FRegSipagPgto)-1].fltValBru := fGetDados(lstCampos[5], True, 2);
        FRegSipagPgto[Length(FRegSipagPgto)-1].fltValDes := fGetDados(lstCampos[6], True, 2);
        FRegSipagPgto[Length(FRegSipagPgto)-1].strNumPar := '01';
        FRegSipagPgto[Length(FRegSipagPgto)-1].strTotPar := '01';

        FRegSipagPgto[Length(FRegSipagPgto)-1].strDtaTra := fGetDados(lstCampos[7]);
        FRegSipagPgto[Length(FRegSipagPgto)-1].strNumCar := fGetDados(lstCampos[8]);
        FRegSipagPgto[Length(FRegSipagPgto)-1].strNumCli := fGetDados(lstCampos[9]);
        FRegSipagPgto[Length(FRegSipagPgto)-1].strCodAut := fGetDados(lstCampos[10]);
        FRegSipagPgto[Length(FRegSipagPgto)-1].strTipCre := fGetDados(lstCampos[11]);
        FRegSipagPgto[Length(FRegSipagPgto)-1].strStatus := fGetDados(lstCampos[12]);

        If lstCampos.Count >= 20 Then
        Begin
          FRegSipagPgto[Length(FRegSipagPgto)-1].strDtaTra := fGetDados(lstCampos[8]);
          FRegSipagPgto[Length(FRegSipagPgto)-1].strNumCar := fGetDados(lstCampos[9]);
          FRegSipagPgto[Length(FRegSipagPgto)-1].strNumCli := fGetDados(lstCampos[10]);
          FRegSipagPgto[Length(FRegSipagPgto)-1].strCodAut := fGetDados(lstCampos[11]);
          FRegSipagPgto[Length(FRegSipagPgto)-1].strTipCre := fGetDados(lstCampos[12]);
          FRegSipagPgto[Length(FRegSipagPgto)-1].strStatus := fGetDados(lstCampos[13]);
        End;
      End
      Else
      Begin
        FRegSipagPgto[Length(FRegSipagPgto)-1].fltValDes := fGetDados(lstCampos[8], True, 2);
        FRegSipagPgto[Length(FRegSipagPgto)-1].strNumPar := fGetDados(lstCampos[5]);
        FRegSipagPgto[Length(FRegSipagPgto)-1].strTotPar := fGetDados(lstCampos[6]);

        FRegSipagPgto[Length(FRegSipagPgto)-1].fltValBru := fGetDados(lstCampos[7], True, 2) /
                                                            StrtoInt(FRegSipagPgto[Length(FRegSipagPgto)-1].strTotPar);

        FRegSipagPgto[Length(FRegSipagPgto)-1].strDtaTra := fGetDados(lstCampos[9]);
        FRegSipagPgto[Length(FRegSipagPgto)-1].strNumCar := fGetDados(lstCampos[10]);
        FRegSipagPgto[Length(FRegSipagPgto)-1].strNumCli := fGetDados(lstCampos[11]);
        FRegSipagPgto[Length(FRegSipagPgto)-1].strCodAut := fGetDados(lstCampos[12]);
        FRegSipagPgto[Length(FRegSipagPgto)-1].strTipCre := fGetDados(lstCampos[13]);
        FRegSipagPgto[Length(FRegSipagPgto)-1].strStatus := fGetDados(lstCampos[14]);

        If lstCampos.Count >= 19 Then
        Begin
          FRegSipagPgto[Length(FRegSipagPgto)-1].strDtaTra := fGetDados(lstCampos[10]);
          FRegSipagPgto[Length(FRegSipagPgto)-1].strNumCar := fGetDados(lstCampos[11]);
          FRegSipagPgto[Length(FRegSipagPgto)-1].strNumCli := fGetDados(lstCampos[12]);
          FRegSipagPgto[Length(FRegSipagPgto)-1].strCodAut := fGetDados(lstCampos[13]);
          FRegSipagPgto[Length(FRegSipagPgto)-1].strTipCre := fGetDados(lstCampos[14]);
          FRegSipagPgto[Length(FRegSipagPgto)-1].strStatus := fGetDados(lstCampos[15]);
        End;
      End;

    End
    Else If (lstCampos[0] = '030') Then
    Begin
      FRegSipagPgto[Length(FRegSipagPgto)-1].strTipReg := fGetDados(lstCampos[0]);
      FRegSipagPgto[Length(FRegSipagPgto)-1].strCodEst := fGetDados(lstCampos[1]);
      FRegSipagPgto[Length(FRegSipagPgto)-1].strDtaPag := fGetDados(lstCampos[2]);
      FRegSipagPgto[Length(FRegSipagPgto)-1].fltRV_Liq := fGetDados(lstCampos[4], True, 2);
      FRegSipagPgto[Length(FRegSipagPgto)-1].strTipOpe := fGetDados(lstCampos[5]);
      FRegSipagPgto[Length(FRegSipagPgto)-1].strTipCre := fGetDados(lstCampos[6]);
      FRegSipagPgto[Length(FRegSipagPgto)-1].strCodAju := fGetDados(lstCampos[7]);
      FRegSipagPgto[Length(FRegSipagPgto)-1].strDesAju := fGetDados(lstCampos[8]);
      FRegSipagPgto[Length(FRegSipagPgto)-1].fltValLiq := fGetDados(lstCampos[4], True, 2);
      FRegSipagPgto[Length(FRegSipagPgto)-1].fltValBru := fGetDados(lstCampos[11], True, 2);
      FRegSipagPgto[Length(FRegSipagPgto)-1].strTipAju := fGetDados(lstCampos[12]);
      If lstCampos[13] <> '' Then
        FRegSipagPgto[Length(FRegSipagPgto)-1].strNumNSU := fGetDados(lstCampos[13])
      Else
        FRegSipagPgto[Length(FRegSipagPgto)-1].strNumNSU := RightStr(fGetDados(lstCampos[3]), 12);
      FRegSipagPgto[Length(FRegSipagPgto)-1].strNumCar := fGetDados(lstCampos[14]);
      FRegSipagPgto[Length(FRegSipagPgto)-1].strNumCli := fGetDados(lstCampos[15]);
      If lstCampos[16] <> '' Then
        FRegSipagPgto[Length(FRegSipagPgto)-1].strCodAut := fGetDados(lstCampos[16])
      Else
        FRegSipagPgto[Length(FRegSipagPgto)-1].strCodAut := RightStr(fGetDados(lstCampos[3]), 6);
      FRegSipagPgto[Length(FRegSipagPgto)-1].strDtaTra := fGetDados(lstCampos[18]);
      FRegSipagPgto[Length(FRegSipagPgto)-1].fltRV_Bru := fGetDados(lstCampos[19], True, 2);
      If lstCampos[20] <> '' Then
        FRegSipagPgto[Length(FRegSipagPgto)-1].strNumPar := fGetDados(lstCampos[20])
      Else
        FRegSipagPgto[Length(FRegSipagPgto)-1].strNumPar := '01';
      If lstCampos[21] <> '' Then
        FRegSipagPgto[Length(FRegSipagPgto)-1].strTotPar := fGetDados(lstCampos[21])
      Else
        FRegSipagPgto[Length(FRegSipagPgto)-1].strTotPar := '01';
      FRegSipagPgto[Length(FRegSipagPgto)-1].strNum_RV := fGetDados(lstCampos[3]);
      FRegSipagPgto[Length(FRegSipagPgto)-1].strStatus := '0';
      FRegSipagPgto[Length(FRegSipagPgto)-1].strDtaArq := dtaArq;
      FRegSipagPgto[Length(FRegSipagPgto)-1].strNomArq := strNomArq;

      If FRegSipagPgto[Length(FRegSipagPgto)-1].strTipOpe = 'D' Then
      Begin
        FRegSipagPgto[Length(FRegSipagPgto)-1].fltValLiq := FRegSipagPgto[Length(FRegSipagPgto)-1].fltValLiq * (-1);
        FRegSipagPgto[Length(FRegSipagPgto)-1].fltValBru := FRegSipagPgto[Length(FRegSipagPgto)-1].fltValBru * (-1);
      End;
    End;

    If (FRegSipagPgto[Length(FRegSipagPgto)-1].strCodEst <> '') And
       (lstEstabel.IndexOf(FRegSipagPgto[Length(FRegSipagPgto)-1].strCodEst) < 0) Then
      lstEstabel.Add(FRegSipagPgto[Length(FRegSipagPgto)-1].strCodEst);

    strRegAnt := lstCampos[0];
  End;
end;

procedure TSipagPgto.pGravarRegistros(pgbProg: TProgressBar);
  Var
    qryDados : IDataSet;
    intCont  : Integer;
    strSQL   : String;
    arrCampos: TArrEstruturaSipagPgto;
    LMovimentoFinanceiro : TUniQuery;
    LContador: Integer;

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


  Try

    Try
      pgbProg.Position := 0;

      If Length(FRegistroSipagMovimentoFinanceiro) > 0 Then
      Begin
        LMovimentoFinanceiro := untFuncoes.CriarQueryDLL;

        LMovimentoFinanceiro.Close;
        LMovimentoFinanceiro.SQL.Clear;
        LMovimentoFinanceiro.SQL.Text := RetornaReplaceTabela('SIP_FVPGTO',['SIP_CONCIL']);


        pgbProg.Max := Length(FRegistroSipagMovimentoFinanceiro) - 1;

        For LContador := 0 To Length(FRegistroSipagMovimentoFinanceiro) - 1 Do
        Begin
          LMovimentoFinanceiro.Close;
          LMovimentoFinanceiro.ParamByName('SIP_TIPREG').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].TipoRegistro);
          LMovimentoFinanceiro.ParamByName('SIP_NOMBAN').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].BandeiraCartao);
          LMovimentoFinanceiro.ParamByName('SIP_DTAPAG').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].DataPagamento);
          LMovimentoFinanceiro.ParamByName('SIP_CODEST').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].Estabelecimento);
          LMovimentoFinanceiro.ParamByName('SIP_ESTCEN').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].EstabelecimentoCentralizador);
          LMovimentoFinanceiro.ParamByName('SIP_INSPAG').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].InstrucaoPagamento);
          LMovimentoFinanceiro.ParamByName('SIP_NUM_RV').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].NumeroResumoVenda);
          LMovimentoFinanceiro.ParamByName('SIP_QTDROC').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].QuantidadeROC);
          LMovimentoFinanceiro.ParamByName('SIP_TIPPAG').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].TipoPagamento);
          LMovimentoFinanceiro.ParamByName('SIP_TIPTRA').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].TipoTransacao);
          LMovimentoFinanceiro.ParamByName('SIP_CODDES').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].CodigoDescricaoTransacao);
          LMovimentoFinanceiro.ParamByName('SIP_DESTRA').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].Descricaotransacao);
          LMovimentoFinanceiro.ParamByName('SIP_RESPAG').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].ResumoPagamento);
          LMovimentoFinanceiro.ParamByName('SIP_CNPJLC').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].CNPJBeneficiarioLockin);
          LMovimentoFinanceiro.ParamByName('SIP_TIPLOC').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].TipoLockin);
          LMovimentoFinanceiro.ParamByName('SIP_TIPCTA').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].TipoContaPagamento);
          LMovimentoFinanceiro.ParamByName('SIP_STATUS').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].StatusPagamento);
          LMovimentoFinanceiro.ParamByName('SIP_DESPAG').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].DescricaoTransacaoPagamento);
          LMovimentoFinanceiro.ParamByName('SIP_COMREF').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].ChargebackComprovanteReferencia);
          LMovimentoFinanceiro.ParamByName('SIP_REFVEN').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].NumeroComprovanteVenda);
          LMovimentoFinanceiro.ParamByName('SIP_TIPVEN').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].TipoTransacaoVenda);
          LMovimentoFinanceiro.ParamByName('SIP_DTATRA').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].DataTransacao);
          LMovimentoFinanceiro.ParamByName('SIP_HORTRA').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].HorarioCriacao);
          LMovimentoFinanceiro.ParamByName('SIP_NUMPAR').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].NumeroParcela);
          LMovimentoFinanceiro.ParamByName('SIP_TOTPAR').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].TotalParcelas);
          LMovimentoFinanceiro.ParamByName('SIP_NUMCTA').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].NumeroContaEC);
          LMovimentoFinanceiro.ParamByName('SIP_GERSOC').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].DataGeracaoSOC);
          LMovimentoFinanceiro.ParamByName('SIP_PAGSOC').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].DataPagamentoSOC);
          LMovimentoFinanceiro.ParamByName('SIP_CONCLI').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].NumeroControleCliente);
          LMovimentoFinanceiro.ParamByName('SIP_NUMCAR').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].NumeroCartao);
          LMovimentoFinanceiro.ParamByName('SIP_CODAUT').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].CodigoAutorizacao);
          LMovimentoFinanceiro.ParamByName('SIP_NUMNSU').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].NumeroComprovanteNSU);
          LMovimentoFinanceiro.ParamByName('SIP_TIPCON').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].TipoComprovante);
          LMovimentoFinanceiro.ParamByName('SIP_VALBRU').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].ValorBrutoROC);
          LMovimentoFinanceiro.ParamByName('SIP_VALTAX').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].ValorTaxaImpostosROC);
          LMovimentoFinanceiro.ParamByName('SIP_VALLIQ').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].ValorLiquidoROC);
          LMovimentoFinanceiro.ParamByName('SIP_TAXANT').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].ValorTaxaAntecipacaoROC);
          LMovimentoFinanceiro.ParamByName('SIP_LIQANT').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].ValorLiquidoAntecipacaoROC);
          LMovimentoFinanceiro.ParamByName('SIP_VALSAQ').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].ValorCompraComSaque);
          LMovimentoFinanceiro.ParamByName('SIP_VALINT').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].ReversaoIntercambio);
          LMovimentoFinanceiro.ParamByName('SIP_BRUVEN').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].ValorBrutoVenda);
          LMovimentoFinanceiro.ParamByName('SIP_SEQARQ').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].NumeroRegistroArquivo);
          LMovimentoFinanceiro.ParamByName('SIP_NOMARQ').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].NomeArquivo);
          LMovimentoFinanceiro.ExecSQL;

          If Not MatchStr(FRegistroSipagMovimentoFinanceiro[LContador].TipoRegistro,['031']) Then
            FImportouPagamentos := True;

          pStep(pgbProg);
        End;

        SetLength(FRegistroSipagMovimentoFinanceiro,0);

        Try
          LMovimentoFinanceiro.Close;
          LMovimentoFinanceiro.SQL.Text := 'REPLACE INTO ESTCAR (CAR_CODEST, CAR_NOMOPE) VALUES (:ESTAB, "SIPAG")';
          For LContador := 0 To lstEstabel.Count - 1 Do
          Begin
            LMovimentoFinanceiro.ParamByName('ESTAB').AsString := lstEstabel[LContador];
            LMovimentoFinanceiro.ExecSQL;
          End;
        Except
          Raise Exception.Create('A tabela ESTCAR não foi criada. Entre em contato com a Citel!');
        End;


      End;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;

  Finally
    If Assigned(LMovimentoFinanceiro) Then
      FreeAndNil(LMovimentoFinanceiro);
  End;

  strSQL    := 'REPLACE INTO SIP_SIPGTO (';
  arrCampos := fRetEstruturaPgto('SIP_SIPGTO');
  For intCont := 0 to Length(arrCampos) - 1 do
    If (arrCampos[intCont].strDescri <> 'SIP_CONCIL') Then
      strSQL := strSQL + arrCampos[intCont].strDescri + ',';
  strSQL := Copy(strSQL, 1, Length(strSQL) - 1) + ') VALUES (';
  For intCont := 0 to Length(arrCampos) - 1 do
    If (arrCampos[intCont].strDescri <> 'SIP_CONCIL') Then
      strSQL := strSQL + ':' + arrCampos[intCont].strDescri + ',';
  strSQL := Copy(strSQL, 1, Length(strSQL) - 1) + ')';

  qryDados := objFunctions.fGetDataSet;
  qryDados.Close;
  qryDados.SQL := strSQL;

  pgbProg.Position := 0;

  If Length(FRegSipagPgto) > 0 Then
  Begin
    pgbProg.Max      := Length(FRegSipagPgto)-1;
    FImportouPagamentos := True;
    For intCont := 0 To Length(FRegSipagPgto)-1 Do
    Begin
      Application.ProcessMessages;
      If FRegSipagPgto[intCont].strTipReg <> '' Then
      Begin
        Try
          With qryDados Do
          Begin
            Close;
            ParamByName('SIP_TIPREG').Value   := fRetVal(FRegSipagPgto[intCont].strTipReg);
            ParamByName('SIP_CODEST').Value   := fRetVal(FRegSipagPgto[intCont].strCodEst);
            ParamByName('SIP_DTAPAG').Value   := fRetVal(FRegSipagPgto[intCont].strDtaPag, True);
            ParamByName('SIP_OC_DOC').Value   := fRetVal(FRegSipagPgto[intCont].strOC_Doc);
            ParamByName('SIP_RV_BRU').Value   := fRetVal(FRegSipagPgto[intCont].fltRV_Bru);
            ParamByName('SIP_RV_LIQ').Value   := fRetVal(FRegSipagPgto[intCont].fltRV_Liq);
            ParamByName('SIP_CODBCO').Value   := fRetVal(FRegSipagPgto[intCont].strCodBco);
            ParamByName('SIP_CODAGE').Value   := fRetVal(FRegSipagPgto[intCont].strCodAge);
            ParamByName('SIP_NUMCCO').Value   := fRetVal(FRegSipagPgto[intCont].strNumCco);
            ParamByName('SIP_VALBRU').Value   := fRetVal(FRegSipagPgto[intCont].fltValBru);
            ParamByName('SIP_VALDES').Value   := fRetVal(FRegSipagPgto[intCont].fltValDes);
            ParamByName('SIP_VALLIQ').Value   := fRetVal(FRegSipagPgto[intCont].fltValLIQ);
            ParamByName('SIP_TIPOPE').Value   := fRetVal(FRegSipagPgto[intCont].strTipOpe);
            ParamByName('SIP_NUM_RV').Value   := fRetVal(FRegSipagPgto[intCont].strNum_RV);
            ParamByName('SIP_TIPCRE').AsString:= fRetVal(FRegSipagPgto[intCont].strTipOpe);
            ParamByName('SIP_STATUS').AsString:= fRetVal(FRegSipagPgto[intCont].strStatus);
            ParamByName('SIP_TOTPAR').Value   := RightStr(fRetVal(FRegSipagPgto[intCont].strTotPar), 2);
            ParamByName('SIP_NUMPAR').Value   := RightStr(fRetVal(FRegSipagPgto[intCont].strNumPar), 2);
            ParamByName('SIP_DTATRA').Value   := fRetVal(FRegSipagPgto[intCont].strDtaTra, True);
            ParamByName('SIP_CODAUT').Value   := fRetVal(FRegSipagPgto[intCont].strCodAut);
            ParamByName('SIP_NUMCAR').Value   := fRetVal(FRegSipagPgto[intCont].strNumCar);
            ParamByName('SIP_NUMNSU').Value   := fRetVal(FRegSipagPgto[intCont].strNumNSU);
            ParamByName('SIP_BANDEI').Value   := fRetVal(FRegSipagPgto[intCont].strBandei);
            ParamByName('SIP_NUMCLI').Value   := fRetVal(FRegSipagPgto[intCont].strNumCli);
            ParamByName('SIP_CODAJU').Value   := fRetVal(FRegSipagPgto[intCont].strCodAju);
            ParamByName('SIP_DESAJU').Value   := fRetVal(FRegSipagPgto[intCont].strDesAju);
            ParamByName('SIP_TIPAJU').Value   := fRetVal(FRegSipagPgto[intCont].strTipAju);

            ParamByName('SIP_NOMARQ').Value   := fRetVal(FRegSipagPgto[intCont].strNomArq);
            ParamByName('SIP_DTAARQ').Value   := fRetVal(FRegSipagPgto[intCont].strDtaArq, True);
            ExecSQL;
          End;
        Except
          On E: Exception Do
            Raise Exception.Create(E.Message);
        End;
      End;

      pgbProg.Position := pgbProg.Position + 1;
    End;

    Try
      qryDados.Close;
      qryDados.SQL := 'REPLACE INTO ESTCAR (CAR_CODEST, CAR_NOMOPE) VALUES (:ESTAB, "SIPAG")';
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

function TSipagPgto.RetornaDelimitador(AText: String): Char;
begin
  Result := ',';

  If Pos(';',AText) > 0 Then
    Result := ';';
end;

end.
