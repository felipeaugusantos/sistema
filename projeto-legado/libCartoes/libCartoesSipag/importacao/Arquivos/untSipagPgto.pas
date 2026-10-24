unit untSipagPgto;

interface

uses System.Classes, System.StrUtils, System.SysUtils, System.Variants,
     Vcl.ComCtrls, Vcl.Forms, System.Math,

     Uni, cxProgressBar,

     untISipagIntegracaoLibCartoes, untTSipagFuncoes, untSipagTipos;

Type
  TSipagPgto = Class(TInterfacedObject, ICartoes)
  Private
    dtaArq,
    strRegAnt: String;
    FColunas:TStringList;

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

    function fGetDados(AValor: String;
                       ACampoFloat: Boolean = False;
                       ACasasDecimais: Integer = 0): Variant;

    function fRetVal(AValor: Variant;
                     ACampoData: Boolean = False): Variant;
  Public
    constructor Create;
    Destructor Destroy; Override;
    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(pgbProg: TcxProgressBar);

    class function fRetSQLTabelaRegPgto(strTabela: String): String;
    class function fRetEstruturaPgto(strTabela: String): TArrEstruturaSipagPgto;
  End;

Var
  strNomArq,
  strArqAnt: String;
  intParAju: Integer;
  FArquivoFiserv: Boolean;
  FImportouPagamentos: Boolean;

  FIncAddMovimentoFinanceiro:Integer;

  FRegSipagPgto: TArrRegistroSipagPgto;
  FRegistroSipagMovimentoFinanceiro: TArrRegistroSipagMovimentoFinanceiro;

implementation

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

function TSipagPgto.CorrigeCampoNumerico(AValor: String): String;
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

function TSipagPgto.CorrigeDadosBanco(AValor: Variant): Variant;
begin
  Result := Null;
  If Not TSipagFuncoes.fEmptyStr(AValor) Then
  Begin
    Result := AValor;
  End;
end;

function TSipagPgto.CorrigeNumeroParcela(AParcela: String): String;
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

constructor TSipagPgto.Create;
Begin
  FIncAddMovimentoFinanceiro := 0;
  strRegAnt := '';
  FIncAddMovimentoFinanceiro := 0;
  FColunas := TStringList.Create;
  FImportouPagamentos := False;
End;

destructor TSipagPgto.Destroy;
begin
  If Assigned(FColunas) Then
    FreeAndNil(FColunas);
  inherited;
end;

function TSipagPgto.fGetDados(AValor: String; ACampoFloat: Boolean;
  ACasasDecimais: Integer): Variant;
Var
  LResultado: Variant;

  LContador: Integer;

  LZeros: String;
Begin
  LResultado := AValor;
  If ACampoFloat Then
  Begin
    LZeros := '';
    For LContador := 1 to ACasasDecimais do
      LZeros := LZeros + '0';

    LResultado := TSipagFuncoes.fStrToFloat(LResultado) / StrtoFloat('1' + LZeros);
  End;

  Result := LResultado;
End;

class function TSipagPgto.fRetEstruturaPgto(strTabela: String): TArrEstruturaSipagPgto;
Begin
  If strTabela = 'SIP_SIPGTO' Then
  Begin
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

function TSipagPgto.fRetVal(AValor: Variant; ACampoData: Boolean): Variant;
begin
  If TSipagFuncoes.fEmptyStr(AValor) Then
    Exit(Null);

  If ACampoData Then
    Exit(Copy(AValor, 5, 4) + '/' + Copy(AValor, 3, 2) + '/' + Copy(AValor, 1, 2));

  Result := AValor;
end;

