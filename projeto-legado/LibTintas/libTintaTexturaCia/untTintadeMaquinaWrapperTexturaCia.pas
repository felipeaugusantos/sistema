{**************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta TexturaCia *}
{***********************************************************************************AC*}
unit untTintadeMaquinaWrapperTexturaCia;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperTexturaCia = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompTexturaCia,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperTexturaCia }

procedure TTintadeMaquinaWrapperTexturaCia.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  //Configurador TexturaCia
  Configurador.pAdicionarCampo('TEX_CODIGO', 'Código', 'LIKE');
  Configurador.pAdicionarCampo('TEX_DESCRI', 'Descrição Cor',  'LIKE');
  Configurador.pAdicionarCampo('TEX_CODBAS', 'Código Base',  'LIKE');
  Configurador.pAdicionarCampo('TEX_PRODUT', 'Produto', 'LIKE');
  Configurador.pAdicionarCampo('TEX_CATALO', 'Catálogo', 'LIKE');
  Configurador.pAdicionarCampo('TEX_UNIDAD', 'Unidade', 'LIKE');
  Configurador.pAdicionarCampo('TEX_INTENS', 'Intensidade', 'LIKE');
  Configurador.pAdicionarCampo('TEX_CODCOR', 'Nome da Cor', 'LIKE');
  Configurador.pAdicionarCampo('TEX_EMBALA', 'Embalagem', 'LIKE');
  Configurador.pAdicionarCampo('TEX_DESEMB', 'Descrição Embalagem', 'LIKE');
  Configurador.pAdicionarCampo('TEX_REFCOR', 'Referência da Cor', 'LIKE');
  Configurador.pAdicionarCampo('CADITE.ITE_DESITE', 'Descrição do Item', 'LIKE');
  Configurador.pAdicionarCampo('CADITE.ITE_CODITE', 'Código do Item', 'LIKE', False, True);
  Configurador.pAdicionarCampo('TEX_MD5KEY', 'Chave MD5', '=', False, True);
  Configurador.pAdicionarCampo('TEX_ACRMOB', 'Acrescimo Mao Obra', '=', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');

  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('TEX_FORM' + TStrUtils.fStrZero(intCont, 2), 'TEX_FORM' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('TEX_QTDC' + TStrUtils.fStrZero(intCont, 2), 'TEX_QTDC' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperTexturaCia.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  Result := Result + ' AND UPPER(IFNULL(TEX_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperTexturaCia.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result := '';
  Result := Result + '  TEX_CADTEX ';
  Result := Result + '   INNER JOIN TEX_CADBAS ';
  Result := Result + '     ON TEX_CODBAS = BAS_CODBAS ';
  Result := Result + '       AND TEX_PRODUT = BAS_PRODUT ';
  Result := Result + '       AND TEX_UNIDAD = BAS_UNIDAD ';
  Result := Result + '       AND TEX_EMBALA = BAS_EMBALA ';
  Result := Result + '  	  INNER JOIN CADITE ON CADITE.ITE_CODITE = BAS_CODITE     ';
  Result := Result + '     AND CADITE.ITE_ITEATI = "S"          ';
  Result := Result + '      INNER JOIN ITEGER ON         ';
  Result := Result + '       BAS_CODITE = ITEGER.ITE_CODITE AND    ';
  Result := Result + '       ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
end;

function TTintadeMaquinaWrapperTexturaCia.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(TEX_ATIVAD,"S")) = "S" ';
end;

function TTintadeMaquinaWrapperTexturaCia.GetCampoAutoIncrem: String;
begin
  Result := 'TEX_CADTEX.AUTOINCREM';
end;

function TTintadeMaquinaWrapperTexturaCia.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompTexturaCia.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperTexturaCia.GetNomeForm: String;
begin
  Result := 'TexturaCia';
end;

function TTintadeMaquinaWrapperTexturaCia.GetNomeTabela: String;
begin
  Result := 'TEX_CADTEX';
end;

function TTintadeMaquinaWrapperTexturaCia.GetNomeTinta: String;
begin
  Result := 'TexturaCia';
end;

procedure TTintadeMaquinaWrapperTexturaCia.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  Configurador.fSetPos('TEX_CODIGO', 0);
  Configurador.fSetPos('TEX_UNIDAD', 1);
  Configurador.fSetPos('TEX_DESCRI', 2);
  Configurador.fSetPos('TEX_CATALO', 3);
  Configurador.fSetPos('CADITE.ITE_DESITE', 4);
  Configurador.fSetPos('TEX_CODBAS', 5);
  Configurador.fSetPos('TEX_PRODUT', 6);
  Configurador.fSetPos('CADITE.ITE_CODITE', 7);

  Configurador.fSetVisivel('TEX_CODIGO' , True);
  Configurador.fSetVisivel('TEX_UNIDAD' , True);
  Configurador.fSetVisivel('TEX_DESCRI' , True);
  Configurador.fSetVisivel('TEX_CATALO' , True);
  Configurador.fSetVisivel('CADITE.ITE_DESITE' , True);
  Configurador.fSetVisivel('TEX_CODBAS' , True);
  Configurador.fSetVisivel('TEX_PRODUT' , True);
  Configurador.fSetVisivel('CADITE.ITE_CODITE' , True);

  configurador.pAdicionarIndice('TEX_DESCRI+TEX_UNIDAD' , 'Descrição Cor\Unidade');
  configurador.pAdicionarIndice('TEX_CODIGO'  , 'Código');
  Configurador.pAdicionarIndice('TEX_PRODUT'  , 'Produto');
  Configurador.pAdicionarIndice('CADITE.ITE_DESITE'  , 'Descrição do Item');

  configurador.pAdicionarCampoDescricao('TEX_UNIDAD');
end;

end.



