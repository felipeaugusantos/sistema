{******************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta TopCoat *}
{***************************************************************************AC*}
unit untTintadeMaquinaWrapperTopCoat;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperTopCoat = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompTopCoat,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory, untIDataSet;

{ TTintadeMaquinaWrapperTopCoat }

procedure TTintadeMaquinaWrapperTopCoat.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  configurador.pAdicionarCampo('COA_CODIGO', 'Código'                  , 'LIKE');
  configurador.pAdicionarCampo('COA_DESCRI', 'Descrição'               , 'LIKE');
  configurador.pAdicionarCampo('COA_ANOCOR', 'Ano'                     , 'LIKE');
  configurador.pAdicionarCampo('COA_MONTAD', 'Montadora'               , 'LIKE');
  configurador.pAdicionarCampo('COA_REFERE', 'Referência'              , 'LIKE');
  configurador.pAdicionarCampo('COA_CODCLI', 'Código Cliente'          , 'LIKE');
  configurador.pAdicionarCampo('COA_CLIENT', 'Cliente'                 , 'LIKE');
  configurador.pAdicionarCampo('COA_LINHA_', 'Linha'                   , 'LIKE');
  configurador.pAdicionarCampo('COA_DTACAD', 'Data Cadastro'           , 'LIKE');
  configurador.pAdicionarCampo('COA_ACRMOB', 'Acréscimo de mão de obra', 'LIKE', False, False);
  configurador.pAdicionarCampo('COA_MD5KEY', 'COA_MD5KEY'              , 'LIKE', False, True);


  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('COA_BASE' + TStrUtils.fStrZero(intCont, 2), 'COA_BASE' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
    configurador.pAdicionarCampo('COA_QTDC' + TStrUtils.fStrZero(intCont, 2), 'COA_QTDC' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
    configurador.pAdicionarCampo('COA_QTDD' + TStrUtils.fStrZero(intCont, 2), 'COA_QTDD' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperTopCoat.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador) +
    ' AND UPPER(IFNULL(COA_ATIVAD, "S")) = "S" ';
end;

function TTintadeMaquinaWrapperTopCoat.fGetSelectFrom(
  const configurador: IConfiguradorConsulta): String;
begin
  Result := 'COA_CADCOA A';
end;

function TTintadeMaquinaWrapperTopCoat.fGetWhere: String;
Var
  strLinha: String;
begin
  strLinha := GetLinhaAutomotiva;

  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(COA_ATIVAD, "S")) = "S" ';

  If Not TStrUtils.fEmptyStr(strLinha) Then
    Result := Result + '   AND COA_LINHA_ = ' + QuotedStr(strLinha) + ' ';
end;

function TTintadeMaquinaWrapperTopCoat.GetCampoAutoIncrem: String;
begin
  Result := 'A.AUTOINCREM';
end;

function TTintadeMaquinaWrapperTopCoat.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompTopCoat.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperTopCoat.GetLinhaAutomotiva: string;
Var
  qryGen   : IDataSet;
  arrOpcoes: Array Of String;
  intOpcao : Integer;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT DISTINCT LIN_DESCRI FROM COA_CADLIN ORDER BY LIN_CODLIN    ';
  qryGen.Open;
  qryGen.First;

  While not qryGen.Eof Do
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := qryGen.FieldbyName('LIN_DESCRI').AsString;
    qryGen.Next;
  End;

  If Length(arrOpcoes) > 1 Then
  Begin
  {$IFNDEF LINUX}
    intOpcao := TAutcomTintaFactory.Get.fGetMenu('Linhas Top Coat', arrOpcoes, 1, True);
  {$ENDIF}
    If intOpcao > 0 Then
      Result   := arrOpcoes[intOpcao-1]
    Else
      Result   := '';
  End
  Else
    Result := '';
end;

function TTintadeMaquinaWrapperTopCoat.GetNomeTabela: String;
begin
  Result := 'COA_CADCOA ';
end;

procedure TTintadeMaquinaWrapperTopCoat.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  configurador.fSetPos('COA_CODIGO', 0);
  configurador.fSetPos('COA_DESCRI', 1);
  configurador.fSetPos('COA_ANOCOR', 2);
  configurador.fSetPos('COA_MONTAD', 3);
  configurador.fSetPos('COA_REFERE', 4);
  configurador.fSetPos('COA_CLIENT', 5);
  configurador.fSetPos('COA_LINHA_', 6);

  configurador.fSetVisivel('COA_CODIGO', True);
  configurador.fSetVisivel('COA_DESCRI', True);
  configurador.fSetVisivel('COA_ANOCOR', True);
  configurador.fSetVisivel('COA_MONTAD', True);
  configurador.fSetVisivel('COA_REFERE', True);
  configurador.fSetVisivel('COA_CLIENT', True);
  configurador.fSetVisivel('COA_LINHA_', True);

  configurador.pAdicionarIndice('COA_CODIGO', 'Código');
  configurador.pAdicionarIndice('COA_DESCRI', 'Descrição');
  configurador.pAdicionarIndice('COA_ANOCOR', 'Ano');
  configurador.pAdicionarIndice('COA_MONTAD', 'Montadora');
  configurador.pAdicionarIndice('COA_REFERE', 'Referência');
  configurador.pAdicionarIndice('COA_CLIENT', 'Cliente');
  configurador.pAdicionarIndice('COA_LINHA_', 'Linha');

  configurador.pAdicionarCampoDescricao('COA_CODIGO');
  configurador.pAdicionarCampoDescricao('COA_DESCRI');
  configurador.pAdicionarCampoDescricao('COA_ANOCOR');
  configurador.pAdicionarCampoDescricao('COA_MONTAD');
  configurador.pAdicionarCampoDescricao('COA_REFERE');
  configurador.pAdicionarCampoDescricao('COA_CLIENT');
  configurador.pAdicionarCampoDescricao('COA_LINHA_');
end;

end.

