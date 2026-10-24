unit Principal.View.FMXVisualizarMapaGoogle;

interface

uses
  System.IOUtils, System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Layouts, FMX.TMSFNCTypes, FMX.TMSFNCUtils, FMX.TMSFNCGraphics, FMX.Objects,
  FMX.TMSFNCGraphicsTypes, FMX.TMSFNCCustomControl, FMX.TMSFNCWebBrowser,
  FMX.TMSFNCMaps, FMX.TMSFNCGoogleMaps, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.TMSFNCMapsCommonTypes, FMX.Edit, TaEntregue.Romaneios.Interfaces,
  FMX.TMSFNCCloudBase, System.StrUtils, System.ImageList,
  FMX.ImgList, Math, FMX.TMSFNCCustomComponent, FMX.TMSFNCRouteCalculator,
  FMX.TMSFNCDirections, System.DateUtils, FMX.TMSFNCGeocoding,
  Principal.View.Interfaces;

type
  TfmxVisualizarMapaGoogle = class(TForm)
    recFundoCinza: TRectangle;
    Layout1: TLayout;
    layPrincipal: TLayout;
    layTopo: TLayout;
    recFundoTopo: TRectangle;
    linRodape: TLine;
    lblTitulo: TLabel;
    imgVoltar: TImage;
    tmrRotas: TTimer;
    imgLegendas: TImageList;
    layMaps: TLayout;
    imgExpandir: TImage;
    recFundoRotas: TLayout;
    layFiltros: TLayout;
    cbxEmAndamento: TCheckBox;
    cbxFinalizada: TCheckBox;
    cbxNaoIniciada: TCheckBox;
    imgEmAndamento: TImage;
    imgFinalizada: TImage;
    imgNaoIniciada: TImage;
    recRotaPlanejada: TRectangle;
    lblTempoRotaPlanejada: TLabel;
    lblDistanciaRotaPlanejada: TLabel;
    recRotaEfetuada: TRectangle;
    lblTempoRotaEfetuada: TLabel;
    lblDistanciaRotaEfetuada: TLabel;
    patRotaPlanejada: TPath;
    patRotaEfetuada: TPath;
    linMeio: TLine;
    linEsquerda: TLine;
    routeCalculator: TTMSFNCRouteCalculator;
    filtrarRotas: TTMSFNCRouteCalculator;
    aniAguarde: TAniIndicator;
    lblCarregando: TLabel;
    layCarregando: TLayout;
    geolocalizacao: TTMSFNCGeocoding;
    pgbMaps: TProgressBar;
    googleMaps: TTMSFNCGoogleMaps;
    lblpgbMaps: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure imgVoltarClick(Sender: TObject);
    procedure tmrRotasTimer(Sender: TObject);
    procedure cbxFinalizadaChange(Sender: TObject);
    procedure cbxEmAndamentoChange(Sender: TObject);
    procedure cbxNaoIniciadaChange(Sender: TObject);
    procedure googleMapsMarkerDblClick(Sender: TObject;
      AEventData: TTMSFNCMapsEventData);
    procedure imgExpandirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure routeCalculatorCalculateRoute(Sender: TObject;
      const ARoute: TTMSFNCRouteCalculatorRoute);
    procedure filtrarRotasCalculateRoute(Sender: TObject;
      const ARoute: TTMSFNCRouteCalculatorRoute);
    procedure googleMapsMapInitialized(Sender: TObject);
    procedure cbxVerRotaExataChange(Sender: TObject);
    procedure cbxVerRotaExataExit(Sender: TObject);
    procedure googleMapsMarkerMouseEnter(Sender: TObject;
      AEventData: TTMSFNCMapsEventData);
    procedure googleMapsMarkerMouseLeave(Sender: TObject;
      AEventData: TTMSFNCMapsEventData);
    procedure googleMapsGetZoomLevel(Sender: TObject; AZoomLevel: Double);
    procedure lblTituloDblClick(Sender: TObject);
  private
    { Private declarations }
    lstCoordenadasEfetuadas: TStringList;

    WayPoints: TTMSFNCMapsCoordinateRecArray;

    rotasSolicitadas,
    rotasPlotadas, rotasFiltradas : integer;

    sumMinPlanejada,
    sumSegEfetuada : Integer;

    sumkmPlanejada,
    sumMetEfetuada  : Double;

    Origem, Destino: String;

    SalvarGPX : Boolean;

    procedure CarregarMarcadores;
    procedure CarregarRotaPlanejada(ACoordenadas : TTMSFNCMapsCoordinateRecArray);
    procedure CarregarRotaEfetuada;
    procedure CalcularRastreamento;
    procedure CarregarDivergentes;

    function StrToCoordinate(ACoordenada: String): TTMSFNCMapsCoordinateRec;

    function CoordenadasPreenchidas: Boolean;
    function FinalizouCalculoRotaPlanejada: Boolean;
    function FinalizouCalculoRotaEfetuada: Boolean;
    procedure AdicionarPontos(strCoordenada, strEndereco, strStatus, strOrdem,
      strCep, strCliente: String; dtaEntrega: TDatetime);
    procedure AdicionarPontoDePartida;
    procedure AdicionarPontoDeChegada;
    procedure AdicionarPontoMotorista;
    function QtdePontosValidosParaRotas: Boolean;
    Function DistanciaMaiorQue100Metros(AStartCoordinate, AEndCoordinate: TTMSFNCMapsCoordinateRec): Boolean;
    Function RotaAutorizada(AStartCoordinate, AEndCoordinate: TTMSFNCMapsCoordinateRec; Index, QtdePontos: Integer): Boolean;
    function TemRastreamento: Boolean;
    procedure AddCoordenada(ARoute: TTMSFNCRouteCalculatorRoute; ATestarJaExiste: Boolean = True);
    procedure AniCarregando(habilitar: Boolean);

    procedure SalvarDadosGPX;
    procedure ExportaRotasGPX;
    procedure ExportaRotaExata;
    procedure ExportaRotaAproximada;
    function RotaExportada(tpRota: ITipoRota): boolean;

    procedure CarregarDadosGPX(tpRota: ITipoRota);
    procedure ImportaRotasGPX(tpRota: ITipoRota);

    procedure FinalizaCarregamento;
    procedure PreencheInfoRotas(tpRota: ITipoRota; intTempo: integer; fltDistancia: double);

    procedure RotaAproximada;
    procedure AddTrecho(tpRota: ITipoRota; Coordenadas: TTMSFNCMapsCoordinateRecArray; intTempo: Integer);

    procedure RecarregaRotaEfetuada;
    function CorDaRota(tpRota : ITipoRota): TAlphaColor;

    procedure MostrarRotaAproximada;

    function TemRotaAproximadaGPX: Boolean;

    function NenhumaRotaGPXeRastreamentosPendentes: Boolean;

    procedure CarregarRotasPelaAPI;

    procedure MsgCarregando(msg: String);

    procedure FecharTela;

    procedure BarraCarregando(Value: Single);
  public
    { Public declarations }
    objFuncoes: IFuncoes;
    strNumRomLog : String;
    TaEntregue : ITaEntregue;
    Romaneio: IRomaneio;
    lstEndEntregas,
    lstDivergencias   : TStringList;

    procedure CarregarEnderecos;
  end;

