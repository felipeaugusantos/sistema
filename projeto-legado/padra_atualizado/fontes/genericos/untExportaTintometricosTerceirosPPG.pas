unit untExportaTintometricosTerceirosPPG;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  untFuncoesSimples, Windows, Messages,
  cxProgressBar, UniClientDataSet,
  FireDAC.VCLUI.Wait,
{$ENDIF}
  Uni, SysUtils, Variants, Classes, Math, DB,
  untThreadExportacaoTerceiros, DateUtils,
  untExportaTintometricosTerceirosAutomotiva,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.UI;

Type
  TPpgArray = Record
    Tipo: String;
  End;

THackPpg = Array Of TPpgArray;

Type
  TExportaTintometricosTerceirosPPG = class(TExportaTintometricosTerceirosAutomotiva)
  private
    blnNovFor: Boolean;
    strProPpg: String; //Produto para venda PPG
    strAcrMob: String;
    blnDiluido: Boolean;
    qryBasEmp: TUniQuery; //Base por Empresa
    arrTipoPpg: THackPpg;
    procedure pProcessarBasesEmpresas;
    function fCarregarBasesEmpresa(): String;
    function fRetValorAcrMobCfgTin(): String;
    function fArredondaPPG(fltValor: Double): Double;
    function fValorQuantidade(fltValor: Double; fltAcrMob: Double): Double;
  {$IFDEF LINUX}
    function fGetCountRegister(qryGen: TUniQuery): Boolean;
  {$ENDIF}
  Protected
    procedure pProcessaTabelaCores(qryInsert: TFDQuery; qryGen, qryBases, qryColorantes: TUniQuery;
       strTabUni, strTabPre: String; fltPerAcr: Double; dicRetorno: TDicionario); Override;
  public
    function fNomeTabela: String; override;
    function fCamposTabela: String; override;
    function fCamposSelect: String; override;
    function fQuantidadeFormulacao: Integer; override;
    function fFatorTinta: Double; override;
    function fRetDescricao: String; override;
    function fRetItemBase: String; override;
    function fRetMD5KEY: String; override;
    function fRetFormula(intCont: Integer): String; override;
    function fRetQuantidade(intCont: Integer): String; override;
    function fSQLInsert: String; override;
    procedure pAdicionaParamentros(Var DataSet: TFDQuery; qryTinta: TUniQuery; fltPreVen: Double; intParam: Integer = 0); override;
    function fRetornaColorantes: String; override;
    function fRetornaBases: String; override;
    function fRetornaPercentualAcrescimo(Conexao: TUniConnection): Double; override;
    function fRetEmbalagem(qryColorantes: TUniQuery): Double; override;
    procedure pIncluirLogTinSite(Conexao: TUniConnection; strStatus: String); override;
    procedure pRecalculaFormula(dicRetorno: TDicionario; qryGen: TUniQuery; qryBases: TUniQuery); override;
    function fRetornaCampoEmbalagem(strSigEmb: String; dicRetorno: TDicionario): String; override;
    procedure pSetaParametrosEspecificos(Conexao: TUniConnection); override;
    procedure pRetPrecoTintas(dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery; fltPerAcr: Double); Override;
    procedure pRetPrecosAdicionais(dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery; fltPerAcr: Double); Override;
    function fGetTipoFormula(qryGen: TUniQuery; qryBases: TUniQuery): Integer; Override;
    procedure pGravaTintometricoPorTintaTerceiros(qryInsert: TFDQuery; fltPreVen: Double; qryTinta: TUniQuery; intParam: Integer = 0); override;
    function fRetTipoCor: String; override;
    function fRetornaCodigoDiluente(dicRetorno: TDicionario): String; override;
    function fRetornaPorcentagemDiluente(dicRetorno: TDicionario): Double; override;
    function fGetPorLinha(): Integer; Override;
    constructor Create(pgbProgresso: TcxProgressBar; strIdePro: String;  blnAuto: Boolean = False); override;
    destructor Destroy; override;
    procedure Execute; override;

    procedure pPreencheEmbalagens;
    procedure pPreencheArrayEmbalagem;
    function fRetEmbalagemLT(strTipCor: String): String;
    function fRetEmbalagemGL(strTipCor: String): String;
    function fRetEmbalagemBD(strTipCor: String): String;
    function fRetEmbalagemTB(strTipCor: String): String;
    function fRetornaTipoFormulacao(Conexao: TUniConnection): Boolean;
    function fRetornaProdutoParaVenda(Conexao: TUniConnection): String;
    procedure pCriaClientEmbalagem(Conexao: TUniConnection);
    procedure pCriaClientDiluente(Conexao: TUniConnection);
    procedure pRetTabelasVenda(Conexao: TUniConnection);
  End;

implementation

{ TExportaTintometricosTerceirosPPG }

constructor TExportaTintometricosTerceirosPPG.Create(
  pgbProgresso: TcxProgressBar; strIdePro: String; blnAuto: Boolean);
begin
  inherited;
  pPreencheEmbalagens;
  blnNovFor := False;
  strProPpg := '';
  dicPrecoAdicional := TDicionario.Create();
  stlTabPre := TStringList.Create();
  strAcrMob := fRetValorAcrMobCfgTin();
  pProcessarBasesEmpresas;
end;

destructor TExportaTintometricosTerceirosPPG.Destroy;
begin
  inherited;

  If Assigned(dicPrecoAdicional) Then
    FreeAndNil(dicPrecoAdicional);

  If Assigned(stlTabPre) Then
    FreeAndNil(stlTabPre);

  If Assigned(qryBasEmp) Then
    FreeAndNil(qryBasEmp);
end;

procedure TExportaTintometricosTerceirosPPG.Execute;
begin
  inherited;

end;

