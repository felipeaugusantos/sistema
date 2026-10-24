unit untExportaTintometricosTerceirosAutoluks;

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
  untThreadExportacaoTerceiros, DateUtils,
  untExportaTintometricosTerceirosAutomotiva, DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.UI;

Type
  TExportaTintometricosTerceirosAutoluks = Class(TExportaTintometricosTerceirosAutomotiva)
  Private
    ArrComponentes: Array of TComp; //TArrComponentes;
    strProALK: String; //Produto de venda Autoluks
    stlDiluentes: TStringList;
    strAcrMob: String;
    function fRetValorAcrMobCfgTin(): String;
    function fValorQuantidade(fltValor: Double; fltAcrMob: Double): Double;
    function fCalculaVolumeTotal(qryGen, QryBases: TUniQuery; dicRetorno: TDicionario): Double;
    procedure DiluenteUltimaPosicao(qryBases: TUniQuery; dicRetorno: TDicionario; fltParteDiluido: Double);
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

    function fRetEmbalagemLT(): String;
    function fRetEmbalagemGL(): String;
    function fRetEmbalagemLA(): String;
    function fRetItemVenda(Conexao: TUniConnection): String;
    function fRetQtdDiluente(fltVolumePro: Double; strCodDil: String; strPercentual:String = '54'): Double;

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

{ TExportaTintometricosTerceirosAutoluks }

constructor TExportaTintometricosTerceirosAutoluks.Create(
  pgbProgresso: TcxProgressBar; strIdePro: String; blnAuto: Boolean);
begin
  inherited;
  strProALK := '';
  pPreencheEmbalagens;
  pCarregarDados;
  dicPrecoAdicional := TDicionario.Create();
  stlTabPre := TStringList.Create();
  strAcrMob := fRetValorAcrMobCfgTin();
end;

destructor TExportaTintometricosTerceirosAutoluks.Destroy;
begin
  inherited;

  If Assigned(stlDiluentes) Then
    FreeAndNil(stlDiluentes);

  If Assigned(dicPrecoAdicional) Then
    FreeAndNil(dicPrecoAdicional);

  If Assigned(stlTabPre) Then
    FreeAndNil(stlTabPre);
end;

procedure TExportaTintometricosTerceirosAutoluks.DiluenteUltimaPosicao(
  qryBases: TUniQuery; dicRetorno: TDicionario; fltParteDiluido: Double);
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
      dicRetorno['qtdd' + fStrZero(intContador, 2)] := fltParteDiluido * qryBases.FieldByName('BAS_PESESP').AsFloat;

      dicRetorno['coddil'] := stlDiluentes[intTipo];
      dicRetorno['pordil'] := 54;
      Break;
    End;
  End;
end;

procedure TExportaTintometricosTerceirosAutoluks.Execute;
begin
  inherited;
end;