var
  fmxVisualizarMapaGoogle: TfmxVisualizarMapaGoogle;

implementation

{$R *.fmx}


procedure TfmxVisualizarMapaGoogle.FinalizaCarregamento;
begin
  MsgCarregando('Finalizando carregamento das rotas...');
  routeCalculator.Active := False;
  googleMaps.GetZoomLevel;
end;

function TfmxVisualizarMapaGoogle.FinalizouCalculoRotaEfetuada: Boolean;
begin
  Result := rotasFiltradas >= (rotasSolicitadas * 2);
end;

function TfmxVisualizarMapaGoogle.FinalizouCalculoRotaPlanejada: Boolean;
begin
  Result := rotasPlotadas >= (rotasSolicitadas * 2);
end;

procedure TfmxVisualizarMapaGoogle.AddCoordenada(ARoute: TTMSFNCRouteCalculatorRoute;
  ATestarJaExiste: Boolean);
Var
  ItemlistO,
  Origem : String;
  Index: Integer;
Begin
  Origem    := ARoute.FirstSegment.StartCoordinate.Latitude.ToString().Replace(',','.') + ',' +
               ARoute.FirstSegment.StartCoordinate.Longitude.ToString().Replace(',','.');

  ItemListO := Copy(ARoute.ID, 1, 8) + '|' + Origem;

  If ATestarJaExiste Then
  Begin
    Index     := lstCoordenadasEfetuadas.IndexOf(ItemListO);
    If (Index <= -1) Then
      lstCoordenadasEfetuadas.Add(ItemListO);
  End
  Else
    lstCoordenadasEfetuadas.Add(ItemListO);
end;

procedure TfmxVisualizarMapaGoogle.AddTrecho(tpRota: ITipoRota; Coordenadas: TTMSFNCMapsCoordinateRecArray; intTempo: Integer);
Var
  polTrecho : TTMSFNCGoogleMapsPolyline;
begin
  googleMaps.BeginUpdate;

  polTrecho := googleMaps.AddPolyline(Coordenadas);
  polTrecho.StrokeColor := CorDaRota(tpRota);
  polTrecho.StrokeWidth := 11;
  polTrecho.DataString  := 'Aproximada';
  polTrecho.DataInteger := intTempo;

  googleMaps.EndUpdate;
end;

procedure TfmxVisualizarMapaGoogle.AdicionarPontoDeChegada;
Var
  m : TTMSFNCGoogleMapsMarker;
  endereco : String;
begin
  If Not Assigned(Romaneio) Then
    Exit;

  If Not Assigned(Romaneio.PontoChegada) Then
    Exit;

  BarraCarregando(1);

  endereco := geolocalizacao.GetReverseGeocodingSync(StrToCoordinate(Romaneio.PontoChegada.Coordenadas));

  TaEntregue.pGravaLogUsoGoogleMaps(strNumRomLog, 'Consulta Api Geocoding [Endereço Ponto de Chegada]');

  googleMaps.BeginUpdate;

  m             := googleMaps.Markers.Add;
  m.Latitude    := StrToCoordinate(Romaneio.PontoChegada.Coordenadas).Latitude;
  m.Longitude   := StrToCoordinate(Romaneio.PontoChegada.Coordenadas).Longitude;
  m.IconURL     := 'http://conhecimento.citelsoftware.com.br/blog/wp-content/uploads/2023/08/CD_32.png';
  m.Draggable   := False;
  m.Title       := '';
  m.Visible     := True;
  m.Clickable   := True;
  m.DataString  := endereco;

  SetLength(WayPoints, Length(WayPoints)+1);
  WayPoints[Length(WayPoints)- 1] := StrToCoordinate(Romaneio.PontoChegada.Coordenadas);

  googleMaps.EndUpdate;
end;

procedure TfmxVisualizarMapaGoogle.AdicionarPontoDePartida;
var
  marker  : TTMSFNCGoogleMapsMarker;
  endereco: String;
begin
  If Not Assigned(Romaneio) Then
    Exit;

  If Not Assigned(Romaneio.PontoPartida) Then
    Exit;

  BarraCarregando(1);

  endereco := geolocalizacao.GetReverseGeocodingSync(StrToCoordinate(Romaneio.PontoPartida.Coordenadas));

  TaEntregue.pGravaLogUsoGoogleMaps(strNumRomLog, 'Consulta Api Geocoding [Endereço Ponto de Partida]');

  googleMaps.BeginUpdate;

  marker             := googleMaps.Markers.Add;
  marker.Latitude    := StrToCoordinate(Romaneio.PontoPartida.Coordenadas).Latitude;
  marker.Longitude   := StrToCoordinate(Romaneio.PontoPartida.Coordenadas).Longitude;
  marker.Title       := '';
  marker.IconURL     := 'http://conhecimento.citelsoftware.com.br/blog/wp-content/uploads/2023/08/CD_32.png';
  marker.Visible     := True;
  marker.Clickable   := True;
  marker.DataString  := endereco;

  SetLength(WayPoints, Length(WayPoints)+1);
  WayPoints[Length(WayPoints)- 1] := StrToCoordinate(Romaneio.PontoPartida.Coordenadas);

  googleMaps.EndUpdate;
