unit untExportaTintometricosTerceirosPpgNexa;

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
  TPpxArray = Record
    Tipo: String;
  End;

THackPpx = Array Of TPpxArray;

Type
  TExportaTintometricosTerceirosPpgNexa = Class(TExportaTintometricosTerceirosAutomotiva)
  Private
    strProPpx: String; //Produto de venda PPG/Nexa;
    stlDiluentes: TStringList;
    qryDiluentes: TUniQuery;
    qryBasEmp: TUniQuery; //Base por Empresa
    strAcrMob: String;
    blnDiluido: Boolean;
    arrTipoPpx: THackPpx;
    function fRetValorAcrMobCfgTin(): String;
    function fArredondaPPX(fltValor: Double): Double;
    function fValorQuantidade(fltValor: Double; fltAcrMob: Double): Double;
  {$IFDEF LINUX}
    function fGetCountRegister(qryGen: TUniQuery): Boolean;
  {$ENDIF}
  Protected
    procedure pProcessaTabelaCores(qryInsert: TFDQuery; qryGen, qryBases, qryColorantes: TUniQuery;
       strTabUni, strTabPre: String; fltPerAcr: Double; dicRetorno: TDicionario); Override;
  Public
    function fNomeTabela(): String; override;
    function fCamposTabela(): String; override;
    function fCamposSelect(): String; override;
    function fQuantidadeFormulacao(): Integer; override;
    function fFatorTinta(): Double; override;
    function fRetDescricao(): String; override;
    function fRetItemBase(): String; override;
    function fRetMD5KEY(): String; override;
    function fRetFormula(intCont: Integer): String; override;
    function fRetQuantidade(intCont: Integer): String; override;
    function fSQLInsert(): String; override;
    function fRetornaColorantes(): String; override;
    function fRetornaBases(): String; override;
    function fRetornaPercentualAcrescimo(Conexao: TUniConnection): Double; override;
    function fRetEmbalagem(qryColorantes: TUniQuery): Double; override;
    function fRetornaCampoEmbalagem(strSigEmb: String; dicRetorno: TDicionario): String; override;
    function fRetTipoCor(): String; override;
    function fRetornaCodigoDiluente(dicRetorno: TDicionario): String; override;
    function fRetornaPorcentagemDiluente(dicRetorno: TDicionario): Double; override;
    function fCarregarBasesEmpresa(): String;
    function fRetItemVenda(strTipCor: String): String;
    function fRetEmbalagemLT(strTipCor: String): String;
    function fRetEmbalagemGL(strTipCor: String): String;
    function fRetEmbalagemBD(strTipCor: String): String;
    function fRetEmbalagemTB(strTipCor: String): String;
    function fRetEmbalagemCP(): String;
	function fRetEmbalagemSP(): String;
    function fGetTipoFormula(qryGen: TUniQuery; qryBases: TUniQuery): Integer; Override;
    function fGetPorLinha(): Integer; Override;

    procedure pRecalculaFormula(dicRetorno: TDicionario; qryGen: TUniQuery; qryBases: TUniQuery); override;
    procedure pSetaParametrosEspecificos(Conexao: TUniConnection); override;
    procedure pAdicionaParamentros(Var DataSet: TFDQuery; qryTinta: TUniQuery; fltPreVen: Double; intParam: Integer = 0); override;
    procedure pIncluirLogTinSite(Conexao: TUniConnection; strStatus: String); Override;
    procedure pRetPrecoTintas(dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery; fltPerAcr: Double); override;
    procedure pRetPrecosAdicionais(dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery; fltPerAcr: Double); Override;
    procedure pGravaTintometricoPorTintaTerceiros(qryInsert: TFDQuery; fltPreVen: Double; qryTinta: TUniQuery; intParam: Integer = 0); override;
    procedure Execute; override;
    procedure CarregarDados;
    procedure pPreencheEmbalagens;
    procedure pPreencheArrayEmbalagem;
    procedure pCriaClientEmbalagem(Conexao: TUniConnection);
    procedure pRetTabelasVenda(Conexao: TUniConnection);
    procedure GetDiluentes(qryTinta: TUniQuery);

    constructor Create(pgbProgresso: TcxProgressBar; strIdePro: String;
      blnAuto: Boolean = False); Override;
    destructor Destroy; Override;

  End;

implementation

{ TExportaTintometricosTerceirosPpgNexa }

procedure TExportaTintometricosTerceirosPpgNexa.CarregarDados;
begin
  stlDiluentes := TStringList.Create;
  qryDiluentes := fCriaQuery();
  qryBasEmp := fCriaQuery();
  qryBasEmp.Close;
  qryBasEmp.SQL.Clear;
  qryBasEmp.SQL.Add(fCarregarBasesEmpresa);
  qryBasEmp.Open;
end;

constructor TExportaTintometricosTerceirosPpgNexa.Create(
  pgbProgresso: TcxProgressBar; strIdePro: String; blnAuto: Boolean);
begin
  inherited;
  strProPpx := '';
  pPreencheEmbalagens;
  CarregarDados;
  dicPrecoAdicional := TDicionario.Create();
  stlTabPre := TStringList.Create();
  strAcrMob := fRetValorAcrMobCfgTin();
end;

destructor TExportaTintometricosTerceirosPpgNexa.Destroy;
begin
  inherited;
  FreeAndNil(stlDiluentes);
  FreeAndNil(qryDiluentes);
  FreeAndNil(qryBasEmp);

  If Assigned(dicPrecoAdicional) Then
    FreeAndNil(dicPrecoAdicional);

  If Assigned(stlTabPre) Then
    FreeAndNil(stlTabPre);
end;

procedure TExportaTintometricosTerceirosPpgNexa.Execute;
begin
  inherited;
end;

function TExportaTintometricosTerceirosPpgNexa.fArredondaPPX(
  fltValor: Double): Double;
Var
  strAux: String;
begin
  strAux := Format('%.2f', [fltValor]);
  strAux := Copy(strAux, 1, Length(strAux) - 1);

  If (fStrToFloat(strAux) = 0) Then
    strAux := Format('%.2f', [fltValor]);

  Result := fStrToFloat(strAux);
end;

function TExportaTintometricosTerceirosPpgNexa.fCamposSelect: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result +  '  SELECT                 ';
  Result := Result +  '    PPX_DESCOR,          ';
  Result := Result +  '    PPX_TIPO__,          ';
  Result := Result +  '    PPX_MARCA_,          ';
  Result := Result +  '    BAS_TIPO__,          ';
  Result := Result +  '    MON_DESCRI,          ';
  Result := Result +  '    PPX_VEICUL,          ';
  Result := Result +  '    SUBSTR(PPX_A_N_O_, 1, 4),          ';
  Result := Result +  '    SUBSTR(PPX_A_N_O_, 6, 4),          ';
  Result := Result +  '    PPX_CODCOR,          ';
  Result := Result +  '    PPX_CODATC,          ';
  Result := Result +  '    PPX_MONTAD,          ';
  Result := Result +  '    PPX_A_N_O_,          ';
  Result := Result +  '    PPX_VARIAN,          ';
  Result := Result +  '    PPX_REFERE,          ';
  Result := Result +  '    PPX_SISTEM,          ';
  Result := Result +  '    PPX_PAISES,          ';
  Result := Result +  '    PPX_ORIGEM,          ';
  Result := Result +  '    PPX_UTILIZ,          ';
  Result := Result +  '    PPX_EFEFIN,          ';
  Result := Result +  '    PPX_ACRMOB,          ';

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    Result := Result +  '    PPX_CODB' + fStrZero(intContador, 2) + ',     ';
    Result := Result +  '    PPX_QTDB' + fStrZero(intContador, 2) + ',     ';
  End;

  Result := Result +  '    PPX_MD5KEY           ';
  Result := Result +  '  FROM                   ';
  Result := Result +  '    PPX_CADPPX           ';
  Result := Result +  '  LEFT JOIN PPX_CADMON ON          ';
  Result := Result +  '    PPX_MONTAD = MON_CODMON              ';
  Result := Result +  '  INNER JOIN PPX_CADBAS ON         ';
  Result := Result +  '    PPX_CODB01 = BAS_CODBAS  AND         ';
  Result := Result +  '    IFNULL(PPX_ATIVO_, "S") = "S"        ';
  Result := Result +  '  WHERE                  ';
  Result := Result +  '    TRUE                 ';
  Result := Result +  '  AND PPX_SISTEM = "' + arrTipoPpx[intLinha].Tipo + '"   ';
end;

