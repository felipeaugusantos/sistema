{**************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta RennerImobiliaria *}
{***********************************************************************************AC*}
unit untTintadeMaquinaWrapperRennerImobiliaria;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperRennerImobiliaria = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompRennerImobiliaria,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperRennerImobiliaria }

procedure TTintadeMaquinaWrapperRennerImobiliaria.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  configurador.pAdicionarCampo('REI_CODPRO', 'Código do Produto', 'LIKE');
  configurador.pAdicionarCampo('REI_DESCOR', 'Descrição da Cor', 'LIKE');
  configurador.pAdicionarCampo('REI_REFERE', 'Referência', 'LIKE');
  configurador.pAdicionarCampo('REI_CODBAS', 'Código da Base', 'LIKE');
  configurador.pAdicionarCampo('REI_DESCRI', 'Descrição da Base', 'LIKE');
  configurador.pAdicionarCampo('REI_UNIDAD', 'Unidade', 'LIKE');
  configurador.pAdicionarCampo('REI_DTACAD', 'Data de Cadastro', 'DATE');
  configurador.pAdicionarCampo('REI_OBSCOR', 'Observação da Cor', 'LIKE');
  configurador.pAdicionarCampo('CADITE.ITE_CODITE', 'Código do Item', 'LIKE');
  configurador.pAdicionarCampo('CADITE.ITE_DESITE', 'Descrição do Item', 'LIKE');
  configurador.pAdicionarCampo('CADITE.ITE_REFERE', 'Referência do Item', 'LIKE');
  configurador.pAdicionarCampo('REI_INGLES', 'Color Describe','LIKE');
  configurador.pAdicionarCampo('REI_ESPANH', 'Descripción Color','LIKE');
  configurador.pAdicionarCampo('REI_MD5KEY', 'MD5KEY', '=', False, True);
  Configurador.pAdicionarCampo('REI_ACRMOB', 'REI_ACRMOB', 'LIKE', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');

  for intCont := 1 to 20 do
  begin
    configurador.pAdicionarCampo('REI_FORM' + TStrUtils.fStrZero(intCont, 2),  'REI_FORM' + TStrUtils.fStrZero(intCont, 2),
          'LIKE', False, False);

    configurador.pAdicionarCampo('REI_QTDC' + TStrUtils.fStrZero(intCont, 2),  'REI_QTDC' + TStrUtils.fStrZero(intCont, 2),
          '=', False, False);
  end;
end;

function TTintadeMaquinaWrapperRennerImobiliaria.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  If TAutcomTintaFactory.Get.fGetConfTinta('REI').fGetBoolean('USAFOR') Then
    Result := Result + '     AND REI_QTDC01 > 0.0 ';

  Result := Result + ' AND UPPER(IFNULL(REI_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperRennerImobiliaria.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result := '';
  Result := Result + ' REI_CADREI ';
  Result := Result + '  INNER JOIN REI_CADBAS ';
  Result := Result + '    ON BAS_CODBAS = REI_CODBAS ';
  Result := Result + '      AND REI_UNIDAD = BAS_UNIDAD  ';
  Result := Result + '  INNER JOIN CADITE ';


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

function TTintadeMaquinaWrapperRennerImobiliaria.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(REI_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperRennerImobiliaria.GetCampoAutoIncrem: String;
begin
  Result := 'REI_CADREI.AUTOINCREM';
end;

function TTintadeMaquinaWrapperRennerImobiliaria.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompRennerImobiliaria.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')), //TAutcomTintaFactory.Get.fCfgSis('TABPAD', varString)
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperRennerImobiliaria.GetNomeTabela: String;
begin
  Result := 'REI_CADREI';
end;

procedure TTintadeMaquinaWrapperRennerImobiliaria.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  configurador.fSetPos('REI_CODPRO', 0);
  configurador.fSetPos('REI_DESCOR', 1);
  configurador.fSetPos('REI_REFERE', 2);
  configurador.fSetPos('REI_CODBAS', 3);
  configurador.fSetPos('REI_DESCRI', 4);
  configurador.fSetPos('REI_UNIDAD', 5);
  configurador.fSetPos('REI_DTACAD', 6);
  configurador.fSetPos('REI_INGLES', 7);
  configurador.fSetPos('REI_ESPANH', 8);

  configurador.fSetVisivel('REI_CODPRO', True);
  configurador.fSetVisivel('REI_DESCOR', True);
  configurador.fSetVisivel('REI_REFERE', True);
  configurador.fSetVisivel('REI_CODBAS', True);
  configurador.fSetVisivel('REI_DESCRI', True);
  configurador.fSetVisivel('REI_UNIDAD', True);
  configurador.fSetVisivel('REI_DTACAD', True);
  configurador.fSetVisivel('REI_INGLES', True);
  configurador.fSetVisivel('REI_ESPANH', True);

  configurador.pAdicionarIndice('REI_CODPRO+REI_DESCOR+REI_REFERE', 'Código do Produto/Descrição da Cor/Referência');
  configurador.pAdicionarIndice('REI_CODBAS+REI_DESCRI', 'Código da Base/Descrição da Base');

  configurador.pAdicionarCampoDescricao('REI_CODPRO');
  configurador.pAdicionarCampoDescricao('REI_DESCOR');
  configurador.pAdicionarCampoDescricao('REI_REFERE');
  configurador.pAdicionarCampoDescricao('REI_CODBAS');
  configurador.pAdicionarCampoDescricao('REI_DESCRI');
  configurador.pAdicionarCampoDescricao('REI_UNIDAD');
  configurador.pAdicionarCampoDescricao('REI_DTACAD');
  configurador.pAdicionarCampoDescricao('REI_INGLES');
  configurador.pAdicionarCampoDescricao('REI_ESPANH');
end;

end.
