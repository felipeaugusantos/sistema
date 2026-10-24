unit untExportaTintometricosTerceirosLechler;

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
  untExportaTintometricosTerceirosAutomotiva,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.UI;

Type
  TExportaTintometricosTerceirosLechler = Class(TExportaTintometricosTerceirosAutomotiva)
  Private
    ArrComponentes: Array of TComp; //TArrComponentes;
    strProLEC: String; //Produto de venda Lechler
    strAcrMob: String;
    function fCalculaPrecoVendaConcentrado1a7(qryBases: TUniQuery; strTabelaUnica: String; intPreVen: Integer): Double;
    function fCalculaPrecoVendaDiluido1a7(qryBases: TUniQuery; strTabelaUnica: String; intPreVen: Integer): Double;
    function fCalculaPrecoEmbalagem1a7(fltPerAcr: Double; strTabelaUnica: String; strEmbalagem: String; intPreVen: Integer): Double;
    function fCalculaPrecoCustoConcentrado(qryBases: TUniQuery; strTabelaUnica: String): Double;
    function fCalculaPrecoCustoDiluido(qryBases: TUniQuery; strTabelaUnica: String): Double;
    function fCalculaPrecoCustoEmbalagem(fltPerAcr: Double; strTabelaUnica: String; strEmbalagem: String): Double;
    function fRetornaPrecoCustoConcentrado(fltPrecoTotal: Double; fltEmbalagem: Double): Double;
    function fRetornaPrecoCustoDiluido(fltPrecoTotal: Double; fltEmbalagem: Double): Double;
    function fCalculaPrecoVendaConcentrado(qryBases: TUniQuery; strTabelaUnica: String): Double;
    function fCalculaPrecoVendaDiluido(qryBases: TUniQuery; strTabelaUnica: String): Double;
    function fCalculaPrecoEmbalagem(fltPerAcr: Double; strTabelaUnica: String; strEmbalagem: String): Double;
    function fRetornaPrecoConcentrado(fltPrecoTotal: Double; fltPerAcr: Double; fltEmbalagem: Double): Double;
    function fRetornaPrecoDiluido(fltPrecoTotal: Double; fltPerAcr: Double; fltEmbalagem: Double): Double;
    function fValorQuantidade(fltValor: Double; fltAcrMob: Double): Double;
    function fRetValorAcrMobCfgTin(): String;
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

    procedure pAdicionaParamentros(Var DataSet: TFDQuery;
      qryTinta: TUniQuery; fltPreVen: Double; intParam: Integer = 0); Override;
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
    function fRetEmbalagemBD(): String;
    function fRetItemVenda(Conexao: TUniConnection): String;

    procedure pCriaClientEmbalagem(Conexao: TUniConnection);
    procedure pPreencheEmbalagens;
    procedure pPreencheArrayEmbalagem;
    procedure pRetTabelasPreco(Conexao: TUniConnection);
    procedure Execute; override;

    constructor Create(pgbProgresso: TcxProgressBar; strIdePro: String; blnAuto: Boolean = False); Override;
    destructor Destroy; Override;
  End;


implementation

{ TExportaTintometricosTerceirosLechler }

constructor TExportaTintometricosTerceirosLechler.Create(
  pgbProgresso: TcxProgressBar; strIdePro: String; blnAuto: Boolean);
begin
  inherited;
  strProLEC := '';
  pPreencheEmbalagens;
  strAcrMob := fRetValorAcrMobCfgTin();
  dicPrecoAdicional := TDicionario.Create();
  stlTabPre := TStringList.Create();
end;

destructor TExportaTintometricosTerceirosLechler.Destroy;
begin
  If Assigned(dicPrecoAdicional) Then
    FreeAndNil(dicPrecoAdicional);

  If Assigned(stlTabPre) Then
    FreeAndNil(stlTabPre);
end;

procedure TExportaTintometricosTerceirosLechler.Execute;
begin
  inherited;
end;

