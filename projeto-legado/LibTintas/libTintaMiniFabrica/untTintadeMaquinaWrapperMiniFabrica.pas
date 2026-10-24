{******************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta MiniFabrica *}
{***************************************************************************AC*}
unit untTintadeMaquinaWrapperMiniFabrica;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperMiniFabrica = class(TAbstractTintadeMaquinaWrapper)
  public
    procedure Configurar(const configurador: IConfiguradorConsulta); override;
    function GetCampoAutoIncrem: String; override;
    function fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String; override;
    procedure pRestaurarPadrao(const configurador: IConfiguradorConsulta); override;
    function fGetSelectFrom(const configurador: IConfiguradorConsulta): String; override;
    function GetNomeTabela: String; override;
    function GetConsultaComp(strTabPre: String): IConsultaComp; override;
    function fGetWhere: String; override;
    function GetLinhaAutomotiva : string; override;
  end;

implementation

uses
{$IFNDEF LINUX}
  untConsultaCompMiniFabrica,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory, untIDataSet;

{ TTintadeMaquinaWrapperMiniFabrica }

procedure TTintadeMaquinaWrapperMiniFabrica.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  configurador.pAdicionarCampo('MIF_CODIGO', 'Código'                  , 'LIKE');
  configurador.pAdicionarCampo('MIF_DESCRI', 'Descrição'               , 'LIKE');
  configurador.pAdicionarCampo('MIF_ANOCOR', 'Ano'                     , 'LIKE');
  configurador.pAdicionarCampo('MIF_MONTAD', 'Montadora'               , 'LIKE');
  configurador.pAdicionarCampo('MIF_REFERE', 'Referência'              , 'LIKE');
  configurador.pAdicionarCampo('MIF_CODCLI', 'Código Cliente'          , 'LIKE');
  configurador.pAdicionarCampo('MIF_CLIENT', 'Cliente'                 , 'LIKE');
  configurador.pAdicionarCampo('MIF_LINHA_', 'Linha'                   , 'LIKE');
  configurador.pAdicionarCampo('MIF_DTACAD', 'Data Cadastro'           , 'LIKE');
  configurador.pAdicionarCampo('MIF_ORIGEM', 'Origem'                  , 'LIKE');
  configurador.pAdicionarCampo('MIF_PADREF', 'Tipo da Fórmula'         , 'LIKE');
  configurador.pAdicionarCampo('MIF_ESPDEM', 'Espessura por Demão'     , 'LIKE');
  configurador.pAdicionarCampo('MIF_ESPSEC', 'Espessura Seca'          , 'LIKE');
  configurador.pAdicionarCampo('MIF_CATALI', 'Catálise'                , 'LIKE');
  configurador.pAdicionarCampo('MIF_ITEMCB', 'Componente B'            , 'LIKE');
  configurador.pAdicionarCampo('MIF_ITEMCC', 'Componente C'            , 'LIKE');
  configurador.pAdicionarCampo('MIF_OBSERV', 'Observação'              , 'LIKE');
  configurador.pAdicionarCampo('MIF_ACRMOB', 'Acréscimo de mão de obra', 'LIKE', False, False);
  configurador.pAdicionarCampo('MIF_MD5KEY', 'MIF_MD5KEY'              , 'LIKE', False, True);
  configurador.pAdicionarCampo('MIF_BRIL20', 'Brilho (20)', 'LIKE', False, False);
  configurador.pAdicionarCampo('MIF_BRIL60', 'Brilho (60)', 'LIKE', False, False);
  configurador.pAdicionarCampo('MIF_BRIL85', 'Brilho (85)', 'LIKE', False, False);
  configurador.pAdicionarCampo('MIF_SECAGD', 'Secagem D', 'LIKE', False, False);
  configurador.pAdicionarCampo('MIF_SECAGM', 'Secagem M', 'LIKE', False, False);
  configurador.pAdicionarCampo('MIF_SECAGT', 'Secagem T', 'LIKE', False, False);
  configurador.pAdicionarCampo('MIF_TMPCF4', 'Tempo Viscosidade', 'LIKE', False, False);

  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('MIF_BASE' + TStrUtils.fStrZero(intCont, 2), 'MIF_BASE' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
    configurador.pAdicionarCampo('MIF_QTDC' + TStrUtils.fStrZero(intCont, 2), 'MIF_QTDC' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
    configurador.pAdicionarCampo('MIF_QTDD' + TStrUtils.fStrZero(intCont, 2), 'MIF_QTDD' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperMiniFabrica.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador) +
    ' AND UPPER(IFNULL(MIF_ATIVAD, "S")) = "S" ';
end;

function TTintadeMaquinaWrapperMiniFabrica.fGetSelectFrom(
  const configurador: IConfiguradorConsulta): String;
begin
  Result := 'MIF_CADMIF A';
end;

function TTintadeMaquinaWrapperMiniFabrica.fGetWhere: String;
Var
  strLinha: String;
begin
  strLinha := GetLinhaAutomotiva;

  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(MIF_ATIVAD, "S")) = "S" ';

  If Not TStrUtils.fEmptyStr(strLinha) Then
    Result := Result + '   AND MIF_LINHA_ = ' + QuotedStr(strLinha) + ' ';
end;

function TTintadeMaquinaWrapperMiniFabrica.GetCampoAutoIncrem: String;
begin
  Result := 'A.AUTOINCREM';
end;

function TTintadeMaquinaWrapperMiniFabrica.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompMiniFabrica.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperMiniFabrica.GetLinhaAutomotiva: string;
Var
  qryGen   : IDataSet;
  arrOpcoes: Array Of String;
  intOpcao : Integer;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT DISTINCT LIN_DESCRI FROM MIF_CADLIN ORDER BY LIN_CODLIN    ';
  qryGen.Open;
  qryGen.First;

  While not qryGen.Eof Do
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := qryGen.FieldbyName('LIN_DESCRI').AsString;
    qryGen.Next;
  End;

{$IFNDEF LINUX}
  If Length(arrOpcoes) > 1 Then
  Begin
    intOpcao := TAutcomTintaFactory.Get.fGetMenu('Linhas Mini Fábrica', arrOpcoes, 1, True);
    If intOpcao > 0 Then
      Result   := arrOpcoes[intOpcao-1]
    Else
      Result   := '';
  End
  Else
    Result := '';
{$ENDIF}
end;

function TTintadeMaquinaWrapperMiniFabrica.GetNomeTabela: String;
begin
  Result := 'MIF_CADMIF ';
end;

procedure TTintadeMaquinaWrapperMiniFabrica.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  configurador.fSetPos('MIF_CODIGO', 0);
  configurador.fSetPos('MIF_DESCRI', 1);
  configurador.fSetPos('MIF_ANOCOR', 2);
  configurador.fSetPos('MIF_MONTAD', 3);
  configurador.fSetPos('MIF_REFERE', 4);
  configurador.fSetPos('MIF_CLIENT', 5);
  configurador.fSetPos('MIF_LINHA_', 6);

  configurador.fSetVisivel('MIF_CODIGO', True);
  configurador.fSetVisivel('MIF_DESCRI', True);
  configurador.fSetVisivel('MIF_ANOCOR', True);
  configurador.fSetVisivel('MIF_MONTAD', True);
  configurador.fSetVisivel('MIF_REFERE', True);
  configurador.fSetVisivel('MIF_CLIENT', True);
  configurador.fSetVisivel('MIF_LINHA_', True);

  configurador.pAdicionarIndice('MIF_CODIGO', 'Código');
  configurador.pAdicionarIndice('MIF_DESCRI', 'Descrição');
  configurador.pAdicionarIndice('MIF_ANOCOR', 'Ano');
  configurador.pAdicionarIndice('MIF_MONTAD', 'Montadora');
  configurador.pAdicionarIndice('MIF_REFERE', 'Referência');
  configurador.pAdicionarIndice('MIF_CLIENT', 'Cliente');
  configurador.pAdicionarIndice('MIF_LINHA_', 'Linha');

  configurador.pAdicionarCampoDescricao('MIF_CODIGO');
  configurador.pAdicionarCampoDescricao('MIF_DESCRI');
  configurador.pAdicionarCampoDescricao('MIF_ANOCOR');
  configurador.pAdicionarCampoDescricao('MIF_MONTAD');
  configurador.pAdicionarCampoDescricao('MIF_REFERE');
  configurador.pAdicionarCampoDescricao('MIF_CLIENT');
  configurador.pAdicionarCampoDescricao('MIF_LINHA_');
end;

end.

