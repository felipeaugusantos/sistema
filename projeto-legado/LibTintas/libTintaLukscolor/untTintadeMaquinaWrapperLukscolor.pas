{**************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta Lukscolor *}
{***********************************************************************************AC*}
unit untTintadeMaquinaWrapperLukscolor;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperLukscolor = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompLukscolor,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperLukscolor }

procedure TTintadeMaquinaWrapperLukscolor.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  //Configurador Lukscolor
  Configurador.pAdicionarCampo('LKD_DESCRI', 'Descrição', 'LIKE');
  Configurador.pAdicionarCampo('LKD_CODIGO', 'Código',  'LIKE');
  Configurador.pAdicionarCampo('LKD_CODIG2', 'Código 2', 'LIKE');
  Configurador.pAdicionarCampo('LKD_DESCRI', 'Descrição da Base', 'LIKE');
  Configurador.pAdicionarCampo('LKD_UNIDAD', 'Unidade', 'LIKE');
  Configurador.pAdicionarCampo('LKD_SUBKEY', 'Sub. Key', 'LIKE', False, True);
  Configurador.pAdicionarCampo('LKD_BASE__', 'Base', 'LIKE', False, True);
  Configurador.pAdicionarCampo('LKD_PROKEY', 'Prod. Key', 'LIKE', False, True);
  Configurador.pAdicionarCampo('CADITE.ITE_CODITE', 'Código do Item', 'LIKE', False, True);
  Configurador.pAdicionarCampo('CADITE.ITE_DESITE', 'Descrição do Item', 'LIKE', False, True);
  Configurador.pAdicionarCampo('CADITE.ITE_REFERE', 'Referência do Item', 'LIKE', False, True);
  Configurador.pAdicionarCampo('LKD_MD5KEY', 'Chave MD5', '=', False, True);
  Configurador.pAdicionarCampo('LKD_ACRMOB', 'LKD_ACRMOB', 'LIKE', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');

  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('LKD_FORM' + TStrUtils.fStrZero(intCont, 2), 'LKD_FORM' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('LKD_QTDB' + TStrUtils.fStrZero(intCont, 2), 'LKD_QTDB' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperLukscolor.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  Result := Result + ' AND UPPER(IFNULL(LKD_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperLukscolor.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin

  Result := '';
  Result := Result + '  LKD_CADLKD ';
  Result := Result + '   INNER JOIN LKD_CADBAS ';
  Result := Result + '     ON LKD_BASE__ = BAS_BASE__ ';
  Result := Result + '       AND LKD_PROKEY = BAS_PROKEY ';
  Result := Result + '       AND LKD_SUBKEY = BAS_SUBKEY ';
  Result := Result + '       AND LKD_UNIDAD = BAS_UNIDAD ';
  Result := Result + '  	  INNER JOIN CADITE ON CADITE.ITE_CODITE = BAS_CODITE     ';
  Result := Result + '     AND CADITE.ITE_ITEATI = "S"          ';
  Result := Result + '      INNER JOIN ITEGER ON         ';
  Result := Result + '       BAS_CODITE = ITEGER.ITE_CODITE AND    ';
  Result := Result + '       ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
end;

function TTintadeMaquinaWrapperLukscolor.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(LKD_ATIVAD,"S")) = "S" ';
end;

function TTintadeMaquinaWrapperLukscolor.GetCampoAutoIncrem: String;
begin
  Result := 'LKD_CADLKD.AUTOINCREM';
end;

function TTintadeMaquinaWrapperLukscolor.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompLukscolor.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')), //TAutcomTintaFactory.Get.fCfgSis('TABPAD', varString)
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperLukscolor.GetNomeTabela: String;
begin
  Result := 'LKD_CADLKD';
end;

procedure TTintadeMaquinaWrapperLukscolor.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin

  Configurador.fSetPos('LKD_DESCRI', 0);
  Configurador.fSetPos('LKD_CODIGO', 1);
  Configurador.fSetPos('LKD_CODIG2', 2);
  Configurador.fSetPos('LKD_DESCRI', 3);
  Configurador.fSetPos('LKD_UNIDAD', 4);
  Configurador.fSetPos('LKD_SUBKEY', 5);
  Configurador.fSetPos('LKD_BASE__', 6);
  Configurador.fSetPos('LKD_PROKEY', 7);
  Configurador.fSetPos('CADITE.ITE_CODITE', 8);
  Configurador.fSetPos('CADITE.ITE_DESITE', 9);
  Configurador.fSetPos('CADITE.ITE_REFERE', 10);

  Configurador.fSetVisivel('LKD_DESCRI', True);
  Configurador.fSetVisivel('LKD_CODIGO', True);
  Configurador.fSetVisivel('LKD_CODIG2', True);
  Configurador.fSetVisivel('LKD_DESCRI', True);
  Configurador.fSetVisivel('LKD_UNIDAD', True);
  Configurador.fSetVisivel('LKD_SUBKEY', False);
  Configurador.fSetVisivel('LKD_BASE__', False);
  Configurador.fSetVisivel('LKD_PROKEY', False);
  Configurador.fSetVisivel('CADITE.ITE_CODITE', False);
  Configurador.fSetVisivel('CADITE.ITE_DESITE', False);
  Configurador.fSetVisivel('CADITE.ITE_REFERE', False);

  Configurador.pAdicionarIndice('LKD_DESCRI', 'Descrição');
  Configurador.pAdicionarIndice('LKD_CODIGO', 'Código');


  Configurador.pAdicionarCampoDescricao('LKD_CODIGO');
  Configurador.pAdicionarCampoDescricao('LKD_BASE__');
  Configurador.pAdicionarCampoDescricao('LKD_CODIG2');
  Configurador.pAdicionarCampoDescricao('LKD_UNIDAD');

end;

end.
