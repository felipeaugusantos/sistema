unit untEstadoTela;

interface

uses
  Classes,
  Rest.Json,
  System.json,
  TypInfo,
  Uni,
  Data.DB,
  SysUtils,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  System.Generics.Collections,

  untFuncoesSimples;

Type
  TEstadoTela = class
    private
      FNomeFormulario    : String;
      FCodigoOperador    : String;
      FQuery             : TUniQuery;
      FComponentesSalvar : TDictionary<String,TComponent>;

      procedure pAddComponenteJson(objComponente: TComponent; var jaComponentes: TJSONArray);

    public
      property strNomeFormulario : String  read FNomeFormulario write FNomeFormulario;
      property strCodigoOperador : String read FCodigoOperador write FCodigoOperador;

      procedure pGetEstadoTela;
      procedure pSetEstadoTela;
      procedure pAddComponenteSalvar(objComponente : TComponent);

      constructor Create(strNomeFormulario, strCodigoOperador : String);
      destructor Destroy; override;

  End;

implementation

{ TEstadoTela }


constructor TEstadoTela.Create(strNomeFormulario, strCodigoOperador : String);
begin
  FNomeFormulario := strNomeFormulario;
  FCodigoOperador := strCodigoOperador;

  FComponentesSalvar := TDictionary<String,Tcomponent>.Create();
  FQuery := fCriaQuery(nil);
end;

destructor TEstadoTela.Destroy;
begin
  FreeAndNil(FQuery);
  FreeAndNil(FComponentesSalvar);
  inherited;
end;


procedure TEstadoTela.pGetEstadoTela;
var
  jaComponentes : TJSONArray;
  jvComponente  : TJSONValue;
  joComponente  : TJSONObject;
  objComponente : TComponent;
begin

  FQuery.SQL.Text := 'SELECT EST_JSON__ FROM ESTTEL WHERE EST_NOMFRM = :NOMFRM AND EST_CODOPE = :CODOPE';
  FQuery.ParamByName('NOMFRM').AsString := FNomeFormulario;
  FQuery.ParamByName('CODOPE').AsString := FCodigoOperador;
  FQuery.Open;

  if not FQuery.isEmpty then
  begin
    jaComponentes := TJSONObject.ParseJSONValue( FQuery.FieldByName('EST_JSON__').ASString ) as TJSONArray;

    try
      for jvComponente in jaComponentes do
      begin
        if (jvComponente is TJSONObject) then
        begin
          joComponente := (jvComponente as TJSONObject);
          FComponentesSalvar.TryGetValue((joComponente.GetValue('name') as TJSONString).Value, objComponente);
          if objComponente <> nil then
          begin
            if (objComponente  is TCheckBox) then
              (objComponente  as TCheckBox).checked := (joComponente.GetValue('checked') as TJSONBool).AsBoolean;

            if (objComponente  is TEdit) then
              (objComponente  as TEdit).text := (joComponente.GetValue('text') as TJSONString).Value;

            if (objComponente  is TRadioGroup) then
              (objComponente  as TRadioGroup).ItemIndex := (joComponente.GetValue('itemIndex') as TJSONNumber).AsInt;

            if (objComponente  is TRadioButton) then
              (objComponente  as TRadioButton).checked := (joComponente.GetValue('checked') as TJSONBool).AsBoolean;
          end;
        end;
      end;
    finally
      FreeAndNil(jaComponentes);
    end;
  end;

end;

procedure TEstadoTela.pSetEstadoTela;
var
  jaComponentes : TJSONArray;
  objComponente : TPair<String, TComponent>;
begin
  jaComponentes := TJSONArray.Create;
  try

    for objComponente in (FComponentesSalvar) do
      pAddComponenteJson(objComponente.Value, jaComponentes);

    FQuery.SQL.Text := 'REPLACE INTO ESTTEL SET EST_CODOPE = :CODOPE, EST_NOMFRM = :NOMFRM,  EST_JSON__ = :JSON__';
    FQuery.ParamByName('NOMFRM').AsString := FNomeFormulario;
    FQuery.ParamByName('CODOPE').AsString := FCodigoOperador;
    FQuery.ParamByName('JSON__').AsString := jaComponentes.ToJSON;
    FQuery.ExecSQL;
  finally
    FreeAndNil(jaComponentes);
  end;
end;

procedure TEstadoTela.pAddComponenteSalvar(objComponente: TComponent);
begin
  FComponentesSalvar.Add(objComponente.Name, objComponente);
end;

procedure TEstadoTela.pAddComponenteJson(objComponente : TComponent; var jaComponentes : TJSONArray );
var
  joComponente  : TJSONObject;
begin
  joComponente := TJSONObject.Create;
  joComponente.AddPair(TJSONPair.Create('name', TJSONString.Create( objComponente.Name )));
  if (objComponente is TCheckBox) then
    joComponente.AddPair(TJSONPair.Create('checked', TJSONBool.Create( (objComponente as TCheckBox).Checked )));

  if (objComponente is TEdit) then
    joComponente.AddPair(TJSONPair.Create('text', TJSONString.Create( (objComponente as TEdit).Text )));

  if (objComponente is TRadioGroup) then
    joComponente.AddPair(TJSONPair.Create('itemIndex', TJSONNumber.Create( (objComponente as TRadioGroup).ItemIndex )));

  if (objComponente is TRadioButton) then
    joComponente.AddPair(TJSONPair.Create('checked', TJSONBool.Create( (objComponente as TRadioButton).Checked )));

  jaComponentes.Add(joComponente);
end;

end.

