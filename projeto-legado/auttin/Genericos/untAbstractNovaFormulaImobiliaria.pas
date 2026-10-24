unit untAbstractNovaFormulaImobiliaria;

interface

uses
  untINovaFormula, DB, Uni, SysUtils, Classes;

type
  TAbstractNovaFormulaImobiliaria = class abstract(TInterfacedObject, INovaFormula)
  protected
    function GetColorante(const strComponente: string; const qryNfm: TDataSet): TUniQuery; virtual;
  public
    procedure GetCamposChaves(var arrChaves: array of string); virtual;
    function GetCountCamposChaves: Integer; virtual;
    function GetIdePro: string; virtual; abstract;
    function GetNomeConfProCod: string; virtual;
    function GetNomeTabelaNovaFormula: string; virtual; abstract;
    function GetSqlSelectNovasFormulas: string; virtual;
    function GravarNovaFormula(const qryNfm: TDataSet): Boolean; virtual; abstract;
    procedure RemoverNovaFormula(const strCodNfm: string); virtual; abstract;
    function GetCountModos: Integer; virtual;
    function GetMaximoComponentes: Integer; virtual;
    function GetNomeModo(const index: Integer): string; virtual;
    function GetPrefixoComponente: string; virtual;
    function GetPrefixoQuantidade(const intModo: Integer): string; virtual;
    function GetTamanhoCampoComponente: Integer; virtual;
    function GetTamanhoModo(const index: Integer): Integer; virtual;
    function GetTipoModo(const index: Integer): TFieldType; virtual;
    procedure pCriaDataSets(const qryNfm: TDataSet); virtual;
    procedure pInicializaIndices(const stlCampos, stlCamInd, stlDesInd: TStringList); virtual; abstract;
    function ComponenteValido(const strComponente: string; const qryNfm: TDataSet): Boolean; virtual;
    procedure ValidaComponente(const strComponente: string; const qryNfm: TDataSet); virtual;
    function GetNomeTabelaComponete: string; virtual; abstract;
    function GetSqlSelectComponente(const qryNfm: TDataSet): string; virtual; 
    procedure MontaIndicesConsultaComponentes(const stlCamposIndices: TStringList; const stlDescricaoIndices: TStringList); virtual;
    function GetNomeCampoComponente: string; virtual;
    function IsValorVazio(const strValor: string): Boolean; virtual;
    destructor Destroy; override;
  end;

implementation

uses untFuncoesSimples;

{ TAbstractNovaFormulaImobiliaria }

function TAbstractNovaFormulaImobiliaria.ComponenteValido(const strComponente: string; const qryNfm: TDataSet): Boolean;
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

destructor TAbstractNovaFormulaImobiliaria.Destroy;
begin
  inherited;
end;

procedure TAbstractNovaFormulaImobiliaria.GetCamposChaves(var arrChaves: array of string);
begin
  arrChaves[0] := 'NFM_CODNFM';
end;

function TAbstractNovaFormulaImobiliaria.GetColorante(const strComponente: string; const qryNfm: TDataSet): TUniQuery;
begin
  Result := fCriaQuery();
  Result.SQL.Text := GetSqlSelectComponente(qryNfm);
  Result.SQL.Text := Result.SQL.Text +
    'WHERE COL_CODCOL = :CODCOL ';
  Result.ParamByName('CODCOL').AsString := strComponente;
  Result.Open;
end;

function TAbstractNovaFormulaImobiliaria.GetCountCamposChaves: Integer;
begin
  Result := 1;
end;

function TAbstractNovaFormulaImobiliaria.GetCountModos: Integer;
begin
  Result := 1;
end;

function TAbstractNovaFormulaImobiliaria.GetMaximoComponentes: Integer;
begin
  Result := 20;
end;

function TAbstractNovaFormulaImobiliaria.GetNomeCampoComponente: string;
begin
  Result := 'COL_CODCOL';
end;

function TAbstractNovaFormulaImobiliaria.GetNomeConfProCod: string;
begin
  Result := 'PROCOD';
end;

function TAbstractNovaFormulaImobiliaria.GetNomeModo(const index: Integer): string;
begin
  Result := '';
end;

function TAbstractNovaFormulaImobiliaria.GetPrefixoComponente: string;
begin
  Result := 'NFM_FORM';
end;

function TAbstractNovaFormulaImobiliaria.GetPrefixoQuantidade(const intModo: Integer): string;
begin
  Result := 'NFM_QTDC';
end;

function TAbstractNovaFormulaImobiliaria.GetSqlSelectComponente(const qryNfm: TDataSet): string;
begin
    Result :=
    ' SELECT                                    ' +
    '   ' + GetNomeTabelaComponete + '.AUTOINCREM                   ' +
    '   , COL_CODCOL AS ''Código do Colorante'' ' +
    '   , ITE_CODITE AS ''Código do Item''      ' +
    '   , ITE_DESITE AS ''Descrição do Item''   ' +
    '   , ITE_REFERE AS ''Referência do Item''  ' +
    ' FROM                                      ' +
    '   ' + GetNomeTabelaComponete + '                              ' +
    '   LEFT JOIN CADITE                        ' +
    '     ON COL_CODITE = ITE_CODITE            ';
end;

function TAbstractNovaFormulaImobiliaria.GetSqlSelectNovasFormulas: string;
begin
  Result := 'SELECT * FROM ' + GetNomeTabelaNovaFormula;
end;

function TAbstractNovaFormulaImobiliaria.GetTamanhoCampoComponente: Integer;
begin
  Result := 5;
end;

function TAbstractNovaFormulaImobiliaria.GetTamanhoModo(const index: Integer): Integer;
begin
  Result := 0;
end;

function TAbstractNovaFormulaImobiliaria.GetTipoModo(const index: Integer): TFieldType;
begin
  Result := ftFloat;
end;

function TAbstractNovaFormulaImobiliaria.IsValorVazio(const strValor: string): Boolean;
begin
  Result := fStrToFloat(strValor) <= 0;
end;

procedure TAbstractNovaFormulaImobiliaria.MontaIndicesConsultaComponentes(const stlCamposIndices, stlDescricaoIndices: TStringList);
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

procedure TAbstractNovaFormulaImobiliaria.pCriaDataSets(const qryNfm: TDataSet);
begin
  qryNfm.FieldByName('AUTOINCREM').Visible := False;                                                  
end;


procedure TAbstractNovaFormulaImobiliaria.ValidaComponente(const strComponente: string; const qryNfm: TDataSet);
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
