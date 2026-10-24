{**************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta GlobalCsn *}
{***********************************************************************************AC*}
unit untTintadeMaquinaWrapperGlobalCsn;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperGlobalCsn = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompGlobalCsn,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperGlobalCsn }

procedure TTintadeMaquinaWrapperGlobalCsn.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  //Configurador GlobalCsn
  Configurador.pAdicionarCampo('CSN_CODIGO', 'Código', 'LIKE');
  Configurador.pAdicionarCampo('CSN_DESCOR', 'Descrição Cor',  'LIKE');
  Configurador.pAdicionarCampo('CSN_CODBAS', 'Código Base',  'LIKE');
  Configurador.pAdicionarCampo('CSN_PRODUT', 'Produto', 'LIKE');
  Configurador.pAdicionarCampo('CSN_COLECA', 'Coleção', 'LIKE');
  Configurador.pAdicionarCampo('CSN_UNIDAD', 'Unidade', 'LIKE');
  Configurador.pAdicionarCampo('CSN_EMBALA', 'Embalagem', 'LIKE');
  Configurador.pAdicionarCampo('CADITE.ITE_DESITE', 'Descrição do Item', 'LIKE');
  Configurador.pAdicionarCampo('CADITE.ITE_CODITE', 'Código do Item', 'LIKE', False, True);
  Configurador.pAdicionarCampo('CSN_MD5KEY', 'Chave MD5', '=', False, True);
  Configurador.pAdicionarCampo('CSN_ACRMOB', 'Chave MD5', '=', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');

  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('CSN_FORM' + TStrUtils.fStrZero(intCont, 2), 'CSN_FORM' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('CSN_QTDC' + TStrUtils.fStrZero(intCont, 2), 'CSN_QTDC' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperGlobalCsn.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  Result := Result + ' AND UPPER(IFNULL(CSN_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperGlobalCsn.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result := '';
  Result := Result + '  CSN_CADCSN ';
  Result := Result + '   INNER JOIN CSN_CADBAS ';
  Result := Result + '     ON CSN_CODBAS = BAS_CODBAS ';
  Result := Result + '       AND CSN_PRODUT = BAS_PRODUT ';
  Result := Result + '       AND CSN_UNIDAD = BAS_UNIDAD ';
  Result := Result + '       AND CSN_EMBALA = BAS_EMBALA ';
  Result := Result + '  	  INNER JOIN CADITE ON CADITE.ITE_CODITE = BAS_CODITE     ';
  Result := Result + '     AND CADITE.ITE_ITEATI = "S"          ';
  Result := Result + '      INNER JOIN ITEGER ON         ';
  Result := Result + '       BAS_CODITE = ITEGER.ITE_CODITE AND    ';
  Result := Result + '       ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
end;

function TTintadeMaquinaWrapperGlobalCsn.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(CSN_ATIVAD,"S")) = "S" ';
end;

function TTintadeMaquinaWrapperGlobalCsn.GetCampoAutoIncrem: String;
begin
  Result := 'CSN_CADCSN.AUTOINCREM';
end;

function TTintadeMaquinaWrapperGlobalCsn.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompGlobalCsn.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperGlobalCsn.GetNomeTabela: String;
begin
  Result := 'CSN_CADCSN';
end;

procedure TTintadeMaquinaWrapperGlobalCsn.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin

  Configurador.fSetPos('CSN_CODIGO', 0);
  Configurador.fSetPos('CSN_UNIDAD', 1);
  Configurador.fSetPos('CSN_DESCOR', 2);
  Configurador.fSetPos('CSN_COLECA', 3);
  Configurador.fSetPos('CADITE.ITE_DESITE', 4);
  Configurador.fSetPos('CSN_CODBAS', 5);
  Configurador.fSetPos('CSN_PRODUT', 6);
  Configurador.fSetPos('CADITE.ITE_CODITE', 7);

  Configurador.fSetVisivel('CSN_CODIGO' , True);
  Configurador.fSetVisivel('CSN_UNIDAD' , True);
  Configurador.fSetVisivel('CSN_DESCOR' , True);
  Configurador.fSetVisivel('CSN_COLECA' , True);
  Configurador.fSetVisivel('CADITE.ITE_DESITE' , True);
  Configurador.fSetVisivel('CSN_CODBAS' , True);
  Configurador.fSetVisivel('CSN_PRODUT' , True);
  Configurador.fSetVisivel('CADITE.ITE_CODITE' , True);



  configurador.pAdicionarIndice('CSN_DESCOR+CSN_UNIDAD' , 'Descrição Cor\Unidade');
  configurador.pAdicionarIndice('CSN_CODIGO'  , 'Código');
  Configurador.pAdicionarIndice('CSN_PRODUT'  , 'Produto');
  Configurador.pAdicionarIndice('CADITE.ITE_DESITE'  , 'Descrição do Item');


  configurador.pAdicionarCampoDescricao('CSN_UNIDAD');
end;

end.
