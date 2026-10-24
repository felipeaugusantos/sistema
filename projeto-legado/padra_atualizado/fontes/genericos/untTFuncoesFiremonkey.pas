{***********************************************************}
{* Classe criada para permitir acesso ao untFuncoesSimples *}
{* pelas bpls feitas em firemonkey, pois por ser de um     *}
{* framework diferente não é possível adicionar a          *}
{* untFuncoesSimples dentro dessas bpls.                   *}
{********************************************************MM*}

unit untTFuncoesFiremonkey;

interface

uses
   System.Classes, VCL.Forms, FMX.Forms, Principal.View.Interfaces,
   untFuncoesSimples, FMX.TMSFNCMapsCommonTypes, StrUtils, System.SysUtils,
   TaEntregue.Romaneios.Interfaces, untMaplinkTripClasses,
   untVisualizarMapaMaplink, untVisualizarMapaGoogle, untGeradorJSONRotas;

type
  TFuncoes = class(TInterfacedObject, IFuncoes)
  public
    procedure BrowserNavigate(strURL: String; AAbrirNoAutcom: Boolean = False);
    function fRetTempo(intSegund: Integer): String;
    function fCfgSis(strCamCfg: String; varTipVar: TVarType = varString; strCodEmp: String = '') : Variant;
    function fVerificaAcessoSistema(strNomeForm: String; strCodOpe: String = ''): Boolean;
    function StrToCoordinate(ACoordenada: String): TTMSFNCMapsCoordinateRec;
    function RunningInTSPlus : Boolean;
    procedure AbrirMapaGoogle(Romaneio : IRomaneio;
                              lstEntregas, lstDivergencias : TStringlist;
                              fltTotDistancia : Double;
                              intTotTempo : integer;
                              TaEntregue : ITaEntregue);
    procedure AbrirMapaMaplink(Romaneio : IRomaneio;
                               lstEntregas, lstDivergencias : TStringlist;
                               fltTotDistancia : Double;
                               intTotTempo : integer;
                               mapLinkRotaPlanejada,
                               mapLinkRotaEfetuada : TRetornoMaplinkTrip;
                               TaEntregue : ITaEntregue);
    function CheckEdgeBrowser: Boolean;
    function UtilizaModoClassico: Boolean;
    function fMensagem(strTitulo, strTexto: String; arrOpcoes: Array Of String): Integer;
    function GerarArquivoJSON(Romaneio: IRomaneio; ADivergentes: TStringList; ATotalizador: TTotalizaRotas): string;
    function RetCNPJEmpresa(ACodEmp : String) : String;
    function GetAuthorizationMaps: String;
    procedure GravarLogErro(const AstrErro, AstrLocal: String);
  end;

implementation

{ TFuncoes }

procedure TFuncoes.AbrirMapaGoogle(Romaneio: IRomaneio; lstEntregas,
  lstDivergencias: TStringlist; fltTotDistancia: Double; intTotTempo: integer;
  TaEntregue: ITaEntregue);
Var
  strGoogleAPIKey : String;
