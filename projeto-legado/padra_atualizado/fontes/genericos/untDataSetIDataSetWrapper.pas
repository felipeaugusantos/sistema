{*******************************************************************************************}
{* Classe responsável por converter um TDataSet em um IDataSet, assim é possivel trabalhar *}
{* com um dataset em outros projetos                                                       *}
{****************************************************************************************PH*}
unit untDataSetIDataSetWrapper;

interface

uses
  untIDataSet, DB, untParamDataSetWrapper, SysUtils, untFieldDataSetFieldWrapper;

type
  TDataSetIDataSetWrapper = class abstract(TInterfacedObject, IDataSet)
  protected
    qryGen: TDataSet;
    blnVinculado: Boolean;
  public
    constructor Create(const qryGen: TDataSet); overload;
    constructor Create(const qryGen: TDataSet; const blnDestruirQueryJunto: Boolean); overload;
    destructor Destroy; override;

    function GetObject: TObject;

    procedure Close; virtual;
    function Eof: Boolean; virtual;
    procedure ExecSQL; virtual;
    function FieldByName(const strNome: string): IDataSetField; virtual;
    function FindField(const FieldName: string): IDataSetField; virtual;
    function GetActive: Boolean; virtual;
    function GetSQL: string; virtual;
    function IsEmpty: Boolean; virtual;
    function Locate(const KeyFields: string; const KeyValues: Variant; Options: TLocateOptions): Boolean; virtual;
    procedure Next; virtual;
    procedure First; virtual;
    procedure Open; virtual;
    function ParamByName(const Value: string): IDataSetParam; virtual; abstract;
    function Params(const Value: integer): IDataSetParam; virtual; abstract;
    function RecNo: Integer; virtual;
    function RecordCount: Integer; virtual;
    procedure SetActive(const Value: Boolean); virtual;
    procedure SetSQL(const strSql: string); virtual;
    procedure Delete;
    procedure Edit;
    procedure Insert;
    procedure Post;
    procedure Filtrar(const strFiltro: string);

    //
  end;


implementation

{ TDataSetIDataSetWrapper }

procedure TDataSetIDataSetWrapper.Close;
begin
  qryGen.Close;
end;

constructor TDataSetIDataSetWrapper.Create(const qryGen: TDataSet; const blnDestruirQueryJunto: Boolean);
begin
  inherited Create();
  Self.qryGen := qryGen;
  Self.blnVinculado := not blnDestruirQueryJunto;
end;

constructor TDataSetIDataSetWrapper.Create(const qryGen: TDataSet);
begin
  inherited Create();
  Self.qryGen := qryGen;
  Self.blnVinculado := True;
end;

procedure TDataSetIDataSetWrapper.Delete;
begin
  qryGen.Delete;
end;

destructor TDataSetIDataSetWrapper.Destroy;
begin
  if not blnVinculado then
  begin
    qryGen.Close;
    if Assigned(qryGen) then FreeAndNil(qryGen);
  end;

  inherited Destroy;
end;

procedure TDataSetIDataSetWrapper.Edit;
begin
  qryGen.Edit;
end;

function TDataSetIDataSetWrapper.Eof: Boolean;
begin
  Result := qryGen.Eof;
end;

procedure TDataSetIDataSetWrapper.ExecSQL;
begin
  qryGen.Open;
end;

function TDataSetIDataSetWrapper.FieldByName(const strNome: string): IDataSetField;
begin
  Result := TFieldDataSetFieldWrapper.Create(qryGen.FieldByName(strNome));
end;

procedure TDataSetIDataSetWrapper.Filtrar(const strFiltro: string);
begin
  if strFiltro <> qryGen.Filter then
  begin
    qryGen.Filtered := False;
    qryGen.Filter := strFiltro;
    qryGen.Filtered := True;
  end;  
  
end;

function TDataSetIDataSetWrapper.FindField(const FieldName: string): IDataSetField;
var
  retorno: TField;
begin
  Result := nil;
  retorno := qryGen.FindField(FieldName);
  if Assigned(retorno) then
    Result := TFieldDataSetFieldWrapper.Create(retorno);
end;

procedure TDataSetIDataSetWrapper.First;
begin
  qryGen.First;
end;

function TDataSetIDataSetWrapper.GetActive: Boolean;
begin
  Result := qryGen.Active;
end;

function TDataSetIDataSetWrapper.GetObject: TObject;
begin
  Result := qryGen;
end;

function TDataSetIDataSetWrapper.GetSQL: string;
begin
  Result := '';
end;

procedure TDataSetIDataSetWrapper.Insert;
begin
  qryGen.Insert;
end;

function TDataSetIDataSetWrapper.IsEmpty: Boolean;
begin
  Result := qryGen.IsEmpty;
end;

function TDataSetIDataSetWrapper.Locate(const KeyFields: string; const KeyValues: Variant; Options: TLocateOptions): Boolean;
begin
  Result := qryGen.Locate(KeyFields, KeyValues, Options);
end;

procedure TDataSetIDataSetWrapper.Next;
begin
  qryGen.Next;
end;

procedure TDataSetIDataSetWrapper.Open;
begin
  qryGen.Open;
end;

procedure TDataSetIDataSetWrapper.Post;
begin
  qryGen.Post;
end;

function TDataSetIDataSetWrapper.RecNo: Integer;
begin
  Result := qryGen.RecNo;
end;

function TDataSetIDataSetWrapper.RecordCount: Integer;
begin
  Result := qryGen.RecordCount;
end;

procedure TDataSetIDataSetWrapper.SetActive(const Value: Boolean);
begin
  qryGen.Active := Value;
end;

procedure TDataSetIDataSetWrapper.SetSQL(const strSql: string);
begin
end;


end.
