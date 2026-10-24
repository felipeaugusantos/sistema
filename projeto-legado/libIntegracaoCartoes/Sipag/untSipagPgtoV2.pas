{**************************************}
{* Importação de arquivos da SIPAG V2 *}
{***********************************AJ*}
unit untSipagPgtoV2;

interface

uses Classes, StrUtils, SysUtils, Variants, untIIntegracaoCartoes, ComCtrls, Dialogs, Forms,
     Math, Uni,untFuncoesSimples, untSipagPgto;

Type

  TRegistroPgtoV2 = Record
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

  TRegistroMovimentoFinanceiroV2 = Record
    TipoRegistro,
    BandeiraCartao,
    DataPagamento,
    Estabelecimento,
    LoteLiquidacao,
    QtdeComprovantes,
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
    ReferenciadeVenda,
    DescricaoTransacaoPagamento,
    ChargebackComprovanteReferencia,
    NumeroComprovanteVenda,
    TipoTransacaoVenda,
    DataTransacao,
    HorarioCriacao,
    DataProcessamentoTransacao,
    DataPrevistaPagamentoTransacao,
    NumeroParcela,
    TotalParcelas,
    DataDoAjuste,
    NumeroConta,
    DataGeracaoSOC,
    DataPagamentoSOC,
    NumeroControleCliente,
    NumeroCartao,
    CodigoAutorizacao,
    NumeroComprovanteNSU,
    TipoComprovante,
    ValorBruto,
    ValorAjustado,
    ValorBrutoAjuste,
    ValorBrutoVenda,
    ValorTaxaMDR,
    ValorLiquidoVenda,
    ValorTaxaAntecipacao,
    ValorLiquido,
    ValorLiquidoAntecipacao,
    ValorCompraComSaque,
    ReversaoIntercambio,
    AcquirerReferenceNumber,
    NumeroTerminal,
    CancelId,
    NumeroRegistroArquivo,
    NomeArquivo: String;
  End;

  TArrRegistroSipagPgtoV2  = Array Of TRegistroPgtoV2;

  TArrRegistroSipagMovimentoFinanceiroV2 = Array Of TRegistroMovimentoFinanceiroV2;

  TSipagPgtoV2 = Class(TInterfacedObject, ICartoes)
  Private
    strRegAnt: String;
    intPosicaoAtual: Integer;
    FIncAddMovimentoFinanceiroV2:Integer;
    Colunas:TStringList;
    FNomeArquivo : String;
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

    property NomeArquivo: String read FNomeArquivo write FNomeArquivo;
  End;

Var
  strNomArq,
  strArqAnt: String;
  FImportouPagamentosV2: Boolean;
  FArquivoSipagV2: Boolean;

implementation

uses untFuncoes, untIDataSet, untSipag;

{ TSipagPgtoV2 }

function TSipagPgtoV2.ConverterParaNegativo(AValor: String): String;
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

function TSipagPgtoV2.CorrigeCampoData(ADate: String): String;
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

function TSipagPgtoV2.CorrigeCampoNumerico(AValor: String): String;
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

function TSipagPgtoV2.CorrigeDadosBanco(AValor: Variant): Variant;
begin
  Result := Null;
  If Not fEmptyStr(AValor) Then
  Begin
    Result := AValor;
  End;
end;

function TSipagPgtoV2.CorrigeNumeroParcela(AParcela: String): String;
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

constructor TSipagPgtoV2.Create;
Begin
  intPosicaoAtual := 0;
  FIncAddMovimentoFinanceiroV2 := 0;
  strRegAnt := '';
  Colunas := TStringList.Create;
  FImportouPagamentosV2 := False;
End;

{************************************************}
{* RETORNA A ESTRUTURA DA  TABELA  DE PAGAMENTO *}
{* SIP_SIPGTO                                   *}
{*********************************************AJ*}
destructor TSipagPgtoV2.Destroy;
begin
  FreeAndNil(Colunas);
  inherited;
end;

