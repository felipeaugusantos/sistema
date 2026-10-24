{*****************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta Kresil *}
{**************************************************************************************PH*}
unit untTintadeMaquinaWrapperKresil;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperKresil = class(TAbstractTintadeMaquinaWrapper)
  public
    procedure Configurar(const configurador: IConfiguradorConsulta); override;
    function GetCampoAutoIncrem: String; override;
    function fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String; override;
    function GetNomeTinta: String; override;
    function GetNomeForm: String; override;
    procedure pRestaurarPadrao(const configurador: IConfiguradorConsulta); override;
    function fGetSelectFrom(const configurador: IConfiguradorConsulta): String; override;
    function GetNomeTabela: String; override;
    function GetConsultaComp(strTabPre: String): IConsultaComp; override;
    function fGetWhere: String; override;
  end;

implementation

uses
{$IFNDEF LINUX}
  untConsultaCompKresil,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperKresil }

procedure TTintadeMaquinaWrapperKresil.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin

  configurador.pAdicionarCampo('KRE_CODIGO', 'Código Formula', 'LIKE');
  configurador.pAdicionarCampo('KRE_NOMCOR', 'Nome da Cor', 'LIKE');
  configurador.pAdicionarCampo('KRE_BASE__', 'Código Base', 'LIKE');
  configurador.pAdicionarCampo('KRE_PRODUT', 'Produto', 'LIKE');
  configurador.pAdicionarCampo('KRE_UNIDAD', 'Unidade', 'LIKE');
  configurador.pAdicionarCampo('KRE_COLECA', 'Coleção', 'LIKE', False, False);
  configurador.pAdicionarCampo('KRE_DTACAD', 'Data Cadastro', 'LIKE', False, False);
  configurador.pAdicionarCampo('KRE_MD5KEY', 'Chave MD5', '=', False, True);
  configurador.pAdicionarCampo('I.ITE_CODITE', 'Código Item', '=');
  configurador.pAdicionarCampo('I.ITE_DESITE', 'Descrição do Item', '=');
  Configurador.pAdicionarCampo('KRE_ACRMOB', 'KRE_ACRMOB', 'LIKE', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');


  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('KRE_FORM' + TStrUtils.fStrZero(intCont, 2), 'KRE_CODC' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('KRE_QTDC' + TStrUtils.fStrZero(intCont, 2), 'KRE_QTDC' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperKresil.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  Result := Result + ' AND UPPER(IFNULL(KRE_ATIVO_, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperKresil.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result := Result + '  KRE_CADKRE ';
  Result := Result + ' 	INNER JOIN KRE_CADBAS B ON      ';
  Result := Result + '    KRE_BASE__ = BAS_BASE__ AND         ';
  Result := Result + '    KRE_PRODUT = BAS_PRODUT AND         ';
  Result := Result + '    KRE_UNIDAD = BAS_UNIDAD             ';
  Result := Result + ' 	INNER JOIN CADITE I ON BAS_CODITE = I.ITE_CODITE ';
  Result := Result + '     AND I.ITE_ITEATI = "S"          ';
  Result := Result + '  INNER JOIN ITEGER ON         ';
  Result := Result + '       BAS_CODITE = ITEGER.ITE_CODITE AND    ';
  Result := Result + '       ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
end;

function TTintadeMaquinaWrapperKresil.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(KRE_ATIVO_,"S")) = "S" ';
end;

function TTintadeMaquinaWrapperKresil.GetCampoAutoIncrem: String;
begin
  Result := 'KRE_CADKRE.AUTOINCREM';
end;

function TTintadeMaquinaWrapperKresil.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompKresil.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperKresil.GetNomeForm: String;
Begin
  Result := 'Kresil';
End;

function TTintadeMaquinaWrapperKresil.GetNomeTinta: String;
Begin
  Result := 'Kresil';
End;

function TTintadeMaquinaWrapperKresil.GetNomeTabela: String;
begin
  Result := 'KRE_CADKRE';
end;

procedure TTintadeMaquinaWrapperKresil.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  Configurador.fSetPos('KRE_CODIGO', 0);
  Configurador.fSetPos('KRE_NOMCOR', 1);
  Configurador.fSetPos('KRE_BASE__', 2);
  Configurador.fSetPos('KRE_PRODUT', 3);
  Configurador.fSetPos('KRE_UNIDAD', 4);


  Configurador.fSetVisivel('KRE_CODIGO', True);
  Configurador.fSetVisivel('KRE_NOMCOR', True);
  Configurador.fSetVisivel('KRE_BASE__', True);
  Configurador.fSetVisivel('KRE_PRODUT', True);
  Configurador.fSetVisivel('KRE_UNIDAD', True);

  Configurador.pAdicionarIndice('KRE_CODIGO', 'Código Formula');
  Configurador.pAdicionarIndice('KRE_NOMCOR', 'Nome da Cor');
  Configurador.pAdicionarIndice('KRE_BASE__', 'Código Base');
  Configurador.pAdicionarIndice('KRE_PRODUT', 'Produto');
  Configurador.pAdicionarIndice('KRE_UNIDAD', 'Unidade');

  Configurador.pAdicionarCampoDescricao('KRE_CODIGO');
  Configurador.pAdicionarCampoDescricao('KRE_NOMCOR');
  Configurador.pAdicionarCampoDescricao('KRE_BASE__');
  Configurador.pAdicionarCampoDescricao('KRE_PRODUT');
  Configurador.pAdicionarCampoDescricao('KRE_UNIDAD');
end;

end.
