{********************************************************************************}
{* Classes responsável por configurar a tela de configurações da tinta PPX *}
{*****************************************************************************AC*}
unit untConfiguradorPpgNexa;

interface

uses
{$IFNDEF LINUX}
  Forms,
  Controls,
  Dialogs,
{$ENDIF}
  untIConfiguradorTinta, untAbstractConfiguradorTinta, untIAuttinWrapper,Data.DB,
  SysUtils, untIDataSet, Uni, untAutcomTintaFactory, untStrUtils, untTypesSistema;

type
  TConfiguradorPpgNexa = class(TAbstractConfiguradorTinta, IConfiguradorTinta)
  private
    function fConsultaProdutoEmbalagem(const strValCfg: String): String;
    function fConsultaProdutoVenda(const strValCfg: String): String;
  public
    constructor Create(const auttin: IAuttinWrapper); reintroduce;
    function ConfigurarClick(const strCodCfg: string; const strValCfg: string): string; override;
    procedure ConfigurarValidar(var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean); override;
    procedure NumeroValidar(var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean; const strNomCam: String); override;
  {$IFNDEF LINUX}
    function DiretorioValidar(strDir: String): string; override;
  {$ENDIF}
    function BotaoVendaClick(const strCodCfg: string; const strValCfg: string): string; override;
    procedure BotaoVendaValidar(var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean); override;
  {$IFNDEF LINUX}
    function DiretorioValidarNv(strDiretorio: String; strNomCam: String): String; Override;
  {$ENDIF}
    function fRetornarEmbalagemPrincipal(strCodCfg : String) : String;
    procedure pGetInfConfEmb(strCodCfg : String; Var strEmbalagem, strLinha : String);

  end;

implementation

uses
{$IFNDEF LINUX}
  untCadEmbTintaPpgNexa,
{$ENDIF}
  untLibTintaFactory, System.Variants;

{ TConfiguradorPpgNexa }

function TConfiguradorPpgNexa.BotaoVendaClick(const strCodCfg,
  strValCfg: string): string;
begin
  Result := fConsultaProdutoVenda(strValCfg);
end;

procedure TConfiguradorPpgNexa.BotaoVendaValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
var
  qryValida: IDataSet;
begin
  If Not TStrUtils.fEmptyStr(DisplayValue) Then
  Begin
    Try
      Error := False;
      qryValida := TAutcomTintaFactory.Get.fGetDataSet;

      With qryValida Do
      Begin
        SQL := 'SELECT                  ' +
               '  COUNT(*) AS QTD       ' +
               '  FROM                  ' +
               '    CADITE              ' +
               ' WHERE                  ' +
               '   ITE_CODITE = :CODITE ' +
               '   AND ITE_ITEATI = "S" ';

        If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITESER')) Then
          SQL := SQL + '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITESER'));

        If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('SERTER')) Then
          SQL := SQL + '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('SERTER'));

        If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITEFRE')) Then
          SQL := SQL + '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITEFRE'));

        If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITEBOM')) Then
          SQL := SQL + '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITEBOM'));

        If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITEENE')) Then
          SQL := SQL + '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITEENE'));

        If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITEVID')) Then
          SQL := SQL + '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITEVID'));

        If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITETAX')) Then
          SQL := SQL + '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITETAX'));

        If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('PROMAT')) Then
          SQL := SQL + '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('PROMAT'));

        If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITECON')) Then
          SQL := SQL + '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITECON'));

        SQL := SQL + '  AND ITE_DESITE NOT LIKE "%ITEM ESPECIAL%"           ';

        ParamByName('CODITE').AsString := DisplayValue;
        Open;

        If FieldByName('QTD').AsInteger <= 0 Then
        Begin
          TAutcomTintaFactory.Get.fMensagem('ATENÇÃO', 'Produto Venda não encontrado, favor verificar !', ['&Ok']);
          DisplayValue := '';
          Error := True;
        End;
      End;
    Except

    End;
  End;
end;

function TConfiguradorPpgNexa.ConfigurarClick(const strCodCfg,strValCfg: string): string;
begin
  Result := fConsultaProdutoEmbalagem(strValCfg);
