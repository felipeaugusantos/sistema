unit untExportaTintometricosTerceirosSuvinil;

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
  untExportaTintometricosTerceirosImobiliaria,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.UI;

type
  TExportaTintometricosTerceirosSuvinil = class(TExportaTintometricosTerceirosImobiliaria)
  Private
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
    function fRetornaBases: String; override;
    function fRetornaPercentualAcrescimo(Conexao: TUniConnection): Double; override;
    procedure pSetaParametrosEspecificos(Conexao: TUniConnection); Override;

    function fRetEmbalagem(qryColorantes: TUniQuery): Double; override;
    function fGetPorLinha(): Integer; Override; //Gerar Cadastro de empresas Exportação

    procedure pIncluirLogTinSite(Conexao: TUniConnection; strStatus: String); override;
    procedure pCarregarPrecosAdicionais(dicRetorno: TDicionario; qryColorantes: TUniQuery;
      qryBases: TUniQuery; fltPerAcr: Double); Override;

    function fGetTipoFormula(qryGen: TUniQuery; qryBases: TUniQuery): Integer; Override;

    procedure pGravaTintometricoTabelasTerceirosPorTinta(qryInsert: TFDQuery;
      fltPreVen: Double; qryTinta: TUniQuery; intParam: Integer = 0); Override;

    constructor Create(pgbProgresso: TcxProgressBar; strIdePro: String;
      blnAuto: Boolean = False); override;
    destructor Destroy; override;

    procedure Execute; override;
 End;

implementation

{ TExportaTintometricosTerceirosSuvinil }

constructor TExportaTintometricosTerceirosSuvinil.Create(
  pgbProgresso: TcxProgressBar; strIdePro: String; blnAuto: Boolean = False);
begin
  inherited  Create(pgbProgresso, strIdePro, blnAuto);
  pProcessarCadastroEmpresaExportacao;
  dicPrecoAdicional := TDicionario.Create;
  stlTabPre := TStringList.Create;
  strAcrMob := fRetValorAcrMobCfgTin();
end;

destructor TExportaTintometricosTerceirosSuvinil.Destroy;
begin
  inherited;
  If Assigned(dicPrecoAdicional) Then FreeAndNil(dicPrecoAdicional);
  If Assigned(stlTabPre) Then FreeAndNil(stlTabPre);
  if Assigned(slEmpExportacao) Then FreeAndNil(slEmpExportacao);
end;

function TExportaTintometricosTerceirosSuvinil.fNomeTabela: String;
begin
  Result := 'SUV_CADSUV_SIT';
end;

function TExportaTintometricosTerceirosSuvinil.fCamposTabela: String;
begin
  Result := '';
  Result := Result + ' CREATE TABLE ' + fNomeTabela;
  Result := Result + ' ( SUV_CODEMP CHAR(3),        ';
  Result := Result + '   SUV_DESCRI VARCHAR(50),    ';
  Result := Result + '   SUV_REFERE VARCHAR(50),    ';
  Result := Result + '   SUV_UNIDAD CHAR(3),        ';
  Result := Result + '   SUV_CODFML VARCHAR(4),     ';
  Result := Result + '   SUV_CODBAS VARCHAR(10),    ';
  Result := Result + '   SUV_NOMCOR VARCHAR(50),    ';
  Result := Result + '   SUV_R_G_B_ VARCHAR(6),     ';
  Result := Result + '   SUV_RED___ CHAR(3),        ';
  Result := Result + '   SUV_GREEN_ CHAR(3),        ';
  Result := Result + '   SUV_BLUE__ CHAR(3),        ';
  Result := Result + '   SUV_TONALI VARCHAR(50),    ';
  Result := Result + '   SUV_CORNOM VARCHAR(50),    ';
  Result := Result + '   SUV_MD5KEY VARCHAR(32),    ';
  Result := Result + '   SUV_CODITE CHAR('+IntToStr(fTamCodIte)+'), '; //Tabela cadite
  Result := Result + '   SUV_DESITE VARCHAR(70),    '; //Tabela cadite
  Result := Result + '   SUV_PREVEN DECIMAL(12,4),  ';
  Result := Result + '   SUV_PRECUS DECIMAL(12,4),  ';
  Result := Result + '   SUV_PREVE1 DECIMAL(12,4),  ';
  Result := Result + '   SUV_PREVE2 DECIMAL(12,4),  ';
  Result := Result + '   SUV_PREVE3 DECIMAL(12,4),  ';
  Result := Result + '   SUV_PREVE4 DECIMAL(12,4),  ';
  Result := Result + '   SUV_PREVE5 DECIMAL(12,4),  ';
  Result := Result + '   SUV_PREVE6 DECIMAL(12,4),  ';
  Result := Result + '   SUV_PREVE7 DECIMAL(12,4)   ';
  Result := Result + '            );                ';
