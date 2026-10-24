{******************************************************************************************}
{* Classe responsável pela conversão de TZQuery para IDataSet, assim é possivel trabalhar *}
{* com uma TZQuery, sem ter conhecimento de sua implementação                             *}
{***************************************************************************************PH*}
unit untUniQueryDataSetWrapper;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
  Shared.Core, untGTinForTipos,
{$ELSE}
  untFuncoesSimples,
{$ENDIF}
  Uni, untIDataSet, DB, Classes, SysUtils,
  untDataSetIDataSetWrapper, untFieldDataSetFieldWrapper,
  untParamDataSetWrapper;

type
  TUniQueryDataSetWrapper = class(TDataSetIDataSetWrapper, IDataSet)
  public
    function GetSQL: String; override;
    procedure SetSQL(const strSql: String); override;

    function ParamByName(const Value: string): IDataSetParam; override;
    function Params(const Value: integer): IDataSetParam; override;
    procedure ExecSQL; override;
    constructor Create; overload;
  end;

implementation

{ TUniQueryDataSetWrapper }

procedure TUniQueryDataSetWrapper.SetSQL(const strSql: String);
begin
  TUniQuery(qryGen).SQL.Clear;
  TUniQuery(qryGen).Params.Clear;
  TUniQuery(qryGen).SQL.Text := strSql;
end;

procedure TUniQueryDataSetWrapper.ExecSQL;
begin
  TUniQuery(qryGen).ExecSQL;
end;

function TUniQueryDataSetWrapper.GetSQL: String;
begin
  Result := TUniQuery(qryGen).SQL.Text;
end;

function TUniQueryDataSetWrapper.ParamByName(const Value: string): IDataSetParam;
begin
  Result := TParamDataSetWrapper.Create(TUniQuery(qryGen).ParamByName(Value));
end;

function TUniQueryDataSetWrapper.Params(const Value: integer): IDataSetParam;
begin
  Result := TParamDataSetWrapper.Create(TUniQuery(qryGen).Params[Value]);
end;

constructor TUniQueryDataSetWrapper.Create();
begin
  inherited Create();
  Self.qryGen := fCriaQuery();
  Self.blnVinculado := False;
end;

end.
