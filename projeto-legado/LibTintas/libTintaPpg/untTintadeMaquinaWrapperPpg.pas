{****************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta Ppg *}
{*************************************************************************************AC*}
unit untTintadeMaquinaWrapperPpg;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils, System.StrUtils;

type
  TTintadeMaquinaWrapperPpg = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompPpg,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory, untIDataSet;

{ TTintadeMaquinaWrapperPpg }

procedure TTintadeMaquinaWrapperPpg.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  configurador.pAdicionarCampo('PPG_DESCOR', 'Descrição', 'LIKE');
  configurador.pAdicionarCampo('PPG_TIPO__', 'Tipo', 'LIKE');
  configurador.pAdicionarCampo('BAS_TIPO__', 'Produto', 'LIKE');
  configurador.pAdicionarCampo('MON_DESCRI', 'Montadora', 'LIKE');
  configurador.pAdicionarCampo('PPG_VEICUL', 'Modelos', 'LIKE');
  configurador.pAdicionarCampo('SUBSTR(PPG_A_N_O_, 1, 4)', 'Ano Inicial', 'LIKE');
  configurador.pAdicionarCampo('SUBSTR(PPG_A_N_O_, 6, 4)', 'Ano Final', 'LIKE');
  configurador.pAdicionarCampo('PPG_CODCOR', 'Código', 'LIKE');
  configurador.pAdicionarCampo('PPG_CODATC', 'Código PPG', 'LIKE');
  configurador.pAdicionarCampo('PPG_MONTAD', 'Cód. Montadora', 'LIKE', False, False);
  configurador.pAdicionarCampo('PPG_A_N_O_', 'Ano', 'LIKE', False, False);
  configurador.pAdicionarCampo('PPG_MD5KEY', 'PPG_MD5KEY', '=', False, True);
  configurador.pAdicionarCampo('PPG_VARIAN', 'Variante Cor', 'LIKE');
  configurador.pAdicionarCampo('PPG_REFERE', 'Referência', 'LIKE');
  configurador.pAdicionarCampo('PPG_SISTEM', 'Sistema', 'LIKE');
  configurador.pAdicionarCampo('PPG_PAISES', 'País', 'LIKE');
  configurador.pAdicionarCampo('PPG_ORIGEM', 'Origem', 'LIKE');
  configurador.pAdicionarCampo('PPG_UTILIZ', 'Utilização', 'LIKE');
  configurador.pAdicionarCampo('PPG_EFEFIN', 'Efeito Final', 'LIKE');
  configurador.pAdicionarCampo('PPG_ACRMOB', 'Acréscimo mão de obra', 'LIKE', False, False);


  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('PPG_CODB' + TStrUtils.fStrZero(intCont, 2), 'PPG_CODB' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
    configurador.pAdicionarCampo('PPG_QTDB' + TStrUtils.fStrZero(intCont, 2), 'PPG_QTDB' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperPpg.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador) +
    ' AND UPPER(IFNULL(PPG_ATIVO_, "S")) = "S" ';
end;

function TTintadeMaquinaWrapperPpg.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result := Result + '  PPG_CADPPG  ';
  Result := Result + '  LEFT JOIN PPG_CADMON ON PPG_MONTAD = MON_CODMON ';
  Result := Result + ' INNER JOIN PPG_CADBAS ON PPG_CODB01 = BAS_CODBAS ';
  Result := Result + '                      AND IFNULL(PPG_ATIVO_, "S") = "S" ';

end;

function TTintadeMaquinaWrapperPpg.fGetWhere: String;
Var
  strTipo : String;
  strSistema: String;
begin
  strTipo := GetLinhaAutomotiva;

  Result := Result + ' WHERE IFNULL(PPG_ATIVO_, "S") = "S" ';

  If Not TStrUtils.fEmptyStr(strTipo) Then
  Begin
    Result := Result + '   AND PPG_TIPO__ = '+ QuotedStr(strTipo) + ' ';

    strSistema := GetEscolherSistemaAutomotivo(strTipo);

    If Not TStrUtils.fEmptyStr(strSistema) Then
      Result := Result + '   AND PPG_SISTEM = '+ QuotedStr(strSistema) + ' ';
  End;
end;

function TTintadeMaquinaWrapperPpg.GetCampoAutoIncrem: String;
begin
  Result := 'PPG_CADPPG.AUTOINCREM';
end;

function TTintadeMaquinaWrapperPpg.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompPpg.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),Self);
{$ENDIF}
end;

