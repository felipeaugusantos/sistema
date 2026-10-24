unit untExportaTintometricosTerceirosMiniFabrica;

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
  TExportaTintometricosTerceirosMiniFabrica = Class(TExportaTintometricosTerceirosAutomotiva)
  Private
    ArrComponentes: Array of TComp; //TArrComponentes;
    strProMIF: String; //Produto de venda MiniFabrica
    strAcrMob: String;
    function fRetValorAcrMobCfgTin(): String;
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
    function fValorQuantidade(fltValor: Double; fltAcrMob: Double): Double;
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
    function fRetEmbalagemTB(): String;
    function fRetEmbalagemSP(): String;
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

{ TExportaTintometricosTerceirosMiniFabrica }

constructor TExportaTintometricosTerceirosMiniFabrica.Create(
  pgbProgresso: TcxProgressBar; strIdePro: String; blnAuto: Boolean);
begin
  inherited;
  strProMIF := '';
  pPreencheEmbalagens;
  dicPrecoadicional := TDicionario.Create();
  stlTabPre := TStringList.Create();
  strAcrMob := fRetValorAcrMobCfgTin();
end;

destructor TExportaTintometricosTerceirosMiniFabrica.Destroy;
begin
  inherited;

  If Assigned(dicPrecoadicional) Then
    FreeAndNil(dicPrecoadicional);

  If Assigned(stlTabPre) Then
    FreeAndNil(stlTabPre);
end;

procedure TExportaTintometricosTerceirosMiniFabrica.Execute;
begin
  inherited;
end;