end;

procedure TConfiguradorPpgNexa.ConfigurarValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
var
  qryValida: IDataSet;
begin
  If Not TStrUtils.fEmptyStr(DisplayValue) Then
  Begin
    Try
      Error := False;
      qryValida := TAutcomTintaFactory.Get.fGetDataSet;

      With qryValida Do
      Begin
        SQL := 'SELECT                  ' +
               '  COUNT(*) AS QTD       ' +
               '  FROM                  ' +
               '    CADITE              ' +
               ' WHERE                  ' +
               '   ITE_CODITE = :CODITE ' +
               '   AND ITE_ITEATI = "S" ' +
               '   AND ITE_PROEMB = "S" ';

        If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITESER')) Then
          SQL := SQL + '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITESER'));

        If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('SERTER')) Then
          SQL := SQL + '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('SERTER'));

        If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITEFRE')) Then
          SQL := SQL + '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITEFRE'));

        If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITEBOM')) Then
          SQL := SQL + '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITEBOM'));

        If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITEENE')) Then
          SQL := SQL + '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITEENE'));

        If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITEVID')) Then
          SQL := SQL + '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITEVID'));

        If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITETAX')) Then
          SQL := SQL + '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITETAX'));

        If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('PROMAT')) Then
          SQL := SQL + '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('PROMAT'));

        If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITECON')) Then
          SQL := SQL + '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITECON'));

        SQL := SQL + '  AND ITE_DESITE NOT LIKE "%ITEM ESPECIAL%"           ';

        ParamByName('CODITE').AsString := DisplayValue;
        Open;

        If FieldByName('QTD').AsInteger <= 0 Then
        Begin
          TAutcomTintaFactory.Get.fMensagem('ATENÇÃO', 'Produto não encontrado, favor verificar !', ['&Ok']);
          DisplayValue := '';
          Error := True;
        End;
      End;
    Except

    End;
  End;
end;

