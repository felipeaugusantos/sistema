{********************************************************************************}
{* Classes responsável por configurar a tela de configurações da tinta Ppg *}
{*****************************************************************************AC*}
unit untConfiguradorPpg;

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
  TConfiguradorPpg = class(TAbstractConfiguradorTinta, IConfiguradorTinta)
  private
    function fConsultaProdutoEmbalagem(const strValCfg: String): String;
    function fConsultaProdutoVenda(const strValCfg: String): String;
    function fRetornoEmbalagensNovas : String;
  public
    constructor Create(const auttin: IAuttinWrapper); reintroduce;
  {$IFNDEF LINUX}
    function ConfigurarClick(const strCodCfg: string; const strValCfg: string): string; override;
  {$ENDIF}
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
  untCadEmbTintaPpg,
{$ENDIF}
  untLibTintaFactory, System.Variants;

{ TConfiguradorPpg }

function TConfiguradorPpg.BotaoVendaClick(const strCodCfg,
  strValCfg: string): string;
begin
  Result := fConsultaProdutoVenda(strValCfg);
end;

procedure TConfiguradorPpg.BotaoVendaValidar(var DisplayValue: Variant;
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

{$IFNDEF LINUX}
function TConfiguradorPpg.ConfigurarClick(const strCodCfg,strValCfg: string): string;
  Var strEmbalagem : String;
      strLinha     : String;
begin
  If Pos(strCodCfg,fRetornoEmbalagensNovas) > 0 Then
  Begin
    Result := '';
    frmCadEmbTintaPpg := nil;
    Application.CreateForm(TfrmCadEmbTintaPpg, frmCadEmbTintaPpg);

    pGetInfConfEmb(strCodCfg, strEmbalagem,strLinha);

    frmCadEmbTintaPpg.pSetaParametros(strCodCfg, strEmbalagem, strLinha );
    frmCadEmbTintaPpg.ShowModal;

    Result := fRetornarEmbalagemPrincipal(strCodCfg);
  End
  else
    Result := fConsultaProdutoEmbalagem(strValCfg);
end;
{$ENDIF}

procedure TConfiguradorPpg.ConfigurarValidar(var DisplayValue: Variant;
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

constructor TConfiguradorPpg.Create(const auttin: IAuttinWrapper);
begin

  inherited Create(TLibTintaFactory.GetLibTinta.GetIdePro, auttin);

  Configurar('USAFOR', 'Utilizar Formulação',                   'S'  , tpSimNao,    'GERAL');
  Configurar('USATIN', 'Utilizar essa tinta de máquina',        'S'  , tpSimNao,    'GERAL');
  Configurar('MODVEN', 'Modo de Venda',                         '0'  , tpModoVenda, 'GERAL');
  Configurar('NOVFOR', 'Utilizar nova formulação', 'N'  , tpSimNao,    'GERAL');

  Configurar('DESOPE', 'Despesas Operacionais da Tinta (%)',           '0,00', tpNumeroDecimal, 'GERAL');
  Configurar('APREVE', 'Acréscimo Adicional sobre Preço de Venda (%)', '0,00', tpNumeroDecimal, 'GERAL');

  Configurar('ACUABS', 'Valores da Formulação: (1 - Acumulada / 2 - Absoluta)', '2', tpAcuAbs, 'GERAL');

  Configurar('DTAATU', 'Data da Última Atualização'      , '' , tpData,    'GERAL');
  Configurar('VERSAO', 'Versão da máquina'               , '' , tpNormal,  'GERAL');

  Configurar('PROPPG', 'Produto para venda',                ''   , tpBotaoVenda,    'GERAL');
  Configurar('TRAPPG', 'Trava para valor de venda PPG_PRE', 'VEN', tpTravaPreco,    'GERAL');
  Configurar('FATPPG', 'Fator',                             '1'  , tpNumeroDecimal, 'GERAL');
  Configurar('PROCOD', 'Próximo código novas fórmulas',     '1'  , tpNumero_5,      'GERAL');

  Configurar('EMBPPG', 'Preço de embalagem', '0,00',  tpNumeroDecimal, 'GERAL');
  Configurar('GALPPG', 'Preço de galão',     '0,00',  tpNumeroDecimal, 'GERAL');
  Configurar('ACRMOB', 'Acréscimo de mão de obra será em:', '0', tpAcrMob, 'GERAL');
  Configurar('DECNFM', 'Quantidade de casas decimais que serão exibidas nas quantidades da nova fórmula (1, 2 ou 3)', '2', tpNumero, 'GERAL');


  Configurar('PATPPG', 'Path para arquivos (*.txt)', '', tpDiretorio, 'PATH ARQUIVOS');

  Configurar('PPGGDU', 'Embalagem Galão Dulon',     '' , tpBotao, 'EMBALAGEM');
  Configurar('PPGGDF', 'Embalagem Galão Delfleet',  '' , tpBotao, 'EMBALAGEM');
  Configurar('PPGGDT', 'Embalagem Galão Deltron',   '' , tpBotao, 'EMBALAGEM');
  Configurar('PPGGOM', 'Embalagem Galão Omni',      '' , tpBotao, 'EMBALAGEM');

  Configurar('VOLGDU', 'Volume Galão Dulon', '3,600', tpVolumeEmb, 'VOLUME');
  Configurar('VOLGDF', 'Volume Galão Delfleet', '3,600', tpVolumeEmb, 'VOLUME');
  Configurar('VOLGDT', 'Volume Galão Deltron', '3,600', tpVolumeEmb, 'VOLUME');
  Configurar('VOLGOM', 'Volume Galão Omni', '3,600', tpVolumeEmb, 'VOLUME');

  Configurar('PPGLDU', 'Embalagem Litro Dulon',     '' , tpBotao, 'EMBALAGEM');
  Configurar('PPGLDF', 'Embalagem Litro Delfleet',  '' , tpBotao, 'EMBALAGEM');
  Configurar('PPGLDT', 'Embalagem Litro Deltron',   '' , tpBotao, 'EMBALAGEM');
  Configurar('PPGLOM', 'Embalagem Litro Omni',      '' , tpBotao, 'EMBALAGEM');

  Configurar('VOLLDU', 'Volume Litro Dulon', '1,000', tpVolumeEmb, 'VOLUME');
  Configurar('VOLLDF', 'Volume Litro Delfleet', '1,000', tpVolumeEmb, 'VOLUME');
  Configurar('VOLLDT', 'Volume Litro Deltron', '1,000', tpVolumeEmb, 'VOLUME');
  Configurar('VOLLOM', 'Volume Litro Omni', '1,000', tpVolumeEmb, 'VOLUME');

  Configurar('PPGLADU', 'Embalagem Balde Dulon',    '' , tpBotao, 'EMBALAGEM');
  Configurar('PPGLADF', 'Embalagem Balde Delfleet', '' , tpBotao, 'EMBALAGEM');
  Configurar('PPGLADT', 'Embalagem Balde Deltron',  '' , tpBotao, 'EMBALAGEM');
  Configurar('PPGLAOM', 'Embalagem Balde Omni',     '' , tpBotao, 'EMBALAGEM');

  Configurar('VOLADU', 'Volume Balde Dulon', '18,000', tpVolumeEmb, 'VOLUME');
  Configurar('VOLADF', 'Volume Balde Delfleet', '18,000', tpVolumeEmb, 'VOLUME');
  Configurar('VOLADT', 'Volume Balde Deltron', '18,000', tpVolumeEmb, 'VOLUME');
  Configurar('VOLAOM', 'Volume Balde Omni', '18,000', tpVolumeEmb, 'VOLUME');

  Configurar('PPGTDU', 'Embalagem Tambor Dulon',    '' , tpBotao, 'EMBALAGEM');
  Configurar('PPGTDF', 'Embalagem Tambor Delfleet', '' , tpBotao, 'EMBALAGEM');
  Configurar('PPGTDT', 'Embalagem Tambor Deltron',  '' , tpBotao, 'EMBALAGEM');
  Configurar('PPGTOM', 'Embalagem Tambor Omni',     '' , tpBotao, 'EMBALAGEM');

  Configurar('VOLTDU', 'Volume Tambor Dulon', '200,000', tpVolumeEmb, 'VOLUME');
  Configurar('VOLTDF', 'Volume Tambor Delfleet', '200,000', tpVolumeEmb, 'VOLUME');
  Configurar('VOLTDT', 'Volume Tambor Deltron', '200,000', tpVolumeEmb, 'VOLUME');
  Configurar('VOLTOM', 'Volume Tambor Omni', '200,000', tpVolumeEmb, 'VOLUME');

  Configurar('PPGLEN', 'Embalagem Litro Envirobase HP',      '' , tpBotao, 'EMBALAGEM');
  Configurar('VOLLEN', 'Volume Litro Envirobase HP', '1,000', tpVolumeEmb, 'VOLUME');
  Configurar('PPGGEN', 'Embalagem Galão Envirobase HP',      '' , tpBotao, 'EMBALAGEM');
  Configurar('VOLGEN', 'Volume Galão Envirobase HP', '3,600', tpVolumeEmb, 'VOLUME');
  Configurar('PPGBEN', 'Embalagem Balde Envirobase HP',      '' , tpBotao, 'EMBALAGEM');
  Configurar('VOLBEN', 'Volume Balde Envirobase HP', '18,000', tpVolumeEmb, 'VOLUME');
  Configurar('PPGTEN', 'Embalagem Tambor Envirobase HP',      '' , tpBotao, 'EMBALAGEM');
  Configurar('VOLTEN', 'Volume Tambor Envirobase HP', '200,000', tpVolumeEmb, 'VOLUME');
  Configurar('PSPRAY', 'Spray'       , '' , tpBotao, 'EMBALAGEM');
  Configurar('VOLSPR', 'Volume Máximo Spray', '0,450', tpVolumeEmb, 'VOLUME');

  If (TAutcomTintaFactory.Get().fGetConfTinta('PPG').fGet('NOVFOR') = 'S') Then
  Begin
    // EMBALAGENS -  PPG
    Configurar('PPGPMLDU', 'Litro - Dulon',         '' , tpBotao, 'EMBALAGEM PM(PPG)');
    Configurar('PPGPMLDF', 'Litro - Delfleet',      '' , tpBotao, 'EMBALAGEM PM(PPG)');
    Configurar('PPGPMLDT', 'Litro - Deltron(LA)',   '' , tpBotao, 'EMBALAGEM PM(PPG)');
    Configurar('PPGPMLEB', 'Litro - Envirobase HP', '' , tpBotao, 'EMBALAGEM PM(PPG)');

    Configurar('VOLPMLDU', 'Volume Litro - Dulon', '1,000', tpVolumeEmb, 'VOLUME PM(PPG)');
    Configurar('VOLPMLDF', 'Volume Litro - Delfleet', '1,000', tpVolumeEmb, 'VOLUME PM(PPG)');
    Configurar('VOLPMLDT', 'Volume Litro - Deltron(LA)', '1,000', tpVolumeEmb, 'VOLUME PM(PPG)');
    Configurar('VOLPMLEB', 'Volume Litro - Envirobase HP', '1,000', tpVolumeEmb, 'VOLUME PM(PPG)');

    Configurar('PPGPMGDU', 'Galão - Dulon',         '' , tpBotao, 'EMBALAGEM PM(PPG)');
    Configurar('PPGPMGDF', 'Galão - Delfleet',      '' , tpBotao, 'EMBALAGEM PM(PPG)');
    Configurar('PPGPMGDT', 'Galão - Deltron(LA)',   '' , tpBotao, 'EMBALAGEM PM(PPG)');
    Configurar('PPGPMGEB', 'Galão - Envirobase HP', '' , tpBotao, 'EMBALAGEM PM(PPG)');

    Configurar('VOLPMGDU', 'Volume Galão - Dulon', '3,600', tpVolumeEmb, 'VOLUME PM(PPG)');
    Configurar('VOLPMGDF', 'Volume Galão - Delfleet', '3,600', tpVolumeEmb, 'VOLUME PM(PPG)');
    Configurar('VOLPMGDT', 'Volume Galão - Deltron(LA)', '3,600', tpVolumeEmb, 'VOLUME PM(PPG)');
    Configurar('VOLPMGEB', 'Volume Galão - Envirobase HP', '3,600', tpVolumeEmb, 'VOLUME PM(PPG)');

    Configurar('PPGPMLADU', 'Balde - Dulon',         '' , tpBotao, 'EMBALAGEM PM(PPG)');
    Configurar('PPGPMLADF', 'Balde - Delfleet',      '' , tpBotao, 'EMBALAGEM PM(PPG)');
    Configurar('PPGPMLADT', 'Balde - Deltron(LA)',   '' , tpBotao, 'EMBALAGEM PM(PPG)');
    Configurar('PPGPMLAEB', 'Balde - Envirobase HP', '' , tpBotao, 'EMBALAGEM PM(PPG)');

    Configurar('VOLPMADU', 'Volume Balde - Dulon', '18,000', tpVolumeEmb, 'VOLUME PM(PPG)');
    Configurar('VOLPMADF', 'Volume Balde - Delfleet', '18,000', tpVolumeEmb, 'VOLUME PM(PPG)');
    Configurar('VOLPMADT', 'Volume Balde - Deltron(LA)', '18,000', tpVolumeEmb, 'VOLUME PM(PPG)');
    Configurar('VOLPMAEB', 'Volume Balde - Envirobase HP', '18,000', tpVolumeEmb, 'VOLUME PM(PPG)');

    Configurar('PPGPMTDU', 'Tambor - Dulon',         '' , tpBotao, 'EMBALAGEM PM(PPG)');
    Configurar('PPGPMTDF', 'Tambor - Delfleet',      '' , tpBotao, 'EMBALAGEM PM(PPG)');
    Configurar('PPGPMTDT', 'Tambor - Deltron(LA)',   '' , tpBotao, 'EMBALAGEM PM(PPG)');
    Configurar('PPGPMTEB', 'Tambor - Envirobase HP', '' , tpBotao, 'EMBALAGEM PM(PPG)');

    Configurar('VOLPMTDU', 'Volume Tambor - Dulon', '200,000', tpVolumeEmb, 'VOLUME PM(PPG)');
    Configurar('VOLPMTDF', 'Volume Tambor - Delfleet', '200,000', tpVolumeEmb, 'VOLUME PM(PPG)');
    Configurar('VOLPMTDT', 'Volume Tambor - Deltron(LA)', '200,000', tpVolumeEmb, 'VOLUME PM(PPG)');
    Configurar('VOLPMTEB', 'Volume Tambor - Envirobase HP', '200,000', tpVolumeEmb, 'VOLUME PM(PPG)');

    Configurar('PPGCOP', 'Copo',                     '' , tpBotao, 'EMBALAGEM PM(PPG)');

    Configurar('VOLCOP', 'Volume Copo', '0,500', tpVolumeEmb, 'VOLUME PM(PPG)');

    // EMBALAGENS -  NEXA
    Configurar('PPGPML2K', 'Litro - 2K',           '' , tpBotao, 'EMBALAGEM PM(NEXA)');
    Configurar('PPGPMLAC', 'Litro - ACS(LA)',      '' , tpBotao, 'EMBALAGEM PM(NEXA)');
    Configurar('PPGPMLIN', 'Litro - Industran',    '' , tpBotao, 'EMBALAGEM PM(NEXA)');
    Configurar('PPGPMLSG', 'Litro - Spectral Grey','' , tpBotao, 'EMBALAGEM PM(NEXA)');
    Configurar('PPGPMLZY', 'Litro - Zynamix',      '' , tpBotao, 'EMBALAGEM PM(NEXA)');

    Configurar('VOLPML2K', 'Volume Litro - 2K', '1,000', tpVolumeEmb, 'VOLUME PM(NEXA)');
    Configurar('VOLPMLAC', 'Volume Litro - ACS(LA)', '1,000', tpVolumeEmb, 'VOLUME PM(NEXA)');
    Configurar('VOLPMLIN', 'Volume Litro - Industran', '1,000', tpVolumeEmb, 'VOLUME PM(NEXA)');
    Configurar('VOLPMLSG', 'Volume Litro - Spectral Grey', '1,000', tpVolumeEmb, 'VOLUME PM(NEXA)');
    Configurar('VOLPMLZY', 'Volume Litro - Zynamix' , '1,000', tpVolumeEmb, 'VOLUME PM(NEXA)');

    Configurar('PPGPMG2K', 'Galão - 2K',           '' , tpBotao, 'EMBALAGEM PM(NEXA)');
    Configurar('PPGPMGAC', 'Galão - ACS(LA)',      '' , tpBotao, 'EMBALAGEM PM(NEXA)');
    Configurar('PPGPMGIN', 'Galão - Industran',    '' , tpBotao, 'EMBALAGEM PM(NEXA)');
    Configurar('PPGPMGSG', 'Galão - Spectral Grey','' , tpBotao, 'EMBALAGEM PM(NEXA)');
    Configurar('PPGPMGZY', 'Galão - Zynamix',      '' , tpBotao, 'EMBALAGEM PM(NEXA)');

    Configurar('VOLPMG2K', 'Volume Galão - 2K', '3,600', tpVolumeEmb, 'VOLUME PM(NEXA)');
    Configurar('VOLPMGAC', 'Volume Galão - ACS(LA)', '3,600', tpVolumeEmb, 'VOLUME PM(NEXA)');
    Configurar('VOLPMGIN', 'Volume Galão - Industran', '3,600', tpVolumeEmb, 'VOLUME PM(NEXA)');
    Configurar('VOLPMGSG', 'Volume Galão - Spectral Grey', '3,6000', tpVolumeEmb, 'VOLUME PM(NEXA)');
    Configurar('VOLPMGZY', 'Volume Galão - Zynamix', '3,600', tpVolumeEmb, 'VOLUME PM(NEXA)');

    Configurar('PPGPMLA2K', 'Balde - 2K',           '' , tpBotao, 'EMBALAGEM PM(NEXA)');
    Configurar('PPGPMLAAC', 'Balde - ACS(LA)',      '' , tpBotao, 'EMBALAGEM PM(NEXA)');
    Configurar('PPGPMLAIN', 'Balde - Industran',    '' , tpBotao, 'EMBALAGEM PM(NEXA)');
    Configurar('PPGPMLASG', 'Balde - Spectral Grey','' , tpBotao, 'EMBALAGEM PM(NEXA)');
    Configurar('PPGPMLAZY', 'Balde - Zynamix',      '' , tpBotao, 'EMBALAGEM PM(NEXA)');

    Configurar('VOLPMA2K', 'Volume Balde - 2K', '18,000', tpVolumeEmb, 'VOLUME PM(NEXA)');
    Configurar('VOLPMAAC', 'Volume Balde - ACS(LA)', '18,000', tpVolumeEmb, 'VOLUME PM(NEXA)');
    Configurar('VOLPMAIN', 'Volume Balde - Industran', '18,000', tpVolumeEmb, 'VOLUME PM(NEXA)');
    Configurar('VOLPMASG', 'Volume Balde - Spectral Grey', '18,000', tpVolumeEmb, 'VOLUME PM(NEXA)');
    Configurar('VOLPMAZY', 'Volume Balde - Zynamix', '18,000', tpVolumeEmb, 'VOLUME PM(NEXA)');

    Configurar('PPGPMLA2K', 'Tambor - 2K',           '' , tpBotao, 'EMBALAGEM PM(NEXA)');
    Configurar('PPGPMLAAC', 'Tambor - ACS(LA)',      '' , tpBotao, 'EMBALAGEM PM(NEXA)');
    Configurar('PPGPMLAIN', 'Tambor - Industran',    '' , tpBotao, 'EMBALAGEM PM(NEXA)');
    Configurar('PPGPMLASG', 'Tambor - Spectral Grey','' , tpBotao, 'EMBALAGEM PM(NEXA)');
    Configurar('PPGPMLAZY', 'Tambor - Zynamix',      '' , tpBotao, 'EMBALAGEM PM(NEXA)');

    Configurar('VOLPMT2K', 'Volume Tambor - 2K', '200,000', tpVolumeEmb, 'VOLUME PM(NEXA)');
    Configurar('VOLPMTAC', 'Volume Tambor - ACS(LA)', '200,000', tpVolumeEmb, 'VOLUME PM(NEXA)');
    Configurar('VOLPMTIN', 'Volume Tambor - Industran', '200,000', tpVolumeEmb, 'VOLUME PM(NEXA)');
    Configurar('VOLPMTSG', 'Volume Tambor - Spectral Grey', '200,000', tpVolumeEmb, 'VOLUME PM(NEXA)');
    Configurar('VOLPMTZY', 'Volume Tambor - Zynamix', '200,000', tpVolumeEmb, 'VOLUME PM(NEXA)');
  End;
end;

{$IFNDEF LINUX}
function TConfiguradorPpg.DiretorioValidar(strDir: String): string;
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

function TConfiguradorPpg.fConsultaProdutoEmbalagem(const strValCfg: String): String;
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
                                             'CADITE', 'untConfiguradorPpg', 'Consulta Item - Ppg', qryCadIte, [], []) Then
    Begin
      Result := qryCadIte.FieldByName('ITE_CODITE').AsString;
    End;
  {$ENDIF}

  Finally
  End;
end;

function TConfiguradorPpg.fConsultaProdutoVenda(
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
                                             'CADITE', 'untConfiguradorPpg', 'Consulta Item - Ppg', qryCadIte, [], []) Then
    Begin
      Result := qryCadIte.FieldByName('ITE_CODITE').AsString;
    End;
  {$ENDIF}

  Finally
  End;
end;

function TConfiguradorPpg.fRetornarEmbalagemPrincipal(strCodCfg: String): String;
Var
  qryAux: IDataSet;
begin
  qryAux := TAutcomTintaFactory.Get.fGetDataSet;
  qryAux.SQL := 'SELECT CFG_CODITE '+
                '  FROM CFGEMB '+
                ' WHERE CFG_CODEMP = :CODEMP '+
                '   AND CFG_CODCFG = :CODCFG '+
                '   AND CFG_IDEPRO = "PPG" '+
                '   AND CFG_PRINCI = "S" ';
  qryAux.ParamByName('CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryAux.ParamByName('CODCFG').AsString := strCodCfg;
  qryAux.Open;

  Result := qryAux.FieldByName('CFG_CODITE').AsString;

end;

function TConfiguradorPpg.fRetornoEmbalagensNovas: String;
begin
  Result := 'PPGPMLDU_PPGPMLDF_PPGPMLDT_PPGPMLEB_PPGPMGDU_PPGPMGDF_PPGPMGDT_PPGPMGEB_PPGPMLADU_PPGPMLADF_'+
            'PPGPMLADT_PPGPMLAEB_PPGPMTDU_PPGPMTDF_PPGPMTDT_PPGPMTEB_PPGCOP_PPGPML2K_PPGPMLAC_PPGPMLIN_'+
            'PPGPMLSG_PPGPMLZY_PPGPMG2K_PPGPMGAC_PPGPMGIN_PPGPMGSG_PPGPMGZY_PPGPMLA2K_PPGPMLAAC_PPGPMLAIN_'+
            'PPGPMLASG_PPGPMLAZY_PPGPMT2K_PPGPMTAC_PPGPMTIN_PPGPMTSG_PPGPMTZY_';
end;

procedure TConfiguradorPpg.NumeroValidar(var DisplayValue: Variant;
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

procedure TConfiguradorPpg.pGetInfConfEmb(strCodCfg: String; var strEmbalagem, strLinha: String);
Var
  qryAux  : IDataSet;
  strDesc : String;
begin
  qryAux := TAutcomTintaFactory.Get.fGetDataSet;
  qryAux.SQL := ' SELECT CFG_DESCRI '+
                '  FROM CFGTIN '+
                ' WHERE CFG_IDEPRO = "PPG" '+
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