function TExportaTintometricosTerceirosAutoluks.fCalculaPrecoCustoConcentrado(
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

function TExportaTintometricosTerceirosAutoluks.fCalculaPrecoCustoDiluido(
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

function TExportaTintometricosTerceirosAutoluks.fCalculaPrecoCustoEmbalagem(
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

function TExportaTintometricosTerceirosAutoluks.fCalculaPrecoEmbalagem(
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

function TExportaTintometricosTerceirosAutoluks.fCalculaPrecoEmbalagem1a7(
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

function TExportaTintometricosTerceirosAutoluks.fCalculaPrecoVendaConcentrado(qryBases: TUniQuery; strTabelaUnica: String): Double;
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

function TExportaTintometricosTerceirosAutoluks.fCalculaPrecoVendaConcentrado1a7(
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

function TExportaTintometricosTerceirosAutoluks.fCalculaPrecoVendaDiluido(
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

function TExportaTintometricosTerceirosAutoluks.fCalculaPrecoVendaDiluido1a7(
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

function TExportaTintometricosTerceirosAutoluks.fCalculaVolumeTotal(qryGen,
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

    fltVolumeAtual := fltVolumeAtual + (qryGen.FieldByName('ALK_QTDC' + fStrZero(intContador, 2)).AsFloat / qryBases.FieldByName('BAS_PESESP').AsFloat);
  End;

  Result := 1000;
end;

function TExportaTintometricosTerceirosAutoluks.fCamposSelect: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                  ';
  Result := Result + '    ALK_CODIGO,           ';
  Result := Result + '    ALK_DESCRI,           ';
  Result := Result + '    ALK_PRODUT,           ';
  Result := Result + '    ALK_ACABAM,           ';
  Result := Result + '    ALK_VARIAN,           ';
  Result := Result + '    ALK_CORMON,           ';
  Result := Result + '    ALK_ANOINI,           ';
  Result := Result + '    ALK_ANOFIN,           ';
  Result := Result + '    ALK_DTACAD,           ';
  Result := Result + '    ALK_VOLUME,           ';
  Result := Result + '    ALK_VARIAN,           ';
  Result := Result + '    ALK_GRAMA_,           ';
  Result := Result + '    ALK_ACRMOB,           ';

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    Result := Result + '    ALK_BASE' + fStrZero(intContador, 2) + ',     ';
    Result := Result + '    ALK_QTDC' + fStrZero(intContador, 2) + ',     ';
  End;

  Result := Result + '    ALK_MD5KEY            ';
  Result := Result + '  FROM                    ';
  Result := Result + '    ALK_CADALK            ';
  Result := Result + '  WHERE                   ';
  Result := Result + '    TRUE;                 ';
end;

function TExportaTintometricosTerceirosAutoluks.fCamposTabela: String;
begin
  Result := '';
  Result := Result + '  CREATE TABLE    ' + fNomeTabela() + '   (     ';
  Result := Result + '    ALK_CODIGO VARCHAR(15),         ';
  Result := Result + '    ALK_DESCRI VARCHAR(50),         ';
  Result := Result + '    ALK_PRODUT VARCHAR(50),         ';
  Result := Result + '    ALK_ACABAM VARCHAR(50),         ';
  Result := Result + '    ALK_VARIAN VARCHAR(25),         ';
  Result := Result + '    ALK_ANOINI VARCHAR(4),          ';
  Result := Result + '    ALK_ANOFIN VARCHAR(4),          ';
  Result := Result + '    ALK_CORMON VARCHAR(30),         ';
  Result := Result + '    ALK_VOLUME DECIMAL(12,4),       ';
  Result := Result + '    ALK_GRAMA_ DECIMAL(12,4),       ';
  Result := Result + '    ALK_MD5KEY VARCHAR(32),         ';
  Result := Result + '    ALK_CODITE VARCHAR(5),          ';
  Result := Result + '    ALK_CODDIL VARCHAR(20),         ';
  Result := Result + '    ALK_PORDIL DECIMAL(12,4),       ';
  Result := Result + '    ALK_PRECLT DECIMAL(12,4),       ';
  Result := Result + '    ALK_PRECGL DECIMAL(12,4),       ';
  Result := Result + '    ALK_PRECLA DECIMAL(12,4),       ';
  Result := Result + '    ALK_PREDLT DECIMAL(12,4),       ';
  Result := Result + '    ALK_PREDGL DECIMAL(12,4),       ';
  Result := Result + '    ALK_PREDLA DECIMAL(12,4),       ';

  Result := Result + '    ALK_PCUCLT DECIMAL(12,4),       ';
  Result := Result + '    ALK_PCUCGL DECIMAL(12,4),       ';
  Result := Result + '    ALK_PCUCLA DECIMAL(12,4),       ';

  Result := Result + '    ALK_PCUDLT DECIMAL(12,4),       ';
  Result := Result + '    ALK_PCUDGL DECIMAL(12,4),       ';
  Result := Result + '    ALK_PCUDLA DECIMAL(12,4),       ';

  Result := Result + '    ALK_PRCLT1 DECIMAL(12,4),       ';
  Result := Result + '    ALK_PRCLT2 DECIMAL(12,4),       ';
  Result := Result + '    ALK_PRCLT3 DECIMAL(12,4),       ';
  Result := Result + '    ALK_PRCLT4 DECIMAL(12,4),       ';
  Result := Result + '    ALK_PRCLT5 DECIMAL(12,4),       ';
  Result := Result + '    ALK_PRCLT6 DECIMAL(12,4),       ';
  Result := Result + '    ALK_PRCLT7 DECIMAL(12,4),       ';

  Result := Result + '    ALK_PRDLT1 DECIMAL(12,4),       ';
  Result := Result + '    ALK_PRDLT2 DECIMAL(12,4),       ';
  Result := Result + '    ALK_PRDLT3 DECIMAL(12,4),       ';
  Result := Result + '    ALK_PRDLT4 DECIMAL(12,4),       ';
  Result := Result + '    ALK_PRDLT5 DECIMAL(12,4),       ';
  Result := Result + '    ALK_PRDLT6 DECIMAL(12,4),       ';
  Result := Result + '    ALK_PRDLT7 DECIMAL(12,4),       ';

  Result := Result + '    ALK_PRCGL1 DECIMAL(12,4),       ';
  Result := Result + '    ALK_PRCGL2 DECIMAL(12,4),       ';
  Result := Result + '    ALK_PRCGL3 DECIMAL(12,4),       ';
  Result := Result + '    ALK_PRCGL4 DECIMAL(12,4),       ';
  Result := Result + '    ALK_PRCGL5 DECIMAL(12,4),       ';
  Result := Result + '    ALK_PRCGL6 DECIMAL(12,4),       ';
  Result := Result + '    ALK_PRCGL7 DECIMAL(12,4),       ';

  Result := Result + '    ALK_PRDGL1 DECIMAL(12,4),       ';
  Result := Result + '    ALK_PRDGL2 DECIMAL(12,4),       ';
  Result := Result + '    ALK_PRDGL3 DECIMAL(12,4),       ';
  Result := Result + '    ALK_PRDGL4 DECIMAL(12,4),       ';
  Result := Result + '    ALK_PRDGL5 DECIMAL(12,4),       ';
  Result := Result + '    ALK_PRDGL6 DECIMAL(12,4),       ';
  Result := Result + '    ALK_PRDGL7 DECIMAL(12,4),       ';

  Result := Result + '    ALK_PRCLA1 DECIMAL(12,4),       ';
  Result := Result + '    ALK_PRCLA2 DECIMAL(12,4),       ';
  Result := Result + '    ALK_PRCLA3 DECIMAL(12,4),       ';
  Result := Result + '    ALK_PRCLA4 DECIMAL(12,4),       ';
  Result := Result + '    ALK_PRCLA5 DECIMAL(12,4),       ';
  Result := Result + '    ALK_PRCLA6 DECIMAL(12,4),       ';
  Result := Result + '    ALK_PRCLA7 DECIMAL(12,4),       ';

  Result := Result + '    ALK_PRDLA1 DECIMAL(12,4),       ';
  Result := Result + '    ALK_PRDLA2 DECIMAL(12,4),       ';
  Result := Result + '    ALK_PRDLA3 DECIMAL(12,4),       ';
  Result := Result + '    ALK_PRDLA4 DECIMAL(12,4),       ';
  Result := Result + '    ALK_PRDLA5 DECIMAL(12,4),       ';
  Result := Result + '    ALK_PRDLA6 DECIMAL(12,4),       ';
  Result := Result + '    ALK_PRDLA7 DECIMAL(12,4),       ';

  Result := Result + '    ALK_EMBALT VARCHAR(5),          ';
  Result := Result + '    ALK_EMBAGL VARCHAR(5),          ';
  Result := Result + '    ALK_EMBALA VARCHAR(5),          ';
  Result := Result + '    ALK_VOLULT DECIMAL(12,4),       ';
  Result := Result + '    ALK_VOLUGL DECIMAL(12,4),       ';
  Result := Result + '    ALK_VOLULA DECIMAL(12,4),       ';
  Result := Result + '    ALK_PREELT DECIMAL(12,4),       ';
  Result := Result + '    ALK_PREEGL DECIMAL(12,4),       ';
  Result := Result + '    ALK_PREELA DECIMAL(12,4),       ';
  Result := Result + '    ALK_TIPOLT CHAR(2),             ';
  Result := Result + '    ALK_TIPOGL CHAR(2),             ';
  Result := Result + '    ALK_TIPOLA CHAR(2)              ';
  Result := Result + '            );                                  ';
end;

function TExportaTintometricosTerceirosAutoluks.fFatorTinta: Double;
begin
  Result := 0;
end;

function TExportaTintometricosTerceirosAutoluks.fNomeTabela: String;
begin
  Result := 'ALK_CADALK_SIT';
end;

function TExportaTintometricosTerceirosAutoluks.fQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TExportaTintometricosTerceirosAutoluks.fRetDescricao: String;
begin
  Result := 'ALK_DESCRI';
end;

function TExportaTintometricosTerceirosAutoluks.fRetEmbalagem(
  qryColorantes: TUniQuery): Double;
begin
    Result := qryColorantes.FieldByName('BAS_EMBALA').AsFloat * qryColorantes.FieldByName('BAS_PESESP').AsFloat;
end;

function TExportaTintometricosTerceirosAutoluks.fRetEmbalagemLA: String;
begin
  Result := 'LATEMB';
end;

function TExportaTintometricosTerceirosAutoluks.fRetEmbalagemGL: String;
begin
  Result := 'GALEMB';
end;

function TExportaTintometricosTerceirosAutoluks.fRetEmbalagemLT: String;
begin
  Result := 'LITEMB';
end;

function TExportaTintometricosTerceirosAutoluks.fRetFormula(
  intCont: Integer): String;
begin
  Result := 'ALK_BASE' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosAutoluks.fRetItemBase: String;
begin
  Result := '';
end;

function TExportaTintometricosTerceirosAutoluks.fRetItemVenda(
  Conexao: TUniConnection): String;
Var
  qryGen: TUniQuery;
  strSQL: String;
begin
  Try
    strSQL := '';
    strSQL := strSQL + '  SELECT                  ';
    strSQL := strSQL + '    CFG_VALCFG            ';
    strSQL := strSQL + '  FROM                    ';
    strSQL := strSQL + '    CFGTIN                ';
    strSQL := strSQL + '  WHERE                   ';
    strSQL := strSQL + '    CFG_IDEPRO = "ALK" AND                  ';
    strSQL := strSQL + '    CFG_CODCFG = "ALKPRO" AND               ';
    strSQL := strSQL + '    CFG_CODEMP = "' + VS_strCodEmp + '"     ';

    qryGen := fCriaQuery(Nil, Conexao);
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.Open;

    Result := qryGen.FieldByName('CFG_VALCFG').AsString;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosAutoluks.fRetMD5KEY: String;
begin
  Result := 'ALK_MD5KEY';
end;

function TExportaTintometricosTerceirosAutoluks.fRetornaBases: String;
begin
  Result := '';
  Result := Result + '  SELECT                    ';
  Result := Result + '    BAS_CODBAS,             ';
  Result := Result + '    BAS_CODITE,             ';
  Result := Result + '    BAS_EMBALA,             ';
  Result := Result + '    BAS_PESESP,             ';
  Result := Result + '    ITE_PREVE' + fRetornaTabelaPreco + ' AS ITE_PREVEN,        ';
  Result := Result + '   G.ITE_PRECUS AS PRECUS,      ';
  Result := Result + '   G.ITE_PREVE1 AS PREVE1,      ';
  Result := Result + '   G.ITE_PREVE2 AS PREVE2,      ';
  Result := Result + '   G.ITE_PREVE3 AS PREVE3,      ';
  Result := Result + '   G.ITE_PREVE4 AS PREVE4,      ';
  Result := Result + '   G.ITE_PREVE5 AS PREVE5,      ';
  Result := Result + '   G.ITE_PREVE6 AS PREVE6,      ';
  Result := Result + '   G.ITE_PREVE7 AS PREVE7       ';
  Result := Result + '  FROM                      ';
  Result := Result + '    ALK_CADBAS B            ';
  Result := Result + '  INNER JOIN CADITE I ON          ';
  Result := Result + '    B.BAS_CODITE = I.ITE_CODITE               ';
  Result := Result + '  INNER JOIN ITEGER G ON          ';
  Result := Result + '    I.ITE_CODITE = G.ITE_CODITE               ';
  Result := Result + '  WHERE                     ';
  Result := Result + '    G.ITE_CODEMP = "' + VS_strCodEmp + '"     ';
end;

function TExportaTintometricosTerceirosAutoluks.fRetornaCampoEmbalagem(
  strSigEmb: String; dicRetorno: TDicionario): String;
begin
  Result := '';

  If strSigEmb = 'LT' Then
    Result := fRetEmbalagemLT()
  Else If strSigEmb = 'GL' Then
    Result := fRetEmbalagemGL()
  Else If strSigEmb = 'LA' Then
    Result := fRetEmbalagemLA();
end;

function TExportaTintometricosTerceirosAutoluks.fRetornaCodigoDiluente(
  dicRetorno: TDicionario): String;
begin
  Result := IfNull(dicRetorno['coddil'], '');
end;

function TExportaTintometricosTerceirosAutoluks.fRetornaColorantes: String;
begin
  Result := '';
end;

function TExportaTintometricosTerceirosAutoluks.fRetornaPercentualAcrescimo(
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
    strSQL := strSQL + '    CFG_IDEPRO = "ALK" AND                ';
    strSQL := strSQL + '    CFG_CODCFG = "APREVE" AND             ';
    strSQL := strSQL + '    CFG_CODEMP = "' + VS_strCodEmp + '"   ';

    qryGen := fCriaQuery(Nil, Conexao);
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

function TExportaTintometricosTerceirosAutoluks.fRetornaPorcentagemDiluente(
  dicRetorno: TDicionario): Double;
begin
  Result := IfNull(dicRetorno['pordil'], 0);
end;

function TExportaTintometricosTerceirosAutoluks.fRetornaPrecoConcentrado(
  fltPrecoTotal, fltPerAcr, fltEmbalagem: Double): Double;
begin
  Result := 0;

  If fltPrecoTotal > 0 Then
    Result := fltPrecoTotal +
      (fltPerAcr * fltPrecoTotal) + fltEmbalagem;
end;

function TExportaTintometricosTerceirosAutoluks.fRetornaPrecoCustoConcentrado(
  fltPrecoTotal, fltEmbalagem: Double): Double;
begin
  Result := 0;

  If fltPrecoTotal > 0 Then
    Result := fltPrecoTotal + fltEmbalagem;
end;

function TExportaTintometricosTerceirosAutoluks.fRetornaPrecoCustoDiluido(
  fltPrecoTotal, fltEmbalagem: Double): Double;
begin
  Result := 0;

  If fltPrecoTotal > 0 Then
    Result := fltPrecoTotal + fltEmbalagem;
end;

function TExportaTintometricosTerceirosAutoluks.fRetornaPrecoDiluido(
  fltPrecoTotal, fltPerAcr, fltEmbalagem: Double): Double;
begin
  Result := 0;

  If fltPrecoTotal > 0 Then
    Result := fltPrecoTotal +
      (fltPerAcr * fltPrecoTotal) + fltEmbalagem;
end;

function TExportaTintometricosTerceirosAutoluks.fRetQtdDiluente(fltVolumePro: Double; strCodDil: String; strPercentual:String = '54'): Double;
begin
  Result := ((fltVolumePro * 1000) * StrToFloat(strPercentual)) / 100
end;

function TExportaTintometricosTerceirosAutoluks.fRetQuantidade(
  intCont: Integer): String;
begin
  Result := 'ALK_QTDC' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosAutoluks.fRetTipoCor: String;
begin
  Result := 'ALK_PRODUT';
end;

function TExportaTintometricosTerceirosAutoluks.fRetValorAcrMobCfgTin: String;
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' SELECT CFG_VALCFG               ');
    qryGen.SQL.Add('    FROM CFGTIN                  ');
    qryGen.SQL.Add(' WHERE CFG_IDEPRO = "ALK" AND    ');
    qryGen.SQL.Add('       CFG_CODCFG = "ACRMOB" AND ');
    qryGen.SQL.Add('       CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
    qryGen.Open;

    Result := qryGen.FieldByName('CFG_VALCFG').AsString;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosAutoluks.fSQLInsert: String;
begin
  Result := '';
  Result := Result + '  INSERT INTO   ' + fNomeTabela() + '   (     ';
  Result := Result + '    ALK_CODIGO,           ';
  Result := Result + '    ALK_DESCRI,           ';
  Result := Result + '    ALK_PRODUT,           ';
  Result := Result + '    ALK_ACABAM,           ';
  Result := Result + '    ALK_VARIAN,           ';
  Result := Result + '    ALK_CORMON,           ';
  Result := Result + '    ALK_ANOINI,           ';
  Result := Result + '    ALK_ANOFIN,           ';
  Result := Result + '    ALK_VOLUME,           ';
  Result := Result + '    ALK_GRAMA_,           ';
  Result := Result + '    ALK_MD5KEY,           ';
  Result := Result + '    ALK_CODITE,           ';
  Result := Result + '    ALK_CODDIL,           ';
  Result := Result + '    ALK_PORDIL,           ';
  Result := Result + '    ALK_PRECLT,           ';
  Result := Result + '    ALK_PRECGL,           ';
  Result := Result + '    ALK_PRECLA,           ';
  Result := Result + '    ALK_PREDLT,           ';
  Result := Result + '    ALK_PREDGL,           ';
  Result := Result + '    ALK_PREDLA,           ';
  Result := Result + '    ALK_PCUCLT,           ';
  Result := Result + '    ALK_PCUCGL,           ';
  Result := Result + '    ALK_PCUCLA,           ';
  Result := Result + '    ALK_PCUDLT,           ';
  Result := Result + '    ALK_PCUDGL,           ';
  Result := Result + '    ALK_PCUDLA,           ';
  Result := Result + '    ALK_PRCLT1,           ';
  Result := Result + '    ALK_PRCLT2,           ';
  Result := Result + '    ALK_PRCLT3,           ';
  Result := Result + '    ALK_PRCLT4,           ';
  Result := Result + '    ALK_PRCLT5,           ';
  Result := Result + '    ALK_PRCLT6,           ';
  Result := Result + '    ALK_PRCLT7,           ';
  Result := Result + '    ALK_PRDLT1,           ';
  Result := Result + '    ALK_PRDLT2,           ';
  Result := Result + '    ALK_PRDLT3,           ';
  Result := Result + '    ALK_PRDLT4,           ';
  Result := Result + '    ALK_PRDLT5,           ';
  Result := Result + '    ALK_PRDLT6,           ';
  Result := Result + '    ALK_PRDLT7,           ';
  Result := Result + '    ALK_PRCGL1,           ';
  Result := Result + '    ALK_PRCGL2,           ';
  Result := Result + '    ALK_PRCGL3,           ';
  Result := Result + '    ALK_PRCGL4,           ';
  Result := Result + '    ALK_PRCGL5,           ';
  Result := Result + '    ALK_PRCGL6,           ';
  Result := Result + '    ALK_PRCGL7,           ';
  Result := Result + '    ALK_PRDGL1,           ';
  Result := Result + '    ALK_PRDGL2,           ';
  Result := Result + '    ALK_PRDGL3,           ';
  Result := Result + '    ALK_PRDGL4,           ';
  Result := Result + '    ALK_PRDGL5,           ';
  Result := Result + '    ALK_PRDGL6,           ';
  Result := Result + '    ALK_PRDGL7,           ';
  Result := Result + '    ALK_PRCLA1,           ';
  Result := Result + '    ALK_PRCLA2,           ';
  Result := Result + '    ALK_PRCLA3,           ';
  Result := Result + '    ALK_PRCLA4,           ';
  Result := Result + '    ALK_PRCLA5,           ';
  Result := Result + '    ALK_PRCLA6,           ';
  Result := Result + '    ALK_PRCLA7,           ';
  Result := Result + '    ALK_PRDLA1,           ';
  Result := Result + '    ALK_PRDLA2,           ';
  Result := Result + '    ALK_PRDLA3,           ';
  Result := Result + '    ALK_PRDLA4,           ';
  Result := Result + '    ALK_PRDLA5,           ';
  Result := Result + '    ALK_PRDLA6,           ';
  Result := Result + '    ALK_PRDLA7,           ';
  Result := Result + '    ALK_EMBALT,           ';
  Result := Result + '    ALK_EMBAGL,           ';
  Result := Result + '    ALK_EMBALA,           ';
  Result := Result + '    ALK_VOLULT,           ';
  Result := Result + '    ALK_VOLUGL,           ';
  Result := Result + '    ALK_VOLULA,           ';
  Result := Result + '    ALK_PREELT,           ';
  Result := Result + '    ALK_PREEGL,           ';
  Result := Result + '    ALK_PREELA,           ';
  Result := Result + '    ALK_TIPOLT,           ';
  Result := Result + '    ALK_TIPOGL,           ';
  Result := Result + '    ALK_TIPOLA            ';
  Result := Result + '            )                                 ';
  Result := Result + '  VALUES        (                             ';
  Result := Result + '    :CODIGO,              ';
  Result := Result + '    :DESCRI,              ';
  Result := Result + '    :PRODUT,              ';
  Result := Result + '    :ACABAM,              ';
  Result := Result + '    :VARIAN,              ';
  Result := Result + '    :CORMON,              ';
  Result := Result + '    :ANOINI,              ';
  Result := Result + '    :ANOFIN,              ';
  Result := Result + '    :VOLUME,              ';
  Result := Result + '    :GRAMA_,              ';
  Result := Result + '    :MD5KEY,              ';
  Result := Result + '    :CODITE,              ';
  Result := Result + '    :CODDIL,              ';
  Result := Result + '    :PORDIL,              ';
  Result := Result + '    :PRECLT,              ';
  Result := Result + '    :PRECGL,              ';
  Result := Result + '    :PRECLA,              ';
  Result := Result + '    :PREDLT,              ';
  Result := Result + '    :PREDGL,              ';
  Result := Result + '    :PREDLA,              ';
  Result := Result + '    :PCUCLT,              ';
  Result := Result + '    :PCUCGL,              ';
  Result := Result + '    :PCUCLA,              ';
  Result := Result + '    :PCUDLT,              ';
  Result := Result + '    :PCUDGL,              ';
  Result := Result + '    :PCUDLA,              ';
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
  Result := Result + '    :EMBALT,              ';
  Result := Result + '    :EMBAGL,              ';
  Result := Result + '    :EMBALA,              ';
  Result := Result + '    :VOLULT,              ';
  Result := Result + '    :VOLUGL,              ';
  Result := Result + '    :VOLULA,              ';
  Result := Result + '    :PREELT,              ';
  Result := Result + '    :PREEGL,              ';
  Result := Result + '    :PREELA,              ';
  Result := Result + '    :TIPOLT,              ';
  Result := Result + '    :TIPOGL,              ';
  Result := Result + '    :TIPOLA               ';
  Result := Result + '            );                                ';
end;

function TExportaTintometricosTerceirosAutoluks.fValorQuantidade(fltValor,
  fltAcrMob: Double): Double;
begin
  If fltValor <= 0 Then
    Result := 0
  Else
    Result := fltValor + fltAcrMob;
end;

procedure TExportaTintometricosTerceirosAutoluks.pAdicionaParamentros(
  var DataSet: TFDQuery; qryTinta: TUniQuery; fltPreVen: Double; intParam: Integer = 0);
Var
  intContador: Integer;
  intEmb: Integer;
begin
  DataSet.ParamByName('CODIGO').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('ALK_CODIGO').AsString);
  DataSet.ParamByName('DESCRI').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('ALK_DESCRI').AsString);
  DataSet.ParamByName('PRODUT').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('ALK_PRODUT').AsString);
  DataSet.ParamByName('ACABAM').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('ALK_ACABAM').AsString);
  DataSet.ParamByName('VARIAN').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('ALK_VARIAN').AsString);
  DataSet.ParamByName('CORMON').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('ALK_CORMON').AsString);
  DataSet.ParamByName('ANOINI').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('ALK_ANOINI').AsString);
  DataSet.ParamByName('ANOFIN').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('ALK_ANOFIN').AsString);
  DataSet.ParamByName('VOLUME').AsFloats[intParam] := qryTinta.FieldByName('ALK_VOLUME').AsFloat;
  DataSet.ParamByName('GRAMA_').AsFloats[intParam] := qryTinta.FieldByName('ALK_GRAMA_').AsFloat;
  DataSet.ParamByName('MD5KEY').AsStrings[intParam] := qryTinta.FieldByName('ALK_MD5KEY').AsString;
  DataSet.ParamByName('CODITE').AsStrings[intParam] := strProALK;
  DataSet.ParamByName('PCUCLT').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONLT'], 0.0);
  DataSet.ParamByName('PCUCGL').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONGL'], 0.0);
  DataSet.ParamByName('PCUCLA').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONLA'], 0.0);
  DataSet.ParamByName('PCUDLT').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILLT'], 0.0);
  DataSet.ParamByName('PCUDGL').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILGL'], 0.0);
  DataSet.ParamByName('PCUDLA').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILLA'], 0.0);

  For intEmb := 0 To Length(arrEmbalagens) - 1 Do
  Begin
    If strAcrMob = '1' Then
    Begin
      arrPrecosPorEmb[intEmb].fltValCon := arrPrecosPorEmb[intEmb].fltValCon * (1 + qryTinta.FieldByName('ALK_ACRMOB').AsFloat / 100);
      arrPrecosPorEmb[intEmb].fltValDil := arrPrecosPorEmb[intEmb].fltValDil * (1 + qryTinta.FieldByName('ALK_ACRMOB').AsFloat / 100);
    End
    Else
    Begin
      arrPrecosPorEmb[intEmb].fltValCon := fValorQuantidade(arrPrecosPorEmb[intEmb].fltValCon, qryTinta.FieldByName('ALK_ACRMOB').AsFloat);
      arrPrecosPorEmb[intEmb].fltValDil := fValorQuantidade(arrPrecosPorEmb[intEmb].fltValDil, qryTinta.FieldByName('ALK_ACRMOB').AsFloat);
    End;
  End;

  For intContador := 1 To 7 Do
  Begin
    If stlTabPre[intContador] <> 'S' Then
    Begin
      DataSet.ParamByName('PRCLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLT'], 0.0);
      DataSet.ParamByName('PRDLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLT'], 0.0);
      DataSet.ParamByName('PRCGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONGL'], 0.0);
      DataSet.ParamByName('PRDGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILGL'], 0.0);
      DataSet.ParamByName('PRCLA' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLA'], 0.0);
      DataSet.ParamByName('PRDLA' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLA'], 0.0);
    End
    Else
    Begin
      If strAcrMob = '1' Then
      Begin
        DataSet.ParamByName('PRCLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLT'], 0.0) * (1 + qryTinta.FieldByName('ALK_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLT'], 0.0) * (1 + qryTinta.FieldByName('ALK_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONGL'], 0.0) * (1 + qryTinta.FieldByName('ALK_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILGL'], 0.0) * (1 + qryTinta.FieldByName('ALK_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCLA' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLA'], 0.0) * (1 + qryTinta.FieldByName('ALK_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDLA' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLA'], 0.0) * (1 + qryTinta.FieldByName('ALK_ACRMOB').AsFloat / 100);
      End
      Else
      Begin
        DataSet.ParamByName('PRCLT' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLT'], 0.0), qryTinta.FieldByName('ALK_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDLT' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLT'], 0.0), qryTinta.FieldByName('ALK_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCGL' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONGL'], 0.0), qryTinta.FieldByName('ALK_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDGL' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILGL'], 0.0), qryTinta.FieldByName('ALK_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCLA' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLA'], 0.0), qryTinta.FieldByName('ALK_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDLA' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLA'], 0.0), qryTinta.FieldByName('ALK_ACRMOB').AsFloat);
      End;
    End;
  End;
