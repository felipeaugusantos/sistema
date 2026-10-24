unit DominioSistemas.Infra.Repository;

interface

uses
  Data.DB, Uni,
  {$IFDEF LINUX}
    {$I '..\..\..\core\services.core.uses.inc'},
    Shared.Core,
  {$ELSE}
    FireDAC.VCLUI.Wait,
  {$ENDIF}
  System.Classes, DominioSistemas.Core.DocumentoInterface,
  DominioSistemas.Core.DadosDocumentosInterface, DominioSistemas.DTO.DomPro,
  System.Generics.Collections, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.UI ;

type

  TDOMPRORepository = class
  private
    FDatabase : String;
    FUser_Name: String;
    FPassword : String;
    FPort     : String;
    FServer   : String;
    FDriverID : String;

    FDDatabase  : TFDConnection;
    FDDriverLink: TFDPhysMySQLDriverLink;
    {$IFNDEF LINUX}
      FDCursor    : TFDGUIxWaitCursor;
    {$ENDIF}
    procedure pDefinirTimeZoneEmSessaoMySql(const AConnection : TFDConnection; const ACodigoEmpresa : String);
    function fConfiguracaoExiste(strCodCfg: string; strCodEmp: string = ''): boolean;
    function fCfgTmZoneToMySqlFormatTimeZone(const ACodigoEmpresa : String): String;
    function fTimeZoneConfigurado(const ACodigoEmpresa : String) : Integer;
  public
    function fGravarEmBlocoNoBanco(const LDtoList: TObjectList<TDOMPRO>): Boolean;
    constructor Create(Owner: TComponent; strDatabaseName, strUserName, strPassword, strPort, strIPServer: String); Reintroduce;
    destructor Destroy; Override;
  end;


  TMySQLRepository = class
  private
    class function fGetXmlNfe(const AParamDoc: TParamDocumento): String ;
    class function fGetXmlImp(const AParamDoc: TParamDocumento): String ;
    class function fGetArqCte(const AParamDoc: TParamDocumento): String ;
    class function fGetXmlSat(const AParamDoc: TParamDocumento): String ;
    class function fGetNfeImp(const AParamDoc: TParamDocumento): String ;
  public
    class function fGetClientId(const ACodEmp: String) : String;
    class function fGetClientSecret(const ACodEmp: String) : String;
    class function fGetAudiense(const ACodEmp: String) : String;
    class function fGetXIntegrationKey(const ACodEmp: String) : String;
    class function fGetIntegracaoDominioHabilitada(const ACodEmp: String): Boolean ;
    class function fGetUrlApi : String;
    class function fGetUrlToken : String;
    class function fUseBoxE : Boolean;
    class function fUseIntegration : Boolean;
    class function fBuscaXMLDocumento(const AParamDoc: TParamDocumento; var AImportada: Boolean): String ;
    class function fGetSelectDinamico(const ATipo: TTipoDocumentoDominio;
                                      const AGrupo: String): string ;
    class function fGetInformacaoComplementarNfEntrada(const AParamDoc: TParamDocumento;
                                                       const ATipo: TTipoDocumentoDominio;
                                                       const AGrupo: String): TDataSet ;
    class function fGetInformacaoNotaServicoEntrada(const AParamDoc: TParamDocumento;
                                                    const ATipo: TTipoDocumentoDominio;
                                                    const AGrupo: String): TDataSet ;
    class function fGetInformacaoNotaServicoSaida(const AParamDoc: TParamDocumento;
                                                  const ATipo: TTipoDocumentoDominio;
                                                  const AGrupo: String): TDataSet ;
    class function fGetInformacaoNotaCancelada(const AParamDoc: TParamDocumento): TDataSet ;
    class function fConsultaPorPeriodo(const ADataInicial, ADataFinal: TDateTime; const ACodEmp: String): TDataSet ;
    class function fListaEmpresasHablitadas(): TList<String> ;
  end;

  TBaseDadosDocumentos = class(TInterfacedObject, IListarDadosDocumentos)
  protected
    FTipo: TTipoDocumentoDominio ;
    function fPreparaFiltroConsulta(const ACodEmp: String;
                         const ADataIni, ADataFim: TDateTime;
                         const AChaveAcesso: String): String ;
    function fPreparaFiltroConsultaCanc(const ACodEmp: String;
                         const ADataIni, ADataFim: TDateTime;
                         const AChaveAcesso: String): String ;
    function fJaProcessados(const ACodEmp: String;
                            const ADataIni, ADataFim: TDateTime): TDataSet ;
    function fPendenteProcessamento(const ACodEmp: String): TDataSet ;
  public
    function fDocumentos(const ACodEmp: String;
                         const ADataIni, ADataFim: TDateTime;
                         const AChaveAcesso: String): TDataSet ; virtual ; abstract;
    function fDocumentosJaProcessados(const ACodEmp: String;
                                      const ADataIni, ADataFim: TDateTime): TDataSet ; virtual ; abstract;
    function fDocumentosProcessamentoPendente(const ACodEmp: String): TDataSet ;  virtual ; abstract;
  end ;

  TDadosDocumentosSaidaMercadoria = class(TBaseDadosDocumentos)
  public
    function fDocumentos(const ACodEmp: String;
                         const ADataIni, ADataFim: TDateTime;
                         const AChaveAcesso: String): TDataSet ; override ;
    function fDocumentosJaProcessados(const ACodEmp: String;
                                      const ADataIni, ADataFim: TDateTime): TDataSet ; override ;
    function fDocumentosProcessamentoPendente(const ACodEmp: String): TDataSet ; override ;
    constructor Create(const ATipo: TTipoDocumentoDominio) ; reintroduce ;
  end ;

  TDadosDocumentosEntradaMercadoria = class(TBaseDadosDocumentos)
  public
    function fDocumentos(const ACodEmp: String;
                         const ADataIni, ADataFim: TDateTime;
                         const AChaveAcesso: String): TDataSet ; override ;
    function fDocumentosJaProcessados(const ACodEmp: String;
                                      const ADataIni, ADataFim: TDateTime): TDataSet ; override ;
    function fDocumentosProcessamentoPendente(const ACodEmp: String): TDataSet ; override ;
    constructor Create(const ATipo: TTipoDocumentoDominio) ; reintroduce ;
  end ;

  TDadosDocumentosSaidaServico = class(TBaseDadosDocumentos)
  public
    function fDocumentos(const ACodEmp: String;
                         const ADataIni, ADataFim: TDateTime;
                         const AChaveAcesso: String): TDataSet ; override ;
    function fDocumentosJaProcessados(const ACodEmp: String;
                                      const ADataIni, ADataFim: TDateTime): TDataSet ; override ;
    function fDocumentosProcessamentoPendente(const ACodEmp: String): TDataSet ; override ;
    constructor Create(const ATipo: TTipoDocumentoDominio) ; reintroduce ;
  end ;

  TDadosDocumentosEntradaServico = class(TBaseDadosDocumentos)
  public
    function fDocumentos(const ACodEmp: String;
                         const ADataIni, ADataFim: TDateTime;
                         const AChaveAcesso: String): TDataSet ; override ;
    function fDocumentosJaProcessados(const ACodEmp: String;
                                      const ADataIni, ADataFim: TDateTime): TDataSet ; override ;
    function fDocumentosProcessamentoPendente(const ACodEmp: String): TDataSet ; override ;
    constructor Create(const ATipo: TTipoDocumentoDominio) ; reintroduce ;
  end ;

  TDadosDocumentosConhecimentoTransporte = class(TBaseDadosDocumentos)
  public
    function fDocumentos(const ACodEmp: String;
                         const ADataIni, ADataFim: TDateTime;
                         const AChaveAcesso: String): TDataSet ; override ;
    function fDocumentosJaProcessados(const ACodEmp: String;
                                      const ADataIni, ADataFim: TDateTime): TDataSet ; override ;
    function fDocumentosProcessamentoPendente(const ACodEmp: String): TDataSet ; override ;
    constructor Create(const ATipo: TTipoDocumentoDominio) ; reintroduce ;
  end ;

