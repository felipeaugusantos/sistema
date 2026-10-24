unit untLibTintaDllRelacao;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  Windows,
  untFuncoesSimples,
{$ENDIF}
  SysUtils, Classes, Uni, untILibTintaDllRelacao, untTipoTinta;

Type
  TTintaDLL = Record
    strNomeDLL  : String;
    strIdePro   : String;
    strNomeTinta: String;
    tipoTinta   : TTipoTinta;
  End;

type
  TLibTintaDllRelacao = Class(TInterfacedObject, ILibTintaDllRelacao)
  private
    FMatrizTintaDLL: Array Of TTintaDLL;
    stlUsaTin: TStringList;
    procedure pCarregarTintaDLL;
    procedure pAdicionar(strNomeDLL, strIdePro, strNomeTinta: String; tipoTinta: TTipoTinta);
    procedure pLimpar;
    procedure pCarregaCFGTIN;
  public
    constructor Create(blnCarregarCfgTin: Boolean);
    destructor Destroy; override;

    function fGetChaveTinta(strNomeDLL: String): String;
    function fGetNomeTinta(strNomeDLL: String): String;

    function fUtilizaTintaDLL(strIdePro: String): Boolean;
    function fGetNomeDLLPorIdePro(const strIdePro: String): String;
    function fGetNomeTintaPorIdePro(const strIdePro: String): String;
    function fGetTipoTintaPorIdePro(const strIdePro: String): TTipoTinta;
    procedure pGetIdeProHabilitados(const stlIdePro: TStrings);
    procedure pGetTodosNomesDLL(const stlNomDLL: TStrings);
    procedure pGetTodosIdeProDLL(const stlIdePro: TStrings);
    function fGetNomeDLLPorIdentificadorGenerico(const strIdentificador: String): String;
  end;

implementation

{ TLibTintaDllRelacao }

constructor TLibTintaDllRelacao.Create(blnCarregarCfgTin: Boolean);
begin
  inherited Create;
  stlUsaTin := TStringList.Create;
  pCarregarTintaDLL;
  If blnCarregarCfgTin Then
    pCarregaCFGTIN;
end;

destructor TLibTintaDllRelacao.Destroy;
begin
  FreeAndNil(stlUsaTin);
  inherited;
end;

function TLibTintaDllRelacao.fGetChaveTinta(strNomeDLL: String): String;
var
 intCont: Integer;
begin
  Result := '';

  For intCont := Low(FMatrizTintaDLL) To High(FMatrizTintaDLL) Do
  Begin
    If (FMatrizTintaDLL[intCont].strNomeDLL = strNomeDLL) Then
    Begin
      Result := FMatrizTintaDLL[intCont].strIdePro;
      Break;
    End;
  End;

  If fEmptyStr(Result) Then
    fMensagem('ATENÇÃO', strNomeDLL + ' não implementada [TLibTintaDllRelacao] !', ['&Ok']);
end;

function TLibTintaDllRelacao.fGetNomeTinta(strNomeDLL: String): String;
var
 intCont: Integer;
begin
  Result := '';
  For intCont := Low(FMatrizTintaDLL) To High(FMatrizTintaDLL) Do
  Begin
    If (FMatrizTintaDLL[intCont].strNomeDLL = strNomeDLL) Then
    Begin
      Result := FMatrizTintaDLL[intCont].strNomeTinta;
      Break;
    End;
  End;
end;

function TLibTintaDllRelacao.fUtilizaTintaDLL(strIdePro: String): Boolean;
begin
  Result := stlUsaTin.IndexOf(strIdePro) >= 0;
end;

function TLibTintaDllRelacao.fGetNomeDLLPorIdePro(const strIdePro: String): String;
var
  intCont: Integer;
begin
  Result := '';
  For intCont := Low(FMatrizTintaDLL) To High(FMatrizTintaDLL) Do
  Begin
    If SameText(FMatrizTintaDLL[intCont].strIdePro, strIdePro) Then
    Begin
      Result := FMatrizTintaDLL[intCont].strNomeDLL;
      Break;
    End;
  End;
end;

function TLibTintaDllRelacao.fGetNomeTintaPorIdePro(const strIdePro: String): String;
var
  intCont: Integer;
