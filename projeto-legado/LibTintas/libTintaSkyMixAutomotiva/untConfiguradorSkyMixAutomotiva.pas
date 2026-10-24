{********************************************************************************}
{* Classes responsável por configurar a tela de configurações da tinta SkyMixAutomotiva *}
{*****************************************************************************AC*}
unit untConfiguradorSkyMixAutomotiva;

interface

uses
{$IFNDEF LINUX}
  Controls,
  Dialogs,
{$ENDIF}
  untIConfiguradorTinta, untAbstractConfiguradorTinta, untIAuttinWrapper,
  SysUtils, untIDataSet, untAutcomTintaFactory, untStrUtils, untTypesSistema;

type
  TConfiguradorSkyMixAutomotiva = class(TAbstractConfiguradorTinta, IConfiguradorTinta)
  private
    function fConsultaProdutoEmbalagem(const strValCfg: String): String;
    function fConsultaProdutoVenda(const strValCfg: String): String;
    function fConsultaUnidade(const strValCfg:String):String;
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
  end;

implementation

uses
  untLibTintaFactory;

{ TConfiguradorSkyMixAutomotiva }

function TConfiguradorSkyMixAutomotiva.BotaoVendaClick(const strCodCfg,
  strValCfg: string): string;
begin
  Result := fConsultaProdutoVenda(strValCfg);
end;

