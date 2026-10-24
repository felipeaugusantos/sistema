{*****************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta Velutex Imobiliaria *}
{**************************************************************************************PH*}
unit untTintadeMaquinaWrapperVelutexImobiliaria;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperVelutexImobiliaria = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompVelutexImobiliaria,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperVelutexImobiliaria }

procedure TTintadeMaquinaWrapperVelutexImobiliaria.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  configurador.pAdicionarCampo('VEL_CORCOD', 'Cód. da Cor', 'LIKE', False, True);
  configurador.pAdicionarCampo('VEL_CODNOM', 'Cód. Nome', 'LIKE', False, True);
  configurador.pAdicionarCampo('VEL_CODBAS', 'Cód. da Base', 'LIKE', False, True);
  configurador.pAdicionarCampo('VEL_COLECA', 'Coleção', 'LIKE', False, True);
  configurador.pAdicionarCampo('VEL_PRODUT', 'Produto', 'LIKE', False, True);
  configurador.pAdicionarCampo('VEL_CODUNI', 'Unidade', 'LIKE', False, True);
  configurador.pAdicionarCampo('VEL_DTACAD', 'Data Cadastro', 'LIKE', False, True);
  configurador.pAdicionarCampo('VEL_CODNFM', 'Cód. Novas Formulas', 'LIKE', False, False);
  configurador.pAdicionarCampo('BAS_CODITE', 'Cód. Item', 'LIKE', False, True);
  configurador.pAdicionarCampo('CADITE.ITE_CODITE', 'Codigo do Item', 'LIKE', False, True);
  configurador.pAdicionarCampo('CADITE.ITE_DESITE', 'Descrição do Item', 'LIKE', False, True);
  configurador.pAdicionarCampo('CADITE.ITE_REFERE', 'Referência do Item', 'LIKE', False, True);
  configurador.pAdicionarCampo('VEL_MD5KEY', 'MD5KEY','=', False, True);
  Configurador.pAdicionarCampo('VEL_ACRMOB', 'VEL_ACRMOB', 'LIKE', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');


  For intCont := 1 To 6 Do
  Begin
    configurador.pAdicionarCampo('VEL_CODC' + TstrUtils.fStrZero(intCont, 2), 'VEL_CODC' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('VEL_QTDC' + TstrUtils.fStrZero(intCont, 2), 'VEL_QTDC' + TstrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperVelutexImobiliaria.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  Result := Result + ' AND UPPER(IFNULL(VEL_ATIVAD, ''S'')) = ''S'' ';

end;

function TTintadeMaquinaWrapperVelutexImobiliaria.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result :=
     '  	VEL_CADVEL  ' +
     '     	INNER JOIN VEL_CADBAS ON VEL_PRODUT = BAS_PRODUT ' +
     '  		                     AND VEL_CODBAS = BAS_CODBAS ' +
     '                           AND VEL_CODUNI = BAS_CODUNI ' +
     '  	  INNER JOIN CADITE ON CADITE.ITE_CODITE = BAS_CODITE   ' +
     '     AND CADITE.ITE_ITEATI = "S"                       ' +
     '      INNER JOIN ITEGER ON BAS_CODITE = ITEGER.ITE_CODITE AND  ' +
     '      ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
end;

function TTintadeMaquinaWrapperVelutexImobiliaria.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + ' AND VEL_ATIVAD = ''S'' ';
end;

function TTintadeMaquinaWrapperVelutexImobiliaria.GetCampoAutoIncrem: String;
begin
  Result := 'VEL_CADVEL.AUTOINCREM';
end;

function TTintadeMaquinaWrapperVelutexImobiliaria.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompVelutexImobiliaria.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperVelutexImobiliaria.GetNomeTabela: String;
begin
  Result := 'VEL_CADVEL';
end;

procedure TTintadeMaquinaWrapperVelutexImobiliaria.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  configurador.fSetPos('VEL_CORCOD', 0);
  configurador.fSetPos('VEL_CODNOM', 1);
  configurador.fSetPos('VEL_PRODUT', 2);
  configurador.fSetPos('VEL_CODUNI', 3);
  configurador.fSetPos('BAS_CODITE', 4);
  configurador.fSetPos('VEL_CODBAS', 5);
  configurador.fSetPos('CADITE.ITE_DESITE', 6);
  configurador.fSetPos('VEL_DTACAD', 7);

  configurador.fSetVisivel('VEL_CORCOD', True);
  configurador.fSetVisivel('VEL_CODNOM', True);
  configurador.fSetVisivel('VEL_PRODUT', True);
  configurador.fSetVisivel('VEL_CODUNI', True);
  configurador.fSetVisivel('BAS_CODITE', True);
  configurador.fSetVisivel('VEL_CODBAS', True);
  configurador.fSetVisivel('CADITE.ITE_DESITE', True);
  configurador.fSetVisivel('VEL_DTACAD', True);

  //indices
  configurador.pAdicionarIndice('VEL_CORCOD', 'Cód. da Cor');
  configurador.pAdicionarIndice('VEL_CODNOM', 'Cód. Nome');
  configurador.pAdicionarIndice('VEL_PRODUT', 'Produto');
  configurador.pAdicionarIndice('VEL_CODUNI', 'Unidade');
  configurador.pAdicionarIndice('BAS_CODITE', 'Cód. Item');
  configurador.pAdicionarIndice('VEL_CODBAS', 'Cód. Base');
  configurador.pAdicionarIndice('CADITE.ITE_DESITE', 'Descrição do Item');
  configurador.pAdicionarIndice('VEL_DTACAD', 'Data Cadastro');

  configurador.pAdicionarCampoDescricao('VEL_CORCOD');
  configurador.pAdicionarCampoDescricao('VEL_CODNOM');
  configurador.pAdicionarCampoDescricao('VEL_PRODUT');
  configurador.pAdicionarCampoDescricao('VEL_CODUNI');
  configurador.pAdicionarCampoDescricao('BAS_CODITE');
  configurador.pAdicionarCampoDescricao('VEL_CODBAS');
  configurador.pAdicionarCampoDescricao('CADITE.ITE_DESITE');
  configurador.pAdicionarCampoDescricao('VEL_DTACAD');

end;

end.
