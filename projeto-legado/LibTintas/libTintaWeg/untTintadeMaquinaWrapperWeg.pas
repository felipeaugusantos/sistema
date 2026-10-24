{**************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta Weg *}
{***********************************************************************************AC*}
unit untTintadeMaquinaWrapperWeg;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperWeg = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompWeg,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperWeg }

procedure TTintadeMaquinaWrapperWeg.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  //Configurador Weg
  configurador.pAdicionarCampo('WEG_DESCRI', 'Descrição', 'LIKE');
  configurador.pAdicionarCampo('WEG_CODIGO', 'Código', 'LIKE');
  configurador.pAdicionarCampo('WEG_CODIG2', 'Código 2', 'LIKE');
  configurador.pAdicionarCampo('BAS_DESCRI', 'Descrição da Base', 'LIKE');
  configurador.pAdicionarCampo('WEG_UNIDAD', 'Unidade', 'LIKE');
  configurador.pAdicionarCampo('WEG_PROKEY', 'Prod. Key', 'LIKE', False, False);
  configurador.pAdicionarCampo('WEG_SUBKEY', 'Sub. Key', 'LIKE', False, False);
  configurador.pAdicionarCampo('WEG_NOMCOR', 'Nome Cor', 'LIKE', False, True);
  configurador.pAdicionarCampo('CADITE.ITE_CODITE', 'Código do Item', 'LIKE', False, True);
  configurador.pAdicionarCampo('CADITE.ITE_DESITE', 'Descrição do Item', 'LIKE', False, True);
  configurador.pAdicionarCampo('CADITE.ITE_REFERE', 'Referência do Item', 'LIKE', False, True);
  configurador.pAdicionarCampo('WEG_BASE__', 'Base', 'LIKE', False, False);
  configurador.pAdicionarCampo('WEG_MD5KEY', 'MD5KEY', '=', False, True);
  Configurador.pAdicionarCampo('WEG_ACRMOB', 'WEG_ACRMOB', 'LIKE', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');


  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('WEG_FORM' + TStrUtils.fStrZero(intCont, 2), 'WEG_FORM' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('WEG_QTDB' + TStrUtils.fStrZero(intCont, 2), 'WEG_QTDB' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperWeg.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  Result := Result + ' AND UPPER(IFNULL(WEG_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperWeg.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result := '';
  Result := Result + '  WEG_CADWEG ';
  Result := Result + '   INNER JOIN WEG_CADBAS ';
  Result := Result + '     ON WEG_BASE__ = BAS_BASE__ ';
  Result := Result + '       AND WEG_PROKEY = BAS_PROKEY';
  Result := Result + '       AND WEG_SUBKEY = BAS_SUBKEY';
  Result := Result + '       AND WEG_UNIDAD = BAS_UNIDAD ';
  Result := Result + '  	  INNER JOIN CADITE ON CADITE.ITE_CODITE = BAS_CODITE     ';
  Result := Result + '     AND CADITE.ITE_ITEATI = "S"          ';
  Result := Result + '      INNER JOIN ITEGER ON         ';
  Result := Result + '       BAS_CODITE = ITEGER.ITE_CODITE AND    ';
  Result := Result + '       ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
end;

function TTintadeMaquinaWrapperWeg.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(WEG_ATIVAD,"S")) = "S" ';
end;

function TTintadeMaquinaWrapperWeg.GetCampoAutoIncrem: String;
begin
  Result := 'WEG_CADWEG.AUTOINCREM';
end;

function TTintadeMaquinaWrapperWeg.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompWeg.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperWeg.GetNomeTabela: String;
begin
  Result := 'WEG_CADWEG';
end;

procedure TTintadeMaquinaWrapperWeg.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin

  configurador.fSetPos('WEG_DESCRI', 0);
  configurador.fSetPos('WEG_CODIGO', 1);
  configurador.fSetPos('WEG_CODIG2', 2);
  configurador.fSetPos('BAS_DESCRI', 3);
  configurador.fSetPos('WEG_UNIDAD', 4);
  configurador.fSetPos('WEG_PROKEY', 5);
  configurador.fSetPos('WEG_SUBKEY', 6);
  configurador.fSetPos('WEG_NOMCOR', 7);
  configurador.fSetPos('CADITE.ITE_CODITE', 8);
  configurador.fSetPos('CADITE.ITE_DESITE', 9);
  configurador.fSetPos('CADITE.ITE_REFERE', 10);
  configurador.fSetPos('WEG_BASE__', 11);


  configurador.fSetVisivel('WEG_DESCRI', True);
  configurador.fSetVisivel('WEG_CODIGO', True);
  configurador.fSetVisivel('WEG_CODIG2', True);
  configurador.fSetVisivel('BAS_DESCRI', True);
  configurador.fSetVisivel('WEG_UNIDAD', True);
  configurador.fSetVisivel('WEG_PROKEY', False);
  configurador.fSetVisivel('WEG_SUBKEY', False);
  configurador.fSetVisivel('WEG_NOMCOR', False);
  configurador.fSetVisivel('CADITE.ITE_CODITE', False);
  configurador.fSetVisivel('CADITE.ITE_DESITE', False);
  configurador.fSetVisivel('CADITE.ITE_REFERE', False);
  configurador.fSetVisivel('WEG_BASE__', False);

  configurador.pAdicionarIndice('WEG_DESCRI', 'Descrição');
  configurador.pAdicionarIndice('WEG_CODIGO', 'Código');
  configurador.pAdicionarIndice('WEG_CODIG2', 'Código 2');


  configurador.pAdicionarCampoDescricao('WEG_DESCRI');
  configurador.pAdicionarCampoDescricao('WEG_CODIGO');
  configurador.pAdicionarCampoDescricao('WEG_CODIG2');
  configurador.pAdicionarCampoDescricao('BAS_DESCRI');
  configurador.pAdicionarCampoDescricao('WEG_UNIDAD');
end;

end.
