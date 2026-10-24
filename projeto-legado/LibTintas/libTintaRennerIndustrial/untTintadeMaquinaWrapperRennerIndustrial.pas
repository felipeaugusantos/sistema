{**************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta RennerIndustrial *}
{***********************************************************************************AC*}
unit untTintadeMaquinaWrapperRennerIndustrial;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperRennerIndustrial = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompRennerIndustrial,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperRennerIndustrial }

procedure TTintadeMaquinaWrapperRennerIndustrial.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  //Configurador RennerIndustrial
  Configurador.pAdicionarCampo('BAS_DESCRI', 'Descrição da Base', 'LIKE');
  Configurador.pAdicionarCampo('REN_UNIDAD', 'Unidade', 'LIKE');
  Configurador.pAdicionarCampo('REN_CODIGO', 'Código', 'LIKE');
  Configurador.pAdicionarCampo('CADITE.ITE_CODITE', 'Cód. Item', 'LIKE');
  Configurador.pAdicionarCampo('CADITE.ITE_DESITE', 'Descrição do Item', 'LIKE');
  Configurador.pAdicionarCampo('REN_IDENTI', 'Identificador', 'LIKE', False, True);
  Configurador.pAdicionarCampo('REN_CODEMB', 'Embalagem', 'LIKE', False, True);
  Configurador.pAdicionarCampo('REN_MD5KEY', 'Chave MD5', '=', False, True);
  Configurador.pAdicionarCampo('REN_DESCRI', 'Descrição da Tinta', 'LIKE', False, True);
  Configurador.pAdicionarCampo('REN_CODBAS', 'Base', 'LIKE', False, False);
  Configurador.pAdicionarCampo('REN_ACRMOB', 'REN_ACRMOB', 'LIKE', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');
  //End;

  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('REN_FORM' + TStrUtils.fStrZero(intCont, 2), 'REN_FORM' + TStrUtils.fStrZero(intCont, 2),
      'RENE', False, False);

    configurador.pAdicionarCampo('REN_QTDC' + TStrUtils.fStrZero(intCont, 2), 'REN_QTDC' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperRennerIndustrial.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  Result := Result + ' AND UPPER(IFNULL(REN_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperRennerIndustrial.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result := '';
  Result := Result + '  REN_CADREN ';
  Result := Result + '   INNER JOIN REN_CADBAS ';
  Result := Result + '     ON REN_CODBAS = BAS_BASE__ ';
  Result := Result + '       AND REN_UNIDAD = BAS_UNIDAD ';
  Result := Result + '  	  INNER JOIN CADITE ON CADITE.ITE_CODITE = BAS_CODITE     ';
  Result := Result + '     AND CADITE.ITE_ITEATI = "S"          ';
  Result := Result + '      INNER JOIN ITEGER ON         ';
  Result := Result + '       BAS_CODITE = ITEGER.ITE_CODITE AND    ';
  Result := Result + '       ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
end;

function TTintadeMaquinaWrapperRennerIndustrial.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(REN_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperRennerIndustrial.GetCampoAutoIncrem: String;
begin
  Result := 'REN_CADREN.AUTOINCREM';
end;

function TTintadeMaquinaWrapperRennerIndustrial.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompRennerIndustrial.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')), //TAutcomTintaFactory.Get.fCfgSis('TABPAD', varString)
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperRennerIndustrial.GetNomeTabela: String;
begin
  Result := 'REN_CADREN';
end;

procedure TTintadeMaquinaWrapperRennerIndustrial.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin

  Configurador.fSetPos('BAS_DESCRI', 0);
  Configurador.fSetPos('REN_UNIDAD', 1);
  Configurador.fSetPos('REN_CODIGO', 2);
  Configurador.fSetPos('CADITE.ITE_CODITE', 3);
  Configurador.fSetPos('CADITE.ITE_DESITE', 4);
  Configurador.fSetPos('REN_IDENTI', 5);
  Configurador.fSetPos('REN_CODEMB', 6);
  Configurador.fSetPos('REN_DESCRI', 7);

  Configurador.fSetVisivel('BAS_DESCRI', True);
  Configurador.fSetVisivel('REN_UNIDAD', True);
  Configurador.fSetVisivel('REN_CODIGO', True);
  Configurador.fSetVisivel('CADITE.ITE_CODITE', True);
  Configurador.fSetVisivel('CADITE.ITE_DESITE', True);
  Configurador.fSetVisivel('REN_IDENTI', False);
  Configurador.fSetVisivel('REN_CODEMB', False);
  Configurador.fSetVisivel('REN_DESCRI', False);

  //Indices Configuração(Consultas)
  Configurador.pAdicionarIndice('BAS_DESCRI+REN_UNIDAD', 'Descrição da Base/Unidade');
  Configurador.pAdicionarIndice('REN_UNIDAD', 'Unidade');
  Configurador.pAdicionarIndice('REN_CODIGO', 'Código');
  Configurador.pAdicionarIndice('CADITE.ITE_CODITE', 'Código do Item');
  Configurador.pAdicionarIndice('CADITE.ITE_DESITE', 'Descrição do Item');

  //End;

  Configurador.pAdicionarCampoDescricao('REN_UNIDAD');
end;

end.
