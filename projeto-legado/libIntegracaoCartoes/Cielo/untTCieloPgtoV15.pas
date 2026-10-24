unit untTCieloPgtoV15;

interface

uses System.Classes, System.StrUtils, System.SysUtils, System.Variants,
     untIIntegracaoCartoes, Vcl.ComCtrls, Vcl.Forms,
     Math, untIDataSet, untTCielo;

Type
  TCieloPgtoV15 = Class(TInterfacedObject, ICartoes)
  private
    FPosicaoAtual: Integer;

    FDataArquivo,
    FTipoArquivo,
    FVersaoArquivo,
    FNomeArquivo,
    FEstabelecimento,

    FRegistroAnterior,

    FCodigoLiquidacao,
    FDataPagamento,
    FDataNegociacao,

    FLinhaArquivo: String;

    FContadorNegociacao,
    FContadorAjustes: Integer;

    function fGetDados(AIndiceInicial,
                       ATamanho: Integer;
                       ATipoFloat: Boolean = False;
                       AIndiceData: Integer = 0): Variant;

    function fRetVal(AValor: Variant): Variant;

    procedure CopiaDadosRegistroDAnterior;
    procedure AdicionaEstabelecimentoNaLista;
    procedure AdicionaRegistroListaVersao015;

    function RetornaTipoCartao(ATipoProduto: String): String;

    procedure AdicionaRegistroD;
    procedure AdicionaRegistroE;
    procedure AdicionaRegistroTipo8;
    procedure AdicionaRegistrosABC;

    procedure ApagarRegistrosDaVersao014;

    function DeveGravarRegistro(ARegistro: TRegistroCieloPgto015): Boolean;

    function PossuiRegistrosDeArquivosVersao014(ARegistro: TRegistroCieloPgto015): Boolean;

    function GravarRegistro(ARegistro: TRegistroCieloPgto015;
                            ADatasetPagos,
                            ADatasetNegociacao,
                            ADataSetAjustes: IDataset): Boolean;
    function EhAjuste(ARegistro: TRegistroCieloPgto015): Boolean;
  public
    constructor Create;

    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(pgbProg: TProgressBar);

    property NomeArquivo: String read FNomeArquivo write FNomeArquivo;
  end;

  Var
    FListaEstabelecimentos,
    FListaVersao015: TStringList;
    FListaVersao014: TStringList;
    FImportouPagamentos: Boolean;

implementation
Uses untFuncoes, untCieloPgto;
{ TCieloPgtoV15 }

procedure TCieloPgtoV15.AdicionaEstabelecimentoNaLista;
begin
  If FPosicaoAtual = 0 Then
    Exit;

  If FRegCieloPgto015[FPosicaoAtual-1].CodigoEstabelecimento = '' Then
    Exit;

  If PossuiRegistrosDeArquivosVersao014(FRegCieloPgto015[FPosicaoAtual-1]) Then
    Raise Exception.Create('Não é permitido importar arquivos da versão 015 e 014 para o mesmo período de pagamento.' + #13 +
                           'Utilize apenas a versão mais atual.');

  If FListaEstabelecimentos.IndexOf(FRegCieloPgto015[FPosicaoAtual-1].CodigoEstabelecimento) >= 0 Then
    Exit;

  FListaEstabelecimentos.Add(FRegCieloPgto015[FPosicaoAtual-1].CodigoEstabelecimento);
end;

procedure TCieloPgtoV15.AdicionaRegistroD;
begin
  If Not MatchStr(fGetDados(001,01), ['D']) Then
    Exit;

  FRegCieloPgto015[FPosicaoAtual-1].TipoRegistro := fGetDados(001,01);
  FRegCieloPgto015[FPosicaoAtual-1].ValorAjuste := 0;
  FRegCieloPgto015[FPosicaoAtual-1].CalculaLiqDeb := True;

  FRegCieloPgto015[FPosicaoAtual-1].CodigoBandeira := fGetDados(054,03);
  FRegCieloPgto015[FPosicaoAtual-1].TipoLiquidacao := fGetDados(057,03);
  FRegCieloPgto015[FPosicaoAtual-1].StatusPgto := fGetDados(070,02);

  FRegCieloPgto015[FPosicaoAtual-1].ValorBrutoUR := fGetDados(072,14,True);
  FRegCieloPgto015[FPosicaoAtual-1].ValorTaxaUR := fGetDados(086,14,True);
  FRegCieloPgto015[FPosicaoAtual-1].ValorLiquidoUR := fGetDados(100,14,True);

  FRegCieloPgto015[FPosicaoAtual-1].QuantidadeLancamentosUR := fGetDados(144,06);
  FRegCieloPgto015[FPosicaoAtual-1].TipoLancamento := fGetDados(150,02);
  FRegCieloPgto015[FPosicaoAtual-1].ChaveUR := fGetDados(152,100);
  FRegCieloPgto015[FPosicaoAtual-1].TipoLancamentoOriginal := fGetDados(252,02);
  FRegCieloPgto015[FPosicaoAtual-1].TipoAntecipacao := fGetDados(254,01);
  FRegCieloPgto015[FPosicaoAtual-1].NumeroAntecipacao := fGetDados(255,09);

  FRegCieloPgto015[FPosicaoAtual-1].TaxaAntecipacao := fGetDados(264,04,True);

  FRegCieloPgto015[FPosicaoAtual-1].DataPagamento := fGetDados(268,08, False, 1);
  FRegCieloPgto015[FPosicaoAtual-1].DataEnvioBanco := fGetDados(276,08, False, 1);
  FRegCieloPgto015[FPosicaoAtual-1].DataVencimentoOriginal := fGetDados(284,08, False, 1);

  FRegCieloPgto015[FPosicaoAtual-1].IndicativoGravame := fGetDados(304,01);

  FRegCieloPgto015[FPosicaoAtual-1].DataArquivo := FDataArquivo;
  FRegCieloPgto015[FPosicaoAtual-1].NomeArquivo := FNomeArquivo;
  FRegCieloPgto015[FPosicaoAtual-1].TipoArquivo := FTipoArquivo;
  FRegCieloPgto015[FPosicaoAtual-1].VersaoArquivo := FVersaoArquivo;
end;

