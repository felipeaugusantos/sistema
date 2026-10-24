{**************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta GlobalBsn *}
{***********************************************************************************AC*}
unit untTintadeMaquinaWrapperGlobalBsn;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperGlobalBsn = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompGlobalBsn,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperGlobalBsn }

procedure TTintadeMaquinaWrapperGlobalBsn.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  //Configurador GlobalBsn
  Configurador.pAdicionarCampo('BSN_CODIGO', 'Código', 'LIKE');
  Configurador.pAdicionarCampo('BSN_DESCOR', 'Descrição Cor',  'LIKE');
  Configurador.pAdicionarCampo('BSN_CODBAS', 'Código Base',  'LIKE');
  Configurador.pAdicionarCampo('BSN_PRODUT', 'Produto', 'LIKE');
  Configurador.pAdicionarCampo('BSN_COLECA', 'Coleção', 'LIKE');
  Configurador.pAdicionarCampo('BSN_UNIDAD', 'Unidade', 'LIKE');
  Configurador.pAdicionarCampo('CADITE.ITE_DESITE', 'Descrição do Item', 'LIKE');
  Configurador.pAdicionarCampo('CADITE.ITE_CODITE', 'Código do Item', 'LIKE', False, True);
  Configurador.pAdicionarCampo('BSN_MD5KEY', 'Chave MD5', '=', False, True);
  Configurador.pAdicionarCampo('BSN_ACRMOB', 'Chave MD5', '=', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');

  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('BSN_FORM' + TStrUtils.fStrZero(intCont, 2), 'BSN_FORM' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('BSN_QTDC' + TStrUtils.fStrZero(intCont, 2), 'BSN_QTDC' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperGlobalBsn.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  Result := Result + ' AND UPPER(IFNULL(BSN_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperGlobalBsn.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result := '';
  Result := Result + '  BSN_CADBSN ';
  Result := Result + '   INNER JOIN BSN_CADBAS ';
  Result := Result + '     ON BSN_CODBAS = BAS_CODBAS ';
  Result := Result + '       AND BSN_PRODUT = BAS_PRODUT ';
  Result := Result + '       AND BSN_UNIDAD = BAS_UNIDAD ';
  Result := Result + '  	  INNER JOIN CADITE ON CADITE.ITE_CODITE = BAS_CODITE     ';
  Result := Result + '     AND CADITE.ITE_ITEATI = "S"          ';
  Result := Result + '      INNER JOIN ITEGER ON         ';
  Result := Result + '      BAS_CODITE = ITEGER.ITE_CODITE AND    ';
  Result := Result + '      ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
end;

function TTintadeMaquinaWrapperGlobalBsn.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(BSN_ATIVAD,"S")) = "S" ';
end;

function TTintadeMaquinaWrapperGlobalBsn.GetCampoAutoIncrem: String;
begin
  Result := 'BSN_CADBSN.AUTOINCREM';
end;

function TTintadeMaquinaWrapperGlobalBsn.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompGlobalBsn.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperGlobalBsn.GetNomeTabela: String;
begin
  Result := 'BSN_CADBSN';
end;

procedure TTintadeMaquinaWrapperGlobalBsn.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin

  Configurador.fSetPos('BSN_CODIGO', 0);
  Configurador.fSetPos('BSN_UNIDAD', 1);
  Configurador.fSetPos('BSN_DESCOR', 2);
  Configurador.fSetPos('BSN_COLECA', 3);
  Configurador.fSetPos('CADITE.ITE_DESITE', 4);
  Configurador.fSetPos('BSN_CODBAS', 5);
  Configurador.fSetPos('BSN_PRODUT', 6);
  Configurador.fSetPos('CADITE.ITE_CODITE', 7);

  Configurador.fSetVisivel('BSN_CODIGO' , True);
  Configurador.fSetVisivel('BSN_UNIDAD' , True);
  Configurador.fSetVisivel('BSN_DESCOR' , True);
  Configurador.fSetVisivel('BSN_COLECA' , True);
  Configurador.fSetVisivel('CADITE.ITE_DESITE' , True);
  Configurador.fSetVisivel('BSN_CODBAS' , False);
  Configurador.fSetVisivel('BSN_PRODUT' , False);
  Configurador.fSetVisivel('CADITE.ITE_CODITE' , False);



  configurador.pAdicionarIndice('BSN_DESCOR+BSN_UNIDAD' , 'Descrição Cor\Unidade');
  configurador.pAdicionarIndice('BSN_UNIDAD'  , 'Unidade');
  configurador.pAdicionarIndice('BSN_CODIGO'  , 'Código');
  Configurador.pAdicionarIndice('BSN_PRODUT'  , 'Produto');
  Configurador.pAdicionarIndice('CADITE.ITE_DESITE'  , 'Descrição do Item');


  configurador.pAdicionarCampoDescricao('BSN_UNIDAD');
end;

end.
