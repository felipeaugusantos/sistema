{****************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta PPX *}
{*************************************************************************************AC*}
unit untTintadeMaquinaWrapperPpgNexa;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils, System.StrUtils;

type
  TTintadeMaquinaWrapperPpgNexa = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompPpgNexa,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory, untIDataSet;

{ TTintadeMaquinaWrapperPpgNexa }

procedure TTintadeMaquinaWrapperPpgNexa.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  configurador.pAdicionarCampo('PPX_DESCOR', 'Descrição', 'LIKE');
  configurador.pAdicionarCampo('PPX_TIPO__', 'Tipo', 'LIKE');
  configurador.pAdicionarCampo('BAS_TIPO__', 'Produto', 'LIKE');
  configurador.pAdicionarCampo('MON_DESCRI', 'Montadora', 'LIKE');
  configurador.pAdicionarCampo('PPX_VEICUL', 'Modelos', 'LIKE');
  configurador.pAdicionarCampo('SUBSTR(PPX_A_N_O_, 1, 4)', 'Ano Inicial', 'LIKE');
  configurador.pAdicionarCampo('SUBSTR(PPX_A_N_O_, 6, 4)', 'Ano Final', 'LIKE');
  configurador.pAdicionarCampo('PPX_CODCOR', 'Código', 'LIKE');
  configurador.pAdicionarCampo('PPX_CODATC', 'Código PPX', 'LIKE');
  configurador.pAdicionarCampo('PPX_MONTAD', 'Cód. Montadora', 'LIKE', False, False);
  configurador.pAdicionarCampo('PPX_A_N_O_', 'Ano', 'LIKE', False, False);
  configurador.pAdicionarCampo('PPX_MD5KEY', 'PPX_MD5KEY', '=', False, True);
  configurador.pAdicionarCampo('PPX_VARIAN', 'Variante Cor', 'LIKE');
  configurador.pAdicionarCampo('PPX_REFERE', 'Referência', 'LIKE');
  configurador.pAdicionarCampo('PPX_SISTEM', 'Sistema', 'LIKE');
  configurador.pAdicionarCampo('PPX_PAISES', 'País', 'LIKE');
  configurador.pAdicionarCampo('PPX_ORIGEM', 'Origem', 'LIKE');
  configurador.pAdicionarCampo('PPX_UTILIZ', 'Utilização', 'LIKE');
  configurador.pAdicionarCampo('PPX_EFEFIN', 'Efeito Final', 'LIKE');
  configurador.pAdicionarCampo('PPX_ACRMOB', 'Acréscimo mão de obra', 'LIKE', False, False);


  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('PPX_CODB' + TStrUtils.fStrZero(intCont, 2), 'PPX_CODB' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
    configurador.pAdicionarCampo('PPX_QTDB' + TStrUtils.fStrZero(intCont, 2), 'PPX_QTDB' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperPpgNexa.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador) +
    ' AND UPPER(IFNULL(PPX_ATIVO_, "S")) = "S" ';
end;

function TTintadeMaquinaWrapperPpgNexa.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result := Result + '  PPX_CADPPX  ';
  Result := Result + '  LEFT JOIN PPX_CADMON ON PPX_MONTAD = MON_CODMON ';
  Result := Result + ' INNER JOIN PPX_CADBAS ON PPX_CODB01 = BAS_CODBAS ';
  Result := Result + '                      AND IFNULL(PPX_ATIVO_, "S") = "S" ';

end;

function TTintadeMaquinaWrapperPpgNexa.fGetWhere: String;
Var
  strTipo : String;
  strSistema: String;
begin
  strTipo := GetLinhaAutomotiva;

  Result := Result + ' WHERE IFNULL(PPX_ATIVO_, "S") = "S" ';

  If Not TStrUtils.fEmptyStr(strTipo) Then
  Begin
    Result := Result + '   AND PPX_TIPO__ = '+ QuotedStr(strTipo) + ' ';

    strSistema := GetEscolherSistemaAutomotivo(strTipo);

    If Not TStrUtils.fEmptyStr(strSistema) Then
      Result := Result + '   AND PPX_SISTEM = '+ QuotedStr(strSistema) + ' ';
  End;

end;

function TTintadeMaquinaWrapperPpgNexa.GetCampoAutoIncrem: String;
begin
  Result := 'PPX_CADPPX.AUTOINCREM';
end;

function TTintadeMaquinaWrapperPpgNexa.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompPpgNexa.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),Self);
{$ENDIF}
end;

