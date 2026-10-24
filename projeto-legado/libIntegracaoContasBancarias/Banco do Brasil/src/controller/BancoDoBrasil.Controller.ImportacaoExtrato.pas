unit BancoDoBrasil.Controller.ImportacaoExtrato;

interface

uses
  Forms,System.SysUtils, Winapi.Windows,System.JSON, System.NetEncoding, System.Generics.Collections,
  StrUtils,DateUtils, System.Classes, httpsend, ssl_openssl, blcksock, synautil,System.IOUtils,
  BancoDoBrasil.Model.ImportacaoExtrato, BancoDoBrasil.Model.LancamentoExtrato,
  ContasBancarias.Model.ContaBancaria, untLibContaBancariaConstantes,IdCoderMIME,
  untLibContaBancariaGravandoOld,untLibContaBancariaGravando,cxProgressBar;

type
  EServidorBancoBrasilTimeOutException = class(Exception);
  ECredenciaisInvalidasException = class(Exception);
  ECertificadoVencido = class(Exception);

Type
  TDadosToken = class
  public
    Token: String;
    Expiracao: Integer;
    DataLimite: TDateTime;
  end;

Type
  TDadosCertificado = class
  public
    ArquivoPfx,
    SenhaCertificado: String;
    Vencimento: TDate;
  end;

type
  TImportacaoExtratoBancoDoBrasil = class
  private
    FPastaLibContasBancarias: String;
    FLancamentosExtrato: TExtratoBancoDoBrasil;
    FContaBancaria: TContaBancaria;
    FDadosCertificado: TDadosCertificado;
    FDadosToken: TDadosToken;
    FUrlConsultaExtrato: String;
    FUrlToken: String;
    FFormGravando: TForm;
    FQuantidadePaginas: Integer;
    FUrlImportacao: String;
    FConsultaSaldo: Boolean;

    function ObterToken: TDadosToken;
    function RetornaUrlConsultaExtrato(APagina: Integer): String;
    function RetornaTokenAtivo: TDadosToken;
    function RetornaTokenObjectJson(AJsonRetorno: String): TDadosToken;
    procedure ImportarPagina(APagina: Integer; out ATemProxima: Boolean);
    function CriarLancamento(ALancamentoJSON: TJSONObject): TLancamentoExtrato;
    procedure AdicionaCertificadosRequisicao(var AComponente: THTTPSend);
    procedure CarregaCertificados;
    procedure RemoverCertificados;
    procedure CarregaUrl;
    function RetiraZerosEsquerda(AString: String): String;
    function RetornaTextoDoJsonDeErros(AErro: String): String;
    function ImportarExtratoBancario(pgbStatus: TcxProgressBar): Boolean;
    function FormatarCpfCnpjComZeros(AValor: Int64; ATipoPessoa: String): string;
    function ConverterInteiroParaData(AValor: Integer): TDate;
    function mciteste: String;
    procedure AguardeParaProximaRequisicao;
    function RetornaMensagemErroFormatada(AMensagemErro: String): String;
    function CertificadoEstaVencido: Boolean;
  public
    constructor Create(out AContaBancaria: TContaBancaria);
    destructor Destroy; override;
    procedure Importar;
    procedure ConsultarSaldo;
  end;

const
  C_URL_HOM        = 'https://api-extratos.hm.bb.com.br/extratos/v1';
  C_URL_OAUTH_HOM  = 'https://oauth.hm.bb.com.br/oauth/token';

implementation

uses untTLibContasBancariasFuncoes;

{ TImportacaoExtratoBancoDoBrasil }

procedure TImportacaoExtratoBancoDoBrasil.AdicionaCertificadosRequisicao(
  var AComponente: THTTPSend);
begin
  If FDadosCertificado.ArquivoPfx.IsEmpty Then
    Exit;

  AComponente.sock.SSL.PFXfile := FDadosCertificado.ArquivoPfx;
  AComponente.sock.SSL.Password := FDadosCertificado.SenhaCertificado;
  AComponente.sock.SSL.KeyPassword := FDadosCertificado.SenhaCertificado;
end;

