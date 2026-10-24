{**************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta AnjoSintetica *}
{***********************************************************************************AC*}
unit untTintadeMaquinaWrapperAnjoSintetica;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperAnjoSintetica = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompAnjoSintetica,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperAnjoSintetica }

procedure TTintadeMaquinaWrapperAnjoSintetica.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  //Configurador AnjoSintetica
  configurador.pAdicionarCampo('AJA_DESCRI', 'Descrição', 'LIKE');
  configurador.pAdicionarCampo('AJA_CODIGO', 'Código', 'LIKE');
  configurador.pAdicionarCampo('AJA_CODIG2', 'Código 2', 'LIKE');
  configurador.pAdicionarCampo('BAS_DESCRI', 'Descrição da Base', 'LIKE');
  configurador.pAdicionarCampo('AJA_UNIDAD', 'Unidade', 'LIKE');
  configurador.pAdicionarCampo('AJA_MD5KEY', 'MD5KEY', '=', False, True);
  configurador.pAdicionarCampo('CADITE.ITE_CODITE', 'Codigo do Item', 'LIKE', False, True);
  configurador.pAdicionarCampo('CADITE.ITE_DESITE', 'Descrição do Item', 'LIKE', False, True);
  configurador.pAdicionarCampo('CADITE.ITE_REFERE', 'Referencia do Item', 'LIKE', False, True );
  configurador.pAdicionarCampo('AJA_PROKEY', 'Prod. Key', 'LIKE', False, False);
  configurador.pAdicionarCampo('AJA_SUBKEY', 'Sub. Key', 'LIKE', False, False);
  configurador.pAdicionarCampo('AJA_BASE__', 'Base', 'LIKE', False, False);
  Configurador.pAdicionarCampo('AJA_ACRMOB', 'AJA_ACRMOB', 'LIKE', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');


  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('AJA_FORM' + TStrUtils.fStrZero(intCont, 2), 'AJA_FORM' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('AJA_QTDB' + TStrUtils.fStrZero(intCont, 2), 'AJA_QTDB' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperAnjoSintetica.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  Result := Result + ' AND UPPER(IFNULL(AJA_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperAnjoSintetica.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result := '';
  Result := Result + '  AJA_CADAJA ';
  Result := Result + '   INNER JOIN AJA_CADBAS ';
  Result := Result + '     ON AJA_BASE__ = BAS_BASE__ ';
  Result := Result + '      AND AJA_PROKEY = BAS_PROKEY  ';
  Result := Result + '      AND AJA_SUBKEY = BAS_SUBKEY   ';
  Result := Result + '      AND AJA_UNIDAD = BAS_UNIDAD ';
  Result := Result + '  	  INNER JOIN CADITE ON CADITE.ITE_CODITE = BAS_CODITE     ';
  Result := Result + '     AND CADITE.ITE_ITEATI = "S"          ';
  Result := Result + '      INNER JOIN ITEGER ON         ';
  Result := Result + '       BAS_CODITE = ITEGER.ITE_CODITE AND    ';
  Result := Result + '       ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
end;

function TTintadeMaquinaWrapperAnjoSintetica.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(AJA_ATIVAD,"S")) = "S" ';
end;

function TTintadeMaquinaWrapperAnjoSintetica.GetCampoAutoIncrem: String;
begin
  Result := 'AJA_CADAJA.AUTOINCREM';
end;

function TTintadeMaquinaWrapperAnjoSintetica.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompAnjoSintetica.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')), //TAutcomTintaFactory.Get.fCfgSis('TABPAD', varString)
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperAnjoSintetica.GetNomeTabela: String;
begin
  Result := 'AJA_CADAJA';
end;

procedure TTintadeMaquinaWrapperAnjoSintetica.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin

  configurador.fSetPos('AJA_DESCRI', 0);
  configurador.fSetPos('AJA_CODIGO', 1);
  configurador.fSetPos('AJA_CODIG2', 2);
  configurador.fSetPos('BAS_DESCRI', 3);
  configurador.fSetPos('AJA_UNIDAD', 4);

  configurador.fSetVisivel('AJA_DESCRI' , True);
  configurador.fSetVisivel('AJA_CODIGO' , True);
  configurador.fSetVisivel('AJA_CODIG2' , True);
  configurador.fSetVisivel('BAS_DESCRI' , True);
  configurador.fSetVisivel('AJA_UNIDAD' , True);

  configurador.pAdicionarIndice('AJA_DESCRI', 'Descrição');
  configurador.pAdicionarIndice('AJA_CODIGO', 'Código');
  configurador.pAdicionarIndice('AJA_CODIG2', 'Código 2');


  configurador.pAdicionarCampoDescricao('AJA_DESCRI');
  configurador.pAdicionarCampoDescricao('AJA_CODIGO');
  configurador.pAdicionarCampoDescricao('AJA_CODIG2');
  configurador.pAdicionarCampoDescricao('BAS_DESCRI');
  configurador.pAdicionarCampoDescricao('AJA_UNIDAD');
end;

end.
