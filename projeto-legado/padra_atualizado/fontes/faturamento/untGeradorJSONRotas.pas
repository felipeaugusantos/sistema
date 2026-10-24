unit untGeradorJSONRotas;

interface

uses
  System.JSON, System.Classes, System.SysUtils, System.IOUtils, System.StrUtils,
  System.Generics.Collections, TMSFNCMapsCommonTypes, untTypesSistema,
  TaEntregue.Romaneios.Interfaces, untFuncoesSimples, VCL.TMSFNCGeocoding,
  untWebBrowser, Principal.View.Interfaces;

type
  TGeradorJSONRotas = class(TObject)
  constructor Create;
  private
    geoLocalizacao: TTMSFNCGeocoding;

    function CriarObjetoRomaneio(Romaneio: IRomaneio = Nil): TJSONObject; overload;
    function CriarObjetoRomaneio(ACodigoEmpresa: String): TJSONObject; overload;
    function CriarTotalizadoresArray(ATotalizador: TTotalizaRotas): TJSONArray;
    function CriarTotalizador(const Tipo: string; const Distancia: Double; const Tempo: Integer): TJSONObject;
    function CriarRotaPlanejadaArray(Romaneio: IRomaneio; ADivergentes: TStringList): TJSONArray; overload;
    function CriarRotaPlanejadaArray(AEntregas: TStringList): TJSONArray; overload;
    function CriarPontoInicial(Coordenadas: String): TJSONObject;
    function CriarPontoFinal(Coordenadas: String): TJSONObject;
    function CriarPontoMotorista(Romaneio: IRomaneio): TJSONObject;
    procedure AdicionarDocumentosARota(Romaneio: IRomaneio; RotaArray: TJSONArray);
    procedure AdicionarEntregasDivergentes(ADivergentes: TStringList; RotaArray: TJSONArray);
    procedure AdicionarEntregas(AEntregas: TStringList; RotaArray: TJSONArray);
    function CriarRotaEfetuadaArray(Romaneio: IRomaneio): TJSONArray;
    function CriarPonto(Tipo, Coordenadas: string; Ordem: Integer; Endereco: string;
                        Cliente: string = ''; DataEntrega: TDateTime = 0): TJSONObject;
    function CriarCoordenada(const Coordenada: string; const DataHora: TDateTime): TJSONObject;
    function FormatarEndereco(Endereco: IEnderecoEntrega): string;
    function StrToCoordinate(ACoordenada: String): TTMSFNCMapsCoordinateRec;
  public
    destructor Destroy; override;
    function GerarArquivoJSON(Romaneio: IRomaneio; ADivergentes: TStringList; ATotalizador: TTotalizaRotas): string; overload;
    function GerarArquivoJSON(AEntregas: TStringList; ATotalizador: TTotalizaRotas; ACodigoEmpresa: String): string; overload;
    function StatusToStr(Status: IStatus): String;
  end;

procedure BrowserNavigateOnAutcom(strURL: String);

implementation

{ TGeradorJSONRotas }

function TGeradorJSONRotas.GerarArquivoJSON(Romaneio: IRomaneio; ADivergentes: TStringList; ATotalizador: TTotalizaRotas): string;
var
  JSONArray: TJSONArray;
  JSONObject: TJSONObject;
begin
  JSONArray := TJSONArray.Create;
  try
    JSONObject := CriarObjetoRomaneio(Romaneio);
    JSONObject.AddPair('totalizadores', CriarTotalizadoresArray(ATotalizador));
    JSONObject.AddPair('pontosEntrega', CriarRotaPlanejadaArray(Romaneio, ADivergentes));

    if (Romaneio.Rastreamentos.Count > 0) then
      JSONObject.AddPair('rotaEfetuada', CriarRotaEfetuadaArray(Romaneio));

    JSONArray.AddElement(JSONObject);

    Result := JSONArray.ToString;
    
    //TFile.WriteAllText('C:\Users\prgintegracao_22\Documents\Autpas\Maps Server\JSON_TESTE.txt', JSONArray.ToString);
  finally
    JSONArray.Free;
  end;
