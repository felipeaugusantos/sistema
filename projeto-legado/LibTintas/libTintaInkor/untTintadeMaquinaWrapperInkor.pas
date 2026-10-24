{**************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta Inkor *}
{***********************************************************************************AC*}
unit untTintadeMaquinaWrapperInkor;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperInkor = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompInkor,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperInkor }

procedure TTintadeMaquinaWrapperInkor.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  //Configurador Inkor
  Configurador.pAdicionarCampo('INK_CODIGO', 'Código Fórmula', 'LIKE');
  Configurador.pAdicionarCampo('INK_BASE__', 'Código Base', 'LIKE');
  Configurador.pAdicionarCampo('INK_PRODUT', 'Produto', 'LIKE');
  Configurador.pAdicionarCampo('INK_UNIDAD', 'Unidade', 'LIKE');
  Configurador.pAdicionarCampo('INK_DTACAD', 'Data Cadastro', 'LIKE');
  Configurador.pAdicionarCampo('INK_MD5KEY', 'Chave MD5', 'LIKE', False, True);
  Configurador.pAdicionarCampo('CADITE.ITE_CODITE', 'Código do Item', 'LIKE');
  Configurador.pAdicionarCampo('CADITE.ITE_DESITE', 'Descrição do Item', 'LIKE');
  Configurador.pAdicionarCampo('CADITE.ITE_REFERE', 'Referência do Item', 'LIKE');
  Configurador.pAdicionarCampo('INK_DESCRI', 'Descrição', 'LIKE');
  Configurador.pAdicionarCampo('INK_COLECA', 'Coleção', 'LIKE');
  Configurador.pAdicionarCampo('INK_ACRMOB', 'INK_ACRMOB', 'LIKE', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');
  //End;

  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('INK_FORM' + TStrUtils.fStrZero(intCont, 2), 'INK_FORM' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('INK_QTDC' + TStrUtils.fStrZero(intCont, 2), 'INK_QTDC' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperInkor.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  Result := Result + ' AND UPPER(IFNULL(INK_ATIVO_, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperInkor.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result := '';
  Result := Result + '  INK_CADINK ';
  Result := Result + '   INNER JOIN INK_CADBAS ';
  Result := Result + '     ON INK_BASE__ = BAS_BASE__ ';
  Result := Result + '       AND INK_PRODUT = BAS_DESCRI ';
  Result := Result + '       AND INK_UNIDAD = BAS_UNIDAD ';
  Result := Result + '  	  INNER JOIN CADITE ON CADITE.ITE_CODITE = BAS_CODITE     ';
  Result := Result + '     AND CADITE.ITE_ITEATI = "S"          ';
  Result := Result + '      INNER JOIN ITEGER ON         ';
  Result := Result + '       BAS_CODITE = ITEGER.ITE_CODITE AND    ';
  Result := Result + '       ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
end;

function TTintadeMaquinaWrapperInkor.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(INK_ATIVO_, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperInkor.GetCampoAutoIncrem: String;
begin
  Result := 'INK_CADINK.AUTOINCREM';
end;

function TTintadeMaquinaWrapperInkor.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompInkor.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')), //TAutcomTintaFactory.Get.fCfgSis('TABPAD', varString)
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperInkor.GetNomeTabela: String;
begin
  Result := 'INK_CADINK';
end;

procedure TTintadeMaquinaWrapperInkor.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin

  Configurador.fSetPos('INK_CODIGO', 0);
  Configurador.fSetPos('INK_BASE__', 1);
  Configurador.fSetPos('INK_PRODUT', 2);
  Configurador.fSetPos('INK_UNIDAD', 3);
  Configurador.fSetPos('CADITE.ITE_CODITE', 4);
  Configurador.fSetPos('CADITE.ITE_DESITE', 5);
  Configurador.fSetPos('CADITE.ITE_REFERE', 6);
  Configurador.fSetPos('INK_COLECA', 7);

  Configurador.fSetVisivel('INK_CODIGO', True);
  Configurador.fSetVisivel('INK_BASE__', True);
  Configurador.fSetVisivel('INK_PRODUT', True);
  Configurador.fSetVisivel('INK_UNIDAD', True);
  Configurador.fSetVisivel('CADITE.ITE_CODITE', True);
  Configurador.fSetVisivel('CADITE.ITE_DESITE', True);
  Configurador.fSetVisivel('CADITE.ITE_REFERE', True);
  Configurador.fSetVisivel('INK_COLECA', True);

  //Indices Configuração(Consultas)
  Configurador.pAdicionarIndice('INK_CODIGO', 'Código Fórmula');
  Configurador.pAdicionarIndice('INK_BASE__+INK_PRODUT', 'Código Base/Produto');
  Configurador.pAdicionarIndice('INK_UNIDAD', 'Unidade');

  //End;
  Configurador.pAdicionarCampoDescricao('INK_CODIGO');
  Configurador.pAdicionarCampoDescricao('INK_BASE__');
  Configurador.pAdicionarCampoDescricao('INK_PRODUT');
  Configurador.pAdicionarCampoDescricao('INK_UNIDAD');
end;

end.
