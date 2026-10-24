unit PitStop.Classes.EndPoint;

interface

uses classes, REST.Types, REST.Json, System.JSON,  System.IOUtils, System.StrUtils,
     System.SysUtils, Generics.Collections,
     Cotacao.ApiPrecos.BaseParam,
     Cotacao.ApiPrecos.ConstAndTypes;


type


  TProdutosConsultaPitStop = Record
    codigoFabrica: String;
    marca: string;
    ean: string;
    quantidade: integer;
    precoGanhador: Double;
    condicaoPagamento: String;
    codigoInterno: String;
    UfPreco: String;
    precoGanhadorUnitario: Double;
  End;

  TCNPJFornecedores_Disponiveis = array of string;


  TParamFornecedoresPitStop = class(TBaseParamApi)
  public
    EmpresaCNPJ: String;
    CNPJFornecedores_Disponiveis: TCNPJFornecedores_Disponiveis;
    function fProcessaRetono: String; override;
  End;

  TParamCancelaCotacao = class(TBaseParamApi)
  protected
    function getJsonEnvion: String; override;
  public
    idCotacao: String;
    function fProcessaRetono: String; override;
  End;

  TParamToken = class(TBaseParamApi)
  public
    Token: String;
    function fProcessaRetono: String; override;
  End;

  TRetornoBuscaCotacaoNaoLocalizado = record
    ean: string;
    desc: string;
  End;

  TArrRetornoBuscaCotacaoNaoLocalizado = array of TRetornoBuscaCotacaoNaoLocalizado;

  TRetornoBuscaCotacaoProduto = record
    id_ped: string;
    ean: string;
    cod_interno: integer;
    preco: double;
    frete: double;
    despesa: double;
    imposto_st: double;
    imposto_ipi: double;
  End;

  TArrRetornoBuscaCotacaoProduto = array of TRetornoBuscaCotacaoProduto;


  TRetornoBuscaCotacao = record
    ArrRetornoBuscaCotacaoNaoLocalizado: TArrRetornoBuscaCotacaoNaoLocalizado;
    ArrRetornoBuscaCotacaoProduto: TArrRetornoBuscaCotacaoProduto;
  End;

  TParamBuscaCotacao = class(TBaseParamApi)
    idConsulta: String;
    pagina: integer;
    totalPaginas: integer;
    Teste: Boolean;
    RetornoBuscaCotacao: TRetornoBuscaCotacao;
  public
    function fProcessaRetono: String; override;
  End;

  TRetornoProduto =  Record
    PrecoUnitario: Double;
    Marca: string;
    codFabrica: String;
    Item: String;
    Erro: string;
  End;


  TRetornoCotacao = Record
    idCotacao: String;
    mensagem: String;
  end;

  TProdutosDictionary = TDictionary<String, TProdutosConsultaPitStop>;

  TParamLista = class(TBaseParamApi)
  private
    ProdutosDictionary: TProdutosDictionary;
  protected
    procedure pIniciaValores; override;
    function getJsonEnvion: String; override;
  public
    Cnpj_Cliente: String;
    Cnpj_Filial: String;
    PrazoMedio: String;
    CondicaoPagamento: String;
    LogoMarca: Integer;
    PitStopTipoConsulta: TPitStopTipoConsulta;
    Quantidade: Integer;
    RetornoProduto: TRetornoProduto;
    RetornoCotacao: TRetornoCotacao;
    idCotacao: String;
    function fProcessaRetono: String; override;
    property JsonEnvioBody: String read getJsonEnvion;
    procedure pAddItemConsulta( ACodigoItem, ACodFab, AMarca, AEan: String;
                               qtdite: integer; AConPag: string = '';
                               APrecoGanhador: Double= 0;
                               APrecoGanhadorUnitario: Double = 0; AUfPreco: String = '';
                               ACodigoInterno: String = '');
    function fGetQtdItens: Integer;
    property Produtos: TProdutosDictionary read ProdutosDictionary write ProdutosDictionary;

  End;

  TStatusCotacaoPitStop = class
    class function StatusPitStopCotacaoToInt(AStatusPitStopCotacao: TStatusPitStopCotacao): Integer;
    class function IntToStatusPitStopCotacao(AStatusPitStopCotacao: Integer): TStatusPitStopCotacao;
    class function DescricaoStatusPitStopCotacao(AStatusPitStopCotacao: TStatusPitStopCotacao; DataHoraInicio: TDateTime): String;

  End;

  TStatusBuscaCotacaoPitStop = class
    class function fConsultaPitStopToInt(AStatusConsultaPitStop: TStatusConsultaPitStop): Integer;
    class function fIntToStatusConsultaPitStop(AStatus: Integer): TStatusConsultaPitStop;
  End;