end;

procedure TfmxVisualizarMapaGoogle.AdicionarPontoMotorista;
Var
  m : TTMSFNCGoogleMapsMarker;
  endereco : String;
begin
  If Not Assigned(Romaneio) Then
    Exit;

  If Not Assigned(Romaneio.PontoMotorista) Then
    Exit;

  BarraCarregando(1);

  endereco := geolocalizacao.GetReverseGeocodingSync(StrToCoordinate(Romaneio.PontoMotorista.Coordenadas));

  TaEntregue.pGravaLogUsoGoogleMaps(strNumRomLog, 'Consulta Api Geocoding [Endereço Ponto do Motorista]');

  googleMaps.BeginUpdate;

  m             := googleMaps.Markers.Add;
  m.Latitude    := StrToCoordinate(Romaneio.PontoMotorista.Coordenadas).Latitude;
  m.Longitude   := StrToCoordinate(Romaneio.PontoMotorista.Coordenadas).Longitude;
  m.IconURL     := 'http://conhecimento.citelsoftware.com.br/blog/wp-content/uploads/2022/05/gps-pin.png';
  m.Draggable   := False;
  m.Title       := '';
  m.Visible     := True;
  m.Clickable   := True;
  m.DataString  := endereco;

  googleMaps.EndUpdate;
end;

procedure TfmxVisualizarMapaGoogle.AdicionarPontos(strCoordenada, strEndereco, strStatus, strOrdem,
      strCep, strCliente: String; dtaEntrega: TDatetime);
var
  MapsCoordinate : TTMSFNCMapsCoordinateRec;
  marker : TTMSFNCGoogleMapsMarker;
begin
  MapsCoordinate := StrToCoordinate(strCoordenada);

  googleMaps.BeginUpdate;

  marker             := googleMaps.Markers.Add;
  marker.Latitude    := MapsCoordinate.Latitude;
  marker.Longitude   := MapsCoordinate.Longitude;

  If (strEndereco.Contains('Partida')) Or (strEndereco.Contains('Chegada')) Then
    marker.IconURL   := 'http://conhecimento.citelsoftware.com.br/blog/wp-content/uploads/2023/08/CD_32.png'

  Else If (strEndereco.Contains('***')) Then
    marker.IconURL   := 'http://conhecimento.citelsoftware.com.br/blog/wp-content/uploads/2023/10/Divergente_' + FormatFloat('00', strOrdem.ToInteger) + '.png'

  Else
    marker.IconURL   := 'http://conhecimento.citelsoftware.com.br/blog/wp-content/uploads/2022/07/' + strStatus + '_' + FormatFloat('00', strOrdem.ToInteger) + '.png';

  marker.Visible     := True;
  marker.Clickable   := True;
  marker.DataInteger := 1;
  marker.Title       := '';
  marker.DataString  := strEndereco + '|' + strCliente + '|' + DateTimeToStr(dtaEntrega);

  SetLength(WayPoints, Length(WayPoints)+1);
  WayPoints[Length(WayPoints)- 1] := MapsCoordinate;

  googleMaps.EndUpdate;
end;

procedure TfmxVisualizarMapaGoogle.AniCarregando(habilitar: Boolean);
begin
  aniAguarde.Visible := habilitar;
  aniAguarde.Enabled := habilitar;
  lblTitulo.Visible  := Not habilitar;
  imgVoltar.Visible  := Not habilitar;
  imgExpandir.Visible:= Not habilitar;
  layFiltros.Visible := Not habilitar;
  {layFiltroRotas.Visible := Not habilitar;}
end;

procedure TfmxVisualizarMapaGoogle.BarraCarregando(Value: Single);
begin
  If Not (pgbMaps.Visible) Then
    pgbMaps.Visible := True;

  pgbMaps.Value   := pgbMaps.Value + 1;
  lblpgbMaps.Text := FormatFloat('#0',(pgbMaps.Value * 100)  / pgbMaps.Max) + '%';

  Application.ProcessMessages;
end;

procedure TfmxVisualizarMapaGoogle.CalcularRastreamento;
Var
  Origem,
  Destino: IRastreamento;
  Duracao: Integer;
  i      : Integer;
begin
  If Not TemRastreamento Then
  Begin
    FinalizaCarregamento;
    Exit;
  End;

  MsgCarregando('Calculando rota efetuada...');

  rotasSolicitadas := 0;
  lstCoordenadasEfetuadas.Clear;

  Origem := Romaneio.Rastreamentos[0];

  For i := 1 To (Romaneio.Rastreamentos.Count - 1) do
  Begin
    Destino := Romaneio.Rastreamentos[i];

    If RotaAutorizada(StrToCoordinate(Origem.Coordenadas),
                      StrToCoordinate(Destino.Coordenadas),
                      i, Romaneio.Rastreamentos.Count - 1) Then
    Begin
      Duracao := SecondsBetween(Origem.DataHoraCoordenadas, Destino.DataHoraCoordenadas);

      inc(rotasSolicitadas);

      filtrarRotas.CalculateRoute(StrToCoordinate(Origem.Coordenadas),
                                  StrToCoordinate(Destino.Coordenadas),
                                  nil, nil, 'Rota_' + FormatFloat('000', i) + '_' + Duracao.ToString());

      TaEntregue.pGravaLogUsoGoogleMaps(strNumRomLog, 'Consulta Api Directions [Filtrar Rotas]');

      Origem := Romaneio.Rastreamentos[i];
    End;
  End;
end;

