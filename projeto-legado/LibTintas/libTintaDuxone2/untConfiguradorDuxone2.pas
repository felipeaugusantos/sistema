{********************************************************************************}
{* Classes responsável por configurar a tela de configurações da tinta Duxone2   *}
{*****************************************************************************AC*}
unit untConfiguradorDuxone2;

interface

uses
{$IFNDEF LINUX}
  Controls,
  Dialogs,
{$ENDIF}
  untIConfiguradorTinta, untAbstractConfiguradorTinta, untIAuttinWrapper, Classes,
  SysUtils, untIDataSet, untAutcomTintaFactory, untStrUtils, untTypesSistema;

type
  TConfiguradorDuxone2 = class(TAbstractConfiguradorTinta, IConfiguradorTinta)
  private
    arrTitCol: array of string;
    arrTitEmb: array of string;
    Procedure pAddNomeColunaEmbalagem(strNomCol: String);
    Procedure pAddNomeColunaVenda(strNomCol: String);
    function fConsultaProdutoEmbalagem(const strValCfg: String): String;
    function fConsultaProdutoVenda(const strValCfg: String): String;
    function fItemItemSer(): String;
    function fItemSerTer(): String;
    function fItemIteFre(): String;
    function fItemIteBom(): String;
    function fItemIteEne(): String;
    function fItemIteVid(): String;
    function fItemIteTax(): String;
    function fItemItePro(): String;
    function fItemIteCon(): String;
  public
    constructor Create(const auttin: IAuttinWrapper); reintroduce;
    function IsConfiguracaoExistente(const strCodCfg: string): Boolean; Override;
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

{ TConfiguradorDuxone2 }

function TConfiguradorDuxone2.BotaoVendaClick(const strCodCfg,
  strValCfg: string): string;
begin
  Result := fConsultaProdutoVenda(strValCfg);
end;

procedure TConfiguradorDuxone2.BotaoVendaValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
var
  qryValida: IDataSet;
begin
  If Not TStrUtils.fEmptyStr(DisplayValue) Then
  Begin
    Try
      Error := False;
      qryValida := TAutcomTintaFactory.Get.fGetDataSet;

      Begin
        qryValida.SQL := 'SELECT                  ' +
               '  COUNT(*) AS QTD       ' +
               '  FROM                  ' +
               '    CADITE              ' +
               ' WHERE                  ' +
               '   ITE_CODITE = :CODITE ' +
               '   AND ITE_ITEATI = "S" ';


        qryValida.SQL := qryValida.SQL + fItemItemSer;
        qryValida.SQL := qryValida.SQL + fItemSerTer;
        qryValida.SQL := qryValida.SQL + fItemIteFre;
        qryValida.SQL := qryValida.SQL + fItemIteBom;
        qryValida.SQL := qryValida.SQL + fItemIteEne;
        qryValida.SQL := qryValida.SQL + fItemIteVid;
        qryValida.SQL := qryValida.SQL + fItemIteTax;
        qryValida.SQL := qryValida.SQL + fItemItePro;
        qryValida.SQL := qryValida.SQL + fItemIteCon;
        qryValida.SQL := qryValida.SQL + '  AND ITE_DESITE NOT LIKE "%ITEM ESPECIAL%"           ';

        qryValida.ParamByName('CODITE').AsString := DisplayValue;
        qryValida.Open;

        If qryValida.FieldByName('QTD').AsInteger <= 0 Then
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

function TConfiguradorDuxone2.ConfigurarClick(const strCodCfg,
  strValCfg: string): string;
begin
  Result := fConsultaProdutoEmbalagem(strValCfg);
end;

procedure TConfiguradorDuxone2.ConfigurarValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
var
  qryValida: IDataSet;
