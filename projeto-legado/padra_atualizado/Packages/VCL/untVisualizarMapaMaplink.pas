unit untVisualizarMapaMaplink;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, VCL.TMSFNCTypes, VCL.TMSFNCUtils,
  VCL.TMSFNCGraphics, VCL.TMSFNCGraphicsTypes, VCL.TMSFNCCustomControl,
  VCL.TMSFNCWebBrowser, VCL.TMSFNCMaps, VCL.TMSFNCGoogleMaps, Vcl.ComCtrls,
  dxGDIPlusClasses, VCL.TMSFNCMapsCommonTypes, VCL.TMSFNCRouteCalculator,
  TaEntregue.Romaneios.Interfaces, System.UITypes, Principal.View.Interfaces,
  VCL.TMSFNCCustomComponent, VCL.TMSFNCCloudBase, VCL.TMSFNCGeocoding, DateUtils,
  StrUtils, Vcl.WinXCtrls, untMaplinkTripClasses, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxProgressBar,
  untFuncoesSimples;

type
  TfrmVisualizarMapaMaplink = class(TfrmPai)
    pnlTopo: TPanel;
    googleMaps: TTMSFNCGoogleMaps;
    imgVoltar: TImage;
    imgExpandir: TImage;
    recRotaPlanejada: TShape;
    recRotaEfetuada: TShape;
    imgRotaPlanejada: TImage;
    imgRotaEfetuada: TImage;
    lblTempoRotaPlanejada: TLabel;
    lblDistanciaRotaPlanejada: TLabel;
    lblTempoRotaEfetuada: TLabel;
    lblDistanciaRotaEfetuada: TLabel;
    recFiltros: TShape;
    imgFinalizada: TImage;
    imgEmAndamento: TImage;
    imgNaoIniciada: TImage;
    cbxFinalizada: TCheckBox;
    cbxEmAndamento: TCheckBox;
    cbxNaoIniciada: TCheckBox;
    lblTitulo: TLabel;
    lblCarregando: TLabel;
    geolocalizacao: TTMSFNCGeocoding;
    filtrarRotas: TTMSFNCRouteCalculator;
    routeCalculator: TTMSFNCRouteCalculator;
    pnlLegendas: TPanel;
    aniAguarde: TActivityIndicator;
    pgbMaps: TcxProgressBar;
    procedure FormCreate(Sender: TObject);
    procedure imgVoltarClick(Sender: TObject);
    procedure cbxEmAndamentoClick(Sender: TObject);
    procedure googleMapsMarkerDblClick(Sender: TObject; AEventData: TTMSFNCMapsEventData);
    procedure imgExpandirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure routeCalculatorCalculateRoute(Sender: TObject; const ARoute: TTMSFNCRouteCalculatorRoute);
    procedure filtrarRotasCalculateRoute(Sender: TObject; const ARoute: TTMSFNCRouteCalculatorRoute);
    procedure googleMapsMapInitialized(Sender: TObject);
    procedure googleMapsMarkerMouseEnter(Sender: TObject; AEventData: TTMSFNCMapsEventData);
    procedure googleMapsMarkerMouseLeave(Sender: TObject; AEventData: TTMSFNCMapsEventData);
    procedure googleMapsGetZoomLevel(Sender: TObject; AZoomLevel: Double);
    procedure cbxFinalizadaClick(Sender: TObject);
    procedure cbxNaoIniciadaClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
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
    procedure CarregarRotaPlanejada(mapLinkCoord: TRetornoMaplinkTrip = Nil);
    procedure CarregarRotaEfetuada;

    function StrToCoordinate(ACoordenada: String): TTMSFNCMapsCoordinateRec;

    function FinalizouCalculoRotaPlanejada: Boolean;
    function FinalizouCalculoRotaEfetuada: Boolean;
    procedure AdicionarPontos(strCoordenada, strEndereco, strStatus, strOrdem,
      strCep, strCliente: String; dtaEntrega: TDatetime);
    procedure AdicionarPontoDePartida;
    procedure AdicionarPontoDeChegada;
    procedure AdicionarPontoMotorista;
    function QtdePontosValidosParaRotas: Boolean;
    function TemRastreamento: Boolean;
    procedure AddCoordenada(ARoute: TTMSFNCRouteCalculatorRoute; ATestarJaExiste: Boolean = True);
    procedure AniCarregando(habilitar: Boolean);

    procedure SalvarDadosGPX;
    procedure ExportaRotasGPX;
