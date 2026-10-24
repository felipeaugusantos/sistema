{**************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta Liko *}
{***********************************************************************************AC*}
unit untTintadeMaquinaWrapperLiko;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperLiko = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompLiko,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperLiko }

procedure TTintadeMaquinaWrapperLiko.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  //Configurador Liko
  configurador.pAdicionarCampo('LIK_DESCRI', 'Descrição', 'LIKE');
  configurador.pAdicionarCampo('LIK_UNIDAD', 'Unidade'  , 'LIKE');
  configurador.pAdicionarCampo('LIK_CODIGO', 'Código'   , 'LIKE');
  configurador.pAdicionarCampo('CADITE.ITE_CODITE', 'Código do Item', 'LIKE');
  configurador.pAdicionarCampo('CADITE.ITE_DESITE', 'Descrição do Item', 'LIKE');
  configurador.pAdicionarCampo('CADITE.ITE_REFERE', 'Referência do Item', 'LIKE');
  configurador.pAdicionarCampo('LIK_CODBAS', 'Base'     , '='  , False,  True);
  configurador.pAdicionarCampo('LIK_CODEMB', 'Embalagem', '='  , False,  True);
  configurador.pAdicionarCampo('LIK_MD5KEY', 'MD5KEY'   , '='  , False,  True);
  Configurador.pAdicionarCampo('LIK_PRODUT', 'Produto'  , 'LIKE');
  Configurador.pAdicionarCampo('LIK_ACABAM', 'Acabamento', 'LIKE');
  Configurador.pAdicionarCampo('LIK_ACRMOB', 'LIK_ACRMOB', 'LIKE', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');
  //End;

  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('LIK_FORM' + TStrUtils.fStrZero(intCont, 2), 'LIK_FORM' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('LIK_QTDC' + TStrUtils.fStrZero(intCont, 2), 'LIK_QTDC' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperLiko.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  Result := Result + ' AND UPPER(IFNULL(LIK_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperLiko.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result := '';
  Result := Result + '  LIK_CADLIK ';
  Result := Result + '   INNER JOIN LIK_CADBAS ';
  Result := Result + '     ON LIK_CODBAS = BAS_BASE__ ';
  Result := Result + '       AND LIK_UNIDAD = BAS_UNIDAD ';
  Result := Result + '  	  INNER JOIN CADITE ON CADITE.ITE_CODITE = BAS_CODITE     ';
  Result := Result + '     AND CADITE.ITE_ITEATI = "S"          ';
  Result := Result + '      INNER JOIN ITEGER ON         ';
  Result := Result + '       BAS_CODITE = ITEGER.ITE_CODITE AND    ';
  Result := Result + '       ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';

end;

function TTintadeMaquinaWrapperLiko.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(LIK_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperLiko.GetCampoAutoIncrem: String;
begin
  Result := 'LIK_CADLIK.AUTOINCREM';
end;

function TTintadeMaquinaWrapperLiko.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompLiko.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')), //TAutcomTintaFactory.Get.fCfgSis('TABPAD', varString)
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperLiko.GetNomeTabela: String;
begin
  Result := 'LIK_CADLIK';
end;

procedure TTintadeMaquinaWrapperLiko.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin

  configurador.fSetPos('LIK_DESCRI', 0);
  configurador.fSetPos('LIK_UNIDAD', 1);
  configurador.fSetPos('LIK_CODIGO', 2);
  configurador.fSetPos('LIK_CODBAS', 3);
  configurador.fSetPos('LIK_CODEMB', 4);

  configurador.fSetVisivel('LIK_DESCRI', True);
  configurador.fSetVisivel('LIK_UNIDAD', True);
  configurador.fSetVisivel('LIK_CODIGO', True);
  configurador.fSetVisivel('LIK_CODBAS', True);
  configurador.fSetVisivel('LIK_CODEMB', True);


  //Indices Configuração(Consultas)
  configurador.pAdicionarIndice('LIK_DESCRI+LIK_UNIDAD', 'Descrição/Unidade');
  configurador.pAdicionarIndice('LIK_UNIDAD', 'Unidade');
  configurador.pAdicionarIndice('LIK_CODIGO', 'Código');
  //End;

  configurador.pAdicionarCampoDescricao('LIK_UNIDAD');
end;

end.
