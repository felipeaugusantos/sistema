unit untExportaTintometricosTerceirosStarmix;

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
  TExportaTintometricosTerceirosStarmix = Class(TExportaTintometricosTerceirosAutomotiva)
  Private
    strProSta: String; // Produto de venda Starmix
    fltPesCor: Double; // Variavel criada para o calculo do Preço de venda final;
    fltPesFor: Double; // Variavel criada para o calculo do Preço de venda final;
    dicPrecoAdicional: TDicionario;
    strCfgPre: String;
    stlTabPre: TStringList;
    strAcrMob: String;
    function fRetValorAcrMobCfgTin(): String;
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
      qryBases: TUniQuery; fltPerAcr: Double); override;
    procedure pGravaTintometricoPorTintaTerceiros(qryInsert: TFDQuery;
      fltPreVen: Double; qryTinta: TUniQuery; intParam: Integer = 0); override;

    function fRetEmbalagemLT(): String;
    function fRetEmbalagemGL(): String;
    function fRetEmbalagemLA(): String;
    function fRetEmbalagemCP(): String;
    function fRetEmbalagemSP(): String;
    function fRetItemVenda(Conexao: TUniConnection): String;

    procedure pCriaClientEmbalagem(Conexao: TUniConnection);
    procedure pPreencheEmbalagens;
    procedure pPreencheArrayEmbalagem;
    procedure Execute; override;

    constructor Create(pgbProgresso: TcxProgressBar; strIdePro: String; blnAuto: Boolean = False); Override;
    destructor Destroy; Override;
    function fGetTipoFormula(qryGen: TUniQuery; qryBases: TUniQuery): Integer; Override;
  End;

implementation

{ TExportaTintometricosTerceirosStarmix }

constructor TExportaTintometricosTerceirosStarmix.Create(
  pgbProgresso: TcxProgressBar; strIdePro: String; blnAuto: Boolean);
begin
  inherited;
  strProSta := '';
  pPreencheEmbalagens;
  stlTabPre := TStringList.Create;
  dicPrecoAdicional := TDicionario.Create;
  strAcrMob := fRetValorAcrMobCfgTin();
end;

destructor TExportaTintometricosTerceirosStarmix.Destroy;
begin
  inherited;
  If Assigned(dicPrecoAdicional) Then FreeAndNil(dicPrecoAdicional);
  If Assigned(stlTabPre) Then FreeAndNil(stlTabPre);
end;

procedure TExportaTintometricosTerceirosStarmix.Execute;
begin
  inherited;
end;

function TExportaTintometricosTerceirosStarmix.fCamposSelect: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                    ';
  Result := Result + '    STA_CODSEQ,             ';
  Result := Result + '    STA_NOMCOR,             ';
  Result := Result + '    STA_DTACAD,             ';
  Result := Result + '    STA_CODLIN,             ';
  Result := Result + '    STA_DESLIN,             ';
  Result := Result + '    STA_CODMON,             ';
  Result := Result + '    STA_MONTAD,             ';
  Result := Result + '    STA_UNIVER,             ';
  Result := Result + '    STA_ANOCOR,             ';
  Result := Result + '    STA_PESFOR,             ';
  Result := Result + '    STA_PESCOR,             ';
  Result := Result + '    STA_ACRMOB,             ';

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    Result := Result + '    STA_CODB' + fStrZero(intContador, 2) + ',     ';
    Result := Result + '    STA_QTDB' + fStrZero(intContador, 2) + ',     ';
  End;

  Result := Result + '    STA_MD5KEY              ';
  Result := Result + '  FROM                      ';
  Result := Result + '    STA_CADSTA              ';
  Result := Result + '  WHERE                     ';
  Result := Result + '    TRUE                    ';
end;

