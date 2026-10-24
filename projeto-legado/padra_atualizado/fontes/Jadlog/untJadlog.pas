unit untJadlog;

interface

uses Generics.Collections, Rest.Json, REST.Client, REST.Types, SysUtils,
     IdHTTP, IdURI, Classes, System.NetEncoding, IdAuthentication, System.json,
     Uni, Types, Data.DB, strUtils, UniClientDataSet, System.DateUtils, IdSSLOpenSSL,
     System.RegularExpressions;

type
  TTipJadlog = (TpJadIncluirPedido, TpJadCancelarPedido);
  TTipArray = (TpArrPedido, TpArrDfe, TpArrVolume);
  TArrPedido = array of string;

type

  TRecPedido = record
    FVlrCon: Double;
    FCodCli: string;
    FNomVen: string;
    FCodTra: string;
    FNomCom: string;
    FEndCom: string;
    FNumCom: string;
    FComple: string;
    FBaiCon: string;
    FCepCom: string;
    FCidCom: string;
    FEstCom: string;
    FTelCom: string;
    FCgcCom: string;
    FIesCom: string;
    FEmlCom: string;
    FMen001: string;
    FClaFis: string;
    FSerie_: string;
    FAcesso: string;
    FPesBru: Double;
    FVolume: Integer;
    FConteudo: String;
  end;

  TVolumeJadlog = class
    private
      FAltura: integer;
      FComprimento: integer;
      FIdentificador: string;
      FLargura: integer;
      FPeso: Double;
    public
      property Altura: integer read FAltura write FAltura;
      property Comprimento: integer read FComprimento write FComprimento;
      property Identificador: string read FIdentificador write FIdentificador;
      property Largura: integer read FLargura write FLargura;
      property Peso: Double read FPeso write FPeso;
  end;

  TDfeJadlog = class
    private
      FCfop: string;
      FDanfeCte: string;
      FNrDoc: string;
      FSerie: string;
      FTpDocumento: integer;
      FValor: Double;
    public
      property Cfop: string read FCfop write FCfop;
      property DanfeCte: string read FDanfeCte write FDanfeCte;
      property NrDoc: string read FNrDoc write FNrDoc;
      property Serie: string read FSerie write FSerie;
      property TpDocumento: integer read FTpDocumento write FTpDocumento;
      property Valor: Double read FValor write FValor;
  end;

  TArrVolumeJadlog = array of TVolumeJadlog;
  TArrDfeJadlog = array of TDfeJadlog;

  TDestinatarioJadlog = class
    private
      FNome: string;
      FCnpjCpf: string;
      FIe: string;
      FEndereco: string;
      FNumero: string;
      FCompl: string;
      FBairro: string;
      FCidade: string;
      FUf: string;
      FCep: string;
      FFone: String;
      FCel: string;
      FEmail: string;
      FContato: string;
    public
      property Nome: string read FNome write FNome;
      property CnpjCpf: string read FCnpjCpf write FCnpjCpf;
      property Ie: string read FIe write FIe;
      property Endereco: string read FEndereco write FEndereco;
      property Numero: string read FNumero write FNumero;
      property Compl: string read FCompl write FCompl;
      property Bairro: string read FBairro write FBairro;
      property Cidade: string read FCidade write FCidade;
      property Uf: string read FUf write FUf;
      property Cep: string read FCep write FCep;
      property Fone: string read FFone write FFone;
      property Cel: string read FCel write FCel;
      property Email: string read FEmail write FEmail;
      property Contato: string read FContato write FContato;
  end;


  TRemetenteJadlog = class
    private
      FNome: string;
      FCnpjCpf: string;
      FIe: string;
      FEndereco: string;
      FNumero: string;
      FCompl: string;
      FBairro: string;
      FCidade: string;
      FUf: string;
      FCep: string;
      FFone: string;
      FCel: string;
      FEmail: string;
      FContato: string;
    public
      property Nome: string read FNome write FNome;
      property CnpjCpf: string read FCnpjCpf write FCnpjCpf;
      property Ie: string read FIe write FIe;
      property Endereco: string read FEndereco write FEndereco;
      property Numero: string read FNumero write FNumero;
      property Compl: string read FCompl write FCompl;
      property Bairro: string read FBairro write FBairro;
      property Cidade: string read FCidade write FCidade;
      property Uf: string read FUf write FUf;
      property Cep: string read FCep write FCep;
      property Fone: string read FFone write FFone;
      property Cel: string read FCel write FCel;
      property Email: string read FEmail write FEmail;
      property Contato: string read FContato write FContato;
  end;

  TDadosEtiqueta = class
    private
      FCodBarra: string;
      FLastMile: string;
      FPosicao: string;
      FPrioridade: integer;
      FRota: string;
      FRua: string;
      FSeqVolume: integer;
      FUnidadeDestino: string;
    public
      property CodBarra: string read FCodBarra write FCodBarra;
      property LastMile: string read FLastMile write FLastMile;
      property Posicao: string read FPosicao write FPosicao;
      property Prioridade: integer read FPrioridade write FPrioridade;
      property Rota: string read FRota write FRota;
      property Rua: string read FRua write FRua;
      property SeqVolume: integer read FSeqVolume write FSeqVolume;
      property UnidadeDestino: string read FUnidadeDestino write FUnidadeDestino;
  end;

  TArrDadosEtiqueta = Array of TDadosEtiqueta;

  TEtiqueta = class
    private
      FVolume: TArrDadosEtiqueta;
    public
      property Volume: TArrDadosEtiqueta read FVolume write FVolume;
      constructor Create;
      destructor Destroy; override;
  end;

  TRetornoPedido = class
    private
      FCodigo: string;
      FShipmentId: string;
      FStatus: string;
      FEtiqueta: TEtiqueta;
    public
      property Codigo: string read FCodigo write FCodigo;
      property ShipmentId: string read FShipmentId write FShipmentId;
      property Status: string read FStatus write FStatus;
      property Etiqueta: TEtiqueta read FEtiqueta write FEtiqueta;
      Class function fFromJsonString(AJson: string; AAcao: TTipJadlog): TRetornoPedido;
      constructor Create;
      destructor Destroy; override;
  end;

  TIncluiPedidoJadlog = class
    private
      FConteudo: string;
      FPedido: TArrPedido;
      FTotPeso: Double;
      FTotValor: Double;
      FObs: string;
      FModalidade: integer;
      FContaCorrente: string;
      FTpColeta: string;
      FTipoFrete: integer;
      FCdUnidadeOri: string;
      FCdUnidadeDes: string;
      FCdPickupOri: string;
      FCdPickupDes: string;
      FNrContrato: integer;
      FServico: integer;
      FShipmentId: string;
      FVlColeta: Double;
      FRem: TRemetenteJadlog;
      FDes: TDestinatarioJadlog;
      FDfe: TArrDfeJadlog;
      FVolume: TArrVolumeJadlog;
    public
      property Conteudo: string read FConteudo write FConteudo;
      property Pedido: TArrPedido read FPedido write FPedido;
      property TotPeso: Double read FTotPeso write FTotPeso;
      property TotValor: Double read FTotValor write FTotValor;
      property Obs: string read FObs write FObs;
      property Modalidade: integer read FModalidade write FModalidade;
      property ContaCorrente: string read FContaCorrente write FContaCorrente;
      property TpColeta: string read FTpColeta write FTpColeta;
      property TipoFrete: integer read FTipoFrete write FTipoFrete;
      property CdUnidadeOri: string read FCdUnidadeOri write FCdUnidadeOri;
      property CdUnidadeDes: string read FCdUnidadeDes write FCdUnidadeDes;
      property CdPickupOri: string read FCdPickupOri write FCdPickupOri;
      property CdPickupDes: string read FCdPickupDes write FCdPickupDes;
      property NrContrato: integer read FNrContrato write FNrContrato;
      property Servico: integer read FServico write FServico;
      property ShipmentId: string read FShipmentId write FShipmentId;
      property VlColeta: Double read FVlColeta write FVlColeta;
      property Rem: TRemetenteJadlog read FRem write FRem;
      property Des: TDestinatarioJadlog read FDes write FDes;
      property Dfe: TArrDfeJadlog read FDfe write FDfe;
      property Volume: TArrVolumeJadlog read FVolume write FVolume;

      constructor Create;
      destructor Destroy; override;
      function ToJsonString: string;
      procedure pRedimencionaArray(ATamanho: integer; AArray: TTipArray);
      function fEnviarPedido(AJson: string): string;
      procedure pSalvaDadosJadlog(ARetorno: TRetornoPedido; ACodCli, ANumDoc, AEspDoc, ACodEmp: string;
        ADuplicidade: Boolean = False);
      function fRetDadosPedido(ANumDoc, AEspDoc, ACodEmp: string; intVolume: Integer): TRecPedido;
      procedure pSalvaEtiqueta(AEtiqueta: TArrDadosEtiqueta; AAutInc, ACodEmp: string);
      procedure pSalvaPedidoOriginal(ANumDoc, AEspDoc, ACodEmp, AAutInc: string);
  end;

  TCancelarPedidoJadLog = class
    private
      FShipmentId: string;
    public
      property ShipmentId: string read FShipmentId write FShipmentId;
      function ToJsonString: string;
      function fCancelaPedido(AJson: string): string;
      procedure pMarcaPedidoCancelado(strCodShi: string);
  end;

  TErro = class
    private
      FDescricao: string;
      FDetalhe: string;
      FId: integer;
    public
      property Descricao: string read FDescricao write FDescricao;
      property Detalhe: string read FDetalhe write FDetalhe;
      property Id: integer read FId write FId;
  end;

  TRespostaErro = class
    private
      FStatus: string;
      FErro: TErro;
    public
      property Status: string read FStatus write FStatus;
      property Erro: TErro read FErro write FErro;
      constructor Create;
      destructor Destroy; override;
      Class function fFromJsonString(AJson: string; AAcao: TTipJadlog): TRespostaErro;
  end;

