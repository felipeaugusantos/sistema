unit untManifestoFit;

interface

uses
{$IFDEF LINUX}
{$ELSE}
  Windows,
  Forms,
  Dialogs,
{$ENDIF}
  untInterfaces, StrUtils, Math, SysUtils, Classes, untValidadorNFE, DateUtils,
  NfeApiWSBean, untManifestoEletronico, untInterfacesManifestoEletronico,
  untConstantesNFe, untUtilFIT, Types;

Type
  TIntegracaoManifestoFit = class(TInterfacedObject, IIntegracaoManifestoEletronico)
    private
      fitWrapper: TWSNFeFitWrapper;
      blnManifesto300a: Boolean;

      strProtocoloManifesto : String;
      strModeloManifesto    : String;
      strDataHoraManifesto  : String;
      FfonteDados: IFonteDadosManifesto;

      procedure pGeraHeader(stlTexto: TStringList);
      procedure pGeraMDFE(stlTexto: TStringList; manifesto: TManifestoEletronico);
      procedure pGeraMDFECarregamento(stlTexto: TStringList; manifesto: TManifestoEletronico);
      procedure pGeraMDFENFe(stlTexto: TStringList; manifesto: TManifestoEletronico);
      procedure pGeraMDFESeguroDaCarga(stlTexto: TStringList; manifesto: TManifestoEletronico);
      procedure pGeraMDFESeguroDaCargaAverbacao(stlTexto: TStringList; manifesto: TManifestoEletronico);
      procedure pGeraMDFETotal(stlTexto: TStringList; manifesto: TManifestoEletronico);
      procedure pGeraMDFECondutor(stlTexto: TStringList; manifesto: TManifestoEletronico);
      procedure pGeraMDFEModalRodoviario(stlTexto: TStringList; manifesto: TManifestoEletronico);
      procedure pGeraMDFEPercurso(stlTexto: TStringList; manifesto: TManifestoEletronico);
      procedure pGeraMDFEInformacoesAdicionaisContribuinte(stlTexto: TStringList; manifesto: TManifestoEletronico);
      procedure pGeraMDFETrailler(stlTexto: TStringList);
      procedure pGeraMDFEEventoIncDFe(stlTexto: TStringList; manifesto: TManifestoEletronico; strListaAutoIncrem: string);

      procedure pGeraMDFEProdutoPredominante(stlTexto: TStringList; manifesto: TManifestoEletronico);
      procedure pGeraMDFEInformacoesPagamentoFrete(stlTexto: TStringList; manifesto: TManifestoEletronico);

      {Evento Pagamento da Operação de Transporte}
      procedure pGeraMDFEEventoInformacoesPagamentoFrete(stlTexto: TStringList; manifesto: TManifestoEletronico);

      function fFormataValorFit(fltValor: Double; intPrecisao,
        intDecimais: Integer): String;

      function fGeraRetornoNfeManifesto(
        retornoFit: TWSNfeFitRetorno): TRetornoNFE;
      procedure pGeraMDFECTe(stlTexto: TStringList; manifesto: TManifestoEletronico);
      function fGetTipoTransportador(const manifesto: TManifestoEletronico): string;
      procedure pGeraMDFEInformacoesContratante(stlTexto: TStringList; manifesto: TManifestoEletronico);
      procedure pGeraMDFEModalRodoviarioReboque(stlTexto: TStringList; manifesto: TManifestoEletronico);

      procedure pDefinirCodigos(const intPosicao     : Integer;
                                const manifesto      : TManifestoEletronico;
                                  var   strCodigoIbge  : String;
                                  var   strChaveAcesso : String);

    public
      constructor Create(fonteDados: IFonteDadosManifesto);
      destructor Destroy; Override;
      function fEnviarManifesto(manifesto: TManifestoEletronico): Boolean;
      function fProcessarManifesto(manifesto: TManifestoEletronico): TRetornoNFE; overload;
      function fProcessarManifesto(manifesto: TManifestoEletronico; strImpressora: String): TRetornoNFE; overload;
      procedure pImprimirManifesto(manifesto: TManifestoEletronico; strImpressora: String);
      function fEncerrarManifesto(manifesto: TManifestoEletronico): Boolean;
      function fCancelarManifesto(manifesto: TManifestoEletronico; strJustificativa: String): Boolean;
      function fEnviarDocsCarregadosManifesto(manifesto: TManifestoEletronico; strListaAutoIncrem: string): Boolean;
      function fEnviarManifestoEventoPagamento(manifesto: TManifestoEletronico): Boolean;
  end;

implementation

uses untUtil, untUtilBD, untLogDanfe, untDicSis;

{ TIntegracaoManifestoFit }

constructor TIntegracaoManifestoFit.Create(fonteDados: IFonteDadosManifesto);
begin
  FfonteDados := fonteDados;
  fitWrapper := TWSNFeFitWrapper.Create;
  fitWrapper.modeEnvSoap := fGetModeEnvSoap(fonteDados);

  If Not fEmptyStr(objConfig.strFitUrlWebServiceManifesto) Then
    fitWrapper.strUrlAlternativa := objConfig.strFitUrlWebServiceManifesto;
end;

destructor TIntegracaoManifestoFit.Destroy;
begin
  FreeAndNil(fitWrapper);
  inherited;
end;

function TIntegracaoManifestoFit.fCancelarManifesto(
  manifesto: TManifestoEletronico; strJustificativa: String): Boolean;
  Var
    strTexto: String;
    retornoFit: TWSNfeFitRetorno;
    retornoNFE: TRetornoNFE;

    tmrInicial: TDateTime;
  Const
    TIMEOUT_CANCELAMENTO = 20;
begin
  retornoFit := fitWrapper.fConsultaSituacaoIdManifesto(manifesto.strIdReferencia);
  retornoNFE := fGeraRetornoNfeManifesto(retornoFit);

  If retornoNFE.Cancelada Then
  Begin
    Result := True;

    If Assigned(retornoFit) Then
      FreeAndNil(retornoFit);

    If Assigned(retornoNFE) Then
      FreeAndNil(retornoNFE);

    Exit;
  End;

  strTexto := 'MDFE-EVENTO-CANC|' +             // 01 - Tipo de Registro
              manifesto.strIdReferencia + '|' + // 02 - ID Referência
              '|' +                             // 03 - Chave de Acesso
              '|' +                             // 04 - Número Protocolo
              strJustificativa;                 // 05 - Justificativa


  strTexto := fTiraCaracEspeciais(strTexto, False, False, False);

  retornoFit := fitWrapper.fEnviaTextoIntegracaoMDFE(strTexto);

  Result := retornoFit.RetornoOk;
  If Not Result Then
  Begin
    if (fCountChar(retornoFit.Texto, '|') >= 7) then
      Raise Exception.Create('Não foi possível enviar o cancelamento do manifesto: ' + fGetValorLinha(retornoFit.Texto, '|', 7))
    else
      Raise Exception.Create('Não foi possível enviar o cancelamento do manifesto: ' + retornoFit.Texto);
  End;

  Result := False;
  tmrInicial := nOw();
  While (Not Result)                                              And
        (SecondsBetween(nOw(), tmrInicial) <= TIMEOUT_CANCELAMENTO) Do
  Begin
    retornoFit := fitWrapper.fConsultaSituacaoIdManifesto(manifesto.strIdReferencia);
    retornoNFE := fGeraRetornoNfeManifesto(retornoFit);

    If retornoNFE.Cancelada Then
      Result := True;
  End;

  If Not Result Then
    Raise Exception.Create('Timeout na consulta do cancelamento do manifesto ' + manifesto.strNumeroManifesto + '. Tente novamente.');

  If Assigned(retornoFit) Then
    FreeAndNil(retornoFit);

  If Assigned(retornoNFE) Then
    FreeAndNil(retornoNFE);
end;

function TIntegracaoManifestoFit.fEncerrarManifesto(
  manifesto: TManifestoEletronico): Boolean;
  Var
    strTexto: String;
    retornoFit: TWSNfeFitRetorno;
    retornoNFE: TRetornoNFE;

    tmrInicial: TDateTime;
  Const
    TIMEOUT_ENCERRAMENTO = 20; //Segundos
