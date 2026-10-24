unit untExportaTintometricosTerceirosDuxone2;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  untFuncoesSimples, Windows, Messages,
  cxProgressBar, UniClientDataSet,
  FireDAC.VCLUI.Wait,
{$ENDIF}
  Uni, SysUtils, Variants, Classes, Math, strUtils,
  untExportaTintometricosTerceirosAutomotiva, DB,
  untThreadExportacaoTerceiros, DateUtils,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.UI;

Type
  TExportaTintometricosTerceirosDuxone2 = Class(TExportaTintometricosTerceirosAutomotiva)
  Private
    ArrComponentes: Array of TComp; //TArrComponentes;
    strProDU2: String; //Produto de venda Duxone2
    stlDiluentes: TStringList;
    strAcrMob: String;
    intDecFor: Integer;
    function fRetValorAcrMobCfgTin(): String;
    function fValorQuantidade(fltValor: Double; fltAcrMob: Double): Double;
    function fCalculaVolumeTotal(qryGen, QryBases: TUniQuery; dicRetorno: TDicionario): Double;
    procedure DiluenteUltimaPosicao(qryBases: TUniQuery; dicRetorno: TDicionario; fltQtdDiluido: Double; fltTotalGramas: Double;
      fltVolumeDiluido: Double; strPercentual: String);
    function fCalculaPrecoVendaConcentrado(qryBases: TUniQuery; strTabelaUnica: String): Double;
    function fCalculaPrecoCustoConcentrado(qryBases: TUniQuery; strTabelaUnica: String): Double;
    function fCalculaPrecoVendaConcentrado1a7(qryBases: TUniQuery; strTabelaUnica: String; intPreVen: Integer): Double;
    function fCalculaPrecoVendaDiluido(qryBases: TUniQuery; strTabelaUnica: String): Double;
    function fCalculaPrecoCustoDiluido(qryBases: TUniQuery; strTabelaUnica: String): Double;
    function fCalculaPrecoVendaDiluido1a7(qryBases: TUniQuery; strTabelaUnica: String; intPreVen: Integer): Double;
    function fCalculaPrecoEmbalagem(fltPerAcr: Double; strTabelaUnica: String; strEmbalagem: String): Double;
    function fCalculaPrecoCustoEmbalagem(fltPerAcr: Double; strTabelaUnica: String; strEmbalagem: String): Double;
    function fCalculaPrecoEmbalagem1a7(fltPerAcr: Double; strTabelaUnica: String; strEmbalagem: String; intPreVen: Integer): Double;
    function fRetornaPrecoConcentrado(fltPrecoTotal: Double; fltPerAcr: Double; fltEmbalagem: Double): Double;
    function fRetornaPrecoDiluido(fltPrecoTotal: Double; fltPerAcr: Double; fltEmbalagem: Double): Double;
    function fRetornaPrecoCustoConcentrado(fltPrecoTotal: Double; fltEmbalagem: Double): Double;
    function fRetornaPrecoCustoDiluido(fltPrecoTotal: Double; fltEmbalagem: Double): Double;
  Protected
    procedure pProcessaTabelaCores(qryInsert: TFDQuery; qryGen, qryBases, qryColorantes: TUniQuery;
       strTabUni, strTabPre: String; fltPerAcr: Double; dicRetorno: TDicionario); Override;

    procedure pCriaTabelaExportacao; Override;

  {$IFDEF LINUX}
    procedure pValidarPrecoExportacaoDuxone2(AMd5Key, AEmbPro, AModVen, ASigEmb: string; fltPreVen: Double; dicPrecos: TDicionario; APrefix: String; ADiluente: String);
  {$ENDIF}
  Public
    function fNomeTabela(): String; Override;
    function fQuantidadeFormulacao(): Integer; Override;
    function fCamposTabela(): String; Override;
    function fCamposSelect(): String; Override;
    function fFatorTinta(): Double; Override;
    function fRetDescricao(): String; Override;
    function fRetItemBase(): String; Override;
    function fRetMD5KEY(): String; Override;
    function fRetFormula(intCont: Integer): String; Override;
    function fRetQuantidade(intCont: Integer): String; Override;
    function fSQLInsert(): String; Override;
    function fRetornaColorantes(): String; Override;
    function fRetornaBases(): String; Override;
    function fRetornaPercentualAcrescimo(Conexao: TUniConnection): Double; Override;
    function fRetEmbalagem(qryColorantes: TUniQuery): Double; Override;
    function fRetCODEMP: String; Override;
    function fRetTipoCor(): String; Override;
    function fRetornaCodigoDiluente(dicRetorno: TDicionario): String; Override;
    function fRetornaPorcentagemDiluente(dicRetorno: TDicionario): Double; Override;
    function fRetornaCampoEmbalagem(strSigEmb: String; dicRetorno: TDicionario): String; Override;
    function RepetirPorTipo(): Integer; Override;

    procedure pAdicionaParamentros(Var DataSet: TFDQuery; qryTinta: TUniQuery;
      fltPreVen: Double; intParam: Integer = 0); Override;
    procedure pSetaParametrosEspecificos(Conexao: TUniConnection); Override;
    procedure pIncluirLogTinSite(Conexao: TUniConnection; strStatus: String); Override;
    procedure pRecalculaFormula(dicRetorno: TDicionario; qryGen: TUniQuery; qryBases: TUniQuery); Override;
    procedure pRetPrecoTintas(dicRetorno: TDicionario; qryColorantes,
      qryBases: TUniQuery; fltPerAcr: Double); override;
    procedure pRetPrecosAdicionais(dicRetorno: TDicionario; qryColorantes,
      qryBases: TUniQuery; fltPerAcr: Double); Override;
    procedure pGravaTintometricoPorTintaTerceiros(qryInsert: TFDQuery;
      fltPreVen: Double; qryTinta: TUniQuery; intParam: Integer = 0); override;


    //Embalagens
    function fRetEmbalagemLT(): String;
    function fRetEmbalagemGL(): String;
    function fRetEmbalagemLA(): String;
    function fRetEmbalagemTB(): String;
    function fRetEmbalagemBD(): String;
    function fRetEmbalagemCP(): String;
    function fRetEmbalagemSS(): String;
    function fRetEmbalagemSP(): String;
    function fRetEmbalagemSD(): String;
    function fRetItemVenda(Conexao: TUniConnection): String;
    function fRetQtdDiluente(strPercentual: String; fltPesoEspecifico: Double): Double;

    procedure pCriaClientEmbalagem(Conexao: TUniConnection);
    procedure pPreencheEmbalagens;
    procedure pPreencheArrayEmbalagem;
    procedure pCarregarDados;
    procedure pRetTabelasPreco(Conexao: TUniConnection);
    procedure Execute; override;

    constructor Create(pgbProgresso: TcxProgressBar; strIdePro: String; blnAuto: Boolean = False); Override;
    destructor Destroy; Override;
  End;


implementation

{ TExportaTintometricosTerceirosDuxone2 }

constructor TExportaTintometricosTerceirosDuxone2.Create(
  pgbProgresso: TcxProgressBar; strIdePro: String; blnAuto: Boolean);
begin
  inherited;
  strProDU2 := '';
  pPreencheEmbalagens;
  pCarregarDados;
  dicPrecoAdicional := TDicionario.Create();
  stlTabPre := TStringList.Create();
  strAcrMob := fRetValorAcrMobCfgTin();
end;

destructor TExportaTintometricosTerceirosDuxone2.Destroy;
begin
  inherited;

  If Assigned(stlDiluentes) Then
    FreeAndNil(stlDiluentes);

  If Assigned(dicPrecoAdicional) Then
    FreeAndNil(dicPrecoAdicional);

  If Assigned(stlTabPre) Then
    FreeAndNil(stlTabPre);
end;

procedure TExportaTintometricosTerceirosDuxone2.DiluenteUltimaPosicao(qryBases: TUniQuery; dicRetorno: TDicionario; fltQtdDiluido: Double; fltTotalGramas: Double;
      fltVolumeDiluido: Double; strPercentual: String);
Var
  intContador: Integer;
begin
  //Adicionando o diluente na ultima posicao
  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intContador, 2)], ''))) Then
    Begin

      If (Not qryBases.Locate('BAS_CODBAS', stlDiluentes[intTipo], [])) Then
        Break;

      dicRetorno['base' + fStrZero(intContador, 2)] := stlDiluentes[intTipo];
      dicRetorno['qtdb' + fStrZero(intContador, 2)] := 0;
      dicRetorno['qtdd' + fStrZero(intContador, 2)] := fFormataFloat((fltQtdDiluido * fltTotalGramas) / fltVolumeDiluido, intDecFor);
      dicRetorno['coddil'] := stlDiluentes[intTipo];
      dicRetorno['pordil'] := strPercentual;
      Break;
    End;
  End;
end;

procedure TExportaTintometricosTerceirosDuxone2.Execute;
begin
  inherited;
end;

function TExportaTintometricosTerceirosDuxone2.fCalculaPrecoCustoConcentrado(
  qryBases: TUniQuery; strTabelaUnica: String): Double;
Var
  intContador: Integer;
  strCodCli,
  strCodCnd: String;
  intPrzMed: Integer;
  fltPreCusPro,
  fltPreVenPro,
  fltEmbala,
  fltPrecoCustoCon,
  fltPrecoCustoTotalCon,
  fltQuantCon,
  fltPrecoBase: Double;
