{******************************************************************************************}
{* Classe responsável pela conversão de TZQuery para IDataSet, assim é possivel trabalhar *}
{* com uma TZQuery, sem ter conhecimento de sua implementação                             *}
{***************************************************************************************PH*}
unit untZQueryDataSetWrapper;

interface

uses
  ZDataSet, untIDataSet, DB, Classes, untFuncoesSimples, SysUtils,
  untDataSetIDataSetWrapper, untFieldDataSetFieldWrapper,
  untParamDataSetWrapper;

type
  TZQueryDataSetWrapper = class(TDataSetIDataSetWrapper, IDataSet)
  public
    function GetSQL: String; override;
    procedure SetSQL(const strSql: String); override;

    function ParamByName(const Value: string): IDataSetParam; override;
    function Params(const Value: integer): IDataSetParam; override;
    procedure ExecSQL; override;
    constructor Create; overload;
  end;

implementation

{ TZQueryDataSetWrapper }

procedure TZQueryDataSetWrapper.SetSQL(const strSql: String);
begin
  TZQuery(qryGen).SQL.Clear;
  TZQuery(qryGen).Params.Clear;
  TZQuery(qryGen).SQL.Text := strSql;
end;

procedure TZQueryDataSetWrapper.ExecSQL;
begin
  TZQuery(qryGen).ExecSQL;
end;

function TZQueryDataSetWrapper.GetSQL: String;
begin
  Result := TZQuery(qryGen).SQL.Text;
end;

function TZQueryDataSetWrapper.ParamByName(const Value: string): IDataSetParam;
begin
  Result := TParamDataSetWrapper.Create(TZQuery(qryGen).ParamByName(Value));
end;

function TZQueryDataSetWrapper.Params(const Value: integer): IDataSetParam;
begin
  Result := TParamDataSetWrapper.Create(TZQuery(qryGen).Params[Value]);
end;

constructor TZQueryDataSetWrapper.Create();
begin
  inherited Create();
  Self.qryGen := fCriaQuery();
  Self.blnVinculado := False;
end;

end.
