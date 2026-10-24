{**************************************}
{* Importação de arquivos da SIPAG V2 *}
{***********************************AJ*}
unit untSipagPgtoV2;

interface

uses System.Classes, System.StrUtils, System.SysUtils, System.Variants,
     Vcl.ComCtrls, Vcl.Forms, System.Math,

     Uni, cxProgressBar,

     untISipagIntegracaoLibCartoes, untTSipagFuncoes, untSipagTipos;

Type
  TSipagPgtoV2 = Class(TInterfacedObject, ICartoes)
  Private
    strRegAnt: String;
    FColunas:TStringList;
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
    procedure AplicaSinalNegativoQuando202Ou400(var ARegistro : TRegistroMovimentoFinanceiroV2);
  Public
    constructor Create;
    Destructor Destroy; Override;
    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(pgbProg: TcxProgressBar);

    property NomeArquivo: String read FNomeArquivo write FNomeArquivo;
  End;

Var
  strNomArq,
  strArqAnt: String;
  FImportouPagamentosV2: Boolean;
  FArquivoSipagV2: Boolean;

  FIncAddMovimentoFinanceiroV2:Integer;

  FRegistroSipagMovimentoFinanceiroV2: TArrRegistroSipagMovimentoFinanceiroV2;
  FRegSipagPgtoV2: TArrRegistroSipagPgtoV2;

implementation

{ TSipagPgtoV2 }

procedure TSipagPgtoV2.AplicaSinalNegativoQuando202Ou400(var ARegistro : TRegistroMovimentoFinanceiroV2);
begin
  If Not LeftStr(ARegistro.TipoComprovante, 1).Equals('D') Then
    Exit;

  If MatchStr(LeftStr(ARegistro.Descricaotransacao, 3), ['202', '400']) Then
  Begin
    ARegistro.ValorBrutoVenda         := ConverterParaNegativo(ARegistro.ValorBrutoVenda);
    ARegistro.ValorTaxaMDR            := ConverterParaNegativo(ARegistro.ValorTaxaMDR);
    ARegistro.ValorLiquidoVenda       := ConverterParaNegativo(ARegistro.ValorLiquidoVenda);
    ARegistro.ValorTaxaAntecipacao    := ConverterParaNegativo(ARegistro.ValorTaxaAntecipacao);
    ARegistro.ValorLiquidoAntecipacao := ConverterParaNegativo(ARegistro.ValorLiquidoAntecipacao);
  End;
end;

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

  If TSipagFuncoes.fEmptyStr(ADate) Then
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

    If Not TSipagFuncoes.fEmptyStr(AValor) Then
      Result := (StrToFloat(AValor)/100).ToString;

    Result  := StringReplace(Result,',','.',[rfReplaceAll]);
  Except
    Result := '';
  End;
end;

function TSipagPgtoV2.CorrigeDadosBanco(AValor: Variant): Variant;
begin
  Result := Null;
  If Not TSipagFuncoes.fEmptyStr(AValor) Then
  Begin
    Result := AValor;
  End;
end;

function TSipagPgtoV2.CorrigeNumeroParcela(AParcela: String): String;
begin
  If TSipagFuncoes.fEmptyStr(AParcela) Then
    AParcela := '1'
  Else If AParcela.Equals(TSipagFuncoes.fStrZero('0',AParcela.Length)) Then
    AParcela := '1'
  Else If Trim(AParcela).Equals('-') Then
    AParcela := '1';

  Result := LeftStr(AParcela,2);
  Result := TSipagFuncoes.fStrZero(Result.Replace('/',''),2);
end;

constructor TSipagPgtoV2.Create;
Begin
  FIncAddMovimentoFinanceiroV2 := 0;
  strRegAnt := '';
  FColunas := TStringList.Create;
  FImportouPagamentosV2 := False;
End;

{************************************************}
{* RETORNA A ESTRUTURA DA  TABELA  DE PAGAMENTO *}
{* SIP_SIPGTO                                   *}
{*********************************************AJ*}
destructor TSipagPgtoV2.Destroy;
begin
  If Assigned(FColunas) Then
    FreeAndNil(FColunas);
  inherited;
end;

