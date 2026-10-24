unit untTintasdeMaquina;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
  Shared.Core,
{$ELSE}
  Forms,
{$ENDIF}
  untFuncEspecificas, System.Generics.Collections,
  Classes, untIConsultaTinta, untTintadeMaquina, iniFiles,
  SysUtils, untITintasDeMaquina, Uni, strUtils,
  Contnrs, untTipoTinta, untTintadeMaquinaWrapper, untConstantes;

Type
  TTintasdeMaquina = class(TInterfacedObject, ITintasDeMaquina)
  private
    lstIdePros: TStringList;
    lstDesTintas: TStringList;
    lstBlnDisponiveis: TStringList;
    lstConsultas: TList;

    strImobiliarias: String;
    strAutomotivas: String;
    strIndustriais: string;
    qryUsaTin: TUniQuery;
    dicUsaTin: TDictionary<string, boolean>;

    function fContemUsaTin(strIdePro: String): Boolean;
    procedure pAdicionar(strIdePro, strNomeTinta: String;
      classeTinta: TTintadeMaquinaClasse); overload;

    procedure pAdicionar(strIdePro, strNomeTinta: String;
      classeTinta: TTintadeMaquinaClasse; blnDisponivel: Boolean); overload;

    procedure pSetDisponivel(strIdePro: String; blnDisponivel: Boolean);

    procedure pCarregarDadosBanco;
    procedure pCarregarDadosIni;
    procedure pPreencherTabelaConf;
    function fFormataNomeTinta(strTexto: String): String;
    procedure AdicionarTintasDllDinamicas;
    procedure pCarregaConfiguracoesNovas();
  public
    constructor Create;
    destructor Destroy; override;
    function fGetConsulta(strIdePro: String): IConsultaTinta;

    function fGetQtdTintas: Integer;
    function fEstaDisponivel(strIdePro: String): Boolean; overload;
    function fEstaDisponivel(index: Integer): Boolean; overload;
    function fGetIdePro(strNomeTinta: String): String; overload;
    function fGetIdePro(index: Integer): String; overload;
    function fGetNomeTinta(strIdePro: String): String; overload;
    function fGetNomeTinta(index: Integer): String; overload;
    function fGetImobiliarias: String;
    function fGetIndustriais(): string;
    function fGetAutomotivas(): string;
    function fGetTodosIdePros: string;
  End;

implementation

uses
{$IFNDEF LINUX}
  untFuncoesSimples,
{$ENDIF}
  untTintaMaquina, Data.DB,

  untGlasuritConsulta,
  untSalcomixConsulta,

  untIConfTinta,
  untLibTintaFactory,
  untILibTinta,
  untVerificadorTintaExistente,
  untLibTintaDllRelacao, untTypesSistema;

{ TTintasdeMaquina }

procedure TTintasdeMaquina.AdicionarTintasDllDinamicas;
var
  stlIdePros: TStringList;
  libTintaDllRelacao: TLibTintaDllRelacao;
  intCont: Integer;
  strIdePro: String;

  function fRetAddIdePro(const aListaTinta, aIdePro: string): String;
  begin
    Result := aListaTinta;
    If Pos(aIdePro + '_', aListaTinta) = 0 Then
      Result := aListaTinta + aIdePro + '_';
  end;

begin
  pDebugViaEventLog('[AutcomTinta][AdicionarTintasDllDinamicas] >>> Início');

  stlIdePros := nil;
  libTintaDllRelacao := nil;
  Try
    Try
      stlIdePros := TStringList.Create;
      libTintaDllRelacao := TLibTintaDllRelacao.Create(True);

      pCarregaConfiguracoesNovas();

      TLibTintaFactory.GetIdentificadores(stlIdePros);
      for intCont := 0 to stlIdePros.Count - 1 do
      begin
        strIdePro := stlIdePros[intCont];

        pAdicionar(strIdePro, libTintaDllRelacao.fGetNomeTintaPorIdePro(strIdePro), TTintadeMaquinaWrapper);
      end;

      libTintaDllRelacao.pGetTodosIdeProDLL(stlIdePros);
      for intCont := 0 to stlIdePros.Count - 1 do
      begin
        strIdePro := stlIdePros[intCont];

        if (not fContemUsaTin(strIdePro)) then
          fGetConfTinta(strIdePro).pInsereCodigo('USATIN', 'Utilizar essa tinta de máquina', 'N');

        //COMPLEMENTA (strImobiliarias, strAutomotivas, strIndustriais) CASO NÃO SENHA SIDO INCLUIDO NO CREATE
        case libTintaDllRelacao.fGetTipoTintaPorIdePro(strIdePro) of
          ttImobiliaria: strImobiliarias := fRetAddIdePro(strImobiliarias, strIdePro);
          ttAutomotiva : strAutomotivas  := fRetAddIdePro(strAutomotivas,  strIdePro);
          ttIndustrial : strIndustriais  := fRetAddIdePro(strIndustriais,  strIdePro);
        end;
      end;

      pDebugViaEventLog(Format('[AutcomTinta][AdicionarTintasDllDinamicas] %d marcas catalogadas (SEM carga de DLL)', [stlIdePros.Count]));
    Except
      on E: Exception do
      begin
        pDebugViaEventLog('[AutcomTinta][AdicionarTintasDllDinamicas] Exception: ' + E.Message);
        raise;
      end;
    End;
  Finally
    if Assigned(stlIdePros) then
      FreeAndNil(stlIdePros);
    if Assigned(libTintaDllRelacao) then
      FreeAndNil(libTintaDllRelacao);
  End;

  pDebugViaEventLog('[AutcomTinta][AdicionarTintasDllDinamicas] <<< Fim');
