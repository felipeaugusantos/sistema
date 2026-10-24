{******************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta KillingIndustrial *}
{***************************************************************************AC*}
unit untTintadeMaquinaWrapperKillingIndustrial;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperKillingIndustrial = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompKillingIndustrial,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperKillingIndustrial }

procedure TTintadeMaquinaWrapperKillingIndustrial.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  configurador.pAdicionarCampo('KIN_CODIGO', 'Código'                  , 'LIKE');
  configurador.pAdicionarCampo('KIN_DTACAD', 'Data Cadastro'           , 'LIKE');
  Configurador.pAdicionarCampo('KIN_NOMCOR', 'Nome Cor'                , 'LIKE');
  Configurador.pAdicionarCampo('KIN_PRODUT', 'Produto'                 , 'LIKE');
  Configurador.pAdicionarCampo('KIN_SISTEM', 'Sistema'                 , 'LIKE');
  Configurador.pAdicionarCampo('KIN_ORIGEM', 'Origem'                  , 'LIKE');
  Configurador.pAdicionarCampo('KIN_DESMON', 'Montadora'               , 'LIKE');
  Configurador.pAdicionarCampo('KIN_DESLIN', 'Linha'                   , 'LIKE');
  Configurador.pAdicionarCampo('KIN_ANOCOR', 'Ano Cor'                 , 'LIKE');
  Configurador.pAdicionarCampo('KIN_DESCRI', 'Descrição'               , 'LIKE');
  Configurador.pAdicionarCampo('KIN_MD5KEY', 'Chave MD5'               , 'LIKE', False, True);
  Configurador.pAdicionarCampo('KIN_CODMON', 'Código Montadora'        , 'LIKE', False, False);
  Configurador.pAdicionarCampo('KIN_LINHA_', 'Código Linha'            , 'LIKE', False, False);
  Configurador.pAdicionarCampo('KIN_ACRMOB', 'Acréscimo mao de Obra'   , 'LIKE', False, False);
  Configurador.pAdicionarCampo('LIN_DESCRI', 'Descrição da Linha'      , 'LIKE', False, False);
  Configurador.pAdicionarCampo('MON_DESCRI', 'Descrição da Montadora'  , 'LIKE', False, False);




  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('KIN_BASE' + TStrUtils.fStrZero(intCont, 2), 'KIN_BASE' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
    configurador.pAdicionarCampo('KIN_QTDB' + TStrUtils.fStrZero(intCont, 2), 'KIN_QTDB' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperKillingIndustrial.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador) +
    ' AND UPPER(IFNULL(KIN_ATIVO_, "S")) = "S" ';
end;

function TTintadeMaquinaWrapperKillingIndustrial.fGetSelectFrom(
  const configurador: IConfiguradorConsulta): String;
begin
  Result := 'KIN_CADKIN A';
  Result := Result + ' LEFT JOIN KIN_CADMON ON MON_CODMON = A.KIN_CODMON ';
  Result := Result + ' LEFT JOIN KIN_CADLIN ON LIN_CODIGO = A.KIN_LINHA_ ';

end;

function TTintadeMaquinaWrapperKillingIndustrial.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(KIN_ATIVO_, "S")) = "S" ';
end;

function TTintadeMaquinaWrapperKillingIndustrial.GetCampoAutoIncrem: String;
begin
  Result := 'A.AUTOINCREM';
end;

function TTintadeMaquinaWrapperKillingIndustrial.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompKillingIndustrial.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperKillingIndustrial.GetNomeTabela: String;
begin
  Result := 'KIN_CADKIN ';
end;

