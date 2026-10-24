unit untExportaTintometricosTerceirosCoralImobiliaria;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  untFuncoesSimples, Windows, Messages,
  cxProgressBar, UniClientDataSet,
  FireDAC.VCLUI.Wait,
{$ENDIF}
  Uni, SysUtils, Variants, Classes,
  untThreadExportacaoTerceiros, DateUtils, Math,
  untExportaTintometricosTerceirosImobiliaria, DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.UI;

type
  TExportaTintometricosTerceirosCoralImobiliaria = class(TExportaTintometricosTerceirosImobiliaria)
  private
    strAcrMob: String;
    function fRetValorAcrMobCfgTin(): String;
    function fRetValorAcrMob(qryGen: TUniQuery; fltQuantidade: Double): Double;
  protected
    procedure pProcessaTabelaCores(qryInsert: TFDQuery; qryGen, qryBases, qryColorantes: TUniQuery;
      strTabUni, strTabPre: String; fltPerAcr: Double; dicRetorno: TDicionario); Override;
    Procedure pProcessarCadastroEmpresaExportacao(); Override;
  public
    function fNomeTabela: String; override;
    function fCamposTabela: String; override;
    function fCamposSelect: String; override;
    function fQuantidadeFormulacao: Integer; override;
    function fFatorTinta: Double; override;

    function fRetDescricao: String; override;
    function fRetItemBase: String; override;
    function fRetMD5KEY: String; override;
    function fRetCODEMP: String; Override;
    procedure pSetarEmpresaExportacao(); Override;
    function fRetFormula(intCont: Integer): String; override;
    function fRetQuantidade(intCont: Integer): String; override;

    function fSQLInsert: String; override;
    procedure pAdicionaParamentros(Var DataSet: TFDQuery; qryTinta: TUniQuery;
      fltPreVen: Double; intParam: Integer = 0); override;


    function fRetornaColorantes: String; override;
    function fGetTipoFormula(qryGen: TUniQuery; qryBases: TUniQuery): Integer; Override;
    function fRetornaBases: String; override;
    function fRetornaPercentualAcrescimo(Conexao: TUniConnection): Double; override;

    function fRetEmbalagem(qryColorantes: TUniQuery): Double; override;
    function fGetPorLinha(): Integer; Override; //Gerar Cadastro de empresas Exportação

    procedure pIncluirLogTinSite(Conexao: TUniConnection; strStatus: String); override;
    procedure pSetaParametrosEspecificos(Conexao: TUniConnection); Override;
    procedure pCarregarPrecosAdicionais(dicRetorno: TDicionario; qryColorantes: TUniQuery;
      qryBases: TUniQuery; fltPerAcr: Double); Override;

    procedure pGravaTintometricoTabelasTerceirosPorTinta(qryInsert: TFDQuery;
      fltPreVen: Double; qryTinta: TUniQuery; intParam: Integer = 0); Override;

    constructor Create(pgbProgresso: TcxProgressBar; strIdePro: String;
      blnAuto: Boolean = False); override;
    destructor Destroy; override;
    procedure Execute; override;
 End;

Type
  TComp = Record
    Componente: String;
    Quantidade: Double;
End;

implementation

function TExportaTintometricosTerceirosCoralImobiliaria.fNomeTabela: String;
begin
  Result := 'CORIMO_CADCOR_SIT';
end;

function TExportaTintometricosTerceirosCoralImobiliaria.fCamposTabela: String;
begin
  Result := '';
  Result := Result + ' CREATE TABLE ' + fNomeTabela;
  Result := Result + ' ( COR_DESCRI VARCHAR(100),  ';
  Result := Result + '   COR_CODEMP CHAR(3),       ';
  Result := Result + '   COR_CODIGO VARCHAR(25),   ';
  Result := Result + '   COR_UNIDAD CHAR(2),       ';
  Result := Result + '   COR_COLID2 VARCHAR(50),   ';
  Result := Result + '   COR_DESPRO VARCHAR(50),   ';
  Result := Result + '   COR_CODBAS VARCHAR(10),   ';
  Result := Result + '   COR_UNIVER VARCHAR(50),   ';
  Result := Result + '   COR_CODEMB VARCHAR(5),    ';
  Result := Result + '   COR_COLID1 VARCHAR(30),   ';
  Result := Result + '   COR_R_G_B_ VARCHAR(6),    ';
  Result := Result + '   COR_RED___ CHAR(3),       ';
  Result := Result + '   COR_GREEN_ CHAR(3),       ';
  Result := Result + '   COR_BLUE__ CHAR(3),       ';
  Result := Result + '   COR_TONALI VARCHAR(50),   ';
  Result := Result + '   COR_CODITE CHAR('+IntToStr(fTamCodIte)+'),'; //Tabela cadite
  Result := Result + '   COR_DESITE VARCHAR(70),   '; //Tabela cadite
  Result := Result + '   COR_REFERE VARCHAR(20),   '; //Tabela cadite
  Result := Result + '   COR_MD5KEY VARCHAR(32),   ';
  Result := Result + '   COR_PREVEN DECIMAL(12,4), ';
  Result := Result + '   COR_PRECUS DECIMAL(12,4), ';
  Result := Result + '   COR_PREVE1 DECIMAL(12,4), ';
  Result := Result + '   COR_PREVE2 DECIMAL(12,4), ';
  Result := Result + '   COR_PREVE3 DECIMAL(12,4), ';
  Result := Result + '   COR_PREVE4 DECIMAL(12,4), ';
  Result := Result + '   COR_PREVE5 DECIMAL(12,4), ';
  Result := Result + '   COR_PREVE6 DECIMAL(12,4), ';
  Result := Result + '   COR_PREVE7 DECIMAL(12,4)  ';
  Result := Result + '      );                     ';
