{*****************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta bautech *}
{**************************************************************************PH*}
unit untTintadeMaquinaWrapperBautech;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperBautech = class(TAbstractTintadeMaquinaWrapper)
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
  end;

implementation

uses
{$IFNDEF LINUX}
  untConsultaCompBautech,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperBautech }

procedure TTintadeMaquinaWrapperBautech.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  configurador.pAdicionarCampo('S.BAU_DESCRI', 'Descrição', 'LIKE');
  configurador.pAdicionarCampo('S.BAU_DTACAD', 'Data Cadastro', 'LIKE');
  configurador.pAdicionarCampo('S.BAU_UNIDAD', 'Unidade', 'LIKE');
  configurador.pAdicionarCampo('S.BAU_CODBAS', 'Código da Base', 'LIKE');
  configurador.pAdicionarCampo('S.BAU_NOMCOR', 'Cor', 'LIKE');
  configurador.pAdicionarCampo('I.ITE_CODITE', 'Código do Item', 'LIKE');
  configurador.pAdicionarCampo('I.ITE_DESITE', 'Descrição do Item', 'LIKE');
  configurador.pAdicionarCampo('S.BAU_CODUNI', 'BAU_CODUNI', 'LIKE', False, False);
  configurador.pAdicionarCampo('S.BAU_MD5KEY', 'BAU_MD5KEY', 'LIKE', False, True);
  configurador.pAdicionarCampo('S.BAU_DESCRI', 'BAU_DESCRI', 'LIKE', False, False);
  configurador.pAdicionarCampo('S.BAU_PRODUT', 'Produto', 'LIKE');
  Configurador.pAdicionarCampo('S.BAU_ACRMOB', 'BAU_ACRMOB', 'LIKE', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');


  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('BAU_FORM' + TStrUtils.fStrZero(intCont, 2), 'BAU_FORM' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('BAU_QTDB' + TStrUtils.fStrZero(intCont, 2), 'BAU_QTDB' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperBautech.fGetGroup: String;
begin
  Result := ' GROUP BY BAU_DESCRI, BAU_CODUNI, BAU_PRODUT ';
end;

function TTintadeMaquinaWrapperBautech.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  If TAutcomTintaFactory.Get.fGetConfTinta('BAU').fGetBoolean('USAFOR') Then
    Result := Result + '     AND S.BAU_QTDB01 > 0.0 ';

  Result := Result + fGetGroup;
end;

function TTintadeMaquinaWrapperBautech.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result :=
    '   BAU_CADBAU S                      ' +
    '   INNER JOIN BAU_CADBAS B           ' +
    '      ON S.BAU_CODBAS = B.BAS_CODBAS ' +
    '     AND S.BAU_PRODUT = B.BAS_DESCRI ' +
    '   INNER JOIN CADITE I               ';

  If TStrUtils.fEmptyStr(configurador.GetCodIte) Then
  Begin
    Result := Result + '     ON B.BAS_CODITE = I.ITE_CODITE ';
    Result := Result + '     AND I.ITE_ITEATI = "S"          ';
    Result := Result + '     INNER JOIN ITEGER ON         ';
    Result := Result + '       B.BAS_CODITE = ITEGER.ITE_CODITE AND    ';
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


function TTintadeMaquinaWrapperBautech.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(S.BAU_ATIVAD, "S")) = "S" ';
end;

function TTintadeMaquinaWrapperBautech.GetCampoAutoIncrem: String;
begin
  Result := 'S.AUTOINCREM';
end;

function TTintadeMaquinaWrapperBautech.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompBautech.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')), //TAutcomTintaFactory.Get.fCfgSis('TABPAD', varString)
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperBautech.GetNomeTabela: String;
begin
  Result := 'BAU_CADBAU';
end;

procedure TTintadeMaquinaWrapperBautech.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  configurador.fSetPos('S.BAU_UNIDAD', 0);
  configurador.fSetPos('ITE_DESITE', 1);
  configurador.fSetPos('S.BAU_DTACAD', 2);

  configurador.fSetVisivel('S.BAU_UNIDAD', True);
  configurador.fSetVisivel('ITE_DESITE', True);
  configurador.fSetVisivel('S.BAU_DTACAD', True);

  configurador.pAdicionarIndice('S.BAU_DESCRI+S.BAU_NOMCOR', 'Descrição/Cor');
  configurador.pAdicionarIndice('ITE_DESITE', 'Descrição do Item');
  configurador.pAdicionarIndice('BAU_DTACAD', 'Data Cadastro');

  configurador.pAdicionarCampoDescricao('S.BAU_UNIDAD');
  configurador.pAdicionarCampoDescricao('ITE_DESITE');
  configurador.pAdicionarCampoDescricao('S.BAU_DTACAD');
end;

end.
