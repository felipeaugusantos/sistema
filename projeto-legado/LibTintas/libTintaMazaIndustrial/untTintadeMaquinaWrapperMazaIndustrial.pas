{******************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta MazaIndustrial *}
{***************************************************************************AC*}
unit untTintadeMaquinaWrapperMazaIndustrial;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperMazaIndustrial = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompMazaIndustrial,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperMazaIndustrial }

procedure TTintadeMaquinaWrapperMazaIndustrial.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  configurador.pAdicionarCampo('MZD_CODIGO', 'Código'                  , 'LIKE');
  configurador.pAdicionarCampo('MZD_DTACAD', 'Data Cadastro'           , 'LIKE');
  configurador.pAdicionarCampo('MZD_DESCRI', 'Descrição'               , 'LIKE');
  configurador.pAdicionarCampo('MZD_VARIAC', 'Variação'                , 'LIKE');
  configurador.pAdicionarCampo('MZD_OBSERV', 'Observação'              , 'LIKE');
  configurador.pAdicionarCampo('MZD_ANOCOR', 'Ano'                     , 'LIKE');
  configurador.pAdicionarCampo('MZD_PESCOR', 'Peso Cor'                , 'LIKE');
  configurador.pAdicionarCampo('MZD_PESFOR', 'Peso Fórmula'            , 'LIKE');
  configurador.pAdicionarCampo('MZD_LINHA_', 'Linha'                   , 'LIKE');
  configurador.pAdicionarCampo('LIN_DESCRI', 'Descrição da Linha'      , 'LIKE');
  configurador.pAdicionarCampo('MON_DESCRI', 'Montadora'               , 'LIKE');
  configurador.pAdicionarCampo('MZD_CODNFM', 'Código Nfm'              , 'LIKE', False, False);
  configurador.pAdicionarCampo('MZD_UNIVER', 'Código Universal'        , 'LIKE', False, False);
  configurador.pAdicionarCampo('MZD_CODMON', 'Código Montadora'        , 'LIKE', False, False);
  configurador.pAdicionarCampo('MZD_ACRMOB', 'Acréscimo de mão de obra', 'LIKE', False, False);
  configurador.pAdicionarCampo('MZD_MD5KEY', 'MZD_MD5KEY'              , 'LIKE', False, True);
  configurador.pAdicionarCampo('MZD_BAIQDI', 'Baixa Quantidade Digitada', 'LIKE', False, False);


  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('MZD_FORM' + TStrUtils.fStrZero(intCont, 2), 'MZD_BASE' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
    configurador.pAdicionarCampo('MZD_QTDC' + TStrUtils.fStrZero(intCont, 2), 'MZD_QTDC' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperMazaIndustrial.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador) +
    ' AND UPPER(IFNULL(MZD_ATIVAD, "S")) = "S" ';
end;

function TTintadeMaquinaWrapperMazaIndustrial.fGetSelectFrom(
  const configurador: IConfiguradorConsulta): String;
begin
  Result := 'MZD_CADMZD A';
  Result := Result + ' LEFT JOIN MZD_CADMON ON MON_CODMON = A.MZD_CODMON ';
  Result := Result + ' LEFT JOIN MZD_CADLIN ON LIN_CODIGO = A.MZD_LINHA_ ';

end;

function TTintadeMaquinaWrapperMazaIndustrial.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(MZD_ATIVAD, "S")) = "S" ';
end;

function TTintadeMaquinaWrapperMazaIndustrial.GetCampoAutoIncrem: String;
begin
  Result := 'A.AUTOINCREM';
end;

function TTintadeMaquinaWrapperMazaIndustrial.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompMazaIndustrial.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperMazaIndustrial.GetNomeTabela: String;
begin
  Result := 'MZD_CADMZD ';
end;

