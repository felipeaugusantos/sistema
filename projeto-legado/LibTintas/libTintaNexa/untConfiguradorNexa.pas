{********************************************************************************}
{* Classes responsável por configurar a tela de configurações da tinta NEX *}
{*****************************************************************************AC*}
unit untConfiguradorNexa;

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
  TConfiguradorNexa = class(TAbstractConfiguradorTinta, IConfiguradorTinta)
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

    function fRetornarEmbalagemPrincipal(strCodCfg : String) : String;

    procedure pGetInfConfEmb(strCodCfg : String; Var strEmbalagem, strLinha : String);

  end;

implementation

uses
{$IFNDEF LINUX}
  untCadEmbTintaNexa,
{$ENDIF}
  untLibTintaFactory, System.Variants;

{ TConfiguradorNexa }

function TConfiguradorNexa.BotaoVendaClick(const strCodCfg,
  strValCfg: string): string;
begin
  Result := fConsultaProdutoVenda(strValCfg);
end;

procedure TConfiguradorNexa.BotaoVendaValidar(var DisplayValue: Variant;
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

function TConfiguradorNexa.ConfigurarClick(const strCodCfg,strValCfg: string): string;
begin
  Result := fConsultaProdutoEmbalagem(strValCfg);
end;

procedure TConfiguradorNexa.ConfigurarValidar(var DisplayValue: Variant;
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

constructor TConfiguradorNexa.Create(const auttin: IAuttinWrapper);
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
  Configurar('PRONEXA', 'Produto para venda 2K'             , ''   , tpBotaoVenda,    'GERAL');
  Configurar('PROACS',  'Produto para venda ACS'            , ''   , tpBotaoVenda,    'GERAL');
  Configurar('PROIND',  'Produto para venda Industran'      , ''   , tpBotaoVenda,    'GERAL');
  Configurar('PROSPE',  'Produto para venda Spectral Grey'  , ''   , tpBotaoVenda,    'GERAL');
  Configurar('PROZYN',  'Produto para venda Zynamix'        , ''   , tpBotaoVenda,    'GERAL');
  Configurar('PROEVO',  'Produto para venda ACS Evolution'  , ''   , tpBotaoVenda,    'GERAL');
  Configurar('PROTUR',  'Produto para venda Turbo Plus'     , ''   , tpBotaoVenda,    'GERAL');
  Configurar('TRANEXA', 'Trava para valor de venda NEX_PRE', 'VEN', tpTravaPreco,    'GERAL');
  Configurar('FATNEXA', 'Fator',                             '1'  , tpNumeroDecimal, 'GERAL');
  Configurar('PROCOD', 'Próximo código novas fórmulas',     '1'  , tpNumero_5,      'GERAL');
  Configurar('ACRMOB', 'Acréscimo de mão de obra será em:', '0', tpAcrMob, 'GERAL');
  Configurar('DECNFM', 'Quantidade de casas decimais que serão exibidas nas quantidades da nova fórmula (1, 2 ou 3)', '2', tpNumero, 'GERAL');
  Configurar('PATNEXA', 'Path para arquivos (*.txt)', '', tpDiretorio, 'PATH ARQUIVOS');
  Configurar('NEXAPMG2K', 'Embalagem Galão 2K'              ,'' , tpBotao, 'EMBALAGEM ');
  Configurar('NEXAPMGAC', 'Embalagem Galão ACS'             ,'' , tpBotao, 'EMBALAGEM ');
  Configurar('NEXAPMGIN', 'Embalagem Galão Industran'       ,'' , tpBotao, 'EMBALAGEM ');
  Configurar('NEXAPMGSG', 'Embalagem Galão Spectral grey'   ,'' , tpBotao, 'EMBALAGEM ');
  Configurar('NEXAPMGZY', 'Embalagem Galão Zynamix'         ,'' , tpBotao, 'EMBALAGEM ');
  Configurar('NEXAPMGEV', 'Embalagem Galão ACS Evolution '  ,'' , tpBotao, 'EMBALAGEM ');
  Configurar('NEXAPMGTP', 'Embalagem Galão Turbo Plus'      ,'' , tpBotao, 'EMBALAGEM ');
  Configurar('NEXAPML2K', 'Embalagem Litro 2K'              ,'' , tpBotao, 'EMBALAGEM ');
  Configurar('NEXAPMLAC', 'Embalagem Litro ACS'             ,'' , tpBotao, 'EMBALAGEM ');
  Configurar('NEXAPMLIN', 'Embalagem Litro Industran'       ,'' , tpBotao, 'EMBALAGEM ');
  Configurar('NEXAPMLSG', 'Embalagem Litro Spectral grey'   ,'' , tpBotao, 'EMBALAGEM ');
  Configurar('NEXAPMLZY', 'Embalagem Litro Zynamix'         ,'' , tpBotao, 'EMBALAGEM ');
  Configurar('NEXAPMLEV', 'Embalagem Litro ACS Evolution '  ,'' , tpBotao, 'EMBALAGEM ');
  Configurar('NEXAPMLTP', 'Embalagem Litro Turbo Plus'      ,'' , tpBotao, 'EMBALAGEM ');
  Configurar('NEXAPMLA2K','Embalagem Balde 2K'              ,'' , tpBotao, 'EMBALAGEM ');
  Configurar('NEXAPMLAAC','Embalagem Balde ACS'             ,'' , tpBotao, 'EMBALAGEM ');
  Configurar('NEXAPMLAIN','Embalagem Balde Industran'       ,'' , tpBotao, 'EMBALAGEM ');
  Configurar('NEXAPMLASG','Embalagem Balde Spectral grey'   ,'' , tpBotao, 'EMBALAGEM ');
  Configurar('NEXAPMLAZY','Embalagem Balde Zynamix'         ,'' , tpBotao, 'EMBALAGEM ');
  Configurar('NEXAPMLAEV','Embalagem Balde ACS Evolution'   ,'' , tpBotao, 'EMBALAGEM ');
  Configurar('NEXAPMLATP','Embalagem Balde Turbo Plus'      ,'' , tpBotao, 'EMBALAGEM ');
  Configurar('NEXAPMT2K', 'Embalagem Tambor 2K'             ,'' , tpBotao, 'EMBALAGEM ');
  Configurar('NEXAPMTAC', 'Embalagem Tambor ACS'            ,'' , tpBotao, 'EMBALAGEM ');
  Configurar('NEXAPMTIN', 'Embalagem Tambor Industran'      ,'' , tpBotao, 'EMBALAGEM ');
  Configurar('NEXAPMTSG', 'Embalagem Tambor Spectral grey'  ,'' , tpBotao, 'EMBALAGEM ');
  Configurar('NEXAPMTZY', 'Embalagem Tambor Zynamix'        ,'' , tpBotao, 'EMBALAGEM ');
  Configurar('NEXAPMTEV', 'Embalagem Tambor ACS Evolution'  ,'' , tpBotao, 'EMBALAGEM ');
  Configurar('NEXAPMTTP', 'Embalagem Tambor Turbo Plus'     ,'' , tpBotao, 'EMBALAGEM ');
  Configurar('NEXACOP',   'Copo'                            ,'' , tpBotao, 'EMBALAGEM');
  Configurar('VOLPMG2K', 'Volume Máximo Embalagem Galão 2K',  '3,500', tpVolumeEmb, 'VOLUME');
  Configurar('VOLPMGAC', 'Volume Máximo Embalagem Galão ACS', '3,500', tpVolumeEmb, 'VOLUME');
  Configurar('VOLPMGIN', 'Volume Máximo Embalagem Galão Industran', '3,500', tpVolumeEmb, 'VOLUME');
  Configurar('VOLPMGSG', 'Volume Máximo Embalagem Galão Spectral Grey', '3,500', tpVolumeEmb, 'VOLUME');
  Configurar('VOLPMGZY', 'Volume Máximo Embalagem Galão Zynamix', '3,500', tpVolumeEmb, 'VOLUME');
  Configurar('VOLPMGEV', 'Volume Máximo Embalagem Galão ACS Evolution', '3,500', tpVolumeEmb, 'VOLUME');
  Configurar('VOLPMGTP', 'Volume Máximo Embalagem Galão Turbo Plus', '3,500', tpVolumeEmb, 'VOLUME');
  Configurar('VOLPML2K', 'Volume Máximo Embalagem Litro 2K', '1,000', tpVolumeEmb, 'VOLUME');
  Configurar('VOLPMLAC', 'Volume Máximo Embalagem Litro ACS', '1,000', tpVolumeEmb, 'VOLUME');
  Configurar('VOLPMLIN', 'Volume Máximo Embalagem Litro Industran', '1,000', tpVolumeEmb, 'VOLUME');
  Configurar('VOLPMLSG', 'Volume Máximo Embalagem Litro Spectral Grey', '1,000', tpVolumeEmb, 'VOLUME');
  Configurar('VOLPMLZY', 'Volume Máximo Embalagem Litro Zynamix', '1,000', tpVolumeEmb, 'VOLUME');
  Configurar('VOLPMLEV', 'Volume Máximo Embalagem Litro ACS Evolution', '1,000', tpVolumeEmb, 'VOLUME');
  Configurar('VOLPMLTP', 'Volume Máximo Embalagem Litro Turbo Plus', '1,000', tpVolumeEmb, 'VOLUME');
  Configurar('VOLPMB2K', 'Volume Máximo Embalagem Balde 2K', '18,000', tpVolumeEmb, 'VOLUME');
  Configurar('VOLPMBAC', 'Volume Máximo Embalagem Balde ACS', '18,000', tpVolumeEmb, 'VOLUME');
  Configurar('VOLPMBIN', 'Volume Máximo Embalagem Balde Industran', '18,000', tpVolumeEmb, 'VOLUME');
  Configurar('VOLPMBSG', 'Volume Máximo Embalagem Balde Spectral Grey', '18,000', tpVolumeEmb, 'VOLUME');
  Configurar('VOLPMBZY', 'Volume Máximo Embalagem Balde Zynamix', '18,000', tpVolumeEmb, 'VOLUME');
  Configurar('VOLPMBEV', 'Volume Máximo Embalagem Balde ACS Evolution', '18,000', tpVolumeEmb, 'VOLUME');
  Configurar('VOLPMBTP', 'Volume Máximo Embalagem Balde Turbo Plus', '18,000', tpVolumeEmb, 'VOLUME');
  Configurar('VOLPMT2K', 'Volume Máximo Embalagem Tambor 2K', '200,000', tpVolumeEmb, 'VOLUME');
  Configurar('VOLPMTAC', 'Volume Máximo Embalagem Tambor ACS', '200,000', tpVolumeEmb, 'VOLUME');
  Configurar('VOLPMTIN', 'Volume Máximo Embalagem Tambor Industran', '200,000', tpVolumeEmb, 'VOLUME');
  Configurar('VOLPMTSG', 'Volume Máximo Embalagem Tambor Spectral Grey', '200,000', tpVolumeEmb, 'VOLUME');
  Configurar('VOLPMTZY', 'Volume Máximo Embalagem Tambor Zynamix', '200,000', tpVolumeEmb, 'VOLUME');
  Configurar('VOLPMTEV', 'Volume Máximo Embalagem Tambor ACS Evolution', '200,000', tpVolumeEmb, 'VOLUME');
  Configurar('VOLPMTTP', 'Volume Máximo Embalagem Tambor Turbo Plus', '200,000', tpVolumeEmb, 'VOLUME');
  Configurar('VOLUCOPO', 'Volume Máximo Embalagem Copo', '0,500', tpVolumeEmb, 'VOLUME');
  Configurar('PSPRAY', 'Spray'       , '' , tpBotao, 'EMBALAGEM');
  Configurar('VOLSPR', 'Volume Máximo Spray', '0,450', tpVolumeEmb, 'VOLUME');
end;

{$IFNDEF LINUX}
function TConfiguradorNexa.DiretorioValidar(strDir: String): string;
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

function TConfiguradorNexa.fConsultaProdutoEmbalagem(const strValCfg: String): String;
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
                                             'CADITE', 'untConfiguradorNexa', 'Consulta Item - NEX', qryCadIte, [], []) Then
    Begin
      Result := qryCadIte.FieldByName('ITE_CODITE').AsString;
    End;
  {$ENDIF}

  Finally
  End;
end;

function TConfiguradorNexa.fConsultaProdutoVenda(
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
                                             'CADITE', 'untConfiguradorNexa', 'Consulta Item - NEX', qryCadIte, [], []) Then
    Begin
      Result := qryCadIte.FieldByName('ITE_CODITE').AsString;
    End;
  {$ENDIF}

  Finally
  End;
end;

function TConfiguradorNexa.fRetornarEmbalagemPrincipal(strCodCfg: String): String;
Var
  qryAux: IDataSet;
begin
  qryAux := TAutcomTintaFactory.Get.fGetDataSet;
  qryAux.SQL := 'SELECT CFG_CODITE '+
                '  FROM CFGEMB '+
                ' WHERE CFG_CODEMP = :CODEMP '+
                '   AND CFG_CODCFG = :CODCFG '+
                '   AND CFG_IDEPRO = "NEX" '+
                '   AND CFG_PRINCI = "S" ';
  qryAux.ParamByName('CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryAux.ParamByName('CODCFG').AsString := strCodCfg;
  qryAux.Open;

  Result := qryAux.FieldByName('CFG_CODITE').AsString;

end;

procedure TConfiguradorNexa.NumeroValidar(var DisplayValue: Variant;
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

procedure TConfiguradorNexa.pGetInfConfEmb(strCodCfg: String; var strEmbalagem, strLinha: String);
Var
  qryAux  : IDataSet;
  strDesc : String;
begin
  qryAux := TAutcomTintaFactory.Get.fGetDataSet;
  qryAux.SQL := ' SELECT CFG_DESCRI '+
                '  FROM CFGTIN '+
                ' WHERE CFG_IDEPRO = "NEX" '+
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