constructor TConfiguradorPpgNexa.Create(const auttin: IAuttinWrapper);
begin

  inherited Create(TLibTintaFactory.GetLibTinta.GetIdePro, auttin);

  Configurar('USAFOR', 'Utilizar Formulação',                   'S'  , tpSimNao,      'GERAL');
  Configurar('USATIN', 'Utilizar essa tinta de máquina',        'S'  , tpSimNao,      'GERAL');
  Configurar('MODVEN', 'Modo de Venda',                         '0'  , tpModoVenda,   'GERAL');
  Configurar('DESOPE', 'Despesas Operacionais da Tinta (%)',           '0,00', tpNumeroDecimal, 'GERAL');
  Configurar('APREVE', 'Acréscimo Adicional sobre Preço de Venda (%)', '0,00', tpNumeroDecimal, 'GERAL');
  Configurar('ACUABS', 'Valores da Formulação: (1 - Acumulada / 2 - Absoluta)', '2', tpAcuAbs, 'GERAL');
  Configurar('DTAATU', 'Data da Última Atualização'      , '' , tpData,    'GERAL');
  Configurar('VERSAO', 'Versão da máquina'               , '' , tpNormal,  'GERAL');
  Configurar('PROACS', 'Produto para venda - ACS Evolution(LA) ', ''   , tpBotaoVenda,    'GERAL');
  Configurar('PRODEF', 'Produto para venda - Delfleet'          , ''   , tpBotaoVenda,    'GERAL');
  Configurar('PRODET', 'Produto para venda - Deltron'           , ''   , tpBotaoVenda,    'GERAL');
  Configurar('PROIND', 'Produto para venda - Industran'         , ''   , tpBotaoVenda,    'GERAL');
  Configurar('PROENV', 'Produto para venda - Envirobase HP'     , ''   , tpBotaoVenda,    'GERAL');
  Configurar('TRAPPX', 'Trava para valor de venda PPX_PRE', 'VEN', tpTravaPreco,    'GERAL');
  Configurar('FATPPX', 'Fator',                             '1'  , tpNumeroDecimal, 'GERAL');
  Configurar('PROCOD', 'Próximo código novas fórmulas',     '1'  , tpNumero_5,      'GERAL');
  Configurar('ACRMOB', 'Acréscimo de mão de obra será em:', '0', tpAcrMob, 'GERAL');
  Configurar('USAINV', 'Utilizar rotina de importação para Novas Fórmulas:', 'N', tpSimNao, 'GERAL');
  Configurar('DECNFM', 'Quantidade de casas decimais que serão exibidas nas quantidades da nova fórmula (1, 2 ou 3)', '2', tpNumero, 'GERAL');
  Configurar('PATPPX', 'Path para arquivos (*.txt)', '', tpDiretorio, 'PATH ARQUIVOS');
  Configurar('PATINV', 'Path para importação de novas fórmulas', '', tpDiretorioNv, 'PATH ARQUIVOS');
  // LITRO
  Configurar('PXLTAC', 'Litro - ACS Evolution(LA)', '' , tpBotao, 'EMBALAGEM ');
  Configurar('PXLTDF', 'Litro - Delfleet'         , '' , tpBotao, 'EMBALAGEM');
  Configurar('PXLTDT', 'Litro - Deltron'          , '' , tpBotao, 'EMBALAGEM');
  Configurar('PXLTIN', 'Litro - Industran'        , '' , tpBotao, 'EMBALAGEM');
  Configurar('PXLTEN', 'Litro - Envirobase HP'    , '' , tpBotao, 'EMBALAGEM');
  Configurar('VOLLAC', 'Volume Máximo Litro - ACS Evolution(LA)', '1,000', tpVolumeEmb, 'VOLUME');
  Configurar('VOLLDF', 'Volume Máximo Litro - Defleet', '1,000', tpVolumeEmb, 'VOLUME');
  Configurar('VOLLDT', 'Volume Máximo Litro - Deltron', '1,000', tpVolumeEmb, 'VOLUME');
  Configurar('VOLLIN', 'Volume Máximo Litro - Industran', '1,000', tpVolumeEmb, 'VOLUME');
  Configurar('VOLLEN', 'Volume Máximo Litro - Envirobase HP', '1,000', tpVolumeEmb, 'VOLUME');

  // GALÃO
  Configurar('PXGLAC', 'Galão - ACS Evolution(LA)', '' , tpBotao, 'EMBALAGEM');
  Configurar('PXGLDF', 'Galão - Delfleet'         , '' , tpBotao, 'EMBALAGEM');
  Configurar('PXGLDT', 'Galão - Deltron'          , '' , tpBotao, 'EMBALAGEM');
  Configurar('PXGLIN', 'Galão - Industran'        , '' , tpBotao, 'EMBALAGEM');
  Configurar('PXGLEN', 'Galão - Envirobase HP'    , '' , tpBotao, 'EMBALAGEM');
  Configurar('VOLGAC', 'Volume Máximo Galão - ACS Evolution(LA)', '3,600', tpVolumeEmb, 'VOLUME');
  Configurar('VOLGDF', 'Volume Máximo Galão - Delfleet', '3,600', tpVolumeEmb, 'VOLUME');
  COnfigurar('VOLGDT', 'Volume Máximo Galão - Deltron', '3,600', tpVolumeEmb, 'VOLUME');
  Configurar('VOLGIN', 'Volume Máximo Galão - Industran', '3,600', tpVolumeEmb, 'VOLUME');
  Configurar('VOLGEN', 'Volume Máximo Galão - Envirobase HP', '3,600', tpVolumeEmb, 'VOLUME');

  // BALDE
  Configurar('PXBDAC', 'Balde - ACS Evolution(LA)', '' , tpBotao, 'EMBALAGEM');
  Configurar('PXBDDF', 'Balde - Delfleet'         , '' , tpBotao, 'EMBALAGEM');
  Configurar('PXBDDT', 'Balde - Deltron(LA)'      , '' , tpBotao, 'EMBALAGEM');
  Configurar('PXBDIN', 'Balde - Industran'        , '' , tpBotao, 'EMBALAGEM');
  Configurar('PXBDEN', 'Balde - Envirobase HP'    , '' , tpBotao, 'EMBALAGEM');
  Configurar('VOLBAC', 'Volume Máximo Balde - ACS Evolution(LA)', '18,000', tpVolumeEmb, 'VOLUME');
  Configurar('VOLBDF', 'Volume Máximo Balde - Delfleet', '18,000', tpVolumeEmb, 'VOLUME');
  Configurar('VOLBDT', 'Volume Máximo Balde - Deltron', '18,000', tpVolumeEmb, 'VOLUME');
  Configurar('VOLBIN', 'Volume Máximo Balde - Industran', '18,000', tpVolumeEmb, 'VOLUME');
  Configurar('VOLBEN', 'Volume Máximo Balde - Envirobase HP', '18,000', tpVolumeEmb, 'VOLUME');

  // TAMBOR
  Configurar('PXTBAC', 'Tambor - ACS Evolution(LA)', '' , tpBotao, 'EMBALAGEM');
  Configurar('PXTBDF', 'Tambor - Delfleet'         , '' , tpBotao, 'EMBALAGEM');
  Configurar('PXTBDT', 'Tambor - Deltron(LA)'      , '' , tpBotao, 'EMBALAGEM');
  Configurar('PXTBIN', 'Tambor - Industran'        , '' , tpBotao, 'EMBALAGEM');
  Configurar('PXTBEN', 'Tambor - Envirobase HP'    , '' , tpBotao, 'EMBALAGEM');
  Configurar('VOLTAC', 'Volume Máximo Tambor - ACS Evolution(LA)', '200,000', tpVolumeEmb, 'VOLUME');
  Configurar('VOLTDF', 'Volume Máximo Tambor - Delfleet', '200,000', tpVolumeEmb, 'VOLUME');
  Configurar('VOLTDT', 'Volume Máximo Tambor - Deltron', '200,000', tpVolumeEmb, 'VOLUME');
  Configurar('VOLTIN', 'Volume Máximo Tambor - Industran', '200,000', tpVolumeEmb, 'VOLUME');
  Configurar('VOLTEN', 'Volume Máximo Tambor - Envirobase HP', '200,000', tpVolumeEmb, 'VOLUME');

  // COPO
  Configurar('PXCOPO', 'Copo'        , '' , tpBotao, 'EMBALAGEM');
  Configurar('VOLCOP', 'Volume Máximo Copo', '0,500', tpVolumeEmb, 'VOLUME');
  //SPRAY
  Configurar('PSPRAY', 'Spray'       , '' , tpBotao, 'EMBALAGEM');
  Configurar('VOLSPR', 'Volume Máximo Spray', '0,450', tpVolumeEmb, 'VOLUME');