implementation

uses
  SysUtils, DominioSistemas.Core.Exception, StrUtils, math,
  {$IFNDEF LINUX}
  VCL.Forms,
  {$ENDIF}
  DominioSistemas.Core.Utils, untDominioSistemasFuncoesMultiPlataforma;

{ TMySQLRepository }

class function TMySQLRepository.fBuscaXMLDocumento(const AParamDoc: TParamDocumento; var AImportada: Boolean): String;
begin
  AImportada := False ;

  if trim(AParamDoc.Acesso).IsEmpty then
    raise ExceptionDocumentoSemChaveAcesso.CreateFmt('%s-%s-%s-%s', [AParamDoc.NumDoc, AParamDoc.EspDoc, AParamDoc.CodEmp, AParamDoc.ForCli]);

  if (TFuncUtils.fRetornaModeloChaveAcesso(AParamDoc.Acesso) = CONHECIMENTO_TRANSPORTE_ELETRONICO) or
     (TFuncUtils.fRetornaModeloChaveAcesso(AParamDoc.Acesso) = CONHECIMENTO_TRANSPORTE_ELETRONICO_OUTROS_SERVICOS) or
     (TFuncUtils.fRetornaModeloChaveAcesso(AParamDoc.Acesso) = CONHECIMENTO_TRANSPORTE_RODOVIARIO) then
  begin
    result := fGetArqCte(AParamDoc) ;
  end
  else
  begin
    Result := fGetXmlNfe(AParamDoc) ;

    if trim(Result).IsEmpty then
      Result := fGetNfeImp(AParamDoc) ;

    if (trim(Result).IsEmpty) and (AParamDoc.EspDoc = 'IF') then
      Result := fGetXmlSat(AParamDoc) ;

    if trim(Result).IsEmpty then
    begin
      Result := fGetXmlImp(AParamDoc) ;
      AImportada := (not trim(Result).IsEmpty) ;
    end ;

  end ;

  if trim(Result).IsEmpty then
    raise ExceptionXmlNaoEncontrado.CreateFmt('XML não encontrado para a chave [%s]', [AParamDoc.Acesso]);

end;

class function TMySQLRepository.fGetAudiense(const ACodEmp: String): String;
begin
  Result := fMultiCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [ACodEmp, 'CFG_DOMAUD']);
end;

class function TMySQLRepository.fGetClientId(const ACodEmp: String): String;
begin
  Result := fMultiCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [ACodEmp, 'CFG_DOMCID']);
end;

class function TMySQLRepository.fGetClientSecret(const ACodEmp: String): String;
begin
  Result := fMultiCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [ACodEmp, 'CFG_DOMSEC']);
end;

class function TMySQLRepository.fGetInformacaoComplementarNfEntrada(
  const AParamDoc: TParamDocumento;
  const ATipo: TTipoDocumentoDominio;
  const AGrupo: String): TDataSet;
var
  LSelect: String ;
  LParametros: String ;
  LConsultaDados: TUniQuery ;
begin
  LSelect := fGetSelectDinamico(ATipo, AGrupo) ;

  LParametros := '' ;
  LParametros := LParametros + ' AND F.FIS_NUMDOC = :NUMDOC ' ;
  LParametros := LParametros + ' AND F.FIS_ESPDOC = :ESPDOC ' ;
  LParametros := LParametros + ' AND F.FIS_CODEMP = :CODEMP ' ;
  LParametros := LParametros + ' AND F.FIS_SERIE_ = :SERIE_ ' ;
  LParametros := LParametros + ' AND F.FIS_TIP_FC = :TIP_FC ' ;
  LParametros := LParametros + ' AND F.FIS_FORCLI = :FORCLI ' ;
  LParametros := LParametros + ' AND F.FIS_ACESSO = :ACESSO ' ;

  LSelect := ReplaceStr(LSelect, REPLACE_PARAMETROS, LParametros) ;

  LConsultaDados := fMultiCriaQuery() ;
  LConsultaDados.SQL.Clear ;
  LConsultaDados.SQL.Add(LSelect) ;
  LConsultaDados.ParamByName('NUMDOC').AsString := AParamDoc.NumDoc ;
  LConsultaDados.ParamByName('ESPDOC').AsString := AParamDoc.EspDoc ;
  LConsultaDados.ParamByName('CODEMP').AsString := AParamDoc.CodEmp ;
  LConsultaDados.ParamByName('SERIE_').AsString := AParamDoc.Serie_ ;
  LConsultaDados.ParamByName('TIP_FC').AsString := AParamDoc.Tip_Fc ;
  LConsultaDados.ParamByName('FORCLI').AsString := AParamDoc.ForCli ;
  LConsultaDados.ParamByName('ACESSO').AsString := AParamDoc.Acesso ;
  LConsultaDados.Open ;

  Result := LConsultaDados ;
end;

class function TMySQLRepository.fGetInformacaoNotaServicoEntrada(
  const AParamDoc: TParamDocumento; const ATipo: TTipoDocumentoDominio;
  const AGrupo: String): TDataSet;
var
  LSelect: String ;
  LParametros: String ;
  LConsultaDados: TUniQuery ;
begin
  LSelect := fGetSelectDinamico(ATipo, AGrupo) ;

  LParametros := '' ;
  LParametros := LParametros + ' AND CF.FIS_NUMDOC = :NUMDOC ' ;
  LParametros := LParametros + ' AND CF.FIS_ESPDOC = :ESPDOC ' ;
  LParametros := LParametros + ' AND CF.FIS_CODEMP = :CODEMP ' ;
  LParametros := LParametros + ' AND CF.FIS_SERIE_ = :SERIE_ ' ;
  LParametros := LParametros + ' AND CF.FIS_TIP_FC = :TIP_FC ' ;
  LParametros := LParametros + ' AND CF.FIS_FORCLI = :FORCLI ' ;

  LSelect := ReplaceStr(LSelect, REPLACE_PARAMETROS, LParametros) ;

  LConsultaDados := fMultiCriaQuery() ;
  LConsultaDados.SQL.Clear ;
  LConsultaDados.SQL.Add(LSelect) ;
  LConsultaDados.ParamByName('NUMDOC').AsString := AParamDoc.NumDoc ;
  LConsultaDados.ParamByName('ESPDOC').AsString := AParamDoc.EspDoc ;
  LConsultaDados.ParamByName('CODEMP').AsString := AParamDoc.CodEmp ;
  LConsultaDados.ParamByName('SERIE_').AsString := AParamDoc.Serie_ ;
  LConsultaDados.ParamByName('TIP_FC').AsString := AParamDoc.Tip_Fc ;
  LConsultaDados.ParamByName('FORCLI').AsString := AParamDoc.ForCli ;
  LConsultaDados.Open ;

  Result := LConsultaDados ;
end;

class function TMySQLRepository.fGetInformacaoNotaServicoSaida(
  const AParamDoc: TParamDocumento; const ATipo: TTipoDocumentoDominio;
  const AGrupo: String): TDataSet;
var
  LSelect: String ;
  LParametros: String ;
  LConsultaDados: TUniQuery ;