implementation

uses
  untFuncoesSimples;


{ TParamlista }

function TParamLista.fGetQtdItens: Integer;
begin
  Result := 0;
  If Assigned(ProdutosDictionary) Then
    Result := ProdutosDictionary.Count
end;

function TParamlista.fProcessaRetono: String;
var
  JsonRetKeyValue :TJsonRetKeyValue;
begin
  inherited;
  If PitStopTipoConsulta =  pstcBalcao then
  begin
    For JsonRetKeyValue  in FArrJsonRetKeyValue do
    begin

      If (JsonRetKeyValue.Key = 'data.preco_unitario')  Then
        RetornoProduto.PrecoUnitario := StrToFloatDef(AnsiReplaceStr(JsonRetKeyValue.Value, '.', ','), 0)
      Else If (JsonRetKeyValue.Key = 'data.Erro') Then
        RetornoProduto.Erro := JsonRetKeyValue.Value
      Else If (JsonRetKeyValue.Key = 'data.cod_fabrica') Then
        RetornoProduto.CodFabrica := JsonRetKeyValue.Value
      Else If (JsonRetKeyValue.Key = 'data.desc_marca') Then
        RetornoProduto.Marca := JsonRetKeyValue.Value
      Else If (JsonRetKeyValue.Key = 'data.desc_produto') Then
        RetornoProduto.item := JsonRetKeyValue.Value
      Else If (JsonRetKeyValue.Key = 'message')  Then
      begin
        RetornoApi.Falha := JsonRetKeyValue.Value;
      End;

    End;
  End
  Else If PitStopTipoConsulta =  pstcFaturaPedido then
  Begin
    For JsonRetKeyValue  in FArrJsonRetKeyValue do
    begin
      If (JsonRetKeyValue.Key = 'id_cotacao')  Then
        RetornoCotacao.idCotacao := JsonRetKeyValue.Value
      Else If (JsonRetKeyValue.Key = 'msg')  Then
        RetornoCotacao.mensagem := JsonRetKeyValue.Value
      Else If (JsonRetKeyValue.Key = 'message')  Then
      begin
        RetornoApi.Falha := JsonRetKeyValue.Value;
      End;
    End
  End
  Else If PitStopTipoConsulta =  pstcCotacao then
  Begin
    For JsonRetKeyValue  in FArrJsonRetKeyValue do
    begin
      If (JsonRetKeyValue.Key = 'id_cotacao')  Then
        RetornoCotacao.idCotacao := JsonRetKeyValue.Value
      Else If (JsonRetKeyValue.Key = 'msg')  Then
        RetornoCotacao.mensagem := JsonRetKeyValue.Value
      Else If (JsonRetKeyValue.Key = 'message')  Then
      begin
        RetornoApi.Falha := JsonRetKeyValue.Value;
      End;
    end;
  End;

end;

function TParamlista.getJsonEnvion: String;
var Key : string;
    JSON: String;
    produto: string;
    produtos: String;
    qtdItens: integer;