begin
  Result := '';
  For intCont := Low(FMatrizTintaDLL) To High(FMatrizTintaDLL) Do
  Begin
    If SameText(FMatrizTintaDLL[intCont].strIdePro, strIdePro) Then
    Begin
      Result := FMatrizTintaDLL[intCont].strNomeTinta;
      Break;
    End;
  End;
end;

function TLibTintaDllRelacao.fGetTipoTintaPorIdePro(const strIdePro: String): TTipoTinta;
var
  intCont: Integer;
begin
  Result := ttImobiliaria;
  For intCont := Low(FMatrizTintaDLL) To High(FMatrizTintaDLL) Do
  Begin
    If SameText(FMatrizTintaDLL[intCont].strIdePro, strIdePro) Then
    Begin
      Result := FMatrizTintaDLL[intCont].tipoTinta;
      Break;
    End;
  End;
end;

procedure TLibTintaDllRelacao.pGetIdeProHabilitados(const stlIdePro: TStrings);
var
  intCont: Integer;
begin
  stlIdePro.Clear;
  For intCont := 0 To stlUsaTin.Count - 1 Do
    stlIdePro.Add(stlUsaTin[intCont]);
end;

procedure TLibTintaDllRelacao.pGetTodosNomesDLL(const stlNomDLL: TStrings);
var
  intCont: Integer;
begin
  stlNomDLL.Clear;
  For intCont := Low(FMatrizTintaDLL) To High(FMatrizTintaDLL) Do
    stlNomDLL.Add(FMatrizTintaDLL[intCont].strNomeDLL);
end;

procedure TLibTintaDllRelacao.pGetTodosIdeProDLL(const stlIdePro: TStrings);
var
  intCont: Integer;
begin
  stlIdePro.Clear;
  For intCont := Low(FMatrizTintaDLL) To High(FMatrizTintaDLL) Do
    stlIdePro.Add(FMatrizTintaDLL[intCont].strIdePro);
end;

function TLibTintaDllRelacao.fGetNomeDLLPorIdentificadorGenerico(const strIdentificador: String): String;
var
  intCont: Integer;
  strIdentUpper: String;
begin
  Result := '';
  if strIdentificador = '' then
    Exit;

  strIdentUpper := AnsiUpperCase(strIdentificador);

  // 1) Por IDEPRO (ex: CIM)
  For intCont := Low(FMatrizTintaDLL) To High(FMatrizTintaDLL) Do
  Begin
    If AnsiUpperCase(FMatrizTintaDLL[intCont].strIdePro) = strIdentUpper Then
    Begin
      Result := FMatrizTintaDLL[intCont].strNomeDLL;
      Exit;
    End;
  End;

  // 2) Por NOMETINTA (ex: Coral Imobiliaria)
  For intCont := Low(FMatrizTintaDLL) To High(FMatrizTintaDLL) Do
  Begin
    If AnsiUpperCase(FMatrizTintaDLL[intCont].strNomeTinta) = strIdentUpper Then
    Begin
      Result := FMatrizTintaDLL[intCont].strNomeDLL;
      Exit;
    End;
  End;
end;

procedure TLibTintaDllRelacao.pAdicionar(strNomeDLL, strIdePro, strNomeTinta: String; tipoTinta: TTipoTinta);
begin
 {$IFDEF LINUX}
  strNomeDLL := strNomeDLL + '.so';
 {$ELSE}
  strNomeDLL := strNomeDLL + '.dll';
 {$ENDIF}
  SetLength(FMatrizTintaDLL, Length(FMatrizTintaDLL) + 1);
  FMatrizTintaDLL[Length(FMatrizTintaDLL) - 1].strNomeDLL   := strNomeDLL;
  FMatrizTintaDLL[Length(FMatrizTintaDLL) - 1].strIdePro    := strIdePro;
  FMatrizTintaDLL[Length(FMatrizTintaDLL) - 1].strNomeTinta := strNomeTinta;
  FMatrizTintaDLL[Length(FMatrizTintaDLL) - 1].tipoTinta    := tipoTinta;
end;

