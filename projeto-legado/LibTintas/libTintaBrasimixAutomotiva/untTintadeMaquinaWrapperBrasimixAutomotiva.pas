{****************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta BrasimixAutomotiva *}
{*************************************************************************************AC*}
unit untTintadeMaquinaWrapperBrasimixAutomotiva;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperBrasimixAutomotiva = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompBrasimixAutomotiva,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperBrasimixAutomotiva }

procedure TTintadeMaquinaWrapperBrasimixAutomotiva.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin

  configurador.pAdicionarCampo('BZA_CODSEQ','Cód.Sequencial',        'LIKE');
  configurador.pAdicionarCampo('BZA_DTACAD','Data Cadastro',         'LIKE');
  configurador.pAdicionarCampo('BZA_ATIVAD','Ativado',               'LIKE');
  configurador.pAdicionarCampo('BZA_MONTAD','Montadora',             'LIKE');
  configurador.pAdicionarCampo('BZA_A_N_O_','Ano',                   'LIKE');
  configurador.pAdicionarCampo('BZA_DESCRI','Descrição',             'LIKE');
  configurador.pAdicionarCampo('BZA_CODUNI','Cód.Universal',         'LIKE');
  configurador.pAdicionarCampo('BZA_ARQTXT','Tipo',                  'LIKE');
  configurador.pAdicionarCampo('BZA_CODNFM','Cód.Nfm',               'LIKE');
  configurador.pAdicionarCampo('BZA_MD5KEY','MD5KEY',                'LIKE',  False, False);
  configurador.pAdicionarCampo('BZA_ACRMOB','Acréscimo mão de obra', 'LIKE',  False, False);


  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('BZA_CODB' + TStrUtils.fStrZero(intCont, 2), 'BZA_CODB' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
    configurador.pAdicionarCampo('BZA_QTDB' + TStrUtils.fStrZero(intCont, 2), 'BZA_QTDB' + TStrUtils.fStrZero(intCont, 2), '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperBrasimixAutomotiva.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador) +
    ' AND UPPER(IFNULL(BZA_ATIVAD, "S")) = "S" ';
end;

function TTintadeMaquinaWrapperBrasimixAutomotiva.fGetSelectFrom(
  const configurador: IConfiguradorConsulta): String;
begin
  Result := 'BZA_CADBZA A';
end;

function TTintadeMaquinaWrapperBrasimixAutomotiva.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(BZA_ATIVAD, "S")) = "S" ';
end;

function TTintadeMaquinaWrapperBrasimixAutomotiva.GetCampoAutoIncrem: String;
begin
  Result := 'A.AUTOINCREM';
end;

function TTintadeMaquinaWrapperBrasimixAutomotiva.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompBrasimixAutomotiva.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperBrasimixAutomotiva.GetNomeTabela: String;
begin
  Result := 'BZA_CADBZA ';
end;

procedure TTintadeMaquinaWrapperBrasimixAutomotiva.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin

  configurador.fSetPos('BZA_CODSEQ',0);
  configurador.fSetPos('BZA_MONTAD',1);
  configurador.fSetPos('BZA_A_N_O_',2);
  configurador.fSetPos('BZA_DESCRI',3);
  configurador.fSetPos('BZA_CODUNI',4);
  configurador.fSetPos('BZA_ARQTXT',5);
  configurador.fSetPos('BZA_CODNFM',6);
  configurador.fSetPos('BZA_MD5KEY',7);
  configurador.fSetPos('BZA_DTACAD',8);
  configurador.fSetPos('BZA_ATIVAD',9);
  configurador.fSetPos('BZA_ACRMOB',10);


  configurador.fSetVisivel('BZA_CODSEQ',true);
  configurador.fSetVisivel('BZA_MONTAD',true);
  configurador.fSetVisivel('BZA_A_N_O_',true);
  configurador.fSetVisivel('BZA_DESCRI',true);
  configurador.fSetVisivel('BZA_CODUNI',true);
  configurador.fSetVisivel('BZA_ARQTXT',true);
  configurador.fSetVisivel('BZA_CODNFM',true);
  configurador.fSetVisivel('BZA_MD5KEY',true);
  configurador.fSetVisivel('BZA_DTACAD',true);
  configurador.fSetVisivel('BZA_ATIVAD',true);
  configurador.fSetVisivel('BZA_ACRMOB',true);

  configurador.pAdicionarIndice('BZA_CODSEQ','Cód.Sequencial');
  configurador.pAdicionarIndice('BZA_MONTAD','Montadora');
  configurador.pAdicionarIndice('BZA_A_N_O_','Ano');
  configurador.pAdicionarIndice('BZA_DESCRI','Descrição');
  configurador.pAdicionarIndice('BZA_CODUNI','Cód.Universal');
  configurador.pAdicionarIndice('BZA_ARQTXT','Tipo');
  configurador.pAdicionarIndice('BZA_CODNFM','Cód.Nfm');
  configurador.pAdicionarIndice('BZA_MD5KEY','MD5KEY');
  configurador.pAdicionarIndice('BZA_DTACAD','Data Cadastro');
  configurador.pAdicionarIndice('BZA_ATIVAD','Ativado');
  configurador.pAdicionarIndice('BZA_ACRMOB','Acréscimo mão de obra');

  configurador.pAdicionarCampoDescricao('BZA_CODSEQ');
  configurador.pAdicionarCampoDescricao('BZA_MONTAD');
  configurador.pAdicionarCampoDescricao('BZA_A_N_O_');
  configurador.pAdicionarCampoDescricao('BZA_DESCRI');
  configurador.pAdicionarCampoDescricao('BZA_CODUNI');
  configurador.pAdicionarCampoDescricao('BZA_ARQTXT');
  configurador.pAdicionarCampoDescricao('BZA_CODNFM');
  configurador.pAdicionarCampoDescricao('BZA_MD5KEY');
  configurador.pAdicionarCampoDescricao('BZA_DTACAD');
  configurador.pAdicionarCampoDescricao('BZA_ATIVAD');
  configurador.pAdicionarCampoDescricao('BZA_ACRMOB');
end;

end.
