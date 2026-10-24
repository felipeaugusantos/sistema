{**************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta RennerPerformance *}
{***********************************************************************************AC*}
unit untTintadeMaquinaWrapperRennerPerformance;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperRennerPerformance = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompRennerPerformance,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperRennerPerformance }

procedure TTintadeMaquinaWrapperRennerPerformance.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin

  Configurador.pAdicionarCampo('REP_CODBAS', 'Base', 'LIKE');
  Configurador.pAdicionarCampo('REP_CODIGO', 'Código da Fórmula', 'LIKE');
  Configurador.pAdicionarCampo('REP_NOMCOR', 'Nome da Cor', 'LIKE');
  Configurador.pAdicionarCampo('REP_PADRAO', 'Padrão da Cor', 'LIKE');
  Configurador.pAdicionarCampo('REP_ACRMOB', 'Acrésc. Mão de Obra', 'LIKE', False, False);
  Configurador.pAdicionarCampo('REP_MD5KEY', 'Chave Md5', '=', False, True);
  Configurador.pAdicionarCampo('REP_QTDBAS', 'Quantidade Base', 'LIKE', False, False);

  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('REP_FORM' + TStrUtils.fStrZero(intCont, 2), 'REP_FORM' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('REP_QTDC' + TStrUtils.fStrZero(intCont, 2), 'REP_QTDC' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperRennerPerformance.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  If TAutcomTintaFactory.Get.fGetConfTinta('REP').fGetBoolean('USAFOR') Then
    Result := Result + '     AND REP_QTDC01 > 0.0 ';

  Result := Result + ' AND UPPER(IFNULL(REP_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperRennerPerformance.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result := '';
  Result := Result + '  REP_CADREP ';
end;

function TTintadeMaquinaWrapperRennerPerformance.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(REP_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperRennerPerformance.GetCampoAutoIncrem: String;
begin
  Result := 'REP_CADREP.AUTOINCREM';
end;

function TTintadeMaquinaWrapperRennerPerformance.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompRennerPerformance.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')), //TAutcomTintaFactory.Get.fCfgSis('TABPAD', varString)
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperRennerPerformance.GetNomeTabela: String;
begin
  Result := 'REP_CADREP';
end;

procedure TTintadeMaquinaWrapperRennerPerformance.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin

  Configurador.fSetPos('REP_CODBAS', 1);
  Configurador.fSetPos('REP_CODIGO', 2);
  Configurador.fSetPos('REP_NOMCOR', 3);
  Configurador.fSetPos('REP_PADRAO', 4);

  Configurador.fSetVisivel('REP_CODBAS', True);
  Configurador.fSetVisivel('REP_CODIGO', True);
  Configurador.fSetVisivel('REP_NOMCOR', True);
  Configurador.fSetVisivel('REP_PADRAO', True);

  Configurador.pAdicionarIndice('REP_CODIGO+REP_NOMCOR+REP_CODBAS', 'Código da Fórmula/Nome da Cor/Base');
  Configurador.pAdicionarIndice('REP_CODBAS', 'Base');

  Configurador.pAdicionarCampoDescricao('REP_CODBAS');
  Configurador.pAdicionarCampoDescricao('REP_CODIGO');
  Configurador.pAdicionarCampoDescricao('REP_NOMCOR');
  Configurador.pAdicionarCampoDescricao('REP_PADRAO');
end;

end.