procedure TfmxVisualizarMapaGoogle.CarregarEnderecos;
begin
  rotasPlotadas    := 0;
  rotasSolicitadas := 0;

  Origem  := EmptyStr;
  Destino := EmptyStr;

  AniCarregando(True);

  lblTitulo.Text := 'Carregando...';

  pgbMaps.Min   := 1;
  pgbMaps.Value := 0;
  pgbMaps.Max   := (lstEndEntregas.Count+2) +     {Pontos de Entrega + Pontos de partida e chegada}
                    Length(WayPoints); {Rotas Efetuadas}

  CarregarMarcadores;

  If Assigned(Romaneio) Then
  Begin
    pgbMaps.Max := pgbMaps.Max + Romaneio.Rastreamentos.Count; {Rotas Efetuadas}

    If (Romaneio.RotasGPX.Count > 0) Then
    Begin
      pgbMaps.Min   := 1;
      pgbMaps.Value := 0;
      pgbMaps.Max   := Romaneio.RotasGPX.Count;

      CarregarDadosGPX(tpAproximada);
      CarregarDadosGPX(tpPlanejada);
    End;

    if (NenhumaRotaGPXeRastreamentosPendentes) Then
      CarregarRotasPelaAPI
    else
      FinalizaCarregamento;
  End
  Else
    CarregarRotasPelaAPI;

  CarregarDivergentes;
end;

procedure TfmxVisualizarMapaGoogle.CarregarMarcadores;
Var
  lstColunas  : TStringList;
  i           : Integer;
begin
  MsgCarregando('Carregando pontos de entrega...');

  lstColunas                 := TStringList.Create;
  lstColunas.Delimiter       := '|';
  lstColunas.StrictDelimiter := True;

  AdicionarPontoDePartida;

  For i := 0 to lstEndEntregas.Count-1 Do
  Begin
    lstColunas.DelimitedText := lstEndEntregas[i];

    AdicionarPontos(lstColunas[0], lstColunas[1], lstColunas[2],
                    lstColunas[3], lstColunas[4], lstColunas[5],
                    StrToDateTime(lstColunas[6]));

    BarraCarregando(1);
  End;

  AdicionarPontoDeChegada;

  lstColunas.Free;
end;

procedure TfmxVisualizarMapaGoogle.CarregarRotaEfetuada;
begin
  {****************************************************************************}
  {* Quando o mapa é carregado pela tela de roteiro de entrega, deve carregar *}
  {* somente a rota planejada e parar aqui o carregamento.                    *}
  {****************************************************************************}
  If Not TemRastreamento Then
  Begin
    FinalizaCarregamento;
    Exit;
  End
  Else
    RotaAproximada;
end;

procedure TfmxVisualizarMapaGoogle.CarregarDadosGPX(tpRota: ITipoRota);
Var
  RotaGPX: IRotaGPX;
begin
  If Not Assigned(Romaneio) Then
    Exit;

  For RotaGPX In Romaneio.RotasGPX Do
  Begin
    If (RotaGPX.TipoRota = tpRota) Then
    Begin
      ImportaRotasGPX(tpRota);
      Exit;
    End;
  End;
end;

procedure TfmxVisualizarMapaGoogle.CarregarDivergentes;
Var
  lstColunas  : TStringList;
  i           : Integer;
begin
  MsgCarregando('Carregando pontos de entrega divergentes...');

  lstColunas                 := TStringList.Create;
  lstColunas.Delimiter       := '|';
  lstColunas.StrictDelimiter := True;

  For i := 0 to lstDivergencias.Count-1 Do
  Begin
    lstColunas.DelimitedText := lstDivergencias[i];

    AdicionarPontos(lstColunas[0],
                    lstColunas[1],
                    lstColunas[2],
                    lstColunas[3],
                    lstColunas[4],
                    lstColunas[5],
                    StrToDateTime(lstColunas[6]));

    BarraCarregando(1);
  End;

  lstColunas.Free;
end;

procedure TfmxVisualizarMapaGoogle.CarregarRotaPlanejada(ACoordenadas : TTMSFNCMapsCoordinateRecArray);
Var
  Origem,
  Destino: TTMSFNCMapsCoordinateRec;
  WayPoints: TTMSFNCMapsCoordinateRecArray;
  i, x     : Integer;
begin
  {***********************************************************************}
  {* Se a rota planejada já foi exportada anteriormente na RASGPX, então *}
  {* não irá carregar pela API do Google, mas sim pelo ImportaRotasGPX   *}
  {***********************************************************************}
  If RotaExportada(tpPlanejada) Then
  Begin
    {CalcularRastreamento;}
    CarregarRotaEfetuada;
    Exit;
  End;

  MsgCarregando('Carregando rota planejada...');

  x := 0;
  RouteCalculator.Active := True;

  googleMaps.RouteCalculator := routeCalculator;
  googleMaps.BeginUpdate;

  Origem := ACoordenadas[0];

  SetLength(WayPoints, 0);

  For i := 1 To Length(ACoordenadas)-1  do
  Begin
    Inc(x);

    BarraCarregando(1);

    If (x <= 23) And (i < (Length(ACoordenadas)-1)) Then
    Begin
      SetLength(WayPoints, Length(WayPoints)+1);
      WayPoints[Length(WayPoints)-1] := ACoordenadas[i];
    End
    Else
    Begin
      Destino := ACoordenadas[i];

      Try
        routeCalculator.CalculateRoute(Origem, Destino,
          procedure(const ARoute: TTMSFNCRouteCalculatorRoute)
          begin
//            sumKmPlanejada  := sumKmPlanejada + (ARoute.Distance / 1000);
//            sumMinPlanejada := sumMinPlanejada + Round(ARoute.Duration / 60);
//
//            PreencheInfoRotas(tpPlanejada, sumMinPlanejada, sumKmPlanejada);
          end,
          WayPoints, 'Planejada' + i.ToString());

        TaEntregue.pGravaLogUsoGoogleMaps(strNumRomLog, 'Consulta Api Directions [Rota Planejada]');
      Except
        On E: Exception Do
          Showmessage(E.Message);
      End;

      Origem := Destino;

      Inc(rotasSolicitadas);

      x := 0;
      SetLength(WayPoints, 0);
    End;
  End;

  googleMaps.EndUpdate;

  SalvarGPX := True;