procedure TSipagPgtoV2.ImportaAjustesProgramados;
begin
  SetLength(FRegistroSipagMovimentoFinanceiroV2, Length(FRegistroSipagMovimentoFinanceiroV2) + 1);
  Inc(FIncAddMovimentoFinanceiroV2);

  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].TipoRegistro            := FColunas.Strings[0];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].BandeiraCartao          := FColunas.Strings[1];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].DataPagamento           := CorrigeCampoData(FColunas.Strings[2]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].Estabelecimento         := FColunas.Strings[3];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].NumeroResumoVenda       := FColunas.Strings[4];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].TipoTransacao           := FColunas.Strings[5];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].ReferenciadeVenda       := FColunas.Strings[6];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].DataTransacao           := CorrigeCampoData(FColunas.Strings[7]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].NumeroParcela           := FColunas.Strings[8];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].TotalParcelas           := FColunas.Strings[9];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].DataDoAjuste            := CorrigeCampoData(FColunas.Strings[10]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].NumeroCartao            := FColunas.Strings[11];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].CodigoAutorizacao       := FColunas.Strings[12];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].NumeroComprovanteVenda  := FColunas.Strings[13];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].TipoComprovante         := TSipagFuncoes.CorrigirTexto(FColunas.Strings[14]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].ValorBrutoVenda         := CorrigeCampoNumerico(FColunas.Strings[15]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].ValorLiquidoVenda       := CorrigeCampoNumerico(FColunas.Strings[16]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].ValorBrutoAjuste        := CorrigeCampoNumerico(FColunas.Strings[17]);

  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].NumeroTerminal          := FColunas.Strings[18];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].AcquirerReferenceNumber := FColunas.Strings[19];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].NumeroRegistroArquivo   := FColunas.Strings[20];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].NomeArquivo             :=  FNomeArquivo;

  If TSipagFuncoes.fEmptyStr(FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NumeroComprovanteNSU) Then
    FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NumeroComprovanteNSU := '0';

  If TSipagFuncoes.fEmptyStr(FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].Descricaotransacao) Then
    FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].Descricaotransacao := '0';

  If TSipagFuncoes.fEmptyStr(FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].CodigoAutorizacao) Then
    FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].CodigoAutorizacao := '0';

  If TSipagFuncoes.fEmptyStr(FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NumeroParcela) Then
    FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NumeroParcela := '01';

  If TSipagFuncoes.fEmptyStr(FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].TotalParcelas) Then
    FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].TotalParcelas := '01';

 If LeftStr(FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 -1].TipoComprovante, 1).Equals('D') Then
 Begin
   FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].ValorBrutoVenda   := ConverterParaNegativo(FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].ValorBrutoVenda);
   FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].ValorLiquidoVenda := ConverterParaNegativo(FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].ValorLiquidoVenda);
   FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].ValorBrutoAjuste  := ConverterParaNegativo(FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].ValorBrutoAjuste);
 End;

  If Not Assigned(VS_ListaEstabelecimentos) Then
    VS_ListaEstabelecimentos := TStringList.Create;

  If (FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].Estabelecimento <> '') And
     (VS_ListaEstabelecimentos.IndexOf(FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].Estabelecimento) < 0) Then
    VS_ListaEstabelecimentos.Add(FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].Estabelecimento);
end;