end;

function TGeradorJSONRotas.StatusToStr(Status: IStatus): String;
begin
  case status of
    rmFinalizado  : Result := 'Finalizada';
    rmNaoIniciado : Result := 'NaoIniciada';
    rmACaminho    : Result := 'EmAndamento';
    rmNaoEntregue : Result := 'NaoEntregue';
    rmTemPendencia: Result := 'TemPendencia';
  end;
end;

function TGeradorJSONRotas.StrToCoordinate(
  ACoordenada: String): TTMSFNCMapsCoordinateRec;
Var
  lstCoordenadas: TStringList;
begin
  lstCoordenadas                 := TStringList.Create;
  lstCoordenadas.Delimiter       := ',';
  lstCoordenadas.StrictDelimiter := True;
  lstCoordenadas.DelimitedText   := ACoordenada;

  Result.Latitude  := StrToFloat(ReplaceStr(lstCoordenadas[0],'.',','));
  Result.Longitude := StrToFloat(ReplaceStr(lstCoordenadas[1],'.',','));
end;

function TGeradorJSONRotas.CriarObjetoRomaneio(Romaneio: IRomaneio = Nil): TJSONObject;
begin
  Result := TJSONObject.Create;

  If Assigned(Romaneio) Then
  Begin
    Result.AddPair('CNPJ'    , fRetCNPJEmpresa(Romaneio.EmpresaRomaneio));
    Result.AddPair('romaneio', Romaneio.NumeroRomaneio);
    Result.AddPair('empresa' , Romaneio.EmpresaRomaneio);
  End
  Else
  Begin
    Result.AddPair('CNPJ'    , '');
    Result.AddPair('romaneio', '');
    Result.AddPair('empresa' , '');
  End;
end;

function TGeradorJSONRotas.CriarTotalizadoresArray(ATotalizador: TTotalizaRotas): TJSONArray;
begin
  Result := TJSONArray.Create;
  Result.AddElement(CriarTotalizador('Planejada', ATotalizador.fltDistanciaPlanejada, ATotalizador.intTempoPlanejado));
  Result.AddElement(CriarTotalizador('Efetuada', ATotalizador.fltDistanciaEfetuada, ATotalizador.intTempoEfetuada));
end;

destructor TGeradorJSONRotas.Destroy;
begin
  If Assigned(geoLocalizacao) Then
    FreeAndNil(geoLocalizacao);
  inherited;
end;

function TGeradorJSONRotas.CriarTotalizador(const Tipo: string; const Distancia: Double; const Tempo: Integer): TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('tipo', Tipo);
  Result.AddPair('distancia', FormatFloat('#,##0.00', Distancia) + ' km');
  Result.AddPair('tempo', fRetTempo(Tempo));
end;

function TGeradorJSONRotas.CriarRotaPlanejadaArray(Romaneio: IRomaneio; ADivergentes: TStringList): TJSONArray;
begin
  Result := TJSONArray.Create;

  If Assigned(Romaneio.PontoPartida) Then
    Result.AddElement(CriarPontoInicial(Romaneio.PontoPartida.Coordenadas));

  AdicionarDocumentosARota(Romaneio, Result);
  AdicionarEntregasDivergentes(ADivergentes, Result);

  If Assigned(Romaneio.PontoChegada) Then
    Result.AddElement(CriarPontoFinal(Romaneio.PontoChegada.Coordenadas));

  Result.AddElement(CriarPontoMotorista(Romaneio));
end;

function TGeradorJSONRotas.CriarPontoInicial(Coordenadas: String): TJSONObject;
begin
  Result := nil;
  if Not Coordenadas.IsEmpty then
    Result := CriarPonto('Partida', Coordenadas, 0,
                         geolocalizacao.GetReverseGeocodingSync(StrToCoordinate(Coordenadas)), '', 0);
end;

function TGeradorJSONRotas.CriarPontoFinal(Coordenadas: String): TJSONObject;
begin
  Result := nil;
  if Not Coordenadas.IsEmpty then
    Result := CriarPonto('Chegada', Coordenadas, 100,
                         geolocalizacao.GetReverseGeocodingSync(StrToCoordinate(Coordenadas)));