end;


function TExportaTintometricosTerceirosSuvinil.fCamposSelect: String;
begin
  Result := '';
  Result := Result + ' SELECT  ';
  Result := Result + '   S.SUV_DESCRI, ';
  Result := Result + '   SUV_REFERE,   ';
  Result := Result + '   SUV_UNIDAD,   ';
  Result := Result + '   S.SUV_CODFML, ';
  Result := Result + '   S.SUV_CODBAS, ';
  Result := Result + '   SUV_NOMCOR,   ';
  Result := Result + '   SUV_MD5KEY,   ';
  Result := Result + '   S.AUTOINCREM, ';
  Result := Result + '   S.SUV_ACRMOB, ';
  Result := Result + '   S.SUV_CODUNI, ';
  Result := Result + '   S.SUV_TONALI, ';
  Result := Result + '   S.SUV_R_G_B_, ';
  Result := Result + '   S.SUV_RED___, ';
  Result := Result + '   S.SUV_GREEN_, ';
  Result := Result + '   S.SUV_BLUE__, ';
  Result := Result + '   S.SUV_CORNOM, ';

  Result := Result + '   I.ITE_CODITE, ';
  Result := Result + '   I.ITE_DESITE, ';

  Result := Result + '   SUV_FORM01, ';
  Result := Result + '   SUV_QTDB01, ';
  Result := Result + '   SUV_FORM02, ';
  Result := Result + '   SUV_QTDB02, ';
  Result := Result + '   SUV_FORM03, ';
  Result := Result + '   SUV_QTDB03, ';
  Result := Result + '   SUV_FORM04, ';
  Result := Result + '   SUV_QTDB04, ';
  Result := Result + '   SUV_FORM05, ';
  Result := Result + '   SUV_QTDB05, ';
  Result := Result + '   SUV_COLVEN, ';
  Result := Result + '   SUV_COLCUS, ';
  Result := Result + '   SUV_FORM06, ';
  Result := Result + '   SUV_QTDB06, ';
  Result := Result + '   SUV_FORM07, ';
  Result := Result + '   SUV_QTDB07, ';
  Result := Result + '   SUV_FORM08, ';
  Result := Result + '   SUV_QTDB08, ';
  Result := Result + '   SUV_FORM09, ';
  Result := Result + '   SUV_QTDB09, ';
  Result := Result + '   SUV_FORM10, ';
  Result := Result + '   SUV_QTDB10, ';
  Result := Result + '   SUV_FORM11, ';
  Result := Result + '   SUV_QTDB11, ';
  Result := Result + '   SUV_FORM12, ';
  Result := Result + '   SUV_QTDB12, ';
  Result := Result + '   SUV_FORM13, ';
  Result := Result + '   SUV_QTDB13, ';
  Result := Result + '   SUV_FORM14, ';
  Result := Result + '   SUV_QTDB14, ';
  Result := Result + '   SUV_FORM15, ';
  Result := Result + '   SUV_QTDB15, ';
  Result := Result + '   SUV_FORM16, ';
  Result := Result + '   SUV_FORM17, ';
  Result := Result + '   SUV_FORM18, ';
  Result := Result + '   SUV_FORM19, ';
  Result := Result + '   SUV_FORM20, ';
  Result := Result + '   SUV_QTDB16, ';
  Result := Result + '   SUV_QTDB17, ';
  Result := Result + '   SUV_QTDB18, ';
  Result := Result + '   SUV_QTDB19, ';
  Result := Result + '   SUV_QTDB20  ';

  Result := Result + '   FROM SUV_CADSUV S                ';
  Result := Result + '  INNER JOIN SUV_CADBAS B           ';
  Result := Result + '     ON S.SUV_CODBAS = B.SUV_CODBAS ';
  Result := Result + '    AND S.SUV_CODFML = B.SUV_CODFML ';
  Result := Result + '    AND S.SUV_CODUNI = B.SUV_CODUNI ';
  Result := Result + '  INNER JOIN CADITE I               ';
  Result := Result + '     ON B.SUV_CODITE = I.ITE_CODITE ';
  Result := Result + '     AND I.ITE_ITEATI = "S"         ';
  Result := Result + ' WHERE TRUE ';
  Result := Result + '    AND (S.SUV_FORM01 <> "") OR (S.SUV_FORM01 IS NOT NULL);     ';
