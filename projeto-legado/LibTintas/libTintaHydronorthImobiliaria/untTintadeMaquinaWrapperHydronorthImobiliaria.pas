{**************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta HydronorthImobiliaria *}
{***********************************************************************************AC*}
unit untTintadeMaquinaWrapperHydronorthImobiliaria;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperHydronorthImobiliaria = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompHydronorthImobiliaria,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperHydronorthImobiliaria }

procedure TTintadeMaquinaWrapperHydronorthImobiliaria.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  configurador.pAdicionarCampo('HYD_COLECA', 'Coleção', 'LIKE');
  configurador.pAdicionarCampo('HYD_PRODUT', 'Produto', 'LIKE');
  configurador.pAdicionarCampo('HYD_C_O_R_', 'Cor', 'LIKE');
  configurador.pAdicionarCampo('HYD_CORLON', 'Cor Nome Longo', 'LIKE');
  configurador.pAdicionarCampo('HYD_BASE__', 'Base', 'LIKE');
  configurador.pAdicionarCampo('HYD_CODNFM', 'Código Novas Fórmulas', 'LIKE');
  configurador.pAdicionarCampo('CADITE.ITE_CODITE', 'Código do Item', 'LIKE');
  configurador.pAdicionarCampo('CADITE.ITE_DESITE', 'Descrição do Item', 'LIKE');
  configurador.pAdicionarCampo('HYD_CODEMB', 'Código da Embalagem', 'LIKE');
  configurador.pAdicionarCampo('HYD_MD5KEY', 'MD5KEY', '=', False, True);
  Configurador.pAdicionarCampo('HYD_ACRMOB', 'HYD_ACRMOB', 'LIKE', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');

  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('HYD_FORM' + TStrUtils.fStrZero(intCont, 2), 'HYD_FORM' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('HYD_QTDC' + TStrUtils.fStrZero(intCont, 2), 'HYD_QTDC' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperHydronorthImobiliaria.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  If TAutcomTintaFactory.Get.fGetConfTinta('HYD').fGetBoolean('USAFOR') Then
    Result := Result + '     AND HYD_QTDC01 > 0.0 ';

  Result := Result + ' AND UPPER(IFNULL(HYD_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperHydronorthImobiliaria.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result := '';
  Result := Result + '  HYD_CADHYD ';
  Result := Result + '   INNER JOIN HYD_CADBAS ';
  Result := Result + '     ON HYD_BASE__ = BAS_BASE__ ';
  Result := Result + '       AND HYD_PRODUT = BAS_PRODUT ';
  Result := Result + '       AND HYD_CODEMB = BAS_CODEMB ';
  Result := Result + '   INNER JOIN CADITE ';

  If TStrUtils.fEmptyStr(configurador.GetCodIte) Then
  Begin
    Result := Result + '     ON BAS_CODITE = CADITE.ITE_CODITE ';
    Result := Result + '     AND CADITE.ITE_ITEATI = "S"          ';
    Result := Result + '     INNER JOIN ITEGER ON         ';
    Result := Result + '       BAS_CODITE = ITEGER.ITE_CODITE AND    ';
    Result := Result + '       ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
  End
  Else
  Begin
    Result := Result + '     ON ' + AnsiQuotedStr(configurador.GetCodIte, '"') + ' = CADITE.ITE_CODITE ';
    Result := Result + '     AND CADITE.ITE_ITEATI = "S"          ';
    Result := Result + '     INNER JOIN ITEGER ON         ';
    Result := Result + AnsiQuotedStr(configurador.GetCodIte, '"') + ' = ITEGER.ITE_CODITE AND ';
    Result := Result + '       ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
  End;
end;

function TTintadeMaquinaWrapperHydronorthImobiliaria.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(HYD_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperHydronorthImobiliaria.GetCampoAutoIncrem: String;
begin
  Result := 'HYD_CADHYD.AUTOINCREM';
end;

function TTintadeMaquinaWrapperHydronorthImobiliaria.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompHydronorthImobiliaria.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')), //TAutcomTintaFactory.Get.fCfgSis('TABPAD', varString)
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperHydronorthImobiliaria.GetNomeTabela: String;
begin
  Result := 'HYD_CADHYD';
end;

procedure TTintadeMaquinaWrapperHydronorthImobiliaria.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  configurador.fSetPos('HYD_COLECA', 0);
  configurador.fSetPos('HYD_PRODUT', 1);
  configurador.fSetPos('HYD_C_O_R_', 2);
  configurador.fSetPos('HYD_CORLON', 3);
  configurador.fSetPos('HYD_BASE__', 4);
  configurador.fSetPos('BAS_CODNFM', 5);
  configurador.fSetPos('HYD_CODEMB', 5);


  configurador.fSetVisivel('HYD_COLECA', True);
  configurador.fSetVisivel('HYD_PRODUT', True);
  configurador.fSetVisivel('HYD_C_O_R_', True);
  configurador.fSetVisivel('HYD_CORLON', True);
  configurador.fSetVisivel('HYD_BASE__', True);
  configurador.fSetVisivel('HYD_CODNFM', True);
  configurador.fSetVisivel('HYD_CODEMB', True);

  configurador.pAdicionarIndice('HYD_COLECA+HYD_PRODUT+HYD_CORLON', 'Coleção/Produto/Cor Nome Longo');


  configurador.pAdicionarCampoDescricao('HYD_COLECA');
  configurador.pAdicionarCampoDescricao('HYD_PRODUT');
  configurador.pAdicionarCampoDescricao('HYD_C_O_R_');
  configurador.pAdicionarCampoDescricao('HYD_CORLON');
  configurador.pAdicionarCampoDescricao('HYD_BASE__');
  configurador.pAdicionarCampoDescricao('HYD_CODEMB');
  configurador.pAdicionarCampoDescricao('HYD_CODNFM');
  configurador.pAdicionarCampoDescricao('HYD_MD5KEY');
  configurador.pAdicionarCampoDescricao('CADITE.ITE_CODITE');
  configurador.pAdicionarCampoDescricao('CADITE.ITE_DESITE');

end;

end.
