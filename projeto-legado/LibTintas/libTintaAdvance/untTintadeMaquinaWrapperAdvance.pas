{**************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta Advance *}
{***********************************************************************************AC*}
unit untTintadeMaquinaWrapperAdvance;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperAdvance = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompAdvance,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperAdvance }

procedure TTintadeMaquinaWrapperAdvance.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  //Configurador Advance

  Configurador.pAdicionarCampo('ADV_DESCRI', 'Descrição', 'LIKE');
  Configurador.pAdicionarCampo('ADV_CODIGO', 'Código', 'LIKE');
  Configurador.pAdicionarCampo('ADV_CODIG2', 'Código 2', 'LIKE');
  Configurador.pAdicionarCampo('BAS_DESCRI', 'Descrição da Base', 'LIKE');
  Configurador.pAdicionarCampo('ADV_UNIDAD', 'Unidade', 'LIKE');
  Configurador.pAdicionarCampo('ADV_PROKEY', 'Produto', 'LIKE', False, False);
  Configurador.pAdicionarCampo('ADV_SUBKEY', 'Sub produto', 'LIKE', False, False);
  Configurador.pAdicionarCampo('ADV_BASE__', 'Base', 'LIKE', False, False);
  Configurador.pAdicionarCampo('CADITE.ITE_CODITE', 'Código do Item', 'LIKE');
  Configurador.pAdicionarCampo('CADITE.ITE_DESITE', 'Descrição do Item', 'LIKE');
  Configurador.pAdicionarCampo('CADITE.ITE_REFERE', 'Referência do Item', 'LIKE');
  Configurador.pAdicionarCampo('ADV_MD5KEY', 'MD5KEY', '=', False, True);
  Configurador.pAdicionarCampo('ADV_ACRMOB', 'ADV_ACRMOB', 'LIKE', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');

  For intCont := 1 To 20 Do
  Begin
    Configurador.pAdicionarCampo('ADV_FORM' + TStrUtils.fStrZero(intCont, 2), 'ADV_FORM' + TStrUtils.fStrZero(intCont, 2), 'LIKE', False, False);
    Configurador.pAdicionarCampo('ADV_QTDB' + TStrUtils.fStrZero(intCont, 2), 'ADV_QTDB' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperAdvance.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  Result := Result + ' AND UPPER(IFNULL(ADV_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperAdvance.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result := '';
  Result := Result + '    ADVCOR_CADADV    ';
  Result := Result + '      INNER JOIN ADVCOR_CADBAS ON     ';
  Result := Result + '    ADV_PROKEY = BAS_PROKEY AND     ';
  Result := Result + '    ADV_SUBKEY = BAS_SUBKEY AND     ';
  Result := Result + '    ADV_BASE__ = BAS_BASE__ AND     ';
  Result := Result + '    ADV_UNIDAD = BAS_UNIDAD         ';
  Result := Result + '      INNER JOIN CADITE ON        ';
  Result := Result + '    BAS_CODITE = CADITE.ITE_CODITE         ';
  Result := Result + '     AND CADITE.ITE_ITEATI = "S"          ';
  Result := Result + '      INNER JOIN ITEGER ON        ';
  Result := Result + '    BAS_CODITE = ITEGER.ITE_CODITE AND   ';
  Result := Result + '    ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
end;

function TTintadeMaquinaWrapperAdvance.fGetWhere: String;
begin
    Result := Result + ' WHERE TRUE ';
    Result := Result + '   AND UPPER(IFNULL(ADV_ATIVAD,"S")) = "S" ';
end;

function TTintadeMaquinaWrapperAdvance.GetCampoAutoIncrem: String;
begin
  Result := 'ADVCOR_CADADV.AUTOINCREM';
end;

function TTintadeMaquinaWrapperAdvance.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompAdvance.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')), //TAutcomTintaFactory.Get.fCfgSis('TABPAD', varString)
    Self
  );
{$ENDIF}
end;


function TTintadeMaquinaWrapperAdvance.GetNomeTabela: String;
begin
  Result := 'ADVCOR_CADADV';
end;

procedure TTintadeMaquinaWrapperAdvance.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  Configurador.fSetPos('ADV_DESCRI', 0);
  Configurador.fSetPos('ADV_CODIGO', 1);
  Configurador.fSetPos('ADV_CODIG2', 2);
  Configurador.fSetPos('BAS_DESCRI', 3);
  Configurador.fSetPos('ADV_UNIDAD', 4);

  Configurador.fSetVisivel('ADV_DESCRI', True);
  Configurador.fSetVisivel('ADV_CODIGO', True);
  Configurador.fSetVisivel('ADV_CODIG2', True);
  Configurador.fSetVisivel('BAS_DESCRI', True);
  Configurador.fSetVisivel('ADV_UNIDAD', True);

  Configurador.pAdicionarIndice('ADV_DESCRI', 'Descrição');
  Configurador.pAdicionarIndice('ADV_CODIGO', 'Código');
  Configurador.pAdicionarIndice('ADV_CODIG2', 'Código 2');

  Configurador.pAdicionarCampoDescricao('ADV_DESCRI');
  Configurador.pAdicionarCampoDescricao('ADV_CODIGO');
  Configurador.pAdicionarCampoDescricao('ADV_CODIG2');
  Configurador.pAdicionarCampoDescricao('BAS_DESCRI');
  Configurador.pAdicionarCampoDescricao('ADV_DESCRI');
end;

end.
