{*****************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta AnjoImobiliaria *}
{**************************************************************************************PH*}
unit untTintadeMaquinaWrapperAnjoImobiliaria;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperAnjoImobiliaria = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompAnjoImobiliaria,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperAnjoImobiliaria }

procedure TTintadeMaquinaWrapperAnjoImobiliaria.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin

  configurador.pAdicionarCampo('ANJ_DESCRI', 'Descrição', 'LIKE');
  configurador.pAdicionarCampo('ANJ_CODIGO', 'Código', 'LIKE');
  configurador.pAdicionarCampo('ANJ_CODIG2', 'Código 2', 'LIKE');
  configurador.pAdicionarCampo('BAS_DESCRI', 'Descrição da Base', 'LIKE');
  configurador.pAdicionarCampo('ANJ_UNIDAD', 'Unidade', 'LIKE');
  configurador.pAdicionarCampo('ANJ_DTACAD', 'Data Cadastro', 'LIKE');
  configurador.pAdicionarCampo('ANJ_MD5KEY', 'MD5KEY', 'LIKE', False, False);
  configurador.pAdicionarCampo('ANJ_SUBKEY', 'Unidade', 'LIKE', False, False);
  configurador.pAdicionarCampo('ANJ_PROKEY', 'Unidade', 'LIKE', False, False);
  configurador.pAdicionarCampo('ANJ_BASE__', 'Unidade', 'LIKE', False, False);
  configurador.pAdicionarCampo('I.ITE_CODITE', 'Código do Item', 'LIKE');
  configurador.pAdicionarCampo('I.ITE_DESITE', 'Descrição do Item', 'LIKE');
  configurador.pAdicionarCampo('I.ITE_REFERE', 'Referência do Item', 'LIKE');
  Configurador.pAdicionarCampo('ANJ_ACRMOB', 'ANJ_ACRMOB', 'LIKE', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');


  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('ANJ_FORM' + TStrUtils.fStrZero(intCont, 2), 'ANJ_CODC' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('ANJ_QTDB' + TStrUtils.fStrZero(intCont, 2), 'ANJ_QTDC' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperAnjoImobiliaria.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  Result := Result + ' AND UPPER(IFNULL(ANJ_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperAnjoImobiliaria.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result := Result + '  ANJ_CADANJ ';
  Result := Result + ' 	INNER JOIN ANJ_CADBAS B ON ANJ_PROKEY = BAS_PROKEY ';
  Result := Result + ' 	                       AND ANJ_SUBKEY = BAS_SUBKEY ';
  Result := Result + ' 		                     AND ANJ_BASE__ = BAS_BASE__ ';
  Result := Result + ' 		                     AND ANJ_UNIDAD = BAS_UNIDAD ';
  Result := Result + ' 	INNER JOIN CADITE I     ON BAS_CODITE = I.ITE_CODITE ';
  Result := Result + '     AND I.ITE_ITEATI = "S"          ';
  Result := Result + '     INNER JOIN ITEGER ON                          ';
  Result := Result + '       BAS_CODITE = ITEGER.ITE_CODITE AND                 ';
  Result := Result + '       ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
end;

function TTintadeMaquinaWrapperAnjoImobiliaria.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(ANJ_ATIVAD,"S")) = "S" ';
end;

function TTintadeMaquinaWrapperAnjoImobiliaria.GetCampoAutoIncrem: String;
begin
  Result := 'ANJ_CADANJ.AUTOINCREM';
end;

function TTintadeMaquinaWrapperAnjoImobiliaria.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompAnjoImobiliaria.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperAnjoImobiliaria.GetNomeTabela: String;
begin
  Result := 'ANJ_CADANJ';
end;

procedure TTintadeMaquinaWrapperAnjoImobiliaria.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  configurador.fSetPos('ANJ_DESCRI', 0);
  configurador.fSetPos('ANJ_CODIGO', 1);
  configurador.fSetPos('ANJ_CODIG2', 2);
  configurador.fSetPos('BAS_DESCRI', 3);
  configurador.fSetPos('ANJ_UNIDAD', 4);
  configurador.fSetPos('ANJ_DTACAD', 5);

  configurador.fSetVisivel('ANJ_DESCRI', True);
  configurador.fSetVisivel('ANJ_CODIGO', True);
  configurador.fSetVisivel('ANJ_CODIG2', True);
  configurador.fSetVisivel('BAS_DESCRI', True);
  configurador.fSetVisivel('ANJ_UNIDAD', True);
  configurador.fSetVisivel('ANJ_DTACAD', True);

  configurador.pAdicionarIndice('ANJ_DESCRI', 'Descrição');
  configurador.pAdicionarIndice('ANJ_CODIGO', 'Código');
  configurador.pAdicionarIndice('ANJ_CODIG2', 'Código 2');
  configurador.pAdicionarIndice('ANJ_CODIG2', 'Data Cadastro');

  configurador.pAdicionarCampoDescricao('ANJ_DESCRI');
  configurador.pAdicionarCampoDescricao('ANJ_CODIGO');
  configurador.pAdicionarCampoDescricao('ANJ_CODIG2');
  configurador.pAdicionarCampoDescricao('BAS_DESCRI');
  configurador.pAdicionarCampoDescricao('ANJ_UNIDAD');
  configurador.pAdicionarCampoDescricao('ANJ_DTACAD');
end;

end.
