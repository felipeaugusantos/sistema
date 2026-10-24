{*****************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta Killing *}
{**************************************************************************PH*}
unit untTintadeMaquinaWrapperKilling;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperKilling = class(TAbstractTintadeMaquinaWrapper)
  public
    procedure Configurar(const configurador: IConfiguradorConsulta); override;
    function GetCampoAutoIncrem: String; override;
    function fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String; override;
    procedure pRestaurarPadrao(const configurador: IConfiguradorConsulta); override;
    function fGetSelectFrom(const configurador: IConfiguradorConsulta): String; override;
    function GetNomeTabela: String; override;
    function GetConsultaComp(strTabPre: String): IConsultaComp; override;
    function fGetWhere: String; override;
    function fGetGroup: String; override;
  end;

implementation

uses
{$IFNDEF LINUX}
  untConsultaCompKilling,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperKilling }

procedure TTintadeMaquinaWrapperKilling.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  Configurador.pAdicionarCampo('S.KIL_CODCOR'   ,   'Código'              , 'LIKE');
  Configurador.pAdicionarCampo('S.KIL_NOMCOR'   ,   'Nome da Cor'         , 'LIKE');
  Configurador.pAdicionarCampo('S.KIL_DESCRI'   ,   'Descrição'           , 'LIKE');
  Configurador.pAdicionarCampo('S.KIL_REFERE'   ,   'Referência'          , 'LIKE');
  Configurador.pAdicionarCampo('S.KIL_CODBAS'   ,   'Código Base'         , 'LIKE');
  Configurador.pAdicionarCampo('S.KIL_CODUNI'   ,   'Embalagem'           , 'LIKE');
  Configurador.pAdicionarCampo('S.KIL_CODFML'   ,   'Fórmula'             , 'LIKE');
  Configurador.pAdicionarCampo('I.ITE_CODITE'   ,   'Código do Item'      , 'LIKE'    , False , True);
  Configurador.pAdicionarCampo('I.ITE_DESITE'   ,   'Descrição do Item'   , 'LIKE'    , False , True);
  Configurador.pAdicionarCampo('I.ITE_REFERE'   ,   'Referência do Item'  , 'LIKE'    , False , True);
  Configurador.pAdicionarCampo('S.KIL_MD5KEY'   ,   'MD5KEY'              , 'LIKE'    , False , True);
  Configurador.pAdicionarCampo('S.KIL_ACRMOB'   ,   'KIL_ACRMOB'          , 'LIKE'    , False , False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');

  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('S.KIL_FORM' + TStrUtils.fStrZero(intCont, 2), 'S.KIL_FORM' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('S.KIL_QTDB' + TStrUtils.fStrZero(intCont, 2), 'S.KIL_QTDB' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperKilling.fGetGroup: String;
begin
  Result := '';
end;

function TTintadeMaquinaWrapperKilling.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  If TAutcomTintaFactory.Get.fGetConfTinta('KIL').fGetBoolean('USAFOR') Then
    Result := Result + '     AND S.KIL_QTDB01 > 0.0 ';

  Result := Result + fGetGroup;
end;

function TTintadeMaquinaWrapperKilling.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result :=
    '   KILD_CADKIL S                                         ' +
    '   INNER JOIN KILD_CADBAS B                              ' +
    '      ON S.KIL_CODBAS = B.BAS_CODBAS                     ' +
    '     AND S.KIL_CODUNI = B.BAS_CODUNI                     ' +
    '     AND S.KIL_CODFML = B.BAS_CODFML                     ' +
    '   INNER JOIN CADITE I ON B.BAS_CODITE = I.ITE_CODITE    ' +
    '     AND I.ITE_ITEATI = "S"                              ' +
    '   INNER JOIN ITEGER ON B.BAS_CODITE = ITEGER.ITE_CODITE AND ' +
    '   ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
 end;

function TTintadeMaquinaWrapperKilling.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(S.KIL_ATIVAD, "S")) = "S" ';
end;

function TTintadeMaquinaWrapperKilling.GetCampoAutoIncrem: String;
begin
  Result := 'S.AUTOINCREM';
end;

function TTintadeMaquinaWrapperKilling.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompKilling.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')), //TAutcomTintaFactory.Get.fCfgSis('TABPAD', varString)
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperKilling.GetNomeTabela: String;
begin
  Result := 'KILD_CADKIL';
end;


procedure TTintadeMaquinaWrapperKilling.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin

  Configurador.fSetPos('S.KIL_CODCOR' , 1);
  Configurador.fSetPos('S.KIL_DESCRI' , 2);
  Configurador.fSetPos('S.KIL_REFERE' , 3);
  Configurador.fSetPos('S.KIL_CODBAS' , 4);
  Configurador.fSetPos('S.KIL_CODUNI' , 5);
  Configurador.fSetPos('S.KIL_CODFML' , 6);
  Configurador.fSetPos('S.KIL_NOMCOR' , 7);

  Configurador.fSetVisivel('S.KIL_CODCOR' , True);
  Configurador.fSetVisivel('S.KIL_DESCRI' , True);
  Configurador.fSetVisivel('S.KIL_REFERE' , True);
  Configurador.fSetVisivel('S.KIL_CODBAS' , True);
  Configurador.fSetVisivel('S.KIL_CODUNI' , True);
  Configurador.fSetVisivel('S.KIL_CODFML' , True);
  Configurador.fSetVisivel('S.KIL_NOMCOR' , True);

  Configurador.pAdicionarIndice('S.KIL_CODCOR+S.KIL_DESCRI+S.KIL_REFERE', 'Código/Descrição/Referência');

  Configurador.pAdicionarCampoDescricao('S.KIL_CODCOR');
  Configurador.pAdicionarCampoDescricao('S.KIL_DESCRI');
  Configurador.pAdicionarCampoDescricao('S.KIL_REFERE');
  Configurador.pAdicionarCampoDescricao('S.KIL_CODBAS');
  Configurador.pAdicionarCampoDescricao('S.KIL_CODUNI');
  Configurador.pAdicionarCampoDescricao('S.KIL_CODFML');
  Configurador.pAdicionarCampoDescricao('S.KIL_NOMCOR');
end;

end.
