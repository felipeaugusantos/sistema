unit untWS_SkyHub;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, IdURI, Vcl.StdCtrls, Vcl.ExtCtrls, Rest.JSON, Uni, UniClientDataSet,
  Data.DB, System.StrUtils,
  HTTPSend, blcksock, synautil, ssl_openssl;

type
  TRetAutoIncrem = function(strNomeTabela, strCodEmp: String; intIntervalo: Integer = -1; blnForcaValidaExistencia: Boolean = True): String;

  TDocumento = record
    strNumDoc,
    strEspDoc,
    strCodEmp : String;
  End;

  ICommunicate = interface
  ['{24E31E0D-0657-4DFF-8BF9-757D99885F7D}']
    function URL         (const AValue : String) : ICommunicate;
    function GetPost     (const AValue : String) : ICommunicate;
    function JSON        (const AValue : String) : ICommunicate;
    function XMLFile     (const AValue : String) : ICommunicate;
    function XMLName     (const AValue : String) : ICommunicate;
    function RetornoHTTP (const AValue : String) : ICommunicate;
    function fCommunicate() : String;
  end;

  TCommunicate = class(TInterfacedObject, ICommunicate)
  private
    FURL         : String;
    FGetPost     : String;
    FJSON        : String;
    FXMLFile     : String;
    FXMLName     : String;
    FRetornoHTTP : String;
  protected
    constructor Create();
  public

    function URL        (const AValue : String) : ICommunicate;
    function GetPost    (const AValue : String) : ICommunicate;
    function JSON       (const AValue : String) : ICommunicate;
    function XMLFile    (const AValue : String) : ICommunicate;
    function XMLName    (const AValue : String) : ICommunicate;
    function RetornoHTTP(const AValue : String) : ICommunicate;

    class function New : ICommunicate;
    function fCommunicate() : String;

  end;

  {*** Objeto criado para gerar PLP de apenas 1 pedido ***}
  TWS_SkyHub = Class(TObject)
  private
    FNumDoc : String;
    FEspDoc : String;
    FEmpDoc : String;
  protected
    procedure GravarTabelaPLPB2W(ACodigoPLP : String);
    function ExistePLP : Boolean;
    function ChaveDoDocumentoEstaOK : Boolean;
  public

    constructor Create(ANumDoc, AEspDoc, AEmpDoc : String); reintroduce;
    class function PedidoJahFaturado(ANumDoc, AEspDoc, AEmpDoc : String) : Boolean;
    function GerarPLP(out AErro : String) : Boolean;

  end;

  procedure pCriarQueryGeralSingleton;

  function fRetHoraServidor: TTime;
  function fRetDataServidor: TDate;
  function fUtilizaRotinaDeImpressaoDeEtiquetaDeDespachoB2WEntrega : Boolean;
  function fTransportadoraRealizaColetaB2WEntrega(strCodTra : String) : Boolean;
  function fRetornaLayoutEtiquetaDespachoB2W(const strNumDoc, strEspDoc, strCodEmp : String) : String;
  function fUtilizarLayoutPadraoDeEtiquetaPorEmpresa: Boolean;
  function fGetCodigoDaTransportadora(strNumDoc, strEspDoc, strEmpDoc, strTabela : String) : String;

  function RetornaPedidoDocumentoVenda(ANumDoc, AEspDoc, AEmpDoc : String) : TDocumento;
  function RetornarNumPokPedido(ANumDoc, AEspDoc, AEmpDoc : String) : String;

{*** Essas variáveis globais devem ser atribuidas pelo projeto que irá utilizar essa unidade ***}
var
  VS_strCodEmp          : String;
  strLoginUsuarioLogado : String;
  Database              : TUniConnection;
  fRetAutoIncrem        : TRetAutoIncrem;

  qryGeral : TUniQuery;

const
  URL_AGRUPAR_PEDIDOS_PLP    = 'https://api.skyhub.com.br/shipments/b2w';              //POST   {"order_remote_codes":["265358194401","265358194401","265358194401"]}
  URL_CONSULTA_ID_PLP_PEDIDO = 'https://api.skyhub.com.br/shipments/b2w?delivery_id='; //GET
  URL_DESAGRUPAR_PLPS        = 'https://api.skyhub.com.br/shipments/b2w';              //DELETE {"plp_id": "14"}
  URL_RECUPERAR_PLP          = 'https://api.skyhub.com.br/shipments/b2w/view?plp_id='; //GET

