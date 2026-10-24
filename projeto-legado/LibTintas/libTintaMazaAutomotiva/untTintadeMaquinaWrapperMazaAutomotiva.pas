{******************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta MazaAutomotiva *}
{***************************************************************************AC*}
unit untTintadeMaquinaWrapperMazaAutomotiva;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperMazaAutomotiva = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompMazaAutomotiva,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperMazaAutomotiva }

procedure TTintadeMaquinaWrapperMazaAutomotiva.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  configurador.pAdicionarCampo('MZA_CODIGO', 'Código'                   , 'LIKE');
  configurador.pAdicionarCampo('MZA_DESCRI', 'Descrição'                , 'LIKE');
  configurador.pAdicionarCampo('MZA_DTACAD', 'Data Cadastro'            , 'LIKE');
  configurador.pAdicionarCampo('MZA_VARIAC', 'Variação'                 , 'LIKE');
  configurador.pAdicionarCampo('MZA_OBSERV', 'Observação'               , 'LIKE');
  configurador.pAdicionarCampo('MZA_ANOCOR', 'Ano'                      , 'LIKE');
  configurador.pAdicionarCampo('MZA_PESCOR', 'Peso Cor'                 , 'LIKE');
  configurador.pAdicionarCampo('MZA_PESFOR', 'Peso Fórmula'             , 'LIKE');
  configurador.pAdicionarCampo('MZA_LINHA_', 'Linha'                    , 'LIKE');
  configurador.pAdicionarCampo('LIN_DESCRI', 'Descrição da Linha'       , 'LIKE');
  configurador.pAdicionarCampo('MON_DESCRI', 'Montadora'                , 'LIKE');
  configurador.pAdicionarCampo('MZA_CODNFM', 'Código Nfm'               , 'LIKE', False, False);
  configurador.pAdicionarCampo('MZA_UNIVER', 'Código Universal'         , 'LIKE');
  configurador.pAdicionarCampo('MZA_CODMON', 'Código Montadora'         , 'LIKE', False, False);
  configurador.pAdicionarCampo('MZA_ACRMOB', 'Acréscimo de mão de obra' , 'LIKE', False, False);
  configurador.pAdicionarCampo('MZA_MD5KEY', 'MZA_MD5KEY'               , 'LIKE', False, True);
  Configurador.pAdicionarCampo('MZA_BAIQDI', 'Baixa Quantidade Digitada', 'LIKE', False, False);


  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('MZA_FORM' + TStrUtils.fStrZero(intCont, 2), 'MZA_BASE' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
    configurador.pAdicionarCampo('MZA_QTDC' + TStrUtils.fStrZero(intCont, 2), 'MZA_QTDC' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperMazaAutomotiva.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador) +
    ' AND UPPER(IFNULL(MZA_ATIVAD, "S")) = "S" ';
end;

function TTintadeMaquinaWrapperMazaAutomotiva.fGetSelectFrom(
  const configurador: IConfiguradorConsulta): String;
begin
  Result := 'MZA_CADMZA A';
  Result := Result + ' LEFT JOIN MZA_CADMON ON MON_CODMON = A.MZA_CODMON ';
  Result := Result + ' LEFT JOIN MZA_CADLIN ON LIN_CODIGO = A.MZA_LINHA_ ';
end;

function TTintadeMaquinaWrapperMazaAutomotiva.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(MZA_ATIVAD, "S")) = "S" ';
end;

function TTintadeMaquinaWrapperMazaAutomotiva.GetCampoAutoIncrem: String;
begin
  Result := 'A.AUTOINCREM';
end;

function TTintadeMaquinaWrapperMazaAutomotiva.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompMazaAutomotiva.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperMazaAutomotiva.GetNomeTabela: String;
begin
  Result := 'MZA_CADMZA ';
end;

procedure TTintadeMaquinaWrapperMazaAutomotiva.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin

  configurador.fSetPos('MZA_CODIGO', 0);
  configurador.fSetPos('MZA_VARIAC', 1);
  configurador.fSetPos('MZA_DESCRI', 2);
  configurador.fSetPos('MON_DESCRI', 3);
  configurador.fSetPos('MZA_ANOCOR', 4);
  configurador.fSetPos('MZA_OBSERV', 5);
  configurador.fSetPos('MZA_LINHA_', 6);
  configurador.fSetPos('MZA_CODMON', 7);
  configurador.fSetPos('MZA_CODNFM', 8);
  configurador.fSetPos('MZA_DTACAD', 9);
  configurador.fSetPos('LIN_DESCRI', 10);



  configurador.fSetVisivel('MZA_CODIGO', True);
  configurador.fSetVisivel('MZA_VARIAC', True);
  configurador.fSetVisivel('MZA_DTACAD', True);
  configurador.fSetVisivel('MZA_DESCRI', True);
  configurador.fSetVisivel('MON_DESCRI', True);
  configurador.fSetVisivel('MZA_ANOCOR', True);
  configurador.fSetVisivel('MZA_OBSERV', True);
  configurador.fSetVisivel('MZA_LINHA_', True);
  configurador.fSetVisivel('LIN_DESCRI', True);

  configurador.pAdicionarIndice('MZA_DESCRI', 'Descrição');
  configurador.pAdicionarIndice('MZA_CODIGO+MZA_VARIAC', 'Código/Variação');
  configurador.pAdicionarIndice('MON_DESCRI', 'Montadora');
  configurador.pAdicionarIndice('MZA_ANOCOR', 'Ano');
  configurador.pAdicionarIndice('MZA_CODIGO', 'Código');
  configurador.pAdicionarIndice('LIN_DESCRI', 'Descrição da Linha');

  configurador.pAdicionarCampoDescricao('MZA_CODIGO');
  configurador.pAdicionarCampoDescricao('MZA_VARIAC');
  configurador.pAdicionarCampoDescricao('MZA_DESCRI');
  configurador.pAdicionarCampoDescricao('MON_DESCRI');
  configurador.pAdicionarCampoDescricao('MZA_ANOCOR');
  configurador.pAdicionarCampoDescricao('MZA_OBSERV');
  configurador.pAdicionarCampoDescricao('MZA_LINHA_');
  configurador.pAdicionarCampoDescricao('MZA_CODMON');
  configurador.pAdicionarCampoDescricao('MZA_CODNFM');
  configurador.pAdicionarCampoDescricao('MZA_DTACAD');
  configurador.pAdicionarCampoDescricao('LIN_DESCRI');

end;

end.