procedure TImportacaoExtratoBancoDoBrasil.AguardeParaProximaRequisicao;
begin
  If FConsultaSaldo Then
    TLibContaBancariaFuncoes.AguardeTresSegundos
  Else
    TLibContaBancariaFuncoes.AguardeExecutarModalA(TLibContaBancariaFuncoes.AguardeCincoSegundos,
                                                   'Falha na comunicação, Nova tentativa em 5 segundos.', '');
end;

procedure TImportacaoExtratoBancoDoBrasil.CarregaCertificados;
  Var
    LStream: TMemoryStream;
    LDecoder: TIdDecoderMIME;
begin
  If FContaBancaria.CredenciaisAutenticacao.ArquivoPfx.IsEmpty Then
    Exit;

  If Not FDadosCertificado.ArquivoPfx.IsEmpty Then
    Exit;

  LDecoder := TIdDecoderMIME.Create(nil);
  LStream := TMemoryStream.Create;

  Try
    LDecoder.DecodeStream(FContaBancaria.CredenciaisAutenticacao.ArquivoPfx, LStream);

    FDadosCertificado.ArquivoPFX := FPastaLibContasBancarias +
                                     'temp\autb' +
                                      TLibContaBancariaFuncoes.fGetConnectionID +
                                       VS_strCodEmp +
                                        strLoginUsuarioLogado + 'x';


    FDadosCertificado.Vencimento := FContaBancaria.CredenciaisAutenticacao.DataValidadeCertificado;

    LStream.SaveToFile(FDadosCertificado.ArquivoPFX);
    FDadosCertificado.SenhaCertificado := FContaBancaria.CredenciaisAutenticacao.SenhaCertificado;
  Finally
    LDecoder.Free;
    LStream.Free;
  End;
end;

procedure TImportacaoExtratoBancoDoBrasil.CarregaUrl;
begin
  FUrlToken := VS_FuncoesExternas.fICfgSis('URLTBB',varString,VS_strCodEmp);
  FUrlConsultaExtrato := VS_FuncoesExternas.fICfgSis('URLEBB',varString,VS_strCodEmp);

  If FUrlConsultaExtrato.IsEmpty Then
    FUrlConsultaExtrato := C_URL_HOM;

  If FUrlToken.IsEmpty Then
    FUrlToken := C_URL_OAUTH_HOM;
end;

function TImportacaoExtratoBancoDoBrasil.CertificadoEstaVencido: Boolean;
begin
  Result := False;

  if not Assigned(FDadosCertificado) then
    Exit;

  if FDadosCertificado.Vencimento = 0 then
    Exit;

  If VS_FuncoesExternas.fIGetVS_Date = 0 then
    Exit;

  if FDadosCertificado.Vencimento >= VS_FuncoesExternas.fIGetVS_Date then
    Exit;

  Result := True;
end;

constructor TImportacaoExtratoBancoDoBrasil.Create(out AContaBancaria: TContaBancaria);
begin
  inherited Create;
  FPastaLibContasBancarias :=  ExtractFilePath(Application.ExeName);
  FLancamentosExtrato := TExtratoBancoDoBrasil.Create;
  FContaBancaria := AContaBancaria;
  FDadosCertificado := TDadosCertificado.Create;
  CarregaCertificados;
  CarregaUrl;
  FConsultaSaldo := False;
  FContaBancaria.ErroConsulta := '';
end;

destructor TImportacaoExtratoBancoDoBrasil.Destroy;
begin
  FLancamentosExtrato.Free;
  FDadosToken.Free;
  RemoverCertificados;
  inherited;
end;

procedure TImportacaoExtratoBancoDoBrasil.RemoverCertificados;
begin
  If Not Assigned(FDadosCertificado) Then
    Exit;

  Try
    If Not FDadosCertificado.ArquivoPfx.IsEmpty Then
    Begin
      If FileExists(PChar(FDadosCertificado.ArquivoPfx)) Then
        DeleteFile(PChar(FDadosCertificado.ArquivoPfx));
    End;
  Finally
    FreeAndNil(FDadosCertificado);
  End;
end;