procedure TSipagPgtoV2.ImportaAjustesProgramados;
begin
  SetLength(FRegistroSipagMovimentoFinanceiroV2, Length(FRegistroSipagMovimentoFinanceiroV2) + 1);
  Inc(FIncAddMovimentoFinanceiroV2);

  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].TipoRegistro            := Colunas.Strings[0];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].BandeiraCartao          := Colunas.Strings[1];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].DataPagamento           := CorrigeCampoData(Colunas.Strings[2]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].Estabelecimento         := Colunas.Strings[3];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].NumeroResumoVenda       := Colunas.Strings[4];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].TipoTransacao           := Colunas.Strings[5];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].ReferenciadeVenda       := Colunas.Strings[6];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].DataTransacao           := CorrigeCampoData(Colunas.Strings[7]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].NumeroParcela           := Colunas.Strings[8];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].TotalParcelas           := Colunas.Strings[9];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].DataDoAjuste            := CorrigeCampoData(Colunas.Strings[10]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].NumeroCartao            := Colunas.Strings[11];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].CodigoAutorizacao       := Colunas.Strings[12];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].NumeroComprovanteVenda  := Colunas.Strings[13];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].TipoComprovante         := CorrigirTexto(Colunas.Strings[14]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].ValorBrutoVenda         := CorrigeCampoNumerico(Colunas.Strings[15]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].ValorLiquidoVenda       := CorrigeCampoNumerico(Colunas.Strings[16]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].ValorBrutoAjuste        := CorrigeCampoNumerico(Colunas.Strings[17]);

  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].NumeroTerminal          := Colunas.Strings[18];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].AcquirerReferenceNumber := Colunas.Strings[19];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].NumeroRegistroArquivo   := Colunas.Strings[20];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].NomeArquivo             :=  FNomeArquivo;

  If FEmptyStr(FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NumeroComprovanteNSU) Then
    FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NumeroComprovanteNSU := '0';

  If FEmptyStr(FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].CodigoAutorizacao) Then
    FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].CodigoAutorizacao := '0';

  If FEmptyStr(FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NumeroParcela) Then
    FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NumeroParcela := '01';

  If FEmptyStr(FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].TotalParcelas) Then
    FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].TotalParcelas := '01';


 If LeftStr(FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 -1].TipoComprovante, 1).Equals('D') Then
 Begin
   FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].ValorBrutoVenda   := ConverterParaNegativo(FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].ValorBrutoVenda);
   FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].ValorLiquidoVenda := ConverterParaNegativo(FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].ValorLiquidoVenda);
   FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].ValorBrutoAjuste  := ConverterParaNegativo(FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].ValorBrutoAjuste);
 End;

  If Not Assigned(lstEstabel) Then
    lstEstabel := TStringList.Create;

  If (FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].Estabelecimento <> '') And
     (lstEstabel.IndexOf(FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].Estabelecimento) < 0) Then
    lstEstabel.Add(FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].Estabelecimento);
end;

procedure TSipagPgtoV2.ImportaCredito;
begin
  SetLength(FRegistroSipagMovimentoFinanceiroV2, Length(FRegistroSipagMovimentoFinanceiroV2)+1);
  Inc(FIncAddMovimentoFinanceiroV2);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].TipoRegistro                   := Colunas.Strings[0];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].BandeiraCartao                 := Colunas.Strings[1];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].DataPagamento                  := CorrigeCampoData(Colunas.Strings[2]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].Estabelecimento                := Colunas.Strings[3];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].LoteLiquidacao                 := Colunas.Strings[4];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].QtdeComprovantes               := Colunas.Strings[5];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].TipoPagamento                  := Colunas.Strings[6];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].TipoTransacao                  := Colunas.Strings[7];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].Descricaotransacao             := Colunas.Strings[8];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].CNPJBeneficiarioLockin         := Colunas.Strings[9];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].TipoLockin                     := Colunas.Strings[10];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].TipoContaPagamento             := Colunas.Strings[11];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].StatusPagamento                := Colunas.Strings[12];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].ReferenciadeVenda              := Colunas.Strings[13];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].DataTransacao                  := CorrigeCampoData(Colunas.Strings[14]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].HorarioCriacao                 := Colunas.Strings[15];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NumeroParcela                  := '01';
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].TotalParcelas                  := '01';
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NumeroConta                    := Colunas.Strings[16];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].DataProcessamentoTransacao     := CorrigeCampoData(Colunas.Strings[17]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].DataPrevistaPagamentoTransacao := CorrigeCampoData(Colunas.Strings[18]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NumeroCartao                   := Colunas.Strings[19];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].CodigoAutorizacao              := Colunas.Strings[20];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NumeroComprovanteNSU           := Colunas.Strings[21];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].TipoComprovante                := CorrigirTexto(Colunas.Strings[22]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].ValorBrutoVenda                := CorrigeCampoNumerico(Colunas.Strings[23]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].ValorTaxaMDR                   := CorrigeCampoNumerico(Colunas.Strings[24]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].ValorLiquidoVenda              := CorrigeCampoNumerico(Colunas.Strings[25]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].ValorTaxaAntecipacao           := CorrigeCampoNumerico(Colunas.Strings[26]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].ValorLiquidoAntecipacao        := CorrigeCampoNumerico(Colunas.Strings[27]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].AcquirerReferenceNumber        := Colunas.Strings[28];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].CancelId                       := Colunas.Strings[29];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NumeroRegistroArquivo          := Colunas.Strings[30];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NomeArquivo                    := FNomeArquivo;

  If FEmptyStr(FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NumeroComprovanteNSU) Then
    FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NumeroComprovanteNSU := '0';

  If FEmptyStr(FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].CodigoAutorizacao) Then
    FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].CodigoAutorizacao := '0';

  If Not Assigned(lstEstabel) Then
    lstEstabel := TStringList.Create;

  If (FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].Estabelecimento <> '') And
     (lstEstabel.IndexOf(FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 -1 ].Estabelecimento) < 0) Then
    lstEstabel.Add(FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 -1].Estabelecimento);
