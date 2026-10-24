{******************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta Lazzumix *}
{***************************************************************************AC*}
unit untTintadeMaquinaWrapperLazzumix;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils, untIDataSet;

type
  TTintadeMaquinaWrapperLazzumix = class(TAbstractTintadeMaquinaWrapper)
  Private
    function fGetLinhaLazzumix(): String;
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
  untConsultaCompLazzumix,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperLazzumix }

procedure TTintadeMaquinaWrapperLazzumix.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  configurador.pAdicionarCampo('MIX_CODIGO', 'Código', 'LIKE');
  configurador.pAdicionarCampo('MIX_DESCRI', 'Descrição', 'LIKE');
  configurador.pAdicionarCampo('MIX_REFERE', 'Referência', 'LIKE');
  configurador.pAdicionarCampo('MIX_MONTAD', 'Montadora', 'LIKE');
  configurador.pAdicionarCampo('MIX_DTACAD', 'Data de Cadastro', 'LIKE');
  configurador.pAdicionarCampo('MIX_A_N_O_', 'Ano', 'LIKE');
  configurador.pAdicionarCampo('MIX_UNIVER', 'Código Universal', 'LIKE');
  configurador.pAdicionarCampo('MIX_VOLCON', 'Volume Concentrado', 'LIKE');
  configurador.pAdicionarCampo('MIX_VOLDIL', 'Volume Diluido', 'LIKE');
  configurador.pAdicionarCampo('MIX_VOLMID', 'Volume Minímo Diluído','LIKE', False, False);
  configurador.pAdicionarCampo('MIX_VOLMIC', 'Volume Minímo Concentrado','LIKE', False, False);
  configurador.pAdicionarCampo('MIX_ACRMOB', 'Acréscimo de mão de obra','LIKE',False,False);


  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('MIX_BASE' + TStrUtils.fStrZero(intCont, 2), 'MIX_BASE' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
    configurador.pAdicionarCampo('MIX_QTDC' + TStrUtils.fStrZero(intCont, 2), 'MIX_QTDC' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
    configurador.pAdicionarCampo('MIX_QTDD' + TStrUtils.fStrZero(intCont, 2), 'MIX_QTDD' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperLazzumix.fGetLinhaLazzumix: String;
Var
  LQryGen: IDataSet;
  LLinha: String;
  LOpcoes: Array Of String;
  LOpcao: Integer;
begin
  Result := '';

  LLinha := TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGet('LINLAZ');

  LQryGen := TAutcomTintaFactory.Get.fGetDataSet;
  LQryGen.SQL := '  SELECT DISTINCT MIX_REFERE FROM LAZ_CADMIX  ';
  LQryGen.Open;
  LQryGen.First;

  While Not LQryGen.Eof Do
  Begin
    If Pos(LQryGen.FieldByName('MIX_REFERE').AsString, LLinha) > 0 Then
    Begin
      SetLength(LOpcoes, Length(LOpcoes) + 1);
      LOpcoes[Length(LOpcoes)-1] := LQryGen.FieldByName('MIX_REFERE').AsString;
    End;

    LQryGen.Next;
  End;

  If Length(LOpcoes) >= 2 Then
  Begin
  {$IFNDEF LINUX}
    LOpcao := TAutcomTintaFactory.Get.fGetMenu('Linha', LOpcoes, 1, True);
  {$ENDIF}
    If LOpcao > 0 Then
      Result   := Trim(LOpcoes[LOpcao-1])
    Else
      Result   := '';
  End
  Else If Length(LOpcoes) = 1 then
  Begin
    LOpcao := 1;
    Result   := Trim(LOpcoes[LOpcao-1]);
  End;


end;

function TTintadeMaquinaWrapperLazzumix.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador) +
    ' AND UPPER(IFNULL(MIX_ATIVAD, "S")) = "S" ';
end;

function TTintadeMaquinaWrapperLazzumix.fGetSelectFrom(
  const configurador: IConfiguradorConsulta): String;
begin
  Result := GetNomeTabela;
end;

function TTintadeMaquinaWrapperLazzumix.fGetWhere: String;
Var
  LLinha: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(MIX_ATIVAD, "S")) = "S" ';

  LLinha := fGetLinhaLazzumix;
  If Not TStrUtils.fEmptyStr(LLinha) Then
    Result := Result + ' AND MIX_REFERE = "' + LLinha + '" ';
end;

function TTintadeMaquinaWrapperLazzumix.GetCampoAutoIncrem: String;
begin
  Result := 'AUTOINCREM';
end;

function TTintadeMaquinaWrapperLazzumix.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompLazzumix.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperLazzumix.GetNomeTabela: String;
begin
  Result := 'LAZ_CADMIX';
end;

procedure TTintadeMaquinaWrapperLazzumix.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  configurador.fSetPos('MIX_DESCRI', 0);
  configurador.fSetPos('MIX_CODIGO', 1);
  configurador.fSetPos('MIX_REFERE', 2);
  configurador.fSetPos('MIX_MONTAD', 3);
  configurador.fSetPos('MIX_A_N_O_', 4);
  configurador.fSetPos('MIX_UNIVER', 5);

  configurador.fSetVisivel('MIX_DESCRI', True);
  configurador.fSetVisivel('MIX_CODIGO', True);
  configurador.fSetVisivel('MIX_REFERE', True);
  configurador.fSetVisivel('MIX_MONTAD', True);
  configurador.fSetVisivel('MIX_A_N_O_', True);
  configurador.fSetVisivel('MIX_UNIVER', True);

  configurador.pAdicionarIndice('MIX_DESCRI', 'Descrição');
  configurador.pAdicionarIndice('MIX_CODIGO', 'Código');
  configurador.pAdicionarIndice('MIX_UNIVER', 'Código Universal');
  configurador.pAdicionarIndice('MIX_REFERE', 'Referência');

  configurador.pAdicionarCampoDescricao('MIX_DESCRI');
  configurador.pAdicionarCampoDescricao('MIX_REFERE');
  configurador.pAdicionarCampoDescricao('MIX_CODIGO');
end;

end.
