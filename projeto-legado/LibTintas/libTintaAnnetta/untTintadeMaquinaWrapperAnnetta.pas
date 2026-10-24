{**************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta Annetta *}
{***********************************************************************************AC*}
unit untTintadeMaquinaWrapperAnnetta;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperAnnetta = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompAnnetta,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperAnnetta }

procedure TTintadeMaquinaWrapperAnnetta.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  //Configurador Annetta
  Configurador.pAdicionarCampo('CADITE.ITE_DESITE', 'Descrição do Item' , 'LIKE');
  Configurador.pAdicionarCampo('ANN_CODIGO', 'Código', 'LIKE', False, True);
  Configurador.pAdicionarCampo('ANN_UNIDAD', 'Unidade', 'LIKE', False, True);
  Configurador.pAdicionarCampo('ANN_CODBAS', 'Base', 'LIKE', False, True);
  Configurador.pAdicionarCampo('ANN_CODEMB', 'Embalagem', 'LIKE', False, True);
  Configurador.pAdicionarCampo('ANN_PRODUT', 'Produto', 'LIKE', False, True);
  Configurador.pAdicionarCampo('CADITE.ITE_CODITE', 'Cód. Item', 'LIKE', False, True);
  Configurador.pAdicionarCampo('ANN_DESCRI', 'Descrição', 'LIKE', False, True);
  Configurador.pAdicionarCampo('ANN_COLECA', 'Coleção', 'LIKE');
  Configurador.pAdicionarCampo('ANN_MD5KEY', 'MD5KEY', '=' , False, True);
  Configurador.pAdicionarCampo('ANN_ACRMOB', 'ANN_ACRMOB', 'LIKE', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');
  //End;

  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('ANN_FORM' + TStrUtils.fStrZero(intCont, 2), 'ANN_FORM' + TStrUtils.fStrZero(intCont, 2),
      'ANNE', False, False);

    configurador.pAdicionarCampo('ANN_QTDC' + TStrUtils.fStrZero(intCont, 2), 'ANN_QTDC' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperAnnetta.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  Result := Result + ' AND UPPER(IFNULL(ANN_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperAnnetta.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result := '';
  Result := Result + '  ANN_CADANN ';
  Result := Result + '   INNER JOIN ANN_CADBAS ';
  Result := Result + '     ON ANN_CODBAS = BAS_BASE__ ';
  Result := Result + '       AND ANN_PRODUT = BAS_DESCRI ';
  Result := Result + '       AND ANN_UNIDAD = BAS_UNIDAD ';
  Result := Result + '  	  INNER JOIN CADITE ON CADITE.ITE_CODITE = BAS_CODITE     ';
  Result := Result + '     AND CADITE.ITE_ITEATI = "S"          ';
  Result := Result + '      INNER JOIN ITEGER ON         ';
  Result := Result + '       BAS_CODITE = ITEGER.ITE_CODITE AND    ';
  Result := Result + '       ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
end;

function TTintadeMaquinaWrapperAnnetta.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(ANN_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperAnnetta.GetCampoAutoIncrem: String;
begin
  Result := 'ANN_CADANN.AUTOINCREM';
end;

function TTintadeMaquinaWrapperAnnetta.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompAnnetta.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')), //TAutcomTintaFactory.Get.fCfgSis('TABPAD', varString)
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperAnnetta.GetNomeTabela: String;
begin
  Result := 'ANN_CADANN';
end;

procedure TTintadeMaquinaWrapperAnnetta.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin

  Configurador.fSetPos('CADITE.ITE_DESITE', 1);
  Configurador.fSetPos('ANN_CODIGO', 2);
  Configurador.fSetPos('ANN_UNIDAD', 3);
  Configurador.fSetPos('ANN_CODBAS', 4);
  Configurador.fSetPos('ANN_CODEMB', 5);
  Configurador.fSetPos('ANN_PRODUT', 6);
  Configurador.fSetPos('CADITE.ITE_CODITE', 7);
  Configurador.fSetPos('ANN_DESCRI', 8);

  Configurador.fSetVisivel('CADITE.ITE_DESITE', True);
  Configurador.fSetVisivel('ANN_CODIGO', False);
  Configurador.fSetVisivel('ANN_UNIDAD', False);
  Configurador.fSetVisivel('ANN_CODBAS', False);
  Configurador.fSetVisivel('ANN_CODEMB', False);
  Configurador.fSetVisivel('ANN_PRODUT', False);
  Configurador.fSetVisivel('CADITE.ITE_CODITE', False);
  Configurador.fSetVisivel('ANN_DESCRI', False);

  //Indices Configuração(Consultas)
  Configurador.pAdicionarIndice('ANN_CODIGO', 'Código');

  //End;
  Configurador.pAdicionarCampoDescricao('ANN_DESCRI');
  Configurador.pAdicionarCampoDescricao('ANN_UNIDAD');
  Configurador.pAdicionarCampoDescricao('ANN_CODIGO');
end;

end.
