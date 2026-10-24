{*******************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta AlterPlus *}
{****************************************************************************PH*}
unit untTintadeMaquinaWrapperAlterPlus;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperAlterPlus = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompAlterPlus,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperAlterPlus }

procedure TTintadeMaquinaWrapperAlterPlus.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  configurador.pAdicionarCampo('S.ALP_CODIGO', 'Código', 'LIKE');
  configurador.pAdicionarCampo('S.ALP_DESCRI', 'Descrição', 'LIKE');
  configurador.pAdicionarCampo('S.ALP_REFERE', 'Referência', 'LIKE');
  configurador.pAdicionarCampo('S.ALP_DTACAD', 'Data Cadastro', 'LIKE');
  configurador.pAdicionarCampo('S.ALP_CODUNI', 'Unidade', 'LIKE');
  configurador.pAdicionarCampo('S.ALP_CODBAS', 'Código da Base', 'LIKE');
  configurador.pAdicionarCampo('S.ALP_PRODUT', 'Produto', 'LIKE');
  configurador.pAdicionarCampo('S.ALP_COLECA', 'Coleção', 'LIKE');
  configurador.pAdicionarCampo('S.ALP_NOME__', 'Nome da Cor', 'LIKE');
  configurador.pAdicionarCampo('I.ITE_CODITE', 'Código do Item', 'LIKE');
  configurador.pAdicionarCampo('I.ITE_DESITE', 'Descrição do Item', 'LIKE');
  configurador.pAdicionarCampo('S.ALP_CODUNI', 'ALP_CODUNI', 'LIKE', False, False);
  configurador.pAdicionarCampo('S.ALP_MD5KEY', 'ALP_MD5KEY', 'LIKE', False, True);
  configurador.pAdicionarCampo('S.ALP_DESCRI', 'ALP_DESCRI', 'LIKE', False, False);
  configurador.pAdicionarCampo('S.ALP_ACRMOB', 'ALP_ACRMOB', 'LIKE', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');


  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('ALP_FORM' + TStrUtils.fStrZero(intCont, 2), 'ALP_FORM' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('ALP_QTDC' + TStrUtils.fStrZero(intCont, 2), 'ALP_QTDC' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperAlterPlus.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  If TAutcomTintaFactory.Get.fGetConfTinta('ALP').fGetBoolean('USAFOR') Then
    Result := Result + '     AND S.ALP_QTDC01 > 0.0 ';

  Result := Result + ' AND UPPER(IFNULL(S.ALP_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperAlterPlus.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result :=
    '   ALP_CADALP S                      ' +
    '   INNER JOIN ALP_CADBAS B           ' +
    '      ON S.ALP_CODBAS = B.BAS_CODBAS ' +
    '     AND S.ALP_CODUNI = B.BAS_CODUNI ' +
    '     AND S.ALP_PRODUT = B.BAS_PRODUT ' +
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

function TTintadeMaquinaWrapperAlterPlus.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(S.ALP_ATIVAD, "S")) = "S" ';
end;

function TTintadeMaquinaWrapperAlterPlus.GetCampoAutoIncrem: String;
begin
  Result := 'S.AUTOINCREM';
end;

function TTintadeMaquinaWrapperAlterPlus.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompAlterPlus.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')), //TAutcomTintaFactory.Get.fCfgSis('TABPAD', varString)
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperAlterPlus.GetNomeTabela: String;
begin
  Result := 'ALP_CADALP';
end;

procedure TTintadeMaquinaWrapperAlterPlus.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  configurador.fSetPos('S.ALP_CODIGO',0);
  configurador.fSetPos('S.ALP_DESCRI',1 );
  configurador.fSetPos('S.ALP_REFERE',2 );
  configurador.fSetPos('S.ALP_DTACAD',3 );
  configurador.fSetPos('S.ALP_COLECA',4 );
  configurador.fSetPos('S.ALP_PRODUT',5 );
  configurador.fSetPos('S.ALP_CODUNI',6 );
  configurador.fSetPos('I.ITE_DESITE', 7);

  configurador.fSetVisivel('S.ALP_CODIGO',true);
  configurador.fSetVisivel('S.ALP_DESCRI',true);
  configurador.fSetVisivel('S.ALP_REFERE',true);
  configurador.fSetVisivel('S.ALP_DTACAD',true);
  configurador.fSetVisivel('S.ALP_COLECA',true);
  configurador.fSetVisivel('S.ALP_PRODUT',true);
  configurador.fSetVisivel('S.ALP_CODUNI',true);
  configurador.fSetVisivel('I.ITE_DESITE'  ,true);


  configurador.pAdicionarIndice('S.ALP_CODIGO', 'Código');
  configurador.pAdicionarIndice('S.ALP_DESCRI', 'Descrição');
  configurador.pAdicionarIndice('S.ALP_REFERE', 'Referência');
  configurador.pAdicionarIndice('S.ALP_DTACAD', 'Data Cadastro');
  configurador.pAdicionarIndice('S.ALP_COLECA', 'Coleção');
  configurador.pAdicionarIndice('S.ALP_PRODUT', 'Produto');
  configurador.pAdicionarIndice('S.ALP_CODUNI', 'Cód.Unidade');
  configurador.pAdicionarIndice('I.ITE_DESITE', 'Descrição do Item');



  configurador.pAdicionarCampoDescricao('S.ALP_CODIGO');
  configurador.pAdicionarCampoDescricao('S.ALP_DESCRI');
  configurador.pAdicionarCampoDescricao('S.ALP_REFERE');
  configurador.pAdicionarCampoDescricao('S.ALP_DTACAD');
  configurador.pAdicionarCampoDescricao('S.ALP_COLECA');
  configurador.pAdicionarCampoDescricao('S.ALP_PRODUT');
  configurador.pAdicionarCampoDescricao('S.ALP_CODUNI');
  configurador.pAdicionarCampoDescricao('I.ITE_DESITE');
end;

end.
