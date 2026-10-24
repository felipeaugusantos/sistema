{**************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta Alv *}
{***********************************************************************************AC*}
unit untTintadeMaquinaWrapperAlv;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperAlv = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompAlv,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperAlv }

procedure TTintadeMaquinaWrapperAlv.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  //Configurador Alv
  Configurador.pAdicionarCampo('ALV_CODIGO', 'Código', 'LIKE');
  Configurador.pAdicionarCampo('ALV_DESCOR', 'Descrição Cor',  'LIKE');
  Configurador.pAdicionarCampo('ALV_CODBAS', 'Código Base',  'LIKE');
  Configurador.pAdicionarCampo('ALV_PRODUT', 'Produto', 'LIKE');
  Configurador.pAdicionarCampo('ALV_SISTEM', 'Sistema', 'LIKE');
  Configurador.pAdicionarCampo('ALV_UNIDAD', 'Unidade', 'LIKE');
  Configurador.pAdicionarCampo('ALV_VOLUME', 'Volume', 'LIKE');
  Configurador.pAdicionarCampo('CADITE.ITE_DESITE', 'Descrição do Item', 'LIKE');
  Configurador.pAdicionarCampo('CADITE.ITE_CODITE', 'Código do Item', 'LIKE', False, True);
  Configurador.pAdicionarCampo('ALV_MD5KEY', 'Chave MD5', '=', False, True);
  Configurador.pAdicionarCampo('ALV_ACRMOB', 'Acrescimo Mão Obra', '=', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');

  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('ALV_FORM' + TStrUtils.fStrZero(intCont, 2), 'ALV_FORM' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('ALV_QTDC' + TStrUtils.fStrZero(intCont, 2), 'ALV_QTDC' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperAlv.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  Result := Result + ' AND UPPER(IFNULL(ALV_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperAlv.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result := '';
  Result := Result + '  ALV_CADALV ';
  Result := Result + '   INNER JOIN ALV_CADBAS ';
  Result := Result + '     ON ALV_CODBAS = BAS_CODBAS ';
  Result := Result + '       AND ALV_PRODUT = BAS_PRODUT ';
  Result := Result + '       AND ALV_UNIDAD = BAS_UNIDAD ';
  Result := Result + '       AND ALV_VOLUME = BAS_EMBALA ';
  Result := Result + '  	  INNER JOIN CADITE ON CADITE.ITE_CODITE = BAS_CODITE     ';
  Result := Result + '     AND CADITE.ITE_ITEATI = "S"          ';
  Result := Result + '      INNER JOIN ITEGER ON         ';
  Result := Result + '       BAS_CODITE = ITEGER.ITE_CODITE AND    ';
  Result := Result + '       ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
end;

function TTintadeMaquinaWrapperAlv.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(ALV_ATIVAD,"S")) = "S" ';
end;

function TTintadeMaquinaWrapperAlv.GetCampoAutoIncrem: String;
begin
  Result := 'ALV_CADALV.AUTOINCREM';
end;

function TTintadeMaquinaWrapperAlv.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompAlv.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperAlv.GetNomeTabela: String;
begin
  Result := 'ALV_CADALV';
end;

procedure TTintadeMaquinaWrapperAlv.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin

  Configurador.fSetPos('ALV_CODIGO', 0);
  Configurador.fSetPos('ALV_UNIDAD', 1);
  Configurador.fSetPos('ALV_DESCOR', 2);
  Configurador.fSetPos('ALV_SISTEM', 3);
  Configurador.fSetPos('CADITE.ITE_DESITE', 4);
  Configurador.fSetPos('ALV_CODBAS', 5);
  Configurador.fSetPos('ALV_PRODUT', 6);
  Configurador.fSetPos('CADITE.ITE_CODITE', 7);

  Configurador.fSetVisivel('ALV_CODIGO' , True);
  Configurador.fSetVisivel('ALV_UNIDAD' , True);
  Configurador.fSetVisivel('ALV_DESCOR' , True);
  Configurador.fSetVisivel('ALV_SISTEM' , True);
  Configurador.fSetVisivel('CADITE.ITE_DESITE' , True);
  Configurador.fSetVisivel('ALV_CODBAS' , True);
  Configurador.fSetVisivel('ALV_PRODUT' , True);
  Configurador.fSetVisivel('CADITE.ITE_CODITE' , True);



  configurador.pAdicionarIndice('ALV_DESCOR+ALV_UNIDAD' , 'Descrição Cor\Unidade');
  configurador.pAdicionarIndice('ALV_CODIGO'  , 'Código');
  Configurador.pAdicionarIndice('ALV_PRODUT'  , 'Produto');
  Configurador.pAdicionarIndice('CADITE.ITE_DESITE'  , 'Descrição do Item');


  configurador.pAdicionarCampoDescricao('ALV_UNIDAD');
end;

end.