end;

function TExportaTintometricosTerceirosSuvinil.fQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TExportaTintometricosTerceirosSuvinil.fFatorTinta: Double;
begin
  Result := 0.154;
end;

function TExportaTintometricosTerceirosSuvinil.fGetPorLinha: Integer;
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

function TExportaTintometricosTerceirosSuvinil.fGetTipoFormula(qryGen,
  qryBases: TUniQuery): Integer;
Var
  intContador: Integer;
begin
  Result := 0;

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    If fEmptyStr(qryGen.FieldByName('SUV_FORM' + fStrZero(intContador, 2)).AsString) Then
      Break;

    If Not qryBases.Locate('COL_CODCOL', qryGen.FieldByName('SUV_FORM' + fStrZero(intContador, 2)).AsString, []) Then
    Begin
      Result := 3;
      Break;
    End;
  End;
end;

function TExportaTintometricosTerceirosSuvinil.fRetCODEMP: String;
begin
  Result := 'SUV_CODEMP';
end;

function TExportaTintometricosTerceirosSuvinil.fRetDescricao: String;
begin
  Result := 'SUV_DESCRI';
end;

function TExportaTintometricosTerceirosSuvinil.fRetItemBase: String;
begin
  Result := 'ITE_CODITE';
end;

function TExportaTintometricosTerceirosSuvinil.fRetMD5KEY: String;
begin
  Result := 'SUV_MD5KEY';
end;

function TExportaTintometricosTerceirosSuvinil.fRetFormula(intCont: Integer): String;
begin
  Result := 'SUV_FORM' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosSuvinil.fRetQuantidade(intCont: Integer): String;
begin
  Result := 'SUV_QTDB' + fStrZero(intCont, 2)
end;

function TExportaTintometricosTerceirosSuvinil.fRetValorAcrMob(
  qryGen: TUniQuery; fltQuantidade: Double): Double;
begin
  If fltQuantidade <= 0 Then
    Exit(0);

  If strAcrMob = '1' Then
    Result := (1 + qryGen.FieldByName('SUV_ACRMOB').AsFloat / 100)
  Else
    Result := qryGen.FieldByName('SUV_ACRMOB').AsFloat;
end;

function TExportaTintometricosTerceirosSuvinil.fRetValorAcrMobCfgTin: String;
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' SELECT CFG_VALCFG               ');
    qryGen.SQL.Add('    FROM CFGTIN                  ');
    qryGen.SQL.Add(' WHERE CFG_IDEPRO = "SUV" AND    ');
    qryGen.SQL.Add('       CFG_CODCFG = "ACRMOB" AND ');
    qryGen.SQL.Add('       CFG_CODEMP = ' + QuotedStr(VS_EmpExportacao));
    qryGen.Open;

    Result := qryGen.FieldByName('CFG_VALCFG').AsString;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosSuvinil.fSQLInsert: String;
