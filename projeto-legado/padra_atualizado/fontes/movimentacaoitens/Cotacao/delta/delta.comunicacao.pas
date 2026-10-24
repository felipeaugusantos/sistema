unit Delta.comunicacao;

interface

uses
  System.SysUtils, Dialogs,
  Delta.Classes.EndPoint,
  Delta.Classes.Base,
  Cotacao.ApiPrecos.BaseParam;

Type
  TRedeDelta = class(TRedeDeltaBase)
  private
    procedure pTrataRetornoConsultaEstoque(AbstractParamApi: TBaseParamApi);
  public
    constructor Create; override;
    function fConsultaEstoque(AParamns: TParamnsConsultaEstoque): Boolean;

End;

implementation

{ TRedeDelta }


constructor TRedeDelta.Create;
begin
  inherited;
end;


function TRedeDelta.fConsultaEstoque(AParamns: TParamnsConsultaEstoque): Boolean;
begin
  fExecute(AParamns, pTrataRetornoConsultaEstoque);
  Result := AParamns.RetornoApi.StatusCode = 200;
end;

procedure TRedeDelta.pTrataRetornoConsultaEstoque(AbstractParamApi: TBaseParamApi);
begin
  If Assigned(AbstractParamApi) Then
  begin
    AbstractParamApi.RetornoApi.Retorno :=  raRESTResponse.Content;
    TParamnsConsultaEstoque(AbstractParamApi).fProcessaRetono;
  End;
end;

end.