function fEnviaPedidoJadlog(ANumDoc, AEspDoc, ACodEmp: string; intVolume: Integer): Boolean;
function fCancelarPedidoJadlog(AShipment: string): Boolean;
function fRetModalidadeJadlog(ACodTra: string): integer;
function fComunica(AAcao: TTipJadlog; AJason: string): string;
procedure pRetornaPedido(ANumDoc, AEspDoc, ACodEmp: string; var APedidos: TIncluiPedidoJadlog);
function fPedidoEviadoJadlog(ANumDoc, AEspDoc, ACodEmp: string): Boolean;
function fGerouEtiqueta(ANumDoc, AEspDoc, ACodEmp: string):Boolean;
procedure pGravaLogRequisicao(ARequest, AResponse: string; AIdHTTP1: TIdHttp);

function fUsaJadLog(strNumDoc, strEspDoc, strCodEmp: string): Boolean;
function fEhTransportadoraJadlog(strCodTra: string): Boolean;
function fEhErroDuplicidade(AMensagem: String):Boolean;
function fRetornaCodigoPedidoDuplicado(AMensagem: String): TRetornoPedido;

implementation

uses
  untFuncoesSimples, untFuncoesGenerica, Forms, System.IOUtils;

function fComunica(AAcao: TTipJadlog; AJason: string): string;
var
  LIdHTTP1: TIdHttp;
  LjsResponse: TStringStream;
  LPostData: TStringStream;
  LURL: string;
begin
  LIdHTTP1 := TIdHttp.Create(nil);
  try
    LIdHTTP1.ConnectTimeout := 10000;
    LIdHTTP1.Request.Clear;

    LIdHTTP1.Request.ContentType := 'application/json';
    LIdHTTP1.Request.Accept := 'application/json;charset=UTF-8';
    LIdHTTP1.Request.CustomHeaders.Add('Authorization:Bearer ' + fCfgSis('TOKJAD'));


    try
      LjsResponse := TStringStream.Create('', TEncoding.UTF8);

      case AAcao of
        TpJadIncluirPedido: LURL := fCfgSis('URLJAD');
        TpJadCancelarPedido: LURL := fCfgSis('UCAJAD');
      end;

      LURL := TIdURI.URLEncode(LURL);
      LPostData := TStringStream.Create(AJason, TEncoding.UTF8);
      LIdHTTP1.Post(LURL, LPostData, LjsResponse);
      Result := LjsResponse.DataString;
    except
      on E: EIdHTTPProtocolException do
      begin
        Result := '*' +IntToStr(LIdHTTP1.ResponseCode);
      end;
    end;

    pGravaLogRequisicao(AJason, Result, LIdHTTP1);
  finally
    FreeAndNil(LIdHTTP1);
  end;