end;

procedure TfmxVisualizarMapaGoogle.CarregarRotasPelaAPI;
begin
  imgExpandirClick(imgExpandir);

  If (QtdePontosValidosParaRotas) Then
    CarregarRotaPlanejada(WayPoints)
  Else
    FinalizaCarregamento;
end;

procedure TfmxVisualizarMapaGoogle.cbxEmAndamentoChange(Sender: TObject);
var
  m : TTMSFNCMapsMarker;
begin
  For m in googleMaps.Markers do
  Begin
    If (ContainsStr(m.IconURL, 'EmAndamento')) Then
      m.Visible := TCheckBox(Sender).IsChecked;
  End;

  if TCheckBox(Sender).IsChecked Then
  begin
    imgEmAndamento.Opacity     := 1;
    TCheckBox(Sender).Opacity := 1;
  end
  else
  begin
    imgEmAndamento.Opacity    := 0.6;
    TCheckBox(Sender).Opacity := 0.6;
  end;
end;

procedure TfmxVisualizarMapaGoogle.cbxFinalizadaChange(Sender: TObject);
var
  m : TTMSFNCMapsMarker;
begin
  For m in googleMaps.Markers do
  Begin
    If (ContainsStr(m.IconURL, 'Finalizada')) Then
      m.Visible := TCheckBox(Sender).IsChecked;
  End;

  if TCheckBox(Sender).IsChecked Then
  begin
    imgFinalizada.Opacity     := 1;
    TCheckBox(Sender).Opacity := 1;
  end
  else
  begin
    imgFinalizada.Opacity     := 0.6;
    TCheckBox(Sender).Opacity := 0.6;
  end;
end;

procedure TfmxVisualizarMapaGoogle.cbxNaoIniciadaChange(Sender: TObject);
var
  m : TTMSFNCMapsMarker;
begin
  For m in googleMaps.Markers do
  Begin
    If (ContainsStr(m.IconURL, 'NaoIniciada')) Then
      m.Visible := TCheckBox(Sender).IsChecked;
  End;

  if TCheckBox(Sender).IsChecked Then
  begin
    imgNaoIniciada.Opacity     := 1;
    TCheckBox(Sender).Opacity := 1;
  end
  else
  begin
    imgNaoIniciada.Opacity    := 0.6;
    TCheckBox(Sender).Opacity := 0.6;
  end;
end;

procedure TfmxVisualizarMapaGoogle.cbxVerRotaExataChange(Sender: TObject);
begin
  inherited;

  lblTitulo.Text    := 'Carregando...';

  PreencheInfoRotas(tpPlanejada, 0, 0);
  PreencheInfoRotas(tpEfetuada, 0, 0);

  SetLength(WayPoints, 0);

  lstCoordenadasEfetuadas.Clear;

  Origem  := EmptyStr;
  Destino := EmptyStr;

  rotasFiltradas   := 0;
  rotasSolicitadas := 0;
  rotasPlotadas    := 0;

  AniCarregando(True);

  sumSegEfetuada := 0;
  sumMetEfetuada  := 0;

  googleMaps.BeginUpdate;
  googleMaps.Polylines.Clear;
  routeCalculator.Routes.Clear;
  googleMaps.EndUpdate;

  Application.ProcessMessages;

  RecarregaRotaEfetuada;
end;

procedure TfmxVisualizarMapaGoogle.cbxVerRotaExataExit(Sender: TObject);
begin
  CalcularRastreamento;
end;

function TfmxVisualizarMapaGoogle.CoordenadasPreenchidas: Boolean;
Var
  LEndEntregas: Integer;
begin
  LEndEntregas := lstEndEntregas.Count;

  {* Se existir rastreamento preenchido, adicionar ponto de partida do motorista *}
  If (TemRastreamento) Then
    Inc(LEndEntregas);

  Result := googleMaps.Markers.Count = LEndEntregas;
end;

function TfmxVisualizarMapaGoogle.CorDaRota(tpRota: ITipoRota): TAlphaColor;
begin
  Result := TAlphaColorRec.Null;

  Case tpRota Of
    tpPlanejada  : Result := TAlphaColor($FFBCBCC0);
    tpEfetuada,
    tpAproximada : Result := TAlphaColor($FF3265CB);
  End;
end;

Function TfmxVisualizarMapaGoogle.DistanciaMaiorQue100Metros(AStartCoordinate, AEndCoordinate: TTMSFNCMapsCoordinateRec): Boolean;
Var
  Distancia: Double;
begin
  Distancia := MeasureDistance(AStartCoordinate, AEndCoordinate);

  Result := Distancia > 100;
end;

procedure TfmxVisualizarMapaGoogle.ExportaRotaAproximada;
Var
  x,y: Integer;
  hdr, ftr : String;
  d, t : Char;
  sl : TStringList;
