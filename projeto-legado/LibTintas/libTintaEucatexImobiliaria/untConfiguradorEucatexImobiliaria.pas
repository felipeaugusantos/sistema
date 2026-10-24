{*******************************************************************************************}
{* Classes responsável por configurar a tela de configurações da tinta Eucatex Imobiliaria *}
{****************************************************************************************PH*}
unit untConfiguradorEucatexImobiliaria;

interface

uses
{$IFNDEF LINUX}
  Controls,
  Dialogs,
{$ENDIF}
  untIConfiguradorTinta, untAbstractConfiguradorTinta, untIAuttinWrapper,
  SysUtils, untIDataSet, untStrUtils, untAutcomTintaFactory, untTypesSistema;

type
  TConfiguradorEucatexImobiliaria = class(TAbstractConfiguradorTinta, IConfiguradorTinta)
  private
    function fConsultaUnidade(const strValCfg: String): String;
  public
    constructor Create(const auttin: IAuttinWrapper); reintroduce;
    function ConfigurarClick(const strCodCfg: string; const strValCfg: string): string; override;
    procedure ConfigurarValidar(var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean); override;

  {$IFNDEF LINUX}
    function DiretorioValidar(strDir: String): string; override;
  {$ENDIF}

    procedure NumeroValidar(var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean; const strNomCam: String); override;
    function BotaoVendaClick(const strCodCfg: string;
      const strValCfg: string): string; override;
    procedure BotaoVendaValidar(var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean); override;
  end;

implementation

uses
  untLibTintaFactory;

{ TConfiguradorEucatexImobiliaria }

function TConfiguradorEucatexImobiliaria.BotaoVendaClick(const strCodCfg,
  strValCfg: string): string;
begin

end;

procedure TConfiguradorEucatexImobiliaria.BotaoVendaValidar(
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin

end;

function TConfiguradorEucatexImobiliaria.ConfigurarClick(const strCodCfg: string; const strValCfg: string): string;
begin
  Result := fConsultaUnidade(strValCfg);
end;

procedure TConfiguradorEucatexImobiliaria.ConfigurarValidar(var DisplayValue: Variant;
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

constructor TConfiguradorEucatexImobiliaria.Create(const auttin: IAuttinWrapper);
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetIdePro, auttin);

  Configurar('USATIN', 'Utilizar essa tinta de máquina', 'N', tpSimNao, 'GERAL');
  Configurar('EUCTRA', 'Trava para valor de venda EUC_PRE', 'VEN', tpTravaPreco, 'GERAL');
  Configurar('EUCFAT', 'Fator', '1', tpNumeroDecimal, 'GERAL');
  Configurar('EUCNFM', 'Próximo código nova Fórmula', '1', tpNumero_5, 'GERAL');
  Configurar('DESOPE', 'Despesa Operacional da Tinta (%)', '0', tpNumeroDecimal, 'GERAL');
  Configurar('APREVE', 'Acréscimo Adicional sobre Preço de Venda (%)', '0', tpNumeroDecimal, 'GERAL');
  Configurar('EUCPAT', 'Path para arquivo de fórmulas',  '', tpDiretorio, 'GERAL');
  Configurar('EUCGAL', 'Unidade(Galão)', '', tpBotao, 'GERAL');
  Configurar('EUCLAT', 'Unidade(Lata)', '', tpBotao, 'GERAL');
  Configurar('EUCQUA', 'Unidade(Quarto)', '', tpBotao, 'GERAL');
  Configurar('USAFOR', 'Utilizar formulação',  'S', tpSimNao, 'GERAL');
  Configurar('EUCMAN', 'Máquina Manual', 'N', tpSimNao, 'GERAL');
  Configurar('TIPGER', 'Tipo da geração (Excel ou Txt)', '0', tpTipoGeracao, 'GERAL');
  Configurar('DTAATU' ,  'Data da Ultima Atualização'               , ''        , tpData          , 'GERAL');
  Configurar('VERSAO' ,  'Versão da máquina'                        , ''        , tpNormal        , 'GERAL');
  Configurar('UNIOPR' ,  'Unidade da Impressão de Ordem de Produção', ''        , tpUniImpOp      , 'GERAL');
  Configurar('ZERCOL' ,  'Zerar valor dos colorantes na venda da tinta de máquina', 'N', tpSimNao, 'GERAL');
  Configurar('ACRMOB', 'Acréscimo de mão de obra será em:', '0', tpAcrMob, 'GERAL');
  Configurar('BASUNI', 'Permitir amarrar produtos com unidades diferentes no cadastro de base', 'S', tpSimNao, 'GERAL');
end;

{$IFNDEF LINUX}
function TConfiguradorEucatexImobiliaria.DiretorioValidar(strDir: String): string;
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

function TConfiguradorEucatexImobiliaria.fConsultaUnidade(
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

    {$IFNDEF LINUX}
      If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere],
        arrTitCol, ['UNI_DESUNI'], 'AUTOINCREM', 'CADUNI', 'untConfiguradorEucatex',
        'Consulta de Unidade - Tintas', qryCadUni, [], []) Then
      Begin
        Result := qryCadUni.FieldByName('UNI_CODUNI').AsString;
      End;
    {$ENDIF}
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
  End;
end;

procedure TConfiguradorEucatexImobiliaria.NumeroValidar(
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean;
  const strNomCam: String);
begin

end;

end.