//    procedure ExportaRotaExata;
    procedure ExportaRotaAproximada(tpRota: ITipoRota);
    function RotaExportada(tpRota: ITipoRota): boolean;

    procedure CarregarDadosGPX(tpRota: ITipoRota);
    procedure ImportaRotasGPX(tpRota: ITipoRota);

    procedure FinalizaCarregamento;
    procedure PreencheInfoRotas(tpRota: ITipoRota; intTempo: integer; fltDistancia: double);

    procedure RotaAproximada;
    procedure AddTrecho(tpRota: ITipoRota; Coordenadas: TTMSFNCMapsCoordinateRecArray; intTempo: Integer);
    procedure RotaExata;

    function CorDaRota(tpRota : ITipoRota): TColor;

    function NenhumaRotaGPXeRastreamentosPendentes: Boolean;
    procedure CarregarRotasPelaAPI(mapLinkCoord: TRetornoMaplinkTrip = Nil);

    procedure MsgCarregando(msg: String);

    procedure FecharTela;
    procedure BarraCarregando(Value: Single);

    procedure LimparMarcadoresDefault;

  public
    { Public declarations }
    objFuncoes: IFuncoes;
    strNumRomLog : String;
    TaEntregue : ITaEntregue;
    Romaneio: IRomaneio;
    lstEndEntregas,
    lstDivergencias   : TStringList;
    mapLinkRotaPlanejada,
    mapLinkRotaEfetuada : TRetornoMaplinkTrip;
    tpRotaEfetuada : TTipoRotaEfetuada;

    procedure CarregarEnderecos;
  end;

var
  frmVisualizarMapaMaplink: TfrmVisualizarMapaMaplink;

implementation

{$R *.dfm}

{ TfrmVisualizarMapaMaplink }

procedure TfrmVisualizarMapaMaplink.FinalizaCarregamento;
begin
  MsgCarregando('Finalizando carregamento das rotas...');
  routeCalculator.Active := False;
  googleMaps.GetZoomLevel;
end;

function TfrmVisualizarMapaMaplink.FinalizouCalculoRotaEfetuada: Boolean;
begin
  Result := rotasFiltradas >= (rotasSolicitadas * 2);
end;

function TfrmVisualizarMapaMaplink.FinalizouCalculoRotaPlanejada: Boolean;
begin
  Result := rotasPlotadas >= (rotasSolicitadas * 2);
end;

