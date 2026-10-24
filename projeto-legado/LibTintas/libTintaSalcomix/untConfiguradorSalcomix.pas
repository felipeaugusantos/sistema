{********************************************************************************}
{* Classes responsável por configurar a tela de configurações da tinta Salcomix *}
{*****************************************************************************AC*}
unit untConfiguradorSalcomix;

interface

uses
  untIConfiguradorTinta, untAbstractConfiguradorTinta, untIAuttinWrapper,
  SysUtils, untIDataSet, untAutcomTintaFactory, Controls, untStrUtils, Dialogs;

type
  TConfiguradorSalcomix = class(TAbstractConfiguradorTinta, IConfiguradorTinta)
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
  end;

implementation

uses
  untLibTintaFactory;

{ TConfiguradorSalcomix }

function TConfiguradorSalcomix.BotaoVendaClick(const strCodCfg,
  strValCfg: string): string;
begin
  Result := fConsultaProdutoVenda(strValCfg);
end;

procedure TConfiguradorSalcomix.BotaoVendaValidar(var DisplayValue: Variant;
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

function TConfiguradorSalcomix.ConfigurarClick(const strCodCfg,
  strValCfg: string): string;
begin
  Result := fConsultaProdutoEmbalagem(strValCfg);
end;

procedure TConfiguradorSalcomix.ConfigurarValidar(var DisplayValue: Variant;
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

constructor TConfiguradorSalcomix.Create(const auttin: IAuttinWrapper);
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetIdePro, auttin);

  Configurar('USATIN', 'Utilizar essa tinta de máquina', 'N', tpSimNao, 'GERAL');
  Configurar('USAFOR', 'Utilizar Formulação', 'S', tpSimNao, 'GERAL');
  Configurar('MODVEN', 'Modo de Venda', '1',  tpModoVenda,  'GERAL');
  Configurar('CALFOR', 'Calculo da Formulação', '', tpCalForSal, 'GERAL');
  Configurar('SALPRO', 'Produto para Venda',  '', tpBotaoVenda, 'GERAL');
  Configurar('PROCOD', 'Proximo código novas fórmulas', '00001', tpNumero_5, 'GERAL');
  Configurar('SALPAT', 'Path para os arquivos', '', tpDiretorio, 'GERAL');
  Configurar('ACUABS', 'Valores da Formulação: (1 - Acumulada / 2 - Absolula)', '2', tpAcuAbs, 'GERAL');
  Configurar('DESOPE', 'Despesas Operacionais(%)', '', tpNumeroDecimal, 'GERAL');
  Configurar('APREVE', 'Acréscimo adicional sobre preço de venda', '', tpNumeroDecimal, 'GERAL');
  Configurar('DTAATU', 'Data da ultima Atualização', '', tpData, 'GERAL');
  Configurar('VERSAO', 'Versão da máquina', '', tpNormal, 'GERAL');


  Configurar('SALPRE', 'Trava para valor de venda SAL_PRE', 'VEN', tpTravaPreco, 'PREÇO');
  Configurar('SALFAT', 'Fator da trava de preço', '1,00', tpNumeroDecimal, 'PREÇO');
  Configurar('FVESAL',  'Fator para preço de custo', '1,00', tpNumeroDecimal, 'PREÇO');

  Configurar('SALIEM', 'Item embalagem para Litro', '', tpBotao, 'EMBALAGEM');
  Configurar('SALIGL', 'Item embalagem para Galão', '', tpBotao, 'EMBALAGEM');
  Configurar('SALICO', 'Item embalagem para Copo', '', tpBotao, 'EMBALAGEM');
  Configurar('SALISP', 'Item embalagem para Spray', '', tpBotao, 'EMBALAGEM');
  Configurar('SALIBA', 'Item embalagem para Balde', '', tpBotao, 'EMBALAGEM');

  Configurar('VOLIEM', 'Volume Máximo Embalagem para Litro', '0,900', tpVolumeEmb, 'EMBALAGEM');
  Configurar('VOLIGL', 'Volume Máximo Embalagem para Galão', '3,600', tpVolumeEmb, 'EMBALAGEM');
  Configurar('VOLICO', 'Volume Máximo Embalagem para Copo', '0,450', tpVolumeEmb, 'EMBALAGEM');
  Configurar('VOLISP', 'Volume Máximo Embalagem para Spray', '0,400', tpVolumeEmb, 'EMBALAGEM');
  Configurar('VOLIBA', 'Volume Máximo Embalagem para Balde', '18,000', tpVolumeEmb, 'EMBALAGEM');

  Configurar('USUSQS', 'Usuário', '', tpNormal, 'INTEGRAÇÃO SALCOMIX');
  Configurar('SENSQS', 'Senha', '', tpSenha, 'INTEGRAÇÃO SALCOMIX');
  Configurar('DATSQS', 'Banco', '', tpNormal, 'INTEGRAÇÃO SALCOMIX');
  Configurar('HOSSQS', 'IP / Host', '', tpNormal, 'INTEGRAÇÃO SALCOMIX');


end;

function TConfiguradorSalcomix.DiretorioValidar(strDir: String): string;
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

function TConfiguradorSalcomix.fConsultaProdutoEmbalagem(const strValCfg: String): String;
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

    If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere], arrTitCol, ['ITE_DESITE'], 'AUTOINCREM',
                                             'CADITE', 'unTConfiguradorSalcomix', 'Consulta Item - Salcomix', qryCadIte, [], []) Then
    Begin
      Result := qryCadIte.FieldByName('ITE_CODITE').AsString;
    End;

  Finally
  End;
end;

function TConfiguradorSalcomix.fConsultaProdutoVenda(
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

    If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere], arrTitCol, ['ITE_DESITE'], 'AUTOINCREM',
                                             'CADITE', 'unTConfiguradorSalcomix', 'Consulta Item - Salcomix', qryCadIte, [], []) Then
    Begin
      Result := qryCadIte.FieldByName('ITE_CODITE').AsString;
    End;

  Finally
  End;
end;

procedure TConfiguradorSalcomix.NumeroValidar(var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean; const strNomCam: String);
begin
  Error := False;
end;

end.
