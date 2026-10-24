unit untTGetNetPgtoV10_1;

interface

uses System.Classes, System.StrUtils, System.SysUtils, System.Variants, Data.DB,
     Vcl.ComCtrls, Vcl.Forms, System.Math, Dialogs,  System.Generics.Collections,

     Uni, cxProgressBar,

     untIGetNetIntegracaoLibCartoes, untTGetNetFuncoes, untGetNetTipos;


Type
  TGetNetPgtoV10_1 = Class(TInterfacedObject, ICartoes)
  private
    FPosicaoAtual: Integer;

    FValorTaxaRV: Double;

    FDataArquivo,
    FVersaoArquivo,
    FNomeArquivo,
    FEstabelecimento,

    FRegistroAnterior,

    FLinhaArquivo: String;

    FContadorRegistro5,
    FContadorRegistro6,
    FContadorAjuste: Integer;
    FDataInicioImportacao,
    FDataFinalImportacao: TDateTime;

    function fGetDados(AIndiceInicial,
                       ATamanho: Integer;
                       ATipoFloat: Boolean = False): Variant;

    function fRetVal(AValor: Variant;
                     ACampoData: Boolean = False): Variant;

    function RemoverZerosAEsquedaEstabelecimento(AValor: String): String; // a getnet está de palhaçada, tem registro que está vindo, tem registro que não

    procedure CopiaDadosRegistro1Anterior;

    procedure AdicionaEstabelecimentoNaLista;

    procedure AdicionaRegistro1;
    procedure AdicionaRegistro2;
    procedure AdicionaRegistro3;
    procedure AdicionaRegistro5;
    procedure AdicionaRegistro6;
    procedure AjustaDiferencaTaxa;

    function DeveGravarRegistro(ARegistro: TRegistroGetNetPgto10_1): Boolean;
    function RegistroJaImportado(ARegistro : TRegistroGetNetPgto10_1): Boolean;
    function RetornaPeriodoImportacaoSQL: String;

    procedure CarregaDataInicialFinalDeImportacao;
  public
    constructor Create;

    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(pgbProg: TcxProgressBar);

    property NomeArquivo: String read FNomeArquivo write FNomeArquivo;
    property DataInicioImportacao: TDateTime read FDataInicioImportacao write FDataInicioImportacao;
    property DataFinalImportacao:  TDateTime read FDataFinalImportacao  write FDataFinalImportacao;
  end;

  Var
    FRegGetNetPgto10_1: TArrRegistroGetNetPgto10_1;

implementation

{ TGetNetPgtoV10_1 }

procedure TGetNetPgtoV10_1.AdicionaEstabelecimentoNaLista;
begin
  If FPosicaoAtual = 0 Then
    Exit;

  If FRegGetNetPgto10_1[FPosicaoAtual-1].CodigoEstabelecimento.IsEmpty Then
    Exit;

  If VS_ListaEstabelecimentos.IndexOf(FRegGetNetPgto10_1[FPosicaoAtual-1].CodigoEstabelecimento) >= 0 Then
    Exit;

  VS_ListaEstabelecimentos.Add(FRegGetNetPgto10_1[FPosicaoAtual-1].CodigoEstabelecimento);
end;

procedure TGetNetPgtoV10_1.AdicionaRegistro1;
  Var
    LSinal: String;
begin
  If Not MatchStr(fGetDados(001,01), ['1']) Then
    Exit;

  FValorTaxaRV := fGetDados(121,12, True);

  FRegGetNetPgto10_1[FPosicaoAtual-1].TipoRegistro := fGetDados(001,01);
  FRegGetNetPgto10_1[FPosicaoAtual-1].CodigoEstabelecimento := RemoverZerosAEsquedaEstabelecimento(fGetDados(002,15));

  If FRegGetNetPgto10_1[FPosicaoAtual-1].CodigoEstabelecimento.Replace('0', EmptyStr).IsEmpty Then
    Raise Exception.Create('Os dados do estabelecimento gerados no arquivo estão inconsistentes. Deve entrar em contato com a Getnet e solicitar o reprocessamento.' + #13 +
                           'Importação cancelada.');

  FRegGetNetPgto10_1[FPosicaoAtual-1].CodigoProduto := fGetDados(017,02);
  FRegGetNetPgto10_1[FPosicaoAtual-1].FormaCaptura  := fGetDados(019,03);
  FRegGetNetPgto10_1[FPosicaoAtual-1].NumeroRV := fGetDados(022,09);
  FRegGetNetPgto10_1[FPosicaoAtual-1].DataRV := fGetDados(031,08);
  FRegGetNetPgto10_1[FPosicaoAtual-1].DataTransacao := fGetDados(031,08);
  FRegGetNetPgto10_1[FPosicaoAtual-1].DataPagamento := fGetDados(039,08);

  FRegGetNetPgto10_1[FPosicaoAtual-1].CodigoBanco := fGetDados(047,03);
  FRegGetNetPgto10_1[FPosicaoAtual-1].CodigoAgencia := fGetDados(050,06);

  LSinal := fGetDados(286,01);
  FRegGetNetPgto10_1[FPosicaoAtual-1].ValorBrutoRV := fGetDados(085,12, True);
  FRegGetNetPgto10_1[FPosicaoAtual-1].ValorLiquidoRV := fGetDados(097,12, True);

  If LSinal.Equals('-') Then
    FRegGetNetPgto10_1[FPosicaoAtual-1].ValorLiquidoRV := Abs(FRegGetNetPgto10_1[FPosicaoAtual-1].ValorLiquidoRV) * (-1);

  FRegGetNetPgto10_1[FPosicaoAtual-1].ValorTarifaRV := fGetDados(109,12, True);
  FRegGetNetPgto10_1[FPosicaoAtual-1].ValorTaxaRV := fGetDados(121,12, True);
  FRegGetNetPgto10_1[FPosicaoAtual-1].ValorRejeitadoRV := fGetDados(133,12, True);
  FRegGetNetPgto10_1[FPosicaoAtual-1].ValorCreditadoRV := fGetDados(145,12, True);

  FRegGetNetPgto10_1[FPosicaoAtual-1].TipoPagamentoOperacao := fGetDados(169,02);
  FRegGetNetPgto10_1[FPosicaoAtual-1].NumeroParcela := fGetDados(171,02);
  FRegGetNetPgto10_1[FPosicaoAtual-1].TotalParcelas := fGetDados(173,02);

  FRegGetNetPgto10_1[FPosicaoAtual-1].DataVencimentoOriginal := fGetDados(205,08);
  FRegGetNetPgto10_1[FPosicaoAtual-1].NumeroControle := fGetDados(237,18);

  FRegGetNetPgto10_1[FPosicaoAtual-1].ValorLiquidoCI := fGetDados(255,12, True);

  FRegGetNetPgto10_1[FPosicaoAtual-1].CodigoContaCorrente := fGetDados(289,20);
  FRegGetNetPgto10_1[FPosicaoAtual-1].ChaveUR := fGetDados(309,25);

  FRegGetNetPgto10_1[FPosicaoAtual-1].DataArquivo := FDataArquivo;
  FRegGetNetPgto10_1[FPosicaoAtual-1].VersaoArquivo := FVersaoArquivo;
  FRegGetNetPgto10_1[FPosicaoAtual-1].NomeArquivo := FNomeArquivo;