function TImportacaoExtratoBancoDoBrasil.RetiraZerosEsquerda(
  AString: String): String;
begin
  While AString[1] = '0' do
    Delete(AString,1,1);

  Result := AString;
end;

function TImportacaoExtratoBancoDoBrasil.RetornaMensagemErroFormatada(
  AMensagemErro: String): String;
var
  LMensagem: String;
begin
  Result := AMensagemErro;

  LMensagem := LowerCase(AMensagemErro);

  if Pos('certificate is not allowed to call this resource method', LMensagem) > 0 then
  begin
    Result := 'O certificado cadastrado não possui permissão para acessar os recursos do Banco do Brasil.' + #13 +
              'Verifique se este certificado está vinculado corretamente no Portal Developers do Banco do Brasil.';
  end;
end;

function TImportacaoExtratoBancoDoBrasil.RetornaTextoDoJsonDeErros(
  AErro: String): String;
  Var
    LJsonObject: TJsonObject;

    LJsonArray: TJsonArray;

    LJsonValue: TJsonValue;

    LErroArray: String;
begin
  Result := AErro;
  Try
    LJsonObject := TJSONObject.ParseJSONValue(AErro) As TJsonObject;

    If LJsonObject = Nil Then
      Exit;

    If Not LJsonObject.TryGetValue('error_description', Result) Then
    Begin
      If LJsonObject.TryGetValue('erros', LJsonArray) Then
      Begin
        For LJsonValue In LJsonArray Do
        Begin
          If (LJsonValue As TJsonObject).TryGetValue('mensagem', LErroArray) Then
            Result := Result + LErroArray;
        End;
      End;
    End;

    If Result.IsEmpty Then
      Result := AErro;

    FreeAndNil(LJsonObject);
  Except
    Result := AErro;
  End;
end;

function TImportacaoExtratoBancoDoBrasil.RetornaTokenAtivo: TDadosToken;
begin
  Result := Nil;
  If Assigned(FDadosToken) Then
  Begin
    If IncSecond(FDadosToken.DataLimite, -60) > TLibContaBancariaFuncoes.fNow Then
      Exit(FDadosToken);
  End;
end;

function TImportacaoExtratoBancoDoBrasil.RetornaTokenObjectJson(AJsonRetorno: String): TDadosToken;
  Var
    LJsonObject: TJsonObject;
begin
  Result := TDadosToken.Create;

  Try
    LJsonObject := TJSONObject.ParseJSONValue(AJsonRetorno) as TJSONObject;
    Result.Token := LJsonObject.GetValue<String>('access_token');
    Result.Expiracao := LJsonObject.GetValue<Integer>('expires_in');
    Result.DataLimite := IncSecond(TLibContaBancariaFuncoes.fNow, Result.Expiracao);
  Finally
    FreeAndNil(LJsonObject);
  End;
end;

function TImportacaoExtratoBancoDoBrasil.RetornaUrlConsultaExtrato(APagina: Integer): String;
begin
  Result := Format('%s/conta-corrente/agencia/%s' +
                    '/conta/%s?' +
                    'gw-dev-app-key=%s&' +
                    'dataInicioSolicitacao=%s&' +
                    'dataFimSolicitacao=%s&' +
                    'numeroPaginaSolicitacao=%d&' +
                    'quantidadeRegistroPaginaSolicitacao=50',
                    [FUrlConsultaExtrato,
                     RetiraZerosEsquerda(FContaBancaria.Agencia),
                     RetiraZerosEsquerda(FContaBancaria.NumeroConta),
                     FContaBancaria.CredenciaisAutenticacao.AppKey,
                     RetiraZerosEsquerda(FormatDateTime('DDMMYYYY',FContaBancaria.DadosRequisicao.DataInicial)),
                     RetiraZerosEsquerda(FormatDateTime('DDMMYYYY',FContaBancaria.DadosRequisicao.DataFinal)),
                     APagina]);
end;

function TImportacaoExtratoBancoDoBrasil.ObterToken: TDadosToken;
var
  LHTTPSend: THTTPSend;
  LParams: TStringList;
  LJsonRetorno: String;
  LDadosEnvio: String;

  LFDataReq,
  LFDataResp: TMemoryStream;
