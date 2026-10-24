{********************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta StarmixWeb *}
{*****************************************************************************AC*}
unit untTintadeMaquinaWrapperStarmixWeb;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils, StrUtils;

type
  TTintadeMaquinaWrapperStarmixWeb = class(TAbstractTintadeMaquinaWrapper)
  public
    procedure Configurar(const configurador: IConfiguradorConsulta); override;
    function GetCampoAutoIncrem: String; override;
    function fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String; override;
    procedure pRestaurarPadrao(const configurador: IConfiguradorConsulta); override;
    function fGetSelectFrom(const configurador: IConfiguradorConsulta): String; override;
    function GetNomeTabela: String; override;
    function GetConsultaComp(strTabPre: String): IConsultaComp; override;
    function fGetWhere: String; override;
    function GetLinhaAutomotiva: String; override;

  end;

implementation

uses
{$IFNDEF LINUX}
  untConsultaCompStarmixWeb,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory,
  untIDataSet;

{ TTintadeMaquinaWrapperStarmixWeb }

procedure TTintadeMaquinaWrapperStarmixWeb.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  configurador.pAdicionarCampo('STW_CODIGO', 'Código', 'LIKE');
  configurador.pAdicionarCampo('STW_NOMCOR', 'Descrição', 'LIKE');
  configurador.pAdicionarCampo('STW_DTACAD', 'Data Cadastro','LIKE');
  configurador.pAdicionarCampo('STW_CODLIN', 'Código da linha', 'LIKE');
  configurador.pAdicionarCampo('STW_DESLIN', 'Linha', 'LIKE');
  configurador.pAdicionarCampo('STW_CODMON', 'Código da montadora', 'LIKE', False, False);
  configurador.pAdicionarCampo('STW_MONTAD', 'Montadora', 'LIKE');
  configurador.pAdicionarCampo('STW_UNIVER', 'Cod. Universal', 'LIKE');
  configurador.pAdicionarCampo('STW_ANOCOR', 'Ano', 'LIKE');
  configurador.pAdicionarCampo('STW_PESCOR', 'Peso da cor', 'LIKE', False, False);
  configurador.pAdicionarCampo('STW_PESFOR', 'Peso do fornecedor', 'LIKE', False, False);
  configurador.pAdicionarCampo('STW_DESLIN', 'Descrição da linha', 'LIKE', False, False);
  configurador.pAdicionarCampo('STW_ACRMOB', 'Acréscimo mão de obra', 'LIKE', False, False);
  configurador.pAdicionarCampo('STW_MD5KEY', 'Md5key', 'LIKE', False, True);

  for intCont := 1 to 20 do
  begin
    configurador.pAdicionarCampo('STW_CODB' + TStrUtils.fStrZero(intCont, 2),  'STW_CODB' + TStrUtils.fStrZero(intCont, 2),
          'LIKE', False, False);

    configurador.pAdicionarCampo('STW_QTDB' + TStrUtils.fStrZero(intCont, 2),  'STW_QTDB' + TStrUtils.fStrZero(intCont, 2),
          '=', False, False);
  end;
end;

function TTintadeMaquinaWrapperStarmixWeb.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador) +
    ' AND UPPER(IFNULL(STW_ATIVAD, "S")) = "S" ';
end;

function TTintadeMaquinaWrapperStarmixWeb.fGetSelectFrom(
  const configurador: IConfiguradorConsulta): String;
begin
  Result := GetNomeTabela;
end;

function TTintadeMaquinaWrapperStarmixWeb.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(STW_ATIVAD, "S")) = "S" ';
  Result := Result + '   AND STW_CODLIN = '+ QuotedStr(Copy(GetLinhaAutomotiva,0, 3)) + ' ';
end;

function TTintadeMaquinaWrapperStarmixWeb.GetCampoAutoIncrem: String;
begin
  Result := 'AUTOINCREM';
end;

function TTintadeMaquinaWrapperStarmixWeb.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompStarmixWeb.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperStarmixWeb.GetLinhaAutomotiva: String;
Var
  qryGen   : IDataSet;
  arrOpcoes: Array Of String;
  intOpcao : Integer;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT CONCAT(LIN_CODLIN," - ",LIN_DESLIN) LINHA '+
                '   FROM STW_CADLIN '+
                '  ORDER BY LIN_CODLIN ';

  qryGen.Open;

  qryGen.First;

  While not qryGen.Eof Do
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := qryGen.FieldbyName('LINHA').AsString;

    qryGen.Next;
  end;


  If Length(arrOpcoes) >= 2 Then
  Begin
  {$IFNDEF LINUX}
    intOpcao := TAutcomTintaFactory.Get.fGetMenu('Linha', arrOpcoes, 1);
  {$ENDIF}
    Result   := Trim(LeftStr(arrOpcoes[intOpcao-1], 3));
  End
  Else If Length(arrOpcoes) = 1 then
  Begin
    intOpcao := 1;
    Result   := Trim(LeftStr(arrOpcoes[intOpcao-1], 3));
  End;

end;

function TTintadeMaquinaWrapperStarmixWeb.GetNomeTabela: String;
begin
  Result := 'STW_CADSTW';
end;

procedure TTintadeMaquinaWrapperStarmixWeb.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  configurador.fSetPos('STW_NOMCOR', 0);
  configurador.fSetPos('STW_CODLIN', 1);
  configurador.fSetPos('STW_DESLIN', 1);
  configurador.fSetPos('STW_MONTAD', 2);
  configurador.fSetPos('STW_UNIVER', 3);
  configurador.fSetPos('STW_CODIGO', 4);

  configurador.fSetVisivel('STW_NOMCOR', True);
  configurador.fSetVisivel('STW_CODLIN', True);
  configurador.fSetVisivel('STW_DESLIN', True);
  configurador.fSetVisivel('STW_MONTAD', True);
  configurador.fSetVisivel('STW_UNIVER', True);
  configurador.fSetVisivel('STW_CODIGO', True);;

  configurador.pAdicionarIndice('STW_NOMCOR', 'Descrição');
  configurador.pAdicionarIndice('STW_CODLIN', 'Código da linha');
  configurador.pAdicionarIndice('STW_DESLIN', 'Linha');
  configurador.pAdicionarIndice('STW_MONTAD', 'Montadora');
  configurador.pAdicionarIndice('STW_UNIVER', 'Cod. Universal');
  configurador.pAdicionarIndice('STW_CODIGO', 'Código');

  configurador.pAdicionarCampoDescricao('STW_NOMCOR');
  configurador.pAdicionarCampoDescricao('STW_CODLIN');
  configurador.pAdicionarCampoDescricao('STW_DESLIN');
  configurador.pAdicionarCampoDescricao('STW_MONTAD');
  configurador.pAdicionarCampoDescricao('STW_UNIVER');
  configurador.pAdicionarCampoDescricao('STW_CODIGO');
end;

end.
