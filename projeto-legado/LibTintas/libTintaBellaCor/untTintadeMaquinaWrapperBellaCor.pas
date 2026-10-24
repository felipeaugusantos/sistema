{*****************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta BellaCor *}
{**************************************************************************PH*}
unit untTintadeMaquinaWrapperBellaCor;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperBellaCor = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompBellaCor,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperBellaCor }

procedure TTintadeMaquinaWrapperBellaCor.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  configurador.pAdicionarCampo('S.BEL_DESCRI', 'Descrição', 'LIKE');
  configurador.pAdicionarCampo('S.BEL_CODUNI', 'Unidade', 'LIKE');
  configurador.pAdicionarCampo('S.BEL_CODBAS', 'Código da Base', 'LIKE');
  configurador.pAdicionarCampo('S.BEL_NOMCOR', 'Cor', 'LIKE');
  configurador.pAdicionarCampo('S.BEL_DTACAD', 'Data Cadastro', 'LIKE');
  configurador.pAdicionarCampo('S.BEL_COLECA', 'Coleção', 'LIKE');
  configurador.pAdicionarCampo('I.ITE_CODITE',   'Código do Item', 'LIKE');
  configurador.pAdicionarCampo('I.ITE_DESITE',   'Descrição do Item', 'LIKE');
  configurador.pAdicionarCampo('S.BEL_PRODUT', 'Produto', 'LIKE');
  configurador.pAdicionarCampo('S.BEL_MD5KEY', 'BEL_MD5KEY', 'LIKE', False, True);
  configurador.pAdicionarCampo('S.BEL_DESCRI', 'BEL_DESCRI', 'LIKE', False, False);
  Configurador.pAdicionarCampo('S.BEL_ACRMOB', 'BEL_ACRMOB', 'LIKE', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');

  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('BEL_FORM' + TStrUtils.fStrZero(intCont, 2), 'BEL_FORM' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('BEL_QTDB' + TStrUtils.fStrZero(intCont, 2), 'BEL_QTDB' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperBellaCor.fGetGroup: String;
begin
  Result := '';
end;

function TTintadeMaquinaWrapperBellaCor.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  If TAutcomTintaFactory.Get.fGetConfTinta('BEL').fGetBoolean('USAFOR') Then
    Result := Result + '     AND S.BEL_QTDB01 > 0.0 ';

  Result := Result + fGetGroup;
end;

function TTintadeMaquinaWrapperBellaCor.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result :=
    '   BEL_CADBEL S                      ' +
    '   INNER JOIN BEL_CADBAS B           ' +
    '      ON S.BEL_CODBAS = B.BAS_CODBAS ' +
    '     AND S.BEL_PRODUT = B.BAS_PRODUT ' +
    '     AND S.BEL_CODUNI = B.BAS_CODUNI '+
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


function TTintadeMaquinaWrapperBellaCor.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(S.BEL_ATIVAD, "S")) = "S" ';
end;

function TTintadeMaquinaWrapperBellaCor.GetCampoAutoIncrem: String;
begin
  Result := 'S.AUTOINCREM';
end;

function TTintadeMaquinaWrapperBellaCor.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompBellaCor.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')), //TAutcomTintaFactory.Get.fCfgSis('TABPAD', varString)
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperBellaCor.GetNomeTabela: String;
begin
  Result := 'BEL_CADBEL';
end;

procedure TTintadeMaquinaWrapperBellaCor.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  configurador.fSetPos('S.BEL_CODUNI', 0);
  configurador.fSetPos('I.ITE_DESITE', 1);

  configurador.fSetVisivel('S.BEL_CODUNI', True);
  configurador.fSetVisivel('I.ITE_DESITE', True);


  configurador.pAdicionarIndice('S.BEL_DESCRI', 'Descrição');
  configurador.pAdicionarIndice('S.BEL_NOMCOR', 'Nome da Cor');
  configurador.pAdicionarIndice('S.BEL_PRODUT', 'Produto');
  configurador.pAdicionarIndice('S.BEL_CODUNI', 'Cód.Unidade');
  configurador.pAdicionarIndice('S.BEL_DTACAD', 'Data Cadastro');
  configurador.pAdicionarIndice('S.BEL_COLECA', 'Coleção');
  configurador.pAdicionarIndice('I.ITE_DESITE',   'Descrição do Item');


  configurador.pAdicionarCampoDescricao('S.BEL_CODUNI');
  configurador.pAdicionarCampoDescricao('I.ITE_DESITE');
end;

end.