function TTintadeMaquinaWrapperPpg.GetLinhaAutomotiva: String;
Var
  qryGen   : IDataSet;
  arrOpcoes: Array Of String;
  intOpcao : Integer;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT DISTINCT BAS_TIPO__ '+
                '   FROM PPG_CADBAS          '+
                '  ORDER BY BAS_TIPO__       ';

  qryGen.Open;

  qryGen.First;

  While not qryGen.Eof Do
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := qryGen.FieldbyName('BAS_TIPO__').AsString;

    qryGen.Next;
  end;

  If Length(arrOpcoes) >= 2 Then
  Begin
  {$IFNDEF LINUX}
    intOpcao := TAutcomTintaFactory.Get.fGetMenu('Tipo', arrOpcoes, 1, True);
  {$ENDIF}
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


end;

function TTintadeMaquinaWrapperPpg.GetNomeTabela: String;
begin
  Result := 'PPG_CADPPG ';
end;

function TTintadeMaquinaWrapperPpg.GetEscolherSistemaAutomotivo(strTipo : String): String;
Var
  qryGen   : IDataSet;
  arrOpcoes: Array Of String;
  intOpcao : Integer;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT DISTINCT          ' +
                '   PPG_SISTEM             ' +
                ' FROM                     ' +
                '   PPG_CADPPG             ' +
                ' WHERE PPG_TIPO__ = :TIPO ';
  qryGen.ParamByName('TIPO').AsString := strTipo;
  qryGen.Open;

  qryGen.First;

  While not qryGen.Eof Do
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := qryGen.FieldbyName('PPG_SISTEM').AsString;

    qryGen.Next;
  end;


  If Length(arrOpcoes) >= 2 Then
  Begin
  {$IFNDEF LINUX}
    intOpcao := TAutcomTintaFactory.Get.fGetMenu('Sistema', arrOpcoes, 1, True);
  {$ENDIF}
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

end;

procedure TTintadeMaquinaWrapperPpg.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  configurador.fSetPos('PPG_DESCOR', 0);
  configurador.fSetPos('MON_DESCRI', 1);
  configurador.fSetPos('PPG_SISTEM', 2);
  configurador.fSetPos('PPG_PAISES', 2);
  configurador.fSetPos('PPG_VARIAN', 4);
  configurador.fSetPos('SUBSTR(PPG_A_N_O_, 1, 4)', 5);
  configurador.fSetPos('SUBSTR(PPG_A_N_O_, 6, 4)', 6);
  configurador.fSetPos('PPG_CODATC, 9), 4)', 7);

  configurador.fSetPos('PPG_TIPO__', 8);
  configurador.fSetPos('BAS_TIPO__', 9);
  configurador.fSetPos('PPG_VEICUL', 10);
  configurador.fSetPos('PPG_CODCOR, 9), 4)', 11);
  configurador.fSetPos('PPG_REFERE', 12);
  configurador.fSetPos('PPG_ORIGEM', 13);
  configurador.fSetPos('PPG_UTILIZ', 14);
  configurador.fSetPos('PPG_EFEFIN', 15);


  configurador.fSetVisivel('PPG_DESCOR', True);
  configurador.fSetVisivel('MON_DESCRI', True);
  configurador.fSetVisivel('PPG_SISTEM', True);
  configurador.fSetVisivel('PPG_PAISES', True);
  configurador.fSetVisivel('PPG_VARIAN', True);
  configurador.fSetVisivel('SUBSTR(PPG_A_N_O_, 1, 4)', True);
  configurador.fSetVisivel('SUBSTR(PPG_A_N_O_, 6, 4)', True);
  configurador.fSetVisivel('PPG_CODATC', True);
  configurador.fSetVisivel('PPG_TIPO__', True);

  configurador.fSetVisivel('BAS_TIPO__', False);
  configurador.fSetVisivel('PPG_VEICUL', False);
  configurador.fSetVisivel('PPG_CODCOR', False);
  configurador.fSetVisivel('PPG_REFERE', False);
  configurador.fSetVisivel('PPG_ORIGEM', False);
  configurador.fSetVisivel('PPG_UTILIZ', False);
  configurador.fSetVisivel('PPG_EFEFIN', False);

  configurador.pAdicionarIndice('PPG_DESCOR+MON_DESCRI+SUBSTR(PPG_A_N_O_, 1, 4)', 'Descrição/Montadora/Ano Inicial');
  configurador.pAdicionarIndice('PPG_CODATC', 'Código PPG');
  configurador.pAdicionarIndice('PPG_DESCOR+PPG_VARIAN', 'Descrição/Variante Cor');

  configurador.pAdicionarCampoDescricao('PPG_DESCOR');
  configurador.pAdicionarCampoDescricao('MON_DESCRI');
  configurador.pAdicionarCampoDescricao('PPG_SISTEM');
  configurador.pAdicionarCampoDescricao('PPG_VARIAN');
  configurador.pAdicionarCampoDescricao('SUBSTR(PPG_A_N_O_, 1, 4)');
  configurador.pAdicionarCampoDescricao('SUBSTR(PPG_A_N_O_, 6, 4)');
  configurador.pAdicionarCampoDescricao('PPG_CODATC');
end;

end.
