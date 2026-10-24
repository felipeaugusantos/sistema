{**************************************************************************************}
{* Classe responsável pela configuração da tela de consulta da tinta AdvanceStr *}
{***********************************************************************************AC*}
unit untTintadeMaquinaWrapperAdvanceStr;

interface

uses
  untIConfiguradorConsulta, untAbstractTintadeMaquinaWrapper,
  untStrUtils, untAutcomTintaFactory, SysUtils, untIConsultaComp,
  untVariantUtils, untIDataSet;

type
  TTintadeMaquinaWrapperAdvanceStr = class(TAbstractTintadeMaquinaWrapper)
  Private
    function fGetLinha(): String;
  public
    procedure Configurar(const configurador: IConfiguradorConsulta); override;
    function GetCampoAutoIncrem: String; override;
    function fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String; override;
    procedure pRestaurarPadrao(const configurador: IConfiguradorConsulta); override;
    function fGetSelectFrom(const configurador: IConfiguradorConsulta): String; override;
    function GetNomeTinta: String; override;
    function GetNomeForm: String; override;
    function GetNomeTabela: String; override;
    function GetConsultaComp(strTabPre: String): IConsultaComp; override;
    function fGetWhere: String; override;
  end;

implementation

uses
{$IFNDEF LINUX}
  untConsultaCompAdvanceStr,
{$ENDIF}
   untAbstractLibTinta, untLibTintaFactory;

{ TTintadeMaquinaWrapperAdvanceStr }

procedure TTintadeMaquinaWrapperAdvanceStr.Configurar(const configurador: IConfiguradorConsulta);
var
  intCont: Integer;
