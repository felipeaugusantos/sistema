unit untVisualizarMapaGoogle;

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
  StrUtils, Vcl.WinXCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxProgressBar, untFuncoesSimples;

type
  TfrmVisualizarMapaGoogle = class(TfrmPai)
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
    tmrRotas: TTimer;
    pnlLegendas: TPanel;
    aniAguarde: TActivityIndicator;
    pgbMaps: TcxProgressBar;
    procedure imgExpandirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure imgVoltarClick(Sender: TObject);
    procedure tmrRotasTimer(Sender: TObject);
    procedure cbxFinalizadaClick(Sender: TObject);
    procedure cbxEmAndamentoClick(Sender: TObject);
    procedure cbxNaoIniciadaClick(Sender: TObject);
    procedure googleMapsMarkerDblClick(Sender: TObject;
      AEventData: TTMSFNCMapsEventData);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure routeCalculatorCalculateRoute(Sender: TObject;
      const ARoute: TTMSFNCRouteCalculatorRoute);
    procedure filtrarRotasCalculateRoute(Sender: TObject;
      const ARoute: TTMSFNCRouteCalculatorRoute);
    procedure googleMapsMapInitialized(Sender: TObject);
    procedure googleMapsMarkerMouseEnter(Sender: TObject;
      AEventData: TTMSFNCMapsEventData);
    procedure googleMapsMarkerMouseLeave(Sender: TObject;
      AEventData: TTMSFNCMapsEventData);
    procedure googleMapsGetZoomLevel(Sender: TObject; AZoomLevel: Double);
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
    procedure RotaExata;

//    procedure RecarregaRotaEfetuada;
    function CorDaRota(tpRota : ITipoRota): TColor;

//    procedure MostrarRotaAproximada;

//    function TemRotaAproximadaGPX: Boolean;

    function NenhumaRotaGPXeRastreamentosPendentes: Boolean;

    procedure CarregarRotasPelaAPI;

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
    lstDivergencias : TStringList;
    tpRotaEfetuada  : TTipoRotaEfetuada;

    procedure CarregarEnderecos;
  end;

var
  frmVisualizarMapaGoogle: TfrmVisualizarMapaGoogle;

implementation

{$R *.dfm}

{ TfrmVisualizarMapaGoogle }

procedure TfrmVisualizarMapaGoogle.AddCoordenada(
  ARoute: TTMSFNCRouteCalculatorRoute; ATestarJaExiste: Boolean);
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

procedure TfrmVisualizarMapaGoogle.AddTrecho(tpRota: ITipoRota;
  Coordenadas: TTMSFNCMapsCoordinateRecArray; intTempo: Integer);
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

procedure TfrmVisualizarMapaGoogle.RotaExata;
Var
  Origem,
  Destino    : TTMSFNCMapsCoordinateRec;
  WayPoints  : TTMSFNCMapsCoordinateRecArray;
  i, x       : Integer;
  lstColunas : TStringList;
Begin
  If Not FinalizouCalculoRotaEfetuada Then
    Exit;

  MsgCarregando('Carregando rota efetuada...');

  lstColunas                 := TStringList.Create;
  lstColunas.Delimiter       := '|';
  lstColunas.StrictDelimiter := True;

  routeCalculator.Options.Polyline.StrokeColor := CorDaRota(tpEfetuada);
  routeCalculator.Options.Polyline.StrokeWidth := 11;

  x                := 0;
  rotasPlotadas    := 0;
  rotasSolicitadas := 0;

  lstColunas.DelimitedText := lstCoordenadasEfetuadas[0];

  Origem := StrToCoordinate(lstColunas[1]);

  RouteCalculator.Active := True;

  googleMaps.RouteCalculator := routeCalculator;
  googleMaps.BeginUpdate;

  For i := 1 To lstCoordenadasEfetuadas.Count - 1 Do
  Begin
    lstColunas.DelimitedText := lstCoordenadasEfetuadas[i];

    If (x <= 23) And (i < (lstCoordenadasEfetuadas.Count - 1)) Then
    Begin
      Inc(x);

      SetLength(WayPoints, Length(WayPoints)+1);
      WayPoints[Length(WayPoints)-1] := StrToCoordinate(lstColunas[1]);
    End
    Else
    Begin
      Destino := StrToCoordinate(lstColunas[1]);

      routeCalculator.CalculateRoute(Origem, Destino,
        procedure(const ARoute: TTMSFNCRouteCalculatorRoute)
        begin
          sumMetEfetuada := sumMetEfetuada + ARoute.Distance;
          sumSegEfetuada := sumSegEfetuada + Round(ARoute.Duration);

          PreencheInfoRotas(tpEfetuada, sumSegEfetuada, sumMetEfetuada);
        end,
        WayPoints, 'Efetuada');

      TaEntregue.pGravaLogUsoGoogleMaps(strNumRomLog, 'Consulta Api Directions [Rota Efetuada]');

      Inc(rotasSolicitadas);

      Origem := Destino;

      x := 0;
      SetLength(WayPoints, 0);
    End;

    AdicionarPontoDeChegada;
    AdicionarPontoMotorista;
  End;

  googleMaps.EndUpdate;
  lstColunas.Free;