begin
  strCodCli := '';
  strCodCnd := '';
  fltPreCusPro := 0;
  fltPreVenPro := 0;
  intPrzMed := 0;
  fltPrecoBase := 0;
  fltPrecoCustoTotalCon := 0;

  //Calcula o preco de venda
  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    If fEmptyStr(ArrComponentes[intContador].Componente) Then
      Break;

    If qryBases.Locate('BAS_CODBAS', ArrComponentes[intContador].Componente,[]) Then
    Begin
      If fCarregaPromocao(qryBases.FieldByName('BAS_CODITE').AsString,
        strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
        fltPrecoBase := fltPreCusPro
      Else
        fltPrecoBase := qryBases.FieldByName('PRECUS').AsFloat;
    End;

    fltEmbala := fRetEmbalagem(qryBases);

    //Preco de venda concentrado
    fltQuantCon := ArrComponentes[intContador].Quantidade;
    fltPrecoCustoCon := fltQuantCon * (fltPrecoBase / fltEmbala);
    fltPrecoCustoTotalCon := fltPrecoCustoTotalCon + fltPrecoCustoCon;
  End;

  Result := fltPrecoCustoTotalCon;
end;

function TExportaTintometricosTerceirosDuxone2.fCalculaPrecoCustoDiluido(
  qryBases: TUniQuery; strTabelaUnica: String): Double;
Var
  intContador: Integer;
  strCodCli,
  strCodCnd: String;
  intPrzMed: Integer;
  fltPreCusPro,
  fltPreVenPro,
  fltEmbala,
  fltPrecoCustoDil,
  fltPrecoCustoTotalDil,
  fltQuantDil,
  fltPrecoBase: Double;
begin
  strCodCli := '';
  strCodCnd := '';
  fltPreCusPro := 0;
  fltPreVenPro := 0;
  intPrzMed := 0;
  fltPrecoBase := 0;
  fltPrecoCustoTotalDil := 0;

  //Calcula o preco de venda
  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    If fEmptyStr(ArrComponentes[intContador].Componente) Then
      Break;

    If qryBases.Locate('BAS_CODBAS', ArrComponentes[intContador].Componente,[]) Then
    Begin
      If fCarregaPromocao(qryBases.FieldByName('BAS_CODITE').AsString,
        strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
        fltPrecoBase := fltPreCusPro
      Else
        fltPrecoBase := qryBases.FieldByName('PRECUS').AsFloat;
    End;

    fltEmbala := fRetEmbalagem(qryBases);

    //Preco de venda Diluido
    fltQuantDil := ArrComponentes[intContador].Quantiddil;
    fltPrecoCustoDil := fltQuantDil * (fltPrecoBase / fltEmbala);
    fltPrecoCustoTotalDil := fltPrecoCustoTotalDil + fltPrecoCustoDil;
  End;

  Result := fltPrecoCustoTotalDil;
end;

function TExportaTintometricosTerceirosDuxone2.fCalculaPrecoCustoEmbalagem(
  fltPerAcr: Double; strTabelaUnica, strEmbalagem: String): Double;
Var
  strCodCli,
  strCodCnd: String;
  intPrzMed: Integer;
  fltPreCusPro,
  fltPreVenPro,
  fltPrecoEmbalagem: Double;
begin
  strCodCli := '';
  strCodCnd := '';
  fltPreCusPro := 0;
  fltPreVenPro := 0;
  intPrzMed := 0;
  fltPrecoEmbalagem := 0;

  //Retorna preco da embalagem
  If cdsEmbalagens.Locate('CFG_CODCFG', strEmbalagem, []) Then
  Begin
    If fCarregaPromocao(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString,
      strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
      fltPrecoEmbalagem := fltPreCusPro + (fltPerAcr * fltPreVenPro)
    Else
      fltPrecoEmbalagem := fSelecionaPrecoCustoEmbalagem(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString, fltPerAcr);
  End;

  Result := fltPrecoEmbalagem;
end;

function TExportaTintometricosTerceirosDuxone2.fCalculaPrecoEmbalagem(
  fltPerAcr: Double; strTabelaUnica, strEmbalagem: String): Double;
Var
  strCodCli,
  strCodCnd: String;
  intPrzMed: Integer;
  fltPreCusPro,
  fltPreVenPro,
  fltPrecoEmbalagem: Double;
begin
  strCodCli := '';
  strCodCnd := '';
  fltPreCusPro := 0;
  fltPreVenPro := 0;
  intPrzMed := 0;
  fltPrecoEmbalagem := 0;

  //Retorna preco da embalagem
  If cdsEmbalagens.Locate('CFG_CODCFG', strEmbalagem, []) Then
  Begin
    If fCarregaPromocao(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString,
      strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
      fltPrecoEmbalagem := fltPreVenPro + (fltPerAcr * fltPreVenPro)
    Else
      fltPrecoEmbalagem := fRetornaPrecoVendaEmbalagem(
        cdsEmbalagens.FieldByName('CFG_VALCFG').AsString, fltPerAcr);
  End;

  Result := fltPrecoEmbalagem;
end;

function TExportaTintometricosTerceirosDuxone2.fCalculaPrecoEmbalagem1a7(
  fltPerAcr: Double; strTabelaUnica, strEmbalagem: String;
  intPreVen: Integer): Double;
Var
  strCodCli,
  strCodCnd: String;
  intPrzMed: Integer;
  fltPreCusPro,
  fltPreVenPro,
  fltPrecoEmbalagem: Double;
begin
  strCodCli := '';
  strCodCnd := '';
  fltPreCusPro := 0;
  fltPreVenPro := 0;
  intPrzMed := 0;
  fltPrecoEmbalagem := 0;

  //Retorna preco da embalagem
  If cdsEmbalagens.Locate('CFG_CODCFG', strEmbalagem, []) Then
  Begin
    If fCarregaPromocao(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString,
      IntToStr(intPreVen), strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
      fltPrecoEmbalagem := fltPreVenPro + (fltPerAcr * fltPreVenPro)
    Else
      fltPrecoEmbalagem := fSelecionaPrecoVendaEmbalagemTabClientes(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString, fltPerAcr, intPreVen);
  End;

  Result := fltPrecoEmbalagem;
end;

function TExportaTintometricosTerceirosDuxone2.fCalculaPrecoVendaConcentrado(qryBases: TUniQuery; strTabelaUnica: String): Double;
Var
  intContador: Integer;
  strCodCli,
  strCodCnd: String;
  intPrzMed: Integer;
  fltPreCusPro,
  fltPreVenPro,
  fltEmbala,
  fltPrecoVendaCon,
  fltPrecoVendaTotalCon,
  fltQuantCon,
  fltPrecoBase: Double;
begin
  strCodCli := '';
  strCodCnd := '';
  fltPreCusPro := 0;
  fltPreVenPro := 0;
  intPrzMed := 0;
  fltPrecoBase := 0;
  fltPrecoVendaTotalCon := 0;

  //Calcula o preco de venda
  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    If fEmptyStr(ArrComponentes[intContador].Componente) Then
      Break;

    If qryBases.Locate('BAS_CODBAS', ArrComponentes[intContador].Componente,[]) Then
    Begin
      If fCarregaPromocao(qryBases.FieldByName('BAS_CODITE').AsString,
        strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
        fltPrecoBase := fltPreVenPro
      Else
        fltPrecoBase := qryBases.FieldByName('ITE_PREVEN').AsFloat;
    End;

    fltEmbala := fRetEmbalagem(qryBases);

    //Preco de venda concentrado
    fltQuantCon := ArrComponentes[intContador].Quantidade;
    fltPrecoVendaCon := fltQuantCon * (fltPrecoBase / fltEmbala);
    fltPrecoVendaTotalCon := fltPrecoVendaTotalCon + fltPrecoVendaCon;
  End;

  Result := fltPrecoVendaTotalCon;
end;

function TExportaTintometricosTerceirosDuxone2.fCalculaPrecoVendaConcentrado1a7(
  qryBases: TUniQuery; strTabelaUnica: String; intPreVen: Integer): Double;
Var
  intContador: Integer;
  strCodCli,
  strCodCnd: String;
  intPrzMed: Integer;
  fltPreCusPro,
  fltPreVenPro,
  fltEmbala,
  fltPrecoVendaCon,
  fltPrecoVendaTotalCon,
  fltQuantCon,
  fltPrecoBase: Double;
begin
  strCodCli := '';
  strCodCnd := '';
  fltPreCusPro := 0;
  fltPreVenPro := 0;
  intPrzMed := 0;
  fltPrecoBase := 0;
  fltPrecoVendaTotalCon := 0;

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    If fEmptyStr(ArrComponentes[intContador].Componente) Then
      Break;

    If qryBases.Locate('BAS_CODBAS', ArrComponentes[intContador].Componente,[]) Then
    Begin
      If fCarregaPromocao(qryBases.FieldByName('BAS_CODITE').AsString,
        IntToStr(intPreVen), strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
        fltPrecoBase := fltPreVenPro
      Else
        fltPrecoBase := qryBases.FieldByName('PREVE' + IntToStr(intPreVen)).AsFloat;
    End;

    fltEmbala := fRetEmbalagem(qryBases);

    //Preco de venda concentrado
    fltQuantCon := ArrComponentes[intContador].Quantidade;
    fltPrecoVendaCon := fltQuantCon * (fltPrecoBase / fltEmbala);
    fltPrecoVendaTotalCon := fltPrecoVendaTotalCon + fltPrecoVendaCon;
  End;

  Result := fltPrecoVendaTotalCon;
end;

function TExportaTintometricosTerceirosDuxone2.fCalculaPrecoVendaDiluido(
  qryBases: TUniQuery; strTabelaUnica: String): Double;
Var
  intContador: Integer;
  strCodCli,
  strCodCnd: String;
  intPrzMed: Integer;
  fltPreCusPro,
  fltPreVenPro,
  fltEmbala,
  fltPrecoVendaDil,
  fltPrecoVendaTotalDil,
  fltQuantDil,
  fltPrecoBase: Double;
begin
  strCodCli := '';
  strCodCnd := '';
  fltPreCusPro := 0;
  fltPreVenPro := 0;
  intPrzMed := 0;
  fltPrecoBase := 0;
  fltPrecoVendaTotalDil := 0;

  //Calcula o preco de venda
  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    If fEmptyStr(ArrComponentes[intContador].Componente) Then
      Break;

    If qryBases.Locate('BAS_CODBAS', ArrComponentes[intContador].Componente,[]) Then
    Begin
      If fCarregaPromocao(qryBases.FieldByName('BAS_CODITE').AsString,
        strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
        fltPrecoBase := fltPreVenPro
      Else
        fltPrecoBase := qryBases.FieldByName('ITE_PREVEN').AsFloat;
    End;

    fltEmbala := fRetEmbalagem(qryBases);

    //Preco de venda Diluido
    fltQuantDil := ArrComponentes[intContador].Quantiddil;
    fltPrecoVendaDil := fltQuantDil * (fltPrecoBase / fltEmbala);
    fltPrecoVendaTotalDil := fltPrecoVendaTotalDil + fltPrecoVendaDil;
  End;

  Result := fltPrecoVendaTotalDil;
end;

function TExportaTintometricosTerceirosDuxone2.fCalculaPrecoVendaDiluido1a7(
  qryBases: TUniQuery; strTabelaUnica: String; intPreVen: Integer): Double;
Var
  intContador: Integer;
  strCodCli,
  strCodCnd: String;
  intPrzMed: Integer;
  fltPreCusPro,
  fltPreVenPro,
  fltEmbala,
  fltPrecoVendaDil,
  fltPrecoVendaTotalDil,
  fltQuantDil,
  fltPrecoBase: Double;
begin
  strCodCli := '';
  strCodCnd := '';
  fltPreCusPro := 0;
  fltPreVenPro := 0;
  intPrzMed := 0;
  fltPrecoBase := 0;
  fltPrecoVendaTotalDil := 0;

  //Calcula o preco de venda
  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    If fEmptyStr(ArrComponentes[intContador].Componente) Then
      Break;

    If qryBases.Locate('BAS_CODBAS', ArrComponentes[intContador].Componente,[]) Then
    Begin
      If fCarregaPromocao(qryBases.FieldByName('BAS_CODITE').AsString,
        IntToStr(intPreVen), strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
        fltPrecoBase := fltPreVenPro
      Else
        fltPrecoBase := qryBases.FieldByName('PREVE' + IntToStr(intPreVen)).AsFloat;
    End;

    fltEmbala := fRetEmbalagem(qryBases);

    //Preco de venda Diluido
    fltQuantDil := ArrComponentes[intContador].Quantiddil;
    fltPrecoVendaDil := fltQuantDil * (fltPrecoBase / fltEmbala);
    fltPrecoVendaTotalDil := fltPrecoVendaTotalDil + fltPrecoVendaDil;
  End;

  Result := fltPrecoVendaTotalDil;
end;

function TExportaTintometricosTerceirosDuxone2.fCalculaVolumeTotal(qryGen,
  QryBases: TUniQuery; dicRetorno: TDicionario): Double;
Var
  intContador: Integer;
  fltVolumeAtual: Double;
begin
  fltVolumeAtual := 0;

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin

    If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intContador, 2)], ''))) Then
      Break;

    If (Not qryBases.Locate('BAS_CODBAS', dicRetorno['base' + fStrZero(intContador, 2)], [])) Then
      Break;

    fltVolumeAtual := fltVolumeAtual + (qryGen.FieldByName('DU2_QTDC' + fStrZero(intContador, 2)).AsFloat);
  End;

  Result := fltVolumeAtual;
end;

function TExportaTintometricosTerceirosDuxone2.fCamposSelect: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                ';
  Result := Result + '    DU2_CODDU2,         ';
  Result := Result + '    DU2_CODOEM,         ';
  Result := Result + '    DU2_LINHA_,         ';
  Result := Result + '    DU2_QUALID,         ';
  Result := Result + '    DU2_ALTERN,         ';
  Result := Result + '    DU2_REGIAO,         ';
  Result := Result + '    DU2_DESCRI,         ';
  Result := Result + '    DU2_MONTAD,         ';
  Result := Result + '    DU2_ANOCOR,         ';
  Result := Result + '    DU2_LITRAG,         ';
  Result := Result + '    DU2_DTACAD,         ';
  Result := Result + '    DU2_CODSEQ,         ';
  Result := Result + '    DU2_CODNFM,         ';
  Result := Result + '    DU2_ACRMOB,         ';
  Result := Result + '    DU2_OBSERV,         ';

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    Result := Result + '    DU2_BASE' + fStrZero(intContador, 2) + ',       ';
    Result := Result + '    DU2_QTDC' + fStrZero(intContador, 2) + ',       ';
    Result := Result + '    DU2_TIPB' + fStrZero(intContador, 2) + ',       ';
  End;

  Result := Result + '    DU2_MD5KEY          ';
  Result := Result + '  FROM                  ';
  Result := Result + '    DU2_CADDU2          ';
  Result := Result + '  WHERE                 ';
  Result := Result + '    TRUE                ';
end;

function TExportaTintometricosTerceirosDuxone2.fCamposTabela: String;
begin
  Result := '';
  Result := Result + '  CREATE TABLE  '  + fNomeTabela() + '  (         ';
  Result := Result + '    DU2_CODDU2 VARCHAR(15),           ';
  Result := Result + '    DU2_CODOEM VARCHAR(40),           ';
  Result := Result + '    DU2_LINHA_ VARCHAR(20),           ';
  Result := Result + '    DU2_QUALID VARCHAR(20),           ';
  Result := Result + '    DU2_ALTERN CHAR(3),               ';
  Result := Result + '    DU2_REGIAO CHAR(2),               ';
  Result := Result + '    DU2_DESCRI VARCHAR(40),           ';
  Result := Result + '    DU2_MONTAD VARCHAR(25),           ';
  Result := Result + '    DU2_OBSERV VARCHAR(255),          ';
  Result := Result + '    DU2_MD5KEY VARCHAR(32),           ';

  Result := Result + '    DU2_CODITE VARCHAR(' + fTamCodIte.ToString() + '),            ';
  Result := Result + '    DU2_CODDIL VARCHAR(20),           ';
  Result := Result + '    DU2_PORDIL DECIMAL(12,4),         ';

  Result := Result + '    DU2_PRECLT DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRECGL DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRECLA DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRECTB DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRECBD DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRECCP DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRECSS DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRECSP DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRECSD DECIMAL(12,4),         ';

  Result := Result + '    DU2_PREDLT DECIMAL(12,4),         ';
  Result := Result + '    DU2_PREDGL DECIMAL(12,4),         ';
  Result := Result + '    DU2_PREDLA DECIMAL(12,4),         ';
  Result := Result + '    DU2_PREDTB DECIMAL(12,4),         ';
  Result := Result + '    DU2_PREDBD DECIMAL(12,4),         ';
  Result := Result + '    DU2_PREDCP DECIMAL(12,4),         ';
  Result := Result + '    DU2_PREDSS DECIMAL(12,4),         ';
  Result := Result + '    DU2_PREDSP DECIMAL(12,4),         ';
  Result := Result + '    DU2_PREDSD DECIMAL(12,4),         ';

  Result := Result + '    DU2_PCUCLT DECIMAL(12,4),         '; //Preço de Custo Concentrado
  Result := Result + '    DU2_PCUCGL DECIMAL(12,4),         '; //Preço de Custo Concentrado
  Result := Result + '    DU2_PCUCLA DECIMAL(12,4),         '; //Preço de Custo Concentrado
  Result := Result + '    DU2_PCUCTB DECIMAL(12,4),         '; //Preço de Custo Concentrado
  Result := Result + '    DU2_PCUCBD DECIMAL(12,4),         '; //Preço de Custo Concentrado
  Result := Result + '    DU2_PCUCCP DECIMAL(12,4),         '; //Preço de Custo Concentrado
  Result := Result + '    DU2_PCUCSS DECIMAL(12,4),         '; //Preço de Custo Concentrado
  Result := Result + '    DU2_PCUCSP DECIMAL(12,4),         '; //Preço de Custo Concentrado
  Result := Result + '    DU2_PCUCSD DECIMAL(12,4),         '; //Preço de Custo Concentrado

  Result := Result + '    DU2_PCUDLT DECIMAL(12,4),         '; //Preço de Custo Diluido
  Result := Result + '    DU2_PCUDGL DECIMAL(12,4),         '; //Preço de Custo Diluido
  Result := Result + '    DU2_PCUDLA DECIMAL(12,4),         '; //Preço de Custo Diluido
  Result := Result + '    DU2_PCUDTB DECIMAL(12,4),         '; //Preço de Custo Diluido
  Result := Result + '    DU2_PCUDBD DECIMAL(12,4),         '; //Preço de Custo Diluido
  Result := Result + '    DU2_PCUDCP DECIMAL(12,4),         '; //Preço de Custo Diluido
  Result := Result + '    DU2_PCUDSS DECIMAL(12,4),         '; //Preço de Custo Diluido
  Result := Result + '    DU2_PCUDSP DECIMAL(12,4),         '; //Preço de Custo Diluido
  Result := Result + '    DU2_PCUDSD DECIMAL(12,4),         '; //Preço de Custo Diluido

  {* PREÇO DE VENDA 1 A 7 - TABELA DE CLIENTES *}

  Result := Result + '    DU2_PRCLT1 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCLT2 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCLT3 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCLT4 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCLT5 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCLT6 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCLT7 DECIMAL(12,4),         ';

  Result := Result + '    DU2_PRDLT1 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDLT2 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDLT3 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDLT4 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDLT5 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDLT6 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDLT7 DECIMAL(12,4),         ';

  Result := Result + '    DU2_PRCGL1 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCGL2 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCGL3 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCGL4 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCGL5 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCGL6 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCGL7 DECIMAL(12,4),         ';

  Result := Result + '    DU2_PRDGL1 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDGL2 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDGL3 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDGL4 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDGL5 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDGL6 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDGL7 DECIMAL(12,4),         ';

  Result := Result + '    DU2_PRCLA1 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCLA2 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCLA3 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCLA4 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCLA5 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCLA6 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCLA7 DECIMAL(12,4),         ';

  Result := Result + '    DU2_PRDLA1 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDLA2 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDLA3 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDLA4 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDLA5 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDLA6 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDLA7 DECIMAL(12,4),         ';

  Result := Result + '    DU2_PRCTB1 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCTB2 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCTB3 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCTB4 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCTB5 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCTB6 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCTB7 DECIMAL(12,4),         ';

  Result := Result + '    DU2_PRDTB1 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDTB2 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDTB3 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDTB4 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDTB5 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDTB6 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDTB7 DECIMAL(12,4),         ';

  Result := Result + '    DU2_PRCBD1 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCBD2 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCBD3 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCBD4 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCBD5 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCBD6 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCBD7 DECIMAL(12,4),         ';

  Result := Result + '    DU2_PRDBD1 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDBD2 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDBD3 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDBD4 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDBD5 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDBD6 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDBD7 DECIMAL(12,4),         ';

  Result := Result + '    DU2_PRCCP1 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCCP2 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCCP3 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCCP4 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCCP5 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCCP6 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCCP7 DECIMAL(12,4),         ';

  Result := Result + '    DU2_PRDCP1 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDCP2 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDCP3 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDCP4 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDCP5 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDCP6 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDCP7 DECIMAL(12,4),         ';

  Result := Result + '    DU2_PRCSS1 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCSS2 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCSS3 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCSS4 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCSS5 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCSS6 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCSS7 DECIMAL(12,4),         ';

  Result := Result + '    DU2_PRDSS1 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDSS2 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDSS3 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDSS4 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDSS5 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDSS6 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDSS7 DECIMAL(12,4),         ';

  Result := Result + '    DU2_PRCSP1 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCSP2 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCSP3 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCSP4 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCSP5 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCSP6 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCSP7 DECIMAL(12,4),         ';

  Result := Result + '    DU2_PRDSP1 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDSP2 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDSP3 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDSP4 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDSP5 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDSP6 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDSP7 DECIMAL(12,4),         ';

  Result := Result + '    DU2_PRCSD1 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCSD2 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCSD3 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCSD4 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCSD5 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCSD6 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRCSD7 DECIMAL(12,4),         ';

  Result := Result + '    DU2_PRDSD1 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDSD2 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDSD3 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDSD4 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDSD5 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDSD6 DECIMAL(12,4),         ';
  Result := Result + '    DU2_PRDSD7 DECIMAL(12,4),         ';


  Result := Result + '    DU2_EMBALT VARCHAR(' + fTamCodIte.ToString() + '),            ';
  Result := Result + '    DU2_EMBAGL VARCHAR(' + fTamCodIte.ToString() + '),            ';
  Result := Result + '    DU2_EMBALA VARCHAR(' + fTamCodIte.ToString() + '),            ';
  Result := Result + '    DU2_EMBATB VARCHAR(' + fTamCodIte.ToString() + '),            ';
  Result := Result + '    DU2_EMBABD VARCHAR(' + fTamCodIte.ToString() + '),            ';
  Result := Result + '    DU2_EMBACP VARCHAR(' + fTamCodIte.ToString() + '),            ';
  Result := Result + '    DU2_EMBASS VARCHAR(' + fTamCodIte.ToString() + '),            ';
  Result := Result + '    DU2_EMBASP VARCHAR(' + fTamCodIte.ToString() + '),            ';
  Result := Result + '    DU2_EMBASD VARCHAR(' + fTamCodIte.ToString() + '),            ';


  Result := Result + '    DU2_VOLULT DECIMAL(12,4),         ';
  Result := Result + '    DU2_VOLUGL DECIMAL(12,4),         ';
  Result := Result + '    DU2_VOLULA DECIMAL(12,4),         ';
  Result := Result + '    DU2_VOLUTB DECIMAL(12,4),         ';
  Result := Result + '    DU2_VOLUBD DECIMAL(12,4),         ';
  Result := Result + '    DU2_VOLUCP DECIMAL(12,4),         ';
  Result := Result + '    DU2_VOLUSS DECIMAL(12,4),         ';
  Result := Result + '    DU2_VOLUSP DECIMAL(12,4),         ';
  Result := Result + '    DU2_VOLUSD DECIMAL(12,4),         ';

  Result := Result + '    DU2_PREELT DECIMAL(12,4),         ';
  Result := Result + '    DU2_PREEGL DECIMAL(12,4),         ';
  Result := Result + '    DU2_PREELA DECIMAL(12,4),         ';
  Result := Result + '    DU2_PREETB DECIMAL(12,4),         ';
  Result := Result + '    DU2_PREEBD DECIMAL(12,4),         ';
  Result := Result + '    DU2_PREECP DECIMAL(12,4),         ';
  Result := Result + '    DU2_PREESS DECIMAL(12,4),         ';
  Result := Result + '    DU2_PREESP DECIMAL(12,4),         ';
  Result := Result + '    DU2_PREESD DECIMAL(12,4),         ';

  Result := Result + '    DU2_TIPOLT CHAR(2),               ';
  Result := Result + '    DU2_TIPOGL CHAR(2),               ';
  Result := Result + '    DU2_TIPOLA CHAR(2),               ';
  Result := Result + '    DU2_TIPOTB CHAR(2),               ';
  Result := Result + '    DU2_TIPOBD CHAR(2),               ';
  Result := Result + '    DU2_TIPOCP CHAR(2),               ';
  Result := Result + '    DU2_TIPOSS CHAR(2),               ';
  Result := Result + '    DU2_TIPOSP CHAR(2),               ';
  Result := Result + '    DU2_TIPOSD CHAR(2)                ';
  Result := Result + '                );                    ';
end;

function TExportaTintometricosTerceirosDuxone2.fFatorTinta: Double;
begin
  Result := 0;
end;

function TExportaTintometricosTerceirosDuxone2.fNomeTabela: String;
begin
  Result := 'DU2_CADDU2_SIT';
end;

function TExportaTintometricosTerceirosDuxone2.fQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TExportaTintometricosTerceirosDuxone2.fRetCODEMP: String;
begin
  Result := 'DU2_CODDIL';
end;

function TExportaTintometricosTerceirosDuxone2.fRetDescricao: String;
begin
  Result := 'DU2_DESCRI';
end;

function TExportaTintometricosTerceirosDuxone2.fRetEmbalagem(
  qryColorantes: TUniQuery): Double;
begin
  If qryColorantes.FieldByName('BAS_PESGRA').AsString = 'S' Then
    Result := qryColorantes.FieldByName('BAS_EMBALA').AsFloat
  Else
    Result := qryColorantes.FieldByName('BAS_EMBALA').AsFloat * qryColorantes.FieldByName('BAS_PESESP').AsFloat;
end;

function TExportaTintometricosTerceirosDuxone2.fRetEmbalagemBD: String;
begin
  Result := 'ITEBAL';
end;

function TExportaTintometricosTerceirosDuxone2.fRetEmbalagemCP: String;
begin
  Result := 'ITECOP';
end;

function TExportaTintometricosTerceirosDuxone2.fRetEmbalagemGL: String;
begin
  Result := 'ITEGAL';
end;

function TExportaTintometricosTerceirosDuxone2.fRetEmbalagemLA: String;
begin
  Result := 'ITELAT';
end;

function TExportaTintometricosTerceirosDuxone2.fRetEmbalagemLT: String;
begin
  Result := 'ITE1_4';
end;

function TExportaTintometricosTerceirosDuxone2.fRetEmbalagemSD: String;
begin
  Result := 'ITESDU';
end;

function TExportaTintometricosTerceirosDuxone2.fRetEmbalagemSP: String;
begin
  Result := 'ITESPO';
end;

function TExportaTintometricosTerceirosDuxone2.fRetEmbalagemSS: String;
begin
  Result := 'ITESPS';
end;

function TExportaTintometricosTerceirosDuxone2.fRetEmbalagemTB: String;
begin
  Result := 'ITETAM';
end;

function TExportaTintometricosTerceirosDuxone2.fRetFormula(
  intCont: Integer): String;
begin
  Result := 'DU2_BASE' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosDuxone2.fRetItemBase: String;
begin
  Result := '';
end;

function TExportaTintometricosTerceirosDuxone2.fRetItemVenda(
  Conexao: TUniConnection): String;
Var
  qryGen: TUniQuery;
  strSQL: String;
begin
  Try
    strSQL := '';
    strSQL := strSQL + '  SELECT                ';
    strSQL := strSQL + '    CFG_VALCFG          ';
    strSQL := strSQL + '  FROM                  ';
    strSQL := strSQL + '    CFGTIN              ';
    strSQL := strSQL + '  WHERE                 ';
    strSQL := strSQL + '    CFG_IDEPRO = "DU2" AND        ';
    strSQL := strSQL + '    CFG_CODCFG = "PRODU2" AND     ';
    strSQL := strSQL + '    CFG_GRUCFG = "CONFIGURACOES" AND        ';
    strSQL := strSQL + '    CFG_CODEMP = ' + QuotedStr(VS_strCodEmp);

    qryGen := fCriaQuery;
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.Open;

    Result := qryGen.FieldByName('CFG_VALCFG').AsString;
  Finally
    FreeAndNil(QryGen);
  End;
end;

function TExportaTintometricosTerceirosDuxone2.fRetMD5KEY: String;
begin
  Result := 'DU2_MD5KEY';
end;

function TExportaTintometricosTerceirosDuxone2.fRetornaBases: String;
begin
  Result := '';
  Result := Result + '  SELECT              ';
  Result := Result + '    BAS_CODBAS,       ';
  Result := Result + '    BAS_DESBAS,       ';
  Result := Result + '    BAS_CODITE,       ';
  Result := Result + '    BAS_EMBALA,       ';
  Result := Result + '    BAS_PESESP,       ';
  Result := Result + '    BAS_PESGRA,       ';
  Result := Result + '    ITE_PREVE' + fRetornaTabelaPreco + '  AS ITE_PREVEN,     ';
  Result := Result + '    G.ITE_PRECUS AS PRECUS,       ';
  Result := Result + '    G.ITE_PREVE1 AS PREVE1,       ';
  Result := Result + '    G.ITE_PREVE2 AS PREVE2,       ';
  Result := Result + '    G.ITE_PREVE3 AS PREVE3,       ';
  Result := Result + '    G.ITE_PREVE4 AS PREVE4,       ';
  Result := Result + '    G.ITE_PREVE5 AS PREVE5,       ';
  Result := Result + '    G.ITE_PREVE6 AS PREVE6,       ';
  Result := Result + '    G.ITE_PREVE7 AS PREVE7        ';
  Result := Result + '  FROM                ';
  Result := Result + '    DU2_CADBAS        ';
  Result := Result + '  INNER JOIN CADITE I ON        ';
  Result := Result + '    BAS_CODITE = ITE_CODITE         ';
  Result := Result + '  INNER JOIN ITEGER G ON        ';
  Result := Result + '    I.ITE_CODITE = G.ITE_CODITE     ';
  Result := Result + '  WHERE               ';
  Result := Result + '    G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);
end;

function TExportaTintometricosTerceirosDuxone2.fRetornaCampoEmbalagem(
  strSigEmb: String; dicRetorno: TDicionario): String;
begin
  Result := '';

  If strSigEmb = 'LT' Then
    Result := fRetEmbalagemLT()
  Else If strSigEmb = 'GL' Then
    Result := fRetEmbalagemGL()
  Else If strSigEmb = 'LA' Then
    Result := fRetEmbalagemLA()
  Else If strSigEmb = 'TB' Then
    Result := fRetEmbalagemTB()
  Else If strSigEmb = 'BD' Then
    Result := fRetEmbalagemBD()
  Else If strSigEmb = 'CP' Then
    Result := fRetEmbalagemCP()
  Else If strSigEmb = 'SS' Then
    Result := fRetEmbalagemSS()
  Else If strSigEMb = 'SP' Then
    Result := fRetEmbalagemSP()
  Else If strSigEmb = 'SD' Then
    Result := fRetEmbalagemSD();
end;

function TExportaTintometricosTerceirosDuxone2.fRetornaCodigoDiluente(
  dicRetorno: TDicionario): String;
begin
  Result := IfNull(dicRetorno['coddil'], '');
end;

function TExportaTintometricosTerceirosDuxone2.fRetornaColorantes: String;
begin
  Result := '';
end;

function TExportaTintometricosTerceirosDuxone2.fRetornaPercentualAcrescimo(
  Conexao: TUniConnection): Double;
Var
  qryGen: TUniQuery;
  strSQL: String;
begin
  Try
    Result := 0;

    strSQL := '';
    strSQL := strSQL + '  SELECT                ';
    strSQL := strSQL + '    CFG_VALCFG          ';
    strSQL := strSQL + '  FROM                  ';
    strSQL := strSQL + '    CFGTIN              ';
    strSQL := strSQL + '  WHERE                 ';
    strSQL := strSQL + '    CFG_IDEPRO = "DU2" AND                ';
    strSQL := strSQL + '    CFG_CODCFG = "APREVE" AND             ';
    strSQL := strSQL + '    CFG_CODEMP = "' + VS_strCodEmp + '"   ';

    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.Open;

    If Not fEmptyStr(qryGen.FieldByName('CFG_VALCFG').AsString) Then
      Result := (fStrToFloat(qryGen.FieldByName('CFG_VALCFG').AsString) / 100.0);
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosDuxone2.fRetornaPorcentagemDiluente(
  dicRetorno: TDicionario): Double;
begin
  Result := IfNull(dicRetorno['pordil'], 0);
end;

function TExportaTintometricosTerceirosDuxone2.fRetornaPrecoConcentrado(
  fltPrecoTotal, fltPerAcr, fltEmbalagem: Double): Double;
begin
  Result := 0;

  If fltPrecoTotal > 0 Then
    Result := fltPrecoTotal +
      (fltPerAcr * fltPrecoTotal) + fltEmbalagem;
end;

function TExportaTintometricosTerceirosDuxone2.fRetornaPrecoCustoConcentrado(
  fltPrecoTotal, fltEmbalagem: Double): Double;
begin
  Result := 0;

  If fltPrecoTotal > 0 Then
    Result := fltPrecoTotal + fltEmbalagem;
end;

function TExportaTintometricosTerceirosDuxone2.fRetornaPrecoCustoDiluido(
  fltPrecoTotal, fltEmbalagem: Double): Double;
begin
  Result := 0;

  If fltPrecoTotal > 0 Then
    Result := fltPrecoTotal + fltEmbalagem;
end;

function TExportaTintometricosTerceirosDuxone2.fRetornaPrecoDiluido(
  fltPrecoTotal, fltPerAcr, fltEmbalagem: Double): Double;
begin
  Result := 0;

  If fltPrecoTotal > 0 Then
    Result := fltPrecoTotal +
      (fltPerAcr * fltPrecoTotal) + fltEmbalagem;
end;

function TExportaTintometricosTerceirosDuxone2.fRetQtdDiluente(strPercentual: String; fltPesoEspecifico: Double): Double;
begin
  Result := (StrToFloat(strPercentual) * 10) * fltPesoEspecifico;
end;

function TExportaTintometricosTerceirosDuxone2.fRetQuantidade(
  intCont: Integer): String;
begin
  Result := 'DU2_QTDC' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosDuxone2.fRetTipoCor: String;
begin
  Result := 'DU2_LINHA_';
end;

function TExportaTintometricosTerceirosDuxone2.fRetValorAcrMobCfgTin: String;
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' SELECT CFG_VALCFG               ');
    qryGen.SQL.Add('    FROM CFGTIN                  ');
    qryGen.SQL.Add(' WHERE CFG_IDEPRO = "DU2" AND    ');
    qryGen.SQL.Add('       CFG_CODCFG = "ACRMOB" AND ');
    qryGen.SQL.Add('       CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
    qryGen.Open;

    Result := qryGen.FieldByName('CFG_VALCFG').AsString;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosDuxone2.fSQLInsert: String;
begin
  Result := '';
  Result := Result + '  INSERT INTO ' + fNomeTabela() +   '   (     ';
  Result := Result + '    DU2_CODDU2,           ';
  Result := Result + '    DU2_CODOEM,           ';
  Result := Result + '    DU2_LINHA_,           ';
  Result := Result + '    DU2_QUALID,           ';
  Result := Result + '    DU2_ALTERN,           ';
  Result := Result + '    DU2_REGIAO,           ';
  Result := Result + '    DU2_DESCRI,           ';
  Result := Result + '    DU2_MONTAD,           ';
  Result := Result + '    DU2_OBSERV,           ';
  Result := Result + '    DU2_MD5KEY,           ';
  Result := Result + '    DU2_CODITE,           ';
  Result := Result + '    DU2_CODDIL,           ';
  Result := Result + '    DU2_PORDIL,           ';

  Result := Result + '    DU2_PRECLT,           ';
  Result := Result + '    DU2_PRECGL,           ';
  Result := Result + '    DU2_PRECLA,           ';
  Result := Result + '    DU2_PRECTB,           ';
  Result := Result + '    DU2_PRECBD,           ';
  Result := Result + '    DU2_PRECCP,           ';
  Result := Result + '    DU2_PRECSS,           ';
  Result := Result + '    DU2_PRECSP,           ';
  Result := Result + '    DU2_PRECSD,           ';

  Result := Result + '    DU2_PREDLT,           ';
  Result := Result + '    DU2_PREDGL,           ';
  Result := Result + '    DU2_PREDLA,           ';
  Result := Result + '    DU2_PREDTB,           ';
  Result := Result + '    DU2_PREDBD,           ';
  Result := Result + '    DU2_PREDCP,           ';
  Result := Result + '    DU2_PREDSS,           ';
  Result := Result + '    DU2_PREDSP,           ';
  Result := Result + '    DU2_PREDSD,           ';

  Result := Result + '    DU2_PCUCLT,           ';
  Result := Result + '    DU2_PCUCGL,           ';
  Result := Result + '    DU2_PCUCLA,           ';
  Result := Result + '    DU2_PCUCTB,           ';
  Result := Result + '    DU2_PCUCBD,           ';
  Result := Result + '    DU2_PCUCCP,           ';
  Result := Result + '    DU2_PCUCSS,           ';
  Result := Result + '    DU2_PCUCSP,           ';
  Result := Result + '    DU2_PCUCSD,           ';

  Result := Result + '    DU2_PCUDLT,           ';
  Result := Result + '    DU2_PCUDGL,           ';
  Result := Result + '    DU2_PCUDLA,           ';
  Result := Result + '    DU2_PCUDTB,           ';
  Result := Result + '    DU2_PCUDBD,           ';
  Result := Result + '    DU2_PCUDCP,           ';
  Result := Result + '    DU2_PCUDSS,           ';
  Result := Result + '    DU2_PCUDSP,           ';
  Result := Result + '    DU2_PCUDSD,           ';

  Result := Result + '    DU2_PRCLT1,           ';
  Result := Result + '    DU2_PRCLT2,           ';
  Result := Result + '    DU2_PRCLT3,           ';
  Result := Result + '    DU2_PRCLT4,           ';
  Result := Result + '    DU2_PRCLT5,           ';
  Result := Result + '    DU2_PRCLT6,           ';
  Result := Result + '    DU2_PRCLT7,           ';

  Result := Result + '    DU2_PRDLT1,           ';
  Result := Result + '    DU2_PRDLT2,           ';
  Result := Result + '    DU2_PRDLT3,           ';
  Result := Result + '    DU2_PRDLT4,           ';
  Result := Result + '    DU2_PRDLT5,           ';
  Result := Result + '    DU2_PRDLT6,           ';
  Result := Result + '    DU2_PRDLT7,           ';

  Result := Result + '    DU2_PRCGL1,           ';
  Result := Result + '    DU2_PRCGL2,           ';
  Result := Result + '    DU2_PRCGL3,           ';
  Result := Result + '    DU2_PRCGL4,           ';
  Result := Result + '    DU2_PRCGL5,           ';
  Result := Result + '    DU2_PRCGL6,           ';
  Result := Result + '    DU2_PRCGL7,           ';

  Result := Result + '    DU2_PRDGL1,           ';
  Result := Result + '    DU2_PRDGL2,           ';
  Result := Result + '    DU2_PRDGL3,           ';
  Result := Result + '    DU2_PRDGL4,           ';
  Result := Result + '    DU2_PRDGL5,           ';
  Result := Result + '    DU2_PRDGL6,           ';
  Result := Result + '    DU2_PRDGL7,           ';

  Result := Result + '    DU2_PRCLA1,           ';
  Result := Result + '    DU2_PRCLA2,           ';
  Result := Result + '    DU2_PRCLA3,           ';
  Result := Result + '    DU2_PRCLA4,           ';
  Result := Result + '    DU2_PRCLA5,           ';
  Result := Result + '    DU2_PRCLA6,           ';
  Result := Result + '    DU2_PRCLA7,           ';

  Result := Result + '    DU2_PRDLA1,           ';
  Result := Result + '    DU2_PRDLA2,           ';
  Result := Result + '    DU2_PRDLA3,           ';
  Result := Result + '    DU2_PRDLA4,           ';
  Result := Result + '    DU2_PRDLA5,           ';
  Result := Result + '    DU2_PRDLA6,           ';
  Result := Result + '    DU2_PRDLA7,           ';

  Result := Result + '    DU2_PRCTB1,           ';
  Result := Result + '    DU2_PRCTB2,           ';
  Result := Result + '    DU2_PRCTB3,           ';
  Result := Result + '    DU2_PRCTB4,           ';
  Result := Result + '    DU2_PRCTB5,           ';
  Result := Result + '    DU2_PRCTB6,           ';
  Result := Result + '    DU2_PRCTB7,           ';

  Result := Result + '    DU2_PRDTB1,           ';
  Result := Result + '    DU2_PRDTB2,           ';
  Result := Result + '    DU2_PRDTB3,           ';
  Result := Result + '    DU2_PRDTB4,           ';
  Result := Result + '    DU2_PRDTB5,           ';
  Result := Result + '    DU2_PRDTB6,           ';
  Result := Result + '    DU2_PRDTB7,           ';

  Result := Result + '    DU2_PRCBD1,           ';
  Result := Result + '    DU2_PRCBD2,           ';
  Result := Result + '    DU2_PRCBD3,           ';
  Result := Result + '    DU2_PRCBD4,           ';
  Result := Result + '    DU2_PRCBD5,           ';
  Result := Result + '    DU2_PRCBD6,           ';
  Result := Result + '    DU2_PRCBD7,           ';

  Result := Result + '    DU2_PRDBD1,           ';
  Result := Result + '    DU2_PRDBD2,           ';
  Result := Result + '    DU2_PRDBD3,           ';
  Result := Result + '    DU2_PRDBD4,           ';
  Result := Result + '    DU2_PRDBD5,           ';
  Result := Result + '    DU2_PRDBD6,           ';
  Result := Result + '    DU2_PRDBD7,           ';

  Result := Result + '    DU2_PRCCP1,           ';
  Result := Result + '    DU2_PRCCP2,           ';
  Result := Result + '    DU2_PRCCP3,           ';
  Result := Result + '    DU2_PRCCP4,           ';
  Result := Result + '    DU2_PRCCP5,           ';
  Result := Result + '    DU2_PRCCP6,           ';
  Result := Result + '    DU2_PRCCP7,           ';

  Result := Result + '    DU2_PRDCP1,           ';
  Result := Result + '    DU2_PRDCP2,           ';
  Result := Result + '    DU2_PRDCP3,           ';
  Result := Result + '    DU2_PRDCP4,           ';
  Result := Result + '    DU2_PRDCP5,           ';
  Result := Result + '    DU2_PRDCP6,           ';
  Result := Result + '    DU2_PRDCP7,           ';

  Result := Result + '    DU2_PRCSS1,           ';
  Result := Result + '    DU2_PRCSS2,           ';
  Result := Result + '    DU2_PRCSS3,           ';
  Result := Result + '    DU2_PRCSS4,           ';
  Result := Result + '    DU2_PRCSS5,           ';
  Result := Result + '    DU2_PRCSS6,           ';
  Result := Result + '    DU2_PRCSS7,           ';

  Result := Result + '    DU2_PRDSS1,           ';
  Result := Result + '    DU2_PRDSS2,           ';
  Result := Result + '    DU2_PRDSS3,           ';
  Result := Result + '    DU2_PRDSS4,           ';
  Result := Result + '    DU2_PRDSS5,           ';
  Result := Result + '    DU2_PRDSS6,           ';
  Result := Result + '    DU2_PRDSS7,           ';

  Result := Result + '    DU2_PRCSP1,           ';
  Result := Result + '    DU2_PRCSP2,           ';
  Result := Result + '    DU2_PRCSP3,           ';
  Result := Result + '    DU2_PRCSP4,           ';
  Result := Result + '    DU2_PRCSP5,           ';
  Result := Result + '    DU2_PRCSP6,           ';
  Result := Result + '    DU2_PRCSP7,           ';

  Result := Result + '    DU2_PRDSP1,           ';
  Result := Result + '    DU2_PRDSP2,           ';
  Result := Result + '    DU2_PRDSP3,           ';
  Result := Result + '    DU2_PRDSP4,           ';
  Result := Result + '    DU2_PRDSP5,           ';
  Result := Result + '    DU2_PRDSP6,           ';
  Result := Result + '    DU2_PRDSP7,           ';

  Result := Result + '    DU2_PRCSD1,           ';
  Result := Result + '    DU2_PRCSD2,           ';
  Result := Result + '    DU2_PRCSD3,           ';
  Result := Result + '    DU2_PRCSD4,           ';
  Result := Result + '    DU2_PRCSD5,           ';
  Result := Result + '    DU2_PRCSD6,           ';
  Result := Result + '    DU2_PRCSD7,           ';

  Result := Result + '    DU2_PRDSD1,           ';
  Result := Result + '    DU2_PRDSD2,           ';
  Result := Result + '    DU2_PRDSD3,           ';
  Result := Result + '    DU2_PRDSD4,           ';
  Result := Result + '    DU2_PRDSD5,           ';
  Result := Result + '    DU2_PRDSD6,           ';
  Result := Result + '    DU2_PRDSD7,           ';

  Result := Result + '    DU2_EMBALT,           ';
  Result := Result + '    DU2_EMBAGL,           ';
  Result := Result + '    DU2_EMBALA,           ';
  Result := Result + '    DU2_EMBATB,           ';
  Result := Result + '    DU2_EMBABD,           ';
  Result := Result + '    DU2_EMBACP,           ';
  Result := Result + '    DU2_EMBASS,           ';
  Result := Result + '    DU2_EMBASP,           ';
  Result := Result + '    DU2_EMBASD,           ';

  Result := Result + '    DU2_VOLULT,           ';
  Result := Result + '    DU2_VOLUGL,           ';
  Result := Result + '    DU2_VOLULA,           ';
  Result := Result + '    DU2_VOLUTB,           ';
  Result := Result + '    DU2_VOLUBD,           ';
  Result := Result + '    DU2_VOLUCP,           ';
  Result := Result + '    DU2_VOLUSS,           ';
  Result := Result + '    DU2_VOLUSP,           ';
  Result := Result + '    DU2_VOLUSD,           ';

  Result := Result + '    DU2_PREELT,           ';
  Result := Result + '    DU2_PREEGL,           ';
  Result := Result + '    DU2_PREELA,           ';
  Result := Result + '    DU2_PREETB,           ';
  Result := Result + '    DU2_PREEBD,           ';
  Result := Result + '    DU2_PREECP,           ';
  Result := Result + '    DU2_PREESS,           ';
  Result := Result + '    DU2_PREESP,           ';
  Result := Result + '    DU2_PREESD,           ';

  Result := Result + '    DU2_TIPOLT,           ';
  Result := Result + '    DU2_TIPOGL,           ';
  Result := Result + '    DU2_TIPOLA,           ';
  Result := Result + '    DU2_TIPOTB,           ';
  Result := Result + '    DU2_TIPOBD,           ';
  Result := Result + '    DU2_TIPOCP,           ';
  Result := Result + '    DU2_TIPOSS,           ';
  Result := Result + '    DU2_TIPOSP,           ';
  Result := Result + '    DU2_TIPOSD            ';
  Result := Result + '        )                 ';
  Result := Result + '  VALUES  ' + ' (         ';
  Result := Result + '    :CODDU2,              ';
  Result := Result + '    :CODOEM,              ';
  Result := Result + '    :LINHA_,              ';
  Result := Result + '    :QUALID,              ';
  Result := Result + '    :ALTERN,              ';
  Result := Result + '    :REGIAO,              ';
  Result := Result + '    :DESCRI,              ';
  Result := Result + '    :MONTAD,              ';
  Result := Result + '    :OBSERV,              ';
  Result := Result + '    :MD5KEY,              ';
  Result := Result + '    :CODITE,              ';
  Result := Result + '    :CODDIL,              ';
  Result := Result + '    :PORDIL,              ';

  Result := Result + '    :PRECLT,              ';
  Result := Result + '    :PRECGL,              ';
  Result := Result + '    :PRECLA,              ';
  Result := Result + '    :PRECTB,              ';
  Result := Result + '    :PRECBD,              ';
  Result := Result + '    :PRECCP,              ';
  Result := Result + '    :PRECSS,              ';
  Result := Result + '    :PRECSP,              ';
  Result := Result + '    :PRECSD,              ';

  Result := Result + '    :PREDLT,              ';
  Result := Result + '    :PREDGL,              ';
  Result := Result + '    :PREDLA,              ';
  Result := Result + '    :PREDTB,              ';
  Result := Result + '    :PREDBD,              ';
  Result := Result + '    :PREDCP,              ';
  Result := Result + '    :PREDSS,              ';
  Result := Result + '    :PREDSP,              ';
  Result := Result + '    :PREDSD,              ';

  Result := Result + '    :PCUCLT,              ';
  Result := Result + '    :PCUCGL,              ';
  Result := Result + '    :PCUCLA,              ';
  Result := Result + '    :PCUCTB,              ';
  Result := Result + '    :PCUCBD,              ';
  Result := Result + '    :PCUCCP,              ';
  Result := Result + '    :PCUCSS,              ';
  Result := Result + '    :PCUCSP,              ';
  Result := Result + '    :PCUCSD,              ';

  Result := Result + '    :PCUDLT,              ';
  Result := Result + '    :PCUDGL,              ';
  Result := Result + '    :PCUDLA,              ';
  Result := Result + '    :PCUDTB,              ';
  Result := Result + '    :PCUDBD,              ';
  Result := Result + '    :PCUDCP,              ';
  Result := Result + '    :PCUDSS,              ';
  Result := Result + '    :PCUDSP,              ';
  Result := Result + '    :PCUDSD,              ';

  Result := Result + '    :PRCLT1,              ';
  Result := Result + '    :PRCLT2,              ';
  Result := Result + '    :PRCLT3,              ';
  Result := Result + '    :PRCLT4,              ';
  Result := Result + '    :PRCLT5,              ';
  Result := Result + '    :PRCLT6,              ';
  Result := Result + '    :PRCLT7,              ';

  Result := Result + '    :PRDLT1,              ';
  Result := Result + '    :PRDLT2,              ';
  Result := Result + '    :PRDLT3,              ';
  Result := Result + '    :PRDLT4,              ';
  Result := Result + '    :PRDLT5,              ';
  Result := Result + '    :PRDLT6,              ';
  Result := Result + '    :PRDLT7,              ';

  Result := Result + '    :PRCGL1,              ';
  Result := Result + '    :PRCGL2,              ';
  Result := Result + '    :PRCGL3,              ';
  Result := Result + '    :PRCGL4,              ';
  Result := Result + '    :PRCGL5,              ';
  Result := Result + '    :PRCGL6,              ';
  Result := Result + '    :PRCGL7,              ';

  Result := Result + '    :PRDGL1,              ';
  Result := Result + '    :PRDGL2,              ';
  Result := Result + '    :PRDGL3,              ';
  Result := Result + '    :PRDGL4,              ';
  Result := Result + '    :PRDGL5,              ';
  Result := Result + '    :PRDGL6,              ';
  Result := Result + '    :PRDGL7,              ';

  Result := Result + '    :PRCLA1,              ';
  Result := Result + '    :PRCLA2,              ';
  Result := Result + '    :PRCLA3,              ';
  Result := Result + '    :PRCLA4,              ';
  Result := Result + '    :PRCLA5,              ';
  Result := Result + '    :PRCLA6,              ';
  Result := Result + '    :PRCLA7,              ';

  Result := Result + '    :PRDLA1,              ';
  Result := Result + '    :PRDLA2,              ';
  Result := Result + '    :PRDLA3,              ';
  Result := Result + '    :PRDLA4,              ';
  Result := Result + '    :PRDLA5,              ';
  Result := Result + '    :PRDLA6,              ';
  Result := Result + '    :PRDLA7,              ';


  Result := Result + '    :PRCTB1,              ';
  Result := Result + '    :PRCTB2,              ';
  Result := Result + '    :PRCTB3,              ';
  Result := Result + '    :PRCTB4,              ';
  Result := Result + '    :PRCTB5,              ';
  Result := Result + '    :PRCTB6,              ';
  Result := Result + '    :PRCTB7,              ';

  Result := Result + '    :PRDTB1,              ';
  Result := Result + '    :PRDTB2,              ';
  Result := Result + '    :PRDTB3,              ';
  Result := Result + '    :PRDTB4,              ';
  Result := Result + '    :PRDTB5,              ';
  Result := Result + '    :PRDTB6,              ';
  Result := Result + '    :PRDTB7,              ';

  Result := Result + '    :PRCBD1,              ';
  Result := Result + '    :PRCBD2,              ';
  Result := Result + '    :PRCBD3,              ';
  Result := Result + '    :PRCBD4,              ';
  Result := Result + '    :PRCBD5,              ';
  Result := Result + '    :PRCBD6,              ';
  Result := Result + '    :PRCBD7,              ';

  Result := Result + '    :PRDBD1,              ';
  Result := Result + '    :PRDBD2,              ';
  Result := Result + '    :PRDBD3,              ';
  Result := Result + '    :PRDBD4,              ';
  Result := Result + '    :PRDBD5,              ';
  Result := Result + '    :PRDBD6,              ';
  Result := Result + '    :PRDBD7,              ';

  Result := Result + '    :PRCCP1,              ';
  Result := Result + '    :PRCCP2,              ';
  Result := Result + '    :PRCCP3,              ';
  Result := Result + '    :PRCCP4,              ';
  Result := Result + '    :PRCCP5,              ';
  Result := Result + '    :PRCCP6,              ';
  Result := Result + '    :PRCCP7,              ';

  Result := Result + '    :PRDCP1,              ';
  Result := Result + '    :PRDCP2,              ';
  Result := Result + '    :PRDCP3,              ';
  Result := Result + '    :PRDCP4,              ';
  Result := Result + '    :PRDCP5,              ';
  Result := Result + '    :PRDCP6,              ';
  Result := Result + '    :PRDCP7,              ';

  Result := Result + '    :PRCSS1,              ';
  Result := Result + '    :PRCSS2,              ';
  Result := Result + '    :PRCSS3,              ';
  Result := Result + '    :PRCSS4,              ';
  Result := Result + '    :PRCSS5,              ';
  Result := Result + '    :PRCSS6,              ';
  Result := Result + '    :PRCSS7,              ';

  Result := Result + '    :PRDSS1,              ';
  Result := Result + '    :PRDSS2,              ';
  Result := Result + '    :PRDSS3,              ';
  Result := Result + '    :PRDSS4,              ';
  Result := Result + '    :PRDSS5,              ';
  Result := Result + '    :PRDSS6,              ';
  Result := Result + '    :PRDSS7,              ';

  Result := Result + '    :PRCSP1,              ';
  Result := Result + '    :PRCSP2,              ';
  Result := Result + '    :PRCSP3,              ';
  Result := Result + '    :PRCSP4,              ';
  Result := Result + '    :PRCSP5,              ';
  Result := Result + '    :PRCSP6,              ';
  Result := Result + '    :PRCSP7,              ';

  Result := Result + '    :PRDSP1,              ';
  Result := Result + '    :PRDSP2,              ';
  Result := Result + '    :PRDSP3,              ';
  Result := Result + '    :PRDSP4,              ';
  Result := Result + '    :PRDSP5,              ';
  Result := Result + '    :PRDSP6,              ';
  Result := Result + '    :PRDSP7,              ';

  Result := Result + '    :PRCSD1,              ';
  Result := Result + '    :PRCSD2,              ';
  Result := Result + '    :PRCSD3,              ';
  Result := Result + '    :PRCSD4,              ';
  Result := Result + '    :PRCSD5,              ';
  Result := Result + '    :PRCSD6,              ';
  Result := Result + '    :PRCSD7,              ';

  Result := Result + '    :PRDSD1,              ';
  Result := Result + '    :PRDSD2,              ';
  Result := Result + '    :PRDSD3,              ';
  Result := Result + '    :PRDSD4,              ';
  Result := Result + '    :PRDSD5,              ';
  Result := Result + '    :PRDSD6,              ';
  Result := Result + '    :PRDSD7,              ';

  Result := Result + '    :EMBALT,              ';
  Result := Result + '    :EMBAGL,              ';
  Result := Result + '    :EMBALA,              ';
  Result := Result + '    :EMBATB,              ';
  Result := Result + '    :EMBABD,              ';
  Result := Result + '    :EMBACP,              ';
  Result := Result + '    :EMBASS,              ';
  Result := Result + '    :EMBASP,              ';
  Result := Result + '    :EMBASD,              ';

  Result := Result + '    :VOLULT,              ';
  Result := Result + '    :VOLUGL,              ';
  Result := Result + '    :VOLULA,              ';
  Result := Result + '    :VOLUTB,              ';
  Result := Result + '    :VOLUBD,              ';
  Result := Result + '    :VOLUCP,              ';
  Result := Result + '    :VOLUSS,              ';
  Result := Result + '    :VOLUSP,              ';
  Result := Result + '    :VOLUSD,              ';

  Result := Result + '    :PREELT,              ';
  Result := Result + '    :PREEGL,              ';
  Result := Result + '    :PREELA,              ';
  Result := Result + '    :PREETB,              ';
  Result := Result + '    :PREEBD,              ';
  Result := Result + '    :PREECP,              ';
  Result := Result + '    :PREESS,              ';
  Result := Result + '    :PREESP,              ';
  Result := Result + '    :PREESD,              ';

  Result := Result + '    :TIPOLT,              ';
  Result := Result + '    :TIPOGL,              ';
  Result := Result + '    :TIPOLA,              ';
  Result := Result + '    :TIPOTB,              ';
  Result := Result + '    :TIPOBD,              ';
  Result := Result + '    :TIPOCP,              ';
  Result := Result + '    :TIPOSS,              ';
  Result := Result + '    :TIPOSP,              ';
  Result := Result + '    :TIPOSD               ';
  Result := Result + '        );                ';
end;

function TExportaTintometricosTerceirosDuxone2.fValorQuantidade(fltValor,
  fltAcrMob: Double): Double;
begin
  If fltValor <= 0 Then
    Result := 0
  Else
    Result := fltValor + fltAcrMob;
end;

procedure TExportaTintometricosTerceirosDuxone2.pAdicionaParamentros(
  var DataSet: TFDQuery; qryTinta: TUniQuery; fltPreVen: Double; intParam: Integer = 0);
Var
  intContador: Integer;
  intEmb: Integer;
begin
  DataSet.ParamByName('CODDU2').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('DU2_CODDU2').AsString);
  DataSet.ParamByName('CODOEM').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('DU2_CODOEM').AsString);
  DataSet.ParamByName('QUALID').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('DU2_QUALID').AsString);
  DataSet.ParamByName('LINHA_').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('DU2_LINHA_').AsString);
  DataSet.ParamByName('ALTERN').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('DU2_ALTERN').AsString);
  DataSet.ParamByName('REGIAO').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('DU2_REGIAO').AsString);
  DataSet.ParamByName('DESCRI').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('DU2_DESCRI').AsString);
  DataSet.ParamByName('MONTAD').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('DU2_MONTAD').AsString);
  DataSet.ParamByName('OBSERV').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('DU2_OBSERV').AsString);
  DataSet.ParamByName('MD5KEY').AsStrings[intParam] := qryTinta.FieldByName('DU2_MD5KEY').AsString;
  DataSet.ParamByName('CODITE').AsStrings[intParam] := strProDu2;
  DataSet.ParamByName('PCUCLT').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONLT'], 0.0);
  DataSet.ParamByName('PCUCGL').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONGL'], 0.0);
  DataSet.ParamByName('PCUCLA').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONLA'], 0.0);
  DataSet.ParamByName('PCUCTB').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONTB'], 0.0);
  DataSet.ParamByName('PCUCBD').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONBD'], 0.0);
  DataSet.ParamByName('PCUCCP').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONCP'], 0.0);
  DataSet.ParamByName('PCUCSS').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONSS'], 0.0);
  DataSet.ParamByName('PCUCSP').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONSP'], 0.0);
  DataSet.ParamByName('PCUCSD').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONSD'], 0.0);
  DataSet.ParamByName('PCUDLT').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILLT'], 0.0);
  DataSet.ParamByName('PCUDGL').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILGL'], 0.0);
  DataSet.ParamByName('PCUDLA').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILLA'], 0.0);
  DataSet.ParamByName('PCUDTB').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILTB'], 0.0);
  DataSet.ParamByName('PCUDBD').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILBD'], 0.0);
  DataSet.ParamByName('PCUDCP').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILCP'], 0.0);
  DataSet.ParamByName('PCUDSS').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILSS'], 0.0);
  DataSet.ParamByName('PCUDSP').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILSP'], 0.0);
  DataSet.ParamByName('PCUDSD').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILSD'], 0.0);

  For intEmb := 0 To Length(arrEmbalagens) - 1 Do
  Begin
    If strAcrMob = '1' Then
    Begin
      arrPrecosPorEmb[intEmb].fltValCon := arrPrecosPorEmb[intEmb].fltValCon * (1 + qryTinta.FieldByName('DU2_ACRMOB').AsFloat / 100);
      arrPrecosPorEmb[intEmb].fltValDil := arrPrecosPorEmb[intEmb].fltValDil * (1 + qryTinta.FieldByName('DU2_ACRMOB').AsFloat / 100);
    End
    Else
    Begin
      arrPrecosPorEmb[intEmb].fltValCon := fValorQuantidade(arrPrecosPorEmb[intEmb].fltValCon, qryTinta.FieldByName('DU2_ACRMOB').AsFloat);
      arrPrecosPorEmb[intEmb].fltValDil := fValorQuantidade(arrPrecosPorEmb[intEmb].fltValDil, qryTinta.FieldByName('DU2_ACRMOB').AsFloat);
    End;
  End;

  For intContador := 1 To 7 Do
  Begin
    If stlTabPre[intContador] <> 'S' Then
    Begin
      DataSet.ParamByName('PRCLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLT'], 0.0);
      DataSet.ParamByName('PRCGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONGL'], 0.0);
      DataSet.ParamByName('PRCLA' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLA'], 0.0);
      DataSet.ParamByName('PRCTB' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONTB'], 0.0);
      DataSet.ParamByName('PRCBD' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONBD'], 0.0);
      DataSet.ParamByName('PRCCP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONCP'], 0.0);
      DataSet.ParamByName('PRCSS' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONSS'], 0.0);
      DataSet.ParamByName('PRCSP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONSP'], 0.0);
      DataSet.ParamByName('PRCSD' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONSD'], 0.0);
      DataSet.ParamByName('PRDLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLT'], 0.0);
      DataSet.ParamByName('PRDGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILGL'], 0.0);
      DataSet.ParamByName('PRDLA' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLA'], 0.0);
      DataSet.ParamByName('PRDTB' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILTB'], 0.0);
      DataSet.ParamByName('PRDBD' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILBD'], 0.0);
      DataSet.ParamByName('PRDCP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCP'], 0.0);
      DataSet.ParamByName('PRDSS' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILSS'], 0.0);
      DataSet.ParamByName('PRDSP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILSP'], 0.0);
      DataSet.ParamByName('PRDSD' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILSD'], 0.0);
    End
    Else
    Begin
      If strAcrMob = '1' Then
      Begin
        DataSet.ParamByName('PRCLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLT'], 0.0) * (1 + qryTinta.FieldByName('DU2_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONGL'], 0.0) * (1 + qryTinta.FieldByName('DU2_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCLA' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLA'], 0.0) * (1 + qryTinta.FieldByName('DU2_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCTB' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONTB'], 0.0) * (1 + qryTinta.FieldByName('DU2_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCBD' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONBD'], 0.0) * (1 + qryTinta.FieldByName('DU2_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCCP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONCP'], 0.0) * (1 + qryTinta.FieldByName('DU2_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCSS' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONSS'], 0.0) * (1 + qryTinta.FieldByName('DU2_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCSP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONSP'], 0.0) * (1 + qryTinta.FieldByName('DU2_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCSD' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONSD'], 0.0) * (1 + qryTinta.FieldByName('DU2_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLT'], 0.0) * (1 + qryTinta.FieldByName('DU2_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILGL'], 0.0) * (1 + qryTinta.FieldByName('DU2_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDLA' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLA'], 0.0) * (1 + qryTinta.FieldByName('DU2_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDTB' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILTB'], 0.0) * (1 + qryTinta.FieldByName('DU2_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDBD' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILBD'], 0.0) * (1 + qryTinta.FieldByName('DU2_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDCP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCP'], 0.0) * (1 + qryTinta.FieldByName('DU2_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDSS' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILSS'], 0.0) * (1 + qryTinta.FieldByName('DU2_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDSP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILSP'], 0.0) * (1 + qryTinta.FieldByName('DU2_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDSD' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILSD'], 0.0) * (1 + qryTinta.FieldByName('DU2_ACRMOB').AsFloat / 100);
      End
      Else
      Begin
        DataSet.ParamByName('PRCLT' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLT'], 0.0), qryTinta.FieldByName('DU2_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCGL' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONGL'], 0.0), qryTinta.FieldByName('DU2_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCLA' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLA'], 0.0), qryTinta.FieldByName('DU2_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCTB' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONTB'], 0.0), qryTinta.FieldByName('DU2_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCBD' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONBD'], 0.0), qryTinta.FieldByName('DU2_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCCP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONCP'], 0.0), qryTinta.FieldByName('DU2_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCSS' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONSS'], 0.0), qryTinta.FieldByName('DU2_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCSP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONSP'], 0.0), qryTinta.FieldByName('DU2_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCSD' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONSD'], 0.0), qryTinta.FieldByName('DU2_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDLT' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLT'], 0.0), qryTinta.FieldByName('DU2_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDGL' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILGL'], 0.0), qryTinta.FieldByName('DU2_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDLA' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLA'], 0.0), qryTinta.FieldByName('DU2_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDTB' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILTB'], 0.0), qryTinta.FieldByName('DU2_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDBD' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILBD'], 0.0), qryTinta.FieldByName('DU2_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDCP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCP'], 0.0), qryTinta.FieldByName('DU2_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDSS' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILSS'], 0.0), qryTinta.FieldByName('DU2_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDSP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILSP'], 0.0), qryTinta.FieldByName('DU2_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDSD' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILSD'], 0.0), qryTinta.FieldByName('DU2_ACRMOB').AsFloat);
      End;
    End;
  End;