end;

procedure TGetNetPgtoV10_1.AdicionaRegistro2;
Var
  LSinal: String;
begin
  If Not MatchStr(fGetDados(001,01), ['2']) Then
    Exit;

  If Not FRegistroAnterior.Equals('1') Then
    CopiaDadosRegistro1Anterior;

  FRegGetNetPgto10_1[FPosicaoAtual-1].TipoRegistro := fGetDados(001,01);
  FRegGetNetPgto10_1[FPosicaoAtual-1].NumeroNSU := fGetDados(026,12);
  FRegGetNetPgto10_1[FPosicaoAtual-1].DataTransacao := fGetDados(038,08);
  FRegGetNetPgto10_1[FPosicaoAtual-1].NumeroCartao := fGetDados(052,19);

  LSinal := fGetDados(172,01);
  FRegGetNetPgto10_1[FPosicaoAtual-1].ValorTransacao := fGetDados(071,12, True);
  FRegGetNetPgto10_1[FPosicaoAtual-1].ValorParcela := fGetDados(111,12, True);

  If LSinal.Equals('-') Then
  Begin
    FRegGetNetPgto10_1[FPosicaoAtual-1].ValorTransacao := Abs(FRegGetNetPgto10_1[FPosicaoAtual-1].ValorTransacao) * (-1);
    FRegGetNetPgto10_1[FPosicaoAtual-1].ValorParcela := Abs(FRegGetNetPgto10_1[FPosicaoAtual-1].ValorParcela) * (-1);
  End;

  FRegGetNetPgto10_1[FPosicaoAtual-1].TotalParcelas := fGetDados(107,02);
  FRegGetNetPgto10_1[FPosicaoAtual-1].NumeroParcela := fGetDados(109,02);
  FRegGetNetPgto10_1[FPosicaoAtual-1].DataPagamento := fGetDados(123,08);
  FRegGetNetPgto10_1[FPosicaoAtual-1].CodigoAutorizacao := fGetDados(131,10);

  FRegGetNetPgto10_1[FPosicaoAtual-1].FormaCaptura := fGetDados(141,03);
  FRegGetNetPgto10_1[FPosicaoAtual-1].StatusTransacao := fGetDados(144,01);
  FRegGetNetPgto10_1[FPosicaoAtual-1].CodigoTerminal := fGetDados(160,8);
  FRegGetNetPgto10_1[FPosicaoAtual-1].CarteiraDigital := fGetDados(173,03);

  FRegGetNetPgto10_1[FPosicaoAtual-1].ValorComissaoMDR := fGetDados(176,12, True);

  FValorTaxaRV := RoundTo((FValorTaxaRV - FRegGetNetPgto10_1[FPosicaoAtual-1].ValorComissaoMDR),-2);

  FRegGetNetPgto10_1[FPosicaoAtual-1].Metadados := fGetDados(190,118);
end;