begin
  retornoFit := fitWrapper.fConsultaEncerramentoIdManifesto(manifesto.strIdReferencia);
  retornoNFE := fGeraRetornoNfeManifesto(retornoFit);

  If retornoNFE.Encerrada Then
  Begin
    Result := True;

    If Assigned(retornoFit) Then
      FreeAndNil(retornoFit);

    If Assigned(retornoNFE) Then
      FreeAndNil(retornoNFE);

    Exit;
  End;

  strTexto := 'MDFE-EVENTO-ENCERRAMENTO|' + // 01 - Tipo do Registro
              manifesto.strIdReferencia + '|' + // 02 - ID Referencia
              '|' + // 03 - Chave de Acesso
              '|' + // 04 - Numero do protocolo
              FormatDateTime('ddmmyyyy', nOw()) + '|' + // 05 - Data do encerramento
              IIF(manifesto.strCargaPosterior = 'S', manifesto.strIbgeCarregamentoPosterior, manifesto.strIbgeCarregamento);

  strTexto := fTiraCaracEspeciais(strTexto, False, False, False);

  retornoFit :=  fitWrapper.fEnviaTextoIntegracaoMDFE(strTexto);

  Result := retornoFit.RetornoOk;

  If Not Result Then
  Begin
    if (fCountChar(retornoFit.Texto, '|') >= 7) then
      Raise Exception.Create('Não foi possível enviar o encerramento do manifesto: ' + fGetValorLinha(retornoFit.Texto, '|', 7))
    else
      Raise Exception.Create('Não foi possível enviar o encerramento do manifesto: ' + retornoFit.Texto);
  End;

  Result := False;
  tmrInicial := nOw();
  While (Not Result)                                              And
        (SecondsBetween(nOw(), tmrInicial) <= TIMEOUT_ENCERRAMENTO) Do
  Begin
    retornoFit := fitWrapper.fConsultaSituacaoIdManifesto(manifesto.strIdReferencia);
    retornoNFE := fGeraRetornoNfeManifesto(retornoFit);

    If retornoNFE.Encerrada Then
      Result := True;
  End;

  If Not Result Then
    Raise Exception.Create('Timeout na consulta do encerramento do manifesto ' + manifesto.strNumeroManifesto + '. Tente novamente.');

  If Assigned(retornoFit) Then
    FreeAndNil(retornoFit);

  If Assigned(retornoNFE) Then
    FreeAndNil(retornoNFE);
end;

function TIntegracaoManifestoFit.fEnviarDocsCarregadosManifesto(
  manifesto: TManifestoEletronico; strListaAutoIncrem: string): Boolean;
  Var
    stlTexto: TStringList;
    retornoFit: TWSNfeFitRetorno;

    strMsg: String;
    resultValidacao: TResultadoValidacao;
    strPipe3, strPipe7 : String;
begin
  stlTexto := TStringList.Create;
  try
    pGeraMDFEEventoIncDFe(stlTexto, manifesto, strListaAutoIncrem);

    stlTexto.Text := fTiraCaracEspeciais(stlTexto.Text, False, False, False);

    retornoFit := fitWrapper.fEnviaTextoIntegracaoMDFE(stlTexto.Text);

    Try
      stlTexto.SaveToFile(fPnlDir('ULTIMO_MANIFESTO.TXT'));
    Except

    End;

    Result := retornoFit.RetornoOk;

    stlTexto.Clear;
    stlTexto.Add(retornoFit.Texto);

    Try
      stlTexto.SaveToFile(fPnlDir('ULTIMO_RETORNO_MDFE.TXT'));
    Except

    End;
  finally
    FreeAndNil(stlTexto);
  end;

  If Not Result Then
  Begin
    strPipe3 := '';
    strPipe7 := '';

    if (fCountChar(retornoFit.Texto, '|') >= 3) then
      strPipe3 := fGetValorLinha(retornoFit.Texto, '|', 3);
    if (fCountChar(retornoFit.Texto, '|') >= 7) then
      strPipe7 := fGetValorLinha(retornoFit.Texto, '|', 7);

    If Not fEmptyStr(strPipe3 + strPipe7) Then
      strMsg := 'Erro: ' + strPipe3 + ': ' + strPipe7
    Else
      strMsg := IIF(fEmptyStr(retornoFit.Texto), '(Não obteve nenhum retorno da FIT)', retornoFit.Texto);

    resultValidacao := TResultadoValidacao.Create;
    resultValidacao.pAdicionarErro(strMsg, Nil);
    pLogImp(strMsg);
    Raise ErrosValidacaoNFE.Create(strMsg, resultValidacao);
  End;

  If Assigned(retornoFit) Then
    FreeAndNil(retornoFit);
end;

function TIntegracaoManifestoFit.fEnviarManifesto(manifesto: TManifestoEletronico): Boolean;
Var
  stlTexto        : TStringList;
  retornoFit      : TWSNfeFitRetorno;
  retornoNFE      : TRetornoNFE;
  strMsg          : String;
  resultValidacao : TResultadoValidacao;
  strPipe3,
  strPipe7        : String;
begin
  retornoFit    := fitWrapper.fConsultaSituacaoIdManifesto(manifesto.strIdReferencia);
  retornoNFE := fGeraRetornoNfeManifesto(retornoFit);

  If retornoNFE.Sucesso Then
  Begin
    Result := True;

    If Assigned(retornoFit) Then
      FreeAndNil(retornoFit);

    If Assigned(retornoNFE) Then
      FreeAndNil(retornoNFE);

    Exit;
  End;

  blnManifesto300a := manifesto.strVersao = '3.00a';

  stlTexto := TStringList.Create;

  try

    pGeraHeader(stlTexto);
    pGeraMDFE(stlTexto, manifesto);
    pGeraMDFECarregamento(stlTexto, manifesto);
    pGeraMDFECTe(stlTexto, manifesto);
    pGeraMDFENFe(stlTexto, manifesto);
    pGeraMDFESeguroDaCarga(stlTexto, manifesto);
    pGeraMDFESeguroDaCargaAverbacao(stlTexto, manifesto);
    pGeraMDFETotal(stlTexto, manifesto);
    pGeraMDFEModalRodoviario(stlTexto, manifesto);
    pGeraMDFECondutor(stlTexto, manifesto);
    pGeraMDFEModalRodoviarioReboque(stlTexto, manifesto);
    pGeraMDFEPercurso(stlTexto, manifesto);
    pGeraMDFEInformacoesAdicionaisContribuinte(stlTexto, manifesto);

    pGeraMDFEProdutoPredominante(stlTexto, manifesto);
    pGeraMDFEInformacoesPagamentoFrete(stlTexto, manifesto);
    pGeraMDFEInformacoesContratante(stlTexto, manifesto);

    pGeraMDFETrailler(stlTexto);

    stlTexto.Text := fTiraCaracEspeciais(stlTexto.Text, False, False, False);

    retornoFit := fitWrapper.fEnviaTextoIntegracaoMDFE(stlTexto.Text);

    Try
      stlTexto.SaveToFile(fPnlDir('ULTIMO_MANIFESTO.TXT'));
    Except

    End;

    Result := retornoFit.RetornoOk;

    stlTexto.Clear;
    stlTexto.Add(retornoFit.Texto);

    Try
      stlTexto.SaveToFile(fPnlDir('ULTIMO_RETORNO_MDFE.TXT'));
    Except

    End;
  finally
    FreeAndNil(stlTexto);
  end;

  If Not Result Then
  Begin
    strPipe3 := '';
    strPipe7 := '';

    if (fCountChar(retornoFit.Texto, '|') >= 3) then
      strPipe3 := fGetValorLinha(retornoFit.Texto, '|', 3);
    if (fCountChar(retornoFit.Texto, '|') >= 7) then
      strPipe7 := fGetValorLinha(retornoFit.Texto, '|', 7);

    If Not fEmptyStr(strPipe3 + strPipe7) Then
      strMsg := 'Erro: ' + strPipe3 + ': ' + strPipe7
    Else
      strMsg := IIF(fEmptyStr(retornoFit.Texto), '(Não obteve nenhum retorno da FIT)', retornoFit.Texto);

    resultValidacao := TResultadoValidacao.Create;
    resultValidacao.pAdicionarErro(strMsg, Nil);
    pLogImp(strMsg);
    Raise ErrosValidacaoNFE.Create(strMsg, resultValidacao);
  End;

  If Assigned(retornoFit) Then
    FreeAndNil(retornoFit);

  If Assigned(retornoNFE) Then
    FreeAndNil(retornoNFE);
