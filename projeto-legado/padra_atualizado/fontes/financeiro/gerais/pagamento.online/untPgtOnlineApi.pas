unit untPgtOnlineApi;

interface

uses
  Vcl.Forms, IdHTTP, IdURI, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack,
  IdSSL, IdSSLOpenSSL, REST.Client, Rest.Types, IpPeerClient, System.SysUtils,
  untFuncoesSimples, System.StrUtils, Uni, untLinkPagamentoCitelModel,
  untLinkPagamentoCitelEnvio,  untInterfaceLinkPagamentoCitel, untFuncoes,
  untTypesSistema;

type
  TArrayAutoIncAgrupado = Array of String ;

  TPagamentoOnline = class
    private
      FNumDoc : String;
      FEspDoc : String;
      FCodCli : String;
      FCodOpe : String;
      FCodEmp : String;
      FSeqFgo : String;
      FarrAutInc : TArrayAutoIncAgrupado;
      FstrTipLan : String;
      FarrDupAgr: Array Of TDuplicatasAgrupadas;

      objLinkPagamentoCitelEnvio : TLinkPagamentoCitelEnvio;
      objLinkPagamentoCitelModel : TLinkPagamentoCitelModel;

      procedure pGerarLinkPagamentoCitel(strOperacao : String;
                                         intQtdParcelas : Integer;
                                         intTipoParcelamento : Integer;
                                         fltValor : Double;
                                         const strLinkPgtFormaEnvio, strLinkPgtDestinatario: String);

      procedure pClassificaTipoDocumento(var ArecInfoDoc: TInfoDocumentoLinkPagamentoCitel) ;
      function fDocumentoPagamentoLinkPagamentoCitel : Boolean;
      function fArrAutoIncsToString: String ;
      procedure pArrAutoIncsToArrayAgrupado ;
      function fArrayAgrupadoToDocString: String ;
    public
      procedure pGerarLinkPagamento(strOperacao : String;
                                   intQtdParcelas : Integer;
                                   intTipoParcelamento : Integer;
                                   fltValor : Double;
                                   const strLinkPgtFormaEnvio, strLinkPgtDestinatario: String);

      function fEnviarEmail(strUrl, strEmailCli : String) : Boolean;
      function fEnviarEmailAgrupamentoAGR(const AstrUrl, AstrEmailCli : String) : Boolean;

      function fDocumentoPagamentoOnline : Boolean;
      function fGerarArquivosAGR(var AarrDestinatarios, AarrArquivos: TStringArray; const AstrEmailCli: String): String ;

      constructor Create;
      destructor Destroy; override;

      property strNumDoc : String read FNumDoc write FNumDoc;
      property strEspDoc : String read FEspDoc write FEspDoc;
      property strCodCli : String read FCodCli write FCodCli;
      property strCodOpe : String read FCodOpe write FCodOpe;
      property strCodEmp : String read FCodEmp write FCodEmp;
      property strSeqFgo : String read FSeqFgo write FSeqFgo;
      property arrAutInc : TArrayAutoIncAgrupado read FarrAutInc write FarrAutInc;
      property strTipLan : String read FstrTipLan write FstrTipLan;
  end;

  TValidacoesPagamentoOnline = class
  public
    class function fAgrupamentoPossuiLinkPagamento(const AstrNumDup, AstrEspDoc, AstrCodEmp, AstrCodCli : String): Boolean;
  end ;

implementation

uses
  untFatGorEmail, untTEnvioEmail,
  {$IFNDEF LINUX}
  untFuncFat,
  {$ENDIF}
  untLinkPagamentoCitelRepositorio, untLinkPagamentoCitelUtil, untPgtOnlineUtil,
  untLinkPagamentoCitelStatus, untClassesComumLinkPagamentoCitel, DateUtils,
  Classes, untCtrAgrupDupRecibo, untFuncoesComumLinkPagamentoCitel ;

{ TPagamentoOnline }