function TExportaTintometricosTerceirosStarmix.fCamposTabela: String;
begin
  Result := '';
  Result := Result + '  CREATE TABLE    ' + fNomeTabela() + '   (     ';
  Result := Result + '    STA_NOMCOR VARCHAR(45),           ';
  Result := Result + '    STA_CODLIN CHAR(3),               ';
  Result := Result + '    STA_DESLIN VARCHAR(50),           ';
  Result := Result + '    STA_CODMON CHAR(3),               ';
  Result := Result + '    STA_MONTAD VARCHAR(35),           ';
  Result := Result + '    STA_UNIVER VARCHAR(12),           ';
  Result := Result + '    STA_MD5KEY VARCHAR(32),           ';
  Result := Result + '    STA_CODITE VARCHAR(' + fTamCodIte.ToString() + '),            ';
  Result := Result + '    STA_CODDIL VARCHAR(20),           ';
  Result := Result + '    STA_PORDIL DECIMAL(12,4),         ';
  Result := Result + '    STA_PRECLT DECIMAL(12,4),         ';
  Result := Result + '    STA_PRECGL DECIMAL(12,4),         ';
  Result := Result + '    STA_PRECLA DECIMAL(12,4),         ';
  Result := Result + '    STA_PRECCP DECIMAL(12,4),         ';
  Result := Result + '    STA_PRECSP DECIMAL(12,4),         ';
  Result := Result + '    STA_PREDLT DECIMAL(12,4),         ';
  Result := Result + '    STA_PREDGL DECIMAL(12,4),         ';
  Result := Result + '    STA_PREDLA DECIMAL(12,4),         ';
  Result := Result + '    STA_PREDCP DECIMAL(12,4),         ';
  Result := Result + '    STA_PREDSP DECIMAL(12,4),         ';

  Result := Result + '    STA_PCUCLT DECIMAL(12,4),         '; // Preço de Custo (Concentrado Litro)
  Result := Result + '    STA_PCUDLT DECIMAL(12,4),         '; // Preço de Custo (Diluido Litro)
  Result := Result + '    STA_PCUCGL DECIMAL(12,4),         '; // Preço de Custo (Concentrado Galão)
  Result := Result + '    STA_PCUDGL DECIMAL(12,4),         '; // Preço de Custo (Diluido Galão)
  Result := Result + '    STA_PCUCLA DECIMAL(12,4),         '; // Preço de Custo (Concentrado Lata)
  Result := Result + '    STA_PCUDLA DECIMAL(12,4),         '; // Preço de Custo (Diluido Lata)
  Result := Result + '    STA_PCUCCP DECIMAL(12,4),         '; // Preço de Custo (Concentrado Copo)
  Result := Result + '    STA_PCUDCP DECIMAL(12,4),         '; // Preço de Custo (Diluido Copo)
  Result := Result + '    STA_PCUCSP DECIMAL(12,4),         '; // Preço de Custo (Concentrado Spray)
  Result := Result + '    STA_PCUDSP DECIMAL(12,4),         '; // Preço de Custo (Diluido Spray)

  Result := Result + '    STA_PRCLT1 DECIMAL(12,4),         '; // Preço de Venda - PREVE1 (Tabela de Clientes) - Litro Concentrado
  Result := Result + '    STA_PRCLT2 DECIMAL(12,4),         '; // Preço de Venda - PREVE2 (Tabela de Clientes) - Litro Concentrado
  Result := Result + '    STA_PRCLT3 DECIMAL(12,4),         '; // Preço de Venda - PREVE3 (Tabela de Clientes) - Litro Concentrado
  Result := Result + '    STA_PRCLT4 DECIMAL(12,4),         '; // Preço de Venda - PREVE4 (Tabela de Clientes) - Litro Concentrado
  Result := Result + '    STA_PRCLT5 DECIMAL(12,4),         '; // Preço de Venda - PREVE5 (Tabela de Clientes) - Litro Concentrado
  Result := Result + '    STA_PRCLT6 DECIMAL(12,4),         '; // Preço de Venda - PREVE6 (Tabela de Clientes) - Litro Concentrado
  Result := Result + '    STA_PRCLT7 DECIMAL(12,4),         '; // Preço de Venda - PREVE7 (Tabela de Clientes) - Litro Concentrado

  Result := Result + '    STA_PRDLT1 DECIMAL(12,4),         '; // Preço de Venda - PREVE1 (Tabela de Clientes) - Litro Diluido
  Result := Result + '    STA_PRDLT2 DECIMAL(12,4),         '; // Preço de Venda - PREVE2 (Tabela de Clientes) - Litro Diluido
  Result := Result + '    STA_PRDLT3 DECIMAL(12,4),         '; // Preço de Venda - PREVE3 (Tabela de Clientes) - Litro Diluido
  Result := Result + '    STA_PRDLT4 DECIMAL(12,4),         '; // Preço de Venda - PREVE4 (Tabela de Clientes) - Litro Diluido
  Result := Result + '    STA_PRDLT5 DECIMAL(12,4),         '; // Preço de Venda - PREVE5 (Tabela de Clientes) - Litro Diluido
  Result := Result + '    STA_PRDLT6 DECIMAL(12,4),         '; // Preço de Venda - PREVE6 (Tabela de Clientes) - Litro Diluido
  Result := Result + '    STA_PRDLT7 DECIMAL(12,4),         '; // Preço de Venda - PREVE7 (Tabela de Clientes) - Litro Diluido

  Result := Result + '    STA_PRCGL1 DECIMAL(12,4),         '; // Preço de Venda - PREVE1 (Tabela de Clientes) - Galão Concentrado
  Result := Result + '    STA_PRCGL2 DECIMAL(12,4),         '; // Preço de Venda - PREVE2 (Tabela de Clientes) - Galão Concentrado
  Result := Result + '    STA_PRCGL3 DECIMAL(12,4),         '; // Preço de Venda - PREVE3 (Tabela de Clientes) - Galão Concentrado
  Result := Result + '    STA_PRCGL4 DECIMAL(12,4),         '; // Preço de Venda - PREVE4 (Tabela de Clientes) - Galão Concentrado
  Result := Result + '    STA_PRCGL5 DECIMAL(12,4),         '; // Preço de Venda - PREVE5 (Tabela de Clientes) - Galão Concentrado
  Result := Result + '    STA_PRCGL6 DECIMAL(12,4),         '; // Preço de Venda - PREVE6 (Tabela de Clientes) - Galão Concentrado
  Result := Result + '    STA_PRCGL7 DECIMAL(12,4),         '; // Preço de Venda - PREVE7 (Tabela de Clientes) - Galão Concentrado

  Result := Result + '    STA_PRDGL1 DECIMAL(12,4),         '; // Preço de Venda - PREVE1 (Tabela de Clientes) - Galão Diluido
  Result := Result + '    STA_PRDGL2 DECIMAL(12,4),         '; // Preço de Venda - PREVE2 (Tabela de Clientes) - Galão Diluido
  Result := Result + '    STA_PRDGL3 DECIMAL(12,4),         '; // Preço de Venda - PREVE3 (Tabela de Clientes) - Galão Diluido
  Result := Result + '    STA_PRDGL4 DECIMAL(12,4),         '; // Preço de Venda - PREVE4 (Tabela de Clientes) - Galão Diluido
  Result := Result + '    STA_PRDGL5 DECIMAL(12,4),         '; // Preço de Venda - PREVE5 (Tabela de Clientes) - Galão Diluido
  Result := Result + '    STA_PRDGL6 DECIMAL(12,4),         '; // Preço de Venda - PREVE6 (Tabela de Clientes) - Galão Diluido
  Result := Result + '    STA_PRDGL7 DECIMAL(12,4),         '; // Preço de Venda - PREVE7 (Tabela de Clientes) - Galão Diluido

  Result := Result + '    STA_PRCLA1 DECIMAL(12,4),         '; // Preço de Venda - PREVE1 (Tabela de Clientes) - Lata Concentrado
  Result := Result + '    STA_PRCLA2 DECIMAL(12,4),         '; // Preço de Venda - PREVE2 (Tabela de Clientes) - Lata Concentrado
  Result := Result + '    STA_PRCLA3 DECIMAL(12,4),         '; // Preço de Venda - PREVE3 (Tabela de Clientes) - Lata Concentrado
  Result := Result + '    STA_PRCLA4 DECIMAL(12,4),         '; // Preço de Venda - PREVE4 (Tabela de Clientes) - Lata Concentrado
  Result := Result + '    STA_PRCLA5 DECIMAL(12,4),         '; // Preço de Venda - PREVE5 (Tabela de Clientes) - Lata Concentrado
  Result := Result + '    STA_PRCLA6 DECIMAL(12,4),         '; // Preço de Venda - PREVE6 (Tabela de Clientes) - Lata Concentrado
  Result := Result + '    STA_PRCLA7 DECIMAL(12,4),         '; // Preço de Venda - PREVE7 (Tabela de Clientes) - Lata Concentrado

  Result := Result + '    STA_PRDLA1 DECIMAL(12,4),         '; // Preço de Venda - PREVE1 (Tabela de Clientes) - Lata Diluido
  Result := Result + '    STA_PRDLA2 DECIMAL(12,4),         '; // Preço de Venda - PREVE2 (Tabela de Clientes) - Lata Diluido
  Result := Result + '    STA_PRDLA3 DECIMAL(12,4),         '; // Preço de Venda - PREVE3 (Tabela de Clientes) - Lata Diluido
  Result := Result + '    STA_PRDLA4 DECIMAL(12,4),         '; // Preço de Venda - PREVE4 (Tabela de Clientes) - Lata Diluido
  Result := Result + '    STA_PRDLA5 DECIMAL(12,4),         '; // Preço de Venda - PREVE5 (Tabela de Clientes) - Lata Diluido
  Result := Result + '    STA_PRDLA6 DECIMAL(12,4),         '; // Preço de Venda - PREVE6 (Tabela de Clientes) - Lata Diluido
  Result := Result + '    STA_PRDLA7 DECIMAL(12,4),         '; // Preço de Venda - PREVE7 (Tabela de Clientes) - Lata Diluido

  Result := Result + '    STA_PRCCP1 DECIMAL(12,4),         '; // Preço de Venda - PREVE1 (Tabela de Clientes) - Copo Concentrado
  Result := Result + '    STA_PRCCP2 DECIMAL(12,4),         '; // Preço de Venda - PREVE2 (Tabela de Clientes) - Copo Concentrado
  Result := Result + '    STA_PRCCP3 DECIMAL(12,4),         '; // Preço de Venda - PREVE3 (Tabela de Clientes) - Copo Concentrado
  Result := Result + '    STA_PRCCP4 DECIMAL(12,4),         '; // Preço de Venda - PREVE4 (Tabela de Clientes) - Copo Concentrado
  Result := Result + '    STA_PRCCP5 DECIMAL(12,4),         '; // Preço de Venda - PREVE5 (Tabela de Clientes) - Copo Concentrado
  Result := Result + '    STA_PRCCP6 DECIMAL(12,4),         '; // Preço de Venda - PREVE6 (Tabela de Clientes) - Copo Concentrado
  Result := Result + '    STA_PRCCP7 DECIMAL(12,4),         '; // Preço de Venda - PREVE7 (Tabela de Clientes) - Copo Concentrado

  Result := Result + '    STA_PRDCP1 DECIMAL(12,4),         '; // Preço de Venda - PREVE1 (Tabela de Clientes) - Copo Diluido
  Result := Result + '    STA_PRDCP2 DECIMAL(12,4),         '; // Preço de Venda - PREVE2 (Tabela de Clientes) - Copo Diluido
  Result := Result + '    STA_PRDCP3 DECIMAL(12,4),         '; // Preço de Venda - PREVE3 (Tabela de Clientes) - Copo Diluido
  Result := Result + '    STA_PRDCP4 DECIMAL(12,4),         '; // Preço de Venda - PREVE4 (Tabela de Clientes) - Copo Diluido
  Result := Result + '    STA_PRDCP5 DECIMAL(12,4),         '; // Preço de Venda - PREVE5 (Tabela de Clientes) - Copo Diluido
  Result := Result + '    STA_PRDCP6 DECIMAL(12,4),         '; // Preço de Venda - PREVE6 (Tabela de Clientes) - Copo Diluido
  Result := Result + '    STA_PRDCP7 DECIMAL(12,4),         '; // Preço de Venda - PREVE7 (Tabela de Clientes) - Copo Diluido

  Result := Result + '    STA_PRCSP1 DECIMAL(12,4),         '; // Preço de Venda - PREVE1 (Tabela de Clientes) - Spray Concentrado
  Result := Result + '    STA_PRCSP2 DECIMAL(12,4),         '; // Preço de Venda - PREVE2 (Tabela de Clientes) - Spray Concentrado
  Result := Result + '    STA_PRCSP3 DECIMAL(12,4),         '; // Preço de Venda - PREVE3 (Tabela de Clientes) - Spray Concentrado
  Result := Result + '    STA_PRCSP4 DECIMAL(12,4),         '; // Preço de Venda - PREVE4 (Tabela de Clientes) - Spray Concentrado
  Result := Result + '    STA_PRCSP5 DECIMAL(12,4),         '; // Preço de Venda - PREVE5 (Tabela de Clientes) - Spray Concentrado
  Result := Result + '    STA_PRCSP6 DECIMAL(12,4),         '; // Preço de Venda - PREVE6 (Tabela de Clientes) - Spray Concentrado
  Result := Result + '    STA_PRCSP7 DECIMAL(12,4),         '; // Preço de Venda - PREVE7 (Tabela de Clientes) - Spray Concentrado

  Result := Result + '    STA_PRDSP1 DECIMAL(12,4),         '; // Preço de Venda - PREVE1 (Tabela de Clientes) - Spray Diluido
  Result := Result + '    STA_PRDSP2 DECIMAL(12,4),         '; // Preço de Venda - PREVE2 (Tabela de Clientes) - Spray Diluido
  Result := Result + '    STA_PRDSP3 DECIMAL(12,4),         '; // Preço de Venda - PREVE3 (Tabela de Clientes) - Spray Diluido
  Result := Result + '    STA_PRDSP4 DECIMAL(12,4),         '; // Preço de Venda - PREVE4 (Tabela de Clientes) - Spray Diluido
  Result := Result + '    STA_PRDSP5 DECIMAL(12,4),         '; // Preço de Venda - PREVE5 (Tabela de Clientes) - Spray Diluido
  Result := Result + '    STA_PRDSP6 DECIMAL(12,4),         '; // Preço de Venda - PREVE6 (Tabela de Clientes) - Spray Diluido
  Result := Result + '    STA_PRDSP7 DECIMAL(12,4),         '; // Preço de Venda - PREVE7 (Tabela de Clientes) - Spray Diluido


  Result := Result + '    STA_EMBALT VARCHAR(' + fTamCodIte.ToString() + '),            ';
  Result := Result + '    STA_EMBAGL VARCHAR(' + fTamCodIte.ToString() + '),            ';
  Result := Result + '    STA_EMBALA VARCHAR(' + fTamCodIte.ToString() + '),            ';
  Result := Result + '    STA_EMBACP VARCHAR(' + fTamCodIte.ToString() + '),            ';
  Result := Result + '    STA_EMBASP VARCHAR(' + fTamCodIte.ToString() + '),            ';
  Result := Result + '    STA_VOLULT DECIMAL(12,4),         ';
  Result := Result + '    STA_VOLUGL DECIMAL(12,4),         ';
  Result := Result + '    STA_VOLULA DECIMAL(12,4),         ';
  Result := Result + '    STA_VOLUCP DECIMAL(12,4),         ';
  Result := Result + '    STA_VOLUSP DECIMAL(12,4),         ';
  Result := Result + '    STA_PREELT DECIMAL(12,4),         ';
  Result := Result + '    STA_PREEGL DECIMAL(12,4),         ';
  Result := Result + '    STA_PREELA DECIMAL(12,4),         ';
  Result := Result + '    STA_PREECP DECIMAL(12,4),         ';
  Result := Result + '    STA_PREESP DECIMAL(12,4),         ';
  Result := Result + '    STA_TIPOLT CHAR(2),               ';
  Result := Result + '    STA_TIPOGL CHAR(2),               ';
  Result := Result + '    STA_TIPOLA CHAR(2),               ';
  Result := Result + '    STA_TIPOCP CHAR(2),               ';
  Result := Result + '    STA_TIPOSP CHAR(2)                ';
  Result := Result + '            );                        ';