procedure TGetNetPgtoV10_1.AdicionaRegistro3;
begin
  If Not MatchStr(fGetDados(001,01), ['3']) Then
    Exit;

  If Not FRegistroAnterior.Equals('1') Then
    CopiaDadosRegistro1Anterior;

  Inc(FContadorAjuste);

  FRegGetNetPgto10_1[FPosicaoAtual-1].TipoRegistro := fGetDados(001,01);
  FRegGetNetPgto10_1[FPosicaoAtual-1].CodigoEstabelecimento := RemoverZerosAEsquedaEstabelecimento(fGetDados(002,15));

  If FRegGetNetPgto10_1[FPosicaoAtual-1].CodigoEstabelecimento.Replace('0', EmptyStr).IsEmpty Then
    Raise Exception.Create('Os dados do estabelecimento gerados no arquivo estão inconsistentes. Deve entrar em contato com a Getnet e solicitar o reprocessamento.' + #13 +
                           'Importação cancelada.');

  FRegGetNetPgto10_1[FPosicaoAtual-1].NumeroRV := fGetDados(017,09);
  FRegGetNetPgto10_1[FPosicaoAtual-1].DataTransacao := fGetDados(026,08);
  FRegGetNetPgto10_1[FPosicaoAtual-1].DataPagamento := fGetDados(034,08);

  FRegGetNetPgto10_1[FPosicaoAtual-1].IdentificadorAjuste := fGetDados(042,20);

  FRegGetNetPgto10_1[FPosicaoAtual-1].ValorParcela := fGetDados(063,13, True);
  FRegGetNetPgto10_1[FPosicaoAtual-1].ValorTransacao := fGetDados(063,13, True);
  FRegGetNetPgto10_1[FPosicaoAtual-1].ValorCreditadoRV := fGetDados(063,13, True);

  FRegGetNetPgto10_1[FPosicaoAtual-1].MotivoAjuste := fGetDados(076,02);
  FRegGetNetPgto10_1[FPosicaoAtual-1].DataCartaCancelamento := fGetDados(078,08);
  FRegGetNetPgto10_1[FPosicaoAtual-1].NumeroCartao := fGetDados(086,19);
  FRegGetNetPgto10_1[FPosicaoAtual-1].NumeroRVOriginal := fGetDados(105,09);
  FRegGetNetPgto10_1[FPosicaoAtual-1].NumeroNSU := fGetDados(114,12);
  FRegGetNetPgto10_1[FPosicaoAtual-1].TipoPagamentoOperacao := fGetDados(134,02);

  FRegGetNetPgto10_1[FPosicaoAtual-1].CodigoTerminal := fGetDados(136,08);
  FRegGetNetPgto10_1[FPosicaoAtual-1].DataPagamentoOriginal := fGetDados(144,08);
  FRegGetNetPgto10_1[FPosicaoAtual-1].Metadados := fGetDados(169,118);

  FRegGetNetPgto10_1[FPosicaoAtual-1].CodigoAutorizacao := FContadorAjuste.ToString;
end;

procedure TGetNetPgtoV10_1.AdicionaRegistro5;
begin
  If Not MatchStr(fGetDados(001,01), ['5']) Then
    Exit;

  Inc(FContadorRegistro5);

  FRegGetNetPgto10_1[FPosicaoAtual-1].TipoRegistro := fGetDados(001,01);
  FRegGetNetPgto10_1[FPosicaoAtual-1].CodigoEstabelecimento := RemoverZerosAEsquedaEstabelecimento(fGetDados(002,15));

  If FRegGetNetPgto10_1[FPosicaoAtual-1].CodigoEstabelecimento.Replace('0', EmptyStr).IsEmpty Then
    Raise Exception.Create('Os dados do estabelecimento gerados no arquivo estão inconsistentes. Deve entrar em contato com a Getnet e solicitar o reprocessamento.' + #13 +
                           'Importação cancelada.');

  FRegGetNetPgto10_1[FPosicaoAtual-1].DataTransacao := fGetDados(017,08);
  FRegGetNetPgto10_1[FPosicaoAtual-1].DataRV := fGetDados(017,08);

  If FRegGetNetPgto10_1[FPosicaoAtual-1].DataTransacao = '00000000' Then
  Begin
    FRegGetNetPgto10_1[FPosicaoAtual-1].DataTransacao := fGetDados(025,08);
    FRegGetNetPgto10_1[FPosicaoAtual-1].DataRV := fGetDados(025,08);
  End;

  FRegGetNetPgto10_1[FPosicaoAtual-1].DataPagamento := fGetDados(025,08);
  FRegGetNetPgto10_1[FPosicaoAtual-1].NumeroOperacao := fGetDados(033,20);
  FRegGetNetPgto10_1[FPosicaoAtual-1].NumeroNSU := fGetDados(033,20);
  FRegGetNetPgto10_1[FPosicaoAtual-1].NumeroRV := RightStr(fGetDados(025,08), 09);
  FRegGetNetPgto10_1[FPosicaoAtual-1].TipoPagamentoOperacao := fGetDados(053,02);
  FRegGetNetPgto10_1[FPosicaoAtual-1].MotivoAjuste := fGetDados(053,02);

  FRegGetNetPgto10_1[FPosicaoAtual-1].ValorBrutoRV := fGetDados(067,12, True);
  FRegGetNetPgto10_1[FPosicaoAtual-1].ValorParcela := fGetDados(067,12, True);
  FRegGetNetPgto10_1[FPosicaoAtual-1].ValorTaxaRV := fGetDados(079,12, True);
  FRegGetNetPgto10_1[FPosicaoAtual-1].ValorLiquidoRV := fGetDados(091,12, True);
  FRegGetNetPgto10_1[FPosicaoAtual-1].TaxaMensalOperacao := fGetDados(103,11, True) / 100000;

  FRegGetNetPgto10_1[FPosicaoAtual-1].CodigoBanco := fGetDados(116,03);
  FRegGetNetPgto10_1[FPosicaoAtual-1].CodigoAgencia := fGetDados(119,06);
  FRegGetNetPgto10_1[FPosicaoAtual-1].CodigoContaCorrente := fGetDados(125,20);
  FRegGetNetPgto10_1[FPosicaoAtual-1].CanalOperacao := fGetDados(145,03);
  FRegGetNetPgto10_1[FPosicaoAtual-1].StatusTransacao := fGetDados(148,01);
  FRegGetNetPgto10_1[FPosicaoAtual-1].CodigoProduto := fGetDados(256,02);

  FRegGetNetPgto10_1[FPosicaoAtual-1].NumeroCartao := '***';
  FRegGetNetPgto10_1[FPosicaoAtual-1].NumeroParcela := '01';
  FRegGetNetPgto10_1[FPosicaoAtual-1].TotalParcelas := '01';

  FRegGetNetPgto10_1[FPosicaoAtual-1].CodigoAutorizacao := FContadorRegistro5.ToString;

  FRegGetNetPgto10_1[FPosicaoAtual-1].DataArquivo := FDataArquivo;
  FRegGetNetPgto10_1[FPosicaoAtual-1].VersaoArquivo := FVersaoArquivo;
  FRegGetNetPgto10_1[FPosicaoAtual-1].NomeArquivo := FNomeArquivo;