begin
  LSelect := fGetSelectDinamico(ATipo, AGrupo) ;

  LParametros := '' ;
  LParametros := LParametros + ' AND CF.FIS_NUMDOC = :NUMDOC ' ;
  LParametros := LParametros + ' AND CF.FIS_ESPDOC = :ESPDOC ' ;
  LParametros := LParametros + ' AND CF.FIS_CODEMP = :CODEMP ' ;
  LParametros := LParametros + ' AND CF.FIS_SERIE_ = :SERIE_ ' ;
  LParametros := LParametros + ' AND CF.FIS_TIP_FC = :TIP_FC ' ;
  LParametros := LParametros + ' AND CF.FIS_FORCLI = :FORCLI ' ;

  LSelect := ReplaceStr(LSelect, REPLACE_PARAMETROS, LParametros) ;

  LConsultaDados := fMultiCriaQuery() ;
  LConsultaDados.SQL.Clear ;
  LConsultaDados.SQL.Add(LSelect) ;
  LConsultaDados.ParamByName('NUMDOC').AsString := AParamDoc.NumDoc ;
  LConsultaDados.ParamByName('ESPDOC').AsString := AParamDoc.EspDoc ;
  LConsultaDados.ParamByName('CODEMP').AsString := AParamDoc.CodEmp ;
  LConsultaDados.ParamByName('SERIE_').AsString := AParamDoc.Serie_ ;
  LConsultaDados.ParamByName('TIP_FC').AsString := AParamDoc.Tip_Fc ;
  LConsultaDados.ParamByName('FORCLI').AsString := AParamDoc.ForCli ;
  LConsultaDados.Open ;

  Result := LConsultaDados ;
end;

class function TMySQLRepository.fGetIntegracaoDominioHabilitada(
  const ACodEmp: String): Boolean;
begin
  Result := fMultiCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [ACodEmp, 'CFG_DOMHAB']) = 'S';
end;

class function TMySQLRepository.fGetNfeImp(
  const AParamDoc: TParamDocumento): String;
var
  LConsultaXml: TUniQuery ;
begin
  Result := '';
  LConsultaXml := fMultiCriaQuery() ;
  try
    LConsultaXml.Close ;
    LConsultaXml.SQL.Clear ;
    LConsultaXml.SQL.Add('  SELECT CADFIS.FIS_ACESSO, ') ;
    LConsultaXml.SQL.Add('         NFEIMP.NFE_ARQXML ') ;
    LConsultaXml.SQL.Add('  FROM CADFIS ') ;
    LConsultaXml.SQL.Add('       INNER JOIN NFEIMP ON CADFIS.FIS_ACESSO = NFEIMP.NFE_ACESSO ') ;
    LConsultaXml.SQL.Add('  WHERE ') ;
    LConsultaXml.SQL.Add('     CADFIS.FIS_NUMDOC = :NUMDOC AND ') ;
    LConsultaXml.SQL.Add('     CADFIS.FIS_ESPDOC = :ESPDOC AND ') ;
    LConsultaXml.SQL.Add('     CADFIS.FIS_CODEMP = :CODEMP AND ') ;
    LConsultaXml.SQL.Add('     CADFIS.FIS_SERIE_ = :SERIE_ AND ') ;
    LConsultaXml.SQL.Add('     CADFIS.FIS_TIP_FC = :TIP_FC AND ') ;
    LConsultaXml.SQL.Add('     CADFIS.FIS_FORCLI = :FORCLI AND ') ;
    LConsultaXml.SQL.Add('     CADFIS.FIS_ACESSO = :ACESSO ; ') ;
    LConsultaXml.ParamByName('NUMDOC').AsString := AParamDoc.NumDoc ;
    LConsultaXml.ParamByName('ESPDOC').AsString := AParamDoc.EspDoc ;
    LConsultaXml.ParamByName('CODEMP').AsString := AParamDoc.CodEmp ;
    LConsultaXml.ParamByName('SERIE_').AsString := AParamDoc.Serie_ ;
    LConsultaXml.ParamByName('TIP_FC').AsString := AParamDoc.Tip_Fc ;
    LConsultaXml.ParamByName('FORCLI').AsString := AParamDoc.ForCli ;
    LConsultaXml.ParamByName('ACESSO').AsString := AParamDoc.Acesso ;
    LConsultaXml.Open ;
    Result := LConsultaXml.FieldByName('NFE_ARQXML').AsString ;
  finally
    FreeAndNil(LConsultaXml) ;
  end ;
end;

class function TMySQLRepository.fGetSelectDinamico(const ATipo: TTipoDocumentoDominio;
  const AGrupo: String): string;
var
  LConsultaSelect: TUniQuery ;
begin
  LConsultaSelect := fMultiCriaQuery() ;
  try
    LConsultaSelect.Close ;
    LConsultaSelect.SQL.Clear ;
    LConsultaSelect.SQL.Add(' SELECT DOM_CONSUL FROM DOMSQL  ') ;
    LConsultaSelect.SQL.Add(' WHERE DOM_TIPCON = :TIPCON     ') ;
    LConsultaSelect.SQL.Add('       AND DOM_GRUCON = :GRUCON ') ;
    LConsultaSelect.ParamByName('TIPCON').AsString := ABREV_TIPO_DOCUMENTO[ATipo] ;
    LConsultaSelect.ParamByName('GRUCON').AsString := AGrupo ;
    LConsultaSelect.Open ;
    LConsultaSelect.First ;

    if LConsultaSelect.IsEmpty then
      raise ExceptionSelectNaoEncontrado.CreateFmt('Tipo Consulta [%s/%s] não encontrada na DOMSQL', [ABREV_TIPO_DOCUMENTO[ATipo], AGrupo]);

    Result := LConsultaSelect.FieldByName('DOM_CONSUL').AsString ;

  finally
    FreeAndNil(LConsultaSelect) ;
  end ;
end;

class function TMySQLRepository.fGetUrlApi: String;
begin
  Result := fMultiCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [fMultiVS_strCodEmp, 'CFG_DOMURL']);
end;

class function TMySQLRepository.fGetUrlToken: String;
begin
  Result := fMultiCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [fMultiVS_strCodEmp, 'CFG_DOMUTK']);
end;

class function TMySQLRepository.fGetXIntegrationKey(const ACodEmp: String): String;
begin
  Result := fMultiCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [ACodEmp, 'CFG_DOMXIK']);
end;

class function TMySQLRepository.fConsultaPorPeriodo(const ADataInicial,
  ADataFinal: TDateTime; const ACodEmp: String): TDataSet;
var
  LConsulta: TUniQuery ;
begin
  LConsulta := fMultiCriaQuery() ;
  LConsulta.Close ;
  LConsulta.SQL.Clear ;
  LConsulta.SQL.Add(' SELECT ') ;
  LConsulta.SQL.Add('   DOMPRO.AUTOINCREM, ') ;
  LConsulta.SQL.Add('   CADFIS.FIS_NUMDOC, ') ;
  LConsulta.SQL.Add('   CADFIS.FIS_SERIE_, ') ;
  LConsulta.SQL.Add('   CADFIS.FIS_ESPDOC, ') ;
  LConsulta.SQL.Add('   CADFIS.FIS_FORCLI, ') ;
  LConsulta.SQL.Add('   DOMPRO.DOM_CODEMP, ') ;
  LConsulta.SQL.Add('   CADEMP.EMP_NOMFAN, ') ;
  LConsulta.SQL.Add('   DOMPRO.DOM_TIPCON, ') ;
  LConsulta.SQL.Add('   DOMPRO.DOM_ACESSO, ') ;
  LConsulta.SQL.Add('   DOMPRO.DOM_TIP_FC, ') ;
  LConsulta.SQL.Add('   DOMPRO.DOM_CODOPE, ') ;
  LConsulta.SQL.Add('   DOMPRO.DOM_DTPROC, ') ;
  LConsulta.SQL.Add('   DOMPRO.DOM_HRPROC, ') ;
  LConsulta.SQL.Add('   DOMPRO.DOM_PROTOC, ') ;
  LConsulta.SQL.Add('   DOMPRO.DOM_DTADOC, ') ;
  LConsulta.SQL.Add('   DOMPRO.DOM_STATUS, ') ;
  LConsulta.SQL.Add('   DOMPRO.DOM_STATNF  ') ;
  LConsulta.SQL.Add(' FROM DOMPRO ') ;
  LConsulta.SQL.Add('      INNER JOIN CADEMP ON DOMPRO.DOM_CODEMP = CADEMP.EMP_CODEMP ') ;
  LConsulta.SQL.Add('      LEFT JOIN CADFIS ON DOMPRO.DOM_CODEMP = CADFIS.FIS_CODEMP AND DOMPRO.DOM_ACESSO = CADFIS.FIS_ACESSO ') ;
  LConsulta.SQL.Add(' WHERE DOMPRO.DOM_DTADOC BETWEEN :INI AND :FIM ') ;
  LConsulta.ParamByName('INI').AsDate := ADataInicial ;
  LConsulta.ParamByName('FIM').AsDate := ADataFinal ;
  if not trim(ACodEmp).IsEmpty then
  begin
    LConsulta.SQL.Add('       AND DOMPRO.DOM_CODEMP = :CODEMP ') ;
    LConsulta.ParamByName('CODEMP').AsString := ACodEmp ;
  end ;
  LConsulta.SQL.Add(' ORDER BY DOMPRO.DOM_DTADOC, DOMPRO.AUTOINCREM ') ;
  LConsulta.Open ;

  Result := LConsulta ;
