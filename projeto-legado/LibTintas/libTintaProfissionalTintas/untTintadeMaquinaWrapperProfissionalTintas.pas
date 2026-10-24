{**************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta ProfissionalTintas *}
{***********************************************************************************AC*}
unit untTintadeMaquinaWrapperProfissionalTintas;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils, untIDataSet;

type
  TTintadeMaquinaWrapperProfissionalTintas = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompProfissionalTintas,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperProfissionalTintas }

procedure TTintadeMaquinaWrapperProfissionalTintas.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  //Configurador ProfissionalTintas
  Configurador.pAdicionarCampo('PRT_CODIGO', 'Código', 'LIKE');
  Configurador.pAdicionarCampo('PRT_CODBAS', 'Código Base',  'LIKE');
  Configurador.pAdicionarCampo('PRT_PRODUT', 'Produto', 'LIKE');
  Configurador.pAdicionarCampo('PRT_LINHA_', 'Linha', 'LIKE');
  Configurador.pAdicionarCampo('PRT_UNIDAD', 'Unidade', 'LIKE');
  Configurador.pAdicionarCampo('PRT_NOMCOR', 'Nome Cor', 'LIKE');
  Configurador.pAdicionarCampo('PRT_DTACAD', 'Data Cadastro', 'LIKE');
  Configurador.pAdicionarCampo('CADITE.ITE_DESITE', 'Descrição do Item', 'LIKE');
  Configurador.pAdicionarCampo('CADITE.ITE_CODITE', 'Código do Item', 'LIKE', False, True);
  Configurador.pAdicionarCampo('PRT_MD5KEY', 'Chave MD5', '=', False, True);
  Configurador.pAdicionarCampo('PRT_ACRMOB', 'Acrescimo Mao Obra', '=', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');

  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('PRT_FORM' + TStrUtils.fStrZero(intCont, 2), 'PRT_FORM' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('PRT_QTDC' + TStrUtils.fStrZero(intCont, 2), 'PRT_QTDC' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperProfissionalTintas.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  Result := Result + ' AND UPPER(IFNULL(PRT_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperProfissionalTintas.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result := '';
  Result := Result + '  PRT_CADPRT ';
  Result := Result + '   INNER JOIN PRT_CADBAS ';
  Result := Result + '     ON PRT_CODBAS = BAS_CODBAS ';
  Result := Result + '       AND PRT_PRODUT = BAS_PRODUT ';
  Result := Result + '       AND PRT_UNIDAD = BAS_UNIDAD ';
  Result := Result + '  	  INNER JOIN CADITE ON CADITE.ITE_CODITE = BAS_CODITE     ';
  Result := Result + '     AND CADITE.ITE_ITEATI = "S"          ';
  Result := Result + '      INNER JOIN ITEGER ON         ';
  Result := Result + '       BAS_CODITE = ITEGER.ITE_CODITE AND    ';
  Result := Result + '       ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
end;

function TTintadeMaquinaWrapperProfissionalTintas.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(PRT_ATIVAD,"S")) = "S" ';
end;

function TTintadeMaquinaWrapperProfissionalTintas.GetCampoAutoIncrem: String;
begin
  Result := 'PRT_CADPRT.AUTOINCREM';
end;

function TTintadeMaquinaWrapperProfissionalTintas.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompProfissionalTintas.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperProfissionalTintas.GetNomeForm: String;
begin
  Result := 'ProfissionalTintas';
end;

function TTintadeMaquinaWrapperProfissionalTintas.GetNomeTabela: String;
begin
  Result := 'PRT_CADPRT';
end;

function TTintadeMaquinaWrapperProfissionalTintas.GetNomeTinta: String;
begin
  Result := 'ProfissionalTintas';
end;

procedure TTintadeMaquinaWrapperProfissionalTintas.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  Configurador.fSetPos('PRT_CODIGO', 0);
  Configurador.fSetPos('PRT_UNIDAD', 1);
  Configurador.fSetPos('PRT_DESCRI', 2);
  Configurador.fSetPos('PRT_LINHA_', 3);
  Configurador.fSetPos('CADITE.ITE_DESITE', 4);
  Configurador.fSetPos('PRT_CODBAS', 5);
  Configurador.fSetPos('PRT_PRODUT', 6);
  Configurador.fSetPos('CADITE.ITE_CODITE', 7);

  Configurador.fSetVisivel('PRT_CODIGO' , True);
  Configurador.fSetVisivel('PRT_UNIDAD' , True);
  Configurador.fSetVisivel('PRT_DESCRI' , True);
  Configurador.fSetVisivel('PRT_LINHA_' , True);
  Configurador.fSetVisivel('CADITE.ITE_DESITE' , True);
  Configurador.fSetVisivel('PRT_CODBAS' , True);
  Configurador.fSetVisivel('PRT_PRODUT' , True);
  Configurador.fSetVisivel('CADITE.ITE_CODITE' , True);

  configurador.pAdicionarIndice('PRT_DESCRI+PRT_UNIDAD' , 'Descrição Cor\Unidade');
  configurador.pAdicionarIndice('PRT_CODIGO'  , 'Código');
  Configurador.pAdicionarIndice('PRT_PRODUT'  , 'Produto');
  Configurador.pAdicionarIndice('CADITE.ITE_DESITE'  , 'Descrição do Item');

  configurador.pAdicionarCampoDescricao('PRT_UNIDAD');
end;

end.