begin
  //Configurador AdvanceStr
  Configurador.pAdicionarCampo('ADS_CODIGO', 'Código', 'LIKE');
  Configurador.pAdicionarCampo('ADS_DESCRI', 'Descrição Cor',  'LIKE');
  Configurador.pAdicionarCampo('ADS_CODBAS', 'Código Base',  'LIKE');
  Configurador.pAdicionarCampo('ADS_PRODUT', 'Produto', 'LIKE');
  Configurador.pAdicionarCampo('ADS_LINHA_', 'Linha', 'LIKE');
  Configurador.pAdicionarCampo('ADS_UNIDAD', 'Unidade', 'LIKE');
  Configurador.pAdicionarCampo('ADS_NOMCOR', 'Nome Cor', 'LIKE');
  Configurador.pAdicionarCampo('ADS_DTACAD', 'Data Cadastro', 'LIKE');
  Configurador.pAdicionarCampo('CADITE.ITE_DESITE', 'Descrição do Item', 'LIKE');
  Configurador.pAdicionarCampo('CADITE.ITE_CODITE', 'Código do Item', 'LIKE', False, True);
  Configurador.pAdicionarCampo('ADS_MD5KEY', 'Chave MD5', '=', False, True);
  Configurador.pAdicionarCampo('ADS_ACRMOB', 'Acrescimo Mao Obra', '=', False, False);
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoFisico + 'AS ITE_SALFIS', 'Saldo Físico', 'LIKE');
  Configurador.pAdicionarCampo(TAutcomTintaFactory.Get.fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS', 'Saldo Disponível', 'LIKE');

  For intCont := 1 To 20 Do
  Begin
    configurador.pAdicionarCampo('ADS_FORM' + TStrUtils.fStrZero(intCont, 2), 'ADS_FORM' + TStrUtils.fStrZero(intCont, 2),
      'LIKE', False, False);

    configurador.pAdicionarCampo('ADS_QTDC' + TStrUtils.fStrZero(intCont, 2), 'ADS_QTDC' + TStrUtils.fStrZero(intCont, 2),
      '=', False, False);
  End;
end;

function TTintadeMaquinaWrapperAdvanceStr.fGetLinha: String;
Var
  qryGen   : IDataSet;
  arrOpcoes: Array Of String;
  intOpcao : Integer;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'SELECT DISTINCT LIN_DESCRI FROM ADS_CADLIN ';
  qryGen.Open;
  qryGen.First;

  While not qryGen.Eof Do
  Begin
    SetLength(arrOpcoes, Length(arrOpcoes) + 1);
    arrOpcoes[Length(arrOpcoes)-1] := qryGen.FieldbyName('LIN_DESCRI').AsString;

    qryGen.Next;
  End;

  If Length(arrOpcoes) >= 2 Then
  Begin
    {$IFNDEF LINUX}
    intOpcao := TAutcomTintaFactory.Get.fGetMenu('Linha', arrOpcoes, 1, True);
    {$ELSE}
    intOpcao := 0;
    {$ENDIF}
    If intOpcao > 0 Then
      Result   := arrOpcoes[intOpcao-1]
    Else
      Result := '';
  End
  Else If Length(arrOpcoes) = 1 then
  Begin
    intOpcao := 1;
    Result   := arrOpcoes[intOpcao-1];
  End;
end;

function TTintadeMaquinaWrapperAdvanceStr.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
begin
  Result := Inherited fGetSelect(blnTodos, configurador);

  Result := Result + ' AND UPPER(IFNULL(ADS_ATIVAD, ''S'')) = ''S'' ';
end;

function TTintadeMaquinaWrapperAdvanceStr.fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
begin
  Result := '';
  Result := Result + '  ADS_CADADS ';
  Result := Result + '   INNER JOIN ADS_CADBAS ';
  Result := Result + '     ON ADS_CODBAS = BAS_CODBAS ';
  Result := Result + '       AND ADS_PRODUT = BAS_PRODUT ';
  Result := Result + '       AND ADS_UNIDAD = BAS_UNIDAD ';
  Result := Result + '    INNER JOIN ADS_CADLIN ON    ';
  Result := Result + '      ADS_LINHA_ = LIN_DESCRI      ';
  Result := Result + '  	  INNER JOIN CADITE ON CADITE.ITE_CODITE = BAS_CODITE     ';
  Result := Result + '     AND CADITE.ITE_ITEATI = "S"          ';
  Result := Result + '      INNER JOIN ITEGER ON         ';
  Result := Result + '       BAS_CODITE = ITEGER.ITE_CODITE AND    ';
  Result := Result + '       ITEGER.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';
end;

function TTintadeMaquinaWrapperAdvanceStr.fGetWhere: String;
Var
  strLinha: String;
begin
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND UPPER(IFNULL(ADS_ATIVAD,"S")) = "S" ';

  strLinha := fGetLinha;

  If Not TStrUtils.fEmptyStr(strLinha) Then
    Result := Result + '  AND ADS_LINHA_ = ' + QuotedStr(strLinha) + '  ';
end;

function TTintadeMaquinaWrapperAdvanceStr.GetCampoAutoIncrem: String;
begin
  Result := 'ADS_CADADS.AUTOINCREM';
end;

function TTintadeMaquinaWrapperAdvanceStr.GetConsultaComp(strTabPre: String): IConsultaComp;
begin
{$IFNDEF LINUX}
  Result := TConsultaCompAdvanceStr.Create(TLibTintaFactory.GetLibTinta.GetDigDadosTintometricos(
    TVariantUtils.IfNull(strTabPre, '1')),
    Self
  );
{$ENDIF}
end;

function TTintadeMaquinaWrapperAdvanceStr.GetNomeForm: String;
begin
  Result := 'AdvanceStr';
end;

function TTintadeMaquinaWrapperAdvanceStr.GetNomeTabela: String;
begin
  Result := 'ADS_CADADS';
end;

function TTintadeMaquinaWrapperAdvanceStr.GetNomeTinta: String;
begin
  Result := 'AdvanceStr';
end;

procedure TTintadeMaquinaWrapperAdvanceStr.pRestaurarPadrao(const configurador: IConfiguradorConsulta);
begin
  Configurador.fSetPos('ADS_CODIGO', 0);
  Configurador.fSetPos('ADS_UNIDAD', 1);
  Configurador.fSetPos('ADS_DESCRI', 2);
  Configurador.fSetPos('ADS_LINHA_', 3);
  Configurador.fSetPos('CADITE.ITE_DESITE', 4);
  Configurador.fSetPos('ADS_CODBAS', 5);
  Configurador.fSetPos('ADS_PRODUT', 6);
  Configurador.fSetPos('CADITE.ITE_CODITE', 7);

  Configurador.fSetVisivel('ADS_CODIGO' , True);
  Configurador.fSetVisivel('ADS_UNIDAD' , True);
  Configurador.fSetVisivel('ADS_DESCRI' , True);
  Configurador.fSetVisivel('ADS_LINHA_' , True);
  Configurador.fSetVisivel('CADITE.ITE_DESITE' , True);
  Configurador.fSetVisivel('ADS_CODBAS' , True);
  Configurador.fSetVisivel('ADS_PRODUT' , True);
  Configurador.fSetVisivel('CADITE.ITE_CODITE' , True);

  configurador.pAdicionarIndice('ADS_DESCRI+ADS_UNIDAD' , 'Descrição Cor\Unidade');
  configurador.pAdicionarIndice('ADS_CODIGO'  , 'Código');
  Configurador.pAdicionarIndice('ADS_PRODUT'  , 'Produto');
  Configurador.pAdicionarIndice('CADITE.ITE_DESITE'  , 'Descrição do Item');

  configurador.pAdicionarCampoDescricao('ADS_UNIDAD');
end;

end.