end;

class function TMySQLRepository.fGetArqCte(
  const AParamDoc: TParamDocumento): String;
var
  LConsultaXml: TUniQuery ;
begin
  Result := '';
  LConsultaXml := fMultiCriaQuery() ;
  try
    LConsultaXml.Close ;
    LConsultaXml.SQL.Clear ;
    LConsultaXml.SQL.Add(' SELECT CADFIS.FIS_ACESSO, ') ;
    LConsultaXml.SQL.Add('        ARQCTE.CTE_ARQXML ') ;
    LConsultaXml.SQL.Add(' FROM CADFIS ') ;
    LConsultaXml.SQL.Add('      INNER JOIN ARQCTE ON CADFIS.AUTOINCREM = ARQCTE.CTE_CADFIS ') ;
    LConsultaXml.SQL.Add(' WHERE ') ;
    LConsultaXml.SQL.Add('    CADFIS.FIS_NUMDOC = :NUMDOC AND ') ;
    LConsultaXml.SQL.Add('    CADFIS.FIS_ESPDOC = :ESPDOC AND ') ;
    LConsultaXml.SQL.Add('    CADFIS.FIS_CODEMP = :CODEMP AND ') ;
    LConsultaXml.SQL.Add('    CADFIS.FIS_SERIE_ = :SERIE_ AND ') ;
    LConsultaXml.SQL.Add('    CADFIS.FIS_TIP_FC = :TIP_FC AND ') ;
    LConsultaXml.SQL.Add('    CADFIS.FIS_FORCLI = :FORCLI AND ') ;
    LConsultaXml.SQL.Add('    CADFIS.FIS_ACESSO = :ACESSO ') ;
    LConsultaXml.ParamByName('NUMDOC').AsString := AParamDoc.NumDoc ;
    LConsultaXml.ParamByName('ESPDOC').AsString := AParamDoc.EspDoc ;
    LConsultaXml.ParamByName('CODEMP').AsString := AParamDoc.CodEmp ;
    LConsultaXml.ParamByName('SERIE_').AsString := AParamDoc.Serie_ ;
    LConsultaXml.ParamByName('TIP_FC').AsString := AParamDoc.Tip_Fc ;
    LConsultaXml.ParamByName('FORCLI').AsString := AParamDoc.ForCli ;
    LConsultaXml.ParamByName('ACESSO').AsString := AParamDoc.Acesso ;
    LConsultaXml.Open ;

    Result := LConsultaXml.FieldByName('CTE_ARQXML').AsString ;
  finally
    FreeAndNil(LConsultaXml) ;
  end ;
end;

class function TMySQLRepository.fGetXmlNfe(const AParamDoc: TParamDocumento): String;
var
  LConsultaXml: TUniQuery ;
begin
  Result := '';
  LConsultaXml := fMultiCriaQuery() ;
  try
    LConsultaXml.Close ;
    LConsultaXml.SQL.Clear ;
    LConsultaXml.SQL.Add(' SELECT CADFIS.FIS_ACESSO, ') ;
    LConsultaXml.SQL.Add('        XMLNFE.NFE_ARQXML ') ;
    LConsultaXml.SQL.Add(' FROM CADFIS ') ;
    LConsultaXml.SQL.Add('      INNER JOIN XMLNFE ON CADFIS.FIS_ACESSO = XMLNFE.NFE_ACESSO ') ;
    LConsultaXml.SQL.Add(' WHERE ') ;
    LConsultaXml.SQL.Add('    FIS_NUMDOC = :NUMDOC AND ') ;
    LConsultaXml.SQL.Add('    FIS_ESPDOC = :ESPDOC AND ') ;
    LConsultaXml.SQL.Add('    FIS_CODEMP = :CODEMP AND ') ;
    LConsultaXml.SQL.Add('    FIS_SERIE_ = :SERIE_ AND ') ;
    LConsultaXml.SQL.Add('    FIS_TIP_FC = :TIP_FC AND ') ;
    LConsultaXml.SQL.Add('    FIS_FORCLI = :FORCLI AND ') ;
    LConsultaXml.SQL.Add('    FIS_ACESSO = :ACESSO ') ;
    LConsultaXml.ParamByName('NUMDOC').AsString := AParamDoc.NumDoc ;
    LConsultaXml.ParamByName('ESPDOC').AsString := AParamDoc.EspDoc ;
    LConsultaXml.ParamByName('CODEMP').AsString := AParamDoc.CodEmp ;
    LConsultaXml.ParamByName('SERIE_').AsString := AParamDoc.Serie_ ;
    LConsultaXml.ParamByName('TIP_FC').AsString := AParamDoc.Tip_Fc ;
    LConsultaXml.ParamByName('FORCLI').AsString := AParamDoc.ForCli ;
    LConsultaXml.ParamByName('ACESSO').AsString := AParamDoc.Acesso ;
    LConsultaXml.Open ;

    Result := LConsultaXml.FieldByName('NFE_ARQXML').AsString ;
  finally
    FreeAndNil(LConsultaXml) ;
  end ;
end;

class function TMySQLRepository.fGetInformacaoNotaCancelada(const AParamDoc: TParamDocumento): TDataSet;
var
  LConsultaCan: TUniQuery ;
begin
  LConsultaCan := fMultiCriaQuery() ;
  LConsultaCan.Close ;
  LConsultaCan.SQL.Clear ;
  LConsultaCan.SQL.Add('SELECT CAST(CONCAT(DATE_FORMAT(LOG_DTACAN, "%Y-%m-%d"), " ", TIME_FORMAT(LOG_HORCAN, "%H:%i:%s")) AS DATETIME) AS LOG_DTACAN, LOG_NUMDOC, LOG_ACESSO FROM LOGCAN WHERE LOG_ACESSO = :ACESSO') ;
  LConsultaCan.ParamByName('ACESSO').AsString := AParamDoc.Acesso ;
  LConsultaCan.Open ;

  Result := LConsultaCan ;
end;

class function TMySQLRepository.fGetXmlImp(
  const AParamDoc: TParamDocumento): String;
var
  LConsultaXml: TUniQuery ;