procedure TCieloPgtoV15.AdicionaRegistroE;
begin
  If fGetDados(001,01) <> 'E' Then
    Exit;

  If (FRegistroAnterior = 'E') Then
    CopiaDadosRegistroDAnterior;

  FRegCieloPgto015[FPosicaoAtual-1].TipoRegistro := fGetDados(001,01);
  FRegCieloPgto015[FPosicaoAtual-1].CodigoEstabelecimento := fGetDados(002,10);
  FRegCieloPgto015[FPosicaoAtual-1].CodigoBandeira := fGetDados(012,03);
  FRegCieloPgto015[FPosicaoAtual-1].TipoLiquidacao := fGetDados(015,03);
  FRegCieloPgto015[FPosicaoAtual-1].NumeroParcela := fGetDados(018,02);
  FRegCieloPgto015[FPosicaoAtual-1].TotalParcelas := fGetDados(020,02);
  FRegCieloPgto015[FPosicaoAtual-1].CodigoAutorizacao := fGetDados(022,06);
  FRegCieloPgto015[FPosicaoAtual-1].TipoLancamento := fGetDados(028,02);
  FRegCieloPgto015[FPosicaoAtual-1].ChaveUR := fGetDados(030,100);

  FRegCieloPgto015[FPosicaoAtual-1].CodigoTransacaoContrato := fGetDados(130,22);
  FRegCieloPgto015[FPosicaoAtual-1].CodigoAjuste := fGetDados(152,04);
  FRegCieloPgto015[FPosicaoAtual-1].FormaPagameto := fGetDados(156,03);
  FRegCieloPgto015[FPosicaoAtual-1].TipoCartao := RetornaTipoCartao(FRegCieloPgto015[FPosicaoAtual-1].FormaPagameto);

  FRegCieloPgto015[FPosicaoAtual-1].IndicativoRecebaRapido := fGetDados(162,01);
  FRegCieloPgto015[FPosicaoAtual-1].IndicativoTaxaZero := fGetDados(163,01);
  FRegCieloPgto015[FPosicaoAtual-1].IndicativoTransacaoRejeitada := fGetDados(164,01);
  FRegCieloPgto015[FPosicaoAtual-1].IndicativoTardia := fGetDados(165,01);

  FRegCieloPgto015[FPosicaoAtual-1].NumeroCartao := fGetDados(166,06) + '******' + fGetDados(172,04);
  FRegCieloPgto015[FPosicaoAtual-1].NumeroNSU := fGetDados(176,06);
  FRegCieloPgto015[FPosicaoAtual-1].NumeroNF := fGetDados(182,10);
  FRegCieloPgto015[FPosicaoAtual-1].NumeroTID := fGetDados(192,20);
  FRegCieloPgto015[FPosicaoAtual-1].CodigoPedido := fGetDados(212,20);

  FRegCieloPgto015[FPosicaoAtual-1].ValorBrutoVenda := fGetDados(247,14,True);
  FRegCieloPgto015[FPosicaoAtual-1].ValorBrutoParcela := fGetDados(261,14,True);
  FRegCieloPgto015[FPosicaoAtual-1].ValorLiquidoVenda := fGetDados(275,14,True);
  FRegCieloPgto015[FPosicaoAtual-1].ValorComissao := fGetDados(289,14,True);
  FRegCieloPgto015[FPosicaoAtual-1].ValorComissaoMinima := fGetDados(303,14,True);
  FRegCieloPgto015[FPosicaoAtual-1].ValorTaxaMDR := fGetDados(331,14,True);
  FRegCieloPgto015[FPosicaoAtual-1].ValorTaxaRecebaRapido := fGetDados(345,14,True);
  FRegCieloPgto015[FPosicaoAtual-1].ValorTarifaAdministrativa := fGetDados(430,14,True);

  FRegCieloPgto015[FPosicaoAtual-1].GrupoCartoes := fGetDados(477,02);
  FRegCieloPgto015[FPosicaoAtual-1].CodigoVenda := fGetDados(496,15);
  FRegCieloPgto015[FPosicaoAtual-1].CodigoOriginalVenda := fGetDados(511,15);
  FRegCieloPgto015[FPosicaoAtual-1].MeioCaptura := fGetDados(541,03);
  FRegCieloPgto015[FPosicaoAtual-1].NumeroTerminal := fGetDados(544,08);
  FRegCieloPgto015[FPosicaoAtual-1].TipoLancamentoOriginal := fGetDados(552,02);
  FRegCieloPgto015[FPosicaoAtual-1].TipoTransacao := fGetDados(554,03);
  FRegCieloPgto015[FPosicaoAtual-1].NumeroOperacao := fGetDados(557,09);

  FRegCieloPgto015[FPosicaoAtual-1].DataCaptura := fGetDados(574,08, False, 1);
  FRegCieloPgto015[FPosicaoAtual-1].DataMovimento := fGetDados(582,08, False, 1);
  FRegCieloPgto015[FPosicaoAtual-1].DataTransacao := fGetDados(582,08, False, 1);
  FRegCieloPgto015[FPosicaoAtual-1].DataMovimentoOriginal := fGetDados(590,08, False, 1);

  FRegCieloPgto015[FPosicaoAtual-1].NumeroLote := fGetDados(598,07);
  FRegCieloPgto015[FPosicaoAtual-1].NumeroTransacaoProcessada := fGetDados(605,22);
  FRegCieloPgto015[FPosicaoAtual-1].MotivoRejeicao := fGetDados(627,03);

  FRegCieloPgto015[FPosicaoAtual-1].DataVencimentoOriginal := fGetDados(630,08, False, 1);
  FRegCieloPgto015[FPosicaoAtual-1].CodigoBanco := fGetDados(653,04);
  FRegCieloPgto015[FPosicaoAtual-1].CodigoAgencia := fGetDados(657,05);
  FRegCieloPgto015[FPosicaoAtual-1].CodigoConta := fGetDados(662,20);
  FRegCieloPgto015[FPosicaoAtual-1].DigitoConta := fGetDados(682,01);

  FRegCieloPgto015[FPosicaoAtual-1].TipoCaptura := fGetDados(707,02);

  If Not MatchStr(FRegCieloPgto015[FPosicaoAtual-1].TipoLancamento, ['01', '02', '03']) Then
  Begin
    FRegCieloPgto015[FPosicaoAtual-1].ValorAjuste := fGetDados(275,14,True);

    If FRegCieloPgto015[FPosicaoAtual-1].CodigoAutorizacao = '000000' Then
    Begin
      FRegCieloPgto015[FPosicaoAtual-1].CodigoAutorizacao := fStrZero(IntToStr(FContadorAjustes), 6);

      Inc(FContadorAjustes);
    End;
  End;

  FRegCieloPgto015[FPosicaoAtual-1].CalculaLiqDeb := True;