end;

constructor TExportaTintometricosTerceirosCoralImobiliaria.Create(
  pgbProgresso: TcxProgressBar; strIdePro: String; blnAuto: Boolean);
begin
  inherited Create(pgbProgresso, strIdePro, blnAuto);
  pProcessarCadastroEmpresaExportacao;
  dicPrecoAdicional := TDicionario.Create();
  stlTabPre := TStringList.Create();
  strAcrMob := fRetValorAcrMobCfgTin();
end;

destructor TExportaTintometricosTerceirosCoralImobiliaria.Destroy;
begin
  inherited;

  If Assigned(dicPrecoAdicional) Then
    FreeAndNil(dicPrecoAdicional);

  If Assigned(stlTabPre) Then
    FreeAndNil(stlTabPre);

  if Assigned(slEmpExportacao) Then
    FreeAndNil(slEmpExportacao);
end;

procedure TExportaTintometricosTerceirosCoralImobiliaria.Execute;
begin
  inherited Execute;

end;

function TExportaTintometricosTerceirosCoralImobiliaria.fCamposSelect: String;
begin
  Result := '';
  Result := Result + ' SELECT  ';

  Result := Result + '     COR_DESCRI,  ';
  Result := Result + '     COR_CODIGO,  ';
  Result := Result + '     COR_UNIDAD,  ';
  Result := Result + '     COR_COLID2,  ';
  Result := Result + '     COR_DESPRO,  ';
  Result := Result + '     COR_CODBAS,  ';
  Result := Result + '     COR_UNIVER,  ';
  Result := Result + '     COR_CODEMB,  ';
  Result := Result + '     COR_COLID1,  ';
  Result := Result + '     ITE_CODITE,  ';
  Result := Result + '     ITE_DESITE,  ';
  Result := Result + '     ITE_REFERE,  ';
  Result := Result + '     COR_MD5KEY,  ';
  Result := Result + '     COR_ACRMOB,  ';
  Result := Result + '     COR_R_G_B_,  ';
  Result := Result + '     COR_RED___,  ';
  Result := Result + '     COR_GREEN_,  ';
  Result := Result + '     COR_BLUE__,  ';
  Result := Result + '     COR_TONALI,  ';
  Result := Result + '     COR_FORM01,  ';
  Result := Result + '     COR_FORM02,  ';
  Result := Result + '     COR_FORM03,  ';
  Result := Result + '     COR_FORM04,  ';
  Result := Result + '     COR_FORM05,  ';
  Result := Result + '     COR_FORM06,  ';
  Result := Result + '     COR_FORM07,  ';
  Result := Result + '     COR_FORM08,  ';
  Result := Result + '     COR_FORM09,  ';
  Result := Result + '     COR_FORM10,  ';
  Result := Result + '     COR_QTDC01,  ';
  Result := Result + '     COR_QTDC02,  ';
  Result := Result + '     COR_QTDC03,  ';
  Result := Result + '     COR_QTDC04,  ';
  Result := Result + '     COR_QTDC05,  ';
  Result := Result + '     COR_QTDC06,  ';
  Result := Result + '     COR_QTDC07,  ';
  Result := Result + '     COR_QTDC08,  ';
  Result := Result + '     COR_QTDC09,  ';
  Result := Result + '     COR_QTDC10   ';
  Result := Result + ' FROM CORIMO_CADCOR ';
  Result := Result + '   INNER JOIN CORIMO_CADBAS ON COR_CODBAS = BAS_BASE__ ';
  Result := Result + '                           AND COR_DESPRO = BAS_DESCRI ';
  Result := Result + '                           AND COR_CODUNI = BAS_UNIDAD ';
  Result := Result + '   INNER JOIN CADITE ON BAS_CODITE = ITE_CODITE ';
  Result := Result + '   AND ITE_ITEATI = "S"                         ';
  Result := Result + ' WHERE TRUE;      ';
end;

