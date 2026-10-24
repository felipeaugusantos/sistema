unit Fulfillment.Classes.NotasFulfillment;

interface

uses StrUtils, SysUtils, Uni, DB, Classes, Variants,
     UniClientDataSet, cxProgressBar,
     untGravando, System.Zip,
     cxGridDBTableView,
     XMLDoc,
     XMLIntf,
     Fulfillment.Classes.NotasFulfillment.InsertsInBatch;

Type
  TRecMarketplace = Record
    strSigla: String;
    strNome: String;
  end;

Const
  intNaoEncontrada = 1;
  intEncontrada    = 2;
  intCanceladoXML_NaoCancaladaLivro = 3;
  intFaltante      =  4;
  intNaoEncontradaPelaChaveMasEncontradaPeloNumero = 5;

  NFE_AUTORIZADA = 'Autorizado o uso da NF-e';

  TArrMarketplace: Array[1..7] Of TRecMarketplace = (
    (strSigla: 'MLB'; strNome: 'Mercado Livre'),
    (strSigla: 'B2W'; strNome: 'B2W'),
    (strSigla: 'MGL'; strNome: 'Magalu'),
    (strSigla: 'VRJ'; strNome: 'Via Varejo'),
    (strSigla: 'OLI'; strNome: 'Olist'),
    (strSigla: 'AMZ'; strNome: 'Amazon'),
    (strSigla: 'SHP'; strNome: 'Shopee')
  );

Type
  tipoXml = (tpxNaoIdentificado,
             tpxInutilizacao,
             tpxAutorizacao,
             tpxCancelamento,
             tpxDuplicidadeEvento,
             tpxDuplicidadeNFe);

  TZipeFiles = Record
    strNomeArq: String;
    blnAberto: Boolean;
    zipFile: TZipFile;
  End;

  TNotaFaltante = Record
    strNumDoc: String;
    strCodEmp: String;
    strSerie_: String;
  End;

  TArrNotasFaltantes = Array Of TNotaFaltante;

  TArrNotasFaltantesHelper = Record Helper For TArrNotasFaltantes
  Public
    procedure Add(const ANumDoc, ACodEmp, ASerie_: String);
    function Find(const ANumDoc, ACodEmp, ASerie_: String; out AIndex: Integer): Boolean;
  End;

  TNotasFulfillment = Class(TComponent)
  Private

    FcxvNotas: TcxGridDBTableView;
    FFullNameArq: String;

    FEmpresa,
    FSerie,
    FPasta: String;

    FHubMkpPrefix: String;
    FHUbMkpDescricao: String;
    FMkpIdentificado: String;

    FZips: Array Of TZipeFiles;

    FNotasAuxilar: TUniClientDataSet;

    FListaKey: TStringList;
    FListaNotasFaltantes: TArrNotasFaltantes;
    FListaMotivosIgnorar: TStringList;
    FListaArquivosVazios: TStringList;
    FNotasAReprocessar: TStringList;

    FfrmGravando: TfrmGravando;

    procedure pSelecionarHubMarketplace;
    function fValidaMarketplacesArqSelecionados: Boolean;
    function fIdentificaMarketplaceNoXml(const strNomArq: String): String;
    function fSiglaMkpToNome(const strSiglaMkp: String): String;

    function fEhXmlAntigo(const LXmlNFe: String): Boolean;
    function fEhEventoDeCancelamento(const LXmlNFe, LEvento, LDescEvento, LJustif, LMotivo: String): Boolean;
    function fRetornaTipoImportacao(const AXmlFile, LMotivo, LXmlNFe, LEvento, LDescEvento, LJustif: String): tipoXml;
    function fRetornaEmpDocXml(const LCnpj_E, LCnpj_D: String): String;
    function fRetornaCnpjEmitenteXml(const LXmlNFe: String): String;
    function fDataEmissaoCancelamento(const LXmlNFe: String): String;
    function fGetCodEmp(const strCNPJ: String): String;

    Function fNoInicialNota(xmlDoc: TXMLDocument): IXMLNode;
    Function fGetResult(xmlNo: IXMLNode): String;
    Function fRetCNPJEmpresaXML(const strArqXml, strNomArq: String): String;

    Function fSQLCadFis(const blnBuscaPeloCodigo: Boolean): String;

    Procedure pOpenZip;

    procedure pCriaDataSetNotas(ADataSet: TUniClientDataSet);

    Function fBuscaZip(const strNomArq: String; Var intIndice: Integer): TZipFile;

    Function fExportaNotasCSVPrg(cxgProgresso: TCxProgressBar): Boolean;
    Function fOpenSelecionadosPrg(cxProgresso: TCxProgressBar): Boolean;
    Function fCarregaArquivosZipPrg(cxgProgresso: TCxProgressBar): Boolean;
    Function fCarregaArquivosXMLPrg(cxgProgresso: TCxProgressBar): Boolean;
    Procedure pIncluiRegistro(const strNomArq, strSoNomqArq: String; const intIndiceZip, intIndiceXml: Integer);
    Procedure pIncluiRegistroInutilizadas(const strNomArq, strSoNomqArq: String; const intIndiceZip, intIndiceXml: Integer);

    function fNormalizaTexto(const strTexto: String): String;
    procedure pIncluiMotivosIgnorar(const strMotivo: String);

    Procedure pAtualizaUmaNota(qryCadFis: TUniQuery; const intStatus: Integer);

    Procedure pLiberaZipFiles;

    Function fCarregaCadFis(const blnExibirProgresso: Boolean = True): Boolean;

    Procedure pGeraNotasFaltantes(qryCadFis: TUniQuery; strNotaAnterior: String; Var blnProcessouNotaAnterior: Boolean);

    Function fBuscaDocumentos: Boolean;

    Function fIncluiFaltantes: Boolean;

    Function fFiltraNotasInconsistentes: Boolean;

    Procedure pAtualizaDadosNota(qryCadFis: TUniQuery);

    Function fFullNameFile(const strNomPat, strNomArq: String): String;

    Function fEhDocumentoCancelado(const strArqXml, strNomArq: String): Boolean;

    Function fBuscaNaoEncontradasPeloNumero: Boolean;

    Procedure pExtraiDadosChave(const strKeyAce: String; Var strNumDoc, strSerDoc: String);

    Function fDescricaoStatus(const intStatus: Integer): String;

    function fMagaluCanceladaNaoEncontrada: Boolean;

    function fProcessarMotivo(const AXmlNfe: String): String;

    function fGetQuantArquivos(AZipFile: TZipFile): Integer;

    function fLeConteudoArquivo(const intIndiceZip, intIndiceXml: Integer): String;

    function fSerieNaoDeveGravar(const strCodEmp, strSerie: String; const blnDevolucao: Boolean; var strSerCfg: String): Boolean;

    function fProcessarXmlParaInserirNFeImp(const ANomArq, AXmlFile: String; out AMensagem: String): Boolean;

    function fAjustaNumCCDAmazon(const ATexto: String): String;

    procedure pFiltraNotas;

    function fExisteItensComLote(const AXML, ACodEmp: String): Boolean;

  Public
    cdsNotas,
    cdsInconsistencias,
    cdsArquivosZip: TUniClientDataSet;

    FInsertsInBatch: TInsertsInBatchNFEIMP;

    property strHubMkpPrefix: String read FHubMkpPrefix;
    property strHUbMkpDescricao: String read FHUbMkpDescricao;

    Constructor Create(Owner: TComponent); Override;
    Destructor  Destroy; Override;

    Function fExportaNotasCSV(cxvNotas: TcxGridDBTableView; strFullNameArq: String): Boolean;

    Function fImportarNotaParaTabelaNFeImp(ADataSet: TDataSet; out AMensagem: String): Boolean;

    Function fCarregaArquivosZip(strPasta: String): Boolean;

    Function fCarregaArquivosXML: Boolean;

    Function fTemArquivoSelecionado: Boolean;

    Procedure pOpenSelecionados;

    Function fExtraiArquivo(blnMostraArquivo: Boolean; strNomPat, strNomArq: String; intIndiceZip: Integer = -999): Boolean;

    Procedure pReprocessaNotasComErro;
  End;

implementation

uses
  untRegraImportacaoNFEIMP, untMemo, Fulfillment.RegrasMovimentacaoEstoque,
  Fulfillment.Classes.Comandos, untCadLote, untFuncoesSimples;

procedure ReenviaDocumentosParaProcessamento(AChaves: TStrings);
  Var
    LQuery: TUniQuery;
begin
  If AChaves.Count = 0 Then
    Exit;

  LQuery := fCriaQuery;
  Try
    Try
      LQuery.SQL.Add('UPDATE NFEIMP');
      LQuery.SQL.Add('  SET NFE_IMPORT = "N"');
      LQuery.SQL.Add('WHERE NFE_ACESSO IN ('+ AChaves.CommaText +')');
      LQuery.SQL.Add('  AND NFE_IMPORT = "E"');
      LQuery.ExecSQL;

      LQuery.Close;
      LQuery.SQL.Clear;
      LQuery.SQL.Add('DELETE FROM FULL_LOGERR');
      LQuery.SQL.Add('WHERE LOG_ACESSO IN ('+ AChaves.CommaText +')');
      LQuery.ExecSQL;
    Except
      On E: Exception Do
        Raise Exception.Create(E.Message);
    End;
  Finally
    FreeAndNil(LQuery);
  End;
end;

function SiglaMagaluMovEstoque(const AxPed: String): boolean;
var
  arrSiglas: TArray<String>;
  strValCfg, strSigla: String;
begin
  Result := False;

  if fEmptyStr(AxPed) then
    Exit;

  strValCfg := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_MGLSIG'], False);

  if fEmptyStr(strValCfg) then
    Exit;

  arrSiglas := strValCfg.Split([',']);

  for strSigla in arrSiglas do
    if AnsiUpperCase(AxPed.Trim).StartsWith(strSigla.Trim) then
      Exit(True);
end;

function DocumentoExisteNaNfeImp(const AAcesso, AStatus: String): Boolean;
begin
  Result := fCampoTabela('COUNT(1)', 'NFEIMP', ['NFE_ACESSO', 'NFE_STATUS'], [AAcesso, AStatus]) > 0;
end;

constructor TNotasFulfillment.Create(Owner: TComponent);
begin
  inherited;

  cdsNotas := TUniClientDataSet.Create(Self);
  pCriaDataSetNotas(cdsNotas);

  cdsInconsistencias := TUniClientDataSet.Create(Self);
  pCriaDataSetNotas(cdsInconsistencias);

  FInsertsInBatch := TInsertsInBatchNFEIMP.New;

  SetLength(FZips, 0);

  FListaKey := TStringList.Create;

  SetLength(FListaNotasFaltantes, 0);

  FListaMotivosIgnorar := TStringList.Create;

  FListaArquivosVazios := TStringList.Create;
  FListaArquivosVazios.Delimiter := #13;
  FListaArquivosVazios.QuoteChar := #0;

  FNotasAReprocessar := TStringList.Create;
  FNotasAReprocessar.Sorted     := True;
  FNotasAReprocessar.Duplicates := dupIgnore;

  try
    VS_ExisteTabelaFULL_COMAND := fTabelaExiste('FULL_COMAND');
  except
    VS_ExisteTabelaFULL_COMAND := False;
  end;

  pIncluiMotivosIgnorar('Rejeicao: Falha na Consulta do Registro de Passagem, tente novamente apos 5 minutos');

  cdsArquivosZip := TUniClientDataSet.Create(Self);
  cdsArquivosZip.FieldDefs.Add('NOMARQ', ftString, 100);
  cdsArquivosZip.FieldDefs.Add('MARCAD', ftString, 1);
  cdsArquivosZip.FieldDefs.Add('QTDARQ', ftInteger);
  cdsArquivosZip.CreateDataSet;
  cdsArquivosZip.LogChanges := False;

  FNotasAuxilar := TUniClientDataSet.Create(Self);
  FNotasAuxilar.FieldDefs.Add('NUMDOC', ftString, 12);
  FNotasAuxilar.FieldDefs.Add('KEYACE', ftString, 50);
  FNotasAuxilar.CreateDataSet;
  FNotasAuxilar.LogChanges := False;
end;