procedure TConfiguradorSkyMixAutomotiva.BotaoVendaValidar(var DisplayValue: Variant;
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

function TConfiguradorSkyMixAutomotiva.ConfigurarClick(const strCodCfg,
  strValCfg: string): string;
begin
  If Pos(strCodCfg, 'SKYUGL_SKYULT_SKYULA_') > 0 Then
    Result := fConsultaUnidade(strValCfg)
  Else
    Result := fConsultaProdutoEmbalagem(strValCfg);
end;

procedure TConfiguradorSkyMixAutomotiva.ConfigurarValidar(var DisplayValue: Variant;
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

constructor TConfiguradorSkyMixAutomotiva.Create(const auttin: IAuttinWrapper);
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetIdePro, auttin);

    Configurar('USATIN', 'Utilizar essa tinta de máquina:            ', 'S'            , tpSimNao         , 'GERAL');
    Configurar('USAFOR', 'Utilizar Formulação:                       ', 'S'            , tpSimNao         , 'GERAL');
    Configurar('MODVEN', 'Modo de Venda                              ', '0'            , tpModoVenda      , 'GERAL');
    Configurar('ACUABS', 'Valores da Formulação: (1 - Acumulada / 2 - Absoluta)', '2'  , tpAcuAbs     , 'GERAL');
    Configurar('SKYNFM', 'Próximo Código Novas Fórmulas:             ', '00001'        , tpNumero_5       , 'GERAL');
    Configurar('SKYTRA', 'Trava para valor de venda (SKY_PRE):       ', 'VEN'          , tpTravaPreco     , 'GERAL');
    Configurar('SKYFAT', 'Fator da trava:                            ', '1'            , tpNumeroDecimal  , 'GERAL');
    Configurar('DESOPE', 'Despesas Operacionais (%):                 ', '0,00'         , tpNumeroDecimal  , 'GERAL');
    Configurar('APREVE', 'Acréscimo Adicional sobre Preço de Venda (%):  ', '0,00'         , tpNumeroDecimal  , 'GERAL');
    Configurar('SKYPRO', 'Produto para Venda:                        ', ''             , tpBotaoVenda     , 'GERAL');
    Configurar('DTAATU', 'Data da ultima atualização:                ', ''             , tpData           , 'GERAL');
    Configurar('VERSAO', 'Versão da Máquina:                         ', ''             , tpNormal         , 'GERAL');
    Configurar('ACRMOB', 'Acréscimo de mão de obra será em:', '0', tpAcrMob, 'GERAL');
    Configurar('SKYULA', 'Lata:             ',  ''  , tpBotao, 'UNIDADES');
    Configurar('SKYULT', 'Litro:            ',  ''  , tpBotao, 'UNIDADES');
    Configurar('SKYUGL', 'Galão:            ',  ''  , tpBotao, 'UNIDADES');
    Configurar('SKYPAT', 'Arquivo Access 2007 (*.accdb):        ',    '',  tpDiretorio, 'PATH ARQUIVOS');
    Configurar('SKYPQU', 'Embalagem Quarto (LACA):                  ', '', tpBotao, 'EMBALAGEM');
    Configurar('SKYPGA', 'Embalagem Galão (LACA):                   ', '', tpBotao, 'EMBALAGEM');
    Configurar('VOLPQU', 'Volume Máximo Embalagem Quarto(LACA): ', '0,900', tpVolumeEmb, 'EMBALAGEM');
    Configurar('VOLPGA', 'Volume Máximo Embalagem Galão (LACA): ', '3,600', tpVolumeEmb, 'EMBALAGEM');
    Configurar('SKYPQU_POLIESTER', 'Embalagem Quarto (POLIESTER):   ', '', tpBotao, 'EMBALAGEM');
    Configurar('SKYPGA_POLIESTER', 'Embalagem Galão (POLIESTER):    ', '', tpBotao, 'EMBALAGEM');
    Configurar('VOLPQU_POLIESTER', 'Volume Máximo Embalagem Quarto (POLIESTER): ', '0,900', tpVolumeEmb, 'EMBALAGEM');
    Configurar('VOLPGA_POLIESTER', 'Volume Máximo Embalagem Galão (POLISTER): ', '3,600', tpVolumeEmb, 'EMBALAGEM');
    Configurar('SKYPQU_PU', 'Embalagem Quarto (PU):                 ', '', tpBotao, 'EMBALAGEM');
    Configurar('SKYPGA_PU', 'Embalagem Galão (PU):                  ', '', tpBotao, 'EMBALAGEM');
    Configurar('VOLPQU_PU', 'Volume Máximo Embalagem Quarto (PU): ', '0,900', tpVolumeEmb, 'EMBALAGEM');
    Configurar('VOLPGA_PU', 'Volume Máximo Embalagem Galão (PU): ', '3,600', tpVolumeEmb, 'EMBALAGEM');
    Configurar('SKYPQU_SINTETICO', 'Embalagem Quarto (SINTETICO):   ', '', tpBotao, 'EMBALAGEM');
    Configurar('SKYPGA_SINTETICO', 'Embalagem Galão (SINTETICO):    ', '', tpBotao, 'EMBALAGEM');
    Configurar('VOLPQU_SINTETICO', 'Volume Máximo Embalagem Quarto (SINTETICO): ', '0,900', tpVolumeEmb, 'EMBALAGEM');
    Configurar('VOLPGA_SINTETICO', 'Volume Máximo Embalagem Galão (SINTETICO): ', '3,600', tpVolumeEmb, 'EMBALAGEM');
    Configurar('SKYPCP', 'Embalagem Copo:                           ', '', tpBotao, 'EMBALAGEM');
    Configurar('SKYPSP', 'Embalagem Spray:                          ', '', tpBotao, 'EMBALAGEM');
    Configurar('VOLPCP', 'Volume Máximo Embalagem Copo: ', '0,450', tpVolumeEmb, 'EMBALAGEM');
    Configurar('VOLPSP', 'Volume Máximo Embalagem Spray: ', '0,100', tpVolumeEmb, 'EMBALAGEM');
    Configurar('SKYPBD', 'Embalagem Balde:                          ', '', tpBotao, 'EMBALAGEM');
    Configurar('VOLPBD', 'Volume Máximo Embalagem Balde: ', '18,000', tpVolumeEmb, 'EMBALAGEM');
    Configurar('SKYPQU_FROSFL', 'Embalagem Quarto SKYFROTA(SFL):    ', '', tpBotao, 'EMBALAGEM');
    Configurar('SKYPGA_FROSFL', 'Embalagem Galão SKYFROTA(SFL):     ', '', tpBotao, 'EMBALAGEM');
    Configurar('VOLPQU_FROSFL', 'Volume Máximo Embalagem Quarto SKYFROTA(SFL): ', '0,900', tpVolumeEmb, 'EMBALAGEM');
    Configurar('VOLPGA_FROSFL', 'Volume Máximo Embalagem Galão SKYFROTA(SFL): ', '3,600', tpVolumeEmb, 'EMBALAGEM');
    Configurar('SKYPQU_FROSFS', 'Embalagem Quarto SKYFROTA(SFS):    ', '', tpBotao, 'EMBALAGEM');
    Configurar('SKYPGA_FROSFS', 'Embalagem Galão SKYFROTA(SFS):     ', '', tpBotao, 'EMBALAGEM');
    Configurar('VOLPQU_FROSFS', 'Volume Máximo Embalagem Quarto SKYFROTA(SFS): ', '0,900', tpVolumeEmb, 'EMBALAGEM');
    Configurar('VOLPGA_FROSFS', 'Volume Máximo Embalagem Galão SKYFROTA(SFS): ', '3,600', tpVolumeEmb, 'EMBALAGEM');
    Configurar('SKYPQU_FROSFP', 'Embalagem Quarto SKYFROTA(SFP):    ', '', tpBotao, 'EMBALAGEM');
    Configurar('SKYPGA_FROSFP', 'Embalagem Galão SKYFROTA(SFP):     ', '', tpBotao, 'EMBALAGEM');
    Configurar('VOLPQU_FROSFP', 'Volume Máximo Embalagem Quarto SKYFROTA(SFP): ', '0,900', tpVolumeEmb, 'EMBALAGEM');
    Configurar('VOLPGA_FROSFP', 'Volume Máximo Embalagem Galão SKYFROTA(SFP): ', '3,600', tpVolumeEmb, 'EMBALAGEM');
    Configurar('SKYPQU_FROSFE', 'Embalagem Quarto SKYFROTA(SFE):    ', '', tpBotao, 'EMBALAGEM');
    Configurar('SKYPGA_FROSFE', 'Embalagem Galão SKYFROTA(SFE):     ', '', tpBotao, 'EMBALAGEM');
    Configurar('VOLPQU_FROSFE', 'Volume Máximo Embalagem Quarto SKYFROTA(SFE): ', '0,900', tpVolumeEmb, 'EMBALAGEM');
    Configurar('VOLPGA_FROSFE', 'Volume Máximo Embalagem Galão SKYFROTA(SFE): ', '3,600', tpVolumeEmb, 'EMBALAGEM');
end;

{$IFNDEF LINUX}
function TConfiguradorSkyMixAutomotiva.DiretorioValidar(strDir: String): string;
var
 {$WARN SYMBOL_PLATFORM OFF}
  Dialogo: TFileOpenDialog;
{$WARN SYMBOL_PLATFORM ON}
begin
  If DirectoryExists(strDir) Then
    Result := strDir
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

function TConfiguradorSkyMixAutomotiva.fConsultaProdutoEmbalagem(const strValCfg: String): String;
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
                                             'CADITE', 'untConfiguradorSkyMixAutomotiva', 'Consulta Item - SkyMix Automotiva', qryCadIte, [], []) Then
    Begin
      Result := qryCadIte.FieldByName('ITE_CODITE').AsString;
    End;
  {$ENDIF}

  Finally
  End;
