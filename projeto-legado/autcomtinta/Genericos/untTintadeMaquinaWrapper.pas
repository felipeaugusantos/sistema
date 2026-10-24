{**********************************************************}
{* Classe responsável pelas consultas das dlls das tintas *}
{*******************************************************PH*}
unit untTintadeMaquinaWrapper;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  Forms, untFuncoesSimples, untConsultaCompWrapper,
  untPnlBotoesAcoesNovaConsulta,
  UniClientDataSet, Controls,
  untClassPanelCx,
{$ENDIF}
  untIConfiguradorConsulta, untTintadeMaquina, untITintadeMaquinaWrapper, System.AnsiStrings,
  untIDataSet,  SysUtils, Types,
  Classes, untIConsultaTinta, untIConsulta, Uni, Data.DB,
  untICalculadorFatVendasTAB, untIDicionario,
  untDicionarioWrapper, untTypesSistema;

type
  TTintadeMaquinaWrapper = class(TTintadeMaquina, IConfiguradorConsulta, IConsulta)
  private
    tintadeMaquinaWrapper: ITintadeMaquinaWrapper;
    FDicionarioTab: TDicionario;
    {$IFNDEF LINUX}
    class function fConsultaDinamicaInterna(const Sender: TForm;
      strTabPre: String; const tipoConsulta: TTipoConsultaTinta;
      const tintadeMaquinaWrapper: ITintadeMaquinaWrapper;
      blnFaturamento: Boolean; blnPermiteTab: Boolean;
      dicRetorno: IDicionario; sltItems: TStringList): String; stdcall;
    class function fRetornaPrecoTinta(): String;
    {$ENDIF}
    function fVendeItem(cdsConsulta: TUniClientDataSet; DropControl: TControl; RectLinhaGrid: TRect): Boolean;
  protected
    function fGetSelectFrom: String; override;
  public
    constructor Create(const tintadeMaquinaWrapper: ITintadeMaquinaWrapper); reintroduce;
    function fGetSelect(blnTodos: Boolean): String; override;
    procedure pRestaurarPadrao; override;
    function fGetNomeTinta: String; override;
    function fGetNomeForm: String; override;
    function GetCodIte: string;
    function fGetNomeTabela: String; override;
    function fGetWhere: String; override;
    function fGetGroup: String; override;
    function fGetCamposSelect(blnTodos: boolean): String; override;

  public
    {$IFNDEF LINUX}
    function fExecutarConsulta(Sender: TForm;
      tipoConsulta: TTipoConsultaTinta; strTabPre: String;
      TfrmConsulta: TConsultaCompWrapperClass; blnFaturamento: Boolean = False;
      blnPermiteTab: Boolean = True; dicRetorno: IDicionario = Nil; sltItems: TStringList = Nil): String; reintroduce;
    {$ENDIF}
  public
    {$IFNDEF LINUX}
    class function fConsultaDinamica(const Sender: TForm; const tintadeMaquinaWrapper: ITintadeMaquinaWrapper): String; stdcall;
    class function fConsultaDinamicaGeral(const Sender: TForm; const tintadeMaquinaWrapper: ITintadeMaquinaWrapper): String; stdcall;
    class function fConsultaDinamicaVenda(const Sender: TForm; strTabPre: String;
      const tintadeMaquinaWrapper: ITintadeMaquinaWrapper; blnFaturamento,
      blnPermiteTab: Boolean; dicRetorno: IDicionario; sltItems: TStringList): String; stdcall;
    {$ENDIF}
  End;

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
  untConsultas, untPanelCxBotoesAcoesNovaConsulta,
{$ENDIF}
  untUniQueryDataSetWrapper,
  untTintaMaquina, untTipoTinta;

{ TTintadeMaquinaWrapper }

constructor TTintadeMaquinaWrapper.Create(const tintadeMaquinaWrapper: ITintadeMaquinaWrapper);
begin
  inherited Create();
  Self.tintadeMaquinaWrapper := tintadeMaquinaWrapper;
  Self.tintadeMaquinaWrapper.Configurar(Self);
  Self.strIdePro := tintadeMaquinaWrapper.IdePro;
  Self.strCampoAutoincrem := tintadeMaquinaWrapper.CampoAutoIncrem;
  pAbrirTabelaConfs;
end;

{$IFNDEF LINUX}
class function TTintadeMaquinaWrapper.fConsultaDinamica(const Sender: TForm; const tintadeMaquinaWrapper: ITintadeMaquinaWrapper): String;
begin
  Try
    Try
