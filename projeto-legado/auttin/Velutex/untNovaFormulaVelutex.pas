unit untNovaFormulaVelutex;

interface

uses
  untINovaFormula, DB, Uni,  SysUtils, Classes;

type
  TNovaFormulaVelutex = class(TInterfacedObject, INovaFormula)
  private
    qryCadVel: TUniQuery;
    qryCadEmb: TUniQuery;
    function GetColorante(const strComponente: string; const qryNfm: TDataSet): TUniQuery;
  public
    procedure GetCamposChaves(var arrChaves: array of string);
    function GetCountCamposChaves: Integer;
    function GetIdePro: string;
    function GetNomeConfProCod: string;
    function GetNomeTabelaNovaFormula: string;
    function GetSqlSelectNovasFormulas: string;
    function GravarNovaFormula(const qryNfm: TDataSet): Boolean;
    procedure RemoverNovaFormula(const strCodNfm: string);
    function GetCountModos: Integer;
    function GetMaximoComponentes: Integer;
    function GetNomeModo(const index: Integer): string;
    function GetPrefixoComponente: string;
    function GetPrefixoQuantidade(const intModo: Integer): string;
    function GetTamanhoCampoComponente: Integer;
    function GetTamanhoModo(const index: Integer): Integer;
    function GetTipoModo(const index: Integer): TFieldType;
    procedure pCriaDataSets(const qryNfm: TDataSet);
    procedure pInicializaIndices(const stlCampos, stlCamInd, stlDesInd: TStringList);
    function ComponenteValido(const strComponente: string; const qryNfm: TDataSet): Boolean;
    procedure ValidaComponente(const strComponente: string; const qryNfm: TDataSet);
    function GetNomeTabelaComponete: string;
    function GetSqlSelectComponente(const qryNfm: TDataSet): string;
    procedure MontaIndicesConsultaComponentes(const stlCamposIndices: TStringList; const stlDescricaoIndices: TStringList);
    function GetNomeCampoComponente: string;
    function IsValorVazio(const strValor: string): Boolean;
    constructor Create();
    destructor Destroy; override;

    function fRetQuantidade(strUnidadeNfm, strUnidade, strProduto : String; fltQuantidade : Double) : Double;



  end;

implementation

uses untFuncoesSimples;

{ TNovaFormulaVelutex }

function TNovaFormulaVelutex.ComponenteValido(const strComponente: string; const qryNfm: TDataSet): Boolean;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Result := False;
  Try
    Try
      qryGen := GetColorante(strComponente, qryNfm);
      Result := (not qryGen.IsEmpty);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;
end;

function TNovaFormulaVelutex.GetColorante(const strComponente: string; const qryNfm: TDataSet): TUniQuery;
begin
  Result := fCriaQuery();
  Result.SQL.Text := GetSqlSelectComponente(qryNfm);
  Result.SQL.Text := Result.SQL.Text +
    'WHERE COL_CODCOL = :CODCOL ';
  Result.ParamByName('CODCOL').AsString := strComponente;
  Result.Open;
end;

constructor TNovaFormulaVelutex.Create;
begin
  qryCadVel := fCriaQuery();
  qryCadVel.SQL.Text := 'SELECT * FROM VEL_CADVEL WHERE FALSE';
  qryCadVel.Open;

end;

destructor TNovaFormulaVelutex.Destroy;
begin
  if Assigned(qryCadVel) then FreeAndNil(qryCadVel);
  if Assigned(qryCadEmb) then FreeAndNil(qryCadEmb);
  inherited;
end;

function TNovaFormulaVelutex.fRetQuantidade(strUnidadeNfm, strUnidade, strProduto: String;  fltQuantidade : Double): Double;
Var
  blnGrafiato : Boolean;