end;

procedure TGetNetPgtoV10_1.AdicionaRegistro6;
begin
  If Not MatchStr(fGetDados(001,01), ['6']) Then
    Exit;

  Inc(FContadorRegistro6);

  FRegGetNetPgto10_1[FPosicaoAtual-1].TipoRegistro := fGetDados(001,01);
  FRegGetNetPgto10_1[FPosicaoAtual-1].CodigoEstabelecimento := RemoverZerosAEsquedaEstabelecimento(fGetDados(002,15));

  If FRegGetNetPgto10_1[FPosicaoAtual-1].CodigoEstabelecimento.Replace('0', EmptyStr).IsEmpty Then
    Raise Exception.Create('Os dados do estabelecimento gerados no arquivo estão inconsistentes. Deve entrar em contato com a Getnet e solicitar o reprocessamento.' + #13 +
                           'Importação cancelada.');

  FRegGetNetPgto10_1[FPosicaoAtual-1].DataTransacao := fGetDados(017,08);
  FRegGetNetPgto10_1[FPosicaoAtual-1].DataRV := fGetDados(017,08);
  FRegGetNetPgto10_1[FPosicaoAtual-1].DataPagamento := fGetDados(017,08);
  FRegGetNetPgto10_1[FPosicaoAtual-1].NumeroOperacao := fGetDados(025,20);
  FRegGetNetPgto10_1[FPosicaoAtual-1].TipoPagamentoOperacao := fGetDados(045,02);
  FRegGetNetPgto10_1[FPosicaoAtual-1].CodigoProduto := fGetDados(065,02);
  FRegGetNetPgto10_1[FPosicaoAtual-1].DataVencimentoOriginal := fGetDados(067,08);
  FRegGetNetPgto10_1[FPosicaoAtual-1].NumeroRV := RightStr(fGetDados(025,20), 9);

  FRegGetNetPgto10_1[FPosicaoAtual-1].ValorLiquidoRV := fGetDados(111,12, True);
  FRegGetNetPgto10_1[FPosicaoAtual-1].ValorBrutoRV := fGetDados(111,12, True);
  FRegGetNetPgto10_1[FPosicaoAtual-1].ValorParcela := fGetDados(111,12, True);

  FRegGetNetPgto10_1[FPosicaoAtual-1].StatusTransacao := fGetDados(154,01);
  FRegGetNetPgto10_1[FPosicaoAtual-1].ChaveUR := fGetDados(262,25);

  FRegGetNetPgto10_1[FPosicaoAtual-1].NumeroCartao := '***';
  FRegGetNetPgto10_1[FPosicaoAtual-1].NumeroParcela := '01';
  FRegGetNetPgto10_1[FPosicaoAtual-1].TotalParcelas := '01';

  FRegGetNetPgto10_1[FPosicaoAtual-1].CodigoAutorizacao := FContadorRegistro6.ToString;
  FRegGetNetPgto10_1[FPosicaoAtual-1].NumeroNSU :=  fGetDados(025,20);

  FRegGetNetPgto10_1[FPosicaoAtual-1].DataArquivo := FDataArquivo;
  FRegGetNetPgto10_1[FPosicaoAtual-1].VersaoArquivo := FVersaoArquivo;
  FRegGetNetPgto10_1[FPosicaoAtual-1].NomeArquivo := FNomeArquivo;
end;

procedure TGetNetPgtoV10_1.AjustaDiferencaTaxa;
begin

  If Not MatchStr(fGetDados(001,01), ['2']) Then
  Begin

    If FValorTaxaRV <> 0 Then
    Begin
      If FRegGetNetPgto10_1[FPosicaoAtual -1].TipoRegistro.Equals('2') Then
      Begin
        FRegGetNetPgto10_1[FPosicaoAtual -1].ValorComissaoMDR :=  FRegGetNetPgto10_1[FPosicaoAtual-1].ValorComissaoMDR + FValorTaxaRV;
      End;

      FValorTaxaRV := 0;
    End;

  End;

end;

