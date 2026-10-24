{********************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta Starmix *}
{*****************************************************************************AC*}
unit untTintadeMaquinaWrapperStarmix;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils, StrUtils;

type
  TTintadeMaquinaWrapperStarmix = class(TAbstractTintadeMaquinaWrapper)
  public
    procedure Configurar(const configurador: IConfiguradorConsulta); override;
    function GetCampoAutoIncrem: String; override;
    function fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String; override;
    procedure pRestaurarPadrao(const configurador: IConfiguradorConsulta); override;
    function fGetSelectFrom(const configurador: IConfiguradorConsulta): String; override;
    function GetNomeTabela: String; override;
    function GetConsultaComp(strTabPre: String): IConsultaComp; override;
    function fGetWhere: String; override;
//    function GetLinhaAutomotiva: String; override;

  end;

implementation

uses
{$IFNDEF LINUX}
  untConsultaCompStarmix,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory, untIDataSet;

{ TTintadeMaquinaWrapperStarmix }

procedure TTintadeMaquinaWrapperStarmix.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  configurador.pAdicionarCampo('STA_CODSEQ', 'Código', 'LIKE');
  configurador.pAdicionarCampo('STA_NOMCOR', 'Descrição', 'LIKE');
  configurador.pAdicionarCampo('STA_DTACAD', 'Data Cadastro','LIKE');
  configurador.pAdicionarCampo('STA_CODLIN', 'Código da linha', 'LIKE');
  configurador.pAdicionarCampo('STA_DESLIN', 'Linha', 'LIKE');
  configurador.pAdicionarCampo('STA_CODMON', 'Código da montadora', 'LIKE', False, False);
  configurador.pAdicionarCampo('STA_MONTAD', 'Montadora', 'LIKE');
  configurador.pAdicionarCampo('STA_UNIVER', 'Cod. Universal', 'LIKE');
  configurador.pAdicionarCampo('STA_ANOCOR', 'Ano', 'LIKE');
  configurador.pAdicionarCampo('STA_PESCOR', 'Peso da cor', 'LIKE', False, False);
  configurador.pAdicionarCampo('STA_PESFOR', 'Peso do fornecedor', 'LIKE', False, False);
  configurador.pAdicionarCampo('STA_DESLIN', 'Descrição da linha', 'LIKE', False, False);
  configurador.pAdicionarCampo('STA_ACRMOB', 'Acréscimo mão de obra', 'LIKE', False, False);
  configurador.pAdicionarCampo('STA_MD5KEY', 'Md5key', 'LIKE', False, True);

  for intCont := 1 to 20 do
  begin
    configurador.pAdicionarCampo('STA_CODB' + TStrUtils.fStrZero(intCont, 2),  'STA_CODB' + TStrUtils.fStrZero(intCont, 2),
          'LIKE', False, False);

    configurador.pAdicionarCampo('STA_QTDB' + TStrUtils.fStrZero(intCont, 2),  'STA_QTDB' + TStrUtils.fStrZero(intCont, 2),
          '=', False, False);
  end;
end;

function TTintadeMaquinaWrapperStarmix.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador) +
    ' AND UPPER(IFNULL(STA_ATIVAD, "S")) = "S" ';
end;

function TTintadeMaquinaWrapperStarmix.fGetSelectFrom(
  const configurador: IConfiguradorConsulta): String;
begin
  Result := GetNomeTabela;
end;

function TTintadeMaquinaWrapperStarmix.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(STA_ATIVAD, "S")) = "S" ';
//  Result := Result + '   AND STA_CODLIN = '+ QuotedStr(Copy(GetLinhaAutomotiva,0, 3)) + ' ';
end;

function TTintadeMaquinaWrapperStarmix.GetCampoAutoIncrem: String;
begin
  Result := 'AUTOINCREM';
end;

function TTintadeMaquinaWrapperStarmix.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompStarmix.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),Self);
{$ENDIF}
end;

{function TTintadeMaquinaWrapperStarmix.GetLinhaAutomotiva: String;
Var
  qryGen   : IDataSet;
  arrOpcoes: Array Of String;
  intOpcao : Integer;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT CONCAT(LIN_CODLIN," - ",LIN_DESLIN) LINHA '+
                '   FROM STA_CADLIN '+
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
    intOpcao := TAutcomTintaFactory.Get.fGetMenu('Linha', arrOpcoes, 1);
    Result   := Trim(LeftStr(arrOpcoes[intOpcao-1], 3));
  End
  Else If Length(arrOpcoes) = 1 then
  Begin
    intOpcao := 1;
    Result   := Trim(LeftStr(arrOpcoes[intOpcao-1], 3));
  End;

end;
}
function TTintadeMaquinaWrapperStarmix.GetNomeTabela: String;
begin
  Result := 'STA_CADSTA';
end;

procedure TTintadeMaquinaWrapperStarmix.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  configurador.fSetPos('STA_NOMCOR', 0);
  configurador.fSetPos('STA_CODLIN', 1);
  configurador.fSetPos('STA_DESLIN', 1);
  configurador.fSetPos('STA_MONTAD', 2);
  configurador.fSetPos('STA_UNIVER', 3);
  configurador.fSetPos('STA_CODSEQ', 4);

  configurador.fSetVisivel('STA_NOMCOR', True);
  configurador.fSetVisivel('STA_CODLIN', True);
  configurador.fSetVisivel('STA_DESLIN', True);
  configurador.fSetVisivel('STA_MONTAD', True);
  configurador.fSetVisivel('STA_UNIVER', True);
  configurador.fSetVisivel('STA_CODSEQ', True);;

  configurador.pAdicionarIndice('STA_NOMCOR', 'Descrição');
  configurador.pAdicionarIndice('STA_CODLIN', 'Código da linha');
  configurador.pAdicionarIndice('STA_DESLIN', 'Linha');
  configurador.pAdicionarIndice('STA_MONTAD', 'Montadora');
  configurador.pAdicionarIndice('STA_UNIVER', 'Cod. Universal');
  configurador.pAdicionarIndice('STA_CODSEQ', 'Código');

  configurador.pAdicionarCampoDescricao('STA_NOMCOR');
  configurador.pAdicionarCampoDescricao('STA_CODLIN');
  configurador.pAdicionarCampoDescricao('STA_DESLIN');
  configurador.pAdicionarCampoDescricao('STA_MONTAD');
  configurador.pAdicionarCampoDescricao('STA_UNIVER');
  configurador.pAdicionarCampoDescricao('STA_CODSEQ');
end;

end.
