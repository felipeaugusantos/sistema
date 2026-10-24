{*****************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta Falcao *}
{**************************************************************************PH*}
unit untTintadeMaquinaWrapperFalcao;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperFalcao = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompFalcao,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperFalcao }

procedure TTintadeMaquinaWrapperFalcao.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  configurador.pAdicionarCampo('S.FAL_CODIGO', 'Código', 'LIKE');
  configurador.pAdicionarCampo('S.FAL_DESCRI', 'Descrição', 'LIKE');
  configurador.pAdicionarCampo('S.FAL_LINHA_', 'Linha', 'LIKE');
  configurador.pAdicionarCampo('S.FAL_DTACAD', 'Data Cadastro', 'LIKE');
  configurador.pAdicionarCampo('S.FAL_CODUNI', 'Unidade', 'LIKE');
  configurador.pAdicionarCampo('S.FAL_BASE__', 'Código da Base', 'LIKE');
  configurador.pAdicionarCampo('I.ITE_CODITE',   'Código do Item', 'LIKE');
  configurador.pAdicionarCampo('I.ITE_DESITE',   'Descrição do Item', 'LIKE');
  configurador.pAdicionarCampo('S.FAL_CODUNI', 'FAL_CODUNI', 'LIKE', False, False);
  configurador.pAdicionarCampo('S.FAL_MD5KEY', 'FAL_MD5KEY', 'LIKE', False, True);
  configurador.pAdicionarCampo('S.FAL_DESCRI', 'FAL_DESCRI', 'LIKE', False, False);
  Configurador.pAdicionarCampo('S.FAL_ACRMOB', 'FAL_ACRMOB', 'LIKE', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');


  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('FAL_FORM' + TStrUtils.fStrZero(intCont, 2), 'FAL_FORM' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('FAL_QTDC' + TStrUtils.fStrZero(intCont, 2), 'FAL_QTDC' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperFalcao.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  If TAutcomTintaFactory.Get.fGetConfTinta('FAL').fGetBoolean('USAFOR') Then
    Result := Result + '     AND S.FAL_QTDC01 > 0.0 ';

  Result := Result + ' AND UPPER(IFNULL(S.FAL_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperFalcao.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result :=
    '   FAL_CADFAL S                      ' +
    '   INNER JOIN FAL_CADBAS B           ' +
    '      ON S.FAL_BASE__ = B.BAS_DESCRI ' +
    '     AND S.FAL_CODUNI = B.BAS_CODUNI ' +
    '     AND S.FAL_LINHA_ = B.BAS_LINHA_ ' +
    '   INNER JOIN CADITE I               ';

  If TStrUtils.fEmptyStr(configurador.GetCodIte) Then
  Begin
    Result := Result + '     ON B.BAS_CODITE = I.ITE_CODITE ';
    Result := Result + '     AND I.ITE_ITEATI = "S"          ';
    Result := Result + '     INNER JOIN ITEGER ON         ';
    Result := Result + '       BAS_CODITE = ITEGER.ITE_CODITE AND    ';
    Result := Result + '       ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
  End
  Else
  Begin
    Result := Result + '     ON ' + AnsiQuotedStr(configurador.GetCodIte, '"') + ' = I.ITE_CODITE ';
    Result := Result + '     AND I.ITE_ITEATI = "S"          ';
    Result := Result + '     INNER JOIN ITEGER ON         ';
    Result := Result + AnsiQuotedStr(configurador.GetCodIte, '"') + ' = ITEGER.ITE_CODITE AND ';
    Result := Result + '       ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
  End;
end;

function TTintadeMaquinaWrapperFalcao.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(S.FAL_ATIVAD, "S")) = "S" ';
end;

function TTintadeMaquinaWrapperFalcao.GetCampoAutoIncrem: String;
begin
  Result := 'S.AUTOINCREM';
end;

function TTintadeMaquinaWrapperFalcao.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompFalcao.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')), //TAutcomTintaFactory.Get.fCfgSis('TABPAD', varString)
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperFalcao.GetNomeTabela: String;
begin
  Result := 'FAL_CADFAL';
end;

procedure TTintadeMaquinaWrapperFalcao.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  configurador.fSetPos('S.FAL_CODIGO',0);
  configurador.fSetPos('S.FAL_DESCRI',1 );
  configurador.fSetPos('S.FAL_DTACAD',2 );
  configurador.fSetPos('S.FAL_LINHA_',3 );
  configurador.fSetPos('S.FAL_CODUNI',4 );
  configurador.fSetPos('I.ITE_DESITE',  5);

  configurador.fSetVisivel('S.FAL_CODIGO',true);
  configurador.fSetVisivel('S.FAL_DESCRI',true);
  configurador.fSetVisivel('S.FAL_DTACAD',true);
  configurador.fSetVisivel('S.FAL_LINHA_',true);
  configurador.fSetVisivel('S.FAL_CODUNI',true);
  configurador.fSetVisivel('I.ITE_DESITE'  ,true);

  configurador.pAdicionarIndice('S.FAL_CODIGO', 'Código');
  configurador.pAdicionarIndice('S.FAL_DESCRI', 'Descrição');
  configurador.pAdicionarIndice('S.FAL_DTACAD', 'Data Cadastro');
  configurador.pAdicionarIndice('S.FAL_LINHA_', 'Linha');
  configurador.pAdicionarIndice('S.FAL_CODUNI', 'Cód.Unidade');
  configurador.pAdicionarIndice('I.ITE_DESITE', 'Descrição do Item');

  configurador.pAdicionarCampoDescricao('S.FAL_CODIGO');
  configurador.pAdicionarCampoDescricao('S.FAL_DESCRI');
  configurador.pAdicionarCampoDescricao('S.FAL_DTACAD');
  configurador.pAdicionarCampoDescricao('S.FAL_LINHA_');
  configurador.pAdicionarCampoDescricao('S.FAL_CODUNI');
  configurador.pAdicionarCampoDescricao('I.ITE_DESITE');
end;

end.
