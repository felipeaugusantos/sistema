{**************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta Sinteplast *}
{***********************************************************************************AC*}
unit untTintadeMaquinaWrapperSinteplast;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils, untIDataSet;

type
  TTintadeMaquinaWrapperSinteplast = class(TAbstractTintadeMaquinaWrapper)
  public
    procedure Configurar(const configurador: IConfiguradorConsulta); override;
    function GetCampoAutoIncrem: String; override;
    function fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String; override;
    procedure pRestaurarPadrao(const configurador: IConfiguradorConsulta); override;
    function fGetSelectFrom(const configurador: IConfiguradorConsulta): String; override;
    function GetNomeTinta: String; override;
    function GetNomeForm: String; override;
    function GetNomeTabela: String; override;
    function GetConsultaComp(strTabPre: String): IConsultaComp; override;
    function fGetWhere: String; override;
  end;

implementation

uses
{$IFNDEF LINUX}
  untConsultaCompSinteplast,
{$ENDIF}
   untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperSinteplast }

procedure TTintadeMaquinaWrapperSinteplast.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  //Configurador Sinteplast
  Configurador.pAdicionarCampo('SIN_CODIGO', 'Código', 'LIKE');
  Configurador.pAdicionarCampo('SIN_DESCRI', 'Descrição Cor',  'LIKE');
  Configurador.pAdicionarCampo('SIN_CODBAS', 'Código Base',  'LIKE');
  Configurador.pAdicionarCampo('SIN_NOMCOR', 'Nome Cor',  'LIKE');
  Configurador.pAdicionarCampo('SIN_PRODUT', 'Produto', 'LIKE');
  Configurador.pAdicionarCampo('SIN_UNIDAD', 'Unidade', 'LIKE');
  Configurador.pAdicionarCampo('SIN_DTACAD', 'Data Cadastro', 'LIKE');
  Configurador.pAdicionarCampo('CADITE.ITE_DESITE', 'Descrição do Item', 'LIKE');
  Configurador.pAdicionarCampo('CADITE.ITE_CODITE', 'Código do Item', 'LIKE', False, True);
  Configurador.pAdicionarCampo('SIN_MD5KEY', 'Chave MD5', '=', False, True);
  Configurador.pAdicionarCampo('SIN_ACRMOB', 'Acrescimo Mao Obra', '=', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');

  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('SIN_FORM' + TStrUtils.fStrZero(intCont, 2), 'SIN_FORM' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('SIN_QTDC' + TStrUtils.fStrZero(intCont, 2), 'SIN_QTDC' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperSinteplast.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  Result := Result + ' AND UPPER(IFNULL(SIN_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperSinteplast.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result := '';
  Result := Result + '  SIN_CADSIN ';
  Result := Result + '   INNER JOIN SIN_CADBAS ';
  Result := Result + '     ON SIN_CODBAS = BAS_CODBAS ';
  Result := Result + '       AND SIN_PRODUT = BAS_PRODUT ';
  Result := Result + '       AND SIN_UNIDAD = BAS_UNIDAD ';
  Result := Result + '  	  INNER JOIN CADITE ON CADITE.ITE_CODITE = BAS_CODITE     ';
  Result := Result + '     AND CADITE.ITE_ITEATI = "S"          ';
  Result := Result + '      INNER JOIN ITEGER ON         ';
  Result := Result + '       BAS_CODITE = ITEGER.ITE_CODITE AND    ';
  Result := Result + '       ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
end;

function TTintadeMaquinaWrapperSinteplast.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(SIN_ATIVAD,"S")) = "S" ';
end;

function TTintadeMaquinaWrapperSinteplast.GetCampoAutoIncrem: String;
begin
  Result := 'SIN_CADSIN.AUTOINCREM';
end;

function TTintadeMaquinaWrapperSinteplast.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompSinteplast.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperSinteplast.GetNomeForm: String;
begin
  Result := 'Sinteplast';
end;

function TTintadeMaquinaWrapperSinteplast.GetNomeTabela: String;
begin
  Result := 'SIN_CADSIN';
end;

function TTintadeMaquinaWrapperSinteplast.GetNomeTinta: String;
begin
  Result := 'Sinteplast';
end;

procedure TTintadeMaquinaWrapperSinteplast.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  Configurador.fSetPos('SIN_CODIGO', 0);
  Configurador.fSetPos('SIN_UNIDAD', 1);
  Configurador.fSetPos('SIN_DESCRI', 2);
  Configurador.fSetPos('SIN_COLECA', 3);
  Configurador.fSetPos('CADITE.ITE_DESITE', 4);
  Configurador.fSetPos('SIN_CODBAS', 5);
  Configurador.fSetPos('SIN_PRODUT', 6);
  Configurador.fSetPos('CADITE.ITE_CODITE', 7);

  Configurador.fSetVisivel('SIN_CODIGO' , True);
  Configurador.fSetVisivel('SIN_UNIDAD' , True);
  Configurador.fSetVisivel('SIN_DESCRI' , True);
  Configurador.fSetVisivel('SIN_COLECA' , True);
  Configurador.fSetVisivel('CADITE.ITE_DESITE' , True);
  Configurador.fSetVisivel('SIN_CODBAS' , True);
  Configurador.fSetVisivel('SIN_PRODUT' , True);
  Configurador.fSetVisivel('CADITE.ITE_CODITE' , True);

  configurador.pAdicionarIndice('SIN_DESCRI+SIN_UNIDAD' , 'Descrição Cor\Unidade');
  configurador.pAdicionarIndice('SIN_CODIGO'  , 'Código');
  Configurador.pAdicionarIndice('SIN_PRODUT'  , 'Produto');
  Configurador.pAdicionarIndice('CADITE.ITE_DESITE'  , 'Descrição do Item');

  configurador.pAdicionarCampoDescricao('SIN_UNIDAD');
end;

end.



