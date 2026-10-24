unit Contabilidade.Classes.ImportacaoModeloContabilOrquestrador;

interface

uses
  UniClientDataSet, System.Classes, System.Generics.Collections, cxProgressBar,
  Contabilidade.Interfaces, Contabilidade.Classes.CfgContabil,
  Contabilidade.Classes.TImportacaoDadosContabeis,
  Contabilidade.Classes.ImportacaoModeloContabilReader;

type
  TAcumuladorErrosValidacao = class
  private
    FcdsAcumulado: TUniClientDataSet;
  public
    constructor Create;
    destructor Destroy; override;
    procedure pAcumula(const AdsErros: TUniClientDataSet);
    procedure pMostraAcumulado;
    function fTemErros: boolean;
  end;

  TImportacaoModeloContabilOrquestrador = class
  private
    FFactory: IImportacaoDadosContabeisFactory;
    procedure pAplicarOverlayFonteCfgSis(
      AFonteBase: IImportacaoDadosContabeisFonte;
      AOverlayCfgView: TDictionary<string, string>);
    function fClonarDicionarioCfg(const AOrigem: TDictionary<string, string>): TDictionary<string, string>;
    function fCarregaImportacao(AImportacao: IImportacaoDadosContabeis; AAcumuladorErros: TAcumuladorErrosValidacao): Boolean;
    function fPersisteImportacao(AImportacao: IImportacaoDadosContabeis): Boolean;
    function fImportarReader(AReader: TImportacaoModeloContabilReader; ApgbProgresso: TcxProgressBar; AOverlayCfgView: TDictionary<string, string>): Boolean;
  public
    constructor Create;

    function fImportarArquivo(const AstrCaminho: string; ApgbProgresso: TcxProgressBar = nil; AOverlayCfgView: TDictionary<string, string> = nil): Boolean;
    function fImportarStream(AStream: TStream; ApgbProgresso: TcxProgressBar = nil; AOverlayCfgView: TDictionary<string, string> = nil): Boolean;
  end;

implementation

uses
  System.SysUtils, Data.DB, Contabilidade.Funcoes,
  Contabilidade.View.ErrosContabeis, untFuncoesSimples,
  Contabilidade.Classes.TImportacaoDadosContabeisFactory,
  Contabilidade.Classes.TImportacaoDadosContabeisHispad,
  Contabilidade.Classes.TImportacaoDadosContabeisCfgSis,
  Contabilidade.Classes.TImportacaoDadosContabeisFonteStream;

{ TImportacaoModeloContabilOrquestrador }

constructor TImportacaoModeloContabilOrquestrador.Create;
begin
  inherited Create;
  FFactory := TImportacaoDadosContabeisFactory.New;
end;

procedure TImportacaoModeloContabilOrquestrador.pAplicarOverlayFonteCfgSis(
  AFonteBase: IImportacaoDadosContabeisFonte;
  AOverlayCfgView: TDictionary<string, string>);
var
  LFonteStream: TImportacaoDadosContabeisFonteStream;
  LPar: TPair<string, string>;
  LarrLinha: TArray<string>;
begin
  if (not Assigned(AFonteBase)) or (not Assigned(AOverlayCfgView)) then
    Exit;

  try
    LFonteStream := AFonteBase as TImportacaoDadosContabeisFonteStream;
  except
    Exit;
  end;

  for LPar in AOverlayCfgView do
  begin
    SetLength(LarrLinha, 2);
    LarrLinha[0] := LPar.Key;
    LarrLinha[1] := LPar.Value;
    LFonteStream.pAdicionarLinha(LarrLinha);
  end;
end;

function TImportacaoModeloContabilOrquestrador.fClonarDicionarioCfg(
  const AOrigem: TDictionary<string, string>): TDictionary<string, string>;
var
  LPar: TPair<string, string>;