procedure TGetNetPgtoV10_1.CarregaDataInicialFinalDeImportacao;
  Var
    LRegistro: TRegistroGetNetPgto10_1;

    LDataPag: TDateTime;
begin
  FDataInicioImportacao := 0;
  FDataFinalImportacao := 0;
  LDataPag := 0;

  For LRegistro In FRegGetNetPgto10_1 Do
  Begin
    If MatchStr(LRegistro.DataPagamento.Trim, [EmptyStr, '00000000']) Then
      Continue;

     Try
       LDataPag := EncodeDate(StrToInt(Copy(LRegistro.DataPagamento, 5, 4)),
                              StrToInt(Copy(LRegistro.DataPagamento, 3, 2)),
                              StrToInt(LeftStr(LRegistro.DataPagamento, 2)));
     Except
       Continue;
     End;

     If (FDataInicioImportacao = 0) Or (LDataPag < FDataInicioImportacao) Then
        FDataInicioImportacao := LDataPag;

      If LDataPag > FDataFinalImportacao Then
        FDataFinalImportacao := LDataPag;
  End;

  If Not Assigned(VS_RegistrosJaImportados) Then
    TGetnetFuncoes.CarregaRegistrosJaImportados('GET_GEPGTO',
                                               ['GET_CONCIL', 'GET_DTAPAG', 'GET_IDEAJU'],
                                               ['= 1', RetornaPeriodoImportacaoSQL, '<> "" ']);
end;

procedure TGetNetPgtoV10_1.CopiaDadosRegistro1Anterior;
begin
  FRegGetNetPgto10_1[FPosicaoAtual-1].TipoRegistro := FRegGetNetPgto10_1[FPosicaoAtual-2].TipoRegistro;
  FRegGetNetPgto10_1[FPosicaoAtual-1].CodigoEstabelecimento := FRegGetNetPgto10_1[FPosicaoAtual-2].CodigoEstabelecimento;
  FRegGetNetPgto10_1[FPosicaoAtual-1].CodigoProduto := FRegGetNetPgto10_1[FPosicaoAtual-2].CodigoProduto;
  FRegGetNetPgto10_1[FPosicaoAtual-1].FormaCaptura := FRegGetNetPgto10_1[FPosicaoAtual-2].FormaCaptura;
  FRegGetNetPgto10_1[FPosicaoAtual-1].NumeroRV := FRegGetNetPgto10_1[FPosicaoAtual-2].NumeroRV;
  FRegGetNetPgto10_1[FPosicaoAtual-1].DataRV := FRegGetNetPgto10_1[FPosicaoAtual-2].DataRV;
  FRegGetNetPgto10_1[FPosicaoAtual-1].DataTransacao := FRegGetNetPgto10_1[FPosicaoAtual-2].DataTransacao;
  FRegGetNetPgto10_1[FPosicaoAtual-1].DataPagamento := FRegGetNetPgto10_1[FPosicaoAtual-2].DataPagamento;

  FRegGetNetPgto10_1[FPosicaoAtual-1].CodigoBanco := FRegGetNetPgto10_1[FPosicaoAtual-2].CodigoBanco;
  FRegGetNetPgto10_1[FPosicaoAtual-1].CodigoAgencia := FRegGetNetPgto10_1[FPosicaoAtual-2].CodigoAgencia;

  FRegGetNetPgto10_1[FPosicaoAtual-1].ValorBrutoRV := FRegGetNetPgto10_1[FPosicaoAtual-2].ValorBrutoRV;
  FRegGetNetPgto10_1[FPosicaoAtual-1].ValorLiquidoRV := FRegGetNetPgto10_1[FPosicaoAtual-2].ValorLiquidoRV;

  FRegGetNetPgto10_1[FPosicaoAtual-1].ValorTarifaRV := FRegGetNetPgto10_1[FPosicaoAtual-2].ValorTarifaRV;
  FRegGetNetPgto10_1[FPosicaoAtual-1].ValorTaxaRV := FRegGetNetPgto10_1[FPosicaoAtual-2].ValorTaxaRV;
  FRegGetNetPgto10_1[FPosicaoAtual-1].ValorRejeitadoRV := FRegGetNetPgto10_1[FPosicaoAtual-2].ValorRejeitadoRV;
  FRegGetNetPgto10_1[FPosicaoAtual-1].ValorCreditadoRV := FRegGetNetPgto10_1[FPosicaoAtual-2].ValorCreditadoRV;

  FRegGetNetPgto10_1[FPosicaoAtual-1].TipoPagamentoOperacao := FRegGetNetPgto10_1[FPosicaoAtual-2].TipoPagamentoOperacao;
  FRegGetNetPgto10_1[FPosicaoAtual-1].NumeroParcela := FRegGetNetPgto10_1[FPosicaoAtual-2].NumeroParcela;
  FRegGetNetPgto10_1[FPosicaoAtual-1].TotalParcelas := FRegGetNetPgto10_1[FPosicaoAtual-2].TotalParcelas;

  FRegGetNetPgto10_1[FPosicaoAtual-1].DataVencimentoOriginal := FRegGetNetPgto10_1[FPosicaoAtual-2].DataVencimentoOriginal;
  FRegGetNetPgto10_1[FPosicaoAtual-1].NumeroControle := FRegGetNetPgto10_1[FPosicaoAtual-2].NumeroControle;

  FRegGetNetPgto10_1[FPosicaoAtual-1].ValorLiquidoCI := FRegGetNetPgto10_1[FPosicaoAtual-2].ValorLiquidoCI;

  FRegGetNetPgto10_1[FPosicaoAtual-1].CodigoContaCorrente := FRegGetNetPgto10_1[FPosicaoAtual-2].CodigoContaCorrente;
  FRegGetNetPgto10_1[FPosicaoAtual-1].ChaveUR := FRegGetNetPgto10_1[FPosicaoAtual-2].ChaveUR;

  FRegGetNetPgto10_1[FPosicaoAtual-1].DataArquivo := FRegGetNetPgto10_1[FPosicaoAtual-2].DataArquivo;
  FRegGetNetPgto10_1[FPosicaoAtual-1].VersaoArquivo := FRegGetNetPgto10_1[FPosicaoAtual-2].VersaoArquivo;
  FRegGetNetPgto10_1[FPosicaoAtual-1].NomeArquivo := FRegGetNetPgto10_1[FPosicaoAtual-2].NomeArquivo;
