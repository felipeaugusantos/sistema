unit untFatRomRoteiro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Grids, DBGridCitel, DBGrids, Uni,
  AppEvnts, DB, BitBtnLockedIncrem, UniClientDataSet, frxClass, System.UITypes,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels, untConstantes,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxProgressBar,
  cxDataStorage, cxEdit, cxNavigator, untGravando, Math, untMapsDistanceMatrix,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxImageComboBox, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGridCitel, cxGrid,
  System.ImageList, Vcl.ImgList, cxImageList, dxGDIPlusClasses, EditFocus,
  QColorLabel, Vcl.WinXCtrls, Principal.View.FMXMensagemInstalacaoWebView,
  VCL.TMSFNCCustomComponent, VCL.TMSFNCCloudBase, VCL.TMSFNCGeocoding, VCL.TMSFNCMapsCommonTypes,  
  TaEntregue.Romaneios.Interfaces, cxDropDownEdit, untTFuncoesFiremonkey,
  untControllerMaplinkTrip, untMaplinkTripClasses, untGeradorJSONRotas,
  IdHTTP, IdComponent, System.JSON, Principal.View.Interfaces;

type
  TApiMaplink = (MaplinkPlanning, MaplinkDistanceMatrix);
  TApiCitel = (CitelTrip, CitelTable);

  TfrmFatRomRoteiro = class(TfrmPai)
    btnMoveCima: TBitBtnLocked;
    btnMoveBaixo: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    dtsTmpDoc: TDataSource;
    cxImageList: TcxImageList;
    btnRotaAPI: TBitBtnLocked;
    splDefRota: TSplitView;
    pnlRota: TPanel;
    gpbFiliais: TGroupBox;
    cxgCarga: TcxGridCitel;
    cxgCargaDBTableViewCitel: TcxGridDBTableViewCitel;
    cxgCargaMARDES: TcxGridDBColumn;
    cxgCargaEMP_CODEMP: TcxGridDBColumn;
    cxgCargaEMP_NOMEMP: TcxGridDBColumn;
    cxgCargaEMP_C_G_C_: TcxGridDBColumn;
    cxgCargaEMP_ENDERE: TcxGridDBColumn;
    cxgCargaEMP_BAIRRO: TcxGridDBColumn;
    cxgCargaEMP_C_E_P_: TcxGridDBColumn;
    cxgCargaEMP_CODCID: TcxGridDBColumn;
    cxgCargaCID_NOMCID: TcxGridDBColumn;
    cxgCargaCID_ESTADO: TcxGridDBColumn;
    cxgCargaLevel: TcxGridLevel;
    gpbEntregas: TGroupBox;
    cxgItens: TcxGridCitel;
    cxgItensDBTableViewCitel: TcxGridDBTableViewCitel;
    GER_SEQUEN: TcxGridDBColumn;
    GER_NUMDOC: TcxGridDBColumn;
    GER_CODEMP: TcxGridDBColumn;
    GER_NOMCLI: TcxGridDBColumn;
    GER_NOMCID: TcxGridDBColumn;
    GER_ESTADO: TcxGridDBColumn;
    GER_BAIRRO: TcxGridDBColumn;
    GER_ENDCON: TcxGridDBColumn;
    GER_CEPCON: TcxGridDBColumn;
    GER_TRANSP: TcxGridDBColumn;
    GER_ORDIMP: TcxGridDBColumn;
    DISTAENTREGA: TcxGridDBColumn;
    TEMPOENTREGA: TcxGridDBColumn;
    GER_LOCALI: TcxGridDBColumn;
    cxgItensLevel: TcxGridLevel;
    GER_FILIAL: TcxGridDBColumn;
    geolocalizacao: TTMSFNCGeocoding;
    GER_PRIORI: TcxGridDBColumn;
    pnlLegenda: TPanel;
    imgAguard: TImage;
    imgLocali: TImage;
    imgErro: TImage;
    lblAguard: TLabel;
    lblLocali: TLabel;
    lblErro: TLabel;
    lblInfo: TLabel;
    imgInfo: TImage;
    lblIndicadores: TLabel;
    btnInfo: TBitBtnLocked;
    btnVisualizarMapa: TBitBtnLocked;
    btnConsultaEndereco: TBitBtnLocked;
    DISTACUMULADA: TcxGridDBColumn;
    TEMPOACUMULADO: TcxGridDBColumn;
    scrRota: TScrollBox;
    rdgPtInic: TRadioGroup;
    rdgCaminho: TRadioGroup;
    rdgTrajetoGoogle: TRadioGroup;
    gpbTrajetoMaplink: TGroupBox;
    chkTunnels: TCheckBox;
    chkBridges: TCheckBox;
    chkFerries: TCheckBox;
    chkTollRoads: TCheckBox;
    chkTollGates: TCheckBox;
    gpbLibMot: TGroupBox;
    Label1: TLabel;
    ColorLabel22: TColorLabel;
    edtLibApp: TEditFocus;
    btnCalcularRota: TBitBtnLocked;
    gbpOpcOrd: TGroupBox;
    rdbMelhorRota: TRadioButton;
    rdbSelPertoLonge: TRadioButton;
    rdbPertoLonge: TRadioButton;
    rdbSelLongePerto: TRadioButton;
    rdbLongePerto: TRadioButton;
    rdbDefinido: TRadioButton;
    gpbConclusaoRomaneio: TGroupBox;
    rdbRetornarLoja: TRadioButton;
    rdbNaoRetornar: TRadioButton;
    rdbRetornarEndMotorista: TRadioButton;
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnMoveCimaClick(Sender: TObject);
    procedure btnMoveBaixoClick(Sender: TObject);
    procedure pMovimenta(strDirecao: String);
    procedure FormShow(Sender: TObject);
    procedure btnRotaAPIClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCalcularRotaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cxgCargaDBTableViewCitelCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgCargaDBTableViewCitelDblClick(Sender: TObject);
    procedure cxgCargaDBTableViewCitelKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgItensDBTableViewCitelCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure btnVisualizarMapaClick(Sender: TObject);
    procedure cxgItensDBTableViewCitelDblClick(Sender: TObject);
    procedure btnConsultaEnderecoClick(Sender: TObject);
    procedure cxgItensDBTableViewCitelCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure btnInfoClick(Sender: TObject);
    procedure rdbMelhorRotaClick(Sender: TObject);
    procedure rdbPertoLongeClick(Sender: TObject);
    procedure rdbSelPertoLongeClick(Sender: TObject);
    procedure rdbDefinidoClick(Sender: TObject);
    procedure rdbSelLongePertoClick(Sender: TObject);
    procedure rdbLongePertoClick(Sender: TObject);
    procedure rdgPtInicClick(Sender: TObject);
    procedure rdbRetornarEndMotoristaClick(Sender: TObject);
  private
    FTaEntregue : ITaEntregue;

    procedure pConsultaMatrizDeDistancia;
    procedure pCalcTmpDis;
    procedure pAlteraOrdImp(strDocOri, strEspDoc, strCodEmp, strOrdImp : String);
    function fRetEvitar: TAvoid;
    procedure pLimpaRota(blnLimpaPrioridade: Boolean);
    procedure pDefinePrioridade(intRecNoPrioridade: Integer);
    procedure pInverteOrdem;
    procedure pDefineLibApp;
    procedure pDefineInicioPartida;
    procedure pDefineFinalRota;
    procedure pDefineCoordenada(strCoordenada: String);
    procedure pAtualizaEntCli(strCoordenada: String);
    procedure pCarregaEmpresas;
    function fRetEmpresas: String;
    procedure pSelecionaEmpresa;
    procedure pRemoverEmpresaDaRota;
    procedure pAdicionarEmpresaNaRota;
    procedure pMarcaEmpresas;
    procedure pMarcaDesmarcaCargaNaFilial;
    function fSeleciona(pgbStatus: TcxProgressBar = Nil): Boolean;
    procedure pMostrarBotaoVisualizarMapa;
    function CheckEdgeBrowser: Boolean;
    function fTemEnderecoCalculadoComPossivelDivergencia: Boolean;
    procedure pPlanejarRotaMaplink;
    procedure pCarregaOpcoesDoCalculoDeRota;
    function fRetEvitarMaplink: TArray<String>; overload;
    procedure pAddEvitarMaplink(var arrEvitar: TArray<String>; strEvitar: String);
    procedure pDefineOpcaoDePlanejamento;
    function fApiMaplink: TApiMaplink;
    procedure pHabilitaColunaPrioridade;
    procedure pAjustaOpcoesDePlanejamento;
    function fCarregaInfoRotasCitel(pgbProgresso: TcxProgressBar): Boolean;
    function fCarregaInfoRotasMaplink(pgbProgresso: TcxProgressBar): Boolean;
    function fCarregaInfoRotasGoogle(pgbProgresso: TcxProgressBar): Boolean;
    function fLatLonMotoristaCadastrada: Boolean;
    procedure pPlanejarRotaCitel;
    function fApiCitel: TApiCitel;
    function fTemFilialNaRota: Boolean;
    function GetURLRotas(JSONRoutes: String): string;
    procedure OnWork(Sender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    function ExtrairHash(const JSONString: string): string;
    function fLatLonLojaCadastrada: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    cdsTmpDoc,
    cdsRomRet,
    cdsCadEmp,
    cdsOutDig: TUniClientDataSet;

    dtsCadEmp: TDataSource;

    strCodMot: String;
    strDefCon: String;
  published
    property TaEntregue: ITaEntregue Read FTaEntregue write FTaEntregue;
  end;

const
  {$IFDEF WIN64}
  CoreWebView2DLL = 'WebView2Loader_x64.dll';
  {$ELSE}
  CoreWebView2DLL = 'WebView2Loader_x86.dll';
  {$ENDIF}

var
  frmFatRomRoteiro: TfrmFatRomRoteiro;

implementation

uses untfuncoesSimples, Principal.View.FMXVisualizarMapa,
  untConsultaMapaGoogleMaps, untGeocodeRomaneio, untMaplinkPlanning,
  untMensagemExplicativa, Principal.View.FMXVisualizarMapaGoogle,
  untTypesSistema, untCitelOsrmTripApi;

{$R *.dfm}


procedure TfrmFatRomRoteiro.btnConfirmaClick(Sender: TObject);
begin
  if not fValidaCampos(edtLibApp) then
    Exit;

  if (fTemEnderecoCalculadoComPossivelDivergencia) and
     (not fPergunta('Existe endereço com possível divergência na rota calculada. Deseja confirmar mesmo assim?', False)) then
    Exit;

  inherited;

  if fCfgSis('MATDIS', varBoolean) then
    pDefineLibApp;

  close;
end;

function TfrmFatRomRoteiro.fTemEnderecoCalculadoComPossivelDivergencia: Boolean;
begin
  Result := False;

  if not fCfgSis('MATDIS', varBoolean) then
    Exit;

  cdsTmpDoc.DisableControls;

  cdsTmpDoc.First;
  while not cdsTmpDoc.Eof do
  begin
    if cdsTmpDoc.FieldByName('GER_LOCALI').AsString = 'OK?' then
    begin
      Result := True;
      Break;
    end;

    cdsTmpDoc.Next;
  end;

  cdsTmpDoc.EnableControls;
end;

procedure TfrmFatRomRoteiro.btnConsultaEnderecoClick(Sender: TObject);
var
  frmConsultaMapaGoogleMaps: TfrmConsultaMapaGoogleMaps;
begin
  inherited;
  pCriarFormularios(TfrmConsultaMapaGoogleMaps, frmConsultaMapaGoogleMaps);
  try
    frmConsultaMapaGoogleMaps.strEndere := cdsTmpDoc.FieldByName('GER_ENDCON').AsString;
    frmConsultaMapaGoogleMaps.strBairro := cdsTmpDoc.FieldByName('GER_BAIRRO').AsString;
    frmConsultaMapaGoogleMaps.strNomCid := cdsTmpDoc.FieldByName('GER_NOMCID').AsString;
    frmConsultaMapaGoogleMaps.strEstado := cdsTmpDoc.FieldByName('GER_ESTADO').AsString;

    frmConsultaMapaGoogleMaps.ShowModal;

    if frmConsultaMapaGoogleMaps.ModalResult = mrOk then
    begin
      cdsTmpDoc.DisableControls;

      cdsTmpDoc.Edit;

      cdsTmpDoc.FieldByName('BKP_ENDCON').AsString := cdsTmpDoc.FieldByName('GER_ENDCON').AsString;
      cdsTmpDoc.FieldByName('BKP_BAIRRO').AsString := cdsTmpDoc.FieldByName('GER_BAIRRO').AsString;
      cdsTmpDoc.FieldByName('BKP_NOMCID').AsString := cdsTmpDoc.FieldByName('GER_NOMCID').AsString;
      cdsTmpDoc.FieldByName('BKP_ESTADO').AsString := cdsTmpDoc.FieldByName('GER_ESTADO').AsString;
      cdsTmpDoc.FieldByName('BKP_CEPCON').AsString := cdsTmpDoc.FieldByName('GER_CEPCON').AsString;
      cdsTmpDoc.FieldByName('BKP_CODCID').AsString := cdsTmpDoc.FieldByName('CID_CODCID').AsString;
      cdsTmpDoc.FieldByName('BKP_ALTEND').AsString := cdsTmpDoc.FieldByName('GER_ALTEND').AsString;

      cdsTmpDoc.FieldByName('GER_ENDCON').AsString := frmConsultaMapaGoogleMaps.edtEndereco.Text;
      cdsTmpDoc.FieldByName('GER_BAIRRO').AsString := frmConsultaMapaGoogleMaps.edtBairro.Text;
      cdsTmpDoc.FieldByName('GER_NOMCID').AsString := frmConsultaMapaGoogleMaps.edtCidade.Text;
      cdsTmpDoc.FieldByName('GER_ESTADO').AsString := frmConsultaMapaGoogleMaps.edtEstado.Text;
      cdsTmpDoc.FieldByName('GER_CEPCON').AsString := frmConsultaMapaGoogleMaps.mskCep.Text;
      cdsTmpDoc.FieldByName('CID_CODCID').AsString := frmConsultaMapaGoogleMaps.strCodCid;
      cdsTmpDoc.FieldByName('GER_ALTEND').AsString := 'S';


      cdsTmpDoc.Post;

      cdsTmpDoc.EnableControls;
    end;
  finally
    pFreeAndNil(frmConsultaMapaGoogleMaps);
  end;
end;

procedure TfrmFatRomRoteiro.btnInfoClick(Sender: TObject);
begin
  inherited;
  TfrmMensagemExplicativa.pMensagem(
    'A coluna "Distância KM" exibe a distância considerando o ponto de partida e o ponto de entrega para o primeiro documento da rota e depois considera '+
    'a distância entre a entrega atual e a próxima entrega.'+#13#10+#13#10+

    'A coluna "Tempo Distância" exibe o tempo considerando o ponto de partida e o ponto de entrega para o primeiro documento da rota e depois considera '+
    'a distância entre a entrega atual e a próxima entrega.'+#13#10+#13#10+

    'A coluna "Percurso KM" exibe a distância considerando o ponto de partida e o percurso que será feito conforme a rota definida.'+#13#10+#13#10+

    'A coluna "Tempo Percurso" exibe o tempo considerando o ponto de partida e o percurso que será feito conforme a rota definida.'
  );
end;

procedure TfrmFatRomRoteiro.btnMoveCimaClick(Sender: TObject);
begin
  inherited;
  pMovimenta('ACIMA');
end;

procedure TfrmFatRomRoteiro.btnCalcularRotaClick(Sender: TObject);
begin
  inherited;

  If Not fLatLonLojaCadastrada Then
    Exit;

  If Not fLatLonMotoristaCadastrada Then
    Exit;

  If rdbRetornarLoja.Checked Then
    strDefCon := 'BAS'
  Else If rdbRetornarEndMotorista.Checked Then
    strDefCon := 'MOT'
  Else If rdbNaoRetornar.Checked Then
    strDefCon := 'ULT';

  lblIndicadores.Caption := EmptyStr;

  if fCfgSis('APIROT') = 'GOOGLE' then
    TfrmGravando.fExecutarModal(pConsultaMatrizDeDistancia, 'Aguarde, planejando rota...', '')
  else if fCfgSis('APIROT') = 'MAPLINK' then
    TfrmGravando.fExecutarModal(pPlanejarRotaMaplink, 'Aguarde, planejando rota...', '')
  else if fCfgSis('APIROT') = 'CITEL' then
    TfrmGravando.fExecutarModal(pPlanejarRotaCitel, 'Aguarde, planejando rota...', '');

  pMostrarBotaoVisualizarMapa;

  btnConsultaEndereco.Visible := ((btnRotaAPI.Visible) and (cdsTmpDoc.FieldByName('GER_LOCALI').ASString = 'OK?'));

  splDefRota.Close;
end;

function TfrmFatRomRoteiro.fRetEvitar: TAvoid;
begin
  Result := none;
  case rdgTrajetoGoogle.ItemIndex of
    1: Result := tolls;
    2: Result := highways;
    3: Result := ferries;
  end;

  cdsTmpDoc.First;
  while not cdsTmpDoc.Eof do
  begin
    cdsTmpDoc.Edit;
    cdsTmpDoc.FieldByName('GER_EVITAR').AsString := TControllerMapsDistanceMatrix.fRetAvoidStr(Result);
    cdsTmpDoc.Post;

    cdsTmpDoc.Next;
  end;
end;

procedure TfrmFatRomRoteiro.pDefineInicioPartida;
var
  strInicioPartida: String;
begin
  strInicioPartida := IIF(rdgPtInic.ItemIndex = 1,
                          fTiraEspacos(fCampoTabela('MOT_LATLON', 'CADMOT', ['MOT_CODMOT'], [strCodMot])),
                          fTiraEspacos(fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_LATLON']))
                         );

  cdsTmpDoc.DisableControls;

  cdsTmpDoc.First;
  while not cdsTmpDoc.Eof do
  Begin
    cdsTmpDoc.Edit;
    cdsTmpDoc.FieldByName('GER_INIPAR').AsString := strInicioPartida;
    cdsTmpDoc.Post;

    cdsTmpDoc.Next;
  end;

  cdsTmpDoc.EnableControls;
end;

procedure TfrmFatRomRoteiro.pDefineFinalRota;
var
  strFinalRota: String;
begin
  strFinalRota := EmptyStr;

  if not rdbNaoRetornar.Checked then
    strFinalRota := IIF(rdbRetornarEndMotorista.Checked,
                        fTiraEspacos(fCampoTabela('MOT_LATLON', 'CADMOT', ['MOT_CODMOT'], [strCodMot])),
                        fTiraEspacos(fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_LATLON']))
                        );

  cdsTmpDoc.DisableControls;

  cdsTmpDoc.First;
  while not cdsTmpDoc.Eof do
  Begin
    cdsTmpDoc.Edit;
    cdsTmpDoc.FieldByName('GER_FINROT').AsString := strFinalRota;
    cdsTmpDoc.Post;

    cdsTmpDoc.Next;
  end;

  cdsTmpDoc.EnableControls;
end;

function TfrmFatRomRoteiro.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  try
    if (inherited fValidaCampos(Sender, blnBuscaPorChave)) then
    begin

      if (sender = edtLibApp) and (fCfgSis('MATDIS', varBoolean)) then
      begin
        if (Pos(edtLibApp.Text, 'SN') <= 0) then
        begin
          fMensagem('ATENÇÃO!', 'Preencha o campo "Romaneio liberado para o Citel Tá Entregue" corretamente!', ['&Ok']);
          Result := False;
        end;
      end

    end;
  except
    on E: Exception do
    begin
      pMensagensErro(E.Message,'[TfrmCadClientes.fValidaCampos]');
      Result := False;
    end;
  end;

  if (not Result) then
    pSetFocus(Sender);

end;

function TfrmFatRomRoteiro.GetURLRotas(JSONRoutes: String): string;
var
  LRequisicao: TidHTTP;
  LParametros: TStringStream;
  LRespostaRequisicao,
  LHash,
  URLMaps : string;
begin
  Result := '';

  URLMaps := fCfgSis('URLMAP', varString);

  If URLMaps.IsEmpty Then
    URLMaps := 'http://maps2.citelsoftware.com.br:8080';

  LRequisicao                     := TIdHTTP.Create(Nil);
  LRequisicao.Request.Connection  := 'keep-alive';
  LRequisicao.Request.ContentType := 'application/json';
  LRequisicao.Response.KeepAlive  := True;
  LRequisicao.HTTPOptions         := [];
  LRequisicao.OnWork              := OnWork;
  LRequisicao.Request.UserAgent   := 'Mozilla/5.0';
  LRequisicao.HandleRedirects     := True;

  LRequisicao.Request.CustomHeaders.AddValue('Authorization', fGetAuthorizationMaps);
  LRequisicao.Request.CustomHeaders.AddValue('Content-Type', 'application/json');

  LParametros := TStringStream.Create(Trim(JSONRoutes), TEncoding.UTF8);

  try
    LRespostaRequisicao := LRequisicao.Post(URLMaps + '/romaneio', LParametros);

    if LRequisicao.Response.ResponseCode <> 200 then
      raise Exception.Create(LRequisicao.Response.ResponseCode.ToString + ' - ' + LRespostaRequisicao);
  except
    on E: Exception do
      raise Exception.Create('Erro: ' + E.Message + sLineBreak +
                             'URL: ' + URLMaps + '/romaneio' + sLineBreak +
                             'Resposta do Servidor: ' + LRespostaRequisicao);
  end;

  LHash  := ExtrairHash(LRespostaRequisicao);
  Result := URLMaps + '/?hash=' + LHash;

  FreeAndNil(LRequisicao);
  FreeAndNil(LParametros);
end;

procedure TfrmFatRomRoteiro.OnWork(Sender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
begin
  Application.ProcessMessages;
end;

procedure TfrmFatRomRoteiro.pLimpaRota(blnLimpaPrioridade: Boolean);
begin
  cdsTmpDoc.DisableControls;

  cdsTmpDoc.First;
  while not cdsTmpDoc.Eof do
  Begin
    cdsTmpDoc.Edit;
    cdsTmpDoc.FieldByName('GER_LOCALI').AsString := '';
    if blnLimpaPrioridade then
      cdsTmpDoc.FieldByName('PRIORIDADE').AsInteger := 0;
    cdsTmpDoc.Post;

    cdsTmpDoc.Next;
  end;

  cdsTmpDoc.EnableControls;
end;

procedure TfrmFatRomRoteiro.pDefineCoordenada(strCoordenada: String);
begin
  cdsTmpDoc.Edit;
  cdsTmpDoc.FieldByName('GER_LATLON').AsString := strCoordenada;
  cdsTmpDoc.Post;
end;

procedure TfrmFatRomRoteiro.pDefineLibApp;
begin
  cdsTmpDoc.First;
  while not cdsTmpDoc.Eof do
  begin
    cdsTmpDoc.Edit;
    cdsTmpDoc.FieldByName('GER_LIBAPP').AsString := edtLibApp.Text;
    cdsTmpDoc.Post;

    cdsTmpDoc.Next;
  end;
end;

procedure TfrmFatRomRoteiro.pDefinePrioridade(intRecNoPrioridade: Integer);
var
  strFiltro,
  strCodEmp: String;

  blnFiltro: Boolean;
begin
  cdsTmpDoc.DisableControls;

  if (rdbSelPertoLonge.Checked) or (rdbSelLongePerto.Checked) then
  begin
    cdsTmpDoc.RecNo := intRecNoPrioridade;

    strCodEmp := cdsTmpDoc.FieldByName('GER_CODEMP').AsString;

    cdsTmpDoc.Edit;
    cdsTmpDoc.FieldByName('PRIORIDADE').AsInteger := 1;
    cdsTmpDoc.Post;

    blnFiltro := cdsTmpDoc.Filtered;
    strFiltro := cdsTmpDoc.Filter;

    cdsTmpDoc.Filtered := False;
    cdsTmpDoc.Filter := strFiltro + ' AND GER_CODEMP = ' + QuotedStr(strCodEmp) + ' AND GER_FILIAL = '+QuotedStr('S');
    cdsTmpDoc.Filtered := True;

    if not cdsTmpDoc.IsEmpty then
    begin
      cdsTmpDoc.Edit;
      cdsTmpDoc.FieldByName('PRIORIDADE').AsInteger := 1;
      cdsTmpDoc.Post;
    end;

    cdsTmpDoc.Filtered := False;
    cdsTmpDoc.Filter := strFiltro;
    cdsTmpDoc.Filtered := blnFiltro;
  end;

  cdsTmpDoc.EnableControls;
end;

procedure TfrmFatRomRoteiro.pInverteOrdem;
var
  intOrdemIni: Integer;
begin
  cdsTmpDoc.DisableControls;

  cdsTmpDoc.Filtered := False;
  cdsTmpDoc.Filter := 'GER_MARDES = '+QuotedStr('M')+' AND GER_ORDIMP > 0 AND GER_LOCALI = '+QuotedStr('OK')+' AND PRIORIDADE = 0 ';
  cdsTmpDoc.Filtered := True;

  cdsTmpDoc.First;
  intOrdemIni := cdsTmpDoc.FieldByName('GER_ORDIMP').AsInteger;
  cdsTmpDoc.Last;
  while not cdsTmpDoc.IsEmpty do
  begin
    cdsTmpDoc.Edit;
    cdsTmpDoc.FieldByName('GER_ORDIMP').AsInteger := intOrdemIni;
    cdsTmpDoc.FieldByName('GER_LOCALI').AsString := '';
    cdsTmpDoc.Post;

    Inc(intOrdemIni);
  end;

  cdsTmpDoc.EnableControls;
end;

procedure TfrmFatRomRoteiro.pConsultaMatrizDeDistancia;
var
  blnFilter: Boolean;
  strFilter: String;
  intRecNoPrioridade: Integer;

  blnProcessado: Boolean;
begin
  blnFilter := cdsTmpDoc.Filtered;
  strFilter := cdsTmpDoc.Filter;

  cdsTmpDoc.DisableControls;

  if fCfgSis('APIROT') = 'GOOGLE' then
  begin
    intRecNoPrioridade := cdsTmpDoc.RecNo;
    pLimpaRota(True);
    pDefinePrioridade(intRecNoPrioridade);
    pDefineInicioPartida;
    pDefineFinalRota;

    TControllerMapsDistanceMatrix.pProcessarMapsDistanceMatrix(cdsTmpDoc,
                                                               cdsRomRet,
                                                               IIF(rdbDefinido.Checked, ordFixed, ordNone),
                                                               fRetEvitar,
                                                               blnProcessado,
                                                               EmptyStr,
                                                               True);
  end
  else if fCfgSis('APIROT') = 'MAPLINK' then
    TControllerMapsDistanceMatrix.pProcessarMapsDistanceMatrix(cdsTmpDoc,
                                                               cdsRomRet,
                                                               IIF(rdbDefinido.Checked, ordFixed, ordNone),
                                                               fRetEvitarMaplink,
                                                               IIF(rdgCaminho.ItemIndex = 0, THE_FASTEST, THE_SHORTEST),
                                                               blnProcessado,
                                                               EmptyStr,
                                                               True)
  else if fCfgSis('APIROT') = 'CITEL' then
    TControllerMapsDistanceMatrix.pProcessarMapsDistanceMatrix(cdsTmpDoc,
                                                               cdsRomRet,
                                                               IIF(rdbDefinido.Checked, ordFixed, ordNone),
                                                               blnProcessado,
                                                               EmptyStr,
                                                               True);

  if (rdbLongePerto.Checked) or (rdbSelPertoLonge.Checked) or (rdbSelLongePerto.Checked) then
  begin
    if (rdbLongePerto.Checked) or (rdbSelLongePerto.Checked) then
      pInverteOrdem;

    cdsTmpDoc.Filtered := False;
    cdsTmpDoc.Filter := strFilter;
    cdsTmpDoc.Filtered := blnFilter;

    if (rdbSelPertoLonge.Checked) or (rdbSelLongePerto.Checked) then
      pLimpaRota(True);

    if fCfgSis('APIROT') = 'GOOGLE' then
      TControllerMapsDistanceMatrix.pProcessarMapsDistanceMatrix(cdsTmpDoc,
                                                                 cdsRomRet,
                                                                 ordFixed,
                                                                 fRetEvitar,
                                                                 blnProcessado,
                                                                 EmptyStr,
                                                                 True)
    else if fCfgSis('APIROT') = 'MAPLINK' then
      TControllerMapsDistanceMatrix.pProcessarMapsDistanceMatrix(cdsTmpDoc,
                                                                 cdsRomRet,
                                                                 ordFixed,
                                                                 fRetEvitarMaplink,
                                                                 IIF(rdgCaminho.ItemIndex = 0, THE_FASTEST, THE_SHORTEST),
                                                                 blnProcessado,
                                                                 EmptyStr,
                                                                 True)
    else if fCfgSis('APIROT') = 'CITEL' then
      TControllerMapsDistanceMatrix.pProcessarMapsDistanceMatrix(cdsTmpDoc,
                                                                 cdsRomRet,
                                                                 ordFixed,
                                                                 blnProcessado,
                                                                 EmptyStr,
                                                                 True);
  end;

  cdsTmpDoc.Filtered := False;
  cdsTmpDoc.Filter := strFilter;
  cdsTmpDoc.Filtered := blnFilter;

  cdsTmpDoc.EnableControls;

  pCalcTmpDis;
end;

procedure TfrmFatRomRoteiro.pCalcTmpDis;
var
  fltTotalDistancia: Double;
  intTotalTempo: Integer;
begin
  fltTotalDistancia := 0;
  intTotalTempo := 0;

  if (fCfgSis('MATDIS', varBoolean)) then
  begin
    cdsTmpDoc.First;
    if (cdsTmpDoc.FieldByName('GER_DISTAN').AsFloat > 0) and
       (cdsTmpDoc.FieldByName('GER_TMPENT').AsFloat > 0) then
    begin
      cdsTmpDoc.DisableControls;

      while not cdsTmpDoc.Eof do
      Begin
        fltTotalDistancia := fltTotalDistancia + cdsTmpDoc.FieldByName('GER_DISTAN').AsFloat;
        intTotalTempo := intTotalTempo + cdsTmpDoc.FieldByName('GER_TMPENT').AsInteger;

        cdsTmpDoc.Edit;

        cdsTmpDoc.FieldByName('DISTAENTREGA').AsString := FloatToStr(cdsTmpDoc.FieldByName('GER_DISTAN').AsFloat) + ' km';
        cdsTmpDoc.FieldByName('TEMPOENTREGA').AsString := fRetTempo(cdsTmpDoc.FieldByName('GER_TMPENT').AsInteger);

        cdsTmpDoc.FieldByName('DISTACUMULADA').AsString := FloatToStr(fltTotalDistancia) + ' km';
        cdsTmpDoc.FieldByName('TEMPOACUMULADO').AsString := fRetTempo(intTotalTempo);

        cdsTmpDoc.Post;

        cdsTmpDoc.Next;
      end;

      cdsTmpDoc.EnableControls;

      fltTotalDistancia := fltTotalDistancia + cdsRomRet.FieldByName('RET_DISTAN').AsFloat;
      intTotalTempo := intTotalTempo + cdsRomRet.FieldByName('RET_TMPRET').AsInteger;
      lblIndicadores.Caption := 'Retorno: ' + FloatToStr(cdsRomRet.FieldByName('RET_DISTAN').AsFloat) + 'km (' + fRetTempo(cdsRomRet.FieldByName('RET_TMPRET').AsInteger) + ')  |  ' +
                                'Percurso Total: ' + FloatToStr(fltTotalDistancia) + 'km (' + fRetTempo(intTotalTempo)+')    ';
    end;
  end;
end;

procedure TfrmFatRomRoteiro.btnRotaAPIClick(Sender: TObject);
begin
  inherited;
  if splDefRota.Opened then
    splDefRota.Close
  else
    splDefRota.Open;
end;

procedure TfrmFatRomRoteiro.btnVisualizarMapaClick(Sender: TObject);
Var
  KeyGoogleMaps : String;
begin
  KeyGoogleMaps := fCfgSis('KEYMDP', varString);

  If (KeyGoogleMaps.IsEmpty) Then
  Begin
    pMensagemOk('A chave API do Google Maps não foi informada' + #13 + #13 +
                'Procure por CFG_KEYMDP nas configurações do sistema e informe a chave correta.');
    Exit;
  End;

  If Not CheckEdgeBrowser Then
  Begin
    FmxMensagemInstalacaoWebView := TFmxMensagemInstalacaoWebView.Create(Self);
    FmxMensagemInstalacaoWebView.objFuncoes := TFuncoes.Create;
    FmxMensagemInstalacaoWebView.ShowModal;
    Exit;
  End;

  if (fCfgSis('APIROT') = 'GOOGLE') then
    fChamaTelaGravando(fCarregaInfoRotasGoogle)

  else if fCfgSis('APIROT') = 'MAPLINK' then
    fChamaTelaGravando(fCarregaInfoRotasMaplink)

  else if fCfgSis('APIROT') = 'CITEL' then
    fChamaTelaGravando(fCarregaInfoRotasCitel);
end;

function TfrmFatRomRoteiro.CheckEdgeBrowser: Boolean;
begin
  Result := untFuncoesSimples.CheckEdgeBrowser;
end;

procedure TfrmFatRomRoteiro.pSelecionaEmpresa;
Var
  LfrmAguarde: TfrmGravando;
begin
  Try
    Try
      pCriarFormularios(TfrmGravando, LfrmAguarde);
      LfrmAguarde.fExecutarAcao := fSeleciona;
      LfrmAguarde.ShowModal;
    Finally
      pFreeAndNil(LfrmAguarde);
    End;

  Except
    On E: ExceptionAutCom Do
    Begin
      pMensagemOk(E.Message);
    End;

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;
end;

procedure TfrmFatRomRoteiro.rdbDefinidoClick(Sender: TObject);
begin
  inherited;
  pHabilitaColunaPrioridade;
end;

procedure TfrmFatRomRoteiro.rdbLongePertoClick(Sender: TObject);
begin
  inherited;
  pHabilitaColunaPrioridade;
end;

procedure TfrmFatRomRoteiro.rdbMelhorRotaClick(Sender: TObject);
begin
  inherited;
  pHabilitaColunaPrioridade;
end;

procedure TfrmFatRomRoteiro.rdbPertoLongeClick(Sender: TObject);
begin
  inherited;
  pHabilitaColunaPrioridade;
end;

procedure TfrmFatRomRoteiro.rdbRetornarEndMotoristaClick(Sender: TObject);
begin
  inherited;
  if not fLatLonMotoristaCadastrada then
      rdbRetornarLoja.Checked := True;
end;

function TfrmFatRomRoteiro.fLatLonLojaCadastrada: Boolean;
begin
  Result := True;

  If Not rdbRetornarLoja.Checked Then
    Exit;

  If fEmptyStr(fCfgSis('LATLON', varString)) Then
  Begin
    Result := False;

    fMensagem('ATENÇÃO!', 'Para utilizar esta opção é necessário que informar a latitude e longitude do endereço na configuração [CFG_LATLON]! ', ['&Ok']);
  End;
end;

function TfrmFatRomRoteiro.fLatLonMotoristaCadastrada: Boolean;
var
  strMsg: String;
  strLatLon: String;
begin
  inherited;
  Result := True;

  If Not rdbRetornarEndMotorista.Checked Then
    Exit;

  strLatLon := IIF(not fEmptyStr(strCodMot), fCampoTabela('MOT_LATLON', 'CADMOT', ['MOT_CODMOT'], [strCodMot]), '');
  if ((fEmptyStr(strCodMot)) or (fEmptyStr(strLatLon))) then
  begin
    Result := False;

    strMsg := IIF(fEmptyStr(strCodMot),
                  'Para utilizar esta opção é ncessário informar o motorista do romaneio!',
                  'Para utilizar esta opção é necessário informar a latitude e longitude do endereço no cadastro do motorista!');

    fMensagem('ATENÇÃO!', strMsg, ['&Ok']);
  end;
end;

procedure TfrmFatRomRoteiro.rdbSelLongePertoClick(Sender: TObject);
begin
  inherited;
  pHabilitaColunaPrioridade;
end;

procedure TfrmFatRomRoteiro.rdbSelPertoLongeClick(Sender: TObject);
begin
  inherited;
  pHabilitaColunaPrioridade;
end;

procedure TfrmFatRomRoteiro.rdgPtInicClick(Sender: TObject);
begin
  inherited;
  if (rdgPtInic.ItemIndex = 1) and (not fLatLonMotoristaCadastrada) then
    rdgPtInic.ItemIndex := 0;
end;

procedure TfrmFatRomRoteiro.pHabilitaColunaPrioridade;
begin
  if fCfgSis('APIROT') <> 'MAPLINK' then
    Exit;

  GER_PRIORI.Options.Editing := (rdbMelhorRota.Checked);
end;

procedure TfrmFatRomRoteiro.pDefineOpcaoDePlanejamento;
begin
  cdsTmpDoc.First;
  while not cdsTmpDoc.Eof do
  begin
    cdsTmpDoc.Edit;
    cdsTmpDoc.FieldByName('GER_FSTSHT').AsString := IIF(rdgCaminho.ItemIndex = 0, THE_FASTEST, THE_SHORTEST);
    cdsTmpDoc.Post;

    cdsTmpDoc.Next;
  end;
end;

function TfrmFatRomRoteiro.fSeleciona(pgbStatus: TcxProgressBar = Nil): Boolean;
begin
  Result := False;

  if not Assigned(cdsCadEmp) then
    Exit;

  if not cdsCadEmp.Active then
    Exit;

  if cdsCadEmp.IsEmpty then
    Exit;

  cdsCadEmp.Edit;
  cdsCadEmp.FieldByName('MARDES').AsString := IIF(cdsCadEmp.FieldByName('MARDES').AsString = 'D', 'M', 'D');
  cdsCadEmp.Post;

  pMarcaDesmarcaCargaNaFilial;

  if cdsCadEmp.FieldByName('MARDES').AsString = 'D' then
  begin
    pInformacao('Aguarde, removendo empresa da rota...', pgbStatus);
    pRemoverEmpresaDaRota;
  end
  else
  begin
    pInformacao('Aguarde, adicionando empresa na rota...', pgbStatus);
    pAdicionarEmpresaNaRota;
  end;

  Result := True;
end;

procedure TfrmFatRomRoteiro.pMarcaDesmarcaCargaNaFilial;
var
  strFiltro : String;
  blnFiltro: Boolean;
begin
  blnFiltro := cdsTmpDoc.Filtered;
  strFiltro := cdsTmpDoc.Filter;

  cdsTmpDoc.DisableControls;
  cdsTmpDoc.Filtered := False;
  cdsTmpDoc.Filter := strFiltro + ' AND GER_CODEMP = '+QuotedStr(cdsCadEmp.FieldByName('EMP_CODEMP').AsString)+
                                  ' AND GER_FILIAL <> '+QuotedStr('S');
  cdsTmpDoc.Filtered := True;

  while not cdsTmpDoc.Eof do
  begin
    cdsTmpDoc.Edit;
    cdsTmpDoc.FieldByName('CARGANAFILIAL').AsString := IIF(cdsCadEmp.FieldByName('MARDES').AsString = 'M',
                                                           cdsCadEmp.FieldByName('EMP_CODEMP').AsString,
                                                           '');
    cdsTmpDoc.Post;

    cdsTmpDoc.Next;
  end;

  cdsTmpDoc.Filtered := False;
  cdsTmpDoc.Filter := strFiltro;
  cdsTmpDoc.Filtered := blnFiltro;
  cdsTmpDoc.EnableControls;
end;

procedure TfrmFatRomRoteiro.pRemoverEmpresaDaRota;
var
  strFiltro: String;
  blnFiltro: Boolean;
begin
  blnFiltro := cdsTmpDoc.Filtered;
  strFiltro := cdsTmpDoc.Filter;

  cdsTmpDoc.DisableControls;
  cdsTmpDoc.Filtered := False;
  cdsTmpDoc.Filter := strFiltro + ' AND GER_FILIAL = '+QuotedStr('S')+' AND GER_CODEMP = '+QuotedStr(cdsCadEmp.FieldByName('EMP_CODEMP').AsString);
  cdsTmpDoc.Filtered := True;

  if not cdsTmpDoc.IsEmpty then
  begin
    if cdsOutDig.Locate('AUTINC', cdsTmpDoc.FieldByName('GER_AUTINC').AsString, []) then
      cdsOutDig.Delete;

    cdsTmpDoc.Delete;
  end;

  cdsTmpDoc.Filtered := False;
  cdsTmpDoc.Filter := strFiltro;
  cdsTmpDoc.Filtered := blnFiltro;
  cdsTmpDoc.EnableControls;
end;

procedure TfrmFatRomRoteiro.pAddEvitarMaplink(var arrEvitar: TArray<String>;
  strEvitar: String);
begin
  SetLength(arrEvitar, Length(arrEvitar)+1);
  arrEvitar[Length(arrEvitar)-1] := strEvitar;
end;

procedure TfrmFatRomRoteiro.pAdicionarEmpresaNaRota;
var
  strAutInc,
  strNumDoc: String;
begin
  strAutInc := fRetAutoIncrem('OUTDIGX', VS_strCodEmp);
  strNumDoc := fAtualizaProCod('OUTDIGX', 'DIG_NUMDOC');

  cdsOutDig.Append;
  cdsOutDig.FieldByName('AUTINC').AsString := strAutInc;
  cdsOutDig.FieldByName('NUMDOC').AsString := strNumDoc;
  cdsOutDig.FieldByName('CODVEN').AsString := strLoginUsuarioLogado;
  cdsOutDig.FieldByName('ESPDOC').AsString := 'OX';
  cdsOutDig.FieldByName('DTAENT').AsDateTime := VS_Date;
  cdsOutDig.FieldByName('HORENT').AsDateTime := fTime();
  cdsOutDig.FieldByName('DESCRI').AsString := cdsCadEmp.FieldByName('EMP_NOMEMP').AsString;
  cdsOutDig.FieldByName('CODEMP').AsString := cdsCadEmp.FieldByName('EMP_CODEMP').AsString;
  cdsOutDig.FieldByName('DTAETR').AsDateTime := VS_Date;
  cdsOutDig.FieldByName('ENDCON').AsString := cdsCadEmp.FieldByName('EMP_ENDERE').AsString;
  cdsOutDig.FieldByName('BAIRRO').AsString := cdsCadEmp.FieldByName('EMP_BAIRRO').AsString;
  cdsOutDig.FieldByName('CEPCON').AsString := cdsCadEmp.FieldByName('EMP_C_E_P_').AsString;
  cdsOutDig.FieldByName('CODCID').AsString := cdsCadEmp.FieldByName('EMP_CODCID').AsString;
  cdsOutDig.FieldByName('NOMCID').AsString := cdsCadEmp.FieldByName('CID_NOMCID').AsString;
  cdsOutDig.FieldByName('ESTADO').AsString := cdsCadEmp.FieldByName('CID_ESTADO').AsString;
  cdsOutDig.FieldByName('FILIAL').AsString := 'S';
  cdsOutDig.Post;

  cdsTmpDoc.Append;
  cdsTmpDoc.FieldByName('GER_NUMDOC').AsString := strNumDoc + '-OX';
  cdsTmpDoc.FieldByName('GER_DOCORI').AsString := strNumDoc;
  cdsTmpDoc.FieldByName('GER_CODVEN').AsString := strLoginUsuarioLogado;
  cdsTmpDoc.FieldByName('GER_ESPDOC').AsString := 'OX';
  cdsTmpDoc.FieldByName('GER_CODEMP').AsString := cdsCadEmp.FieldByName('EMP_CODEMP').AsString;
  cdsTmpDoc.FieldByName('GER_NOMCLI').AsString := Copy(cdsCadEmp.FieldByName('EMP_NOMEMP').AsString, 1, 60);
  cdsTmpDoc.FieldByName('GER_HORENT').AsDateTime := fTime();
  cdsTmpDoc.FieldByName('GER_DTAENT').AsDateTime := VS_Date;
  cdsTmpDoc.FieldByName('GER_DTENTR').AsDateTime := VS_Date;
  cdsTmpDoc.FieldByName('GER_ENTSAI').AsString := 'S';
  cdsTmpDoc.FieldByName('FIS_ACESSO').AsString := '';
  cdsTmpDoc.FieldByName('GER_VLRCON').AsFloat := 0;
  cdsTmpDoc.FieldByName('GER_VALDOC').AsFloat := 0;
  cdsTmpDoc.FieldByName('GER_MARDES').AsString := 'M';
  cdsTmpDoc.FieldByName('GER_VALSEL').AsFloat := 0;
  cdsTmpDoc.FieldByName('GER_ORDIMP').AsInteger := cdsTmpDoc.RecordCount + 1;
  cdsTmpDoc.FieldByName('INCREMENTO').AsInteger := 0;
  cdsTmpDoc.FieldByName('GER_NOMTBL').AsString := 'OUTDIGX';
  cdsTmpDoc.FieldByName('GER_TOTDET').AsFloat := 0;
  cdsTmpDoc.FieldByName('GER_ENDCON').AsString := cdsCadEmp.FieldByName('EMP_ENDERE').AsString;
  cdsTmpDoc.FieldByName('GER_BAIRRO').AsString := cdsCadEmp.FieldByName('EMP_BAIRRO').AsString;
  cdsTmpDoc.FieldByName('GER_CEPCON').AsString := cdsCadEmp.FieldByName('EMP_C_E_P_').AsString;
  cdsTmpDoc.FieldByName('CID_CODCID').AsString := cdsCadEmp.FieldByName('EMP_CODCID').AsString;
  cdsTmpDoc.FieldByName('GER_NOMCID').AsString := cdsCadEmp.FieldByName('CID_NOMCID').AsString;
  cdsTmpDoc.FieldByName('GER_ESTADO').AsString := cdsCadEmp.FieldByName('CID_ESTADO').AsString;
  cdsTmpDoc.FieldByName('GER_LOCALI').AsString := '';
  cdsTmpDoc.FieldByName('GER_FILIAL').AsString := 'S';
  cdsTmpDoc.FieldByName('GER_AUTINC').AsString := strAutInc;
  cdsTmpDoc.FieldByName('GER_LATLON').AsString := cdsCadEmp.FieldByName('EMP_LATLON').AsString;
  cdsTmpDoc.Post;
end;

procedure TfrmFatRomRoteiro.cxgCargaDBTableViewCitelCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  if not Assigned(cdsCadEmp) then
    Exit;

  if not cdsCadEmp.Active then
    Exit;

  if VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgCargaMARDES.Index]) = 'M' then
  begin
    if ACanvas.Brush.Color = clHighlight then
      ACanvas.Font.Color := clLime
    else
    begin
      ACanvas.Brush.Color := clSkyBlue;
      ACanvas.Font.Color := clBlue;
    end;
  end;
end;

procedure TfrmFatRomRoteiro.cxgCargaDBTableViewCitelDblClick(Sender: TObject);
begin
  inherited;
  pSelecionaEmpresa;
end;

procedure TfrmFatRomRoteiro.cxgCargaDBTableViewCitelKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_RETURN,
    VK_SPACE: pSelecionaEmpresa;
  end;
end;

procedure TfrmFatRomRoteiro.cxgItensDBTableViewCitelCellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  btnConsultaEndereco.Visible := ((btnRotaAPI.Visible) and (cdsTmpDoc.FieldByName('GER_LOCALI').AsString = 'OK?'));
end;

procedure TfrmFatRomRoteiro.cxgItensDBTableViewCitelCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  if not Assigned(cdsTmpDoc) then
    Exit;

  if not cdsTmpDoc.Active then
    Exit;

  if VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, GER_FILIAL.Index]) = 'S' then
  begin
    if ACanvas.Brush.Color = clHighlight then
      ACanvas.Font.Color := clLime
    else
    begin
      ACanvas.Brush.Color := clSkyBlue;
      ACanvas.Font.Color := clBlue;
    end;
  end;

  if VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, GER_LOCALI.Index]) = 'OK?' then
  begin
    if ACanvas.Brush.Color = clHighlight then
      ACanvas.Font.Color := $0039B8EE
    else
      ACanvas.Brush.Color := $0039B8EE;
  end;
