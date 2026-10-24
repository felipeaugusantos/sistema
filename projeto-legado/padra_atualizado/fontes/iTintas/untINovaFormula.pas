unit untINovaFormula;

interface

uses
  DB, Classes;

type
  INovaFormula = interface
    ['{9ABAE4A3-C6F2-4436-B2AE-A6EC37FF7F65}']
    function GetSqlSelectNovasFormulas: string;
    function GetNomeTabelaNovaFormula: string;
    function GetCountCamposChaves: Integer;
    procedure GetCamposChaves(var arrChaves: array of string);
    function GetIdePro: string;
    function GetNomeConfProCod: string;
    procedure RemoverNovaFormula(const strCodNfm: string);
    function GravarNovaFormula(const qryNfm: TDataSet): Boolean;
    function GetTamanhoCampoComponente: Integer;
    function GetCountModos: Integer;
    function GetNomeModo(const index: Integer): string;
    function GetTipoModo(const index: Integer): TFieldType;
    function GetTamanhoModo(const index: Integer): Integer;
    function GetMaximoComponentes: Integer;
    function GetPrefixoComponente: string;
    function GetPrefixoQuantidade(const intModo: Integer): string;
    procedure pCriaDataSets(const qryNfm: TDataSet);
    procedure pInicializaIndices(const stlCampos, stlCamInd, stlDesInd: TStringList);
    function ComponenteValido(const strComponente: string; const qryNfm: TDataSet): Boolean;
    procedure ValidaComponente(const strComponente: string; const qryNfm: TDataSet);
    function GetSqlSelectComponente(const qryNfm: TDataSet): string;
    procedure MontaIndicesConsultaComponentes(const stlCamposIndices: TStringList; const stlDescricaoIndices: TStringList);
    function GetNomeTabelaComponete: string;
    function GetNomeCampoComponente: string;
    function IsValorVazio(const strValor: string): Boolean;
  end;

implementation

end.