begin
  Result := RetornaTokenAtivo;

  If Assigned(Result) Then
    Exit;

  LHTTPSend := THTTPSend.Create;
  LParams := TStringList.Create;
  try
    LHTTPSend.MimeType := 'application/x-www-form-urlencoded';
    LHTTPSend.Protocol  := '1.1';

    LHTTPSend.Sock.SSL.SSLType:= LT_all;

    LHTTPSend.Sock.SetTimeout( 30000 );
    LHTTPSend.Sock.ConnectionTimeout   := 30000;
    LHTTPSend.Sock.InterPacketTimeout  := False;
    LHTTPSend.Sock.NonblockSendTimeout := 30000;
    LHTTPSend.Sock.SocksTimeout        := 30000;
    LHTTPSend.Sock.HTTPTunnelTimeout   := 30000;

    LParams.Add('Authorization:' + FContaBancaria.CredenciaisAutenticacao.AutenticacaoBasic);
    LHTTPSend.Headers.AddStrings(LParams);

    AdicionaCertificadosRequisicao(LHTTPSend);

    LDadosEnvio := 'grant_type=client_credentials&' +
                   'scope=extrato-info';
    Try
      LFDataReq := TMemoryStream.Create;
      WriteStrToStream(LFDataReq, AnsiString(UTF8Encode(LDadosEnvio)));
      LHTTPSend.Document.LoadFromStream(LFDataReq);
    Finally
      FreeAndNil(LFDataReq);
    End;


    If LHTTPSend.HTTPMethod('POST', FUrlToken) Then
    Begin
      LHTTPSend.Document.Position := 0;

      Try
        LFDataResp := TMemoryStream.Create;
        LFDataResp.LoadFromStream(LHTTPSend.Document);

        LFDataResp.Position := 0;
        LJsonRetorno := UTF8ToString(ReadStrFromStream(LFDataResp, LFDataResp.Size));

        If Not MatchStr(LHTTPSend.ResultCode.ToString, ['200', '201']) Then
        Begin
          Raise ECredenciaisInvalidasException.Create('Ocorreu um erro ao realizar a autenticação no servidor do Banco do Brasil.' + #13 +
                                                       'Erro gerado: ' + RetornaTextoDoJsonDeErros(LJsonRetorno));
        End;

        Result := RetornaTokenObjectJson(LJsonRetorno);

      Finally
        FreeAndNil(LFDataResp);
      End;

    End
    Else If CertificadoEstaVencido Then
      raise ECertificadoVencido.Create('O certificado digital configurado na conta bancária está vencido.')
    Else
      raise EServidorBancoBrasilTimeOutException.Create('O servidor do Banco do Brasil não está respondendo no momento.' + #10#13 +
                                                        'Por favor, tente novamente mais tarde.');

  finally
    LParams.Free;
    LHTTPSend.Free;
  end;
end;

function TImportacaoExtratoBancoDoBrasil.CriarLancamento(ALancamentoJSON: TJSONObject): TLancamentoExtrato;
var
  LLancamento: TLancamentoExtrato;
  LTextoIdentificadorUnicoTransacao: String;