end;

procedure TCieloPgtoV15.AdicionaRegistroListaVersao015;
begin
  If FPosicaoAtual = 0 Then
    Exit;

  If FRegCieloPgto015[FPosicaoAtual-1].DataPagamento.IsEmpty Then
    Exit;

  If FRegCieloPgto015[FPosicaoAtual-1].CodigoEstabelecimento.IsEmpty Then
    Exit;

  If FListaVersao015.IndexOf(Concat(FRegCieloPgto015[FPosicaoAtual-1].CodigoEstabelecimento, '|',
                                    FRegCieloPgto015[FPosicaoAtual-1].DataPagamento)) >= 0 Then
    Exit;

  FListaVersao015.Add(Concat(FRegCieloPgto015[FPosicaoAtual-1].CodigoEstabelecimento, '|',
                             FRegCieloPgto015[FPosicaoAtual-1].DataPagamento));
end;

procedure TCieloPgtoV15.AdicionaRegistrosABC;
  Var
    LContador: Integer;
begin
  If Not MatchStr(fGetDados(001,01), ['A', 'B', 'C']) Then
    Exit;

  Try
    If fGetDados(001,01) = 'A' Then
    Begin
      FCodigoLiquidacao := fGetDados(064,20);
      FDataPagamento := fGetDados(008,06, False, 2);
      FDataNegociacao := fGetDados(002,06, False, 2);

      FContadorNegociacao := 1;

      Exit;
    End;

    If fGetDados(001,01) = 'B' Then
    Begin
      FRegCieloPgto015[FPosicaoAtual-1].TipoRegistro := fGetDados(001,01);
      FRegCieloPgto015[FPosicaoAtual-1].TipoTransacao := RightStr(fGetDados(031,03), 2);
      FRegCieloPgto015[FPosicaoAtual-1].DataTransacao := FDataNegociacao;
      FRegCieloPgto015[FPosicaoAtual-1].DataPagamento := FDataPagamento;

      FRegCieloPgto015[FPosicaoAtual-1].ValorBrutoUR := fGetDados(034,14,True);
      FRegCieloPgto015[FPosicaoAtual-1].ValorTaxaUR := fGetDados(062,05,True);
      FRegCieloPgto015[FPosicaoAtual-1].ValorLiquidoUR := fGetDados(048,14,True);

      FRegCieloPgto015[FPosicaoAtual-1].StatusPgto := '01';
      FRegCieloPgto015[FPosicaoAtual-1].NumeroOperacao := FCodigoLiquidacao;
      FRegCieloPgto015[FPosicaoAtual-1].ChaveUR := FCodigoLiquidacao;

      FRegCieloPgto015[FPosicaoAtual-1].CodigoEstabelecimento := FEstabelecimento;
      FRegCieloPgto015[FPosicaoAtual-1].ValorBrutoParcela := fGetDados(034,14,True);
      FRegCieloPgto015[FPosicaoAtual-1].NumeroParcela := '01';
      FRegCieloPgto015[FPosicaoAtual-1].TotalParcelas := '01';
      FRegCieloPgto015[FPosicaoAtual-1].CodigoAutorizacao := fPadL(IntToStr(FContadorNegociacao), 6, '0');
      FRegCieloPgto015[FPosicaoAtual-1].NumeroTID := FCodigoLiquidacao;
      FRegCieloPgto015[FPosicaoAtual-1].NumeroNSU := fPadL(IntToStr(FContadorNegociacao), 6, '0');
      FRegCieloPgto015[FPosicaoAtual-1].ValorBrutoVenda := fGetDados(034,14,True);
      FRegCieloPgto015[FPosicaoAtual-1].ValorLiquidoVenda := fGetDados(048,14,True);
      FRegCieloPgto015[FPosicaoAtual-1].ValorAjuste := fGetDados(048,14,True);
      FRegCieloPgto015[FPosicaoAtual-1].TipoCartao := ' ';
      FRegCieloPgto015[FPosicaoAtual-1].CodigoBandeira := fGetDados(028,03);
      FRegCieloPgto015[FPosicaoAtual-1].VencimentoOriginal := fGetDados(008,06);
      FRegCieloPgto015[FPosicaoAtual-1].DataVencimentoOriginal := fGetDados(008,06);

      FRegCieloPgto015[FPosicaoAtual-1].DataArquivo := FDataArquivo;
      FRegCieloPgto015[FPosicaoAtual-1].NomeArquivo := FNomeArquivo;
      FRegCieloPgto015[FPosicaoAtual-1].TipoArquivo := FTipoArquivo;
      FRegCieloPgto015[FPosicaoAtual-1].VersaoArquivo := FVersaoArquivo;

      Inc(FContadorNegociacao);

      Exit;
    End;

     If fGetDados(001,01) = 'C' Then
    Begin
      For LContador := FPosicaoAtual - (FContadorNegociacao - 1) To FPosicaoAtual  Do
      Begin
        FRegCieloPgto015[LContador].CodigoBanco := fGetDados(002,06);
        FRegCieloPgto015[LContador].CodigoAgencia := fGetDados(006,05);
        FRegCieloPgto015[LContador].CodigoConta := fGetDados(011,20);
        FRegCieloPgto015[LContador].DigitoConta := '';

        FRegCieloPgto015[LContador].ValorLiquidoVenda := fGetDados(031,14,True);
      End;
    End;
  Except
    Raise;
  End;
end;

