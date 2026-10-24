{*****************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta Alessi Imobiliaria  *}
{**************************************************************************************AC*}
unit untTintadeMaquinaWrapperAlessiImobiliaria;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperAlessiImobiliaria = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompAlessiImobiliaria,
{$ENDIF}
 untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperAlessiImobiliaria }

procedure TTintadeMaquinaWrapperAlessiImobiliaria.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  configurador.pAdicionarCampo('ALE_PRODUT', 'Produto', 'LIKE');
  configurador.pAdicionarCampo('ALE_BASE__', 'Base', 'LIKE');
  configurador.pAdicionarCampo('EMB_CODUNI', 'Unidade', 'LIKE');
  configurador.pAdicionarCampo('ALE_EMBALA', 'Embalagem', 'LIKE');
  configurador.pAdicionarCampo('ALE_NOMCOR', 'Nome Cor', 'LIKE');
  configurador.pAdicionarCampo('ALE_NOMLON', 'Nome Longo', 'LIKE');
  configurador.pAdicionarCampo('ALE_SISTEM', 'Sistema', 'LIKE');
  configurador.pAdicionarCampo('BAS_CODITE', 'Cód Item', 'LIKE');
  configurador.pAdicionarCampo('CADITE.ITE_DESITE', 'Item', 'LIKE');
  configurador.pAdicionarCampo('ALE_DTACAD', 'Data Cadastro', 'LIKE');
  configurador.pAdicionarCampo('ALE_CODNFM', 'Código Nova Fórmula', 'LIKE');
  configurador.pAdicionarCampo('CADITE.ITE_CODITE', 'Codigo do Item', 'LIKE', False, False);
  configurador.pAdicionarCampo('ALE_MD5KEY', 'Md5', '=', False, True);
  configurador.pAdicionarCampo('ALE_COLECA', 'Coleção', 'LIKE', True, True);
  Configurador.pAdicionarCampo('ALE_ACRMOB', 'ALE_ACRMOB', 'LIKE', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');

  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('ALE_CODC' + TStrUtils.fStrZero(intCont, 2), 'ALE_CODC' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('ALE_QTOZ' + TStrUtils.fStrZero(intCont, 2), 'ALE_QTOZ' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);

    configurador.pAdicionarCampo('ALE_QSHO' + TStrUtils.fStrZero(intCont, 2), 'ALE_QSHO' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperAlessiImobiliaria.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  Result := Result + ' AND UPPER(IFNULL(ALE_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperAlessiImobiliaria.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result :=
    '   ALE_CADALE                                          ' +
    '     INNER JOIN ALE_CADBAS ON ALE_PRODUT = BAS_PRODUT  ' +
    '                          AND ALE_BASE__ = BAS_BASE__  ' +
    '                          AND ALE_EMBALA = BAS_EMBALA  ' +
    '     INNER JOIN CADITE ON BAS_CODITE = CADITE.ITE_CODITE      ' +
    '     AND CADITE.ITE_ITEATI = "S"                       ' +
    '     INNER JOIN ITEGER ON BAS_CODITE = ITEGER.ITE_CODITE AND  ' +
    '     ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ' +
    '     INNER JOIN ALE_CADEMB ON BAS_EMBALA = EMB_NOME__  ' +
    '     INNER JOIN CADUNI ON EMB_CODUNI = UNI_CODUNI      ';
end;

function TTintadeMaquinaWrapperAlessiImobiliaria.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(ALE_ATIVAD,"S")) = "S" ';
end;

function TTintadeMaquinaWrapperAlessiImobiliaria.GetCampoAutoIncrem: String;
begin
  Result := 'ALE_CADALE.AUTOINCREM';
end;

function TTintadeMaquinaWrapperAlessiImobiliaria.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompAlessiImobiliaria.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperAlessiImobiliaria.GetNomeTabela: String;
begin
  Result := 'ALE_CADALE';
end;

procedure TTintadeMaquinaWrapperAlessiImobiliaria.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  configurador.fSetPos('ALE_PRODUT', 0);
  configurador.fSetPos('ALE_BASE__', 1);
  configurador.fSetPos('EMB_CODUNI', 2);
  configurador.fSetPos('ALE_NOMCOR', 3);
  configurador.fSetPos('ALE_NOMLON', 4);
  configurador.fSetPos('BAS_CODITE', 5);
  configurador.fSetPos('CADITE.ITE_DESITE', 6);
  configurador.fSetPos('ALE_DTACAD', 7);
  configurador.fSetPos('ALE_COLECA', 8);

  configurador.fSetVisivel('ALE_PRODUT', True);
  configurador.fSetVisivel('ALE_BASE__', True);
  configurador.fSetVisivel('EMB_CODUNI', True);
  configurador.fSetVisivel('ALE_NOMCOR', True);
  configurador.fSetVisivel('ALE_NOMLON', True);
  configurador.fSetVisivel('BAS_CODITE', True);
  configurador.fSetVisivel('CADITE.ITE_DESITE', True);
  configurador.fSetVisivel('ALE_DTACAD', True);
  configurador.fSetVisivel('ALE_COLECA', True);

  configurador.pAdicionarIndice('ALE_PRODUT+ALE_BASE__+EMB_CODUNI', 'Produto/Base/Unidade');
  configurador.pAdicionarIndice('ALE_PRODUT+ALE_NOMCOR+ALE_BASE__', 'Produto/Nome Cor/Base');
  configurador.pAdicionarIndice('ALE_COLECA', 'Coleção');

  configurador.pAdicionarCampoDescricao('ALE_PRODUT');
  configurador.pAdicionarCampoDescricao('ALE_BASE__');
  configurador.pAdicionarCampoDescricao('EMB_CODUNI');
  configurador.pAdicionarCampoDescricao('ALE_NOMCOR');
  configurador.pAdicionarCampoDescricao('ALE_NOMLON');
  configurador.pAdicionarCampoDescricao('BAS_CODITE');
  configurador.pAdicionarCampoDescricao('CADITE.ITE_DESITE');
  configurador.pAdicionarCampoDescricao('ALE_DTACAD');
  configurador.pAdicionarCampoDescricao('ALE_COLECA');
end;

end.
