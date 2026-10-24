{*****************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta Lukscolor2 *}
{**************************************************************************************PH*}
unit untTintadeMaquinaWrapperLukscolor2;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperLukscolor2 = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompLukscolor2,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperLukscolor2 }

procedure TTintadeMaquinaWrapperLukscolor2.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin

  configurador.pAdicionarCampo('LKC_CODIGO', 'Código Formula', 'LIKE');
  configurador.pAdicionarCampo('LKC_NOMCOR', 'Nome da Cor', 'LIKE');
  configurador.pAdicionarCampo('LKC_CODBAS', 'Código Base', 'LIKE');
  configurador.pAdicionarCampo('LKC_PRODUT', 'Produto', 'LIKE');
  configurador.pAdicionarCampo('LKC_UNIDAD', 'Unidade', 'LIKE');
  Configurador.pAdicionarCampo('LKC_CONTEU', 'Embalagem', 'LIKE');
  configurador.pAdicionarCampo('LKC_COLECA', 'Coleção', 'LIKE');
  configurador.pAdicionarCampo('LKC_SUBCOL', 'Sub Coleção', 'LIKE');
  configurador.pAdicionarCampo('LKC_DTACAD', 'Data Cadastro', 'LIKE', False, False);
  configurador.pAdicionarCampo('LKC_MD5KEY', 'Chave MD5', '=', False, True);
  configurador.pAdicionarCampo('I.ITE_CODITE', 'Código Item', '=');
  configurador.pAdicionarCampo('I.ITE_DESITE', 'Descrição do Item', '=');
  Configurador.pAdicionarCampo('LKC_ACRMOB', 'LKC_ACRMOB', 'LIKE', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');


  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('LKC_FORM' + TStrUtils.fStrZero(intCont, 2), 'LKC_CODC' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('LKC_QTDC' + TStrUtils.fStrZero(intCont, 2), 'LKC_QTDC' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperLukscolor2.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  Result := Result + ' AND UPPER(IFNULL(LKC_ATIVO_, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperLukscolor2.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result := Result + '  LKC_CADLKC ';
  Result := Result + ' 	INNER JOIN LKC_CADBAS B ON      ';
  Result := Result + '    LKC_CODBAS = BAS_CODBAS AND         ';
  Result := Result + '    LKC_PRODUT = BAS_PRODUT AND         ';
  Result := Result + '    LKC_UNIDAD = BAS_UNIDAD AND         ';
  Result := Result + '    LKC_CONTEU = BAS_CONTEU             ';
  Result := Result + ' 	INNER JOIN CADITE I ON BAS_CODITE = I.ITE_CODITE ';
  Result := Result + '     AND I.ITE_ITEATI = "S"          ';
  Result := Result + '  INNER JOIN ITEGER ON         ';
  Result := Result + '       BAS_CODITE = ITEGER.ITE_CODITE AND    ';
  Result := Result + '       ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
end;

function TTintadeMaquinaWrapperLukscolor2.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(LKC_ATIVO_,"S")) = "S" ';
end;

function TTintadeMaquinaWrapperLukscolor2.GetCampoAutoIncrem: String;
begin
  Result := 'LKC_CADLKC.AUTOINCREM';
end;

function TTintadeMaquinaWrapperLukscolor2.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompLukscolor2.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperLukscolor2.GetNomeForm: String;
Begin
  Result := 'Lukscolor2';
End;

function TTintadeMaquinaWrapperLukscolor2.GetNomeTinta: String;
Begin
  Result := 'Lukscolor';
End;

function TTintadeMaquinaWrapperLukscolor2.GetNomeTabela: String;
begin
  Result := 'LKC_CADLKC';
end;

procedure TTintadeMaquinaWrapperLukscolor2.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  Configurador.fSetPos('LKC_CODIGO', 0);
  Configurador.fSetPos('LKC_NOMCOR', 1);
  Configurador.fSetPos('LKC_CODBAS', 2);
  Configurador.fSetPos('LKC_PRODUT', 3);
  Configurador.fSetPos('LKC_UNIDAD', 4);


  Configurador.fSetVisivel('LKC_CODIGO', True);
  Configurador.fSetVisivel('LKC_NOMCOR', True);
  Configurador.fSetVisivel('LKC_CODBAS', True);
  Configurador.fSetVisivel('LKC_PRODUT', True);
  Configurador.fSetVisivel('LKC_UNIDAD', True);

  Configurador.pAdicionarIndice('LKC_CODIGO', 'Código Formula');
  Configurador.pAdicionarIndice('LKC_NOMCOR', 'Nome da Cor');
  Configurador.pAdicionarIndice('LKC_CODBAS', 'Código Base');
  Configurador.pAdicionarIndice('LKC_PRODUT', 'Produto');
  Configurador.pAdicionarIndice('LKC_UNIDAD', 'Unidade');

  Configurador.pAdicionarCampoDescricao('LKC_CODIGO');
  Configurador.pAdicionarCampoDescricao('LKC_NOMCOR');
  Configurador.pAdicionarCampoDescricao('LKC_CODBAS');
  Configurador.pAdicionarCampoDescricao('LKC_PRODUT');
  Configurador.pAdicionarCampoDescricao('LKC_UNIDAD');
end;

end.
