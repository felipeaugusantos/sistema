{**************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta GlobalBc *}
{***********************************************************************************AC*}
unit untTintadeMaquinaWrapperGlobalBc;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperGlobalBc = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompGlobalBc,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperGlobalBc }

procedure TTintadeMaquinaWrapperGlobalBc.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  //Configurador GlobalBc
  Configurador.pAdicionarCampo('GBC_CODIGO', 'Código', 'LIKE');
  Configurador.pAdicionarCampo('GBC_DESCOR', 'Descrição Cor',  'LIKE');
  Configurador.pAdicionarCampo('GBC_CODBAS', 'Código Base',  'LIKE');
  Configurador.pAdicionarCampo('GBC_PRODUT', 'Produto', 'LIKE');
  Configurador.pAdicionarCampo('GBC_COLECA', 'Coleção', 'LIKE');
  Configurador.pAdicionarCampo('GBC_UNIDAD', 'Unidade', 'LIKE');
  Configurador.pAdicionarCampo('CADITE.ITE_DESITE', 'Descrição do Item', 'LIKE');
  Configurador.pAdicionarCampo('CADITE.ITE_CODITE', 'Código do Item', 'LIKE', False, True);
  Configurador.pAdicionarCampo('GBC_MD5KEY', 'Chave MD5', '=', False, True);
  Configurador.pAdicionarCampo('GBC_ACRMOB', 'Chave MD5', '=', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');

  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('GBC_FORM' + TStrUtils.fStrZero(intCont, 2), 'GBC_FORM' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('GBC_QTDC' + TStrUtils.fStrZero(intCont, 2), 'GBC_QTDC' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperGlobalBc.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  Result := Result + ' AND UPPER(IFNULL(GBC_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperGlobalBc.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result := '';
  Result := Result + '  GBC_CADGBC ';
  Result := Result + '   INNER JOIN GBC_CADBAS ';
  Result := Result + '     ON GBC_CODBAS = BAS_CODBAS ';
  Result := Result + '       AND GBC_PRODUT = BAS_PRODUT ';
  Result := Result + '       AND GBC_UNIDAD = BAS_UNIDAD ';
  Result := Result + '  	  INNER JOIN CADITE ON CADITE.ITE_CODITE = BAS_CODITE     ';
  Result := Result + '     AND CADITE.ITE_ITEATI = "S"          ';
  Result := Result + '      INNER JOIN ITEGER ON         ';
  Result := Result + '       BAS_CODITE = ITEGER.ITE_CODITE AND    ';
  Result := Result + '       ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
end;

function TTintadeMaquinaWrapperGlobalBc.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(GBC_ATIVAD,"S")) = "S" ';
end;

function TTintadeMaquinaWrapperGlobalBc.GetCampoAutoIncrem: String;
begin
  Result := 'GBC_CADGBC.AUTOINCREM';
end;

function TTintadeMaquinaWrapperGlobalBc.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompGlobalBc.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperGlobalBc.GetNomeTabela: String;
begin
  Result := 'GBC_CADGBC';
end;

procedure TTintadeMaquinaWrapperGlobalBc.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin

  Configurador.fSetPos('GBC_CODIGO', 0);
  Configurador.fSetPos('GBC_UNIDAD', 1);
  Configurador.fSetPos('GBC_DESCOR', 2);
  Configurador.fSetPos('GBC_COLECA', 3);
  Configurador.fSetPos('CADITE.ITE_DESITE', 4);
  Configurador.fSetPos('GBC_CODBAS', 5);
  Configurador.fSetPos('GBC_PRODUT', 6);
  Configurador.fSetPos('CADITE.ITE_CODITE', 7);

  Configurador.fSetVisivel('GBC_CODIGO' , True);
  Configurador.fSetVisivel('GBC_UNIDAD' , True);
  Configurador.fSetVisivel('GBC_DESCOR' , True);
  Configurador.fSetVisivel('GBC_COLECA' , True);
  Configurador.fSetVisivel('CADITE.ITE_DESITE' , True);
  Configurador.fSetVisivel('GBC_CODBAS' , True);
  Configurador.fSetVisivel('GBC_PRODUT' , True);
  Configurador.fSetVisivel('CADITE.ITE_CODITE' , True);



  configurador.pAdicionarIndice('GBC_DESCOR+GBC_UNIDAD' , 'Descrição Cor\Unidade');
  configurador.pAdicionarIndice('GBC_CODIGO'  , 'Código');
  Configurador.pAdicionarIndice('GBC_PRODUT'  , 'Produto');
  Configurador.pAdicionarIndice('CADITE.ITE_DESITE'  , 'Descrição do Item');


  configurador.pAdicionarCampoDescricao('GBC_UNIDAD');
end;

end.
