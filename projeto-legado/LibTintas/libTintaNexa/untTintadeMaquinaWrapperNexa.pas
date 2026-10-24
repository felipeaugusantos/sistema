{****************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta NEX *}
{*************************************************************************************AC*}
unit untTintadeMaquinaWrapperNexa;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils, System.StrUtils;

type
  TTintadeMaquinaWrapperNexa = class(TAbstractTintadeMaquinaWrapper)
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

    function GetEscolherSistemaAutomotivo(strTipo : String) : String;
  end;

implementation

uses
{$IFNDEF LINUX}
  untConsultaCompNexa,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory, untIDataSet;

{ TTintadeMaquinaWrapperNexa }

procedure TTintadeMaquinaWrapperNexa.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  configurador.pAdicionarCampo('NEX_DESCOR', 'Descrição', 'LIKE');
  configurador.pAdicionarCampo('NEX_TIPO__', 'Tipo', 'LIKE');
  configurador.pAdicionarCampo('BAS_TIPO__', 'Produto', 'LIKE');
  configurador.pAdicionarCampo('MON_DESCRI', 'Montadora', 'LIKE');
  configurador.pAdicionarCampo('NEX_VEICUL', 'Modelos', 'LIKE');
  configurador.pAdicionarCampo('SUBSTR(NEX_A_N_O_, 1, 4)', 'Ano Inicial', 'LIKE');
  configurador.pAdicionarCampo('SUBSTR(NEX_A_N_O_, 6, 4)', 'Ano Final', 'LIKE');
  configurador.pAdicionarCampo('NEX_CODCOR', 'Código', 'LIKE');
  configurador.pAdicionarCampo('NEX_CODATC', 'Código NEX', 'LIKE');
  configurador.pAdicionarCampo('NEX_MONTAD', 'Cód. Montadora', 'LIKE', False, False);
  configurador.pAdicionarCampo('NEX_A_N_O_', 'Ano', 'LIKE', False, False);
  configurador.pAdicionarCampo('NEX_MD5KEY', 'NEX_MD5KEY', '=', False, True);
  configurador.pAdicionarCampo('NEX_VARIAN', 'Variante Cor', 'LIKE');
  configurador.pAdicionarCampo('NEX_REFERE', 'Referência', 'LIKE');
  configurador.pAdicionarCampo('NEX_SISTEM', 'Sistema', 'LIKE');
  configurador.pAdicionarCampo('NEX_PAISES', 'País', 'LIKE');
  configurador.pAdicionarCampo('NEX_ORIGEM', 'Origem', 'LIKE');
  configurador.pAdicionarCampo('NEX_UTILIZ', 'Utilização', 'LIKE');
  configurador.pAdicionarCampo('NEX_EFEFIN', 'Efeito Final', 'LIKE');
  configurador.pAdicionarCampo('NEX_ACRMOB', 'Acréscimo mão de obra', 'LIKE', False, False);


  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('NEX_CODB' + TStrUtils.fStrZero(intCont, 2), 'NEX_CODB' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
    configurador.pAdicionarCampo('NEX_QTDB' + TStrUtils.fStrZero(intCont, 2), 'NEX_QTDB' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperNexa.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador) +
    ' AND UPPER(IFNULL(NEX_ATIVO_, "S")) = "S" ';
end;

function TTintadeMaquinaWrapperNexa.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result := Result + '  NEX_CADNEX  ';
  Result := Result + '  LEFT JOIN NEX_CADMON ON NEX_MONTAD = MON_CODMON ';
  Result := Result + ' INNER JOIN NEX_CADBAS ON NEX_CODB01 = BAS_CODBAS ';
  Result := Result + '                      AND IFNULL(NEX_ATIVO_, "S") = "S" ';

end;

function TTintadeMaquinaWrapperNexa.fGetWhere: String;
Var
  strTipo : String;
  strSistema: String;
begin
  strTipo := GetLinhaAutomotiva;

  Result := Result + ' WHERE IFNULL(NEX_ATIVO_, "S") = "S" ';

  If Not TStrUtils.fEmptyStr(strTipo) Then
  Begin
    Result := Result + '   AND NEX_TIPO__ = '+ QuotedStr(strTipo) + ' ';

    strSistema := GetEscolherSistemaAutomotivo(strTipo);

    If Not TStrUtils.fEmptyStr(strSistema) Then
      Result := Result + '   AND NEX_SISTEM = '+ QuotedStr(strSistema) + ' ';
  End;
end;

function TTintadeMaquinaWrapperNexa.GetCampoAutoIncrem: String;
begin
  Result := 'NEX_CADNEX.AUTOINCREM';
end;

function TTintadeMaquinaWrapperNexa.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompNexa.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),Self);
{$ENDIF}
end;

function TTintadeMaquinaWrapperNexa.GetLinhaAutomotiva: String;
Var
  qryGen   : IDataSet;
  arrOpcoes: Array Of String;
  intOpcao : Integer;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT DISTINCT      '+
                '        NEX_TIPO__    '+
                '   FROM NEX_CADNEX    '+
                '  ORDER BY NEX_TIPO__ ';
  qryGen.Open;

  qryGen.First;

  While not qryGen.Eof Do
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := qryGen.FieldbyName('NEX_TIPO__').AsString;

    qryGen.Next;
  end;