function TExportaTintometricosTerceirosLechler.fCalculaPrecoCustoConcentrado(
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

function TExportaTintometricosTerceirosLechler.fCalculaPrecoCustoDiluido(
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

function TExportaTintometricosTerceirosLechler.fCalculaPrecoCustoEmbalagem(
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

function TExportaTintometricosTerceirosLechler.fCalculaPrecoEmbalagem(
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

function TExportaTintometricosTerceirosLechler.fCalculaPrecoEmbalagem1a7(
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

function TExportaTintometricosTerceirosLechler.fCalculaPrecoVendaConcentrado(qryBases: TUniQuery; strTabelaUnica: String): Double;
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

function TExportaTintometricosTerceirosLechler.fCalculaPrecoVendaConcentrado1a7(
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

function TExportaTintometricosTerceirosLechler.fCalculaPrecoVendaDiluido(
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

function TExportaTintometricosTerceirosLechler.fCalculaPrecoVendaDiluido1a7(
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

function TExportaTintometricosTerceirosLechler.fCamposSelect: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                  ';
  Result := Result + '    LEC_CODBAS,           ';
  Result := Result + '    LEC_CODNFM,           ';
  Result := Result + '    LEC_CODEMB,           ';
  Result := Result + '    LEC_CODCOR,           ';
  Result := Result + '    LEC_DESCOR,           ';
  Result := Result + '    LEC_EFECOR,           ';
  Result := Result + '    LEC_MASIND,           ';
  Result := Result + '    LEC_ANOINI,           ';
  Result := Result + '    LEC_ANOFIN,           ';
  Result := Result + '    LEC_DESCRI,           ';
  Result := Result + '    LEC_QTDTOT,           ';
  Result := Result + '    LEC_QTDB01,           ';
  Result := Result + '    LEC_PERB01,           ';
  Result := Result + '    LEC_ACRMOB,           ';

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    Result := Result + '    LEC_FORM' + fStrZero(intContador, 2) + ',     ';
    Result := Result + '    LEC_QTDC' + fStrZero(intContador, 2) + ',     ';
    Result := Result + '    LEC_PERC' + fStrZero(intContador, 2) + ',     ';
  End;

  Result := Result + '    LEC_MD5KEY            ';
  Result := Result + '  FROM                    ';
  Result := Result + '    LEC_CADLEC            ';
  Result := Result + '  WHERE                   ';
  Result := Result + '    TRUE;                 ';
end;

function TExportaTintometricosTerceirosLechler.fCamposTabela: String;
begin
  Result := '';
  Result := Result + '  CREATE TABLE    ' + fNomeTabela() + '   (     ';
  Result := Result + '    LEC_CODBAS VARCHAR(10),         ';
  Result := Result + '    LEC_CODNFM VARCHAR(15),         ';
  Result := Result + '    LEC_CODEMB CHAR(3),         ';
  Result := Result + '    LEC_CODCOR VARCHAR(20),         ';
  Result := Result + '    LEC_DESCOR VARCHAR(50),         ';
  Result := Result + '    LEC_EFECOR VARCHAR(20),          ';
  Result := Result + '    LEC_MASIND VARCHAR(20),          ';
  Result := Result + '    LEC_ANOINI VARCHAR(4),         ';
  Result := Result + '    LEC_ANOFIN VARCHAR(4),         ';
  Result := Result + '    LEC_DESCRI VARCHAR(50),       ';
  Result := Result + '    LEC_MD5KEY VARCHAR(32),         ';
  Result := Result + '    LEC_CODITE VARCHAR(5),          ';
  Result := Result + '    LEC_CODDIL VARCHAR(20),         ';
  Result := Result + '    LEC_PORDIL DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRECLT DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRECGL DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRECLA DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRECBD DECIMAL(12,4),       ';
  Result := Result + '    LEC_PREDLT DECIMAL(12,4),       ';
  Result := Result + '    LEC_PREDGL DECIMAL(12,4),       ';
  Result := Result + '    LEC_PREDLA DECIMAL(12,4),       ';
  Result := Result + '    LEC_PREDBD DECIMAL(12,4),       ';
  Result := Result + '    LEC_PCUCLT DECIMAL(12,4),       ';
  Result := Result + '    LEC_PCUDLT DECIMAL(12,4),       ';
  Result := Result + '    LEC_PCUCGL DECIMAL(12,4),       ';
  Result := Result + '    LEC_PCUDGL DECIMAL(12,4),       ';
  Result := Result + '    LEC_PCUCLA DECIMAL(12,4),       ';
  Result := Result + '    LEC_PCUDLA DECIMAL(12,4),       ';
  Result := Result + '    LEC_PCUCBD DECIMAL(12,4),       ';
  Result := Result + '    LEC_PCUDBD DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRCLT1 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRCLT2 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRCLT3 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRCLT4 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRCLT5 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRCLT6 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRCLT7 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRCGL1 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRCGL2 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRCGL3 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRCGL4 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRCGL5 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRCGL6 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRCGL7 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRCLA1 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRCLA2 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRCLA3 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRCLA4 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRCLA5 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRCLA6 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRCLA7 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRCBD1 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRCBD2 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRCBD3 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRCBD4 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRCBD5 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRCBD6 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRCBD7 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRDLT1 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRDLT2 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRDLT3 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRDLT4 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRDLT5 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRDLT6 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRDLT7 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRDGL1 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRDGL2 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRDGL3 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRDGL4 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRDGL5 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRDGL6 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRDGL7 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRDLA1 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRDLA2 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRDLA3 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRDLA4 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRDLA5 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRDLA6 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRDLA7 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRDBD1 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRDBD2 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRDBD3 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRDBD4 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRDBD5 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRDBD6 DECIMAL(12,4),       ';
  Result := Result + '    LEC_PRDBD7 DECIMAL(12,4),       ';
  Result := Result + '    LEC_EMBALT VARCHAR(5),          ';
  Result := Result + '    LEC_EMBAGL VARCHAR(5),          ';
  Result := Result + '    LEC_EMBALA VARCHAR(5),          ';
  Result := Result + '    LEC_EMBABD VARCHAR(5),          ';
  Result := Result + '    LEC_VOLULT DECIMAL(12,4),       ';
  Result := Result + '    LEC_VOLUGL DECIMAL(12,4),       ';
  Result := Result + '    LEC_VOLULA DECIMAL(12,4),       ';
  Result := Result + '    LEC_VOLUBD DECIMAL(12,4),       ';
  Result := Result + '    LEC_PREELT DECIMAL(12,4),       ';
  Result := Result + '    LEC_PREEGL DECIMAL(12,4),       ';
  Result := Result + '    LEC_PREELA DECIMAL(12,4),       ';
  Result := Result + '    LEC_PREEBD DECIMAL(12,4),       ';
  Result := Result + '    LEC_TIPOLT CHAR(2),             ';
  Result := Result + '    LEC_TIPOGL CHAR(2),             ';
  Result := Result + '    LEC_TIPOLA CHAR(2),             ';
  Result := Result + '    LEC_TIPOBD CHAR(2)              ';
  Result := Result + '            );                                  ';
end;

function TExportaTintometricosTerceirosLechler.fFatorTinta: Double;
begin
  Result := 0;
end;

function TExportaTintometricosTerceirosLechler.fNomeTabela: String;
begin
  Result := 'LEC_CADLEC_SIT';
end;

function TExportaTintometricosTerceirosLechler.fQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TExportaTintometricosTerceirosLechler.fRetDescricao: String;
begin
  Result := 'LEC_DESCOR';
end;

function TExportaTintometricosTerceirosLechler.fRetEmbalagem(
  qryColorantes: TUniQuery): Double;
begin
    Result := qryColorantes.FieldByName('BAS_EMBALA').AsFloat * qryColorantes.FieldByName('BAS_PESESP').AsFloat;
end;

function TExportaTintometricosTerceirosLechler.fRetEmbalagemBD: String;
begin
  Result := 'LECBAL';
end;

function TExportaTintometricosTerceirosLechler.fRetEmbalagemLA: String;
begin
  Result := 'LECLAT';
end;

function TExportaTintometricosTerceirosLechler.fRetEmbalagemGL: String;
begin
  Result := 'LECGAL';
end;

function TExportaTintometricosTerceirosLechler.fRetEmbalagemLT: String;
begin
  Result := 'LECLIT';
end;

function TExportaTintometricosTerceirosLechler.fRetFormula(
  intCont: Integer): String;
begin
  Result := 'LEC_FORM' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosLechler.fRetItemBase: String;
begin
  Result := '';
end;

function TExportaTintometricosTerceirosLechler.fRetItemVenda(
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
    strSQL := strSQL + '    CFG_IDEPRO = "LEC" AND                  ';
    strSQL := strSQL + '    CFG_CODCFG = "PROLEC" AND               ';
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

function TExportaTintometricosTerceirosLechler.fRetMD5KEY: String;
begin
  Result := 'LEC_MD5KEY';
end;

function TExportaTintometricosTerceirosLechler.fRetornaBases: String;
begin
  Result := '';
  Result := Result + '  SELECT                    ';
  Result := Result + '    BAS_CODBAS,             ';
  Result := Result + '    BAS_CODITE,             ';
  Result := Result + '    BAS_EMBALA,             ';
  Result := Result + '    BAS_PESESP,             ';
  Result := Result + '    ITE_PREVE' + fRetornaTabelaPreco + ' AS ITE_PREVEN,        ';
  Result := Result + '    G.ITE_PRECUS AS PRECUS,      ';
  Result := Result + '    G.ITE_PREVE1 AS PREVE1,      ';
  Result := Result + '    G.ITE_PREVE2 AS PREVE2,      ';
  Result := Result + '    G.ITE_PREVE3 AS PREVE3,      ';
  Result := Result + '    G.ITE_PREVE4 AS PREVE4,      ';
  Result := Result + '    G.ITE_PREVE5 AS PREVE5,      ';
  Result := Result + '    G.ITE_PREVE6 AS PREVE6,      ';
  Result := Result + '    G.ITE_PREVE7 AS PREVE7       ';
  Result := Result + '  FROM                      ';
  Result := Result + '    LEC_CADBAS B            ';
  Result := Result + '  INNER JOIN CADITE I ON          ';
  Result := Result + '    B.BAS_CODITE = I.ITE_CODITE               ';
  Result := Result + '  INNER JOIN ITEGER G ON          ';
  Result := Result + '    I.ITE_CODITE = G.ITE_CODITE               ';
  Result := Result + '  WHERE                     ';
  Result := Result + '    G.ITE_CODEMP = "' + VS_strCodEmp + '"     ';
  Result := Result + '  UNION ALL                 ';
  Result := Result + '  SELECT                    ';
  Result := Result + '    COL_CODCOL AS BAS_CODBAS,                 ';
  Result := Result + '    COL_CODITE AS BAS_CODITE,                 ';
  Result := Result + '    COL_EMBALA AS BAS_EMBALA,                 ';
  Result := Result + '    COL_PESESP AS BAS_PESESP,                 ';
  Result := Result + '    ITE_PREVE' + fRetornaTabelaPreco + ' AS ITE_PREVEN,        ';
  Result := Result + '    G.ITE_PRECUS AS PRECUS,      ';
  Result := Result + '    G.ITE_PREVE1 AS PREVE1,      ';
  Result := Result + '    G.ITE_PREVE2 AS PREVE2,      ';
  Result := Result + '    G.ITE_PREVE3 AS PREVE3,      ';
  Result := Result + '    G.ITE_PREVE4 AS PREVE4,      ';
  Result := Result + '    G.ITE_PREVE5 AS PREVE5,      ';
  Result := Result + '    G.ITE_PREVE6 AS PREVE6,      ';
  Result := Result + '    G.ITE_PREVE7 AS PREVE7       ';
  Result := Result + '  FROM                      ';
  Result := Result + '    LEC_CADCOL C            ';
  Result := Result + '  INNER JOIN CADITE I ON          ';
  Result := Result + '    C.COL_CODITE = I.ITE_CODITE               ';
  Result := Result + '  INNER JOIN ITEGER G ON          ';
  Result := Result + '    I.ITE_CODITE = G.ITE_CODITE               ';
  Result := Result + '  WHERE                     ';
  Result := Result + '    G.ITE_CODEMP = "' + VS_strCodEmp + '"     ';
end;

function TExportaTintometricosTerceirosLechler.fRetornaCampoEmbalagem(
  strSigEmb: String; dicRetorno: TDicionario): String;
begin
  Result := '';

  If strSigEmb = 'LT' Then
    Result := fRetEmbalagemLT()
  Else If strSigEmb = 'GL' Then
    Result := fRetEmbalagemGL()
  Else If strSigEmb = 'LA' Then
    Result := fRetEmbalagemLA()
  Else If strSigEmb = 'BD' Then
    Result := fRetEmbalagemBD();
end;

function TExportaTintometricosTerceirosLechler.fRetornaCodigoDiluente(
  dicRetorno: TDicionario): String;
begin
  Result := IfNull(dicRetorno['coddil'], '');
end;

function TExportaTintometricosTerceirosLechler.fRetornaColorantes: String;
begin
  Result := '';
end;

function TExportaTintometricosTerceirosLechler.fRetornaPercentualAcrescimo(
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
    strSQL := strSQL + '    CFG_IDEPRO = "LEC" AND                ';
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

function TExportaTintometricosTerceirosLechler.fRetornaPorcentagemDiluente(
  dicRetorno: TDicionario): Double;
begin
  Result := IfNull(dicRetorno['pordil'], 0);
end;

function TExportaTintometricosTerceirosLechler.fRetornaPrecoConcentrado(
  fltPrecoTotal, fltPerAcr, fltEmbalagem: Double): Double;
begin
  Result := 0;

  If fltPrecoTotal > 0 Then
    Result := fltPrecoTotal +
      (fltPerAcr * fltPrecoTotal) + fltEmbalagem;
end;

function TExportaTintometricosTerceirosLechler.fRetornaPrecoCustoConcentrado(
  fltPrecoTotal, fltEmbalagem: Double): Double;
begin
  Result := 0;

  If fltPrecoTotal > 0 Then
    Result := fltPrecoTotal + fltEmbalagem;
end;

function TExportaTintometricosTerceirosLechler.fRetornaPrecoCustoDiluido(
  fltPrecoTotal, fltEmbalagem: Double): Double;
begin
  Result := 0;

  If fltPrecoTotal > 0 Then
    Result := fltPrecoTotal + fltEmbalagem;
end;

function TExportaTintometricosTerceirosLechler.fRetornaPrecoDiluido(
  fltPrecoTotal, fltPerAcr, fltEmbalagem: Double): Double;
begin
  Result := 0;

  If fltPrecoTotal > 0 Then
    Result := fltPrecoTotal +
      (fltPerAcr * fltPrecoTotal) + fltEmbalagem;
end;

function TExportaTintometricosTerceirosLechler.fRetQuantidade(
  intCont: Integer): String;
begin
  Result := 'LEC_QTDC' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosLechler.fRetTipoCor: String;
begin
  Result := 'LEC_EFECOR';
end;

function TExportaTintometricosTerceirosLechler.fRetValorAcrMobCfgTin: String;
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' SELECT CFG_VALCFG               ');
    qryGen.SQL.Add('    FROM CFGTIN                  ');
    qryGen.SQL.Add(' WHERE CFG_IDEPRO = "LEC" AND    ');
    qryGen.SQL.Add('       CFG_CODCFG = "ACRMOB" AND ');
    qryGen.SQL.Add('       CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
    qryGen.Open;

    Result := qryGen.FieldByName('CFG_VALCFG').AsString;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosLechler.fSQLInsert: String;
begin
  Result := '';
  Result := Result + '  INSERT INTO   ' + fNomeTabela() + '   (     ';
  Result := Result + '    LEC_CODBAS,           ';
  Result := Result + '    LEC_CODNFM,           ';
  Result := Result + '    LEC_CODEMB,           ';
  Result := Result + '    LEC_CODCOR,           ';
  Result := Result + '    LEC_DESCOR,           ';
  Result := Result + '    LEC_EFECOR,           ';
  Result := Result + '    LEC_MASIND,           ';
  Result := Result + '    LEC_ANOINI,           ';
  Result := Result + '    LEC_ANOFIN,           ';
  Result := Result + '    LEC_DESCRI,           ';
  Result := Result + '    LEC_MD5KEY,           ';
  Result := Result + '    LEC_CODITE,           ';
  Result := Result + '    LEC_CODDIL,           ';
  Result := Result + '    LEC_PORDIL,           ';
  Result := Result + '    LEC_PRECLT,           ';
  Result := Result + '    LEC_PRECGL,           ';
  Result := Result + '    LEC_PRECLA,           ';
  Result := Result + '    LEC_PRECBD,           ';
  Result := Result + '    LEC_PREDLT,           ';
  Result := Result + '    LEC_PREDGL,           ';
  Result := Result + '    LEC_PREDLA,           ';
  Result := Result + '    LEC_PREDBD,           ';
  Result := Result + '    LEC_PCUCLT,           ';
  Result := Result + '    LEC_PCUDLT,           ';
  Result := Result + '    LEC_PCUCGL,           ';
  Result := Result + '    LEC_PCUDGL,           ';
  Result := Result + '    LEC_PCUCLA,           ';
  Result := Result + '    LEC_PCUDLA,           ';
  Result := Result + '    LEC_PCUCBD,           ';
  Result := Result + '    LEC_PCUDBD,           ';
  Result := Result + '    LEC_PRCLT1,           ';
  Result := Result + '    LEC_PRCLT2,           ';
  Result := Result + '    LEC_PRCLT3,           ';
  Result := Result + '    LEC_PRCLT4,           ';
  Result := Result + '    LEC_PRCLT5,           ';
  Result := Result + '    LEC_PRCLT6,           ';
  Result := Result + '    LEC_PRCLT7,           ';
  Result := Result + '    LEC_PRCGL1,           ';
  Result := Result + '    LEC_PRCGL2,           ';
  Result := Result + '    LEC_PRCGL3,           ';
  Result := Result + '    LEC_PRCGL4,           ';
  Result := Result + '    LEC_PRCGL5,           ';
  Result := Result + '    LEC_PRCGL6,           ';
  Result := Result + '    LEC_PRCGL7,           ';
  Result := Result + '    LEC_PRCLA1,           ';
  Result := Result + '    LEC_PRCLA2,           ';
  Result := Result + '    LEC_PRCLA3,           ';
  Result := Result + '    LEC_PRCLA4,           ';
  Result := Result + '    LEC_PRCLA5,           ';
  Result := Result + '    LEC_PRCLA6,           ';
  Result := Result + '    LEC_PRCLA7,           ';
  Result := Result + '    LEC_PRCBD1,           ';
  Result := Result + '    LEC_PRCBD2,           ';
  Result := Result + '    LEC_PRCBD3,           ';
  Result := Result + '    LEC_PRCBD4,           ';
  Result := Result + '    LEC_PRCBD5,           ';
  Result := Result + '    LEC_PRCBD6,           ';
  Result := Result + '    LEC_PRCBD7,           ';
  Result := Result + '    LEC_PRDLT1,           ';
  Result := Result + '    LEC_PRDLT2,           ';
  Result := Result + '    LEC_PRDLT3,           ';
  Result := Result + '    LEC_PRDLT4,           ';
  Result := Result + '    LEC_PRDLT5,           ';
  Result := Result + '    LEC_PRDLT6,           ';
  Result := Result + '    LEC_PRDLT7,           ';
  Result := Result + '    LEC_PRDGL1,           ';
  Result := Result + '    LEC_PRDGL2,           ';
  Result := Result + '    LEC_PRDGL3,           ';
  Result := Result + '    LEC_PRDGL4,           ';
  Result := Result + '    LEC_PRDGL5,           ';
  Result := Result + '    LEC_PRDGL6,           ';
  Result := Result + '    LEC_PRDGL7,           ';
  Result := Result + '    LEC_PRDLA1,           ';
  Result := Result + '    LEC_PRDLA2,           ';
  Result := Result + '    LEC_PRDLA3,           ';
  Result := Result + '    LEC_PRDLA4,           ';
  Result := Result + '    LEC_PRDLA5,           ';
  Result := Result + '    LEC_PRDLA6,           ';
  Result := Result + '    LEC_PRDLA7,           ';
  Result := Result + '    LEC_PRDBD1,           ';
  Result := Result + '    LEC_PRDBD2,           ';
  Result := Result + '    LEC_PRDBD3,           ';
  Result := Result + '    LEC_PRDBD4,           ';
  Result := Result + '    LEC_PRDBD5,           ';
  Result := Result + '    LEC_PRDBD6,           ';
  Result := Result + '    LEC_PRDBD7,           ';
  Result := Result + '    LEC_EMBALT,           ';
  Result := Result + '    LEC_EMBAGL,           ';
  Result := Result + '    LEC_EMBALA,           ';
  Result := Result + '    LEC_EMBABD,           ';
  Result := Result + '    LEC_VOLULT,           ';
  Result := Result + '    LEC_VOLUGL,           ';
  Result := Result + '    LEC_VOLULA,           ';
  Result := Result + '    LEC_VOLUBD,           ';
  Result := Result + '    LEC_PREELT,           ';
  Result := Result + '    LEC_PREEGL,           ';
  Result := Result + '    LEC_PREELA,           ';
  Result := Result + '    LEC_PREEBD,           ';
  Result := Result + '    LEC_TIPOLT,           ';
  Result := Result + '    LEC_TIPOGL,           ';
  Result := Result + '    LEC_TIPOLA,           ';
  Result := Result + '    LEC_TIPOBD            ';
  Result := Result + '            )                                 ';
  Result := Result + '  VALUES        (                             ';
  Result := Result + '    :CODBAS,           ';
  Result := Result + '    :CODNFM,           ';
  Result := Result + '    :CODEMB,           ';
  Result := Result + '    :CODCOR,           ';
  Result := Result + '    :DESCOR,           ';
  Result := Result + '    :EFECOR,           ';
  Result := Result + '    :MASIND,           ';
  Result := Result + '    :ANOINI,           ';
  Result := Result + '    :ANOFIN,           ';
  Result := Result + '    :DESCRI,           ';
  Result := Result + '    :MD5KEY,           ';
  Result := Result + '    :CODITE,           ';
  Result := Result + '    :CODDIL,           ';
  Result := Result + '    :PORDIL,           ';
  Result := Result + '    :PRECLT,           ';
  Result := Result + '    :PRECGL,           ';
  Result := Result + '    :PRECLA,           ';
  Result := Result + '    :PRECBD,           ';
  Result := Result + '    :PREDLT,           ';
  Result := Result + '    :PREDGL,           ';
  Result := Result + '    :PREDLA,           ';
  Result := Result + '    :PREDBD,           ';
  Result := Result + '    :PCUCLT,           ';
  Result := Result + '    :PCUDLT,           ';
  Result := Result + '    :PCUCGL,           ';
  Result := Result + '    :PCUDGL,           ';
  Result := Result + '    :PCUCLA,           ';
  Result := Result + '    :PCUDLA,           ';
  Result := Result + '    :PCUCBD,           ';
  Result := Result + '    :PCUDBD,           ';
  Result := Result + '    :PRCLT1,           ';
  Result := Result + '    :PRCLT2,           ';
  Result := Result + '    :PRCLT3,           ';
  Result := Result + '    :PRCLT4,           ';
  Result := Result + '    :PRCLT5,           ';
  Result := Result + '    :PRCLT6,           ';
  Result := Result + '    :PRCLT7,           ';
  Result := Result + '    :PRCGL1,           ';
  Result := Result + '    :PRCGL2,           ';
  Result := Result + '    :PRCGL3,           ';
  Result := Result + '    :PRCGL4,           ';
  Result := Result + '    :PRCGL5,           ';
  Result := Result + '    :PRCGL6,           ';
  Result := Result + '    :PRCGL7,           ';
  Result := Result + '    :PRCLA1,           ';
  Result := Result + '    :PRCLA2,           ';
  Result := Result + '    :PRCLA3,           ';
  Result := Result + '    :PRCLA4,           ';
  Result := Result + '    :PRCLA5,           ';
  Result := Result + '    :PRCLA6,           ';
  Result := Result + '    :PRCLA7,           ';
  Result := Result + '    :PRCBD1,           ';
  Result := Result + '    :PRCBD2,           ';
  Result := Result + '    :PRCBD3,           ';
  Result := Result + '    :PRCBD4,           ';
  Result := Result + '    :PRCBD5,           ';
  Result := Result + '    :PRCBD6,           ';
  Result := Result + '    :PRCBD7,           ';
  Result := Result + '    :PRDLT1,           ';
  Result := Result + '    :PRDLT2,           ';
  Result := Result + '    :PRDLT3,           ';
  Result := Result + '    :PRDLT4,           ';
  Result := Result + '    :PRDLT5,           ';
  Result := Result + '    :PRDLT6,           ';
  Result := Result + '    :PRDLT7,           ';
  Result := Result + '    :PRDGL1,           ';
  Result := Result + '    :PRDGL2,           ';
  Result := Result + '    :PRDGL3,           ';
  Result := Result + '    :PRDGL4,           ';
  Result := Result + '    :PRDGL5,           ';
  Result := Result + '    :PRDGL6,           ';
  Result := Result + '    :PRDGL7,           ';
  Result := Result + '    :PRDLA1,           ';
  Result := Result + '    :PRDLA2,           ';
  Result := Result + '    :PRDLA3,           ';
  Result := Result + '    :PRDLA4,           ';
  Result := Result + '    :PRDLA5,           ';
  Result := Result + '    :PRDLA6,           ';
  Result := Result + '    :PRDLA7,           ';
  Result := Result + '    :PRDBD1,           ';
  Result := Result + '    :PRDBD2,           ';
  Result := Result + '    :PRDBD3,           ';
  Result := Result + '    :PRDBD4,           ';
  Result := Result + '    :PRDBD5,           ';
  Result := Result + '    :PRDBD6,           ';
  Result := Result + '    :PRDBD7,           ';
  Result := Result + '    :EMBALT,           ';
  Result := Result + '    :EMBAGL,           ';
  Result := Result + '    :EMBALA,           ';
  Result := Result + '    :EMBABD,           ';
  Result := Result + '    :VOLULT,           ';
  Result := Result + '    :VOLUGL,           ';
  Result := Result + '    :VOLULA,           ';
  Result := Result + '    :VOLUBD,           ';
  Result := Result + '    :PREELT,           ';
  Result := Result + '    :PREEGL,           ';
  Result := Result + '    :PREELA,           ';
  Result := Result + '    :PREEBD,           ';
  Result := Result + '    :TIPOLT,           ';
  Result := Result + '    :TIPOGL,           ';
  Result := Result + '    :TIPOLA,           ';
  Result := Result + '    :TIPOBD            ';
  Result := Result + '            );                                ';
end;

function TExportaTintometricosTerceirosLechler.fValorQuantidade(fltValor,
  fltAcrMob: Double): Double;
begin
  If fltValor <= 0 Then
    Result := 0
  Else
  Begin
    Result := fltValor + fltAcrMob;
  End;
end;

procedure TExportaTintometricosTerceirosLechler.pAdicionaParamentros(Var DataSet: TFDQuery;
      qryTinta: TUniQuery; fltPreVen: Double; intParam: Integer = 0);
Var
  intContador: Integer;
  intEmb: Integer;
begin
  DataSet.ParamByName('CODBAS').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('LEC_CODBAS').AsString);
  DataSet.ParamByName('CODNFM').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('LEC_CODNFM').AsString);
  DataSet.ParamByName('CODEMB').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('LEC_CODEMB').AsString);
  DataSet.ParamByName('CODCOR').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('LEC_CODCOR').AsString);
  DataSet.ParamByName('DESCOR').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('LEC_DESCOR').AsString);
  DataSet.ParamByName('EFECOR').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('LEC_EFECOR').AsString);
  DataSet.ParamByName('MASIND').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('LEC_MASIND').AsString);
  DataSet.ParamByName('ANOINI').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('LEC_ANOINI').AsString);
  DataSet.ParamByName('ANOFIN').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('LEC_ANOFIN').AsString);
  DataSet.ParamByName('DESCRI').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('LEC_DESCRI').AsString);
  DataSet.ParamByName('MD5KEY').AsStrings[intParam] := qryTinta.FieldByName('LEC_MD5KEY').AsString;
  DataSet.ParamByName('CODITE').AsStrings[intParam] := strProLEC;
  DataSet.ParamByName('PCUCLT').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONLT'], 0.0);
  DataSet.ParamByName('PCUCGL').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONGL'], 0.0);
  DataSet.ParamByName('PCUCLA').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONLA'], 0.0);
  DataSet.ParamByName('PCUCBD').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONBD'], 0.0);
  DataSet.ParamByName('PCUDLT').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILLT'], 0.0);
  DataSet.ParamByName('PCUDGL').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILGL'], 0.0);
  DataSet.ParamByName('PCUDLA').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILLA'], 0.0);
  DataSet.ParamByName('PCUDBD').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILBD'], 0.0);

  For intEmb := 0 To Length(arrEmbalagens) - 1 Do
  Begin
    If strAcrMob = '1' Then
    Begin
      arrPrecosPorEmb[intEmb].fltValCon := arrPrecosPorEmb[intEmb].fltValCon * (1 + qryTinta.FieldByName('LEC_ACRMOB').AsFloat / 100);
      arrPrecosPorEmb[intEmb].fltValDil := arrPrecosPorEmb[intEmb].fltValDil * (1 + qryTinta.FieldByName('LEC_ACRMOB').AsFloat / 100);
    End
    Else
    Begin
      arrPrecosPorEmb[intEmb].fltValCon := fValorQuantidade(arrPrecosPorEmb[intEmb].fltValCon, qryTinta.FieldByName('LEC_ACRMOB').AsFloat);
      arrPrecosPorEmb[intEmb].fltValDil := fValorQuantidade(arrPrecosPorEmb[intEmb].fltValDil, qryTinta.FieldByName('LEC_ACRMOB').AsFloat);
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
      DataSet.ParamByName('PRCBD' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONBD'], 0.0);
      DataSet.ParamByName('PRDBD' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILBD'], 0.0);
    End
    Else
    Begin
      If strAcrMob = '1' Then
      Begin
        DataSet.ParamByName('PRCLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLT'], 0.0) * (1 + qryTinta.FieldByName('LEC_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLT'], 0.0) * (1 + qryTinta.FieldByName('LEC_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONGL'], 0.0) * (1 + qryTinta.FieldByName('LEC_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILGL'], 0.0) * (1 + qryTinta.FieldByName('LEC_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCLA' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLA'], 0.0) * (1 + qryTinta.FieldByName('LEC_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDLA' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLA'], 0.0) * (1 + qryTinta.FieldByName('LEC_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCBD' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONBD'], 0.0) * (1 + qryTinta.FieldByName('LEC_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDBD' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILBD'], 0.0) * (1 + qryTinta.FieldByName('LEC_ACRMOB').AsFloat / 100);
      End
      Else
      Begin
        DataSet.ParamByName('PRCLT' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLT'], 0.0), qryTinta.FieldByName('LEC_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDLT' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLT'], 0.0), qryTinta.FieldByName('LEC_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCGL' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONGL'], 0.0), qryTinta.FieldByName('LEC_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDGL' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILGL'], 0.0), qryTinta.FieldByName('LEC_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCLA' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLA'], 0.0), qryTinta.FieldByName('LEC_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDLA' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLA'], 0.0), qryTinta.FieldByName('LEC_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCBD' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONBD'], 0.0), qryTinta.FieldByName('LEC_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDBD' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILBD'], 0.0), qryTinta.FieldByName('LEC_ACRMOB').AsFloat); 
      End;
    End; 
  End;