constructor TPagamentoOnline.Create;
begin
  objLinkPagamentoCitelEnvio := TLinkPagamentoCitelEnvio.Create;
  objLinkPagamentoCitelModel := TLinkPagamentoCitelModel.Create;
  FstrTipLan := 'PD' ;
  SetLength(FarrAutInc, 0);
  SetLength(FarrDupAgr, 0);
  FSeqFgo := '' ;
end;

destructor TPagamentoOnline.Destroy;
begin
  FreeAndNil(objLinkPagamentoCitelEnvio);
  FreeAndNil(objLinkPagamentoCitelModel);
  inherited;
end;

function TPagamentoOnline.fDocumentoPagamentoOnline : Boolean;
begin
  Result := fDocumentoPagamentoLinkPagamentoCitel;
end;

procedure TPagamentoOnline.pGerarLinkPagamentoCitel(strOperacao : String;
                                                     intQtdParcelas : Integer;
                                                     intTipoParcelamento : Integer;
                                                     fltValor : Double;
                                                     const strLinkPgtFormaEnvio, strLinkPgtDestinatario: String);
  var
    blnGravou : Boolean;
    LstrRetornoMsgErro : String;
    LstrRetornoMsg : String;
    LobjResposta: TGerarLinkPagamentoResposta;
    LrecInfoDoc: TInfoDocumentoLinkPagamentoCitel ;
    LdtaExpiracao: TDateTime ;
    LstrAutoIncs : String;
    LDiasExpiracao: Integer;