function TExportaTintometricosTerceirosPpgNexa.fCamposTabela: String;
begin
  Result := '';
  Result := Result +  '  CREATE TABLE   ' + fNomeTabela() +  '    (     ';
  Result := Result +  '    PPX_DESCOR VARCHAR(60),        ';
  Result := Result +  '    PPX_CODCOR VARCHAR(100),       ';
  Result := Result +  '    PPX_CODATC VARCHAR(25),        ';
  Result := Result +  '    PPX_MARCA_ VARCHAR(20),        ';
  Result := Result +  '    PPX_UTILIZ VARCHAR(25),        ';
  Result := Result +  '    PPX_SISTEM VARCHAR(50),        ';
  Result := Result +  '    PPX_EFEFIN VARCHAR(50),        ';
  Result := Result +  '    PPX_ORIGEM VARCHAR(50),        ';
  Result := Result +  '    PPX_PAISES VARCHAR(50),        ';
  Result := Result +  '    PPX_VEICUL VARCHAR(35),        ';
  Result := Result +  '    PPX_MONTAD VARCHAR(16),        ';
  Result := Result +  '    PPX_A_N_O_ VARCHAR(9),         ';
  Result := Result +  '    PPX_TIPO__ VARCHAR(20),        ';
  Result := Result +  '    PPX_MD5KEY VARCHAR(32),        ';
  Result := Result +  '    PPX_CODITE VARCHAR(' + fTamCodIte.ToString() + '),         ';
  Result := Result +  '    PPX_CODDIL VARCHAR(20),        ';
  Result := Result +  '    PPX_PORDIL DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRECLT DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRECGL DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRECBD DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRECTB DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRECCP DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRECSP DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PREDLT DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PREDGL DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PREDBD DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PREDTB DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PREDCP DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PREDSP DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PCUSCL DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PCUSCG DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PCUSCB DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PCUSCT DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PCUSCC DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PCUSCS DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PCUSDL DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PCUSDG DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PCUSDB DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PCUSDT DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PCUSDC DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PCUSDS DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRCLT1 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRCLT2 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRCLT3 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRCLT4 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRCLT5 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRCLT6 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRCLT7 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRDLT1 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRDLT2 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRDLT3 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRDLT4 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRDLT5 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRDLT6 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRDLT7 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRCGL1 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRCGL2 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRCGL3 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRCGL4 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRCGL5 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRCGL6 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRCGL7 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRDGL1 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRDGL2 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRDGL3 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRDGL4 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRDGL5 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRDGL6 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRDGL7 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRCBD1 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRCBD2 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRCBD3 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRCBD4 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRCBD5 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRCBD6 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRCBD7 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRDBD1 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRDBD2 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRDBD3 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRDBD4 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRDBD5 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRDBD6 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRDBD7 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRCTB1 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRCTB2 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRCTB3 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRCTB4 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRCTB5 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRCTB6 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRCTB7 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRDTB1 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRDTB2 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRDTB3 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRDTB4 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRDTB5 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRDTB6 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRDTB7 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRCCP1 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRCCP2 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRCCP3 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRCCP4 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRCCP5 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRCCP6 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRCCP7 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRDCP1 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRDCP2 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRDCP3 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRDCP4 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRDCP5 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRDCP6 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRDCP7 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRCSP1 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRCSP2 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRCSP3 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRCSP4 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRCSP5 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRCSP6 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRCSP7 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRDSP1 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRDSP2 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRDSP3 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRDSP4 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRDSP5 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRDSP6 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PRDSP7 DECIMAL(12,4),      ';
  Result := Result +  '    PPX_EMBALT VARCHAR(' + fTamCodIte.ToString() + '),         ';
  Result := Result +  '    PPX_EMBAGL VARCHAR(' + fTamCodIte.ToString() + '),         ';
  Result := Result +  '    PPX_EMBABD VARCHAR(' + fTamCodIte.ToString() + '),         ';
  Result := Result +  '    PPX_EMBATB VARCHAR(' + fTamCodIte.ToString() + '),         ';
  Result := Result +  '    PPX_EMBACP VARCHAR(' + fTamCodIte.ToString() + '),         ';
  Result := Result +  '    PPX_EMBASP VARCHAR(' + fTamCodIte.ToString() + '),         ';
  Result := Result +  '    PPX_VOLULT DECIMAL(12,4),      ';
  Result := Result +  '    PPX_VOLUGL DECIMAL(12,4),      ';
  Result := Result +  '    PPX_VOLUBD DECIMAL(12,4),      ';
  Result := Result +  '    PPX_VOLUTB DECIMAL(12,4),      ';
  Result := Result +  '    PPX_VOLUCP DECIMAL(12,4),      ';
  Result := Result +  '    PPX_VOLUSP DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PREELT DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PREEGL DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PREEBD DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PREETB DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PREECP DECIMAL(12,4),      ';
  Result := Result +  '    PPX_PREESP DECIMAL(12,4),      ';
  Result := Result +  '    PPX_TIPOLT CHAR(2),            ';
  Result := Result +  '    PPX_TIPOGL CHAR(2),            ';
  Result := Result +  '    PPX_TIPOBD CHAR(2),            ';
  Result := Result +  '    PPX_TIPOTB CHAR(2),            ';
  Result := Result +  '    PPX_TIPOCP CHAR(2),            ';
  Result := Result +  '    PPX_TIPOSP CHAR(2)             ';
  Result := Result +  '       );                                        ';
end;

function TExportaTintometricosTerceirosPpgNexa.fCarregarBasesEmpresa: String;
begin
  Result := '';
  Result := Result +  '  SELECT               ';
  Result := Result +  '    BAS_CODBAS,        ';
  Result := Result +  '    BAS_CODITE,        ';
  Result := Result +  '    BAS_PESESP,        ';
  Result := Result +  '    BAS_EMBALA,        ';
  Result := Result +  '    BAS_CODEMP,        ';
  Result := Result +  '    ITE_PREVE' + fRetornaTabelaPreco + ' AS ITE_PREVEN,     ';
  Result := Result +  '    G.ITE_PRECUS AS PRECUS,      ';
  Result := Result +  '    G.ITE_PREVE1 AS PREVE1,      ';
  Result := Result +  '    G.ITE_PREVE2 AS PREVE2,      ';
  Result := Result +  '    G.ITE_PREVE3 AS PREVE3,      ';
  Result := Result +  '    G.ITE_PREVE4 AS PREVE4,      ';
  Result := Result +  '    G.ITE_PREVE5 AS PREVE5,      ';
  Result := Result +  '    G.ITE_PREVE6 AS PREVE6,      ';
  Result := Result +  '    G.ITE_PREVE7 AS PREVE7       ';
  Result := Result +  '  FROM                 ';
  Result := Result +  '    PPX_BASEMP B       ';
  Result := Result +  '  INNER JOIN ITEGER G ON       ';
  Result := Result +  '    B.BAS_CODITE = G.ITE_CODITE            ';
  Result := Result +  '  INNER JOIN CADITE I ON       ';
  Result := Result +  '    I.ITE_CODITE = G.ITE_CODITE            ';
  Result := Result +  '  WHERE                ';
  Result := Result +  '    G.ITE_CODEMP = "' + VS_strCodEmp + '"  ';
end;

function TExportaTintometricosTerceirosPpgNexa.fFatorTinta: Double;
begin
  Result := 0;
end;

{$IFDEF LINUX}
function TExportaTintometricosTerceirosPpgNexa.fGetCountRegister(
  qryGen: TUniQuery): Boolean;
Var
  intRecordCount: Integer;
begin
  Result := True;
  intRecordCount := Trunc(qryGen.RecordCount / 2);

  If qryGen.RecNo > intRecordCount Then
    Result := False; 
end;
{$ENDIF}

function TExportaTintometricosTerceirosPpgNexa.fGetPorLinha: Integer;
Var
  qryGen: TUniQuery;
begin
  Try  
    SetLength(arrTipoPpx, 0);

    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('SELECT DISTINCT PPX_SISTEM FROM PPX_CADPPX  ');
    qryGen.Open;

    If qryGen.IsEmpty Then
      Exit(1);

    qryGen.First;

    While Not qryGen.Eof Do
    Begin
      SetLength(arrTipoPpx, Length(arrTipoPpx) + 1);
      arrTipoPpx[Length(arrTipoPpx) - 1].Tipo := qryGen.FieldByName('PPX_SISTEM').AsString;
      qryGen.Next;
    End;

    Result := Length(arrTipoPpx);    
  Finally
    If Assigned(qryGen) Then
      FreeAndNil(qryGen);
  End;  
end;

function TExportaTintometricosTerceirosPpgNexa.fGetTipoFormula(qryGen,
  qryBases: TUniQuery): Integer;
Var
  intContador: Integer;