end;

procedure TExportaTintometricosTerceirosDuxone2.pCarregarDados;
Var
  qryDiluente: TUniQuery;
  strSQL: String;
begin
  stlDiluentes := TStringList.Create();
  stlDiluentes.Clear;

  strSQL := '';
  strSQL := strSQL + '  SELECT DISTINCT                            ';
  strSQL := strSQL + '    *                                        ';
  strSQL := strSQL + '  FROM                                       ';
  strSQL := strSQL + '    DU2_CADBAS B                             ';
  strSQL := strSQL + '  WHERE                                      ';
  strSQL := strSQL + '    B.BAS_CODBAS IN ("DX32", "DX34")         ';

  Try
    qryDiluente := fCriaQuery();
    qryDiluente.Close;
    qryDiluente.SQL.Clear;
    qryDiluente.SQL.Add(strSQL);
    qryDiluente.Open;

    While Not qryDiluente.Eof Do
    Begin
      stlDiluentes.Add(qryDiluente.FieldByName('BAS_CODBAS').AsString);
      qryDiluente.Next;
    End;
  Finally
    FreeAndNil(qryDiluente);
  End;
end;

procedure TExportaTintometricosTerceirosDuxone2.pCriaClientEmbalagem(
  Conexao: TUniConnection);
Var
  qryEmb: TUniQuery;
  strSQL: String;