implementation

uses
  untPLP_Consulta_Direct, untPLP_EtiquetaFrete_Direct;

constructor TCommunicate.Create;
begin
  FURL         := '';
  FGetPost     := '';
  FJSON        := '';
  FXMLFile     := '';
  FXMLName     := '';
  FRetornoHTTP := '';
end;

function TCommunicate.fCommunicate: String;
  var
    str_xUserEmail         : String;
    str_xApiKey            : String;
    str_xAccountManagerKey : String;

    FHTTPSend  : THTTPSend;
    LFDataResp : TMemoryStream;
    LFDataReq  : TMemoryStream;

begin

  {Informações de acesso ao web service}
  pCriarQueryGeralSingleton;

  Try

    qryGeral.Close;
    qryGeral.SQL.Clear;
    qryGeral.SQL.Add('SELECT                     ');
    qryGeral.SQL.Add('  *                        ');
    qryGeral.SQL.Add('FROM                       ');
    qryGeral.SQL.Add('  HUB_CFGSIS               ');
    qryGeral.SQL.Add('WHERE                      ');
    qryGeral.SQL.Add('  SIS_CODEMP = :CODEMP AND ');
    qryGeral.SQL.Add('  SIS_CODCFG IN ("CFG_UEMAIL", "CFG_APIKEY", "CFG_ACCKEY")');

    qryGeral.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryGeral.Open;

    If qryGeral.Locate('SIS_CODCFG', 'CFG_UEMAIL', []) Then
      str_xUserEmail := qryGeral.FieldByName('SIS_VALCFG').AsString;

    If qryGeral.Locate('SIS_CODCFG', 'CFG_APIKEY', []) Then
      str_xApiKey := qryGeral.FieldByName('SIS_VALCFG').AsString;

    If qryGeral.Locate('SIS_CODCFG', 'CFG_ACCKEY', []) Then
      str_xAccountManagerKey := qryGeral.FieldByName('SIS_VALCFG').AsString;

  Finally
    qryGeral.Close;
  End;

  FHTTPSend := THTTPSend.Create;

  Try

    FHTTPSend.MimeType  := 'application/json; charset=utf-8';
    FHTTPSend.UserAgent := 'Mozilla/4.0';
    FHTTPSend.Protocol  := '1.1';
    FHTTPSend.KeepAlive := True;

    FHTTPSend.Sock.SSL.SSLType := LT_TLSv1_2;

    FHTTPSend.Sock.SetTimeout(90000);
    FHTTPSend.Sock.ConnectionTimeout   := 90000;
    FHTTPSend.Sock.InterPacketTimeout  := False;
    FHTTPSend.Sock.NonblockSendTimeout := 90000;
    FHTTPSend.Sock.SocksTimeout        := 90000;
    FHTTPSend.Sock.HTTPTunnelTimeout   := 90000;
    FHTTPSend.Sock.SocksType := TSocksType.ST_Socks4;

    If FRetornoHTTP = 'JSON' Then
    Begin
      FHTTPSend.Headers.Add('Accept: application/json');
      FHTTPSend.Headers.Add('Content-Type: application/json');
    End
    Else
    Begin
      FHTTPSend.Headers.Add('Accept: application/json');
      FHTTPSend.Headers.Add('Content-Type: application/pdf');
    End;

    FHTTPSend.Headers.Add('X-User-Email:'+str_xUserEmail);
    FHTTPSend.Headers.Add('x-Api-Key:'+str_xApiKey);
    FHTTPSend.Headers.Add('x-accountmanager-key:'+str_xAccountManagerKey);

    If Not FJSON.IsEmpty Then
    Begin

      LFDataReq := TMemoryStream.Create;

      Try
        WriteStrToStream(LFDataReq, AnsiString(UTF8Encode(FJSON)));
        FHTTPSend.Document.LoadFromStream(LFDataReq);
      Finally
        FreeAndNil(LFDataReq);
      End;

    End;

    if FGetPost.Equals('GET') then
      FHTTPSend.HTTPMethod('GET', TIdURI.URLEncode(FURL));

    if FGetPost.Equals('POST') then
      FHTTPSend.HTTPMethod('POST', TIdURI.URLEncode(FURL));

    if FGetPost.Equals('PUT') then
      FHTTPSend.HTTPMethod('PUT', TIdURI.URLEncode(FURL));

    if FGetPost.Equals('DELETE') then
      FHTTPSend.HTTPMethod('DELETE', TIdURI.URLEncode(FURL));

    LFDataResp := TMemoryStream.Create;

    Try

      LFDataResp.LoadFromStream(FHTTPSend.Document);

      LFDataResp.Position := 0;
      Result := UTF8ToString(ReadStrFromStream(LFDataResp, LFDataResp.Size));

    Finally
      FreeAndNil(LFDataResp);
    End;

  Finally
    If Assigned(FHTTPSend) Then
      FreeAndNil(FHTTPSend);
  End;

