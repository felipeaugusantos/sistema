unit untTCieloPgtoV15;

interface

uses System.Classes, System.StrUtils, System.SysUtils, System.Variants,
     Vcl.Forms, System.Math, Data.DB,

     Uni, cxProgressBar,

     untICieloIntegracaoLibCartoes, untCieloTipos, untTCieloFuncoes;

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
                            ANegociacaoArquivo03,
                            ADataSetAjustes: TUniQuery): Boolean;
    function EhAjuste(ARegistro: TRegistroCieloPgto015): Boolean;

    function EhNegociacaoRecebiveis(ARegistro: TRegistroCieloPgto015): Boolean;
  public
    constructor Create;
    destructor Destroy; override;

    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(pgbProg: TcxProgressBar);

    property NomeArquivo: String read FNomeArquivo write FNomeArquivo;
  end;

  Var
    FListaVersao015: TStringList;
    FListaVersao014: TStringList;
    FImportouPagamentos: Boolean;

    FRegCieloPgto015 : TArrRegistroCieloPgto015;

implementation
Uses untCieloPgto;
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

  If VS_ListaEstabelecimentos.IndexOf(FRegCieloPgto015[FPosicaoAtual-1].CodigoEstabelecimento) >= 0 Then
    Exit;

  VS_ListaEstabelecimentos.Add(FRegCieloPgto015[FPosicaoAtual-1].CodigoEstabelecimento);
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

  If (FTipoArquivo = '03') And (Not MatchStr(fGetDados(028,02), ['11', '13', '14'])) Then
    Exit;

  If (FTipoArquivo <> '03') And (FRegistroAnterior = 'E') Then
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
      FRegCieloPgto015[FPosicaoAtual-1].CodigoAutorizacao := TCieloFuncoes.fStrZero(IntToStr(FContadorAjustes), 6);

      Inc(FContadorAjustes);
    End;
  End;

  FRegCieloPgto015[FPosicaoAtual-1].CalculaLiqDeb := True;

  If (FTipoArquivo = '03') Then
  Begin
    FRegCieloPgto015[FPosicaoAtual-1].DataPagamento := fGetDados(582,08, False, 1);
    FRegCieloPgto015[FPosicaoAtual-1].StatusPgto := FRegCieloPgto015[FPosicaoAtual-1].TipoLancamento;

    If FRegCieloPgto015[FPosicaoAtual-1].TipoLancamento = '11' Then
    Begin
      FRegCieloPgto015[FPosicaoAtual-1].ValorBrutoVenda := FRegCieloPgto015[FPosicaoAtual-1].ValorBrutoParcela;
      FRegCieloPgto015[FPosicaoAtual-1].ValorBrutoUR := FRegCieloPgto015[FPosicaoAtual-1].ValorBrutoParcela;
      FRegCieloPgto015[FPosicaoAtual-1].ValorLiquidoUR := FRegCieloPgto015[FPosicaoAtual-1].ValorLiquidoVenda
    End;

    FRegCieloPgto015[FPosicaoAtual-1].DataArquivo := FDataArquivo;
    FRegCieloPgto015[FPosicaoAtual-1].NomeArquivo := FNomeArquivo;
    FRegCieloPgto015[FPosicaoAtual-1].TipoArquivo := FTipoArquivo;
    FRegCieloPgto015[FPosicaoAtual-1].VersaoArquivo := FVersaoArquivo;
  End;
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
      FRegCieloPgto015[FPosicaoAtual-1].CodigoAutorizacao := TCieloFuncoes.fPadL(IntToStr(FContadorNegociacao), 6, '0');
      FRegCieloPgto015[FPosicaoAtual-1].NumeroTID := FCodigoLiquidacao;
      FRegCieloPgto015[FPosicaoAtual-1].NumeroNSU := TCieloFuncoes.fPadL(IntToStr(FContadorNegociacao), 6, '0');
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

  If FLinhaArquivo.Length = 400 Then
    FRegCieloPgto015[FPosicaoAtual-1].NumeroNSU := fGetDados(231,08)
  Else
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
    LApagar: TUniQuery;

    LItem: String;

    LValores: TStringList;
