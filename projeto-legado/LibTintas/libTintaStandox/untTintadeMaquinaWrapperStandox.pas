{******************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta Standox *}
{***************************************************************************AC*}
unit untTintadeMaquinaWrapperStandox;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperStandox = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompStandox,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperStandox }

procedure TTintadeMaquinaWrapperStandox.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin

  configurador.pAdicionarCampo('DOX_CODNFM', 'Código Novas Fórmulas', 'LIKE');
  configurador.pAdicionarCampo('DOX_MONTAD', 'Montadora', 'LIKE');
  configurador.pAdicionarCampo('DOX_DESCRI', 'Descrição', 'LIKE');
  configurador.pAdicionarCampo('DOX_ANOINI', 'Ano Inicial', 'LIKE');
  configurador.pAdicionarCampo('DOX_ANOFIN', 'Ano Final', 'LIKE');
  configurador.pAdicionarCampo('DOX_PAINEL', 'Painel', 'LIKE');
  configurador.pAdicionarCampo('DOX_QUALID', 'Qualidade', 'LIKE');
  configurador.pAdicionarCampo('DOX_CATEGO', 'Categoria', 'LIKE');
  configurador.pAdicionarCampo('DOX_VARIAN', 'Variante', 'LIKE');
  configurador.pAdicionarCampo('DOX_PAIS__', 'Pais', 'LIKE');
  configurador.pAdicionarCampo('DOX_CODSEQ', 'Código Sequencial', 'LIKE', False, False);
  configurador.pAdicionarCampo('DOX_PROCHA', 'Produto Chapinha', 'LIKE', False, False);
  configurador.pAdicionarCampo('DOX_CODDOX', 'Código', 'LIKE');
  configurador.pAdicionarCampo('DOX_MD5KEY', 'Chave MD5', 'LIKE', False, True);
  configurador.pAdicionarCampo('DOX_ACRMOB', 'Acrésc. Mão de Obra', 'LIKE', False, False);

  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('DOX_BASE' + TStrUtils.fStrZero(intCont, 2), 'DOX_BASE' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
    configurador.pAdicionarCampo('DOX_QTDC' + TStrUtils.fStrZero(intCont, 2), 'DOX_QTDC' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperStandox.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador) +
    ' AND UPPER(IFNULL(DOX_ATIVO_, "S")) = "S" ';
end;

function TTintadeMaquinaWrapperStandox.fGetSelectFrom(
  const configurador: IConfiguradorConsulta): String;
begin
  Result := '';
  Result := GetNomeTabela;
end;

function TTintadeMaquinaWrapperStandox.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(DOX_ATIVO_, "S")) = "S" ';
end;

function TTintadeMaquinaWrapperStandox.GetCampoAutoIncrem: String;
begin
  Result := 'AUTOINCREM';
end;

function TTintadeMaquinaWrapperStandox.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompStandox.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperStandox.GetNomeTabela: String;
begin
  Result := 'DOX_CADDOX';
end;

procedure TTintadeMaquinaWrapperStandox.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin

  configurador.fSetPos('DOX_CODDOX', 0);
  configurador.fSetPos('DOX_MONTAD', 1);
  configurador.fSetPos('DOX_DESCRI', 2);
  configurador.fSetPos('DOX_ANOINI', 3);
  configurador.fSetPos('DOX_ANOFIN', 4);
  configurador.fSetPos('DOX_PAINEL', 5);
  configurador.fSetPos('DOX_QUALID', 6);
  configurador.fSetPos('DOX_CATEGO', 7);
  configurador.fSetPos('DOX_VARIAN', 8);
  configurador.fSetPos('DOX_PAIS__', 9);

  configurador.fSetVisivel('DOX_CODDOX', True);
  configurador.fSetVisivel('DOX_MONTAD', True);
  configurador.fSetVisivel('DOX_DESCRI', True);
  configurador.fSetVisivel('DOX_ANOINI', True);
  configurador.fSetVisivel('DOX_ANOFIN', True);
  configurador.fSetVisivel('DOX_PAINEL', True);
  configurador.fSetVisivel('DOX_QUALID', True);
  configurador.fSetVisivel('DOX_CATEGO', True);
  configurador.fSetVisivel('DOX_VARIAN', True);
  configurador.fSetVisivel('DOX_PAIS__', True);

  configurador.pAdicionarIndice('DOX_DESCRI+DOX_QUALID+DOX_MONTAD', 'Descrição/Qualidade/Montadora');
  configurador.pAdicionarIndice('DOX_MONTAD', 'Montadora');
  configurador.pAdicionarIndice('DOX_CODDOX', 'Código');
  configurador.pAdicionarIndice('DOX_PAINEL', 'Painel');

  configurador.pAdicionarCampoDescricao('DOX_DESCRI');
  configurador.pAdicionarCampoDescricao('DOX_MONTAD');
  configurador.pAdicionarCampoDescricao('DOX_QUALID');
  configurador.pAdicionarCampoDescricao('DOX_CODDOX');
end;

end.