begin
  Result := 0;

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    If fEmptyStr(qryGen.FieldByName('PPX_CODB' + fStrZero(intContador, 2)).AsString) Then
      Break;

    If Not qryBases.Locate('BAS_CODBAS', qryGen.FieldByName('PPX_CODB' + fStrZero(intContador, 2)).AsString, []) Then
    Begin
      Result := 3;
      Break;
    End;
  End;
end;

function TExportaTintometricosTerceirosPpgNexa.fNomeTabela: String;
begin
  Result := 'PPX_CADPPX_SIT';
end;

function TExportaTintometricosTerceirosPpgNexa.fQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TExportaTintometricosTerceirosPpgNexa.fRetDescricao: String;
begin
  Result := 'PPX_DESCOR';
end;

function TExportaTintometricosTerceirosPpgNexa.fRetEmbalagem(
  qryColorantes: TUniQuery): Double;
begin
  Result := (qryColorantes.FieldByName('BAS_EMBALA').AsFloat *
    qryColorantes.FieldByName('BAS_PESESP').AsFloat);
end;

function TExportaTintometricosTerceirosPpgNexa.fRetEmbalagemBD(
  strTipCor: String): String;
begin
  Result := '';

  If Pos('ACS EVOLUTION (LA)', strTipCor) > 0 Then
    Result := 'PXBDAC'
  Else If Pos('DELFLEET', strTipCor) > 0 Then
    Result := 'PXBDDF'
  Else If Pos('DELTRON', strTipCor) > 0 Then
    Result := 'PXBDDT'
  Else If Pos('INDUSTRAN', strTipCor) > 0 Then
    Result := 'PXBDIN';
end;

function TExportaTintometricosTerceirosPpgNexa.fRetEmbalagemCP: String;
begin
  Result := 'PXCOPO';
end;

function TExportaTintometricosTerceirosPpgNexa.fRetEmbalagemSP: String;
begin
  Result := 'PSPRAY';
end;

function TExportaTintometricosTerceirosPpgNexa.fRetEmbalagemGL(
  strTipCor: String): String;
begin
  Result := '';

  If Pos('ACS EVOLUTION (LA)', strTipCor) > 0 Then
    Result := 'PXGLAC'
  Else If Pos('DELFLEET', strTipCor) > 0 Then
    Result := 'PXGLDF'
  Else If Pos('DELTRON', strTipCor) > 0 Then
    Result := 'PXGLDT'
  Else If Pos('INDUSTRAN', strTipCor) > 0 Then
    Result := 'PXGLIN';
end;

function TExportaTintometricosTerceirosPpgNexa.fRetEmbalagemLT(
  strTipCor: String): String;
begin
  Result := '';

  If Pos('ACS EVOLUTION (LA)', strTipCor) > 0 Then
    Result := 'PXLTAC'
  Else If Pos('DELFLEET', strTipCor) > 0 Then
    Result := 'PXLTDF'
  Else If Pos('DELTRON', strTipCor) > 0 Then
    Result := 'PXLTDT'
  Else If Pos('INDUSTRAN', strTipCor) > 0 Then
    Result := 'PXLTIN';
end;

function TExportaTintometricosTerceirosPpgNexa.fRetEmbalagemTB(
  strTipCor: String): String;
begin
  Result := '';

  If Pos('ACS EVOLUTION (LA)', strTipCor) > 0 Then
    Result := 'PXTBAC'
  Else If Pos('DELFLEET', strTipCor) > 0 Then
    Result := 'PXTBDF'
  Else If Pos('DELTRON', strTipCor) > 0 Then
    Result := 'PXTBDT'
  Else If Pos('INDUSTRAN', strTipCor) > 0 Then
    Result := 'PXTBIN';
end;

function TExportaTintometricosTerceirosPpgNexa.fRetFormula(
  intCont: Integer): String;
begin
  Result := 'PPX_CODB' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosPpgNexa.fRetItemBase: String;
begin
  Result := '';
end;

function TExportaTintometricosTerceirosPpgNexa.fRetItemVenda(
  strTipCor: String): String;
Var
  qryGen: TUniQuery;
  strSQL: String;
begin
  Try
    qryGen := fCriaQuery();

    strSQL := '';
    strSQL := strSQL + '  SELECT              ';
    strSQL := strSQL + '    CFG_VALCFG        ';
    strSQL := strSQL + '  FROM                ';
    strSQL := strSQL + '    CFGTIN            ';
    strSQL := strSQL + '  WHERE               ';
    strSQL := strSQL + '    CFG_GRUCFG = "CONFIGURACOES" AND         ';
    strSQL := strSQL + '    CFG_CODEMP = "' + Vs_strCodEmp + '" AND  ';
    strSQL := strSQL + '    CFG_IDEPRO = "PPX"                       ';

    If Pos('ACS EVOLUTION (LA)', strTipCor) > 0 Then
      strSQL := strSQL + '  AND CFG_CODCFG = "PROACS"             '
    Else If Pos('DELFLEET', strTipCor) > 0 Then
      strSQL := strSQL + '  AND CFG_CODCFG = "PRODEF"             '
    Else If Pos('DELTRON', strTipCor) > 0 Then
      strSQL := strSQL + '  AND CFG_CODCFG = "PRODET"             '
    Else If Pos('INDUSTRAN', strTipCor) > 0 Then
      strSQL := strSQL + '  AND CFG_CODCFG = "PROIND"             ';

    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.Open;

    If qryGen.IsEmpty Then
    Begin
      Result := '';
      Exit;
    End;

    If qryGen.RecordCount > 1 Then
    Begin
      Result := '';
      Exit;
    End;

    Result := qryGen.FieldByName('CFG_VALCFG').AsString;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosPpgNexa.fRetMD5KEY: String;
begin
  Result := 'PPX_MD5KEY';
end;

function TExportaTintometricosTerceirosPpgNexa.fRetornaBases: String;
begin
  Result := '';
  Result := Result + '  SELECT              ';
  Result := Result + '    BAS_CODBAS,       ';
  Result := Result + '    BAS_CODITE,       ';
  Result := Result + '    BAS_EMBALA,       ';
  Result := Result + '    BAS_PESESP,       ';
  Result := Result + '    ITE_PREVE' + fRetornaTabelaPreco + ' AS ITE_PREVEN,        ';
  Result := Result +  '   G.ITE_PRECUS AS PRECUS,   ';
  Result := Result +  '   G.ITE_PREVE1 AS PREVE1,   ';
  Result := Result +  '   G.ITE_PREVE2 AS PREVE2,   ';
  Result := Result +  '   G.ITE_PREVE3 AS PREVE3,   ';
  Result := Result +  '   G.ITE_PREVE4 AS PREVE4,   ';
  Result := Result +  '   G.ITE_PREVE5 AS PREVE5,   ';
  Result := Result +  '   G.ITE_PREVE6 AS PREVE6,   ';
  Result := Result +  '   G.ITE_PREVE7 AS PREVE7    ';
  Result := Result + '  FROM                ';
  Result := Result + '    PPX_CADBAS B           ';
  Result := Result + '  INNER JOIN CADITE I ON            ';
  Result := Result + '    B.BAS_CODITE = I.ITE_CODITE             ';
  Result := Result + '  INNER JOIN ITEGER G ON            ';
  Result := Result + '    I.ITE_CODITE = G.ITE_CODITE             ';
  Result := Result + '  WHERE               ';
  Result := Result + '    G.ITE_CODEMP = "' + VS_strCodEmp + '"   ';
end;

function TExportaTintometricosTerceirosPpgNexa.fRetornaCampoEmbalagem(
  strSigEmb: String; dicRetorno: TDicionario): String;
begin
  Result := '';

  If strSigEmb = 'LT' Then
    Result := fRetEmbalagemLT(dicRetorno['tipcor'])
  Else If strSigEmb = 'GL' Then
    Result := fRetEmbalagemGL(dicRetorno['tipcor'])
  Else If strSigEmb = 'BD' Then
    Result := fRetEmbalagemBD(dicRetorno['tipcor'])
  Else If strSigEmb = 'TB' Then
    Result := fRetEmbalagemTB(dicRetorno['tipcor'])
  Else If strSigEmb = 'CP' Then
    Result := fRetEmbalagemCP
  Else If strSigEmb = 'SP' Then	
	Result := fRetEmbalagemSP;
end;

function TExportaTintometricosTerceirosPpgNexa.fRetornaCodigoDiluente(
  dicRetorno: TDicionario): String;
begin
  Result := IfNull(dicRetorno['coddil'], '');
end;

function TExportaTintometricosTerceirosPpgNexa.fRetornaColorantes: String;
begin
  Result := '';
end;

