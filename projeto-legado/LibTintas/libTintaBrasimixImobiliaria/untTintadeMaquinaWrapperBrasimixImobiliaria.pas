{*****************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta BrasimixImobiliaria *}
{**************************************************************************************PH*}
unit untTintadeMaquinaWrapperBrasimixImobiliaria;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperBrasimixImobiliaria = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompBrasimixImobiliaria,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperBrasimixImobiliaria }

procedure TTintadeMaquinaWrapperBrasimixImobiliaria.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  configurador.pAdicionarCampo('BZI_DESCRI', 'Descrição', 'LIKE');
  configurador.pAdicionarCampo('BZI_REFERE', 'Referência', 'LIKE');
  configurador.pAdicionarCampo('BZI_CODIGO', 'Código', 'LIKE');
  configurador.pAdicionarCampo('BZI_UNIDAD', 'Unidade', 'LIKE');
  configurador.pAdicionarCampo('BZI_LINHA_', 'Linha', 'LIKE');
  configurador.pAdicionarCampo('BZI_CODBAS', 'Código da Base', 'LIKE');
  configurador.pAdicionarCampo('BZI_EMBALA', 'Volume', 'LIKE');
  configurador.pAdicionarCampo('CADITE.ITE_CODITE', 'Código do Item', 'LIKE');
  configurador.pAdicionarCampo('CADITE.ITE_DESITE', 'Descrição do Item', 'LIKE');
  configurador.pAdicionarCampo('CADITE.ITE_REFERE', 'Referência do Item', 'LIKE');
  configurador.pAdicionarCampo('BZI_DTACAD', 'Data de Cadastro', '=');
  configurador.pAdicionarCampo('BZI_CODUNI', 'Código da Unidade', 'LIKE', False, False);
  configurador.pAdicionarCampo('BZI_GRUPRO', 'Grupo do Produto', 'LIKE');
  configurador.pAdicionarCampo('BZI_MD5KEY', 'MD5KEY', '=', False, True);
  Configurador.pAdicionarCampo('BZI_ACRMOB', 'BZI_ACRMOB', 'LIKE', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');


  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('BZI_CODC' + TStrUtils.fStrZero(intCont, 2), 'BZI_CODC' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('BZI_QTDC' + TStrUtils.fStrZero(intCont, 2), 'BZI_QTDC' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperBrasimixImobiliaria.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  Result := Result + ' AND UPPER(IFNULL(BZI_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperBrasimixImobiliaria.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result :=
   '  BZI_CADBZI                                        ' +
   '   INNER JOIN BZI_CADBAS ON BAS_BASE__ = BZI_CODBAS ' +
   '                        AND BAS_LINHA_ = BZI_LINHA_ ' +
   '                        AND BAS_UNIDAD = BZI_CODUNI ' +
   '                        AND BAS_DESCRI = BZI_DESCRI ' +
   '                        AND BAS_EMBALA = BZI_EMBALA ' +
   '   INNER JOIN CADITE ON CADITE.ITE_CODITE = BAS_CODITE     ' +
   '     AND CADITE.ITE_ITEATI = "S"                    ' +
   '   INNER JOIN ITEGER ON BAS_CODITE = ITEGER.ITE_CODITE AND ' +
   '   ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
end;

function TTintadeMaquinaWrapperBrasimixImobiliaria.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(BZI_ATIVAD,"S")) = "S" ';
end;

function TTintadeMaquinaWrapperBrasimixImobiliaria.GetCampoAutoIncrem: String;
begin
  Result := 'BZI_CADBZI.AUTOINCREM';
end;

function TTintadeMaquinaWrapperBrasimixImobiliaria.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompBrasimixImobiliaria.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperBrasimixImobiliaria.GetNomeTabela: String;
begin
  Result := 'BZI_CADBZI';
end;

procedure TTintadeMaquinaWrapperBrasimixImobiliaria.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  configurador.fSetPos('BZI_DESCRI', 0);
  configurador.fSetPos('BZI_REFERE', 1);
  configurador.fSetPos('BZI_CODIGO', 2);
  configurador.fSetPos('BZI_UNIDAD', 3);
  configurador.fSetPos('BZI_LINHA_', 4);
  configurador.fSetPos('BZI_CODBAS', 5);
  configurador.fSetPos('CADITE.ITE_CODITE', 6);
  configurador.fSetPos('CADITE.ITE_DESITE', 7);
  configurador.fSetPos('BZI_GRUPRO', 8);
  configurador.fSetPos('BZI_DTACAD', 9);

  configurador.fSetVisivel('BZI_DESCRI', True);
  configurador.fSetVisivel('BZI_REFERE', True);
  configurador.fSetVisivel('BZI_CODIGO', True);
  configurador.fSetVisivel('BZI_UNIDAD', True);
  configurador.fSetVisivel('BZI_LINHA_', True);
  configurador.fSetVisivel('BZI_CODBAS', True);
  configurador.fSetVisivel('CADITE.ITE_CODITE', True);
  configurador.fSetVisivel('CADITE.ITE_DESITE', True);
  configurador.fSetVisivel('BZI_GRUPRO', True);
  configurador.fSetVisivel('BZI_DTACAD', True);

  configurador.pAdicionarIndice('BZI_DESCRI+BZI_REFERE', 'Descrição/Referência');
  configurador.pAdicionarIndice('BZI_REFERE', 'Referência');
  configurador.pAdicionarIndice('BZI_CODIGO', 'Código');

  configurador.pAdicionarCampoDescricao('BZI_DESCRI');
  configurador.pAdicionarCampoDescricao('BZI_REFERE');
  configurador.pAdicionarCampoDescricao('BZI_CODIGO');
  configurador.pAdicionarCampoDescricao('BZI_UNIDAD');
  configurador.pAdicionarCampoDescricao('BZI_LINHA_');
  configurador.pAdicionarCampoDescricao('BZI_CODBAS');
  configurador.pAdicionarCampoDescricao('CADITE.ITE_CODITE');
  configurador.pAdicionarCampoDescricao('CADITE.ITE_DESITE');
  configurador.pAdicionarCampoDescricao('BZI_DTACAD');
end;

end.