begin
  If Not TStrUtils.fEmptyStr(DisplayValue) Then
  Begin
    Try
      Error := False;
      qryValida := TAutcomTintaFactory.Get.fGetDataSet;

      Begin
        qryValida.SQL := 'SELECT                  ' +
                         '  COUNT(*) AS QTD       ' +
                         '  FROM                  ' +
                         '    CADITE              ' +
                         ' WHERE                  ' +
                         '   ITE_CODITE = :CODITE ' +
                         '   AND ITE_ITEATI = "S" ' +
                         '   AND ITE_PROEMB = "S" ';

        qryValida.SQL := qryValida.SQL + fItemItemSer;
        qryValida.SQL := qryValida.SQL + fItemSerTer;
        qryValida.SQL := qryValida.SQL + fItemIteFre;
        qryValida.SQL := qryValida.SQL + fItemIteBom;
        qryValida.SQL := qryValida.SQL + fItemIteEne;
        qryValida.SQL := qryValida.SQL + fItemIteVid;
        qryValida.SQL := qryValida.SQL + fItemIteTax;
        qryValida.SQL := qryValida.SQL + fItemItePro;
        qryValida.SQL := qryValida.SQL + fItemIteCon;
        qryValida.SQL := qryValida.SQL + '  AND ITE_DESITE NOT LIKE "%ITEM ESPECIAL%"           ';

        qryValida.ParamByName('CODITE').AsString := DisplayValue;
        qryValida.Open;

        If qryValida.FieldByName('QTD').AsInteger <= 0 Then
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

constructor TConfiguradorDuxone2.Create(const auttin: IAuttinWrapper);
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetIdePro, auttin);

  Configurar('USATIN', 'Utilizar essa tinta de máquina', 'S', tpSimNao, 'GERAL');
  Configurar('USAFOR', 'Utilizar Formulação', 'S', tpSimNao, 'GERAL');
  Configurar('MODVEN', 'Modo de Venda', '0', tpModoVenda, 'GERAL');
  Configurar('EMB1_4', 'Preço embalagem litro', '0,00', tpNumeroDecimal, 'PREÇO');
  Configurar('EMBGAL', 'Preço embalagem galão', '0,00', tpNumeroDecimal, 'PREÇO');
  Configurar('ITE1_4', 'Produto embalagem Duxone 2 Litro', '', tpBotao, 'EMBALAGEM');
  Configurar('ITEGAL', 'Produto embalagem Duxone 2 galão', '', tpBotao, 'EMBALAGEM');
  Configurar('ITELAT', 'Produto embalagem Duxone 2 lata',  '', tpBotao, 'EMBALAGEM');
  Configurar('VOL1_4', 'Volume Máximo embalagem Duxone 2 Litro', '0,900', tpVolumeEmb, 'EMBALAGEM');
  Configurar('VOLGAL', 'Volume Máximo embalagem Duxone 2 Galão', '3,600', tpVolumeEmb, 'EMBALAGEM');
  Configurar('VOLLAT', 'Volume Máximo embalagem Duxone 2 Lata', '18,000', tpVolumeEmb, 'EMBALAGEM');
  Configurar('TRADU2', 'Trava de preço', 'VEN', tpTravaPreco, 'PREÇO');
  Configurar('FATDU2', 'Fator da trava de preço', '1,00', tpNumeroDecimal, 'PREÇO');
  Configurar('FATCUS', 'Fator da trava de preço de custo', '1,00', tpNumeroDecimal, 'PREÇO');
  Configurar('PATDU2', 'Path para a geração dos arquivos', '', tpDiretorio, 'PATH ARQUIVOS');
  Configurar('NFMDU2', 'Próximo código da novas fórmulas', '1', tpNumero_5, 'GERAL');
  Configurar('ACUABS', 'Valores da Formulação: (1 - Acumulada / 2 - Absoluta)', '2', tpAcuAbs, 'GERAL');
  Configurar('VERSAO', 'Versão da máquina', '', 1, 'GERAL');
  Configurar('DTAATU', 'Data da Ultima Atualização', '', tpData, 'GERAL');
  Configurar('DESOPE', 'Despesas Operacionais da Tinta (%)', '0,00', tpNumeroDecimal, 'GERAL');
  Configurar('APREVE', 'Acréscimo Adicional sobre Preço de Venda (%)', '0,00', tpNumeroDecimal, 'GERAL');
  Configurar('DECFOR', 'Quantidade de casas decimais que serão exibidas nas quantidades da formulação (1, 2 ou 3)', '2', tpNumero, 'GERAL');
  Configurar('ITECOP', 'Produto embalagem copo',            '', tpBotao, 'EMBALAGEM');
  Configurar('ITESPS', 'Produto embalagem spray sintético', '', tpBotao, 'EMBALAGEM');
  Configurar('ITESPO', 'Produto embalagem spray poliéster', '', tpBotao, 'EMBALAGEM');
  Configurar('ITESDU', 'Produto embalagem spray duco',      '', tpBotao, 'EMBALAGEM');
  Configurar('ITEBAL', 'Produto embalagem balde',           '', tpBotao, 'EMBALAGEM');
  Configurar('ITETAM', 'Produto embalagem tambor',          '', tpBotao, 'EMBALAGEM');
  Configurar('VOLCOP', 'Volume Máximo embalagem Copo', '0,500', tpVolumeEmb, 'EMBALAGEM');
  Configurar('VOLSPS', 'Volume Máximo embalagem Spray Sintético', '0,150', tpVolumeEmb, 'EMBALAGEM');
  Configurar('VOLSPO', 'Volume Máximo embalagem Spray Poliéster', '0,150', tpVolumeEmb, 'EMBALAGEM');
  Configurar('VOLSDU', 'Volume Máximo embalagem Spray Duco', '0,150', tpVolumeEmb, 'EMBALAGEM');
  Configurar('VOLBAL', 'Volume Máximo embalagem Balde', '18,000', tpVolumeEmb, 'EMBALAGEM');
  Configurar('VOLTAM', 'Volume Máximo embalagem Tambor', '196,000', tpVolumeEmb, 'EMBALAGEM');
  Configurar('PRODU2', 'Produto Venda da Linha Duxone 2', '', tpBotaoVenda, 'GERAL');
  Configurar('ACRMOB', 'Acréscimo de mão de obra será em:', '0', tpAcrMob, 'GERAL');
  Configurar('MINDIL', 'Percentual Mínimo de Diluição (%)', '50', tpNumero, 'DILUIÇÃO');
  Configurar('MAXDIL', 'Percentual Máximo de Diluição (%)', '80', tpNumero, 'DILUIÇÃO');
  Configurar('PROCHA', 'Produto chapinha para acerto de cor', '', tpBotaoVenda, 'GERAL');
  Configurar('TRACHA', 'Permitir desmarcar a opção de chapinha no cadastro de novas fórmulas', 'S', tpSimNao, 'GERAL');
