unit untExportaTintometricosTerceirosRennerPerformance;

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
  TExportaTintometricosTerceirosRennerPerformance = Class(TExportaTintometricosTerceirosAutomotiva)
  Private
    ArrComponentes: Array of TComp; //TArrComponentes;
    strProREP: String; //Produto de venda RennerPerformance
    strAcrMob: String;
    function fRetValorAcrMobCfgTin(): String;
    function fValorQuantidade(fltValor: Double; fltAcrMob: Double): Double;
    function fRetVolumeOriginal(dicRetorno: TDicionario; strSigEmb: String): Double;
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
  Protected
    procedure pGravaTintometricoTabelasTerceiros(qryInsert: TFDQuery;  fltPreVen: Double; qryTinta: TUniQuery; intParam: Integer = 0); Override;
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
    function fGetTipoFormula(qryGen: TUniQuery; qryBases: TUniQuery): Integer; Override;

    procedure pAdicionaParamentros(Var DataSet: TFDQuery;
      qryTinta: TUniQuery; fltPreVen: Double; intParam: Integer = 0); Override;
    procedure pSetaParametrosEspecificos(Conexao: TUniConnection); Override;
    procedure pIncluirLogTinSite(Conexao: TUniConnection; strStatus: String); Override;
    procedure pRecalculaFormula(dicRetorno: TDicionario; qryGen: TUniQuery; qryBases: TUniQuery); Override;
    procedure pRetPrecoTintas(dicRetorno: TDicionario; qryColorantes,
      qryBases: TUniQuery; fltPerAcr: Double); override;
    procedure pRetPrecosAdicionais(dicRetorno: TDicionario; qryColorantes,
      qryBases: TUniQuery; fltPerAcr: Double); Override;

    function fRetEmbalagemLT(): String;
    function fRetEmbalagemGL(): String;
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

{ TExportaTintometricosTerceirosRennerPerformance }

constructor TExportaTintometricosTerceirosRennerPerformance.Create(
  pgbProgresso: TcxProgressBar; strIdePro: String; blnAuto: Boolean);
begin
  inherited;
  strProREP := '';
  pPreencheEmbalagens;
  dicPrecoAdicional := TDicionario.Create();
  stlTabPre := TStringList.Create();
  strAcrMob := fRetValorAcrMobCfgTin();
end;

destructor TExportaTintometricosTerceirosRennerPerformance.Destroy;
begin
  If Assigned(dicPrecoAdicional) Then
    FreeAndNil(dicPrecoAdicional);

  If Assigned(stlTabPre) Then
    FreeAndNil(stlTabPre);
end;

procedure TExportaTintometricosTerceirosRennerPerformance.Execute;
begin
  inherited;
end;

