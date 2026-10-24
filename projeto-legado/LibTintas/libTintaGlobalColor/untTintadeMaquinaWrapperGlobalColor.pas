{**************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta GlobalColor *}
{***********************************************************************************AC*}
unit untTintadeMaquinaWrapperGlobalColor;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperGlobalColor = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompGlobalColor,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperGlobalColor }

procedure TTintadeMaquinaWrapperGlobalColor.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  //Configurador GlobalColor
  Configurador.pAdicionarCampo('GLO_DESCRI', 'Descrição', 'LIKE');
  Configurador.pAdicionarCampo('GLO_UNIDAD', 'Unidade',  'LIKE');
  Configurador.pAdicionarCampo('GLO_CODIGO', 'Código',  'LIKE');
  Configurador.pAdicionarCampo('GLO_PRODUT', 'Produto', 'LIKE');
  Configurador.pAdicionarCampo('CADITE.ITE_DESITE', 'Descrição do Item', 'LIKE');
  Configurador.pAdicionarCampo('GLO_CODEMB', 'Embalagem', 'LIKE', False, True);
  Configurador.pAdicionarCampo('GLO_CODBAS', 'Base', 'LIKE', False, True);
  Configurador.pAdicionarCampo('CADITE.ITE_CODITE', 'Código do Item', 'LIKE', False, True);
  Configurador.pAdicionarCampo('GLO_MD5KEY', 'Chave MD5', '=', False, True);
  Configurador.pAdicionarCampo('GLO_ACRMOB', 'GLO_ACRMOB', 'LIKE', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');


  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('GLO_FORM' + TStrUtils.fStrZero(intCont, 2), 'GLO_FORM' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('GLO_QTDC' + TStrUtils.fStrZero(intCont, 2), 'GLO_QTDC' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperGlobalColor.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  Result := Result + ' AND UPPER(IFNULL(GLO_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperGlobalColor.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result := '';
  Result := Result + '  GLO_CADGLO ';
  Result := Result + '   INNER JOIN GLO_CADBAS ';
  Result := Result + '     ON GLO_CODBAS = BAS_BASE__ ';
  Result := Result + '       AND GLO_PRODUT = BAS_DESCRI ';
  Result := Result + '       AND GLO_UNIDAD = BAS_UNIDAD ';
  Result := Result + '  	  INNER JOIN CADITE ON CADITE.ITE_CODITE = BAS_CODITE     ';
  Result := Result + '     AND CADITE.ITE_ITEATI = "S"          ';
  Result := Result + '      INNER JOIN ITEGER ON         ';
  Result := Result + '       BAS_CODITE = ITEGER.ITE_CODITE AND    ';
  Result := Result + '       ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
end;

function TTintadeMaquinaWrapperGlobalColor.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(GLO_ATIVAD,"S")) = "S" ';
end;

function TTintadeMaquinaWrapperGlobalColor.GetCampoAutoIncrem: String;
begin
  Result := 'GLO_CADGLO.AUTOINCREM';
end;

function TTintadeMaquinaWrapperGlobalColor.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompGlobalColor.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperGlobalColor.GetNomeTabela: String;
begin
  Result := 'GLO_CADGLO';
end;

procedure TTintadeMaquinaWrapperGlobalColor.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin

  Configurador.fSetPos('GLO_DESCRI', 0);
  Configurador.fSetPos('GLO_UNIDAD', 1);
  Configurador.fSetPos('GLO_CODIGO', 2);
  Configurador.fSetPos('GLO_PRODUT', 3);
  Configurador.fSetPos('CADITE.ITE_DESITE', 4);
  Configurador.fSetPos('GLO_CODEMB', 5);
  Configurador.fSetPos('GLO_CODBAS', 6);
  Configurador.fSetPos('CADITE.ITE_CODITE', 7);

  Configurador.fSetVisivel('GLO_DESCRI' , True);
  Configurador.fSetVisivel('GLO_UNIDAD' , True);
  Configurador.fSetVisivel('GLO_CODIGO' , True);
  Configurador.fSetVisivel('GLO_PRODUT' , True);
  Configurador.fSetVisivel('CADITE.ITE_DESITE' , True);
  Configurador.fSetVisivel('GLO_CODEMB' , False);
  Configurador.fSetVisivel('GLO_CODBAS' , False);
  Configurador.fSetVisivel('CADITE.ITE_CODITE' , False);



  configurador.pAdicionarIndice('GLO_DESCRI+GLO_UNIDAD' , 'Descrição\Unidade');
  configurador.pAdicionarIndice('GLO_UNIDAD'  , 'Unidade');
  configurador.pAdicionarIndice('GLO_CODIGO'  , 'Código');
  Configurador.pAdicionarIndice('GLO_PRODUT'  , 'Produto');
  Configurador.pAdicionarIndice('CADITE.ITE_DESITE'  , 'Descrição do Item');


  configurador.pAdicionarCampoDescricao('GLO_UNIDAD');
end;

end.
