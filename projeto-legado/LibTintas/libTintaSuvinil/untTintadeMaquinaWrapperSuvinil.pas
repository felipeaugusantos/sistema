{*****************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta suvinil *}
{**************************************************************************PH*}
unit untTintadeMaquinaWrapperSuvinil;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils;

type
  TTintadeMaquinaWrapperSuvinil = class(TAbstractTintadeMaquinaWrapper)
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
  untConsultaCompSuvinil,
{$ENDIF}
  untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperSuvinil }

procedure TTintadeMaquinaWrapperSuvinil.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  configurador.pAdicionarCampo('S.SUV_DESCRI', 'Descrição', 'LIKE');
  configurador.pAdicionarCampo('S.SUV_DTACAD', 'Data Cadastro', 'LIKE');
  configurador.pAdicionarCampo('S.SUV_REFERE', 'Referência', 'LIKE');
  configurador.pAdicionarCampo('S.SUV_UNIDAD', 'Unidade', 'LIKE');
  configurador.pAdicionarCampo('S.SUV_CODFML', 'Fórmula', 'LIKE');
  configurador.pAdicionarCampo('S.SUV_CODBAS', 'Código da Base', 'LIKE');
  configurador.pAdicionarCampo('S.SUV_NOMCOR', 'Cor', 'LIKE');
  configurador.pAdicionarCampo('I.ITE_CODITE', 'Código do Item', 'LIKE');
  configurador.pAdicionarCampo('I.ITE_DESITE', 'Descrição do Item', 'LIKE');
  configurador.pAdicionarCampo('I.ITE_REFERE', 'Referência do Item', 'LIKE');
  configurador.pAdicionarCampo('S.SUV_CODUNI', 'SUV_CODUNI', 'LIKE', False, False);
  configurador.pAdicionarCampo('S.SUV_MD5KEY', 'SUV_MD5KEY', 'LIKE', False, True);
  Configurador.pAdicionarCampo('S.SUV_ACRMOB', 'SUV_ACRMOB', 'LIKE', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');


  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('SUV_FORM' + TStrUtils.fStrZero(intCont, 2), 'SUV_FORM' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('SUV_QTDB' + TStrUtils.fStrZero(intCont, 2), 'SUV_QTDB' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperSuvinil.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

 { If TAutcomTintaFactory.Get.fGetConfTinta('SUV').fGetBoolean('USAFOR') Then
    Result := Result + '     AND S.SUV_QTDB01 > 0.0 ';  }

  Result := Result + ' AND UPPER(IFNULL(S.SUV_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperSuvinil.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result :=
    '   SUV_CADSUV S                      ' +
    '   INNER JOIN SUV_CADBAS B           ' +
    '     ON S.SUV_CODBAS = B.SUV_CODBAS  ' +
    '     AND S.SUV_CODFML = B.SUV_CODFML ' +
    '     AND S.SUV_CODUNI = B.SUV_CODUNI ' +
    '   INNER JOIN CADITE I               ';

  If TStrUtils.fEmptyStr(configurador.GetCodIte) Then
  Begin
    Result := Result + '     ON B.SUV_CODITE = I.ITE_CODITE ';
    Result := Result + '     AND I.ITE_ITEATI = "S"          ';
    Result := Result + '     INNER JOIN ITEGER ON         ';
    Result := Result + '       B.SUV_CODITE = ITEGER.ITE_CODITE AND    ';
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

function TTintadeMaquinaWrapperSuvinil.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(SUV_ATIVAD,"S")) = "S" ';
end;

function TTintadeMaquinaWrapperSuvinil.GetCampoAutoIncrem: String;
begin
  Result := 'S.AUTOINCREM';
end;

function TTintadeMaquinaWrapperSuvinil.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompSuvinil.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')), //TAutcomTintaFactory.Get.fCfgSis('TABPAD', varString)
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperSuvinil.GetNomeTabela: String;
begin
  Result := 'SUV_CADSUV';
end;

procedure TTintadeMaquinaWrapperSuvinil.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  configurador.fSetPos('S.SUV_REFERE', 0);
  configurador.fSetPos('S.SUV_UNIDAD', 1);
  configurador.fSetPos('I.ITE_DESITE', 2);
  configurador.fSetPos('I.ITE_REFERE', 3);

  configurador.fSetVisivel('S.SUV_REFERE', True);
  configurador.fSetVisivel('S.SUV_UNIDAD', True);
  configurador.fSetVisivel('I.ITE_DESITE', True);
  configurador.fSetVisivel('I.ITE_REFERE', True);

  configurador.pAdicionarIndice('S.SUV_DESCRI+S.SUV_REFERE+S.SUV_NOMCOR', 'Descrição/Referência/Cor');
  configurador.pAdicionarIndice('S.SUV_REFERE', 'Referência');
  configurador.pAdicionarIndice('I.ITE_DESITE', 'Descrição do Item');

  configurador.pAdicionarCampoDescricao('S.SUV_REFERE');
  configurador.pAdicionarCampoDescricao('S.SUV_UNIDAD');
  configurador.pAdicionarCampoDescricao('I.ITE_DESITE');
  configurador.pAdicionarCampoDescricao('I.ITE_REFERE');
end;

end.