end;

function TIntegracaoManifestoFit.fEnviarManifestoEventoPagamento(manifesto: TManifestoEletronico): Boolean;
Var
  stlTexto        : TStringList;
  retornoFit       : TWSNfeFitRetorno;
  strMsg          : String;
  resultValidacao : TResultadoValidacao;
  strPipe3,
  strPipe7        : String;
begin

  blnManifesto300a := manifesto.strVersao = '3.00a';

  stlTexto := TStringList.Create;

  try

    pGeraMDFEEventoInformacoesPagamentoFrete(stlTexto, manifesto);

    stlTexto.Text := fTiraCaracEspeciais(stlTexto.Text, False, False, False);

    retornoFit := fitWrapper.fEnviaTextoIntegracaoMDFE(stlTexto.Text);

    Try
      stlTexto.SaveToFile(fPnlDir('ULTIMO_MANIFESTO_EVENTO_PAGTO.TXT'));
    Except

    End;

    Result := retornoFit.RetornoOk;

    stlTexto.Clear;
    stlTexto.Add(retornoFit.Texto);

    Try
      stlTexto.SaveToFile(fPnlDir('ULTIMO_RETORNO_MDFE_EVENTO_PAGTO.TXT'));
    Except

    End;
  finally
    FreeAndNil(stlTexto);
  end;

  If Not Result Then
  Begin

    strPipe3 := '';
    strPipe7 := '';

    if (fCountChar(retornoFit.Texto, '|') >= 3) then
      strPipe3 := fGetValorLinha(retornoFit.Texto, '|', 3);

    if (fCountChar(retornoFit.Texto, '|') >= 7) then
      strPipe7 := fGetValorLinha(retornoFit.Texto, '|', 7);

    If Not fEmptyStr(strPipe3 + strPipe7) Then
      strMsg := 'Erro: ' + strPipe3 + ': ' + strPipe7
    Else
      strMsg := IIF(fEmptyStr(retornoFit.Texto), '(Não obteve nenhum retorno da FIT)', retornoFit.Texto);

    resultValidacao := TResultadoValidacao.Create;
    resultValidacao.pAdicionarErro(strMsg, Nil);
    pLogImp(strMsg);
    Raise ErrosValidacaoNFE.Create(strMsg, resultValidacao);

  End;

  If Assigned(retornoFit) Then
    FreeAndNil(retornoFit);
end;

procedure TIntegracaoManifestoFit.pDefinirCodigos(const intPosicao   : Integer;
                                                  const manifesto    : TManifestoEletronico;
                                                    var strCodigoIbge  : String;
                                                    var strChaveAcesso : String);
begin

  strCodigoIbge  := '';
  strChaveAcesso := '';

  if manifesto.strCargaPosterior = 'S' then
  begin
    strCodigoIbge  := manifesto.strIbgeCarregamento;
    strChaveAcesso := '|';
  end
  else
  begin

    If Not fEmptyStr(manifesto.strDescarregamento_IBGE_) Then
      strCodigoIbge := manifesto.strDescarregamento_IBGE_
    Else
      strCodigoIbge := manifesto.NFe[intPosicao].strIbge;

    strChaveAcesso := manifesto.NFe[intPosicao].strChaveAcesso + '|';

  end;

end;

procedure TIntegracaoManifestoFit.pGeraHeader(stlTexto: TStringList);
begin
  stlTexto.Add('HEADER|3.00');
end;

procedure TIntegracaoManifestoFit.pGeraMDFE(stlTexto: TStringList; manifesto: TManifestoEletronico);
var
  strPrevisaoViagem : String;
  strTipoTransportador : string;
begin

  {manifesto.ProprietarioVeiculo.intTipoProprietario:
   0 – TAC Agregado
   1 – TAC Independente
   2 – Outros}
  strTipoTransportador := fGetTipoTransportador(manifesto);

  strPrevisaoViagem := IIF(fEmptyStr(manifesto.strPrevisaoViagem),'',manifesto.strPrevisaoViagem);

  stlTexto.Add(
    'MDFE|' +                                                    // 01 - Tipo de Registro
    manifesto.strIdReferencia + '|' +                            // 02 - Id Referência
    manifesto.strCnpjEmitente + '|' +                            // 03 - CNPJ Emitente
    manifesto.strUfEmitente + '|' +                              // 04 - UF do Emitente
    manifesto.strTipoEmitente + '|' +                            // 05 - Tipo do Emitente
    manifesto.strSerie + '|' +                                   // 06 - Serie
    manifesto.strNumeroManifesto + '|' +                         // 07 - Número do Manifesto
    '|' +                                                        // 08 - Código Chave Acesso
    manifesto.strModalidade + '|' +                              // 09 - Modalidade
    FormatDateTime('ddmmyyyy', manifesto.dtaDataEmissao) + '|' + // 10 - Data de Emissão
    FormatDateTime('hhnnss', nOw()) + '|' +                      // 11 - Hora Saída / Entrada
    IIF(objConfig.blnHomolo, '2', '1') + '|' +                   // 12 - Tipo de Ambiente (1-PRODUÇÃO, 2-HOMOLOGAÇÃO)

    IIF(fEmptyStr(manifesto.strCarregamentoEstado),
        manifesto.strUfCarregamento,
        manifesto.strCarregamentoEstado) + '|' +                 // 13 - UF Carregamento

    manifesto.strUfDescarregamento + '|'+                        // 14 - UF Descarregamento
    '|' +                                                        // 15 - Codigo / Usuário / Arquivo
    strTipoTransportador + '|' +                                 // 16 - Tipo do Transportador
    strPrevisaoViagem +'|'+                                      // 17 - Data e hora previstos de inicio da viagem
    '|' +                                                        // 18 - Indicador de Participação no Canal Verde
    IIF(manifesto.strCargaPosterior='S', '1', '') + '|'          // 19 - Indicador de MDF-e com inclusão da Carga posterior a emissão por evento de inclusão de DF-e
  );

end;

procedure TIntegracaoManifestoFit.pGeraMDFECarregamento(stlTexto: TStringList;
  manifesto: TManifestoEletronico);
begin
  stlTexto.Add(
    'MDFE-CARREGAMENTO|' +                       // 01 - Tipo de Registro
    manifesto.strIdReferencia + '|' +            // 02 - Id Referência

    IIF(fEmptyStr(manifesto.strCarregamento_IBGE_),
        manifesto.strIbgeCarregamento,
        manifesto.strCarregamento_IBGE_)+ '|' +  // 03 - Código IBGE Município Carregamento

    IIF(fEmptyStr(manifesto.strCarregamentoNomCid),
        manifesto.strNomeMunicipioCarregamento,
        manifesto.strCarregamentoNomCid)         // 04 - NOme Município Carregamento
  );
end;

procedure TIntegracaoManifestoFit.pGeraMDFECondutor(stlTexto: TStringList;
  manifesto: TManifestoEletronico);
var
  I: Integer;
begin
  for I := 0 to Pred(manifesto.intQtdeManifesto) do
  begin
    stlTexto.Add(
      'MDFE-MODAL-RODOVIARIO-CONDUTOR|' +              // 01 - Tipo de Registro
      manifesto.strIdReferencia + '|' +                // 02 - Id Referência
      manifesto.Motorista[I].strCpfMotorista + '|' +   // 03 - CPF Condutor
      manifesto.Motorista[I].strNomeMotorista + '|'    // 04 - Nome do Condutor
    );
  end;
end;

procedure TIntegracaoManifestoFit.pGeraMDFECTe(stlTexto: TStringList; manifesto: TManifestoEletronico);
var
  intIndex: Integer;
  strCodigoIbge: string;
  strChaveAcesso: string;