end;

function TConfiguradorSkyMixAutomotiva.fConsultaProdutoVenda(
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
                                             'CADITE', 'untConfiguradorSkyMixAutomotiva', 'Consulta Item - SkyMix Automotiva', qryCadIte, [], []) Then
    Begin
      Result := qryCadIte.FieldByName('ITE_CODITE').AsString;
    End;
  {$ENDIF}

  Finally
  End;
end;

function TConfiguradorSkyMixAutomotiva.fConsultaUnidade(
  const strValCfg: String): String;
Var
  strSQL,strSQLWhere:String;
  qryCadUni:IDataSet;
  arrTitUni:Array Of String;

  procedure pAddNomeColuna(strColuna:String);
  Begin
    SetLength(arrTitUni, Succ(Length(arrTitUni)));
    arrTitUni[High(arrTitUni)] := strColuna;
  End;
begin
  Result := strValCfg;
  Try
    Try
      qryCadUni := TAutcomTintaFactory.Get.fGetDataSet;

      strSQL := strSQL + '    SELECT    ';
      strSQL := strSQL + '      U.UNI_CODUNI,     '; pAddNomeColuna('Código');
      strSQL := strSQL + '      U.UNI_DESUNI,     '; pAddNomeColuna('Descrição');
      strSQL := strSQL + '      U.UNI_SIGUNI,     '; pAddNomeColuna('Sigla');
      strSQL := strSQL + '      U.AUTOINCREM      ';
      strSQL := strSQL + '    FROM      ';
      strSQL := strSQL + '      CADUNI U    ';

      strSQLWhere := '      ';

    {$IFNDEF LINUX}
      If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere], arrTitUni, ['UNI_DESUNI'], 'AUTOINCREM', 'CADUNI',
        'untConfiguradorSkyMixAutomotiva', 'Consulta de Unidades - Tintas', qryCadUni, [], []) Then
      Begin
        Result := qryCadUni.FieldByName('UNI_CODUNI').AsString;
      End;
    {$ENDIF}
    Except
      On E: Exception Do
        Raise;
    End;
  Finally

  End;

end;

procedure TConfiguradorSkyMixAutomotiva.NumeroValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean; const strNomCam: String);
begin
  Error := False;

end;

end.
