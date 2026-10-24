{**************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta AlvAutomotiva *}
{***********************************************************************************AC*}
unit untTintadeMaquinaWrapperAlvAutomotiva;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperAlvAutomotiva = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompAlvAutomotiva,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperAlvAutomotiva }

procedure TTintadeMaquinaWrapperAlvAutomotiva.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  Configurador.pAdicionarCampo('ALA_CODIGO', 'Código da Fórmula', 'LIKE');
  Configurador.pAdicionarCampo('ALA_DESCRI', 'Descrição', 'LIKE');
  Configurador.pAdicionarCampo('ALA_SYSTEM', 'Sistema', 'LIKE');
  Configurador.pAdicionarCampo('ALA_TECNOL', 'Tecnologia', 'LIKE');
  Configurador.pAdicionarCampo('ALA_TONALI', 'Tonalidade', 'LIKE');
  Configurador.pAdicionarCampo('ALA_ANOCOR', 'Ano da Cor', 'LIKE');
  Configurador.pAdicionarCampo('ALA_MD5KEY', 'Chave Md5', '=', False, True);
  configurador.pAdicionarCampo('ALA_PROCHA', 'Produto Chapinha', 'LIKE', False, False);
  Configurador.pAdicionarCampo('ALA_ACRMOB', 'Acrésc. Mão de Obra', 'LIKE', False, False);


  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('ALA_CODB' + TStrUtils.fStrZero(intCont, 2), 'ALA_CODB' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('ALA_QTDB' + TStrUtils.fStrZero(intCont, 2), 'ALA_QTDB' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperAlvAutomotiva.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  If TAutcomTintaFactory.Get.fGetConfTinta('ALA').fGetBoolean('USAFOR') Then
    Result := Result + '     AND ALA_QTDB01 > 0.0 ';

  Result := Result + ' AND UPPER(IFNULL(ALA_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperAlvAutomotiva.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result := '';
  Result := Result + '  ALA_CADALA ';
end;

function TTintadeMaquinaWrapperAlvAutomotiva.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(ALA_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperAlvAutomotiva.GetCampoAutoIncrem: String;
begin
  Result := 'ALA_CADALA.AUTOINCREM';
end;

function TTintadeMaquinaWrapperAlvAutomotiva.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompAlvAutomotiva.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')), //TAutcomTintaFactory.Get.fCfgSis('TABPAD', varString)
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperAlvAutomotiva.GetNomeTabela: String;
begin
  Result := 'ALA_CADALA';
end;

procedure TTintadeMaquinaWrapperAlvAutomotiva.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  Configurador.fSetPos('ALA_CODIGO', 1);
  Configurador.fSetPos('ALA_DESCRI', 2);

  Configurador.fSetVisivel('ALA_CODIGO', True);
  Configurador.fSetVisivel('ALA_DESCRI', True);

  Configurador.pAdicionarIndice('ALA_CODIGO', 'Código da Fórmula');
  Configurador.pAdicionarIndice('ALA_DESCRI', 'Descrição');

  Configurador.pAdicionarCampoDescricao('ALA_CODIGO');
  Configurador.pAdicionarCampoDescricao('ALA_DESCRI');
end;

end.
