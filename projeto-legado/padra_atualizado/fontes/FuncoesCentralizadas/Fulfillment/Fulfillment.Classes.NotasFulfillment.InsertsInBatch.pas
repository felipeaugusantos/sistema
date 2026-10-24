unit Fulfillment.Classes.NotasFulfillment.InsertsInBatch;

interface

uses
  System.SysUtils, System.StrUtils, System.Variants, Uni, Data.DB,
  untFuncoesSimples, System.Generics.Collections;

type
  {Exemplo insert em batch: INSERT INTO tbl_name (a,b,c) VALUES (1,2,3), (4,5,6), (7,8,9)}

  TInsertsInBatchNFEIMP = class
  private
    FDicCampos: TDictionary<String,String>;
    FCamposDisponiveis: TArray<String>;
    FCommand : TUniQuery;
    FRows    : TArray<String>;

    function HeadInsertInto: String;
    function ParseValue(const AValue: Variant): String;
    procedure CheckFields;
    procedure ClearDictionary;
  public
    procedure AddValue(const AField: String; const AValue: Variant);
    procedure AddCommand;
    procedure Clear;
    function IsEmpty: Boolean;
    function ExecSQL: Boolean;
    function FindKey(const AChaAce, AStatus: String): Boolean;

    constructor New;
    destructor Destroy; override;
  end;

const
  ARR_CAMPOS_TABELA: Array[0..29] Of String = (
    'NFE_ACESSO',
    'NFE_STATUS',
    'NFE_ARQXML',
    'NFE_CODEMP',
    'NFE_DTAEMI',
    'NFE_HRAEMI',
    'NFE_IMPORT',
    'NFE_NUMDOC',
    'NFE_ESPDOC',
    'NFE_SERIE_',
    'NFE_NUMCCD',
    'NFE_NUMNSU',
    'NFE_NUMPOK',
    'NFE_CODEXT',
    'NFE_INVOIC',
    'NFE_HUBMKP',
    'NFE_LIBDEV',
    'NFE_DOCBLO',
    'NFE_REFNFE',
    'NFE_TEMLOT',
    'NFE_DTAGRA',
    'NFE_HRAGRA',
    'NFE_LOGIST',
    'NFE_CLAFIS',
    'NFE_XTEXTO',
    'NFE_MOVFIS',
    'NFE_MOVEXT',
    'NFE_GERAJU',
    'NFE_GER_PD',
    'NFE_TXTMGL'
  );

implementation

{ TInsertsInBatchNFEIMP }

procedure TInsertsInBatchNFEIMP.AddCommand;
var
  LCampo, LCommand: String;
begin
  {ATENÇÃO: caso mude o formato do command, ajustar também o método FindKey}
  LCommand := EmptyStr;
  for LCampo in FCamposDisponiveis do
    LCommand := LCommand + FDicCampos[LCampo] + ',';

  SetLength(FRows, Length(FRows) +1);
  FRows[High(FRows)] := '('+ LCommand.TrimRight([',']) +')';

  ClearDictionary;
end;

procedure TInsertsInBatchNFEIMP.AddValue(const AField: String; const AValue: Variant);
begin
  if not MatchText(AField, FCamposDisponiveis) then
    Exit;

  FDicCampos.AddOrSetValue(AField.ToUpper, ParseValue(AValue));
end;

function TInsertsInBatchNFEIMP.ParseValue(const AValue: Variant): String;
begin
  if VarIsNull(AValue) then
    Exit('NULL');

  if VarIsStr(AValue) then
    Exit(QuotedStr(AValue));

  Result := VarToStr(AValue);
end;

function TInsertsInBatchNFEIMP.ExecSQL: Boolean;
var
  LCommand: String;
begin
  try
    LCommand := String.Join(',', FRows);

    FCommand.Close;
    FCommand.SQL.Clear;
    FCommand.SQL.Add(HeadInsertInto);
    FCommand.SQL.Add(LCommand);
    FCommand.ExecSQL;

    Result := True;
  except
    Raise;
  end;
end;

function TInsertsInBatchNFEIMP.FindKey(const AChaAce, AStatus: String): Boolean;
var
  LRow: String;
begin
  Result := False;
  for LRow in FRows do
  begin
    if LRow.StartsWith(Concat('(', QuotedStr(AChaAce), ',', QuotedStr(AStatus))) then
      Exit(True);
  end;
end;

procedure TInsertsInBatchNFEIMP.Clear;
begin
  SetLength(FRows, 0);
  ClearDictionary;
end;

function TInsertsInBatchNFEIMP.IsEmpty: Boolean;
begin
  Result := Length(FRows) = 0;
end;

constructor TInsertsInBatchNFEIMP.New;
begin
  FCommand := fCriaQuery;
  FDicCampos := TDictionary<String,String>.Create;

  CheckFields;
  Clear;
end;

destructor TInsertsInBatchNFEIMP.Destroy;
begin
  FreeAndNil(FCommand);
  FreeAndNil(FDicCampos);
  inherited;
end;

procedure TInsertsInBatchNFEIMP.ClearDictionary;
var
  LField: String;
begin
  FDicCampos.Clear;

  for LField in FCamposDisponiveis do
    FDicCampos.Add(LField, 'NULL');
end;

procedure TInsertsInBatchNFEIMP.CheckFields;
var
  LField: String;
begin
  SetLength(FCamposDisponiveis, 0);

  for LField in ARR_CAMPOS_TABELA do
    if fCampoExiste('NFEIMP', LField) then
    begin
      SetLength(FCamposDisponiveis, Length(FCamposDisponiveis) +1);
      FCamposDisponiveis[High(FCamposDisponiveis)] := LField;
    end;
end;

function TInsertsInBatchNFEIMP.HeadInsertInto: String;
begin
  Result := 'INSERT INTO NFEIMP( '+
            String.Join(',', FCamposDisponiveis) +
            ') VALUES ';
end;

end.