function TExportaTintometricosTerceirosMiniFabrica.fCalculaPrecoCustoConcentrado(
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

function TExportaTintometricosTerceirosMiniFabrica.fCalculaPrecoCustoDiluido(
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

function TExportaTintometricosTerceirosMiniFabrica.fCalculaPrecoCustoEmbalagem(
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

function TExportaTintometricosTerceirosMiniFabrica.fCalculaPrecoEmbalagem(
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

function TExportaTintometricosTerceirosMiniFabrica.fCalculaPrecoEmbalagem1a7(
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

function TExportaTintometricosTerceirosMiniFabrica.fCalculaPrecoVendaConcentrado(qryBases: TUniQuery; strTabelaUnica: String): Double;
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

function TExportaTintometricosTerceirosMiniFabrica.fCalculaPrecoVendaConcentrado1a7(
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

function TExportaTintometricosTerceirosMiniFabrica.fCalculaPrecoVendaDiluido(
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

function TExportaTintometricosTerceirosMiniFabrica.fCalculaPrecoVendaDiluido1a7(
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

function TExportaTintometricosTerceirosMiniFabrica.fCamposSelect: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                  ';
  Result := Result + '    MIF_CODIGO,           ';
  Result := Result + '    MIF_DESCRI,           ';
  Result := Result + '    MIF_ANOCOR,           ';
  Result := Result + '    MIF_MONTAD,           ';
  Result := Result + '    MIF_REFERE,           ';
  Result := Result + '    MIF_CODCLI,           ';
  Result := Result + '    MIF_CLIENT,           ';
  Result := Result + '    MIF_LINHA_,           ';
  Result := Result + '    MIF_DTACAD,           ';
  Result := Result + '    MIF_ACRMOB,           ';
  Result := Result + '    MIF_PADREF,           ';
  Result := Result + '    MIF_ORIGEM,           ';
  Result := Result + '    MIF_TMPCF4,           ';
  Result := Result + '    MIF_ESPDEM,           ';
  Result := Result + '    MIF_ESPSEC,           ';
  Result := Result + '    MIF_SECAGD,           ';
  Result := Result + '    MIF_SECAGM,           ';
  Result := Result + '    MIF_SECAGT,           ';
  Result := Result + '    MIF_CATALI,           ';
  Result := Result + '    MIF_ITEMCB,           ';
  Result := Result + '    MIF_ITEMCC,           ';
  Result := Result + '    MIF_BRIL20,           ';
  Result := Result + '    MIF_BRIL60,           ';
  Result := Result + '    MIF_BRIL85,           ';
  Result := Result + '    MIF_OBSERV,           ';

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    Result := Result + '    MIF_BASE' + fStrZero(intContador, 2) + ',     ';
    Result := Result + '    MIF_QTDC' + fStrZero(intContador, 2) + ',     ';
    Result := Result + '    MIF_QTDD' + fStrZero(intContador, 2) + ',     ';
  End;

  Result := Result + '    MIF_MD5KEY            ';
  Result := Result + '  FROM                    ';
  Result := Result + '    MIF_CADMIF            ';
  Result := Result + '  WHERE                   ';
  Result := Result + '    TRUE;                 ';
end;

function TExportaTintometricosTerceirosMiniFabrica.fCamposTabela: String;
begin
  Result := '';
  Result := Result + '  CREATE TABLE    ' + fNomeTabela() + '   (     ';
  Result := Result + '    MIF_CODIGO VARCHAR(15),         ';
  Result := Result + '    MIF_DESCRI VARCHAR(50),         ';
  Result := Result + '    MIF_ANOCOR CHAR(4),             ';
  Result := Result + '    MIF_MONTAD VARCHAR(50),         ';
  Result := Result + '    MIF_REFERE VARCHAR(50),         ';
  Result := Result + '    MIF_CODCLI VARCHAR(8),          ';
  Result := Result + '    MIF_CLIENT VARCHAR(60),         ';
  Result := Result + '    MIF_LINHA_ VARCHAR(50),         ';
  Result := Result + '    MIF_PADREF VARCHAR(20),         ';
  Result := Result + '    MIF_ORIGEM VARCHAR(15),         ';
  Result := Result + '    MIF_TMPCF4 DECIMAL(12,4),       ';
  Result := Result + '    MIF_ESPDEM VARCHAR(20),         ';
  Result := Result + '    MIF_ESPSEC VARCHAR(20),         ';
  Result := Result + '    MIF_SECAGD CHAR(5),             ';
  Result := Result + '    MIF_SECAGM CHAR(5),             ';
  Result := Result + '    MIF_SECAGT CHAR(5),             ';
  Result := Result + '    MIF_CATALI VARCHAR(25),         ';
  Result := Result + '    MIF_ITEMCB VARCHAR(5),          ';
  Result := Result + '    MIF_ITEMCC VARCHAR(5),          ';
  Result := Result + '    MIF_OBSERV VARCHAR(50),         ';
  Result := Result + '    MIF_BRIL20 DECIMAL(12,4),       ';
  Result := Result + '    MIF_BRIL60 DECIMAL(12,4),       ';
  Result := Result + '    MIF_BRIL85 DECIMAL(12,4),       ';
  Result := Result + '    MIF_MD5KEY VARCHAR(32),         ';
  Result := Result + '    MIF_CODITE VARCHAR(5),          ';
  Result := Result + '    MIF_CODDIL VARCHAR(20),         ';
  Result := Result + '    MIF_PORDIL DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRECLT DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRECGL DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRECLA DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRECTB DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRECSP DECIMAL(12,4),       ';
  Result := Result + '    MIF_PREDLT DECIMAL(12,4),       ';
  Result := Result + '    MIF_PREDGL DECIMAL(12,4),       ';
  Result := Result + '    MIF_PREDLA DECIMAL(12,4),       ';
  Result := Result + '    MIF_PREDTB DECIMAL(12,4),       ';
  Result := Result + '    MIF_PREDSP DECIMAL(12,4),       ';

  Result := Result + '    MIF_PCUCLT DECIMAL(12,4),       ';
  Result := Result + '    MIF_PCUCGL DECIMAL(12,4),       ';
  Result := Result + '    MIF_PCUCLA DECIMAL(12,4),       ';
  Result := Result + '    MIF_PCUCTB DECIMAL(12,4),       ';
  Result := Result + '    MIF_PCUCSP DECIMAL(12,4),       ';

  Result := Result + '    MIF_PCUDLT DECIMAL(12,4),       ';
  Result := Result + '    MIF_PCUDGL DECIMAL(12,4),       ';
  Result := Result + '    MIF_PCUDLA DECIMAL(12,4),       ';
  Result := Result + '    MIF_PCUDTB DECIMAL(12,4),       ';
  Result := Result + '    MIF_PCUDSP DECIMAL(12,4),       ';

  Result := Result + '    MIF_PRCLT1 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRCLT2 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRCLT3 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRCLT4 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRCLT5 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRCLT6 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRCLT7 DECIMAL(12,4),       ';

  Result := Result + '    MIF_PRDLT1 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRDLT2 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRDLT3 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRDLT4 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRDLT5 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRDLT6 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRDLT7 DECIMAL(12,4),       ';

  Result := Result + '    MIF_PRCGL1 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRCGL2 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRCGL3 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRCGL4 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRCGL5 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRCGL6 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRCGL7 DECIMAL(12,4),       ';

  Result := Result + '    MIF_PRDGL1 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRDGL2 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRDGL3 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRDGL4 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRDGL5 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRDGL6 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRDGL7 DECIMAL(12,4),       ';

  Result := Result + '    MIF_PRCLA1 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRCLA2 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRCLA3 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRCLA4 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRCLA5 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRCLA6 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRCLA7 DECIMAL(12,4),       ';

  Result := Result + '    MIF_PRDLA1 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRDLA2 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRDLA3 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRDLA4 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRDLA5 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRDLA6 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRDLA7 DECIMAL(12,4),       ';

  Result := Result + '    MIF_PRCTB1 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRCTB2 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRCTB3 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRCTB4 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRCTB5 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRCTB6 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRCTB7 DECIMAL(12,4),       ';

  Result := Result + '    MIF_PRDTB1 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRDTB2 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRDTB3 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRDTB4 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRDTB5 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRDTB6 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRDTB7 DECIMAL(12,4),       ';

  Result := Result + '    MIF_PRCSP1 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRCSP2 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRCSP3 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRCSP4 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRCSP5 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRCSP6 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRCSP7 DECIMAL(12,4),       ';

  Result := Result + '    MIF_PRDSP1 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRDSP2 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRDSP3 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRDSP4 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRDSP5 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRDSP6 DECIMAL(12,4),       ';
  Result := Result + '    MIF_PRDSP7 DECIMAL(12,4),       ';

  Result := Result + '    MIF_EMBALT VARCHAR(5),          ';
  Result := Result + '    MIF_EMBAGL VARCHAR(5),          ';
  Result := Result + '    MIF_EMBALA VARCHAR(5),          ';
  Result := Result + '    MIF_EMBATB VARCHAR(5),          ';
  Result := Result + '    MIF_EMBASP VARCHAR(5),          ';
  Result := Result + '    MIF_VOLULT DECIMAL(12,4),       ';
  Result := Result + '    MIF_VOLUGL DECIMAL(12,4),       ';
  Result := Result + '    MIF_VOLULA DECIMAL(12,4),       ';
  Result := Result + '    MIF_VOLUTB DECIMAL(12,4),       ';
  Result := Result + '    MIF_VOLUSP DECIMAL(12,4),       ';
  Result := Result + '    MIF_PREELT DECIMAL(12,4),       ';
  Result := Result + '    MIF_PREEGL DECIMAL(12,4),       ';
  Result := Result + '    MIF_PREELA DECIMAL(12,4),       ';
  Result := Result + '    MIF_PREETB DECIMAL(12,4),       ';
  Result := Result + '    MIF_PREESP DECIMAL(12,4),       ';
  Result := Result + '    MIF_TIPOLT CHAR(2),             ';
  Result := Result + '    MIF_TIPOGL CHAR(2),             ';
  Result := Result + '    MIF_TIPOLA CHAR(2),             ';
  Result := Result + '    MIF_TIPOTB CHAR(2),             ';
  Result := Result + '    MIF_TIPOSP CHAR(2)              ';
  Result := Result + '            );                                  ';
end;

function TExportaTintometricosTerceirosMiniFabrica.fFatorTinta: Double;
begin
  Result := 0;
end;

function TExportaTintometricosTerceirosMiniFabrica.fNomeTabela: String;
begin
  Result := 'MIF_CADMIF_SIT';
end;

function TExportaTintometricosTerceirosMiniFabrica.fQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TExportaTintometricosTerceirosMiniFabrica.fRetDescricao: String;
begin
  Result := 'MIF_DESCRI';
end;

function TExportaTintometricosTerceirosMiniFabrica.fRetEmbalagem(
  qryColorantes: TUniQuery): Double;
begin
    Result := qryColorantes.FieldByName('BAS_EMBALA').AsFloat * qryColorantes.FieldByName('BAS_PESESP').AsFloat;
end;

function TExportaTintometricosTerceirosMiniFabrica.fRetEmbalagemLA: String;
begin
  Result := 'LATEMB';
end;

function TExportaTintometricosTerceirosMiniFabrica.fRetEmbalagemGL: String;
begin
  Result := 'GALEMB';
end;

function TExportaTintometricosTerceirosMiniFabrica.fRetEmbalagemLT: String;
begin
  Result := 'LITEMB';
end;

function TExportaTintometricosTerceirosMiniFabrica.fRetEmbalagemSP: String;
begin
  Result := 'SPREMB';
end;

function TExportaTintometricosTerceirosMiniFabrica.fRetEmbalagemTB: String;
begin
  Result := 'TAMEMB';
end;

function TExportaTintometricosTerceirosMiniFabrica.fRetFormula(
  intCont: Integer): String;
begin
  Result := 'MIF_BASE' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosMiniFabrica.fRetItemBase: String;
begin
  Result := '';
end;

function TExportaTintometricosTerceirosMiniFabrica.fRetItemVenda(
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
    strSQL := strSQL + '    CFG_IDEPRO = "MIF" AND                  ';
    strSQL := strSQL + '    CFG_CODCFG = "MIFPRO" AND               ';
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

function TExportaTintometricosTerceirosMiniFabrica.fRetMD5KEY: String;
begin
  Result := 'MIF_MD5KEY';
end;

function TExportaTintometricosTerceirosMiniFabrica.fRetornaBases: String;
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
  Result := Result + '    MIF_CADBAS B            ';
  Result := Result + '  INNER JOIN CADITE I ON          ';
  Result := Result + '    B.BAS_CODITE = I.ITE_CODITE               ';
  Result := Result + '  INNER JOIN ITEGER G ON          ';
  Result := Result + '    I.ITE_CODITE = G.ITE_CODITE               ';
  Result := Result + '  WHERE                     ';
  Result := Result + '    G.ITE_CODEMP = "' + VS_strCodEmp + '"     ';
end;

function TExportaTintometricosTerceirosMiniFabrica.fRetornaCampoEmbalagem(
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
  Else If strSigEmb = 'SP' Then
    Result := fRetEmbalagemSP();
end;

function TExportaTintometricosTerceirosMiniFabrica.fRetornaCodigoDiluente(
  dicRetorno: TDicionario): String;
begin
  Result := IfNull(dicRetorno['coddil'], '');
end;

function TExportaTintometricosTerceirosMiniFabrica.fRetornaColorantes: String;
begin
  Result := '';
end;

function TExportaTintometricosTerceirosMiniFabrica.fRetornaPercentualAcrescimo(
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
    strSQL := strSQL + '    CFG_IDEPRO = "MIF" AND                ';
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

function TExportaTintometricosTerceirosMiniFabrica.fRetornaPorcentagemDiluente(
  dicRetorno: TDicionario): Double;
begin
  Result := IfNull(dicRetorno['pordil'], 0);
end;

function TExportaTintometricosTerceirosMiniFabrica.fRetornaPrecoConcentrado(
  fltPrecoTotal, fltPerAcr, fltEmbalagem: Double): Double;
begin
  Result := 0;

  If fltPrecoTotal > 0 Then
    Result := fltPrecoTotal +
      (fltPerAcr * fltPrecoTotal) + fltEmbalagem;
end;

function TExportaTintometricosTerceirosMiniFabrica.fRetornaPrecoCustoConcentrado(
  fltPrecoTotal, fltEmbalagem: Double): Double;
begin
  Result := 0;

  If fltPrecoTotal > 0 Then
    Result := fltPrecoTotal + fltEmbalagem;
end;

function TExportaTintometricosTerceirosMiniFabrica.fRetornaPrecoCustoDiluido(
  fltPrecoTotal, fltEmbalagem: Double): Double;
begin
  Result := 0;

  If fltPrecoTotal > 0 Then
    Result := fltPrecoTotal + fltEmbalagem;
end;

function TExportaTintometricosTerceirosMiniFabrica.fRetornaPrecoDiluido(
  fltPrecoTotal, fltPerAcr, fltEmbalagem: Double): Double;
begin
  Result := 0;

  If fltPrecoTotal > 0 Then
    Result := fltPrecoTotal +
      (fltPerAcr * fltPrecoTotal) + fltEmbalagem;
end;

function TExportaTintometricosTerceirosMiniFabrica.fRetQuantidade(
  intCont: Integer): String;
begin
  Result := 'MIF_QTDC' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosMiniFabrica.fRetTipoCor: String;
begin
  Result := 'MIF_LINHA_';
end;

function TExportaTintometricosTerceirosMiniFabrica.fRetValorAcrMobCfgTin: String;
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' SELECT CFG_VALCFG               ');
    qryGen.SQL.Add('    FROM CFGTIN                  ');
    qryGen.SQL.Add(' WHERE CFG_IDEPRO = "MIF" AND    ');
    qryGen.SQL.Add('       CFG_CODCFG = "ACRMOB" AND ');
    qryGen.SQL.Add('       CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
    qryGen.Open;

    Result := qryGen.FieldByName('CFG_VALCFG').AsString;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosMiniFabrica.fSQLInsert: String;
begin
  Result := '';
  Result := Result + '  INSERT INTO   ' + fNomeTabela() + '   (     ';
  Result := Result + '    MIF_CODIGO,           ';
  Result := Result + '    MIF_DESCRI,           ';
  Result := Result + '    MIF_ANOCOR,           ';
  Result := Result + '    MIF_MONTAD,           ';
  Result := Result + '    MIF_REFERE,           ';
  Result := Result + '    MIF_CODCLI,           ';
  Result := Result + '    MIF_CLIENT,           ';
  Result := Result + '    MIF_LINHA_,           ';
  Result := Result + '    MIF_PADREF,           ';
  Result := Result + '    MIF_ORIGEM,           ';
  Result := Result + '    MIF_TMPCF4,           ';
  Result := Result + '    MIF_ESPDEM,           ';
  Result := Result + '    MIF_ESPSEC,           ';
  Result := Result + '    MIF_SECAGD,           ';
  Result := Result + '    MIF_SECAGM,           ';
  Result := Result + '    MIF_SECAGT,           ';
  Result := Result + '    MIF_CATALI,           ';
  Result := Result + '    MIF_ITEMCB,           ';
  Result := Result + '    MIF_ITEMCC,           ';
  Result := Result + '    MIF_BRIL20,           ';
  Result := Result + '    MIF_BRIL60,           ';
  Result := Result + '    MIF_BRIL85,           ';
  Result := Result + '    MIF_OBSERV,           ';
  Result := Result + '    MIF_MD5KEY,           ';
  Result := Result + '    MIF_CODITE,           ';
  Result := Result + '    MIF_CODDIL,           ';
  Result := Result + '    MIF_PORDIL,           ';
  Result := Result + '    MIF_PRECLT,           ';
  Result := Result + '    MIF_PRECGL,           ';
  Result := Result + '    MIF_PRECLA,           ';
  Result := Result + '    MIF_PRECTB,           ';
  Result := Result + '    MIF_PRECSP,           ';
  Result := Result + '    MIF_PREDLT,           ';
  Result := Result + '    MIF_PREDGL,           ';
  Result := Result + '    MIF_PREDLA,           ';
  Result := Result + '    MIF_PREDTB,           ';
  Result := Result + '    MIF_PREDSP,           ';
  Result := Result + '    MIF_PCUCLT,           ';
  Result := Result + '    MIF_PCUCGL,           ';
  Result := Result + '    MIF_PCUCLA,           ';
  Result := Result + '    MIF_PCUCTB,           ';
  Result := Result + '    MIF_PCUCSP,           ';
  Result := Result + '    MIF_PCUDLT,           ';
  Result := Result + '    MIF_PCUDGL,           ';
  Result := Result + '    MIF_PCUDLA,           ';
  Result := Result + '    MIF_PCUDTB,           ';
  Result := Result + '    MIF_PCUDSP,           ';
  Result := Result + '    MIF_PRCLT1,           ';
  Result := Result + '    MIF_PRCLT2,           ';
  Result := Result + '    MIF_PRCLT3,           ';
  Result := Result + '    MIF_PRCLT4,           ';
  Result := Result + '    MIF_PRCLT5,           ';
  Result := Result + '    MIF_PRCLT6,           ';
  Result := Result + '    MIF_PRCLT7,           ';
  Result := Result + '    MIF_PRDLT1,           ';
  Result := Result + '    MIF_PRDLT2,           ';
  Result := Result + '    MIF_PRDLT3,           ';
  Result := Result + '    MIF_PRDLT4,           ';
  Result := Result + '    MIF_PRDLT5,           ';
  Result := Result + '    MIF_PRDLT6,           ';
  Result := Result + '    MIF_PRDLT7,           ';
  Result := Result + '    MIF_PRCGL1,           ';
  Result := Result + '    MIF_PRCGL2,           ';
  Result := Result + '    MIF_PRCGL3,           ';
  Result := Result + '    MIF_PRCGL4,           ';
  Result := Result + '    MIF_PRCGL5,           ';
  Result := Result + '    MIF_PRCGL6,           ';
  Result := Result + '    MIF_PRCGL7,           ';
  Result := Result + '    MIF_PRDGL1,           ';
  Result := Result + '    MIF_PRDGL2,           ';
  Result := Result + '    MIF_PRDGL3,           ';
  Result := Result + '    MIF_PRDGL4,           ';
  Result := Result + '    MIF_PRDGL5,           ';
  Result := Result + '    MIF_PRDGL6,           ';
  Result := Result + '    MIF_PRDGL7,           ';
  Result := Result + '    MIF_PRCLA1,           ';
  Result := Result + '    MIF_PRCLA2,           ';
  Result := Result + '    MIF_PRCLA3,           ';
  Result := Result + '    MIF_PRCLA4,           ';
  Result := Result + '    MIF_PRCLA5,           ';
  Result := Result + '    MIF_PRCLA6,           ';
  Result := Result + '    MIF_PRCLA7,           ';
  Result := Result + '    MIF_PRDLA1,           ';
  Result := Result + '    MIF_PRDLA2,           ';
  Result := Result + '    MIF_PRDLA3,           ';
  Result := Result + '    MIF_PRDLA4,           ';
  Result := Result + '    MIF_PRDLA5,           ';
  Result := Result + '    MIF_PRDLA6,           ';
  Result := Result + '    MIF_PRDLA7,           ';
  Result := Result + '    MIF_PRCTB1,           ';
  Result := Result + '    MIF_PRCTB2,           ';
  Result := Result + '    MIF_PRCTB3,           ';
  Result := Result + '    MIF_PRCTB4,           ';
  Result := Result + '    MIF_PRCTB5,           ';
  Result := Result + '    MIF_PRCTB6,           ';
  Result := Result + '    MIF_PRCTB7,           ';
  Result := Result + '    MIF_PRDTB1,           ';
  Result := Result + '    MIF_PRDTB2,           ';
  Result := Result + '    MIF_PRDTB3,           ';
  Result := Result + '    MIF_PRDTB4,           ';
  Result := Result + '    MIF_PRDTB5,           ';
  Result := Result + '    MIF_PRDTB6,           ';
  Result := Result + '    MIF_PRDTB7,           ';
  Result := Result + '    MIF_PRCSP1,           ';
  Result := Result + '    MIF_PRCSP2,           ';
  Result := Result + '    MIF_PRCSP3,           ';
  Result := Result + '    MIF_PRCSP4,           ';
  Result := Result + '    MIF_PRCSP5,           ';
  Result := Result + '    MIF_PRCSP6,           ';
  Result := Result + '    MIF_PRCSP7,           ';
  Result := Result + '    MIF_PRDSP1,           ';
  Result := Result + '    MIF_PRDSP2,           ';
  Result := Result + '    MIF_PRDSP3,           ';
  Result := Result + '    MIF_PRDSP4,           ';
  Result := Result + '    MIF_PRDSP5,           ';
  Result := Result + '    MIF_PRDSP6,           ';
  Result := Result + '    MIF_PRDSP7,           ';
  Result := Result + '    MIF_EMBALT,           ';
  Result := Result + '    MIF_EMBAGL,           ';
  Result := Result + '    MIF_EMBALA,           ';
  Result := Result + '    MIF_EMBATB,           ';
  Result := Result + '    MIF_EMBASP,           ';
  Result := Result + '    MIF_VOLULT,           ';
  Result := Result + '    MIF_VOLUGL,           ';
  Result := Result + '    MIF_VOLULA,           ';
  Result := Result + '    MIF_VOLUTB,           ';
  Result := Result + '    MIF_VOLUSP,           ';
  Result := Result + '    MIF_PREELT,           ';
  Result := Result + '    MIF_PREEGL,           ';
  Result := Result + '    MIF_PREELA,           ';
  Result := Result + '    MIF_PREETB,           ';
  Result := Result + '    MIF_PREESP,           ';
  Result := Result + '    MIF_TIPOLT,           ';
  Result := Result + '    MIF_TIPOGL,           ';
  Result := Result + '    MIF_TIPOLA,           ';
  Result := Result + '    MIF_TIPOTB,           ';
  Result := Result + '    MIF_TIPOSP            ';
  Result := Result + '            )                                 ';
  Result := Result + '  VALUES        (                             ';
  Result := Result + '    :CODIGO,              ';
  Result := Result + '    :DESCRI,              ';
  Result := Result + '    :ANOCOR,              ';
  Result := Result + '    :MONTAD,              ';
  Result := Result + '    :REFERE,              ';
  Result := Result + '    :CODCLI,              ';
  Result := Result + '    :CLIENT,              ';
  Result := Result + '    :LINHA_,              ';
  Result := Result + '    :PADREF,              ';
  Result := Result + '    :ORIGEM,              ';
  Result := Result + '    :TMPCF4,              ';
  Result := Result + '    :ESPDEM,              ';
  Result := Result + '    :ESPSEC,              ';
  Result := Result + '    :SECAGD,              ';
  Result := Result + '    :SECAGM,              ';
  Result := Result + '    :SECAGT,              ';
  Result := Result + '    :CATALI,              ';
  Result := Result + '    :ITEMCB,              ';
  Result := Result + '    :ITEMCC,              ';
  Result := Result + '    :BRIL20,              ';
  Result := Result + '    :BRIL60,              ';
  Result := Result + '    :BRIL85,              ';
  Result := Result + '    :OBSERV,              ';
  Result := Result + '    :MD5KEY,              ';
  Result := Result + '    :CODITE,              ';
  Result := Result + '    :CODDIL,              ';
  Result := Result + '    :PORDIL,              ';
  Result := Result + '    :PRECLT,              ';
  Result := Result + '    :PRECGL,              ';
  Result := Result + '    :PRECLA,              ';
  Result := Result + '    :PRECTB,              ';
  Result := Result + '    :PRECSP,              ';
  Result := Result + '    :PREDLT,              ';
  Result := Result + '    :PREDGL,              ';
  Result := Result + '    :PREDLA,              ';
  Result := Result + '    :PREDTB,              ';
  Result := Result + '    :PREDSP,              ';
  Result := Result + '    :PCUCLT,              ';
  Result := Result + '    :PCUCGL,              ';
  Result := Result + '    :PCUCLA,              ';
  Result := Result + '    :PCUCTB,              ';
  Result := Result + '    :PCUCSP,              ';
  Result := Result + '    :PCUDLT,              ';
  Result := Result + '    :PCUDGL,              ';
  Result := Result + '    :PCUDLA,              ';
  Result := Result + '    :PCUDTB,              ';
  Result := Result + '    :PCUDSP,              ';
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
  Result := Result + '    :EMBALT,              ';
  Result := Result + '    :EMBAGL,              ';
  Result := Result + '    :EMBALA,              ';
  Result := Result + '    :EMBATB,              ';
  Result := Result + '    :EMBASP,              ';
  Result := Result + '    :VOLULT,              ';
  Result := Result + '    :VOLUGL,              ';
  Result := Result + '    :VOLULA,              ';
  Result := Result + '    :VOLUTB,              ';
  Result := Result + '    :VOLUSP,              ';
  Result := Result + '    :PREELT,              ';
  Result := Result + '    :PREEGL,              ';
  Result := Result + '    :PREELA,              ';
  Result := Result + '    :PREETB,              ';
  Result := Result + '    :PREESP,              ';
  Result := Result + '    :TIPOLT,              ';
  Result := Result + '    :TIPOGL,              ';
  Result := Result + '    :TIPOLA,              ';
  Result := Result + '    :TIPOTB,              ';
  Result := Result + '    :TIPOSP               ';
  Result := Result + '            );                                ';
end;

function TExportaTintometricosTerceirosMiniFabrica.fValorQuantidade(fltValor,
  fltAcrMob: Double): Double;
begin
  If fltValor <= 0 Then
    Result := 0
  Else
    Result := fltValor + fltAcrMob;
end;

procedure TExportaTintometricosTerceirosMiniFabrica.pAdicionaParamentros(
  var DataSet: TFDQuery; qryTinta: TUniQuery; fltPreVen: Double; intParam: Integer = 0);
Var
  intContador: Integer;
  intEmb: Integer;
begin
  DataSet.ParamByName('CODIGO').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('MIF_CODIGO').AsString);
  DataSet.ParamByName('DESCRI').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('MIF_DESCRI').AsString);
  DataSet.ParamByName('ANOCOR').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('MIF_ANOCOR').AsString);
  DataSet.ParamByName('MONTAD').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('MIF_MONTAD').AsString);
  DataSet.ParamByName('REFERE').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('MIF_REFERE').AsString);
  DataSet.ParamByName('CODCLI').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('MIF_CODCLI').AsString);
  DataSet.ParamByName('CLIENT').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('MIF_CLIENT').AsString);
  DataSet.ParamByName('LINHA_').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('MIF_LINHA_').AsString);
  DataSet.ParamByName('MD5KEY').AsStrings[intParam] := qryTinta.FieldByName('MIF_MD5KEY').AsString;
  DataSet.ParamByName('PADREF').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('MIF_PADREF').AsString);
  DataSet.ParamByName('ORIGEM').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('MIF_ORIGEM').AsString);
  DataSet.ParamByName('ESPDEM').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('MIF_ESPDEM').AsString);
  DataSet.ParamByName('ESPSEC').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('MIF_ESPSEC').AsString);
  DataSet.ParamByName('SECAGD').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('MIF_SECAGD').AsString);
  DataSet.ParamByName('SECAGM').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('MIF_SECAGM').AsString);
  DataSet.ParamByName('SECAGT').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('MIF_SECAGT').AsString);
  DataSet.ParamByName('CATALI').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('MIF_CATALI').AsString);
  DataSet.ParamByName('ITEMCB').AsStrings[intParam] := qryTinta.FieldByName('MIF_ITEMCB').AsString;
  DataSet.ParamByName('ITEMCC').AsStrings[intParam] := qryTinta.FieldByName('MIF_ITEMCC').AsString;
  DataSet.ParamByName('OBSERV').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('MIF_OBSERV').AsString);
  DataSet.ParamByName('TMPCF4').AsFloats[intParam]  := qryTinta.FieldByName('MIF_TMPCF4').AsFloat;
  DataSet.ParamByName('BRIL20').AsFloats[intParam]  := qryTinta.FieldByName('MIF_BRIL20').AsFloat;
  DataSet.ParamByName('BRIL60').AsFloats[intParam]  := qryTinta.FieldByName('MIF_BRIL60').AsFloat;
  DataSet.ParamByName('BRIL85').AsFloats[intParam]  := qryTinta.FieldByName('MIF_BRIL85').AsFloat;
  DataSet.ParamByName('CODITE').AsStrings[intParam] := strProMIF;
  DataSet.ParamByName('PCUCLT').AsFloats[intParam]  := IfNull(dicPrecoadicional['PRECUS_CONLT'], 0.0);
  DataSet.ParamByName('PCUCGL').AsFloats[intParam]  := IfNull(dicPrecoadicional['PRECUS_CONGL'], 0.0);
  DataSet.ParamByName('PCUCLA').AsFloats[intParam]  := IfNull(dicPrecoadicional['PRECUS_CONLA'], 0.0);
  DataSet.ParamByName('PCUCTB').AsFloats[intParam]  := IfNull(dicPrecoadicional['PRECUS_CONTB'], 0.0);
  DataSet.ParamByName('PCUCSP').AsFloats[intParam]  := IfNull(dicPrecoadicional['PRECUS_CONSP'], 0.0);
  DataSet.ParamByName('PCUDLT').AsFloats[intParam]  := IfNull(dicPrecoadicional['PRECUS_DILLT'], 0.0);
  DataSet.ParamByName('PCUDGL').AsFloats[intParam]  := IfNull(dicPrecoadicional['PRECUS_DILGL'], 0.0);
  DataSet.ParamByName('PCUDLA').AsFloats[intParam]  := IfNull(dicPrecoadicional['PRECUS_DILLA'], 0.0);
  DataSet.ParamByName('PCUDTB').AsFloats[intParam]  := IfNull(dicPrecoadicional['PRECUS_DILTB'], 0.0);
  DataSet.ParamByName('PCUDSP').AsFloats[intParam]  := IfNull(dicPrecoadicional['PRECUS_DILSP'], 0.0);

  For intEmb := 0 To Length(arrEmbalagens) - 1 Do
  Begin
    If strAcrMob = '1' Then
    Begin
      arrPrecosPorEmb[intEmb].fltValCon := arrPrecosPorEmb[intEmb].fltValCon * (1 + qryTinta.FieldByName('MIF_ACRMOB').AsFloat / 100);
      arrPrecosPorEmb[intEmb].fltValDil := arrPrecosPorEmb[intEmb].fltValDil * (1 + qryTinta.FieldByName('MIF_ACRMOB').AsFloat / 100);
    End
    Else
    Begin
      arrPrecosPorEmb[intEmb].fltValCon := fValorQuantidade(arrPrecosPorEmb[intEmb].fltValCon, qryTinta.FieldByName('MIF_ACRMOB').AsFloat);
      arrPrecosPorEmb[intEmb].fltValDil := fValorQuantidade(arrPrecosPorEmb[intEmb].fltValDil, qryTinta.FieldByName('MIF_ACRMOB').AsFloat);
    End;
  End;


  For intContador := 1 To 7 Do
  Begin
    If stlTabPre[intContador] <> 'S' Then
    Begin
      DataSet.ParamByName('PRCLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoadicional['PREVE' + IntToStr(intContador) + '_CONLT'], 0.0);
      DataSet.ParamByName('PRDLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoadicional['PREVE' + IntToStr(intContador) + '_DILLT'], 0.0);
      DataSet.ParamByName('PRCGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoadicional['PREVE' + IntToStr(intContador) + '_CONGL'], 0.0);
      DataSet.ParamByName('PRDGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoadicional['PREVE' + IntToStr(intContador) + '_DILGL'], 0.0);
      DataSet.ParamByName('PRCLA' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoadicional['PREVE' + IntToStr(intContador) + '_CONLA'], 0.0);
      DataSet.ParamByName('PRDLA' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoadicional['PREVE' + IntToStr(intContador) + '_DILLA'], 0.0);
      DataSet.ParamByName('PRCTB' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoadicional['PREVE' + IntToStr(intContador) + '_CONTB'], 0.0);
      DataSet.ParamByName('PRDTB' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoadicional['PREVE' + IntToStr(intContador) + '_DILTB'], 0.0);
      DataSet.ParamByName('PRCSP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoadicional['PREVE' + IntToStr(intContador) + '_CONSP'], 0.0);
      DataSet.ParamByName('PRDSP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoadicional['PREVE' + IntToStr(intContador) + '_DILSP'], 0.0);
    End
    Else
    Begin
      If strAcrMob = '1' Then
      Begin
        DataSet.ParamByName('PRCLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoadicional['PREVE' + IntToStr(intContador) + '_CONLT'], 0.0) * (1 + qryTinta.FieldByName('MIF_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoadicional['PREVE' + IntToStr(intContador) + '_DILLT'], 0.0) * (1 + qryTinta.FieldByName('MIF_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoadicional['PREVE' + IntToStr(intContador) + '_CONGL'], 0.0) * (1 + qryTinta.FieldByName('MIF_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoadicional['PREVE' + IntToStr(intContador) + '_DILGL'], 0.0) * (1 + qryTinta.FieldByName('MIF_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCLA' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoadicional['PREVE' + IntToStr(intContador) + '_CONLA'], 0.0) * (1 + qryTinta.FieldByName('MIF_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDLA' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoadicional['PREVE' + IntToStr(intContador) + '_DILLA'], 0.0) * (1 + qryTinta.FieldByName('MIF_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCTB' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoadicional['PREVE' + IntToStr(intContador) + '_CONTB'], 0.0) * (1 + qryTinta.FieldByName('MIF_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDTB' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoadicional['PREVE' + IntToStr(intContador) + '_DILTB'], 0.0) * (1 + qryTinta.FieldByName('MIF_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCSP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoadicional['PREVE' + IntToStr(intContador) + '_CONSP'], 0.0) * (1 + qryTinta.FieldByName('MIF_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDSP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoadicional['PREVE' + IntToStr(intContador) + '_DILSP'], 0.0) * (1 + qryTinta.FieldByName('MIF_ACRMOB').AsFloat / 100);
      End
      Else
      Begin
        DataSet.ParamByName('PRCLT' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoadicional['PREVE' + IntToStr(intContador) + '_CONLT'], 0.0), qryTinta.FieldByName('MIF_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDLT' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoadicional['PREVE' + IntToStr(intContador) + '_DILLT'], 0.0), qryTinta.FieldByName('MIF_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCGL' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoadicional['PREVE' + IntToStr(intContador) + '_CONGL'], 0.0), qryTinta.FieldByName('MIF_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDGL' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoadicional['PREVE' + IntToStr(intContador) + '_DILGL'], 0.0), qryTinta.FieldByName('MIF_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCLA' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoadicional['PREVE' + IntToStr(intContador) + '_CONLA'], 0.0), qryTinta.FieldByName('MIF_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDLA' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoadicional['PREVE' + IntToStr(intContador) + '_DILLA'], 0.0), qryTinta.FieldByName('MIF_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCTB' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoadicional['PREVE' + IntToStr(intContador) + '_CONTB'], 0.0), qryTinta.FieldByName('MIF_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDTB' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoadicional['PREVE' + IntToStr(intContador) + '_DILTB'], 0.0), qryTinta.FieldByName('MIF_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCSP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoadicional['PREVE' + IntToStr(intContador) + '_CONSP'], 0.0), qryTinta.FieldByName('MIF_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDSP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoadicional['PREVE' + IntToStr(intContador) + '_DILSP'], 0.0), qryTinta.FieldByName('MIF_ACRMOB').AsFloat);
      End;
    End;
  End;
end;

procedure TExportaTintometricosTerceirosMiniFabrica.pCriaClientEmbalagem(
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
    strSQL := strSQL + '    CFG_IDEPRO = "MIF" AND                  ';
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

procedure TExportaTintometricosTerceirosMiniFabrica.pGravaTintometricoPorTintaTerceiros(
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
  {$IFNDEF LINUX}
    SetLength(arrPrecosPorEmb, 0);
  {$ENDIF}
  End;
end;

procedure TExportaTintometricosTerceirosMiniFabrica.pIncluirLogTinSite(
  Conexao: TUniConnection; strStatus: String);
Var
  qryGen: TUniQuery;
  strSQL: String;
begin
  Try
    strSQL := '';
    strSQL := strSQL + '  DELETE FROM LOGTIN_SIT WHERE LOG_IDEPRO = "MIF"       ';

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
    strSQL := strSQL + '    "MIF",              ';
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

procedure TExportaTintometricosTerceirosMiniFabrica.pPreencheArrayEmbalagem;
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

  //Tambor
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Tambor';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'TB';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 200.000;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  //Spray
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Spray';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'SP';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 0.100;
end;

procedure TExportaTintometricosTerceirosMiniFabrica.pPreencheEmbalagens;
begin
  pPreencheArrayEmbalagem;
end;

procedure TExportaTintometricosTerceirosMiniFabrica.pProcessaTabelaCores(
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
    qryInsert.Params.ArraySize := 100;
    intContador := 0;

  {$IFDEF LINUX}
    If VS_ExitProcessSignal Then
      Break;
  {$ENDIF}

    For intRegistros := 0 To Pred(100) Do
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
      fltPreven := IfNull(dicRetorno['preve'+dicRetorno['tabelaunica']], 0.0);
      pGravaTintometricoTabelasTerceiros(qryInsert, fltPreven, qryGen, intContador);

      If ((qryGen.RecNo mod 100 = 0) Or (qryGen.RecNo = intMax)) And (Not FAutoma) Then
          Synchronize(pStep);

    {$IFDEF LINUX}
      If FValidateIndexList.Contains(qryGen.RecNo) Then
      Begin
        For intEmb := 0 To Length(arrEmbalagens) - 1 Do
        Begin
          If qryGen.FieldByName('MIF_QTDC01').AsFloat > 0 Then
          Begin
            pValidarPrecoExportacao(qryGen.FieldByName(fRetMD5KEY).AsString,
              arrEmbalagens[intEmb].strNomEmb, 'C', arrEmbalagens[intEmb].strSigEmb,
              arrPrecosPorEmb[intEmb].fltValCon, dicPrecoAdicional, '_CON');
          End;

          If qryGen.FieldByName('MIF_QTDD01').AsFloat > 0 Then
          Begin
            pValidarPrecoExportacao(qryGen.FieldByName(fRetMD5KEY).AsString,
              arrEmbalagens[intEmb].strNomEmb, 'D', arrEmbalagens[intEmb].strSigEmb,
              arrPrecosPorEmb[intEmb].fltValDil, dicPrecoAdicional, '_DIL');
          End;
        End;
      End;

      SetLength(arrPrecosPorEmb, 0);
    {$ENDIF}

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

    qryInsert.Execute(intContador, 0);

  {$IFDEF LINUX}
    pEscreverLogProgresso(qryGen);
  {$ENDIF}
  End;

{$IFDEF LINUX}
  fValidarPrecosCalculado(True);
{$ENDIF}
end;

procedure TExportaTintometricosTerceirosMiniFabrica.pRecalculaFormula(
  dicRetorno: TDicionario; qryGen, qryBases: TUniQuery);
Var
  intContador: Integer;
begin
  If qryGen.FieldByName('MIF_QTDD01').AsFloat <= 0 Then
    Exit; // Concentrado

  If (qryGen.FieldByName('MIF_QTDC01').AsFloat > 0) Then //Concentrado e Diluido
  Begin
    If (qryGen.FieldByName('MIF_QTDD01').AsFloat > 0) Then
    Begin
      For intContador := 1 To fQuantidadeFormulacao() Do
      Begin

        If fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intContador, 2)], '')) Then
          Break;

        dicRetorno['qtdd' + fStrZero(intContador, 2)] := qryGen.FieldByName('MIF_QTDD' + fStrZero(intContador, 2)).AsFloat;

        dicRetorno['coddil'] := 'CONDIL';
        dicRetorno['pordil'] := 0.0;
      End;
    End;
  End
  Else If (qryGen.FieldByName('MIF_QTDC01').AsFloat <= 0) Then //Diluido
  Begin
    If (qryGen.FieldByName('MIF_QTDD01').AsFloat > 0) Then
    Begin
      For intContador := 1 To fQuantidadeFormulacao() Do
      Begin

        If fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intContador, 2)], '')) Then
          Break;

        dicRetorno['qtdb' + fStrZero(intContador, 2)] := 0.0000;
        dicRetorno['qtdd' + fStrZero(intContador, 2)] := qryGen.FieldByName('MIF_QTDD' + fStrZero(intContador, 2)).AsFloat;

        dicRetorno['pordil'] := 'DILUIDO';
        dicRetorno['pordil'] := 0.0;
      End;
    End;
  End;
end;

procedure TExportaTintometricosTerceirosMiniFabrica.pRetPrecosAdicionais(
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

  dicPrecoadicional.Limpar;

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
        ArrComponentes[intContador].Quantidade := ((dicRetorno['qtdb' + fStrZero(intContador, 2)] * arrEmbalagens[intEmb].fltVolume) / 0.9);
        ArrComponentes[intContador].Quantiddil := ((IfNull(dicRetorno['qtdd' + fStrZero(intContador, 2)], 0) * arrEmbalagens[intEmb].fltVolume) / 0.9);
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

        dicPrecoadicional['PREVE' + IntToStr(intPreVen) + '_CON' + strEmb] := fltPrecoVendaTotalCon;
        dicPrecoadicional['PREVE' + IntToStr(intPreVen) + '_DIL' + strEmb] := fltPrecoVendaTotalDil;
      End;

      //Calcula o preco de custo
      fltPrecoCustoTotalCon := fCalculaPrecoCustoConcentrado(qryBases, strTabelaUnica);
      fltPrecoCustoTotalDil := fCalculaPrecoCustoDiluido(qryBases, strTabelaUnica);
      fltPrecoEmbalagem := fCalculaPrecoCustoEmbalagem(fltPerAcr, strTabelaUnica, strCamEmb);

      fltPrecoCustoTotalCon := fRetornaPrecoCustoConcentrado(fltPrecoCustoTotalCon, fltPrecoEmbalagem);
      fltPrecoCustoTotalDil := fRetornaPrecoCustoDiluido(fltPrecoCustoTotalDil, fltPrecoEmbalagem);

      dicPrecoadicional['PRECUS_CON' + strEmb] := fltPrecoCustoTotalCon;
      dicPrecoadicional['PRECUS_DIL' + strEmb] := fltPrecoCustoTotalDil;
    Finally
      SetLength(arrComponentes, 0);
    End;
  End;
end;

procedure TExportaTintometricosTerceirosMiniFabrica.pRetPrecoTintas(
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
        ArrComponentes[intContador].Quantidade := ((dicRetorno['qtdb' + fStrZero(intContador, 2)] * arrEmbalagens[intEmb].fltVolume) / 0.9);
        ArrComponentes[intContador].Quantiddil := ((IfNull(dicRetorno['qtdd' + fStrZero(intContador, 2)], 0) * arrEmbalagens[intEmb].fltVolume) / 0.9);
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

procedure TExportaTintometricosTerceirosMiniFabrica.pRetTabelasPreco(
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

procedure TExportaTintometricosTerceirosMiniFabrica.pSetaParametrosEspecificos(
  Conexao: TUniConnection);
begin
  pCriaClientEmbalagem(Conexao);
  strProMIF:= fRetItemVenda(Conexao);
  pRetTabelasPreco(Conexao);
end;

end.
