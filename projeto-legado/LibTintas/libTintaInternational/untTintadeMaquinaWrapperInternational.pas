{**************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta International *}
{***********************************************************************************AC*}
unit untTintadeMaquinaWrapperInternational;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperInternational = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompInternational,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperInternational }

procedure TTintadeMaquinaWrapperInternational.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin

  Configurador.pAdicionarCampo('INT_DESCOR', 'Cor', 'LIKE');
  Configurador.pAdicionarCampo('INT_CODBAS', 'Base', 'LIKE');
  Configurador.pAdicionarCampo('INT_CODNFM', 'Código Novas Fórmulas', 'LIKE');
  Configurador.pAdicionarCampo('I.ITE_CODITE', 'Código do Item', 'LIKE');
  Configurador.pAdicionarCampo('ITE_DESITE', 'Descrição do Item', 'LIKE');
  Configurador.pAdicionarCampo('INT_CODINT', 'Código International', 'LIKE');
  Configurador.pAdicionarCampo('INT_MD5KEY', 'Chave MD5', 'LIKE', False, True);
  Configurador.pAdicionarCampo('INT_CODEMB', 'Embalagem', 'LIKE', False, True);
  Configurador.pAdicionarCampo('INT_LINHA_', 'Linha', 'LIKE', False, True);
  Configurador.pAdicionarCampo('ITE_REFERE', 'Referencia do Item', 'LIKE', False, True);
  Configurador.pAdicionarCampo('INT_ACRMOB', 'INT_ACRMOB', 'LIKE', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');

  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('INT_FORM' + TStrUtils.fStrZero(intCont, 2), 'INT_FORM' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('INT_QTDC' + TStrUtils.fStrZero(intCont, 2), 'INT_QTDC' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperInternational.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  If TAutcomTintaFactory.Get.fGetConfTinta('INT').fGetBoolean('USAFOR') Then
    Result := Result + '     AND INT_QTDC01 > 0.0 ';

  Result := Result + ' AND UPPER(IFNULL(INT_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperInternational.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result := '';
  Result := Result + '  INT_CADINT ';
  Result := Result + '   INNER JOIN INT_CADBAS ';
  Result := Result + '     ON INT_CODBAS = BAS_CODBAS ';
  Result := Result + '       AND INT_CODEMB = BAS_CODEMB ';
  Result := Result + '   INNER JOIN CADITE I ';
  Result := Result + '     ON BAS_CODITE = I.ITE_CODITE   ';
  Result := Result + '     AND I.ITE_ITEATI = "S"          ';
  Result := Result + '     INNER JOIN ITEGER ON         ';
  Result := Result + '       BAS_CODITE = ITEGER.ITE_CODITE AND    ';
  Result := Result + '       ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
end;

function TTintadeMaquinaWrapperInternational.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(INT_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperInternational.GetCampoAutoIncrem: String;
begin
  Result := 'INT_CADINT.AUTOINCREM';
end;

function TTintadeMaquinaWrapperInternational.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompInternational.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')), //TAutcomTintaFactory.Get.fCfgSis('TABPAD', varString)
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperInternational.GetNomeTabela: String;
begin
  Result := 'INT_CADINT';
end;

procedure TTintadeMaquinaWrapperInternational.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  Configurador.fSetPos('INT_DESCOR', 0);
  Configurador.fSetPos('INT_CODBAS', 1);
  Configurador.fSetPos('INT_CODNFM', 2);
  Configurador.fSetPos('I.ITE_CODITE', 3);
  Configurador.fSetPos('ITE_DESITE', 4);
  Configurador.fSetPos('ITE_REFERE', 5);
  Configurador.fSetPos('INT_CODEMB', 6);
  Configurador.fSetPos('INT_LINHA_', 7);

  Configurador.fSetVisivel('INT_DESCOR', True);
  Configurador.fSetVisivel('INT_CODBAS', True);
  Configurador.fSetVisivel('INT_CODNFM', True);
  Configurador.fSetVisivel('I.ITE_CODITE', True);
  Configurador.fSetVisivel('ITE_DESITE', True);
  Configurador.fSetVisivel('ITE_REFERE', False);
  Configurador.fSetVisivel('INT_CODEMB', False);
  Configurador.fSetVisivel('INT_LINHA_', False);



  Configurador.pAdicionarIndice('INT_DESCOR+INT_CODBAS+INT_CODEMB', 'Cor/Base/Embalagem');
  Configurador.pAdicionarIndice('INT_DESCOR+INT_LINHA_', 'Cor/Linha');


  Configurador.pAdicionarCampoDescricao('INT_DESCOR');
  Configurador.pAdicionarCampoDescricao('INT_CODBAS');
  Configurador.pAdicionarCampoDescricao('INT_CODNFM');
  Configurador.pAdicionarCampoDescricao('INT_MD5KEY');
  Configurador.pAdicionarCampoDescricao('I.ITE_CODITE');
  Configurador.pAdicionarCampoDescricao('ITE_DESITE');
  Configurador.pAdicionarCampoDescricao('ITE_REFERE');
  Configurador.pAdicionarCampoDescricao('INT_CODEMB');
  Configurador.pAdicionarCampoDescricao('INT_LINHA_');
end;

end.