function TExportaTintometricosTerceirosRennerPerformance.fCalculaPrecoCustoConcentrado(
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

function TExportaTintometricosTerceirosRennerPerformance.fCalculaPrecoCustoDiluido(
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

function TExportaTintometricosTerceirosRennerPerformance.fCalculaPrecoCustoEmbalagem(
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

function TExportaTintometricosTerceirosRennerPerformance.fCalculaPrecoEmbalagem(
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

function TExportaTintometricosTerceirosRennerPerformance.fCalculaPrecoEmbalagem1a7(
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

function TExportaTintometricosTerceirosRennerPerformance.fCalculaPrecoVendaConcentrado(qryBases: TUniQuery; strTabelaUnica: String): Double;
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

function TExportaTintometricosTerceirosRennerPerformance.fCalculaPrecoVendaConcentrado1a7(
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

function TExportaTintometricosTerceirosRennerPerformance.fCalculaPrecoVendaDiluido(
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

function TExportaTintometricosTerceirosRennerPerformance.fCalculaPrecoVendaDiluido1a7(
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

function TExportaTintometricosTerceirosRennerPerformance.fCamposSelect: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                  ';
  Result := Result + '    REP_CODIGO,           ';
  Result := Result + '    REP_NOMCOR,           ';
  Result := Result + '    REP_PADRAO,           ';
  Result := Result + '    REP_CODBAS,           ';
  Result := Result + '    REP_QTDBAS,           ';
  Result := Result + '    REP_ACRMOB,           ';

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    Result := Result + '    REP_FORM' + fStrZero(intContador, 2) + ',     ';
    Result := Result + '    REP_QTDC' + fStrZero(intContador, 2) + ',     ';
  End;

  Result := Result + '    REP_MD5KEY            ';
  Result := Result + '  FROM                    ';
  Result := Result + '    REP_CADREP            ';
  Result := Result + '  WHERE                   ';
  Result := Result + '    TRUE;                 ';
end;

function TExportaTintometricosTerceirosRennerPerformance.fCamposTabela: String;
begin
  Result := '';
  Result := Result + '  CREATE TABLE    ' + fNomeTabela() + '   (     ';
  Result := Result + '    REP_CODIGO VARCHAR(30),         ';
  Result := Result + '    REP_NOMCOR VARCHAR(50),         ';
  Result := Result + '    REP_PADRAO VARCHAR(30),         ';
  Result := Result + '    REP_CODBAS VARCHAR(10),         ';
  Result := Result + '    REP_MD5KEY VARCHAR(32),         ';
  Result := Result + '    REP_CODITE VARCHAR(5),          ';
  Result := Result + '    REP_CODDIL VARCHAR(20),         ';
  Result := Result + '    REP_PORDIL DECIMAL(12,4),       ';
  Result := Result + '    REP_PRECLT DECIMAL(12,4),       ';
  Result := Result + '    REP_PRECGL DECIMAL(12,4),       ';
  Result := Result + '    REP_PREDLT DECIMAL(12,4),       ';
  Result := Result + '    REP_PREDGL DECIMAL(12,4),       ';
  Result := Result + '    REP_PCUCLT DECIMAL(12,4),       ';
  Result := Result + '    REP_PCUDLT DECIMAL(12,4),       ';
  Result := Result + '    REP_PCUCGL DECIMAL(12,4),       ';
  Result := Result + '    REP_PCUDGL DECIMAL(12,4),       ';
  Result := Result + '    REP_PRCLT1 DECIMAL(12,4),       ';
  Result := Result + '    REP_PRCLT2 DECIMAL(12,4),       ';
  Result := Result + '    REP_PRCLT3 DECIMAL(12,4),       ';
  Result := Result + '    REP_PRCLT4 DECIMAL(12,4),       ';
  Result := Result + '    REP_PRCLT5 DECIMAL(12,4),       ';
  Result := Result + '    REP_PRCLT6 DECIMAL(12,4),       ';
  Result := Result + '    REP_PRCLT7 DECIMAL(12,4),       ';
  Result := Result + '    REP_PRCGL1 DECIMAL(12,4),       ';
  Result := Result + '    REP_PRCGL2 DECIMAL(12,4),       ';
  Result := Result + '    REP_PRCGL3 DECIMAL(12,4),       ';
  Result := Result + '    REP_PRCGL4 DECIMAL(12,4),       ';
  Result := Result + '    REP_PRCGL5 DECIMAL(12,4),       ';
  Result := Result + '    REP_PRCGL6 DECIMAL(12,4),       ';
  Result := Result + '    REP_PRCGL7 DECIMAL(12,4),       ';
  Result := Result + '    REP_PRDLT1 DECIMAL(12,4),       ';
  Result := Result + '    REP_PRDLT2 DECIMAL(12,4),       ';
  Result := Result + '    REP_PRDLT3 DECIMAL(12,4),       ';
  Result := Result + '    REP_PRDLT4 DECIMAL(12,4),       ';
  Result := Result + '    REP_PRDLT5 DECIMAL(12,4),       ';
  Result := Result + '    REP_PRDLT6 DECIMAL(12,4),       ';
  Result := Result + '    REP_PRDLT7 DECIMAL(12,4),       ';
  Result := Result + '    REP_PRDGL1 DECIMAL(12,4),       ';
  Result := Result + '    REP_PRDGL2 DECIMAL(12,4),       ';
  Result := Result + '    REP_PRDGL3 DECIMAL(12,4),       ';
  Result := Result + '    REP_PRDGL4 DECIMAL(12,4),       ';
  Result := Result + '    REP_PRDGL5 DECIMAL(12,4),       ';
  Result := Result + '    REP_PRDGL6 DECIMAL(12,4),       ';
  Result := Result + '    REP_PRDGL7 DECIMAL(12,4),       ';
  Result := Result + '    REP_EMBALT VARCHAR(5),          ';
  Result := Result + '    REP_EMBAGL VARCHAR(5),          ';
  Result := Result + '    REP_VOLULT DECIMAL(12,4),       ';
  Result := Result + '    REP_VOLUGL DECIMAL(12,4),       ';
  Result := Result + '    REP_PREELT DECIMAL(12,4),       ';
  Result := Result + '    REP_PREEGL DECIMAL(12,4),       ';
  Result := Result + '    REP_TIPOLT CHAR(2),             ';
  Result := Result + '    REP_TIPOGL CHAR(2)              ';
  Result := Result + '            );                                  ';
end;

function TExportaTintometricosTerceirosRennerPerformance.fFatorTinta: Double;
begin
  Result := 0;
end;

function TExportaTintometricosTerceirosRennerPerformance.fGetTipoFormula(qryGen,
  qryBases: TUniQuery): Integer;
Var
  intContador: Integer;
begin
  Result := 0;

  If Not qryBases.Locate('BAS_CODBAS', qryGen.FieldByName('REP_CODBAS').AsString, []) Then
    Exit(3);

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    If fEmptyStr(qryGen.FieldByName('REP_FORM' + fStrZero(intContador, 2)).AsString) Then
      Break;

    If Not qryBases.Locate('BAS_CODBAS', qryGen.FieldByName('REP_FORM' + fStrZero(intContador, 2)).AsString, []) Then
      Exit(3);
  End;
end;

function TExportaTintometricosTerceirosRennerPerformance.fNomeTabela: String;
begin
  Result := 'REP_CADREP_SIT';
end;

function TExportaTintometricosTerceirosRennerPerformance.fQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TExportaTintometricosTerceirosRennerPerformance.fRetDescricao: String;
begin
  Result := 'REP_NOMCOR';
end;

function TExportaTintometricosTerceirosRennerPerformance.fRetEmbalagem(
  qryColorantes: TUniQuery): Double;
begin
    Result := qryColorantes.FieldByName('BAS_EMBALA').AsFloat * qryColorantes.FieldByName('BAS_PESESP').AsFloat;
end;


function TExportaTintometricosTerceirosRennerPerformance.fRetEmbalagemGL: String;
begin
  Result := 'REPGAL';
end;

function TExportaTintometricosTerceirosRennerPerformance.fRetEmbalagemLT: String;
begin
  Result := 'REPLIT';
end;

function TExportaTintometricosTerceirosRennerPerformance.fRetFormula(
  intCont: Integer): String;
begin
  Result := 'REP_FORM' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosRennerPerformance.fRetItemBase: String;
begin
  Result := '';
end;

function TExportaTintometricosTerceirosRennerPerformance.fRetItemVenda(
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
    strSQL := strSQL + '    CFG_IDEPRO = "REP" AND                  ';
    strSQL := strSQL + '    CFG_CODCFG = "PROREP" AND               ';
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

function TExportaTintometricosTerceirosRennerPerformance.fRetMD5KEY: String;
begin
  Result := 'REP_MD5KEY';
end;

function TExportaTintometricosTerceirosRennerPerformance.fRetornaBases: String;
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
  Result := Result + '    REP_CADBAS B            ';
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
  Result := Result + '    REP_CADCOL C            ';
  Result := Result + '  INNER JOIN CADITE I ON          ';
  Result := Result + '    C.COL_CODITE = I.ITE_CODITE               ';
  Result := Result + '  INNER JOIN ITEGER G ON          ';
  Result := Result + '    I.ITE_CODITE = G.ITE_CODITE               ';
  Result := Result + '  WHERE                     ';
  Result := Result + '    G.ITE_CODEMP = "' + VS_strCodEmp + '"     ';
end;

function TExportaTintometricosTerceirosRennerPerformance.fRetornaCampoEmbalagem(
  strSigEmb: String; dicRetorno: TDicionario): String;
begin
  Result := '';

  If strSigEmb = 'LT' Then
    Result := fRetEmbalagemLT()
  Else If strSigEmb = 'GL' Then
    Result := fRetEmbalagemGL();
end;

function TExportaTintometricosTerceirosRennerPerformance.fRetornaCodigoDiluente(
  dicRetorno: TDicionario): String;
begin
  Result := IfNull(dicRetorno['coddil'], '');
end;

function TExportaTintometricosTerceirosRennerPerformance.fRetornaColorantes: String;
begin
  Result := '';
end;

function TExportaTintometricosTerceirosRennerPerformance.fRetornaPercentualAcrescimo(
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
    strSQL := strSQL + '    CFG_IDEPRO = "REP" AND                ';
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

function TExportaTintometricosTerceirosRennerPerformance.fRetornaPorcentagemDiluente(
  dicRetorno: TDicionario): Double;
begin
  Result := IfNull(dicRetorno['pordil'], 0);
end;

function TExportaTintometricosTerceirosRennerPerformance.fRetornaPrecoConcentrado(
  fltPrecoTotal, fltPerAcr, fltEmbalagem: Double): Double;
begin
  Result := 0;

  If fltPrecoTotal > 0 Then
    Result := fltPrecoTotal +
      (fltPerAcr * fltPrecoTotal) + fltEmbalagem;
end;

function TExportaTintometricosTerceirosRennerPerformance.fRetornaPrecoCustoConcentrado(
  fltPrecoTotal, fltEmbalagem: Double): Double;
begin
  Result := 0;

  If fltPrecoTotal > 0 Then
    Result := fltPrecoTotal + fltEmbalagem;
end;

function TExportaTintometricosTerceirosRennerPerformance.fRetornaPrecoCustoDiluido(
  fltPrecoTotal, fltEmbalagem: Double): Double;
begin
  Result := 0;

  If fltPrecoTotal > 0 Then
    Result := fltPrecoTotal + fltEmbalagem;
end;

function TExportaTintometricosTerceirosRennerPerformance.fRetornaPrecoDiluido(
  fltPrecoTotal, fltPerAcr, fltEmbalagem: Double): Double;
begin
  Result := 0;

  If fltPrecoTotal > 0 Then
    Result := fltPrecoTotal +
      (fltPerAcr * fltPrecoTotal) + fltEmbalagem;
end;

function TExportaTintometricosTerceirosRennerPerformance.fRetQuantidade(
  intCont: Integer): String;
begin
  Result := 'REP_QTDC' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosRennerPerformance.fRetTipoCor: String;
begin
  Result := 'REP_PADRAO';
end;

function TExportaTintometricosTerceirosRennerPerformance.fRetValorAcrMobCfgTin: String;
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' SELECT CFG_VALCFG               ');
    qryGen.SQL.Add('    FROM CFGTIN                  ');
    qryGen.SQL.Add(' WHERE CFG_IDEPRO = "REP" AND    ');
    qryGen.SQL.Add('       CFG_CODCFG = "ACRMOB" AND ');
    qryGen.SQL.Add('       CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
    qryGen.Open;

    Result := qryGen.FieldByName('CFG_VALCFG').AsString;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosRennerPerformance.fRetVolumeOriginal(
  dicRetorno: TDicionario; strSigEmb: String): Double;
begin
  If strSigEmb = 'LT' Then
    Result := 0.9
  Else
    Result := 3.6;

  If strSigEmb = 'LT' Then
  Begin
    If dicRetorno['base01'] = 'RHB300' Then
      Result := 0.9
    Else If dicRetorno['base01'] = 'RHB347' Then
      Result := 0.675;
  End
  Else If strSigEmb = 'GL' Then
  Begin
    If dicRetorno['base01'] = 'RHB300' Then
      Result := 3.6
    Else If dicRetorno['base01'] = 'RHB347' Then
      Result := 2.7;
  End;
end;

function TExportaTintometricosTerceirosRennerPerformance.fSQLInsert: String;
begin
  Result := '';
  Result := Result + '  INSERT INTO   ' + fNomeTabela() + '   (     ';
  Result := Result + '    REP_CODIGO,           ';
  Result := Result + '    REP_NOMCOR,           ';
  Result := Result + '    REP_PADRAO,           ';
  Result := Result + '    REP_CODBAS,           ';
  Result := Result + '    REP_MD5KEY,           ';
  Result := Result + '    REP_CODITE,           ';
  Result := Result + '    REP_CODDIL,           ';
  Result := Result + '    REP_PORDIL,           ';
  Result := Result + '    REP_PRECLT,           ';
  Result := Result + '    REP_PRECGL,           ';
  Result := Result + '    REP_PREDLT,           ';
  Result := Result + '    REP_PREDGL,           ';
  Result := Result + '    REP_PCUCLT,           ';
  Result := Result + '    REP_PCUDLT,           ';
  Result := Result + '    REP_PCUCGL,           ';
  Result := Result + '    REP_PCUDGL,           ';
  Result := Result + '    REP_PRCLT1,           ';
  Result := Result + '    REP_PRCLT2,           ';
  Result := Result + '    REP_PRCLT3,           ';
  Result := Result + '    REP_PRCLT4,           ';
  Result := Result + '    REP_PRCLT5,           ';
  Result := Result + '    REP_PRCLT6,           ';
  Result := Result + '    REP_PRCLT7,           ';
  Result := Result + '    REP_PRCGL1,           ';
  Result := Result + '    REP_PRCGL2,           ';
  Result := Result + '    REP_PRCGL3,           ';
  Result := Result + '    REP_PRCGL4,           ';
  Result := Result + '    REP_PRCGL5,           ';
  Result := Result + '    REP_PRCGL6,           ';
  Result := Result + '    REP_PRCGL7,           ';
  Result := Result + '    REP_PRDLT1,           ';
  Result := Result + '    REP_PRDLT2,           ';
  Result := Result + '    REP_PRDLT3,           ';
  Result := Result + '    REP_PRDLT4,           ';
  Result := Result + '    REP_PRDLT5,           ';
  Result := Result + '    REP_PRDLT6,           ';
  Result := Result + '    REP_PRDLT7,           ';
  Result := Result + '    REP_PRDGL1,           ';
  Result := Result + '    REP_PRDGL2,           ';
  Result := Result + '    REP_PRDGL3,           ';
  Result := Result + '    REP_PRDGL4,           ';
  Result := Result + '    REP_PRDGL5,           ';
  Result := Result + '    REP_PRDGL6,           ';
  Result := Result + '    REP_PRDGL7,           ';
  Result := Result + '    REP_EMBALT,           ';
  Result := Result + '    REP_EMBAGL,           ';
  Result := Result + '    REP_VOLULT,           ';
  Result := Result + '    REP_VOLUGL,           ';
  Result := Result + '    REP_PREELT,           ';
  Result := Result + '    REP_PREEGL,           ';
  Result := Result + '    REP_TIPOLT,           ';
  Result := Result + '    REP_TIPOGL            ';
  Result := Result + '            )                                 ';
  Result := Result + '  VALUES        (                             ';
  Result := Result + '    :CODIGO,              ';
  Result := Result + '    :NOMCOR,              ';
  Result := Result + '    :PADRAO,              ';
  Result := Result + '    :CODBAS,              ';
  Result := Result + '    :MD5KEY,              ';
  Result := Result + '    :CODITE,              ';
  Result := Result + '    :CODDIL,              ';
  Result := Result + '    :PORDIL,              ';
  Result := Result + '    :PRECLT,              ';
  Result := Result + '    :PRECGL,              ';
  Result := Result + '    :PREDLT,              ';
  Result := Result + '    :PREDGL,              ';
  Result := Result + '    :PCUCLT,              ';
  Result := Result + '    :PCUDLT,              ';
  Result := Result + '    :PCUCGL,              ';
  Result := Result + '    :PCUDGL,              ';
  Result := Result + '    :PRCLT1,              ';
  Result := Result + '    :PRCLT2,              ';
  Result := Result + '    :PRCLT3,              ';
  Result := Result + '    :PRCLT4,              ';
  Result := Result + '    :PRCLT5,              ';
  Result := Result + '    :PRCLT6,              ';
  Result := Result + '    :PRCLT7,              ';
  Result := Result + '    :PRCGL1,              ';
  Result := Result + '    :PRCGL2,              ';
  Result := Result + '    :PRCGL3,              ';
  Result := Result + '    :PRCGL4,              ';
  Result := Result + '    :PRCGL5,              ';
  Result := Result + '    :PRCGL6,              ';
  Result := Result + '    :PRCGL7,              ';
  Result := Result + '    :PRDLT1,              ';
  Result := Result + '    :PRDLT2,              ';
  Result := Result + '    :PRDLT3,              ';
  Result := Result + '    :PRDLT4,              ';
  Result := Result + '    :PRDLT5,              ';
  Result := Result + '    :PRDLT6,              ';
  Result := Result + '    :PRDLT7,              ';
  Result := Result + '    :PRDGL1,              ';
  Result := Result + '    :PRDGL2,              ';
  Result := Result + '    :PRDGL3,              ';
  Result := Result + '    :PRDGL4,              ';
  Result := Result + '    :PRDGL5,              ';
  Result := Result + '    :PRDGL6,              ';
  Result := Result + '    :PRDGL7,              ';
  Result := Result + '    :EMBALT,              ';
  Result := Result + '    :EMBAGL,              ';
  Result := Result + '    :VOLULT,              ';
  Result := Result + '    :VOLUGL,              ';
  Result := Result + '    :PREELT,              ';
  Result := Result + '    :PREEGL,              ';
  Result := Result + '    :TIPOLT,              ';
  Result := Result + '    :TIPOGL               ';
  Result := Result + '            );            ';
end;

function TExportaTintometricosTerceirosRennerPerformance.fValorQuantidade(
  fltValor, fltAcrMob: Double): Double;
begin
  If fltValor <= 0 Then
    Result := 0
  Else
  Begin
    Result := fltValor + fltAcrMob;
  End;
end;

procedure TExportaTintometricosTerceirosRennerPerformance.pAdicionaParamentros(Var DataSet: TFDQuery;
      qryTinta: TUniQuery; fltPreVen: Double; intParam: Integer = 0);
Var
  intContador: Integer;
  intEmb: Integer;
begin
  DataSet.ParamByName('CODIGO').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('REP_CODIGO').AsString);
  DataSet.ParamByName('NOMCOR').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('REP_NOMCOR').AsString);
  DataSet.ParamByName('PADRAO').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('REP_PADRAO').AsString);
  DataSet.ParamByName('CODBAS').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('REP_CODBAS').AsString);
  DataSet.ParamByName('MD5KEY').AsStrings[intParam] := qryTinta.FieldByName('REP_MD5KEY').AsString;
  DataSet.ParamByName('CODITE').AsStrings[intParam] := strProREP;
  DataSet.ParamByName('PCUCLT').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONLT'], 0.0);
  DataSet.ParamByName('PCUCGL').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONGL'], 0.0);
  DataSet.ParamByName('PCUDLT').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILLT'], 0.0);
  DataSet.ParamByName('PCUDGL').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILGL'], 0.0);

  For intEmb := 0 To Length(arrEmbalagens) - 1 Do
  Begin
    If strAcrMob = '1' Then
    Begin
      arrPrecosPorEmb[intEmb].fltValCon := arrPrecosPorEmb[intEmb].fltValCon * (1 + qryTinta.FieldByName('REP_ACRMOB').AsFloat / 100);
      arrPrecosPorEmb[intEmb].fltValDil := arrPrecosPorEmb[intEmb].fltValDil * (1 + qryTinta.FieldByName('REP_ACRMOB').AsFloat / 100);
    End
    Else
    Begin
      arrPrecosPorEmb[intEmb].fltValCon := fValorQuantidade(arrPrecosPorEmb[intEmb].fltValCon, qryTinta.FieldByName('REP_ACRMOB').AsFloat);
      arrPrecosPorEmb[intEmb].fltValDil := fValorQuantidade(arrPrecosPorEmb[intEmb].fltValDil, qryTinta.FieldByName('REP_ACRMOB').AsFloat);
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
    End
    Else
    Begin
      If strAcrMob = '1' Then
      Begin
        DataSet.ParamByName('PRCLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLT'], 0.0) * (1 + qryTinta.FieldByName('REP_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLT'], 0.0) * (1 + qryTinta.FieldByName('REP_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONGL'], 0.0) * (1 + qryTinta.FieldByName('REP_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILGL'], 0.0) * (1 + qryTinta.FieldByName('REP_ACRMOB').AsFloat / 100);
      End
      Else
      Begin
        DataSet.ParamByName('PRCLT' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLT'], 0.0), qryTinta.FieldByName('REP_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDLT' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLT'], 0.0), qryTinta.FieldByName('REP_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCGL' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONGL'], 0.0), qryTinta.FieldByName('REP_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDGL' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILGL'], 0.0), qryTinta.FieldByName('REP_ACRMOB').AsFloat);
      End;
    End;
  End;
end;

procedure TExportaTintometricosTerceirosRennerPerformance.pCriaClientEmbalagem(
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
    strSQL := strSQL + '    CFG_IDEPRO = "REP" AND                  ';
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

procedure TExportaTintometricosTerceirosRennerPerformance.pGravaTintometricoTabelasTerceiros(
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

      If strSigEmb = 'LT' Then
      Begin
        If qryTinta.FieldByName('REP_CODBAS').AsString = 'RHB300' Then
          qryInsert.ParamByName('VOLU' + strSigEmb).AsFloats[intParam] := 0.900
        Else If qryTinta.FieldByName('REP_CODBAS').AsString = 'RHB347' Then
          qryInsert.ParamByName('VOLU' + strSigEmb).AsFloats[intParam] := 0.675
        Else
          qryInsert.ParamByName('VOLU' + strSigEmb).AsFloats[intParam] := arrEmbalagens[intEmb].fltVolume;
      End
      Else
      Begin
        If qryTinta.FieldByName('REP_CODBAS').AsString = 'RHB300' Then
          qryInsert.ParamByName('VOLU' + strSigEmb).AsFloats[intParam] := 3.600
        Else If qryTinta.FieldByName('REP_CODBAS').AsString = 'RHB347' Then
          qryInsert.ParamByName('VOLU' + strSigEmb).AsFloats[intParam] := 2.700
        Else
          qryInsert.ParamByName('VOLU' + strSigEmb).AsFloats[intParam] := arrEmbalagens[intEmb].fltVolume;
      End;

      qryInsert.ParamByName('PREE' + strSigEmb).AsFloats[intParam]  := arrPrecosporEmb[intEmb].fltPreEmb; //Preco da embalagem
      qryInsert.ParamByName('TIPO' + strSigEmb).AsStrings[intParam] := strSigEmb;                         //Tipo da embalagem
      qryInsert.ParamByName('CODDIL').AsStrings[intParam] := arrPrecosPorEmb[intEmb].strCodDil; //Código do diluente
      qryInsert.ParamByName('PORDIL').AsFloats[intParam]  := arrPrecosPorEmb[intEmb].fltPorDil;//Porcentagem do diluente
    End;
  Finally
    SetLength(arrPrecosPorEmb, 0);
  End;
end;

procedure TExportaTintometricosTerceirosRennerPerformance.pIncluirLogTinSite(
  Conexao: TUniConnection; strStatus: String);
Var
  qryGen: TUniQuery;
  strSQL: String;
begin
  Try
    strSQL := '';
    strSQL := strSQL + '  DELETE FROM LOGTIN_SIT WHERE LOG_IDEPRO = "REP"       ';

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
    strSQL := strSQL + '    "REP",              ';
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

procedure TExportaTintometricosTerceirosRennerPerformance.pPreencheArrayEmbalagem;
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
end;

procedure TExportaTintometricosTerceirosRennerPerformance.pPreencheEmbalagens;
begin
  pPreencheArrayEmbalagem;
end;

procedure TExportaTintometricosTerceirosRennerPerformance.pProcessaTabelaCores(
  qryInsert: TFDQuery; qryGen, qryBases, qryColorantes: TUniQuery; strTabUni,
  strTabPre: String; fltPerAcr: Double; dicRetorno: TDicionario);
Var
  fltPreVen  : Double;
  intContador: Integer;
  intRegistros: Integer;
  intEmb: Integer;
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

    {$IFDEF LINUX}
      If FValidateIndexList.Contains(qryGen.RecNo) Then
      Begin
        For intEmb := 0 To Length(arrEmbalagens) - 1 Do
        Begin
          pValidarPrecoExportacao(qryGen.FieldByName(fRetMD5KEY).AsString,
              arrEmbalagens[intEmb].strNomEmb, 'C', arrEmbalagens[intEmb].strSigEmb,
              arrPrecosPorEmb[intEmb].fltValCon, dicPrecoAdicional, '_CON');
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

procedure TExportaTintometricosTerceirosRennerPerformance.pRecalculaFormula(
  dicRetorno: TDicionario; qryGen, qryBases: TUniQuery);
Var
  intContador: Integer;
begin
  dicRetorno['base01'] := qryGen.FieldByName('REP_CODBAS').AsString;
  dicRetorno['qtdb01'] := qryGen.FieldByName('REP_QTDBAS').AsFloat;

  For intContador := 1 To fQuantidadeFormulacao () Do
  Begin
    If (fEmptyStr(IfNull(qryGen.FieldByName('REP_FORM' + fStrZero(intContador, 2)).AsString, ''))) Then
        Break;

    If (Not qryBases.Locate('BAS_CODBAS', qryGen.FieldByName('REP_FORM' + fStrZero(intContador, 2)).AsString, [])) Then
        Break;

    dicRetorno['base' + fStrZero(intContador + 1, 2)] := qryGen.FieldByName('REP_FORM' + fStrZero(intContador, 2)).AsString;
    dicRetorno['qtdb' + fStrZero(intContador + 1, 2)] := qryGen.FieldByName('REP_QTDC' + fStrZero(intContador, 2)).AsFloat;
  End;
end;

procedure TExportaTintometricosTerceirosRennerPerformance.pRetPrecosAdicionais(
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
  fltVolumeOri: Double;
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

    fltVolumeOri := fRetVolumeOriginal(dicRetorno, arrEmbalagens[intEmb].strSigEmb);

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
        ArrComponentes[intContador].Quantidade := fFormataFloat(((dicRetorno['qtdb' + fStrZero(intContador, 2)] * fltVolumeOri) / 0.9), 2);
        ArrComponentes[intContador].Quantiddil := fFormataFloat(((IfNull(dicRetorno['qtdd' + fStrZero(intContador, 2)], 0) * fltVolumeOri) / 0.9), 2);
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

procedure TExportaTintometricosTerceirosRennerPerformance.pRetPrecoTintas(
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
  fltVolumeOri: Double;
begin
  strTabelaUnica := dicRetorno['tabelaunica'];

  SetLength(arrPrecosPorEmb, Length(arrEmbalagens));

  //fazer o for das embalagens aqui
  For intEmb := 0 To Length(arrEmbalagens) - 1 Do
  Begin

    strCamEmb := fRetornaCampoEmbalagem(arrEmbalagens[intEmb].strSigEmb, dicRetorno);

    fltVolumeOri := fRetVolumeOriginal(dicRetorno, arrEmbalagens[intEmb].strSigEmb);

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
        ArrComponentes[intContador].Quantidade := fFormataFloat(((dicRetorno['qtdb' + fStrZero(intContador, 2)] * fltVolumeOri) / 0.9), 2);
        ArrComponentes[intContador].Quantiddil := fFormataFloat(((IfNull(dicRetorno['qtdd' + fStrZero(intContador, 2)], 0) * fltVolumeOri) / 0.9), 2);
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

procedure TExportaTintometricosTerceirosRennerPerformance.pRetTabelasPreco(
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

procedure TExportaTintometricosTerceirosRennerPerformance.pSetaParametrosEspecificos(
  Conexao: TUniConnection);
begin
  pCriaClientEmbalagem(Conexao);
  strProREP := fRetItemVenda(Conexao);
  pRetTabelasPreco(Conexao);
end;

end.
