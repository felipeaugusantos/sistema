{**************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta BellaCorTintavel *}
{***********************************************************************************AC*}
unit untTintadeMaquinaWrapperBellaCorTintavel;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperBellaCorTintavel = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompBellaCorTintavel,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperBellaCorTintavel }

procedure TTintadeMaquinaWrapperBellaCorTintavel.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  //Configurador BellaCorTintavel
  Configurador.pAdicionarCampo('BLT_CODIGO', 'Código', 'LIKE');
  Configurador.pAdicionarCampo('BLT_DESCOR', 'Descrição Cor',  'LIKE');
  Configurador.pAdicionarCampo('BLT_CODBAS', 'Código Base',  'LIKE');
  Configurador.pAdicionarCampo('BLT_PRODUT', 'Produto', 'LIKE');
  Configurador.pAdicionarCampo('BLT_COLECA', 'Coleção', 'LIKE');
  Configurador.pAdicionarCampo('BLT_UNIDAD', 'Unidade', 'LIKE');
  Configurador.pAdicionarCampo('CADITE.ITE_DESITE', 'Descrição do Item', 'LIKE');
  Configurador.pAdicionarCampo('CADITE.ITE_CODITE', 'Código do Item', 'LIKE', False, True);
  Configurador.pAdicionarCampo('BLT_MD5KEY', 'Chave MD5', '=', False, True);
  Configurador.pAdicionarCampo('BLT_ACRMOB', 'Chave MD5', '=', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');

  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('BLT_FORM' + TStrUtils.fStrZero(intCont, 2), 'BLT_FORM' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('BLT_QTDC' + TStrUtils.fStrZero(intCont, 2), 'BLT_QTDC' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperBellaCorTintavel.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  Result := Result + ' AND UPPER(IFNULL(BLT_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperBellaCorTintavel.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result := '';
  Result := Result + '  BLT_CADBLT ';
  Result := Result + '   INNER JOIN BLT_CADBAS ';
  Result := Result + '     ON BLT_CODBAS = BAS_CODBAS ';
  Result := Result + '       AND BLT_PRODUT = BAS_PRODUT ';
  Result := Result + '       AND BLT_UNIDAD = BAS_UNIDAD ';
  Result := Result + '  	  INNER JOIN CADITE ON CADITE.ITE_CODITE = BAS_CODITE     ';
  Result := Result + '     AND CADITE.ITE_ITEATI = "S"          ';
  Result := Result + '      INNER JOIN ITEGER ON         ';
  Result := Result + '       BAS_CODITE = ITEGER.ITE_CODITE AND    ';
  Result := Result + '       ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
end;

function TTintadeMaquinaWrapperBellaCorTintavel.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(BLT_ATIVAD,"S")) = "S" ';
end;

function TTintadeMaquinaWrapperBellaCorTintavel.GetCampoAutoIncrem: String;
begin
  Result := 'BLT_CADBLT.AUTOINCREM';
end;

function TTintadeMaquinaWrapperBellaCorTintavel.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompBellaCorTintavel.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperBellaCorTintavel.GetNomeTabela: String;
begin
  Result := 'BLT_CADBLT';
end;

procedure TTintadeMaquinaWrapperBellaCorTintavel.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  Configurador.fSetPos('BLT_CODIGO', 0);
  Configurador.fSetPos('BLT_UNIDAD', 1);
  Configurador.fSetPos('BLT_DESCOR', 2);
  Configurador.fSetPos('BLT_COLECA', 3);
  Configurador.fSetPos('CADITE.ITE_DESITE', 4);
  Configurador.fSetPos('BLT_CODBAS', 5);
  Configurador.fSetPos('BLT_PRODUT', 6);
  Configurador.fSetPos('CADITE.ITE_CODITE', 7);

  Configurador.fSetVisivel('BLT_CODIGO' , True);
  Configurador.fSetVisivel('BLT_UNIDAD' , True);
  Configurador.fSetVisivel('BLT_DESCOR' , True);
  Configurador.fSetVisivel('BLT_COLECA' , True);
  Configurador.fSetVisivel('CADITE.ITE_DESITE' , True);
  Configurador.fSetVisivel('BLT_CODBAS' , True);
  Configurador.fSetVisivel('BLT_PRODUT' , True);
  Configurador.fSetVisivel('CADITE.ITE_CODITE' , True);

  configurador.pAdicionarIndice('BLT_DESCOR+BLT_UNIDAD' , 'Descrição Cor\Unidade');
  configurador.pAdicionarIndice('BLT_CODIGO'  , 'Código');
  Configurador.pAdicionarIndice('BLT_PRODUT'  , 'Produto');
  Configurador.pAdicionarIndice('CADITE.ITE_DESITE'  , 'Descrição do Item');

  configurador.pAdicionarCampoDescricao('BLT_UNIDAD');
end;

end.


