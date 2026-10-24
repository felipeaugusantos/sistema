{**************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta Montana *}
{***********************************************************************************AC*}
unit untTintadeMaquinaWrapperMontana;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperMontana = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompMontana,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperMontana }

procedure TTintadeMaquinaWrapperMontana.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  configurador.pAdicionarCampo('MON_CODSEQ', 'Código', 'LIKE');
  configurador.pAdicionarCampo('MON_DESCOR', 'Cor', 'LIKE');
  configurador.pAdicionarCampo('MON_PRODUT', 'Produto', 'LIKE');
  configurador.pAdicionarCampo('MON_DESCRI', 'Descrição', 'LIKE');
  configurador.pAdicionarCampo('MON_CODBAS', 'Código da Base', 'LIKE');
  configurador.pAdicionarCampo('BAS_DESCRI', 'Descrição da Base', 'LIKE');
  configurador.pAdicionarCampo('MON_ACABAM', 'Acabamento', 'LIKE');
  configurador.pAdicionarCampo('MON_UNIDAD', 'Unidade', 'LIKE');
  configurador.pAdicionarCampo('MON_DTACAD', 'Data de Cadastro', 'DATE');
  configurador.pAdicionarCampo('CADITE.ITE_CODITE', 'Código do Item', 'LIKE');
  configurador.pAdicionarCampo('CADITE.ITE_DESITE', 'Descrição do Item', 'LIKE');
  configurador.pAdicionarCampo('CADITE.ITE_REFERE', 'Referência do Item', 'LIKE');
  configurador.pAdicionarCampo('MON_MD5KEY', 'MD5KEY', '=', False, True);
  Configurador.pAdicionarCampo('MON_ACRMOB', 'MON_ACRMOB', 'LIKE', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');

  for intCont := 1 to 20 do
  begin
    configurador.pAdicionarCampo('MON_FORM' + TStrUtils.fStrZero(intCont, 2),  'MON_FORM' + TStrUtils.fStrZero(intCont, 2),
          'LIKE', False, False);

    configurador.pAdicionarCampo('MON_QTDC' + TStrUtils.fStrZero(intCont, 2),  'MON_QTDC' + TStrUtils.fStrZero(intCont, 2),
          '=', False, False);
  end;
end;

function TTintadeMaquinaWrapperMontana.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  If TAutcomTintaFactory.Get.fGetConfTinta('MON').fGetBoolean('USAFOR') Then
    Result := Result + '     AND MON_QTDC01 > 0.0 ';

  Result := Result + ' AND UPPER(IFNULL(MON_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperMontana.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result := '';
  Result := Result + ' MON_CADMON';
  Result := Result + ' INNER JOIN MON_CADBAS ON BAS_CODBAS = MON_CODBAS';
  Result := Result + '                      AND BAS_UNIDAD = MON_UNIDAD';
  Result := Result + '                      AND BAS_PRODUT = MON_PRODUT';
  Result := Result + '                      AND BAS_ACABAM = MON_ACABAM';
  Result := Result + '  INNER JOIN CADITE ';

  If TStrUtils.fEmptyStr(configurador.GetCodIte) Then
  Begin
    Result := Result + '     ON BAS_CODITE = CADITE.ITE_CODITE ';
    Result := Result + '     AND CADITE.ITE_ITEATI = "S"          ';
    Result := Result + '     INNER JOIN ITEGER ON         ';
    Result := Result + '       BAS_CODITE = ITEGER.ITE_CODITE AND    ';
    Result := Result + '       ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
  End
  Else
  Begin
    Result := Result + '     ON ' + AnsiQuotedStr(configurador.GetCodIte, '"') + ' = CADITE.ITE_CODITE ';
    Result := Result + '     AND CADITE.ITE_ITEATI = "S"          ';
    Result := Result + '     INNER JOIN ITEGER ON         ';
    Result := Result + AnsiQuotedStr(configurador.GetCodIte, '"') + ' = ITEGER.ITE_CODITE AND ';
    Result := Result + '       ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
  End;
end;

function TTintadeMaquinaWrapperMontana.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(MON_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperMontana.GetCampoAutoIncrem: String;
begin
  Result := 'MON_CADMON.AUTOINCREM';
end;

function TTintadeMaquinaWrapperMontana.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompMontana.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')), //TAutcomTintaFactory.Get.fCfgSis('TABPAD', varString)
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperMontana.GetNomeTabela: String;
begin
  Result := 'MON_CADMON';
end;

procedure TTintadeMaquinaWrapperMontana.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  configurador.fSetPos('MON_CODSEQ', 0);
  configurador.fSetPos('MON_DESCOR', 1);
  configurador.fSetPos('MON_DESCRI', 2);
  configurador.fSetPos('MON_CODBAS', 3);
  configurador.fSetPos('MON_PRODUT', 4);
  configurador.fSetPos('MON_UNIDAD', 5);
  configurador.fSetPos('MON_DTACAD', 6);
  configurador.fSetPos('MON_ACABAM', 7);

  configurador.fSetVisivel('MON_CODSEQ', True);
  configurador.fSetVisivel('MON_DESCOR', True);
  configurador.fSetVisivel('MON_DESCRI', True);
  configurador.fSetVisivel('MON_CODBAS', True);
  configurador.fSetVisivel('MON_PRODUT', True);
  configurador.fSetVisivel('MON_UNIDAD', True);
  configurador.fSetVisivel('MON_DTACAD', True);
  configurador.fSetVisivel('MON_ACABAM', True);

  configurador.pAdicionarIndice('MON_DESCOR', 'Cor');
  configurador.pAdicionarIndice('MON_DESCRI', 'Descrição');
  configurador.pAdicionarIndice('MON_CODBAS', 'Código da Base');
  configurador.pAdicionarIndice('MON_PRODUT', 'Produto');
  configurador.pAdicionarIndice('MON_UNIDAD', 'Unidade');
  configurador.pAdicionarIndice('MON_ACABAM', 'Acabamento');


  configurador.pAdicionarCampoDescricao('MON_CODSEQ');
  configurador.pAdicionarCampoDescricao('MON_DESCOR');
  configurador.pAdicionarCampoDescricao('MON_DESCRI');
  configurador.pAdicionarCampoDescricao('MON_CODBAS');
  configurador.pAdicionarCampoDescricao('MON_PRODUT');
  configurador.pAdicionarCampoDescricao('MON_UNIDAD');
  configurador.pAdicionarCampoDescricao('MON_DTACAD');
  configurador.pAdicionarCampoDescricao('MON_ACABAM');
end;

end.