begin
  Result := '';
  LConsultaXml := fMultiCriaQuery() ;
  try
    LConsultaXml.Close ;
    LConsultaXml.SQL.Clear ;
    LConsultaXml.SQL.Add(' SELECT DISTINCT E.DET_SEQGER, X.IMP_ARQXML ') ;
    LConsultaXml.SQL.Add(' FROM CADFIS F ') ;
    LConsultaXml.SQL.Add('     INNER JOIN MOVDET D ON D.DET_NUMDOC = F.FIS_NUMDOC ') ;
    LConsultaXml.SQL.Add('			    AND D.DET_ESPDOC = F.FIS_ESPDOC ') ;
    LConsultaXml.SQL.Add('			    AND D.DET_CODEMP = F.FIS_CODEMP ') ;
    LConsultaXml.SQL.Add('			    AND D.DET_CODFOR = F.FIS_FORCLI ') ;
    LConsultaXml.SQL.Add('			    AND D.DET_DTADOC = F.FIS_DTADOC ') ;
    LConsultaXml.SQL.Add('     INNER JOIN MOVTRI T ON D.AUTOINCREM = T.DET_SEQGER ') ;
    LConsultaXml.SQL.Add('     INNER JOIN DETELE E ON T.DET_AUTELE = E.AUTOINCREM ') ;
    LConsultaXml.SQL.Add('     INNER JOIN XMLIMP X ON X.IMP_SEQGER = E.DET_SEQGER ') ;
    LConsultaXml.SQL.Add(' WHERE  ') ;
    LConsultaXml.SQL.Add('    F.FIS_NUMDOC = :NUMDOC AND ') ;
    LConsultaXml.SQL.Add('    F.FIS_ESPDOC = :ESPDOC AND ') ;
    LConsultaXml.SQL.Add('    F.FIS_CODEMP = :CODEMP AND ') ;
    LConsultaXml.SQL.Add('    F.FIS_SERIE_ = :SERIE_ AND ') ;
    LConsultaXml.SQL.Add('    F.FIS_TIP_FC = :TIP_FC AND ') ;
    LConsultaXml.SQL.Add('    F.FIS_FORCLI = :FORCLI AND ') ;
    LConsultaXml.SQL.Add('    F.FIS_ACESSO = :ACESSO ') ;
    LConsultaXml.ParamByName('NUMDOC').AsString := AParamDoc.NumDoc ;
    LConsultaXml.ParamByName('ESPDOC').AsString := AParamDoc.EspDoc ;
    LConsultaXml.ParamByName('CODEMP').AsString := AParamDoc.CodEmp ;
    LConsultaXml.ParamByName('SERIE_').AsString := AParamDoc.Serie_ ;
    LConsultaXml.ParamByName('TIP_FC').AsString := AParamDoc.Tip_Fc ;
    LConsultaXml.ParamByName('FORCLI').AsString := AParamDoc.ForCli ;
    LConsultaXml.ParamByName('ACESSO').AsString := AParamDoc.Acesso ;
    LConsultaXml.Open ;

    Result := LConsultaXml.FieldByName('IMP_ARQXML').AsString ;
  finally
    FreeAndNil(LConsultaXml) ;
  end ;
end;

class function TMySQLRepository.fGetXmlSat(
  const AParamDoc: TParamDocumento): String;
var
  LConsultaXml: TUniQuery ;
begin
  Result := '';
  LConsultaXml := fMultiCriaQuery() ;
  try
    LConsultaXml.Close ;
    LConsultaXml.SQL.Clear ;
    LConsultaXml.SQL.Add('  SELECT CADFIS.FIS_ACESSO, ') ;
    LConsultaXml.SQL.Add('        XMLSAT.XML_ARQXML ') ;
    LConsultaXml.SQL.Add(' FROM CADFIS ') ;
    LConsultaXml.SQL.Add('      INNER JOIN XMLSAT ON CADFIS.AUTOINCREM = XMLSAT.XML_SEQFIS ') ;
    LConsultaXml.SQL.Add(' WHERE ') ;
    LConsultaXml.SQL.Add('     CADFIS.FIS_NUMDOC = :NUMDOC AND ') ;
    LConsultaXml.SQL.Add('     CADFIS.FIS_ESPDOC = :ESPDOC AND ') ;
    LConsultaXml.SQL.Add('     CADFIS.FIS_CODEMP = :CODEMP AND ') ;
    LConsultaXml.SQL.Add('     CADFIS.FIS_SERIE_ = :SERIE_ AND ') ;
    LConsultaXml.SQL.Add('     CADFIS.FIS_TIP_FC = :TIP_FC AND ') ;
    LConsultaXml.SQL.Add('     CADFIS.FIS_FORCLI = :FORCLI AND ') ;
    LConsultaXml.SQL.Add('     CADFIS.FIS_ACESSO  = :ACESSO ; ') ;
    LConsultaXml.ParamByName('NUMDOC').AsString := AParamDoc.NumDoc ;
    LConsultaXml.ParamByName('ESPDOC').AsString := AParamDoc.EspDoc ;
    LConsultaXml.ParamByName('CODEMP').AsString := AParamDoc.CodEmp ;
    LConsultaXml.ParamByName('SERIE_').AsString := AParamDoc.Serie_ ;
    LConsultaXml.ParamByName('TIP_FC').AsString := AParamDoc.Tip_Fc ;
    LConsultaXml.ParamByName('FORCLI').AsString := AParamDoc.ForCli ;
    LConsultaXml.ParamByName('ACESSO').AsString := AParamDoc.Acesso ;
    LConsultaXml.Open ;

    Result := LConsultaXml.FieldByName('XML_ARQXML').AsString ;
  finally
    FreeAndNil(LConsultaXml) ;
  end ;
end;

class function TMySQLRepository.fListaEmpresasHablitadas: TList<String>;
var
  LConsulta: TUniQuery ;
begin
  Result := TList<String>.Create ;

  LConsulta := fMultiCriaQuery() ;
  try
    LConsulta.Close ;
    LConsulta.SQL.Clear ;
    LConsulta.SQL.Add('SELECT SIS_CODEMP FROM CFGSIS WHERE SIS_CODCFG = "CFG_DOMHAB" AND SIS_VALCFG = "S" ') ;
    LConsulta.Open ;
    LConsulta.First ;
    while not LConsulta.Eof do
    begin
      Result.Add(LConsulta.FieldByName('SIS_CODEMP').AsString) ;
      LConsulta.Next ;
    end;

  finally
    FreeAndNil(LConsulta) ;
  end;

end;

class function TMySQLRepository.fUseBoxE: Boolean;
begin
  Result := fMultiCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [fMultiVS_strCodEmp, 'CFG_DOMBOX'])='S';
end;

class function TMySQLRepository.fUseIntegration: Boolean;
begin
  Result := fMultiCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [fMultiVS_strCodEmp, 'CFG_DOMHAB'])='S';
end;

{ TDadosDocumentosSaidaMercadoria }

constructor TDadosDocumentosSaidaMercadoria.Create(const ATipo: TTipoDocumentoDominio);
begin
  FTipo := ATipo ;
end;

function TDadosDocumentosSaidaMercadoria.fDocumentos(
  const ACodEmp: String; const ADataIni, ADataFim: TDateTime;
  const AChaveAcesso: String): TDataSet;
var
  LConsulta: TUniQuery ;
  LSql: String ;
  LSqlParametros: String ;
begin
  LSql := TMySQLRepository.fGetSelectDinamico(FTipo, '001') ;

  LSqlParametros := fPreparaFiltroConsulta(ACodEmp, ADataIni, ADataFim, AChaveAcesso) ;
  LSql := ReplaceStr(LSql, REPLACE_PARAMETROS, LSqlParametros) ;

  LSqlParametros := fPreparaFiltroConsultaCanc(ACodEmp, ADataIni, ADataFim, AChaveAcesso) ;
  LSql := ReplaceStr(LSql, REPLACE_PARAMETROS_CANCELADO, LSqlParametros) ;

  LConsulta := fMultiCriaQuery() ;
  LConsulta.close ;
  LConsulta.SQL.Clear ;
  LConsulta.SQL.Add(LSql) ;
  if not Trim(ACodEmp).IsEmpty then
    LConsulta.ParamByName('CODEMP').AsString := ACodEmp ;
  if not Trim(AChaveAcesso).IsEmpty then
    LConsulta.ParamByName('ACESSO').AsString := AChaveAcesso ;
  if (ADataini > 0) and (ADataFim > 0) then
  begin
    LConsulta.ParamByName('DTAINI').AsDate := ADataini ;
    LConsulta.ParamByName('DTAFIM').AsDate := ADataFim ;
  end ;
  LConsulta.Open ;
  Result := LConsulta ;
end;