function TExportaTintometricosTerceirosPpgNexa.fRetornaPercentualAcrescimo(
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
    strSQL := strSQL + '    CFG_IDEPRO = "PPX"  AND               ';
    strSQL := strSQL + '    CFG_CODCFG = "APREVE" AND             ';
    strSQL := strSQL + '    CFG_CODEMP = "' + VS_strCodEmp + '"   ';

    qryGen := fCriaQuery(Nil, Conexao);
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.Open;

    If Not fEmptyStr(qryGen.FieldByName('CFG_VALCFG').AsString) Then
      Result := fStrToFloat(qryGen.FieldByName('CFG_VALCFG').AsString) / 100.0;

  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosPpgNexa.fRetornaPorcentagemDiluente(
  dicRetorno: TDicionario): Double;
begin
  Result := IfNull(dicRetorno['pordil'], 0);
end;

function TExportaTintometricosTerceirosPpgNexa.fRetQuantidade(
  intCont: Integer): String;
begin
  Result := 'PPX_QTDB' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosPpgNexa.fRetTipoCor: String;
begin
  Result := 'PPX_TIPO__';
end;

function TExportaTintometricosTerceirosPpgNexa.fRetValorAcrMobCfgTin: String;
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' SELECT CFG_VALCFG               ');
    qryGen.SQL.Add('    FROM CFGTIN                  ');
    qryGen.SQL.Add(' WHERE CFG_IDEPRO = "PPX" AND    ');
    qryGen.SQL.Add('       CFG_CODCFG = "ACRMOB" AND ');
    qryGen.SQL.Add('       CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
    qryGen.Open;

    Result := qryGen.FieldByName('CFG_VALCFG').AsString;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosPpgNexa.fSQLInsert: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '   INSERT INTO      ' + fNomeTabela() + '   (     ';
  Result := Result + '    PPX_DESCOR,           ';
  Result := Result + '    PPX_CODCOR,           ';
  Result := Result + '    PPX_CODATC,           ';
  Result := Result + '    PPX_MARCA_,           ';
  Result := Result + '    PPX_UTILIZ,           ';
  Result := Result + '    PPX_SISTEM,           ';
  Result := Result + '    PPX_EFEFIN,           ';
  Result := Result + '    PPX_ORIGEM,           ';
  Result := Result + '    PPX_PAISES,           ';
  Result := Result + '    PPX_VEICUL,           ';
  Result := Result + '    PPX_MONTAD,           ';
  Result := Result + '    PPX_A_N_O_,           ';
  Result := Result + '    PPX_TIPO__,           ';
  Result := Result + '    PPX_MD5KEY,           ';
  Result := Result + '    PPX_CODITE,           ';
  Result := Result + '    PPX_CODDIL,           ';
  Result := Result + '    PPX_PORDIL,           ';
  Result := Result + '    PPX_PRECLT,           ';
  Result := Result + '    PPX_PRECGL,           ';
  Result := Result + '    PPX_PRECBD,           ';
  Result := Result + '    PPX_PRECTB,           ';
  Result := Result + '    PPX_PRECCP,           ';
  Result := Result + '    PPX_PRECSP,           ';
  Result := Result + '    PPX_PREDLT,           ';
  Result := Result + '    PPX_PREDGL,           ';
  Result := Result + '    PPX_PREDBD,           ';
  Result := Result + '    PPX_PREDTB,           ';
  Result := Result + '    PPX_PREDCP,           ';
  Result := Result + '    PPX_PREDSP,           ';
  Result := Result +  '   PPX_PCUSCL,           ';
  Result := Result +  '   PPX_PCUSCG,           ';
  Result := Result +  '   PPX_PCUSCB,           ';
  Result := Result +  '   PPX_PCUSCT,           ';
  Result := Result +  '   PPX_PCUSCC,           ';
  Result := Result +  '   PPX_PCUSCS,           ';
  Result := Result +  '   PPX_PCUSDL,           ';
  Result := Result +  '   PPX_PCUSDG,           ';
  Result := Result +  '   PPX_PCUSDB,           ';
  Result := Result +  '   PPX_PCUSDT,           ';
  Result := Result +  '   PPX_PCUSDC,           ';
  Result := Result +  '   PPX_PCUSDS,           ';

  For intContador := 1 To 7 Do
  Begin
    Result := Result +  '   PPX_PRCLT' + IntToStr(intContador) + ',   ';
    Result := Result +  '   PPX_PRDLT' + IntToStr(intContador) + ',   ';
    Result := Result +  '   PPX_PRCGL' + IntToStr(intContador) + ',   ';
    Result := Result +  '   PPX_PRDGL' + IntToStr(intContador) + ',   ';
    Result := Result +  '   PPX_PRCBD' + IntToStr(intContador) + ',   ';
    Result := Result +  '   PPX_PRDBD' + IntToStr(intContador) + ',   ';
    Result := Result +  '   PPX_PRCTB' + IntToStr(intContador) + ',   ';
    Result := Result +  '   PPX_PRDTB' + IntToStr(intContador) + ',   ';
    Result := Result +  '   PPX_PRCCP' + IntToStr(intContador) + ',   ';
    Result := Result +  '   PPX_PRDCP' + IntToStr(intContador) + ',   ';
	Result := Result +  '   PPX_PRCSP' + IntToStr(intContador) + ',   ';
    Result := Result +  '   PPX_PRDSP' + IntToStr(intContador) + ',   ';
  End;

  Result := Result + '    PPX_EMBALT,           ';
  Result := Result + '    PPX_EMBAGL,           ';
  Result := Result + '    PPX_EMBABD,           ';
  Result := Result + '    PPX_EMBATB,           ';
  Result := Result + '    PPX_EMBACP,           ';
  Result := Result + '    PPX_EMBASP,           ';
  Result := Result + '    PPX_VOLULT,           ';
  Result := Result + '    PPX_VOLUGL,           ';
  Result := Result + '    PPX_VOLUBD,           ';
  Result := Result + '    PPX_VOLUTB,           ';
  Result := Result + '    PPX_VOLUCP,           ';
  Result := Result + '    PPX_VOLUSP,           ';
  Result := Result + '    PPX_PREELT,           ';
  Result := Result + '    PPX_PREEGL,           ';
  Result := Result + '    PPX_PREEBD,           ';
  Result := Result + '    PPX_PREETB,           ';
  Result := Result + '    PPX_PREECP,           ';
  Result := Result + '    PPX_PREESP,           ';
  Result := Result + '    PPX_TIPOLT,           ';
  Result := Result + '    PPX_TIPOGL,           ';
  Result := Result + '    PPX_TIPOBD,           ';
  Result := Result + '    PPX_TIPOTB,           ';
  Result := Result + '    PPX_TIPOCP,           ';
  Result := Result + '    PPX_TIPOSP            ';
  Result := Result + '          )                                       ';
  Result := Result + '  VALUES          (                               ';
  Result := Result + '    :DESCOR,              ';
  Result := Result + '    :CODCOR,              ';
  Result := Result + '    :CODATC,              ';
  Result := Result + '    :MARCA_,              ';
  Result := Result + '    :UTILIZ,              ';
  Result := Result + '    :SISTEM,              ';
  Result := Result + '    :EFEFIN,              ';
  Result := Result + '    :ORIGEM,              ';
  Result := Result + '    :PAISES,              ';
  Result := Result + '    :VEICUL,              ';
  Result := Result + '    :MONTAD,              ';
  Result := Result + '    :A_N_O_,              ';
  Result := Result + '    :TIPO__,              ';
  Result := Result + '    :MD5KEY,              ';
  Result := Result + '    :CODITE,              ';
  Result := Result + '    :CODDIL,              ';
  Result := Result + '    :PORDIL,              ';
  Result := Result + '    :PRECLT,              ';
  Result := Result + '    :PRECGL,              ';
  Result := Result + '    :PRECBD,              ';
  Result := Result + '    :PRECTB,              ';
  Result := Result + '    :PRECCP,              ';
  Result := Result + '    :PRECSP,              ';
  Result := Result + '    :PREDLT,              ';
  Result := Result + '    :PREDGL,              ';
  Result := Result + '    :PREDBD,              ';
  Result := Result + '    :PREDTB,              ';
  Result := Result + '    :PREDCP,              ';
  Result := Result + '    :PREDSP,              ';
  Result := Result +  '   :PCUSCL,              ';
  Result := Result +  '   :PCUSCG,              ';
  Result := Result +  '   :PCUSCB,              ';
  Result := Result +  '   :PCUSCT,              ';
  Result := Result +  '   :PCUSCC,              ';
  Result := Result +  '   :PCUSCS,              ';
  Result := Result +  '   :PCUSDL,              ';
  Result := Result +  '   :PCUSDG,              ';
  Result := Result +  '   :PCUSDB,              ';
  Result := Result +  '   :PCUSDT,              ';
  Result := Result +  '   :PCUSDC,              ';
  Result := Result +  '   :PCUSDS,              ';

  For intContador := 1 To 7 Do
  Begin
    Result := Result +  '   :PRCLT' + IntToStr(intContador) + ',    ';
    Result := Result +  '   :PRDLT' + IntToStr(intContador) + ',    ';
    Result := Result +  '   :PRCGL' + IntToStr(intContador) + ',    ';
    Result := Result +  '   :PRDGL' + IntToStr(intContador) + ',    ';
    Result := Result +  '   :PRCBD' + IntToStr(intContador) + ',    ';
    Result := Result +  '   :PRDBD' + IntToStr(intContador) + ',    ';
    Result := Result +  '   :PRCTB' + IntToStr(intContador) + ',    ';
    Result := Result +  '   :PRDTB' + IntToStr(intContador) + ',    ';
    Result := Result +  '   :PRCCP' + IntToStr(intContador) + ',    ';
    Result := Result +  '   :PRDCP' + IntToStr(intContador) + ',    ';
	Result := Result +  '   :PRCSP' + IntToStr(intContador) + ',    ';
    Result := Result +  '   :PRDSP' + IntToStr(intContador) + ',    ';
  End;

  Result := Result + '    :EMBALT,              ';
  Result := Result + '    :EMBAGL,              ';
  Result := Result + '    :EMBABD,              ';
  Result := Result + '    :EMBATB,              ';
  Result := Result + '    :EMBACP,              ';
  Result := Result + '    :EMBASP,              ';
  Result := Result + '    :VOLULT,              ';
  Result := Result + '    :VOLUGL,              ';
  Result := Result + '    :VOLUBD,              ';
  Result := Result + '    :VOLUTB,              ';
  Result := Result + '    :VOLUCP,              ';
  Result := Result + '    :VOLUSP,              ';
  Result := Result + '    :PREELT,              ';
  Result := Result + '    :PREEGL,              ';
  Result := Result + '    :PREEBD,              ';
  Result := Result + '    :PREETB,              ';
  Result := Result + '    :PREECP,              ';
  Result := Result + '    :PREESP,              ';
  Result := Result + '    :TIPOLT,              ';
  Result := Result + '    :TIPOGL,              ';
  Result := Result + '    :TIPOBD,              ';
  Result := Result + '    :TIPOTB,              ';
  Result := Result + '    :TIPOCP,              ';
  Result := Result + '    :TIPOSP               ';
  Result := Result + '            );                                    ';
end;

function TExportaTintometricosTerceirosPpgNexa.fValorQuantidade(fltValor,
  fltAcrMob: Double): Double;
begin
  If fltValor <= 0 Then
    Result := 0
  Else
    Result := fltValor + fltAcrMob;
end;

procedure TExportaTintometricosTerceirosPpgNexa.GetDiluentes(
  qryTinta: TUniQuery);
Var
  qryGen: TUniQuery;
  strSQL: String;
begin
  stlDiluentes.Clear;

  strSQL := '';
  strSQL := strSQL + '  SELECT DISTINCT             ';
  strSQL := strSQL + '    *                         ';
  strSQL := strSQL + '  FROM                        ';
  strSQL := strSQL + '    PPX_CADBAS B              ';
  strSQL := strSQL + '  INNER JOIN PPX_CADDIL D ON          ';
  strSQL := strSQL + '    B.BAS_CODBAS = D.DIL_CODDIL             ';
  strSQL := strSQL + '  WHERE                       ';
  strSQL := strSQL + '    BAS_TIPO__ = :TIPO AND            ';
  strSQL := strSQL + '    ((:SISTEM LIKE CONCAT("%", DIL_SISTEM, "%")) OR       ';
  strSQL := strSQL + '    (:SISTEM  = "PERSONALIZADA"))                         ';

  Try
    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.ParamByName('TIPO').AsString   := qryTinta.FieldByName('PPX_TIPO__').AsString;
    qryGen.ParamByName('SISTEM').AsString := qryTinta.FieldByName('PPX_SISTEM').AsString;
    qryGen.Open;

    While Not qryGen.Eof Do
    Begin
      stlDiluentes.Add(qryGen.FieldByName('BAS_CODBAS').AsString);
      qryGen.Next;
    End;


  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TExportaTintometricosTerceirosPpgNexa.pAdicionaParamentros(
  var DataSet: TFDQuery; qryTinta: TUniQuery; fltPreVen: Double; intParam: Integer = 0);
Var
  intContador: Integer;
  intEmb: Integer;
begin
  DataSet.ParamByName('DESCOR').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('PPX_DESCOR').AsString);
  DataSet.ParamByName('CODCOR').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('PPX_CODCOR').AsString);
  DataSet.ParamByName('CODATC').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('PPX_CODATC').AsString);
  DataSet.ParamByName('MARCA_').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('PPX_MARCA_').AsString);
  DataSet.ParamByName('UTILIZ').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('PPX_UTILIZ').AsString);
  DataSet.ParamByName('SISTEM').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('PPX_SISTEM').AsString);
  DataSet.ParamByName('EFEFIN').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('PPX_EFEFIN').AsString);
  DataSet.ParamByName('ORIGEM').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('PPX_ORIGEM').AsString);
  DataSet.ParamByName('PAISES').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('PPX_PAISES').AsString);
  DataSet.ParamByName('VEICUL').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('PPX_VEICUL').AsString);
  DataSet.ParamByName('MONTAD').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('PPX_MONTAD').AsString);
  DataSet.ParamByName('A_N_O_').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('PPX_A_N_O_').AsString);
  DataSet.ParamByName('TIPO__').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('PPX_TIPO__').AsString);
  DataSet.ParamByName('MD5KEY').AsStrings[intParam] := qryTinta.FieldByName('PPX_MD5KEY').AsString;
  DataSet.ParamByName('CODITE').AsStrings[intParam] := strProPpx;
  DataSet.ParamByName('PCUSCL').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONLT'], 0.0);
  DataSet.ParamByName('PCUSDL').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILLT'], 0.0);
  DataSet.ParamByName('PCUSCG').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONGL'], 0.0);
  DataSet.ParamByName('PCUSDG').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILGL'], 0.0);
  DataSet.ParamByName('PCUSCB').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONBD'], 0.0);
  DataSet.ParamByName('PCUSDB').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILBD'], 0.0);
  DataSet.ParamByName('PCUSCT').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONTB'], 0.0);
  DataSet.ParamByName('PCUSDT').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILTB'], 0.0);
  DataSet.ParamByName('PCUSCC').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONCP'], 0.0);
  DataSet.ParamByName('PCUSDC').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILCP'], 0.0);
  DataSet.ParamByName('PCUSCS').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONSP'], 0.0);
  DataSet.ParamByName('PCUSDS').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILSP'], 0.0);

  For intEmb := 0 To Length(arrEmbalagens) - 1 Do
  Begin
    If strAcrMob = '1' Then
    Begin
      arrPrecosPorEmb[intEmb].fltValCon := arrPrecosPorEmb[intEmb].fltValCon * (1 + qryTinta.FieldByName('PPX_ACRMOB').AsFloat / 100);
      arrPrecosPorEmb[intEmb].fltValDil := arrPrecosPorEmb[intEmb].fltValDil * (1 + qryTinta.FieldByName('PPX_ACRMOB').AsFloat / 100);
    End
    Else
    Begin
      arrPrecosPorEmb[intEmb].fltValCon := fValorQuantidade(arrPrecosPorEmb[intEmb].fltValCon, qryTinta.FieldByName('PPX_ACRMOB').AsFloat);
      arrPrecosPorEmb[intEmb].fltValDil := fValorQuantidade(arrPrecosPorEmb[intEmb].fltValDil, qryTinta.FieldByName('PPX_ACRMOB').AsFloat);
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
      DataSet.ParamByName('PRCBD' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONBD'], 0.0);
      DataSet.ParamByName('PRDBD' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILBD'], 0.0);
      DataSet.ParamByName('PRCTB' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONTB'], 0.0);
      DataSet.ParamByName('PRDTB' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILTB'], 0.0);
      DataSet.ParamByName('PRCCP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONCP'], 0.0);
      DataSet.ParamByName('PRDCP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCP'], 0.0);
	    DataSet.ParamByName('PRCSP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONSP'], 0.0);
      DataSet.ParamByName('PRDSP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILSP'], 0.0);
    End
    Else
    Begin
      If strAcrMob = '1' Then
      Begin
        DataSet.ParamByName('PRCLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLT'], 0.0) * (1 + qryTinta.FieldByName('PPX_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLT'], 0.0) * (1 + qryTinta.FieldByName('PPX_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONGL'], 0.0) * (1 + qryTinta.FieldByName('PPX_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILGL'], 0.0) * (1 + qryTinta.FieldByName('PPX_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCBD' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONBD'], 0.0) * (1 + qryTinta.FieldByName('PPX_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDBD' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILBD'], 0.0) * (1 + qryTinta.FieldByName('PPX_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCTB' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONTB'], 0.0) * (1 + qryTinta.FieldByName('PPX_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDTB' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILTB'], 0.0) * (1 + qryTinta.FieldByName('PPX_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCCP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONCP'], 0.0) * (1 + qryTinta.FieldByName('PPX_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDCP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCP'], 0.0) * (1 + qryTinta.FieldByName('PPX_ACRMOB').AsFloat / 100);
    		DataSet.ParamByName('PRCSP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONSP'], 0.0) * (1 + qryTinta.FieldByName('PPX_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDSP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILSP'], 0.0) * (1 + qryTinta.FieldByName('PPX_ACRMOB').AsFloat / 100);
      End
      Else
      Begin
        DataSet.ParamByName('PRCLT' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLT'], 0.0), qryTinta.FieldByName('PPX_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDLT' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLT'], 0.0), qryTinta.FieldByName('PPX_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCGL' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONGL'], 0.0), qryTinta.FieldByName('PPX_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDGL' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILGL'], 0.0), qryTinta.FieldByName('PPX_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCBD' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONBD'], 0.0), qryTinta.FieldByName('PPX_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDBD' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILBD'], 0.0), qryTinta.FieldByName('PPX_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCTB' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONTB'], 0.0), qryTinta.FieldByName('PPX_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDTB' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILTB'], 0.0), qryTinta.FieldByName('PPX_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCCP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONCP'], 0.0), qryTinta.FieldByName('PPX_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDCP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCP'], 0.0), qryTinta.FieldByName('PPX_ACRMOB').AsFloat);
		    DataSet.ParamByName('PRCSP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONSP'], 0.0), qryTinta.FieldByName('PPX_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDSP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILSP'], 0.0), qryTinta.FieldByName('PPX_ACRMOB').AsFloat);
      End;
    End;
  End;