//      Result := PAnsiChar(fConsultaDinamicaInterna(Sender,
      Result := fConsultaDinamicaInterna(Sender,
        fRetornaPrecoTinta,
        tpcGeral,
        tintadeMaquinaWrapper,
        False, False, Nil, Nil);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;
end;
{$ENDIF}

{$IFNDEF LINUX}
class function TTintadeMaquinaWrapper.fConsultaDinamicaGeral(const Sender: TForm;
  const tintadeMaquinaWrapper: ITintadeMaquinaWrapper): String;
var
  frmSender: TForm;
begin
  frmSender := nil;
  Try
    Try
      if not Assigned(Sender) then
      begin
        frmSender := TForm.Create(nil);
        frmSender.Name := 'TFrmTintadeMaquinaWrapper';

        Result := fConsultaDinamicaInterna(frmSender,
          fRetornaPrecoTinta,
          tpcGeral,
          tintadeMaquinaWrapper,
          False, False, Nil, Nil);
      end
      else
      begin
        Result := fConsultaDinamicaInterna(Sender,
          fRetornaPrecoTinta,
          tpcGeral,
          tintadeMaquinaWrapper,
          False, False, Nil, Nil);
      end;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(frmSender) then FreeAndNil(frmSender);
  End;
end;
{$ENDIF}

{$IFNDEF LINUX}
class function TTintadeMaquinaWrapper.fConsultaDinamicaInterna(const Sender: TForm; strTabPre: String;
  const tipoConsulta: TTipoConsultaTinta; const tintadeMaquinaWrapper: ITintadeMaquinaWrapper;
  blnFaturamento: Boolean; blnPermiteTab: Boolean; dicRetorno: IDicionario; sltItems: TStringList): String;
begin
  Result := (TTintadeMaquinaWrapper.Create(tintadeMaquinaWrapper)).fExecutarConsulta(Sender,
    tipoConsulta, strTabPre, TConsultaCompWrapper, blnFaturamento, blnPermiteTab, dicRetorno, sltItems);
end;
{$ENDIF}

{$IFNDEF LINUX}
class function TTintadeMaquinaWrapper.fConsultaDinamicaVenda(const Sender: TForm; strTabPre: String;
  const tintadeMaquinaWrapper: ITintadeMaquinaWrapper; blnFaturamento, blnPermiteTab: Boolean;
  dicRetorno: IDicionario; sltItems: TStringList): String;
begin
  Result := fConsultaDinamicaInterna(Sender,
    strTabPre,
    tpcVenda,
    tintadeMaquinaWrapper,
    blnFaturamento, blnPermiteTab, dicRetorno, sltItems);
end;
{$ENDIF}

{$IFNDEF LINUX}
function TTintadeMaquinaWrapper.fExecutarConsulta(Sender: TForm; tipoConsulta: TTipoConsultaTinta; strTabPre: String;
  TfrmConsulta: TConsultaCompWrapperClass; blnFaturamento: Boolean = False; blnPermiteTab: Boolean = True;
  dicRetorno: IDicionario = Nil; sltItems: TStringList = Nil): String;
var
  stlCamInd, stlCamIndAux: TStringList;
  stlDesInd, stlDesIndAux: TStringList;
  stlSQLAjuste: TStringList;
  i: integer;
  arrSel: TConsultasArray;
  arrCampo: TArrString;
  arrOrdenacao: TArrString;
  strIndices: string;
  strFiltros: string;
  strColunasVisiveis: string;
  strSql, strTmp: string;
  objpnl: TPanelCxBotoesAcoesNovaConsulta;
  objConsulta: TDefConsulta;
  qryCad: TUniQuery;
  btnConfirmaVisivel: Boolean;

  strTabSelect,
  strTabGeral: String;

  calculadorFatVendasTAB: ICalculadorFatVendasTAB;
