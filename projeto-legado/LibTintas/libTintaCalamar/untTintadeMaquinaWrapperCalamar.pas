{**************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta Calamar *}
{***********************************************************************************AC*}
unit untTintadeMaquinaWrapperCalamar;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperCalamar = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompCalamar,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperCalamar }

procedure TTintadeMaquinaWrapperCalamar.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin

  Configurador.pAdicionarCampo('CAL_CODBAS', 'Código da Base', 'LIKE');
  Configurador.pAdicionarCampo('CAL_KEY1__', 'Key 1', 'LIKE');
  Configurador.pAdicionarCampo('CAL_KEY2__', 'Key 2', 'LIKE');
  Configurador.pAdicionarCampo('CAL_KEY3__', 'Key 3', 'LIKE');
  Configurador.pAdicionarCampo('CAL_CODNFM', 'Código Novas Fórmulas', 'LIKE');
  Configurador.pAdicionarCampo('CADITE.ITE_CODITE', 'Código do Item',  'LIKE');
  Configurador.pAdicionarCampo('CADITE.ITE_DESITE', 'Descrição do Item', 'LIKE');
  Configurador.pAdicionarCampo('CAL_CODEMB', 'Embalagem', 'LIKE');
  Configurador.pAdicionarCampo('CAL_PRODUT', 'Produto', 'LIKE', False, True);
  Configurador.pAdicionarCampo('CAL_MD5KEY', 'Chave MD5', '=', False, True);
  Configurador.pAdicionarCampo('CAL_COLECA', 'Coleção'  , 'LIKE', False, True);
  Configurador.pAdicionarCampo('CAL_ACRMOB', 'CAL_ACRMOB', 'LIKE', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');



  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('CAL_CODC' + TStrUtils.fStrZero(intCont, 2), 'CAL_CODC' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('CAL_QTDC' + TStrUtils.fStrZero(intCont, 2), 'CAL_QTDC' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperCalamar.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  If TAutcomTintaFactory.Get.fGetConfTinta('CAL').fGetBoolean('USAFOR') Then
    Result := Result + '     AND CAL_QTDC01 > 0.0 ';

  Result := Result + ' AND UPPER(IFNULL(CAL_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperCalamar.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result := '';
  Result := Result + '  CAL_CADCAL ';
  Result := Result + '   INNER JOIN CAL_CADBAS ';
  Result := Result + '     ON CAL_CODBAS = BAS_CODBAS ';
  Result := Result + '       AND CAL_CODEMB = BAS_CODEMB ';
  Result := Result + '   INNER JOIN CADITE ';
  Result := Result + '     ON BAS_CODITE = CADITE.ITE_CODITE ';
  Result := Result + '     AND CADITE.ITE_ITEATI = "S"          ';
  Result := Result + '   INNER JOIN ITEGER ON         ';
  Result := Result + '       BAS_CODITE = ITEGER.ITE_CODITE AND    ';
  Result := Result + '       ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
end;

function TTintadeMaquinaWrapperCalamar.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(CAL_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperCalamar.GetCampoAutoIncrem: String;
begin
  Result := 'CAL_CADCAL.AUTOINCREM';
end;

function TTintadeMaquinaWrapperCalamar.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompCalamar.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')), //TAutcomTintaFactory.Get.fCfgSis('TABPAD', varString)
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperCalamar.GetNomeTabela: String;
begin
  Result := 'CAL_CADCAL';
end;

procedure TTintadeMaquinaWrapperCalamar.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  Configurador.fSetPos('CAL_CODBAS', 0);
  Configurador.fSetPos('CAL_KEY1__', 1);
  Configurador.fSetPos('CAL_KEY2__', 2);
  Configurador.fSetPos('CAL_KEY3__', 3);
  Configurador.fSetPos('CAL_CODNFM', 4);
  Configurador.fSetPos('CADITE.ITE_CODITE', 5);
  Configurador.fSetPos('CADITE.ITE_DESITE', 6);
  Configurador.fSetPos('CAL_CODEMB', 7);

  Configurador.fSetVisivel('CAL_CODBAS', True);
  Configurador.fSetVisivel('CAL_KEY1__', True);
  Configurador.fSetVisivel('CAL_KEY2__', True);
  Configurador.fSetVisivel('CAL_KEY3__', True);
  Configurador.fSetVisivel('CAL_CODNFM', True);
  Configurador.fSetVisivel('CADITE.ITE_CODITE', True);
  Configurador.fSetVisivel('CADITE.ITE_DESITE', True);
  Configurador.fSetVisivel('CAL_CODEMB', True);

  configurador.pAdicionarIndice('CAL_KEY1__+CAL_KEY2__+CAL_KEY3__', 'Key 1/Key 2/Key 3');


  Configurador.pAdicionarCampoDescricao('CAL_CODBAS');
  Configurador.pAdicionarCampoDescricao('CAL_KEY1__');
  Configurador.pAdicionarCampoDescricao('CAL_KEY2__');
  Configurador.pAdicionarCampoDescricao('CAL_KEY3__');

end;

end.