procedure TfrmVisualizarMapaMaplink.AddCoordenada(ARoute: TTMSFNCRouteCalculatorRoute;
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

procedure TfrmVisualizarMapaMaplink.AddTrecho(tpRota: ITipoRota; Coordenadas: TTMSFNCMapsCoordinateRecArray; intTempo: Integer);
Var
  polTrecho : TTMSFNCGoogleMapsPolyline;
begin
  polTrecho := googleMaps.AddPolyline(Coordenadas);
  polTrecho.StrokeColor := CorDaRota(tpRota);
  polTrecho.StrokeWidth := 11;
  polTrecho.DataString  := 'Aproximada';
  polTrecho.DataInteger := intTempo;
end;

procedure TfrmVisualizarMapaMaplink.AdicionarPontoDeChegada;
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
  m.DataInteger := 1;

  googleMaps.EndUpdate;
end;

procedure TfrmVisualizarMapaMaplink.AdicionarPontoDePartida;
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
  marker.DataInteger := 1;

  SetLength(WayPoints, Length(WayPoints)+1);
  WayPoints[Length(WayPoints)- 1] := StrToCoordinate(Romaneio.PontoPartida.Coordenadas);

  googleMaps.EndUpdate;
end;

procedure TfrmVisualizarMapaMaplink.AdicionarPontoMotorista;
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
  m.DataInteger := 1;

  googleMaps.EndUpdate;
end;

procedure TfrmVisualizarMapaMaplink.AdicionarPontos(strCoordenada, strEndereco, strStatus, strOrdem,
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
  marker.DataString  := strEndereco + '|' + strCliente + '|' + DateTimeToStr(dtaEntrega);
  marker.Title       := '';

  SetLength(WayPoints, Length(WayPoints)+1);
  WayPoints[Length(WayPoints)- 1] := MapsCoordinate;

  googleMaps.EndUpdate;
end;

procedure TfrmVisualizarMapaMaplink.AniCarregando(habilitar: Boolean);
begin
  aniAguarde.Visible := habilitar;
  aniAguarde.Animate := habilitar;

  lblCarregando.Visible  := habilitar;

  lblTitulo.Visible      := Not habilitar;
  imgVoltar.Visible      := Not habilitar;
  imgExpandir.Visible    := Not habilitar;

  cbxFinalizada.Visible  := Not habilitar;
  imgFinalizada.Visible  := Not habilitar;

  cbxEmAndamento.Visible := Not habilitar;
  imgEmAndamento.Visible := Not habilitar;

  cbxNaoIniciada.Visible := Not habilitar;
  imgNaoIniciada.Visible := Not habilitar;
end;

procedure TfrmVisualizarMapaMaplink.BarraCarregando(Value: Single);
begin
  If Not (pgbMaps.Visible) Then
  Begin
    pgbMaps.Visible := True;
    Application.ProcessMessages;
  End;

  pgbMaps.Position   := pgbMaps.Position + 1;

  Application.ProcessMessages;
end;

procedure TfrmVisualizarMapaMaplink.CarregarEnderecos;
begin
  rotasPlotadas    := 0;
  rotasSolicitadas := 0;

  Origem  := EmptyStr;
  Destino := EmptyStr;

  AniCarregando(True);

  lblTitulo.Caption := 'Carregando...';

  pgbMaps.Position := 0;
  pgbMaps.Properties.Max   := (lstEndEntregas.Count) + {Pontos de Entrega + Pontos de partida e chegada}
                    Length(WayPoints);      {Rotas Efetuadas}

  If Assigned(mapLinkRotaPlanejada) Then
    pgbMaps.Properties.Max := pgbMaps.Properties.Max + Length(mapLinkRotaPlanejada.legs); {Rotas Planejadas}

  CarregarMarcadores;

  Application.ProcessMessages;

  If Assigned(Romaneio) Then
  Begin
    pgbMaps.Properties.Max := pgbMaps.Properties.Max + Romaneio.Rastreamentos.Count; {Rotas Efetuadas}

    If (Romaneio.RotasGPX.Count > 0) Then
    Begin
      pgbMaps.Position := 0;
      pgbMaps.Properties.Max   := Romaneio.RotasGPX.Count;

      Case tpRotaEfetuada Of
        rtExata     : CarregarDadosGPX(tpEfetuada);
        rtAproximada: CarregarDadosGPX(tpAproximada);
      End;

      CarregarDadosGPX(tpPlanejada);
    End;

    if (NenhumaRotaGPXeRastreamentosPendentes) Then
      CarregarRotasPelaAPI(mapLinkRotaPlanejada)
    Else
      FinalizaCarregamento;
  End
  Else
    CarregarRotasPelaAPI(mapLinkRotaPlanejada);
end;

procedure TfrmVisualizarMapaMaplink.CarregarMarcadores;
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

  If Assigned(lstDivergencias) Then
  Begin
    For i := 0 to lstDivergencias.Count-1 Do
    Begin
      lstColunas.DelimitedText := lstDivergencias[i];

      AdicionarPontos(lstColunas[0], lstColunas[1], lstColunas[2],
                      lstColunas[3], lstColunas[4], lstColunas[5],
                      StrToDateTime(lstColunas[6]));

      BarraCarregando(1);
    End;
  End;

  AdicionarPontoDeChegada;

  lstColunas.Free;
end;

procedure TfrmVisualizarMapaMaplink.CarregarRotaEfetuada;
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
    If tpRotaEfetuada = rtAproximada Then
      RotaAproximada
    Else
      RotaExata;
end;

procedure TfrmVisualizarMapaMaplink.CarregarDadosGPX(tpRota: ITipoRota);
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

procedure TfrmVisualizarMapaMaplink.CarregarRotaPlanejada(mapLinkCoord: TRetornoMaplinkTrip = Nil);
Var
  Origem,
  Destino    : TTMSFNCMapsCoordinateRec;
  x, y       : Integer;
  polTrecho  : TTMSFNCGoogleMapsPolyline;
begin
  {***********************************************************************}
  {* Se a rota planejada já foi exportada anteriormente na RASGPX, então *}
  {* não irá carregar pela API do Google, mas sim pelo ImportaRotasGPX   *}
  {***********************************************************************}
  If (RotaExportada(tpPlanejada)) Or (Not Assigned(mapLinkCoord)) Then
  Begin
    CarregarRotaEfetuada;
    Exit;
  End;

  MsgCarregando('Carregando rota planejada...');

  googleMaps.BeginUpdate;

  For x := 0 To Length(mapLinkCoord.legs)-1 do
  Begin
    BarraCarregando(1);

    Origem := CreateCoordinate(mapLinkCoord.legs[x].points[0].latitude,
                               mapLinkCoord.legs[x].points[0].longitude);

    For y := 1 To Length(mapLinkCoord.legs[x].points)-1 do
    Begin
      Destino := CreateCoordinate(mapLinkCoord.legs[x].points[y].latitude,
                                  mapLinkCoord.legs[x].points[y].longitude);

      polTrecho := googleMaps.AddPolyline([Origem,Destino]);
      polTrecho.DataString  := 'Planejada';
      polTrecho.StrokeColor := CorDaRota(tpPlanejada);
      polTrecho.StrokeWidth := 6;

      Origem  := Destino;
    End;
  End;

  googleMaps.EndUpdate;

  SalvarGPX := True;

  CarregarRotaEfetuada;
end;

procedure TfrmVisualizarMapaMaplink.CarregarRotasPelaAPI(mapLinkCoord: TRetornoMaplinkTrip = Nil);
begin
  imgExpandirClick(imgExpandir);

  If (QtdePontosValidosParaRotas) Then
    CarregarRotaPlanejada(mapLinkCoord)
  Else
    FinalizaCarregamento;
end;

procedure TfrmVisualizarMapaMaplink.cbxEmAndamentoClick(Sender: TObject);
var
  m : TTMSFNCMapsMarker;
begin
  For m in googleMaps.Markers do
  Begin
    If (ContainsStr(m.IconURL, 'EmAndamento')) Then
      m.Visible := TCheckBox(Sender).Checked;
  End;
end;

procedure TfrmVisualizarMapaMaplink.cbxFinalizadaClick(Sender: TObject);
var
  m : TTMSFNCMapsMarker;
begin
  For m in googleMaps.Markers do
  Begin
    If (ContainsStr(m.IconURL, 'Finalizada')) Then
      m.Visible := TCheckBox(Sender).Checked;
  End;
end;

procedure TfrmVisualizarMapaMaplink.cbxNaoIniciadaClick(Sender: TObject);
var
  m : TTMSFNCMapsMarker;
begin
  For m in googleMaps.Markers do
  Begin
    If (ContainsStr(m.IconURL, 'NaoIniciada')) Then
      m.Visible := TCheckBox(Sender).Checked;
  End;
end;

function TfrmVisualizarMapaMaplink.CorDaRota(tpRota: ITipoRota): TColor;
begin
  Result := TAlphaColorRec.Null;

  Case tpRota Of
    tpPlanejada  : Result := TColor($00BCBCC0);
    tpEfetuada,
    tpAproximada : Result := TColor($00CB6532);
  End;
end;

procedure TfrmVisualizarMapaMaplink.ExportaRotaAproximada(tpRota: ITipoRota);
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

      If (googleMaps.Polylines[x].StrokeColor = CorDaRota(tpRota)) Then
        for y := 0 to Length(googleMaps.Polylines[x].Coordinates.ToArray) - 1 do
          sl.Add(Format('<trkpt lat="%.7f" lon="%.7f" />', [googleMaps.Polylines[x].Coordinates[y].Latitude,
                                                            googleMaps.Polylines[x].Coordinates[y].Longitude]));
    End;

    FormatSettings.ThousandSeparator := t;
    FormatSettings.DecimalSeparator := d;

    sl.Add(ftr);

  finally
    Case tpRota Of
      tpPlanejada : Romaneio.ExportarRotaGPX(tpPlanejada, sl.Text, lblTempoRotaPlanejada.Tag, lblDistanciaRotaPlanejada.Hint.ToDouble());
      tpAproximada,
      tpEfetuada  : Romaneio.ExportarRotaGPX(tpRota, sl.Text, lblTempoRotaEfetuada.Tag, lblDistanciaRotaEfetuada.Hint.ToDouble());
    End;
    sl.Free;
  end;
end;

//procedure TfrmVisualizarMapaMaplink.ExportaRotaExata;
//Var
//  i: Integer;
//begin
//  For i := 0 To routeCalculator.Routes.Count - 1 Do
//  Begin
//    BarraCarregando(1);
//
//    If routeCalculator.Routes[i].ID.Contains('Planejada') Then
//      Romaneio.ExportarRotaGPX(tpPlanejada,
//                               googleMaps.SaveToGPXText(routeCalculator.Routes[i].Polyline),
//                               lblTempoRotaPlanejada.Tag,
//                               lblDistanciaRotaplanejada.Hint.ToDouble());
//
//    If routeCalculator.Routes[i].ID.Contains('Efetuada') Then
//      Romaneio.ExportarRotaGPX(tpEfetuada,
//                               googleMaps.SaveToGPXText(routeCalculator.Routes[i].Polyline),
//                               lblTempoRotaEfetuada.Tag,
//                               lblDistanciaRotaEfetuada.Hint.ToDouble());
//  End;
//end;

procedure TfrmVisualizarMapaMaplink.ExportaRotasGPX;
begin
  MsgCarregando('Salvando rotas GPX...');

  pgbMaps.Position := 0;
  pgbMaps.Properties.Max      := routeCalculator.Routes.Count + googleMaps.Polylines.Count;

  ExportaRotaAproximada(tpPlanejada);

  Case fCfgSis('TPROEF', varString) = 'S' Of
    True  : ExportaRotaAproximada(tpEfetuada);
    False : ExportaRotaAproximada(tpAproximada);
  End;
end;

procedure TfrmVisualizarMapaMaplink.FecharTela;
begin
  AniCarregando(True);
  SalvarDadosGPX;

  Sleep(100);

  Close;
end;

procedure TfrmVisualizarMapaMaplink.SalvarDadosGPX;
begin
  If SalvarGPX Then
    if Assigned(Romaneio) Then
      If NenhumaRotaGPXeRastreamentosPendentes Then
        ExportaRotasGPX;
end;

procedure TfrmVisualizarMapaMaplink.filtrarRotasCalculateRoute(Sender: TObject;
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

procedure TfrmVisualizarMapaMaplink.FormCreate(Sender: TObject);
begin

  imgVoltar.Visible      := False;
  imgExpandir.Visible    := False;
  lblTitulo.Visible      := False;
  imgFinalizada.Visible  := False;
  cbxFinalizada.Visible  := False;
  imgEmAndamento.Visible := False;
  cbxEmAndamento.Visible := False;
  imgNaoIniciada.Visible := False;
  cbxNaoIniciada.Visible := False;

  lstCoordenadasEfetuadas := TStringList.Create;

  lblTempoRotaPlanejada.Tag     := 0;
  lblTempoRotaPlanejada.Caption := '0s';

  lblDistanciaRotaPlanejada.Hint    := '0';
  lblDistanciaRotaPlanejada.Caption := '0 km';

  lblTempoRotaEfetuada.Tag     := 0;
  lblTempoRotaEfetuada.Caption := '0s';

  lblDistanciaRotaEfetuada.Hint    := '0';
  lblDistanciaRotaEfetuada.Caption := '0 km';

  rotasSolicitadas := 0;
  rotasPlotadas    := 0;

  sumMinPlanejada := 0;
  sumSegEfetuada  := 0;

  sumkmPlanejada  := 0;
  sumMetEfetuada   := 0;

  SalvarGPX := False;

  pgbMaps.Position := 0;
  pgbMaps.Properties.Max     := 0;

  tpRotaEfetuada := rtExata;

  lblTitulo.Caption := '';
  lblCarregando.Caption := '';
end;

procedure TfrmVisualizarMapaMaplink.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  Case Key Of
    vkEscape :
    Begin
      If Not ContainsStr(lblTitulo.Caption, 'Carregando') Then
        FecharTela;
    End;
  End;
end;

procedure TfrmVisualizarMapaMaplink.FormResize(Sender: TObject);
begin
  inherited;
  pnlLegendas.Left := pnlTopo.Width - pnlLegendas.Width;
  aniAguarde.Left  := Round((pnlTopo.Width / 2) - (aniAguarde.Width / 2));
end;

procedure TfrmVisualizarMapaMaplink.googleMapsGetZoomLevel(Sender: TObject;
  AZoomLevel: Double);
begin
  pgbMaps.Visible := False;
  lblTitulo.Caption := 'Mapa de Entregas';
  AniCarregando(False);
  LimparMarcadoresDefault;
  Application.ProcessMessages;
end;

procedure TfrmVisualizarMapaMaplink.googleMapsMapInitialized(Sender: TObject);
begin
  CarregarEnderecos;
end;

procedure TfrmVisualizarMapaMaplink.googleMapsMarkerDblClick(Sender: TObject;
  AEventData: TTMSFNCMapsEventData);
begin
  googleMaps.SetCenterCoordinate(AEventData.Marker.Coordinate.ToRec);
  googleMaps.SetZoomLevel(15);
end;

procedure TfrmVisualizarMapaMaplink.googleMapsMarkerMouseEnter(Sender: TObject;
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

procedure TfrmVisualizarMapaMaplink.googleMapsMarkerMouseLeave(Sender: TObject;
  AEventData: TTMSFNCMapsEventData);
begin
  googleMaps.CloseAllPopups;
end;

procedure TfrmVisualizarMapaMaplink.imgExpandirClick(Sender: TObject);
begin
  googleMaps.BeginUpdate;
  googleMaps.ZoomToBounds(googleMaps.Markers.ToCoordinateArray);
  googleMaps.EndUpdate;

  Application.ProcessMessages;
end;

procedure TfrmVisualizarMapaMaplink.imgVoltarClick(Sender: TObject);
begin
  If Not ContainsStr(lblTitulo.Caption, 'Carregando') Then
    FecharTela;
end;

procedure TfrmVisualizarMapaMaplink.ImportaRotasGPX(tpRota: ITipoRota);
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

procedure TfrmVisualizarMapaMaplink.LimparMarcadoresDefault;
var
  m : TTMSFNCMapsMarker;
begin
  For m in googleMaps.Markers do
    m.Visible := m.DataInteger = 1;
end;

procedure TfrmVisualizarMapaMaplink.MsgCarregando(msg: String);
begin
  lblCarregando.Caption := 'Aguarde - ' + msg;
  Application.ProcessMessages;
end;

procedure TfrmVisualizarMapaMaplink.PreencheInfoRotas(tpRota: ITipoRota; intTempo: integer; fltDistancia: double);
begin
  Case tpRota Of
    tpPlanejada:
      Begin
        lblTempoRotaPlanejada.Tag  := intTempo;
        lblTempoRotaPlanejada.Caption := objFuncoes.fRetTempo(intTempo);

        lblDistanciaRotaPlanejada.Hint := fltDistancia.ToString;
        lblDistanciaRotaPlanejada.Caption  := FormatFloat('#,##0.00', fltDistancia) + ' km';

        lblTempoRotaPlanejada.Font.Color := CorDaRota(tpRota);
      End;

    tpEfetuada,
    tpAproximada:
      Begin
        lblTempoRotaEfetuada.Tag  := intTempo;
        lblTempoRotaEfetuada.Caption := objFuncoes.fRetTempo(intTempo);

        lblDistanciaRotaEfetuada.Hint := fltDistancia.ToString;
        lblDistanciaRotaEfetuada.Caption     := FormatFloat('#,##0.00', fltDistancia / 1000) + ' km';

        lblTempoRotaEfetuada.Font.Color := CorDaRota(tpRota);
      End;
  End;
end;

function TfrmVisualizarMapaMaplink.QtdePontosValidosParaRotas: Boolean;
begin
  Result := (Length(WayPoints) > 1) And (Length(WayPoints) <= 99);
end;

procedure TfrmVisualizarMapaMaplink.RotaAproximada;
Var
  Origem,
  Destino        : TTMSFNCMapsCoordinateRec;
  Seg, totSeg, i, x : Integer;
  totMet          : Double;
  UltCoordGPX    : IRastreamento;
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

  googleMaps.BeginUpdate;

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

  googleMaps.EndUpdate;

  AdicionarPontoMotorista;

  PreencheInfoRotas(tpAproximada, totSeg + sumSegEfetuada, totMet + sumMetEfetuada);

  FinalizaCarregamento;

  SalvarGPX := True;
end;

procedure TfrmVisualizarMapaMaplink.RotaExata;
Var
  Origem,
  Destino    : TTMSFNCMapsCoordinateRec;
  x, y       : Integer;
begin
  MsgCarregando('Carregando rota efetuada...');

  googleMaps.BeginUpdate;

  For x := 0 To Length(mapLinkRotaEfetuada.legs)-1 do
  Begin
    BarraCarregando(1);

    Origem := CreateCoordinate(mapLinkRotaEfetuada.legs[x].points[0].latitude,
                               mapLinkRotaEfetuada.legs[x].points[0].longitude);

    For y := 1 To Length(mapLinkRotaEfetuada.legs[x].points)-1 do
    Begin
      Destino := CreateCoordinate(mapLinkRotaEfetuada.legs[x].points[y].latitude,
                                  mapLinkRotaEfetuada.legs[x].points[y].longitude);

      AddTrecho(tpEfetuada, [Origem,Destino], 0);

      Origem  := Destino;
    End;
  End;

  googleMaps.EndUpdate;

  AdicionarPontoMotorista;

  PreencheInfoRotas(tpEfetuada, Round(mapLinkRotaEfetuada.totalNominalDuration), mapLinkRotaEfetuada.totalDistance);

  FinalizaCarregamento;

  SalvarGPX := True;
end;

function TfrmVisualizarMapaMaplink.RotaExportada(tpRota: ITipoRota): boolean;
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

procedure TfrmVisualizarMapaMaplink.routeCalculatorCalculateRoute(Sender: TObject;
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

function TfrmVisualizarMapaMaplink.StrToCoordinate(
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

function TfrmVisualizarMapaMaplink.TemRastreamento: Boolean;
begin
  Result := True;

  If Not Assigned(Romaneio) Then
    Result := False

  Else If (Romaneio.Rastreamentos.Count <= 1) Then
    Result := False;
end;

function TfrmVisualizarMapaMaplink.NenhumaRotaGPXeRastreamentosPendentes: Boolean;
begin
  Result := False;

  If Romaneio.RotasGPX.Count <= 0 Then
    Result := True;

  If Romaneio.Rastreamentos.Count > 0 Then
    Result := True;
end;

end.