end;

constructor TGetNetPgtoV10_1.Create;
begin
  FPosicaoAtual := 0;
  FContadorRegistro5 := 0;
  FContadorRegistro6 := 0;
  FContadorAjuste := 0;
end;

function TGetNetPgtoV10_1.fGetDados(AIndiceInicial, ATamanho: Integer;
  ATipoFloat: Boolean): Variant;
Begin
  Result := FLinhaArquivo.Substring(AIndiceInicial - 1, ATamanho).Trim;

  If ATipoFloat Then
    Result := TGetNetFuncoes.fStrToFloat(Result) / 100;
end;

function TGetNetPgtoV10_1.fRetVal(AValor: Variant;
  ACampoData: Boolean): Variant;
begin
  If TGetNetFuncoes.fEmptyStr(AValor) Then
    Exit(Null);

  Result := AValor;
  If ACampoData Then
    Result := Copy(Result, 5, 4) + '/' + Copy(Result, 3, 2) + '/' + Copy(Result, 1, 2);
end;

procedure TGetNetPgtoV10_1.pAdicionaLinha(strString: String);
  Const
    AUMENTO_CAPACIDADE_FREG  = 2000;
begin
  Try
    FLinhaArquivo := strString;

    If FPosicaoAtual >= Length(FRegGetNetPgto10_1) - 1 Then
      SetLength(FRegGetNetPgto10_1, Length(FRegGetNetPgto10_1) + AUMENTO_CAPACIDADE_FREG);

    If fGetDados(001,01) = '' Then
      Exit;

    If fGetDados(001,01) = '0' Then
    Begin
      FDataArquivo := fGetDados(002,08);
      FEstabelecimento := fGetDados(032,15);
      FVersaoArquivo := VarToStr(fGetDados(092,25)).ToUpperInvariant
                         .Replace('SSANT. V.', EmptyStr)
                         .Replace('SANT. V.', EmptyStr)
                         .Replace('400 BYTES', EmptyStr)
                         .Trim;

      FRegistroAnterior := fGetDados(001,01);

      FContadorRegistro5 := 0;
      FContadorRegistro6 := 0;
      FContadorAjuste := 0;

      Exit;
    End;

    AjustaDiferencaTaxa;

    If MatchStr(fGetDados(001,01), ['1', '2', '3', '5', '6']) Then
    Begin
      If Not FRegistroAnterior.Equals('1') Then
        Inc(FPosicaoAtual);

      AdicionaRegistro1;

      AdicionaRegistro2;

      AdicionaRegistro3;

      AdicionaRegistro5;

      AdicionaRegistro6;

      AdicionaEstabelecimentoNaLista;
    End;

    FRegistroAnterior := fGetDados(001,01);
  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao importar os registros do arquivo ' + FNomeArquivo + '.' + #13 +
                             'Erro gerado: ' + E.Message);
  End;
end;

function TGetNetPgtoV10_1.DeveGravarRegistro(ARegistro: TRegistroGetNetPgto10_1): Boolean;
Begin
  Result := False;

  If ARegistro.TipoRegistro.Trim.IsEmpty Then
    Exit;

  If ARegistro.CodigoEstabelecimento.Trim.IsEmpty Then
    Exit;

  If MatchStr(ARegistro.DataPagamento.Trim, [EmptyStr, '00000000']) Then
    Exit;

  if ARegistro.TipoRegistro = '6' then
  begin
    if MatchStr(ARegistro.TipoPagamentoOperacao, ['GL', 'AL']) then
    begin
      if ARegistro.ValorLiquidoRV = 0 then
        Exit;
    end;
  end;

  Result := True;
End;

procedure TGetNetPgtoV10_1.pGravarRegistros(pgbProg: TcxProgressBar);
Var
  LInserir: TUniQuery;

  LSQL : String;

  LRegistro: TRegistroGetNetPgto10_1;