end;

procedure TSipagPgtoV2.ImportaCreditoParcelado;
begin
  SetLength(FRegistroSipagMovimentoFinanceiroV2, Length(FRegistroSipagMovimentoFinanceiroV2)+1);
  Inc(FIncAddMovimentoFinanceiroV2);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].TipoRegistro                   := Colunas.Strings[0];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].BandeiraCartao                 := Colunas.Strings[1];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].DataPagamento                  := CorrigeCampoData(Colunas.Strings[2]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].Estabelecimento                := Colunas.Strings[3];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].LoteLiquidacao                 := Colunas.Strings[4];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].QtdeComprovantes               := Colunas.Strings[5];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].TipoPagamento                  := Colunas.Strings[6];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].TipoTransacao                  := Colunas.Strings[7];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].Descricaotransacao             := Colunas.Strings[8];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].CNPJBeneficiarioLockin         := Colunas.Strings[9];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].TipoLockin                     := Colunas.Strings[10];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].TipoContaPagamento             := Colunas.Strings[11];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].StatusPagamento                := Colunas.Strings[12];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].ReferenciadeVenda              := Colunas.Strings[13];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].DataTransacao                  := CorrigeCampoData(Colunas.Strings[14]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].HorarioCriacao                 := Colunas.Strings[15];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NumeroParcela                  := CorrigeNumeroParcela(Colunas.Strings[16]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].TotalParcelas                  := Colunas.Strings[17];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NumeroConta                    := Colunas.Strings[18];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].DataProcessamentoTransacao     := CorrigeCampoData(Colunas.Strings[19]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].DataPrevistaPagamentoTransacao := CorrigeCampoData(Colunas.Strings[20]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NumeroCartao                   := Colunas.Strings[21];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].CodigoAutorizacao              := Colunas.Strings[22];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NumeroComprovanteNSU           := Colunas.Strings[23];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].TipoComprovante                := CorrigirTexto(Colunas.Strings[24]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].ValorBrutoVenda                := CorrigeCampoNumerico(Colunas.Strings[25]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].ValorTaxaMDR                   := CorrigeCampoNumerico(Colunas.Strings[26]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].ValorLiquidoVenda              := CorrigeCampoNumerico(Colunas.Strings[27]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].ValorTaxaAntecipacao           := CorrigeCampoNumerico(Colunas.Strings[28]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].ValorLiquidoAntecipacao        := CorrigeCampoNumerico(Colunas.Strings[29]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].AcquirerReferenceNumber        := Colunas.Strings[30];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].CancelId                       := Colunas.Strings[21];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NumeroRegistroArquivo          := Colunas.Strings[32];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NomeArquivo                    := FNomeArquivo;

  If FEmptyStr(FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NumeroComprovanteNSU) Then
    FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NumeroComprovanteNSU := '0';

  If FEmptyStr(FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].CodigoAutorizacao) Then
    FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].CodigoAutorizacao := '0';

  If Not Assigned(lstEstabel) Then
    lstEstabel := TStringList.Create;

  If (FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].Estabelecimento <> '') And
     (lstEstabel.IndexOf(FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 -1 ].Estabelecimento) < 0) Then
    lstEstabel.Add(FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 -1].Estabelecimento);
end;

