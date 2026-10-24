{*****************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta Dupont  *}
{**************************************************************************AC*}
unit untTintadeMaquinaWrapperDupont;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperDupont = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompDupont,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperDupont }

procedure TTintadeMaquinaWrapperDupont.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  configurador.pAdicionarCampo('DUP_CODDUP', 'Código', 'LIKE');
  configurador.pAdicionarCampo('DUP_CODOEM', 'Código Oem', 'LIKE');
  configurador.pAdicionarCampo('DUP_LINHA_', 'Linha', 'LIKE');
  configurador.pAdicionarCampo('DUP_QUALID', 'Qualidade', 'LIKE');
  configurador.pAdicionarCampo('DUP_ALTERN', 'Alternativa', 'LIKE');
  configurador.pAdicionarCampo('DUP_REGIAO', 'Região', 'LIKE');
  configurador.pAdicionarCampo('DUP_DESCRI', 'Descrição', 'LIKE');
  configurador.pAdicionarCampo('DUP_MONTAD', 'Montadora', 'LIKE');
  configurador.pAdicionarCampo('DUP_ANOCOR', 'Ano', 'LIKE');
  configurador.pAdicionarCampo('DUP_LITRAG', 'Volume', 'LIKE');
  configurador.pAdicionarCampo('DUP_DTACAD', 'Data Cadastro', 'LIKE');
  configurador.pAdicionarCampo('DUP_CODSEQ', 'DUP_CODSEQ', 'LIKE', False, False);
  configurador.pAdicionarCampo('DUP_PROCHA', 'Produto Chapinha', 'LIKE', False, False);
  configurador.pAdicionarCampo('DUP_CODNFM', 'DUP_CODNFM', 'LIKE', False, False);
  configurador.pAdicionarCampo('DUP_MD5KEY', 'DUP_MD5KEY', 'LIKE', False, True);
  configurador.pAdicionarCampo('DUP_ACRMOB', 'Acréscimo mão de obra', 'LIKE', False, False);
  configurador.pAdicionarCampo('DUP_OBSERV', 'Observação', 'LIKE');

  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('DUP_BASE' + TStrUtils.fStrZero(intCont, 2), 'DUP_BASE' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
    configurador.pAdicionarCampo('DUP_QTDC' + TStrUtils.fStrZero(intCont, 2), 'DUP_QTDC' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
    configurador.pAdicionarCampo('DUP_QTDD' + TStrUtils.fStrZero(intCont, 2), 'DUP_QTDD' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
    configurador.pAdicionarCampo('DUP_TIPB' + TStrUtils.fStrZero(intCont, 2), 'DUP_TIPB' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperDupont.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador) +
    ' AND UPPER(IFNULL(DUP_ATIVO_, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperDupont.fGetSelectFrom(
  const configurador: IConfiguradorConsulta): String;
begin
  Result := GetNomeTabela;
end;

function TTintadeMaquinaWrapperDupont.fGetWhere: String;
begin
  Result := ' WHERE TRUE AND UPPER(IFNULL(DUP_ATIVO_, ''S'')) = ''S'' '
end;

function TTintadeMaquinaWrapperDupont.GetCampoAutoIncrem: String;
begin
  Result := 'AUTOINCREM';
end;

function TTintadeMaquinaWrapperDupont.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompDupont.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperDupont.GetNomeTabela: String;
begin
  Result := 'DUP_CADDUP';
end;

procedure TTintadeMaquinaWrapperDupont.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  configurador.fSetPos('DUP_CODDUP', 0);
  configurador.fSetPos('DUP_ALTERN', 1);
  configurador.fSetPos('DUP_REGIAO', 2);
  configurador.fSetPos('DUP_DESCRI', 3);
  configurador.fSetPos('DUP_CODOEM', 4);
  configurador.fSetPos('DUP_MONTAD', 5);
  configurador.fSetPos('DUP_ANOCOR', 6);
  configurador.fSetPos('DUP_LINHA_', 7);
  configurador.fSetPos('DUP_QUALID', 8);
  configurador.fSetPos('DUP_DTACAD', 9);

  configurador.fSetVisivel('DUP_CODDUP', True);
  configurador.fSetVisivel('DUP_ALTERN', True);
  configurador.fSetVisivel('DUP_REGIAO', True);
  configurador.fSetVisivel('DUP_DESCRI', True);
  configurador.fSetVisivel('DUP_CODOEM', True);
  configurador.fSetVisivel('DUP_MONTAD', True);
  configurador.fSetVisivel('DUP_ANOCOR', True);
  configurador.fSetVisivel('DUP_LINHA_', True);
  configurador.fSetVisivel('DUP_QUALID', True);
  configurador.fSetVisivel('DUP_DTACAD', True);

  configurador.pAdicionarIndice('DUP_DESCRI+DUP_QUALID+DUP_REGIAO', 'Descrição/Qualidade/Região');
  configurador.pAdicionarIndice('DUP_MONTAD', 'Montadora');
  configurador.pAdicionarIndice('DUP_CODDUP', 'Código');
  configurador.pAdicionarIndice('DUP_CODOEM', 'Código Oem');
  configurador.pAdicionarIndice('DUP_DTACAD', 'Data Cadastro');

  configurador.pAdicionarCampoDescricao('DUP_DESCRI');
  configurador.pAdicionarCampoDescricao('DUP_MONTAD');
  configurador.pAdicionarCampoDescricao('DUP_QUALID');
  configurador.pAdicionarCampoDescricao('DUP_CODDUP');
end;

end.
