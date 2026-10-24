{**************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta Futura           *}
{***********************************************************************************AC*}
unit untTintadeMaquinaWrapperFutura;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperFutura = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompFutura,
{$ENDIF}
   untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperFutura }

procedure TTintadeMaquinaWrapperFutura.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  configurador.pAdicionarCampo('FUT_DESCRI', 'Descrição',          'LIKE');
  configurador.pAdicionarCampo('FUT_DTACAD', 'Data Cadastro',      'LIKE');
  configurador.pAdicionarCampo('FUT_REFERE', 'Referência',         'LIKE');
  configurador.pAdicionarCampo('FUT_UNIDAD', 'Unidade',            'LIKE');
  configurador.pAdicionarCampo('FUT_PRODUT', 'Produto',            'LIKE');
  configurador.pAdicionarCampo('FUT_SPRODU', 'Sub Produto',        'LIKE');
  configurador.pAdicionarCampo('FUT_CODBAS', 'Código Base',        'LIKE');
  configurador.pAdicionarCampo('FUT_NOMCOR', 'Nome da Cor'       , 'LIKE');
  configurador.pAdicionarCampo('BAS_CODITE', 'Código Item',        'LIKE');
  configurador.pAdicionarCampo('FUT_MENSAG', 'Mensagem',           'LIKE');
  configurador.pAdicionarCampo('CADITE.ITE_CODITE', 'Código do Item',     'LIKE');
  configurador.pAdicionarCampo('CADITE.ITE_DESITE', 'Descrição do Item',  'LIKE');
  configurador.pAdicionarCampo('CADITE.ITE_REFERE', 'Referência do Item', 'LIKE');
  configurador.pAdicionarCampo('FUT_MD5KEY', 'MD5KEY', '=', False, True);
  Configurador.pAdicionarCampo('FUT_ACRMOB', 'FUT_ACRMOB',         'LIKE', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');


  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('FUT_FORM' + TStrUtils.fStrZero(intCont, 2), 'FUT_FORM' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('FUT_QTDB' + TStrUtils.fStrZero(intCont, 2), 'FUT_QTDB' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperFutura.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  If TAutcomTintaFactory.Get.fGetConfTinta('FUT').fGetBoolean('USAFOR') Then
    Result := Result + '     AND FUT_QTDB01 > 0.0 ';

  Result := Result + ' AND UPPER(IFNULL(FUT_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperFutura.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result := Result + '  FUT_CADFUT  ';
  Result := Result + '   INNER JOIN FUT_CADBAS  ';
  Result := Result + '     ON FUT_CODBAS = BAS_CODBAS ';
  Result := Result + '       AND FUT_UNIDAD = BAS_CODUNI ';
  Result := Result + '       AND FUT_PRODUT = BAS_PRODUT ';
  Result := Result + '   INNER JOIN CADITE ';

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

function TTintadeMaquinaWrapperFutura.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(FUT_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperFutura.GetCampoAutoIncrem: String;
begin
  Result := 'FUT_CADFUT.AUTOINCREM';
end;

function TTintadeMaquinaWrapperFutura.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompFutura.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')), //TAutcomTintaFactory.Get.fCfgSis('TABPAD', varString)
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperFutura.GetNomeTabela: String;
begin
  Result := 'FUT_CADFUT';
end;

procedure TTintadeMaquinaWrapperFutura.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  configurador.fSetPos('FUT_DESCRI', 0);
  configurador.fSetPos('FUT_REFERE', 1);
  configurador.fSetPos('FUT_UNIDAD', 2);
  configurador.fSetPos('FUT_PRODUT', 3);
  configurador.fSetPos('FUT_SPRODU', 4);
  configurador.fSetPos('FUT_CODBAS', 5);
  configurador.fSetPos('BAS_CODITE', 6);
  configurador.fSetPos('CADITE.ITE_DESITE', 7);
  configurador.fSetPos('FUT_NOMCOR', 8);

  configurador.fSetVisivel('FUT_DESCRI', True);
  configurador.fSetVisivel('FUT_REFERE', True);
  configurador.fSetVisivel('FUT_UNIDAD', True);
  configurador.fSetVisivel('FUT_PRODUT', True);
  configurador.fSetVisivel('FUT_SPRODU', True);
  configurador.fSetVisivel('FUT_CODBAS', True);
  configurador.fSetVisivel('BAS_CODITE', True);
  configurador.fSetVisivel('CADITE.ITE_DESITE', True);
  configurador.fSetVisivel('FUT_NOMCOR', True);

  configurador.pAdicionarIndice('FUT_DESCRI+FUT_REFERE+FUT_SPRODU', 'Descrição/Referência/Sub Produto/Nome da Cor');
  configurador.pAdicionarIndice('FUT_CODBAS+FUT_PRODUT+FUT_SPRODU', 'Código Base/Produto/Sub Produto/Nome da Cor');

  configurador.pAdicionarCampoDescricao('FUT_DESCRI');
  configurador.pAdicionarCampoDescricao('FUT_REFERE');
  configurador.pAdicionarCampoDescricao('FUT_UNIDAD');
  configurador.pAdicionarCampoDescricao('FUT_PRODUT');
  configurador.pAdicionarCampoDescricao('FUT_SPRODU');
  configurador.pAdicionarCampoDescricao('FUT_CODBAS');
  configurador.pAdicionarCampoDescricao('BAS_CODITE');
  configurador.pAdicionarCampoDescricao('CADITE.ITE_DESITE');
  configurador.pAdicionarCampoDescricao('FUT_NOMCOR');
end;

end.