procedure TSipagPgtoV2.ImportaCredito;
begin
  SetLength(FRegistroSipagMovimentoFinanceiroV2, Length(FRegistroSipagMovimentoFinanceiroV2)+1);
  Inc(FIncAddMovimentoFinanceiroV2);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].TipoRegistro                   := FColunas.Strings[0];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].BandeiraCartao                 := FColunas.Strings[1];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].DataPagamento                  := CorrigeCampoData(FColunas.Strings[2]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].Estabelecimento                := FColunas.Strings[3];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].LoteLiquidacao                 := FColunas.Strings[4];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].QtdeComprovantes               := FColunas.Strings[5];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].TipoPagamento                  := FColunas.Strings[6];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].TipoTransacao                  := FColunas.Strings[7];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].Descricaotransacao             := FColunas.Strings[8];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].CNPJBeneficiarioLockin         := FColunas.Strings[9];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].TipoLockin                     := FColunas.Strings[10];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].TipoContaPagamento             := FColunas.Strings[11];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].StatusPagamento                := FColunas.Strings[12];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].ReferenciadeVenda              := FColunas.Strings[13];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].DataTransacao                  := CorrigeCampoData(FColunas.Strings[14]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].HorarioCriacao                 := FColunas.Strings[15];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NumeroParcela                  := '01';
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].TotalParcelas                  := '01';
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NumeroConta                    := FColunas.Strings[16];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].DataProcessamentoTransacao     := CorrigeCampoData(FColunas.Strings[17]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].DataPrevistaPagamentoTransacao := CorrigeCampoData(FColunas.Strings[18]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NumeroCartao                   := FColunas.Strings[19];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].CodigoAutorizacao              := FColunas.Strings[20];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NumeroComprovanteNSU           := FColunas.Strings[21];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].TipoComprovante                := TSipagFuncoes.CorrigirTexto(FColunas.Strings[22]);

  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].ValorBrutoVenda                := CorrigeCampoNumerico(FColunas.Strings[23]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].ValorTaxaMDR                   := CorrigeCampoNumerico(FColunas.Strings[24]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].ValorLiquidoVenda              := CorrigeCampoNumerico(FColunas.Strings[25]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].ValorTaxaAntecipacao           := CorrigeCampoNumerico(FColunas.Strings[26]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].ValorLiquidoAntecipacao        := CorrigeCampoNumerico(FColunas.Strings[27]);

  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].AcquirerReferenceNumber        := FColunas.Strings[28];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].CancelId                       := FColunas.Strings[29];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NumeroRegistroArquivo          := FColunas.Strings[30];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NomeArquivo                    := FNomeArquivo;

  AplicaSinalNegativoQuando202Ou400(FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1]);

  If TSipagFuncoes.fEmptyStr(FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NumeroComprovanteNSU) Then
    FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NumeroComprovanteNSU := '0';

  If TSipagFuncoes.fEmptyStr(FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].Descricaotransacao) Then
    FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].Descricaotransacao := '0';

  If TSipagFuncoes.fEmptyStr(FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].CodigoAutorizacao) Then
    FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].CodigoAutorizacao := '0';

  If Not Assigned(VS_ListaEstabelecimentos) Then
    VS_ListaEstabelecimentos := TStringList.Create;

  If (FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].Estabelecimento <> '') And
     (VS_ListaEstabelecimentos.IndexOf(FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 -1 ].Estabelecimento) < 0) Then
    VS_ListaEstabelecimentos.Add(FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 -1].Estabelecimento);
end;

procedure TSipagPgtoV2.ImportaCreditoParcelado;
begin
  SetLength(FRegistroSipagMovimentoFinanceiroV2, Length(FRegistroSipagMovimentoFinanceiroV2)+1);
  Inc(FIncAddMovimentoFinanceiroV2);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].TipoRegistro                   := FColunas.Strings[0];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].BandeiraCartao                 := FColunas.Strings[1];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].DataPagamento                  := CorrigeCampoData(FColunas.Strings[2]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].Estabelecimento                := FColunas.Strings[3];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].LoteLiquidacao                 := FColunas.Strings[4];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].QtdeComprovantes               := FColunas.Strings[5];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].TipoPagamento                  := FColunas.Strings[6];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].TipoTransacao                  := FColunas.Strings[7];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].Descricaotransacao             := FColunas.Strings[8];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].CNPJBeneficiarioLockin         := FColunas.Strings[9];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].TipoLockin                     := FColunas.Strings[10];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].TipoContaPagamento             := FColunas.Strings[11];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].StatusPagamento                := FColunas.Strings[12];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].ReferenciadeVenda              := FColunas.Strings[13];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].DataTransacao                  := CorrigeCampoData(FColunas.Strings[14]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].HorarioCriacao                 := FColunas.Strings[15];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NumeroParcela                  := CorrigeNumeroParcela(FColunas.Strings[16]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].TotalParcelas                  := FColunas.Strings[17];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NumeroConta                    := FColunas.Strings[18];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].DataProcessamentoTransacao     := CorrigeCampoData(FColunas.Strings[19]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].DataPrevistaPagamentoTransacao := CorrigeCampoData(FColunas.Strings[20]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NumeroCartao                   := FColunas.Strings[21];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].CodigoAutorizacao              := FColunas.Strings[22];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NumeroComprovanteNSU           := FColunas.Strings[23];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].TipoComprovante                := TSipagFuncoes.CorrigirTexto(FColunas.Strings[24]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].ValorBrutoVenda                := CorrigeCampoNumerico(FColunas.Strings[25]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].ValorTaxaMDR                   := CorrigeCampoNumerico(FColunas.Strings[26]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].ValorLiquidoVenda              := CorrigeCampoNumerico(FColunas.Strings[27]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].ValorTaxaAntecipacao           := CorrigeCampoNumerico(FColunas.Strings[28]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].ValorLiquidoAntecipacao        := CorrigeCampoNumerico(FColunas.Strings[29]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].AcquirerReferenceNumber        := FColunas.Strings[30];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].CancelId                       := FColunas.Strings[21];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NumeroRegistroArquivo          := FColunas.Strings[32];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NomeArquivo                    := FNomeArquivo;

  AplicaSinalNegativoQuando202Ou400(FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1]);

  If TSipagFuncoes.fEmptyStr(FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NumeroComprovanteNSU) Then
    FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NumeroComprovanteNSU := '0';

  If TSipagFuncoes.fEmptyStr(FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].Descricaotransacao) Then
    FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].Descricaotransacao := '0';

  If TSipagFuncoes.fEmptyStr(FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].CodigoAutorizacao) Then
    FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].CodigoAutorizacao := '0';

  If Not Assigned(VS_ListaEstabelecimentos) Then
    VS_ListaEstabelecimentos := TStringList.Create;

  If (FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].Estabelecimento <> '') And
     (VS_ListaEstabelecimentos.IndexOf(FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 -1 ].Estabelecimento) < 0) Then
    VS_ListaEstabelecimentos.Add(FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 -1].Estabelecimento);