end;

procedure TfrmFatRomRoteiro.cxgItensDBTableViewCitelDblClick(Sender: TObject);
begin
  inherited;

  If (fCfgSis('MATDIS', varBoolean)) Then
  Begin
    If (cdsTmpDoc.FieldByName('GER_LOCALI').AsString = 'OK?') Then
      fMensagem('INFORMAÇÃO!', 'Talvez o endereço calculado não seja o esperado!'+#13#10+#13#10+
                               'Verifique se o endereço do cliente existe no Google Maps e se ele está '+
                               'exatamente igual no Autcom(Considere também a acentuação).', ['&Ok']);
  End;
end;

function TfrmFatRomRoteiro.ExtrairHash(const JSONString: string): string;
var
  JSONArray: TJSONArray;
  JSONObject: TJSONObject;
begin
  Result := '';
  try
    JSONArray := TJSONObject.ParseJSONValue(JSONString) as TJSONArray;
    try
      if (JSONArray <> nil) and (JSONArray.Count > 0) then
      begin
        JSONObject := JSONArray.Items[0] as TJSONObject;

        if JSONObject.TryGetValue<string>('hash', Result) then
          Exit;
      end;
    finally
      JSONArray.Free;
    end;
  except
    on E: Exception do
      raise Exception.Create('Erro ao processar o JSON: ' + E.Message);
  end;