begin

  blnGrafiato := Pos(strProduto, 'GRAFIATO RÚSTICO_TEXTURATTO RÚSTICO_CRISTAL MÉDIO_GRALITE MÉDIO'+
                                 '_GRAFIATO RUSTICO_TEXTURATTO RUSTICO_CRISTAL MEDIO_GRALITE MEDIO') > 0;

  Result := fltQuantidade;

  if (strUnidadeNfm = 'LT') And (strUnidade =  'GL') Then
    Result := fltQuantidade * 4
  else
  if (strUnidadeNfm = 'LT') And (strUnidade =  'LA') Then
    Result := fltQuantidade * IIF(blnGrafiato, 28.39, 20)
  else
  if (strUnidadeNfm = 'GL') And (strUnidade =  'LT') Then
    Result := fltQuantidade /4
  else
  if (strUnidadeNfm = 'GL') And (strUnidade =  'LA') Then
    Result := fltQuantidade * IIF(blnGrafiato, 7.0975, 5)
  else
  if (strUnidadeNfm = 'LA') And (strUnidade =  'LT') Then
    Result := fltQuantidade / IIF(blnGrafiato, 28.39, 20)
  else
  if (strUnidadeNfm = 'LA') And (strUnidade =  'GL') Then
    Result := fltQuantidade / IIF(blnGrafiato, 7.0975, 5);
end;

procedure TNovaFormulaVelutex.GetCamposChaves(var arrChaves: array of string);
begin
  arrChaves[0] := 'NFM_CODNFM';
end;

function TNovaFormulaVelutex.GetCountCamposChaves: Integer;
begin
  Result := 1;
end;

function TNovaFormulaVelutex.GetCountModos: Integer;
begin
  Result := 1;
end;

function TNovaFormulaVelutex.GetIdePro: string;
begin
  Result := 'VEL';
end;

function TNovaFormulaVelutex.GetMaximoComponentes: Integer;
begin
  Result := 20;
end;

function TNovaFormulaVelutex.GetNomeCampoComponente: string;
begin
  Result := 'COL_CODCOL';
end;

function TNovaFormulaVelutex.GetNomeConfProCod: string;
begin
  Result := 'PROCOD';
end;

function TNovaFormulaVelutex.GetNomeModo(const index: Integer): string;
begin
  Result := '';
end;

function TNovaFormulaVelutex.GetNomeTabelaComponete: string;
begin
  Result := 'VEL_CADCOL';
end;

function TNovaFormulaVelutex.GetNomeTabelaNovaFormula: string;
begin
  Result := 'VEL_CADNFM';
end;

function TNovaFormulaVelutex.GetPrefixoComponente: string;
begin
  Result := 'NFM_CODC';
end;

function TNovaFormulaVelutex.GetPrefixoQuantidade(const intModo: Integer): string;
begin
  Result := 'NFM_QTDC';
end;

function TNovaFormulaVelutex.GetSqlSelectComponente(const qryNfm: TDataSet): string;
begin
  Result :=
    ' SELECT                                    ' +
    '   VEL_CADCOL.AUTOINCREM                   ' +
    '   , COL_CODCOL AS ''Código do Colorante'' ' +
    '   , ITE_CODITE AS ''Código do Item''      ' +
    '   , ITE_DESITE AS ''Descrição do Item''   ' +
    '   , ITE_REFERE AS ''Referência do Item''  ' +
    ' FROM                                      ' +
    '   VEL_CADCOL                              ' +
    '   LEFT JOIN CADITE                        ' +
    '     ON COL_CODITE = ITE_CODITE            ';
end;

function TNovaFormulaVelutex.GetSqlSelectNovasFormulas: string;
begin
  Result := 'SELECT * FROM VEL_CADNFM';
end;

function TNovaFormulaVelutex.GetTamanhoCampoComponente: Integer;
begin
  Result := 5;
end;

function TNovaFormulaVelutex.GetTamanhoModo(const index: Integer): Integer;
begin
  Result := 0;
end;

function TNovaFormulaVelutex.GetTipoModo(const index: Integer): TFieldType;
begin
  Result := ftFloat;
end;

function TNovaFormulaVelutex.GravarNovaFormula(const qryNfm: TDataSet): Boolean;
Var
  intCont  : Integer;
  QryAux   : TUniQuery;
