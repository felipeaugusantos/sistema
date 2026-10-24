{**************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta ProfissionalAutomotiva *}
{***********************************************************************************AC*}
unit untTintadeMaquinaWrapperProfissionalAutomotiva;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperProfissionalAutomotiva = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompProfissionalAutomotiva,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperProfissionalAutomotiva }

procedure TTintadeMaquinaWrapperProfissionalAutomotiva.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin

  Configurador.pAdicionarCampo('PFA_CODIGO', 'Código da Fórmula', 'LIKE');
  Configurador.pAdicionarCampo('PFA_DESCRI', 'Descrição', 'LIKE');
  Configurador.pAdicionarCampo('PFA_NOMCOR', 'Nome da Cor', 'LIKE');
  Configurador.pAdicionarCampo('PFA_A_N_O_', 'Ano da Cor', 'LIKE');
  Configurador.pAdicionarCampo('PFA_LINHA_', 'Linha', 'LIKE');
  Configurador.pAdicionarCampo('PFA_TIPLIN', 'Tipo da Linha', 'LIKE');
  Configurador.pAdicionarCampo('PFA_MD5KEY', 'Chave Md5', '=', False, True);
  configurador.pAdicionarCampo('PFA_PROCHA', 'Produto Chapinha', 'LIKE', False, False);
  Configurador.pAdicionarCampo('PFA_ACRMOB', 'Acrésc. Mão de Obra', 'LIKE', False, False);


  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('PFA_CODB' + TStrUtils.fStrZero(intCont, 2), 'PFA_CODB' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('PFA_QTDB' + TStrUtils.fStrZero(intCont, 2), 'PFA_QTDB' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperProfissionalAutomotiva.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  If TAutcomTintaFactory.Get.fGetConfTinta('PFA').fGetBoolean('USAFOR') Then
    Result := Result + '     AND PFA_QTDB01 > 0.0 ';

  Result := Result + ' AND UPPER(IFNULL(PFA_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperProfissionalAutomotiva.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result := '';
  Result := Result + '  PFA_CADPFA ';
end;

function TTintadeMaquinaWrapperProfissionalAutomotiva.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(PFA_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperProfissionalAutomotiva.GetCampoAutoIncrem: String;
begin
  Result := 'PFA_CADPFA.AUTOINCREM';
end;

function TTintadeMaquinaWrapperProfissionalAutomotiva.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompProfissionalAutomotiva.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')), //TAutcomTintaFactory.Get.fCfgSis('TABPAD', varString)
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperProfissionalAutomotiva.GetNomeTabela: String;
begin
  Result := 'PFA_CADPFA';
end;

procedure TTintadeMaquinaWrapperProfissionalAutomotiva.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin

  Configurador.fSetPos('PFA_CODIGO', 1);
  Configurador.fSetPos('PFA_DESCRI', 2);
  Configurador.fSetPos('PFA_NOMCOR', 3);
  Configurador.fSetPos('PFA_A_N_O_', 4);

  Configurador.fSetVisivel('PFA_CODIGO', True);
  Configurador.fSetVisivel('PFA_DESCRI', True);
  Configurador.fSetVisivel('PFA_NOMCOR', True);
  Configurador.fSetVisivel('PFA_A_N_O_', True);


  Configurador.pAdicionarIndice('PFA_CODIGO', 'Código da Fórmula');
  Configurador.pAdicionarIndice('PFA_DESCRI', 'Descrição');

  Configurador.pAdicionarCampoDescricao('PFA_CODIGO');
  Configurador.pAdicionarCampoDescricao('PFA_DESCRI');
  Configurador.pAdicionarCampoDescricao('PFA_NOMCOR');
  Configurador.pAdicionarCampoDescricao('PFA_A_N_O_');
end;

end.