end;

{$IFNDEF LINUX}
function TConfiguradorPpgNexa.DiretorioValidar(strDir: String): string;
var
  odSel: TOpenDialog;
begin
  if FileExists(strDir) then
    Result := strDir
  Else
    Result := 'C:\';

  Try
    odSel := TOpenDialog.Create(Nil);

    odSel.DefaultExt := '.txt*';
    odSel.FileName   := '*.txt*';
    odSel.Title      := 'Selecione um Arquivo Txt';
    odSel.InitialDir := Result;
    If odSel.Execute then
      Result := odSel.FileName;
  Finally
    FreeAndNil(odSel);
  End;
end;
{$ENDIF}

{$IFNDEF LINUX}
function TConfiguradorPpgNexa.DiretorioValidarNv(strDiretorio,
  strNomCam: String): String;
var
{$WARN SYMBOL_PLATFORM OFF}
  Dialogo: TFileOpenDialog;
{$WARN SYMBOL_PLATFORM ON}
begin
  If DirectoryExists(strDiretorio) Then
    Result := strDiretorio
  Else
    Result := 'C:\';

{$WARN SYMBOL_PLATFORM OFF}
  Try
    Dialogo := TFileOpenDialog.Create(nil);
    Dialogo.Options       := [fdoPickFolders, fdoPathMustExist, fdoForceFileSystem];
    Dialogo.OkButtonLabel := 'Selecionar';
    Dialogo.DefaultFolder := Result;
    Dialogo.FileName      := Result;

    If Dialogo.Execute Then
      Result := Dialogo.FileName;
  Finally
    FreeAndNil(Dialogo);
  End;
{$WARN SYMBOL_PLATFORM ON}
end;
{$ENDIF}

