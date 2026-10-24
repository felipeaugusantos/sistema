{******************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta Salcomix *}
{***************************************************************************AC*}
unit untTintadeMaquinaWrapperSalcomix;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperSalcomix = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompSalcomix, untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperSalcomix }

procedure TTintadeMaquinaWrapperSalcomix.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  Configurador.pAdicionarCampo('SAL_CODSEQ', 'Cód Seq', 'LIKE');
  Configurador.pAdicionarCampo('SAL_LINHA_', 'Linha', 'LIKE');
  Configurador.pAdicionarCampo('SAL_MONTAD', 'Montadora', 'LIKE');
  Configurador.pAdicionarCampo('SAL_DESCRI', 'Descrição', 'LIKE');
  Configurador.pAdicionarCampo('SAL_CODPRO', 'Código', 'LIKE');
  Configurador.pAdicionarCampo('SAL_ANOCOR', 'Ano', 'LIKE');
  Configurador.pAdicionarCampo('SAL_VARIAC', 'Variação', 'LIKE');
  Configurador.pAdicionarCampo('SAL_PASSO_', 'Passo', 'LIKE');
  Configurador.pAdicionarCampo('SAL_DTACAD', 'Data Cadastro', 'LIKE');
  Configurador.pAdicionarCampo('SAL_ACRMOB', 'Acréscimo Mão de Obra', 'LIKE');
  Configurador.pAdicionarCampo('SAL_MD5KEY', 'Chave MD5', '=', False, True);



  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('SAL_FORM' + TStrUtils.fStrZero(intCont, 2), 'SAL_FORM' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
    configurador.pAdicionarCampo('SAL_QTDB' + TStrUtils.fStrZero(intCont, 2), 'SAL_QTDB' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
    configurador.pAdicionarCampo('SAL_QTDD' + TStrUtils.fStrZero(intCont, 2), 'SAL_QTDD' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperSalcomix.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador) +
    ' AND UPPER(IFNULL(SAL_ATIVO_, "S")) = "S" ';
end;

function TTintadeMaquinaWrapperSalcomix.fGetSelectFrom(
  const configurador: IConfiguradorConsulta): String;
begin
  Result := '';
  Result := Result + GetNomeTabela;
end;

function TTintadeMaquinaWrapperSalcomix.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(SAL_ATIVO_, "S")) = "S" ';
end;

function TTintadeMaquinaWrapperSalcomix.GetCampoAutoIncrem: String;
begin
  Result := 'AUTOINCREM';
end;

function TTintadeMaquinaWrapperSalcomix.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
  Result := TConsultaCompSalcomix.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),
    Self
  );
end;

function TTintadeMaquinaWrapperSalcomix.GetNomeTabela: String;
begin
  Result := 'SAL_CADSAL';
end;

procedure TTintadeMaquinaWrapperSalcomix.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin

  Configurador.fSetPos('SAL_DESCRI', 0);
  Configurador.fSetPos('SAL_CODPRO', 1);
  Configurador.fSetPos('SAL_MONTAD', 2);
  Configurador.fSetPos('SAL_VARIAC', 3);
  Configurador.fSetPos('SAL_LINHA_', 4);
  Configurador.fSetPos('SAL_ANOCOR', 5);
  Configurador.fSetPos('SAL_CODSEQ', 6);



  Configurador.fSetVisivel('SAL_DESCRI', True);
  Configurador.fSetVisivel('SAL_CODPRO', True);
  Configurador.fSetVisivel('SAL_MONTAD', True);
  Configurador.fSetVisivel('SAL_VARIAC', True);
  Configurador.fSetVisivel('SAL_LINHA_', True);
  Configurador.fSetVisivel('SAL_ANOCOR', True);
  Configurador.fSetVisivel('SAL_CODSEQ', True);


  Configurador.pAdicionarIndice('SAL_DESCRI+SAL_MONTAD', 'Descrição/Montadora');
  Configurador.pAdicionarIndice('SAL_CODPRO', 'Código');
  Configurador.pAdicionarIndice('SAL_MONTAD', 'Montadora');
  Configurador.pAdicionarIndice('SAL_LINHA_', 'Linha');
  Configurador.pAdicionarIndice('SAL_CODSEQ', 'Cód Seq');

  Configurador.pAdicionarCampoDescricao('SAL_DESCRI');
  Configurador.pAdicionarCampoDescricao('SAL_CODPRO');
  Configurador.pAdicionarCampoDescricao('SAL_VARIAC');
end;

end.
