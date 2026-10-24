{******************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta ColorPro *}
{***************************************************************************AC*}
unit untTintadeMaquinaWrapperColorPro;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils, StrUtils;

type
  TTintadeMaquinaWrapperColorPro = class(TAbstractTintadeMaquinaWrapper)
  public
    procedure Configurar(const configurador: IConfiguradorConsulta); override;
    function GetCampoAutoIncrem: String; override;
    function fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String; override;
    procedure pRestaurarPadrao(const configurador: IConfiguradorConsulta); override;
    function fGetSelectFrom(const configurador: IConfiguradorConsulta): String; override;
    function GetNomeTabela: String; override;
    function GetConsultaComp(strTabPre: String): IConsultaComp; override;
    function fGetWhere: String; override;
    function fGetGroup: String; override;
    function GetLinhaWandaPro: String; override;
  end;

implementation

uses
{$IFNDEF LINUX}
  untConsultaCompColorPro,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperColorPro }

procedure TTintadeMaquinaWrapperColorPro.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  configurador.pAdicionarCampo('WAN_LINHA_', 'Linha', 'LIKE');
  configurador.pAdicionarCampo('WAN_NOMLIN', 'Descrição da Linha', 'LIKE');
  configurador.pAdicionarCampo('WAN_CODAKZ', 'Codigo', 'LIKE');
  configurador.pAdicionarCampo('WAN_DESCRI', 'Descricao', 'LIKE');
  configurador.pAdicionarCampo('WAN_ALTERN', 'Variação', 'LIKE');
  configurador.pAdicionarCampo('WAN_MONTAD', 'Montadora', 'LIKE');
  configurador.pAdicionarCampo('WAN_CAMADA', 'Camada', 'LIKE');
  configurador.pAdicionarCampo('WAN_ANOINI', 'Ano Inicial', 'LIKE');
  configurador.pAdicionarCampo('WAN_ANOFIN', 'Ano Final', 'LIKE');
  configurador.pAdicionarCampo('WAN_DTACAD', 'Data Cadastro', 'LIKE');
  configurador.pAdicionarCampo('WAN_VARIAN', 'Variante', 'LIKE');

  //Sempre quando não for uma campo normal ex : WAN_ANOFIN, criar um apelido seguindo o padrao ex : AS WAN_CODUNI
  configurador.pAdicionarCampo('CAST(GROUP_CONCAT(DISTINCT WANPRO_CODUNI SEPARATOR ", ") AS CHAR(80)) AS WANPRO_CODUNI', 'Cód. Universal', 'LIKE', False, False);
  Configurador.pAdicionarCampo('WAN_UNIVER', 'Código Universal', 'LIKE');
  configurador.pAdicionarCampo('WAN_CODSEQ', 'Sequência', 'LIKE', False, False);
  configurador.pAdicionarCampo('WAN_MD5KEY', 'WAN_MD5KEY', 'LIKE', False, False);
  configurador.pAdicionarCampo('WAN_ACRMOB', 'Acréscimo mão de obra', 'LIKE', False, False);
  configurador.pAdicionarCampo('WAN_VERCOR', 'Versão', 'LIKE');

  for intCont := 1 to 20 do
  begin
    configurador.pAdicionarCampo('WAN_LINC' + TStrUtils.fStrZero(intCont, 2),  'WAN_LINC' + TStrUtils.fStrZero(intCont, 2),
          'LIKE', False, False);

    configurador.pAdicionarCampo('WAN_CODC' + TStrUtils.fStrZero(intCont, 2),  'WAN_CODC' + TStrUtils.fStrZero(intCont, 2),
          'LIKE', False, False);

    configurador.pAdicionarCampo('WAN_QCON' + TStrUtils.fStrZero(intCont, 2),  'WAN_QCON' + TStrUtils.fStrZero(intCont, 2),
          '=', False, False);

    configurador.pAdicionarCampo('WAN_QD21' + TStrUtils.fStrZero(intCont, 2),  'WAN_QD21' + TStrUtils.fStrZero(intCont, 2),
          '=', False, False);

    configurador.pAdicionarCampo('WAN_QD41' + TStrUtils.fStrZero(intCont, 2),  'WAN_QD41' + TStrUtils.fStrZero(intCont, 2),
          '=', False, False);

    Configurador.pAdicionarCampo('WAN_QD92' + TStrUtils.fStrZero(intCont, 2),  'WAN_QD92' + TStrUtils.fStrZero(intCont, 2),
          '=', False, False);

    configurador.pAdicionarCampo('WAN_PORC' + TStrUtils.fStrZero(intCont, 2),  'WAN_PORC' + TStrUtils.fStrZero(intCont, 2),
          '=', False, False);
  end;

end;

function TTintadeMaquinaWrapperColorPro.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador) +
    ' AND WAN_ATIVO_ = ' + QuotedStr('S') + ' ' + fGetGroup;
end;

function TTintadeMaquinaWrapperColorPro.fGetSelectFrom(
  const configurador: IConfiguradorConsulta): String;
begin
  Result := GetNomeTabela;
  Result := Result + '   LEFT JOIN WANPRO_CODUNI ON WANPRO_CODAKZ = WAN_CODAKZ AND ';
  Result := Result + '                              WANPRO_ALTERN = WAN_ALTERN AND ';
  Result := Result + '                              WANPRO_VERCOR = WAN_VERCOR     ';
