unit untTintadeMaquina;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
  Shared.Core, untFuncoesGenerica,
{$ELSE}
  Forms, Graphics, UniClientDataSet, Controls, ExtCtrls, ActiveX,
  untConsultaCompTintaNovaCx,
  untPanelCxBotoesAcoesNovaConsulta, untPnlBotoesAcoesNovaConsulta,
  untFuncoesSimples, untClassPanelCx,
{$ENDIF}
  untIConsultaTinta , Uni, Classes, untConstantes,
  StrUtils, Types,
  System.AnsiStrings,
  untTypesSistema,
  untFuncEspecificas,
  untICalculadorFatVendasTAB;

Type
  TArrString = Array Of String;

  {**************************************}
  {* ESTRUTURA DO CAMPO,                *}
  {* PARA SABER QUAL OPERADO,           *}
  {* SE ESTÁ VISIVEL NA CONSULTA,       *}
  {* SE ESTA DISPONIVEL PARA COPNSULTA, *}
  {* E PARA SABER A DESCRICAO DO CAMPO  *}
  {***********************************PH*}
  TCampoConf = Record
    strNomCampo: String;
    strDesCampo: String;
    blnVisivel: Boolean;
    blnDisponivel: Boolean;
    strOperador: String;
  End;

  {*****************************}
  {* ESTRUTURA PARA OS INDICES *}
  {**************************PH*}
  TIndiceConf = Record
    strNomeCampo: String;
    strDesCampo: String;
  End;

  TTintadeMaquina = class(TInterfacedObject, IConsultaTinta)
  private
    FstrIdePro: String;
    FstrLinhaWandaPro: String;
    FDicionarioTab: TDicionario;
    procedure SetstrIdePro(const Value: String);
    function fRetornaOperador(strNomCampo: String): String;
    function fVendeItem(cdsConsulta: TUniClientDataSet; DropControl: TControl; RectLinhaGrid: TRect): Boolean;
    function fTintaPossuiMD5KEY(strIdeTinta: String): Boolean;

  protected
    qryConf: TUniQuery;
    arrCampos: Array of TCampoConf;
    arrIndices: Array of TIndiceConf;
    arrPrevia: Array Of String;

    strCodIte: String;
    strCampoAutoincrem: String;

    {********************************************}
    {* CARREGA AS CONFIGURACOES PARA OS VETORES *}
    {*****************************************PH*}
    procedure pAbrirTabelaConfs();


    {*****************************************}
    {* ADICIONA O CAMPO NO VETOR, ATUALIZADO *}
    {* QUANDO JA ESTA PRESENTE               *}
    {**************************************PH*}
    procedure pAdicionarCampo(strNomCampo, strDesCampo, strOperador: String;
      blnVisivel: Boolean = False; blnDisponivel: Boolean = True);

    {*********************************}
    {* ADICIONA NO VETOR DOS INDICES *}
    {******************************PH*}
    procedure pAdicionarIndice(strNomeCampo, strDesCampo: String);

    {***********************************************}
    {* VERIFICA SE O USUARIO JA CONFIGUROU A TINTA *}
    {********************************************PH*}
    function fVerificaConfigurado(): Boolean;

    {***********************************************}
    {* VERIFICA SE O SELECT COM AUTOINCREM EXISTE  *}
    {* GROUP BY(ESTA procedure É NECESSARIA POR    *}
    {* CONTA DA COLOR PRO A PRINCIPIO E SERÁ UTIL  *}
    {* PARA TODAS QUE USAREM GROUP BY              *}
    {********************************************AC*}

    procedure pRetornaSeSelectTemGroupBy(strSelect: String; Var strResult, strGroup: String);
    function fGetSelectFrom: String; virtual;
  public
    destructor Destroy; override;
    constructor Create; virtual;

    function fGetCaptionColuna(intPos: Integer): String; overload; virtual;
    function fGetNomeCampoColuna(intPos: Integer): String; overload; virtual;
    function fGetQtdColunas: Integer; virtual;
    function fGetSelect(blnTodos: Boolean): String; overload; virtual;
    function fGetCamposSelect(blnTodos: Boolean): String; overload; virtual;
    function fGetWhere(): String; overload; virtual;
    function fGetGroup(): string; overload; virtual;
    function fGetCaptionColunaVisivel(intPos: Integer): String; virtual;
    function fGetNomeCampoColunaVisivel(intPos: Integer): String; virtual;
    function fGetQtdColunasVisiveis: Integer; virtual;
    function fGetVisivel(intPos: Integer): Boolean; virtual;
    function fGetCaptionColuna(strNomeCampo: String): String; overload; virtual;
    function fGetNomeCampoColuna(strCaptionColuna: String): String; overload; virtual;
    function fGetPos(strNomeCampo: String): Integer; virtual;
    function fGetDescricao(strAutoincrem: String): String; overload; virtual;
    function fGetDescricao(strAutoincrem: String; strCodIte: String): String; overload; virtual;
    function fGetDisponivel(intPos: Integer): Boolean; overload;
    function fGetDisponivel(strNomeCampo: String): Boolean; overload;
    function fGetNomeCampo(strNomeCampo: String): String;
    function fGetCamposIndice(intIndex: Integer): String;
    function fGetDesCamposIndice(intIndex: Integer): String;
    function fGetQtdIndices: Integer;
    function fGetTodosCamposIndices: String;
    function fGetIndiceInicial: TArrString;
    function fGetTodosDesCamposIndices: String;
    function fGetOperador(strNomeCampo: String): String; overload;
    function fGetOperador(intIndex: Integer): String; overload;

    procedure fSetVisivel(strNomeCampo: String; blnValor: Boolean); overload; virtual;
    procedure fSetVisivel(intPos: Integer; blnValor: Boolean); overload; virtual;
    procedure fSetPos(strNomeCampo: String; intPos: Integer);
    procedure pSetDesCamposIndice(intIndex: Integer; strDesCampos: String);
    procedure pSetCamposIndice(intIndex: Integer; strCampos: String);
    procedure pSetQtdIndices(intQtdIndices: Integer);

    procedure pSalvarConfs();
    procedure pRestaurarPadrao; virtual;

    Procedure pGetSelectCxGrid(blnTodos: Boolean; var arrSelect, arrNomCol: TArrString); overload; virtual;

    {$IFNDEF LINUX}
    function fExecutarConsulta(Sender: TForm; qryCad: TUniQuery;
      tipoConsulta: TTipoConsultaTinta; strTabPre: String;
      TfrmConsulta: TfrmPnlBotoesAcoesNovaConsultaClass;
      strLinhaWandaPro: string = ''; blnFaturamento: Boolean = False;
      blnPermiteTab: Boolean = True; dicRetorno: TDicionario = Nil;
      sltItems: TStringList = Nil): String; virtual;

    function fExecutarConsultaCxGrid(Sender: TForm;
      qryCad: TUniQuery; tipoConsulta: TTipoConsultaTinta; strTabPre: String;
      TfrmConsulta: TfrmConsultaCompTintaNovaCxClass): String;
    {$ENDIF}

    function fGetNomeTabela: String; virtual; abstract;
    function fGetNomeTinta: String; virtual;
    function fGetNomeForm: String; virtual;
    function fGetSelectAutoIncrem(strAutoIncrem: String): String;
    function fGetSelectMD5KEY(strMD5Key: String): String;
    procedure SetstrLinhaWandaPro(const Value: String);
    function fAtuallizarConfiguracaoCFGCON(CamposVisiveis, FiltrosVisiveis, ChaveCFGCON: string): boolean;
    function fTemCampoVENDIDONaCFGCON(ChaveCFGCON: string): Boolean;

    function fRetornarDescricaoCatalisador(strIdePro : String; qryGen: TUniQuery) : String;
  public
    function fGetCampoDescricao(intIndex: Integer): String; virtual;
    function fGetDesCampoDescricao(intIndex: Integer): String; virtual;
    function fGetQtdCamposDescricao: Integer; virtual;
    procedure pAdicionarCampoDescricao(strNomeCampo: String); virtual;
    procedure pLimparDescricao; virtual;
    function fGetCampoAutoIncrem: String; virtual;
  public
    property strIdePro: String read FstrIdePro write SetstrIdePro;
    property strLinhaWandaPro: String read FstrLinhaWandaPro write SetstrLinhaWandaPro;
  End;

  TTintadeMaquinaClasse = class of TTintadeMaquina;

{$IFNDEF LINUX}
  TDefConsulaItem = class(TDefConsulta)
  private
  public
    sltItems: TStringList;
    Constructor Create; Reintroduce;
    Destructor Destroy; override;
    procedure pParametriza(qryConsulta: TUniQuery); override;
  End;
{$ENDIF}

implementation

uses
{$IFNDEF LINUX}
  untModulo, untPanelCxTintaNova,
{$ENDIF}
  SysUtils, Data.DB, untTintaMaquina;

{ TTintadeMaquina }

constructor TTintadeMaquina.Create;
begin
  SetLength(arrCampos, 0);
  SetLength(arrIndices, 0);
  SetLength(arrPrevia, 0);
  strCodIte := '';
end;

destructor TTintadeMaquina.Destroy;
begin
  qryConf.Free;
  inherited;
end;

function TTintadeMaquina.fGetCaptionColuna(intPos: Integer): String;
begin
  Result := arrCampos[intPos].strDesCampo;
end;

function TTintadeMaquina.fGetCaptionColuna(strNomeCampo: String): String;
  Var
    intCont: Integer;
begin
  Result := '';
  For intCont := 0 To Length(arrCampos) - 1 Do
  Begin

    If fGetNomeCampo(arrCampos[intCont].strNomCampo) = fGetNomeCampo(strNomeCampo) Then
    Begin
      Result := arrCampos[intCont].strDesCampo;
      Exit;
    End;
  End;
end;

function TTintadeMaquina.fGetCaptionColunaVisivel(intPos: Integer): String;
  Var
    intCont: Integer;
    intVisivel: Integer;
begin
  intVisivel := 0;
  For intCont := 0 To Length(arrCampos) - 1 Do
  Begin
    If arrCampos[intCont].blnVisivel Then
    Begin
      If (intPos = intVisivel) Then
      Begin
        Result := arrCampos[intCont].strDesCampo;
        Exit;
      End;
      intVisivel := intVisivel + 1;
    End;
  End;
end;

function TTintadeMaquina.fGetNomeCampoColuna(intPos: Integer): String;
begin
  Result := arrCampos[intPos].strNomCampo;
end;

function TTintadeMaquina.fGetNomeCampoColuna(
  strCaptionColuna: String): String;
  Var
    intCont: Integer;
begin
  Result := '';
  For intCont := 0 To Length(arrCampos) - 1 Do
  Begin
    If arrCampos[intCont].strDesCampo = strCaptionColuna Then
    Begin
      Result := arrCampos[intCont].strNomCampo;
      Exit;
    End;
  End;
end;

function TTintadeMaquina.fGetNomeCampoColunaVisivel(
  intPos: Integer): String;
  Var
    intCont: Integer;
    intVisivel: Integer;
begin
  intVisivel := 0;
  For intCont := 0 To Length(arrCampos) - 1 Do
  Begin
    If arrCampos[intCont].blnVisivel Then
    Begin
      If (intPos = intVisivel) Then
      Begin
        Result := arrCampos[intCont].strNomCampo;
        Exit;
      End;
      intVisivel := intVisivel + 1;
    End;
  End;
end;

function TTintadeMaquina.fGetNomeForm: String;
begin
  Result := fGetTintasdeMaquina.fGetNomeTinta(Self.strIdePro);
end;

function TTintadeMaquina.fGetNomeTinta: String;
begin
  Result := fGetTintasdeMaquina.fGetNomeTinta(Self.strIdePro);
end;

function TTintadeMaquina.fGetPos(strNomeCampo: String): Integer;
begin
  For Result := 0 To Length(arrCampos) - 1 Do
  Begin
    If arrCampos[Result].strNomCampo = strNomeCampo Then
      Exit;
  End;

  Result := -1;
end;

function TTintadeMaquina.fGetQtdColunas: Integer;
begin
  Result := Length(arrCampos);
end;

function TTintadeMaquina.fGetQtdColunasVisiveis: Integer;
  Var
    intCont: Integer;
begin
  Result := 0;
  For intCont := 0 To Length(arrCampos) - 1 Do
  Begin
    If arrCampos[intCont].blnVisivel Then
      Result := Result + 1;
  End;
end;


procedure TTintadeMaquina.fSetVisivel(strNomeCampo: String; blnValor: Boolean);
begin
  arrCampos[fGetPos(strNomeCampo)].blnVisivel := blnValor;
end;

procedure TTintadeMaquina.fSetPos(strNomeCampo: String; intPos: Integer);
  Var
    campo: TCampoConf;
    intPosOld: Integer;
begin

  If (intPos >= 0) And (intPos < Length(arrCampos)) Then
  Begin
    For intPosOld := 0 To Length(arrCampos) - 1 Do
      If fGetNomeCampo(arrCampos[intPosOld].strNomCampo) = fGetNomeCampo(strNomeCampo) Then
      Begin
        campo := arrCampos[intPos];
        arrCampos[intPos] := arrCampos[intPosOld];
        arrCampos[intPosOld] := campo;
        Exit;
      End;
  End;
end;

procedure TTintadeMaquina.fSetVisivel(intPos: Integer; blnValor: Boolean);
begin
  arrCampos[intPos].blnVisivel := blnValor;
end;

function TTintadeMaquina.fTintaPossuiMD5KEY(strIdeTinta: String): Boolean;
begin
  Result := True;
  If Pos(strIdeTinta,'GLA_SAL_') > 0 Then
    Result := False;
end;

function TTintadeMaquina.fGetVisivel(intPos: Integer): Boolean;
begin
  Result := arrCampos[intPos].blnVisivel;
end;

function TTintadeMaquina.fGetWhere: String;
begin
  Result := ' WHERE TRUE ';
end;

function TTintadeMaquina.fRetornaOperador(strNomCampo: String): String;
begin
  if Pos(' AS ',strNomCampo) > 0 then
    Result := RightStr(strNomCampo,13)
  else
    Result := strNomCampo;

  If Pos('AS', Result) > 0 Then
    Result := RightStr(strNomCampo, 10);
end;

function TTintadeMaquina.fRetornarDescricaoCatalisador( strIdePro: String; qryGen: TUniQuery): String;
  Var
    IntCont  : Integer;
begin
  Result := '';

  if (strIdePro = 'DUP') Then
  Begin
    For intCont := 1 To 20 Do
    Begin
       If qryGen.FieldByName('DUP_TIPB' + fStrZero(intCont, 2)).AsString = 'C' Then
       Begin
         Result  := ' - CATALISADOR ' + qryGen.FieldByName('DUP_BASE' + fStrZero(intCont, 2)).AsString;
         Break;
       End;
    End;
  End;
end;

procedure TTintadeMaquina.pAbrirTabelaConfs();
  procedure AbrirConfs(strGrupo: String);
  begin
    qryConf.Close;
    qryConf.SQL.Clear;
    qryConf.SQL.Add(' SELECT * FROM CFGTIN WHERE CFG_IDEPRO = :IDEPRO AND CFG_CODEMP = :CODEMP ');
    qryConf.SQL.Add(' AND CFG_GRUCFG = "' + strGrupo + '" ORDER BY CFG_CODCFG ');

    qryConf.ParamByName('IDEPRO').AsString := strIdePro;
    qryConf.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryConf.Open;
  end;
begin
  qryConf := fCriaQuery(Nil);
  AbrirConfs('ORDEM DOS CAMPOS');

  While Not qryConf.Eof Do
  Begin
    pAdicionarCampo(
      qryConf.FieldByName('CFG_VALCFG').AsString,
      qryConf.FieldByName('CFG_DESCRI').AsString,
      fGetOperador(qryConf.FieldByName('CFG_VALCFG').AsString),
      True);

    fSetPos(fGetNomeCampo(qryConf.FieldByName('CFG_VALCFG').AsString), qryConf.RecNo - 1);
    qryConf.Next;
  End;

  AbrirConfs('ORDEM DOS INDICES');

  While Not qryConf.Eof Do
  Begin
    If (qryConf.FieldByName('CFG_VALCFG').AsString = 'WAN_CODUNI') And (qryConf.FieldByName('CFG_IDEPRO').AsString = 'WCP') Then
      pAdicionarIndice('WANPRO_CODUNI', qryConf.FieldByName('CFG_DESCRI').AsString)
    Else
      pAdicionarIndice(qryConf.FieldByName('CFG_VALCFG').AsString, qryConf.FieldByName('CFG_DESCRI').AsString);
    qryConf.Next;
  End;

  AbrirConfs('ORDEM DA DESCRICAO');

  While Not qryConf.Eof Do
  Begin
    pAdicionarCampoDescricao(qryConf.FieldByName('CFG_VALCFG').AsString);
    qryConf.Next;
  End;

end;

procedure TTintadeMaquina.pAdicionarCampo(strNomCampo, strDesCampo, strOperador: String;
      blnVisivel: Boolean = False; blnDisponivel: Boolean = True);
  Var
    novoRegistro: TCampoConf;
    intCont: Integer;
begin

  For intCont := 0 To Length(arrCampos) - 1 Do
  Begin
    If arrCampos[intCont].strNomCampo = strNomCampo Then
    Begin
      arrCampos[intCont].strOperador := strOperador;
      arrCampos[intCont].blnVisivel := blnVisivel;
      Exit;
    End;
  End;

  novoRegistro.strNomCampo := strNomCampo;
  novoRegistro.strDesCampo := strDesCampo;
  novoRegistro.blnVisivel := blnVisivel;
  novoRegistro.blnDisponivel := blnDisponivel;
  novoRegistro.strOperador := strOperador;

  SetLength(arrCampos, Length(arrCampos) + 1);
  arrCampos[Length(arrCampos) - 1] := novoRegistro;
end;

procedure TTintadeMaquina.pSalvarConfs();
  Var
    qryGen: TUniQuery;
    intCont: Integer;

    procedure NovaConf(strGrupo: String);
    begin
      qryGen.Close;
      qryGen.SQL.Text := 'DELETE FROM CFGTIN WHERE CFG_CODEMP = :CODEMP AND CFG_IDEPRO = :IDEPRO AND CFG_GRUCFG = :GRUCFG';
      qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryGen.ParamByName('IDEPRO').AsString := strIdePro;
      qryGen.ParamByName('GRUCFG').AsString := strGrupo;
      qryGen.ExecSQL;

      qryGen.SQL.Text := 'SELECT * FROM CFGTIN WHERE CFG_CODEMP = :CODEMP AND CFG_IDEPRO = :IDEPRO AND CFG_GRUCFG = :GRUCFG';
      qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryGen.ParamByName('IDEPRO').AsString := strIdePro;
      qryGen.ParamByName('GRUCFG').AsString := strGrupo;
      qryGen.Open;
    end;
begin
  qryGen := fCriaQuery(Nil);

  NovaConf('ORDEM DOS CAMPOS');

  For intCont := 0 To Length(arrCampos) - 1 Do
  Begin
    If arrCampos[intCont].blnVisivel Then
      qryGen.AppendRecord([VS_strCodEmp, strIdePro, 'POSICAO_' + fStrZero(qryGen.RecordCount + 1, 2),
        arrCampos[intCont].strNomCampo, arrCampos[intCont].strDesCampo, 'ORDEM DOS CAMPOS']);
  End;

  NovaConf('ORDEM DOS INDICES');

  For intCont := 0 To Length(arrIndices) - 1 Do
  Begin
    qryGen.AppendRecord([VS_strCodEmp, strIdePro, 'POSICAO_' + fStrZero(intCont + 1, 2),
      arrIndices[intCont].strNomeCampo, arrIndices[intCont].strDesCampo, 'ORDEM DOS INDICES']);
  End;

  NovaConf('ORDEM DA DESCRICAO');

  For intCont := 0 To Length(arrPrevia) - 1 Do
  Begin
    qryGen.AppendRecord([VS_strCodEmp, strIdePro, 'POSICAO_' + fStrZero(intCont + 1, 2),
      fGetCampoDescricao(intCont) , fGetDesCampoDescricao(intCont), 'ORDEM DA DESCRICAO']);
  End;

  qryGen.Free;
end;

procedure TTintadeMaquina.SetstrIdePro(const Value: String);
begin
  FstrIdePro := Value;
end;

procedure TTintadeMaquina.SetstrLinhaWandaPro(const Value: String);
begin
  FstrLinhaWandaPro := Value;
end;

function TTintadeMaquina.fGetDescricao(strAutoincrem: String): String;
  Var
    qryGen: TUniQuery;
    intCont: Integer;
    strNome  : String;
    strRefere: String;
    strMarca : String;
    strUnidad: String;

    strResult: String;
    strGroup: String;
begin
  pRetornaSeSelectTemGroupBy(fGetSelect(True),strResult,strGroup);
  qryGen := fCriaQuery();
  if strGroup <> EmptyStr then
    qryGen.SQL.Text := strResult +  ' AND ' + strCampoAutoincrem + ' = ' + AnsiQuotedStr(strAutoincrem, '"') + ' ' + strGroup
  else
    qryGen.SQL.Text := fGetSelect(True) +  ' AND ' + strCampoAutoincrem + ' = ' + AnsiQuotedStr(strAutoincrem, '"');
  qryGen.Open;

  Result := '';
  For intCont := 0 To fGetQtdCamposDescricao - 1 Do
  Begin
    {***************************}
    {* CASO SEJA TROCA DE BASE *}
    {************************AF*}
    If fGetNomeCampo(fGetCampoDescricao(intCont)) = 'ITE_DESITE' Then
    Begin

      If qryGen.FieldByName('ITE_CODITE').AsString <> Self.strCodIte Then
        Result := Result + ' ' + Trim(fRetNomProduto(Self.strCodIte))
      Else
        Result := Result + ' ' + Trim(qryGen.FieldByName(fGetNomeCampo(fGetCampoDescricao(intCont))).AsString);
    End

    else If fGetNomeCampo(fGetCampoDescricao(intCont)) = 'ITE_CODITE' Then
    Begin

      If qryGen.FieldByName('ITE_CODITE').AsString <> Self.strCodIte Then
        Result := Result + ' ' + Trim(Self.strCodIte)
      Else
        Result := Result + ' ' + Trim(qryGen.FieldByName(fGetNomeCampo(fGetCampoDescricao(intCont))).AsString);
    End

    Else If fGetNomeCampo(fGetCampoDescricao(intCont)) = 'ITE_REFERE' Then
    Begin
      If qryGen.FieldByName('ITE_CODITE').AsString <> Self.strCodIte Then
      Begin
        pRetDadosItem(Self.strCodIte, '', strNome, strRefere, strMarca, strUnidad);
        Result := Result + ' ' + Trim(strRefere);
      End
      Else
        Result := Result + ' ' + Trim(qryGen.FieldByName(fGetNomeCampo(fGetCampoDescricao(intCont))).AsString);
    End
    Else
      Result := Result + ' ' + Trim(qryGen.FieldByName(fGetNomeCampo(fGetCampoDescricao(intCont))).AsString);
  End;


  Result := Trim(Result + fRetornarDescricaoCatalisador(Self.strIdePro, qryGen));
end;

function TTintadeMaquina.fGetDescricao(strAutoincrem,
  strCodIte: String): String;
begin
  Self.strCodIte := strCodIte;
  Result := fGetDescricao(strAutoincrem);
end;

function TTintadeMaquina.fGetDisponivel(intPos: Integer): Boolean;
begin
  Result := arrCampos[intPos].blnDisponivel;
end;

function TTintadeMaquina.fGetDisponivel(strNomeCampo: String): Boolean;
  Var
    intCont: Integer;
begin
  Result := False;
  For intCont := 0 To Length(arrCampos) - 1 Do
  Begin
    If arrCampos[intCont].strNomCampo = strNomeCampo Then
    Begin
      Result := arrCampos[intCont].blnDisponivel;
      Exit;
    End;
  End;
end;

function TTintadeMaquina.fGetGroup: string;
begin
  Result := '';
end;

function TTintadeMaquina.fGetNomeCampo(strNomeCampo: String): String;
begin
  // Fiz esse esquema para os campos quanto existe apelido.
  // No caso surgiu a necessidade para a color pro por causa de um campo
  // com apelido no select.Por causa de um campo formatado com GROUP_CONCAT.
  if Pos(' AS ', strNomeCampo) > 0 then
    strNomeCampo := RightStr(strNomeCampo,13);

  If Pos('AS', strNomeCampo) > 0 Then
    strNomeCampo := RightStr(strNomeCampo, 10);

  If Pos('.', strNomeCampo) <= 0 Then
    Result := strNomeCampo
  Else
    Result := Copy(strNomeCampo, Pos('.', strNomeCampo) + 1, Length(strNomeCampo));
end;

function TTintadeMaquina.fGetCamposIndice(intIndex: Integer): String;
begin
  Result := arrIndices[intIndex].strNomeCampo;
end;

function TTintadeMaquina.fGetCamposSelect(blnTodos: boolean): String;
  var
    intCont: integer;
begin
  Result := '';
  Result := Result + ' SELECT ';

  For intCont := 0 To fGetQtdColunas - 1 Do
  Begin
    If blnTodos
      Or(fGetDisponivel(intCont)) Then
    Result := Result + ' ' + fGetNomeCampoColuna(intCont)  + ', ';
  End;
  Result := Result + Self.fGetCampoAutoIncrem + ', ';

  Result := Copy(Result, 1, LastDelimiter(',', Result) - 1) + ' ';

  Result := Result + ' FROM ' + fGetSelectFrom + ' ';
end;

function TTintadeMaquina.fGetDesCamposIndice(intIndex: Integer): String;
begin
  Result := arrIndices[intIndex].strDesCampo;
end;

procedure TTintadeMaquina.pSetDesCamposIndice(intIndex: Integer;
  strDesCampos: String);
begin
  arrIndices[intIndex].strDesCampo := strDesCampos;
end;

procedure TTintadeMaquina.pSetCamposIndice(intIndex: Integer;
  strCampos: String);
begin
  //Sempre que não for uma campo normal de 10 posicoes ex : CAST(GROUP_CONCAT(DISTINCT WANPRO_CODUNI SEPARATOR ", ") AS CHAR(80))
  //Criar uma apelido seguindo o padrao ex : CAST(GROUP_CONCAT(DISTINCT WANPRO_CODUNI SEPARATOR ", ") AS CHAR(80)) AS WAN_CODUNI
  //Dúvidas Consultar a unit untWandaProConsulta
  if Pos(' AS ',strCampos) > 0 then
    strCampos := RightStr(strCampos,13);

  If Pos('AS', strCampos) > 0 Then
    strCampos := RightStr(strCampos, 10);

  arrIndices[intIndex].strNomeCampo := strCampos;
end;

procedure TTintadeMaquina.pAdicionarIndice(strNomeCampo,
  strDesCampo: String);
  Var
    intCont: Integer;
begin
  For intCont := 0 To Length(arrIndices) - 1 Do
  Begin
    If arrIndices[intCont].strNomeCampo = strNomeCampo Then
      Exit;
  End;

  SetLength(arrIndices, Length(arrIndices) + 1);
  arrIndices[Length(arrIndices) - 1].strNomeCampo := strNomeCampo;
  arrIndices[Length(arrIndices) - 1].strDesCampo := strDesCampo;
end;

procedure TTintadeMaquina.pSetQtdIndices(intQtdIndices: Integer);
begin
  SetLength(arrIndices, intQtdIndices);
end;

function TTintadeMaquina.fGetQtdIndices: Integer;
begin
  Result := Length(arrIndices);
end;

function TTintadeMaquina.fGetTodosCamposIndices: String;
  Var
    intCont: Integer;
    stlResultado: TStringList;
begin
  stlResultado := TStringList.Create;
  Result := '';
  stlResultado.Clear;

  For intCont := 0 To Length(arrIndices) - 1 Do
  Begin
    stlResultado.Add(arrIndices[intCont].strNomeCampo);
  End;

  Result := stlResultado.Text;
  stlResultado.Free;
end;

function TTintadeMaquina.fGetIndiceInicial: TArrString;
  Var
    intCont: Integer;
    stlResultado: TStringList;
    strCampo: String;
begin
  stlResultado := TStringList.Create;
  Result := Nil;
  stlResultado.Clear;

  If Length(arrIndices) > 0 Then
  Begin
    stlResultado.Text := AnsiReplaceStr(arrIndices[0].strNomeCampo, '+', #13#10);
  End;

  SetLength(Result, stlResultado.Count);

  For intCont := 0 To stlResultado.Count - 1 Do
  Begin
    strCampo := stlResultado[intCont];

    If Pos('.', strCampo) > 0 Then
      Delete(strCampo, 1, Pos('.', strCampo));

    Result[intCont] := strCampo;
  End;

  stlResultado.Free;
end;


function TTintadeMaquina.fGetTodosDesCamposIndices: String;
  Var
    intCont: Integer;
    stlResultado: TStringList;
begin
  stlResultado := TStringList.Create;
  Result := '';
  stlResultado.Clear;

  For intCont := 0 To Length(arrIndices) - 1 Do
  Begin
    stlResultado.Add(arrIndices[intCont].strDesCampo);
  End;

  Result := stlResultado.Text;
  stlResultado.Free;
end;

function TTintadeMaquina.fGetOperador(strNomeCampo: String): String;
  Var
    intCont: Integer;
begin
  For intCont := 0 To Length(arrCampos) - 1 Do
  Begin
    If fRetornaOperador(arrCampos[intCont].strNomCampo) = strNomeCampo Then
    Begin
      Result := arrCampos[intCont].strOperador;
      Exit;
    End;
  End;
end;

function TTintadeMaquina.fGetOperador(intIndex: Integer): String;
begin
  Result := arrCampos[intIndex].strOperador;
end;


procedure TTintadeMaquina.pRestaurarPadrao;
  Var
    intCont: Integer;
begin
  For intCont := 0 To fGetQtdColunas - 1 Do
  Begin
    fSetVisivel(intCont, False);
  End;


  pSetQtdIndices(0);
end;

function TTintadeMaquina.fVendeItem(cdsConsulta: TUniClientDataSet;
  DropControl: TControl; RectLinhaGrid: TRect): Boolean;
var
  qryTinta: TUniQuery;
  calculadorFatVendasTAB: ICalculadorFatVendasTAB;
begin
  Result := False;
  Try
    Try
      qryTinta := fCriaQuery();

      If fRetornaPrecoTABSemExecutarConsulta(qryTinta, FDicionarioTab, True, True, 'S', cdsConsulta.FieldByName('AUTOINCREM').AsString, FstrLinhaWandaPro) Then
      Begin
        if not Supports(FDicionarioTab.RetornaObjeto('calculadorFatVendasTAB'), ICalculadorFatVendasTAB, calculadorFatVendasTAB) then
          calculadorFatVendasTAB := nil;

        If Assigned(calculadorFatVendasTAB) then
        Begin
          calculadorFatVendasTAB.pPreencheRetornoTintaDeMaquinaConsultaTAB(FDicionarioTab, qryTinta);
          calculadorFatVendasTAB.fVendeItemTinta(cdsConsulta, DropControl);
        End;
      End;
      Result := True;
    Except
      on E: Exception do
      begin
        fMensagem('Atenção',E.Message, ['&Ok']);
      end;
    End;
  Finally
    FreeAndNil(qryTinta);
  End;
end;

function TTintadeMaquina.fVerificaConfigurado: Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery();

  qryGen.SQL.Text := 'SELECT COUNT(*) QTD FROM CFGTIN WHERE CFG_CODEMP = :CODEMP AND CFG_IDEPRO = :IDEPRO AND CFG_GRUCFG = :GRUCFG';
  qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryGen.ParamByName('IDEPRO').AsString := strIdePro;
  qryGen.ParamByName('GRUCFG').AsString := 'ORDEM DOS CAMPOS';
  qryGen.Open;

  Result := qryGen.FieldByName('QTD').AsInteger > 0;

  If Result Then
  Begin
    qryGen.Close;
    qryGen.SQL.Text := 'SELECT COUNT(*) QTD FROM CFGTIN WHERE CFG_CODEMP = :CODEMP AND CFG_IDEPRO = :IDEPRO AND CFG_GRUCFG = :GRUCFG';
    qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryGen.ParamByName('IDEPRO').AsString := strIdePro;
    qryGen.ParamByName('GRUCFG').AsString := 'ORDEM DOS INDICES';
    qryGen.Open;

    Result := qryGen.FieldByName('QTD').AsInteger > 0;

    If Result Then
    Begin
      qryGen.Close;
      qryGen.SQL.Text := 'SELECT COUNT(*) QTD FROM CFGTIN WHERE CFG_CODEMP = :CODEMP AND CFG_IDEPRO = :IDEPRO AND CFG_GRUCFG = :GRUCFG';
      qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryGen.ParamByName('IDEPRO').AsString := strIdePro;
      qryGen.ParamByName('GRUCFG').AsString := 'ORDEM DA DESCRICAO';
      qryGen.Open;

      Result := qryGen.FieldByName('QTD').AsInteger > 0;
    End;
  End;

  FreeAndNil(qryGen);
end;

function TTintadeMaquina.fGetSelect(blnTodos: Boolean): String;
begin
  If Not fVerificaConfigurado Then
  Begin
    pRestaurarPadrao;
    pSalvarConfs;
  End;
  Result := Self.fGetCamposSelect(blnTodos);
  Result := Result + Self.fGetWhere;
  Result := Result + Self.fGetGroup;
end;

Procedure TTintadeMaquina.pGetSelectCxGrid(blnTodos: Boolean;
   Var arrSelect, arrNomCol: TArrString);
  Var
    intCont: Integer;
    strSql: String;
    stlNomCol: TStringList;
begin
  If Not fVerificaConfigurado Then
  Begin
    pRestaurarPadrao;
    pSalvarConfs;
  End;

  stlNomCol := TStringList.Create;

  strSql := '';
  strSql := strSql + ' SELECT SQL_NO_CACHE ' + fGetCampoAutoIncrem + ', ';

  stlNomCol.Add('AUTOINCREM');

  For intCont := 0 To fGetQtdColunas - 1 Do
  Begin
    If blnTodos Or (fGetdisponivel(intCont) And fGetVisivel(intCont)) Then
    Begin
      strSql := strSql + ' ' + fGetNomeCampoColuna(intCont) + ', ';
      stlNomCol.Add(fGetCaptionColuna(intCont));
    End;
  End;

  strSql := Copy(strSql, 1, LastDelimiter(',', strSql) - 1) + ' ';

  strSql := strSql + ' FROM ' + fGetNomeTabela + ' ';

  SetLength(arrSelect, 1);
  arrSelect[0] := strSql;

  SetLength(arrNomCol, stlNomCol.Count);
  For intCont := 0 To stlNomCol.Count - 1 Do
    arrNomCol[intCont] := stlNomCol[intCont];

  FreeAndNil(stlNomCol);
end;

function TTintadeMaquina.fGetCampoDescricao(intIndex: Integer): String;
begin
  Result := arrPrevia[intIndex];
end;

function TTintadeMaquina.fGetDesCampoDescricao(intIndex: Integer): String;
begin
  Result := fGetCaptionColuna(arrPrevia[intIndex]);
end;

function TTintadeMaquina.fGetQtdCamposDescricao: Integer;
begin
  Result := Length(arrPrevia);
end;

procedure TTintadeMaquina.pAdicionarCampoDescricao(strNomeCampo: String);
  Var
    intCont: Integer;
begin
  For intCont := 0 To Length(arrPrevia) - 1 Do
  Begin
    If fGetNomeCampo(strNomeCampo) = fGetNomeCampo(arrPrevia[intCont]) Then
      Exit;
  End;

  SetLength(arrPrevia, Length(arrPrevia) + 1);
  arrPrevia[Length(arrPrevia) - 1] := strNomeCampo;
end;

procedure TTintadeMaquina.pLimparDescricao;
begin
  SetLength(arrPrevia, 0);
end;

function TTintadeMaquina.fGetCampoAutoIncrem: String;
begin
  Result := strCampoAutoincrem;
end;

function TTintadeMaquina.fAtuallizarConfiguracaoCFGCON(CamposVisiveis, FiltrosVisiveis, ChaveCFGCON: string): boolean;
  var
    qryUpdate: TUniQuery;
    strAutoIncrem: String;
    blnInsert: boolean;
begin
  qryUpdate := fCriaQuery;
  Try
     //Tira os espaços entre as palavras;
    blnInsert:=  True;
    ChaveCFGCON := StringReplace(ChaveCFGCON, ' ', '', []);

    qryUpdate.SQL.Text := 'SELECT CFG_SEQGER FROM CFGEMP WHERE CFG_CODEMP = ' + VS_strCodEmp + ' AND CFG_CHAVE_ = "' + ChaveCFGCON + '"'  ;
    qryUpdate.Open;
    if qryUpdate.RecordCount > 0 Then
    Begin
      strAutoIncrem := qryUpdate.FieldByName('CFG_SEQGER').AsString;
      qryUpdate.SQL.Text := 'SELECT COUNT(1) FROM CFGCON WHERE AUTOINCREM = "' + strAutoIncrem + '"';
      qryUpdate.Open;
      If qryUpdate.RecordCount > 0 Then
        blnInsert:=  False;
    End;

    qryUpdate.SQL.Clear;
    If not blnInsert Then
    Begin
      qryUpdate.SQL.Add('UPDATE CFGCON SET');
      qryUpdate.SQL.Add('  CFG_PESQUI = :CFG_PESQUI,');
      qryUpdate.SQL.Add('  CFG_EXIBIR = :CFG_EXIBIR,');
      qryUpdate.SQL.Add('  CFG_COMKEY = "S",');
      qryUpdate.SQL.Add('  CFG_VALOR_ = ""    ');

      qryUpdate.SQL.Add(' WHERE AUTOINCREM = :AUTO');
      qryUpdate.ParamByName('AUTO').AsString := strAutoIncrem;

      qryUpdate.ParamByName('CFG_PESQUI').AsString := FiltrosVisiveis;
      qryUpdate.ParamByName('CFG_EXIBIR').AsString := CamposVisiveis;
      qryUpdate.ExecSQL;
    End
    Else
    Begin
      qryUpdate.SQL.Add('INSERT INTO CFGCON');
      qryUpdate.SQL.Add('(CFG_CHAVE_, CFG_COMKEY, CFG_PESQUI, CFG_EXIBIR, AUTOINCREM) VALUES');
      qryUpdate.SQL.Add('(:CFG_CHAVE_, "S", :CFG_PESQUI, :CFG_EXIBIR, :AUTOINCREM)');
      qryUpdate.ParamByName('CFG_CHAVE_').AsString :=  ChaveCFGCON ;
      qryUpdate.ParamByName('CFG_PESQUI').AsString := FiltrosVisiveis;
      qryUpdate.ParamByName('CFG_EXIBIR').AsString := CamposVisiveis;
      strAutoIncrem := fRetAutoIncrem('CFGCON', VS_strCodEmp);
      qryUpdate.ParamByName('AUTOINCREM').AsString := strAutoIncrem;
      qryUpdate.ExecSQL;
      qryUpdate.SQL.TEXT := 'INSERT INTO CFGEMP (CFG_SEQGER, CFG_CODEMP, CFG_CHAVE_) VALUES (:CFG_SEQGER, :CFG_CODEMP, :CFG_CHAVE_)';
      qryUpdate.ParamByName('CFG_CHAVE_').AsString :=  ChaveCFGCON ;
      qryUpdate.ParamByName('CFG_SEQGER').AsString := strAutoIncrem;
      qryUpdate.ParamByName('CFG_CODEMP').AsString :=  VS_strCodEmp ;
      qryUpdate.ExecSQL;
    End;
    Result := True;
  Finally
    FreeAndNil(qryUpdate);
  End;
end;

function TTintadeMaquina.fTemCampoVENDIDONaCFGCON(ChaveCFGCON: string): Boolean;
  var
    qryGen: TUniQuery;
begin
  Result := False;

  qryGen := fCriaQuery;
  Try
    ChaveCFGCON := StringReplace(ChaveCFGCON, ' ', '', []);

    qryGen.SQL.Text :=
       ' SELECT '+
       '   CFG_EXIBIR '+
       ' FROM '+
       '   CFGCON '+
       '   INNER JOIN CFGEMP ON CFGEMP.CFG_SEQGER = CFGCON.AUTOINCREM '+
       ' WHERE CFGEMP.CFG_CHAVE_ = "' + ChaveCFGCON + '"' +
       '   AND CFGEMP.CFG_CODEMP = "' + VS_strCodEmp + '"';
    qryGen.Open;

    If (Not qryGen.IsEmpty) Then
    Begin
      Result := Pos('VENDIDO', qryGen.Fields[0].AsString) > 0;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

{$IFNDEF LINUX}
function TTintadeMaquina.fExecutarConsulta(Sender: TForm; qryCad: TUniQuery;
  tipoConsulta: TTipoConsultaTinta; strTabPre: String;
  TfrmConsulta: TfrmPnlBotoesAcoesNovaConsultaClass; strLinhaWandaPro: string = '';
  blnFaturamento: Boolean = False; blnPermiteTab: Boolean = True;
  dicRetorno: TDicionario = Nil; sltItems: TStringList = Nil): String;
var
  stlCamInd, stlCamIndAux: TStringList;
  stlDesInd, stlDesIndAux: TStringList;
  stlSQLAjuste: TStringList;
  i: integer;
  arrSel: TConsultasArray;
  arrCampo: TArrString;
  strIndices: string;
  strFiltros: string;
  strColunasVisiveis: string;
  strSql, strTmp: string;
  objpnl: TPanelCxBotoesAcoesNovaConsulta;
  objConsulta: TDefConsulta;
  btnConfirmaVisivel: Boolean;

  strTabSelect,
  strTabGeral: String;

  calculadorFatVendasTAB: ICalculadorFatVendasTAB;
begin
  stlCamInd := nil;
  stlDesInd := nil;
  objConsulta := TDefConsulaItem.Create;
  strTabSelect := '';
  strTabGeral  := '';
  Try
    Try
      Result := '-1';

      btnConfirmaVisivel := TipoConsulta = tpcVenda;

      objpnl := TPanelCxBotoesAcoesNovaConsulta.Create(TfrmConsulta, TipoConsulta, Nil, Nil);
      objPnl.strTabPre := strTabPre;
      objPnl.strIdePro := strIdePro;
      objPnl.sltLista  := sltItems;

      If Assigned(objPnl) Then
        TDefConsulaItem(objConsulta).sltItems := objPnl.sltLista;

      FDicionarioTab := Nil;
      FDicionarioTab := dicRetorno;

      If blnFaturamento And blnPermiteTab And fTintaPossuiMD5KEY(strIdePro) Then
        objPnl.fncTeclaTab := fVendeItem;

      If Not Assigned(qryCad) Then
      Begin
        Exit;
      End;

      FstrLinhaWandaPro := strLinhaWandaPro;
      stlCamInd := TStringList.Create;
      stlDesInd := TStringList.Create;
      stlSQLAjuste := TStringList.Create;
      stlCamIndAux := TStringList.Create;
      stlDesIndAux := TStringList.Create;

      stlCamInd.Text := Self.fGetTodosCamposIndices;
      stlDesInd.Text := Self.fGetTodosDesCamposIndices;

      If fEmptyStr(stlCamInd.Text) And fEmptyStr(stlDesInd.Text) Then
      Begin
        fMensagem('Atenção','Favor configurar a tinta de máquina corretamente,' + #13#10 +
                            'os indices de pesquisa da tela de configurações,' + #13#10 +
                            'precisam ser preenchidos !', ['&Ok']);
        if Assigned(stlCamInd) then FreeAndNil(stlCamInd);
        if Assigned(stlDesInd) then FreeAndNil(stlDesInd);
        Exit;
      End;

      //Adiciona o campo TAB na consulta de tinta de maquina para poder vender
      //mais de uma tinta sem ter que voltar para o faturamento
      If blnFaturamento And Assigned(ObjPnl) And Assigned(ObjPnl.sltLista) And
         fTintaPossuiMD5KEY(strIdePro) Then
      Begin
        SetLength(arrCampo, Length(arrCampo)+ 1);
        arrCampo[Length(arrCampo) -1] := 'TAB';
      End;

      //Carregar o nome legivel dos campos
      For i := 0 To Self.fGetQtdColunas -1  Do
      Begin
        if fGetdisponivel(i) Then
        Begin
          SetLength(arrCampo, Length(arrCampo)+ 1);
          arrCampo[Length(arrCampo) -1] := Self.fGetCaptionColuna(i);
        End;
      End;

      // carrega todas as colunas visiveis;
      For i := 0 To Self.fGetQtdColunasVisiveis -1  Do
      Begin
        strTMP := Self.fGetNomeCampoColunaVisivel(i);
        {SE For WanPro}
        If strTMP = 'CAST(GROUP_CONCAT(DISTINCT WANPRO_CODUNI SEPARATOR ", ") AS CHAR(80)) AS WANPRO_CODUNI' Then
            strTmp := 'WANPROCODUNI1';

        If Pos('.', strTMP) > 0 Then
           strTMP := Copy(strTMP, Pos('.', strTMP) + 1, Length(strTMP));

        If (i = 0) And fTemCampoVENDIDONaCFGCON('ConsultaDinamica-' + Self.fGetNomeTinta) Then
          strTMP := 'VENDIDO, ' + strTMP;

        strColunasVisiveis := IfThen(i > 0, strColunasVisiveis + ', ' + strTMP, strTMP);
      End;

      stlCamInd.Text := AnsiReplaceStr(stlCamInd.Text, #$D#$A, '+');
      stlDesInd.Text := AnsiReplaceStr(stlDesInd.Text, #$D#$A, '+');
      stlDesInd.Text := AnsiReplaceStr(stlDesInd.Text, '/', '+');

      //Separa em linhas todos os indices "Filtros";
      If stlCamInd.Count > 0 Then
      Begin
        stlCamInd.StrictDelimiter := True;
        stlDesInd.StrictDelimiter := True;
        stlCamInd.Delimiter := '+';
        stlDesInd.Delimiter := '+';
        stlCamInd.DelimitedText := stlcamInd.Text;
        stlDesInd.DelimitedText := stlDesInd.Text;

      End;

      //Seleciona os filtros para não repetilos
      For i := 0 To stlCamInd.Count - 1 Do
      Begin
        strIndices := stlCamInd[i];
        {SE For WanPro}
        If stlCamInd[i] = 'WANPRO_CODUNI' Then
            strTmp := 'WANPROCODUNI1'
        {Verifica se o campo esta com alias, caso o tenha remove}

        Else  If Pos('.', strIndices) > 0 Then
           strTmp := Copy(strIndices, Pos('.', strIndices) + 1, Length(strIndices))
        else
           strTmp := strIndices;
        {Verifica se o Indice ainda não existe no filtro para poder adiciona-lo}
        If Pos(strTmp, strFiltros) = 0 Then
        Begin
          strFiltros := IfThen(length(strFiltros) > 0, strFiltros + ', ' + strTmp, strTmp);
          stlCamIndAux.Add(stlCamInd[i]);
          stlDesIndAux.Add(stlDesInd[i]);
        End;
      End;

      strSQL := Self.fGetCamposSelect(False);

      for i := 0 To stlCamIndAux.Count -  1 Do
      Begin
        //Localiza comandos sql como indice
        If (Pos('SUBSTR(', stlCamindAux[i]) > 0) Or (Pos('CAST(', stlCamindAux[i]) > 0) Then
        Begin
          //Ajusta as strings e adiciona como filtro
          stlDesindAux[i] := fRemoveAcento(stlDesindAux[i]);
          stlDesindAux[i] := StringReplace(stlDesindAux[i], ' ', '', []);
          strFiltros := StringReplace(strFiltros, stlCamindAux[i], stlDesindAux[i], []);
          strColunasVisiveis := StringReplace(strColunasVisiveis, stlCamindAux[i], stlDesindAux[i], []);
          strSQL := StringReplace(strSQL, stlCamindAux[i], stlDesindAux[i], []);
          objConsulta.pIncluiSubConsulta(stlDesIndAux[i], stlCamindAux[i]);
        End;
      End;

       //Ajuste dos campo visiveis que poder conter uma setenca SQL

      stlSQLAjuste.Text := strSQL;

      For i := 0 to stlSQLAjuste.Count -1 Do
      Begin
        If (Pos('SUBSTR(', stlSQLAjuste[i]) > 0) Or (Pos('CAST(', stlSQLAjuste[i]) > 0) Then
        Begin
          If not (Pos(', '+ stlCamindAux.Text, stlSQLAjuste[i]) > 0) Then
          Begin
            If stlSQLAjuste[i] = ',  CAST(GROUP_CONCAT(DISTINCT WANPRO_CODUNI SEPARATOR ", ") AS CHAR(80)) AS WANPRO_CODUNI' Then
            Begin
              strSQL := AnsiReplaceStr(strSQL, stlSQLAjuste[i], ', WANPROCODUNI1');
              objConsulta.pIncluiSubConsulta('WANPROCODUNI1', '(SELECT CAST(GROUP_CONCAT(DISTINCT WANPRO_CODUNI SEPARATOR ", ") AS CHAR(80)) FROM WANPRO_CADWAN AS WANPRO_CADWAN2 WHERE WANPRO_CADWAN.AUTOINCREM = WANPRO_CADWAN2.AUTOINCREM)');
            End
            Else
            Begin
              strTMP := stlSQLAjuste[i];
              strTMP := fRemoveAcento(strTMP);
              strTMP := AnsiReplaceStr(strTMP, ' ', '');
              strTMP := AnsiReplaceStr(strTMP, ')', '');
              strTMP := AnsiReplaceStr(strTMP, '(', '');
              strTMP := AnsiReplaceStr(strTMP, ',', '');
              strTMP := AnsiReplaceStr(strTMP, '+', '');
              strTMP := AnsiReplaceStr(strTMP, '-', '');
              strTMP := AnsiReplaceStr(strTMP, '/', '');
              strTMP := AnsiReplaceStr(strTMP, '*', '');

              strTMP := AnsiReplaceStr(strTMP, ' ', '');

              stlSQLAjuste[i] := Copy(stlSQLAjuste[i], 2, Length(stlSQLAjuste[i]) -1);

              strSQL := AnsiReplaceStr(strSQL, stlSQLAjuste[i], strTMP);

              strColunasVisiveis := AnsiReplaceStr(strColunasVisiveis, TrimLeft(stlSQLAjuste[i]), strTMP);

              objConsulta.pIncluiSubConsulta(strTMP, stlSQLAjuste[i]);
            End;
          End;
        End;
      End;

      If (Self.fGetNomeTinta = 'Farben Automotiva') Then
        objConsulta.pIncluiConflito('FAR_DESCRI', 'F.FAR_DESCRI');

      If blnFaturamento And Assigned(ObjPnl) And Assigned(ObjPnl.sltLista) And
         fTintaPossuiMD5KEY(strIdePro) Then
      Begin
        //Adicionando o campo TAB para venda continua de tinta de maquina

        strTabSelect := Copy(strSQL, 1, 7);
        strTabGeral  := Copy(strSQL, 8, Length(strSQL));

        strSQL := strTabSelect + ' VENDIDO, ';
        strSQL := strSQL + strTabGeral;

        objConsulta.pIncluiSubConsulta('VENDIDO', 'CAST(IF(LOCATE(' + fGetCampoMD5KEYTabelaTinta(strIdePro) + ', :LISTA) > 0, 1, NULL) AS UNSIGNED)');
        objConsulta.pIncluiIcone('VENDIDO', 0, 0);
        objConsulta.pIncluiIcone('VENDIDO', 1, 1);
      End;

      //Voltar configuração da cfgcon para a predefinida nas configurações de consulta do Autitin
      If fAtuallizarConfiguracaoCFGCON(strColunasVisiveis, strFiltros, 'ConsultaDinamica-' + Self.fGetNomeTinta) Then
      Begin
        If blnFaturamento Then
        Begin
          if not Supports(FDicionarioTab.RetornaObjeto('calculadorFatVendasTAB'), ICalculadorFatVendasTAB, calculadorFatVendasTAB) then
            calculadorFatVendasTAB := nil;

          //Consulta pelo faturamento tendo a possibilidade de utilizar o tab
          If Assigned(calculadorFatVendasTAB) then
          Begin
            //Consulta
            If calculadorFatVendasTAB.fConsultaTab([strSQL, Self.fGetWhere, Self.fGetGroup],
                                                    arrCampo,
                                                    [],
                                                    'AUTOINCREM',
                                                    Self.fGetNomeTabela,
                                                    'frmConsultaDinamica' + Self.fGetNomeTinta,
                                                    'Consulta Dinâmica - ' + Self.fGetNomeTinta,
                                                    qryCad,
                                                    ObjPnl,
                                                    True,
                                                    arrSel,
                                                    'AUTOINCREM',
                                                    objConsulta,False, False, '', nil, False, btnConfirmaVisivel, True) Then

            Result := qryCad.FieldByName(fGetNomeCampo(Self.fGetCampoAutoIncrem)).AsString;
          End;
        End
        Else
        Begin
          //Consulta
          If fConsulta([strSQL, Self.fGetWhere, Self.fGetGroup],
                        arrCampo,
                        [],
                        'AUTOINCREM',
                        Self.fGetNomeTabela,
                        'frmConsultaDinamica' + Self.fGetNomeTinta,
                        'Consulta Dinâmica - ' + Self.fGetNomeTinta,
                        qryCad,
                        ObjPnl,
                        True,
                        arrSel,
                        'AUTOINCREM',
                        objConsulta,False, False, '', nil, False, btnConfirmaVisivel, True) Then

            Result := qryCad.FieldByName(fGetNomeCampo(Self.fGetCampoAutoIncrem)).AsString;
        End;
      End;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(stlCamInd) then FreeAndNil(stlCamInd);
    if Assigned(stlDesInd) then FreeAndNil(stlDesInd);
    FreeAndNil(stlSQLAjuste);
    FreeAndNil(stlCamIndAux);
    FreeAndNil(stlDesIndAux);
    FreeAndNil(stlCamInd);
    FreeAndNil(stlDesInd);
    FreeAndNil(objConsulta);
    FreeAndNil(objpnl);
  End;
end;
{$ENDIF}

function TTintadeMaquina.fGetSelectAutoIncrem(strAutoIncrem: String): String;
var
  strResult: String;
  strGroup: String;
begin
  pRetornaSeSelectTemGroupBy(Self.fGetSelect(True),strResult,strGroup);

  if strGroup <> EmptyStr then
    Result := strResult + ' AND ' + Self.fGetCampoAutoIncrem + ' = ' + AnsiQuotedStr(strAutoIncrem, '"') + ' '+ strGroup
  else
    Result := Self.fGetSelect(True) + ' AND ' + Self.fGetCampoAutoIncrem + ' = ' + AnsiQuotedStr(strAutoIncrem, '"');
end;

{$IFNDEF LINUX}
function TTintadeMaquina.fExecutarConsultaCxGrid(Sender: TForm;
  qryCad: TUniQuery; tipoConsulta: TTipoConsultaTinta; strTabPre: String;
  TfrmConsulta: TfrmConsultaCompTintaNovaCxClass): String;
  Var
    arrSql,
    arrCampos,
    arrOrdenacao: TArrString;
    objfrmPnl: TPanelCxTintaNova;
    arrSelec: TConsultasArray;
begin
  SetLength(arrSelec, 0);
  pCarregaNre;
  pIniciaDllFuncoes(frmModulo.GetCurrentConnection,
                    strLoginUsuarioLogado,
                    VS_strCodEmp,
                    DebugHook,
                    TCfgSis.Create(),
                    VS_objTraceViewer,
                    VS_Date,
                    VS_ComputerNetName,
                    VS_UserFromWindows,
                    VS_IPAddressAsString,
                    VS_MacAddress);

  Result := '-1';

  If Not Assigned(qryCad) Then
  Begin
    Exit;
  End;

  arrOrdenacao := Self.fGetIndiceInicial;

  Self.pGetSelectCxGrid(False, arrSql, arrCampos);

  objfrmPnl := TPanelCxTintaNova.Create(TfrmConsulta, tipoConsulta, strTabPre);

  If fConsulta(arrSql,
               arrCampos,
               arrOrdenacao,
               fGetNomeCampo(Self.fGetCampoAutoIncrem),
               Self.fGetNomeTabela,
               Self.fGetNomeTinta,
               'Consulta ' + Self.fGetNomeTinta,
               qryCad,
               objfrmPnl,
               False,
               arrSelec) Then
  Begin

    If (Not qryCad.IsEmpty) Then
    Begin
      Result := qryCad.FieldByName(fGetNomeCampo(Self.fGetCampoAutoIncrem)).AsString;
    End;
  End;

  FreeAndNil(objfrmPnl);
end;
{$ENDIF}

procedure TTintadeMaquina.pRetornaSeSelectTemGroupBy(strSelect: String; Var strResult, strGroup: String);
Var
  intPos: Integer;
begin
  strGroup  := '';
  strResult := strSelect;

  if Pos('GROUP BY',strResult) > 0 then
  begin
    intPos    := Pos('GROUP BY',strResult);
    strGroup  := Copy(strResult,intPos,Length(strResult) - intPos);
    strResult := Copy(strResult,1,intPos - 1);
  end;
end;

function TTintadeMaquina.fGetSelectFrom: String;
begin
  Result := fGetNomeTabela;
end;

function TTintadeMaquina.fGetSelectMD5KEY(strMD5Key: String): String;
var
  strResult: String;
  strGroup: String;
begin
  If Not fTintaPossuiMD5KEY(strIdePro) Then
    Exit('');

  pRetornaSeSelectTemGroupBy(Self.fGetSelect(True),strResult,strGroup);

  if strGroup <> EmptyStr then
    Result := strResult + ' AND ' + fGetCampoMD5KEYTabelaTinta(strIdePro) + ' = ' + AnsiQuotedStr(strMD5Key, '"') + ' '+ strGroup
  else
    Result := Self.fGetSelect(True) + ' AND ' + fGetCampoMD5KEYTabelaTinta(strIdePro) + ' = ' + AnsiQuotedStr(strMD5Key, '"');
end;

{ TDefConsulaItem }
{$IFNDEF LINUX}
constructor TDefConsulaItem.Create;
begin
  Inherited Create;
end;

destructor TDefConsulaItem.Destroy;
begin

  inherited Destroy;
end;

procedure TDefConsulaItem.pParametriza(qryConsulta: TUniQuery);
begin
  If Assigned(sltItems) And (qryConsulta.Params.FindParam('LISTA') <> Nil) Then
    qryConsulta.ParamByName('LISTA').AsString := sltItems.CommaText;
end;
{$ENDIF}

end.