end;

procedure TExportaTintometricosTerceirosPpgNexa.pCriaClientEmbalagem(
  Conexao: TUniConnection);
Var
  qryGen: TUniQuery;
  strSQL: String;
begin
  Try
    strSQL := strSQL + '  SELECT            ';
    strSQL := strSQL + '    *               ';
    strSQL := strSQL + '  FROM              ';
    strSQL := strSQL + '    CFGTIN          ';
    strSQL := strSQL + '  WHERE             ';
    strSQL := strSQL + '    CFG_IDEPRO = "PPX"  AND                 ';
    strSQL := strSQL + '    CFG_GRUCFG = "CONFIGURACOES"  AND       ';
    strSQL := strSQL + '    CFG_CODEMP = "' + VS_strCodEmp + '"     ';

    qryGen := fCriaQuery(Nil, Conexao);
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.Open;

    cdsEmbalagens := fCriaClientDatset(qryGen, False, Nil, False);
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TExportaTintometricosTerceirosPpgNexa.pGravaTintometricoPorTintaTerceiros(
  qryInsert: TFDQuery; fltPreVen: Double; qryTinta: TUniQuery; intParam: Integer = 0);
var
  intEmb: Integer;
  strSigEmb: String;
begin
  Try
    Begin
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


        If fEmptyStr(qryInsert.ParamByName('CODDIL').AsStrings[intParam]) Then
        Begin
          qryInsert.ParamByName('CODDIL').AsStrings[intParam] := arrPrecosPorEmb[intEmb].strCodDil; //Código do diluente
          qryInsert.ParamByName('PORDIL').AsFloats[intParam]  := arrPrecosPorEmb[intEmb].fltPorDil;//Porcentagem do diluente
        End;
      End;
    End;
  Finally
    SetLength(arrPrecosPorEmb, 0);
  End;