begin
  Result := True;

  QryAux := Nil;

  Try
    Try
      QryAux := fCriaQuery();
      QryAux.SQL.Text := 'SELECT BAS_CODUNI '+
                         '   FROM  VEL_CADBAS '+
                         '  WHERE BAS_CODBAS = :CODBAS '+
                         '    AND BAS_PRODUT = :PRODUT '+
                         '    AND BAS_CODITE IS NOT NULL ';
      QryAux.ParamByName('CODBAS').AsString := qryNfm.FieldByName('NFM_CODBAS').AsString;
      QryAux.ParamByName('PRODUT').AsString := qryNfm.FieldByName('NFM_PRODUT').AsString;
      QryAux.Open;

      QryAux.First;

      While not QryAux.Eof Do
      Begin

        qryCadVel.Insert;
        qryCadVel.FieldByName('VEL_CODEMP').AsString := qryNfm.FieldByName('NFM_CODEMP').AsString;
        qryCadVel.FieldByName('VEL_CORCOD').AsString := qryNfm.FieldByName('NFM_CORCOD').AsString;
        qryCadVel.FieldByName('VEL_CODBAS').AsString := qryNfm.FieldByName('NFM_CODBAS').AsString;
        qryCadVel.FieldByName('VEL_COLECA').AsString := qryNfm.FieldByName('NFM_COLECA').AsString;
        qryCadVel.FieldByName('VEL_PRODUT').AsString := qryNfm.FieldByName('NFM_PRODUT').AsString;
        qryCadVel.FieldByName('VEL_CODNOM').AsString := qryNfm.FieldByName('NFM_CODNOM').AsString;
        qryCadVel.FieldByName('VEL_CODUNI').AsString := QryAux.FieldByName('BAS_CODUNI').AsString;
        qryCadVel.FieldByName('VEL_DTACAD').AsDateTime := qryNfm.FieldByName('NFM_DTACAD').AsDateTime;

        for intCont := 1 to 20 do
        begin

          if qryNfm.FieldByName('NFM_QTDC' + fStrZero(intCont, 2)).AsFloat <= 0 then
            Break;

          if fEmptyStr(qryNfm.FieldByName('NFM_CODC' + fStrZero(intCont, 2)).AsString) then
            Break;

          qryCadVel.FieldByName('VEL_CODC' + fStrZero(intCont, 2)).AsString := qryNfm.FieldByName('NFM_CODC' + fStrZero(intCont, 2)).AsString;
          qryCadVel.FieldByName('VEL_QTDC' + fStrZero(intCont, 2)).AsFloat  := fRetQuantidade( qryNfm.FieldByName('NFM_CODUNI').AsString
                                                                                             , QryAux.FieldByName('BAS_CODUNI').AsString
                                                                                             , qryNfm.FieldByName('NFM_PRODUT').AsString
                                                                                             , qryNfm.FieldByName('NFM_QTDC' + fStrZero(intCont, 2)).AsFloat);
        end;

        qryCadVel.FieldByName('VEL_CODNFM').AsString := qryNfm.FieldByName('NFM_CODNFM').AsString;
        qryCadVel.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('VEL_CADVEL', qryNfm.FieldByName('NFM_CODEMP').AsString);
        qryCadVel.FieldByName('VEL_NOTA__').AsString := qryNfm.FieldByName('NFM_NOTA__').AsString;

        qryCadVel.FieldByName('VEL_MD5KEY').AsString :=
          GetMD5(qryCadVel.FieldByName('VEL_CORCOD').AsString + qryCadVel.FieldByName('VEL_CODBAS').AsString +
                 qryCadVel.FieldByName('VEL_COLECA').AsString + qryCadVel.FieldByName('VEL_PRODUT').AsString +
                 qryCadVel.FieldByName('VEL_CODUNI').AsString + qryCadVel.FieldByName('VEL_CODNOM').AsString);

        qryCadVel.Post;

        QryAux.Next;
      End;
    Except
      on E: Exception do
      begin
      end;
    End;
  Finally
    If Assigned(QryAux) Then
      FreeAndNil(QryAux);
  End;