begin
  Result := TDictionary<string, string>.Create;
  if not Assigned(AOrigem) then
    Exit;

  for LPar in AOrigem do
    Result.AddOrSetValue(UpperCase(Trim(LPar.Key)), LPar.Value);
end;

function TImportacaoModeloContabilOrquestrador.fCarregaImportacao(
  AImportacao: IImportacaoDadosContabeis;
  AAcumuladorErros: TAcumuladorErrosValidacao): Boolean;
var
  LcdsErrosCarregamento: TUniClientDataSet;
begin
  if not Assigned(AImportacao) then
    Exit(True);
  Result := AImportacao.fCarregaDadosPlanilha(AAcumuladorErros.pAcumula);
  if (not Result) and Assigned(AAcumuladorErros) then
  begin
    LcdsErrosCarregamento := AImportacao.fGetErrosCarregamento;
    try
      AAcumuladorErros.pAcumula(LcdsErrosCarregamento);
    finally
      FreeAndNil(LcdsErrosCarregamento);
    end;
  end;
end;

function TImportacaoModeloContabilOrquestrador.fPersisteImportacao(
  AImportacao: IImportacaoDadosContabeis): Boolean;
begin
  if not Assigned(AImportacao) then
    Exit(True);
  Result := AImportacao.fPersisteDados;
end;

function TImportacaoModeloContabilOrquestrador.fImportarArquivo(
  const AstrCaminho: string; ApgbProgresso: TcxProgressBar;
  AOverlayCfgView: TDictionary<string, string>): Boolean;
var
  LReader: TImportacaoModeloContabilReader;
begin
  LReader := TImportacaoModeloContabilReader.Create;
  try
    try
      LReader.pParseArquivo(AstrCaminho);
      Result := fImportarReader(LReader, ApgbProgresso, AOverlayCfgView);
    except
      on E: Exception do
      begin
        fMensagem('ATENÇÃO', 'Erro ao validar arquivo de importação: ' + E.Message, ['&OK']);
        Result := False;
      end;
    end;
  finally
    FreeAndNil(LReader);
  end;
end;

function TImportacaoModeloContabilOrquestrador.fImportarStream(
  AStream: TStream; ApgbProgresso: TcxProgressBar;
  AOverlayCfgView: TDictionary<string, string>): Boolean;
var
  LReader: TImportacaoModeloContabilReader;
begin
  LReader := TImportacaoModeloContabilReader.Create;
  try
    try
      LReader.pParseStream(AStream);
      Result := fImportarReader(LReader, ApgbProgresso, AOverlayCfgView);
    except
      on E: Exception do
      begin
        fMensagem('ATENÇÃO', 'Erro ao validar arquivo de importação: ' + E.Message, ['&OK']);
        Result := False;
      end;
    end;
  finally
    FreeAndNil(LReader);
  end;
end;

function TImportacaoModeloContabilOrquestrador.fImportarReader(AReader: TImportacaoModeloContabilReader;
  ApgbProgresso: TcxProgressBar;
  AOverlayCfgView: TDictionary<string, string>): Boolean;
var
  LblnOk: Boolean;
  LFonteCfgSis: IImportacaoDadosContabeisFonte;
  LAcumuladorErros: TAcumuladorErrosValidacao;
  LCfgContabilDemaisImportacoes: ICfgContabil;
  LOverlayCfgDemaisImportacoes: TDictionary<string, string>;
  LFontesComplementaresParCon: TDictFontesComplementares;
  LMapaCodigosHispad: TDictMapaCodigosHispad;

  LImportacaoCfgSis, LImportacaoHispad, LImportacaoPlanco, LImportacaoParCon: IImportacaoDadosContabeis;