begin
  Try
    strSQL := '';
    strSQL := strSQL + '  SELECT                    ';
    strSQL := strSQL + '    *                       ';
    strSQL := strSQL + '  FROM                      ';
    strSQL := strSQL + '    CFGTIN                  ';
    strSQL := strSQL + '  WHERE                     ';
    strSQL := strSQL + '    CFG_IDEPRO = "DU2" AND                  ';
    strSQL := strSQL + '    CFG_GRUCFG = "CONFIGURACOES" AND        ';
    strSQL := strSQL + '    CFG_CODEMP = "' + VS_strCodEmp + '"     ';

    qryEmb := fCriaQuery();
    qryEmb.Close;
    qryEmb.SQL.Clear;
    qryEmb.SQL.Add(strSQL);
    qryEmb.Open;

    cdsEmbalagens := fCriaClientDatset(qryEmb, False, Nil, False);
  Finally
    FreeAndNil(qryEmb);
  End;
end;

procedure TExportaTintometricosTerceirosDuxone2.pCriaTabelaExportacao;
var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery(Nil);
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(fCamposTabela);
    qryGen.ExecSQL;
    qryGen.Close;
    qryGen.SQL.Clear;

    qryGen.SQL.Add('ALTER TABLE ' + fNomeTabela + ' ADD UNIQUE KEY (' + fRetMD5KEY + ', ' + fRetCODEMP + ')');

    qryGen.ExecSQL;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TExportaTintometricosTerceirosDuxone2.pGravaTintometricoPorTintaTerceiros(
  qryInsert: TFDQuery; fltPreVen: Double; qryTinta: TUniQuery;
  intParam: Integer);
