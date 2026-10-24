{**************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta Lechler *}
{***********************************************************************************AC*}
unit untTintadeMaquinaWrapperLechler;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperLechler = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompLechler,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperLechler }

procedure TTintadeMaquinaWrapperLechler.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin

  Configurador.pAdicionarCampo('LEC_CODBAS', 'Base', 'LIKE');
  Configurador.pAdicionarCampo('LEC_CODNFM', 'Código da Fórmula', 'LIKE');
  Configurador.pAdicionarCampo('LEC_CODEMB', 'Embalagem', 'LIKE');
  Configurador.pAdicionarCampo('LEC_CODCOR', 'Cor', 'LIKE');
  Configurador.pAdicionarCampo('LEC_DESCOR', 'Descrição da Cor', 'LIKE');
  Configurador.pAdicionarCampo('LEC_EFECOR', 'Efeito da Cor', 'LIKE');
  Configurador.pAdicionarCampo('LEC_MASIND', 'Mastercar/Industry', 'LIKE', False, False);
  Configurador.pAdicionarCampo('LEC_ACRMOB', 'Acrésc. Mão de Obra', 'LIKE', False, False);
  Configurador.pAdicionarCampo('LEC_ANOINI', 'Ano Inicial', 'LIKE');
  Configurador.pAdicionarCampo('LEC_ANOFIN', 'Ano Final', 'LIKE');
  Configurador.pAdicionarCampo('LEC_DESCRI', 'Descrição', 'LIKE');
  Configurador.pAdicionarCampo('LEC_CATALI', 'Catálise', 'LIKE');
  Configurador.pAdicionarCampo('LEC_MD5KEY', 'Chave Md5', '=', False, True);

  Configurador.pAdicionarCampo('LEC_QTDTOT', 'Quantidade Total', 'LIKE', False, False);
  Configurador.pAdicionarCampo('LEC_QTDB01', 'Quantidade Base', 'LIKE', False, False);
  Configurador.pAdicionarCampo('LEC_PERB01', 'Percentual Base', 'LIKE', False, False);


  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('LEC_FORM' + TStrUtils.fStrZero(intCont, 2), 'LEC_FORM' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('LEC_QTDC' + TStrUtils.fStrZero(intCont, 2), 'LEC_QTDC' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);

    configurador.pAdicionarCampo('LEC_PERC' + TStrUtils.fStrZero(intCont, 2), 'LEC_PERC' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperLechler.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  If TAutcomTintaFactory.Get.fGetConfTinta('LEC').fGetBoolean('USAFOR') Then
    Result := Result + '     AND LEC_QTDC01 > 0.0 ';

  Result := Result + ' AND UPPER(IFNULL(LEC_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperLechler.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result := '';
  Result := Result + '  LEC_CADLEC ';
end;

function TTintadeMaquinaWrapperLechler.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(LEC_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperLechler.GetCampoAutoIncrem: String;
begin
  Result := 'LEC_CADLEC.AUTOINCREM';
end;

function TTintadeMaquinaWrapperLechler.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompLechler.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')), //TAutcomTintaFactory.Get.fCfgSis('TABPAD', varString)
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperLechler.GetNomeTabela: String;
begin
  Result := 'LEC_CADLEC';
end;

procedure TTintadeMaquinaWrapperLechler.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin

  Configurador.fSetPos('LEC_CODBAS', 1);
  Configurador.fSetPos('LEC_CODNFM', 2);
  Configurador.fSetPos('LEC_CODCOR', 3);
  Configurador.fSetPos('LEC_DESCOR', 4);
  Configurador.fSetPos('LEC_EFECOR', 5);
  Configurador.fSetPos('LEC_ANOINI', 6);
  Configurador.fSetPos('LEC_ANOFIN', 7);
  Configurador.fSetPos('LEC_DESCRI', 8);

  Configurador.fSetVisivel('LEC_CODBAS', True);
  Configurador.fSetVisivel('LEC_CODNFM', True);
  Configurador.fSetVisivel('LEC_CODCOR', True);
  Configurador.fSetVisivel('LEC_DESCOR', True);
  Configurador.fSetVisivel('LEC_EFECOR', True);
  Configurador.fSetVisivel('LEC_ANOINI', True);
  Configurador.fSetVisivel('LEC_ANOFIN', True);
  Configurador.fSetVisivel('LEC_DESCRI', True);


  Configurador.pAdicionarIndice('LEC_CODCOR+LEC_DESCOR+LEC_CODBAS', 'Cor/Descrição da Cor/Base');
  Configurador.pAdicionarIndice('LEC_CODBAS', 'Base');

  Configurador.pAdicionarCampoDescricao('LEC_CODBAS');
  Configurador.pAdicionarCampoDescricao('LEC_CODNFM');
  Configurador.pAdicionarCampoDescricao('LEC_CODCOR');
  Configurador.pAdicionarCampoDescricao('LEC_DESCOR');
  Configurador.pAdicionarCampoDescricao('LEC_EFECOR');
  Configurador.pAdicionarCampoDescricao('LEC_ANOINI');
  Configurador.pAdicionarCampoDescricao('LEC_ANOFIN');
  Configurador.pAdicionarCampoDescricao('LEC_DESCRI');
end;

end.
