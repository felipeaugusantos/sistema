{********************************************************************************}
{* Classes responsável por configurar a tela de configurações da tinta ColorPro *}
{*****************************************************************************AC*}
unit untConfiguradorColorPro;

interface

uses
{$IFNDEF LINUX}
  Controls,
  Dialogs,
{$ENDIF}
  untIConfiguradorTinta, untAbstractConfiguradorTinta, untIAuttinWrapper,
  SysUtils, untIDataSet, untAutcomTintaFactory, untStrUtils, untTypesSistema;

type
  TConfiguradorColorPro = class(TAbstractConfiguradorTinta, IConfiguradorTinta)
  private
    function fConsultaProdutoEmbalagem(const strValCfg: String): String;
    function fConsultaProdutoVenda(const strValCfg: String): String;

    function fConsultaLinha(const strValCfg: String): String;
    function fConsultaBase(const strValCfg: String): String;

    function fTransform(strConteudo: String; intStep: Shortint; strChar: String = '_'): String;
  public
    constructor Create(const auttin: IAuttinWrapper); reintroduce;
    function ConfigurarClick(const strCodCfg: string; const strValCfg: string): string; override;
    procedure ConfigurarValidar(var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean); override;
    procedure NumeroValidar(var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean; const strNomCam: String); override;
  {$IFNDEF LINUX}
    function DiretorioValidar(strDir: String): string; override;
    function DiretorioValidarNv(strDiretorio: String; strNomCam: String): String; Override;
  {$ENDIF}
    function BotaoVendaClick(const strCodCfg: string; const strValCfg: string): string; override;
    procedure BotaoVendaValidar(var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean); override;

    function BotaoLinhaClick(const strCodCfg: string; const strValCfg: string): string; override;
    procedure BotaoLinhaValidar(var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean); override;

    function BotaoBaseClick(const strCodCfg: string; const strValCfg: string): string; override;
    procedure BotaoBaseValidar(var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean); override;

  {$IFNDEF LINUX}
    function BotalLinhasUtilClick(const strCodCfg: string; const strValCfg: string): string; override;
  {$ENDIF}
  end;

implementation

uses
{$IFNDEF LINUX}
  untConfiguracoesWandaProLinhas,
{$ENDIF}
  untLibTintaFactory;

{ TConfiguradorColorPro }

{$IFNDEF LINUX}
function TConfiguradorColorPro.BotalLinhasUtilClick(const strCodCfg,
  strValCfg: string): string;
var
  frm: TfrmConfiguracoesWandaProLinhas;
begin
  frm := nil;
  Try
    Try
      frm := TfrmConfiguracoesWandaProLinhas.Create(nil);
      frm.strConfigAtual := fTransform(strValCfg, 3);
      frm.ShowModal;
      If frm.ModalResult = mrOk Then
      Begin
        Result := frm.getLinhasUtilizadas;
      End;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(frm) then FreeAndNil(frm);
  End;
end;
{$ENDIF}

function TConfiguradorColorPro.BotaoBaseClick(const strCodCfg,
  strValCfg: string): string;
begin
  Result := fConsultaBase(strValCfg);
end;