end;

procedure TExportaTintometricosTerceirosPpgNexa.pIncluirLogTinSite(
  Conexao: TUniConnection; strStatus: String);
Var
  qryGen: TUniQuery;
  strSQL: String;
begin
  Try
    strSQL := '';
    strSQL := strSQL + '  DELETE FROM LOGTIN_SIT WHERE LOG_IDEPRO = "PPX"     ';

    qryGen := fCriaQuery(Nil, Conexao);
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.ExecSQL;

    strSQL := '';
    strSQL := strSQL + '  INSERT INTO LOGTIN_SIT (            ';
    strSQL := strSQL + '    LOG_IDEPRO,           ';
    strSQL := strSQL + '    LOG_DTAEXE,           ';
    strSQL := strSQL + '    LOG_HOREXE,           ';
    strSQL := strSQL + '    LOG_EXECUT            ';
    strSQL := strSQL + '            )                         ';
    strSQL := strSQL + '  VALUES      (                       ';
    strSQL := strSQL + '    "PPX",                ';
    strSQL := strSQL + '    :DTAEXE,              ';
    strSQL := strSQL + '    :HOREXE,              ';
    strSQL := strSQL + '    :EXECUT               ';
    strSQL := strSQL + '            )                         ';

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

procedure TExportaTintometricosTerceirosPpgNexa.pPreencheArrayEmbalagem;
begin
  SetLength(arrEmbalagens, 1);

  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Litro';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'LT';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 1.000;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Galão';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'GL';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 3.600;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Balde';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'BD';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 18.000;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Tambor';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'TB';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 200.000;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Copo';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'CP';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 0.500;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);
  
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Spray';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'SP';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 0.450;
end;

procedure TExportaTintometricosTerceirosPpgNexa.pPreencheEmbalagens;
begin
  pPreencheArrayEmbalagem;
end;

procedure TExportaTintometricosTerceirosPpgNexa.pProcessaTabelaCores(
  qryInsert: TFDQuery; qryGen, qryBases, qryColorantes: TUniQuery; strTabUni,
  strTabPre: String; fltPerAcr: Double; dicRetorno: TDicionario);
Var
  fltPreVen  : Double;
  intContador: Integer;
  intRegistros: Integer;
  intEmb: Integer;
  intEmbValidacao: Integer;
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
          intEmbValidacao := Random(Length(arrEmbalagens) - 1);

          If intEmb > 1 Then
            Break;

          If fGetCountRegister(qryGen) Then
          Begin
            pValidarPrecoExportacao(qryGen.FieldByName(fRetMD5KEY).AsString,
              arrEmbalagens[intEmbValidacao].strNomEmb, 'C', arrEmbalagens[intEmbValidacao].strSigEmb,
              arrPrecosPorEmb[intEmbValidacao].fltValCon, dicPrecoAdicional, '_CON');
          End
          Else
          Begin
            If blnDiluido Then
            Begin
              pValidarPrecoExportacao(qryGen.FieldByName(fRetMD5KEY).AsString,
                arrEmbalagens[intEmbValidacao].strNomEmb, 'D', arrEmbalagens[intEmbValidacao].strSigEmb,
                arrPrecosPorEmb[intEmbValidacao].fltValDil, dicPrecoAdicional, '_DIL');
            End;
          End;
        End;
      End;
    {$ENDIF}


      fltPreven := IfNull(dicRetorno['preve'+dicRetorno['tabelaunica']], 0.0);
      pGravaTintometricoPorTintaTerceiros(qryInsert, fltPreven, qryGen, intContador);

      If ((qryGen.RecNo mod 100 = 0) Or (qryGen.RecNo = intMax)) And (Not FAutoma) Then
          Synchronize(pStep);

      If Not qryGen.Eof Then
        qryGen.Next
      Else
        Break;

      Inc(intContador, 1);
    End;

  {$IFDEF LINUX}
    If Not fValidarPrecosCalculado(False, 1999) Then
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

procedure TExportaTintometricosTerceirosPpgNexa.pRecalculaFormula(
  dicRetorno: TDicionario; qryGen, qryBases: TUniQuery);
Var
  intCont: Integer;
  fltTotalVolumeAtual: Double;
  fltTotalVolumeDiluido: Double;
  fltTaxa: Double;
  fltPorDil: Double;
  strSQL: String;
  fltPesEsp: Double;
  fltQuantidade: Double;