begin
  Result := False;

  LCfgContabilDemaisImportacoes := nil;
  LOverlayCfgDemaisImportacoes := nil;
  LFontesComplementaresParCon := nil;
  LMapaCodigosHispad := nil;

  LImportacaoCfgSis := nil;
  LImportacaoHispad := nil;
  LImportacaoPlanco := nil;
  LImportacaoParCon := nil;

  LAcumuladorErros := TAcumuladorErrosValidacao.Create;
  try
    LblnOk := True;

    //CFGSIS
    if AReader.fTemTabela(DES_IMPORTACAODADOSCONTABEIS[tidcConfiguracoes]) then
    begin
      LFonteCfgSis := AReader.fGetFonte(DES_IMPORTACAODADOSCONTABEIS[tidcConfiguracoes]);
      pAplicarOverlayFonteCfgSis(LFonteCfgSis, AOverlayCfgView);

      LImportacaoCfgSis := FFactory.fImportacao(
        tidcConfiguracoes,
        ApgbProgresso,
        LFonteCfgSis,
        False,
        '', '', '', nil, nil,
        nil,
        False
      );

      if not fCarregaImportacao(LImportacaoCfgSis, LAcumuladorErros) then
        LblnOk := False;

      if Assigned(LImportacaoCfgSis) then
      begin
        LOverlayCfgDemaisImportacoes := fClonarDicionarioCfg((LImportacaoCfgSis as TImportacaoDadosContabeisCfgSis).fGetDictConfiguracoes);
        LCfgContabilDemaisImportacoes := TCfgContabilImportacao.New(LOverlayCfgDemaisImportacoes, True);
        LOverlayCfgDemaisImportacoes := nil;
      end;
    end;

    //fallback
    if (not Assigned(LImportacaoCfgSis)) and Assigned(AOverlayCfgView) then
    begin
      LOverlayCfgDemaisImportacoes := fClonarDicionarioCfg(AOverlayCfgView);
      LCfgContabilDemaisImportacoes := TCfgContabilImportacao.New(LOverlayCfgDemaisImportacoes, True);
      LOverlayCfgDemaisImportacoes := nil;
    end;

    //HISPAD
    if AReader.fTemTabela(DES_IMPORTACAODADOSCONTABEIS[tidcHistoricoPadrao]) then
    begin
      LImportacaoHispad := FFactory.fImportacao(
        tidcHistoricoPadrao,
        ApgbProgresso,
        AReader.fGetFonte(DES_IMPORTACAODADOSCONTABEIS[tidcHistoricoPadrao]),
        False,
        '', '', '', nil, nil,
        LCfgContabilDemaisImportacoes,
        False
      );
      LMapaCodigosHispad := (LImportacaoHispad as TImportacaoDadosContabeisHispad).fGetMapaCodigosImportados;
      if not fCarregaImportacao(LImportacaoHispad, LAcumuladorErros) then
        LblnOk := False;
    end;

    //PLANCO
    if AReader.fTemTabela(DES_IMPORTACAODADOSCONTABEIS[tidcPlanoContas]) then
    begin
      LImportacaoPlanco := FFactory.fImportacao(
        tidcPlanoContas,
        ApgbProgresso,
        AReader.fGetFonte(DES_IMPORTACAODADOSCONTABEIS[tidcPlanoContas]),
        False,
        '', '', '', nil, nil,
        LCfgContabilDemaisImportacoes,
        False
      );
      if not fCarregaImportacao(LImportacaoPlanco, LAcumuladorErros) then
        LblnOk := False;
    end;

    //PARCON
    if AReader.fTemTabela(DES_IMPORTACAODADOSCONTABEIS[tidcParametrosContabilizacao]) then
    begin
      LFontesComplementaresParCon := TDictFontesComplementares.Create;
      if AReader.fTemTabela('CMPPAR') then
        LFontesComplementaresParCon.Add('CMPPAR', AReader.fGetFonte('CMPPAR'));
      if AReader.fTemTabela('PARNCO') then
        LFontesComplementaresParCon.Add('PARNCO', AReader.fGetFonte('PARNCO'));

      LImportacaoParCon := FFactory.fImportacao(
        tidcParametrosContabilizacao,
        ApgbProgresso,
        AReader.fGetFonte(DES_IMPORTACAODADOSCONTABEIS[tidcParametrosContabilizacao]),
        False,
        '', '', '', nil,
        LFontesComplementaresParCon,
        LCfgContabilDemaisImportacoes,
        False,
        LMapaCodigosHispad
      );
      if not fCarregaImportacao(LImportacaoParCon, LAcumuladorErros) then
        LblnOk := False;
    end;

    // So aborta se houver erros acumulados
    if LAcumuladorErros.fTemErros then
    begin
      LAcumuladorErros.pMostraAcumulado;
      LblnOk := False;
    end;

    //Persiste todas as importacoes (ordem importa para o mapa HISPAD->PARCON)
    if LblnOk then
    begin
      fStartTransaction;
      try
        if LblnOk and (not fPersisteImportacao(LImportacaoCfgSis)) then
          LblnOk := False;

        if LblnOk and (not fPersisteImportacao(LImportacaoHispad)) then
          LblnOk := False;

        if LblnOk and (not fPersisteImportacao(LImportacaoPlanco)) then
          LblnOk := False;

        if LblnOk and (not fPersisteImportacao(LImportacaoParCon)) then
          LblnOk := False;

        if LblnOk then
        begin
          fCommit;
          Result := True;
        end
        else
          fRollBack;
      except
        on E: Exception do
        begin
          fRollBack;
          raise;
        end;
      end;
    end;
  finally
    if Assigned(LOverlayCfgDemaisImportacoes) then
      FreeAndNil(LOverlayCfgDemaisImportacoes);

    if Assigned(LFontesComplementaresParCon) then
      FreeAndNil(LFontesComplementaresParCon);

    FreeAndNil(LAcumuladorErros);
  end;