end;

function TCommunicate.GetPost(const AValue: String): ICommunicate;
begin
  FGetPost := AValue;
  Result := Self;
end;

function TCommunicate.JSON(const AValue: String): ICommunicate;
begin
  FJSON := AValue;
  Result := Self;
end;

class function TCommunicate.New: ICommunicate;
begin
  Result := TCommunicate.Create();
end;

function TCommunicate.RetornoHTTP(const AValue: String): ICommunicate;
begin
  FRetornoHTTP := AValue;
  Result := Self;
end;

function TCommunicate.URL(const AValue: String): ICommunicate;
begin
  FURL := AValue;
  Result := Self;
end;

function TCommunicate.XMLFile(const AValue: String): ICommunicate;
begin
  FXMLFile := AValue;
  Result := Self;
end;

function TCommunicate.XMLName(const AValue: String): ICommunicate;
begin
  FXMLName := AValue;
  Result := Self;
end;

{ TWS_SkyHub }

constructor TWS_SkyHub.Create(ANumDoc, AEspDoc, AEmpDoc: String);
begin
  inherited Create;
  FNumDoc := ANumDoc;
  FEspDoc := AEspDoc;
  FEmpDoc := AEmpDoc;
end;

function TWS_SkyHub.ChaveDoDocumentoEstaOK: Boolean;
begin

  Result := True;

  If (FNumdoc.IsEmpty) Then
    Exit(False);

  If (FEspDoc.IsEmpty) Then
    Exit(False);

  If (FEmpDoc.IsEmpty) Then
    Exit(False);

end;

function TWS_SkyHub.ExistePLP: Boolean;
const
  SQL_PLPB2W = 'SELECT   ' +
               '  *      ' +
               'FROM     ' +
               '  PLPB2W ' +
               'WHERE    ' +
               '  PLP_NUMDOC = :NUMDOC AND ' +
               '  PLP_ESPDOC = :ESPDOC AND ' +
               '  PLP_EMPDOC = :EMPDOC';
begin

  Result := False;

  If Not ChaveDoDocumentoEstaOK Then
    Exit;

  pCriarQueryGeralSingleton;

  Try

    qryGeral.Close;
    qryGeral.SQL.Clear;
    qryGeral.SQL.Add(SQL_PLPB2W);
    qryGeral.ParamByName('NUMDOC').AsString := FNumDoc;
    qryGeral.ParamByName('ESPDOC').AsString := FEspDoc;
    qryGeral.ParamByName('EMPDOC').AsString := FEmpDoc;
    qryGeral.Open;

    Result := Not qryGeral.IsEmpty;

  Finally
    qryGeral.Close;
  End;

end;

function TWS_SkyHub.GerarPLP(out AErro : String) : Boolean;
var
  strRetorno : String;
  strEnvio   : String;
  strNumPok  : String;

  TPLP         : untPLP_Consulta_Direct.TRootClass;
  strCodigoPLP : String;
  intPosicao   : Integer;
