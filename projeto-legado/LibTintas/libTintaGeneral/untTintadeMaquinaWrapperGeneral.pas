{******************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta General *}
{***************************************************************************AC*}
unit untTintadeMaquinaWrapperGeneral;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperGeneral = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompGeneral,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperGeneral }

procedure TTintadeMaquinaWrapperGeneral.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  configurador.pAdicionarCampo('GEN_CODIGO', 'Código'                  , 'LIKE');
  configurador.pAdicionarCampo('GEN_DESCRI', 'Descrição'               , 'LIKE');
  configurador.pAdicionarCampo('GEN_VARIAC', 'Variação'                , 'LIKE');
  configurador.pAdicionarCampo('GEN_OBSERV', 'Observação'              , 'LIKE');
  configurador.pAdicionarCampo('MON_DESCRI', 'Montadora'               , 'LIKE');
  configurador.pAdicionarCampo('GEN_ANOINI', 'Ano Inicial'             , 'LIKE');
  configurador.pAdicionarCampo('GEN_ANOFIM', 'Ano Final'               , 'LIKE');
  configurador.pAdicionarCampo('GEN_DTACAD', 'Data Cadastro'           , 'LIKE');
  configurador.pAdicionarCampo('GEN_CODNFM', 'Código Nfm'              , 'LIKE', False, False);
  configurador.pAdicionarCampo('GEN_CODMON', 'Código Montadora'        , 'LIKE', False, False);
  configurador.pAdicionarCampo('GEN_ACRMOB', 'Acréscimo de mão de obra', 'LIKE', False, False);
  configurador.pAdicionarCampo('GEN_DILUID', 'Diluído'                 , 'LIKE', False, False);
  configurador.pAdicionarCampo('GEN_MD5KEY', 'MD5KEY'                  , 'LIKE', False, False);

  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('GEN_FORM' + TStrUtils.fStrZero(intCont, 2), 'GEN_BASE' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
    configurador.pAdicionarCampo('GEN_QTDC' + TStrUtils.fStrZero(intCont, 2), 'GEN_QTDC' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperGeneral.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador) +
    ' AND UPPER(IFNULL(GEN_ATIVAD, "S")) = "S" ';
end;

function TTintadeMaquinaWrapperGeneral.fGetSelectFrom(
  const configurador: IConfiguradorConsulta): String;
begin
  Result := 'GEN_CADGEN A';
  Result := Result + '  LEFT JOIN GEN_CADMON ON MON_CODMON = A.GEN_CODMON';
end;

function TTintadeMaquinaWrapperGeneral.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(GEN_ATIVAD, "S")) = "S" ';
end;

function TTintadeMaquinaWrapperGeneral.GetCampoAutoIncrem: String;
begin
  Result := 'A.AUTOINCREM';
end;

function TTintadeMaquinaWrapperGeneral.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompGeneral.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperGeneral.GetNomeTabela: String;
begin
  Result := 'GEN_CADGEN ';
end;

procedure TTintadeMaquinaWrapperGeneral.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin

  configurador.fSetPos('GEN_CODIGO', 0);
  configurador.fSetPos('GEN_VARIAC', 1);
  configurador.fSetPos('GEN_DESCRI', 2);
  configurador.fSetPos('GEN_CODMON', 3);
  configurador.fSetPos('MON_DESCRI', 4);
  configurador.fSetPos('GEN_OBSERV', 5);
  configurador.fSetPos('GEN_ANOINI', 6);
  configurador.fSetPos('GEN_ANOFIM', 7);


  configurador.fSetVisivel('GEN_CODIGO', True);
  configurador.fSetVisivel('GEN_VARIAC', True);
  configurador.fSetVisivel('GEN_DESCRI', True);
  configurador.fSetVisivel('GEN_CODMON', True);
  configurador.fSetVisivel('MON_DESCRI', True);
  configurador.fSetVisivel('GEN_OBSERV', True);
  configurador.fSetVisivel('GEN_ANOINI', True);
  configurador.fSetVisivel('GEN_ANOFIM', True);

  configurador.pAdicionarIndice('GEN_DESCRI', 'Descrição');
  configurador.pAdicionarIndice('GEN_VARIAC', 'Variação');
  configurador.pAdicionarIndice('MON_DESCRI', 'Montadora');
  configurador.pAdicionarIndice('GEN_OBSERV', 'Observação');
  configurador.pAdicionarIndice('GEN_CODIGO', 'Código da Cor');
  configurador.pAdicionarIndice('GEN_ANOINI', 'Ano Inicial');
  configurador.pAdicionarIndice('GEN_ANOFIM', 'Ano Final');

  configurador.pAdicionarCampoDescricao('GEN_CODIGO');
  configurador.pAdicionarCampoDescricao('GEN_VARIAC');
  configurador.pAdicionarCampoDescricao('GEN_DESCRI');
  configurador.pAdicionarCampoDescricao('GEN_CODMON');
  configurador.pAdicionarCampoDescricao('MON_DESCRI');
  configurador.pAdicionarCampoDescricao('GEN_OBSERV');
  configurador.pAdicionarCampoDescricao('GEN_ANOINI');
  configurador.pAdicionarCampoDescricao('GEN_ANOFIM');
end;

end.
