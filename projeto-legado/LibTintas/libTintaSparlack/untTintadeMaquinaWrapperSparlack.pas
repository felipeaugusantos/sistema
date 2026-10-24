{*****************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta Sparlack *}
{**************************************************************************PH*}
unit untTintadeMaquinaWrapperSparlack;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperSparlack = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompSparlack,
{$ENDIF}
   untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperSparlack }

procedure TTintadeMaquinaWrapperSparlack.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  configurador.pAdicionarCampo('S.SPA_CODSPA', 'Código',            'LIKE');
  configurador.pAdicionarCampo('S.SPA_DESCRI', 'Descrição',         'LIKE');
  configurador.pAdicionarCampo('S.SPA_PRODUT', 'Produto',           'LIKE');
  configurador.pAdicionarCampo('S.SPA_REFERE', 'Referência',        'LIKE');
  configurador.pAdicionarCampo('S.SPA_CODUNI', 'Unidade',           'LIKE');
  configurador.pAdicionarCampo('S.SPA_CODBAS', 'Código da Base',    'LIKE');
  configurador.pAdicionarCampo('S.SPA_DTACAD', 'Data Cadastro',     'LIKE');
  configurador.pAdicionarCampo('I.ITE_CODITE',   'Código do Item',    'LIKE');
  configurador.pAdicionarCampo('I.ITE_DESITE',   'Descrição do Item', 'LIKE');
  configurador.pAdicionarCampo('S.SPA_MD5KEY', 'SPA_MD5KEY',        'LIKE', False, True);
  Configurador.pAdicionarCampo('S.SPA_ACRMOB', 'SPA_ACRMOB',        'LIKE', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');



  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('SPA_CODC' + TStrUtils.fStrZero(intCont, 2), 'SPA_CODC' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('SPA_QTDC' + TStrUtils.fStrZero(intCont, 2), 'SPA_QTDC' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperSparlack.fGetGroup: String;
begin
  Result := '';
end;

function TTintadeMaquinaWrapperSparlack.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  If TAutcomTintaFactory.Get.fGetConfTinta('SPA').fGetBoolean('USAFOR') Then
    Result := Result + '     AND S.SPA_QTDC01 > 0.0 ';

  Result := Result + fGetGroup;
end;

function TTintadeMaquinaWrapperSparlack.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result :=
    '   SPA_CADSPA S                      ' +
    '   INNER JOIN SPA_CADBAS B           ' +
    '      ON S.SPA_CODBAS = B.BAS_CODBAS ' +
    '     AND S.SPA_CODUNI = B.BAS_CODUNI ' +
    '     AND S.SPA_PRODUT = B.BAS_PRODUT ' +
    '   INNER JOIN CADITE I               ' ;

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

function TTintadeMaquinaWrapperSparlack.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(S.SPA_ATIVAD, "S")) = "S" ';
end;

function TTintadeMaquinaWrapperSparlack.GetCampoAutoIncrem: String;
begin
  Result := 'S.AUTOINCREM';
end;

function TTintadeMaquinaWrapperSparlack.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompSparlack.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')), //TAutcomTintaFactory.Get.fCfgSis('TABPAD', varString)
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperSparlack.GetNomeTabela: String;
begin
  Result := 'SPA_CADSPA';
end;

procedure TTintadeMaquinaWrapperSparlack.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  configurador.fSetPos('S.SPA_CODSPA',0);
  configurador.fSetPos('S.SPA_DESCRI',1);
  configurador.fSetPos('S.SPA_PRODUT',2);
  configurador.fSetPos('S.SPA_REFERE',3);
  configurador.fSetPos('S.SPA_CODUNI',4);
  configurador.fSetPos('S.SPA_CODBAS',5);
  configurador.fSetPos('S.SPA_DTACAD',6);
  configurador.fSetPos('I.ITE_CODITE',  7);
  configurador.fSetPos('I.ITE_DESITE',  8);

  configurador.pAdicionarCampo('S.SPA_CODSPA', 'Código',            'LIKE');
  configurador.pAdicionarCampo('S.SPA_DESCRI', 'Descrição',         'LIKE');
  configurador.pAdicionarCampo('S.SPA_PRODUT', 'Produto',           'LIKE');
  configurador.pAdicionarCampo('S.SPA_REFERE', 'Referência',        'LIKE');
  configurador.pAdicionarCampo('S.SPA_CODUNI', 'Cód.Unidade',       'LIKE');
  configurador.pAdicionarCampo('S.SPA_CODBAS', 'Código da Base',    'LIKE');
  configurador.pAdicionarCampo('S.SPA_DTACAD', 'Data Cadastro',     'LIKE');
  configurador.pAdicionarCampo('I.ITE_CODITE',   'Código do Item',    'LIKE');
  configurador.pAdicionarCampo('I.ITE_DESITE',   'Descrição do Item', 'LIKE');
  configurador.pAdicionarCampo('S.SPA_MD5KEY', 'SPA_MD5KEY',        'LIKE', False, True);

  configurador.fSetVisivel('S.SPA_CODSPA', True);
  configurador.fSetVisivel('S.SPA_DESCRI', True);
  configurador.fSetVisivel('S.SPA_PRODUT', True);
  configurador.fSetVisivel('S.SPA_REFERE', True);
  configurador.fSetVisivel('S.SPA_CODUNI', True);
  configurador.fSetVisivel('S.SPA_CODBAS', True);
  configurador.fSetVisivel('S.SPA_DTACAD', True);
  configurador.fSetVisivel('I.ITE_DESITE',   True);

  configurador.pAdicionarIndice('S.SPA_CODSPA', 'Código');
  configurador.pAdicionarIndice('S.SPA_DESCRI', 'Descrição');
  configurador.pAdicionarIndice('S.SPA_PRODUT', 'Produto');
  configurador.pAdicionarIndice('S.SPA_REFERE', 'Referência');
  configurador.pAdicionarIndice('S.SPA_CODUNI', 'Cód.Unidade');
  configurador.pAdicionarIndice('S.SPA_CODBAS', 'Código da Base');
  configurador.pAdicionarIndice('S.SPA_DTACAD', 'Data Cadastro');
  configurador.pAdicionarIndice('I.ITE_CODITE',   'Código do Item');
  configurador.pAdicionarIndice('I.ITE_DESITE',   'Descrição do Item');

  configurador.pAdicionarIndice('SPA_PRODUT', 'Produto');
  configurador.pAdicionarIndice('SPA_DESCRI+SPA_REFERE', 'Descrição/Referência');
  configurador.pAdicionarIndice('SPA_CODBAS+SPA_CODUNI', 'Código da Base/Cód.Unidade');

  configurador.pAdicionarCampoDescricao('S.SPA_CODSPA');
  configurador.pAdicionarCampoDescricao('S.SPA_DESCRI');
  configurador.pAdicionarCampoDescricao('S.SPA_PRODUT');
  configurador.pAdicionarCampoDescricao('S.SPA_REFERE');
  configurador.pAdicionarCampoDescricao('S.SPA_CODUNI');
  configurador.pAdicionarCampoDescricao('S.SPA_CODBAS');
  configurador.pAdicionarCampoDescricao('S.SPA_DTACAD');
  configurador.pAdicionarCampoDescricao('I.ITE_CODITE');
  configurador.pAdicionarCampoDescricao('I.ITE_DESITE');
end;

end.