end;

function TExportaTintometricosTerceirosStarmix.fFatorTinta: Double;
begin
  Result := 0;
end;

function TExportaTintometricosTerceirosStarmix.fGetTipoFormula(qryGen,
  qryBases: TUniQuery): Integer;
Var
  intContador: Integer;
begin
  Result := 0;

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    If fEmptyStr(qryGen.FieldByName('STA_CODB' + fStrZero(intContador, 2)).AsString) Then
      Break;

    If Not qryBases.Locate('BAS_CODBAS', qryGen.FieldByName('STA_CODB' + fStrZero(intContador, 2)).AsString, []) Then
    Begin
      Result := 3;
      Break;
    End;
  End;
end;

function TExportaTintometricosTerceirosStarmix.fNomeTabela: String;
begin
  Result := 'STA_CADSTA_SIT';
end;

function TExportaTintometricosTerceirosStarmix.fQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TExportaTintometricosTerceirosStarmix.fRetDescricao: String;
begin
  Result := 'STA_NOMCOR';
end;

function TExportaTintometricosTerceirosStarmix.fRetEmbalagem(
  qryColorantes: TUniQuery): Double;
begin
  Result := qryColorantes.FieldByName('BAS_VOLUME').AsFloat;
end;

function TExportaTintometricosTerceirosStarmix.fRetEmbalagemCP: String;
begin
  Result := 'STAICO';
end;

function TExportaTintometricosTerceirosStarmix.fRetEmbalagemGL: String;
begin
  Result := 'STAIGL';
end;

function TExportaTintometricosTerceirosStarmix.fRetEmbalagemLA: String;
begin
  Result := 'STAILA';
end;

function TExportaTintometricosTerceirosStarmix.fRetEmbalagemLT: String;
begin
  Result := 'STAIEM';
end;

function TExportaTintometricosTerceirosStarmix.fRetEmbalagemSP: String;
begin
  Result := 'STAISP';
end;

function TExportaTintometricosTerceirosStarmix.fRetFormula(
  intCont: Integer): String;
begin
  Result := 'STA_CODB' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosStarmix.fRetItemBase: String;