end;

procedure TfrmFatRomRoteiro.btnMoveBaixoClick(Sender: TObject);
Begin
  pMovimenta('ABAIXO');
end;

procedure TfrmFatRomRoteiro.pAlteraOrdImp(strDocOri, strEspDoc, strCodEmp,
  strOrdImp: String);
  Var
    strFiltro   : String;
    strFiltrado : Boolean;
    strIntRecNo : Integer;
begin
  strFiltro   := cdsTmpDoc.Filter;
  strFiltrado := cdsTmpDoc.Filtered;
  strIntRecNo := cdsTmpDoc.RecNo;

  cdsTmpDoc.Filtered := False;
  cdsTmpDoc.Filter   :=                    '(GER_DOCORI = ' + QuotedStr(strDocOri) + ') AND ';
  cdsTmpDoc.Filter   := cdsTmpDoc.Filter + '(GER_ESPDOC = ' + QuotedStr(strEspDoc) + ') AND ';
  cdsTmpDoc.Filter   := cdsTmpDoc.Filter + '(GER_CODEMP = ' + QuotedStr(strCodEmp) + ') ';
  cdsTmpDoc.Filtered := True;

  cdsTmpDoc.Edit;
  cdsTmpDoc.FieldByName('GER_ORDIMP').AsString := strOrdImp;
  cdsTmpDoc.Post;

  cdsTmpDoc.Filter   := strFiltro;
  cdsTmpDoc.Filtered := strFiltrado;
  cdsTmpDoc.RecNo    := strIntRecNo;