begin
  Result := '';
  Result := Result + ' INSERT INTO ' + fNomeTabela;
  Result := Result + ' (                ';
  Result := Result + '   SUV_CODEMP,    ';
  Result := Result + '   SUV_DESCRI,    ';
  Result := Result + '   SUV_REFERE,    ';
  Result := Result + '   SUV_UNIDAD,    ';
  Result := Result + '   SUV_CODFML,    ';
  Result := Result + '   SUV_CODBAS,    ';
  Result := Result + '   SUV_NOMCOR,    ';
  Result := Result + '   SUV_R_G_B_,    ';
  Result := Result + '   SUV_RED___,    ';
  Result := Result + '   SUV_GREEN_,    ';
  Result := Result + '   SUV_BLUE__,    ';
  Result := Result + '   SUV_TONALI,    ';
  Result := Result + '   SUV_CORNOM,    ';
  Result := Result + '   SUV_MD5KEY,    ';
  Result := Result + '   SUV_CODITE,    '; //Tabela cadite
  Result := Result + '   SUV_DESITE,    '; //Tabela cadite
  Result := Result + '   SUV_PREVEN,    ';
  Result := Result + '   SUV_PRECUS,    ';
  Result := Result + '   SUV_PREVE1,    ';
  Result := Result + '   SUV_PREVE2,    ';
  Result := Result + '   SUV_PREVE3,    ';
  Result := Result + '   SUV_PREVE4,    ';
  Result := Result + '   SUV_PREVE5,    ';
  Result := Result + '   SUV_PREVE6,    ';
  Result := Result + '   SUV_PREVE7     ';
  Result := Result + ' )                ';

  Result := Result + ' VALUES           ';
  Result := Result + ' (                ';
  Result := Result + '     :CODEMP,     ';
  Result := Result + '     :DESCRI,     ';
  Result := Result + '     :REFERE,     ';
  Result := Result + '     :UNIDAD,     ';
  Result := Result + '     :CODFML,     ';
  Result := Result + '     :CODBAS,     ';
  Result := Result + '     :NOMCOR,     ';
  Result := Result + '     :R_G_B_,     ';
  Result := Result + '     :RED___,     ';
  Result := Result + '     :GREEN_,     ';
  Result := Result + '     :BLUE__,     ';
  Result := Result + '     :TONALI,     ';
  Result := Result + '     :CORNOM,     ';
  Result := Result + '     :MD5KEY,     ';
  Result := Result + '     :CODITE,     '; //Tabela cadite
  Result := Result + '     :DESITE,     '; //Tabela cadite
  Result := Result + '     :PREVEN,     ';
  Result := Result + '     :PRECUS,     ';
  Result := Result + '     :PREVE1,     ';
  Result := Result + '     :PREVE2,     ';
  Result := Result + '     :PREVE3,     ';
  Result := Result + '     :PREVE4,     ';
  Result := Result + '     :PREVE5,     ';
  Result := Result + '     :PREVE6,     ';
  Result := Result + '     :PREVE7      ';
  Result := Result + ' )                ';
end;

procedure TExportaTintometricosTerceirosSuvinil.pAdicionaParamentros(
  Var DataSet: TFDQuery; qryTinta: TUniQuery; fltPreVen: Double; intParam: Integer = 0);
Var
  intContador: Integer;
begin
  DataSet.ParamByName('CODEMP').AsStrings[intParam] := VS_EmpExportacao;
  DataSet.ParamByName('DESCRI').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('SUV_DESCRI').AsString);
  DataSet.ParamByName('REFERE').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('SUV_REFERE').AsString);
  DataSet.ParamByName('UNIDAD').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('SUV_CODUNI').AsString);
  DataSet.ParamByName('CODFML').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('SUV_CODFML').AsString);
  DataSet.ParamByName('CODBAS').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('SUV_CODBAS').AsString);
  DataSet.ParamByName('NOMCOR').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('SUV_NOMCOR').AsString);
  DataSet.ParamByName('R_G_B_').AsStrings[intParam] := qryTinta.FieldByName('SUV_R_G_B_').AsString;
  DataSet.ParamByName('RED___').AsStrings[intParam] := qryTinta.FieldByName('SUV_RED___').AsString;
  DataSet.ParamByName('GREEN_').AsStrings[intParam] := qryTinta.FieldByName('SUV_GREEN_').AsString;
  DataSet.ParamByName('BLUE__').AsStrings[intParam] := qryTinta.FieldByName('SUV_BLUE__').AsString;
  DataSet.ParamByName('TONALI').AsStrings[intParam] := qryTinta.FieldByName('SUV_TONALI').AsString;
  DataSet.ParamByName('CORNOM').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('SUV_CORNOM').AsString);
  DataSet.ParamByName('MD5KEY').AsStrings[intParam] := qryTinta.FieldByName('SUV_MD5KEY').AsString;
  DataSet.ParamByName('CODITE').AsStrings[intParam] := qryTinta.FieldByName('ITE_CODITE').AsString;
  DataSet.ParamByName('DESITE').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('ITE_DESITE').AsString);

  If strAcrMob = '1' Then
    DataSet.ParamByName('PREVEN').AsFloats[intParam]  := fltPreVen * (1 + qryTinta.FieldByName('SUV_ACRMOB').AsFloat / 100)
  Else
    DataSet.ParamByName('PREVEN').AsFloats[intParam]  := fltPreVen + qryTinta.FieldByName('SUV_ACRMOB').AsFloat;

  DataSet.ParamByName('PRECUS').AsFloats[intParam]  := IfNull(dicPrecoAdicional['precus'], 0);

  For intContador := 1 To 7 Do
  Begin
    If stlTabPre[intContador] <> 'S' Then
      DataSet.ParamByName('PREVE' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['preve' + IntToStr(intContador)], 0)
    Else
    Begin
      If strAcrMob = '1' Then
        DataSet.ParamByName('PREVE' + IntToStr(intContador)).AsFloats[intParam] :=  IfNull(dicPrecoAdicional['preve' + IntToStr(intContador)], 0) * (1 + qryTinta.FieldByName('SUV_ACRMOB').AsFloat / 100)
      Else
        DataSet.ParamByName('PREVE' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['preve' + IntToStr(intContador)], 0) + qryTinta.FieldByName('SUV_ACRMOB').AsFloat;
    End;
  End;
