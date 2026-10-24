unit untUtilBDEnt;

interface

uses
{$IFDEF LINUX}
{$ELSE}
  Windows,
  Forms,
  Dialogs,
{$ENDIF}
  SysUtils,
  untInterfaces,
  DB,
  untConfigNFe,
  untDicSis,

{$IF Defined(VER250) Or Defined(UNIDAC) Or Defined(VER300)}
  Uni, MySQLUniProvider, AnsiStrings, System.Generics.Collections,
{$ELSE}
  ZDataset, ZConnection,
{$IFEND}

  untFonteDados,
  Classes,
  Contnrs,
  untManifestoEletronico,
  untInterfacesManifestoEletronico,
  Math,
  Types;

Type
  TValorAliquotaIBPT = Record
    fltNacional : Double;
    fltImportado : Double;
    fltEstadual : Double;
    fltMunicipal : Double;
End;

Type
  TTipoAliquotaIBPT = (alNacional, alImportado, alEstadual, alMunicipal);

Type
  TArrDigDuplic = Record
    intNumDup:  Int64;
    strSequen: String;
    curValor : Currency;
    dtaDtaVen: String;
    strUsaChq: String;
    strHist02: String;
  End;

  TarrDuplicata = Array[0..23] Of TArrDigDuplic;

  TFonteDadosBDEnt = class(TInterfacedObject, IFonteDados, IFonteDadosManifesto)
    private
      {$IF Defined(VER250) Or Defined(UNIDAC) Or Defined(VER300)}
        Database: TUniConnection;
        MySQLUniProvider: TMySQLUniProvider;        
        qryDados: TUniQuery;
        qryDuplicatas: TUniQuery;
        qryItensNotaComp: TUniQuery;
        qryChavesReferenciadas: TUniQuery;
      {$ELSE}
        Database: TZConnection;
        qryDados: TZQuery;
        qryDuplicatas: TZQuery;
        qryItensNotaComp: TZQuery;
        qryChavesReferenciadas: TZQuery;
      {$IFEND}
      FNumDoc  : String;
      FEspDoc  : String;
      FCodEmp  : String;
      FCodCli  : String;
      FSerie   : String;
      FTip_FC  : String;
      FEmitente: Boolean;
      FArqEnt  : String;
      FEmiEnt  : Boolean;

      FChaAce: String;
      FChaTabela: String;

      dadosEmitente: TDadosEmitente;
      dadosGerais: TDadosGerais;

      intPosAtual: Integer;
      lstItens: TObjectList;

      blnCliConNC: Boolean;
      blnTrSeCi : Boolean;
      blnDupCND : Boolean;

      arrDuplicataCND : TarrDuplicata;

      procedure pCarregaDuplicatas(dadosGerais: TDadosGerais);
      procedure pCarregaDuplicatasOutrasNotas(dadosGerais: TDadosGerais);
      procedure pCarregaTotalDuplicataRecebida(dadosGerais: TDadosGerais);
      procedure pRetornaDadosIbge(strCodCid: String; Var strCodIbge, strUfIbge, strEstado, strCidade: String);
      procedure pRetDadosNotaOrigem(Var dtaDtaDoc: TDateTime);
      procedure pRetAlqPisCofins(Var fltAlqPis, fltAlqCof: Double);
      procedure pCarregaCfgDesFab(Var blnDesFab: Boolean);
      procedure pRetClassificacoesDevolucao;

      procedure pCarregarDocumentoImportacao(dadosItem: TDadosItem; strAutIncDet: String);

      function fRetDesCla(strCodCfo: String): String;
      function fNotaComplemento(strNumDoc, strEspDoc, strCodEmp, strCodCli,
        strSerie, strTip_FC: String): Boolean;
      procedure pCarregaItensNotaComp(dadosGerais: TDadosGerais; strAutIncCadFis: String);
      function fAdicionaItem(intIndice, intIndColSer: Integer): TDadosItem;
      function fAdicionaItemServico(intIndice, intIndColSer: Integer): TDadosItem;

      function fConfiguracao(strCodCfg: String): String;
      function fAtividadeConstrutora(strCodAti: String): Boolean;
      function fRetAtividades: String;

      procedure pAdicionaItensNaLista;
      procedure pAdicionaServicosNaListaDeItens(intIndInicial: Integer);
      procedure pRetCstSimplesProdSubstituidos;
      procedure pRetCfgImpValorIpiDadosPropriosCFOPNaoVenda;
      {$HINTS OFF}
      function fClienteFilial(Const strCodCli: String): Boolean;
      function fRetDesCndPagamento(strCodCnd: String): String;
      {$HINTS ON}
      function fEmiteNCMPorLinhaDeTinta: Boolean;
      function fClaFisGarantia:String;
      procedure pCarregaConfiguracoesNotaServico;
      procedure pCarregaAtividadeConstrutora;
      procedure pCarregaEmpresaNFSe;
      procedure pVerificaSeImprimePalavraAVistaDuplicata(dadosGerais: TDadosGerais);
      {$HINTS OFF}
      procedure pPegaNumeroPedidosFaturados(dadosGerais: TDadosGerais);
      {$HINTS ON}
      function fRetornaChaveAcesso: String;

      function fGetQuantidadeItensServico: Integer;

      function fTiraPipeEnter(const strTexto: String): String;
      function fCriaQuery(Owner: TComponent): {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
      procedure pCarregaDadosNFSeSubstituicao(var dadosGerais: TDadosGerais;
        strAutInc: String);
      procedure pCarregaChavesReferenciadas(dadosGerais: TDadosGerais);
      procedure pCarregaChavesReferenciadasAKZ(strNumDoc,strEspDoc,strCodEmp: String);
      {$HINTS OFF}
      function fRetornaInscSubstitutoTributarioEmpresa(strEmpresa, strEstadoDestino: String): String;
      {$HINTS ON}
      function fRetPontoVendaNFCe: String;

      function fGetDocumentoRemessaConcreto(intSeqCcr: Integer): String;

      procedure pCarregarFormasPagamento(dadosGerais: TDadosGerais);
      {$HINTS OFF}
      procedure pLogarPerformance(objeto: TObject);
      function fCriaObjetoLogPerformance(intCodigo: Integer; strMensagem: String): TLogPerformance;
      {$HINTS ON}
      function fBuscaAlqIBPT(strNcm: String; blnImport: Boolean): Double; Overload;
      function fBuscaAlqIBPT(strNcm: String; strEx: String; strCodEmp: String): TValorAliquotaIBPT; Overload;
      function fRetornaPercetualDevolvido(qryDados: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND}): Double;
      function fArredondaABNT_NBR5891_77(fltValor: Double;
        intDecimais: Integer): Double;
      function fParteInteira(fltValor: Double): Double;
      function fRemoveDizimas(fltValor: Double; intDecimais: Integer): Double;
      function fRetSQLMsg1e2TipAbfdeSAI(strTip: String): String;
      procedure pCarregaDuplicatasCND(strTabela, strAutoincrem:String);
    public
      constructor Create(Database: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND}; strNumDoc, strEspDoc,
        strCodEmp, strCodCli, strSerie, strTip_FC: String; blnEmitente: Boolean=False; strArqEnt: String = ''); overload;
      constructor Create(Database: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND}); overload;
      destructor Destroy; override;

      procedure pCarregarDados;
      procedure pInicio;
      function fDadosEmitente: TDadosEmitente;
      function fDadosGerais: TDadosGerais;
      function fTemDados: Boolean;
      function fProximoItem: TDadosItem;

      function fChaveAcesso: String;
      function fNotaServicoEletronica: Boolean;
      function fNotaServicoEletronicaConcreto: Boolean;

      function fRetornaEstadoEmpresa(strCnpj: String): String;
      procedure pCarregaConfiguracoes;

      function fGetTipAbfSaida(strFisJur, strIES, strProRur, strMicEmp, strConsum, strCodAti, strRegTri, strIndust: String; blnCliFil: Boolean): String;
      procedure pAtualizaObraArtigo(strCodObr, strCodArt, strNumDoc, strEspDoc, strCodEmp, strCodCli, strTip_Fc: String);
      function fGetEntGer(strNumDoc, strEspDoc, strCodEmp, strCodCli, strTip_Fc: String): String;
      function fGetCampoValor(strCampoRetorno, strCampoChave, strValorChave, strTabela: String): String;
      function fGetCodObr: String;
      function fGetCodArt: String;

      function fGetManifesto(strNumeroManifesto: String): TManifestoEletronico;
      function fGetManifestoCompacto(strNumeroManifesto: String): TManifestoEletronico;
      function fGetDadosAdicionaisReferenteAEntrega : String;

      function fSuportaOperacaoBanco: Boolean;

      function fExecutaQuery(strSQL: String; arrParametros: Array Of String; arrValores: Array Of Variant): TDataSet;
      function fCampoExiste(const strTabela, strCampo: String): Boolean;
      function fTabelaExiste(strNomeTabela: String): Boolean;

      procedure pCarregaConfiguracoesInternas(Var objConfig: TConfiguracoesInternas);

      function fCampoTabela(strCampo : String;
                            strNomTab: String;
                            arrCampoChave: Array Of String;
                            arrValorChave: Array Of Variant): Variant;
      procedure pSalvarXMLNFeBD(AChaveAcesso, AXML: string; AXMLJaBaixado: String = '');
      function XMlJaBaixado(AChaveAcesso: string): Boolean;
      function fNFSemItens: Boolean;
      procedure pNFCeOffLineConfiguracoes(strCodEmp: String);
      function fChaveTabela: String;
      procedure pGravaTabela(objItem: TDadosItem; strTabela: String);
      procedure pGravaIcmsDesonerado(strTabela, strAutInc, strMtdIcm: String; fltIcmDes: Double);
      function fConfiguracaoExiste(strCodCfg: String): Boolean;
      function PDFJaBaixado(AChaveAcesso: string): Boolean;
      procedure pSalvarPDFNFeBD(AChaveAcesso, APDF: string; APDFJaBaixado: String = '');
      function fUsaNotaServicoEletronicaEnotas: Boolean;
      function CarregarPDF(AChaveAcesso, ANomeArquivo: string; AExtensao: Boolean; AIgnorarLayoutSimplificado: Boolean): string;
      procedure pGravarLogNfe(strNumDoc, strEspDoc, strCodEmp, strSerie,
                              strCodCli, strTip_FC, strStatus, strObserv: String;
                              strChaAce: String=''; dtaDtaAut: TDateTime=0; strPonImp: String='');
      procedure pAtualizaDadosAutorizacaoNFe(Const strChaveAcesso, strProtocolo, strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC: String);
      function fRetornaDocumentoImpresso(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC: String): Boolean;
      procedure pGravaDocumentoImpresso(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC: String);
      procedure pGravaDocumentoPainelCitel(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, strProtoc, strTipInt: String);
      procedure pSalvarXmlDfeBD(ATipDfe, AChaveAcesso, AProtocolo, AXml: string);
      procedure pSetaIndicadorIntegracaoCitel(const AstrIntegradorCitel: String='S');
      procedure pSetaPathSatCitel(const AstrPathSatCitel: String='');
      procedure pGravarLogFit(strNumDoc, strEspDoc, strCodEmp, strSerie_, strForCli, strTip_FC, strTipArq, strArquiv: String);
      procedure pAtualizaDataDeAutorizacao(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli: String);
      function GetTemPerfilAduaneiro: Boolean;
      {$IF Defined(UNIDAC)}
      function fRetDataBase: TUniConnection;
      {$IFEND}
  End;

implementation

uses StrUtils, untUtil, untTipoFreteAtc, untConstantesNFe;

{ TFonteDadosBDEnt }

constructor TFonteDadosBDEnt.Create(Database: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND}; strNumDoc,
  strEspDoc, strCodEmp, strCodCli, strSerie, strTip_FC: String;
  blnEmitente: Boolean=False; strArqEnt: String = '');
  const
    MAX_NFE_NUMDOC = 999999999;//Limite de 9 digitos NFe

  Var
    intCodAut : Integer;

  function fUsarSenhaDLL(strPathIni: String): Boolean;
  begin
    Result := (intCodAut > 0) And (FileExists(strPathIni + 'libUtil.dll'));
  end;

  procedure DefineIsolationLevel;
    Var
      qryIsolation: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  begin
    qryIsolation := fCriaQuery(Nil);
    try
      qryIsolation.SQL.Text := DEFAULT_ISOLATION_LEVEL_SQL_INSTRUCTION;
      qryIsolation.ExecSQL;
    finally
      FreeAndNil(qryIsolation);
    end;
  end;

  procedure pDefinirCharsetConexao;
    Var
      qryGen: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  begin
    qryGen := fCriaQuery(Nil);

    Try
      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SET character_set_connection = LATIN1');
        ExecSQL;

        SQL.Clear;
        SQL.Add('SET character_set_client = LATIN1');
        ExecSQL;

        SQL.Clear;
        SQL.Add('SET character_set_database = LATIN1');
        ExecSQL;

        SQL.Clear;
        SQL.Add('SET character_set_results = LATIN1');
        ExecSQL;

        SQL.Clear;
        SQL.Add('SET character_set_server = LATIN1');
        ExecSQL;

        SQL.Clear;
        SQL.Add('SET collation_connection = latin1_swedish_ci');
        ExecSQL;

        SQL.Clear;
        SQL.Add('SET collation_database = latin1_swedish_ci');
        ExecSQL;

        SQL.Clear;
        SQL.Add('SET collation_server = latin1_swedish_ci');
        ExecSQL;
      End;

    Finally
      FreeAndNil(qryGen);
    End;

  end;

  function fConectar: Boolean;
    {$IF Defined(VER250) Or Defined(UNIDAC)}
    Var
      strPathIni : String;
      libUtil: Cardinal;
      fRetornaUsuario: function: PAnsiChar; stdcall;
      fRetornaSenha: function: PAnsiChar; stdcall;
      pSetaArquivoOpcoes: procedure(strArquivo: PAnsiChar); stdcall;
      arrStr: Array [0..255] Of AnsiChar;
    {$IFEND}
  begin
    Result := False;

    {$IF Defined(VER250) Or Defined(UNIDAC)}
    strPathIni := fPathOpcoesIni;

    If (Not fEmptyStr(strPathIni)) Then
    Begin
      Result := True;
      Self.Database.Disconnect;
      Self.Database.ProviderName := 'MySQL';
      Self.Database.Database := '';
      Self.Database.Server   := '';

      intCodAut := StrToIntDef(fArqIniLocal(0, 'GERAL', 'CODAUT', '0', strPathIni), 0);

      If fUsarSenhaDLL(AnsiReplaceStr(strPathIni, 'opcoes.ini', '')) Then
      Begin
        libUtil := LoadLibrary(PChar(AnsiReplaceStr(strPathIni, 'opcoes.ini', '') + 'libUtil.dll'));
        Try
          fRetornaUsuario := GetProcAddress(libUtil, PChar('fRetornaUsuarioPChar'));
          fRetornaSenha   := GetProcAddress(libUtil, PChar('fRetornaSenhaPChar'));
          pSetaArquivoOpcoes := GetProcAddress(libUtil, PChar('pSetaArquivoOpcoesPChar'));

          If Assigned(pSetaArquivoOpcoes) Then
          Begin
            pSetaArquivoOpcoes(AnsiStrings.StrPCopy(arrStr, AnsiString(strPathIni)));
          End;

          Self.Database.Username := String(AnsiStrings.StrPas(fRetornaUsuario));
          Self.Database.Password := String(AnsiStrings.StrPas(fRetornaSenha));

        Finally
          FreeLibrary(libUtil);
        End;
      End
      Else
      Begin
        Self.Database.Username := 'root';
        Self.Database.Password := 'citel13347';
      End;

      Self.Database.Server   := AnsiReplaceStr(fArqIniLocal(0, 'BANCO', 'NUMIP', '', strPathIni), ' ', '');
      Self.Database.Database := fArqIniLocal(0, 'BANCO', 'NOMBAN', '', strPathIni);
      Self.Database.Port     := StrToIntDef(AnsiReplaceStr(fArqIniLocal(0, 'BANCO', 'PORTA', '3306', strPathIni), ' ', ''), 3306);
      Self.Database.Connect;

      pGeraRegistroParaLogGeneral(Self.Database, 'Inicializacao', True);

      {$IF not Defined(LINUX)}
      pDefinirCharsetConexao;
      {$IFEND}
      DefineIsolationLevel;
    End;
    {$IFEND}
  End;

begin
  {$IF Defined(VER250) Or Defined(UNIDAC)}
    Self.Database := TUniConnection.Create(Nil);
    Self.MySQLUniProvider := TMySQLUniProvider.Create(Self.Database);
    Try
      fConectar;
    Except
      On E: EAccessViolation Do
      Begin
        Raise;
      End;
    End;
  {$ELSE}
    Self.Database := Database;
  {$IFEND}

  If (fEmptyStr(strArqEnt)) And (Not fEmptyStr(strNumDoc)) And (StrToInt64Def(strNumDoc, MAXINT) > MAX_NFE_NUMDOC) Then
    Raise Exception.Create('Número do documento (' + strNumDoc +') excede o limite disponível. Verifique!');

  FNumDoc := strNumDoc;
  FEspDoc := strEspDoc;
  FCodEmp := strCodEmp;
  FCodCli := strCodCli;
  FSerie  := strSerie;
  FTip_FC := strTip_FC;
  FEmitente := blnEmitente;
  blnDupCND := False;
  FArqEnt   := strArqEnt;
  FEmiEnt   := Not fEmptyStr(FArqEnt);

  If (blnEmitente) Then
  Begin
    dadosGerais := TDadosGerais.Create;
    dadosGerais.strNumDoc := strNumDoc;
    dadosGerais.strEspDoc := strEspDoc;
    dadosGerais.strCodEmp := strCodEmp;
    dadosGerais.strCodCli := strCodCli;
    dadosGerais.strSerie  := strSerie;

    dadosGerais.strTemRefFis := 'N';
  End;

  lstItens := TObjectList.Create;

  pCarregaConfiguracoes;
end;

constructor TFonteDadosBDEnt.Create(Database: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND});
begin
  Create(DataBase, '', '', objConfig.strCodEmp, '', '', '', True);
end;

destructor TFonteDadosBDEnt.Destroy;
begin
  If Assigned(qryDados) Then
    FreeAndNil(qryDados);

  If Assigned(qryDuplicatas) Then
    FreeAndNil(qryDuplicatas);

  If Assigned(qryItensNotaComp) Then
    FreeAndNil(qryItensNotaComp);

  If Assigned(qryChavesReferenciadas) Then
    FreeAndNil(qryChavesReferenciadas);

  If Assigned(lstItens) Then
  Begin
    lstItens.Clear;
    FreeAndNil(lstItens);
  End;

  If Assigned(dadosGerais) Then
    FreeAndNil(dadosGerais);

  If Assigned(dadosEmitente) Then
    FreeAndNil(dadosEmitente);

  {$IF Defined(VER250) Or Defined(UNIDAC)}
    pGeraRegistroParaLogGeneral(Self.Database, 'TFonteDadosBDEnt.Destroy > Self.Database.Disconnect', True);

    Self.Database.Disconnect;
    FreeAndNil(Self.Database);
  {$IFEND}

  inherited Destroy;
end;

function TFonteDadosBDEnt.fChaveAcesso: String;
begin
  Result := FChaAce;
end;

function TFonteDadosBDEnt.fChaveTabela: String;
begin
  Result := FChaTabela;
end;

function TFonteDadosBDEnt.fClaFisGarantia: String;
  Var
    strVal: String;
begin
  Result := '';

  strVal := fConfiguracao('CLARGF');

  If (Not fEmptyStr(strVal)) Then
    Result := '5' + strVal + '_6' + strVal;
end;

function TFonteDadosBDEnt.fClienteFilial(const strCodCli: String): Boolean;
  Var
    qryEmp: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryEmp := fCriaQuery(Nil);

  qryEmp.SQL.Add('SELECT COUNT(*) AS QTD FROM CADEMP WHERE EMP_CLIFIL = :CODCLI');
  qryEmp.ParamByName('CODCLI').AsString := strCodCli;
  qryEmp.Open;

  Result := (qryEmp.FieldByName('QTD').AsInteger > 0);

  FreeAndNil(qryEmp);
end;

function TFonteDadosBDEnt.fDadosEmitente: TDadosEmitente;
  Var
    qryDadosEmit: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    blnUsaCadastroInscricaoSubstituto: Boolean;
begin
  If (Not Assigned(dadosEmitente)) Then
  Begin
    blnUsaCadastroInscricaoSubstituto := False;
    If Assigned(qryDados) Then
      If qryDados.Active Then
        If fTabelaExiste('EMPISB') Then
          blnUsaCadastroInscricaoSubstituto := True;

    qryDadosEmit := fCriaQuery(Nil);
    qryDadosEmit.SQL.Add('SELECT ');
    qryDadosEmit.SQL.Add('  E.EMP_C_G_C_, ');
    qryDadosEmit.SQL.Add('  E.EMP_NOMEMP, ');
    qryDadosEmit.SQL.Add('  E.EMP_NOMFAN, ');
    qryDadosEmit.SQL.Add('  E.EMP_ENDERE, ');
    qryDadosEmit.SQL.Add('  E.EMP_ENDNUM, ');
    qryDadosEmit.SQL.Add('  E.EMP_ENDCMP, ');
    qryDadosEmit.SQL.Add('  E.EMP_BAIRRO, ');
    qryDadosEmit.SQL.Add('  E.EMP_CODCID, ');
    qryDadosEmit.SQL.Add('  E.EMP_C_E_P_, ');
    qryDadosEmit.SQL.Add('  E.EMP_FONE01, ');
    qryDadosEmit.SQL.Add('  E.EMP_I_E_S_, ');

    If blnUsaCadastroInscricaoSubstituto Then
      qryDadosEmit.SQL.Add(' (SELECT I.EMP_INSSUB FROM EMPISB I WHERE I.EMP_CODEMP = E.EMP_CODEMP AND I.EMP_ESTADO = :ESTCON LIMIT 1) AS EMP_INSSUB, ')
    Else If fCampoExiste('CADEMP', 'EMP_INSSUB') Then
      qryDadosEmit.SQL.Add(' E.EMP_INSSUB, ')
    Else
      qryDadosEmit.SQL.Add(' CAST("" AS CHAR(1)) AS EMP_INSSUB, ');

    qryDadosEmit.SQL.Add('  E.EMP_CODEMP, ');

    qryDadosEmit.SQL.Add('  E.EMP_INSMUN, ');
    qryDadosEmit.SQL.Add('  E.EMP_CNAEFI, ');
    qryDadosEmit.SQL.Add('  E.EMP_EMAIL_, ');
    qryDadosEmit.SQL.Add('  C.CID_COIBGE, ');
    qryDadosEmit.SQL.Add('  C.CID_NOMCID, ');
    qryDadosEmit.SQL.Add('  C.CID_ESTADO, ');
    qryDadosEmit.SQL.Add('  (SELECT IBG_CODUF_ FROM IBG_CADIBG I WHERE I.IBG_CODMUN = C.CID_COIBGE LIMIT 1) AS IBG_CODUF_ ');
    qryDadosEmit.SQL.Add('FROM ');
    qryDadosEmit.SQL.Add('  CADEMP E INNER JOIN CADCID C ON C.CID_CODCID = E.EMP_CODCID ');
    qryDadosEmit.SQL.Add('WHERE ');
    qryDadosEmit.SQL.Add('  E.EMP_CODEMP = :CODEMP ');

    qryDadosEmit.ParamByName('CODEMP').AsString  := objConfig.strCodEmp;
    If blnUsaCadastroInscricaoSubstituto Then
      qryDadosEmit.ParamByName('ESTCON').AsString := qryDados.FieldByName('GER_ESTCON').AsString;

    qryDadosEmit.Open;

    dadosEmitente := TDadosEmitente.Create;

    dadosEmitente.strCnpj               := qryDadosEmit.FieldByName('EMP_C_G_C_').AsString;
    dadosEmitente.strRazao              := qryDadosEmit.FieldByName('EMP_NOMEMP').AsString;
    dadosEmitente.strFantasia           := qryDadosEmit.FieldByName('EMP_NOMFAN').AsString;
    dadosEmitente.strEndereco           := qryDadosEmit.FieldByName('EMP_ENDERE').AsString;
    dadosEmitente.strNumeroEnd          := qryDadosEmit.FieldByName('EMP_ENDNUM').AsString;
    dadosEmitente.strComplementoEnd     := qryDadosEmit.FieldByName('EMP_ENDCMP').AsString;
    dadosEmitente.strCodIbge            := qryDadosEmit.FieldByName('CID_COIBGE').AsString;
    dadosEmitente.strUfIbge             := qryDadosEmit.FieldByName('IBG_CODUF_').AsString;
    dadosEmitente.strBairro             := qryDadosEmit.FieldByName('EMP_BAIRRO').AsString;
    dadosEmitente.strNomeCidade         := qryDadosEmit.FieldByName('CID_NOMCID').AsString;
    dadosEmitente.strEstado             := qryDadosEmit.FieldByName('CID_ESTADO').AsString;
    dadosEmitente.strCep                := qryDadosEmit.FieldByName('EMP_C_E_P_').AsString;
    dadosEmitente.strCodigoPais         := consCodIbgeBrasil;
    dadosEmitente.strNomePais           := 'BRASIL';
    dadosEmitente.strTelefone           := qryDadosEmit.FieldByName('EMP_FONE01').AsString;
    dadosEmitente.strIES                := qryDadosEmit.FieldByName('EMP_I_E_S_').AsString;
    dadosEmitente.strIESST              := qryDadosEmit.FieldByName('EMP_INSSUB').AsString;

    dadosEmitente.strInscricaoMunicipal := qryDadosEmit.FieldByName('EMP_INSMUN').AsString;
    dadosEmitente.strCNAEFiscal         := qryDadosEmit.FieldByName('EMP_CNAEFI').AsString;
    dadosEmitente.strEMail              := qryDadosEmit.FieldByName('EMP_EMAIL_').AsString;

    FreeAndNil(qryDadosEmit);
  End;

  Result := dadosEmitente;
end;

function TFonteDadosBDEnt.fDadosGerais: TDadosGerais;
  Var
    strCodIbge: String;
    strUfIbge: String;
    strEstado: String;
    strCidade: String;
    intLivFis: Integer;

    function fRetDesPai(strCodPai: String): String;
      Var
        qryGen: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    Begin
      Result := '';

      If fEmptyStr(strCodPai) Then
      Begin
        Exit;
      End;

      If (consCodIbgeBrasil = strCodPai) Then
      Begin
        Result := 'BRASIL';
        Exit;
      End;

      qryGen := fCriaQuery(Nil);
      Try
        qryGen.SQL.Clear;
        qryGen.SQL.Add('SELECT IBG_NOMPAI FROM IBG_CADPAI WHERE IBG_CODPAI = :CODPAI');
        qryGen.ParamByName('CODPAI').AsString := strCodPai;
        qryGen.Open;

        Result := qryGen.FieldByName('IBG_NOMPAI').AsString;
      Finally
        FreeAndNil(qryGen);
      End;
    End;

    function fPermitirFreteEmVendaPresencial: Boolean;
      Var
        strVal: String;
    Begin
      Result := True;

      If (Not dadosGerais.blnVenPre) Then
        Exit;

      strVal := fConfiguracao('FREPRE');
      Result := strVal = 'S';
    End;

    Function fValidaServicoIES(strClafis, strIES, strUF: String) : String;
    Begin
      Result := strIES;

      If Pos('933',strClafis) > 0 Then
        If Not fValidaIES(strIES, strUF) Then
          Result := '';
    End;

    Function fValidaServicoCEP(strClafis, strCEP: String) : String;
    Begin
      Result := strCEP;

      If Pos('933',strClafis) > 0 Then
        If Length(strCEP) < 8 Then
          Result := '00000000';
    End;

    Function fValidaServicoSerieNF(strClafis, strSerie: String) : String;
    Begin
      Result := strSerie;

      If Pos('933',strClafis) > 0 Then
        If fEmptyStr(strSerie) Or (strToIntDef(strSerie,0)=0) Then
          Result := '000';
    End;

begin
  If (Not Assigned(dadosGerais)) And (Assigned(qryDados)) Then
  Begin
    dadosGerais := TDadosGerais.Create;

    If qryDados.FieldByName('GER_ESTCON').AsString = 'EX' Then
    Begin
      strCodIbge := '9999999';
      dadosGerais.strNomeCidade := 'EXTERIOR';
      strUfIbge  := 'EX'
    End
    Else
    Begin
      pRetornaDadosIbge(qryDados.FieldByName('GER_CIDCON').AsString, strCodIbge, strUfIbge, strEstado, strCidade);
      dadosGerais.strNomeCidade       := qryDados.FieldByName('GER_NOMCID').AsString;
    End;

    If (qryDados.FindField('GER_OPCDOC') <> Nil) Then
      dadosGerais.strOpcDoc := qryDados.FindField('GER_OPCDOC').AsString;

    dadosGerais.strCodCli           := qryDados.FieldByName('FIS_FORCLI').AsString;
    dadosGerais.strNomCli           := fTiraPipeEnter(qryDados.FieldByName('GER_NOMCON').AsString);

    dadosGerais.strCnpj             := qryDados.FieldByName('GER_CGCCON').AsString;

    If (Assigned(qryDados.FindField('GER_MATREV'))) Then
      dadosGerais.strMatRev := qryDados.FieldByName('GER_MATREV').AsString
    Else
      dadosGerais.strMatRev := '';

    If (fEmptyStr(dadosGerais.strCnpj)) And (FTip_FC = 'C') And
       (Pos(dadosGerais.strOpcDoc, 'DV_NW_') > 0) And
       ((fConfiguracao('CPFSDV') = 'S') Or (fConfiguracao('CNPSDV') = 'S')) And
       (fCampoExiste('CADCLI', 'CLI_CPFDEV')) Then
    Begin
      dadosGerais.strCnpj := fCampoTabela('CLI_CPFDEV', 'CADCLI', ['CLI_CODCLI'], [dadosGerais.strCodCli]);
    End;

    If (Not fEmptyStr(dadosGerais.strCnpj)) And (FTip_FC = 'C') And
       (Pos(dadosGerais.strEspDoc, 'IF_IV_') > 0) And
       (fConfiguracao('NFPCLI') = 'S') And (fCampoExiste('AUXMOV', 'AUX_NOTPAU')) Then
    Begin
      If qryDados.FieldByName('GER_NOTPAU').AsString = 'N' Then
        dadosGerais.strCnpj := '';
    End;

    dadosGerais.strLogradouro       := fTiraPipeEnter(qryDados.FieldByName('GER_ENDERE').AsString);
    dadosGerais.strNumeroEnd        := fTiraPipeEnter(qryDados.FieldByName('GER_ENDNUM').AsString);
    dadosGerais.strComplementoEnd   := fTiraPipeEnter(qryDados.FieldByName('GER_ENDCOM').AsString);
    dadosGerais.strBairro           := fTiraPipeEnter(qryDados.FieldByName('GER_BAICON').AsString);
    dadosGerais.strCodIbge          := strCodIbge;
    dadosGerais.strUfIbge           := strUfIbge;
    dadosGerais.strEstado           := qryDados.FieldByName('GER_ESTCON').AsString;

    dadosGerais.strCEP              := fValidaServicoCEP(qryDados.FieldByName('GER_CLAFIS').AsString, qryDados.FieldByName('GER_CEPCON').AsString);
    dadosGerais.strTelefone         := qryDados.FieldByName('GER_TELCON').AsString;
    dadosGerais.strIES              := fValidaServicoIES(qryDados.FieldByName('GER_CLAFIS').AsString, qryDados.FieldByName('GER_IESCON').AsString, strEstado);
    dadosGerais.strInscMunicipal    := qryDados.FieldByName('GER_IMPCON').AsString;
    dadosGerais.strEmail            := fTiraPipeEnter(qryDados.FieldByName('GER_EMAIL_').AsString);
    dadosGerais.strEmail2           := fTiraPipeEnter(qryDados.FieldByName('GER_EMAIL2').AsString);

    If (Pos(dadosGerais.strEstado, 'AC_AM_AP_RO_RR_') > 0) Then
      dadosGerais.strSuframa        := fTiraPipeEnter(qryDados.FieldByName('GER_SUFRAM').AsString);

    If Not fEmptyStr(qryDados.FieldByName('GER_CLIORI').AsString) Then
    Begin
      dadosGerais.strEmail          := fGetCampoValor('CLI_EMAIL3', 'CLI_CODCLI', qryDados.FieldByName('GER_CLIORI').AsString, 'CADCLI');
      dadosGerais.strEmail2         := fGetCampoValor('CLI_EMAIL2', 'CLI_CODCLI', qryDados.FieldByName('GER_CLIORI').AsString, 'CADCLI');
    End;

    dadosGerais.strCodigoPais       := qryDados.FieldByName('GER_CODPAI').AsString;
    dadosGerais.strNomePais         := fRetDesPai(qryDados.FieldByName('GER_CODPAI').AsString);

    dadosGerais.strCliCon           := qryDados.FieldByName('GER_CLICON').AsString;
    dadosGerais.strZonFra           := qryDados.FieldByName('GER_ZONFRA').AsString;
    dadosGerais.strCodAti           := qryDados.FieldByName('GER_CODATI').AsString;
    dadosGerais.strIESUni           := qryDados.FieldByName('GER_IESUNI').AsString;
    dadosGerais.strMicroEmpreendedor:= qryDados.FieldByName('GER_MICEMP').AsString;
    dadosGerais.strProdutorRural    := qryDados.FieldByName('GER_PRORUR').AsString;
    dadosGerais.strBeneficioREIDI   := qryDados.FieldByName('GER_BENREI').AsString;
    dadosGerais.strRegimeTributacao := qryDados.FieldByName('GER_REGTRI').AsString;
    dadosGerais.strRetIss           := qryDados.FieldByName('GER_RETISS').AsString;

    dadosGerais.fltPisRet           := qryDados.FieldByName('GER_PISRET').AsFloat;
    dadosGerais.fltCofRet           := qryDados.FieldByName('GER_COFRET').AsFloat;
    dadosGerais.fltIrfRet           := qryDados.FieldByName('GER_IRFRET').AsFloat;
    dadosGerais.fltCslRet           := qryDados.FieldByName('GER_CSLRET').AsFloat;
    dadosGerais.fltVlSgSo           := qryDados.FieldByName('GER_VLSGSO').AsFloat;

    dadosGerais.strNumDoc           := qryDados.FieldByName('FIS_NUMDOC').AsString;
    dadosGerais.strCodEmp           := qryDados.FieldByName('FIS_CODEMP').AsString;
    dadosGerais.strClaFis           := qryDados.FieldByName('GER_CLAFIS').AsString;
    dadosGerais.strCondPagamento    := qryDados.FieldByName('GER_CONPAG').AsString;
    dadosGerais.strDesCondPagamento := fTiraPipeEnter(qryDados.FieldByName('CND_DESCRI').AsString);
    dadosGerais.strSerie            := fValidaServicoSerieNF(qryDados.FieldByName('GER_CLAFIS').AsString, qryDados.FieldByName('FIS_SERIE_').AsString);
    dadosGerais.strTip_FC           := qryDados.FieldByName('FIS_TIP_FC').AsString;
    dadosGerais.dtaDtaEnt           := qryDados.FieldByName('FIS_DTAENT').AsDateTime;
    dadosGerais.dtaDtaDoc           := qryDados.FieldByName('FIS_DTADOC').AsDateTime;
    dadosGerais.dtaHorEnt           := qryDados.FieldByName('GER_HORENT').AsDateTime;
    dadosGerais.dtaHorDoc           := qryDados.FieldByName('GER_HORENT').AsDateTime;
    dadosGerais.fltBasIcm           := qryDados.FieldByName('GER_BASICM').AsFloat;
    dadosGerais.fltAlqIcm           := 0;
    dadosGerais.fltTotIcm           := qryDados.FieldByName('GER_TOTICM').AsFloat;
    dadosGerais.fltBasRet           := qryDados.FieldByName('GER_BASRET').AsFloat;
    dadosGerais.fltTotRet           := qryDados.FieldByName('GER_TOTRET').AsFloat;
    dadosGerais.fltTotIpi           := qryDados.FieldByName('GER_TOTIPI').AsFloat;
    dadosGerais.fltBasIpi           := qryDados.FieldByName('GER_BASIPI').AsFloat;

    dadosGerais.fltBasRetBkp        := qryDados.FieldByName('GER_BASRET').AsFloat;
    dadosGerais.fltTotRetBkp        := qryDados.FieldByName('GER_TOTRET').AsFloat;
    dadosGerais.fltTotIpiBkp        := qryDados.FieldByName('GER_TOTIPI').AsFloat;

    dadosGerais.fltImpPag           := qryDados.FieldByName('GER_IMPPAG').AsFloat;

    If fCampoExiste('AUXMOV', 'AUX_FEDIMP') And
       fCampoExiste('AUXNOT', 'AUX_FEDIMP') Then
      dadosGerais.fltFedImp         := qryDados.FieldByName('GER_FEDIMP').AsFloat
    Else
      dadosGerais.fltFedImp         := 0;

    If fCampoExiste('AUXMOV', 'AUX_ESTIMP') And
       fCampoExiste('AUXNOT', 'AUX_ESTIMP') Then
      dadosGerais.fltEstImp         := qryDados.FieldByName('GER_ESTIMP').AsFloat
    Else
      dadosGerais.fltEstImp         := 0;

    If fCampoExiste('AUXMOV', 'AUX_MUNIMP') And
       fCampoExiste('AUXNOT', 'AUX_MUNIMP') Then
      dadosGerais.fltMunImp         := qryDados.FieldByName('GER_MUNIMP').AsFloat
    Else
      dadosGerais.fltMunImp         := 0;

    dadosGerais.fltTotPro           := qryDados.FieldByName('GER_TOTPRO').AsFloat;
    dadosGerais.fltTotFre           := qryDados.FieldByName('GER_TOTFRE').AsFloat;
    dadosGerais.fltDesEsp           := qryDados.FieldByName('GER_DESESP').AsFloat;
    dadosGerais.fltValPis           := qryDados.FieldByName('FIS_TOTPIS').AsFloat;
    dadosGerais.fltValCof           := qryDados.FieldByName('FIS_TOTCOF').AsFloat;
    dadosGerais.fltDesAce           := qryDados.FieldByName('GER_DESACE').AsFloat;
    dadosGerais.fltTotGer           := qryDados.FieldByName('GER_VLRCON').AsFloat;
    dadosGerais.strDocOriNC         := qryDados.FieldByName('GER_DOCORI').AsString;
    dadosGerais.strSerOriNC         := qryDados.FieldByName('GER_SERORI').AsString;
    dadosGerais.strAceOriNC         := qryDados.FieldByName('GER_ACEORI').AsString;
    dadosGerais.strDesIteNC         := qryDados.FieldByName('GER_DESITE').AsString;

    If fCampoExiste('NOTCOM', 'GER_EMPORI') Then
    Begin
      dadosGerais.strEspOriNC       := qryDados.FieldByName('GER_ESPORI').AsString;
      dadosGerais.strEmpOriNC       := qryDados.FieldByName('GER_EMPORI').AsString;
    End;

    If fCampoExiste('NOTCOM', 'GER_COMICM') Then
      dadosGerais.blnComplementoIcms := qryDados.FieldByName('GER_COMICM').AsString = 'S'
    Else
      dadosGerais.blnComplementoIcms := (Pos('COMPLEMENTO', UpperCase(fTiraCaracEspeciais(dadosGerais.strDesIteNC))) > 0);

    If fCampoExiste('NOTCOM', 'GER_CREICM') Then
      dadosGerais.blnCreditoIcms := qryDados.FieldByName('GER_CREICM').AsString = 'S'
    Else
      dadosGerais.blnCreditoIcms := (Pos('CREDITO', UpperCase(fTiraCaracEspeciais(dadosGerais.strDesIteNC))) > 0) And
                                    (Pos('ICMS',    UpperCase(fTiraCaracEspeciais(dadosGerais.strDesIteNC))) > 0);

    If fCampoExiste('NOTCOM', 'GER_TRAICM') Then
      dadosGerais.blnTransfIcms := qryDados.FieldByName('GER_TRAICM').AsString = 'S'
    Else
      dadosGerais.blnTransfIcms := (Pos('TRANSFERENCIA', UpperCase(fTiraCaracEspeciais(dadosGerais.strDesIteNC))) > 0) And
                                   (Pos('ICMS',    UpperCase(fTiraCaracEspeciais(dadosGerais.strDesIteNC))) > 0);

    If fCampoExiste('AUXMOV', 'AUX_EST_DV') Then
      dadosGerais.blnEst_Dv := qryDados.FieldByName('GER_EST_DV').AsString = 'S'
    Else
      dadosGerais.blnEst_Dv := False;

    If fCampoExiste('NOTCOM', 'GER_COMVAL') Then
      dadosGerais.blnComplementoValor := qryDados.FieldByName('COMPLEMENTO_VALOR').AsString = 'S'
    Else
      dadosGerais.blnComplementoValor := False;

    If fCampoExiste('NOTCOM', 'GER_RESICM') Then
      dadosGerais.blnRestituicaoIcms := qryDados.FieldByName('GER_RESICM').AsString = 'S'
    Else
      dadosGerais.blnRestituicaoIcms := False;

    dadosGerais.strMenNc01          := qryDados.FieldByName('GER_MENC01').AsString;
    dadosGerais.strMenNc02          := qryDados.FieldByName('GER_MENC02').AsString;
    dadosGerais.strMenNc03          := qryDados.FieldByName('GER_MENC03').AsString;
    dadosGerais.strMenNc04          := qryDados.FieldByName('GER_MENC04').AsString;
    dadosGerais.strMenNc05          := qryDados.FieldByName('GER_MENC05').AsString;
    dadosGerais.strMenNc06          := qryDados.FieldByName('GER_MENC06').AsString;
    dadosGerais.strMenNc07          := qryDados.FieldByName('GER_MENC07').AsString;
    dadosGerais.strMenNc08          := qryDados.FieldByName('GER_MENC08').AsString;
    dadosGerais.strMenNc09          := qryDados.FieldByName('GER_MENC09').AsString;
    dadosGerais.strMenNc10          := qryDados.FieldByName('GER_MENC10').AsString;
    dadosGerais.fltImpMer           := qryDados.FieldByName('FIS_IMPMER').AsFloat;
    dadosGerais.fltImpSeg           := qryDados.FieldByName('FIS_IMPSEG').AsFloat;
    dadosGerais.fltImpImp           := qryDados.FieldByName('FIS_IMPIMP').AsFloat;
    dadosGerais.fltBaseII           := qryDados.FieldByName('FIS_BASEII').AsFloat;
    dadosGerais.fltVaFRMM           := qryDados.FieldByName('FIS_VAFRMM').AsFloat;
    dadosGerais.fltDesAdu           := qryDados.FieldByName('FIS_DESADU').AsFloat;
    dadosGerais.fltValIOF           := qryDados.FieldByName('FIS_VALIOF').AsFloat;
    dadosGerais.fltImpPro           := qryDados.FieldByName('FIS_IMPPRO').AsFloat;
    dadosGerais.fltImpTax           := qryDados.FieldByName('FIS_IMPTAX').AsFloat;
    dadosGerais.fltImpPis           := qryDados.FieldByName('FIS_IMPPIS').AsFloat;
    dadosGerais.fltImpCof           := qryDados.FieldByName('FIS_IMPCOF').AsFloat;
    dadosGerais.fltValAdp           := qryDados.FieldByName('FIS_VALADP').AsFloat;
    dadosGerais.strImpIC1           := qryDados.FieldByName('FIS_IMPIC1').AsString;
    dadosGerais.strImpIC2           := qryDados.FieldByName('FIS_IMPIC2').AsString;

    If (fCampoExiste('AUXMOV', 'AUX_VENPRE') And (qryDados.FindField('AUX_VENPRE') <> Nil)) Then
      dadosGerais.blnVenPre := qryDados.FieldByName('AUX_VENPRE').AsString = 'S'
    Else
      dadosGerais.blnVenPre := False;    

    dadosGerais.blnEntFat           := qryDados.FieldByName('GER_ENTFAT').AsString = 'S';

    dadosGerais.intTipFre := tfCif;
    If (Not qryDados.FieldByName('GER_TIPFRE').IsNull) Then
      dadosGerais.intTipFre := fConverteParaTipoNfe(IfThen(Not fPermitirFreteEmVendaPresencial, '9', qryDados.FieldByName('GER_TIPFRE').AsString));

    dadosGerais.strCgcTra           := qryDados.FieldByName('TRA_C_G_C_').AsString;
    dadosGerais.strNomTra           := qryDados.FieldByName('TRA_NOMTRA').AsString;
    dadosGerais.strIesTra           := qryDados.FieldByName('TRA_I_E_S_').AsString;
    dadosGerais.strEndTra           := qryDados.FieldByName('TRA_ENDERE').AsString;
    dadosGerais.strCidTra           := qryDados.FieldByName('TRA_NOMCID').AsString;
    dadosGerais.strEstTra           := qryDados.FieldByName('TRA_ESTADO').AsString;
    dadosGerais.intQtdTra           := qryDados.FieldByName('GER_VOLUME').AsInteger;
    dadosGerais.strEspTra           := qryDados.FieldByName('GER_ESPECI').AsString;
    dadosGerais.strMarTra           := qryDados.FieldByName('GER_MARCA_').AsString;
    dadosGerais.strNumera           := qryDados.FieldByName('AUX_NUMERA').AsString;
    dadosGerais.fltPesLiq           := qryDados.FieldByName('GER_PESLIQ').AsFloat;
    dadosGerais.fltPesBru           := qryDados.FieldByName('GER_PESBRU').AsFloat;
    dadosGerais.strPlaVei           := AnsiReplaceStr(qryDados.FieldByName('TRA_NUMPLA').AsString, '-', '');
    dadosGerais.strEmaTra           := qryDados.FieldByName('TRA_EMAIL_').AsString;

    if Assigned(qryDados.FindField('TRA_EMAILR')) then
      dadosGerais.strEmaTrr           := qryDados.FieldByName('TRA_EMAILR').AsString;

    dadosGerais.strC_Antt           := qryDados.FieldByName('TRA_C_ANTT').AsString;

    If Not fEmptyStr(dadosGerais.strPlaVei) Then
      dadosGerais.strEstVei := dadosGerais.strEstTra;

    dadosGerais.strCodVen           := qryDados.FieldByName('GER_CODVEN').AsString;
    dadosGerais.strNomVen           := qryDados.FieldByName('OPE_NOMOPE').AsString;
    dadosGerais.strCodDig           := qryDados.FieldByName('GER_CODDIG').AsString;
    dadosGerais.strNomDig           := qryDados.FieldByName('OPE_NOMDIG').AsString;
    dadosGerais.strMen001           := fTiraPipeEnter(qryDados.FieldByName('GER_MEN001').AsString);
    dadosGerais.strMen002           := fTiraPipeEnter(qryDados.FieldByName('GER_MEN002').AsString);
    dadosGerais.strMen003           := fTiraPipeEnter(qryDados.FieldByName('GER_MEN003').AsString);
    dadosGerais.strMen004           := fTiraPipeEnter(qryDados.FieldByName('GER_MEN004').AsString);
    dadosGerais.strMen005           := fTiraPipeEnter(qryDados.FieldByName('GER_MEN005').AsString);

    dadosGerais.blnNfComp           := (qryDados.FieldByName('FIS_NFCOMP').AsString='S');

    If fNotaServicoEletronicaConcreto Then
      dadosGerais.fltTotSer         := qryDados.FieldByName('GER_TOTPRO').AsFloat - qryDados.FieldByName('GER_DESESP').AsFloat
    Else
      dadosGerais.fltTotSer         := qryDados.FieldByName('GER_TOTSER').AsFloat;

    dadosGerais.fltBasIss           := dadosGerais.fltTotSer;

    If (qryDados.FindField('GER_BASISS') <> Nil) And (qryDados.FieldByName('GER_BASISS').AsFloat > 0) Then
    Begin
      dadosGerais.fltBasIss         := qryDados.FieldByName('GER_BASISS').AsFloat;
    End;

    dadosGerais.fltPerIss           := qryDados.FieldByName('GER_PERISS').AsFloat;
    dadosGerais.fltValIss           := qryDados.FieldByName('GER_VALISS').AsFloat;

    dadosGerais.fltReceitaBrutaNS := qryDados.FieldByName('EMP_NSRBRU').AsFloat;

    dadosGerais.strCodObr           := qryDados.FieldByName('AUX_CODOBR').AsString;
    dadosGerais.strCodArt           := qryDados.FieldByName('AUX_CODART').AsString;

    dadosGerais.strLogradouroEndEnt  := qryDados.FieldByName('ETC_ENDENT').AsString;
    dadosGerais.strNumeroEndEnt      := '';
    dadosGerais.strComplementoEndEnt := qryDados.FieldByName('ETC_REFENT').AsString;
    dadosGerais.strBairroEndEnt      := qryDados.FieldByName('ETC_BAIENT').AsString;
    dadosGerais.strCEPEndEnt         := qryDados.FieldByName('ETC_CEPENT').AsString;

    pRetornaDadosIbge(qryDados.FieldByName('ETC_CIDENT').AsString, dadosGerais.strCodIbgeEntrega, dadosGerais.strUfIbgeEntrega, strEstado, strCidade);

    If fEmptyStr(dadosGerais.strCodIbgeEntrega) Or (qryDados.FieldByName('GER_CONSUM').AsString = 'S') Then
    Begin
      dadosGerais.strCodIbgeEntrega := dadosGerais.strCodIbge;
      dadosGerais.strUfIbgeEntrega  := dadosGerais.strUfIbge;

      dadosGerais.strLogradouroEndEnt  := dadosGerais.strLogradouro;
      dadosGerais.strNumeroEndEnt      := dadosGerais.strNumeroEnd;
      dadosGerais.strComplementoEndEnt := dadosGerais.strComplementoEnd;
      dadosGerais.strBairroEndEnt      := dadosGerais.strBairro;
      dadosGerais.strCEPEndEnt         := dadosGerais.strCEP;
    End;

    If fEmptyStr(dadosGerais.strNumeroEndEnt) Then
      dadosGerais.strNumeroEndEnt := '0';

    dadosGerais.strDescricaoClaFis  := qryDados.FieldByName('CFO_NATOPE_01').AsString;
    If Not (fEmptyStr(qryDados.FieldByName('CFO_NATOPE_02').AsString)) Then
    Begin
      dadosGerais.strDescricaoClaFis := dadosGerais.strDescricaoClaFis + '/' +
        qryDados.FieldByName('CFO_NATOPE_02').AsString;
    End;

    If Not (fEmptyStr(qryDados.FieldByName('CFO_NATOPE_03').AsString)) Then
    Begin
      dadosGerais.strDescricaoClaFis := dadosGerais.strDescricaoClaFis + '/' +
        qryDados.FieldByName('CFO_NATOPE_03').AsString;
    End;

    If Not (fEmptyStr(qryDados.FieldByName('CFO_NATOPE_04').AsString)) Then
    Begin
      dadosGerais.strDescricaoClaFis := dadosGerais.strDescricaoClaFis + '/' +
        qryDados.FieldByName('CFO_NATOPE_04').AsString;
    End;

    If fCampoExiste('MOVOBS', 'MOV_CNFNFE') And (qryDados.FindField('MOV_CNFNFE') <> Nil) Then
      dadosGerais.strMensagemAplicacao := qryDados.FieldByName('MOV_CNFNFE').AsString
    Else
      dadosGerais.strMensagemAplicacao := qryDados.FieldByName('MOV_OBSERV').AsString;

    If (fCampoExiste('MOVOBS', 'MOV_CNFFIS') And (qryDados.FindField('MOV_CNFFIS') <> Nil)) Then
      dadosGerais.strMensagemFiscalCnf := qryDados.FieldByName('MOV_CNFFIS').AsString
    Else If (fCampoExiste('MOVOBS', 'MOV_OBSFIS') And (qryDados.FindField('MOV_OBSFIS') <> Nil)) Then
      dadosGerais.strMensagemFiscalCnf := qryDados.FieldByName('MOV_OBSFIS').AsString
    Else
      dadosGerais.strMensagemFiscalCnf := '';

    If (Trim(qryDados.FieldByName('GER_SEROBS').AsString)<>'') Then
     dadosGerais.strMensagemAplicacao := dadosGerais.strMensagemAplicacao +
                                         IfThen(Trim(dadosGerais.strMensagemAplicacao)<>'', #13#10, '') +
                                         qryDados.FieldByName('GER_SEROBS').AsString;

     If (qryDados.FindField('GER_DISSER') <> Nil) And (Not fEmptyStr(qryDados.FieldByName('GER_DISSER').AsString)) Then
      dadosGerais.strDisSer := qryDados.FieldByName('GER_DISSER').AsString
    Else
      dadosGerais.strDisSer := '';

    If (qryDados.FieldByName('MOV_IPDPNF').IsNull) Then
      dadosGerais.blnImprimirDuplicatas := True
    Else
      dadosGerais.blnImprimirDuplicatas := (qryDados.FieldByName('MOV_IPDPNF').AsInteger=1);

    If (qryDados.FieldByName('MOV_IPDPCI').IsNull) Then
      dadosGerais.blnImprimirDuplicatasConfCI := False
    Else
      dadosGerais.blnImprimirDuplicatasConfCI := (qryDados.FieldByName('MOV_IPDPCI').AsInteger = 1 );

    If Not (qryDados.FieldByName('MOV_DTESNF').IsNull) Then
    Begin
      dadosGerais.dtaDtaDoc := qryDados.FieldByName('MOV_DTESNF').AsDateTime;
      dadosGerais.dtaHorDoc := qryDados.FieldByName('MOV_HRESNF').AsDateTime;
    End;

    dadosGerais.strStReEs := qryDados.FieldByName('GER_STREES').AsString;
    dadosGerais.strPrStRe := qryDados.FieldByName('GER_PRSTRE').AsString;
    dadosGerais.fltIcmOrg := qryDados.FieldByName('GER_ICMORG').AsFloat;
    dadosGerais.fltVrdIcm := qryDados.FieldByName('AUX_VRDICM').AsFloat;

    dadosGerais.blnOrgPub := (SameText(qryDados.FieldByName('GER_ORGPUB').AsString, 'S'));
    dadosGerais.strOrPuRD := qryDados.FieldByName('GER_ORPURD').AsString;
    dadosGerais.blnCalIcm := (SameText(qryDados.FieldByName('GER_CALICM').AsString, 'S'));
    dadosGerais.blnIndust := (SameText(qryDados.FieldByName('GER_INDUST').AsString, 'S'));

    dadosGerais.strEntGov := qryDados.FieldByName('GER_ENTGOV').AsString;
    dadosGerais.strTpOpEg := qryDados.FieldByName('GER_TPOPEG').AsString;

    dadosGerais.blnComVal := qryDados.FieldByName('GER_COMVAL').AsString = 'S';
    dadosGerais.strDocsPD := qryDados.FieldByName('GER_LISPED').AsString;

    dadosGerais.strTemRefFis := qryDados.FieldByName('GER_REFFIS').AsString;

    dadosGerais.strInfAdEnt := fGetDadosAdicionaisReferenteAEntrega;

    pCarregaDuplicatas(dadosGerais);
    pCarregaDuplicatasOutrasNotas(dadosGerais);
    pCarregaTotalDuplicataRecebida(dadosGerais);
    pVerificaSeImprimePalavraAVistaDuplicata(dadosGerais);

    pRetDadosNotaOrigem(dadosGerais.dtaDtaOriNC);

    If dadosGerais.blnNfComp Then
    Begin
      If (qryDados.FindField('FIS_CSTENT') <> Nil) Then
        dadosGerais.strCodSit := qryDados.FieldByName('FIS_CSTENT').AsString
      Else
        dadosGerais.strCodSit := '';

      dadosGerais.strClaFis := qryDados.FieldByName('FIS_CLFSC1').AsString;

      If Trim(qryDados.FieldByName('FIS_HISTOR').AsString) <> '' Then
        dadosGerais.strDescricaoClaFis := qryDados.FieldByName('FIS_HISTOR').AsString
      Else
        dadosGerais.strDescricaoClaFis := fRetDesCla(dadosGerais.strClaFis);

      If dadosGerais.blnTransfIcms Then
      Begin
        If SameText(dadosGerais.strClaFis, '5601') Then
          dadosGerais.strDescricaoClaFis := 'TRANSFERÊNCIA DE CRÉDITO ACUMULADO DE ICMS'
        Else If SameText(dadosGerais.strClaFis, '5602') Then
          dadosGerais.strDescricaoClaFis := 'TRANSF. DE CRÉDITO DE ICMS'
        Else If SameText(dadosGerais.strClaFis, '5605') Then
          dadosGerais.strDescricaoClaFis := 'TRANSF.DE SALDO DEV. DE ICMS DE OUTRO ESTAB.P/ MESMA EMPRESA';
      End
      Else If (dadosGerais.blnComplementoValor) Then
        dadosGerais.strDescricaoClaFis := 'NF COMPLEMENTAR DE VALOR';

      dadosGerais.fltTotGer := 0;
      dadosGerais.fltTotPro := 0;
      dadosGerais.fltBasIcm := 0;
      dadosGerais.fltTotIcm := 0;
      dadosGerais.fltAlqIcm := 0;
      dadosGerais.fltBasRet := 0;
      dadosGerais.fltTotRet := 0;
      dadosGerais.fltTotIpi := 0;
      dadosGerais.fltBasIpi := 0;

      For intLivFis := 1 To 5 Do
      Begin
        If fEmptyStr(qryDados.FieldByName('FIS_CLFSC' + intToStr(intLivFis)).AsString) Then
          Continue;

        dadosGerais.fltTotGer := dadosGerais.fltTotGer + qryDados.FieldByName('FIS_VLCON' + intToStr(intLivFis)).AsFloat;
        dadosGerais.fltTotPro := dadosGerais.fltTotPro + qryDados.FieldByName('FIS_VLCON' + intToStr(intLivFis)).AsFloat;
        dadosGerais.fltBasIcm := dadosGerais.fltBasIcm + qryDados.FieldByName('FIS_BASIC' + intToStr(intLivFis)).AsFloat;
        dadosGerais.fltTotIcm := dadosGerais.fltTotIcm + qryDados.FieldByName('FIS_VLRIC' + intToStr(intLivFis)).AsFloat;

        If (qryDados.FieldByName('FIS_BASIC' + intToStr(intLivFis)).AsFloat <> 0) And
           (qryDados.FieldByName('FIS_ALQIC' + intToStr(intLivFis)).AsFloat <> 0) Then
        Begin
          dadosGerais.fltAlqIcm := qryDados.FieldByName('FIS_ALQIC' + intToStr(intLivFis)).AsFloat;
        End;

        If intLivFis > 1 Then
          dadosGerais.fltAlqIcm := 0;

        dadosGerais.fltBasRet := dadosGerais.fltBasRet + qryDados.FieldByName('FIS_BCRET' + intToStr(intLivFis)).AsFloat;
        dadosGerais.fltTotRet := dadosGerais.fltTotRet + qryDados.FieldByName('FIS_RETID' + intToStr(intLivFis)).AsFloat;
        dadosGerais.fltTotIpi := dadosGerais.fltTotIpi + qryDados.FieldByName('FIS_VLRIP' + intToStr(intLivFis)).AsFloat;
        dadosGerais.fltBasIpi := dadosGerais.fltBasIpi + qryDados.FieldByName('FIS_BASIP' + intToStr(intLivFis)).AsFloat;
      End;

      pCarregaItensNotaComp(dadosGerais, qryDados.FieldByName('FIS_AUTOINCREM').AsString);
    End;

    dadosGerais.strEspDoc := FEspDoc;

    dadosGerais.strUFEmba := qryDados.FieldByName('EXP_UFEMBA').AsString;
    dadosGerais.strLoEmba := qryDados.FieldByName('EXP_LOEMBA').AsString;
    dadosGerais.strLocDes := qryDados.FieldByName('EXP_LOCDES').AsString;

    If qryDados.FieldByName('FGO_ORIGEM').AsString = 'AKZO NOBEL' then
      pCarregaChavesReferenciadasAKZ(dadosGerais.strNumDoc, dadosGerais.strEspDoc, dadosGerais.strCodEmp)
    Else
      pCarregaChavesReferenciadas(dadosGerais);

    If (FEspDoc = 'NS') Then
      pCarregaDadosNFSeSubstituicao(dadosGerais, qryDados.FieldByName('FIS_AUTOINCREM').AsString);
    pCarregarFormasPagamento(dadosGerais);

    dadosGerais.strNumPok := qryDados.FieldByName('FGO_NUMPOK').AsString;
    dadosGerais.strPedSit := qryDados.FieldByName('FGO_PEDSIT').AsString;
  End;

  Result := dadosGerais;

end;

function TFonteDadosBDEnt.fEmiteNCMPorLinhaDeTinta: Boolean;
begin
  Result := (fConfiguracao('NCMTIN') = 'S');
end;

function TFonteDadosBDEnt.fExecutaQuery(strSQL: String;
  arrParametros: array of String; arrValores: array of Variant): TDataSet;
  Var
    qryRes: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    intContador: Integer;
begin
  qryRes := fCriaQuery(Nil);
  qryRes.SQL.Add(strSQL);

  For intContador := Low(arrParametros) To High(arrParametros) Do
  Begin
    qryRes.ParamByName(arrParametros[intContador]).Value := arrValores[intContador];
  End;
  qryRes.Open;

  Result := qryRes;
end;

function TFonteDadosBDEnt.fNotaComplemento(strNumDoc, strEspDoc, strCodEmp,
  strCodCli, strSerie, strTip_FC: String): Boolean;
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryAux := fCriaQuery(Nil);
  try
    qryAux.SQL.Add('SELECT ');
    qryAux.SQL.Add('  FIS_NFCOMP ');
    qryAux.SQL.Add('FROM ');
    qryAux.SQL.Add('  CADFIS ');
    qryAux.SQL.Add('WHERE ');
    qryAux.SQL.Add('  FIS_TIP_FC = :TIP_FC AND ');
    qryAux.SQL.Add('  FIS_NUMDOC = :NUMDOC AND ');
    qryAux.SQL.Add('  FIS_ESPDOC = :ESPDOC AND ');
    qryAux.SQL.Add('  FIS_CODEMP = :CODEMP AND ');
    qryAux.SQL.Add('  FIS_FORCLI = :CODCLI AND ');
    qryAux.SQL.Add('  IFNULL(FIS_SERIE_, "") = :SERIE_ ');

    qryAux.ParamByName('TIP_FC').AsString := strTip_FC;
    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('CODCLI').AsString := strCodCli;
    qryAux.ParamByName('SERIE_').AsString := strSerie;

    qryAux.Open;

    Result := (qryAux.FieldByName('FIS_NFCOMP').AsString = 'S');
  finally
    FreeAndNil(qryAux);
  end;
end;

function TFonteDadosBDEnt.fParteInteira(fltValor: Double): Double;
Var
  strValor: String;
begin
  strValor := FloatToStrf(fltValor, ffFixed, 9, StrToInt(fConfiguracao('DECUNI')));

  If Pos(',', strValor) > 0 Then
    Result := fStrToFloat(Copy(strValor, 1, Pos(',', strValor)))
  Else
    Result := fStrToFloat(strValor);
end;

function TFonteDadosBDEnt.fProximoItem: TDadosItem;
begin

  Result := Nil;

  If (Assigned(qryDados)) And
     (qryDados.FieldByname('GER_NUMDOC').IsNull) Then
  Begin
    Exit;
  End;

  Result := TDadosItem(lstItens[intPosAtual]);

  Inc(intPosAtual);
End;

function TFonteDadosBDEnt.fAdicionaItem(intIndice, intIndColSer: Integer): TDadosItem;
  Var
    strTipAbfSai: String;
    ValorAliquotaIBPT: TValorAliquotaIBPT;

  function fRetornaNumsPedidoCompra(strNumDoc, strEspDoc, strCodCli, strCodEmp: String): String;
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  begin
    Result := '';

    If Not fTabelaExiste('NUMCMP') Then
      Exit;

    If fEmptyStr(strNumDoc+strEspDoc+strCodEmp) Then
      Exit;

    qryAux := fCriaQuery(Nil);
    Try
      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add('   SELECT                        ');
      qryAux.SQL.Add('     CMP_NUMCMP                  ');
      qryAux.SQL.Add('   FROM                          ');
      qryAux.SQL.Add('     NUMCMP                      ');
      qryAux.SQL.Add('   WHERE CMP_NUMDOC = :NUMDOC    ');
      qryAux.SQL.Add('     AND CMP_ESPDOC = :ESPDOC    ');
      qryAux.SQL.Add('     AND CMP_CODCLI = :CODCLI    ');
      qryAux.SQL.Add('     AND CMP_CODEMP = :CODEMP    ');
      qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
      qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
      qryAux.ParamByName('CODCLI').AsString := strCodCli;
      qryAux.ParamByName('CODEMP').AsString := strCodEmp;
      qryAux.Open;

      If qryAux.RecordCount > 0 Then
      Begin
        qryAux.First;
        While Not qryAux.Eof Do
        Begin

          Result := Result + qryAux.FieldByName('CMP_NUMCMP').AsString;

          qryAux.Next;

          If Not (qryAux.Eof) Then
            Result := Result + ',';

        End;

        Result := Trim(StringReplace(Result, '|', '/', [rfReplaceAll]));
      End;

      qryAux.Close;
    Except
      On E: Exception Do
        Exception.Create(E.Message + ' [TFonteDadosBDEnt.fRetornaNumsPedidoCompra]');
    End;

    FreeAndNil(qryAux);
  End;

  function fRetImpPagItem(item:TDadosItem):Double;
    Var
      fltPeImPg: Double;
      strCfgImpPag: String;
  begin
    Result := 0;

    strCfgImpPag := fConfiguracao('IMPPAG');
    If Not fEmptyStr(strCfgImpPag) Then
    Begin
      If strCfgImpPag = '1' Then
        fltPeImPg := qryDados.FieldByName('ABF_PEIMPG').AsFloat
      Else
        fltPeImPg := fBuscaAlqIBPT(fTiraCaracEspeciais(item.strClaIpi), (LeftStr(item.strCodSit,1) <> '0'));

      Result := fArredondaABNT_NBR5891_77((item.fltTotIte-item.fltDesEsp) * fltPeImPg / 100, 2);
    End;
  end;

  function fEhVendaMetroLinear: Boolean;
  begin
    Result := (fTabelaExiste('MOVMAD')) And
              (fConfiguracao('VENMTL') = 'S') And
              (qryDados.FindField('DET_QTDPEC') <> Nil) And
              (qryDados.FieldByName('DET_QTDPEC').AsFloat > 0) And
              ((qryDados.FieldByName('DET_COMPEC').AsFloat +
                qryDados.FieldByName('DET_LARPEC').AsFloat +
                qryDados.FieldByName('DET_ESPPEC').AsFloat + 0) > 0);
  end;

begin

  Try
    Result := TDadosItem(lstItens.Items[intIndice]);
  Except
    Result := TDadosItem.Create;
    lstItens.Insert(intIndice, Result);

    Result.strAutInc := qryDados.FieldByName('DET_AUTOINCREM').AsString;
    Result.strCodIte := qryDados.FieldByName('DET_CODITE').AsString;
    Result.strCdGTin := qryDados.FieldByName('ITE_CODBAR').AsString;
    Result.strCodFab := qryDados.FieldByName('ITE_CODFAB').AsString;
    Result.strCod_Nf := qryDados.FieldByName('CLI_COD_NF').AsString;
    Result.strDes_Nf := qryDados.FieldByName('CLI_DES_NF').AsString;
    Result.strCodBar := qryDados.FieldByName('ITE_CODBAR').AsString;
    Result.strForIte := qryDados.FieldByName('DET_FORITE').AsString;

    If (fConfiguracao('UNITRI') = 'S') And fCampoExiste('ITEBAR', 'BAR_EANTRB') then
    Begin
      Result.strCdGTin := fCampoTabela('BAR_CODBAR', 'ITEBAR', ['BAR_CODITE','BAR_EANTRB'], [Result.strCodIte,'S']);
      If fEmptyStr(Result.strCdGTin) then
        Result.strCdGTin := Result.strCodBar ;
    End;

    //Caso configurado para imprimir o codigo do produto acabado para as tintas
    Result.strCodigoTinta := '';
    If (fConfiguracao('CODTIN') = '2') And Not fEmptyStr(qryDados.FieldByName('DET_CODACA').AsString) Then
      Result.strCodigoTinta := qryDados.FieldByName('DET_CODACA').AsString + '-' + qryDados.FieldByName('DET_EMPACA').AsString
    Else If (fConfiguracao('CODTIN') = '3') And Not fEmptyStr(qryDados.FieldByName('DET_CODACA').AsString) Then
      Result.strCodigoTinta := intToStr(qryDados.FieldByName('ACA_UNITIN').AsInteger);

    If (Pos(qryDados.FieldByName('DET_CLAFIS').AsString, '5933_6933_') > 0) And
       (Not fNotaServicoEletronicaConcreto)                                 Then
    Begin
      Result.strDesIte := fTiraPipeEnter(qryDados.FieldByName('GER_DESS' + fStrZero(intIndColSer, 2)).AsString);
      Result.strUnidad := qryDados.FieldByName('ITE_SIGUNV').AsString;
      Result.fltQtdIte := 1.0;
      Result.fltUnitar := qryDados.FieldByName('GER_VALS' + fStrZero(intIndColSer, 2)).AsFloat;
      Result.strUnTrib := qryDados.FieldByName('ITE_SIGUNV').AsString;
      Result.fltQtdTri := 1.0;
      Result.fltUniTri := qryDados.FieldByName('GER_VALS' + fStrZero(intIndColSer, 2)).AsFloat;
      Result.fltTotIte := qryDados.FieldByName('GER_VALS' + fStrZero(intIndColSer, 2)).AsFloat;
      Result.fltUniTrO := qryDados.FieldByName('GER_VALS' + fStrZero(intIndColSer, 2)).AsFloat;
    End
    Else
    Begin
      Result.strDesIte := fTiraPipeEnter(qryDados.FieldByName('DET_DESCRI').AsString);

      If fEhVendaMetroLinear And (fConfiguracao('NFEMTL') <> '2') Then
      Begin
        Result.strUnidad := 'PC';
        Result.strUnTrib := 'PC';
        Result.fltTotIte := qryDados.FieldByName('DET_TOTITE').AsFloat;
        Result.fltQtdIte := qryDados.FieldByName('DET_QTDPEC').AsFloat;
        Result.fltQtdTri := qryDados.FieldByName('DET_QTDPEC').AsFloat;

        Result.fltUnitar := Result.fltTotIte / Result.fltQtdIte;
        Result.fltUniTri := Result.fltTotIte / Result.fltQtdIte;
        Result.fltUniTrO := Result.fltTotIte / Result.fltQtdIte;
      End
      Else
      Begin
        //Unidade de venda
        Result.strUnidad := qryDados.FieldByName('ITE_SIGUNV').AsString;
        Result.fltQtdIte := qryDados.FieldByName('DET_QTDITE').AsFloat;
        Result.fltUnitar := qryDados.FieldByName('DET_UNITAR').AsFloat;
        //Unidade tributavel
        Result.strUnTrib := qryDados.FieldByName('ITE_SIGUNT').AsString;
        Result.fltQtdTri := qryDados.FieldByName('DET_QTDITE').AsFloat * qryDados.FieldByName('ITE_FATUTR').AsFloat;
        Result.fltUniTri := qryDados.FieldByName('DET_UNITAR').AsFloat / qryDados.FieldByName('ITE_FATUTR').AsFloat;
        Result.fltUniTrO := qryDados.FieldByName('DET_UNIORI').AsFloat / qryDados.FieldByName('ITE_FATUTR').AsFloat;
        //Total do item
        Result.fltTotIte := qryDados.FieldByName('DET_TOTITE').AsFloat;
      End;

      //Prestcon
      If fNotaServicoEletronicaConcreto And
         ((objConfigInterna.strTpNfCr = PRESTCON) Or (objConfigInterna.strTpNfCr = SECOL)) Then
      Begin
        Result.strDocRemessaConcreto := fGetDocumentoRemessaConcreto(qryDados.FieldByName('DET_SEQCCR').AsInteger);
      End;
    End;

    With Result Do
    Begin
      If fFormataFloat(fltQtdIte * fltUnitar, 2) <> fFormataFloat(fltTotIte, 2) Then
      Begin
        fltUnitar := fFormataFloat(fltTotIte / fltQtdIte, 10);
        fltUniTri := fFormataFloat(fltTotIte / fltQtdIte, 10);
        fltUniTrO := fFormataFloat(fltTotIte / fltQtdIte, 10);
      End;
    End;

    Result.strDesFab := fTiraPipeEnter(qryDados.FieldByName('ITE_DESFAB').AsString);
    Result.fltUniOri := qryDados.FieldByName('DET_UNIORI').AsFloat;

    If (fEmptyStr(qryDados.FieldByName('DET_NCMITE').AsString)) Then
      Result.strClaIpi := qryDados.FieldByName('ITE_CLAIPI').AsString
    Else
      Result.strClaIpi := qryDados.FieldByName('DET_NCMITE').AsString;

    Result.strExcIpi := qryDados.FieldByName('ITE_EXCIPI').AsString;
    Result.strClaFis := qryDados.FieldByName('DET_CLAFIS').AsString;
    Result.fltDesEsp := qryDados.FieldByName('DET_DESESP').AsFloat;
    Result.strCodSit := qryDados.FieldByName('DET_CODFIS').AsString;

    Result.strCodMar := qryDados.FieldByName('DET_CODMAR').AsString;
    Result.strDesMar := fTiraPipeEnter(qryDados.FieldByName('MAR_DESMAR').AsString);

    Result.fltBasIcm := qryDados.FieldByName('DET_BASICM').AsFloat;
    Result.fltAlqIcm := qryDados.FieldByName('DET_ALQICM').AsFloat;
    Result.fltValIcm := qryDados.FieldByName('DET_VALICM').AsFloat;
    Result.fltBasRet := qryDados.FieldByName('DET_BASRET').AsFloat;
    Result.fltAlqRet := qryDados.FieldByName('DET_ALQRET').AsFloat;
    Result.fltValRet := qryDados.FieldByName('DET_VALRET').AsFloat;
    Result.fltPerRed := qryDados.FieldByName('DET_PERRED').AsFloat;
    Result.fltPRedST := qryDados.FieldByName('DET_PERRED').AsFloat;

    If Not qryDados.FieldByName('DET_PEBAST').IsNull Then
      Result.fltPRedST := 100 - qryDados.FieldByName('DET_PEBAST').AsFloat;

    Result.fltValIva := qryDados.FieldByName('DET_VALIVA').AsFloat;
    Result.fltValIpi := qryDados.FieldByName('DET_VALIPI').AsFloat;
    Result.fltBasIpi := qryDados.FieldByName('DET_BASIPI').AsFloat;
    Result.fltAlqIpi := qryDados.FieldByName('DET_ALQIPI').AsFloat;
    Result.strCodAbf := qryDados.FieldByName('ITE_CODABF').AsString;

    If fTabelaExiste('ABFICM') Then
    Begin
      If FTip_FC = 'C' Then
      Begin
        strTipAbfSai := fGetTipAbfSaida(
                             IIF(Length(qryDados.FieldByName('GER_CGCCON').AsString) <= 11, 'F', 'J'),
                                        qryDados.FieldByName('GER_IESCON').AsString,
                                        qryDados.FieldByName('GER_PRORUR').AsString,
                                        qryDados.FieldByName('GER_MICEMP').AsString,
                                        qryDados.FieldByName('GER_CLICON').AsString,
                                        qryDados.FieldByName('GER_CODATI').AsString,
                                        qryDados.FieldByName('GER_REGTRI').AsString,
                                        qryDados.FieldByName('GER_INDUST').AsString,
                                        qryDados.FieldByName('GER_CLIFIL').AsString = 'S');

        If (qryDados.FindField('ABF_MENS01' + strTipAbfSai) <> Nil) And
           (qryDados.FindField('ABF_MENS02' + strTipAbfSai) <> Nil) Then
          Result.strMen__S := fTiraPipeEnter(qryDados.FieldByName('ABF_MENS01' + strTipAbfSai).AsString + ' ' +
                                        qryDados.FieldByName('ABF_MENS02' + strTipAbfSai).AsString);
      End;
    End
    Else
    Begin
      If (qryDados.FieldByName('GER_CLICON').AsString = 'N') Or
         (Not ((fCampoExiste('CADABF', 'ABF_MENSA5') And fCampoExiste('CADABF', 'ABF_MENSA6')))) Then
      Begin
        Result.strMen__S := fTiraPipeEnter(qryDados.FieldByName('ABF_MENS01').AsString + ' ' +
                                      qryDados.FieldByName('ABF_MENS02').AsString)
      End
      Else
      Begin
        Result.strMen__S := fTiraPipeEnter(qryDados.FieldByName('ABF_MENS05').AsString + ' ' +
                                      qryDados.FieldByName('ABF_MENS06').AsString)
      End;
    End;

    Result.strDesNes := fTiraPipeEnter(qryDados.FieldByName('DET_DESNES').AsString);
    Result.strNumFCI := fTiraPipeEnter(qryDados.FieldByName('ITE_NUMFCI').AsString);

    Result.strNumLot := qryDados.FieldByName('DET_NUMLOT').AsString;
    Result.strValLot := qryDados.FieldByName('LOT_DTAVAL').AsString;

    Result.strLocFis := qryDados.FieldByName('DET_LOCFIS').AsString;    

    Result.strMenFis := fTiraPipeEnter(qryDados.FieldByName('ITE_MENFIS').AsString);

    Result.blnIncPis := (qryDados.FieldByName('ITE_INCPIS').AsString='S');

    Result.fltBasPis := Result.fltTotIte - Result.fltDesEsp;
    Result.fltBasCof := Result.fltTotIte - Result.fltDesEsp;

    Result.fltAlqPis := objConfig.fltAlqPis;
    Result.fltAlqCof := objConfig.fltAlqCof;

    If (qryDados.FieldByName('FIS_TOTPIS').AsFloat <= 0) Then
    Begin
      Result.fltAlqPis := 0;
      Result.fltBasPis := 0;
    End;

    If (qryDados.FieldByName('FIS_TOTCOF').AsFloat <= 0) Then
    Begin
      Result.fltAlqCof := 0;
      Result.fltBasCof := 0;
    End;

    Result.fltValPis := Result.fltBasPis * Result.fltAlqPis / 100;
    Result.fltValCof := Result.fltBasCof * Result.fltAlqCof / 100;

    If (qryDados.FindField('DET_CSTPIS') <> Nil) And
       (Not fEmptyStr(qryDados.FieldByName('DET_CSTPIS').AsString)) Then
    Begin
      Result.fltBasPis := qryDados.FieldByName('DET_BASPIS').AsFloat;
      Result.fltBasCof := qryDados.FieldByName('DET_BASCOF').AsFloat;

      Result.fltAlqPis := qryDados.FieldByName('DET_ALQPIS').AsFloat;
      Result.fltAlqCof := qryDados.FieldByName('DET_ALQCOF').AsFloat;

      Result.fltValPis := qryDados.FieldByName('DET_VALPIS').AsFloat;
      Result.fltValCof := qryDados.FieldByName('DET_VALCOF').AsFloat;

      Result.strCstPis := qryDados.FieldByName('DET_CSTPIS').AsString;
      Result.strCstCof := qryDados.FieldByName('DET_CSTCOF').AsString;

    End;

    If (qryDados.FindField('DET_CSTIPI') <> Nil) Then
    Begin
      Result.strCSTIpi := qryDados.FieldByName('DET_CSTIPI').AsString;
    End;

    If (qryDados.FindField('DET_ENQIPI') <> Nil) Then
    Begin
      Result.strEnqIpi := qryDados.FieldByName('DET_ENQIPI').AsString;
    End;

    Result.fltBARTSP := qryDados.FieldByName('DET_BARTSP').AsFloat;
    Result.fltVLRTSP := qryDados.FieldByName('DET_VLRTSP').AsFloat;
    Result.fltICOPPR := qryDados.FieldByName('DET_ICOPPR').AsFloat;

    Result.strDiferi := qryDados.FieldByName('GER_DIFERI').AsString;

    Result.fltTotFre := qryDados.FieldByName('DET_TOTFRE').AsFloat;
    Result.fltDesAce := qryDados.FieldByName('DET_DESACE').AsFloat;

    If fNotaServicoEletronicaConcreto Then
    Begin
      Result.strCodSLC := fConfiguracao('CLCSCR');
      Result.strTriMun := fConfiguracao('TRMNCR');
      Result.strCodListaServ := fConfiguracao('CLCSCR');
    End
    Else
    Begin
      Result.strCodSLC := qryDados.FieldByName('SER_CDLSSE').AsString;
      Result.strTriMun := qryDados.FieldByName('SER_TRIMUN').AsString;
      Result.strCodListaServ := qryDados.FieldByName('SER_CDLSSE').AsString;
    End;

    {******INFORMAÇÕES REF. PEDIDO DE COMPRA******}
    Result.strCoiCmp := qryDados.FieldByName('DET_COICMP').AsString;     //CÓDIGO DO ITEM NO CLIENTE QUE SOLICITOU A PEDIDO
                                                                         //CAMPO CRIADO REQ.: 38461 MAS O REQUISITO FOI "PERDIDO" NA VIRADA 48.02.DESEN > 48.02.30
                                                                         //MANTIDO AQUI SOMENTE POR QUESTÃO DE COMPATIBILIDADE
    If (qryDados.FieldByName('DET_NITCMP').AsInteger > 0) Then
      Result.strNItemPed := qryDados.FieldByName('DET_NITCMP').AsString; //QUANTIDADE SOLICITADA NO PEDIDO DE COMPRA

    //NÚMERO PEDIDO DE COMPRA COM PRIORIDADE DEFINIDA CONFORME REQ.: 76040
    If (Not fEmptyStr(qryDados.FieldByName('DET_NUMCMP').AsString)) Then
    Begin
      Result.strPedCom := qryDados.FieldByName('DET_NUMCMP').AsString
    End
    Else
    Begin
      Result.strPedCom := fRetornaNumsPedidoCompra(qryDados.FieldByName('DET_NUM_PD').AsString,
                                                   qryDados.FieldByName('DET_ESP_PD').AsString,
                                                   qryDados.FieldByName('GER_CODCLI').AsString,
                                                   qryDados.FieldByName('DET_EMP_PD').AsString);
    End;

    Result.strPedCom := AnsiReplaceStr(Result.strPedCom, #13#10, '');
    Result.strPedCom := LeftStr(StringReplace(Result.strPedCom, '|', '/', [rfReplaceAll]), 15);
    {******INFORMAÇÕES REF. PEDIDO DE COMPRA******}

    Result.strImpDir := qryDados.FieldByName('ITE_IMPDIR').AsString; // Importacao Direta

    Result.strRICMPR := qryDados.FieldByName('DET_RICMPR').AsString;

    Result.strInfGar := IIF(qryDados.FieldByName('DET_TMPGAR').AsInteger <> 0,
                           'Garantia de ' + qryDados.FieldByName('DET_TMPGAR').AsString + ' meses. ', '') +
                       qryDados.FieldByName('ITE_INFGAR').AsString;

    pCarregarDocumentoImportacao(Result, qryDados.FieldByName('DET_AUTINC').AsString);

    If (qryDados.FindField('DET_QTDPEC') <> Nil) And
       (qryDados.FieldByName('DET_QTDPEC').AsFloat > 0) And
       ((qryDados.FieldByName('DET_COMPEC').AsFloat +
         qryDados.FieldByName('DET_LARPEC').AsFloat +
         qryDados.FieldByName('DET_ESPPEC').AsFloat + 0) > 0) Then
    Begin
      Result.dadosMadeira := TDadosMadeira.Create;
      Result.dadosMadeira.fltQtdPec := qryDados.FieldByName('DET_QTDPEC').AsFloat;
      Result.dadosMadeira.fltComPec := qryDados.FieldByName('DET_COMPEC').AsFloat;
      Result.dadosMadeira.fltLarPec := qryDados.FieldByName('DET_LARPEC').AsFloat;
      Result.dadosMadeira.fltEspPec := qryDados.FieldByName('DET_ESPPEC').AsFloat;
      Result.dadosMadeira.fltPerApa := qryDados.FieldByName('DET_PERAPA').AsFloat;
      Result.dadosMadeira.fltPerBen := qryDados.FieldByName('DET_PERBEN').AsFloat;
      Result.dadosMadeira.strAparel := qryDados.FieldByName('DET_APAREL').AsString;
      Result.dadosMadeira.strBenefi := qryDados.FieldByName('DET_BENEFI').AsString;

      if (qryDados.FindField('DET_VLUNPC') <> Nil) then
      begin
        Result.dadosMadeira.fltVlUnPc := qryDados.FieldByName('DET_VLUNPC').AsFloat;
      end
      else
      begin
        Result.dadosMadeira.fltVlUnPc := 0;
      end;

    End;

    Result.strCodLub := qryDados.FieldByName('ITE_CODLUB').AsString;
    Result.strDesANP := qryDados.FieldByName('ITE_DESANP').AsString;
    Result.strCodOnu := qryDados.FieldByName('ONU_CODONU').AsString;
    Result.strDesOnu := qryDados.FieldByName('ONU_DESCRI').AsString;
    Result.strCodigo := qryDados.FieldByName('ONU_CODIGO').AsString;
    Result.strClaRis := qryDados.FieldByName('ONU_CLARIS').AsString;
    Result.strGruEmb := qryDados.FieldByName('ONU_GRUEMB').AsString;

    Result.fltTotPes := qryDados.FieldByName('DET_TOTPES').AsFloat;

    Result.fltImpPag := 0;
    Result.fltFedImp := 0;
    Result.fltEstImp := 0;
    Result.fltMunImp := 0;

    If (qryDados.FindField('DET_FEDIMP') <> Nil) And
       (qryDados.FindField('DET_ESTIMP') <> Nil) And
       (qryDados.FindField('DET_MUNIMP') <> Nil) And
       (fConfiguracao('IMPPAG') = '2')           Then
    Begin

      ValorAliquotaIBPT := fBuscaAlqIBPT(fTiraCaracEspeciais(Result.strClaIpi), Result.strExcIpi, FCodEmp);

      If qryDados.FieldByName('DET_FEDIMP').AsFloat > 0 Then
        Result.fltFedImp := qryDados.FieldByName('DET_FEDIMP').AsFloat
      Else
        Result.fltFedImp := IIF((LeftStr(Result.strCodSit,1) <> '0'),
                                fFormataFloat((Result.fltTotIte - Result.fltDesEsp) * ValorAliquotaIBPT.fltImportado / 100, 2),
                                fFormataFloat((Result.fltTotIte - Result.fltDesEsp) * ValorAliquotaIBPT.fltNacional  / 100, 2));

      If qryDados.FieldByName('DET_ESTIMP').AsFloat > 0 Then
        Result.fltEstImp := qryDados.FieldByName('DET_ESTIMP').AsFloat
      Else
        Result.fltEstImp := fFormataFloat((Result.fltTotIte - Result.fltDesEsp) * ValorAliquotaIBPT.fltEstadual / 100, 2);

      If qryDados.FieldByName('DET_MUNIMP').AsFloat > 0 Then
        Result.fltMunImp := qryDados.FieldByName('DET_MUNIMP').AsFloat
      Else
        Result.fltMunImp := fFormataFloat((Result.fltTotIte - Result.fltDesEsp) * ValorAliquotaIBPT.fltMunicipal / 100, 2);

    End
    Else
    Begin
      If (qryDados.FindField('DET_IMPPAG') <> Nil) Then
      Begin
        If qryDados.FieldByName('DET_IMPPAG').AsFloat > 0 Then
          Result.fltImpPag := qryDados.FieldByName('DET_IMPPAG').AsFloat
        Else
          Result.fltImpPag := fRetImpPagItem(Result);
      End
      Else
      Begin
        Result.fltImpPag := fRetImpPagItem(Result);
      End;
    End;

    If (qryDados.FindField('DET_ICMORG') <> Nil) Then
      Result.fltIcmOrg := qryDados.FindField('DET_ICMORG').AsFloat;

    If (qryDados.FindField('DET_VRDICM') <> Nil) Then
      Result.fltVrdIcm := qryDados.FindField('DET_VRDICM').AsFloat;

    If (qryDados.FindField('DET_MTDICM') <> Nil) Then
      Result.strMtdIcm := qryDados.FindField('DET_MTDICM').AsString;

    If (qryDados.FindField('ITE_PROPCD') <> Nil) Then
      Result.strProPCD := qryDados.FindField('ITE_PROPCD').AsString;

    Result.fltPerDevolvido := 0;
    If (Pos(Result.strClaFis, CFOP_DEVOLUCAO) > 0)              And
       (Not fEmptyStr(qryDados.FieldByName('DET_DOCDEV').AsString)) And
       (qryDados.FieldByName('DET_CLAFIS').AsString < '5000') And
       (FTip_FC = 'F') And
       (Assigned(qryDados.FindField('GER_MATREV'))) And
       (qryDados.FieldByName('GER_MATREV').AsString = 'I') Then
    Begin
      Result.fltPerDevolvido := fRetornaPercetualDevolvido(qryDados);
    End;

    Result.strRIcmPRAbf := qryDados.FieldByName('ABF_RICMPR_SAI_CNC').AsString;

    If (qryDados.FieldByName('ITE_CDCEST').AsString = '0000000') Then
      Result.strCodigoCEST := ''
    Else
      Result.strCodigoCEST := qryDados.FieldByName('ITE_CDCEST').AsString;

    Result.strEniEcb := qryDados.FieldByName('ITE_ENIECB').AsString;
    Result.strIndEsc := qryDados.FieldByName('ITE_INDESC').AsString;
    Result.strCnpFab := qryDados.FieldByName('ITE_CNPFME').AsString;
    Result.strCdbFis := qryDados.FieldByName('ITE_CDBFIS').AsString;

    If Assigned(qryDados.FindField('ICD_BCUFDE')) Then
    Begin
      Result.fltBaseUfDestino := qryDados.FieldByName('ICD_BCUFDE').AsFloat;
      Result.fltPercentualFCP := qryDados.FieldByName('ICD_PERFCP').AsFloat;
      Result.fltAliquotaDestino := qryDados.FieldByName('ICD_ALQUFD').AsFloat;
      Result.fltAliquotaInterestadual := qryDados.FieldByName('ICD_ALQINE').AsFloat;
      Result.fltPercentualPartilha := qryDados.FieldByName('ICD_PERPAR').AsFloat;
      Result.fltValorFCP := qryDados.FieldByName('ICD_VALFCP').AsFloat;
      Result.fltValorIcmsDestino := qryDados.FieldByName('ICD_VALDES').AsFloat;
      Result.fltValorIcmsOrigem := qryDados.FieldByName('ICD_VALORI').AsFloat;
      Result.fltBaseFCP := qryDados.FieldByName('ICD_BASFCP').AsFloat;
    End;
  End;
end;

function TFonteDadosBDEnt.fAdicionaItemServico(intIndice, intIndColSer: Integer): TDadosItem;

  procedure pGetItemServico(Item: TDadosItem);
  var
    qryGen: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  begin

    qryGen := fCriaQuery(Nil);

    Try
      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT ITE_DESITE, ITE_CLAIPI FROM CADITE WHERE ITE_CODITE = :CODITE');
        ParamByName('CODITE').AsString := Item.strCodIte;
        Open;

        Item.strDesIte := FieldByName('ITE_DESITE').AsString;
        Item.strClaIpi := FieldByName('ITE_CLAIPI').AsString;

        Close;
      End;
    Finally
      FreeAndNil(qryGen);
    End;
  end;
begin

  Try
    Result := TDadosItem(lstItens.Items[intIndice]);
  Except
    Result := TDadosItem.Create;
    lstItens.Insert(intIndice, Result);

    Result.strAutInc := ''; //qryDados.FieldByName('DET_AUTOINCREM').AsString;
    Result.strCodIte := fConfiguracao('ITESER');
    pGetItemServico(Result);

    Result.strCdGTin := '';
    Result.strCodFab := ''; //qryDados.FieldByName('ITE_CODFAB').AsString;
    Result.strCod_Nf := qryDados.FieldByName('CLI_COD_NF').AsString;
    Result.strDes_Nf := qryDados.FieldByName('CLI_DES_NF').AsString;
    Result.strCodBar := ''; //qryDados.FieldByName('ITE_CODBAR').AsString;
    Result.strForIte := qryDados.FieldByName('DET_FORITE').AsString;

    //Result.strDesIte := 'ITEM';
    Result.strUnidad := 'UN';
    Result.fltQtdIte := 1.0;
    Result.fltUnitar := qryDados.FieldByName('GER_VLRCON').AsFloat;
    Result.strUnTrib := '';
    Result.fltQtdTri := 1.0;
    Result.fltUniTri := qryDados.FieldByName('GER_VLRCON').AsFloat;
    Result.fltTotIte := qryDados.FieldByName('GER_VLRCON').AsFloat;
    Result.fltUniTrO := qryDados.FieldByName('GER_VLRCON').AsFloat;

    Result.strDesFab := '';
    Result.fltUniOri := 0;

    //Result.strClaIpi := '84433299'; //TROCAR;
    Result.strExcIpi := '';

    Result.strClaFis := qryDados.FieldByName('FIS_CLFSC1').AsString;
    Result.fltDesEsp := 0;
    Result.strCodSit := '';

    Result.strCodMar := '';
    Result.strDesMar := '';

    Result.fltBasIcm := 0;
    Result.fltAlqIcm := 0;
    Result.fltValIcm := 0;
    Result.fltBasRet := 0;
    Result.fltAlqRet := 0;
    Result.fltValRet := 0;
    Result.fltPerRed := 0;
    Result.fltPRedST := 0;

    Result.fltPRedST := 0;
    Result.fltValIva := 0;
    Result.fltValIpi := 0;
    Result.fltBasIpi := 0;
    Result.fltAlqIpi := 0;
    Result.strCodAbf := '';
    Result.strMen__S := '';

    Result.strDesNes := '';
    Result.strNumFCI := fTiraPipeEnter(qryDados.FieldByName('ITE_NUMFCI').AsString);

    Result.strNumLot := '';
    Result.strValLot := '';

    Result.strLocFis := '';

    Result.strMenFis := '';

    Result.fltBasPis := 0;
    Result.fltBasCof := 0;

    Result.fltAlqPis := 0;
    Result.fltAlqCof := 0;
    Result.fltBasPis := 0;

    Result.fltAlqCof := 0;
    Result.fltBasCof := 0;

    Result.fltValPis := 0;
    Result.fltValCof := 0;

    Result.strCstPis := '';
    Result.strCstCof := '';

    Result.strCSTIpi := '';

    Result.strEnqIpi := '';

    Result.fltBARTSP := 0;
    Result.fltVLRTSP := 0;
    Result.fltICOPPR := 0;

    Result.strDiferi := '';

    Result.fltTotFre := 0;
    Result.fltDesAce := 0;

    Result.strCodSLC := '';
    Result.strTriMun := '';
    Result.strCodListaServ := '';

    Result.strCoiCmp := '';
    Result.strNItemPed := '';
    Result.strPedCom := '';


    Result.strPedCom := AnsiReplaceStr(Result.strPedCom, #13#10, '');
    Result.strPedCom := LeftStr(Result.strPedCom, 15);

    Result.strImpDir := '';
    Result.strRICMPR := '';
    Result.strInfGar := '';

    Result.strCodLub := '';
    Result.strDesANP := '';
    Result.strCodOnu := '';
    Result.strDesOnu := '';
    Result.strCodigo := '';
    Result.strClaRis := '';
    Result.strGruEmb := '';

    Result.fltTotPes := 0;

    Result.fltImpPag := 0;
    Result.fltFedImp := 0;
    Result.fltEstImp := 0;
    Result.fltMunImp := 0;
    Result.fltImpPag := 0;

    Result.fltIcmOrg := 0;
    Result.fltVrdIcm := 0;
    Result.strMtdIcm := '';
    Result.strProPCD := '';

    Result.fltPerDevolvido := 0;
    Result.strRIcmPRAbf  := '';
    Result.strCodigoCEST := '';

    Result.strEniEcb := qryDados.FieldByName('ITE_ENIECB').AsString;
    Result.strIndEsc := qryDados.FieldByName('ITE_INDESC').AsString;
    Result.strCnpFab := qryDados.FieldByName('ITE_CNPFME').AsString;
    Result.strCdbFis := qryDados.FieldByName('ITE_CDBFIS').AsString;

  End;
end;

(*
  2.1 Quando o algarismo imediatamente seguinte ao último algarismo a ser conservado
  for inferior a 5, o último permanecerá sem modificação
  Exemplo: 1,333 3 arredondado à primeira decimal tornar-se-á:1,3

  2.2 Quando o algarismo imediatamente seguinte ao último algarismo a ser conservado
  for superior a 5, ou sendo 5, seguido de no mínimo um algarismo diferente de zero,
  o último algarismo a ser conservado deverá ser aumentado de uma unidade.
  Exemplo: 1,666 6 arredondado à primeira decimal tornar-se-á:1,7
  4,851 5 arredondado à primeira decimal torna-se-ão:4,9

  2.3 Quando o algarismo imediatamente seguinte ao último algarismo a ser conservado
  for 5 seguido de zeros, dever-se-á arredondar o algarismo a ser conservado para o
  algarismo par mais próximo. Conseqüentemente, o último algarismo a ser retido,
  se for ímpar, aumentará uma unidade.
  Exemplo: 4,550 0 arredondado à primeira decimal tornar-se-á:4,6

  2.4 Quando o algarismo imediatamente seguinte ao último a ser conservado for 5
  seguido de zeros, se for par o algarismo a ser conservado ele permanecerá sem
  modificação.
  Exemplo: 4,850 0 arredondado à primeira decimal tornar-se-á:4,8
*)
function TFonteDadosBDEnt.fArredondaABNT_NBR5891_77(fltValor: Double;
  intDecimais: Integer): Double;
  Var
    fltUltimosNumeros: Double;
    intPow: Int64;
    fltValorPow: Double;
    fltParteInteira: Double;
    intUltimoNumeroInteira: Integer;
    fltResto: Double;
begin
  intPow := Trunc(Power(10.0, intDecimais));
  fltValorPow := fRemoveDizimas(fltValor * intPow, 9);
  fltParteInteira := fParteInteira(fltValorPow);
  fltUltimosNumeros := Trunc(Frac(fltValorPow) * 100);

  If (fltUltimosNumeros > 50) Then
  Begin
    fltParteInteira := fltParteInteira + 1;
  End
  Else if (fltUltimosNumeros = 50) Then
  Begin
    intUltimoNumeroInteira := Round(Frac(fltParteInteira/10)*10);
    If Odd(intUltimoNumeroInteira) Then
      fltParteInteira := fltParteInteira + 1
    Else
    Begin
      fltResto := Frac(fltValorPow * 10);
      If CompareValue(fltResto, 0, 0.00001) = GreaterThanValue Then
        fltParteInteira := fltParteInteira + 1;
    End;
  End;

  Result := fltParteInteira / intPow;
end;

function TFonteDadosBDEnt.fBuscaAlqIBPT(strNcm: String; strEx: String; strCodEmp: String): TValorAliquotaIBPT;
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    strSQL,
    strEstEmp: String;
    ValorAliquotaIBPT: TValorAliquotaIBPT;

    function fRetEstadoCadEmp: String;
    Begin
      qryAux := fCriaQuery(Nil);
      qryAux.SQL.Add('SELECT ');
      qryAux.SQL.Add('  CID_ESTADO  ');
      qryAux.SQL.Add('FROM ');
      qryAux.SQL.Add('  CADEMP E ');
      qryAux.SQL.Add('JOIN CADCID ON CID_CODCID = E.EMP_CODCID ');
      qryAux.SQL.Add('WHERE ');
      qryAux.SQL.Add('  E.EMP_CODEMP = :CODEMP ');
      qryAux.ParamByName('CODEMP').AsString := strCodEmp;
      qryAux.Open;

      Result := qryAux.FieldByName('CID_ESTADO').AsString;

      FreeAndNil(qryAux);
    End;
begin

  Try

    FillChar(ValorAliquotaIBPT, SizeOf(TValorAliquotaIBPT), 0);

    Result := ValorAliquotaIBPT;

    strEstEmp := fRetEstadoCadEmp;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  IBP_ALQNAC, ';
    strSQL := strSQL + '  IBP_ALQIMP, ';
    strSQL := strSQL + '  IBP_ALQEST, ';
    strSQL := strSQL + '  IBP_ALQMUN  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADIBP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  IBP_N_C_M_ = :NCM AND';
    strSQL := strSQL + '  IBP_E_X___ = :E_X AND ';
    strSQL := strSQL + '  IBP_ESTADO = :EST ';

    qryAux := fCriaQuery(Nil);
    qryAux.Close;
    qryAux.SQL.Text := strSQL;
    qryAux.ParamByName('NCM').AsString := strNcm;
    qryAux.ParamByName('E_X').AsString := strEx;
    qryAux.ParamByName('EST').AsString := strEstEmp;
    qryAux.Open;

    If qryAux.IsEmpty Then
    Begin
      qryAux.Close;
      qryAux.ParamByName('NCM').AsString := LeftStr(strNcm,4);
      qryAux.ParamByName('E_X').AsString := strEx;
      qryAux.ParamByName('EST').AsString := strEstEmp;
      qryAux.Open;
    End;

    If qryAux.IsEmpty Then
    Begin
      qryAux.Close;
      qryAux.ParamByName('NCM').AsString := LeftStr(strNcm,2);
      qryAux.ParamByName('E_X').AsString := strEx;
      qryAux.ParamByName('EST').AsString := strEstEmp;
      qryAux.Open;
    End;

    If Not qryAux.IsEmpty Then
    Begin

      ValorAliquotaIBPT.fltNacional  := qryAux.FieldByName('IBP_ALQNAC').AsFloat;
      ValorAliquotaIBPT.fltImportado := qryAux.FieldByName('IBP_ALQIMP').AsFloat;
      ValorAliquotaIBPT.fltEstadual  := qryAux.FieldByName('IBP_ALQEST').AsFloat;
      ValorAliquotaIBPT.fltMunicipal := qryAux.FieldByName('IBP_ALQMUN').AsFloat;

      Result := ValorAliquotaIBPT;

    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TFonteDadosBDEnt.fRemoveDizimas(fltValor: Double;
  intDecimais: Integer): Double;
  Var
    intPow: Double;
begin
  intPow := Power(10, -intDecimais);
  Result := Trunc((fltValor / intPow) + 0.5) * intPow;
end;

function TFonteDadosBDEnt.fRetDesCla(strCodCfo: String): String;
begin
  If fCampoExiste('NATCFO', 'NAT_DESCRI') Then
    fCampoTabela('NAT_DESCRI', 'NATCFO', ['NAT_CODCFO'], [strCodCfo])
  Else
    fCampoTabela('CFO_NATOPE', 'CADCFO', ['CFO_CODCFO'], [strCodCfo]);
end;

procedure TFonteDadosBDEnt.pRetAlqPisCofins(var fltAlqPis, fltAlqCof: Double);
  Var
    strVal: String;
begin
  fltAlqPis := 0;
  fltAlqCof := 0;

  strVal := (fConfiguracao('ALPISP'));
  If (Not fEmptyStr(strVal)) Then
    fltAlqPis := StrToFloatDef(strVal, 0);

  strVal := (fConfiguracao('ALCOFP'));
  If (Not fEmptyStr(strVal)) Then
    fltAlqCof := StrToFloatDef(strVal, 0);
end;

procedure TFonteDadosBDEnt.pRetClassificacoesDevolucao;
begin
  objConfig.strClaDev := fTransform(fConfiguracao('CLADEV'), 4);
end;

procedure TFonteDadosBDEnt.pRetDadosNotaOrigem(var dtaDtaDoc: TDateTime);
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin

  If (dadosGerais.blnNfComp) And (Not fEmptyStr(dadosGerais.strDocOriNC)) Then
  Begin
    qryAux := fCriaQuery(Nil);
    qryAux.SQL.Add('SELECT ');
    qryAux.SQL.Add('  FIS_DTADOC ');
    qryAux.SQL.Add('FROM ');
    qryAux.SQL.Add('  CADFIS ');
    qryAux.SQL.Add('WHERE ');
    qryAux.SQL.Add('  FIS_NUMDOC = :NUMDOC AND ');
    qryAux.SQL.Add('  FIS_CODEMP = :CODEMP AND ');
    qryAux.SQL.Add('  IFNULL(FIS_SERIE_, "") = :SERIE_ AND ');
    qryAux.SQL.Add('  FIS_ACESSO = :ACESSO ');

    qryAux.ParamByName('NUMDOC').AsString := dadosGerais.strDocOriNC;
    qryAux.ParamByName('CODEMP').AsString := dadosGerais.strCodEmp;
    qryAux.ParamByName('SERIE_').AsString := dadosGerais.strSerOriNC;
    qryAux.ParamByName('ACESSO').AsString := dadosGerais.strAceOriNC;

    qryAux.Open;

    If (qryAux.IsEmpty) Then
    Begin
      qryAux.SQL.Clear;
      qryAux.SQL.Add('SELECT ');
      qryAux.SQL.Add('  FIS_DTADOC ');
      qryAux.SQL.Add('FROM ');
      qryAux.SQL.Add('  CADFIS ');
      qryAux.SQL.Add('WHERE ');
      qryAux.SQL.Add('  FIS_NUMDOC = :NUMDOC AND ');
      qryAux.SQL.Add('  FIS_CODEMP = :CODEMP AND ');
      qryAux.SQL.Add('  IFNULL(FIS_SERIE_, "") = :SERIE_ AND ');
      qryAux.SQL.Add('	(FIS_ESPDOC = "NF" OR FIS_ESPDOC = "EL") ');

      qryAux.ParamByName('NUMDOC').AsString := dadosGerais.strDocOriNC;
      qryAux.ParamByName('CODEMP').AsString := dadosGerais.strCodEmp;
      qryAux.ParamByName('SERIE_').AsString := dadosGerais.strSerOriNC;

      qryAux.Open;

      If (qryAux.IsEmpty) Then
        Raise Exception.Create('Nota de origem (' + dadosGerais.strDocOriNC + ') não encontrada.');
    End;

    dtaDtaDoc := qryAux.FieldByName('FIS_DTADOC').AsDateTime;

    FreeAndNil(qryAux);
  End;
end;

function TFonteDadosBDEnt.fTemDados: Boolean;
begin
  Result := (intPosAtual < lstItens.Count);
end;

function TFonteDadosBDEnt.fTiraPipeEnter(const strTexto: String): String;
begin
  Result := strTexto;
  Result := AnsiReplaceStr(Result, '|', '');
  Result := AnsiReplaceStr(Result, #10, '');
  Result := AnsiReplaceStr(Result, #13, '');
end;

procedure TFonteDadosBDEnt.pCarregaAtividadeConstrutora;
begin
  objConfig.strVS_CliAti := fRetAtividades;
end;

procedure TFonteDadosBDEnt.pCarregaCfgDesFab(var blnDesFab: Boolean);
  Var
    strVal: String;
begin
  blnDesFab := True;

  strVal := fConfiguracao('DESFAB');

  If (Not fEmptyStr(strVal)) Then
    blnDesFab := (fConfiguracao('DESFAB') = 'S');
end;

procedure TFonteDadosBDEnt.pCarregaDuplicatas(dadosGerais: TDadosGerais);
  Var
    fltTotVPar: Double;
    intQtdVPar: Integer;
    blnUsaVPar: Boolean;
    intContador: Integer;
    strSQLUnion: String;
begin

  If Not Assigned(qryDuplicatas) Then
  Begin
    qryDuplicatas := fCriaQuery(Nil);
    qryDuplicatas.SQL.Add('SELECT ');
    qryDuplicatas.SQL.Add('  CTR_NUMDUP, ');
    qryDuplicatas.SQL.Add('  CTR_PARCEL, ');
    qryDuplicatas.SQL.Add('  CTR_DTAVEN, ');

    If (objConfigInterna.blnAgrDup) Then
      qryDuplicatas.SQL.Add('  SUM(CTR_VALORI) AS CTR_VALORI, ')
    Else
      qryDuplicatas.SQL.Add('  CTR_VALORI, ');

    qryDuplicatas.SQL.Add('  CTR_VALDUP,  ');
    qryDuplicatas.SQL.Add('  CTR_SEQBAI   ');
    qryDuplicatas.SQL.Add('FROM ');
    qryDuplicatas.SQL.Add('  CADREC ');
    qryDuplicatas.SQL.Add('WHERE ');
    qryDuplicatas.SQL.Add('  CTR_NUMDUP = :NUMDUP AND ');
    qryDuplicatas.SQL.Add('  CTR_ESPDOC = :ESPDOC AND ');
    if fCampoExiste('CADREC', 'CTR_SERIE_') Then
      qryDuplicatas.SQL.Add('  CTR_SERIE_ = :SERIE_ AND ');
    qryDuplicatas.SQL.Add('  CTR_CODEMP = :CODEMP AND ');
    qryDuplicatas.SQL.Add('  CTR_CODCLI = :CODCLI     ');

    If (objConfigInterna.blnAgrDup) Then
    Begin
      qryDuplicatas.SQL.Add('GROUP BY ');
      qryDuplicatas.SQL.Add('  CTR_PARCEL, ');
      qryDuplicatas.SQL.Add('  CTR_DTAVEN  ');
    End;

    strSQLUnion := AnsiReplaceStr(qryDuplicatas.SQL.Text, 'CADREC', 'DUPAGR');

    qryDuplicatas.SQL.Add('  UNION ALL ');

    qryDuplicatas.SQL.Add( strSQLUnion );

    qryDuplicatas.SQL.Add('ORDER BY ');

    If (objConfigInterna.blnAgrDup) Then
      qryDuplicatas.SQL.Add('  CTR_PARCEL, CTR_DTAVEN ') //CTR_PARCEL,  CTR_DTAVEN
    Else
      qryDuplicatas.SQL.Add('  CTR_PARCEL, CTR_DTAVEN, CTR_VALDUP ');//CTR_PARCEL,  CTR_DTAVEN, CTR_VALDUP

    qryDuplicatas.ParamByName('NUMDUP').AsString := qryDados.FieldByName('GER_NUMDOC').AsString;
    qryDuplicatas.ParamByName('ESPDOC').AsString := qryDados.FieldByName('GER_ESPDOC').AsString;
    if fCampoExiste('CADREC', 'CTR_SERIE_') Then
      qryDuplicatas.ParamByName('SERIE_').AsString := qryDados.FieldByName('GER_SERIE_').AsString;
    qryDuplicatas.ParamByName('CODEMP').AsString := qryDados.FieldByName('GER_CODEMP').AsString;
    qryDuplicatas.ParamByName('CODCLI').AsString := qryDados.FieldByName('GER_CODCLI').AsString;
    qryDuplicatas.Open;
  End;

  fltTotVPar := 0;
  intQtdVPar := 0;

  If blnDupCND Then
  Begin
    For intContador := 0 To 23 Do
      If arrDuplicataCND[intContador].curValor > 0 Then
      Begin
        fltTotVPar := fltTotVPar + arrDuplicataCND[intContador].curValor;
        intQtdVPar := intQtdVPar + 1;
      End;
  End
  Else
  Begin
    For intContador := 1 To 12 Do
    Begin
      If qryDados.FieldByName('GER_VPAR' + fStrZero(intContador, 2)).AsFloat = 0.00 Then
        Break;

      fltTotVPar := fltTotVPar + qryDados.FieldByName('GER_VPAR' + fStrZero(intContador, 2)).AsFloat;
      intQtdVPar := intQtdVPar + 1;
    End;
  End;

  blnUsaVPar := (intQtdVPar = qryDuplicatas.RecordCount) And
                (fFormataFloat(fltTotVPar, 2) = fFormataFloat(qryDados.FieldByName('GER_VLRCON').AsFloat, 2));

  SetLength(dadosGerais.arrDuplicatas, 0);
  SetLength(dadosGerais.arrDuplicatas, qryDuplicatas.RecordCount);
  intContador := 0;

  qryDuplicatas.First;
  While (Not qryDuplicatas.Eof) Do
  Begin
    dadosGerais.arrDuplicatas[intContador] := TDuplicatas.Create;

    {*****************************************************************************}
    {* TENTATIVA DE IDENTIFICAR A DUPLICATA DE CRÉDITO PARA INCLUIR A SILGA "CR" *}
    {* ALTERAÇÃO SOLICITADA PELA PIG ATRAVÉS DO REQUISITO 45864.                 *}
    {**************************************************************************PZ*}
    If (Not objConfigInterna.blnAgrDup)                      And
       (qryDuplicatas.FieldByName('CTR_VALDUP').AsFloat = 0) Then
    Begin
      If (qryDuplicatas.FieldByName('CTR_SEQBAI').AsInteger > 0) Then
        dadosGerais.arrDuplicatas[intContador].strNumDup := qryDuplicatas.FieldByName('CTR_NUMDUP').AsString + ' CR'
      Else
        dadosGerais.arrDuplicatas[intContador].strNumDup := qryDuplicatas.FieldByName('CTR_NUMDUP').AsString + ' q';
    End
    Else
    Begin
      dadosGerais.arrDuplicatas[intContador].strNumDup := qryDuplicatas.FieldByName('CTR_NUMDUP').AsString + '/' +
                                                          qryDuplicatas.FieldByName('CTR_PARCEL').AsString;
    End;

    dadosGerais.arrDuplicatas[intContador].dtaDtaVen := qryDuplicatas.FieldByName('CTR_DTAVEN').AsDateTime;

    If blnDupCND Then
    Begin
      If (arrDuplicataCND[intContador].curValor <> 0.00) And blnUsaVPar Then
        dadosGerais.arrDuplicatas[intContador].fltValDup := arrDuplicataCND[intContador].curValor
      Else
        dadosGerais.arrDuplicatas[intContador].fltValDup := qryDuplicatas.FieldByName('CTR_VALORI').AsFloat;
    End
    Else
    Begin
      If (qryDados.FieldByName('GER_VPAR' + fStrZero(intContador+1, 2)).AsFloat <> 0.00) And blnUsaVPar Then
        dadosGerais.arrDuplicatas[intContador].fltValDup := qryDados.FieldByName('GER_VPAR' + fStrZero(intContador+1, 2)).AsFloat
      Else
        dadosGerais.arrDuplicatas[intContador].fltValDup := qryDuplicatas.FieldByName('CTR_VALORI').AsFloat;
    End;

    qryDuplicatas.Next;
    Inc(intContador);
  End;
end;

procedure TFonteDadosBDEnt.pCarregaDuplicatasOutrasNotas(dadosGerais: TDadosGerais);
  Var
    intContador: Integer;
    intQtdDup: Integer;
    strCndPag: String;
    arrDatas: Array Of TDateTime;
    dtaDtaBas: TDateTime;
begin
  If fEmptyStr(dadosGerais.strCondPagamento) Then
    Exit;

  If (qryDados.FindField('GER_OPCDOC') <> Nil) And
     (qryDados.FieldByName('GER_OPCDOC').AsString = 'CA') Then
    Exit;

  If (Pos(dadosGerais.strClaFis, '5902_6902_5903_6903_') > 0) Then
    Exit;

  If (qryDados.FieldByName('GER_FATNOT').AsFloat > 0)    Or
     (qryDados.FieldByName('FIS_NOTESP').AsString = 'S') Or
     (fClienteFilial(dadosGerais.strCodCli))             Then
  Begin
    strCndPag := dadosGerais.strCondPagamento;

    intQtdDup := StrToInt(LeftStr(strCndPag, 2));
    Delete(strCndPag, 1, 2);

    dtaDtaBas := Date;
    If (dadosGerais.dtaDtaEnt > 0) And (dadosGerais.dtaDtaEnt < dtaDtaBas) Then
      dtaDtaBas := dadosGerais.dtaDtaEnt;

    SetLength(arrDatas, intQtdDup);
    For intContador := 1 To intQtdDup Do
    Begin
      arrDatas[intContador-1] := dtaDtaBas + StrToInt(Copy(strCndPag, 1, 3));
      Delete(strCndPag, 1, 3);
    End;

    SetLength(dadosGerais.arrDuplicatas, intQtdDup);
    For intContador := 1 To intQtdDup Do
    Begin
      If blnDupCND Then
      Begin
        If (arrDuplicataCND[intContador-1].curValor <> 0) Then
        Begin
          dadosGerais.arrDuplicatas[intContador-1] := TDuplicatas.Create;
          dadosGerais.arrDuplicatas[intContador-1].strNumDup := dadosGerais.strNumDoc + '/' + Chr(64+intContador);
          dadosGerais.arrDuplicatas[intContador-1].dtaDtaVen := arrDatas[intContador-1];
          dadosGerais.arrDuplicatas[intContador-1].fltValDup := arrDuplicataCND[intContador-1].curValor;
        End;
      End
      Else
      Begin
        If (qryDados.FieldByName('GER_VPAR' + fStrZero(intContador, 2)).AsFloat <> 0) Then
        Begin
          dadosGerais.arrDuplicatas[intContador-1] := TDuplicatas.Create;
          dadosGerais.arrDuplicatas[intContador-1].strNumDup := dadosGerais.strNumDoc + '/' + Chr(64+intContador);
          dadosGerais.arrDuplicatas[intContador-1].dtaDtaVen := arrDatas[intContador-1];
          dadosGerais.arrDuplicatas[intContador-1].fltValDup := qryDados.FieldByName('GER_VPAR' + fStrZero(intContador, 2)).AsFloat;
        End;
      End;
    End;
  End;
end;

procedure TFonteDadosBDEnt.pCarregaEmpresaNFSe;
begin
  objConfigInterna.strEmpNFSe := fConfiguracao('EMPSER');
end;

procedure TFonteDadosBDEnt.pCarregaItensNotaComp(dadosGerais: TDadosGerais; strAutIncCadFis: String);

  procedure pAdicionaCampoIteCom(strCampo: String; strValEmpty: String);
  begin
    If fCampoExiste('ITECOM', strCampo) Then
      qryItensNotaComp.SQL.Add('  , ITECOM.' + strCampo + ' AS ' + strCampo + ' ')
    Else
      qryItensNotaComp.SQL.Add('  , ' + strValEmpty + ' AS ' + strCampo + ' ');
  end;

  procedure pAdicionaCampoCadIte(strCampo: String; strValEmpty: String);
  begin
    If fCampoExiste('CADITE', strCampo) Then
      qryItensNotaComp.SQL.Add('  , CADITE.' + strCampo + ' AS ' + strCampo + ' ')
    Else
      qryItensNotaComp.SQL.Add('  , ' + strValEmpty + ' AS ' + strCampo + ' ');
  end;

  Var
    blnExisteComIcd : Boolean;

begin
  If dadosGerais.blnNfComp And fTabelaExiste('ITECOM') And Not Assigned(qryItensNotaComp) Then
  Begin
    blnExisteComIcd := fTabelaExiste('COMICD');

    qryItensNotaComp := fCriaQuery(Nil);

    With qryItensNotaComp, SQL Do
    Begin
      Close;
      Clear;
      Add('SELECT ');
      Add('  ITC_CODITE, ');
      Add('  ITC_DESCRI, ');
      Add('  ITC_REFERE, ');
      Add('  UNI_SIGUNI, ');
      Add('  ITC_CODFIS, ');
      Add('  ITC_CLAFIS, ');
      Add('  ITC_BASICM, ');
      Add('  ITC_ALQICM, ');
      Add('  ITC_VALICM, ');
      Add('  ITC_BASRET, ');
      Add('  ITC_ALQRET, ');
      Add('  ITC_VALRET, ');
      Add('  ITC_BASIPI, ');
      Add('  ITC_ALQIPI, ');
      Add('  ITC_VALIPI, ');
      Add('  ITE_CLAIPI  ');

      If fCampoExiste('CADITE', 'ITE_EXCIPI') Then
        Add('  , CADITE.ITE_EXCIPI AS ITE_EXCIPI ')
      Else
        Add('  , " " AS ITE_EXCIPI ');

      If fCampoExiste('CADITE', 'ITE_CDCEST') Then
      Begin
        Add('  , CADITE.ITE_CDCEST ');
      End
      Else If fConfiguracao('CESTPD') <> '' Then
      Begin
        Add('  , ' + fConfiguracao('CESTPD') + ' AS ITE_CDCEST ');
      End
      Else Begin
        Add('  , "" AS ITE_CDCEST ');
      End;

      If fCampoExiste('ITECOM', 'ITC_VALCOM') Then
        Add('  , ITECOM.ITC_VALCOM AS ITC_VALCOM ')
      Else
        Add('  , 0.00 AS ITC_VALCOM ');

      pAdicionaCampoCadIte('ITE_INDESC', '"S"');
      pAdicionaCampoCadIte('ITE_CNPFME', '""');
      pAdicionaCampoCadIte('ITE_CDBFIS', '""');
      pAdicionaCampoCadIte('ITE_ENIECB', '"N"');

      pAdicionaCampoIteCom('ITC_CSTPIS', '""');
      pAdicionaCampoIteCom('ITC_CSTCOF', '""');
      pAdicionaCampoIteCom('ITC_BASPIS', '0.00');
      pAdicionaCampoIteCom('ITC_BASCOF', '0.00');
      pAdicionaCampoIteCom('ITC_ALQPIS', '0.00');
      pAdicionaCampoIteCom('ITC_ALQCOF', '0.00');
      pAdicionaCampoIteCom('ITC_VALPIS', '0.00');
      pAdicionaCampoIteCom('ITC_VALCOF', '0.00');

      If (blnExisteComIcd) Then
      Begin
        Add('  ,ITECOM.AUTOINCREM AS ICD_AUTINC ');
        Add('  ,ICD_ALQINE ');
        Add('  ,ICD_ALQUFD ');
        Add('  ,ICD_BCUFDE ');
        Add('  ,ICD_PERFCP ');
        Add('  ,ICD_PERPAR ');
        Add('  ,ICD_VALDES ');
        Add('  ,ICD_VALFCP ');
        Add('  ,ICD_VALORI ');
        Add('  ,ICD_BASFCP ');
      End;

      Add('FROM ');
      Add('  ITECOM ');
      Add('  INNER JOIN CADITE ON ITE_CODITE = ITC_CODITE ');
      Add('  LEFT  JOIN CADUNI ON UNI_CODUNI = ITC_UNIDAD ');

      If (blnExisteComIcd) Then
        Add(' LEFT JOIN COMICD ON COMICD.ICD_SEQITE = ITECOM.AUTOINCREM ');

      Add('WHERE ');
      Add('  ITC_SEQFIS = :SEQFIS ');

      ParamByName('SEQFIS').AsString := strAutIncCadFis;
      Open;

      SetLength(dadosGerais.arrItensNfComp, RecordCount);

      First;
      While (Not Eof) Do
      Begin
        dadosGerais.arrItensNfComp[RecNo-1]           := TItemNfComp.Create;

        dadosGerais.arrItensNfComp[RecNo-1].strAutInc := '';
        dadosGerais.arrItensNfComp[RecNo-1].strCodIte := FieldByName('ITC_CODITE').AsString;
        dadosGerais.arrItensNfComp[RecNo-1].strDesIte := FieldByName('ITC_DESCRI').AsString;
        dadosGerais.arrItensNfComp[RecNo-1].strCodFis := FieldByName('ITC_CODFIS').AsString;
        dadosGerais.arrItensNfComp[RecNo-1].strClaFis := FieldByName('ITC_CLAFIS').AsString;

        If (FieldByName('ITE_CDCEST').AsString = '0000000') Then
          dadosGerais.arrItensNfComp[RecNo-1].strCdCEST := ''
        Else
          dadosGerais.arrItensNfComp[RecNo-1].strCdCEST := FieldByName('ITE_CDCEST').AsString;

        dadosGerais.arrItensNfComp[RecNo-1].strUnidad := FieldByName('UNI_SIGUNI').AsString;
        dadosGerais.arrItensNfComp[RecNo-1].strClaIpi := FieldByName('ITE_CLAIPI').AsString;
        dadosGerais.arrItensNfComp[RecNo-1].strExcIpi := FieldByName('ITE_EXCIPI').AsString;
        dadosGerais.arrItensNfComp[RecNo-1].fltBasIcm := FieldByName('ITC_BASICM').AsFloat;
        dadosGerais.arrItensNfComp[RecNo-1].fltAlqIcm := FieldByName('ITC_ALQICM').AsFloat;
        dadosGerais.arrItensNfComp[RecNo-1].fltValIcm := FieldByName('ITC_VALICM').AsFloat;
        dadosGerais.arrItensNfComp[RecNo-1].fltBasRet := FieldByName('ITC_BASRET').AsFloat;
        dadosGerais.arrItensNfComp[RecNo-1].fltAlqRet := FieldByName('ITC_ALQRET').AsFloat;
        dadosGerais.arrItensNfComp[RecNo-1].fltValRet := FieldByName('ITC_VALRET').AsFloat;
        dadosGerais.arrItensNfComp[RecNo-1].fltBasIpi := FieldByName('ITC_BASIPI').AsFloat;
        dadosGerais.arrItensNfComp[RecNo-1].fltAlqIpi := FieldByName('ITC_ALQIPI').AsFloat;
        dadosGerais.arrItensNfComp[RecNo-1].fltValIpi := FieldByName('ITC_VALIPI').AsFloat;
        dadosGerais.arrItensNfComp[RecNo-1].fltValCom := FieldByName('ITC_VALCOM').AsFloat;
        dadosGerais.arrItensNfComp[RecNo-1].strCstPis := FieldByName('ITC_CSTPIS').AsString;
        dadosGerais.arrItensNfComp[RecNo-1].strCstCof := FieldByName('ITC_CSTCOF').AsString;
        dadosGerais.arrItensNfComp[RecNo-1].fltBasPis := FieldByName('ITC_BASPIS').AsFloat;
        dadosGerais.arrItensNfComp[RecNo-1].fltBasCof := FieldByName('ITC_BASCOF').AsFloat;
        dadosGerais.arrItensNfComp[RecNo-1].fltAlqPis := FieldByName('ITC_ALQPIS').AsFloat;
        dadosGerais.arrItensNfComp[RecNo-1].fltAlqCof := FieldByName('ITC_ALQCOF').AsFloat;
        dadosGerais.arrItensNfComp[RecNo-1].fltValPis := FieldByName('ITC_VALPIS').AsFloat;
        dadosGerais.arrItensNfComp[RecNo-1].fltValCof := FieldByName('ITC_VALCOF').AsFloat;

        If (blnExisteComIcd) Then
        Begin
          dadosGerais.arrItensNfComp[RecNo-1].strAutInc := FieldByName('ICD_AUTINC').AsString;
          dadosGerais.arrItensNfComp[RecNo-1].fltBasDes := FieldByName('ICD_BCUFDE').AsFloat;
          dadosGerais.arrItensNfComp[RecNo-1].fltPerFCP := FieldByName('ICD_PERFCP').AsFloat;
          dadosGerais.arrItensNfComp[RecNo-1].fltAlqUfd := FieldByName('ICD_ALQUFD').AsFloat;
          dadosGerais.arrItensNfComp[RecNo-1].fltAlqIne := FieldByName('ICD_ALQINE').AsFloat;
          dadosGerais.arrItensNfComp[RecNo-1].fltPerPar := FieldByName('ICD_PERPAR').AsFloat;
          dadosGerais.arrItensNfComp[RecNo-1].fltValFCP := FieldByName('ICD_VALFCP').AsFloat;
          dadosGerais.arrItensNfComp[RecNo-1].fltValDes := FieldByName('ICD_VALDES').AsFloat;
          dadosGerais.arrItensNfComp[RecNo-1].fltValOri := FieldByName('ICD_VALORI').AsFloat;
          dadosGerais.arrItensNfComp[RecNo-1].fltBasFCP := FieldByName('ICD_BASFCP').AsFloat;
        End;

        Next;
      End;
    End;
  End;
end;

procedure TFonteDadosBDEnt.pCarregaTotalDuplicataRecebida(dadosGerais: TDadosGerais);
  Var
    intContador: Integer;
begin
  If (qryDados.FieldByName('GER_DUPREC').AsFloat > 0)  And
     (qryDados.FieldByName('GER_FATNOT').AsFloat <= 0) And
     (qryDados.FieldByName('FIS_NOTESP').AsString <> 'S') Then
  Begin
    SetLength(dadosGerais.arrDuplicatas, Length(dadosGerais.arrDuplicatas) + 1);

    For intcontador := Length(dadosGerais.arrDuplicatas) -1 downto 1 Do
    Begin
      dadosGerais.arrDuplicatas[intContador] := dadosGerais.arrDuplicatas[intContador -1];
    End;

    dadosGerais.arrDuplicatas[0] := TDuplicatas.Create;
    dadosGerais.arrDuplicatas[0].strNumDup := dadosGerais.strNumDoc + ' q';
    dadosGerais.arrDuplicatas[0].dtaDtaVen := dadosGerais.dtaDtaEnt;
    dadosGerais.arrDuplicatas[0].fltValDup := qryDados.FieldByName('GER_DUPREC').AsFloat;
  End;
end;

procedure TFonteDadosBDEnt.pGravaTabela(objItem: TDadosItem; strTabela: String);
begin
  //mantido por compatibilidade com a IFonteDados (é usado na untUtilBD).
end;

function TFonteDadosBDEnt.fCriaObjetoLogPerformance(intCodigo: Integer; strMensagem: String): TLogPerformance;
begin
  //Função em desuso, mantida apenas por compatibilidade;

  Result := Nil;
  Exit;

  Result := TLogPerformance.Create;
  Result.strOrigem := Self.ClassName;
  Result.strNumDoc := FNumDoc;
  Result.strEspDoc := FEspDoc;
  Result.strCodEmp := FCodEmp;
  Result.strCodCli := FCodCli;
  Result.strSerie := FSerie;
  Result.strTipFc := '';
  Result.dtaHoraInicial := nOw();
  Result.intCodigo := intCodigo;
  Result.strMensagem := strMensagem;
end;

procedure TFonteDadosBDEnt.pCarregarDados;
  Const
    STR_CLIENTE_CONSUMIDOR = 'CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%"';
  Var
    strSQL   : String;
    strSQLNot: String;
    strTabAbf: String;
    strCadFis: String;
    blnBaEIPI: Boolean;
    blnVaEIPI: Boolean;

    blnBaERet: Boolean;
    blnVaERet: Boolean;

    blnCadFaz: Boolean;

    blnNSRBru: Boolean;

    strSelectTraRed: String;
    strWhereTraRed_: String;

  Const
    strIcmOrg = 'MOVGER.GER_ICMORG AS GER_ICMORG';
    strChvNfe = 'AUX_CHVNFE AS GER_CHVNFE';
    strNumCOO = 'AUX_NUMCOO AS GER_NUMCOO';
    strNumSer = 'AUX_NUMSER AS GER_NUMSER';
    strNumUSU = 'AUX_NUMUSU AS GER_NUMUSU';
    strTipDoc = 'AUX_TIPDOC AS GER_TIPDOC';
    strEst_Dv = 'AUX_EST_DV AS GER_EST_DV';
    strNumero = 'AUX_NUMERO AS GER_NUMERO';
    strSerie_ = 'AUX_SERIE_ AS GER_SERIE1';
    strModelo = 'AUX_MODELO AS GER_MODELO';
    strCPFCNP = 'AUX_CPFCNP AS GER_CPFCNP';
    strEstado = 'AUX_ESTADO AS GER_ESTADO';
    strMesAno = 'AUX_MESANO AS GER_MESANO';
    strComVal = '"N"        AS GER_COMVAL';
    strVrdIcm = 'AUX_VRDICM AS AUX_VRDICM';

    function fConsumid(const strCampoGer, strCampoCon: String): String;
    begin
      Result := 'IF(CLICON.CON_C_P_F_ IS NULL, MOVGER.' + strCampoGer + ', CLICON.' + strCampoCon + ') '
    end;

    function fFazenda(const strCampoCli, strCampoFaz: String): String;
    begin
      If Not blnCadFaz Then
        Result := strCampoCli
      Else
        Result := 'IF(FAZ_CODFAZ IS NULL, ' + strCampoCli + ', ' + strCampoFaz + ') '
    end;

    function fOutrasSaidasConEqu: Boolean;
    begin
      Result := (fTabelaExiste('MOVTRI')) And
        (fCampoExiste('MOVTRI', 'DET_NCMITE'));
    end;

    procedure pAdicionaCampoCadIte(strCampo: String; strValEmpty: String);
    begin
      If fCampoExiste('CADITE', strCampo) Then
        strSQL := strSQL + ' CADITE.' + strCampo + ' AS ' + strCampo + ',  '
      Else
        strSQL := strSQL + ' ' + strValEmpty + ' AS ' + strCampo + ',  ';
    end;

    function fGetSQLMovGer(strCadFis: String): String;
    var
      intAux : Integer;
    begin

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  CADFIS.AUTOINCREM AS FIS_AUTOINCREM,  ';
      strSQL := strSQL + '  MOVDET.AUTOINCREM AS DET_AUTOINCREM,  ';
      strSQL := strSQL + '  "MOVDET"          AS CHAVE_TABELA,    ';
      strSQL := strSQL + '  MOVDET.DET_SEQGER AS CHAVE_DUPLICATA, ';

      strSQL := strSQL + '  MOVGER.GER_ESPDOC, ';
      strSQL := strSQL + '  MOVGER.GER_CODEMP, ';

      If FTip_FC = 'C' Then
      Begin
        strSQL := strSQL + '  MOVGER.GER_CODCLI, ';
        strSQL := strSQL + '  IF(' + STR_CLIENTE_CONSUMIDOR + ', ' +                                                                               '"S", "N") AS GER_CONSUM, ';
        strSQL := strSQL + '  " " AS GER_MATREV, ';
        strSQL := strSQL + '  IF(' + STR_CLIENTE_CONSUMIDOR + ', ' + fConsumid('GER_CGCCON', 'CON_C_P_F_') + ', ' + fFazenda('CLI_C_G_C_', 'FAZ_C_G_C_') + ') AS GER_CGCCON, ';
        strSQL := strSQL + '  IF(' + STR_CLIENTE_CONSUMIDOR + ', ' + fConsumid('GER_NOMCON', 'CON_NOMCON') + ', ' + fFazenda('CLI_NOMCLI', 'CLI_NOMCLI') + ') AS GER_NOMCON, ';
        strSQL := strSQL + '  IF(' + STR_CLIENTE_CONSUMIDOR + ', ' + fConsumid('GER_NOMCON', 'CON_NOMCON') + ', ' + fFazenda('CLI_NOMCLI', 'CLI_NOMCLI') + ') AS GER_NOMFAN, ';
        strSQL := strSQL + '  IF(' + STR_CLIENTE_CONSUMIDOR + ', ' + fConsumid('GER_ENDCON', 'CON_ENDERE') + ', ' + fFazenda('CLI_ENDERE', 'FAZ_NOMFAZ') + ') AS GER_ENDERE, ';
        strSQL := strSQL + '  IF(' + STR_CLIENTE_CONSUMIDOR + ', "", '                                            + fFazenda('CLI_ENDNUM', 'NULL'      ) + ') AS GER_ENDNUM, ';
        strSQL := strSQL + '  IF(' + STR_CLIENTE_CONSUMIDOR + ', "", '                                            + fFazenda('CLI_ENDCOM', 'NULL'      ) + ') AS GER_ENDCOM, ';
        strSQL := strSQL + '  IF(' + STR_CLIENTE_CONSUMIDOR + ', ' + fConsumid('GER_BAICON', 'CON_BAIRRO') + ', ' + fFazenda('CLI_BAIRRO', 'FAZ_BAIRRO') + ') AS GER_BAICON, ';
        strSQL := strSQL + '  IF(' + STR_CLIENTE_CONSUMIDOR + ', ' + fConsumid('GER_CIDCON', 'CON_CODCID') + ', ' + fFazenda('CLI_CODCID', 'FAZ_CODCID') + ') AS GER_CIDCON, ';
        strSQL := strSQL + '  IF(' + STR_CLIENTE_CONSUMIDOR + ', ' + fConsumid('GER_CEPCON', 'CON_C_E_P_') + ', ' + fFazenda('CLI_C_E_P_', 'FAZ_C_E_P_') + ') AS GER_CEPCON, ';
        strSQL := strSQL + '  IF(' + STR_CLIENTE_CONSUMIDOR + ', ' + fConsumid('GER_TELCON', 'CON_FONE01') + ', ' + fFazenda('CLI_FONE01', 'CLI_FONE01') + ') AS GER_TELCON, ';
        strSQL := strSQL + '  IF(' + STR_CLIENTE_CONSUMIDOR + ', ' + fConsumid('GER_IESCON', 'CON_I_E_S_') + ', ' + fFazenda('CLI_I_E_S_', 'FAZ_I_E_S_') + ') AS GER_IESCON, ';
        strSQL := strSQL + '  CC.CID_ESTADO AS GER_ESTCON, ';
        strSQL := strSQL + '  CC.CID_NOMCID AS GER_NOMCID, ';
        strSQL := strSQL + '  CC.CID_CODPAI AS GER_CODPAI, ';
        {***************************************************}
        {* SE O CAMPO GER_EMLCON EXISTIR NA TABELA MOVGER, *}
        {* PEGA O E-MAIL DO CLIENTE "CONSUMIDOR"           *}
        {************************************************RV*}
        If fCampoExiste('MOVGER', 'GER_EMLCON') Then
          strSQL := strSQL + '  IF(' + STR_CLIENTE_CONSUMIDOR + ', ' + fConsumid('GER_EMLCON', 'CON_EMLCON') + ', ' + fFazenda('CLI_EMAIL3', 'CLI_EMAIL3') + ') AS GER_EMAIL_, '
        Else
          strSQL := strSQL + '  CLI_EMAIL3 AS GER_EMAIL_, ';

        strSQL := strSQL + ' CLI_SUFRAM AS GER_SUFRAM, ';

        strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%", "", CLI_EMAIL2)                AS GER_EMAIL2, ';
        strSQL := strSQL + '  CLI_DIFERI AS GER_DIFERI, ';

        If fCampoExiste('AUXMOV', 'AUX_RETISS') Then
          strSQL := strSQL + '  AUX_RETISS AS GER_RETISS, '
        Else
          strSQL := strSQL + '  CLI_RETISS AS GER_RETISS, ';

        If fCampoExiste('AUXMOV', 'AUX_NOTPAU') Then
          strSQL := strSQL + '  AUX_NOTPAU AS GER_NOTPAU, '
        Else
          strSQL := strSQL + '  "S" AS GER_NOTPAU, ';

        If fCampoExiste('MOVGER', 'GER_CONSUM') And (fConfiguracao('USOREV') = 'S') Then
          strSQL := strSQL + '  IF((GER_CONSUM = "S") OR (GER_CONSUM = "N"), GER_CONSUM, CLI_CONSUM) AS GER_CLICON, '
        Else
          strSQL := strSQL + '  CLI_CONSUM AS GER_CLICON, ';

        strSQL := strSQL + '  CLI_ZONFRA AS GER_ZONFRA, ';
        strSQL := strSQL + '  CLI_CODATI AS GER_CODATI, ';

        If fCampoExiste('MOVGER', 'GER_CSLRET') Then
        Begin
          strSQL := strSQL + '  MOVGER.GER_PISRET, ';
          strSQL := strSQL + '  MOVGER.GER_COFRET, ';
          strSQL := strSQL + '  MOVGER.GER_IRFRET, ';
          strSQL := strSQL + '  MOVGER.GER_CSLRET, ';
          strSQL := strSQL + '  MOVGER.GER_VLSGSO, ';
        End
        Else
        Begin
          strSQL := strSQL + '  0.00 AS GER_PISRET, ';
          strSQL := strSQL + '  0.00 AS GER_COFRET, ';
          strSQL := strSQL + '  0.00 AS GER_IRFRET, ';
          strSQL := strSQL + '  0.00 AS GER_CSLRET, ';
          strSQL := strSQL + '  0.00 AS GER_VLSGSO, ';
        End;

        If fCampoExiste('CADCLI', 'CLI_PRORUR') Then
          strSQL := strSQL + '  CLI_PRORUR AS GER_PRORUR, '
        Else
          strSQL := strSQL + '  "N"        AS GER_PRORUR, ';

        If fCampoExiste('CADCLI', 'CLI_BENREI') Then
          strSQL := strSQL + '  CLI_BENREI AS GER_BENREI, '
        Else
          strSQL := strSQL + '  "N"        AS GER_BENREI, ';

        If fCampoExiste('CADCLI', 'CLI_MICEMP') Then
          strSQL := strSQL + '  CLI_MICEMP AS GER_MICEMP, '
        Else
          strSQL := strSQL + '  "N"        AS GER_MICEMP, ';

        strSQL := strSQL + ' IF(' + STR_CLIENTE_CONSUMIDOR + ', "S" ,';
        If fCampoExiste('CADCLI', 'CLI_IESUNI') Then
          strSQL := strSQL + '  CLI_IESUNI) AS GER_IESUNI, '
        Else
          strSQL := strSQL + '  "N"       ) AS GER_IESUNI, ';

        If fCampoExiste('CADCLI', 'CLI_REGTRI') Then
          strSQL := strSQL + '  CLI_REGTRI AS GER_REGTRI, '
        Else
          strSQL := strSQL + '  " "        AS GER_REGTRI, ';

        If fCampoExiste('CADCLI', 'CLI_STREES') Then
          strSQL := strSQL + '  CLI_STREES AS GER_STREES, '
        Else
          strSQL := strSQL + '  "N"        AS GER_STREES, ';

        If fCampoExiste('CADCLI', 'CLI_PRSTRE') Then
          strSQL := strSQL + '  CLI_PRSTRE AS GER_PRSTRE, '
        Else
          strSQL := strSQL + '  " "        AS GER_PRSTRE, ';

        If fCampoExiste('CADCLI', 'CLI_ORGPUB') Then
          strSQL := strSQL + '  CLI_ORGPUB AS GER_ORGPUB, '
        Else
          strSQL := strSQL + '  "N"        AS GER_ORGPUB, ';

        If fCampoExiste('CADCLI', 'CLI_ENTGOV') Then
          strSQL := strSQL + '  CLI_ENTGOV AS GER_ENTGOV, '
        Else
          strSQL := strSQL + '  CAST("" AS CHAR(1)) AS GER_ENTGOV, ';

        If fCampoExiste('CADCLI', 'CLI_TPOPEG') Then
          strSQL := strSQL + '  CLI_TPOPEG AS GER_TPOPEG, '
        Else
          strSQL := strSQL + '  CAST("" AS CHAR(1)) AS GER_TPOPEG, ';

        If fCampoExiste('CADCLI', 'CLI_INDUST') Then
          strSQL := strSQL + '  CLI_INDUST AS GER_INDUST, '
        Else
          strSQL := strSQL + '  "N"        AS GER_INDUST, ';

        If fCampoExiste('CADCLI', 'CLI_ORPURD') Then
          strSQL := strSQL + '  CLI_ORPURD AS GER_ORPURD, '
        Else
          strSQL := strSQL + '  " "        AS GER_ORPURD, ';

        If fCampoExiste('CADCLI', 'CLI_CALICM') Then
          strSQL := strSQL + '  CLI_CALICM AS GER_CALICM, '
        Else
          strSQL := strSQL + '  "N"        AS GER_CALICM, ';

        If fCampoExiste('CADCLI', 'CLI_I_M_P_') Then
          strSQL := strSQL + '  CLI_I_M_P_ AS GER_IMPCON, '
        Else
          strSQL := strSQL + '  ""         AS GER_IMPCON, ';

      End
      Else
      Begin
        strSQL := strSQL + '  MOVGER.GER_CODFOR AS GER_CODCLI, ';
        strSQL := strSQL + '  "N"        AS GER_CONSUM, ';

        If fCampoExiste('CADFOR', 'FOR_MATREV') Then
          strSQL := strSQL + '  FOR_MATREV AS GER_MATREV, '
        Else
          strSQL := strSQL + '  " " AS GER_MATREV, ';

        strSQL := strSQL + '  FOR_C_G_C_ AS GER_CGCCON, ';
        strSQL := strSQL + '  FOR_NOMFOR AS GER_NOMCON, ';
        strSQL := strSQL + '  FOR_NOMFAN AS GER_NOMFAN, ';
        strSQL := strSQL + '  FOR_ENDERE AS GER_ENDERE, ';
        strSQL := strSQL + '  FOR_ENDNUM AS GER_ENDNUM, ';
        strSQL := strSQL + '  FOR_ENDCOM AS GER_ENDCOM, ';
        strSQL := strSQL + '  FOR_BAIRRO AS GER_BAICON, ';
        strSQL := strSQL + '  FOR_CODCID AS GER_CIDCON, ';
        strSQL := strSQL + '  FOR_C_E_P_ AS GER_CEPCON, ';
        strSQL := strSQL + '  FOR_FONE01 AS GER_TELCON, ';
        strSQL := strSQL + '  FOR_I_E_S_ AS GER_IESCON, ';
        strSQL := strSQL + '  CF.CID_ESTADO AS GER_ESTCON, ';
        strSQL := strSQL + '  CF.CID_NOMCID AS GER_NOMCID, ';
        strSQL := strSQL + '  CF.CID_CODPAI AS GER_CODPAI, ';

        If fCampoExiste('CADFOR', 'FOR_EMAIL3') Then
        Begin
          strSQL := strSQL + '  FOR_EMAIL3 AS GER_EMAIL_, ';
        End
        Else
        Begin
          strSQL := strSQL + '  FOR_EMAIL_ AS GER_EMAIL_, ';
        End;

        If fCampoExiste('CADFOR', 'FOR_SUFRAM') Then
          strSQL := strSQL + '  FOR_SUFRAM AS GER_SUFRAM, '
        Else
          strSQL := strSQL + '  "" AS GER_SUFRAM, ';

        If fCampoExiste('CADFOR', 'FOR_EMAIL2') Then
        Begin
          strSQL := strSQL + '  FOR_EMAIL2 AS GER_EMAIL2, ';
        End
        Else
        Begin
          strSQL := strSQL + '  "" AS GER_EMAIL2, ';
        End;

        strSQL := strSQL + '  ""         AS GER_DIFERI, ';
        strSQL := strSQL + '  ""         AS GER_RETISS, ';
        strSQL := strSQL + '  ""         AS GER_NOTPAU, ';
        strSQL := strSQL + '  ""         AS GER_CLICON, ';
        strSQL := strSQL + '  ""         AS GER_ZONFRA, ';
        strSQL := strSQL + '  "000"      AS GER_CODATI, ';
        strSQL := strSQL + '  0.00       AS GER_PISRET, ';
        strSQL := strSQL + '  0.00       AS GER_COFRET, ';
        strSQL := strSQL + '  0.00       AS GER_IRFRET, ';
        strSQL := strSQL + '  0.00       AS GER_CSLRET, ';
        strSQL := strSQL + '  0.00       AS GER_VLSGSO, ';
        strSQL := strSQL + '  "N"        AS GER_PRORUR, ';
        strSQL := strSQL + '  "N"        AS GER_BENREI, ';
        strSQL := strSQL + '  "N"        AS GER_MICEMP, ';
        strSQL := strSQL + '  "N"        AS GER_IESUNI, ';

        If fCampoExiste('CADFOR', 'FOR_SIMPAU') Then
          strSQL := strSQL + '  FOR_SIMPAU AS GER_REGTRI, '
        Else
          strSQL := strSQL + '  " "        AS GER_REGTRI, ';

        strSQL := strSQL + '  "N"        AS GER_STREES, ';
        strSQL := strSQL + '  " "        AS GER_PRSTRE, ';
        strSQL := strSQL + '  "N"        AS GER_ORGPUB, ';
        strSQL := strSQL + '  CAST("" AS CHAR(1)) AS GER_ENTGOV, ';
        strSQL := strSQL + '  CAST("" AS CHAR(1)) AS GER_TPOPEG, ';
        strSQL := strSQL + '  "N"        AS GER_INDUST, ';
        strSQL := strSQL + '  " "        AS GER_ORPURD, ';
        strSQL := strSQL + '  "N"        AS GER_CALICM, ';
        strSQL := strSQL + '  ""         AS GER_IMPCON, ';
      End;

      strSQL := strSQL + '  FIS_FORCLI, ';
      strSQL := strSQL + '  FIS_NUMDOC, ';
      strSQL := strSQL + '  FIS_ESPDOC, ';
      strSQL := strSQL + '  FIS_CODEMP, ';
      strSQL := strSQL + '  FIS_SERIE_, ';
      strSQL := strSQL + '  FIS_TIP_FC, ';
      strSQL := strSQL + '  FIS_DTAENT, ';
      strSQL := strSQL + '  FIS_DTADOC, ';

      For intAux := 1 To 5 Do
      Begin
        strSQL := strSQL + '  FIS_CLFSC' + intToStr(intAux) + ', ';
        strSQL := strSQL + '  FIS_VLCON' + intToStr(intAux) + ', ';
        strSQL := strSQL + '  FIS_BASIC' + intToStr(intAux) + ', ';
        strSQL := strSQL + '  FIS_ALQIC' + intToStr(intAux) + ', ';
        strSQL := strSQL + '  FIS_VLRIC' + intToStr(intAux) + ', ';
        strSQL := strSQL + '  FIS_BCRET' + intToStr(intAux) + ', ';
        strSQL := strSQL + '  FIS_RETID' + intToStr(intAux) + ', ';
        strSQL := strSQL + '  FIS_BASIP' + intToStr(intAux) + ', ';
        strSQL := strSQL + '  FIS_VLRIP' + intToStr(intAux) + ', ';
      End;

      strSQL := strSQL + '  FIS_NOTESP, ';
      strSQL := strSQL + '  FIS_HISTOR, ';
      strSQL := strSQL + '  MOVGER.GER_NUMDOC, ';
      strSQL := strSQL + '  MOVGER.GER_CLAFIS, ';
      strSQL := strSQL + '  MOVGER.GER_CONPAG, ';
      strSQL := strSQL + '  MOVGER.GER_CODCND, ';
      strSQL := strSQL + '  MOVGER.GER_SERIE_, ';
      strSQL := strSQL + '  MOVGER.GER_DTAENT, ';
      strSQL := strSQL + '  MOVGER.GER_HORENT, ';
      strSQL := strSQL + '  MOVGER.GER_DTADOC, ';
      strSQL := strSQL + '  MOVGER.GER_BASICM, ';
      strSQL := strSQL + '  MOVGER.GER_TOTICM, ';

      If blnBaERet Then
      Begin
        strSQL := strSQL + '  MOVGER.GER_BASRET + IFNULL((SELECT SUM(IFNULL(T.DET_BAERET, 0))                ';
        strSQL := strSQL + '                              FROM MOVDET D                                      ';
        strSQL := strSQL + '                              INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ';
        strSQL := strSQL + '                              WHERE D.DET_SEQGER = MOVGER.AUTOINCREM),0)         ';
        strSQL := strSQL + '                              AS GER_BASRET,                                     ';
      End
      Else
        strSQL := strSQL + '  MOVGER.GER_BASRET, ';

      If blnVaERet Then
      Begin
        strSQL := strSQL + '  MOVGER.GER_TOTRET + IFNULL((SELECT SUM(IFNULL(T.DET_VAERET, 0))                ';
        strSQL := strSQL + '                              FROM MOVDET D                                      ';
        strSQL := strSQL + '                              INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ';
        strSQL := strSQL + '                              WHERE D.DET_SEQGER = MOVGER.AUTOINCREM),0)         ';
        strSQL := strSQL + '  AS GER_TOTRET,                                                                 ';
      End
      Else
        strSQL := strSQL + '  MOVGER.GER_TOTRET, ';

      strSQL := strSQL + '  MOVGER.GER_TOTPRO, ';
      strSQL := strSQL + '  MOVGER.GER_TOTFRE, ';
      strSQL := strSQL + '  MOVGER.GER_DESESP, ';

      If blnBaEIPI Then
      Begin
        strSQL := strSQL + '  MOVGER.GER_BASIPI + IFNULL((SELECT SUM(IFNULL(T.DET_BAEIPI, 0))                ';
        strSQL := strSQL + '                              FROM MOVDET D                                      ';
        strSQL := strSQL + '                              INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ';
        strSQL := strSQL + '                              WHERE D.DET_SEQGER = MOVGER.AUTOINCREM),0)         ';
        strSQL := strSQL + '                              AS GER_BASIPI,                                     ';
      End
      Else
        strSQL := strSQL + '  MOVGER.GER_BASIPI, ';

      If blnVaEIPI Then
      Begin
        strSQL := strSQL + '  MOVGER.GER_TOTIPI + IFNULL((SELECT SUM(IFNULL(T.DET_VAEIPI, 0))                ';
        strSQL := strSQL + '                              FROM MOVDET D                                      ';
        strSQL := strSQL + '                              INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ';
        strSQL := strSQL + '                              WHERE D.DET_SEQGER = MOVGER.AUTOINCREM),0)         ';
        strSQL := strSQL + '                              AS GER_TOTIPI,                                     ';
      End
      Else
        strSQL := strSQL + '  MOVGER.GER_TOTIPI, ';

      strSQL := strSQL + '  MOVGER.GER_VALPIS, ';
      strSQL := strSQL + '  MOVGER.GER_VALCOF, ';
      strSQL := strSQL + '  MOVGER.GER_DESACE, ';
      strSQL := strSQL + '  MOVGER.GER_VLRCON, ';

      If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_IMPPAG') Then
        strSQL := strSQL + '  AUX_IMPPAG AS GER_IMPPAG,'
      Else If fCampoExiste('MOVGER', 'GER_IMPPAG') Then
        strSQL := strSQL + '  MOVGER.GER_IMPPAG,'
      Else
        strSQL := strSQL + '  0.00 AS GER_IMPPAG,';

      If fTabelaExiste('AUXMOV') And
         fCampoExiste('AUXMOV', 'AUX_FEDIMP') And
         fCampoExiste('AUXNOT', 'AUX_FEDIMP') Then
        strSQL := strSQL + '  AUX_FEDIMP AS GER_FEDIMP,'
      Else
        strSQL := strSQL + '  0.00 AS GER_FEDIMP,';

      If fTabelaExiste('AUXMOV') And
         fCampoExiste('AUXMOV', 'AUX_ESTIMP') And
         fCampoExiste('AUXNOT', 'AUX_ESTIMP') Then
        strSQL := strSQL + '  AUX_ESTIMP AS GER_ESTIMP,'
      Else
        strSQL := strSQL + '  0.00 AS GER_ESTIMP,';

      If fTabelaExiste('AUXMOV') And
         fCampoExiste('AUXMOV', 'AUX_MUNIMP') And
         fCampoExiste('AUXNOT', 'AUX_MUNIMP') Then
        strSQL := strSQL + '  AUX_MUNIMP AS GER_MUNIMP,'
      Else
        strSQL := strSQL + '  0.00 AS GER_MUNIMP,';

      If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_OPCDOC') Then
        strSQL := strSQL + '  AUX_OPCDOC AS GER_OPCDOC,'
      Else
      Begin
        strSQL := strSQL + '  IF(RIGHT(GER_CLAFIS, 3)="929", "CI", ' +
                           '     IF(LOCATE(GER_CLAFIS, "' + CFOP_DEVOLUCAO + '") > 0, ' +
                           '        IF(GER_TIP_FC="C", "DV", "OF"), " ")) AS GER_OPCDOC, ';
      End;


      If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_CHVNFE') Then
        strSQL := strSQL + ' ' + strChvNfe + ', '
      Else
        strSQL := strSQL + '  "  " AS GER_CHVNFE,';

      If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_NUMCOO') Then
        strSQL := strSQL + ' ' + strNumCOO + ', '
      Else
        strSQL := strSQL + '  "  " AS GER_NUMCOO,';

      If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_NUMSER') Then
        strSQL := strSQL + ' ' + strNumSer + ', '
      Else
        strSQL := strSQL + '  "  " AS GER_NUMSER,';

      If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_NUMUSU') Then
        strSQL := strSQL + ' ' + strNumUSU + ', '
      Else
        strSQL := strSQL + '  "  " AS GER_NUMUSU,';

      If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_TIPDOC') Then
        strSQL := strSQL + ' ' + strTipDoc + ', '
      Else
        strSQL := strSQL + '  "  " AS GER_TIPDOC,';

      If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_EST_DV') Then
        strSQL := strSQL + ' ' + strEst_Dv + ', '
      Else
        strSQL := strSQL + '  "  " AS GER_EST_DV,';

      If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_CLIORI') Then
        strSQL := strSQL + '  AUX_CLIORI AS GER_CLIORI,'
      Else
        strSQL := strSQL + '  "        " AS GER_CLIORI,';

      If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_NUMERO') Then
        strSQL := strSQL + ' ' + strNumero + ', '
      Else
        strSQL := strSQL + '  "  " AS GER_NUMERO,';

      If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_SERIE_') Then
        strSQL := strSQL + ' ' + strSerie_ + ', '
      Else
        strSQL := strSQL + '  "  " AS GER_SERIE1,';

      If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_MODELO') Then
        strSQL := strSQL + ' ' + strModelo + ', '
      Else
        strSQL := strSQL + '  "  " AS GER_MODELO,';

      If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_CPFCNP') Then
        strSQL := strSQL + ' ' + strCPFCNP + ', '
      Else
        strSQL := strSQL + '  "  " AS GER_CPFCNP,';

      If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_ESTADO') Then
        strSQL := strSQL + ' ' + strEstado + ', '
      Else
        strSQL := strSQL + '  "  " AS GER_ESTADO,';

      If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_MESANO') Then
        strSQL := strSQL + ' ' + strMesAno + ', '
      Else
        strSQL := strSQL + '  "  " AS GER_MESANO,';

      strSQL := strSQL + ' ' + strComVal + ', ';

      strSQL := strSQL + '  NOTCOM.GER_DOCORI, ';
      strSQL := strSQL + '  NOTCOM.GER_SERORI, ';
      strSQL := strSQL + '  NOTCOM.GER_ACEORI, ';
      strSQL := strSQL + '  NOTCOM.GER_DESITE, ';
      strSQL := strSQL + '  NOTCOM.GER_MENC01, ';
      strSQL := strSQL + '  NOTCOM.GER_MENC02, ';
      strSQL := strSQL + '  NOTCOM.GER_MENC03, ';
      strSQL := strSQL + '  NOTCOM.GER_MENC04, ';
      strSQL := strSQL + '  NOTCOM.GER_MENC05, ';
      strSQL := strSQL + '  NOTCOM.GER_MENC06, ';
      strSQL := strSQL + '  NOTCOM.GER_MENC07, ';
      strSQL := strSQL + '  NOTCOM.GER_MENC08, ';
      strSQL := strSQL + '  NOTCOM.GER_MENC09, ';
      strSQL := strSQL + '  NOTCOM.GER_MENC10, ';
      If fCampoExiste('NOTCOM', 'GER_ESPORI') Then
      Begin
        strSQL := strSQL + '  NOTCOM.GER_ESPORI, ';
        strSQL := strSQL + '  NOTCOM.GER_EMPORI, ';
      End;
      If fCampoExiste('NOTCOM', 'GER_COMICM') Then
      Begin
        strSQL := strSQL + '  NOTCOM.GER_COMICM, ';
      End;
      If fCampoExiste('NOTCOM', 'GER_CREICM') Then
      Begin
        strSQL := strSQL + '  NOTCOM.GER_CREICM, ';
      End;
      If fCampoExiste('NOTCOM', 'GER_TRAICM') Then
      Begin
        strSQL := strSQL + '  NOTCOM.GER_TRAICM, ';
      End;
      If fCampoExiste('NOTCOM', 'GER_COMVAL') Then
      Begin
        strSQL := strSQL + '  NOTCOM.GER_COMVAL AS COMPLEMENTO_VALOR, ';
      End;
      If fCampoExiste('NOTCOM', 'GER_RESICM') Then
      Begin
        strSQL := strSQL + '  NOTCOM.GER_RESICM, ';
      End;

      strSQL := strSQL + '  FIS_NFCOMP, ';
      strSQL := strSQL + '  FIS_IMPMER, ';
      strSQL := strSQL + '  FIS_IMPSEG, ';
      strSQL := strSQL + '  FIS_IMPIMP, ';

      If fCampoExiste('CADFIS', 'FIS_CSTENT') Then
        strSQL := strSQL + '  FIS_CSTENT, ';

      If fCampoExiste('CADFIS', 'FIS_BASEII') Then
      Begin
        strSQL := strSQL + '  FIS_BASEII, ';
        strSQL := strSQL + '  FIS_DESADU, ';
        strSQL := strSQL + '  FIS_VALIOF, ';
      End
      Else
      Begin
        strSQL := strSQL + '  0.00 AS FIS_BASEII, ';
        strSQL := strSQL + '  0.00 AS FIS_DESADU, ';
        strSQL := strSQL + '  0.00 AS FIS_VALIOF, ';
      End;

      If fCampoExiste('CADFIS', 'FIS_VAFRMM') Then
        strSQL := strSQL + '  FIS_VAFRMM, '
      Else
        strSQL := strSQL + '  0.00 AS FIS_VAFRMM, ';

      If fCampoExiste('DOCIMP', 'IMP_VLRADP') Then
        strSQL := strSQL + '  (SELECT IFNULL(SUM(IMP_VLRADP),0) FROM DOCIMP ' +
                  '   WHERE IMP_SQMVDT = MOVDET.AUTOINCREM) AS FIS_VALADP, '
      Else
        strSQL := strSQL + '  0.00 AS FIS_VALADP, ';

      strSQL := strSQL + '  FIS_IMPPRO, ';
      strSQL := strSQL + '  FIS_IMPTAX, ';
      strSQL := strSQL + '  FIS_IMPPIS, ';
      strSQL := strSQL + '  FIS_IMPCOF, ';
      strSQL := strSQL + '  FIS_IMPIC1, ';
      strSQL := strSQL + '  FIS_IMPIC2, ';
      strSQL := strSQL + '  FIS_TOTPIS, ';
      strSQL := strSQL + '  FIS_TOTCOF, ';
      strSQL := strSQL + '  MOVGER.GER_TIPFRE, ';
      strSQL := strSQL + '  CADTRA.TRA_C_G_C_, ';
      strSQL := strSQL + '  CADTRA.TRA_NOMTRA, ';
      strSQL := strSQL + '  CADTRA.TRA_I_E_S_, ';
      strSQL := strSQL + '  CADTRA.TRA_ENDERE, ';

      If fCampoExiste('AUXMOV', 'AUX_PLAFAT') Then
        strSQL := strSQL + ' AUX_PLAFAT AS TRA_NUMPLA, '
      Else
        strSQL := strSQL + '  CADTRA.TRA_NUMPLA, ';

      strSQL := strSQL + '  CADTRA.TRA_EMAIL_, ';

      strSQL := strSQL + strSelectTraRed;

      If fCampoExiste('CADTRA', 'TRA_C_ANTT') Then
        strSQL := strSQL + '  CADTRA.TRA_C_ANTT, '
      Else
        strSQL := strSQL + ' "" AS TRA_C_ANTT, ';

      strSQL := strSQL + '  CIDTRA.CID_NOMCID AS TRA_NOMCID, ';
      strSQL := strSQL + '  CIDTRA.CID_ESTADO AS TRA_ESTADO, ';
      strSQL := strSQL + '  IFNULL(MOVGER.GER_VOLUME, 0) AS GER_VOLUME, ';
      strSQL := strSQL + '  MOVGER.GER_ESPECI, ';
      strSQL := strSQL + '  MOVGER.GER_MARCA_, ';
      strSQL := strSQL + '  MOVGER.GER_PESLIQ, ';
      strSQL := strSQL + '  MOVGER.GER_PESBRU, ';

      If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_NUMERA') Then
        strSQL := strSQL + '  AUX_NUMERA, '
      Else
        strSQL := strSQL + ' "" AS AUX_NUMERA, ';

      strSQL := strSQL + '  IFNULL(MOVGER.GER_FATNOT, 0) AS GER_FATNOT, ';

      strSQL := strSQL + '  MOVGER.GER_VPAR01, ';
      strSQL := strSQL + '  MOVGER.GER_VPAR02, ';
      strSQL := strSQL + '  MOVGER.GER_VPAR03, ';
      strSQL := strSQL + '  MOVGER.GER_VPAR04, ';
      strSQL := strSQL + '  MOVGER.GER_VPAR05, ';
      strSQL := strSQL + '  MOVGER.GER_VPAR06, ';
      strSQL := strSQL + '  MOVGER.GER_VPAR07, ';
      strSQL := strSQL + '  MOVGER.GER_VPAR08, ';
      strSQL := strSQL + '  MOVGER.GER_VPAR09, ';
      strSQL := strSQL + '  MOVGER.GER_VPAR10, ';
      strSQL := strSQL + '  MOVGER.GER_VPAR11, ';
      strSQL := strSQL + '  MOVGER.GER_VPAR12, ';

      strSQL := strSQL + '  DET_CODITE, ';

      if fCampoExiste('MOVDET', 'DET_CODACA') then
      begin
        strSQL := strSQL + '  DET_CODACA, ';
        strSQL := strSQL + '  DET_EMPACA, ';
      end
      else
      begin
        strSQL := strSQL + '  "" AS DET_CODACA, ';
        strSQL := strSQL + '  "" AS DET_EMPACA, ';
      end;

      If fCampoExiste('CADACA', 'ACA_UNITIN') and fCampoExiste('MOVDET', 'DET_CODACA') Then
        strSQL := strSQL + '  ACA_UNITIN, '
      Else
        strSQL := strSQL + '  0 AS ACA_UNITIN, ';

      strSQL := strSQL + '  CLI_COD_NF, ';

      If fTabelaExiste('CLIPRO') And fCampoExiste('CLIPRO', 'CLI_DES_NF') Then
        strSQL := strSQL + '  CLI_DES_NF, '
      Else
        strSQL := strSQL + '  "" AS CLI_DES_NF, ';

      {********************************************}
      {* SE NF FOR DE GARANTIA, ENTÃO DEVE SAIR   *}
      {* O CÓD. FAB. CADASTRADO NA TABELA MOVGAD  *}
      {* SE NÃO PEGA DO CADITE                    *}
      {*****************************************MM*}
      If fCampoExiste('MOVGAD', 'GAD_CODFAB') Then
      Begin
        strSQL := strSQL + '  IF(LOCATE(MOVGER.GER_CLAFIS,' + QuotedStr(fClaFisGarantia) + ') > 0, ';
        strSQL := strSQL + '      (SELECT GAD_CODFAB FROM MOVGAD WHERE AUTOINCREM = MOVTRI.DET_SEQGAD), ';
        strSQL := strSQL + '       CADITE.ITE_CODFAB ';
        strSQL := strSQL + '    ) AS ITE_CODFAB, ';
      End
      Else
      Begin
        strSQL := strSQL + '  CADITE.ITE_CODFAB, ';
      End;

      strSQL := strSQL + '  CADITE.ITE_DESFAB, ';
      strSQL := strSQL + '  CADITE.ITE_CODBAR, ';
      strSQL := strSQL + '  DET_DESCRI, ';

      //Versao 27.16.470 - CFG_NCMTIN
      If fEmiteNCMPorLinhaDeTinta Then
      Begin
        strSQL := strSQL + '  IF(DET_IDEPRO = "NOR", IFNULL(ITEABF.ITE_CLAIPI, CADITE.ITE_CLAIPI), IF(IFNULL(MOVTRI.TRI_NCMTIN,"") <> "", MOVTRI.TRI_NCMTIN, IFNULL(ITEABF.ITE_CLAIPI, CADITE.ITE_CLAIPI))) AS ITE_CLAIPI, ';
      End
      //Versoes superiores a 27.16.470 - CFG_NCMTIN nao existe mais
      Else
      Begin
        if fCampoExiste('MOVDET', 'DET_ITEEMB') then
        begin
          If fCampoExiste('MOVTRI', 'TRI_NCMTIN') Then
            strSQL := strSQL + '  IF(DET_IDEPRO = "NOR", IFNULL(ITEABF.ITE_CLAIPI, CADITE.ITE_CLAIPI), IF(IFNULL(MOVTRI.TRI_NCMTIN, "") <> "", MOVTRI.TRI_NCMTIN, IFNULL(ITEEMB.ITE_CLAIPI, IFNULL(ITEABF.ITE_CLAIPI, CADITE.ITE_CLAIPI)))) AS ITE_CLAIPI, '
          Else
            strSQL := strSQL + '  IF(DET_IDEPRO = "NOR", IFNULL(ITEABF.ITE_CLAIPI, CADITE.ITE_CLAIPI), IFNULL(ITEEMB.ITE_CLAIPI, IFNULL(ITEABF.ITE_CLAIPI, CADITE.ITE_CLAIPI))) AS ITE_CLAIPI, ';
        end
        else
          strSQL := strSQL + '  IFNULL(ITEABF.ITE_CLAIPI, CADITE.ITE_CLAIPI) AS ITE_CLAIPI, ';
      End;

      If (fOutrasSaidasConEqu()) Then
        strSQL := strSQL + ' MOVTRI.DET_NCMITE AS DET_NCMITE, '
      Else
        strSQL := strSQL + ' "" AS DET_NCMITE, ';


      If fCampoExiste('CADITE', 'ITE_EXCIPI') Then
        strSQL := strSQL + '  CADITE.ITE_EXCIPI AS ITE_EXCIPI, '
      Else
        strSQL := strSQL + '  " " AS ITE_EXCIPI, ';

      strSQL := strSQL + '  DET_CLAFIS, ';
      strSQL := strSQL + '  UV.UNI_SIGUNI AS ITE_SIGUNV, ';

      If fCampoExiste('CADUNI', 'UNI_PESLIT') Then
        strSQL := strSQL + '  UV.UNI_PESLIT AS UNI_PESLTV, '
      Else
        strSQL := strSQL + '  0.000 AS UNI_PESLTV, ';

      If (fConfiguracao('UNITRI') <> 'S') Then
      Begin
        strSQL := strSQL + '  UV.UNI_SIGUNI AS ITE_SIGUNT, ';
        strSQL := strSQL + '  1.000000 AS ITE_FATUTR, ';
      End
      Else
      Begin
        strSQL := strSQL + '  IFNULL(UT.UNI_SIGUNI, UV.UNI_SIGUNI) AS ITE_SIGUNT, ';
        strSQL := strSQL + '  IFNULL(CADITE.ITE_FATUTR, 1) AS ITE_FATUTR, ';
      End;

      strSQL := strSQL + '  DET_QTDITE, ';
      strSQL := strSQL + '  DET_UNITAR, ';
      strSQL := strSQL + '  DET_TOTITE, ';
      strSQL := strSQL + '  DET_DESESP, ';
      strSQL := strSQL + '  DET_CODFIS, ';
      strSQL := strSQL + '  DET_NUMLOT, ';
      strSQL := strSQL + '  DET_UNIORI, ';

      If fCampoExiste('CADLOT', 'LOT_DTAVAL') Then
        strSQL := strSQL + '  LOT_DTAVAL, '
      Else
        strSQL := strSQL + ' " " AS LOT_DTAVAL, ';

      If fTabelaExiste('CADLOT') Then
        strSQL := strSQL + '   IF(IFNULL(DET_NUMLOT, "") = "", ITE_LOCFIS, LOT_LOCFIS) AS DET_LOCFIS, '
      Else
        strSQL := strSQL + '   ITE_LOCFIS AS DET_LOCFIS, ';

      If fCampoExiste('CADLOT', 'LOT_LOCSEP') And fCampoExiste('ITEGER', 'ITE_CODLSE') Then
        strSQL := strSQL + '   IFNULL(NULLIF(LOT_LOCSEP, ""), ITE_CODLSE) AS DET_CODLSE, '
      Else If fCampoExiste('ITEGER', 'ITE_CODLSE') Then
        strSQL := strSQL + '   ITE_CODLSE AS DET_CODLSE, '
      Else
        strSQL := strSQL + '   " " AS DET_CODLSE, ';

      strSQL := strSQL + '  DET_DESNES, ';
      strSQL := strSQL + '  DET_CODMAR, ';
      strSQL := strSQL + '  MAR_DESMAR, ';
      strSQL := strSQL + '  CADITE.ITE_MENFIS, ';

      If fCampoExiste('CADITE', 'ITE_PROPCD') Then
        strSQL := strSQL + '  CADITE.ITE_PROPCD, '
      Else
        strSQL := strSQL + '  " " AS ITE_PROPCD, ';

      strSQL := strSQL + '  DET_BASICM, ';
      strSQL := strSQL + '  DET_ALQICM, ';
      strSQL := strSQL + '  DET_VALICM, ';

      if blnBaERet Then
        strSQL := strSQL + '  DET_BASRET + IFNULL(DET_BAERET,0) AS DET_BASRET, '
      Else
        strSQL := strSQL + '  DET_BASRET, ';

      strSQL := strSQL + '  DET_ALQRET, ';

      If blnVaERet Then
        strSQL := strSQL + '  DET_VALRET + IFNULL(DET_VAERET,0) AS DET_VALRET, '
      Else
        strSQL := strSQL + '  DET_VALRET, ';

      strSQL := strSQL + '  DET_PERRED, ';

      If fCampoExiste('MOVTRI', 'DET_VALIVA') Then
        strSQL := strSQL + '  DET_VALIVA, '
      Else
        strSQL := strSQL + '  0.00 DET_VALIVA, ';

      If fCampoExiste('MOVTRI', 'DET_PEBAST') Then
        strSQL := strSQL + '  DET_PEBAST, '
      Else
        strSQL := strSQL + '  DET_PERBAS AS DET_PEBAST, ';

      If blnVaEIPI Then
        strSQL := strSQL + '  DET_VALIPI + IFNULL(MOVTRI.DET_VAEIPI,0) AS DET_VALIPI, '
      Else
        strSQL := strSQL + '  DET_VALIPI, ';

      strSQL := strSQL + '  DET_BASIPI, ';
      strSQL := strSQL + '  DET_ALQIPI, ';
      strSQL := strSQL + '  DET_TOTFRE, ';
      strSQL := strSQL + '  DET_DESACE, ';
      strSQL := strSQL + '  CADITE.ITE_CODABF, ';

      If strTabAbf = 'ABFICM' Then
      Begin
        If fCampoExiste('ABFICM', 'ABF_RICMPR_SAI_CNC') Then
        Begin
          strSQL := strSQL + '  ABF_RICMPR_SAI_CNC, ';
        End
        Else
        Begin
          strSQL := strSQL + '  "N" AS ABF_RICMPR_SAI_CNC, ';
        End;

        If FTip_FC = 'C' Then
        Begin
          strSQL := strSQL + fRetSQLMsg1e2TipAbfdeSAI('NCO'); //RETORNA MENSAGENS NÃO CONTRIBUINTE
          strSQL := strSQL + fRetSQLMsg1e2TipAbfdeSAI('CCO'); //RETORNA MENSAGENS CONTRIBUINTE CONSUMIDOR
          strSQL := strSQL + fRetSQLMsg1e2TipAbfdeSAI('CNC'); //RETORNA MENSAGENS CONTRIBUINTE NÃO CONSUMIDOR
          strSQL := strSQL + fRetSQLMsg1e2TipAbfdeSAI('CTA'); //RETORNA MENSAGENS CONSTRUTORA
          strSQL := strSQL + fRetSQLMsg1e2TipAbfdeSAI('PRU'); //RETORNA MENSAGENS PRODUTOR RURAL
          strSQL := strSQL + fRetSQLMsg1e2TipAbfdeSAI('SNA'); //RETORNA MENSAGENS SIMPLES NACIONAL
          strSQL := strSQL + fRetSQLMsg1e2TipAbfdeSAI('IND'); //RETORNA MENSAGENS INDUSTRIA
          strSQL := strSQL + fRetSQLMsg1e2TipAbfdeSAI('TRS'); //RETORNA MENSAGENS CLIENTE FILIAL
        End;
      End
      Else
      Begin
        strSQL := strSQL + '  "N" AS ABF_RICMPR_SAI_CNC, ';
        strSQL := strSQL + '  ABF_MENSAG AS ABF_MENS01, ';
        strSQL := strSQL + '  ABF_MENSA2 AS ABF_MENS02, ';

        For intAux:=3 To 6 Do
        Begin
          If fCampoExiste('CADABF', 'ABF_MENSA'+IntToStr(intAux)) Then
            strSQL := strSQL + '  ABF_MENSA'+IntToStr(intAux)+' AS '+'ABF_MENS'+fStrZero(IntToStr(intAux),2) + ', '
          Else
            strSQL := strSQL + '  "" AS '+'ABF_MENS'+fStrZero(IntToStr(intAux),2) + ', '
        End;
      End;

      strSQL := strSQL + '  FIS_ACESSO, ';
      strSQL := strSQL + '  MOVGER.GER_CODVEN, ';
      strSQL := strSQL + '  IFNULL(MOVGER.GER_CODDIG, "") AS GER_CODDIG, ';

      If objConfig.blnAutCen Then
      Begin
        strSQL := strSQL + ' (SELECT ';
        strSQL := strSQL + '    GROUP_CONCAT(DISTINCT  " ", CONCAT(DET_CODVEN, "-", OPE_NOMOPE)) AS NOME ';
        strSQL := strSQL + '  FROM ';
        strSQL := strSQL + '    MOVDET D INNER JOIN CADOPE O ON D.DET_CODVEN = O.OPE_CODOPE ';
        strSQL := strSQL + '  WHERE ';
        strSQL := strSQL + '    D.DET_SEQGER = MOVGER.AUTOINCREM) AS OPE_NOMOPE, ';
      End
      Else
        strSQL := strSQL + '  VE.OPE_NOMOPE, ';

      If objConfig.blnAutCen Then
      Begin
        strSQL := strSQL + ' (SELECT ';
        strSQL := strSQL + '    GROUP_CONCAT(DISTINCT  " ", CONCAT(DET_CODDIG, "-", OPE_NOMOPE)) AS NOME ';
        strSQL := strSQL + '  FROM ';
        strSQL := strSQL + '    MOVDET D INNER JOIN CADOPE O ON D.DET_CODDIG = O.OPE_CODOPE ';
        strSQL := strSQL + '  WHERE ';
        strSQL := strSQL + '    D.DET_SEQGER = MOVGER.AUTOINCREM) AS OPE_NOMDIG, ';
      End
      Else
        strSQL := strSQL + '  DI.OPE_NOMOPE AS OPE_NOMDIG, ';

      strSQL := strSQL + '  MOVGER.GER_MEN001, ';
      strSQL := strSQL + '  MOVGER.GER_MEN002, ';
      strSQL := strSQL + '  MOVGER.GER_MEN003, ';
      strSQL := strSQL + '  MOVGER.GER_MEN004, ';
      strSQL := strSQL + '  MOVGER.GER_MEN005, ';

      If fCampoExiste('NATCFO', 'NAT_DESCRI') Then
        strSQL := strSQL + '  IF(TRIM(IFNULL(MOVGER.GER_NATOPE,""))<>"", MOVGER.GER_NATOPE, (SELECT NAT_DESCRI FROM NATCFO WHERE NAT_CODCFO = GER_CLAFIS LIMIT 1) ) AS CFO_NATOPE_01, '
      Else If fCampoExiste('MOVGER', 'GER_NATOPE') Then
        strSQL := strSQL + '  IF(TRIM(IFNULL(MOVGER.GER_NATOPE,""))<>"", MOVGER.GER_NATOPE, C1.CFO_NATOPE) AS CFO_NATOPE_01, '
      Else
        strSQL := strSQL + '  C1.CFO_NATOPE AS CFO_NATOPE_01, ';

      If fCampoExiste('NATCFO', 'NAT_DESCRI') Then
      Begin
        strSQL := strSQL + '  (SELECT NAT_DESCRI FROM NATCFO WHERE NAT_CODCFO = GER_CLAFI2 LIMIT 1) AS CFO_NATOPE_02, ';
        strSQL := strSQL + '  (SELECT NAT_DESCRI FROM NATCFO WHERE NAT_CODCFO = GER_CLAFI3 LIMIT 1) AS CFO_NATOPE_03, ';
        strSQL := strSQL + '  (SELECT NAT_DESCRI FROM NATCFO WHERE NAT_CODCFO = GER_CLAFI4 LIMIT 1) AS CFO_NATOPE_04, ';
      End
      Else
      Begin
        strSQL := strSQL + '  C2.CFO_NATOPE AS CFO_NATOPE_02, ';
        strSQL := strSQL + '  C3.CFO_NATOPE AS CFO_NATOPE_03, ';
        strSQL := strSQL + '  C4.CFO_NATOPE AS CFO_NATOPE_04, ';
      End;

      strSQL := strSQL + '  MOVGER.GER_TOTSER, ';

      If fCampoExiste('CADFIS', 'FIS_BASISS') Then
        strSQL := strSQL + '  CADFIS.FIS_BASISS AS GER_BASISS, ';

      strSQL := strSQL + '  MOVGER.GER_PERISS, ';
      strSQL := strSQL + '  MOVGER.GER_VALISS, ';
      strSQL := strSQL + '  MOVOBS.MOV_OBSERV, ';

      If fCampoExiste('MOVOBS', 'MOV_OBSFIS') Then
        strSQL := strSQL + '  MOVOBS.MOV_OBSFIS, '
      Else
        strSQL := strSQL + ' " " AS MOV_OBSFIS, ';

      strSQL := strSQL + '  MOVOBS.MOV_IPDPNF, ';
      strSQL := strSQL + '  MOVOBS.MOV_IPDPCI, ';
      strSQL := strSQL + '  MOVOBS.MOV_DTESNF, ';
      strSQL := strSQL + '  MOVOBS.MOV_HRESNF, ';

      If fCampoExiste('MOVOBS', 'MOV_CNFNFE') Then
        strSQL := strSQL + '  MOVOBS.MOV_CNFNFE, '
      Else
        strSQL := strSQL + ' " " AS MOV_CNFNFE, ';

      If fCampoExiste('MOVOBS', 'MOV_CNFFIS') Then
        strSQL := strSQL + '  MOVOBS.MOV_CNFFIS, '
      Else
        strSQL := strSQL + ' " " AS MOV_CNFFIS, ';

      If fCampoExiste('MOVDET', 'DET_INCPIS') Then
        strSQL := strSQL + '  DET_INCPIS AS ITE_INCPIS, '
      Else
        strSQL := strSQL + '  CADITE.ITE_INCPIS, ';

      strSQL := strSQL + '  REPEAT(" ", 20) AS DET_AUTINC, ';

      strSQL := strSQL + '  MOVTRI.DET_BARTSP, ';
      strSQL := strSQL + '  MOVTRI.DET_VLRTSP, ';
      strSQL := strSQL + '  MOVTRI.DET_ICOPPR, ';

      If fCampoExiste('MOVTRI', 'DET_CSTPIS') Then
      Begin
        strSQL := strSQL + '  MOVTRI.DET_CSTPIS, ';
        strSQL := strSQL + '  MOVTRI.DET_BASPIS, ';
        strSQL := strSQL + '  MOVTRI.DET_ALQPIS, ';
        strSQL := strSQL + '  MOVTRI.DET_VALPIS, ';
        strSQL := strSQL + '  MOVTRI.DET_CSTCOF, ';
        strSQL := strSQL + '  MOVTRI.DET_BASCOF, ';
        strSQL := strSQL + '  MOVTRI.DET_ALQCOF, ';
        strSQL := strSQL + '  MOVTRI.DET_VALCOF, ';

        strSQL := strSQL + '  MOVTRI.DET_CSTIPI, ';
      End;

      If fCampoExiste('MOVTRI', 'DET_ENQIPI') Then
        strSQL := strSQL + '  MOVTRI.DET_ENQIPI, ';

      if fCampoExiste('MOVGER', 'GER_DESS01') then
      begin
        strSQL := strSQL + '  MOVGER.GER_DESS01, ';
        strSQL := strSQL + '  MOVGER.GER_DESS02, ';
        strSQL := strSQL + '  MOVGER.GER_DESS03, ';
        strSQL := strSQL + '  MOVGER.GER_DESS04, ';
        strSQL := strSQL + '  MOVGER.GER_DESS05, ';
        strSQL := strSQL + '  MOVGER.GER_DESS06, ';
      end
      else
      begin
        strSQL := strSQL + '  "" AS GER_DESS01, ';
        strSQL := strSQL + '  "" AS GER_DESS02, ';
        strSQL := strSQL + '  "" AS GER_DESS03, ';
        strSQL := strSQL + '  "" AS GER_DESS04, ';
        strSQL := strSQL + '  "" AS GER_DESS05, ';
        strSQL := strSQL + '  "" AS GER_DESS06, ';
      end;

      // Se existe os serviços 07, 08, 09 e 10
      If fTabelaExiste('SERMOV') And fCampoExiste('SERMOV', 'GER_DESS07') Then
      Begin
        strSQL := strSQL + '  SERMOV.GER_DESS07, ';
        strSQL := strSQL + '  SERMOV.GER_DESS08, ';
        strSQL := strSQL + '  SERMOV.GER_DESS09, ';
        strSQL := strSQL + '  SERMOV.GER_DESS10, ';
      End;

      If fTabelaExiste('SERMOV') And fCampoExiste('SERMOV', 'GER_DESS11') Then Begin
        strSQL := strSQL + '  SERMOV.GER_DESS11, ';
        strSQL := strSQL + '  SERMOV.GER_DESS12, ';
        strSQL := strSQL + '  SERMOV.GER_DESS13, ';
        strSQL := strSQL + '  SERMOV.GER_DESS14, ';
        strSQL := strSQL + '  SERMOV.GER_DESS15, ';
        strSQL := strSQL + '  SERMOV.GER_DESS16, ';
        strSQL := strSQL + '  SERMOV.GER_DESS17, ';
        strSQL := strSQL + '  SERMOV.GER_DESS18, ';
        strSQL := strSQL + '  SERMOV.GER_DESS19, ';
        strSQL := strSQL + '  SERMOV.GER_DESS20, ';
        strSQL := strSQL + '  SERMOV.GER_DESS21, ';
        strSQL := strSQL + '  SERMOV.GER_DESS22, ';
        strSQL := strSQL + '  SERMOV.GER_DESS23, ';
        strSQL := strSQL + '  SERMOV.GER_DESS24, ';
        strSQL := strSQL + '  SERMOV.GER_DESS25, ';
        strSQL := strSQL + '  SERMOV.GER_DESS26, ';
        strSQL := strSQL + '  SERMOV.GER_DESS27, ';
        strSQL := strSQL + '  SERMOV.GER_DESS28, ';
        strSQL := strSQL + '  SERMOV.GER_DESS29, ';
        strSQL := strSQL + '  SERMOV.GER_DESS30, ';
      End;

      if fCampoExiste('MOVGER', 'GER_VALS01') then
      begin
        If fTabelaExiste('SERMOV') And fCampoExiste('SERMOV','GER_DECS01') Then
        Begin
          If fCampoExiste('SERMOV','GER_IDES01') Then
          Begin
            strSQL := strSQL + ' IF(SERMOV.GER_IDES01 = "I", 0.00, (MOVGER.GER_VALS01 - (MOVGER.GER_VALS01 * (SERMOV.GER_DECS01 / 100)))) AS GER_VALS01, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES02 = "I", 0.00, (MOVGER.GER_VALS02 - (MOVGER.GER_VALS02 * (SERMOV.GER_DECS02 / 100)))) AS GER_VALS02, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES03 = "I", 0.00, (MOVGER.GER_VALS03 - (MOVGER.GER_VALS03 * (SERMOV.GER_DECS03 / 100)))) AS GER_VALS03, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES04 = "I", 0.00, (MOVGER.GER_VALS04 - (MOVGER.GER_VALS04 * (SERMOV.GER_DECS04 / 100)))) AS GER_VALS04, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES05 = "I", 0.00, (MOVGER.GER_VALS05 - (MOVGER.GER_VALS05 * (SERMOV.GER_DECS05 / 100)))) AS GER_VALS05, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES06 = "I", 0.00, (MOVGER.GER_VALS06 - (MOVGER.GER_VALS06 * (SERMOV.GER_DECS06 / 100)))) AS GER_VALS06, ';
          End
          Else
          Begin
            strSQL := strSQL + ' (MOVGER.GER_VALS01 - (MOVGER.GER_VALS01 * (SERMOV.GER_DECS01 / 100))) AS GER_VALS01, ';
            strSQL := strSQL + ' (MOVGER.GER_VALS02 - (MOVGER.GER_VALS02 * (SERMOV.GER_DECS02 / 100))) AS GER_VALS02, ';
            strSQL := strSQL + ' (MOVGER.GER_VALS03 - (MOVGER.GER_VALS03 * (SERMOV.GER_DECS03 / 100))) AS GER_VALS03, ';
            strSQL := strSQL + ' (MOVGER.GER_VALS04 - (MOVGER.GER_VALS04 * (SERMOV.GER_DECS04 / 100))) AS GER_VALS04, ';
            strSQL := strSQL + ' (MOVGER.GER_VALS05 - (MOVGER.GER_VALS05 * (SERMOV.GER_DECS05 / 100))) AS GER_VALS05, ';
            strSQL := strSQL + ' (MOVGER.GER_VALS06 - (MOVGER.GER_VALS06 * (SERMOV.GER_DECS06 / 100))) AS GER_VALS06, ';
          End;
        End
        Else
        Begin
          strSQL := strSQL + '  MOVGER.GER_VALS01, ';
          strSQL := strSQL + '  MOVGER.GER_VALS02, ';
          strSQL := strSQL + '  MOVGER.GER_VALS03, ';
          strSQL := strSQL + '  MOVGER.GER_VALS04, ';
          strSQL := strSQL + '  MOVGER.GER_VALS05, ';
          strSQL := strSQL + '  MOVGER.GER_VALS06, ';
        End;
      end
      else
      begin
        strSQL := strSQL + '  0.00 AS GER_VALS01, ';
        strSQL := strSQL + '  0.00 AS GER_VALS02, ';
        strSQL := strSQL + '  0.00 AS GER_VALS03, ';
        strSQL := strSQL + '  0.00 AS GER_VALS04, ';
        strSQL := strSQL + '  0.00 AS GER_VALS05, ';
        strSQL := strSQL + '  0.00 AS GER_VALS06, ';
      end;

      // Se existe os serviços 07, 08, 09 e 10
      If fTabelaExiste('SERMOV') And fCampoExiste('SERMOV', 'GER_VALS07') Then
      Begin
        If fCampoExiste('SERMOV','GER_DECS07') Then
        Begin
          If fCampoExiste('SERMOV','GER_IDES07') Then
          Begin
            strSQL := strSQL + ' IF(SERMOV.GER_IDES07 = "I", 0.00, (SERMOV.GER_VALS07 - (SERMOV.GER_VALS07 * (SERMOV.GER_DECS07 / 100)))) AS GER_VALS07, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES08 = "I", 0.00, (SERMOV.GER_VALS08 - (SERMOV.GER_VALS08 * (SERMOV.GER_DECS08 / 100)))) AS GER_VALS08, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES09 = "I", 0.00, (SERMOV.GER_VALS09 - (SERMOV.GER_VALS09 * (SERMOV.GER_DECS09 / 100)))) AS GER_VALS09, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES10 = "I", 0.00, (SERMOV.GER_VALS10 - (SERMOV.GER_VALS10 * (SERMOV.GER_DECS10 / 100)))) AS GER_VALS10, ';
          End
          Else
          Begin
            strSQL := strSQL + ' (SERMOV.GER_VALS07 - (SERMOV.GER_VALS07 * (SERMOV.GER_DECS07 / 100))) AS GER_VALS07, ';
            strSQL := strSQL + ' (SERMOV.GER_VALS08 - (SERMOV.GER_VALS08 * (SERMOV.GER_DECS08 / 100))) AS GER_VALS08, ';
            strSQL := strSQL + ' (SERMOV.GER_VALS09 - (SERMOV.GER_VALS09 * (SERMOV.GER_DECS09 / 100))) AS GER_VALS09, ';
            strSQL := strSQL + ' (SERMOV.GER_VALS10 - (SERMOV.GER_VALS10 * (SERMOV.GER_DECS10 / 100))) AS GER_VALS10, ';
          End;
        End
        Else
        Begin
          strSQL := strSQL + '  SERMOV.GER_VALS07, ';
          strSQL := strSQL + '  SERMOV.GER_VALS08, ';
          strSQL := strSQL + '  SERMOV.GER_VALS09, ';
          strSQL := strSQL + '  SERMOV.GER_VALS10, ';
        End;
      End;

      If fTabelaExiste('SERMOV') And fCampoExiste('SERMOV', 'GER_IDES11') Then
      Begin
        If fCampoExiste('SERMOV','GER_IDES11') Then
        Begin
          If fCampoExiste('SERMOV','GER_IDES11') Then
          Begin
            strSQL := strSQL + ' IF(SERMOV.GER_IDES11 = "I", 0.00, (SERMOV.GER_VALS11 - (SERMOV.GER_VALS11 * (SERMOV.GER_DECS11 / 100)))) AS GER_VALS11, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES12 = "I", 0.00, (SERMOV.GER_VALS12 - (SERMOV.GER_VALS12 * (SERMOV.GER_DECS12 / 100)))) AS GER_VALS12, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES13 = "I", 0.00, (SERMOV.GER_VALS13 - (SERMOV.GER_VALS13 * (SERMOV.GER_DECS13 / 100)))) AS GER_VALS13, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES14 = "I", 0.00, (SERMOV.GER_VALS14 - (SERMOV.GER_VALS14 * (SERMOV.GER_DECS14 / 100)))) AS GER_VALS14, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES15 = "I", 0.00, (SERMOV.GER_VALS15 - (SERMOV.GER_VALS15 * (SERMOV.GER_DECS15 / 100)))) AS GER_VALS15, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES16 = "I", 0.00, (SERMOV.GER_VALS16 - (SERMOV.GER_VALS16 * (SERMOV.GER_DECS16 / 100)))) AS GER_VALS16, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES17 = "I", 0.00, (SERMOV.GER_VALS17 - (SERMOV.GER_VALS17 * (SERMOV.GER_DECS17 / 100)))) AS GER_VALS17, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES18 = "I", 0.00, (SERMOV.GER_VALS18 - (SERMOV.GER_VALS18 * (SERMOV.GER_DECS18 / 100)))) AS GER_VALS18, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES19 = "I", 0.00, (SERMOV.GER_VALS19 - (SERMOV.GER_VALS19 * (SERMOV.GER_DECS19 / 100)))) AS GER_VALS19, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES20 = "I", 0.00, (SERMOV.GER_VALS20 - (SERMOV.GER_VALS20 * (SERMOV.GER_DECS20 / 100)))) AS GER_VALS20, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES21 = "I", 0.00, (SERMOV.GER_VALS21 - (SERMOV.GER_VALS21 * (SERMOV.GER_DECS21 / 100)))) AS GER_VALS21, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES22 = "I", 0.00, (SERMOV.GER_VALS22 - (SERMOV.GER_VALS22 * (SERMOV.GER_DECS22 / 100)))) AS GER_VALS22, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES23 = "I", 0.00, (SERMOV.GER_VALS23 - (SERMOV.GER_VALS23 * (SERMOV.GER_DECS23 / 100)))) AS GER_VALS23, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES24 = "I", 0.00, (SERMOV.GER_VALS24 - (SERMOV.GER_VALS24 * (SERMOV.GER_DECS24 / 100)))) AS GER_VALS24, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES25 = "I", 0.00, (SERMOV.GER_VALS25 - (SERMOV.GER_VALS25 * (SERMOV.GER_DECS25 / 100)))) AS GER_VALS25, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES26 = "I", 0.00, (SERMOV.GER_VALS26 - (SERMOV.GER_VALS26 * (SERMOV.GER_DECS26 / 100)))) AS GER_VALS26, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES27 = "I", 0.00, (SERMOV.GER_VALS27 - (SERMOV.GER_VALS27 * (SERMOV.GER_DECS27 / 100)))) AS GER_VALS27, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES28 = "I", 0.00, (SERMOV.GER_VALS28 - (SERMOV.GER_VALS28 * (SERMOV.GER_DECS28 / 100)))) AS GER_VALS28, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES29 = "I", 0.00, (SERMOV.GER_VALS29 - (SERMOV.GER_VALS29 * (SERMOV.GER_DECS29 / 100)))) AS GER_VALS29, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES30 = "I", 0.00, (SERMOV.GER_VALS30 - (SERMOV.GER_VALS30 * (SERMOV.GER_DECS30 / 100)))) AS GER_VALS30, ';
          End
          Else
          Begin
            strSQL := strSQL + ' (SERMOV.GER_VALS11 - (SERMOV.GER_VALS11 * (SERMOV.GER_DECS11 / 100))) AS GER_VALS11, ';
            strSQL := strSQL + ' (SERMOV.GER_VALS12 - (SERMOV.GER_VALS12 * (SERMOV.GER_DECS12 / 100))) AS GER_VALS12, ';
            strSQL := strSQL + ' (SERMOV.GER_VALS13 - (SERMOV.GER_VALS13 * (SERMOV.GER_DECS13 / 100))) AS GER_VALS13, ';
            strSQL := strSQL + ' (SERMOV.GER_VALS14 - (SERMOV.GER_VALS14 * (SERMOV.GER_DECS14 / 100))) AS GER_VALS14, ';
            strSQL := strSQL + ' (SERMOV.GER_VALS15 - (SERMOV.GER_VALS15 * (SERMOV.GER_DECS15 / 100))) AS GER_VALS15, ';
            strSQL := strSQL + ' (SERMOV.GER_VALS16 - (SERMOV.GER_VALS16 * (SERMOV.GER_DECS16 / 100))) AS GER_VALS16, ';
            strSQL := strSQL + ' (SERMOV.GER_VALS17 - (SERMOV.GER_VALS17 * (SERMOV.GER_DECS17 / 100))) AS GER_VALS17, ';
            strSQL := strSQL + ' (SERMOV.GER_VALS18 - (SERMOV.GER_VALS18 * (SERMOV.GER_DECS18 / 100))) AS GER_VALS18, ';
            strSQL := strSQL + ' (SERMOV.GER_VALS19 - (SERMOV.GER_VALS19 * (SERMOV.GER_DECS19 / 100))) AS GER_VALS19, ';
            strSQL := strSQL + ' (SERMOV.GER_VALS20 - (SERMOV.GER_VALS20 * (SERMOV.GER_DECS20 / 100))) AS GER_VALS20, ';
            strSQL := strSQL + ' (SERMOV.GER_VALS21 - (SERMOV.GER_VALS21 * (SERMOV.GER_DECS21 / 100))) AS GER_VALS21, ';
            strSQL := strSQL + ' (SERMOV.GER_VALS22 - (SERMOV.GER_VALS22 * (SERMOV.GER_DECS22 / 100))) AS GER_VALS22, ';
            strSQL := strSQL + ' (SERMOV.GER_VALS23 - (SERMOV.GER_VALS23 * (SERMOV.GER_DECS23 / 100))) AS GER_VALS23, ';
            strSQL := strSQL + ' (SERMOV.GER_VALS24 - (SERMOV.GER_VALS24 * (SERMOV.GER_DECS24 / 100))) AS GER_VALS24, ';
            strSQL := strSQL + ' (SERMOV.GER_VALS25 - (SERMOV.GER_VALS25 * (SERMOV.GER_DECS25 / 100))) AS GER_VALS25, ';
            strSQL := strSQL + ' (SERMOV.GER_VALS26 - (SERMOV.GER_VALS26 * (SERMOV.GER_DECS26 / 100))) AS GER_VALS26, ';
            strSQL := strSQL + ' (SERMOV.GER_VALS27 - (SERMOV.GER_VALS27 * (SERMOV.GER_DECS27 / 100))) AS GER_VALS27, ';
            strSQL := strSQL + ' (SERMOV.GER_VALS28 - (SERMOV.GER_VALS28 * (SERMOV.GER_DECS28 / 100))) AS GER_VALS28, ';
            strSQL := strSQL + ' (SERMOV.GER_VALS29 - (SERMOV.GER_VALS29 * (SERMOV.GER_DECS29 / 100))) AS GER_VALS29, ';
            strSQL := strSQL + ' (SERMOV.GER_VALS30 - (SERMOV.GER_VALS30 * (SERMOV.GER_DECS30 / 100))) AS GER_VALS30, ';
          End;
        End
        Else
        Begin
          strSQL := strSQL + '  SERMOV.GER_VALS11, ';
          strSQL := strSQL + '  SERMOV.GER_VALS12, ';
          strSQL := strSQL + '  SERMOV.GER_VALS13, ';
          strSQL := strSQL + '  SERMOV.GER_VALS14, ';
          strSQL := strSQL + '  SERMOV.GER_VALS15, ';
          strSQL := strSQL + '  SERMOV.GER_VALS16, ';
          strSQL := strSQL + '  SERMOV.GER_VALS17, ';
          strSQL := strSQL + '  SERMOV.GER_VALS18, ';
          strSQL := strSQL + '  SERMOV.GER_VALS19, ';
          strSQL := strSQL + '  SERMOV.GER_VALS20, ';
          strSQL := strSQL + '  SERMOV.GER_VALS21, ';
          strSQL := strSQL + '  SERMOV.GER_VALS22, ';
          strSQL := strSQL + '  SERMOV.GER_VALS23, ';
          strSQL := strSQL + '  SERMOV.GER_VALS24, ';
          strSQL := strSQL + '  SERMOV.GER_VALS25, ';
          strSQL := strSQL + '  SERMOV.GER_VALS26, ';
          strSQL := strSQL + '  SERMOV.GER_VALS27, ';
          strSQL := strSQL + '  SERMOV.GER_VALS28, ';
          strSQL := strSQL + '  SERMOV.GER_VALS29, ';
          strSQL := strSQL + '  SERMOV.GER_VALS30, ';
        End;
      End;

      If fTabelaExiste('SERMOV') And fCampoExiste('SERMOV', 'GER_SEROBS') Then
        strSQL := strSQL + ' IFNULL(SERMOV.GER_SEROBS,"") AS GER_SEROBS, '
      Else
        strSQL := strSQL + ' "" AS GER_SEROBS, ';

      If fTabelaExiste('MOVOBS') And fCampoExiste('MOVOBS', 'MOV_DISSER') Then
        strSQL := strSQL + ' IFNULL(MOVOBS.MOV_DISSER,"") AS GER_DISSER, '
      Else
        strSQL := strSQL + ' " " AS GER_DISSER, ';

      If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_DUPREC') Then
        strSQL := strSQL + '  AUX_DUPREC AS GER_DUPREC,'
      Else
        strSQL := strSQL + '  0.00 AS GER_DUPREC,';

      If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_CODOBR') Then
      Begin
        strSQL := strSQL + '  AUX_CODOBR, ';
        strSQL := strSQL + '  AUX_CODART, ';
        strSQL := strSQL + '  ETC_CIDENT, ';
        strSQL := strSQL + '  ETC_ENDENT, ';
        strSQL := strSQL + '  ETC_BAIENT, ';
        strSQL := strSQL + '  ETC_CEPENT, ';
        strSQL := strSQL + '  ETC_TELENT, ';
        strSQL := strSQL + '  ETC_CONENT, ';
        strSQL := strSQL + '  ETC_REFENT, ';
      End
      Else
      Begin
        strSQL := strSQL + '  "" AS AUX_CODOBR, ';
        strSQL := strSQL + '  "" AS AUX_CODART, ';
        strSQL := strSQL + '  "" AS ETC_CIDENT, ';
        strSQL := strSQL + '  "" AS ETC_ENDENT, ';
        strSQL := strSQL + '  "" AS ETC_BAIENT, ';
        strSQL := strSQL + '  "" AS ETC_CEPENT, ';
        strSQL := strSQL + '  "" AS ETC_TELENT, ';
        strSQL := strSQL + '  "" AS ETC_CONENT, ';
        strSQL := strSQL + '  "" AS ETC_REFENT, ';
      End;

      If fCampoExiste('MOVTRI', 'DET_SEQCCR') Then
        strSQL := strSQL + '  DET_SEQCCR, '
      Else
        strSQL := strSQL + '  "" AS DET_SEQCCR,  ';

      if blnTrSeCi And fTabelaExiste('TRISER') then
        strSQL := strSQL + '  TSE_CDLSSE AS SER_CDLSSE, '
      Else
      If fCampoExiste('CADSER', 'SER_CDLSSE') Then
        strSQL := strSQL + '  SER_CDLSSE, '
      Else
        strSQL := strSQL + ' "" AS SER_CDLSSE, ';

      if blnTrSeCi And fTabelaExiste('TRISER') then
        strSQL := strSQL + '  TSE_TRIMUN AS SER_TRIMUN, '
      Else
      If fCampoExiste('CADSER', 'SER_TRIMUN') Then
        strSQL := strSQL + '  SER_TRIMUN, '
      Else
        strSQL := strSQL + '  REPEAT(" ", 20) AS SER_TRIMUN,  ';

      strSQL := strSQL + '  DET_NUM_PD, ';
      strSQL := strSQL + '  DET_ESP_PD, ';
      strSQL := strSQL + '  DET_EMP_PD, ';
      strSQL := strSQL + '  DET_IND_PD, ';

      If (fConfiguracao('IMPDIR') = 'S') And fCampoExiste('CADITE', 'ITE_IMPDIR') Then
      Begin
        If (fConfiguracao('IMPDIG') = '2') Then
          strSQL := strSQL + '  ITEGER.ITE_IMPDIR, '
        Else
          strSQL := strSQL + '  CADITE.ITE_IMPDIR, ';
      End
      Else
        strSQL := strSQL + '  "N" AS ITE_IMPDIR, ';

      If ((fConfiguracao('VENMAD') = 'S') Or
          (fConfiguracao('VENVID') = 'S') Or
          (fConfiguracao('VENMTL') = 'S')) And
           fTabelaExiste('MOVMAD') Then
      Begin
        strSQL := strSQL + '  DET_QTDPEC, ';
        strSQL := strSQL + '  DET_COMPEC, ';
        strSQL := strSQL + '  DET_LARPEC, ';
        strSQL := strSQL + '  DET_ESPPEC, ';
        strSQL := strSQL + '  DET_APAREL, ';
        strSQL := strSQL + '  DET_BENEFI, ';
        strSQL := strSQL + '  DET_PERAPA, ';
        strSQL := strSQL + '  DET_PERBEN, ';
        strSQL := strSQL + '  if( (DET_QTDPEC > 0) AND (DET_TOTITE > 0), (DET_TOTITE / DET_QTDPEC), 0) AS DET_VLUNPC, ';
      End;

      If fCampoExiste('CADITE', 'ITE_CODLUB') Then
      Begin
        strSQL := strSQL + '  CADITE.ITE_CODLUB, ';
      End
      Else
      Begin
        strSQL := strSQL + '  "" AS ITE_CODLUB, ';
      End;

      If fCampoExiste('CADITE', 'ITE_DESANP') Then
        strSQL := strSQL + '  CADITE.ITE_DESANP, '
      Else
        strSQL := strSQL + '  "" AS ITE_DESANP, ';

      If fCampoExiste('CADITE', 'ITE_NUMFCI') Then
      Begin
        strSQL := strSQL + '  CADITE.ITE_NUMFCI, ';
      End
      Else
      Begin
        strSQL := strSQL + '  "" AS ITE_NUMFCI, ';
      End;

      If objConfig.blnClaOnu Then
      Begin
        strSQL := strSQL + '  ONU_CODONU, ';
        strSQL := strSQL + '  ONU_DESCRI, ';

        If fCampoExiste('CADONU', 'ONU_CODIGO') Then
          strSQL := strSQL + '  ONU_CODIGO, '
        Else
          strSQL := strSQL + '  "" AS ONU_CODIGO, ';

        If fCampoExiste('CADONU', 'ONU_CLARIS') Then
          strSQL := strSQL + '  ONU_CLARIS, '
        Else
          strSQL := strSQL + '  "" AS ONU_CLARIS, ';

        If fCampoExiste('CADONU', 'ONU_GRUEMB') Then
          strSQL := strSQL + '  ONU_GRUEMB, '
        Else
          strSQL := strSQL + '  "" AS ONU_GRUEMB, ';
      End
      Else
      Begin
        strSQL := strSQL + '  "" AS ONU_CODONU, ';
        strSQL := strSQL + '  "" AS ONU_DESCRI, ';
        strSQL := strSQL + '  "" AS ONU_CODIGO, ';
        strSQL := strSQL + '  "" AS ONU_CLARIS, ';
        strSQL := strSQL + '  "" AS ONU_GRUEMB, ';
      End;

      strSQL := strSQL + '  MOVDET.DET_TOTPES, ';
      strSQL := strSQL + '  MOVDET.DET_FORITE, ';

      If fCampoExiste('MOVTRI', 'DET_COICMP') And fCampoExiste('NOTTRI', 'DET_COICMP') Then //CAMPO CRIADO REQ.: 38461 MAS O REQUISITO FOI "PERDIDO" NA VIRADA 48.02.DESEN > 48.02.30
        strSQL := strSQL + '  MOVTRI.DET_COICMP, '                                          //MANTIDO AQUI SOMENTE POR QUESTÃO DE COMPATIBILIDADE
      Else
        strSQL := strSQL + '  "" AS DET_COICMP, ';

      If fCampoExiste('MOVTRI', 'DET_NUMCMP') Then
        strSQL := strSQL + '  MOVTRI.DET_NUMCMP, '
      Else
        strSQL := strSQL + '  "" AS DET_NUMCMP, ';

      If fCampoExiste('MOVTRI', 'DET_NITCMP') Then
        strSQL := strSQL + '  MOVTRI.DET_NITCMP, '
      Else
        strSQL := strSQL + '  0  AS DET_NITCMP, ';

      //Quando nao existir o campo enviar em branco
      If fCampoExiste('MOVTRI', 'DET_RICMPR') Then
        strSQL := strSQL + '  MOVTRI.DET_RICMPR, '
      Else
        strSQL := strSQL + '  "" AS DET_RICMPR, ';

      strSQL := strSQL + '  MOVDET.DET_TMPGAR, ';

      If fCampoExiste('CADITE', 'ITE_INFGAR') Then
        strSQL := strSQL + '  CADITE.ITE_INFGAR, '
      Else
        strSQL := strSQL + '  "" AS ITE_INFGAR, ';

      If fCampoExiste('MOVGER', 'GER_ICMORG') Then
        strSQL := strSQL + ' ' + strIcmOrg + ', '
      Else
        strSQL := strSQL + ' 0.00 AS GER_ICMORG, ';

      If fCampoExiste('AUXMOV', 'AUX_VRDICM') Then
        strSQL := strSQL + ' ' + strVrdIcm + ', '
      Else
        strSQL := strSQL + ' 0.00 AS AUX_VRDICM, ';

      strSQL := strSQL + '  FGO_NUMCMP, ';
      strSQL := strSQL + '  FGO_NUMPOK, ';
      strSQL := strSQL + '  FGO_PEDSIT, ';

      If fCampoExiste('FATGOR', 'FGO_ORIGEM') Then
        strSQL := strSQL + '  FGO_ORIGEM, '
      else
        strSQL := strSQL + '  "AUTCOM" AS FGO_ORIGEM, ';

      strSQL := strSQL + '  ABF_PEIMPG, ';

      If fCampoExiste('MOVTRI', 'DET_IMPPAG') Then
        strSQL := strSQL + '  MOVTRI.DET_IMPPAG, ';

      If fCampoExiste('MOVTRI', 'DET_FEDIMP') Then
        strSQL := strSQL + '  MOVTRI.DET_FEDIMP, ';

      If fCampoExiste('MOVTRI', 'DET_ESTIMP') Then
        strSQL := strSQL + '  MOVTRI.DET_ESTIMP, ';

      If fCampoExiste('MOVTRI', 'DET_MUNIMP') Then
        strSQL := strSQL + '  MOVTRI.DET_MUNIMP, ';

      If fCampoExiste('MOVTRI', 'DET_ICMORG') Then
        strSQL := strSQL + '  MOVTRI.DET_ICMORG, ';

      If fCampoExiste('MOVTRI', 'DET_VRDICM') Then
        strSQL := strSQL + '  MOVTRI.DET_VRDICM, '
      Else
        strSQL := strSQL + '  0.00 AS DET_VRDICM, ';

      If fCampoExiste('MOVTRI', 'DET_MTDICM') Then
        strSQL := strSQL + '  MOVTRI.DET_MTDICM, '
      Else
        strSQL := strSQL + '  "" AS DET_MTDICM, ';

      If fCampoExiste('MOVTRI', 'DET_ICMORG') Then
        strSQL := strSQL + '  MOVTRI.DET_ICMORG, ';

      If fCampoExiste('MOVDET', 'DET_DOCDEV') Then
      Begin
        strSQL := strSQL + '  MOVDET.DET_DOCDEV, ';
        strSQL := strSQL + '  MOVDET.DET_ESPDEV, ';
        strSQL := strSQL + '  MOVDET.DET_EMPDEV, ';

        If fCampoExiste('MOVDET', 'DET_SERDEV') Then
          strSQL := strSQL + '  MOVDET.DET_SERDEV, ';
      End
      Else
      Begin
        strSQL := strSQL + ' " " AS MOVDET.DET_DOCDEV, ';
        strSQL := strSQL + ' " " AS MOVDET.DET_ESPDEV, ';
        strSQL := strSQL + ' " " AS MOVDET.DET_EMPDEV, ';

        If fCampoExiste('MOVDET', 'DET_SERDEV') Then
          strSQL := strSQL + ' " " AS MOVDET.DET_SERDEV, ';
      End;

      If fCampoExiste('CADITE', 'ITE_CDCEST') Then
      Begin
        strSQL := strSQL + '  CADITE.ITE_CDCEST, ';
      End
      Else If fConfiguracao('CESTPD') <> '' Then
      Begin
        strSQL := strSQL + ' ' + fConfiguracao('CESTPD') + ' AS ITE_CDCEST, ';
      End
      Else Begin
        strSQL := strSQL + '  "" AS ITE_CDCEST, ';
      End;

      pAdicionaCampoCadIte('ITE_INDESC', '"S"');
      pAdicionaCampoCadIte('ITE_CNPFME', '" "');
      pAdicionaCampoCadIte('ITE_CDBFIS', '" "');
      pAdicionaCampoCadIte('ITE_ENIECB', '"N"');

      If fTabelaExiste('MOVICD') Then
      Begin
        strSQL := strSQL + '  ICD_SEQGER, ';
        strSQL := strSQL + '  ICD_BCUFDE, ';
        strSQL := strSQL + '  ICD_PERFCP, ';
        strSQL := strSQL + '  ICD_ALQUFD, ';
        strSQL := strSQL + '  ICD_ALQINE, ';
        strSQL := strSQL + '  ICD_PERPAR, ';
        strSQL := strSQL + '  ICD_VALFCP, ';
        strSQL := strSQL + '  ICD_VALDES, ';
        strSQL := strSQL + '  ICD_VALORI, ';

        If fCampoExiste('MOVICD', 'ICD_BASFCP') Then
          strSQL := strSQL + '  ICD_BASFCP, '
        Else
          strSQL := strSQL + ' ICD_BCUFDE AS ICD_BASFCP, ';
      End;

      If fTabelaExiste('AUXMOV') And (fCampoExiste('AUXMOV', 'AUX_VENPRE')) Then
        strSQL := strSQL + '  AUX_VENPRE, ';

      If (fCampoExiste('MOVGER', 'GER_ENTFAT')) Then
        strSQL := strSQL + '     GER_ENTFAT, '
      Else
        strSQL := strSQL + ' "N" GER_ENTFAT, ';

      If blnNSRBru Then
        strSQL := strSQL + '     EMP_NSRBRU, '
      Else
        strSQL := strSQL + '  -1 EMP_NSRBRU, ';

      If fTabelaExiste('DOCEXP') And (fCampoExiste('DOCEXP', 'EXP_UFEMBA')) Then
      Begin
        strSQL := strSQL + '  DOCEXP.EXP_UFEMBA, ';
        strSQL := strSQL + '  DOCEXP.EXP_LOEMBA, ';
        strSQL := strSQL + '  DOCEXP.EXP_LOCDES ';
      End
      Else
      Begin
        strSQL := strSQL + ' " " AS EXP_UFEMBA, ';
        strSQL := strSQL + ' " " AS EXP_LOEMBA, ';
        strSQL := strSQL + ' " " AS EXP_LOCDES ';
      End;

      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + strCadFis;

      strSQL := strSQL + 'LEFT JOIN MOVGER ON MOVGER.GER_NUMDOC = FIS_NUMDOC AND ';
      strSQL := strSQL + '                    MOVGER.GER_ESPDOC = FIS_ESPDOC AND ';
      strSQL := strSQL + '                    MOVGER.GER_SERIE_ = FIS_SERIE_ AND ';
      strSQL := strSQL + '                    MOVGER.GER_CODEMP = FIS_CODEMP AND ';
      strSQL := strSQL + '                    MOVGER.GER_TIP_FC = FIS_TIP_FC AND ';
      strSQL := strSQL + '                    IF(FIS_TIP_FC="C", MOVGER.GER_CODCLI, MOVGER.GER_CODFOR) = FIS_FORCLI ';

      If fTabelaExiste('SERMOV') Then
        strSQL := strSQL + 'LEFT JOIN SERMOV ON SERMOV.GER_SEQGER = MOVGER.AUTOINCREM ';

      strSQL := strSQL + 'LEFT JOIN MOVDET ON DET_NUMDOC = MOVGER.GER_NUMDOC AND ';
      strSQL := strSQL + '                    DET_ESPDOC = MOVGER.GER_ESPDOC AND ';
      strSQL := strSQL + '                    DET_SERIE_ = MOVGER.GER_SERIE_ AND ';
      strSQL := strSQL + '                    DET_CODEMP = MOVGER.GER_CODEMP AND ';
      strSQL := strSQL + '                    DET_TIP_FC = MOVGER.GER_TIP_FC AND ';
      strSQL := strSQL + '                    IF(FIS_TIP_FC="C", DET_CODCLI, DET_CODFOR) = IF(FIS_TIP_FC="C", MOVGER.GER_CODCLI, MOVGER.GER_CODFOR) ';

      strSQL := strSQL + 'LEFT JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM ';

      if fCampoExiste('MOVGER', 'GER_CODS01') then
        strSQL := strSQL + 'LEFT JOIN CADSER ON CADSER.SER_CODSER = MOVGER.GER_CODS01 '
      else
        strSQL := strSQL + 'LEFT JOIN CADSER ON CADSER.SER_CODSER = "" ';

      if blnTrSeCi And fTabelaExiste('TRISER') then
      begin
        strSQL := strSQL + 'INNER JOIN CADEMP ON CADEMP.EMP_CODEMP = CADFIS.FIS_CODEMP ';
        strSQL := strSQL + 'LEFT  JOIN TRISER ON TSE_CODSER = CADSER.SER_CODSER AND TSE_CODCID = EMP_CODCID ';
      End
      Else If blnNSRBru Then
      Begin
        strSQL := strSQL + 'INNER JOIN CADEMP ON CADEMP.EMP_CODEMP = CADFIS.FIS_CODEMP ';
      End;

      strSQL := strSQL + 'LEFT JOIN CADITE ON CADITE.ITE_CODITE = DET_CODITE ';

      strSQL := strSQL + 'LEFT JOIN ITEGER ON ITEGER.ITE_CODITE = DET_CODITE AND ';
      strSQL := strSQL + '                    ITEGER.ITE_CODEMP = DET_CODEMP ';

      if fCampoExiste('MOVDET', 'DET_ITEEMB') then
        strSQL := strSQL + 'LEFT JOIN CADITE ITEEMB ON ITEEMB.ITE_CODITE = DET_ITEEMB ';

      If fCampoExiste('MOVTRI', 'DET_ITEABF') Then
        strSQL := strSQL + 'LEFT JOIN CADITE ITEABF ON ITEABF.ITE_CODITE = DET_ITEABF '
      Else
        strSQL := strSQL + 'LEFT JOIN CADITE ITEABF ON ITEABF.ITE_CODITE = DET_CODITE ';

      If fTabelaExiste('CADLOT') Then
      Begin
        strSQL := strSQL + 'LEFT JOIN CADLOT ON DET_NUMLOT = LOT_NUMLOT AND ';
        strSQL := strSQL + '                    DET_CODITE = LOT_CODITE AND ';
        strSQL := strSQL + '                    DET_CODEMP = LOT_CODEMP     ';
      End;

      strSQL := strSQL + 'LEFT JOIN NOTCOM ON NOTCOM.GER_SEQGER = CADFIS.AUTOINCREM ';
      strSQL := strSQL + 'LEFT JOIN CLICON ON CLICON.CON_C_P_F_ = ' + IIF(blnCliConNC, 'NOTCOM.GER_CPFCON', 'NULL') + ' ';

      strSQL := strSQL + 'LEFT JOIN CADTRA ON MOVGER.GER_CODTRA = CADTRA.TRA_CODTRA ';

      strSQL := strSQL + 'LEFT JOIN CADCID AS CIDTRA ON CIDTRA.CID_CODCID = TRA_CODCID ';

      strSQL := strSQL + 'LEFT JOIN CADCLI CL ON CL.CLI_CODCLI = FIS_FORCLI AND FIS_TIP_FC="C" ';
      strSQL := strSQL + 'LEFT JOIN CADFOR ON FOR_CODFOR = FIS_FORCLI AND FIS_TIP_FC="F" ';

      If fTabelaExiste('AUXMOV') Then
      Begin
        strSQL := strSQL + 'LEFT JOIN AUXMOV ON AUXMOV.AUX_SEQGER = MOVGER.AUTOINCREM ';
        strSQL := strSQL + 'LEFT JOIN ENTCLI ON AUXMOV.AUX_ENTGER = ENTCLI.AUTOINCREM AND ENTCLI.ETC_CODCLI = CL.CLI_CODCLI ';

        If blnCadFaz Then
          strSQL := strSQL + 'LEFT JOIN CADFAZ ON CADFAZ.FAZ_CODFAZ = IFNULL(NOTCOM.GER_CODFAZ, AUXMOV.AUX_CODFAZ) ';

        strSQL := strSQL + strWhereTraRed_;
      End;

      strSQL := strSQL + 'LEFT JOIN CADCID CC ON CC.CID_CODCID = IF(' + STR_CLIENTE_CONSUMIDOR + ', ' + fConsumid('GER_CIDCON', 'CON_CODCID') + ', ' + fFazenda('CLI_CODCID', 'FAZ_CODCID') + ') ';
      strSQL := strSQL + 'LEFT JOIN CADCID CF ON CF.CID_CODCID = FOR_CODCID ';

      strSQL := strSQL + 'LEFT JOIN CADUNI AS UV ON UV.UNI_CODUNI = DET_UNIDAD ';

      If (fConfiguracao('UNITRI') = 'S') Then
        strSQL := strSQL + '  LEFT  JOIN CADUNI AS UT ON UT.UNI_CODUNI = CADITE.ITE_UNITRI ';

      strSQL := strSQL + 'LEFT JOIN CADMAR ON MAR_CODMAR = DET_CODMAR ';

      If fConfiguracao('TIPABF') = '1' Then
      Begin
        If fCampoExiste('ABFICM', 'ABF_CSTORI') Then
          strSQL := strSQL + 'LEFT JOIN ' + strTabAbf + ' ON ABF_CODABF = CADITE.ITE_CODABF AND ABF_CSTORI = CADITE.ITE_CSTORI AND '
        Else
          strSQL := strSQL + 'LEFT JOIN ' + strTabAbf + ' ON ABF_CODABF = CADITE.ITE_CODABF AND '
      End
      Else
      Begin
        If fCampoExiste('ABFICM', 'ABF_CSTORI') then
          strSQL := strSQL + 'LEFT JOIN ' + strTabAbf + ' ON ABF_CODABF = ITEGER.ITE_CODABF AND ABF_CSTORI = ITEGER.ITE_CSTORI AND '
        Else
          strSQL := strSQL + 'LEFT JOIN ' + strTabAbf + ' ON ABF_CODABF = ITEGER.ITE_CODABF AND ';
      End;


      strSQL := strSQL + '                    ABF_ESTADO = MOVGER.GER_ESTADO ';

      If Not fCampoExiste('NATCFO', 'NAT_DESCRI') Then
      Begin
        strSQL := strSQL + 'LEFT JOIN CADCFO C1 ON C1.CFO_CODCFO = MOVGER.GER_CLAFIS ';
        strSQL := strSQL + 'LEFT JOIN CADCFO C2 ON C2.CFO_CODCFO = MOVGER.GER_CLAFI2 ';
        strSQL := strSQL + 'LEFT JOIN CADCFO C3 ON C3.CFO_CODCFO = MOVGER.GER_CLAFI3 ';
        strSQL := strSQL + 'LEFT JOIN CADCFO C4 ON C4.CFO_CODCFO = MOVGER.GER_CLAFI4 ';
      End;

      strSQL := strSQL + 'LEFT JOIN CADOPE VE ON VE.OPE_CODOPE = MOVGER.GER_CODVEN ';
      strSQL := strSQL + 'LEFT JOIN CADOPE DI ON DI.OPE_CODOPE = MOVGER.GER_CODDIG ';

      strSQL := strSQL + 'LEFT JOIN MOVOBS ON MOV_SEQGER = MOVGER.AUTOINCREM ';

      strSQL := strSQL + 'LEFT JOIN CLIPRO P ON P.CLI_CODITE = DET_CODITE AND ';
      strSQL := strSQL + '                      P.CLI_CODCLI = DET_CODCLI ';

      strSQL := strSQL + 'LEFT JOIN FATGOR ON DET_NUM_PD = FGO_NUMDOC AND ';
      strSQL := strSQL + '                    DET_ESP_PD = FGO_ESPDOC AND ';
      strSQL := strSQL + '                    DET_EMP_PD = FGO_CODEMP AND ';
      strSQL := strSQL + '                    DET_CODCLI = FGO_CODCLI     ';

      If ((fConfiguracao('VENMAD') = 'S') Or
          (fConfiguracao('VENVID') = 'S') Or
          (fConfiguracao('VENMTL') = 'S')) And
           fTabelaExiste('MOVMAD') Then
        strSQL := strSQL + 'LEFT JOIN MOVMAD ON MOVMAD.DET_SEQGER = MOVDET.AUTOINCREM ';

      If objConfig.blnClaOnu Then
        strSQL := strSQL + 'LEFT JOIN CADONU ON CADITE.ITE_CODONU = CADONU.ONU_CODONU ';

      If fTabelaExiste('MOVICD') Then
      Begin
        strSQL := strSQL + 'LEFT JOIN MOVICD ON MOVICD.ICD_SEQGER = MOVDET.AUTOINCREM ';
      End;

      If fTabelaExiste('DOCEXP') Then
        strSQL := strSQL + 'LEFT JOIN DOCEXP ON DOCEXP.EXP_SEQFIS = CADFIS.AUTOINCREM ';

      if fCampoExiste('MOVDET', 'DET_CODACA') then
      begin
        strSQL := strSQL + 'LEFT JOIN CADACA ACA ON ACA.ACA_CODACA = MOVDET.DET_CODACA AND ';
        strSQL := strSQL + '                        ACA.ACA_CODEMP = MOVDET.DET_EMPACA     ';
      end;

      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  IFNULL(FIS_HISTOR,"") <> "CANCELADO" AND ';

      strSQL := strSQL + '  IF(FIS_NFCOMP="S", TRUE, MOVGER.GER_NUMDOC IS NOT NULL) AND ';

      strSQL := strSQL + '  IFNULL(DET_PROEMB,"N") <> "S" AND ';

      strSQL := strSQL + '  FIS_TIP_FC = :TIP_FC AND ';
      strSQL := strSQL + '  FIS_NUMDOC = :NUMDOC AND ';
      strSQL := strSQL + '  FIS_ESPDOC = :ESPDOC AND ';
      strSQL := strSQL + '  FIS_CODEMP = :CODEMP AND ';
      strSQL := strSQL + '  FIS_FORCLI = :CODCLI AND ';
      strSQL := strSQL + '  IFNULL(FIS_SERIE_, "") = :SERIE_ ';

      If (Not fNotaComplemento(FNumDoc, FEspDoc, FCodEmp, FCodCli, FSerie, FTip_FC)) Then
      Begin
        strSQLNot := strSQL;
        strSQLNot := AnsiReplaceStr(strSQLNot, 'MOVGER', 'NOTGER');
        strSQLNot := AnsiReplaceStr(strSQLNot, 'MOVDET', 'NOTDET');
        strSQLNot := AnsiReplaceStr(strSQLNot, 'MOVOBS', 'NOTOBS');
        strSQLNot := AnsiReplaceStr(strSQLNot, 'MOVTRI', 'NOTTRI');
        strSQLNot := AnsiReplaceStr(strSQLNot, 'AUXMOV', 'AUXNOT');
        strSQLNot := AnsiReplaceStr(strSQLNot, 'SERMOV', 'SERNOT');
        strSQLNot := AnsiReplaceStr(strSQLNot, 'MOVMAD', 'NOTMAD');
        strSQLNot := AnsiReplaceStr(strSQLNot, 'MOVICD', 'NOTICD');
        strSQLNot := AnsiReplaceStr(strSQLNot, 'GER_DTADOC', 'GER_DTAENT');
        strSQLNot := AnsiReplaceStr(strSQLNot, 'AUX_CLIORI', '"        "');
        strSQLNot := AnsiReplaceStr(strSQLNot, 'DET_ITEABF', '""');
        strSQLNot := AnsiReplaceStr(strSQLNot, 'DET_NUM_PD', '""');
        strSQLNot := AnsiReplaceStr(strSQLNot, 'DET_ESP_PD', '""');
        strSQLNot := AnsiReplaceStr(strSQLNot, 'DET_EMP_PD', '""');
        strSQLNot := AnsiReplaceStr(strSQLNot, 'DET_IND_PD', '""');

        If fCampoExiste('NOTGER', 'GER_DUPREC') Then
        Begin
          strSQLNot := AnsiReplaceStr(strSQLNot, '0.00 AS GER_DUPREC', 'GER_DUPREC');
          strSQLNot := AnsiReplaceStr(strSQLNot, 'AUX_DUPREC AS GER_DUPREC', 'GER_DUPREC');
        End;

        If Not fCampoExiste('NOTGER', 'GER_ICMORG') Then
        Begin
          strSQLNot := AnsiReplaceStr(strSQLNot, strIcmOrg, ' 0.00 AS GER_ICMORG ');
        End;

        If Not fCampoExiste('NOTTRI', 'DET_ICMORG') Then
        Begin
          strSQLNot := AnsiReplaceStr(strSQLNot, 'NOTTRI.DET_ICMORG', ' 0.00 AS DET_ICMORG ');
        End;

        If Not fCampoExiste('AUXNOT', 'AUX_VRDICM') Then
        Begin
          strSQLNot := AnsiReplaceStr(strSQLNot, strVrdIcm, ' 0.00 AS AUX_VRDICM ');
        End;

        If Not fCampoExiste('AUXNOT', 'AUX_CHVNFE') Then
        Begin
          strSQLNot := AnsiReplaceStr(strSQLNot, strChvNfe, ' " " AS GER_CHVNFE ');
        End;

        If Not fCampoExiste('AUXNOT', 'AUX_NUMCOO') Then
        Begin
          strSQLNot := AnsiReplaceStr(strSQLNot, strNumCOO, ' " " AS GER_NUMCOO ');
        End;

        If Not fCampoExiste('AUXNOT', 'AUX_NUMSER') Then
        Begin
          strSQLNot := AnsiReplaceStr(strSQLNot, strNumSer, ' " " AS GER_NUMSER ');
        End;

        If Not fCampoExiste('AUXNOT', 'AUX_NUMUSU') Then
        Begin
          strSQLNot := AnsiReplaceStr(strSQLNot, strNumUSU, ' " " AS GER_NUMUSU ');
        End;

        If Not fCampoExiste('AUXNOT', 'AUX_TIPDOC') Then
        Begin
          strSQLNot := AnsiReplaceStr(strSQLNot, strTipDoc, ' " " AS GER_TIPDOC ');
        End;

        If Not fCampoExiste('AUXNOT', 'AUX_EST_DV') Then
        Begin
          strSQLNot := AnsiReplaceStr(strSQLNot, strEst_Dv, ' " " AS GER_EST_DV ');
        End;

        If Not fCampoExiste('AUXNOT', 'AUX_NUMERO') Then
        Begin
          strSQLNot := AnsiReplaceStr(strSQLNot, strNumero, ' " " AS GER_NUMERO ');
        End;

        If Not fCampoExiste('AUXNOT', 'AUX_SERIE_') Then
        Begin
          strSQLNot := AnsiReplaceStr(strSQLNot, strSerie_, ' " " AS GER_SERIE1 ');
        End;

        If Not fCampoExiste('AUXNOT', 'AUX_MODELO') Then
        Begin
          strSQLNot := AnsiReplaceStr(strSQLNot, strModelo, ' " " AS GER_MODELO ');
        End;

        If Not fCampoExiste('AUXNOT', 'AUX_CPFCNP') Then
        Begin
          strSQLNot := AnsiReplaceStr(strSQLNot, strCPFCNP, ' " " AS GER_CPFCNP ');
        End;

        If Not fCampoExiste('AUXNOT', 'AUX_ESTADO') Then
        Begin
          strSQLNot := AnsiReplaceStr(strSQLNot, strEstado, ' " " AS GER_ESTADO ');
        End;

        If Not fCampoExiste('AUXNOT', 'AUX_MESANO') Then
        Begin
          strSQLNot := AnsiReplaceStr(strSQLNot, strMesAno, ' " " AS GER_MESANO ');
        End;

        If fCampoExiste('AUXNOT', 'AUX_COMVAL') Then
        Begin
          strSQLNot := AnsiReplaceStr(strSQLNot, strComVal, ' AUX_COMVAL AS GER_COMVAL ');
        End;

       If (Not fCampoExiste('NOTDET', 'DET_DESNES')) And
          (Not fCampoExiste('NOTTRI', 'DET_DESNES')) Then
          strSQLNot := AnsiReplaceStr(strSQLNot, 'DET_DESNES', '"" DET_DESNES');

        strSQLNot := AnsiReplaceStr(strSQLNot, 'REPEAT(" ", 20) AS DET_AUTINC, ', 'NOTDET.AUTOINCREM AS DET_AUTINC, ');

        If (Not fCampoExiste('NOTTRI', 'DET_VAEIPI')) Then
          strSQLNot := AnsiReplaceStr(strSQLNot, 'DET_VALIPI + IFNULL(NOTTRI.DET_VAEIPI,0)', '0');

        If (Not fCampoExiste('AUXNOT', 'AUX_TRARDP')) Then
        Begin
          If (Not fEmptyStr(strSelectTraRed)) Then
          Begin
            strSelectTraRed := AnsiReplaceStr(strSelectTraRed, 'AUXMOV', 'AUXNOT');
            strWhereTraRed_ := AnsiReplaceStr(strWhereTraRed_, 'AUXMOV', 'AUXNOT');

            strSQLNot := AnsiReplaceStr(strSQLNot, strSelectTraRed, ' " " AS TRA_EMAILR, ');
            strSQLNot := AnsiReplaceStr(strSQLNot, strWhereTraRed_, ' ');
          End;
        End;

        strSQL := strSQL + ' UNION ALL ' + strSQLNot;
      End;

      strSQL := strSQL + fRetOrderByNota('', fConfiguracao('ORDALF'));

      Result := strSQL;
    end;

    function fGetSQLCadFis(strCadFis: String): String;
    var
      intAux : Integer;
    begin

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  CADFIS.AUTOINCREM AS FIS_AUTOINCREM,  ';
      strSQL := strSQL + '  MOVDET.AUTOINCREM AS DET_AUTOINCREM,  ';
      strSQL := strSQL + '  "MOVDET"          AS CHAVE_TABELA,    ';
      strSQL := strSQL + '  MOVDET.DET_SEQGER AS CHAVE_DUPLICATA, ';

      strSQL := strSQL + '  CADFIS.FIS_ESPDOC AS GER_ESPDOC, ';
      strSQL := strSQL + '  CADFIS.FIS_CODEMP AS GER_CODEMP, ';

      If FTip_FC = 'C' Then
      Begin
        strSQL := strSQL + '  CADFIS.FIS_FORCLI GER_CODCLI, ';
        strSQL := strSQL + '  IF(' + STR_CLIENTE_CONSUMIDOR + ', ' +                                                                               '"S", "N") AS GER_CONSUM, ';
        strSQL := strSQL + '  " " AS GER_MATREV, ';
        strSQL := strSQL + '  IF(' + STR_CLIENTE_CONSUMIDOR + ', ' + fConsumid('GER_CGCCON', 'CON_C_P_F_') + ', ' + fFazenda('CLI_C_G_C_', 'FAZ_C_G_C_') + ') AS GER_CGCCON, ';
        strSQL := strSQL + '  IF(' + STR_CLIENTE_CONSUMIDOR + ', ' + fConsumid('GER_NOMCON', 'CON_NOMCON') + ', ' + fFazenda('CLI_NOMCLI', 'CLI_NOMCLI') + ') AS GER_NOMCON, ';
        strSQL := strSQL + '  IF(' + STR_CLIENTE_CONSUMIDOR + ', ' + fConsumid('GER_NOMCON', 'CON_NOMCON') + ', ' + fFazenda('CLI_NOMCLI', 'CLI_NOMCLI') + ') AS GER_NOMFAN, ';
        strSQL := strSQL + '  IF(' + STR_CLIENTE_CONSUMIDOR + ', ' + fConsumid('GER_ENDCON', 'CON_ENDERE') + ', ' + fFazenda('CLI_ENDERE', 'FAZ_NOMFAZ') + ') AS GER_ENDERE, ';
        strSQL := strSQL + '  IF(' + STR_CLIENTE_CONSUMIDOR + ', "", '                                            + fFazenda('CLI_ENDNUM', 'NULL'      ) + ') AS GER_ENDNUM, ';
        strSQL := strSQL + '  IF(' + STR_CLIENTE_CONSUMIDOR + ', "", '                                            + fFazenda('CLI_ENDCOM', 'NULL'      ) + ') AS GER_ENDCOM, ';
        strSQL := strSQL + '  IF(' + STR_CLIENTE_CONSUMIDOR + ', ' + fConsumid('GER_BAICON', 'CON_BAIRRO') + ', ' + fFazenda('CLI_BAIRRO', 'FAZ_BAIRRO') + ') AS GER_BAICON, ';
        strSQL := strSQL + '  IF(' + STR_CLIENTE_CONSUMIDOR + ', ' + fConsumid('GER_CIDCON', 'CON_CODCID') + ', ' + fFazenda('CLI_CODCID', 'FAZ_CODCID') + ') AS GER_CIDCON, ';
        strSQL := strSQL + '  IF(' + STR_CLIENTE_CONSUMIDOR + ', ' + fConsumid('GER_CEPCON', 'CON_C_E_P_') + ', ' + fFazenda('CLI_C_E_P_', 'FAZ_C_E_P_') + ') AS GER_CEPCON, ';
        strSQL := strSQL + '  IF(' + STR_CLIENTE_CONSUMIDOR + ', ' + fConsumid('GER_TELCON', 'CON_FONE01') + ', ' + fFazenda('CLI_FONE01', 'CLI_FONE01') + ') AS GER_TELCON, ';
        strSQL := strSQL + '  IF(' + STR_CLIENTE_CONSUMIDOR + ', ' + fConsumid('GER_IESCON', 'CON_I_E_S_') + ', ' + fFazenda('CLI_I_E_S_', 'FAZ_I_E_S_') + ') AS GER_IESCON, ';
        strSQL := strSQL + '  CC.CID_ESTADO AS GER_ESTCON, ';
        strSQL := strSQL + '  CC.CID_NOMCID AS GER_NOMCID, ';
        strSQL := strSQL + '  CC.CID_CODPAI AS GER_CODPAI, ';
        {***************************************************}
        {* SE O CAMPO GER_EMLCON EXISTIR NA TABELA MOVGER, *}
        {* PEGA O E-MAIL DO CLIENTE "CONSUMIDOR"           *}
        {************************************************RV*}
        If fCampoExiste('MOVGER', 'GER_EMLCON') Then
          strSQL := strSQL + '  IF(' + STR_CLIENTE_CONSUMIDOR + ', ' + fConsumid('GER_EMLCON', 'CON_EMLCON') + ', ' + fFazenda('CLI_EMAIL3', 'CLI_EMAIL3') + ') AS GER_EMAIL_, '
        Else
          strSQL := strSQL + '  CLI_EMAIL3 AS GER_EMAIL_, ';

        strSQL := strSQL + ' CLI_SUFRAM AS GER_SUFRAM, ';

        strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%", "", CLI_EMAIL2)                AS GER_EMAIL2, ';
        strSQL := strSQL + '  CLI_DIFERI AS GER_DIFERI, ';

        If fCampoExiste('AUXMOV', 'AUX_RETISS') Then
          strSQL := strSQL + '  AUX_RETISS AS GER_RETISS, '
        Else
          strSQL := strSQL + '  CLI_RETISS AS GER_RETISS, ';

        If fCampoExiste('AUXMOV', 'AUX_NOTPAU') Then
          strSQL := strSQL + '  AUX_NOTPAU AS GER_NOTPAU, '
        Else
          strSQL := strSQL + '  "S" AS GER_NOTPAU, ';

        If fCampoExiste('MOVGER', 'GER_CONSUM') And (fConfiguracao('USOREV') = 'S') Then
          strSQL := strSQL + '  IF((GER_CONSUM = "S") OR (GER_CONSUM = "N"), GER_CONSUM, CLI_CONSUM) AS GER_CLICON, '
        Else
          strSQL := strSQL + '  CLI_CONSUM AS GER_CLICON, ';

        strSQL := strSQL + '  CLI_ZONFRA AS GER_ZONFRA, ';
        strSQL := strSQL + '  CLI_CODATI AS GER_CODATI, ';

        If fCampoExiste('MOVGER', 'GER_CSLRET') Then
        Begin
          strSQL := strSQL + '  MOVGER.GER_PISRET, ';
          strSQL := strSQL + '  MOVGER.GER_COFRET, ';
          strSQL := strSQL + '  MOVGER.GER_IRFRET, ';
          strSQL := strSQL + '  MOVGER.GER_CSLRET, ';
          strSQL := strSQL + '  MOVGER.GER_VLSGSO, ';
        End
        Else
        Begin
          strSQL := strSQL + '  0.00 AS GER_PISRET, ';
          strSQL := strSQL + '  0.00 AS GER_COFRET, ';
          strSQL := strSQL + '  0.00 AS GER_IRFRET, ';
          strSQL := strSQL + '  0.00 AS GER_CSLRET, ';
          strSQL := strSQL + '  0.00 AS GER_VLSGSO, ';
        End;

        If fCampoExiste('CADCLI', 'CLI_PRORUR') Then
          strSQL := strSQL + '  CLI_PRORUR AS GER_PRORUR, '
        Else
          strSQL := strSQL + '  "N"        AS GER_PRORUR, ';

        If fCampoExiste('CADCLI', 'CLI_BENREI') Then
          strSQL := strSQL + '  CLI_BENREI AS GER_BENREI, '
        Else
          strSQL := strSQL + '  "N"        AS GER_BENREI, ';

        If fCampoExiste('CADCLI', 'CLI_MICEMP') Then
          strSQL := strSQL + '  CLI_MICEMP AS GER_MICEMP, '
        Else
          strSQL := strSQL + '  "N"        AS GER_MICEMP, ';

        strSQL := strSQL + ' IF(' + STR_CLIENTE_CONSUMIDOR + ', "S" ,';
        If fCampoExiste('CADCLI', 'CLI_IESUNI') Then
          strSQL := strSQL + '  CLI_IESUNI) AS GER_IESUNI, '
        Else
          strSQL := strSQL + '  "N"       ) AS GER_IESUNI, ';

        If fCampoExiste('CADCLI', 'CLI_REGTRI') Then
          strSQL := strSQL + '  CLI_REGTRI AS GER_REGTRI, '
        Else
          strSQL := strSQL + '  " "        AS GER_REGTRI, ';

        If fCampoExiste('CADCLI', 'CLI_STREES') Then
          strSQL := strSQL + '  CLI_STREES AS GER_STREES, '
        Else
          strSQL := strSQL + '  "N"        AS GER_STREES, ';

        If fCampoExiste('CADCLI', 'CLI_PRSTRE') Then
          strSQL := strSQL + '  CLI_PRSTRE AS GER_PRSTRE, '
        Else
          strSQL := strSQL + '  " "        AS GER_PRSTRE, ';

        If fCampoExiste('CADCLI', 'CLI_ORGPUB') Then
          strSQL := strSQL + '  CLI_ORGPUB AS GER_ORGPUB, '
        Else
          strSQL := strSQL + '  "N"        AS GER_ORGPUB, ';

        If fCampoExiste('CADCLI', 'CLI_ENTGOV') Then
          strSQL := strSQL + '  CLI_ENTGOV AS GER_ENTGOV, '
        Else
          strSQL := strSQL + '  CAST("" AS CHAR(1)) AS GER_ENTGOV, ';

        If fCampoExiste('CADCLI', 'CLI_TPOPEG') Then
          strSQL := strSQL + '  CLI_TPOPEG AS GER_TPOPEG, '
        Else
          strSQL := strSQL + '  CAST("" AS CHAR(1)) AS GER_TPOPEG, ';

        If fCampoExiste('CADCLI', 'CLI_INDUST') Then
          strSQL := strSQL + '  CLI_INDUST AS GER_INDUST, '
        Else
          strSQL := strSQL + '  "N"        AS GER_INDUST, ';

        If fCampoExiste('CADCLI', 'CLI_ORPURD') Then
          strSQL := strSQL + '  CLI_ORPURD AS GER_ORPURD, '
        Else
          strSQL := strSQL + '  " "        AS GER_ORPURD, ';

        If fCampoExiste('CADCLI', 'CLI_CALICM') Then
          strSQL := strSQL + '  CLI_CALICM AS GER_CALICM, '
        Else
          strSQL := strSQL + '  "N"        AS GER_CALICM, ';

        If fCampoExiste('CADCLI', 'CLI_I_M_P_') Then
          strSQL := strSQL + '  CLI_I_M_P_ AS GER_IMPCON, '
        Else
          strSQL := strSQL + '  ""         AS GER_IMPCON, ';

      End
      Else
      Begin
        strSQL := strSQL + '  CADFIS.FIS_FORCLI GER_CODCLI, ';
        strSQL := strSQL + '  "N"        AS GER_CONSUM, ';

        If fCampoExiste('CADFOR', 'FOR_MATREV') Then
          strSQL := strSQL + '  FOR_MATREV AS GER_MATREV, '
        Else
          strSQL := strSQL + '  " " AS GER_MATREV, ';

        strSQL := strSQL + '  FOR_C_G_C_ AS GER_CGCCON, ';
        strSQL := strSQL + '  FOR_NOMFOR AS GER_NOMCON, ';
        strSQL := strSQL + '  FOR_NOMFAN AS GER_NOMFAN, ';
        strSQL := strSQL + '  FOR_ENDERE AS GER_ENDERE, ';
        strSQL := strSQL + '  FOR_ENDNUM AS GER_ENDNUM, ';
        strSQL := strSQL + '  FOR_ENDCOM AS GER_ENDCOM, ';
        strSQL := strSQL + '  FOR_BAIRRO AS GER_BAICON, ';
        strSQL := strSQL + '  FOR_CODCID AS GER_CIDCON, ';
        strSQL := strSQL + '  FOR_C_E_P_ AS GER_CEPCON, ';
        strSQL := strSQL + '  FOR_FONE01 AS GER_TELCON, ';
        strSQL := strSQL + '  FOR_I_E_S_ AS GER_IESCON, ';
        strSQL := strSQL + '  CF.CID_ESTADO AS GER_ESTCON, ';
        strSQL := strSQL + '  CF.CID_NOMCID AS GER_NOMCID, ';
        strSQL := strSQL + '  CF.CID_CODPAI AS GER_CODPAI, ';

        If fCampoExiste('CADFOR', 'FOR_EMAIL3') Then
        Begin
          strSQL := strSQL + '  FOR_EMAIL3 AS GER_EMAIL_, ';
        End
        Else
        Begin
          strSQL := strSQL + '  FOR_EMAIL_ AS GER_EMAIL_, ';
        End;

        If fCampoExiste('CADFOR', 'FOR_SUFRAM') Then
          strSQL := strSQL + '  FOR_SUFRAM AS GER_SUFRAM, '
        Else
          strSQL := strSQL + '  "" AS GER_SUFRAM, ';

        If fCampoExiste('CADFOR', 'FOR_EMAIL2') Then
        Begin
          strSQL := strSQL + '  FOR_EMAIL2 AS GER_EMAIL2, ';
        End
        Else
        Begin
          strSQL := strSQL + '  "" AS GER_EMAIL2, ';
        End;

        strSQL := strSQL + '  ""         AS GER_DIFERI, ';
        strSQL := strSQL + '  ""         AS GER_RETISS, ';
        strSQL := strSQL + '  ""         AS GER_NOTPAU, ';
        strSQL := strSQL + '  ""         AS GER_CLICON, ';
        strSQL := strSQL + '  ""         AS GER_ZONFRA, ';
        strSQL := strSQL + '  "000"      AS GER_CODATI, ';
        strSQL := strSQL + '  0.00       AS GER_PISRET, ';
        strSQL := strSQL + '  0.00       AS GER_COFRET, ';
        strSQL := strSQL + '  0.00       AS GER_IRFRET, ';
        strSQL := strSQL + '  0.00       AS GER_CSLRET, ';
        strSQL := strSQL + '  0.00       AS GER_VLSGSO, ';
        strSQL := strSQL + '  "N"        AS GER_PRORUR, ';
        strSQL := strSQL + '  "N"        AS GER_BENREI, ';
        strSQL := strSQL + '  "N"        AS GER_MICEMP, ';
        strSQL := strSQL + '  "N"        AS GER_IESUNI, ';

        If fCampoExiste('CADFOR', 'FOR_SIMPAU') Then
          strSQL := strSQL + '  FOR_SIMPAU AS GER_REGTRI, '
        Else
          strSQL := strSQL + '  " "        AS GER_REGTRI, ';

        strSQL := strSQL + '  "N"        AS GER_STREES, ';
        strSQL := strSQL + '  " "        AS GER_PRSTRE, ';
        strSQL := strSQL + '  "N"        AS GER_ORGPUB, ';
        strSQL := strSQL + '  CAST("" AS CHAR(1)) AS GER_ENTGOV, ';
        strSQL := strSQL + '  CAST("" AS CHAR(1)) AS GER_TPOPEG, ';
        strSQL := strSQL + '  "N"        AS GER_INDUST, ';
        strSQL := strSQL + '  " "        AS GER_ORPURD, ';
        strSQL := strSQL + '  "N"        AS GER_CALICM, ';
        strSQL := strSQL + '  ""         AS GER_IMPCON, ';
      End;

      strSQL := strSQL + '  FIS_FORCLI, ';
      strSQL := strSQL + '  FIS_NUMDOC, ';
      strSQL := strSQL + '  FIS_ESPDOC, ';
      strSQL := strSQL + '  FIS_CODEMP, ';
      strSQL := strSQL + '  FIS_SERIE_, ';
      strSQL := strSQL + '  FIS_TIP_FC, ';
      strSQL := strSQL + '  FIS_DTAENT, ';
      strSQL := strSQL + '  FIS_DTADOC, ';

      For intAux := 1 To 5 Do
      Begin
        strSQL := strSQL + '  FIS_CLFSC' + intToStr(intAux) + ', ';
        strSQL := strSQL + '  FIS_VLCON' + intToStr(intAux) + ', ';
        strSQL := strSQL + '  FIS_BASIC' + intToStr(intAux) + ', ';
        strSQL := strSQL + '  FIS_ALQIC' + intToStr(intAux) + ', ';
        strSQL := strSQL + '  FIS_VLRIC' + intToStr(intAux) + ', ';
        strSQL := strSQL + '  FIS_BCRET' + intToStr(intAux) + ', ';
        strSQL := strSQL + '  FIS_RETID' + intToStr(intAux) + ', ';
        strSQL := strSQL + '  FIS_BASIP' + intToStr(intAux) + ', ';
        strSQL := strSQL + '  FIS_VLRIP' + intToStr(intAux) + ', ';
      End;

      strSQL := strSQL + '  FIS_NOTESP, ';
      strSQL := strSQL + '  FIS_HISTOR, ';

      strSQL := strSQL + '  CADFIS.FIS_NUMDOC AS GER_NUMDOC, ';
      strSQL := strSQL + '  CADFIS.FIS_CLFSC1 AS GER_CLAFIS, ';
      strSQL := strSQL + '  CADFIS.FIS_CODCON AS GER_CONPAG, ';
      strSQL := strSQL + '  CADFIS.FIS_CODCON AS GER_CODCND, ';
      strSQL := strSQL + '  CADFIS.FIS_SERIE_ AS GER_SERIE_, ';
      strSQL := strSQL + '  CADFIS.FIS_DTAENT AS GER_DTAENT, ';
      strSQL := strSQL + '  "00:00:00" AS GER_HORENT, ';
      strSQL := strSQL + '  CADFIS.FIS_DTADOC AS GER_DTADOC, ';

      strSQL := strSQL + '  (IFNULL(FIS_BASIC1,0)+IFNULL(FIS_BASIC2,0)+IFNULL(FIS_BASIC3,0)+ ';
      strSQL := strSQL + '   IFNULL(FIS_BASIC4,0)+IFNULL(FIS_BASIC5,0)) AS GER_BASICM, ';

      strSQL := strSQL + '  (IFNULL(FIS_VLRIC1,0)+IFNULL(FIS_VLRIC2,0)+IFNULL(FIS_VLRIC3,0)+ ';
      strSQL := strSQL + '   IFNULL(FIS_VLRIC4,0)+IFNULL(FIS_VLRIC5,0)) AS GER_TOTICM, ';

      strSQL := strSQL + '  (IFNULL(FIS_BCRET1,0)+IFNULL(FIS_BCRET2,0)+IFNULL(FIS_BCRET3,0)+IFNULL(FIS_BCRET4,0)+IFNULL(FIS_BCRET5,0)+ ';
      strSQL := strSQL + '   IFNULL(FIS_BAERE1,0)+IFNULL(FIS_BAERE2,0)+IFNULL(FIS_BAERE3,0)+IFNULL(FIS_BAERE4,0)+IFNULL(FIS_BAERE5,0)) AS GER_BASRET, ';

      strSQL := strSQL + '  (IFNULL(FIS_VAERE1,0)+IFNULL(FIS_VAERE2,0)+IFNULL(FIS_VAERE3,0)+IFNULL(FIS_VAERE4,0)+IFNULL(FIS_VAERE5,0)) AS GER_TOTRET, ';

      strSQL := strSQL + '  MOVGER.GER_TOTPRO, ';
      strSQL := strSQL + '  MOVGER.GER_TOTFRE, ';
      strSQL := strSQL + '  MOVGER.GER_DESESP, ';

      strSQL := strSQL + '  (IFNULL(FIS_BASIP1,0)+IFNULL(FIS_BASIP1,0)+IFNULL(FIS_BASIP1,0)+IFNULL(FIS_BASIP1,0)+IFNULL(FIS_BASIP1,0)+ ';
      strSQL := strSQL + '   IFNULL(FIS_BAEIP1,0)+IFNULL(FIS_BAEIP1,0)+IFNULL(FIS_BAEIP1,0)+IFNULL(FIS_BAEIP1,0)+IFNULL(FIS_BAEIP1,0)) AS GER_BASIPI, ';

      strSQL := strSQL + '  (IFNULL(FIS_VLRIP1,0)+IFNULL(FIS_VLRIP2,0)+IFNULL(FIS_VLRIP3,0)+IFNULL(FIS_VLRIP4,0)+IFNULL(FIS_VLRIP5,0)+ ';
      strSQL := strSQL + '   IFNULL(FIS_VAEIP1,0)+IFNULL(FIS_VAEIP2,0)+IFNULL(FIS_VAEIP3,0)+IFNULL(FIS_VAEIP4,0)+IFNULL(FIS_VAEIP5,0)) AS GER_TOTIPI, ';

      strSQL := strSQL + '  FIS_TOTPIS AS GER_VALPIS, ';
      strSQL := strSQL + '  MOVGER.GER_VALCOF, ';
      strSQL := strSQL + '  MOVGER.GER_DESACE, ';
      strSQL := strSQL + '  (IFNULL(FIS_VLCON1,0)+IFNULL(FIS_VLCON2,0)+IFNULL(FIS_VLCON3,0)+IFNULL(FIS_VLCON4,0)+IFNULL(FIS_VLCON5,0)) AS GER_VLRCON, ';

      If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_IMPPAG') Then
        strSQL := strSQL + '  AUX_IMPPAG AS GER_IMPPAG,'
      Else If fCampoExiste('MOVGER', 'GER_IMPPAG') Then
        strSQL := strSQL + '  MOVGER.GER_IMPPAG,'
      Else
        strSQL := strSQL + '  0.00 AS GER_IMPPAG,';

      If fTabelaExiste('AUXMOV') And
         fCampoExiste('AUXMOV', 'AUX_FEDIMP') And
         fCampoExiste('AUXNOT', 'AUX_FEDIMP') Then
        strSQL := strSQL + '  AUX_FEDIMP AS GER_FEDIMP,'
      Else
        strSQL := strSQL + '  0.00 AS GER_FEDIMP,';

      If fTabelaExiste('AUXMOV') And
         fCampoExiste('AUXMOV', 'AUX_ESTIMP') And
         fCampoExiste('AUXNOT', 'AUX_ESTIMP') Then
        strSQL := strSQL + '  AUX_ESTIMP AS GER_ESTIMP,'
      Else
        strSQL := strSQL + '  0.00 AS GER_ESTIMP,';

      If fTabelaExiste('AUXMOV') And
         fCampoExiste('AUXMOV', 'AUX_MUNIMP') And
         fCampoExiste('AUXNOT', 'AUX_MUNIMP') Then
        strSQL := strSQL + '  AUX_MUNIMP AS GER_MUNIMP,'
      Else
        strSQL := strSQL + '  0.00 AS GER_MUNIMP,';

      If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_OPCDOC') Then
        strSQL := strSQL + '  AUX_OPCDOC AS GER_OPCDOC,'
      Else
      Begin
        strSQL := strSQL + '  IF(RIGHT(GER_CLAFIS, 3)="929", "CI", ' +
                           '     IF(LOCATE(GER_CLAFIS, "' + CFOP_DEVOLUCAO + '") > 0, ' +
                           '        IF(GER_TIP_FC="C", "DV", "OF"), " ")) AS GER_OPCDOC, ';
      End;


      If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_CHVNFE') Then
        strSQL := strSQL + ' ' + strChvNfe + ', '
      Else
        strSQL := strSQL + '  "  " AS GER_CHVNFE,';

      If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_NUMCOO') Then
        strSQL := strSQL + ' ' + strNumCOO + ', '
      Else
        strSQL := strSQL + '  "  " AS GER_NUMCOO,';

      If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_NUMSER') Then
        strSQL := strSQL + ' ' + strNumSer + ', '
      Else
        strSQL := strSQL + '  "  " AS GER_NUMSER,';

      If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_NUMUSU') Then
        strSQL := strSQL + ' ' + strNumUSU + ', '
      Else
        strSQL := strSQL + '  "  " AS GER_NUMUSU,';

      If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_TIPDOC') Then
        strSQL := strSQL + ' ' + strTipDoc + ', '
      Else
        strSQL := strSQL + '  "  " AS GER_TIPDOC,';

      If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_EST_DV') Then
        strSQL := strSQL + ' ' + strEst_Dv + ', '
      Else
        strSQL := strSQL + '  "  " AS GER_EST_DV,';

      If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_CLIORI') Then
        strSQL := strSQL + '  AUX_CLIORI AS GER_CLIORI,'
      Else
        strSQL := strSQL + '  "        " AS GER_CLIORI,';

      If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_NUMERO') Then
        strSQL := strSQL + ' ' + strNumero + ', '
      Else
        strSQL := strSQL + '  "  " AS GER_NUMERO,';

      If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_SERIE_') Then
        strSQL := strSQL + ' ' + strSerie_ + ', '
      Else
        strSQL := strSQL + '  "  " AS GER_SERIE1,';

      If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_MODELO') Then
        strSQL := strSQL + ' ' + strModelo + ', '
      Else
        strSQL := strSQL + '  "  " AS GER_MODELO,';

      If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_CPFCNP') Then
        strSQL := strSQL + ' ' + strCPFCNP + ', '
      Else
        strSQL := strSQL + '  "  " AS GER_CPFCNP,';

      If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_ESTADO') Then
        strSQL := strSQL + ' ' + strEstado + ', '
      Else
        strSQL := strSQL + '  "  " AS GER_ESTADO,';

      If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_MESANO') Then
        strSQL := strSQL + ' ' + strMesAno + ', '
      Else
        strSQL := strSQL + '  "  " AS GER_MESANO,';

      strSQL := strSQL + ' ' + strComVal + ', ';

      strSQL := strSQL + '  NOTCOM.GER_DOCORI, ';
      strSQL := strSQL + '  NOTCOM.GER_SERORI, ';
      strSQL := strSQL + '  NOTCOM.GER_ACEORI, ';
      strSQL := strSQL + '  NOTCOM.GER_DESITE, ';
      strSQL := strSQL + '  NOTCOM.GER_MENC01, ';
      strSQL := strSQL + '  NOTCOM.GER_MENC02, ';
      strSQL := strSQL + '  NOTCOM.GER_MENC03, ';
      strSQL := strSQL + '  NOTCOM.GER_MENC04, ';
      strSQL := strSQL + '  NOTCOM.GER_MENC05, ';
      strSQL := strSQL + '  NOTCOM.GER_MENC06, ';
      strSQL := strSQL + '  NOTCOM.GER_MENC07, ';
      strSQL := strSQL + '  NOTCOM.GER_MENC08, ';
      strSQL := strSQL + '  NOTCOM.GER_MENC09, ';
      strSQL := strSQL + '  NOTCOM.GER_MENC10, ';
      If fCampoExiste('NOTCOM', 'GER_ESPORI') Then
      Begin
        strSQL := strSQL + '  NOTCOM.GER_ESPORI, ';
        strSQL := strSQL + '  NOTCOM.GER_EMPORI, ';
      End;
      If fCampoExiste('NOTCOM', 'GER_COMICM') Then
      Begin
        strSQL := strSQL + '  NOTCOM.GER_COMICM, ';
      End;
      If fCampoExiste('NOTCOM', 'GER_CREICM') Then
      Begin
        strSQL := strSQL + '  NOTCOM.GER_CREICM, ';
      End;
      If fCampoExiste('NOTCOM', 'GER_TRAICM') Then
      Begin
        strSQL := strSQL + '  NOTCOM.GER_TRAICM, ';
      End;
      If fCampoExiste('NOTCOM', 'GER_COMVAL') Then
      Begin
        strSQL := strSQL + '  NOTCOM.GER_COMVAL AS COMPLEMENTO_VALOR, ';
      End;
      If fCampoExiste('NOTCOM', 'GER_RESICM') Then
      Begin
        strSQL := strSQL + '  NOTCOM.GER_RESICM, ';
      End;

      strSQL := strSQL + '  FIS_NFCOMP, ';
      strSQL := strSQL + '  FIS_IMPMER, ';
      strSQL := strSQL + '  FIS_IMPSEG, ';
      strSQL := strSQL + '  FIS_IMPIMP, ';

      If fCampoExiste('CADFIS', 'FIS_CSTENT') Then
        strSQL := strSQL + '  FIS_CSTENT, ';

      If fCampoExiste('CADFIS', 'FIS_BASEII') Then
      Begin
        strSQL := strSQL + '  FIS_BASEII, ';
        strSQL := strSQL + '  FIS_DESADU, ';
        strSQL := strSQL + '  FIS_VALIOF, ';
      End
      Else
      Begin
        strSQL := strSQL + '  0.00 AS FIS_BASEII, ';
        strSQL := strSQL + '  0.00 AS FIS_DESADU, ';
        strSQL := strSQL + '  0.00 AS FIS_VALIOF, ';
      End;

      If fCampoExiste('CADFIS', 'FIS_VAFRMM') Then
        strSQL := strSQL + '  FIS_VAFRMM, '
      Else
        strSQL := strSQL + '  0.00 AS FIS_VAFRMM, ';

      If fCampoExiste('DOCIMP', 'IMP_VLRADP') Then
        strSQL := strSQL + '  (SELECT IFNULL(SUM(IMP_VLRADP),0) FROM DOCIMP ' +
                  '   WHERE IMP_SQMVDT = MOVDET.AUTOINCREM) AS FIS_VALADP, '
      Else
        strSQL := strSQL + '  0.00 AS FIS_VALADP, ';

      strSQL := strSQL + '  FIS_IMPPRO, ';
      strSQL := strSQL + '  FIS_IMPTAX, ';
      strSQL := strSQL + '  FIS_IMPPIS, ';
      strSQL := strSQL + '  FIS_IMPCOF, ';
      strSQL := strSQL + '  FIS_IMPIC1, ';
      strSQL := strSQL + '  FIS_IMPIC2, ';
      strSQL := strSQL + '  FIS_TOTPIS, ';
      strSQL := strSQL + '  FIS_TOTCOF, ';
      strSQL := strSQL + '  MOVGER.GER_TIPFRE, ';
      strSQL := strSQL + '  CADTRA.TRA_C_G_C_, ';
      strSQL := strSQL + '  CADTRA.TRA_NOMTRA, ';
      strSQL := strSQL + '  CADTRA.TRA_I_E_S_, ';
      strSQL := strSQL + '  CADTRA.TRA_ENDERE, ';

      If fCampoExiste('AUXMOV', 'AUX_PLAFAT') Then
        strSQL := strSQL + ' AUX_PLAFAT AS TRA_NUMPLA, '
      Else
        strSQL := strSQL + '  CADTRA.TRA_NUMPLA, ';

      strSQL := strSQL + '  CADTRA.TRA_EMAIL_, ';

      strSQL := strSQL + strSelectTraRed;

      If fCampoExiste('CADTRA', 'TRA_C_ANTT') Then
        strSQL := strSQL + '  CADTRA.TRA_C_ANTT, '
      Else
        strSQL := strSQL + ' "" AS TRA_C_ANTT, ';

      strSQL := strSQL + '  CIDTRA.CID_NOMCID AS TRA_NOMCID, ';
      strSQL := strSQL + '  CIDTRA.CID_ESTADO AS TRA_ESTADO, ';
      strSQL := strSQL + '  IFNULL(MOVGER.GER_VOLUME, 0) AS GER_VOLUME, ';
      strSQL := strSQL + '  MOVGER.GER_ESPECI, ';
      strSQL := strSQL + '  MOVGER.GER_MARCA_, ';
      strSQL := strSQL + '  MOVGER.GER_PESLIQ, ';
      strSQL := strSQL + '  MOVGER.GER_PESBRU, ';

      If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_NUMERA') Then
        strSQL := strSQL + '  AUX_NUMERA, '
      Else
        strSQL := strSQL + ' "" AS AUX_NUMERA, ';

      strSQL := strSQL + '  IFNULL(MOVGER.GER_FATNOT, 0) AS GER_FATNOT, ';

      strSQL := strSQL + '  MOVGER.GER_VPAR01, ';
      strSQL := strSQL + '  MOVGER.GER_VPAR02, ';
      strSQL := strSQL + '  MOVGER.GER_VPAR03, ';
      strSQL := strSQL + '  MOVGER.GER_VPAR04, ';
      strSQL := strSQL + '  MOVGER.GER_VPAR05, ';
      strSQL := strSQL + '  MOVGER.GER_VPAR06, ';
      strSQL := strSQL + '  MOVGER.GER_VPAR07, ';
      strSQL := strSQL + '  MOVGER.GER_VPAR08, ';
      strSQL := strSQL + '  MOVGER.GER_VPAR09, ';
      strSQL := strSQL + '  MOVGER.GER_VPAR10, ';
      strSQL := strSQL + '  MOVGER.GER_VPAR11, ';
      strSQL := strSQL + '  MOVGER.GER_VPAR12, ';

      strSQL := strSQL + '  DET_CODITE, ';

      if fCampoExiste('MOVDET', 'DET_CODACA') then
      begin
        strSQL := strSQL + '  DET_CODACA, ';
        strSQL := strSQL + '  DET_EMPACA, ';
      end
      else
      begin
        strSQL := strSQL + '  "" AS DET_CODACA, ';
        strSQL := strSQL + '  "" AS DET_EMPACA, ';
      end;

      If fCampoExiste('CADACA', 'ACA_UNITIN') and fCampoExiste('MOVDET', 'DET_CODACA') Then
        strSQL := strSQL + '  ACA_UNITIN, '
      Else
        strSQL := strSQL + '  0 AS ACA_UNITIN, ';

      strSQL := strSQL + '  CLI_COD_NF, ';

      If fTabelaExiste('CLIPRO') And fCampoExiste('CLIPRO', 'CLI_DES_NF') Then
        strSQL := strSQL + '  CLI_DES_NF, '
      Else
        strSQL := strSQL + '  "" AS CLI_DES_NF, ';

      {********************************************}
      {* SE NF FOR DE GARANTIA, ENTÃO DEVE SAIR   *}
      {* O CÓD. FAB. CADASTRADO NA TABELA MOVGAD  *}
      {* SE NÃO PEGA DO CADITE                    *}
      {*****************************************MM*}
      If fCampoExiste('MOVGAD', 'GAD_CODFAB') Then
      Begin
        strSQL := strSQL + '  IF(LOCATE(MOVGER.GER_CLAFIS,' + QuotedStr(fClaFisGarantia) + ') > 0, ';
        strSQL := strSQL + '      (SELECT GAD_CODFAB FROM MOVGAD WHERE AUTOINCREM = MOVTRI.DET_SEQGAD), ';
        strSQL := strSQL + '       CADITE.ITE_CODFAB ';
        strSQL := strSQL + '    ) AS ITE_CODFAB, ';
      End
      Else
      Begin
        strSQL := strSQL + '  CADITE.ITE_CODFAB, ';
      End;

      strSQL := strSQL + '  CADITE.ITE_DESFAB, ';
      strSQL := strSQL + '  CADITE.ITE_CODBAR, ';
      strSQL := strSQL + '  DET_DESCRI, ';

      //Versao 27.16.470 - CFG_NCMTIN
      If fEmiteNCMPorLinhaDeTinta Then
      Begin
        strSQL := strSQL + '  IF(DET_IDEPRO = "NOR", IFNULL(ITEABF.ITE_CLAIPI, CADITE.ITE_CLAIPI), IF(IFNULL(MOVTRI.TRI_NCMTIN,"") <> "", MOVTRI.TRI_NCMTIN, IFNULL(ITEABF.ITE_CLAIPI, CADITE.ITE_CLAIPI))) AS ITE_CLAIPI, ';
      End
      //Versoes superiores a 27.16.470 - CFG_NCMTIN nao existe mais
      Else
      Begin
        if fCampoExiste('MOVDET', 'DET_ITEEMB') then
        begin
          If fCampoExiste('MOVTRI', 'TRI_NCMTIN') Then
            strSQL := strSQL + '  IF(DET_IDEPRO = "NOR", IFNULL(ITEABF.ITE_CLAIPI, CADITE.ITE_CLAIPI), IF(IFNULL(MOVTRI.TRI_NCMTIN, "") <> "", MOVTRI.TRI_NCMTIN, IFNULL(ITEEMB.ITE_CLAIPI, IFNULL(ITEABF.ITE_CLAIPI, CADITE.ITE_CLAIPI)))) AS ITE_CLAIPI, '
          Else
            strSQL := strSQL + '  IF(DET_IDEPRO = "NOR", IFNULL(ITEABF.ITE_CLAIPI, CADITE.ITE_CLAIPI), IFNULL(ITEEMB.ITE_CLAIPI, IFNULL(ITEABF.ITE_CLAIPI, CADITE.ITE_CLAIPI))) AS ITE_CLAIPI, ';
        end
        else
          strSQL := strSQL + '  IFNULL(ITEABF.ITE_CLAIPI, CADITE.ITE_CLAIPI) AS ITE_CLAIPI, ';
      End;

      If (fOutrasSaidasConEqu()) Then
        strSQL := strSQL + ' MOVTRI.DET_NCMITE AS DET_NCMITE, '
      Else
        strSQL := strSQL + ' "" AS DET_NCMITE, ';


      If fCampoExiste('CADITE', 'ITE_EXCIPI') Then
        strSQL := strSQL + '  CADITE.ITE_EXCIPI AS ITE_EXCIPI, '
      Else
        strSQL := strSQL + '  " " AS ITE_EXCIPI, ';

      strSQL := strSQL + '  DET_CLAFIS, ';
      strSQL := strSQL + '  UV.UNI_SIGUNI AS ITE_SIGUNV, ';

      If fCampoExiste('CADUNI', 'UNI_PESLIT') Then
        strSQL := strSQL + '  UV.UNI_PESLIT AS UNI_PESLTV, '
      Else
        strSQL := strSQL + '  0.000 AS UNI_PESLTV, ';

      If (fConfiguracao('UNITRI') <> 'S') Then
      Begin
        strSQL := strSQL + '  UV.UNI_SIGUNI AS ITE_SIGUNT, ';
        strSQL := strSQL + '  1.000000 AS ITE_FATUTR, ';
      End
      Else
      Begin
        strSQL := strSQL + '  IFNULL(UT.UNI_SIGUNI, UV.UNI_SIGUNI) AS ITE_SIGUNT, ';
        strSQL := strSQL + '  IFNULL(CADITE.ITE_FATUTR, 1) AS ITE_FATUTR, ';
      End;

      strSQL := strSQL + '  DET_QTDITE, ';
      strSQL := strSQL + '  DET_UNITAR, ';
      strSQL := strSQL + '  DET_TOTITE, ';
      strSQL := strSQL + '  DET_DESESP, ';
      strSQL := strSQL + '  DET_CODFIS, ';
      strSQL := strSQL + '  DET_NUMLOT, ';
      strSQL := strSQL + '  DET_UNIORI, ';

      If fCampoExiste('CADLOT', 'LOT_DTAVAL') Then
        strSQL := strSQL + '  LOT_DTAVAL, '
      Else
        strSQL := strSQL + ' " " AS LOT_DTAVAL, ';

      If fTabelaExiste('CADLOT') Then
        strSQL := strSQL + '   IF(IFNULL(DET_NUMLOT, "") = "", ITE_LOCFIS, LOT_LOCFIS) AS DET_LOCFIS, '
      Else
        strSQL := strSQL + '   ITE_LOCFIS AS DET_LOCFIS, ';

      If fCampoExiste('CADLOT', 'LOT_LOCSEP') And fCampoExiste('ITEGER', 'ITE_CODLSE') Then
        strSQL := strSQL + '   IFNULL(NULLIF(LOT_LOCSEP, ""), ITE_CODLSE) AS DET_CODLSE, '
      Else If fCampoExiste('ITEGER', 'ITE_CODLSE') Then
        strSQL := strSQL + '   ITE_CODLSE AS DET_CODLSE, '
      Else
        strSQL := strSQL + '   " " AS DET_CODLSE, ';

      strSQL := strSQL + '  DET_DESNES, ';
      strSQL := strSQL + '  DET_CODMAR, ';
      strSQL := strSQL + '  MAR_DESMAR, ';
      strSQL := strSQL + '  CADITE.ITE_MENFIS, ';

      If fCampoExiste('CADITE', 'ITE_PROPCD') Then
        strSQL := strSQL + '  CADITE.ITE_PROPCD, '
      Else
        strSQL := strSQL + '  " " AS ITE_PROPCD, ';

      strSQL := strSQL + '  DET_BASICM, ';
      strSQL := strSQL + '  DET_ALQICM, ';
      strSQL := strSQL + '  DET_VALICM, ';

      if blnBaERet Then
        strSQL := strSQL + '  DET_BASRET + IFNULL(DET_BAERET,0) AS DET_BASRET, '
      Else
        strSQL := strSQL + '  DET_BASRET, ';

      strSQL := strSQL + '  DET_ALQRET, ';

      If blnVaERet Then
        strSQL := strSQL + '  DET_VALRET + IFNULL(DET_VAERET,0) AS DET_VALRET, '
      Else
        strSQL := strSQL + '  DET_VALRET, ';

      strSQL := strSQL + '  DET_PERRED, ';

      If fCampoExiste('MOVTRI', 'DET_VALIVA') Then
        strSQL := strSQL + '  DET_VALIVA, '
      Else
        strSQL := strSQL + '  0.00 DET_VALIVA, ';

      If fCampoExiste('MOVTRI', 'DET_PEBAST') Then
        strSQL := strSQL + '  DET_PEBAST, '
      Else
        strSQL := strSQL + '  DET_PERBAS AS DET_PEBAST, ';

      If blnVaEIPI Then
        strSQL := strSQL + '  DET_VALIPI + IFNULL(MOVTRI.DET_VAEIPI,0) AS DET_VALIPI, '
      Else
        strSQL := strSQL + '  DET_VALIPI, ';

      strSQL := strSQL + '  DET_BASIPI, ';
      strSQL := strSQL + '  DET_ALQIPI, ';
      strSQL := strSQL + '  DET_TOTFRE, ';
      strSQL := strSQL + '  DET_DESACE, ';
      strSQL := strSQL + '  CADITE.ITE_CODABF, ';

      If strTabAbf = 'ABFICM' Then
      Begin
        If fCampoExiste('ABFICM', 'ABF_RICMPR_SAI_CNC') Then
        Begin
          strSQL := strSQL + '  ABF_RICMPR_SAI_CNC, ';
        End
        Else
        Begin
          strSQL := strSQL + '  "N" AS ABF_RICMPR_SAI_CNC, ';
        End;

        If FTip_FC = 'C' Then
        Begin
          strSQL := strSQL + fRetSQLMsg1e2TipAbfdeSAI('NCO'); //RETORNA MENSAGENS NÃO CONTRIBUINTE
          strSQL := strSQL + fRetSQLMsg1e2TipAbfdeSAI('CCO'); //RETORNA MENSAGENS CONTRIBUINTE CONSUMIDOR
          strSQL := strSQL + fRetSQLMsg1e2TipAbfdeSAI('CNC'); //RETORNA MENSAGENS CONTRIBUINTE NÃO CONSUMIDOR
          strSQL := strSQL + fRetSQLMsg1e2TipAbfdeSAI('CTA'); //RETORNA MENSAGENS CONSTRUTORA
          strSQL := strSQL + fRetSQLMsg1e2TipAbfdeSAI('PRU'); //RETORNA MENSAGENS PRODUTOR RURAL
          strSQL := strSQL + fRetSQLMsg1e2TipAbfdeSAI('SNA'); //RETORNA MENSAGENS SIMPLES NACIONAL
          strSQL := strSQL + fRetSQLMsg1e2TipAbfdeSAI('IND'); //RETORNA MENSAGENS INDUSTRIA
          strSQL := strSQL + fRetSQLMsg1e2TipAbfdeSAI('TRS'); //RETORNA MENSAGENS CLIENTE FILIAL
        End;
      End
      Else
      Begin
        strSQL := strSQL + '  "N" AS ABF_RICMPR_SAI_CNC, ';
        strSQL := strSQL + '  ABF_MENSAG AS ABF_MENS01, ';
        strSQL := strSQL + '  ABF_MENSA2 AS ABF_MENS02, ';

        For intAux:=3 To 6 Do
        Begin
          If fCampoExiste('CADABF', 'ABF_MENSA'+IntToStr(intAux)) Then
            strSQL := strSQL + '  ABF_MENSA'+IntToStr(intAux)+' AS '+'ABF_MENS'+fStrZero(IntToStr(intAux),2) + ', '
          Else
            strSQL := strSQL + '  "" AS '+'ABF_MENS'+fStrZero(IntToStr(intAux),2) + ', '
        End;
      End;

      strSQL := strSQL + '  FIS_ACESSO, ';
      strSQL := strSQL + '  MOVGER.GER_CODVEN, ';
      strSQL := strSQL + '  IFNULL(MOVGER.GER_CODDIG, "") AS GER_CODDIG, ';

      If objConfig.blnAutCen Then
      Begin
        strSQL := strSQL + ' (SELECT ';
        strSQL := strSQL + '    GROUP_CONCAT(DISTINCT  " ", CONCAT(DET_CODVEN, "-", OPE_NOMOPE)) AS NOME ';
        strSQL := strSQL + '  FROM ';
        strSQL := strSQL + '    MOVDET D INNER JOIN CADOPE O ON D.DET_CODVEN = O.OPE_CODOPE ';
        strSQL := strSQL + '  WHERE ';
        strSQL := strSQL + '    D.DET_SEQGER = MOVGER.AUTOINCREM) AS OPE_NOMOPE, ';
      End
      Else
        strSQL := strSQL + '  VE.OPE_NOMOPE, ';

      If objConfig.blnAutCen Then
      Begin
        strSQL := strSQL + ' (SELECT ';
        strSQL := strSQL + '    GROUP_CONCAT(DISTINCT  " ", CONCAT(DET_CODDIG, "-", OPE_NOMOPE)) AS NOME ';
        strSQL := strSQL + '  FROM ';
        strSQL := strSQL + '    MOVDET D INNER JOIN CADOPE O ON D.DET_CODDIG = O.OPE_CODOPE ';
        strSQL := strSQL + '  WHERE ';
        strSQL := strSQL + '    D.DET_SEQGER = MOVGER.AUTOINCREM) AS OPE_NOMDIG, ';
      End
      Else
        strSQL := strSQL + '  DI.OPE_NOMOPE AS OPE_NOMDIG, ';

      strSQL := strSQL + '  MOVGER.GER_MEN001, ';
      strSQL := strSQL + '  MOVGER.GER_MEN002, ';
      strSQL := strSQL + '  MOVGER.GER_MEN003, ';
      strSQL := strSQL + '  MOVGER.GER_MEN004, ';
      strSQL := strSQL + '  MOVGER.GER_MEN005, ';

      If fCampoExiste('NATCFO', 'NAT_DESCRI') Then
        strSQL := strSQL + '  IF(TRIM(IFNULL(MOVGER.GER_NATOPE,""))<>"", MOVGER.GER_NATOPE, (SELECT NAT_DESCRI FROM NATCFO WHERE NAT_CODCFO = FIS_CLFSC1 LIMIT 1) ) AS CFO_NATOPE_01, '
      Else If fCampoExiste('MOVGER', 'GER_NATOPE') Then
        strSQL := strSQL + '  IF(TRIM(IFNULL(MOVGER.GER_NATOPE,""))<>"", MOVGER.GER_NATOPE, C1.CFO_NATOPE) AS CFO_NATOPE_01, '
      Else
        strSQL := strSQL + '  C1.CFO_NATOPE AS CFO_NATOPE_01, ';

      If fCampoExiste('NATCFO', 'NAT_DESCRI') Then
      Begin
        strSQL := strSQL + '  (SELECT NAT_DESCRI FROM NATCFO WHERE NAT_CODCFO = GER_CLAFI2 LIMIT 1) AS CFO_NATOPE_02, ';
        strSQL := strSQL + '  (SELECT NAT_DESCRI FROM NATCFO WHERE NAT_CODCFO = GER_CLAFI3 LIMIT 1) AS CFO_NATOPE_03, ';
        strSQL := strSQL + '  (SELECT NAT_DESCRI FROM NATCFO WHERE NAT_CODCFO = GER_CLAFI4 LIMIT 1) AS CFO_NATOPE_04, ';
      End
      Else
      Begin
        strSQL := strSQL + '  C2.CFO_NATOPE AS CFO_NATOPE_02, ';
        strSQL := strSQL + '  C3.CFO_NATOPE AS CFO_NATOPE_03, ';
        strSQL := strSQL + '  C4.CFO_NATOPE AS CFO_NATOPE_04, ';
      End;

      strSQL := strSQL + '  MOVGER.GER_TOTSER, ';

      If fCampoExiste('CADFIS', 'FIS_BASISS') Then
        strSQL := strSQL + '  CADFIS.FIS_BASISS AS GER_BASISS, ';

      strSQL := strSQL + '  MOVGER.GER_PERISS, ';
      strSQL := strSQL + '  MOVGER.GER_VALISS, ';
      strSQL := strSQL + '  MOVOBS.MOV_OBSERV, ';

      If fCampoExiste('MOVOBS', 'MOV_OBSFIS') Then
        strSQL := strSQL + '  MOVOBS.MOV_OBSFIS, '
      Else
        strSQL := strSQL + ' " " AS MOV_OBSFIS, ';

      strSQL := strSQL + '  MOVOBS.MOV_IPDPNF, ';
      strSQL := strSQL + '  MOVOBS.MOV_IPDPCI, ';
      strSQL := strSQL + '  MOVOBS.MOV_DTESNF, ';
      strSQL := strSQL + '  MOVOBS.MOV_HRESNF, ';

      If fCampoExiste('MOVOBS', 'MOV_CNFNFE') Then
        strSQL := strSQL + '  MOVOBS.MOV_CNFNFE, '
      Else
        strSQL := strSQL + ' " " AS MOV_CNFNFE, ';

      If fCampoExiste('MOVOBS', 'MOV_CNFFIS') Then
        strSQL := strSQL + '  MOVOBS.MOV_CNFFIS, '
      Else
        strSQL := strSQL + ' " " AS MOV_CNFFIS, ';

      If fCampoExiste('MOVDET', 'DET_INCPIS') Then
        strSQL := strSQL + '  DET_INCPIS AS ITE_INCPIS, '
      Else
        strSQL := strSQL + '  CADITE.ITE_INCPIS, ';

      strSQL := strSQL + '  REPEAT(" ", 20) AS DET_AUTINC, ';

      strSQL := strSQL + '  MOVTRI.DET_BARTSP, ';
      strSQL := strSQL + '  MOVTRI.DET_VLRTSP, ';
      strSQL := strSQL + '  MOVTRI.DET_ICOPPR, ';

      If fCampoExiste('MOVTRI', 'DET_CSTPIS') Then
      Begin
        strSQL := strSQL + '  MOVTRI.DET_CSTPIS, ';
        strSQL := strSQL + '  MOVTRI.DET_BASPIS, ';
        strSQL := strSQL + '  MOVTRI.DET_ALQPIS, ';
        strSQL := strSQL + '  MOVTRI.DET_VALPIS, ';
        strSQL := strSQL + '  MOVTRI.DET_CSTCOF, ';
        strSQL := strSQL + '  MOVTRI.DET_BASCOF, ';
        strSQL := strSQL + '  MOVTRI.DET_ALQCOF, ';
        strSQL := strSQL + '  MOVTRI.DET_VALCOF, ';

        strSQL := strSQL + '  MOVTRI.DET_CSTIPI, ';
      End;

      If fCampoExiste('MOVTRI', 'DET_ENQIPI') Then
        strSQL := strSQL + '  MOVTRI.DET_ENQIPI, ';

      if fCampoExiste('MOVGER', 'GER_DESS01') then
      begin
        strSQL := strSQL + '  MOVGER.GER_DESS01, ';
        strSQL := strSQL + '  MOVGER.GER_DESS02, ';
        strSQL := strSQL + '  MOVGER.GER_DESS03, ';
        strSQL := strSQL + '  MOVGER.GER_DESS04, ';
        strSQL := strSQL + '  MOVGER.GER_DESS05, ';
        strSQL := strSQL + '  MOVGER.GER_DESS06, ';
      end
      else
      begin
        strSQL := strSQL + '  "" AS GER_DESS01, ';
        strSQL := strSQL + '  "" AS GER_DESS02, ';
        strSQL := strSQL + '  "" AS GER_DESS03, ';
        strSQL := strSQL + '  "" AS GER_DESS04, ';
        strSQL := strSQL + '  "" AS GER_DESS05, ';
        strSQL := strSQL + '  "" AS GER_DESS06, ';
      end;

      // Se existe os serviços 07, 08, 09 e 10
      If fTabelaExiste('SERMOV') And fCampoExiste('SERMOV', 'GER_DESS07') Then
      Begin
        strSQL := strSQL + '  SERMOV.GER_DESS07, ';
        strSQL := strSQL + '  SERMOV.GER_DESS08, ';
        strSQL := strSQL + '  SERMOV.GER_DESS09, ';
        strSQL := strSQL + '  SERMOV.GER_DESS10, ';
      End;

      If fTabelaExiste('SERMOV') And fCampoExiste('SERMOV', 'GER_DESS11') Then Begin
        strSQL := strSQL + '  SERMOV.GER_DESS11, ';
        strSQL := strSQL + '  SERMOV.GER_DESS12, ';
        strSQL := strSQL + '  SERMOV.GER_DESS13, ';
        strSQL := strSQL + '  SERMOV.GER_DESS14, ';
        strSQL := strSQL + '  SERMOV.GER_DESS15, ';
        strSQL := strSQL + '  SERMOV.GER_DESS16, ';
        strSQL := strSQL + '  SERMOV.GER_DESS17, ';
        strSQL := strSQL + '  SERMOV.GER_DESS18, ';
        strSQL := strSQL + '  SERMOV.GER_DESS19, ';
        strSQL := strSQL + '  SERMOV.GER_DESS20, ';
        strSQL := strSQL + '  SERMOV.GER_DESS21, ';
        strSQL := strSQL + '  SERMOV.GER_DESS22, ';
        strSQL := strSQL + '  SERMOV.GER_DESS23, ';
        strSQL := strSQL + '  SERMOV.GER_DESS24, ';
        strSQL := strSQL + '  SERMOV.GER_DESS25, ';
        strSQL := strSQL + '  SERMOV.GER_DESS26, ';
        strSQL := strSQL + '  SERMOV.GER_DESS27, ';
        strSQL := strSQL + '  SERMOV.GER_DESS28, ';
        strSQL := strSQL + '  SERMOV.GER_DESS29, ';
        strSQL := strSQL + '  SERMOV.GER_DESS30, ';
      End;

      if fCampoExiste('MOVGER', 'GER_VALS01') then
      begin
        If fTabelaExiste('SERMOV') And fCampoExiste('SERMOV','GER_DECS01') Then
        Begin
          If fCampoExiste('SERMOV','GER_IDES01') Then
          Begin
            strSQL := strSQL + ' IF(SERMOV.GER_IDES01 = "I", 0.00, (MOVGER.GER_VALS01 - (MOVGER.GER_VALS01 * (SERMOV.GER_DECS01 / 100)))) AS GER_VALS01, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES02 = "I", 0.00, (MOVGER.GER_VALS02 - (MOVGER.GER_VALS02 * (SERMOV.GER_DECS02 / 100)))) AS GER_VALS02, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES03 = "I", 0.00, (MOVGER.GER_VALS03 - (MOVGER.GER_VALS03 * (SERMOV.GER_DECS03 / 100)))) AS GER_VALS03, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES04 = "I", 0.00, (MOVGER.GER_VALS04 - (MOVGER.GER_VALS04 * (SERMOV.GER_DECS04 / 100)))) AS GER_VALS04, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES05 = "I", 0.00, (MOVGER.GER_VALS05 - (MOVGER.GER_VALS05 * (SERMOV.GER_DECS05 / 100)))) AS GER_VALS05, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES06 = "I", 0.00, (MOVGER.GER_VALS06 - (MOVGER.GER_VALS06 * (SERMOV.GER_DECS06 / 100)))) AS GER_VALS06, ';
          End
          Else
          Begin
            strSQL := strSQL + ' (MOVGER.GER_VALS01 - (MOVGER.GER_VALS01 * (SERMOV.GER_DECS01 / 100))) AS GER_VALS01, ';
            strSQL := strSQL + ' (MOVGER.GER_VALS02 - (MOVGER.GER_VALS02 * (SERMOV.GER_DECS02 / 100))) AS GER_VALS02, ';
            strSQL := strSQL + ' (MOVGER.GER_VALS03 - (MOVGER.GER_VALS03 * (SERMOV.GER_DECS03 / 100))) AS GER_VALS03, ';
            strSQL := strSQL + ' (MOVGER.GER_VALS04 - (MOVGER.GER_VALS04 * (SERMOV.GER_DECS04 / 100))) AS GER_VALS04, ';
            strSQL := strSQL + ' (MOVGER.GER_VALS05 - (MOVGER.GER_VALS05 * (SERMOV.GER_DECS05 / 100))) AS GER_VALS05, ';
            strSQL := strSQL + ' (MOVGER.GER_VALS06 - (MOVGER.GER_VALS06 * (SERMOV.GER_DECS06 / 100))) AS GER_VALS06, ';
          End;
        End
        Else
        Begin
          strSQL := strSQL + '  MOVGER.GER_VALS01, ';
          strSQL := strSQL + '  MOVGER.GER_VALS02, ';
          strSQL := strSQL + '  MOVGER.GER_VALS03, ';
          strSQL := strSQL + '  MOVGER.GER_VALS04, ';
          strSQL := strSQL + '  MOVGER.GER_VALS05, ';
          strSQL := strSQL + '  MOVGER.GER_VALS06, ';
        End;
      end
      else
      begin
        strSQL := strSQL + '  0.00 AS GER_VALS01, ';
        strSQL := strSQL + '  0.00 AS GER_VALS02, ';
        strSQL := strSQL + '  0.00 AS GER_VALS03, ';
        strSQL := strSQL + '  0.00 AS GER_VALS04, ';
        strSQL := strSQL + '  0.00 AS GER_VALS05, ';
        strSQL := strSQL + '  0.00 AS GER_VALS06, ';
      end;

      // Se existe os serviços 07, 08, 09 e 10
      If fTabelaExiste('SERMOV') And fCampoExiste('SERMOV', 'GER_VALS07') Then
      Begin
        If fCampoExiste('SERMOV','GER_DECS07') Then
        Begin
          If fCampoExiste('SERMOV','GER_IDES07') Then
          Begin
            strSQL := strSQL + ' IF(SERMOV.GER_IDES07 = "I", 0.00, (SERMOV.GER_VALS07 - (SERMOV.GER_VALS07 * (SERMOV.GER_DECS07 / 100)))) AS GER_VALS07, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES08 = "I", 0.00, (SERMOV.GER_VALS08 - (SERMOV.GER_VALS08 * (SERMOV.GER_DECS08 / 100)))) AS GER_VALS08, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES09 = "I", 0.00, (SERMOV.GER_VALS09 - (SERMOV.GER_VALS09 * (SERMOV.GER_DECS09 / 100)))) AS GER_VALS09, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES10 = "I", 0.00, (SERMOV.GER_VALS10 - (SERMOV.GER_VALS10 * (SERMOV.GER_DECS10 / 100)))) AS GER_VALS10, ';
          End
          Else
          Begin
            strSQL := strSQL + ' (SERMOV.GER_VALS07 - (SERMOV.GER_VALS07 * (SERMOV.GER_DECS07 / 100))) AS GER_VALS07, ';
            strSQL := strSQL + ' (SERMOV.GER_VALS08 - (SERMOV.GER_VALS08 * (SERMOV.GER_DECS08 / 100))) AS GER_VALS08, ';
            strSQL := strSQL + ' (SERMOV.GER_VALS09 - (SERMOV.GER_VALS09 * (SERMOV.GER_DECS09 / 100))) AS GER_VALS09, ';
            strSQL := strSQL + ' (SERMOV.GER_VALS10 - (SERMOV.GER_VALS10 * (SERMOV.GER_DECS10 / 100))) AS GER_VALS10, ';
          End;
        End
        Else
        Begin
          strSQL := strSQL + '  SERMOV.GER_VALS07, ';
          strSQL := strSQL + '  SERMOV.GER_VALS08, ';
          strSQL := strSQL + '  SERMOV.GER_VALS09, ';
          strSQL := strSQL + '  SERMOV.GER_VALS10, ';
        End;
      End;

      If fTabelaExiste('SERMOV') And fCampoExiste('SERMOV', 'GER_IDES11') Then
      Begin
        If fCampoExiste('SERMOV','GER_IDES11') Then
        Begin
          If fCampoExiste('SERMOV','GER_IDES11') Then
          Begin
            strSQL := strSQL + ' IF(SERMOV.GER_IDES11 = "I", 0.00, (SERMOV.GER_VALS11 - (SERMOV.GER_VALS11 * (SERMOV.GER_DECS11 / 100)))) AS GER_VALS11, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES12 = "I", 0.00, (SERMOV.GER_VALS12 - (SERMOV.GER_VALS12 * (SERMOV.GER_DECS12 / 100)))) AS GER_VALS12, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES13 = "I", 0.00, (SERMOV.GER_VALS13 - (SERMOV.GER_VALS13 * (SERMOV.GER_DECS13 / 100)))) AS GER_VALS13, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES14 = "I", 0.00, (SERMOV.GER_VALS14 - (SERMOV.GER_VALS14 * (SERMOV.GER_DECS14 / 100)))) AS GER_VALS14, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES15 = "I", 0.00, (SERMOV.GER_VALS15 - (SERMOV.GER_VALS15 * (SERMOV.GER_DECS15 / 100)))) AS GER_VALS15, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES16 = "I", 0.00, (SERMOV.GER_VALS16 - (SERMOV.GER_VALS16 * (SERMOV.GER_DECS16 / 100)))) AS GER_VALS16, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES17 = "I", 0.00, (SERMOV.GER_VALS17 - (SERMOV.GER_VALS17 * (SERMOV.GER_DECS17 / 100)))) AS GER_VALS17, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES18 = "I", 0.00, (SERMOV.GER_VALS18 - (SERMOV.GER_VALS18 * (SERMOV.GER_DECS18 / 100)))) AS GER_VALS18, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES19 = "I", 0.00, (SERMOV.GER_VALS19 - (SERMOV.GER_VALS19 * (SERMOV.GER_DECS19 / 100)))) AS GER_VALS19, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES20 = "I", 0.00, (SERMOV.GER_VALS20 - (SERMOV.GER_VALS20 * (SERMOV.GER_DECS20 / 100)))) AS GER_VALS20, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES21 = "I", 0.00, (SERMOV.GER_VALS21 - (SERMOV.GER_VALS21 * (SERMOV.GER_DECS21 / 100)))) AS GER_VALS21, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES22 = "I", 0.00, (SERMOV.GER_VALS22 - (SERMOV.GER_VALS22 * (SERMOV.GER_DECS22 / 100)))) AS GER_VALS22, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES23 = "I", 0.00, (SERMOV.GER_VALS23 - (SERMOV.GER_VALS23 * (SERMOV.GER_DECS23 / 100)))) AS GER_VALS23, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES24 = "I", 0.00, (SERMOV.GER_VALS24 - (SERMOV.GER_VALS24 * (SERMOV.GER_DECS24 / 100)))) AS GER_VALS24, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES25 = "I", 0.00, (SERMOV.GER_VALS25 - (SERMOV.GER_VALS25 * (SERMOV.GER_DECS25 / 100)))) AS GER_VALS25, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES26 = "I", 0.00, (SERMOV.GER_VALS26 - (SERMOV.GER_VALS26 * (SERMOV.GER_DECS26 / 100)))) AS GER_VALS26, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES27 = "I", 0.00, (SERMOV.GER_VALS27 - (SERMOV.GER_VALS27 * (SERMOV.GER_DECS27 / 100)))) AS GER_VALS27, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES28 = "I", 0.00, (SERMOV.GER_VALS28 - (SERMOV.GER_VALS28 * (SERMOV.GER_DECS28 / 100)))) AS GER_VALS28, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES29 = "I", 0.00, (SERMOV.GER_VALS29 - (SERMOV.GER_VALS29 * (SERMOV.GER_DECS29 / 100)))) AS GER_VALS29, ';
            strSQL := strSQL + ' IF(SERMOV.GER_IDES30 = "I", 0.00, (SERMOV.GER_VALS30 - (SERMOV.GER_VALS30 * (SERMOV.GER_DECS30 / 100)))) AS GER_VALS30, ';
          End
          Else
          Begin
            strSQL := strSQL + ' (SERMOV.GER_VALS11 - (SERMOV.GER_VALS11 * (SERMOV.GER_DECS11 / 100))) AS GER_VALS11, ';
            strSQL := strSQL + ' (SERMOV.GER_VALS12 - (SERMOV.GER_VALS12 * (SERMOV.GER_DECS12 / 100))) AS GER_VALS12, ';
            strSQL := strSQL + ' (SERMOV.GER_VALS13 - (SERMOV.GER_VALS13 * (SERMOV.GER_DECS13 / 100))) AS GER_VALS13, ';
            strSQL := strSQL + ' (SERMOV.GER_VALS14 - (SERMOV.GER_VALS14 * (SERMOV.GER_DECS14 / 100))) AS GER_VALS14, ';
            strSQL := strSQL + ' (SERMOV.GER_VALS15 - (SERMOV.GER_VALS15 * (SERMOV.GER_DECS15 / 100))) AS GER_VALS15, ';
            strSQL := strSQL + ' (SERMOV.GER_VALS16 - (SERMOV.GER_VALS16 * (SERMOV.GER_DECS16 / 100))) AS GER_VALS16, ';
            strSQL := strSQL + ' (SERMOV.GER_VALS17 - (SERMOV.GER_VALS17 * (SERMOV.GER_DECS17 / 100))) AS GER_VALS17, ';
            strSQL := strSQL + ' (SERMOV.GER_VALS18 - (SERMOV.GER_VALS18 * (SERMOV.GER_DECS18 / 100))) AS GER_VALS18, ';
            strSQL := strSQL + ' (SERMOV.GER_VALS19 - (SERMOV.GER_VALS19 * (SERMOV.GER_DECS19 / 100))) AS GER_VALS19, ';
            strSQL := strSQL + ' (SERMOV.GER_VALS20 - (SERMOV.GER_VALS20 * (SERMOV.GER_DECS20 / 100))) AS GER_VALS20, ';
            strSQL := strSQL + ' (SERMOV.GER_VALS21 - (SERMOV.GER_VALS21 * (SERMOV.GER_DECS21 / 100))) AS GER_VALS21, ';
            strSQL := strSQL + ' (SERMOV.GER_VALS22 - (SERMOV.GER_VALS22 * (SERMOV.GER_DECS22 / 100))) AS GER_VALS22, ';
            strSQL := strSQL + ' (SERMOV.GER_VALS23 - (SERMOV.GER_VALS23 * (SERMOV.GER_DECS23 / 100))) AS GER_VALS23, ';
            strSQL := strSQL + ' (SERMOV.GER_VALS24 - (SERMOV.GER_VALS24 * (SERMOV.GER_DECS24 / 100))) AS GER_VALS24, ';
            strSQL := strSQL + ' (SERMOV.GER_VALS25 - (SERMOV.GER_VALS25 * (SERMOV.GER_DECS25 / 100))) AS GER_VALS25, ';
            strSQL := strSQL + ' (SERMOV.GER_VALS26 - (SERMOV.GER_VALS26 * (SERMOV.GER_DECS26 / 100))) AS GER_VALS26, ';
            strSQL := strSQL + ' (SERMOV.GER_VALS27 - (SERMOV.GER_VALS27 * (SERMOV.GER_DECS27 / 100))) AS GER_VALS27, ';
            strSQL := strSQL + ' (SERMOV.GER_VALS28 - (SERMOV.GER_VALS28 * (SERMOV.GER_DECS28 / 100))) AS GER_VALS28, ';
            strSQL := strSQL + ' (SERMOV.GER_VALS29 - (SERMOV.GER_VALS29 * (SERMOV.GER_DECS29 / 100))) AS GER_VALS29, ';
            strSQL := strSQL + ' (SERMOV.GER_VALS30 - (SERMOV.GER_VALS30 * (SERMOV.GER_DECS30 / 100))) AS GER_VALS30, ';
          End;
        End
        Else
        Begin
          strSQL := strSQL + '  SERMOV.GER_VALS11, ';
          strSQL := strSQL + '  SERMOV.GER_VALS12, ';
          strSQL := strSQL + '  SERMOV.GER_VALS13, ';
          strSQL := strSQL + '  SERMOV.GER_VALS14, ';
          strSQL := strSQL + '  SERMOV.GER_VALS15, ';
          strSQL := strSQL + '  SERMOV.GER_VALS16, ';
          strSQL := strSQL + '  SERMOV.GER_VALS17, ';
          strSQL := strSQL + '  SERMOV.GER_VALS18, ';
          strSQL := strSQL + '  SERMOV.GER_VALS19, ';
          strSQL := strSQL + '  SERMOV.GER_VALS20, ';
          strSQL := strSQL + '  SERMOV.GER_VALS21, ';
          strSQL := strSQL + '  SERMOV.GER_VALS22, ';
          strSQL := strSQL + '  SERMOV.GER_VALS23, ';
          strSQL := strSQL + '  SERMOV.GER_VALS24, ';
          strSQL := strSQL + '  SERMOV.GER_VALS25, ';
          strSQL := strSQL + '  SERMOV.GER_VALS26, ';
          strSQL := strSQL + '  SERMOV.GER_VALS27, ';
          strSQL := strSQL + '  SERMOV.GER_VALS28, ';
          strSQL := strSQL + '  SERMOV.GER_VALS29, ';
          strSQL := strSQL + '  SERMOV.GER_VALS30, ';
        End;
      End;

      If fTabelaExiste('SERMOV') And fCampoExiste('SERMOV', 'GER_SEROBS') Then
        strSQL := strSQL + ' IFNULL(SERMOV.GER_SEROBS,"") AS GER_SEROBS, '
      Else
        strSQL := strSQL + ' "" AS GER_SEROBS, ';

      If fTabelaExiste('MOVOBS') And fCampoExiste('MOVOBS', 'MOV_DISSER') Then
        strSQL := strSQL + ' IFNULL(MOVOBS.MOV_DISSER,"") AS GER_DISSER, '
      Else
        strSQL := strSQL + ' " " AS GER_DISSER, ';

      If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_DUPREC') Then
        strSQL := strSQL + '  AUX_DUPREC AS GER_DUPREC,'
      Else
        strSQL := strSQL + '  0.00 AS GER_DUPREC,';

      If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_CODOBR') Then
      Begin
        strSQL := strSQL + '  AUX_CODOBR, ';
        strSQL := strSQL + '  AUX_CODART, ';
        strSQL := strSQL + '  ETC_CIDENT, ';
        strSQL := strSQL + '  ETC_ENDENT, ';
        strSQL := strSQL + '  ETC_BAIENT, ';
        strSQL := strSQL + '  ETC_CEPENT, ';
        strSQL := strSQL + '  ETC_TELENT, ';
        strSQL := strSQL + '  ETC_CONENT, ';
        strSQL := strSQL + '  ETC_REFENT, ';
      End
      Else
      Begin
        strSQL := strSQL + '  "" AS AUX_CODOBR, ';
        strSQL := strSQL + '  "" AS AUX_CODART, ';
        strSQL := strSQL + '  "" AS ETC_CIDENT, ';
        strSQL := strSQL + '  "" AS ETC_ENDENT, ';
        strSQL := strSQL + '  "" AS ETC_BAIENT, ';
        strSQL := strSQL + '  "" AS ETC_CEPENT, ';
        strSQL := strSQL + '  "" AS ETC_TELENT, ';
        strSQL := strSQL + '  "" AS ETC_CONENT, ';
        strSQL := strSQL + '  "" AS ETC_REFENT, ';
      End;

      If fCampoExiste('MOVTRI', 'DET_SEQCCR') Then
        strSQL := strSQL + '  DET_SEQCCR, '
      Else
        strSQL := strSQL + '  "" AS DET_SEQCCR,  ';

      if blnTrSeCi And fTabelaExiste('TRISER') then
        strSQL := strSQL + '  TSE_CDLSSE AS SER_CDLSSE, '
      Else
      If fCampoExiste('CADSER', 'SER_CDLSSE') Then
        strSQL := strSQL + '  SER_CDLSSE, '
      Else
        strSQL := strSQL + ' "" AS SER_CDLSSE, ';

      if blnTrSeCi And fTabelaExiste('TRISER') then
        strSQL := strSQL + '  TSE_TRIMUN AS SER_TRIMUN, '
      Else
      If fCampoExiste('CADSER', 'SER_TRIMUN') Then
        strSQL := strSQL + '  SER_TRIMUN, '
      Else
        strSQL := strSQL + '  REPEAT(" ", 20) AS SER_TRIMUN,  ';

      strSQL := strSQL + '  DET_NUM_PD, ';
      strSQL := strSQL + '  DET_ESP_PD, ';
      strSQL := strSQL + '  DET_EMP_PD, ';
      strSQL := strSQL + '  DET_IND_PD, ';

      If (fConfiguracao('IMPDIR') = 'S') And fCampoExiste('CADITE', 'ITE_IMPDIR') Then
      Begin
        If (fConfiguracao('IMPDIG') = '2') Then
          strSQL := strSQL + '  ITEGER.ITE_IMPDIR, '
        Else
          strSQL := strSQL + '  CADITE.ITE_IMPDIR, ';
      End
      Else
        strSQL := strSQL + '  "N" AS ITE_IMPDIR, ';

      If ((fConfiguracao('VENMAD') = 'S') Or
          (fConfiguracao('VENVID') = 'S') Or
          (fConfiguracao('VENMTL') = 'S')) And
           fTabelaExiste('MOVMAD') Then
      Begin
        strSQL := strSQL + '  DET_QTDPEC, ';
        strSQL := strSQL + '  DET_COMPEC, ';
        strSQL := strSQL + '  DET_LARPEC, ';
        strSQL := strSQL + '  DET_ESPPEC, ';
        strSQL := strSQL + '  DET_APAREL, ';
        strSQL := strSQL + '  DET_BENEFI, ';
        strSQL := strSQL + '  DET_PERAPA, ';
        strSQL := strSQL + '  DET_PERBEN, ';
        strSQL := strSQL + '  if( (DET_QTDPEC > 0) AND (DET_TOTITE > 0), (DET_TOTITE / DET_QTDPEC), 0) AS DET_VLUNPC, ';
      End;

      If fCampoExiste('CADITE', 'ITE_CODLUB') Then
      Begin
        strSQL := strSQL + '  CADITE.ITE_CODLUB, ';
      End
      Else
      Begin
        strSQL := strSQL + '  "" AS ITE_CODLUB, ';
      End;

      If fCampoExiste('CADITE', 'ITE_DESANP') Then
        strSQL := strSQL + '  CADITE.ITE_DESANP, '
      Else
        strSQL := strSQL + '  "" AS ITE_DESANP, ';

      If fCampoExiste('CADITE', 'ITE_NUMFCI') Then
      Begin
        strSQL := strSQL + '  CADITE.ITE_NUMFCI, ';
      End
      Else
      Begin
        strSQL := strSQL + '  "" AS ITE_NUMFCI, ';
      End;

      If objConfig.blnClaOnu Then
      Begin
        strSQL := strSQL + '  ONU_CODONU, ';
        strSQL := strSQL + '  ONU_DESCRI, ';

        If fCampoExiste('CADONU', 'ONU_CODIGO') Then
          strSQL := strSQL + '  ONU_CODIGO, '
        Else
          strSQL := strSQL + '  "" AS ONU_CODIGO, ';

        If fCampoExiste('CADONU', 'ONU_CLARIS') Then
          strSQL := strSQL + '  ONU_CLARIS, '
        Else
          strSQL := strSQL + '  "" AS ONU_CLARIS, ';

        If fCampoExiste('CADONU', 'ONU_GRUEMB') Then
          strSQL := strSQL + '  ONU_GRUEMB, '
        Else
          strSQL := strSQL + '  "" AS ONU_GRUEMB, ';
      End
      Else
      Begin
        strSQL := strSQL + '  "" AS ONU_CODONU, ';
        strSQL := strSQL + '  "" AS ONU_DESCRI, ';
        strSQL := strSQL + '  "" AS ONU_CODIGO, ';
        strSQL := strSQL + '  "" AS ONU_CLARIS, ';
        strSQL := strSQL + '  "" AS ONU_GRUEMB, ';
      End;

      strSQL := strSQL + '  MOVDET.DET_TOTPES, ';
      strSQL := strSQL + '  MOVDET.DET_FORITE, ';

      If fCampoExiste('MOVTRI', 'DET_COICMP') And fCampoExiste('NOTTRI', 'DET_COICMP') Then //CAMPO CRIADO REQ.: 38461 MAS O REQUISITO FOI "PERDIDO" NA VIRADA 48.02.DESEN > 48.02.30
        strSQL := strSQL + '  MOVTRI.DET_COICMP, '                                          //MANTIDO AQUI SOMENTE POR QUESTÃO DE COMPATIBILIDADE
      Else
        strSQL := strSQL + '  "" AS DET_COICMP, ';

      If fCampoExiste('MOVTRI', 'DET_NUMCMP') Then
        strSQL := strSQL + '  MOVTRI.DET_NUMCMP, '
      Else
        strSQL := strSQL + '  "" AS DET_NUMCMP, ';

      If fCampoExiste('MOVTRI', 'DET_NITCMP') Then
        strSQL := strSQL + '  MOVTRI.DET_NITCMP, '
      Else
        strSQL := strSQL + '  0  AS DET_NITCMP, ';

      //Quando nao existir o campo enviar em branco
      If fCampoExiste('MOVTRI', 'DET_RICMPR') Then
        strSQL := strSQL + '  MOVTRI.DET_RICMPR, '
      Else
        strSQL := strSQL + '  "" AS DET_RICMPR, ';

      strSQL := strSQL + '  MOVDET.DET_TMPGAR, ';

      If fCampoExiste('CADITE', 'ITE_INFGAR') Then
        strSQL := strSQL + '  CADITE.ITE_INFGAR, '
      Else
        strSQL := strSQL + '  "" AS ITE_INFGAR, ';

      If fCampoExiste('MOVGER', 'GER_ICMORG') Then
        strSQL := strSQL + ' ' + strIcmOrg + ', '
      Else
        strSQL := strSQL + ' 0.00 AS GER_ICMORG, ';

      If fCampoExiste('AUXMOV', 'AUX_VRDICM') Then
        strSQL := strSQL + ' ' + strVrdIcm + ', '
      Else
        strSQL := strSQL + ' 0.00 AS AUX_VRDICM, ';

      strSQL := strSQL + '  FGO_NUMCMP, ';
      strSQL := strSQL + '  FGO_NUMPOK, ';
      strSQL := strSQL + '  FGO_PEDSIT, ';

      If fCampoExiste('FATGOR', 'FGO_ORIGEM') Then
        strSQL := strSQL + '  FGO_ORIGEM, '
      else
        strSQL := strSQL + '  "AUTCOM" AS FGO_ORIGEM, ';

      strSQL := strSQL + '  ABF_PEIMPG, ';

      If fCampoExiste('MOVTRI', 'DET_IMPPAG') Then
        strSQL := strSQL + '  MOVTRI.DET_IMPPAG, ';

      If fCampoExiste('MOVTRI', 'DET_FEDIMP') Then
        strSQL := strSQL + '  MOVTRI.DET_FEDIMP, ';

      If fCampoExiste('MOVTRI', 'DET_ESTIMP') Then
        strSQL := strSQL + '  MOVTRI.DET_ESTIMP, ';

      If fCampoExiste('MOVTRI', 'DET_MUNIMP') Then
        strSQL := strSQL + '  MOVTRI.DET_MUNIMP, ';

      If fCampoExiste('MOVTRI', 'DET_ICMORG') Then
        strSQL := strSQL + '  MOVTRI.DET_ICMORG, ';

      If fCampoExiste('MOVTRI', 'DET_VRDICM') Then
        strSQL := strSQL + '  MOVTRI.DET_VRDICM, '
      Else
        strSQL := strSQL + '  0.00 AS DET_VRDICM, ';

      If fCampoExiste('MOVTRI', 'DET_MTDICM') Then
        strSQL := strSQL + '  MOVTRI.DET_MTDICM, '
      Else
        strSQL := strSQL + '  "" AS DET_MTDICM, ';

      If fCampoExiste('MOVTRI', 'DET_ICMORG') Then
        strSQL := strSQL + '  MOVTRI.DET_ICMORG, ';

      If fCampoExiste('MOVDET', 'DET_DOCDEV') Then
      Begin
        strSQL := strSQL + '  MOVDET.DET_DOCDEV, ';
        strSQL := strSQL + '  MOVDET.DET_ESPDEV, ';
        strSQL := strSQL + '  MOVDET.DET_EMPDEV, ';

        If fCampoExiste('MOVDET', 'DET_SERDEV') Then
          strSQL := strSQL + '  MOVDET.DET_SERDEV, ';
      End
      Else
      Begin
        strSQL := strSQL + ' " " AS MOVDET.DET_DOCDEV, ';
        strSQL := strSQL + ' " " AS MOVDET.DET_ESPDEV, ';
        strSQL := strSQL + ' " " AS MOVDET.DET_EMPDEV, ';

        If fCampoExiste('MOVDET', 'DET_SERDEV') Then
          strSQL := strSQL + ' " " AS MOVDET.DET_SERDEV, ';
      End;

      If fCampoExiste('CADITE', 'ITE_CDCEST') Then
      Begin
        strSQL := strSQL + '  CADITE.ITE_CDCEST, ';
      End
      Else If fConfiguracao('CESTPD') <> '' Then
      Begin
        strSQL := strSQL + ' ' + fConfiguracao('CESTPD') + ' AS ITE_CDCEST, ';
      End
      Else Begin
        strSQL := strSQL + '  "" AS ITE_CDCEST, ';
      End;

      pAdicionaCampoCadIte('ITE_INDESC', '"S"');
      pAdicionaCampoCadIte('ITE_CNPFME', '" "');
      pAdicionaCampoCadIte('ITE_CDBFIS', '" "');
      pAdicionaCampoCadIte('ITE_ENIECB', '"N"');

      If fTabelaExiste('MOVICD') Then
      Begin
        strSQL := strSQL + '  ICD_SEQGER, ';
        strSQL := strSQL + '  ICD_BCUFDE, ';
        strSQL := strSQL + '  ICD_PERFCP, ';
        strSQL := strSQL + '  ICD_ALQUFD, ';
        strSQL := strSQL + '  ICD_ALQINE, ';
        strSQL := strSQL + '  ICD_PERPAR, ';
        strSQL := strSQL + '  ICD_VALFCP, ';
        strSQL := strSQL + '  ICD_VALDES, ';
        strSQL := strSQL + '  ICD_VALORI, ';

        If fCampoExiste('MOVICD', 'ICD_BASFCP') Then
          strSQL := strSQL + '  ICD_BASFCP, '
        Else
          strSQL := strSQL + ' ICD_BCUFDE AS ICD_BASFCP, ';
      End;

      If fTabelaExiste('AUXMOV') And (fCampoExiste('AUXMOV', 'AUX_VENPRE')) Then
        strSQL := strSQL + '  AUX_VENPRE, ';

      If (fCampoExiste('MOVGER', 'GER_ENTFAT')) Then
        strSQL := strSQL + '     GER_ENTFAT, '
      Else
        strSQL := strSQL + ' "N" GER_ENTFAT, ';

      If blnNSRBru Then
        strSQL := strSQL + '     EMP_NSRBRU, '
      Else
        strSQL := strSQL + '  -1 EMP_NSRBRU, ';

      If fTabelaExiste('DOCEXP') And (fCampoExiste('DOCEXP', 'EXP_UFEMBA')) Then
      Begin
        strSQL := strSQL + '  DOCEXP.EXP_UFEMBA, ';
        strSQL := strSQL + '  DOCEXP.EXP_LOEMBA, ';
        strSQL := strSQL + '  DOCEXP.EXP_LOCDES ';
      End
      Else
      Begin
        strSQL := strSQL + ' " " AS EXP_UFEMBA, ';
        strSQL := strSQL + ' " " AS EXP_LOEMBA, ';
        strSQL := strSQL + ' " " AS EXP_LOCDES ';
      End;

      strSQL := strSQL + ' ,CAST((SELECT IF(COUNT(*) > 0, "S", "N") FROM CADEMP WHERE EMP_CLIFIL = MOVGER.GER_CODCLI LIMIT 1) AS CHAR(1)) AS GER_CLIFIL ';
      strSQL := strSQL + ' ,CAST((SELECT CND_DESCRI FROM CADCND WHERE CND_CODIGO = MOVGER.GER_CODCND LIMIT 1) AS CHAR(70)) AS CND_DESCRI ';
      If (FEspDoc = 'IF') Then
      Begin
        strSQL := strSQL + ' ,CAST("" AS CHAR(1)) AS GER_LISPED ';
      End
      Else
      Begin
        strSQL := strSQL + ' ,CAST((SELECT GROUP_CONCAT(DISTINCT FDO_NUMDOC)         ';
        strSQL := strSQL + '          FROM FATDOR                                    ';
        strSQL := strSQL + '         WHERE FATDOR.FDO_NUMFAT = :NUMDOC               ';
        strSQL := strSQL + '           AND FATDOR.FDO_EMPFAT = :CODEMP               ';
        strSQL := strSQL + '           AND FATDOR.FDO_TIPFAT = :ESPDOC               ';
        If fCampoExiste('FATDOR', 'FDO_SERFAT') Then
          strSQL := strSQL + '         AND FATDOR.FDO_SERFAT = :SERIE_               ';
        strSQL := strSQL + '        ORDER BY FDO_NUMDOC) AS CHAR(255)) AS GER_LISPED ';
      End;

      If fTabelaExiste('REFFIS') Then
      Begin
        strSQL := strSQL + ' ,CAST((SELECT IF(COUNT(*)>0, "S", "N") ';
        strSQL := strSQL + '          FROM REFFIS ';
        strSQL := strSQL + '         WHERE REFFIS.FIS_SEQFIS = CADFIS.AUTOINCREM LIMIT 1) AS CHAR(1)) AS GER_REFFIS ';
      End
      Else
      Begin
        strSQL := strSQL + ' ,CAST("N" AS CHAR(1)) AS GER_REFFIS ';
      End;

      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + strCadFis;

      strSQL := strSQL + 'LEFT JOIN MOVGER ON MOVGER.GER_NUMDOC = FIS_NUMDOC AND ';
      strSQL := strSQL + '                    MOVGER.GER_ESPDOC = FIS_ESPDOC AND ';
      strSQL := strSQL + '                    MOVGER.GER_SERIE_ = FIS_SERIE_ AND ';
      strSQL := strSQL + '                    MOVGER.GER_CODEMP = FIS_CODEMP AND ';
      strSQL := strSQL + '                    MOVGER.GER_TIP_FC = FIS_TIP_FC AND ';
      strSQL := strSQL + '                    IF(FIS_TIP_FC="C", MOVGER.GER_CODCLI, MOVGER.GER_CODFOR) = FIS_FORCLI ';

      If fTabelaExiste('SERMOV') Then
        strSQL := strSQL + 'LEFT JOIN SERMOV ON SERMOV.GER_SEQGER = MOVGER.AUTOINCREM ';

      strSQL := strSQL + 'LEFT JOIN MOVDET ON DET_NUMDOC = MOVGER.GER_NUMDOC AND ';
      strSQL := strSQL + '                    DET_ESPDOC = MOVGER.GER_ESPDOC AND ';
      strSQL := strSQL + '                    DET_SERIE_ = MOVGER.GER_SERIE_ AND ';
      strSQL := strSQL + '                    DET_CODEMP = MOVGER.GER_CODEMP AND ';
      strSQL := strSQL + '                    DET_TIP_FC = MOVGER.GER_TIP_FC AND ';
      strSQL := strSQL + '                    IF(FIS_TIP_FC="C", DET_CODCLI, DET_CODFOR) = IF(FIS_TIP_FC="C", MOVGER.GER_CODCLI, MOVGER.GER_CODFOR) ';

      strSQL := strSQL + 'LEFT JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM ';

      if fCampoExiste('MOVGER', 'GER_CODS01') then
        strSQL := strSQL + 'LEFT JOIN CADSER ON CADSER.SER_CODSER = MOVGER.GER_CODS01 '
      else
        strSQL := strSQL + 'LEFT JOIN CADSER ON CADSER.SER_CODSER = "" ';

      if blnTrSeCi And fTabelaExiste('TRISER') then
      begin
        strSQL := strSQL + 'INNER JOIN CADEMP ON CADEMP.EMP_CODEMP = CADFIS.FIS_CODEMP ';
        strSQL := strSQL + 'LEFT  JOIN TRISER ON TSE_CODSER = CADSER.SER_CODSER AND TSE_CODCID = EMP_CODCID ';
      End
      Else If blnNSRBru Then
      Begin
        strSQL := strSQL + 'INNER JOIN CADEMP ON CADEMP.EMP_CODEMP = CADFIS.FIS_CODEMP ';
      End;

      strSQL := strSQL + 'LEFT JOIN CADITE ON CADITE.ITE_CODITE = DET_CODITE ';

      strSQL := strSQL + 'LEFT JOIN ITEGER ON ITEGER.ITE_CODITE = DET_CODITE AND ';
      strSQL := strSQL + '                    ITEGER.ITE_CODEMP = DET_CODEMP ';

      if fCampoExiste('MOVDET', 'DET_ITEEMB') then
        strSQL := strSQL + 'LEFT JOIN CADITE ITEEMB ON ITEEMB.ITE_CODITE = DET_ITEEMB ';

      If fCampoExiste('MOVTRI', 'DET_ITEABF') Then
        strSQL := strSQL + 'LEFT JOIN CADITE ITEABF ON ITEABF.ITE_CODITE = DET_ITEABF '
      Else
        strSQL := strSQL + 'LEFT JOIN CADITE ITEABF ON ITEABF.ITE_CODITE = DET_CODITE ';

      If fTabelaExiste('CADLOT') Then
      Begin
        strSQL := strSQL + 'LEFT JOIN CADLOT ON DET_NUMLOT = LOT_NUMLOT AND ';
        strSQL := strSQL + '                    DET_CODITE = LOT_CODITE AND ';
        strSQL := strSQL + '                    DET_CODEMP = LOT_CODEMP     ';
      End;

      strSQL := strSQL + 'LEFT JOIN NOTCOM ON NOTCOM.GER_SEQGER = CADFIS.AUTOINCREM ';
      strSQL := strSQL + 'LEFT JOIN CLICON ON CLICON.CON_C_P_F_ = ' + IIF(blnCliConNC, 'NOTCOM.GER_CPFCON', 'NULL') + ' ';

      strSQL := strSQL + 'LEFT JOIN CADTRA ON MOVGER.GER_CODTRA = CADTRA.TRA_CODTRA ';
      strSQL := strSQL + 'LEFT JOIN CADCID AS CIDTRA ON CIDTRA.CID_CODCID = TRA_CODCID ';

      strSQL := strSQL + 'LEFT JOIN CADCLI CL ON CL.CLI_CODCLI = FIS_FORCLI AND FIS_TIP_FC="C" ';
      strSQL := strSQL + 'LEFT JOIN CADFOR ON FOR_CODFOR = FIS_FORCLI AND FIS_TIP_FC="F" ';

      If fTabelaExiste('AUXMOV') Then
      Begin
        strSQL := strSQL + 'LEFT JOIN AUXMOV ON AUXMOV.AUX_SEQGER = MOVGER.AUTOINCREM ';
        strSQL := strSQL + 'LEFT JOIN ENTCLI ON AUXMOV.AUX_ENTGER = ENTCLI.AUTOINCREM AND ENTCLI.ETC_CODCLI = CL.CLI_CODCLI ';

        If blnCadFaz Then
          strSQL := strSQL + 'LEFT JOIN CADFAZ ON CADFAZ.FAZ_CODFAZ = IFNULL(NOTCOM.GER_CODFAZ, AUXMOV.AUX_CODFAZ) ';

        strSQL := strSQL + strWhereTraRed_;
      End;

      strSQL := strSQL + 'LEFT JOIN CADCID CC ON CC.CID_CODCID = IF(' + STR_CLIENTE_CONSUMIDOR + ', ' + fConsumid('GER_CIDCON', 'CON_CODCID') + ', ' + fFazenda('CLI_CODCID', 'FAZ_CODCID') + ') ';
      strSQL := strSQL + 'LEFT JOIN CADCID CF ON CF.CID_CODCID = FOR_CODCID ';

      strSQL := strSQL + 'LEFT JOIN CADUNI AS UV ON UV.UNI_CODUNI = DET_UNIDAD ';

      If (fConfiguracao('UNITRI') = 'S') Then
        strSQL := strSQL + '  LEFT  JOIN CADUNI AS UT ON UT.UNI_CODUNI = CADITE.ITE_UNITRI ';

      strSQL := strSQL + 'LEFT JOIN CADMAR ON MAR_CODMAR = DET_CODMAR ';

      If fConfiguracao('TIPABF') = '1' Then
      Begin
        If fCampoExiste('ABFICM', 'ABF_CSTORI') Then
          strSQL := strSQL + 'LEFT JOIN ' + strTabAbf + ' ON ABF_CODABF = CADITE.ITE_CODABF AND ABF_CSTORI = CADITE.ITE_CSTORI AND '
        Else
          strSQL := strSQL + 'LEFT JOIN ' + strTabAbf + ' ON ABF_CODABF = CADITE.ITE_CODABF AND '
      End
      Else
      Begin
        If fCampoExiste('ABFICM', 'ABF_CSTORI') then
          strSQL := strSQL + 'LEFT JOIN ' + strTabAbf + ' ON ABF_CODABF = ITEGER.ITE_CODABF AND ABF_CSTORI = ITEGER.ITE_CSTORI AND '
        Else
          strSQL := strSQL + 'LEFT JOIN ' + strTabAbf + ' ON ABF_CODABF = ITEGER.ITE_CODABF AND ';
      End;


      strSQL := strSQL + '                    ABF_ESTADO = MOVGER.GER_ESTADO ';

      If Not fCampoExiste('NATCFO', 'NAT_DESCRI') Then
      Begin
        strSQL := strSQL + 'LEFT JOIN CADCFO C1 ON C1.CFO_CODCFO = FIS_CLFSC1 ';
        strSQL := strSQL + 'LEFT JOIN CADCFO C2 ON C2.CFO_CODCFO = FIS_CLFSC2 ';
        strSQL := strSQL + 'LEFT JOIN CADCFO C3 ON C3.CFO_CODCFO = FIS_CLFSC3 ';
        strSQL := strSQL + 'LEFT JOIN CADCFO C4 ON C4.CFO_CODCFO = FIS_CLFSC4 ';
      End;

      strSQL := strSQL + 'LEFT JOIN CADOPE VE ON VE.OPE_CODOPE = MOVGER.GER_CODVEN ';
      strSQL := strSQL + 'LEFT JOIN CADOPE DI ON DI.OPE_CODOPE = MOVGER.GER_CODDIG ';

      strSQL := strSQL + 'LEFT JOIN MOVOBS ON MOV_SEQGER = MOVGER.AUTOINCREM ';

      strSQL := strSQL + 'LEFT JOIN CLIPRO P ON P.CLI_CODITE = DET_CODITE AND ';
      strSQL := strSQL + '                      P.CLI_CODCLI = DET_CODCLI ';

      strSQL := strSQL + 'LEFT JOIN FATGOR ON DET_NUM_PD = FGO_NUMDOC AND ';
      strSQL := strSQL + '                    DET_ESP_PD = FGO_ESPDOC AND ';
      strSQL := strSQL + '                    DET_EMP_PD = FGO_CODEMP AND ';
      strSQL := strSQL + '                    DET_CODCLI = FGO_CODCLI     ';

      If ((fConfiguracao('VENMAD') = 'S') Or
          (fConfiguracao('VENVID') = 'S') Or
          (fConfiguracao('VENMTL') = 'S')) And
           fTabelaExiste('MOVMAD') Then
        strSQL := strSQL + 'LEFT JOIN MOVMAD ON MOVMAD.DET_SEQGER = MOVDET.AUTOINCREM ';

      If objConfig.blnClaOnu Then
        strSQL := strSQL + 'LEFT JOIN CADONU ON CADITE.ITE_CODONU = CADONU.ONU_CODONU ';

      If fTabelaExiste('MOVICD') Then
      Begin
        strSQL := strSQL + 'LEFT JOIN MOVICD ON MOVICD.ICD_SEQGER = MOVDET.AUTOINCREM ';
      End;

      If fTabelaExiste('DOCEXP') Then
        strSQL := strSQL + 'LEFT JOIN DOCEXP ON DOCEXP.EXP_SEQFIS = CADFIS.AUTOINCREM ';

      if fCampoExiste('MOVDET', 'DET_CODACA') then
      begin
        strSQL := strSQL + 'LEFT JOIN CADACA ACA ON ACA.ACA_CODACA = MOVDET.DET_CODACA AND ';
        strSQL := strSQL + '                        ACA.ACA_CODEMP = MOVDET.DET_EMPACA     ';
      end;

      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  IFNULL(FIS_HISTOR,"") <> "CANCELADO" AND ';

      strSQL := strSQL + '  IFNULL(DET_PROEMB,"N") <> "S" AND ';

      strSQL := strSQL + '  FIS_TIP_FC = :TIP_FC AND ';
      strSQL := strSQL + '  FIS_NUMDOC = :NUMDOC AND ';
      strSQL := strSQL + '  FIS_ESPDOC = :ESPDOC AND ';
      strSQL := strSQL + '  FIS_CODEMP = :CODEMP AND ';
      strSQL := strSQL + '  FIS_FORCLI = :CODCLI AND ';
      strSQL := strSQL + '  IFNULL(FIS_SERIE_, "") = :SERIE_ ';

      If (Not fNotaComplemento(FNumDoc, FEspDoc, FCodEmp, FCodCli, FSerie, FTip_FC)) Then
      Begin
        strSQLNot := strSQL;
        strSQLNot := AnsiReplaceStr(strSQLNot, 'MOVGER', 'NOTGER');
        strSQLNot := AnsiReplaceStr(strSQLNot, 'MOVDET', 'NOTDET');
        strSQLNot := AnsiReplaceStr(strSQLNot, 'MOVOBS', 'NOTOBS');
        strSQLNot := AnsiReplaceStr(strSQLNot, 'MOVTRI', 'NOTTRI');
        strSQLNot := AnsiReplaceStr(strSQLNot, 'AUXMOV', 'AUXNOT');
        strSQLNot := AnsiReplaceStr(strSQLNot, 'SERMOV', 'SERNOT');
        strSQLNot := AnsiReplaceStr(strSQLNot, 'MOVMAD', 'NOTMAD');
        strSQLNot := AnsiReplaceStr(strSQLNot, 'MOVICD', 'NOTICD');
        strSQLNot := AnsiReplaceStr(strSQLNot, 'GER_DTADOC', 'GER_DTAENT');
        strSQLNot := AnsiReplaceStr(strSQLNot, 'AUX_CLIORI', '"        "');
        strSQLNot := AnsiReplaceStr(strSQLNot, 'DET_ITEABF', '""');
        strSQLNot := AnsiReplaceStr(strSQLNot, 'DET_NUM_PD', '""');
        strSQLNot := AnsiReplaceStr(strSQLNot, 'DET_ESP_PD', '""');
        strSQLNot := AnsiReplaceStr(strSQLNot, 'DET_EMP_PD', '""');
        strSQLNot := AnsiReplaceStr(strSQLNot, 'DET_IND_PD', '""');

        If fCampoExiste('NOTGER', 'GER_DUPREC') Then
        Begin
          strSQLNot := AnsiReplaceStr(strSQLNot, '0.00 AS GER_DUPREC', 'GER_DUPREC');
          strSQLNot := AnsiReplaceStr(strSQLNot, 'AUX_DUPREC AS GER_DUPREC', 'GER_DUPREC');
        End;

        If Not fCampoExiste('NOTGER', 'GER_ICMORG') Then
        Begin
          strSQLNot := AnsiReplaceStr(strSQLNot, strIcmOrg, ' 0.00 AS GER_ICMORG ');
        End;

        If Not fCampoExiste('NOTTRI', 'DET_ICMORG') Then
        Begin
          strSQLNot := AnsiReplaceStr(strSQLNot, 'NOTTRI.DET_ICMORG', ' 0.00 AS DET_ICMORG ');
        End;

        If Not fCampoExiste('AUXNOT', 'AUX_VRDICM') Then
        Begin
          strSQLNot := AnsiReplaceStr(strSQLNot, strVrdIcm, ' 0.00 AS AUX_VRDICM ');
        End;

        If Not fCampoExiste('AUXNOT', 'AUX_CHVNFE') Then
        Begin
          strSQLNot := AnsiReplaceStr(strSQLNot, strChvNfe, ' " " AS GER_CHVNFE ');
        End;

        If Not fCampoExiste('AUXNOT', 'AUX_NUMCOO') Then
        Begin
          strSQLNot := AnsiReplaceStr(strSQLNot, strNumCOO, ' " " AS GER_NUMCOO ');
        End;

        If Not fCampoExiste('AUXNOT', 'AUX_NUMSER') Then
        Begin
          strSQLNot := AnsiReplaceStr(strSQLNot, strNumSer, ' " " AS GER_NUMSER ');
        End;

        If Not fCampoExiste('AUXNOT', 'AUX_NUMUSU') Then
        Begin
          strSQLNot := AnsiReplaceStr(strSQLNot, strNumUSU, ' " " AS GER_NUMUSU ');
        End;

        If Not fCampoExiste('AUXNOT', 'AUX_TIPDOC') Then
        Begin
          strSQLNot := AnsiReplaceStr(strSQLNot, strTipDoc, ' " " AS GER_TIPDOC ');
        End;

        If Not fCampoExiste('AUXNOT', 'AUX_EST_DV') Then
        Begin
          strSQLNot := AnsiReplaceStr(strSQLNot, strEst_Dv, ' " " AS GER_EST_DV ');
        End;

        If Not fCampoExiste('AUXNOT', 'AUX_NUMERO') Then
        Begin
          strSQLNot := AnsiReplaceStr(strSQLNot, strNumero, ' " " AS GER_NUMERO ');
        End;

        If Not fCampoExiste('AUXNOT', 'AUX_SERIE_') Then
        Begin
          strSQLNot := AnsiReplaceStr(strSQLNot, strSerie_, ' " " AS GER_SERIE1 ');
        End;

        If Not fCampoExiste('AUXNOT', 'AUX_MODELO') Then
        Begin
          strSQLNot := AnsiReplaceStr(strSQLNot, strModelo, ' " " AS GER_MODELO ');
        End;

        If Not fCampoExiste('AUXNOT', 'AUX_CPFCNP') Then
        Begin
          strSQLNot := AnsiReplaceStr(strSQLNot, strCPFCNP, ' " " AS GER_CPFCNP ');
        End;

        If Not fCampoExiste('AUXNOT', 'AUX_ESTADO') Then
        Begin
          strSQLNot := AnsiReplaceStr(strSQLNot, strEstado, ' " " AS GER_ESTADO ');
        End;

        If Not fCampoExiste('AUXNOT', 'AUX_MESANO') Then
        Begin
          strSQLNot := AnsiReplaceStr(strSQLNot, strMesAno, ' " " AS GER_MESANO ');
        End;

        If fCampoExiste('AUXNOT', 'AUX_COMVAL') Then
        Begin
          strSQLNot := AnsiReplaceStr(strSQLNot, strComVal, ' AUX_COMVAL AS GER_COMVAL ');
        End;

       If (Not fCampoExiste('NOTDET', 'DET_DESNES')) And
          (Not fCampoExiste('NOTTRI', 'DET_DESNES')) Then
          strSQLNot := AnsiReplaceStr(strSQLNot, 'DET_DESNES', '"" DET_DESNES');

        strSQLNot := AnsiReplaceStr(strSQLNot, 'REPEAT(" ", 20) AS DET_AUTINC, ', 'NOTDET.AUTOINCREM AS DET_AUTINC, ');

        If (Not fCampoExiste('NOTTRI', 'DET_VAEIPI')) Then
          strSQLNot := AnsiReplaceStr(strSQLNot, 'DET_VALIPI + IFNULL(NOTTRI.DET_VAEIPI,0)', '0');

        If (Not fCampoExiste('AUXNOT', 'AUX_TRARDP')) Then
        Begin
          If (Not fEmptyStr(strSelectTraRed)) Then
          Begin
            strSelectTraRed := AnsiReplaceStr(strSelectTraRed, 'AUXMOV', 'AUXNOT');
            strWhereTraRed_ := AnsiReplaceStr(strWhereTraRed_, 'AUXMOV', 'AUXNOT');

            strSQLNot := AnsiReplaceStr(strSQLNot, strSelectTraRed, ' " " AS TRA_EMAILR, ');
            strSQLNot := AnsiReplaceStr(strSQLNot, strWhereTraRed_, ' ');
          End;
        End;

        strSQL := strSQL + ' UNION ALL ' + strSQLNot;
      End;

      strSQL := strSQL + fRetOrderByNota('', fConfiguracao('ORDALF'));

      Result := strSQL;
    end;

    Function fVerificaCadFis(FNumDoc, FEspDoc, FCodEmp, FCodCli, FTip_FC : String): String;
    var
      qryCadFis : {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    Begin

      Result := ' CADFIS ';

      qryCadFis := fCriaQuery(Nil);

      Try
        With qryCadFis Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT COUNT(*) AS QTD FROM DEL_CADFIS WHERE ');
          SQL.Add('  FIS_NUMDOC = :NUMDOC AND ');
          SQL.Add('  FIS_ESPDOC = :ESPDOC AND ');
          SQL.Add('  FIS_CODEMP = :CODEMP AND ');
          SQL.Add('  FIS_FORCLI = :CODCLI AND ');
          SQL.Add('  FIS_TIP_FC = :TIP_FC ');

          ParamByName('NUMDOC').AsString := FNumDoc;
          ParamByName('ESPDOC').AsString := FEspDoc;
          ParamByName('CODEMP').AsString := FCodEmp;
          ParamByName('CODCLI').AsString := FCodCli;
          ParamByName('TIP_FC').AsString := FTip_Fc;

          Open;

          Result := IIF(FieldByName('QTD').AsInteger > 0,' DEL_CADFIS AS CADFIS ',Result);

          Close;

        End;

      Finally
        FreeAndNil(qryCadFis);
      End;

    End;

begin
  If Assigned(dadosGerais) Then
    Exit;

  strCadFis := fVerificaCadFis(FNumDoc, FEspDoc, FCodEmp, FCodCli, FTip_Fc);

  if not fEmptyStr(fConfiguracao('CFODVF')) then
    CFOP_DEVOLUCAO_FORNECEDOR_NFE := fTransform(fConfiguracao('CFODVF'),4);

  blnCadFaz    := (fConfiguracao('CADFAZ') = 'S') And (fCampoExiste('AUXMOV', 'AUX_CODFAZ'));

  blnTrSeCi    := fConfiguracao('TRSECI') = 'S';
  blnBaEIPI    := fCampoExiste('MOVTRI', 'DET_BAEIPI');
  blnVaEIPI    := fCampoExiste('MOVTRI', 'DET_VAEIPI');

  blnBaERet    := fCampoExiste('MOVTRI', 'DET_BAERET');
  blnVaERet    := fCampoExiste('MOVTRI', 'DET_VAERET');
  blnDupCND    := fCampoExiste('GERCND', 'GER_PARCEL');

  blnNSRBru    := (fCampoExiste('CADEMP', 'EMP_NSRBRU')) And (fConfiguracao('NSRBRU') = 'S');

  intPosAtual := 0;

  If FEmitente Then
  Begin
    FChaAce    := fRetornaChaveAcesso;
    FChaTabela := EmptyStr;
    Exit;
  End;

  If FCodEmp <> objConfig.strCodEmp Then
    Raise Exception.Create('Empresa do Documento (' + FCodEmp +') é diferente da empresa configurada (' + objConfig.strCodEmp +'). Verifique.');

  If (Not Assigned(qryDados)) Then
    qryDados := fCriaQuery(Nil);

  blnCliConNC := fCampoExiste('NOTCOM', 'GER_CPFCON');

  objConfig.blnClaOnu := fTabelaExiste('CADONU') And (fConfiguracao('CLAONU') = 'S');

  objConfigInterna.strImpPag := fConfiguracao('IMPPAG');
  objConfigInterna.blnMsgIaI := (fConfiguracao('MSGIAI') = 'S');

  objConfigInterna.strImpOnu := fConfiguracao('IMPONU');
  If fEmptyStr(objConfigInterna.strImpOnu) Then
    objConfigInterna.strImpOnu := 'A';

  objConfig.blnVenMad := (fConfiguracao('VENMAD') = 'S');
  objConfig.blnVenMtl := (fConfiguracao('VENMTL') = 'S');

  objConfigInterna.blnImpLot := (fConfiguracao('NFELOT') <> 'N');

  objConfigInterna.blnAgrDup := True;
  If (Pos(fConfiguracao('AGRDUP'), 'N_S_') > 0) Then
    objConfigInterna.blnAgrDup := SameText(fConfiguracao('AGRDUP'), 'S');

  objConfigInterna.blnPDCNFE := (fConfiguracao('PDCNFE') = 'S');

  objConfigInterna.blnNFeDig := (fConfiguracao('NFEDIG') <> 'N');

  objConfigInterna.blnNFeBar := (fConfiguracao('NFEBAR') = 'S');

  objConfigInterna.strTCrIcm := fConfiguracao('TCRICM');

  objConfigInterna.blnUniTri := (fConfiguracao('UNITRI') = 'S');

  objConfigInterna.blnImprimeAnotacoesItem := (fConfiguracao('IMPANO')='S');

  strSelectTraRed := '';
  strWhereTraRed_ := '';

  If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_TRARDP') Then
  Begin
    strSelectTraRed := ' TRARED.TRA_EMAIL_ AS TRA_EMAILR, ';
    strWhereTraRed_ := ' LEFT JOIN CADTRA AS TRARED ON AUXMOV.AUX_TRARDP = TRARED.TRA_CODTRA ';
  End;

  If fTabelaExiste('ABFICM') Then
    strTabAbf := 'ABFICM'//Nova tabela de abreviacao Fiscal
  Else
    strTabAbf := 'CADABF';

  If (FEspDoc = 'NS') Then
  Begin
    pAtualizaObraArtigo(fGetCodObr, fGetCodArt, FNumDoc, FEspDoc, FCodEmp, FCodCli, FTip_FC);
  End;

  qryDados.SQL.Clear;

  If fNFSemItens Then
    qryDados.SQL.Add(fGetSQLCadFis(strCadFis))
  Else
    qryDados.SQL.Add(fGetSQLMovGer(strCadFis));

  qryDados.ParamByName('NUMDOC').AsString := FNumDoc;
  qryDados.ParamByName('ESPDOC').AsString := FEspDoc;
  qryDados.ParamByName('CODEMP').AsString := FCodEmp;
  qryDados.ParamByName('CODCLI').AsString := FCodCli;
  qryDados.ParamByName('SERIE_').AsString := FSerie;
  qryDados.ParamByName('TIP_FC').AsString := FTip_FC;

  qryDados.Open;

  FChaAce    := qryDados.FieldByName('FIS_ACESSO').AsString;
  FChaTabela := qryDados.FieldByName('CHAVE_TABELA').AsString;

  If qryDados.IsEmpty Then
    Raise Exception.Create('Documento (' + FNumDoc +') não encontrado. Verifique.');

  objConfig.pValoresDefault;
  pRetAlqPisCofins(objConfig.fltAlqPis, objConfig.fltAlqCof);
  pCarregaCfgDesFab(objConfig.blnDesFab);
  pRetClassificacoesDevolucao;
  pRetCstSimplesProdSubstituidos;
  pCarregaConfiguracoesNotaServico;
  pRetCfgImpValorIpiDadosPropriosCFOPNaoVenda;
  pCarregaAtividadeConstrutora;
  pCarregaEmpresaNFSe;

  If blnDupCND Then
    pCarregaDuplicatasCND( qryDados.FieldByName('CHAVE_TABELA').AsString, qryDados.FieldByName('CHAVE_DUPLICATA').AsString );

  {************************************}
  {* PERMITIR NOTA DE SERVICO SEM CPF *}
  {********************************JC**}
  objConfigInterna.strNFSeSemCpf := fConfiguracao('NSSCPF');

  {***********************************}
  {* TIPO DE NOTA FISCAL DE CONCRETO *}
  {********************************JC*}
  objConfigInterna.strTpNfCr := fConfiguracao('TPNFCR');

  {*************************************************************************}
  {* VERIFICA DE IRA PRATICAR O CST DE OUTRAS ENTRADAS E SAIDAS PARA O IPI *}
  {**********************************************************************JC*}
  objConfigInterna.blnCstIpiOutras := (fConfiguracao('CSTIPO') = 'S');

  {**************************************************************************}
  {* VERIFICA SE CONCATENA O CODIGO DE FABRICA JUNTO A DESCRICAO DO PRODUTO *}
  {**********************************************************************JC**}
  objConfigInterna.blnFabNfe := (fConfiguracao('FABNFE') = 'S');

  objConfigInterna.strImpIcmsOpeProprias := fConfiguracao('ICOPDI');

  pAdicionaItensNaLista;
  pAdicionaServicosNaListaDeItens(qryDados.RecordCount - fGetQuantidadeItensServico);

  lstItens.Pack;
end;

procedure TFonteDadosBDEnt.pAdicionaItensNaLista;
begin
  qryDados.First;
  While (Not qryDados.Eof) Do
  Begin
    If ((Pos(qryDados.FieldByName('DET_CLAFIS').AsString, '5933_6933_') <= 0) Or
       (fNotaServicoEletronicaConcreto)) And
       (Not fEmptyStr(qryDados.FieldByName('DET_CODITE').AsString)) Then
    Begin
      fAdicionaItem(qryDados.RecNo-1, 0);
    End;

    qryDados.Next;
  End;

  If lstItens.Count = 0 Then
    fAdicionaItemServico(0, 0);
end;

procedure TFonteDadosBDEnt.pAdicionaServicosNaListaDeItens(intIndInicial: Integer);
  Var
    intContador: Integer;
begin
  If intIndInicial <= 0 Then
    intIndInicial := 0;

  If Not fEmptyStr(qryDados.FieldByName('GER_DESS01').AsString) And (qryDados.FieldByName('GER_TOTSER').AsFloat > 0) Then
  Begin
    For intContador := 1 To 30 Do
    Begin
      If qryDados.Fields.FindField('GER_DESS' + fStrZero(intContador, 2)) = Nil Then
        Continue;

      If Not fEmptyStr(qryDados.FieldByName('GER_DESS' + fStrZero(intContador, 2)).AsString) Then
        fAdicionaItem(intIndInicial+intContador-1, intContador);
    End;
  End;
end;

function TFonteDadosBDEnt.fGetQuantidadeItensServico: Integer;
begin
  Result := 0;
  qryDados.First;
  While (Not qryDados.Eof) Do
  Begin
    If (Pos(qryDados.FieldByName('DET_CLAFIS').AsString, '5933_6933_') > 0) And
       (Not fNotaServicoEletronicaConcreto)                                 Then
    Begin
      Inc(Result);
    End;
    qryDados.Next;
  End;
end;

procedure TFonteDadosBDEnt.pAtualizaDataDeAutorizacao(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli: String);
begin
//
end;

procedure TFonteDadosBDEnt.pAtualizaDadosAutorizacaoNFe(Const strChaveAcesso, strProtocolo, strNumDoc,
  strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC: String);
begin

end;

procedure TFonteDadosBDEnt.pAtualizaObraArtigo(strCodObr, strCodArt, strNumDoc, strEspDoc, strCodEmp, strCodCli, strTip_Fc: String);
  Const
    arrMovNot : Array[1..2] Of String[6] = ('MOVGER', 'NOTGER');

  function fSQLUpDate(strTabPri: String; strArtObr: String): String;
    Var
      strTabAux : String;
  begin
    If (strTabPri = 'NOTGER') Then
      strTabAux := 'AUXNOT'
    Else
      strTabAux := 'AUXMOV';
    Result := '';
    Result := Result + ' UPDATE ' + strTabAux ;
    Result := Result + '  INNER JOIN ' + strTabPri + ' ON ' + strTabPri + '.AUTOINCREM = ' + strTabAux + '.AUX_SEQGER  ';
    Result := Result + '    SET ' + strArtObr + ' = :ARTOBR ';
    Result := Result + '  WHERE GER_NUMDOC = :NUMDOC ';
    Result := Result + '    AND GER_ESPDOC = :ESPDOC ';
    Result := Result + '    AND GER_CODEMP = :CODEMP ';
    Result := Result + '    AND GER_TIP_FC = :TIP_FC ';
    If (strTip_Fc = 'F') Then
      Result := Result + '  AND GER_CODFOR = :CODCLI '
    Else
      Result := Result + '  AND GER_CODCLI = :CODCLI ';
  end;

  procedure pAtualiza(strCodObrArt, strObrArt: String);
    Var
      qryAtu : {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
      intCnt : Integer;
  begin
    qryAtu := fCriaQuery(Nil);

    Try
      With qryAtu DO
      Begin
        If (Not fEmptyStr(strCodObrArt)) Then
        Begin
          For intCnt := 1 To 2 Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add( fSQLUpDate( String(arrMovNot[intCnt]), strObrArt )  );
            ParamByName('ARTOBR').AsString := strCodObrArt;
            ParamByName('NUMDOC').AsString := strNumDoc;
            ParamByName('ESPDOC').AsString := strEspDoc;
            ParamByName('CODEMP').AsString := strCodEmp;
            ParamByName('TIP_FC').AsString := strTip_Fc;
            ParamByName('CODCLI').AsString := strCodCli;
            ExecSQL;
          End;
        End;
      End;
    Except
      On E: Exception Do
        Exception.Create(E.Message + ' [untUtilBD.pAtualizaObraArtigo]');
    End;

    FreeAndNil(qryAtu);
  End;

begin
  If Not fTabelaExiste('AUXMOV') Then
    Exit;

  If (strEspDoc <> 'NS') Then
    Exit;

  If (Not fCampoExiste('AUXMOV', 'AUX_CODOBR')) Or (Not fCampoExiste('AUXMOV', 'AUX_CODART')) Then
    Exit;

  If (Not fEmptyStr(strCodObr)) Then
    pAtualiza(strCodObr, 'AUX_CODOBR');

  If (Not fEmptyStr(strCodArt)) Then
    pAtualiza(strCodArt, 'AUX_CODART');
end;

procedure TFonteDadosBDEnt.pCarregarDocumentoImportacao(dadosItem: TDadosItem;
  strAutIncDet: String);
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin

  If fEmptyStr(strAutIncDet) Then
    Exit;

  qryAux := fCriaQuery(Nil);

  Try
    qryAux.SQL.Add('SELECT * FROM DOCIMP WHERE IMP_SEQDET = :SEQDET');
    qryAux.ParamByName('SEQDET').AsString := strAutIncDet;
    qryAux.Open;

    If (Not qryAux.IsEmpty) Then
    Begin
      dadosItem.documentoImportacao := TDocumentoImportacao.Create;
      dadosItem.documentoImportacao.strNumeroDi                := qryAux.FieldByName('IMP_NUM_DI').AsString;
      dadosItem.documentoImportacao.dtaDataDi                  := qryAux.FieldByName('IMP_DTA_DI').AsDateTime;
      dadosItem.documentoImportacao.strLocalizacaoDesembaracao := qryAux.FieldByName('IMP_LCDESE').AsString;
      dadosItem.documentoImportacao.strUFDesembaraco           := qryAux.FieldByName('IMP_UFDESE').AsString;
      dadosItem.documentoImportacao.dtaDataDesembaraco         := qryAux.FieldByName('IMP_DTDESE').AsDateTime;

      If (qryAux.FindField('IMP_ADICAO') <> Nil) Then
        dadosItem.documentoImportacao.intAdicao                  := qryAux.FieldByName('IMP_ADICAO').AsInteger
      Else
        dadosItem.documentoImportacao.intAdicao                  := 1;

      If (qryAux.FindField('IMP_BASEII') <> Nil) Then
      Begin
        dadosItem.documentoImportacao.fltBaseImpostoImportacao   := qryAux.FieldByName('IMP_BASEII').AsFloat;
        dadosItem.documentoImportacao.fltDespesasAduaneiras      := qryAux.FieldByName('IMP_DESADU').AsFloat;
        dadosItem.documentoImportacao.fltValorImpostoImportacao  := qryAux.FieldByName('IMP_VAL_II').AsFloat;
        dadosItem.documentoImportacao.fltValorIOF                := qryAux.FieldByName('IMP_VALIOF').AsFloat;
      End;

      If (qryAux.FindField('IMP_VTRINT') <> Nil) Then
      Begin
        dadosItem.documentoImportacao.intViaTransporte      := strToIntDef(qryAux.FieldByName('IMP_VTRINT').AsString, 0);
        dadosItem.documentoImportacao.fltValorAFRMM         := qryAux.FieldByName('IMP_VAFRMM').AsFloat;
        dadosItem.documentoImportacao.intFormaIntermediacao := strToIntDef(qryAux.FieldByName('IMP_FORIMP').AsString, 0);
        dadosItem.documentoImportacao.strCNPJAdquirente     := qryAux.FieldByName('IMP_CGCADQ').AsString;
        dadosItem.documentoImportacao.strUFAdquirente       := qryAux.FieldByName('IMP_UF_ADQ').AsString;
      End;

      If (qryAux.FindField('IMP_SISCOM') <> Nil) Then
      Begin
        dadosItem.documentoImportacao.fltSiscomex  := qryAux.FieldByName('IMP_SISCOM').AsFloat;
        dadosItem.documentoImportacao.fltPisPasep  := qryAux.FieldByName('IMP_PISPAS').AsFloat;
        dadosItem.documentoImportacao.fltCofins    := qryAux.FieldByName('IMP_COFINS').AsFloat;

        (*
        dadosItem.documentoImportacao.fltValorImpostoImportacao :=
          dadosItem.documentoImportacao.fltValorImpostoImportacao + dadosItem.fltValIcm;

        dadosItem.documentoImportacao.fltValorImpostoImportacao :=
          dadosItem.documentoImportacao.fltValorImpostoImportacao + dadosItem.documentoImportacao.fltSiscomex;

        dadosItem.documentoImportacao.fltValorImpostoImportacao :=
          dadosItem.documentoImportacao.fltValorImpostoImportacao + dadosItem.documentoImportacao.fltPisPasep;

        dadosItem.documentoImportacao.fltValorImpostoImportacao :=
          dadosItem.documentoImportacao.fltValorImpostoImportacao + dadosItem.documentoImportacao.fltCofins;
          *)
      End;

      dadosItem.documentoImportacao.fltValAdp := 0;
      If (qryAux.FindField('IMP_VLRADP') <> Nil) Then
        dadosItem.documentoImportacao.fltValAdp    := qryAux.FieldByName('IMP_VLRADP').AsFloat;

    End;
  Finally
    FreeAndNil(qryAux);
  End;

end;

procedure TFonteDadosBDEnt.pCarregarFormasPagamento(dadosGerais: TDadosGerais);
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    fltTotalModalidades: Double;
    fltDiferenca: Double;

    intContador: Integer;
begin
  SetLength(dadosGerais.arrFormasPagamento, 0);
  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  CASE MOD_CODMOD ');
  qryAux.SQL.Add('    WHEN "001" THEN "01" ');
  qryAux.SQL.Add('    WHEN "002" THEN "02" ');
  qryAux.SQL.Add('    WHEN "006" THEN "02" ');
  qryAux.SQL.Add('    WHEN "007" THEN IF(CAR_TIPCAR="C", "03", "04") ');
  qryAux.SQL.Add('    ELSE "99" ');
  qryAux.SQL.Add('  END AS CODMOD, ');

  qryAux.SQL.Add('  MOD_CODMOD, ');

  If fCampoExiste('MOVMOD', 'MOD_VALPAG') Then
   qryAux.SQL.Add('  SUM(MOD_VALPAG) AS VALPAG, ');

  qryAux.SQL.Add('  SUM(MOD_VALMOD) AS VALMOD ');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  MOVMOD ');
  qryAux.SQL.Add('  LEFT JOIN MOVCAR ON MCA_DOCUME = MOD_DOCUME AND MCA_PARCEL = "A" AND MOD_CODMOD = "007" ');
  qryAux.SQL.Add('  LEFT JOIN CADCAR ON CAR_CODCAR = MCA_CODCAR ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  MOD_NUMDOC = :NUMDOC AND ');
  qryAux.SQL.Add('  MOD_ESPDOC = :ESPDOC AND ');
  qryAux.SQL.Add('  MOD_CODEMP = :CODEMP AND ');
  qryAux.SQL.Add('  MOD_CODCLI = :CODCLI AND ');
  qryAux.SQL.Add('  MOD_SERIE_ = :SERIE_     ');//projeto_serie
  qryAux.SQL.Add('GROUP BY MOD_CODMOD ');

  qryAux.ParamByName('NUMDOC').AsString := dadosGerais.strNumDoc;
  qryAux.ParamByName('ESPDOC').AsString := dadosGerais.strEspDoc;
  qryAux.ParamByName('CODEMP').AsString := dadosGerais.strCodEmp;
  qryAux.ParamByName('CODCLI').AsString := dadosGerais.strCodCli;
  qryAux.ParamByName('SERIE_').AsString := dadosGerais.strSerie;
  qryAux.Open;

  If Not qryAux.IsEmpty Then
  Begin
    fltTotalModalidades := 0;
    While (Not qryAux.Eof) Do
    Begin
      If qryAux.FieldByName('VALMOD').AsFloat > 0 Then
      Begin
        SetLength(dadosGerais.arrFormasPagamento, Length(dadosGerais.arrFormasPagamento)+1);
        dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1] := TFormaPagamento.Create;
        dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1].strCodigo := qryAux.FieldByName('CODMOD').AsString;
        dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1].strModCodMod := qryAux.FieldByName('MOD_CODMOD').AsString;
        dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1].fltValor  := qryAux.FieldByName('VALMOD').AsFloat;
        If fCampoExiste('MOVMOD', 'MOD_VALPAG') Then
          dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1].fltValPag := qryAux.FieldByName('VALPAG').AsFloat
        Else
          dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1].fltValPag := 0;

        fltTotalModalidades := fltTotalModalidades + qryAux.FieldByName('VALMOD').AsFloat;
      End;
      qryAux.Next;
    End;

    fltDiferenca := dadosGerais.fltTotGer - fltTotalModalidades;
    If fltDiferenca < 0 Then
    Begin
      fltDiferenca := Abs(fltDiferenca);
      For intContador := Low(dadosGerais.arrFormasPagamento) To High(dadosGerais.arrFormasPagamento) Do
      Begin
        If dadosGerais.arrFormasPagamento[intContador].fltValor > fltDiferenca Then
        Begin
          dadosGerais.arrFormasPagamento[intContador].fltValor := dadosGerais.arrFormasPagamento[intContador].fltValor - fltDiferenca;
          Break;
        End;
      End;
    End
    Else
    Begin
      {************************************************************************************}
      {* SE CASO HOUVE BAIXA PARCIAL DE UM DOCUMENTO CONFIRMADO, AO GERAR A NFCE, JOGAR A *}
      {* DIFERENÇA NO PRIMEIRO REGISTRO. A NOTA ESTAVA SENDO REJEITADA DEVIDO A QUESTÃO   *}
      {* DO VALOR TOTAL NÃO BATER COM A SOMA DOS ITENS. RONALDO CIENTE.                   *}
      {*********************************************************************************FC*}
      If fltDiferenca > 0 Then
      Begin
        If Length(dadosGerais.arrFormasPagamento) > 0 Then
        Begin
          If fCampoExiste('MOVMOD', 'MOD_VALPAG') Then
            dadosGerais.arrFormasPagamento[0].fltValPag := dadosGerais.arrFormasPagamento[0].fltValor + fltDiferenca;

          dadosGerais.arrFormasPagamento[0].fltValor := dadosGerais.arrFormasPagamento[0].fltValor + fltDiferenca;
        End
        Else
        Begin
          SetLength(dadosGerais.arrFormasPagamento, 1);
          dadosGerais.arrFormasPagamento[0] := TFormaPagamento.Create;
          dadosGerais.arrFormasPagamento[0].strCodigo := '01';
          dadosGerais.arrFormasPagamento[0].fltValor  := fltDiferenca;
        End;
      End;
    End;
  End
  Else
  Begin
    {*******************************************************}
    {* SE CASO NÃO ENCONTRAR NENHUM REGISTRO NA MOVMOD,    *}
    {* É PORQUE É UM REGISTRO DE CONFIRMAÇÃO E O DOCUMENTO *}
    {* ORIGINAL DELE JÁ FOI QUITADO, POR ISSO O DOCUMENTO  *}
    {* CONFIRMADO NÃO EXISTE MOVMOD CADASTRADO, DEVIDO A   *}
    {* ESTA QUESTÃO SERÁ MANDADO COMO DINHEIRO A VISTA,    *}
    {* POIS O MESMO JÁ ESTÁ QUITADO                        *}
    {****************************************************FC*}
    SetLength(dadosGerais.arrFormasPagamento, 1);
    dadosGerais.arrFormasPagamento[0] := TFormaPagamento.Create;
    dadosGerais.arrFormasPagamento[0].strCodigo := '01';
    dadosGerais.arrFormasPagamento[0].fltValor  := dadosGerais.fltTotGer;
  End;
  FreeAndNil(qryAux);
end;

procedure TFonteDadosBDEnt.pInicio;
begin
  If (Not Assigned(qryDados)) Then
  Begin
    pCarregarDados;
  End;

  intPosAtual := 0;

  If Assigned(qryDados) Then
    qryDados.First;
end;

procedure TFonteDadosBDEnt.pLogarPerformance(objeto: TObject);
//  Var
//    log: TLogPerformance;
//    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
//    qrySel: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  //Função em desuso, mantida apenas por compatibilidade;

  If Not objConfigInterna.blnMonitoramentoTempo Then
    Exit;

  If (objeto = Nil) Then
    Exit;

//  log := TLogPerformance(objeto);
//  qryAux := fCriaQuery(Nil);
//  qryAux.SQL.Add('INSERT INTO NFE_TEMPO (');
//  qryAux.SQL.Add('  NFE_ORIGEM, ');
//  qryAux.SQL.Add('  NFE_NUMDOC, ');
//  qryAux.SQL.Add('  NFE_ESPDOC, ');
//  qryAux.SQL.Add('  NFE_CODEMP, ');
//  qryAux.SQL.Add('  NFE_CODCLI, ');
//  qryAux.SQL.Add('  NFE_SERIE_, ');
//  qryAux.SQL.Add('  NFE_TIP_FC, ');
//  qryAux.SQL.Add('  NFE_INIOPE, ');
//  qryAux.SQL.Add('  NFE_FIMOPE, ');
//  qryAux.SQL.Add('  NFE_CODEVE, ');
//  qryAux.SQL.Add('  NFE_DESEVE) ');
//  qryAux.SQL.Add('VALUES ( ');
//  qryAux.SQL.Add('  :ORIGEM, ');
//  qryAux.SQL.Add('  :NUMDOC, ');
//  qryAux.SQL.Add('  :ESPDOC, ');
//  qryAux.SQL.Add('  :CODEMP, ');
//  qryAux.SQL.Add('  :CODCLI, ');
//  qryAux.SQL.Add('  :SERIE_, ');
//  qryAux.SQL.Add('  :TIP_FC, ');
//  qryAux.SQL.Add('  :INIOPE, ');
//  qryAux.SQL.Add('  :FIMOPE, ');
//  qryAux.SQL.Add('  :CODEVE, ');
//  qryAux.SQL.Add('  :DESEVE) ');
//
//  qryAux.ParamByName('ORIGEM').AsString := log.strOrigem;
//  qryAux.ParamByName('NUMDOC').AsString := log.strNumDoc;
//  qryAux.ParamByName('ESPDOC').AsString := log.strEspDoc;
//  qryAux.ParamByName('CODEMP').AsString := log.strCodEmp;
//  qryAux.ParamByName('CODCLI').AsString := log.strCodCli;
//  qryAux.ParamByName('SERIE_').AsString := log.strSerie;
//  qryAux.ParamByName('TIP_FC').AsString := FTip_FC;
//  qryAux.ParamByName('INIOPE').AsDateTime := log.dtaHoraInicial;
//  qryAux.ParamByName('FIMOPE').AsDateTime := log.dtaHoraFinal;
//  qryAux.ParamByName('CODEVE').AsInteger := log.intCodigo;
//  qryAux.ParamByName('DESEVE').AsString := log.strMensagem;
//  qryAux.ExecSQL;
//
//  If log.intCodigo = IMPRESSAO_NOTA_FISCAL Then
//  Begin
//    qrySel := fCriaQuery(Nil);
//    qrySel.SQL.Add('SELECT NFE_INIOPE FROM NFE_TEMPO WHERE ');
//    qrySel.SQL.Add('  NFE_NUMDOC = :NUMDOC AND ');
//    qrySel.SQL.Add('  NFE_ESPDOC = :ESPDOC AND ');
//    qrySel.SQL.Add('  NFE_CODEMP = :CODEMP AND ');
//    qrySel.SQL.Add('  NFE_CODCLI = :CODCLI AND ');
//    qrySel.SQL.Add('  IFNULL(NFE_SERIE_, "") = :SERIE_ AND ');
//    qrySel.SQL.Add('  NFE_TIP_FC = :TIP_FC AND ');
//    qrySel.SQL.Add('  NFE_CODEVE = :CODEVE ');
//    qrySel.SQL.Add('ORDER BY ');
//    qrySel.SQL.Add('  NFE_INIOPE DESC ');
//    qrySel.SQL.Add('LIMIT 1 ');
//
//    qrySel.ParamByName('NUMDOC').AsString := log.strNumDoc;
//    qrySel.ParamByName('ESPDOC').AsString := log.strEspDoc;
//    qrySel.ParamByName('CODEMP').AsString := log.strCodEmp;
//    qrySel.ParamByName('CODCLI').AsString := log.strCodCli;
//    qrySel.ParamByName('SERIE_').AsString := log.strSerie;
//    qrySel.ParamByName('TIP_FC').AsString := FTip_FC;
//    qrySel.ParamByName('CODEVE').AsInteger := PRIMEIRO_PASSO_MEDICAO_TEMPO;
//    qrySel.Open;
//
//    If Not qrySel.IsEmpty Then
//    Begin
//      qryAux.ParamByName('ORIGEM').AsString := log.strOrigem;
//      qryAux.ParamByName('NUMDOC').AsString := log.strNumDoc;
//      qryAux.ParamByName('ESPDOC').AsString := log.strEspDoc;
//      qryAux.ParamByName('CODEMP').AsString := log.strCodEmp;
//      qryAux.ParamByName('CODCLI').AsString := log.strCodCli;
//      qryAux.ParamByName('SERIE_').AsString := log.strSerie;
//      qryAux.ParamByName('TIP_FC').AsString := FTip_FC;
//      qryAux.ParamByName('INIOPE').AsDateTime := qrySel.FieldByName('NFE_INIOPE').AsDateTime;
//      qryAux.ParamByName('FIMOPE').AsDateTime := log.dtaHoraFinal;
//      qryAux.ParamByName('CODEVE').AsInteger := MEDICAO_TEMPO_GERAL;
//      qryAux.ParamByName('DESEVE').AsString := 'Tempo total para emissão NFe';
//      qryAux.ExecSQL;
//    End;
//
//    FreeAndNil(qrySel);
//  End;
//
//  FreeAndNil(qryAux);
end;

procedure TFonteDadosBDEnt.pRetornaDadosIbge(strCodCid: String; var strCodIbge,
  strUfIbge, strEstado, strCidade: String);
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  strUfIbge  := '';
  strCodIbge := '';
  strEstado  := '';
  strCidade  := '';

  If Not fEmptyStr(strCodCid) Then
  Begin
    qryAux := fCriaQuery(Nil);
    Try
      qryAux.SQL.Add('SELECT ');
      qryAux.SQL.Add('  IBG_CODUF_, ');
      qryAux.SQL.Add('  IBG_CODMUN, ');
      qryAux.SQL.Add('  CID_ESTADO, ');
      qryAux.SQL.Add('  CID_NOMCID  ');
      qryAux.SQL.Add('FROM ');
      qryAux.SQL.Add('  IBG_CADIBG ');
      qryAux.SQL.Add('JOIN CADCID ON CID_COIBGE = IBG_CODMUN ');
      qryAux.SQL.Add('WHERE ');
      qryAux.SQL.Add('  CID_CODCID = :CODCID ');
      qryAux.ParamByName('CODCID').AsString := strCodCid;
      qryAux.Open;

      strUfIbge  := qryAux.FieldByName('IBG_CODUF_').AsString;
      strCodIbge := qryAux.FieldByName('IBG_CODMUN').AsString;
      strEstado  := qryAux.FieldByName('CID_ESTADO').AsString;
      strCidade  := qryAux.FieldByName('CID_NOMCID').AsString;
    Finally
      FreeAndNil(qryAux);
    End;
  End;
end;

function TFonteDadosBDEnt.fRetSQLMsg1e2TipAbfdeSAI(strTip: String): String;
  Var
    intAux: Integer;
    strAux: String;
begin
  For intAux:=1 To 2 Do
  Begin
    strAux := 'ABF_MENS'+fStrZero(IntToStr(intAux),2)+'_SAI_'+strTip;
    If fCampoExiste('ABFICM', strAux) Then
      Result := Result + ' ' + strAux + ', ';
  End;
end;

function TFonteDadosBDEnt.fGetCampoValor(strCampoRetorno, strCampoChave, strValorChave, strTabela: String): String;
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  Result := '';

  If Not fTabelaExiste(strTabela) Then
    Exit;

  If (Not fCampoExiste(strTabela, strCampoRetorno)) Then
    Exit;

  If (Not fCampoExiste(strTabela, strCampoChave)) Then
    Exit;

  qryAux := fCriaQuery(Nil);

  Try
    With qryAux Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT ' + strCampoRetorno );
      SQL.Add('   FROM ' + strTabela);
      SQL.Add('  WHERE ' + strCampoChave + ' = :CHAVE ');
      ParamByName('CHAVE').AsString := strValorChave;
      Open;
      Result := FieldByName(strCampoRetorno).AsString;
      Close;
    End;
  Except

  End;

  FreeAndNil(qryAux);
end;

function TFonteDadosBDEnt.fGetCodArt: String;
  Var
    strEntGer : String;
begin
  Result := '';
  strEntGer := fGetEntGer(FNumDoc, FEspDoc, FCodEmp, FCodCli, FTip_FC);

  If (Not fEmptyStr(strEntGer)) Then
    Result := fGetCampoValor('ETC_CODART', 'AUTOINCREM', strEntGer, 'ENTCLI');

  If fEmptyStr(Result) Then
    Result := fGetCampoValor('CLI_CODART', 'CLI_CODCLI', FCodCli, 'CADCLI');
end;

function TFonteDadosBDEnt.fGetCodObr: String;
  Var
    strEntGer : String;
begin
  Result := '';
  strEntGer := fGetEntGer(FNumDoc, FEspDoc, FCodEmp, FCodCli, FTip_FC);

  If (Not fEmptyStr(strEntGer)) Then
    Result := fGetCampoValor('ETC_CODOBR', 'AUTOINCREM', strEntGer, 'ENTCLI');

  If fEmptyStr(Result) Then
    Result := fGetCampoValor('CLI_CODOBR', 'CLI_CODCLI', FCodCli, 'CADCLI');
end;

function TFonteDadosBDEnt.fGetDadosAdicionaisReferenteAEntrega: String;

  function fIdxTurno(strTurno: String): Integer;
  begin
    Result := -1;
    If (AnsiSameText(strTurno, 'Manhã')) Then
      Result := 0
    Else If (AnsiSameText(strTurno, 'Tarde')) Then
      Result := 1
    Else If (AnsiSameText(strTurno, 'Noite')) Then
      Result := 2;
  end;

  function fSQLBase(strTabela: String): String;
    Var
      strTabTri : String;
  begin
    If (strTabela = 'MOVDET') Then
      strTabTri := 'MOVTRI'
    Else
      strTabTri := 'NOTTRI';

    Result := '';
    Result := Result + ' SELECT DET_TURENT, DET_DTAFUT ';
    Result := Result + '   FROM ' + strTabela;
    Result := Result + '   LEFT JOIN ' + strTabTri + ' ON ' + strTabTri + '.DET_SEQGER = ' + strTabela + '.AUTOINCREM ';
    Result := Result + '  WHERE DET_DTAFUT IS NOT NULL ';
    Result := Result + '    AND DET_NUMDOC = :NUMDOC ';
    Result := Result + '    AND DET_ESPDOC = :ESPDOC ';
    Result := Result + '    AND DET_SERIE_ = :SERIE_ ';
    Result := Result + '    AND DET_CODEMP = :CODEMP ';
    Result := Result + '    AND DET_TIP_FC = :TIP_FC ';
    If (FTip_FC = 'C') Then
      Result := Result + '    AND DET_CODCLI = :CLIFOR '
    Else
      Result := Result + '    AND DET_CODFOR = :CLIFOR ';
  end;

  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    dtaBase : TDateTime;
    strTurno : String;
begin
  Result := '';

  If Not (fConfiguracao('EXITUR') = 'S') Then
    Exit;

  If (fConfiguracao('TURDAD') = 'N') Then
    Exit;

  If Not fTabelaExiste('MOVTRI') Then
    Exit;

  If Not fTabelaExiste('MOVDET') Then
    Exit;

  If (Not fCampoExiste('MOVTRI', 'DET_TURENT')) Then
    Exit;

  If (Not fCampoExiste('MOVDET', 'DET_DTAFUT')) Then
    Exit;

  qryAux := fCriaQuery(Nil);

  With qryAux Do
  Begin
    SQL.Clear;
    SQL.Add(fSQLBase('MOVDET'));
    SQL.Add(' UNION ALL ');
    SQL.Add(fSQLBase('NOTDET'));
    SQL.Add(' ORDER BY DET_DTAFUT DESC ');
    ParamByName('NUMDOC').AsString := FNumDoc;
    ParamByName('ESPDOC').AsString := FEspDoc;
    ParamByName('SERIE_').AsString := FSerie;
    ParamByName('CODEMP').AsString := FCodEmp;
    ParamByName('TIP_FC').AsString := FTip_FC;
    ParamByName('CLIFOR').AsString := FCodCli;
    Open;

    If (Not IsEmpty) Then
    Begin

      First;

      dtaBase := FieldByName('DET_DTAFUT').AsDateTime;
      strTurno := FieldByName('DET_TURENT').AsString;

      While Not Eof Do
      Begin

        If (AnsiSameText(strTurno, 'Noite')) Or (RecordCount = 1) Then
          Break;

        If fEmptyStr(FieldByName('DET_TURENT').AsString) Then
        Begin
          Next;
          Continue;
        End;

        If (dtaBase = FieldByName('DET_DTAFUT').AsDateTime) Then
        Begin
          If fEmptyStr(strTurno) Then
            strTurno := FieldByName('DET_TURENT').AsString;

          If fIdxTurno(FieldByName('DET_TURENT').AsString) > fIdxTurno(strTurno) Then
            strTurno := FieldByName('DET_TURENT').AsString;
        End;

        Next;
      End;

      Result := 'PREVISAO DE ENTREGA ATÉ ' + FormatDateTime('dd/MM/yyyy', dtaBase);

      If Not fEmptyStr(strTurno) Then
        Result := Result + ', NO PERÍODO DA ' + strTurno;

      Result := Result + '.#';
    End;
    
  End;  

  FreeAndNil(qryAux);
end;

function TFonteDadosBDEnt.fGetDocumentoRemessaConcreto(intSeqCcr: Integer): String;
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryAux := fCriaQuery(Nil);

  With qryAux, SQL Do
  Begin
    Clear;
    
    Add('SELECT SQL_NO_CACHE ');
    Add('  CONCAT("DANFE: ", DET_NUMDOC,"-",DET_ESPDOC,"-",IFNULL(DET_SERIE_,"")) AS DOCUMENTO');
    Add('FROM');
    Add('  MOVDET D');
    Add('  INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM');
    Add('WHERE');
    Add('  D.DET_NUMFAT = :NUMDOC AND ');
    Add('  D.DET_TIPFAT = :ESPDOC AND ');

    If fCampoExiste('MOVDET', 'DET_SERFAT') Then
      Add('  D.DET_SERFAT = :SERDOC AND ');

    Add('  D.DET_EMPFAT = :CODEMP AND ');
    Add('  T.DET_SEQCCR = :SEQCCR');

    ParamByName('NUMDOC').AsString  := FNumDoc;
    ParamByName('ESPDOC').AsString  := FEspDoc;

    If fCampoExiste('MOVDET', 'DET_SERFAT') Then
      ParamByName('SERDOC').AsString  := FSerie;

    ParamByName('CODEMP').AsString  := FCodEmp;
    ParamByName('SEQCCR').AsInteger := intSeqCcr;

    Open;

    Result := FieldByName('DOCUMENTO').AsString;
  End;

  FreeAndNil(qryAux);
end;

function TFonteDadosBDEnt.fGetEntGer(strNumDoc, strEspDoc, strCodEmp, strCodCli, strTip_Fc: String): String;
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    intCnt : Integer;
  Const
    arrAuxMovNot : Array[1..2] Of String[6] = ('AUXMOV', 'AUXNOT');
    arrGerMovNot : Array[1..2] Of String[6] = ('MOVGER', 'NOTGER');
begin
  Result := '';

  If Not fTabelaExiste('AUXMOV') Then
    Exit;

  If (Not fCampoExiste('AUXMOV', 'AUX_ENTGER')) Then
    Exit;

  qryAux := fCriaQuery(Nil);

  Try
    With qryAux Do
    Begin
      For intCnt := 1 To 2 Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(' SELECT IFNULL(AUX_ENTGER,"") AUX_ENTGER ');
        SQL.Add('   FROM ' + String(arrAuxMovNot[intCnt]) );
        SQL.Add('  INNER JOIN ' + String(arrGerMovNot[intCnt]) + ' ON ' + String(arrGerMovNot[intCnt]) + '.AUTOINCREM = ' + String(arrAuxMovNot[intCnt]) + '.AUX_SEQGER  ');
        SQL.Add('  WHERE GER_NUMDOC = :NUMDOC ');
        SQL.Add('    AND GER_ESPDOC = :ESPDOC ');
        SQL.Add('    AND GER_CODEMP = :CODEMP ');
        SQL.Add('    AND GER_TIP_FC = :TIP_FC ');
        If (strTip_Fc = 'F') Then
          SQL.Add('  AND GER_CODFOR = :CODCLI ')
        Else
          SQL.Add('  AND GER_CODCLI = :CODCLI ');
        ParamByName('NUMDOC').AsString := strNumDoc;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ParamByName('CODEMP').AsString := strCodEmp;
        ParamByName('TIP_FC').AsString := strTip_Fc;
        ParamByName('CODCLI').AsString := strCodCli;
        Open;

        If (RecordCount > 0) Then
        Begin
          Result := FieldByName('AUX_ENTGER').AsString;
          Break;
        End;
      End;
      Close;
    End;
  Except

  End;

  FreeAndNil(qryAux);
end;

function TFonteDadosBDEnt.fGetManifesto(
  strNumeroManifesto: String): TManifestoEletronico;
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    qrySeg: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    nfe: TNFeManifesto;
    segCar: TManifestoSegCar;
    segCarAverb: TManifestoSegCarAverb;
    blnEstMan : Boolean;

  function fGetSql(): String;
  begin
    Result := '';
    Result := Result + 'SELECT ';
    Result := Result + '  FIS_DTAMAN AS DTAMAN, ';
    Result := Result + '  FIS_ACESSO AS ACESSO, ';
    Result := Result + '  GER_VLRCON AS VLRCON, ';
    Result := Result + '  GER_PESBRU AS PESBRU, ';
    Result := Result + '  MOT_CPFMOT AS CPFMOT, ';
    Result := Result + '  MOT_NOMMOT AS NOMMOT, ';
    Result := Result + '  CID_COIBGE AS COIBGE, ';

    If fCampoExiste('CADFIS', 'FIS_EMPMAN') Then
      Result := Result + ' FIS_EMPMAN AS EMPMAN, '
    Else
      Result := Result + ' "" AS EMPMAN, ';

    Result := Result + '  FIS_PLAMAN AS PLAMAN, ';

    If (blnEstMan) Then
      Result := Result + '  FIS_ESTMAN AS ESTADO '
    Else
      Result := Result + '  FIS_ESTADO AS ESTADO ';

    If fCampoExiste('CADFIS', 'FIS_PERCUR') Then
      Result := Result + '  , FIS_PERCUR AS PERCUR '
    Else
      Result := Result + ' "" AS PERCUR ';

    Result := Result + 'FROM ';
    Result := Result + '  CADFIS ';
    Result := Result + '  LEFT JOIN CADCLI ON CLI_CODCLI = FIS_FORCLI AND FIS_TIP_FC = "C" ';
    Result := Result + '  LEFT JOIN CADFOR ON FOR_CODFOR = FIS_FORCLI AND FIS_TIP_FC = "F" ';
    Result := Result + '  JOIN MOVGER ON GER_NUMDOC = FIS_NUMDOC AND ';
    Result := Result + '                 GER_ESPDOC = FIS_ESPDOC AND ';
    Result := Result + '                 GER_SERIE_ = FIS_SERIE_ AND ';
    Result := Result + '                 GER_CODEMP = FIS_CODEMP AND ';
    Result := Result + '                 GER_TIP_FC = FIS_TIP_FC AND ';
    Result := Result + '                 IFNULL(GER_CODCLI, FOR_CODFOR) = FIS_FORCLI ';
    Result := Result + '  JOIN CADMOT ON MOT_CODMOT = FIS_MOTMAN ';

    If (blnEstMan) And (fTabelaExiste('AUXMOV')) And (fTabelaExiste('ENTCLI')) Then
    Begin
      Result := Result + ' LEFT JOIN AUXMOV ON AUXMOV.AUX_SEQGER = MOVGER.AUTOINCREM ';
      Result := Result + ' LEFT JOIN ENTCLI ON AUXMOV.AUX_ENTGER = ENTCLI.AUTOINCREM ';
      Result := Result + '                 AND ENTCLI.ETC_CODCLI = IFNULL(GER_CODCLI, NULL) ';
      Result := Result + ' JOIN CADCID ON CID_CODCID = IFNULL(ETC_CIDENT, IFNULL(CLI_CODCID, FOR_CODCID)) ';
    End
    Else
      Result := Result + '  JOIN CADCID ON CID_CODCID = IFNULL(CLI_CODCID, FOR_CODCID) ';

    Result := Result + 'WHERE ';
    Result := Result + '  FIS_ESPDOC IN ("NF", "EL") AND ';
    Result := Result + '  FIS_CLFSC1 > "5000" AND ';
    Result := Result + '  FIS_ORIDOC = "V" AND ';
    If fCampoExiste('CADFIS', 'FIS_EMPMAN') Then
      Result := Result + '  FIS_EMPMAN = :CODEMP AND '
    else
      Result := Result + '  FIS_CODEMP = :CODEMP AND ';
    Result := Result + '  FIS_NUMMAN = :NUMMAN ';

    Result := Result + 'UNION ALL ' + AnsiReplaceStr(Result, 'MOVGER', 'NOTGER');
  end;
begin
  blnEstMan := fCampoExiste('CADFIS', 'FIS_ESTMAN');
  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add(fGetSql);
  qryAux.ParamByName('CODEMP').AsString := objConfig.strCodEmp;
  qryAux.ParamByName('NUMMAN').AsString := strNumeroManifesto;
  qryAux.Open;

  Result := TManifestoEletronico.Create(strNumeroManifesto,
    fDadosEmitente,
    qryAux.FieldByName('DTAMAN').AsDateTime,
    qryAux.FieldByName('CPFMOT').AsString,
    qryAux.FieldByName('NOMMOT').AsString,
    qryAux.FieldByName('PLAMAN').AsString,
    objConfig.strCodEmp, '', '');

  While (Not qryAux.Eof) Do
  Begin
    nfe := TNFeManifesto.Create(qryAux.FieldByName('ACESSO').AsString,
      qryAux.FieldByName('COIBGE').AsString,
      qryAux.FieldByName('PESBRU').AsFloat,
      qryAux.FieldByName('VLRCON').AsFloat,
      qryAux.FieldByName('ESTADO').AsString,
      qryAux.FieldByName('PERCUR').AsString, '');
    Result.pAddNfe(nfe);

    qryAux.Next;
  End;

  If (fTabelaExiste('FISMOT')) Then
  Begin
    qrySeg := fCriaQuery(Nil);
    Try
      qrySeg.SQL.Add('SELECT FMO_CODMOT, MOT_CPFMOT, MOT_NOMMOT');
      qrySeg.SQL.Add('FROM FISMOT');
      qrySeg.SQL.Add('JOIN CADMOT ON MOT_CODMOT = FMO_CODMOT');
      qrySeg.SQL.Add('WHERE FMO_SEQGER = :SEQGER');
      qrySeg.ParamByName('SEQGER').AsString := qryAux.FieldByName('AUTOINCREM').AsString;
      qrySeg.Open;
      while not qrySeg.Eof do
      begin
        Result.pAddMotorista(
          TManifestoMotorista.Create(
            qrySeg.FieldByName('MOT_CPFMOT').AsString,
            qrySeg.FieldByName('MOT_NOMMOT').AsString));

        qrySeg.Next;
      end;
    Finally
      qrySeg.Free;
    End;
  End;

  If (fTabelaExiste('MDFSEG')) And (fTabelaExiste('MDFAVE')) And
     (qryAux.FindField('EMPMAN') <> Nil) And
     (Not fEmptyStr(qryAux.FieldByName('EMPMAN').AsString)) Then
  Begin
    qrySeg := fCriaQuery(Nil);
    Try
      qrySeg.SQL.Text := 'SELECT * FROM MDFSEG WHERE MDF_NUMMAN = :NUMMAN AND MDF_EMPMAN = :EMPMAN ORDER BY MDF_SEQUEN';
      qrySeg.ParamByName('NUMMAN').AsString := strNumeroManifesto;
      qrySeg.ParamByName('EMPMAN').AsString := qryAux.FieldByName('EMPMAN').AsString;
      qrySeg.Open;

      qrySeg.First;
      While Not qrySeg.Eof Do
      Begin
        segCar := TManifestoSegCar.Create(qrySeg.FieldByName('MDF_SEQUEN').AsInteger,
                                          qrySeg.FieldByName('MDF_RESSEG').AsInteger,
                                          qrySeg.FieldByName('MDF_RESCPF').AsString,
                                          qrySeg.FieldByName('MDF_NOMSEG').AsString,
                                          qrySeg.FieldByName('MDF_SEGCNP').AsString,
                                          qrySeg.FieldByName('MDF_NUMAPO').AsString
                                          );
        Result.pAddSeqCarga(segCar);

        qrySeg.Next;
      End;

      qrySeg.Close;
      qrySeg.SQL.Text := 'SELECT * FROM MDFAVE WHERE MDF_NUMMAN = :NUMMAN AND MDF_EMPMAN = :EMPMAN ORDER BY MDF_SEQUEN';
      qrySeg.ParamByName('NUMMAN').AsString := strNumeroManifesto;
      qrySeg.ParamByName('EMPMAN').AsString := qryAux.FieldByName('EMPMAN').AsString;
      qrySeg.Open;

      qrySeg.First;
      While Not qrySeg.Eof Do
      Begin
        segCarAverb := TManifestoSegCarAverb.Create(qrySeg.FieldByName('MDF_SEQUEN').AsInteger,
                                                    qrySeg.FieldByName('MDF_NUMAVE').AsString
                                                    );
        Result.pAddSeqCargaAverb(segCarAverb);

        qrySeg.Next;
      End;
    Finally
      FreeAndNil(qrySeg);
    End;
  End;

  FreeAndNil(qryAux);
end;

function TFonteDadosBDEnt.fGetManifestoCompacto(
  strNumeroManifesto: String): TManifestoEletronico;
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  FIS_DTAMAN, FIS_ACEMAN ');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  CADFIS ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  FIS_NUMMAN = :NUMMAN AND ');
  if fCampoExiste('CADFIS', 'FIS_EMPMAN') then
    qryAux.SQL.Add('FIS_EMPMAN = :CODEMP')
  else
    qryAux.SQL.Add('FIS_CODEMP = :CODEMP');

  qryAux.ParamByName('CODEMP').AsString := objConfig.strCodEmp;
  qryAux.ParamByName('NUMMAN').AsString := strNumeroManifesto;
  qryAux.Open;

  Result := TManifestoEletronico.Create(strNumeroManifesto, fDadosEmitente,
    qryAux.FieldByName('FIS_DTAMAN').AsDateTime, '', '', '', objConfig.strCodEmp, '', '');
  Result.SetChaveAcesso(qryAux.FieldByName('FIS_ACEMAN').AsString);

  FreeAndNil(qryAux);
end;

procedure TFonteDadosBDEnt.pRetCstSimplesProdSubstituidos;
  Var
    strCfg: String;
begin
  If fEmptyStr(fConfiguracao('CSTSSC')) Then
    strCfg := 'CSTSSC'
  Else
    strCfg := IIF(fDadosGerais.strCliCon='S', 'CSTSSB', 'CSTSSC');

  objConfig.strCstSimSubs := fConfiguracao(strCfg);

  If fEmptyStr(fConfiguracao('CSTNSF')) Then
    strCfg := 'CSTSSF'
  Else
    strCfg := IIF(fDadosGerais.strCliCon='S', 'CSTSSF', 'CSTNSF');

  objConfig.strCstSimSubsForaEstado := fConfiguracao(strCfg);

  If fEmptyStr(objConfig.strCstSimSubsForaEstado) Then
    objConfig.strCstSimSubsForaEstado := objConfig.strCstSimSubs;

  if (fDadosGerais.strOriundoOS = 'S') and (fConfiguracao('SIMPAU') = 'S') and (fConfiguracao('CSTCEQ') = 'S') then
    objConfig.strCstSimTrib := '102'
  else
    objConfig.strCstSimTrib := fConfiguracao('CSTSTR');

  objConfig.strCstSimTribCI := fConfiguracao('CSTSTC');

  objConfig.strAPCSOS := fConfiguracao('APCSOS');
end;

procedure TFonteDadosBDEnt.pRetCfgImpValorIpiDadosPropriosCFOPNaoVenda;
begin
  objConfig.strOpcImpValIpi := fConfiguracao('IVLIPI');
end;

function TFonteDadosBDEnt.fRetDesCndPagamento(strCodCnd: String): String;
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryAux := fCriaQuery(Nil);
  Try
    qryAux.SQL.Add('SELECT CND_DESCRI FROM CADCND WHERE CND_CODIGO = :CODCND');
    qryAux.ParamByName('CODCND').AsString := strCodCnd;
    qryAux.Open;
    Result := qryAux.FieldByName('CND_DESCRI').AsString;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TFonteDadosBDEnt.fCampoExiste(const strTabela, strCampo: String): Boolean;
  {$IF Defined(UNIDAC)}
  Var
    strKey: String;
  {$IFEND}
begin
  {$IF Defined(UNIDAC)}
  strKey := fFormataKeyCmpExiParaDicSis(strTabela, strCampo);
  If fAchouDicSisBln(Database, strKey, Result) Then
    Exit;
  {$IFEND}

  Result := fTabelaCampoExiste(Database, strTabela, strCampo);

  {$IF Defined(UNIDAC)}
  pInsereDicSis(Database, strKey, fBooleanToStringDisSis(Result));
  {$IFEND}
end;

{***********************************************}
{* RETORNA O VALOR DE UM DETERMINADO CAMPO     *}
{* DE UMA TABELA PASSANDO COMO PARAMETROS      *}
{* OS CAMPOS CHAVES E SEUS VALORES (WHERE)     *}
{* PODE SER UTIL PARA RETORNAR DESDE DESCRICAO *}
{* ATE VALORES, DATAS ENTRE OUTROS             *}
{********************************************JC*}
function TFonteDadosBDEnt.fCampoTabela(strCampo : String;
                                    strNomTab: String;
                                    arrCampoChave: Array Of String;
                                    arrValorChave: Array Of Variant): Variant;
  Const
    arrParms : Array [0..11] Of String[1] = ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L');

  Var
    intCont  : Integer;
    strSQL   : String;
    qryGenGer: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
Begin
  Try
    qryGenGer := fCriaQuery(nil);

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  ' + strCampo + ' ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ' + strNomTab + ' ';
    strSQL := strSQL + 'WHERE ';

    For intCont := 0 To Length(arrCampoChave) -1 Do
    Begin
      If Pos('<>', arrCampoChave[intCont]) > 0 Then
        strSQL := strSQL + '  ' + arrCampoChave[intCont] + ' :' + String(arrParms[intCont]) + ' AND '
      Else
        strSQL := strSQL + '  ' + arrCampoChave[intCont] + ' = :' + String(arrParms[intCont]) + ' AND ';
    End;

    strSQL := strSQL + '  TRUE  ';

    With qryGenGer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      For intCont := 0 To Length(arrCampoChave) -1 Do
        ParamByName(String(arrParms[intCont])).Value := arrValorChave[intCont];

      Open;

      Result := Fields[0].Value;

      {*******************************************}
      {* EXECUTA UM CAST PARA NAO RETORNAR NULL  *}
      {****************************************JC*}
      Case Fields[0].DataType Of
        ftString : Result := Fields[0].AsString;
        ftMemo   : Result := Fields[0].AsString;
        ftFloat  : Result := Fields[0].AsFloat;
        ftInteger: Result := Fields[0].AsInteger;
        ftBoolean: Result := Fields[0].AsBoolean;
        ftDate   : Result := Fields[0].AsDateTime;
        ftTime   : Result := Fields[0].AsDateTime;
      End;

    End;

  Finally
    FreeAndNil(qryGenGer);
  End;

End;

function TFonteDadosBDEnt.fNotaServicoEletronica: Boolean;
begin
  Result := (FEspDoc = 'NS');
end;

function TFonteDadosBDEnt.fNotaServicoEletronicaConcreto: Boolean;
begin
  Result := fNotaServicoEletronica And Assigned(qryDados) And
            (Not fEmptyStr(qryDados.FieldByName('DET_SEQCCR').AsString));
end;

function TFonteDadosBDEnt.fConfiguracao(strCodCfg: String): String;
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    strRes,
    strAux : String;
    {$IF Defined(UNIDAC)}
    strKey: String;
    {$IFEND}
begin
  If SameText(strCodCfg, 'CLIATI') Then
    raise Exception.Create('"CFG_CLIATI" obsoleta, utilizar: "fAtividadeConstrutora" ou "fRetAtividades" ');

  qryAux := fCriaQuery(Nil);
  Try
    Try
      {$IF Defined(UNIDAC)}
      strKey := fFormataKeyValCfgParaDicSis(strCodCfg, objConfig.strCodEmp);
      If fAchouDicSisStr(qryAux.Connection, strKey, Result) Then
        Exit;
      {$IFEND}

      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add('SELECT ');
      qryAux.SQL.Add('  SIS_CODCFG,');
      qryAux.SQL.Add('  SIS_VALCFG ');
      qryAux.SQL.Add('FROM ');
      qryAux.SQL.Add('  CFGSIS ');
      qryAux.SQL.Add('WHERE ');
      qryAux.SQL.Add('  SIS_CODCFG = :CODCFG AND ');
      qryAux.SQL.Add('  SIS_CODEMP = :CODEMP ');

      qryAux.ParamByName('CODEMP').AsString := objConfig.strCodEmp;
      qryAux.ParamByName('CODCFG').AsString := 'CFG_' + strCodCfg;

      qryAux.Open;

      strRes := qryAux.FieldByName('SIS_VALCFG').AsString;

      {**********************************************************}
      {* VALIDAÇÃO PARA TESTAR SE JÁ É UMA CHAVE CRIPTROGRAFADA *}
      {********************************************************VA}
      If Pos(qryAux.FieldByName('SIS_CODCFG').AsString, consChavesCript) > 0 Then
      Begin
        strAux:=fDecrypt(strRes);
        If fCrypt(strAux) = strRes Then
          Result := fDecrypt(strRes)
        Else
          Result := strRes;
      End
      Else
        Result := strRes;
    Except
      Result := '';
    End;
    {$IF Defined(UNIDAC)}
    pInsereDicSis(qryAux.Connection, strKey, Result);
    {$IFEND}
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TFonteDadosBDEnt.fConfiguracaoExiste(strCodCfg: String): Boolean;
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    {$IF Defined(UNIDAC)}
    strKey: String;
    {$IFEND}
begin
  qryAux := fCriaQuery(Nil);
  Try
    {$IF Defined(UNIDAC)}
    strKey := fFormataKeyCfgExiParaDicSis(strCodCfg, objConfig.strCodEmp);
    If fAchouDicSisBln(qryAux.Connection, strKey, Result) Then
      Exit;
    {$IFEND}

    Try
      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add('SELECT ');
      qryAux.SQL.Add('  SIS_CODCFG AS CONFIG_EXISTE ');
      qryAux.SQL.Add('FROM ');
      qryAux.SQL.Add('  CFGSIS ');
      qryAux.SQL.Add('WHERE ');
      qryAux.SQL.Add('  SIS_CODCFG = :CODCFG AND ');
      qryAux.SQL.Add('  SIS_CODEMP = :CODEMP ');

      qryAux.ParamByName('CODEMP').AsString := objConfig.strCodEmp;
      qryAux.ParamByName('CODCFG').AsString := 'CFG_' + strCodCfg;

      qryAux.Open;

      Result := (Not qryAux.IsEmpty);

      qryAux.Close;
    Except
      Result := False;
    End;
    {$IF Defined(UNIDAC)}
    pInsereDicSis(qryAux.Connection, strKey, fBooleanToStringDisSis(Result));
    {$IFEND}
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TFonteDadosBDEnt.fAtividadeConstrutora(strCodAti: String): Boolean;
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  If (Not fEmptyStr(objConfig.strVS_CliAti)) Then
  Begin
    Result := (Pos(strCodAti, objConfig.strVS_CliAti) > 0);
  End
  Else
  Begin
    qryAux := fCriaQuery(Nil);
    Try
      Try
        If fTabelaExiste('CLIATI') Then
        Begin
          qryAux.Close;
          qryAux.SQL.Clear;
          qryAux.SQL.Add('SELECT ATI_CODATI ');
          qryAux.SQL.Add('  FROM CLIATI ');
          qryAux.SQL.Add(' WHERE ATI_CODATI = :CODATI ');
          qryAux.SQL.Add('   AND ATI_CODEMP = :CODEMP ');
          qryAux.ParamByName('CODATI').AsString := strCodAti;
          qryAux.ParamByName('CODEMP').AsString := objConfig.strCodEmp;
          qryAux.Open;
          Result := (Not qryAux.IsEmpty);
          qryAux.Close;
        End
        Else
        Begin
          qryAux.Close;
          qryAux.SQL.Clear;
          qryAux.SQL.Add('SELECT SIS_VALCFG ');
          qryAux.SQL.Add('  FROM CFGSIS ');
          qryAux.SQL.Add(' WHERE SIS_CODCFG = "CFG_CLIATI" ');
          qryAux.SQL.Add('   AND SIS_CODEMP = :CODEMP ');
          qryAux.ParamByName('CODEMP').AsString := objConfig.strCodEmp;
          qryAux.Open;
          Result := (qryAux.FieldByName('SIS_VALCFG').AsString = strCodAti);
          qryAux.Close;
        End;
      Except
        On E: Exception Do
        Begin
          Result := False;
          Exception.Create(E.Message + ' [TFonteDadosBD.fAtividadeConstrutora]');
        End;
      End;
    Finally
      FreeAndNil(qryAux);
    End;
  End;
end;

function TFonteDadosBDEnt.fRetAtividades: String;
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryAux := fCriaQuery(Nil);
  Try
    If fTabelaExiste('CLIATI') Then
    Begin
      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add('SELECT ATI_CODATI ');
      qryAux.SQL.Add('  FROM CLIATI ');
      qryAux.SQL.Add(' WHERE ATI_CODEMP = :CODEMP ');
      qryAux.ParamByName('CODEMP').AsString := objConfig.strCodEmp;
      qryAux.Open;

      Result := '---_';

      qryAux.First;
      While Not qryAux.Eof Do
      Begin
        Result := Result + qryAux.FieldByName('ATI_CODATI').AsString + '_';
        qryAux.Next;
      End;

      qryAux.Close;
    End
    Else
    Begin
      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add('SELECT SIS_VALCFG ');
      qryAux.SQL.Add('  FROM CFGSIS ');
      qryAux.SQL.Add(' WHERE SIS_CODCFG = "CFG_CLIATI" ');
      qryAux.SQL.Add('   AND SIS_CODEMP = :CODEMP ');
      qryAux.ParamByName('CODEMP').AsString := objConfig.strCodEmp;
      qryAux.Open;
      Result := qryAux.FieldByName('SIS_VALCFG').AsString;
      qryAux.Close;
    End;
  Except
    On E: Exception Do
    Begin
      Result := '';
      Exception.Create(E.Message + ' [TFonteDadosBDEnt.fRetAtividades]');
    End;
  End;

  FreeAndNil(qryAux);
end;

procedure TFonteDadosBDEnt.pCarregaConfiguracoes;
begin
  objConfig.strFitUrlWebService := fConfiguracao('TOTURL');
  objConfig.strFitLicenca       := fConfiguracao('TOTLIC');
  objConfig.strFitUsuario       := fConfiguracao('TOTUSU');
  objConfig.strFitSenha         := fConfiguracao('TOTSEN');

  objConfig.strFitImpressoraPadrao := fConfiguracao('CITIMP');

  objConfigProxy.strFitUsuarioProxy := fConfiguracao('CITUSP');
  objConfigProxy.strFitSenhaProxy := fConfiguracao('CITPSP');
  objConfigProxy.strFitProxy := fConfiguracao('CITPRX');
  objConfigProxy.strFitProxyByPass := fConfiguracao('CITPBP');

  objConfig.blnInfGar := False;

  If SameText(fConfiguracao('IMPGAR'), 'S')  Then
    objConfig.blnInfGar := True;

  If fConfiguracao('NFEMAR') = EmptyStr Then
    objConfig.blnNFEMar := objConfig.blnNFEFab;

  objConfig.blnNfeFCI := fConfiguracao('NFEFCI') <> 'N';

  If SameText(fConfiguracao('AUTCEN'), 'S')  Then
    objConfig.blnAutCen := True
  Else
    objConfig.blnAutCen := False;

  Try
    objConfigInterna.strFitIntegradorImpressao := fConfiguracao('CITINT');
    objConfigInterna.strPontoVenda := fRetPontoVendaNFCe;
    objConfigInterna.strUrlNFCe    := '';//MORTA
    objConfigInterna.blnMonitoramentoTempo := False;
    objConfigInterna.strArqEnt             := FArqEnt;
    objConfigInterna.blnEmiEnt             := FEmiEnt;
  Except
  End;

  Try
    objConfig.strFitUrlWebServiceManifesto := fConfiguracao('CITURM');
  Except
  End;
end;

procedure TFonteDadosBDEnt.pCarregaConfiguracoesInternas(
  var objConfig: TConfiguracoesInternas);
begin
  //
end;

function TFonteDadosBDEnt.fRetPontoVendaNFCe: String;
  Var
    strPathOpcoesNFCe: String;
begin
  Result := '';
  Exit;

  strPathOpcoesNFCe := fConfiguracao('PTNFCE');
  If fEmptyStr(strPathOpcoesNFCe) Then
  Begin
    Exit;
  End;

  Result := fArqIniLocal(0, 'NFCE', 'PDV', '', strPathOpcoesNFCe + PATH_SEPARATOR + 'opcoes_nfce.ini');
end;

function TFonteDadosBDEnt.fSuportaOperacaoBanco: Boolean;
begin
  Result := True;
end;

procedure TFonteDadosBDEnt.pCarregaConfiguracoesNotaServico;
begin
  objConfigInterna.strPatNES := fConfiguracao('PATNES');
  objConfigInterna.strCliNES := fConfiguracao('CCLNSE');
  objConfigInterna.strReEsTr := fConfiguracao('REESTR');
  objConfigInterna.strNtOpNS := fConfiguracao('NTOPNS');
  objConfigInterna.blnSimISS := fConfiguracao('SIMISS') = 'S';
  objConfigInterna.blnZerIss := fConfiguracao('ZERISS') = 'S';
  objConfigInterna.strIteTax := fConfiguracao('ITETAX');
end;

function TFonteDadosBDEnt.fTabelaExiste(strNomeTabela: String): Boolean;
  {$IF Defined(UNIDAC)}
  Var
    strKey: String;
  {$IFEND}
Begin
  If (fEmptyStr(strNomeTabela)) Then
  Begin
    Result := False;
    Exit;
  End;

  {$IF Defined(UNIDAC)}
  strKey := fFormataKeyTabExiParaDicSis(strNomeTabela);
  If fAchouDicSisBln(Database, strKey, Result) Then
    Exit;
  {$IFEND}

  Result := fTabelaCampoExiste(Database, strNomeTabela);

  {$IF Defined(UNIDAC)}
  pInsereDicSis(Database, strKey, fBooleanToStringDisSis(Result));
  {$IFEND}
End;

procedure TFonteDadosBDEnt.pVerificaSeImprimePalavraAVistaDuplicata(dadosGerais: TDadosGerais);
begin
  If (fConfiguracao('IMPAVI') = 'P') And
     (Length(dadosGerais.arrDuplicatas) = 1) And
     (Assigned(dadosGerais.arrDuplicatas[0])) And
     (dadosGerais.arrDuplicatas[0].dtaDtaVen = dadosGerais.dtaDtaEnt) Then
  Begin
    dadosGerais.arrDuplicatas[0].strNumDup := 'A VISTA';
  End;
end;

procedure TFonteDadosBDEnt.pPegaNumeroPedidosFaturados(dadosGerais: TDadosGerais);
  Var
    qryGenTmp: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
Begin

  Try
    qryGenTmp := fCriaQuery(Nil);

    With qryGenTmp, SQL Do
    Begin
      Close;
      Clear;

      Add('SELECT GROUP_CONCAT(DISTINCT FDO_NUMDOC) AS PEDIDOS ');
      Add('FROM ');
      Add('  FATDOR ');
      Add('WHERE ');
      Add('  FDO_NUMFAT = :NUMFAT AND ');
      Add('  FDO_TIPFAT = :TIPFAT AND ');

      If fCampoExiste('FATDOR', 'FDO_SERFAT') Then
        Add('  FDO_SERFAT = :SERFAT AND ');

      Add('  FDO_EMPFAT = :EMPFAT ');
      Add('ORDER BY ');
      Add('  FDO_NUMDOC ');

      ParamByName('NUMFAT').AsString := FNumDoc;
      ParamByName('TIPFAT').AsString := FEspDoc;

      If fCampoExiste('FATDOR', 'FDO_SERFAT') Then
        ParamByName('SERFAT').AsString := FSerie;

      ParamByName('EMPFAT').AsString := FCodEmp;

      Open;

      dadosGerais.strDocsPD := FieldByName('PEDIDOS').AsString;

      Close;
    End;

  Except

  End;

  FreeAndNil(qryGenTmp);
end;

function TFonteDadosBDEnt.fRetornaChaveAcesso: String;
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  FIS_ACESSO ');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  CADFIS ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  FIS_TIP_FC = :TIP_FC AND ');
  qryAux.SQL.Add('  FIS_NUMDOC = :NUMDOC AND ');
  qryAux.SQL.Add('  FIS_ESPDOC = :ESPDOC AND ');
  qryAux.SQL.Add('  FIS_CODEMP = :CODEMP AND ');
  qryAux.SQL.Add('  FIS_FORCLI = :CODCLI AND ');
  qryAux.SQL.Add('  IFNULL(FIS_SERIE_, "") = :SERIE_ ');

  qryAux.ParamByName('TIP_FC').AsString := FTip_FC;
  qryAux.ParamByName('NUMDOC').AsString := FNumDoc;
  qryAux.ParamByName('ESPDOC').AsString := FEspDoc;
  qryAux.ParamByName('CODEMP').AsString := FCodEmp;
  qryAux.ParamByName('CODCLI').AsString := FCodCli;
  qryAux.ParamByName('SERIE_').AsString := FSerie;
  qryAux.Open;

  Result := qryAux.FieldByName('FIS_ACESSO').AsString;

  FreeAndNil(qryAux);
end;

function TFonteDadosBDEnt.fRetornaEstadoEmpresa(strCnpj: String): String;
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  CID_ESTADO ');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  CADEMP ');
  qryAux.SQL.Add('JOIN CADCID ON CID_CODCID = EMP_CODCID ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  EMP_C_G_C_ = :CGC ');

  qryAux.ParamByName('CGC').AsString := strCnpj;
  qryAux.Open;

  Result := qryAux.FieldByName('CID_ESTADO').AsString;

  FreeAndNil(qryAux);
end;

{**************************************************************}
{* NCO - SAIDA NAO CONTRIBUINTE (PF OU PJ SEM INSC. ESTADUAL) *}
{* CCO - SAIDA CONTRIBUINTE CONSUMIDOR                        *}
{* CNC - SAIDA CONTRIBUINTE NAO CONSUMIDOR                    *}
{* CTA - SAIDA CONSTRUTORA                                    *}
{* PRU - SAIDA PRODUTOR RURAL                                 *}
{* IND - SAIDA INDUSTRIA                                      *}
{**************************************************************}
function TFonteDadosBDEnt.fGetTipAbfSaida(strFisJur, strIES, strProRur, strMicEmp, strConsum, strCodAti, strRegTri, strIndust: String; blnCliFil: Boolean): String;
begin
  Result := '_SAI_';

  If (fCampoExiste('ABFICM', 'ABF_ALQICM_SAI_TRS')) And  blnCliFil Then
    Result := Result + 'TRS'//TRS - SAIDAS TRANSFERENCIAS ENTRE LOJAS

  Else If (strProRur = 'S') And (Not fEmptyStr(fRetSQLMsg1e2TipAbfdeSAI('PRU'))) Then
    Result := Result + 'PRU'//PRU - PRODUTOR RURAL

  Else If (strIndust = 'S') And (Not fEmptyStr(fRetSQLMsg1e2TipAbfdeSAI('IND'))) Then
    Result := Result + 'IND'//IND - SAIDA INDUSTRIA

  Else If (strRegTri = 'S') And (Not fEmptyStr(fRetSQLMsg1e2TipAbfdeSAI('SNA'))) Then
    Result := Result + 'SNA'//SNA - SIMPLES NACIONAL

  Else If fAtividadeConstrutora(strCodAti) Then
    Result := Result + 'CTA'//CTA - CONSTRUTORA

  Else If (fEmptyStr(strIES) And (strMicEmp <> 'S'))  Or (strFisJur = 'F') Then//(F)isica ou (J)uridica
    Result := Result + 'NCO'//NCO - NAO CONTRIBUINTE (PF OU PJ SEM INSC. ESTADUAL)

  Else If strConsum = 'S' Then
    Result := Result + 'CCO'//CCO - CONTRIBUINTE CONSUMIDOR

  Else
    Result := Result + 'CNC';//CNC - CONTRIBUINTE NAO CONSUMIDOR
end;

function TFonteDadosBDEnt.fCriaQuery(Owner: TComponent): {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
Begin
  Result := {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery.Create(Owner); {$ELSE} TZQuery.Create(Owner); {$IFEND}
  Result.Connection := Database;
  Result.Tag := Database.Tag;
  {$IF Defined(VER250) Or Defined(UNIDAC)}
  Result.BeforeExecute := untDicSis.TQueryLog.BeforeExecute;
  {$ELSE}
  Result.BeforeOpen := untDicSis.TQueryLog.BeforeOpen;
  {$IFEND}
End;

procedure TFonteDadosBDEnt.pCarregaDadosNFSeSubstituicao(Var dadosGerais: TDadosGerais; strAutInc: String);
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  If Not fTabelaExiste('SUBNFS') Then
  Begin
    Exit;
  End;

  qryAux := fCriaQuery(Nil);

  qryAux.SQL.Add('SELECT * FROM SUBNFS WHERE SUB_SEQGER = :SEQGER AND SUB_ENVIAD = 1 ORDER BY SUB_NUMRPS DESC LIMIT 1');
  qryAux.ParamByName('SEQGER').AsString := strAutInc;
  qryAux.Open;

  dadosGerais.strNumeroRpsSubstituto := qryAux.FieldByName('SUB_NUMRPS').AsString;
  dadosGerais.strSerieRpsSubstituto := qryAux.FieldByName('SUB_SERRPS').AsString;

  FreeAndNil(qryAux);
end;

procedure TFonteDadosBDEnt.pCarregaChavesReferenciadasAKZ(strNumDoc,strEspDoc,strCodEmp: String);
  Var
    qryInfCom: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    stlAdicionadas : TStringList;
    strChvAce: String;
Begin
  SetLength(dadosGerais.arrChavesReferenciadas, 0);
  qryInfCom := fCriaQuery(Nil);
  stlAdicionadas := TStringList.Create;
  Try
    With qryInfCom, SQL Do
    Begin
      Clear;
      Add('SELECT DISTINCT SUBSTR(LOT_NOTULT,1,12) AS LOT_NOTULT, LOT_DTAULT, ');
      Add('                LOT_CHVULT, FIS_NUMDOC, FIS_DTAENT, FIS_ACESSO     ');
      Add('FROM MOVDET                                                        ');
      Add('INNER JOIN FATDOR ON FDO_NUMDOC = DET_NUM_PD AND                   ');
      Add('                     FDO_ESPDOC = DET_ESP_PD AND                   ');
      Add('                     FDO_CODEMP = DET_EMP_PD AND                   ');
      Add('                     FDO_CODITE = DET_CODITE AND                   ');
      Add('                     FDO_SEQIND = DET_IND_PD                       ');
      Add('INNER JOIN DEL_LOTDOR ON LDO_SEQFDO = FATDOR.AUTOINCREM            ');
      Add('INNER JOIN CADLOT ON LOT_NUMLOT = LDO_NUMLOT AND                   ');
      Add('                     LOT_CODEMP = FDO_CODEMP AND                   ');
      Add('                     LOT_CODITE = FDO_CODITE                       ');
      Add('LEFT  JOIN CADFIS ON FIS_NUMDOC = SUBSTR(LOT_NOTULT,1,12) AND      ');
      Add('                     FIS_FORCLI = LOT_FORULT  AND                  ');
      Add('                     FIS_TIP_FC = "F" AND                          ');
      Add('                     FIS_ENTSAI = "E"                              ');
      Add('WHERE LOT_NOTULT IS NOT NULL                                       ');
      Add('  AND DET_NUMDOC = :NUMDOC                                         ');
      Add('  AND DET_ESPDOC = :ESPDOC                                         ');
      Add('  AND DET_CODEMP = :CODEMP                                         ');
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;

      First;
      While Not Eof Do
      Begin
        strChvAce := IIF(fEmptyStr(FieldByName('FIS_ACESSO').AsString), FieldByName('LOT_CHVULT').AsString, FieldByName('FIS_ACESSO').AsString);

        If (stlAdicionadas.IndexOf(strChvAce) < 0) Then
        Begin
          SetLength(dadosGerais.arrChavesReferenciadas, Length(dadosGerais.arrChavesReferenciadas) + 1);
          dadosGerais.arrChavesReferenciadas[Length(dadosGerais.arrChavesReferenciadas) - 1] := TChaveReferenciada.Create;

          With dadosGerais.arrChavesReferenciadas[Length(dadosGerais.arrChavesReferenciadas) - 1] Do
          Begin
            strTipoChave := DOCUMENTO_REF_NFe_Modelo_55;

            If fEmptyStr(FieldByName('FIS_ACESSO').AsString) Then
              strChaveAcessoNfe := FieldByName('LOT_CHVULT').AsString
            Else
              strChaveAcessoNfe := FieldByName('FIS_ACESSO').AsString;

            stlAdicionadas.Add(strChvAce);
          End;
        End;

        Next;
      End;
    End;
  Finally
    FreeAndNil(qryInfCom);
    FreeAndNil(stlAdicionadas);
  End;
end;

procedure TFonteDadosBDEnt.pCarregaChavesReferenciadas(dadosGerais: TDadosGerais);
  Var
    strSQL,
    strCodIbge,
    strUfIbge,
    strEstado: String;
    strCidade: String;

    function fExiteTipoDoc: Boolean;
    Begin
      Result := (qryDados.FindField('GER_TIPDOC') <> Nil)                  And
                (Not fEmptyStr(qryDados.FindField('GER_TIPDOC').AsString));
    End;

    function fExisteChaveNfeAuxMov: Boolean;
    Begin
      Result := (qryDados.FindField('GER_CHVNFE') <> Nil)                  And
                (Not fEmptyStr(qryDados.FindField('GER_CHVNFE').AsString));
    End;

    function fExisteCupomFiscalAuxMov: Boolean;
    Begin
      Result := (qryDados.FindField('GER_NUMCOO') <> Nil)                  And
                (Not fEmptyStr(qryDados.FindField('GER_NUMCOO').AsString)) And
                (qryDados.FindField('GER_NUMSER') <> Nil)                  And
                (Not fEmptyStr(qryDados.FindField('GER_NUMSER').AsString)) And
                (qryDados.FindField('GER_NUMUSU') <> Nil)                  And
                (Not fEmptyStr(qryDados.FindField('GER_NUMUSU').AsString));

    End;

    function fExisteModeloA1AuxMov: Boolean;
    Begin
      Result := (qryDados.FindField('GER_NUMERO') <> Nil)                  And
                (Not fEmptyStr(qryDados.FindField('GER_NUMERO').AsString)) And
                (qryDados.FindField('GER_SERIE1') <> Nil)                  And
                (Not fEmptyStr(qryDados.FindField('GER_SERIE1').AsString)) And
                (qryDados.FindField('GER_MODELO') <> Nil)                  And
                (Not fEmptyStr(qryDados.FindField('GER_MODELO').AsString)) And
                (qryDados.FindField('GER_CPFCNP') <> Nil)                  And
                (Not fEmptyStr(qryDados.FindField('GER_CPFCNP').AsString)) And
                (qryDados.FindField('GER_ESTADO') <> Nil)                  And
                (Not fEmptyStr(qryDados.FindField('GER_ESTADO').AsString)) And
                (qryDados.FindField('GER_MESANO') <> Nil)                  And
                (Not fEmptyStr(qryDados.FindField('GER_MESANO').AsString));

    End;
begin
  SetLength(dadosGerais.arrChavesReferenciadas, 0);

  {*********************************************************************************}
  {* SE FOR UM DOCUMENTO DE OUTRAS ENTRADAS COM CFOP DE DEVOLUÇÃO E ESTIVER USANDO *}
  {* A VERSÃO DA NFE 3.10, PEGA A CHAVE DE REFERENCIA QUE FOI SALVA NA AUXMOV.     *}
  {******************************************************************************FC*}
  {*********************************************************************************}
  {* ALTEREI PARA VERIFICAR APENAS OS CAMPOS DE CHAVE REF. OU CUPOM REF.           *}
  {******************************************************************************MV*}

  If fVersao310(Self, '55') And
     ((fExisteChaveNfeAuxMov) Or (fExisteCupomFiscalAuxMov) Or (fExisteModeloA1AuxMov)) Then
  Begin
    SetLength(dadosGerais.arrChavesReferenciadas, Length(dadosGerais.arrChavesReferenciadas) + 1);
    dadosGerais.arrChavesReferenciadas[Length(dadosGerais.arrChavesReferenciadas) - 1] := TChaveReferenciada.Create;

    With dadosGerais.arrChavesReferenciadas[Length(dadosGerais.arrChavesReferenciadas) - 1] Do
    Begin
      If fExisteChaveNfeAuxMov Then
      Begin
        {*********************************************************************************}
        {* NÃO TEM PROBLEMA USAR NF, TANTO PARA NFE QUANTO NFCE, POIS A TAG É A MESMA.   *}
        {******************************************************************************MV*}
        strTipoChave      := dadosGerais.fTipoChaveReferenciada('NF', qryDados.FindField('GER_CHVNFE').AsString);
        strChaveAcessoNfe := qryDados.FindField('GER_CHVNFE').AsString;
      End
      Else If fExisteCupomFiscalAuxMov Then
      Begin
        strTipoChave           := dadosGerais.fTipoChaveReferenciada('IF', '');
        strModeloDocFiscalIF   := '2D'; //"2D" - quando se tratar de Cupom Fiscal (emitido por ECF)
        strNumOrdSequencialECF := qryDados.FindField('GER_NUMUSU').AsString;
        strNumeroCOO           := qryDados.FindField('GER_NUMCOO').AsString;
        strNumeroSerieECF      := qryDados.FindField('GER_NUMSER').AsString;
      End
      Else If fExisteModeloA1AuxMov Then
      Begin
        strTipoChave         := dadosGerais.fTipoChaveReferenciada('NF', '');
        strChaveAcessoNfe    := '';
        strModeloDocFiscalNF := qryDados.FindField('GER_MODELO').AsString;
        strCnpjEmitente      := qryDados.FindField('GER_CPFCNP').AsString;
        strUfIbgeEmitente    := qryDados.FindField('GER_ESTADO').AsString;
        strSerieFiscal       := qryDados.FindField('GER_SERIE1').AsString;
        strDocumentoFiscal   := qryDados.FindField('GER_NUMERO').AsString;
        strAnoMesEmissao     := qryDados.FindField('GER_MESANO').AsString;
      End;
    End;
  End
  Else
  Begin
    //Preciso definir se o documento é proveniente de uma devolucao ou confirmacao de cupom fiscal
    If (qryDados.FindField('GER_OPCDOC') = Nil) Or
       (fEmptyStr(qryDados.FindField('GER_OPCDOC').AsString)) Or
       (Pos(qryDados.FindField('GER_OPCDOC').AsString, 'DV_CI_OF_GF_OU_OE_EF_FE_NE_NG_BD_') <= 0) Or
       (dadosGerais.blnNfComp And dadosGerais.blnComplementoIcms) Then
    Begin
      Exit;
    End;

    If Not Assigned(qryChavesReferenciadas) Then
    Begin
      qryChavesReferenciadas := fCriaQuery(Nil);

      With qryChavesReferenciadas, SQL Do
      Begin
        Close;
        Clear;

        //Devolução de Venda
        If (qryDados.FieldByName('GER_OPCDOC').AsString = 'DV') Or
           (qryDados.FieldByName('GER_OPCDOC').AsString = 'OF') Or
           (qryDados.FieldByName('GER_OPCDOC').AsString = 'GF') Or
           (qryDados.FieldByName('GER_OPCDOC').AsString = 'OU') Or
           (qryDados.FieldByName('GER_OPCDOC').AsString = 'OE') Or
           (qryDados.FieldByName('GER_OPCDOC').AsString = 'EF') Or
           (qryDados.FieldByName('GER_OPCDOC').AsString = 'FE') Or
           (qryDados.FieldByName('GER_OPCDOC').AsString = 'NE') Or
           (qryDados.FieldByName('GER_OPCDOC').AsString = 'NG') Or
           (qryDados.FieldByName('GER_OPCDOC').AsString = 'BD') Then
        Begin
          Add('SELECT DISTINCT ');
          Add('  FIS_DTAENT AS DTAEMI, ');
          Add('  RIGHT(DET_DOCDEV, 9) AS NUMDOC, ');
          Add('  DET_ESPDEV AS ESPDOC, ');
          Add('  FIS_SERIE_ AS SERIE_, ');
          Add('  DET_EMPDEV AS CODEMP, ');
          Add('  DET_CODCLI AS CODCLI, ');
          Add('  EMP_C_G_C_ AS CGCEMI, ');
          Add('  EMP_CODCID AS CIDEMI, ');
          Add('  FIS_ACESSO AS CHAACE, ');
          Add('  FIS_NUMCOO AS NUMCOO, ');
          Add('  FIS_NUMSER AS NUMSER, ');
          Add('  IFNULL(ECF_NUMUSU,"001") AS SEQECF  ');
          Add('FROM                    ');
          Add('  MOVDET M              ');

          Add('  INNER JOIN CADEMP ON CADEMP.EMP_CODEMP = M.DET_CODEMP ');

          Add('  INNER JOIN CADFIS ON CADFIS.FIS_NUMDOC = M.DET_DOCDEV AND ');
          Add('                       CADFIS.FIS_ESPDOC = M.DET_ESPDEV AND ');
          Add('                       CADFIS.FIS_CODEMP = M.DET_EMPDEV AND ');

          If fCampoExiste('MOVDET', 'DET_SERDEV') Then
            Add('                       CADFIS.FIS_SERIE_ = M.DET_SERDEV AND ');

          Add('                       CONDICAO_CLIENTE                          ');
          Add('                       CADFIS.FIS_TIP_FC = M.DET_TIP_FC     ');

          Add('  LEFT JOIN CADECF ON CADFIS.FIS_NUMSER = CADECF.ECF_NUMSER ');

          Add('WHERE                        ');
          Add('  M.DET_NUMDOC = :NUMDOC   AND ');
          Add('  M.DET_ESPDOC = :ESPDOC   AND ');
          Add('  M.DET_SERIE_ = :SERIE_   AND ');
          Add('  M.DET_CODEMP = :CODEMP   AND ');

          If (SameText(qryDados.FieldByName('GER_OPCDOC').AsString, 'DV')) Or
             (SameText(qryDados.FieldByName('GER_OPCDOC').AsString, 'BD')) Or
             (SameText(qryDados.FieldByName('GER_OPCDOC').AsString, 'NE')) Then
          Begin
            Add('  M.DET_CODCLI = :CODCLI   AND ');
            Add('  M.DET_TIP_FC = "C"       AND ');
          End
          Else
          Begin
            Add('  M.DET_CODFOR = :CODCLI   AND ');
            Add('  M.DET_TIP_FC = "F"       AND ');
          End;

          Add('  DET_DOCDEV IS NOT NULL AND ');
          Add('  DET_ESPDEV IN ("NF", "EL","IF") ');

          qryChavesReferenciadas.SQL.Add('UNION ALL ' + AnsiReplaceStr(qryChavesReferenciadas.SQL.Text, 'MOVDET', 'NOTDET'));

          strSQL := qryChavesReferenciadas.SQL.Text;

          qryChavesReferenciadas.SQL.Text := AnsiReplaceStr(strSQL, 'CONDICAO_CLIENTE', 'CADFIS.FIS_FORCLI = IF(CADFIS.FIS_TIP_FC="C", M.DET_CODCLI, M.DET_CODFOR) AND');

          ParamByName('NUMDOC').AsString := qryDados.FieldByName('GER_NUMDOC').AsString;
          ParamByName('ESPDOC').AsString := qryDados.FieldByName('GER_ESPDOC').AsString;
          ParamByName('SERIE_').AsString := qryDados.FieldByName('GER_SERIE_').AsString;
          ParamByName('CODEMP').AsString := qryDados.FieldByName('GER_CODEMP').AsString;
          ParamByName('CODCLI').AsString := qryDados.FieldByName('GER_CODCLI').AsString;

          Open;

          //Devolucoes quando troca o cliente consumidor
          If IsEmpty And (SameText(qryDados.FieldByName('GER_OPCDOC').AsString, 'DV')) Then
          Begin
            qryChavesReferenciadas.SQL.Text := AnsiReplaceStr(strSQL, 'CONDICAO_CLIENTE', '');

            ParamByName('NUMDOC').AsString := qryDados.FieldByName('GER_NUMDOC').AsString;
            ParamByName('ESPDOC').AsString := qryDados.FieldByName('GER_ESPDOC').AsString;
            ParamByName('SERIE_').AsString := qryDados.FieldByName('GER_SERIE_').AsString;
            ParamByName('CODEMP').AsString := qryDados.FieldByName('GER_CODEMP').AsString;
            ParamByName('CODCLI').AsString := qryDados.FieldByName('GER_CODCLI').AsString;

            Open;
          End;
        End
        //Confirmação de Cupom Fiscal
        Else If qryDados.FieldByName('GER_OPCDOC').AsString = 'CI' Then
        Begin
          Add('SELECT DISTINCT ');
          Add('  FIS_DTAENT AS DTAEMI, ');
          Add('  DET_NUMDOC AS NUMDOC, ');
          Add('  DET_ESPDOC AS ESPDOC, ');
          Add('  FIS_SERIE_ AS SERIE_, ');
          Add('  DET_CODEMP AS CODEMP, ');
          Add('  DET_CODCLI AS CODCLI, ');
          Add('  EMP_C_G_C_ AS CGCEMI, ');
          Add('  EMP_CODCID AS CIDEMI, ');
          Add('  FIS_ACESSO AS CHAACE, ');
          Add('  FIS_NUMCOO AS NUMCOO, ');
          Add('  FIS_NUMSER AS NUMSER, ');
          Add('  IFNULL(ECF_NUMUSU,"001") AS SEQECF  ');
          Add('FROM                    ');
          Add('  MOVDET                ');

          Add('  INNER JOIN CADEMP ON CADEMP.EMP_CODEMP = MOVDET.DET_CODEMP ');

          Add('  INNER JOIN CADFIS ON CADFIS.FIS_NUMDOC = MOVDET.DET_NUMDOC AND ');
          Add('                       CADFIS.FIS_ESPDOC = MOVDET.DET_ESPDOC AND ');
          Add('                       CADFIS.FIS_SERIE_ = MOVDET.DET_SERIE_ AND ');
          Add('                       CADFIS.FIS_CODEMP = MOVDET.DET_CODEMP AND ');
          Add('                       CADFIS.FIS_FORCLI = MOVDET.DET_CODCLI AND ');
          Add('                       CADFIS.FIS_TIP_FC = MOVDET.DET_TIP_FC     ');

          Add('  LEFT JOIN CADECF ON CADFIS.FIS_NUMSER = CADECF.ECF_NUMSER ');

          Add('WHERE                        ');
          Add('  DET_NUMFAT = :NUMDOC   AND ');
          Add('  DET_TIPFAT = :ESPDOC   AND ');

          If fCampoExiste('MOVDET', 'DET_SERFAT') Then
            Add('  DET_SERFAT = :SERDOC AND ');

          Add('  DET_EMPFAT = :CODEMP   AND ');
          Add('  DET_CLIFAT = :CODCLI   AND ');
          Add('  DET_TIP_FC = "C"       AND ');
          Add('  DET_ESPDOC = :ESPREF   AND ');
          Add('  (FIS_NUMCOO IS NOT NULL OR FIS_ACESSO IS NOT NULL) ');

          Add(' UNION ALL ' + AnsiReplaceStr(Text, 'MOVDET','NOTDET'));

          Add('ORDER BY                     ');
          Add('  NUMDOC                     ');

          //Tenta por IF
          ParamByName('ESPREF').AsString := 'IF';
          ParamByName('NUMDOC').AsString := qryDados.FieldByName('GER_NUMDOC').AsString;
          ParamByName('ESPDOC').AsString := qryDados.FieldByName('GER_ESPDOC').AsString;
          If fCampoExiste('MOVDET', 'DET_SERFAT') Then
            ParamByName('SERDOC').AsString  := qryDados.FieldByName('GER_SERIE_').AsString;
          ParamByName('CODEMP').AsString := qryDados.FieldByName('GER_CODEMP').AsString;
          ParamByName('CODCLI').AsString := qryDados.FieldByName('GER_CODCLI').AsString;
          Open;

          If IsEmpty Then
          Begin
            //Tenta por IV
            Close;
            ParamByName('ESPREF').AsString := 'IV';
            ParamByName('NUMDOC').AsString := qryDados.FieldByName('GER_NUMDOC').AsString;
            ParamByName('ESPDOC').AsString := qryDados.FieldByName('GER_ESPDOC').AsString;
            If fCampoExiste('MOVDET', 'DET_SERFAT') Then
              ParamByName('SERDOC').AsString  := qryDados.FieldByName('GER_SERIE_').AsString;
            ParamByName('CODEMP').AsString := qryDados.FieldByName('GER_CODEMP').AsString;
            ParamByName('CODCLI').AsString := qryDados.FieldByName('GER_CODCLI').AsString;
            Open;
          End;
        End;
      End;
    End;

    With qryChavesReferenciadas Do
    Begin
      First;
      While Not Eof Do
      Begin
        pRetornaDadosIbge(FieldByName('CIDEMI').AsString, strCodIbge, strUfIbge, strEstado, strCidade);

        SetLength(dadosGerais.arrChavesReferenciadas, Length(dadosGerais.arrChavesReferenciadas) + 1);
        dadosGerais.arrChavesReferenciadas[Length(dadosGerais.arrChavesReferenciadas) - 1] := TChaveReferenciada.Create;

        With dadosGerais.arrChavesReferenciadas[Length(dadosGerais.arrChavesReferenciadas) - 1] Do
        Begin
          strTipoChave := dadosGerais.fTipoChaveReferenciada(FieldByName('ESPDOC').AsString, FieldByName('CHAACE').AsString);

          If (FieldByName('ESPDOC').AsString <> 'IF') Or (strTipoChave = DOCUMENTO_REF_NFCE) Then
          Begin
            strChaveAcessoNfe    := FieldByName('CHAACE').AsString;
            strModeloDocFiscalNF := '01';
            strCnpjEmitente      := FieldByName('CGCEMI').AsString;

            If fVersao310(Self, '55') Then
              strUfIbgeEmitente    := strEstado
            Else
              strUfIbgeEmitente  := strUfIbge;

            strSerieFiscal       := FieldByName('SERIE_').AsString;
            strDocumentoFiscal   := FieldByName('NUMDOC').AsString;
            strAnoMesEmissao     := FormatDateTime('YYMM', FieldByName('DTAEMI').AsDateTime);
          End
          Else
          Begin
            strModeloDocFiscalIF   := '2D'; //"2D" - quando se tratar de Cupom Fiscal (emitido por ECF)
            strNumOrdSequencialECF := FieldByName('SEQECF').AsString;
            strNumeroCOO           := FieldByName('NUMCOO').AsString;
            strNumeroSerieECF      := FieldByName('NUMSER').AsString;
          End;
        End;

        Next;
      End;
    End;
  End;
end;

function TFonteDadosBDEnt.fRetornaInscSubstitutoTributarioEmpresa(strEmpresa, strEstadoDestino: String): String;
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryAux := fCriaQuery(Nil);
  Try
    qryAux.SQL.Add('SELECT ');
    qryAux.SQL.Add('  EMP_INSSUB ');
    qryAux.SQL.Add('FROM ');
    qryAux.SQL.Add('  EMPISB ');
    qryAux.SQL.Add('WHERE ');
    qryAux.SQL.Add('  EMP_CODEMP = :CODEMP AND  ');
    qryAux.SQL.Add('  EMP_ESTADO = :ESTADO      ');

    qryAux.ParamByName('CODEMP').AsString := strEmpresa;
    qryAux.ParamByName('ESTADO').AsString := strEstadoDestino;
    qryAux.Open;

    Result := qryAux.FieldByName('EMP_INSSUB').AsString;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TFonteDadosBDEnt.fBuscaAlqIBPT(strNcm: String; blnImport: Boolean): Double;
Var
  qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  strSQL: String;
begin
  Try
    Result := 0;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  IBP_ALQNAC, ';
    strSQL := strSQL + '  IBP_ALQIMP ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADIBP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  IBP_N_C_M_ = :NCM';

    qryAux := fCriaQuery(Nil);
    qryAux.Close;
    qryAux.SQL.Text := strSQL;
    qryAux.ParamByName('NCM').AsString := strNcm;
    qryAux.Open;

    If qryAux.IsEmpty Then
    Begin
      qryAux.Close;
      qryAux.ParamByName('NCM').AsString := LeftStr(strNcm,4);
      qryAux.Open;
    End;

    If qryAux.IsEmpty Then
    Begin
      qryAux.Close;
      qryAux.ParamByName('NCM').AsString := LeftStr(strNcm,2);
      qryAux.Open;
    End;

    If Not qryAux.IsEmpty Then
    Begin
      If blnImport Then
        Result := qryAux.FieldByName('IBP_ALQIMP').AsFloat
      Else
        Result := qryAux.FieldByName('IBP_ALQNAC').AsFloat;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TFonteDadosBDEnt.fRetornaPercetualDevolvido(qryDados: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND}): Double;
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryAux := fCriaQuery(Nil);
  Try
    qryAux.SQL.Add(' SELECT SUM(DET_TOTITE-DET_DESESP) AS TOTAL ');
    qryAux.SQL.Add('   FROM MOVDET ');
    qryAux.SQL.Add('  WHERE DET_NUMDOC = :NUMDOC ');
    qryAux.SQL.Add('    AND DET_ESPDOC = :ESPDOC ');
    qryAux.SQL.Add('    AND DET_CODEMP = :CODEMP ');

    If (qryDados.FieldByName('FIS_TIP_FC').AsString = 'C') Then
      qryAux.SQL.Add('  AND DET_CODCLI = :CODCLI ')
    Else
      qryAux.SQL.Add('  AND DET_CODFOR = :CODCLI ');

    qryAux.SQL.Add('    AND DET_SERIE_ = :SERIE_ ');
    qryAux.SQL.Add('    AND DET_TIP_FC = :TIP_FC ');
    qryAux.SQL.Add('    AND DET_CODITE = :CODITE ');

    qryAux.ParamByName('NUMDOC').AsString := qryDados.FieldByName('DET_DOCDEV').AsString;
    qryAux.ParamByName('ESPDOC').AsString := qryDados.FieldByName('DET_ESPDEV').AsString;
    qryAux.ParamByName('CODEMP').AsString := qryDados.FieldByName('DET_EMPDEV').AsString;
    qryAux.ParamByName('CODCLI').AsString := qryDados.FieldByName('FIS_FORCLI').AsString;

    If fCampoExiste('MOVDET', 'DET_SERDEV') Then
      qryAux.ParamByName('SERIE_').AsString := qryDados.FieldByName('DET_SERDEV').AsString
    Else
      qryAux.ParamByName('SERIE_').AsString := qryDados.FieldByName('FIS_SERIE_').AsString;

    qryAux.ParamByName('TIP_FC').AsString := qryDados.FieldByName('FIS_TIP_FC').AsString;
    qryAux.ParamByName('CODITE').AsString := qryDados.FieldByName('DET_CODITE').AsString;

    qryAux.Open;

    Result := 0;

    If qryAux.FieldByName('TOTAL').AsFloat > 0 Then
    Begin
      Result := (qryDados.FieldByName('DET_TOTITE').AsFloat - qryDados.FieldByName('DET_DESESP').AsFloat) /
                qryAux.FieldByName('TOTAL').AsFloat;
      Result := fFormataFloat(Result * 100, 2);
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TFonteDadosBDEnt.pCarregaDuplicatasCND(strTabela, strAutoincrem:String);
Var qryCND: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    intIndex: Integer;
Begin
  FillChar(arrDuplicataCND, SizeOf(arrDuplicataCND), #0);
  qryCND := fCriaQuery(Nil);
  Try
    With qryCND Do
    Begin
      SQL.Clear;

      If (Pos(strTabela, 'MOVGER_MOVDET_') > 0) Then
      Begin
        SQL.Add('SELECT GER_PARCEL, GER_VALPAR FROM GERCND INNER JOIN MOVGER ON GERCND.GER_SEQGER = MOVGER.AUTOINCREM');
        SQL.Add(' WHERE MOVGER.AUTOINCREM = :AUTOINCREM               ');
      End
      Else
      Begin
        SQL.Add('SELECT GER_PARCEL, GER_VALPAR FROM NOTCND INNER JOIN NOTGER ON NOTCND.GER_SEQGER = NOTGER.AUTOINCREM');
        SQL.Add(' WHERE NOTGER.AUTOINCREM = :AUTOINCREM               ');
      End;
      SQL.Add('ORDER BY GER_PARCEL');

      ParamByName('AUTOINCREM').AsString := strAutoincrem ;
      Open;
      First;

      intIndex := 0;
      While Not Eof do
      Begin
        arrDuplicataCND[intIndex].strSequen := FieldByName('GER_PARCEL').AsString;
        arrDuplicataCND[intIndex].curValor  := fFormataFloat(FieldByName('GER_VALPAR').AsFloat, 2);
        Inc(intIndex);

        Next;
      End;
    End;
  Finally
    FreeAndNil(qryCND);
  End;
End;

procedure TFonteDadosBDEnt.pSalvarXMLNFeBD(AChaveAcesso, AXML: string; AXMLJaBaixado: String = '');
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    blnSalvar: Boolean;
begin
  pLogImp('TFonteDadosBDEnt.pSalvarXMLNFeBD >');

  If (Not fCampoExiste('XMLNFE', 'NFE_ACESSO')) Then
  Begin
    pLogImp('TFonteDadosBDEnt.pSalvarXMLNFeBD < NÃO EXISTE XMLNFE-NFE_ACESSO');
    Exit;
  End;

  If (Not fCampoExiste('XMLNFE', 'NFE_ARQXML')) Then
  Begin
    pLogImp('TFonteDadosBDEnt.pSalvarXMLNFeBD < NÃO EXISTE XMLNFE-NFE_ARQXML');
    Exit;
  End;

  If fEmptyStr(AChaveAcesso) Then
  Begin
    pLogImp('TFonteDadosBDEnt.pSalvarXMLNFeBD < AChaveAcesso='' > Exit;');
    Exit;
  End;

  qryAux := fCriaQuery(Nil);
  Try
    With qryAux Do
    Begin
      blnSalvar := (AXMLJaBaixado <> 'S');

      If (AXMLJaBaixado = '') Then
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT COUNT(1) AS QTD FROM XMLNFE ');
        SQL.Add(' WHERE NFE_ACESSO = :CHV           ');
        ParamByName('CHV').AsString := AChaveAcesso;
        Open;

        blnSalvar := (FieldByName('QTD').AsInteger = 0);
      End;

      If (blnSalvar) Then
      Begin
        Close;
        SQL.Clear;
        SQL.Add('INSERT INTO XMLNFE      ');
        SQL.Add('   SET NFE_ARQXML :XML, ');
        SQL.Add('       NFE_ACESSO :CHV; ');
        ParamByName('CHV').AsString := AChaveAcesso;
        ParamByName('XML').AsString := AXML;
        ExecSQL;
      End
      Else
      Begin
        pLogImp('XMLNFE JÁ SALVA');
      End;
    End;
  Finally
    FreeAndNil(qryAux);
  End;

  pLogImp('TFonteDadosBDEnt.pSalvarXMLNFeBD <');
end;

function TFonteDadosBDEnt.XMlJaBaixado(AChaveAcesso: string): Boolean;
var
  qryXML : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin

  qryXML := fCriaQuery(nil);
  try
    qryXML.Close;
    qryXML.SQL.Clear;
    qryXML.SQL.Add('SELECT * FROM XMLNFE WHERE NFE_ACESSO = :ACESSO');
    qryXML.ParamByName('ACESSO').AsString := AChaveAcesso;
    qryXML.Open;
    qryXML.First;

    if qryXML.IsEmpty or qryXML.FieldByName('NFE_ARQXML').IsNull then
      Result := False
    else
      Result := True;
  finally
    qryXML.free;
  end;
end;

function TFonteDadosBDEnt.fNFSemItens: Boolean;
var
  qryAux : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin

  qryAux := fCriaQuery(nil);
  Try
    with qryAux do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT COUNT(*) QTD FROM MOVGER ');
      SQL.Add('WHERE                           ');
      SQL.Add('  GER_NUMDOC = :NUMDOC AND      ');
      If FTip_FC = 'F' Then
        SQL.Add('  GER_CODFOR = :CODCLI AND    ')
      Else
        SQL.Add('  GER_CODCLI = :CODCLI AND    ');
      SQL.Add('  GER_ESPDOC = :ESPDOC AND      ');
      SQL.Add('  GER_CODEMP = :CODEMP AND      ');
      SQL.Add('  IFNULL(GER_SERIE_, "") = :SERIE_ ');

      ParamByName('NUMDOC').AsString := FNumDoc;
      ParamByName('ESPDOC').AsString := FEspDoc;
      ParamByName('CODEMP').AsString := FCodEmp;
      ParamByName('CODCLI').AsString := FCodCli;
      ParamByName('SERIE_').AsString := FSerie;

      Open;

      Result := FieldByName('QTD').AsInteger = 0;

      qryAux.Close;
    end;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TFonteDadosBDEnt.pNFCeOffLineConfiguracoes(strCodEmp: String);
Begin
//
End;

procedure TFonteDadosBDEnt.pGravaIcmsDesonerado(strTabela, strAutInc, strMtdIcm: String; fltIcmDes: Double);
Begin
  //
End;

function TFonteDadosBDEnt.PDFJaBaixado(AChaveAcesso: string): Boolean;
begin
  Result := False;
end;

procedure TFonteDadosBDEnt.pSalvarPDFNFeBD(AChaveAcesso, APDF: string; APDFJaBaixado: String = '');
begin
//
end;

function TFonteDadosBDEnt.fUsaNotaServicoEletronicaEnotas: Boolean;
begin
  Result := False;
end;

function TFonteDadosBDEnt.GetTemPerfilAduaneiro: Boolean;
begin
  Result := False;
end;

function TFonteDadosBDEnt.CarregarPDF(AChaveAcesso, ANomeArquivo: string; AExtensao: Boolean; AIgnorarLayoutSimplificado: Boolean): string;
begin
//
end;

procedure TFonteDadosBDEnt.pGravarLogNfe(strNumDoc, strEspDoc, strCodEmp, strSerie,
                                         strCodCli, strTip_FC, strStatus, strObserv: String;
                                         strChaAce: String=''; dtaDtaAut: TDateTime=0; strPonImp: String='');
begin
//
end;

function TFonteDadosBDEnt.fRetornaDocumentoImpresso(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC: String): Boolean;
begin
  Result := False;
end;

procedure TFonteDadosBDEnt.pGravaDocumentoImpresso(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC: String);
begin
//
end;

procedure TFonteDadosBDEnt.pGravaDocumentoPainelCitel(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, strProtoc, strTipInt: String);
begin
//
end;

procedure TFonteDadosBDEnt.pSalvarXmlDfeBD(ATipDfe, AChaveAcesso, AProtocolo, AXml: string);
begin
//
end;

procedure TFonteDadosBDEnt.pSetaIndicadorIntegracaoCitel(const AstrIntegradorCitel: String);
begin
//
end;

procedure TFonteDadosBDEnt.pSetaPathSatCitel(const AstrPathSatCitel: String);
begin
//
end;

procedure TFonteDadosBDEnt.pGravarLogFit(strNumDoc, strEspDoc, strCodEmp, strSerie_, strForCli, strTip_FC, strTipArq, strArquiv: String);
begin
//
end;

{$IF Defined(UNIDAC)}
function TFonteDadosBDEnt.fRetDataBase: TUniConnection;
begin
  Result := Self.DataBase;
end;
{$IFEND}

initialization

finalization

end.