begin
  strCodigoIbge  := IIF(manifesto.strCargaPosterior = 'S', manifesto.strIbgeCarregamento, '');
  strChaveAcesso := '|';
  For intIndex := 0 To manifesto.intQtdeCte -1 Do
  Begin
    if manifesto.strCargaPosterior = 'N' then
    begin
      strCodigoIbge  := manifesto.CTe[intIndex].strIbge;
      strChaveAcesso := manifesto.CTe[intIndex].strChaveAcesso + '|';
    end;

    stlTexto.Add(
      'MDFE-CTE|' +                       // 01 - Tipo de Registro
      manifesto.strIdReferencia + '|' +   // 02 - Id Referência
      IntToStr(intIndex) + '|' +          // 03 - Nr. Item
      strCodigoIbge + '|' +               // 04 - Código IBGE do Municipio
      strChaveAcesso +                    // 05 - Chave de Acesso NF-e
      '|'+IIF(blnManifesto300a, '|', '')  // 06 - Segundo código de barras + 07 - Indicador de Reentrega
    );
  End;
end;

procedure TIntegracaoManifestoFit.pGeraMDFEEventoIncDFe(stlTexto: TStringList;
  manifesto: TManifestoEletronico; strListaAutoIncrem: string);
  Var
    intIndex: Integer;
    intSequencial: Integer;
begin
  intSequencial := 0;
  For intIndex := 0 To manifesto.intQtdeNfe -1 Do
  Begin
    if Pos(manifesto.NFe[intIndex].strAutoIncrem, strListaAutoIncrem) <= 0 then
      Continue;

    stlTexto.Add(
      'MDFE-EVENTO-INCLUSAO-DFE|' +                   // 01 - Tipo de Registro
      manifesto.strIdReferencia + '|' +               // 02 - Id Referência
      '|' +                                           // 03 - Chave de Acesso
      IntToStr(intSequencial) + '|' +                 // 04 - Sequencial
      '|' +                                           // 05 - Numero Protocolo
      manifesto.strIbgeCarregamentoPosterior + '|' +  // 06 - Código IBGE do Municipio de Carregamento
      manifesto.NFe[intIndex].strIbge + '|' +         // 07 - Código IBGE do Municipio de Descarregamento
      manifesto.NFe[intIndex].strChaveAcesso + '|'    // 08 - Chave de Acesso NF-e
    );

    Inc(intSequencial);
  End;
end;

procedure TIntegracaoManifestoFit.pGeraMDFEEventoInformacoesPagamentoFrete(stlTexto: TStringList; manifesto: TManifestoEletronico);
var
  intIndexPAG,
  intIndexCOM,
  intIndexPRA,
  intNumPro : Integer;

  strParcela : String;

begin

  If (manifesto.intQtdMDFPAG <= 0) Then
    Exit;

  intNumPro := manifesto.EventoPagamentoOperacaoTransporte.intNumeroProtocolo;

  stlTexto.Add(
    'MDFE-EVENTO-PGTO-OPER-TRANSP|'                                                               + // 01 - Tipo de Registro
    manifesto.strIdReferencia                                                               + '|' + // 02 - Id Referência
                                                                                              '|' + // 03 - Chave de Acesso
    IIF(intNumPro > 0, IntToStr(intNumPro), '')                                             + '|' + // 04 - Informar quando MDF-e não for autorizado por FIT DF-e
    fStrZero(IntToStr(manifesto.EventoPagamentoOperacaoTransporte.intQuantidadeViagens), 5) + '|' + // 05 - Quantidade total de viagens realizadas com o pagamento do Frete
    fStrZero(IntToStr(manifesto.EventoPagamentoOperacaoTransporte.intNumeroViagem), 5)      + '|'   // 06 - Número de referência da viagem do MDF-e referenciado
  );

  for intIndexPAG := 0 to manifesto.intQtdMDFPAG -1 do
  begin

    stlTexto.Add(
      'MDFE-EVENTO-PGTO-OPER-TRANSP-INF-PAG|'                                    + // 01 - Tipo de Registro
      manifesto.strIdReferencia                                            + '|' + // 02 - Id Referência
                                                                             '|' + // 03 - Chave de Acesso
      IntToStr(manifesto.MDFPAG[intIndexPAG].intSeqInfPagFrete)            + '|' + // 04 - Número do Item da Informação do Pagamento do Frete
      manifesto.MDFPAG[intIndexPAG].strNomeResponsavel                     + '|' + // 05 - Nome do responsável do pagamento
      manifesto.MDFPAG[intIndexPAG].strCPF_CNPJ                            + '|' + // 06 - CNPJ-CPF do responsável do pagamento (Quando não for estrangeiro)
      manifesto.MDFPAG[intIndexPAG].strIDEstrangeiro                       + '|' + // 07 - ID Estrangeiro
      fFormataValorFit(manifesto.MDFPAG[intIndexPAG].fltValorTotal, 15, 2) + '|' + // 08 - Valor total do contrato
      IntToStr(manifesto.MDFPAG[intIndexPAG].intFormaPagamento)            + '|' + // 09 - 0=à vista 1=à prazo
      manifesto.MDFPAG[intIndexPAG].strNumeroBanco                         + '|' + // 10 - Número do banco
      manifesto.MDFPAG[intIndexPAG].strNumeroAgencia                       + '|' + // 11 - Número da agência
      manifesto.MDFPAG[intIndexPAG].strCNPJPagamento                       + '|' + // 12 - CNPJ da instituição do pagamento
      manifesto.MDFPAG[intIndexPAG].strChavePix                            + '|' + // 13 - Chave PIX
      IIF(manifesto.MDFPAG[intIndexPAG].intFormaPagamento = 1,
      fFormataValorFit(manifesto.MDFPAG[intIndexPAG].fltValorAdiantam, 15, 2),
      '') + '|'                                                                    // 14 - Valor do Adiantamento
    );

    {Componentes}
    for intIndexCOM := 0 to manifesto.intQtdMDFCOM -1 do
    begin
      If (manifesto.MDFPAG[intIndexPAG].intSeqInfPagFrete = manifesto.MDFCOM[intIndexCOM].intSeqInfPagFrete) Then
      Begin

        stlTexto.Add(
          'MDFE-EVENTO-PGTO-OPER-TRANSP-INF-PAG-COMP|'                                    + // 01 - Tipo de Registro
          manifesto.strIdReferencia                                                 + '|' + // 02 - Id Referência
                                                                                      '|' + // 03 - Chave de Acesso
          IntToStr(manifesto.MDFCOM[intIndexCOM].intSeqInfPagFrete)                 + '|' + // 04 - Número do Item da Informação do Pagamento do Frete
          IntToStr(manifesto.MDFCOM[intIndexCOM].intSeqInfPagFreteCom)              + '|' + // 05 - Número do Item do Componente do Pagamento do Frete
          manifesto.MDFCOM[intIndexCOM].strTipoComponente                           + '|' + // 06 - Tipo do Componente
          fFormataValorFit(manifesto.MDFCOM[intIndexCOM].fltValorComponente, 15, 2) + '|' + // 07 - Valor do Componente
          manifesto.MDFCOM[intIndexCOM].strDescricaoComponente                      + '|'   // 08 - Descrição do Componente
        );

      End;
    end;

    {Prazos}
    for intIndexPRA := 0 to manifesto.intQtdMDFPRA -1 do
    begin

      If (manifesto.MDFPAG[intIndexPAG].intSeqInfPagFrete = manifesto.MDFPRA[intIndexPRA].intSeqInfPagFrete) Then
      Begin

        strParcela := '';
        If (manifesto.MDFPRA[intIndexPRA].intNumeroParcela > 0) Then
          strParcela := fStrZero(IntToStr(manifesto.MDFPRA[intIndexPRA].intNumeroParcela), 3);

        stlTexto.Add(
          'MDFE-EVENTO-PGTO-OPER-TRANSP-INF-PRAZO|'                                    + // 01 - Tipo de Registro
          manifesto.strIdReferencia                                              + '|' + // 02 - Id Referência
                                                                                   '|' + // 03 - Chave de Acesso
          IntToStr(manifesto.MDFPRA[intIndexPRA].intSeqInfPagFrete)              + '|' + // 04 - Número do Item da Informação do Pagamento do Frete
          IntToStr(manifesto.MDFPRA[intIndexPRA].intSeqInfPagFretePra)           + '|' + // 05 - Número do Item do Prazo do Pagamento do Frete
          strParcela                                                             + '|' + // 06 - Número de Parcela
          manifesto.MDFPRA[intIndexPRA].strDataVencimento                        + '|' + // 07 - Data de Vencimento da Parcela DDMMAAAA
          fFormataValorFit(manifesto.MDFPRA[intIndexPRA].fltValorParcela, 15, 2) + '|'   // 08 - Valor da Parcela
        );

      End;
    end;

  end;