end;

procedure TExportaTintometricosTerceirosLechler.pCriaClientEmbalagem(
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
    strSQL := strSQL + '    CFG_IDEPRO = "LEC" AND                  ';
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

procedure TExportaTintometricosTerceirosLechler.pGravaTintometricoPorTintaTerceiros(
  qryInsert: TFDQuery; fltPreVen: Double; qryTinta: TUniQuery;
  intParam: Integer);
var
  intEmb: Integer;
  strSigEmb: String;
begin
  Try
    With qryInsert Do
    Begin
      pAdicionaParamentros(qryInsert, qryTinta, fltPreVen, intParam);

      For intEmb := 0 To Length(arrEmbalagens) - 1 Do
      Begin
        strSigEmb := arrEmbalagens[intEmb].strSigEmb;

        ParamByName('PREC' + strSigEmb).AsFloats[intParam]  := arrPrecosPorEmb[intEmb].fltValCon; //preco concentrado
        ParamByName('PRED' + strSigEmb).AsFloats[intParam]  := arrPrecosPorEmb[intEmb].fltValDil; //preco diluido
        ParamByName('EMBA' + strSigEmb).AsStrings[intParam] := arrPrecosPorEmb[intEmb].strIteEmb; //Produto embalagem
        ParamByName('VOLU' + strSigEmb).AsFloats[intParam]  := arrEmbalagens[intEmb].fltVolume;   //Volume vendido
        ParamByName('PREE' + strSigEmb).AsFloats[intParam]  := arrPrecosporEmb[intEmb].fltPreEmb; //Preco da embalagem
        ParamByName('TIPO' + strSigEmb).AsStrings[intParam] := strSigEmb;                         //Tipo da embalagem
        ParamByName('CODDIL').AsStrings[intParam] := arrPrecosPorEmb[intEmb].strCodDil; //Código do diluente
        ParamByName('PORDIL').AsFloats[intParam]  := arrPrecosPorEmb[intEmb].fltPorDil;//Porcentagem do diluente
      End;
    End;
  Finally
    SetLength(arrPrecosPorEmb, 0);
  End;
end;

procedure TExportaTintometricosTerceirosLechler.pIncluirLogTinSite(
  Conexao: TUniConnection; strStatus: String);
Var
  qryGen: TUniQuery;
  strSQL: String;
begin
  Try
    strSQL := '';
    strSQL := strSQL + '  DELETE FROM LOGTIN_SIT WHERE LOG_IDEPRO = "LEC"       ';

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
    strSQL := strSQL + '    "LEC",              ';
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

procedure TExportaTintometricosTerceirosLechler.pPreencheArrayEmbalagem;
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
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 16.000;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  //Balde
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Balde';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'BD';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 20.000;
end;

procedure TExportaTintometricosTerceirosLechler.pPreencheEmbalagens;
begin
  pPreencheArrayEmbalagem;
end;

procedure TExportaTintometricosTerceirosLechler.pProcessaTabelaCores(
  qryInsert: TFDQuery; qryGen, qryBases, qryColorantes: TUniQuery; strTabUni,
  strTabPre: String; fltPerAcr: Double; dicRetorno: TDicionario);
Var
  fltPreVen  : Double;
  intContador: Integer;
  intRegistros: Integer;
begin
  qryGen.First;

  If Not FAutoma Then
    FProgresso.Position := 0;

{$IFDEF LINUX}
  FInicioExportacao := Now;
{$ENDIF}

{$IFDEF LINUX}
  pGerarArrayValidacao(qryGen.RecordCount);
{$ENDIF}

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
      pRecalculaFormula(dicRetorno, qryGen, qryBases);
      pRetornaPrecoTinta(dicRetorno, qryColorantes, qryBases, fltPerAcr);

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

    If intContador > 0 Then
      qryInsert.Execute(intContador, 0);

  {$IFDEF LINUX}
    pEscreverLogProgresso(qryGen);
  {$ENDIF}
  End;

{$IFDEF LINUX}
  fValidarPrecosCalculado(True);
{$ENDIF}
end;

procedure TExportaTintometricosTerceirosLechler.pRecalculaFormula(
  dicRetorno: TDicionario; qryGen, qryBases: TUniQuery);
Var
  intContador: Integer;
begin
  dicRetorno['base01'] := qryGen.FieldByName('LEC_CODBAS').AsString;
  dicRetorno['qtdb01'] := qryGen.FieldByName('LEC_QTDB01').AsFloat;
  dicRetorno['qtdd01'] := 0.0;

  For intContador := 1 To fQuantidadeFormulacao () Do
  Begin
    If (fEmptyStr(IfNull(qryGen.FieldByName('LEC_FORM' + fStrZero(intContador, 2)).AsString, ''))) Then
        Break;

    If (Not qryBases.Locate('BAS_CODBAS', qryGen.FieldByName('LEC_FORM' + fStrZero(intContador, 2)).AsString, [])) Then
        Break;

    dicRetorno['base' + fStrZero(intContador + 1, 2)] := qryGen.FieldByName('LEC_FORM' + fStrZero(intContador, 2)).AsString;
    dicRetorno['qtdb' + fStrZero(intContador + 1, 2)] := qryGen.FieldByName('LEC_QTDC' + fStrZero(intContador, 2)).AsFloat;
    dicRetorno['qtdd' + fStrZero(intContador + 1, 2)] := 0.0;
  End;
end;

procedure TExportaTintometricosTerceirosLechler.pRetPrecosAdicionais(
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

procedure TExportaTintometricosTerceirosLechler.pRetPrecoTintas(
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

procedure TExportaTintometricosTerceirosLechler.pRetTabelasPreco(
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

procedure TExportaTintometricosTerceirosLechler.pSetaParametrosEspecificos(
  Conexao: TUniConnection);
begin
  pCriaClientEmbalagem(Conexao);
  strProLEC := fRetItemVenda(Conexao);
  pRetTabelasPreco(Conexao);
end;

end.