end;

procedure TfrmFatRomRoteiro.pAtualizaEntCli(strCoordenada: String);
Var
  qryUpdt : TUniQuery;
begin
  qryUpdt := fCriaQuery;

  try
    qryUpdt.Close;
    qryUpdt.SQL.Text :=
    ' UPDATE ENTCLI '+
    '    SET ETC_LATLON = :LATLON '+
    '  WHERE ETC_CODCLI = :CODCLI '+
    '    AND ETC_CIDENT = :CIDENT '+
    '    AND ETC_CEPENT = :CEPENT '+
    '    AND ETC_ENDENT = :ENDENT '+
    '    AND ETC_BAIENT = :BAIENT ';

    qryUpdt.ParamByName('LATLON').AsString := strCoordenada;
    qryUpdt.ParamByName('CODCLI').AsString := cdsTmpDoc.FieldByName('GER_CLIORI').AsString;
    qryUpdt.ParamByName('CIDENT').AsString := cdsTmpDoc.FieldByName('CID_CODCID').AsString;
    qryUpdt.ParamByName('CEPENT').AsString := cdsTmpDoc.FieldByName('GER_CEPCON').AsString;
    qryUpdt.ParamByName('ENDENT').AsString := cdsTmpDoc.FieldByName('GER_ENDCON').AsString;
    qryUpdt.ParamByName('BAIENT').AsString := cdsTmpDoc.FieldByName('GER_BAIRRO').AsString;
    qryUpdt.ExecSql;
  finally
    FreeAndNil(qryUpdt);
  end;