begin
  qtdItens := 0;
  produto := '"produto": [';
  If PitStopTipoConsulta = pstcCotacaoSegundaEtapa then
    produto := '"produtos": [';
  for Key in ProdutosDictionary.Keys do
  Begin
     If produtos <> '' Then
       produtos := produtos + ',';

     If PitStopTipoConsulta = pstcCotacaoSegundaEtapa then
     begin
       produtos := produtos + '{"codigoBarras": "' + ProdutosDictionary.Items[Key].ean + '",';
       produtos := produtos + '"marca":"' +ProdutosDictionary.Items[Key].marca + '",';
       produtos := produtos + '"codigoFabrica":"' +ProdutosDictionary.Items[Key].codigoFabrica + '",';
       produtos := produtos + '"quantidadeCotacao":' +ProdutosDictionary.Items[Key].quantidade.ToString + ',';
       produtos := produtos + '"precoGanhador":' +AnsiReplaceStr(FormatFloat('0.00', ProdutosDictionary.Items[Key].precoGanhador), ',', '.') + ',';
       produtos := produtos + '"precoGanhadorUnitario":' +AnsiReplaceStr(FormatFloat('0.00', ProdutosDictionary.Items[Key].precoGanhadorUnitario), ',', '.') + ',';
       produtos := produtos + '"ufPreco":"' +ProdutosDictionary.Items[Key].UfPreco + '",';

       If ProdutosDictionary.Items[Key].condicaoPagamento <> '' Then
          produtos := produtos + '"condicaoPagamento":"' + fFormataCondPag(ProdutosDictionary.Items[Key].condicaoPagamento)+ '"}'
        Else
          produtos := produtos + '"condicaoPagamento":""}';
     End
     Else
     Begin
       produtos := produtos + '{"codigo_fabrica": "' + ProdutosDictionary.Items[Key].codigoFabrica + '",';
       produtos := produtos + '"marca":"' +ProdutosDictionary.Items[Key].marca + '",';
       produtos := produtos + '"ean":"' +ProdutosDictionary.Items[Key].ean + '",';
       If PitStopTipoConsulta = pstcFaturaPedido then
         produtos := produtos + '"cod_interno":' +ProdutosDictionary.Items[Key].codigoInterno + '}'
       Else
         produtos := produtos + '"quantidade":' +ProdutosDictionary.Items[Key].quantidade.ToString + '}';
     End;
     inc(qtdItens);
  End;

  produto := produto + produtos + ']';

  JSON := JSON + '{';
  case PitStopTipoConsulta of
    pstcBalcao:  JSON := JSON + '"balcao":{';
    pstcCotacao:   JSON := JSON + '"cotacao":{';
    pstcCotacaoSegundaEtapa:   JSON := JSON + '"melhorPreco":{';
    pstcFaturaPedido:   JSON := JSON + '"faturar":{';
  End;
  If (PitStopTipoConsulta = pstcCotacaoSegundaEtapa) or (PitStopTipoConsulta = pstcFaturaPedido)  then
    JSON := JSON + '"idCotacao":"' + idCotacao + '",'
  Else
  Begin

    JSON := JSON + '"cnpj_cliente":"' + Cnpj_Cliente + '",';
    JSON := JSON + '"cnpj_filial_consulta":"' + Cnpj_Filial + '",';
    If PitStopTipoConsulta = pstcBalcao then
    begin
      JSON := JSON + '"prazo_medio":"' + PrazoMedio + '",';
      JSON := JSON + '"quantidade":' + qtdItens.ToString + ',';
      JSON := JSON + '"empresa":82,';
    End;
    If PitStopTipoConsulta = pstcCotacao then
    begin
      JSON := JSON + '"condicaoPagamento":"'+CondicaoPagamento+'",';
      JSON := JSON + '"logomarca":0,';
    End;

  End;
  JSON := JSON + produto;
  JSON := JSON + '}';
  JSON := JSON + '}';
  Result := JSON;
end;

procedure TParamlista.pAddItemConsulta(ACodigoItem, ACodFab, AMarca, AEan: String;
                                       qtdite: integer; AConPag: string = '';
                                       APrecoGanhador: Double= 0;
                                       APrecoGanhadorUnitario: Double = 0; AUfPreco: String = '';
                                       ACodigoInterno: String = '');
var ProdutosConsultaPitStop: TProdutosConsultaPitStop;
begin
  ProdutosConsultaPitStop.codigoFabrica := ACodFab;
  ProdutosConsultaPitStop.marca := AMarca;
  ProdutosConsultaPitStop.ean := AEan;
  ProdutosConsultaPitStop.Quantidade := qtdite;
  ProdutosConsultaPitStop.condicaoPagamento := AConPag;
  ProdutosConsultaPitStop.precoGanhador := AprecoGanhador;
  ProdutosConsultaPitStop.codigoInterno := ACodigoInterno;
  ProdutosConsultaPitStop.PrecoGanhadorUnitario := APrecoGanhadorUnitario;
  ProdutosConsultaPitStop.UfPreco := AUfPreco;

  ProdutosDictionary.Add(ACodigoItem,  ProdutosConsultaPitStop);
end;

procedure TParamlista.pIniciaValores;
begin
  inherited;
  ProdutosDictionary := TDictionary<string,TProdutosConsultaPitStop>.Create;

end;

{ TParamFornecedoresPitStop }


function TParamFornecedoresPitStop.fProcessaRetono: String;
var JsonRetKeyValue :TJsonRetKeyValue;
    PosArray: integer;
begin
  inherited;
  For JsonRetKeyValue  in FArrJsonRetKeyValue do
  begin
    If JsonRetKeyValue.Index > -1 Then
    begin
      If JsonRetKeyValue.Key = 'filiais.cnpj' Then
      Begin
        SetLength(CNPJFornecedores_Disponiveis, succ(Length(CNPJFornecedores_Disponiveis)));
        PosArray := High(CNPJFornecedores_Disponiveis);
        CNPJFornecedores_Disponiveis[PosArray] := JsonRetKeyValue.Value;
      end;
    end;

  End;
  {}
end;

{ TParamToken }

function TParamToken.fProcessaRetono: String;
var
  JsonRetKeyValue :TJsonRetKeyValue;
