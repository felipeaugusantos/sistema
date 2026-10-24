{**************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta BlascorAutomotiva *}
{***********************************************************************************AC*}
unit untTintadeMaquinaWrapperBlascorAutomotiva;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperBlascorAutomotiva = class(TAbstractTintadeMaquinaWrapper)
  public
    procedure Configurar(const configurador: IConfiguradorConsulta); override;
    function GetCampoAutoIncrem: String; override;
    function GetNomeTinta: String; Override;
    function GetNomeForm: String; Override;
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
  untConsultaCompBlascorAutomotiva,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperBlascorAutomotiva }

procedure TTintadeMaquinaWrapperBlascorAutomotiva.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  Configurador.pAdicionarCampo('BLA_CODIGO', 'Código', 'LIKE');
  Configurador.pAdicionarCampo('BLA_CODUNI', 'Código Universal', 'LIKE');
  Configurador.pAdicionarCampo('BLA_DESCRI', 'Descrição Cor', 'LIKE');
  Configurador.pAdicionarCampo('BLA_ANOINI', 'Ano Inicial', 'LIKE');
  Configurador.pAdicionarCampo('BLA_ANOFIM', 'Ano Final', 'LIKE');
  Configurador.pAdicionarCampo('LIN_DESCRI', 'Linha', 'LIKE');
  Configurador.pAdicionarCampo('MON_DESCRI', 'Montadora', 'LIKE');
  Configurador.pAdicionarCampo('BLA_MD5KEY', 'Chave Md5', '=', False, True);
  configurador.pAdicionarCampo('BLA_PROCHA', 'Produto Chapinha', 'LIKE', False, False);
  Configurador.pAdicionarCampo('BLA_ACRMOB', 'Acrésc. Mão de Obra', 'LIKE', False, False);


  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('BLA_BASE' + TStrUtils.fStrZero(intCont, 2), 'BLA_BASE' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('BLA_QTDB' + TStrUtils.fStrZero(intCont, 2), 'BLA_QTDB' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperBlascorAutomotiva.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  If TAutcomTintaFactory.Get.fGetConfTinta('BLA').fGetBoolean('USAFOR') Then
    Result := Result + '     AND BLA_QTDB01 > 0.0 ';

  Result := Result + ' AND UPPER(IFNULL(BLA_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperBlascorAutomotiva.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result := '';
  Result := Result + '  BLA_CADBLA ';
  Result := Result + ' 	LEFT JOIN BLA_CADMON  ';
  Result := Result + ' 	ON (BLA_CODMON = MON_CODMON) ';
  Result := Result + ' 	LEFT JOIN BLA_CADLIN ';
  Result := Result + ' 	ON (BLA_CODLIN = LIN_CODLIN) ';
end;

function TTintadeMaquinaWrapperBlascorAutomotiva.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(BLA_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperBlascorAutomotiva.GetCampoAutoIncrem: String;
begin
  Result := 'BLA_CADBLA.AUTOINCREM';
end;

function TTintadeMaquinaWrapperBlascorAutomotiva.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompBlascorAutomotiva.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')), //TAutcomTintaFactory.Get.fCfgSis('TABPAD', varString)
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperBlascorAutomotiva.GetNomeForm: String;
begin
  Result := 'BlascorAutomotiva';
end;

function TTintadeMaquinaWrapperBlascorAutomotiva.GetNomeTabela: String;
begin
  Result := 'BLA_CADBLA';
end;

function TTintadeMaquinaWrapperBlascorAutomotiva.GetNomeTinta: String;
begin
  Result := 'Blascor Automotiva';
end;

procedure TTintadeMaquinaWrapperBlascorAutomotiva.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  Configurador.fSetPos('BLA_CODIGO', 1);
  Configurador.fSetPos('BLA_DESCRI', 2);

  Configurador.fSetVisivel('BLA_CODIGO', True);
  Configurador.fSetVisivel('BLA_DESCRI', True);

  Configurador.pAdicionarIndice('BLA_CODIGO', 'Código da Fórmula');
  Configurador.pAdicionarIndice('BLA_DESCRI', 'Descrição');

  Configurador.pAdicionarCampoDescricao('BLA_CODIGO');
  Configurador.pAdicionarCampoDescricao('BLA_DESCRI');
end;

end.
