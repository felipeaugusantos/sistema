{**************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta CoralImobiliaria *}
{***********************************************************************************AC*}
unit untTintadeMaquinaWrapperCoralImobiliaria;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperCoralImobiliaria = class(TAbstractTintadeMaquinaWrapper)
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
 {$IFDEF LINUX}
 {$ELSE}
  untConsultaCompCoralImobiliaria,
 {$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperCoralImobiliaria }

procedure TTintadeMaquinaWrapperCoralImobiliaria.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  configurador.pAdicionarCampo('COR_DESCRI', 'Descrição', 'LIKE');
  configurador.pAdicionarCampo('COR_DTACAD', 'Data Cadastro', 'LIKE');
  configurador.pAdicionarCampo('COR_CODIGO', 'Código', 'LIKE');
  configurador.pAdicionarCampo('COR_UNIDAD', 'Unidade', 'LIKE');
  configurador.pAdicionarCampo('COR_COLID2', 'Color ID2', 'LIKE');
  configurador.pAdicionarCampo('COR_DESPRO', 'Produto', 'LIKE');
  configurador.pAdicionarCampo('COR_CODBAS', 'Base', 'LIKE');
  configurador.pAdicionarCampo('COR_COLECA', 'Coleção', 'LIKE');
  configurador.pAdicionarCampo('COR_UNIVER', 'Código Universal', 'LIKE');
  configurador.pAdicionarCampo('CADITE.ITE_CODITE', 'Código do Item', 'LIKE');
  configurador.pAdicionarCampo('CADITE.ITE_DESITE', 'Descrição do Item', 'LIKE');
  configurador.pAdicionarCampo('CADITE.ITE_REFERE', 'Referência do Item', 'LIKE');
  configurador.pAdicionarCampo('COR_CODUNI', 'Unidade', 'LIKE', False, False);
  configurador.pAdicionarCampo('COR_CODEMB', 'Embalagem', 'LIKE');
  configurador.pAdicionarCampo('COR_COLID1', 'Color ID', 'LIKE');
  configurador.pAdicionarCampo('COR_MD5KEY', 'MD5KEY', '=', False, True);
  Configurador.pAdicionarCampo('COR_OBSERV', 'Observação', 'LIKE');
  Configurador.pAdicionarCampo('COR_ACRMOB', 'COR_ACRMOB', 'LIKE', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');
  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('COR_FORM' + TStrUtils.fStrZero(intCont, 2), 'COR_FORM' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('COR_QTDC' + TStrUtils.fStrZero(intCont, 2), 'COR_QTDC' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperCoralImobiliaria.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  If TAutcomTintaFactory.Get.fGetConfTinta('CIM').fGetBoolean('USAFOR') Then
    Result := Result + '     AND COR_QTDC01 > 0.0 ';

  Result := Result + ' AND UPPER(IFNULL(COR_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperCoralImobiliaria.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result := '';
  Result := Result + '  CORIMO_CADCOR ';
  Result := Result + '   INNER JOIN CORIMO_CADBAS ';
  Result := Result + '     ON COR_CODBAS = BAS_BASE__ ';
  Result := Result + '       AND COR_DESPRO = BAS_DESCRI ';
  Result := Result + '       AND COR_CODUNI = BAS_UNIDAD ';
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

function TTintadeMaquinaWrapperCoralImobiliaria.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(COR_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperCoralImobiliaria.GetCampoAutoIncrem: String;
begin
  Result := 'CORIMO_CADCOR.AUTOINCREM';
end;

function TTintadeMaquinaWrapperCoralImobiliaria.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompCoralImobiliaria.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')), //TAutcomTintaFactory.Get.fCfgSis('TABPAD', varString)
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperCoralImobiliaria.GetNomeTabela: String;
begin
  Result := 'CORIMO_CADCOR';
end;

procedure TTintadeMaquinaWrapperCoralImobiliaria.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  configurador.fSetPos('COR_DESCRI', 0);
  configurador.fSetPos('COR_UNIDAD', 1);
  configurador.fSetPos('COR_CODIGO', 2);
  configurador.fSetPos('COR_COLID2', 3);
  configurador.fSetPos('COR_UNIVER', 4);
  configurador.fSetPos('BAS_CODITE', 5);
  configurador.fSetPos('CADITE.ITE_DESITE', 6);
  configurador.fSetPos('COR_DTACAD', 7);
  Configurador.fSetPos('COR_OBSERV', 8);

  configurador.fSetVisivel('COR_DESCRI', True);
  configurador.fSetVisivel('COR_UNIDAD', True);
  configurador.fSetVisivel('COR_CODIGO', True);
  configurador.fSetVisivel('COR_COLID2', True);
  configurador.fSetVisivel('COR_UNIVER', True);
  configurador.fSetVisivel('BAS_CODITE', True);
  configurador.fSetVisivel('CADITE.ITE_DESITE', True);
  configurador.fSetVisivel('COD_DTACAD', True);
  Configurador.fSetVisivel('COD_OBSERV', True);

  configurador.pAdicionarIndice('COR_DESCRI+COR_UNIDAD', 'Descrição/Unidade');
  configurador.pAdicionarIndice('COR_UNIDAD', 'Unidade');
  configurador.pAdicionarIndice('COR_CODIGO+COR_COLID2', 'Código/Color ID2');
  configurador.pAdicionarIndice('COR_UNIVER', 'Código Universal');
  configurador.pAdicionarIndice('COR_DTACAD', 'Data Cadastro');
  Configurador.pAdicionarIndice('COR_OBSERV', 'Observação');

  configurador.pAdicionarCampoDescricao('COR_UNIVER');
  configurador.pAdicionarCampoDescricao('COR_UNIDAD');
end;

end.