begin
  blnDiluido := False;
  ///////////////////////////////////////////////////
  //Procedure aonde carrega os diluidos da formula///
  ////////////////////////////////////////////////RG/
  GetDiluentes(qryGen);

  If Pos('PERSONALIZ', qryGen.FieldByName('PPX_SISTEM').AsString) > 0 Then
    dicRetorno['NVFORMULA'] := 'S'
  Else
    dicRetorno['NVFORMULA'] := 'N';

  strSQL := '';
  strSQL := strSQL + '  SELECT DISTINCT             ';
  strSQL := strSQL + '    *                         ';
  strSQL := strSQL + '  FROM                        ';
  strSQL := strSQL + '    PPX_CADBAS B              ';
  strSQL := strSQL + '  INNER JOIN PPX_CADDIL D ON          ';
  strSQL := strSQL + '    B.BAS_CODBAS = D.DIL_CODDIL             ';
  strSQL := strSQL + '  WHERE                       ';
  strSQL := strSQL + '    BAS_TIPO__ = :TIPO  AND           ';
  strSQL := strSQL + '    ((:SISTEM LIKE CONCAT("%", DIL_SISTEM, "%")) OR         ';
  strSQL := strSQL + '    (:SISTEM = "PERSONALIZADA"))    AND     ';
  strSQL := strSQL + '    D.DIL_CODDIL = :DILUEN                  ';

  qryDiluentes.Close;
  qryDiluentes.SQL.Clear;
  qryDiluentes.SQL.Add(strSQL);
  qryDiluentes.ParamByName('TIPO').AsString := qryGen.FieldByName('PPX_TIPO__').AsString;
  qryDiluentes.ParamByName('SISTEM').AsString := qryGen.FieldByName('PPX_SISTEM').AsString;

  If stlDiluentes.Count > 0 Then
    qryDiluentes.ParamByName('DILUEN').AsString := stlDiluentes[0]
  Else
    qryDiluentes.ParamByName('DILUEN').AsString := '';

  qryDiluentes.Open;

  If qryDiluentes.IsEmpty Then
    Exit;

  blnDiluido := True;

  fltTotalVolumeAtual := 0;

  For intCont := 1 To fQuantidadeFormulacao() Do
  Begin

    If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intCont, 2)], ''))) Then
      Break;

    If qryBasEmp.Locate('BAS_CODBAS;BAS_CODEMP', VarArrayOf([dicRetorno['base' + fStrZero(intCont, 2)], VS_strCodEmp]), []) Then
      fltPesEsp := qryBasEmp.FieldByName('BAS_PESESP').AsFloat
    Else If qryBases.Locate('BAS_CODBAS', dicRetorno['base' + fStrZero(intCont, 2)], []) Then
      fltPesEsp := qryBases.FieldByName('BAS_PESESP').AsFloat
    Else
      Break;

    fltQuantidade := qryGen.FieldByName(fRetQuantidade(intCont)).AsFloat;

    fltTotalVolumeAtual := fltTotalVolumeAtual + (fltQuantidade / fltPesEsp);
  End;

  fltPorDil := qryDiluentes.FieldByName('DIL_MINIMO').AsFloat;

  fltTotalVolumeDiluido := fltTotalVolumeAtual + (fltPorDil * fltTotalVolumeAtual / 100);
  fltTaxa := (fltTotalVolumeAtual / fltTotalVolumeDiluido);

  //Adicionando o diluente na ultima posicao
  For intCont := 1 To fQuantidadeFormulacao Do
  Begin
    If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intCont, 2)], ''))) Then
    Begin
      dicRetorno['base' + fStrZero(intCont, 2)] := qryDiluentes.FieldByName('BAS_CODBAS').AsString;
      dicRetorno['qtdb' + fStrZero(intCont, 2)] := 0;
      dicRetorno['qtdd' + fStrZero(intCont, 2)] := ((fltPorDil * fltTotalVolumeAtual / 100) * qryDiluentes.FieldByName('BAS_PESESP').AsFloat);

      dicRetorno['coddil'] := qryDiluentes.FieldByName('BAS_CODBAS').AsString;
      dicRetorno['pordil'] := qryDiluentes.FieldByName('DIL_MINIMO').AsFloat;
      Break;
    End;
  End;

  //Aplicando a taxa de diluicao
  For intCont := 1 To fQuantidadeFormulacao Do
  Begin
    If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intCont, 2)], ''))) Then
      Break;

    If IfNull(dicRetorno['qtdb' + fStrZero(intCont, 2)], 0) > 0 Then
      dicRetorno['qtdd' + fStrZero(intCont, 2)] := dicRetorno['qtdb' + fStrZero(intCont, 2)] * fltTaxa
    Else
      dicRetorno['qtdd' + fStrZero(intCont, 2)] := dicRetorno['qtdd' + fStrZero(intCont, 2)] * fltTaxa;
  End;
end;

procedure TExportaTintometricosTerceirosPpgNexa.pRetPrecosAdicionais(
  dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery;
  fltPerAcr: Double);
Var
  intContador: Integer;
  intPreVen: Integer;
  fltQuantCon,
  fltPrecoVendaCon,
  fltPrecoVendaTotalCon,
  fltQuantDil,
  fltPrecoVendaDil,
  fltPrecoVendaTotalDil,
  fltPrecoCustoCon,
  fltPrecoCustoDil,
  fltPrecoCustoTotalCon,
  fltPrecoCustoTotalDil,
  fltPrecoBase,
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
  strEmb: String;
