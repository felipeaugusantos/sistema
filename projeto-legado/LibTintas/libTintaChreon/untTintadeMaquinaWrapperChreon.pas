{**************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta Chreon *}
{***********************************************************************************AC*}
unit untTintadeMaquinaWrapperChreon;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperChreon = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompChreon,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperChreon }

procedure TTintadeMaquinaWrapperChreon.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  //Configurador Chreon
  Configurador.pAdicionarCampo('CHR_CODIGO', 'Código', 'LIKE');
  Configurador.pAdicionarCampo('CHR_DESCRI', 'Descrição Cor',  'LIKE');
  Configurador.pAdicionarCampo('CHR_CODBAS', 'Código Base',  'LIKE');
  Configurador.pAdicionarCampo('CHR_PRODUT', 'Produto', 'LIKE');
  Configurador.pAdicionarCampo('CHR_COLECA', 'Coleção', 'LIKE');
  Configurador.pAdicionarCampo('CHR_UNIDAD', 'Unidade', 'LIKE');
  Configurador.pAdicionarCampo('CHR_PALETA', 'Paleta', 'LIKE');
  Configurador.pAdicionarCampo('CHR_NOMCOR', 'Nome Cor', 'LIKE');
  Configurador.pAdicionarCampo('CHR_DTACAD', 'Data Cadastro', 'LIKE');
  Configurador.pAdicionarCampo('CADITE.ITE_DESITE', 'Descrição do Item', 'LIKE');
  Configurador.pAdicionarCampo('CADITE.ITE_CODITE', 'Código do Item', 'LIKE', False, True);
  Configurador.pAdicionarCampo('CHR_MD5KEY', 'Chave MD5', '=', False, True);
  Configurador.pAdicionarCampo('CHR_ACRMOB', 'Acrescimo Mao Obra', '=', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');

  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('CHR_FORM' + TStrUtils.fStrZero(intCont, 2), 'CHR_FORM' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('CHR_QTDC' + TStrUtils.fStrZero(intCont, 2), 'CHR_QTDC' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperChreon.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  Result := Result + ' AND UPPER(IFNULL(CHR_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperChreon.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result := '';
  Result := Result + '  CHR_CADCHR ';
  Result := Result + '   INNER JOIN CHR_CADBAS ';
  Result := Result + '     ON CHR_CODBAS = BAS_CODBAS ';
  Result := Result + '       AND CHR_PRODUT = BAS_PRODUT ';
  Result := Result + '       AND CHR_UNIDAD = BAS_UNIDAD ';
  Result := Result + '  	  INNER JOIN CADITE ON CADITE.ITE_CODITE = BAS_CODITE     ';
  Result := Result + '     AND CADITE.ITE_ITEATI = "S"          ';
  Result := Result + '      INNER JOIN ITEGER ON         ';
  Result := Result + '       BAS_CODITE = ITEGER.ITE_CODITE AND    ';
  Result := Result + '       ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
end;

function TTintadeMaquinaWrapperChreon.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(CHR_ATIVAD,"S")) = "S" ';
end;

function TTintadeMaquinaWrapperChreon.GetCampoAutoIncrem: String;
begin
  Result := 'CHR_CADCHR.AUTOINCREM';
end;

function TTintadeMaquinaWrapperChreon.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompChreon.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperChreon.GetNomeForm: String;
begin
  Result := 'Chreon';
end;

function TTintadeMaquinaWrapperChreon.GetNomeTabela: String;
begin
  Result := 'CHR_CADCHR';
end;

function TTintadeMaquinaWrapperChreon.GetNomeTinta: String;
begin
  Result := 'Chreon';
end;

procedure TTintadeMaquinaWrapperChreon.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  Configurador.fSetPos('CHR_CODIGO', 0);
  Configurador.fSetPos('CHR_UNIDAD', 1);
  Configurador.fSetPos('CHR_DESCRI', 2);
  Configurador.fSetPos('CHR_COLECA', 3);
  Configurador.fSetPos('CADITE.ITE_DESITE', 4);
  Configurador.fSetPos('CHR_CODBAS', 5);
  Configurador.fSetPos('CHR_PRODUT', 6);
  Configurador.fSetPos('CADITE.ITE_CODITE', 7);

  Configurador.fSetVisivel('CHR_CODIGO' , True);
  Configurador.fSetVisivel('CHR_UNIDAD' , True);
  Configurador.fSetVisivel('CHR_DESCRI' , True);
  Configurador.fSetVisivel('CHR_COLECA' , True);
  Configurador.fSetVisivel('CADITE.ITE_DESITE' , True);
  Configurador.fSetVisivel('CHR_CODBAS' , True);
  Configurador.fSetVisivel('CHR_PRODUT' , True);
  Configurador.fSetVisivel('CADITE.ITE_CODITE' , True);

  configurador.pAdicionarIndice('CHR_DESCRI+CHR_UNIDAD' , 'Descrição Cor\Unidade');
  configurador.pAdicionarIndice('CHR_CODIGO'  , 'Código');
  Configurador.pAdicionarIndice('CHR_PRODUT'  , 'Produto');
  Configurador.pAdicionarIndice('CADITE.ITE_DESITE'  , 'Descrição do Item');

  configurador.pAdicionarCampoDescricao('CHR_UNIDAD');
end;

end.