begin
  pgbProg.Position := 0;

  If Length(FRegGetNetPgto10_1) = 0 Then
    Exit;

  LSQL := TGetnetFuncoes.RetornaSQLReplace('GET_GEPGTO',['GET_CONCIL']);

  pgbProg.Properties.Max := Length(FRegGetNetPgto10_1) - 1;

  CarregaDataInicialFinalDeImportacao;

  LInserir := Nil;
  Try
    LInserir := VS_FuncoesExternas.fICriaQuery;
    LInserir.SQL.text := LSQL;

    For LRegistro In FRegGetNetPgto10_1 Do
    Begin
      If DeveGravarRegistro(LRegistro) Then
      Begin
        If RegistroJaImportado(LRegistro) Then
        Begin
          TGetnetFuncoes.pStepStatusGravacao(pgbProg);
          Continue;
        End;

        LInserir.Close;
        TGetNetFuncoes.CarregaParametroDataset(LInserir, 'GET_TIPREG', fRetVal(LRegistro.TipoRegistro));
        TGetNetFuncoes.CarregaParametroDataset(LInserir, 'GET_CODEST', fRetVal(LRegistro.CodigoEstabelecimento));
        TGetNetFuncoes.CarregaParametroDataset(LInserir, 'GET_NUM_RV', fRetVal(LRegistro.NumeroRV));
        TGetNetFuncoes.CarregaParametroDataset(LInserir, 'GET_DTA_RV', fRetVal(LRegistro.DataRV, True));
        TGetNetFuncoes.CarregaParametroDataset(LInserir, 'GET_DTAPAG', fRetVal(LRegistro.DataPagamento, True));
        TGetNetFuncoes.CarregaParametroDataset(LInserir, 'GET_CODBCO', fRetVal(LRegistro.CodigoBanco));
        TGetNetFuncoes.CarregaParametroDataset(LInserir, 'GET_CODAGE', fRetVal(LRegistro.CodigoAgencia));
        TGetNetFuncoes.CarregaParametroDataset(LInserir, 'GET_NUMCCO', fRetVal(LRegistro.CodigoContaCorrente));
        TGetNetFuncoes.CarregaParametroDataset(LInserir, 'GET_RV_BRU', fRetVal(LRegistro.ValorBrutoRV));
        TGetNetFuncoes.CarregaParametroDataset(LInserir, 'GET_RV_LIQ', fRetVal(LRegistro.ValorLiquidoRV));
        TGetNetFuncoes.CarregaParametroDataset(LInserir, 'GET_VALDES', fRetVal(LRegistro.ValorTaxaRV));
        TGetNetFuncoes.CarregaParametroDataset(LInserir, 'GET_VALTAX', fRetVal(LRegistro.ValorTarifaRV));
        TGetNetFuncoes.CarregaParametroDataset(LInserir, 'GET_VALPAG', fRetVal(LRegistro.ValorCreditadoRV));
        TGetNetFuncoes.CarregaParametroDataset(LInserir, 'GET_VALENC', 0.00);
        TGetNetFuncoes.CarregaParametroDataset(LInserir, 'GET_RVNPAR', fRetVal(LRegistro.NumeroParcela));
        TGetNetFuncoes.CarregaParametroDataset(LInserir, 'GET_RVTPAR', fRetVal(LRegistro.TotalParcelas));
        TGetNetFuncoes.CarregaParametroDataset(LInserir, 'GET_NUMANT', Null);
        TGetNetFuncoes.CarregaParametroDataset(LInserir, 'GET_VENORI', fRetVal(LRegistro.DataVencimentoOriginal, True));
        TGetNetFuncoes.CarregaParametroDataset(LInserir, 'GET_LIQANT', 0.00);
        TGetNetFuncoes.CarregaParametroDataset(LInserir, 'GET_NUMNSU', fRetVal(LRegistro.NumeroNSU));
        TGetNetFuncoes.CarregaParametroDataset(LInserir, 'GET_DTATRA', fRetVal(LRegistro.DataTransacao, True));
        TGetNetFuncoes.CarregaParametroDataset(LInserir, 'GET_NUMCAR', fRetVal(LRegistro.NumeroCartao));
        TGetNetFuncoes.CarregaParametroDataset(LInserir, 'GET_VALVEN', fRetVal(LRegistro.ValorTransacao));
        TGetNetFuncoes.CarregaParametroDataset(LInserir, 'GET_TOTPAR', fRetVal(LRegistro.TotalParcelas));
        TGetNetFuncoes.CarregaParametroDataset(LInserir, 'GET_NUMPAR', fRetVal(LRegistro.NumeroParcela));
        TGetNetFuncoes.CarregaParametroDataset(LInserir, 'GET_VALPAR', fRetVal(LRegistro.ValorParcela));
        TGetNetFuncoes.CarregaParametroDataset(LInserir, 'GET_CODAUT', fRetVal(LRegistro.CodigoAutorizacao));
        TGetNetFuncoes.CarregaParametroDataset(LInserir, 'GET_STATUS', fRetVal(LRegistro.StatusTransacao));
        TGetNetFuncoes.CarregaParametroDataset(LInserir, 'GET_NUMTER', fRetVal(LRegistro.CodigoTerminal));
        TGetNetFuncoes.CarregaParametroDataset(LInserir, 'GET_TIPPAG', fRetVal(LRegistro.TipoPagamentoOperacao));
        TGetNetFuncoes.CarregaParametroDataset(LInserir, 'GET_MOTAJU', fRetVal(LRegistro.MotivoAjuste));

        TGetNetFuncoes.CarregaParametroDataset(LInserir,'GET_METDAD', fRetVal(LRegistro.Metadados));

        Try
          TGetNetFuncoes.CarregaParametroDataset(LInserir, 'GET_IDEAJU', EmptyStr);
          If Not LRegistro.IdentificadorAjuste.Trim.IsEmpty Then
            TGetNetFuncoes.CarregaParametroDataset(LInserir, 'GET_IDEAJU', LRegistro.IdentificadorAjuste);
        Except
          //para que versões mais antigas, sem rodar o script funcionem
        end;

        If LInserir.SQL.text.Contains('GET_VALMDR') Then
          TGetNetFuncoes.CarregaParametroDataset(LInserir, 'GET_VALMDR', fRetVal(LRegistro.ValorComissaoMDR));

        If LInserir.SQL.text.Contains('GET_VERARQ') Then
        Begin
          TGetNetFuncoes.CarregaParametroDataset(LInserir, 'GET_VERARQ', fRetVal(LRegistro.VersaoArquivo));
          TGetNetFuncoes.CarregaParametroDataset(LInserir, 'GET_CHA_UR', fRetVal(LRegistro.ChaveUR));
          TGetNetFuncoes.CarregaParametroDataset(LInserir, 'GET_CODPRO', fRetVal(LRegistro.CodigoProduto));
          TGetNetFuncoes.CarregaParametroDataset(LInserir, 'GET_TIPCAP', fRetVal(LRegistro.FormaCaptura));
          TGetNetFuncoes.CarregaParametroDataset(LInserir, 'GET_NUMCON', fRetVal(LRegistro.NumeroControle));
          TGetNetFuncoes.CarregaParametroDataset(LInserir, 'GET_DTACAN', fRetVal(LRegistro.DataCartaCancelamento, True));
          TGetNetFuncoes.CarregaParametroDataset(LInserir, 'GET_RV_ORI', fRetVal(LRegistro.NumeroRVOriginal));
          TGetNetFuncoes.CarregaParametroDataset(LInserir, 'GET_PAGORI', fRetVal(LRegistro.DataPagamentoOriginal, True));
          TGetNetFuncoes.CarregaParametroDataset(LInserir, 'GET_NUMOPE', fRetVal(LRegistro.NumeroOperacao));
          TGetNetFuncoes.CarregaParametroDataset(LInserir, 'GET_CANOPE', fRetVal(LRegistro.CanalOperacao));
        End;

        TGetNetFuncoes.CarregaParametroDataset(LInserir, 'GET_NOMARQ', fRetVal(LRegistro.NomeArquivo));
        TGetNetFuncoes.CarregaParametroDataset(LInserir, 'GET_DTAARQ', fRetVal(LRegistro.DataArquivo, True));

        LInserir.ExecSQL;
      End;
      TGetnetFuncoes.pStepStatusGravacao(pgbProg);
    End;

    TGetNetFuncoes.GravarEstabelecimentos;

    LInserir.Close;
    LInserir.SQL.text := 'DELETE FROM ESTCAR WHERE CAR_CODEST="000000000000000" AND CAR_NOMOPE="GETNET"';
    LInserir.ExecSQL;

    LInserir.Close;
    LInserir.SQL.text := 'DELETE FROM GET_GEPGTO WHERE GET_CODEST="000000000000000" AND GET_VERARQ IN ("10.1", "10.3")';
    LInserir.ExecSQL;

    pgbProg.Position := Length(FRegGetNetPgto10_1) - 1;
  Finally
    TGetnetFuncoes.FreeAndNilDatasets(LInserir);
    SetLength(FRegGetNetPgto10_1, 0);
  End;