procedure TSipagPgtoV2.ImportaDebitos;
begin
  SetLength(FRegistroSipagMovimentoFinanceiroV2, Length(FRegistroSipagMovimentoFinanceiroV2)+1);
  Inc(FIncAddMovimentoFinanceiroV2);

  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].TipoRegistro                   := Colunas.Strings[0];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].BandeiraCartao                 := Colunas.Strings[1];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].DataPagamento                  := CorrigeCampoData(Colunas.Strings[2]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].Estabelecimento                := Colunas.Strings[3];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].LoteLiquidacao                 := Colunas.Strings[4];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].QtdeComprovantes               := Colunas.Strings[5];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].TipoPagamento                  := Colunas.Strings[6];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].TipoTransacao                  := Colunas.Strings[7];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].Descricaotransacao             := Colunas.Strings[8];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].CNPJBeneficiarioLockin         := Colunas.Strings[9];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].TipoLockin                     := Colunas.Strings[10];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].TipoContaPagamento             := Colunas.Strings[11];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].StatusPagamento                := Colunas.Strings[12];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].ReferenciadeVenda              := Colunas.Strings[13];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].DataTransacao                  := CorrigeCampoData(Colunas.Strings[14]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].HorarioCriacao                 := Colunas.Strings[15];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NumeroParcela                  := '01';
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].TotalParcelas                  := '01';
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NumeroConta                    := Colunas.Strings[16];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].DataProcessamentoTransacao     := CorrigeCampoData(Colunas.Strings[17]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].DataPrevistaPagamentoTransacao := CorrigeCampoData(Colunas.Strings[18]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NumeroCartao                   := Colunas.Strings[19];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].CodigoAutorizacao              := Colunas.Strings[20];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NumeroComprovanteNSU           := Colunas.Strings[21];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].TipoComprovante                := CorrigirTexto(Colunas.Strings[22]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].ValorBrutoVenda                := CorrigeCampoNumerico(Colunas.Strings[23]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].ValorTaxaMDR                   := CorrigeCampoNumerico(Colunas.Strings[24]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].ValorLiquidoVenda              := CorrigeCampoNumerico(Colunas.Strings[25]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].ValorTaxaAntecipacao           := CorrigeCampoNumerico(Colunas.Strings[26]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].ValorLiquidoAntecipacao        := CorrigeCampoNumerico(Colunas.Strings[27]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].ReversaoIntercambio            := CorrigeCampoNumerico(Colunas.Strings[28]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].AcquirerReferenceNumber        := Colunas.Strings[29];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].CancelId                       := Colunas.Strings[30];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NumeroRegistroArquivo          := Colunas.Strings[31];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NomeArquivo                    := FNomeArquivo;

  If FEmptyStr(FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NumeroComprovanteNSU) Then
    FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NumeroComprovanteNSU := '0';

  If FEmptyStr(FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].CodigoAutorizacao) Then
    FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].CodigoAutorizacao := '0';

  If Not Assigned(lstEstabel) Then
    lstEstabel := TStringList.Create;

  If (FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].Estabelecimento <> '') And
     (lstEstabel.IndexOf(FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 -1 ].Estabelecimento) < 0) Then
    lstEstabel.Add(FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 -1].Estabelecimento);
end;

procedure TSipagPgtoV2.pAdicionaLinha(strString: String);
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

  Colunas.Delimiter := RetornaDelimitador(strString);
  Colunas.StrictDelimiter := True;
  Colunas.DelimitedText := fConverteParaAcento(strString);
  If fEmptyStr(Colunas.Text) Then
    Exit;

  // Registro 025 – Detalhe Ordem de Pagamento de Crédito Parcelado
  If Colunas.Strings[0].Equals('025') Then
  begin
    ImportaCreditoParcelado;
  end

  // Detalhamento (Pagamento) – Registro 021 – Detalhe da Ordem de Pagamento de Débito
  Else If Colunas.Strings[0].Equals('021') Then
  begin
    ImportaDebitos;
  end

  // Detalhamento (Pagamento) – Registro 023 – - Detalhamento Ordem de Pagamento de Crédito à vista
  Else IF Colunas.Strings[0].Equals('023') Then
  begin
    ImportaCredito;
  end

  // Registro 031 – Ajustes Programados (Lançamentos futuros - Próximos 30 Dias)
  Else If Colunas.Strings[0].Equals('031') Then
  begin
    ImportaAjustesProgramados;
  end;

end;