end;

{ TAcumuladorErrosValidacao }

constructor TAcumuladorErrosValidacao.Create;
begin
  FcdsAcumulado := fCriarDataSetErros;
end;

destructor TAcumuladorErrosValidacao.Destroy;
begin
  FreeAndNil(FcdsAcumulado);
  inherited;
end;

procedure TAcumuladorErrosValidacao.pAcumula(const AdsErros: TUniClientDataSet);
var
  LField: Data.DB.TField;
begin
  if not Assigned(AdsErros) then
    Exit;

  AdsErros.DisableControls;
  FcdsAcumulado.DisableControls;
  try
    AdsErros.First;
    while not AdsErros.Eof do
    begin
      FcdsAcumulado.Insert;
      for LField in AdsErros.Fields do
        FcdsAcumulado.FieldByName(LField.FieldName).Value := LField.Value;
      FcdsAcumulado.Post;
      AdsErros.Next;
    end;
  finally
    AdsErros.EnableControls;
    FcdsAcumulado.EnableControls;
  end;
end;

function TAcumuladorErrosValidacao.fTemErros: boolean;
begin
  Result := (FcdsAcumulado.RecordCount > 0);
end;

procedure TAcumuladorErrosValidacao.pMostraAcumulado;
var
  LfrmErrosContabil: TfrmErrosContabil;
begin
  pCriarFormularios(TfrmErrosContabil, LfrmErrosContabil);
  try
    LfrmErrosContabil.cdsErros := FcdsAcumulado;
    LfrmErrosContabil.objUpdateContaContabil := nil;
    LfrmErrosContabil.cxDadosDBTableViewTIPLAN.Visible := False;
    LfrmErrosContabil.cxDadosDBTableViewORIGEM.Visible := False;
    LfrmErrosContabil.cxDadosDBTableViewHISTOR.Visible := False;
    LfrmErrosContabil.cxDadosDBTableViewDESVAL.Visible := False;
    LfrmErrosContabil.cxDadosDBTableViewNATCFO.Visible := False;
    LfrmErrosContabil.cxDadosDBTableViewPLANCO.Visible := False;
    LfrmErrosContabil.ShowModal;
  finally
    pFreeAndNil(LfrmErrosContabil);
  end;
end;

end.