end;

procedure TfrmFatRomRoteiro.pAjustaOpcoesDePlanejamento;
var
  strOpcoes: String;
begin
  strOpcoes := fCfgSis('PLAROT');

  rdbMelhorRota.Visible    := (Pos(IntToStr(rdbMelhorRota.Tag)   +'_', strOpcoes) > 0);
  rdbPertoLonge.Visible    := (Pos(IntToStr(rdbPertoLonge.Tag)   +'_', strOpcoes) > 0);
  rdbLongePerto.Visible    := (Pos(IntToStr(rdbLongePerto.Tag)   +'_', strOpcoes) > 0);
  rdbSelPertoLonge.Visible := (Pos(IntToStr(rdbSelPertoLonge.Tag)+'_', strOpcoes) > 0);
  rdbSelLongePerto.Visible := (Pos(IntToStr(rdbSelLongePerto.Tag)+'_', strOpcoes) > 0);
  rdbDefinido.Visible      := (Pos(IntToStr(rdbDefinido.Tag)     +'_', strOpcoes) > 0);

  gbpOpcOrd.Height := gbpOpcOrd.Height - IIF(not rdbMelhorRota.Visible   , rdbMelhorRota.Height   , 0);
  gbpOpcOrd.Height := gbpOpcOrd.Height - IIF(not rdbPertoLonge.Visible   , rdbPertoLonge.Height   , 0);
  gbpOpcOrd.Height := gbpOpcOrd.Height - IIF(not rdbLongePerto.Visible   , rdbLongePerto.Height   , 0);
  gbpOpcOrd.Height := gbpOpcOrd.Height - IIF(not rdbSelPertoLonge.Visible, rdbSelPertoLonge.Height, 0);
  gbpOpcOrd.Height := gbpOpcOrd.Height - IIF(not rdbSelLongePerto.Visible, rdbSelLongePerto.Height, 0);
  gbpOpcOrd.Height := gbpOpcOrd.Height - IIF(not rdbDefinido.Visible     , rdbDefinido.Height     , 0);

  rdbDefinido.Checked      := rdbDefinido.Visible;
  rdbSelLongePerto.Checked := rdbSelLongePerto.Visible;
  rdbSelPertoLonge.Checked := rdbSelPertoLonge.Visible;
  rdbLongePerto.Checked    := rdbLongePerto.Visible;
  rdbPertoLonge.Checked    := rdbPertoLonge.Visible;
  rdbMelhorRota.Checked    := rdbMelhorRota.Visible;