function TDadosDocumentosSaidaMercadoria.fDocumentosJaProcessados(
  const ACodEmp: String; const ADataIni, ADataFim: TDateTime): TDataSet;
begin
  Result := self.fJaProcessados(ACodEmp, ADataIni, ADataFim) ;
end;

function TDadosDocumentosSaidaMercadoria.fDocumentosProcessamentoPendente(
  const ACodEmp: String): TDataSet;
begin
  Result := self.fPendenteProcessamento(ACodEmp) ;
end;

{ TDadosDocumentosEntradaMercadoria }

constructor TDadosDocumentosEntradaMercadoria.Create(const ATipo: TTipoDocumentoDominio);
begin
  FTipo := ATipo ;
end;

function TDadosDocumentosEntradaMercadoria.fDocumentos(const ACodEmp: String;
  const ADataIni, ADataFim: TDateTime; const AChaveAcesso: String): TDataSet;
var
  LConsulta: TUniQuery ;
  LSql: String ;
  LSqlParametros: String ;
begin
  LSql := TMySQLRepository.fGetSelectDinamico(FTipo, '001') ;

  LSqlParametros := fPreparaFiltroConsulta(ACodEmp, ADataIni, ADataFim, AChaveAcesso) ;
  LSql := ReplaceStr(LSql, REPLACE_PARAMETROS, LSqlParametros) ;

  LSqlParametros := fPreparaFiltroConsultaCanc(ACodEmp, ADataIni, ADataFim, AChaveAcesso) ;
  LSql := ReplaceStr(LSql, REPLACE_PARAMETROS_CANCELADO, LSqlParametros) ;

  LConsulta := fMultiCriaQuery() ;
  LConsulta.close ;
  LConsulta.SQL.Clear ;
  LConsulta.SQL.Add(LSql) ;
  if not Trim(ACodEmp).IsEmpty then
    LConsulta.ParamByName('CODEMP').AsString := ACodEmp ;
  if not Trim(AChaveAcesso).IsEmpty then
    LConsulta.ParamByName('ACESSO').AsString := AChaveAcesso ;
  if (ADataini > 0) and (ADataFim > 0) then
  begin
    LConsulta.ParamByName('DTAINI').AsDate := ADataini ;
    LConsulta.ParamByName('DTAFIM').AsDate := ADataFim ;
  end ;
  LConsulta.Open ;
  Result := LConsulta ;
end;

function TDadosDocumentosEntradaMercadoria.fDocumentosJaProcessados(
  const ACodEmp: String; const ADataIni, ADataFim: TDateTime): TDataSet;
begin
  Result := self.fJaProcessados(ACodEmp, ADataIni, ADataFim) ;
end;

function TDadosDocumentosEntradaMercadoria.fDocumentosProcessamentoPendente(
  const ACodEmp: String): TDataSet;
begin
  Result := self.fPendenteProcessamento(ACodEmp) ;
end;

{ TDadosDocumentosSaidaServico }

constructor TDadosDocumentosSaidaServico.Create(const ATipo: TTipoDocumentoDominio);
begin
  FTipo := ATipo ;
end;

function TDadosDocumentosSaidaServico.fDocumentos(const ACodEmp: String;
  const ADataIni, ADataFim: TDateTime; const AChaveAcesso: String): TDataSet;
var
  LConsulta: TUniQuery ;
  LSql: String ;
  LSqlParametros: String ;
begin
  LSql := TMySQLRepository.fGetSelectDinamico(FTipo, '001') ;

  LSqlParametros := fPreparaFiltroConsulta(ACodEmp, ADataIni, ADataFim, AChaveAcesso) ;
  LSql := ReplaceStr(LSql, REPLACE_PARAMETROS, LSqlParametros) ;

  LSqlParametros := fPreparaFiltroConsultaCanc(ACodEmp, ADataIni, ADataFim, AChaveAcesso) ;
  LSql := ReplaceStr(LSql, REPLACE_PARAMETROS_CANCELADO, LSqlParametros) ;

  LConsulta := fMultiCriaQuery() ;
  LConsulta.close ;
  LConsulta.SQL.Clear ;
  LConsulta.SQL.Add(LSql) ;
  if not Trim(ACodEmp).IsEmpty then
    LConsulta.ParamByName('CODEMP').AsString := ACodEmp ;
  if not Trim(AChaveAcesso).IsEmpty then
    LConsulta.ParamByName('ACESSO').AsString := AChaveAcesso ;
  if (ADataini > 0) and (ADataFim > 0) then
  begin
    LConsulta.ParamByName('DTAINI').AsDate := ADataini ;
    LConsulta.ParamByName('DTAFIM').AsDate := ADataFim ;
  end ;
  LConsulta.Open ;
  Result := LConsulta ;
end;

function TDadosDocumentosSaidaServico.fDocumentosJaProcessados(
  const ACodEmp: String; const ADataIni, ADataFim: TDateTime): TDataSet;
begin
  Result := self.fJaProcessados(ACodEmp, ADataIni, ADataFim) ;
end;

function TDadosDocumentosSaidaServico.fDocumentosProcessamentoPendente(
  const ACodEmp: String): TDataSet;
begin
  Result := self.fPendenteProcessamento(ACodEmp) ;
end;

{ TDadosDocumentosEntradaServico }

constructor TDadosDocumentosEntradaServico.Create(const ATipo: TTipoDocumentoDominio);
begin
  FTipo := ATipo ;
end;

function TDadosDocumentosEntradaServico.fDocumentos(const ACodEmp: String;
  const ADataIni, ADataFim: TDateTime; const AChaveAcesso: String): TDataSet;
var
  LConsulta: TUniQuery ;
  LSql: String ;
  LSqlParametros: String ;
begin
  LSql := TMySQLRepository.fGetSelectDinamico(FTipo, '001') ;

  LSqlParametros := fPreparaFiltroConsulta(ACodEmp, ADataIni, ADataFim, AChaveAcesso) ;
  LSql := ReplaceStr(LSql, REPLACE_PARAMETROS, LSqlParametros) ;

  LSqlParametros := fPreparaFiltroConsultaCanc(ACodEmp, ADataIni, ADataFim, AChaveAcesso) ;
  LSql := ReplaceStr(LSql, REPLACE_PARAMETROS_CANCELADO, LSqlParametros) ;

  LConsulta := fMultiCriaQuery() ;
  LConsulta.close ;
  LConsulta.SQL.Clear ;
  LConsulta.SQL.Add(LSql) ;
  if not Trim(ACodEmp).IsEmpty then
    LConsulta.ParamByName('CODEMP').AsString := ACodEmp ;
  if not Trim(AChaveAcesso).IsEmpty then
    LConsulta.ParamByName('ACESSO').AsString := AChaveAcesso ;
  if (ADataini > 0) and (ADataFim > 0) then
  begin
    LConsulta.ParamByName('DTAINI').AsDate := ADataini ;
    LConsulta.ParamByName('DTAFIM').AsDate := ADataFim ;
  end ;
  LConsulta.Open ;
  Result := LConsulta ;
end;

function TDadosDocumentosEntradaServico.fDocumentosJaProcessados(
  const ACodEmp: String; const ADataIni, ADataFim: TDateTime): TDataSet;
begin
  Result := self.fJaProcessados(ACodEmp, ADataIni, ADataFim) ;
end;

function TDadosDocumentosEntradaServico.fDocumentosProcessamentoPendente(
  const ACodEmp: String): TDataSet;
begin
  Result := self.fPendenteProcessamento(ACodEmp) ;
end;

{ TDadosDocumentosConhecimentoTransporte }

constructor TDadosDocumentosConhecimentoTransporte.Create(
  const ATipo: TTipoDocumentoDominio);
begin
  FTipo := ATipo ;
end;

function TDadosDocumentosConhecimentoTransporte.fDocumentos(
  const ACodEmp: String; const ADataIni, ADataFim: TDateTime;
  const AChaveAcesso: String): TDataSet;