End;

procedure TfrmVisualizarMapaGoogle.AdicionarPontoDeChegada;
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

procedure TfrmVisualizarMapaGoogle.AdicionarPontoDePartida;
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

procedure TfrmVisualizarMapaGoogle.AdicionarPontoMotorista;
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

procedure TfrmVisualizarMapaGoogle.AdicionarPontos(strCoordenada, strEndereco,
  strStatus, strOrdem, strCep, strCliente: String; dtaEntrega: TDatetime);
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

procedure TfrmVisualizarMapaGoogle.AniCarregando(habilitar: Boolean);
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
  {layFiltroRotas.Visible := Not habilitar;}
end;

procedure TfrmVisualizarMapaGoogle.BarraCarregando(Value: Single);
begin
  If Not (pgbMaps.Visible) Then
    pgbMaps.Visible := True;

  pgbMaps.Position   := pgbMaps.Position + 1;
//  lblpgbMaps.Text := FormatFloat('#0',(pgbMaps.Position * 100)  / pgbMaps.Max) + '%';

  Application.ProcessMessages;
end;

procedure TfrmVisualizarMapaGoogle.CalcularRastreamento;
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

  If tpRotaEfetuada = rtAproximada Then
    Exit;

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

procedure TfrmVisualizarMapaGoogle.CarregarDadosGPX(tpRota: ITipoRota);
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

procedure TfrmVisualizarMapaGoogle.CarregarDivergentes;
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

procedure TfrmVisualizarMapaGoogle.CarregarEnderecos;
begin
  rotasPlotadas    := 0;
  rotasSolicitadas := 0;

  Origem  := EmptyStr;
  Destino := EmptyStr;

  AniCarregando(True);

  lblTitulo.Caption := 'Carregando...';

  pgbMaps.Position := 0;
  pgbMaps.Properties.Max   := (lstEndEntregas.Count+2) +     {Pontos de Entrega + Pontos de partida e chegada}
                    Length(WayPoints); {Rotas Efetuadas}

  CarregarMarcadores;

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
      CarregarRotasPelaAPI
    else
      FinalizaCarregamento;
  End
  Else
    CarregarRotasPelaAPI;

  CarregarDivergentes;
end;

procedure TfrmVisualizarMapaGoogle.CarregarMarcadores;
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

procedure TfrmVisualizarMapaGoogle.CarregarRotaEfetuada;
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

procedure TfrmVisualizarMapaGoogle.CarregarRotaPlanejada(
  ACoordenadas: TTMSFNCMapsCoordinateRecArray);
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
    CalcularRastreamento;
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

procedure TfrmVisualizarMapaGoogle.CarregarRotasPelaAPI;
begin
  imgExpandirClick(imgExpandir);

  If (QtdePontosValidosParaRotas) Then
    CarregarRotaPlanejada(WayPoints)
  Else
    FinalizaCarregamento;
end;

procedure TfrmVisualizarMapaGoogle.cbxEmAndamentoClick(Sender: TObject);
var
  m : TTMSFNCMapsMarker;
begin
  For m in googleMaps.Markers do
  Begin
    If (ContainsStr(m.IconURL, 'EmAndamento')) Then
      m.Visible := TCheckBox(Sender).Checked;
  End;
end;

procedure TfrmVisualizarMapaGoogle.cbxFinalizadaClick(Sender: TObject);
var
  m : TTMSFNCMapsMarker;
begin
  For m in googleMaps.Markers do
  Begin
    If (ContainsStr(m.IconURL, 'Finalizada')) Then
      m.Visible := TCheckBox(Sender).Checked;
  End;
end;

