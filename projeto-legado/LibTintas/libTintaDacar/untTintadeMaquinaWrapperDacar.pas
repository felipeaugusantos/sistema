{******************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta Dacar    *}
{***************************************************************************AC*}
unit untTintadeMaquinaWrapperDacar;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperDacar = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompDacar,
{$ENDIF
  }untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperDacar }

procedure TTintadeMaquinaWrapperDacar.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  configurador.pAdicionarCampo('D.DAC_DESCRI', 'Descricao', 'LIKE');
  configurador.pAdicionarCampo('D.DAC_REFERE', 'Referencia', 'LIKE');
  configurador.pAdicionarCampo('D.DAC_COLECA', 'Coleção', 'LIKE');
  configurador.pAdicionarCampo('D.DAC_CODCOR', 'Cód. Cor', 'LIKE');
  configurador.pAdicionarCampo('D.DAC_CODUNI', 'Unidade', 'LIKE');
  configurador.pAdicionarCampo('D.DAC_DTACAD', 'Data Cadastro', 'LIKE');
  configurador.pAdicionarCampo('D.DAC_CODITE', 'Cód. Item', 'LIKE', False, False);
  configurador.pAdicionarCampo('D.DAC_CODBAS', 'Base', 'LIKE');
  configurador.pAdicionarCampo('D.DAC_CODFML', 'Fórmula', 'LIKE');
  configurador.pAdicionarCampo('D.DAC_EMBALA', 'Embalagem', 'LIKE');
  configurador.pAdicionarCampo('D.DAC_PROCOD', 'Pro. Cod.', 'LIKE');
  configurador.pAdicionarCampo('I.ITE_DESITE', 'Descrição Item', 'LIKE');
  configurador.pAdicionarCampo('I.ITE_CODITE', 'Código do Item', 'LIKE');
  configurador.pAdicionarCampo('I.ITE_REFERE', 'Referência do Item', 'LIKE');
  configurador.pAdicionarCampo('D.DAC_MD5KEY', 'Md5', '=', False, True);
  configurador.pAdicionarCampo('D.DAC_NOMCOR', 'Nome Cor', 'LIKE');
  Configurador.pAdicionarCampo('D.DAC_ACRMOB', 'DAC_ACRMOB', 'LIKE', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');

  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('DAC_FORM' + TStrUtils.fStrZero(intCont, 2), 'DAC_FORM' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('DAC_QTDB' + TStrUtils.fStrZero(intCont, 2), 'DAC_QTDB' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperDacar.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  Result := Result + ' AND UPPER(IFNULL(DAC_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperDacar.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result :=
   '	DAC_CADDAC D                      ' +
   '	INNER JOIN DAC_UNIDAC U           ' +
   '	 ON D.DAC_CODUNI = U.DAC_UNIAUT   ' +
   '	INNER JOIN DAC_CADBAS B           ' +
   '	 ON D.DAC_CODFML = B.BAS_CODFML   ' +
   '	  AND B.BAS_UNIDAD = D.DAC_CODUNI ' +
   '	  AND B.BAS_BASE__ = D.DAC_CODBAS ' +
   '  INNER JOIN CADITE I               ' +
   '   ON B.BAS_CODITE = I.ITE_CODITE   ' +
   '     AND I.ITE_ITEATI = "S"         ' +
   '  INNER JOIN ITEGER ON            ' +
   '    B.BAS_CODITE = ITEGER.ITE_CODITE AND ' +
   '    ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '"  ';
end;

function TTintadeMaquinaWrapperDacar.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(DAC_ATIVAD,"S")) = "S" ';
end;

function TTintadeMaquinaWrapperDacar.GetCampoAutoIncrem: String;
begin
  Result := 'D.AUTOINCREM';
end;

function TTintadeMaquinaWrapperDacar.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompDacar.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperDacar.GetNomeTabela: String;
begin
  Result := 'DAC_CADDAC';
end;

procedure TTintadeMaquinaWrapperDacar.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  configurador.fSetPos('D.DAC_DESCRI', 0);
  configurador.fSetPos('D.DAC_REFERE', 1);
  configurador.fSetPos('D.DAC_COLECA', 2);
  configurador.fSetPos('D.DAC_CODCOR', 3);
  configurador.fSetPos('D.DAC_CODUNI', 4);
  configurador.fSetPos('I.ITE_CODITE', 5);
  configurador.fSetPos('I.ITE_DESITE', 6);
  configurador.fSetPos('D.DAC_DTACAD', 7);
  Configurador.fSetPos('D.DAC_NOMCOR', 8);

  configurador.fSetVisivel('D.DAC_DESCRI', True);
  configurador.fSetVisivel('D.DAC_REFERE', True);
  configurador.fSetVisivel('D.DAC_COLECA', True);
  configurador.fSetVisivel('D.DAC_CODCOR', True);
  configurador.fSetVisivel('D.DAC_CODUNI', True);
  configurador.fSetVisivel('I.ITE_CODITE', True);
  configurador.fSetVisivel('I.ITE_DESITE', True);
  configurador.fSetVisivel('D.DAC_DTACAD', True);
  configurador.fSetVisivel('D.DAC_NOMCOR', True);

  configurador.pAdicionarIndice('D.DAC_DESCRI+D.DAC_REFERE', 'Descricao/Referencia');
  configurador.pAdicionarIndice('D.DAC_COLECA+D.DAC_CODCOR', 'Coleção/Cód. Cor');
  configurador.pAdicionarIndice('D.DAC_NOMCOR', 'Nome Cor');
  configurador.pAdicionarIndice('D.DAC_REFERE', 'Referencia');
  configurador.pAdicionarIndice('I.ITE_DESITE', 'Descrição Item');
  configurador.pAdicionarIndice('D.DAC_DTACAD', 'Data Cadastro');

  configurador.pAdicionarCampoDescricao('D.DAC_DESCRI');
  configurador.pAdicionarCampoDescricao('D.DAC_NOMCOR');
  configurador.pAdicionarCampoDescricao('D.DAC_REFERE');
  configurador.pAdicionarCampoDescricao('D.DAC_CODUNI');
  configurador.pAdicionarCampoDescricao('D.DAC_DTACAD');
end;

end.