var
  intEmb: Integer;
  strSigEmb: String;
begin
   Try
    pAdicionaParamentros(qryInsert, qryTinta, fltPreVen, intParam);

    For intEmb := 0 To Length(arrEmbalagens) - 1 Do
    Begin
      strSigEmb := arrEmbalagens[intEmb].strSigEmb;

      qryInsert.ParamByName('PREC' + strSigEmb).AsFloats[intParam]  := arrPrecosPorEmb[intEmb].fltValCon; //preco concentrado
      qryInsert.ParamByName('PRED' + strSigEmb).AsFloats[intParam]  := arrPrecosPorEmb[intEmb].fltValDil; //preco diluido
      qryInsert.ParamByName('EMBA' + strSigEmb).AsStrings[intParam] := arrPrecosPorEmb[intEmb].strIteEmb; //Produto embalagem
      qryInsert.ParamByName('VOLU' + strSigEmb).AsFloats[intParam]  := arrEmbalagens[intEmb].fltVolume;   //Volume vendido
      qryInsert.ParamByName('PREE' + strSigEmb).AsFloats[intParam]  := arrPrecosporEmb[intEmb].fltPreEmb; //Preco da embalagem
      qryInsert.ParamByName('TIPO' + strSigEmb).AsStrings[intParam] := strSigEmb;                         //Tipo da embalagem
      qryInsert.ParamByName('CODDIL').AsStrings[intParam] := arrPrecosPorEmb[intEmb].strCodDil; //Código do diluente
      qryInsert.ParamByName('PORDIL').AsFloats[intParam]  := arrPrecosPorEmb[intEmb].fltPorDil;//Porcentagem do diluente
    End;
  Finally
    SetLength(arrPrecosPorEmb, 0);
  End;
