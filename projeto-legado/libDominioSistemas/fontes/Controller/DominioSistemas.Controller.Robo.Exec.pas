unit DominioSistemas.Controller.Robo.Exec;

interface

uses
  DominioSistemas.DTO.DomPro, DominioSistemas.Infra.APIClient,
  DominioSistemas.Core.ApiClientInterface, System.Generics.Collections,
  DominioSistemas.Core.DocumentoInterface, Data.DB ;

type
  TControllerIntegracaoDominioExec = class
  private
    procedure pConsultaStatusProcessamento(const AApi: IApiClient;
                                           const AListProc: TObjectList<TDOMPRO>;
                                           const ATipo: TTipoDocumentoDominio;
                                           const ACodEmp: String) ;
    procedure pPersisteIntegracao(const AListProc: TObjectList<TDOMPRO>) ;
    function fJaProcessado(const ADocumentos: TDataSet; const AAcesso, ATip_fc, AStatNf: String): Boolean ;
    procedure pProcessaStatusProcessamentoPendente(const ATipo: TTipoDocumentoDominio; const ACodEmp: String; const AApi: IApiClient) ;
  public
    procedure pProcessarDocumentos;
  end;

implementation

uses
  DominioSistemas.Infra.Repository,
  System.SysUtils, DominioSistemas.DocumentoProcessor,
  {$IFDEF LINUX}
    {$I '..\..\..\core\services.core.uses.inc'},
    Shared.Core,
  {$ELSE}
    untFuncoesSimples, REST.Client,
  {$ENDIF} DominioSistemas.Core.Exception, Uni, variants;

{ TControllerIntegracaoDominioExec }

function TControllerIntegracaoDominioExec.fJaProcessado(
  const ADocumentos: TDataSet; const AAcesso, ATip_fc, AStatNf: String): Boolean;
begin
  Result := ADocumentos.Locate('DOM_ACESSO;DOM_TIP_FC;DOM_STATNF', VarArrayOf([AAcesso, ATip_fc, AStatNf]), []) ;
end;

procedure TControllerIntegracaoDominioExec.pConsultaStatusProcessamento(
  const AApi: IApiClient; const AListProc: TObjectList<TDOMPRO>;
  const ATipo: TTipoDocumentoDominio; const ACodEmp: String);
var
  LItemDomPro: TDOMPRO ;
  LStatusProcessamento: String ;
begin
  for LItemDomPro in AListProc do
  begin
    if not fEmptyStr(LItemDomPro.Protoc) then
    begin
      try
        LStatusProcessamento := fConsultarProtocoloDocumento(AApi, LItemDomPro.Protoc) ;
        LItemDomPro.Status := LStatusProcessamento ;
      except
        on ED: ExceptionDominio do
          LItemDomPro.Status := '998 - ' + ED.Message ;
        on E: Exception do
          LItemDomPro.Status := '999 - ' + E.Message ;
      end ;
    end ;
  end ;
end;

procedure TControllerIntegracaoDominioExec.pPersisteIntegracao(
  const AListProc: TObjectList<TDOMPRO>);
var
  LGravacaoEmLote: TDOMPRORepository ;
  LQry: TUniQuery ;
begin
  if AListProc.Count = 0 then
    Exit ;

  LQry := fCriaQuery() ;
  try
    LGravacaoEmLote := TDOMPRORepository.Create(Nil,
                                                LQry.Connection.Database,
                                                LQry.Connection.Username,
                                                LQry.Connection.Password,
                                                IntToStr(LQry.Connection.Port),
                                                LQry.Connection.Server);

    LGravacaoEmLote.fGravarEmBlocoNoBanco(AListProc) ;
  finally
    FreeAndNil(LQry) ;
    FreeAndNil(LGravacaoEmLote) ;
  end ;
end;

procedure TControllerIntegracaoDominioExec.pProcessarDocumentos;
var
  LEmpresas: TList<String> ;
  LCodEmp: String ;
  LDataReferencia: TDateTime ;
  LToken, LxIntregration, LIntegrationKeyApp: String ;
  LApi: IApiClient ;
  LTiposSelecionados: TTipoDocumentosDominio ;
  LTipo: TTipoDocumentoDominio ;
  LConsultaDocumentos: TDataSet ;
  LJaProcessados: TDataSet ;
  LDtoList: TObjectList<TDOMPRO>;
  LDtoDomPro: TDOMPRO ;
  LParamDoc: TParamDocumento ;
  LRetorno: String ;