end;

procedure TSipagPgtoV2.ImportaDebitos;
begin
  SetLength(FRegistroSipagMovimentoFinanceiroV2, Length(FRegistroSipagMovimentoFinanceiroV2)+1);
  Inc(FIncAddMovimentoFinanceiroV2);

  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].TipoRegistro                   := FColunas.Strings[0];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].BandeiraCartao                 := FColunas.Strings[1];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].DataPagamento                  := CorrigeCampoData(FColunas.Strings[2]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].Estabelecimento                := FColunas.Strings[3];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].LoteLiquidacao                 := FColunas.Strings[4];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].QtdeComprovantes               := FColunas.Strings[5];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].TipoPagamento                  := FColunas.Strings[6];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].TipoTransacao                  := FColunas.Strings[7];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].Descricaotransacao             := FColunas.Strings[8];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].CNPJBeneficiarioLockin         := FColunas.Strings[9];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].TipoLockin                     := FColunas.Strings[10];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].TipoContaPagamento             := FColunas.Strings[11];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].StatusPagamento                := FColunas.Strings[12];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].ReferenciadeVenda              := FColunas.Strings[13];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].DataTransacao                  := CorrigeCampoData(FColunas.Strings[14]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].HorarioCriacao                 := FColunas.Strings[15];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NumeroParcela                  := '01';
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].TotalParcelas                  := '01';
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NumeroConta                    := FColunas.Strings[16];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].DataProcessamentoTransacao     := CorrigeCampoData(FColunas.Strings[17]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].DataPrevistaPagamentoTransacao := CorrigeCampoData(FColunas.Strings[18]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NumeroCartao                   := FColunas.Strings[19];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].CodigoAutorizacao              := FColunas.Strings[20];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NumeroComprovanteNSU           := FColunas.Strings[21];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].TipoComprovante                := TSipagFuncoes.CorrigirTexto(FColunas.Strings[22]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].ValorBrutoVenda                := CorrigeCampoNumerico(FColunas.Strings[23]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].ValorTaxaMDR                   := CorrigeCampoNumerico(FColunas.Strings[24]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].ValorLiquidoVenda              := CorrigeCampoNumerico(FColunas.Strings[25]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].ValorTaxaAntecipacao           := CorrigeCampoNumerico(FColunas.Strings[26]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].ValorLiquidoAntecipacao        := CorrigeCampoNumerico(FColunas.Strings[27]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].ReversaoIntercambio            := CorrigeCampoNumerico(FColunas.Strings[28]);
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].AcquirerReferenceNumber        := FColunas.Strings[29];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].CancelId                       := FColunas.Strings[30];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NumeroRegistroArquivo          := FColunas.Strings[31];
  FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NomeArquivo                    := FNomeArquivo;

  AplicaSinalNegativoQuando202Ou400(FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1]);

  If TSipagFuncoes.fEmptyStr(FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NumeroComprovanteNSU) Then
    FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NumeroComprovanteNSU := '0';

 If TSipagFuncoes.fEmptyStr(FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].Descricaotransacao) Then
    FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].Descricaotransacao := '0';

  If MatchStr(FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].DescricaoTransacao,['400']) And
    (TSipagFuncoes.FEmptyStr(FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].CodigoAutorizacao) Or
     FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].CodigoAutorizacao.Equals('0')) Then
  Begin
    FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].CodigoAutorizacao := FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].NumeroRegistroArquivo;
  End;

  If TSipagFuncoes.FEmptyStr(FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].CodigoAutorizacao) Then
    FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2-1].CodigoAutorizacao := '0';


  If Not Assigned(VS_ListaEstabelecimentos) Then
    VS_ListaEstabelecimentos := TStringList.Create;

  If (FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 - 1].Estabelecimento <> '') And
     (VS_ListaEstabelecimentos.IndexOf(FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 -1 ].Estabelecimento) < 0) Then
    VS_ListaEstabelecimentos.Add(FRegistroSipagMovimentoFinanceiroV2[FIncAddMovimentoFinanceiroV2 -1].Estabelecimento);