begin
  fltPrecoBase       := 0;
  fltPrecoEmbalagem  := 0;
  fltPreCusPro       := 0;
  fltPreVenPro       := 0;
  strCodCli          := '';
  strCodCnd          := '';
  intPrzMed          := 0;
  fltEmbala          := 0;


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
      SetLength(arrComponentes, fQuantidadeFormulacao());

      For intContador := 1 To fQuantidadeFormulacao Do
      Begin
        If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intContador, 2)], ''))) Then
          Break;

        If (Not qryBases.Locate('BAS_CODBAS', dicRetorno['base' + fStrZero(intContador, 2)], [])) Then
          Break;

        ArrComponentes[intContador].Componente := dicRetorno['base' + fStrZero(intContador, 2)];

        If dicRetorno['NVFORMULA'] = 'S' Then
        Begin
          ArrComponentes[intContador].Quantidade := dicRetorno['qtdb' + fStrZero(intContador, 2)];
          ArrComponentes[intContador].Quantiddil := IfNull(dicRetorno['qtdd' + fStrZero(intContador, 2)], 0);
        End
        Else
        Begin
          ArrComponentes[intContador].Quantidade := fArredondaPPX(fFormataFloat(dicRetorno['qtdb' + fStrZero(intContador, 2)], 1));
          ArrComponentes[intContador].Quantiddil := fArredondaPPX(fFormataFloat(IfNull(dicRetorno['qtdd' + fStrZero(intContador, 2)], 0), 1));
        End;

      End;

      For intPreVen := 1 To 7 Do
      Begin
        fltPrecoVendaTotalCon := 0;
        fltPrecoVendaTotalDil := 0;

        If stlTabPre[intPreVen] <> 'S' Then
          Continue;

        For intContador := 1 To Length(ArrComponentes) Do
        Begin
          If fEmptyStr(ArrComponentes[intContador].Componente) Then
            Break;

          If qryBasEmp.Locate('BAS_CODBAS;BAS_CODEMP', VarArrayOf([ArrComponentes[intContador].Componente,
            VS_strCodEmp]), []) Then
          Begin
            If fCarregaPromocao(qryBasEmp.FieldByName('BAS_CODITE').AsString,
              IntToStr(intPreVen), strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
              fltPrecoBase := fltPreVenPro
            Else
              fltPrecoBase := qryBasEmp.FieldByName('PREVE' + IntToStr(intPreVen)).AsFloat;

            fltEmbala := fRetEmbalagem(qryBasEmp);
          End
          Else If qryBases.Locate('BAS_CODBAS', ArrComponentes[intContador].Componente,[]) Then
          Begin
            If fCarregaPromocao(qryBases.FieldByName('BAS_CODITE').AsString,
              IntToStr(intPreVen), strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
              fltPrecoBase := fltPreVenPro
            Else
              fltPrecoBase := qryBases.FieldByName('PREVE' + IntToStr(intPreVen)).AsFloat;

            fltEmbala := fRetEmbalagem(qryBases);
          End;

          //Preco de venda concentrado
          fltQuantCon := ArrComponentes[intContador].Quantidade;
          fltPrecoVendaCon := (((arrEmbalagens[intEmb].fltVolume / 1 * fltQuantCon) * fltPrecoBase) / fltEmbala);
          fltPrecoVendaTotalCon := fltPrecoVendaTotalCon + fltPrecoVendaCon;

          //Preco de venda diluido
          fltQuantDil := ArrComponentes[intContador].Quantiddil;
          fltPrecoVendaDil := (((arrEmbalagens[intEmb].fltVolume / 1 * fltQuantDil) * fltPrecoBase) / fltEmbala);
          fltPrecoVendaTotalDil := fltPrecoVendaTotalDil + fltPrecoVendaDil;
        End;

        If IsInfinite(fltPrecoVendaTotalCon) Or IsNan(fltPrecoVendaTotalCon) Then
          fltPrecoVendaTotalCon := 0.0;

        If IsInfinite(fltPrecoVendaTotalDil) Or IsNan(fltPrecoVendaTotalDil) Then
          fltPrecoVendaTotalDil := 0.0;

        //Retorna preco da embalagem
        If cdsEmbalagens.Locate('CFG_CODCFG', strCamEmb, []) Then
        Begin
          If fCarregaPromocao(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString,
            strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
            fltPrecoEmbalagem := fltPreVenPro + (fltPerAcr * fltPreVenPro)
          Else
            fltPrecoEmbalagem := fSelecionaPrecoVendaEmbalagemTabClientes(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString, fltPerAcr, intPreVen);
        End;

        //Preco de venda concentrado
        If fltPrecoVendaTotalCon > 0 Then
          fltPrecoVendaTotalCon := fltPrecoVendaTotalCon +
            (fltPerAcr * fltPrecoVendaTotalCon) + fltPrecoEmbalagem;

        //Preco de venda diluido
        If fltPrecoVendaTotalDil > 0 Then
          fltPrecoVendaTotalDil := fltPrecoVendaTotalDil +
            (fltPerAcr * fltPrecoVendaTotalDil) + fltPrecoEmbalagem;

        dicPrecoAdicional['PREVE' + IntToStr(intPreVen) + '_CON'+ strEmb] := fltPrecoVendaTotalCon;
        dicPrecoAdicional['PREVE' + IntToStr(intPreVen) + '_DIL'+ strEmb] := fltPrecoVendaTotalDil;
      End;

      //Calcula o preço de custo
      fltPrecoCustoTotalCon := 0;
      fltPrecoCustoTotalDil := 0;

      For intContador := 1 To Length(ArrComponentes) Do
      Begin
        If fEmptyStr(ArrComponentes[intContador].Componente) Then
          Break;

        If qryBasEmp.Locate('BAS_CODBAS;BAS_CODEMP', VarArrayOf([ArrComponentes[intContador].Componente,
          VS_strCodEmp]), []) Then
        Begin
          If fCarregaPromocao(qryBasEmp.FieldByName('BAS_CODITE').AsString,
            strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
            fltPrecoBase := fltPreCusPro
          Else
            fltPrecoBase := qryBasEmp.FieldByName('PRECUS').AsFloat;

          fltEmbala := fRetEmbalagem(qryBasEmp);
        End
        Else If qryBases.Locate('BAS_CODBAS', ArrComponentes[intContador].Componente,[]) Then
        Begin
          If fCarregaPromocao(qryBases.FieldByName('BAS_CODITE').AsString,
            strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
            fltPrecoBase := fltPreVenPro
          Else
            fltPrecoBase := qryBases.FieldByName('PRECUS').AsFloat;

          fltEmbala := fRetEmbalagem(qryBases);
        End;

        //Preco de custo concentrado
        fltQuantCon := (ArrComponentes[intContador].Quantidade * arrEmbalagens[intEmb].fltVolume / 1);
        fltPrecoCustoCon := (fltQuantCon * fltPrecoBase / fltEmbala);
        fltPrecoCustoTotalCon := fltPrecoCustoTotalCon + fltPrecoCustoCon;

        //Preco de custo diluido
        fltQuantDil := (ArrComponentes[intContador].Quantiddil * arrEmbalagens[intEmb].fltVolume / 1);
        fltPrecoCustoDil := (fltQuantDil * fltPrecoBase / fltEmbala);
        fltPrecoCustoTotalDil := fltPrecoCustoTotalDil + fltPrecoCustoDil;
      End;

      If IsInfinite(fltPrecoCustoTotalCon) Or IsNan(fltPrecoCustoTotalCon) Then
        fltPrecoCustoTotalCon := 0.0;

      If IsInfinite(fltPrecoCustoTotalDil) Or IsNan(fltPrecoCustoTotalDil) Then
        fltPrecoCustoTotalDil := 0.0;

      //Retorna preço de custo da embalagem
      If cdsEmbalagens.Locate('CFG_CODCFG', strCamEmb, []) Then
      Begin
        If fCarregaPromocao(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString,
            strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
          fltPrecoEmbalagem := fltPreCusPro + (fltPerAcr * fltPreCusPro)
        Else
          fltPrecoEmbalagem := fSelecionaPrecoCustoEmbalagem(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString, fltPerAcr);
      End;

      //Preco de custo concentrado
      If fltPrecoCustoTotalCon > 0 Then
        fltPrecoCustoTotalCon := fltPrecoCustoTotalCon +
          (fltPerAcr * fltPrecoCustoTotalCon) + fltPrecoEmbalagem;

      //Preco de custo diluido
      If fltPrecoCustoTotalDil > 0 Then
        fltPrecoCustoTotalDil := fltPrecoCustoTotalDil +
          (fltPerAcr * fltPrecoCustoTotalDil) + fltPrecoEmbalagem;

      dicPrecoAdicional['PRECUS_CON' + strEmb] := fltPrecoCustoTotalCon;
      dicPrecoAdicional['PRECUS_DIL' + strEmb] := fltPrecoCustoTotalDil;
    Finally
      SetLength(arrComponentes, 0);
    End;
  End;
end;

procedure TExportaTintometricosTerceirosPpgNexa.pRetPrecoTintas(
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
  fltEmbala          := 0;


  strTabelaUnica := dicRetorno['tabelaunica'];

  strProPpx := fRetItemVenda(dicRetorno['tipcor']);

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

        If dicRetorno['NVFORMULA'] = 'S' Then
        Begin
          ArrComponentes[intContador].Quantidade := dicRetorno['qtdb' + fStrZero(intContador, 2)];
          ArrComponentes[intContador].Quantiddil := IfNull(dicRetorno['qtdd' + fStrZero(intContador, 2)], 0);
        End
        Else
        Begin
          ArrComponentes[intContador].Quantidade := fArredondaPPX(fFormataFloat(dicRetorno['qtdb' + fStrZero(intContador, 2)], 1));
          ArrComponentes[intContador].Quantiddil := fArredondaPPX(fFormataFloat(IfNull(dicRetorno['qtdd' + fStrZero(intContador, 2)], 0), 1));
        End;
      End;

      For intContador := 1 To Length(ArrComponentes) Do
      Begin
        If fEmptyStr(ArrComponentes[intContador].Componente) Then
          Break;

        If qryBasEmp.Locate('BAS_CODBAS;BAS_CODEMP', VarArrayOf([ArrComponentes[intContador].Componente,
          VS_strCodEmp]), []) Then
        Begin
          If fCarregaPromocao(qryBasEmp.FieldByName('BAS_CODITE').AsString,
            strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
            fltPrecoBase := fltPreVenPro
          Else
            fltPrecoBase := qryBasEmp.FieldByName('ITE_PREVEN').AsFloat;

          fltEmbala := fRetEmbalagem(qryBasEmp);
        End
        Else If qryBases.Locate('BAS_CODBAS', ArrComponentes[intContador].Componente,[]) Then
        Begin
          If fCarregaPromocao(qryBases.FieldByName('BAS_CODITE').AsString,
            strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
            fltPrecoBase := fltPreVenPro
          Else
            fltPrecoBase := qryBases.FieldByName('ITE_PREVEN').AsFloat;

          fltEmbala := fRetEmbalagem(qryBases);
        End;

        //Preco de venda concentrado
        fltQuantCon := ArrComponentes[intContador].Quantidade;
        fltPrecoVendaCon := (((arrEmbalagens[intEmb].fltVolume / 1 * fltQuantCon) * fltPrecoBase) / fltEmbala);
        fltPrecoVendaTotalCon := fltPrecoVendaTotalCon + fltPrecoVendaCon;

        //Preco de venda diluido
        fltQuantDil := ArrComponentes[intContador].Quantiddil;
        fltPrecoVendaDil := (((arrEmbalagens[intEmb].fltVolume / 1 * fltQuantDil) * fltPrecoBase) / fltEmbala);
        fltPrecoVendaTotalDil := fltPrecoVendaTotalDil + fltPrecoVendaDil;
      End;

      If IsInfinite(fltPrecoVendaTotalCon) Or IsNan(fltPrecoVendaTotalCon) Then
          fltPrecoVendaTotalCon := 0.0;

        If IsInfinite(fltPrecoVendaTotalDil) Or IsNan(fltPrecoVendaTotalDil) Then
          fltPrecoVendaTotalDil := 0.0;

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

procedure TExportaTintometricosTerceirosPpgNexa.pRetTabelasVenda(
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

procedure TExportaTintometricosTerceirosPpgNexa.pSetaParametrosEspecificos(
  Conexao: TUniConnection);
begin
  pCriaClientEmbalagem(Conexao);
  pRetTabelasVenda(Conexao);
end;

end.