end;

procedure TIntegracaoManifestoFit.pGeraMDFEInformacoesAdicionaisContribuinte(
  stlTexto: TStringList; manifesto: TManifestoEletronico);
  Var
    intIndex: Integer;
    intLinha: Integer;
begin
  intLinha := 1; {PRIMEIRA LINHA DA TAG}

  For intIndex := 0 To manifesto.intQtdeINFComplContrib -1 Do
  Begin
    stlTexto.Add(
    'MDFE-INF-ADIC-CONTRIB|'  +                                     // 01 - Tipo de Registro
    manifesto.strIdReferencia + '|' +                               // 02 - Id Referência
    intToStr(intLinha)        + '|' +                               // 03 - Nr Linha
    manifesto.InfComplementarContribuinte[intIndex].strInfCom + '|' // 04 - Informações Complementares
    );

    intLinha := intLinha + 1;
  End;

  {Inclusão das Notas no Campo de Observações - KM}
  If manifesto.intQtdeNfe > 0 Then
  Begin
    For intIndex := 0 To manifesto.intQtdeNfe -1 Do
    Begin
      stlTexto.Add(
      'MDFE-INF-ADIC-CONTRIB|'                +                     // 01 - Tipo de Registro
      manifesto.strIdReferencia               + '|' +               // 02 - Id Referência
      intToStr(intLinha)                      + '|' +               // 03 - Nr Linha (Ultima linha com informações + 1)
      manifesto.NFe[intIndex].strChaveAcesso  + '|'                 // 04 - Informações Complementares (Chave de acesso das notas)
      );

      intLinha := intLinha + 1;
    End;
  End;

end;

procedure TIntegracaoManifestoFit.pGeraMDFEInformacoesContratante(stlTexto: TStringList; manifesto: TManifestoEletronico);
var
  intIndex: Integer;
begin
  For intIndex := 0 To manifesto.intQtdInfContr -1 Do
  Begin
    stlTexto.Add(
      'MDFE-MODAL-RODOVIARIO-CONTRATANTE|' +               // 01 - Tipo de Registro
      manifesto.strIdReferencia + '|' +                    // 02 - Id Referência
      manifesto.Contratante[intIndex].strCnpjCpf + '|' +   // 03 - Obrigatório quando não for estrangeiro
      manifesto.Contratante[intIndex].strRazaoNome + '|' + // 04 -
      '|'                                                  // 05 - Identif icador do contratante em caso de contratante estrangeiro
    );
  End;
end;

procedure TIntegracaoManifestoFit.pGeraMDFEInformacoesPagamentoFrete(stlTexto: TStringList; manifesto: TManifestoEletronico);
var
  intIndexPAG,
  intIndexCOM,
  intIndexPRA : Integer;

  strParcela : String;

begin

  If (manifesto.intQtdMDFPAG <= 0) Then
    Exit;

  for intIndexPAG := 0 to manifesto.intQtdMDFPAG -1 do
  begin

    stlTexto.Add(
      'MDFE-MODAL-RODOVIARIO-INF-PAG|'                                           + // 01 - Tipo de Registro
      manifesto.strIdReferencia                                            + '|' + // 02 - Id Referência
      IntToStr(manifesto.MDFPAG[intIndexPAG].intSeqInfPagFrete)            + '|' + // 03 - Número do Item da Informação do Pagamento do Frete
      manifesto.MDFPAG[intIndexPAG].strNomeResponsavel                     + '|' + // 04 - Nome do responsável do pagamento
      manifesto.MDFPAG[intIndexPAG].strCPF_CNPJ                            + '|' + // 05 - CNPJ-CPF do responsável do pagamento (Quando não for estrangeiro)
      manifesto.MDFPAG[intIndexPAG].strIDEstrangeiro                       + '|' + // 06 - ID Estrangeiro
      fFormataValorFit(manifesto.MDFPAG[intIndexPAG].fltValorTotal, 15, 2) + '|' + // 07 - Valor total do contrato
      IntToStr(manifesto.MDFPAG[intIndexPAG].intFormaPagamento)            + '|' + // 08 - 0=à vista 1=à prazo
      manifesto.MDFPAG[intIndexPAG].strNumeroBanco                         + '|' + // 09 - Número do banco
      manifesto.MDFPAG[intIndexPAG].strNumeroAgencia                       + '|' + // 10 - Número da agência
      manifesto.MDFPAG[intIndexPAG].strCNPJPagamento                       + '|' + // 11 - CNPJ da instituição do pagamento
      manifesto.MDFPAG[intIndexPAG].strChavePix                            + '|' + // 12 - Chave PIX
                                                                             '|' + // 13 - Indicador de operação de transporte de alto desempenho
      IIF(manifesto.MDFPAG[intIndexPAG].intFormaPagamento = 1,
      fFormataValorFit(manifesto.MDFPAG[intIndexPAG].fltValorAdiantam, 15, 2),
      '') + '|'                                                                    // 14 - Valor do Adiantamento
    );

    {Componentes}
    for intIndexCOM := 0 to manifesto.intQtdMDFCOM -1 do
    begin
      If (manifesto.MDFPAG[intIndexPAG].intSeqInfPagFrete = manifesto.MDFCOM[intIndexCOM].intSeqInfPagFrete) Then
      Begin

        stlTexto.Add(
          'MDFE-MODAL-RODOVIARIO-INF-PAG-COMP|'                                           + // 01 - Tipo de Registro
          manifesto.strIdReferencia                                                 + '|' + // 02 - Id Referência
          IntToStr(manifesto.MDFCOM[intIndexCOM].intSeqInfPagFrete)                 + '|' + // 03 - Número do Item da Informação do Pagamento do Frete
          IntToStr(manifesto.MDFCOM[intIndexCOM].intSeqInfPagFreteCom)              + '|' + // 04 - Número do Item do Componente do Pagamento do Frete
          manifesto.MDFCOM[intIndexCOM].strTipoComponente                           + '|' + // 05 - Tipo do Componente
          fFormataValorFit(manifesto.MDFCOM[intIndexCOM].fltValorComponente, 15, 2) + '|' + // 06 - Valor do Componente
          manifesto.MDFCOM[intIndexCOM].strDescricaoComponente                      + '|'   // 07 - Descrição do Componente
        );

      End;
    end;

    {Prazos}
    for intIndexPRA := 0 to manifesto.intQtdMDFPRA -1 do
    begin

      If (manifesto.MDFPAG[intIndexPAG].intSeqInfPagFrete = manifesto.MDFPRA[intIndexPRA].intSeqInfPagFrete) Then
      Begin

        strParcela := '';
        If (manifesto.MDFPRA[intIndexPRA].intNumeroParcela > 0) Then
          strParcela := fStrZero(IntToStr(manifesto.MDFPRA[intIndexPRA].intNumeroParcela), 3);

        stlTexto.Add(
          'MDFE-MODAL-RODOVIARIO-INF-PAG-PRAZO|'                                       + // 01 - Tipo de Registro
          manifesto.strIdReferencia                                              + '|' + // 02 - Id Referência
          IntToStr(manifesto.MDFPRA[intIndexPRA].intSeqInfPagFrete)              + '|' + // 03 - Número do Item da Informação do Pagamento do Frete
          IntToStr(manifesto.MDFPRA[intIndexPRA].intSeqInfPagFretePra)           + '|' + // 04 - Número do Item do Prazo do Pagamento do Frete
          strParcela                                                             + '|' + // 05 - Número de Parcela
          manifesto.MDFPRA[intIndexPRA].strDataVencimento                        + '|' + // 06 - Data de Vencimento da Parcela DDMMAAAA
          fFormataValorFit(manifesto.MDFPRA[intIndexPRA].fltValorParcela, 15, 2) + '|'   // 07 - Valor da Parcela
        );

      End;
    end;

  end;

