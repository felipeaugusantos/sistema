{*****************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta Jotun *}
{**************************************************************************PH*}
unit untTintadeMaquinaWrapperJotun;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperJotun = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompJotun,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperJotun }

procedure TTintadeMaquinaWrapperJotun.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  configurador.pAdicionarCampo('S.JOT_DESCRI', 'Descrição', 'LIKE');
  configurador.pAdicionarCampo('S.JOT_CODUNI', 'Unidade', 'LIKE');
  configurador.pAdicionarCampo('S.JOT_BASE__', 'Código da Base', 'LIKE');
  Configurador.pAdicionarCampo('S.JOT_CODNFM', 'Código Nova Fórmula', 'LIKE');
  configurador.pAdicionarCampo('S.JOT_NOMCOR', 'Cor', 'LIKE');
  configurador.pAdicionarCampo('S.JOT_REFERE', 'Referência', 'LIKE');
  configurador.pAdicionarCampo('S.JOT_TIPO__', 'Tipo', 'LIKE');
  configurador.pAdicionarCampo('S.JOT_EMBALA', 'Embalagem', 'LIKE');
  configurador.pAdicionarCampo('I.ITE_CODITE', 'Código do Item', 'LIKE');
  configurador.pAdicionarCampo('I.ITE_DESITE', 'Descrição do Item', 'LIKE');
  configurador.pAdicionarCampo('S.JOT_DTACAD', 'Data Cadastro', 'LIKE');

  configurador.pAdicionarCampo('S.JOT_CODUNI', 'JOT_CODUNI', 'LIKE', False, False);
  configurador.pAdicionarCampo('S.JOT_MD5KEY', 'JOT_MD5KEY', 'LIKE', False, True);
  configurador.pAdicionarCampo('S.JOT_DESCRI', 'JOT_DESCRI', 'LIKE', False, False);
  configurador.pAdicionarCampo('S.JOT_ACRMOB', 'JOT_ACRMOB', 'LIKE', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');


  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('JOT_FORM' + TStrUtils.fStrZero(intCont, 2), 'JOT_FORM' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('JOT_QTDB' + TStrUtils.fStrZero(intCont, 2), 'JOT_QTDB' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperJotun.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  If TAutcomTintaFactory.Get.fGetConfTinta('JOT').fGetBoolean('USAFOR') Then
    Result := Result + '     AND S.JOT_QTDB01 > 0.0 ';

  Result := Result + ' AND UPPER(IFNULL(S.JOT_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperJotun.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result :=
    '   JOT_CADJOT S                      ' +
    '   INNER JOIN JOT_CADBAS B           ' +
    '      ON S.JOT_BASE__ = B.BAS_CODBAS ' +
    '     AND S.JOT_CODUNI = B.BAS_CODUNI ' +
    '     AND S.JOT_EMBALA = B.BAS_EMBALA '+
    '     AND S.JOT_TIPO__ = B.BAS_TIPO__ '+
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

function TTintadeMaquinaWrapperJotun.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(S.JOT_ATIVAD, "S")) = "S" ';
end;

function TTintadeMaquinaWrapperJotun.GetCampoAutoIncrem: String;
begin
  Result := 'S.AUTOINCREM';
end;

function TTintadeMaquinaWrapperJotun.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompJotun.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')), //TAutcomTintaFactory.Get.fCfgSis('TABPAD', varString)
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperJotun.GetNomeTabela: String;
begin
  Result := 'JOT_CADJOT';
end;

procedure TTintadeMaquinaWrapperJotun.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  configurador.fSetPos('S.JOT_CODUNI', 0);
  configurador.fSetPos('I.ITE_DESITE', 1);
  configurador.fSetPos('JOT_DTACAD', 2);

  configurador.fSetVisivel('S.JOT_CODUNI', True);
  configurador.fSetVisivel('I.ITE_DESITE', True);
  configurador.fSetVisivel('JOT_DTACAD', True);


  configurador.pAdicionarIndice('S.JOT_DESCRI', 'Descrição');
  configurador.pAdicionarIndice('S.JOT_NOMCOR', 'Nome da Cor');
  configurador.pAdicionarIndice('S.JOT_REFERE', 'Referência');
  configurador.pAdicionarIndice('S.JOT_CODUNI', 'Cód.Unidade');
  configurador.pAdicionarIndice('S.JOT_TIPO__', 'Tipo');
  configurador.pAdicionarIndice('S.JOT_EMBALA', 'Embalagem');
  configurador.pAdicionarIndice('I.ITE_DESITE', 'Descrição do Item');
  configurador.pAdicionarIndice('JOT_DTACAD', 'Data Cadastro');


  configurador.pAdicionarCampoDescricao('S.JOT_CODUNI');
  configurador.pAdicionarCampoDescricao('I.ITE_DESITE');
end;

end.