destructor TNotasFulfillment.Destroy;
begin
  FreeAndNil(FInsertsInBatch);
  FreeAndNil(FListaKey);
  FreeAndNil(FListaMotivosIgnorar);
  FreeAndNil(FListaArquivosVazios);
  FreeAndNil(FNotasAReprocessar);
  FreeAndNil(cdsNotas);
  FreeAndNil(cdsArquivosZip);
  FreeAndNil(FNotasAuxilar);

  pLiberaZipFiles;

  inherited;
end;

procedure TNotasFulfillment.pCriaDataSetNotas(ADataSet: TUniClientDataSet);
begin
  ADataSet.FieldDefs.Add('INDZIP', ftInteger);
  ADataSet.FieldDefs.Add('INDXML', ftInteger);
  ADataSet.FieldDefs.Add('NOMARQ', ftString, 100);
  ADataSet.FieldDefs.Add('NOMPAT', ftString, 500);
  ADataSet.FieldDefs.Add('STATUS', ftInteger);
  ADataSet.FieldDefs.Add('NFESTS', ftString, 2);
  ADataSet.FieldDefs.Add('ENCONT', ftString, 1);
  ADataSet.FieldDefs.Add('DTAEMI', ftDate);
  ADataSet.FieldDefs.Add('NUMDOC', ftString, 12);
  ADataSet.FieldDefs.Add('ESPDOC', ftString, 2);
  ADataSet.FieldDefs.Add('CODEMP', ftString, 3);
  ADataSet.FieldDefs.Add('SERIE_', ftString, 3);
  ADataSet.FieldDefs.Add('CODCLI', ftString, 8);
  ADataSet.FieldDefs.Add('NOMCLI', ftString, 60);
  ADataSet.FieldDefs.Add('HISTOR', ftString, 60);
  ADataSet.FieldDefs.Add('KEYACE', ftString, 50);
  ADataSet.FieldDefs.Add('CGCEMP', ftString, 14);
  ADataSet.FieldDefs.Add('VLRCON', ftFloat);

  ADataSet. CreateDataSet;
  ADataSet.LogChanges := False;

  ADataSet.FieldByName('DTAEMI').Alignment := taCenter;
  ADataSet.FieldByName('NUMDOC').Alignment := taCenter;
  ADataSet.FieldByName('ESPDOC').Alignment := taCenter;
  ADataSet.FieldByName('CODEMP').Alignment := taCenter;
  ADataSet.FieldByName('SERIE_').Alignment := taCenter;
  ADataSet.FieldByName('CODCLI').Alignment := taCenter;
  ADataSet.FieldByName('KEYACE').Alignment := taCenter;
end;

procedure TNotasFulfillment.pSelecionarHubMarketplace;
Var
  LIndex: Integer;
  LSugestao: Integer;
  LArrMkp: Array Of String;
begin
  LSugestao := 1;

  SetLength(LArrMkp, Length(TArrMarketplace));

  For LIndex := Low(TArrMarketplace) To High(TArrMarketplace) Do
  Begin
    LArrMkp[LIndex -1] := TArrMarketplace[LIndex].strNome;

    If TArrMarketplace[LIndex].strSigla = FMkpIdentificado Then
      LSugestao := LIndex;
  End;

  LIndex := fGetMenu('Marketplace dos arquivos XML:', LArrMkp, LSugestao);

  If LIndex < Low(TArrMarketplace) Then
    Exit;

  If LIndex > High(TArrMarketplace) Then
    Exit;

  FHubMkpPrefix    := TArrMarketplace[LIndex].strSigla;
  FHUbMkpDescricao := TArrMarketplace[LIndex].strNome;
end;