begin
  {*******************************************************************}
  {* É NECESSARIO QUE ALTERE A EMPRESA DA DLL DE TINTA DE MAQUINA    *}
  {* PARA QUE CALCULE CORRETAMENTE OS SALDOS DE ACORDO COM A EMPRESA *}
  {* QUE IRA FATURAR O PRODUTO NA CONSULTA DE TINTAS IMOBILIARIAS    *}
  {***************************************************************RG**}

  If dicRetorno <> Nil Then
    pSetaEmpresaLogadaTinta(IIF(IfNull(dicRetorno['Cd_S_N'], '') = 'S', dicRetorno['emp_cd'], dicRetorno['codemp']));

  stlCamInd := nil;
  stlDesInd := nil;
  Try
    Try
      Result := '-1';

      btnConfirmaVisivel := TipoConsulta = tpcVenda;

      qryCad := fCriaQuery();
      objConsulta := TDefConsulaItem.Create;
      strTabSelect := '';
      strTabGeral  := '';

      If Not Assigned(qryCad) Then
      Begin
        Exit;
      End;

      objpnl := TPanelCxBotoesAcoesNovaConsulta.Create(TfrmPnlBotoesAcoesNovaConsultaClass(TfrmConsulta), TipoConsulta, IConsulta(Self), tintadeMaquinaWrapper.GetConsultaComp(strTabPre), dicRetorno);
      objPnl.strTabPre := strTabPre;
      objPnl.sltLista  := sltItems;

      If Assigned(objPnl) Then
        TDefConsulaItem(objConsulta).sltItems := objPnl.sltLista;

      FDicionarioTab := Nil;
      If Assigned(dicRetorno) Then
        FDicionarioTab := TDicionario(dicRetorno.RetornaDicionario);

      If blnFaturamento and blnPermiteTab Then
        objPnl.fncTeclaTab := fVendeItem;

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

      If blnFaturamento And Assigned(ObjPnl) And Assigned(ObjPnl.sltLista) Then
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

        If Pos('.', strTMP) > 0 Then
           strTMP := Copy(strTMP, Pos('.', strTMP) + 1, Length(strTMP));

        If (i = 0) And fTemCampoVENDIDONaCFGCON('ConsultaDinamica-' + Self.fGetNomeTinta) Then
          strTMP := 'VENDIDO, ' + strTMP;

        strColunasVisiveis := IIF(i > 0, strColunasVisiveis + ', ' + StrTMP, strTMP);
      End;

      stlCamInd.Text := string(AnsiReplaceStr(AnsiString(stlCamInd.Text), #$D#$A, '+'));
      stlDesInd.Text := string(AnsiReplaceStr(AnsiString(stlDesInd.Text), #$D#$A, '+'));
      stlDesInd.Text := string(AnsiReplaceStr(AnsiString(stlDesInd.Text), '/', '+'));
      stlDesInd.Text := string(AnsiReplaceStr(AnsiString(stlDesInd.Text), '\', '+'));

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
        {Verifica se o campo esta com alias, caso o tenha remove}
        If Pos('.', strIndices) > 0 Then
           strTmp := Copy(strIndices, Pos('.', strIndices) + 1, Length(strIndices))
        else
           strTmp := strIndices;
        {Verifica se o Indice ainda não existe no filtro para poder adiciona-lo}
        If Pos(strTmp, strFiltros) = 0 Then
        Begin
          strFiltros := iIF(length(strFiltros) > 0, strFiltros + ', ' + strTmp, strTmp);
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
      // Ajusta os campos com funções sql
       stlDesindAux.Clear;

      stlSQLAjuste.Text := strSQL;

      For i := 0 to stlSQLAjuste.Count -1 Do
      Begin
        If (Pos('SUBSTR(', stlSQLAjuste[i]) > 0) Or (Pos('CAST(', stlSQLAjuste[i]) > 0) Then
        Begin
          If not (Pos(', '+ stlCamindAux.Text, stlSQLAjuste[i]) > 0) And (Self.strIdePro <> 'WCP') Then
          Begin
            strTMP := stlSQLAjuste[i];
            strTMP := fRemoveAcento(strTMP);
            strTMP := String(AnsiReplaceStr(AnsiString(strTMP), ' ', ''));
            strTMP := String(AnsiReplaceStr(AnsiString(strTMP), ')', ''));
            strTMP := String(AnsiReplaceStr(AnsiString(strTMP), '(', ''));
            strTMP := String(AnsiReplaceStr(AnsiString(strTMP), ',', ''));
            strTMP := String(AnsiReplaceStr(AnsiString(strTMP), '+', ''));
            strTMP := String(AnsiReplaceStr(AnsiString(strTMP), '-', ''));
            strTMP := String(AnsiReplaceStr(AnsiString(strTMP), '/', ''));
            strTMP := String(AnsiReplaceStr(AnsiString(strTMP), '*', ''));

            strTMP := String(AnsiReplaceStr(AnsiString(strTMP), ' ', ''));

            stlSQLAjuste[i] := Copy(stlSQLAjuste[i], 2, Length(stlSQLAjuste[i]) -1);

            strSQL := StringReplace(strSQL, stlSQLAjuste[i], strTMP, []);

            strColunasVisiveis := StringReplace(strColunasVisiveis, TrimLeft(stlSQLAjuste[i]), strTMP, []);

            objConsulta.pIncluiSubConsulta(strTMP, stlSQLAjuste[i]);
          End;
        End
        Else If Pos('ITE_SALFIS', stlSQLAjuste[i]) > 0 Then
        Begin
          strSQL := StringReplace(strSQL, stlSQLAjuste[i], ', ITE_SALFIS', []);
          If (Not fCfgSis('BEFTRG', VarBoolean)) Or (fUsaQtdPendenteEntregaFutura(True)) Then
            objConsulta.pIncluiSubConsulta('ITE_SALFIS', 'IFNULL(ITEGER.ITE_SALDOS, 0) + IFNULL(ITEGER.ITE_SAL_ML, 0) / IF(IFNULL(ITE_CNV_ML, 0) <= 0, 1, ITE_CNV_ML) ' +
              '+ IFNULL(ITEGER.ITE_QTEF_F, 0) + IFNULL(ITEGER.ITE_QTEF_A, 0) + IFNULL(ITEGER.ITE_QTEF_P, 0) + IFNULL(ITEGER.ITE_QTPDBF, 0)', 'ITE_SALFIS')
          Else
            objConsulta.pIncluiSubConsulta('ITE_SALFIS', ' IFNULL(ITEGER.ITE_SALDOS, 0) + IFNULL(ITEGER.ITE_SAL_ML, 0) / IF(IFNULL(ITE_CNV_ML, 0) <= 0, 1, ITE_CNV_ML)', 'ITE_SALFIS');
        End
        Else If Pos('ITE_SALDIS', stlSQLAjuste[i]) > 0 Then
        Begin
          strSQL := StringReplace(strSQL, stlSQLAjuste[i], ', ITE_SALDIS', []);
          ObjConsulta.pIncluiSubConsulta('ITE_SALDIS', fSQLSaldoDisponivel('ITEGER', True));
        End;
      End;



      If  Self.fGetNomeTinta = 'Suvinil' Then
      Begin
        objConsulta.pIncluiConflito('SUV_DESCRI', ' S.SUV_DESCRI');
        objConsulta.pIncluiConflito('SUV_CODBAS', 'S.SUV_CODBAS');
        objConsulta.pIncluiConflito('SUV_CODFML', 'S.SUV_CODFML');

        SetLength(arrOrdenacao, Length(arrOrdenacao)+ 1);
        arrOrdenacao[Length(arrOrdenacao) -1] := 'SUV_NOMCOR';

        SetLength(arrOrdenacao, Length(arrOrdenacao)+ 1);
        arrOrdenacao[Length(arrOrdenacao) -1] := 'SUV_DESCRI';

        SetLength(arrOrdenacao, Length(arrOrdenacao)+ 1);
        arrOrdenacao[Length(arrOrdenacao) -1] := 'SUV_UNIDAD';
      End;

      If (fTipoTinta(Self.strIdePro) = ttImobiliaria) And
        (Pos(Self.strIdePro, 'SUV_BAU_SHE_CIA_QUA_DAC_ANJ_MEG_SPA_JOT_FAL_MZI_KIL_BEL_GRA_SHW_LKC_KRE_ALP_CLB_INT_') > 0) Then
        objConsulta.pIncluiConflito('ITE_CODITE', 'I.ITE_CODITE')
      Else If fTipoTinta(Self.strIdePro) = ttImobiliaria Then
        objConsulta.pIncluiConflito('ITE_CODITE', 'CADITE.ITE_CODITE');

      If blnFaturamento And Assigned(ObjPnl) And Assigned(ObjPnl.sltLista) Then
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
                                                    arrOrdenacao,
                                                    'AUTOINCREM',
                                                    Self.fGetNomeTabela,
                                                    'frmConsultaDinamica' + Self.fGetNomeTinta,
                                                    'Consulta Dinâmica - ' + Self.fGetNomeTinta,
                                                    qryCad,
                                                    objpnl,
                                                    True,
                                                    arrSel,
                                                    'AUTOINCREM',
                                                    objConsulta,False, False, '', nil, False, btnConfirmaVisivel, True) Then
            Result := qryCad.FieldByName(fGetNomeCampo(Self.fGetCampoAutoIncrem)).AsString;
          End
        End
        Else
        Begin
          //Consulta
          If fConsulta([strSQL, Self.fGetWhere, Self.fGetGroup],
                        arrCampo,
                        arrOrdenacao,
                        'AUTOINCREM',
                        Self.fGetNomeTabela,
                        'frmConsultaDinamica' + Self.fGetNomeForm,
                        'Consulta Dinâmica - ' + Self.fGetNomeTinta,
                        qryCad,
                        objpnl,
                        True,
                        arrSel,
                        'AUTOINCREM',
                        objConsulta,
                        False,
                        False,
                        '',
                        nil,
                        False,
                        btnConfirmaVisivel,
                        True,
                        Nil,
                        Nil,
                        Nil,
                        Nil) Then
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

function TTintadeMaquinaWrapper.fGetCamposSelect(blnTodos: boolean): String;
begin
  Result := tintadeMaquinaWrapper.fGetCamposSelect(blnTodos, Self);
end;

function TTintadeMaquinaWrapper.fGetGroup: String;
begin
  Result := tintadeMaquinaWrapper.fGetGroup;
end;

function TTintadeMaquinaWrapper.fGetNomeForm: String;
begin
  Result := tintadeMaquinaWrapper.GetNomeForm;
end;

function TTintadeMaquinaWrapper.fGetNomeTabela: String;
begin
  Result := tintadeMaquinaWrapper.GetNomeTabela;
end;

function TTintadeMaquinaWrapper.fGetNomeTinta: String;
begin
  Result := tintadeMaquinaWrapper.NomeTinta;
end;

function TTintadeMaquinaWrapper.fGetSelect(blnTodos: Boolean): String;
begin
  Result := tintadeMaquinaWrapper.fGetSelect(blnTodos, Self);
end;

function TTintadeMaquinaWrapper.fGetSelectFrom: String;
begin
  Result := tintadeMaquinaWrapper.fGetSelectFrom(Self);
end;

function TTintadeMaquinaWrapper.fGetWhere: String;
begin
  Result := tintadeMaquinaWrapper.fGetWhere;
end;

{$IFNDEF LINUX}
class function TTintadeMaquinaWrapper.fRetornaPrecoTinta: String;
begin
  If fCfgSis('PREGER') = '0' Then
    Result := '1'
  Else If fCfgSis('PREGER') = '1' Then
    Result := fCfgSis('TABPRE')
  Else
    Result := IfNull(fCfgSis('TABPAD'), '1');
end;
{$ENDIF}

function TTintadeMaquinaWrapper.fVendeItem(cdsConsulta: TUniClientDataSet;
  DropControl: TControl; RectLinhaGrid: TRect): Boolean;
var
  qryTinta: TUniQuery;
  calculadorFatVendasTAB: ICalculadorFatVendasTAB;
begin
  Result := False;
  Try
    Try
      qryTinta := fCriaQuery();

      If fRetornaPrecoTABSemExecutarConsulta(qryTinta, FDicionarioTab, True, True, 'S', cdsConsulta.FieldByName('AUTOINCREM').AsString) Then
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

function TTintadeMaquinaWrapper.GetCodIte: string;
begin
  Result := strCodIte;
end;



{function TTintadeMaquinaWrapper.pConsultaEspecifica(arrSql,
                     arrCampos,
                     arrOrdenacao: Array Of String;
                     strCampoChave,
                     strTabela,
                     strNomForm,
                     strTitulo: String;
                     var qryConsulta: TUniQuery;
  var
    Key: Char;
begin
  Key := '/';
  Result := False;
  Try
    Try
      If Not Assigned(qryConsulta) Then
        qryConsulta := fCriaQuery();

      Result := fConsulta(arrSql,
                         arrCampos,
                         arrOrdenacao,
                         strCampoChave,
                         strTabela,
                         strNomForm,
                         strTitulo,
                         qryConsulta);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
  End;
end;}

procedure TTintadeMaquinaWrapper.pRestaurarPadrao;
begin
  Inherited pRestaurarPadrao;
  pLimparDescricao;
  tintadeMaquinaWrapper.pRestaurarPadrao(Self);
end;

{ TDefConsulaItem }

{$IFNDEF LINUX}
constructor TDefConsulaItem.Create;
begin
  Inherited Create;
end;
{$ENDIF}

{$IFNDEF LINUX}
destructor TDefConsulaItem.Destroy;
begin

  inherited Destroy;
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TDefConsulaItem.pParametriza(qryConsulta: TUniQuery);
begin
  If Assigned(sltItems) And (qryConsulta.Params.FindParam('LISTA') <> Nil) Then
      qryConsulta.ParamByName('LISTA').AsString := sltItems.CommaText;
end;
{$ENDIF}

end.