procedure TSipagPgtoV2.pGravarRegistros(pgbProg: TProgressBar);
  Var
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

      If Length(FRegistroSipagMovimentoFinanceiroV2) > 0 Then
      Begin
        LMovimentoFinanceiro := untFuncoes.CriarQueryDLL;

        LMovimentoFinanceiro.Close;
        LMovimentoFinanceiro.SQL.Clear;
        LMovimentoFinanceiro.SQL.Text := RetornaReplaceTabela('SIP_SIPGT2',['SIP_CONCIL']);

        pgbProg.Max := Length(FRegistroSipagMovimentoFinanceiroV2) - 1;

        For LContador := 0 To Length(FRegistroSipagMovimentoFinanceiroV2) - 1 Do
        Begin

          LMovimentoFinanceiro.Close;
          LMovimentoFinanceiro.ParamByName('SIP_TIPREG').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].TipoRegistro);
          LMovimentoFinanceiro.ParamByName('SIP_NOMBAN').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].BandeiraCartao);
          LMovimentoFinanceiro.ParamByName('SIP_DTAPAG').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].DataPagamento);
          LMovimentoFinanceiro.ParamByName('SIP_CODEST').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].Estabelecimento);
          LMovimentoFinanceiro.ParamByName('SIP_LOTLIQ').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].LoteLiquidacao );
          LMovimentoFinanceiro.ParamByName('SIP_QTCOMP').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].QtdeComprovantes);
          LMovimentoFinanceiro.ParamByName('SIP_TIPPAG').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].TipoPagamento);
          LMovimentoFinanceiro.ParamByName('SIP_TIPTRA').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].TipoTransacao);
          LMovimentoFinanceiro.ParamByName('SIP_DESTRA').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].Descricaotransacao);
          LMovimentoFinanceiro.ParamByName('SIP_CNPJLC').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].CNPJBeneficiarioLockin);
          LMovimentoFinanceiro.ParamByName('SIP_TIPLOC').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].TipoLockin);
          LMovimentoFinanceiro.ParamByName('SIP_TIPCTA').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].TipoContaPagamento);
          LMovimentoFinanceiro.ParamByName('SIP_TOTPAR').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].TotalParcelas);
          LMovimentoFinanceiro.ParamByName('SIP_NUMPAR').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].NumeroParcela);
          LMovimentoFinanceiro.ParamByName('SIP_STATUS').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].StatusPagamento);
          LMovimentoFinanceiro.ParamByName('SIP_REFVEN').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].ReferenciadeVenda);
          LMovimentoFinanceiro.ParamByName('SIP_DTAPRO').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].DataProcessamentoTransacao);
          LMovimentoFinanceiro.ParamByName('SIP_DTATRA').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].DataTransacao);
          LMovimentoFinanceiro.ParamByName('SIP_HORTRA').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].HorarioCriacao);
          LMovimentoFinanceiro.ParamByName('SIP_DTAPRE').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].DataPrevistaPagamentoTransacao);
          LMovimentoFinanceiro.ParamByName('SIP_NUMCAR').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].NumeroCartao);
          LMovimentoFinanceiro.ParamByName('SIP_CODAUT').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].CodigoAutorizacao);
          LMovimentoFinanceiro.ParamByName('SIP_NUMNSU').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].NumeroComprovanteNSU);
          LMovimentoFinanceiro.ParamByName('SIP_TIPCON').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].TipoComprovante);
          LMovimentoFinanceiro.ParamByName('SIP_VALBRU').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].ValorBrutoVenda);
          LMovimentoFinanceiro.ParamByName('SIP_VALTAX').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].ValorTaxaMDR);
          LMovimentoFinanceiro.ParamByName('SIP_VALLIQ').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].ValorLiquidoVenda);
          LMovimentoFinanceiro.ParamByName('SIP_TAXANT').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].ValorTaxaAntecipacao);
          LMovimentoFinanceiro.ParamByName('SIP_LIQANT').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].ValorLiquidoAntecipacao);
          LMovimentoFinanceiro.ParamByName('SIP_ACQRER').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].AcquirerReferenceNumber);
          LMovimentoFinanceiro.ParamByName('SIP_CANCEL').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].CancelId);
          LMovimentoFinanceiro.ParamByName('SIP_DTAAJU').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].DataDoAjuste);
          LMovimentoFinanceiro.ParamByName('SIP_VALAJU').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].ValorAjustado);
          LMovimentoFinanceiro.ParamByName('SIP_VBRUAJ').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].ValorBrutoAjuste);
          LMovimentoFinanceiro.ParamByName('SIP_TERMIN').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].NumeroTerminal);
          LMovimentoFinanceiro.ParamByName('SIP_SEQARQ').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].NumeroRegistroArquivo);
          LMovimentoFinanceiro.ParamByName('SIP_NOMARQ').Value := CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].NomeArquivo);
          LMovimentoFinanceiro.ExecSQL;

          If Not MatchStr(FRegistroSipagMovimentoFinanceiroV2[LContador].TipoRegistro,['031']) Then
            FImportouPagamentosV2 := True;

          pStep(pgbProg);
        End;

        SetLength(FRegistroSipagMovimentoFinanceiroV2,0);

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

end;

function TSipagPgtoV2.RetornaDelimitador(AText: String): Char;
begin
  Result := ',';

  If Pos(';',AText) > 0 Then
    Result := ';';
end;

end.
