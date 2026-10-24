{**************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta Leinertex *}
{***********************************************************************************AC*}
unit untTintadeMaquinaWrapperLeinertex;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils, untIDataSet;

type
  TTintadeMaquinaWrapperLeinertex = class(TAbstractTintadeMaquinaWrapper)
  public
    procedure Configurar(const configurador: IConfiguradorConsulta); override;
    function GetCampoAutoIncrem: String; override;
    function fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String; override;
    procedure pRestaurarPadrao(const configurador: IConfiguradorConsulta); override;
    function fGetSelectFrom(const configurador: IConfiguradorConsulta): String; override;
    function GetNomeTinta: String; override;
    function GetNomeForm: String; override;
    function GetNomeTabela: String; override;
    function GetConsultaComp(strTabPre: String): IConsultaComp; override;
    function fGetWhere: String; override;
  end;

implementation

uses
{$IFNDEF LINUX}
  untConsultaCompLeinertex,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperLeinertex }

procedure TTintadeMaquinaWrapperLeinertex.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  //Configurador Leinertex
  Configurador.pAdicionarCampo('LEI_CODIGO', 'Código', 'LIKE');
  Configurador.pAdicionarCampo('LEI_DESCRI', 'Descrição Cor',  'LIKE');
  Configurador.pAdicionarCampo('LEI_CODBAS', 'Código Base',  'LIKE');
  Configurador.pAdicionarCampo('LEI_PRODUT', 'Produto', 'LIKE');
  Configurador.pAdicionarCampo('LEI_COLECA', 'Coleção', 'LIKE');
  Configurador.pAdicionarCampo('LEI_UNIDAD', 'Unidade', 'LIKE');
  Configurador.pAdicionarCampo('LEI_NOMCOR', 'Nome Cor', 'LIKE');
  Configurador.pAdicionarCampo('LEI_DTACAD', 'Data Cadastro', 'LIKE');
  Configurador.pAdicionarCampo('CADITE.ITE_DESITE', 'Descrição do Item', 'LIKE');
  Configurador.pAdicionarCampo('CADITE.ITE_CODITE', 'Código do Item', 'LIKE', False, True);
  Configurador.pAdicionarCampo('LEI_MD5KEY', 'Chave MD5', '=', False, True);
  Configurador.pAdicionarCampo('LEI_ACRMOB', 'Acrescimo Mao Obra', '=', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');

  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('LEI_FORM' + TStrUtils.fStrZero(intCont, 2), 'LEI_FORM' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('LEI_QTDC' + TStrUtils.fStrZero(intCont, 2), 'LEI_QTDC' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperLeinertex.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  Result := Result + ' AND UPPER(IFNULL(LEI_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperLeinertex.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result := '';
  Result := Result + '  LEI_CADLEI ';
  Result := Result + '   INNER JOIN LEI_CADBAS ';
  Result := Result + '     ON LEI_CODBAS = BAS_CODBAS ';
  Result := Result + '       AND LEI_PRODUT = BAS_PRODUT ';
  Result := Result + '       AND LEI_UNIDAD = BAS_UNIDAD ';
  Result := Result + '  	  INNER JOIN CADITE ON CADITE.ITE_CODITE = BAS_CODITE     ';
  Result := Result + '     AND CADITE.ITE_ITEATI = "S"          ';
  Result := Result + '      INNER JOIN ITEGER ON         ';
  Result := Result + '       BAS_CODITE = ITEGER.ITE_CODITE AND    ';
  Result := Result + '       ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
end;

function TTintadeMaquinaWrapperLeinertex.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(LEI_ATIVAD,"S")) = "S" ';
end;

function TTintadeMaquinaWrapperLeinertex.GetCampoAutoIncrem: String;
begin
  Result := 'LEI_CADLEI.AUTOINCREM';
end;

function TTintadeMaquinaWrapperLeinertex.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompLeinertex.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperLeinertex.GetNomeForm: String;
begin
  Result := 'Leinertex';
end;

function TTintadeMaquinaWrapperLeinertex.GetNomeTabela: String;
begin
  Result := 'LEI_CADLEI';
end;

function TTintadeMaquinaWrapperLeinertex.GetNomeTinta: String;
begin
  Result := 'Leinertex';
end;

procedure TTintadeMaquinaWrapperLeinertex.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  Configurador.fSetPos('LEI_CODIGO', 0);
  Configurador.fSetPos('LEI_UNIDAD', 1);
  Configurador.fSetPos('LEI_DESCRI', 2);
  Configurador.fSetPos('LEI_COLECA', 3);
  Configurador.fSetPos('CADITE.ITE_DESITE', 4);
  Configurador.fSetPos('LEI_CODBAS', 5);
  Configurador.fSetPos('LEI_PRODUT', 6);
  Configurador.fSetPos('CADITE.ITE_CODITE', 7);

  Configurador.fSetVisivel('LEI_CODIGO' , True);
  Configurador.fSetVisivel('LEI_UNIDAD' , True);
  Configurador.fSetVisivel('LEI_DESCRI' , True);
  Configurador.fSetVisivel('LEI_COLECA' , True);
  Configurador.fSetVisivel('CADITE.ITE_DESITE' , True);
  Configurador.fSetVisivel('LEI_CODBAS' , True);
  Configurador.fSetVisivel('LEI_PRODUT' , True);
  Configurador.fSetVisivel('CADITE.ITE_CODITE' , True);

  configurador.pAdicionarIndice('LEI_DESCRI+LEI_UNIDAD' , 'Descrição Cor\Unidade');
  configurador.pAdicionarIndice('LEI_CODIGO'  , 'Código');
  Configurador.pAdicionarIndice('LEI_PRODUT'  , 'Produto');
  Configurador.pAdicionarIndice('CADITE.ITE_DESITE'  , 'Descrição do Item');

  configurador.pAdicionarCampoDescricao('LEI_UNIDAD');
end;

end.