var
  LConsulta: TUniQuery ;
  LSql: String ;
  LSqlParametros: String ;
begin
  LSql := TMySQLRepository.fGetSelectDinamico(FTipo, '001') ;

  LSqlParametros := fPreparaFiltroConsulta(ACodEmp, ADataIni, ADataFim, AChaveAcesso) ;
  LSql := ReplaceStr(LSql, REPLACE_PARAMETROS, LSqlParametros) ;

  LSqlParametros := fPreparaFiltroConsultaCanc(ACodEmp, ADataIni, ADataFim, AChaveAcesso) ;
  LSql := ReplaceStr(LSql, REPLACE_PARAMETROS_CANCELADO, LSqlParametros) ;

  LConsulta := fMultiCriaQuery() ;
  LConsulta.close ;
  LConsulta.SQL.Clear ;
  LConsulta.SQL.Add(LSql) ;
  if not Trim(ACodEmp).IsEmpty then
    LConsulta.ParamByName('CODEMP').AsString := ACodEmp ;
  if not Trim(AChaveAcesso).IsEmpty then
    LConsulta.ParamByName('ACESSO').AsString := AChaveAcesso ;
  if (ADataini > 0) and (ADataFim > 0) then
  begin
    LConsulta.ParamByName('DTAINI').AsDate := ADataini ;
    LConsulta.ParamByName('DTAFIM').AsDate := ADataFim ;
  end ;
  LConsulta.Open ;
  Result := LConsulta ;
end;

function TDadosDocumentosConhecimentoTransporte.fDocumentosJaProcessados(
  const ACodEmp: String; const ADataIni, ADataFim: TDateTime): TDataSet;
begin
  Result := self.fJaProcessados(ACodEmp, ADataIni, ADataFim) ;
end;

function TDadosDocumentosConhecimentoTransporte.fDocumentosProcessamentoPendente(
  const ACodEmp: String): TDataSet;
begin
  Result := self.fPendenteProcessamento(ACodEmp) ;
end;

{ TBaseDadosDocumentos }

function TBaseDadosDocumentos.fJaProcessados(const ACodEmp: String;
  const ADataIni, ADataFim: TDateTime): TDataSet;
var
  LConsulta: TUniQuery ;
begin
  LConsulta := fMultiCriaQuery() ;
  LConsulta.close ;
  LConsulta.SQL.Clear ;
  LConsulta.SQL.Add(' SELECT DOM_ACESSO, DOM_TIP_FC, DOM_STATNF ') ;
  LConsulta.SQL.Add(' FROM DOMPRO ') ;
  LConsulta.SQL.Add(' WHERE DOM_TIPCON = :TIPCON ') ;
  LConsulta.SQL.Add('       AND DOM_CODEMP = :CODEMP ') ;
  LConsulta.SQL.Add('       AND DOM_DTADOC BETWEEN :INI AND :FIM ') ;
  LConsulta.ParamByName('TIPCON').AsString := ABREV_TIPO_DOCUMENTO[FTipo] ;
  LConsulta.ParamByName('CODEMP').AsString := ACodEmp ;
  LConsulta.ParamByName('INI').AsDateTime := ADataIni ;
  LConsulta.ParamByName('FIM').AsDateTime := ADataFim ;
  LConsulta.Open ;
  Result := LConsulta ;
end;

function TBaseDadosDocumentos.fPendenteProcessamento(
  const ACodEmp: String): TDataSet;
var
  LConsulta: TUniQuery ;
begin
  LConsulta := fMultiCriaQuery() ;
  LConsulta.close ;
  LConsulta.SQL.Clear ;
  LConsulta.SQL.Add(' SELECT DOM_CODEMP, DOM_ACESSO, DOM_DTADOC, DOM_PROTOC ') ;
  LConsulta.SQL.Add(' FROM DOMPRO ') ;
  LConsulta.SQL.Add(' WHERE DOM_TIPCON = :TIPCON AND ') ;
  LConsulta.SQL.Add('       DOM_CODEMP = :CODEMP AND ') ;
  LConsulta.SQL.Add('       SUBSTRING(DOM_STATUS,1,3) = "SA1" ') ;
  LConsulta.ParamByName('TIPCON').AsString := ABREV_TIPO_DOCUMENTO[FTipo] ;
  LConsulta.ParamByName('CODEMP').AsString := ACodEmp ;
  LConsulta.Open ;
  Result := LConsulta ;
end;

function TBaseDadosDocumentos.fPreparaFiltroConsulta(const ACodEmp: String;
  const ADataIni, ADataFim: TDateTime; const AChaveAcesso: String): String;
begin
  Result := '' ;
  if not Trim(ACodEmp).IsEmpty then
    Result := Result + ' AND FIS_CODEMP = :CODEMP ' ;

  if not Trim(AChaveAcesso).IsEmpty then
    Result := Result + ' AND FIS_ACESSO = :ACESSO ' ;

  if (ADataini > 0) and (ADataFim > 0) then
    Result := Result + ' AND FIS_DTAENT BETWEEN :DTAINI AND :DTAFIM ' ;
end;

function TBaseDadosDocumentos.fPreparaFiltroConsultaCanc(const ACodEmp: String;
  const ADataIni, ADataFim: TDateTime; const AChaveAcesso: String): String;
begin
  Result := '' ;
  if not Trim(ACodEmp).IsEmpty then
    Result := Result + ' AND FIS_CODEMP = :CODEMP ' ;

  if not Trim(AChaveAcesso).IsEmpty then
    Result := Result + ' AND FIS_ACESSO = :ACESSO ' ;

  if (ADataini > 0) and (ADataFim > 0) then
    Result := Result + ' AND LOG_DTACAN BETWEEN :DTAINI AND :DTAFIM ' ;
end;

{ TDOMPRORepository }

constructor TDOMPRORepository.Create(Owner: TComponent; strDatabaseName,
  strUserName, strPassword, strPort, strIPServer: String);
begin
  FDriverID  := 'DriverID=MySQL';
  FDatabase  := 'Database=' + strDatabaseName;
  FUser_Name := 'User_Name=' + strUserName;
  FPassword  := 'Password=' + strPassword;
  FPort      := 'Port=' + strPort;
  FServer    := 'Server=' + strIPServer;

  FDDatabase   := TFDConnection.Create(Nil);
  FDDriverLink := TFDPhysMySQLDriverLink.Create(Nil);
  {$IFNDEF LINUX}
    FDCursor     := TFDGUIxWaitCursor.Create(Nil);
  {$ENDIF}
  FDDatabase.Params.Add(FDatabase);
  FDDatabase.Params.Add(FUser_Name);
  FDDatabase.Params.Add(FPassword);
  FDDatabase.Params.Add(FPort);
  FDDatabase.Params.Add(FServer);
  FDDatabase.Params.Add(FDriverID);

  FDDatabase.LoginPrompt := False;
  {$IFNDEF LINUX}
    if FileExists(ExtractFilePath(Application.ExeName) + 'libmysql57.dll') then
      FDDriverLink.VendorLib := ExtractFilePath(Application.ExeName) + 'libmysql57.dll'
    else
      FDDriverLink.VendorLib := ExtractFilePath(Application.ExeName) + 'libmysql41.dll';

  {$ELSE}
    FDDriverLink.VendorLib := 'libmysqlclient.so';
  {$ENDIF}
  FDDatabase.Connected := True;

  pDefinirTimeZoneEmSessaoMySql(FDDatabase, fMultiVS_strCodEmp);

end;

destructor TDOMPRORepository.Destroy;
begin
  FDDatabase.Connected := False;
  {$IFNDEF LINUX}
    FreeAndNil(FDCursor);
  {$ENDIF}
  FreeAndNil(FDDriverLink);
  FreeAndNil(FDDatabase);
  inherited;
end;

function TDOMPRORepository.fGravarEmBlocoNoBanco(
  const LDtoList: TObjectList<TDOMPRO>): Boolean;