end;

procedure TfrmFatRomRoteiro.pMarcaEmpresas;
var
  strFiltro: String;
  blnFiltro: Boolean;
begin
  blnFiltro := cdsTmpDoc.Filtered;
  strFiltro := cdsTmpDoc.Filter;

  cdsTmpDoc.DisableControls;
  cdsTmpDoc.Filter := strFiltro + ' AND GER_FILIAL = '+QuotedStr('S');
  cdsTmpDoc.Filtered := True;

  if not cdsTmpDoc.IsEmpty then
  begin
    cdsCadEmp.DisableControls;

    while not cdsTmpDoc.Eof do
    begin
      cdsCadEmp.Filtered := False;
      cdsCadEmp.Filter := 'EMP_CODEMP = '+QuotedStr(cdsTmpDoc.FieldByName('GER_CODEMP').AsString);
      cdsCadEmp.Filtered := True;

      cdsCadEmp.Edit;
      cdsCadEmp.FieldByName('MARDES').AsString := 'M';
      cdsCadEmp.Post;

      cdsTmpDoc.Next;
    end;
  end;

  cdsTmpDoc.Filtered := False;
  cdsTmpDoc.Filter := strFiltro;
  cdsTmpDoc.Filtered := blnFiltro;
  cdsTmpDoc.EnableControls;

  cdsCadEmp.Filtered := False;
  cdsCadEmp.Filter := 'MARDES = '+QuotedStr('M');
  cdsCadEmp.Filtered := True;

  while not cdsCadEmp.Eof do
  begin
    pMarcaDesmarcaCargaNaFilial;
    cdsCadEmp.Next;
  end;

  cdsCadEmp.Filtered := False;
  cdsCadEmp.EnableControls;

end;

procedure TfrmFatRomRoteiro.pMostrarBotaoVisualizarMapa;
begin
  cdsTmpDoc.First;
  while not cdsTmpDoc.Eof do
  begin
    If (cdsTmpDoc.fieldbyname('GER_LOCALI').AsString = 'OK') Then
    Begin
      btnVisualizarMapa.Visible := True;
      Exit;
    End;

    cdsTmpDoc.Next;
  end;
end;

procedure TfrmFatRomRoteiro.pMovimenta(strDirecao: String);
Var
  strNum1   : String;
  strNum2   : String;
  strDocOri1: String;
  strDocOri2: String;
  strEspDoc1: String;
  strEspDoc2: String;
  strCodEmp1: String;
  strCodEmp2: String;
  intPosicao: Integer;
begin
  strNum1   := cdsTmpDoc.fieldbyname('GER_ORDIMP').AsString;
  strDocOri1:= cdsTmpDoc.fieldbyname('GER_DOCORI').AsString;
  strEspDoc1:= cdsTmpDoc.fieldbyname('GER_ESPDOC').AsString;
  strCodEmp1:= cdsTmpDoc.fieldbyname('GER_CODEMP').AsString;

  If strDirecao = 'ACIMA' Then
    cdsTmpDoc.Prior
  Else
    cdsTmpDoc.Next;

  intPosicao := cdsTmpDoc.RecNo;

  strNum2   := cdsTmpDoc.fieldbyname('GER_ORDIMP').AsString;
  strDocOri2:= cdsTmpDoc.fieldbyname('GER_DOCORI').AsString;
  strEspDoc2:= cdsTmpDoc.fieldbyname('GER_ESPDOC').AsString;
  strCodEmp2:= cdsTmpDoc.fieldbyname('GER_CODEMP').AsString;

  cdsTmpDoc.DisableControls;
  pAlteraOrdImp(strDocOri1, strEspDoc1, strCodEmp1, strNum2);
  pAlteraOrdImp(strDocOri2, strEspDoc2, strCodEmp2, strNum1);
  cdsTmpDoc.EnableControls;

  cdsTmpDoc.RecNo := intPosicao; 
End;

procedure TfrmFatRomRoteiro.pPlanejarRotaMaplink;
var
  strMsgRetorno: String;
  intRecNoPrioridade: Integer;
begin
  strMsgRetorno := EmptyStr;
  intRecNoPrioridade := cdsTmpDoc.RecNo;

  pDefineInicioPartida;
  pDefineFinalRota;
  pDefineOpcaoDePlanejamento;

  if TGeocodeRomaneio.fProcessaGeocodeDosEnderecos(cdsTmpDoc, strMsgRetorno) then
  begin
    if fApiMaplink = MaplinkPlanning then
    begin
      pLimpaRota(rdbDefinido.Checked);

      if TControllerMaplinkPlanning.fPlanejarRota(cdsTmpDoc,
                                                  cdsRomRet,
                                                  IIF(rdgCaminho.ItemIndex = 0, THE_FASTEST, THE_SHORTEST),
                                                  fRetEvitarMaplink,
                                                  (rdbDefinido.Checked),
                                                  strMsgRetorno) then
        pCalcTmpDis
      else
        fMensagem('', strMsgRetorno,['&OK']);
    end
    else
    begin
      pLimpaRota(True);
      pDefinePrioridade(intRecNoPrioridade);

      pConsultaMatrizDeDistancia;
    end;
  end
  else
  begin
    if Length(strMsgRetorno) > 100 then
      TfrmMensagemExplicativa.pMensagem(strMsgRetorno)
    else
      fMensagem('', strMsgRetorno,['&OK']);
  end;
end;

function TfrmFatRomRoteiro.fApiMaplink: TApiMaplink;
begin
  Result := IIF(rdbMelhorRota.Checked, MaplinkPlanning, MaplinkDistanceMatrix);
end;

procedure TfrmFatRomRoteiro.pPlanejarRotaCitel;
var
  strMsgRetorno: String;
  intRecNoPrioridade: Integer;
begin
  strMsgRetorno := EmptyStr;
  intRecNoPrioridade := cdsTmpDoc.RecNo;

  pDefineInicioPartida;
  pDefineFinalRota;

  if TGeocodeRomaneio.fProcessaGeocodeDosEnderecos(cdsTmpDoc, strMsgRetorno) then
  begin
    if fApiCitel = CitelTrip then
    begin
      pLimpaRota(rdbDefinido.Checked);

      if TCitelOsrmTripApi.fPlanejarRota(cdsTmpDoc,
                                         cdsRomRet,
                                         strMsgRetorno) then
        pCalcTmpDis
      else
        fMensagem('', strMsgRetorno,['&OK']);
    end
    else
    begin
      pLimpaRota(True);
      pDefinePrioridade(intRecNoPrioridade);

      pConsultaMatrizDeDistancia;
    end;
  end
  else
  begin
    if Length(strMsgRetorno) > 100 then
      TfrmMensagemExplicativa.pMensagem(strMsgRetorno)
    else
      fMensagem('', strMsgRetorno,['&OK']);
  end;

  SetForegroundWindow(Self.Handle);
end;

function TfrmFatRomRoteiro.fApiCitel: TApiCitel;
begin
  Result := IIF(((rdbMelhorRota.Checked) and (not fTemFilialNaRota)), CitelTrip, CitelTable);
end;

function TfrmFatRomRoteiro.fTemFilialNaRota: Boolean;
var
  strFilter: String;
  blnFiltered: Boolean;
begin
  strFilter := cdsCadEmp.Filter;
  blnFiltered := cdsCadEmp.Filtered;

  cdsCadEmp.DisableControls;
  try
    cdsCadEmp.Filtered := False;
    cdsCadEmp.Filter := 'MARDES = '+QuotedStr('M');
    cdsCadEmp.Filtered := True;

    Result := (not cdsCadEmp.IsEmpty);
  finally
    cdsCadEmp.Filtered := False;
    cdsCadEmp.Filter := strFilter;
    cdsCadEmp.Filtered := blnFiltered;
    cdsCadEmp.EnableControls;
  end;
end;

function TfrmFatRomRoteiro.fCarregaInfoRotasCitel(
  pgbProgresso: TcxProgressBar): Boolean;
Var
  strEndereco,
  strCoordenada,
  jsonFile,
  strURL        : String;
  lstEndEntrega : TStringlist;
  index         : Integer;
  recTotalRotas : TTotalizaRotas;
  GeradorJSON   : TGeradorJSONRotas;
