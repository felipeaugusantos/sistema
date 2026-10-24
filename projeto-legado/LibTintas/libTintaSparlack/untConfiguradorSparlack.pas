{*******************************************************************************}
{* Classes responsável por configurar a tela de configurações da tinta Sparlack *}
{****************************************************************************PH*}
unit untConfiguradorSparlack;

interface

uses
{$IFNDEF LINUX}
  Controls,
  Dialogs,
{$ENDIF}
  untIConfiguradorTinta, untAbstractConfiguradorTinta, untIAuttinWrapper,
  SysUtils, untIDataSet, untStrUtils, untTypesSistema;

type
  TConfiguradorSparlack = class(TAbstractConfiguradorTinta, IConfiguradorTinta)
  private
    function fConsultaUnidade(const strValCfg: String): String;

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
  untLibTintaFactory, untAutcomTintaFactory;

{ TConfiguradorSparlack }

function TConfiguradorSparlack.BotaoVendaClick(const strCodCfg,
  strValCfg: string): string;
begin

end;

procedure TConfiguradorSparlack.BotaoVendaValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;

end;

function TConfiguradorSparlack.ConfigurarClick(const strCodCfg: string; const strValCfg: string): string;
begin
  Result := fConsultaUnidade(strValCfg);
end;

procedure TConfiguradorSparlack.ConfigurarValidar(var DisplayValue: Variant;
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
               '   AND UNI_SIGUNI IN ("QT","GL","BL") ';
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
function TConfiguradorSparlack.fConsultaUnidade(
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
      strSQLWhere := ' WHERE UNI_SIGUNI IN ("QT","GL","BL") ';

    {$IFNDEF LINUX}
      If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere],
        arrTitCol, ['UNI_DESUNI'], 'AUTOINCREM', 'CADUNI', 'untConfiguradorSparlack', 'Consulta de Unidade - Tintas', qryCadUni, [], []) Then
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


constructor TConfiguradorSparlack.Create(const auttin: IAuttinWrapper);
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetIdePro, auttin);

 { TAutcomTintaFactory.Get.fInsereProCod('SPA_CADBAS', false);
  TAutcomTintaFactory.Get.fInsereProCod('SPA_CADCOL', false);
  TAutcomTintaFactory.Get.fInsereProCod('SPA_CADNFM', false);
  TAutcomTintaFactory.Get.fInsereProCod('SPA_CADSPA', false);
  }
  Configurar('DTAATU' ,  'Data da Ultima Atualização'               , ''        , tpData          , 'GERAL');
  Configurar('VERSAO' ,  'Versão da máquina'                        , ''        , tpNormal        , 'GERAL');
  Configurar('APREVE' ,  'Acréscimo Adicional sobre Preço de Venda (%)' , '0'       , tpNumeroDecimal , 'GERAL');
  Configurar('DESOPE' ,  'Despesas Operacionais da Tinta (%)'           , '0'       , tpNumeroDecimal , 'GERAL');
  Configurar('FATSPA' ,  'Fator da trava de preço'                  , '0'       , tpNumeroDecimal , 'GERAL');
  Configurar('PATSPA' ,  'Path para arquivo de geração'             , ''        , tpDiretorio     , 'GERAL');
  Configurar('PROCOD' ,  'Próximo Código Novas Fórmulas'            , '00001'   , tpNumero_5      , 'GERAL');
  Configurar('TRATIN' ,  'Trava para valor de venda'                , 'VEN'     , tpTravaPreco    , 'GERAL');
  Configurar('USAFOR' ,  'Utilizar Formulação'                      , 'S'       , tpSimNao        , 'GERAL');
  Configurar('USATIN' ,  'Utilizar essa tinta de máquina'           , 'N'       , tpSimNao        , 'GERAL');
  Configurar('UNIOPR', 'Unidade da Impressão de Ordem de Produção', '3', tpUniImpOp, 'GERAL');
  Configurar('ZERCOL', 'Zerar valor dos colorantes na venda da tinta de máquina', 'N', tpSimNao, 'GERAL');
  Configurar('ACRMOB', 'Acréscimo de mão de obra será em:', '0', tpAcrMob, 'GERAL');
  Configurar('BASUNI', 'Permitir amarrar produtos com unidades diferentes no cadastro de base', 'S', tpSimNao, 'GERAL');
end;

{$IFNDEF LINUX}
function TConfiguradorSparlack.DiretorioValidar(strDir: String): string;
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


procedure TConfiguradorSparlack.NumeroValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean; const strNomCam: String);
begin
end;

end.
