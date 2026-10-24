{*****************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta Universo Imobiliaria *}
{**************************************************************************************PH*}
unit untTintadeMaquinaWrapperUniverso;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperUniverso = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompUniverso,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperUniverso }

procedure TTintadeMaquinaWrapperUniverso.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  Configurador.pAdicionarCampo('UNI_GRUPO_', 'Grupo',     'LIKE', False, True);
  Configurador.pAdicionarCampo('UNI_PRODUT', 'Produto',   'LIKE', False, True);
  Configurador.pAdicionarCampo('UNI_CODNFM', 'Código',    'LIKE', False, True);
  Configurador.pAdicionarCampo('UNI_DESCOR', 'Descrição', 'LIKE', False, True);
  Configurador.pAdicionarCampo('UNI_CODBAS', 'Base',      'LIKE', False, True);
  Configurador.pAdicionarCampo('UNI_CODUNI', 'Unidade',   'LIKE', False, True);
  configurador.pAdicionarCampo('UNI_MD5KEY', 'MD5KEY','=', False, True);
  Configurador.pAdicionarCampo('UNI_ACRMOB', 'UNI_ACRMOB', 'LIKE', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');


  For intCont := 1 To 6 Do
  Begin
    configurador.pAdicionarCampo('UNI_CODC' + TstrUtils.fStrZero(intCont, 2), 'UNI_CODC' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('UNI_QTDC' + TstrUtils.fStrZero(intCont, 2), 'UNI_QTDC' + TstrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperUniverso.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

end;

function TTintadeMaquinaWrapperUniverso.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result :=
     '  	UNI_CADUNI  ' +
     '     	INNER JOIN UNI_CADBAS ON UNI_PRODUT = BAS_PRODUT ' +
     '  		                     AND UNI_CODBAS = BAS_CODBAS ' +
     '                           AND UNI_CODUNI = BAS_UNIDAD ' +
     '  	  INNER JOIN CADITE ON CADITE.ITE_CODITE = BAS_CODITE   ' +
     '     AND CADITE.ITE_ITEATI = "S"                       ' +
     '      INNER JOIN ITEGER ON BAS_CODITE = ITEGER.ITE_CODITE AND  ' +
     '      ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
end;

function TTintadeMaquinaWrapperUniverso.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
end;

function TTintadeMaquinaWrapperUniverso.GetCampoAutoIncrem: String;
begin
  Result := 'UNI_CADUNI.AUTOINCREM';
end;

function TTintadeMaquinaWrapperUniverso.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompUniverso.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperUniverso.GetNomeTabela: String;
begin
  Result := 'UNI_CADUNI';
end;

procedure TTintadeMaquinaWrapperUniverso.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  Configurador.fSetPos('UNI_GRUPO_', 0);
  Configurador.fSetPos('UNI_PRODUT', 1);
  Configurador.fSetPos('UNI_CODNFM', 2);
  Configurador.fSetPos('UNI_DESCOR', 3);
  Configurador.fSetPos('UNI_CODBAS', 4);
  Configurador.fSetPos('UNI_CODUNI', 5);

  Configurador.fSetVisivel('UNI_GRUPO_', True);
  Configurador.fSetVisivel('UNI_PRODUT', True);
  Configurador.fSetVisivel('UNI_CODNFM', True);
  Configurador.fSetVisivel('UNI_DESCOR', True);
  Configurador.fSetVisivel('UNI_CODBAS', True);
  Configurador.fSetVisivel('UNI_CODUNI', True);

  //indices
  Configurador.pAdicionarIndice('UNI_CODNFM+UNI_PRODUT+UNI_DESCOR', 'Código/Produto/Descrição');

  configurador.pAdicionarCampoDescricao('UNI_GRUPO_');
  configurador.pAdicionarCampoDescricao('UNI_PRODUT');
  configurador.pAdicionarCampoDescricao('UNI_CODNFM');
  configurador.pAdicionarCampoDescricao('UNI_DESCOR');
  configurador.pAdicionarCampoDescricao('UNI_CODBAS');
  configurador.pAdicionarCampoDescricao('UNI_CODUNI');

end;

end.