procedure TConfiguradorColorPro.BotaoBaseValidar(var DisplayValue: Variant;
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
               '    WANPRO_CADBAS       ' +
               '  JOIN CADITE ON ITE_CODITE = BAS_CODITE '+
               ' WHERE                  ' +
               '   BAS_CODBAS = :BASE   ';
        ParamByName('BASE').AsString := DisplayValue;
        Open;

        If FieldByName('QTD').AsInteger <= 0 Then
        Begin
          TAutcomTintaFactory.Get.fMensagem('ATENÇÃO', 'Base não encontrada, favor verificar !', ['&Ok']);
          DisplayValue := '';
          Error := True;
        End;
      End;
    Except

    End;
  End;
end;

function TConfiguradorColorPro.BotaoLinhaClick(const strCodCfg,
  strValCfg: string): string;
begin
  Result := fConsultaLinha(strValCfg);
end;

procedure TConfiguradorColorPro.BotaoLinhaValidar(var DisplayValue: Variant;
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
               '    WANPRO_CADBAS       ' +
               '  JOIN CADITE ON ITE_CODITE = BAS_CODITE ' +
               ' WHERE                  ' +
               '   BAS_LINHA_ = :LINHA  ';
        ParamByName('LINHA').AsString := DisplayValue;
        Open;

        If FieldByName('QTD').AsInteger <= 0 Then
        Begin
          TAutcomTintaFactory.Get.fMensagem('ATENÇÃO', 'Linha não encontrada, favor verificar !', ['&Ok']);
          DisplayValue := '';
          Error := True;
        End;
      End;
    Except

    End;
  End;
end;

function TConfiguradorColorPro.BotaoVendaClick(const strCodCfg,
  strValCfg: string): string;
begin
  Result := fConsultaProdutoVenda(strValCfg);
end;

procedure TConfiguradorColorPro.BotaoVendaValidar(var DisplayValue: Variant;
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

function TConfiguradorColorPro.ConfigurarClick(const strCodCfg,
  strValCfg: string): string;
begin
  Result := fConsultaProdutoEmbalagem(strValCfg);
end;

procedure TConfiguradorColorPro.ConfigurarValidar(var DisplayValue: Variant;
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

constructor TConfiguradorColorPro.Create(const auttin: IAuttinWrapper);
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetIdePro, auttin);

  Configurar('USAFOR', 'Utilizar Formulação'                                                   , 'S'   , tpSimNao,          'GERAL');
  Configurar('USATIN', 'Utilizar essa tinta de máquina'                                        , 'S'   , tpSimNao,          'GERAL');
  Configurar('MODVEN', 'Modo da Venda'                                                         , '1'   ,  tpModoVenda,      'GERAL');
  Configurar('PROWAN', 'Produto de venda'                                                      , ''    , tpBotaoVenda,      'GERAL');
  Configurar('EMBWAN', 'Preço de embalagem (LT)'                                               , ''    , tpNumeroDecimal,   'PREÇO');
  Configurar('GALWAN', 'Preço de galão'                                                        , '0,00', tpNumeroDecimal,   'PREÇO');

  Configurar('WANICO', 'ITEM EMB.(COPO)'                                                       , ''    , tpBotao,           'EMBALAGEM');
  Configurar('WANISP', 'ITEM EMB.(SPRAY)'                                                      , ''    , tpBotao,           'EMBALAGEM');
  Configurar('WANISS', 'ITEM EMB.(SPRAY SINTÉTICO)'                                            , ''    , tpBotao,           'EMBALAGEM');

  Configurar('VOLICO', 'Volume Máximo EMB.(COPO)', '0,500', tpVolumeEmb, 'VOLUME'); //Volume Copo
  Configurar('VOLISP', 'Volume Máximo EMB.(SPRAY)', '0,400', tpVolumeEmb, 'VOLUME'); //Volume Spray
  Configurar('VOLISS', 'Volume Máximo EMB.(SPRAY SINTÉTICO)', '0,100', tpVolumeEmb, 'VOLUME'); //Volume SpraySint.


  Configurar('MMSILT', 'ITEM EMB. AUTOWAVE MM - SIKKENS(LT)'                                   , ''    , tpBotao,           'EMBALAGEM');
  Configurar('MMSIGL', 'ITEM EMB. AUTOWAVE MM - SIKKENS(GL)'                                   , ''    , tpBotao,           'EMBALAGEM');
  Configurar('MMSILA', 'ITEM EMB. AUTOWAVE MM - SIKKENS(LA)'                                   , ''    , tpBotao,           'EMBALAGEM');

  Configurar('VOMMLT', 'Volume Máximo EMB. AUTOWAVE - SIKKENS(LT)', '0,900',  tpVolumeEmb,  'VOLUME');
  Configurar('VOMMGL', 'Volume Máximo EMB. AUTOWAVE - SIKKENS(GL)', '3,600',  tpVolumeEmb,  'VOLUME');
  Configurar('VOMMLA', 'Volume Máximo EMB. AUTOWAVE - SIKKENS(LA)', '18,000',  tpVolumeEmb,  'VOLUME');

  Configurar('EMBMML', 'ITEM EMB. AUTOWAVE MM 2.0 - LITRO(LT)', '', tpBotao, 'EMBALAGEM');
  Configurar('EMBMMG', 'ITEM EMB. AUTOWAVE MM 2.0 - GALÃO(GL)', '', tpBotao, 'EMBALAGEM');
  Configurar('EMBMMA', 'ITEM EMB. AUTOWAVE MM 2.0 - LATA(LA)', '', tpBotao, 'EMBALAGEM');

  Configurar('VOLMML', 'Volume Máximo EMB. AUTOWAVE MM 2.0 - LITRO(LT)', '0,900', tpVolumeEmb, 'VOLUME');
  Configurar('VOLMMG', 'Volume Máximo EMB. AUTOWAVE MM 2.0 - GALÃO(GL)', '3,600', tpVolumeEmb, 'VOLUME');
  Configurar('VOLMMA', 'Volume Máximo EMB. AUTOWAVE MM 2.0 - LATA(LA)', '18,000', tpVolumeEmb, 'VOLUME');

  Configurar('BTSILT', 'ITEM EMB. AUTOCOAT BT100 - SIKKENS(LT)'                                , ''    , tpBotao,           'EMBALAGEM');
  Configurar('BTSIGL', 'ITEM EMB. AUTOCOAT BT100 - SIKKENS(GL)'                                , ''    , tpBotao,           'EMBALAGEM');
  Configurar('BTSILA', 'ITEM EMB. AUTOCOAT BT100 - SIKKENS(LA)'                                , ''    , tpBotao,           'EMBALAGEM');

  Configurar('VOBTLT', 'Volume Máximo EMB. AUTOCOAT BT100 - SIKKENS(LT)', '0,900', tpVolumeEmb, 'VOLUME');
  Configurar('VOBTGL', 'Volume Máximo EMB. AUTOCOAT BT100 - SIKKENS(GL)', '3,600', tpVolumeEmb, 'VOLUME');
  Configurar('VOBTLA', 'Volume Máximo EMB. AUTOCOAT BT100 - SIKKENS(LA)', '18,000', tpVolumeEmb, 'VOLUME');

  Configurar('PLSILT', 'ITEM EMB. AUTOBASE PLUS 100:50 - SIKKENS(LT)'                          , ''    , tpBotao,           'EMBALAGEM');
  Configurar('PLSIGL', 'ITEM EMB. AUTOBASE PLUS 100:50 - SIKKENS(GL)'                          , ''    , tpBotao,           'EMBALAGEM');
  Configurar('PLSILA', 'ITEM EMB. AUTOBASE PLUS 100:50 - SIKKENS(LA)'                          , ''    , tpBotao,           'EMBALAGEM');

  Configurar('VOPLLT', 'Volume Máximo EMB. AUTOBASE PLUS 100:50 - SIKKENS(LT)', '0,900', tpVolumeEmb, 'VOLUME');
  Configurar('VOPLGL', 'Volume Máximo EMB. AUTOBASE PLUS 100:50 - SIKKENS(GL)', '3,600', tpVolumeEmb, 'VOLUME');
  Configurar('VOPLLA', 'Volume Máximo EMB. AUTOBASE PLUS 100:50 - SIKKENS(LA)', '18,000', tpVolumeEmb, 'VOLUME');

  //emb novas

  Configurar('WAHSLT', 'ITEM EMB. WANDABASE HS(LT)',                  GetDefault('WANIEM'), tpBotao,           'EMBALAGEM');
  Configurar('WAHSGL', 'ITEM EMB. WANDABASE HS(GL)',                  GetDefault('WANIGL'), tpBotao,           'EMBALAGEM');
  Configurar('WAHSLA', 'ITEM EMB. WANDABASE HS(LA)',                  GetDefault('WANILA'), tpBotao,           'EMBALAGEM');

  Configurar('VOHSLT', 'Volume Máximo EMB. WANDABASE HS(LT)', '0,900', tpVolumeEmb, 'VOLUME');
  Configurar('VOHSGL', 'Volume Máximo EMB. WANDABASE HS(GL)', '3,600', tpVolumeEmb, 'VOLUME');
  Configurar('VOHSLA', 'Volume Máximo EMB. WANDABASE HS(LA)', '18,000', tpVolumeEmb, 'VOLUME');

  Configurar('WALALT', 'ITEM EMB. WANDALAC(LT)',                      GetDefault('WANIEM'), tpBotao,           'EMBALAGEM');
  Configurar('WALAGL', 'ITEM EMB. WANDALAC(GL)',                      GetDefault('WANIGL'), tpBotao,           'EMBALAGEM');
  Configurar('WALALA', 'ITEM EMB. WANDALAC(LA)',                      GetDefault('WANILA'), tpBotao,           'EMBALAGEM');

  Configurar('VOLALT', 'Volume Máximo EMB. WANDALAC(LT)', '0,900', tpVolumeEmb, 'VOLUME');
  Configurar('VOLAGL', 'Volume Máximo EMB. WANDALAC(GL)', '3,600', tpVolumeEmb, 'VOLUME');
  Configurar('VOLALA', 'Volume Máximo EMB. WANDALAC(LA)', '18,000', tpVolumeEmb, 'VOLUME');

  Configurar('PUHSLT', 'ITEM EMB. WANDA PU HS(LT)',                   GetDefault('WANIEM'), tpBotao,           'EMBALAGEM');
  Configurar('PUHSGL', 'ITEM EMB. WANDA PU HS(GL)',                   GetDefault('WANIGL'), tpBotao,           'EMBALAGEM');
  Configurar('PUHSLA', 'ITEM EMB. WANDA PU HS(LA)',                   GetDefault('WANILA'), tpBotao,           'EMBALAGEM');

  Configurar('VOPULT', 'Volume Máximo EMB. WANDA PU HS(LT)', '0,900', tpVolumeEmb, 'VOLUME');
  Configurar('VOPUGL', 'Volume Máximo EMB. WANDA PU HS(GL)', '3,600', tpVolumeEmb, 'VOLUME');
  Configurar('VOPULA', 'Volume Máximo EMB. WANDA PU HS(LA)', '18,000', tpVolumeEmb, 'VOLUME');

  Configurar('WCARLT', 'ITEM EMB. WANDACAR(LT)',                      GetDefault('WANIEM'), tpBotao,           'EMBALAGEM');
  Configurar('WCARGL', 'ITEM EMB. WANDACAR(GL)',                      GetDefault('WANIGL'), tpBotao,           'EMBALAGEM');
  Configurar('WCARLA', 'ITEM EMB. WANDACAR(LA)',                      GetDefault('WANILA'), tpBotao,           'EMBALAGEM');

  Configurar('VOWCLT', 'Volume Máximo EMB. WANDACAR(LT)', '0,900', tpVolumeEmb, 'VOLUME');
  Configurar('VOWCGL', 'Volume Máximo EMB. WANDACAR(GL)', '3,600', tpVolumeEmb, 'VOLUME');
  Configurar('VOWCLA', 'Volume Máximo EMB. WANDACAR(LA)', '18,000', tpVolumeEmb, 'VOLUME');

  Configurar('SISTLT', 'ITEM EMB. SINGLE STAGE CONVERTER(LT)',        GetDefault('WANIEM'), tpBotao,           'EMBALAGEM');
  Configurar('SISTGL', 'ITEM EMB. SINGLE STAGE CONVERTER(GL)',        GetDefault('WANIGL'), tpBotao,           'EMBALAGEM');
  Configurar('SISTLA', 'ITEM EMB. SINGLE STAGE CONVERTER(LA)',        GetDefault('WANILA'), tpBotao,           'EMBALAGEM');

  Configurar('VOSSLT', 'Volume Máximo EMB. SINGLE STAGE CONVERTER(LT)', '0,900', tpVolumeEmb, 'VOLUME');
  Configurar('VOSSGL', 'Volume Máximo EMB. SINGLE STAGE CONVERTER(GL)', '3,600', tpVolumeEmb, 'VOLUME');
  Configurar('VOSSLA', 'Volume Máximo EMB. SINGLE STAGE CONVERTER(LA)', '18,000', tpVolumeEmb, 'VOLUME');

  Configurar('PLBALT', 'ITEM EMB. AUTOBASE PLUS BASELINE 100:80(LT)', GetDefault('WANIEM'), tpBotao,           'EMBALAGEM');
  Configurar('PLBAGL', 'ITEM EMB. AUTOBASE PLUS BASELINE 100:80(GL)', GetDefault('WANIGL'), tpBotao,           'EMBALAGEM');
  Configurar('PLBALA', 'ITEM EMB. AUTOBASE PLUS BASELINE 100:80(LA)', GetDefault('WANILA'), tpBotao,           'EMBALAGEM');

  Configurar('VOAPLT', 'Volume Máximo EMB. AUTOBASE PLUS BASELINE 100:80(LT)', '0,900', tpVolumeEmb, 'VOLUME');
  Configurar('VOAPGL', 'Volume Máximo EMB. AUTOBASE PLUS BASELINE 100:80(GL)', '3,600', tpVolumeEmb, 'VOLUME');
  Configurar('VOAPLA', 'Volume Máximo EMB. AUTOBASE PLUS BASELINE 100:80(LA)', '18,000', tpVolumeEmb, 'VOLUME');

  Configurar('PLAULT', 'ITEM EMB. AUTOBASE PLUS 100:80(LT)',          GetDefault('WANIEM'), tpBotao,           'EMBALAGEM');
  Configurar('PLAUGL', 'ITEM EMB. AUTOBASE PLUS 100:80(GL)',          GetDefault('WANIGL'), tpBotao,           'EMBALAGEM');
  Configurar('PLAULA', 'ITEM EMB. AUTOBASE PLUS 100:80(LA)',          GetDefault('WANILA'), tpBotao,           'EMBALAGEM');

  Configurar('VOABLT', 'Volume Máximo EMB. AUTOBASE PLUS 100:80(LT)', '0,900', tpVolumeEmb, 'VOLUME');
  Configurar('VOABGL', 'Volume Máximo EMB. AUTOBASE PLUS 100:80(GL)', '3,600', tpVolumeEmb, 'VOLUME');
  Configurar('VOABLA', 'Volume Máximo EMB. AUTOBASE PLUS 100:80(LA)', '18,000', tpVolumeEmb, 'VOLUME');

  Configurar('BT11LT', 'ITEM EMB. AUTOCOAT BT110(LT)',                GetDefault('WANIEM'), tpBotao,           'EMBALAGEM');
  Configurar('BT11GL', 'ITEM EMB. AUTOCOAT BT110(GL)',                GetDefault('WANIGL'), tpBotao,           'EMBALAGEM');
  Configurar('BT11LA', 'ITEM EMB. AUTOCOAT BT110(LA)',                GetDefault('WANILA'), tpBotao,           'EMBALAGEM');

  Configurar('VO11LT', 'Volume Máximo EMB. AUTOCOAT BT110(LT)', '0,900', tpVolumeEmb, 'VOLUME');
  Configurar('VO11GL', 'Volume Máximo EMB. AUTOCOAT BT110(GL)', '3,600', tpVolumeEmb, 'VOLUME');
  Configurar('VO11LA', 'Volume Máximo EMB. AUTOCOAT BT110(LA)', '18,000', tpVolumeEmb, 'VOLUME');

  Configurar('BT12LT', 'ITEM EMB. AUTOCOAT BT120(LT)',                GetDefault('WANIEM'), tpBotao,           'EMBALAGEM');
  Configurar('BT12GL', 'ITEM EMB. AUTOCOAT BT120(GL)',                GetDefault('WANIGL'), tpBotao,           'EMBALAGEM');
  Configurar('BT12LA', 'ITEM EMB. AUTOCOAT BT120(LA)',                GetDefault('WANILA'), tpBotao,           'EMBALAGEM');

  Configurar('VO12LT', 'Volume Máximo EMB. AUTOCOAT BT120(LT)', '0,900', tpVolumeEmb, 'VOLUME');
  Configurar('VO12GL', 'Volume Máximo EMB. AUTOCOAT BT120(GL)', '3,600', tpVolumeEmb, 'VOLUME');
  Configurar('VO12LA', 'Volume Máximo EMB. AUTOCOAT BT120(LA)', '18,000', tpVolumeEmb, 'VOLUME');

  Configurar('BT13LT', 'ITEM EMB. AUTOCOAT BT130(LT)',                GetDefault('WANIEM'), tpBotao,           'EMBALAGEM');
  Configurar('BT13GL', 'ITEM EMB. AUTOCOAT BT130(GL)',                GetDefault('WANIGL'), tpBotao,           'EMBALAGEM');
  Configurar('BT13LA', 'ITEM EMB. AUTOCOAT BT130(LA)',                GetDefault('WANILA'), tpBotao,           'EMBALAGEM');

  Configurar('VO13LT', 'Volume Máximo EMB. AUTOCOAT BT130(LT)', '0,900', tpVolumeEmb, 'VOLUME');
  Configurar('VO13GL', 'Volume Máximo EMB. AUTOCOAT BT130(GL)', '3,600', tpVolumeEmb, 'VOLUME');
  Configurar('VO13LA', 'Volume Máximo EMB. AUTOCOAT BT130(LA)', '18,000', tpVolumeEmb, 'VOLUME');

  Configurar('PLBLLT', 'ITEM EMB. AUTOBASE PLUS BASELINE 100:50(LT)', GetDefault('WANIEM'), tpBotao,           'EMBALAGEM');
  Configurar('PLBLGL', 'ITEM EMB. AUTOBASE PLUS BASELINE 100:50(GL)', GetDefault('WANIGL'), tpBotao,           'EMBALAGEM');
  Configurar('PLBLLA', 'ITEM EMB. AUTOBASE PLUS BASELINE 100:50(LA)', GetDefault('WANILA'), tpBotao,           'EMBALAGEM');

  Configurar('VOBLLT', 'Volume Máximo EMB. UTOBASE PLUS BASELINE 100:50(LT)', '0,900', tpVolumeEmb, 'VOLUME');
  Configurar('VOBLGL', 'Volume Máximo EMB. UTOBASE PLUS BASELINE 100:50(GL)', '3,600', tpVolumeEmb, 'VOLUME');
  Configurar('VOBLLA', 'Volume Máximo EMB. UTOBASE PLUS BASELINE 100:50(LA)', '18,000', tpVolumeEmb, 'VOLUME');

  Configurar('PUMSLT', 'ITEM EMB. WANDA PU MS(LT)',                   GetDefault('WANIEM'), tpBotao,           'EMBALAGEM');
  Configurar('PUMSGL', 'ITEM EMB. WANDA PU MS(GL)',                   GetDefault('WANIGL'), tpBotao,           'EMBALAGEM');
  Configurar('PUMSLA', 'ITEM EMB. WANDA PU MS(LA)',                   GetDefault('WANILA'), tpBotao,           'EMBALAGEM');

  Configurar('VOMSLT', 'Volume Máximo EMB. WANDA PU MS(LT)',  '0,900', tpVolumeEmb, 'VOLUME');
  Configurar('VOMSGL', 'Volume Máximo EMB. WANDA PU MS(GL)',  '3,600', tpVolumeEmb, 'VOLUME');
  Configurar('VOMSLA', 'Volume Máximo EMB. WANDA PU MS(LA)',  '18,000', tpVolumeEmb, 'VOLUME');

  Configurar('BT90LT', 'ITEM EMB. AUTOCOAT BT90(LT)',                 GetDefault('WANIEM'), tpBotao,           'EMBALAGEM');
  Configurar('BT90GL', 'ITEM EMB. AUTOCOAT BT90(GL)',                 GetDefault('WANIGL'), tpBotao,           'EMBALAGEM');
  Configurar('BT90LA', 'ITEM EMB. AUTOCOAT BT90(LA)',                 GetDefault('WANILA'), tpBotao,           'EMBALAGEM');

  Configurar('VO90LT', 'Volume Máximo EMB. AUTOCOAT BT90(LT)', '0,900', tpVolumeEmb, 'VOLUME');
  Configurar('VO90GL', 'Volume Máximo EMB. AUTOCOAT BT90(GL)', '3,600', tpVolumeEmb, 'VOLUME');
  Configurar('VO90LA', 'Volume Máximo EMB. AUTOCOAT BT90(LA)', '18,000', tpVolumeEmb, 'VOLUME');

  Configurar('TFPULT', 'ITEM EMB. TECH FLEET PU(LT)',                 GetDefault('WANIEM'), tpBotao,           'EMBALAGEM');
  Configurar('TFPUGL', 'ITEM EMB. TECH FLEET PU(GL)',                 GetDefault('WANIGL'), tpBotao,           'EMBALAGEM');
  Configurar('TFPULA', 'ITEM EMB. TECH FLEET PU(LA)',                 GetDefault('WANILA'), tpBotao,           'EMBALAGEM');

  Configurar('VOTFLT', 'Volume Máximo EMB. TECH FLEET PU(LT)', '0,900', tpVolumeEmb, 'VOLUME');
  Configurar('VOTFGL', 'Volume Máximo EMB. TECH FLEET PU(GL)', '3,600', tpVolumeEmb, 'VOLUME');
  Configurar('VOTFLA', 'Volume Máximo EMB. TECH FLEET PU(LA)', '18,000', tpVolumeEmb, 'VOLUME');

  Configurar('TFEPLT', 'ITEM EMB. TECH FLEET EPOXY(LT)',              GetDefault('WANIEM'), tpBotao,           'EMBALAGEM');
  Configurar('TFEPGL', 'ITEM EMB. TECH FLEET EPOXY(GL)',              GetDefault('WANIGL'), tpBotao,           'EMBALAGEM');
  Configurar('TFEPLA', 'ITEM EMB. TECH FLEET EPOXY(LA)',              GetDefault('WANILA'), tpBotao,           'EMBALAGEM');

  Configurar('VOFELT', 'Volume Máximo EMB. TECH FLEET EPOXY(LT)', '0,900', tpVolumeEmb, 'VOLUME');
  Configurar('VOFEGL', 'Volume Máximo EMB. TECH FLEET EPOXY(GL)', '3,600', tpVolumeEmb, 'VOLUME');
  Configurar('VOFELA', 'Volume Máximo EMB. TECH FLEET EPOXY(LA)', '18,000', tpVolumeEmb, 'VOLUME');

  Configurar('TFSILT', 'ITEM EMB. TECH FLEET SINTETICO(LT)',          GetDefault('WANIEM'), tpBotao,           'EMBALAGEM');
  Configurar('TFSIGL', 'ITEM EMB. TECH FLEET SINTETICO(GL)',          GetDefault('WANIGL'), tpBotao,           'EMBALAGEM');
  Configurar('TFSILA', 'ITEM EMB. TECH FLEET SINTETICO(LA)',          GetDefault('WANILA'), tpBotao,           'EMBALAGEM');

  Configurar('VOFSLT', 'Volume Máximo EMB. TECH FLEET SINTETICO(LT)', '0,900', tpVolumeEmb, 'VOLUME');
  Configurar('VOFSGL', 'Volume Máximo EMB. TECH FLEET SINTETICO(GL)', '3,600', tpVolumeEmb, 'VOLUME');
  Configurar('VOFSLA', 'Volume Máximo EMB. TECH FLEET SINTETICO(LA)', '18,000', tpVolumeEmb, 'VOLUME');

  Configurar('TFLALT', 'ITEM EMB. TECH FLEET LACA(LT)',               GetDefault('WANIEM'), tpBotao,           'EMBALAGEM');
  Configurar('TFLAGL', 'ITEM EMB. TECH FLEET LACA(GL)',               GetDefault('WANIGL'), tpBotao,           'EMBALAGEM');
  Configurar('TFLALA', 'ITEM EMB. TECH FLEET LACA(LA)',               GetDefault('WANILA'), tpBotao,           'EMBALAGEM');

  Configurar('VOFLLT', 'Volume Máximo EMB. TECH FLEET LACA(LT)', '0,900', tpVolumeEmb, 'VOLUME');
  Configurar('VOFLGL', 'Volume Máximo EMB. TECH FLEET LACA(GL)', '3,600', tpVolumeEmb, 'VOLUME');
  Configurar('VOFLLA', 'Volume Máximo EMB. TECH FLEET LACA(LA)', '18,000', tpVolumeEmb, 'VOLUME');

  //emb novas

  Configurar('FVEWAN', 'Fator para geração de preço de venda'                                  , '0,00', tpNumeroDecimal,   'PREÇO');
  Configurar('TRAWAN', 'Trava p/ valor de venda concentrado WAN_CON'                           , 'VEN' , tpTravaPreco,      'PREÇO');
  Configurar('FATWAN', 'Fator p/ valor de venda concentrado WAN_CON'                           , '1,00', tpNumeroDecimal,   'PREÇO');
  Configurar('TRDWAN', 'Trava p/ valor de venda diluido WAN_DIL'                               , 'VEN' , tpTravaPreco,      'PREÇO');
  Configurar('FADWAN', 'Fator p/ valor de venda diluido WAN_DIL'                               , '1,00', tpNumeroDecimal,   'PREÇO');
  Configurar('LINWAN', 'Linhas para utilização (duplo clique para alterar)'                    , ''    , tpBotaoLinhasUtil, 'GERAL');
  Configurar('LD1WAN', 'Linha para preço diluído Wandabase HS'                                 , ''    , tpBotaoLinha,      'LINHA DILUIDO'); //Linha / Base para preço diluído Wandabase HS
  Configurar('BD1WAN', 'Base para preço diluído Wandabase HS'                                  , ''    , tpBotaoBase,       'BASE DILUIDO'); //Base
  Configurar('LD1ABS_100_50', 'Linha para preço diluído Autobase 100:50'                       , ''    , tpBotaoLinha,      'LINHA DILUIDO'); //Linha / Base para preço diluído Autobase 100:50
  Configurar('BD1ABS_100_50', 'Base para preço diluído Autobase 100:50'                        , ''    , tpBotaoBase,       'BASE DILUIDO'); //Base
  Configurar('LD1ABS_100_80', 'Linha para preço diluído Autobase 100:80'                       , ''    , tpBotaoLinha,      'LINHA DILUIDO'); //Linha / Base para preço diluído Autobase 100:80
  Configurar('BD1ABS_100_80', 'Base para preço diluído Autobase 100:80'                        , ''    , tpBotaoBase,       'BASE DILUIDO'); //Base
  Configurar('LD1PU_MS', 'Linha para preço diluído Wanda PU MS'                                , ''    , tpBotaoLinha,      'LINHA DILUIDO');
  Configurar('BD1PU_MS', 'Base para preço diluído Wanda PU MS'                                 , ''    , tpBotaoBase,       'BASE DILUIDO');
  Configurar('LD1PU_HS', 'Linha para preço diluído Wanda PU HS'                                , ''    , tpBotaoLinha,      'LINHA DILUIDO');
  Configurar('BD1PU_HS', 'Base para preço diluído Wanda PU HS'                                 , ''    , tpBotaoBase,       'BASE DILUIDO');
  Configurar('LD1BT120', 'Linha para preço diluído BT120'                                      , ''    , tpBotaoLinha,      'LINHA DILUIDO');
  Configurar('BD1BT120', 'Base para preço diluído BT120'                                       , ''    , tpBotaoBase,       'BASE DILUIDO');
  Configurar('LD1BT90', 'Linha para preço diluído BT90'                                        , ''    , tpBotaoLinha,      'LINHA DILUIDO');
  Configurar('BD1BT90', 'Base para preço diluído BT90'                                         , ''    , tpBotaoBase,       'BASE DILUIDO');
  Configurar('LD1BT80', 'Linha para preço diluído BT80'                                        , ''    , tpBotaoLinha,      'LINHA DILUIDO');
  Configurar('BD1BT80', 'Base para preço diluído BT80'                                         , ''    , tpBotaoBase,       'BASE DILUIDO');
  Configurar('LD1BT100', 'Linha para preço diluído BT100'                                      , ''    , tpBotaoLinha,      'LINHA DILUIDO');
  Configurar('BD1BT100', 'Base para preço diluído BT100'                                       , ''    , tpBotaoBase,       'BASE DILUIDO');

  Configurar('LD1ABS_BASELINE', 'Linha para preço diluído Autobase Plus Baseline 100:50'       , ''    , tpBotaoLinha,      'LINHA DILUIDO');
  Configurar('BD1ABS_BASELINE', 'Base para preço diluído Autobase Plus Baseline 100:50'        , ''    , tpBotaoBase,       'BASE DILUIDO');

  Configurar('LPAPB_10080', 'Linha para preço diluído Autobase Plus Baseline 100:80'           , ''    , tpBotaoLinha,      'LINHA DILUIDO');
  Configurar('BPAPB_10080', 'Base para preço diluído Autobase Plus Baseline 100:80'            , ''    , tpBotaoBase,       'BASE DILUIDO');

  Configurar('LD1BT362', 'Linha para preço diluído BT362'                                      , ''    , tpBotaoLinha,      'LINHA DILUIDO');
  Configurar('BD1BT362', 'Base para preço diluído BT362'                                       , ''    , tpBotaoBase,       'BASE DILUIDO');

  Configurar('PATWAN', 'Path para arquivo Txt'                                                 , ''    , tpDiretorio,       'PATH ARQUIVOS');
  Configurar('NFMPRO', 'Próximo código Nova Fórmula'                                           , '1'   , tpNumero_5,        'GERAL');
  Configurar('ACUABS', 'Valores da Formulação'                                                 , '1'   , tpAcuAbs,          'GERAL');
  Configurar('DESOPE', 'Despesas Operacionais da Tinta (%)'                                        , '0,00', tpNumeroDecimal,   'GERAL');
  Configurar('APREVE', 'Acréscimo Adicional sobre Preço de Venda (%)'                              , '0,00', tpNumeroDecimal,   'GERAL');

  Configurar('DTAATU', 'Data da Última Atualização'                                            , ''    , tpData,            'GERAL');
  Configurar('VERSAO', 'Versão da máquina'                                                     , ''    , tpNormal,          'GERAL');
  Configurar('ACRMOB', 'Acréscimo de mão de obra será em:', '0', tpAcrMob, 'GERAL');
  Configurar('USAINV', 'Utilizar rotina de importação para Novas Fórmulas:', 'N', tpSimNao, 'GERAL');
  Configurar('WCPPAT', 'Database para conexão com banco de dados de importação' , '', tpDiretorioNv, 'PATH ARQUIVOS');
  Configurar('WCPUSU', 'Usuário para conexão com banco de dados de importação'  , '',         1 , 'PATH ARQUIVOS');
  Configurar('WCPSEN', 'Senha para conexão com banco de dados de importação'    , '',         5 , 'PATH ARQUIVOS');
  Configurar('WCPSER', 'Servidor do banco de dados de importação'               , '',         1 , 'PATH ARQUIVOS');
  Configurar('WCPPOR', 'Porta de conexão com banco de dados de importação'      , '',         1 , 'PATH ARQUIVOS');
end;

{$IFNDEF LINUX}
function TConfiguradorColorPro.DiretorioValidar(strDir: String): string;
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

function TConfiguradorColorPro.DiretorioValidarNv(strDiretorio,
  strNomCam: String): String;
var
  odSel: TOpenDialog;
begin
  if FileExists(strDiretorio) then
    Result := strDiretorio
  Else
    Result := 'C:\';

  Try
    odSel := TOpenDialog.Create(Nil);

    odSel.DefaultExt := '.fdb*';
    odSel.FileName   := '*.fdb*';
    odSel.Title      := 'Selecione um Arquivo fdb';
    odSel.InitialDir := Result;
    If odSel.Execute then
      Result := odSel.FileName;
  Finally
    FreeAndNil(odSel);
  End;
end;

{$ENDIF}

function TConfiguradorColorPro.fConsultaBase(const strValCfg: String): String;
var
  strSQL: String;
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
    strSQL := strSQL + '   BAS_CODBAS, ';  pAddNomeColuna('Base');
    strSQL := strSQL + '   BAS_DESBAS, ';  pAddNomeColuna('Descrição');
    strSQL := strSQL + '   BAS_LINHA_, ';  pAddNomeColuna('Linha');
    strSQL := strSQL + '   WANPRO_CADBAS.AUTOINCREM  ';
    strSQL := strSQL + ' FROM WANPRO_CADBAS ';
    strSQL := strSQL + ' JOIN CADITE ON ITE_CODITE = BAS_CODITE ';

  {$IFNDEF LINUX}
    If TAutcomTintaFactory.Get.pConsultaComp([strSQL], arrTitCol, ['BAS_LINHA_','BAS_CODBAS'], 'AUTOINCREM',
                                             'WANPRO_CADBAS', 'untConfiguradorColorPro', 'Consulta Bases - Color Pro', qryCadIte, [], []) Then
    Begin
      Result := qryCadIte.FieldByName('BAS_CODBAS').AsString;
    End;
  {$ENDIF}

  Finally
  End;
end;

function TConfiguradorColorPro.fConsultaLinha(const strValCfg: String): String;
var
  strSQL: String;
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
    strSQL := strSQL + '   BAS_CODBAS, ';  pAddNomeColuna('Código');
    strSQL := strSQL + '   BAS_DESBAS, ';  pAddNomeColuna('Descrição');
    strSQL := strSQL + '   BAS_LINHA_, ';  pAddNomeColuna('Linha');
    strSQL := strSQL + '   WANPRO_CADBAS.AUTOINCREM  ';
    strSQL := strSQL + ' FROM WANPRO_CADBAS ';
    strSQL := strSQL + ' JOIN CADITE ON ITE_CODITE = BAS_CODITE ';

  {$IFNDEF LINUX}
    If TAutcomTintaFactory.Get.pConsultaComp([strSQL], arrTitCol, ['BAS_LINHA_','BAS_CODBAS'], 'AUTOINCREM',
                                             'WANPRO_CADBAS', 'untConfiguradorColorPro', 'Consulta Bases - Color Pro', qryCadIte, [], []) Then
    Begin
      Result := qryCadIte.FieldByName('BAS_LINHA_').AsString;
    End;
  {$ENDIF}

  Finally
  End;
end;

function TConfiguradorColorPro.fConsultaProdutoEmbalagem(const strValCfg: String): String;
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
                                             'CADITE', 'untConfiguradorColorPro', 'Consulta Item - ColorPro', qryCadIte, [], []) Then
    Begin
      Result := qryCadIte.FieldByName('ITE_CODITE').AsString;
    End;
  {$ENDIF}

  Finally
  End;
end;

function TConfiguradorColorPro.fConsultaProdutoVenda(
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
                                             'CADITE', 'untConfiguradorColorPro', 'Consulta Item - ColorPro', qryCadIte, [], []) Then
    Begin
      Result := qryCadIte.FieldByName('ITE_CODITE').AsString;
    End;
  {$ENDIF}

  Finally
  End;
end;

function TConfiguradorColorPro.fTransform(strConteudo: String;
  intStep: Shortint; strChar: String): String;
  Var
    strAux       : String;
    intPosicao   : Integer;
begin
  strAux := '';

  intPosicao := 1;
  While intPosicao < Length(strConteudo) Do
  Begin
    strAux := strAux + Copy(strConteudo, intPosicao, intStep) + strChar;
    Inc(intPosicao, intStep);
  End;

  Result := strAux;
end;

procedure TConfiguradorColorPro.NumeroValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean; const strNomCam: String);
begin
  Error := False;
  If strNomCam = 'DECFOR' Then
  Begin
    If Pos(DisplayValue, '1_2_3_') <= 0 Then
    Begin
      Error := True;
      TAutcomTintaFactory.Get.fMensagem('ATENÇÃO', 'A Configuração: Quantidade de casas decimais que serão' + #13#10 +
                                                   'exibidas nas quantidades da formulação,' + #13#10 +
                                                   'aceita somente os números: 1, 2 ou 3', ['&Ok']);
    End;
  End;
end;

end.