begin
  hdr :=
    '<?xml version="1.0"?>'+
    '<gpx xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" '+
    'xsi:schemaLocation="http://www.topografix.com/GPX/1/1 http://www.topografix.com/GPX/1/1/gpx.xsd" version="1.1" creator="TMS FNC Maps" xmlns="http://www.topografix.com/GPX/1/1">'+
    '<metadata>'+
    '<author>'+
    '<name>%s</name>'+
    '<link href="%s" />'+
    '</author>'+
    '</metadata>'+
    '<trk>'+
    '<name>%s</name>'+
    '<type>%s</type>'+
    '<trkseg>';

  ftr :=
    '</trkseg>'+
    '</trk>'+
    '</gpx>';

  sl := TStringList.Create;

  try
    sl.Add(hdr);

    t := FormatSettings.ThousandSeparator;
    d := FormatSettings.DecimalSeparator;

    FormatSettings.DecimalSeparator := '.';
    FormatSettings.ThousandSeparator := ',';

    For x := 0 To googleMaps.Polylines.Count - 1 Do
    Begin
      BarraCarregando(1);

      If (googleMaps.Polylines[x].StrokeColor = CorDaRota(tpAproximada)) Then
        for y := 0 to Length(googleMaps.Polylines[x].Coordinates.ToArray) - 1 do
          sl.Add(Format('<trkpt lat="%.7f" lon="%.7f" />', [googleMaps.Polylines[x].Coordinates[y].Latitude,
                                                            googleMaps.Polylines[x].Coordinates[y].Longitude]));

    End;

    FormatSettings.ThousandSeparator := t;
    FormatSettings.DecimalSeparator := d;

    sl.Add(ftr);

  finally
    Romaneio.ExportarRotaGPX(tpAproximada, sl.Text, lblTempoRotaEfetuada.Tag, lblDistanciaRotaEfetuada.TagFloat);
    sl.Free;
  end;
end;

procedure TfmxVisualizarMapaGoogle.ExportaRotaExata;
Var
  i: Integer;
begin
  For i := 0 To routeCalculator.Routes.Count - 1 Do
  Begin
    BarraCarregando(1);

    If routeCalculator.Routes[i].ID.Contains('Planejada') Then
      Romaneio.ExportarRotaGPX(tpPlanejada,
                               googleMaps.SaveToGPXText(routeCalculator.Routes[i].Polyline),
                               lblTempoRotaPlanejada.Tag,
                               lblDistanciaRotaplanejada.TagFloat);

    If routeCalculator.Routes[i].ID.Contains('Efetuada') Then
      Romaneio.ExportarRotaGPX(tpEfetuada,
                               googleMaps.SaveToGPXText(routeCalculator.Routes[i].Polyline),
                               lblTempoRotaEfetuada.Tag,
                               lblDistanciaRotaEfetuada.TagFloat);
  End;
end;

procedure TfmxVisualizarMapaGoogle.ExportaRotasGPX;
begin
  MsgCarregando('Salvando rotas GPX...');

  pgbMaps.Min   := 0;
  pgbMaps.Value := 0;
  pgbMaps.Max   := routeCalculator.Routes.Count + googleMaps.Polylines.Count;

  ExportaRotaExata;
  ExportaRotaAproximada;
end;

procedure TfmxVisualizarMapaGoogle.FecharTela;
begin
  AniCarregando(True);
  SalvarDadosGPX;

  Sleep(100);

  Close;
end;

procedure TfmxVisualizarMapaGoogle.SalvarDadosGPX;
begin
  If SalvarGPX Then
    if Assigned(Romaneio) Then
      If NenhumaRotaGPXeRastreamentosPendentes Then
        ExportaRotasGPX;
end;

procedure TfmxVisualizarMapaGoogle.filtrarRotasCalculateRoute(Sender: TObject;
  const ARoute: TTMSFNCRouteCalculatorRoute);
Var
  Duracao : Integer;
begin
  Duracao := Copy(ARoute.ID, 10, 30).ToInteger;

  Inc(rotasFiltradas);

  If FinalizouCalculoRotaEfetuada Then
  Begin
    AddCoordenada(ARoute);
    lstCoordenadasEfetuadas.Sorted := True;
    CarregarRotaEfetuada;
  End
  Else
  Begin
    If (ARoute.Duration <= (Duracao * 1.1)) Then
      AddCoordenada(ARoute);
  End;
end;

procedure TfmxVisualizarMapaGoogle.FormCreate(Sender: TObject);
begin
  lblTempoRotaPlanejada.Tag  := 0;
  lblTempoRotaPlanejada.Text := '0s';

  lblDistanciaRotaPlanejada.TagFloat := 0;
  lblDistanciaRotaPlanejada.Text     := '0 km';

  lblTempoRotaEfetuada.Tag  := 0;
  lblTempoRotaEfetuada.Text := '0s';

  lblDistanciaRotaEfetuada.TagFloat := 0;
  lblDistanciaRotaEfetuada.Text     :=  '0 km';

  lstCoordenadasEfetuadas := TStringList.Create;

  rotasSolicitadas := 0;
  rotasPlotadas    := 0;

  sumMinPlanejada := 0;
  sumSegEfetuada  := 0;

  sumkmPlanejada  := 0;
  sumMetEfetuada   := 0;

  SalvarGPX := False;

  pgbMaps.Visible := False;
  pgbMaps.Min     := 0;
  pgbMaps.Value   := 0;
  pgbMaps.Max     := 0;

  lblTitulo.Text     := '';
  lblCarregando.Text := '';
end;

procedure TfmxVisualizarMapaGoogle.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  Case Key Of
    vkEscape :
    Begin
      If Not lblTitulo.Text.Contains('Carregando') Then
        FecharTela;
    End;
  End;
end;

procedure TfmxVisualizarMapaGoogle.googleMapsGetZoomLevel(Sender: TObject;
  AZoomLevel: Double);
begin
  pgbMaps.Visible := False;
  lblTitulo.Text := 'Mapa de Entregas';
  AniCarregando(False);
  Application.ProcessMessages;
end;

procedure TfmxVisualizarMapaGoogle.googleMapsMapInitialized(Sender: TObject);
begin
  AniCarregando(True);
  CarregarEnderecos;
end;

procedure TfmxVisualizarMapaGoogle.googleMapsMarkerDblClick(Sender: TObject;
  AEventData: TTMSFNCMapsEventData);
begin
  googleMaps.SetCenterCoordinate(AEventData.Marker.Coordinate.ToRec);
  googleMaps.SetZoomLevel(15);
end;

procedure TfmxVisualizarMapaGoogle.googleMapsMarkerMouseEnter(Sender: TObject;
  AEventData: TTMSFNCMapsEventData);
Var
  lstColunas  : TStringList;
  add, cli, ent : String;