begin
  inherited;
  Token := '';
  For JsonRetKeyValue  in FArrJsonRetKeyValue do
  begin
    If JsonRetKeyValue.Key = 'message' Then
    Begin
      RetornoApi.Falha := JsonRetKeyValue.Value;
    End
    Else If JsonRetKeyValue.Key = 'token' Then
    Begin
      Token := JsonRetKeyValue.Value;
      Break;
    end;
  End;
end;

{ TParamBuscaCotacao }

function TParamBuscaCotacao.fProcessaRetono: String;
var
  JsonRetKeyValue :TJsonRetKeyValue;
  intLastPosNaoLocalizado : integer;
  intLastPosLocalizado: integer;
begin
  inherited;
  intLastPosNaoLocalizado := -1;
  intLastPosLocalizado := -1;
//  RetornoBuscaCotacao.retMessage := '';
  For JsonRetKeyValue  in FArrJsonRetKeyValue do
  begin
    If JsonRetKeyValue.Key = 'message' Then
    Begin
      RetornoApi.Falha := JsonRetKeyValue.Value;
    End;


    If Pos('itens_nao_localizados', JsonRetKeyValue.Key) > 0 Then
    begin
      If  JsonRetKeyValue.Index >  intLastPosNaoLocalizado then
      begin
        intLastPosNaoLocalizado := JsonRetKeyValue.Index;
        SetLength(RetornoBuscaCotacao.ArrRetornoBuscaCotacaoNaoLocalizado, intLastPosNaoLocalizado + 1);
      End;
      If Pos('itens_nao_localizados.ean', JsonRetKeyValue.Key) > 0 Then
        RetornoBuscaCotacao.ArrRetornoBuscaCotacaoNaoLocalizado[JsonRetKeyValue.Index].ean := JsonRetKeyValue.Value
      Else If Pos('itens_nao_localizados.desc', JsonRetKeyValue.Key) > 0 Then
        RetornoBuscaCotacao.ArrRetornoBuscaCotacaoNaoLocalizado[JsonRetKeyValue.Index].desc := JsonRetKeyValue.Value;
    End;


    If Pos('itens.', JsonRetKeyValue.Key) > 0 Then
    begin
      If  JsonRetKeyValue.Index >  intLastPosLocalizado then
      begin
        intLastPosLocalizado := JsonRetKeyValue.Index;
        SetLength(RetornoBuscaCotacao.ArrRetornoBuscaCotacaoProduto, intLastPosLocalizado + 1);
      End;
      If Pos('itens.id_ped', JsonRetKeyValue.Key) > 0 Then
        RetornoBuscaCotacao.ArrRetornoBuscaCotacaoProduto[JsonRetKeyValue.Index].id_ped := JsonRetKeyValue.Value
      Else If Pos('itens.ean', JsonRetKeyValue.Key) > 0 Then
        RetornoBuscaCotacao.ArrRetornoBuscaCotacaoProduto[JsonRetKeyValue.Index].ean := JsonRetKeyValue.Value
      Else If Pos('itens.cod_interno', JsonRetKeyValue.Key) > 0 Then
        RetornoBuscaCotacao.ArrRetornoBuscaCotacaoProduto[JsonRetKeyValue.Index].cod_interno := JsonRetKeyValue.Value.ToInteger
      Else If Pos('itens.preco', JsonRetKeyValue.Key) > 0 Then
        RetornoBuscaCotacao.ArrRetornoBuscaCotacaoProduto[JsonRetKeyValue.Index].preco := StrToFloatDef(AnsiReplaceStr(JsonRetKeyValue.Value, '.', ','), 0)
      Else If Pos('itens.frete', JsonRetKeyValue.Key) > 0 Then
        RetornoBuscaCotacao.ArrRetornoBuscaCotacaoProduto[JsonRetKeyValue.Index].frete := StrToFloatDef(AnsiReplaceStr(JsonRetKeyValue.Value, '.', ','), 0)
      Else If Pos('itens.despesa', JsonRetKeyValue.Key) > 0 Then
        RetornoBuscaCotacao.ArrRetornoBuscaCotacaoProduto[JsonRetKeyValue.Index].despesa := StrToFloatDef(AnsiReplaceStr(JsonRetKeyValue.Value, '.', ','), 0)
      Else If Pos('itens.imposto_st', JsonRetKeyValue.Key) > 0 Then
        RetornoBuscaCotacao.ArrRetornoBuscaCotacaoProduto[JsonRetKeyValue.Index].imposto_st := StrToFloatDef(AnsiReplaceStr(JsonRetKeyValue.Value, '.', ','), 0)
      Else If Pos('itens.imposto_ipi', JsonRetKeyValue.Key) > 0 Then
        RetornoBuscaCotacao.ArrRetornoBuscaCotacaoProduto[JsonRetKeyValue.Index].imposto_ipi := StrToFloatDef(AnsiReplaceStr(JsonRetKeyValue.Value, '.', ','), 0)
    End;
    If JsonRetKeyValue.Key = 'retorno.numero_paginas' Then
      totalPaginas := JsonRetKeyValue.Value.ToInteger;
  End;
