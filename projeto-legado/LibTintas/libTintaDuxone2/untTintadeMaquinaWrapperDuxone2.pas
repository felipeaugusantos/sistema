{*****************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta Duxone2  *}
{**************************************************************************AC*}
unit untTintadeMaquinaWrapperDuxone2;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperDuxone2 = class(TAbstractTintadeMaquinaWrapper)
  public
    procedure Configurar(const configurador: IConfiguradorConsulta); override;
    function GetCampoAutoIncrem: String; override;
    function fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String; override;
    procedure pRestaurarPadrao(const configurador: IConfiguradorConsulta); override;
    function fGetSelectFrom(const configurador: IConfiguradorConsulta): String; override;
    function GetNomeTinta: String; override;
    function GetNomeForm: String; override;
    function GetNomeTabela: String; override;
    function GetConsultaComp(strTabPre: String): IConsultaComp; override;
    function fGetWhere: String; override;
  end;

implementation

uses
{$IFNDEF LINUX}
  untConsultaCompDuxone2,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperDuxone2 }

procedure TTintadeMaquinaWrapperDuxone2.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  configurador.pAdicionarCampo('DU2_CODDU2', 'Código', 'LIKE');
  configurador.pAdicionarCampo('DU2_CODOEM', 'Código Oem', 'LIKE');
  configurador.pAdicionarCampo('DU2_LINHA_', 'Linha', 'LIKE');
  configurador.pAdicionarCampo('DU2_DESLIN', 'Descrição Linha', 'LIKE');
  configurador.pAdicionarCampo('DU2_QUALID', 'Qualidade', 'LIKE');
  configurador.pAdicionarCampo('DU2_ALTERN', 'Alternativa', 'LIKE');
  configurador.pAdicionarCampo('DU2_REGIAO', 'Região', 'LIKE');
  configurador.pAdicionarCampo('DU2_DESCRI', 'Descrição', 'LIKE');
  configurador.pAdicionarCampo('DU2_MONTAD', 'Montadora', 'LIKE');
  configurador.pAdicionarCampo('DU2_ANOCOR', 'Ano', 'LIKE');
  configurador.pAdicionarCampo('DU2_LITRAG', 'Volume', 'LIKE');
  configurador.pAdicionarCampo('DU2_DTACAD', 'Data Cadastro', 'LIKE');
  configurador.pAdicionarCampo('DU2_CODSEQ', 'DU2_CODSEQ', 'LIKE', False, False);
  configurador.pAdicionarCampo('DU2_PROCHA', 'Produto Chapinha', 'LIKE', False, False);
  configurador.pAdicionarCampo('DU2_CODNFM', 'DU2_CODNFM', 'LIKE', False, False);
  configurador.pAdicionarCampo('DU2_MD5KEY', 'DU2_MD5KEY', 'LIKE', False, True);
  configurador.pAdicionarCampo('DU2_ACRMOB', 'Acréscimo mão de obra', 'LIKE', False, False);
  configurador.pAdicionarCampo('DU2_OBSERV', 'Observação', 'LIKE');

  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('DU2_BASE' + TStrUtils.fStrZero(intCont, 2), 'DU2_BASE' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
    configurador.pAdicionarCampo('DU2_QTDC' + TStrUtils.fStrZero(intCont, 2), 'DU2_QTDC' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
    configurador.pAdicionarCampo('DU2_TIPB' + TStrUtils.fStrZero(intCont, 2), 'DU2_TIPB' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperDuxone2.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador) +
    ' AND UPPER(IFNULL(DU2_ATIVO_, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperDuxone2.fGetSelectFrom(
  const configurador: IConfiguradorConsulta): String;
begin
  Result := GetNomeTabela;
end;

function TTintadeMaquinaWrapperDuxone2.fGetWhere: String;
begin
  Result := ' WHERE TRUE AND UPPER(IFNULL(DU2_ATIVO_, ''S'')) = ''S'' '
end;

function TTintadeMaquinaWrapperDuxone2.GetCampoAutoIncrem: String;
begin
  Result := 'AUTOINCREM';
end;

function TTintadeMaquinaWrapperDuxone2.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompDuxone2.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperDuxone2.GetNomeForm: String;
begin
  Result := 'Duxone2Global';
end;

function TTintadeMaquinaWrapperDuxone2.GetNomeTabela: String;
begin
  Result := 'DU2_CADDU2';
end;

function TTintadeMaquinaWrapperDuxone2.GetNomeTinta: String;
begin
  Result := 'Duxone Global';
end;

procedure TTintadeMaquinaWrapperDuxone2.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  configurador.fSetPos('DU2_CODDU2', 0);
  configurador.fSetPos('DU2_ALTERN', 1);
  configurador.fSetPos('DU2_REGIAO', 2);
  configurador.fSetPos('DU2_DESCRI', 3);
  configurador.fSetPos('DU2_CODOEM', 4);
  configurador.fSetPos('DU2_MONTAD', 5);
  configurador.fSetPos('DU2_ANOCOR', 6);
  configurador.fSetPos('DU2_LINHA_', 7);
  configurador.fSetPos('DU2_QUALID', 8);
  configurador.fSetPos('DU2_DTACAD', 9);

  configurador.fSetVisivel('DU2_CODDU2', True);
  configurador.fSetVisivel('DU2_ALTERN', True);
  configurador.fSetVisivel('DU2_REGIAO', True);
  configurador.fSetVisivel('DU2_DESCRI', True);
  configurador.fSetVisivel('DU2_CODOEM', True);
  configurador.fSetVisivel('DU2_MONTAD', True);
  configurador.fSetVisivel('DU2_ANOCOR', True);
  configurador.fSetVisivel('DU2_LINHA_', True);
  configurador.fSetVisivel('DU2_QUALID', True);
  configurador.fSetVisivel('DU2_DTACAD', True);

  configurador.pAdicionarIndice('DU2_DESCRI+DU2_QUALID+DU2_REGIAO', 'Descrição/Qualidade/Região');
  configurador.pAdicionarIndice('DU2_MONTAD', 'Montadora');
  configurador.pAdicionarIndice('DU2_CODDU2', 'Código');
  configurador.pAdicionarIndice('DU2_CODOEM', 'Código Oem');
  configurador.pAdicionarIndice('DU2_DTACAD', 'Data Cadastro');

  configurador.pAdicionarCampoDescricao('DU2_DESCRI');
  configurador.pAdicionarCampoDescricao('DU2_MONTAD');
  configurador.pAdicionarCampoDescricao('DU2_QUALID');
  configurador.pAdicionarCampoDescricao('DU2_CODDU2');
end;

end.