begin
  strGoogleAPIKey := fCfgSis('KEYMDP', varString);

  frmVisualizarMapaGoogle := TfrmVisualizarMapaGoogle.Create(Nil);
  Try
    frmVisualizarMapaGoogle.objFuncoes                         := Self;
    frmVisualizarMapaGoogle.googleMaps.APIKey                  := strGoogleAPIKey;
    frmVisualizarMapaGoogle.routeCalculator.APIKey             := strGoogleAPIKey;
    frmVisualizarMapaGoogle.filtrarRotas.APIKey                := strGoogleAPIKey;
    frmVisualizarMapaGoogle.Left                               := 0;
    frmVisualizarMapaGoogle.Top                                := 0;
    frmVisualizarMapaGoogle.Width                              := Screen.WorkAreaWidth;
    frmVisualizarMapaGoogle.Height                             := Screen.WorkAreaHeight;
    frmVisualizarMapaGoogle.WindowState                        := TWindowState.wsMaximized;
    frmVisualizarMapaGoogle.geoLocalizacao.APIKEy              := strGoogleAPIKey;
    frmVisualizarMapaGoogle.lstEndEntregas                     := lstEntregas;
    frmVisualizarMapaGoogle.lstDivergencias                    := lstDivergencias;
    frmVisualizarMapaGoogle.Romaneio                           := Romaneio;
    frmVisualizarMapaGoogle.TaEntregue                         := TaEntregue;

    If Assigned(Romaneio) Then
      frmVisualizarMapaGoogle.strNumRomLog                       := Romaneio.NumeroRomaneio;

    frmVisualizarMapaGoogle.lblTempoRotaPlanejada.Tag          := intTotTempo;
    frmVisualizarMapaGoogle.lblTempoRotaPlanejada.Caption      := Self.fRetTempo(intTotTempo);
    frmVisualizarMapaGoogle.lblDistanciaRotaPlanejada.Hint     := fltTotDistancia.ToString();
    frmVisualizarMapaGoogle.lblDistanciaRotaPlanejada.Caption  := FormatFloat('#,##0.00', fltTotDistancia) + ' km';

    Case fCfgSis('TPROEF', varString) = 'S' Of
      True  : frmVisualizarMapaGoogle.tpRotaEfetuada := rtExata;
      False : frmVisualizarMapaGoogle.tpRotaEfetuada := rtAproximada;
    End;

    frmVisualizarMapaGoogle.ShowModal;
  Finally
    FreeAndNil(frmVisualizarMapaGoogle);
  End;
end;

procedure TFuncoes.AbrirMapaMaplink(Romaneio: IRomaneio;
                                    lstEntregas,
                                    lstDivergencias: TStringlist;
                                    fltTotDistancia: Double;
                                    intTotTempo: integer;
                                    mapLinkRotaPlanejada,
                                    mapLinkRotaEfetuada : TRetornoMaplinkTrip;
                                    TaEntregue: ITaEntregue);
Var
  strGoogleAPIKey : String;
begin
  strGoogleAPIKey := fCfgSis('KEYMDP', varString);

  frmVisualizarMapaMaplink := TfrmVisualizarMapaMaplink.Create(Nil);
  Try
    frmVisualizarMapaMaplink.objFuncoes                         := Self;
    frmVisualizarMapaMaplink.googleMaps.APIKey                  := strGoogleAPIKey;
    frmVisualizarMapaMaplink.routeCalculator.APIKey             := strGoogleAPIKey;
    frmVisualizarMapaMaplink.filtrarRotas.APIKey                := strGoogleAPIKey;
    frmVisualizarMapaMaplink.Left                               := 0;
    frmVisualizarMapaMaplink.Top                                := 0;
    frmVisualizarMapaMaplink.Width                              := Screen.WorkAreaWidth;
    frmVisualizarMapaMaplink.Height                             := Screen.WorkAreaHeight;
    frmVisualizarMapaMaplink.WindowState                        := TWindowState.wsMaximized;
    frmVisualizarMapaMaplink.geoLocalizacao.APIKey              := strGoogleAPIKey;
    frmVisualizarMapaMaplink.lstEndEntregas                     := lstEntregas;
    frmVisualizarMapaMaplink.lstDivergencias                    := lstDivergencias;
    frmVisualizarMapaMaplink.Romaneio                           := Romaneio;
    frmVisualizarMapaMaplink.TaEntregue                         := TaEntregue;

    If Assigned(Romaneio) Then
      frmVisualizarMapaMaplink.strNumRomLog                       := Romaneio.NumeroRomaneio;

    frmVisualizarMapaMaplink.lblTempoRotaPlanejada.Tag          := intTotTempo;
    frmVisualizarMapaMaplink.lblTempoRotaPlanejada.Caption      := Self.fRetTempo(intTotTempo);
    frmVisualizarMapaMaplink.lblDistanciaRotaPlanejada.Hint     := fltTotDistancia.ToString;
    frmVisualizarMapaMaplink.lblDistanciaRotaPlanejada.Caption  := FormatFloat('#,##0.00', fltTotDistancia) + ' km';
    frmVisualizarMapaMaplink.mapLinkRotaPlanejada               := mapLinkRotaPlanejada;
    frmVisualizarMapaMaplink.mapLinkRotaEfetuada                := mapLinkRotaEfetuada;

    Case fCfgSis('TPROEF', varString) = 'S' Of
      True  : frmVisualizarMapaMaplink.tpRotaEfetuada := rtExata;
      False : frmVisualizarMapaMaplink.tpRotaEfetuada := rtAproximada;
    End;

    frmVisualizarMapaMaplink.ShowModal;
  Finally
    FreeAndNil(frmVisualizarMapaMaplink);
  End;