end;

{ TStatusCotacaoPitStop }

class function TStatusCotacaoPitStop.IntToStatusPitStopCotacao(
  AStatusPitStopCotacao: Integer): TStatusPitStopCotacao;
begin
  Result := spscSemApi;
  case AStatusPitStopCotacao of
    0: Result := spscSemApi;
    1: Result := spscComApi;
    2: Result := spscPendenteConsultaPreco;
    3: Result := spscIntegrandoConsultaPreco;
    4: Result := spscPendenteImportarConsultaPreco;
    5: Result := spscPendenteRecotarPreco;
    6: Result := spscIntegrandoRecotarPreco;
    7: Result := spscPendenteImportarRecotarPreco;
    8: Result := spscConcluido;
  End;end;

class function TStatusCotacaoPitStop.StatusPitStopCotacaoToInt(
  AStatusPitStopCotacao: TStatusPitStopCotacao): Integer;
begin
  Result := 0;
  case AStatusPitStopCotacao of
    spscSemApi: Result := 0;
    spscComApi: Result := 1;
    spscPendenteConsultaPreco: Result := 2;
    spscIntegrandoConsultaPreco: Result := 3;
    spscPendenteImportarConsultaPreco: Result := 4;
    spscPendenteRecotarPreco: Result := 5;
    spscIntegrandoRecotarPreco: Result := 6;
    spscPendenteImportarRecotarPreco: Result := 7;
    spscConcluido: Result := 8;
  End;
end;

class function TStatusCotacaoPitStop.DescricaoStatusPitStopCotacao(
  AStatusPitStopCotacao: TStatusPitStopCotacao; DataHoraInicio: TDateTime): String;
begin
  Result := '';
  case AStatusPitStopCotacao of
    spscSemApi: Result := 'Sem acesso';
    spscComApi,
    spscPendenteConsultaPreco: Result := 'Integração não foi iniciada';
    spscIntegrandoConsultaPreco: Result := 'Busca de preços iniciada em ' + FormatDateTime('dd/mm/yyyy hh:nn:ss', DataHoraInicio);
    spscPendenteImportarConsultaPreco: Result := 'Pendente carregar preços da cotação';
    spscPendenteRecotarPreco: Result := 'Importação da 1ª. cotação concluída';
    spscIntegrandoRecotarPreco: Result := 'Busca de preços iniciada em ' + FormatDateTime('dd/mm/yyyy hh:nn:ss', DataHoraInicio);
    spscPendenteImportarRecotarPreco: Result := 'Pendente carregar preços da cotação';
    spscConcluido: Result := 'Importação da 2ª. cotação concluída';
  End;
end;


class function TStatusBuscaCotacaoPitStop.fConsultaPitStopToInt(AStatusConsultaPitStop: TStatusConsultaPitStop): Integer;
begin
  Result := 0;
  case AStatusConsultaPitStop of
    scpsPendente: Result := 0;
    scpsProcessando: Result := 1;
    scpsConcluidoPrimeiraEtapa: Result := 2;
    scpsPendenteSegundaEtapa: Result := 3;
    scpsProcessandoSegundaEtapa: Result := 4;
    scpsConcluido: Result := 5;
    scpsCancelado: Result := -1;
   end;
end;

class function TStatusBuscaCotacaoPitStop.fIntToStatusConsultaPitStop(
  AStatus: Integer): TStatusConsultaPitStop;
begin
  Result := scpsPendente;
  case AStatus of
    0: Result := scpsPendente;
    1: Result := scpsProcessando;
    2: Result := scpsConcluidoPrimeiraEtapa;
    3: Result := scpsPendenteSegundaEtapa;
    4: Result := scpsProcessandoSegundaEtapa;
    5: Result := scpsConcluido;
    -1: Result := scpsCancelado;
  end;
end;

{ TParamCancelaCotacao }

function TParamCancelaCotacao.fProcessaRetono: String;
begin
  {}
end;

function TParamCancelaCotacao.getJsonEnvion: String;
begin
  Result := '{"cancelar":{"idCotacao": "'+idCotacao+'"}}';
end;

end.