end;

function TGetNetPgtoV10_1.RemoverZerosAEsquedaEstabelecimento(
  AValor: String): String;
  Var
    LValorInteiro: Int64;
begin
  If AValor.Trim.IsEmpty Then
    Exit;

  LValorInteiro := StrToInt64(AValor.Trim);

  Result := LValorInteiro.ToString;
end;

function TGetNetPgtoV10_1.RetornaPeriodoImportacaoSQL: String;
begin
  Result := ' BETWEEN "' + FormatDateTime('yyyy-mm-dd', FDataInicioImportacao) + '" ' +
            '     AND "' + FormatDateTime('yyyy-mm-dd', FDataFinalImportacao)  + '" ';
end;

function TGetNetPgtoV10_1.RegistroJaImportado(ARegistro: TRegistroGetNetPgto10_1): Boolean;
  Var
    LDataVenda,
    LDataPagamento: TDateTime;
begin
  If Not Assigned(VS_RegistrosJaImportados) Then
    Exit(False);

  If VS_RegistrosJaImportados.IsEmpty Then
    Exit(False);

  Try
    LDataVenda := EncodeDate(StrToInt(Copy(ARegistro.DataTransacao, 5, 4)),
                             StrToInt(Copy(ARegistro.DataTransacao, 3, 2)),
                             StrToInt(LeftStr(ARegistro.DataTransacao, 2)));

    LDataPagamento := EncodeDate(StrToInt(Copy(ARegistro.DataPagamento, 5, 4)),
                                 StrToInt(Copy(ARegistro.DataPagamento, 3, 2)),
                                 StrToInt(LeftStr(ARegistro.DataPagamento, 2)));
  Except
    Exit(False);
  End;

  Result := VS_RegistrosJaImportados.Locate('GET_CODEST;GET_NUMNSU;GET_DTATRA;GET_NUMPAR;GET_DTAPAG;GET_IDEAJU',
                                          VarArrayOf([ARegistro.CodigoEstabelecimento,
                                                      ARegistro.NumeroNsu,
                                                      LDataVenda,
                                                      ARegistro.NumeroParcela,
                                                      LDataPagamento,
                                                      ARegistro.IdentificadorAjuste]), []);
end;

end.