end;

procedure TIntegracaoManifestoFit.pGeraMDFEModalRodoviario(stlTexto: TStringList; manifesto: TManifestoEletronico);
Var
  strCPF_CNPJ,
  strRNTRC,
  strNomeRazaoSocial,
  strInscricaoEstadual,
  strEstado,
  strTipoProprietario,
  strTaraKg,
  strTipoRodado,
  strTipoCarroceria : String;
begin
  If Not fEmptyStr(manifesto.ProprietarioVeiculo.strNomeRazaoSocial) Then
  Begin
    strCPF_CNPJ          := manifesto.ProprietarioVeiculo.strCPF_CNPJ;
    strRNTRC             := manifesto.ProprietarioVeiculo.strRNTRC;
    strNomeRazaoSocial   := manifesto.ProprietarioVeiculo.strNomeRazaoSocial;
    strInscricaoEstadual := manifesto.ProprietarioVeiculo.strInscricaoEstadual;
    strEstado            := manifesto.ProprietarioVeiculo.strEstado;
    strTipoProprietario  := IntToStr(manifesto.ProprietarioVeiculo.intTipoProprietario);
  End
  Else Begin
    strCPF_CNPJ          := '';
    strRNTRC             := '';
    strNomeRazaoSocial   := '';
    strInscricaoEstadual := '';
    strEstado            := '';
    strTipoProprietario  := '';
  End;

  if Assigned(manifesto.DadosVeiculo) then
  begin
    strTaraKg := IntToStr(manifesto.DadosVeiculo.intTaraKg) + '|';
    strTipoRodado := manifesto.DadosVeiculo.strTipoRodado + '|';
    strTipoCarroceria := manifesto.DadosVeiculo.strTipoCarroceria + '|';
  end
  else
  begin
    strTaraKg := '0|';
    strTipoRodado := '06|';
    strTipoCarroceria := '02|';
  end;

  stlTexto.Add(
    'MDFE-MODAL-RODOVIARIO|' +                                                       // 01 - Tipo de Registro
    manifesto.strIdReferencia + '|' +                                                // 02 - Id Referência
    '|' +                                                                            // 03 - RNTC
    '|' +                                                                            // 04 - CIOT
    manifesto.strPlacaVeiculo + '|' +                                                // 05 - Código interno do Veículo com a Tração
    manifesto.strPlacaVeiculo + '|' +                                                // 06 - Placa do veículo com a Tração
    strTaraKg +                                                                      // 07 - Tara em KG
    '0|' +                                                                           // 08 - Capacidade em KG
    '0|' +                                                                           // 09 - Capacidade em M3
    strTipoRodado +                                                                  // 10 - Tipo de Rodado - 06 - Outros, ver layout
    strTipoCarroceria +                                                              // 11 - Tipo de Carroceria - 02 - Fechada / Baú, ver layout
    manifesto.strUfEmitente + '|' +                                                  // 12 - UF de licenciamento do Veículo

    //13 - CPF / CNPJ PROPRIETARIO
    IIF(Not fEmptyStr(strCPF_CNPJ), strCPF_CNPJ, '') + '|' +

    //14 - RNTC
    IIF(Not fEmptyStr(strRNTRC), strRNTRC, '') + '|' +

    //15 - Nome ou Razão Social do Proprietário
    IIF(Not fEmptyStr(strNomeRazaoSocial), strNomeRazaoSocial, '') + '|' +

    //16 - IE
    IIF(Not fEmptyStr(strInscricaoEstadual), strInscricaoEstadual, '') + '|' +

    //17 - UF
    IIF(Not fEmptyStr(strEstado), strEstado, '') + '|' +

    //18 - Tipo do proprietário
    IIF(Not fEmptyStr(strTipoProprietario), strTipoProprietario, '') + '|' +

    '|' + // 19 - RENAVAM do veículo (Campo referente a Veículo com a Tração)
    '|' + // 20 - Código de Agendamento no porto
    '|'   // 21 - Categoria de Combinação Veicular
  );
end;

procedure TIntegracaoManifestoFit.pGeraMDFEModalRodoviarioReboque(stlTexto: TStringList; manifesto: TManifestoEletronico);
Var
  strCPF_CNPJ,
  strRNTRC,
  strNomeRazaoSocial,
  strInscricaoEstadual,
  strEstado,
  strTipoProprietario : String;

  procedure pAdicionaReboque(strPlaca: String; intTaraKg, intCapacidadeKG: Integer; strTipoCarroceria: String);
  begin
    stlTexto.Add(
      'MDFE-MODAL-RODOVIARIO-REBOQUE|' +                                         // 01 - Tipo de Registro
      manifesto.strIdReferencia + '|' +                                          // 02 - Id Referência
      '|' +                                                                      // 03 - Código interno do Reboque
      strPlaca + '|' +                                                           // 04 - Placa do Reboque
      IntToStr(intTaraKg) + '|' +                                                // 05 - Tara em KG
      IntToStr(intCapacidadeKG) + '|' +                                          // 06 - Capacidade em KG
      '0|' +                                                                     // 07 - Capacidade em M3
      strTipoCarroceria + '|' +                                                  // 08 - Tipo de Carroceria - 02 - Fechada / Baú, ver layout
      '|' +                                                                      // 09 - UF de licenciamento do Veículo
      IIF(Not fEmptyStr(strCPF_CNPJ), strCPF_CNPJ, '') + '|' +                   // 10 - CPF / CNPJ PROPRIETARIO
      IIF(Not fEmptyStr(strRNTRC), strRNTRC, '') + '|' +                         // 11 - RNTC
      IIF(Not fEmptyStr(strNomeRazaoSocial), strNomeRazaoSocial, '') + '|' +     // 12 - Nome ou Razão Social do Proprietário
      IIF(Not fEmptyStr(strInscricaoEstadual), strInscricaoEstadual, '') + '|' + // 13 - IE
      IIF(Not fEmptyStr(strEstado), strEstado, '') + '|' +                       // 14 - UF
      IIF(Not fEmptyStr(strTipoProprietario), strTipoProprietario, '') + '|' +   // 15 - Tipo do proprietário
      '|'                                                                        // 16 - RENAVAM do veículo (Campo referente a Veículo com a Tração)
    );
  end;

begin
  if not Assigned(manifesto.DadosReboque1) then
    Exit;

  If Not fEmptyStr(manifesto.ProprietarioVeiculo.strNomeRazaoSocial) Then
  Begin
    strCPF_CNPJ          := manifesto.ProprietarioVeiculo.strCPF_CNPJ;
    strRNTRC             := manifesto.ProprietarioVeiculo.strRNTRC;
    strNomeRazaoSocial   := manifesto.ProprietarioVeiculo.strNomeRazaoSocial;
    strInscricaoEstadual := manifesto.ProprietarioVeiculo.strInscricaoEstadual;
    strEstado            := manifesto.ProprietarioVeiculo.strEstado;
    strTipoProprietario  := IntToStr(manifesto.ProprietarioVeiculo.intTipoProprietario);
  End
  Else Begin
    strCPF_CNPJ          := '';
    strRNTRC             := '';
    strNomeRazaoSocial   := '';
    strInscricaoEstadual := '';
    strEstado            := '';
    strTipoProprietario  := '';
  End;

  pAdicionaReboque(manifesto.DadosReboque1.strPlaca,
                   manifesto.DadosReboque1.intTaraKg,
                   manifesto.DadosReboque1.intCapacidadeKG,
                   manifesto.DadosReboque1.strTipoCarroceria);

  If Assigned(manifesto.DadosReboque2) Then
  Begin
    If not fEmptyStr(manifesto.DadosReboque2.strPlaca) Then
      pAdicionaReboque(manifesto.DadosReboque2.strPlaca,
                       manifesto.DadosReboque2.intTaraKg,
                       manifesto.DadosReboque2.intCapacidadeKG,
                       manifesto.DadosReboque2.strTipoCarroceria);
  End;

  If Assigned(manifesto.DadosReboque3) Then
  Begin
    If not fEmptyStr(manifesto.DadosReboque3.strPlaca) Then
      pAdicionaReboque(manifesto.DadosReboque3.strPlaca,
                       manifesto.DadosReboque3.intTaraKg,
                       manifesto.DadosReboque3.intCapacidadeKG,
                       manifesto.DadosReboque3.strTipoCarroceria);
  End;