begin
  If Not AEventData.Marker.DataString.IsEmpty Then
  Begin
    add := '';
    cli := '';
    ent := '';

    lstColunas                 := TStringList.Create;
    lstColunas.Delimiter       := '|';
    lstColunas.StrictDelimiter := True;
    lstColunas.DelimitedText   := AEventData.Marker.DataString;

    If lstColunas[0].Contains('Partida') Or lstColunas[0].Contains('Chegada') Then
    Begin
      add := '<b>' + lstColunas[0] + ' </b>'
    End
    Else
    Begin
      add := '<b>Endereço: </b>' + lstColunas[0].Replace('*** ','') + '<br>';

      If lstColunas.Count > 1 Then
      Begin
        cli := '<b>Cliente: </b>' + lstColunas[1] + '<br>';

        if StrToDatetime(lstColunas[2]) > 0 Then
          ent := '<b>Entregue em: </b>' + lstColunas[2] + '<br>';
      End;
    End;

    googleMaps.ShowPopup(AEventData.Marker.Coordinate.ToRec, add + cli + ent, 0, -32);

    lstColunas.Free;
  End;
end;

procedure TfmxVisualizarMapaGoogle.googleMapsMarkerMouseLeave(Sender: TObject;
  AEventData: TTMSFNCMapsEventData);
begin
  googleMaps.CloseAllPopups;
end;

procedure TfmxVisualizarMapaGoogle.imgExpandirClick(Sender: TObject);
begin
  googleMaps.BeginUpdate;
  googleMaps.ZoomToBounds(googleMaps.Markers.ToCoordinateArray);
  googleMaps.EndUpdate;

  Application.ProcessMessages;
end;

procedure TfmxVisualizarMapaGoogle.imgVoltarClick(Sender: TObject);
begin
  If Not lblTitulo.Text.Contains('Carregando') Then
    FecharTela;
end;

procedure TfmxVisualizarMapaGoogle.ImportaRotasGPX(tpRota: ITipoRota);
Var
  RotaGPX : IRotaGPX;
begin
  MsgCarregando('Importando rotas GPX...');

  googleMaps.BeginUpdate;

  For RotaGPX in Romaneio.RotasGPX Do
  Begin
    If (RotaGPX.TipoRota = tpRota) Then
    Begin
      BarraCarregando(1);

      Case RotaGPX.TipoRota Of
        tpPlanejada:
        Begin
          PreencheInfoRotas(tpPlanejada, RotaGPX.Tempo, RotaGPX.Distancia);
          googleMaps.LoadGPXFromText(String(RotaGPX.GPXFile), True, False, 5, CorDaRota(tpPlanejada));
        End;

        tpEfetuada:
        Begin
          sumSegEfetuada := sumSegEfetuada + RotaGPX.Tempo;
          sumMetEfetuada  := sumMetEfetuada + RotaGPX.Distancia;

          googleMaps.LoadGPXFromText(String(RotaGPX.GPXFile), True, False, 11, CorDaRota(tpEfetuada));
        End;

        tpAproximada:
        Begin
          sumSegEfetuada := sumSegEfetuada + RotaGPX.Tempo;
          sumMetEfetuada  := sumMetEfetuada + RotaGPX.Distancia;

          googleMaps.LoadGPXFromText(String(RotaGPX.GPXFile), True, False, 11, CorDaRota(tpAproximada));
        End;
      End;
    End;
  End;

  googleMaps.ZoomToBounds(googleMaps.Polylines.ToCoordinateArray);
  googleMaps.EndUpdate;

  If tpRota <> tpPlanejada Then
  Begin
    AdicionarPontoMotorista;
    PreencheInfoRotas(tpRota, sumSegEfetuada, sumMetEfetuada);
  End;
end;

procedure TfmxVisualizarMapaGoogle.lblTituloDblClick(Sender: TObject);
begin
//  If Assigned(Romaneio) Then
//  Begin
//    Romaneio.LimparRotasGPX;
//    Showmessage('Rotas GPX apagadas com sucesso');
//  End;
end;

procedure TfmxVisualizarMapaGoogle.MostrarRotaAproximada;
begin
  If TemRotaAproximadaGPX Then
    CarregarDadosGPX(tpAproximada)
  Else
  Begin
    Romaneio.RecalcularRotaEfetuada;
    RotaAproximada;
  End;
end;

procedure TfmxVisualizarMapaGoogle.MsgCarregando(msg: String);
begin
  lblCarregando.Text := 'Aguarde - ' + msg;
  Application.ProcessMessages;
end;

procedure TfmxVisualizarMapaGoogle.PreencheInfoRotas(tpRota: ITipoRota; intTempo: integer; fltDistancia: double);
begin
  Case tpRota Of
    tpPlanejada:
      Begin
        lblTempoRotaPlanejada.Tag  := intTempo;
        lblTempoRotaPlanejada.Text := objFuncoes.fRetTempo(intTempo);

        lblDistanciaRotaPlanejada.TagFloat := fltDistancia;
        lblDistanciaRotaPlanejada.Text     := FormatFloat('#,##0.00', fltDistancia) + ' km';

        lblTempoRotaPlanejada.FontColor := CorDaRota(tpRota);
        patRotaPlanejada.Fill.Color     := CorDaRota(tpRota);
      End;

    tpEfetuada,
    tpAproximada:
      Begin
        lblTempoRotaEfetuada.Tag  := intTempo;
        lblTempoRotaEfetuada.Text := objFuncoes.fRetTempo(intTempo);

        lblDistanciaRotaEfetuada.TagFloat := fltDistancia;
        lblDistanciaRotaEfetuada.Text     := FormatFloat('#,##0.00', fltDistancia / 1000) + ' km';

        lblTempoRotaEfetuada.FontColor := CorDaRota(tpRota);
        patRotaEfetuada.Fill.Color     := CorDaRota(tpRota);
      End;
  End;
end;

function TfmxVisualizarMapaGoogle.QtdePontosValidosParaRotas: Boolean;
begin
  Result := (Length(WayPoints) > 1) And (Length(WayPoints) <= 45);
end;