end;

procedure TExportaTintometricosTerceirosDuxone2.pIncluirLogTinSite(
  Conexao: TUniConnection; strStatus: String);
Var
  qryGen: TUniQuery;
  strSQL: String;
begin
  Try
    strSQL := '';
    strSQL := strSQL + '  DELETE FROM LOGTIN_SIT WHERE LOG_IDEPRO = "DU2"       ';

    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.ExecSQL;

    strSQL := '';
    strSQL := strSQL + '  INSERT INTO LOGTIN_SIT (            ';
    strSQL := strSQL + '    LOG_IDEPRO,         ';
    strSQL := strSQL + '    LOG_DTAEXE,         ';
    strSQL := strSQL + '    LOG_HOREXE,         ';
    strSQL := strSQL + '    LOG_EXECUT          ';
    strSQL := strSQL + '            )                         ';
    strSQL := strSQL + '  VALUES      (                       ';
    strSQL := strSQL + '    "DU2",              ';
    strSQL := strSQL + '    :DTAEXE,            ';
    strSQL := strSQL + '    :HOREXE,            ';
    strSQL := strSQL + '    :EXECUT             ';
    strSQL := strSQL + '          );                          ';

    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.ParamByName('DTAEXE').AsDateTime := VS_Date;
    qryGen.ParamByName('HOREXE').AsDateTime := Time;
    qryGen.ParamByName('EXECUT').AsString   := strStatus;
    qryGen.ExecSQL;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TExportaTintometricosTerceirosDuxone2.pPreencheArrayEmbalagem;
