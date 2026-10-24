{**************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta Sayerlack *}
{***********************************************************************************AC*}
unit untTintadeMaquinaWrapperSayerlack;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperSayerlack = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompSayerlack,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperSayerlack }

procedure TTintadeMaquinaWrapperSayerlack.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  Configurador.pAdicionarCampo('SAY_BASE__', 'Base',  'LIKE');
  Configurador.pAdicionarCampo('SAY_CODBAS', 'Código Base', 'LIKE');
  Configurador.pAdicionarCampo('SAY_PRODUT', 'Produto', 'LIKE');
  Configurador.pAdicionarCampo('SAY_CODIGO', 'Código Formula', 'LIKE');
  Configurador.pAdicionarCampo('SAY_DESCRI', 'Descrição', 'LIKE');
  Configurador.pAdicionarCampo('CADITE.ITE_DESITE', 'Descrição do Item', 'LIKE');
  Configurador.pAdicionarCampo('SAY_COMENT', 'Comentário',  'LIKE');
  Configurador.pAdicionarCampo('CADITE.ITE_CODITE', 'Código do Item', 'LIKE');
  Configurador.pAdicionarCampo('EMB_CODUNI', 'Unidade', 'LIKE');
  Configurador.pAdicionarCampo('SAY_CODNFM', 'Código Novas Fórmulas', 'LIKE');
  Configurador.pAdicionarCampo('SAY_DESEMB', 'Embalagem', 'LIKE');
  Configurador.pAdicionarCampo('SAY_MD5KEY', 'Chave MD5', '=', False, True);
  Configurador.pAdicionarCampo('SAY_ACRMOB', 'SAY_ACRMOB', 'LIKE', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');


  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('SAY_FORM' + TStrUtils.fStrZero(intCont, 2), 'SAY_FORM' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('SAY_QTDC' + TStrUtils.fStrZero(intCont, 2), 'SAY_QTDC' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperSayerlack.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  If TAutcomTintaFactory.Get.fGetConfTinta('SAY').fGetBoolean('USAFOR') Then
    Result := Result + '     AND SAY_QTDC01 > 0.0 ';

  Result := Result + ' AND UPPER(IFNULL(SAY_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperSayerlack.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result := '';
  Result := Result + '  SAY_CADSAY ';
  Result := Result + '   INNER JOIN SAY_CADBAS ';
  Result := Result + '     ON SAY_CODBAS = BAS_CODBAS ';
  Result := Result + '       AND SAY_PRODUT = BAS_PRODUT ';
  Result := Result + '       AND SAY_DESEMB = BAS_DESEMB ';
  Result := Result + '   INNER JOIN CADITE               ';
  Result := Result + '      ON BAS_CODITE = CADITE.ITE_CODITE   ';
  Result := Result + '     AND CADITE.ITE_ITEATI = "S"          ';
  Result := Result + '   INNER JOIN ITEGER ON            ';
  Result := Result + '       BAS_CODITE = ITEGER.ITE_CODITE AND    ';
  Result := Result + '       ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
  Result := Result + '   INNER JOIN SAY_CADEMB           ';
  Result := Result + '      ON BAS_DESEMB = EMB_DESEMB   ';
end;

function TTintadeMaquinaWrapperSayerlack.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(SAY_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperSayerlack.GetCampoAutoIncrem: String;
begin
  Result := 'SAY_CADSAY.AUTOINCREM';
end;

function TTintadeMaquinaWrapperSayerlack.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompSayerlack.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')), //TAutcomTintaFactory.Get.fCfgSis('TABPAD', varString)
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperSayerlack.GetNomeTabela: String;
begin
  Result := 'SAY_CADSAY';
end;

procedure TTintadeMaquinaWrapperSayerlack.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  Configurador.fSetPos('SAY_BASE__', 0);
  Configurador.fSetPos('SAY_CODBAS', 1);
  Configurador.fSetPos('SAY_PRODUT', 2);
  Configurador.fSetPos('SAY_CODIGO', 3);
  Configurador.fSetPos('SAY_DESCRI', 4);
  Configurador.fSetPos('CADITE.ITE_DESITE', 5);
  Configurador.fSetPos('SAY_COMENT', 6);
  Configurador.fSetPos('CADITE.ITE_CODITE', 7);
  Configurador.fSetPos('EMB_CODUNI', 8);
  Configurador.fSetPos('SAY_CODNFM', 9);
  Configurador.fSetPos('SAY_DESEMB', 10);


  Configurador.fSetVisivel(0, True);
  Configurador.fSetVisivel(1, True);
  Configurador.fSetVisivel(2, True);
  Configurador.fSetVisivel(3, True);
  Configurador.fSetVisivel(4, True);
  Configurador.fSetVisivel(5, True);
  Configurador.fSetVisivel(6, False);
  Configurador.fSetVisivel(7, False);
  Configurador.fSetVisivel(8, False);
  Configurador.fSetVisivel(9, False);
  Configurador.fSetVisivel(10, False);


  Configurador.pAdicionarIndice('SAY_CODIGO+SAY_DESCRI', 'Código Fórmula/Descrição');
  Configurador.pAdicionarIndice('SAY_BASE__+SAY_CODBAS+SAY_PRODUT', 'Base/Código Base/Produto');

  Configurador.pAdicionarCampoDescricao('SAY_BASE__');
  Configurador.pAdicionarCampoDescricao('SAY_CODBAS');
  Configurador.pAdicionarCampoDescricao('SAY_PRODUT');
  Configurador.pAdicionarCampoDescricao('SAY_CODIGO');
  Configurador.pAdicionarCampoDescricao('SAY_DESCRI');
  Configurador.pAdicionarCampoDescricao('CADITE.ITE_DESITE');
  Configurador.pAdicionarCampoDescricao('SAY_DESEMB');
end;

end.