function TExportaTintometricosTerceirosCoralImobiliaria.fQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TExportaTintometricosTerceirosCoralImobiliaria.fFatorTinta: Double;
begin
  Result := 0.308;
end;

function TExportaTintometricosTerceirosCoralImobiliaria.fGetPorLinha: Integer;
Var
  blnGerarEmpresas: Boolean;
  qryCadEmp: TUniQuery;
begin
  blnGerarEmpresas := (fCfgSis('EXPEMP') = 'S');

  If Not blnGerarEmpresas Then
    Exit(1);

  Try
    qryCadEmp := fCriaQuery();
    qryCadEmp.Close;
    qryCadEmp.SQL.Clear;
    qryCadEmp.SQL.Add(' SELECT COUNT(*) AS QTD FROM CADEMP ');
    qryCadEmp.Open;

    Result := qryCadEmp.FieldByName('QTD').AsInteger;
  Finally
    If Assigned(qryCadEmp) Then
      FreeAndNil(qryCadEmp);
  End;
end;

function TExportaTintometricosTerceirosCoralImobiliaria.fGetTipoFormula(qryGen,
  qryBases: TUniQuery): Integer;
Var
  intContador: Integer;
begin
  Result := 0;

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    If fEmptyStr(qryGen.FieldByName('COR_FORM' + fStrZero(intContador, 2)).AsString) Then
      Break;

    If Not qryBases.Locate('COL_CODCOL', qryGen.FieldByName('COR_FORM' + fStrZero(intContador, 2)).AsString, []) Then
    Begin
      Result := 3;
      Break;
    End;
  End;
end;

function TExportaTintometricosTerceirosCoralImobiliaria.fRetCODEMP: String;
begin
  Result := 'COR_CODEMP';
end;

function TExportaTintometricosTerceirosCoralImobiliaria.fRetDescricao: String;
begin
  Result := 'COR_DESCRI';
end;

function TExportaTintometricosTerceirosCoralImobiliaria.fRetEmbalagem(
  qryColorantes: TUniQuery): Double;
begin
  Result := qryColorantes.FieldByName('COL_EMBALA').AsFloat;
end;

function TExportaTintometricosTerceirosCoralImobiliaria.fRetItemBase: String;
begin
  Result := 'ITE_CODITE';
end;

function TExportaTintometricosTerceirosCoralImobiliaria.fRetMD5KEY: String;
begin
  Result := 'COR_MD5KEY';
end;

function TExportaTintometricosTerceirosCoralImobiliaria.fRetFormula(intCont: Integer): String;
begin
  Result := 'COR_FORM' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosCoralImobiliaria.fRetQuantidade(intCont: Integer): String;
begin
  Result := 'COR_QTDC' + fStrZero(intCont, 2)
end;

function TExportaTintometricosTerceirosCoralImobiliaria.fRetValorAcrMob(
  qryGen: TUniQuery; fltQuantidade: Double): Double;
begin
  If fltQuantidade <= 0 Then
    Exit(0);

  If strAcrMob = '1' Then
    Result := (1 + qryGen.FieldByName('COR_ACRMOB').AsFloat / 100)
  Else
    Result := qryGen.FieldByName('COR_ACRMOB').AsFloat;
end;

function TExportaTintometricosTerceirosCoralImobiliaria.fRetValorAcrMobCfgTin: String;
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' SELECT CFG_VALCFG               ');
    qryGen.SQL.Add('    FROM CFGTIN                  ');
    qryGen.SQL.Add(' WHERE CFG_IDEPRO = "CIM" AND    ');
    qryGen.SQL.Add('       CFG_CODCFG = "ACRMOB" AND ');
    qryGen.SQL.Add('       CFG_CODEMP = ' + QuotedStr(VS_EmpExportacao));
    qryGen.Open;

    If qryGen.IsEmpty Then
      Exit('0');

    Result := qryGen.FieldByName('CFG_VALCFG').AsString
  Finally
    FreeAndNil(qryGen);
  End;