begin
  If Not Assigned(FListaVersao015) Then
    Exit;

  If FListaVersao015.Count = 0 Then
    Exit;

  If Not TCieloFuncoes.ExisteScriptsDaCieloVersao015 Then
    Exit;

  LValores := Nil;
  LApagar := Nil;
  Try
    LValores := TStringList.Create;
    LValores.Delimiter := '|';
    LValores.StrictDelimiter := True;

    LApagar := VS_FuncoesExternas.fICriaQuery;
    LApagar.SQL.Text := 'SELECT * ' +
                        'FROM CIE_CIPGTO ' +
                        'WHERE CIE_DTAPAG=:DTAPAG ' +
                        '  AND CIE_CODEST=:CODEST ' +
                        '  AND (CIE_VERARQ IS NULL OR ' +
                        '       CIE_VERARQ<>"015") ';

    VS_FuncoesExternas.fIStartTransaction;
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
    VS_FuncoesExternas.fICommit;
  Finally
    TCieloFuncoes.FreeAndNilDatasets(LApagar);

    If Assigned(LValores) Then
      FreeAndNil(LValores);
  End;
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
  if not Assigned(VS_ListaEstabelecimentos) then
    VS_ListaEstabelecimentos := TStringList.Create;
  FListaVersao015 := TStringList.Create;
  FImportouPagamentos := False;
end;

destructor TCieloPgtoV15.Destroy;
begin
  If Assigned(FListaVersao015) Then
    FreeAndNil(FListaVersao015);

  SetLength(FRegCieloPgto015, 0);

  inherited;
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

function TCieloPgtoV15.EhNegociacaoRecebiveis(ARegistro: TRegistroCieloPgto015): Boolean;
begin
  If fRetVal(ARegistro.TipoRegistro) = 'B' Then
    Exit(True);

  If fRetVal(ARegistro.TipoArquivo) <> '03' Then
    Exit(False);

  If fRetVal(ARegistro.TipoRegistro) <> 'E' Then
    Exit(False);

  If fRetVal(ARegistro.TipoLancamento) <> '11' Then
    Exit(False);

  Result := True;
end;

function TCieloPgtoV15.fGetDados(AIndiceInicial, ATamanho: Integer;
  ATipoFloat: Boolean = False; AIndiceData: Integer = 0): Variant;
Begin
  Result := Trim(Copy(FLinhaArquivo, AIndiceInicial, ATamanho));

  If ATipoFloat Then
    Result := TCieloFuncoes.fStrToFloat(Result) / 100
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
  ADatasetPagos, ADatasetNegociacao, ANegociacaoArquivo03,ADataSetAjustes: TUniQuery): Boolean;
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

  If (Not EhNegociacaoRecebiveis(ARegistro)) Then
  Begin
    if ARegistro.StatusPgto = '01' then
      Exit;

    If ADatasetPagos.Active Then
    Begin
      Result := ADatasetPagos.IsEmpty;
      Exit;
    End;
  End;

  If EhNegociacaoRecebiveis(ARegistro) Then
  Begin
    If ARegistro.TipoRegistro = 'B' Then
    Begin
      If ADatasetNegociacao.Active Then
      Begin
        Result := ADatasetNegociacao.IsEmpty;
        Exit;
      End;
    End
    Else
    Begin
      If ANegociacaoArquivo03.Active Then
      Begin
        Result := ANegociacaoArquivo03.IsEmpty;
        Exit;
      End;
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

    If MatchStr(fGetDados(001,01), ['D', 'E', '8', 'A', 'B', 'C']) Then
    Begin
      If MatchStr(fGetDados(001,01), ['D', '8', 'B']) Then
        Inc(FPosicaoAtual);

      If MatchStr(fGetDados(001,01), ['E']) Then
      Begin
        If (FTipoArquivo = '03') Or (FRegistroAnterior = 'E') Then
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
  If TCieloFuncoes.fEmptyStr(AValor) Then
    Exit(Null);

  Result := AValor;