begin
  pgbProgresso.Properties.Max := cdsTmpDoc.RecordCount + 4;
  pStepStatusGravacao(pgbProgresso, 'Aguarde... Atualizando informações das rotas');

  recTotalRotas.fltDistanciaPlanejada := 0;
  recTotalRotas.intTempoPlanejado     := 0;
  recTotalRotas.fltDistanciaEfetuada  := 0;
  recTotalRotas.intTempoEfetuada      := 0;

  lstEndEntrega := TStringList.Create;
  lstEndEntrega.Add(cdsTmpDoc.FieldByName('GER_INIPAR').AsString + '|' +
                    'Ponto de Partida' + '|' +
                    'Partida' + '|' +
                    '0' + '|' +
                    '' + '|' +
                    '' + '|' +
                    '0');

  cdsTmpDoc.DisableControls;
  cdsTmpDoc.First;

  While (Not cdsTmpDoc.Eof) Do
  Begin
    recTotalRotas.fltDistanciaPlanejada := recTotalRotas.fltDistanciaPlanejada + cdsTmpDoc.FieldByName('GER_DISTAN').AsFloat;
    recTotalRotas.intTempoPlanejado     := recTotalRotas.intTempoPlanejado + cdsTmpDoc.FieldByName('GER_TMPENT').AsInteger;

    strEndereco := cdsTmpDoc.FieldByName('GER_ENDCON').AsString + ' - ' +
                   cdsTmpDoc.FieldByName('GER_BAIRRO').AsString + ', ' +
                   cdsTmpDoc.FieldByName('GER_NOMCID').AsString + ' - ' +
                   cdsTmpDoc.FieldByName('GER_ESTADO').AsString + ', ' +
                   cdsTmpDoc.FieldByName('GER_CEPCON').AsString;

    pStepStatusGravacao(pgbProgresso, 'Aguarde... Carregando dados da entrega');

    strCoordenada := cdsTmpDoc.FieldByName('GER_LATLON').AsString;

    index := lstEndEntrega.IndexOf(strEndereco);

    If (index = -1) Then
    Begin
      lstEndEntrega.Add(strCoordenada + '|' +
                        strEndereco + '|' +
                        'NaoIniciada' + '|' +
                        FormatFloat('00', cdsTmpDoc.FieldByName('GER_ORDIMP').AsInteger) + '|' +
                        cdsTmpDoc.FieldByName('GER_CEPCON').AsString + '|' +
                        cdsTmpDoc.FieldByName('GER_NOMCLI').AsString + '|' +
                        '0');
    End;

    cdsTmpDoc.Next;
  end;

  cdsTmpDoc.EnableControls;

  if not fEmptyStr(cdsTmpDoc.FieldByName('GER_FINROT').AsString) then
    lstEndEntrega.Add(cdsTmpDoc.FieldByName('GER_FINROT').AsString + '|' +
                      'Ponto de Chegada' + '|' +
                      'Chegada' + '|' +
                      '0' + '|' +
                      '' + '|' +
                      '' + '|' +
                      '0');

  pStepStatusGravacao(pgbProgresso, 'Aguarde... Calculando rotas');

  recTotalRotas.fltDistanciaPlanejada := recTotalRotas.fltDistanciaPlanejada + cdsRomRet.FieldByName('RET_DISTAN').AsFloat;
  recTotalRotas.intTempoPlanejado     := recTotalRotas.intTempoPlanejado + cdsRomRet.FieldByName('RET_TMPRET').AsInteger;

  recTotalRotas.fltDistanciaEfetuada  := 0;
  recTotalRotas.intTempoEfetuada      := 0;

  pStepStatusGravacao(pgbProgresso, 'Aguarde... Abrindo visualização das rotas');

  GeradorJSON := TGeradorJSONRotas.Create;
  try
    jsonFile := GeradorJSON.GerarArquivoJSON(lstEndEntrega, recTotalRotas, VS_strCodEmp);
    strURL   := GetURLRotas(jsonFile);
    BrowserNavigateOnAutcom(strURL);
  finally
    FreeAndNil(GeradorJSON);
  end;

  Result := True;
end;

function TfrmFatRomRoteiro.fCarregaInfoRotasGoogle(
  pgbProgresso: TcxProgressBar): Boolean;
Var
  KeyGoogleMaps,
  strEndereco,
  strCoordenada,
  strNumRom    : String;
  lstEndEntrega: TStringlist;
  fltTotalDistancia : Double;
  index,
  intTotalTempo     : Integer;
  MapsCoordinate : TTMSFNCMapsCoordinateRec;
begin
  pgbProgresso.Properties.Max := cdsTmpDoc.RecordCount + 3;
  pStepStatusGravacao(pgbProgresso, 'Aguarde... Atualizando informações das rotas');

  fltTotalDistancia := 0;
  intTotalTempo     := 0;

  KeyGoogleMaps := fCfgSis('KEYMDP', varString);
  strNumRom := '';

  If (cdsTmpDoc.FindField('GER_NUMROM') <> Nil) Then
    strNumRom := cdsTmpDoc.FieldByName('GER_NUMDOC').AsString;

  geolocalizacao.APIKey := KeyGoogleMaps;
  lstEndEntrega := TStringList.Create;
  lstEndEntrega.Add(cdsTmpDoc.FieldByName('GER_INIPAR').AsString + '|' +
                    'Ponto de Partida' + '|' +
                    'NaoIniciada' + '|' +
                    '0' + '|' +
                    '' + '|' +
                    '' + '|' +
                    '0');

  cdsTmpDoc.DisableControls;
  cdsTmpDoc.First;

  While (Not cdsTmpDoc.Eof) Do
  Begin
    fltTotalDistancia := fltTotalDistancia + cdsTmpDoc.FieldByName('GER_DISTAN').AsFloat;
    intTotalTempo     := intTotalTempo + cdsTmpDoc.FieldByName('GER_TMPENT').AsInteger;

    strEndereco := cdsTmpDoc.FieldByName('GER_ENDCON').AsString + ' - ' +
                   cdsTmpDoc.FieldByName('GER_BAIRRO').AsString + ', ' +
                   cdsTmpDoc.FieldByName('GER_NOMCID').AsString + ' - ' +
                   cdsTmpDoc.FieldByName('GER_ESTADO').AsString + ', ' +
                   cdsTmpDoc.FieldByName('GER_CEPCON').AsString;

    pStepStatusGravacao(pgbProgresso, 'Aguarde... Carregando dados da entrega');

    If (cdsTmpDoc.FindField('GER_LATLON') <> Nil) Then
    Begin
      If (cdsTmpDoc.FieldByName('GER_LATLON').AsString.IsEmpty) or (cdsTmpDoc.FieldByName('GER_ALTEND').AsString = 'S') Then
      Begin
        MapsCoordinate := geolocalizacao.GetGeocodingSync(strEndereco);

        TaEntregue.pGravaLogUsoGoogleMaps(strNumRom, 'Consulta Api Geocoding [Roteiro de Entregas]');

        strCoordenada  := MapsCoordinate.Latitude.ToString().Replace(',','.') + ',' +
                          MapsCoordinate.Longitude.ToString().Replace(',','.');

        pDefineCoordenada(strCoordenada);

        If (Not fEmptyStr(strNumRom)) And
           (cdsTmpDoc.FieldByName('GER_ALTEND').AsString = 'N') Then
          pAtualizaEntCli(strCoordenada);
      End
      Else
        strCoordenada  := cdsTmpDoc.FieldByName('GER_LATLON').AsString;
    End;

    index := lstEndEntrega.IndexOf(strEndereco);
    If (index = -1) Then
    Begin
      lstEndEntrega.Add(strCoordenada + '|' +
                        strEndereco + '|' +
                        'NaoIniciada' + '|' +
                        FormatFloat('00', cdsTmpDoc.FieldByName('GER_ORDIMP').AsInteger) + '|' +
                        cdsTmpDoc.FieldByName('GER_CEPCON').AsString + '|' +
                        cdsTmpDoc.FieldByName('GER_NOMCLI').AsString + '|' +
                        '0');
    End;

    cdsTmpDoc.Next;
  end;

  cdsTmpDoc.EnableControls;

  fltTotalDistancia := fltTotalDistancia + cdsRomRet.FieldByName('RET_DISTAN').AsFloat;
  intTotalTempo     := intTotalTempo + cdsRomRet.FieldByName('RET_TMPRET').AsInteger;

  if not fEmptyStr(cdsTmpDoc.FieldByName('GER_FINROT').AsString) then
    lstEndEntrega.Add(cdsTmpDoc.FieldByName('GER_FINROT').AsString + '|' +
                      'Ponto de Chegada' + '|' +
                      'NaoIniciada' + '|' +
                      '0' + '|' +
                      '' + '|' +
                      '' + '|' +
                      '0');

  pStepStatusGravacao(pgbProgresso, 'Aguarde... Abrindo visualização das rotas');
  TaEntregue.pGravaLogUsoGoogleMaps(strNumRom, 'Abertura do Google Maps [Roteiro de Entregas]');

  fmxVisualizarMapaGoogle := TfmxVisualizarMapaGoogle.Create(Self);

  Try
    fmxVisualizarMapaGoogle.objFuncoes                     := TFuncoes.Create;
    fmxVisualizarMapaGoogle.googleMaps.APIKey              := KeyGoogleMaps;
    fmxVisualizarMapaGoogle.routeCalculator.APIKey         := KeyGoogleMaps;
    fmxVisualizarMapaGoogle.filtrarRotas.APIKey            := KeyGoogleMaps;
    fmxVisualizarMapaGoogle.geolocalizacao.APIKey          := KeyGoogleMaps;
    fmxVisualizarMapaGoogle.lstEndEntregas                 := lstEndEntrega;
    fmxVisualizarMapaGoogle.Left                           := 0;
    fmxVisualizarMapaGoogle.Top                            := 0;
    fmxVisualizarMapaGoogle.Height                         := Screen.WorkAreaHeight;
    fmxVisualizarMapaGoogle.Width                          := Screen.WorkAreaWidth;
    fmxVisualizarMapaGoogle.Romaneio                       := Nil;
    fmxVisualizarMapaGoogle.TaEntregue                     := TaEntregue;
    fmxVisualizarMapaGoogle.strNumRomLog                   := strNumRom;
    fmxVisualizarMapaGoogle.lblTempoRotaPlanejada.Text     := fRetTempo(intTotalTempo);
    fmxVisualizarMapaGoogle.lblDistanciaRotaPlanejada.Text := FormatFloat('#,##0.00', fltTotalDistancia) + ' km';
    fmxVisualizarMapaGoogle.ShowModal;
  Finally
    pStepStatusGravacao(pgbProgresso, 'Aguarde...');
    FreeAndNil(fmxVisualizarMapaGoogle);
    TaEntregue.pGravaLogUsoGoogleMaps(strNumRom, 'Fechamento do Google Maps [Roteiro de Entregas]');
  End;

  Result := True;
end;

function TfrmFatRomRoteiro.fCarregaInfoRotasMaplink(
  pgbProgresso: TcxProgressBar): Boolean;
Var
  KeyGoogleMaps,
  strEndereco,
  strCoordenada,
  strNumRom         : String;
  lstEndEntrega     : TStringlist;
  fltTotalDistancia : Double;
  index,
  intTotalTempo     : Integer;
  arrWayPoints      : TArray<String>;
  mapLinkCoord      : TRetornoMaplinkTrip;
