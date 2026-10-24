{**************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta Resicolor2 *}
{***********************************************************************************AC*}
unit untTintadeMaquinaWrapperResicolor2;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils, untIDataSet;

type
  TTintadeMaquinaWrapperResicolor2 = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompResicolor2,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperResicolor2 }

procedure TTintadeMaquinaWrapperResicolor2.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  //Configurador Resicolor2
  Configurador.pAdicionarCampo('RS2_CODIGO', 'Código', 'LIKE');
  Configurador.pAdicionarCampo('RS2_CODBAS', 'Código Base',  'LIKE');
  Configurador.pAdicionarCampo('RS2_PRODUT', 'Produto', 'LIKE');
  Configurador.pAdicionarCampo('RS2_COLECA', 'Coleção', 'LIKE');
  Configurador.pAdicionarCampo('RS2_UNIDAD', 'Unidade', 'LIKE');
  Configurador.pAdicionarCampo('RS2_EMBALA', 'Embalagem', 'LIKE');
  Configurador.pAdicionarCampo('RS2_NOMCOR', 'Nome Cor', 'LIKE');
  Configurador.pAdicionarCampo('RS2_OBSERV', 'Observação', 'LIKE');
  Configurador.pAdicionarCampo('RS2_DTACAD', 'Data Cadastro', 'LIKE');
  Configurador.pAdicionarCampo('CADITE.ITE_DESITE', 'Descrição do Item', 'LIKE');
  Configurador.pAdicionarCampo('CADITE.ITE_CODITE', 'Código do Item', 'LIKE', False, True);
  Configurador.pAdicionarCampo('CADITE.ITE_REFERE', 'Referência do Item', 'LIKE');
  Configurador.pAdicionarCampo('RS2_MD5KEY', 'Chave MD5', '=', False, True);
  Configurador.pAdicionarCampo('RS2_ACRMOB', 'Acrescimo Mao Obra', '=', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');

  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('RS2_FORM' + TStrUtils.fStrZero(intCont, 2), 'RS2_FORM' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('RS2_QTDC' + TStrUtils.fStrZero(intCont, 2), 'RS2_QTDC' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperResicolor2.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  Result := Result + ' AND UPPER(IFNULL(RS2_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperResicolor2.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result := '';
  Result := Result + '  RS2_CADRS2 ';
  Result := Result + '   INNER JOIN RS2_CADBAS ';
  Result := Result + '     ON RS2_CODBAS = BAS_CODBAS ';
  Result := Result + '       AND RS2_PRODUT = BAS_PRODUT ';
  Result := Result + '       AND RS2_UNIDAD = BAS_UNIDAD ';
  Result := Result + '       AND RS2_EMBALA = BAS_EMBALA ';
  Result := Result + '  	  INNER JOIN CADITE ON CADITE.ITE_CODITE = BAS_CODITE     ';
  Result := Result + '     AND CADITE.ITE_ITEATI = "S"          ';
  Result := Result + '      INNER JOIN ITEGER ON         ';
  Result := Result + '       BAS_CODITE = ITEGER.ITE_CODITE AND    ';
  Result := Result + '       ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
end;

function TTintadeMaquinaWrapperResicolor2.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(RS2_ATIVAD,"S")) = "S" ';
end;

function TTintadeMaquinaWrapperResicolor2.GetCampoAutoIncrem: String;
begin
  Result := 'RS2_CADRS2.AUTOINCREM';
end;

function TTintadeMaquinaWrapperResicolor2.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompResicolor2.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperResicolor2.GetNomeForm: String;
begin
  Result := 'Resicolor2';
end;

function TTintadeMaquinaWrapperResicolor2.GetNomeTabela: String;
begin
  Result := 'RS2_CADRS2';
end;

function TTintadeMaquinaWrapperResicolor2.GetNomeTinta: String;
begin
  Result := 'Resicolor';
end;

procedure TTintadeMaquinaWrapperResicolor2.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  Configurador.fSetPos('RS2_CODIGO', 0);
  Configurador.fSetPos('RS2_UNIDAD', 1);
  Configurador.fSetPos('RS2_NOMCOR', 2);
  Configurador.fSetPos('CADITE.ITE_DESITE', 3);
  Configurador.fSetPos('RS2_CODBAS', 4);
  Configurador.fSetPos('RS2_PRODUT', 5);
  Configurador.fSetPos('CADITE.ITE_CODITE', 6);

  Configurador.fSetVisivel('RS2_CODIGO' , True);
  Configurador.fSetVisivel('RS2_UNIDAD' , True);
  Configurador.fSetVisivel('RS2_NOMCOR' , True);
  Configurador.fSetVisivel('CADITE.ITE_DESITE' , True);
  Configurador.fSetVisivel('RS2_CODBAS' , True);
  Configurador.fSetVisivel('RS2_PRODUT' , True);
  Configurador.fSetVisivel('CADITE.ITE_CODITE' , True);

  configurador.pAdicionarIndice('RS2_NOMCOR+RS2_UNIDAD' , 'Nome Cor\Unidade');
  configurador.pAdicionarIndice('RS2_CODIGO'  , 'Código');
  Configurador.pAdicionarIndice('RS2_PRODUT'  , 'Produto');
  Configurador.pAdicionarIndice('CADITE.ITE_DESITE'  , 'Descrição do Item');

  configurador.pAdicionarCampoDescricao('RS2_UNIDAD');
end;

end.



