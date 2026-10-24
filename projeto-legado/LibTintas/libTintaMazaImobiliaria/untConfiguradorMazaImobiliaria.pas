{*******************************************************************************}
{* Classes responsável por configurar a tela de configurações da tinta MazaImobiliaria *}
{****************************************************************************PH*}
unit untConfiguradorMazaImobiliaria;

interface

uses
{$IFNDEF LINUX}
  Controls,
  Dialogs,
{$ENDIF}
  untIConfiguradorTinta, untAbstractConfiguradorTinta, untIAuttinWrapper,
  SysUtils, untIDataSet, untStrUtils, untTypesSistema;

type
  TConfiguradorMazaImobiliaria = class(TAbstractConfiguradorTinta, IConfiguradorTinta)
  private
  {$IFNDEF LINUX}
    function fConsultaUnidade(const strValCfg: String): String;
  {$ENDIF}

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
  end;

implementation

uses
  untLibTintaFactory, untAutcomTintaFactory;

{ TConfiguradorMazaImobiliaria }

function TConfiguradorMazaImobiliaria.BotaoVendaClick(const strCodCfg,
  strValCfg: string): string;
begin

end;

procedure TConfiguradorMazaImobiliaria.BotaoVendaValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;

end;

{$IFNDEF LINUX}
function TConfiguradorMazaImobiliaria.ConfigurarClick(const strCodCfg: string; const strValCfg: string): string;
begin
  Result := fConsultaUnidade(strValCfg);
end;
{$ENDIF}

procedure TConfiguradorMazaImobiliaria.ConfigurarValidar(var DisplayValue: Variant;
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
               '    CADUNI              ' +
               ' WHERE                  ' +
               '   UNI_CODUNI = :CODUNI ' +
               '   AND UNI_SIGUNI IN ("QT","LT","GL","LA") ';
        ParamByName('CODUNI').AsString := DisplayValue;
        Open;

        If FieldByName('QTD').AsInteger <= 0 Then
        Begin
          TAutcomTintaFactory.Get.fMensagem('ATENÇÃO', 'Unidade não encontrada, favor verificar !', ['&Ok']);
          DisplayValue := '';
          Error := True;
        End;
      End;
    Except

    End;
  End;
end;

{$IFNDEF LINUX}
function TConfiguradorMazaImobiliaria.fConsultaUnidade(
  const strValCfg: String): String;
var
  strSQL, strSQLWhere: String;
  qryCadUni : IDataSet;
  arrTitCol: Array of String;

  Procedure pAddNomeColuna(strNomCol: String);
  Begin
    SetLength(arrTitCol, Succ(Length(arrTitCol)));
    arrTitCol[High(arrTitCol)] := strNomCol;
  End;
begin
  Result := strValCfg;
  Try
    Try
      qryCadUni := TAutcomTintaFactory.Get.fGetDataSet;

      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + '   U.UNI_CODUNI, '; pAddNomeColuna('Código');
      strSQL := strSQL + '   U.UNI_DESUNI, '; pAddNomeColuna('Descrição');
      strSQL := strSQL + '   U.UNI_SIGUNI, '; pAddNomeColuna('Sigla');
      strSQL := strSQL + '   U.AUTOINCREM ';
      strSQL := strSQL + ' FROM   ';
      strSQL := strSQL + '   CADUNI U  ';
      strSQLWhere := ' WHERE UNI_SIGUNI IN ("QT","LT","GL","LA") ';

      If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere],
        arrTitCol, ['UNI_DESUNI'], 'AUTOINCREM', 'CADUNI', 'untConfiguradorMazaImobiliaria', 'Consulta de Unidade - Tintas', qryCadUni, [], []) Then
      Begin
        Result := qryCadUni.FieldByName('UNI_CODUNI').AsString;
      End;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
  End;
end;
{$ENDIF}

constructor TConfiguradorMazaImobiliaria.Create(const auttin: IAuttinWrapper);
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetIdePro, auttin);

  TAutcomTintaFactory.Get.fInsereProCod('MZI_CADBAS', false);
  TAutcomTintaFactory.Get.fInsereProCod('MZI_CADCOL', false);
  TAutcomTintaFactory.Get.fInsereProCod('MZI_CADNFM', false);
  TAutcomTintaFactory.Get.fInsereProCod('MZI_CADMZI', false);

  Configurar('DTAATU' ,  'Data da Ultima Atualização'               , ''        , tpData          , 'GERAL');
  Configurar('VERSAO' ,  'Versão da máquina'                        , ''        , tpNormal        , 'GERAL');
  Configurar('APREVE' ,  'Acréscimo Adicional sobre Preço de Venda (%)' , '0'       , tpNumeroDecimal , 'GERAL');
  Configurar('DESOPE' ,  'Despesas Operacionais da Tinta (%)'           , '0'       , tpNumeroDecimal , 'GERAL');
  Configurar('FATMZI' ,  'Fator da trava de preço'                  , '0'       , tpNumeroDecimal , 'GERAL');
  Configurar('PATMZI' ,  'Path para arquivo de geração'             , ''        , tpDiretorio     , 'GERAL');
  Configurar('PROCOD' ,  'Próximo Código Novas Fórmulas'            , '00001'   , tpNumero_5      , 'GERAL');
  Configurar('TRATIN' ,  'Trava para valor de venda'                , 'VEN'     , tpTravaPreco    , 'GERAL');
  Configurar('USAFOR' ,  'Utilizar Formulação'                      , 'S'       , tpSimNao        , 'GERAL');
  Configurar('USATIN' ,  'Utilizar essa tinta de máquina'           , 'N'       , tpSimNao        , 'GERAL');
  Configurar('UNIOPR' ,  'Unidade da Impressão de Ordem de Produção', ''        , tpUniImpOp      , 'GERAL', 'CFG_PULMLS');
  Configurar('MZIQUA' ,  'Unidade (Litro)'                          , ''        , tpBotao         , 'EMBALAGEM');
  Configurar('MZIGAL' ,  'Unidade (Galão)'                          , ''        , tpBotao         , 'EMBALAGEM');
  Configurar('MZILAT' ,  'Unidade (Lata)'                           , ''        , tpBotao         , 'EMBALAGEM');
  Configurar('ZERCOL' ,  'Zerar valor dos colorantes na venda da tinta de máquina', 'N', tpSimNao, 'GERAL');
  Configurar('ACRMOB', 'Acréscimo de mão de obra será em:', '0', tpAcrMob, 'GERAL');
  Configurar('BASUNI', 'Permitir amarrar produtos com unidades diferentes no cadastro de base', 'S', tpSimNao, 'GERAL');

  //CONFIGURAÇÃO POSTGRESSQL - Maza Imobiliaria
  Configurar('SERMZI', 'Servidor: ', '', tpNormal, 'CONEXÃO');
  Configurar('PORMZI', 'Porta: ', '', tpNormal, 'CONEXÃO');
  Configurar('USUMZI', 'Usuario: ', '', tpNormal, 'CONEXÃO');
  Configurar('SENMZI', 'Senha: ', '', tpSenha, 'CONEXÃO');
  Configurar('DBMZII', 'Database: ', '', tpNormal, 'CONEXÃO');
end;

{$IFNDEF LINUX}
function TConfiguradorMazaImobiliaria.DiretorioValidar(strDir: String): string;
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

procedure TConfiguradorMazaImobiliaria.NumeroValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean; const strNomCam: String);
begin
end;

end.
