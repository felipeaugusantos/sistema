{********************************************************************************}
{* Classes responsável por configurar a tela de configurações da tinta Lazzumix *}
{*****************************************************************************AC*}
unit untConfiguradorLazzumix;

interface

uses
{$IFNDEF LINUX}
  Controls,
  Dialogs,
{$ENDIF}
  untIConfiguradorTinta, untAbstractConfiguradorTinta, untIAuttinWrapper,
  SysUtils, untIDataSet, untAutcomTintaFactory, untStrUtils, untTypesSistema;

type
  TConfiguradorLazzumix = class(TAbstractConfiguradorTinta, IConfiguradorTinta)
  private
    function fConsultaProdutoEmbalagem(const strValCfg: String): String;
    function fConsultaProdutoVenda(const strValCfg: String): String;
  public
    constructor Create(const auttin: IAuttinWrapper); reintroduce;
    function ConfigurarClick(const strCodCfg: string; const strValCfg: string): string; override;
    procedure ConfigurarValidar(var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean); override;
    procedure NumeroValidar(var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean; const strNomCam: String); override;
    function DiretorioValidar(strDir: String): string; override;
    function BotaoVendaClick(const strCodCfg: string; const strValCfg: string): string; override;
    procedure BotaoVendaValidar(var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean); override;
  {$IFNDEF LINUX}
    function BotalLinhasUtilClick(const strCodCfg: string; const strValCfg: string): string; override;
  {$ENDIF}
  end;

implementation

uses
  {$IFNDEF LINUX}
  untConfiguracoesLazzumixLinhas,
  {$ENDIF}
  untLibTintaFactory;

{ TConfiguradorLazzumix }

{$IFNDEF LINUX}
function TConfiguradorLazzumix.BotalLinhasUtilClick(const strCodCfg,
  strValCfg: string): string;
var
  Frm: TfrmConfiguracoesLazzumixLinhas;
begin
  Frm := nil;
  Try
    Try
      Frm := TfrmConfiguracoesLazzumixLinhas.Create(nil);
      Frm.strConfigAtual := strValCfg;
      Frm.ShowModal;

      If Frm.ModalResult = mrOk Then
        Result := Frm.getLinhasUtilizadas;
    Except
      On E: Exception Do
      Begin
        Raise;
      End;
    End;
  Finally
    If Assigned(Frm) Then
      FreeAndNil(Frm);
  End;
end;
{$ENDIF}

function TConfiguradorLazzumix.BotaoVendaClick(const strCodCfg,
  strValCfg: string): string;
begin
  Result := fConsultaProdutoVenda(strValCfg);
end;