end;

{$IFNDEF LINUX}
function TConfiguradorDuxone2.DiretorioValidar(strDir: String): string;
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

function TConfiguradorDuxone2.fConsultaProdutoEmbalagem(const strValCfg: String): String;
var
  strSQL, strSQLWhere: String;
  qryCadIte : IDataSet;
begin
  qryCadIte := Nil;

  Result := strValCfg;
  Try

    strSQL := 'SELECT';
    strSQL := strSQL + '   ITE_DESITE, ';  pAddNomeColunaEmbalagem('Descrição');
    strSQL := strSQL + '   ITE_REFERE, ';  pAddNomeColunaEmbalagem('Referência');
    strSQL := strSQL + '   ITE_CODITE, ';  pAddNomeColunaEmbalagem('Código');
    strSQL := strSQL + '   ITE_CODBAR, ';  pAddNomeColunaEmbalagem('Cód. Barra');
    strSQL := strSQL + '   AUTOINCREM  ';
    strSQL := strSQL + ' FROM CADITE ';
    strSQLWhere := strSQLWhere + ' WHERE ITE_ITEATI = "S" ';
    strSQLWhere := strSQLWhere + '   AND ITE_PROEMB = "S" ';

    strSQLWhere := strSQLWhere + fItemItemSer;
    strSQLWhere := strSQLWhere + fItemSerTer;
    strSQLWhere := strSQLWhere + fItemIteFre;
    strSQLWhere := strSQLWhere + fItemIteBom;
    strSQLWhere := strSQLWhere + fItemIteEne;
    strSQLWhere := strSQLWhere + fItemIteVid;
    strSQLWhere := strSQLWhere + fItemIteTax;
    strSQLWhere := strSQLWhere + fItemItePro;
    strSQLWhere := strSQLWhere + fItemIteCon;
    strSQLWhere := strSQLWhere + '  AND ITE_DESITE NOT LIKE "%ITEM ESPECIAL%"           ';

  {$IFNDEF LINUX}
    If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere], arrTitEmb, ['ITE_DESITE'], 'AUTOINCREM',
                                             'CADITE', 'untConfiguradorAutoluks', 'Consulta Item - Autoluks', qryCadIte, [], []) Then
    Begin
      Result := qryCadIte.FieldByName('ITE_CODITE').AsString;
    End;
  {$ENDIF}

  Finally
  End;
end;

function TConfiguradorDuxone2.fConsultaProdutoVenda(
  const strValCfg: String): String;
var
  strSQL, strSQLWhere: String;
  qryCadIte : IDataSet;