procedure TTintadeMaquinaWrapperMazaIndustrial.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin

  configurador.fSetPos('MZD_CODIGO', 0);
  configurador.fSetPos('MZD_VARIAC', 1);
  configurador.fSetPos('MZD_DESCRI', 2);
  configurador.fSetPos('MON_DESCRI', 3);
  configurador.fSetPos('MZD_ANOCOR', 4);
  configurador.fSetPos('MZD_OBSERV', 5);
  configurador.fSetPos('MZD_LINHA_', 6);
  configurador.fSetPos('LIN_DESCRI', 7);
  configurador.fSetPos('MZD_CODMON', 8);
  configurador.fSetPos('MZD_CODNFM', 9);
  configurador.fSetPos('MZD_DTACAD', 10);

  configurador.pAdicionarCampo('MZD_CODIGO', 'Código'                  , 'LIKE');
  configurador.pAdicionarCampo('MZD_DESCRI', 'Descrição'               , 'LIKE');
  configurador.pAdicionarCampo('MZD_LINHA_', 'Linha'                   , 'LIKE');
  configurador.pAdicionarCampo('LIN_DESCRI', 'Descrição da Linha'      , 'LIKE');
  configurador.pAdicionarCampo('MZD_ANOCOR', 'Ano'                     , 'LIKE');
  configurador.pAdicionarCampo('MZD_PESCOR', 'Peso Cor'                , 'LIKE');
  configurador.pAdicionarCampo('MZD_PESFOR', 'Peso Fórmula'            , 'LIKE');
  configurador.pAdicionarCampo('MZD_DTACAD', 'Data Cadastro'           , 'LIKE');
  configurador.pAdicionarCampo('MZD_UNIVER', 'Código Universal'        , 'LIKE', False, False);
  configurador.pAdicionarCampo('MON_DESCRI', 'Montadora'               , 'LIKE', False, False);
  configurador.pAdicionarCampo('MZD_ACRMOB', 'Acréscimo de mão de obra', 'LIKE', False, False);

  configurador.fSetVisivel('MZD_CODIGO', True);
  configurador.fSetVisivel('MZD_VARIAC', True);
  configurador.fSetVisivel('MZD_DESCRI', True);
  configurador.fSetVisivel('MON_DESCRI', True);
  configurador.fSetVisivel('MZD_ANOCOR', True);
  configurador.fSetVisivel('MZD_OBSERV', True);
  configurador.fSetVisivel('MZD_LINHA_', True);
  configurador.fSetVisivel('LIN_DESCRI', True);
  configurador.fSetVisivel('MZD_DTACAD', True);
//  configurador.fSetVisivel('MZD_CODNFM', True);

  configurador.pAdicionarIndice('MZD_DESCRI', 'Descrição');
  configurador.pAdicionarIndice('MZD_CODIGO+MZD_VARIAC', 'Código da Cor/Variação');
  configurador.pAdicionarIndice('MON_DESCRI', 'Montadora');
  configurador.pAdicionarIndice('MZD_ANOCOR', 'Ano Cor');
  configurador.pAdicionarIndice('MZD_CODIGO', 'Código da Cor');
  configurador.pAdicionarIndice('LIN_DESCRI', 'Descrição da Linha');

  configurador.pAdicionarCampoDescricao('MZD_CODIGO');
  configurador.pAdicionarCampoDescricao('MZD_VARIAC');
  configurador.pAdicionarCampoDescricao('MZD_DESCRI');
  configurador.pAdicionarCampoDescricao('MON_DESCRI');
  configurador.pAdicionarCampoDescricao('MZD_ANOCOR');
  configurador.pAdicionarCampoDescricao('MZD_OBSERV');
  configurador.pAdicionarCampoDescricao('MZD_LINHA_');
  configurador.pAdicionarCampoDescricao('LIN_DESCRI');
  configurador.pAdicionarCampoDescricao('MZD_CODMON');
  configurador.pAdicionarCampoDescricao('MZD_CODNFM');
  configurador.pAdicionarCampoDescricao('MZD_DTACAD');

end;

end.
