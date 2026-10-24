{*****************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta Ciacollor *}
{**************************************************************************PH*}
unit untTintadeMaquinaWrapperCiacollor;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperCiacollor = class(TAbstractTintadeMaquinaWrapper)
  public
    procedure Configurar(const configurador: IConfiguradorConsulta); override;
    function GetCampoAutoIncrem: String; override;
    function fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String; override;
    procedure pRestaurarPadrao(const configurador: IConfiguradorConsulta); override;
    function fGetSelectFrom(const configurador: IConfiguradorConsulta): String; override;
    function GetNomeTabela: String; override;
    function GetConsultaComp(strTabPre: String): IConsultaComp; override;
    function fGetWhere: String; override;
  end;

implementation

uses
{$IFNDEF LINUX}
  untConsultaCompCiacollor,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperCiacollor }

procedure TTintadeMaquinaWrapperCiacollor.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  configurador.pAdicionarCampo('S.CIA_DESCRI', 'Descrição', 'LIKE');
  configurador.pAdicionarCampo('S.CIA_DTACAD', 'Data Cadastro', 'LIKE');
  configurador.pAdicionarCampo('S.CIA_UNIDAD', 'Unidade', 'LIKE');
  configurador.pAdicionarCampo('S.CIA_CODBAS', 'Código da Base', 'LIKE');
  configurador.pAdicionarCampo('S.CIA_NOMCOR', 'Cor', 'LIKE');
  configurador.pAdicionarCampo('S.CIA_VOLUME', 'Volume', 'LIKE');
  configurador.pAdicionarCampo('I.ITE_CODITE', 'Código do Item', 'LIKE');
  configurador.pAdicionarCampo('I.ITE_DESITE', 'Descrição do Item', 'LIKE');
  configurador.pAdicionarCampo('S.CIA_PRODUT', 'Produto', 'LIKE');
  configurador.pAdicionarCampo('S.CIA_COLECA', 'Coleção', 'LIKE');
  configurador.pAdicionarCampo('S.CIA_CODUNI', 'CIA_CODUNI', 'LIKE', False, False);
  configurador.pAdicionarCampo('S.CIA_MD5KEY', 'CIA_MD5KEY', 'LIKE', False, True);
  configurador.pAdicionarCampo('S.CIA_DESCRI', 'CIA_DESCRI', 'LIKE', False, False);
  Configurador.pAdicionarCampo('S.CIA_ACRMOB', 'CIA_ACRMOB', 'LIKE', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');


  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('CIA_FORM' + TStrUtils.fStrZero(intCont, 2), 'CIA_FORM' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('CIA_QTDB' + TStrUtils.fStrZero(intCont, 2), 'CIA_QTDB' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperCiacollor.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  If TAutcomTintaFactory.Get.fGetConfTinta('CIA').fGetBoolean('USAFOR') Then
    Result := Result + '     AND S.CIA_QTDB01 > 0.0 ';

  Result := Result + ' AND UPPER(IFNULL(S.CIA_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperCiacollor.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result :=
    '   CIA_CADCIA S                      ' +
    '   INNER JOIN CIA_CADBAS B           ' +
    '      ON S.CIA_CODBAS = B.BAS_CODBAS ' +
    '     AND S.CIA_CODUNI = B.BAS_CODUNI ' +
    '     AND S.CIA_PRODUT = B.BAS_PRODUT ' +
    '     AND S.CIA_VOLUME = B.BAS_VOLUME ' +
    '   INNER JOIN CADITE I               ';

  If TStrUtils.fEmptyStr(configurador.GetCodIte) Then
  Begin
    Result := Result + '     ON B.BAS_CODITE = I.ITE_CODITE ';
    Result := Result + '     AND I.ITE_ITEATI = "S"          ';
    Result := Result + '     INNER JOIN ITEGER ON         ';
    Result := Result + '       B.BAS_CODITE = ITEGER.ITE_CODITE AND    ';
    Result := Result + '       ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
  End
  Else
  Begin
    Result := Result + '     ON ' + AnsiQuotedStr(configurador.GetCodIte, '"') + ' = I.ITE_CODITE ';
    Result := Result + '     AND I.ITE_ITEATI = "S"          ';
    Result := Result + '     INNER JOIN ITEGER ON         ';
    Result := Result + AnsiQuotedStr(configurador.GetCodIte, '"') + ' = ITEGER.ITE_CODITE AND ';
    Result := Result + '       ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
  End;
end;

function TTintadeMaquinaWrapperCiacollor.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(S.CIA_ATIVAD, "S")) = "S" ';
end;

function TTintadeMaquinaWrapperCiacollor.GetCampoAutoIncrem: String;
begin
  Result := 'S.AUTOINCREM';
end;

function TTintadeMaquinaWrapperCiacollor.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompCiacollor.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')), //TAutcomTintaFactory.Get.fCfgSis('TABPAD', varString)
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperCiacollor.GetNomeTabela: String;
begin
  Result := 'CIA_CADCIA';
end;

procedure TTintadeMaquinaWrapperCiacollor.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  configurador.fSetPos('S.CIA_UNIDAD', 0);
  configurador.fSetPos('I.ITE_DESITE', 1);

  configurador.fSetVisivel('S.CIA_UNIDAD', True);
  configurador.fSetVisivel('I.ITE_DESITE', True);


  configurador.pAdicionarIndice('S.CIA_DESCRI', 'Descrição');
  configurador.pAdicionarIndice('S.CIA_DTACAD', 'Data Cadastro');
  configurador.pAdicionarIndice('S.CIA_NOMCOR', 'Nome da Cor');
  configurador.pAdicionarIndice('S.CIA_PRODUT', 'Produto');
  configurador.pAdicionarIndice('S.CIA_VOLUME', 'Volume');
  configurador.pAdicionarIndice('S.CIA_CODUNI', 'Cód.Unidade');
  configurador.pAdicionarIndice('I.ITE_DESITE', 'Descrição do Item');


  configurador.pAdicionarCampoDescricao('S.CIA_UNIDAD');
  configurador.pAdicionarCampoDescricao('I.ITE_DESITE');
end;

end.
