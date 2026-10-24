{*****************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta Grafftex *}
{**************************************************************************PH*}
unit untTintadeMaquinaWrapperGrafftex;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperGrafftex = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompGrafftex,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperGrafftex }

procedure TTintadeMaquinaWrapperGrafftex.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  configurador.pAdicionarCampo('S.GRA_CODIGO', 'Código', 'LIKE');
  configurador.pAdicionarCampo('S.GRA_DESCRI', 'Descrição', 'LIKE');
  configurador.pAdicionarCampo('S.GRA_NOME__', 'Nome da Cor', 'LIKE');
  configurador.pAdicionarCampo('S.GRA_REFERE', 'Referência', 'LIKE');
  configurador.pAdicionarCampo('S.GRA_DTACAD', 'Data Cadastro', 'LIKE');
  configurador.pAdicionarCampo('S.GRA_CODUNI', 'Unidade', 'LIKE');
  configurador.pAdicionarCampo('S.GRA_BASE__', 'Código da Base', 'LIKE');
  configurador.pAdicionarCampo('S.GRA_PRODUT', 'Produto', 'LIKE');
  configurador.pAdicionarCampo('S.GRA_COLECA', 'Coleção', 'LIKE');
  configurador.pAdicionarCampo('I.ITE_CODITE', 'Código do Item', 'LIKE');
  configurador.pAdicionarCampo('I.ITE_DESITE', 'Descrição do Item', 'LIKE');
  configurador.pAdicionarCampo('S.GRA_CODUNI', 'GRA_CODUNI', 'LIKE', False, False);
  configurador.pAdicionarCampo('S.GRA_MD5KEY', 'GRA_MD5KEY', 'LIKE', False, True);
  configurador.pAdicionarCampo('S.GRA_DESCRI', 'GRA_DESCRI', 'LIKE', False, False);
  Configurador.pAdicionarCampo('S.GRA_ACRMOB', 'GRA_ACRMOB', 'LIKE', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');


  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('GRA_FORM' + TStrUtils.fStrZero(intCont, 2), 'GRA_FORM' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('GRA_QTDC' + TStrUtils.fStrZero(intCont, 2), 'GRA_QTDC' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperGrafftex.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  If TAutcomTintaFactory.Get.fGetConfTinta('GRA').fGetBoolean('USAFOR') Then
    Result := Result + '     AND S.GRA_QTDC01 > 0.0 ';

  Result := Result + ' AND UPPER(IFNULL(S.GRA_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperGrafftex.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result :=
    '   GRA_CADGRA S                      ' +
    '   INNER JOIN GRA_CADBAS B           ' +
    '      ON S.GRA_BASE__ = B.BAS_CODBAS ' +
    '     AND S.GRA_CODUNI = B.BAS_CODUNI ' +
    '     AND S.GRA_PRODUT = B.BAS_PRODUT ' +
    '   INNER JOIN CADITE I               ';

  If TStrUtils.fEmptyStr(configurador.GetCodIte) Then
  Begin
    Result := Result + '     ON B.BAS_CODITE = I.ITE_CODITE ';
    Result := Result + '     AND I.ITE_ITEATI = "S"          ';
    Result := Result + '     INNER JOIN ITEGER ON         ';
    Result := Result + '       B.BAS_CODITE = ITEGER.ITE_CODITE AND    ';
    Result := Result + '       ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
  End
  Else
  Begin
    Result := Result + '     ON ' + AnsiQuotedStr(configurador.GetCodIte, '"') + ' = I.ITE_CODITE ';
    Result := Result + '     AND I.ITE_ITEATI = "S"          ';
    Result := Result + '     INNER JOIN ITEGER ON         ';
    Result := Result + AnsiQuotedStr(configurador.GetCodIte, '"') + ' = ITEGER.ITE_CODITE AND ';
    Result := Result + '       ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
  End;
end;

function TTintadeMaquinaWrapperGrafftex.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(S.GRA_ATIVAD, "S")) = "S" ';
end;

function TTintadeMaquinaWrapperGrafftex.GetCampoAutoIncrem: String;
begin
  Result := 'S.AUTOINCREM';
end;

function TTintadeMaquinaWrapperGrafftex.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompGrafftex.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')), //TAutcomTintaFactory.Get.fCfgSis('TABPAD', varString)
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperGrafftex.GetNomeTabela: String;
begin
  Result := 'GRA_CADGRA';
end;

procedure TTintadeMaquinaWrapperGrafftex.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  configurador.fSetPos('S.GRA_CODIGO',0);
  configurador.fSetPos('S.GRA_DESCRI',1 );
  configurador.fSetPos('S.GRA_REFERE',2 );
  configurador.fSetPos('S.GRA_DTACAD',3 );
  configurador.fSetPos('S.GRA_COLECA',4 );
  configurador.fSetPos('S.GRA_PRODUT',5 );
  configurador.fSetPos('S.GRA_CODUNI',6 );
  configurador.fSetPos('I.ITE_DESITE'  ,7);
  configurador.fSetPos('S.GRA_NOME__',8);

  configurador.fSetVisivel('S.GRA_CODIGO',true);
  configurador.fSetVisivel('S.GRA_DESCRI',true);
  configurador.fSetVisivel('S.GRA_REFERE',true);
  configurador.fSetVisivel('S.GRA_DTACAD',true);
  configurador.fSetVisivel('S.GRA_COLECA',true);
  configurador.fSetVisivel('S.GRA_PRODUT',true);
  configurador.fSetVisivel('S.GRA_CODUNI',true);
  configurador.fSetVisivel('I.ITE_DESITE'  ,true);
  configurador.fSetVisivel('S.GRA_NOME__',true);


  configurador.pAdicionarIndice('S.GRA_CODIGO', 'Código');
  configurador.pAdicionarIndice('S.GRA_DESCRI', 'Descrição');
  configurador.pAdicionarIndice('S.GRA_REFERE', 'Referência');
  configurador.pAdicionarIndice('S.GRA_DTACAD', 'Data Cadastro');
  configurador.pAdicionarIndice('S.GRA_COLECA', 'Coleção');
  configurador.pAdicionarIndice('S.GRA_PRODUT', 'Produto');
  configurador.pAdicionarIndice('S.GRA_CODUNI', 'Cód.Unidade');
  configurador.pAdicionarIndice('I.ITE_DESITE'  , 'Descrição do Item');
  configurador.pAdicionarIndice('S.GRA_NOME__', 'Nome da Cor');



  configurador.pAdicionarCampoDescricao('S.GRA_CODIGO');
  configurador.pAdicionarCampoDescricao('S.GRA_DESCRI');
  configurador.pAdicionarCampoDescricao('S.GRA_REFERE');
  configurador.pAdicionarCampoDescricao('S.GRA_DTACAD');
  configurador.pAdicionarCampoDescricao('S.GRA_COLECA');
  configurador.pAdicionarCampoDescricao('S.GRA_PRODUT');
  configurador.pAdicionarCampoDescricao('S.GRA_CODUNI');
  configurador.pAdicionarCampoDescricao('I.ITE_DESITE');
  configurador.pAdicionarCampoDescricao('S.GRA_NOME__');
end;

end.
