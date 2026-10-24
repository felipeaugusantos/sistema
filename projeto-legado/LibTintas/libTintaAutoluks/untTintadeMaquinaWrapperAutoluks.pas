{******************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta Autoluks *}
{***************************************************************************AC*}
unit untTintadeMaquinaWrapperAutoluks;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperAutoluks = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompAutoluks,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperAutoluks }

procedure TTintadeMaquinaWrapperAutoluks.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  configurador.pAdicionarCampo('ALK_CODIGO', 'Código'                  , 'LIKE');
  configurador.pAdicionarCampo('ALK_DESCRI', 'Descrição'               , 'LIKE');
  configurador.pAdicionarCampo('ALK_PRODUT', 'Produto'                 , 'LIKE');
  configurador.pAdicionarCampo('ALK_ACABAM', 'Acabamento'              , 'LIKE');
  configurador.pAdicionarCampo('ALK_VARIAN', 'Variação'                , 'LIKE');
  configurador.pAdicionarCampo('ALK_CORMON', 'Cor Montadora'           , 'LIKE');
  configurador.pAdicionarCampo('ALK_ANOINI', 'Ano Inicio'              , 'LIKE');
  configurador.pAdicionarCampo('ALK_ANOFIN', 'Ano Fim'                 , 'LIKE');
  configurador.pAdicionarCampo('ALK_DTACAD', 'Data Cadastro'           , 'LIKE');
  configurador.pAdicionarCampo('ALK_VOLUME', 'Volume Litro'            , 'LIKE');
  configurador.pAdicionarCampo('MON_DESCRI', 'Montadora'               , 'LIKE');
  configurador.pAdicionarCampo('ALK_GRAMA_', 'Total Gramas'            , 'LIKE');
  configurador.pAdicionarCampo('ALK_PAIS__', 'País'                    , 'LIKE');
  configurador.pAdicionarCampo('ALK_ACRMOB', 'Acréscimo de mão de obra', 'LIKE', False, False);
  configurador.pAdicionarCampo('ALK_MD5KEY', 'ALK_MD5KEY'              , 'LIKE', False, True);


  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('ALK_BASE' + TStrUtils.fStrZero(intCont, 2), 'ALK_BASE' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
    configurador.pAdicionarCampo('ALK_QTDC' + TStrUtils.fStrZero(intCont, 2), 'ALK_QTDC' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperAutoluks.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador) +
    ' AND UPPER(IFNULL(ALK_ATIVAD, "S")) = "S" ';
end;

function TTintadeMaquinaWrapperAutoluks.fGetSelectFrom(
  const configurador: IConfiguradorConsulta): String;
begin
  Result := 'ALK_CADALK A';
  Result := Result + ' LEFT JOIN ALK_CADMON ON MON_CODMON = A.ALK_CODMON';
end;

function TTintadeMaquinaWrapperAutoluks.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(ALK_ATIVAD, "S")) = "S" ';
end;

function TTintadeMaquinaWrapperAutoluks.GetCampoAutoIncrem: String;
begin
  Result := 'A.AUTOINCREM';
end;

function TTintadeMaquinaWrapperAutoluks.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompAutoluks.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperAutoluks.GetNomeTabela: String;
begin
  Result := 'ALK_CADALK ';
end;

procedure TTintadeMaquinaWrapperAutoluks.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin

  configurador.fSetPos('ALK_CODIGO', 0);
  configurador.fSetPos('ALK_DESCRI', 1);
  configurador.fSetPos('ALK_PRODUT', 2);
  configurador.fSetPos('ALK_ACABAM', 3);
  configurador.fSetPos('ALK_VARIAN', 4);
  configurador.fSetPos('ALK_CORMON', 5);
  configurador.fSetPos('ALK_ANOINI', 6);
  configurador.fSetPos('ALK_ANOFIN', 7);
  configurador.fSetPos('ALK_DTACAD', 8);
  configurador.fSetPos('ALK_VOLUME', 9);
  configurador.fSetPos('ALK_GRAMA_', 10);
  configurador.fSetPos('MON_DESCRI', 11);

  configurador.fSetVisivel('ALK_CODIGO', True);
  configurador.fSetVisivel('ALK_DESCRI', True);
  configurador.fSetVisivel('ALK_PRODUT', True);
  configurador.fSetVisivel('ALK_ACABAM', True);
  configurador.fSetVisivel('ALK_VARIAN', True);
  configurador.fSetVisivel('ALK_CORMON', True);
  configurador.fSetVisivel('ALK_ANOINI', True);
  configurador.fSetVisivel('ALK_ANOFIN', True);
  configurador.fSetVisivel('ALK_DTACAD', True);
  configurador.fSetVisivel('ALK_VOLUME', True);
  configurador.fSetVisivel('ALK_GRAMA_', True);
  configurador.fSetVisivel('MON_DESCRI', True);

  configurador.pAdicionarIndice('ALK_CODIGO', 'Código');
  configurador.pAdicionarIndice('ALK_DESCRI', 'Descrição');
  configurador.pAdicionarIndice('ALK_PRODUT', 'Produto');
  configurador.pAdicionarIndice('ALK_ACABAM', 'Acabamento');
  configurador.pAdicionarIndice('ALK_VARIAN', 'Variação');

  configurador.pAdicionarCampoDescricao('ALK_CODIGO');
  configurador.pAdicionarCampoDescricao('ALK_DESCRI');
  configurador.pAdicionarCampoDescricao('ALK_PRODUT');
  configurador.pAdicionarCampoDescricao('MON_DESCRI');
end;

end.