var
  LintCnt, LBlockSize, LStartIndex: Integer;
  LqryLanCon: TFDQuery;
  LSQL: String ;
begin
  if LDtoList.Count = 0 then
    Exit(True) ;

  Result := False ;
  LBlockSize := 1000;
  LqryLanCon := TFDQuery.Create(nil);
  try
    try
      LqryLanCon.Connection := FDDatabase ;
      LqryLanCon.SQL.Clear ;

      LSQL := 'REPLACE INTO DOMPRO (DOM_CODEMP, DOM_TIPCON, DOM_ACESSO, DOM_TIP_FC, DOM_STATUS, ' +
             'DOM_CODOPE, DOM_DTPROC, DOM_HRPROC, DOM_PROTOC, DOM_DTADOC, DOM_STATNF) ' +
             'VALUES (:DOM_CODEMP, :DOM_TIPCON, :DOM_ACESSO, :DOM_TIP_FC, :DOM_STATUS, ' +
             ':DOM_CODOPE, :DOM_DTPROC, :DOM_HRPROC, :DOM_PROTOC, :DOM_DTADOC, :DOM_STATNF)';

      LqryLanCon.SQL.Add(LSQL) ;

      LqryLanCon.Params.ClearValues;
      LqryLanCon.ParamByName('DOM_CODEMP').DataType := ftString;
      LqryLanCon.ParamByName('DOM_TIPCON').DataType := ftString;
      LqryLanCon.ParamByName('DOM_ACESSO').DataType := ftString;
      LqryLanCon.ParamByName('DOM_TIP_FC').DataType := ftString;
      LqryLanCon.ParamByName('DOM_STATUS').DataType := ftString;
      LqryLanCon.ParamByName('DOM_CODOPE').DataType := ftString;
      LqryLanCon.ParamByName('DOM_DTPROC').DataType := ftDate;
      LqryLanCon.ParamByName('DOM_HRPROC').DataType := ftTime;
      LqryLanCon.ParamByName('DOM_PROTOC').DataType := ftString;
      LqryLanCon.ParamByName('DOM_DTADOC').DataType := ftDate;
      LqryLanCon.ParamByName('DOM_STATNF').DataType := ftString;

      for LStartIndex := 0 to (LDtoList.Count div LBlockSize) do
      begin
        LqryLanCon.Params.ArraySize := IfThen(LDtoList.Count - LStartIndex * LBlockSize < LBlockSize, LDtoList.Count - LStartIndex * LBlockSize, LBlockSize);
        for LintCnt := 0 to LqryLanCon.Params.ArraySize - 1 do
        begin
          LqryLanCon.ParamByName('DOM_CODEMP').AsStrings[LintCnt] := LDtoList[LStartIndex * LBlockSize + LintCnt].CodEmp;
          LqryLanCon.ParamByName('DOM_TIPCON').AsStrings[LintCnt] := LDtoList[LStartIndex * LBlockSize + LintCnt].TipCon;
          LqryLanCon.ParamByName('DOM_ACESSO').AsStrings[LintCnt] := LDtoList[LStartIndex * LBlockSize + LintCnt].Acesso;
          LqryLanCon.ParamByName('DOM_TIP_FC').AsStrings[LintCnt] := LDtoList[LStartIndex * LBlockSize + LintCnt].TipFC;
          LqryLanCon.ParamByName('DOM_STATUS').AsStrings[LintCnt] := LDtoList[LStartIndex * LBlockSize + LintCnt].Status;
          LqryLanCon.ParamByName('DOM_CODOPE').AsStrings[LintCnt] := LDtoList[LStartIndex * LBlockSize + LintCnt].CodOpe;
          LqryLanCon.ParamByName('DOM_DTPROC').AsDateTimes[LintCnt] := LDtoList[LStartIndex * LBlockSize + LintCnt].DtProc;
          LqryLanCon.ParamByName('DOM_HRPROC').AsDateTimes[LintCnt] := LDtoList[LStartIndex * LBlockSize + LintCnt].HrProc;
          LqryLanCon.ParamByName('DOM_PROTOC').AsStrings[LintCnt] := LDtoList[LStartIndex * LBlockSize + LintCnt].Protoc;
          LqryLanCon.ParamByName('DOM_DTADOC').AsDateTimes[LintCnt] := LDtoList[LStartIndex * LBlockSize + LintCnt].DtaEnt;
          LqryLanCon.ParamByName('DOM_STATNF').AsStrings[LintCnt] := LDtoList[LStartIndex * LBlockSize + LintCnt].StatNf;
        end;
        LqryLanCon.Execute(LqryLanCon.Params.ArraySize, 0);
      end;

      Result := True;
    except
      on E: Exception do
      begin
        // Em caso de erro, retorne False e você pode logar ou mostrar a mensagem
        raise Exception.Create('Erro ao gravar em bloco: ' + E.Message);
      end;
    end;
  finally
    FreeAndNil(LqryLanCon) ;
  end ;
end;

function TDOMPRORepository.fTimeZoneConfigurado(
  const ACodigoEmpresa: String): Integer;
Var
  LTimeZone : String;
begin
  Result := 0;

  If (Not fConfiguracaoExiste('TMZONE', ACodigoEmpresa)) Then
    Exit;

  LTimeZone := fMultiCfgSis('TMZONE', varString, ACodigoEmpresa);

  If (LTimeZone.IsEmpty) Then
    Exit;

  Result := StrToIntDef(LTimeZone, 0);
end;

procedure TDOMPRORepository.pDefinirTimeZoneEmSessaoMySql(
  const AConnection: TFDConnection; const ACodigoEmpresa: String);
Var
  LQryTimeZone : TFDQuery;
  LUsaTimeZone : String;
begin
  If ACodigoEmpresa.IsEmpty Then
    Exit;
  If (Not fConfiguracaoExiste('USATMZ', ACodigoEmpresa)) Then
    Exit;
  LUsaTimeZone := fMultiCfgSis('USATMZ', varString, ACodigoEmpresa);
  If (LUsaTimeZone.IsEmpty) Or (LUsaTimeZone = 'N') Then
    Exit;
  LQryTimeZone := TFDQuery.Create(Nil);
  Try
    LQryTimeZone.Connection := AConnection;
    LQryTimeZone.SQL.Text := Format('SET time_zone = %s;', [QuotedStr(fCfgTmZoneToMySqlFormatTimeZone(ACodigoEmpresa))]);
    LQryTimeZone.ExecSQL;
  Finally
    FreeAndNil(LQryTimeZone);
  End;
end;

function TDOMPRORepository.fCfgTmZoneToMySqlFormatTimeZone(
  const ACodigoEmpresa: String): String;
Const
  arrTimeZonesPemrmitidos : Array [1..4] Of Integer = (-2, -3, -4, -5);
Var
  LTimeZoneConfigurado : Integer;
  LContador : Integer;
begin
  Result := '-3:00';
  If ACodigoEmpresa.IsEmpty Then
    Exit;
  LTimeZoneConfigurado := fTimeZoneConfigurado(ACodigoEmpresa);
  If LTimeZoneConfigurado = 0 Then
    Exit;
  For LContador := Low(arrTimeZonesPemrmitidos) To High(arrTimeZonesPemrmitidos) Do
  Begin
    If (arrTimeZonesPemrmitidos[LContador] = LTimeZoneConfigurado) Then
    Begin
      Result := Format('%d:00', [LTimeZoneConfigurado]);
      Exit;
    End;
  End;
end;

function TDOMPRORepository.fConfiguracaoExiste(strCodCfg: string; strCodEmp: string = ''): boolean;
begin
  if Trim(strCodEmp).IsEmpty then
    strCodEmp := fMultiVS_strCodEmp;

  Result := (fMultiCampoTabela('COUNT(*)', 'CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP'], ['CFG_' + strCodCfg, strCodEmp], False) > 0);
end;

end.