begin
  try
    LLancamento.Agencia := FContaBancaria.Agencia;
    LLancamento.Conta := FContaBancaria.NumeroConta;
    LLancamento.IndicadorTipoLancamento := ALancamentoJSON.GetValue<string>('indicadorTipoLancamento', '');

    LLancamento.DataLancamento := ConverterInteiroParaData(ALancamentoJSON.GetValue<Integer>('dataLancamento', 0));
    LLancamento.DataMovimento := ConverterInteiroParaData(ALancamentoJSON.GetValue<Integer>('dataMovimento', 0));

    LLancamento.CodigoAgenciaOrigem := ALancamentoJSON.GetValue<Integer>('codigoAgenciaOrigem', 0);
    LLancamento.NumeroLote := ALancamentoJSON.GetValue<Integer>('numeroLote', 0);
    LLancamento.NumeroDocumento := ALancamentoJSON.GetValue<Int64>('numeroDocumento', 0);
    LLancamento.CodigoHistorico := ALancamentoJSON.GetValue<Integer>('codigoHistorico', 0);
    LLancamento.TextoDescricaoHistorico := ALancamentoJSON.GetValue<string>('textoDescricaoHistorico', '');
    LLancamento.TextoDescricaoSubHistorico := ALancamentoJSON.GetValue<string>('textoDescricaoSubHistorico', '');
    LLancamento.ValorLancamento := ALancamentoJSON.GetValue<Double>('valorLancamento', 0);
    LLancamento.IndicadorSinalLancamento := ALancamentoJSON.GetValue<string>('indicadorSinalLancamento', '');
    LLancamento.TextoInformacaoComplementar := ALancamentoJSON.GetValue<string>('textoInformacaoComplementar', '');
    LLancamento.IndicadorTipoPessoaContrapartida := ALancamentoJSON.GetValue<string>('indicadorTipoPessoaContrapartida', '');

    LLancamento.NumeroCpfCnpjContrapartida := FormatarCpfCnpjComZeros(ALancamentoJSON.GetValue<Int64>('numeroCpfCnpjContrapartida', 0),
                                                                      LLancamento.IndicadorTipoPessoaContrapartida);

    LLancamento.CodigoBancoContrapartida := ALancamentoJSON.GetValue<Integer>('codigoBancoContrapartida', 0);
    LLancamento.CodigoAgenciaContrapartida := ALancamentoJSON.GetValue<Integer>('codigoAgenciaContrapartida', 0);
    LLancamento.NumeroContaContrapartida := ALancamentoJSON.GetValue<string>('numeroContaContrapartida', '');
    LLancamento.TextoDvContaContrapartida := ALancamentoJSON.GetValue<string>('textoDvContaContrapartida', '');

    if ALancamentoJSON.TryGetValue('textoIdentificadorUnicoTransacao', LTextoIdentificadorUnicoTransacao) then
      LLancamento.TextoIdentificadorUnicoTransacao := LTextoIdentificadorUnicoTransacao;

    LLancamento.OperadorImportacao := VS_FuncoesExternas.fIRetOperadorLogado;
    LLancamento.DataImportacao := VS_FuncoesExternas.fIGetVS_Date;
    LLancamento.HoraDaImportacao := TLibContaBancariaFuncoes.fTime;
    LLancamento.UrlImportacao := FUrlImportacao;
    LLancamento.ContaBancaria := FContaBancaria;

    Result := LLancamento;
  except
    raise;
  end;
end;

procedure TImportacaoExtratoBancoDoBrasil.ConsultarSaldo;
begin
  FConsultaSaldo := True;
  ImportarExtratoBancario(nil);
end;

function TImportacaoExtratoBancoDoBrasil.ConverterInteiroParaData(AValor: Integer): TDate;
var
  LDataStr: string;
  LDia, LMes, LAno: Word;
begin
  Result := 0;

  if AValor <= 0 then
    Exit;

  try
    LDataStr := FormatFloat('00000000', AValor);

    if Length(LDataStr) = 8 then
    begin
      LDia := StrToIntDef(Copy(LDataStr, 1, 2), 0);
      LMes := StrToIntDef(Copy(LDataStr, 3, 2), 0);
      LAno := StrToIntDef(Copy(LDataStr, 5, 4), 0);

      if (LDia > 0) and (LMes > 0) and (LAno > 0) then
        Result := EncodeDate(LAno, LMes, LDia);
    end;
  except
    Result := 0;
  end;
end;


function TImportacaoExtratoBancoDoBrasil.FormatarCpfCnpjComZeros(AValor: Int64; ATipoPessoa: String): string;
begin
 Result := '';

  if AValor > 0 then
  Begin
    If ATipoPessoa.Equals('J') Then
      Result := FormatFloat('00000000000000', AValor)
    Else
      Result := FormatFloat('00000000000', AValor);
  End;
end;