end;

procedure TSipagPgtoV2.pAdicionaLinha(strString: String);
Var
  lstCampos: TStringList;
begin
  lstCampos := TStringList.Create;
  lstCampos.Delimiter     := ',';
  lstCampos.DelimitedText := StringReplace(strString, ' ', EmptyStr, [rfReplaceAll]);

  If Not Assigned(VS_ListaEstabelecimentos) Then
    VS_ListaEstabelecimentos := TStringList.Create;

  FColunas.Delimiter := RetornaDelimitador(strString);
  FColunas.StrictDelimiter := True;
  FColunas.DelimitedText := TSipagFuncoes.fConverteParaAcento(strString);
  If TSipagFuncoes.fEmptyStr(FColunas.Text) Then
    Exit;

  // Registro 025 – Detalhe Ordem de Pagamento de Crédito Parcelado
  If FColunas.Strings[0].Equals('025') Then
  begin
    ImportaCreditoParcelado;
  end

  // Detalhamento (Pagamento) – Registro 021 – Detalhe da Ordem de Pagamento de Débito
  Else If FColunas.Strings[0].Equals('021') Then
  begin
    ImportaDebitos;
  end

  // Detalhamento (Pagamento) – Registro 023 – - Detalhamento Ordem de Pagamento de Crédito à vista
  Else IF FColunas.Strings[0].Equals('023') Then
  begin
    ImportaCredito;
  end

  // Registro 031 – Ajustes Programados (Lançamentos futuros - Próximos 30 Dias)
  Else If FColunas.Strings[0].Equals('031') Then
  begin
    ImportaAjustesProgramados;
  end;

end;

procedure TSipagPgtoV2.pGravarRegistros(pgbProg: TcxProgressBar);
  Var
    LMovimentoFinanceiro : TUniQuery;
    LExcluiOutroArquivo : TUniQuery;
    LContador: Integer;
    LParametro: Integer;