end;

function TGeradorJSONRotas.CriarPontoMotorista(Romaneio: IRomaneio): TJSONObject;
begin
  Result := nil;
  if Assigned(Romaneio.PontoMotorista) then
    Result := CriarPonto('Motorista', Romaneio.PontoMotorista.Coordenadas, 101,
                         geolocalizacao.GetReverseGeocodingSync(StrToCoordinate(Romaneio.PontoMotorista.Coordenadas)));
end;

function TGeradorJSONRotas.CriarPonto(Tipo, Coordenadas: string; Ordem: Integer; Endereco: string;
                                      Cliente: string = ''; DataEntrega: TDateTime = 0): TJSONObject;
var
  JSONCoord: TJSONArray;
  MapsCoordinate: TTMSFNCMapsCoordinateRec;
begin
  Result := TJSONObject.Create;
  Result.AddPair('ordem', TJSONNumber.Create(Ordem));
  Result.AddPair('tipo', Tipo);
  Result.AddPair('endereco', Endereco);

  if Cliente <> '' then
    Result.AddPair('cliente', Cliente);

  if DataEntrega <> 0 then
    Result.AddPair('dataEntrega', DateTimeToStr(DataEntrega));

  JSONCoord := TJSONArray.Create;
  if Coordenadas.IsEmpty then
  begin
    MapsCoordinate := geolocalizacao.GetGeocodingSync(endereco);
    JSONCoord.Add(MapsCoordinate.Latitude);
    JSONCoord.Add(MapsCoordinate.Longitude);
  end
  else
  begin
    JSONCoord.Add(StrToCoordinate(Coordenadas).Latitude);
    JSONCoord.Add(StrToCoordinate(Coordenadas).Longitude);
  end;

  Result.AddPair('coordenada', JSONCoord);
end;

constructor TGeradorJSONRotas.Create;
begin
  geoLocalizacao := TTMSFNCGeocoding.Create;
  geoLocalizacao.APIKey := fCfgSis('KEYMDP', varString);
end;

function TGeradorJSONRotas.CriarCoordenada(const Coordenada: string; const DataHora: TDateTime): TJSONObject;
var
  JSONCoord: TJSONArray;
begin
  Result := TJSONObject.Create;
  Result.AddPair('datahora', DateTimeToStr(dataHora));

  JSONCoord := TJSONArray.Create;
  JSONCoord.Add(StrToCoordinate(Coordenada).Latitude);
  JSONCoord.Add(StrToCoordinate(Coordenada).Longitude);

  Result.AddPair('coordenada', JSONCoord);
end;

function TGeradorJSONRotas.CriarObjetoRomaneio(ACodigoEmpresa: String): TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('CNPJ'    , fRetCNPJEmpresa(ACodigoEmpresa));
  Result.AddPair('empresa' , ACodigoEmpresa);
end;

function TGeradorJSONRotas.FormatarEndereco(Endereco: IEnderecoEntrega): string;
begin
  Result := Endereco.Endereco + ' - ' + Endereco.Bairro + ', ' + Endereco.Cidade + ' - ' + Endereco.Uf + ', ' + Endereco.Cep;
end;

function TGeradorJSONRotas.GerarArquivoJSON(AEntregas: TStringList; ATotalizador: TTotalizaRotas; ACodigoEmpresa: String): string;
var
  JSONArray: TJSONArray;
  JSONObject: TJSONObject;
begin
  JSONArray := TJSONArray.Create;
  try
    JSONObject := CriarObjetoRomaneio(ACodigoEmpresa);
    JSONObject.AddPair('totalizadores', CriarTotalizadoresArray(ATotalizador));
    JSONObject.AddPair('pontosEntrega', CriarRotaPlanejadaArray(AEntregas));
    JSONArray.AddElement(JSONObject);

    Result := JSONArray.ToString;

    //TFile.WriteAllText(FileName, JSONArray.ToString);
  finally
    JSONArray.Free;
  end;
