{*****************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta Duxone  *}
{**************************************************************************AC*}
unit untTintadeMaquinaWrapperDuxone;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperDuxone = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompDuxone,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperDuxone }

procedure TTintadeMaquinaWrapperDuxone.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  configurador.pAdicionarCampo('DUX_CODDUX', 'Código', 'LIKE');
  configurador.pAdicionarCampo('DUX_CODOEM', 'Código Oem', 'LIKE');
  configurador.pAdicionarCampo('DUX_LINHA_', 'Linha', 'LIKE');
  configurador.pAdicionarCampo('DUX_DESLIN', 'Descrição Linha', 'LIKE');
  configurador.pAdicionarCampo('DUX_QUALID', 'Qualidade', 'LIKE');
  configurador.pAdicionarCampo('DUX_ALTERN', 'Alternativa', 'LIKE');
  configurador.pAdicionarCampo('DUX_REGIAO', 'Região', 'LIKE');
  configurador.pAdicionarCampo('DUX_DESCRI', 'Descrição', 'LIKE');
  configurador.pAdicionarCampo('DUX_MONTAD', 'Montadora', 'LIKE');
  configurador.pAdicionarCampo('DUX_ANOCOR', 'Ano', 'LIKE');
  configurador.pAdicionarCampo('DUX_LITRAG', 'Volume', 'LIKE');
  configurador.pAdicionarCampo('DUX_DTACAD', 'Data Cadastro', 'LIKE');
  configurador.pAdicionarCampo('DUX_CODSEQ', 'DUX_CODSEQ', 'LIKE', False, False);
  configurador.pAdicionarCampo('DUX_PROCHA', 'Produto Chapinha', 'LIKE', False, False);
  configurador.pAdicionarCampo('DUX_CODNFM', 'DUX_CODNFM', 'LIKE', False, False);
  configurador.pAdicionarCampo('DUX_MD5KEY', 'DUX_MD5KEY', 'LIKE', False, True);
  configurador.pAdicionarCampo('DUX_ACRMOB', 'Acréscimo mão de obra', 'LIKE', False, False);
  configurador.pAdicionarCampo('DUX_OBSERV', 'Observação', 'LIKE');

  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('DUX_BASE' + TStrUtils.fStrZero(intCont, 2), 'DUX_BASE' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
    configurador.pAdicionarCampo('DUX_QTDC' + TStrUtils.fStrZero(intCont, 2), 'DUX_QTDC' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
    configurador.pAdicionarCampo('DUX_QTDD' + TStrUtils.fStrZero(intCont, 2), 'DUX_QTDD' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
    configurador.pAdicionarCampo('DUX_TIPB' + TStrUtils.fStrZero(intCont, 2), 'DUX_TIPB' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperDuxone.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador) +
    ' AND UPPER(IFNULL(DUX_ATIVO_, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperDuxone.fGetSelectFrom(
  const configurador: IConfiguradorConsulta): String;
begin
  Result := GetNomeTabela;
end;

function TTintadeMaquinaWrapperDuxone.fGetWhere: String;
begin
  Result := ' WHERE TRUE AND UPPER(IFNULL(DUX_ATIVO_, ''S'')) = ''S'' '
end;

function TTintadeMaquinaWrapperDuxone.GetCampoAutoIncrem: String;
begin
  Result := 'AUTOINCREM';
end;

function TTintadeMaquinaWrapperDuxone.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompDuxone.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperDuxone.GetNomeTabela: String;
begin
  Result := 'DUX_CADDUX';
end;

procedure TTintadeMaquinaWrapperDuxone.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  configurador.fSetPos('DUX_CODDUX', 0);
  configurador.fSetPos('DUX_ALTERN', 1);
  configurador.fSetPos('DUX_REGIAO', 2);
  configurador.fSetPos('DUX_DESCRI', 3);
  configurador.fSetPos('DUX_CODOEM', 4);
  configurador.fSetPos('DUX_MONTAD', 5);
  configurador.fSetPos('DUX_ANOCOR', 6);
  configurador.fSetPos('DUX_LINHA_', 7);
  configurador.fSetPos('DUX_QUALID', 8);
  configurador.fSetPos('DUX_DTACAD', 9);

  configurador.fSetVisivel('DUX_CODDUX', True);
  configurador.fSetVisivel('DUX_ALTERN', True);
  configurador.fSetVisivel('DUX_REGIAO', True);
  configurador.fSetVisivel('DUX_DESCRI', True);
  configurador.fSetVisivel('DUX_CODOEM', True);
  configurador.fSetVisivel('DUX_MONTAD', True);
  configurador.fSetVisivel('DUX_ANOCOR', True);
  configurador.fSetVisivel('DUX_LINHA_', True);
  configurador.fSetVisivel('DUX_QUALID', True);
  configurador.fSetVisivel('DUX_DTACAD', True);

  configurador.pAdicionarIndice('DUX_DESCRI+DUX_QUALID+DUX_REGIAO', 'Descrição/Qualidade/Região');
  configurador.pAdicionarIndice('DUX_MONTAD', 'Montadora');
  configurador.pAdicionarIndice('DUX_CODDUX', 'Código');
  configurador.pAdicionarIndice('DUX_CODOEM', 'Código Oem');
  configurador.pAdicionarIndice('DUX_DTACAD', 'Data Cadastro');

  configurador.pAdicionarCampoDescricao('DUX_DESCRI');
  configurador.pAdicionarCampoDescricao('DUX_MONTAD');
  configurador.pAdicionarCampoDescricao('DUX_QUALID');
  configurador.pAdicionarCampoDescricao('DUX_CODDUX');
end;

end.
