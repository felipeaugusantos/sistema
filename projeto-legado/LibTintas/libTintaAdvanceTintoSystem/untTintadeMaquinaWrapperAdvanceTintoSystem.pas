{**************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta AdvanceTintoSystem *}
{***********************************************************************************AC*}
unit untTintadeMaquinaWrapperAdvanceTintoSystem;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperAdvanceTintoSystem = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompAdvanceTintoSystem,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperAdvanceTintoSystem }

procedure TTintadeMaquinaWrapperAdvanceTintoSystem.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  configurador.pAdicionarCampo('ADT_IDFORM', 'Fórmula', 'LIKE');
  configurador.pAdicionarCampo('ADT_CODCOR', 'Código Cor', 'LIKE');
  configurador.pAdicionarCampo('ADT_CODTEC', 'Código Tecnico', 'LIKE');
  configurador.pAdicionarCampo('ADT_PRODUT', 'PRODUTO', 'LIKE');
  configurador.pAdicionarCampo('ADT_CODBAS', 'Código da Base', 'LIKE');
  configurador.pAdicionarCampo('ADT_CODEMB', 'Código da Embalagem', 'LIKE', False, False);
  configurador.pAdicionarCampo('ADT_CODCAT', 'Código do Catalisador', 'LIKE');
  configurador.pAdicionarCampo('BAS_DESCRI', 'Descrição da Base', 'LIKE');
  configurador.pAdicionarCampo('CADITE.ITE_CODITE', 'Código do Item', 'LIKE');
  configurador.pAdicionarCampo('CADITE.ITE_DESITE', 'Descrição do Item', 'LIKE');
  configurador.pAdicionarCampo('EMB_DESCRI', 'Descrição da Embalagem',  'LIKE', False, False);
  configurador.pAdicionarCampo('UNI_CODUNI', 'Código da Unidade', 'LIKE', False, False);
  configurador.pAdicionarCampo('UNI_DESUNI', 'Descrição da Unidade',  'LIKE', False, False);
  configurador.pAdicionarCampo('UNI_SIGUNI', 'Sigla da Unidade',  'LIKE', False, False);
  configurador.pAdicionarCampo('ADT_QTDFIN', 'Volume Final', '=', False, False);
  configurador.pAdicionarCampo('ADT_QTDBAS', 'Volume da Base', '=', False, False);
  configurador.pAdicionarCampo('ADT_QTDCAT', 'Volume do Catalisador', '=', False, False);
  configurador.pAdicionarCampo('ADT_QTD_ML', 'Volume dos Colorantes', '=', False, False);
  configurador.pAdicionarCampo('ADT_MD5KEY', 'Chave MD5', '=', False, True);
  configurador.pAdicionarCampo('BAS_CODEMB', 'Embalagem da Base', 'LIKE', False, False);
  configurador.pAdicionarCampo('ADT_ACRMOB', 'Acrescimo Mão de Oba', 'LIKE', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');


  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('ADT_CODC' + TStrUtils.fStrZero(intCont, 2), 'ADT_CODC' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);

    configurador.pAdicionarCampo('ADT_QTDC' + TStrUtils.fStrZero(intCont, 2), 'ADT_QTDC' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperAdvanceTintoSystem.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  If TAutcomTintaFactory.Get.fGetConfTinta('ADT').fGetBoolean('USAFOR') Then
    Result := Result + '     AND ADT_QTDC01 > 0.0 ';

  Result := Result + ' AND UPPER(IFNULL(ADT_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperAdvanceTintoSystem.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result := '';
  Result := Result + '   ADT_CADADT                    ';
  Result := Result + '   INNER JOIN ADT_CADBAS         ';
  Result := Result + '     ON ADT_CODBAS = BAS_CODBAS  ';
  Result := Result + '     AND ADT_PRODUT = BAS_PRODUT ';
  Result := Result + '     AND ADT_CODEMB = BAS_CODEMB ';
  Result := Result + '   INNER JOIN ADT_CADEMB         ';
  Result := Result + '     ON BAS_CODEMB = EMB_CODEMB  ';
  Result := Result + '   INNER JOIN CADUNI             ';
  Result := Result + '     ON EMB_CODUNI = UNI_CODUNI  ';
  Result := Result + '   INNER JOIN CADITE             ';
  Result := Result + '     ON BAS_CODITE = CADITE.ITE_CODITE  ';
  Result := Result + '     AND CADITE.ITE_ITEATI = "S"          ';
  Result := Result + '   INNER JOIN ITEGER ON          ';
  Result := Result + '       BAS_CODITE = ITEGER.ITE_CODITE AND    ';
  Result := Result + '       ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
end;

function TTintadeMaquinaWrapperAdvanceTintoSystem.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(ADT_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperAdvanceTintoSystem.GetCampoAutoIncrem: String;
begin
  Result := 'ADT_CADADT.AUTOINCREM';
end;

function TTintadeMaquinaWrapperAdvanceTintoSystem.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompAdvanceTintoSystem.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')), //TAutcomTintaFactory.Get.fCfgSis('TABPAD', varString)
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperAdvanceTintoSystem.GetNomeTabela: String;
begin
  Result := 'ADT_CADADT';
end;

procedure TTintadeMaquinaWrapperAdvanceTintoSystem.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  configurador.fSetPos('ADT_IDFORM', 0);
  configurador.fSetPos('ADT_CODCOR', 1);
  configurador.fSetPos('ADT_CODTEC', 2);
  configurador.fSetPos('ADT_PRODUT', 3);
  configurador.fSetPos('ADT_CODBAS', 4);
  configurador.fSetPos('BAS_CODCAT', 5);


  configurador.fSetVisivel('ADT_IDFORM', True);
  configurador.fSetVisivel('ADT_CODCOR', True);
  configurador.fSetVisivel('ADT_CODTEC', True);
  configurador.fSetVisivel('ADT_PRODUT', True);
  configurador.fSetVisivel('ADT_CODBAS', True);
  configurador.fSetVisivel('ADT_CODCAT', True);


  configurador.pAdicionarIndice('ADT_PRODUT+ADT_CODCOR+ADT_CODTEC', 'Produto/Código Cor/Código Técnico');
  configurador.pAdicionarIndice('ADT_CODBAS+ADT_CODCAT', 'Código Base/Código do Catalisador');


  configurador.pAdicionarCampoDescricao('ADT_CODCOR');
  configurador.pAdicionarCampoDescricao('ADT_PRODUT');
  configurador.pAdicionarCampoDescricao('ADT_CODTEC');
  configurador.pAdicionarCampoDescricao('EMB_DESCRI');
end;

end.