end;

constructor TTintasdeMaquina.Create;
  Var
    qryAux : TUniQuery;
begin
  lstIdePros := TStringList.Create;
  lstConsultas := TList.Create;
  lstDesTintas := TStringList.Create;
  lstBlnDisponiveis := TStringList.Create;
  qryUsaTin := fCriaQuery();

  dicUsaTin := TDictionary<string, boolean>.Create;
  qryAux := fCriaQuery();
  Try
    qryAux.SQL.Text :=
      ' SELECT CFG_IDEPRO AS IDEPRO FROM CFGTIN ' +
      '  WHERE  CFG_CODEMP = :CODEMP            ' +
      '     AND CFG_CODCFG = "USATIN"           ' +
      '     AND CFG_GRUCFG = "CONFIGURACOES"    ' ;
    qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryAux.Open;
    qryAux.First;
    While Not qryAux.Eof Do
    Begin
      dicUsaTin.AddOrSetValue(qryAux.FieldByName('IDEPRO').AsString, True);

      qryAux.Next;
    End;
  Finally
    FreeAndNil(qryAux);
    dicUsaTin.TrimExcess;
  End;

  strImobiliarias :=
    '_SUV_CIM_REI_CID_SHE_BZI_LKS_LKC_KRE_DAC_SHW_FUT_MZI_KIL_COL_EUC_ADV_MAZ_RSI_ANJ_WEG' +
    '_ALE_VEL_SAY_HYD_INT_CAL_IQU_LIK_REC_GLO_AJA_REN_ANN_INK_BAU_QUA_CIA_MON_MEG_FAL_GRA' +
    '_BEL_MAX_ALP_BSN_CSN_GBC_CLB_BLT_UNI_C11_TEX_CHR_LEI_MAE_DCA_LUZ_PRT_AN2_RS2_';

  strAutomotivas :=
    '_LAZ_SKY_GEN_PPG_ZYN_STA_WAN_WCP_SAL_DUP_AUT_FAR_GLA_MZA_NEX_BZC_BZA_DOX_STW_AJT_ROB' +
    '_ALK_COA_LCA_PFA_ALA_BLA_DUX_PPX_DU2_';

  strIndustriais := '_ADT_MZD_SPA_LEC_JOT_ADS_SIN_REP_MIF_ALV_KIN_';

  pAdicionar('GLA', 'Glasurit', TGlasuritConsulta);
  pAdicionar('SAL', 'Salcomix', TSalcomixConsulta);

  AdicionarTintasDllDinamicas;

  pCarregarDadosBanco;
  pCarregarDadosIni;
end;

destructor TTintasdeMaquina.Destroy;
begin
  FreeAndNil(lstIdePros);
  FreeAndNil(lstConsultas);
  FreeAndNil(lstDesTintas);
  FreeAndNil(lstBlnDisponiveis);
  if Assigned(qryUsaTin) then
    FreeAndNil(qryUsaTin);
  if Assigned(dicUsaTin) then
    FreeAndNil(dicUsaTin);
  inherited;
end;

function TTintasdeMaquina.fContemUsaTin(strIdePro: String): Boolean;
begin
  Result := False;
  if Assigned(dicUsaTin) then
    Result := dicUsaTin.ContainsKey(strIdePro);
end;

function TTintasdeMaquina.fEstaDisponivel(index: Integer): Boolean;
begin
  Result := lstBlnDisponiveis[index] = 'S';
end;

function TTintasdeMaquina.fEstaDisponivel(strIdePro: String): Boolean;
begin
  If lstIdePros.IndexOf(strIdePro) = -1 Then
    Result := False
  Else
    Result := lstBlnDisponiveis[lstIdePros.IndexOf(strIdePro)] = 'S';