Function TNotasFulfillment.fCarregaArquivosZip(strPasta: String): Boolean;
Begin
  FPasta := strPasta;

  If Not EndsStr('\', FPasta)  Then
    FPasta := Concat(FPasta, '\');

  Result := TfrmGravando.fExecuta(fCarregaArquivosZipPrg, FfrmGravando, 'Lendo pasta de arqruivos, aguarde...');
End;

Procedure TNotasFulfillment.pLiberaZipFiles;
  Var
    intContador: Integer;
Begin
  For intContador := Low(FZips) To High(FZips) Do
  Begin
    FZips[intContador].zipFile.Close;
    FreeAndNil(FZips[intContador].zipFile);
  End;

  SetLength(FZips, 0);
End;

Procedure TNotasFulfillment.pOpenZip;
  Var
    intContador: Integer;
    strNomArq: String;
Begin

  strNomArq := cdsArquivosZip.FieldByName('NOMARQ').AsString;

  For intContador := Low(FZips) To High(FZips) Do
    If SameText(FZips[intContador].strNomeArq, strNomArq) Then
    Begin

      If Not FZips[intContador].blnAberto Then
      Begin
        FfrmGravando.pgbStatus.Position := 0;
        FfrmGravando.pgbStatus.Visible := False;
        FfrmGravando.lblGravando.Caption := Concat('Carregando arquivos de ', strNomArq, ', aguarde...');
        pProcessMessages;

        FZips[intContador].zipFile.Open(Concat(FPasta, strNomArq), zmRead);
        FZips[intContador].blnAberto := True;

        cdsArquivosZip.Edit;
        //foi usada a função abaixo porque ZipFile.FileCount também considera pastas dentro do zip
        cdsArquivosZip.FieldByName('QTDARQ').AsInteger := fGetQuantArquivos(FZips[intContador].zipFile);
        cdsArquivosZip.Post;

        FfrmGravando.pgbStatus.Visible := True;
      End;

      Break;
    End;
End;

Function TNotasFulfillment.fCarregaArquivosZipPrg(cxgProgresso: TCxProgressBar): Boolean;
  Var
    srcArquivo: TSearchRec;
    intAchou  : Integer;
Begin

  Try

    Try
      pLiberaZipFiles;

      cdsArquivosZip.DisableControls;
      cdsArquivosZip.EmptyDataSet;

      intAchou := FindFirst(FPasta + '*.ZIP', faArchive, srcArquivo);

      If intAchou = 0 Then
      begin
        Repeat
          FfrmGravando.lblGravando.Caption := srcArquivo.Name;
          pProcessMessages;

          cdsArquivosZip.Append;
          cdsArquivosZip.FieldByName('NOMARQ').AsString := srcArquivo.Name;
          cdsArquivosZip.FieldByName('MARCAD').AsString := 'S';
          cdsArquivosZip.Post;

        Until FindNext(srcArquivo) <> 0;

      End;

      SetLength(FZips, cdsArquivosZip.RecordCount);

      cxgProgresso.Properties.Max := cdsArquivosZip.RecordCount;

      cdsArquivosZip.First;
      While Not cdsArquivosZip.Eof Do
      Begin
        FZips[Pred(cdsArquivosZip.RecNo)].zipFile    := TZipFile.Create;

        FZips[Pred(cdsArquivosZip.RecNo)].blnAberto  := False;
        FZips[Pred(cdsArquivosZip.RecNo)].strNomeArq := cdsArquivosZip.FieldByName('NOMARQ').AsString;

        cdsArquivosZip.Next;

        pStepStatusGravacao(cxgProgresso);
      End;

      Result := True;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, 'TNotasFulfillment.fCarregaArquivosZip');
        Result := False;
      End;
    End;

  Finally
    cdsArquivosZip.EnableControls;
    FindClose(srcArquivo);
  End;

End;

Function TNotasFulfillment.fCarregaArquivosXML: Boolean;
Begin
  Result := TfrmGravando.fExecuta(fCarregaArquivosXMLPrg, FfrmGravando, 'Extraindo arquivos...');
End;

Function TNotasFulfillment.fBuscaZip(const strNomArq: String; Var intIndice: Integer): TZipFile;
  Var
    intContador: Integer;
Begin
  Result := Nil;

  For intContador := Low(FZips) To High(FZips) Do
    If SameText(strNomArq, FZips[intContador].strNomeArq) Then
    Begin
      Result := FZips[intContador].zipFile;

      intIndice := intContador;

      If Not FZips[intContador].blnAberto Then
        pOpenZip;

      Exit;
    End;

End;

Procedure TNotasFulfillment.pIncluiRegistroInutilizadas(const strNomArq, strSoNomqArq: String; const intIndiceZip, intIndiceXml: Integer);
var
  nNFIni: Integer;
  nNFFin: Integer;
  nNFNro: Integer;
  strXml: String;
  strSerie: String;
  strChave: String;
  strStat: String;
Begin
  If Pos('\Nao_Inutilizadas\', strNomArq) > 0 Then
    Exit;

  strXml := fLeConteudoArquivo(intIndiceZip, intIndiceXml);

  if not strXml.Contains('<nNFIni>') then
    Exit;

  strStat := fExtractBetweenTags(strXML, '<cStat>', '</cStat>').Trim;

  if not strStat.Equals('102') then
    Exit;

  nNFIni := fExtractBetweenTags(strXML, '<nNFIni>', '</nNFIni>').ToInteger;
  nNFFin := fExtractBetweenTags(strXML, '<nNFFin>', '</nNFFin>').ToInteger;

  strSerie := fExtractBetweenTags(strXML, '<serie>', '</serie>').PadLeft(3, '0');
  strChave := LeftStr(fExtractBetweenTags(strXML, 'Id="ID', '"'), 23);

  for nNFNro := nNFIni to nNFFin do
  begin
    cdsNotas.Append;
    cdsNotas.FieldByName('NOMPAT').AsString  := ExtractFilePath(strNomArq);
    cdsNotas.FieldByName('NOMARQ').AsString  := strSoNomqArq;
    cdsNotas.FieldByName('ENCONT').AsString  := 'N';
    cdsNotas.FieldByName('STATUS').AsInteger := intNaoEncontrada;
    cdsNotas.FieldByName('NFESTS').AsString  := 'IN';
    cdsNotas.FieldByName('INDZIP').AsInteger := intIndiceZip;
    cdsNotas.FieldByName('INDXML').AsInteger := intIndiceXml;
    cdsNotas.FieldByName('SERIE_').AsString  := strSerie;
    cdsNotas.FieldByName('NUMDOC').AsString  := nNFNro.ToString.PadLeft(9, '0');
    cdsNotas.FieldByName('CGCEMP').AsString  := fRetCNPJEmpresaXML(strXml, strSoNomqArq);
    cdsNotas.FieldByName('KEYACE').AsString  := strChave +
                                                nNFNro.ToString.PadLeft(9, '0') +
                                                nNFNro.ToString.PadLeft(9, '0') ;

    FNotasAuxilar.Append;
    FNotasAuxilar.FieldByName('NUMDOC').AsString := cdsNotas.FieldByName('NUMDOC').AsString;
    FNotasAuxilar.FieldByName('KEYACE').AsString := cdsNotas.FieldByName('KEYACE').AsString;
    FNotasAuxilar.Post;

    cdsNotas.Post;
  end;

end;

function TNotasFulfillment.fNormalizaTexto(const strTexto: String): String;
begin
  Result := AnsiUpperCase(fRemoveAcentoPontos(strTexto));
end;

function TNotasFulfillment.fValidaMarketplacesArqSelecionados: Boolean;
var
  strSigAtu: String;
begin
  Result := True;

  strSigAtu := EmptyStr;
  cdsArquivosZip.DisableControls;

  Try
    cdsArquivosZip.Filtered := False;
    cdsArquivosZip.Filter   := 'MARCAD = ' + QuotedStr('S');
    cdsArquivosZip.Filtered := True;

    cdsArquivosZip.First;
    While Not cdsArquivosZip.Eof Do
    Begin
      If FMkpIdentificado.IsEmpty Then
        FMkpIdentificado := fIdentificaMarketplaceNoXml(cdsArquivosZip.FieldByName('NOMARQ').AsString)
      Else
      Begin
        strSigAtu := fIdentificaMarketplaceNoXml(cdsArquivosZip.FieldByName('NOMARQ').AsString);

        If (strSigAtu <> '') And (FMkpIdentificado <> strSigAtu) Then
          Exit(False);
      End;

      cdsArquivosZip.Next;
    End;
  Finally
    cdsArquivosZip.Filtered := False;
    cdsArquivosZip.Filter   := '';
    cdsArquivosZip.EnableControls;
  End;
end;

function TNotasFulfillment.fIdentificaMarketplaceNoXml(const strNomArq: String): String;
Var
  UnZipper: TZipFile;
  strXmlNFe, strRespTec, strVerProc: String;
  intIndice, intContador: Integer;
begin
  Result := EmptyStr;

  If strNomArq.IsEmpty Then
    Exit;

  UnZipper := fBuscaZip(strNomArq, intIndice);

  If Not Assigned(UnZipper) Then
    Exit;

  For intContador := 0 To UnZipper.FileCount -1 Do
  Begin
    If UnZipper.FileInfo[intContador].CompressedSize = 0 Then
      Continue;

    strXmlNFe := fLeConteudoArquivo(intIndice, intContador).Replace(#13,'').Replace(#10,'');

    strRespTec := fExtractBetweenTags(fExtractBetweenTags(strXmlNFe, '<infRespTec>','</infRespTec>'), '<email>','</email>').Trim.ToLower;
    strVerProc := fExtractBetweenTags(fExtractBetweenTags(strXmlNFe, '<ide>','</ide>'), '<verProc>','</verProc>').Trim.ToLower;

    If Not strRespTec.IsEmpty Then
    Begin
      If strRespTec.Contains('amazon') Then
        Exit('AMZ');

      If strRespTec.Contains('shopee') Then
        Exit('SHP');

      If strRespTec.Contains('luizalabs') Then
        Exit('MGL');
    End;

    If Not strVerProc.IsEmpty Then
    Begin
      If strVerProc.Contains('mercadolivre') Then
        Exit('MLB');

      If strVerProc.Contains('eldoc') Then
        Exit('MGL');
    End;
  End;
end;

function TNotasFulfillment.fSiglaMkpToNome(const strSiglaMkp: String): String;
Var
  recMkp: TRecMarketplace;
begin
  Result := EmptyStr;

  If strSiglaMkp.IsEmpty Then
    Exit;

  For recMkp In TArrMarketplace Do
  Begin
    If recMkp.strSigla = strSiglaMkp Then
      Exit(recMkp.strNome);
  End;
end;

procedure TNotasFulfillment.pIncluiMotivosIgnorar(const strMotivo: String);
begin
  FListaMotivosIgnorar.Add(fNormalizaTexto(strMotivo));
end;

Procedure TNotasFulfillment.pIncluiRegistro(const strNomArq, strSoNomqArq: String; const intIndiceZip, intIndiceXml: Integer);
Var
  strXmlNFe, strMotivo, strChaAce, strStatusNFe, strNumDoc, strSerDoc: String;
Begin
  Try
    strXmlNFe := fLeConteudoArquivo(intIndiceZip, intIndiceXml);
    strMotivo := fNormalizaTexto(fExtractBetweenTags(strXmlNFe, '<xMotivo>', '</xMotivo>'));
    strChaAce := fExtractBetweenTags(strXmlNFe, '<chNFe>', '</chNFe>');

    If strChaAce.IsEmpty And strXmlNFe.Contains('Id="NFe') Then
      strChaAce := LeftStr(fExtractBetweenTags(strXmlNFe, 'Id="NFe', '"'), 44);

    pExtraiDadosChave(strChaAce, strNumDoc, strSerDoc);

    If (FListaMotivosIgnorar.IndexOf(strMotivo) <> -1) Then
      Exit;
  Except
    Raise;
  End;

  If strSoNomqArq.ToLower.Contains('inut') Or strXmlNFe.Contains('<nNFIni>') Then
  Begin
    pIncluiRegistroInutilizadas(strNomArq, strSoNomqArq, intIndiceZip, intIndiceXml);
    Exit;
  End;

  strStatusNFe := '';
  If SameText(strMotivo, NFE_AUTORIZADA) Then
    strStatusNFe := 'AT';

  cdsNotas.Append;
  cdsNotas.FieldByName('NOMPAT').AsString  := ExtractFilePath(strNomArq);
  cdsNotas.FieldByName('NOMARQ').AsString  := strSoNomqArq;
  cdsNotas.FieldByName('ENCONT').AsString  := 'N';
  cdsNotas.FieldByName('STATUS').AsInteger := intNaoEncontrada;
  cdsNotas.FieldByName('NFESTS').AsString  := strStatusNFe;
  cdsNotas.FieldByName('INDZIP').AsInteger := intIndiceZip;
  cdsNotas.FieldByName('INDXML').AsInteger := intIndiceXml;
  cdsNotas.FieldByName('CGCEMP').AsString  := fRetCNPJEmpresaXML(strXmlNFe, strSoNomqArq);
  cdsNotas.FieldByName('KEYACE').AsString  := strChaAce;
  cdsNotas.FieldByName('SERIE_').AsString  := strSerDoc;
  cdsNotas.FieldByName('NUMDOC').AsString  := strNumDoc;
  cdsNotas.Post;

  If Not fEmptyStr(cdsNotas.FieldByName('KEYACE').AsString) Then
  Begin
    FNotasAuxilar.Append;
    FNotasAuxilar.FieldByName('NUMDOC').AsString := cdsNotas.FieldByName('NUMDOC').AsString;
    FNotasAuxilar.FieldByName('KEYACE').AsString := cdsNotas.FieldByName('KEYACE').AsString;
    FNotasAuxilar.Post;
  End;
End;

Function TNotasFulfillment.fCarregaArquivosXMLPrg(cxgProgresso: TCxProgressBar): Boolean;
  Var
    intIndice,
    intQtdFiles,
    intContador: Integer;
    strArqXml,
    strSoNomqArq,
    strNomArq: String;
    UnZipper: TZipFile;
Begin
  FMkpIdentificado := '';
  FHubMkpPrefix    := '';
  FHUbMkpDescricao := '';

  Try
    If Not fValidaMarketplacesArqSelecionados Then
    Begin
      pMensagemOk('Os arquivos selecionados são de marketplaces diferentes. Importação não permitida!'+ sLineBreak +
                  'Revise os arquivos ou selecione um zip de cada vez.');
      Exit(False);
    End;

    Self.pSelecionarHubMarketplace;

    If FHubMkpPrefix.IsEmpty Then
      Exit(False);

    If (FMkpIdentificado <> '') And (FMkpIdentificado <> FHubMkpPrefix) Then
    Begin
      pMensagemOk('Os arquivos selecionados são do marketplace "'+ fSiglaMkpToNome(FMkpIdentificado) +
                  '", mas foi selecionado "'+ FHUbMkpDescricao +'".'+ sLineBreak +'Escolha a opção correta e tente novamente.');
      Exit(False);
    End;

    If ExecucaoRoboPausada(FHubMkpPrefix, VS_strCodEmp) Then
    Begin
      pMensagemOk('Execução do robô '+ FHubMkpPrefix +'-'+ VS_strCodEmp +' pausada. Importação não permitida!');
      Exit(False);
    End;

    Result := True;

    cdsNotas.DisableControls;
    cdsNotas.Filtered := False;
    cdsNotas.EmptyDataSet;

    cdsArquivosZip.DisableControls;
    cdsArquivosZip.Filter   := 'MARCAD = ' + QuotedStr('S');
    cdsArquivosZip.Filtered := True;
    cdsArquivosZip.First;

    FListaArquivosVazios.Clear;

    While Not cdsArquivosZip.Eof Do
    Begin
      FNotasAuxilar.EmptyDataSet;

      strArqXml := cdsArquivosZip.FieldByName('NOMARQ').AsString;

      UnZipper := fBuscaZip(strArqXml, intIndice);

      intQtdFiles := UnZipper.FileCount;

      FfrmGravando.pgbStatus.Position := 0;
      FfrmGravando.pgbStatus.Properties.Max := intQtdFiles;
      pProcessMessages;

      For intContador := 0 To intQtdFiles -1 Do
      Begin
        strNomArq := ReplaceStr(UnZipper.FileName[intContador], '/', '\');

        strSoNomqArq := ExtractFileName(strNomArq);

        If UnZipper.FileInfo[intContador].CompressedSize = 0 Then
        Begin
          If Not strSoNomqArq.IsEmpty Then
            FListaArquivosVazios.Add(strSoNomqArq);
          Continue;
        End;

        If Not SameText(ExtractFileExt(strSoNomqArq), '.xml') Then
          Continue;

        If Not strSoNomqArq.IsEmpty Then
          pIncluiRegistro(strNomArq, strSoNomqArq, intIndice, intContador);

        pStepStatusGravacao(FfrmGravando.pgbStatus,
                            Format('Extraindo arquivos de %s (%d/%d)', [strArqXml, (intContador +1), intQtdFiles]));
      End;

      Result := fBuscaDocumentos;

      If Not Result Then
        Break;

      cdsArquivosZip.Next;
    End; {While Not cdsArquivosZip.Eof Do}

    Result := Result And
              fBuscaNaoEncontradasPeloNumero;

    If FListaArquivosVazios.Count > 0 Then
    Begin
      TfrmMemo.pShowMessage('Os arquivos relacionados abaixo estão vazios e por isso não podem ser importados.'+ sLineBreak +
                            'Avalie os XMLs e caso necessário, exporte e importe novamente:'+ sLineBreak + sLineBreak +
                            FListaArquivosVazios.DelimitedText.Trim);
    End;

    If Result Then
      Result := fFiltraNotasInconsistentes;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'TNotasFulfillment.fCarregaArquivosXML');
      Result := False;
    End;
  End;

  cdsNotas.EnableControls;

  cdsArquivosZip.Filtered := False;
  cdsArquivosZip.EnableControls;
End;

Function TNotasFulfillment.fFiltraNotasInconsistentes: Boolean;
  Var
    intContador: Integer;
Begin
  Result := True;
  pFiltraNotas;

  FfrmGravando.lblGravando.Caption := 'Copiando inconsistências, aguarde...';
  FfrmGravando.pgbStatus.Position := 0;
  FfrmGravando.pgbStatus.Properties.Max := cdsNotas.RecordCount;
  FfrmGravando.pgbStatus.Visible := True;
  pProcessMessages;

  cdsInconsistencias.DisableControls;
  cdsInconsistencias.EmptyDataSet;

  cdsNotas.DisableControls;

  cdsNotas.First;
  While Not cdsNotas.Eof Do
  Begin
    cdsInconsistencias.Append;

    For intContador := 0 To cdsInconsistencias.FieldCount - 1 Do
      cdsInconsistencias.Fields[intContador].Value := cdsNotas.Fields[intContador].Value;

    cdsInconsistencias.Post;

    cdsNotas.Next;

    pStepStatusGravacao(FfrmGravando.pgbStatus);
  End;

  cdsInconsistencias.EnableControls;

  cdsNotas.EnableControls;
  cdsNotas.Filtered := False;
End;

Function TNotasFulfillment.fBuscaDocumentos: Boolean;
  Var
    intContador: Integer;
Begin
  Result := True;

  FfrmGravando.pgbStatus.Properties.Max := FNotasAuxilar.RecordCount;
  FfrmGravando.pgbStatus.Position := 0;
  FfrmGravando.lblGravando.Caption := 'Atualizando documentos...';
  pProcessMessages;

  SetLength(FListaNotasFaltantes, 0);
  FListaKey.Clear;
  intContador := 0;

  cdsNotas.IndexFieldNames      := 'KEYACE';
  FNotasAuxilar.IndexFieldNames := 'NUMDOC';

  FNotasAuxilar.DisableControls;
  FNotasAuxilar.First;

  While Not FNotasAuxilar.Eof Do
  Begin
    FListaKey.Add(FNotasAuxilar.FieldByName('KEYACE').AsString);

    If (intContador > 0) Then
    If (intContador Mod 2000 = 0) Then
    Begin
      Result := fCarregaCadFis(False);

      If Not Result Then
        Break;

      FListaKey.Clear;
    End;

    FNotasAuxilar.Next;

    Inc(intContador);

    pStepStatusGravacao(FfrmGravando.pgbStatus);
  End;

  FfrmGravando.lblGravando.Caption := 'Atualizando dados das notas, aguarde...';

  If Result Then
    Result := fCarregaCadFis And
              fIncluiFaltantes;

  cdsNotas.IndexFieldNames      := '';
  FNotasAuxilar.IndexFieldNames := '';

  FNotasAuxilar.EmptyDataSet;
  FNotasAuxilar.EnableControls;
End;

Function TNotasFulfillment.fImportarNotaParaTabelaNFeImp(ADataSet: TDataSet;
  out AMensagem: String): Boolean;
Var
  LArquiv: String;
begin
  AMensagem := '';

  If ADataSet.FieldByName('NOMARQ').AsString.IsEmpty Then
    Exit(True);

  If ADataSet.FieldByName('KEYACE').AsString.IsEmpty Then
    Exit(True);

  LArquiv := fLeConteudoArquivo(ADataSet.FieldByName('INDZIP').AsInteger,
                                ADataSet.FieldByName('INDXML').AsInteger);

  Result := fProcessarXmlParaInserirNFeImp(ADataSet.FieldByName('NOMARQ').AsString, LArquiv, AMensagem);
end;

function TNotasFulfillment.fLeConteudoArquivo(const intIndiceZip, intIndiceXml: Integer): String;
Var
  Data: TBytes;
begin
  FZips[intIndiceZip].zipFile.Read(intIndiceXml, Data);

  Result := StringOf(Data);
end;

Function TNotasFulfillment.fIncluiFaltantes: Boolean;
  Var
    intContador: Integer;
    qryCadFis: TUniQuery;
    strComand: String;
Begin
  Result := True;

  If Length(FListaNotasFaltantes) = 0 Then
    Exit;

  qryCadFis := fCriaQuery;

  Try
    qryCadFis.SQL.Add('SELECT SQL_NO_CACHE FIS_NUMDOC, FIS_CODEMP, FIS_SERIE_');
    qryCadFis.SQL.Add('FROM CADFIS');
    qryCadFis.SQL.Add('WHERE (FIS_NUMDOC, FIS_ESPDOC, FIS_CODEMP, FIS_SERIE_, FIS_TIP_FC)');

    strComand := '';
    For intContador := Low(FListaNotasFaltantes) To High(FListaNotasFaltantes) Do
      strComand := strComand +'('+ QuotedStr(FListaNotasFaltantes[intContador].strNumDoc) +',"NF",'+
                                   QuotedStr(FListaNotasFaltantes[intContador].strCodEmp) +','+
                                   QuotedStr(FListaNotasFaltantes[intContador].strSerie_) +',"C"),';

    qryCadFis.SQL.Add('IN ('+ strComand.TrimRight([',']) +')');
    qryCadFis.Open;

    FfrmGravando.pgbStatus.Properties.Max := qryCadFis.RecordCount;
    FfrmGravando.pgbStatus.Position := 0;
    pProcessMessages;

    qryCadFis.First;
    While Not qryCadFis.Eof Do
    Begin
      If FListaNotasFaltantes.Find(qryCadFis.Fields[0].AsString,
                                   qryCadFis.Fields[1].AsString,
                                   qryCadFis.Fields[2].AsString, intContador) Then
        Delete(FListaNotasFaltantes, intContador, 1);

      qryCadFis.Next;

      pStepStatusGravacao(FfrmGravando.pgbStatus);
    End;

    FfrmGravando.pgbStatus.Position := 0;
    FfrmGravando.pgbStatus.Properties.Max := Length(FListaNotasFaltantes);
    pProcessMessages;

    cdsNotas.IndexFieldNames := 'NUMDOC;ESPDOC;CODEMP;SERIE_;STATUS';
    cdsNotas.DisableControls;

    For intContador := Low(FListaNotasFaltantes) To High(FListaNotasFaltantes) Do
    Begin
      if (not cdsNotas.FindKey([FListaNotasFaltantes[intContador].strNumDoc,
                                'NF',
                                FListaNotasFaltantes[intContador].strCodEmp,
                                FListaNotasFaltantes[intContador].strSerie_,
                                intFaltante])) then
      begin
        cdsNotas.Append;
        cdsNotas.FieldByName('NUMDOC').Value := FListaNotasFaltantes[intContador].strNumDoc;
        cdsNotas.FieldByName('ESPDOC').Value := 'NF';
        cdsNotas.FieldByName('CODEMP').Value := FListaNotasFaltantes[intContador].strCodEmp;
        cdsNotas.FieldByName('SERIE_').Value := FListaNotasFaltantes[intContador].strSerie_;
        cdsNotas.FieldByName('STATUS').Value := intFaltante;
        cdsNotas.FieldByName('NFESTS').Value := '';
        cdsNotas.Post;
      end;

      pStepStatusGravacao(FfrmGravando.pgbStatus);
    End;

  Finally
    FreeAndNil(qryCadFis);

    cdsNotas.IndexFieldNames := '';
    cdsNotas.EnableControls;
  End;
End;

function TNotasFulfillment.fMagaluCanceladaNaoEncontrada: Boolean;
var
  strXmlNFe,
  strMotivo,
  strInfEvento: String;
Begin
  Result := False;

  if (not FHubMkpPrefix.Equals('MGL')) then
    Exit;

  try
    strXmlNFe := fLeConteudoArquivo(cdsNotas.FieldByName('INDZIP').AsInteger,
                                    cdsNotas.FieldByName('INDXML').AsInteger);

    if (not fEhXmlAntigo(strXmlNfe)) then
    begin
      strInfEvento := fExtractBetweenTags(strXmlNFe, '<infEvento>', '</infEvento>');
      strMotivo := fNormalizaTexto(fExtractBetweenTags(strInfEvento, '<xMotivo>', '</xMotivo>'));
    end
    else
      strMotivo := fNormalizaTexto(fExtractBetweenTags(strXmlNFe, '<xMotivo>', '</xMotivo>'));

    if (Pos('CANCEL', UpperCase(strMotivo)) <= 0) then
      Exit;

    Result := fCampoTabela('COUNT(1)', 'NFEIMP', ['NFE_ACESSO', 'NFE_STATUS'],
                           [cdsNotas.FieldByName('KEYACE').AsString, 'CN']) = 0;
  except
    Result := False;
  end;
end;

function TNotasFulfillment.fSerieNaoDeveGravar(const strCodEmp, strSerie: String;
  const blnDevolucao: Boolean; var strSerCfg: String): Boolean;
var
  strSerDev: String;
begin
  strSerCfg := CfgSisFulfillment('SERIE_', FHubMkpPrefix, strCodEmp);

  If blnDevolucao Then
  Begin
    strSerDev := CfgSisFulfillment('SERDEV', FHubMkpPrefix, strCodEmp);

    If Not fEmptyStr(strSerDev) Then
      strSerCfg := strSerDev;
  End;

  If fEmptyStr(strSerCfg) Then
    Exit(False);

  strSerCfg := fStrZero(strSerCfg, 3);

  If strSerie = strSerCfg Then
    Exit(False);

  Result := True;
end;

Function TNotasFulfillment.fSQLCadFis(const blnBuscaPeloCodigo: Boolean): String;
Begin
  Result := Concat('SELECT SQL_NO_CACHE ',
                   '  FIS_ACESSO, ',
                   '  FIS_SERIE_, ',
                   '  FIS_DTADOC, ',
                   '  FIS_NUMDOC, ',
                   '  FIS_ESPDOC, ',
                   '  FIS_CODEMP, ',
                   '  FIS_FORCLI, ',
                   '  CLI_NOMCLI, ',
                   '  FIS_HISTOR, ',
                   '  (IFNULL(FIS_VLCON1, 0) + IFNULL(FIS_VLCON2, 0) + IFNULL(FIS_VLCON3, 0) + ',
                   '   IFNULL(FIS_VLCON4, 0) + IFNULL(FIS_VLCON5, 0)) AS VLRCON  ',
                   'FROM   ',
                   '   CADFIS ',
                   'LEFT JOIN CADCLI ON CLI_CODCLI = FIS_FORCLI ');

  If blnBuscaPeloCodigo Then
  Begin
    Result := Concat(Result, 'WHERE ',
                             '      FIS_NUMDOC = :NUMDOC ',
                             '  AND FIS_ESPDOC = "NF"    ',
                             '  AND FIS_CODEMP = :CODEMP ',
                             '  AND FIS_SERIE_ = :SERIE_ ',
                             '  AND FIS_TIP_FC = "C"     ');
  End Else
  Begin
    Result := Concat(Result, 'WHERE FIS_ACESSO IN (' + fCommaText(FListaKey, True) + ') ',
                             'ORDER BY FIS_NUMDOC ');
  End;

End;

Procedure TNotasFulfillment.pGeraNotasFaltantes(qryCadFis: TUniQuery; strNotaAnterior: String; Var blnProcessouNotaAnterior: Boolean);
  Var
   intNota: Integer;
Begin
  If (Not strNotaAnterior.IsEmpty) And
     (FEmpresa = qryCadFis.FieldByName('FIS_CODEMP').AsString) And
     (FSerie   = qryCadFis.FieldByName('FIS_SERIE_').AsString) Then
  Begin

    intNota := StrToIntDef(strNotaAnterior, -1);

    If intNota > -1 Then
    Begin
      strNotaAnterior := fPadL(IntToStr(intNota + 1), 12, '0');

      While strNotaAnterior < qryCadFis.FieldByName('FIS_NUMDOC').AsString Do
      Begin
        FListaNotasFaltantes.Add(strNotaAnterior, FEmpresa, FSerie);

        intNota := StrToIntDef(strNotaAnterior, -1);
        If IntNota = - 1 Then
          Break;

        strNotaAnterior := fPadL(IntToStr(intNota + 1), 12, '0');
      End;

    End;

    blnProcessouNotaAnterior := True;
  End Else
  Begin
    blnProcessouNotaAnterior := False;
  End;
End;

Function TNotasFulfillment.fEhDocumentoCancelado(const strArqXml, strNomArq: String): Boolean;
  Var
    xmlDoc: TXMLDocument;
    xmlNo: IXMLNode;
    strDescEvento: String;
Begin
  Result := False;

  if not strArqXml.Contains('<procEventoNFe') then
    Exit;

  xmlDoc := TXMLDocument.Create(Self);
  Try
    Try
      xmlDoc.LoadFromXML(strArqXml);

      xmlNo := xmlDoc.Node.ChildNodes.FindNode('procEventoNFe');

      If Not Assigned(xmlNo) Then
        Exit;

      xmlNo := xmlNo.ChildNodes.FindNode('evento');

      If Not Assigned(xmlNo) Then
        Exit;

      xmlNo := xmlNo.ChildNodes.FindNode('infEvento');

      If Not Assigned(xmlNo) Then
        Exit;

      xmlNo := xmlNo.ChildNodes.FindNode('detEvento');

      If Not Assigned(xmlNo) Then
        Exit;

      xmlNo := xmlNo.ChildNodes.FindNode('descEvento');

      If Not Assigned(xmlNo) Then
        Exit;

      If (xmlNo.NodeValue <> Null) Then
      Begin
        strDescEvento := xmlNo.NodeValue;
        Result := SameText(strDescEvento, 'Cancelamento');
      End;

    Except
      On E: Exception Do
        Raise Exception.Create('Ocorreu um erro ao validar documento cancelado: '+ E.Message + sLineBreak +
                               'Arquivo: '+ ExtractFileName(strNomArq));
    End;
  Finally
    FreeAndNil(xmlDoc);
  End;
End;

Procedure TNotasFulfillment.pAtualizaUmaNota(qryCadFis: TUniQuery; const intStatus: Integer);
Var
  strArqXml: String;
Begin
  cdsNotas.Edit;
  cdsNotas.FieldByName('DTAEMI').Value := qryCadFis.FieldByName('FIS_DTADOC').Value;
  cdsNotas.FieldByName('NUMDOC').Value := qryCadFis.FieldByName('FIS_NUMDOC').Value;
  cdsNotas.FieldByName('ESPDOC').Value := qryCadFis.FieldByName('FIS_ESPDOC').Value;
  cdsNotas.FieldByName('CODEMP').Value := qryCadFis.FieldByName('FIS_CODEMP').Value;
  cdsNotas.FieldByName('SERIE_').Value := qryCadFis.FieldByName('FIS_SERIE_').Value;
  cdsNotas.FieldByName('CODCLI').Value := qryCadFis.FieldByName('FIS_FORCLI').Value;
  cdsNotas.FieldByName('NOMCLI').Value := qryCadFis.FieldByName('CLI_NOMCLI').Value;
  cdsNotas.FieldByName('HISTOR').Value := qryCadFis.FieldByName('FIS_HISTOR').Value;
  cdsNotas.FieldByName('VLRCON').Value := qryCadFis.FieldByName('VLRCON').Value;

  cdsNotas.FieldByName('ENCONT').AsString  := 'S';
  cdsNotas.FieldByName('STATUS').Value     := intStatus;

  If EndsStr('Canceladas\', cdsNotas.FieldByName('NOMPAT').AsString) Then
  Begin
    If Not cdsNotas.FieldByName('HISTOR').AsString.Contains('CANCELAD') Then
      cdsNotas.FieldByName('STATUS').Value := intCanceladoXML_NaoCancaladaLivro;
  End
  Else
  Begin
    If (Not cdsNotas.FieldByName('HISTOR').AsString.Contains('CANCELAD')) Then
    Begin
      strArqXml := fLeConteudoArquivo(cdsNotas.FieldByName('INDZIP').AsInteger,
                                      cdsNotas.FieldByName('INDXML').AsInteger);

      If fEhDocumentoCancelado(strArqXml, cdsNotas.FieldByName('NOMARQ').AsString) Then
        cdsNotas.FieldByName('STATUS').Value := intCanceladoXML_NaoCancaladaLivro;
    End;
  End;

  if (intStatus = intEncontrada) and (fMagaluCanceladaNaoEncontrada) then
  begin
    cdsNotas.FieldByName('STATUS').Value := intCanceladoXML_NaoCancaladaLivro;
    cdsNotas.FieldByName('ENCONT').AsString  := 'N';
  end;

  cdsNotas.Post;
End;

Procedure TNotasFulfillment.pAtualizaDadosNota(qryCadFis: TUniQuery);
Begin
  // PREENCHE TODOS COM A MESMA CHAVE DE ACESSO
  While (Not cdsNotas.Eof) And
        (cdsNotas.FieldByName('KEYACE').AsString = qryCadFis.FieldByName('FIS_ACESSO').AsString) Do
  Begin
    pAtualizaUmaNota(qryCadFis, intEncontrada);

    cdsNotas.Next;
  End;
End;

Function TNotasFulfillment.fCarregaCadFis(const blnExibirProgresso: Boolean = True): Boolean;
  Var
    qryCadFis: TUniQuery;
    blnProcessouNotaAnterior,
    blnEncontrouPrimeiraNota: Boolean;
    strNotaAnterior: String;
Begin
  Result := True;

  If FListaKey.Count = 0 Then
    Exit;

  qryCadFis := fCriaQuery;

  Try
    qryCadFis.SQL.Text := fSQLCadFis(False);
    qryCadFis.Open;

    If qryCadFis.IsEmpty Then
      Exit;

    If blnExibirProgresso Then
    Begin
      FfrmGravando.pgbStatus.Properties.Max := qryCadFis.RecordCount;
      FfrmGravando.pgbStatus.Position := 0;
      pProcessMessages;
    End;

    blnProcessouNotaAnterior := True;
    blnEncontrouPrimeiraNota := False;

    cdsNotas.DisableControls;

    qryCadFis.First;
    While Not qryCadFis.Eof Do
    Begin

      If cdsNotas.FindKey([qryCadFis.FieldByName('FIS_ACESSO').AsString]) Then
      Begin

        If Not blnEncontrouPrimeiraNota Then
        Begin
          blnEncontrouPrimeiraNota := True;
          strNotaAnterior := qryCadFis.FieldByName('FIS_NUMDOC').AsString;
          FEmpresa        := qryCadFis.FieldByName('FIS_CODEMP').AsString;
          FSerie          := qryCadFis.FieldByName('FIS_SERIE_').AsString;
        End;

        pAtualizaDadosNota(qryCadFis);
      End;

      If blnEncontrouPrimeiraNota And
         blnProcessouNotaAnterior And
         (FEmpresa = qryCadFis.FieldByName('FIS_CODEMP').AsString) And
         (FSerie   = qryCadFis.FieldByName('FIS_SERIE_').AsString) Then
        strNotaAnterior := qryCadFis.FieldByName('FIS_NUMDOC').AsString;

      qryCadFis.Next;

      pGeraNotasFaltantes(qryCadFis, strNotaAnterior, blnProcessouNotaAnterior);

      If blnExibirProgresso Then
        pStepStatusGravacao(FfrmGravando.pgbStatus);
    End;

  Finally
    FreeAndNil(qryCadFis);

    cdsNotas.EnableControls;
  End;
End;

Function TNotasFulfillment.fTemArquivoSelecionado: Boolean;
Begin
  Result := False;

  If cdsArquivosZip.IsEmpty Then
  Begin
    pMensagemOk('Nenhum arquivo zip carregado!');
    Exit;
  End;

  If Not cdsArquivosZip.Locate('MARCAD', 'S', []) Then
  Begin
    pMensagemOk('Nenhum arquivo selecionado para verificação!');
    Exit;
  End;

  Result := True;
End;

Procedure TNotasFulfillment.pOpenSelecionados;
Begin
  TfrmGravando.fExecuta(fOpenSelecionadosPrg, FfrmGravando, '', False);
End;

Function TNotasFulfillment.fOpenSelecionadosPrg(cxProgresso: TCxProgressBar): Boolean;
  Var
    intRecNo: Integer;
Begin
  Try
    If cdsArquivosZip.IsEmpty Then
    Begin
      Result := False;
      Exit;
    End;

    cdsArquivosZip.DisableControls;

    intRecNo := cdsArquivosZip.RecNo;

    cdsArquivosZip.First;

    While Not cdsArquivosZip.Eof Do
    Begin
      If cdsArquivosZip.FieldByName('MARCAD').AsString = 'S' Then
        pOpenZip;

      cdsArquivosZip.Next;
    End;

    cdsArquivosZip.RecNo := intRecNo;

    Result := True;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TNotasFulfillment.pOpenSelecionados');
    End;
  End;

  cdsArquivosZip.EnableControls;
End;

function TNotasFulfillment.fEhXmlAntigo(const LXmlNFe: String): Boolean;
begin
  Result := fExtractBetweenTags(LXmlNFe, '<infEvento>', '</infEvento>').IsEmpty;
end;

function TNotasFulfillment.fEhEventoDeCancelamento(const LXmlNFe, LEvento, LDescEvento, LJustif, LMotivo: String): Boolean;
begin
  Result := False;

  If LEvento.Equals('Cancelamento registrado') Then
    Exit(True);

  If fEhXmlAntigo(LXmlNFe) Then
  Begin
    If LMotivo.Equals('Cancelada') Then
      Exit(True);

    If LDescEvento.Equals('Cancelamento') Then
    Begin
      If LJustif.Equals('Motivo do cancelamento: cancelamento de nfe') Or
         LJustif.Equals('Motivo do cancelamento: Invalid') Then
      Begin
        Exit(True);
      End;
    End;
  End;
end;

function TNotasFulfillment.fRetornaTipoImportacao(const AXmlFile, LMotivo, LXmlNFe, LEvento, LDescEvento, LJustif: String): tipoXml;

  function EhDuplicidadeDeEvento : Boolean;
  begin

    Result := True;

    If LMotivo.Contains('Duplicidade de Evento (tpEvento + chNFe + nSeqEvento)') And
       LDescEvento.Equals('Cancelamento') And
       LJustif.Equals('Motivo do cancelamento: cancelamento de nfe') Then
      Exit;

    If LMotivo.Contains('Rejeição: Duplicidade de Evento (tpEvento + chNFe + nSeqEvento)') And
       LDescEvento.Equals('Cancelamento') And
       LJustif.Equals('Motivo do cancelamento: Invalid') Then
      Exit;

    Result := False;

  end;

begin
  Result := tpxNaoIdentificado;

  If ExtractFileName(AXmlFile).ToLower.Contains('inut') Or LXmlNFe.Contains('<nNFIni>') Then
  Begin
    Result := tpxInutilizacao;
  End
  Else If SameText(LMotivo, NFE_AUTORIZADA) Then
  Begin
    Result := tpxAutorizacao;
  End
  Else If fEhEventoDeCancelamento(LXmlNFe, LEvento, LDescEvento, LJustif, LMotivo) Then
  Begin
    Result := tpxCancelamento;
  End
  Else If (EhDuplicidadeDeEvento) Then
  Begin
    Result := tpxDuplicidadeEvento;
  End
  Else If LMotivo.Contains('Duplicidade de NF-e') Then
  Begin
    Result := tpxDuplicidadeNFe;
  End;
end;

function TNotasFulfillment.fRetornaEmpDocXml(const LCnpj_E, LCnpj_D: String): String;
begin
  Result := fGetCodEmp(LCnpj_E);

  If Result.IsEmpty And (Not LCnpj_D.IsEmpty) Then
    Result := fGetCodEmp(LCnpj_D);
end;

function TNotasFulfillment.fRetornaCnpjEmitenteXml(const LXmlNFe: String): String;
begin
  Result := fExtractBetweenTags(LXmlNFe, '<CNPJ>', '</CNPJ>');

  If Result.IsEmpty Then
    Result := fCampoTabela('EMP_C_G_C_', 'CADEMP', ['EMP_CODEMP'], [VS_strCodEmp], False);
end;

function TNotasFulfillment.fDataEmissaoCancelamento(const LXmlNFe: String): String;
begin
  If fEhXmlAntigo(LXmlNFe) Then
  Begin
    Result := fExtractBetweenTags(LXmlNFe, '<dhEvento>', '</dhEvento>');

    If Result.IsEmpty Then
      Result := fExtractBetweenTags(LXmlNFe, '<dhRecbto>', '</dhRecbto>');
  End
  Else
    Result := fExtractBetweenTags(LXmlNFe, '<dhRegEvento>', '</dhRegEvento>');
end;

function TNotasFulfillment.fProcessarMotivo(const AXmlNfe: String): String;
var
  LInfEvento: String;
begin
  if FHubMkpPrefix.Equals('MGL') and (not fEhXmlAntigo(AXmlNfe)) then
  begin
    LInfEvento := fExtractBetweenTags(AXmlNFe, '<infEvento>', '</infEvento>');
    Result := fExtractBetweenTags(LInfEvento, '<xMotivo>', '</xMotivo>');
  end
  else
    Result := fExtractBetweenTags(AXmlNFe, '<xMotivo>', '</xMotivo>');
end;

function TNotasFulfillment.fAjustaNumCCDAmazon(const ATexto: String): String;
var
  LCont: Integer;
begin
  Result := EmptyStr;

  for LCont := Low(ATexto) to High(ATexto) do
  begin
    if CharInSet(ATexto[LCont], ['0'..'9', '-']) then
      Result := Result + ATexto[LCont]
    else
      Break;
  end;
end;

Function TNotasFulfillment.fProcessarXmlParaInserirNFeImp(const ANomArq, AXmlFile: String;
  out AMensagem: String): Boolean;
Const
  STR_INVOICE = 'Auditoria de Notas Emitidas pelo Fulfillment - XMLs';
Var
  LIndex : Integer;
  nNFIni : Integer;
  nNFFin : Integer;
  nNFNro : Integer;
  LArrDoc: Array of String;
  LArrAce: Array of String;
  LArrRef: Array of String;
  LEspDoc: String;
  LEmpDoc: String;
  LSerie_: String;
  LCnpj_E: String;
  LCnpj_D: String;
  LdhEmis: String;
  LDtaEmi: String;
  LHraEmi: String;
  LMotivo: String;
  LEvento: String;
  LDescEvento: String;
  LJustif: String;
  LStatus: String;
  LEmpEst: String;
  LClaFis: String;
  LNatOpe: String;
  LInfAdiProd: String;
  LInfAdi: String;
  LXpedCompra: String;
  LNumPed: String;
  LNumCCD: String;
  LNumNSU: String;
  LImport: String;
  LDocBlo: String;
  LLibDev: String;
  LLogist: String;
  LMovFis: String;
  LMovExt: String;
  LGerAju: String;
  LGer_PD: String;
  LChaAce: String;
  LTxtMGL: String;
  LSerieCFG: String;
  LDevolucao: Boolean;
  LChaveValida: Boolean;
  LRegrasMovimentacaoEstoque: FulfillmentRegrasMovimentacaoEstoque;
begin
  Result := False;

  AMensagem := '';

  SetLength(LArrDoc, 1);
  SetLength(LArrAce, 1);
  SetLength(LArrRef, 1);

  LMotivo := fProcessarMotivo(AXmlFile);

  LEvento := fExtractBetweenTags(AXmlFile, '<xEvento>', '</xEvento>');
  LDescEvento := fExtractBetweenTags(AXmlFile, '<descEvento>', '</descEvento>');
  LJustif := fExtractBetweenTags(AXmlFile, '<xJust>', '</xJust>');
  LClaFis := fExtractBetweenTags(AXmlFile, '<CFOP>', '</CFOP>');
  LNatOpe := fExtractBetweenTags(AXmlFile, '<natOp>', '</natOp>');
  LNumPed := '';
  LNumCCD := '';
  LNumNSU := '';
  LTxtMGL := '';
  LXpedCompra := '';

  If FHubMkpPrefix.Equals('MGL') Then
  Begin
    LInfAdi := AnsiUpperCase(fRemoveAcento(fExtractBetweenTags(AXmlFile, '<infCpl>', '</infCpl>'))).Trim;
    LXpedCompra := fExtractBetweenTags(fExtractBetweenTags(AXmlFile.Replace(#13,'').Replace(#10,''), '<compra>', '</compra>'), '<xPed>', '</xPed>').Trim;

    If SiglaMagaluMovEstoque(LXpedCompra) Then
      LTxtMGL := AnsiUpperCase(LXpedCompra);
  End
  Else
    LInfAdi := AnsiUpperCase(fExtractBetweenTags(AXmlFile, '<xTexto>', '</xTexto>')).Trim;

  Case fRetornaTipoImportacao(ANomArq, LMotivo, AXmlFile, LEvento, LDescEvento, LJustif) Of
    tpxInutilizacao:
       Begin
         LStatus := 'IN';
         LEspDoc := 'NF';
         LSerie_ := fExtractBetweenTags(AXmlFile, '<serie>', '</serie>');
         LdhEmis := fExtractBetweenTags(AXmlFile, '<dhRecbto>', '</dhRecbto>');
         LCnpj_E := fExtractBetweenTags(AXmlFile, '<CNPJ>', '</CNPJ>');
         LCnpj_D := fExtractBetweenTags(AXmlFile, '<CNPJ>', '</CNPJ>');
         LChaAce := LeftStr(fExtractBetweenTags(AXmlFile, 'Id="ID', '"'), 23);

         try
           LEmpDoc := fRetornaEmpDocXml(LCnpj_E, LCnpj_D);
         except
           on E: Exception do
           begin
             AMensagem := E.Message;
             Exit(False);
           end;
         end;

         if not AXmlFile.Contains('<nNFIni>') then
         begin
           AMensagem := 'Tag <nNFIni> não localizada no arquivo de inutilização: '+ ExtractFileName(ANomArq);
           Exit(False);
         end;

         nNFIni := fExtractBetweenTags(AXmlFile, '<nNFIni>', '</nNFIni>').ToInteger;
         nNFFin := fExtractBetweenTags(AXmlFile, '<nNFFin>', '</nNFFin>').ToInteger;

         SetLength(LArrDoc, 0);
         SetLength(LArrAce, 0);
         SetLength(LArrRef, 0);

         for nNFNro := nNFIni to nNFFin do
         begin
           SetLength(LArrDoc, Length(LArrDoc) +1);
           LArrDoc[High(LArrDoc)] := nNFNro.ToString.PadLeft(9, '0');

           SetLength(LArrAce, Length(LArrAce) +1);
           LArrAce[High(LArrAce)] := LChaAce +
                                     nNFNro.ToString.PadLeft(9, '0') +
                                     nNFNro.ToString.PadLeft(9, '0');

           SetLength(LArrRef, Length(LArrRef) +1);
           LArrRef[High(LArrRef)] := '';
         end;
       End;

    tpxAutorizacao:
       Begin
         LStatus := 'AT';
         LEspDoc := 'NF';
         LArrAce[0] := fExtractBetweenTags(AXmlFile, '<chNFe>', '</chNFe>');
         LArrDoc[0] := fExtractBetweenTags(AXmlFile, '<nNF>', '</nNF>');
         LArrRef[0] := fExtractBetweenTags(AXmlFile, '<refNFe>', '</refNFe>');
         LSerie_ := fExtractBetweenTags(AXmlFile, '<serie>', '</serie>');
         LdhEmis := fExtractBetweenTags(AXmlFile, '<dhEmi>', '</dhEmi>');
         LCnpj_E := fRetornaCnpjEmitenteXml(AXmlFile);
         LCnpj_D := fExtractBetweenTags(fExtractBetweenTags(AXmlFile.Replace(#13,'').Replace(#10,''), '<dest>', '</dest>'), '<CNPJ>', '</CNPJ>');

         try
           LEmpDoc := fRetornaEmpDocXml(LCnpj_E, LCnpj_D);
         except
           on E: Exception do
           begin
             AMensagem := E.Message;
             Exit(False);
           end;
         end;

         If FHubMkpPrefix = 'MLB' Then
         Begin
           LInfAdiProd := fExtractBetweenTags(AXmlFile, '<infAdProd>', '</infAdProd>').Trim;
           If LInfAdiProd.StartsWith('xPed:') Then
           Begin
             LInfAdiProd := LInfAdiProd.Replace('xPed:', '').Trim;

             If LInfAdiProd.Contains(' ') Then
               LNumPed := Copy(LInfAdiProd, 1, Pos(' ', LInfAdiProd) -1)
             Else
               LNumPed := LInfAdiProd;
           End;

           LNumCCD := LNumPed;
         End
         Else If FHubMkpPrefix = 'MGL' Then
         Begin
           LNumPed := fExtractBetweenTags(AXmlFile, '<xPed>', '</xPed>').Trim;
           LNumCCD := LNumPed;

           If (Not LNumPed.IsEmpty) And
              (Not LNumPed.StartsWith('LU-')) And
              (LNumPed.Replace('-','') = fRetSomenteNumeros(LNumPed.Replace('-',''))) Then
           Begin
             If LNumPed.Contains('-') Then
               LNumCCD := Copy(LNumPed, 1, Pos('-', LNumPed) -1);

             LNumCCD := Concat('LU-', LNumCCD);

             LNumNSU := LNumCCD;
           End;
         End
         Else If FHubMkpPrefix = 'SHP' Then
         Begin
           LInfAdiProd := fExtractBetweenTags(AXmlFile, '<infAdProd>', '</infAdProd>').Trim;
           If LInfAdiProd.StartsWith('xPed:') Then
           Begin
             LInfAdiProd := LInfAdiProd.Replace('xPed:', '').Trim;

             If LInfAdiProd.Contains(' ') Then
               LNumPed := Copy(LInfAdiProd, 1, Pos(' ', LInfAdiProd) -1)
             Else If LInfAdiProd.Contains('.') Then
               LNumPed := Copy(LInfAdiProd, 1, Pos('.', LInfAdiProd) -1)
             Else
               LNumPed := LInfAdiProd;

             If LNumPed.EndsWith('.') Then
               LNumPed := LNumPed.TrimRight(['.']);
           End;

           LNumCCD := LNumPed;
           LNumNSU := LNumPed;
         End
         Else If FHubMkpPrefix = 'AMZ' Then
         Begin
           LInfAdiProd := fExtractBetweenTags(AXmlFile, '<infCpl>', '</infCpl>').ToLower;
           If LInfAdiProd.Contains('pedido da compra:') Then
           Begin
             LNumCCD := Copy(LInfAdiProd, Pos('pedido da compra:', LInfAdiProd) + Length('pedido da compra:'), Length(LInfAdiProd)).Trim;

             LNumCCD := fAjustaNumCCDAmazon(LNumCCD);
             LNumNSU := LNumCCD;
           End;
         End;
       End;

    tpxCancelamento,
    tpxDuplicidadeEvento:
       Begin
         LStatus := 'CN';
         LEspDoc := 'NF';
         LArrAce[0] := fExtractBetweenTags(AXmlFile, '<chNFe>', '</chNFe>');
         LArrDoc[0] := fCampoTabela('NFE_NUMDOC', 'NFEIMP', ['NFE_ACESSO','NFE_STATUS'], [LArrAce[0], 'AT']);
         LArrRef[0] := fExtractBetweenTags(AXmlFile, '<refNFe>', '</refNFe>');
         LSerie_ := fCampoTabela('NFE_SERIE_', 'NFEIMP', ['NFE_ACESSO','NFE_STATUS'], [LArrAce[0], 'AT']);
         LdhEmis := fDataEmissaoCancelamento(AXmlFile);
         LCnpj_E := fRetornaCnpjEmitenteXml(AXmlFile);
         LCnpj_D := fExtractBetweenTags(fExtractBetweenTags(AXmlFile.Replace(#13,'').Replace(#10,''), '<dest>', '</dest>'), '<CNPJ>', '</CNPJ>');

         try
           LEmpDoc := fRetornaEmpDocXml(LCnpj_E, LCnpj_D);
         except
           on E: Exception do
           begin
             AMensagem := E.Message;
             Exit(False);
           end;
         end;

         LChaveValida := LArrAce[0].Length = 44;

         If LArrDoc[0].IsEmpty Then
         Begin
           If AXmlFile.Contains('<nNF>') Then
             LArrDoc[0] := fExtractBetweenTags(AXmlFile, '<nNF>', '</nNF>').Trim
           Else If LChaveValida Then
             LArrDoc[0] := Copy(LArrAce[0], 26, 9);
         End;

         If LSerie_.IsEmpty Then
         Begin
           If AXmlFile.Contains('<serie>') Then
             LSerie_ := fExtractBetweenTags(AXmlFile, '<serie>', '</serie>').Trim
           Else If LChaveValida Then
             LSerie_ := Copy(LArrAce[0], 23, 3);
         End;
       End;

    tpxDuplicidadeNFe:
       Begin
         AMensagem := 'Rejeição: Duplicidade de NF-e para o arquivo '+ ExtractFileName(ANomArq);
         Exit(False);
       End;

    tpxNaoIdentificado:
       Begin
         AMensagem := 'Não foi possível definir o tipo de importação para o arquivo '+ ExtractFileName(ANomArq) +
                      IIF(Not LMotivo.IsEmpty, ' - Motivo: ' + LMotivo, '');
         Exit(False);
       End;
  End;

  If (Length(LArrAce) = 0) Or (LArrAce[0].IsEmpty) Then
  Begin
    AMensagem := 'Chave de acesso inválida no arquivo '+ ExtractFileName(ANomArq);
    Exit(False);
  End;

  If LEmpDoc.IsEmpty Then
  Begin
    AMensagem := 'O arquivo '+ ExtractFileName(ANomArq) +' não é destinado a nenhuma empresa cadastrada!';
    Exit(False);
  End;

  if ExecucaoRoboPausada(FHubMkpPrefix, LEmpDoc) then
  begin
    AMensagem := 'Execução do robô '+ FHubMkpPrefix +'-'+ LEmpDoc +' pausada. Importação não permitida!';
    Exit(False);
  end;

  LSerie_ := fStrZero(LSerie_, 3);

  If MatchText(LStatus, ['AT','IN']) Then
  Begin
    LDevolucao := False;
    if FHubMkpPrefix.Equals('MGL') and (not fEmptyStr(LClaFis)) then
      LDevolucao := Pos(LClaFis, fCfgSis('CLADEV', varString, LEmpDoc)) > 0;

    If fSerieNaoDeveGravar(LEmpDoc, LSerie_, LDevolucao, LSerieCFG) Then
    Begin
      AMensagem := 'Arquivo '+ ExtractFileName(ANomArq) +' - a série configurada não condiz com a série do xml. '+
                   'Série configurada: ' + LSerieCFG + ' / Série Xml: ' + LSerie_;
      Exit(False);
    End;
  End;

  Try
    LEmpEst := CfgSisFulfillment('CODEEE', FHubMkpPrefix, LEmpDoc);
  Except
    LEmpEst := '';
  End;

  If LEmpEst.IsEmpty Then
  Begin
    AMensagem := 'Arquivo '+ ExtractFileName(ANomArq) +' não importado: '+
                 'Empresa de Estoque Externo não informada nas configurações do marketplace '+
                 FHUbMkpDescricao +'! Empresa do documento: '+ LEmpDoc;
    Exit(False);
  End;

  For LIndex := Low(LArrDoc) To High(LArrDoc) Do
  Begin
    Try
      If FInsertsInBatch.FindKey(LArrAce[LIndex], LStatus) Then
      Begin
        AMensagem := 'Documento '+ LArrAce[LIndex] +' duplicado. Status: '+ LStatus;
        Exit(False);
      End;

      If DocumentoExisteNaNfeImp(LArrAce[LIndex], LStatus) Then
      Begin
        AMensagem := 'Documento '+ LArrAce[LIndex] +' já importado. Status: '+ LStatus;
        Exit(False);
      End;

      LLibDev := 'S';
      If CfgSisFulfillment('LIBDEV', FHubMkpPrefix) <> '0' Then
        LLibDev := TRegraImportacaoNFEIMP.New()
                  .setQryAux(fCriaQuery())
                  .setMktPlc(FHubMkpPrefix)
                  .setCodEmp(VS_strCodEmp)
                  .setClaFis(LClaFis)
                  .setNatOpe(LNatOpe)
                  .setInfAdi(LInfAdi)
                  .setXpedCompra(LXpedCompra)
                  .fRetRegraLiberaImportacaoDev;

      LDocBlo := IIF(LLibDev.Equals('N'), 'S', 'N');
      LImport := IIF(Not fCfgSis('ESTEXT', varBoolean, LEmpDoc), 'P', 'N');
      LDtaEmi := MidStr(LdhEmis, 01, 10);
      LHraEmi := MidStr(LdhEmis, 12, 08);
      LLogist := '';

      If FHubMkpPrefix.Equals('MLB') Then
      Begin
        LLogist := 'fulfillment';

        If (Not fEmptyStr(LArrRef[LIndex])) And
           (Pos(LClaFis, fTransform(fCfgSis('CLADEV', varString, LEmpDoc), 4)) > 0) Then
        Begin
          LLogist := fCampoTabela('NFE_LOGIST', 'NFEIMP', ['NFE_ACESSO', 'NFE_STATUS'], [LArrRef[LIndex], 'AT']);

          If fEmptyStr(LLogist) Then
            LLogist := 'fulfillment';
        End;

        If EhDocumentoCrossDocking(LArrAce[LIndex], LStatus, LEmpDoc, LClaFis, AXmlFile) Then
          LLogist := 'cross_docking';

        If LLogist.Equals('cross_docking') And
           CfgSisFulfillment('IMPFUL', FHubMkpPrefix).Equals('S') Then
          LImport := 'C';

        //Semelhante à regra "LIB_OPE" existente na libPluginMercadoLivre.dll
        //para importar a nota sem movimentar estoque (req 312863).
        //A regra na ESTFUL movimenta estoque de X949 quando FUL_TEMREF = 'N'
        If fEmptyStr(LArrRef[LIndex]) And
           LNumPed.ToUpper.Contains('MULTISELLER_PRODUCTS_SWAPS-TAX_OPERATION') And
           MatchText(LClaFis, ['5949', '6949']) Then
          LArrRef[LIndex] := 'MULTISELLER';
      End;

      LRegrasMovimentacaoEstoque := TRegraMovimentacaoEstoque.New(
                                      TRegrasParametros.New()
                                        .ChaAce(LArrAce[LIndex])
                                        .SigMkp(FHubMkpPrefix)
                                        .CodEmp(LEmpDoc)
                                        .ClaFis(LClaFis)
                                        .ChaRef(LArrRef[LIndex])
                                        .Logist(LLogist)
                                        .InfAdi(LInfAdi)
                                        .TxtMGL(LTxtMGL)
                                        .BuscaDadosNfeImp(False)
                                    ).ProcessarRegras;

      LMovFis := IIF(LRegrasMovimentacaoEstoque.MovimentaEstoqueFisico , 'S', 'N');
      LMovExt := IIF(LRegrasMovimentacaoEstoque.MovimentaEstoqueExterno, 'S', 'N');
      LGerAju := IIF(LRegrasMovimentacaoEstoque.GeraAjusteDeEstoque    , 'S', 'N');
      LGer_PD := 'N';

      If FHubMkpPrefix.Equals('MGL') And
         LRegrasMovimentacaoEstoque.InformacaoAdicional.Equals('DEVOLUCAO SIMBOLICA DE MERCADORIA NAO RECEBIDA') Then
        LGer_PD := 'S';

      FInsertsInBatch.AddValue('NFE_ACESSO', LArrAce[LIndex]);
      FInsertsInBatch.AddValue('NFE_STATUS', LStatus);
      FInsertsInBatch.AddValue('NFE_ARQXML', AXmlFile);
      FInsertsInBatch.AddValue('NFE_CODEMP', LEmpDoc);
      FInsertsInBatch.AddValue('NFE_DTAEMI', LDtaEmi);
      FInsertsInBatch.AddValue('NFE_HRAEMI', LHraEmi);
      FInsertsInBatch.AddValue('NFE_IMPORT', LImport);
      FInsertsInBatch.AddValue('NFE_NUMDOC', fStrZero(LArrDoc[LIndex], 9));
      FInsertsInBatch.AddValue('NFE_ESPDOC', LEspDoc);
      FInsertsInBatch.AddValue('NFE_SERIE_', LSerie_);
      FInsertsInBatch.AddValue('NFE_NUMCCD', IIF(Not fEmptyStr(LNumCCD), LNumCCD, Null));
      FInsertsInBatch.AddValue('NFE_NUMNSU', IIF(Not fEmptyStr(LNumNSU), LNumNSU, Null));
      FInsertsInBatch.AddValue('NFE_NUMPOK', IIF(Not fEmptyStr(LNumPed), LNumPed, Null));
      FInsertsInBatch.AddValue('NFE_CODEXT', IIF(fCfgSis('ESTEXT', varBoolean, LEmpDoc), LEmpEst, Null));
      FInsertsInBatch.AddValue('NFE_INVOIC', STR_INVOICE);
      FInsertsInBatch.AddValue('NFE_HUBMKP', FHubMkpPrefix);
      FInsertsInBatch.AddValue('NFE_LIBDEV', LLibDev);
      FInsertsInBatch.AddValue('NFE_DOCBLO', LDocBlo);
      FInsertsInBatch.AddValue('NFE_REFNFE', LArrRef[LIndex]);
      FInsertsInBatch.AddValue('NFE_TEMLOT', IIF(fUsaRotinaWMS Or fExisteItensComLote(AXmlFile, LEmpDoc), 'S', 'N'));
      FInsertsInBatch.AddValue('NFE_DTAGRA', FormatDateTime('yyyy-mm-dd', fRetDataServidor));
      FInsertsInBatch.AddValue('NFE_HRAGRA', FormatDateTime('hh:nn:ss', fRetHoraServidor));
      FInsertsInBatch.AddValue('NFE_LOGIST', IIF(Not fEmptyStr(LLogist), LLogist, Null));
      FInsertsInBatch.AddValue('NFE_CLAFIS', LClaFis);
      FInsertsInBatch.AddValue('NFE_XTEXTO', IIF(FHubMkpPrefix.Equals('MLB'), LInfAdi, Null));
      FInsertsInBatch.AddValue('NFE_MOVFIS', LMovFis);
      FInsertsInBatch.AddValue('NFE_MOVEXT', LMovExt);
      FInsertsInBatch.AddValue('NFE_GERAJU', LGerAju);
      FInsertsInBatch.AddValue('NFE_GER_PD', LGer_PD);
      FInsertsInBatch.AddValue('NFE_TXTMGL', IIF(Not fEmptyStr(LTxtMGL), LTxtMGL, Null));

      FInsertsInBatch.AddCommand;

      //marca a nota referenciada para ser processada novamente, caso esteja com erro
      If Not fEmptyStr(LArrRef[LIndex]) Then
      Begin
        If AXmlFile.Contains('<xTexto>') Then
          FNotasAReprocessar.Add(QuotedStr(LArrRef[LIndex]));
      End;

      Result := True;

    Except
      On E: Exception Do
      Begin
        Result := False;
        AMensagem := 'Erro ao importar o arquivo '+ ExtractFileName(ANomArq) +': '+ E.Message;
        pMensagensErro(E.Message, 'TNotasFulfillment.fProcessarXmlParaInserirNFeImp');
      End;
    End;

  End;
end;

Function TNotasFulfillment.fFullNameFile(const strNomPat, strNomArq: String): String;
begin
  Result := Concat(FPasta, strNomPat, strNomArq);
End;

Function TNotasFulfillment.fExtraiArquivo(blnMostraArquivo: Boolean; strNomPat, strNomArq: String; intIndiceZip: Integer = -999): Boolean;
  Var
    strNomExt: String;
    intIndZip: Integer;
Begin
  Result := False;

  Try
    If Not cdsNotas.IsEmpty Then
    Begin
      strNomExt := Concat(ReplaceStr(strNomPat, '\', '/'),
                          ReplaceStr(strNomArq, '\', '/'));

      If (intIndiceZip = -999) Then
        intIndZip := cdsNotas.FieldByName('INDZIP').AsInteger
      Else
        intIndZip := intIndiceZip;

      FZips[intIndZip].zipFile.Extract(strNomExt, FPasta);

      If blnMostraArquivo Then
        pExecArquivo(fFullNameFile(strNomPat, strNomArq), 0);

      Result := True;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TNotasFulfillment.fExtraiArquivo');
    End;
  End;
End;

procedure TNotasFulfillment.pFiltraNotas;
Begin

  cdsNotas.DisableControls;

  Try

    cdsNotas.Filtered := False;
    cdsNotas.Filter   := 'STATUS <> ' + intEncontrada.ToString;
    cdsNotas.Filtered := True;

  Finally
    cdsNotas.EnableControls;
  End;

End;

Function TNotasFulfillment.fNoInicialNota(xmlDoc: TXMLDocument): IXMLNode;
Begin
  Result := xmlDoc.Node.ChildNodes.FindNode('nfeProc');

  If Not Assigned(Result) Then
    Result := xmlDoc.Node.ChildNodes.FindNode('NFeList');
End;

function TNotasFulfillment.fGetCodEmp(const strCNPJ: String): String;
var
  qryCodEmp: TUniQuery;
begin
  Result := EmptyStr;

  if strCNPJ.IsEmpty then
    Exit;

  qryCodEmp := fCriaQuery;
  try
    qryCodEmp.SQL.Add('SELECT EMP_CODEMP FROM CADEMP WHERE EMP_C_G_C_ = :CNPJ');
    qryCodEmp.SQL.Add('ORDER BY EMP_CODEMP');
    qryCodEmp.ParamByName('CNPJ').AsString := strCNPJ;
    qryCodEmp.Open;

    if qryCodEmp.IsEmpty then
      Exit;

    //permite empresa mesmo com a CFG_UTIFUL desabilitada, para manter o comportamento padrão
    if qryCodEmp.RecordCount = 1 then
      Exit(qryCodEmp.FieldByName('EMP_CODEMP').AsString)
    else
    begin
      qryCodEmp.First;
      while not qryCodEmp.Eof do
      begin
        if fCfgSis('UTIFUL', varString, qryCodEmp.FieldByName('EMP_CODEMP').AsString) = 'S' then
          Exit(qryCodEmp.FieldByName('EMP_CODEMP').AsString);

        qryCodEmp.Next;
      end;

      if Result.IsEmpty then
        raise Exception.Create('Nenhuma empresa habilitada para Fulfillment com o CNPJ '+ strCNPJ +' (CFG_UTIFUL)!');
    end;
  finally
    FreeAndNil(qryCodEmp);
  end;
end;

function TNotasFulfillment.fGetQuantArquivos(AZipFile: TZipFile): Integer;
  Var
    intContador: Integer;
    strNomArq: String;
begin
  Result := 0;

  For intContador := 0 To AZipFile.FileCount -1 Do
  Begin
    strNomArq := ReplaceStr(AZipFile.FileName[intContador], '/', '\');

    If Not ExtractFileName(strNomArq).IsEmpty Then
      Inc(Result);
  End;
end;

Function TNotasFulfillment.fGetResult(xmlNo: IXMLNode): String;
Begin
  Result := '';

  If Assigned(xmlNo) Then
    If (xmlNo.NodeValue <> Null) Then
      Result := xmlNo.NodeValue;
End;

Procedure TNotasFulfillment.pReprocessaNotasComErro;
begin
  ReenviaDocumentosParaProcessamento(FNotasAReprocessar);
  FNotasAReprocessar.Clear;
end;

Function TNotasFulfillment.fRetCNPJEmpresaXML(const strArqXml, strNomArq: String): String;
  Var
    xmlDoc: TXMLDocument;
    xmlNo: IXMLNode;
Begin
  Result := '';

  If Not strArqXml.Contains('<NFe') Then
    Exit;

  xmlDoc := TXMLDocument.Create(Self);
  Try
    Try
      xmlDoc.LoadFromXML(strArqXml);

      xmlNo := fNoInicialNota(xmlDoc);

      If Not Assigned(xmlNo) Then
        Exit;

      xmlNo := xmlNo.ChildNodes.FindNode('NFe');

      If Not Assigned(xmlNo) Then
        Exit;

      xmlNo := xmlNo.ChildNodes.FindNode('infNFe');

      If Not Assigned(xmlNo) Then
        Exit;

      xmlNo := xmlNo.ChildNodes.FindNode('emit');

      If Not Assigned(xmlNo) Then
        Exit;

      xmlNo := xmlNo.ChildNodes.FindNode('CNPJ');

      Result := fGetResult(xmlNo);

    Except
      On E: Exception Do
        Raise Exception.Create('Ocorreu um erro ao buscar o CNPJ da empresa: '+ E.Message + sLineBreak +
                               'Arquivo: '+ ExtractFileName(strNomArq));
    End;
  Finally
    FreeAndNil(xmlDoc);
  End;
End;

Procedure TNotasFulfillment.pExtraiDadosChave(const strKeyAce: String; Var strNumDoc, strSerDoc: String);
Begin
  strSerDoc := Copy(strKeyAce, 23, 3);
  strNumDoc := Copy(strKeyAce, 26, 9);
End;

Function TNotasFulfillment.fBuscaNaoEncontradasPeloNumero: Boolean;
  Var
    strEmpresa,
    strNumDoc,
    strSerDoc: String;
    qryCadFis: TUniQuery;
Begin
  Result := True;
  cdsNotas.DisableControls;
  qryCadFis := fCriaQuery;

  Try
    cdsNotas.Filtered := False;
    cdsNotas.Filter   := 'STATUS = ' + intNaoEncontrada.ToString;
    cdsNotas.Filtered := True;

    FfrmGravando.pgbStatus.Position := 0;
    FfrmGravando.pgbStatus.Properties.Max := cdsNotas.RecordCount;
    pProcessMessages;

    qryCadFis.SQL.Text := fSQLCadFis(True);

    cdsNotas.First;
    While Not cdsNotas.Eof Do
    Begin
      strEmpresa := cdsNotas.FieldByName('CGCEMP').AsString;

      If strEmpresa.IsEmpty Then
        strEmpresa := fCampoTabela('EMP_C_G_C_', 'CADEMP', ['EMP_CODEMP'], [VS_strCodEmp], False);
      strEmpresa := fCampoTabela('EMP_CODEMP', 'CADEMP', ['EMP_C_G_C_'], [strEmpresa], False);

      pExtraiDadosChave(cdsNotas.FieldByName('KEYACE').AsString, strNumDoc, strSerDoc);

      qryCadFis.Close;
      qryCadFis.ParamByName('CODEMP').AsString := strEmpresa;
      qryCadFis.ParamByName('NUMDOC').AsString := fStrZero(strNumDoc, 12);
      qryCadFis.ParamByName('SERIE_').AsString := strSerDoc;
      qryCadFis.Open;

      If Not qryCadFis.IsEmpty Then
        pAtualizaUmaNota(qryCadFis, intNaoEncontradaPelaChaveMasEncontradaPeloNumero);

      cdsNotas.Next;

      pStepStatusGravacao(FfrmGravando.pgbStatus,
                          Format('Atualizando dados das notas (%d/%d)', [cdsNotas.RecNo, cdsNotas.RecordCount]));
    End;

  Finally
    FreeAndNil(qryCadFis);

    cdsNotas.Filtered := False;
    cdsNotas.EnableControls;
  End;
End;

function TNotasFulfillment.fExisteItensComLote(const AXML, ACodEmp: String): Boolean;
  Var
    xmlDoc: IXMLDocument;
    nodeNfe, nodeNfeInf, nodeDetail, nodeItem: IXMLNode;
    strCodIte: String;
begin

  Result := False;

  If AXML.IsEmpty Then
    Exit;

  If Not AXML.Contains('<NFe') Then
    Exit;

  try

    xmlDoc := LoadXMLData(AXML);

    if Assigned(xmlDoc) then
      nodeNfe := xmlDoc.DocumentElement.ChildNodes.FindNode('NFe');

    if Assigned(nodeNfe) then
      nodeNfeInf := nodeNfe.ChildNodes.FindNode('infNFe');

    if Assigned(nodeNfeInf) then
      nodeDetail := nodeNfeInf.ChildNodes.FindNode('det');

    if nodeDetail = nil then
      Exit;

    nodeDetail.ChildNodes.First;

    repeat
      nodeItem := nodeDetail.ChildNodes.FindNode('prod');

      if nodeItem <> nil then
      begin
        strCodIte := LocalizaCodIte(nodeItem.ChildNodes['cEANTrib'].Text.Trim,
                                    nodeItem.ChildNodes['cProd'].Text.Trim,
                                    FHubMkpPrefix,
                                    ACodEmp);

        If (Not strCodIte.IsEmpty) And TCadLot.ProdutoTemLote(strCodIte, ACodEmp) Then
          Exit(True);
      end;

      nodeDetail := nodeDetail.NextSibling;

    until (nodeItem =  nil);

  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;

end;

Function TNotasFulfillment.fExportaNotasCSV(cxvNotas: TcxGridDBTableView; strFullNameArq: String): Boolean;
Begin
  FcxvNotas    := cxvNotas;
  FFullNameArq := strFullNameArq;

  Result := TfrmGravando.fExecuta(fExportaNotasCSVPrg, FfrmGravando, 'Exportando arquivo, aguarde...');
End;

Function TNotasFulfillment.fDescricaoStatus(const intStatus: Integer): String;
Begin
  Case intStatus Of
    intNaoEncontrada                                : Result := 'Chave de Acesso não localizada';
    intEncontrada                                   : Result := 'Registros encontrado sem problemas';
    intCanceladoXML_NaoCancaladaLivro               : Result := 'Documento cancelado no XML mas não cancelado no livro';
    intFaltante                                     : Result := 'Documento não encontrado (número faltante)';
    intNaoEncontradaPelaChaveMasEncontradaPeloNumero: Result := 'Chave de Acesso não localizada  mas o documento foi encontrado pelo número';
    Else Result := '';
  End;
End;

Function TNotasFulfillment.fExportaNotasCSVPrg(cxgProgresso: TCxProgressBar): Boolean;
  Var
    intContador: Integer;
    strLinha,
    strNomArq: String;
    cxvNotasNOMARQ: TcxGridDBColumn;
    blnAchou: Boolean;
    stlNotasCSV: TStringList;
Begin
  Try
    Result := False;

    cxvNotasNOMARQ := FcxvNotas.GetColumnByFieldName('NOMARQ');

    If Not Assigned(cxvNotasNOMARQ) Then
    Begin
      pMensagemOk('Coluna do nome do arquivo não encontrada!');
      Exit;
    End;

    cdsNotas.DisableControls;
    cdsNotas.IndexFieldNames := 'NOMARQ';

    stlNotasCSV := TStringList.Create;

    strLinha := Concat('Arquivo', ';',
                       'Pasta', ';',
                       'Status', ';',
                       'Emissão', ';',
                       'Documento', ';',
                       'Espécie', ';',
                       'Empresa', ';',
                       'Série', ';',
                       'Cód. Cliente', ';',
                       'Nome do Cliente', ';',
                       'Histórico', ';',
                       'Chave de Acesso', ';',
                       'Valor Contábil');

    stlNotasCSV.Add(strLinha);

    cxgProgresso.Properties.Max := FcxvNotas.ViewData.RecordCount;

    For intContador := 0 To FcxvNotas.ViewData.RecordCount - 1 Do
    Begin

      If FcxvNotas.ViewData.Records[intContador].IsData Then
      Begin
        strNomArq := VarToStr(FcxvNotas.ViewData.Records[intContador].Values[cxvNotasNOMARQ.Index]);

        If strNomArq.IsEmpty Then
          blnAchou := cdsNotas.Locate('NUMDOC;ESPDOC;CODEMP;SERIE_;CODCLI',  VarArrayOf([cdsNotas.FieldByName('NUMDOC').AsString,
                                                                                         cdsNotas.FieldByName('ESPDOC').AsString,
                                                                                         cdsNotas.FieldByName('CODEMP').AsString,
                                                                                         cdsNotas.FieldByName('SERIE_').AsString,
                                                                                         cdsNotas.FieldByName('CODCLI').AsString]), [])
        Else
          blnAchou := cdsNotas.FindKey([strNomArq]);

        If blnAchou Then
        Begin
          strLinha := Concat(IIF(cdsNotas.FieldByName('NOMARQ').IsNull, '', cdsNotas.FieldByName('NOMARQ').AsString), ';',
                             IIF(cdsNotas.FieldByName('NOMPAT').IsNull, '', cdsNotas.FieldByName('NOMPAT').AsString), ';',
                             IIF(cdsNotas.FieldByName('STATUS').IsNull, '', fDescricaoStatus(cdsNotas.FieldByName('STATUS').AsInteger)), ';',
                             IIF(cdsNotas.FieldByName('DTAEMI').IsNull, '', FormatDateTime('DD/MM/YY', cdsNotas.FieldByName('DTAEMI').AsDateTime)), ';',
                             '''', IIF(cdsNotas.FieldByName('NUMDOC').IsNull, '', cdsNotas.FieldByName('NUMDOC').AsString), ';',
                             IIF(cdsNotas.FieldByName('ESPDOC').IsNull, '', cdsNotas.FieldByName('ESPDOC').AsString), ';',
                             '''', IIF(cdsNotas.FieldByName('CODEMP').IsNull, '', cdsNotas.FieldByName('CODEMP').AsString), ';',
                             '''', IIF(cdsNotas.FieldByName('SERIE_').IsNull, '', cdsNotas.FieldByName('SERIE_').AsString), ';',
                             '''', IIF(cdsNotas.FieldByName('CODCLI').IsNull, '', cdsNotas.FieldByName('CODCLI').AsString), ';',
                             IIF(cdsNotas.FieldByName('NOMCLI').IsNull, '', cdsNotas.FieldByName('NOMCLI').AsString), ';',
                             IIF(cdsNotas.FieldByName('HISTOR').IsNull, '', cdsNotas.FieldByName('HISTOR').AsString), ';',
                             '''', IIF(cdsNotas.FieldByName('KEYACE').IsNull, '', cdsNotas.FieldByName('KEYACE').AsString), ';',
                             IIF(cdsNotas.FieldByName('VLRCON').IsNull, '', cdsNotas.FieldByName('VLRCON').AsString));

          stlNotasCSV.Add(strLinha);
        End;
      End;

      pStepStatusGravacao(cxgProgresso);
    End;

    stlNotasCSV.SaveToFile(FFullNameArq);

    cdsNotas.IndexFieldNames := '';
    cdsNotas.EnableControls;
    FreeAndNil(stlNotasCSV);

    Result := True;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.message, '[TNotasFulfillment.fExportaNotasCSV]');
    End;
  End;

End;

{ TArrNotasFaltantesHelper }

procedure TArrNotasFaltantesHelper.Add(const ANumDoc, ACodEmp, ASerie_: String);
begin
  SetLength(Self, Length(Self) +1);

  Self[High(Self)].strNumDoc := ANumDoc;
  Self[High(Self)].strCodEmp := ACodEmp;
  Self[High(Self)].strSerie_ := ASerie_;
end;

function TArrNotasFaltantesHelper.Find(const ANumDoc, ACodEmp, ASerie_: String; out AIndex: Integer): Boolean;
Var
  LCont: Integer;
begin
  AIndex := -1;
  Result := False;

  For LCont := Low(Self) To High(Self) Do
  Begin
    If (Self[LCont].strNumDoc = ANumDoc) And
       (Self[LCont].strCodEmp = ACodEmp) And
       (Self[LCont].strSerie_ = ASerie_) Then
    Begin
      AIndex := LCont;
      Exit(True);
    End;
  End;
end;

end.
