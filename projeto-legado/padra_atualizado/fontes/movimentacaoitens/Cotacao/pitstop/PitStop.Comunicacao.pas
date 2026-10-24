unit PitStop.Comunicacao;

interface

uses
  System.SysUtils, Dialogs,  System.Classes,
  PitStop.Classes.EndPoint,
  PitStop.Classes.Base,
  Cotacao.ApiPrecos.BaseParam,
  Cotacao.ApiPrecos.ConstAndTypes,
  Winapi.Messages, Winapi.Windows;


  const WM_PIT_STOP_CONCLUIDO = WM_USER + 100;
  Type
  TFuncFaturaRedePitStop = function (ACodFor, AIncPcmGer, ANumCot: String; AStatusPitStopCotacao: TStatusPitStopCotacao): boolean of object;

  TRedePitStop = class(TRedePitStopBase)
  private
    ParamFornecedoresPitStop: TParamFornecedoresPitStop;

    procedure pTrataRetornoLista(AbstractParamApi: TBaseParamApi);
    procedure pTrataRetornoFornecedoresDisponiveis(AbstractParamApi: TBaseParamApi);
    procedure pTrataRetornoBuscaCotacao(AbstractParamApi: TBaseParamApi);
    procedure pTrataRetornoCancelaCotacao(AbstractParamApi: TBaseParamApi);

  public
    ApiFalha: String;
    constructor Create(ACNPJClientePitStop: String; AblnConsultaPitStop: Boolean = False);reintroduce;
    Destructor Destroy; override;
    function fRetProcessaLista(var AParamns: TParamLista): string;
    function fRetFornecedoresDiponiveis(var AParamns: TParamFornecedoresPitStop): String;
    function fRetFornecedorDiponivel(ACNPJ: String): Boolean;
    function fRetBuscaCotacao(var AParamns: TParamBuscaCotacao): Boolean;
    function fRetFaturaPedido(var AParamns: TParamLista): string;
    function fCancelaCotacao(var AParamns: TParamCancelaCotacao): string;


  End;


implementation

{ TRedePitStop }

constructor TRedePitStop.Create(ACNPJClientePitStop: String; AblnConsultaPitStop: Boolean = False);
begin
  inherited Create(AblnConsultaPitStop);
  ParamFornecedoresPitStop := TParamFornecedoresPitStop.Create;
  ParamFornecedoresPitStop.EmpresaCNPJ := ACNPJClientePitStop;

  fRetFornecedoresDiponiveis(ParamFornecedoresPitStop);

end;

destructor TRedePitStop.Destroy;
begin
  inherited;
  FreeAndNil(ParamFornecedoresPitStop)
end;

function TRedePitStop.fCancelaCotacao(var AParamns: TParamCancelaCotacao): string;
begin
  fExecute(trpiCancelaCotacao, TBaseParamApi(AParamns), pTrataRetornoCancelaCotacao, ApiFalha);
end;

function TRedePitStop.fRetBuscaCotacao(var AParamns: TParamBuscaCotacao): Boolean;
begin
  Result := True;
  fExecute(trpitBuscaCotacao, TBaseParamApi(AParamns), pTrataRetornoBuscaCotacao, ApiFalha);
end;

function TRedePitStop.fRetFaturaPedido(var AParamns: TParamLista): string;
begin
  fExecute(trpitLista, TBaseParamApi(AParamns), pTrataRetornoLista, ApiFalha);
end;

function TRedePitStop.fRetFornecedorDiponivel(ACNPJ: String): Boolean;
var i: integer;
begin
  Result := False;
  For i := 0 To High(ParamFornecedoresPitStop.CNPJFornecedores_Disponiveis) do
    If ParamFornecedoresPitStop.CNPJFornecedores_Disponiveis[i] = ACNPJ Then
    Begin
      Result := True;
      Break;
    End;
end;

function TRedePitStop.fRetFornecedoresDiponiveis(var AParamns: TParamFornecedoresPitStop): String;
begin
  fExecute(trpitFornecedores, TBaseParamApi(AParamns), pTrataRetornoFornecedoresDisponiveis, ApiFalha);
end;

function TRedePitStop.fRetProcessaLista(var AParamns: TParamLista): string;
begin
  fExecute(trpitLista, TBaseParamApi(AParamns), pTrataRetornoLista, ApiFalha);
end;


procedure TRedePitStop.pTrataRetornoBuscaCotacao(AbstractParamApi: TBaseParamApi);
var lstTeste: TStringList;
begin
  If Assigned(AbstractParamApi) Then
  begin
    If TParamBuscaCotacao(AbstractParamApi).Teste then
    begin
      lstTeste := TStringList.Create;
      try
        lstTeste.LoadFromFile('C:\Users\prgintegracao_34\Desktop\Teste PitStop\' + TParamBuscaCotacao(AbstractParamApi).pagina.Tostring + '.txt');
        AbstractParamApi.RetornoApi.Retorno :=  lstTeste.Text;
      finally
        freeAndNil(lstTeste);
      end;
    End
    Else
      AbstractParamApi.RetornoApi.Retorno :=  raRESTResponse.Content;
    TParamBuscaCotacao(AbstractParamApi).fProcessaRetono;
  End;

end;

procedure TRedePitStop.pTrataRetornoCancelaCotacao(
  AbstractParamApi: TBaseParamApi);
begin
  If Assigned(AbstractParamApi) Then
  begin
    AbstractParamApi.RetornoApi.Retorno :=  raRESTResponse.Content;
    TParamCancelaCotacao(AbstractParamApi).fProcessaRetono;
  End;
end;

procedure TRedePitStop.pTrataRetornoFornecedoresDisponiveis(
  AbstractParamApi: TBaseParamApi);
begin
  If Assigned(AbstractParamApi) Then
  begin
    AbstractParamApi.RetornoApi.Retorno :=  raRESTResponse.Content;
    TParamFornecedoresPitStop(AbstractParamApi).fProcessaRetono;
  End;

end;

procedure TRedePitStop.pTrataRetornoLista(AbstractParamApi: TBaseParamApi);
begin
  If Assigned(AbstractParamApi) Then
  begin
    AbstractParamApi.RetornoApi.Retorno := raRESTResponse.Content;
    AbstractParamApi.RetornoApi.Retorno := StringReplace(AbstractParamApi.RetornoApi.Retorno, '\n' , '',[rfReplaceAll]);
    AbstractParamApi.RetornoApi.Retorno := StringReplace(AbstractParamApi.RetornoApi.Retorno, '\' , '', [rfReplaceAll]);
    AbstractParamApi.RetornoApi.Retorno := StringReplace(AbstractParamApi.RetornoApi.Retorno, '"{  "data"' , '{  "data"', [rfReplaceAll]);
    AbstractParamApi.RetornoApi.Retorno := StringReplace(AbstractParamApi.RetornoApi.Retorno, '}"}' , '}}', [rfReplaceAll]);
    TParamLista(AbstractParamApi).fProcessaRetono;
  End;
end;


end.
