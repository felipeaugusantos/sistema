{********************************************************************************}
{* Classes responsável por configurar a tela de configurações da tinta ProfissionalAutomotiva *}
{*****************************************************************************AC*}
unit untConfiguradorProfissionalAutomotiva;

interface

uses
{$IFNDEF LINUX}
  Controls,
  Dialogs,
{$ENDIF}
  untIConfiguradorTinta, untAbstractConfiguradorTinta, untIAuttinWrapper,
  SysUtils, untIDataSet, untAutcomTintaFactory, untStrUtils, untTypesSistema;

type
  TConfiguradorProfissionalAutomotiva = class(TAbstractConfiguradorTinta, IConfiguradorTinta)
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

{ TConfiguradorProfissionalAutomotiva }

function TConfiguradorProfissionalAutomotiva.BotaoVendaClick(const strCodCfg,
  strValCfg: string): string;
begin
  Result := fConsultaProdutoVenda(strValCfg);
end;

procedure TConfiguradorProfissionalAutomotiva.BotaoVendaValidar(var DisplayValue: Variant;
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

function TConfiguradorProfissionalAutomotiva.ConfigurarClick(const strCodCfg,
  strValCfg: string): string;
begin
  Result := fConsultaProdutoEmbalagem(strValCfg);
end;

procedure TConfiguradorProfissionalAutomotiva.ConfigurarValidar(var DisplayValue: Variant;
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

constructor TConfiguradorProfissionalAutomotiva.Create(const auttin: IAuttinWrapper);
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetIdePro, auttin);
  Configurar('USATIN', 'Utilizar essa tinta de máquina', 'S', tpSimNao, 'GERAL');
  Configurar('USAFOR', 'Utilizar Formulação', 'S', tpSimNao, 'GERAL');
  Configurar('MODVEN', 'Modo de Venda', '0', tpModoVenda, 'GERAL');
  Configurar('PFATRV', 'Trava de Preço', 'VEN', tpTravaPreco, 'GERAL');
  Configurar('PFANFM', 'Próximo código', '1', tpNumero_5, 'GERAL');
  Configurar('PFAFAT', 'Fator da Trava', '1', tpNumeroDecimal, 'GERAL');
  Configurar('DESOPE', 'Despesas Operacionais da Tinta (%)', '0,00', tpNumeroDecimal, 'GERAL');
  Configurar('APREVE', 'Acréscimo Adicional sobre Preço de Venda (%)', '0,00', tpNumeroDecimal, 'GERAL');
  Configurar('PFAPRO', 'Produto para Venda', '', tpBotaoVenda, 'GERAL');
  Configurar('ACUABS', 'Valores da Formulação: (1 - Acumulada / 2 - Absoluta)', '2', tpAcuAbs, 'GERAL');
  Configurar('DTAATU', 'Data da Ultima Atualização', '', tpData, 'GERAL');
  Configurar('VERSAO', 'Versão da máquina', '', tpNormal, 'GERAL');
  Configurar('ACRMOB', 'Acréscimo de mão de obra será em:', '0', tpAcrMob, 'GERAL');
  Configurar('PROCHA', 'Produto chapinha para acerto de cor', '', tpBotaoVenda, 'GERAL');
  Configurar('TRACHA', 'Permitir desmarcar a opção de chapinha no cadastro de novas fórmulas', 'S', tpSimNao, 'GERAL');
  Configurar('LITEMB', 'Produto Embalagem Litro', '', tpBotao, 'EMBALAGEM');
  Configurar('GALEMB', 'Produto Embalagem Galão', '', tpBotao, 'EMBALAGEM');
  Configurar('LATEMB', 'Produto Embalagem Lata', '', tpBotao, 'EMBALAGEM');
  Configurar('LITVOL', 'Volume Máximo Embalagem Litro', '0,900', tpVolumeEmb, 'EMBALAGEM');
  Configurar('GALVOL', 'Volume Máximo Embalagem Galão', '3,600', tpVolumeEmb, 'EMBALAGEM');
  Configurar('LATVOL', 'Volume Máximo Embalagem Lata', '18,000', tpVolumeEmb, 'EMBALAGEM');
  Configurar('PATPFA' ,  'Path para arquivo:'  , ''        , tpDiretorio     , 'GERAL');
end;

{$IFNDEF LINUX}
function TConfiguradorProfissionalAutomotiva.DiretorioValidar(strDir: String): string;
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

function TConfiguradorProfissionalAutomotiva.fConsultaProdutoEmbalagem(const strValCfg: String): String;
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
                                             'CADITE', 'untConfiguradorProfissionalAutomotiva', 'Consulta Item - ProfissionalAutomotiva', qryCadIte, [], []) Then
    Begin
      Result := qryCadIte.FieldByName('ITE_CODITE').AsString;
    End;

  {$ENDIF}

  Finally
  End;
end;

function TConfiguradorProfissionalAutomotiva.fConsultaProdutoVenda(
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
                                             'CADITE', 'untConfiguradorProfissionalAutomotiva', 'Consulta Item - ProfissionalAutomotiva', qryCadIte, [], []) Then
    Begin
      Result := qryCadIte.FieldByName('ITE_CODITE').AsString;
    End;

  {$ENDIF}


  Finally
  End;
end;

function TConfiguradorProfissionalAutomotiva.fItemIteBom: String;
begin
  Result := '';

  If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITEBOM')) Then
    Result := '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITEBOM'));
end;

function TConfiguradorProfissionalAutomotiva.fItemIteCon: String;
begin
  Result := '';

  If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITECON')) Then
    Result := '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITECON'));
end;

function TConfiguradorProfissionalAutomotiva.fItemIteEne: String;
begin
  Result := '';

  If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITEENE')) Then
    Result := '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITEENE'));
end;

function TConfiguradorProfissionalAutomotiva.fItemIteFre: String;
begin
  Result := '';

  If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITEFRE')) Then
    Result := '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITEFRE'));
end;

function TConfiguradorProfissionalAutomotiva.fItemIteTax: String;
begin
  Result := '';

  If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITETAX')) Then
    Result := '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITETAX'));
end;

function TConfiguradorProfissionalAutomotiva.fItemItemSer: String;
begin
  Result := '';

  If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITESER')) Then
    Result := '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITESER'));
end;

function TConfiguradorProfissionalAutomotiva.fItemItePro: String;
begin
  Result := '';

  If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('PROMAT')) Then
    Result := '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('PROMAT'));
end;

function TConfiguradorProfissionalAutomotiva.fItemIteVid: String;
begin
  Result := '';

  If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITEVID')) Then
    Result := '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITEVID'));
end;

function TConfiguradorProfissionalAutomotiva.fItemSerTer: String;
begin
  Result := '';

  If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('SERTER')) Then
    Result := '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('SERTER'));
end;

procedure TConfiguradorProfissionalAutomotiva.NumeroValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean; const strNomCam: String);
begin
  Error := False;
end;

procedure TConfiguradorProfissionalAutomotiva.pAddNomeColunaEmbalagem(strNomCol: String);
begin
  SetLength(arrTitEmb, Succ(Length(arrTitEmb)));
  arrTitEmb[High(arrTitEmb)] := strNomCol;
end;

procedure TConfiguradorProfissionalAutomotiva.pAddNomeColunaVenda(strNomCol: String);
begin
  SetLength(arrTitCol, Succ(Length(arrTitCol)));
  arrTitCol[High(arrTitCol)] := strNomCol;
end;

end.