begin
  pClassificaTipoDocumento(LrecInfoDoc) ;
  LDiasExpiracao := fRetornaDiasExpiracaoLink();
  LdtaExpiracao := IncDay(fNow, LDiasExpiracao) ;
  LstrAutoIncs := '' ;

  LobjResposta := objLinkPagamentoCitelEnvio.fGerarLinkPagamento(strOperacao,
                                                               intQtdParcelas,
                                                               IntToStr(intTipoParcelamento),
                                                               fltValor,
                                                               LstrRetornoMsgErro,
                                                               LrecInfoDoc,
                                                               LdtaExpiracao);

  if not Assigned(LobjResposta) then
  begin
    fMensagem('ATENÇÃO!', LstrRetornoMsgErro, ['&Ok']);
    Exit;
  end;

  try
    LstrAutoIncs := fArrAutoIncsToString ;
    blnGravou := objLinkPagamentoCitelEnvio.fCriarNovaTransacao(strCodEmp,
                                                    LobjResposta.url,
                                                    LobjResposta.IdLink,
                                                    LobjResposta.nsu,
                                                    strCodOpe,
                                                    Date,
                                                    fTime(),
                                                    fltValor,
                                                    strSeqFgo,
                                                    intQtdParcelas,
                                                    FstrTipLan,
                                                    LstrAutoIncs,
                                                    TLinkPagamentoCitelRepositorio.fGetMerchantId,
                                                    LdtaExpiracao);

    if not blnGravou then
    begin
      fMensagem('ATENÇÃO!', 'Erro na gravação do link de pagamento.' + #13#10 + 'Entre em contato com o Suporte Citel!', ['&Ok']);
      Exit;
    end;

    LstrRetornoMsg := '' ;
    if fNotificaCliente(LobjResposta.Url,
                        LstrRetornoMsg,
                        FNumDoc,
                        FEspDoc,
                        FCodEmp,
                        FCodCli,
                        strLinkPgtFormaEnvio,
                        strLinkPgtDestinatario,
                        FstrTipLan,
                        FarrAutInc) then
    begin

      objLinkPagamentoCitelModel.pAtualizaFormaEnvio(LobjResposta.IdLink,
                                              TLinkPagamentoCitelRepositorio.fGetMerchantId,
                                              strLinkPgtFormaEnvio);

      fMensagem('ATENÇÃO!', LstrRetornoMsg, ['&Ok']) ;
    end
    else
    begin
      // So grava ENE em link ainda NOV: o envio pode ter aguardado o operador e,
      // nesse meio-tempo, o robo ja ter gravado o pagamento (CON). Req. 466218
      objLinkPagamentoCitelModel.pAtualizaStatus(LobjResposta.IdLink,
                                          TLinkPagamentoCitelRepositorio.fGetMerchantId,
                                          strCodEmp,
                                          stTransacaoRecenteEmailNaoEnviado,
                                          stTransacaoRecente);
      fMensagem('ATENÇÃO!', IfThen(fEmptyStr(LstrRetornoMsg), 'Notificação do link de pagamento não enviada!'+#13+'Faça o reenvio em "> Útil > Links para Pagamento Online - Manutenção"', LstrRetornoMsg), ['&Ok']);
    end ;
  finally
    FreeAndNil(LobjResposta);
  end;
end;

function TPagamentoOnline.fArrAutoIncsToString: String;
var
  LintCnt: Integer ;
begin
  Result := '' ;
  for LintCnt := Low(FarrAutInc) to High(FarrAutInc) do
  begin
    if Trim(Result) = '' then
      Result := FarrAutInc[LintCnt]
    else
      Result := Result + ';' + FarrAutInc[LintCnt] ;
  end ;
end;

function TPagamentoOnline.fArrayAgrupadoToDocString: String;
var
  LintCnt: Integer ;
begin
  Result := '' ;
  for LintCnt := Low(FarrDupAgr) to High(FarrDupAgr) do
  begin
    Result := Result +  IfThen(Trim(Result) = '', ', ' + FarrDupAgr[LintCnt].strEmpAgr, FarrDupAgr[LintCnt].strEmpAgr) ;
  end ;
end;

function TPagamentoOnline.fDocumentoPagamentoLinkPagamentoCitel: Boolean;
begin
  Result := TLinkPagamentoCitelClass.fDocumentoLinkPagamentoCitel(FNumDoc, FEspDoc, FCodEmp, FCodCli, FstrTipLan);
end;

function TPagamentoOnline.fEnviarEmail(strUrl, strEmailCli : String) : Boolean;
Var
  arrDestinatarios, arrArquivos: TStringArray;
  strTexto, strAssunto, strArqHtml : String;
begin
  If fUsaLinkPagamentoEmaSaiCielo Then
  Begin
    Result := fDisparaEmailAutomatico(FNumDoc,
                                      'CB',
                                      FEspDoc,
                                      '',
                                      '',
                                      FCodEmp,
                                      FCodCli,
                                      '',
                                      '',
                                      TGeraArquivoAnexoEmailAutomatico.New(FNumDoc,
                                                                           FEspDoc,
                                                                           FCodEmp,
                                                                           FCodCli,
                                                                           False,
                                                                           'PD'),
                                      '',
                                      '',
                                      '',
                                      '',
                                      ''
                                      );
    exit ;
  End;


  strTexto := strTexto + 'Segue o link para pagamento online do(s) pedido(s) nº('+FNumDoc+')' + sLineBreak + strUrl;

  strAssunto := fRetNomeEmpresa + ' - ' + 'Link para Pagamento Online';

  pCriarFormularios(TfrmFatGorEmail, frmFatGorEmail);
  strArqHtml := '';
  strArqHtml := strArqHtml + IIf(fEmptyStr(strArqHtml) , '', ',') +
                             frmFatGorEmail.fGeraEmail(FNumDoc,
                                                       FEspDoc,
                                                       impComPrecoGeral,
                                                       True,
                                                       'P',
                                                       'R',
                                                       '1',
                                                       FCodEmp,
                                                       False,
                                                       'R',
                                                       FCodCli,
                                                       False);

  pCriarArrayAnexosEDestinatarios(strArqHtml, strEmailCli, arrDestinatarios, arrArquivos);
  Result := TEnvioEmail.EnviarEmail(Application.GetParentComponent(),
                                    strLoginUsuarioLogado,
                                    strAssunto,
                                    arrDestinatarios,
                                    [],
                                    [],
                                    TEnvioEmail.ContruirArrayMensagem(strTexto),
                                    arrArquivos,
                                    false,
                                    false,
                                    '',
                                    '',
                                    0,
                                    false,
                                    '',
                                    '',
                                    '',
                                    '',
                                    0,
                                    0,
                                    0,
                                    '',
                                    '',
                                    0,
                                    false,
                                    '',
                                    nil,
                                    '',
                                    '',
                                    false,
                                    false,
                                    'S',
                                    'N',
                                    '',
                                    '',
                                    true,
                                    false);
end;

function TPagamentoOnline.fEnviarEmailAgrupamentoAGR(const AstrUrl,
  AstrEmailCli: String): Boolean;
Var
  LarrDestinatarios, LarrArquivos: TStringArray;
  LstrTexto, LstrAssunto : String;
begin
  Result := False ;

  LstrTexto := LstrTexto + 'Segue o link para pagamento online do(s) agrupamento(s) nº('+fArrayAgrupadoToDocString+')' + sLineBreak + AstrUrl;

  LstrAssunto := fRetNomeEmpresa + ' - ' + 'Link para Pagamento Online';

  fGerarArquivosAGR(LarrDestinatarios, LarrArquivos, AstrEmailCli) ;

  Try
    Result := TEnvioEmail.EnviarEmail(Application.GetParentComponent(),
                                  strLoginUsuarioLogado,
                                  LstrAssunto,
                                  LarrDestinatarios,
                                  [],
                                  [],
                                  TEnvioEmail.ContruirArrayMensagem(LstrTexto),
                                  LarrArquivos,
                                  false,
                                  false,
                                  '',
                                  '',
                                  0,
                                  false,
                                  '',
                                  '',
                                  '',
                                  '',
                                  0,
                                  0,
                                  0,
                                  '',
                                  '',
                                  0,
                                  false,
                                  '',
                                  nil,
                                  '',
                                  '',
                                  false,
                                  false,
                                  'S',
                                  'N',
                                  '',
                                  '',
                                  true,
                                  false);
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[Erro ao salvar comprovante agrupamento contas a receber]');
  End;
end;

function TPagamentoOnline.fGerarArquivosAGR(var AarrDestinatarios,
  AarrArquivos: TStringArray; const AstrEmailCli: String): String;
var
  LfrmCtrAgrupDupRecibo: TfrmCtrAgrupDupRecibo ;
  LintCont: Integer ;
begin
  Result := '' ;
  pArrAutoIncsToArrayAgrupado ;

  pCriarFormularios(TfrmCtrAgrupDupRecibo, LfrmCtrAgrupDupRecibo);
  try
    If Length(FarrDupAgr) > 0 Then
    Begin
      For LintCont := 0 To Length(FarrDupAgr) - 1 Do
        LfrmCtrAgrupDupRecibo.pImprimeComprovante(FarrDupAgr[LintCont].strNumAgr, 'fEnviarEmailAgrupamentoAGR', 1, True);
    End;

    for LintCont := low(LfrmCtrAgrupDupRecibo.arrArqAgrupamentos) to high(LfrmCtrAgrupDupRecibo.arrArqAgrupamentos) do
      pCriarArrayAnexosEDestinatarios(LfrmCtrAgrupDupRecibo.arrArqAgrupamentos[LintCont].strarqanexos, AstrEmailCli, AarrDestinatarios, AarrArquivos);

  finally
    pDestroiModulo(LfrmCtrAgrupDupRecibo);
  end ;

  for LintCont := 0 To Length(AarrArquivos)-1 do
    Result := ifthen(fEmptyStr(Result), AarrArquivos[LintCont], ',' + AarrArquivos[LintCont] ) ;

end;

procedure TPagamentoOnline.pArrAutoIncsToArrayAgrupado;
var
  LqryCtr: TUniQuery ;
  LintCnt: Integer ;
  LslControle: TStringList ;
  LregItem: TDuplicatasAgrupadas ;
  LstrDoc, LstrEmp: String ;
begin
  SetLength(FarrDupAgr, 0);

  LslControle := TStringList.Create ;
  LqryCtr := fCriaQuery() ;
  try
    LqryCtr.Close ;
    LqryCtr.SQL.Clear ;
    LqryCtr.SQL.Add('SELECT CTR_NUMDUP, CTR_CODEMP, CTR_CODCLI FROM CADREC WHERE AUTOINCREM = :AUTOINCREM ;') ;
    for LintCnt := low(FarrAutInc) to High(FarrAutInc) do
    begin
      LqryCtr.Close ;
      LqryCtr.ParamByName('AUTOINCREM').AsString := FarrAutInc[LintCnt] ;
      LqryCtr.Open ;

      LstrDoc := LqryCtr.FieldByName('CTR_NUMDUP').AsString ;
      FCodCli := LqryCtr.FieldByName('CTR_CODCLI').AsString ;
      LstrEmp := LqryCtr.FieldByName('CTR_CODEMP').AsString ;

      if LslControle.IndexOf(LstrDoc+FCodCli+LstrEmp) = -1 then
      begin
        LslControle.Add(LstrDoc+FCodCli+LstrEmp) ;
        FillChar(LregItem, SizeOf(LregItem), #0);
        LregItem.strNumAgr := LstrDoc ;
        LregItem.strCodCli := FCodCli ;
        LregItem.strEmpAgr := LstrEmp ;

        SetLength(FarrDupAgr, Length(FarrDupAgr)+1);
        FarrDupAgr[High(FarrDupAgr)] := LregItem ;
      end ;

    end ;
  finally
    FreeAndNil(LslControle) ;
    FreeAndNil(LqryCtr) ;
  end ;

end;

procedure TPagamentoOnline.pClassificaTipoDocumento(
  var ArecInfoDoc: TInfoDocumentoLinkPagamentoCitel);
var
  LstrDocumentos: String ;
  LstrTipLan: String ;
begin
  FillChar(ArecInfoDoc, SizeOf(ArecInfoDoc), #0);
  //pedidos
  LstrDocumentos := strSeqFgo ;
  if not fEmptyStr(LstrDocumentos) then
  begin
    ArecInfoDoc.Tipo := 'PD' ;
    ArecInfoDoc.Documentos := LstrDocumentos ;
    Exit ;
  end ;
  //SitDoc
  LstrDocumentos := fArrAutoIncsToString ;
  if not fEmptyStr(LstrDocumentos) then
  begin
    ArecInfoDoc.Tipo := LstrTipLan ;
    ArecInfoDoc.Documentos := LstrDocumentos ;
    Exit ;
  end ;
end;

procedure TPagamentoOnline.pGerarLinkPagamento(strOperacao : String;
                                              intQtdParcelas,
                                              intTipoParcelamento: Integer;
                                              fltValor: Double;
                                              const strLinkPgtFormaEnvio, strLinkPgtDestinatario: String);
begin
  pGerarLinkPagamentoCitel(strOperacao, intQtdParcelas, intTipoParcelamento, fltValor, strLinkPgtFormaEnvio, strLinkPgtDestinatario);
end;

{ TValidacoesPagamentoOnline }

class function TValidacoesPagamentoOnline.fAgrupamentoPossuiLinkPagamento(
  const AstrNumDup, AstrEspDoc, AstrCodEmp, AstrCodCli: String): Boolean;
var
  LobjPgtOnlineApi : TPagamentoOnline;
begin
  Result := False ;
  if fCfgSis('LINKPG', varInteger) <= 1 then
    Exit ;

  LobjPgtOnlineApi := TPagamentoOnline.Create;
  try
    LobjPgtOnlineApi.strNumDoc := AstrNumDup;
    LobjPgtOnlineApi.strEspDoc := AstrEspDoc;
    LobjPgtOnlineApi.strCodEmp := AstrCodEmp;
    LobjPgtOnlineApi.strCodCli := AstrCodCli;
    LobjPgtOnlineApi.strTipLan := 'AGR';

    Result := LobjPgtOnlineApi.fDocumentoPagamentoOnline;
  finally
    FreeAndNil(LobjPgtOnlineApi);
  end;
end;

end.