function TExportaTintometricosTerceirosPPG.fArredondaPPG(
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

function TExportaTintometricosTerceirosPPG.fCamposSelect: String;
begin
  Result := '';
  Result := Result + ' SELECT  ';

  Result := Result + '     PPG_DESCOR,  ';
  Result := Result + '     PPG_CODCOR,  ';
  Result := Result + '     PPG_CODATC,  ';
  Result := Result + '     PPG_VARIAN,  ';
  Result := Result + '     PPG_REFERE,  ';
  Result := Result + '     PPG_MARCA_,  ';
  Result := Result + '     PPG_UTILIZ,  ';
  Result := Result + '     PPG_SISTEM,  ';
  Result := Result + '     PPG_EFEFIN,  ';
  Result := Result + '     PPG_ORIGEM,  ';
  Result := Result + '     PPG_PAISES,  ';
  Result := Result + '     PPG_VEICUL,  ';
  Result := Result + '     PPG_MONTAD,  ';
  Result := Result + '     PPG_A_N_O_,  ';
  Result := Result + '     PPG_TIPO__,  ';
  Result := Result + '     PPG_MD5KEY,  ';
  Result := Result + '     MON_DESCRI,  ';
  Result := Result + '     PPG_ACRMOB,  ';

  Result := Result + '     PPG_CODB01,  ';
  Result := Result + '     PPG_CODB02,  ';
  Result := Result + '     PPG_CODB03,  ';
  Result := Result + '     PPG_CODB04,  ';
  Result := Result + '     PPG_CODB05,  ';
  Result := Result + '     PPG_CODB06,  ';
  Result := Result + '     PPG_CODB07,  ';
  Result := Result + '     PPG_CODB08,  ';
  Result := Result + '     PPG_CODB09,  ';
  Result := Result + '     PPG_CODB10,  ';
  Result := Result + '     PPG_CODB11,  ';
  Result := Result + '     PPG_CODB12,  ';
  Result := Result + '     PPG_CODB13,  ';
  Result := Result + '     PPG_CODB14,  ';
  Result := Result + '     PPG_CODB15,  ';
  Result := Result + '     PPG_CODB16,  ';
  Result := Result + '     PPG_CODB17,  ';
  Result := Result + '     PPG_CODB18,  ';
  Result := Result + '     PPG_CODB19,  ';
  Result := Result + '     PPG_CODB20,  ';
  Result := Result + '     PPG_QTDB01,  ';
  Result := Result + '     PPG_QTDB02,  ';
  Result := Result + '     PPG_QTDB03,  ';
  Result := Result + '     PPG_QTDB04,  ';
  Result := Result + '     PPG_QTDB05,  ';
  Result := Result + '     PPG_QTDB06,  ';
  Result := Result + '     PPG_QTDB07,  ';
  Result := Result + '     PPG_QTDB08,  ';
  Result := Result + '     PPG_QTDB09,  ';
  Result := Result + '     PPG_QTDB10,  ';
  Result := Result + '     PPG_QTDB11,  ';
  Result := Result + '     PPG_QTDB12,  ';
  Result := Result + '     PPG_QTDB13,  ';
  Result := Result + '     PPG_QTDB14,  ';
  Result := Result + '     PPG_QTDB15,  ';
  Result := Result + '     PPG_QTDB16,  ';
  Result := Result + '     PPG_QTDB17,  ';
  Result := Result + '     PPG_QTDB18,  ';
  Result := Result + '     PPG_QTDB19,  ';
  Result := Result + '     PPG_QTDB20   ';
  Result := Result + ' FROM PPG_CADPPG  ';
  Result := Result + '   INNER JOIN PPG_CADBAS  ';
  Result := Result + '     ON PPG_CODB01 = BAS_CODBAS ';
  Result := Result + '   LEFT JOIN PPG_CADMON  ';
  Result := Result + '     ON PPG_MONTAD = MON_CODMON ';
  Result := Result + ' WHERE TRUE  ';
  Result := Result + '  AND PPG_SISTEM = "' + arrTipoPpg[intLinha].Tipo + '"  ';
end;

function TExportaTintometricosTerceirosPPG.fCamposTabela: String;
begin
  Result := '';
  Result := Result + ' CREATE TABLE ' + fNomeTabela;
  Result := Result + ' ( PPG_DESCOR VARCHAR(35),   ';
  Result := Result + '   PPG_CODCOR VARCHAR(100),  ';
  Result := Result + '   PPG_CODATC VARCHAR(25),   ';
  Result := Result + '   PPG_VARIAN VARCHAR(40),   ';
  Result := Result + '   PPG_REFERE VARCHAR(10),   ';
  Result := Result + '   PPG_MARCA_ VARCHAR(20),   ';
  Result := Result + '   PPG_UTILIZ VARCHAR(25),   ';
  Result := Result + '   PPG_SISTEM VARCHAR(50),   ';
  Result := Result + '   PPG_EFEFIN VARCHAR(50),   ';
  Result := Result + '   PPG_ORIGEM VARCHAR(50),   ';
  Result := Result + '   PPG_PAISES VARCHAR(50),   ';
  Result := Result + '   PPG_VEICUL VARCHAR(35),   ';
  Result := Result + '   PPG_MONTAD VARCHAR(40),   '; //descrição da montadora(PPG_CADMON)
  Result := Result + '   PPG_A_N_O_ VARCHAR(9),    ';
  Result := Result + '   PPG_TIPO__ VARCHAR(15),   ';
  Result := Result + '   PPG_MD5KEY VARCHAR(32),   ';
  Result := Result + '   PPG_CODITE VARCHAR('+IntToStr(fTamCodIte)+'),';

  Result := Result + '   PPG_CODDIL VARCHAR(20),   ';
  Result := Result + '   PPG_PORDIL DECIMAL(12,4), ';

  //Campos referentes a preços concentrados de cada embalagem
  Result := Result + '   PPG_PRECLT DECIMAL(12,4), ';
  Result := Result + '   PPG_PRECGL DECIMAL(12,4), ';
  Result := Result + '   PPG_PRECBD DECIMAL(12,4), ';
  Result := Result + '   PPG_PRECTB DECIMAL(12,4), ';

  //Campos referentes a preços diluidos de cada embalagem
  Result := Result + '   PPG_PREDLT DECIMAL(12,4), ';
  Result := Result + '   PPG_PREDGL DECIMAL(12,4), ';
  Result := Result + '   PPG_PREDBD DECIMAL(12,4), ';
  Result := Result + '   PPG_PREDTB DECIMAL(12,4), ';

  Result := Result + '   PPG_PCUCLT DECIMAL(12,4), ';
  Result := Result + '   PPG_PCUCGL DECIMAL(12,4), ';
  Result := Result + '   PPG_PCUCBD DECIMAL(12,4), ';
  Result := Result + '   PPG_PCUCTB DECIMAL(12,4), ';

  Result := Result + '   PPG_PCUDLT DECIMAL(12,4), ';
  Result := Result + '   PPG_PCUDGL DECIMAL(12,4), ';
  Result := Result + '   PPG_PCUDBD DECIMAL(12,4), ';
  Result := Result + '   PPG_PCUDTB DECIMAL(12,4), ';

  Result := Result + '   PPG_PRCLT1 DECIMAL(12,4), ';
  Result := Result + '   PPG_PRCLT2 DECIMAL(12,4), ';
  Result := Result + '   PPG_PRCLT3 DECIMAL(12,4), ';
  Result := Result + '   PPG_PRCLT4 DECIMAL(12,4), ';
  Result := Result + '   PPG_PRCLT5 DECIMAL(12,4), ';
  Result := Result + '   PPG_PRCLT6 DECIMAL(12,4), ';
  Result := Result + '   PPG_PRCLT7 DECIMAL(12,4), ';

  Result := Result + '   PPG_PRDLT1 DECIMAL(12,4), ';
  Result := Result + '   PPG_PRDLT2 DECIMAL(12,4), ';
  Result := Result + '   PPG_PRDLT3 DECIMAL(12,4), ';
  Result := Result + '   PPG_PRDLT4 DECIMAL(12,4), ';
  Result := Result + '   PPG_PRDLT5 DECIMAL(12,4), ';
  Result := Result + '   PPG_PRDLT6 DECIMAL(12,4), ';
  Result := Result + '   PPG_PRDLT7 DECIMAL(12,4), ';

  Result := Result + '   PPG_PRCGL1 DECIMAL(12,4), ';
  Result := Result + '   PPG_PRCGL2 DECIMAL(12,4), ';
  Result := Result + '   PPG_PRCGL3 DECIMAL(12,4), ';
  Result := Result + '   PPG_PRCGL4 DECIMAL(12,4), ';
  Result := Result + '   PPG_PRCGL5 DECIMAL(12,4), ';
  Result := Result + '   PPG_PRCGL6 DECIMAL(12,4), ';
  Result := Result + '   PPG_PRCGL7 DECIMAL(12,4), ';

  Result := Result + '   PPG_PRDGL1 DECIMAL(12,4), ';
  Result := Result + '   PPG_PRDGL2 DECIMAL(12,4), ';
  Result := Result + '   PPG_PRDGL3 DECIMAL(12,4), ';
  Result := Result + '   PPG_PRDGL4 DECIMAL(12,4), ';
  Result := Result + '   PPG_PRDGL5 DECIMAL(12,4), ';
  Result := Result + '   PPG_PRDGL6 DECIMAL(12,4), ';
  Result := Result + '   PPG_PRDGL7 DECIMAL(12,4), ';

  Result := Result + '   PPG_PRCBD1 DECIMAL(12,4), ';
  Result := Result + '   PPG_PRCBD2 DECIMAL(12,4), ';
  Result := Result + '   PPG_PRCBD3 DECIMAL(12,4), ';
  Result := Result + '   PPG_PRCBD4 DECIMAL(12,4), ';
  Result := Result + '   PPG_PRCBD5 DECIMAL(12,4), ';
  Result := Result + '   PPG_PRCBD6 DECIMAL(12,4), ';
  Result := Result + '   PPG_PRCBD7 DECIMAL(12,4), ';

  Result := Result + '   PPG_PRDBD1 DECIMAL(12,4), ';
  Result := Result + '   PPG_PRDBD2 DECIMAL(12,4), ';
  Result := Result + '   PPG_PRDBD3 DECIMAL(12,4), ';
  Result := Result + '   PPG_PRDBD4 DECIMAL(12,4), ';
  Result := Result + '   PPG_PRDBD5 DECIMAL(12,4), ';
  Result := Result + '   PPG_PRDBD6 DECIMAL(12,4), ';
  Result := Result + '   PPG_PRDBD7 DECIMAL(12,4), ';

  Result := Result + '   PPG_PRCTB1 DECIMAL(12,4), ';
  Result := Result + '   PPG_PRCTB2 DECIMAL(12,4), ';
  Result := Result + '   PPG_PRCTB3 DECIMAL(12,4), ';
  Result := Result + '   PPG_PRCTB4 DECIMAL(12,4), ';
  Result := Result + '   PPG_PRCTB5 DECIMAL(12,4), ';
  Result := Result + '   PPG_PRCTB6 DECIMAL(12,4), ';
  Result := Result + '   PPG_PRCTB7 DECIMAL(12,4), ';

  Result := Result + '   PPG_PRDTB1 DECIMAL(12,4), ';
  Result := Result + '   PPG_PRDTB2 DECIMAL(12,4), ';
  Result := Result + '   PPG_PRDTB3 DECIMAL(12,4), ';
  Result := Result + '   PPG_PRDTB4 DECIMAL(12,4), ';
  Result := Result + '   PPG_PRDTB5 DECIMAL(12,4), ';
  Result := Result + '   PPG_PRDTB6 DECIMAL(12,4), ';
  Result := Result + '   PPG_PRDTB7 DECIMAL(12,4), ';

  //Campos referentes aos produtos de cada embalagem
  Result := Result + '   PPG_EMBALT VARCHAR('+IntToStr(fTamCodIte)+'), ';
  Result := Result + '   PPG_EMBAGL VARCHAR('+IntToStr(fTamCodIte)+'), ';
  Result := Result + '   PPG_EMBABD VARCHAR('+IntToStr(fTamCodIte)+'), ';
  Result := Result + '   PPG_EMBATB VARCHAR('+IntToStr(fTamCodIte)+'), ';

  //Campos referentes aos volumes de cada embalagem
  Result := Result + '   PPG_VOLULT DECIMAL(12,4), ';
  Result := Result + '   PPG_VOLUGL DECIMAL(12,4), ';
  Result := Result + '   PPG_VOLUBD DECIMAL(12,4), ';
  Result := Result + '   PPG_VOLUTB DECIMAL(12,4), ';

  //Campos referentes aos preços de cada embalagem
  Result := Result + '   PPG_PREELT DECIMAL(12,4), ';
  Result := Result + '   PPG_PREEGL DECIMAL(12,4), ';
  Result := Result + '   PPG_PREEBD DECIMAL(12,4), ';
  Result := Result + '   PPG_PREETB DECIMAL(12,4), ';

  //Campos referentes aos tipos de cada embalagem
  Result := Result + '   PPG_TIPOLT CHAR(2), ';
  Result := Result + '   PPG_TIPOGL CHAR(2), ';
  Result := Result + '   PPG_TIPOBD CHAR(2), ';
  Result := Result + '   PPG_TIPOTB CHAR(2)); ';
end;

function TExportaTintometricosTerceirosPPG.fCarregarBasesEmpresa: String;
begin
  Result := '';
  Result := Result + '  SELECT                ';
  Result := Result + '    BAS_CODBAS,         ';
  Result := Result + '    BAS_CODITE,         ';
  Result := Result + '    BAS_CODEMP,         ';
  Result := Result + '    BAS_EMBALA,         ';
  Result := Result + '    BAS_PESESP,         ';
  Result := Result + '    ITE_PREVE' + fRetornaTabelaPreco + '  AS ITE_PREVEN,       ';
  Result := Result + '    G.ITE_PRECUS AS PRECUS,       ';
  Result := Result + '    G.ITE_PREVE1 AS PREVE1,       ';
  Result := Result + '    G.ITE_PREVE2 AS PREVE2,       ';
  Result := Result + '    G.ITE_PREVE3 AS PREVE3,       ';
  Result := Result + '    G.ITE_PREVE4 AS PREVE4,       ';
  Result := Result + '    G.ITE_PREVE5 AS PREVE5,       ';
  Result := Result + '    G.ITE_PREVE6 AS PREVE6,       ';
  Result := Result + '    G.ITE_PREVE7 AS PREVE7        ';
  Result := Result + '  FROM                  ';
  Result := Result + '    PPG_BASEMP B        ';
  Result := Result + '  INNER JOIN ITEGER G ON          ';
  Result := Result + '    B.BAS_CODITE = G.ITE_CODITE             ';
  Result := Result + '  INNER JOIN CADITE I ON          ';
  Result := Result + '    I.ITE_CODITE = G.ITE_CODITE             ';
  Result := Result + '  WHERE                 ';
  Result := Result + '    G.ITE_CODEMP = "' + VS_strCodEmp + '"       ';
end;

function TExportaTintometricosTerceirosPPG.fFatorTinta: Double;
begin
  Result := 0;
end;

{$IFDEF LINUX}
function TExportaTintometricosTerceirosPPG.fGetCountRegister(
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

function TExportaTintometricosTerceirosPPG.fGetPorLinha: Integer;
Var
  qryGen: TUniQuery;
begin
  Try  
    SetLength(arrTipoPpg, 0);

    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('SELECT DISTINCT PPG_SISTEM FROM PPG_CADPPG  ');
    qryGen.Open;

    If qryGen.IsEmpty Then
      Exit(1);

    qryGen.First;

    While Not qryGen.Eof Do
    Begin
      SetLength(arrTipoPpg, Length(arrTipoPpg) + 1);
      arrTipoPpg[Length(arrTipoPpg) - 1].Tipo := qryGen.FieldByName('PPG_SISTEM').AsString;
      qryGen.Next;
    End;

    Result := Length(arrTipoPpg);    
  Finally
    If Assigned(qryGen) Then
      FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosPPG.fGetTipoFormula(qryGen,
  qryBases: TUniQuery): Integer;
Var
  intContador: Integer;
begin
  Result := 0;

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    If fEmptyStr(qryGen.FieldByName('PPG_CODB' + fStrZero(intContador, 2)).AsString) Then
      Break;

    If Not qryBases.Locate('BAS_CODBAS', qryGen.FieldByName('PPG_CODB' + fStrZero(intContador, 2)).AsString, []) Then
    Begin
      Result := 3;
      Break;
    End;
  End;
end;

function TExportaTintometricosTerceirosPPG.fNomeTabela: String;
begin
  Result := 'PPG_CADPPG_SIT';
end;

function TExportaTintometricosTerceirosPPG.fQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TExportaTintometricosTerceirosPPG.fRetDescricao: String;
begin
  Result := 'PPG_DESCOR';
end;

function TExportaTintometricosTerceirosPPG.fRetEmbalagem(
  qryColorantes: TUniQuery): Double;
begin
  Result := (qryColorantes.FieldByName('BAS_EMBALA').AsFloat *
    qryColorantes.FieldByName('BAS_PESESP').AsFloat);
end;

function TExportaTintometricosTerceirosPPG.fRetEmbalagemBD(
  strTipCor: String): String;
begin
  Result := '';

  If Pos('DELTRON', strTipCor) > 0 Then
    Result := 'PPGLADT'
  Else If Pos('DELFLEET', strTipCor) > 0 Then
    Result := 'PPGLADF'
  Else If Pos('DULON', strTipCor) > 0 Then
    Result := 'PPGLADU'
  Else If Pos('OMNI', strTipCor) > 0 Then
    Result := 'PPGLAOM';

  //AQUI CONFIGURACOES (PM)
  If blnNovFor Then
  Begin
    Result := '';
    //Forma nova de carregar com troca de embalagem
    If Pos('2K', strTipCor) > 0 Then
      Result := 'PPGPMLA2K'
    Else If Pos('ACS', strTipCor) > 0 Then
      Result := 'PPGPMLAAC'
    Else If Pos('DELFLEET', strTipCor) > 0 Then
      Result := 'PPGPMLADF'
    Else If Pos('DELTRON', strTipCor) > 0 Then
      Result := 'PPGPMLADT'
    Else If Pos('DULON', strTipCor) > 0 Then
      Result := 'PPGPMLADU'
    Else If Pos('ENVIROBASE', strTipCor) > 0 Then
      Result := 'PPGPMLAEB'
    Else If Pos('INDUSTRAN', strTipCor) > 0 Then
      Result := 'PPGPMLAIN'
    Else If Pos('SPECTRAL GREY', strTipCor) > 0 Then
      Result := 'PPGPMLASG'
    Else If Pos('ZYNAMIX', strTipCor) > 0 Then
      Result := 'PPGPMLAZY';
  End;
end;

function TExportaTintometricosTerceirosPPG.fRetEmbalagemGL(
  strTipCor: String): String;
begin
  Result := '';

  If Pos('DELTRON', strTipCor) > 0 Then
    Result := 'PPGGDT'
  Else If Pos('DELFLEET', strTipCor) > 0 Then
    Result := 'PPGGDF'
  Else If Pos('DULON', strTipCor) > 0 Then
    Result := 'PPGGDU'
  Else If Pos('OMNI', strTipCor) > 0 Then
    Result := 'PPGGOM'
  Else If Pos('ENVIROBASE', strTipCor) > 0 Then
    Result := 'PPGGDT';

  //AQUI CONFIGURACOES (PM)
  If blnNovFor Then
  Begin
    Result := '';
    //Forma nova com troca de embalagem
    If Pos('2K', strTipCor) > 0 Then
      Result := 'PPGPMG2K'
    Else If Pos('ACS', strTipCor) > 0 Then
      Result := 'PPGPMGAC'
    Else If Pos('DELFLEET', strTipCor) > 0 Then
      Result := 'PPGPMGDF'
    Else If Pos('DELTRON', strTipCor) > 0 Then
      Result := 'PPGPMGDT'
    Else If Pos('DULON', strTipCor) > 0 Then
      Result := 'PPGPMGDU'
    Else If Pos('ENVIROBASE', strTipCor) > 0 Then
      Result := 'PPGPMGEB'
    Else If Pos('INDUSTRAN', strTipCor) > 0 Then
      Result := 'PPGPMGIN'
    Else If Pos('SPECTRAL GREY', strTipCor) > 0 Then
      Result := 'PPGPMGSG'
    Else If Pos('ZYNAMIX', strTipCor) > 0 Then
      Result := 'PPGPMGZY';
  End;
end;

function TExportaTintometricosTerceirosPPG.fRetEmbalagemLT(
  strTipCor: String): String;
begin
  Result := '';

  If Pos('DELTRON', strTipCor) > 0 Then
    Result := 'PPGLDT'
  Else If Pos('DELFLEET', strTipCor) > 0 Then
    Result := 'PPGLDF'
  Else If Pos('DULON', strTipCor) > 0 Then
    Result := 'PPGLDU'
  Else If Pos('OMNI', strTipCor) > 0 Then
    Result := 'PPGLOM'
  Else If Pos('ENVIROBASE', strTipCor) > 0 Then
    Result := 'PPGLDT';

  If blnNovFor Then
  Begin
    Result := '';
    //forma nova com troca de embalagem
    If Pos('2K', strTipCor) > 0 Then
      Result := 'PPGPML2K'
    Else If Pos('ACS', strTipCor) > 0 Then
      Result := 'PPGPMLAC'
    Else If Pos('DELFLEET', strTipCor) > 0 Then
      Result := 'PPGPMLDF'
    Else If Pos('DELTRON', strTipCor) > 0 Then
      Result := 'PPGPMLDT'
    Else If Pos('DULON', strTipCor) > 0 Then
      Result := 'PPGPMLDU'
    Else If Pos('ENVIROBASE', strTipCor) > 0 Then
      Result := 'PPGPMLEB'
    Else If Pos('INDUSTRAN', strTipCor) > 0 Then
      Result := 'PPGPMLIN'
    Else If Pos('SPECTRAL GREY', strTipCor) > 0 Then
      Result := 'PPGPMLSG'
    Else If Pos('ZYNAMIX', strTipCor) > 0 Then
      Result := 'PPGPMLZY';
  End;
end;

function TExportaTintometricosTerceirosPPG.fRetEmbalagemTB(
  strTipCor: String): String;
begin
  Result := '';

  If Pos('DELTRON', strTipCor) > 0 Then
    Result := 'PPGTDT'
  Else If Pos('DELFLEET', strTipCor) > 0 Then
    Result := 'PPGTDF'
  Else If Pos('DULON', strTipCor) > 0 Then
    Result := 'PPGTDU'
  Else If Pos('OMNI', strTipCor) > 0 Then
    Result := 'PPGTOM';

  //AQUI CONFIGURACOES (PM)
  If blnNovFor Then
  Begin
    Result := '';
    //Forma nova de carregar sem trocar embalagens
    If Pos('2K', strTipCor) > 0 Then
      Result := 'PPGPMT2K'
    Else If Pos('ACS', strTipCor) > 0 Then
      Result := 'PPGPMTAC'
    Else If Pos('DELFLEET', strTipCor) > 0 Then
      Result := 'PPGPMTDF'
    Else If Pos('DELTRON', strTipCor) > 0 Then
      Result := 'PPGPMTDT'
    Else If Pos('DULON', strTipCor) > 0 Then
      Result := 'PPGPMTDU'
    Else If Pos('ENVIROBASE', strTipCor) > 0 Then
      Result := 'PPGPMTEB'
    Else If Pos('INDUSTRAN', strTipCor) > 0 Then
      Result := 'PPGPMTIN'
    Else If Pos('SPECTRAL GREY', strTipCor) > 0 Then
      Result := 'PPGPMTSG'
    Else If Pos('ZYNAMIX', strTipCor) > 0 Then
      Result := 'PPGPMTZY';
  End;
end;

function TExportaTintometricosTerceirosPPG.fRetFormula(
  intCont: Integer): String;
begin
  Result := 'PPG_CODB' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosPPG.fRetItemBase: String;
begin
  Result := '';
end;

function TExportaTintometricosTerceirosPPG.fRetMD5KEY: String;
begin
  Result := 'PPG_MD5KEY';
end;

function TExportaTintometricosTerceirosPPG.fRetornaBases: String;
begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   BAS_CODITE, ';
  Result := Result + '   BAS_CODBAS, ';
  Result := Result + '   BAS_EMBALA, ';
  Result := Result + '   BAS_PESESP, ';
  Result := Result + '   ITE_PREVE' + fRetornaTabelaPreco + ' AS ITE_PREVEN,  ';
  Result := Result + '   G.ITE_PRECUS AS PRECUS,      ';
  Result := Result + '   G.ITE_PREVE1 AS PREVE1,      ';
  Result := Result + '   G.ITE_PREVE2 AS PREVE2,      ';
  Result := Result + '   G.ITE_PREVE3 AS PREVE3,      ';
  Result := Result + '   G.ITE_PREVE4 AS PREVE4,      ';
  Result := Result + '   G.ITE_PREVE5 AS PREVE5,      ';
  Result := Result + '   G.ITE_PREVE6 AS PREVE6,      ';
  Result := Result + '   G.ITE_PREVE7 AS PREVE7       ';
  Result := Result + '  FROM                                 ';
  Result := Result + '    PPG_CADBAS B                       ';
  Result := Result + '    INNER JOIN CADITE I                ';
  Result := Result + '      ON B.BAS_CODITE = I.ITE_CODITE   ';
  Result := Result + '    INNER JOIN ITEGER G                ';
  Result := Result + '      ON I.ITE_CODITE = G.ITE_CODITE   ';
  Result := Result + '  WHERE G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);
end;

function TExportaTintometricosTerceirosPPG.fRetornaCampoEmbalagem(
  strSigEmb: String; dicRetorno: TDicionario): String;
begin
  Result := '';

  If strSigEmb = 'LT' Then
    Result := fRetEmbalagemLT(dicRetorno['tipcor']);

  If strSigEmb = 'GL' Then
    Result := fRetEmbalagemGL(dicRetorno['tipcor']);

  If strSigEmb = 'BD' Then
    Result := fRetEmbalagemBD(dicRetorno['tipcor']);

  If strSigEmb = 'TB' Then
    Result := fRetEmbalagemTB(dicRetorno['tipcor']);
end;

function TExportaTintometricosTerceirosPPG.fRetornaCodigoDiluente(
  dicRetorno: TDicionario): String;
begin
  Result := IfNull(dicRetorno['coddil'], '');
end;

function TExportaTintometricosTerceirosPPG.fRetornaColorantes: String;
begin
  Result := '';
end;

function TExportaTintometricosTerceirosPPG.fRetornaPercentualAcrescimo(
  Conexao: TUniConnection): Double;
var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery(Nil, Conexao);
    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT CFG_VALCFG ');
      SQL.Add('   FROM CFGTIN ');
      SQL.Add('  WHERE CFG_IDEPRO = "PPG" ');
      SQL.Add('    AND CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
      SQL.Add('    AND CFG_CODCFG = "APREVE" ');
      Open;

      If fEmptyStr(FieldByName('CFG_VALCFG').AsString) Then
        Result := 0
      Else
        Result := fStrToFloat(FieldByName('CFG_VALCFG').AsString) / 100.0;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosPPG.fRetornaPorcentagemDiluente(
  dicRetorno: TDicionario): Double;
begin
  Result := IfNull(dicRetorno['pordil'], 0);
end;

function TExportaTintometricosTerceirosPPG.fRetornaProdutoParaVenda(
  Conexao: TUniConnection): String;
var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery(Nil, Conexao);
    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT CFG_VALCFG ');
      SQL.Add('   FROM CFGTIN     ');
      SQL.Add('  WHERE CFG_IDEPRO = "PPG" ');
      SQL.Add('    AND CFG_GRUCFG = "CONFIGURACOES" ');
      SQL.Add('    AND CFG_CODCFG = "PROPPG" ');
      SQL.Add('    AND CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
      Open;

      Result := qryGen.FieldByName('CFG_VALCFG').AsString;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosPPG.fRetornaTipoFormulacao(
  Conexao: TUniConnection): Boolean;
var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery(Nil, Conexao);
    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT CFG_VALCFG ');
      SQL.Add('   FROM CFGTIN     ');
      SQL.Add('  WHERE CFG_IDEPRO = "PPG" ');
      SQL.Add('    AND CFG_GRUCFG = "CONFIGURACOES" ');
      SQL.Add('    AND CFG_CODCFG = "NOVFOR" ');
      SQL.Add('    AND CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
      Open;

      Result := qryGen.FieldByName('CFG_VALCFG').AsString = 'S';
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosPPG.fRetQuantidade(
  intCont: Integer): String;
begin
  Result := 'PPG_QTDB' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosPPG.fRetTipoCor: String;
begin
  Result := 'PPG_TIPO__';
end;

function TExportaTintometricosTerceirosPPG.fRetValorAcrMobCfgTin: String;
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' SELECT CFG_VALCFG               ');
    qryGen.SQL.Add('    FROM CFGTIN                  ');
    qryGen.SQL.Add(' WHERE CFG_IDEPRO = "PPG" AND    ');
    qryGen.SQL.Add('       CFG_CODCFG = "ACRMOB" AND ');
    qryGen.SQL.Add('       CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
    qryGen.Open;

    Result := qryGen.FieldByName('CFG_VALCFG').AsString;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosPPG.fSQLInsert: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + ' INSERT INTO ' + fNomeTabela;
  Result := Result + ' (              ';
  Result := Result + '   PPG_DESCOR , ';
  Result := Result + '   PPG_CODCOR , ';
  Result := Result + '   PPG_CODATC , ';
  Result := Result + '   PPG_VARIAN , ';
  Result := Result + '   PPG_REFERE , ';
  Result := Result + '   PPG_MARCA_ , ';
  Result := Result + '   PPG_UTILIZ , ';
  Result := Result + '   PPG_SISTEM , ';
  Result := Result + '   PPG_EFEFIN , ';
  Result := Result + '   PPG_ORIGEM , ';
  Result := Result + '   PPG_PAISES , ';
  Result := Result + '   PPG_VEICUL , ';
  Result := Result + '   PPG_MONTAD , '; //descrição da montadora(PPG_CADMON)
  Result := Result + '   PPG_A_N_O_ , ';
  Result := Result + '   PPG_TIPO__ , ';
  Result := Result + '   PPG_MD5KEY , ';
  Result := Result + '   PPG_CODITE , ';

  //Diluente PPG
  Result := Result + '   PPG_CODDIL , ';
  Result := Result + '   PPG_PORDIL , ';

  //Campos referentes a preços concentrados de cada embalagem
  Result := Result + '   PPG_PRECLT , ';
  Result := Result + '   PPG_PRECGL , ';
  Result := Result + '   PPG_PRECBD , ';
  Result := Result + '   PPG_PRECTB , ';

  //Campos referentes a preços diluidos de cada embalagem
  Result := Result + '   PPG_PREDLT , ';
  Result := Result + '   PPG_PREDGL , ';
  Result := Result + '   PPG_PREDBD , ';
  Result := Result + '   PPG_PREDTB , ';

  Result := Result + '   PPG_PCUCLT , ';
  Result := Result + '   PPG_PCUCGL , ';
  Result := Result + '   PPG_PCUCBD , ';
  Result := Result + '   PPG_PCUCTB , ';

  Result := Result + '   PPG_PCUDLT , ';
  Result := Result + '   PPG_PCUDGL , ';
  Result := Result + '   PPG_PCUDBD , ';
  Result := Result + '   PPG_PCUDTB , ';

  For intContador := 1 To 7 Do
  Begin
    Result := Result + '   PPG_PRCLT' + IntToStr(intContador) + ',    ';
    Result := Result + '   PPG_PRDLT' + IntToStr(intContador) + ',    ';
    Result := Result + '   PPG_PRCGL' + IntToStr(intContador) + ',    ';
    Result := Result + '   PPG_PRDGL' + IntToStr(intContador) + ',    ';
    Result := Result + '   PPG_PRCBD' + IntToStr(intContador) + ',    ';
    Result := Result + '   PPG_PRDBD' + IntToStr(intContador) + ',    ';
    Result := Result + '   PPG_PRCTB' + IntToStr(intContador) + ',    ';
    Result := Result + '   PPG_PRDTB' + IntToStr(intContador) + ',    ';
  End;

  //Campos referentes aos produtos de cada embalagem
  Result := Result + '   PPG_EMBALT , ';
  Result := Result + '   PPG_EMBAGL , ';
  Result := Result + '   PPG_EMBABD , ';
  Result := Result + '   PPG_EMBATB , ';

  //Campos referentes aos volumes de cada embalagem
  Result := Result + '   PPG_VOLULT , ';
  Result := Result + '   PPG_VOLUGL , ';
  Result := Result + '   PPG_VOLUBD , ';
  Result := Result + '   PPG_VOLUTB , ';

  //Campos referentes aos preços de cada embalagem
  Result := Result + '   PPG_PREELT , ';
  Result := Result + '   PPG_PREEGL , ';
  Result := Result + '   PPG_PREEBD , ';
  Result := Result + '   PPG_PREETB , ';

  //Campos referentes aos tipos de cada embalagem
  Result := Result + '   PPG_TIPOLT , ';
  Result := Result + '   PPG_TIPOGL , ';
  Result := Result + '   PPG_TIPOBD , ';
  Result := Result + '   PPG_TIPOTB   ';

  Result := Result + ' )              ';
  Result := Result + ' VALUES         ';
  Result := Result + ' (              ';

  Result := Result + '   :DESCOR , ';
  Result := Result + '   :CODCOR , ';
  Result := Result + '   :CODATC , ';
  Result := Result + '   :VARIAN , ';
  Result := Result + '   :REFERE , ';
  Result := Result + '   :MARCA_ , ';
  Result := Result + '   :UTILIZ , ';
  Result := Result + '   :SISTEM , ';
  Result := Result + '   :EFEFIN , ';
  Result := Result + '   :ORIGEM , ';
  Result := Result + '   :PAISES , ';
  Result := Result + '   :VEICUL , ';
  Result := Result + '   :MONTAD , '; //descrição da montadora(PPG_CADMON)
  Result := Result + '   :A_N_O_ , ';
  Result := Result + '   :TIPO__ , ';
  Result := Result + '   :MD5KEY , ';
  Result := Result + '   :CODITE , ';

  //Diluente PPG
  Result := Result + '   :CODDIL , ';
  Result := Result + '   :PORDIL , ';

  //Campos referentes a preços concentrados de cada embalagem
  Result := Result + '   :PRECLT , ';
  Result := Result + '   :PRECGL , ';
  Result := Result + '   :PRECBD , ';
  Result := Result + '   :PRECTB , ';

  //Campos referentes a preços diluidos de cada embalagem
  Result := Result + '   :PREDLT , ';
  Result := Result + '   :PREDGL , ';
  Result := Result + '   :PREDBD , ';
  Result := Result + '   :PREDTB , ';

  Result := Result + '   :PCUCLT , ';
  Result := Result + '   :PCUCGL , ';
  Result := Result + '   :PCUCBD , ';
  Result := Result + '   :PCUCTB , ';

  Result := Result + '   :PCUDLT , ';
  Result := Result + '   :PCUDGL , ';
  Result := Result + '   :PCUDBD , ';
  Result := Result + '   :PCUDTB , ';

  For intContador := 1 To 7 Do
  Begin
    Result := Result + '   :PRCLT' + IntToStr(intContador) + ',       ';
    Result := Result + '   :PRDLT' + IntToStr(intContador) + ',       ';
    Result := Result + '   :PRCGL' + IntToStr(intContador) + ',       ';
    Result := Result + '   :PRDGL' + IntToStr(intContador) + ',       ';
    Result := Result + '   :PRCBD' + IntToStr(intContador) + ',       ';
    Result := Result + '   :PRDBD' + IntToStr(intContador) + ',       ';
    Result := Result + '   :PRCTB' + IntToStr(intContador) + ',       ';
    Result := Result + '   :PRDTB' + IntToStr(intContador) + ',       ';
  End;

  //Campos referentes aos produtos de cada embalagem
  Result := Result + '   :EMBALT , ';
  Result := Result + '   :EMBAGL , ';
  Result := Result + '   :EMBABD , ';
  Result := Result + '   :EMBATB , ';

  //Campos referentes aos volumes de cada embalagem
  Result := Result + '   :VOLULT , ';
  Result := Result + '   :VOLUGL , ';
  Result := Result + '   :VOLUBD , ';
  Result := Result + '   :VOLUTB , ';

  //Campos referentes aos preços de cada embalagem
  Result := Result + '   :PREELT , ';
  Result := Result + '   :PREEGL , ';
  Result := Result + '   :PREEBD , ';
  Result := Result + '   :PREETB , ';

  //Campos referentes aos tipos de cada embalagem
  Result := Result + '   :TIPOLT , ';
  Result := Result + '   :TIPOGL , ';
  Result := Result + '   :TIPOBD , ';
  Result := Result + '   :TIPOTB   ';

  Result := Result + ' )           ';
end;

function TExportaTintometricosTerceirosPPG.fValorQuantidade(fltValor,
  fltAcrMob: Double): Double;
begin
  If fltValor <= 0 Then
    Result := 0
  Else
    Result := fltValor + fltAcrMob;
end;

procedure TExportaTintometricosTerceirosPPG.pAdicionaParamentros(
  var DataSet: TFDQuery; qryTinta: TUniQuery; fltPreVen: Double; intParam: Integer = 0);
Var
  intContador: Integer;
  intEmb: Integer;
begin
  With DataSet Do
  Begin
    ParamByName('DESCOR').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('PPG_DESCOR').AsString);
    ParamByName('CODCOR').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('PPG_CODCOR').AsString);
    ParamByName('CODATC').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('PPG_CODATC').AsString);
    ParamByName('VARIAN').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('PPG_VARIAN').AsString);
    ParamByName('REFERE').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('PPG_REFERE').AsString);
    ParamByName('MARCA_').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('PPG_MARCA_').AsString);
    ParamByName('UTILIZ').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('PPG_UTILIZ').AsString);
    ParamByName('SISTEM').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('PPG_SISTEM').AsString);
    ParamByName('EFEFIN').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('PPG_EFEFIN').AsString);
    ParamByName('ORIGEM').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('PPG_ORIGEM').AsString);
    ParamByName('PAISES').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('PPG_PAISES').AsString);
    ParamByName('VEICUL').AsStrings[intParam]:= fRemoveAcento(qryTinta.FieldByName('PPG_VEICUL').AsString);
    ParamByName('MONTAD').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('MON_DESCRI').AsString);
    ParamByName('A_N_O_').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('PPG_A_N_O_').AsString);
    ParamByName('TIPO__').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('PPG_TIPO__').AsString);
    ParamByName('MD5KEY').AsStrings[intParam] := qryTinta.FieldByName('PPG_MD5KEY').AsString;
    ParamByName('CODITE').AsStrings[intParam] := strProPpg; //Produto para venda PPG;
    ParamByName('PCUCLT').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONLT'], 0.0);
    ParamByName('PCUCGL').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONGL'], 0.0);
    ParamByName('PCUCBD').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONBD'], 0.0);
    ParamByName('PCUCTB').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONTB'], 0.0);
    ParamByName('PCUDLT').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILLT'], 0.0);
    ParamByName('PCUDGL').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILGL'], 0.0);
    ParamByName('PCUDBD').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILBD'], 0.0);
    ParamByName('PCUDTB').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILTB'], 0.0);

    For intEmb := 0 To Length(arrEmbalagens) - 1 Do
    Begin
      If strAcrMob = '1' Then
      Begin
        arrPrecosPorEmb[intEmb].fltValCon := arrPrecosPorEmb[intEmb].fltValCon * (1 + qryTinta.FieldByName('PPG_ACRMOB').AsFloat / 100);
        arrPrecosPorEmb[intEmb].fltValDil := arrPrecosPorEmb[intEmb].fltValDil * (1 + qryTinta.FieldByName('PPG_ACRMOB').AsFloat / 100);
      End
      Else
      Begin
        arrPrecosPorEmb[intEmb].fltValCon := fValorQuantidade(arrPrecosPorEmb[intEmb].fltValCon, qryTinta.FieldByName('PPG_ACRMOB').AsFloat);
        arrPrecosPorEmb[intEmb].fltValDil := fValorQuantidade(arrPrecosPorEmb[intEmb].fltValDil, qryTinta.FieldByName('PPG_ACRMOB').AsFloat);
      End;
    End;

    For intContador := 1 To 7 Do
    Begin
      If stlTabPre[intContador] <> 'S' Then
      Begin
        ParamByName('PRCLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLT'], 0.0);
        ParamByName('PRDLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLT'], 0.0);
        ParamByName('PRCGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONGL'], 0.0);
        ParamByName('PRDGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILGL'], 0.0);
        ParamByName('PRCBD' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONBD'], 0.0);
        ParamByName('PRDBD' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILBD'], 0.0);
        ParamByName('PRCTB' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONTB'], 0.0);
        ParamByName('PRDTB' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILTB'], 0.0);
      End
      Else
      Begin
        If strAcrMob = '1' Then
        Begin
          ParamByName('PRCLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLT'], 0.0) * (1 + qryTinta.FieldByName('PPG_ACRMOB').AsFloat / 100);
          ParamByName('PRDLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLT'], 0.0) * (1 + qryTinta.FieldByName('PPG_ACRMOB').AsFloat / 100);
          ParamByName('PRCGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONGL'], 0.0) * (1 + qryTinta.FieldByName('PPG_ACRMOB').AsFloat / 100);
          ParamByName('PRDGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILGL'], 0.0) * (1 + qryTinta.FieldByName('PPG_ACRMOB').AsFloat / 100);
          ParamByName('PRCBD' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONBD'], 0.0) * (1 + qryTinta.FieldByName('PPG_ACRMOB').AsFloat / 100);
          ParamByName('PRDBD' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILBD'], 0.0) * (1 + qryTinta.FieldByName('PPG_ACRMOB').AsFloat / 100);
          ParamByName('PRCTB' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONTB'], 0.0) * (1 + qryTinta.FieldByName('PPG_ACRMOB').AsFloat / 100);
          ParamByName('PRDTB' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILTB'], 0.0) * (1 + qryTinta.FieldByName('PPG_ACRMOB').AsFloat / 100);
        End
        Else
        Begin
          ParamByName('PRCLT' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLT'], 0.0), qryTinta.FieldByName('PPG_ACRMOB').AsFloat);
          ParamByName('PRDLT' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLT'], 0.0), qryTinta.FieldByName('PPG_ACRMOB').AsFloat);
          ParamByName('PRCGL' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONGL'], 0.0), qryTinta.FieldByName('PPG_ACRMOB').AsFloat);
          ParamByName('PRDGL' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILGL'], 0.0), qryTinta.FieldByName('PPG_ACRMOB').AsFloat);
          ParamByName('PRCBD' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONBD'], 0.0), qryTinta.FieldByName('PPG_ACRMOB').AsFloat);
          ParamByName('PRDBD' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILBD'], 0.0), qryTinta.FieldByName('PPG_ACRMOB').AsFloat);
          ParamByName('PRCTB' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONTB'], 0.0), qryTinta.FieldByName('PPG_ACRMOB').AsFloat);
          ParamByName('PRDTB' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILTB'], 0.0), qryTinta.FieldByName('PPG_ACRMOB').AsFloat);
        End;
      End;
    End;
  End;
end;

procedure TExportaTintometricosTerceirosPPG.pCriaClientDiluente(
  Conexao: TUniConnection);
var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery(Nil, Conexao);

    //Diluente

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT DISTINCT  ');
      SQL.Add('   *              ');
      SQL.Add('   FROM           ');
      SQL.Add('     PPG_CADBAS B ');
      SQL.Add('     INNER JOIN PPG_CADDIL D ');
      SQL.Add('       ON B.BAS_CODBAS = D.DIL_CODDIL');
      SQL.Add(' ORDER BY BAS_CODBAS         ');
      Open;
    End;

    cdsDiluentes := fCriaClientDatset(qryGen, False, Nil, False);
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TExportaTintometricosTerceirosPPG.pCriaClientEmbalagem(
  Conexao: TUniConnection);
var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery(Nil, Conexao);

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT * ');
      SQL.Add('   FROM CFGTIN     ');
      SQL.Add('  WHERE CFG_IDEPRO = "PPG" ');
      SQL.Add('    AND CFG_GRUCFG = "CONFIGURACOES" ');
      SQL.Add('    AND CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
      Open;
    End;

    cdsEmbalagens := fCriaClientDatset(qryGen, False, Nil, False);
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TExportaTintometricosTerceirosPPG.pGravaTintometricoPorTintaTerceiros(
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

procedure TExportaTintometricosTerceirosPPG.pIncluirLogTinSite(
  Conexao: TUniConnection; strStatus: String);
var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery(Nil, Conexao);

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' DELETE FROM LOGTIN_SIT    ');
      SQL.Add('  WHERE LOG_IDEPRO = "PPG" ');
      ExecSQL;
    End;

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' INSERT INTO LOGTIN_SIT (LOG_IDEPRO, LOG_DTAEXE, LOG_HOREXE, LOG_EXECUT) ');
      SQL.Add('                 VALUES ("PPG", :DTAEXE, :HOREXE, :EXECUT) ');
      ParamByName('DTAEXE').AsDateTime := VS_Date;
      ParamByName('HOREXE').AsDateTime := Time;
      ParamByName('EXECUT').AsString   := strStatus;
      ExecSQL;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TExportaTintometricosTerceirosPPG.pPreencheArrayEmbalagem;
Begin
  SetLength(arrEmbalagens, 1);

  //Litro
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Litro';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'LT';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := (1000 / 1000);
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  //Galão
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Galão';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'GL';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := (3600 / 1000);
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  //Balde
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Balde';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'BD';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := (18000 / 1000);
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  //Tambor
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Tambor';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'TB';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := (200000 / 1000);
end;

procedure TExportaTintometricosTerceirosPPG.pPreencheEmbalagens;
begin
  pPreencheArrayEmbalagem;
end;

procedure TExportaTintometricosTerceirosPPG.pProcessarBasesEmpresas;
begin
  qryBasEmp := fCriaQuery();
  qryBasEmp.Close;
  qryBasEmp.SQL.Clear;
  qryBasEmp.SQL.Add(fCarregarBasesEmpresa);
  qryBasEmp.Open;
end;

procedure TExportaTintometricosTerceirosPPG.pProcessaTabelaCores(
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

procedure TExportaTintometricosTerceirosPPG.pRecalculaFormula(
  dicRetorno: TDicionario; qryGen: TUniQuery; qryBases: TUniQuery);
var
  intCont: Integer;
  fltTotalVolumeAtual: Double;
  fltTotalVolumeDiluido: Double;
  fltTaxa: Double;
  fltPorDil: Double;
  strCodDil: String;

  fltPesoEsp,
  fltQuantidade: Double;
begin
  blnDiluido := False;
  //No caso da PPG a ideia é carregar os diluentes uma vez só em memoria
  //Para o processo nao ficar tão lento

  If Pos('PERSONALIZ', qryGen.FieldByName('PPG_SISTEM').AsString) > 0 Then
    dicRetorno['NVFORMULA'] := 'S'
  Else
    dicRetorno['NVFORMULA'] := 'N';

  cdsDiluentes.Filtered := False;
  cdsDiluentes.Filter   := 'BAS_TIPO__ = ' + QuotedStr(qryGen.FieldByName('PPG_TIPO__').AsString) +
    ' AND DIL_SISTEM = ' + QuotedStr(qryGen.FieldByName('PPG_SISTEM').AsString);
  cdsDiluentes.Filtered := True;

  If cdsDiluentes.IsEmpty Then
    Exit;

  strCodDil := cdsDiluentes.FieldByName('BAS_CODBAS').AsString;

  blnDiluido := True;

  fltTotalVolumeAtual := 0;

  For intCont := 1 To fQuantidadeFormulacao Do
  Begin
    If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intCont, 2)], ''))) Then
      Break;


    If qryBasEmp.Locate('BAS_CODBAS;BAS_CODEMP', VarArrayOf([dicRetorno['base' + fStrZero(intCont, 2)], VS_strCodEmp]), []) Then
      fltPesoEsp := qryBasEmp.FieldByName('BAS_PESESP').AsFloat
    Else If qryBases.Locate('BAS_CODBAS', dicRetorno['base' + fStrZero(intCont, 2)],[]) Then
      fltPesoEsp := qryBases.FieldByName('BAS_PESESP').AsFloat
    Else
      Break;

    fltQuantidade := qryGen.FieldByName(fRetQuantidade(intCont)).AsFloat;

    fltTotalVolumeAtual := fltTotalVolumeAtual +  (fltQuantidade / fltPesoEsp);
  End;

  fltPorDil := cdsDiluentes.FieldByName('DIL_MINIMO').AsFloat;

  fltTotalVolumeDiluido := fltTotalVolumeAtual + (fltPorDil * fltTotalVolumeAtual / 100);
  fltTaxa := (fltTotalVolumeAtual / fltTotalVolumeDiluido);

  //Adicionando o diluente na ultima posicao
  For intCont := 1 To fQuantidadeFormulacao Do
  Begin
    If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intCont, 2)], ''))) Then
    Begin
      dicRetorno['base' + fStrZero(intCont, 2)] := cdsDiluentes.FieldByName('BAS_CODBAS').AsString;
      dicRetorno['qtdb' + fStrZero(intCont, 2)] := 0;
      dicRetorno['qtdd' + fStrZero(intCont, 2)] := ((fltPorDil * fltTotalVolumeAtual / 100) * cdsDiluentes.FieldByName('BAS_PESESP').AsFloat);

      dicRetorno['coddil'] := cdsDiluentes.FieldByName('BAS_CODBAS').AsString;
      dicRetorno['pordil'] := cdsDiluentes.FieldByName('DIL_MINIMO').AsFloat;
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

procedure TExportaTintometricosTerceirosPPG.pRetPrecosAdicionais(
  dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery;
  fltPerAcr: Double);
var
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

        fltEmbala := fRetEmbalagem(qryBases);
        ArrComponentes[intContador].Componente := dicRetorno['base' + fStrZero(intContador, 2)];

        If dicRetorno['NVFORMULA'] = 'S' Then
        Begin
          ArrComponentes[intContador].Quantidade := dicRetorno['qtdb' + fStrZero(intContador, 2)];
          ArrComponentes[intContador].Quantiddil := IfNull(dicRetorno['qtdd' + fStrZero(intContador, 2)], 0);
        End
        Else
        Begin
          ArrComponentes[intContador].Quantidade := fArredondaPPG(fFormataFloat(dicRetorno['qtdb' + fStrZero(intContador, 2)], 1));
          ArrComponentes[intContador].Quantiddil := fArredondaPPG(fFormataFloat(IfNull(dicRetorno['qtdd' + fStrZero(intContador, 2)], 0), 1));
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

          If qryBasEmp.Locate('BAS_CODBAS;BAS_CODEMP', VarArrayOf([ArrComponentes[intContador].Componente, VS_strCodEmp]), []) Then
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
              IntToStr(intContador), strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
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
            IntToStr(intPreVen), strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
            fltPrecoEmbalagem := fltPreVenPro + (fltPerAcr * fltPreVenPro)
          Else
            fltPrecoEmbalagem := fSelecionaPrecoVendaEmbalagemTabClientes(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString, fltPerAcr, intPreVen);
        End;

        //Preco de venda concentrado
        fltPrecoVendaTotalCon := fltPrecoVendaTotalCon +
          (fltPerAcr * fltPrecoVendaTotalCon) + fltPrecoEmbalagem;

        //Preco de venda diluido
        If fltPrecoVendaTotalDil > 0 Then
          fltPrecoVendaTotalDil := fltPrecoVendaTotalDil +
            (fltPerAcr * fltPrecoVendaTotalDil) + fltPrecoEmbalagem;

        dicPrecoAdicional['PREVE' + IntToStr(intPreVen) + '_CON' + strEmb] := fltPrecoVendaTotalCon;
        dicPrecoAdicional['PREVE' + IntToStr(intPreVen) + '_DIL' + strEmb] := fltPrecoVendaTotalDil;
      End;

      //Calcula Preço de custo
      fltPrecoCustoTotalCon := 0;
      fltPrecoCustoTotalDil := 0;

      For intContador := 1 To Length(ArrComponentes) Do
      Begin
        If fEmptyStr(ArrComponentes[intContador].Componente) Then
          Break;
        If qryBasEmp.Locate('BAS_CODBAS;BAS_CODEMP', VarArrayOf([ArrComponentes[intContador].Componente, VS_strCodEmp]), []) Then
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

procedure TExportaTintometricosTerceirosPPG.pRetPrecoTintas(
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
          ArrComponentes[intContador].Quantidade := fArredondaPPG(fFormataFloat(dicRetorno['qtdb' + fStrZero(intContador, 2)], 1));
          ArrComponentes[intContador].Quantiddil := fArredondaPPG(fFormataFloat(IfNull(dicRetorno['qtdd' + fStrZero(intContador, 2)], 0), 1));
        End;
      End;

      For intContador := 1 To Length(ArrComponentes) Do
      Begin
        If fEmptyStr(ArrComponentes[intContador].Componente) Then
          Break;

        If qryBasEmp.Locate('BAS_CODBAS;BAS_CODEMP', VarArrayOf([ArrComponentes[intContador].Componente, VS_strCodEmp]), []) Then
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

procedure TExportaTintometricosTerceirosPPG.pRetTabelasVenda(
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

procedure TExportaTintometricosTerceirosPPG.pSetaParametrosEspecificos(
  Conexao: TUniConnection);
begin
  blnNovFor := fRetornaTipoFormulacao(Conexao);
  strProPpg := fRetornaProdutoParaVenda(Conexao);
  pCriaClientEmbalagem(Conexao);
  pCriaClientDiluente(Conexao);
  pRetTabelasVenda(Conexao);
end;

end.