function TConfiguradorPpgNexa.fConsultaProdutoEmbalagem(const strValCfg: String): String;
var
  strSQL, strSQLWhere: String;
  qryCadIte : IDataSet;
  arrTitCol: Array of String;

  Procedure pAddNomeColuna(strNomCol: String);
  Begin
    SetLength(arrTitCol, Succ(Length(arrTitCol)));
    arrTitCol[High(arrTitCol)] := strNomCol;
  End;

begin
  qryCadIte := Nil;

  Result := strValCfg;
  Try

    strSQL := 'SELECT';
    strSQL := strSQL + '   ITE_DESITE, ';  pAddNomeColuna('Descrição');
    strSQL := strSQL + '   ITE_REFERE, ';  pAddNomeColuna('Referência');
    strSQL := strSQL + '   ITE_CODITE, ';  pAddNomeColuna('Código');
    strSQL := strSQL + '   ITE_CODBAR, ';  pAddNomeColuna('Cód. Barra');
    strSQL := strSQL + '   AUTOINCREM  ';
    strSQL := strSQL + ' FROM CADITE ';
    strSQLWhere := strSQLWhere + ' WHERE ITE_ITEATI = "S" ';
    strSQLWhere := strSQLWhere + '   AND ITE_PROEMB = "S" ';

    If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITESER')) Then
      strSQLWhere := strSQLWhere + '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITESER'));

    If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('SERTER')) Then
      strSQLWhere := strSQLWhere + '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('SERTER'));

    If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITEFRE')) Then
      strSQLWhere := strSQLWhere + '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITEFRE'));

    If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITEBOM')) Then
      strSQLWhere := strSQLWhere + '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITEBOM'));

    If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITEENE')) Then
      strSQLWhere := strSQLWhere + '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITEENE'));

    If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITEVID')) Then
      strSQLWhere := strSQLWhere + '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITEVID'));

    If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITETAX')) Then
      strSQLWhere := strSQLWhere + '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITETAX'));

    If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('PROMAT')) Then
      strSQLWhere := strSQLWhere + '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('PROMAT'));

    If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITECON')) Then
      strSQLWhere := strSQLWhere + '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITECON'));

    strSQLWhere := strSQLWhere + '  AND ITE_DESITE NOT LIKE "%ITEM ESPECIAL%"           ';

  {$IFNDEF LINUX}
    If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere], arrTitCol, ['ITE_DESITE'], 'AUTOINCREM',
                                             'CADITE', 'untConfiguradorPpgNexa', 'Consulta Item - Ppg/Nexa', qryCadIte, [], []) Then
    Begin
      Result := qryCadIte.FieldByName('ITE_CODITE').AsString;
    End;
  {$ENDIF}

  Finally
  End;
end;

function TConfiguradorPpgNexa.fConsultaProdutoVenda(
  const strValCfg: String): String;
var
  strSQL, strSQLWhere: String;
  qryCadIte : IDataSet;

  arrTitCol: array of string;

  Procedure pAddNomeColuna(strNomCol: String);
  Begin
    SetLength(arrTitCol, Succ(Length(arrTitCol)));
    arrTitCol[High(arrTitCol)] := strNomCol;
  End;

