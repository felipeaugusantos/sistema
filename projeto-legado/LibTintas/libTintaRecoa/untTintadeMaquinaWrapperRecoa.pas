{**************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta Recoa *}
{***********************************************************************************AC*}
unit untTintadeMaquinaWrapperRecoa;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperRecoa = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompRecoa,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperRecoa }

procedure TTintadeMaquinaWrapperRecoa.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  //Configurador Recoa
  configurador.pAdicionarCampo('REC_DESCRI' , 'Descrição da Base' , 'LIKE');
  configurador.pAdicionarCampo('REC_UNIDAD' , 'Unidade'           , 'LIKE');
  configurador.pAdicionarCampo('REC_CODIGO' , 'Código'            , 'LIKE');
  configurador.pAdicionarCampo('CADITE.ITE_CODITE' , 'Código do Item'    , 'LIKE');
  configurador.pAdicionarCampo('CADITE.ITE_DESITE' , 'Descrição do Item' , 'LIKE');
  configurador.pAdicionarCampo('REC_CODEMB' , 'Embalagem'         , 'LIKE' , False , True);
  configurador.pAdicionarCampo('REC_DESCRI' , 'Produto'           , 'LIKE' , False , True);
  configurador.pAdicionarCampo('REC_CODBAS' , 'Base'              , 'LIKE' , False , True);
  configurador.pAdicionarCampo('REC_MD5KEY' , 'MD5KEY'            , '='    , False , True);
  Configurador.pAdicionarCampo('REC_ACRMOB' , 'REC_ACRMOB'        , 'LIKE' , False , False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');


  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('REC_FORM' + TStrUtils.fStrZero(intCont, 2), 'REC_FORM' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('REC_QTDC' + TStrUtils.fStrZero(intCont, 2), 'REC_QTDC' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperRecoa.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  Result := Result + ' AND UPPER(IFNULL(REC_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperRecoa.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result := '';
  Result := Result + '  REC_CADREC ';
  Result := Result + '   INNER JOIN REC_CADBAS ';
  Result := Result + '     ON REC_CODBAS = BAS_BASE__ ';
 // Result := Result + '       AND REC_DESCRI = BAS_DESCRI ';
  Result := Result + '       AND REC_UNIDAD = BAS_UNIDAD ';
  Result := Result + '  	  INNER JOIN CADITE ON CADITE.ITE_CODITE = BAS_CODITE     ';
  Result := Result + '     AND CADITE.ITE_ITEATI = "S"          ';
  Result := Result + '     INNER JOIN ITEGER ON         ';
  Result := Result + '       BAS_CODITE = ITEGER.ITE_CODITE AND    ';
  Result := Result + '       ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
end;

function TTintadeMaquinaWrapperRecoa.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(REC_ATIVAD,"S")) = "S" ';
end;

function TTintadeMaquinaWrapperRecoa.GetCampoAutoIncrem: String;
begin
  Result := 'REC_CADREC.AUTOINCREM';
end;

function TTintadeMaquinaWrapperRecoa.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompRecoa.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')), //TAutcomTintaFactory.Get.fCfgSis('TABPAD', varString)
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperRecoa.GetNomeTabela: String;
begin
  Result := 'REC_CADREC';
end;

procedure TTintadeMaquinaWrapperRecoa.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin

  configurador.fSetPos('REC_DESCRI', 0);
  configurador.fSetPos('REC_UNIDAD', 1);
  configurador.fSetPos('REC_CODIGO', 2);
  configurador.fSetPos('CADITE.ITE_CODITE', 3);
  configurador.fSetPos('CADITE.ITE_DESITE', 4);

  configurador.fSetVisivel('REC_DESCRI' , True);
  configurador.fSetVisivel('REC_UNIDAD' , True);
  configurador.fSetVisivel('REC_CODIGO' , True);
  configurador.fSetVisivel('CADITE.ITE_CODITE' , True);
  configurador.fSetVisivel('CADITE.ITE_DESITE' , True);

  configurador.pAdicionarIndice('REC_DESCRI+REC_UNIDAD' , 'Descrição da Base/Unidade');
  configurador.pAdicionarIndice('REC_UNIDAD'  , 'Unidade');
  configurador.pAdicionarIndice('REC_CODIGO'  , 'Código');
  configurador.pAdicionarIndice('CADITE.ITE_CODITE'  , 'Código do Item');
  configurador.pAdicionarIndice('CADITE.ITE_DESITE'  , 'Descrição do Item');

  configurador.pAdicionarCampoDescricao('REC_UNIDAD');
end;

end.