begin
  Result := '';
end;

function TExportaTintometricosTerceirosStarmix.fRetItemVenda(
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
    strSQL := strSQL + '    CFG_IDEPRO = "STA" AND                  ';
    strSQL := strSQL + '    CFG_CODCFG = "PROSTA" AND               ';
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

function TExportaTintometricosTerceirosStarmix.fRetMD5KEY: String;
begin
  Result := 'STA_MD5KEY';
end;

function TExportaTintometricosTerceirosStarmix.fRetornaBases: String;
begin
  Result := '';
  Result := Result + '  SELECT                ';
  Result := Result + '    BAS_CODBAS,         ';
  Result := Result + '    BAS_CODITE,         ';
  Result := Result + '    BAS_DESBAS,         ';
  Result := Result + '    BAS_VOLUME,         ';
  Result := Result + '    BAS_PESESP,         ';
  Result := Result + '    ITE_PREVE' + fRetornaTabelaPreco + ' AS ITE_PREVEN,        ';
  Result := Result + '    G.ITE_PRECUS AS PRECUS,     ';
  Result := Result + '    G.ITE_PREVE1 AS PREVE1,     ';
  Result := Result + '    G.ITE_PREVE2 AS PREVE2,     ';
  Result := Result + '    G.ITE_PREVE3 AS PREVE3,     ';
  Result := Result + '    G.ITE_PREVE4 AS PREVE4,     ';
  Result := Result + '    G.ITE_PREVE5 AS PREVE5,     ';
  Result := Result + '    G.ITE_PREVE6 AS PREVE6,     ';
  Result := Result + '    G.ITE_PREVE7 AS PREVE7      ';
  Result := Result + '  FROM                  ';
  Result := Result + '    STA_CADBAS B        ';
  Result := Result + '  INNER JOIN CADITE I ON          ';
  Result := Result + '    B.BAS_CODITE = I.ITE_CODITE               ';
  Result := Result + '  INNER JOIN ITEGER G ON          ';
  Result := Result + '    I.ITE_CODITE = G.ITE_CODITE               ';
  Result := Result + '  WHERE                 ';
  Result := Result + '    G.ITE_CODEMP = "' + VS_strCodEmp + '"     ';
end;

function TExportaTintometricosTerceirosStarmix.fRetornaCampoEmbalagem(
  strSigEmb: String; dicRetorno: TDicionario): String;
begin
  Result := '';

  If strSigEmb = 'LT' Then
    Result := fRetEmbalagemLT()
  Else If strSigEmb = 'GL' Then
    Result := fRetEmbalagemGL()
  Else If strSigEmb = 'LA' Then
    Result := fRetEmbalagemLA()
  Else If strSigEmb = 'CP' Then
    Result := fRetEmbalagemCP()
  Else If strSigEmb = 'SP' Then
    Result := fRetEmbalagemSP();
end;

function TExportaTintometricosTerceirosStarmix.fRetornaCodigoDiluente(
  dicRetorno: TDicionario): String;
begin
  Result := IfNull(dicRetorno['coddil'], '');
end;

function TExportaTintometricosTerceirosStarmix.fRetornaColorantes: String;
begin
  Result := '';
end;

function TExportaTintometricosTerceirosStarmix.fRetornaPercentualAcrescimo(
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
    strSQL := strSQL + '    CFG_IDEPRO = "STA" AND                ';
    strSQL := strSQL + '    CFG_CODCFG = "APREVE" AND             ';
    strSQL := strSQL + '    CFG_CODEMP = "' + VS_strCodEmp + '"   ';

    qryGen := fCriaQuery(Nil, Conexao);
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.Open;

    If Not fEmptyStr(qryGen.FieldByName('CFG_VALCFG').AsString) Then
      Result := (fStrToFloat(qryGen.FieldByName('CFG_VALCFG').ASString) / 100.0);

  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosStarmix.fRetornaPorcentagemDiluente(
  dicRetorno: TDicionario): Double;
begin
  Result := IfNull(dicRetorno['pordil'], 0);
end;

function TExportaTintometricosTerceirosStarmix.fRetQuantidade(
  intCont: Integer): String;
begin
  Result := 'STA_QTDB' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosStarmix.fRetTipoCor: String;
begin
  Result := 'STA_NOMCOR';
end;

function TExportaTintometricosTerceirosStarmix.fRetValorAcrMobCfgTin: String;
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' SELECT CFG_VALCFG               ');
    qryGen.SQL.Add('    FROM CFGTIN                  ');
    qryGen.SQL.Add(' WHERE CFG_IDEPRO = "STA" AND    ');
    qryGen.SQL.Add('       CFG_CODCFG = "ACRMOB" AND ');
    qryGen.SQL.Add('       CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
    qryGen.Open;

    Result := qryGen.FieldByName('CFG_VALCFG').AsString;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosStarmix.fSQLInsert: String;
begin
  Result := '';
  Result := Result + '  INSERT INTO   ' + fNomeTabela() + '   (     ';
  Result := Result + '    STA_NOMCOR,         ';
  Result := Result + '    STA_CODLIN,         ';
  Result := Result + '    STA_DESLIN,         ';
  Result := Result + '    STA_CODMON,         ';
  Result := Result + '    STA_MONTAD,         ';
  Result := Result + '    STA_UNIVER,         ';
  Result := Result + '    STA_MD5KEY,         ';
  Result := Result + '    STA_CODITE,         ';
  Result := Result + '    STA_CODDIL,         ';
  Result := Result + '    STA_PORDIL,         ';
  Result := Result + '    STA_PRECLT,         ';
  Result := Result + '    STA_PRECGL,         ';
  Result := Result + '    STA_PRECLA,         ';
  Result := Result + '    STA_PRECCP,         ';
  Result := Result + '    STA_PRECSP,         ';
  Result := Result + '    STA_PREDLT,         ';
  Result := Result + '    STA_PREDGL,         ';
  Result := Result + '    STA_PREDLA,         ';
  Result := Result + '    STA_PREDCP,         ';
  Result := Result + '    STA_PREDSP,         ';

  //Preços de custos
  Result := Result + '    STA_PCUCLT,         ';
  Result := Result + '    STA_PCUDLT,         ';
  Result := Result + '    STA_PCUCGL,         ';
  Result := Result + '    STA_PCUDGL,         ';
  Result := Result + '    STA_PCUCLA,         ';
  Result := Result + '    STA_PCUDLA,         ';
  Result := Result + '    STA_PCUCCP,         ';
  Result := Result + '    STA_PCUDCP,         ';
  Result := Result + '    STA_PCUCSP,         ';
  Result := Result + '    STA_PCUDSP,         ';

  //**INICIO - Preços de Vendas

  Result := Result + '    STA_PRCLT1,         ';
  Result := Result + '    STA_PRCLT2,         ';
  Result := Result + '    STA_PRCLT3,         ';
  Result := Result + '    STA_PRCLT4,         ';
  Result := Result + '    STA_PRCLT5,         ';
  Result := Result + '    STA_PRCLT6,         ';
  Result := Result + '    STA_PRCLT7,         ';

  Result := Result + '    STA_PRDLT1,         ';
  Result := Result + '    STA_PRDLT2,         ';
  Result := Result + '    STA_PRDLT3,         ';
  Result := Result + '    STA_PRDLT4,         ';
  Result := Result + '    STA_PRDLT5,         ';
  Result := Result + '    STA_PRDLT6,         ';
  Result := Result + '    STA_PRDLT7,         ';

  Result := Result + '    STA_PRCGL1,         ';
  Result := Result + '    STA_PRCGL2,         ';
  Result := Result + '    STA_PRCGL3,         ';
  Result := Result + '    STA_PRCGL4,         ';
  Result := Result + '    STA_PRCGL5,         ';
  Result := Result + '    STA_PRCGL6,         ';
  Result := Result + '    STA_PRCGL7,         ';

  Result := Result + '    STA_PRDGL1,         ';
  Result := Result + '    STA_PRDGL2,         ';
  Result := Result + '    STA_PRDGL3,         ';
  Result := Result + '    STA_PRDGL4,         ';
  Result := Result + '    STA_PRDGL5,         ';
  Result := Result + '    STA_PRDGL6,         ';
  Result := Result + '    STA_PRDGL7,         ';

  Result := Result + '    STA_PRCLA1,         ';
  Result := Result + '    STA_PRCLA2,         ';
  Result := Result + '    STA_PRCLA3,         ';
  Result := Result + '    STA_PRCLA4,         ';
  Result := Result + '    STA_PRCLA5,         ';
  Result := Result + '    STA_PRCLA6,         ';
  Result := Result + '    STA_PRCLA7,         ';

  Result := Result + '    STA_PRDLA1,         ';
  Result := Result + '    STA_PRDLA2,         ';
  Result := Result + '    STA_PRDLA3,         ';
  Result := Result + '    STA_PRDLA4,         ';
  Result := Result + '    STA_PRDLA5,         ';
  Result := Result + '    STA_PRDLA6,         ';
  Result := Result + '    STA_PRDLA7,         ';

  Result := Result + '    STA_PRCCP1,         ';
  Result := Result + '    STA_PRCCP2,         ';
  Result := Result + '    STA_PRCCP3,         ';
  Result := Result + '    STA_PRCCP4,         ';
  Result := Result + '    STA_PRCCP5,         ';
  Result := Result + '    STA_PRCCP6,         ';
  Result := Result + '    STA_PRCCP7,         ';

  Result := Result + '    STA_PRDCP1,         ';
  Result := Result + '    STA_PRDCP2,         ';
  Result := Result + '    STA_PRDCP3,         ';
  Result := Result + '    STA_PRDCP4,         ';
  Result := Result + '    STA_PRDCP5,         ';
  Result := Result + '    STA_PRDCP6,         ';
  Result := Result + '    STA_PRDCP7,         ';

  Result := Result + '    STA_PRCSP1,         ';
  Result := Result + '    STA_PRCSP2,         ';
  Result := Result + '    STA_PRCSP3,         ';
  Result := Result + '    STA_PRCSP4,         ';
  Result := Result + '    STA_PRCSP5,         ';
  Result := Result + '    STA_PRCSP6,         ';
  Result := Result + '    STA_PRCSP7,         ';

  Result := Result + '    STA_PRDSP1,         ';
  Result := Result + '    STA_PRDSP2,         ';
  Result := Result + '    STA_PRDSP3,         ';
  Result := Result + '    STA_PRDSP4,         ';
  Result := Result + '    STA_PRDSP5,         ';
  Result := Result + '    STA_PRDSP6,         ';
  Result := Result + '    STA_PRDSP7,         ';

  //** FINAL - Preços de Vendas

  Result := Result + '    STA_EMBALT,         ';
  Result := Result + '    STA_EMBAGL,         ';
  Result := Result + '    STA_EMBALA,         ';
  Result := Result + '    STA_EMBACP,         ';
  Result := Result + '    STA_EMBASP,         ';
  Result := Result + '    STA_VOLULT,         ';
  Result := Result + '    STA_VOLUGL,         ';
  Result := Result + '    STA_VOLULA,         ';
  Result := Result + '    STA_VOLUCP,         ';
  Result := Result + '    STA_VOLUSP,         ';
  Result := Result + '    STA_PREELT,         ';
  Result := Result + '    STA_PREEGL,         ';
  Result := Result + '    STA_PREELA,         ';
  Result := Result + '    STA_PREECP,         ';
  Result := Result + '    STA_PREESP,         ';
  Result := Result + '    STA_TIPOLT,         ';
  Result := Result + '    STA_TIPOGL,         ';
  Result := Result + '    STA_TIPOLA,         ';
  Result := Result + '    STA_TIPOCP,         ';
  Result := Result + '    STA_TIPOSP          ';
  Result := Result + '            )                                 ';
  Result := Result + '  VALUES        (                             ';
  Result := Result + '    :NOMCOR,            ';
  Result := Result + '    :CODLIN,            ';
  Result := Result + '    :DESLIN,            ';
  Result := Result + '    :CODMON,            ';
  Result := Result + '    :MONTAD,            ';
  Result := Result + '    :UNIVER,            ';
  Result := Result + '    :MD5KEY,            ';
  Result := Result + '    :CODITE,            ';
  Result := Result + '    :CODDIL,            ';
  Result := Result + '    :PORDIL,            ';
  Result := Result + '    :PRECLT,            ';
  Result := Result + '    :PRECGL,            ';
  Result := Result + '    :PRECLA,            ';
  Result := Result + '    :PRECCP,            ';
  Result := Result + '    :PRECSP,            ';
  Result := Result + '    :PREDLT,            ';
  Result := Result + '    :PREDGL,            ';
  Result := Result + '    :PREDLA,            ';
  Result := Result + '    :PREDCP,            ';
  Result := Result + '    :PREDSP,            ';

  Result := Result + '    :PCUCLT,            ';
  Result := Result + '    :PCUDLT,            ';
  Result := Result + '    :PCUCGL,            ';
  Result := Result + '    :PCUDGL,            ';
  Result := Result + '    :PCUCLA,            ';
  Result := Result + '    :PCUDLA,            ';
  Result := Result + '    :PCUCCP,            ';
  Result := Result + '    :PCUDCP,            ';
  Result := Result + '    :PCUCSP,            ';
  Result := Result + '    :PCUDSP,            ';

  Result := Result + '    :PRCLT1,            ';
  Result := Result + '    :PRCLT2,            ';
  Result := Result + '    :PRCLT3,            ';
  Result := Result + '    :PRCLT4,            ';
  Result := Result + '    :PRCLT5,            ';
  Result := Result + '    :PRCLT6,            ';
  Result := Result + '    :PRCLT7,            ';

  Result := Result + '    :PRDLT1,            ';
  Result := Result + '    :PRDLT2,            ';
  Result := Result + '    :PRDLT3,            ';
  Result := Result + '    :PRDLT4,            ';
  Result := Result + '    :PRDLT5,            ';
  Result := Result + '    :PRDLT6,            ';
  Result := Result + '    :PRDLT7,            ';

  Result := Result + '    :PRCGL1,            ';
  Result := Result + '    :PRCGL2,            ';
  Result := Result + '    :PRCGL3,            ';
  Result := Result + '    :PRCGL4,            ';
  Result := Result + '    :PRCGL5,            ';
  Result := Result + '    :PRCGL6,            ';
  Result := Result + '    :PRCGL7,            ';

  Result := Result + '    :PRDGL1,            ';
  Result := Result + '    :PRDGL2,            ';
  Result := Result + '    :PRDGL3,            ';
  Result := Result + '    :PRDGL4,            ';
  Result := Result + '    :PRDGL5,            ';
  Result := Result + '    :PRDGL6,            ';
  Result := Result + '    :PRDGL7,            ';

  Result := Result + '    :PRCLA1,            ';
  Result := Result + '    :PRCLA2,            ';
  Result := Result + '    :PRCLA3,            ';
  Result := Result + '    :PRCLA4,            ';
  Result := Result + '    :PRCLA5,            ';
  Result := Result + '    :PRCLA6,            ';
  Result := Result + '    :PRCLA7,            ';

  Result := Result + '    :PRDLA1,            ';
  Result := Result + '    :PRDLA2,            ';
  Result := Result + '    :PRDLA3,            ';
  Result := Result + '    :PRDLA4,            ';
  Result := Result + '    :PRDLA5,            ';
  Result := Result + '    :PRDLA6,            ';
  Result := Result + '    :PRDLA7,            ';

  Result := Result + '    :PRCCP1,            ';
  Result := Result + '    :PRCCP2,            ';
  Result := Result + '    :PRCCP3,            ';
  Result := Result + '    :PRCCP4,            ';
  Result := Result + '    :PRCCP5,            ';
  Result := Result + '    :PRCCP6,            ';
  Result := Result + '    :PRCCP7,            ';

  Result := Result + '    :PRDCP1,            ';
  Result := Result + '    :PRDCP2,            ';
  Result := Result + '    :PRDCP3,            ';
  Result := Result + '    :PRDCP4,            ';
  Result := Result + '    :PRDCP5,            ';
  Result := Result + '    :PRDCP6,            ';
  Result := Result + '    :PRDCP7,            ';

  Result := Result + '    :PRCSP1,            ';
  Result := Result + '    :PRCSP2,            ';
  Result := Result + '    :PRCSP3,            ';
  Result := Result + '    :PRCSP4,            ';
  Result := Result + '    :PRCSP5,            ';
  Result := Result + '    :PRCSP6,            ';
  Result := Result + '    :PRCSP7,            ';

  Result := Result + '    :PRDSP1,            ';
  Result := Result + '    :PRDSP2,            ';
  Result := Result + '    :PRDSP3,            ';
  Result := Result + '    :PRDSP4,            ';
  Result := Result + '    :PRDSP5,            ';
  Result := Result + '    :PRDSP6,            ';
  Result := Result + '    :PRDSP7,            ';

  Result := Result + '    :EMBALT,            ';
  Result := Result + '    :EMBAGL,            ';
  Result := Result + '    :EMBALA,            ';
  Result := Result + '    :EMBACP,            ';
  Result := Result + '    :EMBASP,            ';
  Result := Result + '    :VOLULT,            ';
  Result := Result + '    :VOLUGL,            ';
  Result := Result + '    :VOLULA,            ';
  Result := Result + '    :VOLUCP,            ';
  Result := Result + '    :VOLUSP,            ';
  Result := Result + '    :PREELT,            ';
  Result := Result + '    :PREEGL,            ';
  Result := Result + '    :PREELA,            ';
  Result := Result + '    :PREECP,            ';
  Result := Result + '    :PREESP,            ';
  Result := Result + '    :TIPOLT,            ';
  Result := Result + '    :TIPOGL,            ';
  Result := Result + '    :TIPOLA,            ';
  Result := Result + '    :TIPOCP,            ';
  Result := Result + '    :TIPOSP             ';
  Result := Result + '            );                                ';
end;

function TExportaTintometricosTerceirosStarmix.fValorQuantidade(fltValor,
  fltAcrMob: Double): Double;
begin
  If fltValor <= 0 Then
    Result := 0
  Else
    Result := fltValor + fltAcrMob;
end;

procedure TExportaTintometricosTerceirosStarmix.pAdicionaParamentros(
  var DataSet: TFDQuery; qryTinta: TUniQuery; fltPreVen: Double; intParam: Integer = 0);
Var
  intContador: Integer;
  intEmb: Integer;
begin
  DataSet.ParamByName('NOMCOR').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('STA_NOMCOR').AsString);
  DataSet.ParamByName('CODLIN').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('STA_CODLIN').AsString);
  DataSet.ParamByName('DESLIN').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('STA_DESLIN').AsString);
  DataSet.ParamByName('CODMON').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('STA_CODMON').AsString);
  DataSet.ParamByName('MONTAD').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('STA_MONTAD').AsString);
  DataSet.ParamByName('UNIVER').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('STA_UNIVER').AsString);
  DataSet.ParamByName('MD5KEY').AsStrings[intParam]  := qryTinta.FieldByName('STA_MD5KEY').AsString;
  DataSet.ParamByName('CODITE').AsStrings[intParam] := strProSta;

  DataSet.ParamByName('PCUCLT').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONLT'], 0.0);
  DataSet.ParamByName('PCUDLT').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILLT'], 0.0);
  DataSet.ParamByName('PCUCGL').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONGL'], 0.0);
  DataSet.ParamByName('PCUDGL').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILGL'], 0.0);
  DataSet.ParamByName('PCUCLA').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONLA'], 0.0);
  DataSet.ParamByName('PCUDLA').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILLA'], 0.0);
  DataSet.ParamByName('PCUCCP').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONCP'], 0.0);
  DataSet.ParamByName('PCUDCP').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILCP'], 0.0);
  DataSet.ParamByName('PCUCSP').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONSP'], 0.0);
  DataSet.ParamByName('PCUDSP').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILSP'], 0.0);

  For intEmb := 0 To Length(arrEmbalagens) - 1 Do
  Begin
    If strAcrMob = '1' Then
    Begin
      arrPrecosPorEmb[intEmb].fltValCon := arrPrecosPorEmb[intEmb].fltValCon * (1 + qryTinta.FieldByName('STA_ACRMOB').AsFloat / 100);
      arrPrecosPorEmb[intEmb].fltValDil := arrPrecosPorEmb[intEmb].fltValDil * (1 + qryTinta.FieldByName('STA_ACRMOB').AsFloat / 100);
    End
    Else
    Begin
      arrPrecosPorEmb[intEmb].fltValCon := fValorQuantidade(arrPrecosPorEmb[intEmb].fltValCon, qryTinta.FieldByName('STA_ACRMOB').AsFloat);
      arrPrecosPorEmb[intEmb].fltValDil := fValorQuantidade(arrPrecosPorEmb[intEmb].fltValDil, qryTinta.FieldByName('STA_ACRMOB').AsFloat);
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
      DataSet.ParamByName('PRCCP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONCP'], 0.0);
      DataSet.ParamByName('PRDCP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCP'], 0.0);
      DataSet.ParamByName('PRCSP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONSP'], 0.0);
      DataSet.ParamByName('PRDSP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILSP'], 0.0);
    End
    Else
    Begin
      If strAcrMob = '1' Then
      Begin
        DataSet.ParamByName('PRCLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLT'], 0.0) * (1 + qryTinta.FieldByName('STA_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLT'], 0.0) * (1 + qryTinta.FieldByName('STA_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONGL'], 0.0) * (1 + qryTinta.FieldByName('STA_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILGL'], 0.0) * (1 + qryTinta.FieldByName('STA_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCLA' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLA'], 0.0) * (1 + qryTinta.FieldByName('STA_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDLA' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLA'], 0.0) * (1 + qryTinta.FieldByName('STA_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCCP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONCP'], 0.0) * (1 + qryTinta.FieldByName('STA_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDCP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCP'], 0.0) * (1 + qryTinta.FieldByName('STA_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCSP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONSP'], 0.0) * (1 + qryTinta.FieldByName('STA_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDSP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILSP'], 0.0) * (1 + qryTinta.FieldByName('STA_ACRMOB').AsFloat / 100);
      End
      Else
      Begin
        DataSet.ParamByName('PRCLT' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLT'], 0.0), qryTinta.FieldByName('STA_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDLT' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLT'], 0.0), qryTinta.FieldByName('STA_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCGL' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONGL'], 0.0), qryTinta.FieldByName('STA_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDGL' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILGL'], 0.0), qryTinta.FieldByName('STA_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCLA' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLA'], 0.0), qryTinta.FieldByName('STA_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDLA' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLA'], 0.0), qryTinta.FieldByName('STA_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCCP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONCP'], 0.0), qryTinta.FieldByName('STA_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDCP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCP'], 0.0), qryTinta.FieldByName('STA_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCSP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONSP'], 0.0), qryTinta.FieldByName('STA_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDSP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILSP'], 0.0), qryTinta.FieldByName('STA_ACRMOB').AsFloat);
      End;
    End;
  End;