procedure TCieloPgtoV15.AdicionaRegistroTipo8;
begin
  If fGetDados(001,01) <> '8' Then
    Exit;

  If FTipoArquivo = '03' Then
    Exit;

  FRegCieloPgto015[FPosicaoAtual-1].TipoRegistro := fGetDados(001,01);
  FRegCieloPgto015[FPosicaoAtual-1].CodigoEstabelecimento := fGetDados(002,10);
  FRegCieloPgto015[FPosicaoAtual-1].TipoTransacao := fGetDados(012,02);

  FRegCieloPgto015[FPosicaoAtual-1].DataTransacao := fGetDados(014,06, False, 2);
  FRegCieloPgto015[FPosicaoAtual-1].CodigoAutorizacao := fGetDados(026,36);
  FRegCieloPgto015[FPosicaoAtual-1].NumeroNSU := fGetDados(062,06);
  FRegCieloPgto015[FPosicaoAtual-1].ChaveUR := fGetDados(062,06);
  FRegCieloPgto015[FPosicaoAtual-1].DataPagamento := fGetDados(068,06, False, 2);

  FRegCieloPgto015[FPosicaoAtual-1].ValorBrutoUR := fGetDados(074,14,True);
  FRegCieloPgto015[FPosicaoAtual-1].ValorBrutoVenda := fGetDados(074,14,True);
  FRegCieloPgto015[FPosicaoAtual-1].ValorBrutoParcela := fGetDados(074,14,True);
  FRegCieloPgto015[FPosicaoAtual-1].ValorTaxaUR := fGetDados(088,14,True);
  FRegCieloPgto015[FPosicaoAtual-1].ValorTarifaAdministrativa := fGetDados(088,14,True);
  FRegCieloPgto015[FPosicaoAtual-1].ValorLiquidoUR := fGetDados(102,14,True);
  FRegCieloPgto015[FPosicaoAtual-1].ValorLiquidoVenda := fGetDados(102,14,True);

  FRegCieloPgto015[FPosicaoAtual-1].NumeroParcela := '01';
  FRegCieloPgto015[FPosicaoAtual-1].TotalParcelas := '01';
  FRegCieloPgto015[FPosicaoAtual-1].TipoCartao := 'PX';
  FRegCieloPgto015[FPosicaoAtual-1].StatusPgto := fGetDados(223,02);
  FRegCieloPgto015[FPosicaoAtual-1].MeioCaptura := fGetDados(160,02);
  FRegCieloPgto015[FPosicaoAtual-1].NumeroTerminal := fGetDados(162,08);

  FRegCieloPgto015[FPosicaoAtual-1].OrigemAjuste := fGetDados(220,02);
  
  If FRegCieloPgto015[FPosicaoAtual-1].OrigemAjuste <> '' Then
    FRegCieloPgto015[FPosicaoAtual-1].ValorAjuste := fGetDados(102,14,True);

  If FRegCieloPgto015[FPosicaoAtual-1].StatusPgto = '' Then
    FRegCieloPgto015[FPosicaoAtual-1].StatusPgto := '01';

  FRegCieloPgto015[FPosicaoAtual-1].DataArquivo := FDataArquivo;
  FRegCieloPgto015[FPosicaoAtual-1].NomeArquivo := FNomeArquivo;
  FRegCieloPgto015[FPosicaoAtual-1].TipoArquivo := FTipoArquivo;
  FRegCieloPgto015[FPosicaoAtual-1].VersaoArquivo := FVersaoArquivo;
end;

procedure TCieloPgtoV15.ApagarRegistrosDaVersao014;
  Var
    LApagar: IDataset;

    LItem: String;

    LValores: TStringList;
begin
  If FListaVersao015.Count = 0 Then
    Exit;

  If Not untFuncoes.ExisteScriptsDaCieloVersao015 Then
    Exit;

  LValores := TStringList.Create;
  LValores.Delimiter := '|';
  LValores.StrictDelimiter := True;

  LApagar := objFunctions.fGetDataSet;
  LApagar.SQL := 'SELECT * ' +
                 'FROM CIE_CIPGTO ' +
                 'WHERE CIE_DTAPAG=:DTAPAG ' +
                 '  AND CIE_CODEST=:CODEST ' +
                 '  AND (CIE_VERARQ IS NULL OR ' +
                 '       CIE_VERARQ<>"015") ';

  For LItem In FListaVersao015 Do
  Begin
    LApagar.Close;

    LValores.DelimitedText := LItem;

    LApagar.ParamByName('DTAPAG').Value := fRetVal(LValores[1]);
    LApagar.ParamByName('CODEST').AsString := LValores[0];
    LApagar.Open;

    While Not LApagar.Eof Do
      LApagar.Delete;
  End;

  FreeAndNil(LValores);

  FreeAndNil(FListaVersao015);
end;

procedure TCieloPgtoV15.CopiaDadosRegistroDAnterior;
begin
  FRegCieloPgto015[FPosicaoAtual-1].TipoRegistro := FRegCieloPgto015[FPosicaoAtual-2].TipoRegistro;
  FRegCieloPgto015[FPosicaoAtual-1].ValorAjuste := FRegCieloPgto015[FPosicaoAtual-2].ValorAjuste;
  FRegCieloPgto015[FPosicaoAtual-1].CalculaLiqDeb := FRegCieloPgto015[FPosicaoAtual-2].CalculaLiqDeb;

  FRegCieloPgto015[FPosicaoAtual-1].CodigoBandeira := FRegCieloPgto015[FPosicaoAtual-2].CodigoBandeira;
  FRegCieloPgto015[FPosicaoAtual-1].TipoLiquidacao := FRegCieloPgto015[FPosicaoAtual-2].TipoLiquidacao;
  FRegCieloPgto015[FPosicaoAtual-1].StatusPgto := FRegCieloPgto015[FPosicaoAtual-2].StatusPgto;

  FRegCieloPgto015[FPosicaoAtual-1].ValorBrutoUR := FRegCieloPgto015[FPosicaoAtual-2].ValorBrutoUR;
  FRegCieloPgto015[FPosicaoAtual-1].ValorTaxaUR := FRegCieloPgto015[FPosicaoAtual-2].ValorTaxaUR;
  FRegCieloPgto015[FPosicaoAtual-1].ValorLiquidoUR := FRegCieloPgto015[FPosicaoAtual-2].ValorLiquidoUR;

  FRegCieloPgto015[FPosicaoAtual-1].QuantidadeLancamentosUR := FRegCieloPgto015[FPosicaoAtual-2].QuantidadeLancamentosUR;
  FRegCieloPgto015[FPosicaoAtual-1].TipoLancamento := FRegCieloPgto015[FPosicaoAtual-2].TipoLancamento;
  FRegCieloPgto015[FPosicaoAtual-1].ChaveUR := FRegCieloPgto015[FPosicaoAtual-2].ChaveUR;
  FRegCieloPgto015[FPosicaoAtual-1].TipoLancamentoOriginal := FRegCieloPgto015[FPosicaoAtual-2].TipoLancamentoOriginal;
  FRegCieloPgto015[FPosicaoAtual-1].TipoAntecipacao := FRegCieloPgto015[FPosicaoAtual-2].TipoAntecipacao;
  FRegCieloPgto015[FPosicaoAtual-1].NumeroAntecipacao := FRegCieloPgto015[FPosicaoAtual-2].NumeroAntecipacao;

  FRegCieloPgto015[FPosicaoAtual-1].TaxaAntecipacao := FRegCieloPgto015[FPosicaoAtual-2].TaxaAntecipacao;

  FRegCieloPgto015[FPosicaoAtual-1].DataPagamento := FRegCieloPgto015[FPosicaoAtual-2].DataPagamento;
  FRegCieloPgto015[FPosicaoAtual-1].DataEnvioBanco := FRegCieloPgto015[FPosicaoAtual-2].DataEnvioBanco;
  FRegCieloPgto015[FPosicaoAtual-1].DataVencimentoOriginal := FRegCieloPgto015[FPosicaoAtual-2].DataVencimentoOriginal;

  FRegCieloPgto015[FPosicaoAtual-1].IndicativoGravame := FRegCieloPgto015[FPosicaoAtual-2].IndicativoGravame;

  FRegCieloPgto015[FPosicaoAtual-1].DataArquivo := FRegCieloPgto015[FPosicaoAtual-2].DataArquivo;
  FRegCieloPgto015[FPosicaoAtual-1].NomeArquivo := FRegCieloPgto015[FPosicaoAtual-2].NomeArquivo;
  FRegCieloPgto015[FPosicaoAtual-1].TipoArquivo := FRegCieloPgto015[FPosicaoAtual-2].TipoArquivo;
  FRegCieloPgto015[FPosicaoAtual-1].VersaoArquivo := FRegCieloPgto015[FPosicaoAtual-2].VersaoArquivo;