begin
  LMovimentoFinanceiro := Nil;
  LExcluiOutroArquivo := Nil;
  Try

    pgbProg.Position := 0;

    If Length(FRegistroSipagMovimentoFinanceiroV2) > 0 Then
    Begin
      LMovimentoFinanceiro := VS_FuncoesExternas.fICriaQuery;

      LMovimentoFinanceiro.SQL.Text := TSipagFuncoes.RetornaSQLReplace('SIP_SIPGT2',['SIP_CONCIL']);

      // Mesmo pagamento vindo de OUTRO arquivo do mesmo dia (a SIPAG reenvia o arquivo de pagamentos, às
      // vezes com os registros em outra ordem): apaga o registro do arquivo anterior antes de gravar. Como o
      // número do registro no arquivo (SIP_SEQARQ) faz parte da chave da tabela, sem isso o REPLACE não o
      // substituía e o pagamento entrava duas vezes na conciliação. Registros iguais dentro do MESMO arquivo
      // continuam sendo gravados todos (Req. 439837).
      // A referência do adquirente (SIP_ACQRER) fica fora da comparação: a coluna é inteira e não comporta o
      // valor do arquivo (12 dígitos na VISA, que o MySQL grava como 2147483647; letras e números na
      // Mastercard), então o valor gravado não é igual ao do arquivo e a cópia da VISA não era apagada.
      LExcluiOutroArquivo := VS_FuncoesExternas.fICriaQuery;
        LExcluiOutroArquivo.SQL.Text :=
          'DELETE FROM SIP_SIPGT2                                   ' +
          ' WHERE SIP_DTAPAG <=> :SIP_DTAPAG                        ' +
          '   AND SIP_NUMNSU <=> :SIP_NUMNSU                        ' +
          '   AND SIP_NUMPAR <=> :SIP_NUMPAR                        ' +
          '   AND SIP_TIPREG <=> :SIP_TIPREG                        ' +
          '   AND SIP_TIPTRA <=> :SIP_TIPTRA                        ' +
          '   AND SIP_DESTRA <=> :SIP_DESTRA                        ' +
          '   AND SIP_NOMBAN <=> :SIP_NOMBAN                        ' +
          '   AND SIP_CODEST <=> :SIP_CODEST                        ' +
          '   AND SIP_DTATRA <=> :SIP_DTATRA                        ' +
          '   AND SIP_HORTRA <=> :SIP_HORTRA                        ' +
          '   AND SIP_VALLIQ <=> :SIP_VALLIQ                        ' +
          '   AND SIP_NUMCAR <=> :SIP_NUMCAR                        ' +
          '   AND (    SIP_CODAUT <=> :SIP_CODAUT                   ' +
          '         OR (    :SIP_DESTRA = ''400''                   ' +
          '             AND :SIP_CODAUT = :SIP_SEQARQ               ' +
          '             AND SIP_CODAUT = SIP_SEQARQ))               ' +
          '   AND SIP_NOMARQ <> :SIP_NOMARQ                         ';

      pgbProg.Properties.Max := Length(FRegistroSipagMovimentoFinanceiroV2) - 1;

      For LContador := 0 To Length(FRegistroSipagMovimentoFinanceiroV2) - 1 Do
      Begin
        LMovimentoFinanceiro.Close;

        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_TIPREG', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].TipoRegistro));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_NOMBAN', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].BandeiraCartao));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_DTAPAG', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].DataPagamento));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_CODEST', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].Estabelecimento));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_LOTLIQ', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].LoteLiquidacao ));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_QTCOMP', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].QtdeComprovantes));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_TIPPAG', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].TipoPagamento));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_TIPTRA', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].TipoTransacao));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_DESTRA', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].Descricaotransacao));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_CNPJLC', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].CNPJBeneficiarioLockin));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_TIPLOC', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].TipoLockin));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_TIPCTA', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].TipoContaPagamento));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_TOTPAR', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].TotalParcelas));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_NUMPAR', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].NumeroParcela));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_STATUS', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].StatusPagamento));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_REFVEN', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].ReferenciadeVenda));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_DTAPRO', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].DataProcessamentoTransacao));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_DTATRA', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].DataTransacao));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_HORTRA', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].HorarioCriacao));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_DTAPRE', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].DataPrevistaPagamentoTransacao));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_NUMCAR', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].NumeroCartao));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_CODAUT', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].CodigoAutorizacao));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_NUMNSU', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].NumeroComprovanteNSU));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_TIPCON', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].TipoComprovante));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_VALBRU', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].ValorBrutoVenda));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_VALTAX', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].ValorTaxaMDR));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_VALLIQ', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].ValorLiquidoVenda));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_TAXANT', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].ValorTaxaAntecipacao));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_LIQANT', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].ValorLiquidoAntecipacao));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_ACQRER', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].AcquirerReferenceNumber));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_CANCEL', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].CancelId));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_DTAAJU', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].DataDoAjuste));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_VALAJU', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].ValorAjustado));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_VBRUAJ', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].ValorBrutoAjuste));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_TERMIN', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].NumeroTerminal));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_SEQARQ', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].NumeroRegistroArquivo));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_NOMARQ', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiroV2[LContador].NomeArquivo));

        LExcluiOutroArquivo.Close;
        For LParametro := 0 To LExcluiOutroArquivo.Params.Count - 1 Do
          LExcluiOutroArquivo.Params[LParametro].Value := LMovimentoFinanceiro.ParamByName(LExcluiOutroArquivo.Params[LParametro].Name).Value;
        LExcluiOutroArquivo.ExecSQL;

        LMovimentoFinanceiro.ExecSQL;

        If Not MatchStr(FRegistroSipagMovimentoFinanceiroV2[LContador].TipoRegistro,['031']) Then
          FImportouPagamentosV2 := True;

        TSipagFuncoes.pStepStatusGravacao(pgbProg);
      End;

      SetLength(FRegistroSipagMovimentoFinanceiroV2,0);

      TSipagFuncoes.GravarEstabelecimentos;
    End;
  Finally
    TSipagFuncoes.FreeAndNilDatasets(LExcluiOutroArquivo);
    TSipagFuncoes.FreeAndNilDatasets(LMovimentoFinanceiro);
  End;

end;

function TSipagPgtoV2.RetornaDelimitador(AText: String): Char;
begin
  Result := ',';

  If Pos(';',AText) > 0 Then
    Result := ';';
end;

end.