begin
  qryCadIte := Nil;

  Result := strValCfg;
  Try
    strSQL := 'SELECT';
    strSQL := strSQL + '   ITE_DESITE, ';  pAddNomeColuna('Descrição');
    strSQL := strSQL + '   ITE_REFERE, ';  pAddNomeColuna('Referência');
    strSQL := strSQL + '   ITE_CODITE, ';  pAddNomeColuna('Código');
    strSQL := strSQL + '   ITE_CODBAR, ';  pAddNomeColuna('Cód. Barra');
    strSQL := strSQL + '   AUTOINCREM  ';
    strSQL := strSQL + ' FROM CADITE ';
    strSQLWhere := strSQLWhere + ' WHERE ITE_ITEATI = "S" ';

    If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITESER')) Then
      strSQLWhere := strSQLWhere + '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITESER'));

    If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('SERTER')) Then
      strSQLWhere := strSQLWhere + '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('SERTER'));

    If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITEFRE')) Then
      strSQLWhere := strSQLWhere + '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITEFRE'));

    If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITEBOM')) Then
      strSQLWhere := strSQLWhere + '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITEBOM'));

    If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITEENE')) Then
      strSQLWhere := strSQLWhere + '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITEENE'));

    If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITEVID')) Then
      strSQLWhere := strSQLWhere + '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITEVID'));

    If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITETAX')) Then
      strSQLWhere := strSQLWhere + '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITETAX'));

    If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('PROMAT')) Then
      strSQLWhere := strSQLWhere + '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('PROMAT'));

    If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITECON')) Then
      strSQLWhere := strSQLWhere + '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITECON'));

    strSQLWhere := strSQLWhere + '  AND ITE_DESITE NOT LIKE "%ITEM ESPECIAL%"           ';

  {$IFNDEF LINUX}
    If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere], arrTitCol, ['ITE_DESITE'], 'AUTOINCREM',
                                             'CADITE', 'untConfiguradorPpgNexa', 'Consulta Item - Ppg/Nexa', qryCadIte, [], []) Then
    Begin
      Result := qryCadIte.FieldByName('ITE_CODITE').AsString;
    End;
  {$ENDIF}

  Finally
  End;
end;

function TConfiguradorPpgNexa.fRetornarEmbalagemPrincipal(strCodCfg: String): String;
Var
  qryAux: IDataSet;
begin
  qryAux := TAutcomTintaFactory.Get.fGetDataSet;
  qryAux.SQL := 'SELECT CFG_CODITE '+
                '  FROM CFGEMB '+
                ' WHERE CFG_CODEMP = :CODEMP '+
                '   AND CFG_CODCFG = :CODCFG '+
                '   AND CFG_IDEPRO = "PPX" '+
                '   AND CFG_PRINCI = "S" ';
  qryAux.ParamByName('CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryAux.ParamByName('CODCFG').AsString := strCodCfg;
  qryAux.Open;

  Result := qryAux.FieldByName('CFG_CODITE').AsString;

end;

procedure TConfiguradorPpgNexa.NumeroValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean; const strNomCam: String);
begin
  Error := False;
  If strNomCam = 'DECNFM' Then
  Begin
    If Pos(DisplayValue, '1_2_3_') <= 0 Then
    Begin
      Error := True;
      TAutcomTintaFactory.Get.fMensagem('ATENÇÃO', 'A Configuração: Quantidade de casas decimais que serão' + #13#10 +
                                                   'exibidas nas quantidades da nova fórmula,' + #13#10 +
                                                   'aceita somente os números: 1, 2 ou 3', ['&Ok']);
    End;
  End;
end;

procedure TConfiguradorPpgNexa.pGetInfConfEmb(strCodCfg: String; var strEmbalagem, strLinha: String);
Var
  qryAux  : IDataSet;
  strDesc : String;
begin
  qryAux := TAutcomTintaFactory.Get.fGetDataSet;
  qryAux.SQL := ' SELECT CFG_DESCRI '+
                '  FROM CFGTIN '+
                ' WHERE CFG_IDEPRO = "PPX" '+
                '   AND CFG_CODCFG = :CODCFG '+
                '   AND CFG_CODEMP = :CODEMP ';

  qryAux.ParamByName('CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryAux.ParamByName('CODCFG').AsString := strCodCfg;
  qryAux.Open;

  strDesc := qryAux.fieldByName('CFG_DESCRI').AsString;

  strEmbalagem := AnsiUpperCase(Trim(Copy(strDesc , 0, pos('-',strDesc) -1)));

  strLinha := AnsiUpperCase(Trim(Copy(strDesc, pos( '-' , strDesc) + 1 , length(strDesc)  )));

end;

end.