end;

constructor TCieloPgtoV15.Create;
begin
  FPosicaoAtual := 0;
  FContadorNegociacao := 0;
  FListaEstabelecimentos := TStringList.Create;
  FListaVersao015 := TStringList.Create;
  FImportouPagamentos := False;
end;

function TCieloPgtoV15.DeveGravarRegistro(
  ARegistro: TRegistroCieloPgto015): Boolean;
begin
  Result := False;

  If Trim(ARegistro.TipoRegistro) = '' Then
    Exit;

  If Not MatchStr(ARegistro.TipoRegistro, ['D', 'E', '8', 'B']) Then
    Exit;

  If Trim(ARegistro.CodigoEstabelecimento) = '' Then
    Exit;

  Result := True;
end;

function TCieloPgtoV15.EhAjuste(ARegistro: TRegistroCieloPgto015): Boolean;
begin
  Result := False;

  If fRetVal(ARegistro.TipoArquivo) = '04' then
  begin
    if fRetVal(ARegistro.TipoRegistro) = 'E' then
    begin
      if not MatchStr(ARegistro.TipoLancamento, ['01', '02', '03', '13', '14']) then
        Result := True;
    end
    else if fRetVal(ARegistro.TipoRegistro) = '8' then
    begin
      if fRetVal(ARegistro.TipoTransacao) <> '01' then
        Result := True;
    end;
  end;
end;

function TCieloPgtoV15.fGetDados(AIndiceInicial, ATamanho: Integer;
  ATipoFloat: Boolean = False; AIndiceData: Integer = 0): Variant;
Begin
  Result := Trim(Copy(FLinhaArquivo, AIndiceInicial, ATamanho));

  If ATipoFloat Then
    Result := fStrToFloat(Result) / 100
  Else If AIndiceData > 0 Then
  Begin
    If Trim(Result) = '' THen
      Exit;

    Case AIndiceData Of
      1: Result := Copy(Result, 5, 4) + '/' + Copy(Result, 3, 2) + '/' + Copy(Result, 1, 2);
      2: Result := Copy(Result, 1, 2) + '/' + Copy(Result, 3, 2) + '/' + Copy(Result, 5, 2);
      3: Result := Copy(Result, 1, 4) + '/' + Copy(Result, 5, 2) + '/' + Copy(Result, 7, 2);
    End;
  End;
End;

function TCieloPgtoV15.GravarRegistro(ARegistro: TRegistroCieloPgto015;
  ADatasetPagos, ADatasetNegociacao, ADataSetAjustes: IDataset): Boolean;
begin
  Result := True;

  If ARegistro.TipoRegistro = '' Then
    Exit;

  if EhAjuste(ARegistro) then
  begin
    if ADataSetAjustes.Active then
    begin
      Result := ADataSetAjustes.IsEmpty;
      Exit;
    end;
  end;

  If (ARegistro.TipoRegistro <> 'B') Then
  Begin
    if ARegistro.StatusPgto = '01' then
      Exit;

    If ADatasetPagos.Active Then
    Begin
      Result := ADatasetPagos.IsEmpty;
      Exit;
    End;
  End;

  If ARegistro.TipoRegistro = 'B' Then
  Begin
    If ADatasetNegociacao.Active Then
    Begin
      Result := ADatasetNegociacao.IsEmpty;
      Exit;
    End;
  End;
end;

procedure TCieloPgtoV15.pAdicionaLinha(strString: String);
  Const
    AUMENTO_CAPACIDADE_FREG  = 2000;
begin
  Try
    FLinhaArquivo := strString;

    If FPosicaoAtual >= Length(FRegCieloPgto015) - 1 Then
      SetLength(FRegCieloPgto015, Length(FRegCieloPgto015)+AUMENTO_CAPACIDADE_FREG);

    If fGetDados(001,01) = '' Then
      Exit;

    If fGetDados(001,01) = '0' Then
    Begin
      FDataArquivo := fGetDados(012,08, False, 3);
      FTipoArquivo := fGetDados(048,02);
      FEstabelecimento := fGetDados(002,10);
      FVersaoArquivo := fGetDados(071,03);

      FContadorNegociacao := 0;
      FContadorAjustes := 1;

      FRegistroAnterior := fGetDados(001,01);

      Exit;
    End;

    If Not MatchStr(FTipoArquivo, ['04', '15']) Then
      Exit;

    If MatchStr(fGetDados(001,01), ['D', 'E', '8', 'A', 'B', 'C']) Then
    Begin
      If MatchStr(fGetDados(001,01), ['D', '8', 'B']) Then
        Inc(FPosicaoAtual);

      If MatchStr(fGetDados(001,01), ['E']) Then
      Begin
        If FRegistroAnterior = 'E' Then
          Inc(FPosicaoAtual);
      End;

      AdicionaRegistroD;

      AdicionaRegistroE;

      AdicionaRegistrosABC;

      AdicionaRegistroTipo8;

      AdicionaEstabelecimentoNaLista;

      AdicionaRegistroListaVersao015;

      FImportouPagamentos := True;
    End;

    FRegistroAnterior := fGetDados(001,01);
  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao importar os registros do arquivo ' + FNomeArquivo + '.' + #13 +
                             'Erro gerado: ' + E.Message);
  End;