procedure TImportacaoExtratoBancoDoBrasil.ImportarPagina(APagina: Integer; out ATemProxima: Boolean);
var
  LHTTPSend: THTTPSend;
  LParams: TStringList;
  LJsonRetorno: String;

  LFDataResp: TMemoryStream;

  LJsonObject: TJSONObject;
  LLista: TJSONArray;
  I: Integer;
  LLancamento: TLancamentoExtrato;
  LMensagem: String;
begin
  ATemProxima := False;

  LHTTPSend := THTTPSend.Create;
  LParams := TStringList.Create;

  try
    LHTTPSend.MimeType := 'application/json; charset=utf-8';
    LHTTPSend.Protocol  := '1.1';

    LHTTPSend.Sock.SSL.SSLType:= LT_all;

    LHTTPSend.Sock.SetTimeout(30000);
    LHTTPSend.Sock.ConnectionTimeout   := 30000;
    LHTTPSend.Sock.InterPacketTimeout  := False;
    LHTTPSend.Sock.NonblockSendTimeout := 30000;
    LHTTPSend.Sock.SocksTimeout        := 30000;
    LHTTPSend.Sock.HTTPTunnelTimeout   := 30000;

    LParams.Add('Authorization:Bearer ' + FDadosToken.Token);
    LParams.Add('Accept: application/json');

    If FUrlConsultaExtrato.Contains('hm.bb') Then
      LParams.Add('x-br-com-bb-ipa-mciteste: ' + mciteste);

    LHTTPSend.Headers.AddStrings(LParams);

    AdicionaCertificadosRequisicao(LHTTPSend);

    LMensagem := 'Aguarde... Importando extrato bancário';
    If FQuantidadePaginas <> 0 Then
      LMensagem := Format('Aguarde... Importando extrato bancário (Página %d de %d)', [APagina, FQuantidadePaginas]);

    If Not FConsultaSaldo Then
    Begin
      TLibContaBancariaFuncoes.
        AlterarMensagemFormGravando(FFormGravando,LMensagem);

      TLibContaBancariaFuncoes.
        IniciarProgressoFormGravando(FFormGravando,0,0);
    End;

    FUrlImportacao := RetornaUrlConsultaExtrato(APagina);

    if LHTTPSend.HTTPMethod('GET', FUrlImportacao) then
    begin

      LHTTPSend.Document.Position := 0;

      Try
        LFDataResp := TMemoryStream.Create;
        LFDataResp.LoadFromStream(LHTTPSend.Document);

        LFDataResp.Position := 0;
        LJsonRetorno := UTF8ToString(ReadStrFromStream(LFDataResp, LFDataResp.Size));

        If Not MatchStr(LHTTPSend.ResultCode.ToString, ['200', '201']) Then
        Begin
          Raise Exception.Create('Ocorreu um erro ao realizar a importação do extrato do Banco do Brasil.' + #13 +
                                 'Erro gerado: ' + RetornaTextoDoJsonDeErros(LJsonRetorno));
        End;

        LJsonObject := TJSONObject.ParseJSONValue(LJsonRetorno) as TJSONObject;
        if Assigned(LJsonObject) then
        begin
          Try
            FQuantidadePaginas := LJsonObject.GetValue<Integer>('quantidadeTotalPagina', 0);

            If Not FConsultaSaldo Then
              TLibContaBancariaFuncoes.
               IniciarProgressoFormGravando(FFormGravando,0,LJsonObject.GetValue<Integer>('quantidadeRegistroPaginaAtual', 0));

            ATemProxima := LJsonObject.GetValue<Integer>('numeroPaginaProximo', 0) > 0;
            LLista := LJsonObject.GetValue<TJSONArray>('listaLancamento');

            if Assigned(LLista) then
            begin
              for I := 0 to LLista.Count - 1 do
              begin
                LLancamento := CriarLancamento(LLista.Items[I] as TJSONObject);

                If Not FConsultaSaldo Then
                  FLancamentosExtrato.SalvarLancamento(LLancamento);

                If Not FConsultaSaldo Then
                  TLibContaBancariaFuncoes.
                   AtualizarStatusProgressaFormGravando(FFormGravando);

                If FConsultaSaldo Then
                Begin
                  If LLancamento.CodigoHistorico = 999 Then
                  Begin
                    FLancamentosExtrato.SalvarLancamento(LLancamento);

                    FContaBancaria.Saldo :=  LLancamento.ValorLancamento;
                    ATemProxima := False;
                    Exit;
                  End;
                End;

              end;

            end;
          Finally
            LJsonObject.Free;
          End;

        end;

      Finally
        If Assigned(LFDataResp) Then
          FreeAndNil(LFDataResp);
      End;

    end
    else if CertificadoEstaVencido then
      raise ECertificadoVencido.Create('O certificado digital configurado na conta bancária está vencido.')
    else
      raise EServidorBancoBrasilTimeOutException.Create('O servidor do Banco do Brasil não está respondendo no momento.' + #10#13 +
                                                        'Por favor, tente novamente mais tarde.');
  finally
    LHTTPSend.Free;
  end;