end;

function TTintasdeMaquina.fFormataNomeTinta(strTexto: String): String;
Var
  intPos: Integer;
begin
  if strTexto <> '' then
  begin
    strTexto := Trim(strTexto);
    strTexto := LowerCase(strTexto);
    strTexto[1] := UpCase(strTexto[1]);
  end;

  If Pos(' ', strTexto) > 0 Then
  Begin
    For intPos := 2 To Length(strTexto) Do
    Begin
      If strTexto[intPos] = ' ' Then
        strTexto[intPos + 1] := UpCase(strTexto[intPos + 1]);
    End;
  End;

  Result := strTexto;
end;

function TTintasdeMaquina.fGetConsulta(strIdePro: String): IConsultaTinta;
Var
  intIndex: Integer;
  libTinta: ILibTinta;
begin
  intIndex := lstIdePros.IndexOf(strIdePro);

  libTinta := TLibTintaFactory.GetITintadeMaquina(strIdePro);
  if Assigned(libTinta) then
  begin
    Result := TTintadeMaquinaWrapper.Create(libTinta.GetITintadeMaquina);
    Exit;
  end;

  If (intIndex >= 0) Then
  Begin
    If TTintadeMaquinaClasse(lstConsultas[intIndex]).ClassName <>
      TTintasdeMaquina.ClassName Then
      Result := TTintadeMaquinaClasse(lstConsultas[intIndex]).Create;
  End;
end;

function TTintasdeMaquina.fGetIdePro(index: Integer): String;
begin
  Result := lstIdePros[index];
end;

function TTintasdeMaquina.fGetIdePro(strNomeTinta: String): String;
begin
  Result := '';
  if lstDesTintas.IndexOf(strNomeTinta) >= 0 then
    Result := lstIdePros[lstDesTintas.IndexOf(strNomeTinta)];
end;

function TTintasdeMaquina.fGetNomeTinta(index: Integer): String;
begin
  Result := fFormataNomeTinta(lstDesTintas[index]);
end;

function TTintasdeMaquina.fGetNomeTinta(strIdePro: String): String;
begin
  Result := fFormataNomeTinta(lstDesTintas[lstIdePros.IndexOf(strIdePro)]);
end;

function TTintasdeMaquina.fGetQtdTintas: Integer;
begin
  Result := lstIdePros.Count;
end;

procedure TTintasdeMaquina.pAdicionar(strIdePro, strNomeTinta: String;
  classeTinta: TTintadeMaquinaClasse);
begin
  pAdicionar(strIdePro, strNomeTinta, classeTinta, False); // true
end;

function TTintasdeMaquina.fGetTodosIdePros: string;
begin
  Result := strImobiliarias + strAutomotivas + strIndustriais;
end;

procedure TTintasdeMaquina.pAdicionar(strIdePro, strNomeTinta: String;
  classeTinta: TTintadeMaquinaClasse; blnDisponivel: Boolean);
begin
  If lstIdePros.IndexOf(strIdePro) < 0 Then
  Begin
    lstIdePros.Add(strIdePro);
    lstConsultas.Add(classeTinta);
    lstDesTintas.Add(strNomeTinta);
    lstBlnDisponiveis.Add(IfThen(blnDisponivel, 'S', 'N'));
  End;
end;