begin

  Result := False;

  If Not ChaveDoDocumentoEstaOK Then
    Exit;

  {Se existe retorna TRUE}
  If ExistePLP Then
    Exit(True);

  strNumPok := RetornarNumPokPedido(FNumDoc, FEspDoc, FEmpDoc);

  If Not VS_strCodEmp.Equals(FEmpDoc) Then
    VS_strCodEmp := FEmpDoc;

  intPosicao := Pos('-', strNumPok);
  If (intPosicao > 0) Then
    strNumPok := Copy(strNumPok, intPosicao+1, Length(strNumPok));

  If (strNumPok.IsEmpty) Then
    Exit;

  strEnvio  := '{"order_remote_codes":["' + strNumPok + '"]}';

  strRetorno := TCommunicate.New().URL(URL_AGRUPAR_PEDIDOS_PLP)
                                  .GetPost('POST')
                                  .JSON(strEnvio)
                                  .RetornoHTTP('JSON')
                                  .fCommunicate;

  AErro := '';

  If (Pos('sucesso', strRetorno) >= 1) then
  Begin

    strRetorno := TCommunicate.New().URL(URL_CONSULTA_ID_PLP_PEDIDO + strNumPok)
                                    .GetPost('GET')
                                    .RetornoHTTP('JSON')
                                    .fCommunicate;

    TPLP := untPLP_Consulta_Direct.TRootClass.FromJsonString(strRetorno);

    Try

      strCodigoPLP := TPLP.plp[0].id.ToString();
      GravarTabelaPLPB2W(strCodigoPLP);

      Result := True;

    Finally
      FreeAndNil(TPLP);
    End;

  End Else
    AErro := strRetorno;

end;

procedure pCriarQueryGeralSingleton;
Begin

  If Not Assigned(qryGeral) Then
  Begin
    qryGeral := TUniQuery.Create(Nil);
    qryGeral.Connection := Database;
    qryGeral.Options.RequiredFields := False;
  End;

End;

function fRetHoraServidor: TTime;
begin

  Result := 0;
  pCriarQueryGeralSingleton;

  Try

    qryGeral.Close;
    qryGeral.SQL.Clear;
    qryGeral.SQL.Add('SELECT CURRENT_TIME');
    qryGeral.Open;

    Result := qryGeral.FieldByName('CURRENT_TIME').AsDateTime;

  Finally

    If Result = 0 Then
      Result := Time;

    qryGeral.Close;

  End;

end;

function fRetDataServidor: TDate;
begin

  pCriarQueryGeralSingleton;

  Try

    qryGeral.Close;
    qryGeral.SQL.Clear;
    qryGeral.SQL.Add('SELECT CURRENT_DATE');
    qryGeral.Open;

    Result := qryGeral.FieldByName('CURRENT_DATE').AsDateTime;

  Finally
    qryGeral.Close;
  End;

end;

function fUtilizaRotinaDeImpressaoDeEtiquetaDeDespachoB2WEntrega : Boolean;
const
  SQL_CFGSIS = 'SELECT * FROM CFGSIS WHERE SIS_CODCFG = :CODCFG AND SIS_CODEMP = :CODEMP';
begin

  Result := False;

  pCriarQueryGeralSingleton;

  Try

    qryGeral.Close;
    qryGeral.SQL.Clear;
    qryGeral.SQL.Add(SQL_CFGSIS);
    qryGeral.ParamByName('CODCFG').AsString := 'CFG_B2WIMP';
    qryGeral.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryGeral.Open;

    If (Not qryGeral.IsEmpty) Then
      Result := (qryGeral.FieldByName('SIS_VALCFG').AsString = 'S');

  Finally
    qryGeral.Close;
  End;

end;

function fTransportadoraRealizaColetaB2WEntrega(strCodTra : String) : Boolean;
const
  SQL_CADTRA = 'SELECT TRA_B2WENT FROM CADTRA WHERE TRA_CODTRA = :CODTRA';
begin

  Result := False;

  If (strCodTra.IsEmpty) Then
    Exit;

  pCriarQueryGeralSingleton;

  Try

    qryGeral.Close;
    qryGeral.SQL.Clear;
    qryGeral.SQL.Add(SQL_CADTRA);
    qryGeral.ParamByName('CODTRA').AsString := strCodTra;
    qryGeral.Open;

    If (Not qryGeral.IsEmpty) Then
      Result := (qryGeral.FieldByName('TRA_B2WENT').AsString = 'S');

  Finally
    qryGeral.Close;
  End;

end;

function fRetornaLayoutEtiquetaDespachoB2W(const strNumDoc, strEspDoc, strCodEmp : String) : String;
var
  strMarket : String;
  blnUtilizarLayoutsPorEmpresa : Boolean;