begin
  pgbProgresso.Properties.Max := cdsTmpDoc.RecordCount + 4;
  pStepStatusGravacao(pgbProgresso, 'Aguarde... Atualizando informações das rotas');

  fltTotalDistancia := 0;
  intTotalTempo     := 0;

  KeyGoogleMaps := fCfgSis('KEYMDP', varString);
  strNumRom := '';

  If (cdsTmpDoc.FindField('GER_NUMROM') <> Nil) Then
    strNumRom := cdsTmpDoc.FieldByName('GER_NUMDOC').AsString;

  SetLength(arrWayPoints, 0);

  lstEndEntrega := TStringList.Create;
  lstEndEntrega.Add(cdsTmpDoc.FieldByName('GER_INIPAR').AsString + '|' +
                    'Ponto de Partida' + '|' +
                    'NaoIniciada' + '|' +
                    '0' + '|' +
                    '' + '|' +
                    '' + '|' +
                    '0');

  SetLength(arrWayPoints, Length(arrWayPoints)+1);
  arrWayPoints[Length(arrWayPoints)- 1] := cdsTmpDoc.FieldByName('GER_INIPAR').AsString;

  cdsTmpDoc.DisableControls;
  cdsTmpDoc.First;

  While (Not cdsTmpDoc.Eof) Do
  Begin
    fltTotalDistancia := fltTotalDistancia + cdsTmpDoc.FieldByName('GER_DISTAN').AsFloat;
    intTotalTempo     := intTotalTempo + cdsTmpDoc.FieldByName('GER_TMPENT').AsInteger;

    strEndereco := cdsTmpDoc.FieldByName('GER_ENDCON').AsString + ' - ' +
                   cdsTmpDoc.FieldByName('GER_BAIRRO').AsString + ', ' +
                   cdsTmpDoc.FieldByName('GER_NOMCID').AsString + ' - ' +
                   cdsTmpDoc.FieldByName('GER_ESTADO').AsString + ', ' +
                   cdsTmpDoc.FieldByName('GER_CEPCON').AsString;

    pStepStatusGravacao(pgbProgresso, 'Aguarde... Carregando dados da entrega');

    strCoordenada := cdsTmpDoc.FieldByName('GER_LATLON').AsString;

    SetLength(arrWayPoints, Length(arrWayPoints)+1);
    arrWayPoints[Length(arrWayPoints)- 1] := strCoordenada;

    index := lstEndEntrega.IndexOf(strEndereco);

    If (index = -1) Then
    Begin
      lstEndEntrega.Add(strCoordenada + '|' +
                        strEndereco + '|' +
                        'NaoIniciada' + '|' +
                        FormatFloat('00', cdsTmpDoc.FieldByName('GER_ORDIMP').AsInteger) + '|' +
                        cdsTmpDoc.FieldByName('GER_CEPCON').AsString + '|' +
                        cdsTmpDoc.FieldByName('GER_NOMCLI').AsString + '|' +
                        '0');
    End;

    cdsTmpDoc.Next;
  end;

  cdsTmpDoc.EnableControls;

  if not fEmptyStr(cdsTmpDoc.FieldByName('GER_FINROT').AsString) then
    lstEndEntrega.Add(cdsTmpDoc.FieldByName('GER_FINROT').AsString + '|' +
                      'Ponto de Chegada' + '|' +
                      'NaoIniciada' + '|' +
                      '0' + '|' +
                      '' + '|' +
                      '' + '|' +
                      '0');

  pStepStatusGravacao(pgbProgresso, 'Aguarde... Calculando rotas');

  fltTotalDistancia := fltTotalDistancia + cdsRomRet.FieldByName('RET_DISTAN').AsFloat;
  intTotalTempo     := intTotalTempo + cdsRomRet.FieldByName('RET_TMPRET').AsInteger;

  SetLength(arrWayPoints, Length(arrWayPoints)+1);
  arrWayPoints[Length(arrWayPoints)- 1] := cdsTmpDoc.FieldByName('GER_FINROT').AsString;

  mapLinkCoord := TControllerMaplinkTrip.fRetPoints(arrWayPoints,
                                                    fRetEvitarMaplink,
                                                    cdsTmpDoc.FieldByName('GER_FSTSHT').AsString);

  TaEntregue.pGravaLogUsoGoogleMaps(strNumRom, 'Abertura do Google Maps [Roteiro de Entregas]');

  pStepStatusGravacao(pgbProgresso, 'Aguarde... Abrindo visualização das rotas');

  fmxVisualizarMapaMaplink := TfmxVisualizarMapaMaplink.Create(Self);

  Try
    fmxVisualizarMapaMaplink.objFuncoes                     := TFuncoes.Create;
    fmxVisualizarMapaMaplink.googleMaps.APIKey              := KeyGoogleMaps;
    fmxVisualizarMapaMaplink.routeCalculator.APIKey         := KeyGoogleMaps;
    fmxVisualizarMapaMaplink.filtrarRotas.APIKey            := KeyGoogleMaps;
    fmxVisualizarMapaMaplink.geolocalizacao.APIKey          := KeyGoogleMaps;
    fmxVisualizarMapaMaplink.lstEndEntregas                 := lstEndEntrega;
    fmxVisualizarMapaMaplink.lstDivergencias                := TStringList.Create;
    fmxVisualizarMapaMaplink.Left                           := 0;
    fmxVisualizarMapaMaplink.Top                            := 0;
    fmxVisualizarMapaMaplink.Height                         := Screen.WorkAreaHeight;
    fmxVisualizarMapaMaplink.Width                          := Screen.WorkAreaWidth;
    fmxVisualizarMapaMaplink.Romaneio                       := Nil;
    fmxVisualizarMapaMaplink.TaEntregue                     := TaEntregue;
    fmxVisualizarMapaMaplink.strNumRomLog                   := strNumRom;
    fmxVisualizarMapaMaplink.lblTempoRotaPlanejada.Text     := fRetTempo(intTotalTempo);
    fmxVisualizarMapaMaplink.lblDistanciaRotaPlanejada.Text := FormatFloat('#,##0.00', fltTotalDistancia) + ' km';
    fmxVisualizarMapaMaplink.mapLinkRomRoteiro              := mapLinkCoord;
    fmxVisualizarMapaMaplink.ShowModal;
  Finally
    pStepStatusGravacao(pgbProgresso, 'Aguarde...');
    FreeAndNil(fmxVisualizarMapaMaplink);
    TaEntregue.pGravaLogUsoGoogleMaps(strNumRom, 'Fechamento do Google Maps [Roteiro de Entregas]');
  End;

  Result := True;
end;

procedure TfrmFatRomRoteiro.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(dtsCadEmp) then
    FreeAndnil(dtsCadEmp);

  if Assigned(cdsCadEmp) then
    FreeAndNil(cdsCadEmp);
end;

procedure TfrmFatRomRoteiro.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_ESCAPE) Then
    Close;

  If (Key = VK_F5) Then
    btnMoveCima.Click;

  If (Key = VK_F6) Then
    btnMoveBaixo.Click;

  If (Key = VK_F9) Then
    btnRotaAPI.Click;

  If (Key = VK_F11) And (splDefRota.Opened) Then
    btnCalcularRota.Click;

  If (Key = VK_F12) And (btnVisualizarMapa.Visible) Then
    btnVisualizarMapa.Click;
end;

function TfrmFatRomRoteiro.fRetEmpresas: String;
begin
  Result := '';

  cdsTmpDoc.DisableControls;

  cdsTmpDoc.First;
  while not cdsTmpDoc.Eof do
  begin
    if Pos(cdsTmpDoc.FieldByName('GER_CODEMP').AsString, Result) = 0 then
      Result := Result + cdsTmpDoc.FieldByName('GER_CODEMP').AsString+'_';

    cdsTmpDoc.Next;
  end;

  cdsTmpDoc.EnableControls;
end;

function TfrmFatRomRoteiro.fRetEvitarMaplink: TArray<String>;
var
  intCount: Integer;
  strEvitar: String;
begin
  Result := nil;

  if chkTunnels.Checked then
    pAddEvitarMaplink(Result, AVOID_TUNNELS);

  if chkBridges.Checked then
    pAddEvitarMaplink(Result, AVOID_BRIDGES);

  if chkFerries.Checked then
    pAddEvitarMaplink(Result, AVOID_FERRIES);

  if chkTollGates.Checked then
    pAddEvitarMaplink(Result, AVOID_TOLL_GATES);

  if chkTollRoads.Checked then
    pAddEvitarMaplink(Result, AVOID_TOLL_ROADS);

  for intCount:=0 to Length(Result)-1 do
    strEvitar := IIF(fEmptyStr(strEvitar), '', strEvitar+',') + Result[intCount];

  cdsTmpDoc.First;
  while not cdsTmpDoc.Eof do
  begin
    cdsTmpDoc.Edit;
    cdsTmpDoc.FieldByName('GER_EVITAR').AsString := strEvitar;
    cdsTmpDoc.Post;

    cdsTmpDoc.Next;
  end;
end;

procedure TfrmFatRomRoteiro.pCarregaEmpresas;
var
  qryCadEmp: TUniQuery;
begin
  qryCadEmp := fCriaQuery(Self);
  try
    qryCadEmp.Close;
    qryCadEmp.SQL.Text :=
    ' SELECT '+
    '   "D" AS MARDES, '+
    '   EMP_CODEMP, '+
    '   EMP_NOMEMP, '+
    '   EMP_C_G_C_, '+
    '   EMP_ENDERE, '+
    '   EMP_BAIRRO, '+
    '   EMP_C_E_P_, '+
    '   EMP_CODCID, '+
    '   EMP_LATLON, '+
    '   CID_NOMCID, '+
    '   CID_ESTADO '+
    ' FROM '+
    '   CADEMP '+
    ' INNER JOIN CADCID ON '+
    '   EMP_CODCID = CID_CODCID '+
    ' WHERE '+
    '   LOCATE(EMP_CODEMP, '+QuotedStr(fRetEmpresas)+')';

    qryCadEmp.Open;

    cdsCadEmp := fCriaClientDatset(qryCadEmp);
    dtsCadEmp := fCriaDataSource(cdsCadEmp);
    cxgCargaDBTableViewCitel.DataController.DataSource := dtsCadEmp;

  finally
    FreeAndNil(qryCadEmp);
  end;

end;

procedure TfrmFatRomRoteiro.pCarregaOpcoesDoCalculoDeRota;
begin
  if fCfgSis('APIROT') = 'GOOGLE' then
  begin
    gpbTrajetoMaplink.Visible := False;
    rdgCaminho.Visible := False;
    GER_PRIORI.Visible := False;
    rdbMelhorRota.Visible := False;
  end
  else if fCfgSis('APIROT') = 'MAPLINK' then
    rdgTrajetoGoogle.Visible  := False
  else if fCfgSis('APIROT') = 'CITEL' then
  begin
    gpbTrajetoMaplink.Visible := False;
    rdgCaminho.Visible := False;
    rdgTrajetoGoogle.Visible  := False;
    GER_PRIORI.Visible := False;
  end;
end;

procedure TfrmFatRomRoteiro.FormShow(Sender: TObject);
begin
  inherited;
  dtsTmpDoc.DataSet := cdsTmpDoc;

  if fCfgSis('MATDIS', varBoolean) then
  begin
    gpbFiliais.Visible := True;
    pCarregaEmpresas;
    pMarcaEmpresas;

    pnlLegenda.Visible        := True;
    btnRotaAPI.Visible        := True;
    btnInfo.Visible           := True;
    pMostrarBotaoVisualizarMapa;

    DISTAENTREGA.Visible := True;
    TEMPOENTREGA.Visible := True;
    DISTACUMULADA.Visible := True;
    TEMPOACUMULADO.Visible := True;
    GER_LOCALI.Visible := True;
    GER_PRIORI.Visible := True;

    edtLibApp.Text := fCfgSis('LIBAPP', varString);

    pCarregaOpcoesDoCalculoDeRota;
    pAjustaOpcoesDePlanejamento;
  end;

  cxgItensDBTableViewCitel.ApplyBestFit();

  pCalcTmpDis;

  pSetFocus(cxgItens);

  GER_SEQUEN.Visible := fCfgSis('ROTREG', varBoolean);
  If fCfgSis('ROTREG', varBoolean) Then
    TNumericField(cdsTmpDoc.FieldByName('GER_SEQUEN')).DisplayFormat := '000';
end;

end.