procedure TfrmVisualizarMapaGoogle.cbxNaoIniciadaClick(Sender: TObject);
var
  m : TTMSFNCMapsMarker;
begin
  For m in googleMaps.Markers do
  Begin
    If (ContainsStr(m.IconURL, 'NaoIniciada')) Then
      m.Visible := TCheckBox(Sender).Checked;
  End;
end;

function TfrmVisualizarMapaGoogle.CoordenadasPreenchidas: Boolean;
Var
  LEndEntregas: Integer;
begin
  LEndEntregas := lstEndEntregas.Count;

  {* Se existir rastreamento preenchido, adicionar ponto de partida do motorista *}
  If (TemRastreamento) Then
    Inc(LEndEntregas);

  Result := googleMaps.Markers.Count = LEndEntregas;
end;

function TfrmVisualizarMapaGoogle.CorDaRota(tpRota: ITipoRota): TColor;
begin
  Result := TAlphaColorRec.Null;

  Case tpRota Of
    tpPlanejada  : Result := TColor($00C0BCBC);
    tpEfetuada,
    tpAproximada : Result := TColor($00CB6532);
  End;
end;

function TfrmVisualizarMapaGoogle.DistanciaMaiorQue100Metros(AStartCoordinate,
  AEndCoordinate: TTMSFNCMapsCoordinateRec): Boolean;
Var
  Distancia: Double;
begin
  Distancia := MeasureDistance(AStartCoordinate, AEndCoordinate);

  Result := Distancia > 100;
end;

procedure TfrmVisualizarMapaGoogle.ExportaRotaAproximada;
Var
  x,y: Integer;
  hdr, ftr : String;
  d, t : Char;
  sl : TStringList;
begin
  If (fCfgSis('TPROEF', varString) = 'S') Then
    Exit;

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
    Romaneio.ExportarRotaGPX(tpAproximada, sl.Text, lblTempoRotaEfetuada.Tag, lblDistanciaRotaEfetuada.Hint.ToDouble());
    sl.Free;
  end;
end;

procedure TfrmVisualizarMapaGoogle.ExportaRotaExata;
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
                               lblDistanciaRotaPlanejada.Hint.ToDouble());

    If routeCalculator.Routes[i].ID.Contains('Efetuada') Then
      If (fCfgSis('TPROEF', varString) = 'S') Then
        Romaneio.ExportarRotaGPX(tpEfetuada,
                                 googleMaps.SaveToGPXText(routeCalculator.Routes[i].Polyline),
                                 lblTempoRotaEfetuada.Tag,
                                 lblDistanciaRotaEfetuada.Hint.ToDouble());
  End;
end;

procedure TfrmVisualizarMapaGoogle.ExportaRotasGPX;
begin
  MsgCarregando('Salvando rotas GPX...');

  pgbMaps.Position := 0;
  pgbMaps.Properties.Max   := routeCalculator.Routes.Count + googleMaps.Polylines.Count;

  ExportaRotaExata;
  ExportaRotaAproximada;
end;

procedure TfrmVisualizarMapaGoogle.FecharTela;
begin
  AniCarregando(True);
  SalvarDadosGPX;

  Sleep(100);

  Close;
end;