procedure TConfiguradorLazzumix.BotaoVendaValidar(var DisplayValue: Variant;
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

function TConfiguradorLazzumix.ConfigurarClick(const strCodCfg,
  strValCfg: string): string;
begin
  Result := fConsultaProdutoEmbalagem(strValCfg);
end;

procedure TConfiguradorLazzumix.ConfigurarValidar(var DisplayValue: Variant;
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

constructor TConfiguradorLazzumix.Create(const auttin: IAuttinWrapper);
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetIdePro, auttin);

  Configurar('USATIN', 'Utilizar essa tinta de máquina', 'S', tpSimNao, 'GERAL');
  Configurar('USAFOR', 'Utilizar Formulação', 'S', tpSimNao, 'GERAL');
  Configurar('MODVEN', 'Modo de Venda', '0', tpModoVenda,  'GERAL');
  Configurar('PROLAZ', 'Produto para venda', '', tpBotaoVenda, 'GERAL');
  Configurar('EMBLAZ', 'Preço de embalagem', '0', tpNumeroDecimal, 'PREÇO');
  Configurar('GALLAZ', 'Preço de galão', '0', tpNumeroDecimal, 'PREÇO');
  Configurar('COPLAZ', 'Preço de copo', '0', tpNumeroDecimal, 'PREÇO');
  Configurar('SPRLAZ', 'Preço de spray', '0', tpNumeroDecimal, 'PREÇO');
  Configurar('LATLAZ', 'Preço de lata', '0', tpNumeroDecimal, 'PREÇO');
  Configurar('TRACLZ', 'Trava de preço Concentrado: (1 - Venda / 2 - Custo)', '1', tpTravaPrecoCon, 'PREÇO');
  Configurar('FATCLZ', 'Fator de trava de preço Concentrado', '1,00', tpNumeroDecimal, 'PREÇO');
  Configurar('TRADLZ', 'Trava de preço Diluido: (3 - Venda / 4 - Custo)', '3', tpTravaPrecoDil, 'PREÇO');
  Configurar('FATDLZ', 'Fator de trava de preço Diluido', '1,00', tpNumeroDecimal, 'PREÇO');
  Configurar('LAZPPR', 'Path para o arquivo "Produto.txt"', '', tpDiretorio, 'PATH ARQUIVOS');
  Configurar('LAZPFO', 'Path para o arquivo "Formula.txt"', '', tpDiretorio, 'PATH ARQUIVOS');
  Configurar('LAZPBA', 'Path para o arquivo "Base.txt"', '', tpDiretorio, 'PATH ARQUIVOS');
//  Configurar('LAZ_SO', 'Sistema Operacional', 'W', tpNormal);
  Configurar('ACUABS', 'Formulação: (1 - Acumulada / 2 - Absoluta)', '2', tpAcuAbs, 'GERAL');
  Configurar('PERFRE', 'Percentual frete', '0,00', tpNumeroDecimal, 'GERAL');
  Configurar('PERIPI', 'Percentual da IPI', '0,00', tpNumeroDecimal, 'GERAL');
  Configurar('PERRET', 'Percentual retido', '0,00', tpNumeroDecimal, 'GERAL');
  Configurar('PERADC', 'Percentual adicionais', '0,00', tpNumeroDecimal, 'GERAL');
  Configurar('PERPER', 'Percentual de perda', '0,00', tpNumeroDecimal, 'GERAL');
  Configurar('MARLUC', 'Margem de lucro', '0,00', tpNumeroDecimal, 'GERAL');
  Configurar('DESOPE', 'Despesas Operacionais da Tinta (%)', '0,00', tpNumeroDecimal, 'GERAL');
  Configurar('APREVE', 'Acréscimo Adicional sobre Preço de Venda (%)', '0,00', tpNumeroDecimal, 'GERAL');
  Configurar('PRONFM', 'Próximo código novas fórmulas', '1', tpNumero_5, 'GERAL');
  Configurar('ACRMOB', 'Acréscimo de mão de obra será em:', '0', tpAcrMob, 'GERAL');

  //Txt Personalizadas
  Configurar('PERSO210', 'Path para arquivo (Perso210.TXT):', '', tpDiretorio, 'PATH ARQUIVOS');
  Configurar('PERSO211', 'Path para arquivo (Perso211.TXT):', '', tpDiretorio, 'PATH ARQUIVOS');
  Configurar('LINPER', 'Quantidade de Linhas no Arquivo (Perso211.TXT): (Padrão: 4)', '4', tpNumero, 'GERAL');

  //Litro
  Configurar('LAZIEM', 'Produto embalagem LAZZURIL (LT)', '', tpBotao, 'EMBALAGEM');
  Configurar('LAZLLA', 'Produto embalagem LAZZULAC (LT)', '', tpBotao, 'EMBALAGEM');
  Configurar('LAZLPO', 'Produto embalagem LAZZUDUR (LT)', '', tpBotao, 'EMBALAGEM');
  Configurar('LAZLTL', 'Produto embalagem LEGACY (LT)', '', tpBotao, 'EMBALAGEM');
  Configurar('LAZLPU', 'Produto embalagem P.U. (LT)', '', tpBotao, 'EMBALAGEM');
  Configurar('LAZLCR', 'Produto embalagem LAZZUCRIT (LT)', '', tpBotao, 'EMBALAGEM');
  Configurar('LAZLFL', 'Produto embalagem FLEET COLOR (LT)', '', tpBotao, 'EMBALAGEM');
  Configurar('ULTRABASELT', 'Produto embalagem ULTRABASE (LT)', '', tpBotao, 'EMBALAGEM');
  Configurar('PUMSLT', 'Produto embalagem P.U. MS (LT)', '', tpBotao, 'EMBALAGEM');
  Configurar('SHERLT', 'Produto embalagem SHERTRUCKMIX (LT)', '', tpBotao, 'EMBALAGEM');
  Configurar('LAZNLT', 'Produto embalagem PERSONALIZADA (LT)', '', tpBotao, 'EMBALAGEM');

  //Volume Litro
  Configurar('VOLIEM', 'Volume Máximo embalagem LAZZURIL (LT)     ', '0,900', tpVolumeEmb, 'VOLUME');
  Configurar('VOLLLA', 'Volume Máximo embalagem LAZZULAC (LT)     ', '0,900', tpVolumeEmb, 'VOLUME');
  Configurar('VOLLPO', 'Volume Máximo embalagem LAZZUDUR (LT)     ', '0,900', tpVolumeEmb, 'VOLUME');
  Configurar('VOLLTL', 'Volume Máximo embalagem LEGACY (LT)     ', '0,900', tpVolumeEmb, 'VOLUME');
  Configurar('VOLLPU', 'Volume Máximo embalagem P.U. (LT)         ', '0,900', tpVolumeEmb, 'VOLUME');
  Configurar('VOLLCR', 'Volume Máximo embalagem LAZZUCRIL (LT)    ', '0,900', tpVolumeEmb, 'VOLUME');
  Configurar('VOLLFL', 'Volume Máximo embalagem FLEET COLOR (LT)  ', '0,900', tpVolumeEmb, 'VOLUME');
  Configurar('VOLLUL', 'Volume Máximo embalagem ULTRABASE (LT)    ', '0,900', tpVolumeEmb, 'VOLUME');
  Configurar('VOLSLT', 'Volume Máximo embalagem P.U. MS (LT)      ', '0,900', tpVolumeEmb, 'VOLUME');
  Configurar('VOLRLT', 'Volume Máximo embalagem SHERTRUCKMIX (LT) ', '0,900', tpVolumeEmb, 'VOLUME');
  Configurar('VOLNLT', 'Volume Máximo embalagem PERSONALIZADA (LT) ', '0,900', tpVolumeEmb, 'VOLUME');

  //Galao
  Configurar('LAZIGL', 'Produto embalagem LAZZURIL (GL)', '', tpBotao, 'EMBALAGEM');
  Configurar('LAZGLA', 'Produto embalagem LAZZULAC (GL)', '', tpBotao, 'EMBALAGEM');
  Configurar('LAZGPO', 'Produto embalagem LAZZUDUR (GL)', '', tpBotao, 'EMBALAGEM');
  Configurar('LAZGLL', 'Produto embalagem LEGACY (GL)', '', tpBotao, 'EMBALAGEM');
  Configurar('LAZGPU', 'Produto embalagem P.U. (GL)', '', tpBotao, 'EMBALAGEM');
  Configurar('LAZGCR', 'Produto embalagem LAZZUCRIT (GL)', '', tpBotao, 'EMBALAGEM');
  Configurar('LAZGFL', 'Produto embalagem FLEET COLOR (GL)', '', tpBotao, 'EMBALAGEM');
  Configurar('ULTRABASEGL', 'Produto embalagem ULTRABASE (GL)', '', tpBotao, 'EMBALAGEM');
  Configurar('PUMSGL', 'Produto embalagem P.U. MS (GL)', '', tpBotao, 'EMBALAGEM');
  Configurar('SHERGL', 'Produto embalagem SHERTRUCKMIX (GL)', '', tpBotao, 'EMBALAGEM');
  Configurar('LAZNGL', 'Produto embalagem PERSONALIZADA (GL)', '', tpBotao, 'EMBALAGEM');

  //Volume Galão
  Configurar('VOLIGL',  'Volume Máximo embalagem LAZZURIL (GL)      ',  '3,600',  tpVolumeEmb,  'VOLUME');
  Configurar('VOLGLA',  'Volume Máximo embalagem LAZZULAC (GL)      ',  '3,600',  tpVolumeEmb,  'VOLUME');
  Configurar('VOLGPO',  'Volume Máximo embalagem LAZZUDUR (GL)      ',  '3,600',  tpVolumeEmb,  'VOLUME');
  Configurar('VOLGLL',  'Volume Máximo embalagem LEGACY (GL)      ',  '3,600',  tpVolumeEmb,  'VOLUME');
  Configurar('VOLGPU',  'Volume Máximo embalagem P.U (GL)           ',  '3,600',  tpVolumeEmb,  'VOLUME');
  COnfigurar('VOLGCR',  'Volume Máximo embalagem LAZZUCRIL (GL)     ',  '3,600',  tpVolumeEmb,  'VOLUME');
  Configurar('VOLGFL',  'Volume Máximo embalagem FLEET COLOR (GL)   ',  '3,600',  tpVolumeEmb,  'VOLUME');
  Configurar('VOLGUL',  'Volume Máximo embalagem ULTRABASE (GL)     ',  '3,600',  tpVolumeEmb,  'VOLUME');
  Configurar('VOLSGL',  'Volume Máximo embalagem P.U. MS (GL)       ',  '3,600',  tpVolumeEmb,  'VOLUME');
  Configurar('VOLRGL',  'Volume Máximo embalagem SHERTRUCKMIX (GL)  ',  '3,600',  tpVolumeEmb,  'VOLUME');
  Configurar('VOLNGL',  'Volume Máximo embalagem PERSONALIZADA (GL)      ',  '3,600',  tpVolumeEmb,  'VOLUME');


  //Lata
  Configurar('LAZILA', 'Produto embalagem LAZZURIL(LA)', '', tpBotao, 'EMBALAGEM');
  Configurar('LAZLAZ', 'Produto embalagem LAZZULAC(LA)', '', tpBotao, 'EMBALAGEM');
  Configurar('LAZLDU', 'Produto embalagem LAZZUDUR(LA)', '', tpBotao, 'EMBALAGEM');
  Configurar('LAZLAL', 'Produto embalagem LEGACY(LA)', '', tpBotao, 'EMBALAGEM');
  Configurar('LAZLAP', 'Produto embalagem P. U.(LA)', '', tpBotao, 'EMBALAGEM');
  Configurar('LAZLIL', 'Produto embalagem Lazzucril(LA)', '', tpBotao, 'EMBALAGEM');
  Configurar('LAZLCO', 'Produto embalagem Fleet Color(LA)', '', tpBotao, 'EMBALAGEM');
  Configurar('ULTRABASELA', 'Produto embalagem UltraBase(LA)', '', tpBotao, 'EMBALAGEM');
  Configurar('PUMSLA', 'Produto embalagem PU MS(LA)', '', tpBotao, 'EMBALAGEM');
  Configurar('SHERLA', 'Produto embalagem SHERTRUCKMIX(LA)', '', tpBotao, 'EMBALAGEM');
  Configurar('LAZNLA', 'Produto embalagem PERSONALIZADA(LA)', '', tpBotao, 'EMBALAGEM');

  //Volume Lata
  Configurar('VOLILA',  'Volume Máximo embalagem LAZZURIL (LA)      ',  '18,000', tpVolumeEmb,  'VOLUME');
  Configurar('VOLLAZ',  'Volume Máximo embalagem LAZZULAC (LA)      ',  '18,000', tpVolumeEmb,  'VOLUME');
  Configurar('VOLLDU',  'Volume Máximo embalagem LAZZUDUR (LA)      ',  '18,000', tpVolumeEmb,  'VOLUME');
  Configurar('VOLLAL',  'Volume Máximo embalagem LEGACY (LA)      ',  '18,000', tpVolumeEmb,  'VOLUME');
  Configurar('VOLLAP',  'Volume Máximo embalagem P. U. (LA)         ',  '18,000', tpVolumeEmb,  'VOLUME');
  Configurar('VOLLIL',  'Volume Máximo embalagem LAZZUCRIL (LA)     ',  '18,000', tpVolumeEmb,  'VOLUME');
  Configurar('VOLLCO',  'Volume Máximo embalagem FLEET COLOR (LA)   ',  '18,000', tpVolumeEmb,  'VOLUME');
  Configurar('VOLLAU',  'Volume Máximo embalagem ULTRABASE (LA)     ',  '18,000', tpVolumeEmb,  'VOLUME');
  Configurar('VOLSLA',  'Volume Máximo embalagem P.U. MS (LA)       ',  '18,000', tpVolumeEmb,  'VOLUME');
  Configurar('VOLRLA',  'Volume Máximo embalagem SHERTRUCKMIX (LA) ',  '18,000', tpVolumeEmb,  'VOLUME');
  Configurar('VOLNLA',  'Volume Máximo embalagem PERSONALIZADA (LA) ',  '18,000', tpVolumeEmb,  'VOLUME');

  //Outras
  Configurar('LAZCOP', 'Produto embalagem COPO', '', tpBotao, 'EMBALAGEM');
  Configurar('VOLCOP', 'Volume Máximo embalagem COPO    ',  '0,500',  tpVolumeEmb,  'VOLUME');
  Configurar('LAZSPR', 'Produto embalagem SPRAY', '', tpBotao, 'EMBALAGEM');
  Configurar('VOLSPR', 'Volume Máximo embalagem SPRAY   ',  '0,100',  tpVolumeEmb,  'VOLUME');
  Configurar('DTAATU', 'Data da Ultima Atualização', '', tpData, 'GERAL');
  Configurar('VERSAO', 'Versão da máquina', '', tpNormal, 'GERAL');
  Configurar('LINLAZ', 'Linhas para utilização (duplo clique para alterar)'  , ''    , tpBotaoLinhasUtil, 'GERAL');
end;

function TConfiguradorLazzumix.DiretorioValidar(strDir: String): string;
{$IFNDEF LINUX}
var
  odSel: TOpenDialog;
{$ENDIF}
begin
{$IFNDEF LINUX}
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
{$ENDIF}
end;

function TConfiguradorLazzumix.fConsultaProdutoEmbalagem(const strValCfg: String): String;
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
                                             'CADITE', 'untConfiguradorLazzumix', 'Consulta Item - LazZumix', qryCadIte, [], []) Then
    Begin
      Result := qryCadIte.FieldByName('ITE_CODITE').AsString;
    End;
  {$ENDIF}
  Finally
  End;
end;

function TConfiguradorLazzumix.fConsultaProdutoVenda(
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
                                             'CADITE', 'untConfiguradorLazzumix', 'Consulta Item - Lazuzmix', qryCadIte, [], []) Then
    Begin
      Result := qryCadIte.FieldByName('ITE_CODITE').AsString;
    End;
  {$ENDIF}
  Finally
  End;
end;

procedure TConfiguradorLazzumix.NumeroValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean; const strNomCam: String);
begin
  Error := False;
  If strNomCam = 'LINPER' Then
  Begin
    If Pos(DisplayValue, '3_4_') <= 0 Then
    Begin
      Error := True;
      TAutcomTintaFactory.Get.fMensagem('ATENÇÃO', 'A Configuração: Quantidade de Linhas no Arquivo (Perso211.TXT),' + #13#10 +
                                                   'Aceita somente os números: 3 ou 4', ['&Ok']);
    End;
  End;
end;

end.
