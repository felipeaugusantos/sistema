{**************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta Resicolor *}
{***********************************************************************************AC*}
unit untTintadeMaquinaWrapperResicolor;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperResicolor = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompResicolor,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperResicolor }

procedure TTintadeMaquinaWrapperResicolor.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  //Configurador Resicolor
  Configurador.pAdicionarCampo('RSI_DESCRI', 'Descrição' , 'LIKE');
  Configurador.pAdicionarCampo('RSI_CODIGO', 'Código', 'LIKE');
  Configurador.pAdicionarCampo('RSI_CODIG2', 'Código 2', 'LIKE');
  Configurador.pAdicionarCampo('RSI_UNIDAD', 'Unidade', 'LIKE');
  Configurador.pAdicionarCampo('RSI_BASE__', 'Base',  'LIKE');
  Configurador.pAdicionarCampo('RSI_PROKEY', 'Prod. Key', 'LIKE');
  Configurador.pAdicionarCampo('RSI_SUBKEY', 'Sub. Key', 'LIKE');
  Configurador.pAdicionarCampo('CADITE.ITE_CODITE', 'Código do Item', 'LIKE');
  Configurador.pAdicionarCampo('CADITE.ITE_DESITE', 'Descrição do Item', 'LIKE');
  Configurador.pAdicionarCampo('CADITE.ITE_REFERE', 'Referência do Item', 'LIKE');
  Configurador.pAdicionarCampo('RSI_MD5KEY', 'Chave MD5', '=', False, True);
  Configurador.pAdicionarCampo('RSI_ACRMOB', 'RSI_ACRMOB', 'LIKE', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');


  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('RSI_FORM' + TStrUtils.fStrZero(intCont, 2), 'RSI_FORM' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('RSI_QTDB' + TStrUtils.fStrZero(intCont, 2), 'RSI_QTDB' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperResicolor.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  Result := Result + ' AND UPPER(IFNULL(RSI_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperResicolor.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result := '';
  Result := Result + '  RSI_CADRSI ';
  Result := Result + '   INNER JOIN RSI_CADBAS ';
  Result := Result + '     ON RSI_BASE__ = BAS_BASE__ ';
  Result := Result + '       AND RSI_PROKEY = BAS_PROKEY ';
  Result := Result + '       AND RSI_SUBKEY = BAS_SUBKEY ';
  Result := Result + '       AND RSI_UNIDAD = BAS_UNIDAD ';
  Result := Result + '  	  INNER JOIN CADITE ON CADITE.ITE_CODITE = BAS_CODITE     ';
  Result := Result + '     AND CADITE.ITE_ITEATI = "S"          ';
  Result := Result + '      INNER JOIN ITEGER ON         ';
  Result := Result + '       BAS_CODITE = ITEGER.ITE_CODITE AND    ';
  Result := Result + '       ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
end;

function TTintadeMaquinaWrapperResicolor.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(RSI_ATIVAD,"S")) = "S" ';
end;

function TTintadeMaquinaWrapperResicolor.GetCampoAutoIncrem: String;
begin
  Result := 'RSI_CADRSI.AUTOINCREM';
end;

function TTintadeMaquinaWrapperResicolor.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompResicolor.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')), //TAutcomTintaFactory.Get.fCfgSis('TABPAD', varString)
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperResicolor.GetNomeTabela: String;
begin
  Result := 'RSI_CADRSI';
end;

procedure TTintadeMaquinaWrapperResicolor.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin

  Configurador.fSetPos('RSI_DESCRI', 0);
  Configurador.fSetPos('RSI_CODIGO', 1);
  Configurador.fSetPos('RSI_CODIG2', 2);
  Configurador.fSetPos('RSI_UNIDAD', 3);
  Configurador.fSetPos('RSI_BASE__', 4);
  Configurador.fSetPos('RSI_PROKEY', 5);
  Configurador.fSetPos('RSI_SUBKEY', 6);
  Configurador.fSetPos('CADITE.ITE_CODITE', 7);
  Configurador.fSetPos('CADITE.ITE_DESITE', 8);
  Configurador.fSetPos('CADITE.ITE_REFERE', 9);


  Configurador.fSetVisivel('RSI_DESCRI' , True);
  Configurador.fSetVisivel('RSI_CODIGO' , True);
  Configurador.fSetVisivel('RSI_CODIG2' , True);
  Configurador.fSetVisivel('RSI_UNIDAD' , True);
  Configurador.fSetVisivel('RSI_BASE__' , False);
  Configurador.fSetVisivel('RSI_PROKEY' , False);
  Configurador.fSetVisivel('RSI_SUBKEY' , False);
  Configurador.fSetVisivel('CADITE.ITE_CODITE' , False);
  Configurador.fSetVisivel('CADITE.ITE_DESITE' , False);
  Configurador.fSetVisivel('CADITE.ITE_REFERE' , False);

  Configurador.pAdicionarIndice('RSI_DESCRI', 'Descrição');
  Configurador.pAdicionarIndice('RSI_CODIGO', 'Código');
  Configurador.pAdicionarIndice('RSI_CODIG2', 'Código 2');

  Configurador.pAdicionarCampoDescricao('RSI_CODIGO');
  Configurador.pAdicionarCampoDescricao('RSI_DESCRI');
  Configurador.pAdicionarCampoDescricao('RSI_UNIDAD');
end;

end.