procedure TfrmVisualizarMapaGoogle.filtrarRotasCalculateRoute(Sender: TObject;
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

procedure TfrmVisualizarMapaGoogle.FinalizaCarregamento;
begin
  MsgCarregando('Finalizando carregamento das rotas...');
  routeCalculator.Active := False;
  googleMaps.GetZoomLevel;
end;

function TfrmVisualizarMapaGoogle.FinalizouCalculoRotaEfetuada: Boolean;
begin
  Result := rotasFiltradas >= (rotasSolicitadas * 2);
end;

function TfrmVisualizarMapaGoogle.FinalizouCalculoRotaPlanejada: Boolean;
begin
  Result := rotasPlotadas >= (rotasSolicitadas * 2);
end;

procedure TfrmVisualizarMapaGoogle.FormCreate(Sender: TObject);
begin
  inherited;

  imgVoltar.Visible      := False;
  imgExpandir.Visible    := False;
  lblTitulo.Visible      := False;
  imgFinalizada.Visible  := False;
  cbxFinalizada.Visible  := False;
  imgEmAndamento.Visible := False;
  cbxEmAndamento.Visible := False;
  imgNaoIniciada.Visible := False;
  cbxNaoIniciada.Visible := False;

  lblTempoRotaPlanejada.Tag     := 0;
  lblTempoRotaPlanejada.Caption := '0s';

  lblDistanciaRotaPlanejada.Hint    := '0';
  lblDistanciaRotaPlanejada.Caption := '0 km';

  lblTempoRotaEfetuada.Tag     := 0;
  lblTempoRotaEfetuada.Caption := '0s';

  lblDistanciaRotaEfetuada.Hint    := '0';
  lblDistanciaRotaEfetuada.Caption := '0 km';

  lstCoordenadasEfetuadas := TStringList.Create;

  rotasSolicitadas := 0;
  rotasPlotadas    := 0;

  sumMinPlanejada := 0;
  sumSegEfetuada  := 0;

  sumkmPlanejada  := 0;
  sumMetEfetuada  := 0;

  SalvarGPX := False;

  pgbMaps.Visible := False;
  pgbMaps.Position:= 0;
  pgbMaps.Properties.Max     := 0;

  tpRotaEfetuada := rtExata;

  lblTitulo.Caption     := '';
  lblCarregando.Caption := '';
end;

procedure TfrmVisualizarMapaGoogle.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    vkEscape :
    Begin
      If Not ContainsStr(lblTitulo.Caption, 'Carregando') Then
        FecharTela;
    End;
  End;
end;

procedure TfrmVisualizarMapaGoogle.FormResize(Sender: TObject);
begin
  inherited;
  pnlLegendas.Left := pnlTopo.Width - pnlLegendas.Width;
  aniAguarde.Left  := Round((pnlTopo.Width / 2) - (aniAguarde.Width / 2));
end;

procedure TfrmVisualizarMapaGoogle.googleMapsGetZoomLevel(Sender: TObject;
  AZoomLevel: Double);
begin
  inherited;
  pgbMaps.Visible := False;
  lblTitulo.Caption := 'Mapa de Entregas';
  AniCarregando(False);
  LimparMarcadoresDefault;
  Application.ProcessMessages;
end;

procedure TfrmVisualizarMapaGoogle.googleMapsMapInitialized(Sender: TObject);
begin
  inherited;
  AniCarregando(True);
  CarregarEnderecos;
end;

procedure TfrmVisualizarMapaGoogle.googleMapsMarkerDblClick(Sender: TObject;
  AEventData: TTMSFNCMapsEventData);
begin
  inherited;
  googleMaps.SetCenterCoordinate(AEventData.Marker.Coordinate.ToRec);
  googleMaps.SetZoomLevel(15);
end;

procedure TfrmVisualizarMapaGoogle.googleMapsMarkerMouseEnter(Sender: TObject;
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
      add := '<b>Endereço: </b>' + lstColunas[0] + '<br>';

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

procedure TfrmVisualizarMapaGoogle.googleMapsMarkerMouseLeave(Sender: TObject;
  AEventData: TTMSFNCMapsEventData);
begin
  inherited;
  googleMaps.CloseAllPopups;
end;

procedure TfrmVisualizarMapaGoogle.imgExpandirClick(Sender: TObject);
begin
  googleMaps.BeginUpdate;
  googleMaps.ZoomToBounds(googleMaps.Markers.ToCoordinateArray);
  googleMaps.EndUpdate;

  Application.ProcessMessages;
end;

procedure TfrmVisualizarMapaGoogle.imgVoltarClick(Sender: TObject);
begin
  inherited;

  If Not ContainsStr(lblTitulo.Caption, 'Carregando') Then
    FecharTela;
end;

procedure TfrmVisualizarMapaGoogle.ImportaRotasGPX(tpRota: ITipoRota);
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

procedure TfrmVisualizarMapaGoogle.LimparMarcadoresDefault;
var
  m : TTMSFNCMapsMarker;
begin
  For m in googleMaps.Markers do
    m.Visible := m.DataInteger = 1;
end;

//procedure TfrmVisualizarMapaGoogle.MostrarRotaAproximada;
//begin
//  If TemRotaAproximadaGPX Then
//    CarregarDadosGPX(tpAproximada)
//  Else
//  Begin
//    Romaneio.RecalcularRotaEfetuada;
//    RotaAproximada;
//  End;
//end;

procedure TfrmVisualizarMapaGoogle.MsgCarregando(msg: String);
begin
  lblCarregando.Caption := 'Aguarde - ' + msg;
  Application.ProcessMessages;
end;

function TfrmVisualizarMapaGoogle.NenhumaRotaGPXeRastreamentosPendentes: Boolean;
begin
  Result := False;

  If Romaneio.RotasGPX.Count <= 0 Then
    Result := True;

  If Romaneio.Rastreamentos.Count > 0 Then
    Result := True;
end;

procedure TfrmVisualizarMapaGoogle.PreencheInfoRotas(tpRota: ITipoRota;
  intTempo: integer; fltDistancia: double);
begin
  Case tpRota Of
    tpPlanejada:
      Begin
        lblTempoRotaPlanejada.Tag     := intTempo;
        lblTempoRotaPlanejada.Caption := objFuncoes.fRetTempo(intTempo);

        lblDistanciaRotaPlanejada.Hint    := fltDistancia.ToString;
        lblDistanciaRotaPlanejada.Caption := FormatFloat('#,##0.00', fltDistancia) + ' km';

        lblTempoRotaPlanejada.Font.Color := CorDaRota(tpRota);
      End;

    tpEfetuada,
    tpAproximada:
      Begin
        lblTempoRotaEfetuada.Tag     := intTempo;
        lblTempoRotaEfetuada.Caption := objFuncoes.fRetTempo(intTempo);

        lblDistanciaRotaEfetuada.Hint    := fltDistancia.ToString;
        lblDistanciaRotaEfetuada.Caption := FormatFloat('#,##0.00', fltDistancia / 1000) + ' km';

        lblTempoRotaEfetuada.Font.Color := CorDaRota(tpRota);
      End;
  End;
end;

function TfrmVisualizarMapaGoogle.QtdePontosValidosParaRotas: Boolean;
begin
  Result := (Length(WayPoints) > 1) And (Length(WayPoints) <= 99);
end;

//procedure TfrmVisualizarMapaGoogle.RecarregaRotaEfetuada;
//begin
//  MsgCarregando('Carregando rota efetuada...');
//
//  If Assigned(Romaneio) Then
//  Begin
//    CarregarDadosGPX(tpPlanejada);
//    MostrarRotaAproximada;
//    FinalizaCarregamento;
//  End;
//end;

procedure TfrmVisualizarMapaGoogle.RotaAproximada;
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

function TfrmVisualizarMapaGoogle.RotaAutorizada(AStartCoordinate,
  AEndCoordinate: TTMSFNCMapsCoordinateRec; Index,
  QtdePontos: Integer): Boolean;
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

function TfrmVisualizarMapaGoogle.RotaExportada(tpRota: ITipoRota): boolean;
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

procedure TfrmVisualizarMapaGoogle.routeCalculatorCalculateRoute(
  Sender: TObject; const ARoute: TTMSFNCRouteCalculatorRoute);
begin
  inherited;
  If ARoute.ID.Contains('Planejada') Then
  Begin
    Inc(rotasPlotadas);
    googleMaps.RouteCalculatorPlotRoute(ARoute);

    If FinalizouCalculoRotaPlanejada Then
    Begin
      CalcularRastreamento;
      CarregarRotaEfetuada;
    End;
  End;

  If ARoute.ID.Contains('Efetuada') Then
  Begin
    Inc(rotasPlotadas);
    googleMaps.RouteCalculatorPlotRoute(ARoute);

    If FinalizouCalculoRotaPlanejada Then
      FinalizaCarregamento;
  End;
end;

procedure TfrmVisualizarMapaGoogle.SalvarDadosGPX;
begin
  If SalvarGPX Then
    if Assigned(Romaneio) Then
      If NenhumaRotaGPXeRastreamentosPendentes Then
        ExportaRotasGPX;
end;

function TfrmVisualizarMapaGoogle.StrToCoordinate(
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

function TfrmVisualizarMapaGoogle.TemRastreamento: Boolean;
begin
  Result := True;

  If Not Assigned(Romaneio) Then
    Result := False

  Else If (Romaneio.Rastreamentos.Count <= 1) Then
    Result := False;
end;

//function TfrmVisualizarMapaGoogle.TemRotaAproximadaGPX: Boolean;
//Var
//  RotaGPX : IRotaGPX;
//begin
//  Result := False;
//
//  For RotaGPX in Romaneio.RotasGPX Do
//  Begin
//    If RotaGPX.TipoRota = tpAproximada Then
//    Begin
//      Result := True;
//      Exit;
//    End;
//  End;
//end;

procedure TfrmVisualizarMapaGoogle.tmrRotasTimer(Sender: TObject);
begin
  inherited;
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