end;

procedure TExportaTintometricosTerceirosStarmix.pCriaClientEmbalagem(
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
    strSQL := strSQL + '    CFG_IDEPRO = "STA" AND                  ';
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

procedure TExportaTintometricosTerceirosStarmix.pGravaTintometricoPorTintaTerceiros(
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

procedure TExportaTintometricosTerceirosStarmix.pIncluirLogTinSite(
  Conexao: TUniConnection; strStatus: String);
Var
  qryGen: TUniQuery;
  strSQL: String;
begin
   Try
    strSQL := '';
    strSQL := strSQL + '  DELETE FROM LOGTIN_SIT WHERE LOG_IDEPRO = "STA"       ';

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
    strSQL := strSQL + '    "STA",              ';
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

procedure TExportaTintometricosTerceirosStarmix.pPreencheArrayEmbalagem;
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

  //Copo
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Copo';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'CP';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 0.500;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  //Spray
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Spray';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'SP';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 0.400;
end;

procedure TExportaTintometricosTerceirosStarmix.pPreencheEmbalagens;
begin
  pPreencheArrayEmbalagem;
end;

procedure TExportaTintometricosTerceirosStarmix.pProcessaTabelaCores(
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
      pRetornaQuantidadeFormulacao(dicRetorno, qryGen, qryBases);
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

procedure TExportaTintometricosTerceirosStarmix.pRecalculaFormula(
  dicRetorno: TDicionario; qryGen, qryBases: TUniQuery);
begin
  //Nao possui quantidade diluida
  fltPesCor := qryGen.FieldByName('STA_PESCOR').AsFloat * 1000;
  fltPesFor := qryGen.FieldByName('STA_PESFOR').AsFloat;
end;

procedure TExportaTintometricosTerceirosStarmix.pRetPrecosAdicionais(
  dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery;
  fltPerAcr: Double);
Var
  intContador: Integer;
  intVenda: Integer;
  fltQuantCon,
  fltQuantDil,
  fltPrecoVendaCon,
  fltPrecoVendaDil,
  fltPrecoVendaTotalCon,
  fltPrecoVendaTotalDil,
  fltPrecoCustoCon,
  fltPrecoCustoDil,
  fltPrecoCustoTotalCon,
  fltPrecoCustoTotalDil,
  fltPesoEspecifico,
  fltEmbalagem,
  fltPrecoEmbalagem,
  fltPrecoVenda,
  fltPrecoCusto: Double;
  strTabelaUnica: String;
  ArrComponentes: Array of TComp; //TArrComponentes;
  fltPreCusPro,
  fltPreVenPro: Double;
  strCodCli, strCodCnd: String;
  intPrzMed: Integer;
  intEmb: Integer;
  strCamEmb: String;
  strEmb: String;
begin
  fltPrecoVenda       := 0;
  fltPrecoCusto       := 0;
  fltPrecoEmbalagem   := 0;
  fltPreCusPro        := 0;
  fltPreVenPro        := 0;
  strCodCli           := '';
  strCodCnd           := '';
  intPrzMed           := 0;

  strTabelaUnica := dicRetorno['tabelaunica'];

  SetLength(arrPrecosPorEmb, Length(arrEmbalagens));

  dicPrecoAdicional.Limpar;

  For intEmb := 0 To Length(arrEmbalagens) - 1 Do
  Begin
    strCamEmb := fRetornaCampoEmbalagem(arrEmbalagens[intEmb].strSigEmb, dicRetorno);
    strEmb := arrEmbalagens[intEmb].strSigEmb;

    //Verificar se existe a embalagem
    If (Not cdsEmbalagens.Locate('CFG_CODCFG', strCamEmb, [])) Then
      Continue;

    //Verificar se existe produto vinculado
    If fEmptyStr(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString) Then
      Continue;

    Try
      SetLength(ArrComponentes, fQuantidadeFormulacao());

      //Adiciona a formulacao no array
      For intContador := 1 To fQuantidadeFormulacao Do
      Begin
        If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intContador, 2)], ''))) Then
          Break;

        If (Not qryBases.Locate('BAS_CODBAS', dicRetorno['base' + fStrZero(intContador, 2)], [])) Then
          Break;

        ArrComponentes[intContador].Componente := dicRetorno['base' + fStrZero(intContador, 2)];
        ArrComponentes[intContador].Quantidade := fFormataFloat(arrEmbalagens[intEmb].fltVolume * ((fltPesCor / fltPesFor) *
          (dicRetorno['qtdb' + fStrZero(intContador, 2)])), 1);
        ArrComponentes[intContador].Quantiddil := 0.0;
      End;

      //Calculando Preços de vendas (Tabelas dos Clientes) Diluidos e Concentrados
      For intVenda := 1 To 7 Do
      Begin
        fltPrecoVendaTotalCon := 0;
        fltPrecoVendaTotalDil := 0;

        If stlTabPre[intVenda] <> 'S' Then
          Continue;

        For intContador := 1 To fQuantidadeFormulacao() Do
        Begin

          If fEmptyStr(ArrComponentes[intContador].Componente) Then
            Break;

          If qryBases.Locate('BAS_CODBAS', ArrComponentes[intContador].Componente,[]) Then
          Begin
            If fCarregaPromocao(qryBases.FieldByName('BAS_CODITE').AsString,
              IntToStr(intVenda), strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
              fltPrecoVenda := fltPreVenPro
            Else
              fltPrecoVenda := qryBases.FieldByName('PREVE' + IntToStr(intVenda)).AsFloat;
          End;

          fltEmbalagem := fRetEmbalagem(qryBases);

          fltPesoEspecifico := qryBases.FieldByName('BAS_PESESP').AsFloat;

          //Preco de venda concentrado
           fltQuantCon := ArrComponentes[intContador].Quantidade;
           fltPrecoVendaCon := (fltPrecoVenda / fltEmbalagem) * (fltQuantCon / fltPesoEspecifico);
           fltPrecoVendaTotalCon := fltPrecoVendaTotalCon + fltPrecoVendaCon;


          //Preco de venda diluido
          fltQuantDil := ArrComponentes[intContador].Quantiddil;
          fltPrecoVendaDil := (fltPrecoVenda / fltEmbalagem) * (fltQuantDil / fltPesoEspecifico);
          fltPrecoVendaTotalDil := fltPrecoVendaTotalDil + fltPrecoVendaDil;
        End;

        //Retorna preco da embalagem
        If cdsEmbalagens.Locate('CFG_CODCFG', strCamEmb, []) Then
        Begin
          If fCarregaPromocao(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString,
            IntToStr(intVenda), strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
            fltPrecoEmbalagem := fltPreVenPro + (fltPerAcr * fltPreVenPro)
          Else
            fltPrecoEmbalagem := fSelecionaPrecoVendaEmbalagemTabClientes(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString, fltPerAcr, intVenda);
        End;

        //Preco de venda concentrado
        If fltPrecoVendaTotalCon > 0 Then
          dicPrecoAdicional['PREVE' + IntToStr(intVenda) + '_CON' + strEmb] := fltPrecoVendaTotalCon +
            (fltPerAcr * fltPrecoVendaTotalCon) + fltPrecoEmbalagem;

        //Preco de venda diluido
        If fltPrecoVendaTotalDil > 0 Then
          dicPrecoAdicional['PREVE' + IntToStr(intVenda) + '_DIL' + strEmb] := fltPrecoVendaTotalDil +
            (fltPerAcr * fltPrecoVendaTotalDil) + fltPrecoEmbalagem;
      End;

      fltPrecoCustoTotalCon := 0.0;
      fltPrecoCustoTotalDil := 0.0;

      //Preço de Custo Concentrado e Diluido(Por Embalagem);
      For intContador := 1 To fQuantidadeFormulacao() Do
      Begin

        If fEmptyStr(ArrComponentes[intContador].Componente) Then
          Break;

        If qryBases.Locate('BAS_CODBAS', ArrComponentes[intContador].Componente,[]) Then
        Begin
          If fCarregaPromocao(qryBases.FieldByName('BAS_CODITE').AsString,
            strTabelaUnica , strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
            fltPrecoCusto := fltPreCusPro
          Else
            fltPrecoCusto := qryBases.FieldByName('PRECUS').AsFloat;
        End;


        fltEmbalagem := fRetEmbalagem(qryBases);

        fltPesoEspecifico := qryBases.FieldByName('BAS_PESESP').AsFloat;

        //Preço de Custo Concentrado
        fltQuantCon := ArrComponentes[intContador].Quantidade;
        fltPrecoCustoCon := (fltPrecoCusto / fltEmbalagem) * (fltQuantCon / fltPesoEspecifico);
        fltPrecoCustoTotalCon := fltPrecoCustoTotalCon + fltPrecoCustoCon;

        //Preço de Custo Diluido
        fltQuantDil := ArrComponentes[intContador].Quantiddil;
        fltPrecoCustoDil := (fltPrecoCusto / fltEmbalagem) * (fltQuantDil / fltPesoEspecifico);
        fltPrecoCustoTotalDil := fltPrecoCustoTotalDil + fltPrecoCustoDil;
      End;

      //Retorna preço de custo da embalagem
      If cdsEmbalagens.Locate('CFG_CODCFG', strCamEmb, []) Then
      Begin
        If fCarregaPromocao(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString,
            strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
          fltPrecoEmbalagem := fltPreCusPro + (fltPerAcr * fltPreCusPro)
        Else
          fltPrecoEmbalagem := fSelecionaPrecoCustoEmbalagem(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString, fltPerAcr);
      End;

      If fltPrecoCustoTotalCon > 0 Then
        dicPrecoAdicional['PRECUS_CON' + strEmb] := IfNull((fltPrecoCustoTotalCon + fltPrecoEmbalagem), 0);

      If fltPrecoCustoTotalDil > 0 Then
        dicPrecoAdicional['PRECUS_DIL' + strEmb] := IfNull((fltPrecoCustoTotalDil + fltPrecoEmbalagem), 0);
    Finally
      SetLength(ArrComponentes, 0);
    End;

  End;
end;

procedure TExportaTintometricosTerceirosStarmix.pRetPrecoTintas(
  dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery;
  fltPerAcr: Double);
Var
  intContador: Integer;
  fltQuantCon,
  fltPrecoVendaCon,
  fltPrecoVendaTotalCon,
  fltQuantDil,
  fltPrecoVendaDil,
  fltPrecoVendaTotalDil,
  fltPrecoBase,
  fltPesoEspecifico,
  fltPrecoEmbalagem: Double;
  strTabelaUnica: String;
  ArrComponentes: Array of TComp; //TArrComponentes;
  fltPreCusPro,
  fltPreVenPro: Double;
  strCodCli, strCodCnd: String;
  intPrzMed: Integer;
  fltEmbala: Double;
  intEmb: Integer;
  strCamEmb: String;
begin
  fltPrecoBase       := 0;
  fltPrecoEmbalagem  := 0;
  fltPreCusPro       := 0;
  fltPreVenPro       := 0;
  strCodCli          := '';
  strCodCnd          := '';
  intPrzMed          := 0;

  strTabelaUnica := dicRetorno['tabelaunica'];

  SetLength(arrPrecosPorEmb, Length(arrEmbalagens));

  //fazer o for das embalagens aqui
  For intEmb := 0 To Length(arrEmbalagens) - 1 Do
  Begin
    fltPrecoVendaTotalCon := 0;
    fltPrecoVendaTotalDil := 0;

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
        ArrComponentes[intContador].Quantidade := fFormataFloat(arrEmbalagens[intEmb].fltVolume * ((fltPesCor / fltPesFor) *
          (dicRetorno['qtdb' + fStrZero(intContador, 2)])), 1);
        ArrComponentes[intContador].Quantiddil := 0.0;
      End;

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

        fltPesoEspecifico := qryBases.FieldByName('BAS_PESESP').AsFloat;


        //Preco de venda concentrado
        fltQuantCon := ArrComponentes[intContador].Quantidade;
        fltPrecoVendaCon := (fltPrecoBase / fltEmbala) * (fltQuantCon / fltPesoEspecifico);
        fltPrecoVendaTotalCon := fltPrecoVendaTotalCon + fltPrecoVendaCon;

        //Preco de venda diluido
        fltQuantDil := ArrComponentes[intContador].Quantiddil;
        fltPrecoVendaDil := (fltPrecoBase / fltEmbala) * (fltQuantDil / fltPesoEspecifico);
        fltPrecoVendaTotalDil := fltPrecoVendaTotalDil + fltPrecoVendaDil;
      End;

      //Retorna preco da embalagem
      If cdsEmbalagens.Locate('CFG_CODCFG', strCamEmb, []) Then
      Begin
        If fCarregaPromocao(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString,
          strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
          fltPrecoEmbalagem := fltPreVenPro + (fltPerAcr * fltPreVenPro)
        Else
          fltPrecoEmbalagem := fRetornaPrecoVendaEmbalagem(
            cdsEmbalagens.FieldByName('CFG_VALCFG').AsString, fltPerAcr);
      End;

      //Preco de venda concentrado
      If fltPrecoVendaTotalCon > 0 Then
        fltPrecoVendaTotalCon := fltPrecoVendaTotalCon +
          (fltPerAcr * fltPrecoVendaTotalCon) + fltPrecoEmbalagem;

      //Preco de venda diluido
      If fltPrecoVendaTotalDil > 0 Then
        fltPrecoVendaTotalDil := fltPrecoVendaTotalDil +
          (fltPerAcr * fltPrecoVendaTotalDil) + fltPrecoEmbalagem;

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

procedure TExportaTintometricosTerceirosStarmix.pSetaParametrosEspecificos(
  Conexao: TUniConnection);
Var
  qryGen: TUniQuery;
  strSQL: String;
  intContador: Integer;
begin
  pCriaClientEmbalagem(Conexao);
  strProSta := fRetItemVenda(Conexao);

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

end.