begin
  SetLength(arrEmbalagens, 1);

  //Litro
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Litro';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'LT';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 0.900;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  //Galão
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Galão';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'GL';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 3.600;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  //Lata
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Lata';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'LA';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 18.000;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  //Balde
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Balde';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'BD';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 18.000;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  //Tambor
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Tambor';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'TB';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 196.000;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  //Copo
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Copo';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'CP';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 0.500;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  //Spray Sintetico
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Spray Sintetico';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'SS';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 0.150;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  //Spray Poliester
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Spray Poliester';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'SP';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 0.150;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  //Spray Duco
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Spray Duco';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'SD';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 0.150;
end;

procedure TExportaTintometricosTerceirosDuxone2.pPreencheEmbalagens;
begin
  pPreencheArrayEmbalagem;
end;

procedure TExportaTintometricosTerceirosDuxone2.pProcessaTabelaCores(qryInsert: TFDQuery; qryGen, qryBases, qryColorantes: TUniQuery;
       strTabUni, strTabPre: String; fltPerAcr: Double; dicRetorno: TDicionario);
Var
  fltPreVen  : Double;
  intContador: Integer;
  intRegistros: Integer;
  intRepetir: Integer;
  intEmb: Integer;
begin
  If Not FAutoma Then
    FProgresso.Position := 0;

{$IFDEF LINUX}
  FInicioExportacao := Now;
{$ENDIF}

{$IFDEF LINUX}
  pGerarArrayValidacao(qryGen.RecordCount);
{$ENDIF}

  For intRepetir := 1 To RepetirPorTipo Do
  Begin
    qryGen.First;

    While Not qryGen.Eof Do
    Begin
      qryInsert.Params.ClearValues();
      qryInsert.Params.ArraySize := 1;
      intContador := 0;

    {$IFDEF LINUX}
      If VS_ExitProcessSignal Then
        Break;
    {$ENDIF}

      For intRegistros := 0 To 0 Do
      Begin
      {$IFDEF LINUX}
        If VS_ExitProcessSignal Then
          Break;
      {$ENDIF}

        {************************************************************}
        {** VALIDAÇÃO FEITA PARA VERIFICAR SE EXISTE BASE AMARRADA **}
        {**         SE FOR 3 EXISTE BASE NÃO AMARRADA              **}
        {********************************************************RG**}
        If fGetTipoFormula(qryGen, qryBases) = 3 Then
        Begin
          If ((qryGen.RecNo mod 100 = 0) Or (qryGen.RecNo = intMax)) And (Not FAutoma) Then
            Synchronize(pStep);

          qryGen.Next;
          Continue;
        End;

        pPreencheDicRetorno(dicRetorno, qryGen, strTabUni, strTabPre);
        pRetornaQuantidadeFormulacao(dicRetorno, qryGen, qryBases);
        pRetornaPrecoTinta(dicRetorno, qryColorantes, qryBases, fltPerAcr);

      {$IFDEF LINUX}
        If FValidateIndexList.Contains(qryGen.RecNo) Then
        Begin
          For intEmb := 0 To 3 Do
          Begin
              pValidarPrecoExportacaoDuxone2(qryGen.FieldByName(fRetMD5KEY).AsString,
                       arrEmbalagens[intEmb].strNomEmb, 'C', arrEmbalagens[intEmb].strSigEmb,
                       arrPrecosPorEmb[intEmb].fltValCon, dicPrecoAdicional, '_CON', arrPrecosPorEmb[intEmb].strCodDil);

              pValidarPrecoExportacaoDuxone2(qryGen.FieldByName(fRetMD5KEY).AsString,
                      arrEmbalagens[intEmb].strNomEmb, 'D', arrEmbalagens[intEmb].strSigEmb,
                      arrPrecosPorEmb[intEmb].fltValDil, dicPrecoAdicional, '_DIL', arrPrecosPorEmb[intEmb].strCodDil);
          End;
        End;
      {$ENDIF}

        fltPreven := IfNull(dicRetorno['preve'+dicRetorno['tabelaunica']], 0.0);
        pGravaTintometricoTabelasTerceiros(qryInsert, fltPreven, qryGen, intContador);

        If ((qryGen.RecNo mod 100 = 0) Or (qryGen.RecNo = intMax)) And (Not FAutoma) Then
          Synchronize(pStep);

        If Not qryGen.Eof Then
          qryGen.Next
        Else
          Break;

        Inc(intContador, 1);
      End;

    {$IFDEF LINUX}
      If Not fValidarPrecosCalculado(False, 9999) Then
        Break;
    {$ENDIF}

    {$IFDEF LINUX}
      pEscreverAguardeInserindo;
    {$ENDIF}

      If intContador > 0  Then
        qryInsert.Execute(intContador, 0);

    {$IFDEF LINUX}
      pEscreverLogProgresso(qryGen);
    {$ENDIF}
    End;

    Inc(intTipo);
  {$IFDEF LINUX}
    fValidarPrecosCalculado(True);
  {$ENDIF}
  End;
end;

procedure TExportaTintometricosTerceirosDuxone2.pRecalculaFormula(
  dicRetorno: TDicionario; qryGen, qryBases: TUniQuery);
Var
  qryDiluente: TUniQuery;
  strSQL: String;
  intContador: Integer;
  fltVolumeConcentrado: Double;
  fltVolumeDiluido: Double;
  fltVolumeTotal: Double;
  fltTotalGramas: Double;
  fltPesoEspFormula: Double;
  fltQtdDiluente: Double;
begin
  dicRetorno['linha'] := qryGen.FieldByName('DU2_LINHA_').AsString;

  Try
    strSQL := '';
    strSQL := strSQL + '  SELECT                  ';
    strSQL := strSQL + '    *                     ';
    strSQL := strSQL + '  FROM                    ';
    strSQL := strSQL + '    DU2_CADBAS B          ';
    strSQL := strSQL + '  INNER JOIN ITEGER G ON         ';
    strSQL := strSQL + '    G.ITE_CODITE = B.BAS_CODITE AND         ';
    strSQL := strSQL + '    G.ITE_CODEMP = "' + VS_strCodEmp + '"   ';
    strSQL := strSQL + '  INNER JOIN CADITE I ON         ';
    strSQL := strSQL + '    I.ITE_CODITE =  G.ITE_CODITE            ';
    strSQL := strSQL + '  WHERE                   ';
    strSQL := strSQL + '    BAS_CODBAS = :CODBAS        ';


    qryDiluente := fCriaQuery();
    qryDiluente.Close;
    qryDiluente.SQL.Clear;
    qryDiluente.SQL.Add(strSQL);
    qryDiluente.ParamByName('CODBAS').AsString := stlDiluentes[intTipo];
    qryDiluente.Open;

    If qryDiluente.IsEmpty Then
      Exit;

    If qryGen.FieldByName('DU2_LINHA_').AsString <> '1ST' Then
    Begin
      If Not cdsEmbalagens.Locate('CFG_CODCFG', 'MINDIL', []) Then
        Exit;

      //Calculando o volume das bases concentrada;
      fltVolumeConcentrado := fCalculaVolumeTotal(qryGen, qryBases, dicRetorno);
      fltVolumeTotal := 1000;
      fltQtdDiluente := fRetQtdDiluente(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString, qryDiluente.FieldByName('BAS_PESESP').AsFloat);
      fltVolumeDiluido := fltVolumeConcentrado + fltQtdDiluente;
      fltVolumeTotal := fltVolumeTotal + (StrToFloat(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString) * 10);
      fltPesoEspFormula := fFormataFloat(fltVolumeDiluido / fltVolumeTotal, 5);
      fltTotalGramas := 1000 * fltPesoEspFormula;

      //Aplicando a taxa de diluicao
      For intContador := 1 To fQuantidadeFormulacao () Do
      Begin

        If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intContador, 2)], ''))) Then
          Break;

        If (Not qryBases.Locate('BAS_CODBAS', dicRetorno['base' + fStrZero(intContador, 2)], [])) Then
          Break;

        dicRetorno['qtdb' + fStrZero(intContador, 2)] := qryGen.FieldByName('DU2_QTDC' + fStrZero(intContador, 2)).AsFloat;
        dicRetorno['qtdd' + fStrZero(intContador, 2)] := fFormataFloat((qryGen.FieldByName('DU2_QTDC' + fStrZero(intContador, 2)).AsFloat * fltTotalGramas) / fltVolumeDiluido, intDecFor);
      End;

      DiluenteUltimaPosicao(qryBases, dicRetorno, fltQtdDiluente, fltTotalGramas, fltVolumeDiluido, cdsEmbalagens.FieldByName('CFG_VALCFG').AsString);
    End
    Else
    Begin
      fltVolumeConcentrado := fCalculaVolumeTotal(qryGen, qryBases, dicRetorno);
      fltVolumeTotal := 1100;
      fltQtdDiluente := 100 * qryDiluente.FieldByName('BAS_PESESP').AsFloat;
      fltVolumeDiluido := fltVolumeConcentrado + fltQtdDiluente;
      fltPesoEspFormula := fFormataFloat(fltVolumeDiluido / fltVolumeTotal, 5);
      fltTotalGramas := 1000 * fltPesoEspFormula;

      //Aplicando a taxa de diluicao
      For intContador := 1 To fQuantidadeFormulacao () Do
      Begin

        If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intContador, 2)], ''))) Then
          Break;

        If (Not qryBases.Locate('BAS_CODBAS', dicRetorno['base' + fStrZero(intContador, 2)], [])) Then
          Break;

        dicRetorno['qtdb' + fStrZero(intContador, 2)] := qryGen.FieldByName('DU2_QTDC' + fStrZero(intContador, 2)).AsFloat;
        dicRetorno['qtdd' + fStrZero(intContador, 2)] := fFormataFloat((qryGen.FieldByName('DU2_QTDC' + fStrZero(intContador, 2)).AsFloat * fltTotalGramas) / fltVolumeDiluido, intDecFor);
      End;

      DiluenteUltimaPosicao(qryBases, dicRetorno, fltQtdDiluente, fltTotalGramas, fltVolumeDiluido, '10');
    End;
  Finally
    FreeAndNil(qryDiluente);
  End;