end;

function TTintadeMaquinaWrapperColorPro.fGetWhere: String;
begin
  Result := ' WHERE TRUE AND WAN_ATIVO_ = ' + QuotedStr('S') + ' ';
  Result := Result + '  AND WAN_LINHA_ = '+ QuotedStr(AnsiReplaceStr(Trim(LeftStr(GetLinhaWandaPro, 3)),'0','')) + ' ';
end;

function TTintadeMaquinaWrapperColorPro.GetCampoAutoIncrem: String;
begin
  Result := 'AUTOINCREM';
end;

function TTintadeMaquinaWrapperColorPro.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompColorPro.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperColorPro.GetLinhaWandaPro: String;
  Var
    strLinWan: String;
    strLinhaWandaPro: String;
    arrOpcoes: Array Of String;
    intOpcao: Integer;
begin
  Result := '';

  strLinWan := TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGet('LINWAN');

  If Pos('001', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := ' 1 Autobase Plus 100:50';
  End;

  If Pos('004', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := ' 4 Wandabase HS';
  End;

  If Pos('006', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := ' 6 Wandalac';
  End;

  If Pos('008', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := ' 8 Wanda PU HS';
  End;

  If Pos('009', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := ' 9 Wandacar';
  End;

  If Pos('011', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := '11 Single Stage Converter';
  End;

  If Pos('012', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := '12 Autobase Plus Baseline 100:80';
  End;

  If Pos('014', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := '14 Autobase Plus 100:80';
  End;

  If Pos('016', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := '16 Autocoat BT120';
  End;

  If Pos('019', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := '19 Autobase Plus Baseline 100:50';
  End;

  If Pos('058', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := '58 Wanda PU MS';
  End;

  If Pos('059', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := '59 Autocoat BT90';
  End;

  If Pos('013', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := '13 Autocoat BT100';
  End;

  If Pos('15', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := '15 Autocoat BT110';
  End;

  If Pos('17', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := '17 Autocoat BT130';
  End;

  If Pos('27', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := '27 Autowave MM';
  End;

  If Pos('67', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := '67 Autowave MM 2.0';
  End;

  If Pos('72', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := '72 Tech Fleet PU';
  End;

  If Pos('74', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := '74 Tech Fleet Epoxy';
  End;

  If Pos('75', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := '75 Tech Fleet Sintetico';
  End;

  If Pos('76', strLinWan) > 0 Then
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := '76 Tech Fleet Laca';
  End;

  If Length(arrOpcoes) >= 2 Then
  Begin
  {$IFNDEF LINUX}
    intOpcao := TAutcomTintaFactory.Get.fGetMenu('Linha', arrOpcoes, 1);
  {$ENDIF}
    Result   := Trim(LeftStr(arrOpcoes[intOpcao-1], 2));
  End
  Else If Length(arrOpcoes) = 1 then
  Begin
    intOpcao := 1;
    Result   := Trim(LeftStr(arrOpcoes[intOpcao-1], 2));
  End;
end;

function TTintadeMaquinaWrapperColorPro.GetNomeTabela: String;
begin
  Result := 'WANPRO_CADWAN';
end;

function TTintadeMaquinaWrapperColorPro.fGetGroup: String;
begin
  Result := Result + ' GROUP BY ';
  Result := Result + '   WAN_CODAKZ, WAN_ALTERN, WAN_CAMADA, WAN_VERCOR, WAN_DESCRI ';
end;

procedure TTintadeMaquinaWrapperColorPro.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  configurador.fSetPos('WAN_LINHA_', 0);
  configurador.fSetPos('WAN_NOMLIN', 1);
  configurador.fSetPos('WAN_CODAKZ', 2);
  configurador.fSetPos('WAN_DESCRI', 3);
  configurador.fSetPos('WAN_ALTERN', 4);
  configurador.fSetPos('WAN_MONTAD', 5);
  configurador.fSetPos('WAN_CAMADA', 6);
  configurador.fSetPos('WAN_ANOINI', 7);
  configurador.fSetPos('WAN_ANOFIN', 8);

  configurador.fSetVisivel('WAN_LINHA_', True);
  configurador.fSetVisivel('WAN_NOMLIN', True);
  configurador.fSetVisivel('WAN_CODAKZ', True);
  configurador.fSetVisivel('WAN_DESCRI', True);
  configurador.fSetVisivel('WAN_ALTERN', True);
  configurador.fSetVisivel('WAN_MONTAD', True);
  configurador.fSetVisivel('WAN_CAMADA', True);
  configurador.fSetVisivel('WAN_ANOINI', True);
  configurador.fSetVisivel('WAN_ANOFIN', True);

  configurador.pAdicionarIndice('WAN_DESCRI', 'Descricao');
  configurador.pAdicionarIndice('WAN_CODAKZ', 'Codigo');

  configurador.pAdicionarCampoDescricao('WAN_DESCRI');
  configurador.pAdicionarCampoDescricao('WAN_CODAKZ');
end;

end.
