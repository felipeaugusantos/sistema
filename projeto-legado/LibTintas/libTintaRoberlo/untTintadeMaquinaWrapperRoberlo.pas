{**************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta Roberlo *}
{***********************************************************************************AC*}
unit untTintadeMaquinaWrapperRoberlo;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperRoberlo = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompRoberlo,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperRoberlo }

procedure TTintadeMaquinaWrapperRoberlo.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  Configurador.pAdicionarCampo('ROB_CODIGO', 'Código da Fórmula', 'LIKE');
  Configurador.pAdicionarCampo('ROB_SERIE_', 'Série', 'LIKE');
  Configurador.pAdicionarCampo('ROB_MARCA_', 'Marca', 'LIKE');
  Configurador.pAdicionarCampo('ROB_NOMCOR', 'Nome Cor', 'LIKE');
  Configurador.pAdicionarCampo('ROB_GRUCOR', 'Grupo Cor', 'LIKE');
  Configurador.pAdicionarCampo('ROB_CAMADA', 'Camada', 'LIKE');
  Configurador.pAdicionarCampo('ROB_MODELO', 'Modelo', 'LIKE', False, False);
  Configurador.pAdicionarCampo('ROB_REGIAO', 'Região', 'LIKE');
  Configurador.pAdicionarCampo('ROB_DTACAD', 'Data Cadastro', 'LIKE', False, False);
  Configurador.pAdicionarCampo('ROB_VARIAN', 'Variante', 'LIKE');
  Configurador.pAdicionarCampo('ROB_CODCOR', 'Código Cor', 'LIKE');
  Configurador.pAdicionarCampo('ROB_ACRMOB', 'Acrésc. Mão de Obra', 'LIKE', False, False);
  Configurador.pAdicionarCampo('ROB_ANOINI', 'Ano Inicial', 'LIKE');
  Configurador.pAdicionarCampo('ROB_ANOFIN', 'Ano Final', 'LIKE');
  Configurador.pAdicionarCampo('ROB_MD5KEY', 'Chave Md5', '=', False, True);
  Configurador.pAdicionarCampo('ROB_CATALO', 'Catálogo', 'LIKE');

  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('ROB_BASE' + TStrUtils.fStrZero(intCont, 2), 'ROB_BASE' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('ROB_QTDB' + TStrUtils.fStrZero(intCont, 2), 'ROB_QTDB' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);

  End;
end;

function TTintadeMaquinaWrapperRoberlo.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  If TAutcomTintaFactory.Get.fGetConfTinta('ROB').fGetBoolean('USAFOR') Then
    Result := Result + '     AND ROB_QTDB01 > 0.0 ';

  Result := Result + ' AND UPPER(IFNULL(ROB_ATIVO_, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperRoberlo.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result := '';
  Result := Result + '  ROB_CADROB ';
end;

function TTintadeMaquinaWrapperRoberlo.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(ROB_ATIVO_, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperRoberlo.GetCampoAutoIncrem: String;
begin
  Result := 'ROB_CADROB.AUTOINCREM';
end;

function TTintadeMaquinaWrapperRoberlo.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompRoberlo.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')), //TAutcomTintaFactory.Get.fCfgSis('TABPAD', varString)
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperRoberlo.GetNomeTabela: String;
begin
  Result := 'ROB_CADROB';
end;

procedure TTintadeMaquinaWrapperRoberlo.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin

  Configurador.fSetPos('ROB_CODIGO', 1);
  Configurador.fSetPos('ROB_SERIE_', 2);
  Configurador.fSetPos('ROB_MARCA_', 3);
  Configurador.fSetPos('ROB_CODCOR', 4);
  Configurador.fSetPos('ROB_NOMCOR', 5);

  Configurador.fSetVisivel('ROB_CODIGO', True);
  Configurador.fSetVisivel('ROB_SERIE_', True);
  Configurador.fSetVisivel('ROB_MARCA_', True);
  Configurador.fSetVisivel('ROB_CODCOR', True);
  Configurador.fSetVisivel('ROB_NOMCOR', True);


  Configurador.pAdicionarIndice('ROB_CODIGO+ROB_NOMCOR+ROB_CODCOR', 'Código da Fórmula/Nome Cor/Código Cor');
  Configurador.pAdicionarIndice('ROB_SERIE_', 'Série');
  Configurador.pAdicionarIndice('ROB_MARCA_', 'Marca');
  Configurador.pAdicionarIndice('ROB_DESCRI', 'Descrição');

  Configurador.pAdicionarCampoDescricao('ROB_CODIGO');
  Configurador.pAdicionarCampoDescricao('ROB_SERIE_');
  Configurador.pAdicionarCampoDescricao('ROB_MARCA_');
  Configurador.pAdicionarCampoDescricao('ROB_CODCOR');
  Configurador.pAdicionarCampoDescricao('ROB_NOMCOR');
end;

end.
