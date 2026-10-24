{*****************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta Colorbraz *}
{**************************************************************************************PH*}
unit untTintadeMaquinaWrapperColorbraz;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperColorbraz = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompColorbraz,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperColorbraz }

procedure TTintadeMaquinaWrapperColorbraz.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin

  configurador.pAdicionarCampo('CLB_CODIGO', 'Código Formula', 'LIKE');
  configurador.pAdicionarCampo('CLB_NOMCOR', 'Nome da Cor', 'LIKE');
  configurador.pAdicionarCampo('CLB_CODBAS', 'Código Base', 'LIKE');
  configurador.pAdicionarCampo('CLB_PRODUT', 'Produto', 'LIKE');
  configurador.pAdicionarCampo('CLB_UNIDAD', 'Unidade', 'LIKE');
  configurador.pAdicionarCampo('CLB_COLECA', 'Coleção', 'LIKE', False, False);
  configurador.pAdicionarCampo('CLB_SUBCOL', 'Sub Coleção', 'LIKE', False, False);
  configurador.pAdicionarCampo('CLB_DTACAD', 'Data Cadastro', 'LIKE', False, False);
  configurador.pAdicionarCampo('CLB_MD5KEY', 'Chave MD5', '=', False, True);
  configurador.pAdicionarCampo('I.ITE_CODITE', 'Código Item', '=');
  configurador.pAdicionarCampo('I.ITE_DESITE', 'Descrição do Item', '=');
  Configurador.pAdicionarCampo('CLB_ACRMOB', 'CLB_ACRMOB', 'LIKE', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');


  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('CLB_FORM' + TStrUtils.fStrZero(intCont, 2), 'CLB_CODC' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('CLB_QTDC' + TStrUtils.fStrZero(intCont, 2), 'CLB_QTDC' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperColorbraz.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  Result := Result + ' AND UPPER(IFNULL(CLB_ATIVO_, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperColorbraz.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result := Result + '  CLB_CADCLB ';
  Result := Result + ' 	INNER JOIN CLB_CADBAS B ON      ';
  Result := Result + '    CLB_CODBAS = BAS_CODBAS AND         ';
  Result := Result + '    CLB_PRODUT = BAS_PRODUT AND         ';
  Result := Result + '    CLB_UNIDAD = BAS_UNIDAD             ';
  Result := Result + ' 	INNER JOIN CADITE I ON BAS_CODITE = I.ITE_CODITE ';
  Result := Result + '     AND I.ITE_ITEATI = "S"          ';
  Result := Result + '  INNER JOIN ITEGER ON         ';
  Result := Result + '       BAS_CODITE = ITEGER.ITE_CODITE AND    ';
  Result := Result + '       ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
end;

function TTintadeMaquinaWrapperColorbraz.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(CLB_ATIVO_,"S")) = "S" ';
end;

function TTintadeMaquinaWrapperColorbraz.GetCampoAutoIncrem: String;
begin
  Result := 'CLB_CADCLB.AUTOINCREM';
end;

function TTintadeMaquinaWrapperColorbraz.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompColorbraz.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperColorbraz.GetNomeForm: String;
Begin
  Result := 'Colorbraz';
End;

function TTintadeMaquinaWrapperColorbraz.GetNomeTinta: String;
Begin
  Result := 'Colorbraz';
End;

function TTintadeMaquinaWrapperColorbraz.GetNomeTabela: String;
begin
  Result := 'CLB_CADCLB';
end;

procedure TTintadeMaquinaWrapperColorbraz.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  Configurador.fSetPos('CLB_CODIGO', 0);
  Configurador.fSetPos('CLB_NOMCOR', 1);
  Configurador.fSetPos('CLB_CODBAS', 2);
  Configurador.fSetPos('CLB_PRODUT', 3);
  Configurador.fSetPos('CLB_UNIDAD', 4);


  Configurador.fSetVisivel('CLB_CODIGO', True);
  Configurador.fSetVisivel('CLB_NOMCOR', True);
  Configurador.fSetVisivel('CLB_CODBAS', True);
  Configurador.fSetVisivel('CLB_PRODUT', True);
  Configurador.fSetVisivel('CLB_UNIDAD', True);

  Configurador.pAdicionarIndice('CLB_CODIGO', 'Código Formula');
  Configurador.pAdicionarIndice('CLB_NOMCOR', 'Nome da Cor');
  Configurador.pAdicionarIndice('CLB_CODBAS', 'Código Base');
  Configurador.pAdicionarIndice('CLB_PRODUT', 'Produto');
  Configurador.pAdicionarIndice('CLB_UNIDAD', 'Unidade');

  Configurador.pAdicionarCampoDescricao('CLB_CODIGO');
  Configurador.pAdicionarCampoDescricao('CLB_NOMCOR');
  Configurador.pAdicionarCampoDescricao('CLB_CODBAS');
  Configurador.pAdicionarCampoDescricao('CLB_PRODUT');
  Configurador.pAdicionarCampoDescricao('CLB_UNIDAD');
end;

end.