begin

  LEmpresas := TMySQLRepository.fListaEmpresasHablitadas ;
  try

    if LEmpresas.Count = 0 then
      Exit ;

    LDataReferencia := VS_Date ;
    LTiposSelecionados := [tdSaidaMercadoria, tdSaidaServico, tdEntradaMercadoria, tdEntradaServico, tdConhecimentoTransporte];

    for LCodEmp in LEmpresas do
    begin
      LToken := fRetornaAccessToken(LCodEmp) ;

      LxIntregration := fRetornaXIntegrationKey(LCodEmp) ;

      LApi := TAPIClient.Create(LToken, LxIntregration) ;
      LIntegrationKeyApp := fGerarIntegrationKeyApp(LApi) ;
      LApi.pSetIntegrationKeyApp(LIntegrationKeyApp);

      for LTipo in LTiposSelecionados do
      begin
        LConsultaDocumentos := fListarDocumentos(LTipo, LCodEmp, LDataReferencia, LDataReferencia, '') ;
        LJaProcessados := fListarDocumentosJaProcessados(LTipo, LCodEmp, LDataReferencia, LDataReferencia) ;
        LDtoList := TObjectList<TDOMPRO>.Create(True);
        try

          LConsultaDocumentos.First ;
          while not LConsultaDocumentos.Eof do
          begin
            if fJaProcessado(LJaProcessados,
                             LConsultaDocumentos.FieldByName('FIS_ACESSO').AsString,
                             LConsultaDocumentos.FieldByName('FIS_TIP_FC').AsString,
                             LConsultaDocumentos.FieldByName('FIS_STATUS').AsString) then
            begin
              LConsultaDocumentos.Next ;
              Continue ;
            end;

            LDtoDomPro := TDOMPRO.Create ;
            try
              LDtoDomPro.CodEmp := LConsultaDocumentos.FieldByName('FIS_CODEMP').AsString ;
              LDtoDomPro.TipCon := ABREV_TIPO_DOCUMENTO[LTipo] ;
              LDtoDomPro.Acesso := LConsultaDocumentos.FieldByName('FIS_ACESSO').AsString ;
              LDtoDomPro.TipFC := LConsultaDocumentos.FieldByName('FIS_TIP_FC').AsString ;
              LDtoDomPro.CodOpe := strLoginUsuarioLogado  ;
              LDtoDomPro.DtProc := VS_Date ;
              LDtoDomPro.HrProc := fTime() ;
              LDtoDomPro.DtaEnt := LConsultaDocumentos.FieldByName('FIS_DTAENT').AsDateTime ;
              LDtoDomPro.StatNf := LConsultaDocumentos.FieldByName('FIS_STATUS').AsString ;

              FillChar(LParamDoc, SizeOf(TParamDocumento), #0);
              LParamDoc.NumDoc := LConsultaDocumentos.FieldByName('FIS_NUMDOC').AsString ;
              LParamDoc.EspDoc := LConsultaDocumentos.FieldByName('FIS_ESPDOC').AsString ;
              LParamDoc.CodEmp := LConsultaDocumentos.FieldByName('FIS_CODEMP').AsString ;
              LParamDoc.Serie_ := LConsultaDocumentos.FieldByName('FIS_SERIE_').AsString ;
              LParamDoc.Tip_Fc := LConsultaDocumentos.FieldByName('FIS_TIP_FC').AsString ;
              LParamDoc.ForCli := LConsultaDocumentos.FieldByName('FIS_FORCLI').AsString ;
              LParamDoc.Acesso := LConsultaDocumentos.FieldByName('FIS_ACESSO').AsString ;
              LParamDoc.OriDoc := LConsultaDocumentos.FieldByName('FIS_ORIDOC').AsString ;
              LParamDoc.Status := LConsultaDocumentos.FieldByName('FIS_STATUS').AsString ;

              LRetorno := fProcessarDocumento(LTipo, LApi, LParamDoc) ;

              LDtoDomPro.Protoc := LRetorno ;
              LDtoList.Add(LDtoDomPro) ;

            except
              on EXml: ExceptionXmlNaoEncontrado do
              begin
                LDtoDomPro.Status := EXml.Message ;
                LDtoList.Add(LDtoDomPro) ;
              end ;
              on EChaveAcesso: ExceptionDocumentoSemChaveAcesso do
              begin
                LDtoDomPro.Acesso := EChaveAcesso.Message ;
                LDtoDomPro.Status := format('Documento sem Chave Acesso [%s]', [EChaveAcesso.Message]) ;
                LDtoList.Add(LDtoDomPro) ;
              end ;
              on ED: ExceptionDominio do
              begin
                LDtoDomPro.Status := ED.Message ;
                LDtoList.Add(LDtoDomPro) ;
              end ;
              on E: Exception do
              begin
                break ;
              end ;
            end ;

            LConsultaDocumentos.Next ;
          end;

          pConsultaStatusProcessamento(LApi, LDtoList, LTipo, LCodEmp) ;

          pPersisteIntegracao(LDtoList) ;

        finally
          FreeAndNil(LJaProcessados) ;
          FreeAndNil(LConsultaDocumentos) ;
          FreeAndNil(LDtoList) ;
        end ;

        pProcessaStatusProcessamentoPendente(LTipo, LCodEmp, LApi) ;
      end;

    end;
  finally
    FreeAndNil(LEmpresas) ;
  end;
end;

procedure TControllerIntegracaoDominioExec.pProcessaStatusProcessamentoPendente(
  const ATipo: TTipoDocumentoDominio; const ACodEmp: String; const AApi: IApiClient);
var
  LConsulta: TDataSet ;
  LConsultaDocumentos: TDataSet ;
  LAcesso, LProtocolo: String ;
  LDataReferencia: TDateTime ;
  LDtoList: TObjectList<TDOMPRO>;
  LDtoDomPro: TDOMPRO ;
begin
  LConsulta := fListarDocumentosProcessamentoPendente(ATipo, ACodEmp) ;
  try
    LConsulta.First ;
    while not LConsulta.Eof do
    begin
      LDataReferencia := LConsulta.FieldByName('DOM_DTADOC').AsDateTime ;
      LAcesso := LConsulta.FieldByName('DOM_ACESSO').AsString ;
      LProtocolo := LConsulta.FieldByName('DOM_PROTOC').AsString ;

      LDtoList := TObjectList<TDOMPRO>.Create(True);
      LConsultaDocumentos := fListarDocumentos(ATipo, ACodEmp, LDataReferencia, LDataReferencia, LAcesso) ;
      try
        LConsultaDocumentos.First ;
        while not LConsultaDocumentos.Eof do
        begin

          LDtoDomPro := TDOMPRO.Create ;
          LDtoDomPro.CodEmp := LConsultaDocumentos.FieldByName('FIS_CODEMP').AsString ;
          LDtoDomPro.TipCon := ABREV_TIPO_DOCUMENTO[ATipo] ;
          LDtoDomPro.Acesso := LConsultaDocumentos.FieldByName('FIS_ACESSO').AsString ;
          LDtoDomPro.TipFC := LConsultaDocumentos.FieldByName('FIS_TIP_FC').AsString ;
          LDtoDomPro.CodOpe := strLoginUsuarioLogado  ;
          LDtoDomPro.DtProc := VS_Date ;
          LDtoDomPro.HrProc := fTime() ;
          LDtoDomPro.DtaEnt := LConsultaDocumentos.FieldByName('FIS_DTAENT').AsDateTime ;
          LDtoDomPro.StatNf := LConsultaDocumentos.FieldByName('FIS_STATUS').AsString ;
          LDtoDomPro.Protoc := LProtocolo ;
          LDtoList.Add(LDtoDomPro) ;

          LConsultaDocumentos.Next ;
        end;

        pConsultaStatusProcessamento(AApi, LDtoList, ATipo, ACodEmp) ;

        pPersisteIntegracao(LDtoList) ;

      finally
        FreeAndNil(LConsultaDocumentos) ;
        FreeAndNil(LDtoList) ;
      end;

      LConsulta.Next ;
    end;
  finally
    FreeAndNil(LConsulta) ;
  end;
end;

end.
