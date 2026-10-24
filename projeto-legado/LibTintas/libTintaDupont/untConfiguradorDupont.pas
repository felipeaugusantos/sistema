{********************************************************************************}
{* Classes responsável por configurar a tela de configurações da tinta Dupont   *}
{*****************************************************************************AC*}
unit untConfiguradorDupont;

interface

uses
{$IFNDEF LINUX}
  Controls,
  Dialogs,
{$ENDIF}
  untIConfiguradorTinta, untAbstractConfiguradorTinta, untIAuttinWrapper, Classes,
  SysUtils, untIDataSet, untAutcomTintaFactory, untStrUtils, untTypesSistema;

type
  TConfiguradorDupont = class(TAbstractConfiguradorTinta, IConfiguradorTinta)
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
  end;

implementation

uses
  untLibTintaFactory;

{ TConfiguradorDupont }

function TConfiguradorDupont.BotaoVendaClick(const strCodCfg,
  strValCfg: string): string;
begin
  Result := fConsultaProdutoVenda(strValCfg);
end;

procedure TConfiguradorDupont.BotaoVendaValidar(var DisplayValue: Variant;
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

function TConfiguradorDupont.ConfigurarClick(const strCodCfg,
  strValCfg: string): string;
begin
  Result := fConsultaProdutoEmbalagem(strValCfg);
end;

procedure TConfiguradorDupont.ConfigurarValidar(var DisplayValue: Variant;
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

constructor TConfiguradorDupont.Create(const auttin: IAuttinWrapper);
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetIdePro, auttin);

  Configurar('USATIN', 'Utilizar essa tinta de máquina', 'S', tpSimNao, 'GERAL');
  Configurar('USAFOR', 'Utilizar Formulação', 'S', tpSimNao, 'GERAL');
  Configurar('MODVEN', 'Modo de Venda', '0', tpModoVenda, 'GERAL');

  Configurar('EMB1_4', 'Preço embalagem litro', '0,00', tpNumeroDecimal, 'PREÇO');
  Configurar('EMBGAL', 'Preço embalagem galão', '0,00', tpNumeroDecimal, 'PREÇO');


  Configurar('TRADUP', 'Trava de preço', 'VEN', tpTravaPreco, 'PREÇO');
  Configurar('FATDUP', 'Fator da trava de preço', '1,00', tpNumeroDecimal, 'PREÇO');
  Configurar('FATCUS', 'Fator da trava de preço de custo', '1,00', tpNumeroDecimal, 'PREÇO');
  Configurar('PATDUP', 'Path para a geração dos arquivos', '', tpDiretorio, 'PATH ARQUIVOS');
  Configurar('NFMDUP', 'Próximo código da novas fórmulas', '1', tpNumero_5, 'GERAL');
  Configurar('ACUABS', 'Valores da Formulação: (1 - Acumulada / 2 - Absoluta)', '1', tpAcuAbs, 'GERAL');

  Configurar('VERSAO', 'Versão da máquina', '', 1, 'GERAL');

  Configurar('DTAATU', 'Data da Ultima Atualização', '', tpData, 'GERAL');
  Configurar('DESOPE', 'Despesas Operacionais da Tinta (%)', '0,00', tpNumeroDecimal, 'GERAL');
  Configurar('APREVE', 'Acréscimo Adicional sobre Preço de Venda (%)', '0,00', tpNumeroDecimal, 'GERAL');
  Configurar('DECFOR', 'Quantidade de casas decimais que serão exibidas nas quantidades da formulação (1, 2 ou 3)', '1', tpNumero, 'GERAL');
  Configurar('ACRMOB', 'Acréscimo de mão de obra será em:', '0', tpAcrMob, 'GERAL');

  Configurar('ITE1_4', 'Produto embalagem Duxone Litro', '', tpBotao, 'EMBALAGEM');
  Configurar('ITEGAL', 'Produto embalagem Duxone galão', '', tpBotao, 'EMBALAGEM');
  Configurar('ITELAT', 'Produto embalagem Duxone lata',  '', tpBotao, 'EMBALAGEM');

  //Volume Duxone
  Configurar('VOL1_4',  'Volume Máximo embalagem Duxone litro', '0,900',  tpVolumeEmb,  'VOLUME');
  Configurar('VOLGAL',  'Volume Máximo embalagem Duxone galão', '3,600',  tpVolumeEmb,  'VOLUME');
  Configurar('VOLLAT',  'Volume Máximo embalagem Duxone lata' , '18,000', tpVolumeEmb,  'VOLUME');

  Configurar('NASOLT', 'Produto embalagem Nason litro',  '', tpBotao, 'EMBALAGEM');
  Configurar('NASOGL', 'Produto embalagem Nason galão',  '', tpBotao, 'EMBALAGEM');
  Configurar('NASOLA', 'Produto embalagem Nason lata',   '', tpBotao, 'EMBALAGEM');

  //Volume Nason
  Configurar('VOLNLT',  'Volume Máximo embalagem Nason litro',  '0,900' , tpVolumeEmb, 'VOLUME');
  Configurar('VOLNGL',  'Volume Máximo embalagem Nason galão',  '3,600' , tpVolumeEmb, 'VOLUME');
  configurar('VOLNLA',  'Volume Máximo embalagem Nason lata ',  '18,000', tpVolumeEmb, 'VOLUME');

  Configurar('CHROLT', 'Produto embalagem Chroma litro', '', tpBotao, 'EMBALAGEM');
  Configurar('CHROGL', 'Produto embalagem Chroma galão', '', tpBotao, 'EMBALAGEM');
  Configurar('CHROLA', 'Produto embalagem Chroma lata',  '', tpBotao, 'EMBALAGEM');

  //Volume Choma
  Configurar('VOLCLT',  'Volume Máximo embalagem Chroma litro', '0,900' , tpVolumeEmb,  'VOLUME');
  Configurar('VOLCGL',  'Volume Máximo embalagem Chroma galão', '3,600' , tpVolumeEmb,  'VOLUME');
  Configurar('VOLCLA',  'Volume Máximo embalagem Chroma lata ', '18,000', tpVolumeEmb,  'VOLUME');

  Configurar('IMROLT', 'Produto embalagem Imron litro',  '', tpBotao, 'EMBALAGEM');
  Configurar('IMROGL', 'Produto embalagem Imron galão',  '', tpBotao, 'EMBALAGEM');
  Configurar('IMROLA', 'Produto embalagem Imron lata',   '', tpBotao, 'EMBALAGEM');

  //Volume Imron
  Configurar('VOLILT',  'Volume Máximo embalagem Imron litro',  '0,900' ,  tpVolumeEmb,  'VOLUME');
  Configurar('VOLIGL',  'Volume Máximo embalagem Imron galão',  '3,600' ,  tpVolumeEmb,  'VOLUME');
  Configurar('VOLILA',  'Volume Máximo embalagem Imron lata' ,  '18,000',  tpVolumeEmb,  'VOLUME');

  Configurar('CORMLT', 'Produto embalagem Cormax litro', '', tpBotao, 'EMBALAGEM');
  Configurar('CORMGL', 'Produto embalagem Cormax galão', '', tpBotao, 'EMBALAGEM');
  Configurar('CORMLA', 'Produto embalagem Cormax lata',  '', tpBotao, 'EMBALAGEM');

  //Volume Cormax
  Configurar('VOLMLT',  'Volume Máximo embalagem Cormax litro', '0,900' ,  tpVolumeEmb,  'VOLUME');
  Configurar('VOLMGL',  'Volume Máximo embalagem Cormax galão', '3,600' ,  tpVolumeEmb,  'VOLUME');
  Configurar('VOLMLA',  'Volume Máximo embalagem Cormax lata' , '18,000',  tpVolumeEmb,  'VOLUME');

  Configurar('ITECOP', 'Produto embalagem copo',            '', tpBotao, 'EMBALAGEM');
  //VolumeCopo
  Configurar('VOLCOP',  'Volume Máximo embalagem  copo',  '0,500',  tpVolumeEmb,  'VOLUME');
  Configurar('ITESPS', 'Produto embalagem spray sintético', '', tpBotao, 'EMBALAGEM');
  //VolumeSpraySint
  Configurar('VOLSPS',  'Volume Máximo embalagem spray sintético',  '0,150',  tpVolumeEmb,  'VOLUME');
  Configurar('ITESPO', 'Produto embalagem spray poliéster', '', tpBotao, 'EMBALAGEM');
  //VolumeSprayPoli
  Configurar('VOLSPO',  'Volume Máximo embalagem spray poliéster',  '0,150',  tpVolumeEmb,  'VOLUME');
  Configurar('ITESDU', 'Produto embalagem spray duco',      '', tpBotao, 'EMBALAGEM');
  //VolumeSprayDuco
  Configurar('VOLSDU',  'Volume Máximo embalagem spray duco', '0,150', tpVolumeEmb, 'VOLUME');
  Configurar('ITEBAL', 'Produto embalagem balde',           '', tpBotao, 'EMBALAGEM');
  //VolumeBalde
  Configurar('VOLBAL',  'Volume Máximo embalagem balde',  '18,000', tpVolumeEmb,  'VOLUME');
  Configurar('ITETAM', 'Produto embalagem tambor',          '', tpBotao, 'EMBALAGEM');
  //VolumeTambor
  Configurar('VOLTAM',  'Volume Máximo embalagem tambor', '196,000',  tpVolumeEmb,  'VOLUME');

  Configurar('PROCHR', 'Produto Venda da Linha CHROMA', '', tpBotaoVenda, 'GERAL');
  Configurar('PRODUX', 'Produto Venda da Linha DUXONE', '', tpBotaoVenda, 'GERAL');
  Configurar('PROIRO', 'Produto Venda da Linha IMRON',  '', tpBotaoVenda, 'GERAL');
  Configurar('PRONAS', 'Produto Venda da Linha NASON',  '', tpBotaoVenda, 'GERAL');
  Configurar('PROCOR', 'Produto Venda da Linha CORMAX', '', tpBotaoVenda, 'GERAL');
  Configurar('PROCHA', 'Produto chapinha para acerto de cor', '', tpBotaoVenda, 'GERAL');
  Configurar('TRACHA', 'Permitir desmarcar a opção de chapinha no cadastro de novas fórmulas', 'S', tpSimNao, 'GERAL');
end;

{$IFNDEF LINUX}
function TConfiguradorDupont.DiretorioValidar(strDir: String): string;
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

function TConfiguradorDupont.fConsultaProdutoEmbalagem(const strValCfg: String): String;
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
                                             'CADITE', 'untConfiguradorDupont', 'Consulta Item - Axalta', qryCadIte, [], []) Then
    Begin
      Result := qryCadIte.FieldByName('ITE_CODITE').AsString;
    End;
  {$ENDIF}

  Finally
  End;
end;

function TConfiguradorDupont.fConsultaProdutoVenda(
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
                                             'CADITE', 'untConfiguradorDupont', 'Consulta Item - Axalta', qryCadIte, [], []) Then
    Begin
      Result := qryCadIte.FieldByName('ITE_CODITE').AsString;
    End;
  {$ENDIF}

  Finally
  End;
end;

procedure TConfiguradorDupont.NumeroValidar(var DisplayValue: Variant;
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
