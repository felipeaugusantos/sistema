{**************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta LechlerAutomotiva *}
{***********************************************************************************AC*}
unit untTintadeMaquinaWrapperLechlerAutomotiva;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperLechlerAutomotiva = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompLechlerAutomotiva,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperLechlerAutomotiva }

procedure TTintadeMaquinaWrapperLechlerAutomotiva.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin

  Configurador.pAdicionarCampo('LCA_CODIGO', 'Código da Fórmula', 'LIKE');
  Configurador.pAdicionarCampo('LCA_DESCRI', 'Descrição', 'LIKE');
  Configurador.pAdicionarCampo('LCA_NOMCOR', 'Nome da Cor', 'LIKE');
  Configurador.pAdicionarCampo('LCA_A_N_O_', 'Ano da Cor', 'LIKE');
  Configurador.pAdicionarCampo('LCA_MONTAD', 'Montadora', 'LIKE');
  Configurador.pAdicionarCampo('LCA_REFCOR', 'Referência da Cor', 'LIKE');
  Configurador.pAdicionarCampo('LCA_VARIAN', 'Variante', 'LIKE');
  Configurador.pAdicionarCampo('LCA_MD5KEY', 'Chave Md5', '=', False, True);
  Configurador.pAdicionarCampo('LCA_MONTAD', 'Montadora', 'LIKE');
  Configurador.pAdicionarCampo('LCA_REFCOR', 'Referência da Cor', 'LIKE');
  Configurador.pAdicionarCampo('LCA_VARIAN', 'Variante', 'LIKE');
  configurador.pAdicionarCampo('LCA_PROCHA', 'Produto Chapinha', 'LIKE', False, False);
  Configurador.pAdicionarCampo('LCA_ACRMOB', 'Acrésc. Mão de Obra', 'LIKE', False, False);


  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('LCA_CODB' + TStrUtils.fStrZero(intCont, 2), 'LCA_CODB' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('LCA_QTDB' + TStrUtils.fStrZero(intCont, 2), 'LCA_QTDB' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperLechlerAutomotiva.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  If TAutcomTintaFactory.Get.fGetConfTinta('LCA').fGetBoolean('USAFOR') Then
    Result := Result + '     AND LCA_QTDB01 > 0.0 ';

  Result := Result + ' AND UPPER(IFNULL(LCA_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperLechlerAutomotiva.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result := '';
  Result := Result + '  LCA_CADLCA ';
end;

function TTintadeMaquinaWrapperLechlerAutomotiva.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(LCA_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperLechlerAutomotiva.GetCampoAutoIncrem: String;
begin
  Result := 'LCA_CADLCA.AUTOINCREM';
end;

function TTintadeMaquinaWrapperLechlerAutomotiva.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompLechlerAutomotiva.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')), //TAutcomTintaFactory.Get.fCfgSis('TABPAD', varString)
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperLechlerAutomotiva.GetNomeTabela: String;
begin
  Result := 'LCA_CADLCA';
end;

procedure TTintadeMaquinaWrapperLechlerAutomotiva.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin

  Configurador.fSetPos('LCA_CODIGO', 1);
  Configurador.fSetPos('LCA_DESCRI', 2);
  Configurador.fSetPos('LCA_NOMCOR', 3);
  Configurador.fSetPos('LCA_A_N_O_', 4);

  Configurador.fSetVisivel('LCA_CODIGO', True);
  Configurador.fSetVisivel('LCA_DESCRI', True);
  Configurador.fSetVisivel('LCA_NOMCOR', True);
  Configurador.fSetVisivel('LCA_A_N_O_', True);


  Configurador.pAdicionarIndice('LCA_CODIGO', 'Código da Fórmula');
  Configurador.pAdicionarIndice('LCA_DESCRI', 'Descrição');

  Configurador.pAdicionarCampoDescricao('LCA_CODIGO');
  Configurador.pAdicionarCampoDescricao('LCA_DESCRI');
  Configurador.pAdicionarCampoDescricao('LCA_NOMCOR');
  Configurador.pAdicionarCampoDescricao('LCA_A_N_O_');
end;

end.