procedure TSipagPgto.ImportaAjustesProgramados;
begin
  SetLength(FRegistroSipagMovimentoFinanceiro, Length(FRegistroSipagMovimentoFinanceiro) + 1);
  Inc(FIncAddMovimentoFinanceiro);

  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoRegistro := FColunas.Strings[0];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].BandeiraCartao := FColunas.Strings[1];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].DataPagamento := CorrigeCampoData(FColunas.Strings[2]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento := FColunas.Strings[3];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroResumoVenda := FColunas.Strings[4];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoTransacao := FColunas.Strings[5];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoTransacaoVenda := FColunas.Strings [6];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroComprovanteVenda := FColunas.Strings [7];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].DataTransacao := CorrigeCampoData(FColunas.Strings[8]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroParcela := FColunas.Strings[9];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TotalParcelas := FColunas.Strings[10];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].DataGeracaoSoc := CorrigeCampoData(FColunas.Strings[11]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroControleCliente := FColunas.Strings[12];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroCartao := FColunas.Strings[13];
  // Colunas.Strings[14] Número referência da conta de pagamento
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].CodigoAutorizacao := FColunas.Strings[15];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroComprovanteVenda := FColunas.Strings[16];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoComprovante := TSipagFuncoes.CorrigirTexto(FColunas.Strings[17]);

  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorBrutoVenda := CorrigeCampoNumerico(FColunas.Strings[18]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorLiquidoROC := CorrigeCampoNumerico(FColunas.Strings[19]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorBrutoROC := CorrigeCampoNumerico(FColunas.Strings[20]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Descricaotransacao := TSipagFuncoes.CorrigirTexto(FColunas.Strings[21]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoPagamento := FColunas.Strings[22];
  // Colunas.Strings[23] Número do Terminal
  // Colunas.Strings[24] Acquirer Reference Number
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroRegistroArquivo := FColunas.Strings[25];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NomeArquivo := strNomArq;


  If TSipagFuncoes.fEmptyStr(FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU) Then
    FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU := '0';

  If TSipagFuncoes.fEmptyStr(FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao) Then
    FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao := '0';

  If TSipagFuncoes.fEmptyStr(FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroParcela) Then
    FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroParcela := '01';

  If TSipagFuncoes.fEmptyStr(FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TotalParcelas) Then
    FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TotalParcelas := '01';

  If LeftStr(FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro -1].TipoComprovante, 1).Equals('D') Then
  Begin
    FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorBrutoVenda := ConverterParaNegativo(FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorBrutoVenda);
    FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorLiquidoROC := ConverterParaNegativo(FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorLiquidoROC);
    FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorBrutoROC := ConverterParaNegativo(FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorBrutoROC);
  End;

  If Not Assigned(VS_ListaEstabelecimentos) Then
    VS_ListaEstabelecimentos := TStringList.Create;

  If (FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento <> '') And
     (VS_ListaEstabelecimentos.IndexOf(FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento) < 0) Then
    VS_ListaEstabelecimentos.Add(FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento);
end;

procedure TSipagPgto.ImportaCredito;
begin
  SetLength(FRegistroSipagMovimentoFinanceiro, Length(FRegistroSipagMovimentoFinanceiro)+1);
  Inc(FIncAddMovimentoFinanceiro);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoRegistro  := FColunas.Strings[0];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].BandeiraCartao := FColunas.Strings[1];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DataPagamento := CorrigeCampoData(FColunas.Strings[2]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].Estabelecimento := FColunas.Strings[3];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].EstabelecimentoCentralizador := FColunas.Strings[4];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].InstrucaoPagamento := FColunas.Strings[5];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroResumoVenda := FColunas.Strings[6];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].QuantidadeROC := FColunas.Strings[7];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoPagamento := FColunas.Strings[8];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoTransacao := FColunas.Strings[09];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoDescricaoTransacao := FColunas.Strings[10];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].Descricaotransacao := FColunas.Strings[11];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ResumoPagamento := FColunas.Strings[12];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CNPJBeneficiarioLockin := FColunas.Strings[13];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoLockin := FColunas.Strings[14];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoContaPagamento := FColunas.Strings[15];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].StatusPagamento := FColunas.Strings[16];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DescricaoTransacaoPagamento := FColunas.Strings[17];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ChargebackComprovanteReferencia := FColunas.Strings[18];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteVenda := FColunas.Strings[19];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoTransacaoVenda := FColunas.Strings[20];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DataTransacao := CorrigeCampoData(FColunas.Strings[21]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].HorarioCriacao := FColunas.Strings[22];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroParcela := '01';
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TotalParcelas := '01';
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroContaEC := FColunas.Strings[23];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DataGeracaoSOC := CorrigeCampoData(FColunas.Strings[24]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DataPagamentoSOC := CorrigeCampoData(FColunas.Strings[25]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroControleCliente := FColunas.Strings[26];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroCartao := FColunas.Strings[27];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao := FColunas.Strings[29];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU := FColunas.Strings[30];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoComprovante := TSipagFuncoes.CorrigirTexto(FColunas.Strings[31]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorBrutoROC := CorrigeCampoNumerico(FColunas.Strings[32]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorTaxaImpostosROC := CorrigeCampoNumerico(FColunas.Strings[33]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorLiquidoROC := CorrigeCampoNumerico(FColunas.Strings[34]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorTaxaAntecipacaoROC := CorrigeCampoNumerico(FColunas.Strings[35]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorLiquidoAntecipacaoROC := CorrigeCampoNumerico(FColunas.Strings[36]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorCompraComSaque  := '';
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ReversaoIntercambio  := '';
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroRegistroArquivo := FColunas.Strings[37];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NomeArquivo := strNomArq;

  If TSipagFuncoes.fEmptyStr(FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU) Then
    FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU := '0';

  If TSipagFuncoes.fEmptyStr(FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao) Then
    FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao := '0';

  If Not Assigned(VS_ListaEstabelecimentos) Then
    VS_ListaEstabelecimentos := TStringList.Create;

  If (FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento <> '') And
     (VS_ListaEstabelecimentos.IndexOf(FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro -1 ].Estabelecimento) < 0) Then
    VS_ListaEstabelecimentos.Add(FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro -1].Estabelecimento);
end;

procedure TSipagPgto.ImportaCreditoParcelado;
begin
  SetLength(FRegistroSipagMovimentoFinanceiro, Length(FRegistroSipagMovimentoFinanceiro)+1);
  Inc(FIncAddMovimentoFinanceiro);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoRegistro  := FColunas.Strings[0];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].BandeiraCartao := FColunas.Strings[1];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DataPagamento := CorrigeCampoData(FColunas.Strings[2]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].Estabelecimento := FColunas.Strings[3];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].EstabelecimentoCentralizador := FColunas.Strings[4];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].InstrucaoPagamento := FColunas.Strings[5];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroResumoVenda := FColunas.Strings[6];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].QuantidadeROC := FColunas.Strings[7];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoPagamento := FColunas.Strings[8];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoTransacao := FColunas.Strings[9];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoDescricaoTransacao := FColunas.Strings[10];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].Descricaotransacao := FColunas.Strings[11];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ResumoPagamento := FColunas.Strings[12];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CNPJBeneficiarioLockin := FColunas.Strings[13];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoLockin := FColunas.Strings[14];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoContaPagamento := FColunas.Strings[15];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].StatusPagamento := FColunas.Strings[16];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DescricaoTransacaoPagamento := FColunas.Strings[17];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ChargebackComprovanteReferencia := FColunas.Strings[18];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteVenda := FColunas.Strings[19];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoTransacaoVenda := FColunas.Strings[20];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DataTransacao := CorrigeCampoData(FColunas.Strings[21]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].HorarioCriacao := FColunas.Strings[22];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroParcela := CorrigeNumeroParcela(FColunas.Strings[23]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TotalParcelas := FColunas.Strings[24];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroContaEC := FColunas.Strings[25];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DataGeracaoSOC := CorrigeCampoData(FColunas.Strings[26]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DataPagamentoSOC := CorrigeCampoData(FColunas.Strings[27]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroControleCliente := FColunas.Strings[28];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroCartao := FColunas.Strings[29];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao := FColunas.Strings[31];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU := FColunas.Strings[32];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoComprovante := TSipagFuncoes.CorrigirTexto(FColunas.Strings[33]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorBrutoROC := CorrigeCampoNumerico(FColunas.Strings[34]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorTaxaImpostosROC := CorrigeCampoNumerico(FColunas.Strings[35]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorLiquidoROC := CorrigeCampoNumerico(FColunas.Strings[36]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorTaxaAntecipacaoROC := CorrigeCampoNumerico(FColunas.Strings[37]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorLiquidoAntecipacaoROC := CorrigeCampoNumerico(FColunas.Strings[38]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorCompraComSaque  := '';
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ReversaoIntercambio  := '';
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroRegistroArquivo := FColunas.Strings[39];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NomeArquivo := strNomArq;

  If TSipagFuncoes.fEmptyStr(FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU) Then
    FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU := '0';

  If TSipagFuncoes.fEmptyStr(FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao) Then
    FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao := '0';

  If Not Assigned(VS_ListaEstabelecimentos) Then
    VS_ListaEstabelecimentos := TStringList.Create;

  If (FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento <> '') And
     (VS_ListaEstabelecimentos.IndexOf(FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro -1 ].Estabelecimento) < 0) Then
    VS_ListaEstabelecimentos.Add(FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro -1].Estabelecimento);
end;

procedure TSipagPgto.ImportaDebitos;
begin
  SetLength(FRegistroSipagMovimentoFinanceiro, Length(FRegistroSipagMovimentoFinanceiro)+1);
  Inc(FIncAddMovimentoFinanceiro);

  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoRegistro  := FColunas.Strings[0];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].BandeiraCartao := FColunas.Strings[1];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DataPagamento := CorrigeCampoData(FColunas.Strings[2]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].Estabelecimento := FColunas.Strings[3];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].EstabelecimentoCentralizador := FColunas.Strings[4];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].InstrucaoPagamento := FColunas.Strings[5];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroResumoVenda := FColunas.Strings[6];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].QuantidadeROC := FColunas.Strings[7];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoPagamento := FColunas.Strings[8];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoTransacao := FColunas.Strings[9];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoDescricaoTransacao := FColunas.Strings[10];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].Descricaotransacao := FColunas.Strings[11];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ResumoPagamento := FColunas.Strings[12];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CNPJBeneficiarioLockin := FColunas.Strings[13];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoLockin := FColunas.Strings[14];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoContaPagamento := FColunas.Strings[15];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].StatusPagamento := FColunas.Strings[16];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DescricaoTransacaoPagamento := FColunas.Strings[17];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ChargebackComprovanteReferencia := FColunas.Strings[18];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteVenda := FColunas.Strings[19];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoTransacaoVenda := '';
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DataTransacao := CorrigeCampoData(FColunas.Strings[20]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].HorarioCriacao := FColunas.Strings[21];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroParcela := '01';
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TotalParcelas := '01';
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroContaEC := FColunas.Strings[22];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DataGeracaoSOC := CorrigeCampoData(FColunas.Strings[23]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DataPagamentoSOC := CorrigeCampoData(FColunas.Strings[24]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroControleCliente := FColunas.Strings[25];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroCartao := FColunas.Strings[26];

  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao := FColunas.Strings[28];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU := FColunas.Strings[29];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoComprovante := TSipagFuncoes.CorrigirTexto(FColunas.Strings[30]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorBrutoROC := CorrigeCampoNumerico(FColunas.Strings[31]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorTaxaImpostosROC := CorrigeCampoNumerico(FColunas.Strings[32]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorLiquidoROC := CorrigeCampoNumerico(FColunas.Strings[33]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorTaxaAntecipacaoROC := CorrigeCampoNumerico(FColunas.Strings[34]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorLiquidoAntecipacaoROC := CorrigeCampoNumerico(FColunas.Strings[35]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorCompraComSaque  := CorrigeCampoNumerico(FColunas.Strings[36]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ReversaoIntercambio  := CorrigeCampoNumerico(FColunas.Strings[37]);
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroRegistroArquivo := FColunas.Strings[37];
  FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NomeArquivo := strNomArq;

  If TSipagFuncoes.fEmptyStr(FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU) Then
    FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU := '0';

  If TSipagFuncoes.fEmptyStr(FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao) Then
    FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao := '0';

  If Not Assigned(VS_ListaEstabelecimentos) Then
    VS_ListaEstabelecimentos := TStringList.Create;

  If (FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento <> '') And
     (VS_ListaEstabelecimentos.IndexOf(FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro -1 ].Estabelecimento) < 0) Then
    VS_ListaEstabelecimentos.Add(FRegistroSipagMovimentoFinanceiro[FIncAddMovimentoFinanceiro -1].Estabelecimento);
end;

procedure TSipagPgto.pAdicionaLinha(strString: String);
Var
  lstCampos: TStringList;
begin
  lstCampos := TStringList.Create;
  lstCampos.Delimiter     := ',';
  lstCampos.DelimitedText := StringReplace(strString, ' ', EmptyStr, [rfReplaceAll]);

  If Not Assigned(VS_ListaEstabelecimentos) Then
    VS_ListaEstabelecimentos := TStringList.Create;

  If FArquivoFiserv Then
  begin
    FColunas.Delimiter := RetornaDelimitador(strString);
    FColunas.StrictDelimiter := True;
    FColunas.DelimitedText := TSipagFuncoes.fConverteParaAcento(strString);
    If TSipagFuncoes.fEmptyStr(FColunas.Text) Then
      Exit;

    // Registro 025 – Detalhamento Ordem de Pagamento de Crédito Parcelado
    If FColunas.Strings[0].Equals('025') Then
    begin
      ImportaCreditoParcelado;
    end

    // Detalhamento (Pagamento) – Registro 021 – Detalhamento Ordem de Pagamento de Débito
    Else If FColunas.Strings[0].Equals('021') Then
    begin
      ImportaDebitos;
    end

    // Detalhamento (Pagamento) – Registro 023 – Detalhamento Ordem de Pagamento de Crédito
    Else IF FColunas.Strings[0].Equals('023') Then
    begin
      ImportaCredito;
    end
    // Registro 031 – Ajustes Programados (Próximos 30 Dias)
    Else IF FColunas.Strings[0].Equals('031') Then
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
       (VS_ListaEstabelecimentos.IndexOf(FRegSipagPgto[Length(FRegSipagPgto)-1].strCodEst) < 0) Then
      VS_ListaEstabelecimentos.Add(FRegSipagPgto[Length(FRegSipagPgto)-1].strCodEst);

    strRegAnt := lstCampos[0];
  End;
end;

procedure TSipagPgto.pGravarRegistros(pgbProg: TcxProgressBar);
  Var
    LGravacao: TUniQuery;
    intCont  : Integer;
    LMovimentoFinanceiro : TUniQuery;
    LContador: Integer;
begin
  LMovimentoFinanceiro := Nil;
  Try

    pgbProg.Position := 0;

    If Length(FRegistroSipagMovimentoFinanceiro) > 0 Then
    Begin
      LMovimentoFinanceiro := VS_FuncoesExternas.fICriaQuery;
      LMovimentoFinanceiro.SQL.Text := TSipagFuncoes.RetornaSQLReplace('SIP_FVPGTO',['SIP_CONCIL']);

      pgbProg.Properties.Max := Length(FRegistroSipagMovimentoFinanceiro) - 1;

      For LContador := 0 To Length(FRegistroSipagMovimentoFinanceiro) - 1 Do
      Begin
        LMovimentoFinanceiro.Close;

        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_TIPREG', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].TipoRegistro));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_NOMBAN', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].BandeiraCartao));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_DTAPAG', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].DataPagamento));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_CODEST', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].Estabelecimento));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_ESTCEN', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].EstabelecimentoCentralizador));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_INSPAG', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].InstrucaoPagamento));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_NUM_RV', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].NumeroResumoVenda));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_QTDROC', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].QuantidadeROC));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_TIPPAG', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].TipoPagamento));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_TIPTRA', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].TipoTransacao));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_CODDES', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].CodigoDescricaoTransacao));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_DESTRA', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].Descricaotransacao));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_RESPAG', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].ResumoPagamento));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_CNPJLC', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].CNPJBeneficiarioLockin));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_TIPLOC', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].TipoLockin));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_TIPCTA', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].TipoContaPagamento));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_STATUS', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].StatusPagamento));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_DESPAG', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].DescricaoTransacaoPagamento));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_COMREF', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].ChargebackComprovanteReferencia));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_REFVEN', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].NumeroComprovanteVenda));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_TIPVEN', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].TipoTransacaoVenda));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_DTATRA', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].DataTransacao));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_HORTRA', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].HorarioCriacao));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_NUMPAR', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].NumeroParcela));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_TOTPAR', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].TotalParcelas));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_NUMCTA', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].NumeroContaEC));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_GERSOC', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].DataGeracaoSOC));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_PAGSOC', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].DataPagamentoSOC));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_CONCLI', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].NumeroControleCliente));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_NUMCAR', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].NumeroCartao));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_CODAUT', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].CodigoAutorizacao));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_NUMNSU', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].NumeroComprovanteNSU));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_TIPCON', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].TipoComprovante));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_VALBRU', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].ValorBrutoROC));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_VALTAX', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].ValorTaxaImpostosROC));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_VALLIQ', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].ValorLiquidoROC));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_TAXANT', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].ValorTaxaAntecipacaoROC));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_LIQANT', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].ValorLiquidoAntecipacaoROC));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_VALSAQ', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].ValorCompraComSaque));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_VALINT', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].ReversaoIntercambio));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_BRUVEN', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].ValorBrutoVenda));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_SEQARQ', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].NumeroRegistroArquivo));
        TSipagFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIP_NOMARQ', CorrigeDadosBanco(FRegistroSipagMovimentoFinanceiro[LContador].NomeArquivo));

        LMovimentoFinanceiro.ExecSQL;

        If Not MatchStr(FRegistroSipagMovimentoFinanceiro[LContador].TipoRegistro,['031']) Then
          FImportouPagamentos := True;

        TSipagFuncoes.pStepStatusGravacao(pgbProg);
      End;

      SetLength(FRegistroSipagMovimentoFinanceiro,0);

      TSipagFuncoes.GravarEstabelecimentos;
    End;
  Finally
    TSipagFuncoes.FreeAndNilDatasets(LMovimentoFinanceiro);
  End;

  LGravacao := Nil;
  Try
    LGravacao := VS_FuncoesExternas.fICriaQuery;
    LGravacao.SQL.Text := TSipagFuncoes.RetornaSQLReplace('SIP_SIPGTO', ['SIP_CONCIL']);

    pgbProg.Position := 0;

    If Length(FRegSipagPgto) > 0 Then
    Begin
      pgbProg.Properties.Max      := Length(FRegSipagPgto)-1;
      FImportouPagamentos := True;
      For intCont := 0 To Length(FRegSipagPgto)-1 Do
      Begin
        Application.ProcessMessages;
        If FRegSipagPgto[intCont].strTipReg <> '' Then
        Begin
          LGravacao.Close;

          TSipagFuncoes.CarregaParametroDataset(LGravacao, 'SIP_TIPREG', fRetVal(FRegSipagPgto[intCont].strTipReg));
          TSipagFuncoes.CarregaParametroDataset(LGravacao, 'SIP_CODEST', fRetVal(FRegSipagPgto[intCont].strCodEst));
          TSipagFuncoes.CarregaParametroDataset(LGravacao, 'SIP_DTAPAG', fRetVal(FRegSipagPgto[intCont].strDtaPag, True));
          TSipagFuncoes.CarregaParametroDataset(LGravacao, 'SIP_OC_DOC', fRetVal(FRegSipagPgto[intCont].strOC_Doc));
          TSipagFuncoes.CarregaParametroDataset(LGravacao, 'SIP_RV_BRU', fRetVal(FRegSipagPgto[intCont].fltRV_Bru));
          TSipagFuncoes.CarregaParametroDataset(LGravacao, 'SIP_RV_LIQ', fRetVal(FRegSipagPgto[intCont].fltRV_Liq));
          TSipagFuncoes.CarregaParametroDataset(LGravacao, 'SIP_CODBCO', fRetVal(FRegSipagPgto[intCont].strCodBco));
          TSipagFuncoes.CarregaParametroDataset(LGravacao, 'SIP_CODAGE', fRetVal(FRegSipagPgto[intCont].strCodAge));
          TSipagFuncoes.CarregaParametroDataset(LGravacao, 'SIP_NUMCCO', fRetVal(FRegSipagPgto[intCont].strNumCco));
          TSipagFuncoes.CarregaParametroDataset(LGravacao, 'SIP_VALBRU', fRetVal(FRegSipagPgto[intCont].fltValBru));
          TSipagFuncoes.CarregaParametroDataset(LGravacao, 'SIP_VALDES', fRetVal(FRegSipagPgto[intCont].fltValDes));
          TSipagFuncoes.CarregaParametroDataset(LGravacao, 'SIP_VALLIQ', fRetVal(FRegSipagPgto[intCont].fltValLIQ));
          TSipagFuncoes.CarregaParametroDataset(LGravacao, 'SIP_TIPOPE', fRetVal(FRegSipagPgto[intCont].strTipOpe));
          TSipagFuncoes.CarregaParametroDataset(LGravacao, 'SIP_NUM_RV', fRetVal(FRegSipagPgto[intCont].strNum_RV));
          TSipagFuncoes.CarregaParametroDataset(LGravacao, 'SIP_TIPCRE', fRetVal(FRegSipagPgto[intCont].strTipOpe));
          TSipagFuncoes.CarregaParametroDataset(LGravacao, 'SIP_STATUS', fRetVal(FRegSipagPgto[intCont].strStatus));
          TSipagFuncoes.CarregaParametroDataset(LGravacao, 'SIP_TOTPAR', RightStr(fRetVal(FRegSipagPgto[intCont].strTotPar), 2));
          TSipagFuncoes.CarregaParametroDataset(LGravacao, 'SIP_NUMPAR', RightStr(fRetVal(FRegSipagPgto[intCont].strNumPar), 2));
          TSipagFuncoes.CarregaParametroDataset(LGravacao, 'SIP_DTATRA', fRetVal(FRegSipagPgto[intCont].strDtaTra, True));
          TSipagFuncoes.CarregaParametroDataset(LGravacao, 'SIP_CODAUT', fRetVal(FRegSipagPgto[intCont].strCodAut));
          TSipagFuncoes.CarregaParametroDataset(LGravacao, 'SIP_NUMCAR', fRetVal(FRegSipagPgto[intCont].strNumCar));
          TSipagFuncoes.CarregaParametroDataset(LGravacao, 'SIP_NUMNSU', fRetVal(FRegSipagPgto[intCont].strNumNSU));
          TSipagFuncoes.CarregaParametroDataset(LGravacao, 'SIP_BANDEI', fRetVal(FRegSipagPgto[intCont].strBandei));
          TSipagFuncoes.CarregaParametroDataset(LGravacao, 'SIP_NUMCLI', fRetVal(FRegSipagPgto[intCont].strNumCli));
          TSipagFuncoes.CarregaParametroDataset(LGravacao, 'SIP_CODAJU', fRetVal(FRegSipagPgto[intCont].strCodAju));
          TSipagFuncoes.CarregaParametroDataset(LGravacao, 'SIP_DESAJU', fRetVal(FRegSipagPgto[intCont].strDesAju));
          TSipagFuncoes.CarregaParametroDataset(LGravacao, 'SIP_TIPAJU', fRetVal(FRegSipagPgto[intCont].strTipAju));

          TSipagFuncoes.CarregaParametroDataset(LGravacao, 'SIP_NOMARQ', fRetVal(FRegSipagPgto[intCont].strNomArq));
          TSipagFuncoes.CarregaParametroDataset(LGravacao, 'SIP_DTAARQ', fRetVal(FRegSipagPgto[intCont].strDtaArq, True));

          LGravacao.ExecSQL;
        End;

        TSipagFuncoes.pStepStatusGravacao(pgbProg);
      End;

      TSipagFuncoes.GravarEstabelecimentos;
    End;
  Finally
    TSipagFuncoes.FreeAndNilDatasets(LGravacao);
  End;
end;

function TSipagPgto.RetornaDelimitador(AText: String): Char;
begin
  Result := ',';

  If Pos(';',AText) > 0 Then
    Result := ';';
end;

end.
