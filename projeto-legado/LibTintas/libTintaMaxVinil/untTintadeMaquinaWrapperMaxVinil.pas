{**************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta MaxVinil *}
{***********************************************************************************AC*}
unit untTintadeMaquinaWrapperMaxVinil;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperMaxVinil = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompMaxVinil,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperMaxVinil }

procedure TTintadeMaquinaWrapperMaxVinil.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  //Configurador MaxVinil
  Configurador.pAdicionarCampo('CADITE.ITE_DESITE', 'Descrição do Item' , 'LIKE');
  Configurador.pAdicionarCampo('MAX_CODIGO', 'Código', 'LIKE', False, True);
  Configurador.pAdicionarCampo('MAX_COLECA', 'Coleção', 'LIKE', False, True);
  Configurador.pAdicionarCampo('MAX_UNIDAD', 'Unidade', 'LIKE', False, True);
  Configurador.pAdicionarCampo('MAX_CODBAS', 'Base', 'LIKE', False, True);
  Configurador.pAdicionarCampo('MAX_NOMCOR', 'Nome Cor', 'LIKE', False, True);
  Configurador.pAdicionarCampo('MAX_PRODUT', 'Produto', 'LIKE', False, True);
  Configurador.pAdicionarCampo('MAX_OBSERV', 'Observação', 'LIKE', False, True);
  Configurador.pAdicionarCampo('MAX_EMBALA', 'Embalagem', 'LIKE');
  Configurador.pAdicionarCampo('CADITE.ITE_CODITE', 'Código do Item', 'LIKE', False, True);
  Configurador.pAdicionarCampo('CADITE.ITE_REFERE', 'Referência do Item', 'LIKE', False, True);
  Configurador.pAdicionarCampo('MAX_MD5KEY', 'MD5KEY', '=' , False, True);
  Configurador.pAdicionarCampo('MAX_DTACAD', 'Data Cadastro', 'LIKE', False, True);
  Configurador.pAdicionarCampo('MAX_ATIVO_', 'Ativar/Desativar', 'LIKE', False, False);
  Configurador.pAdicionarCampo('MAX_ACRMOB', 'MAX_ACRMOB', 'LIKE', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');


  //End;

  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('MAX_FORM' + TStrUtils.fStrZero(intCont, 2), 'MAX_FORM' + TStrUtils.fStrZero(intCont, 2),
      'MAXE', False, False);

    configurador.pAdicionarCampo('MAX_QTDC' + TStrUtils.fStrZero(intCont, 2), 'MAX_QTDC' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperMaxVinil.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  Result := Result + ' AND UPPER(IFNULL(MAX_ATIVO_, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperMaxVinil.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result := '';
  Result := Result + '  MAX_CADMAX ';
  Result := Result + '   INNER JOIN MAX_CADBAS ';
  Result := Result + '     ON MAX_CODBAS = BAS_CODBAS ';
  Result := Result + '       AND MAX_PRODUT = BAS_PRODUT ';
  Result := Result + '       AND MAX_UNIDAD = BAS_UNIDAD ';
  Result := Result + '       AND MAX_EMBALA = BAS_CONTEU ';
  Result := Result + '   INNER JOIN CADITE ON            ';
  Result := Result + '      CADITE.ITE_CODITE = BAS_CODITE      ';
  Result := Result + '     AND CADITE.ITE_ITEATI = "S"          ';
  Result := Result + '   INNER JOIN ITEGER ON         ';
  Result := Result + '      BAS_CODITE = ITEGER.ITE_CODITE AND    ';
  Result := Result + '      ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
end;

function TTintadeMaquinaWrapperMaxVinil.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(MAX_ATIVO_, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperMaxVinil.GetCampoAutoIncrem: String;
begin
  Result := 'MAX_CADMAX.AUTOINCREM';
end;

function TTintadeMaquinaWrapperMaxVinil.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompMaxVinil.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperMaxVinil.GetNomeTabela: String;
begin
  Result := 'MAX_CADMAX';
end;

procedure TTintadeMaquinaWrapperMaxVinil.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin

  Configurador.fSetPos('MAX_CODIGO', 1);
  Configurador.fSetPos('MAX_PRODUT', 2);
  Configurador.fSetPos('MAX_COLECA', 3);
  Configurador.fSetPos('MAX_UNIDAD', 4);
  Configurador.fSetPos('CADITE.ITE_CODITE', 5);

  Configurador.fSetVisivel('MAX_CODIGO', True);
  Configurador.fSetVisivel('MAX_PRODUT', False);
  Configurador.fSetVisivel('MAX_COLECA', False);
  Configurador.fSetVisivel('MAX_UNIDAD', False);
  Configurador.fSetVisivel('CADITE.ITE_CODITE', False);

  //Indices Configuração(Consultas)
  Configurador.pAdicionarIndice('MAX_CODIGO', 'Código');
  Configurador.pAdicionarIndice('MAX_PRODUT', 'Produto');
  Configurador.pAdicionarIndice('MAX_COLECA', 'Coleção');
  Configurador.pAdicionarIndice('MAX_UNIDAD', 'Unidade');
  Configurador.pAdicionarIndice('CADITE.ITE_CODITE', 'Código do Item');

  //End;
  Configurador.pAdicionarCampoDescricao('MAX_PRODUT');
  Configurador.pAdicionarCampoDescricao('MAX_COLECA');
  Configurador.pAdicionarCampoDescricao('MAX_CODIGO');
  Configurador.pAdicionarCampoDescricao('MAX_UNIDAD');
end;

end.