end;
function TExportaTintometricosTerceirosCoralImobiliaria.fSQLInsert: String;
begin
  Result := '';
  Result := Result + ' INSERT INTO ' + fNomeTabela;
  Result := Result + ' (                ';
  Result := Result + '     COR_DESCRI,  ';
  Result := Result + '     COR_CODEMP,  ';
  Result := Result + '     COR_CODIGO,  ';
  Result := Result + '     COR_UNIDAD,  ';
  Result := Result + '     COR_COLID2,  ';
  Result := Result + '     COR_DESPRO,  ';
  Result := Result + '     COR_CODBAS,  ';
  Result := Result + '     COR_UNIVER,  ';
  Result := Result + '     COR_CODEMB,  ';
  Result := Result + '     COR_COLID1,  ';
  Result := Result + '     COR_R_G_B_,  ';
  Result := Result + '     COR_RED___,  ';
  Result := Result + '     COR_GREEN_,  ';
  Result := Result + '     COR_BLUE__,  ';
  Result := Result + '     COR_TONALI,  ';
  Result := Result + '     COR_CODITE,  '; //Tabela cadite
  Result := Result + '     COR_DESITE,  '; //Tabela cadite
  Result := Result + '     COR_REFERE,  '; //Tabela cadite
  Result := Result + '     COR_MD5KEY,  ';
  Result := Result + '     COR_PREVEN,  ';
  Result := Result + '     COR_PRECUS,  ';
  Result := Result + '     COR_PREVE1,  ';
  Result := Result + '     COR_PREVE2,  ';
  Result := Result + '     COR_PREVE3,  ';
  Result := Result + '     COR_PREVE4,  ';
  Result := Result + '     COR_PREVE5,  ';
  Result := Result + '     COR_PREVE6,  ';
  Result := Result + '     COR_PREVE7   ';
  Result := Result + ' )                ';
  Result := Result + ' VALUES           ';
  Result := Result + ' (                ';
  Result := Result + '     :DESCRI,  ';
  Result := Result + '     :CODEMP,  ';
  Result := Result + '     :CODIGO,  ';
  Result := Result + '     :UNIDAD,  ';
  Result := Result + '     :COLID2,  ';
  Result := Result + '     :DESPRO,  ';
  Result := Result + '     :CODBAS,  ';
  Result := Result + '     :UNIVER,  ';
  Result := Result + '     :CODEMB,  ';
  Result := Result + '     :COLID1,  ';
  Result := Result + '     :R_G_B_,  ';
  Result := Result + '     :RED___,  ';
  Result := Result + '     :GREEN_,  ';
  Result := Result + '     :BLUE__,  ';
  Result := Result + '     :TONALI,  ';
  Result := Result + '     :CODITE,  '; //Tabela cadite
  Result := Result + '     :DESITE,  '; //Tabela cadite
  Result := Result + '     :REFERE,  '; //Tabela cadite
  Result := Result + '     :MD5KEY,  ';
  Result := Result + '     :PREVEN,  ';
  Result := Result + '     :PRECUS,  ';
  Result := Result + '     :PREVE1,  ';
  Result := Result + '     :PREVE2,  ';
  Result := Result + '     :PREVE3,  ';
  Result := Result + '     :PREVE4,  ';
  Result := Result + '     :PREVE5,  ';
  Result := Result + '     :PREVE6,  ';
  Result := Result + '     :PREVE7   ';
  Result := Result + ' )             ';
end;

procedure TExportaTintometricosTerceirosCoralImobiliaria.pAdicionaParamentros(Var DataSet: TFDQuery; qryTinta: TUniQuery;
  fltPreVen: Double; intParam: Integer = 0);
Var
  intContador: Integer;
begin
  With DataSet Do
  Begin
    ParamByName('DESCRI').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('COR_DESCRI').AsString);
    ParamByName('CODEMP').AsStrings[intParam] := VS_EmpExportacao;
    ParamByName('CODIGO').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('COR_CODIGO').AsString);
    ParamByName('UNIDAD').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('COR_UNIDAD').AsString);
    ParamByName('COLID2').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('COR_COLID2').AsString);
    ParamByName('DESPRO').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('COR_DESPRO').AsString);
    ParamByName('CODBAS').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('COR_CODBAS').AsString);
    ParamByName('UNIVER').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('COR_UNIVER').AsString);
    ParamByName('CODEMB').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('COR_CODEMB').AsString);
    ParamByName('COLID1').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('COR_COLID1').AsString);
    ParamByName('CODITE').AsStrings[intParam] := qryTinta.FieldByName('ITE_CODITE').AsString;
    ParamByName('DESITE').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('ITE_DESITE').AsString);
    ParamByName('REFERE').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('ITE_REFERE').AsString);
    ParamByName('MD5KEY').AsStrings[intParam] := qryTinta.FieldByName('COR_MD5KEY').AsString;
    ParamByName('R_G_B_').AsStrings[intParam] := qryTinta.FieldByName('COR_R_G_B_').AsString;
    ParamByName('RED___').AsStrings[intParam] := qryTinta.FieldByName('COR_RED___').AsString;
    ParamByName('GREEN_').AsStrings[intParam] := qryTinta.FieldByName('COR_GREEN_').AsString;
    ParamByName('BLUE__').AsStrings[intParam] := qryTinta.FieldByName('COR_BLUE__').AsString;
    ParamByName('TONALI').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('COR_TONALI').AsString);
    ParamByName('PRECUS').AsFloats[intParam]  := IfNull(dicPrecoAdicional['precus'], 0.0);

    If strAcrMob = '1' Then
      ParamByName('PREVEN').AsFloats[intParam]  := fltPreVen * (1 + qryTinta.FieldByName('COR_ACRMOB').AsFloat / 100)
    Else
      ParamByName('PREVEN').AsFloats[intParam]  := fltPreVen + qryTinta.FieldByName('COR_ACRMOB').AsFloat;

    ParamByName('PRECUS').AsFloats[intParam]  := IfNull(dicPrecoAdicional['precus'], 0);

    For intContador := 1 To 7 Do
    Begin
      If stlTabPre[intContador] <> 'S' Then
        ParamByName('PREVE' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['preve' + IntToStr(intContador)], 0)
      Else
      Begin
        If strAcrMob = '1' Then
          ParamByName('PREVE' + IntToStr(intContador)).AsFloats[intParam] :=  IfNull(dicPrecoAdicional['preve' + IntToStr(intContador)], 0) * (1 + qryTinta.FieldByName('COR_ACRMOB').AsFloat / 100)
        Else
          ParamByName('PREVE' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['preve' + IntToStr(intContador)], 0) + qryTinta.FieldByName('COR_ACRMOB').AsFloat;
      End;
    End;
  End;
