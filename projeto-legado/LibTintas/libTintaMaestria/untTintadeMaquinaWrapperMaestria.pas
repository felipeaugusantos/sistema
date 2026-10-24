{**************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta Maestria *}
{***********************************************************************************AC*}
unit untTintadeMaquinaWrapperMaestria;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils, untIDataSet;

type
  TTintadeMaquinaWrapperMaestria = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompMaestria,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperMaestria }

procedure TTintadeMaquinaWrapperMaestria.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  //Configurador Maestria
  Configurador.pAdicionarCampo('MAE_CODIGO', 'Código', 'LIKE');
  Configurador.pAdicionarCampo('MAE_DESCRI', 'Descrição Cor',  'LIKE');
  Configurador.pAdicionarCampo('MAE_CODBAS', 'Código Base',  'LIKE');
  Configurador.pAdicionarCampo('MAE_PRODUT', 'Produto', 'LIKE');
  Configurador.pAdicionarCampo('MAE_EMBALA', 'Embalagem', 'LIKE');
  Configurador.pAdicionarCampo('MAE_COLECA', 'Coleção', 'LIKE');
  Configurador.pAdicionarCampo('MAE_UNIDAD', 'Unidade', 'LIKE');
  Configurador.pAdicionarCampo('MAE_NOMCOR', 'Nome Cor', 'LIKE');
  Configurador.pAdicionarCampo('MAE_DTACAD', 'Data Cadastro', 'LIKE');
  Configurador.pAdicionarCampo('CADITE.ITE_DESITE', 'Descrição do Item', 'LIKE');
  Configurador.pAdicionarCampo('CADITE.ITE_CODITE', 'Código do Item', 'LIKE', False, True);
  Configurador.pAdicionarCampo('MAE_MD5KEY', 'Chave MD5', '=', False, True);
  Configurador.pAdicionarCampo('MAE_ACRMOB', 'Acrescimo Mao Obra', '=', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');

  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('MAE_FORM' + TStrUtils.fStrZero(intCont, 2), 'MAE_FORM' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('MAE_QTDC' + TStrUtils.fStrZero(intCont, 2), 'MAE_QTDC' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperMaestria.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  Result := Result + ' AND UPPER(IFNULL(MAE_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperMaestria.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result := '';
  Result := Result + '  MAE_CADMAE ';
  Result := Result + '   INNER JOIN MAE_CADBAS ';
  Result := Result + '     ON MAE_CODBAS = BAS_CODBAS ';
  Result := Result + '       AND MAE_PRODUT = BAS_PRODUT ';
  Result := Result + '       AND MAE_UNIDAD = BAS_UNIDAD ';
  Result := Result + '       AND MAE_EMBALA = BAS_EMBALA ';
  Result := Result + '  	  INNER JOIN CADITE ON CADITE.ITE_CODITE = BAS_CODITE     ';
  Result := Result + '     AND CADITE.ITE_ITEATI = "S"          ';
  Result := Result + '      INNER JOIN ITEGER ON         ';
  Result := Result + '       BAS_CODITE = ITEGER.ITE_CODITE AND    ';
  Result := Result + '       ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
end;

function TTintadeMaquinaWrapperMaestria.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(MAE_ATIVAD,"S")) = "S" ';
end;

function TTintadeMaquinaWrapperMaestria.GetCampoAutoIncrem: String;
begin
  Result := 'MAE_CADMAE.AUTOINCREM';
end;

function TTintadeMaquinaWrapperMaestria.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompMaestria.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperMaestria.GetNomeForm: String;
begin
  Result := 'Maestria';
end;

function TTintadeMaquinaWrapperMaestria.GetNomeTabela: String;
begin
  Result := 'MAE_CADMAE';
end;

function TTintadeMaquinaWrapperMaestria.GetNomeTinta: String;
begin
  Result := 'Maestria';
end;

procedure TTintadeMaquinaWrapperMaestria.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  Configurador.fSetPos('MAE_CODIGO', 0);
  Configurador.fSetPos('MAE_UNIDAD', 1);
  Configurador.fSetPos('MAE_DESCRI', 2);
  Configurador.fSetPos('MAE_COLECA', 3);
  Configurador.fSetPos('CADITE.ITE_DESITE', 4);
  Configurador.fSetPos('MAE_CODBAS', 5);
  Configurador.fSetPos('MAE_PRODUT', 6);
  Configurador.fSetPos('CADITE.ITE_CODITE', 7);

  Configurador.fSetVisivel('MAE_CODIGO' , True);
  Configurador.fSetVisivel('MAE_UNIDAD' , True);
  Configurador.fSetVisivel('MAE_DESCRI' , True);
  Configurador.fSetVisivel('MAE_COLECA' , True);
  Configurador.fSetVisivel('CADITE.ITE_DESITE' , True);
  Configurador.fSetVisivel('MAE_CODBAS' , True);
  Configurador.fSetVisivel('MAE_PRODUT' , True);
  Configurador.fSetVisivel('CADITE.ITE_CODITE' , True);

  configurador.pAdicionarIndice('MAE_DESCRI+MAE_UNIDAD' , 'Descrição Cor\Unidade');
  configurador.pAdicionarIndice('MAE_CODIGO'  , 'Código');
  Configurador.pAdicionarIndice('MAE_PRODUT'  , 'Produto');
  Configurador.pAdicionarIndice('CADITE.ITE_DESITE'  , 'Descrição do Item');

  configurador.pAdicionarCampoDescricao('MAE_UNIDAD');
end;

end.



