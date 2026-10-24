{******************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta BrazilianColorAutomotiva *}
{***************************************************************************AC*}
unit untTintadeMaquinaWrapperBrazilianColorAutomotiva;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperBrazilianColorAutomotiva = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompBrazilianColorAutomotiva,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperBrazilianColorAutomotiva }

procedure TTintadeMaquinaWrapperBrazilianColorAutomotiva.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  configurador.pAdicionarCampo('BZC_CODIGO', 'Código', 'LIKE');
  configurador.pAdicionarCampo('BZC_CODNFM', 'Código Novas Fórmulas', 'LIKE');
  configurador.pAdicionarCampo('BZC_DESCRI', 'Descrição', 'LIKE');
  configurador.pAdicionarCampo('BZC_CODUNI', 'Código Universal', 'LIKE');
  configurador.pAdicionarCampo('BZC_A_N_O_', 'Ano', 'LIKE');
  configurador.pAdicionarCampo('BZC_LINHA_', 'Linha', 'LIKE');
  configurador.pAdicionarCampo('MON_DESCRI', 'Montadora', 'LIKE');
  configurador.pAdicionarCampo('BZC_TIPO__', 'Tipo', 'LIKE');
  configurador.pAdicionarCampo('BZC_DTACAD', 'Data de Cadastro', 'LIKE');
  configurador.pAdicionarCampo('BZC_ACRMOB', 'Acréscimo de mão de obra','LIKE',False,False);
  configurador.pAdicionarCampo('BZC_MD5KEY', 'MD5KEY', 'LIKE', False, True);


  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('BZC_BASE' + TStrUtils.fStrZero(intCont, 2), 'BZC_BASE' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
    configurador.pAdicionarCampo('BZC_QTDC' + TStrUtils.fStrZero(intCont, 2), 'BZC_QTDC' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
    configurador.pAdicionarCampo('BZC_QTDD' + TStrUtils.fStrZero(intCont, 2), 'BZC_QTDD' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperBrazilianColorAutomotiva.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador) +
    ' AND UPPER(IFNULL(BZC_ATIVAD, "S")) = "S" ';
end;

function TTintadeMaquinaWrapperBrazilianColorAutomotiva.fGetSelectFrom(
  const configurador: IConfiguradorConsulta): String;
begin
  Result :=
    '   BZC_CADBZC                     ' +
    '   LEFT JOIN BZC_CADMON           ' +
    '     ON BZC_CODMON = MON_CODMON   ';;
end;

function TTintadeMaquinaWrapperBrazilianColorAutomotiva.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(BZC_ATIVAD, "S")) = "S" ';
end;

function TTintadeMaquinaWrapperBrazilianColorAutomotiva.GetCampoAutoIncrem: String;
begin
  Result := 'BZC_CADBZC.AUTOINCREM';
end;

function TTintadeMaquinaWrapperBrazilianColorAutomotiva.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompBrazilianColorAutomotiva.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperBrazilianColorAutomotiva.GetNomeTabela: String;
begin
  Result := 'BZC_CADBZC';
end;

procedure TTintadeMaquinaWrapperBrazilianColorAutomotiva.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin

  configurador.fSetPos('BZC_CODIGO', 0);
  configurador.fSetPos('BZC_CODUNI', 1);
  configurador.fSetPos('BZC_DESCRI', 2);
  configurador.fSetPos('BZC_A_N_O_', 3);
  configurador.fSetPos('MON_DESCRI', 4);
  configurador.fSetPos('BZC_CODNFM', 5);
  configurador.fSetPos('BZC_TIPO__', 6);
  configurador.fSetPos('BZC_LINHA_', 7);

  configurador.fSetVisivel('BZC_CODIGO', True);
  configurador.fSetVisivel('BZC_CODUNI', True);
  configurador.fSetVisivel('BZC_DESCRI', True);
  configurador.fSetVisivel('BZC_A_N_O_', True);
  configurador.fSetVisivel('MON_DESCRI', True);
  configurador.fSetVisivel('BZC_CODNFM', False);
  configurador.fSetVisivel('BZC_TIPO__', True);
  configurador.fSetVisivel('BZC_LINHA_', True);

  configurador.pAdicionarIndice('BZC_DESCRI', 'Descrição');
  configurador.pAdicionarIndice('BZC_CODIGO', 'Código');
  configurador.pAdicionarIndice('BZC_A_N_O_+BZC_DESCRI', 'Ano/Descrição');
  configurador.pAdicionarIndice('BZC_LINHA_', 'Linha');

  configurador.pAdicionarCampoDescricao('BZC_CODIGO');
  configurador.pAdicionarCampoDescricao('BZC_CODUNI');
  configurador.pAdicionarCampoDescricao('BZC_DESCRI');
  configurador.pAdicionarCampoDescricao('BZC_A_N_O_');
  configurador.pAdicionarCampoDescricao('MON_DESCRI');
  configurador.pAdicionarCampoDescricao('BZC_CODNFM');
  configurador.pAdicionarCampoDescricao('BZC_TIPO__');
  configurador.pAdicionarCampoDescricao('BZC_LINHA_');

end;

end.