procedure TLibTintaDllRelacao.pCarregaCFGTIN;
var
  qryTinta: TUniQuery;
begin
  Try
    qryTinta := fCriaQuery;

    With qryTinta Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT CFG_IDEPRO            ');
      SQL.Add('   FROM CFGTIN                ');
      SQL.Add('  WHERE CFG_CODCFG = "USATIN" ');
      SQL.Add('    AND CFG_VALCFG = "S"      ');
      SQL.Add('    AND CFG_CODEMP = :CODEMP  ');
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      First;
      While Not Eof Do
      Begin
        stlUsaTin.Add(FieldByName('CFG_IDEPRO').AsString);

        Next;
      End;
    End;
  Finally
    FreeAndNil(qryTinta);
  End;
end;

procedure TLibTintaDllRelacao.pCarregarTintaDLL;
begin
  pLimpar;
  pAdicionar('libTintaAnjoAutomotiva'           , 'AJT', 'Anjo Automotiva',           ttAutomotiva);
  pAdicionar('libTintaAnjoImobiliaria'          , 'ANJ', 'Anjo Imobiliária',          ttImobiliaria);
  pAdicionar('libTintaBautech'                  , 'BAU', 'Bautech',                   ttImobiliaria);
  pAdicionar('libTintaCiacollor'                , 'CIA', 'Ciacollor',                 ttImobiliaria);
  pAdicionar('libTintaAlessiImobiliaria'        , 'ALE', 'Alessi Imobiliária',        ttImobiliaria);
  pAdicionar('libTintaCoralImobiliaria'         , 'CIM', 'Coral Imobiliária',         ttImobiliaria);
  pAdicionar('libTintaDacar'                    , 'DAC', 'Dacar',                     ttImobiliaria);
  pAdicionar('libTintaDupont'                   , 'DUP', 'Axalta',                    ttAutomotiva);
  pAdicionar('libTintaDuxone'                   , 'DUX', 'Duxone Global',             ttAutomotiva);
  pAdicionar('libTintaFalcao'                   , 'FAL', 'Falcão',                    ttImobiliaria);
  pAdicionar('libTintaFutura'                   , 'FUT', 'Futura',                    ttImobiliaria);
  pAdicionar('libTintaLazzumix'                 , 'LAZ', 'Lazzumix',                  ttAutomotiva);
  pAdicionar('libTintaMazaAutomotiva'           , 'MZA', 'Maza Automotiva',           ttAutomotiva);
  pAdicionar('libTintaMazaIndustrial'           , 'MZD', 'Maza Industrial',           ttIndustrial);
  pAdicionar('libTintaMiniFabrica'              , 'MIF', 'Mini Fábrica',              ttIndustrial);
  pAdicionar('libTintaMegaTintas'               , 'MEG', 'Mega Tintas',               ttImobiliaria);
  pAdicionar('libTintaGrafftex'                 , 'GRA', 'Grafftex',                  ttImobiliaria);
  pAdicionar('libTintaMontana'                  , 'MON', 'Montana',                   ttImobiliaria);
  pAdicionar('libTintaQualyVinil'               , 'QUA', 'Qualyvinil',                ttImobiliaria);
  pAdicionar('libTintaRennerImobiliaria'        , 'REI', 'Renner Imobiliária',        ttImobiliaria);
  pAdicionar('libTintaSherwinWilliams'          , 'SHE', 'Sherwin Williams',          ttImobiliaria);
  pAdicionar('libTintaSherwinWilliams2'         , 'SHW', 'Sherwin Williams 2',        ttImobiliaria);
  pAdicionar('libTintaSparlack'                 , 'SPA', 'Sparlack Industrial',       ttIndustrial);
  pAdicionar('libTintaStarmixWeb'               , 'STW', 'Starmix Web / W-Mix',       ttAutomotiva);
  pAdicionar('libTintaSuvinil'                  , 'SUV', 'Suvinil',                   ttImobiliaria);
  pAdicionar('libTintaColorPro'                 , 'WCP', 'Color Pro',                 ttAutomotiva);
  pAdicionar('libTintaGeneral'                  , 'GEN', 'General',                   ttAutomotiva);
  pAdicionar('libTintaJotun'                    , 'JOT', 'Jotun',                     ttIndustrial);
  pAdicionar('libTintaBrasimixImobiliaria'      , 'BZI', 'Brasimix Imobiliária',      ttImobiliaria);
  pAdicionar('libTintaEucatexImobiliaria'       , 'EUC', 'Eucatex Imobiliária',       ttImobiliaria);
  pAdicionar('libTintaMazaImobiliaria'          , 'MZI', 'Maza Imobiliária',          ttImobiliaria);
  pAdicionar('libTintaBrasimixAutomotiva'       , 'BZA', 'Brasimix Automotiva',       ttAutomotiva);
  pAdicionar('libTintaBrazilianColorAutomotiva' , 'BZC', 'BrazilianColor Automotiva', ttAutomotiva);
  pAdicionar('libTintaVelutexImobiliaria'       , 'VEL', 'Velutex Imobiliária',       ttImobiliaria);
  pAdicionar('libTintaUniverso'                 , 'UNI', 'Universo',                  ttImobiliaria);
  pAdicionar('libTintaFarbenAutomotiva'         , 'FAR', 'Farben Automotiva',         ttAutomotiva);
  pAdicionar('libTintaHydronorthImobiliaria'    , 'HYD', 'Hydronorth Imobiliária',    ttImobiliaria);
  pAdicionar('libTintaLiko'                     , 'LIK', 'Liko',                      ttImobiliaria);
  pAdicionar('libTintaBellaCor'                 , 'BEL', 'Bellacor',                  ttImobiliaria);
  pAdicionar('libTintaIquine'                   , 'IQU', 'Iquine',                    ttImobiliaria);
  pAdicionar('libTintaRecoa'                    , 'REC', 'Recoa',                     ttImobiliaria);
  pAdicionar('libTintaCalamar'                  , 'CAL', 'Calamar',                   ttImobiliaria);
  pAdicionar('libTintaKilling'                  , 'KIL', 'Killing',                   ttImobiliaria);
  pAdicionar('libTintaAnnetta'                  , 'ANN', 'Annetta',                   ttImobiliaria); //TRATADA COMO IMOBILIÁRIA
  pAdicionar('libTintaInternational'            , 'INT', 'International',             ttImobiliaria);
  pAdicionar('libTintaLukscolor'                , 'LKS', 'Lukscolor',                 ttImobiliaria);
  pAdicionar('libTintaGlobalColor'              , 'GLO', 'Global Color',              ttImobiliaria);
  pAdicionar('libTintaPpg'                      , 'PPG', 'Ppg',                       ttAutomotiva);
  pAdicionar('libTintaPpgNexa'                  , 'PPX', 'PPG/NEXA',                  ttAutomotiva);
  pAdicionar('libTintaNexa'                     , 'NEX', 'Nexa Autocolor',            ttAutomotiva);
  pAdicionar('libTintaAdvance'                  , 'ADV', 'Advance',                   ttImobiliaria);
  pAdicionar('libTintaAdvanceTintoSystem'       , 'ADT', 'Advance TintoSystem',       ttIndustrial);
  pAdicionar('libTintaAnjoSintetica'            , 'AJA', 'Anjo Sintética',            ttImobiliaria);
  pAdicionar('libTintaRennerIndustrial'         , 'REN', 'Renner Industrial',         ttImobiliaria); //TRATADA COMO IMOBILIÁRIA
  pAdicionar('libTintaResicolor'                , 'RSI', 'Resicolor',                 ttImobiliaria);
  pAdicionar('libTintaSayerlack'                , 'SAY', 'Sayerlack',                 ttImobiliaria);
  pAdicionar('libTintaSkyMixAutomotiva'         , 'SKY', 'SkyMix Automotiva',         ttAutomotiva);
  pAdicionar('libTintaWeg'                      , 'WEG', 'Weg',                       ttImobiliaria);
  pAdicionar('libTintaStandox'                  , 'DOX', 'Standox',                   ttAutomotiva);
  pAdicionar('libTintaStarmix'                  , 'STA', 'Starmix',                   ttAutomotiva);
  pAdicionar('libTintaLechler'                  , 'LEC', 'Lechler Industrial',        ttIndustrial);
  pAdicionar('libTintaLukscolor2'               , 'LKC', 'Lukscolor 2',               ttImobiliaria);
  pAdicionar('libTintaInkor'                    , 'INK', 'Inkor',                     ttImobiliaria);
  pAdicionar('libTintaKresil'                   , 'KRE', 'Kresil',                    ttImobiliaria);
  pAdicionar('libTintaKillingIndustrial'        , 'KIN', 'Killing Industrial',        ttIndustrial);
  pAdicionar('libTintaRoberlo'                  , 'ROB', 'Roberlo',                   ttAutomotiva);
  pAdicionar('libTintaMaxVinil'                 , 'MAX', 'MaxVinil',                  ttImobiliaria);
  pAdicionar('libTintaAlterPlus'                , 'ALP', 'Alter Plus',                ttImobiliaria);
  pAdicionar('libTintaGlobalBsn'                , 'BSN', 'Global BSN',                ttImobiliaria);
  pAdicionar('libTintaGlobalCsn'                , 'CSN', 'Global CSN',                ttImobiliaria);
  pAdicionar('libTintaGlobalBc'                 , 'GBC', 'Global BC',                 ttImobiliaria);
  pAdicionar('libTintaColorbraz'                , 'CLB', 'Colorbraz',                 ttImobiliaria);
  pAdicionar('libTintaBellaCorTintavel'         , 'BLT', 'BellaCor Tintavel',         ttImobiliaria);
  pAdicionar('libTintaAutoluks'                 , 'ALK', 'Autoluks',                  ttAutomotiva);
  pAdicionar('libTintaTopCoat'                  , 'COA', 'Top Coat',                  ttAutomotiva);
  pAdicionar('libTintaGlobalCc11'               , 'C11', 'Global CC11',               ttImobiliaria);
  pAdicionar('libTintaTexturaCia'               , 'TEX', 'Textura e Cia',             ttImobiliaria);
  pAdicionar('libTintaChreon'                   , 'CHR', 'Chreon',                    ttImobiliaria);
  pAdicionar('libTintaAdvanceStr'               , 'ADS', 'Advance Str',               ttIndustrial);
  pAdicionar('libTintaDuxone2'                  , 'DU2', 'Duxone Global 2',           ttAutomotiva);
  pAdicionar('libTintaLeinertex'                , 'LEI', 'Leinertex',                 ttImobiliaria);
  pAdicionar('libTintaMaestria'                 , 'MAE', 'Maestria',                  ttImobiliaria);
  pAdicionar('libTintaSinteplast'               , 'SIN', 'Sinteplast',                ttIndustrial);
  pAdicionar('libTintaDacasa'                   , 'DCA', 'Dacasa',                    ttImobiliaria);
  pAdicionar('libTintaLuztol'                   , 'LUZ', 'Luztol',                    ttImobiliaria);
  pAdicionar('libTintaRennerPerformance'        , 'REP', 'Renner Performance',        ttIndustrial);
  pAdicionar('libTintaProfissionalTintas'       , 'PRT', 'Profissional Tintas',       ttImobiliaria);
  pAdicionar('libTintaAnjoImobiliaria2'         , 'AN2', 'Anjo Imobiliária 2',        ttImobiliaria);
  pAdicionar('libTintaResicolor2'               , 'RS2', 'Resicolor 2',               ttImobiliaria);
  pAdicionar('libTintaLechlerAutomotiva'        , 'LCA', 'Lechler Automotiva',        ttAutomotiva);
  pAdicionar('libTintaAlv'                      , 'ALV', 'ALV Industrial',            ttIndustrial);
  pAdicionar('libTintaProfissionalAutomotiva'   , 'PFA', 'Profissional Automotiva',   ttAutomotiva);
  pAdicionar('libTintaAlvAutomotiva'            , 'ALA', 'ALV Automotiva',            ttAutomotiva);
  pAdicionar('libTintaBlascorAutomotiva'        , 'BLA', 'Blascor Automotiva',        ttAutomotiva);
end;

procedure TLibTintaDllRelacao.pLimpar;
begin
  SetLength(FMatrizTintaDLL, 0);
end;

end.
