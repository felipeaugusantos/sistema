{**************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta GlobalCc11 *}
{***********************************************************************************AC*}
unit untTintadeMaquinaWrapperGlobalCc11;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperGlobalCc11 = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompGlobalCc11,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperGlobalCc11 }

procedure TTintadeMaquinaWrapperGlobalCc11.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  //Configurador GlobalCc11
  Configurador.pAdicionarCampo('C11_CODIGO', 'Código', 'LIKE');
  Configurador.pAdicionarCampo('C11_DESCOR', 'Descrição Cor',  'LIKE');
  Configurador.pAdicionarCampo('C11_CODBAS', 'Código Base',  'LIKE');
  Configurador.pAdicionarCampo('C11_PRODUT', 'Produto', 'LIKE');
  Configurador.pAdicionarCampo('C11_COLECA', 'Coleção', 'LIKE');
  Configurador.pAdicionarCampo('C11_UNIDAD', 'Unidade', 'LIKE');
  Configurador.pAdicionarCampo('C11_VOLUME', 'Volume', 'LIKE');
  Configurador.pAdicionarCampo('CADITE.ITE_DESITE', 'Descrição do Item', 'LIKE');
  Configurador.pAdicionarCampo('CADITE.ITE_CODITE', 'Código do Item', 'LIKE', False, True);
  Configurador.pAdicionarCampo('C11_MD5KEY', 'Chave MD5', '=', False, True);
  Configurador.pAdicionarCampo('C11_ACRMOB', 'Chave MD5', '=', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');

  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('C11_FORM' + TStrUtils.fStrZero(intCont, 2), 'C11_FORM' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('C11_QTDC' + TStrUtils.fStrZero(intCont, 2), 'C11_QTDC' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperGlobalCc11.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  Result := Result + ' AND UPPER(IFNULL(C11_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperGlobalCc11.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result := '';
  Result := Result + '  C11_CADC11 ';
  Result := Result + '   INNER JOIN C11_CADBAS ';
  Result := Result + '     ON C11_CODBAS = BAS_CODBAS ';
  Result := Result + '       AND C11_PRODUT = BAS_PRODUT ';
  Result := Result + '       AND C11_UNIDAD = BAS_UNIDAD ';
  Result := Result + '       AND C11_VOLUME = BAS_EMBALA ';
  Result := Result + '  	  INNER JOIN CADITE ON CADITE.ITE_CODITE = BAS_CODITE     ';
  Result := Result + '     AND CADITE.ITE_ITEATI = "S"          ';
  Result := Result + '      INNER JOIN ITEGER ON         ';
  Result := Result + '       BAS_CODITE = ITEGER.ITE_CODITE AND    ';
  Result := Result + '       ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
end;

function TTintadeMaquinaWrapperGlobalCc11.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(C11_ATIVAD,"S")) = "S" ';
end;

function TTintadeMaquinaWrapperGlobalCc11.GetCampoAutoIncrem: String;
begin
  Result := 'C11_CADC11.AUTOINCREM';
end;

function TTintadeMaquinaWrapperGlobalCc11.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompGlobalCc11.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperGlobalCc11.GetNomeTabela: String;
begin
  Result := 'C11_CADC11';
end;

procedure TTintadeMaquinaWrapperGlobalCc11.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin

  Configurador.fSetPos('C11_CODIGO', 0);
  Configurador.fSetPos('C11_UNIDAD', 1);
  Configurador.fSetPos('C11_DESCOR', 2);
  Configurador.fSetPos('C11_COLECA', 3);
  Configurador.fSetPos('CADITE.ITE_DESITE', 4);
  Configurador.fSetPos('C11_CODBAS', 5);
  Configurador.fSetPos('C11_PRODUT', 6);
  Configurador.fSetPos('CADITE.ITE_CODITE', 7);

  Configurador.fSetVisivel('C11_CODIGO' , True);
  Configurador.fSetVisivel('C11_UNIDAD' , True);
  Configurador.fSetVisivel('C11_DESCOR' , True);
  Configurador.fSetVisivel('C11_COLECA' , True);
  Configurador.fSetVisivel('CADITE.ITE_DESITE' , True);
  Configurador.fSetVisivel('C11_CODBAS' , True);
  Configurador.fSetVisivel('C11_PRODUT' , True);
  Configurador.fSetVisivel('CADITE.ITE_CODITE' , True);



  configurador.pAdicionarIndice('C11_DESCOR+C11_UNIDAD' , 'Descrição Cor\Unidade');
  configurador.pAdicionarIndice('C11_CODIGO'  , 'Código');
  Configurador.pAdicionarIndice('C11_PRODUT'  , 'Produto');
  Configurador.pAdicionarIndice('CADITE.ITE_DESITE'  , 'Descrição do Item');


  configurador.pAdicionarCampoDescricao('C11_UNIDAD');
end;

end.