const
  SQL_MKPPED = 'SELECT       ' +
               '  MKP_MARKET ' +
               'FROM         ' +
               '  MKPPED     ' +
               'WHERE        ' +
               '  MKP_NUMPED = :NUMPED AND ' +
               '  MKP_ESPPED = :ESPPED AND ' +
               '  MKP_EMPPED = :EMPPED ';

  SQL_HUB_CADMKP_POR_EMPRESA = 'SELECT * FROM HUB_CADMKP WHERE MKP_CODMKP = :CODMKP AND MKP_CODEMP = :CODEMP';
  SQL_HUB_CADMKP_GERAL       = 'SELECT * FROM HUB_CADMKP WHERE MKP_CODMKP = :CODMKP';

begin

  Result := '';

  If (strNumDoc.IsEmpty) Then
    Exit;

  If (strEspDoc.IsEmpty) Then
    Exit;

  If (strCodEmp.IsEmpty) Then
    Exit;

  pCriarQueryGeralSingleton;
  blnUtilizarLayoutsPorEmpresa := fUtilizarLayoutPadraoDeEtiquetaPorEmpresa;

  Try

    qryGeral.Close;
    qryGeral.SQL.Clear;
    qryGeral.SQL.Add(SQL_MKPPED);
    qryGeral.ParamByName('NUMPED').AsString := strNumDoc;
    qryGeral.ParamByName('ESPPED').AsString := strEspDoc;
    qryGeral.ParamByName('EMPPED').AsString := strCodEmp;
    qryGeral.Open;

    If Not qryGeral.IsEmpty Then
    Begin

      strMarket := qryGeral.FieldByName('MKP_MARKET').AsString;

      If (strMarket = 'Americanas Empresas') Then
        strMarket := 'Lojas Americanas';

      qryGeral.Close;
      qryGeral.SQL.Clear;

      qryGeral.SQL.Add(IfThen(blnUtilizarLayoutsPorEmpresa, SQL_HUB_CADMKP_POR_EMPRESA, SQL_HUB_CADMKP_GERAL));

      qryGeral.ParamByName('CODMKP').AsString := strMarket;

      If (blnUtilizarLayoutsPorEmpresa) Then
        qryGeral.ParamByName('CODEMP').AsString := VS_strCodEmp;

      qryGeral.Open;

      Result := IfThen(Not qryGeral.IsEmpty, qryGeral.FieldByName('MKP_CODLAY').AsString, '');

    End;

  Finally
    qryGeral.Close;
  End;

end;

function fUtilizarLayoutPadraoDeEtiquetaPorEmpresa: Boolean;
const
  SQL_CFGSIS = 'SELECT * FROM CFGSIS WHERE SIS_CODCFG = :CODCFG AND SIS_CODEMP = :CODEMP';
begin

  Result := False;

  pCriarQueryGeralSingleton;

  Try

    qryGeral.Close;
    qryGeral.SQL.Clear;
    qryGeral.SQL.Add(SQL_CFGSIS);
    qryGeral.ParamByName('CODCFG').AsString := 'CFG_ETIEMP';
    qryGeral.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryGeral.Open;

    If (Not qryGeral.IsEmpty) Then
      Result := (qryGeral.FieldByName('SIS_VALCFG').AsString = 'S');

  Finally
    qryGeral.Close;
  End;

end;

function fGetCodigoDaTransportadora(strNumDoc, strEspDoc, strEmpDoc, strTabela : String) : String;
const
  SQL_PD = 'SELECT FGO_CODTRA FROM FATGOR WHERE FGO_NUMDOC = :NUMDOC AND FGO_ESPDOC = :ESPDOC AND FGO_CODEMP = :CODEMP';
  SQL_VN = 'SELECT GER_CODTRA FROM TABELA WHERE GER_NUMDOC = :NUMDOC AND GER_ESPDOC = :ESPDOC AND GER_CODEMP = :CODEMP AND GER_ORIDOC = "V"';
