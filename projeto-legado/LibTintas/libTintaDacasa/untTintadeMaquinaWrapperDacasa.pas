{**************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta Dacasa *}
{***********************************************************************************AC*}
unit untTintadeMaquinaWrapperDacasa;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils, untIDataSet;

type
  TTintadeMaquinaWrapperDacasa = class(TAbstractTintadeMaquinaWrapper)
  public
    procedure Configurar(const configurador: IConfiguradorConsulta); override;
    function GetCampoAutoIncrem: String; override;
    function fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String; override;
    procedure pRestaurarPadrao(const configurador: IConfiguradorConsulta); override;
    function fGetSelectFrom(const configurador: IConfiguradorConsulta): String; override;
    function GetNomeTinta: String; override;
    function GetNomeForm: String; override;
    function GetNomeTabela: String; override;
    function GetConsultaComp(strTabPre: String): IConsultaComp; override;
    function fGetWhere: String; override;
  end;

implementation

uses
{$IFNDEF LINUX}
  untConsultaCompDacasa,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperDacasa }

procedure TTintadeMaquinaWrapperDacasa.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  //Configurador Dacasa
  Configurador.pAdicionarCampo('DCA_CODIGO', 'Código', 'LIKE');
  Configurador.pAdicionarCampo('DCA_CODBAS', 'Código Base',  'LIKE');
  Configurador.pAdicionarCampo('DCA_PRODUT', 'Produto', 'LIKE');
  Configurador.pAdicionarCampo('DCA_COLECA', 'Coleçao', 'LIKE');
  Configurador.pAdicionarCampo('DCA_UNIDAD', 'Unidade', 'LIKE');
  Configurador.pAdicionarCampo('DCA_NOMCOR', 'Nome Cor', 'LIKE');
  Configurador.pAdicionarCampo('DCA_DTACAD', 'Data Cadastro', 'LIKE');
  Configurador.pAdicionarCampo('CADITE.ITE_DESITE', 'Descrição do Item', 'LIKE');
  Configurador.pAdicionarCampo('CADITE.ITE_CODITE', 'Código do Item', 'LIKE', False, True);
  Configurador.pAdicionarCampo('DCA_MD5KEY', 'Chave MD5', '=', False, True);
  Configurador.pAdicionarCampo('DCA_ACRMOB', 'Acrescimo Mao Obra', '=', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');

  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('DCA_FORM' + TStrUtils.fStrZero(intCont, 2), 'DCA_FORM' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('DCA_QTDC' + TStrUtils.fStrZero(intCont, 2), 'DCA_QTDC' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperDacasa.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  Result := Result + ' AND UPPER(IFNULL(DCA_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperDacasa.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result := '';
  Result := Result + '  DCA_CADDCA ';
  Result := Result + '   INNER JOIN DCA_CADBAS ';
  Result := Result + '     ON DCA_CODBAS = BAS_CODBAS ';
  Result := Result + '       AND DCA_PRODUT = BAS_PRODUT ';
  Result := Result + '       AND DCA_UNIDAD = BAS_UNIDAD ';
  Result := Result + '  	  INNER JOIN CADITE ON CADITE.ITE_CODITE = BAS_CODITE     ';
  Result := Result + '     AND CADITE.ITE_ITEATI = "S"          ';
  Result := Result + '      INNER JOIN ITEGER ON         ';
  Result := Result + '       BAS_CODITE = ITEGER.ITE_CODITE AND    ';
  Result := Result + '       ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
end;

function TTintadeMaquinaWrapperDacasa.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(DCA_ATIVAD,"S")) = "S" ';
end;

function TTintadeMaquinaWrapperDacasa.GetCampoAutoIncrem: String;
begin
  Result := 'DCA_CADDCA.AUTOINCREM';
end;

function TTintadeMaquinaWrapperDacasa.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompDacasa.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperDacasa.GetNomeForm: String;
begin
  Result := 'Dacasa';
end;

function TTintadeMaquinaWrapperDacasa.GetNomeTabela: String;
begin
  Result := 'DCA_CADDCA';
end;

function TTintadeMaquinaWrapperDacasa.GetNomeTinta: String;
begin
  Result := 'Dacasa';
end;

procedure TTintadeMaquinaWrapperDacasa.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  Configurador.fSetPos('DCA_CODIGO', 0);
  Configurador.fSetPos('DCA_UNIDAD', 1);
  Configurador.fSetPos('DCA_DESCRI', 2);
  Configurador.fSetPos('DCA_COLECA', 3);
  Configurador.fSetPos('CADITE.ITE_DESITE', 4);
  Configurador.fSetPos('DCA_CODBAS', 5);
  Configurador.fSetPos('DCA_PRODUT', 6);
  Configurador.fSetPos('CADITE.ITE_CODITE', 7);

  Configurador.fSetVisivel('DCA_CODIGO' , True);
  Configurador.fSetVisivel('DCA_UNIDAD' , True);
  Configurador.fSetVisivel('DCA_DESCRI' , True);
  Configurador.fSetVisivel('DCA_COLECA' , True);
  Configurador.fSetVisivel('CADITE.ITE_DESITE' , True);
  Configurador.fSetVisivel('DCA_CODBAS' , True);
  Configurador.fSetVisivel('DCA_PRODUT' , True);
  Configurador.fSetVisivel('CADITE.ITE_CODITE' , True);

  configurador.pAdicionarIndice('DCA_DESCRI+DCA_UNIDAD' , 'Descrição Cor\Unidade');
  configurador.pAdicionarIndice('DCA_CODIGO'  , 'Código');
  Configurador.pAdicionarIndice('DCA_PRODUT'  , 'Produto');
  Configurador.pAdicionarIndice('CADITE.ITE_DESITE'  , 'Descrição do Item');

  configurador.pAdicionarCampoDescricao('DCA_UNIDAD');
end;

end.