end;

procedure TFuncoes.BrowserNavigate(strURL: String; AAbrirNoAutcom: Boolean = False);
begin
  If AAbrirNoAutcom Then
    BrowserNavigateOnAutcom(strURL)
  Else
  pBrowserNavigate(strURL);
end;

function TFuncoes.CheckEdgeBrowser: Boolean;
begin
  Result := untFuncoesSimples.CheckEdgeBrowser;
end;

function TFuncoes.fCfgSis(strCamCfg: String; varTipVar: TVarType;
  strCodEmp: String): Variant;
begin
  Result := untFuncoesSimples.fCfgSis(strCamCfg, varTipVar, strCodEmp);
end;

function TFuncoes.fMensagem(strTitulo, strTexto: String; arrOpcoes: Array Of String): Integer;
begin
  Result := untFuncoesSimples.fMensagem(strTitulo, strTexto, arrOpcoes);
end;

function TFuncoes.fRetTempo(intSegund: Integer): String;
begin
  Result := untFuncoesSimples.fRetTempo(intSegund);
end;

function TFuncoes.fVerificaAcessoSistema(strNomeForm,
  strCodOpe: String): Boolean;
begin
  Result := untFuncoesSimples.fVerificaAcessoSistema(strNomeForm, strCodOpe);
end;

function TFuncoes.GerarArquivoJSON(Romaneio: IRomaneio; ADivergentes: TStringList;
  ATotalizador: TTotalizaRotas): string;
var
  GeradorJSON: TGeradorJSONRotas;
begin
  GeradorJSON := TGeradorJSONRotas.Create;
  try
    Result := GeradorJSON.GerarArquivoJSON(Romaneio, ADivergentes, ATotalizador);
  finally
    FreeAndNil(GeradorJSON);
  end;
end;

{***********************************************************}
{* Log das views FMX. A pilha vem de fRetornaStack aqui, no *}
{* lado VCL, ainda dentro da cadeia de chamada do handler.  *}
{***********************************************************}
procedure TFuncoes.GravarLogErro(const AstrErro, AstrLocal: String);
begin
  pGravaLogErrArquivoLocal(AstrErro, fRetornaStack, AstrLocal);
end;

function TFuncoes.GetAuthorizationMaps: String;
begin
  Result := untFuncoesSimples.fGetAuthorizationMaps;
end;

function TFuncoes.RetCNPJEmpresa(ACodEmp: String): String;
begin
  Result := untFuncoesSimples.fRetCNPJEmpresa(ACodEmp);
end;

function TFuncoes.RunningInTSPlus: Boolean;
begin
  Result := untFuncoesSimples.RunningInTSPlus;
end;

function TFuncoes.StrToCoordinate(
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

function TFuncoes.UtilizaModoClassico: Boolean;
begin
  Result := untFuncoesSimples.blnUsuarioLogadoUtilizaModoClassico;
end;

end.
