{*****************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta MazaImobiliaria *}
{**************************************************************************PH*}
unit untTintadeMaquinaWrapperMazaImobiliaria;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperMazaImobiliaria = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompMazaImobiliaria,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperMazaImobiliaria }

procedure TTintadeMaquinaWrapperMazaImobiliaria.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  configurador.pAdicionarCampo('S.MZI_CODMZI', 'Código',            'LIKE');
  configurador.pAdicionarCampo('S.MZI_COLNAM', 'Descrição',         'LIKE');
  configurador.pAdicionarCampo('S.MZI_COLNUM', 'Referência',        'LIKE');
  configurador.pAdicionarCampo('S.MZI_CODUNI', 'Unidade',           'LIKE');
  configurador.pAdicionarCampo('S.MZI_CODBAS', 'Código da Base',    'LIKE');
  configurador.pAdicionarCampo('S.MZI_DTACAD', 'Data Cadastro',     'LIKE');
  configurador.pAdicionarCampo('I.ITE_CODITE',   'Código do Item',    'LIKE');
  configurador.pAdicionarCampo('I.ITE_DESITE',   'Descrição do Item', 'LIKE');
  configurador.pAdicionarCampo('S.MZI_BAICOB', 'Baixa Cobertura',   'LIKE');
  configurador.pAdicionarCampo('S.MZI_PRODUT', 'Produto',           'LIKE');
  configurador.pAdicionarCampo('S.MZI_SUBCOL', 'Leque da Cor',       'LIKE');
  configurador.pAdicionarCampo('S.MZI_MD5KEY', 'MZI_MD5KEY',        'LIKE', False, True);
  configurador.pAdicionarCampo('S.MZI_COLNAM', 'MZI_COLNAM',        'LIKE', False, False);
  Configurador.pAdicionarCampo('S.MZI_ACRMOB', 'MZI_ACRMOB',        'LIKE', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');



  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('MZI_CODC' + TStrUtils.fStrZero(intCont, 2), 'MZI_CODC' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('MZI_QTDC' + TStrUtils.fStrZero(intCont, 2), 'MZI_QTDC' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperMazaImobiliaria.fGetGroup: String;
begin
  Result := '';
end;

function TTintadeMaquinaWrapperMazaImobiliaria.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  If TAutcomTintaFactory.Get.fGetConfTinta('MZI').fGetBoolean('USAFOR') Then
    Result := Result + '     AND S.MZI_QTDC01 > 0.0 ';

  Result := Result + fGetGroup;
end;

function TTintadeMaquinaWrapperMazaImobiliaria.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result :=
    '   MZI_CADMZI S                      ' +
    '   INNER JOIN MZI_CADBAS B           ' +
    '      ON S.MZI_CODBAS = B.BAS_CODBAS ' +
    '     AND S.MZI_PRODUT = B.BAS_PRODUT ' +
    '     AND S.MZI_CODUNI = B.BAS_CODUNI ' +
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
    Result := Result + '       BAS_CODITE = ITEGER.ITE_CODITE AND    ';
    Result := Result + '       ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
  End;
 end;

function TTintadeMaquinaWrapperMazaImobiliaria.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(S.MZI_ATIVAD, "S")) = "S" ';
end;

function TTintadeMaquinaWrapperMazaImobiliaria.GetCampoAutoIncrem: String;
begin
  Result := 'S.AUTOINCREM';
end;

function TTintadeMaquinaWrapperMazaImobiliaria.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompMazaImobiliaria.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')), //TAutcomTintaFactory.Get.fCfgSis('TABPAD', varString)
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperMazaImobiliaria.GetNomeTabela: String;
begin
  Result := 'MZI_CADMZI';
end;

procedure TTintadeMaquinaWrapperMazaImobiliaria.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  configurador.fSetPos('S.MZI_CODMZI',0);
  configurador.fSetPos('S.MZI_COLNAM',1);
  configurador.fSetPos('S.MZI_COLNUM',2);
  configurador.fSetPos('S.MZI_CODUNI',3);
  configurador.fSetPos('S.MZI_CODBAS',4);
  configurador.fSetPos('S.MZI_DTACAD',5);
  configurador.fSetPos('I.ITE_CODITE',  6);
  configurador.fSetPos('I.ITE_DESITE',  7);
  configurador.fSetPos('S.MZI_PRODUT',8);


  configurador.fSetVisivel('S.MZI_CODMZI', True);
  configurador.fSetVisivel('S.MZI_COLNAM', True);
  configurador.fSetVisivel('S.MZI_COLNUM', True);
  configurador.fSetVisivel('S.MZI_CODUNI', True);
  configurador.fSetVisivel('S.MZI_CODBAS', True);
  configurador.fSetVisivel('S.MZI_DTACAD', True);
  configurador.fSetVisivel('I.ITE_DESITE',   True);
  configurador.fSetVisivel('S.I_PRODUT',   True);

  configurador.pAdicionarIndice('S.MZI_CODMZI', 'Código');
  configurador.pAdicionarIndice('S.MZI_COLNAM', 'Descrição');
  configurador.pAdicionarIndice('S.MZI_COLNUM', 'Referência');
  configurador.pAdicionarIndice('S.MZI_CODUNI', 'Cód.Unidade');
  configurador.pAdicionarIndice('S.MZI_CODBAS', 'Código da Base');
  configurador.pAdicionarIndice('S.MZI_DTACAD', 'Data Cadastro');
  configurador.pAdicionarIndice('I.ITE_CODITE',   'Código do Item');
  configurador.pAdicionarIndice('I.ITE_DESITE',   'Descrição do Item');

  configurador.pAdicionarIndice('MZI_COLNAM+MZI_COLNUM', 'Descrição/Referência');
  configurador.pAdicionarIndice('MZI_CODBAS+MZI_PRODUT', 'Código Base/Produto');

  configurador.pAdicionarCampoDescricao('S.MZI_CODMZI');
  configurador.pAdicionarCampoDescricao('S.MZI_COLNAM');
  configurador.pAdicionarCampoDescricao('S.MZI_COLNUM');
  configurador.pAdicionarCampoDescricao('S.MZI_CODUNI');
  configurador.pAdicionarCampoDescricao('S.MZI_CODBAS');
  configurador.pAdicionarCampoDescricao('S.MZI_DTACAD');
  configurador.pAdicionarCampoDescricao('I.ITE_CODITE');
  configurador.pAdicionarCampoDescricao('I.ITE_DESITE');
  configurador.pAdicionarCampoDescricao('S.MZI_PRODUT');
end;

end.