begin

  Result := '';

  If (strNumDoc.IsEmpty) Then
    Exit;

  If (strEspDoc.IsEmpty) Then
    Exit;

  If (strEmpDoc.IsEmpty) then
    Exit;

  pCriarQueryGeralSingleton;

  If strTabela = 'FATGOR' Then
  Begin

    Try

      qryGeral.Close;
      qryGeral.SQL.Clear;
      qryGeral.SQL.Add(SQL_PD);
      qryGeral.ParamByName('NUMDOC').AsString := strNumDoc;
      qryGeral.ParamByName('ESPDOC').AsString := strEspDoc;
      qryGeral.ParamByName('CODEMP').AsString := strEmpDoc;
      qryGeral.Open;

      If (Not qryGeral.IsEmpty) Then
        Result := qryGeral.FieldByName('FGO_CODTRA').AsString;

    Finally
      qryGeral.Close;
    End;

  End
  Else
  Begin

    Try

      qryGeral.Close;
      qryGeral.SQL.Clear;
      qryGeral.SQL.Add(StringReplace(SQL_VN, 'TABELA', strTabela, [rfReplaceAll]));
      qryGeral.ParamByName('NUMDOC').AsString := strNumDoc;
      qryGeral.ParamByName('ESPDOC').AsString := strEspDoc;
      qryGeral.ParamByName('CODEMP').AsString := strEmpDoc;
      qryGeral.Open;

      If (Not qryGeral.IsEmpty) Then
        Result := qryGeral.FieldByName('GER_CODTRA').AsString;

    Finally
      qryGeral.Close;
    End;

  End;

end;

procedure TWS_SkyHub.GravarTabelaPLPB2W(ACodigoPLP: String);
var
  TPLP       : untPLP_EtiquetaFrete_Direct.TRootClass;
  strRetorno : String;
  strDtaPro  : String;
  strCodAWB  : String;
  strBasRot  : String;
  strMegRot  : String;

  dtaData,
  dtaHora : TDateTime;

const
  SQL_PLPB2W = 'SELECT   ' +
               '  *      ' +
               'FROM     ' +
               '  PLPB2W ' +
               'WHERE    ' +
               '  FALSE  ';
begin

  strRetorno := TCommunicate.New().URL(URL_RECUPERAR_PLP + ACodigoPLP)
                                  .GetPost('GET')
                                  .RetornoHTTP('JSON')
                                  .fCommunicate;

  TPLP := untPLP_EtiquetaFrete_Direct.TRootClass.FromJsonString(strRetorno);

  Try
    strDtaPro  := TPLP.docsExternos[0].dtPrometida;
    strCodAWB  := TPLP.docsExternos[0].awbs[0].codigoAwb;
    strBasRot  := TPLP.docsExternos[0].rota;
    strMegRot  := TPLP.docsExternos[0].megaRota;
  Finally
    FreeAndNil(TPLP);
  End;

  pCriarQueryGeralSingleton;

  Try

    dtaData := fRetDataServidor;
    dtaHora := fRetHoraServidor;

    qryGeral.Close;
    qryGeral.SQL.Clear;
    qryGeral.SQL.Add(SQL_PLPB2W);
    qryGeral.Open;

    qryGeral.Append;
    qryGeral.FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('PLPB2W', VS_strCodEmp);
    qryGeral.FieldByName('PLP_NUMDOC').AsString   := FNumDoc;
    qryGeral.FieldByName('PLP_ESPDOC').AsString   := FEspDoc;
    qryGeral.FieldByName('PLP_EMPDOC').AsString   := FEmpDoc;
    qryGeral.FieldByName('PLP_CODIGO').AsString   := ACodigoPLP;
    qryGeral.FieldByName('PLP_DTAGER').AsDateTime := dtaData;
    qryGeral.FieldByName('PLP_HRAGER').AsDateTime := dtaHora;
    qryGeral.FieldByName('PLP_OPEGER').AsString   := strLoginUsuarioLogado;
    qryGeral.FieldByName('PLP_DTAPRO').AsString   := strDtaPro;
    qryGeral.FieldByName('PLP_CODAWB').AsString   := strCodAWB;
    qryGeral.FieldByName('PLP_BASROT').AsString   := strBasRot;
    qryGeral.FieldByName('PLP_MEGROT').AsString   := strMegRot;
    qryGeral.Post;

  Finally
    qryGeral.Close;
  End;

end;