end;

{ TIncluiPedido }

constructor TIncluiPedidoJadlog.Create;
begin
  Self.FRem := TRemetenteJadlog.Create;
  Self.FDes := TDestinatarioJadlog.Create;
  SetLength(FPedido, 0);
  SetLength(FDfe, 0);
  SetLength(FVolume, 0);
end;

destructor TIncluiPedidoJadlog.Destroy;
begin
  FreeAndNil(FRem);
  FreeAndNil(FDes);
  inherited;
end;

function TIncluiPedidoJadlog.fEnviarPedido(AJson: string): string;
begin
  Result := fComunica(TpJadIncluirPedido, AJson);
end;

function TIncluiPedidoJadlog.fRetDadosPedido(ANumDoc, AEspDoc, ACodEmp: string; intVolume: Integer): TRecPedido;
var
  qryPedido: TUniQuery;
  LEndereco: string;
  LSql: string;
begin
  FillChar(Result, SizeOf(Result), #0);
  qryPedido := fCriaQuery;

  try
    LSql := EmptyStr;
    LSql := LSql + 'SELECT MG.GER_VLRCON, MG.GER_CODVEN, MG.GER_CODTRA, MG.GER_NOMCON, MG.GER_ENDCON, MG.GER_BAICON, MG.GER_CEPCON, MG.GER_CODCLI, ';
    LSql := LSql + '       MG.GER_CIDCON, MG.GER_ESTCON, MG.GER_TELCON, MG.GER_CGCCON, MG.GER_IESCON, MG.GER_EMLCON, MG.GER_MEN001, MG.GER_PESBRU, MG.GER_VOLUME, ';
    LSql := LSql + '       MD.DET_CODITE, MD.DET_DESCRI, ';
    LSql := LSql + '       FI.FIS_CLFSC1, FI.FIS_SERIE_, FI.FIS_ACESSO ';
    LSql := LSql + 'FROM MOVGER MG ';
    LSql := LSql + 'INNER JOIN MOVDET MD ';
    LSql := LSql + 'ON(MG.AUTOINCREM = MD.DET_SEQGER) ';
    LSql := LSql + 'INNER JOIN CADFIS FI ';
    LSql := LSql + 'ON(MG.GER_NUMDOC = FI.FIS_NUMDOC ';
    LSql := LSql + 'AND MG.GER_ESPDOC = FI.FIS_ESPDOC ';
    LSql := LSql + 'AND MG.GER_CODEMP = FI.FIS_CODEMP) ';
    LSql := LSql + 'WHERE MG.GER_NUMDOC = :NUMDOC ';
    LSql := LSql + 'AND MG.GER_ESPDOC = :ESPDOC ';
    LSql := LSql + 'AND MG.GER_CODEMP = :CODEMP ';

    qryPedido.Close;
    qryPedido.SQL.Clear;
    qryPedido.SQL.Add(LSql);

    qryPedido.ParamByName('NUMDOC').AsString := ANumDoc;
    qryPedido.ParamByName('ESPDOC').AsString := AEspDoc;
    qryPedido.ParamByName('CODEMP').AsString := ACodEmp;

    qryPedido.Open;

    if qryPedido.IsEmpty then
      Exit;

    Result.FVlrCon := qryPedido.FieldByName('GER_VLRCON').AsFloat;
    Result.FCodCli := qryPedido.FieldByName('GER_CODCLI').AsString;
    Result.FNomVen := fRetNomVendRep(qryPedido.FieldByName('GER_CODVEN').AsString);
    Result.FCodTra := qryPedido.FieldByName('GER_CODTRA').AsString;
    Result.FNomCom := qryPedido.FieldByName('GER_NOMCON').AsString;

    LEndereco := qryPedido.FieldByName('GER_ENDCON').AsString;
    Result.FEndCom := Copy(LEndereco,1,Pos(',',LEndereco)-1);
    Delete(LEndereco, 1, Pos(',',LEndereco)+1);
    if not fEmptyStr(LEndereco) then
    begin
      Result.FNumCom := Copy(LEndereco, 1, Pos(' ',LEndereco)-1);
      Delete(LEndereco, 1, Pos(' ',LEndereco));
      LEndereco := fTiraEnter(LEndereco);
      if not fEmptyStr(LEndereco) then
      begin
        Result.FComple := LEndereco;
      end;
    end;

    if fEmptyStr(Result.FEndCom) then
    begin
      Result.FEndCom := fCampoTabela('CLI_ENDERE', 'CADCLI', ['CLI_CODCLI'], [qryPedido.FieldByName('GER_CODCLI').AsString], False);
      Result.FNumCom := fCampoTabela('CLI_ENDNUM', 'CADCLI', ['CLI_CODCLI'], [qryPedido.FieldByName('GER_CODCLI').AsString], False);
      Result.FComple := fCampoTabela('CLI_ENDCOM', 'CADCLI', ['CLI_CODCLI'], [qryPedido.FieldByName('GER_CODCLI').AsString], False);
    end;

    Result.FBaiCon := qryPedido.FieldByName('GER_BAICON').AsString;
    Result.FCepCom := qryPedido.FieldByName('GER_CEPCON').AsString;
    Result.FCidCom := fRetCidade(qryPedido.FieldByName('GER_CIDCON').AsString);
    Result.FEstCom := qryPedido.FieldByName('GER_ESTCON').AsString;
    Result.FTelCom := qryPedido.FieldByName('GER_TELCON').AsString;
    Result.FCgcCom := qryPedido.FieldByName('GER_CGCCON').AsString;
    Result.FIesCom := qryPedido.FieldByName('GER_IESCON').AsString;
    Result.FEmlCom := qryPedido.FieldByName('GER_EMLCON').AsString;
    Result.FMen001 := qryPedido.FieldByName('GER_MEN001').AsString;
    Result.FClaFis := qryPedido.FieldByName('FIS_CLFSC1').AsString;
    Result.FSerie_ := qryPedido.FieldByName('FIS_SERIE_').AsString;
    Result.FAcesso := qryPedido.FieldByName('FIS_ACESSO').AsString;
    Result.FPesBru := qryPedido.FieldByName('GER_PESBRU').AsFloat;

    If (intVolume = 0) Then
      Result.FVolume := qryPedido.FieldByName('GER_VOLUME').AsInteger
    Else
      Result.FVolume := intVolume;

    Result.FConteudo := '';
    while not qryPedido.Eof do
    begin
      Result.FConteudo := Result.FConteudo + ';' + qryPedido.FieldByName('DET_DESCRI').AsString;
      qryPedido.Next;
    end;

    if not fEmptyStr(Result.FConteudo) then
    begin
      Delete(Result.FConteudo,1,1);
      Result.FConteudo := Copy(Result.FConteudo, 1, 80);
    end;
  finally
    FreeAndNil(qryPedido);
  end;
end;

procedure pRetornaPedido(ANumDoc, AEspDoc, ACodEmp: string; var APedidos: TIncluiPedidoJadlog);
var
  LQryPedido: TUniQuery;
  LSql: string;
begin
  LQryPedido := fCriaQuery;

  try
    LSql := EmptyStr;
    LSql := LSql + 'SELECT DET_NUM_PD, DET_ESP_PD, DET_EMP_PD, COUNT(DET_NUM_PD) AS TOTAL ';
    LSql := LSql + 'FROM MOVDET ';
    LSql := LSql + 'WHERE DET_NUMDOC = :NUMDOC ';
    LSql := LSql + 'AND DET_ESPDOC = :ESPDOC ';
    LSql := LSql + 'AND DET_CODEMP = :CODEMP ';
    LSql := LSql + 'GROUP BY DET_NUM_PD, DET_ESP_PD, DET_EMP_PD ';

    LQryPedido.Close;
    LQryPedido.SQL.Clear;
    LQryPedido.SQL.Add(LSql);

    LQryPedido.ParamByName('NUMDOC').AsString := ANumDoc;
    LQryPedido.ParamByName('ESPDOC').AsString := AEspDoc;
    LQryPedido.ParamByName('CODEMP').AsString := ACodEmp;

    LQryPedido.Open;

    if LQryPedido.IsEmpty then
      Exit;

    if fEmptyStr(LQryPedido.FieldByName('DET_NUM_PD').AsString) then
    begin
      APedidos.pRedimencionaArray(Length(APedidos.Pedido) + 1, TpArrPedido);
      APedidos.Pedido[Length(APedidos.Pedido) - 1] := ANumDoc + '-' + AEspDoc + '-' + ACodEmp;
    end
    else
    begin
      while not LQryPedido.Eof do
      begin
        if fPedidoEviadoJadlog(LQryPedido.FieldByName('DET_NUM_PD').AsString,LQryPedido.FieldByName('DET_ESP_PD').AsString,LQryPedido.FieldByName('DET_EMP_PD').AsString) then
        begin
          APedidos.pRedimencionaArray(Length(APedidos.Pedido) + 1, TpArrPedido);
          APedidos.Pedido[Length(APedidos.Pedido) - 1] := LQryPedido.FieldByName('DET_NUM_PD').AsString + '-' + LQryPedido.FieldByName('DET_ESP_PD').AsString + '-' + LQryPedido.FieldByName('DET_EMP_PD').AsString + '-' + IntToStr(LQryPedido.FieldByName('DET_EMP_PD').AsInteger + 1);
        end
        else
        begin
          APedidos.pRedimencionaArray(Length(APedidos.Pedido) + 1, TpArrPedido);
          APedidos.Pedido[Length(APedidos.Pedido) - 1] := LQryPedido.FieldByName('DET_NUM_PD').AsString + '-' + LQryPedido.FieldByName('DET_ESP_PD').AsString + '-' + LQryPedido.FieldByName('DET_EMP_PD').AsString + '-' + '1';
        end;

        LQryPedido.Next;
      end;
    end;
  finally
    FreeAndNil(LQryPedido);
  end;
end;

procedure TIncluiPedidoJadlog.pRedimencionaArray(ATamanho: integer; AArray: TTipArray);
begin
  case AArray of
    TpArrPedido: SetLength(Self.FPedido, ATamanho);

    TpArrDfe:      begin
                     SetLength(Self.FDfe, ATamanho);
                     Self.FDfe[Length(Self.FDfe) - 1] := TDfeJadlog.Create;
                   end;

    TpArrVolume:   begin
                     SetLength(Self.FVolume, ATamanho);
                     Self.FVolume[Length(Self.FVolume) - 1] := TVolumeJadlog.Create;
                   end;
  end;

end;

procedure TIncluiPedidoJadlog.pSalvaDadosJadlog(ARetorno: TRetornoPedido; ACodCli,
  ANumDoc, AEspDoc, ACodEmp: string; ADuplicidade: Boolean = False);
var
  qryJadlog: TUniQuery;
  LAutinc: string;
begin
  qryJadlog := fCriaQuery;

  try
    LAutinc := fRetAutoIncrem('PEDJAD', ACodEmp);

    qryJadlog.Close;
    qryJadlog.SQL.Clear;
    qryJadlog.SQL.Add('INSERT INTO PEDJAD(AUTOINCREM,JAD_CODJAD,JAD_SHIPME,JAD_CODCLI,JAD_NUMDOC,JAD_ESPDOC,JAD_CODEMP,JAD_DTAEMI, JAD_PDFETI)');
    qryJadlog.SQL.Add('VALUES(:AUTINC,:CODJAD,:CODSHI,:CODCLI,:NUMDOC,:ESPDOC,:CODEMP,:DTAEMI,:PDFETI)');

    qryJadlog.ParamByName('AUTINC').AsString := LAutinc;
    qryJadlog.ParamByName('CODJAD').AsString := ARetorno.Codigo;
    qryJadlog.ParamByName('CODSHI').AsString := ARetorno.ShipmentId;
    qryJadlog.ParamByName('CODCLI').AsString := ACodCli;
    qryJadlog.ParamByName('NUMDOC').AsString := ANumDoc;
    qryJadlog.ParamByName('ESPDOC').AsString := AEspDoc;
    qryJadlog.ParamByName('CODEMP').AsString := ACodEmp;
    qryJadlog.ParamByName('DTAEMI').AsDate := VS_Date;

    qryJadlog.ExecSQL;

    if (Assigned(ARetorno.Etiqueta)) and (Assigned(ARetorno.Etiqueta.Volume)) then
      pSalvaEtiqueta(ARetorno.Etiqueta.Volume, LAutinc, ACodEmp)
    else if (Not ADuplicidade) then
      fMensagem('ATENÇÃO','Não foi possível imprimir a etiqueta da Jadlog por uma falha do retorno da API. Verifique se as configurações estão '+
                                'corretas e se sim, verifique com a Jadlog se está habilitado o retorno para Smartlabel.'+'',['&OK']);

    pSalvaPedidoOriginal(ANumDoc, AEspDoc, ACodEmp, LAutinc);
  finally
    FreeAndNil(qryJadlog);
  end;
end;

procedure TIncluiPedidoJadlog.pSalvaEtiqueta(AEtiqueta: TArrDadosEtiqueta;
  AAutInc, ACodEmp: string);
var
  LQryEtiqueta: TUniQuery;
  LIndice: integer;
begin
  LQryEtiqueta := fCriaQuery;

  try
    LQryEtiqueta.Close;
    LQryEtiqueta.SQL.Clear;
    LQryEtiqueta.SQL.Add('INSERT INTO ETIJAD(AUTOINCREM, JAD_SEQPED, JAD_CODBAR, JAD_LASTMI, JAD_POSICA, ');
    LQryEtiqueta.SQL.Add('JAD_PRIORI, JAD_ROTENT, JAD_R_U_A_, JAD_SEQVOL, JAD_UNIDES)');
    LQryEtiqueta.SQL.Add('VALUES(:AUTINC, :SEQPED, :CODBAR, :LASTMI, :POSICA, ');
    LQryEtiqueta.SQL.Add(':PRIORI, :ROTENT, :R_U_A_, :SEQVOL, :UNIDES)');

    for LIndice := 0 to Length(AEtiqueta) - 1 do
    Begin
      LQryEtiqueta.ParamByName('AUTINC').AsString := fRetAutoIncrem('ETIJAD', ACodEmp);
      LQryEtiqueta.ParamByName('SEQPED').AsString := AAutInc;
      LQryEtiqueta.ParamByName('CODBAR').AsString := AEtiqueta[LIndice].CodBarra;
      LQryEtiqueta.ParamByName('LASTMI').AsString := AEtiqueta[LIndice].LastMile;
      LQryEtiqueta.ParamByName('POSICA').AsString := AEtiqueta[LIndice].Posicao;
      LQryEtiqueta.ParamByName('PRIORI').AsInteger := AEtiqueta[LIndice].Prioridade;
      LQryEtiqueta.ParamByName('ROTENT').AsString := AEtiqueta[LIndice].Rota;
      LQryEtiqueta.ParamByName('R_U_A_').AsString := AEtiqueta[LIndice].Rua;
      LQryEtiqueta.ParamByName('SEQVOL').AsInteger := AEtiqueta[LIndice].SeqVolume;
      LQryEtiqueta.ParamByName('UNIDES').AsString := AEtiqueta[LIndice].UnidadeDestino;

      LQryEtiqueta.ExecSQL;
    End;
  finally
    FreeAndNil(LQryEtiqueta);
  end;
end;

procedure TIncluiPedidoJadlog.pSalvaPedidoOriginal(ANumDoc, AEspDoc, ACodEmp,
  AAutInc: string);
var
  LQryPedido: TUniQuery;
  LIndice: integer;
begin
  LQryPedido := fCriaQuery;

  try
    if Length(Self.Pedido) <= 0 then
      Exit;

    LQryPedido.Close;
    LQryPedido.SQL.Clear;
    LQryPedido.SQL.Add('INSERT INTO PDENJD(AUTOINCREM, NJD_SEQPED, NJD_NUMDOC, NJD_ESPDOC, ');
    LQryPedido.SQL.Add('NJD_CODEMP, NJD_DOC_PD, NJD_ESP_PD, NJD_EMP_PD)');
    LQryPedido.SQL.Add('VALUES(:AUTINC, :SEQPED, :NUMDOC, :ESPDOC, ');
    LQryPedido.SQL.Add(':CODEMP, :DOC_PD, :ESP_PD, :EMP_PD)');

    for LIndice := 0 to Length(Self.Pedido) - 1 do
    begin
      if Pos(Copy(Self.Pedido[LIndice],14,2),'PD_OR_') > 0 then
      begin
        LQryPedido.ParamByName('AUTINC').AsString := fRetAutoIncrem('PDENJD', ACodEmp);
        LQryPedido.ParamByName('SEQPED').AsString := AAutInc;
        LQryPedido.ParamByName('NUMDOC').AsString := ANumDoc;
        LQryPedido.ParamByName('ESPDOC').AsString := AEspDoc;
        LQryPedido.ParamByName('CODEMP').AsString := ACodEmp;
        LQryPedido.ParamByName('DOC_PD').AsString := Copy(Self.Pedido[LIndice], 1, 12);
        LQryPedido.ParamByName('ESP_PD').AsString := Copy(Self.Pedido[LIndice], 14, 2);
        LQryPedido.ParamByName('EMP_PD').AsString := Copy(Self.Pedido[LIndice], 17, 3);
        LQryPedido.ExecSQL;
      end;
    end;
  finally
    FreeAndNil(LQryPedido);
  end;
end;

function TIncluiPedidoJadlog.ToJsonString: string;
begin
  Result := TJson.ObjectToJsonString(self);
end;

{ TCancelarPedidoJadLog }

function TCancelarPedidoJadLog.fCancelaPedido(AJson: string): string;
begin
  Result := fComunica(TpJadCancelarPedido, AJson);
end;

procedure TCancelarPedidoJadLog.pMarcaPedidoCancelado(strCodShi: string);
var
  qryCancel: TUniQuery;
begin
  qryCancel := fCriaQuery;

  try
    qryCancel.Close;
    qryCancel.SQL.Clear;
    qryCancel.SQL.Add('UPDATE PEDJAD');
    qryCancel.SQL.Add('SET JAD_CANCEL = TRUE');
    qryCancel.SQL.Add('WHERE JAD_SHIPME = :CODSHI');
    qryCancel.ParamByName('CODSHI').AsString := strCodShi;
    qryCancel.ExecSQL;
  finally
    FreeAndNil(qryCancel);
  end;
end;

function TCancelarPedidoJadLog.ToJsonString: string;
begin
  Result := TJson.ObjectToJsonString(self);
end;

function fEnviaPedidoJadlog(ANumDoc, AEspDoc, ACodEmp: string; intVolume: Integer): Boolean;
var
  LPedido: TIncluiPedidoJadlog;
  LJson,
  LResposta: string;
  LIndice: integer;
  fltTotPes: Double;
  LInfEmpresa: TDadosEmpresa;
  LRetorno: TRetornoPedido;
  LRetErro: TRespostaErro;
  LRecPedido: TRecPedido;
begin
  LPedido := TIncluiPedidoJadlog.Create;
  FillChar(LRecPedido, SizeOf(LRecPedido), #0);
  LRecPedido := LPedido.fRetDadosPedido(ANumDoc, AEspDoc, ACodEmp, intVolume);

  try
    LRetorno := nil;
    LRetErro := nil;
    Result := False;

    if fEmptyStr(LRecPedido.FAcesso) then
    begin
      fMensagem('ERRO - JADLOG','A nota ainda não foi aprovada no painel, verifique',['&OK']);
      Result := False;
      Exit;
    end;

    fltTotPes := 0;
    for LIndice := 1 to LRecPedido.FVolume do
    begin
      LPedido.pRedimencionaArray(Length(LPedido.Volume) + 1, TpArrVolume);
      LPedido.Volume[Length(LPedido.Volume) - 1].Identificador := ANumDoc + '-' + AEspDoc + '-' + ACodEmp + '-VOL' + IntToStr(LIndice);
      LPedido.Volume[Length(LPedido.Volume) - 1].Peso := fFormataFloat(LRecPedido.FPesBru / LRecPedido.FVolume, 2);
      fltTotPes := fltTotPes + LPedido.Volume[Length(LPedido.Volume) - 1].Peso;
    end;

    If (Length(LPedido.Volume) = 0) Then
    begin
      fMensagem('ERRO - JADLOG', 'Não foi informado nenhum volume para esse documento!',['&OK']);
      Result := False;
      Exit;
    end;

    if LRecPedido.FPesBru > fltTotPes then
      LPedido.Volume[Length(LPedido.Volume) - 1].Peso := LPedido.Volume[Length(LPedido.Volume) - 1].Peso + (LRecPedido.FPesBru - fltTotPes)
    else if LRecPedido.FPesBru < fltTotPes then
      LPedido.Volume[Length(LPedido.Volume) - 1].Peso := LPedido.Volume[Length(LPedido.Volume) - 1].Peso - (fltTotPes - LRecPedido.FPesBru);

    LPedido.pRedimencionaArray(Length(LPedido.Dfe) + 1, TpArrDfe);
    LPedido.Dfe[Length(LPedido.Dfe) - 1].Cfop := LRecPedido.FClaFis;
    LPedido.Dfe[Length(LPedido.Dfe) - 1].DanfeCte := LRecPedido.FAcesso;
    LPedido.Dfe[Length(LPedido.Dfe) - 1].Serie := LRecPedido.FSerie_;
    LPedido.Dfe[Length(LPedido.Dfe) - 1].NrDoc := ANumDoc;
    LPedido.Dfe[Length(LPedido.Dfe) - 1].TpDocumento := 2;
    LPedido.Dfe[Length(LPedido.Dfe) - 1].Valor := LRecPedido.FVlrCon;

    LInfEmpresa := fRetDadosEmpresa;

    LPedido.Rem.Nome := LInfEmpresa.strNome;
    LPedido.Rem.CnpjCpf := LInfEmpresa.strCpfCnpj;
    LPedido.Rem.Endereco := LInfEmpresa.strEndereco;
    LPedido.Rem.Numero := LInfEmpresa.strNumero;
    LPedido.Rem.Compl := LInfEmpresa.strComplemento;
    LPedido.Rem.Bairro := LInfEmpresa.strBairro;
    LPedido.Rem.Cidade := LInfEmpresa.strCidade;
    LPedido.Rem.Uf := LRecPedido.FEstCom;
    LPedido.Rem.Cep := LInfEmpresa.strCep;
    LPedido.Rem.Fone := LInfEmpresa.strFone;
    LPedido.Rem.Cel := LInfEmpresa.strCelular;
    LPedido.Rem.Email := LInfEmpresa.strEmail;
    LPedido.Rem.Contato := LRecPedido.FNomVen;
    LPedido.Rem.Ie := LInfEmpresa.strIe;

    LPedido.Des.Nome := LRecPedido.FNomCom;
    LPedido.Des.CnpjCpf := LRecPedido.FCgcCom;
    LPedido.Des.Ie := LRecPedido.FIesCom;
    LPedido.Des.Endereco := LRecPedido.FEndCom;
    LPedido.Des.Numero := LRecPedido.FNumCom;
    LPedido.Des.Bairro := LRecPedido.FBaiCon;
    LPedido.Des.Compl := LRecPedido.FComple;
    LPedido.Des.Cidade := LRecPedido.FCidCom;
    LPedido.Des.Uf := LRecPedido.FEstCom;
    LPedido.Des.Cep := LRecPedido.FCepCom;
    LPedido.Des.Fone := LRecPedido.FTelCom;
    LPedido.Des.Email := LRecPedido.FEmlCom;
    LPedido.Des.Contato := LRecPedido.FNomCom;

    LPedido.Conteudo := LRecPedido.FConteudo;
    pRetornaPedido(ANumDoc, AEspDoc, ACodEmp, LPedido);
    LPedido.TotPeso := LRecPedido.FPesBru;
    LPedido.TotValor := LRecPedido.FVlrCon;
    LPedido.Obs := LRecPedido.FMen001;
    LPedido.Modalidade := fRetModalidadeJadlog(LRecPedido.FCodTra);
    LPedido.TpColeta := fCfgSis('SOLJAD');
    LPedido.TipoFrete := fCfgSis('FREJAD', varInteger);
    LPedido.CdUnidadeOri := fCfgSis('CUOJAD');
    LPedido.ContaCorrente := fCfgSis('CC_JAD');
    LPedido.Servico := 0;

    LJson := LPedido.ToJsonString;
    LResposta := LPedido.fEnviarPedido(LJson);

    if Pos('*', LResposta) > 0 then
    begin
      Delete(LResposta,1,1);
      fMensagem('ERRO - JADLOG','Ocorreu um erro de comunicação com a api da Jadlog: ' + LResposta,['&OK']);
      Result := False;
    end
    else if Pos('erro', LResposta) > 0 then
    Begin
      LRetErro := TRespostaErro.fFromJsonString(LResposta, TpJadIncluirPedido);

      if (fEhErroDuplicidade(LRetErro.Erro.Descricao)) then
      begin
        LRetorno := fRetornaCodigoPedidoDuplicado(LRetErro.Erro.Descricao);
        if LRetorno <> Nil then
        begin
          LPedido.pSalvaDadosJadlog(LRetorno, LRecPedido.FCodCli, ANumDoc, AEspDoc, ACodEmp, True);
          Result := True;
        end;
      end;

      if (Not Result) then
        fMensagem('ERRO - JADLOG',LRetErro.Erro.Descricao,['&OK']);
    End
    else
    begin
      LRetorno := TRetornoPedido.fFromJsonString(LResposta, TpJadIncluirPedido);
      if (LRetorno = Nil) then
      begin
        fMensagem('JADLOG', 'Retorno da JADLOG inválido!',['&OK']);
        Result := False;
      end
      else
      begin
        LPedido.pSalvaDadosJadlog(LRetorno, LRecPedido.FCodCli, ANumDoc, AEspDoc, ACodEmp);
        fMensagem('JADLOG',LRetorno.Status,['&OK']);
        Result := True;
      end;
    end;
  finally
    if Assigned(LRetorno) then
      FreeAndNil(LRetorno);

    if Assigned(LRetErro) then
      FreeAndNil(LRetErro);

    FreeAndNil(LPedido);
  end;
end;

function fCancelarPedidoJadlog(AShipment: string): Boolean;
var
  LCancelaPedido: TCancelarPedidoJadLog;
  LResposta,
  LJson: string;
  LRetErro: TRespostaErro;
  LRetorno: TRetornoPedido;
begin
  LCancelaPedido := TCancelarPedidoJadLog.Create;

  try
    LRetorno := nil;
    LRetErro := nil;

    LCancelaPedido.ShipmentId := AShipment;
    LJson := LCancelaPedido.ToJsonString;
    LResposta := LCancelaPedido.fCancelaPedido(LJson);

    if Pos('*', LResposta) > 0 then
    begin
      Delete(LResposta,1,1);
      fMensagem('ERRO - JADLOG','Ocorreu um erro de comunicação com a api da Jadlog: ' + LResposta,['&OK']);
      Result := False;
    end
    else if Pos('erro', LResposta) > 0 then
    Begin
      LRetErro := TRespostaErro.fFromJsonString(LResposta, TpJadCancelarPedido);
      fMensagem('ERRO - JADLOG',LRetErro.Erro.Detalhe,['&OK']);
      Result := False;
    End
    else
    begin
      LRetorno := TRetornoPedido.fFromJsonString(LResposta, TpJadCancelarPedido);
      LCancelaPedido.pMarcaPedidoCancelado(AShipment);

      if LRetorno <> Nil then
        fMensagem('JADLOG',LRetorno.Status,['&OK'])
      else
        fMensagem('JADLOG','Retorno da JADLOG inválido!',['&OK']);

      Result := True;
    end;
  finally
    if Assigned(LRetorno) then
      FreeAndNil(LRetorno);

    if Assigned(LRetErro) then
      FreeAndNil(LRetErro);

    FreeAndNil(LCancelaPedido);
  end;
end;

function fPedidoEviadoJadlog(ANumDoc, AEspDoc, ACodEmp: string): Boolean;
var
  LPedido: string;
begin
  LPedido := fCampoTabela('AUTOINCREM','PDENJD',['NJD_DOC_PD','NJD_ESP_PD','NJD_EMP_PD'],[ANumDoc, AEspDoc, ACodEmp]);
  Result := not fEmptyStr(LPedido);
end;

function fRetModalidadeJadlog(ACodTra: string): integer;
begin
  Result := fCampoTabela('TRA_MODJED','CADTRA',['TRA_CODTRA'],[ACodTra], False);
end;

function fGerouEtiqueta(ANumDoc, AEspDoc, ACodEmp: string):Boolean;
var
  LEtiqueta: string;
begin
  LEtiqueta := fCampoTabela('AUTOINCREM', 'PEDJAD', ['JAD_NUMDOC','JAD_ESPDOC','JAD_CODEMP'], [ANumDoc,AEspDoc,ACodEmp]);
  Result := not fEmptyStr(LEtiqueta);
end;

{ TRetornoPedido }

constructor TRetornoPedido.Create;
begin
  Self.FEtiqueta := TEtiqueta.Create;
end;

destructor TRetornoPedido.Destroy;
begin
  FreeAndNil(FEtiqueta);
  inherited;
end;

Class function TRetornoPedido.fFromJsonString(AJson: string; AAcao: TTipJadlog): TRetornoPedido;
var
  LResposta: TJSONObject;
  LEtiqueta: TJSONObject;
  LVolume: TJSONValue;
  LArrVolume: TJSONArray;
  LObjArrVolume: TJSONObject;
  LIndice: integer;
begin
  LResposta := TJSONObject.ParseJSONValue(AJson) as TJSONObject;
  if LResposta = nil then
    Exit(nil);

  Result := TRetornoPedido.Create;
  try
    if AAcao = TpJadIncluirPedido then
    begin
      If LResposta.GetValue('codigo') <> nil Then
        Result.Codigo := (LResposta.GetValue('codigo') as TJSONString).Value;

      LEtiqueta := (LResposta.GetValue('etiqueta') as TJSONObject);
      If LResposta.GetValue('etiqueta') <> nil Then
      begin
        If LEtiqueta.GetValue('volume') <> nil Then
        begin
          LVolume := LEtiqueta.Get('volume').JsonValue;
          LArrVolume := LVolume as TJSONArray;

          for LIndice := 0 to LArrVolume.Count - 1 do
          begin
            LObjArrVolume := (LArrVolume.Items[LIndice] as TJSONObject);
            SetLength(Result.FEtiqueta.FVolume, Length(Result.Etiqueta.Volume) + 1);
            Result.Etiqueta.Volume[Length(Result.Etiqueta.Volume) - 1] := TDadosEtiqueta.Create;
            Result.Etiqueta.Volume[Length(Result.Etiqueta.Volume) - 1].CodBarra := (LObjArrVolume.GetValue('codbarra') as TJSONString).Value;
            Result.Etiqueta.Volume[Length(Result.Etiqueta.Volume) - 1].LastMile := (LObjArrVolume.GetValue('lastMile') as TJSONString).Value;
            Result.Etiqueta.Volume[Length(Result.Etiqueta.Volume) - 1].Posicao := (LObjArrVolume.GetValue('posicao') as TJSONString).Value;
            Result.Etiqueta.Volume[Length(Result.Etiqueta.Volume) - 1].Prioridade := (LObjArrVolume.GetValue('prioridade') as TJSONNumber).AsInt;
            Result.Etiqueta.Volume[Length(Result.Etiqueta.Volume) - 1].Rota := (LObjArrVolume.GetValue('rota') as TJSONString).Value;
            Result.Etiqueta.Volume[Length(Result.Etiqueta.Volume) - 1].Rua := (LObjArrVolume.GetValue('rua') as TJSONString).Value;
            Result.Etiqueta.Volume[Length(Result.Etiqueta.Volume) - 1].SeqVolume := (LObjArrVolume.GetValue('seqVolume') as TJSONNumber).AsInt;
            Result.Etiqueta.Volume[Length(Result.Etiqueta.Volume) - 1].UnidadeDestino := (LObjArrVolume.GetValue('unidadeDestino') as TJSONString).Value;
          end;
        end;
      end;
    end;

    If LResposta.GetValue('shipmentId') <> nil Then
      Result.ShipmentId := (LResposta.GetValue('shipmentId') as TJSONString).Value;

    If LResposta.GetValue('status') <> nil Then
      Result.Status := (LResposta.GetValue('status') as TJSONString).Value;
  finally
    FreeAndNil(LResposta);
   end;
end;

{ TRespostaErro }

constructor TRespostaErro.Create;
begin
  Self.FErro := TErro.Create;
end;

destructor TRespostaErro.Destroy;
begin
  FreeAndNil(FErro);
  inherited;
end;

class function TRespostaErro.fFromJsonString(AJson: string; AAcao: TTipJadlog): TRespostaErro;
var
  LResposta: TJSONObject;
  LErro: TJSONObject;
begin
  Result := TRespostaErro.Create;

  LResposta := TJSONObject.ParseJSONValue(AJson) as TJSONObject;

  LErro := (LResposta.GetValue('erro') as TJSONObject);

  Result.Status := (LResposta.GetValue('status') as TJSONString).Value;
  Result.Erro.Descricao := (LErro.GetValue('descricao') as TJSONString).Value;

  if AAcao = TpJadCancelarPedido then
    Result.Erro.Detalhe := (LErro.GetValue('detalhe') as TJSONString).Value;

  Result.Erro.Id := (LErro.GetValue('id') as TJSONNumber).AsInt;
end;

{ TEtiqueta }

constructor TEtiqueta.Create;
begin
  SetLength(Self.FVolume, 0);
end;

destructor TEtiqueta.Destroy;
begin

  inherited;
end;

procedure pGravaLogRequisicao(ARequest, AResponse: string; AIdHTTP1: TIdHttp);
var
  strDir: String;
  stlLog: TStringList;
begin
  if (Pos('*', AResponse) > 0) or (Pos('erro', AResponse) > 0) then
  Begin
    strDir := TPath.Combine(ExtractFilePath(Application.ExeName), 'JADLOG');
    if not DirectoryExists(strDir) then
      CreateDir(strDir);

    stlLog := TStringList.Create;
    try
      stlLog.Add('--HOST');
      stlLog.Add(AIdHTTP1.Request.Host);
      stlLog.Add('--URL');
      stlLog.Add(AIdHTTP1.Request.URL);
      stlLog.Add('--CUSTOM HEADERS');
      stlLog.Add(AIdHTTP1.Request.CustomHeaders.Text);
      stlLog.Add('--REQUEST');
      stlLog.Add(ARequest);
      stlLog.Add('-------------------------------------------------------------');
      stlLog.Add('--RESPONSE CODE');
      stlLog.Add(AIdHTTP1.Response.ResponseCode.ToString);
      stlLog.Add('--RESPONSE TEXT');
      stlLog.Add(AIdHTTP1.Response.ResponseText);
      stlLog.Add('--CUSTOM HEADERS');
      stlLog.Add(AIdHTTP1.Response.CustomHeaders.Text);
      stlLog.Add('--RESPONSE');
      stlLog.Add(AResponse);

      stlLog.SaveToFile(TPath.Combine(strDir, FormatDateTime('yyyy_mm_dd_hh_mm_ss', fNow)+ '.txt'));
    finally
      FreeAndNil(stlLog);
    end;
  End;
end;

function fUsaJadLog(strNumDoc, strEspDoc, strCodEmp: string): Boolean;
var
  strCodTra: string;
begin
  strCodTra := fCampoTabela('GER_CODTRA', 'MOVGER', ['GER_NUMDOC','GER_ESPDOC','GER_CODEMP'],[strNumDoc, strEspDoc, strCodEmp], False);
  if fEmptyStr(strCodTra) then
    strCodTra := fCampoTabela('FGO_CODTRA', 'FATGOR', ['FGO_NUMDOC','FGO_ESPDOC','FGO_CODEMP'],[strNumDoc, strEspDoc, strCodEmp], False);

  Result := (fCfgSis('USAJAD', varBoolean)) and (fEhTransportadoraJadlog(strCodTra));
end;

function fEhTransportadoraJadlog(strCodTra: string): Boolean;
begin
  Result := fCampoTabela('TRA_ETIDES', 'CADTRA', ['TRA_CODTRA'], [strCodTra], False) = 'JADLOG';
end;

function fEhErroDuplicidade(AMensagem: String):Boolean;
var
  LMatch: TMatch;
  LPattern: string;
begin
  LPattern := 'Pedido:\s*[^\s]+\s+já foi enviado\.\s*Solicitacao de coleta:\s*(\d+)\s+com shipmentId:\s*(\d+)';
  LMatch := TRegEx.Match(AMensagem, LPattern, [roIgnoreCase]);
  Result := LMatch.Success;
end;

function fRetornaCodigoPedidoDuplicado(AMensagem: String): TRetornoPedido;
var
  LMatch: TMatch;
  LPattern: String;
begin
  Result := Nil;

  LPattern := 'Solicitacao de coleta:\s*(\d+)\s+com shipmentId:\s*(\d+)';
  LMatch := TRegEx.Match(AMensagem, LPattern, [roIgnoreCase]);

  if LMatch.Success then
  begin
    Result := TRetornoPedido.Create;
    Result.Status := '200';
    Result.Codigo := LMatch.Groups[1].Value;
    Result.ShipmentId := LMatch.Groups[2].Value;
  end;
end;

end.