end;

function TCieloPgtoV15.fRetVal(AValor: Variant): Variant;
Begin
  If fEmptyStr(AValor) Then
    Exit(Null);

  Result := AValor;
End;

procedure TCieloPgtoV15.pGravarRegistros(pgbProg: TProgressBar);
  Var
    LNegociacao,
    LRegistrosPagos,
    LInserir,
    LAjuste: IDataset;

    LSQL: String;

    LRegistro: TRegistroCieloPgto015;

    LContador: Integer;
begin
  LRegistrosPagos := objFunctions.fGetDataSet;
  LRegistrosPagos.SQL := 'SELECT * FROM CIE_CIPGTO WHERE ' +
                         ' CIE_DTAPAG = :DTAPAG AND  ' +
                         ' CIE_CODEST = :CODEST AND  ' +
                         ' CIE_CODAUT = :CODAUT AND  ' +
                         ' CIE_NUMPAR = :NUMPAR AND  ' +
                         ' CIE_DTAVEN = :DTAVEN AND  ' +
                         ' CIE_TIPTRA = :TIPTRA AND  ' +
                         ' CIE_STATUS="01"           ';

  LNegociacao := objFunctions.fGetDataSet;
  LNegociacao.SQL := 'SELECT * FROM CIE_CIPGTO WHERE ' +
                     ' CIE_DTAPAG = :DTAPAG AND  ' +
                     ' CIE_CODEST = :CODEST AND  ' +
                     ' CIE_TIPREG = "B" AND      ' +
                     ' CIE_CODTID = :CODTID AND  ' +
                     ' CIE_VENORI = :VENORI AND  ' +
                     ' CIE_CODBAN = :CODBAN AND  ' +
                     ' CIE_RO_LIQ = :RO_LIQ      ';

  LAjuste := objFunctions.fGetDataSet;
  LAjuste.SQL := 'SELECT * FROM CIE_CIPGTO WHERE ' +
                 ' CIE_DTAPAG = :DTAPAG AND ' +
                 ' CIE_VERARQ = "015" AND ' +
                 ' CIE_LIQDEB <> 0 AND ' +
                 ' ( ' +
                 '   (CIE_TIPREG = "E" AND CIE_TIPLAN NOT IN ("01", "02", "03", "13", "14") AND CIE_TIPARQ = "04") OR ' +
                 '   (CIE_TIPREG = "8" AND CIE_TIPTRA <> "01" AND CIE_TIPARQ = "04") ' +
                 ' ) AND ' +
                 ' CIE_CODEST = :CODEST AND ' +
                 ' CIE_CODAUT = :CODAUT AND ' +
                 ' CIE_NUMPAR = :NUMPAR AND ' +
                 ' CIE_DTAVEN = :DTAVEN AND ' +
                 ' CIE_NUM_RO = :NUM_RO AND ' +
                 ' CIE_NUMNSU = :NUMNSU AND ' +
                 ' CIE_STATUS = :STATUS AND ' +
                 ' CIE_VALPAR = :VALPAR AND ' +
                 ' CIE_CONCIL = 1 ';


  LSQL := RetornaSQLReplace('CIE_CIPGTO',
                            TCieloPgto.RetornaListaDeCampos(TCieloPgto.fRetEstruturaPgto('CIE_CIPGTO')),
                            ['CIE_CONCIL']);

  LInserir := objFunctions.fGetDataSet;
  LInserir.SQL := LSQL;

  pgbProg.Position := 0;

  If Length(FRegCieloPgto015) = 0 Then
    Exit;

  ApagarRegistrosDaVersao014;

  Try
    pgbProg.Max := Length(FRegCieloPgto015);
    For LRegistro in FRegCieloPgto015 Do
    Begin
      If DeveGravarRegistro(LRegistro) Then
      Begin
        Application.ProcessMessages;

        LRegistrosPagos.Close;
        LNegociacao.Close;

        If Concat(fRetVal(LRegistro.StatusPgto), fRetVal(LRegistro.TipoRegistro)) <> '01B' Then
        Begin
          LRegistrosPagos.ParamByName('CODEST').Value := fRetVal(LRegistro.CodigoEstabelecimento);
          LRegistrosPagos.ParamByName('CODAUT').Value := fRetVal(LRegistro.CodigoAutorizacao);
          LRegistrosPagos.ParamByName('NUMPAR').Value := fRetVal(LRegistro.NumeroParcela);
          LRegistrosPagos.ParamByName('DTAPAG').Value := fRetVal(LRegistro.DataPagamento);
          LRegistrosPagos.ParamByName('DTAVEN').Value := fRetVal(LRegistro.DataTransacao);
          LRegistrosPagos.ParamByName('TIPTRA').Value := fRetVal(LRegistro.TipoTransacao);
          LRegistrosPagos.Open;
        End;

        If (fRetVal(LRegistro.TipoRegistro) = 'B') Then
        Begin
          LNegociacao.ParamByName('CODEST').Value := fRetVal(LRegistro.CodigoEstabelecimento);
          LNegociacao.ParamByName('DTAPAG').Value := fRetVal(LRegistro.DataPagamento);
          LNegociacao.ParamByName('CODTID').Value := fRetVal(LRegistro.NumeroOperacao);
          LNegociacao.ParamByName('VENORI').Value := fRetVal(LRegistro.VencimentoOriginal);
          LNegociacao.ParamByName('CODBAN').Value := fRetVal(LRegistro.CodigoBandeira);
          LNegociacao.ParamByName('RO_LIQ').Value := fRetVal(LRegistro.ValorLiquidoUR);
          LNegociacao.Open;

          If Not LNegociacao.IsEmpty Then
          Begin
            LNegociacao.Edit;
            LNegociacao.FieldByName('CIE_CONCIL').AsInteger := 0;
            LNegociacao.Post;
          End;
        End;

        If EhAjuste(LRegistro) Then
        begin
          LAjuste.Close;
          LAjuste.ParambyName('DTAPAG').Value := fRetVal(LRegistro.DataPagamento);
          LAjuste.ParambyName('CODEST').Value := fRetVal(LRegistro.CodigoEstabelecimento);
          LAjuste.ParambyName('CODAUT').Value := fRetVal(LRegistro.CodigoAutorizacao);
          LAjuste.ParambyName('NUMPAR').Value := fRetVal(LRegistro.NumeroParcela);
          LAjuste.ParambyName('DTAVEN').Value := fRetVal(LRegistro.DataTransacao);
          LAjuste.ParambyName('NUM_RO').Value := fRetVal(LeftStr(LRegistro.ChaveUR, 7));
          LAjuste.ParambyName('NUMNSU').Value := fRetVal(LRegistro.NumeroNSU);
          LAjuste.ParambyName('STATUS').Value := fRetVal(LRegistro.StatusPgto);
          LAjuste.ParambyName('VALPAR').Value := fRetVal(LRegistro.ValorBrutoParcela);
          LAjuste.Open;
        end;

        If GravarRegistro(LRegistro,
                          LRegistrosPagos,
                          LNegociacao,
                          LAjuste) Then
        Begin
          LInserir.Close;

          LInserir.ParamByName('CIE_TIPREG').Value   := fRetVal(LRegistro.TipoRegistro);
          LInserir.ParamByName('CIE_CODEST').Value   := fRetVal(LRegistro.CodigoEstabelecimento);
          LInserir.ParamByName('CIE_NUM_RO').Value   := fRetVal(LeftStr(LRegistro.ChaveUR, 7));
          LInserir.ParamByName('CIE_DTAAPR').Value   := fRetVal(LRegistro.DataTransacao);
          LInserir.ParamByName('CIE_DTAPAG').Value   := fRetVal(LRegistro.DataPagamento);
          LInserir.ParamByName('CIE_CODBCO').Value   := fRetVal(LRegistro.CodigoBanco);
          LInserir.ParamByName('CIE_CODAGE').Value   := fRetVal(LRegistro.CodigoAgencia);
          LInserir.ParamByName('CIE_NUMCCO').Value   := fRetVal(LRegistro.CodigoConta + LRegistro.DigitoConta);
          LInserir.ParamByName('CIE_RO_BRU').Value   := fRetVal(LRegistro.ValorBrutoUR);
          LInserir.ParamByName('CIE_RO_LIQ').Value   := fRetVal(LRegistro.ValorLiquidoUR);
          LInserir.ParamByName('CIE_RO_COM').Value   := fRetVal(LRegistro.ValorTaxaUR);
          LInserir.ParamByName('CIE_RO_REJ').Value   := 0.00;
          LInserir.ParamByName('CIE_STATUS').Value   := fRetVal(LRegistro.StatusPgto);
          LInserir.ParamByName('CIE_PORCOM').Value   := 0.00;

          LInserir.ParamByName('CIE_NUMANT').Value   := fRetVal(LRegistro.NumeroAntecipacao);
          If fRetVal(Trim(LRegistro.NumeroAntecipacao)) <> Null Then
            LInserir.ParamByName('CIE_BRUANT').Value   := fRetVal(LRegistro.ValorBrutoUR);

          LInserir.ParamByName('CIE_NUMNSU').Value   := fRetVal(LRegistro.NumeroNSU);
          LInserir.ParamByName('CIE_DTAVEN').Value   := fRetVal(LRegistro.DataTransacao);
          LInserir.ParamByName('CIE_NUMCAR').Value   := fRetVal(LRegistro.NumeroCartao);
          LInserir.ParamByName('CIE_VALTOT').Value   := fRetVal(LRegistro.ValorBrutoVenda);
          LInserir.ParamByName('CIE_TOTPAR').Value   := fRetVal(LRegistro.TotalParcelas);
          LInserir.ParamByName('CIE_NUMPAR').Value   := fRetVal(LRegistro.NumeroParcela);
          LInserir.ParamByName('CIE_VALPAR').Value   := fRetVal(LRegistro.ValorBrutoParcela);
          LInserir.ParamByName('CIE_VALPRO').Value   := fRetVal(LRegistro.ValorLiquidoVenda);
          LInserir.ParamByName('CIE_CODAUT').Value   := fRetVal(LRegistro.CodigoAutorizacao);
          LInserir.ParamByName('CIE_CODTID').Value   := fRetVal(LRegistro.NumeroTID);
          LInserir.ParamByName('CIE_NUMTER').Value   := fRetVal(LRegistro.NumeroTerminal);
          LInserir.ParamByName('CIE_TIPCAR').Value   := fRetVal(LRegistro.TipoCartao);
          LInserir.ParamByName('CIE_TIPFIN').Value   := ' ';
          LInserir.ParamByName('CIE_TIPTRA').Value   := fRetVal(LRegistro.TipoTransacao);
          LInserir.ParamByName('CIE_NUM_NF').Value   := fRetVal(LRegistro.NumeroNF);
          LInserir.ParamByName('CIE_NOMARQ').Value   := fRetVal(LRegistro.NomeArquivo);
          LInserir.ParamByName('CIE_DTAARQ').Value   := fRetVal(LRegistro.DataArquivo);
          LInserir.ParamByName('CIE_DTAANT').Value   := fRetVal(LRegistro.DataMovimento);
          LInserir.ParamByName('CIE_LIQANT').Value   := fRetVal(LRegistro.ValorLiquidoUR);
          LInserir.ParamByName('CIE_RO_DEB').Value   := ' ';
          LInserir.ParamByName('CIE_ORIAJU').Value   := fRetVal(LRegistro.OrigemAjuste);
          LInserir.ParamByName('CIE_CODBAN').Value   := fRetVal(LRegistro.CodigoBandeira);
          LInserir.ParamByName('CIE_CODPRO').Value   := fRetVal(LRegistro.FormaPagameto);
          LInserir.ParamByName('CIE_TIPNEG').Value   := fRetVal(LRegistro.TipoNegociacao);
          LInserir.ParamByName('CIE_VENORI').Value   := fRetVal(LRegistro.DataVencimentoOriginal);
          LInserir.ParamByName('CIE_LIQDEB').Value   := fRetVal(LRegistro.ValorAjuste);

          If LRegistro.TipoRegistro = 'B' Then
            LInserir.ParamByName('CIE_CODTID').Value   := fRetVal(LRegistro.NumeroOperacao);

          {CAMPOS NOVOS}
          If (Pos('CIE_CHA_UR',LInserir.SQL) > 0) Then
          Begin
            LInserir.ParamByName('CIE_CHA_UR').Value   := fRetVal(LRegistro.ChaveUR);
            LInserir.ParamByName('CIE_TAXANT').Value   := fRetVal(LRegistro.TaxaAntecipacao);
            LInserir.ParamByName('CIE_TIPARQ').Value   := fRetVal(LRegistro.TipoArquivo);
            LInserir.ParamByName('CIE_VERARQ').Value   := fRetVal(LRegistro.VersaoArquivo);
            LInserir.ParamByName('CIE_CODAJU').Value   := fRetVal(LRegistro.CodigoAjuste);
            LInserir.ParamByName('CIE_CODPED').Value   := fRetVal(LRegistro.CodigoPedido);
            LInserir.ParamByName('CIE_CODVEN').Value   := fRetVal(LRegistro.CodigoVenda);
            LInserir.ParamByName('CIE_CODVOR').Value   := fRetVal(LRegistro.CodigoOriginalVenda);
            LInserir.ParamByName('CIE_TIPCAP').Value   := fRetVal(LRegistro.TipoCaptura);
            LInserir.ParamByName('CIE_MEICAP').Value   := fRetVal(LRegistro.MeioCaptura);
            LInserir.ParamByName('CIE_TIPLAN').Value   := fRetVal(LRegistro.TipoLancamento);
            LInserir.ParamByName('CIE_TIPLOR').Value   := fRetVal(LRegistro.TipoLancamentoOriginal);
            LInserir.ParamByName('CIE_TIPANT').Value   := fRetVal(LRegistro.TipoAntecipacao);
            LInserir.ParamByName('CIE_MOVORI').Value   := fRetVal(LRegistro.DataMovimentoOriginal);
            LInserir.ParamByName('CIE_DTAENV').Value   := fRetVal(LRegistro.DataEnvioBanco);
            LInserir.ParamByName('CIE_GRUCAR').Value   := fRetVal(LRegistro.GrupoCartoes);
            LInserir.ParamByName('CIE_CODVEN').Value   := fRetVal(LRegistro.CodigoVenda);
            LInserir.ParamByName('CIE_VALCOM').Value   := fRetVal(LRegistro.ValorComissao);
            LInserir.ParamByName('CIE_COMMIN').Value   := fRetVal(LRegistro.ValorComissaoMinima);
            LInserir.ParamByName('CIE_TAXADM').Value   := fRetVal(LRegistro.ValorTarifaAdministrativa);
            LInserir.ParamByName('CIE_TAXMDR').Value   := fRetVal(LRegistro.ValorTaxaMDR);
            LInserir.ParamByName('CIE_TAXRAP').Value   := fRetVal(LRegistro.ValorTaxaRecebaRapido);
            LInserir.ParamByName('CIE_INDGRA').Value   := fRetVal(LRegistro.IndicativoGravame);
            LInserir.ParamByName('CIE_INDRAP').Value   := fRetVal(LRegistro.IndicativoRecebaRapido);
            LInserir.ParamByName('CIE_INDZER').Value   := fRetVal(LRegistro.IndicativoTaxaZero);
            LInserir.ParamByName('CIE_INDREJ').Value   := fRetVal(LRegistro.IndicativoTransacaoRejeitada);
            LInserir.ParamByName('CIE_INDTAR').Value   := fRetVal(LRegistro.IndicativoTardia);
            LInserir.ParamByName('CIE_TRACON').Value   := fRetVal(LRegistro.CodigoTransacaoContrato);
            LInserir.ParamByName('CIE_NUMLOT').Value   := fRetVal(LRegistro.NumeroLote);
            LInserir.ParamByName('CIE_TRAPRO').Value   := fRetVal(LRegistro.NumeroTransacaoProcessada);
            LInserir.ParamByName('CIE_MOTREJ').Value   := fRetVal(LRegistro.MotivoRejeicao);
          End;

          LInserir.ExecSQL;
          LRegistrosPagos.Close;
        End;
      End;

      pgbProg.Position := pgbProg.Position + 1;
    End;

    Try
      LInserir.Close;
      LInserir.SQL := 'REPLACE INTO ESTCAR (CAR_CODEST, CAR_NOMOPE) VALUES (:ESTAB, "CIELO")';
      For LContador := 0 To FListaEstabelecimentos.Count - 1 Do
      Begin
        LInserir.ParamByName('ESTAB').AsString := FListaEstabelecimentos[LContador];
        LInserir.ExecSQL;
      End;

      FreeAndNil(FListaEstabelecimentos);
    Except
      Raise Exception.Create('A tabela ESTCAR não foi criada. Entre em contato com a Citel!');
    End;

    pgbProg.Position := pgbProg.Max;
    Application.ProcessMessages;
  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao gravar os registros. Erro gerado: ' + E.Message);
  End;
end;

function TCieloPgtoV15.PossuiRegistrosDeArquivosVersao014(ARegistro: TRegistroCieloPgto015): Boolean;
begin
  Result := False;

  If FListaVersao014.Count = 0 Then
    Exit;

  Result := FListaVersao014.IndexOf(Concat(ARegistro.CodigoEstabelecimento, '|',
                                           RightStr(fRetSomenteNumeros(ARegistro.DataPagamento), 6))) >= 0;
end;

function TCieloPgtoV15.RetornaTipoCartao(ATipoProduto: String): String;
  Const
    PRODUTOS_ARRAY: Array[0..46] Of String = ('001', '002', '003', '004', '005',
                                              '006', '007', '008', '009', '010',
                                              '012', '019', '020', '021', '029',
                                              '030', '032', '033', '038', '039',
                                              '040', '043', '061', '062', '070',
                                              '072', '082', '083', '084', '096',
                                              '098', '110', '161', '163', '164',
                                              '165', '200', '201', '270', '321',
                                              '322', '324', '330', '342', '378',
                                              '380', '433');
Begin
  Result := 'D';
  If MatchStr(ATipoProduto, PRODUTOS_ARRAY) Then
    Result := 'C';
end;

end.