class function TWS_SkyHub.PedidoJahFaturado(ANumDoc, AEspDoc, AEmpDoc: String) : Boolean;
const
  SQL_FATGOR = 'SELECT       ' +
               '  FGO_JAFATU ' +
               'FROM         ' +
               '  FATGOR     ' +
               'WHERE        ' +
               '  FGO_NUMDOC = :NUMDOC AND ' +
               '  FGO_ESPDOC = :ESPDOC AND ' +
               '  FGO_CODEMP = :EMPDOC';
begin

  Result := False;

  If (ANumDoc.IsEmpty) Then
    Exit;

  If (AEspDoc.IsEmpty) Then
    Exit;

  If (AEmpDoc.IsEmpty) Then
    Exit;

  pCriarQueryGeralSingleton;

  Try

    qryGeral.Close;
    qryGeral.SQL.Clear;
    qryGeral.SQL.Add(SQL_FATGOR);
    qryGeral.ParamByName('NUMDOC').AsString := ANumDoc;
    qryGeral.ParamByName('ESPDOC').AsString := AEspDoc;
    qryGeral.ParamByName('EMPDOC').AsString := AEmpDoc;
    qryGeral.Open;

    If (Not qryGeral.IsEmpty) Then
      Result := (qryGeral.FieldByName('FGO_JAFATU').AsString = '1');

  Finally
    qryGeral.Close;
  End;

end;

function RetornaPedidoDocumentoVenda(ANumDoc, AEspDoc, AEmpDoc: String): TDocumento;
const
  SQL_FATGOR = 'SELECT       ' +
               '  *          ' +
               'FROM         ' +
               '  FATGOR     ' +
               'WHERE        ' +
               '  FGO_NUMFAT = :NUMDOC AND ' +
               '  FGO_TIPFAT = :ESPDOC AND ' +
               '  FGO_EMPFAT = :EMPDOC';
begin

  Result.strNumDoc := '';
  Result.strEspDoc := '';
  Result.strCodEmp := '';

  If (ANumDoc.IsEmpty) Then
    Exit;

  If (AEspDoc.IsEmpty) Then
    Exit;

  If (AEmpDoc.IsEmpty) Then
    Exit;

  pCriarQueryGeralSingleton;

  Try

    qryGeral.Close;
    qryGeral.SQL.Clear;
    qryGeral.SQL.Add(SQL_FATGOR);
    qryGeral.ParamByName('NUMDOC').AsString := ANumDoc;
    qryGeral.ParamByName('ESPDOC').AsString := AEspDoc;
    qryGeral.ParamByName('EMPDOC').AsString := AEmpDoc;
    qryGeral.Open;

    If (Not qryGeral.IsEmpty) Then
    Begin
      Result.strNumDoc := qryGeral.FieldByName('FGO_NUMDOC').AsString;
      Result.strEspDoc := qryGeral.FieldByName('FGO_ESPDOC').AsString;
      Result.strCodEmp := qryGeral.FieldByName('FGO_CODEMP').AsString;
    End;

  Finally
    qryGeral.Close;
  End;

end;

function RetornarNumPokPedido(ANumDoc, AEspDoc, AEmpDoc: String): String;
const
  SQL_FATGOR = 'SELECT       ' +
               '  FGO_NUMPOK ' +
               'FROM         ' +
               '  FATGOR     ' +
               'WHERE        ' +
               '  FGO_NUMDOC = :NUMDOC AND ' +
               '  FGO_ESPDOC = :ESPDOC AND ' +
               '  FGO_CODEMP = :EMPDOC';
begin

  Result := '';

  If (ANumDoc.IsEmpty) Then
    Exit;

  If (AEspDoc.IsEmpty) Then
    Exit;

  If (AEmpDoc.IsEmpty) Then
    Exit;

  pCriarQueryGeralSingleton;

  Try

    qryGeral.Close;
    qryGeral.SQL.Clear;
    qryGeral.SQL.Add(SQL_FATGOR);
    qryGeral.ParamByName('NUMDOC').AsString := ANumDoc;
    qryGeral.ParamByName('ESPDOC').AsString := AEspDoc;
    qryGeral.ParamByName('EMPDOC').AsString := AEmpDoc;
    qryGeral.Open;

    If Not qryGeral.IsEmpty Then
      Result := qryGeral.FieldByName('FGO_NUMPOK').AsString;

  Finally
    qryGeral.Close;
  End;

end;

end.

