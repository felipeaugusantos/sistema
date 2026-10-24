{**************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta Luztol *}
{***********************************************************************************AC*}
unit untTintadeMaquinaWrapperLuztol;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils, untIDataSet;

type
  TTintadeMaquinaWrapperLuztol = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompLuztol,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperLuztol }

procedure TTintadeMaquinaWrapperLuztol.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  //Configurador Luztol
  Configurador.pAdicionarCampo('LUZ_CODIGO', 'Código', 'LIKE');
  Configurador.pAdicionarCampo('LUZ_CODBAS', 'Código Base',  'LIKE');
  Configurador.pAdicionarCampo('LUZ_PRODUT', 'Produto', 'LIKE');
  Configurador.pAdicionarCampo('LUZ_COLECA', 'Coleçao', 'LIKE');
  Configurador.pAdicionarCampo('LUZ_UNIDAD', 'Unidade', 'LIKE');
  Configurador.pAdicionarCampo('LUZ_NOMCOR', 'Nome Cor', 'LIKE');
  Configurador.pAdicionarCampo('LUZ_DTACAD', 'Data Cadastro', 'LIKE');
  Configurador.pAdicionarCampo('CADITE.ITE_DESITE', 'Descrição do Item', 'LIKE');
  Configurador.pAdicionarCampo('CADITE.ITE_CODITE', 'Código do Item', 'LIKE', False, True);
  Configurador.pAdicionarCampo('LUZ_MD5KEY', 'Chave MD5', '=', False, True);
  Configurador.pAdicionarCampo('LUZ_ACRMOB', 'Acrescimo Mao Obra', '=', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');

  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('LUZ_FORM' + TStrUtils.fStrZero(intCont, 2), 'LUZ_FORM' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('LUZ_QTDC' + TStrUtils.fStrZero(intCont, 2), 'LUZ_QTDC' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperLuztol.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  Result := Result + ' AND UPPER(IFNULL(LUZ_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperLuztol.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result := '';
  Result := Result + '  LUZ_CADLUZ ';
  Result := Result + '   INNER JOIN LUZ_CADBAS ';
  Result := Result + '     ON LUZ_CODBAS = BAS_CODBAS ';
  Result := Result + '       AND LUZ_PRODUT = BAS_PRODUT ';
  Result := Result + '       AND LUZ_UNIDAD = BAS_UNIDAD ';
  Result := Result + '  	  INNER JOIN CADITE ON CADITE.ITE_CODITE = BAS_CODITE     ';
  Result := Result + '     AND CADITE.ITE_ITEATI = "S"          ';
  Result := Result + '      INNER JOIN ITEGER ON         ';
  Result := Result + '       BAS_CODITE = ITEGER.ITE_CODITE AND    ';
  Result := Result + '       ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
end;

function TTintadeMaquinaWrapperLuztol.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(LUZ_ATIVAD,"S")) = "S" ';
end;

function TTintadeMaquinaWrapperLuztol.GetCampoAutoIncrem: String;
begin
  Result := 'LUZ_CADLUZ.AUTOINCREM';
end;

function TTintadeMaquinaWrapperLuztol.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompLuztol.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperLuztol.GetNomeForm: String;
begin
  Result := 'Luztol';
end;

function TTintadeMaquinaWrapperLuztol.GetNomeTabela: String;
begin
  Result := 'LUZ_CADLUZ';
end;

function TTintadeMaquinaWrapperLuztol.GetNomeTinta: String;
begin
  Result := 'Luztol';
end;

procedure TTintadeMaquinaWrapperLuztol.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  Configurador.fSetPos('LUZ_CODIGO', 0);
  Configurador.fSetPos('LUZ_UNIDAD', 1);
  Configurador.fSetPos('LUZ_DESCRI', 2);
  Configurador.fSetPos('LUZ_COLECA', 3);
  Configurador.fSetPos('CADITE.ITE_DESITE', 4);
  Configurador.fSetPos('LUZ_CODBAS', 5);
  Configurador.fSetPos('LUZ_PRODUT', 6);
  Configurador.fSetPos('CADITE.ITE_CODITE', 7);

  Configurador.fSetVisivel('LUZ_CODIGO' , True);
  Configurador.fSetVisivel('LUZ_UNIDAD' , True);
  Configurador.fSetVisivel('LUZ_DESCRI' , True);
  Configurador.fSetVisivel('LUZ_COLECA' , True);
  Configurador.fSetVisivel('CADITE.ITE_DESITE' , True);
  Configurador.fSetVisivel('LUZ_CODBAS' , True);
  Configurador.fSetVisivel('LUZ_PRODUT' , True);
  Configurador.fSetVisivel('CADITE.ITE_CODITE' , True);

  configurador.pAdicionarIndice('LUZ_DESCRI+LUZ_UNIDAD' , 'Descrição Cor\Unidade');
  configurador.pAdicionarIndice('LUZ_CODIGO'  , 'Código');
  Configurador.pAdicionarIndice('LUZ_PRODUT'  , 'Produto');
  Configurador.pAdicionarIndice('CADITE.ITE_DESITE'  , 'Descrição do Item');

  configurador.pAdicionarCampoDescricao('LUZ_UNIDAD');
end;

end.