function TTintadeMaquinaWrapperPpgNexa.GetLinhaAutomotiva: String;
Var
  qryGen   : IDataSet;
  arrOpcoes: Array Of String;
  intOpcao : Integer;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT DISTINCT BAS_TIPO__ '+
                '   FROM PPX_CADBAS          '+
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
      Result := '';
  End
  Else If Length(arrOpcoes) = 1 then
  Begin
    intOpcao := 1;
    Result   := arrOpcoes[intOpcao-1];
  End;


end;

function TTintadeMaquinaWrapperPpgNexa.GetNomeTabela: String;
begin
  Result := 'PPX_CADPPX ';
end;

function TTintadeMaquinaWrapperPpgNexa.GetEscolherSistemaAutomotivo(strTipo : String): String;
Var
  qryGen   : IDataSet;
  arrOpcoes: Array Of String;
  intOpcao : Integer;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT DISTINCT          ' +
                '   PPX_SISTEM             ' +
                ' FROM                     ' +
                '   PPX_CADPPX             ' +
                ' WHERE PPX_TIPO__ = :TIPO ';
  qryGen.ParamByName('TIPO').AsString := strTipo;
  qryGen.Open;

  qryGen.First;

  While not qryGen.Eof Do
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := qryGen.FieldbyName('PPX_SISTEM').AsString;

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

procedure TTintadeMaquinaWrapperPpgNexa.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  configurador.fSetPos('PPX_DESCOR', 0);
  configurador.fSetPos('MON_DESCRI', 1);
  configurador.fSetPos('PPX_SISTEM', 2);
  configurador.fSetPos('PPX_PAISES', 2);
  configurador.fSetPos('PPX_VARIAN', 4);
  configurador.fSetPos('SUBSTR(PPX_A_N_O_, 1, 4)', 5);
  configurador.fSetPos('SUBSTR(PPX_A_N_O_, 6, 4)', 6);
  configurador.fSetPos('PPX_CODATC, 9), 4)', 7);

  configurador.fSetPos('PPX_TIPO__', 8);
  configurador.fSetPos('BAS_TIPO__', 9);
  configurador.fSetPos('PPX_VEICUL', 10);
  configurador.fSetPos('PPX_CODCOR, 9), 4)', 11);
  configurador.fSetPos('PPX_REFERE', 12);
  configurador.fSetPos('PPX_ORIGEM', 13);
  configurador.fSetPos('PPX_UTILIZ', 14);
  configurador.fSetPos('PPX_EFEFIN', 15);


  configurador.fSetVisivel('PPX_DESCOR', True);
  configurador.fSetVisivel('MON_DESCRI', True);
  configurador.fSetVisivel('PPX_SISTEM', True);
  configurador.fSetVisivel('PPX_PAISES', True);
  configurador.fSetVisivel('PPX_VARIAN', True);
  configurador.fSetVisivel('SUBSTR(PPX_A_N_O_, 1, 4)', True);
  configurador.fSetVisivel('SUBSTR(PPX_A_N_O_, 6, 4)', True);
  configurador.fSetVisivel('PPX_CODATC', True);
  configurador.fSetVisivel('PPX_TIPO__', True);

  configurador.fSetVisivel('BAS_TIPO__', False);
  configurador.fSetVisivel('PPX_VEICUL', False);
  configurador.fSetVisivel('PPX_CODCOR', False);
  configurador.fSetVisivel('PPX_REFERE', False);
  configurador.fSetVisivel('PPX_ORIGEM', False);
  configurador.fSetVisivel('PPX_UTILIZ', False);
  configurador.fSetVisivel('PPX_EFEFIN', False);

  configurador.pAdicionarIndice('PPX_DESCOR+MON_DESCRI+SUBSTR(PPX_A_N_O_, 1, 4)', 'Descrição/Montadora/Ano Inicial');
  configurador.pAdicionarIndice('PPX_CODATC', 'Código PPX');
  configurador.pAdicionarIndice('PPX_DESCOR+PPX_VARIAN', 'Descrição/Variante Cor');

  configurador.pAdicionarCampoDescricao('PPX_DESCOR');
  configurador.pAdicionarCampoDescricao('MON_DESCRI');
  configurador.pAdicionarCampoDescricao('PPX_SISTEM');
  configurador.pAdicionarCampoDescricao('PPX_VARIAN');
  configurador.pAdicionarCampoDescricao('SUBSTR(PPX_A_N_O_, 1, 4)');
  configurador.pAdicionarCampoDescricao('SUBSTR(PPX_A_N_O_, 6, 4)');
  configurador.pAdicionarCampoDescricao('PPX_CODATC');
end;

end.