end;

procedure TExportaTintometricosTerceirosCoralImobiliaria.pCarregarPrecosAdicionais(
  dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery;
  fltPerAcr: Double);
Var
  intPreVen: Integer;
  fltPreCusPro,
  fltPreVenPro: Double;
  strCodCli, strCodCnd: String;
  intPrzMed: Integer;
  fltQuantidade,
  fltPrecoVenda,
  fltPrecoVendaTotal,
  fltPrecoCusto,
  fltPrecoCustoTotal,
  fltPrecoColorante,
  fltPrecoEmbalagem: Double;
  fltPrecoCustoBase: Double;
  intContador: Integer;
  strTabelaUnica: String;
  ArrComponentes: array of TComp;
begin
  dicPrecoAdicional.Limpar;
  strTabelaUnica := dicRetorno['tabelaunica'];

  Try
    SetLength(ArrComponentes, fQuantidadeFormulacao);

    //Adiciona a formulacao no array
    For intContador := 1 To fQuantidadeFormulacao Do
    Begin
      If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intContador, 2)], ''))) Then
        Break;

      ArrComponentes[intContador].Componente := dicRetorno['base' + fStrZero(intContador, 2)];
      ArrComponentes[intContador].Quantidade := fFormataFloat(dicRetorno['qtdb' + fStrZero(intContador, 2)] / fFatorTinta, 3);
    End;

    For intPreVen := 1 To 7 Do
    Begin

      If stlTabPre[intPreVen] <> 'S' Then
        Continue;

      fltPrecoVendaTotal := 0;
      fltPrecoColorante  := 0;
      fltPrecoEmbalagem  := 0;
      fltPreCusPro       := 0;
      fltPreVenPro       := 0;
      strCodCli          := '';
      strCodCnd          := '';
      intPrzMed          := 0;

      //Calcula o preco de venda
      For intContador := 1 To Length(ArrComponentes) Do
      Begin
        If fEmptyStr(ArrComponentes[intContador].Componente) Then
          Break;

        If qryColorantes.Locate('COL_CODCOL', ArrComponentes[intContador].Componente,[]) Then
        Begin
          If fCarregaPromocao(qryColorantes.FieldByName('COL_CODITE').AsString, IntToStr(intPreVen),  strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
            fltPrecoColorante := fltPreVenPro
          Else
            fltPrecoColorante := qryColorantes.FieldByName('PREVE' + IntToStr(intPreVen)).AsFloat;
        End;

        fltQuantidade := ArrComponentes[intContador].Quantidade * fFatorTinta;
        fltPrecoVenda := fltQuantidade * (fltPrecoColorante / fRetEmbalagem(qryColorantes));

        fltPrecoVendaTotal := fltPrecoVendaTotal + fltPrecoVenda;
      End;

      If qryBases.Locate('ITE_CODITE', dicRetorno['itebas'],[]) Then
      Begin
        If fCarregaPromocao(dicRetorno['itebas'], IntToStr(intPreVen), strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
          fltPrecoEmbalagem := fltPreVenPro + (fltPerAcr * fltPreVenPro)
        Else
          fltPrecoEmbalagem := qryBases.FieldByName('PREVE' + IntToStr(intPreVen)).AsFloat + (fltPerAcr * qryBases.FieldByName('PREVE' + IntToStr(intPreVen)).AsFloat);
      End;

      fltPrecoVendaTotal := fltPrecoVendaTotal + (fltPerAcr * fltPrecoVendaTotal) + fltPrecoEmbalagem;

      dicPrecoAdicional['preve' + IntToStr(intPreVen)] := fltPrecoVendaTotal;
    End;

    fltPrecoCustoTotal := 0;
    fltPrecoColorante  := 0;
    fltPrecoCustoBase  := 0;
    fltPreCusPro       := 0;
    fltPreVenPro       := 0;
    strCodCli          := '';
    strCodCnd          := '';
    intPrzMed          := 0;

    //Calculando o Preço de Custo
    For intContador := 1 To Length(ArrComponentes) Do
    Begin
      If fEmptyStr(ArrComponentes[intContador].Componente) Then
        Break;

      If qryColorantes.Locate('COL_CODCOL', ArrComponentes[intContador].Componente,[]) Then
      Begin
        If fCarregaPromocao(qryColorantes.FieldByName('COL_CODITE').AsString, strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
        Begin
          fltPrecoColorante := fltPreCusPro;

          If fltPrecoColorante = 0 Then
            fltPrecoColorante := qryColorantes.FieldByName('PRECUS').AsFloat;
        End
        Else
          fltPrecoColorante := qryColorantes.FieldByName('PRECUS').AsFloat;
      End;

      fltQuantidade := ArrComponentes[intContador].Quantidade * fFatorTinta;
      fltPrecoCusto := fltQuantidade * (fltPrecoColorante / fRetEmbalagem(qryColorantes));

      fltPrecoCustoTotal := fltPrecoCustoTotal + fltPrecoCusto;
    End;

    If qryBases.Locate('ITE_CODITE', dicRetorno['itebas'],[]) Then
    Begin
      If fCarregaPromocao(dicRetorno['itebas'], '1', strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
      Begin
        fltPrecoCustoBase := fltPreCusPro + (fltPerAcr * fltPreCusPro);

        If fltPrecoCustoBase = 0 Then
          fltPrecoCustoBase := qryBases.FieldByName('PRECUS').AsFloat + (fltPerAcr * qryBases.FieldByName('PRECUS').AsFloat);
      End
      Else
        fltPrecoCustoBase := qryBases.FieldByName('PRECUS').AsFloat + (fltPerAcr * qryBases.FieldByName('PRECUS').AsFloat);
    End;

    dicPrecoAdicional['precus'] := fltPrecoCustoTotal + fltPrecoCustoBase;
  Finally
    SetLength(arrComponentes, 0);
  End;
end;

procedure TExportaTintometricosTerceirosCoralImobiliaria.pGravaTintometricoTabelasTerceirosPorTinta(
  qryInsert: TFDQuery; fltPreVen: Double; qryTinta: TUniQuery;
  intParam: Integer);
begin
  pAdicionaParamentros(qryInsert, qryTinta, fltPreVen, intParam);
end;

procedure TExportaTintometricosTerceirosCoralImobiliaria.pIncluirLogTinSite(
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
      SQL.Add('  WHERE LOG_IDEPRO = "CIM" ');
      ExecSQL;
    End;

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' INSERT INTO LOGTIN_SIT (LOG_IDEPRO, LOG_DTAEXE, LOG_HOREXE, LOG_EXECUT) ');
      SQL.Add('                 VALUES ("CIM", :DTAEXE, :HOREXE, :EXECUT) ');
      ParamByName('DTAEXE').AsDateTime := VS_Date;
      ParamByName('HOREXE').AsDateTime := Time;
      ParamByName('EXECUT').AsString   := strStatus;
      ExecSQL;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TExportaTintometricosTerceirosCoralImobiliaria.pProcessarCadastroEmpresaExportacao;
Var
  blnGerarEmpresas: Boolean;
  qryCadEmp: TUniQuery;
begin
  blnGerarEmpresas := (fCfgSis('EXPEMP') = 'S');

  If Not blnGerarEmpresas Then
    Exit;

  Try
    slEmpExportacao := TStringList.Create();
    qryCadEmp := fCriaQuery();
    qryCadEmp.Close;
    qryCadEmp.SQL.Clear;
    qryCadEmp.SQL.Add(' SELECT EMP_CODEMP AS EMPRESA FROM CADEMP ');
    qryCadEmp.Open;

    While Not qryCadEmp.Eof Do
    Begin
      slEmpExportacao.Add(qryCadEmp.FieldByName('EMPRESA').AsString);
      qryCadEmp.Next;
    End;

  Finally
    If Assigned(qryCadEmp) Then
      FreeAndNil(qryCadEmp);
  End;
end;

procedure TExportaTintometricosTerceirosCoralImobiliaria.pProcessaTabelaCores(
  qryInsert: TFDQuery; qryGen, qryBases, qryColorantes: TUniQuery; strTabUni,
  strTabPre: String; fltPerAcr: Double; dicRetorno: TDicionario);
Var
{$IFDEF LINUX}
  LValInfo: TValidateInf;
{$ENDIF}
  fltPreven: Double;
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
  pGerarArrayValidacao(Trunc(qryGen.RecordCount / 6));
{$ENDIF}

  While Not qryGen.Eof Do
  Begin
    qryInsert.Params.ClearValues();
    qryInsert.Params.ArraySize := BATCH_SIZE;
    intContador := 0;

  {$IFDEF LINUX}
    if VS_ExitProcessSignal then
      Break;
  {$ENDIF}

   {$IFDEF LINUX}
    pEscreverAguardeCalculando;
   {$ENDIF}

    For intRegistros := 0 To Pred(BATCH_SIZE) Do
    Begin
     {$IFDEF LINUX}
      if VS_ExitProcessSignal then
        Break;
     {$ENDIF}

      If fGetTipoFormula(qryGen, qryColorantes) = 3 Then
      Begin
        If ((qryGen.RecNo mod 100 = 0) Or (qryGen.RecNo = intMax)) And (Not FAutoma) Then
          Synchronize(pStep);

        qryGen.Next;
        Continue;
      End;

      dicRetorno.Limpar;

      pPreencheDicRetorno(dicRetorno, qryGen, strTabUni, strTabPre);
      pRetornaQuantidadeFormulacao(dicRetorno, qryGen, qryBases);
      pRetornaPrecoTinta(dicRetorno, qryColorantes, qryBases, fltPerAcr);

      If strAcrMob = '1' Then
        fltPreven := IfNull(dicRetorno['preve'+dicRetorno['tabelaunica']], 0.0) * fRetValorAcrMob(qryGen, IfNull(dicRetorno['preve'+dicRetorno['tabelaunica']], 0.0))
      Else
        fltPreVen := IfNull(dicRetorno['preve'+dicRetorno['tabelaunica']], 0.0) + fRetValorAcrMob(qryGen, IfNull(dicRetorno['preve'+dicRetorno['tabelaunica']], 0.0));

      pGravaTintometricoTabelasTerceiros(qryInsert, fltPreven, qryGen, intContador);

      If ((qryGen.RecNo mod 100 = 0) Or (qryGen.RecNo = intMax)) And (Not FAutoma) Then
          Synchronize(pStep);

     {$IFDEF LINUX}
     If FValidateIndexList.Contains(qryGen.RecNo) Then
      begin
        LValInfo.strIdePro := FIdePro;
        LValInfo.strMD5Key := qryGen.FieldByName(fRetMD5KEY).AsString;
        LValInfo.strTabPre := fRetornaTabelaPreco;
        LValInfo.fltPreVen := fltPreven;
        LValInfo.fltPreCus := IfNull(dicPrecoAdicional['precus'], 0);

        If strAcrMob = '1' Then
        Begin
          LValInfo.fltPreVe1 := IfNull(dicPrecoAdicional['preve1'], 0) * fRetValorAcrMob(qryGen, IfNull(dicPrecoAdicional['preve1'], 0));
          LValInfo.fltPreVe2 := IfNull(dicPrecoAdicional['preve2'], 0) * fRetValorAcrMob(qryGen, IfNull(dicPrecoAdicional['preve2'], 0));
          LValInfo.fltPreVe3 := IfNull(dicPrecoAdicional['preve3'], 0) * fRetValorAcrMob(qryGen, IfNull(dicPrecoAdicional['preve3'], 0));
          LValInfo.fltPreVe4 := IfNull(dicPrecoAdicional['preve4'], 0) * fRetValorAcrMob(qryGen, IfNull(dicPrecoAdicional['preve4'], 0));
          LValInfo.fltPreVe5 := IfNull(dicPrecoAdicional['preve5'], 0) * fRetValorAcrMob(qryGen, IfNull(dicPrecoAdicional['preve5'], 0));
          LValInfo.fltPreVe6 := IfNull(dicPrecoAdicional['preve6'], 0) * fRetValorAcrMob(qryGen, IfNull(dicPrecoAdicional['preve6'], 0));
          LValInfo.fltPreVe7 := IfNull(dicPrecoAdicional['preve7'], 0) * fRetValorAcrMob(qryGen, IfNull(dicPrecoAdicional['preve7'], 0));
        End
        Else
        Begin
          LValInfo.fltPreVe1 := IfNull(dicPrecoAdicional['preve1'], 0) + fRetValorAcrMob(qryGen, IfNull(dicPrecoAdicional['preve1'], 0));
          LValInfo.fltPreVe2 := IfNull(dicPrecoAdicional['preve2'], 0) + fRetValorAcrMob(qryGen, IfNull(dicPrecoAdicional['preve2'], 0));
          LValInfo.fltPreVe3 := IfNull(dicPrecoAdicional['preve3'], 0) + fRetValorAcrMob(qryGen, IfNull(dicPrecoAdicional['preve3'], 0));
          LValInfo.fltPreVe4 := IfNull(dicPrecoAdicional['preve4'], 0) + fRetValorAcrMob(qryGen, IfNull(dicPrecoAdicional['preve4'], 0));
          LValInfo.fltPreVe5 := IfNull(dicPrecoAdicional['preve5'], 0) + fRetValorAcrMob(qryGen, IfNull(dicPrecoAdicional['preve5'], 0));
          LValInfo.fltPreVe6 := IfNull(dicPrecoAdicional['preve6'], 0) + fRetValorAcrMob(qryGen, IfNull(dicPrecoAdicional['preve6'], 0));
          LValInfo.fltPreVe7 := IfNull(dicPrecoAdicional['preve7'], 0) + fRetValorAcrMob(qryGen, IfNull(dicPrecoAdicional['preve7'], 0));
        End;

        pValidacaoFormula(LValInfo, VS_EmpExportacao);
      end;
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

procedure TExportaTintometricosTerceirosCoralImobiliaria.pSetaParametrosEspecificos(
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
    strSQL := strSQL + '    SIS_CODEMP = "' + VS_EmpExportacao + '" AND       ';
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

procedure TExportaTintometricosTerceirosCoralImobiliaria.pSetarEmpresaExportacao;
Var
  blnGerarEmpresas: Boolean;
begin
  blnGerarEmpresas := (fCfgSis('EXPEMP') = 'S');

  If Not blnGerarEmpresas Then
    VS_EmpExportacao := VS_strCodEmp
  Else
    VS_EmpExportacao := slEmpExportacao[intLinha];
end;

function TExportaTintometricosTerceirosCoralImobiliaria.fRetornaColorantes: String;
begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '    COL_CODCOL, ';
  Result := Result + '    COL_CODITE, ';
  Result := Result + '    COL_EMBALA, ';
  Result := Result + '    ITE_PREVE' + fRetornaTabelaPreco + ' AS ITE_PREVEN, ';
  Result := Result + '   G.ITE_PRECUS AS PRECUS,          ';
  Result := Result + '   G.ITE_PREVE1 AS PREVE1,          ';
  Result := Result + '   G.ITE_PREVE2 AS PREVE2,          ';
  Result := Result + '   G.ITE_PREVE3 AS PREVE3,          ';
  Result := Result + '   G.ITE_PREVE4 AS PREVE4,          ';
  Result := Result + '   G.ITE_PREVE5 AS PREVE5,          ';
  Result := Result + '   G.ITE_PREVE6 AS PREVE6,          ';
  Result := Result + '   G.ITE_PREVE7 AS PREVE7           ';
  Result := Result + ' FROM                               ';
  Result := Result + '   CORIMO_CADCOL                    ';
  Result := Result + '   JOIN ITEGER G                    ';
  Result := Result + '     ON G.ITE_CODITE = COL_CODITE   ';
  Result := Result + '   JOIN CADITE I               ';
  Result := Result + '     ON I.ITE_CODITE = G.ITE_CODITE ';
  Result := Result + ' WHERE G.ITE_CODEMP = ' + QuotedStr(VS_EmpExportacao);
  Result := Result + '  AND I.ITE_ITEATI = "S"            ';
end;

function TExportaTintometricosTerceirosCoralImobiliaria.fRetornaBases: String;
begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   I.ITE_CODITE, ';
  Result := Result + '   ITE_PREVE' + fRetornaTabelaPreco + ' AS ITE_PREVEN, ';
  Result := Result + '   G.ITE_PRECUS AS PRECUS,             ';
  Result := Result + '   G.ITE_PREVE1 AS PREVE1,             ';
  Result := Result + '   G.ITE_PREVE2 AS PREVE2,             ';
  Result := Result + '   G.ITE_PREVE3 AS PREVE3,             ';
  Result := Result + '   G.ITE_PREVE4 AS PREVE4,             ';
  Result := Result + '   G.ITE_PREVE5 AS PREVE5,             ';
  Result := Result + '   G.ITE_PREVE6 AS PREVE6,             ';
  Result := Result + '   G.ITE_PREVE7 AS PREVE7              ';
  Result := Result + '  FROM                                 ';
  Result := Result + '    CORIMO_CADBAS B                    ';
  Result := Result + '    INNER JOIN CADITE I                ';
  Result := Result + '      ON B.BAS_CODITE = I.ITE_CODITE   ';
  Result := Result + '    INNER JOIN ITEGER G                ';
  Result := Result + '      ON I.ITE_CODITE = G.ITE_CODITE   ';
  Result := Result + '  WHERE G.ITE_CODEMP = ' + QuotedStr(VS_EmpExportacao);
end;

function TExportaTintometricosTerceirosCoralImobiliaria.fRetornaPercentualAcrescimo(
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
      SQL.Add('  WHERE CFG_IDEPRO = "CIM" ');
      SQL.Add('    AND CFG_CODEMP = ' + QuotedStr(VS_EmpExportacao));
      SQL.Add('    AND CFG_CODCFG = "APREVE" ');
      Open;

      If qryGen.IsEmpty Then
        Exit(0);

      If fEmptyStr(FieldByName('CFG_VALCFG').AsString) Then
        Result := 0
      Else
        Result := fStrToFloat(FieldByName('CFG_VALCFG').AsString) / 100.0;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

end.