end;

procedure TIntegracaoManifestoFit.pGeraMDFENFe(stlTexto  : TStringList;
                                               manifesto : TManifestoEletronico);
Var
  intIndex       : Integer;
  strCodigoIbge  : String;
  strChaveAcesso : String;
begin

  For intIndex := 0 To manifesto.intQtdeNfe -1 Do
  Begin

    pDefinirCodigos(intIndex, manifesto, strCodigoIbge, strChaveAcesso);

    stlTexto.Add(
      'MDFE-NFE|' +                       // 01 - Tipo de Registro
      manifesto.strIdReferencia + '|' +   // 02 - Id Referência
      IntToStr(intIndex) + '|' +          // 03 - Nr. Item
      strCodigoIbge + '|' +               // 04 - Código IBGE do Municipio
      strChaveAcesso +                    // 05 - Chave de Acesso NF-e
      '|'+IIF(blnManifesto300a, '|', '')  // 06 - Segundo código de barras + 07 - Indicador de Reentrega
    );
  End;

end;

procedure TIntegracaoManifestoFit.pGeraMDFEPercurso(stlTexto: TStringList;
  manifesto: TManifestoEletronico);
  Var
    stlUFs: TStringList;
    intContador: Integer;
    strUF: String;
    strPercurso: String;
begin
  strPercurso := '';
  if (manifesto.intQtdeNfe > 0) then
    strPercurso := manifesto.NFe[0].strPercurso
  else if (manifesto.intQtdeCte > 0) then
    strPercurso := manifesto.CTe[0].strPercurso;

  stlUFs := TStringList.Create;
  ExtractStrings([','], [], PChar(strPercurso), stlUFs);

  For intContador := 0 To stlUFs.Count -1 Do
  Begin
    strUF := Trim(stlUFs[intContador]);
    stlTexto.Add(
      'MDFE-PERCURSO|' +                                         // 01 - Tipo de Registro
      manifesto.strIdReferencia + '|' +                          // 02 - Id Referência
      strUF + '|'                                                // 03 - UF
    );
  End;
end;

procedure TIntegracaoManifestoFit.pGeraMDFEProdutoPredominante(stlTexto: TStringList; manifesto: TManifestoEletronico);
begin

  If fEmptyStr(manifesto.ProdutoPredominante.strDescricaoProdutoPredominante) Then
    Exit;

  stlTexto.Add(
    'MDFE-PROD-PRED|'                                                          + // 01 - Tipo de Registro
    manifesto.strIdReferencia                                            + '|' + // 02 - Id Referência
    manifesto.ProdutoPredominante.strTipoDeCarga                         + '|' + // 03 - Tipo de Carga
    manifesto.ProdutoPredominante.strDescricaoProdutoPredominante        + '|' + // 04 - Descrição do Produto Predominante
    manifesto.ProdutoPredominante.strCEAN_GTIN                           + '|' + // 05 - GTIN (Global Trade Item Number)
    manifesto.ProdutoPredominante.strNCM                                 + '|' + // 06 - Código NCM
    manifesto.ProdutoPredominante.strCEPLocalizacaoCarregamento          + '|' + // 07 - CEP onde foi carregado o MDF-e
    manifesto.ProdutoPredominante.strLatitudeLocalizacaoCarregamento     + '|' + // 08 - Latitude do ponto geográfico onde foi carregado o MDF-e
    manifesto.ProdutoPredominante.strLongitudeLocalizacaoCarregamento    + '|' + // 09 - Longitude do ponto geográfico onde foi carregado o MDF-e
    manifesto.ProdutoPredominante.strCEPLocalizacaoDescarregamento       + '|' + // 10 - CEP onde foi carregado o MDF-e
    manifesto.ProdutoPredominante.strLatitudeLocalizacaoDescarregamento  + '|' + // 11 - Latitude do ponto geográfico onde foi descarregado o MDF-e
    manifesto.ProdutoPredominante.strLongitudeLocalizacaoDescarregamento + '|'   // 12 - Longitude do ponto geográfico onde foi descarregado o MDF-e
  );
end;

procedure TIntegracaoManifestoFit.pGeraMDFESeguroDaCarga(stlTexto: TStringList;
  manifesto: TManifestoEletronico);
  Var
    intIndex: Integer;
begin
  { hoje o tipo de emitente é fixo = "2" no sistema:

  1 – Prestador de serviço de transporte
  2 – Transportador de Carga Própria
  3 - Prestador de serviço de transporte que
  emitirá CT-e Globalizado

  OBS: Deve ser preenchido com 2 para emitentes
  de NF-e e pelas transportadoras quando
  estiverem fazendo transporte de carga própria
  }

  For intIndex := 0 To manifesto.intQtdeSegCar -1 Do
  Begin
    stlTexto.Add(
      'MDFE-SEGURO|' +                                             // 01 - Tipo de Registro
      manifesto.strIdReferencia + '|' +                            // 02 - Id Referência
      IntToStr(intIndex) + '|' +                                   // 03 - Sequencial
      IntToStr(manifesto.SeguroCarga[intIndex].intResSeg) + '|' +  // 04 - Responsável pelo Seguro (1- Emitente do MDF-e; 2 - Responsável pela contratação do serviço)
      manifesto.SeguroCarga[intIndex].strResCpf + '|' +            // 05 - CPF/CNPJ do Responsável (obrigatório se o tipo de emitente for 1 ou 3)

      // obrigatório se o tipo de emitente for 1 ou 3
      manifesto.SeguroCarga[intIndex].strNomSeg + '|' +            // 06 - Nome da Seguradora
      manifesto.SeguroCarga[intIndex].strSegCnp + '|' +            // 07 - Número do CNPJ da Seguradora - Obrigatório apenas se responsável pelo seguro for (2) responsável pela contratação do transporte – pessoa jurídica
      manifesto.SeguroCarga[intIndex].strNumApo + '|'              // 08 - Número da Apolice
    );
  End;
end;

procedure TIntegracaoManifestoFit.pGeraMDFESeguroDaCargaAverbacao(
  stlTexto: TStringList; manifesto: TManifestoEletronico);
  Var
    intIndex: Integer;
begin
  // obrigatório se o tipo de emitente for 1 ou 3
  For intIndex := 0 To manifesto.intQtdeSegCarAverb -1 Do
  Begin
    stlTexto.Add(
      'MDFE-SEGURO-AVERBACAO|' +                                 // 01 - Tipo de Registro
      manifesto.strIdReferencia + '|' +                          // 02 - Id Referência
      IntToStr(intIndex) + '|' +                                 // 03 - Sequencial
      manifesto.SeguroCargaAverbacao[intIndex].strNumAve + '|'   // 04 - Número da Averbação
    );
  End;
end;

procedure TIntegracaoManifestoFit.pGeraMDFETotal(stlTexto: TStringList;
  manifesto: TManifestoEletronico);
  Var
    strQtdeNfe: string;
    strQtdeCte: string;
begin
  if manifesto.strCargaPosterior = 'S' then
  begin
    strQtdeNfe := '0|';                                                     // 05 - Quantidade de NF-e
    strQtdeCte := '0|';                                                     // 05 - Quantidade de CT-e
  end
  else
  begin
    strQtdeNfe := IntToStr(manifesto.intQtdeNfe) + '|';                     // 05 - Quantidade de NF-e
    strQtdeCte := IntToStr(manifesto.intQtdeCte) + '|';                     // 05 - Quantidade de CT-e
  end;

  stlTexto.Add(
    'MDFE-TOTAL|' +                                            // 01 - Tipo de Registro
    manifesto.strIdReferencia + '|' +                          // 02 - Id Referência
    strQtdeCte +                                               // 03 - Quantidade de CT-e
    '|' +                                                      // 04 - Quantidade de CT
    strQtdeNfe +                                               // 05 - Quantidade de NF-e
    '|' +                                                      // 06 - Quantidade de NF
    '0|' +                                                     // 07 - Quantidade de MDF-e relacionadas no manifesto aquaviario
    fFormataValorFit(manifesto.fltTotalCarga, 13, 2) + '|' +   // 08 - Valor Total da Carga / Mercadorias Transportadas
    '01|' +                                                    // 09 - Código da Unidade do Peso Bruto (01 - KG, 02 - TON)
    fFormataValorFit(manifesto.fltPesoBrutoTotal, 11, 4) + '|' // 10 - Peso Bruto Total da Carga / Merca
  );
