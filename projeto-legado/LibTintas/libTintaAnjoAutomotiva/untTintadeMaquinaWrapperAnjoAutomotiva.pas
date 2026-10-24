{******************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta AnjoAutomotiva *}
{***************************************************************************AC*}
unit untTintadeMaquinaWrapperAnjoAutomotiva;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperAnjoAutomotiva = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompAnjoAutomotiva,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperAnjoAutomotiva }

procedure TTintadeMaquinaWrapperAnjoAutomotiva.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  configurador.pAdicionarCampo('AJT_CODIGO', 'Código'                  , 'LIKE');
  configurador.pAdicionarCampo('AJT_DESCRI', 'Descrição'               , 'LIKE');
  configurador.pAdicionarCampo('AJT_PRODUT', 'Produto'                 , 'LIKE');
  configurador.pAdicionarCampo('AJT_ACABAM', 'Acabamento'              , 'LIKE');
  configurador.pAdicionarCampo('AJT_VARIAC', 'Variação'                , 'LIKE');
  configurador.pAdicionarCampo('AJT_CORMON', 'Cor Montadora'           , 'LIKE');
  configurador.pAdicionarCampo('AJT_ANOINI', 'Ano Inicio'              , 'LIKE');
  configurador.pAdicionarCampo('AJT_ANOFIM', 'Ano Fim'                 , 'LIKE');
  configurador.pAdicionarCampo('AJT_DTACAD', 'Data Cadastro'           , 'LIKE');
  configurador.pAdicionarCampo('AJT_OBSERV', 'Observação'              , 'LIKE');
  configurador.pAdicionarCampo('AJT_CODMON', 'Código Montadora'        , 'LIKE');
  configurador.pAdicionarCampo('MON_DESCRI', 'Montadora'               , 'LIKE');
  configurador.pAdicionarCampo('AJT_VOLUME', 'Volume Litro'            , 'LIKE');
  configurador.pAdicionarCampo('AJT_GRAMA_', 'Total Gramas'            , 'LIKE');
  configurador.pAdicionarCampo('AJT_ACRMOB', 'Acréscimo de mão de obra', 'LIKE', False, False);
  configurador.pAdicionarCampo('AJT_MD5KEY', 'AJT_MD5KEY'              , 'LIKE', False, True);


  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('AJT_FORM' + TStrUtils.fStrZero(intCont, 2), 'AJT_BASE' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
    configurador.pAdicionarCampo('AJT_QTDC' + TStrUtils.fStrZero(intCont, 2), 'AJT_QTDC' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperAnjoAutomotiva.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador) +
    ' AND UPPER(IFNULL(AJT_ATIVAD, "S")) = "S" ';
end;

function TTintadeMaquinaWrapperAnjoAutomotiva.fGetSelectFrom(
  const configurador: IConfiguradorConsulta): String;
begin
  Result := 'AJT_CADAJT A';
  Result := Result + ' LEFT JOIN AJT_CADMON ON MON_CODMON = A.AJT_CODMON';

end;

function TTintadeMaquinaWrapperAnjoAutomotiva.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(AJT_ATIVAD, "S")) = "S" ';
end;

function TTintadeMaquinaWrapperAnjoAutomotiva.GetCampoAutoIncrem: String;
begin
  Result := 'A.AUTOINCREM';
end;

function TTintadeMaquinaWrapperAnjoAutomotiva.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompAnjoAutomotiva.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperAnjoAutomotiva.GetNomeTabela: String;
begin
  Result := 'AJT_CADAJT ';
end;

procedure TTintadeMaquinaWrapperAnjoAutomotiva.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin

  configurador.fSetPos('AJT_CODIGO', 0);
  configurador.fSetPos('AJT_DESCRI', 1);
  configurador.fSetPos('AJT_PRODUT', 2);
  configurador.fSetPos('AJT_ACABAM', 3);
  configurador.fSetPos('AJT_VARIAC', 4);
  configurador.fSetPos('AJT_CORMON', 5);
  configurador.fSetPos('AJT_ANOINI', 6);
  configurador.fSetPos('AJT_ANOFIM', 7);
  configurador.fSetPos('AJT_DTACAD', 8);
  configurador.fSetPos('AJT_OBSERV', 9);
  configurador.fSetPos('AJT_VARIAC', 10);
  configurador.fSetPos('AJT_CODMON', 11);
  configurador.fSetPos('MON_DESCRI', 12);
  configurador.fSetPos('AJT_VOLUME', 13);
  configurador.fSetPos('AJT_GRAMA_', 14);

  configurador.fSetVisivel('AJT_CODIGO', True);
  configurador.fSetVisivel('AJT_DESCRI', True);
  configurador.fSetVisivel('AJT_PRODUT', True);
  configurador.fSetVisivel('AJT_ACABAM', True);
  configurador.fSetVisivel('AJT_VARIAC', True);
  configurador.fSetVisivel('AJT_CORMON', True);
  configurador.fSetVisivel('AJT_ANOINI', True);
  configurador.fSetVisivel('AJT_ANOFIM', True);
  configurador.fSetVisivel('AJT_DTACAD', True);
  configurador.fSetVisivel('AJT_OBSERV', True);
  configurador.fSetVisivel('AJT_VARIAC', True);
  configurador.fSetVisivel('AJT_CODMON', True);
  configurador.fSetVisivel('MON_DESCRI', True);
  configurador.fSetVisivel('AJT_VOLUME', True);
  configurador.fSetVisivel('AJT_GRAMA_', True);

  configurador.pAdicionarIndice('AJT_CODIGO', 'Código');
  configurador.pAdicionarIndice('AJT_DESCRI', 'Descrição');
  configurador.pAdicionarIndice('AJT_PRODUT', 'Produto');
  configurador.pAdicionarIndice('AJT_ACABAM', 'Acabamento');
  configurador.pAdicionarIndice('AJT_VARIAC', 'Variação');

  configurador.pAdicionarCampoDescricao('AJT_CODIGO');
  configurador.pAdicionarCampoDescricao('AJT_DESCRI');
  configurador.pAdicionarCampoDescricao('AJT_PRODUT');
  configurador.pAdicionarCampoDescricao('MON_DESCRI');

end;

end.