end;

function TNovaFormulaVelutex.IsValorVazio(const strValor: string): Boolean;
begin
  Result := fStrToFloat(strValor) <= 0;
end;

procedure TNovaFormulaVelutex.MontaIndicesConsultaComponentes(const stlCamposIndices, stlDescricaoIndices: TStringList);
begin
  stlCamposIndices.Add('COL_CODCOL');
  stlCamposIndices.Add('ITE_CODITE');
  stlCamposIndices.Add('ITE_DESITE');
  stlCamposIndices.Add('ITE_REFERE');

  stlDescricaoIndices.Add('Código do Colorante');
  stlDescricaoIndices.Add('Código do Item');
  stlDescricaoIndices.Add('Descrição do Item');
  stlDescricaoIndices.Add('Referência do Item');
end;

procedure TNovaFormulaVelutex.pCriaDataSets(const qryNfm: TDataSet);
var
  intCont: Integer;
begin
  qryNfm.FieldbyName('NFM_CORCOD').DisplayLabel := 'Color Code';
  qryNfm.FieldbyName('NFM_CODBAS').DisplayLabel := 'Código da Base';
  qryNfm.FieldbyName('NFM_COLECA').DisplayLabel := 'Coleção';
  qryNfm.FieldbyName('NFM_PRODUT').DisplayLabel := 'Produto';
  qryNfm.FieldbyName('NFM_CODUNI').DisplayLabel := 'Unidade';
  qryNfm.FieldbyName('NFM_NOTA__').DisplayLabel := 'Nota';
  qryNfm.FieldbyName('NFM_CODNOM').DisplayLabel := 'Cód.Nome';

  qryNfm.FieldByName('AUTOINCREM').Visible := False;

  For intCont := 1 To 20 Do
  Begin
    TFloatField(qryNfm.FieldByName('NFM_QTDC' + fStrZero(intCont, 2))).DisplayFormat := '0.00';
  End;
end;

procedure TNovaFormulaVelutex.pInicializaIndices(const stlCampos, stlCamInd, stlDesInd: TStringList);
begin
  stlCampos.Add('NFM_CORCOD');
  stlCampos.Add('NFM_CODBAS');
  stlCampos.Add('NFM_COLECA');
  stlCampos.Add('NFM_PRODUT');
  stlCampos.Add('NFM_CODUNI');
  stlCampos.Add('NFM_NOTA__');
  stlCampos.Add('NFM_CODNOM');

  stlCamInd.Add('NFM_CORCOD');
  stlCamInd.Add('NFM_CODBAS');
  stlCamInd.Add('NFM_COLECA');
  stlCamInd.Add('NFM_PRODUT');
  stlCamInd.Add('NFM_CODUNI');
  stlCamInd.Add('NFM_NOTA__');
  stlCamInd.Add('NFM_CODNOM');

  stlDesInd.Add('Color Code');
  stlDesInd.Add('Código da Base');
  stlDesInd.Add('Colecao');
  stlDesInd.Add('Produto');
  stlDesInd.Add('Unidade');
  stlDesInd.Add('Nota');
  stlDesInd.Add('Cód.Nome');
end;

procedure TNovaFormulaVelutex.RemoverNovaFormula(const strCodNfm: string);
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text := 'DELETE FROM VEL_CADVEL WHERE VEL_CODNFM = :CODNFM';
      qryGen.ParamByName('CODNFM').AsString := strCodNfm;
      qryGen.ExecSQL;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;                              
end;

procedure TNovaFormulaVelutex.ValidaComponente(const strComponente: string; const qryNfm: TDataSet);
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := GetColorante(strComponente, qryNfm);
      if qryGen.IsEmpty then
        raise Exception.CreateFmt('O componente [%s] não está cadastrado!', [strComponente]);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;
end;

end.