begin
  qryCadIte := Nil;

  Result := strValCfg;
  Try
    strSQL := 'SELECT';
    strSQL := strSQL + '   ITE_DESITE, ';  pAddNomeColunaVenda('Descrição');
    strSQL := strSQL + '   ITE_REFERE, ';  pAddNomeColunaVenda('Referência');
    strSQL := strSQL + '   ITE_CODITE, ';  pAddNomeColunaVenda('Código');
    strSQL := strSQL + '   ITE_CODBAR, ';  pAddNomeColunaVenda('Cód. Barra');
    strSQL := strSQL + '   AUTOINCREM  ';
    strSQL := strSQL + ' FROM CADITE ';
    strSQLWhere := strSQLWhere + ' WHERE ITE_ITEATI = "S" ';

    strSQLWhere := strSQLWhere + fItemItemSer;
    strSQLWhere := strSQLWhere + fItemSerTer;
    strSQLWhere := strSQLWhere + fItemIteFre;
    strSQLWhere := strSQLWhere + fItemIteBom;
    strSQLWhere := strSQLWhere + fItemIteEne;
    strSQLWhere := strSQLWhere + fItemIteVid;
    strSQLWhere := strSQLWhere + fItemIteTax;
    strSQLWhere := strSQLWhere + fItemItePro;
    strSQLWhere := strSQLWhere + fItemIteCon;
    strSQLWhere := strSQLWhere + '  AND ITE_DESITE NOT LIKE "%ITEM ESPECIAL%"           ';

  {$IFNDEF LINUX}
    If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere], arrTitCol, ['ITE_DESITE'], 'AUTOINCREM',
                                             'CADITE', 'untConfiguradorAutoluks', 'Consulta Item - Autoluks', qryCadIte, [], []) Then
    Begin
      Result := qryCadIte.FieldByName('ITE_CODITE').AsString;
    End;
  {$ENDIF}

  Finally
  End;
end;

function TConfiguradorDuxone2.fItemIteBom: String;
begin
  Result := '';

  If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITEBOM')) Then
    Result := '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITEBOM'));
end;

function TConfiguradorDuxone2.fItemIteCon: String;
begin
  Result := '';

  If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITECON')) Then
    Result := '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITECON'));
end;

function TConfiguradorDuxone2.fItemIteEne: String;
begin
  Result := '';

  If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITEENE')) Then
    Result := '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITEENE'));
end;

function TConfiguradorDuxone2.fItemIteFre: String;
begin
  Result := '';

  If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITEFRE')) Then
    Result := '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITEFRE'));
end;

function TConfiguradorDuxone2.fItemItemSer: String;
begin
  Result := '';

  If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITESER')) Then
    Result := '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITESER'));
end;

function TConfiguradorDuxone2.fItemItePro: String;
begin
  Result := '';

  If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('PROMAT')) Then
    Result := '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('PROMAT'));
end;

function TConfiguradorDuxone2.fItemIteTax: String;
begin
  Result := '';

  If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITETAX')) Then
    Result := '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITETAX'));
end;

function TConfiguradorDuxone2.fItemIteVid: String;
begin
  Result := '';

  If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITEVID')) Then
    Result := '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITEVID'));
end;

function TConfiguradorDuxone2.fItemSerTer: String;
begin
  Result := '';

  If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('SERTER')) Then
    Result := '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('SERTER'));
end;

function TConfiguradorDuxone2.IsConfiguracaoExistente(
  const strCodCfg: string): Boolean;
begin
  Result := GetConfiguracoesExistentes().IndexOf(strCodCfg) >= 0;

  If Not TAutcomTintaFactory.Get.fEhAdministrador(TAutcomTintaFactory.Get.GetUsuarioLogado) Then
  Begin
    If strCodCfg = 'MAXDIL' Then
      Result := False;

    If strCodCfg = 'MINDIL' Then
      Result := False;
  End;
end;

procedure TConfiguradorDuxone2.NumeroValidar(var DisplayValue: Variant;
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

procedure TConfiguradorDuxone2.pAddNomeColunaEmbalagem(strNomCol: String);
begin
  SetLength(arrTitEmb, Succ(Length(arrTitEmb)));
  arrTitEmb[High(arrTitEmb)] := strNomCol;
end;

procedure TConfiguradorDuxone2.pAddNomeColunaVenda(strNomCol: String);
begin
  SetLength(arrTitCol, Succ(Length(arrTitCol)));
  arrTitCol[High(arrTitCol)] := strNomCol;
end;

end.