procedure TTintasdeMaquina.pCarregaConfiguracoesNovas;
begin
  {****************************************}
  {** VERIFICA SE EXISTE A CONFIGURACAO  **}
  {** SE NÃO EXISTIR CRIA A CONFIGURAÇÃO **}
  {*************************************RG*}
{$IFNDEF LINUX}
  If Not fEhAdministrador(strLoginUsuarioLogado) Then
{$ENDIF}
  Begin
    pCriarCfgSis('CFG_PREGER', 'Utilizar qual cadastro para tabela de preço de tinta de máquina?', 'AUTTIN', fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', ''));
    pCriarCfgSis('CFG_TABPRE', 'Tabela de preço para cadastro de produto (tinta de máquina):', 'AUTTIN', fArqIniTinta(0, 'GERAL', 'TABPRECO_GERACAO', ''));
    pCriarCfgSis('CFG_UPROAC', 'Utilizar Produto Acabado?', 'AUTTIN', fArqIniTinta(0, 'PRODUTO ACABADO', 'USATIN', ''));
    pCriarCfgSis('CFG_TABTER', 'Tabela de preço para geração de exportação de tintométricos para terceiros:', 'AUTTIN', fArqIniTinta(0, 'GERAL', 'TABPRECO_GERACAO_TERCEIROS', ''));
  End;
end;

procedure TTintasdeMaquina.pCarregarDadosBanco;
var
  strIdePro: string;
  conf: IConfTinta;
begin
  qryUsaTin.SQL.Text :=
    'SELECT CFG_IDEPRO, CFG_VALCFG FROM CFGTIN WHERE CFG_CODEMP = :CODEMP AND CFG_CODCFG = "USATIN"';
  qryUsaTin.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryUsaTin.Open;

  if qryUsaTin.IsEmpty then
  begin
    pPreencherTabelaConf;
    qryUsaTin.Close;
    qryUsaTin.Open;
  end;

  While Not qryUsaTin.Eof Do
  Begin
    { If lstIdePros.IndexOf(qryUsaTin.FieldByName('CFG_IDEPRO').AsString) < 0 Then
      Begin
      if TVerificadorTintaExistente.IsTintaExistente(qryUsaTin.FieldByName('CFG_IDEPRO').AsString) then
      begin
      pAdicionar(qryUsaTin.FieldByName('CFG_IDEPRO').AsString,
      fRetornaNomeTinta(qryUsaTin.FieldByName('CFG_IDEPRO').AsString),
      TTintadeMaquina,
      qryUsaTin.FieldByName('CFG_VALCFG').AsString = 'S');
      end;
      End
      Else
      Begin
      pSetDisponivel(qryUsaTin.FieldByName('CFG_IDEPRO').AsString,
      qryUsaTin.FieldByName('CFG_VALCFG').AsString = 'S');
      End;
    }
    If lstIdePros.IndexOf(qryUsaTin.FieldByName('CFG_IDEPRO').AsString)
      >= 0 Then
    Begin
      pSetDisponivel(qryUsaTin.FieldByName('CFG_IDEPRO').AsString,
        qryUsaTin.FieldByName('CFG_VALCFG').AsString = 'S');
    End;

    qryUsaTin.Next;

  End;

  // Verifica se a tinta esta na lista de tintas do banco[constructor TTintasdeMaquina.Create] e se realmente ela está
  // no banco[qryUsaTin].Isso ocorre porque subiu a versao ou usava arquivo ini e trocou para
  // banco de dados.
  for strIdePro in lstIdePros do
  begin
    If (Not fContemUsaTin(strIdePro)) Then
    Begin
      conf := fGetConfTinta(strIdePro);
      conf.pInsereCodigo('USATIN', 'Utilizar essa tinta de máquina', 'N');
      conf := nil;
    End;
  end;
end;

procedure TTintasdeMaquina.pCarregarDadosIni;
Var
  //arqIni: TIniFile;
  strPathOpcoes: String;
  lstTintas: TStringList;
  intCont: Integer;
begin
  strPathOpcoes := ExtractFilePath(Application.ExeName);
  If (Not AnsiEndsText('auttin', strPathOpcoes)) And
    (Not AnsiEndsText('auttin\', strPathOpcoes)) Then
    strPathOpcoes := strPathOpcoes + '\auttin\';

  strPathOpcoes := strPathOpcoes + 'opcoestinta.ini';

  //arqIni := TIniFile.Create(strPathOpcoes);

  lstTintas := TStringList.Create;
  //arqIni.ReadSections(lstTintas);
  lstTintas.Add('PRODUTO ACABADO');

  For intCont := 0 To lstTintas.Count - 1 Do
  Begin
    Try
      If ((lstTintas[intCont]) = 'PRODUTO ACABADO') And (fCfgSis('UPROAC') = 'S') Then
        pAdicionar('ACA', 'Produto Acabado', TTintadeMaquina,
          fCfgSis('UPROAC') = 'S');
    Except
      on E: ExceptionTintaNaoDisponivel do
      begin
      end;

      on E: Exception do
      begin
        raise;
      end;
    End;
  End;

  //arqIni.Free;
  lstTintas.Free;
end;

procedure TTintasdeMaquina.pPreencherTabelaConf;
Var
  intCont: Integer;
begin
  for intCont := 0 to fGetQtdTintas - 1 do
  begin
    fGetConfTinta(Self.lstIdePros[intCont]).pInsereCodigo('USATIN', 'Utilizar essa tinta de máquina', 'N');
  end;
end;

procedure TTintasdeMaquina.pSetDisponivel(strIdePro: String;
  blnDisponivel: Boolean);
begin
  lstBlnDisponiveis[lstIdePros.IndexOf(strIdePro)] :=
    IfThen(blnDisponivel, 'S', 'N');
end;

function TTintasdeMaquina.fGetImobiliarias: String;
begin
  Result := strImobiliarias;
end;

function TTintasdeMaquina.fGetIndustriais: string;
begin
  Result := strIndustriais;
end;

function TTintasdeMaquina.fGetAutomotivas(): string;
begin
  Result := strAutomotivas;
end;

end.