End;

procedure TCieloPgtoV15.pGravarRegistros(pgbProg: TcxProgressBar);
  Var
    LNegociacao,
    LNegociacaoArquivo03,
    LRegistrosPagos,
    LInserir,
    LAjuste: TUniQuery;

    LSQL: String;

    LRegistro: TRegistroCieloPgto015;
begin
  LRegistrosPagos := Nil;
  LNegociacao := Nil;
  LNegociacaoArquivo03 := Nil;
  LAjuste := Nil;
  LInserir := Nil;

  Try
    Try
      LRegistrosPagos := VS_FuncoesExternas.fICriaQuery;
      LNegociacao := VS_FuncoesExternas.fICriaQuery;
      LNegociacaoArquivo03 := VS_FuncoesExternas.fICriaQuery;
      LAjuste := VS_FuncoesExternas.fICriaQuery;

      LRegistrosPagos.SQL.Text := 'SELECT * FROM CIE_CIPGTO WHERE ' +
                               ' CIE_DTAPAG = :DTAPAG AND  ' +
                               ' CIE_CODEST = :CODEST AND  ' +
                               ' CIE_CODAUT = :CODAUT AND  ' +
                               ' CIE_NUMPAR = :NUMPAR AND  ' +
                               ' CIE_DTAVEN = :DTAVEN AND  ' +
                               ' CIE_TIPTRA = :TIPTRA AND  ' +
                               ' CIE_STATUS="01"           ';


      LNegociacao.SQL.Text := 'SELECT * FROM CIE_CIPGTO WHERE ' +
                              ' CIE_DTAPAG = :DTAPAG AND  ' +
                              ' CIE_CODEST = :CODEST AND  ' +
                              ' CIE_TIPREG = "B" AND      ' +
                              ' CIE_CODTID = :CODTID AND  ' +
                              ' CIE_VENORI = :VENORI AND  ' +
                              ' CIE_CODBAN = :CODBAN AND  ' +
                              ' CIE_RO_LIQ = :RO_LIQ      ';

      LNegociacaoArquivo03.SQL.Text := 'SELECT * FROM CIE_CIPGTO WHERE ' +
                                       ' CIE_DTAPAG = :DTAPAG AND  ' +
                                       ' CIE_CODEST = :CODEST AND  ' +
                                       ' CIE_TIPARQ = "03"    AND  ' +
                                       ' CIE_TIPREG = "E"     AND  ' +
                                       ' CIE_TIPLAN = "11"    AND  ' +
                                       ' CIE_TRACON = :TRACON AND  ' +
                                       ' CIE_VENORI = :VENORI AND  ' +
                                       ' CIE_CODBAN = :CODBAN AND  ' +
                                       ' CIE_RO_LIQ = :RO_LIQ      ';

      LAjuste.SQL.Text := 'SELECT * FROM CIE_CIPGTO WHERE ' +
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

      LSQL :=  TCieloFuncoes.RetornaSQLReplace('CIE_CIPGTO', ['CIE_CONCIL']);

      LInserir := VS_FuncoesExternas.fICriaQuery;

      LInserir.SQL.Text := LSQL;

      pgbProg.Position := 0;

      If Length(FRegCieloPgto015) = 0 Then
        Exit;

      ApagarRegistrosDaVersao014;

      pgbProg.Properties.Max := Length(FRegCieloPgto015);
      For LRegistro in FRegCieloPgto015 Do
      Begin
        If DeveGravarRegistro(LRegistro) Then
        Begin
          LRegistrosPagos.Close;
          LNegociacao.Close;
          LNegociacaoArquivo03.Close;

          If Concat(fRetVal(LRegistro.StatusPgto), fRetVal(LRegistro.TipoRegistro)) <> '01B' Then
          Begin
            TCieloFuncoes.CarregaParametroDataset(LRegistrosPagos, 'CODEST', fRetVal(LRegistro.CodigoEstabelecimento));
            TCieloFuncoes.CarregaParametroDataset(LRegistrosPagos, 'CODAUT', fRetVal(LRegistro.CodigoAutorizacao));
            TCieloFuncoes.CarregaParametroDataset(LRegistrosPagos, 'NUMPAR', fRetVal(LRegistro.NumeroParcela));
            TCieloFuncoes.CarregaParametroDataset(LRegistrosPagos, 'DTAPAG', fRetVal(LRegistro.DataPagamento));
            TCieloFuncoes.CarregaParametroDataset(LRegistrosPagos, 'DTAVEN', fRetVal(LRegistro.DataTransacao));
            TCieloFuncoes.CarregaParametroDataset(LRegistrosPagos, 'TIPTRA', fRetVal(LRegistro.TipoTransacao));
            LRegistrosPagos.Open;
          End;

          If EhNegociacaoRecebiveis(LRegistro) Then
          Begin
            If (fRetVal(LRegistro.TipoRegistro) = 'B') Then
            Begin
              TCieloFuncoes.CarregaParametroDataset(LNegociacao, 'CODEST', fRetVal(LRegistro.CodigoEstabelecimento));
              TCieloFuncoes.CarregaParametroDataset(LNegociacao, 'DTAPAG', fRetVal(LRegistro.DataPagamento));
              TCieloFuncoes.CarregaParametroDataset(LNegociacao, 'TRACON', fRetVal(LRegistro.CodigoTransacaoContrato));
              TCieloFuncoes.CarregaParametroDataset(LNegociacao, 'VENORI', fRetVal(LRegistro.VencimentoOriginal));
              TCieloFuncoes.CarregaParametroDataset(LNegociacao, 'CODBAN', fRetVal(LRegistro.CodigoBandeira));
              TCieloFuncoes.CarregaParametroDataset(LNegociacao, 'RO_LIQ', fRetVal(LRegistro.ValorLiquidoUR));
              LNegociacao.Open;

              If Not LNegociacao.IsEmpty Then
              Begin
                LNegociacao.Edit;
                LNegociacao.FieldByName('CIE_CONCIL').AsInteger := 0;
                LNegociacao.Post;
              End;
            End
            Else
            Begin
              TCieloFuncoes.CarregaParametroDataset(LNegociacaoArquivo03, 'CODEST', fRetVal(LRegistro.CodigoEstabelecimento));
              TCieloFuncoes.CarregaParametroDataset(LNegociacaoArquivo03, 'DTAPAG', fRetVal(LRegistro.DataPagamento));
              TCieloFuncoes.CarregaParametroDataset(LNegociacaoArquivo03, 'CODTID', fRetVal(LRegistro.NumeroOperacao));
              TCieloFuncoes.CarregaParametroDataset(LNegociacaoArquivo03, 'VENORI', fRetVal(LRegistro.VencimentoOriginal));
              TCieloFuncoes.CarregaParametroDataset(LNegociacaoArquivo03, 'CODBAN', fRetVal(LRegistro.CodigoBandeira));
              TCieloFuncoes.CarregaParametroDataset(LNegociacaoArquivo03, 'RO_LIQ', fRetVal(LRegistro.ValorLiquidoUR));
              LNegociacaoArquivo03.Open;

              If Not LNegociacaoArquivo03.IsEmpty Then
              Begin
                LNegociacaoArquivo03.Edit;
                LNegociacaoArquivo03.FieldByName('CIE_CONCIL').AsInteger := 0;
                LNegociacaoArquivo03.Post;
              End;
            End;
          End;

          If EhAjuste(LRegistro) Then
          begin
            LAjuste.Close;
            TCieloFuncoes.CarregaParametroDataset(LAjuste, 'DTAPAG', fRetVal(LRegistro.DataPagamento));
            TCieloFuncoes.CarregaParametroDataset(LAjuste, 'CODEST', fRetVal(LRegistro.CodigoEstabelecimento));
            TCieloFuncoes.CarregaParametroDataset(LAjuste, 'CODAUT', fRetVal(LRegistro.CodigoAutorizacao));
            TCieloFuncoes.CarregaParametroDataset(LAjuste, 'NUMPAR', fRetVal(LRegistro.NumeroParcela));
            TCieloFuncoes.CarregaParametroDataset(LAjuste, 'DTAVEN', fRetVal(LRegistro.DataTransacao));
            TCieloFuncoes.CarregaParametroDataset(LAjuste, 'NUM_RO', fRetVal(LeftStr(LRegistro.ChaveUR, 7)));
            TCieloFuncoes.CarregaParametroDataset(LAjuste, 'NUMNSU', fRetVal(LRegistro.NumeroNSU));
            TCieloFuncoes.CarregaParametroDataset(LAjuste, 'STATUS', fRetVal(LRegistro.StatusPgto));
            TCieloFuncoes.CarregaParametroDataset(LAjuste, 'VALPAR', fRetVal(LRegistro.ValorBrutoParcela));
            LAjuste.Open;
          end;

          If GravarRegistro(LRegistro,
                            LRegistrosPagos,
                            LNegociacao,
                            LNegociacaoArquivo03,
                            LAjuste) Then
          Begin
            LInserir.Close;

            TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_TIPREG', fRetVal(LRegistro.TipoRegistro));
            TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_CODEST', fRetVal(LRegistro.CodigoEstabelecimento));
            TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_NUM_RO', fRetVal(LeftStr(LRegistro.ChaveUR, 7)));
            TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_DTAAPR', fRetVal(LRegistro.DataTransacao));
            TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_DTAPAG', fRetVal(LRegistro.DataPagamento));
            TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_CODBCO', fRetVal(LRegistro.CodigoBanco));
            TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_CODAGE', fRetVal(LRegistro.CodigoAgencia));
            TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_NUMCCO', fRetVal(LRegistro.CodigoConta + LRegistro.DigitoConta));
            TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_RO_BRU', fRetVal(LRegistro.ValorBrutoUR));
            TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_RO_LIQ', fRetVal(LRegistro.ValorLiquidoUR));
            TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_RO_COM', fRetVal(LRegistro.ValorTaxaUR));
            TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_RO_REJ', 0.00);
            TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_STATUS', fRetVal(LRegistro.StatusPgto));
            TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_PORCOM', 0.00);

            TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_NUMANT', fRetVal(LRegistro.NumeroAntecipacao));
            If fRetVal(Trim(LRegistro.NumeroAntecipacao)) <> Null Then
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_BRUANT', fRetVal(LRegistro.ValorBrutoUR));

            TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_NUMNSU', fRetVal(LRegistro.NumeroNSU));
            TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_DTAVEN', fRetVal(LRegistro.DataTransacao));
            TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_NUMCAR', fRetVal(LRegistro.NumeroCartao));
            TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_VALTOT', fRetVal(LRegistro.ValorBrutoVenda));
            TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_TOTPAR', fRetVal(LRegistro.TotalParcelas));
            TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_NUMPAR', fRetVal(LRegistro.NumeroParcela));
            TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_VALPAR', fRetVal(LRegistro.ValorBrutoParcela));
            TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_VALPRO', fRetVal(LRegistro.ValorLiquidoVenda));
            TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_CODAUT', fRetVal(LRegistro.CodigoAutorizacao));
            TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_CODTID', fRetVal(LRegistro.NumeroTID));
            TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_NUMTER', fRetVal(LRegistro.NumeroTerminal));
            TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_TIPCAR', fRetVal(LRegistro.TipoCartao));
            TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_TIPFIN', ' ');
            TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_TIPTRA', fRetVal(LRegistro.TipoTransacao));
            TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_NUM_NF', fRetVal(LRegistro.NumeroNF));
            TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_NOMARQ', fRetVal(LRegistro.NomeArquivo));
            TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_DTAARQ', fRetVal(LRegistro.DataArquivo));
            TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_DTAANT', fRetVal(LRegistro.DataMovimento));
            TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_LIQANT', fRetVal(LRegistro.ValorLiquidoUR));
            TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_RO_DEB', ' ');
            TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_ORIAJU', fRetVal(LRegistro.OrigemAjuste));
            TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_CODBAN', fRetVal(LRegistro.CodigoBandeira));
            TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_CODPRO', fRetVal(LRegistro.FormaPagameto));
            TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_TIPNEG', fRetVal(LRegistro.TipoNegociacao));
            TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_VENORI', fRetVal(LRegistro.DataVencimentoOriginal));
            TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_LIQDEB', fRetVal(LRegistro.ValorAjuste));

            If LRegistro.TipoRegistro = 'B' Then
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_CODTID', fRetVal(LRegistro.NumeroOperacao));

            {CAMPOS NOVOS}
            If (Pos('CIE_CHA_UR',LInserir.SQL.Text) > 0) Then
            Begin
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_CHA_UR', fRetVal(LRegistro.ChaveUR));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_TAXANT', fRetVal(LRegistro.TaxaAntecipacao));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_TIPARQ', fRetVal(LRegistro.TipoArquivo));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_VERARQ', fRetVal(LRegistro.VersaoArquivo));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_CODAJU', fRetVal(LRegistro.CodigoAjuste));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_CODPED', fRetVal(LRegistro.CodigoPedido));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_CODVEN', fRetVal(LRegistro.CodigoVenda));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_CODVOR', fRetVal(LRegistro.CodigoOriginalVenda));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_TIPCAP', fRetVal(LRegistro.TipoCaptura));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_MEICAP', fRetVal(LRegistro.MeioCaptura));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_TIPLAN', fRetVal(LRegistro.TipoLancamento));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_TIPLOR', fRetVal(LRegistro.TipoLancamentoOriginal));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_TIPANT', fRetVal(LRegistro.TipoAntecipacao));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_MOVORI', fRetVal(LRegistro.DataMovimentoOriginal));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_DTAENV', fRetVal(LRegistro.DataEnvioBanco));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_GRUCAR', fRetVal(LRegistro.GrupoCartoes));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_CODVEN', fRetVal(LRegistro.CodigoVenda));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_VALCOM', fRetVal(LRegistro.ValorComissao));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_COMMIN', fRetVal(LRegistro.ValorComissaoMinima));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_TAXADM', fRetVal(LRegistro.ValorTarifaAdministrativa));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_TAXMDR', fRetVal(LRegistro.ValorTaxaMDR));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_TAXRAP', fRetVal(LRegistro.ValorTaxaRecebaRapido));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_INDGRA', fRetVal(LRegistro.IndicativoGravame));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_INDRAP', fRetVal(LRegistro.IndicativoRecebaRapido));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_INDZER', fRetVal(LRegistro.IndicativoTaxaZero));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_INDREJ', fRetVal(LRegistro.IndicativoTransacaoRejeitada));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_INDTAR', fRetVal(LRegistro.IndicativoTardia));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_TRACON', fRetVal(LRegistro.CodigoTransacaoContrato));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_NUMLOT', fRetVal(LRegistro.NumeroLote));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_TRAPRO', fRetVal(LRegistro.NumeroTransacaoProcessada));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_MOTREJ', fRetVal(LRegistro.MotivoRejeicao));
            End;

            LInserir.ExecSQL;
            LRegistrosPagos.Close;
          End;
        End;

        TCieloFuncoes.pStepStatusGravacao(pgbProg);
      End;

      SetLength(FRegCieloPgto015, 0);
      TCieloFuncoes.GravarEstabelecimentos;
    Finally
      TCieloFuncoes.FreeAndNilDatasets(LRegistrosPagos);
      TCieloFuncoes.FreeAndNilDatasets(LNegociacao);
      TCieloFuncoes.FreeAndNilDatasets(LAjuste);
      TCieloFuncoes.FreeAndNilDatasets(LInserir);
      TCieloFuncoes.FreeAndNilDatasets(LNegociacaoArquivo03);
    End;
    pgbProg.Position := pgbProg.Properties.Max;
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
                                           RightStr(TCieloFuncoes.fRetSomenteNumeros(ARegistro.DataPagamento), 6))) >= 0;
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
