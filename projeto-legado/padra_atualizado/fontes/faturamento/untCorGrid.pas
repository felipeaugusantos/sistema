unit untCorGrid;

interface

uses
  Uni, Vcl.Graphics, Vcl.ExtCtrls, Vcl.Dialogs, System.SysUtils;

type
  TCorGrid = class
  private
    FNomeFormulario: String;
    FNomeGrid: String;
    FColorDialog: TColorDialog;

    FQuery: TUniQuery;
  public
    constructor Create(ANomeFormulario: String; ANomeGrid: String);
    destructor Destroy; override;

    procedure Atualizar;

    function CarregarCorToStr(AIdentificador: String): String;
    function CarregarCor(AIdentificador: String): TColor; overload;
    function CarregarSeqCor(AIdentificador : String; ADefault : String):String;

    function AlterarCor(AIdentificador: String; ACor: TColor = clNone): TColor;
    procedure AlterarCorStr(AIdentificador: String; ACor: String);
    procedure AlterarSeqCor(AIdentificador : String; ASeqCor : String);
  end;

implementation

uses
  untFuncoesSimples;

{ TCorGrid }

function TCorGrid.CarregarCor(AIdentificador: String): TColor;
begin
  Result := StringToColor(CarregarCorToStr(AIdentificador));
end;

procedure TCorGrid.AlterarCorStr(AIdentificador, ACor: String);
begin
  AlterarCor(AIdentificador, StringToColor(ACor));
end;

procedure TCorGrid.AlterarSeqCor(AIdentificador, ASeqCor: String);
begin
  if FQuery.Locate('GRD_IDENTI', AIdentificador, []) then
  begin
    FQuery.Edit;
    FQuery.FieldByName('GRD_SEQCOR').AsString := ASeqCor;
    FQuery.Post;
  end
  else
  begin
    FQuery.Append;
    FQuery.FieldByName('GRD_FORMUL').AsString := FNomeFormulario;
    FQuery.FieldByName('GRD_GRID__').AsString := FNomeGrid;
    FQuery.FieldByName('GRD_IDENTI').AsString := AIdentificador;
    FQuery.FieldByName('GRD_SEQCOR').AsString := ASeqCor;
    FQuery.Post;
  end;
end;

procedure TCorGrid.Atualizar;
begin
  FQuery.Close;
  FQuery.Open;
end;

function TCorGrid.CarregarCorToStr(AIdentificador: String): String;
begin
  if FQuery.Locate('GRD_IDENTI', AIdentificador, []) then
    Result := FQuery.FieldByName('GRD_COR___').AsString
  else
    Result := ColorToString(clNone);
end;

function TCorGrid.CarregarSeqCor(AIdentificador: String; ADefault : String): String;
begin
  if FQuery.Locate('GRD_IDENTI', AIdentificador, []) then
  begin
    Result := FQuery.FieldByName('GRD_SEQCOR').AsString;

    if fEmptyStr(Result) then
      Result := ADefault;
  end
  else
    Result := ADefault;
end;

function TCorGrid.AlterarCor(AIdentificador: String; ACor: TColor = clNone): TColor;
begin
  if ACor = clNone then
    if not FColorDialog.Execute then
      Exit(clNone)
    else
      ACor := FColorDialog.Color;

  if FQuery.Locate('GRD_IDENTI', AIdentificador, []) then
  begin
    FQuery.Edit;
    FQuery.FieldByName('GRD_COR___').AsString := ColorToString(ACor);
    FQuery.Post;
  end
  else
  begin
    FQuery.Append;
    FQuery.FieldByName('GRD_FORMUL').AsString := FNomeFormulario;
    FQuery.FieldByName('GRD_GRID__').AsString := FNomeGrid;
    FQuery.FieldByName('GRD_IDENTI').AsString := AIdentificador;
    FQuery.FieldByName('GRD_COR___').AsString := ColorToString(ACor);
    FQuery.Post;
  end;

  Result := ACor;
end;

constructor TCorGrid.Create(ANomeFormulario: String; ANomeGrid: String);
begin
  FNomeFormulario := ANomeFormulario;
  FNomeGrid := ANomeGrid;

  FColorDialog := TColorDialog.Create(Nil);
  FQuery := fCriaQuery;

  FQuery.SQL.Add('SELECT *');
  FQuery.SQL.Add('  FROM GRDCOR');
  FQuery.SQL.Add(' WHERE GRD_FORMUL = :FORMUL');
  FQuery.SQL.Add('   AND GRD_GRID__ = :GRID__');

  FQuery.ParamByName('FORMUL').AsString := FNomeFormulario;
  FQuery.ParamByName('GRID__').AsString := FNomeGrid;
  FQuery.Open;
end;

destructor TCorGrid.Destroy;
begin
  FreeAndNil(FQuery);
  FreeAndNil(FColorDialog);
  inherited;
end;

end.
