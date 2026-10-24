{ **************************************************************************************** }
{ * Classe responsável pela configuração da tela de consulta da tinta SkyMixAutomotiva * }
{ *************************************************************************************AC* }
unit untTintadeMaquinaWrapperSkyMixAutomotiva;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperSkyMixAutomotiva = class(TAbstractTintadeMaquinaWrapper)
  public
    procedure Configurar(const configurador: IConfiguradorConsulta); override;
    function GetCampoAutoIncrem: String; override;
    function fGetSelect(const blnTodos: Boolean;
      const configurador: IConfiguradorConsulta): String; override;
    procedure pRestaurarPadrao(const configurador
      : IConfiguradorConsulta); override;
    function fGetSelectFrom(const configurador: IConfiguradorConsulta)
      : String; override;
    function GetNomeTabela: String; override;
    function GetConsultaComp(strTabPre: String): IConsultaComp; override;
    function fGetWhere: String; override;
  end;

implementation

uses
{$IFNDEF LINUX}
  untConsultaCompSkyMixAutomotiva,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperSkyMixAutomotiva }

procedure TTintadeMaquinaWrapperSkyMixAutomotiva.Configurar(const configurador
  : IConfiguradorConsulta);
var
  intCont: Integer;
begin

  configurador.pAdicionarCampo('SKY_CODUNI', 'Código Universal', 'LIKE');
  configurador.pAdicionarCampo('SKY_ANUANC', 'Variante', 'LIKE');
  configurador.pAdicionarCampo('SKY_CORPAI', 'Cor Pai', 'LIKE');
  configurador.pAdicionarCampo('SKY_NACIMP', 'Nacionalidade', 'LIKE');
  configurador.pAdicionarCampo('SKY_CONDIL', 'Concentrado', 'LIKE');
  configurador.pAdicionarCampo('MON_DESMON', 'Montadora', 'LIKE');
  configurador.pAdicionarCampo('GRU_LINHA_', 'Linha', 'LIKE');
  configurador.pAdicionarCampo('SGR_ASPECT', 'Sub Grupo', 'LIKE');
  configurador.pAdicionarCampo('SKY_VARIAN', 'Variante Cores', 'LIKE');
  configurador.pAdicionarCampo('SKY_CODSGR', 'Cód. SGR', 'LIKE');
  configurador.pAdicionarCampo('SKY_CODGRU', 'Grupo', 'LIKE');
  configurador.pAdicionarCampo('SKY_CODMON', 'Cód. Montadora', 'LIKE');
  configurador.pAdicionarCampo('SKY_VERSAO', 'Versão', 'LIKE');
  configurador.pAdicionarCampo('SKY_DESCRI', 'Descrição', 'LIKE');
  configurador.pAdicionarCampo('SKY_CODPRO', 'Cód. Prod', 'LIKE');
  configurador.pAdicionarCampo('SKY_ANOFAB', 'Ano Fabricação', 'LIKE');
  Configurador.pAdicionarCampo('SKY_ACRMOB', 'Acréscimo Mão de Obra', 'LIKE', False, False);
  Configurador.pAdicionarCampo('SKY_OBS001', 'Observação', 'LIKE');
  configurador.pAdicionarCampo('SKY_MD5KEY', 'Chave MD5', '=', False, True);
  Configurador.pAdicionarCampo('SKY_DTACAD', 'Data Cadastro', 'LIKE');

  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('SKY_FORM' + TStrUtils.fStrZero(intCont, 2),
      'SKY_FORM' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
    configurador.pAdicionarCampo('SKY_QTDB' + TStrUtils.fStrZero(intCont, 2),
      'SKY_QTDB' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
    configurador.pAdicionarCampo('SKY_QTDC' + TStrUtils.fStrZero(intCont, 2),
      'SKY_QTDC' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperSkyMixAutomotiva.fGetSelect(const blnTodos
  : Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador) +
    ' AND UPPER(IFNULL(SKY_ATIVAD, "S")) = "S" ';
end;

function TTintadeMaquinaWrapperSkyMixAutomotiva.fGetSelectFrom
  (const configurador: IConfiguradorConsulta): String;
begin
  Result := 'SKY_CADSKY ';
  Result := Result + '   LEFT JOIN SKY_CADMON ON SKY_CODMON = MON_CODMON   ';
  Result := Result + '   LEFT JOIN SKY_CADGRU ON SKY_CODGRU = GRU_CODGRU   ';
  Result := Result + '   LEFT JOIN SKY_CADSGR ON SKY_CODSGR = SGR_CODSGR   ';
end;

function TTintadeMaquinaWrapperSkyMixAutomotiva.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(SKY_ATIVAD, "S")) = "S" ';
end;

function TTintadeMaquinaWrapperSkyMixAutomotiva.GetCampoAutoIncrem: String;
begin
  Result := 'SKY_CADSKY.AUTOINCREM';
end;

function TTintadeMaquinaWrapperSkyMixAutomotiva.GetConsultaComp
  (strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompSkyMixAutomotiva.Create
    (TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos
    (TVariantUtils.IfNull(strTabPre, '1')), Self);
{$ENDIF}
end;

function TTintadeMaquinaWrapperSkyMixAutomotiva.GetNomeTabela: String;
begin
  Result := 'SKY_CADSKY';
end;

procedure TTintadeMaquinaWrapperSkyMixAutomotiva.pRestaurarPadrao
  (const configurador: IConfiguradorConsulta);
begin

  configurador.fSetPos('SKY_CODPRO', 0);
  configurador.fSetPos('SKY_DESCRI', 1);
  configurador.fSetPos('SKY_ANOFAB', 2);
  configurador.fSetPos('SKY_CODUNI', 3);
  configurador.fSetPos('SKY_ANUANC', 4);
  configurador.fSetPos('SKY_CORPAI', 5);
  configurador.fSetPos('SKY_NACIMP', 6);
  configurador.fSetPos('SKY_CONDIL', 7);
  configurador.fSetPos('MON_DESMON', 8);
  configurador.fSetPos('GRU_LINHA_', 9);
  configurador.fSetPos('SGR_ASPECT', 10);
  configurador.fSetPos('SKY_VARIAN', 11);
  configurador.fSetPos('SKY_OBS001', 12);

  configurador.fSetVisivel('SKY_CODPRO', True);
  configurador.fSetVisivel('SKY_DESCRI', True);
  configurador.fSetVisivel('SKY_ANOFAB', True);
  configurador.fSetVisivel('SKY_CODUNI', True);
  configurador.fSetVisivel('SKY_ANUANC', True);
  configurador.fSetVisivel('SKY_CORPAI', True);
  configurador.fSetVisivel('SKY_NACIMP', True);
  configurador.fSetVisivel('SKY_CONDIL', True);
  configurador.fSetVisivel('MON_DESMON', True);
  configurador.fSetVisivel('GRU_LINHA_', True);
  configurador.fSetVisivel('SGR_ASPECT', True);
  configurador.fSetVisivel('SKY_VARIAN', True);
  configurador.fSetVisivel('SKY_OBS001', True);


  configurador.pAdicionarIndice('SKY_DESCRI', 'Descrição');
  configurador.pAdicionarIndice('SKY_CODPRO', 'Cód. Prod');
  configurador.pAdicionarIndice('SKY_ANOFAB', 'Ano Fabricação');
  configurador.pAdicionarIndice('MON_DESMON', 'Montadora');

  configurador.pAdicionarCampoDescricao('SKY_CODPRO');
  configurador.pAdicionarCampoDescricao('SKY_DESCRI');
  configurador.pAdicionarCampoDescricao('MON_DESMON');
  configurador.pAdicionarCampoDescricao('SKY_CODUNI');
  configurador.pAdicionarCampoDescricao('SKY_ANUANC');
end;

end.