end;

procedure TExportaTintometricosTerceirosDuxone2.pRetPrecosAdicionais(
  dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery;
  fltPerAcr: Double);
var
  intContador: Integer;
  intPreVen: Integer;
  fltPrecoVendaTotalCon,
  fltPrecoVendaTotalDil,
  fltPrecoCustoTotalCon,
  fltPrecoCustoTotalDil,
  fltPrecoEmbalagem: Double;
  strTabelaUnica: String;
  strCodCli, strCodCnd: String;
  intEmb: Integer;
  strCamEmb: String;
  strEmb: String;
begin
  strCodCli          := '';
  strCodCnd          := '';

  strTabelaUnica := dicRetorno['tabelaunica'];
  SetLength(arrPrecosPorEmb, Length(arrEmbalagens));

  dicPrecoAdicional.Limpar;

  For intEmb := 0 To Length(arrEmbalagens) - 1 Do
  Begin
    strCamEmb := fRetornaCampoEmbalagem(arrEmbalagens[intEmb].strSigEmb, dicRetorno);
    strEmb := arrEmbalagens[intEmb].strSigEmb;

    If (Not cdsEmbalagens.Locate('CFG_CODCFG', strCamEmb, [])) Then
      Continue;

    If fEmptyStr(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString) Then
      Continue;

    Try
      SetLength(ArrComponentes, fQuantidadeFormulacao);

      //Adiciona a formulacao no array
      For intContador := 1 To fQuantidadeFormulacao Do
      Begin
        If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intContador, 2)], ''))) Then
          Break;

        If (Not qryBases.Locate('BAS_CODBAS', dicRetorno['base' + fStrZero(intContador, 2)], [])) Then
          Break;

        ArrComponentes[intContador].Componente := dicRetorno['base' + fStrZero(intContador, 2)];
        ArrComponentes[intContador].Quantidade := ((dicRetorno['qtdb' + fStrZero(intContador, 2)] * arrEmbalagens[intEmb].fltVolume) / 1);
        ArrComponentes[intContador].Quantiddil := ((IfNull(dicRetorno['qtdd' + fStrZero(intContador, 2)], 0) * arrEmbalagens[intEmb].fltVolume) / 1);
      End;

      For intPreVen := 1 To 7 Do
      Begin
        If stlTabPre[intPreVen] <> 'S' Then
          Continue;

        fltPrecoVendaTotalCon := fCalculaPrecoVendaConcentrado1a7(qryBases, strTabelaUnica, intPreVen);
        fltPrecoVendaTotalDil := fCalculaPrecoVendaDiluido1a7(qryBases, strTabelaUnica, intPreVen);
        fltPrecoEmbalagem := fCalculaPrecoEmbalagem1a7(fltPerAcr, strTabelaUnica, strCamEmb, intPreVen);

        //Preco de venda concentrado
        fltPrecoVendaTotalCon := fRetornaPrecoConcentrado(fltPrecoVendaTotalCon, fltPerAcr, fltPrecoEmbalagem);

        //Preco de venda diluido
        fltPrecoVendaTotalDil := fRetornaPrecoDiluido(fltPrecoVendaTotalDil, fltPerAcr, fltPrecoEmbalagem);

        dicPrecoAdicional['PREVE' + IntToStr(intPreVen) + '_CON' + strEmb] := fltPrecoVendaTotalCon;
        dicPrecoAdicional['PREVE' + IntToStr(intPreVen) + '_DIL' + strEmb] := fltPrecoVendaTotalDil;
      End;

      //Calcula o preco de custo
      fltPrecoCustoTotalCon := fCalculaPrecoCustoConcentrado(qryBases, strTabelaUnica);
      fltPrecoCustoTotalDil := fCalculaPrecoCustoDiluido(qryBases, strTabelaUnica);
      fltPrecoEmbalagem := fCalculaPrecoCustoEmbalagem(fltPerAcr, strTabelaUnica, strCamEmb);

      fltPrecoCustoTotalCon := fRetornaPrecoCustoConcentrado(fltPrecoCustoTotalCon, fltPrecoEmbalagem);
      fltPrecoCustoTotalDil := fRetornaPrecoCustoDiluido(fltPrecoCustoTotalDil, fltPrecoEmbalagem);

      dicPrecoAdicional['PRECUS_CON' + strEmb] := fltPrecoCustoTotalCon;
      dicPrecoAdicional['PRECUS_DIL' + strEmb] := fltPrecoCustoTotalDil;
    Finally
      SetLength(arrComponentes, 0);
    End;
  End;
end;

procedure TExportaTintometricosTerceirosDuxone2.pRetPrecoTintas(
  dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery;
  fltPerAcr: Double);
Var
  intContador: Integer;
  fltPrecoVendaTotalCon,
  fltPrecoVendaTotalDil,
  fltPrecoEmbalagem: Double;
  strTabelaUnica: String;
  intEmb: Integer;
  strCamEmb: String;
begin
  strTabelaUnica := dicRetorno['tabelaunica'];

  SetLength(arrPrecosPorEmb, Length(arrEmbalagens));

  //fazer o for das embalagens aqui
  For intEmb := 0 To Length(arrEmbalagens) - 1 Do
  Begin

    strCamEmb := fRetornaCampoEmbalagem(arrEmbalagens[intEmb].strSigEmb, dicRetorno);

    //Verificar se existe a embalagem
    If (Not cdsEmbalagens.Locate('CFG_CODCFG', strCamEmb, [])) Then
      Continue;

    //Verificar se existe produto vinculado
    If fEmptyStr(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString) Then
      Continue;

    Try
      SetLength(ArrComponentes, fQuantidadeFormulacao);

      //Adiciona a formulacao no array
      For intContador := 1 To fQuantidadeFormulacao Do
      Begin
        If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intContador, 2)], ''))) Then
          Break;

        If (Not qryBases.Locate('BAS_CODBAS', dicRetorno['base' + fStrZero(intContador, 2)], [])) Then
          Break;

        ArrComponentes[intContador].Componente := dicRetorno['base' + fStrZero(intContador, 2)];
        ArrComponentes[intContador].Quantidade := ((dicRetorno['qtdb' + fStrZero(intContador, 2)] * arrEmbalagens[intEmb].fltVolume) / 1);
        ArrComponentes[intContador].Quantiddil := ((IfNull(dicRetorno['qtdd' + fStrZero(intContador, 2)], 0) * arrEmbalagens[intEmb].fltVolume) / 1);
      End;

      fltPrecoVendaTotalCon := fCalculaPrecoVendaConcentrado(qryBases, strTabelaUnica);
      fltPrecoVendaTotalDil := fCalculaPrecoVendaDiluido(qryBases, strTabelaUnica);
      fltPrecoEmbalagem := fCalculaPrecoEmbalagem(fltPerAcr, strTabelaUnica, strCamEmb);

      //Preco de venda concentrado
      fltPrecoVendaTotalCon := fRetornaPrecoConcentrado(fltPrecoVendaTotalCon, fltPerAcr, fltPrecoEmbalagem);

      //Preco de venda diluido
      fltPrecoVendaTotalDil := fRetornaPrecoDiluido(fltPrecoVendaTotalDil, fltPerAcr, fltPrecoEmbalagem);

      //Adiciona informacoes no array para gravar
      arrPrecosPorEmb[intEmb].strSigEmb := arrEmbalagens[intEmb].strSigEmb;
      arrPrecosPorEmb[intEmb].fltValCon := fltPrecoVendaTotalCon;
      arrPrecosPorEmb[intEmb].fltValDil := fltPrecoVendaTotalDil;
      arrPrecosPorEmb[intEmb].strIteEmb := cdsEmbalagens.FieldByName('CFG_VALCFG').AsString;
      arrPrecosPorEmb[intEmb].fltPreEmb := fltPrecoEmbalagem;
      arrPrecosPorEmb[intEmb].strCodDil := fRetornaCodigoDiluente(dicRetorno);
      arrPrecosPorEmb[intEmb].fltPorDil := fRetornaPorcentagemDiluente(dicRetorno);
    Finally
      SetLength(ArrComponentes, 0);
    End;
  End;

  pRetPrecosAdicionais(dicRetorno, qryColorantes, qryBases, fltPerAcr);
end;

procedure TExportaTintometricosTerceirosDuxone2.pRetTabelasPreco(
  Conexao: TUniConnection);
Var
  qryGen: TUniQuery;
  strSQL: String;
  intContador: Integer;
begin
  Try
    strSQL := '';
    strSQL := strSQL + '  SELECT                ';
    strSQL := strSQL + '    SIS_VALCFG          ';
    strSQL := strSQL + '  FROM                  ';
    strSQL := strSQL + '    CFGSIS              ';
    strSQL := strSQL + '  WHERE                 ';
    strSQL := strSQL + '    SIS_CODEMP = "' + VS_strCodEmp + '" AND       ';
    strSQL := strSQL + '    SIS_CODCFG = "CFG_TABPRC"   AND               ';
    strSQL := strSQL + '    SIS_GRUCFG = "PRODUTOS"                       ';

    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.Open;

    strCfgPre := qryGen.FieldByName('SIS_VALCFG').AsString;
    stlTabPre.Clear;
    stlTabPre.Add(strCfgPre);

    For intContador := 1 To 7 Do
      stlTabPre.Add(Copy(strCfgPre, intContador, 1));
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TExportaTintometricosTerceirosDuxone2.pSetaParametrosEspecificos(
  Conexao: TUniConnection);
begin
  pCriaClientEmbalagem(Conexao);
  strProDU2 := fRetItemVenda(Conexao);
  pRetTabelasPreco(Conexao);

  If Not cdsEmbalagens.Locate('CFG_CODCFG', 'DECFOR', []) Then
    Exit;

  intDecFor := cdsEmbalagens.FieldByName('CFG_VALCFG').AsInteger;
end;

{$IFDEF LINUX}
procedure TExportaTintometricosTerceirosDuxone2.pValidarPrecoExportacaoDuxone2(AMd5Key,
  AEmbPro, AModVen, ASigEmb: string; fltPreVen: Double; dicPrecos: TDicionario;
  APrefix: String; ADiluente: String);
var
  LValInfo: TValidateInf;
begin
  LValInfo.strIdePro := FIdePro;
  LValInfo.strMD5Key := AMd5Key;
  LValInfo.strEmbPro := AEmbPro;
  LValInfo.strTabPre := fRetornaTabelaPreco;
  LValInfo.strModVen := AModVen;
  LValInfo.fltPreVen := fltPreVen;
  LValInfo.strCodDil := ADiluente;
  LValInfo.fltPreCus := IfNull(dicPrecos['PRECUS' + APrefix + ASigEmb], 0.0);
  LValInfo.fltPreVe1 := IfNull(dicPrecos['PREVE1' + APrefix + ASigEmb], 0.0);
  LValInfo.fltPreVe2 := IfNull(dicPrecos['PREVE2' + APrefix + ASigEmb], 0.0);
  LValInfo.fltPreVe3 := IfNull(dicPrecos['PREVE3' + APrefix + ASigEmb], 0.0);
  LValInfo.fltPreVe4 := IfNull(dicPrecos['PREVE4' + APrefix + ASigEmb], 0.0);
  LValInfo.fltPreVe5 := IfNull(dicPrecos['PREVE5' + APrefix + ASigEmb], 0.0);
  LValInfo.fltPreVe6 := IfNull(dicPrecos['PREVE6' + APrefix + ASigEmb], 0.0);
  LValInfo.fltPreVe7 := IfNull(dicPrecos['PREVE7' + APrefix + ASigEmb], 0.0);
  pValidacaoFormula(LValInfo, VS_strCodEmp);
end;
{$ENDIF}

function TExportaTintometricosTerceirosDuxone2.RepetirPorTipo: Integer;
begin
  Result := stlDiluentes.Count;
end;

end.
