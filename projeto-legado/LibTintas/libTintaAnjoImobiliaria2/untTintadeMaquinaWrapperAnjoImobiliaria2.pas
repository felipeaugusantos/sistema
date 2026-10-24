{**************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta AnjoImobiliaria2 *}
{***********************************************************************************AC*}
unit untTintadeMaquinaWrapperAnjoImobiliaria2;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils, untIDataSet;

type
  TTintadeMaquinaWrapperAnjoImobiliaria2 = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompAnjoImobiliaria2,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperAnjoImobiliaria2 }

procedure TTintadeMaquinaWrapperAnjoImobiliaria2.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  //Configurador AnjoImobiliaria2
  Configurador.pAdicionarCampo('AN2_CODIGO', 'Código', 'LIKE');
  Configurador.pAdicionarCampo('AN2_CODBAS', 'Código Base',  'LIKE');
  Configurador.pAdicionarCampo('AN2_PRODUT', 'Produto', 'LIKE');
  Configurador.pAdicionarCampo('AN2_COLECA', 'Coleção', 'LIKE');
  Configurador.pAdicionarCampo('AN2_UNIDAD', 'Unidade', 'LIKE');
  Configurador.pAdicionarCampo('AN2_NOMCOR', 'Nome Cor', 'LIKE');
  Configurador.pAdicionarCampo('AN2_DTACAD', 'Data Cadastro', 'LIKE');
  Configurador.pAdicionarCampo('CADITE.ITE_DESITE', 'Descrição do Item', 'LIKE');
  Configurador.pAdicionarCampo('CADITE.ITE_CODITE', 'Código do Item', 'LIKE', False, True);
  Configurador.pAdicionarCampo('CADITE.ITE_REFERE', 'Referência do Item', 'LIKE');
  Configurador.pAdicionarCampo('AN2_MD5KEY', 'Chave MD5', '=', False, True);
  Configurador.pAdicionarCampo('AN2_ACRMOB', 'Acrescimo Mao Obra', '=', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');

  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('AN2_FORM' + TStrUtils.fStrZero(intCont, 2), 'AN2_FORM' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('AN2_QTDC' + TStrUtils.fStrZero(intCont, 2), 'AN2_QTDC' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperAnjoImobiliaria2.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  Result := Result + ' AND UPPER(IFNULL(AN2_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperAnjoImobiliaria2.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result := '';
  Result := Result + '  AN2_CADAN2 ';
  Result := Result + '   INNER JOIN AN2_CADBAS ';
  Result := Result + '     ON AN2_CODBAS = BAS_CODBAS ';
  Result := Result + '       AND AN2_PRODUT = BAS_PRODUT ';
  Result := Result + '       AND AN2_UNIDAD = BAS_UNIDAD ';
  Result := Result + '  	  INNER JOIN CADITE ON CADITE.ITE_CODITE = BAS_CODITE     ';
  Result := Result + '     AND CADITE.ITE_ITEATI = "S"          ';
  Result := Result + '      INNER JOIN ITEGER ON         ';
  Result := Result + '       BAS_CODITE = ITEGER.ITE_CODITE AND    ';
  Result := Result + '       ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
end;

function TTintadeMaquinaWrapperAnjoImobiliaria2.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(AN2_ATIVAD,"S")) = "S" ';
end;

function TTintadeMaquinaWrapperAnjoImobiliaria2.GetCampoAutoIncrem: String;
begin
  Result := 'AN2_CADAN2.AUTOINCREM';
end;

function TTintadeMaquinaWrapperAnjoImobiliaria2.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompAnjoImobiliaria2.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperAnjoImobiliaria2.GetNomeForm: String;
begin
  Result := 'AnjoImobiliaria2';
end;

function TTintadeMaquinaWrapperAnjoImobiliaria2.GetNomeTabela: String;
begin
  Result := 'AN2_CADAN2';
end;

function TTintadeMaquinaWrapperAnjoImobiliaria2.GetNomeTinta: String;
begin
  Result := 'Anjo Imobiliaria';
end;

procedure TTintadeMaquinaWrapperAnjoImobiliaria2.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  Configurador.fSetPos('AN2_CODIGO', 0);
  Configurador.fSetPos('AN2_UNIDAD', 1);
  Configurador.fSetPos('AN2_DESCRI', 2);
  Configurador.fSetPos('AN2_LINHA_', 3);
  Configurador.fSetPos('CADITE.ITE_DESITE', 4);
  Configurador.fSetPos('AN2_CODBAS', 5);
  Configurador.fSetPos('AN2_PRODUT', 6);
  Configurador.fSetPos('CADITE.ITE_CODITE', 7);

  Configurador.fSetVisivel('AN2_CODIGO' , True);
  Configurador.fSetVisivel('AN2_UNIDAD' , True);
  Configurador.fSetVisivel('AN2_DESCRI' , True);
  Configurador.fSetVisivel('AN2_LINHA_' , True);
  Configurador.fSetVisivel('CADITE.ITE_DESITE' , True);
  Configurador.fSetVisivel('AN2_CODBAS' , True);
  Configurador.fSetVisivel('AN2_PRODUT' , True);
  Configurador.fSetVisivel('CADITE.ITE_CODITE' , True);

  configurador.pAdicionarIndice('AN2_DESCRI+AN2_UNIDAD' , 'Descrição Cor\Unidade');
  configurador.pAdicionarIndice('AN2_CODIGO'  , 'Código');
  Configurador.pAdicionarIndice('AN2_PRODUT'  , 'Produto');
  Configurador.pAdicionarIndice('CADITE.ITE_DESITE'  , 'Descrição do Item');

  configurador.pAdicionarCampoDescricao('AN2_UNIDAD');
end;

end.