procedure TTintadeMaquinaWrapperKillingIndustrial.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  Configurador.fSetPos('KIN_CODIGO', 0);
  Configurador.fSetPos('KIN_NOMCOR', 1);
  Configurador.fSetPos('KIN_PRODUT', 2);
  Configurador.fSetPos('KIN_SISTEM', 3);
  Configurador.fSetPos('KIN_ORIGEM', 4);
  Configurador.fSetPos('KIN_DESMON', 5);
  Configurador.fSetPos('KIN_DESLIN', 6);
  Configurador.fSetPos('KIN_DTACAD', 7);
  Configurador.fSetPos('KIN_DESCRI', 8);
  Configurador.fSetPos('KIN_ANOCOR', 9);

  Configurador.pAdicionarCampo('KIN_CODIGO', 'Código', 'LIKE');
  Configurador.pAdicionarCampo('KIN_DTACAD', 'Data Cadastro', 'LIKE');
  Configurador.pAdicionarCampo('KIN_NOMCOR', 'Nome Cor', 'LIKE');
  Configurador.pAdicionarCampo('KIN_PRODUT', 'Produto', 'LIKE');
  Configurador.pAdicionarCampo('KIN_SISTEM', 'Sistema', 'LIKE');
  Configurador.pAdicionarCampo('KIN_ORIGEM', 'Origem', 'LIKE');
  Configurador.pAdicionarCampo('KIN_DESMON', 'Montadora', 'LIKE');
  Configurador.pAdicionarCampo('KIN_DESLIN', 'Linha', 'LIKE');
  Configurador.pAdicionarCampo('KIN_ANOCOR', 'Ano Cor', 'LIKE');
  Configurador.pAdicionarCampo('KIN_DESCRI', 'Descrição', 'LIKE');
  Configurador.pAdicionarCampo('KIN_MD5KEY', 'Chave MD5', 'LIKE', False, True);
  Configurador.pAdicionarCampo('KIN_CODMON', 'Código Montadora', 'LIKE', False, False);
  Configurador.pAdicionarCampo('KIN_LINHA_', 'Código Linha', 'LIKE', False, False);
  Configurador.pAdicionarCampo('KIN_ACRMOB', 'Acréscimo mao de Obra', 'LIKE', False, False);


  Configurador.fSetVisivel('KIN_CODIGO', True);
  Configurador.fSetVisivel('KIN_NOMCOR', True);
  Configurador.fSetVisivel('KIN_PRODUT', True);
  Configurador.fSetVisivel('KIN_SISTEM', True);
  Configurador.fSetVisivel('KIN_ORIGEM', True);
  Configurador.fSetVisivel('KIN_DESMON', True);
  Configurador.fSetVisivel('KIN_DESLIN', True);
  Configurador.fSetVisivel('KIN_DTACAD', True);
  Configurador.fSetVisivel('KIN_DESCRI', True);
  Configurador.fSetVisivel('KIN_ANOCOR', True);

  Configurador.pAdicionarIndice('KIN_DESCRI', 'Descrição');
  Configurador.pAdicionarIndice('KIN_ORIGEM+KIN_SISTEM', 'Origem/Sistema');
  Configurador.pAdicionarIndice('KIN_ANOCOR', 'Ano Cor');
  Configurador.pAdicionarIndice('KIN_NOMCOR', 'Nome Cor');
  Configurador.pAdicionarIndice('KIN_CODIGO', 'Código');
  Configurador.pAdicionarIndice('KIN_DESMON', 'Montadora');
  Configurador.pAdicionarIndice('KIN_DESLIN', 'Linha');

  Configurador.pAdicionarCampoDescricao('KIN_CODIGO');
  Configurador.pAdicionarCampoDescricao('KIN_NOMCOR');
  Configurador.pAdicionarCampoDescricao('KIN_PRODUT');
  Configurador.pAdicionarCampoDescricao('KIN_SISTEM');
  Configurador.pAdicionarCampoDescricao('KIN_ORIGEM');
  Configurador.pAdicionarCampoDescricao('KIN_DESMON');
  Configurador.pAdicionarCampoDescricao('KIN_DESLIN');
  Configurador.pAdicionarCampoDescricao('KIN_DTACAD');
  Configurador.pAdicionarCampoDescricao('KIN_DESCRI');
  Configurador.pAdicionarCampoDescricao('KIN_ANOCOR');

end;

end.
