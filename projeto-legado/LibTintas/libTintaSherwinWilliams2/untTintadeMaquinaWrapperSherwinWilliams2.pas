{*****************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta SherwinWilliams2 *}
{**************************************************************************PH*}
unit untTintadeMaquinaWrapperSherwinWilliams2;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperSherwinWilliams2 = class(TAbstractTintadeMaquinaWrapper)
  public
    procedure Configurar(const configurador: IConfiguradorConsulta); override;
    function GetCampoAutoIncrem: String; override;
    function fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String; override;
    function GetNomeTinta: String; override;
    function GetNomeForm: String; override;
    procedure pRestaurarPadrao(const configurador: IConfiguradorConsulta); override;
    function fGetSelectFrom(const configurador: IConfiguradorConsulta): String; override;
    function GetNomeTabela: String; override;
    function GetConsultaComp(strTabPre: String): IConsultaComp; override;
    function fGetWhere: String; override;
  end;

implementation

uses
{$IFNDEF LINUX}
  untConsultaCompSherwinWilliams2,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperSherwinWilliams2 }

procedure TTintadeMaquinaWrapperSherwinWilliams2.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  configurador.pAdicionarCampo('S.SHW_CODIGO', 'Código', 'LIKE');
  configurador.pAdicionarCampo('S.SHW_DESCRI', 'Descrição', 'LIKE');
  configurador.pAdicionarCampo('S.SHW_PRODUT', 'Produto', 'LIKE');
  configurador.pAdicionarCampo('S.SHW_DTACAD', 'Data Cadastro', 'LIKE');
  configurador.pAdicionarCampo('S.SHW_CODUNI', 'Unidade', 'LIKE');
  configurador.pAdicionarCampo('S.SHW_COLECA', 'Coleção', 'LIKE');
  configurador.pAdicionarCampo('S.SHW_BASE__', 'Código da Base', 'LIKE');
  configurador.pAdicionarCampo('I.ITE_CODITE', 'Código do Item', 'LIKE');
  configurador.pAdicionarCampo('I.ITE_DESITE', 'Descrição do Item', 'LIKE');
  configurador.pAdicionarCampo('I.ITE_REFERE', 'Referência do Item', 'LIKE');
  configurador.pAdicionarCampo('S.SHW_CODUNI', 'SHW_CODUNI', 'LIKE', False, False);
  configurador.pAdicionarCampo('S.SHW_MD5KEY', 'SHW_MD5KEY', 'LIKE', False, True);
  configurador.pAdicionarCampo('S.SHW_DESCRI', 'SHW_DESCRI', 'LIKE', False, False);
  configurador.pAdicionarCampo('S.SHW_OBSERV', 'Observação', 'LIKE');
  Configurador.pAdicionarCampo('S.SHW_ACRMOB', 'SHW_ACRMOB', 'LIKE', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');


  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('SHW_FORM' + TStrUtils.fStrZero(intCont, 2), 'SHW_FORM' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('SHW_QTDC' + TStrUtils.fStrZero(intCont, 2), 'SHW_QTDC' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperSherwinWilliams2.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  If TAutcomTintaFactory.Get.fGetConfTinta('SHW').fGetBoolean('USAFOR') Then
    Result := Result + '     AND S.SHW_QTDC01 > 0.0 ';

  Result := Result + ' AND UPPER(IFNULL(S.SHW_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperSherwinWilliams2.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result :=
    '   SHW_CADSHW S                      ' +
    '   INNER JOIN SHW_CADBAS B           ' +
    '      ON S.SHW_BASE__ = B.BAS_CODBAS ' +
    '     AND S.SHW_CODUNI = B.BAS_CODUNI ' +
    '     AND S.SHW_PRODUT = B.BAS_PRODUT' +
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

function TTintadeMaquinaWrapperSherwinWilliams2.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(S.SHW_ATIVAD, "S")) = "S" ';
end;

function TTintadeMaquinaWrapperSherwinWilliams2.GetCampoAutoIncrem: String;
begin
  Result := 'S.AUTOINCREM';
end;

function TTintadeMaquinaWrapperSherwinWilliams2.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompSherwinWilliams2.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')), //TAutcomTintaFactory.Get.fCfgSis('TABPAD', varString)
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperSherwinWilliams2.GetNomeForm: String;
begin
  Result := 'SherwinWIlliams2';
end;

function TTintadeMaquinaWrapperSherwinWilliams2.GetNomeTabela: String;
begin
  Result := 'SHW_CADSHW';
end;

function TTintadeMaquinaWrapperSherwinWilliams2.GetNomeTinta: String;
begin
  Result := 'Sherwin Williams';
end;

procedure TTintadeMaquinaWrapperSherwinWilliams2.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  configurador.fSetPos('S.SHW_CODIGO',0);
  configurador.fSetPos('S.SHW_DESCRI',1 );
  configurador.fSetPos('S.SHW_DTACAD',2 );
  configurador.fSetPos('S.SHW_PRODUT',3 );
  configurador.fSetPos('S.SHW_CODUNI',4 );
  configurador.fSetPos('I.ITE_DESITE',  5);

  configurador.fSetVisivel('S.SHW_CODIGO',true);
  configurador.fSetVisivel('S.SHW_DESCRI',true);
  configurador.fSetVisivel('S.SHW_DTACAD',true);
  configurador.fSetVisivel('S.SHW_PRODUT',true);
  configurador.fSetVisivel('S.SHW_CODUNI',true);
  configurador.fSetVisivel('I.ITE_DESITE'  ,true);

  configurador.pAdicionarIndice('S.SHW_CODIGO', 'Código');
  configurador.pAdicionarIndice('S.SHW_DESCRI', 'Descrição');
  configurador.pAdicionarIndice('S.SHW_DTACAD', 'Data Cadastro');
  configurador.pAdicionarIndice('S.SHW_PRODUT', 'Produto');
  configurador.pAdicionarIndice('S.SHW_CODUNI', 'Cód.Unidade');
  configurador.pAdicionarIndice('I.ITE_DESITE', 'Descrição do Item');

  configurador.pAdicionarCampoDescricao('S.SHW_CODIGO');
  configurador.pAdicionarCampoDescricao('S.SHW_DESCRI');
  configurador.pAdicionarCampoDescricao('S.SHW_DTACAD');
  configurador.pAdicionarCampoDescricao('S.SHW_PRODUT');
  configurador.pAdicionarCampoDescricao('S.SHW_CODUNI');
  configurador.pAdicionarCampoDescricao('I.ITE_DESITE');
end;

end.