procedure TfmxVisualizarMapaGoogle.RecarregaRotaEfetuada;
begin
  MsgCarregando('Carregando rota efetuada...');

  If Assigned(Romaneio) Then
  Begin
    CarregarDadosGPX(tpPlanejada);
    MostrarRotaAproximada;
    FinalizaCarregamento;
  End;
end;

procedure TfmxVisualizarMapaGoogle.RotaAproximada;
Var
  Origem,
  Destino         : TTMSFNCMapsCoordinateRec;
  Seg, totSeg, i, x : Integer;
  totMet          : Double;
  UltCoordGPX     : IRastreamento;
begin
  If Not TemRastreamento Then
    Exit;

  MsgCarregando('Carregando rota efetuada...');

  totSeg := 0;
  totMet := 0;

  UltCoordGPX := Romaneio.UltimaCoordenadaGPX;

  If Assigned(UltCoordGPX) Then
  Begin
    Origem := StrToCoordinate(UltCoordGPX.Coordenadas);
    x      := 0;
  End
  Else
  Begin
    Origem := StrToCoordinate(Romaneio.Rastreamentos[0].Coordenadas);
    x      := 1;
  End;

  For i := x To (Romaneio.Rastreamentos.Count - 1) do
  Begin
    BarraCarregando(1);

    Destino := StrToCoordinate(Romaneio.Rastreamentos[i].Coordenadas);

    If (i > 0) Then
      Seg   := SecondsBetween(Romaneio.Rastreamentos[i-1].DataHoraCoordenadas,
                              Romaneio.Rastreamentos[i].DataHoraCoordenadas)
    Else
      Seg   := SecondsBetween(UltCoordGPX.DataHoraCoordenadas,
                              Romaneio.Rastreamentos[i].DataHoraCoordenadas);

    totMet  := totMet + MeasureDistance(Origem, Destino);
    totSeg  := totSeg + Seg;

    AddTrecho(tpAproximada, [Origem,Destino], Seg);

    Origem  := Destino;
  End;

  AdicionarPontoMotorista;

  PreencheInfoRotas(tpAproximada, totSeg + sumSegEfetuada, totMet + sumMetEfetuada);

  FinalizaCarregamento;

  SalvarGPX := True;
end;

Function TfmxVisualizarMapaGoogle.RotaAutorizada(AStartCoordinate, AEndCoordinate: TTMSFNCMapsCoordinateRec; Index, QtdePontos: Integer): Boolean;
begin
  Result := False;

  {* A primeira rota deve ser plotada *}
  If (Index = 1) Then
    Result := True

  {* A última rota deve ser plotada *}
  Else If (Index = QtdePontos) Then
    Result := True

  {* Somente as rotas com distancia maior que 100 m devem ser plotadas *}
  Else If DistanciaMaiorQue100Metros(AStartCoordinate, AEndCoordinate) Then
    Result := True;
end;

function TfmxVisualizarMapaGoogle.RotaExportada(tpRota: ITipoRota): boolean;
Var
  RotaGPX : IRotaGPX;
begin
  Result := False;

  If (Assigned(Romaneio)) Then
    For RotaGPX in Romaneio.RotasGPX Do
      If RotaGPX.TipoRota = tpRota Then
      Begin
        Result := True;
        Exit;
      End;
end;

procedure TfmxVisualizarMapaGoogle.routeCalculatorCalculateRoute(Sender: TObject;
  const ARoute: TTMSFNCRouteCalculatorRoute);
begin
  If ARoute.ID.Contains('Planejada') Then
  Begin
    Inc(rotasPlotadas);
    googleMaps.RouteCalculatorPlotRoute(ARoute);

    If FinalizouCalculoRotaPlanejada Then
      {CalcularRastreamento;}
      CarregarRotaEfetuada;
  End;

  If ARoute.ID.Contains('Efetuada') Then
  Begin
    Inc(rotasPlotadas);
    googleMaps.RouteCalculatorPlotRoute(ARoute);

    If FinalizouCalculoRotaPlanejada Then
      FinalizaCarregamento;
  End;
end;

function TfmxVisualizarMapaGoogle.StrToCoordinate(
  ACoordenada: String): TTMSFNCMapsCoordinateRec;
Var
  lstCoordenadas: TStringList;
begin
  lstCoordenadas                 := TStringList.Create;
  lstCoordenadas.Delimiter       := ',';
  lstCoordenadas.StrictDelimiter := True;
  lstCoordenadas.DelimitedText   := ACoordenada;

  Result.Latitude  := lstCoordenadas[0].Replace('.',',').ToDouble;
  Result.Longitude := lstCoordenadas[1].Replace('.',',').ToDouble;
end;

function TfmxVisualizarMapaGoogle.TemRastreamento: Boolean;
begin
  Result := True;

  If Not Assigned(Romaneio) Then
    Result := False

  Else If (Romaneio.Rastreamentos.Count <= 1) Then
    Result := False;
end;

function TfmxVisualizarMapaGoogle.TemRotaAproximadaGPX: Boolean;
Var
  RotaGPX : IRotaGPX;
begin
  Result := False;

  For RotaGPX in Romaneio.RotasGPX Do
  Begin
    If RotaGPX.TipoRota = tpAproximada Then
    Begin
      Result := True;
      Exit;
    End;
  End;
end;

function TfmxVisualizarMapaGoogle.NenhumaRotaGPXeRastreamentosPendentes: Boolean;
begin
  Result := False;

  If Romaneio.RotasGPX.Count <= 0 Then
    Result := True;

  If Romaneio.Rastreamentos.Count > 0 Then
    Result := True;
end;

procedure TfmxVisualizarMapaGoogle.tmrRotasTimer(Sender: TObject);
begin
  If CoordenadasPreenchidas Then
  Begin
    tmrRotas.Enabled := false;
    imgExpandirClick(imgExpandir);

    If (QtdePontosValidosParaRotas) Then
      CarregarRotaPlanejada(WayPoints)
    Else
      FinalizaCarregamento;
  End;
end;

end.