{$IFNDEF LINUX}
  If Length(arrOpcoes) >= 2 Then
  Begin
    intOpcao := TAutcomTintaFactory.Get.fGetMenu('Tipo', arrOpcoes, 1, True);
    If intOpcao > 0 Then
      Result   := arrOpcoes[intOpcao-1]
    Else
      Result   := '';
  End
  Else If Length(arrOpcoes) = 1 then
  Begin
    intOpcao := 1;
    Result   := arrOpcoes[intOpcao-1];
  End;
{$ENDIF}
end;

function TTintadeMaquinaWrapperNexa.GetNomeTabela: String;
begin
  Result := 'NEX_CADNEX ';
end;

function TTintadeMaquinaWrapperNexa.GetEscolherSistemaAutomotivo(strTipo : String): String;
Var
  qryGen   : IDataSet;
  arrOpcoes: Array Of String;
  intOpcao : Integer;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT DISTINCT          ' +
                '   NEX_SISTEM             ' +
                ' FROM                     ' +
                '   NEX_CADNEX             ' +
                ' WHERE NEX_TIPO__ = :TIPO ';
  qryGen.ParamByName('TIPO').AsString := strTipo;
  qryGen.Open;

  qryGen.First;

  While not qryGen.Eof Do
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := qryGen.FieldbyName('NEX_SISTEM').AsString;

    qryGen.Next;
  end;

{$IFNDEF LINUX}
  If Length(arrOpcoes) >= 2 Then
  Begin
    intOpcao := TAutcomTintaFactory.Get.fGetMenu('Sistema', arrOpcoes, 1, True);
    If intOpcao > 0 Then
      Result   := arrOpcoes[intOpcao-1]
    Else
      Result   := '';
  End
  Else If Length(arrOpcoes) = 1 then
  Begin
    intOpcao := 1;
    Result   := arrOpcoes[intOpcao-1];
  End;
{$ENDIF}
end;

procedure TTintadeMaquinaWrapperNexa.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  configurador.fSetPos('NEX_DESCOR', 0);
  configurador.fSetPos('MON_DESCRI', 1);
  configurador.fSetPos('NEX_SISTEM', 2);
  configurador.fSetPos('NEX_PAISES', 2);
  configurador.fSetPos('NEX_VARIAN', 4);
  configurador.fSetPos('SUBSTR(NEX_A_N_O_, 1, 4)', 5);
  configurador.fSetPos('SUBSTR(NEX_A_N_O_, 6, 4)', 6);
  configurador.fSetPos('NEX_CODATC, 9), 4)', 7);

  configurador.fSetPos('NEX_TIPO__', 8);
  configurador.fSetPos('BAS_TIPO__', 9);
  configurador.fSetPos('NEX_VEICUL', 10);
  configurador.fSetPos('NEX_CODCOR, 9), 4)', 11);
  configurador.fSetPos('NEX_REFERE', 12);
  configurador.fSetPos('NEX_ORIGEM', 13);
  configurador.fSetPos('NEX_UTILIZ', 14);
  configurador.fSetPos('NEX_EFEFIN', 15);


  configurador.fSetVisivel('NEX_DESCOR', True);
  configurador.fSetVisivel('MON_DESCRI', True);
  configurador.fSetVisivel('NEX_SISTEM', True);
  configurador.fSetVisivel('NEX_PAISES', True);
  configurador.fSetVisivel('NEX_VARIAN', True);
  configurador.fSetVisivel('SUBSTR(NEX_A_N_O_, 1, 4)', True);
  configurador.fSetVisivel('SUBSTR(NEX_A_N_O_, 6, 4)', True);
  configurador.fSetVisivel('NEX_CODATC', True);
  configurador.fSetVisivel('NEX_TIPO__', True);

  configurador.fSetVisivel('BAS_TIPO__', False);
  configurador.fSetVisivel('NEX_VEICUL', False);
  configurador.fSetVisivel('NEX_CODCOR', False);
  configurador.fSetVisivel('NEX_REFERE', False);
  configurador.fSetVisivel('NEX_ORIGEM', False);
  configurador.fSetVisivel('NEX_UTILIZ', False);
  configurador.fSetVisivel('NEX_EFEFIN', False);

  configurador.pAdicionarIndice('NEX_DESCOR+MON_DESCRI+SUBSTR(NEX_A_N_O_, 1, 4)', 'Descrição/Montadora/Ano Inicial');
  configurador.pAdicionarIndice('NEX_CODATC', 'Código NEX');
  configurador.pAdicionarIndice('NEX_DESCOR+NEX_VARIAN', 'Descrição/Variante Cor');

  configurador.pAdicionarCampoDescricao('NEX_DESCOR');
  configurador.pAdicionarCampoDescricao('MON_DESCRI');
  configurador.pAdicionarCampoDescricao('NEX_SISTEM');
  configurador.pAdicionarCampoDescricao('NEX_VARIAN');
  configurador.pAdicionarCampoDescricao('SUBSTR(NEX_A_N_O_, 1, 4)');
  configurador.pAdicionarCampoDescricao('SUBSTR(NEX_A_N_O_, 6, 4)');
  configurador.pAdicionarCampoDescricao('NEX_CODATC');
end;

end.