end;

function TImportacaoExtratoBancoDoBrasil.mciteste: String;
begin
  case FContaBancaria.Agencia.ToInteger of
    551: Result := '26968930';
    1505: Result := '178961031';
    452: Result := '704950857';
  end;
end;

procedure TImportacaoExtratoBancoDoBrasil.Importar;
begin
  FFormGravando := TLibContaBancariaFuncoes.CriarFormGravando;
  Try
    TLibContaBancariaFuncoes.
     AlterarMensagemFormGravando(FFormGravando,'Aguarde... Importando Extrato Bancario.');

    TLibContaBancariaFuncoes.
     AdicionarFuncaoAcaoFormGravando(FFormGravando,ImportarExtratoBancario);

    FFormGravando.ShowModal;

  Finally
    FreeAndNil(FFormGravando);
  End;
end;

function TImportacaoExtratoBancoDoBrasil.ImportarExtratoBancario(pgbStatus: TcxProgressBar): Boolean;
  var
    LPagina: Integer;
    LTemProxima: Boolean;
    LContadorTentativas : Integer;
begin
  Result := False;
  FQuantidadePaginas := 0;
  FContaBancaria.QuantidadeDeMovimentacoes := 0;
  LContadorTentativas := 1;
  LPagina := 1;

  While (LContadorTentativas <= 2) Do
  begin
    Try

      Repeat
        FDadosToken := ObterToken;
        ImportarPagina(LPagina, LTemProxima);

        Inc(LPagina);
      Until Not LTemProxima;

      Exit(True);


    Except
      On E: EServidorBancoBrasilTimeOutException Do
      Begin
        AguardeParaProximaRequisicao;

        If LContadorTentativas >= 2 Then
        begin
          FContaBancaria.ErroConsulta := E.Message;
          VS_FuncoesExternas.pIGravarErro(True,E.Message,E.Message);
        End;
      End;

      On E: ECertificadoVencido Do
      Begin
        FContaBancaria.ErroConsulta := E.Message;
        VS_FuncoesExternas.pIGravarErro(True,E.Message,E.Message);
        Break;
      End;

      On E: ECredenciaisInvalidasException Do
      Begin
        AguardeParaProximaRequisicao;

        If LContadorTentativas >= 2 Then
        begin
          FContaBancaria.ErroConsulta :=
            'Não foi possível realizar a autenticação.' + sLineBreak +
            'Verifique sua conexão com a internet,' + sLineBreak +
            'confirme suas credenciais de autenticação' + sLineBreak +
            'e tente novamente mais tarde.';

          VS_FuncoesExternas.pIGravarErro(True,E.Message,E.Message);
        End;
      End;

      On E: Exception Do
      begin
        AguardeParaProximaRequisicao;

        If LContadorTentativas >= 2 Then
        begin
          FContaBancaria.ErroConsulta := 'Ocorreu um problema inesperado ao processar a consulta. tente novamente mais tarde.' + sLineBreak+
                                         'Problema: ' + RetornaMensagemErroFormatada(E.Message);
          VS_FuncoesExternas.pIGravarErro(True,E.Message,E.Message);
        end;

      end;
    End;

    Inc(LContadorTentativas);
  End;
end;

end.