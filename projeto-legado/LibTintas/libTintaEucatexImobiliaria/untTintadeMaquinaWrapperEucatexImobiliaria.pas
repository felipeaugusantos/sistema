{*****************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta Eucatex Imobiliaria *}
{**************************************************************************************PH*}
unit untTintadeMaquinaWrapperEucatexImobiliaria;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperEucatexImobiliaria = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompEucatexImobiliaria,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperEucatexImobiliaria }

procedure TTintadeMaquinaWrapperEucatexImobiliaria.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  configurador.pAdicionarCampo('EUC_CODCOR', 'Cód. da Cor', 'LIKE');
  configurador.pAdicionarCampo('EUC_DESCOR', 'Cor', 'LIKE');
  configurador.pAdicionarCampo('EUC_PRODUT', 'Produto', 'LIKE');
  configurador.pAdicionarCampo('EUC_DESBAS', 'Base', 'LIKE');
  configurador.pAdicionarCampo('EUC_UNIDAD', 'Unidade', 'LIKE');
  configurador.pAdicionarCampo('BAS_CODITE', 'Cód Item', 'LIKE');
  configurador.pAdicionarCampo('EUC_DTACAD', 'Data Cadastro', 'LIKE');
  configurador.pAdicionarCampo('EUC_EMBALA', 'Embalagem', 'LIKE');
  configurador.pAdicionarCampo('EUC_CODNFM', 'Codigo novas formulas', 'LIKE', False, False);
  configurador.pAdicionarCampo('CADITE.ITE_CODITE', 'Código do Item', 'LIKE');
  configurador.pAdicionarCampo('CADITE.ITE_DESITE', 'Descrição do Item', 'LIKE');
  configurador.pAdicionarCampo('CADITE.ITE_REFERE', 'Referência do Item', 'LIKE');
  configurador.pAdicionarCampo('EUC_OBSCOR', 'Observação Cor', 'LIKE');
  Configurador.pAdicionarCampo('EUC_COLECA', 'Coleção', 'LIKE');
  configurador.pAdicionarCampo('EUC_MD5KEY', 'MD5KEY', '=', False, True);
  Configurador.pAdicionarCampo('EUC_ACRMOB', 'EUC_ACRMOB', 'LIKE', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');


  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('EUC_FORM' + TStrUtils.fStrZero(intCont, 2), 'EUC_FORM' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('EUC_QTDB' + TStrUtils.fStrZero(intCont, 2), 'EUC_QTDB' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperEucatexImobiliaria.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  Result := Result + ' AND UPPER(IFNULL(EUC_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperEucatexImobiliaria.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result :=
     '  	EUC_CADEUC  ' +
     '     	INNER JOIN EUC_CADBAS ON EUC_PRODUT = BAS_PRODUT ' +
     '  		                     AND EUC_DESBAS = BAS_DESCRI ' +
     '                           AND EUC_UNIDAD = BAS_CODUNI ' +
     '                           AND EUC_EMBALA = BAS_EMBALA ' +
     '  	  INNER JOIN CADITE ON CADITE.ITE_CODITE = BAS_CODITE      ' +
     '     AND CADITE.ITE_ITEATI = "S"                       ' +
     '      INNER JOIN ITEGER ON BAS_CODITE = ITEGER.ITE_CODITE AND  ' +
     '      ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
end;

function TTintadeMaquinaWrapperEucatexImobiliaria.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(EUC_ATIVAD,"S")) = "S" ';
end;

function TTintadeMaquinaWrapperEucatexImobiliaria.GetCampoAutoIncrem: String;
begin
  Result := 'EUC_CADEUC.AUTOINCREM';
end;

function TTintadeMaquinaWrapperEucatexImobiliaria.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompEucatexImobiliaria.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperEucatexImobiliaria.GetNomeTabela: String;
begin
  Result := 'EUC_CADEUC';
end;

procedure TTintadeMaquinaWrapperEucatexImobiliaria.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  configurador.fSetPos('EUC_CODCOR', 0);
  configurador.fSetPos('EUC_DESCOR', 1);
  configurador.fSetPos('EUC_PRODUT', 2);
  configurador.fSetPos('EUC_DESBAS', 3);
  configurador.fSetPos('EUC_UNIDAD', 4);
  configurador.fSetPos('BAS_CODITE', 5);
  configurador.fSetPos('CADITE.ITE_DESITE', 6);
  configurador.fSetPos('EUC_OBSCOR', 7);
  configurador.fSetPos('EUC_DTACAD', 8);

  configurador.fSetVisivel('EUC_CODCOR', True);
  configurador.fSetVisivel('EUC_DESCOR', True);
  configurador.fSetVisivel('EUC_PRODUT', True);
  configurador.fSetVisivel('EUC_DESBAS', True);
  configurador.fSetVisivel('EUC_UNIDAD', True);
  configurador.fSetVisivel('BAS_CODITE', True);
  configurador.fSetVisivel('CADITE.ITE_DESITE', True);
  configurador.fSetVisivel('EUC_OBSCOR', True);
  configurador.fSetVisivel('EUC_DTACAD', True);

  configurador.pAdicionarIndice('EUC_CODCOR+EUC_DESCOR+EUC_PRODUT', 'Cód. da Cor/Cor/Produto');
  configurador.pAdicionarIndice('EUC_DESCOR+EUC_PRODUT+EUC_DESBAS+EUC_OBSCOR', 'Cor/Produto/Base/Observação Cor');

  configurador.pAdicionarCampoDescricao('EUC_CODCOR');
  configurador.pAdicionarCampoDescricao('EUC_DESCOR');
  configurador.pAdicionarCampoDescricao('EUC_PRODUT');
  configurador.pAdicionarCampoDescricao('EUC_DESBAS');
  configurador.pAdicionarCampoDescricao('EUC_UNIDAD');
  configurador.pAdicionarCampoDescricao('BAS_CODITE');
  configurador.pAdicionarCampoDescricao('CADITE.ITE_DESITE');
  configurador.pAdicionarCampoDescricao('EUC_OBSCOR');
  configurador.pAdicionarCampoDescricao('EUC_DTACAD');
end;

end.
