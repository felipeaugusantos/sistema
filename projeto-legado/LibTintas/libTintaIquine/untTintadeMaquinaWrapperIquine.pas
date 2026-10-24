{**************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta Iquine *}
{***********************************************************************************AC*}
unit untTintadeMaquinaWrapperIquine;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperIquine = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompIquine,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperIquine }

procedure TTintadeMaquinaWrapperIquine.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  Configurador.pAdicionarCampo('IQU_UNIDAD',  'Unidade'  , 'LIKE');
  Configurador.pAdicionarCampo('IQU_CODIGO',  'Código'    , 'LIKE');
  Configurador.pAdicionarCampo('CADITE.ITE_DESITE',  'Descrição do Item' , 'LIKE');
  Configurador.pAdicionarCampo('IQU_DESCRI',  'Descrição' , 'LIKE');
  Configurador.pAdicionarCampo('IQU_CODBAS',  'Base'    , 'LIKE', False, True);
  Configurador.pAdicionarCampo('IQU_CODEMB',  'Embalagem',  'LIKE', False, True);
  Configurador.pAdicionarCampo('IQU_MD5KEY',  'MD5KEY'   ,  '=', False, True);
  Configurador.pAdicionarCampo('CADITE.ITE_CODITE',  'Código do Item', 'LIKE', False, True);
  Configurador.pAdicionarCampo('IQU_PRODUT',  'Produto' ,     'LIKE', False, True);
  Configurador.pAdicionarCampo('CADITE.ITE_REFERE',  'Referência do Item', 'LIKE');
  Configurador.pAdicionarCampo('IQU_CODCOL',  'Coleção', 'LIKE');
  Configurador.pAdicionarCampo('IQU_ACRMOB',  'IQU_ACRMOB', 'LIKE', False, False);
  Configurador.pAdicionarCampo('IQU_EMBALA',  'IQU_EMBALA', 'LIKE', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');


  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('IQU_FORM' + TStrUtils.fStrZero(intCont, 2), 'IQU_FORM' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('IQU_QTDC' + TStrUtils.fStrZero(intCont, 2), 'IQU_QTDC' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperIquine.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  If TAutcomTintaFactory.Get.fGetConfTinta('IQU').fGetBoolean('USAFOR') Then
    Result := Result + '     AND IQU_QTDC01 > 0.0 ';

  Result := Result + ' AND UPPER(IFNULL(IQU_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperIquine.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result := '';
  Result := Result + '  IQU_CADIQU ';
  Result := Result + '   INNER JOIN IQU_CADBAS ';
  Result := Result + '     ON IQU_CODBAS = BAS_BASE__ ';
  Result := Result + '       AND IQU_PRODUT = BAS_PRODUT ';
  Result := Result + '       AND IQU_UNIDAD = BAS_UNIDAD ';
  Result := Result + '       AND IQU_EMBALA = BAS_EMBALA ';
  Result := Result + '  	  INNER JOIN CADITE ON CADITE.ITE_CODITE = BAS_CODITE     ';
  Result := Result + '     AND CADITE.ITE_ITEATI = "S"          ';
  Result := Result + '  INNER JOIN ITEGER ON         ';
  Result := Result + '       BAS_CODITE = ITEGER.ITE_CODITE AND    ';
  Result := Result + '       ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
end;

function TTintadeMaquinaWrapperIquine.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(IQU_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperIquine.GetCampoAutoIncrem: String;
begin
  Result := 'IQU_CADIQU.AUTOINCREM';
end;

function TTintadeMaquinaWrapperIquine.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompIquine.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')), //TAutcomTintaFactory.Get.fCfgSis('TABPAD', varString)
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperIquine.GetNomeTabela: String;
begin
  Result := 'IQU_CADIQU';
end;

procedure TTintadeMaquinaWrapperIquine.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin

  Configurador.fSetPos('IQU_UNIDAD', 0);
  Configurador.fSetPos('IQU_CODIGO', 1);
  Configurador.fSetPos('CADITE.ITE_ITEDES', 2);
  Configurador.fSetPos('IQU_DESCRI', 3);
  Configurador.fSetPos('IQU_CODBAS', 4);
  Configurador.fSetPos('IQU_CODEMB', 5);
  Configurador.fSetPos('CADITE.ITE_CODITE', 6);
  Configurador.fSetPos('IQU_PRODUT', 7);
  Configurador.fSetPos('CADITE.ITE_REFERE', 8);

  Configurador.fSetVisivel('IQU_UNIDAD', True);
  Configurador.fSetVisivel('IQU_CODIGO', True);
  Configurador.fSetVisivel('CADITE.ITE_ITEDES', True);
  Configurador.fSetVisivel('IQU_DESCRI', True);
  Configurador.fSetVisivel('IQU_CODBAS', True);
  Configurador.fSetVisivel('IQU_CODEMB', True);
  Configurador.fSetVisivel('CADITE.ITE_CODITE', False);
  Configurador.fSetVisivel('IQU_PRODUT', True);
  Configurador.fSetVisivel('CADITE.ITE_REFERE', True);


  configurador.pAdicionarIndice('IQU_DESCRI+IQU_UNIDAD', 'Descrição/Unidade');
  Configurador.pAdicionarIndice('CADITE.ITE_REFERE', 'Referência do Item');
  configurador.pAdicionarIndice('IQU_UNIDAD', 'Unidade');
  configurador.pAdicionarIndice('IQU_CODIGO', 'Código');

  configurador.pAdicionarCampoDescricao('IQU_UNIDAD');
  Configurador.pAdicionarCampoDescricao('CADITE.ITE_REFERE');
end;

end.