end;

procedure TExportaTintometricosTerceirosSuvinil.pCarregarPrecosAdicionais(
  dicRetorno: TDicionario;  qryColorantes, qryBases: TUniQuery; fltPerAcr: Double);
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
          fltPrecoColorante := fltPreCusPro
        Else
          fltPrecoColorante := qryColorantes.FieldByName('PRECUS').AsFloat;

        If fltPrecoColorante = 0 Then
          fltPrecoColorante := qryColorantes.FieldByName('PRECUS').AsFloat;
      End;

     fltQuantidade := ArrComponentes[intContador].Quantidade * fFatorTinta;
     fltPrecoCusto := fltQuantidade * (fltPrecoColorante / fRetEmbalagem(qryColorantes));

     fltPrecoCustoTotal := fltPrecoCustoTotal + fltPrecoCusto;
    End;

    If qryBases.Locate('ITE_CODITE', dicRetorno['itebas'],[]) Then
    Begin
      If fCarregaPromocao(dicRetorno['itebas'], '1', strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
        fltPrecoCustoBase := fltPreCusPro + (fltPerAcr * fltPreCusPro)
      Else
        fltPrecoCustoBase := qryBases.FieldByName('PRECUS').AsFloat + (fltPerAcr * qryBases.FieldByName('PRECUS').AsFloat);

      If fltPrecoCustoBase = 0 Then
        fltPrecoCustoBase := qryBases.FieldByName('PRECUS').AsFloat + (fltPerAcr * qryBases.FieldByName('PRECUS').AsFloat);
    End;

    dicPrecoAdicional['precus'] := fltPrecoCustoTotal + fltPrecoCustoBase;
  Finally
    SetLength(arrComponentes, 0);
  End;
end;


procedure TExportaTintometricosTerceirosSuvinil.pGravaTintometricoTabelasTerceirosPorTinta(
  qryInsert: TFDQuery; fltPreVen: Double; qryTinta: TUniQuery;
  intParam: Integer);
begin
  pAdicionaParamentros(qryInsert, qryTinta, fltPreVen, intParam);
end;

procedure TExportaTintometricosTerceirosSuvinil.pIncluirLogTinSite(
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
      SQL.Add('  WHERE LOG_IDEPRO = "SUV" ');
      ExecSQL;
    End;

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' INSERT INTO LOGTIN_SIT (LOG_IDEPRO, LOG_DTAEXE, LOG_HOREXE, LOG_EXECUT) ');
      SQL.Add('                 VALUES ("SUV", :DTAEXE, :HOREXE, :EXECUT) ');
      ParamByName('DTAEXE').AsDateTime := VS_Date;
      ParamByName('HOREXE').AsDateTime := Time;
      ParamByName('EXECUT').AsString   := strStatus;
      ExecSQL;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TExportaTintometricosTerceirosSuvinil.pProcessarCadastroEmpresaExportacao;
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

procedure TExportaTintometricosTerceirosSuvinil.pProcessaTabelaCores(
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
    If VS_ExitProcessSignal Then
      Break;
  {$ENDIF}

  {$IFDEF LINUX}
    pEscreverAguardeCalculando;
  {$ENDIF}

    For intRegistros := 0 To Pred(BATCH_SIZE) Do
    Begin
    {$IFDEF LINUX}
      If VS_ExitProcessSignal Then
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
      Begin
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
      End;
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

procedure TExportaTintometricosTerceirosSuvinil.pSetaParametrosEspecificos(
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

procedure TExportaTintometricosTerceirosSuvinil.pSetarEmpresaExportacao;
Var
  blnGerarEmpresas: Boolean;
begin
  blnGerarEmpresas := (fCfgSis('EXPEMP') = 'S');

  If Not blnGerarEmpresas Then
    VS_EmpExportacao := VS_strCodEmp
  Else
    VS_EmpExportacao := slEmpExportacao[intLinha];
end;

function TExportaTintometricosTerceirosSuvinil.fRetornaColorantes: String;
begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '    COL_CODCOL, ';
  Result := Result + '    COL_CODITE, ';
  Result := Result + '    COL_EMBALA, ';
  Result := Result + '    ITE_PREVE' + fRetornaTabelaPreco + ' AS ITE_PREVEN,   ';
  Result := Result + '    G.ITE_PRECUS AS PRECUS,         ';
  Result := Result + '    G.ITE_PREVE1 AS PREVE1,         ';
  Result := Result + '    G.ITE_PREVE2 AS PREVE2,         ';
  Result := Result + '    G.ITE_PREVE3 AS PREVE3,         ';
  Result := Result + '    G.ITE_PREVE4 AS PREVE4,         ';
  Result := Result + '    G.ITE_PREVE5 AS PREVE5,         ';
  Result := Result + '    G.ITE_PREVE6 AS PREVE6,         ';
  Result := Result + '    G.ITE_PREVE7 AS PREVE7          ';
  Result := Result + ' FROM                               ';
  Result := Result + '   SUV_CADCOL                    ';
  Result := Result + '   JOIN ITEGER G                    ';
  Result := Result + '     ON G.ITE_CODITE = COL_CODITE   ';
  Result := Result + '   JOIN CADITE I               ';
  Result := Result + '     ON I.ITE_CODITE = G.ITE_CODITE ';
  Result := Result + ' WHERE G.ITE_CODEMP = ' + QuotedStr(VS_EmpExportacao);
  Result := Result + '  AND I.ITE_ITEATI = "S"            ';
end;

function TExportaTintometricosTerceirosSuvinil.fRetornaBases: String;
begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   I.ITE_CODITE, ';
  Result := Result + '   ITE_PREVE' + fRetornaTabelaPreco + ' AS ITE_PREVEN,  ';
  Result := Result + '   G.ITE_PRECUS AS PRECUS,              ';
  Result := Result + '   G.ITE_PREVE1 AS PREVE1,              ';
  Result := Result + '   G.ITE_PREVE2 AS PREVE2,              ';
  Result := Result + '   G.ITE_PREVE3 AS PREVE3,              ';
  Result := Result + '   G.ITE_PREVE4 AS PREVE4,              ';
  Result := Result + '   G.ITE_PREVE5 AS PREVE5,              ';
  Result := Result + '   G.ITE_PREVE6 AS PREVE6,              ';
  Result := Result + '   G.ITE_PREVE7 AS PREVE7               ';
  Result := Result + '  FROM                                  ';
  Result := Result + '    SUV_CADBAS B                        ';
  Result := Result + '    INNER JOIN CADITE I                 ';
  Result := Result + '      ON B.SUV_CODITE = I.ITE_CODITE    ';
  Result := Result + '    INNER JOIN ITEGER G                 ';
  Result := Result + '      ON I.ITE_CODITE = G.ITE_CODITE    ';
  Result := Result + '  WHERE G.ITE_CODEMP = ' + QuotedStr(VS_EmpExportacao);
end;

function TExportaTintometricosTerceirosSuvinil.fRetornaPercentualAcrescimo(
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
      SQL.Add('  WHERE CFG_IDEPRO = "SUV" ');
      SQL.Add('    AND CFG_CODEMP = ' + QuotedStr(VS_EmpExportacao));
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

function TExportaTintometricosTerceirosSuvinil.fRetEmbalagem(
  qryColorantes: TUniQuery): Double;
begin
  Result := qryColorantes.FieldByName('COL_EMBALA').AsFloat;
end;

procedure TExportaTintometricosTerceirosSuvinil.Execute;
begin
  inherited Execute;
end;


end.