end;

procedure TIntegracaoManifestoFit.pGeraMDFETrailler(stlTexto: TStringList);
begin
  stlTexto.Add('TRAILLER|' + IntToStr(stlTexto.Count+1));
end;

procedure TIntegracaoManifestoFit.pImprimirManifesto(
  manifesto: TManifestoEletronico; strImpressora: String);
  Var
    metodoImpressao: IMetodoImpressao;
begin
  metodoImpressao := TMetodoImpressaoFactory.fCriarManifesto;

  fitWrapper.fDownloadDanfe('', manifesto.strNumeroManifesto,
    strImpressora, metodoImpressao, 1, IntToStr(StrToInt64(manifesto.strIdReferencia)), nil, nil, False, 0, '',
    IIF(objConfig.blnNfiMdf, tiNfeImpressao, tiPadrao), manifesto.strCodigoEmpresa);
end;

function TIntegracaoManifestoFit.fFormataValorFit(fltValor: Double;
  intPrecisao, intDecimais: Integer): String;
begin
  Result := FloatToStrF(fltValor, ffNumber, intPrecisao, intDecimais);
  Result := AnsiReplaceStr(Result, ',', '');
  Result := AnsiReplaceStr(Result, '.', '');
end;

function TIntegracaoManifestoFit.fProcessarManifesto(manifesto: TManifestoEletronico): TRetornoNFE;
begin
  Result := fProcessarManifesto(manifesto, objConfig.strFitImpressoraPadrao);
end;

function TIntegracaoManifestoFit.fProcessarManifesto(manifesto: TManifestoEletronico; strImpressora: String): TRetornoNFE;
  Var
    retornoFit: TWSNfeFitRetorno;
begin
  retornoFit := fitWrapper.fConsultaSituacaoIdManifesto(manifesto.strIdReferencia);

  Result := fGeraRetornoNfeManifesto(retornoFit);

  If Result.Sucesso Then
  Begin
    pImprimirManifesto(manifesto, IIF(fEmptyStr(strImpressora), objConfig.strFitImpressoraPadrao, strImpressora));
  End;

  If Assigned(retornoFit) Then
    FreeAndNil(retornoFit);
end;

function TIntegracaoManifestoFit.fGeraRetornoNfeManifesto(retornoFit: TWSNfeFitRetorno): TRetornoNFE;
  Var
    intStatus: Integer;
    strMsg: String;
    strAcesso: String;
    stlRet: TStringList;
begin
  stlRet := TStringList.Create;
  Try
    stlRet.Add(retornoFit.Texto);
    Try
      stlRet.SaveToFile(fPnlDir('ULTIMO_RETORNO_MDFE.TXT'));
    Except

    End;
  Finally
    FreeAndNil(stlRet);
  End;

  If (Pos('não encontrado', LowerCase(retornoFit.Texto)) > 0) Then
  Begin
    Result := TRetornoNFE.fCriaRetornoErro(retornoFit.Texto);
    Exit;
  End;

  If (Pos('[erro] evento encerramento mdfe', LowerCase(retornoFit.Texto)) > 0) Then
  Begin
    Result := TRetornoNFE.fCriaRetornoErro(retornoFit.Texto);
    Exit;
  End;

  If ((Pos('evento registrado e vinculado ao mdf-e(encerramento)', LowerCase(retornoFit.Texto)) > 0) Or
      (Pos('mdf-e já está encerrado na base de dados da sefaz', LowerCase(retornoFit.Texto)) > 0)) Then
  Begin
    strAcesso             := fGetValorLinha(retornoFit.Texto, '|', 3);
    strMsg                := fGetValorLinha(retornoFit.Texto, '|', 5);
    strProtocoloManifesto := fGetValorLinha(retornoFit.Texto, '|', 6);
    strModeloManifesto    := '58';
    strDataHoraManifesto  := fGetValorLinha(retornoFit.Texto, '|', 7);

    Result := TRetornoNFE.fCriaRetornoEncerrada(strMsg, strAcesso, '', nOw());
    Result := TRetornoNFE.fCriaRetornoManifesto(Result, strProtocoloManifesto, strModeloManifesto, strDataHoraManifesto);

    Exit;
  End;

  strMsg := fGetValorLinha(retornoFit.Texto, '|', 11);

  If Not retornoFit.RetornoOk Then
  Begin
    Result := TRetornoNFE.fCriaRetornoErro(strMsg)
  End
  Else
  Begin
    intStatus := StrToIntDef(fGetValorLinha(retornoFit.Texto, '|', 9), 0);
    strAcesso := fGetValorLinha(retornoFit.Texto, '|', 7);

    strProtocoloManifesto := fGetValorLinha(retornoFit.Texto, '|', 12);
    strModeloManifesto    := fGetValorLinha(retornoFit.Texto, '|', 5);
    strDataHoraManifesto  := fGetValorLinha(retornoFit.Texto, '|', 13);

    If (intStatus In [0,1,2,3]) Or (intStatus = 1102) Or (intStatus = 1101) Or (Pos('em processamento', LowerCase(strMsg)) > 0) Then
      Result := TRetornoNFE.fCriaRetornoAguardando
    Else If intStatus = 4 Then
      Result := TRetornoNFE.fCriaRetornoErro(strMsg)
    Else If intStatus = 7 Then
    Begin
      Result := TRetornoNFE.fCriaRetornoEncerrada(strMsg, strAcesso, '', nOw());
      Result := TRetornoNFE.fCriaRetornoManifesto(Result, strProtocoloManifesto, strModeloManifesto, strDataHoraManifesto);
    End
    Else If intStatus = 8 Then
    Begin
      Result := TRetornoNFE.fCriaRetornoCancelada('')
    End
    Else
    Begin
      Result := TRetornoNFE.fCriaRetornoSucesso(strMsg, strAcesso, '', nOw());
      Result := TRetornoNFE.fCriaRetornoManifesto(Result, strProtocoloManifesto, strModeloManifesto, strDataHoraManifesto);
    End;
  End;
end;

function TIntegracaoManifestoFit.fGetTipoTransportador(const manifesto: TManifestoEletronico): string;
begin
  Result := '';

  if (manifesto.strTipoDocumento = 'CTe') and (Not fEmptyStr(manifesto.ProprietarioVeiculo.strNomeRazaoSocial)) then
  begin
    Result := '1'; {16 - Tipo do Transportador 1-ETC 2-TAC 3-CTC}
    Exit;
  end;

  If (Not fEmptyStr(manifesto.ProprietarioVeiculo.strNomeRazaoSocial)) Then
  begin
    {************************************************************************************************}
    {* TipoProprietario 0 = TAC AGREGADO, 1 = TAC INDEPENDENTE, 2 -OUTROS                           *}
    {* ETC = EMPRESA QUE DISPÕEM DO VEÍCULO E AGREGA O CONDUTOR(AMARRADO AO TAC AGREGADO OU OUTROS) *}
    {* CTC = UNIÕES DE CONDUTORES QUE OPERAM NO MERCADO DE TRANSPORTES(AMARRADO AO TAC INDEPENDENTE)*}
    {*********************************************************************************************BL*}
    if Length(manifesto.ProprietarioVeiculo.strCPF_CNPJ) > 11 then
       Result := IIF(manifesto.ProprietarioVeiculo.intTipoProprietario = 1, '3', '1'){16 - Tipo do Transportador 1-ETC 2-TAC 3-CTC}
    else
      Result := '2'; {16 - Tipo do Transportador 1-ETC 2-TAC 3-CTC}

    Exit;
  end;
end;

end.