end;

procedure TGeradorJSONRotas.AdicionarDocumentosARota(Romaneio: IRomaneio; RotaArray: TJSONArray);
var
  Documento  : IDocumento;
  Coordenada : String;
begin
  for Documento in Romaneio.Documentos do
  begin
    Coordenada := Documento.EnderecoEntrega.Coordenadas;
    If (Coordenada.IsEmpty) And (Documento.EspecieDocumento = 'OX') Then
      If Assigned(Romaneio.PontoChegada) Then
        Coordenada := Romaneio.PontoChegada.Coordenadas;

    If Not Coordenada.IsEmpty Then
      RotaArray.AddElement(
        CriarPonto(
          StatusToStr(Documento.StatusDocumento),
          Coordenada,
          Documento.RotaOrdem.ToInteger,
          FormatarEndereco(Documento.EnderecoEntrega),
          Documento.Cliente.NomeCliente,
          Documento.DataHoraBaixaEntrega));
  end;
end;

procedure TGeradorJSONRotas.AdicionarEntregas(AEntregas: TStringList;
  RotaArray: TJSONArray);
var
  lstColunas: TStringList;
  i: Integer;
begin
  lstColunas := TStringList.Create;
  try
    lstColunas.Delimiter := '|';
    lstColunas.StrictDelimiter := True;

    for i := 0 to AEntregas.Count - 1 do
    begin
      lstColunas.DelimitedText := AEntregas[i];

      If (lstColunas[2] = 'Partida') Then
        RotaArray.AddElement(CriarPontoInicial(lstColunas[0]))

      Else If (lstColunas[2] = 'Chegada') Then
        RotaArray.AddElement(CriarPontoFinal(lstColunas[0]))

      Else
        RotaArray.AddElement(
          CriarPonto(
            lstColunas[2],
            lstColunas[0],
            lstColunas[3].ToInteger,
            lstColunas[1],
            lstColunas[5],
            StrToDateTime(lstColunas[6])));
    end;
  finally
    lstColunas.Free;
  end;
end;

procedure TGeradorJSONRotas.AdicionarEntregasDivergentes(ADivergentes: TStringList; RotaArray: TJSONArray);
var
  lstColunas: TStringList;
  i: Integer;
begin
  lstColunas := TStringList.Create;
  try
    lstColunas.Delimiter := '|';
    lstColunas.StrictDelimiter := True;

    for i := 0 to ADivergentes.Count - 1 do
    begin
      lstColunas.DelimitedText := ADivergentes[i];
      RotaArray.AddElement(
        CriarPonto(
          'Divergente',
          lstColunas[0],
          lstColunas[3].ToInteger,
          lstColunas[1].Replace('*** ', ''),
          lstColunas[5],
          StrToDateTime(lstColunas[6])));
    end;
  finally
    lstColunas.Free;
  end;
end;

procedure BrowserNavigateOnAutcom(strURL: String);
Var
  frmWebBrowser : TfrmWebBrowser;
Begin
  Try
    pCriarFormularios(TfrmWebBrowser, frmWebBrowser);
    try
      frmWebBrowser.Url := strURL;
      frmWebBrowser.ShowModal;
    finally
      pFreeAndNil(frmWebBrowser);
    end;
  Except
    On E: Exception do
      pErro(E.Message);
  End;
end;

function TGeradorJSONRotas.CriarRotaEfetuadaArray(Romaneio: IRomaneio): TJSONArray;
var
  i: Integer;
begin
  Result := TJSONArray.Create;
  for i := 0 to Romaneio.Rastreamentos.Count - 1 do
    Result.AddElement(CriarCoordenada(Romaneio.Rastreamentos[i].Coordenadas,
                                      Romaneio.Rastreamentos[i].DataHoraCoordenadas));
end;

function TGeradorJSONRotas.CriarRotaPlanejadaArray(AEntregas: TStringList): TJSONArray;
begin
  Result := TJSONArray.Create;
  AdicionarEntregas(AEntregas, Result);
end;

end.