end;

procedure TExportaTintometricosTerceirosAutoluks.pCarregarDados;
Var
  qryDiluente: TUniQuery;
  strSQL: String;
begin
  stlDiluentes := TStringList.Create();
  stlDiluentes.Clear;

  strSQL := '';
  strSQL := strSQL + '  SELECT DISTINCT                   ';
  strSQL := strSQL + '    *                               ';
  strSQL := strSQL + '  FROM                              ';
  strSQL := strSQL + '    ALK_CADBAS B                    ';
  strSQL := strSQL + '  WHERE                             ';
  strSQL := strSQL + '    B.BAS_CODBAS = "ATL000"         ';

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

procedure TExportaTintometricosTerceirosAutoluks.pCriaClientEmbalagem(
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
    strSQL := strSQL + '    CFG_IDEPRO = "ALK" AND                  ';
    strSQL := strSQL + '    CFG_GRUCFG = "CONFIGURACOES" AND        ';
    strSQL := strSQL + '    CFG_CODEMP = "' + VS_strCodEmp + '"     ';

    qryEmb := fCriaQuery(Nil, Conexao);
    qryEmb.Close;
    qryEmb.SQL.Clear;
    qryEmb.SQL.Add(strSQL);
    qryEmb.Open;

    cdsEmbalagens := fCriaClientDatset(qryEmb, False, Nil, False);
  Finally
    FreeAndNil(qryEmb);
  End;
end;

procedure TExportaTintometricosTerceirosAutoluks.pGravaTintometricoPorTintaTerceiros(
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

procedure TExportaTintometricosTerceirosAutoluks.pIncluirLogTinSite(
  Conexao: TUniConnection; strStatus: String);
Var
  qryGen: TUniQuery;
  strSQL: String;
begin
  Try
    strSQL := '';
    strSQL := strSQL + '  DELETE FROM LOGTIN_SIT WHERE LOG_IDEPRO = "ALK"       ';

    qryGen := fCriaQuery(Nil, Conexao);
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
    strSQL := strSQL + '    "ALK",              ';
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

procedure TExportaTintometricosTerceirosAutoluks.pPreencheArrayEmbalagem;
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
end;

procedure TExportaTintometricosTerceirosAutoluks.pPreencheEmbalagens;
begin
  pPreencheArrayEmbalagem;
end;

procedure TExportaTintometricosTerceirosAutoluks.pProcessaTabelaCores(
  qryInsert: TFDQuery; qryGen, qryBases, qryColorantes: TUniQuery; strTabUni,
  strTabPre: String; fltPerAcr: Double; dicRetorno: TDicionario);
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
      qryInsert.Params.ArraySize := 500;
      intContador := 0;

    {$IFDEF LINUX}
      If VS_ExitProcessSignal Then
        Break;
    {$ENDIF}

      For intRegistros := 0 To Pred(500) Do
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
        pRecalculaFormula(dicRetorno, qryGen, qryBases);
        pRetornaPrecoTinta(dicRetorno, qryColorantes, qryBases, fltPerAcr);

      {$IFDEF LINUX}
        If FValidateIndexList.Contains(qryGen.RecNo) Then
        Begin
          For intEmb := 0 To Length(arrEmbalagens) - 1 Do
          Begin
            pValidarPrecoExportacao(qryGen.FieldByName(fRetMD5KEY).AsString,
                  arrEmbalagens[intEmb].strNomEmb, 'C', arrEmbalagens[intEmb].strSigEmb,
                  arrPrecosPorEmb[intEmb].fltValCon, dicPrecoAdicional, '_CON');

            If qryGen.FieldByName('ALK_PRODUT').AsString <> 'ATL SINTETICO'  Then
            Begin
              pValidarPrecoExportacao(qryGen.FieldByName(fRetMD5KEY).AsString,
                  arrEmbalagens[intEmb].strNomEmb, 'D', arrEmbalagens[intEmb].strSigEmb,
                  arrPrecosPorEmb[intEmb].fltValDil, dicPrecoAdicional, '_DIL');
            End;
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
      If Not fValidarPrecosCalculado(False, 999) Then
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

  {$IFDEF LINUX}
    fValidarPrecosCalculado(True);
  {$ENDIF}
  End;
end;

procedure TExportaTintometricosTerceirosAutoluks.pRecalculaFormula(
  dicRetorno: TDicionario; qryGen, qryBases: TUniQuery);
Var
  qryDiluente: TUniQuery;
  strSQL: String;
  fltVolumeAtual: Double;
  intContador: Integer;
  fltDiluicao, fltParteDiluida,
  fltParteCatalizador, fltParteTinta: Double;
  fltRedutor: Double;
begin
  If (qryGen.FieldByName('ALK_PRODUT').AsString = 'ATL SINTETICO') Then
  Begin
    For intContador := 1 To fQuantidadeFormulacao () Do
    Begin

      If fEmptyStr(qryGen.FieldByName(fRetFormula(intContador)).AsString) Then
        Break;

      dicRetorno['base' + fStrZero(intContador, 2)] := qryGen.FieldByName(fRetFormula(intContador)).AsString;
      dicRetorno['qtdb' + fStrZero(intContador, 2)] := qryGen.FieldByName(fRetQuantidade(intContador)).AsFloat;
    End;
  End;

  If (qryGen.FieldByName('ALK_PRODUT').AsString = 'ATL SINTETICO') Then
    Exit;

  Try
    Begin
      //Aplicando a taxa de diluicao
      fltDiluicao := 0.54;

      strSQL := '';
      strSQL := strSQL + '  SELECT                  ';
      strSQL := strSQL + '    *                     ';
      strSQL := strSQL + '  FROM                    ';
      strSQL := strSQL + '    ALK_CADBAS B          ';
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

      //Calculando o volume das bases concentrada;
      fltVolumeAtual := fCalculaVolumeTotal(qryGen, qryBases, dicRetorno);

      If qryGen.FieldByName('ALK_PRODUT').AsString = 'ATL PU' Then
      Begin
        fltParteCatalizador := fltVolumeAtual / 4;
        fltParteDiluida := fltVolumeAtual / 4;
        fltRedutor := fFormataFloat((fltVolumeAtual - fltParteCatalizador - fltParteDiluida) / fltVolumeAtual, 7);
      End
      Else
      Begin
        fltParteCatalizador := 0;
        fltParteTinta := fFormataFloat(fltVolumeAtual / (1 + fltParteCatalizador + (fltDiluicao * (1 + fltParteCatalizador))), 4);
        fltParteDiluida := fFormataFloat((fltParteTinta + fltParteCatalizador) * fltDiluicao, 4);
        fltRedutor := 0.6493507;
      End;


      //Aplicando a taxa de diluicao
      For intContador := 1 To fQuantidadeFormulacao () Do
      Begin

        If fEmptyStr(qryGen.FieldByName(fRetFormula(intContador)).AsString) Then
          Break;

        dicRetorno['base' + fStrZero(intContador, 2)] := qryGen.FieldByName(fRetFormula(intContador)).AsString;
        dicRetorno['qtdb' + fStrZero(intContador, 2)] := qryGen.FieldByName(fRetQuantidade(intContador)).AsFloat;
        dicRetorno['qtdd' + fStrZero(intContador, 2)] := qryGen.FieldByName(fRetQuantidade(intContador)).AsFloat * fltRedutor;
      End;

      DiluenteUltimaPosicao(qryBases, dicRetorno, fltParteDiluida);
    End;
  Finally
    FreeAndNil(qryDiluente);
  End;
end;

procedure TExportaTintometricosTerceirosAutoluks.pRetPrecosAdicionais(
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
        ArrComponentes[intContador].Quantidade := fFormataFloat(((dicRetorno['qtdb' + fStrZero(intContador, 2)] * arrEmbalagens[intEmb].fltVolume) / 1), 1);
        ArrComponentes[intContador].Quantiddil := fFormataFloat(((IfNull(dicRetorno['qtdd' + fStrZero(intContador, 2)], 0) * arrEmbalagens[intEmb].fltVolume) / 1), 1);
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

procedure TExportaTintometricosTerceirosAutoluks.pRetPrecoTintas(
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
        ArrComponentes[intContador].Quantidade := fFormataFloat(((dicRetorno['qtdb' + fStrZero(intContador, 2)] * arrEmbalagens[intEmb].fltVolume) / 1), 1);
        ArrComponentes[intContador].Quantiddil := fFormataFloat(((IfNull(dicRetorno['qtdd' + fStrZero(intContador, 2)], 0)* arrEmbalagens[intEmb].fltVolume) / 1), 1);
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

procedure TExportaTintometricosTerceirosAutoluks.pRetTabelasPreco(
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

    qryGen := fCriaQuery(Nil, Conexao);
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

procedure TExportaTintometricosTerceirosAutoluks.pSetaParametrosEspecificos(
  Conexao: TUniConnection);
begin
  pCriaClientEmbalagem(Conexao);
  strProALK := fRetItemVenda(Conexao);
  pRetTabelasPreco(Conexao);
end;

function TExportaTintometricosTerceirosAutoluks.RepetirPorTipo: Integer;
begin
  Result := stlDiluentes.Count;
end;

end.
