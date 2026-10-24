{******************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta FarbenAutomotiva *}
{***************************************************************************AC*}
unit untTintadeMaquinaWrapperFarbenAutomotiva;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperFarbenAutomotiva = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompFarbenAutomotiva,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperFarbenAutomotiva }

procedure TTintadeMaquinaWrapperFarbenAutomotiva.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin


  configurador.pAdicionarCampo('F.FAR_CODNFM', 'Código'               , 'LIKE');
  configurador.pAdicionarCampo('F.FAR_DESCRI', 'Descrição'            , 'LIKE');
  configurador.pAdicionarCampo('M.FAR_DESMON', 'Montadora'            , 'LIKE');
  configurador.pAdicionarCampo('F.FAR_O_E_M_', 'Oem'                  , 'LIKE');
  configurador.pAdicionarCampo('F.FAR_A_N_O_', 'Ano'                  , 'LIKE');
  configurador.pAdicionarCampo('F.FAR_SETOR_', 'Setor'                , 'LIKE');
  configurador.pAdicionarCampo('F.FAR_LINHA_', 'Linha'                , 'LIKE');
  configurador.pAdicionarCampo('F.FAR_CODEMP', 'Cod. Emp'             , 'LIKE');
  configurador.pAdicionarCampo('F.FAR_METPES', 'Metais Pesados'       , 'LIKE');
  configurador.pAdicionarCampo('F.FAR_MONTAD', 'Cod. Montadora'       , 'LIKE', False, False);
  configurador.pAdicionarCampo('F.FAR_CODSEQ', 'Cod. Seq'             , 'LIKE', False, False);
  configurador.pAdicionarCampo('F.FAR_MD5KEY', 'MD5KEY',                  '=' , False, True);
  configurador.pAdicionarCampo('F.FAR_ACRMOB', 'Acréscimo mão de obra', 'LIKE', False, False);
  configurador.pAdicionarCampo('F.FAR_PROCHA', 'Produto Chapinha', 'LIKE', False, False);
  configurador.pAdicionarCampo('F.FAR_TIPPRG', 'Programa'             , 'LIKE');
  configurador.pAdicionarCampo('F.FAR_OBSERV', 'Observação'           , 'LIKE');
  configurador.pAdicionarCampo('F.FAR_DESLIN', 'Descrição Linha'      , 'LIKE');
  configurador.pAdicionarCampo('F.FAR_DESPRG', 'Descrição Programa'   , 'LIKE');


  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('FAR_CODB' + TStrUtils.fStrZero(intCont, 2), 'FAR_CODB' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
    configurador.pAdicionarCampo('FAR_QTDC' + TStrUtils.fStrZero(intCont, 2), 'FAR_QTDC' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
    configurador.pAdicionarCampo('FAR_QTDD' + TStrUtils.fStrZero(intCont, 2), 'FAR_QTDD' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperFarbenAutomotiva.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador) +
    ' AND UPPER(IFNULL(FAR_ATIVAD, "S")) = "S" ';
end;

function TTintadeMaquinaWrapperFarbenAutomotiva.fGetSelectFrom(
  const configurador: IConfiguradorConsulta): String;
begin
  Result := '';
  Result := Result + ' 	FAR_CADFAR F ';
  Result := Result + ' 	LEFT JOIN FAR_CADMON M ';
  Result := Result + ' 	ON (F.FAR_MONTAD = M.FAR_CODMON) ';
end;

function TTintadeMaquinaWrapperFarbenAutomotiva.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(FAR_ATIVAD, "S")) = "S" ';
end;

function TTintadeMaquinaWrapperFarbenAutomotiva.GetCampoAutoIncrem: String;
begin
  Result := 'F.AUTOINCREM';
end;

function TTintadeMaquinaWrapperFarbenAutomotiva.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompFarbenAutomotiva.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperFarbenAutomotiva.GetNomeTabela: String;
begin
  Result := 'FAR_CADFAR';
end;

procedure TTintadeMaquinaWrapperFarbenAutomotiva.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin

  configurador.fSetPos('F.FAR_CODNFM', 0);
  configurador.fSetPos('F.FAR_DESCRI', 1);
  configurador.fSetPos('M.FAR_DESMON', 2);
  configurador.fSetPos('F.FAR_O_E_M_', 3);
  configurador.fSetPos('F.FAR_A_N_O_', 4);
  configurador.fSetPos('F.FAR_SETOR_', 5);
  configurador.fSetPos('F.FAR_LINHA_', 6);
  configurador.fSetPos('F.FAR_CODEMP', 7);


  configurador.fSetVisivel('F.FAR_CODNFM', True);
  configurador.fSetVisivel('F.FAR_DESCRI', True);
  configurador.fSetVisivel('M.FAR_DESMON', True);
  configurador.fSetVisivel('F.FAR_O_E_M_', True);
  configurador.fSetVisivel('F.FAR_A_N_O_', True);
  configurador.fSetVisivel('F.FAR_SETOR_', True);
  configurador.fSetVisivel('F.FAR_LINHA_', True);
  configurador.fSetVisivel('F.FAR_CODEMP', True);


  configurador.pAdicionarIndice('F.FAR_DESCRI', 'Descrição');
  configurador.pAdicionarIndice('F.FAR_CODNFM', 'Código');
  configurador.pAdicionarIndice('M.FAR_DESMON', 'Montadora');
  configurador.pAdicionarIndice('F.FAR_A_N_O_', 'Ano');

  configurador.pAdicionarCampoDescricao('F.FAR_CODNFM');
  configurador.pAdicionarCampoDescricao('F.FAR_DESCRI');
  configurador.pAdicionarCampoDescricao('M.FAR_DESMON');
  configurador.pAdicionarCampoDescricao('F.FAR_O_E_M_');
  configurador.pAdicionarCampoDescricao('F.FAR_A_N_O_');
  configurador.pAdicionarCampoDescricao('F.FAR_SETOR_');
  configurador.pAdicionarCampoDescricao('F.FAR_LINHA_');
  configurador.pAdicionarCampoDescricao('F.FAR_CODEMP');
end;

end.
