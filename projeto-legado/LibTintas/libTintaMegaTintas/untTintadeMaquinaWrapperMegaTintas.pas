{*****************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta MegaTintas *}
{**************************************************************************PH*}
unit untTintadeMaquinaWrapperMegaTintas;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperMegaTintas = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompMegaTintas,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperMegaTintas }

procedure TTintadeMaquinaWrapperMegaTintas.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  configurador.pAdicionarCampo('S.MEG_CODIGO', 'Código', 'LIKE');
  configurador.pAdicionarCampo('S.MEG_DESCRI', 'Descrição', 'LIKE');
  configurador.pAdicionarCampo('S.MEG_REFERE', 'Referência', 'LIKE');
  configurador.pAdicionarCampo('S.MEG_DTACAD', 'Data Cadastro', 'LIKE');
  configurador.pAdicionarCampo('S.MEG_CODUNI', 'Unidade', 'LIKE');
  configurador.pAdicionarCampo('S.MEG_BASE__', 'Código da Base', 'LIKE');
  configurador.pAdicionarCampo('S.MEG_PRODUT', 'Produto', 'LIKE');
  configurador.pAdicionarCampo('S.MEG_COLECA', 'Coleção', 'LIKE');
  configurador.pAdicionarCampo('I.ITE_CODITE', 'Código do Item', 'LIKE');
  configurador.pAdicionarCampo('I.ITE_DESITE', 'Descrição do Item', 'LIKE');
  Configurador.pAdicionarCampo('S.MEG_NOMCOR', 'Nome da Cor', 'LIKE');
  configurador.pAdicionarCampo('S.MEG_CODUNI', 'MEG_CODUNI', 'LIKE', False, False);
  configurador.pAdicionarCampo('S.MEG_MD5KEY', 'MEG_MD5KEY', 'LIKE', False, True);
  configurador.pAdicionarCampo('S.MEG_DESCRI', 'MEG_DESCRI', 'LIKE', False, False);
  Configurador.pAdicionarCampo('S.MEG_ACRMOB', 'SUV_ACRMOB', 'LIKE', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');


  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('MEG_FORM' + TStrUtils.fStrZero(intCont, 2), 'MEG_FORM' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('MEG_QTDC' + TStrUtils.fStrZero(intCont, 2), 'MEG_QTDC' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperMegaTintas.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  If TAutcomTintaFactory.Get.fGetConfTinta('MEG').fGetBoolean('USAFOR') Then
    Result := Result + '     AND S.MEG_QTDC01 > 0.0 ';

  Result := Result + ' AND UPPER(IFNULL(S.MEG_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperMegaTintas.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result :=
    '   MEG_CADMEG S                      ' +
    '   INNER JOIN MEG_CADBAS B           ' +
    '      ON S.MEG_BASE__ = B.BAS_CODBAS ' +
    '     AND S.MEG_CODUNI = B.BAS_CODUNI ' +
    '     AND S.MEG_PRODUT = B.BAS_PRODUT ' +
    '   INNER JOIN CADITE I               ';

  If TStrUtils.fEmptyStr(configurador.GetCodIte) Then
  Begin
    Result := Result + '     ON B.BAS_CODITE = I.ITE_CODITE ';
    Result := Result + '     AND I.ITE_ITEATI = "S"          ';
    Result := Result + '     INNER JOIN ITEGER ON         ';
    Result := Result + '       BAS_CODITE = ITEGER.ITE_CODITE AND    ';
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

function TTintadeMaquinaWrapperMegaTintas.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(S.MEG_ATIVAD, "S")) = "S" ';
end;

function TTintadeMaquinaWrapperMegaTintas.GetCampoAutoIncrem: String;
begin
  Result := 'S.AUTOINCREM';
end;

function TTintadeMaquinaWrapperMegaTintas.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompMegaTintas.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')), //TAutcomTintaFactory.Get.fCfgSis('TABPAD', varString)
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperMegaTintas.GetNomeTabela: String;
begin
  Result := 'MEG_CADMEG';
end;

procedure TTintadeMaquinaWrapperMegaTintas.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  configurador.fSetPos('S.MEG_CODIGO',0);
  configurador.fSetPos('S.MEG_DESCRI',1 );
  configurador.fSetPos('S.MEG_REFERE',2 );
  configurador.fSetPos('S.MEG_DTACAD',3 );
  configurador.fSetPos('S.MEG_COLECA',4 );
  configurador.fSetPos('S.MEG_PRODUT',5 );
  configurador.fSetPos('S.MEG_CODUNI',6 );
  Configurador.fSetPos('S.MEG_NOMCOR',7 );
  configurador.fSetPos('I.ITE_DESITE', 8);

  configurador.fSetVisivel('S.MEG_CODIGO',true);
  configurador.fSetVisivel('S.MEG_DESCRI',true);
  configurador.fSetVisivel('S.MEG_REFERE',true);
  configurador.fSetVisivel('S.MEG_DTACAD',true);
  configurador.fSetVisivel('S.MEG_COLECA',true);
  configurador.fSetVisivel('S.MEG_PRODUT',true);
  configurador.fSetVisivel('S.MEG_CODUNI',true);
  Configurador.fSetVisivel('S.MEG_NOMCOR',true);
  configurador.fSetVisivel('I.ITE_DESITE'  ,true);


  configurador.pAdicionarIndice('S.MEG_CODIGO', 'Código');
  configurador.pAdicionarIndice('S.MEG_DESCRI', 'Descrição');
  configurador.pAdicionarIndice('S.MEG_REFERE', 'Referência');
  configurador.pAdicionarIndice('S.MEG_DTACAD', 'Data Cadastro');
  configurador.pAdicionarIndice('S.MEG_COLECA', 'Coleção');
  configurador.pAdicionarIndice('S.MEG_PRODUT', 'Produto');
  configurador.pAdicionarIndice('S.MEG_CODUNI', 'Cód.Unidade');
  Configurador.pAdicionarIndice('S.MEG_NOMCOR', 'Nome da Cor');
  configurador.pAdicionarIndice('I.ITE_DESITE', 'Descrição do Item');



  configurador.pAdicionarCampoDescricao('S.MEG_CODIGO');
  configurador.pAdicionarCampoDescricao('S.MEG_DESCRI');
  configurador.pAdicionarCampoDescricao('S.MEG_REFERE');
  configurador.pAdicionarCampoDescricao('S.MEG_DTACAD');
  configurador.pAdicionarCampoDescricao('S.MEG_COLECA');
  configurador.pAdicionarCampoDescricao('S.MEG_PRODUT');
  configurador.pAdicionarCampoDescricao('S.MEG_CODUNI');
  Configurador.pAdicionarCampoDescricao('S.MEG_NOMCOR');
  configurador.pAdicionarCampoDescricao('I.ITE_DESITE');
end;

end.
