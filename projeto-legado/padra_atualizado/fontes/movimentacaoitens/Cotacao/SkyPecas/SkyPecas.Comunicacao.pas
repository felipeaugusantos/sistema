unit SkyPecas.Comunicacao;

interface
uses
  System.SysUtils, Dialogs,  System.Classes,
  SkyPecas.Classes.EndPoint,
  SkyPecas.Classes.Base,
  Cotacao.ApiPrecos.BaseParam,
  Cotacao.ApiPrecos.ConstAndTypes,
  Winapi.Messages, Winapi.Windows;

  Type
  TRedeSkyPecas = class(TRedeSkyPecasBase)
  private
    FParamSkyPecas: TParamSkyAcesso;
    function fGetParamSkyPecas: TParamSkyAcesso;

    procedure pTrataRetLogin(AParamSkyPecas: TBaseParamApi);
    procedure pTrataBuscaPrecoProduto(AParamSkyConsultaProduto: TBaseParamApi);
  public
    constructor Create;reintroduce;
    Destructor Destroy; override;
    function fLogin: boolean;
    function fBuscaPrecoProduto(ParamSkyConsultaProduto: TParamSkyConsultaProduto): Boolean;
    property ParamSkyPecas: TParamSkyAcesso read fGetParamSkyPecas;

  End;

implementation



{ TRedeSkyPecas }

constructor TRedeSkyPecas.Create;
begin
  inherited;
  FParamSkyPecas := TParamSkyAcesso.Create;
end;

destructor TRedeSkyPecas.Destroy;
begin
  FreeAndNil(FParamSkyPecas);
  inherited;
end;


function TRedeSkyPecas.fBuscaPrecoProduto(
  ParamSkyConsultaProduto: TParamSkyConsultaProduto): Boolean;
var ApiFalha: String;
begin
  Self.Token := FParamSkyPecas.SkyPecasConexao.token;
  fExecute(trSkyBuscaPreco, TBaseParamApi(ParamSkyConsultaProduto), pTrataBuscaPrecoProduto, ApiFalha);
  Result := ParamSkyConsultaProduto.RetornoApi.Sucess;
end;

function TRedeSkyPecas.fLogin: Boolean;
var ApiFalha: string;
begin
  fExecute(trSkyToken, TBaseParamApi(FParamSkyPecas), pTrataRetLogin, ApiFalha);
  Result := FParamSkyPecas.RetornoApi.Sucess;
end;

function TRedeSkyPecas.fGetParamSkyPecas: TParamSkyAcesso;
begin
  Result := FParamSkyPecas;
End;

procedure TRedeSkyPecas.pTrataBuscaPrecoProduto(AParamSkyConsultaProduto: TBaseParamApi);
begin
  TParamSkyConsultaProduto(AParamSkyConsultaProduto).fProcessaRetono;
end;

procedure TRedeSkyPecas.pTrataRetLogin(AParamSkyPecas: TBaseParamApi);
begin
  If Assigned(AParamSkyPecas) Then
    TParamSkyAcesso(AParamSkyPecas).fProcessaRetono;
end;

end.
