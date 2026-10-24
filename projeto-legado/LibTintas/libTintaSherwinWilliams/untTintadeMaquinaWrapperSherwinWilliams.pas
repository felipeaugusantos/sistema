{**************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta SherwinWilliams  *}
{***********************************************************************************AC*}
unit untTintadeMaquinaWrapperSherwinWilliams;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperSherwinWilliams = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompSherwinWilliams,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperSherwinWilliams }

procedure TTintadeMaquinaWrapperSherwinWilliams.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  configurador.pAdicionarCampo('SHE_DESCRI', 'Descrição', 'LIKE');
  configurador.pAdicionarCampo('SHE_CODIGO', 'Código', 'LIKE');
  configurador.pAdicionarCampo('SHE_CODIG2', 'Código 2', 'LIKE');
  configurador.pAdicionarCampo('SHE_UNIDAD', 'Unidade', 'LIKE');
  configurador.pAdicionarCampo('SHE_DTACAD', 'Data de Cadastro', 'LIKE');
  configurador.pAdicionarCampo('SHE_BASE__', 'Base', 'LIKE');
  configurador.pAdicionarCampo('SHE_PROKEY', 'Prod. Key', 'LIKE');
  configurador.pAdicionarCampo('SHE_SUBKEY', 'Sub. Key', 'LIKE');
  configurador.pAdicionarCampo('BAS_BASE__', 'Base ', 'LIKE', False, False);
  configurador.pAdicionarCampo('BAS_PROKEY', 'Prod. Key ', 'LIKE', False, False);
  configurador.pAdicionarCampo('BAS_SUBKEY', 'Sub. Key ', 'LIKE', False, False);
  configurador.pAdicionarCampo('BAS_UNIDAD', 'Unidade ', 'LIKE', False, False);
  configurador.pAdicionarCampo('BAS_DESCRI', 'Descrição da Base', 'LIKE', False, False);
  configurador.pAdicionarCampo('SHE_CODITE', 'Código do Item ', 'LIKE', False, False);
  configurador.pAdicionarCampo('I.ITE_CODITE', 'Código do Item', 'LIKE');
  configurador.pAdicionarCampo('I.ITE_DESITE', 'Descrição do Item', 'LIKE');
  configurador.pAdicionarCampo('I.ITE_REFERE', 'Referência do Item', 'LIKE');
  configurador.pAdicionarCampo('SHE_COMMEN', 'Observação', 'LIKE');
  configurador.pAdicionarCampo('SHE_MD5KEY', 'MD5KEY', '=', False, True);
  Configurador.pAdicionarCampo('SHE_ACRMOB', 'SHE_ACRMOB', 'LIKE', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');


  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('SHE_FORM' + TStrUtils.fStrZero(intCont, 2), 'SHE_FORM' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('SHE_QTDB' + TStrUtils.fStrZero(intCont, 2), 'SHE_QTDB' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperSherwinWilliams.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  If TAutcomTintaFactory.Get.fGetConfTinta('SHE').fGetBoolean('USAFOR') Then
    Result := Result + '     AND S.SHE_QTDB01 > 0.0 ';

  Result := Result + ' AND UPPER(IFNULL(S.SHE_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperSherwinWilliams.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result := '';
  Result := Result + '  SHE_CADSHE S ';
  Result := Result + '   INNER JOIN SHE_CADBAS B ';
  Result := Result + '     ON SHE_PROKEY = BAS_PROKEY ';
  Result := Result + '       AND SHE_SUBKEY = BAS_SUBKEY ';
  Result := Result + '       AND SHE_BASE__ = BAS_BASE__ ';
  Result := Result + '       AND SHE_UNIDAD = BAS_UNIDAD ';
  Result := Result + '   INNER JOIN CADITE I ';

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

function TTintadeMaquinaWrapperSherwinWilliams.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(S.SHE_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperSherwinWilliams.GetCampoAutoIncrem: String;
begin
  Result := 'S.AUTOINCREM';
end;

function TTintadeMaquinaWrapperSherwinWilliams.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompSherwinWilliams.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperSherwinWilliams.GetNomeTabela: String;
begin
  Result := 'SHE_CADSHE';
end;

procedure TTintadeMaquinaWrapperSherwinWilliams.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  configurador.fSetPos('SHE_DESCRI', 0);
  configurador.fSetPos('SHE_CODIGO', 1);
  configurador.fSetPos('SHE_CODIG2', 2);
  configurador.fSetPos('SHE_UNIDAD', 3);

  configurador.fSetVisivel('SHE_DESCRI', True);
  configurador.fSetVisivel('SHE_CODIGO', True);
  configurador.fSetVisivel('SHE_CODIG2', True);
  configurador.fSetVisivel('SHE_UNIDAD', True);

  configurador.pAdicionarIndice('SHE_DESCRI', 'Descrição');
  configurador.pAdicionarIndice('SHE_CODIGO', 'Código');
  configurador.pAdicionarIndice('SHE_CODIG2', 'Código 2');

  configurador.pAdicionarCampoDescricao('SHE_CODIGO');
  configurador.pAdicionarCampoDescricao('BAS_DESCRI');
  configurador.pAdicionarCampoDescricao('SHE_UNIDAD');
end;

end.

