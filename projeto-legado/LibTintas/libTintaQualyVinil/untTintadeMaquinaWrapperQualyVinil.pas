{*****************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta QualyVinil *}
{**************************************************************************PH*}
unit untTintadeMaquinaWrapperQualyVinil;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperQualyVinil = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompQualyVinil,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperQualyVinil }

procedure TTintadeMaquinaWrapperQualyVinil.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  configurador.pAdicionarCampo('S.QUA_DESCRI', 'Descrição', 'LIKE');
  configurador.pAdicionarCampo('S.QUA_CODUNI', 'Unidade', 'LIKE');
  configurador.pAdicionarCampo('S.QUA_CODBAS', 'Código da Base', 'LIKE');
  configurador.pAdicionarCampo('S.QUA_NOMCOR', 'Cor', 'LIKE');
  configurador.pAdicionarCampo('S.QUA_DTACAD', 'Data Cadastro', 'LIKE');
  Configurador.pAdicionarCampo('S.QUA_COLECA', 'Coleção', 'LIKE');
  configurador.pAdicionarCampo('I.ITE_CODITE', 'Código do Item', 'LIKE');
  configurador.pAdicionarCampo('I.ITE_DESITE', 'Descrição do Item', 'LIKE');
  configurador.pAdicionarCampo('S.QUA_PRODUT', 'Produto', 'LIKE');
  configurador.pAdicionarCampo('S.QUA_MD5KEY', 'QUA_MD5KEY', 'LIKE', False, True);
  configurador.pAdicionarCampo('S.QUA_DESCRI', 'QUA_DESCRI', 'LIKE', False, False);
  Configurador.pAdicionarCampo('S.QUA_ACRMOB', 'QUA_ACRMOB', 'LIKE', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');

  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('QUA_FORM' + TStrUtils.fStrZero(intCont, 2), 'QUA_FORM' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('QUA_QTDB' + TStrUtils.fStrZero(intCont, 2), 'QUA_QTDB' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperQualyVinil.fGetGroup: String;
begin
  Result := '';
end;

function TTintadeMaquinaWrapperQualyVinil.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  If TAutcomTintaFactory.Get.fGetConfTinta('QUA').fGetBoolean('USAFOR') Then
    Result := Result + '     AND S.QUA_QTDB01 > 0.0 ';

  Result := Result + fGetGroup;
end;

function TTintadeMaquinaWrapperQualyVinil.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result :=
    '   QUA_CADQUA S                      ' +
    '   INNER JOIN QUA_CADBAS B           ' +
    '      ON S.QUA_CODBAS = B.BAS_CODBAS ' +
    '     AND S.QUA_PRODUT = B.BAS_PRODUT ' +
    '     AND S.QUA_CODUNI = B.BAS_CODUNI '+
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


function TTintadeMaquinaWrapperQualyVinil.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(S.QUA_ATIVAD, "S")) = "S" ';
end;

function TTintadeMaquinaWrapperQualyVinil.GetCampoAutoIncrem: String;
begin
  Result := 'S.AUTOINCREM';
end;

function TTintadeMaquinaWrapperQualyVinil.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompQualyVinil.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')), //TAutcomTintaFactory.Get.fCfgSis('TABPAD', varString)
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperQualyVinil.GetNomeTabela: String;
begin
  Result := 'QUA_CADQUA';
end;

procedure TTintadeMaquinaWrapperQualyVinil.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  configurador.fSetPos('S.QUA_CODUNI', 0);
  configurador.fSetPos('I.ITE_DESITE', 1);

  configurador.fSetVisivel('S.QUA_CODUNI', True);
  configurador.fSetVisivel('I.ITE_DESITE', True);


  configurador.pAdicionarIndice('S.QUA_DESCRI', 'Descrição');
  configurador.pAdicionarIndice('S.QUA_NOMCOR', 'Nome da Cor');
  configurador.pAdicionarIndice('S.QUA_PRODUT', 'Produto');
  configurador.pAdicionarIndice('S.QUA_CODUNI', 'Cód.Unidade');
  configurador.pAdicionarIndice('S.QUA_DTACAD', 'Data Cadastro');
  configurador.pAdicionarIndice('I.ITE_DESITE', 'Descrição do Item');


  configurador.pAdicionarCampoDescricao('S.QUA_CODUNI');
  configurador.pAdicionarCampoDescricao('I.ITE_DESITE');
end;

end.
